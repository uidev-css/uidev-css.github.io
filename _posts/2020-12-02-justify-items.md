---
layout: post
title: "정당화 항목
 "
author: 'CSS Dev'
thumbnail: undefined
tags: 
---


`justify-items` 속성은 기본적으로 범위 내에서 그리드 항목의 정렬을 제어하는 CSS 상자 정렬 모듈의 하위 속성입니다.
 

```css
.element {
  justify-items: center;
}
```

`justify-items`는 행 (인라인) 축을 따라 그리드 항목을 정렬합니다.
 특히,이 속성을 사용하면 특정 위치 (예 :`start`,`center` 및`end`) 또는 동작 (예 :`auto` 또는`
 늘이기`).
 

`justify-items`를 사용하면 모든 그리드 항목에 대한 기본`justify-self` 값도 설정하지만 자식 자체의`justify-self` 속성을 사용하여 자식 수준에서 재정의 할 수 있습니다.
 

```css
.grid {
  display: grid;
  justify-items: center;
}

.grid-item {
  justify-self: start;
}
```

### 통사론
 

```css
justify-items: normal | stretch | <baseline-position> | <overflow-position>? [ <self-position> | left | right ] | legacy | legacy && [ left | right | center ]
```

- 초기 값 :`legacy`
 
- 적용 대상 : 모든 요소
 
- 상 속됨 : 아니요
 
- 계산 된 값 : 지정된대로
 
- 애니메이션 유형 : 이산
 

### 가치
 

```css
/* Basic keyword values */
justify-items: auto;
justify-items: normal;
justify-items: stretch;

/* Baseline alignment */
justify-items: baseline;
justify-items: first baseline;
justify-items: last baseline;

/* Positional alignment */
justify-items: center;
justify-items: start;
justify-items: end;
justify-items: flex-start;
justify-items: flex-end;
justify-items: self-start;
justify-items: self-end;
justify-items: left;
justify-items: right;

/* Overflow alignment */
/* Used as an optional second value for positional alignment */
justify-items: safe;
justify-items: unsafe;

/* Legacy */
justify-items: legacy center;
justify-items: legacy left;
justify-items: legacy right;

/* Global values */
justify-items: inherit;
justify-items: initial;
justify-items: unset;
```

- `stretch` : 기본값입니다.
 그리드 항목 셀의 전체 너비를 채우도록 항목을 정렬합니다.
 
- `auto` : 상위 항목의`justify-items` 값과 동일합니다.
 
- `normal` : 그리드 레이아웃에서 가장 자주 사용되는`justify-items`를 볼 수 있지만, 기술적으로는 모든 상자 정렬을위한 것이며`normal`은 다음을 포함하여 다른 레이아웃 컨텍스트에서 다른 것을 의미합니다.
블록 수준 레이아웃 (`start`)
그리드 레이아웃`stretch`
flexbox (무시 됨)
표 셀 (무시 됨)
절대 위치 레이아웃 (`start`)
절대 위치에있는 상자 (`stretch`)
절대 위치에있는 상자 교체 (`시작`)
 
- 블록 수준 레이아웃 (`start`)
 
- 그리드 레이아웃`stretch`
 
- flexbox (무시 됨)
 
- 표 셀 (무시 됨)
 
- 절대 위치 레이아웃 (`start`)
 
- 절대 위치에있는 상자 (`stretch`)
 
- 절대 위치에있는 상자 교체 (`시작`)
 

```css
.container {
  justify-items: stretch;
}
```

![image](https://css-tricks.com/wp-content/uploads/2018/11/justify-items-stretch.svg)

이렇게하면 상자의 첫 번째 또는 마지막 기준선 세트의 정렬 기준선이 해당 정렬 컨텍스트의 해당 기준선에 맞춰 정렬됩니다.
 

```css
.container {
  justify-items: <first | last> baseline;
}
```

- `첫 번째 기준선`에 대한 대체 정렬은 `안전한 시작`입니다.
 
- `마지막 기준선`에 대한 대체 정렬은 `안전한 끝`입니다.
 
- `기준선`은 단독으로 사용될 때 `첫 번째 기준선`에 해당합니다.
 

아래 데모 (Firefox에서 가장 잘 볼 수 있음)에서 요소가 기본 축을 기준으로 그리드의 기준선에 정렬되는 방식을 볼 수 있습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 350px;"><iframe id="cp_embed_ZEpGQqm" src="//codepen.io/anon/embed/ZEpGQqm?height=350&amp;theme-id=1&amp;slug-hash=ZEpGQqm&amp;default-tab=result" height="350" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed ZEpGQqm" title="CodePen Embed ZEpGQqm" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

- `start` : 정렬 컨테이너의 시작 가장자리에 항목을 정렬합니다.
 
- `end` : 항목을 끝 가장자리 정렬 컨테이너에 정렬합니다.
 
- `center` : 정렬 컨테이너의 중앙에 항목을 정렬합니다.
 
- `left` : 정렬 컨테이너의 왼쪽에있는 항목을 정렬합니다.
 
- `right` : 정렬 컨테이너의 오른쪽에 항목을 정렬합니다.
 
- `self-start` : 각 그리드 항목 셀의 시작 부분에 항목을 정렬합니다.
 
- `self-end` : 각 그리드 항목 셀의 끝에 항목을 정렬합니다.
 

```css
.container {
  justify-items: <start | left | self-start>
}
```

![image](https://css-tricks.com/wp-content/uploads/2018/11/justify-items-start.svg)

```css
.container {
  justify-items: <end | right | self-end>
}
```

![image](https://css-tricks.com/wp-content/uploads/2018/11/justify-items-end.svg)

```css
.container {
  justify-items: center;
}
```

![image](https://css-tricks.com/wp-content/uploads/2018/11/justify-items-center.svg)

오버플로 속성은 콘텐츠가 그리드의 경계 제한을 초과 할 때 그리드의 콘텐츠를 표시하는 방법을 결정합니다.
 따라서 내용이 정렬 컨테이너보다 크면 오버플로가 발생하여 데이터 손실이 발생할 수 있습니다.
 이를 방지하기 위해 데이터 손실이 없도록 브라우저에 정렬을 변경하도록 지시하는 `safe`값을 사용할 수 있습니다.
 

- `안전한 <왼쪽 |
 오른쪽 |
 center>`: 항목이 정렬 컨테이너를 오버플로하면 `시작`모드가 사용됩니다.
 
- `안전하지 않은 <왼쪽 |
 오른쪽 |
 center>`: 항목 크기 또는 정렬 컨테이너에 관계없이 정렬 값이 그대로 유지됩니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 550px;"><iframe id="cp_embed_BazgZOx" src="//codepen.io/anon/embed/BazgZOx?height=550&amp;theme-id=1&amp;slug-hash=BazgZOx&amp;default-tab=result" height="550" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed BazgZOx" title="CodePen Embed BazgZOx" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

- `레거시 <오른쪽 |
 왼쪽 |
 center>`: 방향성 키워드 (예 :`right`,`left` 또는`center`)와 함께 사용하면 해당 키워드가 상속을 위해 자손에게 전달됩니다.
 그러나 자손이`justify-self : auto;`를 선언하면`legacy`는 무시되지만 여전히 방향 키워드를 존중합니다.
 방향성 키워드가 제공되지 않으면 값은 상속 된 값으로 계산됩니다.
 그렇지 않으면 `보통`으로 계산됩니다.
 

### 데모
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 650px;"><iframe id="cp_embed_yLJZPWb" src="//codepen.io/anon/embed/yLJZPWb?height=650&amp;theme-id=1&amp;slug-hash=yLJZPWb&amp;default-tab=result" height="650" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed yLJZPWb" title="CodePen Embed yLJZPWb" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 추가 정보
 verified_user

- CSS 상자 정렬 모듈 레벨 3 (작업 초안)
 
- 그리드에 대한 완벽한 가이드
 
- Flexbox에 대한 완벽한 가이드
 

### 브라우저 지원
 

브라우저 지원`justify-items`는 그리드, 플렉스 박스, 테이블 셀과 같은 여러 레이아웃 컨텍스트에서 사용되기 때문에 영역을 실행합니다.
 그러나 일반적으로 그리드와 플렉스 박스가 지원된다면`justify-items`도 있다고 가정 할 수 있습니다.
 

### 관련 속성
 