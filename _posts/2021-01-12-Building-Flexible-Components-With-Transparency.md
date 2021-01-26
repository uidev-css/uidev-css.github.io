---
layout: post
title: "투명성으로 유연한 구성 요소 만들기"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2021/01/transparent-flexible.png
tags: 
---


구성 요소 색상 화에 대한 Cloudfour 블로그의 Paul Hebert의 좋은 생각.
 디자인 컴포지션을 보면 헤더 배경이`# dddddd`이고 콘텐츠 배경이`# ffffff` 인 카드 구성 요소가`# eeeeee`의 전체 배경에 표시 될 수 있습니다.
 좋아요, 충분히 쉽습니다.
 하지만 전체적인 배경이`# dddddd`가되면 어떨까요?
 이제 헤더가 손실 된 것처럼 보입니다.

더 어두운 헤더?
 디자인 측면에서 중요한 것은 정확히`# dddddd`가 아닙니다.
 배경보다 약간 어둡게 보입니다.
 이 경우 `rgba (0, 0, 0, 0.135)`와 같은 배경이 좀 더 resiliant입니다.

그런 다음 모든 종류의 배경에 대해 복원력이 유지됩니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 480px;"><iframe id="cp_embed_GRZaqYj" src="//codepen.io/anon/embed/GRZaqYj?height=480&amp;theme-id=1&amp;slug-hash=GRZaqYj&amp;default-tab=result" height="480" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed GRZaqYj" title="CodePen Embed GRZaqYj" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>