---
layout: post
title: "FOUT과 싸우고 등대를 행복하게 만드는 방식으로 글꼴을로드하는 방법
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2019/06/google-lighthouse.png
tags: FONT LOADING,LIGHTHOUSE,RENDERING
---


웹 글꼴 워크 플로우는 간단합니다.
 멋진 웹용 글꼴 몇 개를 선택하고 HTML 또는 CSS 코드 조각을 가져 와서 프로젝트에 넣고 제대로 표시되는지 확인합니다.
 사람들은 Google Fonts를 사용하여 하루에 수많은 작업을 수행하며`<link>`태그를`<head>`에 추가합니다.
 

Lighthouse가이 워크 플로우에 대해 무엇을 말하는지 살펴 보겠습니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/11/P7giOAfg.png?resize=1024%2C486&ssl=1)

책, 문서 및 HTML 표준에 따라 모든 작업을 수행했는데 Lighthouse가 모든 것이 잘못되었다고 말하는 이유는 무엇입니까?
 

렌더링 차단 리소스로 글꼴 스타일 시트를 제거하는 방법에 대해 이야기하고 Lighthouse를 행복하게 만들뿐만 아니라 일반적으로 글꼴로드와 함께 제공되는 스타일이 지정되지 않은 텍스트 (FOUT)의 무서운 플래시를 극복하는 최적의 설정을 살펴 보겠습니다.
 모든 기술 스택에 적용 할 수 있도록 기본 HTML, CSS 및 JavaScript로 모든 작업을 수행합니다.
 보너스로 Gatsby 구현과 이에 대한 간단한 드롭 인 솔루션으로 개발 한 플러그인도 살펴볼 것입니다.
 

### "렌더링 차단"글꼴의 의미
 

브라우저가 웹 사이트를로드 할 때 DOM, 즉 HTML 및 CSSOM의 개체 모델, 즉 모든 CSS 선택기의 맵에서 렌더링 트리를 생성합니다.
 렌더 트리는 브라우저가 페이지를 렌더링하기 위해 거치는 단계를 나타내는 중요한 렌더링 경로의 일부입니다.
 브라우저가 페이지를 렌더링하려면 HTML 문서와 해당 HTML에 링크 된 모든 CSS 파일을로드하고 구문 분석해야합니다.
 

다음은 Google Fonts에서 직접 가져온 상당히 일반적인 글꼴 스타일 시트입니다.
 

```css
@font-face {
  font-family: 'Merriweather';
  src: local('Merriweather'), url(https://fonts.gstatic.com/...) format('woff2');
}
```

글꼴 스타일 시트는 보통 몇 개의`@ font-face` 정의를 포함하기 때문에 파일 크기 측면에서 작다고 생각할 수 있습니다.
 렌더링에 눈에 띄는 영향이 없어야합니다.
 

외부 CDN에서 CSS 글꼴 파일을로드한다고 가정 해 보겠습니다.
 웹 사이트가로드되면 브라우저는 해당 파일이 CDN에서로드되고 렌더 트리에 포함될 때까지 기다려야합니다.
 뿐만 아니라 CSS`@ font-face` 정의에서 URL 값으로 참조되는 글꼴 파일이 요청되고로드 될 때까지 기다려야합니다.
 

결론 : 글꼴 파일은 중요한 렌더링 경로의 일부가되어 페이지 렌더링 지연을 증가시킵니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/11/5stamK7w.png?resize=1024%2C388&ssl=1)

일반 사용자에게 웹 사이트에서 가장 중요한 부분은 무엇입니까?
 물론 내용입니다.
 그렇기 때문에 웹 사이트 로딩 프로세스에서 가능한 한 빨리 콘텐츠를 사용자에게 표시해야합니다.
 이를 위해서는 중요한 렌더링 경로를 중요한 리소스 (예 : HTML 및 중요 CSS)로 축소해야하며, 페이지가 렌더링 된 후 다른 모든 항목이로드되고 글꼴이 포함됩니다.
 

사용자가 느리고 불안정한 연결에서 최적화되지 않은 웹 사이트를 탐색하는 경우 글꼴 파일 및 기타 중요한 리소스가로드를 완료 할 때까지 기다리는 빈 화면에 앉아 짜증을냅니다.
 결과?
 사용자가 매우 인내하지 않는 한 페이지가 전혀로드되지 않는다고 생각하면서 포기하고 창을 닫을 가능성이 있습니다.
 

그러나 중요하지 않은 리소스가 지연되고 콘텐츠가 가능한 한 빨리 표시되는 경우 사용자는 웹 사이트를 탐색하고 누락 된 프레젠테이션 스타일 (예 : 글꼴)을 무시할 수 있습니다. 즉,
 내용의 방법.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/11/qpzhshZQ.jpeg?resize=2386%2C1000&ssl=1)

### 글꼴을로드하는 최적의 방법
 

여기서 바퀴를 재발 명 할 필요가 없습니다.
 Harry Roberts는 이미 웹 글꼴을로드하는 최적의 방법을 설명하는 훌륭한 작업을 수행했습니다.
 그는 Google Fonts의 철저한 조사와 데이터를 사용하여 매우 자세하게 설명하고 모든 것을 4 단계 프로세스로 요약합니다.
 

- 글꼴 파일 원본에 미리 연결합니다.
 
- 낮은 우선 순위로 글꼴 스타일 시트를 비동기 적으로 미리로드합니다.
 
- 콘텐츠가 JavaScript로 렌더링 된 후 글꼴 스타일 시트와 글꼴 파일을 비동기 적으로로드합니다.
 
- JavaScript가 꺼진 사용자에게 대체 글꼴을 제공하십시오.
 

Harry의 접근 방식을 사용하여 글꼴을 구현해 보겠습니다.
 

```html
<!-- https://fonts.gstatic.com is the font file origin -->
<!-- It may not have the same origin as the CSS file (https://fonts.googleapis.com) -->
<link rel="preconnect"
      href="https://fonts.gstatic.com"
      crossorigin />

<!-- We use the full link to the CSS file in the rest of the tags -->
<link rel="preload"
      as="style"
      href="https://fonts.googleapis.com/css2?family=Merriweather&display=swap" />

<link rel="stylesheet"
      href="https://fonts.googleapis.com/css2?family=Merriweather&display=swap"
      media="print" onload="this.media='all'" />

<noscript>
  <link rel="stylesheet"
        href="https://fonts.googleapis.com/css2?family=Merriweather&display=swap" />
</noscript>
```

글꼴 스타일 시트 링크에서`media = "print"`를 확인하세요.
 브라우저는 자동으로 인쇄 스타일 시트에 낮은 우선 순위를 부여하고 중요한 렌더링 경로의 일부로 제외합니다.
 인쇄 스타일 시트가로드 된 후 `onload`이벤트가 발생하고 미디어가 기본 `all`값으로 전환되며 글꼴이 모든 미디어 유형 (화면, 인쇄 및 음성)에 적용됩니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/11/z1DxMG3A.png?resize=1024%2C217&ssl=1)

글꼴 자체 호스팅도 렌더링 차단 문제를 해결하는 데 도움이 될 수 있지만 항상 옵션은 아닙니다.
 예를 들어 CDN을 사용하는 것은 불가피 할 수 있습니다.
 경우에 따라 정적 리소스를 제공 할 때 CDN이 무거운 작업을 수행하도록하는 것이 좋습니다.
 

이제 최적의 비 렌더링 차단 방식으로 글꼴 스타일 시트와 글꼴 파일을로드하고 있지만 사소한 UX 문제를 도입했습니다.
 

### 스타일이 지정되지 않은 텍스트 플래시 (FOUT)
 

이것이 우리가 FOUT이라고 부르는 것입니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/11/nqWflG8k.gif?resize=800%2C243&ssl=1)

왜 그럴까요?
 렌더링 차단 리소스를 제거하려면 페이지 콘텐츠가 렌더링 된 후 (즉, 화면에 표시됨)로드해야합니다.
 중요 리소스 이후에 비동기 적으로로드되는 우선 순위가 낮은 글꼴 스타일 시트의 경우 사용자는 글꼴이 대체 글꼴에서 다운로드 된 글꼴로 변경되는 순간을 볼 수 있습니다.
 뿐만 아니라 페이지 레이아웃이 이동하여 웹 글꼴이로드 될 때까지 일부 요소가 깨져 보일 수 있습니다.
 

FOUT을 처리하는 가장 좋은 방법은 대체 글꼴과 웹 글꼴 사이를 부드럽게 전환하는 것입니다.
 이를 달성하려면 다음이 필요합니다.
 

- 가능한 한 비동기 적으로로드 된 글꼴과 일치하는 적절한 대체 시스템 글꼴을 선택하십시오.
 
- 대체 글꼴의 글꼴 스타일 (`font-size`,`line-height`,`letter-spacing` 등)을 다시 비동기 적으로로드 된 글꼴의 특성과 일치하도록 최대한 가깝게 조정합니다.
 
- 비동기 적으로로드 된 글꼴 파일이 렌더링되면 대체 글꼴의 스타일을 지우고 새로로드 된 글꼴을위한 스타일을 적용합니다.
 

Font Style Matcher를 사용하여 최적의 대체 시스템 글꼴을 찾고 사용할 웹 글꼴에 맞게 구성 할 수 있습니다.
 대체 글꼴과 웹 글꼴 모두에 대한 스타일이 준비되면 다음 단계로 넘어갈 수 있습니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/11/4_XbUCyA.png?resize=1492%2C950&ssl=1)

CSS 글꼴로드 API를 사용하여 웹 글꼴이로드 된시기를 감지 할 수 있습니다.
 왜 그럴까요?
 Typekit의 웹 글꼴 로더는 한때이를 수행하는 가장 인기있는 방법 중 하나였으며 계속 사용하거나 유사한 라이브러리를 사용하고 싶지만 다음 사항을 고려해야합니다.
 

- 4 년 넘게 업데이트되지 않았습니다. 즉, 플러그인 측면에서 중단되거나 새로운 기능이 필요한 경우 아무도이를 구현하고 유지 관리하지 않을 것입니다.
 
- 이미 Harry Roberts의 스 니펫을 사용하여 비동기로드를 효율적으로 처리하고 있으며 글꼴을로드하기 위해 JavaScript에 의존 할 필요가 없습니다.
 

저에게 물어 보면 Typekit과 같은 라이브러리를 사용하는 것은 이와 같은 간단한 작업에 너무 많은 JavaScript입니다.
 타사 라이브러리 및 종속성을 사용하지 않기를 원하므로 솔루션을 직접 구현하고 과도한 엔지니어링없이 최대한 간단하고 간단하게 만들도록 노력하겠습니다.
 

CSS Font Loading API는 실험적인 기술로 간주되지만 약 95 %의 브라우저 지원을 제공합니다.
 그러나 어쨌든 API가 변경되거나 향후 지원이 중단되는 경우 대체 방법을 제공해야합니다.
 글꼴을 잃어 버릴 위험은 문제가되지 않습니다.
 

CSS Font Loading API를 사용하여 글꼴을 동적 및 비동기 적으로로드 할 수 있습니다.
 우리는 이미 글꼴로드와 같은 단순한 작업을 위해 JavaScript에 의존하지 않기로 결정했으며, 사전로드 및 사전 연결이있는 일반 HTML을 사용하여 최적의 방식으로 해결했습니다.
 글꼴이로드되고 사용 가능한지 확인하는 데 도움이되는 API의 단일 함수를 사용합니다.
 

```js
document.fonts.check("12px 'Merriweather'");
```

`check ()`함수는 함수 인수에 지정된 글꼴을 사용할 수 있는지 여부에 따라`true` 또는`false`를 반환합니다.
 글꼴 크기 매개 변수 값은 사용 사례에 중요하지 않으며 어떤 값으로도 설정할 수 있습니다.
 그래도 다음 사항을 확인해야합니다.
 

- 웹 글꼴 선언이 적용된 문자가 하나 이상 포함 된 페이지에 HTML 요소가 하나 이상 있습니다.
 예에서는`& nbsp;`를 사용하지만 시각이있는 사용자와 시각이없는 사용자 모두에게 숨겨져있는 한 (`display : none;`을 사용하지 않고) 모든 캐릭터가 작업을 수행 할 수 있습니다.
 API는 글꼴 스타일이 적용된 DOM 요소를 추적합니다.
 페이지에 일치하는 요소가없는 경우 API는 글꼴이로드되었는지 여부를 확인할 수 없습니다.
 
- `check ()`함수 인수에 지정된 글꼴은 정확히 CSS에서 호출 된 글꼴입니다.
 

다음 데모에서 CSS 글꼴로드 API를 사용하여 글꼴로드 리스너를 구현했습니다.
 예를 들어 글꼴 및 리스너로드는 버튼을 클릭하여 시작되어 페이지로드를 시뮬레이션하므로 변경 사항이 발생하는 것을 볼 수 있습니다.
 일반 프로젝트에서는 웹 사이트가로드되고 렌더링 된 직후에 발생합니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_Exyemav" src="//codepen.io/anon/embed/Exyemav?height=450&amp;theme-id=1&amp;slug-hash=Exyemav&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed Exyemav" title="CodePen Embed Exyemav" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

대단하지 않나요?
 CSS Font Loading API에서 잘 지원되는 기능 덕분에 간단한 글꼴로드 리스너를 구현하는 데 30 줄도 채 안되는 JavaScript가있었습니다.
 또한이 과정에서 두 가지 가능한 예외 사례를 처리했습니다.
 

- API에 문제가 있거나 일부 오류가 발생하여 웹 글꼴이로드되지 않습니다.
 
- 사용자가 JavaScript를 끈 상태에서 웹 사이트를 탐색하고 있습니다.
 

이제 글꼴 파일로드가 완료되면 감지하는 방법이 있으므로 웹 글꼴과 일치하도록 대체 글꼴에 스타일을 추가하고 FOUT을보다 효과적으로 처리하는 방법을 확인해야합니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_dyXqWZw" src="//codepen.io/anon/embed/dyXqWZw?height=450&amp;theme-id=1&amp;slug-hash=dyXqWZw&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed dyXqWZw" title="CodePen Embed dyXqWZw" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

대체 글꼴과 웹 글꼴 사이의 전환이 부드러워 보이며 훨씬 덜 눈에 띄는 FOUT을 달성했습니다!
 복잡한 사이트에서 이러한 변경으로 인해 레이아웃 이동이 줄어들고 콘텐츠 크기에 의존하는 요소가 깨지거나 제자리에서 벗어나지 않습니다.
 

### 내부에서 일어나는 일
 

HTML부터 시작하여 이전 예제의 코드를 자세히 살펴 보겠습니다.
 `<head>`요소에 스 니펫이있어 사전로드, 사전 연결 및 폴백을 사용하여 비동기 적으로 글꼴을로드 할 수 있습니다.
 

```html
<body class="no-js">
  <!-- ... Website content ... -->
  <div aria-visibility="hidden" class="hidden" style="font-family: '[web-font-name]'">
      /* There is a non-breaking space here */
  </div>
  <script> 
    document.getElementsByTagName("body")[0].classList.remove("no-js");
  </script>
</body>
```

`<body>`요소에 하드 코딩 된`.no-js` 클래스가 있습니다.이 클래스는 HTML 문서가로드되는 순간 제거됩니다.
 이것은 JavaScript가 비활성화 된 사용자에게 웹 폰트 스타일을 적용합니다.
 

둘째, CSS Font Loading API가 글꼴을 추적하고 스타일을 적용하기 위해 하나의 문자가있는 HTML 요소가 하나 이상 필요하다는 것을 기억하십니까?
 `display : none;`을 사용할 수 없기 때문에 시각 장애인과 비 시각 사용자 모두에게 접근 가능한 방식으로 숨기고있는`& nbsp;`문자가있는`<div>`를 추가했습니다.
 이 요소에는 인라인`font-family : `Merriweather`` 스타일이 있습니다.
 이를 통해 대체 스타일과로드 된 글꼴 스타일 사이를 원활하게 전환 할 수 있으며 페이지에서 사용되는지 여부에 관계없이 모든 글꼴 파일이 제대로 추적되는지 확인할 수 있습니다.
 

`& nbsp;`문자는 코드 스 니펫에 표시되지 않지만 거기에 있습니다!
 

CSS는 가장 간단한 부분입니다.
 HTML로 하드 코딩되거나 JavaScript로 조건부로 적용된 CSS 클래스를 활용하여 다양한 글꼴 로딩 상태를 처리 할 수 있습니다.
 

```css
body:not(.wf-merriweather--loaded):not(.no-js) {
  font-family: [fallback-system-font];
  /* Fallback font styles */
}
 
.wf-merriweather--loaded,
.no-js {
  font-family: "[web-font-name]";
  /* Webfont styles */
}
 
/* Accessible hiding */
.hidden {
  position: absolute; 
  overflow: hidden; 
  clip: rect(0 0 0 0); 
  height: 1px;
  width: 1px; 
  margin: -1px;
  padding: 0;
  border: 0; 
}
```

JavaScript는 마법이 일어나는 곳입니다.
 앞서 설명한 것처럼 CSS Font Loading API의`check ()`함수를 사용하여 글꼴이로드되었는지 확인합니다.
 다시 말하지만 글꼴 크기 매개 변수는 모든 값 (픽셀 단위)이 될 수 있습니다.
 로드하는 글꼴의 이름과 일치해야하는 글꼴 모음 값입니다.
 

```js
var interval = null;
 
function fontLoadListener() {
  var hasLoaded = false;
 
  try {
    hasLoaded = document.fonts.check('12px "[web-font-name]"')
  } catch(error) {
    console.info("CSS font loading API error", error);
    fontLoadedSuccess();
    return;
  }
  
  if(hasLoaded) {
    fontLoadedSuccess();
  }
}
 
function fontLoadedSuccess() {
  if(interval) {
    clearInterval(interval);
  }
  /* Apply class names */
}
 
interval = setInterval(fontLoadListener, 500);
```

여기서 일어나는 일은 정기적으로 실행되는`fontLoadListener ()`로 리스너를 설정하는 것입니다.
 이 함수는 가능한 한 간단해야 간격 내에서 효율적으로 실행됩니다.
 try-catch 블록을 사용하여 오류를 처리하고 문제를 포착하여 자바 스크립트 오류가 발생한 경우에도 웹 글꼴 스타일이 계속 적용되어 사용자가 UI 문제를 경험하지 않도록합니다.
 

다음으로 `fontLoadedSuccess ()`를 사용하여 글꼴이 성공적으로로드되는시기를 고려합니다.
 검사가 불필요하게 이후에 실행되지 않도록 먼저 간격을 지워야합니다.
 여기에서 웹 글꼴 스타일을 적용하는 데 필요한 클래스 이름을 추가 할 수 있습니다.
 

그리고 마지막으로 간격을 시작합니다.
 이 예에서는 최대 500ms로 설정 했으므로 함수가 초당 두 번 실행됩니다.
 

### 다음은 Gatsby 구현입니다.
 

Gatsby는 바닐라 웹 개발 (및 일반 create-react-app 기술 스택)과 다른 몇 가지 작업을 수행하므로 여기에서 다룬 내용을 구현하기가 약간 까다로워집니다.
 

이를 쉽게하기 위해 로컬 Gatsby 플러그인을 개발할 것이므로 글꼴 로더와 관련된 모든 코드는 아래 예에서`plugins / gatsby-font-loader`에 있습니다.
 

글꼴 로더 코드와 구성은 세 가지 주요 Gatsby 파일로 분할됩니다.
 

- 플러그인 구성 (`gatsby-config.js`) : 프로젝트에 로컬 플러그인을 포함하고 모든 로컬 및 외부 글꼴과 해당 속성 (글꼴 이름 및 CSS 파일 URL 포함)을 나열하고 모든 사전 연결 URL을 포함합니다.
 .
 
- 서버 측 코드 (`gatsby-ssr.js`) : 구성을 사용하여 Gatsby API의`setHeadComponents` 함수를 사용하여 HTML`<head>`에 사전로드 및 사전 연결 태그를 생성하고 포함합니다.
 그런 다음 글꼴을 숨기고`setPostBodyComponents`를 사용하여 HTML에 포함하는 HTML 스 니펫을 생성합니다.
 
- 클라이언트 측 코드 (`gatsby-browser.js`) :이 코드는 페이지가로드 된 후 React가 시작된 후 실행되므로 이미 비동기 상태입니다.
 즉, react-helmet을 사용하여 글꼴 스타일 시트 링크를 삽입 할 수 있습니다.
 또한 FOUT을 처리하기 위해 글꼴로드 리스너를 시작합니다.
 

다음 CodeSandbox 예제에서 Gatsby 구현을 확인할 수 있습니다.
 

이 중 일부는 복잡합니다.
 고성능, 비동기 글꼴 로딩 및 FOUT 버스 팅을위한 간단한 드롭 인 솔루션을 원하신다면이를 위해 gatsby-omni-font-loader 플러그인을 개발했습니다.
 이 기사의 코드를 사용하며 적극적으로 유지 관리하고 있습니다.
 제안, 버그 보고서 또는 코드 기여가 있으면 언제든지 GitHub에 제출하십시오.
 

### 결론
 

콘텐츠는 웹 사이트에서 사용자의 경험에 가장 중요한 요소 일 것입니다.
 콘텐츠가 최우선 순위를 차지하고 가능한 한 빨리로드되도록해야합니다.
 이는로드 프로세스에서 최소한의 프레젠테이션 스타일 (즉, 인라인 된 중요 CSS)을 사용하는 것을 의미합니다.
 그렇기 때문에 대부분의 경우 웹 글꼴이 중요하지 않은 것으로 간주됩니다. 사용자는 콘텐츠 없이도 콘텐츠를 사용할 수 있으므로 페이지가 렌더링 된 후로드해도 좋습니다.
 

그러나 이로 인해 FOUT 및 레이아웃 이동이 발생할 수 있으므로 대체 시스템 글꼴과 웹 글꼴 사이를 원활하게 전환하려면 글꼴로드 리스너가 필요합니다.
 

여러분의 생각을 듣고 싶습니다!
 귀하의 프로젝트에서 웹 글꼴 로딩, 렌더링 차단 리소스 및 FOUT 문제를 어떻게 해결하고 있는지 의견을 통해 알려주십시오.
 

- 렌더링 차단 리소스 (web.dev) 제거
 
- WebFont 로딩 및 렌더링 최적화 (web.dev)
 
- 렌더링 차단 CSS (Google Web Fundamentals)
 
- 가장 빠른 Google 글꼴 (CSS Wizardry)
 
- CSS 기초 :보다 강력한 웹 타이포그래피를위한 대체 글꼴 스택 (CSS-Tricks)
 
- CSS 글꼴로드 API (MDN)
 
- 글꼴 스타일 매처
 