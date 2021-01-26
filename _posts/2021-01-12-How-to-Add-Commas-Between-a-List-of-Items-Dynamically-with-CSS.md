---
layout: post
title: "CSS를 사용하여 항목 목록 사이에 동적으로 쉼표를 추가하는 방법"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2021/01/commas.jpg
tags: 
---


항목 목록이 있다고 상상해보십시오.
 과일 : 바나나, 사과, 오렌지, 배, 천도 복숭아

HTML에 쉼표 (,)를 넣을 수 있지만 대신 CSS에서이를 수행하여 추가 제어 수준을 제공하는 방법을 살펴 보겠습니다.
 마지막 항목에 쉼표가 없는지 확인하겠습니다.

나는 최근에 실제 프로젝트를 위해 이것을 필요로했고, 요구 사항 중 일부는 목록의 모든 항목이 JavaScript를 통해 숨겨 지거나 표시 될 수 있다는 것이 었습니다.
 쉼표는 현재 표시된 항목에 관계없이 올바르게 작동해야했습니다.

내가 찾은 한 가지 해결책은 일반적인 형제 결합자를 사용하는 것입니다.
 잠시 후에 설명하겠습니다.
 몇 가지 예제 HTML부터 시작하겠습니다.
 과일 목록으로 시작한다고 가정 해 보겠습니다.

```html
<ul class="fruits">
  <li class="fruit on">Banana</li>
  <li class="fruit on">Apple</li>
  <li class="fruit on">Orange</li>
  <li class="fruit on">Pear</li>
  <li class="fruit on">Nectarine</li>
</ul>
```

그리고 그것들을 목록에 표시하기위한 몇 가지 기본 CSS :

```css
.fruits {
  display: flex;
  padding-inline-start: 0;
  list-style: none;
}

.fruit {
  display: none; /* hidden by default */
} 
.fruit.on { /* JavaScript-added class to reveal list items */
  display: inline-block;
}
```

이제 사용자가 추운 기후에서 자라는 모든 과일을 걸러내는 컨트롤을 전환하는 것처럼이 인터페이스 내에서 일이 발생한다고 가정 해보십시오.
 이제 다른 과일 세트가 표시되므로`fruit.on` 클래스는`classList` API로 조작됩니다.

지금까지 HTML과 CSS는 다음과 같은 목록을 만들었습니다.

```
BananaOrangeNectarine
```

이제 일반적인 형제 결합 자에 도달하여 두 개의 `on`요소 사이에 쉼표와 공백을 적용 할 수 있습니다.

```css
.fruit.on ~ .fruit.on::before {
  content: ', '; 
}
```

좋은!

아마도 모든 목록 항목에 쉼표를 적용하고`: last-child` 또는`: last-of-type`과 같이 마지막 항목에서 제거하는 것이 어떻습니까?
 그 문제는 마지막 아이가 주어진 시간에 "꺼져"있을 수 있다는 것입니다.
 그래서 우리가 정말로 원하는 것은“on”인 마지막 항목입니다. CSS에서는 쉽게 불가능합니다.“Last of class”와 같은 것이 없기 때문입니다.
 따라서 일반적인 형제 결합 자 트릭!

UI에서는`display` 대신`max-width`를 사용하고이를`0`과 합리적인 최대 값 사이에서 토글하여 전환을 사용하여 항목을보다 자연스럽게 켜고 끌 수 있도록하여 사용자가
 목록에서 추가되거나 제거되는 항목을 확인합니다.
 유사 요소에도 동일한 효과를 추가하여 매우 매끄럽게 만들 수 있습니다.

다음은 약간의 변형이있는 몇 가지 예가 포함 된 데모입니다.
 fruits 예제는 `on`대신 `hidden`클래스를 사용하고 veggies 예제에는 애니메이션이 있습니다.
 SCSS는 여기서도 중첩을 위해 사용됩니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 350px;"><iframe id="cp_embed_NWRaYPY" src="//codepen.io/anon/embed/NWRaYPY?height=350&amp;theme-id=1&amp;slug-hash=NWRaYPY&amp;default-tab=result" height="350" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed NWRaYPY" title="CodePen Embed NWRaYPY" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

나는 이것이 비슷한 것을 찾는 다른 사람들에게 도움이되기를 바랍니다!