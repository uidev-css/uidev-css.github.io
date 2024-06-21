---
title: "다양한 Firebase 프로젝트로 Android 및 iOS용 Flutter 빌드 플래버 구성 방법"
description: ""
coverImage: "/assets/img/2024-06-21-BuildflavorsinFlutterAndroidandiOSwithdifferentFirebaseprojectsperflavor_0.png"
date: 2024-06-21 20:53
ogImage: 
  url: /assets/img/2024-06-21-BuildflavorsinFlutterAndroidandiOSwithdifferentFirebaseprojectsperflavor_0.png
tag: Tech
originalTitle: "Build flavors in Flutter (Android and iOS) with different Firebase projects per flavor"
link: "https://medium.com/@animeshjain/build-flavors-in-flutter-android-and-ios-with-different-firebase-projects-per-flavor-27c5c5dac10b"
---



[업데이트 2020년 3월 7일]
- iOS와 Android에서 다른 플레이버용 앱 아이콘 설명 추가함


다양한 시도와 오류 끝에, 특히 iOS에서 플레이버가 작동하도록 하기 위해 이 기사를 쓰기로 결정했습니다. 그래서 곧 바로 플러터에서 플레이버 빌드에 대해 자세히 알아보겠습니다.

## 플레이버가 필요한 이유

플레이버는 일반적으로 앱을 dev 및 prod와 같은 다른 환경으로 빌드하는 데 사용됩니다.
예를 들어,
- 앱의 개발 버전은 dev.api.myapp.com에 위치한 API 호스트를 가리키도록 할 수 있음
- 그리고 앱의 프로덕션 버전은 api.myapp.com을 가리키도록 할 수 있음


<div class="content-ad"></div>

이 값들을 변수로 하드 코딩하고 각 환경에 앱을 수동으로 빌드하는 대신, 올바른 방법은 플레이버를 사용하고 빌드 시간 구성으로 이러한 값들을 제공하는 것입니다.

재밌게도, 이 기사는 어떻게 다른 API 호스트를 처리하는지에 대한 사용 사례를 다루지 않습니다. 또 다른 기사가 이를 잘 다룬다고 생각하며, 그 정보를 반복하고 싶지는 않았어요. 동일한 내용에 대한 자세한 내용은 "Flutter Ready to Go"를 참조해주세요. (이 기사에서 다루는 내용은 다음 섹션에서 설명합니다)

거의 모든 앱을 출시하는 사람들이 플레이버를 사용해야 한다고 생각하지만, 대부분의 사람들이 더 오래 동안 사용하지 않는다는 것을 알아봤어요. 보통 초기 설정 관성은 나중에 처리할 수 있을만큼 충분하기 때문에, 최종적으로 개발자들이 의도치 않게 시간을 많이 낭비하게 된다는 것을 알 수 있어요. 유감스럽게도, Flutter의 경우 아직도 *그렇게* 간단하게 설정되지 않으므로, 이 기사가 도움이 되기를 바랍니다.

## Flutter 플레이버 문서에 대한 한 가지 참고사항

<div class="content-ad"></div>

플러터 플레이버 지원은 공식 문서에서 아직 매우 잘 문서화되어 있지 않습니다. 이 문제는 아래의 세 가지 기사를 가리키고 있습니다.

- Flutter 앱의 플레이버 생성(Android 전용)
- Flutter ready to go (Android 전용)
- Flutter에 플레이버 주입(Android 및 iOS)

Android 설정은 상당히 간단합니다. 반면 iOS 설정은 자세한 부분이 부족하고 따라가기 어려웠습니다. 그래서 이 기사를 쓴 이유가 두 가지 있습니다.

- 위의 기사들 위에 쌓아서, 각기 다른 플레이버에 대해 Firebase 프로젝트를 설정하는 방법도 설명합니다.
- iOS 플레이버 설정에 대해 더 깊게 파고들어 단계를 더 명확하게 설명하려고 했습니다. 그래서 당신이 이 작업을 수행하는 데 내가 한 것 만큼의 시간을 들이지 않으셔도 되도록 했습니다.

<div class="content-ad"></div>

## 이 튜토리얼의 접근 방식

두 가지 플레이버(dev, prod)가 있는 샘플 앱을 만들어 볼 것입니다.
각 단계 후에 커밋이 있으므로 코드 차이를 살펴보고 모든 변경 사항을 이해할 수 있습니다. 물론 상세한 지침도 제공하겠습니다. 이미 있는 앱에 대해서도 쉽게 이 지침을 사용할 수 있을 것입니다.

샘플 앱은 여기 있습니다

멋지죠? 그럼 이제 단계를 따라 출발해봅시다...

<div class="content-ad"></div>

## 단계 1: 기본 플러터 앱 초기화

기본 플러터 프로젝트를 생성하려면 flutter create flavor_test을 실행하세요. 특별한 것은 없어요.. 이것은 샘플 앱의 첫 번째 커밋입니다.

![이미지](/assets/img/2024-06-21-BuildflavorsinFlutterAndroidandiOSwithdifferentFirebaseprojectsperflavor_0.png)

## 단계 2: 앱을 Firebase에 연결하도록 구성하기

<div class="content-ad"></div>

<img src="/assets/img/2024-06-21-BuildflavorsinFlutterAndroidandiOSwithdifferentFirebaseprojectsperflavor_1.png" />

Firebase 콘솔에서 iOS 및 Android 앱을 만들고 각각 GoogleService-Info.plist 및 google-services.json을 다운로드하세요. Firebase를 Flutter 프로젝트에 추가하는 자세한 지침은 여기에서 확인할 수 있습니다 - https://firebase.google.com/docs/flutter/setup

이 단계에서는 main.dart 파일을 업데이트하여 로컬이 아닌 Firebase Realtime DB에 카운터를 저장하였습니다. Firebase Realtime DB를 콘솔을 통해 설정하고 쓰기 액세스를 허용하는 보안 규칙을 추가해주세요.

이 커밋 후 앱은 아래와 같이 나타납니다 -

<div class="content-ad"></div>


![이미지](/assets/img/2024-06-21-BuildflavorsinFlutterAndroidandiOSwithdifferentFirebaseprojectsperflavor_2.png)

다음 링크로 변경 사항을 확인할 수 있습니다 — 

Code Diff : Step 1 to Step 2
https://github.com/animeshjain/flavor_test/compare/step_1_init...step_2_firebase


## 단계 3: Android에 빌드 플레이버 추가하기

<div class="content-ad"></div>

운영 환경용 새 Firebase 프로젝트를 만들 수 있습니다

![이미지](/assets/img/2024-06-21-BuildflavorsinFlutterAndroidandiOSwithdifferentFirebaseprojectsperflavor_3.png)

<div class="content-ad"></div>

프로젝트에 Android 앱도 만들어서 google-services.json 파일을 다운로드하고 손쉽게 접근할 수 있도록 해주세요. 곧 앱에 추가할 예정이에요.

재미로, --flavor 플래그를 사용하여 앱을 실행하려고 시도할 때 플러터가 무슨 말을 하는지 확인해봅시다.

![이미지](/assets/img/2024-06-21-BuildflavorsinFlutterAndroidandiOSwithdifferentFirebaseprojectsperflavor_4.png)

app/build.gradle에 flavors를 추가하고 다음과 같이 되어야 해요.

<div class="content-ad"></div>

<img src="/assets/img/2024-06-21-BuildflavorsinFlutterAndroidandiOSwithdifferentFirebaseprojectsperflavor_5.png" />

개발 플레이버는 기본 applicationId로 com.kanily.flavortest를 사용하며, 프로덕션 플레이버는 프로덕션 플레이버 정의에서 정의된 flavor별 applicationId인 com.kanily.flavortest.prod를 사용할 것입니다. 또한 AndroidManifest.xml에서 앱 이름을 하드 코딩하는 대신에 사용 중인 app_name이라는 문자열 리소스를 정의했습니다. 마지막으로, google-services.json은 소스 폴더 하위에 flavor와 일치하는 이름의 서브폴더에 넣을 수 있습니다. Firebase 문서에서 -

<img src="/assets/img/2024-06-21-BuildflavorsinFlutterAndroidandiOSwithdifferentFirebaseprojectsperflavor_6.png" />

따라서 이러한 설정으로 관리할 수 있습니다.

<div class="content-ad"></div>

- 각각 다른 플레이버용 앱 ID를 사용하여 장치에 여러 플레이버를 동시에 설치할 수 있습니다.
- 각기 다른 애플리케이션 이름을 사용하여 사용자/테스터/개발자가 쉽게 구별할 수 있습니다.
- 각 플레이버가 고유한 Firebase 프로젝트를 가리키게 됩니다 (파일을 플레이버 이름과 동일한 폴더에 배치하는 규칙에 따라 자동으로 처리됩니다).

이제 다음 명령어를 사용하여 앱을 실행할 수 있습니다.

flutter run --flavor dev 또는 flutter run --flavor prod

이제 두 앱을 장치에 설치하고 병렬로 실행할 수 있습니다.

<div class="content-ad"></div>

위의 코드 변경 사항을 확인하려면 다음과 같이 코드를 보시면 됩니다 —

```js
코드 변경 내역: Step 2부터 Step 3로
https://github.com/animeshjain/flavor_test/compare/step_2_firebase...step_3_android_flavors
```

## 단계 4: iOS에 빌드 플레이버 추가

iOS 플레이버를 설정하는 것은 더 복잡할 수 있습니다. 또한, iOS 구성은 대부분 XCode UI를 사용하여 진행되며 텍스트 편집기에서 설정 파일을 편집하는 것이 아닙니다 😱. 이 설명은 말로 설명하기에 상당히 복잡하기 때문에 이해를 돕기 위해 모든 조치를 녹화하고 스크린캐스트 GIF로 제공했습니다. 그러니 물 한 잔 마시고 허리띠를 매고 준비하세요…

<div class="content-ad"></div>

플러터 런 명령을 사용하여 iOS 장치/시뮬레이터를 대상으로 실행해 봅시다.


flutter run --flavor dev


![이미지](/assets/img/2024-06-21-BuildflavorsinFlutterAndroidandiOSwithdifferentFirebaseprojectsperflavor_7.png)

이제 custom schemas라는 것을 설정해야 하는 것 같아요. Xcode를 열고 ios/Runner.xcworkspace를 열어 보겠습니다.

<div class="content-ad"></div>

그리고, 여기에 개발자라고 불리는 사용자 지정 체계를 설정하는 방법이 있습니다...

![image](https://miro.medium.com/v2/resize:fit:1400/1*tctD2CuUZuCV4FcFIXXddw.gif)

이제 다시 flutter run --flavor dev를 실행합니다...

![image](/assets/img/2024-06-21-BuildflavorsinFlutterAndroidandiOSwithdifferentFirebaseprojectsperflavor_8.png)

<div class="content-ad"></div>

플러터는 Debug-dev 나 유사한 이름의 빌드 구성을 기대한다고 에러 메시지에 나와 있네요. 이 빌드 구성들을 만들어봅시다...

![image](https://miro.medium.com/v2/resize:fit:1400/1*XsDo_Kv4UPiS-Qeix9YEEA.gif)

다시 flutter run --flavor dev을 시도해봅니다...

![image](/assets/img/2024-06-21-BuildflavorsinFlutterAndroidandiOSwithdifferentFirebaseprojectsperflavor_9.png)

<div class="content-ad"></div>

그럼 이제 잘 되었네요. 그러나 지금은 빌드 구성을 사용자 정의하지 않았기 때문에 앱은 이전과 동일한 구성으로 실행 중입니다. 기본 빌드 구성 및 빌드 스키마를 prod로 변경해보겠습니다.

![이미지](https://miro.medium.com/v2/resize:fit:1400/1*3TPzQMrFbtwBoe3-seCDhg.gif)

빌드 구성을 복제했기 때문에 개발 구성은 아직 기존 스키마(이제 prod로 변경된)에 연결되어 있습니다. 이것도 수정해 봅시다...

![이미지](https://miro.medium.com/v2/resize:fit:1400/1*qXSwfOJfHFWmBgnb2Rqzrw.gif)

<div class="content-ad"></div>

이제 두 개의 스키마가 각각의 빌드 구성에 연결되었습니다. 이제 스키마별로 사항을 사용자 정의할 수 있습니다. 우선 두 스키마를 위해 앱 번들 식별자를 다르게 변경해 봅시다. 안드로이드에서 우리의 프로덕션 애플리케이션 식별자는 com.kanily.flavortest.prod이었는데, iOS의 번들 식별자는 안드로이드의 애플리케이션 식별자와 동일합니다. 그래서 우리의 프로덕션 번들 식별자를 com.kanily.flavortest.prod로 변경해 봅시다...

![이미지](https://miro.medium.com/v2/resize:fit:1400/1*huXgYB4sDD092hq75PAnyg.gif)

또한 앱을 위해 서로 다른 표시 이름을 사용하고 싶습니다. 그러나 대상의 빌드 설정에는 표시 이름 매개변수가 없습니다. 따라서 사용자 정의 매개변수를 만들고 대신 사용하도록 하겠습니다...

[2020년 5월 5일 업데이트. Stanford Lin님의 댓글 감사합니다]

<div class="content-ad"></div>

플러터 iOS 빌드 방법에 변경 사항이 있어서 이 비디오는 조금 오래됐습니다. 아마 다음과 같은 오류가 발생할 것입니다.

```js
Could not find the built application bundle at build/ios/iphoneos/Runner.app
```

이 오류를 피하려면 일반 설정 탭의 표시 이름 속성에 `$(APP_DISPLAY_NAME)`을 추가하는 대신 Info.plist 파일을 업데이트하여 새로운 속성을 포함해야 합니다.

```js
<dict>
...
<key>CFBundleDisplayName</key>
<string>$(APP_DISPLAY_NAME)</string>
...
</dict>
```

<div class="content-ad"></div>

일반 설정 탭에서 더 이상 Display Name 속성을 변경할 필요가 없습니다.

![이미지](https://miro.medium.com/v2/resize:fit:1400/1*VJhfqIi3-Y365nfM3D99BQ.gif)

마지막으로, 빌드 구성에 따라 다른 GoogleServices-Info.plist를 사용하는 방법을 찾아야 합니다. 이를 실행시간에 앱 시작 시 수행하거나 Firebase 사용을 시작할 때 적합한 구성 파일을 명시적으로 지정하여 Firebase를 초기화하는 것을 제안하는 해결책도 있습니다(https://firebase.google.com/docs/projects/multiprojects에 Firebase 문서에서도 같은 것을 제안합니다). 하지만 저는 앱 번들이 생성될 때 올바른 파일이 자동으로 사용되도록 기본 위치에 올바른 파일을 빌드 시간에 복사하는 다른 옵션을 선호합니다.

이를 달성하기 위해 먼저 각 플레이버용 GoogleServices-Info.plist 파일을 다음과 같이 별도의 폴더에 유지합니다...

<div class="content-ad"></div>

맨처음 코드 조각을 Markdown 글서식에 맞게 변경해볼게요. 


![이미지](https://miro.medium.com/v2/resize:fit:1400/1*2QT0g0XVi72daZz3tYJdmw.gif)


XCode에 config 폴더를 명확히 복사한 후 해당 위치에서 명령줄 또는 탐색기를 통해 XCode에 명시적으로 드래그앤드랍 해주세요. XCode가 명시적으로 추가하기 전까지는 프로젝트 참조에 추가되지 않습니다. 프로젝트 디렉토리에 보관된 파일/폴더는 기본적으로 더해지지 않아요. 위 단계를 따른 후 XCode 폴더 구조는 아래와 같이 보일 거예요.


![이미지](/assets/img/2024-06-21-BuildflavorsinFlutterAndroidandiOSwithdifferentFirebaseprojectsperflavor_10.png)


이제 빌드 프로세스에 단계를 추가하여 각각의 GoogleServices-Info.plist 파일이 올바른 위치로, 즉 Runner 디렉토리 내부로 복사되도록 해야 합니다. 이는 새로운 Run script 빌드 단계를 타겟에 추가함으로써 성취할 수 있어요.

<div class="content-ad"></div>

<img src="https://miro.medium.com/v2/resize:fit:1400/1*5tcidmX4DPIvskHpgtec0Q.gif" />

위의 스크립트를 사용했어요...

[2020년 6월 23일 업데이트. Dharma Teja Nuli님의 코멘트에 감사드립니다.]

여기서 코멘트를 편리하게 요약하면:

<div class="content-ad"></div>

그리고 이제 다 끝났어요! 이제 flutter run --flavor dev 또는 flutter run --flavor prod 명령어를 실행할 수 있어요.

그러면 iOS 기기 / 시뮬레이터에 각각 다른 Firebase DB에 연결되는 별도의 앱이 설치될 거예요!

```js
코드 차이: 단계 3에서 단계 4로
https://github.com/animeshjain/flavor_test/compare/step_3_android_flavors...step_4_ios_flavors
```

<div class="content-ad"></div>

## 단계 5: 다른 플레이버용 앱 아이콘 추가

가끔은 다른 이름만으로는 충분하지 않을 수 있습니다. 기기에 여러 가지 플레이버가 설치된 경우 시각적으로 명확하게 구분하기 위해 다른 앱 아이콘을 원할 수도 있습니다.

지금까지 Flutter에서 제공하는 기본 런처 아이콘을 사용했지만, 단계를 설명하기 위해 프로드 및 데브를 위한 두 개의 아이콘을 만들었습니다.

- Android용 단계

<div class="content-ad"></div>

기본값으로 고려하는 플레이버에 따라 이 아이콘 중 하나는 android/app/src/main/res 폴더로 이동하여 모든 크기에 대한 기존 ic_launcher.png 파일을 대체할 수 있습니다. 저는 default 폴더에 개발자 아이콘을 넣을 것입니다.

![아이콘 이미지](/assets/img/2024-06-21-BuildflavorsinFlutterAndroidandiOSwithdifferentFirebaseprojectsperflavor_11.png)

프로드 플레이버의 경우, 몇몇 분들이 추측하신 것처럼, 우리는 간단히 prod 폴더에 res 폴더를 만들어 모든 크기별 폴더를 추가하면 됩니다. 그러면 디렉토리 구조는 다음과 같이 보일 것입니다.

![디렉토리 구조](/assets/img/2024-06-21-BuildflavorsinFlutterAndroidandiOSwithdifferentFirebaseprojectsperflavor_12.png)

<div class="content-ad"></div>

참고: 개발 앱 아이콘 파일을 특정히 dev 폴더에 넣을 수도 있습니다. 안드로이드는 먼저 플레이버별 디렉토리를 찾아보고, 그곳에서 찾을 수 없는 경우에는 기본 디렉토리인 main으로 되돌아가 그 안에 있는 리소스를 사용합니다.

안드로이드에서 아이콘은 다음과 같이 보입니다 -

![Android Icon](/assets/img/2024-06-21-BuildflavorsinFlutterAndroidandiOSwithdifferentFirebaseprojectsperflavor_13.png)

- iOS 설정 방법

<div class="content-ad"></div>

위에서 JSON 파일의 내용을 복사하고 붙여넣기하여 manifest.json 파일을 만들고 해당 파일을 등록합니다.

<div class="content-ad"></div>

마침내 모든 설명을 마쳤습니다. 이 튜토리얼이 iOS에서 특히 플레이버를 설정하는 데 어떤 혼란을 해소하는 데 도움이 되길 바랍니다. 아래에는 이 작업을 수행하려고 노력하면서 발견한 유용한 기사/자료들이 있습니다.

## 부가 자료

- 플러터 플레이버(및 빌드 모드 — 디버그, 릴리스, 프로파일)가 해당 OS별 빌드 구조로 매핑되는 방식을 설명하는 깃헙 풀 리퀘스트 — [링크](https://github.com/flutter/flutter/pull/11734)
- XCode가 앱을 빌드하는 방법에 대한 심화 학습을 원하는 분들을 위한 자료 — [링크](https://www.youtube.com/watch?v=yazY8hCO46s)
- XCode 빌드를 실행하는 플러터 커맨드 라인 도구 소스 코드 — [링크](https://github.com/flutter/flutter/blob/27b058a41473d5ef136f3874ed6f0a2ccaf969d0/packages/flutter_tools/lib/src/ios/xcodeproj.dart)
- Dart 코드에서 플레이버를 구현하는 방법에 대한 설명 — [링크](https://medium.com/flutter-community/flutter-ready-to-go-e59873f9d7de)