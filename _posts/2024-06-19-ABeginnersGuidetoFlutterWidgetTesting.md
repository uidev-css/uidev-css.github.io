---
title: "플러터 위젯 테스팅 초보자 가이드"
description: ""
coverImage: "/assets/img/2024-06-19-ABeginnersGuidetoFlutterWidgetTesting_0.png"
date: 2024-06-19 08:15
ogImage:
  url: /assets/img/2024-06-19-ABeginnersGuidetoFlutterWidgetTesting_0.png
tag: Tech
originalTitle: "A Beginner’s Guide to Flutter Widget Testing"
link: "https://medium.com/@sharansukesh2000/a-beginners-guide-to-flutter-widget-testing-f7e3cf5b61c4"
---

플러터를 사용해오신 분이라면, 앱이 완벽하고 원활한 사용자 경험을 제공하는 것이 얼마나 중요한지 알고 계실 것입니다. 위젯 테스팅은 이를 달성하는 데 가장 좋은 방법 중 하나입니다. 이 블로그 포스트에서는 플러터 위젯 테스팅의 기본 사항을 다루고 유용한 예제를 제공하여 여러분을 도와드리겠습니다.

![이미지](/assets/img/2024-06-19-ABeginnersGuidetoFlutterWidgetTesting_0.png)

# 위젯 테스팅이란?

사용자 인터페이스(UI) 구성 요소가 의도한 대로 작동하는지 확인하는 테스팅 방법입니다. 이는 통합 테스팅과 단위 테스팅 사이에 위치하여 사용자 인터페이스와 상호 작용하는 방식을 확인할 수 있도록 합니다. 이를 통해 UI가 다양한 시나리오에서 올바르게 작동하고 오류를 조기에 발견하는 데 도움이 됩니다.

<div class="content-ad"></div>

# 위젯 테스트하는 이유

- 버그 조기 발견: 제품 출시 전에 문제를 식별할 수 있습니다.
- 자신 있게 리팩터링: 코드베이스를 수정할 때 이미 존재하는 기능에 영향을 미칠 걱정 없이 변경할 수 있습니다.
- UI 테스트 자동화: 시간이 오래 걸리는 UI 검사를 자동화하여 시간을 절약할 수 있습니다.

# 플러터 프로젝트의 테스트 예제

위젯 테스트에 들어가기 전에, 플러터 프로젝트가 준비되었는지 확인해봅시다.

<div class="content-ad"></div>

의존성 확인: pubspec.yaml 파일을 열어 다음 의존성이 있는지 확인하십시오:

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
```

# 첫 번째 위젯 테스트 작성

위젯에 대한 기본 테스트를 작성해 봅시다. 사용자가 할 일 목록 앱(TodoApp)을 가정하고 사용자가 목록에 작업을 추가할 수 있는 앱이라고 합시다.

<div class="content-ad"></div>

# 단계 1: 위젯 생성하기

먼저 테스트용 데모 위젯을 생성해보세요. 이 경우에는 TodoApp 위젯입니다.

```js
import 'package:flutter/material.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  TodoScreenState createState() => TodoScreenState();
}

class TodoScreenState extends State<TodoScreen> {
  final List<String> _todos = [];
  final TextEditingController _controller = TextEditingController();

  void _addTodo() {
    setState(() {
      _todos.add(_controller.text);
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo App')),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter a task',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _addTodo,
            child: const Text('Add Task'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_todos[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
```

# 단계 2: 샘플 테스트 작성하기

<div class="content-ad"></div>

다음의 테스트 코드를 추가하여 test 디렉토리에 todo_test.dart 파일을 생성해주세요:

```js
// 파일 구조에 맞게 import 수정해주세요.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widget_testing/main.dart';

void main() {
  testWidgets('할 일 목록 테스트', (WidgetTester tester) async {
    // 데모 앱을 빌드하고 프레임을 트리거합니다.
    await tester.pumpWidget(const TodoApp());

    // 앱이 빈 목록으로 시작하는지 확인합니다.
    expect(find.byType(ListTile), findsNothing);

    // 텍스트 필드에 할 일을 입력합니다.
    await tester.enterText(find.byType(TextField), '우유 사기');
    await tester.tap(find.text('할 일 추가'));
    await tester.pump();

    // 할 일이 추가되었는지 확인합니다.
    expect(find.text('우유 사기'), findsOneWidget);
    expect(find.byType(ListTile), findsOneWidget);
  });
}
```

# 단계 3: 테스트 실행

다음 명령어로 테스트를 실행해주세요:

<div class="content-ad"></div>

```js
flutter test
```

위 명령어를 실행하면 테스트가 성공했음을 나타내는 출력이 표시됩니다.

# 테스트 코드 이해

테스트 코드를 살펴보겠습니다:

<div class="content-ad"></div>

- 위젯 빌드: await tester.pumpWidget(TodoApp());을 사용하여 TodoApp 위젯을 빌드하고 프레임을 트리거합니다.
- 초기 상태 확인: expect(find.byType(ListTile), findsNothing);을 사용하여 목록이 처음에 비어 있는지 확인합니다.
- 사용자 상호작용 시뮬레이션: await tester.enterText(find.byType(TextField), `Learn Flutter`);을 사용하여 텍스트 필드에 텍스트를 입력하는 것을 시뮬레이션합니다. await tester.tap(find.text(`Add Task`));을 사용하여 `Add Task` 버튼을 탭하는 것을 시뮬레이션합니다.
- 위젯 다시 빌드: await tester.pump();을 사용하여 업데이트된 상태로 위젯을 다시 빌드하는 또 다른 프레임을 트리거합니다.
- 최종 상태 확인: 작업이 목록에 추가되었는지 확인합니다.

# 고급 위젯 테스트

# 비동기 작업 테스트

위젯에 비동기 작업(예: 네트워크 요청)이 포함되어 있는 경우 pumpAndSettle을 사용하여 모든 애니메이션 및 예약된 프레임이 완료될 때까지 기다릴 수 있습니다.

<div class="content-ad"></div>

```js
await tester.pumpAndSettle();
```

# 위젯 찾기

다양한 방법을 사용하여 위젯을 찾을 수 있습니다:

- find.byType(Type): 타입으로 위젯 찾기.
- find.byKey(ValueKey): Key로 위젯 찾기.
- find.text(String): 특정 텍스트를 포함한 위젯 찾기.

<div class="content-ad"></div>

# 모의 의존성

외부 종속성에 의존하는 위젯의 동작을 흉내 내기 위해 모의 객체를 사용하세요. 모의 객체를 생성하기 위해 mockito와 같은 패키지를 활용할 수 있습니다.

# 결론

Flutter 테스트 도구상 가장 유용한 도구 중 하나는 위젯 테스트입니다. 사용자 인터페이스(UI)가 의도한 대로 작동하는지 확인하고, 오류를 초기에 발견하며, 위젯 테스트를 작성하여 자신감을 가지고 코드를 리팩터링할 수 있습니다. 먼저 사용자 인터페이스(UI)의 필수 구성 요소에 대한 테스트를 작성한 후, 더 복잡한 상호 작용으로 넘어가세요.

<div class="content-ad"></div>

화이팅해서 테스트를 진행해보세요🧪! 문제가 있으시면 댓글란에 자유롭게 질문해주시고, 이 게시물이 마음에 드시면 👏좋아요를 눌러주시고 더 많은 훌륭한 컨텐츠를 받아보세요!
