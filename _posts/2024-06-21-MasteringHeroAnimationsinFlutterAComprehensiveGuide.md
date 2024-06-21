---
title: "플러터에서 히어로 애니메이션 마스터하기 종합 가이드"
description: ""
coverImage: "/assets/img/2024-06-21-MasteringHeroAnimationsinFlutterAComprehensiveGuide_0.png"
date: 2024-06-21 21:13
ogImage: 
  url: /assets/img/2024-06-21-MasteringHeroAnimationsinFlutterAComprehensiveGuide_0.png
tag: Tech
originalTitle: "Mastering Hero Animations in Flutter: A Comprehensive Guide"
link: "https://medium.com/@blup-tool/mastering-hero-animations-in-flutter-a-comprehensive-guide-ecb3e2b3f8e5"
---



![image](https://miro.medium.com/v2/resize:fit:1400/1*hfZq5kMkFSZtlSRsReQYdQ.gif)

모바일 앱 개발 세계에서 부드럽고 시각적으로 매력적인 전환을 만드는 것은 매혹적인 사용자 경험을 위해 중요합니다. Flutter에서 이를 달성하는 가장 효과적인 방법 중 하나는 히어로 애니메이션을 통해입니다. 히어로 애니메이션은 위젯을 한 페이지에서 다른 페이지로 애니메이션화하여 서로 연결되고 동적인 느낌을 만들어 다른 화면 간에 매끄러운 전환을 제공합니다. 이 안내서에서는 Flutter에서 히어로 애니메이션의 기본 사항, 중요성 및 코드 예제로 구현하는 방법을 안내합니다.

## 히어로 애니메이션의 중요성과 사용 사례

히어로 애니메이션은 시각적으로 매력적일 뿐만 아니라 사용자 경험에서도 중요한 역할을 합니다. 그들은 다음에서 도움이 됩니다:


<div class="content-ad"></div>

- 컨텍스트 유지: 사용자들이 쉽게 전환을 따라갈 수 있고 서로 다른 UI 요소 간의 관계를 이해할 수 있습니다.
- 시각적 연속성 제공: 부드럽고 연속적인 사용자 경험을 제공하여 네비게이션이 자연스럽고 순조롭게 느껴지도록 합니다.
- 사용자 참여 증진: 정교하게 디자인된 애니메이션은 앱을 사용하는 데 더 즐겁고 매력적으로 만들 수 있습니다.

## 주요 히어로 애니메이션 사용 사례:

- 이미지 갤러리 전환: 섬네일 그리드 뷰에서 전체 화면 이미지 뷰로 이동하는 것.
- 프로필 페이지 애니메이션: 서로 다른 화면 간에 사용자 아바타나 프로필 사진을 전환하는 것.
- 전자 상거래 앱: 제품 이미지를 목록에서 상세보기로 애니메이션하는 것.

# 파트 1: 히어로 애니메이션의 기본 구조

<div class="content-ad"></div>

## 히어로 애니메이션이란 무엇인가요?

Flutter에서의 히어로 애니메이션은 위젯 간 전환 애니메이션으로, 화면 전환 시 위젯이 한 화면에서 다른 화면으로 "비행"하는 것을 의미합니다. 이로 인해 위젯은 출발지와 도착지 화면 사이를 부드럽게 전환하는 것처럼 보여 시각적으로 매력적인 효과를 제공합니다.

## 기본 히어로 애니메이션 예제

기본 히어로 애니메이션을 만들려면 다음 단계를 따라주세요:

<div class="content-ad"></div>

1. 위젯을 히어로 위젯으로 감싸기:

- 애니메이션을 적용하려는 위젯을 감싸는 데 히어로 위젯을 사용하세요.
- 원본과 대상 히어로 위젯이 동일한 태그를 가지고 있는지 확인하세요.

2. 화면 간 이동하기:

- 화면 간 이동에는 Navigator.push 메서드를 사용하세요.

<div class="content-ad"></div>

여기에 기본 hero 애니메이션을 보여주는 간단한 예제가 있어요:

![영상](https://miro.medium.com/v2/resize:fit:1400/1*Tnp6mCmVil2aRqNtcxrfDg.gif)

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('First Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondPage()),
            );
          },
          child: Text('Go to Second Page'),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Second Page')),
      body: Center(
        child: Text('Welcome to the second page!'),
      ),
    );
  }
}
```

## 플러터에서 사용자 정의 전환

<div class="content-ad"></div>

기본 전환 방식은 편리하지만, 사용자 정의 전환은 애니메이션에 대한 더 큰 유연성과 제어를 제공하여 더 독특한 사용자 경험을 만들 수 있습니다. 페이지 라우트 빌더를 사용하여 사용자 정의 전환을 구현할 수 있으며 전환 애니메이션을 정의할 수 있습니다.

사용자 정의 슬라이드 전환 예시

![사용자 정의 슬라이드 전환 예시](https://miro.medium.com/v2/resize:fit:1400/1*c5cZecOnWL5IL6g75JmoNw.gif)

PageRouteBuilder를 사용하여 사용자 정의 슬라이드 전환의 예시를 확인해보세요:

<div class="content-ad"></div>

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('First Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => SecondScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.ease;

                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ));
          },
          child: Text('Go to Second Screen'),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Second Screen')),
      body: Center(
        child: Text('This is the second screen'),
      ),
    );
  }
}
```

# 사용자 정의 슬라이드 트랜지션 설명

- PageRouteBuilder: 사용자 정의 페이지 라우트 전환을 생성하는 데 사용됩니다.
- pageBuilder: 대상 화면을 정의합니다.
- transitionsBuilder: 전환 애니메이션을 정의합니다. 여기서 SlideTransition을 사용하여 새 화면이 오른쪽에서 슬라이드되는 애니메이션을 구현합니다.

## 코드 설명

<div class="content-ad"></div>

- FirstScreen Class: 초기 화면으로 이미지의 작은 버전을 표시하는 곳입니다. `hero-tag` 태그로 된 Hero 위젯으로 감싸져 있습니다. GestureDetector를 사용하여 탭하면 SecondScreen으로 이동합니다.
- SecondScreen Class: 이 화면은 동일한 이미지의 큰 버전을 표시하며, 같은 태그로 된 Hero 위젯으로도 감싸져 있습니다. Hero 애니메이션은 이 태그를 기반으로 두 위젯을 연결하고 매끄러운 전환 효과를 만듭니다.

## 고급 사용자 정의

Flutter를 사용하면 여러 가지 사용자 정의가 가능합니다. 예를 들어 사용자 정의 비행 경로 및 애니메이션을 정의하거나, FlightShuttleBuilder를 사용하여 전환 중에 hero의 모양을 사용자 정의할 수 있습니다.

# 결론

<div class="content-ad"></div>

플러터의 히어로 애니메이션은 화면 간에 시각적으로 매력적이고 맥락적으로 의미 있는 전환을 만드는 강력한 도구입니다. 기본 구조를 이해하고 간단한 코드 조각으로 히어로 애니메이션을 구현하면 앱의 사용자 경험을 크게 향상시킬 수 있습니다. 사진 갤러리, 전자상거래 플랫폼 또는 부드러운 전환을 통해 혜택을 얻는 어떤 앱이든 구축 중이라면 히어로 애니메이션은 게임 체인저가 될 수 있습니다.