---
layout: post
title: "Google의 데이터 비교 및 Netlifify Analytics"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/08/analytics-chart-line.png
tags: ANALYTICS,GOOGLE ANALYTICS,NETLIFY
---


짐 닐슨:

> 데이터셋이 저한테는 가깝지도 않았어요

Google Analytics는 사이트에 클라이언트 측 JavaScript 비트를 설치하는 방식으로 작동합니다. Netlifify Analytics는 서버 로그 측면을 구문 분석하여 작동합니다. 그들은 사실 사과에 대한 사과가 아니다. 구글 분석(Google Analytics)은(는) 사이트에 대한 매우 중요한 분석 데이터인 사용자 정의 이벤트 추적과 같은 작업을 수행할 수 있습니다. 하지만 둘 다 기본이 있어요. 예를 들어, 두 사람 모두 당신의 홈페이지가 얼마나 많은 페이지뷰를 얻었는지 알려주려고 한다.

이러한 숫자에 영향을 미치는 두 가지 중요한 요소가 있습니다.

- 클라이언트 측 JavaScript는 차단이 가능하며, 특히 Google의 타사 스크립트에 많은 사람들이 콘텐츠 차단기를 사용합니다. 서버측 로그는 차단할 수 없습니다.
- Netlifify는 로그에서 항목을 필터링하지 않습니다. 즉, 봇이 일반 방문자 외에도 계산된다는 의미입니다.

그래서 저는 이렇게 말하고 싶습니다. Netlifify는 아마도 더 정확한 숫자를 가지고 있을 것입니다. 하지만 봇으로부터 약간 부풀려졌습니다.

또한 서버측 Google Analytics를 사용할 수 있습니다. 실제로 하는 사람은 본 적이 없지만 좋은 생각인 것 같아요.

짐의 조언 하나:

> 단일 데이터 집합에서 너무 많은 것을 가정하지 마십시오. 다시 말해, 하나의 바스켓에서 모든 데이터 중심 통찰력을 끌어내지 마십시오.

직접 링크 →