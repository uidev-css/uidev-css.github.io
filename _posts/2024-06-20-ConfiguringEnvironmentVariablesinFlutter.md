---
title: "플러터Flutter에서 환경 변수 설정하기"
description: ""
coverImage: "/assets/img/2024-06-20-ConfiguringEnvironmentVariablesinFlutter_0.png"
date: 2024-06-20 13:48
ogImage: 
  url: /assets/img/2024-06-20-ConfiguringEnvironmentVariablesinFlutter_0.png
tag: Tech
originalTitle: "Configuring Environment Variables in Flutter"
link: "https://medium.com/@9dan_/configuring-environment-variables-in-flutter-e0614e3449e5"
---


우리 앱이 개발, 스테이징, 프로덕션 등 여러 환경을 지원해야 하는 경우가 많습니다.

여러 라이브러리를 사용하여 특정 환경과 관련된 변수를 선언할 수 있습니다. 오늘은 Flutter가 이 기능을 네이티브로 제공하여 간단하고 효율적으로 만드는 방법에 대해 설명하려고 합니다.

![이미지](/assets/img/2024-06-20-ConfiguringEnvironmentVariablesinFlutter_0.png)

# 환경 변수 선언

<div class="content-ad"></div>

## dart-define 사용하기

Flutter는 flutter run 및 flutter build 명령에 대해 --dart-define 옵션을 사용하여 환경 변수를 정의하는 쉬운 방법을 제공합니다.

예를 들어, 개발 환경에서 서버 URL을 선언하고 싶다면 다음과 같이 할 수 있습니다:

```js
flutter run --dart-define server_url=https://mywonderfulserver.development.com
```

<div class="content-ad"></div>

개발 API 키를 선언하고 싶을 때는 어떻게 하면 될까요? 단순히 다른 --dart-define를 추가하면 됩니다:

```js
flutter run --dart-define server_url=https://mywonderfulserver.development.com --dart-define api_key=mydevelopmentapikey
```

이 방법은 환경 변수가 몇 개 없을 때 잘 작동하지만, 변수가 많아질수록 가독성이 떨어질 수 있습니다. 변수의 수가 늘어날수록 관리하기 번거로워지고 변수를 빼먹거나 잘못 입력할 수 있는 실수가 발생할 수 있습니다.

## dart-define-from-file 사용하기

<div class="content-ad"></div>

만약 모든 변수를 파일에 넣고 그 파일을 사용할 수 있다면 어떨까요? --dart-define 방식의 가독성과 관리 용이성 문제를 해결하기 위해 Flutter는 --dart-define-from-file 옵션을 지원합니다.

이를 통해 모든 변수를 파일에 넣고 해당 파일을 flutter run 또는 flutter build 명령에 선언할 수 있습니다.

이전의 예제를 생각해보겠습니다. 개발 환경을 선언하는 server_url 및 api_key 두 변수가 있는 경우를 고려해 봅시다. 이를 직접 명령줄에 정의하는 대신 env/development.json이라는 JSON 파일을 만들 수 있습니다.

```js
{
  "server_url": "https://mywonderfulserver.development.com",
  "api_key": "mydevelopmentapikey"
}
```

<div class="content-ad"></div>

그리고 파일을 전달해 주세요:

```js
flutter run --dart-define-from-file env/development.json
```

이 방법은 훨씬 확장 가능하고 가독성을 크게 향상시킵니다. 파일을 사용함으로써 환경 변수를 중앙 집중화하여 필요에 따라 쉽게 관리하고 업데이트할 수 있습니다.

# 환경 변수 읽기

<div class="content-ad"></div>

환경 변수를 선언하는 방법에 상관없이 코드에서 그 값을 읽는 방법은 일관되게 유지됩니다. 일반적으로 이러한 변수를 읽는 유일한 목적의 정적 상수 필드가 있는 클래스를 사용하여 이러한 변수를 읽는 것이 일반적입니다. 이렇게 하면 응용 프로그램 전체에서 쉽게 접근할 수 있습니다.

다음은 그러한 클래스의 예시입니다:

```js
class Environment {
  const Environment._();

  static const String serverUrl = String.fromEnvironment('server_url');
  static const String apiKey = String.fromEnvironment('api_key');
}
```

이 방법은 환경 변수를 처리하는 깔끔하고 조직적인 방법을 제공합니다. 또한 환경 파일에서 int 또는 bool 값도 동일한 방법으로 읽을 수 있습니다.

<div class="content-ad"></div>

```dart
static const int magicInt = int.fromEnvironment('magic_number');
static const bool magicBool = bool.fromEnvironment('magic_bool');
```

`fromEnvironment` 팩토리는 키가 선언되지 않았을 때 오버라이드 가능한 기본값으로 설정됩니다.

```dart
// `defaultValue`가 지정되지 않은 경우, String.fromEnvironment는 ""를 기본값으로 사용합니다
static const String stringValue = String.fromEnvironment('string_key', defaultValue: 'Hello');
// int.fromEnvironment는 기본값으로 0을 사용합니다
static const String intValue = int.fromEnvironment('int_key', defaultValue: 42);
// bool.fromEnvironment는 기본값으로 false를 사용합니다
static const String boolValue = int.fromEnvironment('bool_key', defaultValue: true);
```

# 결론


<div class="content-ad"></div>

저는 처음부터 Flutter를 사용해왔는데요, 환경 설정 방법을 소개한 이후로 계속 사용해왔습니다. 이 방법 덕분에 많은 시간을 절약할 수 있고 앱을 다양한 환경에서 지원할 수 있어 매우 유연하게 유지할 수 있습니다. Flutter의 기본 환경 변수 처리 기능을 활용함으로써 개발 프로세스를 최적화하고 오류를 줄이며 더 깨끗한 코드를 유지할 수 있습니다.

좋은 하루 보내세요!

# 참고문헌