---
title: "플러터 앱 라이프사이클 이해하기 단계별 안내"
description: ""
coverImage: "/assets/img/2024-06-19-UnderstandingFlutterAppLifecycleAStep-by-StepGuide_0.png"
date: 2024-06-19 14:29
ogImage: 
  url: /assets/img/2024-06-19-UnderstandingFlutterAppLifecycleAStep-by-StepGuide_0.png
tag: Tech
originalTitle: "Understanding Flutter App Lifecycle: A Step-by-Step Guide"
link: "https://medium.com/@sharansukesh2000/understanding-flutter-app-lifecycle-a-step-by-step-guide-89676251ac84"
---


# 소개

Flutter 애플리케이션의 수명주기를 이해하는 것은 효과적인 앱 개발에 중요합니다. 이 포관적인 안내서에서는 앱의 다양한 수명주기 상태를 모니터링하고 표시하는 방법을 보여주는 Flutter 코드 스니펫을 살펴보겠습니다. 코드를 분석하고 설명을 제공하며 각 단계를 안내하는 과정을 함께 따라와 주세요.

# Flutter 앱 수명 주기

![이미지](/assets/img/2024-06-19-UnderstandingFlutterAppLifecycleAStep-by-StepGuide_0.png)

<div class="content-ad"></div>

# 스크린샷

![UnderstandingFlutterAppLifecycleAStep-by-StepGuide_1](/assets/img/2024-06-19-UnderstandingFlutterAppLifecycleAStep-by-StepGuide_1.png)

# Flutter 앱 라이프사이클 상태

- resumed: 앱이 전경으로 돌아왔고 사용자와 상호 작용할 준비가 되어 있는 상태입니다. 일시 중지되거나 비활성 상태에서 전환됩니다.
- inactive: 앱이 비활성 상태이며 일반적으로 전경과 배경 사이를 전환 중인 상태입니다. 이 상태에서는 사용자 상호 작용이 처리되지 않습니다.
- hidden: 앱이 숨겨진 상태이며 사용자에게 보이지 않음을 나타냅니다. 이 상태는 앱이 최소화되거나 다른 애플리케이션에 의해 가려졌을 때 자주 발생합니다.
- paused: 앱이 일시 중지되어 코드를 실행하지 않습니다. 이 상태는 앱이 배경에 있고 사용자에게 보이지 않을 때 발생합니다.
- detached: 앱이 프레임워크에서 완전히 분리되어 종료되기 직전임을 나타냅니다.

<div class="content-ad"></div>

# 준비 사항

코드를 시작하기 전에 다음 사항을 확인해주세요:

- 컴퓨터에 Flutter SDK가 설치되어 있어야 합니다.
- Flutter 앱 구조에 대한 기본적인 이해가 필요합니다.

# 단계 1: 새로운 Flutter 앱 생성

<div class="content-ad"></div>

새로운 Flutter 앱을 만들어보세요. 즐겁게 사용하시는 IDE나 명령 줄을 사용하시면 됩니다. 이름을 app_lifecycle_demo로 지어보세요.

```js
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: AppLifecycleDisplay()),
    );
  }
}
```

# 단계 2: 앱 구조 정의하기

main.dart 파일에서 Flutter 앱의 구조를 정의해보세요. AppLifeCycleDisplay 위젯을 포함한 간단한 MaterialApp과 Scaffold를 생성해보세요.

<div class="content-ad"></div>

# 단계 3: AppLifecycleDisplay 위젯 구현

AppLifeCycleDisplay 위젯을 만들어주세요. 이 위젯은 앱 라이프사이클 상태를 모니터링하고 표시합니다. 이 위젯은 StatefulWidget을 확장하여 상태를 관리합니다.

```js
class AppLifecycleDisplay extends StatefulWidget {
  const AppLifecycleDisplay({super.key});

  @override
  State<AppLifecycleDisplay> createState() => _AppLifecycleDisplayState();
}
``` 

# 단계 4: _AppLifecycleDisplayState 구현

<div class="content-ad"></div>

AppLifeCycleDisplay 위젯의 상태를 정의하세요. 앱 라이프사이클 이벤트에 대한 리스너와 스크롤을 위한 ScrollController를 포함한 필수 변수를 초기화하세요. initState 메서드 내에서 앱 라이프사이클 이벤트를 위한 리스너를 설정하고 초기 상태를 상태 히스토리에 추가하세요. 또한 메모리 누출을 방지하기 위해 dispose 메서드에서 리스너를 해제하세요.

```js
class _AppLifecycleDisplayState extends State<AppLifecycleDisplay> {
  late final AppLifecycleListener _listener;
  final ScrollController _scrollController = ScrollController();
  final List<String> _states = <String>[];
  late AppLifecycleState? _state;

  @override
  void initState() {
    super.initState();
    _state = SchedulerBinding.instance.lifecycleState;
    _listener = AppLifecycleListener(
      // 이벤트 핸들러...
    );
    if (_state != null) {
      _states.add(_state!.name);
    }
  }
  
  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }
}
```

# 스텝 5: 라이프사이클 전환 처리하기

다양한 앱 라이프사이클 전환을 처리하는 메서드를 구현하세요. 전환 발생 시 상태를 업데이트하고 히스토리의 가장 아래로 스크롤하세요.

<div class="content-ad"></div>

```js
void _handleTransition(String name) {
  setState(() {
    _states.add(name);
  });
  _scrollController.animateTo(
    _scrollController.position.maxScrollExtent,
    duration: const Duration(milliseconds: 200),
    curve: Curves.easeOut,
  );
}

void _handleStateChange(AppLifecycleState state) {
  setState(() {
    _state = state;
  });
}
```

# 단계 7: UI 구축하기

MaterialApp, Scaffold 및 현재 상태와 상태 히스토리를 표시하는 텍스트 위젯이 있는 중앙 정렬된 column을 사용하여 UI를 빌드하는 코드를 완성하세요.

```js
@override
Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('App LifeCycle State'),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: <Widget>[
                Text('Current State: ${_state ?? 'Not initialized yet'}'),
                const SizedBox(height: 30),
                Text('State History:\n  ${_states.join('\n  ')}'),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
```

<div class="content-ad"></div>

# 결론

플러터 앱 라이프사이클을 이해하는 데 도움이 되는 이 포괄적인 안내서를 완료하신 것을 축하드립니다! 이 튜토리얼을 통해 플러터 앱 상태의 복잡성에 대한 소중한 통찰력을 얻으셨으며, 앱의 성능과 사용자 경험을 최적화할 수 있게 되었습니다. 요약하자면, ‘hidden,’ ‘inactive,’ ‘paused,’ ‘resumed,’ ‘suspending,’ 그리고 ‘detached’와 같은 다양한 앱 라이프사이클 상태에 대해 배우셨습니다. 이러한 상태 간의 앱 전환 시점을 파악함으로써 효율적인 리소스 관리를 구현하고 사용자 상호작용에 적절히 대응하는 능력을 키울 수 있습니다.

이 예제의 전체 코드는 여기에서 확인하실 수 있습니다.

즐거운 코딩 되세요!