---
title: "IntelliJ에서 Flutter 사용하는 방법"
description: ""
coverImage: "/assets/img/2024-06-21-FlutterinIntelliJ_0.png"
date: 2024-06-21 22:27
ogImage: 
  url: /assets/img/2024-06-21-FlutterinIntelliJ_0.png
tag: Tech
originalTitle: "Flutter in IntelliJ"
link: "https://medium.com/@tigerasks/flutter-in-intellij-7cf9677b0d7e"
---


## 완전 초보자를 위한 "플러터 시작하기" 시리즈의 3부

Tiger가 묻습니다... 선호하는 IDE를 계속 사용하는 방법은 무엇인가요?

VS Code는 플러터 프로젝트에서 인기 있는 선택지입니다. 그리고 그것이 그렇게 나쁜 선택은 아닙니다.

하지만 나는 연령이다 유지하려는 것을 좋아하는 Jetbrain의 IntelliJ를 업무에서나 개인적으로 여러 해 동안 사용해 왔습니다. 그것을 좋아하기 때문에, 그리고 필요 없는 경우에는 그것을 포기하기를 꺼리는 것입니다.

<div class="content-ad"></div>

정 테이블 기호(Markdown 형식)로 변경해야 할 것 같습니다.

<div class="content-ad"></div>

만약 더 자세한 지침에 관심이 없고 빠른 "이것을 해야 한다" 체크리스트를 원하신다면, 문서 맨 아래의 요약 부분으로 건너뛰세요.

# 플러터 플러그인 설치

그게 플러터의 "에디터 설정" 페이지에 언급된 유일한 항목이에요, 그래서 우리는 그것을 해볼 거에요.

- Ctrl+Alt+S - Plugins 찾기
- marketplace 탭 열고, flutter로 검색하기

<div class="content-ad"></div>

플러터 플러그인이 많다고 하는데, 예를 들어 Bloc 등이 있습니다. 하지만 지금은 플러터 플러그인만 설치할 예정이에요. 그리고 이에 필요한 Dart 플러그인도 설치해야 한다고 알려줍니다.

![이미지](/assets/img/2024-06-21-FlutterinIntelliJ_0.png)

그런 다음 플러그인을 활성화하기 위해 IDE를 다시 시작하세요.

# 플러터 SDK 설치하기

<div class="content-ad"></div>

이제 IntelliJ는 Flutter를 사용하는 방법을 알고 있지만, Flutter 자체가 필요합니다.

- https://docs.flutter.dev/get-started/install

제 경우에는 Linux에 설치하고 Snap을 사용할 것입니다:

```js
sudo snap install flutter --classic
```

<div class="content-ad"></div>

만약 --classic에 대해 헷갈린다면, 스택익스체인지에 훌륭한 답변이 있으니 참고하세요. 요약하면, 이것은 플러터와는 아무 상관이 없으며 플러터에 부여된 액세스 권한에 대한 것입니다.

그럼, 설치가 유효한지 확인해봅시다.

```js
flutter doctor
```

이 명령을 실행하여 많은 정보를 확인할 수 있습니다. 먼저, 실행하길 원합니다.

<div class="content-ad"></div>

```js
flutter --disable-analytics
```

이것은 선택 사항이지만, 나는 텔레메트리를 싫어해요.

다음으로, flutter doctor는 정확히 무엇이 부족한지 알려줍니다:

![FlutterinIntelliJ_1](/assets/img/2024-06-21-FlutterinIntelliJ_1.png)


<div class="content-ad"></div>

안녕하세요! 안드로이드 애플리케이션을 개발할 때 플러터를 사용하기 위해 안드로이드 SDK가 필요합니다. 큰 놀라움이 아니에요. 안드로이드 에뮬레이터를 어떻게 가져올까요?

실제 애플리케이션을 실행할 때 그 다리를 건너가면서 알아보도록 하겠습니다.

# 플러터 프로젝트 생성

![Flutter in IntelliJ](/assets/img/2024-06-21-FlutterinIntelliJ_2.png)

<div class="content-ad"></div>

IntelliJ는 플러터 SDK 경로를 인식해야 합니다. 그렇지 않을 경우,

```js
flutter sdk-path
```

를 입력하여 확인할 수 있습니다. 거기서 새 프로젝트를 설정하는 일반적인 단계를 거치면 됩니다. 저는 이 시리즈의 개요 포스트에서 설명된 프로젝트를 설정할 것이며, iOS를 대상으로 하지는 않을 것입니다.

![이미지](/assets/img/2024-06-21-FlutterinIntelliJ_3.png)

<div class="content-ad"></div>

한 번의 git init과 커밋 후에, 우리는 출발할 준비가 되었어요.

제 개인적인 의견으로는, gitignore.io에서 더 포괄적인 .gitignore 파일을 생성하여 IntelliJ가 자동으로 생성하는 것과 교체하는 것을 선호합니다. 하지만 이 작업을 할 때 주의할 점이 있습니다: 이 글을 쓰는 시점에서, gitignore.io는 *.iws 파일만 무시하지만 IntelliJ가 생성하는 것은


# 파일 기반 프로젝트 형식
*.iml
*.ipr
*.iws
.idea/


이렇게 추가해야 할 부분이 있을 수 있어요.

<div class="content-ad"></div>

# 에뮬레이터에서 앱 실행하기

새로운 플러터 프로젝트에는 "Hello world" 보일러플레이트 애플리케이션이 자동으로 포함되어 있습니다. 놀랍게도, 플러터에 대한 미니 튜토리얼을 제공하는 유용한 주석도 포함되어 있습니다. 편리하네요.

지금은 어쨌든, 일단 애플리케이션을 가상 플러터 장치에서 실행하여 모든 것이 작동하는지 확인하고 싶습니다. IntelliJ가 표시하는 경고에서 알 수 있듯이, 그렇게 되지는 않습니다.

<div class="content-ad"></div>

참고로, IDE 오른쪽 상단의 '장치 선택 없음' 드롭다운을 보는 것을 좋아해요. 안드로이드 스튜디오에 신경을 쓰지 않은 것이 옳은 선택이었다고 느끼게 해줍니다.

## 안드로이드 SDK 설치

경고에서 Configure...을 누를 수도 있지만, 경고 없이 어디에서 무엇을 찾을 수 있는지 알아둘 때를 선호하기 때문에 다음으로 이동합니다.

파일 - 프로젝트 구조 - +

<div class="content-ad"></div>

수정해주셔서 감사합니다. 단 … 현재 버그가 있어서 원하는 곳이 아닙니다.

![image](/assets/img/2024-06-21-FlutterinIntelliJ_5.png)

Android SDK 다운로드를 선택하면 IntelliJ가 다운로드할 JDK 버전을 묻습니다. 제가 원하는 것이 아닙니다.

언젠가는 패치될 것 같지만 그동안 Shift를 두 번 눌러 android를 검색하면 Android SDK 관리자라는 유용한 기능이 있다는 것을 알게 됩니다.

<div class="content-ad"></div>

만약 우리가 그것을 열면, 그것이 우리가 찾고 있는 것과 더 닮아 보입니다.

![Flutter in IntelliJ image 6](/assets/img/2024-06-21-FlutterinIntelliJ_6.png)

여기서 '편집'을 누르면 SDK 설정을 마칠 수 있습니다.

![Flutter in IntelliJ image 7](/assets/img/2024-06-21-FlutterinIntelliJ_7.png)

<div class="content-ad"></div>

그러면 우리에게 다음을 설치할 것입니다:

- 안드로이드 에뮬레이터
- SDK 빌드 도구
- SDK 플랫폼과 해당 도구
- 안드로이드 소스

유용합니다. 한 번의 라이센스 동의 화면을 거치고 나면, 마침내 SDK를 설치했습니다.

## 올바른 Android 플랫폼 설치하기

<div class="content-ad"></div>

하지만 조심해, 아직 Fig.5에서의 경고가 남아 있네. 왜냐하면 방금 실행한 SDK 설정은 최신 플랫폼만 설치하도록 했기 때문이야... 이는 생성된 프로젝트가 구성된 API 레벨이 아니기 때문이야.

나는 API를 최신 것으로 변경할 수 있지만, 대신 앱이 기대하는 API를 설치해보자:

![이미지](/assets/img/2024-06-21-FlutterinIntelliJ_8.png)

Apply를 누르면... 여전히 Fig.5의 경고가 남아 있어.

<div class="content-ad"></div>

API 29를 설치했지만 프로젝트가 아직 그것을 사용하도록 설정되지 않았기 때문입니다.

그래서 Project Structure 대화상자에서 Android API의 빌드 대상을 29로 변경해봅시다.

![이미지](/assets/img/2024-06-21-FlutterinIntelliJ_9.png)

그리고... 경고 메시지가 여전히 있네요. -.-

<div class="content-ad"></div>

그래, 저희는 이 오해불쏙 끝나는 '구성...' 버튼을 사용할 거에요:

![image](/assets/img/2024-06-21-FlutterinIntelliJ_10.png)

Figure 11에서 안드로이드 API는 프로젝트 구조에서 SDK로 이름을 변경한 것입니다. 내 의견으로는, IntelliJ가 그것에 만족해야 하는 것이었어야 했는데, 그러나 확실히 우리에게 그것을 사용할 수 있다는 것을 알려줄 때 만족했다고 해야 할까요... 대신에 우리가 설치했으므로 이제 추가할 수 있다는 IntelliJ가 감지한 Android API 29 플랫폼 Android SDK 옵션을 선택할 겁니다.

그리고 경고가 없어졌어요. 프로젝트 구조를 간략히 살펴보면, IntelliJ가 새 API를 별도의 항목으로 추가했음을 알 수 있어요. 그래서 첫 번째를 제거하기로 결정할게요.

<div class="content-ad"></div>

## 안드로이드 가상 장치 (AVD) 만들기

당신의 IntelliJ 오른쪽 가장자리, 세 개의 플러터 아이콘(플러터 인스펙터, 플러터 성능 및 플러터 아웃라인 도구) 위에 장치 관리자가 있습니다:

![Device Manager](/assets/img/2024-06-21-FlutterinIntelliJ_11.png)

만약 어떤 이유로 그곳에 없다면, 다시 두 번 Shift를 누르세요.

<div class="content-ad"></div>

이미 미리 설정된 장치가 있어서 시스템 이미지를 다운로드하여 사용할 수 있습니다. 대신 나는 그것을 무시하고 + 버튼을 눌러 내 장치를 스스로 설정할 것입니다.

과정은 매우 간단합니다. 먼저 전화기 크기를 선택하세요:

![전화기 크기 선택](/assets/img/2024-06-21-FlutterinIntelliJ_12.png)

그런 다음 장치가 실행 중이어야하는 시스템 이미지를 선택하세요. 이 이미지를 사용하는 것이 처음이라면, 다운로드해야 합니다.

<div class="content-ad"></div>

<img src="/assets/img/2024-06-21-FlutterinIntelliJ_13.png" />

마지막으로 이름을 지어주면 끝입니다. (고급 옵션은 일단 건너 뜁니다.)

## AVD에서 애플리케이션 실행

장치 드롭다운에서 장치 목록을 새로 고침한 후, 이제 우리가 에뮬레이터에서 생성한 AVD를 시작할 수 있습니다.

<div class="content-ad"></div>


<img src="/assets/img/2024-06-21-FlutterinIntelliJ_14.png" />

IntelliJ에서 기기를 부팅하는 데 시간이 걸릴 수 있지만 결국 AVD가 준비되고 IntelliJ에서 `no device selected`이라고 표시된 이전 기기가 표시될 것입니다.

만약 Android Emulator를 열 때 "아무 일도 일어나지 않는" 것에 혼란스러워한다면, 기본적으로 IntelliJ의 Android 에뮬레이터가 Running Devices 도구 창에서 실행되기 때문입니다. 그 창은 새로운 기기를 시작할 때 자동으로 열리지 않습니다.

<img src="/assets/img/2024-06-21-FlutterinIntelliJ_15.png" />


<div class="content-ad"></div>

이 동작은 Android 에뮬레이터 설정에서 변경할 수 있어요 (찾으려면 double Shift를 누르세요), 그리고 Launch in a tool window 옵션을 선택하세요.

![이미지](/assets/img/2024-06-21-FlutterinIntelliJ_16.png)

여기에는 "앱을 실행할 때 Running Devices 도구 창을 열기"라는 옵션이 있다고 적혀 있지만, 제 경우에는 그렇게 되지 않았어요.

![이미지](/assets/img/2024-06-21-FlutterinIntelliJ_17.png)

<div class="content-ad"></div>

메인.dart 드롭다운 옆의 초록색 플레이 버튼 또는 버그 버튼으로 어플리케이션을 실행할 수 있습니다.

# 실제 기기에서 앱 실행하기

가끔은 실제 기기에서 앱을 실행하는 것이 필요할 때가 있습니다.

상당히 간단한 과정입니다.

<div class="content-ad"></div>

- 기기에서 개발자 모드를 활성화하세요 (특정 기기에 대해 하는 방법을 구글에서 검색해보세요).
- USB 디버깅을 켜세요.
- 안드로이드 기기를 개발용 컴퓨터에 연결하고, 기기에서 USB 디버깅을 허용하세요.
- 이전에 AVD를 선택했던 드롭다운 메뉴에서 기기를 선택하세요.
- IntelliJ에서 애플리케이션을 실행하세요.

# Flutter doctor를 성공적으로 완료하기

애플리케이션이 실행되지만, flutter 설치를 확인하기 위해 flutter doctor를 실행하면 여전히 flutter가 불평합니다:

![이미지](/assets/img/2024-06-21-FlutterinIntelliJ_18.png)

<div class="content-ad"></div>

우선, Command Line 도구에 대해 이야기해볼게요. IntelliJ에서 다시 설치할 수 있는 도구입니다. Android SDK 매니저에서 SDK Tools 탭에는 CLI 도구를 설치할 수 있는 옵션이 있습니다.

이제 새 터미널에서 아래 명령어를 실행해봅시다.

```js
flutter doctor --android-licenses
```

<div class="content-ad"></div>


![Flutter doctor](/assets/img/2024-06-21-FlutterinIntelliJ_20.png)

And if we run flutter doctor again,

![Android Studio warning](/assets/img/2024-06-21-FlutterinIntelliJ_21.png)

Flutter warns that it cannot find Android Studio, but that’s ok, we don’t care about that anyway.


<div class="content-ad"></div>

# 요약

다시 한 번 강조하자면, 안드로이드 에뮬레이터에서 플러터 앱을 성공적으로 시작하기 위해 해야 할 단계는 다음과 같습니다:

- 머신에 Flutter 설치하기

```js
sudo snap install flutter --classic
```

<div class="content-ad"></div>

- IntelliJ를 설치해주세요 (아직 설치하지 않았다면)
- IntelliJ에 Flutter 및 Dart 플러그인을 설치해주세요
- IntelliJ에서 새로운 Flutter 프로젝트 생성하기 (이 과정에서 데모 앱이 만들어집니다)
- IntelliJ에서 Android SDK 매니저 열기
- SDK 매니저에서 편집 옵션을 눌러 Android SDK를 설치해주세요
- SDK 플랫폼 탭에서 데모 앱이 요구하는 API 레벨의 Android SDK를 추가로 설치해주세요
- 프로젝트가 방금 설치한 Android SDK를 사용하도록 구성해주세요
- 프로젝트 구조에서 오래된 것(들)은 제거하고 Android SDK가 하나만 추가되어 있는지 확인해주세요
- Device Manager를 사용하여 새로운 안드로이드 가상 장치를 만들어주세요
- IntelliJ에서 생성한 AVD를 선택하여 앱을 실행해주세요
- Running Devices 탭에서 안드로이드 에뮬레이터를 찾아주세요
- 선택적으로 IntelliJ를 구성하여 에뮬레이터를 별도의 창에서 열도록 설정해주세요

그러면 flutter doctor에서 완전히 만족스러운 결과를 얻을 수 있을 것입니다:

- IntelliJ의 Android SDK 매니저의 SDK 도구 탭에서 android SDK 명령줄 도구를 설치해주세요
- 새 터미널에서 flutter가 받아들이기를 원하는 모든 라이선스를 수락해주세요

```js
flutter doctor --android-licenses
```