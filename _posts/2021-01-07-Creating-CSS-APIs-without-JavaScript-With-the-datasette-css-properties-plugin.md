---
layout: post
title: "datasette-css-properties 플러그인을 사용하여 JavaScript없이 CSS API 만들기"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2021/01/datasette-logo.jpg
tags: 
---


Simon Willison은 데이터를 탐색하고 게시하기위한 오픈 소스 멀티 도구 인 Datasette라는 프로젝트를 가지고 있습니다.
 설명 할 자격이 있는지는 모르겠지만, 데이터를 더 쉽게 처리하고 보유한 데이터로 웹을 통해 더 많은 작업을 수행 할 수있는 도구와 같습니다.
 데이터를 쿼리 가능하게 만들고 API를 제공하는 것과 같습니다.

일반적으로 JSON과 같은 유용한 데이터에 대한 API 호출 결과를 얻을 수 있다고 생각합니다.
 그러나 Simon은 결과를 CSS 사용자 정의 속성으로 대신 출력하는 플러그인을 만들고 블로그에 올렸습니다.

> 매우 이상합니다. CSS 사용자 정의 속성 형식을 사용하여 SQL 쿼리의 결과를 출력하는`.css` 출력 확장자를 Datasette에 추가합니다.
 즉, JavaScript없이 순수한 CSS 및 HTML을 사용하여 데이터베이스 쿼리 결과를 표시 할 수 있습니다!

최근에 "사용자 지정 속성을 상태로"에서 언급 한 내용은 다음과 같습니다.

> 이로 인해 이와 같은 CDN 호스팅 CSS 파일은 의사 콘텐츠에 사용되는 오늘 날짜 또는 기타 특수한 시간에 민감한 항목과 같은 다른 유용한 항목을 포함 할 수 있다고 생각합니다.
 아마도 달의 위상일까요?
 스포츠 점수?!
 오늘의 수프?!

그리고 Simon은 길가의 명소는 어떻습니까?

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_MWjXRdP" src="//codepen.io/anon/embed/MWjXRdP?height=450&amp;theme-id=1&amp;slug-hash=MWjXRdP&amp;default-tab=html,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed MWjXRdP" title="CodePen Embed MWjXRdP" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

내 두뇌는 자동으로 그 접근성에 대해 걱정하지만 ... 요즘에는 스크린 리더에서 의사 요소가 공정하고 안정적으로 읽히지 않습니까?
 그래도 유용성과 접근성 문제인 텍스트 또는 페이지에서 찾기를 선택할 수는 없으므로 알 수없는 사용자와 프로덕션 작업을 위해 실제로 수행하는 작업이라고 생각하지 마세요.

그의 블로그 게시물은 시간이 다른 색상을 출력하는 약간 더 역동적 인 예를 보여줍니다.
 그래서`@ property`를 생각하고 사용자 정의 속성에 대한 유형을 선언합니다.
 특정 구문으로 반환되는 값을 사용할 수있을 때 이것이 더 유용하다고 생각합니다.