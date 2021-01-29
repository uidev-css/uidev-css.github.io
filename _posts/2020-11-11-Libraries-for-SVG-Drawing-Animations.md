---
layout: post
title: "SVG 드로잉 애니메이션 용 라이브러리"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/10/castle-svg-texture.jpg
tags: SVG,SVG ANIMATION
---


2013 년에 Jake Archibald는 SVG 경로를 그림처럼 보이도록 애니메이션하는이 멋진 트릭을 도입했습니다.
 지금은 2020 년이고 그 트릭은 여전히 인기가 있습니다.
 최근에 방문한 많은 웹 사이트에서 본 적이 있습니다.
 저도 아래에서 소개 할 라이브러리 중 하나를 사용하여 웹 사이트에 애니메이션 SVG 로더를 제공합니다.
 

이전 기사에서 Chris Coyier는 CSS`stroke-dasharray` 및`stroke-dashoffset` 속성을 사용하여 SVG 경로 애니메이션이 내부에서 작동하는 방식에 대해 썼습니다.
 이 기사에서는이 멋진 예제와 같이 더 적은 코드 줄로 SVG 경로 그리기 애니메이션을 만드는 데 사용할 수있는 네 가지 JavaScript 라이브러리를 소개하고자합니다.
 왜 도서관인가?
 경로가 여러 개인 2 개 이상의 SVG가 포함 된 복잡한 애니메이션에 이상 적이기 때문입니다.
 

시작하려면 먼저 데모 용 SVG를 보호하겠습니다.
 svgrepo에서이 성을 사용합시다.
 성 SVG는 SVG 이미지로 다운로드됩니다.
 하지만 경로 애니메이션을 다루기 때문에 SVG의 코드 형식이 필요합니다.
 이를 위해 파일을 Figma로 가져오고 "SVG로 복사"기능 (오른쪽 클릭 → 복사 / 붙여 넣기 → SVG로 복사)을 사용하여 SVG 코드를 가져옵니다.
 

SVG 경로를 성공적으로 애니메이션하려면 SVG 모양에 `채우기`가 `없음`이어야하며 각 개별 SVG 경로에는 `획`( `# B2441D`로 설정)과 `획 너비`가 있어야합니다.
 (2px로 설정).
 

우리가 만들고 싶은 애니메이션 효과는 먼저 SVG의 윤곽선 (또는 획)을 그린 다음 다른 색상을 채우는 것입니다.
 전체적으로 SVG 전체에 6 개의 다른 채우기 색상이 사용되므로 각 경로에서 채우기 색상을 제거하고 동일한 색상의 경로에 동일한 클래스 이름을 지정합니다.
 

- `# 695A69` :`color-1`
 
- `# B2441D` :`색상 -2`
 
- `# DFDOC6` :`color-3`
 
- `# C8B2A8` :`색상 -4`
 
- `# DE582A` :`color-5`
 
- `# AO8A8A` :`color-6`
 

모든 수정 후 SVG 코드는 다음과 같습니다.
 

```svg

<svg id="svg-castle" width="480" height="480" viewBox="0 0 480 480" fill="none" xmlns="http://www.w3.org/2000/svg">
  <path d="M231.111 183.761V150.371C231.111 149.553 231.774 148.889 232.592 148.889H24  7.407C248.225 148.889 248.889 149.552 248.889 150.371V183.761L258.342 206.667H271.111  V135.556H240H208.889V206.667H221.658L231.111 183.761Z" stroke="#B2441D" stroke-width="2px" class="color-6" />
  <path d="M311.111 420H288.889V455.556V468.889H311.111V455.556V420Z" stroke="#B2441D"   stroke-width="2px" class="color-1" />
  <path d="M191.111 420H168.889V455.556V468.889H191.111V455.556V420Z" stroke="#B2441D" stroke-width="2px" class="color-1" />
  <path d="M168.889 220V228.889V237.778H222.222V228.889H212.487L221.658 206.667H208.88   9H169.524L177.778 220H168.889Z" stroke="#B2441D" stroke-width="2px" class="color-2"/ >
  <!-- etc. -->
</svg>
```

이것이 우리에게 필요한 모든 SVG 준비입니다.
 다양한 라이브러리로 원하는 애니메이션을 얻는 방법을 살펴 보겠습니다.
 

### 라이브러리 1 : Vivus
 

Vivus는 SVG를 그리는 것처럼 애니메이션을 적용 할 수있는 경량 JavaScript 클래스 (종속성 없음)입니다.
 라이브러리는 이러한 옵션을 사용하여 사용할 수 있습니다.
 간단하게하기 위해 CDN 링크를 사용합니다.
 

```html
<script src="https://cdnjs.cloudflare.com/ajax/libs/vivus/0.4.5/vivus.min.js" integrity="sha512-NBLGIjYyAoYAr23l+dmAcUv7TvFj0XrqZoFa4i1o+F2VvF9SrERyMD8BHNnJn1SEGjl1AouBDcCv/q52L3ozBQ==" crossorigin="anonymous"></script>
```

다음으로 새 Vivus 인스턴스를 만들어 보겠습니다.
 세 가지 인수가 필요합니다.
 

- 대상 요소 (SVG)의 ID
 
- 가능한 값이 12 개있는`options` 객체
 
- 애니메이션이 끝날 때 실행되는 콜백 함수
 

SVG 코드를 되돌아 보면 SVG ID는`svg-castle`입니다.
 

```js
new Vivus('svg-castle', { 
  duration: 200, type:'oneByOne'
});
```

이제 정의한 다른 색상으로 경로를 채우는 콜백 함수를 작성해 보겠습니다.
 

```js
function fillPath(classname, color) {
  const paths = document.querySelectorAll(`#svg-castle .${classname}`);
  for (path of paths){
    path.style.fill = `${color}`;
  }
}
```

`fillPath` 함수는 제공된`classname`이있는`svg-castle` 요소의 모든 경로를 선택하고 지정된 색상으로 각 경로를 반복하고 채 웁니다.
 이전 단계에서 각 경로에서 채우기를 제거하고 각 경로에 동일한 채우기 클래스 (`color-1`,`color-2` 등)를 부여했습니다.
 

다음으로, 6 가지 클래스 이름과 해당 색상에 대해`fillPath` 함수를 호출합니다.
 

```js
function after() {
  fillPath('color-1', '#695a69');
  fillPath('color-2', '#b2441d');
  fillPath('color-3', '#dfd0c6');
  fillPath('color-4', '#c8b2a8');
  fillPath('color-5', '#de582a');
  fillPath('color-6', '#a08a8a')
}
```

이것이 Vivus 인스턴스에 전달 된 콜백 함수입니다.
 전체 구현은 Pen을 참조하십시오.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 600px;"><iframe id="cp_embed_ZEOYbJY" src="//codepen.io/anon/embed/ZEOYbJY?height=600&amp;theme-id=1&amp;slug-hash=ZEOYbJY&amp;default-tab=result" height="600" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed ZEOYbJY" title="CodePen Embed ZEOYbJY" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 라이브러리 2 : Walkway.js
 

Walkway는`path`,`line` 및`polygon` 요소를위한 경량 SVG 애니메이션 라이브러리입니다.
 사용을 시작하려면`npm`,`yarn`을 사용하거나 Vivus에서했던 것처럼 CDN 링크를 사용하여 라이브러리를 추가 할 수 있습니다.
 다시 한 번 CDN 링크로 이동합니다.
 

```html
<script src="https://cdn.jsdelivr.net/npm/walkway.js/src/walkway.min.js"></script>
```

Walkway를 사용하여`options` 객체를 인수로 전달하는 새`Walkway` 인스턴스를 만듭니다.
 그런 다음 새 인스턴스에서`draw` 메서드를 호출하고 그리기 애니메이션이 끝날 때 실행할 선택적 콜백 함수를 전달합니다.
 다시 말하지만 Vivus와 매우 유사합니다.
 

이전 예제에서 이미`after` 콜백 함수를 작성 했으므로 나머지는 케이크 조각이 될 것입니다.
 

```js
const svg = new Walkway({
  selector: '#svg-castle',
  duration: 3000,
});

svg.draw(after);
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 600px;"><iframe id="cp_embed_GRqRXzp" src="//codepen.io/anon/embed/GRqRXzp?height=600&amp;theme-id=1&amp;slug-hash=GRqRXzp&amp;default-tab=result" height="600" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed GRqRXzp" title="CodePen Embed GRqRXzp" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 라이브러리 3 : Lazy Line Painter
 

Lazy Line Painter는 SVG 경로 애니메이션을위한 최신 JavaScript 라이브러리입니다.
 설정하려면 최소한의 코드가 필요합니다.
 그러나 GUI가 더 필요한 경우 동일한 제작자의 SVG 경로 애니메이션을위한 무료 온라인 편집기 인 Lazy Line Composer를 사용할 수 있습니다.
 SVG는 어디서나 직접 사용할 수있는 애니메이션 SVG 파일로 내보내집니다.
 

![image](https://paper-attachments.dropbox.com/s_0F4B2A256F39C5890B6B94AAC9FE4B01766C23FFE67E01CCCC3AFEE79B29AB60_1602483495618_image.png)

Lazy Line Painter의 기본 설정은 다른 예제에서 이미 수행 한 것과 유사합니다.
 먼저 npm 또는 CDN 링크를 사용하여 라이브러리를 가져옵니다.
 이전 예와 마찬가지로 CDN 링크를 사용합니다.
 

```html
<script src="https://cdn.jsdelivr.net/npm/lazy-line-painter@1.9.4/lib/lazy-line-painter-1.9.4.min.js"></script>
```

그런 다음 두 개의 매개 변수를받는 새로운`LazyLinePainter` 인스턴스를 초기화합니다. 선택기 (대상 SVG 요소의 ID)와 구성 객체입니다.
 새 인스턴스에서 paint 메서드를 호출 해 보겠습니다.
 

```js
// select the svg by id
let svg = document.querySelector('#svg-castle')

// define config options
let options = {
  strokeDash: '2, 2',
}
// initialize new LazyLinePainter instance
let myAnimation = new LazyLinePainter(svg, options)

// call the paint method
myAnimation.paint()
```

구성 옵션의 전체 목록은 라이브러리 문서에서 사용할 수 있습니다.
 이전 라이브러리와 달리`paint` 메서드에 콜백 함수를 전달하지 않습니다.
 대신 애니메이션에서`complete : all` 이벤트 핸들러를 수신 한 다음 콜백 함수를 전달합니다.
 

```js
myAnimation.on('complete:all', (event) => {after()});
```

다음 코드 펜 데모에서 수행 한 것처럼 이벤트 리스너를 사용하여`paint` 메서드가 실행되는시기를 제어 할 수도 있습니다.
 애니메이션을 다시 실행하려면 성을 클릭하십시오.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 600px;"><iframe id="cp_embed_eYzmWyQ" src="//codepen.io/anon/embed/eYzmWyQ?height=600&amp;theme-id=1&amp;slug-hash=eYzmWyQ&amp;default-tab=result" height="600" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed eYzmWyQ" title="CodePen Embed eYzmWyQ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 라이브러리 4 : 프레이머 모션
 

Framer Motion은 우리가 다룬 다른 라이브러리와 약간 다릅니다.
 수많은 가능한 애니메이션 유형이있는 React 구성 요소를위한 프로덕션 준비가 완료된 오픈 소스 애니메이션 라이브러리입니다.
 그리고 네, 이것은 유명한 Framer 프로토 타이핑 도구를 만든 같은 팀에서 나왔습니다.
 

먼저 터미널에 npm을 사용하여 라이브러리를 설치합니다.
 

```terminal
npm install framer-motion
```

SVG 경로 그리기 애니메이션의 경우 Framer Motion은 네 가지 소품을 사용하는`motion.path` 구성 요소를 제공합니다.
 



이를 사용하려면 다음과 같이 SVG 경로를`motion.path`로 변환하기 만하면됩니다.
 

```jsx
import React from 'react';
import { motion } from "framer-motion";
const AnimatedCastle = () => {
  return (
    <svg id="svg-castle" width="480" height="480" viewBox="0 0 480 480" fill="non            e" xmlns="http://www.w3.org/2000/svg">
      <motion.path d="M311.111 420H288.889V455.556V468.889H311.111V455.556V420Z"              stroke="#B2441D" stroke-width="2" className="color-1"
      
      />
      <motion.path d="M191.111 420H168.889V455.556V468.889H191.111V455.556V420Z"                stroke="#B2441D" stroke-width="2" className="color-2"
        
      />
         
      <!-- etc. -->
    </svg>
  )
}
```

이것은 각 SVG 경로에 대해 수행되어야합니다.
 전체 구현은이 데모를 참조하십시오.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 600px;"><iframe id="cp_embed_PozzYLr" src="//codepen.io/anon/embed/PozzYLr?height=600&amp;theme-id=1&amp;slug-hash=PozzYLr&amp;default-tab=result" height="600" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed PozzYLr" title="CodePen Embed PozzYLr" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

하지만주의 할 점이 있습니다. 성 SVG에는 60 개가 넘는 경로가 있습니다.
 그것들을 통과하는 것은 저에게 상당히 힘들었고, 프로세스가 반복적이고 오류가 발생하기 쉽다는 것을 알았습니다.
 따라서 Framer Motion은 권장하지 않지만 5 개 이하의 경로가있는 React 구성 요소 내의 SVG에 적합하다고 말하고 싶습니다.
 그 이상이 필요하면 이전에 다룬 라이브러리를 사용하십시오.
 

손으로 그린 SVG 효과를 얻기 위해 사용할 수있는 네 가지 자바 스크립트 라이브러리를 살펴 보겠습니다.
 

CSS 전용 솔루션을 다루지 않은 이유는 무엇입니까?
 가능하지만 많은 코드 반복이 필요합니다.
 예를 들어 자바 스크립트를 사용하거나 각 경로 길이를 1로 설정하는이 멋진 트릭을 사용하여 각 경로의 총 길이를 찾은 다음 각 경로의 `stroke-dasharrray`및 `stroke-dashoffset`을 경로 길이로 설정합니다.
 

그 후에도 `stroke-dashoffset`을 0으로 애니메이션하는 키 프레임을 정의해야합니다.
 그런 다음 해당 키 프레임 애니메이션이 각 경로에 추가되고 `animation-delay`로 약간 오프셋됩니다.
 또한 경로를 각각의 색상으로 채우기 위해 6 개의 다른 키 프레임 규칙을 작성해야합니다.
 성에 60 개 이상의 개별 경로가 있다는 점을 고려하면 100 줄이 넘는 CSS입니다!
 가장 효율적이거나 간단한 접근 방식은 아닙니다.
 