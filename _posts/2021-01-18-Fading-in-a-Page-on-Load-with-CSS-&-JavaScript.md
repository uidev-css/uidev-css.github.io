---
layout: post
title: "CSS 및 JavaScript로로드시 페이지 페이드"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2021/01/ezgif-3-cdb94d8aee26.gif
tags: 
---


Louis Lazaris는이를 수행하는 매우 간단한 방법을 보여줍니다.

- `opacity : 0`을 선언하는 CSS 클래스를 사용하여 JavaScript로 본문을 즉시 숨 깁니다.
- 모든 JavaScript가 실행될 때까지 기다립니다.
- 다시 `불투명도 : 1`로 전환하여 바디 숨기기 해제

이렇게 :

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_zYKaVvo" src="//codepen.io/anon/embed/zYKaVvo?height=450&amp;theme-id=1&amp;slug-hash=zYKaVvo&amp;default-tab=js,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed zYKaVvo" title="CodePen Embed zYKaVvo" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

Louis는 콜백 메소드를 보여 주며`window.load` 또는 DOM Ready 이벤트를 기다릴 수 있다고 언급했습니다.
 위에서했던 것처럼 실행되는 스크립트의 맨 마지막 줄처럼`className`을`visible`로 설정하는 줄을 가질 수도 있다고 가정합니다.

Louis는 그것이 특별히 유행하지 않는다는 것을 알고 있습니다.

> 저는 오늘날 우리가 페이지 성능에서 밀리 초마다 향상되는이 업계에 집착하고 있다는 것을 알고 있습니다.
 하지만 최근에 점검 한 몇 가지 프로젝트에서 사용자가 내 페이지와 상호 작용을 시작할 수있는 시간을 약간 지연하더라도 경험을 더 좋게 만드는 미묘하고 깨끗한 로딩 메커니즘을 추가했습니다.

가능한 한 절대적으로 빠르게 텍스트를 렌더링하는 데 전념하는`font-display : swap;`과 같은 것을 생각합니다. 냉각기 옵션보다는 FOUT이 저주입니다.

직접 링크 →