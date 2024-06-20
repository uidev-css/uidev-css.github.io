---
title: "네스트JS 소개 개념부터 초기 설정까지"
description: ""
coverImage: "/assets/img/2024-06-19-IntroductiontoNestJSFromConcepttoInitialSetup_0.png"
date: 2024-06-19 08:21
ogImage: 
  url: /assets/img/2024-06-19-IntroductiontoNestJSFromConcepttoInitialSetup_0.png
tag: Tech
originalTitle: "Introduction to NestJS: From Concept to Initial Setup"
link: "https://medium.com/@aazimanishgdev/introduction-to-nestjs-from-concept-to-initial-setup-7bd6ae0eb96a"
---


![NestJS 이미지](/assets/img/2024-06-19-IntroductiontoNestJSFromConcepttoInitialSetup_0.png)

# 소개

NestJS의 세계에 오신 걸 환영합니다! 강력하고 확장 가능한 프레임워크를 찾는 개발자라면 효율적인 Node.js 서버 측 애플리케이션을 구축할 수 있는 곳에 왔습니다. Nest (NestJS)는 TypeScript를 완전히 지원하며 TypeScript를 사용해 본적이 없는 분들도 환영합니다. Object-Oriented Programming (OOP), Functional Programming (FP), 그리고 Functional Reactive Programming (FRP)의 가장 좋은 측면을 결합한 프레임워크입니다. 흥미로우신가요? 함께 알아봅시다! 🌊

NestJS는 Express (기본)와 Fastify와 같은 튼튼한 HTTP 서버 프레임워크 위에서 작동합니다. 이 프레임워크를 추상화하면서 여전히 API에 액세스할 수 있도록 제공하므로 강력한 프레임워크와 타사 모듈을 사용할 수 있는 자유를 함께 제공합니다.

<div class="content-ad"></div>

# 왜 NestJS를 선택해야 하나요? 🚀

JavaScript는 Node.js 덕분에 웹 개발에 가장 많이 사용되는 언어가 되었습니다. 이것은 Angular, React, Vue와 같은 훌륭한 프론트엔드 프레임워크의 등장으로 이어졌습니다. 그러나 백엔드 아키텍처에서는 약간 까다로운 면이 있습니다. 많은 라이브러리와 도구가 존재하지만, 확고한 아키텍처 기반을 제공하는 것은 몇 안됩니다. 이때 NestJS가 등장합니다. Angular에서 영감을 받아 만들어진 NestJS는 애플리케이션 아키텍처를 즉시 제공하여 애플리케이션을 높은 수준으로 테스트할 수 있고, 확장 가능하며, 유지보수하기 쉽게 만들어줍니다.

# NestJS로 시작하기

첫 번째 NestJS 프로젝트를 설정하는 것은 아주 쉽습니다. 우리는 NestJS의 기본 구축 블록에 익숙해지도록하는 기본 CRUD 애플리케이션 생성 과정을 안내해 드리겠습니다.

<div class="content-ad"></div>

# 준비물 🛠️  

시작하기 전에 해당 운영 체제에 Node.js(버전 `= 16)가 설치되어 있는지 확인하세요. 공식 웹사이트에서 다운로드할 수 있습니다.

## 스텝 1: Nest CLI 설치  

가장 먼저 Nest CLI를 설치해보겠습니다. Nest CLI는 NestJS 프로젝트의 구조를 만들고 관리하는 강력한 명령줄 도구입니다.

<div class="content-ad"></div>

```js
npm install -g @nestjs/cli
```

## 단계 2: 새 프로젝트 생성하기

Nest CLI를 설치했으면 새 프로젝트를 만드는 것은 간단합니다. 터미널에서 다음 명령을 실행하세요:

```js
nest new project-name
```

<div class="content-ad"></div>

당신은 패키지 관리자(npm 또는 yarn)를 선택하라는 프롬프트를 받게 될 거예요. 당신이 좋아하는 것을 선택하면, CLI가 새로운 NestJS 프로젝트를 설정해 줄 거에요. 더 엄격한 TypeScript 설정을 위해, --strict 플래그를 추가할 수도 있어요:

## 단계 3: 프로젝트 구조 살펴보기 📂

새로운 프로젝트 디렉토리로 이동해 보세요:

```js
cd 프로젝트명
```

<div class="content-ad"></div>

귀하의 프로젝트 구조는 다음과 같이 보일 것입니다:

```js
src/
├── app.controller.spec.ts
├── app.controller.ts
├── app.module.ts
├── app.service.ts
└── main.ts
```

다음은 이러한 핵심 파일에 대한 간단한 설명과 실제 예제입니다:

![이미지](/assets/img/2024-06-19-IntroductiontoNestJSFromConcepttoInitialSetup_1.png)

<div class="content-ad"></div>

- app.controller.ts - 커피숍에서 브리스타: 커피숍에 들어가 라떼를 주문한다고 상상해보세요. 카운터에 있는 브리스타는 여러분의 요청을 듣고 주문을 처리합니다. 우리 NestJS 애플리케이션에서 app.controller.ts는 이 브리스타 역할을 합니다. 클라이언트(고객)로부터 HTTP 요청을 받아 처리하고 적절한 응답을 반환합니다.
- app.controller.spec.ts - 브리스타를 평가하는 익명 쇼핑고객: 익명 쇼핑고객이 커피숍을 방문하여 브리스타의 성능을 평가하며 주문이 올바르게 처리되고 효율적으로 진행되는지 확인합니다. 우리 NestJS 애플리케이션에서 app.controller.spec.ts에는 컨트롤러(브리스타)가 기대한 대로 작동하는지 확인하는 테스트가 포함되어 있습니다.
- app.module.ts - 커피숍 매니저가 부서를 조직하는 역할: 커피숍 매니저는 부서(주방, 카운터, 배달)가 원활하게 협력하도록 보장합니다. 우리 NestJS 애플리케이션에서 app.module.ts는 매니저처럼 다양한 모듈을 조직하고 관리하는 역할을 합니다.
- app.service.ts - 커피를 내리는 브리스타: 카운터의 브리스타가 주문을 받은 후, 주방의 브리스타가 라떼를 만들기 시작합니다. 우리 NestJS 애플리케이션에서 app.service.ts는 이 백그라운드 작업을 대변합니다. 요청을 수행하기 위해 필요한 비즈니스 로직과 프로세스가 포함되어 있습니다.
- main.ts - 커피숍 개장: 고객이 들어와 주문을 하기 위해 커피숍이 영업을 시작해야 합니다. 우리 NestJS 애플리케이션에서 main.ts는 오프닝 절차처럼 애플리케이션을 부팅하고 서버를 시작하여 들어오는 요청을 수신하는 역할을 합니다.

이 파일들은 NestJS 애플리케이션의 기반을 형성하며, 각각이 특정 역할을 수행하여 원활한 작동과 모듈식 구조를 보장합니다. 이러한 구성 요소와 역할에 대해 더 자세히 살펴볼 것이며, 향후 블로그 포스트에서 소개할 예정입니다. 기대해 주세요!

## 단계 4: 애플리케이션 실행하기 🏃

NestJS 애플리케이션을 실행하려면 다음 명령어를 사용하세요:

<div class="content-ad"></div>

```js
npm run start
```

기본적으로 애플리케이션이 http://localhost:3000에서 실행됩니다. 브라우저를 열고 이 URL로 이동하세요. "Hello World!" 메시지가 표시되면 NestJS 애플리케이션이 제대로 실행 중임을 확인할 수 있습니다.

보다 빠른 개발을 위해 다음을 사용하세요:

```js
npm run start:dev
```

<div class="content-ad"></div>

당신이 파일을 감시하고 변경 사항을 감지할 때마다 자동으로 다시 컴파일하고 서버를 다시로드합니다.

## 단계 5: 린팅 및 형식 지정 📏

Nest 프로젝트에는 코드 린터 (eslint)와 코드 포매터 (prettier)가 미리 설치되어 있어 코드베이스를 깨끗하고 일관되게 유지하는 데 도움이 됩니다.

코드를 린팅하려면:

<div class="content-ad"></div>

```js
npm run lint
```

코드를 포맷하려면:

```js
npm run format
```

# 결론 🎉


<div class="content-ad"></div>

그럼 이제 완료되었습니다! 첫 번째 NestJS를 설정했습니다.