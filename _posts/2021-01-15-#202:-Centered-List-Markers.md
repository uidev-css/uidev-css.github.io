---
layout: post
title: "# 202 : 중앙 목록 마커"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2021/01/centered-list-markers.png
tags: 
---


비디오 다운로드
(MVP 서포터 만 오프라인보기를 위해 원본 고품질 녹음을 다운로드 할 수 있습니다.)

CSS와 마찬가지로 목록 마커를 중앙에 배치하는 것과 같은 사소한 것조차도 알아야 할 모든 종류의 작은 것들이 있습니다.

독자가 달성하려는 작업의 스크린 샷을 작성했습니다. 기본적으로 목록 콘텐츠 위에 목록 마커 (1., 2., 3. 등)가 있고 중앙에 정렬 된 순서가 지정된 목록 (`<ol>`)
 .
 스크린 샷에서 텍스트는 중앙에 있었지만 숫자는 그렇지 않았습니다.
 자, 그 숫자를 중심으로합시다!

가장 먼저 알아야 할 것은`list-style-position`이`inside` 여야한다는 것입니다.
 센터링 파티가 시작됩니다.
 콘텐츠 전에 휴식 시간이 있으면 거의 다 있습니다.
 비디오에서는`:: marker`를 사용하여이를 수행하면서 한계를 찾고 모든 아이디어를 탐색합니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 1000px;"><iframe id="cp_embed_dypQydN" src="//codepen.io/anon/embed/dypQydN?height=1000&amp;theme-id=1&amp;slug-hash=dypQydN&amp;default-tab=css,result" height="1000" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed dypQydN" title="CodePen Embed dypQydN" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>