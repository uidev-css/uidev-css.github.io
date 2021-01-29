---
layout: post
title: "# 200 : 확대 / 축소로 스크롤
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/12/thumb-scroll.png
tags: 
---


비디오 다운로드
(MVP 서포터 만 오프라인보기를 위해 원본 고품질 녹음을 다운로드 할 수 있습니다.)
 

공정한 경고 : 매일 이것이 필요하지 않을 것입니다!
 마우스 스크롤 휠 (또는 트랙 패드)을 사용하여 작업 영역을 확대 / 축소 할 수있는 기능이있는 깔끔한 작은 SVG 워핑 도구를 보았습니다.
 우리는 아이디어를 활용하기 위해 파헤 쳤고,`wheel` DOM 이벤트와 CSS`transform` 덕분에 그리 어렵지 않은 것으로 나타났습니다.
 

결과는 다음과 같습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_oNzLRza" src="//codepen.io/anon/embed/oNzLRza?height=450&amp;theme-id=1&amp;slug-hash=oNzLRza&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed oNzLRza" title="CodePen Embed oNzLRza" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>