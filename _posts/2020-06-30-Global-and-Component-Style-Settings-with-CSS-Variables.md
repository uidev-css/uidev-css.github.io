---
layout: post
title: "CSS 변수를 사용한 전역 및 구성요소 스타일 설정"
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/06/style-guide-settings.png"
tags: CUSTOM PROPERTIES,GLOBAL SCOPE,THEMES
---


Sara Soueidan 기사의 제목은 나에게 말해준다. 저는 어떤 CSS는 전 세계적으로 가장 잘 적용되고 어떤 CSS는 구성 요소에 가장 잘 적용된다는 생각에 열렬한 팬입니다. 저는 그것이 어떻게 이루어지는지에 덜 관심이 있고 단지 어떤 방식으로 사용되는 개념적 접근을 보는 것에 더 관심이 있습니다.

Sara는 구성요소가 기본적으로 너무 많은 스타일링을 가지지는 않지만, 사용자가 구성요소를 설정하도록 선택할 경우 값을 취할 준비가 된 CSS 사용자 지정 속성을 적용할 수 있는 접근 방식을 자세히 설명합니다.

> 각 패턴에 대해 글꼴, 색상(텍스트, 배경, 테두리), 상자 그림자, 간격 등 필요할 때마다 동일한 속성을 수정했습니다. 그래서 저는 이러한 특성에 맞는 변수를 만들고, 그 변수를 요소의 '루트'에 정의하며, 제가 원하는 패턴을 사용할 때 이 변수들의 값을 '전달'하는 것이 유용하고 시간을 절약할 수 있다고 생각했습니다. 이렇게 하면 여러 규칙 간에 이동할 필요 없이 하나의 규칙 집합에서 속성 값을 변경하여 구성 요소를 사용자 지정하거나 테마를 지정할 수 있습니다.

직접 링크 →