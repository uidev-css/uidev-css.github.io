---
layout: post
title: "선행 트림: 디지털 타이프 설정의 미래"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/08/1gXfB7QR3LpWwJEuA12drqw.gif
tags: LEADING-TRIM,TYPOGRAPHY
---


`leading-trim`은 텍스트를 보다 예측 가능하게 스타일링할 수 있도록 모든 글꼴의 추가 간격을 제거할 수 있는 새로운 CSS 속성이다. Ethan Wang은 Microsoft가 이를 어떻게 옹호해왔는지 포함하여, 현재 인라인 레이아웃 모듈 레벨 3 사양의 일부라고 썼습니다.

이렇게 하면 됩니다.

```css
h1 { 
 leading-trim: both;
 text-edge: cap alphabetic;
} 

```

이것은 브라우저에게 폰트 파일을 보고 OpenType 메트릭을 탐색하고 Ethan이 이 gif에서 보여준 것을 효과적으로 수행하라고 지시하는 것입니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/08/1gXfB7QR3LpWwJEuA12drqw.gif?resize=1024%2C364&ssl=1)

우리는 왜 이것을 하고 싶은가? 음, 이상한 해킹 없이 버튼 안에 텍스트를 적절하게 띄울 수 있게 해주고, 다른 서체들 사이에 예측 가능한 간격 값도 설정할 수 있게 해줍니다. 저는 이 규격과 CSS 속성이 상당히 흥분됩니다. 왜냐하면 이 규격은 웹에서 타이포그래피를 사용할 수 있는 도구를 하나 더 제공해주기 때문입니다. 예를 들어, 줄 높이를 길들이는 것과 같은 것이죠.

직접 링크 →