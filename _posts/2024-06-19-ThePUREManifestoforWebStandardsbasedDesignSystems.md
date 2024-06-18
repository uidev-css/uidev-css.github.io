---
title: "퓨어 매니페스토  웹 표준 기반 디자인 시스템을 위한"
description: ""
coverImage: "/assets/img/2024-06-19-ThePUREManifestoforWebStandardsbasedDesignSystems_0.png"
date: 2024-06-19 00:33
ogImage: 
  url: /assets/img/2024-06-19-ThePUREManifestoforWebStandardsbasedDesignSystems_0.png
tag: Tech
originalTitle: "The PURE Manifesto — for Web Standards based Design Systems"
link: "https://medium.com/cto-as-a-service/the-pure-manifesto-for-web-standards-based-design-systems-d46f400853eb"
---


## 초경량, 웹 표준 기반 디자인 시스템에 대한 기본 규칙

![이미지](/assets/img/2024-06-19-ThePUREManifestoforWebStandardsbasedDesignSystems_0.png)

알고 계실지 모르겠지만, 저는 간단하게 유지하는 것을 선호해요.

![이미지](/assets/img/2024-06-19-ThePUREManifestoforWebStandardsbasedDesignSystems_1.png)

<div class="content-ad"></div>

요즘에는 웹 컴포넌트 전용 PWA를 개발 중이었어요. 구글의 가벼운 라이브러리인 Google Lit을 활용해서요. 이 라이브러리는 무려 5KB밖에 안 되죠.

이 중 하나의 프로젝트는 이미 완성된 피그마 디자인을 가지고 있던 젊은 B2B 스타트업을 위한 것이었어요. 처음에는 목표로 했던 모바일 앱 대신 PWA 기술을 이용하자는 이야기를 나눴을 때, 컴포넌트 라이브러리와 디자인 시스템에 관한 문제가 생겼어요.

앱의 디자인은 신선하고 다채롭고 독창적이었어요. 

일반적인 UI 라이브러리(Material Web, FAST, Shoelace 등)를 사용하면 맞춤 작업을 많이 해야 했기 때문에 결정을 내리는 데 시간이 걸렸어요.

<div class="content-ad"></div>

우리만의 사용자 정의 구성 요소 라이브러리로 나아갈까요? 분명히 많은 작업이 필요할 겁니다.

디자인 시스템을 분리하고 Storybook 인스턴스를 만드는 추가 작업이 필요하기 때문에 스마트하게 대응해야 합니다:

- 자체 디자인 시스템 구축은 가능한 최소한의 부담을 동반해야 합니다.
- 이미 있는 모범 사례를 활용해야 합니다.
- 언제나 네이티브 솔루션을 지향하고 표준을 준수해야 합니다.
- 외부 종속성을 최소화하기 위해 최선을 다해야 합니다.
- 신속히 반복하고 실용적인 선택을 해야 합니다.
- 열렬하지 않아도 되며 바퀴를 다시 발명하는 것을 막기 위해 좋은 이유가 있을 때 외부 구성 요소를 사용할 여지를 열어두어야 합니다 😉.

제 경험을 바탕으로 PURE 선언을 소개하겠습니다.

<div class="content-ad"></div>

# 1순위: 순수한(의미론적) HTML+CSS 사용하기

적절한 의미론을 가진 표준 HTML+CSS 솔루션을 항상 찾아보세요.

가끔은 표준 의미론적 HTML 이상이 필요하지 않을 수도 있습니다.

```js
<section class="callout warning">
  <h3>Warning</h3>
  <div>This is a simple callout test message.</div>
</section>
```

<div class="content-ad"></div>

```md
![이미지](/assets/img/2024-06-19-ThePUREManifestoforWebStandardsbasedDesignSystems_2.png)

가끔은 표준 HTML 구조를 사용하여 흥미로운 사용자 정의 결과를 얻을 수 있습니다. 이는 완전한 의미론적인 응답입니다:

```js
<hr data-content="or"/>
```

...약간의 스타일링을 추가하면 멋진 구분선이 될 수 있습니다.
```

<div class="content-ad"></div>

![image](/assets/img/2024-06-19-ThePUREManifestoforWebStandardsbasedDesignSystems_3.png) 

# 우선 순위 2: 점진적 향상을 생각하세요

최근 프로젝트 중 하나에서는 Google Material Web의 텍스트 필드 구성 요소를 살펴보았고, 우리의 요구 사항을 충족할 수 있는 완전한 Web 구성 요소를 개발하는 것을 고려했지만, 간단함을 위해 어느 쪽도 사용하지 않기로 결정했습니다.

다음은 'id' 및 'for' 속성을 사용하지 않고도 레이블이 있는 양식 필드를 만드는 방법을 보여주는 내가 항상 사용하는 코드 조각입니다(모든 브라우저에서 오랜 기간 동안 작동되어 왔습니다):

<div class="content-ad"></div>

```js
<label>
  <span data-label>Email address</span>
  <input name="email" type="email" placeholder="john@doe.com">
</label>
```

간단한 점진적 향상을 작성했는데, 'data-label' 속성을 가진 컨트롤을 자동으로 확장하여 위의 구조로 표시됩니다:

```js
<input name="email" required
  data-label="Email address"
  placeholder="john@doe.com"
/>
```

<img src="/assets/img/2024-06-19-ThePUREManifestoforWebStandardsbasedDesignSystems_4.png" />

<div class="content-ad"></div>

매우 간단한 점진적 개선 방법은 HTML 입력의 모든 표준 로직이 보존된다는 것을 의미합니다. Web 컴포넌트가 Web Forms에서 일등 시민으로 동작하도록 하는 데 필요한 것과 비교해보면, 절약할 수 있는 규모를 감을 수 있을 겁니다. 

우리는 모든 폼 요소에 이 방법을 사용하기로 결정했고, 우리 자체 맞춤형 컴포넌트와 같이 네이티브가 아닌 HTML 요소를 사용하더라도 동일한 점진적 개선을 사용할 수 있습니다:

```js
<switch-check name="email" required
  data-label="Email address"
  placeholder="john@doe.com"
></switch-check>
```

# 우선순위 3: 사용자 정의 태그 시험 (스타일 적용하기)

<div class="content-ad"></div>

많은 웹 표준(예: PWA — 이름은 무슨 뜻일까?)과 마찬가지로, 웹 컴포넌트는 HTML 언어 자체의 확장성을 통해 시작되는 점진적인 향상을 제공합니다. 이는 사용자 정의 태그를 사용하는 것으로 이루어져 있습니다.

따라서, 사용자 정의 태그는 웹 컴포넌트가 아닙니다. 웹 컴포넌트는 기능이 첨부된 사용자 정의 태그입니다.

사용자 정의 태그는 단순히 선언함으로써 사용할 수 있으며, 해당 태그에 첨부된 웹 컴포넌트를 정의하지 않고 사용자 정의 태그를 사용하는 것은 HTML 구성 요소화에 유효한 접근 방식일 수 있습니다.

가끔은 의미있는 앵커 포인트가 있는 것이면서 해당 포인트에 특정 사용자 정의 태그 CSS를 첨부하는 것만으로 충분할 수 있습니다. 확실히 잘 선택된 사용자 정의 태그 이름은 향후 개발자가 당신의 애플리케이션 흐름을 읽는 데 도움이 됩니다!

<div class="content-ad"></div>

하지만 사용자 정의 태그를 정의할 때는 언제나 CSS만 적용할 경우(기능은 없음)일까요?

내 기준은 다음과 같습니다:

- 우리의 목표와 가장 일치하는 의미론적 요소가 없습니다.
- 사용자 정의 태그는 사용자 정의 방식을 따르는 내부 HTML을 기대하는 래퍼입니다.

```js
<custom-grid columns="1">
  [내용을 입력하세요]
</custom-grid>
```

<div class="content-ad"></div>

위의 예제는 Markdown 형식의 표로 변경해야 합니다.

```js
custom-grid {
  display: grid;
  grid-gap: var(--gutter-small, .5rem);
  &[columns="1"]{
    grid-template-columns: 1fr;
  }
}
```

그리고 다른 복잡한 예제로는 최근에 작성한 TabStrip이 있습니다. 이는 tab-strip라는 사용자 지정 태그를 사용하며 매우 구체적인 콘텐츠를 필요로 합니다: 각 탭은 하나의 링크와 하나의 div로 구성된 섹션으로 표현됩니다.

```js
<tab-strip>
  <section id="tab1"><a href="#insights">Tab 1</a>
    <div class="tab-content" id="overview">
      Tab 1 content
    </div>
  </section>  
  <section id="tab2"><a href="#tab2">Tab 2</a>
    <div class="tab-content">
      Tab 2 content
    </div>
  </section>  
  <section id="tab3"><a href="#tab3">Tab 3</a>
    <div class="tab-content">
      Tab 3 content
    </div>
  </section>
</tab-strip>
```

<div class="content-ad"></div>

물론, 상황이 더 복잡해지면, 예를 들어 탭 콘텐츠를 탭을 클릭할 때 가져와야 하는 경우, 다음 단계는 사용자 정의 태그의 로직을 정의하고 이를 웹 구성 요소로 만드는 것입니다.

# 우선순위 4: 웹 컴포넌트 로직 추가 (Light DOM 사용)

사용자 정의 태그를 사용할 때 트리거되는 기능이 필요한 경우, customElements.define()를 사용하여 해당 기능을 첨부해야 합니다.

많은 경우 전역 스타일링을 활용하거나 전역 상태를 처리하고 버블링 이벤트를 캐치하는 등 JavaScript 기능을 가진 컨테이너 유형의 요소가 필요할 수 있습니다.

<div class="content-ad"></div>

이 컨테이너 요소를 고려해보세요:

```js
<spa-route>
  [HTML 내용을 입력하세요]
</spa-route>
```

```js
import {html, LitElement} from "lit";
import {Router} from "./router";
import {config} from "../app-config";
import {until} from "lit/directives/until.js";

customElements.define(
  "spa-route",

  class PWARenderRoute extends LitElement {

     #router = new Router(config.routes));

    // Light DOM 사용
    createRenderRoot() {
      return this;
    }

    render() {
      return html`${until(this.#router.matchRoute(), app.loader)}`;
    }
  }
)
```

이 코드는 SPA 라우터의 간소화된 버전으로, 구성된 라우트에 기반하여 콘텐츠를 렌더링합니다. 완전한 예제는 "The Browser is your Framework: Building a PWA with only Web Components and Lit"에서 확인할 수 있습니다.

<div class="content-ad"></div>

웹 컴포넌트 중심의 PWA에서는 본문 태그 아래에 모든 것을 포함하는 웹 컴포넌트를 두는 것이 모범 사례입니다.

```js
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=1.0, minimum-scale=1.0, maximum-scale=1.0">
    <title>My App</title>
    <link rel="manifest" href="/manifest.webmanifest"/>
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="mobile-web-app-capable" content="yes"/>
    <meta name="theme-color" content="#655122"/>
    <link rel="apple-touch-icon" href="/assets/img/icon512px"/>
    <link rel="shortcut icon" href="/assets/img/favicon.ico">
    <link href="/assets/css/main.css" rel="stylesheet"/>
    <script type="module" defer src="/assets/js/app.js"></script>
</head>

<body>

<my-app class="app-canvas">
  <main>
    <spa-route></spa-route>
  </main>
</my-app>

</body>

</html>
```

그러니까, my-app 구성요소는 글로벌 앱 상태를 관리하고, localStorage를 처리하며, 인증 세션을 관리하며, 버블링 이벤트를 처리합니다.

# 5순위: 완전한 웹 컴포넌트 생성하기 (Shadow DOM 활용)

<div class="content-ad"></div>

위에 표시된 코드 중 일부에서 Light DOM을 사용하는 꿀팁(Light DOM을 사용하면 전역 스타일이 웹 컴포넌트의 태그 아래에 모두 적용됩니다)은 다음과 같은 Lit 코드입니다:

```js
// Light DOM 사용하기
createRenderRoot() {
  return this;
}
```

기본적으로 LitElement 기반의 웹 컴포넌트는 Shadow DOM을 사용하여 렌더링되므로 확장된 HTMLElement 자체를 반환하여 사용을 비활성화해야 합니다!

커스텀 HTML을 출력하고 문서의 전역 스타일과 격리되어야 하는 커스텀 스타일을 사용하는 복잡한 컴포넌트의 경우, 이 아이디어가 좋지만 몇 가지 추가 복잡성을 받아 들여야 합니다:```

<div class="content-ad"></div>

- 먼저 Shadow DOM의 격리 수준에 대해 알아야 합니다. 웹 구성 요소 중에서 복잡한 부분이 있다면 바로 그것입니다.
- CSS 속성(또는 변수)을 사용하는 것은 추가 작업이 필요합니다.
- 테마 공유(테두리, 색상, 그림자, 안쪽 간격 등)는 조금 더 복잡하고 설명이 필요합니다.
- 컨텐츠 배치(슬롯 사용)는 매우 특정하며 항상 명확하지는 않습니다.
- 접근성 및 사용 용이성 노력(특히 양식 요소를 빌드할 때)은 개발 시간을 늘릴 것입니다.

이렇게 말씀드리는 것에, 많은 구성 요소와 흐름이 있는 복잡한 컨트롤은 물론 단일 단위로 작동합니다. 당연히 매우 가치가 있고, 웹 표준은 이러한 모듈성을 만들기 위한 좋은 방법을 제공합니다.

# 결론

웹 구성 요소 중심의 애플리케이션 개발은 훌륭하고, 초고속 그리고 가벼운 PWA를 제공하지만 웹 구성 요소는 훌륭한 앱을 제공하는 유일한 수단으로 간주되어서는 안 됩니다. 그들에 대한 많은 사용 사례가 있지만, 항상 그것들이 다른 웹 표준과 마찬가지로 점진적 향상의 한 형태임을 염두에 두어야 합니다.

<div class="content-ad"></div>

따라서 코드를 모조리 웹 구성 요소 또는 완전히 격리된 Shadow DOM을 사용하는 것에 대해서는 신중하게 고려해야 합니다.

이 선언은 Lean Startup 관점에서 항상 올바르고 실용적이며 때로는 기회적인 선택을 하는 데 관한 것입니다. 항상 가장 간단하고 지속 가능한 해결책을 찾으려 노력하며 잡기 어려운 방법으로 접근합니다.

가끔은 재사용하기 쉬운 가벼운 구조부터 시작하여 미래에 프로그레시브한 향상을 위한 여지도 남겨두는 것을 의미합니다 😉.

PURE 선언의 많은 개념은 이전 (오픈 소스) 작업에서 기인한 것으로, PurePWA - 파워 & 순수성 (pure-pwa.com)과 같은 작업이 있습니다.