---
layout: post
title: "JavaScript에서 페이지의 모든 사용자 지정 속성을 가져오는 방법"
author: "Uidev Css"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/05/how-to-get-all-custom-props-featured.png"
tags: 
---


우리는 자바스크립트를 사용하여 CSS 사용자 지정 속성의 값을 얻을 수 있습니다. 로빈은 이에 대한 자세한 설명을 자바스크립트로 CSS Custom Property Value에 적었다. HTML 요소에 대해 단일 사용자 지정 속성을 선언했다고 가정해 보겠습니다.

```css
html {
  --color-accent: #00eb9b;
}
```

JavaScript에서는 `getComputedStyle` 및 `getPropertyValue`로 값에 액세스할 수 있습니다.

```js
const colorAccent = getComputedStyle(document.documentElement)
  .getPropertyValue('--color-accent'); // #00eb9b
```

완벽해. 이제 우리는 자바스크립트에서 우리의 억양 색깔에 접근할 수 있다. 뭐가 멋진지 알아? CSS에서 그 색을 변경하면 자바스크립트에서도 업데이트가 됩니다! 편리하다.

하지만, 자바스크립트에서 액세스해야 하는 하나의 속성이 아니라 여러 개의 속성이 있는 경우에는 어떻게 될까요?

```css
html {
  --color-accent: #00eb9b;
  --color-accent-secondary: #9db4ff;
  --color-accent-tertiary: #f2c0ea;
  --color-text: #292929;
  --color-divider: #d7d7d7;
}
```

이렇게 보이는 JavaScript가 제공됩니다.

```js
const colorAccent = getComputedStyle(document.documentElement).getPropertyValue('--color-accent'); // #00eb9b
const colorAccentSecondary = getComputedStyle(document.documentElement).getPropertyValue('--color-accent-secondary'); // #9db4ff
const colorAccentTertiary = getComputedStyle(document.documentElement).getPropertyValue('--color-accent-tertiary'); // #f2c0ea
const colorText = getComputedStyle(document.documentElement).getPropertyValue('--color-text'); // #292929
const colorDivider = getComputedStyle(document.documentElement).getPropertyValue('--color-text'); // #d7d7d7
```

우리는 많이 반복하고 있어요. 우리는 공통 작업을 함수로 추상화함으로써 이러한 각 줄을 단축할 수 있었다.

```js
const getCSSProp = (element, propName) => getComputedStyle(element).getPropertyValue(propName);
const colorAccent = getCSSProp(document.documentElement, '--color-accent'); // #00eb9b
// repeat for each custom property...
```

이는 코드 반복을 줄이는 데 도움이 되지만, 여전히 이상적인 상황은 아닙니다. CSS에 사용자 지정 속성을 추가할 때마다 액세스하기 위해 JavaScript 라인을 하나 더 작성해야 합니다. 몇 가지 사용자 지정 속성만 있으면 이 기능이 제대로 작동합니다. 이 설정을 프로덕션 프로젝트에서 사용한 적이 있습니다. 그러나 이를 자동화할 수도 있습니다.

작업물을 만들어 자동화 과정을 살펴보겠습니다.

### 뭘 만드는 거죠?

우리는 패턴 라이브러리에서 공통적인 특징인 색상 팔레트를 만들 것입니다. CSS 사용자 지정 속성에서 컬러 스와치의 그리드를 생성합니다.

다음은 단계별로 작성하는 전체 데모입니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/05/Lr2GwoOg.png?fit=1024%2C520&ssl=1)

무대 세팅 합시다. 정렬되지 않은 목록을 사용하여 팔레트를 표시합니다. 각 스왓치는 JavaScript로 렌더링할 ` `` 요소입니다.

```html
<ul class="colors"></ul>
```

그리드 레이아웃에 대한 CSS는 이 게시물의 기법과 관련이 없기 때문에 자세히 살펴보지는 않을 것입니다. 코드펜 데모에서 사용할 수 있습니다.

이제 HTML과 CSS가 준비되었으므로 JavaScript에 초점을 맞추겠습니다. 코드로 수행할 작업에 대한 개요는 다음과 같습니다.

- 외부 및 내부 페이지의 모든 스타일시트 가져오기
- 타사 도메인에서 호스트되는 스타일시트 삭제
- 나머지 스타일시트에 대한 모든 규칙 가져오기
- 기본 스타일 규칙이 아닌 모든 규칙 삭제
- 모든 CSS 속성의 이름 및 값 가져오기
- 사용자 정의되지 않은 CSS 속성 삭제
- 색 스왓치를 표시하는 HTML 작성

시작합시다.

### 1단계: 페이지의 모든 스타일시트 가져오기

먼저 현재 페이지의 모든 외부 및 내부 스타일시트를 가져와야 합니다. 스타일시트는 전역 문서의 구성원으로 사용할 수 있습니다.

```js
document.styleSheets
```

그러면 배열 유사 개체가 반환됩니다. 어레이 방법을 사용하고자 하므로 어레이로 변환하겠습니다. 이 게시물 전체에서 사용할 기능에도 넣읍시다.

```js
const getCSSCustomPropIndex = () => [...document.styleSheets];
```

getCSCustomProp을 호출할 때인덱스, 현재 페이지의 각 외부 및 내부 스타일시트에 하나씩 "CSS 스타일시트" 객체가 배열되어 있습니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/05/jfCaNYSe.png?fit=1024%2C111&ssl=1)

### 2단계: 타사 스타일시트 폐기

스크립트가 https://example.com에서 실행 중인 경우 검사하려는 스타일시트가 https://example.com에도 있어야 합니다. 이것은 보안 기능입니다. CSS 스타일시트 MDN 문서:

> 일부 브라우저에서는 스타일시트가 다른 도메인에서 로드된 경우 'cssRules'에 액세스하면 'SecurityError'가 발생합니다.

즉, 현재 페이지가 https://some-cdn.com에서 호스트되는 스타일시트로 링크되는 경우 사용자 지정 속성이나 다른 스타일을 가져올 수 없습니다. 현재 도메인에서 호스트되는 스타일시트에 대해서만 사용할 수 있습니다.

CSS 스타일시트 개체에는 href 속성이 있습니다. 이 값은 https://example.com/styles.css과 같은 스타일시트의 전체 URL입니다. 내부 스타일시트는 `href` 속성을 가지지만 값은 `null`이 됩니다.

타사 스타일시트를 폐기하는 함수를 작성하겠습니다. 스타일시트의 href 값을 현재 location.origin과 비교해 보겠습니다.

```js
const isSameDomain = (styleSheet) => {
  if (!styleSheet.href) {
    return true;
  }
 
  return styleSheet.href.indexOf(window.location.origin) === 0;
};
```

이제 isSameDomain을 document.styleSheets의 필터로 사용합니다.

```js
const getCSSCustomPropIndex = () => [...document.styleSheets]
  .filter(isSameDomain);
```

타사 스타일시트가 폐기되면 나머지 내용물을 검사할 수 있습니다.

### 3단계: 나머지 스타일시트에 대한 모든 규칙 가져오기

GetCS CustomProp을 위한 우리의 목표인덱스는 배열을 생성하는 것입니다. 이를 위해 여러 어레이 방법을 조합하여 순환하고 원하는 값을 찾아 결합합니다. 모든 스타일 규칙이 포함된 배열을 생성하여 해당 방향으로 첫 번째 단계를 진행하겠습니다.

```js
const getCSSCustomPropIndex = () => [...document.styleSheets]
  .filter(isSameDomain)
  .reduce((finalArr, sheet) => finalArr.concat(...sheet.cssRules), []);
```

우리는 모든 1단계 요소가 관심 있는 플랫 어레이를 생산하고 싶기 때문에 "reduce"와 "concat"을 사용합니다. 이 코드 조각에서 우리는 개별 `CSS 스타일 시트` 개체에 대해 반복한다. 이들 각각에 대해 우리는 css 룰이 필요하다. MDN 문서:

> 읽기 전용 CSSStyleSheet 속성 cssRules는 스타일시트로 구성된 모든 CSS 규칙의 실시간 최신 목록을 제공하는 라이브 CSSRuleList를 반환합니다. 목록의 각 항목은 단일 규칙을 정의하는 'CSS 규칙'입니다.

각 CSS 규칙은 선택기, 가새 및 속성 선언입니다. 확산 연산자 `...sheet.csrules는 cssRules 객체의 모든 규칙을 제거하고 final Arr에 배치한다. getCSCustomProp의 출력을 기록할 때인덱스에는 CSRule 객체의 단일 수준 배열이 있습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/05/dHY0PlES.png?fit=1024%2C310&ssl=1)

이것은 우리에게 모든 스타일시트에 대한 모든 CSS 규칙을 제공한다. 우리는 그것들 중 일부를 버리고 싶으니 다음으로 넘어가자.

### 4단계: 기본 스타일 규칙이 아닌 모든 규칙 폐기

CSS 규칙은 유형이 다릅니다. CSS 사양은 이름과 정수로 각 유형을 정의합니다. 가장 일반적인 규칙 유형은 `CSS 스타일 규칙`입니다. 또 다른 형태의 규칙은 `CSS미디어 규칙`이다. 이러한 쿼리를 사용하여 `@media(최소 폭: 400px) {}과 같은 미디어 쿼리를 정의합니다. 이 밖에 CSS 지원 규칙, CSSFontFaceRule, CSSKeyframe 등이 있다.규칙. 전체 목록은 MDN 문서의 유형 상수 섹션을 참조하십시오.

사용자 지정 속성을 정의하는 규칙에만 관심이 있으며 이 게시물의 목적상 `CSS 스타일 규칙`에 초점을 맞추겠습니다. 이렇게 하면 사용자 지정 속성을 정의할 수 있는 `CSSMediaRule` 규칙 유형은 제외됩니다. 이 데모에서 사용자 지정 속성을 추출하기 위해 사용하는 것과 유사한 접근 방식을 사용할 수 있지만 데모 범위를 제한하기 위해 이 특정 규칙 유형을 제외합니다.

스타일 규칙으로 초점을 좁히기 위해 다른 어레이 필터를 작성합니다.

```js
const isStyleRule = (rule) => rule.type === 1;
```

모든 `CSSRule`에는 해당 유형 상수에 대한 정수를 반환하는 `type` 속성이 있습니다. isStyleRule을 사용하여 sheet.cssRules를 필터링합니다.

```js
const getCSSCustomPropIndex = () => [...document.styleSheets]
  .filter(isSameDomain)
  .reduce((finalArr, sheet) => finalArr.concat(
    [...sheet.cssRules].filter(isStyleRule)
  ), []); 

```

한가지 주목할 점은 우리가 `...`를 포장하고 있다는 것이다.sheet.cssRules`는 배열 메서드 필터를 사용할 수 있도록 괄호로 묶은 것입니다.

저희 스타일시트는 `CSS스타일 규칙`만 있어서 데모 결과는 예전과 같습니다. 만약 우리 스타일시트에 미디어 쿼리나 폰트페이스 선언이 있다면 isStyleRule은 그것들을 폐기할 것이다.

### 5단계: 모든 속성의 이름과 값 가져오기

이제 원하는 규칙이 생겼으므로 이를 구성하는 속성을 얻을 수 있습니다. CSSStyleRule 객체는 CSS 스타일 선언 객체인 스타일 속성을 가집니다. 컬러, 폰트패밀리, 보더레이디어스 등 표준 CSS 속성과 맞춤형 속성으로 구성됐다. getCSCustomProp에 추가해 보겠습니다.인덱스는 모든 규칙을 볼 수 있도록 다음과 같은 방식으로 배열 배열을 구성합니다.

```js
const getCSSCustomPropIndex = () => [...document.styleSheets]
  .filter(isSameDomain)
  .reduce((finalArr, sheet) => finalArr.concat(
    [...sheet.cssRules]
      .filter(isStyleRule)
      .reduce((propValArr, rule) => {
        const props = []; /* TODO: more work needed here */
        return [...propValArr, ...props];
      }, [])
  ), []); 
 
 
 

```

지금 호출하면 빈 배열이 나타납니다. 우리는 할 일이 더 많지만, 이것이 토대가 된다. 우리는 배열로 끝나기를 원하기 때문에 `축소`의 두 번째 매개 변수인 축전지(accumulator)를 사용하여 빈 배열로 시작한다. `축소` 콜백 기능의 본문에는 자리 표시자 변수인 `props`가 있는데, 여기서 우리는 속성을 수집할 것이다. `return` 문은 이전 반복의 배열인 축전지 배열과 현재의 `props` 배열을 결합한다.

지금은 둘 다 빈 배열입니다. 현재 규칙의 모든 속성/값에 대한 배열로 소품을 채우려면 `rule.style`을 사용해야 합니다.

```js
const getCSSCustomPropIndex = () => [...document.styleSheets]
  .filter(isSameDomain)
  .reduce((finalArr, sheet) => finalArr.concat(
    [...sheet.cssRules]
      .filter(isStyleRule)
      .reduce((propValArr, rule) => {
        const props = [...rule.style].map((propName) => [
          propName.trim(),
          rule.style.getPropertyValue(propName).trim()
        ]);
        return [...propValArr, ...props];
      }, [])
  ), []); 
 
 
 

```

rule.style은 어레이와 유사하므로, 우리는 스프레드 연산자를 사용하여 각 멤버를 맵으로 루프하는 어레이에 넣습니다. 맵 콜백에서는 멤버가 두 개인 배열을 반환합니다. 첫 번째 멤버는 propName(컬러, 폰트 패밀리, 컬러 액센트 등)이다. 두 번째 구성원은 각 속성의 값입니다. 이를 위해 CSS 스타일 선언의 getProperty Value 방법을 사용한다. CSS 속성의 문자열 이름인 단일 매개변수를 사용합니다.

이름과 값 모두에 trim을 사용하여 때때로 뒤쳐지는 선행 또는 후행 공백을 포함하지 않도록 합니다.

getCSCustomProp을 호출할 때인덱스, 배열을 볼 수 있습니다. 모든 하위 배열에는 CSS 속성 이름과 값이 포함됩니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/05/oz9FWtIw.png?fit=1024%2C451&ssl=1)

이게 우리가 찾는 거야! 거의 다 됐어요. 사용자 지정 자산 외에도 모든 자산을 확보할 수 있습니다. 원하는 것은 사용자 지정 속성이기 때문에 표준 속성을 제거하기 위한 필터가 하나 더 필요합니다.

### 6단계: 사용자 정의되지 않은 속성 폐기

속성이 사용자 정의인지 확인하기 위해 이름을 살펴볼 수 있습니다. 사용자 지정 속성은 두 개의 대시(-)로 시작해야 합니다. CSS에서는 이러한 기능이 고유하므로 이를 사용하여 다음과 같은 필터 기능을 작성할 수 있습니다.

```js
([propName]) => propName.indexOf("--") === 0)
```

그런 다음 이를 `props` 어레이의 필터로 사용합니다.

```js
const getCSSCustomPropIndex = () =>
  [...document.styleSheets].filter(isSameDomain).reduce(
    (finalArr, sheet) =>
      finalArr.concat(
        [...sheet.cssRules].filter(isStyleRule).reduce((propValArr, rule) => {
          const props = [...rule.style]
            .map((propName) => [
              propName.trim(),
              rule.style.getPropertyValue(propName).trim()
            ])
            .filter(([propName]) => propName.indexOf("--") === 0);
 
          return [...propValArr, ...props];
        }, [])
      ),
    []
  ); 

```

함수 서명에는 `([propName])가 있습니다. 여기서는 소품에서 모든 하위 어레이의 첫 번째 멤버에 액세스하기 위해 어레이 파괴를 사용합니다. 거기서 우리는 부동산의 이름에 대해 인덱스 Of 검사를 한다. -가 prop 이름의 앞에 없으면 props 배열에 포함되지 않습니다.

결과를 기록할 때 원하는 정확한 출력을 얻을 수 있습니다. 모든 사용자 지정 속성에 대한 배열과 다른 속성 없이 해당 값이 표시됩니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/05/ELSQMPP8.png?fit=1024%2C190&ssl=1)

미래를 내다볼 때 속성/값 맵을 만드는 데는 많은 코드가 필요하지 않습니다. CSS Type Object Model Level 1 초안에는 `CSSStyleRule.styleMap`을 사용하는 대체 항목이 있습니다. styleMap 속성은 CSS 규칙의 모든 속성/값의 배열 유사 개체입니다. 아직 가지고 있지 않지만, 만약 가지고 있다면, 우리는 `지도`를 제거함으로써 위의 코드를 줄일 수 있을 것이다.

```js
// ...
const props = [...rule.styleMap.entries()].filter(/*same filter*/);
// ...
```

이 글을 쓸 당시 크롬과 엣지는 스타일맵을 구현했지만 다른 주요 브라우저는 구현하지 못했다. 스타일맵은 초안에 들어 있기 때문에 우리가 실제로 받을 것이라는 보장이 없고, 이 데모에 사용하는 것도 의미가 없다. 하지만, 이것이 미래의 가능성이라는 것을 아는 것은 재미있어요!

우리는 우리가 원하는 데이터 구조를 가지고 있습니다. 이제 데이터를 사용하여 컬러 스와치를 표시해 보겠습니다.

### 7단계: 컬러 스와치를 표시하는 HTML 구축

데이터를 우리가 필요로 하는 정확한 모양으로 만드는 것은 힘든 일이었다. 우리는 우리의 아름다운 컬러 스와치를 렌더링하기 위해 자바스크립트 한 비트가 더 필요합니다. getCSCustomProp의 출력을 로깅하는 대신인덱스, 변수에 저장해 두겠습니다.

```js
const cssCustomPropIndex = getCSSCustomPropIndex();
```

다음은 이 게시물의 시작 부분에 색 스왓치를 만드는 데 사용한 HTML입니다.

```html
<ul class="colors"></ul>
```

이너로 하겠습니다.각 색에 대한 목록 항목으로 해당 목록을 채우는 HTML:

```js
document.querySelector(".colors").innerHTML = cssCustomPropIndex.reduce(
  (str, [prop, val]) => `${str}<li class="color">
    <b class="color__swatch" style="--color: ${val}"></b>
    <div class="color__details">
      <input value="${prop}" readonly />
      <input value="${val}" readonly />
    </div>
   </li>`,
  "");
```

사용자 지정 소품 인덱스에 대해 반복하고 `내부`를 위한 단일 HTML 모양 문자열을 구축하기 위해 축소를 사용합니다.그러나 reduce만이 이 일을 할 수 있는 유일한 방법은 아니다. 우리는 각각에 대해 지도와 가입 또는 가입이 필요할 수 있다. 여기서 문자열을 만드는 모든 방법을 사용할 수 있습니다. 이것은 내가 가장 선호하는 방법일 뿐이다.

나는 몇 가지 특정한 코드 비트를 강조하고 싶다. reduce 콜백 서명에서, 우리는 각 하위 어레이의 두 멤버 모두에 액세스하기 위해 이번에도 "[prop, val]"로 어레이 구조를 다시 사용하고 있습니다. 그런 다음 함수 본문에 prop 변수와 val 변수를 사용합니다.

각 색상의 예를 보여주기 위해, 우리는 인라인 스타일을 가진 `b` 요소를 사용한다.

```html
<b class="color__swatch" style="--color: ${val}"></b>
```

따라서 다음과 같은 HTML이 제공됩니다.

```html
<b class="color__swatch" style="--color: #00eb9b"></b>
```

하지만 어떻게 배경색을 설정할 수 있을까요? 전체 CSS에서 사용자 지정 속성 --color를 각 .color_swatch에 대해 "background-color" 값으로 사용합니다. 외부 CSS 규칙은 인라인 스타일에서 상속되므로 --color는 b 요소에 설정한 값입니다.

```css
.color__swatch {
  background-color: var(--color);
  /* other properties */
}
```

현재 CSS 사용자 지정 속성을 나타내는 색 스와치의 HTML 디스플레이가 있습니다!

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_jObmNNM" src="//codepen.io/anon/embed/jObmNNM?height=450&amp;theme-id=1&amp;slug-hash=jObmNNM&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed jObmNNM" title="CodePen Embed jObmNNM" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이 데모는 색상에 초점을 맞추고 있지만, 이 기술은 사용자 지정 색 소품에만 국한되지 않습니다. 글꼴, 간격, 그리드 설정 등과 같은 패턴 라이브러리의 다른 섹션을 생성하기 위해 이 접근 방식을 확장하지 못할 이유는 없습니다. 사용자 지정 속성으로 저장할 수 있는 모든 항목은 이 기술을 사용하여 페이지에 자동으로 표시될 수 있습니다.