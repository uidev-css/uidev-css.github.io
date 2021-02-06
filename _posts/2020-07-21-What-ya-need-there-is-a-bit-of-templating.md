---
layout: post
title: "거기에 필요한 것은 약간의 템플릿이다."
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2018/04/ellipses-brackets.jpg"
tags: TEMPLATING
---


요전 날 한 친구가 나한테 편지를 쓰게 했어. 그는 HTML, CSS, 자바스크립트를 가지고 있었고, 그것은 그가 생각해야만 했던 것처럼 행동하지 않았습니다. HTML에는 일부 자리 표시자가 있었고 자바스크립트에는 일부 데이터가 들어 있었으며, 데이터가 자리 표시자를 채운다는 가정도 있었다.

어느 정도 웹 지식이 있는 사람이라면, 우리는 이것을 볼 수 있고 왜 그가 생각했던 것처럼 작동하지 않는지 알 수 있습니다. 하지만 저는 이러한 관점에서 사물을 바라보면서 원래의 문제처럼 바라건대 간단한 해결책을 찾는 것도 가치 있다고 생각합니다.

### HTML은 이와 비슷한 것이었다.

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Test</title>
  <link rel="stylesheet" href="test.css">
  <script src="data.js"></script>
</head>
<body>
  <section>
    <div>{company_name}</div>
  </section>
</body>
</html>
```

### 자바스크립트는 이렇습니다.

```js
var company_data = {
  "{company_name}" : "SOME COMPANY",
};
```

### 여기에는 아무런 잘못된 일도 없다.

그건 모두 완벽하게 유효한 암호야. 그것은 오른쪽으로 연결되어 있다. 그것은 달릴 것이다. 화면에 {company_name}을(를) 렌더링하는 것 외에는 아무 작업도 수행되지 않습니다. 대신 SOME COMPANY를 화면에 렌더링하여 `{company_name} 자리 표시자를 JavaScript 파일의 데이터로 대체할 것으로 기대된다.

### 원라이너로 고칩시다.

이 정확한 시나리오에서 정확한 회사 이름을 표시하려면 DOM에서 해당 요소를 선택하고 해당 컨텐츠를 우리의 데이터로 교체해야 합니다. 자바스크립트에 한 줄만 더 추가하면 됩니다.

```js
var company_data = {
  "{company_name}": "SOME COMPANY"
};

document.querySelector("div").innerHTML = company_data["{company_name}"]; 

```

특별히 재사용이 되거나 회복이 되지는 않지만, 이봐, 그건 또한 지나친 생각이나 도구화도 아니야.

### 그 기대는 대단했다.

저는 이 시점에서 그가 바라는 것은 이런 종류의 템플릿이 자동적으로 일어나기를 바란다는 것을 알 수 있다고 생각합니다. 개체에 HTML의 내용과 일치하는 키를 제공하면 해당 HTML의 내용이 자동으로 스왑 아웃됩니다. 원시 웹 기술에서는 그런 식으로 작동하지 않습니다.

농담이 아닙니다. 이 문제를 해결할 수 있는 방법은 수백 가지가 있습니다. 제 머리에서 몇 가지 짚고 넘어가겠습니다.

- 핸들바 또는 콧수염과 같은 템플릿 언어 사용
- 기본적으로 Liquid를 사용하는 Elevent와 같은 정적 사이트 생성기 사용
- HTML `<template>`를 만들고 사용할 스크립트를 직접 작성합니다.
- 웹 구성 요소 만들기
- 대신 백엔드 언어를 사용하거나 Nunjuks와 같은 언어를 사용하여 미리 처리
- Pug와 같은 전처리기 사용

일반적으로 서버측 또는 빌드 중에 템플릿 작업을 수행하는 것이 이상적입니다. 필요하지 않으면 DOM을 사용하는 이유는 무엇입니까?

하지만 잠시 이 조언을 무시하기 위해 Handlebars를 통해 클라이언트측에서 수행하는 예를 보여드리겠습니다. 원래 e-메일을 보낸 사람은 다음과 같은 작업을 수행할 수 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_VweEYrB" src="//codepen.io/anon/embed/VweEYrB?height=450&amp;theme-id=1&amp;slug-hash=VweEYrB&amp;default-tab=html,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed VweEYrB" title="CodePen Embed VweEYrB" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>