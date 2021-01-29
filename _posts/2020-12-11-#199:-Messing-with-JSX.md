---
layout: post
title: "# 199 : JSX와의 혼란
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/12/jsx-thumb.png
tags: JSX
---


비디오 다운로드
(MVP 서포터 만 오프라인보기를 위해 원본 고품질 녹음을 다운로드 할 수 있습니다.)
 

오래 전에 배웠어야했는데 아아, 여기 있습니다.
 JSX가 어떤 기능을 사용하기를 원하는지 알 수 있습니다.
 네, JSX는 실제로 수행하는 주요 변환이 하나뿐입니다.
 JavaScript의 꺾쇠 괄호를 함수 호출로 바꿉니다.
 따라서 JavaScript에서 다음과 같은 줄을 작성하면 :
 

```jsx
<div class="big">Hello</div>
```

처리 후 (아마 Babel 및 JSX 플러그인 사용) 기본적으로 다음을 얻을 수 있습니다.
 

```js
React.createElement("div", { class: "big" }, "Hello");
```

그러나 JSX에 자신의 함수를 사용하고 싶다는 지시문 주석을 포함하면 해당 출력을 변경할 수 있습니다.
 

```jsx
/* @jsx myFunction */
<div class="big">Hello</div>
```

다음으로 바뀝니다.
 

```js
/* @jsx myFunction */
myFunction("div", { class: "big" }, "Hello");
```

즉, 우리 자신의 함수를 작성할 수 있습니다.
 좀 이상하지만 괜찮습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_OJRyaoG" src="//codepen.io/anon/embed/OJRyaoG?height=450&amp;theme-id=1&amp;slug-hash=OJRyaoG&amp;default-tab=js,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed OJRyaoG" title="CodePen Embed OJRyaoG" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

실제 사용 사례는 Preact와 같은 비 React 라이브러리에 대한 것입니다.
 나는 Jason Miller의 예를 통해 이것을 배웠습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_vYXNQPV" src="//codepen.io/anon/embed/vYXNQPV?height=450&amp;theme-id=1&amp;slug-hash=vYXNQPV&amp;default-tab=js,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed vYXNQPV" title="CodePen Embed vYXNQPV" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

Vue도 이런 식으로 할 수 있습니다.
 Vue와 Preact 모두이를 위해 설계된 특별한`h` 함수를 제공합니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_ExaboEP" src="//codepen.io/anon/embed/ExaboEP?height=450&amp;theme-id=1&amp;slug-hash=ExaboEP&amp;default-tab=js,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed ExaboEP" title="CodePen Embed ExaboEP" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

Valeri Karpov는 블로그 게시물 인“An Overview of JSX With 3 Non-React Examples”에서도 몇 가지 흥미로운 사용 사례를 가지고 있습니다.
 