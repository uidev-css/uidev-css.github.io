---
layout: post
title: "CurtainsJS로 WebGL 효과 만들기
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/11/webgl-effects-curtainsjs.png
tags: CANVAS,CURTAINS.JS,SLIDER,WEBGL
---


이 문서는 이미 "완료된"웹 페이지의`<image>`및`<video>`요소에 WebGL 효과를 추가하는 데 중점을 둡니다.
 이 주제에 대한 몇 가지 유용한 리소스 (예 :이 두 가지)가 있지만 프로세스를 몇 단계로 정리하여이 주제를 단순화하는 데 도움이되기를 바랍니다.
 

- 평소처럼 웹 페이지를 만듭니다.
 
- WebGL 효과를 추가하려는 조각을 WebGL로 렌더링합니다.
 
- 사용할 WebGL 효과를 만들거나 찾습니다.
 
- 이벤트 리스너를 추가하여 페이지를 WebGL 효과와 연결합니다.
 

특히 일반 웹 페이지와 WebGL 간의 연결에 초점을 맞출 것입니다.
 우리는 무엇을 만들까요?
 대화 형 마우스 호버가있는 드래그 글 이미지 슬라이더는 어떻습니까!
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 650px;"><iframe id="cp_embed_3850c1db403e7c9acfad42ee1e440501" src="//codepen.io/anon/embed/3850c1db403e7c9acfad42ee1e440501?height=650&amp;theme-id=1&amp;slug-hash=3850c1db403e7c9acfad42ee1e440501&amp;default-tab=result" height="650" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed 3850c1db403e7c9acfad42ee1e440501" title="CodePen Embed 3850c1db403e7c9acfad42ee1e440501" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

슬라이더의 핵심 기능을 다루거나 WebGL 또는 GLSL 셰이더의 기술적 세부 사항에 대해서는 자세히 설명하지 않습니다.
 그러나 데모 코드에는 많은 주석이 있으며 자세히 알아 보려면 외부 리소스에 대한 링크가 있습니다.
 

현재 Safari 또는 Internet Explorer에서 작동하지 않는 최신 버전의 WebGL (WebGL2) 및 GLSL (GLSL 300)을 사용하고 있습니다.
 따라서 Firefox 또는 Chrome을 사용하여 데모를보십시오.
 프로덕션에서 다루는 내용을 사용할 계획이라면 GLSL 100 및 300 버전의 셰이더를 모두로드하고`curtains.renderer._isWebGL2`가 true 인 경우에만 GLSL 300 버전을 사용해야합니다.
 위의 데모에서이를 다룹니다.
 

### 먼저 평소처럼 웹 페이지를 만듭니다.
 

아시다시피, HTML과 CSS 등이 있습니다.
 이 경우 이미지 슬라이더를 만들고 있지만 이는 데모 용입니다.
 슬라이더를 만드는 방법에 대해서는 자세히 설명하지 않겠습니다 (Robin이 이에 대한 멋진 게시물을 올림).
 하지만 여기에 제가 합친 내용이 있습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 650px;"><iframe id="cp_embed_3a59057e77b12c564ae5ae32be8b4760" src="//codepen.io/anon/embed/3a59057e77b12c564ae5ae32be8b4760?height=650&amp;theme-id=1&amp;slug-hash=3a59057e77b12c564ae5ae32be8b4760&amp;default-tab=result" height="650" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed 3a59057e77b12c564ae5ae32be8b4760" title="CodePen Embed 3a59057e77b12c564ae5ae32be8b4760" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

- 각 슬라이드는 페이지의 전체 너비와 같습니다.
 
- 슬라이드를 드래그 한 후 슬라이더는 드래그 방향으로 계속 미끄러지면서 점차적으로 속도가 느려집니다.
 
- 운동량은 슬라이더를 끝점에서 가장 가까운 슬라이드로 스냅합니다.
 
- 각 슬라이드에는 드래그가 시작될 때 시작되는 이탈 애니메이션과 드래그가 중지 될 때 시작되는 시작 애니메이션이 있습니다.
 
- 슬라이더를 가리키면이 비디오와 유사한 호버 효과가 적용됩니다.
 

저는 GreenSock 애니메이션 플랫폼 (GSAP)의 열렬한 팬입니다.
 드래그 용 플러그인, 드래그 할 때 운동량을 활성화하는 플러그인, 텍스트를 한 줄로 분할하기위한 플러그인을 제공하기 때문에 여기에서 특히 유용합니다.
 GSAP로 슬라이더를 만드는 것이 불편하다면 위의 데모 코드에 익숙해지는 데 시간을 할애하는 것이 좋습니다.
 

다시 말하지만 이것은 단지 데모 용이지만 최소한 구성 요소에 대해 설명하고 싶었습니다.
 이것은 WebGL을 동기화 상태로 유지할 DOM 요소입니다.
 

### 다음으로 WebGL을 사용하여 WebGL 효과를 포함 할 조각을 렌더링합니다.
 

이제 WebGL에서 이미지를 렌더링해야합니다.
 이를 위해서는 다음이 필요합니다.
 

- 이미지를 GLSL 셰이더에 텍스처로로드합니다.
 
- 이미지에 대한 WebGL 평면을 만들고 이미지 텍스처를 평면에 올바르게 적용합니다.
 
- 이미지의 DOM 버전이있는 곳에 평면을 배치하고 올바르게 크기를 조정합니다.
 

세 번째 단계는 스크롤 및 사용자 상호 작용 중에 DOM 및 WebGL 부분을 동기화 상태로 유지하면서 WebGL 세계로 이식하려는 DOM 요소의 위치를 추적해야하기 때문에 순수 WebGL을 사용하는 경우 특히 중요하지 않습니다.
 

이 모든 것을 쉽게 수행 할 수 있도록 도와주는 라이브러리가 있습니다. CurtainsJS!
 WebGL 버전의 DOM 이미지 및 비디오를 쉽게 생성하고 다른 기능없이 동기화하는 유일한 라이브러리입니다 (하지만 그 점에 대해 잘못 입증 되었으면하므로 다른 사람을 알고 있으면 댓글을 남겨주세요.
 잘합니다).
 

Curtains를 사용하면 추가해야하는 모든 JavaScript가 있습니다.
 

```js
// Create a new curtains instance
const curtains = new Curtains({ container: "canvas", autoRender: false });
// Use a single rAF for both GSAP and Curtains
function renderScene() {
  curtains.render();
}
gsap.ticker.add(renderScene);
// Params passed to the curtains instance
const params = {
  vertexShaderID: "slider-planes-vs", // The vertex shader we want to use
  fragmentShaderID: "slider-planes-fs", // The fragment shader we want to use
  
 // Include any variables to update the WebGL state here
  uniforms: {
    // ...
  }
};
// Create a curtains plane for each slide
const planeElements = document.querySelectorAll(".slide");
planeElements.forEach((planeEl, i) => {
  const plane = curtains.addPlane(planeEl, params);
  // const plane = new Plane(curtains, planeEl, params); // v7 version
  // If our plane has been successfully created
  if(plane) {
    // onReady is called once our plane is ready and all its texture have been created
    plane.onReady(function() {
      // Add a "loaded" class to display the image container
      plane.htmlElement.closest(".slide").classList.add("loaded");
    });
  }
});
```

WebGL 플레인을 업데이트하도록`updateProgress` 함수도 업데이트해야합니다.
 

```js
function updateProgress() {
  // Update the actual slider
  animation.progress(wrapVal(this.x) / wrapWidth);
  
  // Update the WebGL slider planes
  planes.forEach(plane => plane.updatePosition());
}
```

또한로드중인 텍스처를 표시하려면 매우 기본적인 정점 및 조각 셰이더를 추가해야합니다.
 데모 에서처럼`<script>`태그를 통해로드하거나 최종 데모에서 볼 수 있듯이 백틱을 사용하여이를 수행 할 수 있습니다.
 

다시 말하지만,이 글은 이러한 GLSL 쉐이더의 기술적 측면에 대해 자세히 다루지 않을 것입니다.
 Codrops에 대한 The Book of Shaders 및 WebGL 주제를 시작점으로 읽는 것이 좋습니다.
 

셰이더에 대해 잘 모른다면 정점 셰이더가 평면을 배치하고 조각 셰이더가 텍스처의 픽셀을 처리한다고 말하는 것으로 충분합니다.
 지적하고 싶은 세 가지 변수 접두사도 있습니다.
 

- `in`은 데이터 버퍼에서 전달됩니다.
 버텍스 쉐이더에서는 CPU (우리 프로그램)에서 가져옵니다.
 조각 셰이더에서는 정점 셰이더에서 가져옵니다.
 
- `uniform`은 CPU (우리 프로그램)에서 전달됩니다.
 
- `out`은 셰이더의 출력입니다.
 버텍스 셰이더에서는 조각 셰이더로 전달됩니다.
 프래그먼트 셰이더에서는 프레임 버퍼 (화면에 그려지는 것)로 전달됩니다.
 

이 모든 것을 프로젝트에 추가하면 이전에는 똑같은 것이 있지만 이제 슬라이더가 WebGL을 통해 표시됩니다!
 산뜻한.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 650px;"><iframe id="cp_embed_f5b64ce930c4752ca8e367db2c076e2f" src="//codepen.io/anon/embed/f5b64ce930c4752ca8e367db2c076e2f?height=650&amp;theme-id=1&amp;slug-hash=f5b64ce930c4752ca8e367db2c076e2f&amp;default-tab=result" height="650" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed f5b64ce930c4752ca8e367db2c076e2f" title="CodePen Embed f5b64ce930c4752ca8e367db2c076e2f" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

CurtainsJS는 이미지와 비디오를 WebGL로 쉽게 변환합니다.
 텍스트에 WebGL 효과를 추가하는 방법에는 여러 가지가 있지만 가장 일반적인 방법은 텍스트를`<canvas>`에 그린 다음 셰이더에서 텍스처로 사용하는 것입니다 (예 : 1, 2).
 html2canvas (또는 유사)를 사용하여 대부분의 다른 HTML을 수행하고 해당 캔버스를 셰이더에서 텍스처로 사용할 수 있습니다.
 그러나 이것은 그다지 성능이 좋지 않습니다.
 

### 사용할 WebGL 효과 만들기 (또는 찾기)
 

이제 WebGL로 슬라이더를 렌더링하므로 WebGL 효과를 추가 할 수 있습니다.
 영감 비디오에서 본 효과를 분석해 보겠습니다.
 

- 이미지 색상이 반전됩니다.
 
- 마우스 위치 주변에는 정상적인 색상을 표시하고 어안 효과를 만드는 반경이 있습니다.
 
- 마우스 주변의 반경은 슬라이더를 가리키면 0에서 움직이고 더 이상 가리 키지 않으면 0으로 돌아갑니다.
 
- 반경은 마우스 위치로 이동하지 않고 시간이 지남에 따라 애니메이션됩니다.
 
- 전체 이미지는 이미지 중앙을 기준으로 마우스의 위치를 기준으로 변환됩니다.
 

WebGL 효과를 만들 때 셰이더에는 프레임 사이에 존재하는 메모리 상태가 없다는 점을 기억하는 것이 중요합니다.
 주어진 시간에 마우스가 어디에 있는지에 따라 무언가를 할 수는 있지만 마우스 자체가 어디에 있었는지에 따라 무언가를 할 수는 없습니다.
 그렇기 때문에 마우스가 슬라이더에 들어가면 반경을 애니메이션하거나 시간이 지남에 따라 반경 위치를 애니메이션하는 것과 같은 특정 효과의 경우 JavaScript 변수를 사용하고 해당 값을 슬라이더의 각 프레임에 전달해야합니다.
 다음 섹션에서 해당 프로세스에 대해 자세히 설명하겠습니다.
 

쉐이더를 수정하여 반경 외부의 색상을 반전하고 반경 내부에 어안 효과를 만들면 아래 데모와 같은 결과를 얻을 수 있습니다.
 다시 말하지만,이 기사의 요점은 DOM 요소와 WebGL 간의 연결에 초점을 맞추는 것이므로 셰이더에 대해 자세히 설명하지는 않지만 주석을 추가했습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 650px;"><iframe id="cp_embed_1a4c557fbaea5198f873d0fef444c5e3" src="//codepen.io/anon/embed/1a4c557fbaea5198f873d0fef444c5e3?height=650&amp;theme-id=1&amp;slug-hash=1a4c557fbaea5198f873d0fef444c5e3&amp;default-tab=result" height="650" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed 1a4c557fbaea5198f873d0fef444c5e3" title="CodePen Embed 1a4c557fbaea5198f873d0fef444c5e3" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

하지만 반경이 마우스에 반응하지 않기 때문에 아직 그렇게 흥미롭지는 않습니다.
 이것이 다음 섹션에서 다룰 내용입니다.
 

일반 웹 사이트에 사용하기 위해 미리 만들어진 WebGL 셰이더가 많은 저장소를 찾지 못했습니다.
 ShaderToy와 VertexShaderArt (정말 놀라운 셰이더가 있습니다!)가 있지만 둘 다 대부분의 웹 사이트에 맞는 효과 유형을 목표로하지 않습니다.
 누군가가 일상적인 사이트에서 작업하는 사람들을위한 리소스로 WebGL 셰이더의 저장소를 만드는 것을보고 싶습니다.
 알고 있다면 알려주세요.
 

### 페이지를 WebGL 효과와 연결하는 이벤트 리스너 추가
 

이제 WebGL 부분에 상호 작용을 추가 할 수 있습니다!
 셰이더에 일부 변수 (유니폼)를 전달하고 사용자가 요소와 상호 작용할 때 해당 변수에 영향을 주어야합니다.
 이 섹션은 JavaScript를 셰이더에 연결하는 방법의 핵심이기 때문에 가장 자세히 설명 할 섹션입니다.
 

먼저 셰이더에서 일부 유니폼을 선언해야합니다.
 버텍스 셰이더에서 마우스 위치 만 필요합니다.
 

```js
// The un-transformed mouse position
uniform vec2 uMouse;
```

조각 셰이더에서 반경과 해상도를 선언해야합니다.
 

```js
uniform float uRadius; // Radius of pixels to warp/invert
uniform vec2 uResolution; // Used in anti-aliasing
```

그런 다음 Curtains 인스턴스에 전달하는 매개 변수 내부에 이러한 값을 추가해 보겠습니다.
 우리는 이미`uResolution`을 위해 이것을하고있었습니다!
 셰이더에서 변수의 `이름`, `유형`, 시작 `값`을 지정해야합니다.
 

```js
const params = {
  vertexShaderID: "slider-planes-vs", // The vertex shader we want to use
  fragmentShaderID: "slider-planes-fs", // The fragment shader we want to use
  
  // The variables that we're going to be animating to update our WebGL state
  uniforms: {
    // For the cursor effects
    mouse: { 
      name: "uMouse", // The shader variable name
      type: "2f",     // The type for the variable - https://webglfundamentals.org/webgl/lessons/webgl-shaders-and-glsl.html
      value: mouse    // The initial value to use
    },
    radius: { 
      name: "uRadius",
      type: "1f",
      value: radius.val
    },
    
    // For the antialiasing
    resolution: { 
      name: "uResolution",
      type: "2f", 
      value: [innerWidth, innerHeight] 
    }
  },
};
```

이제 쉐이더`uniforms`가 JavaScript에 연결되었습니다!
 이 시점에서 셰이더로 전달하는 값에 영향을주는 이벤트 리스너와 애니메이션을 만들어야합니다.
 먼저 반지름에 대한 애니메이션을 설정하고 셰이더에 전달하는 값을 업데이트하는 함수를 설정하겠습니다.
 

```js
const radius = { val: 0.1 };
const radiusAnim = gsap.from(radius, { 
  val: 0, 
  duration: 0.3, 
  paused: true,
  onUpdate: updateRadius
});
function updateRadius() {
  planes.forEach((plane, i) => {
    plane.uniforms.radius.value = radius.val;
  });
}
```

반경 애니메이션을 재생하면 셰이더는 매 틱마다 새 값을 사용합니다.
 

또한 마우스 장치와 터치 스크린 모두 슬라이더 위에있을 때 마우스 위치를 업데이트해야합니다.
 여기에는 많은 코드가 있지만 매우 선형 적으로 살펴볼 수 있습니다.
 시간을내어 무슨 일이 일어나고 있는지 처리하십시오.
 

```js
const mouse = new Vec2(0, 0);
function addMouseListeners() {
  if ("ontouchstart" in window) {
    wrapper.addEventListener("touchstart", updateMouse, false);
    wrapper.addEventListener("touchmove", updateMouse, false);
    wrapper.addEventListener("blur", mouseOut, false);
  } else {
    wrapper.addEventListener("mousemove", updateMouse, false);
    wrapper.addEventListener("mouseleave", mouseOut, false);
  }
}
 
// Update the stored mouse position along with WebGL "mouse"
function updateMouse(e) {
  radiusAnim.play();
  
  if (e.changedTouches && e.changedTouches.length) {
    e.x = e.changedTouches[0].pageX;
    e.y = e.changedTouches[0].pageY;
  }
  if (e.x === undefined) {
    e.x = e.pageX;
    e.y = e.pageY;
  }
  
  mouse.x = e.x;
  mouse.y = e.y;
  
  updateWebGLMouse();
}
 
// Updates the mouse position for all planes
function updateWebGLMouse(dur) {
  // update the planes mouse position uniforms
  planes.forEach((plane, i) => {
    const webglMousePos = plane.mouseToPlaneCoords(mouse);
    updatePlaneMouse(plane, webglMousePos, dur);
  });
}
 
// Updates the mouse position for the given plane
function updatePlaneMouse(plane, endPos = new Vec2(0, 0), dur = 0.1) {
  gsap.to(plane.uniforms.mouse.value, {
    x: endPos.x,
    y: endPos.y,
    duration: dur,
    overwrite: true,
  });
}
 
// When the mouse leaves the slider, animate the WebGL "mouse" to the center of slider
function mouseOut(e) {
  planes.forEach((plane, i) => updatePlaneMouse(plane, new Vec2(0, 0), 1) );
  
  radiusAnim.reverse();
}
```

WebGL 마우스를 동기화 상태로 유지하려면 기존`updateProgress` 함수도 수정해야합니다.
 

```js
// Update the slider along with the necessary WebGL variables
function updateProgress() {
  // Update the actual slider
  animation.progress(wrapVal(this.x) / wrapWidth);
  
  // Update the WebGL slider planes
  planes.forEach(plane => plane.updatePosition());
  
  // Update the WebGL "mouse"
  updateWebGLMouse(0);
}
```

이제 우리는 불로 요리하고 있습니다!
 슬라이더는 이제 모든 요구 사항을 충족합니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 650px;"><iframe id="cp_embed_dce2bef6ef5ef41f551b06c71687f861" src="//codepen.io/anon/embed/dce2bef6ef5ef41f551b06c71687f861?height=650&amp;theme-id=1&amp;slug-hash=dce2bef6ef5ef41f551b06c71687f861&amp;default-tab=result" height="650" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed dce2bef6ef5ef41f551b06c71687f861" title="CodePen Embed dce2bef6ef5ef41f551b06c71687f861" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

애니메이션에 GSAP를 사용하는 두 가지 추가 이점은 `onComplete`와 같은 콜백에 대한 액세스를 제공하고 GSAP는 새로 고침 빈도 (예 :이 상황)에 관계없이 모든 것을 완벽하게 동기화합니다.
 

### 여기에서 가져 가세요!
 

물론 이것은 WebGL에있는 슬라이더로 할 수있는 일에 관해서는 빙산의 일각 일뿐입니다.
 예를 들어 난류 및 변위와 같은 일반적인 효과를 WebGL의 이미지에 추가 할 수 있습니다.
 변위 효과의 핵심 개념은 입력 소스로 사용하는 그래디언트 라이트 맵을 기반으로 픽셀을 이동하는 것입니다.
 이 텍스처 (제가 Jesper Landberg의이 변위 데모에서 가져온 것입니다. 따라 가야합니다)를 소스로 사용한 다음 셰이더에 연결할 수 있습니다.
 

이와 같은 텍스처 생성에 대한 자세한 내용은이 기사,이 트윗 및이 도구를 참조하십시오.
 이와 같은 이미지의 기존 저장소를 알지 못하지만 알고있는 경우 알려주십시오.
 

위의 텍스처를 연결하고 변위 파워와 강도를 애니메이션하여 시간이 지남에 따라 드래그 속도에 따라 달라지면 멋진 반 무작위이지만 자연스럽게 보이는 변위 효과가 생성됩니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 650px;"><iframe id="cp_embed_3850c1db403e7c9acfad42ee1e440501" src="//codepen.io/anon/embed/3850c1db403e7c9acfad42ee1e440501?height=650&amp;theme-id=1&amp;slug-hash=3850c1db403e7c9acfad42ee1e440501&amp;default-tab=result" height="650" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed 3850c1db403e7c9acfad42ee1e440501" title="CodePen Embed 3850c1db403e7c9acfad42ee1e440501" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

당신이 원하는 방식이라면 Curtains에 자체 React 버전이 있다는 점도 주목할 가치가 있습니다.
 

지금은 그게 전부입니다.
 이 기사에서 배운 것을 사용하여 무언가를 만들면보고 싶어요!
 Twitter를 통해 저와 연결하십시오.
 