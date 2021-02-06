---
layout: post
title: "하위 그리드를 사용한 불규칙한 모양 링크"
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/07/irregular-shaped-links-with-subgrid-03a.jpg"
tags: SUBGRID
---


Michelle Barker는 클릭할 수 있는 영역의 간격띄우기 직사각형이 필요한 상황을 다룹니다. 까다로운 부분은 직사각형만 클릭할 수 있게 하는 것이다. 이는 일부 상위 요소를 사용하는 것을 배제하고 공통적인 (그러나 똑같이 까다로운) 패턴인 사각형을 포함하는 전체를 클릭할 수 있게 한다.

절대 위치 지정으로 연결된 사각형의 경계 밖으로 한 칸을 차면 될 수 있지만 미셸은 모든 것을 그리드에 배치한 다음 포인터 이벤트를 사용하여 클릭 영역을 정확하게 맞출 수 있다. 내가 더 강인하게 느껴져.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 750px;"><iframe id="cp_embed_JjGNdNY" src="//codepen.io/anon/embed/JjGNdNY?height=750&amp;theme-id=1&amp;slug-hash=JjGNdNY&amp;default-tab=result" height="750" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed JjGNdNY" title="CodePen Embed JjGNdNY" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

하지만 왜 모든 곳에 서브그리드(subgrid)가 필요한지에 대한 또 다른 좋은 예시는 stat.

직접 링크 →