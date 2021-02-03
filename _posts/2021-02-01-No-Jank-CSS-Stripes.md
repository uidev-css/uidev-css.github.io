---
layout: post
title: "No-Jank CSS 스트라이프
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2021/01/stripes.jpg
tags: GRADIENTS,REPEATING GRADIENT
---


내 마음은 CSS에서 줄무늬를 만들 때 즉시 `반복 선형 그라데이션`과 하드 스톱 그라데이션으로 이동합니다.
 두 색상 중지 사이에 동일한 색상을 사용하고 다른 스트라이프 (또는 그 이상)를 사용하지만 두 색상 중지간에 다른 색상을 사용하여 하나의 스트라이프를 만듭니다 (중간에있는 색상을 공유).
 

그처럼:
 verified_user

```css
background: repeating-linear-gradient(
  45deg,
  black,
  black 10px,
  #444 10px,
  #444 11px
);
```

그러면 검은 색에서 각진 짙은 회색 줄무늬가 10px 떨어져 있습니다.
 

그러나 이것이 내 화면에서 렌더링되는 방법입니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-21-at-11.59.45-AM.png?resize=1344%2C336&ssl=1)

줄무늬 중 하나 또는 두 개가 다른 줄무늬보다 더 가볍고 얇아 보이는 렌더링 버벅 거림을 볼 수 있습니까?
 나는 이유를 모른다.
 나는 그것이 서브 픽셀 렌더링 등과 관련이 있다고 가정합니다.
 이것은 복제하기 어렵지 않습니다.
 이 두 가지 색상뿐만 아니라이 특정 각도는 `반복 선형 그라데이션`으로 만들어진 줄무늬에 대한 것입니다.
 하지만 더 두꺼운 줄무늬 (예 : `5px`이상)로 눈에 띄지 않습니다.
 

나는 몇 가지 예를 만들었습니다.
 다른 방향으로가는 줄무늬가 더 촘촘한 것이 특히 두드러집니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-21-at-12.02.18-PM.png?resize=1182%2C334&ssl=1)

요 전에이 작업을 수행해야했고, 버벅 거림을 발견하고 줄무늬 기사에서이 작은 메모를 기억했습니다.
 `반복 선형 그라데이션`을 사용하지 마세요.
 그냥`linear-gradient`를 사용하고`background-size`를 설정하고 반복하게하세요.
 실제로 그것은 속임수를 쓰는 것 같습니다.
 문제는 ... `배경 크기`를 얼마나 크게 만드는가?
 줄무늬가 세로 또는 가로이면 무언가를 번지기가 상당히 쉽습니다.
 그러나 줄무늬가 비스듬한 경우… 완벽한 너비 × 높이를 계산하는 것은 까다 롭습니다.
 피타고라스 정리와 관련이있을 것 같지만 저는 깊이 빠져 있습니다.
 

### 그래서 당신은 무엇을합니까?
 

이 멋진 생성기 도구를 사용하십시오.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-21-at-1.45.08-PM.png?resize=2358%2C1940&ssl=1)

올바른 계산을 위해 필요한 모든 멋진 수학을 수행합니다.
 여기에서 축소되지 않은 JavaScript를 볼 수 있습니다.
 `/ GET BACKGROUND SIZE /`를 검색하여 진행되는 모든 수학을 확인합니다.
 거기에서 무엇을하든 줄무늬가 완벽하게 나옵니다.
 

일종의 부끄러운 `반복 선형 그라데이션`은 추론하기가 훨씬 쉽기 때문에 더 나은 시각적 출력을 제공하지 못하지만해야 할 일을해야합니다.
 