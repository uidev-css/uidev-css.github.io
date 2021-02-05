---
layout: post
title: "바로 그렇게 스크롤할 수 있습니다."
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/08/scroll-indicators.png
tags: SCROLLBARS,SCROLLING,UX
---


페이지 스크롤(또는 해당 페이지의 요소)을 어떻게 압니까? 음, 만약 스크롤바가 있다면, 그건 꽤 좋은 표시야. 여전히 "접기"나 뭐 그런 것에 대해 당신의 고객과 마찰을 빚어야 할 수도 있지만, 저는 아무도 스크롤바가 무엇이고 무엇을 나타내는지에 대해 혼란스러워하지 않는다고 생각합니다.

그러나 스크롤바가 없다고 가정해 보자. 이것은 매우 일반적인 것입니다. macOS는 기본적으로 스크롤 막대를 숨기고 스크롤 중에만 표시합니다. 대부분의 모바일 브라우저에는 스크롤 막대가 없습니다. "overflow:scroll;"(오버플로: 스크롤;)와 같은 방법으로 강제로 사용하려고 해도 스크롤 막대가 없습니다.

이게 왜 중요하죠? 영역을 스크롤할 수 있는지 모를 경우 중요한 내용이나 기능을 놓칠 수 있습니다.

나는 정기적으로 타일러 홀의 `완벽하게 잘려나간 이야기`에 대해 생각한다. iOS에는 아래로 스크롤해야 하는 중요한 기능이 있는 화면이 있지만 스크롤할 수 있는 표시기는 없습니다.

그 결과 타일러의 엄마는 문자 그대로 그녀가 익숙한 기능을 찾을 수 없었다. 별로야.

눈에 보이는 스크롤 막대를 감지하고 강제로 표시하도록 하는 정교한 방법이 있지만, 뭔가 잘못된 방향으로 저를 비벼요. 사용자의 선호도를 존중하지 않으며(사용자의 선호도를 가정하고), DOM 조작 테스트가 필요하며, 벤더에 의해 사전 지정된 CSS를 사용합니다(이 CSS는 아마도 오래 살 것이지만, 지금은 표준화되어 있기 때문에 영원하지는 않을 수도 있음).

저는 이러한 접근 방식과 Chris Smith의 생각을 즐깁니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 850px;"><iframe id="cp_embed_OJMrWgb" src="//codepen.io/anon/embed/OJMrWgb?height=850&amp;theme-id=1&amp;slug-hash=OJMrWgb&amp;default-tab=result" height="850" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed OJMrWgb" title="CodePen Embed OJMrWgb" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

제가 가장 좋아하는 기술은 섀도우 기반 기술입니다. 즉, 음영이 매우 명확한 지표라는 것을 의미합니다. 음영이 그 방향으로 스크롤할 수 있는 힌트로 가장자리를 따라 흐른다는 것을 의미하기 때문입니다. 게다가 CSS 제어가 가능해서 어떤 UI 상황과도 쉽게 일치할 수 있을 것 같아요.

자바스크립트가 없어도 CSS에서 완전히 수행될 수 있고, CSS의 훌륭한 기술 중 하나라는 것을 알아야 한다.