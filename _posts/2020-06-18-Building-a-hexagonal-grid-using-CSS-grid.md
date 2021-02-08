---
layout: post
title: "CSS 그리드를 이용한 육각형 그리드 구축"
author: "Uidev Css"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/06/Screen-Shot-2020-06-17-at-7.40.37-AM.png"
tags: GRID
---


저는 그리드를 수직선과 수평선이 교차하는 직사각형의 배열로 생각합니다. 그렇긴 하지만, 그렇다고 해서 그리드에 물건을 설치하는 방법이나 그 후에 우리가 그 요소들을 가지고 무엇을 할 수 있는지에 있어서 여전히 영리한 일을 할 수 없다는 뜻은 아닙니다.

제시 브렌먼의 이 데모에서는 각 블록이 세 개의 열과 두 개의 행에 걸쳐 있을 수 있도록 수학으로 그리드 열을 설정하여 블록 주위에 `클립 경로`를 적용할 수 있는 방식으로 블록이 겹칠 수 있도록 육각형 그리드를 만든다. 이것은 블록을 다른 블록과 균일한 간격으로 있는 육각형으로 조각합니다. 매우 총명하다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/06/Screen-Shot-2020-06-17-at-7.39.00-AM.png?fit=1024%2C727&ssl=1)

그리고, 하, 제시라는 도메인 이름이 지독하군. 개인적으로, 나는 CSS에 대한 블로그에 대해 아주 치사한 도메인 이름을 쓰는 것에 대해 아는 것이 없다.

직접 링크 →