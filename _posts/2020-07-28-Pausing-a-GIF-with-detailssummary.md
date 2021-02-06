---
layout: post
title: "세부 정보/요약으로 GIF 일시 중지"
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/07/gif-play-pause.png"
tags: DETAILS/SUMMARY,GIF
---


스티브 포크너는 여기서 현명한 생각을 가지고 있다. (애니메이션) GIF를 보여주고 그 위에 일시 중지/재생 버튼을 덧씌울 수 있는데, 이는 정말로 `디테일`/`요약` 요소이다. 전환하면 (비애니메이션) JPG가 GIF를 커버하여 사실상 "일시 정지"합니다.

Adrian Roselli는 WCAG 성공 기준 2.2.2 일시정지, 중지, 숨기는 것을 "빠르고 더러운" 방법이라고 부른다.

포크를 만들고, JPG가 먼저 보이도록 모든 이미지를 바꾸고, 영상에 로딩="➡"을 붙였습니다. 재생을 명시적으로 누르기 전에는 GIF를 로드하지 않는 것처럼 보이므로 이 옵션도 다음과 같습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 550px;"><iframe id="cp_embed_pogQJER" src="//codepen.io/anon/embed/pogQJER?height=550&amp;theme-id=1&amp;slug-hash=pogQJER&amp;default-tab=html,result" height="550" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed pogQJER" title="CodePen Embed pogQJER" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>