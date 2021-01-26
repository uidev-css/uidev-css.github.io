---
layout: post
title: "동적 조건부 가져 오기"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2021/01/dynamic-conditional-imports.png
tags: 
---


ES 모듈을 사용하면 기본적으로 다른 JavaScript를 `가져올`수 있습니다.
 색종이처럼, 이런 :

```js
import confetti from 'https://cdn.skypack.dev/canvas-confetti';
confetti();
```

그`import` 문이 실행됩니다.
 하지만 조건부로하는 패턴이 있습니다.
 다음과 같습니다.

```js
(async () => {
  if (condition) {
    // await import("stuff.js");

    // Like confetti! Which you have to import this special way because the web
    const { default: confetti } = await import(
      "https://cdn.skypack.dev/canvas-confetti@latest"
    );
    confetti();
  }
})();
```

왜?
 어떤 종류의 조건이든 상관 없습니다.
 URL을 확인하고 특정 페이지에서만 특정 항목을로드 할 수 있습니다.
 특정 조건에서만 특정 웹 구성 요소를로드 할 수 있습니다.
 몰라요.
 백만 가지를 생각할 수 있다고 확신합니다.

책임감있는 조건부 로딩은 또 다른 아이디어입니다.
 다음은`saveData`가 켜져 있지 않은 경우에만 모듈을로드하는 것입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_NWRBwGJ" src="//codepen.io/anon/embed/NWRBwGJ?height=450&amp;theme-id=1&amp;slug-hash=NWRBwGJ&amp;default-tab=js,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed NWRBwGJ" title="CodePen Embed NWRBwGJ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>