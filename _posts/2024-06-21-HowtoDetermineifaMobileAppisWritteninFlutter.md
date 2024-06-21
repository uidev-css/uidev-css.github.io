---
title: "Flutter로 작성된 모바일 앱인지 확인하는 방법"
description: ""
coverImage: "/assets/img/2024-06-21-HowtoDetermineifaMobileAppisWritteninFlutter_0.png"
date: 2024-06-21 22:34
ogImage: 
  url: /assets/img/2024-06-21-HowtoDetermineifaMobileAppisWritteninFlutter_0.png
tag: Tech
originalTitle: "How to Determine if a Mobile App is Written in Flutter"
link: "https://medium.com/@vitalib/how-to-determine-if-a-mobile-app-is-written-in-flutter-aad911b18c79"
---


안녕하세요, Flutter 팬 여러분들! 오늘은 모바일 앱이 Flutter로 작성되었는지 확인하는 방법에 대해 이야기해보겠습니다. 이 지식은 경쟁 조사를 위해 개발자와 매니저들에게 유용하며, 자신이 좋아하는 앱의 내부를 더 알고 싶어하는 기술 애호가들에게도 도움이 될 수 있습니다. 그래서, 더 이상 말뿐인 소리는 그만하고 시작해봅시다.

# 부드러운 인터페이스와 복잡한 애니메이션

- 복잡성: 1
- 정확성: 2

Flutter는 부드럽고 아름다운 인터페이스를 만들어내는 능력으로 유명합니다. 만약 예상치 못한 아름다움과 부드러움을 발견한다면, 그것이 Flutter 앱일 수 있습니다. 그러나, 좋은 디자인과 애니메이션 부드러움은 다른 프레임워크로도 구현할 수 있기 때문에 이것은 단지 많은 조직 중 하나에 불과합니다. 반면, 앱이 끊기는 애니메이션과 오랜 응답 시간을 보인다면, 그 또한 Flutter 앱일 수 있습니다. 대부분, 개발자들이 이 앱에 큰 노력을 기울이지 않았거나, 클라이언트가 비용을 줄이기로 결정했을 수 있습니다.

<div class="content-ad"></div>

# 두 손가락 스크롤링 속도가 두 배 빨라졌어요

- 복잡도: 1
- 정확도: 3

Flutter 앱에서는 네이티브 앱과 비교했을 때 두 손가락으로 스크롤링 하는 것이 두 배 빨라집니다. 게다가, 세 손가락 스크롤링은 세 배 빠릅니다. 그러나 Flutter 개발자들은 항상 개선해 나가는 중이며, 최근에 이 "버그"를 수정했기 때문에 이 방법은 이전만큼 신뢰할 수 없을 수도 있습니다.

# 공식 Flutter 페이지에 피처된 앱들

<div class="content-ad"></div>

- 복잡도: 1
- 정확성: 5

가장 신뢰할 수 있는 방법은 공식 플러터 페이지를 확인하는 것입니다. 그곳에는 플러터로 개발된 앱들의 모음을 볼 수 있습니다.

![이미지](/assets/img/2024-06-21-HowtoDetermineifaMobileAppisWritteninFlutter_0.png)

# 온라인 서비스 플러터헌트

<div class="content-ad"></div>

- 복잡도: 1
- 정확도: 4

FlutterHunt은 Flutter로 개발된 앱에 대한 정보를 수집하는 온라인 데이터베이스입니다. 그런데 이 서비스의 제작자와 채팅할 수도 있어요.

![이미지](/assets/img/2024-06-21-HowtoDetermineifaMobileAppisWritteninFlutter_1.png)

# 플러터 상어 앱

<div class="content-ad"></div>

- 복잡성: 1
- 정확성: 4

네, 다른 앱이 플러터를 사용하는지 여부를 결정하는 데 전용 앱이 있습니다! 기기에 설치된 앱을 분석하고 해당 앱이 플러터로 개발되었는지 식별합니다. 신기하게도, 플러터 Shark는 플러터로 작성되었습니까?

![이미지](/assets/img/2024-06-21-HowtoDetermineifaMobileAppisWritteninFlutter_2.png)

# 개발 속도 및 통합 코드베이스

<div class="content-ad"></div>

- 복잡도: 3
- 정확성: 2

플러터를 사용하면 Android와 iOS용 앱을 생성하는 데 동일한 코드를 사용할 수 있어 개발 프로세스를 크게 가속화할 수 있습니다. 한 회사가 새로운 기능을 두 플랫폼에서 동시에 빠르게 출시한다면, 그들은 플러터를 사용하고 있을 수도 있습니다.

# 개발자 메뉴에서 "레이아웃 경계 표시" 활성화하기

- 복잡도: 4
- 정확성: 4

<div class="content-ad"></div>

이 방법은 강력한 중급 개발자를 대상으로 합니다. 안드로이드 개발자 설정에서 "레이아웃 경계 표시" 옵션을 활성화하여 인터페이스 요소의 경계를 볼 수 있습니다. 플러터 앱은 자체 렌더링 메커니즘이 있기 때문에 네이티브 앱과 달리 인터페이스 요소에는 경계가 없습니다.

## 안드로이드 개발자 메뉴에서 "레이아웃 경계 표시"를 활성화하는 방법:

단계 1: 개발자 모드 활성화

- 안드로이드 기기의 설정을 엽니다.
- 아래로 내려 "휴대폰 정보"를 찾습니다.
- 빌드 번호를 찾습니다 (소프트웨어 정보 또는 휴대폰 정보 섹션에 있을 수 있습니다).
- 빌드 번호를 7번 탭합니다. "개발자가 되고 있습니다"라는 메시지가 표시됩니다.

<div class="content-ad"></div>

**단계 2: 레이아웃 바운드 보기 활성화**

- 메인 설정 메뉴로 돌아갑니다.
- 개발자 모드를 활성화한 후 나타난 "개발자용" 또는 "개발자 옵션" 항목으로 스크롤합니다.
- "개발자 옵션"을 선택합니다.
- "디버깅" 또는 "시각화" 섹션으로 스크롤합니다.
- "레이아웃 바운드 보기" 또는 "레이아웃 테두리 표시" 옵션을 찾아 활성화합니다.

# 디버깅 정보 및 개발자 도구

- 복잡성: 5
- 정확도: 5

<div class="content-ad"></div>

진짜 고급 사용자를 위한 방법을 찾아왔어요. Flutter 앱은 작동 방식과 시스템과의 상호 작용에 따라 구별될 수 있는 특정 특성이 있어요. 디버깅 중에 접근할 수 있어요. Android Studio와 Visual Studio Code를 사용하면 애플리케이션의 라이프사이클, 시스템과의 상호 작용 및 기타 기술적 측면을 관찰할 수 있어요.

## 다음은 방법이에요:

- 기기를 컴퓨터에 연결하세요. 기기의 개발자 모드가 활성화되어 있고 USB 디버깅이 허용되어 있는지 확인하세요.
- 즐겨 사용하는 코드 편집기를 열어주세요. Flutter와 Dart 플러그인이 설치된 Android Studio 또는 Visual Studio Code를 시작하세요.
- ADB (Android Debug Bridge)를 시작하세요. 터미널이나 명령 프롬프트를 열고 adb devices 명령을 입력하여 기기가 연결되어 있는지 확인하세요.
- 애플리케이션을 기기에서 시작하세요. 기기에서 원하는 Flutter 앱을 열어주세요.
- Android Studio에서 Logcat을 엽니다. Android Studio에서는 화면 하단의 "Logcat" 탭을 선택하세요. Visual Studio Code에서는 통합 터미널을 사용하여 해당 명령을 실행하여 로그를 볼 수 있어요.
- 로그 출력을 애플리케이션 식별자로 필터링하세요.
- Flutter 및 Dart VM에 대한 언급을 찾아보세요. Flutter 앱을 시작하고 실행할 때, 로그에 Dart VM 또는 Flutter Engine과 관련된 메시지가 표시될 수 있어요.
- 이 방법은 Flutter를 사용하여 개발된 앱을 확인하는 가장 신뢰할 수 있는 방법 중 하나에요.

# APK 파일 분석

<div class="content-ad"></div>

- 복잡성: 666
- 정확도: 5

이전 방법들이 만족스럽지 않다면, APK를 언패킹하여 애플리케이션을 심층적으로 탐색해볼 수 있습니다.

## 단계별로:

- 애플리케이션의 APK를 다운로드합니다. 다양한 온라인 서비스나 도구를 사용하여 Google Play Store에서 APK를 직접 다운로드할 수 있습니다.
- APK를 "언팩"할 도구를 사용합니다. 이 작업에 대한 인기 있는 도구 중 하나는 APKTool이며, APK를 디컴파일하고 내용을 확인할 수 있는 다른 유사한 도구도 사용할 수 있습니다.
- libflutter.so 및 kernel_blob.bin 파일을 찾습니다. 디컴파일된 APK를 열고 ./lib/ 및 ./assets/flutter_assets/ 디렉토리를 찾아봅니다.

<div class="content-ad"></div>

## 왜 이것이 동작하는지:

- libflutter.so는 안드로이드에서 Dart 코드를 로드하고 실행하는 데 사용되는 Flutter 전용 라이브러리입니다.
- kernel_blob.bin은 애플리케이션의 컴파일된 Dart 코드를 포함하고 있습니다.

이 방법은 좀 더 기술적인 지식이 필요하며, 진정한 엔지니어를 위한 것입니다.

이 방법은 Alexandra Kovaleva가 제안했으며, 그녀에게 특별한 감사의 말씀을 전합니다.

<div class="content-ad"></div>

# 결론

그게 다야! 이 방법들이 플러터의 세계에 대해 더 많이 알게 해주고 당신에게 자극을 주어 여러분만의 프로젝트를 만들게 하는 데 도움이 되길 바랍니다.

흥미롭고 유용하다면, 링크드인과 X(트위터)에서 저와 함께하세요.