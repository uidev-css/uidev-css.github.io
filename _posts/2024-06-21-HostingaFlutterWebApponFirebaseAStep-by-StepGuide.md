---
title: "Firebase로 Flutter 웹 앱 호스팅하기 단계별 가이드"
description: ""
coverImage: "/assets/img/2024-06-21-HostingaFlutterWebApponFirebaseAStep-by-StepGuide_0.png"
date: 2024-06-21 23:36
ogImage: 
  url: /assets/img/2024-06-21-HostingaFlutterWebApponFirebaseAStep-by-StepGuide_0.png
tag: Tech
originalTitle: "Hosting a Flutter Web App on Firebase: A Step-by-Step Guide"
link: "https://medium.com/@yawarosman/hosting-a-flutter-web-app-on-firebase-a-step-by-step-guide-46a8bc2f0a5b"
---


<img src="/assets/img/2024-06-21-HostingaFlutterWebApponFirebaseAStep-by-StepGuide_0.png" />

Flutter은 개발자가 크로스 플랫폼 애플리케이션을 만드는 방식을 혁신했습니다. 이는 모바일 및 웹 플랫폼 모두에 대해 원활한 경험을 제공합니다. 웹 개발자들에게는 다양한 호스팅 옵션을 고려할 때 플러터 웹 앱을 호스팅하는 것이 어려울 수 있습니다. 그 중에서도 Firebase는 견고하고 개발자 친화적인 선택지로 빛을 발합니다. 이 글에서는 Firebase에서 플러터 웹 앱을 호스팅하기 위한 단계를 안내하겠습니다. 이를 통해 원활하고 성공적인 배포를 보장합니다.

# 단계 1: 플러터 웹 앱 설정하기

Firebase로 진입하기 전에 플러터 웹 앱이 배포 준비가 되어 있는지 확인하세요. 즉, 앱을 철저히 테스트하여 버그가 없고 최상의 성능을 발휘하는지 확인해야 합니다.

<div class="content-ad"></div>

- 앱 개발하기: 먼저 플러터 웹 앱을 만들어 보세요. 플러터가 처음이라면 시작하는 데 도움이 되는 다양한 리소스가 있습니다.
- 앱 테스트하기: 앱이 예상대로 원활하게 실행되는지 확인하세요. 플러터는 이 프로세스를 돕는 테스트 도구를 제공합니다.

# 단계 2: Firebase 도구 설치하기

Firebase 도구는 Firebase 프로젝트를 배포하고 관리하는 데 도움이 되는 명령줄 도구입니다.

- Node.js 설치: Firebase 도구는 Node.js를 필요로 합니다. nodejs.org에서 다운로드하여 설치하세요.
- Firebase 도구 설치: 명령 프롬프트 또는 터미널을 열고 npm install -g firebase-tools를 실행하세요. 이 명령은 Firebase 명령줄 도구를 전역적으로 설치합니다.

<div class="content-ad"></div>

# 단계 3: Firebase 프로젝트 만들기

- Firebase 콘솔로 이동: Firebase 콘솔로 이동합니다.
- 새 프로젝트 만들기: 화면 안내에 따라 새 Firebase 프로젝트를 만듭니다. 이 프로젝트는 당신의 Flutter 웹 앱을 위한 홈이 될 것입니다.

# 단계 4: Firebase 및 Flutter 설정

Firebase 프로젝트를 만든 후에, Flutter 앱과 연결해야 합니다.

<div class="content-ad"></div>

- 프로젝트에서 Firebase를 초기화하세요: 프로젝트 디렉토리에서 firebase init를 실행하세요.
- Hosting 선택: 안내를 받으면 'Hosting' 옵션을 선택하거나 아래의 두 호스팅 옵션 중 선택하세요:

![이미지](/assets/img/2024-06-21-HostingaFlutterWebApponFirebaseAStep-by-StepGuide_1.png)

- 기존 프로젝트 사용 또는 새 프로젝트를 만들려면 새로 만들어지는 새 프로젝트를 선택하고 나머지 지침을 따르세요.
- 방금 Firebase 콘솔에서 만든 프로젝트를 지정하세요.
- 그런 다음 다음과 같이 진행하세요:

![이미지](/assets/img/2024-06-21-HostingaFlutterWebApponFirebaseAStep-by-StepGuide_2.png)

<div class="content-ad"></div>

- 그런 다음 `Set up automatic builds and deploys with GitHub?`이라는 옵션을 보고 만일 당신이 Github에 코드를 푸시할 때 자동으로 웹사이트를 재배포하고 싶다면 Y를 입력하고, 그렇지 않다면 N을 입력하세요.

# 단계 5: Flutter 웹 앱 빌드하기

배포하기 전에, Flutter 웹 앱의 릴리스 버전을 빌드해야 합니다.

- 빌드 명령 실행: 터미널에서 flutter build web 명령을 실행하세요. 이 명령은 앱을 배포 가능한 웹 형식으로 컴파일합니다.

<div class="content-ad"></div>

# 단계 6: Firebase로 배포하기

앱을 구축하고 Firebase를 구성했으면 배포할 준비가 되었습니다.

- 앱을 배포하세요: 프로젝트 디렉토리에서 firebase deploy를 실행하십시오. 이 명령은 구축된 앱을 Firebase Hosting에 업로드합니다.
- 앱에 액세스하기: 배포가 완료되면 Firebase가 웹 앱에 액세스할 수 있는 URL을 제공합니다.

# 단계 7: 앱 관리 및 업데이트하기

<div class="content-ad"></div>

파이어베이스는 앱 사후 배포를 관리하기 위한 다양한 도구를 제공합니다.

- 성능 모니터링: 파이어베이스의 분석 도구를 사용하여 사용자 참여 및 앱 성능을 추적합니다.
- 앱 업데이트: 간단히 flutter build web로 앱을 다시 빌드하고 firebase deploy를 실행하여 업데이트할 수 있습니다.

# 결론

파이어베이스를 사용하면 Flutter 웹 앱을 호스팅하는 것이 직관적인 프로세스로 개발자들에게 다양한 기회를 제공합니다. 파이어베이스를 통해 앱을 호스팅할 뿐만 아니라 분석, 데이터베이스 관리 등의 기타 기능도 활용할 수 있습니다. 이러한 단계를 따라 Flutter 웹 앱을 파이어베이스에 호스팅하여 전세계 사용자가 액세스할 수 있도록 준비시킬 수 있습니다. 즐거운 코딩하세요!

<div class="content-ad"></div>

yawarosman.com