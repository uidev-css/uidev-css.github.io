---
layout: post
title: "나만의 도구 만들기"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/12/tools.png
tags: DEVTOOLS,FORMS,REACT
---


Wealthfront 블로그의 Spencer Miskoviak :

> 앱에 특정한 사용자 지정 DevTools를 생성하면 훨씬 더 높은 추상화에서 작동하여 사용자 상호 작용 또는 추적 이벤트 디버깅과 같은 작업을 처리 할 수 있습니다.
 이를 위해서는 맞춤형 DevTools를 구축하고 유지해야하지만, 이는 개발을 간소화하기 위해 앱과 엔지니어의 요구에 맞게 조정할 수 있음을 의미합니다.

개발자 팀을위한 맞춤 도구를 구축하는 것이 정말 멋지고 똑똑하다고 생각합니다.
 사용자 정의 도구가 자신만을위한 것이더라도 생산성에 도움이 될 수 있습니다.
 하지만 전체 팀을위한 맞춤 도구를 구축하고 아이디어의 문을 열면 더욱 스마트하고 가치가 더해집니다.

Spencer는 UI 팝업 위젯이라는 우산 아래에있는 다양한 도구를 선보였습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/12/pasted-image-0.png?resize=444%2C523&ssl=1)

- 현재 분기 및 CI 상태 표시
- 양식 작성, 사용자 작업 수행, 사용자 전환
- 구성 요소를 강조

영리한 것들.

CodePen에는 이와 같은 멋진 UI 위젯이 없지만 생산성을 향상시키는 기능이 앱에 뿌려져 있습니다.
 예를 들어 많은 양식에는 개발자에게만 표시되는 미리 채우기 버튼이 있습니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/12/CleanShot-2020-12-31-at-07.34.34.gif?resize=800%2C531&ssl=1)

또한 지원 티켓이 참조하는 사용자 및 콘텐츠에 대한 컨텍스트를 제공하는 지원받은 편지함 용 사용자 지정 도구가 있습니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/12/CleanShot-2020-12-31-at-07.38.07@2x.png?resize=2206%2C1832&ssl=1)

관리자 및 개발자 중심 작업을 수행하기 위해 사이트 자체의 전체 보호 된 관리 영역은 말할 것도 없습니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/12/Screen-Shot-2020-12-31-at-7.43.37-AM.png?resize=1994%2C1504&ssl=1)

Spencer가 말한 "컴포넌트 하이 라이터"가 특히 깔끔하다고 생각합니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/12/side-by-side-1.png?resize=800%2C238&ssl=1)

React DevTools는 현재 페이지의 어떤 부분이 어떤 구성 요소인지 확인하는 데 도움이 될 수 있지만 이와 같은 페이지는 아닙니다.
 VS Code에서 해당 파일을 여는 각 제목 옆에 약간의 🔗이 있으면 멋질 것 같습니다.

자신 만의 도구를 만드는 것에 대해 Shawn Wang은 최근에 "자신 만의 도구를 만들 수 있습니다."라고 썼습니다.

> 최고의 소프트웨어조차도 당신에게 그다지 좋지 않은 부분이 있습니다.
 그러나 당신과 다른 사람들의 차이점은 코딩이 가능하다는 것입니다.

Shawn은 다음과 같은 이야기를합니다.

- 나만의 스타일 시트 만들기
- UI 쿼리 생성기 빌드
- 자신 만의 CLI 구축 (Mina Markham의 dotfile이 생각납니다)
- 자신 만의 프록시 만들기

Shawn은 Google 검색 결과에 대한 자신의 dang 프록시를 작성하여 최적화하고 자신이 좋아하는 방식을 제시했습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/12/56r2dhdtgq8qw3qsi3jo.png?resize=567%2C579&ssl=1)

가끔은 툴링에 집중할 기분이 듭니다. "VS Code Tasks를 사용하여 VS Code 프로젝트를 열 때 Gulp를 실행"하기로 결정했을 때와 같은 작업을 수행하게됩니다.
 이상한 문제를 겪고 있습니다.
 저는 회사의 훌륭한 DevOps 직원이 이와 같은 모든 일을 끝낼 것이라고 생각합니다. 항상 자신의 직원을위한 개발자 경험을 생각합니다.

나는 시간을 절약하기 위해 얼마 전에 내가 플레이하는 텍스트 기반 멀티 플레이어 비디오 게임의 오프닝을 스크립트로 작성하기도했습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/12/Screen-Shot-2020-12-31-at-7.56.06-AM.png?resize=669%2C330&ssl=1)

일반적으로 자신 만의 도구를 구축하는 것에 대해 말하자면, Dick Proenneke의 Alone in the Wilderness 다큐멘터리가 생각납니다.
 이 인트로 클립에서 Dick이 말 그대로 건물 도구에 대해 이야기하는 것을들을 수 있습니다. 도구를 알래스카 야생으로 깊숙이 운반 할 필요가 없었기 때문에 유용했습니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/12/Screen-Shot-2020-12-31-at-8.01.24-AM.png?resize=660%2C379&ssl=1)

🛠