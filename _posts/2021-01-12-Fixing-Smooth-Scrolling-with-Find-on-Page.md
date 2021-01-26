---
layout: post
title: "페이지에서 찾기로 부드러운 스크롤 수정"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2021/01/smooth-scroll.jpg
tags: :FOCUS-WITHIN,SMOOTH SCROLLING
---


이 사이트의 v17 디자인 (현재 v18)을 출시했을 때입니다.
 나는`html {scroll-behavior : smooth;
 }`을 CSS에 추가합니다.
 바로 다음과 같은 댓글이 있습니다 (하나의 예).

> … control + f 또는 command + f를 사용하고 CSS-Tricks를 검색하면 결과에 맞추는 대신 매우 느리게 스크롤되므로 CSS-Tricks에서 정보와 키워드를 찾는 속도가 훨씬 느려집니다.
 이 바로 가기를 자주 사용하는 사람으로서 이것은 유용성 문제입니다.

그리 오래지 않아 나는 그것을 제거했습니다.
 나는 그것에 대해 그렇게 강하게 느끼지 않았고 당신이 그것에 대해 거의 제어 할 수 없다는 사실 때문에 나는 단지 아이디어를 할 수있게 만들었습니다.

나는 그것이 "CSS 팁"으로 많이 떠오르는 것을보고, 내 경험에 착수했다.

이를 언급 한 후 Christian Schaefer는 훌륭한 아이디어를 내놓았습니다.

사랑해!

Christian은 그것을 블로그에 올렸습니다.

> 결과적으로 부드러운 스크롤이 모든 것에 적용됩니다.
 항상.
 브라우저의 페이지 검색 결과를 순환하는 경우에도 마찬가지입니다.
 적어도 Chromium의 경우입니다.
 따라서 페이지 검색의 경우 브라우저가 해당 규칙에 예외를 적용하고 부드러운 스크롤을 비활성화하는 것이 바람직합니다.
 Chromium 팀에서 문제를 해결할 때까지 약간의 추가 CSS 및 HTML을 사용하여 문제를 직접 해결하는 방법이 있습니다.

Chrome (또는 다른 브라우저)이이를 버그로 간주할지 여부를 잘 모르겠습니다.
 페이지에서 찾기가 실제로 웹 기술 기능이 아니기 때문에 사양이 확실하지 않습니다.
 그러나 어쨌든 나는 그것이없는 페이지에서 찾기를 훨씬 선호한다.

```css
html:focus-within {
  scroll-behavior: smooth;
}
```

대부분 작동합니다.
 안타까운 부분은 이런 상황입니다…

```html
<a href="#link-down-the-page">Jump down</a>

...

<h2 id="link-down-the-page">Header</h2>
```

그러면 페이지가 아래로 이동합니다.
 `scroll-behavior : smooth;`가 제자리에 있으면 괜찮습니다.
 그러나`<h2>`는 일반적으로 "포커스 가능한"요소가 아닙니다.
 따라서 위의 트릭을 사용하면 이제`<html>`내에 더 이상 포커스가없고 부드러운 스크롤이 손실됩니다.
 이를 보존하려면 다음을 수행해야합니다.

```html
<h2 tabindex="-1" id="link-down-the-page">Header</h2>
```