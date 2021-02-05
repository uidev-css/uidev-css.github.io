---
layout: post
title: "막다른 골목의"
author: 'CSS Dev'
thumbnail: undefined
tags: 
---


inset-block-end는 요소가 끝 에지에서 블록 방향으로 오프셋되는 길이를 설정하는 논리 CSS 속성이다. 끝점이 다른 논리 속성과 마찬가지로 요소의 방향, 텍스트 방향, 쓰기 모드에 의해 결정된다는 점을 제외하면 바닥임을 선언하는 것과 같다.

속성은 현재 편집기의 초안 상태에 있는 CSS 논리적 속성 및 값 수준 1 규격의 일부입니다. 그것은 그것에 대한 정의와 정보가 지금과 공식적인 추천 사이에서 바뀔 수 있다는 것을 의미합니다.

```css
.element {
  inset-block-end: 50px;
  position: relative; /* Apples to positioned elements */
  writing-mode: vertical-rl; /* Determines the block start direction */
} 

```

따라서 예를 들어 쓰기 모드를 `수평-lr`로 설정하면 `inset-block-end` 속성은 `하단`과 동일하게 작동하고 요소의 오프셋을 하단 가장자리에서 설정합니다. 하단과 기타 물리적 오프셋 속성처럼 동일한 요소에 명시적인 `위치`를 지정해야 효과를 볼 수 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 550px;"><iframe id="cp_embed_qBNBpWY" src="//codepen.io/anon/embed/qBNBpWY?height=550&amp;theme-id=1&amp;slug-hash=qBNBpWY&amp;default-tab=result" height="550" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed qBNBpWY" title="CodePen Embed qBNBpWY" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

그러나 요소의 쓰기 모드를 수직-lr과 같은 것으로 바꾸고 하단 가장자리가 수직 방향으로 회전하여 오른쪽 속성에 가깝다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 550px;"><iframe id="cp_embed_eYzYymW" src="//codepen.io/anon/embed/eYzYymW?height=550&amp;theme-id=1&amp;slug-hash=eYzYymW&amp;default-tab=result" height="550" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed eYzYymW" title="CodePen Embed eYzYymW" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 구문

```css
inset-block-end: <'bottom'>;
```

- 초기값: `자동`
- 적용 대상: 위치 요소
- 상속됨: 아니요
- 백분율: 해당 물리적 속성의 경우
- 계산된 값: 해당하는 `하단` 속성과 동일합니다.
- 애니메이션 유형: 계산된 값 유형별

### 가치

inset-block-end는 길이 값을 사용하며 글로벌 키워드를 지원한다. 기본값은 `자동`입니다.

```css
/* Length values */
inset-block-end: 50px;
inset-block-end: 4em;
inset-block-end: 3.5rem
inset-block-end: 25vh;

/* Percentage values */
inset-block-end: 50%;

/* Keyword values */
inset-block-end: auto; /* initial value */

/* Global values */
inset-block-end: initial
inset-block-end: inherit;
inset-block-end: unset;
```

### 브라우저 지원

### 데모

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 550px;"><iframe id="cp_embed_mdEdxXj" src="//codepen.io/anon/embed/mdEdxXj?height=550&amp;theme-id=1&amp;slug-hash=mdEdxXj&amp;default-tab=result" height="550" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed mdEdxXj" title="CodePen Embed mdEdxXj" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 관련 속성

- 인셋 블록
- inset-block-start
- `속옷`
- inset-continue
- inset-setting-start

### 추가 읽기

- CSS 논리적 속성 및 값 수준 1 규격(편집자 초안)
- MDN 설명서
- 논리적 특성과 가치 이해(매거진 파괴)
- CSS 논리적 속성(Adrian Roselli)
- CSS(Hussein Al Hammad)의 양방향 수평 규칙