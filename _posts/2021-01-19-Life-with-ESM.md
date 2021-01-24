---
layout: post
title: "ESM과 함께하는 생활"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2018/04/javascript-v4.png
tags: JAVASCRIPT MODULES
---


ES 모듈, JavaScript 모듈을 의미하는 ESM.
 `가져 오기`와 친구들.

요즘 브라우저가 지원합니다.
 많은 뉘앙스가 있지만 IE를 삭제하는 한 문은 상당히 열려 있습니다.

ESM 이전의 JavaScript 프로젝트 상황은 다음과 같습니다.

이제 우리는 ESM을 더 많이 믿을 수있게되었고, 이야기는 다소 바뀌고 있으며, 그 모든 것들이 의문을 제기하고 있습니다.

- `npm install`이 필요하지 않았다면 어떨까요?
- 번 들러가 필요하지 않으면 어떻게합니까?
- HTTP / 2 +, 글로벌 CDN, 멋진 작업을 수행하는 브라우저 등의 성능이 좋으면 어떨까요?
- 다운 컴파일을 너무 많이해서 코드를 너무 많이 컴파일해서는 안된다면 어떨까요?

우리는이 모든 것에 집중하는 차세대 도구를보고 있습니다.
 Snowpack 3이 방금 출시되었으며 다음을보십시오.


<div class="video_wrapper" style="padding-top: 56.25%;">
    <div class="fluid-width-video-wrapper" style="padding-top: 50%;"><video controls="" src="https://css-tricks.com/wp-content/uploads/2021/01/streaming-imports-demo.mp4" name="fitvid0"></video></div>
</div>


그 React (JSX 포함)는 정상적으로 작성되었으며`npm install`,`node_modules` 디렉토리 및 빌드 단계가 없었습니다.
 그러나 여전히 개발 서버 및 다시로드 중입니다.
 너무 가볍습니다.
 매우 상쾌합니다.

최근에 Una와 Chris가 Jason Miller와 WMR에 대해 이야기 한 Toolsday 에피소드를 들었습니다.
 Snowpack / Skypack과 매우 영적으로 비슷합니다.
 WMR을 사용하면 npm 패키지를 설치하지 않고 사용하거나 JSX, TypeScript 또는 CSS 모듈과 같은 것으로 작성하고 서버, 핫 리로딩 등과 같은 다양한 개발 편의성을 얻을 수 있습니다.

여기 물 속에 뭔가 분명히 있고, 뭔가 ESM에 기대어 있다고 생각합니다.

Node.js 측에서도 ESM이 일어나고 있습니다.
 다음은 1,000 개 이상의 npm 패키지 (!)를 보유한 Sindre Sorhus입니다.

> 2021 년 4 월 말에 Node.js 10은 수명이 종료됩니다. 즉, 패키지 관리자가 Node.js 12를 대상으로 할 수 있습니다.이 Node.js 버전은 ESM이라고도하는 JavaScript 모듈을 완벽하게 지원합니다.

그는 거의 모든 1,000 개의 패키지를 2021 년에 ESM으로 옮길 계획입니다. 여러 다른 형식을 출력하는 "이중"설정이 아니라 ESM 뿐이며 모든 사람이 똑같이하도록 권장하고 있습니다.
 브라우저에서 직접 ESM 사용을 향한이 모멘텀은 npm 생태계가 똑같은 일을 할 때 크게 구축 될 것이라고 생각합니다.

예를 들어 npm의 항목이 아직 ESM을 사용할 준비가되어 있지 않아 번들링이 필요한 경우 차세대 번 들러가 빠르게 퍼지고 있습니다.