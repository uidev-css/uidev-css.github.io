---
layout: post
title: "Flexbox와 텍스트 줄임말 함께 사용"
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/07/files-ellipsis.png"
tags: ELLIPSIS,OVERFLOW,TEXT-OVERFLOW
---


줄임표(...)와 몇 명의 친구를 사용하여 한 줄의 텍스트를 쉽게 자를 수 있습니다. 그러나 예상한 대로 텍스트 줄의 끝에서 잘라내기가 발생합니다. 중간에 내용을 잘라내려면 어떻게 해야 합니까?

Leonardo Faria는 운영 체제 창에서 파일을 나열하는 것처럼 이를 위한 좋은 사용 사례를 자세히 설명합니다. 텍스트 행은 파일 이름과 파일 확장명입니다. 줄이 잘리면 이름만 잘라내고 항상 끝에 있는 확장자를 그대로 둡니다. 이 트릭은 플렉스박스 부모이므로 파일 이름 부분에만 오버플로를 사용할 수 있지만 자연 값이 "min-content"이므로 "min-width"를 재설정해야 하므로 잘리지 않아 혼란스럽다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_rNxZJad" src="//codepen.io/anon/embed/rNxZJad?height=450&amp;theme-id=1&amp;slug-hash=rNxZJad&amp;default-tab=html,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed rNxZJad" title="CodePen Embed rNxZJad" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

직접 링크 →