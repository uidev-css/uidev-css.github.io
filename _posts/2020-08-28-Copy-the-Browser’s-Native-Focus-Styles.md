---
layout: post
title: "브라우저의 기본 포커스 스타일 복사"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/08/Screen-Shot-2020-08-25-at-4.08.31-PM.png
tags: FOCUS,OUTLINE
---


며칠 전에 레미가 이걸 기록했어 파이어폭스는 하이라이트(Highlight) 키워드를, 크롬과 사파리(Safari)는 웹킷포커스링컬러(-webkit-focus-ring-color) 키워드를 지원한다. 예를 들어, 포커스를 제거한 후 브라우저 기본값과 동일한 스타일로 되돌리거나 포커스 자체가 직접 포커스가 아닌 요소에 포커스 스타일을 적용하려는 경우 이 방법이 유용할 수 있습니다.

예를 들어:

```css
button:focus + span {
  outline: 5px auto Highlight;
  outline: 5px auto -webkit-focus-ring-color;
}
```

내가 보기엔 좋아. 그렇지 않으면 복제하기가 조금 까다로울 것 같은 이상한 새로운 크롬 더블 아웃라인 스타일에 특히 도움이 된다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/08/Screen-Shot-2020-08-25-at-4.08.13-PM.png?resize=536%2C248&ssl=1)

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/08/Screen-Shot-2020-08-25-at-4.08.31-PM.png?resize=564%2C268&ssl=1)

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/08/Screen-Shot-2020-08-25-at-4.09.01-PM.png?resize=520%2C210&ssl=1)