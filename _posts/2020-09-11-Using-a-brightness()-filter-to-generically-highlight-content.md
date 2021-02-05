---
layout: post
title: "밝기() 필터를 사용하여 일반적으로 내용 강조"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2019/05/button-hover.png
tags: BUTTONS,FILTER,FOCUS,HOVER
---


릭 스트롤:

> 몇 년 동안 CSS 구현과 같은 사용자 지정 '버튼'을 몇 번이나 구현했는지 말할 수 없습니다. 수년간 이미지, 배경, 그라데이션 및 불투명도를 사용하여 컨트롤을 효과적으로 '강조'했습니다. 물론 모든 것이 효과가 있지만, 대부분의 이러한 접근 방식의 문제는 색상 값, 이미지 또는 그라데이션의 하드 코딩입니다.

정확한 색상을 지정할 경우 훨씬 더 많은 제어 기능을 사용할 수 있습니다. 하지만 밝기, 어두워짐 또는 색조 전환을 통해 사이트에 응집력이 있다고 느낄 수 있다면 훨씬 적은 코드를 유지할 수 있습니다.

```css
.button.specific-button {
  background: #4CAF50;
}
.button.specific-button:focus,
.button.specific-button:hover {
  background: #A5D6A7;
}

/* vs. */
.button:focus,
.button:hover {
  filter: brightness(120%);
}

/* or maybe you're super hardcore and do it everywhere */
:focus,
:hover {
  filter: brightness(120%) saturate(120%);
}
```

직접 링크 →