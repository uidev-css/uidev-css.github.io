---
layout: post
title: "현대 웹링을 구축하는 방법
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/11/webring.png
tags: WEB COMPONENTS
---


나는 웹링에 대해 생각할 때 다른 사람들이 다른 것을 생각한다고 확신하므로 내가 무엇을 그리는지 명확히하겠습니다.
 웹 사이트에 다음과 같은 요소가 있습니다.
 

- 이 사이트가 웹링의 일부임을 나타냅니다.
 
- 웹링의 다음 또는 이전 사이트로 이동할 수 있습니다.
 
- "무작위"사이트로 이동하거나 전체 목록을 보는 것과 같은 다른 기능이있을 수 있습니다.
 

그러나 또 다른 중요한 것은 :
 

- 사이트 소유자는 많은 일을 할 필요가 없습니다.
 그들은 단지 사이트에 (그것?) 튀기고 기능적인 웹링 UI가 있습니다.
 

그래서 이렇게 :
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/11/j8amu39zkrrz.png?resize=1024%2C428&ssl=1)

어떻게 작동 했습니까?
 그거 알아?
 나는 모른다.
 내 생각 엔 고대의`<frameset> <frame /> </ frameset>`상황이었던 것 같지만, 이건 내 시간보다 조금 전이다.
 오늘 우리는 어떻게 할 수 있습니까?
 

음, 우리는`<iframe>`을 사용할 수 있습니다.
 이것이 YouTube와 같은 사이트에서 HTML 스 니펫으로 `삽입 코드`를 제공 할 때하는 일입니다.
 Twitter 및 CodePen과 같은 사이트는`<div>`(또는 모든 의미 HTML)와`<script>`를 제공하므로 대체 콘텐츠가있을 수 있고 스크립트는이를`<iframe>`으로 향상시킵니다.
 `<iframe>`은 사이트 소유자에게 거의 요구하지 않기 때문에 괜찮을 수 있지만 성능에는 상당히 나쁜 것으로 알려져 있습니다.
 결국 다른 문서 안에있는 전체 문서입니다.
 또한 사용자 정의 방식으로 많은 것을 제공하지 않습니다.
 당신은 당신이 얻는 것을 얻습니다.
 

iframe의 또 다른 문제는… 현재 어떤 사이트에 삽입되었는지 어떻게 알 수 있습니까?
 URL 매개 변수일까요?
 상위 페이지의 `postMessage`일까요?
 당신이 나에게 묻는다면 매우 깨끗하지 않습니다.
 

현대적이라고 생각하는 한 웹 구성 요소가 여기로가는 길이라고 생각합니다.
 `<webring-*>`과 같은 맞춤 요소를 만들 수 있습니다.
 그렇게해서 CSS 사이트를 위해 구체적으로 만들어 보겠습니다.
 이렇게하면 다음과 같은 속성을 사용하여 현재 사이트를 보낼 수 있습니다.
 

```html
<webring-css site="http://css-tricks.com">
  This is gonna boot itself up into webring in a minute.
</webring-css>
```

그것은 기술 선택을 해결합니다.
 이제 데이터를 저장할 글로벌 위치를 파악해야합니다.
 왜냐하면 웹링을 업데이트 할 수 있어야하기 때문입니다.
 웹링의 다른 사이트가 아무것도 할 필요없이 웹링에서 사이트를 추가하고 제거 할 수 있어야합니다.
 

이와 같은 매우 간단한 데이터의 경우 GitHub의 JSON 파일이 완벽하게 현대적인 선택 인 것 같습니다.
 그걸하자.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/11/Screen-Shot-2020-11-12-at-2.03.55-PM.png?resize=1926%2C1874&ssl=1)

이제 모든 사람이 웹링의 모든 사이트를 상당히 읽기 쉬운 방식으로 볼 수 있습니다.
 또한 사이트를 추가 / 제거하기 위해 Pull Request를 제출할 수 있습니다.
 

웹 구성 요소에서 데이터를 가져 오는 것은 간단합니다.
 

```js
fetch(`https://raw.githubusercontent.com/CSS-Tricks/css-webring/main/webring.json`)
  .then((response) => response.json())
  .then((sites) => {
     // Got the data.
  });
```

웹 구성 요소가 마운트 될 때 시작합니다.
 비계하자 ...
 

```js
const DATA_FOR_WEBRING = `https://raw.githubusercontent.com/CSS-Tricks/css-webring/main/webring.json`;

const template = document.createElement("template");
template.innerHTML = `
<style>
  /* styles */
</style>

<div class="webring">
  <!-- content -->
</div>`;

class WebRing extends HTMLElement {
  connectedCallback() {
    this.attachShadow({ mode: "open" });
    this.shadowRoot.appendChild(template.content.cloneNode(true));

    fetch(DATA_FOR_WEBRING)
      .then((response) => response.json())
      .then((sites) => {
        // update template with data
      });
  }
}

window.customElements.define("webring-css", WebRing);

```

나머지 부분은 그다지 흥미롭지 않아서 단계별로 진행해야한다고 생각합니다.
 블로그에 스케치 해 드리겠습니다.
 

- 현재 사이트가 무엇인지 볼 수 있도록 웹 구성 요소에서 속성을 가져옵니다.
 
- 데이터의 현재 사이트와 일치
 
- 템플릿의 데이터에서 다음, 이전 및 임의 링크 구축
 
- 템플릿에서 HTML 업데이트
 

그리고 voilà!
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_VwjERBw" src="//codepen.io/anon/embed/VwjERBw?height=450&amp;theme-id=1&amp;slug-hash=VwjERBw&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed VwjERBw" title="CodePen Embed VwjERBw" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>