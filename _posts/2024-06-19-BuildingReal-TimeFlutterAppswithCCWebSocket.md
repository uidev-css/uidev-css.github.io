---
title: "CC 웹 소켓을 활용한 실시간 플러터 앱 구축"
description: ""
coverImage: "/assets/img/2024-06-19-BuildingReal-TimeFlutterAppswithCCWebSocket_0.png"
date: 2024-06-19 14:20
ogImage: 
  url: /assets/img/2024-06-19-BuildingReal-TimeFlutterAppswithCCWebSocket_0.png
tag: Tech
originalTitle: "Building Real-Time Flutter Apps with CC Web Socket"
link: "https://medium.com/@ferhaterdem/building-real-time-flutter-apps-with-cc-web-socket-c8429fa5c83c"
---


환영합니다! 실시간 Flutter 애플리케이션의 세계로 오신 것을 환영합니다! 오늘은 CC Web Socket을 소개할 기쁨이 있습니다. 이 강력하고 유연한 웹소켓 클라이언트는 Flutter 애플리케이션을 위해 특별히 설계되었습니다. 채팅 앱, 라이브 트레이딩 플랫폼, 또는 다른 실시간 애플리케이션을 구축 중이라면 CC Web Socket이 여러분을 도와드릴 것입니다.

# 웹소켓이 필요한 이유

CC Web Socket에 대한 구체적인 내용에 들어가기 전에, 왜 웹소켓이 필요한지 먼저 알아보겠습니다. 전통적인 HTTP 요청은 많은 작업에 좋지만, 실시간 통신에는 한계가 있습니다. 웹소켓은 클라이언트와 서버 간의 지속적인 연결을 제공하여 즉각적인 양방향 데이터 전송이 가능합니다. 이는 정시적인 업데이트가 중요한 애플리케이션에 이상적입니다.

# CC Web Socket 소개

<div class="content-ad"></div>

CC Web Socket은 Flutter에서 WebSocket 연결을 쉽게 관리할 수 있게 해줍니다. 간단한 설정 옵션, 자세한 로깅 및 모듈식 아키텍처로 설계되어 초보자부터 숙련된 개발자의 요구를 충족시킬 수 있습니다.

# 주요 기능

- 쉬운 초기화: 간편한 구성으로 웹소켓을 즉시 시작할 수 있습니다.
- 타임아웃 및 핑 설정: 연결 설정을 맞춤화하여 안정성과 반응성을 보장할 수 있습니다.
- 자동 재연결: 끊긴 연결에 대해 걱정할 필요가 없습니다. CC Web Socket이 재연결을 처리합니다.
- 자세한 로깅: 내장 로깅으로 연결 상태, 요청 및 응답을 추적할 수 있습니다.
- 모듈식 구조: 모듈을 사용하여 기능을 확장하고 사용자 정의할 수 있습니다.

# 시작하기

<div class="content-ad"></div>

파이썬에 대한 가상 환경을 시작하는 방법을 안내해 드릴게요.

# 1. 가상 환경 생성

가상 환경을 생성하려면 다음 명령어를 사용하세요:

```bash
python -m venv myenv
```

# 2. 가상 환경 활성화

윈도우에서는 다음 명령어로 가상 환경을 활성화하세요:

```bash
myenv\Scripts\activate
```

macOS 및 리눅스에서는 다음 명령어로 가상 환경을 활성화하세요:

```bash
source myenv/bin/activate
```

이제 가상 환경이 활성화되었습니다! 🎉

<div class="content-ad"></div>

그럼 flutter pub get을 실행하여 패키지를 설치하세요.

# 초기화

원하는 설정으로 CC Web Socket을 초기화하십시오. 간단한 예는 다음과 같습니다:

```js
import 'package:cc_web_socket/cc_web_socket.dart';

void main() {
  CCWebSocket.init(
    socketOptions: CCSocketOptions(
      uri: Uri(
        scheme: "wss",
        host: "echo.websocket.org",
        port: 443,
        path: ".ws",
      ),
      connectTimeout: const Duration(seconds: 5),
      pingInterval: const Duration(seconds: 120),
      requestTypeName: "request_type",
      autoConnect: true,
    ),
    loggingOptions: CCSocketLogging(
      logEnabled: true,
      onConnection: (prompt) => print("Connected: $prompt"),
      onReconnection: (prompt) => print("Reconnecting: $prompt"),
      onClosed: (prompt) => print("Connection closed: $prompt"),
      onRequest: (prompt) => print("Request: $prompt"),
      onResponse: (prompt) => print("Response: $prompt"),
      onError: (prompt) => print("Error: $prompt"),
    ),
    modules: [
      Example(),
    ],
  );
}
```

<div class="content-ad"></div>

이 예제에서는 WebSocket echo 서비스에 연결하고 있습니다. uri, 시간 제한 및 로깅 옵션을 필요에 따라 사용자 정의할 수 있습니다.

참고: requestTypeName 매개변수는 반환된 데이터의 올바른 모듈과 일치하는 JSON 콘텐츠에서의 식별자입니다.

# 연결하기

연결을 설정하려면 다음을 간단히 호출하면 됩니다:

<div class="content-ad"></div>

```js
CCWebSocket.connect();
```

# 모듈 사용하기

모듈을 사용하면 WebSocket 통신을 효율적으로 구조화할 수 있습니다. 모듈을 통해 요청을 보내는 방법은 다음과 같습니다:

```js
CCWebSocket.getModule<Example>().request(
  body: {
    "request_type": "Unknown",
  },
);
```

<div class="content-ad"></div>

# 사용자 정의 모듈 만들기

사용자 정의 모듈을 만드는 것은 간단합니다. 다음은 사용자 정의 모듈을 정의하는 예시입니다:

```js
class Example extends RequestModule {
  @override
  void request({required Map<String, dynamic> body}) {
    super.request(body: body);
  }

  @override
  void response(dynamic response) {
    print("받은 응답: $response");
  }
}
```

모듈에서 요청과 응답 모두를 처리할 수 있어서 관심사 분리를 깔끔하게 유지할 수 있습니다.

<div class="content-ad"></div>

# 실제 예시

실제 예시로 모든 것을 함께 살펴봅시다. 라이브 채팅 애플리케이션을 구축 중이라고 가정해보겠습니다. CC 웹 소켓을 사용하여 이를 설정하는 방법은 다음과 같습니다.

# 웹 소켓 초기화

```js
void main() {
  CCWebSocket.init(
    socketOptions: CCSocketOptions(
      uri: Uri(
        scheme: "wss",
        host: "yourchatserver.com",
        port: 443,
        path: "/chat",
      ),
      connectTimeout: const Duration(seconds: 5),
      pingInterval: const Duration(seconds: 60),
      requestTypeName: "message_type",
      autoConnect: true,
    ),
    loggingOptions: CCSocketLogging(
      logEnabled: true,
      onConnection: (prompt) => print("채팅 서버에 연결되었습니다."),
      onReconnection: (prompt) => print("채팅 서버 다시 연결 중..."),
      onClosed: (prompt) => print("채팅 서버 연결이 닫혔습니다."),
      onRequest: (prompt) => print("메시지 전송됨: $prompt"),
      onResponse: (prompt) => print("메시지 받음: $prompt"),
      onError: (prompt) => print("채팅 서버 오류: $prompt"),
    ),
    modules: [
      ChatModule(),
    ],
  );

  CCWebSocket.connect();
}
```

<div class="content-ad"></div>

# 채팅 모듈 정의

```js
class ChatModule extends RequestModule {
  @override
  void request({required Map<String, dynamic> body}) {
    super.request(body: body);
  }

  @override
  void response(dynamic response) {
    print("새로운 채팅 메시지: $response");
  }
}
```

# 메시지 보내기

```js
void sendMessage(String message) {
  CCWebSocket.getModule<ChatModule>().request(
    body: {
      "message_type": "chat",
      "content": message,
    },
  );
}
```

<div class="content-ad"></div>

이러한 단계를 따라 CC Web Socket을 사용하여 기본 라이브 채팅 애플리케이션을 만들었습니다. 이 모듈식 접근 방식은 코드를 깔끔하고 관리하기 쉽게 유지하며 새로운 기능 추가를 쉽게 만들어 줍니다.

# 결론

CC Web Socket은 어떤 플러터 개발자에게도 강력한 도구로, 애플리케이션에 실시간 기능을 추가하고자 하는 사람들에게 이상적입니다. 사용의 편의성, 강력한 기능, 그리고 모듈식 디자인은 플러터에서 WebSocket 관리의 핵심 선택지로 만들어 줍니다.

이 가이드가 CC Web Socket을 시작하고 멋진 실시간 애플리케이션을 만들도록 영감을 줄 수 있기를 바랍니다. 궁금한 점이나 의견이 있으면 언제든지 문의하거나 프로젝트에 기여해 주세요. 즐거운 코딩되세요!