---
title: "VSCode를 사용하여 Android Studio 대신 Windows 환경에서 Flutter 프로그래밍하는 방법"
description: ""
coverImage: "/assets/img/2024-06-23-FlutterprogrammingforandroidwithVSCodeinsteadofusingAndroidStudioinWindows_0.png"
date: 2024-06-23 14:50
ogImage: 
  url: /assets/img/2024-06-23-FlutterprogrammingforandroidwithVSCodeinsteadofusingAndroidStudioinWindows_0.png
tag: Tech
originalTitle: "Flutter programming for android with VSCode instead of using Android Studio in Windows"
link: "https://medium.com/@m.yuvaraj2303/flutter-programming-for-android-with-vscode-instead-of-using-android-studio-in-windows-af20f2d67e81"
---


<img src="/assets/img/2024-06-23-FlutterprogrammingforandroidwithVSCodeinsteadofusingAndroidStudioinWindows_0.png" />

# 윈도우에서 VSCode로 새 Flutter 프로젝트를 만드는 단계별 지침서

## 단계 1: VSCode 설치하기

VSCode를 공식 링크(https://code.visualstudio.com/download)에서 다운로드하고 설치하세요.

<div class="content-ad"></div>

<img src="/assets/img/2024-06-23-FlutterprogrammingforandroidwithVSCodeinsteadofusingAndroidStudioinWindows_1.png" />

## 단계 2: Flutter 확장 프로그램 설치

비주얼 스튜디오 코드용 Flutter 확장 프로그램을 설치하세요. 이를 위해 비주얼 스튜디오 코드에서 Extension Marketplace를 열고 "Flutter"를 검색한 다음 Flutter 확장 프로그램을 설치하기 위해 "설치"를 클릭하세요.

## 단계 3: Java 11 SDK 설치

<div class="content-ad"></div>

아래 링크에서 Java 11 SDK를 다운로드하고 설치해주세요. https://www.oracle.com/in/java/technologies/javase/jdk11-archive-downloads.html

![image](/assets/img/2024-06-23-FlutterprogrammingforandroidwithVSCodeinsteadofusingAndroidStudioinWindows_2.png)

- 시스템 변수 아래에 새로운 변수를 생성해주세요.

이름: JAVA_HOME, 값: C:\Program Files\Java\jdk-11.0.12

<div class="content-ad"></div>

```js
JAVA_HOME=C:\Program Files\Java\jdk-11.0.12
```

![Image](/assets/img/2024-06-23-FlutterprogrammingforandroidwithVSCodeinsteadofusingAndroidStudioinWindows_3.png)

2. PATH에 %JAVA_HOME%\bin 추가

```js
%JAVA_HOME%\bin
```

<div class="content-ad"></div>

## 단계 4: 명령 줄 도구를 사용하여 Android SDK 설치하기

공식 링크인 https://developer.android.com/studio 에서 명령 줄 도구를 사용하여 Android SDK를 다운로드하세요.

![이미지](/assets/img/2024-06-23-FlutterprogrammingforandroidwithVSCodeinsteadofusingAndroidStudioinWindows_4.png)

- C:\Android\ 안에 android-sdk라는 이름의 폴더를 생성하세요.
- 다운로드한 zip 파일을 C:\Android\android-sdk\cmdline-tools\latest\ 경로에 압축 해제하세요. 참고: 경로는 동일해야 합니다.
- 시스템 변수 아래에 새 변수를 만드세요.

<div class="content-ad"></div>

```js
ANDROID_HOME=C:\Android\android-sdk
ANDROID_SDK_ROOT=C:\Android\android-sdk
```

`ANDROID_HOME`의 이름과 값은 `C:\Android\android-sdk`입니다.

![이미지](/assets/img/2024-06-23-FlutterprogrammingforandroidwithVSCodeinsteadofusingAndroidStudioinWindows_5.png)

`ANDROID_SDK_ROOT`의 이름과 값은 `C:\Android\android-sdk`입니다.

<div class="content-ad"></div>


![Image 1](/assets/img/2024-06-23-FlutterprogrammingforandroidwithVSCodeinsteadofusingAndroidStudioinWindows_6.png)

4. Variable After added like this.

![Image 2](/assets/img/2024-06-23-FlutterprogrammingforandroidwithVSCodeinsteadofusingAndroidStudioinWindows_7.png)

4. Add C:\Android\android-sdk\cmdline-tools\latest\bin to PATH


<div class="content-ad"></div>

```js
%ANDROID_HOME%\cmdline-tools\latest\bin
```

5. cmd sdkmanager — update 명령을 사용하여 SDK 관리자 업데이트

```js
sdkmanager --update
```

6. 다음 명령을 사용하여 시스템 이미지, 플랫폼, 플랫폼 도구, 에뮬레이터 및 빌드 도구 다운로드하기

<div class="content-ad"></div>

```js
sdkmanager emulator platform-tools
sdkmanager "system-images;android-29;google_apis;x86"
sdkmanager "platforms;android-29"
sdkmanager "build-tools;29.0.2"
```

7. 그리고 최종적으로 다음 경로들이 시스템 변수 아래 PATH에 추가됩니다

![image](/assets/img/2024-06-23-FlutterprogrammingforandroidwithVSCodeinsteadofusingAndroidStudioinWindows_8.png)

## 단계 5: Flutter SDK 설치

<div class="content-ad"></div>

공식 링크인 https://docs.flutter.dev/get-started/install/windows 에서 플러터의 최신 버전을 다운로드 받을 수 있어요.

![이미지](/assets/img/2024-06-23-FlutterprogrammingforandroidwithVSCodeinsteadofusingAndroidStudioinWindows_9.png)

- C:\ 안에 Android란 이름의 폴더를 만들어주세요.
- 다운로드한 zip 파일을 C:\Android\flutter 경로에 압축 해제해주세요.
- C:\Android\flutter\bin를 PATH에 추가해주세요

```js
C:\Android\flutter\bin
```

<div class="content-ad"></div>

4. 프로젝트가 저장된 드라이브에 Pubcache를위한 폴더를 만듭니다. D:\Program Data\.pubcache 및 PATH에 추가합니다.

```js
D:\Program Data\.pubcache
```

## 단계 6: Flutter가 작동하는지 확인합니다.

cmd를 사용하여 flutter doctor -v를 실행하세요.

<div class="content-ad"></div>

```js
flutter doctor -v
```

<img src="/assets/img/2024-06-23-FlutterprogrammingforandroidwithVSCodeinsteadofusingAndroidStudioinWindows_10.png" />

## Step 7: Create new flutter project

Create a new flutter project using cmd `flutter create projectname`

<div class="content-ad"></div>

이미지를 참고해주세요!

```js
flutter create testpro
cd testpro
code .
```

VSCode에서 폴더를 열기 위해 코드를 실행하세요.

## 단계 8: 에뮬레이터 시작하기

<div class="content-ad"></div>

에뮬레이터를 시작하기 위한 전제 조건입니다.

- 가상화가 활성화되어 있어야 합니다.

![이미지](/assets/img/2024-06-23-FlutterprogrammingforandroidwithVSCodeinsteadofusingAndroidStudioinWindows_12.png)

3. Windows 10 Home에서 Hyper-v를 설치하고 활성화하려면 Windows Hypervisor 플랫폼 확인란을 선택하세요.

<div class="content-ad"></div>


![image](https://www.example.com/assets/img/2024-06-23-FlutterprogrammingforandroidwithVSCodeinsteadofusingAndroidStudioinWindows_13.png)

4. 새로운 Android 가상 장치를 만들고 디바이스를 실행하려면 키 Ctrl+Shift+P를 눌러 명령 팔레트를 열고 select device를 입력하세요.

![image](https://www.example.com/assets/img/2024-06-23-FlutterprogrammingforandroidwithVSCodeinsteadofusingAndroidStudioinWindows_14.png)

Android 에뮬레이터를 만들어보세요.


<div class="content-ad"></div>

## 단계 9: VSCode에서 프로젝트 디버그 모드 실행

디버그 모드로 플러터 프로젝트를 실행하려면 메뉴에서 Run-` Start Debugging을 선택하거나 F5 키를 누르세요.

![이미지](/assets/img/2024-06-23-FlutterprogrammingforandroidwithVSCodeinsteadofusingAndroidStudioinWindows_15.png)

## 단계 10: 터미널에서 실행

<div class="content-ad"></div>

터미널을 열려면 Ctrl + ` 키를 누르세요. 터미널에서 cmd flutter run을 입력하여 실행을 시작하세요.

```js
flutter run
```

## 단계 11: 프로덕션용 빌드

터미널을 열려면 Ctrl + ` 키를 눌러주세요. 빌드 후 플레이스토어에 배포하려면 .abb 파일을 얻으려면 터미널에서 cmd flutter build appbundle을 입력하세요.

<div class="content-ad"></div>

```js
플러터 앱 번들을 빌드하려면 다음 명령어를 실행하세요.
```