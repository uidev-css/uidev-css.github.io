---
layout: post
title: "CSS 카운터를 사용하여 현재 단계 표시"
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/07/counter-steps.png"
tags: COUNTER-INCREMENT,COUNTERS
---


단추가 다섯 개라고 하세요. 각 버튼은 한 단계입니다. 네 번째 버튼을 클릭하면 5단계 중 4단계에 해당됩니다.

이런 종류의 계산과 표시는 하드 코딩이 될 수 있지만, 재미는 없습니다. JavaScript도 이 작업을 수행할 수 있습니다. 그런데 CSS는요? 흠, 그럴 수 있을까? CSS에는 카운터가 있기 때문에 우리는 확실히 버튼 수를 셀 수 있습니다. 하지만 어떻게 특정 버튼까지만 계산할 수 있을까요? 할 수 있다는 것이 밝혀졌어요.

### HTML

단추가 아니라 우리가 셀 수 있는 형제자매 요소들이면 됩니다. 하지만 여기서는 버튼을 사용합니다.

```html
<div class="steps">

  <button class="active">Shop</button>
  <button>Cart</button>
  <button>Shipping</button>
  <button>Checkout</button>
  <button>Thank You</button>

  <div class="message"></div>

</div>
```

빈 `.message` div는 우리가 CSS 콘텐츠로 단계 메시징을 출력하는 곳이 될 것이다.

### CSS

요령은 실제로 세 개의 카운터를 사용한다는 것입니다.

- 모든 버튼의 총 개수
- 현재 단계의 개수
- 현재 단계 이후 남은 단계 수

```css
.steps {
  counter-reset: 
    currentStep 0 
    remainder 0 
    totalStep 0;
}
```

이제 계산을 해보겠습니다. 모든 버튼의 카운트는 간단합니다.

```css
button {
  counter-increment: totalStep;
}
```

다음으로, 우리는 버튼을 셀 수 있는 또 다른 것이 필요합니다. 의사 요소를 사용할 수 있습니다. 그 목적은 버튼을 세는 것입니다.

```css
button::before {
  content: "";
  counter-increment: currentStep;
}
```

요령은 활성 요소 이후의 모든 요소에 대한 의사 요소 계산을 중지하는 것입니다. 다음과 같은 `.active` 클래스를 사용하는 경우:

```css
button.active ~ button::before {
  /* prevents currentStep from being incremented! */
  counter-increment: remainder;
}
```

우리는 `남은 것`을 세고 있는데, 이것은 유용할 수도 있지만, 우리가 나머지만 늘리고 있기 때문에, 그것은 우리가 `현재 단계` 카운터를 세지 않는다는 것을 의미한다. 멋지다, 멋지다.

그런 다음 카운터를 사용하여 메시지를 출력할 수 있습니다.

```css
message::before {
  content: "Step: " counter(currentStep) " / " counter(totalStep);
}
```

여기있다!

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_QWydxqP" src="//codepen.io/anon/embed/QWydxqP?height=450&amp;theme-id=1&amp;slug-hash=QWydxqP&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed QWydxqP" title="CodePen Embed QWydxqP" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

거기에 작은 자바스크립트가 있어서 버튼의 활성 상태를 이동하면서 플레이할 수 있지만, 카운팅과 메시징은 모두 CSS입니다.