---
title: "Flutter 애플리케이션에서 빌드 플레버 설정하는 방법 iOS, Android"
description: ""
coverImage: "/assets/img/2024-06-21-CreateBuildFlavorinFlutterApplicationiOSAndroid_0.png"
date: 2024-06-21 20:29
ogImage:
  url: /assets/img/2024-06-21-CreateBuildFlavorinFlutterApplicationiOSAndroid_0.png
tag: Tech
originalTitle: "Create Build Flavor in Flutter Application (iOS , Android)"
link: "https://medium.com/@dwirandyh/create-build-flavor-in-flutter-application-ios-android-fb35a81a9fac"
---

## Flutter 앱에서 다른 환경을 설정하는 방법이 궁금한 적이 있나요? 예를 들어, 다른 API URL, API 키, 개발 및 제품용 아이콘과 같은 것들을 설정해야 하는 경우가 있습니다.

![이미지](/assets/img/2024-06-21-CreateBuildFlavorinFlutterApplicationiOSAndroid_0.png)

이 기사에서는 동일한 소스 코드를 사용하여 iOS 및 Android 애플리케이션의 다른 환경을 어떻게 설정하는지 단계별로 배우게 될 것입니다.

# 개요

<div class="content-ad"></div>

- 빌드 플레이버란 무엇인가요?
- 빌드 플레이버와 빌드 모드의 차이점은 무엇인가요?
- 환경을 정의해보세요.
- 플러터 앱 설정하기
- iOS에서 빌드 플레이버 설정하기
- 안드로이드에서 빌드 플레이버 설정하기
- 빌드 플레이버를 기반으로 앱 실행하기

# 빌드 플레이버란 무엇인가요?

![이미지](/assets/img/2024-06-21-CreateBuildFlavorinFlutterApplicationiOSAndroid_1.png)

플러터 앱을 개발할 때, 앱의 백엔드가 프로덕션용이 아닌 개발용으로 구성된 버전을 개발 환경에서 내부 테스터와 공유하고 싶을 수 있습니다. 이 앱의 버전을 dev 변형이라고 합니다.

<div class="content-ad"></div>

앱을 공개적으로 릴리스하기 준비가 되었고 프로덕션 백엔드가 설정되어 있을 때, 프로덕션 백엔드에 연결된 앱의 다른 버전인 "prod flavor"이 필요합니다.

Build Flavor(빌드 플레이버)는 iOS에서의 Build Configurations(빌드 설정)과 같은 역할을 하는데, 이를 통해 동일한 코드 베이스를 사용하여 앱의 개별 환경을 만들 수 있습니다. 이를 활용하여 두 개의 별도 앱을 작성하지 않고도 앱 버전을 두 개 설정할 수 있습니다.

# 빌드 플레이버, 빌드 모드 및 빌드 변형의 차이

## 빌드 플레이버

<div class="content-ad"></div>

[Build Flavor(빌드 플레이버)]은 동일한 코드베이스를 사용하여 앱의 여러 환경을 만드는 방법에 관한 것입니다.

## Build Mode(빌드 모드)

빌드 모드는 소스 코드를 서로 다른 모드로 컴파일하는 컴파일 모드입니다.

- **개발 중 디버그 모드(Debug mode)**: 핫 리로드를 사용하고 싶을 때 사용됩니다.
- **성능 분석을 원할 때 프로파일 모드(Profile mode)**:
- **앱을 릴리스할 준비가 된 경우 릴리스 모드(Release mode)**:

<div class="content-ad"></div>

## 빌드 변형

빌드 변형은 빌드 모드와 빌드 플레이버의 조합으로, 단일 프로젝트에서 빌드할 애플리케이션의 버전을 사용자 정의할 수 있게 합니다. 따라서 빌드 변형은 단일 프로젝트에서 빌드할 애플리케이션의 버전 차이를 나타낼 수 있습니다. 아래의 표 형태로 나타낼 수 있습니다.

![표](/assets/img/2024-06-21-CreateBuildFlavorinFlutterApplicationiOSAndroid_2.png)

# 환경 정의

<div class="content-ad"></div>

플러터에서 구현 부분으로 넘어가기 전에 원하는 환경을 먼저 정의하는 것이 좋습니다. 개발 및 프로덕션 두 가지 다른 환경을 만들 것입니다.

아래 표는 준비할 환경 예시이며, 개발과 프로덕션 사이에는 필요에 따라 다른 환경을 갖게 될 것입니다.

![환경 예시](/assets/img/2024-06-21-CreateBuildFlavorinFlutterApplicationiOSAndroid_3.png)

# 플러터 앱 설정

<div class="content-ad"></div>

## 단계 1. AppConfig 파일 만들기

AppConfig 클래스를 만들어주세요. 이 싱글톤 클래스는 플레이버별 구성을 저장하는 데 유용합니다.

```js
import 'package:flutter/material.dart';

enum Flavor { prod, dev }

class AppConfig {
  String appName = "";
  String baseUrl = "";
  MaterialColor primaryColor = Colors.blue;
  Flavor flavor = Flavor.dev;

  static AppConfig shared = AppConfig.create();

  factory AppConfig.create({
    String appName = "",
    String baseUrl = "",
    MaterialColor primaryColor = Colors.blue,
    Flavor flavor = Flavor.dev,
  }) {
    return shared = AppConfig(appName, baseUrl, primaryColor, flavor);
  }

  AppConfig(this.appName, this.baseUrl, this.primaryColor, this.flavor);
}
```

## 단계 2. 각 플레이버별 진입점 생성

`lib/main_prod.dart` 파일을 만들어주세요. 이곳에서 제품 플레이버에 맞게 앱을 실행합니다. 해당 플레이버에 따라 앱의 이름을 지정할 수 있습니다.

프로덕션용 진입점

<div class="content-ad"></div>

프로덕션 모드에서 앱을 실행하도록 lib/main.dart 파일을 만들거나 편집하세요. 이 파일에서는 플레이버 타입을 정의하고 앱에 특정 이름, 베이스 URL, 기본 색상 등을 부여합니다.

```js
import 'package:flutter/material.dart';
import 'package:medium_build_flavor/app_config.dart';
import 'package:medium_build_flavor/home_page.dart';

void main() async {
  AppConfig.create(
    appName: "Prod Flavor Example",
    baseUrl: "https://dwirandyh.com",
    primaryColor: Colors.yellow,
    flavor: Flavor.prod,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key});

  // 이 위젯은 애플리케이션의 루트입니다.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo Production',
      theme: ThemeData(
        primarySwatch: AppConfig.shared.primaryColor,
      ),
      home: const HomePage(),
    );
  }
}
```

개발용 진입점

개발 모드에서 앱을 실행하도록 lib/main_prod.dart 파일을 만들어보세요. 이 파일에서는 플레이버 타입을 정의하고 앱에 특정 이름, 베이스 URL, 기본 색상 등을 부여합니다.

<div class="content-ad"></div>

```js
import 'package:flutter/material.dart';
import 'package:medium_build_flavor/app_config.dart';
import 'package:medium_build_flavor/home_page.dart';

void main() async {
  AppConfig.create(
    appName: "개발 Flavor 예시",
    baseUrl: "https://dev.dwirandyh.com",
    primaryColor: Colors.blue,
    flavor: Flavor.prod,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // 이 위젯은 애플리케이션의 루트입니다.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 데모 프로덕션',
      theme: ThemeData(
        primarySwatch: AppConfig.shared.primaryColor,
      ),
      home: const HomePage(),
    );
  }
}
```

단계 3. 홈 페이지
이 홈 페이지 뷰는 우리가 진입점 파일에서 정의한 app config을 기반으로 한 구성을 표시하는 데 사용됩니다.

```js
import 'package:flutter/material.dart';
import 'package:medium_build_flavor/app_config.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConfig.shared.appName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("앱 이름: ${AppConfig.shared.appName}"),
            Text("기본 URL: ${AppConfig.shared.baseUrl}"),
            Text("Flavor: ${AppConfig.shared.flavor}"),
          ],
        ),
      ),
    );
  }
}
```

# iOS용 빌드 Flavor 설정

<div class="content-ad"></div>

### Step 1. 대상 복제

ios/Runner.xcworkspace을 여세요. Runner 대상을 복제합니다. 이렇게 하면 두 개의 서로 다른 대상이 생성됩니다. 방금 만든 dev 대상은 개발 대상으로 사용되고 기본 대상인 Runner은 prod로 이름을 변경하여 프로덕션 대상으로 사용됩니다.

![이미지](https://miro.medium.com/v2/resize:fit:1400/1*3pl3Ash1kCDEecmnD1RIeg.gif)

### Step 2. 스킴 이름 바꾸기

대상을 복제하면 생성된 스킴을 이름을 변경해야 합니다. Runner을 dev로 이름을 변경합니다. 이 스킴은 dev 플레이버를 사용하여 flutter 명령을 실행할 때 식별자로 사용됩니다.

![이미지](https://miro.medium.com/v2/resize:fit:1400/1*yGyUZHGWN7cI3XW-m9k69A.gif)

<div class="content-ad"></div>

테이블 태그를 Markdown 형식으로 변경해주세요.

<div class="content-ad"></div>

이 시점에서 CLI에서 flutter run -t lib/main_dev.dart --flavor dev를 실행하면 사용자 정의 스키마를 완료해야 할 정보가 표시됩니다. 안내에 따라 사용자 정의 스키마 설정을 마무리하세요.

```js
Xcode 프로젝트는 빌드 구성(Debug, Release, Profile)을 정의합니다.
Flutter는 Debug-dev 또는 유사한 이름의 빌드 구성을 예상합니다.
문제를 해결하기 위해 Xcode를 엽니다:
  ios/Runner.xcworkspace 파일을 엽니다.
1. 프로젝트 탐색기에서 "Runner"를 클릭합니다.
2. Runner PROJECT가 선택되었는지 확인하고 Runner TARGET이 아닌지 확인하세요.
3. 편집기->구성 추가->"Debug" 구성 복제를 클릭합니다.

   이 옵션이 비활성화된 경우, 대상 대신 프로젝트를 선택한 것일 수 있습니다.
   https://stackoverflow.com/questions/19842746/adding-a-build-configuration-in-xcode
   을 참조하세요.

   완전히 사용자 정의된 빌드 구성 세트를 만들었다면, 새 구성에서 .xcconfig 파일에 FLUTTER_BUILD_MODE=debug를 설정하고 Xcode에서 실행할 수 있습니다.

4. 완전히 사용자 정의된 빌드 구성을 사용하지 않는 경우, 새로 만든 구성을 debug로 명명하세요.
시뮬레이터용 응용 프로그램을 빌드할 수 없습니다.
iPhone 14 Pro에서 애플리케이션을 시작하지 못했습니다.
```

Step 3. 개발용 빌드 모드 구성 추가

모든 빌드 모드에 대한 빌드 구성을 정의해야 하므로 각 구성 (Debug, Release 및 Profile)을 + 기호를 클릭하여 복제하고 -dev 접미사를 추가하는 것을 잊지 마세요.

<div class="content-ad"></div>

![이미지](https://miro.medium.com/v2/resize:fit:1400/1*2osPENEcGz9zFDCboBsZxw.gif)

우리는 또한 기본 구성 이름을 변경하고 -prod 접미사를 추가해야 합니다.

![이미지](/assets/img/2024-06-21-CreateBuildFlavorinFlutterApplicationiOSAndroid_6.png)

4단계. 개발 환경을 위한 앱 ID 변경

<div class="content-ad"></div>

앱 ID는 iOS 및 안드로이드 앱을 식별하는 데 사용되는 고유 식별자입니다. 앱 개발자가 할당하는 문자열이며, 장치에 설치될 때 운영 체제가 앱을 식별하는 데 사용됩니다.

개발을 위해 고유 식별자로 .dev 접미사를 추가할 수 있고, 제품용은 그대로 둘 수 있습니다

![이미지](https://miro.medium.com/v2/resize:fit:1400/1*Og8WrFL3zvlOvpcVVaiK4A.gif)

단계 5. 개발용 앱 아이콘 변경

<div class="content-ad"></div>

저희는 앱 아이콘을 환경마다 변경할 수도 있습니다. 이번 경우에는 개발 환경을 위해 앱 아이콘을 변경할 거에요. 이렇게 하면 우리는 프로덕션 및 개발 애플리케이션에 다른 앱 아이콘이 나타날 거에요.

개발 환경에서 앱 아이콘을 변경하려면 Assets.xcassets 안에 있는 AppIcon을 복제하고 AppIconDev이라고 이름을 지정하면 돼요.

그 다음에는 RunnerDev 빌드 설정에서 'Primary App Icon Set Name'을 AppIconDev로 변경해야 해요.

<div class="content-ad"></div>

![Image](https://miro.medium.com/v2/resize:fit:1400/1*2mQ1CJ_sPyIHHSodjqCVGg.gif)

어플리케이션에서 변경 사항을 보려면 flutter run lib/main_dev.dart --flavor dev 명령어를 다시 실행하면, 개발용 앱 아이콘이 변경된 것을 확인할 수 있습니다.

# 안드로이드에서 빌드 플레이버 설정하기

단계 1. 플레이버 구성 추가
안드로이드에서 빌드 플레이버를 생성하기 위한 첫 번째 단계는 app/build.gradle 파일에 일부 구성을 추가해야 합니다.

<div class="content-ad"></div>

```json
안드로이드 {
  defaultConfig {
         ...
      }
  ...
  flavorDimensions "default"
  productFlavors {
      prod {
          dimension "default"
          resValue "string", "app_name", "Flutter Demo Prod"
      }
      dev {
          dimension "default"
          applicationIdSuffix ".dev"
          resValue "string", "app_name", "Flutter Demo Dev"
          versionNameSuffix ".dev"
      }
  }

}
```

단계 2. 개발용 아이콘 변경

개발 애플리케이션을 위한 앱 아이콘을 변경하려면 app/src/dev 내에 디렉토리를 생성하고 해당 폴더에 모든 앱 아이콘 리소스를 넣어야 합니다. 이렇게 하면 개발 플레이버를 실행할 때 dev/res 디렉토리에서 ic_launcher를 사용할 수 있습니다

<img src="/assets/img/2024-06-21-CreateBuildFlavorinFlutterApplicationiOSAndroid_8.png" />

<div class="content-ad"></div>

# 플레이버에 기반한 앱 실행

앱을 실행하려면 다음 명령을 사용해야 합니다:

각 플레이버를 DEBUG 모드로 실행하는 방법:

- flutter run -t lib/main.dart --flavor prod
- flutter run -t lib/main_dev.dart --flavor dev

<div class="content-ad"></div>

각각의 플레이버를 PROFILE 모드에서 실행하려면:

- flutter run --profile -t lib/main.dart --flavor prod
- flutter run --profile -t lib/main_dev.dart --flavor dev

각각의 플레이버를 RELEASE 모드에서 실행하려면:

- flutter run --release -t lib/main.dart --flavor prod
- flutter run --release -t lib/main_dev.dart --flavor dev

<div class="content-ad"></div>

아래의 저장소에서 전체 프로젝트를 다운로드할 수 있습니다.
