---
layout: post
title: "뷰포트를 기반으로 CSS 클램프()를 사용한 선형 축척 글꼴 크기"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/08/clamp-website.jpg
tags: CLAMP,FLUID TYPE,FONT-SIZE,RELATIVE SIZING
---


대응형 타이포그래피는 과거에 미디어 쿼리 및 CSS `calc()와 같은 많은 방법으로 시도되었다.

여기서는 뷰포트의 너비가 증가함에 따라 최소 및 최대 크기 사이에서 텍스트를 선형적으로 스케일링하는 다른 방법을 탐색할 것이며, 이는 모두 `clamp()`clamp() 덕분에 CSS의 단일 행으로 동작을 더욱 예측하기 위한 것이다.

CSS 기능 클램프()는 헤비타자이다. 다양한 용도로 유용하지만, 특히 타이포그래피에 좋습니다. 작동 방식은 이렇습니다. 다음 세 가지 값이 필요합니다.

```css
clamp(minimum, preferred, maximum);
```

기본값이 최소값(최소값이 반환되는 시점)보다 낮거나 최대값(최대값이 반환되는 시점)보다 높을 때까지 반환되는 값이 기본값이 됩니다.

![image](https://css-tricks.com/wp-content/uploads/2020/09/clamp-ex.svg)

이상하지 않고 최소값과 최대값 사이에서 설정한다면 항상 선호되는 값이 아닐까요? 선호되는 값에 대한 공식을 사용하는 것이 좋습니다.

```css
.banner {
  width: clamp(200px, 50% + 20px, 800px); /* Yes, you can do math inside clamp()! */
}
```

뷰포트 너비가 360px 이하일 때 요소의 최소 `글꼴 크기`를 1rem으로 설정하고 뷰포트 너비가 840px 이상일 때 최대값을 3.5rem으로 설정하려고 합니다.

즉, 다음과 같습니다.

```
1rem   = 360px and below
Scaled = 361px - 839px
3.5rem = 840px and above
```

361과 839픽셀 사이의 뷰포트 폭은 1과 3.5rem 사이의 글꼴 크기를 선형으로 조정해야 합니다. clamp()로 하면 정말 쉬워! 예를 들어, 600픽셀의 뷰포트 폭에서 360픽셀과 840픽셀 사이의 중간 값인 1과 3.5rem 사이, 즉 2.25rem을 얻을 수 있습니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/09/ap9aPWBI.png?resize=1565%2C742&ssl=1)

우리가 `clamp()`로 달성하고자 하는 것을 선형 보간이라고 한다. 두 데이터 포인트 사이에서 중간 정보를 얻는 것이다.

이를 위한 네 가지 단계는 다음과 같습니다.

최소 및 최대 글꼴 크기, 최소 및 최대 뷰포트 너비를 선택합니다. 이 예에서는 글꼴 크기에 대해 1rem 및 3.5rem이고 너비에 대해 360px 및 840px입니다.

너비를 `rem`으로 변환합니다. 대부분의 브라우저에서는 기본적으로 1rem이 16px이므로(나중에 추가되는 경우), 바로 이 기능을 사용할 것입니다. 따라서 이제 최소 뷰포트 폭과 최대 뷰포트 폭은 각각 22.5rem과 52.5rem이 됩니다.

자, 이제 수학 쪽으로 좀 기울이도록 하죠. 서로 쌍을 이루면 뷰포트 폭과 글꼴 크기가 X 및 Y 좌표계에서 두 점을 만들고 이 점들은 선을 만듭니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/09/wdl-gKiY.png?resize=973%2C379&ssl=1)

우리는 좀 더 구체적이기 위해 그 선, 혹은 그것의 경사도와 Y축과의 교차점이 필요하다. 계산 방법은 다음과 같습니다.

```
slope = (maxFontSize - minFontSize) / (maxWidth - minWidth)
yAxisIntersection = -minWidth * slope + minFontSize
```

그러면 기울기는 0.0833이고 Y축 교차로는 -0.875입니다.

이제 클램프() 기능을 구축합니다. 선호 값의 공식은 다음과 같습니다.

```
preferredValue = yAxisIntersection[rem] + (slope * 100)[vw]
```

결국 기능은 다음과 같습니다.

```css
.header {
  font-size: clamp(1rem, -0.875rem + 8.333vw, 3.5rem);
}
```

다음 데모에서 결과를 시각화할 수 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_yLONLPv" src="//codepen.io/anon/embed/yLONLPv?height=450&amp;theme-id=1&amp;slug-hash=yLONLPv&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed yLONLPv" title="CodePen Embed yLONLPv" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

어서 가지고 놀아라. 보시다시피, 보기 포트 너비가 840px일 때 글꼴 크기가 증가하지 않고 360px에서 축소되지 않습니다. 그 사이의 모든 것은 선형적인 방식으로 변한다.

### 사용자가 루트의 글꼴 크기를 변경하면 어떻게 됩니까?

이 전체 접근 방식에서 약간의 결함을 발견했을 수 있습니다. 루트의 글꼴 크기가 이전 예에서 16px인 경우에만 작동하고 변경되지 않습니다.

360px와 840px의 너비를 16으로 나누어 `rem` 단위로 변환하는 것이 루트의 글꼴 크기라고 가정하기 때문이다. 기본 설정을 다른 루트 글꼴 크기로 설정한 경우 기본 16px 대신 18px로 설정하면 계산이 잘못되어 텍스트가 예상대로 크기를 조정하지 않습니다.

여기서 사용할 수 있는 접근 방식은 (1) 페이지 로드 시 코드에서 필요한 계산을 수행하고, (2) 루트의 글꼴 크기 변경 내용을 청취하고, (3) 변경이 발생할 경우 모든 것을 재계산하는 것입니다.

다음은 계산을 수행하는 데 유용한 JavaScript 기능입니다.

```js
// Takes the viewport widths in pixels and the font sizes in rem
function clampBuilder( minWidthPx, maxWidthPx, minFontSize, maxFontSize ) {
  const root = document.querySelector( "html" );
  const pixelsPerRem = Number( getComputedStyle( root ).fontSize.slice( 0,-2 ) );

  const minWidth = minWidthPx / pixelsPerRem;
  const maxWidth = maxWidthPx / pixelsPerRem;

  const slope = ( maxFontSize - minFontSize ) / ( maxWidth - minWidth );
  const yAxisIntersection = -minWidth * slope + minFontSize

  return `clamp( ${ minFontSize }rem, ${ yAxisIntersection }rem + ${ slope * 100 }vw, ${ maxFontSize }rem )`;
}

// clampBuilder( 360, 840, 1, 3.5 ) -> "clamp( 1rem, -0.875rem + 8.333vw, 3.5rem )"
```

반환된 문자열을 CSS에 주입하는 방법은 의도적으로 생략하고 있습니다. 당신의 필요에 따라, 그리고 당신이 바닐라 CSS, CSS-in-JS 라이브러리, 또는 다른 것을 사용하고 있는지 여부에 따라 많은 방법이 있기 때문입니다. 또한 글꼴 크기 변경에 대한 기본 이벤트가 없으므로 수동으로 확인해야 합니다. `세트`를 쓰면 되겠네요매초마다 점검하는 간격이지만 성능 비용이 발생할 수 있습니다.

이건 좀 더 날렵한 케이스야. 브라우저의 글꼴 크기를 변경하는 사람은 거의 없으며 사이트를 방문하는 동안 정확히 변경하는 사람은 더 적습니다. 하지만 여러분의 사이트가 가능한 한 신속하게 처리되기를 원한다면, 이것이 바로 방법입니다.

### 그 엣지 케이스에 개의치 않는 분들을 위해

완벽하지 않아도 살 수 있다고 생각해? 그럼 너한테 줄 게 있어 나는 계산을 빠르고 간단하게 하기 위해 작은 도구를 만들었다.

너비와 글꼴 크기만 도구에 연결하면 기능이 계산됩니다. 결과를 복사하여 CSS에 붙여넣습니다. 화려하지도 않고 많은 부분이 개선될 수 있을 거라고 확신하지만, 이 기사의 목적상으로는 충분하고도 남습니다. 마음껏 포크를 만들고 수정하세요.

### 텍스트의 흐름을 방지하는 방법

타이포그래피 치수에 대한 세밀한 제어를 통해 우리는 다른 뷰포트 폭에서 텍스트가 다시 흐르지 않도록 하는 것과 같은 다른 멋진 작업을 할 수 있다.

일반적으로 텍스트의 동작 방식입니다.

하지만 이제, 우리가 가진 제어장치로, 우리는 텍스트를 같은 수의 선으로 유지하게 할 수 있습니다. 항상 같은 단어에, 우리가 어떤 뷰포트 폭에 던지든 말이죠.

어떻게 해야 할까요? 시작하려면 글꼴 크기와 뷰포트 폭 사이의 비율이 동일해야 합니다. 이 예에서는 320px의 경우 1rem에서 960px의 경우 3rem으로 이동합니다.

```
320 / 1 = 320
960 / 3 = 320
```

앞에서 만든 `clampBuilder()` 기능을 사용하는 경우 다음과 같이 됩니다.

```js
const text = document.querySelector( "p" );
text.style.fontSize = clampBuilder( 320, 960, 1, 3 );
```

너비 대 글꼴 비율을 동일하게 유지합니다. 우리가 이렇게 하는 이유는 텍스트가 동일한 수의 선을 유지할 수 있도록 모든 폭에서 올바른 크기를 가져야 하기 때문입니다. 아직 폭이 다르겠지만, 다음에 우리가 할 일을 위해서 이렇게 하는 것이 필요해요.

이제 우리는 글자 크기가 적당하지 않기 때문에 CSS 문자 (ch) 단위의 도움을 받아야 합니다. 하나의 "ch" 단위는 요소의 글꼴에서 글리프 "0"의 너비와 같습니다. 우리는 텍스트 본문을 가로로 채우는 데 필요한 ch 단위(또는 0s)의 양인 너비 100%가 아니라 너비 Xch로 뷰포트만큼 넓게 만들고자 한다.

X를 찾으려면 최소 뷰포트 폭인 320px를 320px 너비가 320px일 때 어떤 글꼴 크기에서 요소의 "ch" 크기로 나누어야 한다. 이 사건에서 1리멤버입니다.

걱정하지 마세요, 여기 원소의 `ch` 크기를 계산하는 조각이 있습니다.

```js
// Returns the width, in pixels, of the "0" glyph of an element at a desired font size
function calculateCh( element, fontSize ) {
  const zero = document.createElement( "span" );
  zero.innerText = "0";
  zero.style.position = "absolute";
  zero.style.fontSize = fontSize;

  element.appendChild( zero );
  const chPixels = zero.getBoundingClientRect().width;
  element.removeChild( zero );

  return chPixels;
}
```

이제 텍스트 너비를 계속 설정할 수 있습니다.

```js
function calculateCh( element, fontSize ) { ... }

const text = document.querySelector( "p" );
text.style.fontSize = clampBuilder( 320, 960, 1, 3 );
text.style.width = `${ 320 / calculateCh(text, "1rem" ) }ch`; 

```

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/09/CqaUfg-U.png?resize=421%2C451&ssl=1)

워, 잠깐만. 안 좋은 일이 생겼어요. 가로 스크롤 막대가 일을 망치고 있어!

우리가 320px에 대해 말할 때, 우리는 수직 스크롤 바를 포함한 뷰포트의 너비에 대해 이야기하고 있습니다. 따라서 텍스트 너비는 보이는 영역의 너비에 스크롤 막대의 너비를 더하여 가로로 넘치게 합니다.

그러면 세로 스크롤 막대의 너비가 포함되지 않은 메트릭을 사용하는 것은 어떨까요? 우리는 할 수 없고 그것은 CSS `vw` 장치 때문입니다. 우리는 글자 크기를 제어하기 위해 clamp()의 vw를 사용하고 있다는 것을 기억하십시오. vw는 세로 스크롤 막대의 너비를 포함하므로 스크롤 막대를 포함한 뷰포트 너비를 따라 글꼴 크기를 조정할 수 있습니다. 리플로우를 방지하려면 스크롤 막대를 포함하여 뷰포트의 너비에 비례해야 합니다.

따라서 우리는 어떻게 해야 할까요? 이 작업을 수행할 때:

```js
text.style.width = `${ 320 / calculateCh(text, "1rem") }ch`;
```

…우리는 결과를 1.0.9보다 작은 숫자로 곱하여 축소할 수 있습니다. 즉, 텍스트 너비가 뷰포트 너비의 90%가 된다는 것을 의미하며, 이는 스크롤 막대가 차지하는 작은 공간을 설명하는 것보다 더 많은 양입니다. 0.6처럼 더 작은 숫자를 사용하면 더 좁힐 수 있습니다.

```js
function calculateCh( element, fontSize ) { ... }

const text = document.querySelector( "p" );
text.style.fontSize = clampBuilder( 20, 960, 1, 3 );
text.style.width = `${ 320 / calculateCh(text, "1rem" ) * 0.9 }ch`;
```

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/09/DMsBf3xo.png?resize=353%2C431&ssl=1)

다음과 같이 스크롤 막대를 무시하려면 320에서 몇 개의 픽셀을 빼야 할 수도 있습니다.

```js
text.style.width = `${ ( 320 - 30 ) / calculateCh( text, "1rem" ) }ch`;
```

이것의 문제는 그것이 리플로우 문제를 다시 불러온다는 것입니다! 320에서 빼면 뷰포트 대 글꼴 비율이 깨지기 때문입니다.

텍스트 너비는 항상 뷰포트 너비의 백분율이어야 합니다. 염두에 두어야 할 또 다른 사항은 사이트를 사용하는 모든 장치에 동일한 글꼴을 로드해야 한다는 것입니다. 이거 뻔하게 들리지 않나요? 자, 여기 여러분의 텍스트를 생략할 수 있는 작은 세부 사항이 있습니다. font-family: sans-serif와 같은 것을 한다고 해서 모든 브라우저에서 동일한 글꼴이 사용된다는 보장은 없다. 샌세리프는 아이리얼을 윈도용 크롬으로, 로보트는 안드로이드용 크롬으로 설정한다. 또한 일부 글꼴의 지오메트리는 모든 작업을 올바르게 수행해도 다시 흐름을 일으킬 수 있습니다. 단공간 글꼴은 최상의 결과를 산출하는 경향이 있다. 따라서 항상 글꼴이 정확한지 확인하십시오.

다음 데모에서 이 비반복 예제를 확인하십시오.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_BaKNePe" src="//codepen.io/anon/embed/BaKNePe?height=450&amp;theme-id=1&amp;slug-hash=BaKNePe&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed BaKNePe" title="CodePen Embed BaKNePe" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 컨테이너 내부의 비반복 텍스트

이제 텍스트 요소 대신 글꼴 크기와 너비를 컨테이너에 직접 적용하기만 하면 됩니다. 안에 있는 텍스트는 `폭: 100%`로 설정하기만 하면 됩니다. 어차피 블록 레벨 요소이고 컨테이너 너비를 자동으로 채울 것이기 때문에 문단 및 표제의 경우에는 필요하지 않습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_vYGZvGN" src="//codepen.io/anon/embed/vYGZvGN?height=450&amp;theme-id=1&amp;slug-hash=vYGZvGN&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed vYGZvGN" title="CodePen Embed vYGZvGN" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이를 부모 컨테이너에 적용하면 자식들이 글꼴 크기와 너비를 하나씩 설정할 필요 없이 자동으로 반응하고 크기를 조정할 수 있다는 장점이 있다. 또한, 단일 요소의 글꼴 크기를 다른 요소에 영향을 주지 않고 변경할 필요가 있다면, 우리가 할 일은 글꼴 크기를 임의의 `이` 양으로 바꾸기만 하면 되고, 컨테이너의 글꼴 크기에 비례하게 됩니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_ExKXGwz" src="//codepen.io/anon/embed/ExKXGwz?height=450&amp;theme-id=1&amp;slug-hash=ExKXGwz&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed ExKXGwz" title="CodePen Embed ExKXGwz" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

따라하지 않는 텍스트는 까다롭지만 디자인에 멋진 터치를 가져다 줄 수 있는 미묘한 효과입니다!

### 마무리하기

이 모든 것을 멈추기 위해, 저는 이 모든 것이 실제 상황에서 어떻게 보일 수 있는지에 대한 간단한 설명을 덧붙였습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_xxVVKPZ" src="//codepen.io/anon/embed/xxVVKPZ?height=450&amp;theme-id=1&amp;slug-hash=xxVVKPZ&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed xxVVKPZ" title="CodePen Embed xxVVKPZ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이 마지막 예에서는 루트 글꼴 크기를 변경할 수도 있으며 `clamp()` 함수가 자동으로 재계산되어 텍스트가 어떤 상황에서도 올바른 크기를 가질 수 있습니다.

이 기사의 대상은 글꼴 크기의 clamp()를 사용하는 것이지만, 길이 단위를 수신하는 CSS 속성에는 동일한 기술을 사용할 수 있다. 이걸 아무데서나 쓰라고 하는 건 아니에요 옛날의 폰트 사이즈 1렘만 있으면 되는 경우가 많다. 필요할 때 얼마나 통제력을 가질 수 있는지 보여드리려는 거예요

개인적으로 clamp()는 CSS에 들어가기에 가장 좋은 것 중 하나라고 생각하는데, 점점 더 널리 퍼지면서 다른 사람들이 어떻게 쓰는지 기대된다!