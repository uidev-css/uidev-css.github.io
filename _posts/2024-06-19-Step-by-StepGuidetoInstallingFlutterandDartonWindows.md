---
title: "Windows에 Flutter 및 Dart 설치하는 단계별 가이드"
description: ""
coverImage: "/assets/img/2024-06-19-Step-by-StepGuidetoInstallingFlutterandDartonWindows_0.png"
date: 2024-06-19 14:19
ogImage: 
  url: /assets/img/2024-06-19-Step-by-StepGuidetoInstallingFlutterandDartonWindows_0.png
tag: Tech
originalTitle: "Step-by-Step Guide to Installing Flutter and Dart on Windows"
link: "https://medium.com/@blup-tool/step-by-step-guide-to-installing-flutter-and-dart-on-windows-b30a631e7583"
---


![Step by Step Guide to Installing Flutter and Dart on Windows](/assets/img/2024-06-19-Step-by-StepGuidetoInstallingFlutterandDartonWindows_0.png)

윈도우에 Flutter SDK 설치 및 구성하는 방법

Google이 개발한 혁명적인 오픈 소스 UI 소프트웨어 개발 키트인 Flutter는 모바일 앱 개발에 혁신을 가져왔습니다. 이 도구의 크로스 플랫폼 기능을 통해 개발자들은 단일 코드베이스를 사용하여 iOS 및 Android용으로 고품질 네이티브 컴파일된 응용프로그램을 개발할 수 있습니다. 이는 개발 속도를 높일 뿐만 아니라 시간과 비용을 크게 줄여줍니다.

Flutter를 사용하면 개발자들은 강력한 위젯 라이브러리를 활용하여 시각적으로 멋지고 사용자 정의가 가능한 사용자 인터페이스를 만들 수 있습니다. 또한 핫 리로드 기능을 통해 실시간 코드 변경과 즉각적인 피드백이 가능하여 개발 프로세스를 간소화할 수 있습니다.

<div class="content-ad"></div>

초기 범용 앱 시장에서 플러터는 기업들이 더 넓은 대중에 효과적으로 접근할 수 있도록 돕습니다. 이 제품의 매력은 새로운 기업부터 모바일 앱 개발에 비용 효율적이고 민첩한 솔루션을 찾는 기존 기업에 이르기까지 다양합니다. 플러터로 앱을 만드는 미래를 경험해보세요.

# Windows 설치

시스템 요구 사항

- 운영 체제: Windows 10 이상 (64비트), x86–64 기반.
- 디스크 공간: 2.5 GB (IDE/도구용 디스크 공간은 포함되지 않습니다).
- 도구: 플러터는 환경에 이러한 도구들이 설치되어 있어야 합니다.
- Windows PowerShell 5.0 이상 (Windows 10에 미리 설치됨)
- Windows Command Prompt 옵션을 사용한 Git for Windows 2.x.

<div class="content-ad"></div>

Git for Windows가 이미 설치되어 있는 경우에는 명령 프롬프트 또는 PowerShell에서 git 명령을 실행할 수 있는지 확인하세요.

# Flutter SDK 다운로드

단계 1: Flutter SDK 다운로드:

다음 설치 번들을 다운로드하여 Flutter SDK의 최신 안정 버전을 가져옵니다.

<div class="content-ad"></div>

단계 2: 파일 추출하기: 다운로드한 zip 파일을 압축 해제하여 Flutter SDK를 설치하고자 하는 위치로 이동하세요.

프로그램이 올바르게 실행되도록 하려면 (예: C:\Program Files\)과 같은 권한이 필요한 폴더나 디렉토리에 설치하지 마십시오. 이 튜토리얼에서는 C:\development\flutter에 저장됩니다.

이제 Flutter 콘솔에서 Flutter 명령을 실행할 준비가 되었습니다.

단계 3: Windows PowerShell에 대한 경로 변수 업데이트

<div class="content-ad"></div>

Flutter 명령을 일반 Windows 콘솔에서 실행하려면 PATH 환경 변수에 Flutter를 추가하기 위해 다음 단계를 따라하세요:

- 시작 검색 창에서 'env'를 입력하고 계정에 대한 환경 변수 편집을 선택하십시오.

![이미지](/assets/img/2024-06-19-Step-by-StepGuidetoInstallingFlutterandDartonWindows_1.png)

- 사용자 변수 아래에서 Path 항목이 있는지 확인하십시오:
- 항목이 이미 존재하면 flutter\bin의 전체 경로를 기존 값과 구분자로 ; 뒤에 이어서 추가하십시오.

<div class="content-ad"></div>

```
![Step 1](/assets/img/2024-06-19-Step-by-StepGuidetoInstallingFlutterandDartonWindows_2.png)

다음 화면에서 "새로 만들기"를 클릭하고 flutter\bin 디렉토리의 전체 경로를 추가하세요. 이 가이드에서는 아래와 같이 표시됩니다. 두 창 모두 "확인"을 클릭하여 Windows 콘솔에서 Flutter 명령을 실행할 수 있도록 활성화하세요.

![Step 2](/assets/img/2024-06-19-Step-by-StepGuidetoInstallingFlutterandDartonWindows_3.png)

- 해당 항목이 없는 경우 flutter\bin의 전체 경로를 값으로 하는 Path라는 새로운 사용자 변수를 만드세요.
```

<div class="content-ad"></div>

### 단계 4: 플러터 실행을 위한 설치된 도구 확인

CMD에서 플러터 닥터 명령을 실행하여 설치된 도구와 간단한 설명을 확인하세요.

![이미지](/assets/img/2024-06-19-Step-by-StepGuidetoInstallingFlutterandDartonWindows_4.png)

확인할 수 있듯이, 설치를 완료하기 위해 몇 가지 구성 요소가 아직 설치되어야 합니다.

<div class="content-ad"></div>

### 단계 5: Android Studio 다운로드 및 설치

Android Studio 다운로드:

- https://developer.android.com/studio 에서 공식 Android Studio 다운로드 페이지에 방문하세요.
- "Download Android Studio" 버튼을 클릭하세요.

이제 Android Studio를 다운로드하고 설치하세요. 설정 중에 독특한 요구 사항이 없는 경우 기본 설정을 유지하려면 모든 화면에서 "다음"을 클릭하세요. "구성 요소 선택" 화면에서 앱 개발에 필요한 Android 에뮬레이터를 활성화하려면 "Android Virtual Device" 옵션을 선택해야 합니다.

<div class="content-ad"></div>

```markdown
![Step 5](/assets/img/2024-06-19-Step-by-StepGuidetoInstallingFlutterandDartonWindows_5.png)

Afterward, The Android Studio Setup Wizard will start, and you can proceed by clicking Next.

![Step 6](/assets/img/2024-06-19-Step-by-StepGuidetoInstallingFlutterandDartonWindows_6.png)

On the Install Type screen, select Custom and click Next
```

<div class="content-ad"></div>

```markdown
<img src="/assets/img/2024-06-19-Step-by-StepGuidetoInstallingFlutterandDartonWindows_7.png" />

설치 위치를 선택하거나 기본 경로를 유지하고 '다음'을 클릭하세요.

<img src="/assets/img/2024-06-19-Step-by-StepGuidetoInstallingFlutterandDartonWindows_8.png" />

UI 테마를 선택하고 '다음'을 클릭하세요.
```

<div class="content-ad"></div>

```markdown
![Step 9](/assets/img/2024-06-19-Step-by-StepGuidetoInstallingFlutterandDartonWindows_9.png)

![Step 10](/assets/img/2024-06-19-Step-by-StepGuidetoInstallingFlutterandDartonWindows_10.png)

![Step 11](/assets/img/2024-06-19-Step-by-StepGuidetoInstallingFlutterandDartonWindows_11.png)

Verify the selections and click Next.
```

<div class="content-ad"></div>

다음 화면에서 라이센스 동의를 받아들이고 완료를 클릭해주세요.

빠른 설치를 위해 아래의 명령어를 사용해주세요.
```markdown
| 컴퓨터 유형       | 특징                           |
|------------------|--------------------------------|
| 노트북           | 가볍고 휴대할 수 있는 디바이스 |
| 데스크탑         | 더 많은 연산이 필요한 곳에서 사용 |
| 태블릿           | 화면이 크고 터치 기능이 있는 디바이스 |
```

<div class="content-ad"></div>

설치를 완료한 후 Android Studio를 시작하세요. 왼쪽에 있는 Plugins를 클릭하세요. Flutter를 검색하고 Flutter 플러그인을 설치하려면 설치를 클릭하세요.

![plugin](/assets/img/2024-06-19-Step-by-StepGuidetoInstallingFlutterandDartonWindows_14.png)

그럼 Flutter 앱을 생성하는 데 사용되는 Dart 프로그래밍 언어도 설치하라는 메시지가 나타날 것입니다. 프롬프트에서 설치를 클릭하세요.

![dart](/assets/img/2024-06-19-Step-by-StepGuidetoInstallingFlutterandDartonWindows_15.png)

<div class="content-ad"></div>

마지막으로 플러그인 변경 사항이 적용되도록 IDE를 다시 시작하세요. 작업을 확인하려면 프롬프트에서 "다시 시작"을 클릭하세요.

![이미지](/assets/img/2024-06-19-Step-by-StepGuidetoInstallingFlutterandDartonWindows_16.png)

이후에 CMD에서 flutter doctor 명령을 실행하여 Android Studio 설치 여부를 확인하세요.

```js
C:\Users\blup>flutter doctor
Doctor summary (모든 세부정보를 보려면 flutter doctor -v를 실행하세요):
[√] Flutter (Channel stable, 2.10.4, on Microsoft Windows [version 10.0.19041.746), locale en-US)
[!] Android toolchain - develop for Android devices (Android SDK version 32.1.0-rc1)
    ! 일부 Android 라이센스가 승인되지 않았습니다. 이 문제를 해결하려면 flutter doctor --android-licenses를 실행하세요.
[√] Chrome - develop for the web
[X] Visual Studio - develop for Windows
    X Visual Studio가 설치되지 않았습니다. 이는 Windows 개발에 필요합니다.
      https://visualstudio.microsoft.com/downloads/에서 다운로드하세요.
      "C++ 데스크톱 개발" 워크로드 및 해당 기본 구성 요소를 모두 설치하세요.
[√] Android Studio (버전 2021.1)
[√] 연결된 장치 (2개 사용 가능)
[√] HTTP Host 가용성

! Doctor에서 2개 범주에서 문제를 발견했습니다.
```

<div class="content-ad"></div>

안녕하세요! 안드로이드 스튜디오가 성공적으로 설치되었지만, 안드로이드 라이센스에 문제가 발견되었습니다. 이 문제는 다음 명령어를 CMD에서 실행하여 해결할 수 있어요.

```js
flutter doctor --android-licenses
```

프롬프트에서 y를 입력하여 라이센스를 수락해주세요.

```js
C:\Users\blup>flutter doctor --android-licenses
5 of 7 SDK package licenses not accepted. 100% Computing updates...
Review licenses that have not been accepted (y/N)? y
```

<div class="content-ad"></div>

다시 플러터 닥터 명령을 실행하면 문제가 해결된 것을 확인할 수 있습니다.

```js
C:\Users\blup>flutter doctor
Doctor summary (자세한 정보를 보려면 flutter doctor -v를 실행하세요):
[√] Flutter (Channel stable, 2.10.4, on Microsoft Windows [Version 10.0.19041.746], 로캘 en-US)
[√] Android toolchain - develop for Android devices (Android SDK version 32.1.0-rc1)
[√] Chrome - develop for the web
[X] Visual Studio - develop for Windows
    X Visual Studio가 설치되지 않았습니다; Windows 개발에 필요합니다.
      https://visualstudio.microsoft.com/downloads/에서 다운로드하세요.
      "C++로 데스크톱 개발" 워크로드를 설치해 주십시오. 기본 구성 모두 포함
[√] Android Studio (버전 2021.1)
[√] 연결된 장치 (2개 사용 가능)
[√] HTTP 호스트 가용성

! 문제가 있는 카테고리에서 문제를 발견했습니다.
```

# 단계 6: Visual Studio 설치하기 (선택 사항)

위 출력 결과에서 Visual Studio가 설치되어 있지 않음을 알 수 있습니다. Windows 데스크톱 개발을 위해 Flutter를 사용하고 싶지 않은 경우에는 Visual Studio가 필요하지 않습니다.

<div class="content-ad"></div>

만약 필요하다면 Microsoft의 Visual Studio 2022와 C++을 함께 설치할 수 있어요. VisualStudioSetup.exe 파일을 다운로드한 후에는 열어서 기본 설치 옵션에 동의하면서 설치를 진행하세요. 이 설치에는 적어도 20GB의 여유 디스크 공간이 필요합니다. 설치가 완료되면 CMD에서 flutter doctor 명령을 실행하여 Visual Studio 설치 여부를 확인하세요.

```js
C:\Users\blup>flutter doctor
Doctor summary (to see all details, run flutter doctor -v):  
[√] Flutter (Channel stable, 2.10.4, on Microsoft Windows [Version 10.0.19041.746], locale en-US)
[√] Android toolchain - develop for Android devices (Android SDK version 32.1.0-rc1)
[√] Chrome - develop for the web
[√] Visual Studio - develop for Windows (Visual Studio Community 2022 17.1.3)
[√] Android Studio (version 2021.1)
[√] Connected device (2 available)
[√] HTTP Host Availability

• 문제 없음!
```

이 시점에서 Flutter 프로젝트에 필요한 모든 도구가 준비되어 Flutter 앱을 개발할 준비가 끝났어요. Android Studio나 Visual Studio 중에서 프로젝트를 시작할 수 있으니 필요에 맞게 선택하세요.

Flutter를 사용하고 있는 기업들 목록을 보려면 Flutter Showcase blup.in/blogs에서 확인할 수 있어요.

<div class="content-ad"></div>

이외에도, 플러터와 모바일 앱 개발에 관한 다른 상세 기사를 작성했습니다. 아래에서 찾아볼 수 있어요:

- 2023년 최고의 플러터 학습 로드맵: 최고의 플러터 개발자가 되는 법
- 플러터 개발자 학습 로드맵: Dart의 능력 공개
- 모바일 앱 개발 완전 가이드
- 플러터 프레임워크로 제작된 최고의 20개 앱
- 2023년 최고의 플러터 앱 개발 회사는 무엇인가요?

결론: Windows 기기에 플러터를 성공적으로 설치하고 Android 및 iOS 앱 개발 환경을 설정했어요. 이제 플러터로 크로스 플랫폼 애플리케이션을 만들 준비가 되었답니다. 당신이 경험 많은 개발자이든 막 시작한 개발자이든, 플러터의 힘은 당신의 손끝에 있어요. Windows 시스템에서 즐거운 코딩되세요!