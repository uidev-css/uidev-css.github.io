---
title: "Flutter 애니메이션, 전환 효과 Flutter에서 위젯의 페이드 인아웃 방법"
description: ""
coverImage: "/assets/img/2024-06-21-FlutterAnimationsTransitionsFadeaWidgetInandOutinFlutter_0.png"
date: 2024-06-21 20:05
ogImage:
  url: /assets/img/2024-06-21-FlutterAnimationsTransitionsFadeaWidgetInandOutinFlutter_0.png
tag: Tech
originalTitle: "Flutter Animations , Transitions: Fade a Widget In and Out in Flutter."
link: "https://medium.com/@blup-tool/flutter-animations-transitions-fade-a-widget-in-and-out-in-flutter-9f95849076f8"
---

<img src="https://miro.medium.com/v2/resize:fit:1400/1*BOcAOqWDdYizQO08mQaOiA.gif" />

## 플러터에서 페이드 인 및 페이드 아웃 애니메이션을 만드는 방법

AnimatedOpacity를 사용하여 플러터 앱을 부드러운 페이드 인 및 페이드 아웃 애니메이션으로 향상시키는 방법을 배워보세요. 원활한 전환을 위한 단계별 가이드를 따라보세요.

애니메이션을 통해 모바일 애플리케이션의 사용자 경험을 크게 향상시킬 수 있으며 더 매력적이고 상호작용적인 요소를 더할 수 있습니다. 가장 간단하면서도 효과적인 애니메이션 중 하나는 페이드 인 및 페이드 아웃 효과입니다. 이 블로그 포스트에서는 위젯의 가시성을 부드럽게 전환할 수 있게 해주는 플러터에서 불투명도 애니메이션을 만드는 방법을 탐색해보겠습니다. 스플래시 화면, 로딩 표시기를 생성하거나 UI에 약간의 서서히 변하는 애니메이션을 추가하고 싶은 경우, 이 효과를 구현하는 방법을 이해하는 것이 굉장히 유용할 수 있습니다.

<div class="content-ad"></div>

# 목차

- 소개
- 불투명도 애니메이션을 사용하는 이유
- 플러터 환경 설정
- StatefulWidget 생성
- 불투명도 애니메이션 구현
- 불투명도 전환
- 앱 실행
- 결론

플러터 불투명도 애니메이션, 플러터 위젯 페이드인, 플러터 위젯 페이드아웃, 플러터 애니메이션, 플러터 AnimatedOpacity, 플러터 UI 향상, 플러터 튜토리얼, 플러터 Stateful 위젯 애니메이션

# 불투명도 애니메이션을 사용하는 이유?

<div class="content-ad"></div>

투명도 애니메이션은 앱에 시각적 매력을 더할 수 있는 훌륭한 방법입니다. 이것들은 전환을 더 부드럽게 만들어주고 사용자에게 미세한 방식으로 피드백을 제공할 수 있습니다. 예를 들어, 다음과 같이 사용할 수 있습니다:

- 콘텐츠가 이용 가능해지면 서서히 나타나게 하기.
- 콘텐츠가 제거되거나 교체될 때 서서히 사라지게 하기.
- 앱의 다른 상태 간에 부드러운 전환을 만들기.

이러한 애니메이션들을 활용하면 애플리케이션이 더 반응적이고 세련되게 느껴지게 할 수 있습니다.

# Flutter 환경 구성하기

<div class="content-ad"></div>

코딩에 들어가기 전에, 귀하의 컴퓨터에 Flutter를 설치하고 설정했는지 확인해 주세요. 모든 준비가 끝났다면 공식 Flutter 설치 가이드를 따를 수 있습니다.

- 새로운 Flutter 프로젝트 만들기: 터미널을 열고 다음을 실행해 주세요:

```bash
flutter create fade_animation_example
```

- 프로젝트 디렉토리로 이동하기:

<div class="content-ad"></div>

- cd fade_animation_example

- 선호하는 IDE에서 프로젝트 열기: Visual Studio Code, Android Studio 또는 선호하는 다른 IDE를 사용할 수 있어요.

# StatefulWidget 만들기

투명도 애니메이션을 만들기 위해 StatefulWidget이 필요합니다. 애니메이션은 상태 변경을 포함하기 때문이에요.

<div class="content-ad"></div>

```js
import 'package:flutter/material.dart';
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FadeInOut(),
    );
  }
}
class FadeInOut extends StatefulWidget {
  @override
  _FadeInOutState createState() => _FadeInOutState();
}
```

# Opacity Animation 구현

상태 클래스 내에서 AnimatedOpacity를 사용하여 투명도 애니메이션을 관리할 것입니다.

```js
class _FadeInOutState extends State<FadeInOut> {
  double _opacity = 1.0;
```

<div class="content-ad"></div>

```js
위젯 빌드(BuildContext context) {
  반환 Scafflod(
    appBar: AppBar(title: Text('투명도 애니메이션')),
    body: Center(
      child: AnimatedOpacity(
        opacity: _opacity,
        duration: Duration(seconds: 1),
        child: Container(
          width: 200.0,
          height: 200.0,
          color: Colors.blue,
        ),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        setState(() {
          _opacity = _opacity == 0 ? 1.0 : 0.0;
        });
      },
      tooltip: '투명도 전환',
      child: Icon(Icons.flip),
    ),
  );
}
```

# 투명도 전환

투명도를 전환하려면 FloatingActionButton을 사용합니다. 이 버튼을 누르면 setState 메서드가 실행되어 \_opacity 변수를 업데이트하고, 이로 인해 AnimatedOpacity 위젯이 새로운 투명도 값으로 다시 빌드됩니다.

```js
floatingActionButton: FloatingActionButton(
  onPressed: () {
    setState(() {
      _opacity = _opacity == 0 ? 1.0 : 0.0;
    });
  },
  tooltip: '투명도 전환',
  child: Icon(Icons.flip),
)
```

<div class="content-ad"></div>

# 앱 실행하기

터미널에서 다음 명령어를 사용하여 앱을 실행하세요:

```js
flutter run
```

앱이 실행되면 화면 중앙에 파란색 정사각형이 나타납니다. 플로팅 액션 버튼을 눌러 정사각형이 서서히 나타났다가 사라지게 할 수 있습니다.

<div class="content-ad"></div>

# 결론

위젯의 투명도를 애니메이션화하는 것은 플러터 애플리케이션의 사용자 인터페이스를 향상시키는 간단하면서도 강력한 방법입니다. 이 안내서를 따라가면 AnimatedOpacity를 사용하여 페이드 인 및 페이드 아웃 효과를 구현하는 방법을 알게 될 것입니다. 이 기술은 앱의 다양한 요소에 적용되어 전체적인 사용자 경험을 향상시킬 수 있습니다.
