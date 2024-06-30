---
title: "Flutter FCM - 푸시 알림 탭 후 특정 화면으로 이동하는 방법"
description: ""
coverImage: "/assets/img/2024-06-21-FlutterFCMHowtoNavigatetoaParticularScreenAfterTappingonPushNotification_0.png"
date: 2024-06-21 23:04
ogImage:
  url: /assets/img/2024-06-21-FlutterFCMHowtoNavigatetoaParticularScreenAfterTappingonPushNotification_0.png
tag: Tech
originalTitle: "Flutter: FCM — How to Navigate to a Particular Screen After Tapping on Push Notification"
link: "https://medium.com/firebase-developers/flutter-fcm-how-to-navigate-to-a-particular-screen-after-tapping-on-push-notification-8cb5d5111ee6"
---

이 게시물에서는 FCM 푸시 알림을 수신하고 사용자가 푸시 알림을 탭했을 때 특정 페이지로 이동하는 방법에 대해 Flutter에서 설명하겠습니다 (서버 측 코드 없음).

![Flutter FCM How to Navigate to a Particular Screen After Tapping on Push Notification](/assets/img/2024-06-21-FlutterFCMHowtoNavigatetoaParticularScreenAfterTappingonPushNotification_0.png)

## iOS 설정

Apple의 플랫폼에서 개발하는 것은 때로 어려울 수 있습니다. 예를 들어 Android와는 달리, 푸시 알림을 테스트하려면 실제 기기가 필요하며 Apple 개발자 프로그램에 관리자 또는 계정 보유자로 등록해야 합니다.

<div class="content-ad"></div>

- Xcode에서 Targets `Runner` Signing & Capabilities로 이동하여 푸시 알림을 추가하려면 +를 눌러주세요. 그리고 Background Modes에 Background fetch와 Remote notification도 추가해주세요.

2. Apple Developer Member Center에서 Certificates, Identifiers & Profile로 이동하여 `Keys`에서 Apple Push Notification service (APN) 키를 추가해주세요. 그런 다음, 해당 키를 Firebase Console `Project Settings` Cloud Messaging `Apple app configuration`에 추가해주세요.

3. 나머지는 매우 간단합니다 — 공식 문서를 참조해주세요.

## Android 설정

<div class="content-ad"></div>

Foreground Notification(푸시 알림이 일시적으로 화면 상단에 팝업되는 경우)을 사용하려면 AndroidManifest.xml에 아래의 메타데이터가 필요합니다. 'high_importance_channel'에 대한 고급 중요도 채널은 Firebase 공식 문서에서 제공된 이름을 사용했으며 platformChannelSpecifics에서 (아래에서 자세히 설명함) 채널 이름을 지정할 수 있습니다.

```js
<meta-data
  android:name="com.google.firebase.messaging.default_notification_channel_id"
  android:value="high_importance_channel"
/>
```

## Firebase 초기화

먼저 필요한 모든 패키지를 추가해주세요.

<div class="content-ad"></div>

```js
flutter pub add firebase_messaging
flutter pub add firebase_core
flutter pub add flutter_local_notifications
```

파일들을 프로바이더와 서비스 파일로 분리하는 것에 익숙하지만, 그렇게 하는 것이 필요하지는 않습니다. Firebase 초기화에 대해 말씀드리면 main 함수에서 해야 합니다.

```js
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.initializeFirebase();
  runApp(const MyApp());
}
```

```js
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseService {
  static FirebaseMessaging? _firebaseMessaging;
  static FirebaseMessaging get firebaseMessaging => FirebaseService._firebaseMessaging ?? FirebaseMessaging.instance;

  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    FirebaseService._firebaseMessaging = FirebaseMessaging.instance;
    await FirebaseService.initializeLocalNotifications();
    await FCMProvider.onMessage();
    await FirebaseService.onBackgroundMsg();
  }

  Future<String?> getDeviceToken() async => await FirebaseMessaging.instance.getToken();

  static FlutterLocalNotificationsPlugin _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initializeLocalNotifications() async {
    final InitializationSettings _initSettings = InitializationSettings(
      android: AndroidInitializationSettings("icon_name"),
      iOS: DarwinInitializationSettings()
    );
    /// on did receive notification response = for when app is opened via notification while in foreground on android
    await FirebaseService.localNotificationsPlugin.initialize(_initSettings, onDidReceiveNotificationResponse: FCMProvider.onTapNotification);
    /// need this for ios foregournd notification
    await FirebaseService.firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  static NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: AndroidNotificationDetails(
      "high_importance_channel", "High Importance Notifications", priority: Priority.max, importance: Importance.max,
    ),
  );

  // for receiving message when app is in background or foreground
  static Future<void> onMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (Platform.isAndroid) {
        // if this is available when Platform.isIOS, you'll receive the notification twice
        await FirebaseService._localNotificationsPlugin.show(
          0, message.notification!.title, message.notification!.body, FirebaseService.platformChannelSpecifics,
          payload: message.data.toString(),
        );
      }
    });
  }

  static Future<void> onBackgroundMsg() async {
    FirebaseMessaging.onBackgroundMessage(FCMProvider.backgroundHandler);
  }

}
```

<div class="content-ad"></div>

FirebaseService.initializeFirebase 메서드 내의 모든 메서드를 살펴보겠습니다.

\_firebaseMessaging: 이전 FCM 포스트를 작성하던 중 한국 어딘가에서 FirebaseMessaging.instance를 한 번만 호출하는 것이 좋다는 글을 읽은 적이 있어요. 그래서 이를 initialize 메서드에서 초기화하고, \_firebaseMessaging이 null인 경우 적절한 값을 제공해주는 getter를 만들었어요.

initializeLocalNotifications: Foreground Notification을 활용하려면 이 메서드가 필요해요. Android에서는 반드시 전달해야 하는 인자 중 하나가 android/app/src/main/res/drawable에 있어야 하는 아이콘 로고 파일 이름이에요.

전달된 두 번째 인자는 onSelectNotification으로, 사용자가 푸시 알림을 탭했을 때 (앱이 포그라운드에 있을 때) 실행되는 콜백입니다. 이런 처리가 없으면 앱이 열리고 더 이상의 작업이 발생하지 않아요. 이 메서드는 onMessage의 FirebaseMessaging.onMessage.listen(안드로이드용)로부터 페이로드를 받습니다.

<div class="content-ad"></div>

`onMessage`: 앱이 활성 상태인 경우에 알림을 받을 때 호출됩니다.

`onBackgroundMsg`: 앱이 백그라운드에 있거나 종료된 상태일 때 알림을 받을 때 호출됩니다.

## 디바이스 토큰 받기/확인

```js
Future<String?> getDeviceToken() async => await FirebaseService.firebaseMessaging.getToken();
```

<div class="content-ad"></div>

기기 토큰을 관리하는 올바른 방법은 없지만 Firebase가 권장하는 방법이 있습니다. 제가 선택한 방법은 sqflite를 사용하여 사용자 기기에 타임스탬프와 함께 기기 토큰을 저장하고 서버로 보내는 것입니다. 앱이 열릴 때마다 기기에 저장된 토큰이 있다면 서버로 전송됩니다. 타임스탬프가 한 달 이상 경과했다는 것을 나타내는 경우, 토큰이 새로 고침되고 새 토큰이 서버로 전송됩니다. (아래 코드는 sqflite를 사용하는 제 sql 파일을 기반으로 합니다.)

```js
Future<String?> checkDeviceToken() async {
    String? _deviceToken;
    final bool _exists = await this._sqlService.tableExists(this._tableName);
    if (_exists) {
        final List<Json> _data = await this._sqlService.readData(this._tableName);
        final DateTime _timeStamp = DateTime.parse(_data[0]["timeStamp"]);
        if (_timeStamp.difference(DateTime.now()).inDays > 30) {
            _deviceToken = await this._getDeviceToken();
            if (_deviceToken == null) return null; // todo error handling
            await this._updateDeviceToken(_deviceToken);
        } else {
            _deviceToken = _data[0]["deviceToken"];
        }
    } else {
        _deviceToken = await this._getDeviceToken();
        if (_deviceToken == null) return null; // todo error handling
        await this._saveDeviceToken(_deviceToken);
    }
    return _deviceToken;
}

Future<String?> _getDeviceToken() async => await FirebaseService.firebaseMessaging.getToken();

Future<void> _saveDeviceToken(String deviceToken) async {
    final String _createSql = "CREATE TABLE ${this._tableName}(deviceToken TEXT PRIMARY KEY NOT NULL, timeStamp TEXT NOT NULL)";
    final List<Object> _values = [deviceToken, DateTime.now().toIso8601String()];
    final String _insertSql = "INSERT INTO ${this._tableName}(deviceToken, timeStamp) VALUES(?, ?)";
    await this._sqlService.saveData(tableName: this._tableName, createSql: _createSql, insertSql: _insertSql, values: _values);
}

Future<void> _updateDeviceToken(String deviceToken) async {
    final String _updateSql = "UPDATE ${this._tableName} SET deviceToken = ?, timeStamp = ?";
    final List<Object> _values = [deviceToken, DateTime.now().toIso8601String()];
    await this._sqlService.updateData(tableName: this._tableName, updateSql: _updateSql, values: _values);
}
```

## 알림 수신

불행히도 저는 서버 측 코드를 만들지 않아 message.data가 어떻게 작동하는지를 보여줄 수 없습니다. 왜냐하면 Firebase의 테스트 알림은 message.notification.body와 message.notification.title만 허용하기 때문입니다. 더 구체적인 알림을 테스트하려면 백엔드 개발자와 협력해야 합니다.

<div class="content-ad"></div>

푸시 알림을 받고 앱을 열 수 있는 세 가지 방법이 있습니다:

- 앱이 화면에 표시될 때
- 앱이 백그라운드에 있을 때
- 앱이 종료되었을 때

## 앱이 화면에 표시될 때 (Android)

사용자가 알림을 탭하면 기본적으로 앱이 열리게 됩니다. 그러나 때로는 사용자가 특정 페이지를 볼 수 있기를 원할 수도 있습니다. 백엔드 개발자는 이러한 정보를 메시지.data에 제공할 수 있습니다. 해당 정보를 가져오기 위해 제공자를 만들었고, Navigator.of(context).push를 사용하기 위해 첫 화면에서 제공자의 BuildContext 변수를 초기화했습니다.

<div class="content-ad"></div>

@override
void init() {
super.initState();
WidgetsBinding.instance.addPostFrameCallback((\_) {
FCMProvider.setContext(context);
});
}

import 'package:firebase_messaging/firebase_messaging.dart' show FirebaseMessaging, RemoteMessage;
import 'package:flutter/widgets.dart';
import 'package:pops/helpers/custom_types.dart';

import '../views/store_detail/store_detail_page.dart';

class FCMProvider with ChangeNotifier {
static BuildContext? \_context;

static void setContext(BuildContext context) => FCMProvider.\_context = context;

/// when app is in the foreground
static Future<void> onTapNotification(NotificationResponse? response) async {
if (FCMProvider.\_context == null || response?.payload == null) return;
final Json \_data = FCMProvider.convertPayload(response!.payload!);
if (\_data.containsKey(...)){
await Navigator.of(FCMProvider.\_context!).push(...);
}
}

static Json convertPayload(String payload){
final String \_payload = payload.substring(1, payload.length - 1);
List<String> \_split = [];
\_payload.split(",")..forEach((String s) => \_split.addAll(s.split(":")));
Json \_mapped = {};
for (int i = 0; i < \_split.length + 1; i++) {
if (i % 2 == 1) \_mapped.addAll({\_split[i-1].trim().toString(): \_split[i].trim()});
}
return \_mapped;
}

static Future<void> onMessage() async {
FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
if (FCMProvider.\_refreshNotifications != null) await FCMProvider.\_refreshNotifications!(true);
// if this is available when Platform.isIOS, you'll receive the notification twice
if (Platform.isAndroid) {
await FirebaseService.localNotificationsPlugin.show(
0, message.notification!.title,
message.notification!.body,
FirebaseService.platformChannelSpecifics,
payload: message.data.toString(),
);
}
});
}

static Future<void> backgroundHandler(RemoteMessage message) async {

}
}

앱이 화면에 보일 때 onTapNotification 메서드가 실행되며, localNotificationsPlugin.initialize의 onSelectNotification에 콜백 메서드로 설정됩니다. onTapNotification은 message.data.toString()을 페이로드로 받고(페이로드는 문자열로만 넣을 수 있기 때문에) 페이로드를 다시 맵으로 변환합니다.

## 앱이 백그라운드에 있을 때 (Android) 및 앱이 포그라운드 / 백그라운드에 있을 때(iOS)

<div class="content-ad"></div>

첫 번째 페이지에서 initState에 다음 코드를 넣었는데, 안드로이드에서 앱이 백그라운드에 있을 때 작동하는 것으로 보이며, iOS에서는 앱이 포그라운드/백그라운드에 있을 때 작동합니다.

```js
Stream<RemoteMessage> _stream = FirebaseMessaging.onMessageOpenedApp;
_stream.listen((RemoteMessage event) async {
  if (event.data != null) {
    await Navigator.of(context).push(...);
  }
});
```

## 앱이 종료된 경우

앱이 종료된 경우 main.dart의 main 메소드에서 메시지를 받아와야 하며, 다른 곳에서 시도하면 실패할 것입니다. 저는 이 메시지를 첫 번째 페이지로 전달하고, initState에서 적절한 조치를 취했습니다.

<div class="content-ad"></div>

```js
// main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.initializeFirebase();
  final RemoteMessage? _message = await FirebaseService.firebaseMessaging.getInitialMessage();
  runApp(const MyApp(message: _message));
}

// 앱이 켜졌을 때 열리는 첫 번째 페이지
@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    if (this.widget.message != null) {
      Future.delayed(const Duration(milliseconds: 1000), () async {
        await Navigator.of(context).pushNamed(...);
      });
    }
  });
}
```

## Backend

iOS에서 소리가 포함된 알림을 받으려면 Cloud 콘솔에 다음이 필요합니다: (깃헙 참조)

```js
"apns: {
  "payload": {
    "aps": {
      "sound": default
    }
  }
}
```

<div class="content-ad"></div>

도움이 되길 바라요! 즐거운 코딩하세요.
