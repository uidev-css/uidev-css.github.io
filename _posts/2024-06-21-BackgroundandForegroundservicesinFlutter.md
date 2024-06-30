---
title: "Flutter에서 백그라운드 서비스와 포어그라운드 서비스 사용 방법"
description: ""
coverImage: "/assets/img/2024-06-21-BackgroundandForegroundservicesinFlutter_0.png"
date: 2024-06-21 22:36
ogImage:
  url: /assets/img/2024-06-21-BackgroundandForegroundservicesinFlutter_0.png
tag: Tech
originalTitle: "Background and Foreground services in Flutter"
link: "https://medium.com/@sanjaysharmajw/background-and-foreground-services-in-flutter-cc66f612d58c"
---

![그림](/assets/img/2024-06-21-BackgroundandForegroundservicesinFlutter_0.png)

플러터의 백그라운드 및 포그라운드 서비스를 사용하면 앱이 활발히 실행되거나 활성화되어 있지 않을 때에도 백그라운드에서 작업을 수행할 수 있습니다. 이는 음악 재생, 인터넷에서 데이터 가져오기, 또는 사용자 경험을 방해하지 않고 장기간 실행되는 계산과 같은 작업을 포함합니다.

패키지 추가: Flutter Background Service 문서 읽기를 클릭

```js
  flutter_background_service: 5.0.2
  flutter_background_service_android: 6.1.0
  flutter_background_service_ios: ^5.0.0
```

<div class="content-ad"></div>

매니페스트에 다음 항목 추가해주세요.

```js
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE"/>
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE_LOCATION"/>
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE_DATA_SYNC"/>

    <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
    <uses-permission android:name="android.permission.WAKE_LOCK"/>
```

애플리케이션 태그 안에 다음을 추가해주세요.

```js
<service
    android:name="id.flutter.flutter_background_service.BackgroundService"
    android:foregroundServiceType="location"
/>

<service
    android:enabled="true"
    android:exported="true"
    android:name=".BackgroundService"
    android:stopWithTask="false"
/>

<receiver
    android:name=".WatchdogReceiver"
    android:enabled="true"
    android:exported="true"
/>

<receiver
    android:name=".BootReceiver"
    android:enabled="true"
    android:exported="true">
    <intent-filter>
        <action android:name="android.intent.action.BOOT_COMPLETED"/>
        <action android:name="android.intent.action.QUICKBOOT_POWERON"/>
    </intent-filter>
</receiver>
```

<div class="content-ad"></div>

다음은 main.dart에서 사용하세요:

```js
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeService();
  runApp(const MyApp());
}
```

```js
/// Foreground 및 Background
Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: false,
      isForegroundMode: true,
      // notificationChannelId: 'my_foreground',
      // initialNotificationContent: 'running',
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );
}
```

IOS용:

<div class="content-ad"></div>

```js
@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}
```

Android용:

```js
@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // // bring to foreground
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        flutterLocalNotificationsPlugin.show(
          0, 'This is foreground', '${DateTime.now()}',
          const NotificationDetails(
            android: AndroidNotificationDetails(
              "notificationChannelId",
              'MY FOREGROUND SERVICE',
              icon: 'ic_bg_service_small',
              ongoing: true,
            ),
          ),
        );
      }
    }
  });
}
```

이 메서드는 어디서든 사용할 수 있습니다:

<div class="content-ad"></div>

```js
void backgroundService()async{
  final service = FlutterBackgroundService();
  var isRunning = await service.isRunning();
  if (isRunning) {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (mounted) {
        setState(() {
          debugPrint("runningSanjay");
          CustomLoader.message("runningSanjay");
        });
      }
    });
  } else {
    service.startService();
  }
  setState(() {});
}
```

전체 코드:

```js
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeService();
  runApp(const MyApp());
}

/// Foreground and Background
Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: false,
      isForegroundMode: true,
      // notificationChannelId: 'my_foreground',
      // initialNotificationContent: 'running',
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  // bring to foreground
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        CustomLoader.message("foreground");
        flutterLocalNotificationsPlugin.show(
          0, 'COOL SERVICE', 'Awesome ${DateTime.now()}',
          const NotificationDetails(
            android: AndroidNotificationDetails(
              "notificationChannelId",
              'MY FOREGROUND SERVICE',
              icon: 'ic_bg_service_small',
              ongoing: true,
            ),
          ),
        );
      }
    }
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          inputDecorationTheme: const InputDecorationTheme(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue)
            ),
          )),
      home:  Container(
        color: Colors.white,
        child:  Center(
            child: Text("This is foreground service app"),
        ),
      ),
    );
  }
}
```

<img src="/assets/img/2024-06-21-BackgroundandForegroundservicesinFlutter_1.png" />

<div class="content-ad"></div>

이 기사를 즐겁게 읽으셨기를 바랍니다! 제공된 정보를 감사히 여기신다면 'Buy Me A Coffee'로 저를 지원할 수 있습니다! 여러분의 제스처에 감사드립니다!
