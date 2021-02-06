---
layout: post
title: "라인 애니메이션 햄버거 메뉴"
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/06/1gvhLdQ8-lIgCYmXEeTVyw.png"
tags: HAMBURGER,STROKE-DASHARRAY,SVG ANIMATION
---


이런 종류의 SVG + CSS 애니메이션 속임수는 나에게 매력적이다. Mikael Ainalem은 햄버거 아이콘(당신이 잘 알고 있는 "세 줄")을 그리는 방법을 공유하지만, CSS에서 SVG 속성을 제어함으로써 놀랍고 재미있는 방식으로 애니메이션을 만든다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_wvKOEMV" src="//codepen.io/anon/embed/wvKOEMV?height=450&amp;theme-id=1&amp;slug-hash=wvKOEMV&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed wvKOEMV" title="CodePen Embed wvKOEMV" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

요령은 상·하선이 단순히 직선적인 <선/>이 아니라, 상하로 굽이쳐 십자가를 이루는 <길/>이라는 것이다. 스트로크-대시 배열은 선의 일부만 표시하므로 선의 일부만 볼 수 있습니다(처음에는 직선으로 표시). 그런 다음 stroke-dash array와 stroke-dash offset을 애니메이션화하여 ➡을 형성한다.

직접 링크 →