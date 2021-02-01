---
layout: post
title: "세 줄의 CSS로 된 달력
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/07/calendar-month-view-previous-past-months.png
tags: GRID
---


이 기사는 바이 라인이 없으며이 기사보다 더 이상하게 구체적인 웹 사이트에 있지만 여기에서 트릭에 감사드립니다.
 7 열 그리드는 캘린더 레이아웃을 매우 빠르게 만듭니다.
 `grid-column-start`를 사용하여 첫 번째 날을 올바른 첫 번째 열로 넘기는 것을 제외하고는 날짜 (그리드 항목)가 자연스럽게 떨어지도록 할 수 있습니다.
 

생각 :
 

- 꼭 날짜가 정해져있는 것 같아서`<ul>`이 아닌`<ol>`을 사용하겠습니다.
 
- 목록으로서의 날은 캘린더의 내용에 의미 론적 의미가있을 수 있기 때문에 나를 괴롭히지 않습니다 (일부 항목이 있다고 가정).
 
- 하지만… 같은 목록의 첫 번째 항목으로 요일의 제목을 보는 것은 이상하게 느껴집니다.
 거의 별도의 목록이되어야합니다.
 
- 또는 일종의 표 형식의 데이터이기 때문에 모두`<table>`이어야 할 수도 있습니다 (상호 참조하고 모든 목요일 등을 살펴볼 수 있음을 의미 함).
 

어쨌든 배치 속임수는 재미 있습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_BaLwqGR" src="//codepen.io/anon/embed/BaLwqGR?height=450&amp;theme-id=1&amp;slug-hash=BaLwqGR&amp;default-tab=css,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed BaLwqGR" title="CodePen Embed BaLwqGR" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

다음은 CSS 그리드 스타터 템플릿 컬렉션의 또 다른 (유사한) 접근 방식입니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 600px;"><iframe id="cp_embed_vWXBea" src="//codepen.io/anon/embed/vWXBea?height=600&amp;theme-id=1&amp;slug-hash=vWXBea&amp;default-tab=css,result" height="600" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed vWXBea" title="CodePen Embed vWXBea" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

직접 링크 →
 