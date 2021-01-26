---
layout: post
title: "CSS Paint API로 그림자 효과 시뮬레이션
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2018/09/houdini.png
tags: CSS PAINT API,HOUDINI,SHADOW
---


100 명의 프론트 엔드 개발자에게 물어보십시오. 전부는 아니더라도 대부분은 경력에서 `box-shadow`속성을 사용했을 것입니다.
 그림자는 지속적으로 인기가 있으며 적절하게 사용하면 우아하고 미묘한 효과를 추가 할 수 있습니다.
 그러나 그림자는 CSS 상자 모델에서 이상한 위치를 차지합니다.
 요소의 너비와 높이에는 영향을주지 않으며 상위 (또는 조부모) 요소의 오버플로가 숨겨지면 쉽게 잘립니다.
 

몇 가지 다른 방법으로 표준 CSS로이 문제를 해결할 수 있습니다.
 그러나 이제 CSS Houdini 사양 중 일부가 브라우저에서 구현되고 있으므로 감질 나게하는 새로운 옵션이 있습니다.
 예를 들어 CSS Paint API를 사용하면 개발자가 런타임에 프로그래밍 방식으로 이미지를 생성 할 수 있습니다.
 이를 사용하여 테두리 이미지 내에 복잡한 그림자를 칠하는 방법을 살펴 보겠습니다.
 

### Houdini에 대한 간단한 입문서
 

Houdini라는 눈에 띄는 이름으로 플랫폼을 강타하는 새로운 CSS 기술에 대해 들어 보셨을 것입니다.
 Houdini는 브라우저가 페이지를 그리는 방법에 더 많은 액세스를 제공 할 것을 약속합니다.
 MDN은 "CSS 엔진의 일부를 노출하는 저수준 API 집합으로, 개발자가 브라우저 렌더링 엔진의 스타일 및 레이아웃 프로세스에 연결하여 CSS를 확장 할 수있는 능력을 제공합니다."
 

CSS Paint API는 이러한 API 중 브라우저에 가장 먼저 적용되는 API 중 하나입니다.
 W3C 후보 추천입니다.
 스펙이 구현되기 시작하는 단계입니다.
 현재 Chrome 및 Edge에서 일반적인 용도로 사용할 수 있으며 Safari에는 플래그가 있고 Firefox는 "프로토 타이핑 할 가치가있는"것으로 표시합니다.
 지원되지 않는 브라우저에서 사용할 수있는 polyfill이 있지만 IE11에서는 실행되지 않습니다.
 

Chromium에서 CSS Paint API가 활성화되어 있지만`paint ()`함수에 인수를 전달하는 것은 여전히 플래그 뒤에 있습니다.
 당분간 실험적인 웹 플랫폼 기능을 사용 설정해야합니다.
 안타깝게도 이러한 예제는 현재 선택한 브라우저에서 작동하지 않을 수 있습니다.
 아직 생산 준비가되지 않은 상황의 예를 고려하십시오.
 

### 접근
 verified_user

그림자가있는 이미지를 생성 한 다음 `테두리 이미지`에 사용할 것입니다 ... 응?
 음, 더 자세히 살펴 보겠습니다.
 

위에서 언급했듯이 그림자는 요소에 너비 나 높이를 추가하지 않고 경계 상자에서 펼쳐집니다.
 대부분의 경우 이것은 문제가되지 않지만 이러한 그림자는 클리핑에 취약합니다.
 일반적인 해결 방법은 패딩이나 여백을 사용하여 일종의 오프셋을 만드는 것입니다.
 

우리가하려고하는 것은 `border-image`영역에 페인팅하여 요소에 바로 그림자를 만드는 것입니다.
 여기에는 몇 가지 주요 이점이 있습니다.
 

- `border-width`는 전체 요소 너비에 추가됩니다.
 
- 내용이 테두리 영역으로 넘치지 않고 그림자와 겹치지 않습니다.
 
- 패딩은 그림자와 내용을 수용하기 위해 추가 너비가 필요하지 않습니다.
 
- 요소 주변의 여백은 해당 요소의 형제를 방해하지 않습니다.
 

앞서 언급 한 `box-shadow`를 사용한 100 명의 개발자 그룹의 경우, 그들 중 소수만이 `border-image`를 사용했을 가능성이 높습니다.
 펑키 한 속성입니다.
 기본적으로 이미지를 가져와 9 개로 분할 한 다음 네 모서리, 측면 및 (선택적으로) 중앙에 배치합니다.
 이 모든 작동 방식에 대한 자세한 내용은 Nora Brown의 기사를 참조하십시오.
 

CSS Paint API는 이미지 생성의 무거운 작업을 처리합니다.
 일련의 그림자를 서로 겹쳐 놓는 방법을 알려주는 모듈을 만들 것입니다.
 그러면 해당 이미지가`border-image`에서 사용됩니다.
 

우리가 취할 단계는 다음과 같습니다.
 

- 페인트하려는 요소에 대한 HTML 및 CSS 설정
 
- 이미지를 그리는 모듈 만들기
 
- 페인트 워크 릿에 모듈로드
 
- 새로운`paint ()`함수를 사용하여 CSS에서 worklet을 호출합니다.
 

### 캔버스 설정
 

여기와 다른 CSS Paint API 리소스에서 캔버스라는 용어를 몇 번 듣게 될 것입니다.
 그 용어가 익숙하게 들리면 맞습니다.
 API는 HTML`<canvas>`요소와 유사한 방식으로 작동합니다.
 

먼저 API가 그릴 캔버스를 설정해야합니다.
 이 영역은 paint 함수를 호출하는 요소와 동일한 치수를 갖습니다.
 300 × 300 div를 만들어 보겠습니다.
 

```html
<section>
  <div class="foo"></div>
</section>
```

그리고 스타일 :
 

```css
.foo {
  border: 15px solid #efefef;
  box-sizing: border-box;
  height: 300px;
  width: 300px;
}
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_JjKqOWG" src="//codepen.io/anon/embed/JjKqOWG?height=450&amp;theme-id=1&amp;slug-hash=JjKqOWG&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed JjKqOWG" title="CodePen Embed JjKqOWG" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 페인트 클래스 만들기
 

페인트 워크 릿을 포함한 모든 JavaScript 워크 릿에는 HTTPS가 필요합니다.
 HTTP를 통해 콘텐츠를 제공하는 경우에는 전혀 사용할 수 없습니다.
 

두 번째 단계는 `registerPaint ()`함수가있는 간단한 파일 인 worklet에로드되는 모듈을 만드는 것입니다.
 이 함수는 worklet의 이름과 그리기 논리가있는 클래스의 두 가지 인수를 사용합니다.
 깔끔하게 정리하기 위해 익명의 수업을 사용합니다.
 

```js
registerPaint(
  "shadow",
  class {}
);
```

우리의 경우 클래스에는`inputProperties`와`inputArguments`의 두 가지 속성과`paint ()`메서드가 필요합니다.
 

```js
registerPaint(
  "shadow",
  class {
    static get inputProperties() {
      return [];
    }
    static get inputArguments() {
      return [];
    }
    paint(context, size, props, args) {}
  }
);
```

`inputProperties` 및`inputArguments`는 선택 사항이지만 데이터를 클래스로 전달하는 데 필요합니다.
 

`inputProperties`를 사용하여 대상 요소에서 가져올 CSS 속성을 worklet에 알려야합니다.
 문자열 배열을 반환하는 게터입니다.
 

이 배열에는 클래스에 필요한 사용자 정의 및 표준 속성 인`--shadow-colors`,`background-color` 및`border-top-width`가 나열됩니다.
 비 속기 속성을 사용하는 방법에 특히주의하십시오.
 

```js
static get inputProperties() {
  return ["--shadow-colors", "background-color", "border-top-width"];
}
```

간단하게하기 위해 여기서는 테두리가 모든면에 균등하다고 가정합니다.
 

현재`inputArguments`는 여전히 플래그 뒤에 있으므로 실험 기능을 사용할 수 있습니다.
 그것들이 없으면 대신`inputProperties` 및 사용자 정의 속성을 사용하십시오.
 

또한`inputArguments`를 사용하여 페인트 모듈에 인수를 전달합니다.
 언뜻보기에는`inputProperties`에 불필요한 것처럼 보일 수 있지만 두 가지를 사용하는 방법에는 미묘한 차이가 있습니다.
 

스타일 시트에서 paint 함수가 호출되면`paint ()`호출에서`inputArguments`가 명시 적으로 전달됩니다.
 이는 다른 스크립트 나 스타일에 의해 수정 될 수있는 속성을 수신 할 수있는`inputProperties`보다 이점을 제공합니다.
 예를 들어 변경되는`: root`에 설정된 맞춤 속성을 사용하는 경우 필터링하여 출력에 영향을 미칠 수 있습니다.
 

직관적이지 않은`inputArguments`의 두 번째 중요한 차이점은 이름이 지정되지 않았다는 것입니다.
 대신 paint 메서드 내에서 배열의 항목으로 참조됩니다.
 `inputArguments`가 수신하는 것을 말할 때 실제로 인수 유형을 제공합니다.
 

`shadow` 클래스에는 X 위치, Y 위치, 블러에 대한 세 가지 인수가 필요합니다.
 공백으로 구분 된 세 개의 정수 목록으로 설정합니다.
 

사용자 지정 속성을 등록한 사람은 누구나 구문을 인식 할 수 있습니다.
 이 경우`<integer>`키워드는 모든 정수를 의미하고`+`는 공백으로 구분 된 목록을 나타냅니다.
 

```js
static get inputArguments() {
  return ["<integer>+", "<integer>+", "<integer>+"];
}
```

`inputArguments` 대신`inputProperties`를 사용하려면 요소에서 직접 사용자 정의 속성을 설정하고이를 수신 할 수 있습니다.
 다른 곳에서 상속 된 사용자 지정 속성이 유출되지 않도록하려면 네임 스페이스 지정이 중요합니다.
 

이제 입력을 얻었으므로 페인트 방법을 설정할 차례입니다.
 

`paint ()`의 핵심 개념은`context` 객체입니다.
 약간의 차이는 있지만 HTML`<canvas>`요소 컨텍스트와 비슷하고 비슷하게 작동합니다.
 현재는 보안상의 이유로 캔버스에서 픽셀을 다시 읽거나 텍스트를 렌더링 할 수 없습니다 (이 GitHub 스레드에 이유에 대한 간략한 설명이 있습니다).
 

`paint ()`메서드에는 4 개의 암시 적 매개 변수가 있습니다.
 

- 컨텍스트 객체
 
- 기하학 (너비와 높이가있는 개체)
 
- 속성 (`inputProperties`의 맵)
 
- 인수 (스타일 시트에서 전달 된 인수)
 

```js
paint(ctx, geom, props, args) {}
```

`geometry` 객체는 요소의 크기를 알고 있지만 X 및 Y 축에서 전체 테두리의 30 픽셀을 조정해야합니다.
 

```js
const width = (geom.width - borderWidth * 2);
const height = (geom.height - borderWidth * 2);
```

속성 및 인수는`inputProperties` 및`inputArguments`에서 확인 된 데이터를 보유합니다.
 속성은지도와 같은 객체로 제공되며`get ()`및`getAll ()`을 사용하여 값을 가져올 수 있습니다.
 

```js
const borderWidth = props.get("border-top-width").value;
const shadowColors = props.getAll("--shadow-colors");
```

`get ()`은 단일 값을 반환하고`getAll ()`은 배열을 반환합니다.
 

`--shadow-colors`는 배열로 가져올 수있는 공백으로 구분 된 색상 목록입니다.
 나중에 브라우저에 등록하여 예상되는 사항을 알 수 있습니다.
 

또한 사각형을 채울 색상을 지정해야합니다.
 요소와 동일한 배경색을 사용합니다.
 

```js
ctx.fillStyle = props.get("background-color").toString();
```

앞서 언급했듯이 인수는 모듈에 배열로 들어오고 인덱스로 참조합니다.
 지금은`CSSStyleValue` 유형입니다. 더 쉽게 반복 할 수 있도록하겠습니다.
 

- `toString ()`메서드를 사용하여`CSSStyleValue`를 문자열로 변환합니다.
 
- 정규식을 사용하여 결과를 공백으로 분할
 

```js
const blurArray = args[2].toString().split(/\s+/);
const xArray = args[0].toString().split(/\s+/);
const yArray = args[1].toString().split(/\s+/);
// e.g. ‘1 2 3’ -> [‘1’, ‘2’, ‘3’]
```

이제 치수와 속성을 얻었으므로 무언가를 그릴 때입니다!
 `shadowColors`의 각 항목에 대한 그림자가 필요하므로 반복해서 살펴 보겠습니다.
 `forEach ()`루프로 시작합니다.
 

```js
shadowColors.forEach((shadowColor, index) => { 
});
```

배열의 인덱스를 사용하여 X, Y 및 blur 인수에서 일치하는 값을 가져옵니다.
 

```js
shadowColors.forEach((shadowColor, index) => {
  ctx.shadowOffsetX = xArray[index];
  ctx.shadowOffsetY = yArray[index];
  ctx.shadowBlur = blurArray[index];
  ctx.shadowColor = shadowColor.toString();
});
```

마지막으로`fillRect ()`메서드를 사용하여 캔버스에 그릴 것입니다.
 X 위치, Y 위치, 너비 및 높이의 네 가지 인수가 필요합니다.
 위치 값의 경우`inputProperties`에서`border-width`를 사용합니다.
 이런 식으로 `border-image`는 사각형 주위의 그림자 만 포함하도록 잘립니다.
 

```js
shadowColors.forEach((shadowColor, index) => {
  ctx.shadowOffsetX = xArray[index];
  ctx.shadowOffsetY = yArray[index];
  ctx.shadowBlur = blurArray[index];
  ctx.shadowColor = shadowColor.toString();

  ctx.fillRect(borderWidth, borderWidth, width, height);
});
```

이 기술은 캔버스 드롭 섀도우 필터와 단일 직사각형을 사용하여 수행 할 수도 있습니다.
 Chrome, Edge, Firefox에서는 지원되지만 Safari에서는 지원되지 않습니다.
 CodePen에서 완성 된 예제를 참조하십시오.
 

거의 다 왔어!
 연결하는 데 몇 단계 만 더 있습니다.
 

### 페인트 모듈 등록
 

먼저 모듈을 브라우저에 페인트 워크 렛으로 등록해야합니다.
 이 작업은 기본 JavaScript 파일에서 다시 수행됩니다.
 

```js
CSS.paintWorklet.addModule("https://codepen.io/steve_fulghum/pen/bGevbzm.js");
https://codepen.io/steve_fulghum/pen/BazexJX
```

### 사용자 지정 속성 등록
 

우리가해야 할 다른 작업은 반드시 필요한 것은 아니지만 사용자 정의 속성을 등록하여 브라우저에 조금 더 알리는 것입니다.
 

등록 정보는 유형을 제공합니다.
 우리는 브라우저가`--shadow-colors`가 단순한 문자열이 아니라 실제 색상의 목록임을 알기를 원합니다.
 

Properties and Values API를 지원하지 않는 브라우저를 타겟팅해야한다면 실망하지 마세요!
 사용자 지정 속성은 등록되지 않은 경우에도 페인트 모듈에서 읽을 수 있습니다.
 그러나 이들은 사실상 문자열 인 구문 분석되지 않은 값으로 처리됩니다.
 자체 파싱 로직을 추가해야합니다.
 

`addModule ()`과 마찬가지로 기본 JavaScript 파일에 추가됩니다.
 

```js
CSS.registerProperty({
  name: "--shadow-colors",
  syntax: "<color>+",
  initialValue: "black",
  inherits: false
});
```

스타일 시트에서`@ property`를 사용하여 속성을 등록 할 수도 있습니다.
 MDN에 대한 간략한 설명을 읽을 수 있습니다.
 

### 이것을 border-image에 적용
 

이제 worklet이 브라우저에 등록되었으며 메인 CSS 파일에서 paint 메소드를 호출하여 이미지 URL을 대신 할 수 있습니다.
 

```css
border-image-source: paint(shadow, 0 0 0, 8 2 1, 8 5 3) 15;
border-image-slice: 15;
```

이것은 단위가없는 값입니다.
 1 : 1 이미지를 그리므로 픽셀과 동일합니다.
 

### 디스플레이 비율에 맞게 조정
 

거의 끝났지 만 해결해야 할 문제가 하나 더 있습니다.
 

여러분 중 일부에게는 상황이 예상과 다르게 보일 수 있습니다.
 멋지고 높은 DPI 모니터를 원 하시겠죠?
 기기 픽셀 비율에 문제가 발생했습니다.
 페인트 워크 릿에 전달 된 치수가 일치하도록 크기가 조정되지 않았습니다.
 

각 값을 수동으로 살펴보고 크기를 조정하는 대신 간단한 해결책은 `border-image-slice`값을 곱하는 것입니다.
 적절한 교차 환경 표시를 위해 수행하는 방법은 다음과 같습니다.
 

먼저`window.devicePixelRatio`를 노출하는 CSS 용 새 사용자 정의 속성을 등록 해 보겠습니다.
 

```js
CSS.registerProperty({
  name: "--device-pixel-ratio",
  syntax: "<number>",
  initialValue: window.devicePixelRatio,
  inherits: true
});
```

속성을 등록하고 초기 값을 제공하므로`inherit : true`가 모든 요소로 전달되므로`: root`에 설정할 필요가 없습니다.
 

마지막으로`border-image-slice` 값에`calc ()`를 곱합니다.
 

```css
.foo {
  border-image-slice: calc(15 * var(--device-pixel-ratio));
}
```

페인트 워크 렛도 기본적으로`devicePixelRatio` 값에 액세스 할 수 있다는 점에 유의해야합니다.
 클래스에서 간단히 참조 할 수 있습니다.
 `console.log (devicePixelRatio)`.
 

### 끝마친
 

아휴!
 이제 경계 영역의 경계에 적절하게 배율이 조정 된 이미지가 그려 져야합니다!
 

![image](https://paper-attachments.dropbox.com/s_BE5638C916916B3E8D93D3FDF3875CA176141E3D646941C71A3CE70189A62E66_1607378057665_image.png)

### 보너스 : 배경 이미지에 적용
 

나는 `테두리 이미지`대신 `배경 이미지`를 사용하는 솔루션도 시연하지 않을 것입니다.
 방금 작성한 모듈을 몇 가지만 수정하면 간단합니다.
 

사용할`border-width` 값이 없으므로이를 사용자 정의 속성으로 만들 것입니다.
 

```js
CSS.registerProperty({
  name: "--shadow-area-width",
  syntax: "<integer>",
  initialValue: "0",
  inherits: false
});
```

또한 사용자 지정 속성을 사용하여 배경색을 제어해야합니다.
 콘텐츠 상자 내부에 그리기 때문에 실제 `배경색`을 설정해도 배경 이미지 뒤에 계속 표시됩니다.
 

```js
CSS.registerProperty({
  name: "--shadow-rectangle-fill",
  syntax: "<color>",
  initialValue: "#fff",
  inherits: false
});
```

그런 다음`.foo`에 설정합니다.
 

```css
.foo {
  --shadow-area-width: 15;
  --shadow-rectangle-fill: #efefef;
}
```

이번에는`paint ()`가`border-image`에 대해했던 것과 동일한 인수를 사용하여`background-image`에 설정됩니다.
 

```css
.foo {
  --shadow-area-width: 15;
  --shadow-rectangle-fill: #efefef;
  background-image: paint(shadow, 0 0 0, 8 2 1, 8 5 3);
}
```

예상대로 이것은 배경에 그림자를 칠합니다.
 그러나 배경 이미지가 패딩 상자로 확장되므로 텍스트가 겹치지 않도록 `패딩`을 조정해야합니다.
 

```css
.foo {
  --shadow-area-width: 15;
  --shadow-rectangle-fill: #efefef;
  background-image: paint(shadow, 0 0 0, 8 2 1, 8 5 3);
  padding: 15px;
}
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_XWjJavr" src="//codepen.io/anon/embed/XWjJavr?height=450&amp;theme-id=1&amp;slug-hash=XWjJavr&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed XWjJavr" title="CodePen Embed XWjJavr" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 폴백
 

우리 모두 알다시피, 우리는 모든 사람이 동일한 브라우저를 사용하거나 가장 최신의 최신 브라우저에 액세스 할 수있는 세상에 살고 있지 않습니다.
 버스트 된 레이아웃을받지 않도록 몇 가지 폴백을 고려해 보겠습니다.
 

부모 요소의 패딩은 자식에서 확장되는 그림자를 수용하기 위해 콘텐츠 상자를 압축합니다.
 

```css
section.parent {
  padding: 6px; /* size of shadow on child */
}
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_jOrdvvY" src="//codepen.io/anon/embed/jOrdvvY?height=450&amp;theme-id=1&amp;slug-hash=jOrdvvY&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed jOrdvvY" title="CodePen Embed jOrdvvY" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

자식 요소의 여백은 클리핑 부모로부터 그림자를 멀리하기 위해 간격에 사용할 수 있습니다.
 

```css
div.child {
  margin: 6px; /* size of shadow on self */
}
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_QWEYVVO" src="//codepen.io/anon/embed/QWEYVVO?height=450&amp;theme-id=1&amp;slug-hash=QWEYVVO&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed QWEYVVO" title="CodePen Embed QWEYVVO" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이것은 패딩이나 여백보다 조금 더 비싸지 만 훌륭한 브라우저 지원을 제공합니다.
 CSS를 사용하면 이미지 대신 그라디언트를 사용할 수 있으므로`paint ()`로했던 것처럼`border-image` 내에서 그라디언트를 사용할 수 있습니다.
 디자인에 정확히 동일한 그림자가 필요하지 않은 한 이는 Paint API 솔루션의 대체 수단으로 훌륭한 옵션 일 수 있습니다.
 

그라디언트는 까다 롭고 까다로울 수 있지만 Geoff Graham은 사용에 대한 훌륭한 기사를 제공합니다.
 

```css
div {
  border: 6px solid;
  border-image: radial-gradient(
    white,
    #aaa 0%,
    #fff 80%,
    transparent 100%
  )
  25%;
}
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_ZEOwKwG" src="//codepen.io/anon/embed/ZEOwKwG?height=450&amp;theme-id=1&amp;slug-hash=ZEOwKwG&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed ZEOwKwG" title="CodePen Embed ZEOwKwG" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

추가 마크 업 및 CSS 위치 지정에 신경 쓰지 않고 정확한 그림자가 필요한 경우 삽입 된 의사 요소를 사용할 수도 있습니다.
 `Z- 색인`을 조심하세요!
 상황에 따라 조정이 필요할 수 있습니다.
 

```css
.foo {
  box-sizing: border-box;
  position: relative;
  width: 300px;
  height: 300px;
  padding: 15px;
}

.foo::before {
  background: #fff;
  bottom: 15px;
  box-shadow: 0px 2px 8px 2px #333;
  content: "";
  display: block;
  left: 15px;
  position: absolute;
  right: 15px;
  top: 15px;
  z-index: -1;
}
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_RwGRZwQ" src="//codepen.io/anon/embed/RwGRZwQ?height=450&amp;theme-id=1&amp;slug-hash=RwGRZwQ&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed RwGRZwQ" title="CodePen Embed RwGRZwQ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 마지막 생각들
 verified_user

그리고 여러분은 CSS Paint API를 사용하여 필요한 이미지 만 칠할 수 있습니다.
 다음 프로젝트에서 가장 먼저 도달해야 할 것이 있습니까?
 그건 당신이 결정할 일입니다.
 브라우저 지원은 아직 진행 중이지만 앞으로 나아가고 있습니다.
 

공정하게 말하면 단순한 문제가 요구하는 것보다 훨씬 더 복잡해질 수 있습니다.
 그러나 원하는 위치에 픽셀을 배치해야하는 상황이있는 경우 CSS Paint API는 강력한 도구입니다.
 

하지만 가장 흥미로운 것은 디자이너와 개발자에게 제공하는 기회입니다.
 그림자 그리기는 API가 수행 할 수있는 작업의 작은 예일뿐입니다.
 약간의 상상력과 독창성으로 모든 종류의 새로운 디자인과 상호 작용이 가능합니다.
 

### 추가 읽기
 

- CSS Paint API 사양
 
- Houdini는 아직 준비 되었습니까?
 
- CSS Paint API (Google 웹 개발자)
 
- CSS Houdini 실험
 
- Paint API를 사용하여 삼각형 및 라디오 입력을 그리는 또 다른 예
 