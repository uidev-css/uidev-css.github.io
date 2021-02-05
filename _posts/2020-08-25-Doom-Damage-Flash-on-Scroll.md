---
layout: post
title: "스크롤 시 Doom Damage Flash"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/08/doom.png
tags: SCROLLING
---


네가 맞았을 때 둠이 화면을 빨갛게 비추기로 유명했던 비디오 게임이야. Chris Johnson은 그 아이디어를 받아들였을 뿐만 아니라, Doom의 UI를 이 unge-in-chek 자바스크립트 라이브러리에 통합했습니다. 알았어요? 둠 스크롤링처럼, 둠 스크롤링처럼. 웃겨요, 절 믿으세요.

저는 크리스의 멋진 프로젝트에서 손상 애니메이션 자체에 초점을 맞추기 위해 비트를 추출했습니다. 빨간색 플래시는 HTML과 CSS로 처리된다. 먼저 전체 화면 오버레이를 만듭니다.

```html
#doom-damage {
  background-color: red;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  opacity: 0;
  pointer-events: none;
}
```

`표시: 없음`이 아닙니다. 애니메이션을 적용하기 위해서는 애니메이션이 완성될 때까지 기다려야 하기 때문에 애니메이션이 훨씬 어렵습니다. 왜냐하면 `디스플레이`는 애니메이션이 아니기 때문이다. 그건 할 수 있어, 그냥 짜증나.

플래시를 사용하기 위해 일시적으로만 하는 클래스를 적용하겠습니다.

```css
const damage = document.getElementById("doom-damage");

function doomTakeDamage() {
  damage.classList.add("do-damage");
  setTimeout(function () {
    damage.classList.remove("do-damage");
  }, 400);
}
```

이 클래스가 활성화되면 즉시 화면을 빨간색으로 전환한 다음 빨간색이 사라집니다.

```css
.do-damage {
  background-color: red;
  animation: 0.4s doom-damage forwards;
}

@keyframes doom-damage {
  0% {
    opacity: 1;
  }
  100% {
    opacity: 0;
  }
}
```

다음 비트는 손상의 섬광을 일으키는 기능을 호출합니다. 기본적으로 현재 스크롤 위치를 추적하고 다음 Damage Position을 지나면 빨간색으로 깜박이며 다음 Damage Position을 전체 화면 높이에서 한 번 떨어진 곳에 재설정합니다.

여러분이 이 모든 것을 보고 싶다면, 제가 펜으로 추상화했습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_jOqrgeB" src="//codepen.io/anon/embed/jOqrgeB?height=450&amp;theme-id=1&amp;slug-hash=jOqrgeB&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed jOqrgeB" title="CodePen Embed jOqrgeB" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>