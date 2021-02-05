---
layout: post
title: "칼럼 갭"
author: 'CSS Dev'
thumbnail: undefined
tags: 
---


CSS "column-gap" 속성은 CSS Grid, Flexbox 및 CSS Columns 레이아웃의 열 사이에 공간을 설정한다.

![image](https://css-tricks.com/wp-content/uploads/2020/09/column-gap.svg)

### 문맥

이미 `그리드-컬럼-갭`이 있는데 왜 우리가 `컬럼-갭`을 가지고 있는지 궁금하다면, 당신만 그런 것이 아닙니다! 실제로 기둥-갭은 격자-기둥-기둥-기둥-기둥을 사실상 대체한다. "그리드" 접두사를 삭제함으로써, 우리가 CSS 그리드보다 더 많은 상황에서 격차를 통제할 수 있다는 것이 훨씬 더 명확해졌다.

네, 브라우저가 변화를 따라잡기 전까지 가장 광범위한 브라우저 지원을 위해 두 가지 모두 선언해야 하기 때문에 이미 그리드-컬럼-갭(grid-column-gap)으로 작업했다면 좀 골치 아픈 일입니다. 따라서 칼럼 갭을 지원하는 브라우저와 지원하지 않는 브라우저가 이를 건너뛰고 그리드 칼럼 갭을 사용하는 미래형 구현은 이런 식으로 보일 수 있다.

```css
.something {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  grid-column-gap: 25px;
  column-gap: 25px;
} 
 

```

### 구문

```css
column-gap: normal | <length-percentage>
```

- 초기값: `정상`
- 적용 대상: 다중 열 컨테이너, 플렉스 컨테이너, 그리드 컨테이너
- 상속됨: 아니요
- 백분율: 내용 영역의 해당 차원 참조
- 계산 값: 지정된 키워드, 계산 `<길이 백분율>` 값
- 애니메이션 유형: 계산된 값 유형별

이 공식 구문은 기본적으로 `열 간격`이 `정상` 값(기본값) 또는 단위(예: 25px 또는 1.25em) 또는 백분율(예: 10%)로 지정된 길이 값을 허용한다고 말한다.

### 가치

행 갭은 정상 값과는 별도로 숫자와 백분율을 받아들인다. "Normal"은 브라우저의 표준적인 것을 의미합니다.

```css
/* Default value */
column-gap: normal;

/* <length> values */
column-gap: 50px;
column-gap: 2rem;
column-gap: 1.5em;
column-gap: 5vw;
column-gap: 25ch;

/* <percentage> value */
column-gap: 15%;

/* Global values */
column-gap: inherit;
column-gap: initial;
column-gap: unset;
```

### 데모

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 600px;"><iframe id="cp_embed_mdPvGMz" src="//codepen.io/anon/embed/mdPvGMz?height=600&amp;theme-id=1&amp;slug-hash=mdPvGMz&amp;default-tab=result" height="600" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed mdPvGMz" title="CodePen Embed mdPvGMz" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 브라우저 지원

브라우저 지원은 CSS Grid 또는 Flexbox에서 `row-gap`을 지원하는지 여부에 따라 분할할 수 있습니다.

### 관련 속성

- 갭
- 줄 갭
- `그리드 갭`
- 격자-기둥-갭
- 격자선 격차

### 추가 읽기

- CSS 박스 정렬 모듈 레벨 3(사양, 편집기 초안)
- 크롬 및 플렉스 박스 갭(CSS-Tricks)
- CSS 레이아웃에 대한 Horizon의 흥미로운 내용(CSS {In Real Life})