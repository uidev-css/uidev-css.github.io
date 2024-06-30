---
title: "Flutter에서 Bloc을 사용한 상태 관리 마스터하기 종합 가이드"
description: ""
coverImage: "/assets/img/2024-06-21-MasteringStateManagementinFlutterwithBlocAComprehensiveGuide_0.png"
date: 2024-06-21 22:13
ogImage:
  url: /assets/img/2024-06-21-MasteringStateManagementinFlutterwithBlocAComprehensiveGuide_0.png
tag: Tech
originalTitle: "Mastering State Management in Flutter with Bloc: A Comprehensive Guide"
link: "https://medium.com/@dihsar/mastering-state-management-in-flutter-with-bloc-a-comprehensive-guide-1d03319ba7df"
---

소개

상태 관리는 견고하고 유지보수가 용이한 플러터 애플리케이션을 구축하는 중요한 측면입니다. 플러터는 다양한 상태 관리 옵션을 제공하며, 상태를 관리하는 가장 인기 있는 강력한 라이브러리 중 하나인 flutter_bloc 패키지가 있습니다. 이 포괄적인 가이드에서는 Bloc를 사용한 상태 관리의 기본 개념을 탐색하고 시작하는 데 도움이 되는 자세한 예제를 제공합니다.

![마스터링 플러터 Bloc를 이용한 상태 관리: 포괄적인 가이드](/assets/img/2024-06-21-MasteringStateManagementinFlutterwithBlocAComprehensiveGuide_0.png)

# 플러터 Bloc이란 무엇인가요?

<div class="content-ad"></div>

flutter_bloc은 Flutter 애플리케이션의 상태를 관리하기 위해 BLoC (Business Logic Component) 패턴을 활용하는 라이브러리입니다. 이는 데이터 및 이벤트의 흐름을 처리하는 구조화된 방법을 제공하여 코드베이스를 더 조직화하고 유지보수하기 쉽게 만들어줍니다. Bloc은 프리젠테이션 레이어를 비즈니스 로직에서 분리함으로써 깨끗하고 확장 가능한 아키텍처를 장려합니다.

# Flutter 프로젝트 설정하기

예제에 들어가기 전에 새로운 Flutter 프로젝트를 설정하고 flutter_bloc 패키지를 종속성으로 추가해 봅시다. 이를 위해 다음 단계를 따라주세요:

- 다음 명령어를 사용하여 새로운 Flutter 프로젝트를 생성합니다:

<div class="content-ad"></div>

```js
flutter create my_bloc_app
```

2. 즐겨 사용하는 코드 편집기에서 프로젝트를 엽니다.

3. pubspec.yaml 파일에 flutter_bloc를 추가하세요:

```js
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^7.0.0
```

<div class="content-ad"></div>

4. 의존성을 가져와 설치하려면 `flutter pub get`을 실행하세요.

# 카운터 앱 예제

이제 Bloc을 사용하여 카운터의 상태를 관리하는 간단한 Flutter 앱을 만들어 보겠습니다. 이 예제에서는 Bloc을 설정하는 방법, 이벤트와 상태를 만드는 방법 및 BlocProvider를 만드는 방법을 보여줍니다.

# 1. Bloc 만들기

<div class="content-ad"></div>

프로젝트에서 Bloc을 위한 새 Dart 파일을 만드세요. counter_bloc.dart라고 이름 짓겠어요.

```js
import 'package:flutter_bloc/flutter_bloc.dart';

// 이벤트
abstract class CounterEvent {}

class IncrementEvent extends CounterEvent {}

class DecrementEvent extends CounterEvent {}

// 상태
abstract class CounterState {}

class InitialState extends CounterState {}

class UpdatedState extends CounterState {
  final int count;

  UpdatedState(this.count);
}

// Bloc
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(InitialState());

  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    if (event is IncrementEvent) {
      yield UpdatedState(state is UpdatedState ? (state as UpdatedState).count + 1 : 1);
    } else if (event is DecrementEvent) {
      yield UpdatedState(state is UpdatedState ? (state as UpdatedState).count - 1 : -1);
    }
  }
}
```

# 2. UI 만들기

이제 카운터 앱을 위한 간단한 UI를 만들어보세요. main.dart 파일에서 만들어보세요.

<div class="content-ad"></div>

```js
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => CounterBloc(),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Bloc Counter'),
      ),
      body: BlocBuilder<CounterBloc, CounterState>(
        builder: (context, state) {
          if (state is UpdatedState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Counter Value:',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    '${state.count}',
                    style: TextStyle(fontSize: 50),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FloatingActionButton(
                        onPressed: () => counterBloc.add(IncrementEvent()),
                        child: Icon(Icons.add),
                      ),
                      SizedBox(width: 20),
                      FloatingActionButton(
                        onPressed: () => counterBloc.add(DecrementEvent()),
                        child: Icon(Icons.remove),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
```

# 3. 앱 실행하기

이제 다음을 실행하여 Flutter 앱을 실행할 수 있습니다:

```js
flutter run
```

<div class="content-ad"></div>

간단한 카운터 앱이 표시되어야 합니다. '증가' 및 '감소' 버튼이 있습니다. 앱의 상태는 CounterBloc을 사용하여 관리되며, UI는 상태 변경에 따라 업데이트됩니다.

# 결론

이 가이드에서는 flutter_bloc 패키지를 사용하여 Flutter에서 상태 관리의 기본을 탐구했습니다. Bloc를 설정하는 방법, 이벤트 및 상태를 생성하는 방법, 및 UI와 Bloc을 통합하는 방법을 보여주기 위해 간단한 카운터 앱을 만들었습니다.

Flutter Bloc은 Flutter 애플리케이션에서 상태를 관리하는 강력한 도구이며, 프로젝트가 성장함에 따라 더 복잡한 시나리오에도 적용할 수 있습니다. BLoC 패턴을 따르고 비즈니스 로직을 UI와 분리함으로써 유지 관리 가능하고 확장 가능한 Flutter 앱을 구축할 수 있습니다.

<div class="content-ad"></div>

이 안내서가 플러터 Bloc을 시작하고 플러터 프로젝트에서 더 복잡한 상태 관리를 위한 기초를 제공하는 데 도움이 되기를 바랍니다. 즐거운 코딩 되세요!
