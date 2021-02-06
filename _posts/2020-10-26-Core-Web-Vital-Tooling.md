---
layout: post
title: "핵심 웹 필수 도구
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/10/Screen-Shot-2020-10-22-at-4.24.48-PM.png
tags: CORE WEB VITALS,DEVTOOLS,LIGHTHOUSE,PERFORMANCE
---


Google에서 개발 한 Core Web Vitals는 여전히 똑똑하다고 생각합니다.
 처음 성능에 신경을 썼을 때는 요청을 줄이십시오!
 캐시 물건!
 물건을 작게 만드세요!
 그리고 그것들은 모두 웹 성능과 매우 관련이 있지만 추상적으로 관련되어 있습니다.
 사용자에 대한 실제 웹 성능은 페이지의 콘텐츠를보기 위해 얼마나 기다려야 했습니까?
 양식에 입력하거나 링크를 클릭하는 등 실제로 페이지와 상호 작용할 수있을 때까지 얼마나 걸리나요?
 내가 뭔가를하려고하는 동안 물건이 불쾌하게 뛰었나요?
 이것이 바로 Core Web Vitals가 똑똑한 이유입니다.
 

Chrome DevTools의 Lighthouse 탭에는 다음과 같은 기능이 있습니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/10/Screen-Shot-2020-10-22-at-4.24.48-PM.png?resize=1024%2C456&ssl=1)

사용자가 사이트를 방문한 후 사용자에게 직접적인 혜택을주는 숫자는 제외하고 사용자가 사이트를 방문하는 데 전혀 영향을 미칠 수 있기 때문에 주시하는 것이 좋습니다.
 Web Core Vitals는 SEO 및 이전에 AMP 페이지 전용으로 예약되었던 새로운 캐 러셀 요구 사항을 고려합니다.
 

일회성 감사에서 이러한 숫자를 추적하는 것은 유용하지만 시간이 지남에 따라 실수를 방지하기 위해이를 지켜 보는 것이 더 유용합니다.
 Calibre와 같은 성능 도구가이를 다룹니다.
 New Relic이 가져 왔습니다.
 SpeedCurve가이를 추적합니다.
 

CLS (Cumulative Layout Shift)는 까다로운 것입니다.
 예를 들어 사이트의 기사 상단에 광고가있는 곳입니다.
 해당 광고에 대한 요청은 비동기식이므로 광고가 늦게 들어와 기사의 콘텐츠를 아래로 푸시 할 가능성이 높습니다.
 이는 단순히 성가신 것이 아니라 성능 지표 및 궁극적으로 SEO에 대한 실제적인 영향입니다.
 

Nic Jansma의“Cumulative Layout Shift in Practice”는 심층 분석을 제공합니다.
 

CLS는 단순히 "페이지가 수행합니까?"가 아닙니다.
 위의 그림이 지적했듯이 점수가 있습니다.
 누구에게나 좋은 CLS 버전이 없기 때문에 0이 좋은 목표라고 말하고 싶습니다.
 여기에는 "종합적으로"추적 (예 : 헤드리스 브라우저, 특히 성능 도구) 및 실제 사이트의 실제 사용자 (RUM 또는 실제 사용자 메트릭이라고 함)와 같은 많은 뉘앙스가 있습니다.
 둘 다 유용합니다.
 

싸워야하는 CLS가 있다면 까다로울 수 있습니다.
 SpeedCurve에는 다음과 같은 몇 가지 새로운 도구가 있습니다.
 

> 각 레이아웃 이동에 대해 이동 직전과 직후에 필름 스트립 프레임을 보여줍니다.
 그런 다음 이동 한 요소 주위에 빨간색 상자를 그려 이동을 유발 한 요소를 정확히 강조 표시합니다.
 각 교대조의 레이아웃 이동 점수는 해당 교대조의 영향과 누적 점수에 추가되는 방식을 이해하는데도 도움이됩니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/10/cls_layout_shift.png?resize=1024%2C528&ssl=1)

그렇게하면 뿌리를 내리고 고치는 것이 매우 쉬워 질 것입니다.
 특히 까다로운 것들.
 나는 이것을 몰랐지만 CLS는 Mark Zeman이 포스트에서 지적한 훨씬 더 미묘한 것들로 인해 발생할 수 있습니다.
 예를 들면 :
 

- 수평으로 만 움직이는 이미지 캐 러셀은 CLS를 트리거 할 수 있습니다.
 그것이 그들이해야하는 일이기 때문에 당황 스럽지만 분명히 CSS`transform`으로 만 캐 러셀을 이동하여 속일 수 있습니다.
 
- 지역이 매우 넓다면 이동하기가 더 위험합니다.
 조금만 움직이면 CLS에 많은 영향을 미칩니다.
 
- 스타일이 지정되지 않은 텍스트 플래시 (FOUT)는 CLS의 원인입니다.
 다른 이유로 성능에 좋지만!
 22를 잡아라!
 완벽한 글꼴 대체에 도달하는 것은 좋은 변명입니다.
 

까다 롭지 만 중요한 것들.
 제 CI / CD에 성능 테스트를 넣어야하는데 정말 도움이 될 것입니다.
 웹 성능이 웹 개발의 완전한 직업 하위 장르 인 것처럼 점점 더 많이 느껴집니다.
 프런트 엔드 웹 개발자는이 내용을 이해하고 어느 정도 도움이 필요하지만 이미 할 일이 너무 많습니다.
 