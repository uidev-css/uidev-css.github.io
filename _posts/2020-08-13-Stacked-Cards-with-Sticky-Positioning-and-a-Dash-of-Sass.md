---
layout: post
title: "끈적끈적한 포지셔닝과 한바탕의 Sass가 포함된 스택형 카드"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/08/stacked-cards.png
tags: SCSS,STICKY
---


요전 날, 저는 코리 긴니반의 웹사이트에서 이 특별한 사랑스러운 부분을 발견했습니다. 스크롤할 때 카드모음이 서로 겹쳐져 있습니다.


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video controls="" muted="" poster="https://css-tricks.com/wp-content/uploads/2020/08/Screen-Shot-2020-08-12-at-4.11.47-PM.png" src="https://css-tricks.com/wp-content/uploads/2020/08/corey-stacked-cards.mp4" name="fitvid0"></video>
</div>


저는 자바스크립트가 얼마나 필요할지 궁금하기 시작했고, 제가 깨달았을 때 어떻게 만들 수 있는지 궁금했습니다. 아! 이건 `position: 끈적끈적`과 `sass` 소량의 작업일 겁니다. 그래서 코리가 어떻게 이런 짓을 했는지에 대해 깊이 생각하지 않고, 제가 직접 해보기로 결심했습니다.

먼저 카드의 기본 스타일:

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/08/Screen-Shot-2020-08-08-at-3.50.19-PM.png?resize=1024%2C731&ssl=1)

다음으로, 우리는 각각의 카드를 포장지 맨 위에 끈적끈적하게 만들어야 합니다. 이렇게 할 수 있습니다.

이제 우리는 다음과 같은 이점을 얻게 됩니다.


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video controls="" muted="" src="https://css-tricks.com/wp-content/uploads/2020/08/card-sticky-1-1.mp4" name="fitvid1"></video>
</div>


하지만 어떻게 각각의 요소들이 서로 겹쳐지는 것처럼 보이게 할 수 있을까요? 사스 마법을 사용해서 각 카드의 위치를 조정할 수 있습니다. 먼저 모든 카드 요소를 반복한 다음 각 반복에 따라 값을 변경합니다.

그래서 이 데모는 정말 매력적이죠. 제 스스로도 그렇게 말한다면,

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_a10a07290f047c4f553850f17e0c5c44" src="//codepen.io/anon/embed/a10a07290f047c4f553850f17e0c5c44?height=450&amp;theme-id=1&amp;slug-hash=a10a07290f047c4f553850f17e0c5c44&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed a10a07290f047c4f553850f17e0c5c44" title="CodePen Embed a10a07290f047c4f553850f17e0c5c44" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

그리고 우리가 가지고 있어! 우리는 상황을 개선하기 위해 몇 가지 시각적인 변화를 만들 수 있습니다. 예를 들어, 코리의 예처럼 각 카드의 `박스 섀도우`와 색상. 하지만 저는 여기서 계속 실험하고 싶었습니다. 카드 순서를 바꿔서 가로로 만들면 어떡하지?

이미 이 웹 사이트에서 이 작업을 수행하고 있습니다.


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video controls="" muted="" src="https://css-tricks.com/wp-content/uploads/2020/08/css-tricks-stacked.mp4" name="fitvid2"></video>
</div>


잠시 동안 실험한 후 플렉스 박스로 카드 순서를 바꿔 각 항목을 오른쪽에서 왼쪽으로 밀어 넣었습니다.

하지만 각 카드가 다른 각도로 나오도록 하고 싶어서 Sass 루프를 랜덤 기능으로 업데이트했습니다.

이는 대부분의 변경 사항이며 다음과 같은 결과로 이어집니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 600px;"><iframe id="cp_embed_58d3b4c22a7ae18565e29d097ee5dad9" src="//codepen.io/anon/embed/58d3b4c22a7ae18565e29d097ee5dad9?height=600&amp;theme-id=1&amp;slug-hash=58d3b4c22a7ae18565e29d097ee5dad9&amp;default-tab=result" height="600" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed 58d3b4c22a7ae18565e29d097ee5dad9" title="CodePen Embed 58d3b4c22a7ae18565e29d097ee5dad9" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

꽤 깔끔하죠? 나는 `위치: 끈적끈적`을 너무 좋아한다.