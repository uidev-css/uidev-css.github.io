---
layout: post
title: "CSS 그리드의 네이티브 CSS 벽돌 레이아웃
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/11/pure-css-masonry.jpg
tags: 
---


Rachel Andrew는 석조 레이아웃이 CSS 그리드 레이아웃을 통해 네이티브 CSS에 포함될 것이라는 사실을 소개했습니다.
 석조물에 대한 것은 우리가 이미 대부분을 할 수 있다는 것입니다. 그러나 그것을 어렵게 만드는 한 가지가 있습니다 : 수직으로 엇갈리게하고 왼쪽에서 오른쪽으로 소스 순서를 갖는 것입니다.
 이것이이 새로운 능력이 일반적으로 덜 험난 해지는 것 외에도 해결 될 것입니다.
 

`layout.css.grid-template-masonry-value.enabled`를 활성화하여 Firefox Nightly에서 부분 구현을 이미 테스트 할 수 있습니다.
 

```css
.container {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  grid-template-rows: masonry;
}
```

저는`grid-template-rows : masonry;`구문을 좋아합니다. "이 행을 설정하는 것이 아닙니다.
 사실 더 이상 실제로 행도 없습니다. 우리가 처리하겠습니다. "
 내가 생각하기에 하위 표에 상속 할 행이 없음을 의미합니다.
 