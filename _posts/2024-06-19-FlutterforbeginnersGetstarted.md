---
title: "초보자를 위한 Flutter 시작하기"
description: ""
coverImage: "/assets/img/2024-06-19-FlutterforbeginnersGetstarted_0.png"
date: 2024-06-19 14:23
ogImage: 
  url: /assets/img/2024-06-19-FlutterforbeginnersGetstarted_0.png
tag: Tech
originalTitle: "Flutter for beginners —Get started"
link: "https://medium.com/@lidongw90/flutter-for-beginners-get-started-7586cfc10b63"
---


# 1. 플러터 소개

플러터(Flutter)는 구글이 제공하는 무료 도구로, 개발자가 단일 코드베이스를 사용하여 모바일, 웹, 데스크톱용 앱을 만들 수 있도록 도와줍니다. 2018년에 출시된 플러터는 빠르고 강력하여 빠르게 인기를 얻고 있습니다.

## 주요 기능

- 크로스 플랫폼 개발: 플러터를 사용하면 안드로이드, iOS, Windows, macOS, Linux, 웹용 앱을 단일 코드베이스에서 모두 개발할 수 있습니다.
- 핫 리로드: 이 기능을 통해 개발자는 앱을 다시 시작하지 않고 실시간으로 변경 사항을 볼 수 있어 개발 프로세스가 빨라집니다.
- 다양한 위젯: 플러터는 많은 사용자 정의 가능한 위젯을 제공하여 아름답고 복잡한 사용자 인터페이스를 쉽게 만들 수 있습니다.
- 높은 성능: 플러터 앱은 네이티브 코드로 직접 컴파일하기 때문에 부드럽고 빠르게 실행됩니다.
- Dart 언어: 플러터는 구글이 개발한 프로그래밍 언어인 Dart를 사용하며, 사용자 인터페이스 구축을 위해 최적화되어 있고 배우기 쉽습니다.

<div class="content-ad"></div>

![이미지](/assets/img/2024-06-19-FlutterforbeginnersGetstarted_0.png)

## 장점

- 빠른 개발: 핫 리로드 및 다양한 위젯 라이브러리로 개발 프로세스가 빨라집니다. 
- 아름다운 UI: 개발자들은 쉽게 매력적인 사용자 인터페이스를 만들 수 있습니다. 
- 강력한 커뮤니티 지원: 플러터에는 큰 커뮤니티와 Google의 지원이 있어 개발자에게 다양한 자료와 도움이 제공됩니다.

![이미지](/assets/img/2024-06-19-FlutterforbeginnersGetstarted_1.png)

<div class="content-ad"></div>

# 2. 플러터 설치하기

2.1 맥에서 플러터 웹 앱 빌드 시작하기

시작하려면 개발 플랫폼을 선택하세요. 이 가이드에서는 macOS에서 웹용으로 빌드하는 데 초점을 맞출 것입니다. 플러터 문서 페이지로 이동해주세요.

![이미지](/assets/img/2024-06-19-FlutterforbeginnersGetstarted_2.png)

<div class="content-ad"></div>

아래는 Markdown 형식으로 표시해 드릴게요.

![이미지](/assets/img/2024-06-19-FlutterforbeginnersGetstarted_3.png)

## 2.1.1 하드웨어 요구 사항

귀하의 macOS 개발 환경은 다음 최소 하드웨어 요구 사항을 충족해야 합니다:

![이미지](/assets/img/2024-06-19-FlutterforbeginnersGetstarted_4.png)

<div class="content-ad"></div>

## 2.1.2 소프트웨어 요구 사항

웹용 Flutter 코드를 개발하고 컴파일하기 위해 다음 소프트웨어 패키지를 설치하십시오.

### 2.1.2.1 운영 체제

Flutter는 macOS 10.15(카탈리나) 이상을 지원합니다. 본 안내서는 zsh를 기본 셸로 사용한다고 가정합니다. macOS Catalina (10.15) 이후로 macOS의 기본 셸은 zsh입니다.

<div class="content-ad"></div>

zsh를 사용 중인지 확인하려면:

- SHELL 환경 변수 확인: 터미널을 열고 다음을 입력하세요:

```bash
echo $SHELL
```

만약 /bin/zsh 또는 /usr/bin/zsh와 같은 결과가 나오면, zsh를 사용 중입니다.

<div class="content-ad"></div>

아래 Markdown 포맷으로 테이블 태그를 변경해 주세요.

<img src="/assets/img/2024-06-19-FlutterforbeginnersGetstarted_5.png" />

2. 현재 쉘을 확인하세요: 터미널을 열고 다음을 입력하세요:

```js
echo $0
```

만약 -zsh가 나오면, zsh를 사용 중입니다.

<div class="content-ad"></div>

```markdown
![이미지](/assets/img/2024-06-19-FlutterforbeginnersGetstarted_6.png)

3. ps 명령어 사용: 터미널을 열고 다음을 입력하세요:

```bash
ps -p $$
```

![이미지](/assets/img/2024-06-19-FlutterforbeginnersGetstarted_7.png)
```

<div class="content-ad"></div>

일부 Flutter 구성 요소는 Apple 실리콘을 사용하는 Mac에서 Rosetta 2를 필요로 합니다. Rosetta 2를 설치하려면 다음 명령을 실행해주세요:

```js
sudo softwareupdate --install-rosetta --agree-to-license
```

설치가 완료되면 "Rosetta 2 설치가 성공적으로 완료되었습니다."라는 메시지가 표시됩니다.

## 2.1.2.2 개발 도구

<div class="content-ad"></div>

다음 패키지를 설치해 주세요.

- Google Chrome: 웹 앱의 JavaScript 코드를 디버그하기 위해 설치합니다.
- Git 2.27 이상: 소스 코드를 관리하기 위해 설치합니다. 터미널에 git version을 입력해서 Git이 설치되었는지 확인하세요. 설치되어 있지 않다면 brew install git 명령어로 설치하세요.

## 2.1.2.3 텍스트 에디터 또는 통합 개발 환경 (IDE)

Flutter의 명령줄 도구와 함께 사용할 수 있는 어떤 텍스트 편집기나 IDE를 사용할 수 있습니다. Flutter 확장 또는 플러그인이 포함된 IDE는 코드 완성, 구문 강조, 위젯 편집 보조, 디버깅 등을 제공합니다.

<div class="content-ad"></div>

인기 있는 옵션은 다음과 같습니다:

- Visual Studio Code 1.77 이상 및 VS Code용 Flutter 확장 프로그램.
- Android Studio 2023.2.1 (이구아나) 이상 및 IntelliJ용 Flutter 플러그인.
- IntelliJ IDEA 2023.2 이상 및 IntelliJ용 Flutter 플러그인 및 Android 플러그인.

권장

## 2.1.3 Flutter SDK 설치

<div class="content-ad"></div>

VS 코드 Flutter 확장 프로그램을 사용하거나 Flutter 번들을 직접 다운로드하여 설치할 수 있습니다.

## 2.1.3.1 VS Code를 사용하여 Flutter 및 Flutter 확장 프로그램 설치

VS 코드를 사용하여 Flutter를 설치하려면 Visual Studio Code 1.77 이상 버전이 설치되어 있어야 하며 Flutter 확장 프로그램을 설치하는 방법은 다음과 같습니다.

- Visual Studio Code를 엽니다.
- 확장 프로그램 버튼을 클릭합니다 (보통 사이드바에 있음).
- 검색 창에 "Flutter"를 입력합니다.
- Flutter 확장 프로그램 옆의 "설치" 버튼을 클릭합니다.

<div class="content-ad"></div>

아래 단계에 따라 플러터 확장 프로그램을 설정해보세요.

![Flutter 확장 프로그램 설치](/assets/img/2024-06-19-FlutterforbeginnersGetstarted_8.png)

## 2.1.3.1.1 VS Code를 사용하여 Flutter 설치

- VS Code 열기: 컴퓨터에서 Visual Studio Code를 시작하세요.
- 명령 팔레트 열기: Command + Shift + P를 눌러 명령 팔레트를 열어보세요.
- Flutter 입력: 명령 팔레트에 flutter를 입력하세요.
- 새 프로젝트 선택: Flutter: New Project를 클릭하세요.

<div class="content-ad"></div>

![이미지](/assets/img/2024-06-19-FlutterforbeginnersGetstarted_9.png)

5. Flutter SDK 찾기: VS Code에서 컴퓨터에서 Flutter SDK를 찾도록 요청할 것입니다.

- 이미 Flutter SDK를 설치한 경우 "SDK 찾기"를 클릭하십시오.
- Flutter SDK를 아직 설치하지 않은 경우 "SDK 다운로드"를 클릭하십시오.

![이미지](/assets/img/2024-06-19-FlutterforbeginnersGetstarted_10.png)

<div class="content-ad"></div>

위치를 선택한 후 다음을 볼 수 있습니다:

```
![Flutter for beginners - Get started 11](/assets/img/2024-06-19-FlutterforbeginnersGetstarted_11.png)

![Flutter for beginners - Get started 12](/assets/img/2024-06-19-FlutterforbeginnersGetstarted_12.png)
```

VS Code를 다시 열고 Command + Shift + P를 누른 다음, Flutter: New Project를 선택하세요. 이런 스크린샷과 같은 화면을 볼 때 SDK가 성공적으로 설치된 것입니다.

<div class="content-ad"></div>

```markdown
![이미지](/assets/img/2024-06-19-FlutterforbeginnersGetstarted_13.png)

# 3. Test drive

## 3.1 샘플 Flutter 앱 만들기

VS Code에서 DevTools를 사용하려면 Dart 확장이 필요합니다. 더 쉬운 디버깅을 위해 Flutter 확장도 유용합니다.
```

<div class="content-ad"></div>

- Command Palette를 열어주세요: View ` Command Palette로 이동하거나 Command + Shift + P를 눌러주세요.
- Flutter라고 입력하세요: Command Palette에 flutter라고 입력하세요.
- 새 프로젝트 선택하세요: Flutter: New Project를 클릭하세요.
- 프로젝트 유형 선택하세요: "어떤 Flutter 프로젝트?"라는 메시지가 나오면 Application을 선택하세요.

<img src="/assets/img/2024-06-19-FlutterforbeginnersGetstarted_14.png" />

5. 새 프로젝트 폴더의 상위 디렉토리를 만들거나 선택해주세요.

6. 프로젝트 이름을 입력해주세요. "test_drive"를 입력한 뒤 Enter를 눌러주세요.

<div class="content-ad"></div>

```markdown
![이미지](/assets/img/2024-06-19-FlutterforbeginnersGetstarted_15.png)

7. 프로젝트가 생성되는 동안 기다려주세요. 시간이 조금 걸릴 수 있어요.

8. lib 폴더 내의 main.dart 파일을 열어주세요. 코드의 각 부분이 무엇을 하는지 이해하려면 main.dart 파일의 주석을 읽어보세요.

# 3.2 예제 애플리케이션 실행하기
```

<div class="content-ad"></div>

당신은 데스크톱, Chrome 웹 브라우저, iOS 시뮬레이터 또는 Android 에뮬레이터에서 앱을 실행할 수 있어요.

참고: 웹에서 앱을 실행할 수는 있지만, 현재 웹 타겟에 대한 핫 리로드는 지원되지 않아요.

- 명령 팔레트 열기: 뷰에서 명령 팔레트로 이동하거나 Command + Shift + P를 누르세요.
- Flutter 입력: 명령 팔레트에 flutter 입력해주세요.
- 디바이스 선택: Flutter: Select Device를 클릭하고, 앱을 실행할 디바이스를 선택해주세요.

![이미지](/assets/img/2024-06-19-FlutterforbeginnersGetstarted_16.png)

<div class="content-ad"></div>

![이미지](/assets/img/2024-06-19-FlutterforbeginnersGetstarted_17.png)

4. 대상 장치 선택: "장치 선택" 메시지에서 앱을 실행할 장치를 선택하세요.

5. 앱 시작: 실행하려면 "디버깅 시작" 또는 F5를 누르세요.

6. 앱이 시작될 때까지 기다리기: 앱이 시작될 때까지 기다려 주세요.

<div class="content-ad"></div>

7. 모니터 발매 진행 상황: 디버그 콘솔 보기에서 진행 상황을 확인할 수 있습니다.

8. 앱 보기: 빌드가 완료되면 선택한 기기에 앱이 나타납니다.

![이미지](/assets/img/2024-06-19-FlutterforbeginnersGetstarted_18.png)

# 3.3 Flutter에서 핫 리로드 사용하기

<div class="content-ad"></div>

플러터는 Stateful Hot Reload로 빠른 개발 주기를 제공합니다. 이는 앱을 재시작하거나 상태를 잃지 않고 코드를 업데이트할 수 있다는 것을 의미합니다.

- main.dart 열기: 프로젝트에서 lib/main.dart로 이동합니다.
- 변경하기: `You have pushed the button this many times:` 텍스트가 포함된 줄을 찾아서 `You have clicked the button this many times:`로 변경합니다.

원본:

```js
'You have pushed the button this many times:'
```

<div class="content-ad"></div>

새로운 방법:

```js
'이 버튼을 클릭한 횟수:'
```

참고: 앱을 중지하지 마세요. 계속 실행하도록 해주세요.

3. 변경 사항 저장하기: 모두 저장을 사용하거나 핫 리로드 버튼을 클릭하세요.

<div class="content-ad"></div>

<img src="/assets/img/2024-06-19-FlutterforbeginnersGetstarted_19.png" />

앱을 재시작하지 않고 대상 장치에서 즉시 변경 사항이 반영됩니다.

<img src="/assets/img/2024-06-19-FlutterforbeginnersGetstarted_20.png" />

문제 해결 팁:

<div class="content-ad"></div>

어플리케이션을 실행할 때 다음과 같은 오류가 발생한다면:

```js 
macOS의 debug 모드에서 lib/main.dart를 실행 중...
ProcessException: Process exited abnormally with exit code 72:
xcrun: error: unable to find utility "xcodebuild", not a developer tool or in PATH
Command: /usr/bin/arch -arm64e xcrun xcodebuild -list -project Runner.xcodeproj
Exited (1).
```

보고하신 오류 메시지는 xcodebuild 유틸리티를 찾을 수 없다는 것을 나타냅니다. 이 유틸리티는 iOS 또는 macOS에서 Flutter 애플리케이션을 빌드하고 실행하는 데 필요한 Xcode의 일부입니다.

PATH를 확인해야 합니다: Xcode 명령줄 도구가 PATH에 있는지 확인하세요. 터미널에서 다음 몤령어를 실행하여 확인할 수 있습니다:

<div class="content-ad"></div>

```js
echo $PATH
```

결과에는 /Applications/Xcode.app/Contents/Developer/usr/bin과 유사한 경로가 포함되어 있어야 합니다. 그렇지 않은 경우 경로를 추가해야 합니다.

터미널에서 다음 명령을 실행하여 경로를 추가할 수 있습니다:

```js
echo 'export PATH="/Applications/Xcode.app/Contents/Developer/usr/bin:$PATH"' >> ~/.zshrc
```

<div class="content-ad"></div>

해당 명령어는 ~/.zshrc 파일의 끝에 export PATH="/Applications/Xcode.app/Contents/Developer/usr/bin:$PATH" 라인을 추가합니다. 이 파일은 새로운 터미널 세션이 시작될 때마다 실행됩니다.

이 명령어를 실행한 후에는 다음 명령어를 사용하여 ~/.zshrc 파일을 다시 불러와야 합니다:

```js
source ~/.zshrc
```

그런 다음, Xcode 경로가 포함되어 있는지 확인하기 위해 echo $PATH를 사용할 수 있습니다. 이후에 Flutter 애플리케이션을 다시 실행해보세요.