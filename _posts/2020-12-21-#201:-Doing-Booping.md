---
layout: post
title: "# 201 : 부핑하기
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/12/boop-thumb.png
tags: 
---


비디오 다운로드
(MVP 서포터 만 오프라인보기를 위해 원본 고품질 녹음을 다운로드 할 수 있습니다.)
 

Joshua Comeau는“boop”(하이 파이브, Adam Kuhn)라는 용어를 군중으로 만들었습니다.
 호버 / 포커스 상태와 비슷하지만 그렇지 않다는 점이 다릅니다.
 링크, 버튼 등과 같은 사물에는 여전히 이러한 상태가 있어야합니다.
 "boop"는 마우스가 들어갔을 때 한 번 실행되고 마우스가 나가더라도 실행을 완료하고 (CSS에서는 실제로 할 수없는 일임) 잠재적으로 사용자의 다음 `마우스`에서 다시 실행되는 기발한 효과입니다.
 나중에 첫 번째 booping이 완료된 후.
 

Josh의 React 구현이 아니라 CSS에서 시작하여 얼마나 멀리 얻을 수 있는지 확인한 다음 대체 JavaScript 접근 방식을 살펴 보겠습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_PoGbvmV" src="//codepen.io/anon/embed/PoGbvmV?height=450&amp;theme-id=1&amp;slug-hash=PoGbvmV&amp;default-tab=js,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed PoGbvmV" title="CodePen Embed PoGbvmV" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

위의 펜에 우리가 그 과정에서 탐색 한 대체 방법에서 나온 몇 가지 의견을 남겼습니다.
 