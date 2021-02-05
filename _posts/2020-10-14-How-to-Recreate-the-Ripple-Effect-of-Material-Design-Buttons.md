---
layout: post
title: "재료 설계 버튼의 리플 효과 재현 방법"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/10/unsplash-alihartmann-ripples.png
tags: ANIMATIONS,BUTTONS,MATERIAL DESIGN
---


제가 처음 재료 디자인을 발견했을 때, 저는 특히 재료의 버튼 구성 요소에 영감을 받았습니다. 리플 효과를 사용하여 사용자에게 단순하고 우아한 방식으로 피드백을 제공합니다.

이 효과는 어떻게 작용합니까? 재료디자인의 버튼은 깔끔한 리플 애니메이션만을 보여주는 것이 아니라, 각 버튼을 클릭하는 위치에 따라 애니메이션의 위치도 바뀐다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/10/material-button.gif?resize=456%2C164&ssl=1)

우리는 같은 결과를 얻을 수 있다. ES6+ JavaScript를 사용하는 간결한 솔루션부터 시작하여 몇 가지 다른 접근 방식을 살펴보겠습니다.

### HTML

우리의 목표는 불필요한 HTML 표식을 피하는 것이다. 이제 최소값으로 진행하겠습니다.

```html
<button>Find out more</button>
```

### 버튼 스타일링

JavaScript를 사용하여 리플의 몇 가지 요소를 동적으로 스타일링해야 합니다. 하지만 다른 모든 것은 CSS로 할 수 있습니다. 버튼의 경우 두 가지 속성만 포함하면 됩니다.

```css
button {
  position: relative;
  overflow: hidden;
}
```

position: relative를 사용하면 우리의 리플 요소에 position:절대 position을 사용할 수 있는데, 이것은 우리가 position: assolute의 위치를 통제할 필요가 있다. 반면 오버플로우: 히든은 버튼의 가장자리를 벗어나는 리플을 방지한다. 나머지는 모두 선택 사항입니다. 하지만 지금 우리 버튼은 조금 오래된 학교처럼 보입니다. 보다 현대적인 출발점은 다음과 같습니다.

```css
/* Roboto is Material's default font */
@import url('https://fonts.googleapis.com/css2?family=Roboto&display=swap');

button {
  position: relative;
  overflow: hidden;
  transition: background 400ms;
  color: #fff;
  background-color: #6200ee;
  padding: 1rem 2rem;
  font-family: 'Roboto', sans-serif;
  font-size: 1.5rem;
  outline: 0;
  border: 0;
  border-radius: 0.25rem;
  box-shadow: 0 0 0.5rem rgba(0, 0, 0, 0.3);
  cursor: pointer;
}
```

### 잔물결 스타일링

나중에 JavaScript를 사용하여 HTML에 .ripple 클래스로 리플을 주입할 예정입니다. 하지만 JavaScript로 전환하기 전에 CSS에서 이러한 리플에 대한 스타일을 정의하여 준비하도록 하겠습니다.

```css
span.ripple {
  position: absolute; /* The absolute position we mentioned earlier */
  border-radius: 50%;
  transform: scale(0);
  animation: ripple 600ms linear;
  background-color: rgba(255, 255, 255, 0.7);
}
```

우리의 파문을 순환시키기 위해, 우리는 `경계 반지름`을 50%로 설정했다. 그리고 각 리플이 무에서 나오도록 기본 스케일을 0으로 설정했습니다. 현재로서는 상단, 왼쪽, 폭, 높이 등의 속성이 아직 없기 때문에 아무것도 볼 수 없으며 조만간 자바스크립트로 이러한 속성을 도입할 예정이다.

CSS에 대해서는 애니메이션의 종료 상태를 마지막으로 추가해야 합니다.

```css
@keyframes ripple {
  to {
    transform: scale(4);
    opacity: 0;
  }
}
```

키 프레임에서 `시작` 키워드로 시작 상태를 정의하는 것은 아닙니다. 우리는 from을 생략할 수 있고 CSS는 애니메이션 요소에 적용되는 값을 기반으로 결측값을 구성할 것이다. 이 문제는 `변환: 척도(0)`에서처럼 관련 값이 명시적으로 명시되거나 `oppacity: 1`과 같이 기본값인 경우에 발생합니다.

### 이제 JavaScript용

마지막으로, 우리는 리플의 위치와 크기를 동적으로 설정하기 위해 JavaScript가 필요하다. 크기는 버튼의 크기에 근거해야 하며, 위치는 버튼과 커서의 위치 모두에 근거해야 한다.

먼저 클릭 이벤트를 인수로 사용하는 빈 함수부터 시작합니다.

```js
function createRipple(event) {
  //
}
```

우리는 행사의 `현재 대상`을 찾아 버튼에 접근할 것이다.

```js
const button = event.currentTarget;
```

다음으로 스팬 요소를 인스턴스화하고 버튼의 폭과 높이에 따라 스팬 요소의 직경 및 반지름을 계산합니다.

```js
const circle = document.createElement("span");
const diameter = Math.max(button.clientWidth, button.clientHeight);
const radius = diameter / 2;
```

이제 잔물결에 필요한 나머지 성질, 즉 왼쪽, 위쪽, 너비, 높이 등을 정의할 수 있다.

```js
circle.style.width = circle.style.height = `${diameter}px`;
circle.style.left = `${event.clientX - (button.offsetLeft + radius)}px`;
circle.style.top = `${event.clientY - (button.offsetTop + radius)}px`;
circle.classList.add("ripple"); 
```

스팬 요소를 DOM에 추가하기 전에 이전 클릭에서 남아 있을 수 있는 기존 리플을 확인하고 다음 리플을 실행하기 전에 제거하는 것이 좋습니다.

```js
const ripple = button.getElementsByClassName("ripple")[0];

if (ripple) {
  ripple.remove();
}
```

마지막 단계로, 우리는 어린 시절 스팬을 버튼 요소에 추가하여 버튼 안에 삽입되도록 합니다.

```js
button.appendChild(circle);
```

우리의 기능이 완성되면, 이제 그것을 부르는 일만 남았습니다. 이것은 여러 가지 방법으로 이루어질 수 있다. 페이지의 모든 버튼에 리플을 추가하려면 다음과 같은 기능을 사용할 수 있습니다.

```js
const buttons = document.getElementsByTagName("button");
for (const button of buttons) {
  button.addEventListener("click", createRipple);
}
```

이제 효과가 나타나고 있습니다!

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_mdPMVaW" src="//codepen.io/anon/embed/mdPMVaW?height=250&amp;theme-id=1&amp;slug-hash=mdPMVaW&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed mdPMVaW" title="CodePen Embed mdPMVaW" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 더 나아가서

만약 우리가 더 나아가서 이 효과를 우리 단추의 위치나 크기에 대한 다른 변화와 결합하고 싶다면? 결국, 사용자 정의할 수 있는 능력은 그 효과를 직접 재현하는 것을 선택함으로써 우리가 가진 주요 장점 중 하나입니다. 기능 확장이 얼마나 쉬운지 테스트하기 위해 커서가 특정 영역 내에 있을 때 버튼이 커서 쪽으로 이동하도록 하는 "자석" 효과를 추가하기로 했습니다.

우리는 리플 기능에 정의된 몇 가지 동일한 변수에 의존할 필요가 있습니다. 코드를 불필요하게 반복하지 말고 두 가지 방법을 모두 사용할 수 있는 곳에 저장해야 합니다. 하지만 우리는 또한 각각의 버튼에 대한 공유 변수의 범위를 유지해야 합니다. 이를 위한 한 가지 방법은 아래 예와 같이 클래스를 사용하는 것입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_mdPBjWG" src="//codepen.io/anon/embed/mdPBjWG?height=250&amp;theme-id=1&amp;slug-hash=mdPBjWG&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed mdPBjWG" title="CodePen Embed mdPBjWG" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

자석 효과는 이동할 때마다 커서를 추적해야 하므로 더 이상 커서 위치를 계산할 필요가 없습니다. 대신 커서X와 커서(cursorX)에 의존할 수 있다.네.

두 가지 중요한 새로운 변수는 마그네틱 풀X와 마그네틱 풀리이다. 그들은 우리의 자석 방법이 커서 뒤에 있는 버튼을 얼마나 강하게 잡아당기는지를 조절한다. 따라서, 우리가 우리의 리플의 중심을 정의할 때, 우리는 새로운 버튼의 위치 (x와 y)와 자기 당김 둘 다에 맞게 조정할 필요가 있다.

```js
const offsetLeft = this.left + this.x * this.magneticPullX;
const offsetTop = this.top + this.y * this.magneticPullY;
```

이러한 결합된 효과를 모든 버튼에 적용하려면 각 버튼에 대해 클래스의 새 인스턴스를 인스턴스화해야 합니다.

```js
const buttons = document.getElementsByTagName("button");
for (const button of buttons) {
  new Button(button);
}
```

### 기타 기법

물론 이것은 파급효과를 얻을 수 있는 한 가지 방법일 뿐이다. CodePen에는 다양한 구현을 보여주는 많은 예가 있습니다. 아래는 내가 좋아하는 것들 중 일부이다.

사용자가 JavaScript를 사용하지 않도록 설정한 경우 리플 효과에는 단점이 없습니다. 그러나 클릭에 반응하기 위해 활성 의사 클래스를 사용하여 CSS만으로 원래 효과에 근접할 수 있습니다. 주요 제한 사항은 리플이 클릭 위치에 반응하지 않고 한 지점(일반적으로 버튼의 중심)에서만 나타날 수 있다는 점입니다. Ben Szabo의 예는 특히 간결합니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 200px;"><iframe id="cp_embed_jLXKJw" src="//codepen.io/anon/embed/jLXKJw?height=200&amp;theme-id=1&amp;slug-hash=jLXKJw&amp;default-tab=result" height="200" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed jLXKJw" title="CodePen Embed jLXKJw" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

Leandro Parice의 데모는 당사의 구현과 유사하지만 이전 버전의 JavaScript와 호환됩니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_EmPvbM" src="//codepen.io/anon/embed/EmPvbM?height=250&amp;theme-id=1&amp;slug-hash=EmPvbM&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed EmPvbM" title="CodePen Embed EmPvbM" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이 예에서는 jQuery를 사용하여 리플 효과를 얻습니다. 종속성으로 이미 jQuery를 가지고 있는 경우 몇 줄의 코드를 저장하는 데 도움이 될 수 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_Dnktj" src="//codepen.io/anon/embed/Dnktj?height=450&amp;theme-id=1&amp;slug-hash=Dnktj&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed Dnktj" title="CodePen Embed Dnktj" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

마지막으로, 제가 마지막으로 한 가지 예를 들겠습니다. 상태 및 참조와 같은 React 기능을 사용하여 파급 효과를 생성할 수는 있지만, 이러한 기능이 반드시 필요한 것은 아닙니다. 리플의 위치와 크기는 클릭할 때마다 계산되어야 하므로 해당 정보를 상태로 유지하는 데 이점이 없습니다. 또한 클릭 이벤트에서 버튼 요소에 액세스할 수 있으므로 참조할 필요도 없습니다.

이 반응 예제에서는 이 아티클의 첫 번째 구현과 동일한 `createRiple` 함수를 사용합니다. 주요 차이점은 (`버튼` 구성 요소의 한 방법으로) 우리의 기능이 그 구성 요소로 범위가 지정된다는 것이다. 또한 `onClick` 이벤트 수신기는 이제 JSX의 일부입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_ZEWJKbN" src="//codepen.io/anon/embed/ZEWJKbN?height=250&amp;theme-id=1&amp;slug-hash=ZEWJKbN&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed ZEWJKbN" title="CodePen Embed ZEWJKbN" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>