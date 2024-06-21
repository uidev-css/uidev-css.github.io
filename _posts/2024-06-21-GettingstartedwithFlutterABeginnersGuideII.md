---
title: "처음 시작하는 Flutter 초보자를 위한 가이드 II"
description: ""
coverImage: "/assets/img/2024-06-21-GettingstartedwithFlutterABeginnersGuideII_0.png"
date: 2024-06-21 20:07
ogImage: 
  url: /assets/img/2024-06-21-GettingstartedwithFlutterABeginnersGuideII_0.png
tag: Tech
originalTitle: "Getting started with Flutter: A Beginner’s Guide II"
link: "https://medium.com/@ishinidesilva2418/getting-started-with-flutter-a-beginners-guide-ii-2cbeaf9c4f79"
---


내가 만든 플러터 개발 시리즈의 두 번째 부분에 다시 오신 것을 환영합니다. 첫 번째 부분에서는 Flutter의 이점, 설치, 그리고 프로젝트 설정에 대해 이야기했습니다. 이제 플러터 여정에서 중요한 구성 요소들에 대해 자세히 살펴보겠습니다. 이 글에서는 다음 주제를 다룰 것입니다.

1. Flutter에서의 널 안전성

2. 위젯 만들기

3. 위젯 트리 이해하기

<div class="content-ad"></div>

4. 자료 App

5. 빌드 컨텍스트/컨텍스트

6. 스캐폴드

7. 컨테이너

<div class="content-ad"></div>

8. 행과 열

![Image](/assets/img/2024-06-21-GettingstartedwithFlutterABeginnersGuideII_0.png)

# 플러터에서의 널 안전성

널 안전성은 Dart에 존재하는 기능으로, 실행 시간 오류를 최소화하는 것을 목표로 합니다. 이는 플러터 프로젝트에 대한 더 큰 견고성과 신뢰성을 제공합니다.

<div class="content-ad"></div>

널 안전성을 활성화하려면 SDK가 pubspec.yaml 파일에서 널 안전 Dart 버전으로 설정되어 있는지 확인하세요.

![image](/assets/img/2024-06-21-GettingstartedwithFlutterABeginnersGuideII_1.png)

널 변수: 값이 할당되지 않은 변수를 정의할 수 없습니다. 필요한 경우 아래 예제처럼 물음표를 추가해야 합니다.

예:

<div class="content-ad"></div>

```js
String? name;  //name은 널 가능성이 있음
```

# 위젯 만들기

위젯을 만드는 방법은 3가지가 있습니다. 상태가 없는 위젯, 상태가 있는 위젯 및 클래스 내의 메소드가 있습니다. 각각은 생성 중인 구성 요소의 특정 요구 사항에 따라 사용됩니다.

- 상태가 없는 위젯

<div class="content-ad"></div>

Stateless 위젯은 변경할 수 없습니다. 생성되면 변경할 수 없습니다. 정적 정보나 구성 요소를 표시하는 데 이상적입니다.

사용 시기,

- 어떠한 상태 변화에도 의존하지 않는 UI 요소입니다.


![Getting Started with Flutter: A Beginner's Guide](/assets/img/2024-06-21-GettingstartedwithFlutterABeginnersGuideII_2.png)


<div class="content-ad"></div>

2. Stateful widgets

상태를 가지는 위젯(Stateful widgets)은 변할 수 있으며 사용자 상호작용이나 다른 요소에 따라 변할 수 있습니다.

사용 시기:

- 동적으로 변경해야 하는 UI 요소들.

<div class="content-ad"></div>

`<img src="/assets/img/2024-06-21-GettingstartedwithFlutterABeginnersGuideII_3.png" />`

3. In-class method widgets

클래스 내에서 메소드를 사용하여 위젯을 생성하면 코드를 단순화하고 작은 재사용 가능한 구성 요소로 변환할 수 있습니다.

언제 사용해야 하는지,

<div class="content-ad"></div>

- 대규모 위젯 트리 다루기.

![image](/assets/img/2024-06-21-GettingstartedwithFlutterABeginnersGuideII_4.png)

## 위젯 트리 이해하기

위젯 트리는 Flutter 프로젝트의 계층적 표현입니다. 트리는 루트 위젯에서 시작되고 가지에는 하위 위젯들이 포함됩니다.

<div class="content-ad"></div>


![image](/assets/img/2024-06-21-GettingstartedwithFlutterABeginnersGuideII_5.png)

Ex:

![image](/assets/img/2024-06-21-GettingstartedwithFlutterABeginnersGuideII_6.png)

# Material App


<div class="content-ad"></div>

매터리얼 앱은 Flutter 프로젝트를 위한 기본 구조를 제공합니다. 매터리얼 앱의 속성을 사용하여 앱에 필요한 것들을 조정할 수 있어요.

여기서 매터리얼 앱의 주요 속성 중 일부를 소개했어요.

- Home: 첫 화면을 표시합니다.
- Theme: 앱의 색상, 폰트 및 기타 요소를 정의합니다.
- Route: 한 페이지에서 다른 페이지로 이동합니다.
- Locale: 여러 언어를 지원합니다.

# 빌드 컨텍스트/컨텍스트

<div class="content-ad"></div>

Build context는 Flutter의 위젯 시스템의 중요한 부분입니다. 이는 앱 위젯 간의 관계에 대한 정보를 보유합니다.

예시:

![이미지](/assets/img/2024-06-21-GettingstartedwithFlutterABeginnersGuideII_7.png)

# Scaffold

<div class="content-ad"></div>

스캐폴드는 Material Design 앱의 기본 시각적 레이아웃 구조를 제공합니다. 앱 바, 본문, 배경 서랍 등과 같은 구성 요소가 포함됩니다.

![이미지](/assets/img/2024-06-21-GettingstartedwithFlutterABeginnersGuideII_8.png)

# 컨테이너

컨테이너는 레이아웃 및 스타일링을 위해 일반적으로 사용됩니다.

<div class="content-ad"></div>

프로퍼티: child, width, height, padding, margin, color 등 다양한 속성이 있습니다.

![이미지](/assets/img/2024-06-21-GettingstartedwithFlutterABeginnersGuideII_9.png)

```javascript
Container(
  width: 100,
  height: 100,
  color: Colors.blue,
  child: Center(child: Text('첫 번째 앱')),
);
```

# 행과 열

<div class="content-ad"></div>

플러터에서 행과 열은 기본 레이아웃 위젯입니다. 이를 사용하면 위젯을 수평으로 (행) 또는 수직으로 (열) 배열할 수 있어요.

행:

![Row](/assets/img/2024-06-21-GettingstartedwithFlutterABeginnersGuideII_10.png)

```dart
Row(
  children: [
    Text("텍스트 1"),
    Text("텍스트 2"),
    Text("텍스트 3"),
  ],
);
```

<div class="content-ad"></div>

컬럼:

![이미지](/assets/img/2024-06-21-GettingstartedwithFlutterABeginnersGuideII_11.png)

```js
Column(
  children: [
    Text("텍스트 1"),
    Text("텍스트 2"),
    Text("텍스트 3"),
  ],
);
```

이 블로그 포스트에서는 플러터 애플리케이션을 구축하는 데 필수적인 주요 개념과 구성 요소를 탐색했습니다. 널 안전성을 이해하고 위젯을 생성하며 MaterialApp, BuildContext, Scaffold, Container, Rows 및 Columns을 활용하는 방법을 다루었습니다. 이제 당신은 견고하고 동적인 UI를 구축하기 위한 지식을 갖추었습니다.

<div class="content-ad"></div>

다음 플러터 개발 시리즈에서 더 많은 통찰과 고급 기술을 기대해 주세요! 🥳👏