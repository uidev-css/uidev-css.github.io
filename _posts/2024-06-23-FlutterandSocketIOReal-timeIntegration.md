---
title: "Flutter와 SocketIO 실시간 통합 방법"
description: ""
coverImage: "/assets/img/2024-06-23-FlutterandSocketIOReal-timeIntegration_0.png"
date: 2024-06-23 14:53
ogImage:
  url: /assets/img/2024-06-23-FlutterandSocketIOReal-timeIntegration_0.png
tag: Tech
originalTitle: "Flutter and Socket.IO: Real-time Integration"
link: "https://medium.com/@akshelar.18119/flutter-and-socket-io-real-time-integration-9112d48c41a3"
---

![Socket.IO package for Flutter](/assets/img/2024-06-23-FlutterandSocketIOReal-timeIntegration_0.png)

## Socket.IO는 무엇인가요?

Socket.IO는 실시간 이중방향 및 이벤트 주도 통신을 가능하게 하는 JavaScript 라이브러리입니다. 모든 플랫폼, 브라우저 또는 디바이스에서 작동하여 클라이언트와 서버 간의 원활한 연결을 보장합니다. Socket.IO는 WebSocket 프로토콜을 기반으로 작동하지만 다시 연결 지원, 멀티플렉싱 및 채널 지원과 같은 추가 기능을 제공합니다. 이는 즉각적인 데이터 업데이트 및 동적 상호작용이 필요한 애플리케이션에 이상적인 선택이 됩니다.

<div class="content-ad"></div>

Socket.IO를 Flutter와 통합하기 위해서는, 개발자들이 socket_io_client 패키지를 활용합니다. 이 패키지는 Socket.IO 클라이언트의 Dart 구현을 제공하여 Flutter 애플리케이션이 Socket.IO 서버와 원활하게 연결할 수 있도록 합니다.

# Flutter 프로젝트 설정하기:

- 의존성 추가: pubspec.yaml 파일을 열고 다음 종속성을 추가하세요:

```yaml
dependencies:
  socket_io_client: ^2.0.3+1
```

<div class="content-ad"></div>

# 로컬호스트에 연결하기:

- 로컬에서 Socket.IO 서버가 실행 중인지 확인하세요.
- `socketUrl` 함수는 에뮬레이터(IOS 또는 Android)에 적합한 로컬호스트 URL을 반환합니다.

```js
String socketUrl() {
  if (Platform.isAndroid) {
    return "http://10.0.2.2:3000";  // 안드로이드 에뮬레이터의 기본 IP 주소
  } else {
    return "http://localhost:3000"; // iOS 시뮬레이터용
  }
}
```

# 온라인 서버에 연결하기:

<div class="content-ad"></div>

온라인 Socket.IO 서버에 연결하려면:

- Socket.IO 서버를 온라인으로 배포하거나 기존 서버를 사용합니다.
- socketUrl 함수를 업데이트하여 온라인 서버 URL을 반환하세요.

```js
String socketUrl() {
  return "https://your-online-server-url.com";
}
```

사용자가 HomeScreen을 열자마자 소켓 서버에 연결을 설정하세요.

<div class="content-ad"></div>

```js
@override
void initState() {
  super.initState();

  // 소켓 서버에 연결
  socket = IO.io(socketUrl(), <String, dynamic>{
    'transports': ['websocket'],
  });

  // 'connect' 이벤트에 대한 이벤트 리스너
  socket.on('connect', (_) {
    print('서버에 연결되었습니다');
  });

  // 서버로부터 메시지 수신
  socket.on('message', (data) {
    _streamController.add(data);
  });
}
```

## 메시지 전송:

```js
void sendMessage(String message) {
  socket.emit('sendMessage', message);
}
```

sendMessage 메서드는 제공된 메시지와 함께 `sendMessage` 이벤트를 서버로 전송합니다.

<div class="content-ad"></div>

## 정리 작업 시 Dispose:

```js
@override
void dispose() {
  socket.disconnect();
  _streamController.close();
  super.dispose();
}
```

- dispose()은 위젯이 제거될 때 호출되며, 소켓을 연결 해제하고 스트림을 닫습니다.

# 출력:

<div class="content-ad"></div>

![Socket.IO Flutter Demo](https://miro.medium.com/v2/resize:fit:1200/1*fdjqKbSJXfSqS_13uHvy9g.gif)

# 전체 코드:

```js
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late IO.Socket socket;
  final StreamController<String> _streamController = StreamController<String>();
  Stream<String> get messagesStream => _streamController.stream;

  TextEditingController controller = TextEditingController();

  //This will give platofrm specific url for ios and android emulator
  String socketUrl() {
    if (Platform.isAndroid) {
      return "http://10.0.2.2:3000";
    } else {
      return "http://localhost:3000";
    }
  }

  @override
  void initState() {
    super.initState();
    // Connect to the Socket.IO server
    socket = IO.io(socketUrl(), <String, dynamic>{
      'transports': ['websocket'],
    });

    socket.on('connect', (_) {
      print('Connected to server');
    });

    // Listen for messages from the server
    socket.on('message', (data) {
      _streamController.add(data);
    });
  }

  @override
  void dispose() {
    // Disconnect from the Socket.IO server when the app is disposed
    socket.disconnect();

    //close stream
    _streamController.close();
    super.dispose();
  }

  void sendMessage(String message) {
    // Send a message to the server
    socket.emit('sendMessage', message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Socket.IO Flutter Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                onChanged: (value) {
                  if (socket.connected) {
                    sendMessage(value);
                  }
                },
                controller: controller,
                decoration: const InputDecoration(hintText: "Enter Message"),
              ),
            ),
            const SizedBox(height: 40),
            StreamBuilder<String>(
              stream: messagesStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: ListTile(
                    title: Text("Received Message: ${snapshot.data ?? ""}"),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
```
