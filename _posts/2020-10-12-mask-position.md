---
layout: post
title: "탈의의의"
author: 'CSS Dev'
thumbnail: undefined
tags: 
---


CSS에서 `마스크 위치` 속성은 마스크 위치 영역에 상대적인 마스크 계층 이미지의 초기 위치를 지정합니다. 그것은 배경지식 재산과 같은 역할을 한다.

```css
.element {
  mask-image: url("star.svg");
  mask-position: 20px center;
} 

```

마스킹 기능을 사용하면 요소의 선택된 부분을 숨기면서 표시할 수 있습니다. 다음 데모에서는 마스크 계층 이미지의 위치를 변경할 수 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 1000px;"><iframe id="cp_embed_gOMYgZV" src="//codepen.io/anon/embed/gOMYgZV?height=1000&amp;theme-id=1&amp;slug-hash=gOMYgZV&amp;default-tab=result" height="1000" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed gOMYgZV" title="CodePen Embed gOMYgZV" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 구문

```css
mask-position: <position> = [ [ left | center | right ] || [ top | center | bottom ] | [ left | center | right | <length-percentage> ] [ top | center | bottom | <length-percentage> ]? | [ [ left | right ] <length-percentage> ] && [ [ top | bottom ] <length-percentage> ] ]
```

- 초기값: `0% 0%`
- 모든 요소에 적용됩니다. SVG에서는 ➡defs 요소, 모든 그래픽 요소 및 ➡use 요소를 제외한 컨테이너 요소에 적용됩니다.
- 상속됨: 아니요
- 계산된 값: 원점을 나타내는 두 개의 키워드 및 해당 원점에서 나온 두 개의 오프셋으로 구성되며, 각 키워드는 절대 길이(<길이>가 주어지면)로 지정되며, 그렇지 않으면 백분율로 지정됩니다.
- 애니메이션 유형: 반복 가능한 목록

### 가치

【위치】는 CSS의 배경 위치 속성과 유사한 요소 가장자리의 간격띄우기 키워드(위, 왼쪽, 아래, 오른쪽, 가운데)와 백분율 및 길이 값으로 지정할 수 있다.

```css
/* Offset keywords */
mask-position: top;
mask-position: right;
mask-position: bottom;
mask-position: left;
mask-position: center;
 
/* Length values */
mask-position: 100px 200px;
mask-position: 5rem 20%;
mask-position: 0 10vh;
 
/* Percentage values */
mask-position: 25% 50%;
 
/* Global values */
mask-position: intial;
mask-position: inherit;
mask-position: unset;
```

- <길이>: 마스크 이미지의 가장자리가 요소의 해당 가장자리로부터 얼마나 떨어져 있는지 지정하는 유효한 CSS 길이(예: px, em, rem, %s 등)
- `<백분율>: 마스크 계층 이미지의 위치를 마스크 위치 영역 - 마스크 이미지의 크기를 기준으로 백분율 값으로 지정합니다.
- `top`: 수직 위치의 0%에 해당합니다.
- 오른쪽: 수평 위치의 경우 100%에 해당합니다.
- `하단`: 수직 위치의 경우 100%에 해당합니다.
- `left`: 수평 위치의 0%에 해당합니다.
- `중앙`: 수평 위치가 달리 지정되지 않은 경우 수평 위치의 경우 50%에 해당하며, 수직 위치의 경우 50%에 해당한다.
- `initial`: 0%인 속성의 기본 설정을 적용합니다.
- ➡: 상위 항목의 `마스크 위치` 값을 사용합니다.
- unset: 요소에서 현재 마스크 위치를 제거합니다.

이 속성은 쉼표로 구분된 마스크 위치 값 목록을 사용할 수 있으며 각 값은 `마스크-이미지` 속성에 지정된 해당 마스크 계층 이미지에 적용됩니다. 다음 예에서는 첫 번째 값이 첫 번째 이미지의 위치를 지정하고, 두 번째 값이 두 번째 이미지의 위치를 지정하는 등의 작업을 수행합니다.

```css
.element {
  mask-image: url("image-1.png"), url("image-2.png"), url("image-3.png");
  mask-position: 100px 10%, 0 right, center;
}
```

`마스크 위치`는 하나, 둘, 셋 또는 넷 값을 사용하여 마스크 레이어의 위치를 수평 및 수직으로 지정할 수 있다.

단일 값이 설정된 경우, 수평 값으로 간주하고 수직 값은 `중앙`으로 가정한다.

```css
mask-position: 100px; /* 100px center */
```

쌍 값을 사용하는 경우 첫 번째 값을 수평 값으로 사용하고 두 번째 값을 사용하여 도면층의 위치를 수직으로 지정합니다.

```css
mask-position: 10% 50%; /* x=10%, Y=50% */
```

두 값이 모두 키워드인 경우 키워드 순서는 관련이 없습니다.

```css
mask-position: top left; /* = left top */
```

그러나 키워드와 길이 또는 백분율을 조합하면 순서가 중요하며 첫 번째 값은 항상 수평 오프셋에 해당합니다. 따라서:

```css
mask-position: 50% right; /* = horizontal center, vertical right */
mask-position: right 50%; /* = horizontal right, vertical center */
```

세 개의 값이 주어진 경우 결측 오프셋은 0으로 가정됩니다.

```css
mask-position: left 100px bottom; /* left=100px bottom=0 */
```

4-값 구문을 사용하면 마스크의 위치를 상대적으로 지정할 요소(값 1 및 3)와 이러한 측면에서 떨어진 거리(값 2 및 4)를 지정할 수 있습니다.

따라서 요소 하단에서 100px, 오른쪽에서 200px의 마스크를 배치하려면 다음과 같이 할 수 있습니다.

```css
mask-position: bottom 100px right 200px;
```

### 애니메이션 마스크

키프레임 애니메이션과 CSS 전환을 사용하여 다음과 같이 마스크 위치와 `마스크 크기`를 애니메이션화할 수 있습니다.

```css
.element {
  mask-image: url("mask.png");
  mask-position: 10px 10px;
  transition: mask-position 1s ease-in-out;
}
 
.element:hover {
  mask-position: right 10px bottom 10px;
}
```

다음 데모에서는 키프레임 애니메이션을 사용하여 마스크 계층의 애니메이션 위치를 보여줍니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 600px;"><iframe id="cp_embed_wvWwgxv" src="//codepen.io/anon/embed/wvWwgxv?height=600&amp;theme-id=1&amp;slug-hash=wvWwgxv&amp;default-tab=result" height="600" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed wvWwgxv" title="CodePen Embed wvWwgxv" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 데모

다음 데모에서 `마스크 위치` 값을 변경합니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 650px;"><iframe id="cp_embed_BazBpGa" src="//codepen.io/anon/embed/BazBpGa?height=650&amp;theme-id=1&amp;slug-hash=BazBpGa&amp;default-tab=result" height="650" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed BazBpGa" title="CodePen Embed BazBpGa" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 브라우저 지원

### 관련 속성

- `가면 이미지
- 마스크 크기
- `가면봉`
- `가면봉`
- 마스크형
- 마스크 모드

### 추가 정보

- CSS 마스킹 모듈 레벨 1(편집자 초안)
- CSS의 클리핑 및 마스킹
- 클리핑 대 클리핑 마스킹: 각각 사용 시기
- #185: CSS 마스크 사용(비디오)