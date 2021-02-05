---
layout: post
title: "망가지지 않은"
author: 'CSS Dev'
thumbnail: undefined
tags: 
---


inset-inline-end는 요소가 시작 인라인 방향으로 오프셋되는 길이를 설정하는 CSS 속성이다. 다른 논리 속성과 마찬가지로 요소의 방향, 텍스트 방향, 쓰기 모드에 따라 시작점과 끝점이 변경될 수 있다는 점을 제외하면, 위치 요소에 적용되고 왼쪽 방향으로 요소가 상쇄된다는 점에서 `오른쪽`을 선언하는 것과 같다.

속성은 현재 편집기의 초안 상태에 있는 CSS 논리적 속성 및 값 수준 1 규격의 일부입니다. 그것은 그것에 대한 정의와 정보가 지금과 공식적인 추천 사이에서 바뀔 수 있다는 것을 의미합니다.

```css
.element {
  inset-inline-end: 50px;
  position: relative; /* Apples to positioned elements */
  writing-mode: vertical-rl; /* Determines the block start direction */
} 

```

따라서 예를 들어 쓰기 모드를 `수평-lr`로 설정하면 `inset-inline-end` 속성은 `left`를 설정하는 것과 똑같이 작동하여 왼쪽 가장자리에서 요소를 오프셋합니다. 물리적 오프셋 속성과 마찬가지로 동일한 요소에 명시적인 `위치`를 지정해야 적용할 수 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 550px;"><iframe id="cp_embed_KKMKRZm" src="//codepen.io/anon/embed/KKMKRZm?height=550&amp;theme-id=1&amp;slug-hash=KKMKRZm&amp;default-tab=result" height="550" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed KKMKRZm" title="CodePen Embed KKMKRZm" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

그러나 요소의 쓰기 모드를 수직-lr과 같은 것으로 바꾸면 시작 가장자리가 수직 방향으로 회전하면서 대신 상단과 같은 역할을 한다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 550px;"><iframe id="cp_embed_YzWzLYb" src="//codepen.io/anon/embed/YzWzLYb?height=550&amp;theme-id=1&amp;slug-hash=YzWzLYb&amp;default-tab=result" height="550" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed YzWzLYb" title="CodePen Embed YzWzLYb" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 구문

```css
inset-inline-end: <'left'>;
```

- 초기값: `자동`
- 적용 대상: 위치 요소
- 상속됨: 아니요
- 백분율: 해당 물리적 속성의 경우
- 계산된 값: 해당하는 `left` 속성과 동일합니다.
- 애니메이션 유형: 계산된 값 유형별

### 가치

inset-block은 길이 값을 가지며 글로벌 키워드를 지원한다. 기본값은 `자동`입니다.

```css
/* Length values */
inset-inline-end: 50px;
inset-inline-end: 4em;
inset-inline-end: 3.5rem
inset-inline-end: 25vh;

/* Percentage values */
inset-inline-end: 50%;

/* Keyword values */
inset-inline-end: auto; /* initial value */

/* Global values */
inset-inline-end: initial
inset-inline-end: inherit;
inset-inline-end: unset;
```

### 브라우저 지원

### 데모

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 550px;"><iframe id="cp_embed_yLJLjvo" src="//codepen.io/anon/embed/yLJLjvo?height=550&amp;theme-id=1&amp;slug-hash=yLJLjvo&amp;default-tab=result" height="550" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed yLJLjvo" title="CodePen Embed yLJLjvo" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 관련 속성

- 인셋 블록
- inset-block-end
- inset-block-start
- `속옷`
- inset-setting-start

## 추가 읽기

- CSS 논리적 속성 및 값 수준 1 규격(편집자 초안)
- MDN 설명서
- 논리적 특성과 가치 이해(매거진 파괴)
- CSS 논리적 속성(Adrian Roselli)
- CSS(Hussein Al Hammad)의 양방향 수평 규칙