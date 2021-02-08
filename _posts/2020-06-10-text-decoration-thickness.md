---
layout: post
title: "문자 장식의"
author: "Uidev Css"
thumbnail: "undefined"
tags: 
---


CSS의 텍스트 데코레이션 두께 속성은 요소의 텍스트에 사용되는 데코레이션 라인의 스트로크 두께를 설정합니다. 텍스트-데코레이션-라인 값은 두께 속성을 반영하기 위해 밑줄, 줄줄 또는 밑줄로 되어야 한다.

```css
.text {
  text-decoration-line: underline;
  text-decoration-thickness: 2px;
} 

```

### 구문

```css
auto | from-font | <length> | <percentage>
```

### 가치

- `자동`: (기본값) 브라우저가 텍스트 장식 줄에 적합한 두께를 지정할 수 있습니다.
- `from-font`: 사용 가능한 첫 번째 글꼴에 기본 두께를 지정하는 메트릭이 있는 경우 해당 두께를 사용하고, 그렇지 않으면 자동 값처럼 작동합니다.
- `<길이>: 단위가 있는 유효한 길이는 텍스트 장식 선의 두께를 고정 길이로 지정합니다. 그러면 글꼴 및 브라우저 기본값에 있는 모든 정보가 바뀝니다.
- `백분율`: 요소 글꼴에서 텍스트 장식 선의 두께를 1em의 백분율로 지정합니다.
- `초기`: 속성의 기본 설정(자동)입니다.
- ➡: 상위 항목의 장식 두께 값을 사용합니다.
- `unset`: 요소에서 현재 두께를 제거합니다.

### 데모

다음 데모에서 `텍스트 데코레이션 두께` 값을 변경하여 속성이 요소의 텍스트 데코레이션에 어떤 영향을 미치는지 확인하십시오.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_VwvBwxj" src="//codepen.io/anon/embed/VwvBwxj?height=450&amp;theme-id=1&amp;slug-hash=VwvBwxj&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed VwvBwxj" title="CodePen Embed VwvBwxj" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 그것은 자손에게 일정하다.

요소에 대한 장식을 설정한 후, 모든 어린이들도 장식을 갖게 됩니다. 이제 아이들 중 한 명을 위해 장식의 두께를 바꾸고 싶다고 상상해 보십시오.

```css
p {
  text-decoration-line: underline;
  text-decoration-color: green;
  text-decoration-thickness: 0.2em;
}
 
p span {
  text-decoration-thickness: 0.1em; /* Doesn't work */
} 
 

```

상위 요소에서 지정한 장식 두께를 재정의할 수 없기 때문에 이 작업은 수행되지 않습니다. 이렇게 하려면 요소 자체에 대한 장식 특수성을 설정해야 합니다.

```css
p {
  text-decoration-line: underline;
  text-decoration-color: green;
  text-decoration-thickness: 0.2em;
}

p span {
  text-decoration-line: underline;
  text-decoration-color: green;
  text-decoration-thickness: 0.1em; /* It works! */
} 
 

```

### 백분율 및 계단식

이 속성의 경우 길이는 고정 값으로 상속되며 글꼴과 함께 확장되지 않습니다. 반면, 백분율은 상대 값으로 상속되므로 상속할 때 글꼴의 변경과 함께 크기가 조정됩니다.

```css
p {
  text-decoration-thickness: 20%;
}
 
p span {
  font-size: 20px;
  text-decoration-line: underline;
  text-decoration-thickness: inherit; /* = 20% */  
}
```

다음 데모에서는 상속의 경우 em 값과 백분율 값 사용 간의 비교를 보여 주며, 보시다시피 왼쪽(우리가 em을 사용하고 있는 경우)에서 상속된 값은 고정 길이입니다. 즉, 글꼴의 변화에 따라 크기가 조정되지 않습니다. 그러나 오른쪽에서 텍스트는 상대 값(이 경우 20%)을 상속하므로 두께는 글꼴의 변화에 따라 조정됩니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_mdeGGbO" src="//codepen.io/anon/embed/mdeGGbO?height=450&amp;theme-id=1&amp;slug-hash=mdeGGbO&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed mdeGGbO" title="CodePen Embed mdeGGbO" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

현재 작업 중인 규격 초안은 텍스트 장식 두께에 대한 백분율 값을 참조하고 있지만 실제 지원은 현재 파이어폭스로 제한돼 있다.

### 텍스트 장식과 함께 사용

현재 CSS 텍스트 데코레이션 모듈 레벨 4 규격의 작업 초안은 텍스트 데코레이션-두께를 텍스트 데코레이션 속성의 값으로 포함하고 있다.

```css
.link {
  text-decoration: underline solid green 1px;
}
 
/* The longhand equivalent */
.link { 
  text-decoration-line: underline;
  text-decoration-style: solid;
  text-decoration-color: green,
  text-decoration-thickness: 1px;
}
```

텍스트 데코레이션은 잘 지원되지만 텍스트 데코레이션 두께는 현재 파이어폭스에 국한돼 있다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_ExPaMBE" src="//codepen.io/anon/embed/ExPaMBE?height=450&amp;theme-id=1&amp;slug-hash=ExPaMBE&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed ExPaMBE" title="CodePen Embed ExPaMBE" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 브라우저 지원

### 메모들

- 이 속성은 `텍스트 데코레이션 폭`이라고 불렸지만 CSS 텍스트 데코레이션 모듈 레벨 4 규격의 2019년 작업 초안에서 업데이트되었다.
- 브라우저는 최소 1개의 장치 픽셀 두께를 사용해야 합니다.