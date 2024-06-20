---
title: "플러터에서 빌드 변형 설정하기 포괄적인 안내"
description: ""
coverImage: "/assets/img/2024-06-20-SettingUpBuildVariantsinFlutterAComprehensiveGuide_0.png"
date: 2024-06-20 13:52
ogImage: 
  url: /assets/img/2024-06-20-SettingUpBuildVariantsinFlutterAComprehensiveGuide_0.png
tag: Tech
originalTitle: "Setting Up Build Variants in Flutter: A Comprehensive Guide"
link: "https://medium.com/@johnsonsivakumar13/setting-up-build-variants-in-flutter-a-comprehensive-guide-6cc15f77c948"
---


현대 앱 개발에서는 다양한 빌드 변형을 관리하는 것이 중요합니다. 플러터(Flutter)에서 빌드 변형은 개발, 스테이징 및 프로덕션과 같이 여러 버전의 앱을 구성할 수 있도록 해줍니다. 각각이 API 엔드포인트, 기능 플래그 및 기타 환경별 설정과 같은 고유의 구성을 가지고 있습니다. 이 안내서에서는 플러터 프로젝트에서 빌드 변형을 설정하는 방법을 안내해 드릴 예정입니다.

# 단계 1: 구성 파일 만들기

첫 번째 단계는 각 빌드 변형을 위한 별도의 구성 파일을 만드는 것입니다. 이러한 파일에는 환경별 설정이 포함됩니다.

- 플러터 프로젝트의 루트에 config 디렉토리를 생성합니다.
- 각 빌드 변형을 위해 config 디렉토리 내에 JSON 구성 파일을 추가합니다:

<div class="content-ad"></div>

- config/development.json
- config/staging.json
- config/production.json

각 구성 파일은 다음과 같을 수 있습니다:

![이미지](/assets/img/2024-06-20-SettingUpBuildVariantsinFlutterAComprehensiveGuide_0.png)

# 단계 2: 구성 로더 생성

<div class="content-ad"></div>

다음으로, 빌드 변형에 따라 적절한 구성 파일을 로드할 클래스를 만들어보겠습니다.

- lib/config_loader.dart라는 새 파일을 생성하세요:

```dart
import 'dart:convert';
import 'package:flutter/services.dart';

class ConfigLoader {
  final String environment;

  ConfigLoader({required this.environment});

  Future<Map<String, dynamic>> load() async {
    final String configString = await rootBundle.loadString('config/$environment.json');
    return json.decode(configString);
  }
}
```

2. lib/config.dart 파일을 생성하세요.

<div class="content-ad"></div>

```js
class Config {
  final String apiBaseUrl;
  final bool debug;

  Config({required this.apiBaseUrl, required this.debug});

  factory Config.fromJson(Map<String, dynamic> json) {
    return Config(
      apiBaseUrl: json['apiBaseUrl'],
      debug: json['debug'],
    );
  }
}
```

![Setting up build variants in Flutter](/assets/img/2024-06-20-SettingUpBuildVariantsinFlutterAComprehensiveGuide_1.png)

# 단계 3: 설정을 사용하도록 메인 파일 수정

빌드 변형에 기반하여 구성 파일을 로드하도록 메인.dart 파일을 수정하세요.

<div class="content-ad"></div>

- 구성을로드하도록 main.dart를 아래와 같이 편집하세요

```js
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String envFile = "development";

  const flavor = String.fromEnvironment('FLAVOR');

  switch (flavor) {
    case 'development':
      envFile = "development";
      break;
    case 'staging':
      envFile = "staging";
      break;
    case 'production':
      envFile = "release";
      break;
  }

  // 구성로드
  final configLoader = ConfigLoader(environment: envFile); // 환경에 따라 변경
  final config = await configLoader.load();

  print(config.apiBaseUrl);
  runApp(const MyApp());
}
```

# 단계 4: build.gradle (Android)에서 빌드 변형 정의

android/app/build.gradle 파일에 build variants를 정의하십시오. 이렇게하면 환경 변수를 Dart 코드로 전달할 수 있습니다.

<div class="content-ad"></div>

- 안드로이드 앱의 build.gradle 파일을 편집하세요:

```js
android {
    ...

    flavorDimensions "env"
    productFlavors {
        dev {
            dimension "env"
            buildConfigField "String", "ENV", "\"development\""
        }
        staging {
            dimension "env"
            buildConfigField "String", "ENV", "\"staging\""
        }
        prod {
            dimension "env"
            buildConfigField "String", "ENV", "\"production\""
        }
    }
}
```

# 단계 5: (iOS)에서 빌드 변형 정의하기

## 설정 구성:

<div class="content-ad"></div>

- 워크스페이스 파일 열기:

프로젝트를 .xcodeproj 파일이 아닌 .xcworkspace 파일을 사용하여 열어야 합니다. 워크스페이스 파일에는 CocoaPods나 기타 도구로 관리되는 프로젝트와 종속성에 대한 참조가 포함되어 있습니다.

2. 프로젝트 설정으로 이동:

- Xcode에서 프로젝트 네비게이터(일반적으로 왼쪽에 위치)에서 프로젝트를 선택합니다.
- 이렇게 하면 다양한 설정을 구성할 수 있는 프로젝트 편집기가 열립니다. 

<div class="content-ad"></div>

3. 환경 설정 관리:

- 프로젝트 네비게이터 상단에 있는 프로젝트 이름을 클릭하여 프로젝트 설정에 액세스합니다.
- 다른 빌드 설정을 구성하려는 대상을 선택합니다 (예: Runner).

4. 환경 설정 추가 또는 편집:

- 정보 탭을 클릭합니다.
- Debug 및 Release와 같은 다양한 빌드 구성을 관리할 수 있는 환경 설정 섹션을 볼 수 있습니다.

<div class="content-ad"></div>

+ 버튼을 클릭하고 "Debug"을 복제하거나 "Release"를 복사하여 사용자 정의 구성물을 추가할 수 있어요. 그리고 나서 그 구성물을 원하는 대로 (예: Debug-staging, Debug-production) 이름을 바꿔주세요.

5. 빌드 설정 구성:

- 새로 생성된 구성물을 선택합니다.
- 필요에 따라 빌드 설정을 조정합니다. 일반적으로 API 엔드포인트, 환경 변수 또는 각 구성에 특정한 번들 식별자와 같은 설정이 포함됩니다.

6. 변경 사항을 저장하세요.

<div class="content-ad"></div>

- 변경을 저장하려면 파일 ` 저장 또는 Cmd + S를 클릭하세요.

## 설정 체계:

- 체계 수정:

- Xcode에서 툴바에 있는 일반적으로 중지 버튼 옆의 체계 드롭다운을 클릭합니다.
- 체계 수정...을 선택합니다.

<div class="content-ad"></div>

### 2. 스킴 구성 관리:

- 스킴 편집기에서 동작 목록을 볼 수 있습니다 (예: 실행, 테스트, 프로파일 등).
- 각 동작에는 고유한 구성이 있습니다 (예: 실행 동작의 디버그).
- 기존 구성 (예: 디버그)을 복제하여 새로운 구성 (예: 릴리스, 스테이징)을 만들 수 있습니다.

### 3. 스킴별 빌드 구성 설정:

- 각 동작 (예: 실행)에 대해 드롭다운에서 적절한 빌드 구성 (디버그, 릴리스 또는 사용자 정의 구성)을 선택하세요.

<div class="content-ad"></div>

4. 실행 대상 구성하기:

- 동일한 Scheme 편집기에서 앱이 실행될 대상을 구성할 수 있습니다 (예: 시뮬레이터 장치 유형, 연결된 장치).

- Scheme 변경 사항 저장하기:

- Scheme 변경 사항을 저장하려면 확인을 클릭하세요.

<div class="content-ad"></div>

```markdown
![이미지](/assets/img/2024-06-20-SettingUpBuildVariantsinFlutterAComprehensiveGuide_2.png)

# 단계 6. 다른 플레이버 실행/빌드하기

명령줄을 사용하여 원하는 플레이버로 앱을 실행하세요. --flavor 플래그와 -t 플래그를 사용하여 빌드 플레이버와 대상 파일을 지정합니다.

터미널에서 아래의 주석을 사용하세요
```

<div class="content-ad"></div>

```md
flutter run --flavor development -t lib/main.dart // 개발용

flutter run --flavor staging -t lib/main.dart    // 스테이징용

flutter run --flavor production -t lib/main.dart // 프로덕션 또는 릴리스용
```

Android 빌드하려면 터미널에서 다음 주석을 사용하세요

```md
flutter build apk --flavor development -t lib/main.dart

flutter build apk --flavor staging -t lib/main.dart

flutter build apk --flavor production -t lib/main.dart
```

iOS 빌드하려면 터미널에서 다음 주석을 사용하세요
```  

<div class="content-ad"></div>

```js
flutter build ios --flavor development -t lib/main.dart

flutter build ios --flavor staging -t lib/main.dart

flutter build ios --flavor production -t lib/main.dart
```

# 단계 6: 또한 안드로이드 스튜디오에서 실행 구성 설정을 설정할 수 있습니다

- 실행/디버그 구성을 엽니다:

- 안드로이드 스튜디오에서 Run ` Edit Configurations...`로 이동합니다.

<div class="content-ad"></div>

2. 새로운 Flutter 구성 만들기:

- 새 구성을 추가하려면 + 버튼을 클릭합니다.
- 목록에서 Flutter를 선택합니다.

3. 개발 플레이버 구성하기:

- 구성 이름을 Flutter 개발과 같이 지정합니다.
- 대상을 main.dart로 설정합니다.
- 추가 실행 인수 필드에서 다트 정의로 플레이버를 추가합니다: --dart-define=FLAVOR=development.
- 선택적으로 빌드 섹션 아래에서 개발을 빌드 플레이버 필드로 설정할 수 있습니다.

<div class="content-ad"></div>

4. 스테이징 플레이버 구성:

- 다른 구성을 만들기 위해 위 단계를 반복합니다.
- 이름을 플러터 스테이징으로 지정합니다.
- 타겟을 main.dart로 설정합니다.
- 추가 실행 인수 필드에 Dart Define으로 플레이버를 추가합니다: --dart-define=FLAVOR=staging.
- 빌드 플레이버 필드를 스테이징으로 설정합니다.

5. 프로덕션 플레이버 구성:

- 다른 구성을 만들기 위해 단계를 반복합니다.
- 이름을 플러터 프로덕션으로 지정합니다.
- 타겟을 main.dart로 설정합니다.
- 추가 실행 인수 필드에 Dart Define으로 플레이버를 추가합니다: --dart-define=FLAVOR=production.
- 빌드 플레이버 필드를 프로덕션으로 설정합니다.

<div class="content-ad"></div>

```markdown
![image](/assets/img/2024-06-20-SettingUpBuildVariantsinFlutterAComprehensiveGuide_3.png)

# 결론

위의 단계를 따라가면, 플러터 앱에서 여러 빌드 변형을 효율적으로 관리하여 개발, 테스트 및 프로덕션을 위한 다른 환경을 유지하기 쉬워집니다. 이 설정을 통해 각 빌드 변형이 자체 구성 및 리소스를 가질 수 있도록하여 개발 및 배포 프로세스를 더 효율적으로 할 수 있습니다.

의문이나 질문이 있으면 언제든지 연락해 주세요. LinkTree를 통해 저에게 연락할 수 있습니다.
```

<div class="content-ad"></div>

행복한 코딩하세요! :)