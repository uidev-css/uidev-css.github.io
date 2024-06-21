---
title: "Flutter에서 위젯 크기를 동적으로 측정하는 방법"
description: ""
coverImage: "/assets/img/2024-06-21-HowtoDynamicallyMeasureWidgetSizeinFlutter_0.png"
date: 2024-06-21 20:09
ogImage: 
  url: /assets/img/2024-06-21-HowtoDynamicallyMeasureWidgetSizeinFlutter_0.png
tag: Tech
originalTitle: "How to Dynamically Measure Widget Size in Flutter"
link: "https://medium.com/@dpon1996/how-to-dynamically-measure-widget-size-in-flutter-e4004f3bd5fb"
---


<img src="/assets/img/2024-06-21-HowtoDynamicallyMeasureWidgetSizeinFlutter_0.png" />

플러터 개발에서 흔한 도전 과제 중 하나는 위젯이 렌더링된 후에 해당 위젯의 동적 크기를 결정하는 것입니다. 이는 다양한 레이아웃 조정 및 애니메이션에 중요할 수 있습니다. 이 포스트에서는 사용자 지정 위젯을 사용하여 위젯의 크기를 측정하는 간단하고 효율적인 방법을 보여 드리겠습니다.

# SizeMeasureWidget

해결책의 핵심은 모든 위젯을 감싸고 렌더링된 후에 크기를 제공하는 사용자 지정 SizeMeasureWidget입니다.

<div class="content-ad"></div>

```js
import 'package:flutter/material.dart';

class SizeMeasureWidget extends StatefulWidget {
  final Widget child;
  final ValueChanged<Size> onSizeMeasured;

  const SizeMeasureWidget({
    Key? key,
    required this.onSizeMeasured,
    required this.child,
  }) : super(key: key);

  @override
  _SizeMeasureWidgetState createState() => _SizeMeasureWidgetState();
}

class _SizeMeasureWidgetState extends State<SizeMeasureWidget> {
  final GlobalKey _sizeKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _sizeKey,
      child: widget.child,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getSize();
    });
  }

  void _getSize() {
    RenderBox renderBox = _sizeKey.currentContext!.findRenderObject() as RenderBox;
    Size size = renderBox.size;
    widget.onSizeMeasured(size);
  }
}
```

## 작동 방식

- Stateful Widget: SizeMeasureWidget은 자식 위젯과 onSizeMeasured 콜백 함수를 가져오는 상태를 가진 위젯입니다.
- GlobalKey: 위젯을 고유하게 식별하고 해당 컨텍스트를 얻기 위해 GlobalKey를 사용합니다.
- Post Frame Callback: initState에서 WidgetsBinding.instance.addPostFrameCallback를 사용하여 위젯 트리가 레이아웃 된 후에 코드를 실행할 콜백을 등록합니다.
- RenderBox: GlobalKey를 사용하여 위젯의 RenderBox를 가져와서 해당 크기를 가져옵니다.
- Callback: 마지막으로 위젯의 크기와 함께 onSizeMeasured 콜백을 호출합니다.

# SizeMeasureWidget 사용 방법  

<div class="content-ad"></div>

여기는 귀하의 응용 프로그램에서 SizeMeasureWidget을 사용하는 방법입니다:

```js
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Dynamic Size Measurement')),
        body: Center(
          child: SizeMeasureWidget(
            onSizeMeasured: (size) {
              print("Widget size: $size");
            },
            child: Container(
              color: Colors.blue,
              height: 200,
              width: 200,
              child: Center(child: Text('Measure my size!')),
            ),
          ),
        ),
      ),
    );
  }
}
```

# 설명

이 예제에서:

<div class="content-ad"></div>

- SizeMeasureWidget 안에 Container를 감쌉니다.
- onSizeMeasured 콜백은 Container의 크기를 콘솔에 출력합니다.

# 장점

- 다이나믹한 레이아웃 조정: 위젯의 크기에 따라 레이아웃을 동적으로 조정할 수 있습니다.
- 애니메이션: 요소의 크기를 알고 있을 때 더 복잡한 애니메이션을 만들 수 있습니다.
- 반응형 디자인: 더 반응형이고 적응형인 UI를 구축할 수 있습니다.

# 결론

<div class="content-ad"></div>

SizeMeasureWidget을 사용하면 Flutter에서 어떤 위젯의 동적 크기를 측정하고 반응하는 것이 쉽습니다. 이 기술은 유연하고 반응적인 레이아웃을 만드는 데 귀중합니다. 여러분의 프로젝트에서 시도해보고 레이아웃 로직을 얼마나 간단하게 만드는지 확인해보세요!