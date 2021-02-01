---
layout: post
title: "GreenSock ScrollTrigger
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2021/01/gsap-scrolltrigger.png
tags: GSAP
---


ScrollTrigger 릴리스를 위해 Greensock 갱단에 하이 파이브.
 이 새로운 플러그인의 요점은 페이지가 특정 위치로 스크롤 될 때와 특정 요소가 뷰포트에있을 때 애니메이션을 트리거하는 것입니다.
 구성 할 수있는 모든 것이 있습니다.
 수년 동안 많은 스크롤 위치 라이브러리가 있었지만 Greensock은 API와 성능을 바로 잡는 요령을 가지고 있습니다. 원하는 것은 애니메이션을 트리거하는 것이기 때문에 이제 Greensock을 사용하여 확인할 수 있습니다.
 당신은 좋은 손에 있습니다.
 GSAP의 다른 모든 애니메이션 가능성과 긴밀하게 통합됩니다 (예 : 스크롤 위치에 따라 타임 라인 애니메이션).
 

그들은 문서와 많은 예제를 가지고 있습니다.
 나는 특히 그들이 실수를 할 수있는 방법이있는 실수 섹션을 좋아합니다.
 모든 프로젝트는 그렇게해야합니다.
 

CodePen도 예제로 가득 차 있으므로보기의 즐거움을 위해 여기에 몇 가지를 드롭 할 기회를 잡겠습니다.
 CodePen에서 무료로 플레이 할 수 있습니다 (검색).
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-25-at-3.34.11-PM.png?resize=1506%2C1272&ssl=1)

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_BaogqYy" src="//codepen.io/anon/embed/BaogqYy?height=450&amp;theme-id=1&amp;slug-hash=BaogqYy&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed BaogqYy" title="CodePen Embed BaogqYy" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_qBbBLyB" src="//codepen.io/anon/embed/qBbBLyB?height=450&amp;theme-id=1&amp;slug-hash=qBbBLyB&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed qBbBLyB" title="CodePen Embed qBbBLyB" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_xxwBLMy" src="//codepen.io/anon/embed/xxwBLMy?height=450&amp;theme-id=1&amp;slug-hash=xxwBLMy&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed xxwBLMy" title="CodePen Embed xxwBLMy" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_rNOBLBV" src="//codepen.io/anon/embed/rNOBLBV?height=450&amp;theme-id=1&amp;slug-hash=rNOBLBV&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed rNOBLBV" title="CodePen Embed rNOBLBV" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_abdwYaJ" src="//codepen.io/anon/embed/abdwYaJ?height=450&amp;theme-id=1&amp;slug-hash=abdwYaJ&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed abdwYaJ" title="CodePen Embed abdwYaJ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

너무 많은 모션이 걱정된다면 CSS 미디어 쿼리와 자바 스크립트로 모두 사용할 수있는`prefers-reduced-motion`을 통해 책임감있게 수행 할 수있는 작업입니다.
 