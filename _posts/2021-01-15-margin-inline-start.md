---
layout: post
title: "마진 인라인 시작"
author: 'CSS Dev'
thumbnail: undefined
tags: MARGIN
---


CSS의`margin-inline-start` 속성은 인라인 방향으로 요소의 바깥 쪽 시작 가장자리를 따라 공간의 양을 정의합니다.
 현재 Working Draft에있는 CSS Logical Properties Level 1 사양에 포함되어 있습니다.

```css
.element {
  margin-inline-start: 25%;
  writing-mode: vertical-lr;
} 

```

인라인 방향의 시작 가장자리는 요소의 `쓰기 모드`, `방향`및 `텍스트 방향`에 의해 결정됩니다.
 따라서 수평 왼쪽에서 오른쪽 컨텍스트에서`margin-inline-start`를 사용할 때 요소의 시작 가장자리가 왼쪽이기 때문에`margin-left`처럼 작동합니다.

그러나 `쓰기 모드`를 수직으로 변경하면 요소가 시계 방향으로 회전하여 시작 가장자리가 위쪽으로 이동합니다.
 결과적으로`margin-inline-start`는`margin-top`처럼 작동합니다.
 기본적으로 시작 가장자리는 흐르는 방향에 상대적입니다.
 이것이 "논리적"속성에 대해 이야기 할 때 의미하는 바입니다.

### 통사론

```css
margin-inline-start: <‘margin-top’>
```

한 속성의 구문이 문서에서 다른 CSS 속성의 구문을 참조하는 것을 보는 것은 다소 이상하지만 실제로는 그게 다입니다.
 기본적으로 말하려는 것은 속성이 다음 구문을 따르는 `margin-top`과 동일한 값을 허용한다는 것입니다.

```css
margin-top: <length> | <percentage> | auto;
```

- 초기 값 :`0`
- 적용 대상 : 내부 테이블 요소, 루비 기본 컨테이너 및 루비 주석 컨테이너를 제외한 모든 요소
- 상 속됨 : 아니요
- 백분율 : 해당 물성에 관해서
- 계산 된 값 : 해당`margin- *`속성과 동일
- 애니메이션 유형 : 계산 된 값 유형별

### 가치

`margin-block-start`는 단일 길이 또는 키워드 값을 허용합니다.

```css
/* Length values */
margin-inline-start: 20px;
margin-inline-start: 2rem;
margin-inline-start: 25%;

/* Keyword values */
margin-inline-start: auto;

/* Global values */
margin-inline-start: inherit;
margin-inline-start: initial;
margin-inline-start: unset;
```

### 데모

다음 데모에서 버튼을 클릭하여 요소의 시작 인라인 가장자리가 `쓰기 모드`로 어떻게 변경되는지 확인합니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 650px;"><iframe id="cp_embed_dypqEqG" src="//codepen.io/anon/embed/dypqEqG?height=650&amp;theme-id=1&amp;slug-hash=dypqEqG&amp;default-tab=css,result" height="650" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed dypqEqG" title="CodePen Embed dypqEqG" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 브라우저 지원

### 추가 읽기

### 관련 속성