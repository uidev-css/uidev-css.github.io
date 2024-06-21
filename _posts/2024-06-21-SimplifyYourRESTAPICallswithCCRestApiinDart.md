---
title: "Dart에서 CC Rest Api로 REST API 호출 간단하게 하는 방법"
description: ""
coverImage: "/assets/img/2024-06-21-SimplifyYourRESTAPICallswithCCRestApiinDart_0.png"
date: 2024-06-21 20:34
ogImage: 
  url: /assets/img/2024-06-21-SimplifyYourRESTAPICallswithCCRestApiinDart_0.png
tag: Tech
originalTitle: "Simplify Your REST API Calls with CC Rest Api in Dart"
link: "https://medium.com/@ferhaterdem/simplify-your-rest-api-calls-with-cc-rest-api-in-dart-1e944e7ea9ab"
---


# 안녕하세요, Dart 애호가 여러분!

Dart 애플리케이션에서 REST API 호출의 복잡성에 지치셨나요? HTTP 요청과 응답을 처리하는 더 체계적이고 간편한 방법이 있으면 좋겠다고 생각하시나요? 걱정하지 마세요! 여러분의 REST API 상호작용을 보다 조직적이고 관리하기 쉬운 클래스 구조로 변환하여 여러분의 삶을 더 편하게 만들어주는 Dart 패키지, CC Rest Api를 소개해 드리게 되어 매우 기쁩니다.

본 문서에서는 CC Rest Api에 대해 알아야 할 모든 것을 초기화부터 모듈 생성과 사용까지 친절하게 안내해 드리겠습니다. 함께 알아보시죠!

# CC Rest Api를 선택해야 하는 이유?

<div class="content-ad"></div>

세부 사항에 들어가기 전에 CC Rest Api를 사용하고 싶어 하는 이유에 대해 이야기해 보겠습니다. 이 패키지를 개발하는 가장 큰 목표는 전통적인 방법 기반의 API 상호 작용을 클래스 기반 구조로 전환하는 것입니다. 이렇게 함으로써 코드를 단순화하는 것뿐만 아니라 복잡성을 줄여 유지 및 확장하기 쉽게 만듭니다.

CC Rest Api는 현재 GET, POST 및 DELETE 작업을 지원하며 API 통신에 필요한 가장 일반적인 기능을 다룹니다.

# 시작하기

# 설치

<div class="content-ad"></div>

먼저, CC Rest Api를 프로젝트에 추가해 봅시다. 간단히 pub.dev를 통해 추가할 수 있어요. 다음 줄을 pubspec.yaml 파일에 추가해 주세요:

```yaml
dependencies:
  cc_rest_api: ^1.0.0
```

그리고 flutter pub get을 실행하여 패키지를 설치해 주세요.

# 초기화

<div class="content-ad"></div>

CC Rest API를 사용하기 전에 REST API 구성 및 로깅 옵션으로 초기화해야 합니다. 아래는 설정하는 예시입니다:

```js
import 'package:cc_rest_api/cc_rest_api.dart';

void main() {
  CCRestApi.init(
    restOptions: CCRestOptions(
      baseUrl: "httpbin.org",
      defaultHeaders: {
        "Access-Control-Allow-Origin": "*",
        "Accept": "*",
        "Content-Type": "application/json",
      },
    ),
    loggingOptions: CCRestLogging(
      logEnabled: true,
      onRequest: (handler) => print("Request: $handler"),
      onResponse: (handler) => print("Response: $handler"),
      onError: (handler) => print("Error: $handler"),
    ),
    modules: [
      GetUser(const CCApiConfig("user/get", RequestType.GET, NetworkType.HTTPS)),
      // 다른 모듈을 여기에 추가할 수 있습니다
    ],
  );
}
```

이 예시에서는 기본 URL, 기본 헤더 및 로깅 옵션을 설정하고 있습니다. 로깅은 디버깅에 매우 유용하며 각 요청 및 응답의 세부 정보를 콘솔에서 직접 확인할 수 있습니다.

# 모듈 생성하기

<div class="content-ad"></div>

CC Rest Api의 진정한 힘은 모듈화된 접근 방식에서 나옵니다. 각 API 작업은 자체 모듈에 캡슐화될 수 있어 관리와 재사용이 쉬워집니다.

모듈을 만드는 방법은 다음과 같습니다:

```js
class GetUser extends CCApiModule {
  GetUser(CCApiConfig config) : super(config);

  @override
  Future<Map<String, dynamic>> request() async {
    return await super.request();
  }

  @override
  response(dynamic data) {
    // 받은 데이터에 대한 처리 로직을 여기에 추가할 수 있습니다
  }
}
```

또는, 요청 메서드를 사용자 정의할 필요가 없다면 더 간단하게 유지할 수도 있습니다:

<div class="content-ad"></div>

```dart
class GetUser extends CCApiModule {
  GetUser(CCApiConfig config): super(config);

  @override
  response(dynamic data) {
    // 여기에 받은 데이터를 처리하는 논리를 넣을 수 있습니다.
  }
}
```

# 모듈 사용하기

모듈을 설정한 후에 API 요청을 하는 것은 매우 간단합니다. GetUser 모듈을 사용하는 예시를 보여드리겠습니다:

```dart
import 'package:cc_rest_api/cc_rest_api.dart'; // 패키지 import

void main() {
  GetUser getUser = CCRestApi.getModule<GetUser>();
  getUser.setHeaders({
    "Authorization": "Bearer your_access_token",
  });
  getUser.setParameters({
    "param1": "value1",
    "param2": "value2",
  });
  getUser.setBody({
    "firebaseToken": "testFT",
    "user_id": "test",
  });

  getUser.request(); // 요청을 트리거합니다. 응답 값을 반환할 수 있습니다.
}
```

<div class="content-ad"></div>

이 예제에서는 GetUser 모듈의 인스턴스를 만들고, 필요한대로 헤더, 매개변수 및 본문을 설정합니다. 그런 다음 request() 메서드를 호출하여 API 호출을 트리거합니다. 쉽죠?

# 결론

CC Rest Api는 REST API 상호작용을 처리하는 구조화된 유연한 방법을 제공하여 Dart 개발자로서 여러분의 삶을 더 나은 방향으로 만들도록 고안되었습니다. 이 패키지를 사용하여 코드 복잡성을 줄이고 유지 관리성을 향상시키며, 앱에 멋진 기능을 더 많이 구축하는 데 집중할 수 있습니다.

이 기사가 CC Rest Api를 시작하는 방법에 대한 명확한 이해를 제공했기를 바랍니다. 한번 시도해보고 여러분에게 어떻게 작용하는지 알려주세요! 질문이나 피드백이 있으면 아래 댓글을 자유롭게 남겨주세요. 즐거운 코딩되세요!