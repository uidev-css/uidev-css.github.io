---
layout: post
title: "WAAPI를 사용하여 세부 정보 요소를 애니메이션하는 방법
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/10/waapidetails-accordion.png
tags: ACCORDION,DETAILS/SUMMARY,WAAPI
---


자바 스크립트에서 애니메이션 아코디언은 웹 사이트에서 가장 많이 요청 된 애니메이션 중 하나였습니다.
 재미있는 사실 : jQuery의`slideDown ()`함수는 2006 년 첫 번째 버전에서 이미 사용 가능했습니다.
 

이 기사에서는 Web Animations API를 사용하여 네이티브`<details>`요소에 애니메이션을 적용하는 방법을 살펴 봅니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_QWEpLqm" src="//codepen.io/anon/embed/QWEpLqm?height=450&amp;theme-id=1&amp;slug-hash=QWEpLqm&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed QWEpLqm" title="CodePen Embed QWEpLqm" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### HTML 설정
 

먼저이 애니메이션에 필요한 마크 업을 어떻게 구성할지 살펴 보겠습니다.
 

`<details>`요소에는`<summary>`요소가 필요합니다.
 요약은 아코디언을 닫을 때 표시되는 내용입니다.
`<details>`내의 다른 모든 요소는 아코디언 내부 콘텐츠의 일부입니다.
 해당 콘텐츠를보다 쉽게 애니메이션 할 수 있도록`<div>`안에 래핑합니다.
 

```html
<details>
  <summary>Summary of the accordion</summary>
  <div class="content">
    <p>
      Lorem, ipsum dolor sit amet consectetur adipisicing elit.
      Modi unde, ex rem voluptates autem aliquid veniam quis temporibus repudiandae illo, nostrum, pariatur quae!
      At animi modi dignissimos corrupti placeat voluptatum!
    </p>
  </div>
</details>
```

### 아코디언 클래스
 

코드를 더 재사용 가능하게하려면`Accordion` 클래스를 만들어야합니다.
 이렇게하면 페이지의 모든`<details>`요소에서`new Accordion ()`을 호출 할 수 있습니다.
 

```js
class Accordion {
  // The default constructor for each accordion
  constructor() {}

  // Function called when user clicks on the summary
  onClick() {}

  // Function called to close the content with an animation
  shrink() {}

  // Function called to open the element after click
  open() {}

  // Function called to expand the content with an animation
  expand() {}

  // Callback when the shrink or expand animations are done
  onAnimationFinish() {}
}
```

생성자는 아코디언 당 필요한 모든 데이터를 저장하는 곳입니다.
 

```js
constructor(el) {
  // Store the <details> element
  this.el = el;
  // Store the <summary> element
  this.summary = el.querySelector('summary');
  // Store the <div class="content"> element
  this.content = el.querySelector('.content');

  // Store the animation object (so we can cancel it, if needed)
  this.animation = null;
  // Store if the element is closing
  this.isClosing = false;
  // Store if the element is expanding
  this.isExpanding = false;
  // Detect user clicks on the summary element
  this.summary.addEventListener('click', (e) => this.onClick(e));
}
```

`onClick ()`함수에서 요소가 애니메이션 (닫기 또는 확장) 중인지 확인하고 있음을 알 수 있습니다.
 애니메이션이 진행되는 동안 사용자가 아코디언을 클릭하는 경우에 대비해야합니다.
 빠른 클릭의 경우 아코디언이 완전히 열린 상태에서 완전히 닫힌 상태로 점프하는 것을 원하지 않습니다.
 

`<details>`요소에는 요소를 열 때 브라우저에 의해 적용된`[open]`속성이 있습니다.
 `this.el.open`을 사용하여 요소의`open` 속성을 확인하여 해당 속성의 값을 얻을 수 있습니다.
 

```js
onClick(e) {
  // Stop default behaviour from the browser
  e.preventDefault();
  // Add an overflow on the <details> to avoid content overflowing
  this.el.style.overflow = 'hidden';
  // Check if the element is being closed or is already closed
  if (this.isClosing || !this.el.open) {
    this.open();
  // Check if the element is being openned or is already open
  } else if (this.isExpanding || this.el.open) {
    this.shrink();
  }
}
```

이 축소 함수는 WAAPI`.animate ()`함수를 사용합니다.
 MDN 문서에서 더 많은 것을 읽을 수 있습니다.
 WAAPI는 CSS`@ keyframes`와 매우 유사합니다.
 애니메이션의 시작 및 종료 키 프레임을 정의해야합니다.
 이 경우 두 개의 키 프레임 만 필요합니다. 첫 번째 키 프레임은 요소의 현재 높이이고 두 번째 키 프레임은 닫히면`<details>`요소의 높이입니다.
 현재 높이는`startHeight` 변수에 저장됩니다.
 닫힌 높이는`endHeight` 변수에 저장되며`<summary>`의 높이와 같습니다.
 

```js
shrink() {
  // Set the element as "being closed"
  this.isClosing = true;

  // Store the current height of the element
  const startHeight = `${this.el.offsetHeight}px`;
  // Calculate the height of the summary
  const endHeight = `${this.summary.offsetHeight}px`;

  // If there is already an animation running
  if (this.animation) {
    // Cancel the current animation
    this.animation.cancel();
  }

  // Start a WAAPI animation
  this.animation = this.el.animate({
    // Set the keyframes from the startHeight to endHeight
    height: [startHeight, endHeight]
  }, {
    // If the duration is too slow or fast, you can change it here
    duration: 400,
    // You can also change the ease of the animation
    easing: 'ease-out'
  });

  // When the animation is complete, call onAnimationFinish()
  this.animation.onfinish = () => this.onAnimationFinish(false);
  // If the animation is cancelled, isClosing variable is set to false
  this.animation.oncancel = () => this.isClosing = false;
}
```

`open` 함수는 아코디언을 확장하고 싶을 때 호출됩니다.
 이 기능은 아직 아코디언 애니메이션을 제어하지 않습니다.
 먼저`<details>`요소의 높이를 계산하고이 높이에 인라인 스타일을 적용합니다.
 완료되면 콘텐츠를 표시하도록 open 속성을 설정할 수 있지만 요소에 `overflow : hidden`과 고정 높이가 있으므로 숨길 수 있습니다.
 그런 다음 다음 프레임이 확장 함수를 호출하고 요소에 애니메이션을 적용 할 때까지 기다립니다.
 

```js
open() {
  // Apply a fixed height on the element
  this.el.style.height = `${this.el.offsetHeight}px`;
  // Force the [open] attribute on the details element
  this.el.open = true;
  // Wait for the next frame to call the expand function
  window.requestAnimationFrame(() => this.expand());
}
```

확장 기능은 `축소`기능과 유사하지만 현재 높이에서 가까운 높이로 애니메이션하는 대신 요소의 높이에서 끝 높이까지 애니메이션을 적용합니다.
 끝 높이는 요약 높이에 내부 콘텐츠 높이를 더한 값입니다.
 

```js
expand() {
  // Set the element as "being expanding"
  this.isExpanding = true;
  // Get the current fixed height of the element
  const startHeight = `${this.el.offsetHeight}px`;
  // Calculate the open height of the element (summary height + content height)
  const endHeight = `${this.summary.offsetHeight + this.content.offsetHeight}px`;

  // If there is already an animation running
  if (this.animation) {
    // Cancel the current animation
    this.animation.cancel();
  }

  // Start a WAAPI animation
  this.animation = this.el.animate({
    // Set the keyframes from the startHeight to endHeight
    height: [startHeight, endHeight]
  }, {
    // If the duration is too slow of fast, you can change it here
    duration: 400,
    // You can also change the ease of the animation
    easing: 'ease-out'
  });
  // When the animation is complete, call onAnimationFinish()
  this.animation.onfinish = () => this.onAnimationFinish(true);
  // If the animation is cancelled, isExpanding variable is set to false
  this.animation.oncancel = () => this.isExpanding = false;
}
```

이 함수는 축소 또는 확장 애니메이션이 끝날 때 호출됩니다.
 보시다시피 아코디언이 열렸을 때 true로 설정되는 매개 변수`[open]`이 있습니다.이 매개 변수는 더 이상 처리되지 않으므로 요소에`[open]`HTML 속성을 설정할 수 있습니다.
 브라우저.
 

```js
onAnimationFinish(open) {
  // Set the open attribute based on the parameter
  this.el.open = open;
  // Clear the stored animation
  this.animation = null;
  // Reset isClosing & isExpanding
  this.isClosing = false;
  this.isExpanding = false;
  // Remove the overflow hidden and the fixed height
  this.el.style.height = this.el.style.overflow = '';
}
```

### 아코디언 설정
 

휴, 우리는 코드의 가장 큰 부분을 끝냈습니다!
 

남은 것은 HTML의 모든`<details>`요소에 대해`Accordion` 클래스를 사용하는 것입니다.
 이를 위해`<details>`태그에`querySelectorAll`을 사용하고 각각에 대해 새로운`Accordion` 인스턴스를 만듭니다.
 

```js
document.querySelectorAll('details').forEach((el) => {
  new Accordion(el);
});
```

### 노트
 verified_user

닫힌 높이와 열린 높이를 계산하려면`<summary>`와 콘텐츠의 높이가 항상 같은지 확인해야합니다.
 

예를 들어 요약이 열려있을 때 요약에 패딩을 추가하지 마십시오. 애니메이션 중에 점프로 이어질 수 있습니다.
 내부 콘텐츠도 마찬가지입니다. 높이가 고정되어 있어야하며 애니메이션을 여는 동안 높이가 변경 될 수있는 콘텐츠는 피해야합니다.
 

또한 높이 키 프레임에 대해 계산되지 않으므로 요약과 콘텐츠 사이에 여백을 추가하지 마십시오.
 대신 콘텐츠에 직접 패딩을 사용하여 간격을 추가하십시오.
 

### 끝
 

그리고 우리는 라이브러리없이 JavaScript로 멋진 애니메이션 아코디언을 가지고 있습니다!
 🌈
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_QWEpLqm" src="//codepen.io/anon/embed/QWEpLqm?height=450&amp;theme-id=1&amp;slug-hash=QWEpLqm&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed QWEpLqm" title="CodePen Embed QWEpLqm" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>