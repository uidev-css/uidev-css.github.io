---
title: "비주얼 스튜디오 코드에서 Flutter 설정하기 단계별 가이드"
description: ""
coverImage: "/assets/img/2024-06-20-SettingUpFlutterinVisualStudioCodeAStep-by-StepGuide_0.png"
date: 2024-06-20 13:54
ogImage: 
  url: /assets/img/2024-06-20-SettingUpFlutterinVisualStudioCodeAStep-by-StepGuide_0.png
tag: Tech
originalTitle: "Setting Up Flutter in Visual Studio Code: A Step-by-Step Guide"
link: "https://medium.com/@hanansani2002/setting-up-flutter-in-visual-studio-code-a-step-by-step-guide-1c64450728a7"
---


# 소개:

플러터(Flutter)는 구글의 오픈소스 UI 툴킷으로, 크로스 플랫폼 앱 개발에 대한 인기 있는 선택지가 되었습니다. 플러터의 모든 기능을 활용하기 위해서는 코딩 프로세스를 최적화하는 개발 환경을 설정하는 것이 중요합니다. Visual Studio Code(VSCode)는 가벼우면서도 강력한 코드 편집기로 플러터와 완벽하게 통합되어 풍부한 기능의 애플리케이션을 구축하는 데 견고한 환경을 제공합니다. 본 문서에서는 Visual Studio Code에서 플러터를 설정하는 단계별 프로세스를 안내합니다.

# 필수 조건:

설정 프로세스에 들어가기 전에 시스템에 다음 필수 조건이 설치되어 있는지 확인하세요:

<div class="content-ad"></div>

1. Flutter SDK:
공식 Flutter 웹사이트 (https://flutter.dev/docs/get-started/install)에서 Flutter SDK를 다운로드하고 설치해주세요.

2. Dart SDK:
Flutter는 Dart 프로그래밍 언어에 의존합니다. Dart SDK를 Dart SDK 다운로드 페이지 (https://dart.dev/get-dart)에서 다운로드하고 설치해주세요.

3. Visual Studio Code:
아직 설치하지 않았다면, 공식 VSCode 웹사이트 (https://code.visualstudio.com/)에서 Visual Studio Code를 다운로드하고 설치해주세요.

위 사항을 모두 설치한 후, 다음 단계를 따라 Visual Studio Code에서 Flutter를 설정해주세요:

<div class="content-ad"></div>

단계 1: 플러터 익스텐션 설치하기

Visual Studio Code를 열고, 창의 측면에 있는 활동 표시줄의 익스텐션 아이콘을 클릭하거나 단축키 `Ctrl+Shift+X`를 사용하여 익스텐션 뷰로 이동합니다.

익스텐션 뷰 검색 창에서 "Flutter"를 검색합니다. Dart Code 팀에서 발행한 공식 플러터 익스텐션을 찾습니다. 설치 버튼을 클릭하여 익스텐션을 설치합니다.

단계 2: Dart SDK 설치하기

<div class="content-ad"></div>

비슷하게, 확장 프로그램 보기 검색 창에서 "Dart"를 검색하고 Dart 확장 프로그램을 설치하세요. 이 확장 프로그램은 Flutter가 구축된 Dart 프로그래밍 언어를 지원합니다.

단계 3: Flutter SDK 경로 설정

Flutter 확장 프로그램을 설치한 후에는 `Ctrl+Shift+P` (Windows/Linux) 또는 `Cmd+Shift+P` (Mac)를 눌러 명령 팔레트를 열고 `Flutter: Select Flutter SDK` 명령을 실행해주세요. Flutter SDK를 설치한 경로를 선택하세요.

단계 4: 새로운 Flutter 프로젝트 만들기

<div class="content-ad"></div>

이제 플러터 환경이 설정되었으니 새 플러터 프로젝트를 만들어 보세요. 명령 팔레트를 열고 (`Ctrl+Shift+P` 또는 `Cmd+Shift+P`) `Flutter: New Project` 명령을 실행하세요. 프로젝트 이름과 위치를 지정하는 프롬프트에 따라 진행하면 됩니다.

단계 5: VSCode에서 프로젝트 열기

새로 만든 플러터 프로젝트 폴더를 Visual Studio Code에서 열어보세요. “파일” > “폴더 열기”를 선택하고 플러터 프로젝트를 생성한 폴더를 선택하면 됩니다.

단계 6: 플러터 앱 실행

<div class="content-ad"></div>

VSCode에서 터미널을 열어주시고 (`보기` > `터미널 또는` `Ctrl+`` `) `cd` 명령어를 사용하여 프로젝트 폴더로 이동한 다음 다음 명령어를 실행해주세요:

이 명령어는 연결된 에뮬레이터나 장치에서 Flutter 앱을 빌드하고 실행할 것입니다.

# 결론:

Visual Studio Code에서 Flutter를 설정하는 것은 개발 경험을 크게 향상시키는 간단한 프로세스입니다. Flutter 및 Dart 확장 기능을 사용하면 강력한 도구, 디버깅 기능, 그리고 크로스 플랫폼 응용 프로그램을 쉽게 작성할 수 있는 다채로운 기능에 액세스할 수 있습니다. 이 단계별 안내에 따라 Visual Studio Code에서 생산적인 Flutter 개발 환경을 구축했습니다. 즐거운 코딩되세요!