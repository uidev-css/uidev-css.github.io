---
layout: post
title: "고정 요소가 고정되는시기를 감지하는 방법"
author: 'CSS Dev'
thumbnail: undefined
tags: INTERSECTIONOBSERVER,STICKY
---


`position : sticky;`요소가 끈적 거리는 일을하고 있는지 아닌지를 알기 위해 선택자가 필요한 CSS에 대해 David와 완전히 동의합니다.
 

> 이상적으로는 사용할 수있는`: stuck` CSS 지시문이 있지만 대신 CSS 트릭과 일부 JavaScript 마법을 사용하여 요소가 고정 될 때 CSS 클래스를 적용하는 것이 가장 좋습니다.
 

대규모 폴리 필 등이 아닌 솔루션이있을 때 마음에 듭니다.
 이 경우, 몇 줄의`IntersectionObserver` 자바 스크립트와 CSS에서`top : -1px`를 까다롭게 사용합니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_WNwVXKx" src="//codepen.io/anon/embed/WNwVXKx?height=450&amp;theme-id=1&amp;slug-hash=WNwVXKx&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed WNwVXKx" title="CodePen Embed WNwVXKx" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

직접 링크 →
 