---
layout: post
title: "기둥-규칙-색"
author: 'CSS Dev'
thumbnail: undefined
tags: 
---


`column-rule-color` CSS 속성은 CSS 다중 열 레이아웃에서 열 사이의 선의 색상을 결정합니다.

숙박업소는 단독으로 작동할 수 없습니다! 색상을 보려면 열 사이에 줄(기술적으로 "규칙"이라고 함)을 만들어야 합니다. 이를 위해서는 `column-rule-style` 속성이 필요합니다.

```css
.columns {
  column-count: 2 600px;
  column-rule-style: solid;
  column-rule-color: #f8a100;
} 

```

또는 칼럼-규칙 색상, 칼럼-규칙 스타일, 칼럼-규칙-폭을 하나의 선언에 결합한 칼럼-규칙 속기 속성을 사용할 수 있다.

```css
column-rule: 3px solid #f8a100;
```

### 구문

열-규칙-색상은 단일 색상 값을 사용합니다. 16진수, RGB, RGBa, HSL, HSLa 및 명명된 색상을 포함한 모든 유효한 CSS 색상이 될 수 있습니다. 현재 색상까지 값으로 받아들인다.

```css
column-rule-color: #f8a100;
column-rule-color: hsl(39,100,49);
column-rule-color: rgb(250,162,0);
column-rule-color: aliceblue;
column-rule-color: currentColor;
```

### 데모

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 500px;"><iframe id="cp_embed_rNeEdyY" src="//codepen.io/anon/embed/rNeEdyY?height=500&amp;theme-id=1&amp;slug-hash=rNeEdyY&amp;default-tab=result" height="500" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed rNeEdyY" title="CodePen Embed rNeEdyY" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 브라우저 지원

### 관련 속성

- 열 개수
- `기둥 채우기`
- 칼럼 갭
- `칼럼
- `칼럼-규칙 방식`
- `열-규칙 너비`
- `기둥-스팬`
- `열 너비`
- ➡➡➡➡➡➡➡➡➡➡ ➡

## 사양

CSS 다중 열 레이아웃 모듈 레벨 1(편집자 초안)