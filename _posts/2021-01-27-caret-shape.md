---
layout: post
title: "캐럿 모양
 "
author: 'CSS Dev'
thumbnail: undefined
tags: 
---


CSS의`caret-shape` 속성은 사용자가 입력하고 있음을 나타내는 편집 가능한 요소 내부의 텍스트 커서 모양을 변경합니다.
 현재 작업 초안 상태 인 CSS 기본 사용자 인터페이스 모듈 레벨 4의 일부입니다.
 

내가 글을 쓸 때 캐럿은 내가 입력하는 각 문자를 따르는 작은 깜박이는 막대입니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/blinking-caet.gif?resize=392%2C86&ssl=1)

`캐럿 모양`을 사용하여 막대를 블록과 같은 다른 것으로 변경할 수 있습니다.
 

```css
.element {
  caret-shape: block;
}
```

그러면 명령 줄에 입력 할 때 볼 수있는 것과 같은 캐럿이 생성됩니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2021/01/caret-block.gif?resize=308%2C51&ssl=1)

### 통사론
 

```css
caret-shape: auto | bar | block | underscore
```

- 초기 값 :`auto`
 
- 적용 대상 : 입력을받는 요소
 
- 상 속됨 : 예
 
- 백분율 : 해당 사항 없음
 
- 계산 된 값 : 지정된 키워드
 
- 애니메이션 유형 : 계산 된 값 기준
 

### 가치
 

```css
caret-shape: auto;
caret-shape: bar;
caret-shape: block;
caret-shape: underscore;
```

현재 `캐럿 모양`에 대한 브라우저 지원은 많지 않지만 (아래 참조) 다음은 이러한 값의 렌더링입니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2021/01/caret-bar.gif?resize=364%2C60&ssl=1)

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2021/01/caret-block.gif?resize=308%2C51&ssl=1)

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/caret-shape-underscore.gif?resize=437%2C51&ssl=1)

### 브라우저 지원
 

Caniuse에서 사용할 수있는 데이터가없는 것 같지만 몇 가지 빠른 테스트를 통해 다음과 같은 결과를 찾았습니다.
 

### 우리는 이것을 "가짜"수 있습니다
 

브라우저 지원은 그대로이지만 다른 CSS 마법으로 효과를 실제로 복제 할 수 있습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_YzGoBGq" src="//codepen.io/anon/embed/YzGoBGq?height=450&amp;theme-id=1&amp;slug-hash=YzGoBGq&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed YzGoBGq" title="CodePen Embed YzGoBGq" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이것이 바로이 타자기 애니메이션에서 사용되는 종류입니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_jrWwWM" src="//codepen.io/anon/embed/jrWwWM?height=250&amp;theme-id=1&amp;slug-hash=jrWwWM&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed jrWwWM" title="CodePen Embed jrWwWM" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 추가 정보
 verified_user

- CSS 기본 사용자 인터페이스 모듈 레벨 4 (작업 초안)
 

### 관련 속성
 