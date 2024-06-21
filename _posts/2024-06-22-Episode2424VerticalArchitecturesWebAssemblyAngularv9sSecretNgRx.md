---
title: "웹 어키텍처 혁신 WebAssembly, Angular v9의 비밀과 NgRx 활용 방법 24화"
description: ""
coverImage: "/assets/img/2024-06-22-Episode2424VerticalArchitecturesWebAssemblyAngularv9sSecretNgRx_0.png"
date: 2024-06-22 00:23
ogImage: 
  url: /assets/img/2024-06-22-Episode2424VerticalArchitecturesWebAssemblyAngularv9sSecretNgRx_0.png
tag: Tech
originalTitle: "Episode 24 24: Vertical Architectures, WebAssembly, Angular v9’s Secret, NgRx"
link: "https://medium.com/ng-news/episode-24-24-vertical-architectures-webassembly-angular-v9s-secret-ngrx-a96636b275b9"
---


![Episode2424VerticalArchitecturesWebAssemblyAngularv9sSecretNgRx_0](/assets/img/2024-06-22-Episode2424VerticalArchitecturesWebAssemblyAngularv9sSecretNgRx_0.png)

브랜든 로버츠는 왜 Angular 9가 가장 높은 다운로드율을 보이는지를 공개했습니다. 만프레드 스테이어는 수직 구조에 대해 이야기했습니다. Evgeniy Tuboltsev는 Angular에서 WebAssembly를 통합하는 방법에 대한 안내서를 게시했으며, NgRx 18가 릴리스되었습니다.

# 수직 구조

Angular 커뮤니티 미팅에서 만프레드 스테이어가 Angular에서 DDD에 대한 강화 버전을 소개했습니다.

<div class="content-ad"></div>

그는 다른 작업을 담당하는 네 가지 유형의 팀이 존재하는 팀 토폴로지 모델에 대해 언급했습니다:

1. 플랫폼 서비스 팀
2. 전문화 팀
3. 지원 팀
4. 가치 흐름 팀

## NgRx 18

NgRx는 Angular에서 가장 인기 있는 상태 관리 라이브러리로, v18에서 발표되어 Angular 18과 호환되게 되었습니다.

<div class="content-ad"></div>

신호 스토어를 사용하려면 주의하세요. 나중에 **안정화**되고 아직 릴리스되지 않았습니다.

Angular 18에서 사용하려면 `npm i @ngrx/signals@next`를 실행하거나 스키매틱(또한 `next` 태그 사용)을 사용하세요.

# Angular 9 뒤의 비밀

현재 Angular은 주간 약 350만 번 다운로드되어 React와 Vue에 이어 세 번째로 가장 많이 다운로드되는 프레임워크입니다.

<div class="content-ad"></div>

앵귤러 9가 45만 회 다운로드되었다고 합니다. 현재 버전이 18인데, 그것은 조금 이상하네요.

브랜든 로버츠가 발견했는데, 앵귤러 9는 코들라이저의 의존성입니다. 코들라이저는 타입스크립트 ESLint가 나오기 전에 우리가 사용한 라이브러리입니다.

코들라이저는 많은 애플리케이션에 포함되어 있을 가능성이 매우 높지만, 활성적으로 사용되지는 않고 있으므로 개발자들은 제거해야 할 것입니다.

통계에 따르면, 코들라이저의 현재 다운로드 수는 60만 회입니다.

<div class="content-ad"></div>

코드라이저가 없다면 Angular의 다운로드 수는 17% 떨어질 것입니다.

# 웹어셈블리 & 앵귤러

웹어셈블리는 자바스크립트보다 다른 언어로 작성된 응용 프로그램을 브라우저에서 실행할 수 있게 해줍니다. 게다가 실행 속도는 거의 네이티브 코드와 비슷합니다.

Evgeniy Tuboltsev가 러스트로 작성된 응용 프로그램을 웹어셈블리로 이식하고 Angular에서 사용하는 방법을 보여준 기사를 썼습니다. 비교해보면, 그의 예시는 자바스크립트와 비교했을 때 세 배 빠르게 실행됩니다.