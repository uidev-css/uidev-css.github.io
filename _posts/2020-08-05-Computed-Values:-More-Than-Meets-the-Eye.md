---
layout: post
title: "계산된 값: 눈에 보이는 것 이상의 것"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/06/gV3KVm6g.png
tags: CASCADE,COMPUTED,DEVTOOLS,INHERITANCE,VALUES
---


브라우저 DevTools는 당사의 프런트 엔드 개발자에게 필수적입니다. 이 기사에서는 DevTools 패널의 작은 코너인 Computed 탭을 살펴봅니다. 이 탭은 상대 CSS 값이 어떻게 해결되는지를 보여 줍니다. 또한 상속이 브라우저의 스타일 계산 프로세스에 어떻게 적합한지도 확인할 수 있습니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/06/gV3KVm6g.png?fit=1024%2C727&ssl=1)

계산 탭의 내용은 브라우저가 렌더링된 웹 사이트에서 실제로 사용하고 있는 값을 보여주기 때문에 중요합니다. 요소의 스타일이 지정된 대로 지정되지 않은 경우 요소의 계산된 값을 보는 것이 그 이유를 이해하는 데 도움이 될 수 있습니다.

스타일 탭(파이어폭스의 규칙이라고 함)을 사용하는 데 익숙한 경우 계산 탭과 어떻게 다른지 궁금할 수 있습니다. 제 말은, 둘 다 요소에 적용되는 스타일을 보여줍니다. 정답? 계산 탭에는 스타일시트에 선언된 스타일, 상속에서 파생된 스타일 및 브라우저의 기본값이 포함된 확인된 스타일이 알파벳 순으로 표시됩니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/06/image.png?fit=1024%2C729&ssl=1)

반면 [스타일] 탭에는 선택한 요소의 정확한 규칙 집합이 기록된 대로 표시됩니다. 따라서 스타일 탭에 `.subhead {font-size:75}`와 같은 항목이 표시될 수 있지만 계산 탭에는 실제 글꼴 크기 또는 현재 `70%`가 표시됩니다. 예를 들어, 위와 같이 렌더링된 텍스트의 실제 글꼴 크기는 `13.2px`입니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/06/VNT_r8zq.png?fit=1024%2C729&ssl=1)

다음으로, 계산 탭에서 계산된 값이 도달하는 방법의 큰 부분인 두 가지인 상속과 캐스케이드 개념을 간략히 검토해보자.

### 상속 및 계단식 충돌 코스

> CSS는 Cascading Style Sheets의 약자로, 첫 번째 단어인 Cascading은 이해하는데 매우 중요하다. - CSS를 이해하는 데는 Cascading의 동작 방식이 중요하다.
MDN

캐스케이드는 CSS의 "C"이기 때문에 주목할 만하다. 문서에 대한 스타일 선언의 서로 다른 원본 간에 존재하는 충돌을 해결하는 데 사용되는 메커니즘입니다.

예를 들어, div의 너비를 두 번 정의하는 스타일시트를 상상해 보십시오.

```css
div {
  width: 65vw;
}
 
/* Somewhere, further down */
div {
  width: 85vw;
}
```

이 특정 예제에서 두 번째 너비는 마지막으로 선언된 이후 이깁니다. 첫 번째 폭은 여전히 중요!로 이길 수 있지만, 그것은 엄밀히 말하면 폭력에 의한 계단식 폭의 파괴이다. 여기서 요점은 캐스케이드 알고리듬이 각 요소에 적용되는 스타일을 결정하고 값에 안착하기 위해 미리 결정된 순서로 스타일을 우선시한다는 것이다.

캐스케이드는 브라우저, 웹 개발자 또는 사용자에 의해 명시적으로 설정된 속성에 적용됩니다. 캐스케이드 출력이 비어 있을 때 상속이 그림으로 나타난다. 이 경우 요소의 부모에 대한 속성 계산 값이 해당 속성에 대한 자체 값으로 가져옵니다. 예를 들어 요소의 색상을 지정하는 경우 하위 요소를 지정하지 않으면 모든 하위 요소가 해당 색상을 상속합니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_mdezzoa" src="//codepen.io/anon/embed/mdezzoa?height=450&amp;theme-id=1&amp;slug-hash=mdezzoa&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed mdezzoa" title="CodePen Embed mdezzoa" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

유산과 관련된 네 가지 핵심 재산가치가 있는데, 우리가 이룩하기 전에 먼저 알아둬야 한다. 기사 내내 이걸 사용할 거예요.

가장 높은 수준의 DOM 트리가 `<html> 요소인 HTML 문서에서, 이와 같은 요소에 `초기` 키워드를 사용할 때…

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_VwLEMeL" src="//codepen.io/anon/embed/VwLEMeL?height=450&amp;theme-id=1&amp;slug-hash=VwLEMeL&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed VwLEMeL" title="CodePen Embed VwLEMeL" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

…본문 요소가 녹색으로 설정되어 있더라도 해당 요소의 텍스트 색상은 검은색입니다. 더 높은 특수성을 갖는 div 선택기의 문제가 있지만, 우리는 왜 초기 div가 검은색으로 번역되었는지에 관심이 있다.

일반 용어로 이 키워드는 속성 정의 테이블(CSS 사양)에 지정된 대로 속성 기본값을 설정합니다. 이 경우 검은색은 브라우저가 `초기` 색상 값을 구현한 것입니다.

MDN에서 속성 페이지를 체크 아웃하면 기본적으로 상속되는지 여부를 알 수 있다고 기사 말미에 언급했습니다. 이러한 방식으로 모든 속성에 대한 초기 값을 찾을 수도 있습니다.

상속되지 않은 속성의 경우 이 키워드는 상속을 강제 적용합니다. 다음 예에서 <body> 요소는 빨간색 테두리가 완비되어 있습니다. 국경 재산은 기본적으로 상속되는 것이 아니라 국경 재산에 대한 상속 키워드를 사용하여 우리 디브이에게 `본문` 요소에 선언된 것과 같은 붉은 경계를 상속하라고 말할 수 있다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_rNVqGeo" src="//codepen.io/anon/embed/rNVqGeo?height=450&amp;theme-id=1&amp;slug-hash=rNVqGeo&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed rNVqGeo" title="CodePen Embed rNVqGeo" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

속성을 상속하면 `unset`이 상속된 값으로 확인됩니다. 그렇지 않으면 `초기` 값이 사용됩니다. 이는 기본적으로 `설정 해제`가 상속 여부에 따라 속성을 재설정한다는 의미입니다. 다음은 `설정 해제`를 전환하여 서로 다른 수준의 특수성을 가진 요소에 대한 효과를 보여주는 데모입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 500px;"><iframe id="cp_embed_BaoevoO" src="//codepen.io/anon/embed/BaoevoO?height=500&amp;theme-id=1&amp;slug-hash=BaoevoO&amp;default-tab=result" height="500" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed BaoevoO" title="CodePen Embed BaoevoO" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

요소에 CSS 속성이 설정되어 있지 않으면 스타일을 얻을 수 있습니까? 틀림 없어요. 브라우저의 기본 스타일을 사용합니다.

예를 들어 스팬 요소에 대한 디스플레이 속성의 초기 값은 인라인이지만 스타일시트에서 이를 블록으로 지정할 수 있습니다. 다음 데모의 버튼을 사용하여 `span` 요소의 `display` 및 `color` 속성 모두에서 `revert`를 전환할 수 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_XWmwovg" src="//codepen.io/anon/embed/XWmwovg?height=450&amp;theme-id=1&amp;slug-hash=XWmwovg&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed XWmwovg" title="CodePen Embed XWmwovg" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

범위가 인라인 요소로 올바르게 되돌아가지만 기다려 주십시오! 브라우저의 기본 검은색 값이 아닌 녹색으로 스팬 색상이 변경되는 것을 알고 계십니까? `반전`이 상속을 허용하기 때문이다. 색상을 설정하는 것은 브라우저의 기본 설정까지 거슬러 올라가지만, 명시적으로 `<body>` 요소에 녹색을 설정했기 때문에 이것이 상속되는 것입니다.

### DevTools에서 계산된 값 찾기

여기서 우리는 DevTools에서 계산된 값에 대해 이야기하기 시작합니다. 속성들의 기본값과 마찬가지로, CSS 속성의 계산된 값은 CSS 사양에서 그 속성의 정의 테이블에 의해 결정된다. 높이에서 볼 수 있는 재산은 다음과 같습니다.

10em 또는 70% 또는 5vw 중 하나와 같이 CSS에 상대적인 길이를 사용한다고 하자. 글꼴 크기나 뷰포트 같은 것과 "상대적"이기 때문에 픽셀 절대값으로 해결해야 합니다. 예를 들어, 뷰포트가 1000px 너비인 경우 너비가 10%인 요소는 100px로 계산되지만 뷰포트 너비가 변경되면 일부 다른 숫자도 함께 계산될 수 있습니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/06/o92gsazQ.png?resize=1079%2C647&ssl=1)

이러한 값은 계산 스타일 계산이라는 프로세스에서 DOM이 수정될 때마다 계산됩니다. 브라우저가 각 페이지 요소에 적용할 스타일을 알 수 있습니다.

스타일 계산은 여러 값을 포함하는 여러 단계에서 수행됩니다. 이것들은 CSS Cascading 및 Heritance Level 4 규격에 문서화되어 있으며, 모두 계산 탭에서 보는 최종 값에 영향을 미친다. 다음 작품들을 살펴보자.

### 값 및 값 처리 방법

스타일 계산 프로세스에 정의된 값에는 선언 값, 지정된 값, 계단식 값, 계산 값, 사용된 값 및 실제 값이 포함됩니다. 이렇게 많은 줄 누가 알았겠어요?

선언된 값은 요소에 적용되는 모든 속성 선언입니다. 브라우저는 다음과 같은 몇 가지 기준에 따라 이러한 선언을 식별합니다.

- 선언이 현재 문서에 적용되는 스타일시트에 있습니다.
- 스타일 선언에 일치하는 선택자가 있습니다.
- 스타일 선언에 유효한 구문(즉, 유효한 속성 이름 및 값)이 포함되어 있습니다.

다음 HTML을 사용합니다.

```html
<main>
  <p>It's not denial. I'm just selective about the reality I accept.</p>
</main>
```

다음은 텍스트의 `글꼴 크기`에 적용되는 선언된 값입니다.

```css
main {
  font-size: 1.2em; /* this would apply if the paragraph element wasn't targeted specifically, and even then, as an inherited value, not "declared value" */
}
 
main > p {
  font-size: 1.5em; /* declared value */
}
```

요소에 적용되는 모든 선언된 값의 목록은 다음과 같은 항목을 기준으로 우선 순위를 매겨 단일 값을 반환합니다.

- 선언의 출처(브라우저, 개발자 또는 다른 원본에서 온 것인가?)
- 선언이 `!중요`로 표시되었는지 여부
- 규칙의 특정 방식(예: `span {} 대 `section span {})
- 표시 순서(예: 여러 선언이 적용될 경우 마지막 선언이 사용됨)

즉, 계단식 값은 "승리" 선언입니다. 만약 계단식 값이 승리 선언값으로 이어지지 않는다면 계단식 값은 없습니다.

```css
main > p  {
  font-size: 1.2em;
}
 
main > .product-description { /* the same paragraph targeted in the previous rule */
  font-size: 1.2em; /* cascaded value based on both specificity and document order, ignoring all other considerations such as origin */
}
```

앞서 언급했듯이 캐스케이드 출력은 비어 있을 수 있다. 그러나 값은 여전히 다른 방법으로 찾을 필요가 있습니다.

요소의 특정 속성에 대한 값을 선언한 것이 아니라 상위 속성에 대한 값을 선언했다고 가정해 보겠습니다. 여러 곳에서 같은 값을 설정할 필요가 없기 때문에 의도적으로 하는 경우가 많습니다. 이 경우 상위 항목에 대한 상속된 값이 사용됩니다. 이를 지정된 값이라고 합니다.

대부분의 경우 계단식 값이 지정된 값이기도 합니다. 그러나 기본적으로 상속 키워드를 사용하거나 상속 키워드를 사용하여 계단식 값이 없고 관련 속성이 상속된 경우에도 상속된 값이 될 수 있습니다. 속성을 상속하지 않으면 지정된 값이 속성의 초기 값이며, 앞에서 언급한 것처럼 `initial` 키워드를 사용하여 명시적으로 설정할 수도 있습니다.

요약하면, 지정된 값은 해당 요소에 명시적으로 선언하거나 선언하지 않고 요소에 사용할 값입니다. 스타일시트에 선언된 내용이 없는 경우 브라우저의 기본값도 지정된 값이 될 수 있기 때문에 약간 흐릿합니다.

```css
/* Browser default = 16px */
 
main > p {
  /* no declared value for font-size for the paragraph element and all its ancestors */
}
```

앞서, 우리는 상대 값이 픽셀 절대 등가값으로 어떻게 해결되어야 하는지에 대해 간략히 논의하였다. 이미 언급한 바와 같이 이 프로세스는 사전에 결정됩니다. 예를 들어 속성 정의 테이블에는 일반적으로 지정된 값이 해결되는 방법을 설명하는 "계산된 값" 필드가 있습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/07/computed-value-field-color-property.png?resize=892%2C316&ssl=1)

다음 예에서는 상대적인 단위인 `em`과 함께 작업하고 있습니다. 여기서 속성이 적용되는 요소를 렌더링할 때 사용되는 최종 값은 우리의 선언된 값에 나타난 고정 숫자가 아니라 몇 가지 요인을 기반으로 계산해야 하는 값입니다.

```css
main {
  font-size: 1.2em;
}
 
main > p {
  font-size: 1.5em; /* declared value */
}
```

문단 요소의 글꼴 크기는 주항목의 글꼴 크기인 1.2em에 상대적인 1.5em으로 설정되어 있다. 본문 요소의 직계 하위 항목이고 그 위에 다음과 같은 추가적인 `글꼴 크기` 선언이 없는 경우(예:root` selector) 문단 `글꼴 크기`에 대한 계산이 다음과 같은 대략적인 과정을 따른다고 가정할 수 있다.

```
Browser_Default_FontSize = 16px;
Calculated_FontSize_For_Main = 1.2 * Browser_Default_FontSize; // 19.2px
Calculated_FontSize_For_Paragraph = 1.5 * Calculated_FontSize_For_Main; // 28.8px
```

그 28.8px는 계산된 값이다. 데모는 다음과 같습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_jObqgjQ" src="//codepen.io/anon/embed/jObqgjQ?height=450&amp;theme-id=1&amp;slug-hash=jObqgjQ&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed jObqgjQ" title="CodePen Embed jObqgjQ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

DevTools를 열고 계산 탭에서 계산된 글꼴 크기를 확인합니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/06/image-2.png?resize=2880%2C1852&ssl=1)

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/06/image-3.png?resize=2880%2C1852&ssl=1)

대신 렘 유닛을 사용한다고 가정합시다.

```css
html {
  font-size: 1.2em;
}
 
main {
  font-size: 1.5rem;
}
 
div {
  font-size: 1.7rem;
}
```

렘 단위의 계산된 값은 루트 HTML 요소의 폰트 크기를 기준으로 하므로 계산이 조금 바뀐다. 이 경우 HTML 요소에서도 상대 단위를 사용하므로 브라우저의 기본 `font-size` 값은 모든 `rem` 값을 해결하는 데 사용할 기본 `font-size` 값을 계산하는 데 사용됩니다.

```
Browser_Default_FontSize = 16px
Root_FontSize = 1.2 * Browser_Default_FontSize; // 19.2px
Calculated_FontSize_For_Main = 1.5 * Root_FontSize; // 28.8px
Calculated_FontSize_For_Div = 1.7 * Root_FontSize; // 32.64px
```

데모를 위해 DevTools를 다시 엽니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_qBOaMxw" src="//codepen.io/anon/embed/qBOaMxw?height=450&amp;theme-id=1&amp;slug-hash=qBOaMxw&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed qBOaMxw" title="CodePen Embed qBOaMxw" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

브라우저에서는 브라우저_Default_FontSize의 16px 값을 일반적으로 사용하지만, 이것은 변동의 대상이다. 현재 기본값을 보려면 DevTools에서 `<` 요소를 선택하고 해당 요소에 대해 표시되는 `font-size`를 확인하십시오. 이 예제에서와 같이 루트 요소에 대한 값을 명시적으로 설정한 경우 규칙 탭에서 값을 해제해야 할 수 있습니다. 그런 다음 계산 탭에서 "모두 표시" 또는 "브라우저 스타일"(파이어폭스) 확인란을 선택하여 기본값을 확인합니다.

상속 중에 계산된 값은 부모로부터 자식 요소로 전달됩니다. 이에 대한 계산 프로세스는 앞에서 살펴본 네 가지 상속 제어 키워드를 고려한다. 일반적으로 상대 값은 절대값이 됩니다(즉, 1rem은 16px가 됩니다). 여기서도 상대 URL이 절대 경로가 되고, 볼더(글꼴 가중치 속성 값)와 같은 키워드가 해결된다. 문서에서는 이 작업에 대한 몇 가지 추가 예를 볼 수 있습니다.

사용된 값은 계산된 값에 대해 모든 계산을 수행한 후 최종 결과입니다. 여기서 모든 상대 값은 절대값이 됩니다. 이 사용된 값은 페이지 레이아웃에 적용(가시적으로) 적용될 값입니다. 당신은 왜 더 많은 계산이 일어나야 하는지 궁금할 것이다. 지정된 값이 계산된 값으로 처리될 때 이전 단계에서 모두 처리되지 않았습니까?

여기서 중요한 점은 일부 상대 값은 이 시점에서 픽셀 절대값으로만 확인된다는 것입니다. 예를 들어, 백분율 지정 너비를 확인하려면 페이지 레이아웃이 필요할 수 있습니다. 그러나 많은 경우 계산된 값도 사용된 값이 된다.

사용된 값이 존재하지 않는 경우도 있습니다. CSS Cascading 및 상속 수준 4 규격에 따라:

> …특성이 요소에 적용되지 않는 경우 사용된 값이 없으므로, 예를 들어 '가변' 속성은 유연한 항목이 아닌 요소에 대해 사용된 값이 없습니다.

브라우저가 사용 값을 바로 적용할 수 없어 조정이 필요한 경우도 있습니다. 이 수정된 값을 실제 값이라고 합니다. 사용 가능한 글꼴을 기준으로 글꼴 크기를 조정해야 하거나 브라우저가 렌더링 중에 정수 값만 사용할 수 있고 정수가 아닌 값을 근사치로 계산해야 하는 경우를 생각해 보십시오.

### 브라우저 스타일 계산에서 상속

재점검하기 위해 상속은 명시적으로 설정되지 않은 속성의 요소에 적용되는 값을 제어합니다. 상속된 속성의 경우 이 값은 상위 요소에 대해 계산되는 모든 값에서 가져오며 상속되지 않은 속성의 경우 해당 속성의 초기 값이 설정됩니다(키워드 `initial`이 지정될 때 사용된 값).

우리는 앞서 "계산된 가치"의 존재에 대해 이야기했지만, 우리는 정말로 무엇인가를 명확히 할 필요가 있습니다. 스타일 해상도 프로세스에 참여하는 한 가지 유형의 값이라는 의미에서 계산된 값에 대해 논의했지만, "계산된 값"은 페이지 스타일링을 위해 브라우저에서 계산한 값의 일반적인 용어이기도 하다. 여러분은 일반적으로 우리가 주변 상황에 대해 어떤 것을 의미하는지 이해할 것입니다.

상속된 속성에는 계산된 값만 액세스할 수 있습니다. 477px와 같은 픽셀 절대값, 3과 같은 숫자 또는 왼쪽과 같은 값(예: `text-align: left)`이 상속 프로세스를 위해 준비되었습니다. 85%와 같은 백분율 값은 그렇지 않습니다. 속성에 대한 상대 값을 지정할 때 최종(즉, "사용") 값을 계산해야 합니다. 백분율 값 또는 기타 상대 값은 참조 크기(예: `font-size`) 또는 값(예: 장치 뷰포트의 너비)으로 곱됩니다. 따라서 속성의 최종 값은 선언된 값일 수 있으며, 이를 사용하려면 추가 처리가 필요할 수 있습니다.

이미 알아차렸을 수도 있고 그렇지 않았을 수도 있지만, 브라우저의 계산 탭에 표시된 값이 앞에서 설명한 계산 값 대 지정 값 또는 사용된 값일 필요는 없습니다. 오히려 표시된 값은 getComputedStyle() 함수에 의해 반환되는 값과 같습니다. 이 함수는 속성에 따라 계산된 값 또는 사용된 값이 될 값을 반환합니다.

자, 몇 가지 예를 봅시다.

```css
main {
  color: blue;
}

/* The color will inherit anyway, but we can be explicit too: */
main > p {
  color: inherit;
}
```

주 요소의 `color` 속성에 대해 계산된 값은 파란색이 됩니다. 색상은 기본적으로 상속되기 때문에 어차피 파란색이 되기 때문에 하위 항목인 경우 색:상속은 필요 없었다. 하지만 그것은 요점을 설명하는데 도움이 된다.

색상 값은 사용되는 값이 되기 위해 자체 해상도 프로세스를 거칩니다.

```css
main {
  font-size: 1.2em;
}

main > p {
  /* No styles specified */
}
```

값 및 값이 처리되는 방법에 대한 앞부분에서 보았듯이, 글꼴 크기에 대한 상대적 값은 명시적으로 선언하지 않더라도 절대값으로 계산한 다음 문단 요소에 의해 상속됩니다(다시 말하지만 글꼴 크기는 기본적으로 상속됨). 이전에 글로벌 문단 요소 선택기를 통해 스타일을 설정했다면, 캐스케이드 덕분에 문단에서 몇 가지 추가 스타일을 얻을 수 있다. 상속될 수 있는 모든 속성 값이 되며 캐스케이드 및 상속에서 값을 생성하지 않은 일부 속성이 초기 값으로 설정됩니다.

```css
body {
  font-size: 18px;
}

main {
  font-size: 80%;
}

main > p {
  /* No styles specified */
}
```

앞의 예와 마찬가지로 상속을 대비해 <메인> 요소의 글꼴 크기가 절대화되고 본문 18px 값의 80%인 글꼴 크기(14.4px)를 상속받게 된다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_zYvmMgM" src="//codepen.io/anon/embed/zYvmMgM?height=450&amp;theme-id=1&amp;slug-hash=zYvmMgM&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed zYvmMgM" title="CodePen Embed zYvmMgM" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

계산된 값은 일반적으로 레이아웃 없이 지정된 값을 최대한 많이 해결하지만 앞에서 언급한 것처럼 일부 값은 백분율 지정 `폭` 값과 같은 레이아웃 후 값만 확인할 수 있다. 폭은 상속된 재산이 아니지만, 사전 레이아웃과 사후 레이아웃 스타일 해상도를 설명하기 위해 상속을 강제할 수 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_xxwaZbb" src="//codepen.io/anon/embed/xxwaZbb?height=450&amp;theme-id=1&amp;slug-hash=xxwaZbb&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed xxwaZbb" title="CodePen Embed xxwaZbb" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이것은 조작된 예이지만 우리가 하는 일은 표시 속성을 "없음"으로 설정하여 페이지 레이아웃에서 요소를 제거하는 것입니다. 우리의 마크업에는 그들의 모체 요소인 <섹션>으로부터 50%인 `폭`을 물려받는 두 개의 div가 있다. DevTools의 Computed 탭에서 첫 번째 div의 계산된 `width`는 픽셀 값(243.75px)으로 해결된 절대값이다. 반면 `디스플레이:없음`을 사용해 레이아웃에서 꺼낸 2div의 폭은 여전히 50%다.

상위 `섹션` 요소에 대해 지정되고 계산된 값이 50%(사전 레이아웃)이고 사용된 값이 계산 탭 아래에 표시된 것과 같다고 가정하면, 이는 사후 레이아웃인 487.5px이다. 이 값은 하위 디브(포함 블록의 50%)에 의한 상속에서 절반으로 감소합니다.

브라우저의 뷰포트 너비가 변경될 때마다 이 값을 계산해야 합니다. 따라서 백분율 지정 값은 백분율 계산 값이 되고, 이 값은 픽셀 사용 값이 됩니다.

### 기본적으로 상속되는 속성

속성이 기본적으로 상속되는지 여부를 어떻게 알 수 있습니까? MDN 문서의 각 CSS 속성에 대해 속성 상속 여부를 포함하는 몇 가지 추가 세부 정보를 제공하는 사양 섹션이 있습니다. 색상의 특성은 다음과 같습니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/06/image-4.png?resize=888%2C314&ssl=1)

> 기본적으로 상속되는 속성 및 상속되지 않는 속성은 주로 상식에 따라 다릅니다.
MDN

또 다른 참조 옵션은 W3C 사양의 속성 섹션입니다. 그러나 다른 하나는 스택 오버플로 스레드로, 이 스레드는 작성 시 완전하지 않을 수 있습니다.

기본적으로 상속되는 속성의 몇 가지 예는 다음과 같습니다.

- 색채
- `방향`
- 폰트 패밀리
- 글꼴 크기
- `글꼴`
- `편지 발송인
- `선 높이`
- 목록형식
- 탭 크기
- 텍스트 정렬
- `문자 표시`
- `문자 표시`
- 가시성
- `말싸기

상속하지 않지만 상속 키워드로 상속할 수 있는 속성의 예:

- `상자 보관함`
- 국경
- `내용
- 높이
- ➡➡➡➡➡➡➡➡➡➡ ➡
- `객체 적합`
- ➡➡➡➡➡➡➡➡➡➡ ➡
- ➡➡➡➡➡➡➡➡➡➡ ➡
- 직위치`
- ➡➡➡➡➡➡➡➡➡➡ ➡
- 과도기
- 폭
- z-색인

그러면 브라우저가 스타일을 계산하는 방법과 DevTools에서 스타일을 참조하는 방법을 확실하게 알 수 있을 것입니다. 보시다시피, 이면에는 가치로 들어가는 것이 많습니다. 이러한 맥락을 갖는 것은 우리가 CSS라고 알고 있는 훌륭한 언어에 대한 여러분의 일반적인 이해를 증진시킬 뿐만 아니라 여러분의 작업 문제를 해결하는 데 도움이 됩니다.

- QuirksMode.org에 의한 상속, 초기 및 설정 해제 값
- CSS 상속: 아샤 락스미의 소개
- CSS 상속, 캐스케이드 및 글로벌 범위: Heydon Pickering의 새로운 가장 나쁜 친구
- Ollie Williams의 캐스케이드, 상속 및 특수성을 처리하는 최신 방법
- MDN에 의한 캐스케이드 및 상속
- MDN에 의한 상속
- MDN에 의한 캐스케이드
- CSS 계단식 및 상속 수준 4(W3C 사양)
- 일리야 그리고리크의 렌더링 트리 구성, 배치 및 도장
- MDN의 Window.getComputedStyle()
- Aaron Gustafson의 대화형 URL