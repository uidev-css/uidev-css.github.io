---
title: "Flutter 애니메이션 종합 가이드"
description: ""
coverImage: "/assets/img/2024-06-21-FlutterAnimationsComprehensiveGuide_0.png"
date: 2024-06-21 22:15
ogImage: 
  url: /assets/img/2024-06-21-FlutterAnimationsComprehensiveGuide_0.png
tag: Tech
originalTitle: "Flutter Animations Comprehensive Guide"
link: "https://medium.com/flutter-community/flutter-animations-comprehensive-guide-cb93b246ca5d"
---


이 기사에서는 플러터 애니메이션에 대해 자세히 설명하고 여러 예제와 함께 다루어보겠습니다. 이 기사를 끝까지 읽으면 다양한 복잡성을 갖는 애니메이션을 플러터 앱에 추가할 수 있을 것입니다. 또한 플러터에서 제공하는 다양한 접근 방법 중에서 여러분의 애니메이션 목표에 가장 적합한 것을 알게 될 것입니다. 그럼 바로 시작해 봅시다!

![Flutter Animations](/assets/img/2024-06-21-FlutterAnimationsComprehensiveGuide_0.png)

## 목차:

- 소개
- 암시적 애니메이션 - AnimatedFoo 위젯
- 암시적 애니메이션 - TweenAnimationBuilder 위젯
- 명시적 애니메이션 - FooTransition 위젯
- AnimationController
- 명시적 애니메이션 - AnimatedBuilder 위젯
- 명시적 애니메이션 - AnimatedWidget 클래스
- 올바른 애니메이션 접근 방법 선택하기
- 서드파티 패키지를 사용한 애니메이션

<div class="content-ad"></div>

## TL;DR

이 튜토리얼에서 모든 애니메이션의 코드를 DartPad에서 볼 수 있어요. 코드를 손대면서 실험해보세요.

최근에는 이 튜토리얼을 요약한 트위터 스레드도 올렸어요. 한 번 확인해보세요.

# 소개

<div class="content-ad"></div>

플러터 앱에서 애니메이션은 기본적으로 두 가지 유형으로 볼 수 있어요: 그리기 기반 애니메이션과 코드 기반 애니메이션이에요. 그리기 기반 애니메이션은 애니메이션된 그래픽, 벡터, 캐릭터 또는 "그려진" 모든 것을 말해요. 한편, 코드 기반 애니메이션은 위젯 레이아웃 및 스타일(리스트, 색상, 텍스트 등)에 중점을 두었어요. 이 글의 끝에는 그리기 기반 애니메이션에 대해 간략히 다뤄볼 거에요. 그러나 그들은 보통 3rd party 프레임워크/패키지를 사용하여 달성되므로, 우리는 코드 기반 애니메이션에보다 초점을 맞출 거예요. 코드 기반 애니메이션은 제한적이라는 의미가 아니라, 그 반대로 플러터 애니메이션을 통해 완전히 멋진, 창의적이고 매우 복잡한 애니메이션을 만들 수 있어요. 3rd party 패키지가 필요하지 않아요!

플러터의 코드 기반 애니메이션에는 암시적 애니메이션 및 명시적 애니메이션이 두 가지 유형이 있어요. 이러한 유형 각각에서 준비된 위젯을 사용하거나 직접 위젯을 만들 수 있어요. 각 유형에 대해 몇 가지 예제와 함께 더 자세히 알아보겠어요.

# 1. 암시적 애니메이션

맨 위로 이동하기 👆🏼

<div class="content-ad"></div>

가장 간단하고 사용하기 쉬운 애니메이션입니다. 값만 변경하면 애니메이션이 트리거되고, Flutter가 모든 것을 자동으로 처리해줍니다.

## 1.1 준비된 위젯으로 암묵적 애니메이션

이들은 AnimatedFoo 위젯이라고 불립니다. 여기서 Foo는 애니메이션 속성을 나타냅니다. 대부분은 이미 알고 사용하는 위젯의 애니메이션 버전입니다. 예를 들어 Container/AnimatedContainer, Padding/AnimatedPadding, Positioned/AnimatedPositioned 등이 있습니다.

예를 들어, 다음 애니메이션을 확인해보세요:

<div class="content-ad"></div>


<img src="https://miro.medium.com/v2/resize:fit:930/1*cjoraoQHodaUhNx7z2n1aA.gif" />

이 애니메이션은 AnimatedContainer, AnimatedPositioned 및 AnimatedDefaultTextStyle 위젯만을 사용하여 구현되었습니다. 지속 시간 값을 지정하고 변경 가능한 변수를 제공하면 끝입니다!

```js
AnimatedPositioned(
  top: selectedItemIndex * itemHeight,
  left: 0,
  right: 0,
  duration: const Duration(milliseconds: 200),
  curve: Curves.easeInOut,
  child: //...
),
//...
AnimatedContainer(
  duration: const Duration(milliseconds: 200),
  curve: Curves.easeInOut,
  decoration: BoxDecoration(
    color: selectedItemIndex == i ? yellow : pink,
    border: Border.all(
      color: selectedItemIndex == i
          ? Colors.white
          : Colors.transparent,
      width: 2,
    ),
  ),
  child: AnimatedDefaultTextStyle(
    duration: const Duration(milliseconds: 200),
    style: TextStyle(
      color: selectedItemIndex == i
          ? Colors.black
          : Colors.white,
    ),
    child: const Text('Featured!'),
  ),
),
```

그리고 간단히 각 목록 항목은 아래와 같은 onTap 메서드가 있는 InkWell 위젯으로 래핑되어 있습니다:


<div class="content-ad"></div>

```js
onTap: () => setState(() => selectedItemIndex = i),
```

이렇게 하면 애니메이션을 트리거할 수 있어요!

여기 사용 가능한 AnimatedFoo 위젯 전체 목록이 있어요.

따라서 우리는 AnimatedFoo 위젯을 투명도, 패딩, 정렬, 위치와 같은 속성용으로 가지고 있어요. 하지만 다른 속성을 애니메이션화하고 싶을 때 어떡하나요? 그럼 여전히 쉽고 빠르게 사용하고 싶어요.

<div class="content-ad"></div>

## 1.2. TweenAnimationBuilder를 사용한 암시적 애니메이션

화면 맨 위로 이동 👆🏼

TweenAnimationBuilder를 사용하면 Tween 클래스를 사용하여 모든 위젯의 속성을 암시적으로 애니메이트할 수 있습니다. Tween 클래스의 이름은 "Between"에서 따왔습니다. 기본적으로 애니메이트해야 할 시작 및 끝 값을 제공합니다. 그리고 TweenAnimationBuilder 위젯의 빌더는 애니메이션 값으로 제공되며 이 값을 해당 빌더에서 반환하는 위젯의 어떤 속성에 적용할 수 있습니다.

다음은 예시 애니메이션입니다:

<div class="content-ad"></div>

아래는 해당 코드입니다:

```js
TweenAnimationBuilder(
  duration: const Duration(milliseconds: 200),
  tween: Tween<double>(begin: 0.01, end: _sliderValue),
  child: Container(
    decoration: BoxDecoration(
      //...
    ),
    child: Slider(
      value: _sliderValue,
      min: 0.01,
      onChanged: (value) {
        setState(() => _sliderValue = value);
      },
    ),
  ),
  builder: (BuildContext context, double? value, Widget? child) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 40 * (value ?? 0.01),
          sigmaY: 40 * (value ?? 0.01),
        ),
        child: child,
      ),
    );
  },
);
```

_sliderValue 변수는 0.01에서 1로 변경됩니다. 따라서 각 값의 변경마다 애니메이션이 트리거되며 BackdropFilter 위젯의 sigmaX 및 sigmaY 속성을 위한 새 값으로 다시 빌더 함수가 재구성됩니다. (0 값을 주면 BackdropFilter 위젯이 웹에서 오류를 발생시키기 때문에 0.01을 사용했습니다.)

<div class="content-ad"></div>

TweenAnimationBuilder의 child 매개변수를 사용하여 더 나은 성능을 위해 빌더를 활용하고 있어요. 이 child는 애니메이션이 트리거될 때마다 다시 빌드하는 대신 한 번만 다시 빌드되어요.

좋아요, 쉬운 내용은 끝났습니다. 이제 본격적인 내용을 시작해볼까요?

# 2. 명시적 애니메이션

맨 위로 돌아가기 👆🏼

<div class="content-ad"></div>

암시적 애니메이션에서 AnimatedFoo 또는 TweenAnimationBuilder 위젯 내부의 값만 변경하면 애니메이션이 트리거되었던 것을 기억하시나요? 그러나 명시적 애니메이션은 "명시적으로" 애니메이트할 때까지 애니메이션을 트리거하지 않습니다. 애니메이션을 시작하고 어떻게 애니메이트할지 및 AnimationController를 사용하여 애니메이션을 "제어"하는 방법을 알려주어야 합니다.

명시적 애니메이션 역시 암시적 애니메이션과 유사하게 사용하기 쉬운 위젯과 사용자 정의 수준이 추가된 위젯이 준비되어 있어 자유롭게 사용할 수 있습니다!

그런데, AnimationController가 무엇인지 궁금하시죠? 이를 사용하는 명시적 애니메이션 위젯에 대해 알아보기 전에 먼저 AnimationController에 대해 학습해 보겠습니다.

## AnimationController

<div class="content-ad"></div>

위로 이동 👆🏼

```js
AnimationController({
  double? value,
  this.duration,
  this.reverseDuration,
  this.debugLabel,
  this.lowerBound = 0.0,
  this.upperBound = 1.0,
  this.animationBehavior = AnimationBehavior.normal,
  required TickerProvider vsync,
})
```

이전에 언급했듯이 AnimationController를 사용하면 애니메이션을 "제어"할 수 있습니다. 그를 위해서는 vsync 값이 TickerProvider 유형이 필요합니다. Ticker는 기본적으로 Flutter의 프레임 렌더링을 추적하고 컨트롤러가 해당 티커를 따라가서 지정된 기간 내에 '애니메이션'할 수 있도록 허용하며, 기본적으로 0과 1인 lowerBound 및 upperBound 값 사이에서 선형으로 값들을 생성합니다.

결과적으로, AnimationController를 사용하면 다음을 할 수 있습니다:

<div class="content-ad"></div>

- forward()을 호출하여 애니메이션을 앞으로 재생합니다.
- reverse()를 호출하여 애니메이션을 역방향으로 재생합니다.
- stop()을 호출하여 애니메이션을 멈춥니다.
- repeat()을 호출하여 애니메이션을 가시 상태인 한 계속 반복합니다.
- reset()을 호출하여 애니메이션을 lowerBound로 재설정합니다.
- 값을 설정합니다.
- isAnimating, isCompleted, isDismissed 등과 같이 애니메이션의 상태를 알아내기 위해 다양한 get 함수에 액세스합니다.

자, 이 멋진 놈을 사용하여 실제 작업을 확인해 보겠습니다 🎬

## 2.1. 준비된 위젯을 사용한 명시적 애니메이션

맨 위로 이동 👆🏼

<div class="content-ad"></div>

그들은 FooTransition 위젯이라고 불립니다. 이 때 Foo는 위젯의 애니메이션 속성입니다. 일부는 당신이 사용하는 일반 위젯의 애니메이션 가능한 위젯들입니다. 예를 들어, AlignTransition, PositionedTransition가 있습니다.

이 애니메이션을 확인해보세요:

![animation](https://miro.medium.com/v2/resize:fit:1400/1*GYCKdoQEUQeblnBoyoEHjQ.gif)

이것은 AlignTransition 및 RotationTransition 위젯을 사용하여 달성되었습니다.

<div class="content-ad"></div>

코드 분석:

- 10번 줄 및 17번 줄: AnimationController를 초기화하고 정의합니다.
- AnimationController의 vsync 값 (19번 줄)은 SingleTickerProviderStateMixin(9번 줄)에서 가져온 값입니다. 이 mixin은 우리에게 이야기한 TickerProvider를 제공합니다. 또한 위젯이 보이는 상태일 때만 애니메이션이 실행되도록 보장합니다.
- 11번 줄 및 22번 줄: AlignTransition 위젯의 Animation을 초기화하고 정의합니다 (51번 줄). AlignmentGeometry 유형의 Tween을 사용하여 애니메이션을 정의합니다. 결국, 애니메이션은 Alignment.centerLeft에서 Alignment.centerRight로 애니메이션될 것임을 알려주고 Tween의 animate 메서드를 호출하여 이 애니메이션을 AnimationController와 연결한 후 AlignmentGeometry 유형의 Animation을 반환합니다. 이렇게 하면 AnimationController의 하한 및 상한이 아니라 Tween의 시작 및 종료 값 사이에서 애니메이션이 작동합니다.

- 12번 줄 및 32번 줄: RotationTransition 위젯의 회전 속성(turns)의 애니메이션을 초기화하고 정의합니다 (53번 줄). 따라서 0부터 2까지의 시작 및 종료 값이 있으므로, 애니메이션이 끝나면 위젯은 두 번 회전할 것입니다.
- 20번 줄: AnimationController에 반복을 호출하여 애니메이션이 계속되도록 만듭니다. 그리고 reverse를 true로 설정하면 애니메이션이 순방향으로 시작하여 반대로, 다시 순방향으로, ... 이렇게 반복됩니다.
- 42번 줄: 위젯의 상태가 dispose되는 시점에 AnimationController를 폐기(dispose)합니다. 메모리 누수를 방지하기 위해 AnimationController를 dispose하는 것은 항상 중요합니다!

하지만 걱정하지 마세요. 조금의 연습으로 매우 쉬워지고 익숙해질 것입니다!

<div class="content-ad"></div>

가능한 모든 FooTransition 위젯 목록입니다:

암시적 애니메이션에서 AnimatedFoo 위젯이 애니메이션 목적에 충분하지 않을 때 어떻게 했는지 기억하나요? AnimatedFoo 위젯으로 처리되지 않은 속성을 애니메이션화하기 위해 TweenAnimationBuilder를 사용했습니다. 비슷하게, 명시적 애니메이션에서는 AnimatedBuilder 위젯을 사용하여 어떤 위젯 속성을 애니메이션화할 수 있습니다. 또는 더 나아가서 직접 FooTransition을 만들기 위해 AnimatedWidget 클래스를 사용할 수도 있습니다!

## 2.2 AnimatedBuilder 위젯을 사용한 명시적 애니메이션

맨 위로 이동 👆🏼

<div class="content-ad"></div>

다음 애니메이션을 확인해보세요:

![Animation](https://miro.medium.com/v2/resize:fit:1400/1*whGvEQM5o0b4W0hZIkgu_A.gif)

GradientTransition 위젯이 없죠? 그럼 어떻게 만들었을까요? AnimatedBuilder 위젯을 이용했어요! 여기에 코드가 있어요:

우리는 AnimationController를 초기화하고 정의했고 이를 AnimatedBuilder 위젯의 애니메이션 값으로 사용했어요. 이제 AnimatedBuilder는 컨트롤러의 값이 변경될 때마다 "다시 빌드(build)"되고 빌더를 호출하여 업데이트된 _controller.value 값을 가진 새 위젯을 반환해요. 이로써 그라데이션이 애니메이션 되게 만들었어요.

<div class="content-ad"></div>

물론, AnimationController의 lowerBound 및 upperBound 값 이외의 것을 원한다면, 자체 Animation을 만들고 AnimationController에 연결한 다음 AnimatedBuilder 위젯에 전달할 수 있습니다.

```dart
_animation = Tween<double>(begin: 0, end: 0.5).animate(_controller);
//...
AnimatedBuilder(
  animation: _animation,
  builder: (context, child) {
     //... 값 사용하기: _animation.value
  }
)
```

또한 AnimatedBuilder 위젯의 child 매개변수를 사용하여 성능을 향상시킬 수 있습니다. 이렇게 하면 매번 애니메이션 값이 변경될 때마다 다시 구축되지 않습니다.

아직 따라오고 있나요? 조금만 더 힘내세요! 거의 끝났습니다!

<div class="content-ad"></div>

이제 한 걸음 더 나아가서 AnimatedWidget 클래스를 사용하여 우리만의 FooTransition 위젯을 만들어보겠습니다!

## 2.3 AnimatedWidget 클래스를 사용한 명시적 애니메이션

맨 위로 이동 👆🏼

아주 비밀스러운 비밀을 하나 알려줄게요. 어떤 FooTransition 위젯의 소스 코드로 가 보세요, 무엇을 보게 될까요?

<div class="content-ad"></div>


![Image 1](/assets/img/2024-06-21-FlutterAnimationsComprehensiveGuide_1.png)

😱 It extends an AnimatedWidget class, and from what we see, the Animation type parameter (in this case turns) is passed as a listenable to the super class:

![Image 2](/assets/img/2024-06-21-FlutterAnimationsComprehensiveGuide_2.png)

And the AnimatedWidget is basically a StatefulWidget! So we can do the exact same!


<div class="content-ad"></div>

우리만의 GradientTransition 위젯을 만들어봅시다:

```js
class GradientTransition extends AnimatedWidget {
  final Animation<double> stop;

  const GradientTransition({
    Key? key,
    required this.stop,
  }) : super(key: key, listenable: stop);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: const [purple, pink, yellow],
          stops: [0, stop.value, 1],
        ),
      ),
    );
  }
}
```

그리고 사용하기 위해서는 AnimationController를 그대로 전달하면 됩니다:

```js
GradientTransition(stop: _controller),
```  

<div class="content-ad"></div>

그게 다야!

여기까지 버텨내 왔다면, 매우 간단한 것부터 매우 복잡한 것까지 다양한 플러터 애니메이션을 만들기에 충분한 지식을 가지고 있습니다. 필요한 건 조금의 연습뿐이며, 하늘이 한계입니다!

# 적절한 애니메이션 접근 방식 선택

맨 위로 이동 👆🏼

<div class="content-ad"></div>

하지만 잠시만 기다려봐요. 위에서 다룬 여러 방법 중에서 어떤 애니메이션을 선택해야 하는지 어떻게 알 수 있을까요? 플러터(Flutter) 팀의 멋진 분들이 도와주기 위해 비디오와 의사결정 트리를 만들었어요. 제가 최대한 요약해 드릴게요.

## 1. 그림 기반 vs. 코드 기반

첫 번째 선택은 그림 기반 및 코드 기반 애니메이션 사이에서 이루어질 거예요. 이를 위해 자신에게 물어보세요. 만약 당신의 애니메이션이 그림처럼 더 비스무런가요(그림 기반 사용, 3rd party 패키지 사용, 곧 설명할 거예요) 아니면 레이아웃, 위젯, 위젯 스타일, 색상, 테두리, 텍스트 등과 관련이 있는가요(코드 기반 사용, 위에서 설명한 것)?

## 2. 암시적(Implicit) vs. 명시적(Explicit)

<div class="content-ad"></div>

다음 선택은 암시적 및 명시적 애니메이션 중 하나가 될 것입니다. 선택을 하는 데 고려해야 할 여러 기준이 있습니다:

- 무한히 반복되는 애니메이션
- 연속되지 않는 애니메이션: 애니메이션이 시작 지점으로 돌아가지 않음
- 여러 위젯이 함께 애니메이션화되는 경우

만약 애니메이션이 위의 기준 중 하나라도 가지고 있다면, 명시적 애니메이션을 사용해야 합니다.

## 3. 내장 위젯 대 사용자 정의 위젯

<div class="content-ad"></div>

마지막 선택 사항은 내장 위젯(AnimatedFoo 및 FooTransition 위젯)과 사용자 지정 위젯(TweenAnimationBuilder 및 AnimatedBuilder/AnimatedWidget) 사이에서 합니다. 이것은 이 목록을 보고 원하는 속성을 애니메이션화하기 위해 이미 내장된 위젯이 있는지 여부를 고려하는 것만큼 간단합니다. 해당 내장 위젯을 사용하거나 (그렇지 않으면 직접 생성)

# 3rd Party 패키지를 사용한 애니메이션

하지만 앱에서 그림을 기반으로 한 애니메이션을 사용하고 싶다면 어떨까요? 여기서는 코딩이 절약되었네요 🫢, 또한 플러터는 여기에서도 놀라울 정도로 좋습니다! Rive 및 Lottie와 같은 훌륭한 패키지들이 있어서 3rd party 애니메이션을 원활하게 통합하고 앱에 추가할 수 있습니다. 제공되는 애니메이션을 그래픽 디자이너/모션 그래픽 디자이너와 함께 사용하거나 커뮤니티에서 만든 애니메이션을 다운로드/구매하여 빠르고 쉽게 앱에 사용할 수 있습니다.

<div class="content-ad"></div>

3rd party 패키지를 사용하여 Flutter에서 애니메이션을 만드는 데 관한 전용 기사를 작성할 예정이에요. 지금 당장 유용한 링크 몇 개를 공유해 드릴게요:

- 사용 준비가 된 멋진 애니메이션을 볼 수 있는 Rive 커뮤니티 쇼케이스
- Rive Flutter 패키지
- 무료 LottieFiles 애니메이션
- LottieFiles Flutter 패키지

여기까지가 제 글이에요! 이 기사를 읽어 주셔서 감사합니다. 이것이 Flutter 앱에 애니메이션을 추가하고 싶을 때 여러분의 정보원이 되었으면 좋겠어요. 그럼 여러분도 애니메이션을 넣을 때 즐겁게 시도해 보세요!

https://twitter.com/FlutterComm