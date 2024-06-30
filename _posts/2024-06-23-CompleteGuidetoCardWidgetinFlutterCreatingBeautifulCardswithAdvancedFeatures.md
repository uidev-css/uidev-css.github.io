---
title: "Flutter 카드 위젯 완벽 가이드 고급 기능을 활용한 아름다운 카드 만들기 방법"
description: ""
coverImage: "/assets/img/2024-06-23-CompleteGuidetoCardWidgetinFlutterCreatingBeautifulCardswithAdvancedFeatures_0.png"
date: 2024-06-23 14:54
ogImage:
  url: /assets/img/2024-06-23-CompleteGuidetoCardWidgetinFlutterCreatingBeautifulCardswithAdvancedFeatures_0.png
tag: Tech
originalTitle: "Complete Guide to Card Widget in Flutter: Creating Beautiful Cards with Advanced Features"
link: "https://medium.com/@hamidrezadeveloper/complete-guide-to-card-widget-in-flutter-creating-beautiful-cards-with-advanced-features-982fc1ac32ba"
---

![Card Widget](/assets/img/2024-06-23-CompleteGuidetoCardWidgetinFlutterCreatingBeautifulCardswithAdvancedFeatures_0.png)

플러터 프레임워크의 Card 위젯은 그림자와 둥근 모서리를 가진 표면을 만들 수 있어서 기사, 목록 및 다른 UI 섹션에 정보를 표시하는 데 적합합니다. 이 위젯에는 카드의 모양을 사용자 지정할 수 있는 다양한 속성이 있습니다.

1. 자식 위젯 지정:
   Card 위젯은 카드의 내용으로 작동하는 자식 위젯을 허용합니다. 다음 예제는 카드 안에 텍스트를 배치하는 방법을 보여줍니다:

```js
Card(
  child: Text('This is a card'),
)
```

<div class="content-ad"></div>

2. 색상 설정
   `color` 속성을 사용하여 카드의 배경색을 변경할 수 있습니다. 아래 예시는 다채로운 카드를 표시합니다:

```js
Card(
  color: Colors.blue,
  child: Text('Colored Card'),
)
```

# 3. 고도 증가

`elevation` 속성은 카드의 그림자 높이를 제어합니다. 이 속성에 더 큰 값이 할당되면 더 높은 그림자가 생성됩니다. 아래는 고도가 증가된 카드 예시입니다:

<div class="content-ad"></div>

```js
Card(
  elevation: 8,
  child: Text('Elevated Card'),
)
```

# 4. 모양

모양 속성을 사용하여 카드의 모서리 모양을 변경할 수 있습니다. 예를 들어, 모서리를 둥글게 만들 수 있습니다:

```js
Card(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0),
  ),
  child: Text('Rounded Corners Card'),
)
```

<div class="content-ad"></div>

# 5. 여백

카드의 여백은 margin 속성을 사용하여 설정할 수 있습니다:

```js
Card(
  margin: EdgeInsets.all(16.0),
  child: Text('여백 카드'),
)
```

# 6. 전경 제어에 대한 테두리

<div class="content-ad"></div>

`borderOnForeground` 속성을 사용하면 카드의 테두리가 전경에 배치되는지 여부를 제어할 수 있습니다:

```js
Card(
  borderOnForeground: false,
  child: Text('테두리가 전경에 표시되지 않는 카드'),
)
```

# 7. 클립 동작

`clipBehavior` 속성을 사용하면 카드 내부 콘텐츠가 어떻게 클립되는지 결정할 수 있습니다. 가능한 값으로 Clip.none, Clip.hardEdge 및 Clip.antiAlias가 있습니다:

<div class="content-ad"></div>

```js
Card(
  clipBehavior: Clip.antiAlias,
  child: Text('Anti-aliased Clip Card'),
)
```

# 8. 시맨틱 컨테이너

만약 이 속성이 true이면, 카드는 시맨틱 컨테이너로 정의되며, 그렇지 않으면 자식 요소의 의미론이 가장 가까운 둘러싸는 시맨틱 컨테이너와 병합됩니다.

```js
Card(
  semanticContainer: true,
  child: Text('Semantic Container Card'),
)
```

<div class="content-ad"></div>

# 9. 그림자 색상

그림자 색상을 설정하려면 shadowColor 속성을 사용할 수 있습니다:

```js
Card(
  shadowColor: Colors.red,
  child: Text('그림자 색상 카드'),
)
```

# 10. 테두리 반지름

<div class="content-ad"></div>

borderRadius 속성을 사용하여 카드의 모서리의 반지름을 설정할 수 있습니다.

```js
Card(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30.0),
  ),
  child: Text('사용자 정의 보더 반경 카드'),
)
```

<img src="/assets/img/2024-06-23-CompleteGuidetoCardWidgetinFlutterCreatingBeautifulCardswithAdvancedFeatures_1.png" />

플러터의 Card 위젯의 다양한 기능을 활용하여, Material Design 표준에 부합하는 다양한 외관의 카드를 생성할 수 있습니다. 이러한 기능을 통해 시각적으로 매력적이며 이해하기 쉽고 직관적인 사용자 인터페이스를 만들 수 있습니다.
