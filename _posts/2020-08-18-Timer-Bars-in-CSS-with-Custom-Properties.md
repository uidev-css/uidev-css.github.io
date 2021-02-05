---
layout: post
title: "사용자 지정 속성이 있는 CSS의 타이머 막대"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/08/timers.png
tags: CSS ANIMATION,CUSTOM PROPERTIES,METER
---


일전에 눈에 보이는 타이머가 필요한 일을 하고 있었어요. 프로젝트에서 이러한 유형의 타이머에 대한 UI 선례가 있습니다. 사람들은 숫자가 아래로 떨어지는 것을 보고 싶어하지 않았다; "막대"가 가득 찬 상태에서 텅 빈 곳으로 빠져나가는 것을 보는 것이 더 이상적이었다. 제가 언급하는 것은 여러분이 "타이머" UI에 접근할 수 있는 수 많은 방법들이 있기 때문입니다. 이것은 그 모든 것에 대한 탐구가 아니라, 제게 유용한 한 가지 방법에 대한 탐구입니다.

제가 필요로 했던 타이머는 프로젝트 이름이 "라운드 타임" 바였습니다. 작업이 수행됩니다. 그러면 라운드 시간이 발생할 수 있으며 라운드 시간이 끝날 때까지 대부분의 추가 작업이 차단됩니다. 그래서 똑딱거리는 아주 선명한 빨간 막대가 올바른 UI였습니다. 타이머의 끝을 느낄 수 있는 리듬과 흐름을 느낄 수 있고 다음 액션의 시간을 느낄 수 있습니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/08/roundtime.gif?resize=1024%2C95&ssl=1)

이 설정은 매우 쉽습니다.

언제부턴가 컨테이너의 빈 부분을 스타일링하고 싶을 때를 대비해서 부모/자녀에게 선물합시다.

```html
<div class="round-time-bar">
  <div></div>
</div>
```

일단은 그냥 안에다 스타일링만 하자.

```css
.round-time-bar div {
  height: 5px;
  background: linear-gradient(to bottom, red, #900);
}
```

시간 표시기에 사용할 수 있는 작고 빨간 막대를 제공합니다.

다음으로 우리는 그것을 체크해야 합니다. 그러나 여기서 기능성에 대해 생각해야 할 필요가 있습니다. 이런 타이머는 얼마나 걸리는지 알아야 해! HTML로 바로 정보를 제공할 수 있습니다. 그렇다고 해서 JavaScript를 사용하지 않는 것은 아닙니다. 이 정보를 수용하고 있습니다. 우리는 "이봐 자바스크립트, 그 기간을 변수로 주면 우리가 거기서 그걸 가져갈게."라고 말하고 있다.

```html
<div class="round-time-bar" style="--duration: 5;">
  <div></div>
</div>
```

사실, 이 방법은 현대의 DOM 처리 자바스크립트에 매우 친숙하다. "--variable"이 맞는 한 DOM 요소를 언제든지 다시 렌더링할 수 있으며 우리는 설계가 잘 처리되도록 할 수 있다. 우리는 그렇게 하는 변화를 만들 것입니다.

일단 애니메이션을 만들어 봅시다. 좋은 소식이에요, 쉬워요. 다음은 단일 라이너 키 프레임입니다.

```css
@keyframes roundtime {
  to {
    /* More performant than animating `width` */
    transform: scaleX(0);
  }
}
```

막대 디자인에 가로로 축척할 때 찌그러져 보일 것이 없기 때문에 막대를 "스퀴즈"할 수 있습니다. 만약 그랬다면, 우리는 `폭`을 애니메이션으로 만들 수 있을 것이다. 별일 아니에요, 특히 다른 건 따라오지 않으니까요.

이제 막대에 적용합니다.

```css
.round-time-bar div {
  /* ... */
  animation: roundtime calc(var(--duration) * 1s) steps(var(--duration)) forwards;
  transform-origin: left center;
}
```

애니메이션의 지속 시간을 설정하기 위해 `--기간` 변수를 어떻게 끌어당기고 있는지 보시죠? 무거운 걸 들어 올리는군요. 또한 같은 수의 "단계"()를 설정하기 위해 이 단계를 사용하고 있습니다. 이러한 "틱킹"은 사용자가 좋아하는 시각적 UI일 수도 있지만, JavaScript가 언제든지 이 막대를 다시 렌더링할 수 있다는 아이디어도 수용하고, 눈금도 표시하므로 사용자가 알아차릴 가능성이 적습니다. 이렇게 더블듀티를 할 수 있도록 지속시간 값에 정수를 사용했습니다.

하지만 부드러운 애니메이션을 원한다면 다음과 같은 변형으로 제작할 수 있습니다.

```html
<div class="round-time-bar" data-style="smooth" ... />
```

그런 다음 다음 단계를 수행하지 마십시오.

```css
.round-time-bar[data-style="smooth"] div {
  animation: roundtime calc(var(--duration) * 1s) linear forwards;
}
```

또한 타이머에 적합한 선형 애니메이션을 사용하고 있습니다. 원래대로라면 시간은 쉽게 풀리지 않는다. 아니면 그럴까요? 어쨌든, 네 결정이야. 특정 지점에서 속도가 빨라지거나 느려지는 것처럼 보이는 타이머를 원하는 경우 해당 타이머를 사용해 보십시오.

색상 변형과 같은 경우 동일한 변형 데이터 속성 기반 API를 사용할 수 있습니다.

```css
.round-time-bar[data-color="blue"] div {
  background: linear-gradient(to bottom, #64b5f6, #1565c0);
}
```

그리고 마지막 변화는 각각의 "초"를 고정된 너비로 만드는 것입니다. 이렇게 하면 10초 타이머는 문자 그대로 5초 타이머보다 길어 보입니다.

```css
.round-time-bar[data-style="fixed"] div {
  width: calc(var(--duration) * 5%);
}
```

데모는 다음과 같습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_WNraewo" src="//codepen.io/anon/embed/WNraewo?height=450&amp;theme-id=1&amp;slug-hash=WNraewo&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed WNraewo" title="CodePen Embed WNraewo" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

CSS 애니메이션을 다시 시작하기 위한 작은 트릭에 주목하세요.

아, 그리고 저는 좀 더 의미있는 `<meter>` 요소가 있다는 것을 알지만, 적어도 싸우지 않고는 여기 있는 것들을 원하지 않는 것처럼 흉내낼 수 없는 자신만의 UI를 가지고 왔습니다. 하지만 더 쉽게 접근할 수 있을까요? 현재 가치를 유용한 방법으로 발표합니까? 자바스크립트로 실시간으로 <미터>를 업데이트한다면 더 쉽게 접근할 수 있을까요? 아는 사람이 있으면 여기에 솔루션을 연결할 수 있습니다.