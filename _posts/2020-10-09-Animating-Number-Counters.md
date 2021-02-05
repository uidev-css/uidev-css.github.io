---
layout: post
title: "애니메이션 번호 카운터"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2019/10/random-number-slots.png
tags: @PROPERTY,CALC,CONTENT,COUNTERS,KEYFRAMES
---


숫자 애니메이션은 지정된 시간 동안 1에서 2로, 2에서 3으로, 3에서 4로 등 숫자가 변화하는 모습을 상상합니다. 카운터와 같이, 우리가 웹 상에서 다른 디자인 애니메이션에 사용하는 것과 같은 종류의 애니메이션에 의해 제어되는 것 외에는요. 이것은 대시보드와 같은 것을 디자인할 때 유용하게 쓰일 수 있습니다. 작은 피자를 숫자에 맞게 가져오는데 말이죠. 놀랍게도, 이것은 이제 큰 속임수 없이 CSS에서 할 수 있다. 원하신다면 바로 새로운 솔루션으로 넘어가실 수 있습니다. 하지만 먼저 우리가 어떻게 그것을 해왔는지 살펴보도록 하겠습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/09/number-animation.gif?resize=450%2C80&ssl=1)

번호 애니메이션을 하는 논리적인 한 가지 방법은 JavaScript에서 번호를 변경하는 것입니다. 우리는 다소 간단한 세트를 할 수 있다.간격`이지만 시작, 종료 및 지속 시간을 받아들이는 기능이 있는 멋진 답변이 있으므로 애니메이션처럼 취급할 수 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_xxVBqEg" src="//codepen.io/anon/embed/xxVBqEg?height=250&amp;theme-id=1&amp;slug-hash=xxVBqEg&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed xxVBqEg" title="CodePen Embed xxVBqEg" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

CSS에 보관하면 CSS 카운터를 사용하여 서로 다른 키 프레임에서 카운트를 조정하여 숫자를 애니메이션할 수 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_NWNJpPe" src="//codepen.io/anon/embed/NWNJpPe?height=250&amp;theme-id=1&amp;slug-hash=NWNJpPe&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed NWNJpPe" title="CodePen Embed NWNJpPe" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

또 다른 방법은 모든 숫자를 일렬로 정렬하고 한 번에 하나씩만 보여주는 위치를 애니메이션화하는 것입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_dyMrvYR" src="//codepen.io/anon/embed/dyMrvYR?height=250&amp;theme-id=1&amp;slug-hash=dyMrvYR&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed dyMrvYR" title="CodePen Embed dyMrvYR" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이러한 예에서 반복되는 코드 중 일부는 HTML을 위한 Pug 또는 CSS를 위한 SCSS와 같은 전처리를 사용할 수 있는데, 이 전처리는 그것들을 관리하기 쉽도록 하기 위해 루프를 제공하지만, 기본 아이디어를 볼 수 있도록 일부러 바닐라를 사용한다.

### 새로운 학교 CSS 솔루션

최근 `CSS.registerProperty`와 `@property`에 대한 지원을 통해 CSS 변수를 애니메이션할 수 있다. 이 트릭은 CSS 사용자 지정 속성을 정수로 선언하는 것입니다. 이렇게 하면 다른 정수처럼 (전환 내에서처럼) 보간될 수 있습니다.

```css
@property --num {
  syntax: '<integer>';
  initial-value: 0;
  inherits: false;
}

div {
  transition: --num 1s;
  counter-reset: num var(--num);
}
div:hover {
  --num: 10000;
}
div::after {
  content: counter(num);
}
```

중요 참고: 이 @property 구문은 크롬(Edge 및 Opera와 같은 다른 크롬 코어 브라우저)에서만 지원되므로 크로스 브라우저에 익숙하지 않다. Chrome 전용(예: Electronic app)을 빌드하는 경우 즉시 유용하며, 그렇지 않은 경우 잠시 기다리십시오. 위의 데모는 보다 광범위하게 지원됩니다.

CSS 콘텐츠 속성은 숫자를 표시하는 데 사용할 수 있지만, 콘텐츠는 <string> 값만 출력할 수 있기 때문에 우리는 여전히 카운터를 사용하여 숫자를 문자열로 변환해야 한다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_NWNJpdJ" src="//codepen.io/anon/embed/NWNJpdJ?height=250&amp;theme-id=1&amp;slug-hash=NWNJpdJ&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed NWNJpdJ" title="CodePen Embed NWNJpdJ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

다른 애니메이션과 마찬가지로 애니메이션을 쉽게 사용할 수 있는 방법을 확인하십시오. 멋있다!

유형화된 CSS 변수는 `@keyframe`에서도 사용할 수 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_NWNJvPE" src="//codepen.io/anon/embed/NWNJvPE?height=250&amp;theme-id=1&amp;slug-hash=NWNJvPE&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed NWNJvPE" title="CodePen Embed NWNJvPE" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

한 가지 단점? 카운터는 정수만 지원합니다. 그것은 소수점 이하로는 불가능하다는 것을 의미한다. 정수 부분과 부분 부분을 따로 표시해야 할 것 같아요.

### 십진법도 만들 수 있을까요?

소수점(예: `--숫자`)를 정수로 변환할 수 있습니다. 작동 방식은 다음과 같습니다.

- `초기 값`이 지정된 `<` CSS 변수(예: `--integer`)를 등록합니다.
- 그런 다음 calc()를 사용하여 값을 반올림합니다. --integer: calc(var(--숫자))

이 경우 --number는 가장 가까운 정수로 반올림되어 결과를 --integer에 저장합니다.

```css
@property --integer {
  syntax: "<integer>";
  initial-value: 0;
  inherits: false;
}
--number: 1234.5678;
--integer: calc(var(--number)); /* 1235 */
```

가끔은 정수 부분만 있으면 돼요. 까다로운 방법이 있습니다. `--정수: max(var(--숫자) - 0.5, 0) 이것은 양수에 효과적입니다. 이런 식으로 하면 안 돼요.

```css
/* @property --integer */
--number: 1234.5678;
--integer: max(var(--number) - 0.5, 0); /* 1234 */
```

유사한 방법으로 분수 부분을 추출한 다음 카운터가 있는 문자열로 변환할 수 있다(그러나 `내용` 값은 문자열이어야 한다는 것을 기억하라). 연결된 문자열을 표시하려면 다음 구문을 사용하십시오.

```css
content: "string1" var(--string2) counter(--integer) ...
```

다음은 십진수로 백분율을 애니메이션하는 전체 예입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_dyMrzpz" src="//codepen.io/anon/embed/dyMrzpz?height=250&amp;theme-id=1&amp;slug-hash=dyMrzpz&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed dyMrzpz" title="CodePen Embed dyMrzpz" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 기타 팁

우리는 CSS 카운터를 사용하기 때문에 그 카운터의 형식은 숫자 외에 다른 형식일 수 있습니다. 다음은 문자 "CSS"를 "YES"로 애니메이션화한 예입니다!

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_wvGOJqO" src="//codepen.io/anon/embed/wvGOJqO?height=250&amp;theme-id=1&amp;slug-hash=wvGOJqO&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed wvGOJqO" title="CodePen Embed wvGOJqO" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

다음 추가 팁: JavaScript를 사용하여 사용자 지정 속성의 계산된 값을 캡처하는 값을 디버깅할 수 있습니다.

```js
getComputedStyle(element).getPropertyValue('--variable')
```

다 됐다! 더 이상 어쩔 수 없다! 요즘 CSS가 할 수 있는 게 신기해요.