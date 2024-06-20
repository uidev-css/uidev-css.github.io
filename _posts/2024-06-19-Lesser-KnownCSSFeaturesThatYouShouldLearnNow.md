---
title: "지금 익히면 좋은 잘 알려지지 않은 CSS 기능들"
description: ""
coverImage: "/assets/img/2024-06-19-Lesser-KnownCSSFeaturesThatYouShouldLearnNow_0.png"
date: 2024-06-19 00:20
ogImage: 
  url: /assets/img/2024-06-19-Lesser-KnownCSSFeaturesThatYouShouldLearnNow_0.png
tag: Tech
originalTitle: "Lesser-Known CSS Features That You Should Learn Now"
link: "https://medium.com/gitconnected/lesser-known-css-features-that-you-should-learn-now-bebc4154e817"
---



<img src="/assets/img/2024-06-19-Lesser-KnownCSSFeaturesThatYouShouldLearnNow_0.png" />

WWW(월드 와이드 웹)의 발명은 정보를 전 세계적으로 공유하기 위한 새로운 디지털 시대를 만들어 냈습니다. 초기 WWW는 주요 웹 문서 요소 사이의 기본 스타일을 구분하기 위해 의미론적 HTML 태그를 사용하는 순수 HTML 문서만을 가졌습니다. 이후 CSS가 도입되어 의미론적 HTML 태그를 스타일링하는 간단한 키-값 기반 스타일링 언어로 발전했습니다. CSS는 발전함에 따라 현재 웹 디자이너들은 생산적이고 개발자 친화적인 구문을 사용하여 현대적인 스타일, 애니메이션, 반응형 요소, 그리고 이미지 필터를 만들 수 있습니다.

일반적으로 CSS는 미리 정의된 문자열 값 또는 숫자 값이 들어 있는 많은 전통적인 속성을 제공합니다. 현대 CSS 표준은 기본 키-값 구문을 넘어서 함수 및 중첩된 블록(즉, at-rules)을 제공하며, 또한 현대 CSS 구문은 가상 요소, 가상 클래스, 그리고 선택자 조합을 지원합니다. 이 모든 CSS 기능들은 표준 웹 브라우저에서 깔끔하게 작동하는 사용 가능하고 현대적인 웹사이트를 만들기 위해 개발자의 생산성을 향상시키기 위한 것입니다.

이 글에서는 대부분의 웹 디자이너가 자주 사용하지 않는 몇 가지 CSS 기능을 탐색해 보겠습니다. 덜 알려진 이러한 CSS 기능들을 숙달하여 고품질 디자인 요구 사항에 맞추어 CSS 기능을 최적으로 선택하여 생산적으로 웹사이트를 디자인할 수 있습니다!


<div class="content-ad"></div>

# 유동 디자인에서 수학 및 그리드 함수 사용하기

전통적인 반응형 디자인 개념은 개발자들에게 장치 뷰포트 크기에 기반하여 웹사이트 레이아웃을 조정하도록 권장합니다. 반면에, 유동 디자인 개념은 상대적인 단위와 CSS 수학 함수를 사용하여 전체 웹사이트 요소를 뷰포트 크기에 동적으로 조정하는 것을 권장합니다.

뷰포트 너비에 기반하여 제목 글꼴 크기를 동적으로 조정해야 한다고 가정해보겠습니다. 최소 및 최대 글꼴 크기 경계를 사용하여 이를 구현하기 위해 CSS clamp() 함수를 사용할 수 있습니다. 이를 한 줄의 솔루션으로 구현할 수 있습니다:

```js
<style>
  h1 { font-size: clamp(2.2em, 3vw + 1em, 2.5em) }
</style>

<h1>CSS 수학 함수</h1>
```

<div class="content-ad"></div>

위의 clamp 함수 호출은 3vw + 1em 표현식을 사용하여 글꼴 크기를 동적으로 설정하지만, 글꼴 크기가 2.2em 및 2.5em 범위를 넘지 못하도록 제한합니다. 아래 미리보기에서 확인할 수 있습니다:

![clamp function preview](https://miro.medium.com/v2/resize:fit:1400/1*w5nqPkbGDo0Lqq-TM2vtcg.gif)

마찬가지로 min() 및 max() 함수를 사용하여 동적으로 계산된 숫자형 CSS 값을 하나의 경계로만 사용할 수 있습니다. 예를 들어, 다음 CSS 코드는 이전 clamp() 함수 예제의 상한선을 제거합니다:

```css
h1 { font-size: max(2.2em, 3vw + 1em) }
```

<div class="content-ad"></div>

슬기로운 디자인 원칙을 따라 레이아웃 요소의 간격 및 크기를 조절하는 데 CSS 수학 함수를 사용할 수 있어요. 또한, 현대 CSS에는 미디어 쿼리를 사용하지 않고 반응형을 개선하기 위한 플루이드 디자인을 구현할 수 있는 그리드 중심 함수들이 여럿 제공돼요.

다음 HTML 코드 스니펫을 살펴보세요:

```js
<style>
  .container {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(20em, 1fr));
    grid-gap: 1em;
    justify-self: center;

    > div {
      background: #ddd;
      padding: calc(2vw + 0.5em);
      font-size: calc(1vw + 1em); 
      font-weight: bold;
      text-align: center;
      border-radius: 0.5em;
    }
  }
</style>   
<div class="container">
  <div>Block 1</div>
  <div>Block 2</div>
  <div>Block 3</div>
  <div>Block 4</div>
</div>
```

위의 HTML 스니펫은 repeat() 및 minmax() CSS 그리드 함수를 사용하여 뷰포트 너비를 기준으로 동적 그리드 열 크기를 갖는 플루이드 디자인을 렌더링해요. 아래 미리보기에서 확인할 수 있어요.

<div class="content-ad"></div>


![image](https://miro.medium.com/v2/resize:fit:1400/1*vgI9wo0MaP4SriLdBTR3bw.gif)

Utopia fluid design methodology 웹사이트에서 유체 디자인 원칙에 대해 더 읽을 수 있어요.

# CSS Math Stepped Value Functions 사용하기

대부분의 일반 목적 프로그래밍 언어는 일반적인 수학 알고리즘을 구현하기 위한 십진 반올림 함수와 내장된 나머지/모듈로 연산자를 제공합니다. CSS 명세는 여전히 뷰포트 높이를 기반으로 컨테이너 높이를 계산하는 데 사용하는 구식(calc()) 함수가 인기를 얻은 후 더 많은 수학 함수를 소개하기 시작했어요.


<div class="content-ad"></div>

2024년 이후로 인기 있는 모든 웹 브라우저는 CSS 엔진에 round(), rem(), 그리고 mod() 스텝 값 함수들을 추가하는 작업을 완료했습니다. 이러한 함수들은 다른 값에 기반하여 스텝 값들을 생성하는 데 도움이 되기 때문에 스텝 값 함수로 소개되었습니다.

--width CSS 변수를 사용하여 1부터 1000 사이의 픽셀 값을 보낼 때, JavaScript를 사용하지 않고 가장 가까운 10을 사용해야 할 경우가 있다고 상상해 봅시다. 다음 CSS 코드 스니펫이 그 역할을 합니다:

```js
<style>
  :root { --width: 527px }
  .container {
    background: #aaa;
    width: round(var(--width), 25px);
    height: 2em;
  }
</style>   

<div class="container"></div>
```

위의 HTML 스니펫을 브라우저에서 실행하고 --width 변수를 증가시켜보세요. 컨테이너의 너비는 25로 나누어 떨어지는 픽셀 값으로만 업데이트됩니다. 아래 미리보기에서 확인할 수 있습니다:

<div class="content-ad"></div>


![Image](https://miro.medium.com/v2/resize:fit:1400/1*IVJjCjbFsDpcMGhr1rh_lQ.gif)

round() 함수는 공식 MDN 문서에 설명된 대로 개발자가 반올림 전략을 사용자 정의할 수 있도록 합니다.

rem() 함수는 CSS 내에서 JavaScript의 % 연산자를 사용하여 특정 나눈 수와 나누는 수의 나머지를 찾아주는 도움이 됩니다. 다음 CSS 코드 스니펫에서 보여지는 것처럼요:

```css
:root {
  --width: 50em;
  --block: 15em;
  --extra: rem(var(--width), var(--block));  /* --extra: 5em */
}
```

<div class="content-ad"></div>

mod() 함수의 동작은 rem() 함수와 유사하지만 결과는 항상 나눗셈자의 부호를 취합니다.

이러한 단계별 값 함수들은 여전히 2024년 기준으로 현재이므로 제작 웹사이트에서 사용하기 전에 기다려야 할 수도 있습니다.

# 전통적인 반응형 디자인을 넘어서 미디어 쿼리 활용하기

과거 대부분의 웹사이트는 고정 너비를 사용했으며 일부는 더 나은 사용성을 위해 사용자가 필요로 하는 특정 화면 해상도까지 언급하기도 했습니다. 과거 개발자들은 이동 트래픽이 증가함에 따라, 서브도메인을 사용하여 별도의 웹사이트를 구축하기도 했습니다. 2010년 경에는 반응형 디자인 개념이 소개되어 CSS 미디어 쿼리를 사용하여 다양한 화면에 대해 매우 사용하기 쉬운 웹사이트 레이아웃을 렌더링하는 방법이 도입되었습니다.

<div class="content-ad"></div>

우리 모두는 미디어 쿼리를 사용한 반응형 디자인 기술에 대해 알고 있습니다. 미디어 쿼리는 반응형 디자인에만 적용되는 것이 아니라 일부 다른 중요한 사용 사례를 해결하기도 합니다.

미디어 쿼리를 사용하여 인쇄 가능한 문서에 대한 사용자 정의 스타일을 제공할 수 있습니다. 화면 전용 세그먼트를 숨기는 방식으로 가능합니다:

```js
@media print {
  header, footer {
    display: none;
  }
} 
```

인쇄 미리보기 창을 사용하여 인쇄 미디어 유형을 테스트할 수 있으니, 위의 CSS 코드 스니펫을 현대적인 웹페이지에 추가하고 Ctrl + P 키 조합을 눌러보세요.

<div class="content-ad"></div>

웹 전체 화면 모드에 대한 스타일을 조정할 수 있습니다. 다음과 같이 display-mode 미디어 쿼리 기능을 사용하면 됩니다:

```js
@media (display-mode: fullscreen) {
  body {
    margin: 0;
    padding: 2em;
    border: 0.5em solid #aaa;
  }
}
```

위의 CSS 코드 조각은 전체 화면 모드에서만 테두리를 적용합니다. 또한 aspect-ratio 미디어 쿼리 기능을 사용하여 장치의 가로세로 비율도 확인할 수 있습니다:

```js
@media (aspect-ratio: 16 / 9) {
  body { background: darkcyan }
}
```

<div class="content-ad"></div>

크롬 장치 모드를 사용하면 위의 코드 스니펫을 테스트할 수 있습니다. 아래 미리보기에서 확인할 수 있습니다:

![이미지](https://miro.medium.com/v2/resize:fit:1400/1*Ub5ot2L0jo82ttIZAvkpKA.gif)

미디어 쿼리는 디바이스 방향, 시스템 색상 테마 설정, JavaScript 활성화/비활성화 여부, 화면 DPI (Dots Per Inch) 값 등을 확인하는 다양한 미디어 기능을 제공합니다. 공식 MDN 문서에서 지원하는 모든 미디어 기능을 확인할 수 있습니다.

# CSS로 네이티브 폼 컨트롤 사용자 정의하기

<div class="content-ad"></div>

기본 HTML 폼 컨트롤, 예를 들어 버튼, 텍스트 입력란, 라디오 버튼 및 체크박스는 초기 HTML 사양에서 사용할 수 있었습니다. 이후 HTML 사양은 더 현대적인 웹 앱을 구축하기 위해 range-sliders, date-pickers, color-pickers 등을 소개했습니다. 그러나 대부분의 개발자들은 기본 폼 컨트롤의 사용성에 대한 문제로 이러한 기본 폼 컨트롤을 선호하지 않았으며 CSS 기반의 사용자 정의 폼 컨트롤을 사용했습니다. 그러나 최근 CSS는 기본 폼 컨트롤을 사용자 정의하기 위한 새로운 속성을 도입하기 시작했습니다.

accent-color 속성을 사용하면 기본 폼 컨트롤의 기본 색상 스키마를 변경할 수 있습니다:

```js
<input type="checkbox" style="accent-color: cadetblue"/>
<input type="radio" style="accent-color: teal"/>
<input type="range" style="accent-color: hotpink"/><br/>
<progress style="accent-color: darkcyan"></progress>
```

위 코드 스니펫은 다양한 색상 스키마로 기본 폼 컨트롤을 렌더링하며, 다음 미리보기에 나와 있습니다:

<div class="content-ad"></div>


![image](https://miro.medium.com/v2/resize:fit:1400/1*TZdvLwHpwHwiK901ozI3jQ.gif)

`accent-color` 속성은 입력 색상을 기반으로 기본 폼 컨트롤의 모든 하위 요소를 업데이트하여 접근 가능한 색상 체계를 생성합니다. 해당 예시에서 보여지는 폼 요소들만을 기준으로 현재 이 기능이 작동합니다.

CSS는 `accent-color` 속성과 함께 사용할 `color-scheme` 속성을 제공하여 밝은 테마와 어두운 테마에서 모두 원래의 폼 컨트롤 가시성을 향상시킬 수 있습니다:

```css
@media (prefers-color-scheme: dark) {
  body {
    background-color: black;
    color: white;
  }

  input[type="checkbox"], 
  input[type="radio"], 
  input[type="range"], 
  progress {
    accent-color: white;
    color-scheme: dark;
  }
}
```


<div class="content-ad"></div>

위의 미디어 쿼리는 원시 폼 컨트롤 색 구성을 다음과 같이 변경합니다:

![이미지](https://miro.medium.com/v2/resize:fit:1400/1*cIfznllnpX0t-msAM25vjQ.gif)

앞으로 CSS는 기본 폼 컨트롤 스타일을 조정할 수 있는 새로운 속성을 제공하고 다른 기본 요소에 대한 강조 색 지원을 확대할 예정이지만, 기존의 CSS 기능을 사용하여 텍스트 입력과 버튼을 사용자 정의하는 데 문제가 없습니다.

# CSS 카운터 및 @counter-style 사용하기

<div class="content-ad"></div>

CSS 카운터 기능은 CSS 선택자 내에서 증가/감소시킬 수 있는 카운터를 생성하는 방법을 제공합니다. 이 기능을 다양한 용도에 활용할 수 있습니다. 간단한 용례는 요소 발생 횟수에 따라 카운터 값을 표시하는 것입니다.

다음 HTML 코드 조각을 살펴보세요:

```js
<style>
  :root { counter-reset: references }
  a[href]:empty { text-decoration: none }

  a[href]:empty::after {
    counter-increment: references;
    content: '[' counter(references) ']';
  }
</style>

<p>
  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque in 
  eleifend dolor <a href="https://example.com/link1"></a>. Integer mauris 
  eros, posuere vitae ex feugiat, pretium ultrices 
  ex <a href="https://example.com/link2"></a>. Nulla et nibh feugiat, 
  pharetra ipsum vel, accumsan augue 
  <a href="https://example.com/link3"></a>.
</p>
```

위 CSS 정의는 references라는 카운터를 생성하고, CSS 카운터를 사용하여 빈 하이퍼링크 태그에 IEEE 인용 형식을 표시합니다. 여기서, 우리는 :root 선택자 내에서 카운터를 0으로 초기화하고, 모든 빈 하이퍼링크의 ::after 가상 클래스로 카운터를 증가시켰습니다. 마지막으로, 카운터 값을 content 속성을 통해 렌더링하고 counter() 함수를 사용하여 카운터 값을 가져와 표시합니다. 위 HTML 문서는 다음과 같은 결과를 렌더링합니다:

<div class="content-ad"></div>


<img src="/assets/img/2024-06-19-Lesser-KnownCSSFeaturesThatYouShouldLearnNow_1.png" />

HTML에는 내장된 정렬된 및 정렬되지 않은 목록 스타일이 있지만 특정 시나리오에서는 처음부터 사용자 정의 스타일을 구현하거나 기존 스타일을 확장해야 할 수 있습니다. @counter-style at-rule을 사용하면 새로운 또는 확장된 목록 스타일을 만들 수 있습니다. 내장된 10진수 목록 스타일 유형을 주변 괄호 추가 및 단일 제로 패딩 사용하여 사용자 정의해야 한다고 가정해 보십시오. CSS 카운터로 이 요구 사항을 구현할 수 있지만 @counter-style을 사용하면 이 기능에 대해 작성해야 하는 CSS 코드를 줄일 수 있습니다.

```js
<style>
  @counter-style modified-alpha {
    system: extends alpha;
    prefix: "[ ";
    suffix: " ] ";
    pad: 2 "0";
  }
  
  ol { list-style-type: modified-alpha }
</style>

<ol>
  <li>HTML</li>
  <li>CSS</li>
  <li>JavaScript</li>
  <li>TypeScript</li>
  <li>Bootstrap</li>
</ol>
```

위의 HTML 코드는 사용자 정의 목록 스타일이 적용된 정렬된 목록을 렌더링하며, 다음 미리보기와 같이 표시됩니다:


<div class="content-ad"></div>

<img src="/assets/img/2024-06-19-Lesser-KnownCSSFeaturesThatYouShouldLearnNow_2.png" />

@counter-style을 사용하여 이모지와 함께 스타일리쉬한 불릿 포인트를 만들 수도 있어요. 이런 기능은 이 MDN 문서 페이지에서 확인할 수 있어요.

다음 이야기에서는 모든 최신 웹 개발자가 알아야 할 몇 가지 CSS 규칙을 나열했어요:

## CSS Animation 특정 Keyframes를 생성하지 않아도 가능합니다

<div class="content-ad"></div>

과거에는 웹 개발자가 DOM 요소에 애니메이션을 구현하기 위해 JavaScript 알고리즘을 작성해야 했습니다. 이제는 내장 된 요소 변환 알고리즘과 표준 속성을 사용하여 CSS 만을 사용하여 DOM 요소를 애니메이션화 할 수 있습니다. 잘 알려진 CSS 애니메이션 접근 방식은 @keyframes at-rule을 사용한 일련의 키프레임을 활용합니다.

저는 최근 이 흥미로운 기사를 발견했고, 키프레임 내에서 CSS 변수를 업데이트할 수 있다는 사실을 알게 되었습니다. 이 기술을 사용하면 다양한 요소를 다중 키프레임 블록을 작성하지 않고 동적으로 업데이트 된 CSS 변수를 사용하여 애니메이션화 할 수 있습니다.

다음 CSS 코드 스니펫을 살펴보세요:

```js
@property --t {
  syntax: "<number>";
  initial-value: 0;
  inherits: true;
}

@keyframes tick {
  from { --t: 0 }
  to   { --t: 100000 }
}

:root { animation: tick 86400s linear infinite }
```

<div class="content-ad"></div>

위의 CSS 코드 스니펫은 사용자 지정 속성(변수)을 정의하고 전역 keyframe 두 개만을 사용하여 해당 속성을 업데이트합니다. 그 다음, 우리는 :root 선택자를 사용하여 --t 변수를 루프로 업데이트하면서 애니메이션을 시작했습니다.

--t 변수를 애니메이션 클록으로 사용하여 CSS 함수를 사용해 애니메이션을 만들 수 있습니다. 여기서는 DOM 요소를 애니메이션화하지 않고 CSS 함수를 사용하여 전역 애니메이션 클록을 시작했는데, 이렇게 하면 어떤 CSS 속성에도 사용할 수 있습니다!

아래 코드 스니펫은 애니메이션 keyframes를 사용하지 않고 위의 애니메이션 클록을 활용하여 두 개의 DOM 요소를 애니메이션화하는 예제입니다:

```js
<style>
  /* 이전 CSS 스니펫을 여기에 붙여넣기... */

  div > div {
    background: #555;
    width: 2em;
    height: 2em;
    margin-top: 2em;
    border-radius: 50%;
  }
  
  div > div:first-child { translate: calc(sin(var(--t)) * 200px + 200px) }
  div > div:last-child { translate: calc(cos(var(--t)) * 200px + 200px) }

</style>

<div>
  <div></div>
  <div></div>
</div>
```

<div class="content-ad"></div>

여기서는 이징 알고리즘을 사용하지 않고도 최신 CSS 삼각함수 덕분에 다음과 같이 부드러운 애니메이션을 만들 수 있어요:

![이미지](https://miro.medium.com/v2/resize:fit:1400/1*p4TDYHRD8_pe72zFZAqWCA.gif)

이 기술을 사용하면 여러 키프레임을 작성하는 데 소비하는 시간을 줄여 CSS 함수로 애니메이션을 만들 수 있어요! 삼각함수는 아직 새로운 기술이라 2023년 기준으로, 웹 앱 사용자가 오래된 웹 브라우저를 사용하는 경우에는 프로덕션에서 사용하기 전에 기다려야 할 수도 있어요.

다음 이야기에서는 모든 현대 웹 디자이너가 알아야 할 CSS 함수를 탐구해볼 거에요:

<div class="content-ad"></div>

읽어 주셔서 감사합니다.