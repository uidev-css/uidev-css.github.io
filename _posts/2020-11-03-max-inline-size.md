---
layout: post
title: "최대 인라인 크기"
author: 'CSS Dev'
thumbnail: undefined
tags: 
---


`max-inline-size`는`writing-mode`가 수 평일 때 요소의 최대 너비를 정의하고`writing-mode`가 수직 일 때 요소의 최대 높이를 정의하는 CSS의 논리적 속성입니다.
 

```css
.element {
  max-inline-size: 500px;
  writing-mode: vertical-lr;
} 

```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 600px;"><iframe id="cp_embed_JjKLMKB" src="//codepen.io/anon/embed/JjKLMKB?height=600&amp;theme-id=1&amp;slug-hash=JjKLMKB&amp;default-tab=result" height="600" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed JjKLMKB" title="CodePen Embed JjKLMKB" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

위의 예에서 짐작할 수 있듯이`writing-mode` 속성은 텍스트 및 레이아웃 흐름의 방향을 90도 변경합니다.
 

멋진 디자인을 만드는 것 외에도 방향을 변경하는 주된 이유는 사이트에서 국제화를 수용하기 위해서입니다.
 중국어, 일본어 및 한국어와 같은 많은 동아시아 문자는 가로 또는 세로로 쓸 수 있습니다.
 논리적 속성을 사용하여 사용자의 쓰기 모드에 따라 요소의 올바른 크기 조정 방향을 제공 할 수 있습니다.
 

Jen Simmons에는 CSS 작성 모드에 대해 자세히 설명하는 기사와 프레젠테이션이 있습니다.
 

### `max-width` 속성 만 사용할 수는 없나요?
 

예!
 하지만 Internet Explorer를 지원하지 않는 경우 대신 `max-inline-size`를 사용하지 않을 이유가 없습니다.
 `최대 너비`는 물리적 크기이므로 쓰기 모드가 변경되면 요소가 가로 너비 크기를 유지하여 세로로 설정하면 레이아웃이 깨집니다.
 `max-inline-size`와 같은 논리적 속성은 이러한 변경에 응답하고 적절한 방향으로 크기를 적용 할 수 있습니다.
 

### 통사론
 

```css
max-inline-size: <'width'>;
```

- 이니셜 :`auto`
 
- 적용 대상 :`height` 및`width`와 동일
 
- 상 속됨 : 아니요
 
- 백분율 : 해당 물성에 관해서
 
- 계산 된 값 :`height` 및`width`와 동일
 
- 애니메이션 유형 : 계산 된 값 유형별
 

### 가치
 

```css
/* Length values */
max-inline-size: 250px;
max-inline-size: 5rem;
 
/* Percentage values */
max-inline-size: 75%;
 
/* Keyword values */
max-inline-size: auto;
max-inline-size: fit-content(5rem);
max-inline-size: max-content;
max-inline-size: min-content;
 
/* Global values */
max-inline-size: inherit;
max-inline-size: initial;
max-inline-size: unset;
```

### 데모
 

`쓰기 모드`가 `vertical-rl`로 설정되면 콘텐츠가 회전하여 레이아웃이 변경됩니다.
 `최대 너비`상자의 너비는 콘텐츠와 함께 회전합니다.
 하지만`max-inline-size`는 똑똑합니다!
 `쓰기 모드`값에 관계없이 너비를 그대로 유지합니다.
 다음 데모에서 `쓰기 모드`를 전환하여 둘의 차이점을 확인하십시오.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 650px;"><iframe id="cp_embed_KKMoZaa" src="//codepen.io/anon/embed/KKMoZaa?height=650&amp;theme-id=1&amp;slug-hash=KKMoZaa&amp;default-tab=result" height="650" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed KKMoZaa" title="CodePen Embed KKMoZaa" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 브라우저 지원
 

다음 기능 사용에 대한 지원은 속성 지원과 다를 수 있습니다.
 

- `fit-content ()`
 
- `max-content ()`
 
- `min-content ()`
 

### 추가 정보
 verified_user

### 관련 속성
 