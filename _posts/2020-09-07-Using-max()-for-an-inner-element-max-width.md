---
layout: post
title: "내부 요소 최대 너비에 max() 사용"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/08/full-width-inner-content.png
tags: MAX
---


`내부 문제`에서 이 모든 것을 다뤘습니다. 요지: 가장자리부터 가장자리까지 컨테이너를 사용하되, 내부 콘텐츠의 너비는 제한적입니다. 저는 안에 내포된 요소를 사용하는 데 전혀 문제가 없다고 생각하지만, 그 가능성을 하나의 요소에서 보는 것도 재미있습니다.

이 기사에서 제가 가장 좋아하는 것은 패딩을 계산하는 것입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 350px;"><iframe id="cp_embed_VOYxOa" src="//codepen.io/anon/embed/VOYxOa?height=350&amp;theme-id=1&amp;slug-hash=VOYxOa&amp;default-tab=result" height="350" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed VOYxOa" title="CodePen Embed VOYxOa" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

calc()가 실제로 요령을 발휘하지만 최소 패딩은 허용하지 않습니다. 음, max()는 그렇다. 최소의 가치를 원하는데 그 근육의 기억력을 쌓아야 한다는 것은 여전히 혼란스러운 일이다.

Caluè de Lacerda Pataca 독자는 마지막 뉴스레터에 다음과 같은 현명한 아이디어로 이러한 기능에 대해 언급했습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 350px;"><iframe id="cp_embed_qBZqNKa" src="//codepen.io/anon/embed/qBZqNKa?height=350&amp;theme-id=1&amp;slug-hash=qBZqNKa&amp;default-tab=result" height="350" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed qBZqNKa" title="CodePen Embed qBZqNKa" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이제 어떤 일이 있어도 콘텐츠가 가장자리와 충돌하지 않도록 할 수 있습니다.