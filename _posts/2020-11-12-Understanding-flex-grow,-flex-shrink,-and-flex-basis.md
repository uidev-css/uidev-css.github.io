---
layout: post
title: "flex-grow, flex-shrink 및 flex-basis 이해"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2018/12/guide-flexbox.png
tags: FLEX-BASIS,FLEX-GROW,FLEX-SHRINK,FLEXBOX
---


CSS 속성을 요소에 적용하면 내부적으로 많은 일이 발생합니다.
 예를 들어 다음과 같은 HTML이 있다고 가정 해 보겠습니다.
 

```html
<div class="parent">
  <div class="child">Child</div>
  <div class="child">Child</div>
  <div class="child">Child</div>
</div>
```

그리고 CSS를 작성합니다.
 

```css
.parent {
  display: flex;
}
```

기술적으로 위의 CSS 한 줄을 작성할 때 적용하는 유일한 스타일은 아닙니다.
 사실, 마치 우리가 이러한 스타일을 직접 작성한 것처럼 여기에서`.child` 요소에 전체 속성이 적용됩니다.
 

```css
.child {
  flex: 0 1 auto; /* Default flex value */
}
```

이상 하네!
 코드를 작성하지 않았지만 이러한 요소에 이러한 추가 스타일이 적용된 이유는 무엇입니까?
 그 이유는 일부 속성에 기본값이 있으므로 우리가 재정의하기 때문입니다.
 그리고 CSS를 작성할 때 이러한 스타일이 적용되는 것을 알지 못한다면 레이아웃이 상당히 혼란스럽고 관리하기 어려울 수 있습니다.
 

위의 `flex`속성은 속기 CSS 속성으로 알려져 있습니다.
 실제로 이것이하는 일은 세 개의 개별 CSS 속성을 동시에 설정하는 것입니다.
 그래서 우리가 위에서 쓴 것은 이것을 쓰는 것과 같습니다 :
 

```css
.child {
  flex-grow: 0;
  flex-shrink: 1;
  flex-basis: auto;
}
```

따라서 속기 속성은 다음과 같이 작성할 수있는 `background`속성과 같이 한 번에 여러 속성을 더 쉽게 작성할 수 있도록 다양한 CSS 속성을 묶습니다.
 

```css
body {
  background: url(sweettexture.jpg) top center no-repeat fixed padding-box content-box red;                   
}
```

나는 속기 속성이 매우 혼란 스러울 수 있기 때문에 피하려고 노력하고 종종 내 두뇌가 긴 속성 값을 구문 분석하지 못하기 때문에 긴 손 버전을 작성하는 경향이 있습니다.
 그러나 flexbox와 관련하여 속기를 사용하는 것이 좋습니다. 즉, `flex`속성이 많은 작업을 수행하고 각 하위 속성이 다른 속성과 상호 작용한다는 것을 이해할 때까지 ... 이상합니다.
 

또한 이러한 flexbox 속성이 90 %의 시간 동안 수행하는 작업을 알 필요가 없기 때문에 기본 스타일이 좋습니다.
 예를 들어, flexbox를 사용할 때 다음과 같이 작성하는 경향이 있습니다.
 

```css
.parent {
  display: flex;
  justify-content: space-between;
}
```

하위 요소 나 여기에 적용된 스타일에 대해 신경 쓸 필요조차 없습니다. 훌륭합니다!
 이 경우 하위 항목을 나란히 정렬 한 다음 서로 균등하게 간격을 둡니다.
 두 줄의 CSS는 여기에서 많은 힘을 제공합니다. 이것이 flexbox와 이러한 상속 된 스타일에 대한 가장 좋은 점입니다. 90 %의 시간 동안 동일한 작업을 수행하려는 경우 내부적으로 모든 복잡성을 이해할 필요가 없습니다.
 .
 모든 복잡성이 보이지 않기 때문에 매우 똑똑합니다.
 

하지만`flex-grow`,`flex-shrink`,`flex-basis` 속성을 포함한 flexbox가 실제로 어떻게 작동하는지 이해하려면 어떻게해야할까요?
 그리고 우리는 그들로 어떤 멋진 일을 할 수 있습니까?
 

CSS-Tricks Almanac으로 이동하십시오.
 끝난!
 

농담입니다.
 조금 단순화 된 간단한 개요부터 시작하여 하위 요소에 적용되는 기본`flex` 속성으로 돌아가 보겠습니다.
 

```css
.child {
  flex: 0 1 auto;
}
```

이러한 기본 스타일은 자식 요소에 확장 및 확장 방법을 알려줍니다.
 그러나 사용되거나 재정의되는 것을 볼 때마다 다음과 같은 속기 속성을 생각하는 것이 도움이됩니다.
 

```css
/* This is just how I think about the rule above in my head */

.child {
  flex: [flex-grow] [flex-shrink] [flex-basis];
}

/* or... */

.child {
  flex: [max] [min] [ideal size];
}
```

첫 번째 값은`flex-grow`이고`0`으로 설정되어 있습니다. 기본적으로 요소가 전혀 확장되는 것을 원하지 않기 때문입니다 (대부분의 경우).
 대신 모든 요소가 그 안에있는 콘텐츠의 크기에 종속되기를 원합니다.
 예를 들면 다음과 같습니다.
 

```css
.parent { 
  display: flex; 
}
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 200px;"><iframe id="cp_embed_bc3d06b3162c4163a9e51ccd91913986" src="//codepen.io/anon/embed/bc3d06b3162c4163a9e51ccd91913986?height=200&amp;theme-id=1&amp;slug-hash=bc3d06b3162c4163a9e51ccd91913986&amp;default-tab=result" height="200" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed bc3d06b3162c4163a9e51ccd91913986" title="CodePen Embed bc3d06b3162c4163a9e51ccd91913986" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

위의 각`.child` 요소에`contenteditable` 속성을 추가하여 클릭하여 더 많은 콘텐츠를 입력 할 수 있습니다.
 어떻게 반응하는지 보십니까?
 이것이 가변 상자 항목의 기본 동작입니다. `flex-grow`는 내부 콘텐츠에 따라 요소가 커지기를 원하기 때문에 `0`으로 설정됩니다.
 

그러나!
 다음과 같이`flex-grow` 속성의 기본값을`0`에서`1`로 변경하면 ...
 

```css
.child {
  flex: 1 1 auto;
}
```

그러면 모든 요소가 성장하여 .parent 요소의 동일한 부분을 차지합니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 200px;"><iframe id="cp_embed_7aab5c7671016f4c76401020568d49b0" src="//codepen.io/anon/embed/7aab5c7671016f4c76401020568d49b0?height=200&amp;theme-id=1&amp;slug-hash=7aab5c7671016f4c76401020568d49b0&amp;default-tab=result" height="200" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed 7aab5c7671016f4c76401020568d49b0" title="CodePen Embed 7aab5c7671016f4c76401020568d49b0" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이것은 글쓰기와 똑같습니다…
 

```css
.child {
  flex-grow: 1;
}
```

… 다른 값은 어쨌든 기본적으로 설정되어 있으므로 무시합니다.
 유연한 레이아웃으로 작업을 시작했을 때 오랫동안 혼란 스러웠습니다.
 그냥`flex-grow`를 추가하고 다른 스타일이 어디에서 왔는지 궁금해하는 코드를 보게 될 것입니다.
 내가 알아낼 수 없었던 격분한 살인 미스터리 같았어요.
 

이제 이러한 요소 중 하나만 다른 요소보다 더 많이 성장하도록하려면 다음을 수행하면됩니다.
 

```css
.child-three {
  flex: 3 1 auto;
}

/* or we could just write... */

.child-three {
  flex-grow: 3;
}
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 200px;"><iframe id="cp_embed_a0492e0d5913e92c2e2a6fee17e065b0" src="//codepen.io/anon/embed/a0492e0d5913e92c2e2a6fee17e065b0?height=200&amp;theme-id=1&amp;slug-hash=a0492e0d5913e92c2e2a6fee17e065b0&amp;default-tab=result" height="200" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed a0492e0d5913e92c2e2a6fee17e065b0" title="CodePen Embed a0492e0d5913e92c2e2a6fee17e065b0" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

Flexbox가 브라우저에 탑재 된 지 10 년이 지난 후에도이 이상한 코드를 볼 수 있습니까?
 그것은 확실히 나를위한 것입니다.
 속기를 읽을 때“아, 최대, 최소, 이상적인 크기”라고 말할 수있는 추가 두뇌 능력이 필요하지만 시간이지나면서 점점 쉬워집니다.
 어쨌든 위의 예에서 처음 두 자식 요소는 비례 적으로 동일한 공간을 차지하지만 세 번째 요소는 다른 요소보다 최대 3 배까지 공간을 늘리려 고합니다.
 

이제 이것은 모든 것이 자식 요소의 내용에 의존하기 때문에 상황이 이상 해지는 곳입니다.
 위의 예에서와 같이`flex-grow`를`3`으로 설정 한 다음 콘텐츠를 더 추가하더라도 레이아웃은 다음과 같이 이상하고 특이한 작업을 수행합니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 200px;"><iframe id="cp_embed_480cd39e0ef5f98f6d82706f0478a504" src="//codepen.io/anon/embed/480cd39e0ef5f98f6d82706f0478a504?height=200&amp;theme-id=1&amp;slug-hash=480cd39e0ef5f98f6d82706f0478a504&amp;default-tab=result" height="200" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed 480cd39e0ef5f98f6d82706f0478a504" title="CodePen Embed 480cd39e0ef5f98f6d82706f0478a504" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

두 번째 열은 이제 너무 많은 공간을 차지하고 있습니다!
 나중에 다시 살펴 보 겠지만 지금은 flex 항목의 내용이 `flex-grow`, `flex-shrink`및 `flex-basis`가 함께 작동하는 방식에 영향을 미친다는 점을 기억하는 것이 중요합니다.
 .
 

이제`flex-shrink`에 대해 좋습니다.
 속기에서 두 번째 값임을 기억하십시오.
 

```css
.child {
  flex: 0 1 auto; /* flex-shrink = 1 */
}
```

`flex-shrink`는 브라우저에 요소의 최소 크기를 알려줍니다.
 기본값은 `1`로“항상 같은 양의 공간을 차지한다”는 뜻입니다.
 하나!
 이 값을 다음과 같이 `0`으로 설정하면 :
 

```css
.child {
  flex: 0 0 auto;
}
```

… 그런 다음 우리는이 요소가 지금 전혀 줄어들지 않도록 지시합니다.
 같은 크기를 유지하세요, 당신은 요소를 폭파했습니다!
 기본적으로이 CSS가 말하는 내용이며 정확히 수행 할 작업입니다.
 이 속기에서 최종 값을 살펴보면 잠시 후이 속성으로 돌아올 것입니다.
 

`flex-basis`는`flex` 속기에서 기본적으로 추가되는 마지막 값이며 요소가 이상적인 크기를 유지하도록 지시하는 방법입니다.
 기본적으로 `내 높이 또는 너비 사용`을 의미하는 `자동`으로 설정되어 있습니다.
 따라서 부모 요소를`display : flex`로 설정하면…
 

```css
.parent {
  display: flex;
}

.child {
  flex: 0 1 auto;
}
```

기본적으로 브라우저에 표시됩니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 200px;"><iframe id="cp_embed_682e040debc4ae4b12bdb50d14663047" src="//codepen.io/anon/embed/682e040debc4ae4b12bdb50d14663047?height=200&amp;theme-id=1&amp;slug-hash=682e040debc4ae4b12bdb50d14663047&amp;default-tab=result" height="200" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed 682e040debc4ae4b12bdb50d14663047" title="CodePen Embed 682e040debc4ae4b12bdb50d14663047" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

모든 요소가 기본적으로 콘텐츠의 너비 인 것을 알 수 있습니까?
 `auto`는 요소의 이상적인 크기가 콘텐츠에 의해 정의된다는 의미이기 때문입니다.
 모든 요소가 부모의 전체 공간을 차지하게하려면 자식 요소를`width : 100 %`로 설정하거나`flex-basis`를`100 %`로 설정하거나`flex-
 `1`로 성장합니다.
 

말이 돼?
 이상 해요, 허!
 당신이 그것에 대해 생각할 때 그렇습니다.
 이러한 각 속기 값은 다른 값에 영향을 미치므로 이러한 값을 서로 독립적으로 설정하는 것보다 먼저이 속기를 작성하는 것이 좋습니다.
 

좋습니다.
 이렇게 쓸 때 ...
 

```css
.child-three {
  flex: 0 1 1000px;
}
```

여기에서 브라우저에 말하는 것은`flex-basis`를`1000px`로 설정하거나“제발, 제발, 그냥`1000px`의 공간을 차지하십시오.”라고 말하는 것입니다.
 가능하지 않은 경우 요소는 다른 요소에 비례하여 많은 공간을 차지합니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 200px;"><iframe id="cp_embed_efd6a0311719f8458fcb8f3e99bf1f13" src="//codepen.io/anon/embed/efd6a0311719f8458fcb8f3e99bf1f13?height=200&amp;theme-id=1&amp;slug-hash=efd6a0311719f8458fcb8f3e99bf1f13&amp;default-tab=result" height="200" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed efd6a0311719f8458fcb8f3e99bf1f13" title="CodePen Embed efd6a0311719f8458fcb8f3e99bf1f13" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

작은 화면에서는이 세 번째 요소가 실제로 `1000px`가 아님을 알 수 있습니다!
 정말 제안이기 때문입니다.
 우리는 여전히 요소가 다른 요소와 같은 크기로 축소되도록 지시하는`flex-shrink`가 적용되어 있습니다.
 

또한 다른 어린이에게 더 많은 콘텐츠를 추가해도 여기에 영향을 미칩니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_464505f57050c12f294a6269583dd663" src="//codepen.io/anon/embed/464505f57050c12f294a6269583dd663?height=250&amp;theme-id=1&amp;slug-hash=464505f57050c12f294a6269583dd663&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed 464505f57050c12f294a6269583dd663" title="CodePen Embed 464505f57050c12f294a6269583dd663" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이제이 요소가 축소되는 것을 방지하려면 다음과 같이 작성할 수 있습니다.
 

```css
.child-three {
  flex: 0 0 1000px;
}
```

여기서 `flex-shrink`는 두 번째 값이며 0으로 설정하면 "절대 축소하지 마십시오. 바보 야."라고 말합니다.
 그래서 그렇지 않습니다.
 요소는 너비가`1000px`보다 짧아지지 않기 때문에 상위 요소에서 벗어날 수도 있습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 200px;"><iframe id="cp_embed_1a99b3fe9761e6581e3cf9a0e5e02595" src="//codepen.io/anon/embed/1a99b3fe9761e6581e3cf9a0e5e02595?height=200&amp;theme-id=1&amp;slug-hash=1a99b3fe9761e6581e3cf9a0e5e02595&amp;default-tab=result" height="200" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed 1a99b3fe9761e6581e3cf9a0e5e02595" title="CodePen Embed 1a99b3fe9761e6581e3cf9a0e5e02595" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이제 부모 요소에`flex-wrap`을 설정하면이 모든 것이 변경됩니다.
 

```css
.parent {
  display: flex;
  flex-wrap: wrap;
}

.child-three {
  flex: 0 0 1000px;
}
```

다음과 같은 내용이 표시됩니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 300px;"><iframe id="cp_embed_587a4f6710efcb8f0fb403791834df33" src="//codepen.io/anon/embed/587a4f6710efcb8f0fb403791834df33?height=300&amp;theme-id=1&amp;slug-hash=587a4f6710efcb8f0fb403791834df33&amp;default-tab=result" height="300" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed 587a4f6710efcb8f0fb403791834df33" title="CodePen Embed 587a4f6710efcb8f0fb403791834df33" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

기본적으로 플렉스 항목은 한 줄에 맞추려고하지만`flex-wrap : wrap`은이를 완전히 무시하기 때문입니다.
 이제 이러한 플렉스 항목이 같은 공간에 맞지 않으면 새 줄로 분리됩니다.
 

어쨌든 이것은 `유연한`속성이 서로 충돌하는 방식 중 일부에 불과하며 이러한 속성이 내부적으로 어떻게 작동하는지 이해하는 것이 왜 그렇게 가치가 있는가입니다.
 이러한 각 속성은 다른 속성에 영향을 미칠 수 있습니다. 한 속성이 작동하는 방식을 이해하지 못하면 어떤 속성도 작동하는지 전혀 이해하지 못합니다.이 속성을 조사하기 전에 확실히 혼란 스러웠습니다.
 

그러나 요약하면 :
 

- `flex` 속기 사용
 
- 그렇게 할 때 최대, 최소 및 이상적인 크기를 기억하십시오.
 
- 요소의 내용은 이러한 값이 함께 작동하는 방식에도 영향을 줄 수 있습니다.
 