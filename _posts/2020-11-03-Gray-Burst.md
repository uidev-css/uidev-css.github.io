---
layout: post
title: "그레이 버스트
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/10/gray-burst.jpg
tags: GENERATOR,SVG
---


이 깔끔한 회색 버스트를 만들었습니다.
 특히 CodePen의 놀라운 창의력과 비교할 때 특별히 특별한 것은 아니지만 학습상의 이유로 그 안에서 일어나는 일 중 일부를 문서화 할 수 있다고 생각했습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_OJXNeyP" src="//codepen.io/anon/embed/OJXNeyP?height=450&amp;theme-id=1&amp;slug-hash=OJXNeyP&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed OJXNeyP" title="CodePen Embed OJXNeyP" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### SVG입니다
 

SVG에는`<line x1 y1 x2 y2>`가 있으므로이 버스트 모양에 사용하기 쉬울 것이라고 생각했습니다.
 x1 y1은 항상 중간이고 x2 y2는 무작위로 생성됩니다.
 `viewBox = "0 0 100 100"`을 사용하기 때문에 선을 배치하는 정신 수학은 매우 쉽습니다.
 좌표 `0 0`이 중간에 있도록 `-50-50100100`을 선호 할 수도 있습니다.
 

### 난수
 

```js
const getRandomInt = (min, max) => {
  min = Math.ceil(min);
  max = Math.floor(max);
  return Math.floor(Math.random() * (max - min + 1)) + min;
};
```

아트 생성에 사용할 수있는 것과 같은 기능이 있다는 것은 좋은 일입니다.
 선 위치뿐만 아니라 회색의 획 너비와 불투명도에도 사용합니다.
 

저는 그 함수를 너무 많이 사용해 왔기 때문에 네이티브 자바 스크립트가 그처럼 명확한 도우미 수학 함수를 가져야한다고 생각합니다.
 

### 템플릿 리터럴로 HTML을 생성하는 것은 매우 쉽습니다.
 

이것은 나에게 매우 읽기 쉽습니다.
 

```js
let newLines;
for (let i = 0; i < NUM_LINES; i++) {
  newLines += `
  <line 
    x1="50"
    y1="50"
    x2="${getRandomInt(10, 90)}"
    y2="${getRandomInt(10, 90)}"
    stroke="rgba(0, 0, 0, 0.${getRandomInt(0, 25)})"
    stroke-linecap="round"
    stroke-width="${getRandomInt(1, 2)}"
  />`;
}

svg.insertAdjacentHTML("afterbegin", newLines);
```

### 클릭하여 재생성하는 형태의 상호 작용
 

아트웍 그리기를 시작하는 단일 기능이있는 경우 클릭하여 다시 생성하는 것은 다음과 같이 쉽습니다.
 

```js
doArt();

window.addEventListener("click", doArt);
```

### 반올림
 

`stroke-linecap = "round"`가 훨씬 더 즐겁습니다.
 SVG의 획 끝으로 그렇게 할 수 있다는 것이 좋습니다.
 

### 선의 좌표는 움직이지 않고 CSS 변형 일뿐입니다.
 

나는 방금 이것을 줄에 댔다.
 

```css
line {
  transform-origin: center;
  animation: do 4s infinite alternate;
}
line:nth-child(6n) {
  animation-delay: -1s;
}
line:nth-child(6n + 1) {
  animation-delay: -2s;
}
line:nth-child(6n + 2) {
  animation-delay: -3s;
}
line:nth-child(6n + 3) {
  animation-delay: -4s;
}
line:nth-child(6n + 4) {
  animation-delay: -5s;
}

@keyframes do {
  100% {
    transform: scale(0.69);
  }
}
```

선이 길어지고 짧아지는 것처럼 보일 수 있지만 실제로는`scale ()`로 축소되는 전체 선입니다.
 선이 너비보다 훨씬 길기 때문에 선이 얇아지는 것을 거의 알아 차리지 못합니다.
 

부정적인 애니메이션 지연을 확인하십시오.
 애니메이션이 약간 무작위로 느껴지도록 엇갈리게 배치하는 것이지만 여전히 모두 동시에 시작되도록하는 것입니다.
 

### 다른 무엇을 할 수 있습니까?
 

- 색채가 멋질 수 있습니다.
 아마도 기뻐요?
 
- 나는 미학을 그룹화하는 아이디어를 좋아합니다.
 마찬가지로 모든 스트로크를 1-10 사이에서 무작위로 만들면 너무 무작위로 느껴지지만 1-2, 2-4 또는 8-10의 그룹간에 무작위로 지정하면 미학이 더 고려 된 느낌이 듭니다.
 색상 화와 마찬가지로 완전히 임의의 색상이 너무 임의적입니다.
 더 엄격한 매개 변수 내에서 무작위 화를 보는 것이 더 흥미로울 것입니다.
 
- 더 많은 움직임.
 회전?
 페이지 주변의 움직임?
 더 많은 버스트?
 
- 무엇보다도 데모 자체에서 더 많은 매개 변수를 가지고 플레이 할 수 있다는 것은 언제나 재미 있습니다.
 dat.GUI는 항상 멋지다.
 