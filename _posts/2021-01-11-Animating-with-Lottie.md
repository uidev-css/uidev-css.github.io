---
layout: post
title: "Lottie로 애니메이션"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2021/01/play-pause.jpg
tags: ANIMATION,LOTTIE
---


웹상의 애니메이션은 재미있을뿐만 아니라 사이트 방문자를 고객으로 전환시키는 방식으로 참여한다고 생각합니다.
 Twitter의 "좋아요"버튼을 생각해보십시오.
 트윗을 "좋아요"하면 하트 버튼 주위에 작은 다채로운 거품이 퍼지고 버튼 주위에 원으로 변하는 것처럼 보이며 최종 "좋아요"상태 인 빨간색 채우기로 설정됩니다.
 마음이 윤곽이 그려지 다가 가득 차면 훨씬 덜 흥미로울 것입니다.
 이러한 흥분과 만족은 애니메이션을 사용하여 사용자 경험을 향상시키는 완벽한 예입니다.

이 기사에서는 Lottie를 사용하여 웹에서 Adobe After Effects 애니메이션을 렌더링하는 개념을 소개합니다.이를 통해 Twitter 버튼과 같은 고급 애니메이션을 구현할 수 있습니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/FhJ7mbMU.gif?resize=700%2C350&ssl=1)

Bodymovin은 애니메이션을 JSON으로 내보내는 Adobe After Effects 용 플러그인이며 Lottie는 기본적으로 모바일 및 웹에서 애니메이션을 렌더링하는 라이브러리입니다.
 Hernan Torrisi가 만들었습니다.
 아, 애프터 이펙트를 사용하지 않는다고 생각하시는 분은이 기사가 저에게 맞지 않을 것입니다. 잠시만 기다려주십시오.
 After Effects도 사용하지 않지만 프로젝트에서 Lottie를 사용했습니다.

물론 웹에서 애니메이션을하기 위해 Lottie를 사용할 필요는 없습니다.
 대안은 애니메이션을 처음부터 디자인하는 것입니다.
 그러나 이는 특히 Lottie가 잘하는 복잡한 유형의 애니메이션의 경우 시간이 많이 소요될 수 있습니다.
 또 다른 대안은 GIF 애니메이션을 사용하는 것입니다. GIF 애니메이션은 표시 할 수있는 애니메이션 유형에는 제한이 없지만 일반적으로 Bodymovin이 생성하는 JSON 파일 크기의 두 배입니다.

그럼 여기로 이동하여 어떻게 작동하는지 살펴 보겠습니다.

### JSON 가져 오기

Lottie를 사용하려면 After Effects의 애니메이션이 포함 된 JSON 파일이 필요합니다.
 다행히도 Icons8에는 JSON, GIF 및 After Effects 형식으로 된 많은 무료 애니메이션 아이콘이 있습니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/R2_fthHg.png?resize=1600%2C1128&ssl=1)

### HTML에 스크립트 추가

또한 HTML에서 Bodymovin 플레이어의 JavaScript 라이브러리를 가져 와서`loadAnimation ()`메서드를 호출해야합니다.
 기본 사항은 다음과 같습니다.

```html
<div id="icon-container"></div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bodymovin/5.7.4/lottie.min.js">

<script>
  var animation = bodymovin.loadAnimation({
  // animationData: { /* ... */ },
  container: document.getElementById('icon-container'), // required
  path: 'data.json', // required
  renderer: 'svg', // required
  loop: true, // optional
  autoplay: true, // optional
  name: "Demo Animation", // optional
});
</script>
```

### 애니메이션 활성화

애니메이션이 컨테이너에로드 된 후 활성화되는 방법과 이벤트 리스너를 사용하여 활성화해야하는 작업으로 구성 할 수 있습니다.
 그녀는 우리가 함께 일해야하는 속성입니다.

- `container` : 애니메이션이로드되는 DOM 요소
- `path` : 애니메이션이 포함 된 JSON 파일의 상대 경로
- `renderer` : SVG, 캔버스 및 HTML을 포함한 애니메이션 형식
- `loop` : 애니메이션이 반복되어야하는지 여부를 지정하는 부울
- `autoplay` : 애니메이션이로드되는 즉시 재생할지 여부를 지정하는 부울
- `name` : 향후 참조를위한 애니메이션 이름

앞의 예에서`animationData` 속성이 주석 처리되어 있음에 유의하십시오.
 `path` 속성과 상호 배타적이며 내 보낸 애니메이션 데이터를 포함하는 객체입니다.

### 예를 들어 보겠습니다.

Icons8의이 애니메이션 재생 / 일시 중지 컨트롤 아이콘으로 Lottie를 사용하는 방법을 보여 드리고 싶습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2021/01/zVtNYzTs.gif?resize=200%2C200&ssl=1)

Bodymovin 플레이어 라이브러리는 여기에서 정적으로 호스팅되며 이러한 방식으로 HTML에 드롭 할 수 있지만 패키지로도 사용할 수 있습니다.

```terminal
npm install lottie-web ### or yarn add lottie-web
```

그런 다음 HTML 파일에 설치된 패키지의`dist` 폴더에있는 스크립트를 포함합니다.
 Skypack에서 라이브러리를 모듈로 가져올 수도 있습니다.

```js
import lottieWeb from "https://cdn.skypack.dev/lottie-web";
```

지금은 일시 중지 버튼이 루프에 있으며 자동으로 재생됩니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_WNxPWWX" src="//codepen.io/anon/embed/WNxPWWX?height=250&amp;theme-id=1&amp;slug-hash=WNxPWWX&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed WNxPWWX" title="CodePen Embed WNxPWWX" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

액션에 의해 애니메이션이 트리거되도록 변경해 보겠습니다.

### 트리거에서 애니메이션

`자동 재생`을 끄면 After Effects에서 내 보낸 방식이므로 정적 일시 중지 아이콘이 표시됩니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_VwjgOva" src="//codepen.io/anon/embed/VwjgOva?height=250&amp;theme-id=1&amp;slug-hash=VwjgOva&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed VwjgOva" title="CodePen Embed VwjgOva" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

하지만 걱정하지 마세요!
 Lottie는 애니메이션 인스턴스에 적용 할 수있는 몇 가지 방법을 제공합니다.
 즉, npm 패키지의 문서가 더 포괄적입니다.

여기서 몇 가지 작업을 수행해야합니다.

- 처음에는 "재생"상태로 표시합니다.
- 클릭시 "일시 중지"상태로 애니메이션
- 후속 클릭에서 둘 사이에 애니메이션을 적용합니다.

`goToAndStop (value, isFrame)`메소드가 여기에 적합합니다.
 애니메이션이 컨테이너에로드되면이 메서드는 애니메이션이 제공된 값으로 이동 한 다음 중지되도록 설정합니다.
 이 상황에서 우리는 재생 될 때 애니메이션 값을 찾아서 설정해야합니다.
 두 번째 매개 변수는 제공된 값이 시간 또는 프레임 기반인지 여부를 지정합니다.
 부울 유형이며 기본값은 `false`(즉, 시간 기반 값)입니다.
 애니메이션을 재생 프레임으로 설정하고 싶기 때문에 `true`로 설정합니다.

시간 기반 값은 애니메이션을 타임 라인의 특정 지점으로 설정합니다.
 예를 들어 애니메이션 시작 부분의 시간 값은 일시 중지되었을 때 `1`입니다.
 그러나 프레임 기반 값은 애니메이션을 특정 프레임 값으로 설정합니다.
 TechTerms에 따르면 프레임은 이미지 시퀀스의 개별 그림입니다.
 따라서 애니메이션의 프레임 값을 `5`로 설정하면 애니메이션의 5 번째 프레임 (이 상황에서는 `이미지 시퀀스`)으로 이동합니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_JjKxqNY" src="//codepen.io/anon/embed/JjKxqNY?height=250&amp;theme-id=1&amp;slug-hash=JjKxqNY&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed JjKxqNY" title="CodePen Embed JjKxqNY" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

다른 값을 시도한 후 프레임 값 11에서 16까지의 애니메이션 재생을 발견했습니다. 따라서 저는 14를 안전한 편으로 선택했습니다.

이제 애니메이션을 사용자가 클릭 할 때 일시 중지하고 사용자가 다시 클릭하면 재생되도록 변경하도록 설정해야합니다.
 다음으로`playSegments (segments, forceFlag)`메소드가 필요합니다.
 `segments` 매개 변수는 두 개의 숫자를 포함하는 배열 유형입니다.
 첫 번째와 두 번째 숫자는 메서드가 각각 읽어야하는 첫 번째와 마지막 프레임을 나타냅니다.
 `forceFlag`는 메서드를 즉시 실행해야하는지 여부를 나타내는 부울입니다.
 `false`로 설정하면 애니메이션이 트리거되기 전에 `세그먼트`배열의 첫 번째 프레임으로 지정된 값으로 애니메이션이 재생 될 때까지 기다립니다.
 true이면 세그먼트를 즉시 재생합니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_GRqzbza" src="//codepen.io/anon/embed/GRqzbza?height=250&amp;theme-id=1&amp;slug-hash=GRqzbza&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed GRqzbza" title="CodePen Embed GRqzbza" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

여기서는 재생에서 일시 중지로, 일시 중지에서 재생으로 세그먼트를 재생하는시기를 나타내는 플래그를 만들었습니다.
 즉각적인 전환을 원하기 때문에`forceFlag` 부울을`true`로 설정했습니다.

그래서 우리는 그것을 가지고 있습니다!
 After Effects에서 브라우저로 애니메이션을 렌더링했습니다!
 감사합니다 Lottie!

### 캔버스?

스케일링을 지원하고 가장 선명한 애니메이션을 렌더링하기 때문에 SVG를 내 렌더러로 사용하는 것을 선호합니다.
 캔버스는 그다지 멋지게 렌더링되지 않으며 크기 조정도 지원하지 않습니다.
 그러나 기존 캔버스를 사용하여 애니메이션을 렌더링하려면 몇 가지 추가 작업을 수행해야합니다.

### 더 많은 일을

애니메이션 인스턴스에는 애니메이션 작동 방식을 구성하는데도 사용할 수있는 이벤트도 있습니다.

예를 들어 아래의 Pen에서 애니메이션에 두 개의 이벤트 리스너를 추가하고 이벤트가 시작될 때 표시 할 텍스트를 설정했습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_NWRagbB" src="//codepen.io/anon/embed/NWRagbB?height=250&amp;theme-id=1&amp;slug-hash=NWRagbB&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed NWRagbB" title="CodePen Embed NWRagbB" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

모든 이벤트는 npm 패키지 문서에서 사용할 수 있습니다.
 내가 말한 것으로, 앞으로 나아가서 놀라운 애니메이션을 렌더링하십시오!