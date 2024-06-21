---
title: "플러터와 다트에서 코드 난독화 신비로운 코드 이해하기"
description: ""
coverImage: "/assets/img/2024-06-21-ObfuscationinFlutterandDartMysteriouscodes_0.png"
date: 2024-06-21 20:49
ogImage: 
  url: /assets/img/2024-06-21-ObfuscationinFlutterandDartMysteriouscodes_0.png
tag: Tech
originalTitle: "Obfuscation in Flutter and Dart: Mysterious codes"
link: "https://medium.com/@gizemgizgg/obfuscation-in-flutter-and-dart-mysterious-codes-64d91f0fad10"
---


![image](/assets/img/2024-06-21-ObfuscationinFlutterandDartMysteriouscodes_0.png)

안녕하세요, 이 글에서는 플러터와 다트 코드 난독화, 플러터의 중요한 주제 중 하나를 배우게 됩니다.

먼저, 난독화가 무엇인지 알아보겠습니다.

난독화는 코드를 사람이 해독할 수 없도록 만드는 과정입니다. 이는 역공학 공격을 어렵게 만들어서 애플리케이션의 보안을 높이기 위해 사용됩니다. 플러터와 다트는 난독화를 위한 일부 내장 도구와 방법을 제공합니다.

<div class="content-ad"></div>

# 왜 난독화를 사용해야 하나요?

- 보안: 코드를 알아보기 어렵게 만들어 악의적 사용자가 코드를 이해하고 남용하는 것을 어렵게 합니다.
- 지적 재산권: 코드를 보호하여 지적 재산권을 안전하게 지킵니다.
- 용량 감소: 어떤 경우에는 난독화가 코드의 크기를 줄이는 데 도움이 될 수도 있습니다.

시작해봅시다! 🥷🏻

- 플러터 프로젝트를 만들어보세요.

<div class="content-ad"></div>


```js
flutter create my_app
cd my_app
```

2. 프로젝트 구조화

난독화를 활성화하려면 flutter 빌드 명령에 몇 가지 추가 매개변수를 추가해야 합니다. Android 및 iOS 모두를 위해 난독화하는 방법을 살펴보겠습니다.

Android용으로는;


<div class="content-ad"></div>

- android/app/build.gradle 파일을 열어주세요.
- buildTypes 섹션에서 릴리스 구성을 다음과 같이 업데이트해주세요:

```js
android {
    ...
    buildTypes {
        release {
            ...
            minifyEnabled true
            shrinkResources true
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
}
```

- Proguard 규칙을 지정하려면 android/app/proguard-rules.pro 파일을 생성하고 다음 줄을 추가해주세요:

```js
# Flutter 난독화
-ignorewarnings
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.embedding.engine.** { *; }
-keep class io.flutter.embedding.android.** { *; }
-keep class io.flutter.embedding.engine.plugins.** { *; }
-keep class io.flutter.plugin.common.** { *; }
-keep class io.flutter.plugin.platform.** { *; }
```

<div class="content-ad"></div>

iOS에서는 다음을 수행하실 수 있습니다:

- Open theios/Runner.xcodeproj 파일을 엽니다.
- 빌드 설정 섹션에서 'Other Swift Flags' 설정을 찾아서 -D DART_OBFUSCATION을 추가합니다.

3. 난독화된 애플리케이션 컴파일

다음 명령어를 사용하여 Android 및 iOS용 난독화된 빌드를 생성합니다:

<div class="content-ad"></div>

안드로이드:

```js
flutter build apk --release --obfuscate --split-debug-info=./build_info
```

iOS:

```js
flutter build ios --release --obfuscate --split-debug-info=./build_info
```

<div class="content-ad"></div>

이 명령어들은 난독화된 코드의 디버그 정보 파일을 지정된 디렉토리에 넣습니다. 이 파일들은 디버깅 및 충돌 보고서 해결에 중요합니다.

4. 애플리케이션 파일 검토

난독화 프로세스의 결과물인 APK 또는 IPA 파일을 열어 코드가 숨겨져 있는지 확인할 수 있습니다. Android APK 파일을 검토하기 위해서는 apktool 또는 유사한 도구를 사용할 수 있습니다. iOS IPA 파일은 class-dump 또는 otool과 같은 도구를 사용할 수 있습니다.

- Android APK 파일 검토:
apktool을 사용하여 APK 파일을 디컴파일합니다.

<div class="content-ad"></div>

```js
apktool d my_app.apk -o output_dir
```

- iOS IPA 파일을 조사해보세요:
IPA 파일을 열고 Payload 디렉토리에서 응용 프로그램 파일을 추출하세요. class-dump나 otool을 사용하여 응용 프로그램 파일을 조사하세요.

```js
class-dump -H MyApp -o output_dir
```

# 결론

<div class="content-ad"></div>

위의 단계를 따라 코드를 난독화하여 응용 프로그램의 안전성을 높일 수 있습니다. 이를 정기적으로 수행함으로써 응용 프로그램의 보안을 지속적으로 보호할 수 있습니다.

독자 여러분, 읽어주셔서 감사합니다!
새로운 기사에서 뵙겠습니다 💙

제 계정을 여기에서 확인하고 질문을 하실 수 있습니다 ✨

트위터에서 플러터 커뮤니티를 팔로우해보세요:
https://www.twitter.com/FlutterComm