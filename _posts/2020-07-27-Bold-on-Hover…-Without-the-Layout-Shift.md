---
layout: post
title: "Hover에 굵게 표시... Layout Shift 없이"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/07/bold-no-shifty-shift.gif
tags: HOVER,PSEUDO ELEMENTS
---


글꼴의 `글꼴 가중치`를 변경하면 일반적으로 텍스트에서 레이아웃 이동이 약간 발생합니다. 그 이유는 굵은 글씨가 종종 더 크고 공간을 더 많이 차지하기 때문입니다. 때로는 더 넓거나 더 굵은 텍스트가 아무 것도 밀어넣지 않는 링크의 수직적 스택처럼 문제가 되지 않을 수도 있습니다. 때로는 더 넓거나 더 굵은 텍스트가 다른 요소를 살짝 밀어내는 수평 행처럼 문제가 되기도 합니다.

Ryan Muligan은 다음과 같이 설명합니다.

라이언의 기술은 매우 영리하다. 목록의 각 항목에는 링크에 정확한 텍스트가 있는 유사 요소가 있습니다. 그 유사 요소는 시각적으로 숨겨져 있지만 미리 볼드되어 있고 여전히 폭을 차지하고 있다. 따라서 실제 링크 텍스트가 굵게 표시되더라도 추가 너비는 차지 않습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_WNrYPLo" src="//codepen.io/anon/embed/WNrYPLo?height=450&amp;theme-id=1&amp;slug-hash=WNrYPLo&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed WNrYPLo" title="CodePen Embed WNrYPLo" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

또한 레이아웃에 따라 다릅니다. 여기서 CSS 그리드와 너비에 실제로 도전하지 않는 텍스트가 있는 4개의 열을 강제로 적용해도, 굵은 글꼴은 레이아웃에도 영향을 주지 않습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 350px;"><iframe id="cp_embed_ExPGoaY" src="//codepen.io/anon/embed/ExPGoaY?height=350&amp;theme-id=1&amp;slug-hash=ExPGoaY&amp;default-tab=css,result" height="350" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed ExPGoaY" title="CodePen Embed ExPGoaY" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

하지만, 예를 들어, 그 링크들이 자동 기둥으로 흐르게 한다면, 우리는 변화하는 문제를 가지게 될 것입니다.