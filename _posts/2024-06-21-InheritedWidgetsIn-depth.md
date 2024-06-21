---
title: "상속 위젯에 대한 심층 분석 Flutter 개발자가 알아야 할 모든 것"
description: ""
coverImage: "/assets/img/2024-06-21-InheritedWidgetsIn-depth_0.png"
date: 2024-06-21 20:56
ogImage: 
  url: /assets/img/2024-06-21-InheritedWidgetsIn-depth_0.png
tag: Tech
originalTitle: "Inherited Widgets In-depth"
link: "https://medium.com/@CavinMac/inherited-widgets-in-depth-413794c3b3d9"
---


![image](/assets/img/2024-06-21-InheritedWidgetsIn-depth_0.png)

안녕하세요 여러분! 👋

여러분이 Theme.of(context) 또는 MediaQuery.of(context)를 작성할 때 뒷면에서 무슨 일이 일어나는지 궁금했던 적이 있나요?🤔 그렇지 않다면, 이 글에서는 InheritedWidgets에 대해 모든 것을 배우고 재미난 사실 몇 가지를 알게될 거예요 😉

이 블로그는 초심자와 경험 많은 개발자 모두를 위해 작성되었으므로 모두가 이로부터 혜택을 받을 수 있습니다. 그러니 더 이상 말이 필요 없죠, 시작해봅시다 😄

<div class="content-ad"></div>

## 목차:

- 상속 위젯의 필요성
- 상속 위젯의 구현
- 상속 위젯이란
- 따를 규칙 몇 가지
- 데모
- 결론

# 상속 위젯의 필요성

우리는 모두 플러터에서 모든 것이 위젯이라고 들어본 적이 있습니다. 이 문장은 사실이 아니지만, 위젯은 플러터 앱을 개발할 때 중요한 역할을 합니다.

<div class="content-ad"></div>

플러터(Flutter)에서는 StateLessWidget, StatefulWidget, RenderObjectWidget 등 다양한 유형의 위젯이 있어요. 하지만 대부분의 경우에는 StatelessWidget과 StatefulWidgets를 주로 사용해요. 그럼 InheritedWidget은 어디에 있을까요? 🤔

InheritedWidget의 필요성을 이해하기 위해 이 위젯 트리의 예제를 살펴보겠어요:

![이미지](/assets/img/2024-06-21-InheritedWidgetsIn-depth_1.png)

이제 함께 살펴봐요:

<div class="content-ad"></div>

- CustomText 위젯에서 userName 속성에 액세스하고 싶어요. 그러나 이 속성에 액세스하기 위해서는 userName 속성을 모든 위젯의 생성자 안에 전달해야 해요 🏗️
- 여기서 보면, CustomText로 들어가기 위해 단지 3개의 위젯에서 userName을 전달해야 했어요. 하지만, 이를 위해 많은 표준 코드를 작성해야 했죠. 또한, 모든 위젯에 의존성을 만들어야 했는데, 이는 좋지 않은 방법이에요.

따라서, 모든 위젯의 생성자에 데이터를 전달하는 방법보다 꼼꼼한 💪 해결책이 필요했어요 🏗️

알아챈대로, InheritedWidget이 이 문제를 해결하는 방법이에요 😉 그렇다면, InheritedWidget이 이 문제를 해결하는 데 어떻게 도움이 되는 걸까요? 이 질문에 대한 대답을 드리기 위해, 아래 그래프📈를 보고 제대로 이해해보세요.

<img src="/assets/img/2024-06-21-InheritedWidgetsIn-depth_2.png" />

<div class="content-ad"></div>

호출할 수 있는 데이터에 대해 알고 싶을 때, 상위 레벨에 InheritedWidget을 넣을 수 있다는 점을 확인할 수 있어요. 멋있죠?😃

이제 코드에서 이를 어떻게 구현할 수 있는지 살펴보겠어요.

# Inherited Widget의 구현

- InheritedWidget을 생성하려면 클래스를 InheritedWidget으로 확장해야 합니다.
- 그런 다음 updateShouldNotify 메서드를 구현해야 합니다.

<div class="content-ad"></div>

한 예를 통해 이 개념을 익혀봅시다:

여기에는 이야기할 몇 가지 새로운 내용이 있습니다:

- 생성자에서 자식 위젯을 가져오고 updateShouldNotify 메서드: 이 메서드는 InheritedWidget 내부의 데이터가 변경될 때마다 호출됩니다. 이 메서드가 true를 반환하면, 이 InheritedWidget에 의존하는 자식 위젯들이 다시 빌드될 것을 의미합니다. 이 메서드에서는 이전 InheritedWidget을 가져와서 InheritedWidget 내부의 데이터가 변경되었는지 확인할 수 있습니다. 너무 복잡해 보이나요? 걱정하지 마세요. 이에 대해 깊이 있는 이야기를 나중에 할 거에요 😉
- static UserDataInheritedWidget? of(BuildContext context): InheritedWidget로부터 데이터를 가져오고 싶을 때는 이 메서드를 호출하여 InheritedWidget 내부의 데이터를 가져올 수 있습니다.

이제 Theme.of(context)나 MediaQuery.of(context) 같은 코드를 작성할 때마다 실제로는 해당 InheritedWidget로부터 데이터를 가져오고 있었음을 알게 되었죠.

<div class="content-ad"></div>

이제 자식 위젯에서 데이터를 가져오는 방법을 살펴보겠습니다. 

InheritedWidget의 참조를 가져오려면 StatelessWidget의 경우 build 메서드나 StatefulWidget의 경우 didChangeDependencies 메서드에 다음과 같이 이 문장을 작성할 수 있습니다:

![image](/assets/img/2024-06-21-InheritedWidgetsIn-depth_3.png)

![image](/assets/img/2024-06-21-InheritedWidgetsIn-depth_4.png)

<div class="content-ad"></div>

이제 InheritedWidget을 사용하는 방법을 알게 되었으니, 이에 대해 더 깊이 파보겠습니다🤖.

# Inherited Widget 깊이 알아보기

다음 라인을 살펴보세요: UserDataInheritedWidget.of(context)?.userName

- 이 라인에서는 Widget 트리의 맨 위에 위치한 UserDataInheritedWidget의 참조를 얻고 있습니다.
- 따라서 .of(context)를 작성할 때마다, 당신의 위젯(우리의 경우 DemoWidget)이 UserDataInheritedWidget의 청취자(listener👂)로 등록됩니다.
- 따라서 UserDataInheritedWidget 내부의 값이 바뀔 때마다, 이에 종속된 위젯들이 다시 빌드됩니다. 이에 대한 예시는 마지막에 볼 것입니다.

<div class="content-ad"></div>

## InheritedWidget에서 데이터에 액세스 할 때 지켜야 할 몇 가지 규칙:

- StatefulWidget의 initState 내에서 .of(context) 메서드를 호출하는 것을 피해야 합니다. InheritedWidget의 구성이 변경되어도 위젯이 다시 빌드되지 않기 때문에 ❌
- build, didChangeDependencies 또는 didUpdateWidget 내에서 .of(context) 메서드를 호출할 수 있습니다 ✅

다음은 .of(context) 메서드를 호출할 수 있는 예시입니다:

![이미지](/assets/img/2024-06-21-InheritedWidgetsIn-depth_5.png)

<div class="content-ad"></div>

알겠어요. 이 라이프사이클 메서드 안에서 .of(context) 메서드를 호출할 수 있지만, 어떻게 작동하는지 궁금하시군요? 🤔

이에 대한 답변을 하기 위해서, 우선 didChangeDependencies에서 어떤 종속성을 다루고 있는지 알아보겠습니다. 🤔💭

답은 이 종속성이 dependOnInheritWidgetOfExactType 함수에 의해 생성된다는 점입니다. 이 함수는 InheritedWidget의 static of(BuildContext context) 메서드를 만들 때 구현되었습니다.

그러므로 InheritedWidget 내부의 데이터💽가 변경될 때마다 didChangeDependencies 메서드가 호출될 것입니다.

<div class="content-ad"></div>

build 메소드 내부에서도 .of(context)을 호출할 수 있어요. 성능 차이가 크지 않기 때문에 didChangeDependencies 내부에 이 메소드를 사용하는 것이 좋아요. 더 큰 앱에는 많은 위젯이 있기 때문에요.

이제 InheritedWidgets에 대해 깊게 알았으니, 의존하는 위젯을 다시 빌드할 수 있도록 InheritedWidget의 구성을 변경하는 방법을 살펴봐요.

# 데모:

- 먼저, InheritedWidget을 확장하는 ColorWidget을 만들어봅시다:

<div class="content-ad"></div>

- 여기서는 위젯의 생성자 안에 color와 함께 onColorChanged 메서드를 전달하고 있습니다.
- updateShouldNotify에서는 색이 변경되었는지 확인하고 있습니다. 그리고 변경되었을 경우, true를 반환하여 이 InheritedWidget에 의존하는 위젯들이 다시 빌드되도록 합니다.

이제 이 InheritedWidget을 위젯 트리에 삽입하는 StatefulWidget의 코드를 살펴보겠습니다:

- 이 StatefulWidget에서는 색을 설정하는 ColorWidget을 삽입하는데, 이는 InheritedWidget입니다. ElevetedButton을 누르면 색을 녹색으로 설정합니다.
- 상태 객체의 color 변수가 InheritedWidget에 전달됩니다.

이제 Column 내에 있는 ColorCardWidget의 코드를 살펴보겠습니다:

<div class="content-ad"></div>

여기서 StatelessWidget을 보면 InheritedWidget에서 색상🎨을 받아오고 있습니다. 따라서 색상의 값이 변경될 때마다 ColorCardWidget이 다시 빌드됩니다.

이제 코드를 실행하면 다음과 같은 출력을 볼 수 있어요:

![Image](https://miro.medium.com/v2/resize:fit:748/0*glpgY0XHAbtBZWPz.gif)

그러므로 .of(context) 메서드를 작성함으로써 해당 위젯을 InheritedWidget의 리스너로 등록하여 InheritedWidget 내부 데이터가 변경될 때 자체를 다시 빌드할 수 있다는 것을 확인할 수 있습니다.

<div class="content-ad"></div>

위 예제를 직접 시도하고 싶다면 제 GitHub 저장소를 확인해보세요:

이 글을 통해 상속 위젯에 대해 어떤 통찰을 얻을 수 있었기를 바랍니다. 이 부분 중 이해하지 못한 부분이 있다면 의견란이나 제 LinkedIn 및 Twitter에서 질문해주세요.

## 계속해서 박수를 보내주세요 👏 (박수를 50번 치는 것으로 감사의 표시를 할 수 있습니다)

## 참고문헌: