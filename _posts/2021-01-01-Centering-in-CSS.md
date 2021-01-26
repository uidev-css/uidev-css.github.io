---
layout: post
title: "CSS 중심"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/12/centering.jpg
tags: CENTERING
---


Adam Argyle은 web.dev에 대한 게시물이 있습니다.
 그는 수직 센터링과 수평 센터링을해야한다는 가정으로 시작합니다.
 특히 콘텐츠의 높이를 알 수없는 경우에는 전통적으로 사람들에게 조금 더 까다로운 수직 센터링이 있습니다.

의사 결정 트리와 같은 다양한 상황을 다루는 센터링에 대한 완전한 가이드가 있습니다.

Adam은이를 처리하기위한 다섯 (!) 메서드를 자세히 설명합니다. 심지어 알려지지 않은 수직 및 수평 차원의 중심을 맞추는 방법과 언어 방향 및 여러 요소와 같은 몇 가지 다른 제한 사항도 포함합니다.
 CSS에서 중심을 맞추는 것이 어렵다는 모든 우스꽝스러운 농담을 업데이트해야한다고 생각합니다.
 CSS를 중심에 놓을 수있는 방법이 얼마나 많은지 재미있게 이야기해야 할 것입니다.

Adam은 모든 기술의 장단점을 나열하고이를 명확하게 보여줍니다.
 비디오도 있습니다.
 그는이기는 접근 방식으로 "부드러운 플렉스"를 선택합니다.

```css
.gentle-flex {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 1ch;
}
```

> 매크로 및 마이크로 레이아웃 모두에 유용하므로 내 스타일 시트에서 항상 찾을 수 있습니다.
 내 기대와 일치하는 결과를 제공하는 다재다능한 신뢰할 수있는 솔루션입니다.
 또한 저는 본질적인 사이징 중독자이기 때문에이 솔루션으로 졸업하는 경향이 있습니다.
 사실, 입력하는 것이 많지만 제공하는 이점이 추가 코드보다 큽니다.

"CSS를 중심으로"할 때 항상 이러한 극한 상황에있는 것은 아닙니다.
 재미로 다른 상황을 살펴 보겠습니다.
 일부`inline- *`¹ 요소를 가로로 가운데에 배치해야한다고 가정 해 보겠습니다.`text-align : center;`를 사용하면 한 줄로 이동할 수 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_HulzB" src="//codepen.io/anon/embed/HulzB?height=450&amp;theme-id=1&amp;slug-hash=HulzB&amp;default-tab=css,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed HulzB" title="CodePen Embed HulzB" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

하지만 해당 항목의 부모를 중앙에 배치해야하는 경우에는 어떻게해야합니까?
 고전적인 `margin : 0 auto;`작업을 할 수 있다고 생각하고 할 수 있지만 부모는 블록 수준이므로 전체 너비이거나 고정 너비 일 수 있습니다.
 대신에 포함 된 콘텐츠만큼 넓기를 원한다고 말합니다.
 부모`inline- *`를 만들 수는 있지만`text-align`을 설정하여 중앙에 배치 할 다른 부모가 필요합니다.

Stefan Judis는 최근에 이것에 대해 이야기했습니다.
 트릭은 요소 블록 수준을 그대로두고`width : fit-content;`를 사용하는 것입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_PoGQbWg" src="//codepen.io/anon/embed/PoGQbWg?height=450&amp;theme-id=1&amp;slug-hash=PoGQbWg&amp;default-tab=css,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed PoGQbWg" title="CodePen Embed PoGQbWg" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이 부드러운 굴곡이 여기에도 포함될 수 있었을 것입니다.하지만 다시 부모가 필요했습니다.
 항상 생각할 것.

직접 링크 →