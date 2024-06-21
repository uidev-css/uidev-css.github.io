---
title: "Dio 패키지로 Flutter에서 HTTP 요청 마스터하기 완벽 가이드"
description: ""
coverImage: "/assets/img/2024-06-21-MasteringHTTPRequestsinFlutterwithDioPackage_0.png"
date: 2024-06-21 22:09
ogImage: 
  url: /assets/img/2024-06-21-MasteringHTTPRequestsinFlutterwithDioPackage_0.png
tag: Tech
originalTitle: "Mastering HTTP Requests in Flutter with Dio Package"
link: "https://medium.com/@azizndao/mastering-http-requests-in-flutter-with-dio-package-975b75002911"
---


<img src="/assets/img/2024-06-21-MasteringHTTPRequestsinFlutterwithDioPackage_0.png" />

# 소개

Dio는 Dart용 HTTP 클라이언트로, API와 HTTP 요청을 처리하는 것이 쉽도록 도와줍니다. Dart HttpClient를 기반으로 만들어졌으며, 더 강력하고 유연한 기능이 추가되어 있습니다.

이 튜토리얼에서는 Dio를 Flutter 애플리케이션에서 사용하는 방법을 살펴보고, 몇 가지 기능을 살펴볼 것입니다.

<div class="content-ad"></div>

# 단계 1: Dio 설치하기

Flutter 애플리케이션에서 Dio를 사용하려면 해당 패키지를 프로젝트에 추가해야 합니다. 이를 위해 다음 줄을 pubspec.yaml 파일에 추가할 수 있습니다:

```js
dependencies:
  dio: ^5.4.0
```

패키지를 프로젝트에 추가한 후에는 flutter pub get 명령을 실행하여 설치할 수 있습니다.

<div class="content-ad"></div>

# 단계 2: Dio를 사용하여 HTTP 요청하기

Dio 패키지는 HTTP 요청을 쉽게 만들 수 있는 API를 제공합니다. 예를 들어 GET 요청을 하려면 dio.get() 메서드를 사용할 수 있습니다. 다음은 JSONPlaceholder API에 GET 요청을 하는 예시입니다:

```js
import 'package:dio/dio.dart';

...
final dio = Dio();
final response = await dio.get('https://jsonplaceholder.typicode.com/todos/1');
print(response.data);
...
```

위의 코드에서는 Dio 클래스의 인스턴스를 생성하여 JSONPlaceholder API에 GET 요청을 보내고 있습니다. 그리고 응답은 콘솔에 출력됩니다.

<div class="content-ad"></div>

HTTP 요청을 더 많은 유형으로도 보낼 수 있어요. 예를 들어 POST, PUT, DELETE 등이죠. POST 요청을 보내는 방법을 보여드릴게요!

```js
import 'package:dio/dio.dart';

...
final dio = Dio();
final response = await dio.post('https://jsonplaceholder.typicode.com/posts',
  data: {
    'title': 'My post',
    'body': 'This is my post content',
    'userId': 1,
  },
);
print(response.data);
...
```

위 코드에서는 dio.post() 메서드를 사용하여 JSONPlaceholder API로 POST 요청을 보냈어요. 요청과 함께 보내는 데이터는 우리가 만들고자 하는 게시물의 제목, 본문, 그리고 사용자 ID가 들어있는 JSON 객체에요.

# Step 3: Interceptors

<div class="content-ad"></div>

Dio는 인터셉터또한 제공합니다. 이는 요청이 보내거나 받기 전에 요청과 응답을 수정할 수 있도록 해줍니다. 인터셉터는 요청에 헤더를 추가하거나 오류를 처리하거나 네트워크 트래픽을 로깅하는 등 다양한 목적으로 사용될 수 있습니다.

다음은 Dio 인스턴스에 인터셉터를 추가하는 예시입니다:

```dart
import 'package:dio/dio.dart';

...

final dio = Dio();
dio.interceptors.add(
  InterceptorsWrapper(
    onRequest: (options, handler) {
      // 요청에 커스텀 헤더 추가
      options.headers['Authorization'] = 'Bearer my_token';
      return handler.next(options);
    },
  ),
);
final response = await dio.get('https://jsonplaceholder.typicode.com/todos/1');
print(response.data);
...
```

위 코드에서는 Dio 인스턴스에 인터셉터를 추가하여 모든 요청에 사용자 정의 Authorization 헤더를 추가했습니다. onRequest 콜백은 요청을 보내기 전에 호출되고, onResponse 콜백은 응답을 받은 후에 호출됩니다. onError 콜백은 오류가 발생할 경우 호출됩니다.

<div class="content-ad"></div>

# 단계 4: 취소

Dio는 더 이상 필요하지 않은 요청을 취소할 수 있게 하는 취소 토큰도 제공합니다. 이 기능은 요청이 너무 오래 걸리거나 더 이상 관련이 없는 요청을 중단해야 하는 상황에서 유용할 수 있습니다.

다음은 취소 토큰을 사용하는 예시입니다:

```js
import 'package:dio/dio.dart';

...
final dio = Dio();
final cancelToken = CancelToken();
final response = await dio.get('https://jsonplaceholder.typicode.com/todos/1',
  cancelToken: cancelToken,
);
print(response.data);
// 요청 취소
cancelToken.cancel('요청이 취소되었습니다');
...
```

<div class="content-ad"></div>

위의 코드에서는 CancelToken을 생성하고 dio.get() 메서드에 전달합니다. 요청을 취소하기로 결정하면 CancelToken 객체의 cancel() 메서드를 호출할 수 있습니다.

단계 5: 오류 처리

Dio는 HTTP 요청 시 발생할 수 있는 오류를 처리하는 편리한 방법을 제공합니다. dio.on 메서드를 사용하여 오류 핸들러를 등록하여 오류가 발생할 때마다 호출되도록 할 수 있습니다.

다음은 오류 처리하는 방법의 예시입니다:

<div class="content-ad"></div>

```dart
import 'package:dio/dio.dart';

...
final dio = Dio();
dio.on(DioError, (error, handler) {
  print('Request failed with error: ${error.message}');
  return handler.next(error);
});
final response = await dio.get('https://jsonplaceholder.typicode.com/todos/999');
print(response.data);
...
```

위의 코드에서는 DioError가 발생할 때마다 호출되는 오류 핸들러를 등록합니다. 오류 메시지가 콘솔에 출력되고 오류가 다음 오류 핸들러로 전달됩니다.

# 결론

이 튜토리얼에서는 Dio 패키지를 살펴보고 Flutter 애플리케이션에서 HTTP 요청을 하는 방법을 살펴보았습니다. HTTP 요청을 만드는 기본 사항, 인터셉터 사용, 요청 취소 및 오류 처리에 대해 다루었습니다.


<div class="content-ad"></div>

Dio는 Dart에서 API를 다루기 쉽게 만들어주는 강력하고 유연한 패키지입니다. 많은 기능과 옵션을 제공하여 HTTP 요청을 사용자 정의하고 오류를 효과적으로 처리할 수 있습니다. 이 튜토리얼이 도움이 되었기를 바라며, 여러분의 프로젝트에서 Dio를 더 탐험하도록 장려합니다.