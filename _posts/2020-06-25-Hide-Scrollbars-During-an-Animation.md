---
layout: post
title: "애니메이션 도중 스크롤 막대 숨기기"
author: "Uidev Css"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/06/toggle-list.png"
tags: ANIMATION,SCROLLBARS,SPECIFICITY
---


CSS는 여전히 `자동` 차원으로 애니메이션할 수 없습니다.

```css
.dropdown {
  transition: 0.2s;
  height: 0;
}
.dropdown.open {
  /* the height will change, but it won't animate. */
  height: auto;
}
```

시도해 볼 수 있는 JavaScript 속임수가 있습니다. 브랜든 스미스는 조금 전에 여기서 몇 가지 기술을 개략적으로 설명했습니다. 내 마음은 항상 이 해결책으로 간다. 단지 그것이 매우 간단하기 때문이다:

```css
.dropdown {
  transition: 0.2s;
  max-height: 0;
}
.dropdown.open {
  /* 🎉 */
  max-height: 400px;
}
```

이제 400px 매직 넘버가 나왔는데 이상적이지는 않습니다. 하지만 이것이 효과가 있고 매우 간단하다는 사실은 제가 항상 그것을 사용하는 것을 매우 매력적으로 만듭니다.

하지만 매직 넘버만이 문제가 아닙니다. 또 다른 문제는 스크롤 막대입니다.

최대 높이: 0, hidden을 설정할 때 드롭다운이 닫힐 때 실제로 숨겨지도록 하려면 "overflow:hidden"도 필요합니다. 드롭다운이 열려 있을 때, 우리는 아마도 "overflow: auto;"를 사용하여 드롭다운의 자연 높이가 확장 후 "max-height"보다 높을 경우 실수로 콘텐츠를 차단하지 않도록 해야 한다. "overflow: auto;"를 사용하면 다른 문제를 해결할 수 있는데, 확장 중에 최종 확장 높이에 스크롤 바가 필요하지 않더라도 드롭다운에는 항상 확장의 최소한 일부에 대한 스크롤 바가 있습니다. 어색하네요!

구조에 대한 CSS 속임수입니다.

확장된 상태에서는 `overflow: auto;`를 계속 사용할 수 있습니다. 애니메이션 중에 재정의만 하면 됩니다. 우리가 위대한 CSS 특수성 전투에서 배웠듯이, `@keyframe`은 활동 중에 어떤 것이든 재정의할 수 있는 놀라운 능력을 가지고 있다. 개구부를 애니메이션화하는 데 사용하지 말고 스크롤 막대 숨기기 기능에만 사용합니다.

```css
.dropdown {
  max-height: 0;
  overflow: hidden;
  transition: max-height 1.2s ease-in-out;
}
.dropdown.open {
  overflow: auto;
  max-height: 400px;
  animation: hide-scroll 1.2s backwards;
  @keyframes hide-scroll {
    from, to { overflow: hidden; } 
  }
}
```

그거면 충분해!

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_xxZgbwN" src="//codepen.io/anon/embed/xxZgbwN?height=450&amp;theme-id=1&amp;slug-hash=xxZgbwN&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed xxZgbwN" title="CodePen Embed xxZgbwN" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

애니메이션 중에 스크롤 막대가 보이지 않고 필요한 경우에만 스크롤 막대가 표시되는 방법을 확인하려면 높이를 더 낮은 값으로 조정해 보십시오. 스크롤바가 튀어나올 때 약간 이상한 느낌이 들지만, 제 경우에는 그런 일이 거의 일어나지 않기 때문에 그런 일은 용납될 수긍할 수 있는 일이죠. 저크를 완전히 중지하려면 드롭다운에 (사용자 정의) 스크롤 막대를 항상 적용하고 필요한 경우 애니메이션 중에 스크롤 막대의 스타일링을 조정할 수 있습니다.

이 속임수로 인해 @keyframers의 팬시인 Stephen Shaw씨의 공을 인정해 주십시오. 코드펜에서 뭔가를 할 때 내가 알아내는 걸 도와주려고 그를 끌어당겼지 우리는 이 트릭을 Collabo Mode를 보여주는 CodePen 채널의 비디오로 만들기로 결정했습니다. 이 트릭은 문제/해결 방법을 파악하는 데 사용되었습니다.