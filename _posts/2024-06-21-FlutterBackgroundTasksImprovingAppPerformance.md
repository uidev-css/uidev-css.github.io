---
title: "Flutter 백그라운드 작업 앱 성능 향상 방법"
description: ""
coverImage: "/assets/img/2024-06-21-FlutterBackgroundTasksImprovingAppPerformance_0.png"
date: 2024-06-21 23:32
ogImage: 
  url: /assets/img/2024-06-21-FlutterBackgroundTasksImprovingAppPerformance_0.png
tag: Tech
originalTitle: "Flutter Background Tasks: Improving App Performance"
link: "https://medium.com/@parthbhanderi01/flutter-background-tasks-improving-app-performance-d1a6d54bd9ec"
---


요즘의 빠르게 변화하는 디지턈 세계에서 사용자들은 모바일 어플리케이션이 효율적이고 반응성이 있기를 원합니다. 개발자들은 이러한 요구를 충족시키기 위해 어플리케이션의 성능을 향상시키기 위한 다양한 전략을 사용해야 합니다. 그 중 하나는 백그라운드 작업을 실행하는 것인데, 이를 통해 Flutter 어플리케이션이 사용자 경험을 방해하지 않으면서 고통스러운 작업을 처리할 수 있습니다. 이 블로그 글에서 Flutter의 백그라운드 작업과 중요성을 살펴보고, 구현하는 방법을 보여줄 코딩 예제를 제공해보겠습니다.

## 백그라운드 작업이 중요한 이유

사용자 경험이 원활하고 끊김없이 유지되려면 백그라운드 프로세스가 필수적입니다. 이를 통해 프로그래머들은 동기화, 데이터 수집, 처리와 같이 자원 집약적인 작업을 주 UI 스레드를 방해하지 않고 백그라운드에서 처리할 수 있습니다. 이러한 작업들은 백그라운드 프로세스로 이동되어 어플리케이션이 반응적으로 유지되고 사용자들에게 원활한 경험을 제공합니다.

## Flutter 백그라운드 작업 구현

<div class="content-ad"></div>

플러터는 배경 작업을 효과적으로 수행하기 위한 다양한 도구와 모듈을 제공합니다. 자주 사용되는 두 가지 방법을 살펴봅시다:

Isolate를 기반으로 하는 배경 작업:

메인 UI 스레드와 병렬로 작동하는 경량 별도 실행 스레드인 아이솔레이트는 배경 작업을 메인 스레드에 간섭하지 않고 수행할 수 있도록 합니다. 다음은 아이솔레이트가 배경 작업에 사용되는 예시입니다:

```js
import 'dart:async';
import 'dart:isolate';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
    _startBackgroundTask();
  }

  void _startBackgroundTask() async {
    await Isolate.spawn(_backgroundTask, _port.sendPort);
    _port.listen((message) {
      // 배경 작업 완료 처리
      print('배경 작업 완료: $message');
    });
  }

  static void _backgroundTask(SendPort sendPort) {
    // 시간이 많이 소요되는 작업 수행
    // ...

    // 결과를 메인 UI 아이솔레이트로 전송
    sendPort.send('작업 성공적으로 완료!');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('플러터의 배경 작업'),
        ),
        body: Center(
          child: Text('배경 작업 실행 중...'),
        ),
      ),
    );
  }
}
```

<div class="content-ad"></div>

플러터의 배경 작업 가져오기:

앱이 닫혀 있거나 사용 중이 아닌 경우에도, 개발자는 플러터 배경 작업 가져오기 플러그인을 사용하여 주기적인 배경 작업을 계획할 수 있습니다. 이는 데이터 동기화나 앱 컨텐츠 업데이트와 같은 상황에서 유용합니다. 플러터 배경 작업 가져오기 패키지를 사용하는 예제는 다음과 같습니다:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_background_fetch/flutter_background_fetch.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('플러터에서 배경 작업 실행'),
        ),
        body: Center(
          child: Text('배경 작업 실행 중...'),
        ),
      ),
    );
  }
}

void backgroundFetchHeadlessTask(String taskId) async {
  // 여기에서 시간이 오래 걸리는 작업을 수행합니다
  // ...

  FlutterBackgroundFetch.finish(taskId);
}

void initBackgroundFetch() {
  FlutterBackgroundFetch.configure(
    minimumFetchInterval: 15,
    stopOnTerminate: false,
    startOnBoot: true,
    enableHeadless: true,
    requiresBatteryNotLow: false,
    requiresCharging: false,
    requiresStorageNotLow: false,
    requiresDeviceIdle: false,
    requiredNetworkType: NetworkType.NONE,
  );
  FlutterBackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}
```

플랫폼 채널:

<div class="content-ad"></div>

플랫폼 채널을 통해 Flutter는 네이티브 플랫폼 코드와 통신할 수 있습니다. 코틀린 또는 스위프트로 플랫폼별 코드를 작성하면 백그라운드 작업을 수행할 수 있는 플랫폼 채널을 사용할 수 있습니다. 필요한 작업은 그런 다음 네이티브 코드에서 백그라운드에서 수행될 수 있고, Flutter 앱에서 결과를 얻을 수 있습니다. 이 접근 방식으로 유연성과 플랫폼별 API에 접근할 수 있습니다.

배경 작업을 실행하여 플랫폼별 코드를 사용하여 기기의 현재 위치를 획득하는 활동을 실행하려고 상상해보세요. 이렇게 플랫폼 채널이 사용되는 방법을 설명하기 위한 것입니다.

Flutter 앱에서 플랫폼별 코드를 실행하는 메서드를 만들어보세요:

```js
import 'package:flutter/services.dart';

Future<String> getCurrentLocation() async {
  const platform = MethodChannel('your_channel_name');
  try {
    final String result = await platform.invokeMethod('getCurrentLocation');
    return result;
  } catch (e) {
    return 'Failed to get location: $e';
  }
}
```

<div class="content-ad"></div>

플랫폼별 언어로 위치 검색 기능을 구현해보세요:

```js
class MainActivity : FlutterActivity() {
    private val CHANNEL = "your_channel_name"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getCurrentLocation") {
                // 백그라운드에서 위치를 검색합니다
                val location = getLocation()
                result.success(location)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getLocation(): String {
        // 안드로이드 특화 API를 사용하여 위치를 가져옵니다
        // ...
        return "위도: 20.5937, 경도: 78.9629"
    }
}
```

```js
import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    let CHANNEL = "your_channel_name"

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: CHANNEL, binaryMessenger: controller.binaryMessenger)
        channel.setMethodCallHandler { [weak self] call, result in
            if call.method == "getCurrentLocation" {
                // 백그라운드에서 위치를 검색합니다
                let location = self?.getLocation() ?? ""
                result(location)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func getLocation() -> String {
        // iOS 특화 API를 사용하여 위치를 가져옵니다
        // ...
        return "위도: 123.456, 경도: 78.901"
    }
}
```

WorkManager(안드로이드) 및 BackgroundFetch(iOS)에서 사용하세요.

<div class="content-ad"></div>

주어진 플랫폼에서 백그라운드 작업을 보다 효과적으로 처리하기 위해 WorkManager(안드로이드)와 BackgroundFetch(iOS)와 같은 플랫폼별 라이브러리를 사용할 수 있습니다. 이러한 라이브러리에는 작업 스케줄링, 반복 및 네트워크 의존 프로세스 관리, 그리고 작업이 완료되었을 때 Flutter 앱에 콜백을 제공하는 기능이 포함되어 있습니다.

만약 이 방법을 보여주기 위해 서버에서 데이터를 정기적으로 다운로드하는 백그라운드 활동을 예약하려고 한다면 다음과 같이 할 수 있습니다.

WorkManager를 사용하기 위해 android/app/build.gradle 파일에 필요한 종속성을 추가하세요:

```js
dependencies {
    def work_version = "2.6.0"

    implementation "androidx.work:work-runtime:$work_version"
}
```

<div class="content-ad"></div>

워커 클래스를 만들어 백그라운드 작업을 설명해 보겠습니다:

```js
// 플러터 측
import 'package:flutter_background_fetch/flutter_background_fetch.dart';

void initBackgroundFetch() {
  FlutterBackgroundFetch.configure(
    minimumFetchInterval: 15,
    stopOnTerminate: false,
    startOnBoot: true,
    enableHeadless: true,
    requiresBatteryNotLow: false,
    requiresCharging: false,
    requiresStorageNotLow: false,
    requiresDeviceIdle: false,
    requiredNetworkType: NetworkType.NONE,
  );
  FlutterBackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}

void backgroundFetchHeadlessTask(String taskId) async {
  // 여기서 시간이 많이 소요되는 작업(예: 데이터 가져오기)을 수행합니다
  // ...

  FlutterBackgroundFetch.finish(taskId);
}
```

BackgroundFetch를 사용하려면 pubspec.yaml 파일에 다음 종속성을 추가하세요:

```js
dependencies:
  background_fetch: ^0.9.0
```

<div class="content-ad"></div>

다음 백그라운드 작업을 구현해보세요:

```js
// 플러터 측
import 'package:flutter/material.dart';
import 'package:background_fetch/background_fetch.dart';

void main() {
  runApp(MyApp());
  initBackgroundFetch();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter에서 백그라운드 작업'),
        ),
        body: Center(
          child: Text('백그라운드 작업 실행 중...'),
        ),
      ),
    );
  }
}

void initBackgroundFetch() {
  BackgroundFetch.configure(
    BackgroundFetchConfig(
      minimumFetchInterval: 15,
      stopOnTerminate: false,
      startOnBoot: true,
      enableHeadless: true,
    ),
    (String taskId) async {
      // 여기서 시간이 많이 소요되는 작업(예: 데이터 가져오기) 수행하기
      // ...

      BackgroundFetch.finish(taskId);
    },
  );
}
```

## 타이머:

항상 번거로운 백그라운드 작업을 실행할 필요는 없을 수 있습니다. 대신 플러터 프로그램에 내장된 타이머를 활용할 수도 있습니다. Dart 프로그래밍 언어에는 백그라운드 작업을 계획하고 수행할 수 있는 Timer 클래스가 함께 제공되며, 플랫폼별 추가 기능이 필요하지 않은 프로젝트에 적합합니다.

<div class="content-ad"></div>

이 예시를 위해, 플러터 앱에서 매 시간마다 공지를 표시하고 싶다고 가정해 봅시다.

```js
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(MyApp());
  scheduleNotifications();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('플러터에서 백그라운드 작업하기'),
        ),
        body: Center(
          child: Text('백그라운드 작업 실행 중...'),
        ),
      ),
    );
  }
}

void scheduleNotifications() {
  Timer.periodic(Duration(hours: 1), (Timer timer) {
    showNotification();
  });
}

void showNotification() {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // 플러그인 설정 초기화
  // ...

  flutterLocalNotificationsPlugin.show(
    0,
    '매 시간 알림',
    '매 시간 트리거되는 알림입니다.',
    NotificationDetails(
      android: AndroidNotificationDetails(
        '채널 ID',
        '채널 이름',
        '채널 설명',
      ),
      iOS: IOSNotificationDetails(),
    ),
  );
}
```

## Firebase Cloud Messaging (FCM):

Firebase Cloud Messaging (FCM)은 서버 이벤트에 의해 유발된 경보를 보내거나 활동을 수행하는 백그라운드 활동에 도움이 될 수 있습니다. 플러터 앱이 열리지 않거나 사용되지 않아도 FCM을 통해 서버에서 메시지를 전송할 수 있습니다. 이 신호에 응답하고 필요한 백그라운드 작업을 수행할 수 있습니다.

<div class="content-ad"></div>

이 예제를 기준으로 FCM 알림을 수신할 때마다 백그라운드 프로세스를 실행하려고 한다고 가정해 봅시다.

```dart
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter에서 백그라운드 작업'),
        ),
        body: Center(
          child: Text('백그라운드 작업 실행 중...'),
        ),
      ),
    );
  }
}

void initFirebaseMessaging() {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  messaging.configure(
    onMessage: (message) {
      // 메시지를 수신할 때 백그라운드 작업 수행
      // ...
      return;
    },
    onResume: (message) {
      // 앱이 백그라운드에서 다시 활성화될 때 백그라운드 작업 수행
      // ...
      return;
    },
    onLaunch: (message) {
      // 앱이 종료된 상태에서 다시 실행될 때 백그라운드 작업 수행
      // ...
      return;
    },
  );
}
```

## 결론:

Flutter 애플리케이션의 효율성을 향상시키는 중요한 구성 요소 중 하나는 백그라운드 활동입니다. 시간이 오래 걸리는 작업을 백그라운드에서 실행함으로써 원활한 사용자 경험을 제공하고 UI가 느려지는 것을 방지할 수 있습니다. 이 블로그 글에서는 아이솔레이트와 Flutter Background Fetch 패키지의 사용법을 살펴보았습니다. 이러한 전략을 Flutter 애플리케이션에 구현하여 앱의 속도를 향상시키고 우수한 사용자 경험을 제공할 수 있습니다.

<div class="content-ad"></div>

앱 기능과 효율성을 균형 있게 유지하기 위해 백그라운드 작업을 구현할 때 장치 자원, 배터리 수명 및 네트워크 이용량과 같은 요소를 고려하는 것이 중요합니다.

## 코딩 즐기세요!!!…