---
layout: post
title: "심층 중첩 HTML 구조를 생성하는 보다 현명한 방법"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/10/nesting-spinner.jpg
tags: HAML,HTML,JAVASCRIPT,PHP,PREPROCESSING,PUG
---


다음과 같은 HTML 구조를 가지고 싶다고 가정해 보겠습니다.

```html
<div class='boo'>
  <div class='boo'>
    <div class='boo'>
      <div class='boo'>
        <div class='boo'></div>
      </div>
    </div>
  </div>
</div>
```

수동으로 쓰는 것은 정말 고통스러운 일입니다. 그리고 이 게시물이 탄생한 이유는 Haml과 함께 이러한 게시물이 생성되는 것을 보고 두려웠기 때문입니다.

```haml
.boo
  .boo
    .boo
      .boo
        .boo
```

제가 본 코드에는 실제로 약 20단계 정도의 둥지가 있었습니다. 하지만 아마도 몇몇 사람들은 휴대폰으로 뭔가를 읽고 있을 것입니다. 그러니 할로윈이 다가오더라도 전체 뷰포트를 야유로 가득 채우지 맙시다.

보시다시피, 모든 레벨을 수동으로 작성하는 것은 특히 사전 프로세서(또는 자바스크립트 또는 PHP와 같은 백엔드 언어)에 의해 HTML이 생성될 경우 이상과는 거리가 멀다. 저는 개인적으로 깊은 보금자리 팬은 아니고 제가 많이 쓰지도 않지만 어쨌든 여러분이 원하신다면, 스케일도 잘 되고 유지도 쉽게 되는 그런 방식으로 할 가치가 있다고 생각합니다.

먼저 이 기본 케이스에 대한 몇 가지 더 나은 솔루션과 다양한 솔루션을 살펴본 후, 이와 같은 종류의 깊은 보금자리를 통해 몇 가지 재미있는 것들을 살펴보도록 하자!

### 기본 용액

우리가 여기서 필요로 하는 것은 재귀적인 접근이다. 예를 들어 Haml을 사용하면 다음 코드 비트가 사용됩니다.

```haml
- def nest(cls, n);
-  return '' unless n > 0;
-  "<div class='#{cls}'>#{nest(cls, n - 1)}</div>"; end

= nest('👻', 5)
```

거기에 이모티콘이 있습니다. 왜냐하면 우리는 할 수 있고 이것은 단지 재미있는 작은 예이기 때문입니다. 저는 확실히 실제 웹사이트에서는 이모지 수업을 사용하지 않겠지만, 다른 상황에서는 제가 쓰는 코드로 조금 재미를 느끼는 것을 좋아합니다.

또한 Pug를 사용하여 HTML을 생성할 수도 있습니다.

```pug
mixin nest(cls, n)
  div(class=cls)
    if --n
      +nest(cls, n)

+nest('👻', 5)
```

또한 JavaScript 옵션도 있습니다.

```js
function nest(_parent, cls, n) {
  let _el = document.createElement('div');
 
  if(--n) nest(_el, cls, n);

  _el.classList.add(cls);
  _parent.appendChild(_el)
};

nest(document.body, '👻', 5)
```

PHP를 사용하면 다음과 같은 기능을 사용할 수 있습니다.

```php
<?php
function nest($cls, $n) {
  echo "<div class='$cls'>";
  if(--$n > 0) nest($cls, $n);
  echo "</div>";
}

nest('👻', 5);
?>
```

이러한 각 생성물의 주요 차이점은 포맷과 백색 공간과 관련이 있습니다. `로 가장 안쪽의 `부`를 겨냥한다는 뜻이다.👻:empty`는 Haml, JavaScript 및 PHP 생성 HTML에서 작동하지만 Pug 생성 HTML에서는 작동하지 않습니다.

### 수준 표시기 추가

예를 들어, 각각의 부스에 레벨 표시기를 사용자 지정 자산인 --i로 설정하기를 원한다고 가정해 보자. 예를 들어, 각각의 부스에 다른 배경을 제공하는 데 사용될 수 있다.

여러분은 우리가 원하는 것이 색조를 바꾸는 것이라면 `필터: 색-회전()`으로 그것을 할 수 있고 레벨 표시기 없이 할 수 있다고 생각할지도 모른다. 그러나 색채 회전()은 색채뿐만 아니라 포화와 가벼움에도 영향을 미친다. 또한 수준 지표인 --i에 의존하는 자체 사용자 지정 기능을 사용하는 것과 동일한 수준의 제어 기능을 제공하지 않습니다.

예를 들어, 이것은 `background` 구성 요소를 수준에서 수준까지 부드럽게 변화시키기 위해 최근 프로젝트에서 사용한 것입니다(`$c` 값은 다항식 계수임).

```css
--sq: calc(var(--i)*var(--i)); /* square */
--cb: calc(var(--sq)*var(--i)); /* cube */
--hue: calc(#{$ch0} + #{$ch1}*var(--i) + #{$ch2}*var(--sq) + #{$ch3}*var(--cb));
--sat: calc((#{$cs0} + #{$cs1}*var(--i) + #{$cs2}*var(--sq) + #{$cs3}*var(--cb))*1%);
--lum: calc((#{$cl0} + #{$cl1}*var(--i) + #{$cl2}*var(--sq) + #{$cl3}*var(--cb))*1%);

background: hsl(var(--hue), var(--sat), var(--lum));
```

Pug를 조정하여 레벨 표시기를 추가하는 방법은 다음과 같습니다.

```pug
mixin nest(cls, n, i = 0)
  div(class=cls style=`--i: ${i}`)
    if ++i < n
      +nest(cls, n, i)

+nest('👻', 5)
```

Haml 버전도 크게 다르지 않습니다.

```haml
- def nest(cls, n, i = 0);
-   return '' unless i < n;
-   "<div class='#{cls}' style='--i: #{i}'>#{nest(cls, n, i + 1)}</div>"; end

= nest('👻', 5)
```

JavaScript를 사용하면 다음과 같은 이점이 있습니다.

```js
function nest(_parent, cls, n, i = 0) {
  let _el = document.createElement('div');

  _el.style.setProperty('--i', i);
 
  if(++i < n) nest(_el, cls, n, i);

  _el.classList.add(cls);
  _parent.appendChild(_el)
};

nest(document.body, '👻', 5)
```

PHP의 경우 코드는 다음과 같습니다.

```php
<?php
function nest($cls, $n, $i = 0) {
  echo "<div class='$cls' style='--i: $i'>";
  if(++$i < $n) nest($cls, $n, $i);
  echo "</div>";
}

nest('👻', 5);
?>
```

### 더 나무와 같은 구조

우리가 각각의 부스가 두 명의 부아이를 낳기를 원한다고 가정해봅시다. 이렇게 생긴 구조 말입니다.

```haml
.boo
  .boo
    .boo
      .boo
      .boo
    .boo
      .boo
      .boo
  .boo
    .boo
      .boo
      .boo
    .boo
      .boo
      .boo
```

다행히도, 이것을 얻기 위해 Pug 믹스를 많이 바꿀 필요는 없습니다.

```pug
mixin nest(cls, n)
  div(class=cls)
    if --n
      +nest(cls, n)
      +nest(cls, n)

+nest('👻', 5)
```

Haml 버전도 마찬가지입니다.

```haml
- def nest(cls, n);
-   return '' unless n > 0;
-   "<div class='#{cls}'>#{nest(cls, n - 1)}#{nest(cls, n - 1)}</div>"; end

= nest('👻', 5)
```

JavaScript 버전은 다음과 같은 작업을 더 많이 수행하지만, 많은 작업이 필요하지 않습니다.

```js
function nest(_parent, cls, n) {
  let _el = document.createElement('div');
  
  if(n > 1) {
    nest(_el, cls, n - 1);
    nest(_el, cls, n - 1)
  }

  _el.classList.add(cls);
  _parent.appendChild(_el)
};

nest(document.body, '👻', 5)
```

PHP를 사용하면 if 블록에서 nest() 함수를 다시 한 번만 호출하면 됩니다.

```php
<?php
function nest($cls, $n) {
  echo "<div class='$cls'>";
  if(--$n > 0) {
    nest($cls, $n);
    nest($cls, $n);
  }
  echo "</div>";
}

nest('👻', 5);
?>
```

### 최상위 요소를 다르게 스타일링

물론 최상위 수준에만 특수 .top(또는 .root) 클래스를 추가할 수 있지만 CSS에 맡기는 것이 좋습니다.

```css
:not(.👻) > .👻 {
  /* Top-level styles*/
}
```

### 조심해!

변환필터클립길마스크오패시티 등 일부 성질은 요소뿐 아니라 그 후손 모두에게 영향을 미친다. 때로는 이것이 바람직한 효과이며 정확히는 이러한 요소들이 형제자매보다 더 선호되는 이유이다.

그러나 다른 때는 그것이 우리가 원하는 것이 아닐 수도 있고 `변혁`과 `필터`의 효과를 뒤집는 것은 가능하지만 다른 경우는 어쩔 수 없다. 예를 들어 부모의 opacity:.8을 보상하기 위해 요소에 opacity:1.25를 설정할 수는 없다.

### 예를 들어!

먼저, 최근 코드펜 도전을 위해 만든 순수 CSS 도트 로더가 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 370px;"><iframe id="cp_embed_gOMOMYz" src="//codepen.io/anon/embed/gOMOMYz?height=370&amp;theme-id=1&amp;slug-hash=gOMOMYz&amp;default-tab=result" height="370" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed gOMOMYz" title="CodePen Embed gOMOMYz" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

여기서 스케일링 변환과 애니메이션 회전의 효과는 불투명도처럼 내부 요소에 더해진다.

다음은 나무와 같은 구조를 사용하는 음양 춤입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 750px;"><iframe id="cp_embed_oNNzygv" src="//codepen.io/anon/embed/oNNzygv?height=750&amp;theme-id=1&amp;slug-hash=oNNzygv&amp;default-tab=result" height="750" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed oNNzygv" title="CodePen Embed oNNzygv" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

가장 바깥쪽(`:not ☯ > .☯ > )을 제외한 모든 항목의 지름은 부모 직경의 절반과 같습니다. 가장 안쪽에 있는 항목의 경우(영문)☯나무 잎이라고 할 수 있을 것 같은데) 배경에는 두 개의 `나무 잎` 층이 더 있다. 첫 번째 데모와 마찬가지로, 애니메이션 회전의 효과는 내부 요소에 더합니다.

또 다른 예는 회전하는 사탕 촉수입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 500px;"><iframe id="cp_embed_NWrPOYa" src="//codepen.io/anon/embed/NWrPOYa?height=500&amp;theme-id=1&amp;slug-hash=NWrPOYa&amp;default-tab=result" height="500" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed NWrPOYa" title="CodePen Embed NWrPOYa" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

각각의 동심원은 둥지의 수준을 나타내며, 그것의 모든 조상들의 애니메이션 회전의 효과와 그것의 자신의 것을 결합한다.

마지막으로, 이 삼각형 개구부 데모(참고로 `rotate` 및 `scale`과 같은 개별 변환 속성을 사용하므로 Chrome://flags에서 실험 웹 플랫폼의 기능 플래그를 활성화해야 크롬 브라우저에서 작동한다)를 볼 수 있다.

기본 중첩 혼합의 약간 수정된 버전을 사용하여 각 수준에 `색상`을 설정합니다.

```pug
- let c = ['#b05574', '#f87e7b', '#fab87f', '#dcd1b4', '#5e9fa3'];
- let n = c.length;

mixin nest(cls, n)
  div(class=cls style=`color: ${c[--n]}`)
    if n
      +nest(cls, n)

body(style=`background: ${c[0]}`)
  +nest('🔺', n)
```

여기서 활기를 띠는 것은 개별 변환 속성인 스케일과 회전이다. 이것은 우리가 그들을 위해 다른 타이밍 기능을 설정할 수 있도록 하기 위해 행해진다.