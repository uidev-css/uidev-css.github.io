---
layout: post
title: "기둥-규칙형"
author: 'CSS Dev'
thumbnail: undefined
tags: 
---


`column-rule-style` CSS 속성은 CSS 다중 열 레이아웃의 열 사이에 그려지는 선의 유형을 지정합니다.

그 재산은 그 자체로 다소 제한되어 있다. 우리가 그것을 선언할 때, 그것은 폭이 1픽셀인 CSS 열과 검은색 사이에 선을 그을 것이다.

```css
.columns {
  columns: 2 600px;
  column-rule-style: solid;
} 

```

칼럼 규칙 스타일과 칼럼 규칙 폭(더 두꺼운 선을 설정하기 위해)과 칼럼 규칙 색상(색상을 바꾸기 위해)을 포함한 다른 칼럼 규칙 속성을 결합하기 시작하면 더 흥미로워진다.

```css
.columns {
  columns: 2 600px;
  column-rule-style: solid;
  column-rule-width: 3px;
  column-rule-color: #f8a100;
} 

```

아니면 세 가지를 모두 하나의 선언에 결합한 `칼럼 룰` 속기 속성을 간단히 사용할 수도 있다.

```css
.columns {
  columns: 2 600px;
  column-rule: solid 3px #f8a100;
} 

```

### 구문

```css
column-rule-style: <'border-style'>;
```

- 초기값: `없음`
- 적용 대상: 다중 열 컨테이너
- 상속됨: 아니요
- 계산된 값: 지정된 키워드
- 애니메이션 유형: 이산형

### 가치

`column-rule-style`은 다음 값을 사용합니다.

```css
/* Keyword values */
column-rule-style: none;
column-rule-style: hidden;
column-rule-style: dotted;
column-rule-style: dashed;
column-rule-style: solid;
column-rule-style: double;
column-rule-style: groove;
column-rule-style: ridge;
column-rule-style: inset;
column-rule-style: outset;

/* Global values */
column-rule-style: inherit;
column-rule-style: initial;
column-rule-style: unset;
```

### 데모

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 750px;"><iframe id="cp_embed_xxVoWYa" src="//codepen.io/anon/embed/xxVoWYa?height=750&amp;theme-id=1&amp;slug-hash=xxVoWYa&amp;default-tab=result" height="750" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed xxVoWYa" title="CodePen Embed xxVoWYa" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 브라우저 지원

### 관련 속성

- 열 개수
- `기둥 채우기`
- 칼럼 갭
- `칼럼
- `기둥-규칙-색`
- `열-규칙 너비`
- `기둥-스팬`
- `열 너비`
- ➡➡➡➡➡➡➡➡➡➡ ➡

## 사양

CSS 다중 열 레이아웃 모듈 레벨 1(편집자 초안)