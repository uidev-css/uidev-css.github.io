---
layout: post
title: "열-규칙-폭"
author: 'CSS Dev'
thumbnail: undefined
tags: 
---


column-rule-width CSS 속성은 CSS 다중 열 레이아웃에서 column-rule-style에 의해 열 사이에 그려지는 선의 두께를 설정합니다.

```css
.columns {
  columns: 2 600px;
  column-rule-style: dotted;
  column-rule-width: 3px;
} 

```

칼럼-룰 폭과 칼럼-룰 스타일, 칼럼-룰 색상 등을 결합한 칼럼-룰 속기 속성을 활용하는 것도 한 방법이다.

```css
.columns {
  columns: 2 600px;
  column-rule: dotted 3px #f8a100;
} 

```

### 구문

```css
column-rule-width: thin | medium | thick | <length>
```

- 초기값: `medium`
- 적용 대상: 다중 열 컨테이너
- 상속됨: 아니요
- 계산된 값: 절대 길이; `열 규칙 유형`이 `없음` 또는 `숨김`인 경우 `0`
- 애니메이션 유형: 계산된 값 유형별

### 가치

열-규칙 너비는 이름, 길이 또는 전역 값을 사용합니다.

```css
/* Named values */
column-rule-width: thin;
column-rule-width: medium;
column-rule-width: thick;

/* Length values */
column-rule-width: 15px;
column-rule-width: 1.5rem;

/* Global values */
column-rule-width: inherit;
column-rule-width: initial;
column-rule-width: unset;
```

### 데모

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 650px;"><iframe id="cp_embed_XWdLEOB" src="//codepen.io/anon/embed/XWdLEOB?height=650&amp;theme-id=1&amp;slug-hash=XWdLEOB&amp;default-tab=result" height="650" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed XWdLEOB" title="CodePen Embed XWdLEOB" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 브라우저 지원

### 관련 속성

- 열 개수
- `기둥 채우기`
- 칼럼 갭
- `칼럼
- `기둥-규칙-색`
- `칼럼-규칙 방식`
- `기둥-스팬`
- `열 너비`
- ➡➡➡➡➡➡➡➡➡➡ ➡

## 사양

CSS 다중 열 레이아웃 모듈 레벨 1(편집자 초안)