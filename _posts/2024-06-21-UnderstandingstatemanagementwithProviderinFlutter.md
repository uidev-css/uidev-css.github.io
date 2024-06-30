---
title: "Flutter에서 Provider로 상태 관리 이해하기"
description: ""
coverImage: "/assets/img/2024-06-21-UnderstandingstatemanagementwithProviderinFlutter_0.png"
date: 2024-06-21 23:43
ogImage:
  url: /assets/img/2024-06-21-UnderstandingstatemanagementwithProviderinFlutter_0.png
tag: Tech
originalTitle: "Understanding state management with Provider in Flutter"
link: "https://medium.com/@nureddineraslan/understanding-state-management-with-provider-in-flut-e74e0b9e49d9"
---

<img src="/assets/img/2024-06-21-UnderstandingstatemanagementwithProviderinFlutter_0.png" />

플러터에서 "provider"는 애플리케이션 내에서 상태 관리와 데이터 공유에 사용되는 인기 있는 패키지입니다. Provider를 사용하면 애플리케이션의 다양한 구성 요소(위젯) 간에 데이터를 공유하고 업데이트할 수 있습니다. 이를 통해 상태 관리를 간단히 처리하고 전통적인 상태 관리 기술을 사용하지 않고 위젯 트리에서 데이터 변경을 추적하고 업데이트할 수 있습니다.

Provider 개념을 이해하기 위해 몇 가지 주요 개념을 살펴보겠습니다:

- Provider: Provider는 데이터 소스를 제공하고 애플리케이션 내에서 데이터에 액세스할 수 있도록 지원하는 패키지입니다. 데이터 프로바이더를 생성할 때 일반적으로 ChangeNotifier 클래스를 사용합니다. 이 클래스는 가변 상태를 나타내며 그 내부 데이터가 변경될 때 청취자들에게 알립니다.
- Consumer: Consumer 위젯은 데이터 프로바이더의 값을 액세스하고 해당 변경 사항을 추적하는 데 사용됩니다. 데이터 프로바이더의 위젯 트리 내에 있으며 관련 데이터에 기초하여 스스로 다시 구축됩니다. 다시 말하면 데이터가 변경될 때 자동으로 업데이트됩니다.
- Provider.of(): 이 메소드를 사용하면 위젯 트리 내에서 가장 가까운 데이터 프로바이더에 액세스할 수 있습니다. 이를 통해 관련 데이터를 검색하고 업데이트를 추적할 수 있습니다.
- ChangeNotifier: 이 클래스는 데이터 프로바이더의 기반이 됩니다. ChangeNotifier 클래스를 확장한 클래스를 생성함으로써 가변 상태를 나타낼 수 있습니다. 데이터가 변경될 때 notifyListeners() 메소드를 호출하여 청취자에게 알릴 수 있습니다.

<div class="content-ad"></div>

이제 제공자 개념을 사용하여 데이터 공유를 구현하는 방법을 살펴보겠습니다:

- 먼저 데이터 제공자 클래스를 만들고 ChangeNotifier 클래스에서 확장합니다.

```js
import 'package:flutter/foundation.dart';

class CounterProvider with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}
```

다음으로, 응용 프로그램 위젯 트리의 최상위에 MultiProvider를 생성하고 생성한 데이터 제공자를 추가합니다.

<div class="content-ad"></div>

```js
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CounterProvider()),
      ],
      child: MyApp(),
    ),
  );
}
```

이제 Consumer 위젯을 사용하여 모든 위젯에서 데이터에 액세스할 수 있습니다.

```js
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CounterProvider>(
      builder: (context, counterProvider, child) {
        return Text(
          'Count: ${counterProvider.count}',
          style: TextStyle(fontSize: 24),
        );
      },
    );
  }
}
```

위의 예에서는 CounterProvider 클래스 내의 count 변수에 액세스하여 업데이트가 발생할 때마다 위젯을 자동으로 다시 빌드합니다.

<div class="content-ad"></div>

Provider 패키지를 사용하면 Flutter 애플리케이션에서 데이터 공유를 쉽게 구현할 수 있어요. 위젯 간 데이터 통신과 업데이트가 간단해지며, 애플리케이션 전체 성능이 향상될 거예요.

우선, pubspec.yaml 파일에 provider 패키지를 추가했는지 확인해주세요.

그런 다음, 다음 코드를 main.dart 파일로 사용할 수 있어요:

```js
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 단계 1: 데이터 제공자 클래스 생성
class CounterProvider with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

void main() {
  runApp(
    // 단계 2: 앱을 MultiProvider로 래핑
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CounterProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 단계 3: Consumer 위젯을 사용하여 데이터에 액세스
    return Consumer<CounterProvider>(
      builder: (context, counterProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Counter App'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Count:',
                  style: TextStyle(fontSize: 24),
                ),
                Text(
                  '${counterProvider.count}',
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // 단계 4: 상태 업데이트 트리거
              counterProvider.increment();
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
```

<div class="content-ad"></div>

이 예시에서는 ChangeNotifier를 확장하는 CounterProvider 클래스를 생성합니다. 이 클래스는 카운트 변수를 관리하고 증가시키는 메서드를 제공합니다. HomePage 위젯은 Consumer 위젯을 사용하여 카운트 값을 액세스하고 화면에 표시합니다. FloatingActionButton을 누르면 프로바이더의 increment 메서드가 트리거되어 카운트를 업데이트하고 UI를 다시 빌드하도록 알립니다.

이 앱을 실행하면 카운트가 표시된 화면이 표시되며 FloatingActionButton을 탭할 때마다 카운트가 증가하고 화면에 변경 내용이 반영됩니다.

이것은 플러터 앱에서 상태 관리를 위해 provider 패키지를 사용하는 방법의 기본 예시입니다. 이 개념을 확장하여 더 복잡한 데이터를 관리하고 응용 프로그램 전체에서 상태 변경을 처리할 수 있습니다.
