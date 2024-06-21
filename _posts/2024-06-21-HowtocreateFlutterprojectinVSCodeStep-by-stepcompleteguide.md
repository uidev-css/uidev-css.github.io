---
title: "VS Code에서 Flutter 프로젝트 만드는 방법  단계별 완벽 가이드"
description: ""
coverImage: "/assets/img/2024-06-21-HowtocreateFlutterprojectinVSCodeStep-by-stepcompleteguide_0.png"
date: 2024-06-21 21:30
ogImage: 
  url: /assets/img/2024-06-21-HowtocreateFlutterprojectinVSCodeStep-by-stepcompleteguide_0.png
tag: Tech
originalTitle: "How to create Flutter project in VS Code| Step-by-step complete guide"
link: "https://medium.com/@kamranktk807/how-to-create-flutter-project-in-vs-code-step-by-step-complete-guide-466e22b235ef"
---


![image](/assets/img/2024-06-21-HowtocreateFlutterprojectinVSCodeStep-by-stepcompleteguide_0.png)

새로운 Flutter 프로젝트를 Visual Studio Code 내에서 생성하는 단계별 가이드를 제공합니다:

시작하기 전에, 머신에 Flutter 및 Dart SDK가 설치되어 있는지 확인하세요. 공식 Flutter 웹사이트에서 다운로드하고 운영 체제에 맞는 설치 지침을 따를 수 있습니다.

![image](/assets/img/2024-06-21-HowtocreateFlutterprojectinVSCodeStep-by-stepcompleteguide_1.png)

<div class="content-ad"></div>

만약 Visual Studio Code가 설치되어 있지 않다면, 공식 웹사이트에서 다운로드하여 설치해주세요: go

Visual Studio Code를 실행한 다음, 창 옆의 활동 표시줄에서 확장 아이콘을 클릭하여 확장 보기로 이동합니다. "Flutter"와 "Dart" 확장 프로그램을 검색하여 설치하세요. 이러한 확장 프로그램은 Flutter 개발을 위한 언어 지원 및 추가 도구를 제공합니다.

<img src="/assets/img/2024-06-21-HowtocreateFlutterprojectinVSCodeStep-by-stepcompleteguide_2.png" />

이제 모든 준비가 끝났으므로 새로운 Flutter 프로젝트를 생성할 수 있습니다:

<div class="content-ad"></div>

- Visual Studio Code를 열어주세요.
- 상단 메뉴에서 "View"를 클릭한 후 "Command Palette..."를 선택해주세요(또는 Windows/Linux에서는 Ctrl+Shift+P, macOS에서는 Cmd+Shift+P 단축키를 사용할 수 있습니다).

![이미지](/assets/img/2024-06-21-HowtocreateFlutterprojectinVSCodeStep-by-stepcompleteguide_3.png)

- Command Palette에 "Flutter: New Project"를 입력하고 해당 옵션이 나타나면 선택해주세요.

![이미지](/assets/img/2024-06-21-HowtocreateFlutterprojectinVSCodeStep-by-stepcompleteguide_4.png)

<div class="content-ad"></div>

- "Flutter: New Project"을 선택한 후 프로젝트 유형을 선택하라는 메시지가 표시됩니다. 표준 Flutter 프로젝트를 위해 "Flutter Application"을 선택할 수 있습니다.

![image](/assets/img/2024-06-21-HowtocreateFlutterprojectinVSCodeStep-by-stepcompleteguide_5.png)

- 이후 새 프로젝트를 생성할 위치를 선택하고 이름을 제공하세요. 프로젝트 파일에 쓰기 권한이 있는 위치를 선택하고 쉽게 프로젝트 파일에 액세스할 수 있는 곳을 선택하세요.

VS Code가 대신 새 Flutter 프로젝트를 생성할 것입니다. 이 작업에는 필요한 종속성을 다운로드하고 초기 프로젝트 구조를 설정하는 데 시간이 걸릴 수 있습니다.

<div class="content-ad"></div>

프로젝트가 생성되면 VS Code가 자동으로 프로젝트 폴더를 엽니다. 여기에 프로젝트 파일과 폴더가 나타납니다.

Flutter 앱을 실행하려면 에뮬레이터/시뮬레이터 또는 실제 기기가 필요합니다.

에뮬레이터/시뮬레이터:

- Android 에뮬레이터: Android를 타겟팅하는 경우, Android Studio가 설치되어 있는지 확인하고 AVD Manager에서 Android 에뮬레이터를 설정할 수 있습니다.
- iOS 시뮬레이터: iOS를 타겟팅하는 경우, Xcode를 사용하여 iOS 시뮬레이터를 설정할 수 있습니다.

<div class="content-ad"></div>

피지컬 디바이스:

- 안드로이드와 iOS 모두 USB를 이용해 컴퓨터에 피지컬 디바이스를 연결할 수 있어요. Android 디바이스의 경우 USB 디버깅이 활성화되어 있는지 확인해 주세요.

Flutter 앱을 실행하는 두 가지 방법이 있어요,

첫 번째 방법:

<div class="content-ad"></div>

아래는 마크다운 형식으로 지정되었습니다.


![이미지](/assets/img/2024-06-21-HowtocreateFlutterprojectinVSCodeStep-by-stepcompleteguide_6.png)

노트: main.dart 파일에서 작업 중인지 확인하세요.

두 번째 방법:

터미널을 열고 flutter run 명령을 실행한 후 Enter 키를 누릅니다.


<div class="content-ad"></div>

<img src="/assets/img/2024-06-21-HowtocreateFlutterprojectinVSCodeStep-by-stepcompleteguide_7.png" />

이제 선택한 기기(에뮬레이터 또는 실제 장치)에서 플러터 앱이 실행 중입니다. 앱을 실제 애플리케이션처럼 상호 작용할 수 있으며 코드를 변경하면 자동으로 핫 리로드되어 변경 사항을 즉시 확인할 수 있습니다.

새 플러터 프로젝트를 설정하고 실행한 후에 앱 개발을 시작할 수 있습니다! Visual Studio Code의 코드 자동 완성, 디버깅 및 통합 터미널과 같은 강력한 기능을 활용하여 개발 프로세스를 원할하고 효율적으로 만들어 보세요.

그게 다예요! 이제 Visual Studio Code 내에서 새 플러터 프로젝트를 성공적으로 만들고 앱 개발을 시작했습니다. 멋진 플러터 애플리케이션을 개발하는 재미를 느껴보세요! 추가 질문이 있거나 도움이 필요하면 언제든지 물어보세요. 즐거운 코딩하세요!