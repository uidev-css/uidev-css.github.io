---
title: "함수를 인자로 전달하는 방법  Flutter"
description: ""
coverImage: "/assets/img/2024-06-22-PassingaFunctionasanArgumentFlutter_0.png"
date: 2024-06-22 04:06
ogImage: 
  url: /assets/img/2024-06-22-PassingaFunctionasanArgumentFlutter_0.png
tag: Tech
originalTitle: "Passing a Function as an Argument — Flutter💙"
link: "https://medium.com/@dnkibere/passing-a-function-as-an-argument-flutter-e011ad2afd86"
---


함수를 인수로 전달하는 방법에 대해 궁금했던 적이 있으신가요? 더 나아가, 코드가 깔끔하고 가독성 있게 유지될 수 있도록 함수를 전달해야 하는 상황이 있으신가요?

그렇다면 이제 시작해봅시다!

![이미지](/assets/img/2024-06-22-PassingaFunctionasanArgumentFlutter_0.png)

Flutter는 함수를 인수로 쉽게 전달할 수 있는 다양한 방법을 제공하며, 대부분의 방법이 비슷한 결과를 이끌어냅니다. 본 문서는 이러한 방법들을 설명하고 여러분의 지식 저고리에 추가하고자 합니다. 😁

<div class="content-ad"></div>

이것은 가장 기본적이고 다른 모든 구현은 여기를 기반으로 합니다. 값과 함께 전달되는 옵션인 its variant Function(String val)을 통해 콜백 함수에서 전달된 값을 받을 수 있습니다.

이름이 암시하듯이, 어떤 값을 전달하지 않는 함수 콜백을 선언할 수 있습니다. Function()과 같이 그냥 클릭 이벤트를 수신하고 전달하는 역할을 합니다.

Flutter 프레임워크에서 제공하는 콜백 중 하나로, GestureDetector 위젯에서 탭 이벤트를 듣는 콜백입니다. GestureDoubleTapCallback, GestureTapDownCallback, GestureTapCancelCallback 등이 제공됩니다.

ValueChanged — 값을 변경할 때 사용됩니다.

<div class="content-ad"></div>

ValueSetter — 값이 변경되지 않아도 호출되는 ValueChanged와 동일한 시그니처를 가지고 있습니다. 비동기 상대편 AsyncValueSetter가 있습니다.

ValueGetter — 이벤트를 수신하고 필요할 때 호출됩니다. 비동기 상대편 AsyncValueGetter가 있습니다.

콜백 함수에 ( )가 없다는 것을 알아채셨을 것입니다. 이것은 ( )을 추가하면 함수가 위젯 레이아웃 중에 빌드 메서드에 의해 실행되기 때문입니다. 더 나아가 이후 이벤트를 수신하지 않으므로 클릭 이벤트에서 콜백이 실행되지 않습니다.

DO 🟢

<div class="content-ad"></div>

```dart
ElevatedButton(onPressed: onTap, child: Text('Tap Me')),
```

금지 🛑

```dart
ElevatedButton(onPressed: onTap(), child: Text('Tap Me')),
```

Flutter 2.5부터, Tear Off 개념이 받아들여졌어요.

<div class="content-ad"></div>

단순히 함수를 매개변수로 전달하는 것 뿐입니다. 호출하지 않고 나중에 기본 위젯이 사용할 수 있도록 함수를 전달하는 것입니다. 아래와 같이 표시되어 있습니다. 이전 예제에서 이를 수행해 왔지만, 이 개념에 이름을 지어주면 더 좋습니다. 

```js
ElevatedButton(onPressed: onTap, child: Text('Tap Me')),
```

TearOffs에 관한 자세한 정보는 이 비디오를 확인하세요. 

오늘은 여기까지! 👋👋