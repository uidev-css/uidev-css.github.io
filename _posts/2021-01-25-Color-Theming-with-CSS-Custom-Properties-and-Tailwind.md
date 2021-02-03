---
layout: post
title: "CSS 사용자 정의 속성 및 Tailwind를 사용한 색상 테마
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/11/tailwind-custom-properties-color-theming.png
tags: CUSTOM PROPERTIES,TAILWIND,THEMING
---


사용자 정의 속성을 사용하면 코드를보다 효율적으로 만들 수있을뿐만 아니라 CSS로도 진정한 마법을 사용할 수 있습니다.
 그들이 큰 잠재력을 가진 한 영역은 테마입니다.
 Atomic Smash에서는 스타일 작성을 위해 유틸리티 클래스 프레임 워크 인 Tailwind CSS를 사용합니다.
 이 기사에서는 사용자 정의 속성을 테마에 사용하는 방법과이를 Tailwind와 통합하여 코드의 재사용 성을 극대화하는 방법을 살펴 보겠습니다.
 Tailwind를 시작하고 실행하는 방법은 다루지 않겠습니다. 공식 문서를 확인하세요. 처음 사용하는 경우에도 이러한 도움말 중 일부가 유용 할 수 있습니다.
 

### 테마 개요
 

제목, 본문 문구, 버튼이있는 `클릭 유도 문안`(CTA) 구성 요소가 있다고 가정 해 보겠습니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/11/cta-red.png?resize=390%2C183&ssl=1)

이 색 구성표에 대해 일반 (Tailwind가 아닌) CSS를 작성하는 것은 다음과 같습니다.
 

```css
.cta {
  background-color: #742a2a; // dark red
  color: #ffffff; //white
}
    
.cta__heading {
  background-color: #e53e3e; // medium red
  color: #742a2a;
}
 
.cta__button {
  background-color: #e53e3e;
}
```

Tailwind를 사용하여 HTML에서 이러한 색상을 유틸리티 클래스로 적용합니다.
 

```html
<div class="bg-red-900 text-white">
  <h3 class="bg-red-600 text-red-900">Join our mailing list</h3>
  <div>
    <p>Be the first to hear about our new offerings</p>
    <button class="bg-red-600" type="button">Sign up</button>
  </div>
</div>
```

기본 색 구성표 이외의 다른 항목과 관련된 클래스를 의도적으로 생략했지만이 데모에서 전체 예제를 볼 수 있습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_jOrzvyV" src="//codepen.io/anon/embed/jOrzvyV?height=450&amp;theme-id=1&amp;slug-hash=jOrzvyV&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed jOrzvyV" title="CodePen Embed jOrzvyV" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이제 구성 요소에 다른 색 구성표를 적용하려면 원래 구성 요소의 색 값을 재정의해야합니다.
 Tailwind가 없으면이를 수행하는 일반적인 방법은 구성 요소 자체에 테마 클래스를 추가하고 캐스케이드에서 더 낮은 색상 값을 다시 정의하는 것입니다.
 따라서 수정 자 클래스가`.cta--blue` (BEM 규칙 사용) 인 구성 요소의 경우 파란색 색 구성표에 CSS 값을 적용합니다.
 

```css
.cta--blue {
  background-color: #2a4365; // dark blue
}
 
.cta--blue .cta__heading {
  background-color: #3182ce; // medium blue
  color: #2a4365;
}
 
.cta--blue .cta__button {
  background-color: #3182ce;
}
```

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/11/cta-blue.png?resize=391%2C183&ssl=1)

Sass 또는 다른 전처리기를 사용하는 경우 해당 색상 이름에 변수를 사용하여 삶을 더 쉽게 만들고`.cta__heading` 및`.cta__body` 선택기를 중첩 할 수 있습니다.
 코드를 더 간결하게 만드는 것은 아니지만 단일 위치에서 해당 값을 업데이트 할 수 있으므로 더 쉽게 관리 할 수 있습니다.
 

이제 최근 프로젝트에서 경험 한 것처럼 10 가지 색 구성표가 있다고 가정합니다.
 색상 값을 변경하기 위해 기본적으로 위의 예제를 10 번 복제하므로 코드가 길어지기 시작합니다.
 이제 디자인 시스템의 모든 구성 요소에 10 가지 색 구성표가 필요하며 이러한 구성 요소 중 많은 부분이 단순한 CTA보다 훨씬 더 복잡하다고 상상해보십시오.
 테마에도 다른 글꼴이 필요할 수 있습니다.
 갑자기 작성해야 할 CSS가 많이 생겼습니다.
 

### Tailwind를 사용한 테마
 

반면 Tailwind를 사용하는 경우 HTML 자체에서 여러 클래스를 변경해야합니다.
 React 또는 Vue와 같은 JavaScript 프레임 워크를 사용하더라도 이것은 정확히 간단한 작업이 아닙니다.
 프로덕션 빌드에서 사용되지 않는 스타일을 제거하기 위해 Tailwind는 클래스 이름 (작성 당시)에 문자열 연결 사용을 권장하지 않습니다.
 따라서 테마를 구축하는 것은 잠재적으로 많은 로직을 구성 요소에 쌓는 것을 의미합니다.
 

### 사용자 지정 속성을 사용한 테마
 

색상 테마에 사용자 지정 속성을 사용하면 작성해야하는 코드의 양을 대폭 줄이고 유지 관리 부담을 줄일 수 있습니다.
 먼저 일반 CSS에서이를 수행하는 방법을 살펴 보겠습니다.
 

사용자 정의 속성을 : root 선택기에서 변수로 정의하여 전역 변수로 만듭니다.
 (본문 선택기는 우리에게도 도움이 될 것입니다.) 그런 다음 색상 속성 값 대신 선택기에서 해당 변수를 사용할 수 있습니다.
 

```css
:root {
  --primary: #742a2a; // dark red;
  --secondary: #e53e3e; // medium red
}
 
.cta {
  background-color: var(--primary);
  color: white;
}
 
.cta__heading {
  background-color: var(--secondary);
  color: var(--primary);
}
 
.cta__button {
  background-color: var(--secondary);
}
```

이것이 진정한 마술이 일어나는 곳입니다. 이제 각 테마를 만드는 코드는 이러한 사용자 지정 속성 값만 업데이트하는 경우가됩니다.
 새 값은 테마 클래스를 적용 할 때마다 상속됩니다.
 

```css
.th-blue {
  --primary: #2a4365; // dark blue
  --secondary: #3182ce; // medium blue
}
```

파란색 색 구성표를 원하면`.th-blue` 클래스를 구성 요소에 적용하거나`<body>`태그에 적용하여 페이지 전체 테마를 적용 할 수 있습니다.
 원하는대로 개별 구성 요소.
 유틸리티 클래스를 사용하면 코드베이스의 모든 곳에 적용 할 수 있으므로 구성 요소 별 클래스 (예 : 원래 코드의`.cta--blue`)에 비해 더 많은 코드를 작성할 수 있습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_oNLdeBM" src="//codepen.io/anon/embed/oNLdeBM?height=450&amp;theme-id=1&amp;slug-hash=oNLdeBM&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed oNLdeBM" title="CodePen Embed oNLdeBM" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 이전 브라우저 처리
 

많은 대행사와 마찬가지로 Atomic Smash의 많은 고객은 여전히 Internet Explorer 11을 지원해야합니다. 저는 대부분의 경우 점진적 향상 접근 방식에 대해 괜찮습니다 (CSS Grid를 지원하지 않는 브라우저에 대해 더 간단한 대체 레이아웃을 제공함으로써
 예) 테마는 종종 쉬운 타협을 허용하지 않는 영역 중 하나입니다.
 클라이언트는 이전 브라우저에서도 브랜드 색상과 글꼴이 표시되기를 원합니다.
 기능 쿼리를 사용하여 대체를 제공하려면 처음에 사용자 지정 속성을 사용하는 이점을 무효화하는 많은 추가 작업이 필요합니다.
 이를 극복하려면 폴리 필이 필요합니다.
 

IE 11에는 사용자 지정 속성을 폴리 필하는 몇 가지 옵션이 있습니다.
 

첫 번째는 postcss-custom-properties라는 PostCSS 플러그인을 사용하는 것입니다.
 워크 플로에서 이미 PostCSS를 사용하고 있다면 추가하기가 매우 간단합니다.
 CSS를 처리하고 변수의 결과를 속성 값으로 출력하여 작동합니다.
 따라서 다음 CSS가있는 경우 :
 

```css
:root {
  --color: red;
}
 
h1 {
  color: var(--color);
}
```

처리 된 결과는 다음과 같습니다.
 

```css
h1 {
  color: red;
  color: var(--color);
}
```

맞춤 속성을 지원하지 않는 브라우저는 두 번째 규칙을 무시하고 일반 속성 값으로 돌아갑니다.
 출력에서 사용자 정의 속성이있는 규칙을 제거하는 옵션도 있으므로 파일 크기가 더 작아집니다.
 즉, 변수를 동적으로 업데이트하는 경우 문제가되는 사용자 지정 속성은 브라우저에서 얻지 못하지만 악영향없이 코드의 정적 값에 사용할 수 있습니다.
 

불행히도이 polyfill에는 몇 가지 제한 사항이 있습니다.
 

- 사용자 정의 속성을 정의하는 구성에서 파일을 지정해야합니다.
 
- 사용자 지정 속성은`: root` 선택기에서만 정의 할 수 있습니다.
 

첫 번째 제한은 상대적으로 사소하지만 두 번째 제한은 안타깝게도이 폴리 필을 테마 사용 사례에 완전히 쓸모 없게 만듭니다.
 테마를 만들기 위해 선택기에서 변수를 재정의 할 수 없음을 의미합니다.
 

이 polyfill 옵션에는 CSS를 사전 처리하는 대신 클라이언트 측 스크립트를 제공하는 것이 포함됩니다.
 polyfill이 IE 11에서만로드되도록하기 위해 머리에 다음 스크립트를 추가 할 수 있습니다.
 

```html
<script>window.MSInputMethodContext && document.documentMode && document.write('<script src="https://cdn.jsdelivr.net/gh/nuxodin/ie11CustomProperties@4.1.0/ie11CustomProperties.min.js"><\/script>');</script>
```

이를 통해 여기의 예에서와 같이 사용자 지정 속성의 모든 이점을 누릴 수 있으므로이 솔루션을 사용하기로 결정했습니다.
 `스타일`속성에 설정된 맞춤 속성이 폴리 필되지 않는 제한이 있습니다.
 그러나 위의 테마 예제에 대해 테스트했으며 제대로 작동합니다.
 

### 그러나 이것이 Tailwind와 어떤 관련이 있습니까?
 

이미 살펴본 것처럼 유틸리티 클래스 (HTML의 어느 곳에 나 적용 할 수있는 단일 목적 클래스)를 사용하면 코드를보다 재사용 할 수 있습니다.
 이것이 Tailwind 및 기타 유틸리티 클래스 프레임 워크의 주요 판매 포인트입니다. 결과적으로 제공하는 CSS 파일의 크기가 작아야합니다.
 Tailwind는 여러 색상 클래스를 사용할 수 있도록합니다.`.bg-red-medium`은 빨간색`background-color` 속성 값을,`.text-red-medium`은`color`, 그리고`border`,`box
 -그림자`또는 색상 값이 필요할 수 있다고 생각할 수있는 모든 장소.
 

구성 파일에서 색상을 정의 할 수 있습니다.
 

Tailwind 클래스에 사용자 지정 속성 값을 사용하려면 구성에서 지정할 수 있습니다.
 

```js
module.exports = {
  theme: {
    colors: {
      'th-primary': 'var(--primary)',
      'th-secondary': 'var(--secondary)'
    }
  }
}
```

내 색상과 테마 관련 수업 이름 앞에`th-`를 붙여서 특별히 테마와 관련이 있음을 분명히하지만 자신에게 맞는 규칙을 자유롭게 사용하세요.
 

이제 이러한 클래스는 Tailwind를 통해 사용할 수 있습니다.
 `.bg-th-primary`를 사용하면 다음과 같은 결과를 얻을 수 있습니다.
 

```css
.some-element {
  background-color: var(--primary);
}
```

CSS에서 이전과 같이 테마에 대한 사용자 정의 속성을 정의 할 수 있습니다.
 

```css
:root {
  --primary: #742a2a;
  --secondary: #742a2a;
}
 
.th-blue {
  --primary: #2a4365;
  --secondary: #3182ce;
}
```

이러한 클래스를 HTML에 적용 해 보겠습니다.
 첫 번째 예제는 기본 테마 (: root에 정의 된 변수)가있는 구성 요소를 제공합니다.
 두 번째는 파란색 테마입니다.
 유일한 차이점은 구성 요소에`.th-blue` 클래스가 추가 된 것입니다.
 (간결하고 명확하게하기 위해 주제와 관련없는 수업은 다시 한 번 생략했습니다.)
 

```html
<!--Component with default (red) theme-->
<div class="bg-th-primary">
  <h3 class="bg-th-secondary text-th-primary">Join our mailing list</h3>
  <div>
    <p>Be the first to hear about our new offerings</p>
    <button class="bg-th-secondary" type="button">Sign up</button>
  </div>
</div>
 
<!--Component with blue theme-->
<div class="th-blue bg-th-primary">
  <h3 class="bg-th-secondary text-th-primary">Join our mailing list</h3>
  <div>
    <p>Be the first to hear about our new offerings</p>
    <button class="bg-th-secondary" type="button">Sign up</button>
  </div>
</div>
```

### 구성을 스타일 가이드로 사용
 

Tailwind는 구성의 모든 변수를 정의하도록 권장하며 개인적으로 더 나은 접근 방식이라는 데 동의합니다.
 이는 구성 파일이 (잠재적으로) 색상 및 기타 테마 값을 정의하기 위해 여러 위치로 끝나는 것이 아니라 단일 진실 소스가 될 수 있음을 의미합니다.
 다행히도 사용자 지정 속성에 Tailwind 구성 파일의 값을 사용할 수도 있습니다.
 먼저 구성에서 모든 색상을 정의해야합니다 (Tailwind에 포함 된 기본 색상 팔레트를 사용하지 않는다고 가정).
 

```js
module.exports = {
  theme: {
    colors: {
      red: {
        medium: '#e53e3e',
        dark: '#742a2a'
      },
      blue: {
        medium: '#3182ce',
        dark: '#2a4365'
      },
      'th-primary': 'var(--primary)',
      'th-secondary': 'var(--secondary)'
    }
  }
}
```

그런 다음 CSS에서 테마 개체에 액세스 할 수 있습니다.
 

```css
:root {
  --primary: theme('colors.red.dark');
  --secondary: theme('colors.red.medium');
}
 
.th-blue {
  --primary: theme('colors.blue.dark');
  --secondary: theme('colors.blue.medium');
}
```

### 마무리
 verified_user

브라우저 지원에 대해 걱정할 필요없이 사용자 지정 속성을 사용할 수 있다는 이점에 대해 정말 기쁩니다.이를 통해 기존 워크 플로와 원활하게 통합 할 수 있습니다.
 그들이 테마를 위해 우리를 절약 할 시간의 양을 과장하기는 어렵습니다.
 Tailwind 사용자가 아니더라도이 도움말에서이 사용 사례에 맞춤 속성을 제공하는 것이 좋습니다.
 