---
title: "Flutter 숨겨진 보물 탐험 잘 알려지지 않은 위젯 공개  Part 3"
description: ""
coverImage: "/assets/img/2024-06-30-ExploringHiddenTreasuresinFlutterLesser-KnownWidgetsUnveiledPart3_0.png"
date: 2024-06-30 18:46
ogImage: 
  url: /assets/img/2024-06-30-ExploringHiddenTreasuresinFlutterLesser-KnownWidgetsUnveiledPart3_0.png
tag: Tech
originalTitle: "Exploring Hidden Treasures in Flutter: Lesser-Known Widgets Unveiled — Part 3"
link: "https://medium.com/stackademic/exploring-hidden-treasures-in-flutter-lesser-known-widgets-unveiled-part-3-3c92242fa181"
---


플러터는 다양하고 시각적으로 멋진 애플리케이션을 개발할 수 있도록 개발자들에게 넓은 위젯 카탈로그로 유명합니다. 자주 사용되는 위젯들은 잘 알려져 있지만, 플러터는 잘 알려지지 않지만 매우 유용한 다양한 위젯들도 제공합니다. UI의 세련됨과 기능성을 향상시킬 수 있는 이런 숨겨진 보석들을 알아보겠습니다.

![이미지](/assets/img/2024-06-30-ExploringHiddenTreasuresinFlutterLesser-KnownWidgetsUnveiledPart3_0.png)

### 1. FadeInImage

FadeInImage는 주 이미지가 로딩되는 동안 플레이스홀더 이미지를 표시할 수 있는 위젯입니다. 네트워크에서 이미지를 다룰 때 사용자 경험을 향상시키는 데 특히 유용합니다.

<div class="content-ad"></div>

```dart
FadeInImage(
  placeholder: AssetImage('assets/placeholder.png'),
  image: NetworkImage('https://example.com/image.jpg'),
)
```

## 2. GridPaper

GridPaper은 레이아웃 디버깅을 위한 편리한 위젯입니다. 앱에 그리드를 겹쳐서 간격, 정렬 및 레이아웃 문제를 시각화하기 쉽게 만들어줍니다.

```dart
GridPaper(
  color: Colors.blueAccent,
  divisions: 4,
  interval: 100.0,
  subdivisions: 2,
)
```

<div class="content-ad"></div>

## 3. 히어로

히어로는 위젯을 화면에서 다른 화면으로 부드럽게 전환하여 라우트 간에 애니메이션을 제공합니다. 시각적으로 매력적인 네비게이션 애니메이션을 만드는 데 이상적입니다.

```js
Hero(
  tag: 'hero-image',
  child: Image.network('https://example.com/image.jpg'),
)
```

## 4. KeepAlive

<div class="content-ad"></div>

KeepAlive은 위젯이 화면에서 벗어나도 위젯 트리에 유지되도록 돕습니다. 이는 ListView 또는 PageView에서 위젯의 상태를 유지하는 데 특히 유용합니다.

```js
class MyStatefulWidget extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> with AutomaticKeepAliveClientMixin<MyStatefulWidget> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container();
  }
}
```

## 5. ListBody

ListBody는 주어진 축을 따라 자식 위젯을 선형 배열로 정렬합니다. 간단한 리스트 레이아웃이 필요한 경우 Column 및 Row 대신 간단한 대안으로 사용할 수 있습니다.

<div class="content-ad"></div>

```dart
ListBody(
  children: <Widget>[
    Text('Item 1'),
    Text('Item 2'),
    Text('Item 3'),
  ],
)
```

## 6. MenuRegion

MenuRegion은 앱에서 컨텍스트 메뉴를 정의하는 데 사용됩니다. 이 위젯은 데스크톱 애플리케이션에서 마우스 오른쪽 클릭 컨텍스트 메뉴가 흔한 경우에 유용합니다.

```dart
MenuRegion(
  child: Container(
    color: Colors.blue,
    width: 100,
    height: 100,
  ),
)
```

<div class="content-ad"></div>

## 7. LookUpBoundary

LookUpBoundary은 InheritedWidget 조회 범위를 제한하는 위젯입니다. 위젯 트리의 재구성 동작을 최적화하고 제어하는 데 유용합니다.

```dart
LookUpBoundary(
  child: MyInheritedWidget(
    child: MyWidget(),
  ),
)
```

## 8. Listener

<div class="content-ad"></div>

리스너는 터치, 마우스, 스타일러스 상호작용과 같은 포인터 이벤트를 감지합니다. 이 위젯은 사용자 정의 제스처와 상호작용을 구현하는 데 유용합니다.

```js
Listener(
  onPointerDown: (PointerDownEvent event) => print('Pointer down event'),
  child: Container(
    color: Colors.red,
    width: 100,
    height: 100,
  ),
)
```

## 9. 확대경

확대경은 특정 영역에 확대 효과를 제공합니다. 이는 접근성을 향상시키고 특정 시나리오에서 사용자 경험을 향상하는 데 좋습니다.

<div class="content-ad"></div>


```js
확대기(
  자식: Text('나를 확대해주세요!'),
)
```

## 10. 메뉴 앵커

메뉴 앵커는 특정 위치에 메뉴를 고정하는 데 사용됩니다. 사용자 정의 드롭다운 메뉴와 컨텍스트 메뉴를 만드는 데 유용합니다.

```js
메뉴 앵커(
  menuChildren: <Widget>[
    Text('메뉴 항목 1'),
    Text('메뉴 항목 2'),
  ],
  자식: Text('메뉴 열기'),
)
```

<div class="content-ad"></div>

## 11. MenuBar

MenuBar은 데스크톱 애플리케이션에서 사용할 수 있는 전통적인 메뉴 모음입니다. 데스크톱 사용자에게 익숙한 탐색 경험을 제공합니다.

```js
MenuBar(
  children: <Widget>[
    Text('File'),
    Text('Edit'),
    Text('View'),
  ],
)
```

## 12. MouseRegion

<div class="content-ad"></div>

MouseRegion은 위젯에 마우스가 진입하거나 나가거나 호버될 때를 감지합니다. 인터랙티브 데스크톱 애플리케이션을 만드는 데 필수적인 기능이에요!

```js
MouseRegion(
  onEnter: (_) => print('마우스 진입'),
  onExit: (_) => print('마우스 나감'),
  child: Container(
    color: Colors.green,
    width: 100,
    height: 100,
  ),
)
```

이 글이 유익했기를 바라요! 제공된 정보를 감사하게 여기신다면, 제게 커피 한 잔 사주는 옵션이 있답니다! 여러분의 도움이 큰 힘이 될 거에요!

<img src="/assets/img/2024-06-30-ExploringHiddenTreasuresinFlutterLesser-KnownWidgetsUnveiledPart3_1.png" />

<div class="content-ad"></div>

# 함께해요

이 글을 읽어 주셔서 감사합니다. 즐겁게 읽으셨다면, 더 많은 글을 살펴보고 앞으로 제 포스트를 지켜봐 주시면 감사하겠습니다.

더 많은 IT 관련 콘텐츠에 관심이 있다면, Digital Dive Hub 웹사이트를 방문해 최신 블로그와 소식을 확인해 보세요.

# Stackademic 🎓

<div class="content-ad"></div>

끝까지 읽어 주셔서 감사합니다! 떠나시기 전에 다음을 확인해 주세요: 

- 작가를 박수로 응원하고 팔로우해 주세요! 👏
- 저희를 팔로우해 주세요: X | LinkedIn | YouTube | Discord
- 다른 플랫폼에서도 만나보세요: In Plain English | CoFeed | Differ
- 더 많은 콘텐츠는 Stackademic.com에서 확인하세요.