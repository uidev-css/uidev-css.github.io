---
layout: post
title: "눈에 띄지 않는 스크롤 투 톱 버튼을 만드는 방법"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/09/scroll-to-top.png
tags: BUTTONS,SCROLL-BEHAVIOR,SCROLLING
---


페이지 맨 위로 돌아가기 위한 버튼을 사용하면 사용자가 너무 많은 노력을 기울이지 않고도 페이지 맨 위로 빠르게 돌아갈 수 있습니다. 페이지에 내용이 많거나 한 페이지 웹 사이트, 무한 스크롤 사용 시 또는 다양한 화면 크기로 인해 콘텐츠가 확장될 수 있는 모바일 장치에서 발생하는 경우에 매우 유용합니다.

일반적으로 이러한 단추는 사이트의 아래쪽 구석에 뜬 다음 클릭하면 페이지의 맨 위로 돌아갑니다. 그것들은 자바스크립트로 만들기가 꽤 쉽다. 그러나 시각적으로 볼 때, 우리는 그것을 누르거나 클릭할 수 있을 만큼 충분히 큰 목표물이면서도 방해물이 되지 않기를 바라고 있다. 우리가 이것을 할 수 있는 몇 가지 방법들을 생각해 봅시다. 단순하게 시작하고, 나아가서 개선해 나가는 방법들을요.

### 옵션 1: 단순성 유지

먼저 자바스크립트에서 버튼을 선택합니다.

```js
var scrollToTopBtn = document.getElementById("scrollToTopBtn")
```

이제 `document.documentElement`는 문서의 루트 요소를 반환합니다. 우리는 오프셋 값을 얻기 위해 그것이 필요합니다. 따라서 다음으로는 코드를 호출하기 쉬운 `rootElement`라는 변수에 저장해 보겠습니다.

```js
var rootElement = document.documentElement
```

클릭 이벤트 수신기를 버튼에 추가합니다.

```js
function scrollToTop {
  // scroll to top logic
}

scrollToTopBtn.addEventListener("click", scrollToTop)
```

그런 다음 스크롤 토톱 기능 내에서 스크롤 토(scroll To) 방식으로 화면 상단으로 스크롤할 수 있도록 하겠습니다.

```js
function scrollToTop() {
  // Scroll to top logic
  rootElement.scrollTo({
    top: 0,
    behavior: "smooth"
  })
}
```

버튼의 스타일을 약간 높일 수도 있습니다.

```css
#scrollToTopBtn {
  background-color: black;
  border: none;
  border-radius: 50%;
  color: white;
  cursor: pointer;
  font-size: 16px;
  line-height: 48px;
  width: 48px;
}
```

이제 페이지 아래쪽에 버튼을 놓을 수 있습니다. 예를 들어 바닥글:

```html
<footer>
  <!-- Scroll to top button -->
  <button id="scrollToTopBtn">☝️</button>
</footer>
```

그리고 우리는 이것을 얻습니다:

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_bGpxyEM" src="//codepen.io/anon/embed/bGpxyEM?height=450&amp;theme-id=1&amp;slug-hash=bGpxyEM&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed bGpxyEM" title="CodePen Embed bGpxyEM" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 옵션 2: 스크롤 위치 감지

스크롤 이벤트 수신기를 사용하여 스크롤을 감지할 수 있습니다.

```js
function handleScroll() {
  // Do something on scroll
}
document.addEventListener("scroll", handleScroll)
```

사용자가 스크롤할 때마다 핸들 스크롤 기능이 호출됩니다. 이제 스크롤할 수 있는 총 픽셀 수가 필요합니다.

- 스크롤 높이는 오버플로로 인해 보이지 않는 부분을 포함하여 요소의 높이를 제공합니다.
- 클라이언트 높이는 요소의 내부 높이(픽셀)를 나타냅니다.

`클라이언트`로 스크롤 높이를 빼면높이, 스크롤할 수 있는 총 픽셀 수:

```js
var scrollTotal = rootElement.scrollHeight - rootElement.clientHeight
```

이제 수직으로 스크롤할 수 있는 최대 픽셀 수를 나타내는 `scrolTotal`이라는 변수가 생겼다. 스크롤할 수 있는 총 픽셀 수로 스크롤되는 양을 나누면 0과 1의 비율을 얻을 수 있습니다. 이 비율로 재생하면 버튼을 쉽게 켜고 끌 수 있습니다.

예를 들어, 사용자가 페이지 전체 높이에서 80%(또는 0.80 비율) 아래로 스크롤했을 때 스크롤 투 톱 버튼을 표시하는 조건을 추가합니다. 80%는 임의 숫자입니다. 기본적으로 1에 가까울수록 사용자가 버튼을 보기 전에 스크롤해야 합니다.

다음은 JavaScript입니다.

```js
var rootElement = document.documentElement
 
function handleScroll() {
  // Do something on scroll
  var scrollTotal = rootElement.scrollHeight - rootElement.clientHeight
  if ((rootElement.scrollTop / scrollTotal ) > 0.80 ) {
    // Show button
    scrollToTopBtn.classList.add("showBtn")
  } else {
    // Hide button
    scrollToTopBtn.classList.remove("showBtn")
  }
}
 
document.addEventListener("scroll", handleScroll)
```

우리는 어떤 CSS가 버튼의 위치를 정확하게 지정하기를 원합니다.

```css
.scrollToTopBtn {
  /* same general styles as before */
  
  /* place it at the bottom-right corner */
  position: fixed;
  bottom: 30px;
  right: 30px;
 
  /* keep it at the top of everything else */
  z-index: 100;
 
  /* hide with opacity */
  opacity: 0;
 
  /* also add a translate effect */
  transform: translateY(100px);
 
  /* and a transition */
  transition: all .5s ease
}
 
.showBtn {
  opacity: 1;
  transform: translateY(0)
}
```

이렇게 하면 사용자가 페이지를 80% 아래로 이동한 다음 그 이상 높으면 단추가 나타납니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_GRZOWwp" src="//codepen.io/anon/embed/GRZOWwp?height=450&amp;theme-id=1&amp;slug-hash=GRZOWwp&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed GRZOWwp" title="CodePen Embed GRZOWwp" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이것은 훌륭한 선택인 것 같고, 이것을 하도록 이벤트 청취자를 설정하는 것은 매우 쉽습니다. 하지만 항상 현재 스크롤 위치를 확인하기 때문에 성능 오버헤드가 클 수 있습니다.

이 문제를 해결할 다른 방법이 있습니다.

### 옵션 3: 교차로 관찰자

Intersection Observer API는 위의 문제에 대한 훌륭한 솔루션입니다. 개발자는 최신 브라우저 API를 사용하여 이러한 작업의 대부분을 브라우저로 전송할 수 있습니다. Travis Almand는 그것이 어떻게 작동하는지에 대한 철저한 설명을 썼다. MDN은 이를 다음과 같이 정의합니다.

> Intersection Observer API는 상위 요소 또는 최상위 수준 문서의 뷰포트와 대상 요소의 교차점에 대한 변경 사항을 비동기적으로 관찰하는 방법을 제공합니다.

아주 깔끔해! 즉, 버튼이 목표 요소가 될 수 있습니다.

```js
// We select the element we want to target
var target = document.querySelector("footer");
```

그런 다음 요소가 뷰포트와 "교차"될 때 어떤 작업을 수행하는 콜백 함수를 작성합니다. 뷰포트는 뷰포트와 "교차"할 때 멋진 방식으로 표시됩니다.

바닥글이 뷰포트를 들어가거나 나가기만 하면 클래스를 추가하거나 제거하는 것이 가장 좋습니다. 콜백은 일련의 항목을 매개 변수로 수신합니다.

```js
function callback(entries, observer) {
  // The callback will return an array of entries, even if you are only observing a single item
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      // Show button
      scrollToTopBtn.classList.add('showBtn')
    } else {
      // Hide button
      scrollToTopBtn.classList.remove('showBtn')
    }
  });
}
```

새로운 `인터섹션 옵서버` 인스턴스를 만들어서 방금 작성한 콜백 기능을 전달해야 합니다.

```js
let observer = new IntersectionObserver(callback);
```

마지막으로, 관찰자에게 위에서 선택한 대상 요소가 뷰포트와 교차할 때 관찰(오류, 관찰)을 시작하라고 말한다.

```js
observer.observe(target);
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_WNwgBRg" src="//codepen.io/anon/embed/WNwgBRg?height=450&amp;theme-id=1&amp;slug-hash=WNwgBRg&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed WNwgBRg" title="CodePen Embed WNwgBRg" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 부드러운 스크롤은 어떨까요?

물론 가능합니다! 실제로 Chris는 2019년에 CSS를 사용하여 이 작업을 수행할 수 있는 방법을 보여주었습니다.

```html
<html id="top">
  <body>
     <!-- the entire document -->
     <a href="#top">Jump to top of page</a>
  </body>
</html>
```

```css
html {
  scroll-behavior: smooth;
}
```

크리스가 게시물에서 다루었던 접근성 향상과 같은 조금 더 뉘앙스가 있습니다. 핵심은 CSS가 우리가 자바스크립트를 사용하던 것들을 성취할 수 있는 새로운 힘을 얻고 있다는 것이다.

여기 있어요! 우리는 아주 간단한 아이디어로 시작했습니다. 사용자의 스크롤 위치에 따라 버튼을 표시하거나 숨김으로써 개선했습니다. 그런 다음 현재 스크롤 위치를 보는 대신 Intersection Observer API를 구현하여 성능을 향상시켰다. 그리고 마지막으로 CSS가 어떻게 매끄러운 스크롤을 위해 사용될 수 있는지 보았습니다. 모두 함께, 우리는 페이지의 다른 요소들을 차단하지 않으면서 쉽게 보고 사용할 수 있는 스크롤 투 톱 버튼을 얻습니다.