---
layout: post
title: "1fr이 아닌 minmax (10px, 1fr)를 원합니다.
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2021/01/Untitled.jpg
tags: COLUMNS,GRID,MINMAX
---


웹에는 다음과 같은 많은 그리드가 있습니다.
 

```css
.grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
}
```

제 메시지는 그들이 정말로되어야하는 것은 다음과 같습니다.
 

```css
.grid {
  display: grid;
  grid-template-columns: repeat(3, minmax(10px, 1fr));
}
```

왜?
 전자의 경우 그리드 열의 최소 너비는 `최소 내용`으로, 원하는 것보다 어색하게 넓을 수 있습니다 (그리드 블로우 아웃 참조).
 후자의 경우 최소값을 `10px`로 줄였습니다 (0이 아니므로 사라지지 않고 더 많은 혼란을 초래 함).
 

약간 안타깝게도 이것이 필요하지만 그렇게하면 더 예측 가능한 행동으로 이어지고 두통을 예방할 수 있습니다.
 

그게 다입니다.
 그게 내 전체 메시지입니다.
 

(Kilian의 "You want overflow : auto, not overflow : scroll"에서 kiped 된 블로그 게시물 형식도 마찬가지입니다.)
 