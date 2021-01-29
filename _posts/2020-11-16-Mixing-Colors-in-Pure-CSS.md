---
layout: post
title: "순수 CSS에서 색상 혼합"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2018/03/color-wheels.jpg
tags: COLOR,KEYFRAMES
---


빨간색 + 파란색 = 보라색… 맞죠?
 

CSS로 표현할 수있는 방법이 있습니까?
 글쎄, 쉽지는 않습니다.
 `색상 혼합`기능에 대한 제안 초안이 있고 Chrome에서 어느 정도 관심이 있지만 모퉁이에있는 것 같지 않습니다.
 디자이너가 색상으로 작업 할 때 더 큰 유연성을 제공하므로 네이티브 CSS 색상 혼합을 사용하는 것이 좋습니다.
 한 가지 예는 단일 기본 색상의 색조 변형을 만들어 디자인 팔레트를 형성하는 것입니다.
 

하지만 이것은 CSS 트릭이므로 CSS 트릭을 몇 가지 해보겠습니다.
 

CSS에는 숫자를 조작하기위한`calc ()`함수가 있습니다.
 그러나 일부 색상 형식 (예 :`hsl ()`및`rgb ()`)이 숫자 값을 기반으로하지만 색상에서 직접 작업하는 방법은 거의 없습니다.
 

### 애니메이션과 색상 혼합
 

CSS에서 한 색상에서 다른 색상으로 전환 할 수 있습니다.
 이것은 작동합니다 :
 

```css
div {
  background: blue;
  transition: 0.2s;
}
div:hover {
  background: red; 
}
```

여기에 애니메이션이 있습니다.
 

```css
div {
  background: blue;
  transition: 0.2s;
}
div:hover {
  animation: change-color 0.2s forwards;
}
 
@keyframes change-color {
  to {
    background: red;
  }
}
```

무한히 실행되는 키 프레임 애니메이션으로, 빨간색과 파란색 사이에서 색상이 움직이는 것을 볼 수 있습니다.
 콘솔을 열고 페이지를 클릭하십시오. JavaScript에서도 애니메이션의 정확한 지점에서 현재 색상을 알 수 있습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_Vwjajrw" src="//codepen.io/anon/embed/Vwjajrw?height=250&amp;theme-id=1&amp;slug-hash=Vwjajrw&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed Vwjajrw" title="CodePen Embed Vwjajrw" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

그렇다면 중간 어딘가에 애니메이션을 일시 중지하면 어떻게 될까요?
 색상 혼합이 작동합니다!
 다음은 `1 초`기간 동안 `0.5 초`인 일시 중지 된 애니메이션입니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_abZNGRN" src="//codepen.io/anon/embed/abZNGRN?height=250&amp;theme-id=1&amp;slug-hash=abZNGRN&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed abZNGRN" title="CodePen Embed abZNGRN" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

우리는`-0.5s`의`animation-delay`를 설정함으로써이를 달성했습니다.
 그리고 빨간색과 파란색의 중간 색상은 무엇입니까?
 보라색.
 `animation-delay`를 조정하여 두 색상의 백분율을 지정할 수 있습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_bGeppRb" src="//codepen.io/anon/embed/bGeppRb?height=250&amp;theme-id=1&amp;slug-hash=bGeppRb&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed bGeppRb" title="CodePen Embed bGeppRb" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이것은 Chromium 핵심 브라우저 및 Firefox에서 작동합니다.
 Safari에서 브라우저가 애니메이션 진행률을 다시 계산하도록하려면 애니메이션 이름을 변경해야합니다.
 

### CSS 사용자 정의 속성에 혼합 색상 가져 오기
 

지금까지는 깔끔한 트릭이지만 혼합 색상을 사용해야하는 요소에 애니메이션을 적용한 다음 `@keyframes`내에서 변경하려는 모든 속성을 설정해야하는 것은 그리 실용적이지 않습니다.
 

CSS 기능을 몇 개 더 추가하면 조금 더 개선 할 수 있습니다.
 

- `@ property` 유형의 CSS 사용자 정의 속성을 사용하여 적절한 색상으로 만들어 색상으로 애니메이션 할 수 있습니다.
 
- Sass`@ function`을 사용하여 특정 지점에서 키 프레임을 쉽게 호출 할 수 있습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_RwRKZOW" src="//codepen.io/anon/embed/RwRKZOW?height=250&amp;theme-id=1&amp;slug-hash=RwRKZOW&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed RwRKZOW" title="CodePen Embed RwRKZOW" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이제 애니메이션을 호출해야하지만 그 결과 다른 속성에서 사용할 수 있도록 사용자 지정 속성이 변경됩니다.
 