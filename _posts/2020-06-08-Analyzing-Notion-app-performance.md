---
layout: post
title: "개념 앱 성능 분석"
author: "Uidev Css"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/06/notion.png"
tags: NOTION,PERFORMANCE
---


다음은 Ivan Akulov가 널리 사용되는 쓰기 앱 개념과 팀이 코드 분할, 사용되지 않는 벤더 코드 제거, 모듈 연결 및 JavaScript 실행 연기 등 다양한 방식으로 성능을 개선할 수 있는 방법을 살펴보는 환상적인 사례 연구입니다. 얼마 전에 웹 성능을 시작하기 위한 목록을 작성했지만 이 문서는 앱 측면으로 훨씬 더 자세히 들어가 있습니다. 사용자가 필요한 JavaScript만 로드하고 있는지 확인하고 가능한 한 신속하게 작업을 수행합니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/06/notion.png?fit=1024%2C674&ssl=1)

나는 이 작품이 콘셉트 팀에 빠져서 이반이 어떻게 일을 더 잘할 수 있을지에 대해 자랑하고 싶지 않다는 것을 좋아한다. 항상 개선의 여지가 있고 건설적인 피드백이 누군가를 설득하는 것보다 낫다. 잘하면서 일을 빨리 만든다고 하는군요!

직접 링크 →