---
layout: post
title: "CSS 그리드의 아코디언 행"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/07/fig06.png
tags: GRID,GRID-TEMPLATE-COLUMNS,GRID-TEMPLATE-ROWS
---


격자-템플릿 기둥은 격자-템플릿 행보다 10배 정도 더 많이 쓰이겠지만, 어쩌면 모두가 그냥 빠져 있는 것일 수도 있다. 에릭 마이어는 다음과 같이 자신의 주 사이트 레이아웃 그리드에 여러 줄의 줄을 긋습니다.

```css
grid-template-rows: repeat(7, min-content) 1fr repeat(3, min-content);
```

이러한 방식으로 사용할 필요가 있는 경우 다음과 같은 이점이 있습니다.

> 이 무늬가 마음에 들어요. 개별 행 아코디언이 열려 내용을 받아들이고, 그렇지 않을 때는 0 높이로 접히는 두 개의 행이 있어, 그것들을 밀어내는 세트 사이에 "빈" 행이 끼어 있어 기분이 좋다. 유연성이 뛰어나며 레이아웃 스타일을 모두 다시 작성할 필요 없이 집합에 행을 더 추가할 수도 있습니다.

직접 링크 →