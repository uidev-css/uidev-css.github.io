---
title: "Flutter에서 ElevatedButton 모양 커스터마이징 하는 방법"
description: ""
coverImage: "/assets/img/2024-06-21-HowtoCustomizetheShapeofanElevatedButtoninFlutter_0.png"
date: 2024-06-21 22:43
ogImage: 
  url: /assets/img/2024-06-21-HowtoCustomizetheShapeofanElevatedButtoninFlutter_0.png
tag: Tech
originalTitle: "How to Customize the Shape of an ElevatedButton in Flutter"
link: "https://medium.com/@irawnewton/how-to-customize-the-shape-of-an-elevatedbutton-in-flutter-78f34c60fc68"
---


![이미지](/assets/img/2024-06-21-HowtoCustomizetheShapeofanElevatedButtoninFlutter_0.png)

ElevatedButtons의 모양을 shape 속성으로 사용자 정의하세요!

ElevatedButton 위젯은 작업을 실행하는 Material Design 버튼입니다. 발판 모양을 가지고 있으며 모양 속성을 포함한 다양한 속성으로 사용자 정의할 수 있습니다.

기본 ElevatedButton 모양은 8.0의 테두리 반경을 가진 둥근 직사각형입니다. 그러나 ElevatedButton 위젯의 shape 속성을 설정하여 버튼의 모양을 사용자 정의할 수 있습니다.

<div class="content-ad"></div>

모양 속성은 다양한 형태로 설정할 수 있습니다. 예를 들어 다음과 같은 형태들이 있습니다:

- RoundedRectangleBorder
- BeveledRectangleBorder
- CircleBorder
- NotchedShape
- ContinuousRectangleBorder

예를 들어, 다음 코드는 둥근 테두리 반경이 5.0인 ElevatedButton을 생성합니다:

```js
ElevatedButton.icon(
  style: ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
  ), 
  onPressed: () {},
  icon: const Icon(Icons.filter_list),
  label: const Text('Filter'),
);
```

<div class="content-ad"></div>

더 알고 싶다면 irawnewton을 방문해보세요. Flutter에 관한 심층적인 기사와 안내서가 있습니다. Flutter 및 관련 기사에 대한 블로그를 계속 올릴 거에요.

또한 버튼의 모양을 사용자 정의하려면 shape 속성을 사용할 수 있어요. 예를 들어, 다음 코드는 원형 테두리가 있는 ElevatedButton을 만듭니다:

```js
ElevatedButton.icon(
  style: ElevatedButton.styleFrom(
    shape: StadiumBorder(),
  ),
  onPressed: () {},
  icon: const Icon(Icons.filter_list),
  label: const Text('Filter'),
);
```

shape 속성을 사용하면 ElevatedButton의 외관을 사용자 정의하는 강력한 방법입니다. 사용 가능한 다양한 모양을 활용하여 특정한 요구사항과 스타일에 맞는 버튼을 만들 수 있어요.

<div class="content-ad"></div>

안녕하세요! ElevatedButton의 모양을 사용자 정의하는 몇 가지 팁을 제공합니다:

- borderRadius 속성을 사용하여 버튼의 모퉁이 반경을 제어합니다.
- side 속성을 사용하여 버튼의 테두리 색상 및 너비를 설정합니다.
- elevation 속성을 사용하여 버튼의 그림자 높이를 설정합니다.
- padding 속성을 사용하여 버튼 콘텐츠 주변의 패딩 양을 설정합니다.

ElevatedButton의 모양을 사용자 정의하는 자세한 내용은 다음 ElevatedButton 문서를 참조해주세요: [ElevatedButton 문서](https://api.flutter.dev/flutter/material/ElevatedButton-class.html).

이 문서가 Flutter에서 ElevatedButtons의 모양을 사용자 정의하는 데 도움이 되기를 바랍니다.

<div class="content-ad"></div>

질문이 있으시면 언제든지 댓글을 남겨주세요. 도와드릴 수 있어서 더할 나위 없이 기쁩니다.