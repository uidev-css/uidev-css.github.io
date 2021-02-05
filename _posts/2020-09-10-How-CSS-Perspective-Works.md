---
layout: post
title: "CSS 관점 작동 방식"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/08/perspective-cubes.png
tags: PERSPECTIVE,PERSPECTIVE-ORIGIN,TRANSFORM
---


CSS 애니메이션을 만드는 것을 좋아하는 사람으로서, 제가 사용하는 가장 강력한 도구 중 하나는 `관점`입니다. 투시(pective) 속성은 자체적으로 3D 효과를 모두 얻을 수 없지만(기본 형상은 깊이를 가질 수 없으므로) 변환 속성을 사용하여 X, Y, Z축을 사용하여 물체를 3D 공간에서 이동하고 회전한 다음 투시(pective)를 사용하여 깊이를 제어할 수 있습니다.

이 글에서, 저는 완전히 애니메이션화된 3D 큐브를 만들기 위해 노력하는 바로 그 기본적인 것부터 `관점`의 개념을 설명하려고 합니다.

### 원근법

먼저 간단한 녹색 사각형으로 시작해서 세 개의 축으로 모두 옮기도록 하겠습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_fd773fc2f3c2c1efc0b13829c813ce63" src="//codepen.io/anon/embed/fd773fc2f3c2c1efc0b13829c813ce63?height=450&amp;theme-id=1&amp;slug-hash=fd773fc2f3c2c1efc0b13829c813ce63&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed fd773fc2f3c2c1efc0b13829c813ce63" title="CodePen Embed fd773fc2f3c2c1efc0b13829c813ce63" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

X축과 Y축에서 물체를 움직이는 것은 매우 간단하지만, Z축에서 물체를 움직이면 사각형이 그대로 유지되는 것처럼 보입니다. 왜냐하면 물체가 Z축에서 움직이면 애니메이션이 물체를 우리 쪽으로 더 가까이 이동시키고 그 다음에는 우리로부터 더 멀리 이동하지만, 사각형의 크기(및 위치)는 동일하게 유지됩니다. 바로 여기서 CSS의 관점 속성이 작동하게 됩니다.

원근법은 X축이나 Y축으로 이동할 때 사물에 영향을 주지 않지만 원근법(pective)은 사물이 우리 쪽으로 가까이 이동할 때 더 크게, 멀어질 때는 더 작게 보이게 한다. 네, "실제" 생활에서처럼요.

객체를 회전할 때도 동일한 효과가 발생합니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_2a968ececee7eb337ab45aa0b0792edd" src="//codepen.io/anon/embed/2a968ececee7eb337ab45aa0b0792edd?height=450&amp;theme-id=1&amp;slug-hash=2a968ececee7eb337ab45aa0b0792edd&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed 2a968ececee7eb337ab45aa0b0792edd" title="CodePen Embed 2a968ececee7eb337ab45aa0b0792edd" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

Z축에서 사각형을 회전하는 것은 우리 모두가 알고 사랑하는 규칙적인 회전처럼 보이지만, X축이나 Y축에서 사각형을 회전할 때(원근법을 사용하지 않고) 사각형이 회전하는 것이 아니라 작아지는 것처럼 보일 뿐이다. 그러나 `관점`을 더하면 광장이 회전할 때 광장의 가까운 쪽이 더 크게 보이고, 더 먼 쪽이 더 작게 보이고, 회전도 예상대로 보인다는 것을 알 수 있다.

X 또는 Y 축에서 물체의 회전 속도가 90°(또는 270°, 450°, 630° 등)일 때 물체는 시야에서 "사라진다"는 점에 유의하십시오. 다시 말하지만, 물체에 깊이를 추가할 수 없으며, 이 위치에서 사각형의 너비(또는 높이)는 실제로 0이 되기 때문입니다.

### 원근 값

우리는 `관점` 속성을 가치로 설정할 필요가 있다. 이 값은 물체의 평면으로부터의 거리, 즉 원근 강도의 값을 설정합니다. 값이 클수록 개체로부터 멀어지고 값이 작을수록 원근감이 더 뚜렷해집니다.

`관측 출처` 속성은 개체를 "보고" 있는 위치를 결정합니다. 원점이 가운데에 있고(기본값) 개체가 오른쪽으로 이동하면 왼쪽에서 원점을 보는 것처럼 보이고 그 반대도 마찬가지입니다.

또는 개체를 가운데로 두고 `관점 원점`을 이동할 수 있습니다. 원점을 옆으로 설정하면, 그 쪽에서 물체를 "보고" 있는 것과 같습니다. 값이 클수록 더 멀리 볼 수 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_db5f120940371ef81f3f337dcbca61b4" src="//codepen.io/anon/embed/db5f120940371ef81f3f337dcbca61b4?height=450&amp;theme-id=1&amp;slug-hash=db5f120940371ef81f3f337dcbca61b4&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed db5f120940371ef81f3f337dcbca61b4" title="CodePen Embed db5f120940371ef81f3f337dcbca61b4" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

원소의 상위 컨테이너에 `관점`과 `관점-원점`이 둘 다 설정되어 있고 소멸 지점의 위치(즉, 물체를 "보는" 위치에서 멀어지는)를 결정하는 반면, 객체의 위치와 회전은 객체에 선언된 `변환` 속성을 사용하여 설정됩니다.본연의 모습을 드러내다

앞의 예에서 제가 정사각형을 한 쪽에서 다른 쪽으로 옮긴 코드를 보면 X축을 따라 움직이기 원했기 때문에 `번역 X()` 기능을 사용했다는 것을 알 수 있습니다. 변환 속성에 할당되어 있습니다. 함수는 변환할 요소에 직접 적용되지만 상위 요소에 할당된 투시 규칙에 따라 동작하는 변환 유형입니다.

우리는 여러 기능을 변환 속성에 "연결"할 수 있다. 그러나 다중 변환을 사용할 때 고려해야 할 세 가지 중요한 사항이 있습니다.

- 물체를 회전시킬 때 좌표계는 물체와 함께 변환된다.
- 객체를 변환하는 경우, 객체는 상위 좌표계가 아닌 자체 좌표계를 기준으로 이동합니다.
- 이러한 값이 기록되는 순서는 최종 결과를 변경할 수 있습니다.

이전 데모에서 내가 찾던 효과를 얻기 위해서는 먼저 X축의 정사각형을 번역해야 했습니다. 그제서야 회전시킬 수 있었다. 만약 이 작업이 반대로 이루어졌더라면(먼저 회전한 다음 번역) 결과는 완전히 달라졌을 것입니다.

가치의 순서가 변환 속성에 얼마나 중요한지 설명하기 위해 몇 가지 간단한 예를 들어보자. 첫째, 두 제곱의 간단한 2차원(2D) 변환. 두 제곱은 모두 동일한 변환 값을 가지지만 서로 다른 순서로 선언됩니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_36700c92aaafb432ebe2efb69d26d7a8" src="//codepen.io/anon/embed/36700c92aaafb432ebe2efb69d26d7a8?height=450&amp;theme-id=1&amp;slug-hash=36700c92aaafb432ebe2efb69d26d7a8&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed 36700c92aaafb432ebe2efb69d26d7a8" title="CodePen Embed 36700c92aaafb432ebe2efb69d26d7a8" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

Y축의 사각형을 회전해도 마찬가지입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 500px;"><iframe id="cp_embed_30915da2edd9aec0da926a21f4e35dfb" src="//codepen.io/anon/embed/30915da2edd9aec0da926a21f4e35dfb?height=500&amp;theme-id=1&amp;slug-hash=30915da2edd9aec0da926a21f4e35dfb&amp;default-tab=result" height="500" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed 30915da2edd9aec0da926a21f4e35dfb" title="CodePen Embed 30915da2edd9aec0da926a21f4e35dfb" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

값의 순서가 중요하지만, 값의 순서를 바꾸는 대신 우리가 원하는 결과를 얻기 위해 단순히 값 자체를 바꿀 수 있다는 점에 유의해야 한다. 예를 들면…

```css
transform: translateX(100px) rotateY(90deg);
```

…의 효과는 다음과 같습니다.

```css
transform: rotateY(90deg) translate<strong>Z(100px);
```

왜냐하면 첫 번째 선에서는 물체를 회전시키기 전에 X축으로 옮겼지만, 두 번째 선에서는 물체를 회전시키고 좌표를 바꾼 다음 Z축으로 옮겼기 때문입니다. 같은 결과, 다른 값.

### 좀 더 재미있는 것을 보자.

물론, 정사각형은 원근의 일반적인 개념을 설명하는 좋은 방법이지만, 우리는 3차원(3D) 모양으로 쪼개졌을 때 원근법이 어떻게 작용하는지를 실제로 보기 시작합니다.

지금까지 살펴본 모든 것을 사용하여 3D 큐브를 구축해 봅시다.

우리는 .cube 요소를 감싸는 .container 요소를 만들 것입니다. 이 요소는 큐브의 측면을 나타내는 6개의 요소로 구성됩니다.

```html
<div class="container">
  <div class="cube">
    <div class="side front"></div>
    <div class="side back"></div>
    <div class="side left"></div>
    <div class="side right"></div>
    <div class="side top"></div>
    <div class="side bottom"></div>
  </div>
</div>
```

먼저 상위 `.container` 요소에 관점을 추가하겠습니다. 그러면 `.cube` 요소는 200px의 변을 가지고 있고 3D 변환을 존중할 것입니다. 여기에 몇 가지 프레젠테이션 스타일을 추가하고 있지만 주요 속성이 강조 표시되어 있습니다.

```css
/* The parent container, with perspective */
.container {
  width: 400px;
  height: 400px;
  border: 2px solid white;
  border-radius: 4px;
  display: flex;
  justify-content: center;
  align-items: center;
  perspective: 800px;
  perspective-origin: top right;
}

/* The child element, with 3D tranforms preserved */
.cube {
  position: relative;
  width: 200px;
  height: 200px;
  transform-style: preserve-3d;
}

/* The sides of the cube, absolutely positioned */
.side {
  position: absolute;
  width: 100%;
  height: 100%;
  opacity: 0.9;
  border: 2px solid white;
}

/* Background colors for the cube's sides to help visualize the work */
.front { background-color: #d50000; }
.back { background-color: #aa00ff; }

.left { background-color: #304ffe; }
.right { background-color: #0091ea; }

.top { background-color: #00bfa5; }
.bottom { background-color: #64dd17; } 
 
 
 

```

앞면이 제일 쉬워요. 100px만큼 앞당기겠습니다.

```css
.front {
  background-color: #d50000;
  transform: translateZ(100px);
}
```

우리는 `번역 Z(-100px)`를 추가하여 큐브의 뒷면을 뒤로 이동할 수 있다. 또 다른 방법은 측면 180도를 회전한 후 앞으로 이동하는 것입니다.

```css
.back {
  background-color: #aa00ff;
  transform: translateZ(-100px);
 
  /* or */
  /* transform: rotateY(180deg) translateZ(100px); */
}
```

뒷면처럼 왼쪽과 오른쪽을 바꿀 수 있는 몇 가지 방법이 있습니다.

```css
.left {
  background-color: #304ffe;
  transform: rotateY(90deg) translateZ(100px);
 
  /* or */
  /* transform: translateX(100px) rotateY(90deg); */
}

.right {
  background-color: #0091ea;
  transform: rotateY(-90deg) translateZ(100px);
 
  /* or */
  /* transform: translateX(-100px) rotateY(90deg); */
}
```

윗부분과 아랫부분이 조금 달라요. Y축에서 회전시키는 대신 X축에서 회전시켜야 합니다. 두 가지 방법으로 수행할 수 있습니다.

```css
.top {
  background-color: #00Bfa5;
  transform: rotateX(90deg) translateZ(100px);
 
  /* or */
  /* transform: translateY(-100px) rotateX(90deg); */
}
 
.bottom {
  background-color: #64dd17;
  transform: rotateX(-90deg) translateZ(100px);
 
  /* or */
  /* transform: translateY(100px) rotateX(90deg); */
}
```

이렇게 하면 3D 큐브를 얻을 수 있어요.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_44b2c7661a9db555a5714322dd129657" src="//codepen.io/anon/embed/44b2c7661a9db555a5714322dd129657?height=450&amp;theme-id=1&amp;slug-hash=44b2c7661a9db555a5714322dd129657&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed 44b2c7661a9db555a5714322dd129657" title="CodePen Embed 44b2c7661a9db555a5714322dd129657" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

`관점`과 `관점-원점`에 대한 다양한 옵션을 자유롭게 사용하여 큐브에 어떤 영향을 미치는지 살펴보십시오.

큐브에 멋진 애니메이션을 추가해 보겠습니다. 먼저 `트랜스포머 스타일`의 특성에 대해 이야기해 보겠습니다. 제가 아까 일반 CSS에 추가했는데, 이게 뭔지, 어떤 기능을 하는지 제대로 설명하지 않았어요.

변환 스타일 속성에는 다음 두 가지 값이 있습니다.

- `flat`(기본값)
- 1912-3d

자산을 `preserve-3d`로 설정하면 두 가지 중요한 작업이 수행됩니다.

- 큐브의 측면(하위 요소)을 큐브와 동일한 3D 공간에 배치하도록 지시합니다. preserve-3d로 설정되어 있지 않으면 기본값은 flat으로 설정되고 정육면체 면은 평평해진다. 아이(측면)에게 큐브 원근감을 주고 큐브만 회전시킬 수 있어 각 면을 따로 애니메이션할 필요가 없다.
- DOM의 위치에 관계없이 3D 공간에서의 위치에 따라 하위 요소를 표시합니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_d0bc7f2e16c17243cde7c5397dc33f30" src="//codepen.io/anon/embed/d0bc7f2e16c17243cde7c5397dc33f30?height=450&amp;theme-id=1&amp;slug-hash=d0bc7f2e16c17243cde7c5397dc33f30&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed d0bc7f2e16c17243cde7c5397dc33f30" title="CodePen Embed d0bc7f2e16c17243cde7c5397dc33f30" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이 예제에는 녹색, 빨간색 및 파란색의 세 개의 정사각형이 있습니다. 녹색 사각형의 `번역 Z` 값은 100px로 다른 사각형의 앞에 있음을 의미합니다. 파란색 정사각형은 번역 Z가 -100px로 다른 정사각형의 뒤에 있다는 뜻이다.

그러나 DOM에서 정사각형의 순서는 녹색, 빨간색, 파란색입니다. 따라서 변환 스타일을 플랫(또는 전혀 설정하지 않음)으로 설정하면 파란색 사각형이 맨 위에 나타나고 녹색 사각형이 맨 뒤에 나타나는데, 이는 DOM의 순서이기 때문이다. 그러나 만약 우리가 `변형식`을 `보존-3d`로 설정하면, 3D 공간에서의 위치에 따라 변하게 될 것이다. 이에 따라 녹색광장은 앞에, 파란색광장은 뒤에 있게 된다.

이제 큐브를 애니메이션으로 만들어봅시다! 그리고 좀 더 흥미롭게 만들기 위해, 우리는 세 축 모두에 애니메이션을 추가할 것입니다. 먼저 애니메이션 속성을 .cube에 추가할 것입니다. 애니메이션 키프레임을 정의하지 않았기 때문에 아직 아무 효과가 없을 것입니다. 하지만 애니메이션 키프레임을 정의할 때는 사용할 수 있습니다.

```css
animation: cubeRotate 10s linear infinite;
```

이제 키 프레임입니다. 우리는 기본적으로 큐브를 각 축을 따라 회전시켜 우주 공간에서 구르는 것처럼 보이도록 할 것입니다.

```css
@keyframes cubeRotate {
  from { transform: rotateY(0deg) rotateX(720deg) rotateZ(0deg); }
  to { transform: rotateY(360deg) rotateX(0deg) rotateZ(360deg); }
}
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 500px;"><iframe id="cp_embed_f92d8cab824fa46174961909ab87771c" src="//codepen.io/anon/embed/f92d8cab824fa46174961909ab87771c?height=500&amp;theme-id=1&amp;slug-hash=f92d8cab824fa46174961909ab87771c&amp;default-tab=result" height="500" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed f92d8cab824fa46174961909ab87771c" title="CodePen Embed f92d8cab824fa46174961909ab87771c" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

`관점`적 특성은 실제로 애니메이션에 그 깊이를 부여하는데, 마치 큐브 롤이 앞뒤로 움직이는 것을 보는 것 같다.

그러나 지금까지는 관점의 가치가 일정했고, 관점의 기원도 마찬가지였다. 이러한 값을 변경하면 큐브의 모양에 어떤 영향을 미치는지 살펴보겠습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 650px;"><iframe id="cp_embed_8987ff9244e30856aff23b1d2ea4fb8f" src="//codepen.io/anon/embed/8987ff9244e30856aff23b1d2ea4fb8f?height=650&amp;theme-id=1&amp;slug-hash=8987ff9244e30856aff23b1d2ea4fb8f&amp;default-tab=result" height="650" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed 8987ff9244e30856aff23b1d2ea4fb8f" title="CodePen Embed 8987ff9244e30856aff23b1d2ea4fb8f" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

다른 값이 큐브의 관점에 어떤 영향을 미치는지 알아보기 위해 이 예제에 슬라이더 3개를 추가했습니다.

- 왼쪽 슬라이더는 `관점` 속성의 값을 설정합니다. 이 값은 객체 평면으로부터의 거리를 설정하므로 값이 작을수록 원근 효과가 더 두드러집니다.
- 나머지 두 슬라이더는 `관점-원점` 속성을 지칭한다. 오른쪽 슬라이더는 위에서 아래로 수직 축에서 원점을 설정하고, 아래쪽 슬라이더는 오른쪽에서 왼쪽으로 수평 축에서 원점을 설정합니다.

애니메이션이 실행되는 동안 큐브 자체가 회전할 때 이러한 변경 사항이 덜 눈에 띄겠지만 "Run animation(애니메이션 실행)" 버튼을 클릭하여 쉽게 애니메이션을 끌 수 있습니다.

이 값들을 가지고 놀고 그것들이 큐브의 모양에 어떤 영향을 미치는지 알아보세요. 올바른 값은 하나도 없으며, 이러한 값은 애니메이션, 개체의 크기 및 원하는 효과에 따라 달라지기 때문에 프로젝트마다 다릅니다.

### 그럼 다음은 뭘까?

이제 CSS에서 `관점` 속성의 기본을 익혔으므로 상상력과 창의력을 발휘하여 자신의 프로젝트에 3D 개체를 만들 수 있으며 단추, 메뉴, 입력 정보 및 "생기도록" 원하는 그 밖의 모든 항목에 깊이와 흥미를 더할 수 있습니다.

한편, 여러분은 이와 같은 복잡한 구조와 시각 기반 애니메이션을 만들도록 노력함으로써 여러분의 기술을 연습하고 향상시킬 수 있습니다.

![image](https://amitsh.com/2020/imglogger?img=perspective.jpg)

저는 여러분이 이 기사를 재미있게 읽었고 그 과정에서 새로운 것을 배웠기를 바랍니다! 이 글의 관점이나 다른 주제에 대해 궁금한 점이 있으면 언제든지 의견을 남겨 당신의 생각을 알려주거나 트위터에 한 줄 적어주세요.