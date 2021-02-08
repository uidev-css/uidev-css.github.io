---
layout: post
title: "CSS 사용자 지정 카운터를 되돌리는 방법"
author: "Uidev Css"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/06/css-counter-reversed.png"
tags: COUNTER-INCREMENT,COUNTERS,LISTS
---


나는 블로그 게시물의 번호가 매겨진 리스트가 필요했는데, 그 리스트는 맨 마지막에/높게 먼저 기재되어 있고 거기서 아래로 내려가고 있었다. 다음과 같은 경우:

```html
5. Post Title
4. Post Title
3. Post Title
2. Post Title
1. Post Title
```

하지만 위의 내용은 텍스트일 뿐입니다. 나는 이것을 의미론적 `올` 요소로 하고 싶었다.

### 쉬운 방법

HTML의 역방향 속성을 사용하여 다음을 수행할 수 있습니다` 속성을 사용해서 수행할 수 있습니다.

```html
<ol reversed>
  <li>This</li>
  <li>List</li>
  <li>Will Be</li>
  <li>Numbered In</li>
  <li>Reverse</li>
</ol> 

```

대부분의 사람들에게 이 정도면 충분할 것이다. 됐다.

하지만 카운터를 위한 맞춤 스타일이 필요했어요.

사용자 지정 목록 번호 스타일은 `:marker` 유사 요소를 사용하여 수행할 수 있지만 아직 Chrome에서 지원하지 않습니다(곧 출시될 예정이지만).

완벽한 크로스 브라우저 호환 사용자 지정 번호 스타일을 원했기 때문에 사용자 지정 카운터를 이용했습니다.

### 사용자 지정 카운터 추가 및 스타일링

목록의 나머지 부분과 다르게 정렬된 목록의 카운터를 스타일링하려면 기본 카운터를 비활성화하고 CSS 카운터를 사용하여 직접 만들고 표시해야 합니다. 크리스는 얼마 전에 확인해 볼 만한 몇 가지 요리법을 공유했다.

다음과 같은 HTML을 가지고 있다고 가정합니다.

```html
<ol class="fancy-numbered">
  <li>Item 1</li>
  <li>Item 2</li>
  <li>Item 3</li>
</ol>
```

…CSS 속성 `list-style-type`을 다음과 같이 `없음`으로 설정하여 모든 순서 목록과 함께 제공되는 기본 카운터를 비활성화해야 합니다.

```css
ol.fancy-numbered {
  list-style-type: none;
}
```

그러면 기본 번호가 모두 제거됩니다. 다음으로 CSS에 카운터를 만들어 목록의 항목 수를 추적합니다.

```css
ol.fancy-numbered {
  list-style-type: none;
  counter-reset: a;
}
```

이것은 우리에게 "a"라는 이름의 카운터를 주지만, 그것은 당신이 원하는 대로 부를 수 있습니다. 목록 항목(<li>)의 `::before` 유사 요소를 사용하여 카운터를 표시해 보겠습니다.

```css
ol.fancy-numbered li::before {
  content: counter(a)'.';
}
```

이렇게 하면 유사 요소의 내용이 카운터의 값으로 설정됩니다. 지금 당장은 목록 항목 옆에 1이 인쇄됩니다.

CSS 카운터에 어떻게 증분을 하는지 알려줘야 합니다.

```css
ol.fancy-numbered li::before {
  content: counter(a)'.';
  counter-increment: a;
}
```

"a"의 시작 값은 0으로 이상하게 보이지만, 기본 증분은 1로 실제 시작점이 된다는 의미입니다. 1씩 증가하면 기본값이 되지만, 곧 알게 될 대로 변경할 수 있습니다.

이제 카운터는 스타일링에 크게 열려 있는 텍스트 의사 요소이기 때문에 원하는 사용자 지정 스타일을 카운터에 적용할 수 있습니다.

```css
ol.fancy-numbered li::before {
  content: counter(a)'.';
  counter-increment: a;   
  position: absolute;   
  left: 0;   
  color: blue;   
  font-size: 4rem;
}
```

예를 들어, 여기에서는 카운터를 파란색으로 만들고 글꼴 크기를 늘렸습니다. 기본 카운터를 사용하여 수행할 수 없었던 작업들입니다.

### 사용자 지정 카운터 되돌리기

이전처럼 `올` 요소에 `반전` 속성을 추가하면 기본 번호를 사용하지 않도록 설정했기 때문에 아무 효과도 관찰할 수 없습니다. 그게 바로 이 부동산이 하는 일입니다.

```html
<ol class="fancy-numbered" reversed>
  <li>Item 1</li>
  <li>Item 2</li>
  <li>Item 3</li>
</ol>
```

위의 코드는 고객 번호 지정에 영향을 미치지 않습니다. 아직 거기에 놔두는 게 좋을 것 같은데, 우리의 의도는 목록을 뒤집는 것이기 때문입니다. 이것은 의미론적으로 정확한 것을 유지한다.

카운터 기반 번호의 시각적 순서를 뒤집으려면 목록에 있는 총 항목 수를 알고 카운터에 해당 번호에서 시작하여 거기서 감소하도록 지시해야 합니다.

```css
ol.fancy-numbered {
  counter-reset: a 4;
  list-style-type: none;
}
```

여기서는 `반대 재설정`을 4로 설정합니다. 다시 말하면, 우리는 브라우저에게 카운트를 1이 아닌 4로 시작하라고 말하고 있는 것입니다. 우리는 또 목록의 첫 번째 항목인 0에 카운터() 규칙이 적용되기 때문에 3 대신 4를 사용합니다. 하지만 거꾸로 세는 경우에는 4가 0이 됩니다. 3부터 시작해서 감소하면 1이 아니라 0이 됩니다.

다음으로, 우리는 `반증분` 규칙을 음의 정수로 만들어 증가보다는 1 감소로 변경한다.

```css
ol.fancy-numbered li:before {
  content: counter(a)'.';
  counter-increment: a -1;
  position: absolute;   
  left: 0;   
  color: blue;   
  font-size: 4rem;
} 

```

바로 그거야! 이제 세계는 스텝 트래커와 같은 것을 위한 굴입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_ExPYvYM" src="//codepen.io/anon/embed/ExPYvYM?height=450&amp;theme-id=1&amp;slug-hash=ExPYvYM&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed ExPYvYM" title="CodePen Embed ExPYvYM" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

또는 시간 표시 막대는 어떻게 됩니까?

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_gOPYxbg" src="//codepen.io/anon/embed/gOPYxbg?height=450&amp;theme-id=1&amp;slug-hash=gOPYxbg&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed gOPYxbg" title="CodePen Embed gOPYxbg" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

사업 계획이라도?

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_dyGbRab" src="//codepen.io/anon/embed/dyGbRab?height=450&amp;theme-id=1&amp;slug-hash=dyGbRab&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed dyGbRab" title="CodePen Embed dyGbRab" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>