---
layout: post
title: "형체를 갖추다"
author: 'CSS Dev'
thumbnail: undefined
tags: 
---


CSS `shape-margin` 속성은 `shape-outside` 속성으로 생성된 CSS 도형에 여백을 추가합니다.

CSS 셰이프와 주변 콘텐츠 사이의 거리를 변경한다는 점에서 쉐이프 이미지 임계값과 비슷한 역할을 하지만, 이름에 참된 쉐이프 마진은 CSS 셰이프의 플로트 영역과 그 주변에 떠 있는 콘텐츠 사이의 공간을 정의한다.

![image](https://css-tricks.com/wp-content/uploads/2020/08/shape-margin-illustration.svg)

shape-outside는 단독으로 사용하지 않고 shape-outside와 함께 작동하여 부동 면적을 설정하는 정의된 CSS 모양에 여백을 추가한다.

### 구문

```html
shape-margin: <length> | <percentage>
```

- 초기값: `0`
- 적용 대상: 부동액
- 상속됨: 아니요
- 애니메이션 유형: 길이, 백분율 또는 계산

### 가치

shape-margin 속성은 "calc() 함수를 사용하여 숫자 길이, 백분율 또는 계산된 값을 포함하는 값을 허용합니다.

```css
/* Length values */
shape-margin: 25px;
shape-margin: 2.5em;

/* Percentage values */
shape-margin: 25%;

/* Calculated values */
shape-margin: calc(100% - 2vw);

/* Global values */
shape-margin: inherit;
shape-margin: initial;
shape-margin: unset;
```

백분율 값은 속성을 선언하는 요소를 포함하는 요소의 너비를 나타냅니다.

### 데모

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 800px;"><iframe id="cp_embed_KKzmxxJ" src="//codepen.io/anon/embed/KKzmxxJ?height=800&amp;theme-id=1&amp;slug-hash=KKzmxxJ&amp;default-tab=result" height="800" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed KKzmxxJ" title="CodePen Embed KKzmxxJ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 브라우저 지원

## 관련 속성

- 형체 변형
- `모양상`