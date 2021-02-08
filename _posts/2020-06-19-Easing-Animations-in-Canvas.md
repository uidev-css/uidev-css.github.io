---
layout: post
title: "캔버스의 애니메이션 완화"
author: "Uidev Css"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/06/solitaire.png"
tags: ANIMATION,CANVAS,EASING
---


HTML의 <캔버스> 요소와 자바스크립트의 Canvas API가 결합되어 웹 상에서 주요한 래스터 그래픽과 애니메이션의 가능성 중 하나를 형성한다. 일반적인 캔버스 사용 사례는 웹 사이트, 특히 게임에 대한 이미지를 프로그래밍 방식으로 생성하는 것이다. 그것이 바로 제가 솔리타이어를 연주하기 위해 만든 웹사이트입니다. 모든 움직임을 포함한 카드들은 모두 캔버스로 되어 있다.

이 기사에서는 애니메이션이 더 부드럽게 보이도록 캔버스에 있는 애니메이션과 테크닉을 구체적으로 살펴봅시다. 우리는 특히 CSS에서처럼 캔버스에서 공짜로 얻을 수 없는 "이즈인"이나 "이즈아웃"과 같은 쉬운 전환을 살펴보기로 한다.

정적인 캔버스부터 시작해보죠. 저는 캔버스에 DOM에서 꺼낸 하나의 플레이 카드를 그렸습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_NWGyRyd" src="//codepen.io/anon/embed/NWGyRyd?height=450&amp;theme-id=1&amp;slug-hash=NWGyRyd&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed NWGyRyd" title="CodePen Embed NWGyRyd" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

기본적인 애니메이션부터 시작해보죠. 캔버스에 있는 플레이 카드를 옮기죠. 심지어 캔버스 안에서 처음부터 작업을 해야 하는 것과 같은 아주 기본적인 것들도, 우리가 사용할 수 있는 기능을 만들기 시작해야 할 것이다.

먼저 X 및 Y 좌표를 계산하는 데 도움이 되는 함수를 만듭니다.

```js
function getX(params) {
  let distance = params.xTo - params.xFrom;
  let steps = params.frames;
  let progress = params.frame;
  return distance / steps * progress;
}
 
function getY(params) {
  let distance = params.yTo - params.yFrom;
  let steps = params.frames;
  let progress = params.frame;
  return distance / steps * progress;
}
```

이렇게 하면 이미지가 애니메이션화될 때 위치 값을 업데이트하는 데 도움이 됩니다. 그런 다음 애니메이션이 완료될 때까지 캔버스를 다시 렌더링합니다. "AddImage() 방법에 다음 코드를 추가하여 이를 수행합니다.

```js
if (params.frame < params.frames) {
  params.frame = params.frame + 1;
  window.requestAnimationFrame(drawCanvas);
  window.requestAnimationFrame(addImage.bind(null, params))
}
```

이제 애니메이션이 나왔습니다! 우리는 매번 1단위씩 꾸준히 증가하는데, 이것을 선형 애니메이션이라고 부릅니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_OJyQbGE" src="//codepen.io/anon/embed/OJyQbGE?height=450&amp;theme-id=1&amp;slug-hash=OJyQbGE&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed OJyQbGE" title="CodePen Embed OJyQbGE" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

도형이 점 A에서 점 B로 선형적으로 이동하여 점 간의 동일한 속도를 유지하는 방법을 볼 수 있습니다. 기능적이지만 현실성이 부족합니다. 출발과 정지가 뒤죽박죽이다.

우리가 원하는 것은 물체가 가속(이완)하고 감속(이완)하는 것이기 때문에 마찰이나 중력 같은 것이 작동하게 되면 실제 물체가 무엇을 할지를 모방한다.

## JavaScript 완화 기능

우리는 "입방형"의 이완과 완화의 전환을 통해 이를 달성할 것입니다. 우리는 로버트 페너의 플래시 완화 기능에 있는 방정식 중 하나를 수정했습니다. 우리가 여기서 하고자 하는 것에 적합하도록 말이죠.

```js
function getEase(currentProgress, start, distance, steps) {
  currentProgress /= steps/2;
  if (currentProgress < 1) {
    return (distance/2)*(Math.pow(currentProgress, 3)) + start;
  }
  currentProgress -= 2;
  return distance/2*(Math.pow(currentProgress, 3)+ 2) + start;
}
```

이것을 우리 코드에 삽입하면, 큐빅이 쉬워져, 우리는 훨씬 더 부드러운 결과를 얻을 수 있다. 카드가 공간의 중앙을 향해 어떻게 속도를 내는지 알아본 후, 끝에 도달하면서 속도가 느려집니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_GRpQrVa" src="//codepen.io/anon/embed/GRpQrVa?height=450&amp;theme-id=1&amp;slug-hash=GRpQrVa&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed GRpQrVa" title="CodePen Embed GRpQrVa" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

## JavaScript를 통한 고급화

2차 또는 사인파 용이성으로 더 느린 가속도를 얻을 수 있습니다.

더 빠른 가속을 위해 5분위 또는 지수 용이성을 제공합니다.

### GSAP를 통한 더욱 정교한 애니메이션

자신만의 쉬운 기능을 굴리는 것도 재미있을 수 있지만, 더 많은 힘과 유연성을 원한다면 어떨까요? 사용자 지정 코드를 계속 작성할 수도 있고 더 강력한 라이브러리를 고려할 수도 있습니다. 이를 위해 GSAP(Green Sock Animation Platform)를 살펴보겠습니다.

GSAP를 사용하면 애니메이션 구현이 훨씬 쉬워집니다. 이 예를 들어, 마지막에 카드가 튀어 나옵니다. GSAP 라이브러리는 데모에 포함되어 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_RwWeMeN" src="//codepen.io/anon/embed/RwWeMeN?height=450&amp;theme-id=1&amp;slug-hash=RwWeMeN&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed RwWeMeN" title="CodePen Embed RwWeMeN" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

핵심 기능은 `moveCard`입니다.

```js
function moveCard() {
  gsap.to(position, {
    duration: 2,
    ease: "bounce.out",
    x: position.xMax, 
    y: position.yMax, 
    onUpdate: function() {
      draw();
    },
    onComplete: function() {
      position.x = position.origX;
      position.y = position.origY;
    }
  });
}
```

모든 마술이 일어나는 곳은 gsap.to 방식이다. 2초 동안 `위치` 객체가 업데이트되고 업데이트 때마다 다시 그릴 캔버스를 트리거링이라고 합니다.

그리고 우리는 단지 바운스에 대해서만 이야기하는 것이 아닙니다. 선택할 수 있는 수많은 다양한 완화 옵션들이 있다.

### 모든 것을 종합하다.

캔버스에서 어떤 애니메이션 스타일과 방법을 사용해야 하는지 아직 잘 모르십니까? 다음은 GSAP에서 제공되는 다양한 완화 애니메이션을 보여주는 펜입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_gOaVygx" src="//codepen.io/anon/embed/gOaVygx?height=450&amp;theme-id=1&amp;slug-hash=gOaVygx&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed gOaVygx" title="CodePen Embed gOaVygx" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

GSAP 이외의 애니메이션에 대한 라이브 데모를 보려면 내 Solitaire 카드 게임을 확인하십시오. 이 경우, 저는 게임의 카드가 더미 사이를 이동할 때 편안하고 편안해지기 위해 애니메이션을 추가했습니다.

모션 생성 외에도 불투명도, 회전 및 스케일링의 변화와 같이 시작 및 종료 상태가 있는 다른 속성에 완화 기능을 적용할 수 있습니다. 응용 프로그램이나 게임이 더 부드럽게 보이도록 쉬운 기능을 사용할 수 있는 많은 방법을 찾길 바랍니다.