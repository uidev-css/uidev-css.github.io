---
title: "Flutter에서 InheritedWidget 사용하기 간단한 카운터 예제"
description: ""
coverImage: "/assets/img/2024-06-21-UsingInheritedWidgetinFlutterASimpleCounterExample_0.png"
date: 2024-06-21 21:03
ogImage:
  url: /assets/img/2024-06-21-UsingInheritedWidgetinFlutterASimpleCounterExample_0.png
tag: Tech
originalTitle: "Using InheritedWidget in Flutter: A Simple Counter Example"
link: "https://medium.com/@subhashchandrashukla/using-inheritedwidget-in-flutter-a-simple-counter-example-3eb0d03ca936"
---

![사진](/assets/img/2024-06-21-UsingInheritedWidgetinFlutterASimpleCounterExample_0.png)

플러터에서 상태를 관리하는 것은 어렵지만, 특히 여러 위젯 간에 데이터를 공유해야 할 때 더 어려울 수 있습니다. InheritedWidget은 이 문제를 해결하는 데 도움이 되는 플러터의 강력한 기능으로, 위젯이 공유된 데이터에 효율적으로 액세스할 수 있도록 합니다. 이 글에서는 간단한 카운터 예제와 함께 InheritedWidget을 어떻게 사용하는지 살펴보겠습니다.

단계 1: Inherited Widget 생성

먼저, AppState라는 InheritedWidget을 만들겠습니다. 이 위젯은 공유 상태(이 경우 카운터)를 보유하고 이를 하위 항목에 제공할 것입니다.

<div class="content-ad"></div>

```js
import 'package:flutter/material.dart';

class AppState extends InheritedWidget {
  final int counter;
  final Widget child;

  AppState({
    required this.counter,
    required this.child,
  }) : super(child: child);

  static AppState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppState>();
  }

  @override
  bool updateShouldNotify(AppState oldWidget) {
    return oldWidget.counter != counter;
  }
}
```

AppState 클래스에서:

- counter와 child를 초기화하는 생성자를 정의합니다.
- of 메서드는 하위 위젯이 AppState에 액세스할 수 있도록 합니다.
- updateShouldNotify 메서드는 하위 항목에 변경 사항을 알리는 시점을 결정합니다.

단계 2: State를 관리하는 StatefulWidget 생성

<div class="content-ad"></div>

다음으로 상태를 관리하는 StatefulWidget 인 MyApp을 만들겠습니다. 이 위젯은 상태를 업데이트하고 필요할 때 다시 빌드를 트리거할 것입니다.

```js
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppState(
      counter: _counter,
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Inherited Widget demo'),
          ),
          body: CounterDisplay(),
          floatingActionButton: FloatingActionButton(
            onPressed: _incrementCounter,
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
```

단계 3: Inherited Widget을 사용하는 위젯 생성

마지막으로, 우리는 InheritedWidget을 사용하여 카운터 값을 액세스하고 표시하는 CounterDisplay라는 StatelessWidget을 만들 것입니다.

<div class="content-ad"></div>

```js
class CounterDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = AppState.of(context);

    return Center(
      child: Text(
        'Counter: ${appState?.counter}',
        style: TextStyle(fontSize: 22),
      ),
    );
  }
}
```

CounterDisplay 클래스에서:

- AppState를 액세스하고 카운터 값을 검색하려면 of 메서드를 사용합니다.
- Text 위젯에 카운터 값을 표시합니다.

이 코드를 실행해 봅시다.

<div class="content-ad"></div>

앱을 실행하려면 MyApp을 인수로 사용하여 runApp 함수를 호출하겠습니다.

```js
void main() => runApp(MyApp());
```
