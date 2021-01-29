---
layout: post
title: "텍스트 결합 수직"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/11/richter-albertinum.jpg
tags: 
---


`text-combine-upright` CSS 속성은 문자를 한 문자의 공간으로 결합합니다.
 사양에서는이를 "수평-수직"구성이라고 부르는데, 이는 사용 사례를 설명하는 좋은 방법입니다. 같은 줄에 수평으로 표시하기 위해 수직 쓰기 모드에서 일부 문자가 필요할 수있는 상황입니다.
 

```css
span {
  text-combine-upright: all;
}
```

세로 텍스트 내의 가로 텍스트 기술은 일본식 tate-chū-yoko입니다.
 그 모습은 다음과 같습니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/11/text-combine-upright-ex.png?resize=889%2C597&ssl=1)

### 통사론
 

```css
text-combine-upright: none | all | [ digits <integer>? ]
```

- 초기 값 :`none`
 
- 적용 대상 : 대체되지 않은 인라인 요소
 
- 상 속됨 : 예
 
- 백분율 : 해당 사항 없음
 
- 계산 된 값 : 지정된 키워드, `숫자`인 경우 정수 더하기
 
- 애니메이션 유형 : 애니메이션 불가
 

### 가치
 

`text-combine-upright`는 다음 값을 허용합니다.
 

- `none` : 초기 값입니다.
 세로 쓰기 모드에서는 문자가 가로로 표시되지 않습니다.
 
- `all` : 세로 포함 상자에 연속 된 모든 활자체 문자가 동일한 줄에 가로로 표시되며 세로 상자에서 단일 문자의 공간을 차지합니다.
 
- `digits <integer>?`: 세로 포함 상자의 모든 연속 ASCII 숫자가 동일한 행에 가로로 표시되며 세로 상자의 단일 문자 공간을 지정된 정수까지 차지합니다.
 특정 정수가없는 경우 기본값은 2 자리입니다.
 2 미만 및 4 이상은 유효하지 않습니다.
 

```css
/* Keyword values */
text-combine-upright: none;
text-combine-upright: all;

/* Digits values */
text-combine-upright: digits; /* 2 digits */
text-combine-upright: digits 4; /* 4 digits */

/* Global values */
text-combine-upright: inherit;
text-combine-upright: initial;
text-combine-upright: unset;
```

### 용법
 

세로 쓰기 모드의`<date>`요소 인 사양에서 바로 나온 예를 들어 보겠습니다.
 

```html
<date>平成20年4月16日に</date>
```

```css
date {
  writing-mode: vertical-lr;
}
```

좋습니다. 날짜의 숫자가 가로로 표시되기를 원합니다.
 요소에 직접`text-combine-upright`를 추가하는 것이 트릭을 수행한다고 가정하는 것이 논리적입니다.
 

```css
date {
  text-combine-upright: digits 2; /* 👎 */
  writing-mode: vertical-lr;
}
```

Buuuuut,별로.
 글을 쓰는 시점에서 이것이 작동하려면 숫자 자체에 속성을 적용해야합니다.
 스팬이 할 것입니다.
 

```html
<date>平成<span>20</span>年<span>4</span>月<span>16</span>日に</date>
```

```css
date {
  writing-mode: vertical-lr;
}

span {
  text-combine-upright: digits 2;
}
```

우리는 거기에 갈!
 verified_user

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 425px;"><iframe id="cp_embed_ExyByrP" src="//codepen.io/anon/embed/ExyByrP?height=425&amp;theme-id=1&amp;slug-hash=ExyByrP&amp;default-tab=css,result" height="425" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed ExyByrP" title="CodePen Embed ExyByrP" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 브라우저 지원
 

예에서 방금 보았 듯이 브라우저 지원은 현재 약간 흩어져 있습니다.
 많은 브라우저가`text-combine-upright`에 대한 부분적 지원을 제공하지만`all` 값보다`digits` 값에 대한 지원이 훨씬 적습니다.
 

### 사양
 verified_user

- CSS 작성 모드 레벨 4 (편집자 초안)
 

### 관련 속성
 