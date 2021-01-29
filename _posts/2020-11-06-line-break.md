---
layout: post
title: "줄 바꿈 verified_user"
author: 'CSS Dev'
thumbnail: undefined
tags: 
---


CSS`line-break` 속성은 특히 중국어, 일본어 또는 한국어 (CJK) 쓰기 시스템에서 기호 및 구두점으로 작업 할 때 새 줄에 텍스트 줄 바꿈 규칙을 얼마나 엄격하게 적용할지 정의합니다.
 현재 에디터 초안에있는 CSS 텍스트 모듈 레벨 3 사양에 포함되어 있습니다.
 

```css
.element {
  line-break: strict;
}
```

### 데모
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 650px;"><iframe id="cp_embed_JjKZpaQ" src="//codepen.io/anon/embed/JjKZpaQ?height=650&amp;theme-id=1&amp;slug-hash=JjKZpaQ&amp;default-tab=result" height="650" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed JjKZpaQ" title="CodePen Embed JjKZpaQ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 통사론
 

```css
line-break: auto | loose | normal | strict | anywhere;
```

- 이니셜 :`auto`
 
- 적용 대상 : 모든 요소
 
- 상 속됨 : 예
 
- 계산 된 값 : 지정된대로
 
- 애니메이션 유형 : 이산
 

### 가치
 

```css
/* Keyword values */
line-break: auto;
line-break: loose;
line-break: normal;
line-break: strict;
line-break: anywhere;

/* Global values */
line-break: inherit;
line-break: initial;
line-break: unset;
```

- `auto` : 브라우저가 줄 바꿈을 구현하는 방법을 결정할 수 있습니다.
 각 브라우저는 줄 길이를 포함한 요인에 따라 기준이 다를 수 있습니다.
 
- `loose` : 줄 바꿈 규칙을 가장 가볍게 적용합니다.
 사양은이 값이 사용될 수있는 예로 우리가 신문에서 볼 수있는 것과 같은 짧은 텍스트 줄을 인용합니다.
 
- `normal` : "가장 일반적인"규칙 집합에 따라 텍스트 줄을 나눕니다.
 (가장 일반적인 규칙 집합이 무엇인지 또는 포함 할 수있는 내용에 대한 정의는 제공되지 않습니다.)
 
- `strict` : 줄 바꿈에 대해 가장 엄격한 규칙 집합을 적용합니다.
 
- `anywhere` :이 값은 소프트 랩 기회를 활성화하여 텍스트가 단어 경계 대신 공백이나 구두점에서 분리되도록합니다.
 단어를 구분하는 데 공백이나 구두점을 사용하지 않는 언어에 적합합니다.
 사양에 따르면 CSS는 소프트 랩 기회를 정의하지 않으며이 값은 줄 바꿈 규칙을 적용하기 위해이를 인식하고 활용합니다.
 사양은 일반적으로 터미널에서 보는 것과 같은 텍스트 래핑 동작을 설명합니다.
 

사양은 또한`anywhere` 값이`break-spaces`로 설정된`white-space` 속성과 함께 사용될 때 행 끝에 보존 된 공백을 다음 행으로 줄 바꿈 할 수 있도록 허용합니다.
 

### 다양한 언어에서의 가치 행동
 

상상할 수 있듯이, 텍스트가 새 줄로 분할되는 방식과 관련하여 언어마다 선호도가 다릅니다.
 모든 언어에서 사용되는 표준화 된 규칙은 없습니다.
 이는 브라우저가 특정 언어에 대한 "올바른"규칙을 파악하고 따르도록합니다.
 그러나 사양은 특정 상황에서 다양한 수준의 `줄 바꿈`엄격 성에서 줄 바꿈이 허용되는지 여부를 결정하기위한 몇 가지 요구 사항을 설명합니다.
 여기에서 설명하겠습니다.
 

### 관련 속성
 