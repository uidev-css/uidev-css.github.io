---
layout: post
title: "Mad Magazine Fold-In Effect in CSS"
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/06/mad-magazine-fold-in.png"
tags: 3D,ANIMATION,TRANSFORM
---


이것은 매드 잡지에서 항상 내가 가장 좋아하는 것이었다. 한 페이지(뒷면 커버 안쪽)는 자니 그림으로 덮여 있었다. 당신은 그 페이지를 3등분하고, 그 이미지의 중간 부분을 덮습니다. 그리고 새로운 이미지가 형성될 것입니다. 왜냐하면 삽화가 그 접힌 부분들과 완벽하게 일렬로 정렬되도록 설계되었기 때문입니다. 새로운 이미지와 텍스트는 농담의 일부였다.

모두가 영리한 속임수였습니다. 물론, 저는 그 속임수가 토마스 박의 호의로 CSS로 가는 길을 만드는 것을 보게 되어 기쁩니다.


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video controls="" src="https://css-tricks.com/wp-content/uploads/2020/06/mad-magazine-fold-in-1.mp4" playsinline="" name="fitvid0"></video>
</div>


토머스가 단 하나의 상태(`:hover` / `:active`)로 할 수 있었다는 것에 상당히 놀랐습니다. 애니메이션 중에 3D 변형을 다른 위치로 조정하려면 `@keyframe`이 필요했을 것이라고 장담할 수 있지만, 여러 가지 전환(부모와 자녀 모두)이 이를 처리하는 것처럼 보입니다.

다른 멋진 CSS 종이 효과를 원하신다면...

여기 린 피셔의 새로운 것이 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_PoZpjOr" src="//codepen.io/anon/embed/PoZpjOr?height=450&amp;theme-id=1&amp;slug-hash=PoZpjOr&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed PoZpjOr" title="CodePen Embed PoZpjOr" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

맨디 마이클의 고전:

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_BWyYYP" src="//codepen.io/anon/embed/BWyYYP?height=450&amp;theme-id=1&amp;slug-hash=BWyYYP&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed BWyYYP" title="CodePen Embed BWyYYP" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

그리고 Mattia Astorino의 더 많은 접기:

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_jymEgr" src="//codepen.io/anon/embed/jymEgr?height=450&amp;theme-id=1&amp;slug-hash=jymEgr&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed jymEgr" title="CodePen Embed jymEgr" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

직접 링크 →