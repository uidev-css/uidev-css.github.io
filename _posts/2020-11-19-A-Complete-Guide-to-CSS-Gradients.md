---
layout: post
title: "CSS 그라디언트에 대한 완전한 가이드"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/11/css-gradient.png
tags: 
---


CSS에서`background-color` 속성을 사용하여 단색 배경을 선언하는 방법과 마찬가지로`background-image` 속성을 사용하여 이미지 파일을 배경으로 선언 할뿐만 아니라 그라디언트도 사용할 수 있습니다.
 CSS 그래디언트를 사용하면 실제 이미지 (그래디언트) 파일을 사용하는 것보다 제어 및 성능이 더 좋습니다.
 

그라디언트는 일반적으로 다른 색상으로 페이드되는 하나의 색상이지만 CSS를 사용하면 방향과 모양에서 색상에 이르기까지, 색상이 서로 전환되는 방식에 대한 모든 측면을 제어 할 수 있습니다.
 실제로 선형, 방사형 및 원추형의 세 가지 유형의 그라디언트가 있습니다.
 각각의 기본 구문은 다음과 같습니다.
 

```css
/* Basic linear gradient examples */
background-image: linear-gradient(#ff8a00, #e52e71);
background-image: linear-gradient(to right, violet, darkred, purple);
background-image: linear-gradient(40deg, rgb(255 0 0) 60%, orange);

/* Basic radial gradient examples */
background-image: radial-gradient(#ff8a00, #e52e71);
background-image: radial-gradient(circle at top right, #ff8a00, red, #e52e71);

/* Basic conic gradient examples */
background-image: conic-gradient(#ff8a00, #e52e71);
background-image: conic-gradient(red 50deg, yellow 100deg, lime 200deg, aqua, blue, magenta, red);
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 375px;"><iframe id="cp_embed_YzWdPdN" src="//codepen.io/anon/embed/YzWdPdN?height=375&amp;theme-id=1&amp;slug-hash=YzWdPdN&amp;default-tab=result" height="375" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed YzWdPdN" title="CodePen Embed YzWdPdN" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 선형 그래디언트
 

웹 디자인에서 볼 수있는 가장 일반적인 그라디언트 유형은`linear-gradient ()`일 것입니다.
 색상이 왼쪽에서 오른쪽으로, 위에서 아래로 또는 선택한 각도로 단일 방향으로 흐르기 때문에 `선형`이라고합니다.
 

### 방사형 그래디언트
 

방사형 그래디언트는 단일 지점에서 시작하여 바깥쪽으로 퍼진다는 점에서 선형 그래디언트와 다릅니다.
 그라디언트는 종종 광원을 시뮬레이션하는 데 사용되지만 항상 직선이 아닌 것으로 알고 있습니다.
 따라서 방사형 그래디언트의 색상 간 전환이 더욱 자연스럽게 보입니다.
 

### 원추형 그라디언트
 

원추형 그라데이션은 방사형 그라데이션과 유사합니다.
 둘 다 원형이며 요소의 중심을 색상 중지의 소스 포인트로 사용합니다.
 그러나 방사형 그래디언트의 색상 멈춤이 원의 중심에서 나오는 경우 원추형 그래디언트가 원 주위에 배치합니다.
 

위에서 바라 보는 원뿔 모양처럼 보이기 때문에 "원추형"이라고합니다.
 글쎄, 적어도 뚜렷한 각도가 제공되고 색상 값 간의 대비가 차이를 알 수있을만큼 충분히 클 때.
 

### 반복 그라디언트
 

반복되는 그래디언트는`linear-gradient ()`및`radial-gradient ()`표기법에서`color-stops`를 창의적으로 사용하여 이미 할 수있는 트릭을 사용하고이를 적용합니다.
 아이디어는 우리가 만든 그라디언트에서 패턴을 만들고 무한히 반복 할 수 있다는 것입니다.
 

### 트릭!
 

### 접근성
 

그래디언트는 `배경색`으로 작업하는 것처럼 배경색과 전경색의 대비를 고려해야합니다.
 비결은 그래디언트에 사용 된 모든 색상과 그 사이의 전환이 그 위에있는 콘텐츠의 가독성에 영향을주지 않도록하는 것입니다.
 여기서 대비 검사기를 사용하는 것이 편리합니다.
 

주시해야 할 다른 것이 있습니까?
 애니메이션.
 두 개의 단색 배경 색상 (예 : 마우스 오버시)간에 전환하는 것은 일반적으로 문제가되지 않습니다.
 그러나 `background-position`을 사용하여 그래디언트가 움직이는 것처럼 보이게하는 경우 `prefers-reduced-motion`미디어 쿼리를 고려하여 애니메이션이 올바른 사용자에게 제공되도록하는 것이 좋습니다.
 

### 사양
 verified_user

- CSS 이미지 모듈 레벨 3 (최신)
 
- CSS 이미지 모듈 레벨 3 (편집자 초안)
 

### 관련 속성
 