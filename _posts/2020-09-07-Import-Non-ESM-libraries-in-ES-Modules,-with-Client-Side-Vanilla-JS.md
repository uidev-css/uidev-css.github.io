---
layout: post
title: "클라이언트측 Vanilla JS를 사용하여 ES 모듈의 비 ESM 라이브러리 가져오기"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2018/02/js-es6.jpg
tags: ES6,IMPORT
---


우리는 수많은 자바스크립트 라이브러리가 이용 가능한 전 세계를 노출시키는 `스크립트` 태그로 사용되는 이상한 시대를 살고 있다. 그리고 모듈 로더를 통해 사용되는 수많은 자바스크립트 라이브러리가 있다. 그리고 수많은 자바스크립트 라이브러리는 당신이 npm을 통해 그것들을 사용할 것이라고 가정한다. 그리고 ES6를 수입하기 위해 만들어진 수많은 도서관이 있다. JavaScript 라이브러리를 작성하고 최대 사용을 위해 촬영하는 경우 유해한 레깅스가 있더라도 이러한 모든 방식으로 작동합니다.

저는 ES6가 `수입`을 목적으로 한 것이 아닌 도서관을 가져가는 것에 대한 리아의 생각이 마음에 들지만 어쨌든 그렇게 하고 있습니다.

예를 들어:

```js
window.module = {};
import("https://cdn.jsdelivr.net/gh/reworkcss/css@latest/lib/parse/index.js").then(_ => {
  console.log(module.exports);
});
```

그리고 그 부분에 대해 좀 더 안전할 필요가 있다면, 작은 추상화처럼 말이죠.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_qBbQdGG" src="//codepen.io/anon/embed/qBbQdGG?height=450&amp;theme-id=1&amp;slug-hash=qBbQdGG&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed qBbQdGG" title="CodePen Embed qBbQdGG" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

또 다른 영리한 속임수는 그 기사를 확인해 보세요.

직접 링크 →