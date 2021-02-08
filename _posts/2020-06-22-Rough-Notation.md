---
layout: post
title: "대략적인 표기법"
author: "Uidev Css"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/06/Screen-Shot-2020-06-19-at-7.24.50-AM.png"
tags: 
---


이것은 깔끔한 작은 도서관이다. SVG를 사용하여 밑줄이나 상자 강조 표시(모두 구성 가능한 6가지 설계 옵션이 있음)와 같이 요소(텍스트일 가능성이 있음)에 손으로 그린 것처럼 보이는 주석을 삽입합니다. 아주 영리하다.

간단한 데모는 다음과 같습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_JjGEpXK" src="//codepen.io/anon/embed/JjGEpXK?height=450&amp;theme-id=1&amp;slug-hash=JjGEpXK&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed JjGEpXK" title="CodePen Embed JjGEpXK" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

그냥 쿨한 것 말고도, 나는 그것이 어떻게 출시되었는지가 정말 마음에 들어. npm부터 사용 가능합니다. ES6를 통해 바로 사용할 수 있습니다. 그냥 `<script src>로 쓰면 됩니다. 그런 다음 JavaScript 프레임워크를 사용하는 경우 React, Vue, Svelte, Angular 및 Web Components에 대한 래퍼가 있습니다. 좋아요.

모든 프로젝트가 그런 방식을 취하는 것은 아닙니다. 여기 또 다른 멋진 프로젝트가 있습니다. 바로 goey-react입니다. 그것은 goey effect 개념을 취하며 기본적으로 React/JSX를 통해 API를 제공한다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/06/Screen-Shot-2020-06-19-at-8.03.25-AM.png?fit=1024%2C540&ssl=1)

다시 말하지만, 이것은 매우 멋지고 영리하며 나는 그것을 좋아한다. 그러나 그 대신에 그 효과를 제어하기 위해 `데이터-*` 속성을 가진 HTML 래퍼를 상상해보라. 이를 통해, 래퍼는 모든 JavaScript 프레임워크에서 (쉽게?) 만들어질 수 있습니다.

직접 링크 →