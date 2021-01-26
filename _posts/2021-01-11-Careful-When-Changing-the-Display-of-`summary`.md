---
layout: post
title: "'요약'표시를 변경할 때주의"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2021/01/4C5S1Ncg.jpg
tags: 
---


얼마전에 블로그 게시물의`<details>`요소에 대해 매우 유용한 버그 보고서를 받았습니다 (Kilian에게 감사드립니다!).
 .

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/4C5S1Ncg.jpg?resize=1200%2C398&ssl=1)

진단하기가 그리 어렵지 않았습니다.
 방금 Firefox에서 페이지를 열고 Firefox DevTools에서 요소를 검사하고 ▶가 돌아올 때까지 속성과 값을 가지고 놀았습니다.
 문제?
 나는 Normalize.css의 (아주 오래된) 사본을 사용하고 있었는데, 이것은이 사이트에서 몇 번의 재 설계를 통해 나를 따라 왔을 것입니다.

```css
summary {
  display: block; /* the problem */
}
```

그렇게하면 Firefox는 ▶ :

2016 년에이 문제는 Normalize에서 Jon Neal이 수정했습니다.

```css
summary {
  display: list-item;
}
```

Chrome에서`<summary>`의 사용자 에이전트 스타일은`block`이므로`block`으로 설정해도 문제가 없습니다.
 하지만 Firefox에서 가장 잘 알 수있는 것은 User Agent 스타일이 `list-item`입니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/CleanShot-2021-01-07-at-12.43.04@2x.png?resize=920%2C330&ssl=1)

따라서 Jon은 현재 버전의 Normalize에서 `list-item`으로 설정합니다.

또한 Firefox DevTools에서`:: marker` 유사 요소와 함께 ▶가 적용된 것을 볼 수 있습니다.
 `<summary>`가 더 이상`list-item`이 아닌 즉시`:: marker`가 사라집니다.
 사양에서 알 수 있듯이 의미가 있다고 생각합니다.

> :: marker 의사 요소는 목록 항목의 자동 생성 된 마커 상자를 나타냅니다.

그래서`:: marker`가 Chrome의 블록 수준 항목에서 작동한다는 사실이 버그일까요?
 잘 모르겠지만`:: marker`가 다른 작업을하는 것을 좋아합니다.
 Šime Vidas가 한때 지적했듯이 꽤 좋습니다.

사파리에서는 쉐도우 콘텐츠에서 ▶ 나오는 것이므로 문제 없습니다. ???

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2021/01/CleanShot-2021-01-07-at-12.50.26@2x.png?resize=716%2C210&ssl=1)

어쨌든 `목록 항목`으로 강제하는 Normalize 아이디어는 괜찮아 보입니다 (또는 전혀 건드리지 마십시오).