---
layout: post
title: "페이지 로드 간에 스크롤 위치 기억"
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/07/localstorage-sidebar-scroll.png"
tags: SCROLLING
---


Hakim El Hattab은 스크롤 가능한 탐색 사이드바를 포함하는 정적 사이트에 대해 정말 멋진 UX 기능 향상을 트위터에 올렸습니다.

페이지를 종료하기 직전에 스크롤 위치를 localStorage(로컬 저장소)로 던진 다음 로드되면 해당 값을 잡고 스크롤하는 것이 요령이다. 트윗에서 다시 입력하겠습니다.

```js
let sidebar = document.querySelector(".sidebar");

let top = localStorage.getItem("sidebar-scroll");
if (top !== null) {
  sidebar.scrollTop = parseInt(top, 10);
}

window.addEventListener("beforeunload", () => {
  localStorage.setItem("sidebar-scroll", sidebar.scrollTop);
});
```

놀라운 것은 플래시 오브 스크롤 포지션이 없다는 것이다. 내가 왜인지 궁금해? 아마도 그것은 브라우저들이 현재 하고 있는 화려한 페인트 홀딩과 관련이 있을까? 확실하진 않다.