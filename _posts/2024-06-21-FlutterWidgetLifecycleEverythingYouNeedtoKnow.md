---
title: "플러터 위젯 생명주기 모든 것을 알아보세요"
description: ""
coverImage: "/assets/img/2024-06-21-FlutterWidgetLifecycleEverythingYouNeedtoKnow_0.png"
date: 2024-06-21 21:28
ogImage:
  url: /assets/img/2024-06-21-FlutterWidgetLifecycleEverythingYouNeedtoKnow_0.png
tag: Tech
originalTitle: "Flutter Widget Lifecycle: Everything You Need to Know"
link: "https://medium.com/gytworkz/flutter-widget-lifecycle-everything-you-need-to-know-629d01ca4a09"
---

![이미지](/assets/img/2024-06-21-FlutterWidgetLifecycleEverythingYouNeedtoKnow.png)

플러터(Flutter)는 구글의 UI 툴킷으로, 모바일, 웹 및 데스크톱용으로 아름답고 네이티브로 결합된 애플리케이션을 단일 코드베이스에서 빠르게 개발할 수 있도록 도와줍니다. 이는 상태를 가지는(stateful) 및 상태를 가지지 않는(stateless) 위젯의 조합입니다. 위젯 라이프사이클을 이해하는 것은 고품질의 플러터 애플리케이션을 개발하기 위해 꼭 필요합니다.

이 블로그 포스트에서는 실제 예제와 함께 플러터에서의 위젯 라이프사이클에 대해 학습하여 작동 방식을 이해하는 데 도움이 되도록 하겠습니다.

![이미지](https://miro.medium.com/v2/resize:fit:960/1*i4BhVQPDcv8mspZ1TOP4_g.gif)

<div class="content-ad"></div>

위젯 생명주기에 들어가기 전에, 이 위젯이 무엇을 의미하며 Flutter에서 어떤 유형의 위젯이 있는지 먼저 이해해 보겠습니다.

# 위젯이란 무엇인가요?

위젯은 Flutter 애플리케이션의 구성 요소입니다. 버튼에서 복잡한 UI 구성 요소까지 모든 것이 될 수 있습니다. 위젯은 애플리케이션의 사용자 인터페이스를 구성하는 데 사용됩니다. Flutter 애플리케이션은 위젯 트리로 구성됩니다. 각 위젯은 고유한 속성을 가지며 다른 위젯 내에 중첩될 수 있습니다.

여기서 위젯을 자세히 설명했습니다.

<div class="content-ad"></div>

- 상태가 없는 위젯.
- 상태를 가지는 위젯.

상태가 없는 위젯은 상태를 포함하지 않기 때문에 부모가 변경될 때만 업데이트될 수 있습니다. 생성된 후에 상태가 없는 위젯은 업데이트할 수 없으므로 변하지 않고 불변성을 가집니다. 변경 사항을 보려면 새 데이터를 제공하여 다시 만들어야 합니다.

```js
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

상태를 가지는 위젯은 내부적으로 상태를 가지므로 상태가 변경될 때나 부모가 변경될 때 업데이트될 수 있습니다. 가변적인 위젯이므로 수명 동안 여러 번 그려질 수 있습니다.

<div class="content-ad"></div>

```js
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

![Flutter Widget Lifecycle - Everything You Need to Know](/assets/img/2024-06-21-FlutterWidgetLifecycleEverythingYouNeedtoKnow_1.png)

# 위젯 라이프사이클 메서드란:

위젯 라이프사이클은 위젯이 생성, 업데이트 또는 파괴될 때 발생하는 일련의 이벤트입니다. 위젯 라이프사이클을 이해하는 것은 효율적인 Flutter 애플리케이션을 작성하는 데 중요합니다.

<div class="content-ad"></div>

- createState(): 위 메서드는 위젯의 상태 객체를 생성합니다. 상태를 가진 위젯을 만들 때, 프레임워크는 createState() 메서드를 호출하며 이를 재정의해야 합니다.

```js
class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}
```

- initState(): 위 메서드는 상태 객체 생성 후에 호출됩니다. 위젯의 상태를 초기화하는 데 사용됩니다.

```js
late int _counter;
@override
void initState() {
  print("initState");
  _counter = 0;
  super.initState();
}
```

<div class="content-ad"></div>

- build() 메서드: 이 메서드는 상태 객체가 초기화된 후에 호출됩니다. 위젯 트리를 구축하는 데 사용됩니다. initState, didChangeDependencies, didUpdateWidget 또는 setState를 통해 상태가 변경된 후에 위젯이 다시 빌드될 때마다 호출됩니다.

```js
  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lifecycle Demo"),
      ),
      body: Container(
          child: Column(
        children: [
          Text(_counter.toString()),
          ElevatedButton(onPressed: _increment, child: const Text("Increment"))
        ],
      )),
    );
  }
```

- didChangeDependencies() 메서드: 이 메서드는 initState 후에 즉시 호출되며, 상태 객체의 종속성이 InheritedWidget을 통해 변경된 경우에 호출됩니다.

```js
  @override
  void didChangeDependencies() {
    print("didChangeDependencies");
    super.didChangeDependencies();
  }
```

<div class="content-ad"></div>

- didUpdateWidget(): 위젯이 새로운 속성으로 업데이트될 때 호출되는 메서드입니다. 일반적인 경우는 부모가 생성자를 통해 자식 위젯에 변수를 전달할 때입니다.

```js
  @override
  void didUpdateWidget(covariant MyPage oldWidget) {
    print("didUpdateWidget");
    super.didUpdateWidget(oldWidget);
  }
```

- deactivate(): 이 메서드는 State가 subtree A에서 제거되고 GlobalKey를 사용하여 subtree B로 다시 삽입될 때 호출됩니다.

```js
  @override
  void deactivate() {
    print("deactivate");
    super.deactivate();
  }
```

<div class="content-ad"></div>

- dispose(): 위젯이 영구적으로 파괴되기 전에 호출되는 메서드입니다. 네트워크 연결을 닫거나 애니메이션을 중지하는 등 위젯이 사용한 모든 리소스를 해제하는 데 사용됩니다.

```js
  @override
  void dispose() {
    print("dispose");
    super.dispose();
  }
```

코드 파일

```js
class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() {
    print("createState");
    return _MyPageState();
  }
}

class _MyPageState extends State<MyPage> {
  void _increment() {
    setState(() {
      _counter = _counter + 1;
    });
  }

  late int _counter;
  @override
  void initState() {
    print("initState");
    _counter = 0;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print("didChangeDependencies");
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant MyPage oldWidget) {
    print("didUpdateWidget");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print("dispose");
    super.dispose();
  }

  @override
  void deactivate() {
    print("deactivate");
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lifecycle Demo"),
      ),
      body: Container(
          child: Column(
        children: [
          Text(_counter.toString()),
          ElevatedButton(onPressed: _increment, child: const Text("Increment"))
        ],
      )),
    );
  }
}
```

<div class="content-ad"></div>

라이프사이클 메서드의 순서:

![라이프사이클](/assets/img/2024-06-21-FlutterWidgetLifecycleEverythingYouNeedtoKnow_2.png)

# 결론

요약하면, 위젯 라이프사이클을 이해하는 것은 고품질의 플러터 애플리케이션을 개발하는 데 필수적입니다. 위젯은 플러터 애플리케이션의 구성 요소이며, 각 위젯은 고유의 라이프사이클을 갖습니다. 위젯 라이프사이클을 숙지함으로써 더 효율적이고 효과적인 플러터 애플리케이션을 개발할 수 있습니다.

<div class="content-ad"></div>

❤ ❤ 이 글 읽어 주셔서 감사합니다 ❤ ❤

만약 이 블로그가 유익하다고 느끼신다면 아래에 👏 클랩(clap)을 부탁드립니다.

LinkedIn에서 연결해요.

저는 플러터 앱 라이프사이클에 관한 모든 것을 설명한 이 블로그를 썼어요 (위젯 라이프사이클과는 다릅니다)
