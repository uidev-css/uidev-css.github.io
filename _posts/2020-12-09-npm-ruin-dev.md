---
layout: post
title: "npm 망치 개발
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/12/Screen-Shot-2020-12-09-at-7.52.47-AM.png
tags: BUILD TOOL,DEPENDENCIES
---


2020 년에 저는 HTML, CSS 및 JavaScript로 웹 사이트를 구축하는 즐거움을 재발견했습니다. 트랜스 파일도, 컴파일도없고, 키보드에 손을 대는 것 외에는 빌드 도구도 없습니다.
 

CSS는 최근 몇 년 동안`calc ()`및 사용자 정의 속성과 같은 기능을 통해 많이 발전하여 Sass와 같은 전처리기를 사용할 필요가 없습니다.
 그리고 바닐라 JavaScript는 강력하고 모든 기능을 갖추고 있으며 컴파일없이 브라우저에서 작동합니다.
 

오해하지 마세요. 복잡한 웹 사이트에 복잡한 파이프 라인이 필요한 이유를 완전히 이해합니다.
 대규모 팀의 일원이라면 모든 사람이 일관된 방식으로 코드베이스에 기여할 수 있도록 프로세스를 마련해야 할 것입니다.
 코드베이스가 복잡할수록 작업을 자동화하고 오류가 발생하기 전에 오류를 포착하는 데 도움이되는 기술이 더 많이 필요합니다.
 

그러나 이러한 설정이 모든 웹 사이트에 적합한 것은 아닙니다.
 그리고 시간을 절약해야하는 모든 도구와 프로세스는 때때로 시간을 더 낭비하게됩니다.
 6 개월 또는 12 개월 후에 프로젝트를 다시 방문해야했던 적이 있습니까?
 CSS를 조금만 변경하고 싶을 수도 있습니다.
 하지만 의존성이 깨져서 그렇게 할 수 없습니다.
 그래서 당신은 그것을 업데이트하려고합니다.
 그러나 다른 버전의 Node.js에 의존합니다.
 알기 전에 전구를 바꾸는 Bryan Cranston입니다.
 CSS 한 줄을 수정해야하지만 대신 엔트로피와 싸우고 있습니다.
 

프론트 엔드 개발에서 문제를 해결할 때마다 최소 전력 원칙을 적용하는 것을 좋아합니다. 주어진 목적에 적합한 가장 덜 강력한 언어를 선택하는 것입니다.
 고전적인 예는 ARIA 및 JavaScript의 래싱이있는 div를 사용하여 버튼의 모든 기본 기능을 다시 생성하는 대신 간단한 HTML 버튼 요소를 사용하는 것입니다.
 올해는이 원칙이 빌드 도구에도 적용된다는 것을 깨달았습니다.
 

기본적으로 모든 노래를 부르는 올 댄싱 도구 체인에 도달하는 대신 지루한 기준부터 시작하겠습니다.
 그것이 너무 고통 스럽거나 다루기 힘들어지면 나는 작업 관리자를 던질 것입니다.
 하지만 종속성을 추가 할 때마다 프로젝트의 수명이 제한됩니다.
 

2021 년 새해 결심은 다이어트를하는 것입니다.
 더 이상 무거운`node_modules` 폴더가 없습니다.
 바삭하고 맛있는 HTML, CSS 및 JavaScript.
 