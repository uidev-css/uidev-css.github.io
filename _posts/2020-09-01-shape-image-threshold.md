---
layout: post
title: "형상화 이미지 처리"
author: 'CSS Dev'
thumbnail: undefined
tags: 
---


CSS "shape-image-threshold" 속성은 CSS 요소의 부동 영역을 정의하기 위해 "shape-outside"를 사용할 때 화소가 이미지 모양에 포함되는 것을 설정한다.

CSS 셰이프의 부동 영역을 정의하기 위해 선형 그라데이션(gradient)을 사용한다고 가정합시다. 45° 각도에서 단색에서 투명한 색으로 변하는 것과 같은 것입니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/08/gradient-to-transparent.png?resize=239%2C239&ssl=1)

일반적으로, 우리는 그것을 요소의 배경 이미지라고 정의한다. 이 요소를 띄우고 일부 콘텐츠를 옆에 놓으면 그라데이션과 콘텐츠가 나란히 배치됩니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_qBZrWOx" src="//codepen.io/anon/embed/qBZrWOx?height=450&amp;theme-id=1&amp;slug-hash=qBZrWOx&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed qBZrWOx" title="CodePen Embed qBZrWOx" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

그러나 배경 이미지를 쉐이프 아웃사이드(shape-outside)로 바꾸면 그라데이션이 더 이상 나타나지 않고 그라데이션의 픽셀이 투명한 곳에 콘텐츠가 감싼다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 650px;"><iframe id="cp_embed_mdPWbpZ" src="//codepen.io/anon/embed/mdPWbpZ?height=650&amp;theme-id=1&amp;slug-hash=mdPWbpZ&amp;default-tab=result" height="650" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed mdPWbpZ" title="CodePen Embed mdPWbpZ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

하지만 텍스트는 모양을 좀 더 가까이 끌어안아야 한다고 생각해봅시다. 그것이 우리가 `모양-이미지-임계점`에 도달할 수 있는 부분이다. 우리는 반투명 픽셀을 포함함으로써 콘텐트가 투명 픽셀을 자연스럽게 감싸는 위치를 조정할 수 있습니다. 예를 들어, 형상 이미지 임계값 0.3은 형상의 부동 영역에서 30% 이상 불투명한 픽셀을 포함한다.

이번에는 그라데이션이 어떻게 작동하는지 보기 위해 그레이디언트를 포함하겠습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 850px;"><iframe id="cp_embed_ZEWezQL" src="//codepen.io/anon/embed/ZEWezQL?height=850&amp;theme-id=1&amp;slug-hash=ZEWezQL&amp;default-tab=result" height="850" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed ZEWezQL" title="CodePen Embed ZEWezQL" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

보이지? 두 번째 도형에 형상 이미지 임계값을 선언하고 값을 .15로 설정함으로써, 우리는 플로트 영역에 15% 이상 불투명 픽셀을 포함시켜 내용물이 도형을 약간 겹칠 수 있게 했다.

이 기능은 투명도를 사용하는 실제 이미지 파일로 외부 모양을 정의할 때도 작동합니다. 같은 거래요, 그냥 다른 모양으로 일해요.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 850px;"><iframe id="cp_embed_OJNpLjL" src="//codepen.io/anon/embed/OJNpLjL?height=850&amp;theme-id=1&amp;slug-hash=OJNpLjL&amp;default-tab=result" height="850" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed OJNpLjL" title="CodePen Embed OJNpLjL" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 구문

- 적용 대상: 부동액
- 상속됨: 아니요
- 초기값: 0.0
- 애니메이션 유형: 번호

### 가치

형상 영상 임계값은 0과 1 사이의 단일 알파 값을 허용하며, 여기서 0은 불투명도 수준 0%(완전 투명)의 등가이고 1은 불투명도 수준 100%(투명성 없음)의 등가입니다. 초기 값은 0.0입니다.

### 브라우저 지원

### 관련 속성

- 형체 변형
- 형체 변형

### 추가 정보

- CSS 도형 모듈 레벨 1 사양(편집자 초안)
- MDN 설명서