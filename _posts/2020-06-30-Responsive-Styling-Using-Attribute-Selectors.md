---
layout: post
title: "특성 선택기를 사용한 반응형 스타일링"
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/06/atomic-css-attributes-1.png"
tags: ATOMIC,ATTRIBUTE SELECTORS,MEDIA QUERIES
---


클래스 기반 원자 스타일링을 구현할 때 직면하는 과제 중 하나는 컨텍스트의 특정 중단점에 의존하는 경우가 많다는 것이다.

```html
<div class="span-12"></div> <!-- we want this for small screens  -->
<div class="span-6"></div>  <!-- we want this for medium screens -->
<div class="span-4"></div>  <!-- we want this for large screens  -->
```

일반적으로 접두사를 사용하여 각 중단점을 대상으로 합니다.

```html
<div class="sm-span-12 md-span-6 lg-span-4"></div>
```

이 작업은 여러 클래스를 추가하기 시작할 때까지 잘 작동합니다. 이 때, 무엇을 어디에 추가하고 제거할 것인지 추적하기가 어려워집니다. 물건을 바꾸거나.

```html
<div class="
  sm-span-12 
  md-span-6 
  lg-span-4 
  sm-font-size-xl 
  md-font-size-xl 
  lg-font-size-xl 
  md-font-weight-500 
  lg-font-weight-700">
</div>
```

다음과 같이 다시 그룹화하여 보다 읽기 쉽게 만들 수 있습니다.

```html
<div class="
  sm-span-12 
  sm-font-size-xl 
 
  md-span-6 
  md-font-size-xl 
  md-font-weight-500 
 
  lg-span-4 
  lg-font-size-xl 
  lg-font-weight-700">
</div>
```

펑키 구분 기호를 추가할 수 있습니다(잘못된 클래스 이름은 무시됩니다).

```html
<div class="
  [
   sm-span-12 
   sm-font-size-xl 
  ],[
   md-span-6 
   md-font-size-xl 
   md-font-weight-500 
  ],[
   lg-span-4 
   lg-font-size-xl 
   lg-font-weight-700
  ]">
</div>
```

하지만 이건 여전히 지저분하고 이해하기가 힘듭니다. 적어도 제게는요.

실제 클래스 대신 속성 선택기를 그룹화하여 더 나은 개요를 얻고 구현 접두사를 피할 수 있습니다.

```html
<div 
  data-sm="span-12 font-size-lg"
  data-md="span-6 font-size-xl font-weight-500"
  data-lg="span-4 font-size-xl font-weight-700"
>
</div>
```

클래스가 손실된 것이 아니라 공백으로 구분된 속성 목록으로, `[https~="value"]를 사용하여 선택할 수 있습니다. 여기서 `~=`는 속성 값에서 일치하는 정확한 단어를 찾아야 합니다.

```css
@media (min-width: 0) {
 [data-sm~="span-1"] { /*...*/ }              
 [data-sm~="span-2"] { /*...*/ }   
 /* etc. */ 
}
@media (min-width: 30rem) {
 [data-md~="span-1"] { /*...*/ }   
 [data-md~="span-2"] { /*...*/ }   
 /* etc. */   
}
@media (min-width: 60rem) {
 [data-lg~="span-1"] { /*...*/ }   
 [data-lg~="span-2"] { /*...*/ }   
 /* etc. */   
}
```

약간 이상하게 보일 수 있지만 원자 클래스를 속성으로 변환하는 것은 매우 간단하다고 생각한다(예: `.sm-span-1`은 [data-sm~="span-1"]이 된다). 또한 속성 선택기는 클래스와 동일한 특수성을 가지므로 손실되는 것이 없습니다. 그리고 클래스와 달리 속성은 `/+?와 같은 특수 문자를 벗어나지 않고 쓸 수 있습니다.

이상입니다! 다시 말하지만, 이것은 미디어 쿼리의 선언을 쓰기, 읽기, 관리하기 쉽게 만드는 것을 목표로 하는 아이디어일 뿐이다. 수업이나 그런 것들을 없애자는 제안은 절대 아닙니다.