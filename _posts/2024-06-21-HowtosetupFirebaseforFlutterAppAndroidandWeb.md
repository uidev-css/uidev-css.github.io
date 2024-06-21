---
title: "Flutter 앱 설정을 위한 Firebase 설정 방법  Android 및 Web"
description: ""
coverImage: "/assets/img/2024-06-21-HowtosetupFirebaseforFlutterAppAndroidandWeb_0.png"
date: 2024-06-21 23:21
ogImage: 
  url: /assets/img/2024-06-21-HowtosetupFirebaseforFlutterAppAndroidandWeb_0.png
tag: Tech
originalTitle: "How to setup Firebase for Flutter App — Android and Web."
link: "https://medium.com/@dev.hassankhan/how-to-setup-firebase-for-flutter-app-android-and-web-afa7abf488d2"
---


![이미지](/assets/img/2024-06-21-HowtosetupFirebaseforFlutterAppAndroidandWeb_0.png)

소개:

Firebase는 모바일 및 웹 응용 프로그램을위한 다양한 백엔드 서비스를 제공하는 강력하고 다재다능한 플랫폼입니다. Flutter 개발자들에게는 Firebase를 프로젝트에 통합하여 응용 프로그램의 기능을 향상시키고 사용자 참여를 개선할 수 있습니다. 이 블로그에서는 Android, iOS 및 웹 플랫폼에 Firebase를 연결하는 방법에 대한 단계별 매뉴얼 가이드를 안내해 드리겠습니다.

단계 1: Firebase 프로젝트 설정하기

<div class="content-ad"></div>

비디오 튜토리얼 "Flutter용 Firebase 설정"을 시청해보세요.

1. Firebase 콘솔(https://console.firebase.google.com/)에 가서 Google 계정으로 로그인하세요.

2. 새 Firebase 프로젝트를 생성하려면 '프로젝트 추가' 옵션을 클릭하세요.

![이미지](/assets/img/2024-06-21-HowtosetupFirebaseforFlutterAppAndroidandWeb_1.png)

<div class="content-ad"></div>

3- 프로젝트 이름을 입력하고 국가 또는 지역을 선택하세요. "계속"을 클릭하세요.

![이미지](/assets/img/2024-06-21-HowtosetupFirebaseforFlutterAppAndroidandWeb_2.png)

4- 다음 화면에서 프로젝트에 Google Analytics를 활성화하세요 (선택 사항이지만 더 나은 통찰력을 위해 추천됨). "계속"을 클릭하세요.

![이미지](/assets/img/2024-06-21-HowtosetupFirebaseforFlutterAppAndroidandWeb_3.png)

<div class="content-ad"></div>

5 - Google Analytics를 구성하세요. "계정 선택"을 클릭한 후 "Firebase의 기본 계정"을 선택하세요. "프로젝트 생성"을 클릭하세요.

![이미지](/assets/img/2024-06-21-HowtosetupFirebaseforFlutterAppAndroidandWeb_4.png)

프로젝트를 생성한 후 Firebase 로딩 표시기가 나타날 것이며 5초가 소요될 것입니다. "계속"을 클릭하세요.

![이미지](/assets/img/2024-06-21-HowtosetupFirebaseforFlutterAppAndroidandWeb_5.png)

<div class="content-ad"></div>

Firebase 프로젝트가 성공적으로 생성되었으니, 이제 Flutter 애플리케이션을 해당 Firebase 프로젝트에 추가할 차례입니다.

Step 2: Firebase에 Flutter Android 앱 추가하기

1- Firebase 프로젝트를 생성한 후 “Add app” 버튼(안드로이드 로고로 표시됨)을 클릭합니다.

![이미지](/assets/img/2024-06-21-HowtosetupFirebaseforFlutterAppAndroidandWeb_6.png)

<div class="content-ad"></div>

2- "Android 패키지 이름", "앱 별명" (선택 사항) 및 "디버그 서명 인증서 SHA-1" (선택 사항)을 제공하여 앱을 등록하세요.

![이미지](/assets/img/2024-06-21-HowtosetupFirebaseforFlutterAppAndroidandWeb_7.png)

3- "Android 패키지 이름"을 가져오려면 IDE (Android Studio 또는 Vs Code)를 열고 "android" 디렉토리에 있는 앱 레벨 "build.gradle" 파일을 엽니다.

또한 기본 "minSdkVersion"을 "21"로 변경하세요. 왜냐하면 일부 Firebase 종속성이 더 높은 SDK 버전을 요구하기 때문입니다.

<div class="content-ad"></div>

<img src="/assets/img/2024-06-21-HowtosetupFirebaseforFlutterAppAndroidandWeb_8.png" />

'Android package name'을 얻은 후에 해당 필드에 붙여 넣고 "앱 등록"을 클릭합니다.

단계 3: 구성 파일 다운로드

"google-services.json" 파일을 다운로드하고 "android/app" 디렉토리에 붙여 넣습니다. 그런 다음 "다음"을 클릭하십시요.

<div class="content-ad"></div>


![How to set up Firebase for Flutter App Android and Web](/assets/img/2024-06-21-HowtosetupFirebaseforFlutterAppAndroidandWeb_9.png)

이제 다음 단계는 Flutter 앱에 Firebase SDK를 추가하는 것입니다. Google services Gradle 플러그인을 사용하여 google-services.json 구성 값을 Firebase SDK가 액세스할 수 있도록 만들어야 합니다.

![How to set up Firebase for Flutter App Android and Web](/assets/img/2024-06-21-HowtosetupFirebaseforFlutterAppAndroidandWeb_10.png)

프로젝트 수준의 "build.gradle" 파일에 플러그인을 의존성으로 추가하세요.


<div class="content-ad"></div>

루트 수준(프로젝트 수준) Gradle 파일 (`project`/build.gradle):

“id ‘com.google.gms.google-services’ version ‘4.3.15’ apply false”를 “classpath “com.google.gms:google-services:4.3.15””로 대체하세요.

![이미지](/assets/img/2024-06-21-HowtosetupFirebaseforFlutterAppAndroidandWeb_11.png)

그런 다음, 앱 수준의 모듈 build.gradle 파일에서 앱에서 사용할 google-services 플러그인 및 Firebase SDK를 추가하세요.

<div class="content-ad"></div>

아래는 Markdown 형식으로 테이블을 표현해 봅니다.


| 이벤트 | 장소     | 날짜          |
|--------|-----------|---------------|
| A      | Seoul     | 2023년 12월 1일 |
| B      | Busan     | 2024년 3월 15일  |
| C      | Incheon   | 2024년 7월 8일   |


위의 내용을 참고해 주세요!

<div class="content-ad"></div>

Google-services.json 파일을 "앱 수준" 및 "프로젝트 수준" Gradle 파일에 추가한 후에 "다음"을 클릭하세요.

이제 여기서 "콘솔로 계속"을 클릭하고 축하합니다! Android 앱이 Firebase와 성공적으로 연결되었습니다.

<img src="/assets/img/2024-06-21-HowtosetupFirebaseforFlutterAppAndroidandWeb_14.png" />

단계 4- Firebase에 웹 앱 추가

<div class="content-ad"></div>

우리의 Android 앱이 Firebase 콘솔에 성공적으로 추가되었으니 다음 앱인 Web을 추가할 차례입니다. 계속하려면 Firebase 콘솔에서 "웹 아이콘"을 클릭하세요.

![웹 아이콘](/assets/img/2024-06-21-HowtosetupFirebaseforFlutterAppAndroidandWeb_15.png)

여기서 "앱 별명"이 필요하며, 이 앱을 위한 Firebase 호스팅을 설정하려면 체크박스를 확인하세요. "앱 등록"을 클릭하세요.

![앱 등록](/assets/img/2024-06-21-HowtosetupFirebaseforFlutterAppAndroidandWeb_16.png)

<div class="content-ad"></div>

다음 단계에서 두 가지 방법을 적용할 수 있습니다. 하나는 "npm" (노드 패키지 관리자)를 사용하는 경우 다음 명령을 실행하고 다음 데이터를 추가할 수 있습니다.

두 번째 방법은 모두 "main.dart"에 수동으로 데이터를 추가하는 것입니다. 저는 "npm"이 없어서 두 번째 방법을 사용할 것입니다 ㅋㅋ

<img src="/assets/img/2024-06-21-HowtosetupFirebaseforFlutterAppAndroidandWeb_17.png" />

Step 5 — Firebase 종속성 추가

<div class="content-ad"></div>

"위 데이터를 'main.dart'에 추가하려면 먼저 'pubspec.ymal' 파일에 몇 가지 Firebase 종속성을 추가해야 합니다. 'cupertino_icons' 바로 아래에 'firebase_core' 패키지를 'pubspec.ymal'에 추가하세요.

<img src="/assets/img/2024-06-21-HowtosetupFirebaseforFlutterAppAndroidandWeb_18.png" />

이 패키지를 통해 Firebase를 앱에 초기화할 수 있습니다. 이제 'main.dart'를 열고 이러한 변경 사항을 만들어보세요.

단계 6: Firebase 초기화"

<div class="content-ad"></div>

우선 "firebase_core" 라이브러리를 import 하겠습니다.

```dart
import 'package:firebase_core/firebase_core.dart';
```

그리고 main() 메서드 안에서 Firebase를 초기화합니다. "WidgetsFlutterBinding.ensureInitialized();" 바로 아래에, 만약 앱이 Web인지 확인하고 해당 구성을 실행하거나 그렇지 않은 경우에는 "await Firebase.initializeApp();"을 초기화합니다.

![Firebase 설정 이미지](/assets/img/2024-06-21-HowtosetupFirebaseforFlutterAppAndroidandWeb_19.png)

<div class="content-ad"></div>

7단계: Firebase 통합 테스트

이제 모든 구성이 완료되었습니다. 모든 구성이 올바르게 작동하는지 확인할 때입니다. Firebase가 플러터 프로젝트와 올바르게 통합되었는지 확인하기 위해 Android 에뮬레이터 또는 실제 기기에서 앱을 실행하십시오. Firebase 초기화와 관련된 오류가 없는지 확인하기 위해 로그를 확인하십시오.

Firebase 통합을 확인하기 위해 Web에 대해서도 동일한 프로세스를 반복하십시오.

# 결론

<div class="content-ad"></div>

축하합니다! Flutter 프로젝트를 안드로이드 및 웹 플랫폼에 수동으로 Firebase와 연결하는 데 성공했습니다. Firebase가 앱에 통합되었으므로 인증, Firestore, 클라우드 스토리지 등과 같은 다양한 Firebase 서비스를 활용하여 강력하고 확장 가능하며 매력적인 애플리케이션을 개발할 수 있습니다.

Firebase SDK를 정기적으로 업데이트하고 특정 서비스 및 고급 구성에 대한 자세한 정보는 공식 Firebase 문서를 참조하십시오. 즐거운 코딩 되세요!