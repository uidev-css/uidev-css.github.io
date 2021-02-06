---
layout: post
title: "고대비 모드에 대한 빠른 팁"
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/06/button-focus-outline-whcm.png"
tags: ACCESSIBILITY,FOCUS,HIGH-CONTRAST
---


Sarah Higley는 Windows에서 고대비 모드를 처리하기 위한 CSS 트릭을 가지고 있습니다. 이를 WHCM이라고 합니다.

첫 번째 방법은 다음과 같습니다.

> […] 기본 CSS 개요 속성이 포커스 상태에 대해 [WHCM]에서 원하는 시각적 효과를 제공하지 않는 경우 매우 간단한 해결 방법이 있습니다. 기본 브라우저 포커스 스타일을 "outline: none"으로 재정의하는 대신 "outline 3px solid transparent"로 변환합니다.

그렇게 되면 기본적으로 WHCM 밖에서는 아무 것도 할 수 없겠지만 WHCM에서는 두터운 흰색 테두리가 될 것이며, 이는 강하고 좋은 시각적 집중 스타일이다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/06/button-focus-outline-whcm.png?resize=899%2C499&ssl=1)

직접 링크 →