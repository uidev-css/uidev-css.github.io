---
title: "Flutter iOS  다양한 Firebase 설정으로 Flavors 설정하는 방법"
description: ""
coverImage: "/assets/img/2024-06-21-FlutteriOSSetupFlavorswithdifferentFirebaseConfig_0.png"
date: 2024-06-21 21:47
ogImage:
  url: /assets/img/2024-06-21-FlutteriOSSetupFlavorswithdifferentFirebaseConfig_0.png
tag: Tech
originalTitle: "Flutter iOS — Setup Flavors with different Firebase Config"
link: "https://medium.com/@ahmedyusuf/setup-flavors-in-ios-flutter-with-different-firebase-config-43c4c4823e6b"
---

![이미지](/assets/img/2024-06-21-FlutteriOSSetupFlavorswithdifferentFirebaseConfig_0.png)

플레이버의 목적은 무엇인가요? 플레이버는 개발 및 프로덕션을 포함한 다양한 맥락에 맞춰 응용 프로그램을 사용자 정의하는 수단으로 작용합니다. 아래 예시를 살펴보겠습니다:

- 개발 단계에서는 앱이 https://dev.mobileapp.com/v1/에 위치한 API 호스트와 com.mobileapp.dev 프로젝트 ID를 사용하여 연결을 설정하기를 원할 수 있습니다.
- 반면, 앱을 릴리스할 때에는 프로덕션 버전이 https://api.mobileapp.com/v1/에 위치한 API 호스트와 com.mobileapp.prod 프로젝트 ID를 사용하여 연결해야 합니다.

이러한 값을 변수로 직접 코딩하고 각 환경에 대해 별도의 앱 빌드를 생성하는 대신 플레이버를 활용하는 것이 권장됩니다. 플레이버를 사용하면 이러한 값을 빌드 시간 구성으로 제공하여 프로세스를 간소화할 수 있습니다.

<div class="content-ad"></div>

이 튜토리얼에서는 "dev"와 "prod" 두 가지 플레이버를 가진 샘플 애플리케이션을 생성하는 방법을 안내합니다. 각 단계마다 샘플 앱에 커밋이 이루어지며 코드 차이를 검토하고 적용된 수정 사항을 파악할 수 있게 됩니다.

추가로, 기존 앱에 이 지침을 간편하게 적용할 수 있도록 상세한 지침을 제공할 것이며, 사용자 친화적인 경험을 보장할 것입니다.

단계 1: Flutter 애플리케이션 프로젝트 생성

단계 2: Firebase와 통합하도록 애플리케이션 구성

<div class="content-ad"></div>

먼저, 개발 및 프로덕션을 위해 두 개의 별도 Firebase 프로젝트를 설정하세요. Firebase 콘솔 내에서 각 프로젝트에 대한 Android 애플리케이션을 생성해주세요. 개발 앱은 com.mobileapp.dev ID를, 프로덕션 앱은 com.mobileapp.prod ID를 갖고 있다고 가정합니다. 각 애플리케이션에 대한 GoogleServices-Info.plist 파일을 다운로드해주세요. Firebase를 Flutter 프로젝트에 통합하는 자세한 지침은 Firebase Flutter 설정 가이드를 참고하세요.

![image1](/assets/img/2024-06-21-FlutteriOSSetupFlavorswithdifferentFirebaseConfig_1.png)

그다음, 개발 및 프로덕션 애플리케이션을 위한 GoogleServices-Info.plist 파일을 ios/config/ 디렉토리 내의 별도 폴더로 복사해주세요.

![image2](/assets/img/2024-06-21-FlutteriOSSetupFlavorswithdifferentFirebaseConfig_2.png)

<div class="content-ad"></div>

Step 3: 루트 프로젝트 디렉토리에 다른 API 엔드포인트를 가리키도록 하는 2개의 구성 파일을 생성하세요.

![dev.json](/assets/img/2024-06-21-FlutteriOSSetupFlavorswithdifferentFirebaseConfig_3.png)

![dev.json](/assets/img/2024-06-21-FlutteriOSSetupFlavorswithdifferentFirebaseConfig_4.png)

<div class="content-ad"></div>

prod.json

![Flutter iOS Setup Flavors with different Firebase Config](/assets/img/2024-06-21-FlutteriOSSetupFlavorswithdifferentFirebaseConfig_5.png)

Step 4: Create multiple Runner on XCode

XCode에서 여러 Runner를 생성하려면

XCode에서 ios 폴더를 열어주세요. ios 폴더를 우클릭하고 "Xcode에서 열기" 옵션을 선택하면 됩니다.

<div class="content-ad"></div>

<img src="/assets/img/2024-06-21-FlutteriOSSetupFlavorswithdifferentFirebaseConfig_6.png" />

Xcode는 제품 플레이버와 상응하는 스키마와 빌드 구성 개념을 소개합니다. 안드로이드에서 제품 플레이버에 해당하는 사용자 정의 스키마를 만들어봅시다.

<img src="https://miro.medium.com/v2/resize:fit:1200/1*OE7e4r2CbOJ1mue4mzfMTg.gif" />

그런 다음, Debug-Dev, Release-Dev 및 Profile-Dev로 명명된 3가지 구성을 생성합시다.

<div class="content-ad"></div>

![Image](https://miro.medium.com/v2/resize:fit:1200/1*5KlPoqD-amdcgurzjTVulA.gif)

We also need to rename for prod build configuration

![Image](https://miro.medium.com/v2/resize:fit:1200/1*74RaOwzLGWilIM5LkzVi1A.gif)

Ok, now let’s set Dev schemes by Dev build configuration

<div class="content-ad"></div>

<img src="https://miro.medium.com/v2/resize:fit:1200/1*9FqzXYzM4USJiBaFjf3dbA.gif" />

- 플레이버에 기반한 번들 ID 설정

이제 두 개의 스키마가 각각의 빌드 구성과 연결되었습니다. 이는 우리가 각 스키마에 맞도록 사용자 정의를 할 수 있게 해 줍니다. 시작하려면 어플리케이션 번들 식별자를 두 스키마 각각에 대해 고유하게 설정해 보겠습니다.

타겟 섹션의 Runner를 클릭하여 `Build Settings`로 이동하고, 오른쪽 상단의 필터 필드에서 Bundle을 입력하여 모든 제품 번들 식별자를 채워주세요.

<div class="content-ad"></div>

![이미지](/assets/img/2024-06-21-FlutteriOSSetupFlavorswithdifferentFirebaseConfig_7.png)

- 플레이버에 따라 AppName 설정하기

앱에 다른 디스플레이 이름을 사용하고 싶습니다. 그러나 빌드 설정의 대상에는 디스플레이 이름 매개변수가 없습니다. 해결책으로 사용자 정의 매개변수를 생성하고 이를 디스플레이 이름 매개변수 대신 사용할 수 있습니다.

Build Settings에서 `Info`를 클릭하세요.

<div class="content-ad"></div>

번들 디스플레이 이름을 $(APP_DISPLAY_NAME)으로 설정하세요.

![이미지](/assets/img/2024-06-21-FlutteriOSSetupFlavorswithdifferentFirebaseConfig_8.png)

빌드 설정으로 이동해서 `추가 버튼 (+)`을 클릭하고 사용자 정의 설정을 추가한 다음 APP_DISPLAY_NAME을 입력하세요.

![이미지](/assets/img/2024-06-21-FlutteriOSSetupFlavorswithdifferentFirebaseConfig_9.png)

<div class="content-ad"></div>

그리고 다음과 같이 설정하세요

![image](/assets/img/2024-06-21-FlutteriOSSetupFlavorswithdifferentFirebaseConfig_10.png)

- Runner에 config 폴더 추가하기

마지막으로, 빌드 구성에 따라 다른 GoogleServices-Info.plist 파일을 활용하는 해결책을 찾아야 합니다. 몇 가지 제안은 Firebase 초기화 시에 원하는 구성 파일을 명시적으로 지정하여 런타임에서 처리하는 것을 제안합니다 (Firebase 문서에서 언급됨: https://firebase.google.com/docs/projects/multiprojects). 그러나 다른 옵션으로 저는 빌드 시 적절한 파일을 기본 위치로 복사하는 방법을 선호합니다. 이렇게 하면 앱 번들이 생성될 때 자동으로 올바른 파일을 사용하게 됩니다.

<div class="content-ad"></div>

위 작업을 수행하기 위해 먼저 각 flavor에 대한 GoogleServices-Info.plist 파일을 별도 폴더에 정리하고, Runner에 추가합니다.

![image](https://miro.medium.com/v2/resize:fit:1200/1*x4yGjohfV_JUafeoPOw1Aw.gif)

![image](/assets/img/2024-06-21-FlutteriOSSetupFlavorswithdifferentFirebaseConfig_11.png)

- 빌드 단계에서 GoogleService-info.plist를 복사하는 Runnner 스크립트를 추가합니다.

<div class="content-ad"></div>

다음으로는 빌드 프로세스에 단계를 추가하여 해당 GoogleServices-Info.plist 파일이 Runner 디렉토리 내의 적절한 위치로 복사되도록 하는 방법을 결정해야 합니다. 이것은 새로운 Run script Build Phase를 대상에 추가함으로써 달성할 수 있습니다.

![이미지](https://miro.medium.com/v2/resize:fit:1200/1*TFJl5ZZVrS0f1gIuB3zajQ.gif)

```js
environment="default"

# 빌드 구성에서 스킴 이름을 추출하기 위한 정규식
# 빌드 구성을 Debug-dev, Debug-prod 등과 같이 지정했습니다.
# 여기서 dev와 prod는 스킴 이름입니다. Flutter에서 플레이버가 작동하려면 이러한 유형의 이름이 필요합니다.
# 우리는 XCode 빌드 환경에서 사용 가능한 $CONFIGURATION 변수를 사용하여 환경(또는 플레이버)를 추출합니다.
# 예를 들어
# CONFIGURATION="Debug-prod"인 경우, 환경은 "prod"로 설정됩니다.
if [[ $CONFIGURATION =~ -([^-]*)$ ]]; then
    environment=${BASH_REMATCH[1]}
fi

echo $environment

# 복사하는 리소스의 이름과 경로
GOOGLESERVICE_INFO_PLIST=GoogleService-Info.plist
GOOGLESERVICE_INFO_FILE=${PROJECT_DIR}/config/${environment}/${GOOGLESERVICE_INFO_PLIST}

# GoogleService-Info.plist 파일이 존재하는지 확인
echo "${GOOGLESERVICE_INFO_PLIST} 파일이 ${GOOGLESERVICE_INFO_FILE}에서 확인 중"
if [ ! -f $GOOGLESERVICE_INFO_FILE ]; then
    echo "GoogleService-Info.plist 파일을 찾을 수 없습니다. 올바른 디렉토리에 있는지 확인하세요."
    exit 1
fi

# GoogleService-Info.plist의 대상 위치에 대한 참조 얻기
# Firebase init 코드가 GoogleServices-Info.plist 파일을 찾을 기본 위치입니다.
PLIST_DESTINATION=${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app
echo "${GOOGLESERVICE_INFO_PLIST} 파일을 최종 대상지인 ${PLIST_DESTINATION}에 복사합니다."

# 릴리스 빌드용 prod GoogleService-Info.plist를 복사합니다.
cp "${GOOGLESERVICE_INFO_FILE}" "${PLIST_DESTINATION}"
```

Step 5: 플레이버를 기반으로 한 설정을 처리하는 몇 개의 Dart 파일을 생성하세요.

<div class="content-ad"></div>

lib/utils/environment.dart

```js
abstract class Environment {
  static const dev = 'dev';
  static const prod = 'prod';
}
```

lib/utils/config_reader.dart

```js
import 'dart:convert';
import 'package:flutter/services.dart';

abstract class ConfigReader {
  static Map<String, dynamic>? _config;
  static bool _isDevMode = false;

  static Future<void> initialize(String env) async {
    var configString = '{}';

    try {
      configString = await rootBundle.loadString('config/$env.json');
    } catch (_) {
      configString = await rootBundle.loadString('config/dev.json');
    }

    _config = json.decode(configString) as Map<String, dynamic>;
    _isDevMode = env == "dev";
  }

  static bool isDevMode() {
    return _isDevMode;
  }

  static String getBaseUrl() {
    return _config!['baseUrl'] as String;
  }
}
```

<div class="content-ad"></div>

6단계: 플레이버를 관리하기 위해 3개의 다른 주요 Dart 파일을 만듭니다.

lib/main_dev.dart

```js
Future<void> main() async {
  await mainCommon(Environment.dev);
}
```

lib/main_prod.dart

<div class="content-ad"></div>

```js
Future<void> main() async {
  await mainCommon(Environment.prod);
}
```

lib/main_common.dart

```js
Future<void> mainCommon(String env) async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigReader.initialize(env);
  runApp(const MyApp());
}
```

Step 6: 플레이버에 기반한 변수 가져오기

<div class="content-ad"></div>

config에서 변수를 다음과 같이 가져올 수 있어요

```js
debugShowCheckedModeBanner: ConfigReader.isDevMode(),
```

또한 연결 클래스 파일에 대한 base_url을 다음과 같이 가져올 수 있어요

```js
class HttpGetConnect extends GetConnect {
  final _baseUrl = ConfigReader.getBaseUrl();
  static HttpGetConnect? _instance;
  HttpGetConnect._internal() {
    _instance = this;
    httpClient.baseUrl = _baseUrl;
  }
}
```

<div class="content-ad"></div>

7단계: VS code 런처 설정 추가하기

.vscode/lunch.json을 생성하세요.

![이미지](/assets/img/2024-06-21-FlutteriOSSetupFlavorswithdifferentFirebaseConfig_12.png)

launch.json을 다음 코드로 변경하세요.

<div class="content-ad"></div>

```json
{
  // 가능한 속성에 대해 알아보려면 IntelliSense를 사용하세요.
  // 기존 속성에 대한 설명을 보려면 가리킬 수 있어요.
  // 더 많은 정보는 여기를 참조하세요: https://go.microsoft.com/fwlink/?linkid=830387
  "version": "0.2.0",
  "configurations": [
    {
      "name": "[Debug] Development App",
      "request": "launch",
      "type": "dart",
      "program": "lib/main_dev.dart",
      "args": ["--flavor", "Dev"]
    },
    {
      "name": "[Debug] Production App",
      "request": "launch",
      "type": "dart",
      "program": "lib/main_prod.dart",
      "args": ["--flavor", "Prod"]
    },
    {
      "name": "[Release] Production App",
      "request": "launch",
      "type": "dart",
      "flutterMode": "release",
      "program": "lib/main_prod.dart",
      "args": ["--flavor", "Prod"]
    }
  ]
}
```

그리고 이제 개발 flavor 또는 프로덕션 flavor를 사용하여 앱을 실행할 수 있어요

![Flutter iOS Setup Flavors](/assets/img/2024-06-21-FlutteriOSSetupFlavorswithdifferentFirebaseConfig_13.png)

그리고 여기 결과가 있어요

<div class="content-ad"></div>

8단계: xcarchive 빌드하기

XCode를 열고 Target Runners 'Signing & Capabilities'를 선택하여 Apple 개발자 계정이 이미 있는지 확인한 다음에 아래 스크립트를 실행하면 build/ios/ 폴더에 출력 파일이 생성됩니다.

```js
flutter build xcarchive --flavor prod -t lib/main_prod.dart
```

Android에서 플레이버 설정을 진행하시겠습니까? 다음 단계로 넘어가 보시겠습니까?

<div class="content-ad"></div>

![이미지](/assets/img/2024-06-21-FlutteriOSSetupFlavorswithdifferentFirebaseConfig_14.png)

Github 프로젝트

[https://github.com/c0deslinger/flutter-learn-flavor](https://github.com/c0deslinger/flutter-learn-flavor)

참고:

<div class="content-ad"></div>

https://medium.com/flutter-community/flutter-ready-to-go-e59873f9d7de

https://medium.com/@animeshjain/build-flavors-in-flutter-android-and-ios-with-different-firebase-projects-per-flavor-27c5c5dac10b
