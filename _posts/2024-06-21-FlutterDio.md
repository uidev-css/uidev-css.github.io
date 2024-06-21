---
title: "2024년 Flutter에서 Dio로 HTTP 요청을 간편하게 보내는 방법"
description: ""
coverImage: "/assets/img/2024-06-21-FlutterDio_0.png"
date: 2024-06-21 19:56
ogImage: 
  url: /assets/img/2024-06-21-FlutterDio_0.png
tag: Tech
originalTitle: "Flutter Dio"
link: "https://medium.com/@hemantjamdev/flutter-dio-dc1e6d4659eb"
---


# Flutter에서 Dio를 활용한 네트워크 요청 마스터하기

Flutter 개발 세계에서 네트워크 요청을 보내는 것은 흔한 작업입니다. Flutter는 기본적인 HTTP 요청 처리 기능을 제공하지만 Dio와 같은 강력한 라이브러리를 통해 고급 기능을 제공하고 프로세스를 간소화할 수 있습니다. 이 글에서는 Dart용 강력한 HTTP 클라이언트인 Dio에 대해 깊이 있게 알아보고, 이를 통해 Flutter 개발을 더 쉽고 효율적으로 만드는 방법을 살펴보겠습니다.

## Dio란 무엇인가요?

Dio는 복잡한 네트워크 작업을 처리하는데 필요한 쉬운 API, 고급 구성 옵션, 다양한 기능을 제공하는 Dart용 강력한 HTTP 클라이언트입니다. 주요 기능 중 일부는 다음과 같습니다:

<div class="content-ad"></div>

- 요청 및 응답 로깅을위한 인터셉터
- 글로벌 구성 옵션
- 폼 데이터 처리
- 파일 다운로드
- 시간 초과 처리
- HTTP, WebSocket 등을위한 사용자 정의 어댑터
- 자동 JSON 직렬화

## Dio를 사용해야 하는 이유?

Flutter의 내장 http 패키지는 간단한 작업에는 충분하지만, Dio는 더 많은 기능을 제공하여 복잡한 네트워크 작업에 적합합니다. 인터셉터 및 폼 데이터 처리와 같은 강력한 기능으로 많은 개발자들에게 선택되는 이유입니다.

## Dio 시작하기

<div class="content-ad"></div>

Dio 시작하려면, Flutter 프로젝트의 종속성에 Dio를 추가해야 해요. pubspec.yaml 파일을 열고 다음과 같이 추가해 주세요:

```yaml
dependencies:
  dio: ^5.0.0
```

패키지를 설치하려면 flutter pub get을 실행해 주세요.

## 간단한 GET 요청하기

<div class="content-ad"></div>

간단한 GET 요청부터 시작해봅시다. 먼저 Dio 패키지를 가져와주세요.

```js
import 'package:dio/dio.dart';
```

이제 Dio의 인스턴스를 만들고 GET 요청을 보내보세요:

```js
void fetchUser() async {
  try {
    final dio = Dio();
    final response = await dio.get('https://jsonplaceholder.typicode.com/users/1');
    print(response.data);
  } catch (e) {
    print('Error: $e');
  }
}
```

<div class="content-ad"></div>

이 코드 스니펫은 API에서 사용자 데이터를 가져오기 위해 GET 요청을 보내는 방법을 보여줍니다.

## 오류 처리

Dio는 견고한 오류 처리 메커니즘을 제공합니다. 다양한 유형의 오류를 catch하여 적절히 처리할 수 있습니다:

```js
void fetchUser() async {
  try {
    final dio = Dio();
    final response = await dio.get('https://jsonplaceholder.typicode.com/users/1');
    print(response.data);
  } on DioError catch (e) {
    if (e.response != null) {
      print('에러 응답: ${e.response?.data}');
    } else {
      print('에러 메시지: ${e.message}');
    }
  }
}
```

<div class="content-ad"></div>

## Interceptors 사용하기

Dio의 Interceptors는 요청을 보내기 전이나 응답을 받은 후에 작업을 수행할 수 있게 해줍니다. 이는 로깅, 요청 수정 또는 전역적으로 오류를 처리하는 데 유용합니다.

```js
final dio = Dio();
```

```js
dio.interceptors.add(
  InterceptorsWrapper(
    onRequest: (options, handler) {
      print('Request: ${options.method} ${options.path}');
      return handler.next(options);
    },
    onResponse: (response, handler) {
      print('Response: ${response.statusCode} ${response.data}');
      return handler.next(response);
    },
    onError: (DioError e, handler) {
      print('Error: ${e.message}');
      return handler.next(e);
    },
  ),
);
```

<div class="content-ad"></div>

## POST 요청하기

Dio를 사용하여 POST 요청을 보내려면 post 메서드를 사용할 수 있습니다. 다음은 POST 요청에서 JSON 데이터를 보내는 예시입니다:

```js
void createUser() async {
  try {
    final dio = Dio();
    final response = await dio.post(
    'https://jsonplaceholder.typicode.com/users',
    data: {
      'name': 'John Doe',
      'email': 'john.doe@example.com',
    },
    );
    print(response.data);
  } catch (e) {
    print('Error: $e');
  }
}
```

## 파일 업로드 및 다운로드

<div class="content-ad"></div>

Dio를 사용하면 파일 업로드 및 다운로드를 쉽게 처리할 수 있습니다. 파일을 업로드하는 방법은 다음과 같습니다:

```js
void uploadFile() async {
  try {
    final dio = Dio();
    final file = await MultipartFile.fromFile('파일 경로');
    final response = await dio.post(
      'https://example.com/upload',
      data: FormData.fromMap({
        'file': file,
      }),
    );
    print(response.data);
  } catch (e) {
    print('Error: $e');
  }
}
```

파일을 다운로드하는 방법은 다음과 같습니다:

```js
void downloadFile() async {
  try {
    final dio = Dio();
    final response = await dio.download(
      'https://example.com/file',
      '저장할 파일 경로',
    );
    print('파일 다운로드됨: ${response.statusCode}');
  } catch (e) {
    print('Error: $e');
  }
}
```

<div class="content-ad"></div>

## 결론

Dio는 플러터용으로 개발된 다재다능하고 강력한 HTTP 클라이언트로, 네트워크 요청을 간단하게 만들어주고 복잡한 시나리오를 다룰 수 있는 고급 기능을 제공합니다. Dio를 플러터 프로젝트에 통합하면 네트워크 작업을 더 효율적으로 처리하고 관련 코드양을 줄일 수 있습니다.

간단한 앱을 개발하거나 복잡한 기업 애플리케이션을 구축하더라도, Dio는 플러터에서 모든 네트워크 요청을 처리하는 좋은 선택지입니다. 다음 프로젝트에서 Dio를 사용해보고 차이를 경험해보세요!