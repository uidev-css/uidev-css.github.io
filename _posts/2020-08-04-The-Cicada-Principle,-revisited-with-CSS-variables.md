---
layout: post
title: "CSS 변수로 다시 찾은 매미 원리"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/08/cicada-css.png
tags: CUSTOM PROPERTIES
---


Lea Verou는 CSS trickery classic을 발굴하여 이를 적용하여 일부 코드 블록의 배경을 클리핑합니다.

> 주요 아이디어는 간단합니다. CSS 변수를 사용하여 기본 규칙을 작성한 다음 ':nth-of-*()' 규칙을 사용하여 N개 항목마다 다른 값으로 설정합니다. 충분한 수의 변수를 사용하고 N을 소수값으로 선택하면 N이 상대적으로 작은 의사 임의성이 양호하게 나타납니다.

요령에 대한 업데이트는 그녀가 각 선택기의 전체 코드 블록을 업데이트하지 않고 사용자 지정 속성을 통해 업데이트되는 클리핑 경로의 일부에 불과하다는 것입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_dyGmbJJ" src="//codepen.io/anon/embed/dyGmbJJ?height=450&amp;theme-id=1&amp;slug-hash=dyGmbJJ&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed dyGmbJJ" title="CodePen Embed dyGmbJJ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

리아의 직책은 같은 개념을 사용하는 더 많은 속임수를 가지고 있다.

직접 링크 →