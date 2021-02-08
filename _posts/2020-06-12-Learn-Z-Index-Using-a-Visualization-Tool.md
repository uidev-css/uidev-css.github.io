---
layout: post
title: "시각화 도구를 사용하여 Z-색인 학습"
author: "Uidev Css"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/06/Screen-Shot-2020-06-11-at-6.53.56-AM.png"
tags: Z-INDEX
---


티루 마니칸단의 멋진 인터랙티브 데모들이 있습니다. z-인덱스에는 헷갈리지 않는 매우 까다로운 점이 한두 가지 있다. 위치 지정과 소스 순서 요구와 같은 것 외에도, 가장 까다로운 것은 스택 컨텍스트와 부모/자녀 관계입니다. z-index는 평평한 게임장이 아닙니다. 요소에 z-index:2147483644를 적용하더라도 해당 요소는 상위 요소 내부에 고유한 스택 컨텍스트와 형제 또는 일부 상위 수준 DOM 요소보다 낮은 `z-index`가 있을 수 있으므로 아무 일도 일어나지 않을 수 있습니다.

직접 링크 →