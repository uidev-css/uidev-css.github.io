---
layout: post
title: "브라우저에서 유효한 CSS 속성 값을 얻을 수 있습니까?"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2018/02/mouse-cursor.jpg
tags: CSS PROPERTIES
---


누군가 이 아주 정당한 질문에 답글을 달게 했어요. 브라우저에서 유효한 CSS 속성을 가져올 수 있는 방법에 대해 방금 블로그에 게시했습니다. 이런 식입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_eYJodjb" src="//codepen.io/anon/embed/eYJodjb?height=450&amp;theme-id=1&amp;slug-hash=eYJodjb&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed eYJodjb" title="CodePen Embed eYJodjb" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이를테면 `커서`가 물건이라는 사실을 알 수 있다. 그러나 커서(cursor)에 대한 유효한 값이 무엇인지 어떻게 알 수 있는가? 우리는 문서를 통해 auto, none, help, context-menu, 포인터, progress, wait 등과 같은 가치들이 있다는 것을 알고 있다.

그런데 그 리스트는 어디서 나온 거죠? 글쎄요, 스펙에 딱 맞는 리스트가 있어서 도움이 됩니다. 그러나 특정 브라우저가 실제로 지원하는 값의 전체 목록은 보장되지 않습니다. `저주: 해골과 십자가 뼈`가 있을 수 있고 우리는 알지도 못할 것이다!

요소에 적용하고 DevTools를 확인하여 테스트할 수 있습니다.

하지만 우리가 그 가치에 대해 거대한 사전 공격을 시작하지 않는 한, 우리는 실제로 브라우저에서 어떤 가치를 가지고 있는지 알지 못합니다. Houdini가 어떻게든 브라우저에서 CSS 자기성찰을 더 잘 할 수 있도록 도와줄까?

또한 `CSS` 개체를 사용하여 `CSS.supports(property, value)`와 같은 테스트를 실행할 수도 있습니다.

CS.validValues(텍스트-데코-두께)와 같은 값을 가질 수 있고 [<길이>>, [백분율], [자동], "from-font" 등의 값을 가질 수 있다고 생각할 수 있지만, 아아, 아무것도 아니다.