---
layout: post
title: "텍스트 방향
 "
author: 'CSS Dev'
thumbnail: undefined
tags: 
---


CSS의 `text-orientation`속성은 수직 `쓰기 모드`로 작업 할 때 텍스트를 한 줄로 정렬합니다.
 기본적으로 세로 언어가 표시되는 방식을 제어하는 데 도움이되도록 줄을 시계 방향으로 90 ° 회전합니다. `text-combine-upright`가 세로 스크립트의 텍스트 줄 내에서 문자 그룹을 회전하는 것과 비슷하지만
 본문.
 

```css
.element {
  text-orientation: mixed;
  writing-mode: vertical-rl; 
} 

```

양방향 텍스트 (예 : 왼쪽에서 오른쪽 및 오른쪽에서 왼쪽 텍스트가 모두 포함 된 블록)를 처리하려면`unicode-bidi` 속성을 확인하세요.
 `방향`속성과 결합되어 브라우저가 텍스트를 표시하는 방법을 재정의합니다.
 

### 통사론
 

```css
text-orientation: mixed | upright | sideways
```

- 이니셜 :`mixed`
 
- 적용 대상 : 테이블 행 그룹, 행, 열 그룹 및 열을 제외한 모든 요소
 
- 상 속됨 : 예
 
- 백분율 : 해당 사항 없음
 
- 계산 된 값 : 지정된 값
 
- 애니메이션 유형 : 애니메이션 불가
 

### 가치
 

```css
/* Keyword values */
text-orientation: mixed; /* default */
text-orientation: upright;
text-orientation: sideways;
text-orientation: sideways-right;

/* Global values */
text-orientation: inherit;
text-orientation: initial; /* mixed */
text-orientation: unset;
```

- `혼합`: 기본값입니다.
 가로 스크립트의 문자는 시계 방향으로 90 ° 회전합니다.
 수직 스크립트의 문자는 자연스러운 수직 방향으로 표시됩니다.
 
- `upright` : 수평 스크립트의 문자는 일부 글리프를 포함하여 자연스러운 수평 수직 위치로 설정됩니다.
 따라서 세로 쓰기 모드에서 문자가 옆으로 오도록 텍스트 줄을 회전 할 수있는 경우이 값은 문자 자체를 원래 위치로 90 ° 회전합니다.
 이 값은`direction` 속성을`ltr`의 사용 된 값으로 강제 적용합니다. 즉, 모든 문자가 왼쪽에서 오른쪽 쓰기 모드에있는 것처럼 처리됩니다.
 
- `sideways` : 세로 쓰기 모드의 모든 텍스트는 가로 레이아웃 인 것처럼 가로로 표시되지만 전체 라인은 시계 방향으로 90 ° 회전됩니다.
 
- `sideways-right` : 일부 브라우저는이 값을 이전 버전과의 호환성을 위해 유지되는`sideways` 값의 별칭으로 간주합니다.
 

`use-glyph-orientation`은 2015 년 12 월에 키워드 값에서 제거되었습니다. SVG 요소에서 현재 지원이 중단 된 SVG 속성`glyph-orientation-vertical` 및`glyph-orientation-horizontal`을 정의하는 데 사용되었습니다.
 `glyph-orientation-vertical`은 이제`text-orientation`의 별칭입니다.
 

### 브라우저 지원
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 500px;"><iframe id="cp_embed_jOMNqzr" src="//codepen.io/anon/embed/jOMNqzr?height=500&amp;theme-id=1&amp;slug-hash=jOMNqzr&amp;default-tab=result" height="500" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed jOMNqzr" title="CodePen Embed jOMNqzr" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 사양
 verified_user

- CSS 작성 모드 레벨 3 (편집자 초안)
 

### 추가 정보
 verified_user

- 세로 텍스트 방향이 브라우저 간 호환성에 악몽 인 이유는 무엇입니까?
 by Nikhil —`text-orientation`과`writing-mode`에 대한 철저한 설명.
 
- Adi Purdila의 "쓰기 모드"CSS 속성을 사용하여 가로 방향 텍스트를 쉽게 생성 — `텍스트 방향`을 사용하는 것 외에도 다양한 접근 방식을 탐색합니다.
 
- CSS로 세로 텍스트를 만드는 2 가지 방법 by W.S.
 Toh — `쓰기 모드`와 `텍스트 방향`을 사용하는 접근 방식을보다 직접적으로 비교합니다.
 
- Chris Coyier의 텍스트 회전 — `쓰기 모드`또는 `텍스트 방향`대신 `변환`을 사용하는 수직 텍스트 접근 방식입니다.
 

### 관련 속성
 