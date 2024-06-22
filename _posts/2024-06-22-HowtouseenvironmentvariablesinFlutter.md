---
title: "Flutter에서 환경 변수 사용하는 방법"
description: ""
coverImage: "/assets/img/2024-06-22-HowtouseenvironmentvariablesinFlutter_0.png"
date: 2024-06-22 15:38
ogImage: 
  url: /assets/img/2024-06-22-HowtouseenvironmentvariablesinFlutter_0.png
tag: Tech
originalTitle: "How to use environment variables in Flutter?"
link: "https://medium.com/@ajay.kumar_14/how-to-use-environment-variables-in-flutter-90cfc882177d"
---


플러터는 크로스 플랫폼 기능, 성능 및 다양한 위젯 라이브러리로 모바일 앱을 구축하기 위해 인기가 있습니다. 플러터 개발자로서, API 키, 데이터베이스 URL 및 환경별 변수와 같은 다양한 구성 설정이 필요한 프로젝트에 자주 참여합니다. 이러한 설정을 적절하게 관리하는 것은 여러 가지 이유로 중요합니다:

1. 보안: API 키 및 데이터베이스 URL과 같이 민감한 정보는 보호되어야 합니다. 개발 및 프로덕션용으로 다른 설정을 사용하면 민감한 데이터가 안전하지 않은 환경에서 노출되지 않도록 보호할 수 있습니다.

2. 일관성: 다른 환경은 서로 다른 요구 사항과 제약 사항을 가지고 있습니다. 환경별 설정을 관리하면 개발, 스테이징 및 프로덕션 환경에서 앱이 일관되게 동작하도록 보장하여 예기치 않은 문제의 위험을 줄일 수 있습니다.

3. 효율성: 적절한 구성 관리는 개발 프로세스를 간소화합니다. 개발자는 설정을 수동으로 변경하지 않고 환경 간에 쉽게 전환할 수 있어 생산성을 향상시키고 오류 가능성을 줄일 수 있습니다.

<div class="content-ad"></div>

4. 확장성: 프로젝트가 커짐에 따라 여러 환경을 관리하는 것은 더 복잡해집니다. 구조화된 설정 관리 접근 방식은 코드베이스의 확장성과 유지보수성을 향상시킬 수 있습니다.

5. 규정 준수: 특정 프로젝트에는 개발, 테스트 및 제품용으로 별도의 환경을 사용해야 하는 규정 준수 요구사항이 있을 수 있습니다. 서로 다른 설정을 관리하여 앱이 이러한 규정을 준수할 수 있도록합니다.

다양한 환경에 대한 설정을 효과적으로 관리함으로써 플러터 개발자는 애플리케이션의 보안, 일관성, 효율성, 확장성 및 규정 준수를 향상시킬 수 있어 더 견고하고 신뢰할 수 있는 최종 제품을 얻을 수 있습니다.

# 시작해봅시다 :)

<div class="content-ad"></div>

컴파일 시간 변수를 사용하면 환경 변수를 컴파일 시간에만 정의할 수 있습니다. 이는 변수가 flutter run 또는 flutter build 명령을 실행하는 동안 설정된다는 것을 의미합니다. 따라서 이러한 명령은 CI 환경에서 컴파일/빌드 프로세스에 통합될 수 있습니다. Dart와 Flutter 생태계에서는 컴파일 시간 환경 변수 선언의 개념이 잘 확립되어 있습니다.

만약 초기부터 Flutter Web에서 작업을 해오셨다면, --dart-define 인수는 주로 다음과 같이 사용되어 Flutter Web에서 Skia를 활성화하는 데 사용되었습니다 --dart-define=FLUTTER_WEB_USE_SKIA=true

예를 들어 다음과 같은 인수를 사용하여 Flutter 애플리케이션을 시작할 때:

```js
flutter run --dart-define=APP_NAME="Flutter Environment Variables"
```

<div class="content-ad"></div>

다음으로, Dart 코드에서 이러한 값을 간단히 사용할 수 있어요:

```js
abstract class EnvConfig {
  static String appName = const String.fromEnvironment(
    'APP_NAME',
    defaultValue: 'Flutter Demo',
  );
}

/// 모든 컴파일 타임 변수는 String.fromEnvironment, bool.fromEnvironment 및 
/// int.fromEnvironment 생성자를 사용하여 상수로 사용할 수 있어요.
```

APP_NAME에 대한 기본값으로 Flutter Demo를 사용했다는 점을 알 수 있어요. 값이 전달되지 않으면 기본값이 사용될 거예요.

실제로 동작하는 것을 보자.

<div class="content-ad"></div>


![이미지](/assets/img/2024-06-22-HowtouseenvironmentvariablesinFlutter_0.png)

플러터 환경 변수가 전달된 인수에서 기본값 대신 렌더링된 것을 알 수 있습니다.

비슷한 방식으로 여러 변수를 전달해야 하는 경우 --dart-define 플래그를 계속 사용할 수 있습니다. 그러나 여러 변수를 필요로 하는 프로젝트의 경우 이러한 설정을 구성 파일을 통해 효율적으로 관리하는 것이 좋습니다.

프로젝트의 루트 디렉토리에 .env 파일을 생성할 수 있습니다. .env는 키-값 쌍 형식의 간단한 환경 파일입니다.


<div class="content-ad"></div>

아래는 Flutter가 상수 전역 풀에 정의하는 환경별 변수를 담은 파일입니다.

이 변수들에 접근하려면 이전에는 flutter_dotenv를 추가하고 다음과 같이 변수에 액세스해야 했습니다.

```js
import 'package:flutter_dotenv/flutter_dotenv.dart';
```

<div class="content-ad"></div>

```js
Future main() async {
  //...
  await dotenv.load(fileName: ".env");
  //...runapp
  final appName = dotenv.env['APP_NAME'];
  //...
}
```

간단히! 당신의 Dart 코드는 이렇게 보일 것입니다.

```js
abstract class EnvConfig {
  static String appName = const String.fromEnvironment(
    'APP_NAME',
    defaultValue: 'Flutter Demo',
  );
  static String appEnvironment = const String.fromEnvironment(
    'APP_ENVIRONMENT',
    defaultValue: 'development',
  );
}
```

--dart-define-from-file을 사용하면 다양한 설정을 관리하는 과정을 간소화할 수 있습니다. --dart-define 플래그로 각 변수를 개별적으로 전달하는 대신, 개발자는 필요한 모든 설정이 포함된 단일 .env 파일을 유지할 수 있습니다. 이 접근 방식은 환경 변수의 가독성과 구성을 향상시키며, 구성을 관리하고 업데이트하는 작업을 쉽게 만듭니다.

<div class="content-ad"></div>

```js
flutter run --dart-define-from-file=.env
```

실제로 실행해보겠습니다!

JSON 파일에서도 다음 형식의 key-value 쌍을 사용할 수 있습니다:

```js
flutter run --dart-define-from-file=env.json
```

<div class="content-ad"></div>

마크다운 형식으로 변경하면 다음과 같습니다.


![이미지1](/assets/img/2024-06-22-HowtouseenvironmentvariablesinFlutter_2.png)

이와 같이 여러 개의 .env 파일을 정의하여 아래와 같이 다양한 환경을 지원할 수 있습니다:

![이미지2](/assets/img/2024-06-22-HowtouseenvironmentvariablesinFlutter_3.png)

이제 dev.env 파일을 사용할 수 있습니다.


<div class="content-ad"></div>

```js
flutter run --dart-define-from-file=dev.env
```

그리고 prod.env 파일은 다음과 같이 작성하실 수 있어요.

```js
flutter run --dart-define-from-file=prod.env
```

걱정 마세요! 매번 앱을 실행할 때마다 --dart-define-from-file 인자를 지정할 필요는 없어요. IDE에서 이를 설정할 수 있어요.

<div class="content-ad"></div>

IntelliJ/Android Studio에서는 실행/디버그 구성을 업데이트해 주세요.

![이미지](/assets/img/2024-06-22-HowtouseenvironmentvariablesinFlutter_4.png)

VS Code에서는 launch.json을 편집해 주세요.

![이미지](/assets/img/2024-06-22-HowtouseenvironmentvariablesinFlutter_5.png)

<div class="content-ad"></div>

그거야! :) 여기 소스 코드예요

마지막으로, 환경 변수를 플러터에서 사용하면 설정을 안전하고 효율적으로 관리할 수 있어요.