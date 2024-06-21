---
title: "Flutter  Firebase로 푸시 알림 구현하는 완벽 가이드"
description: ""
coverImage: "/assets/img/2024-06-21-FlutterFirebasePushNotificationsCompleteGuide_0.png"
date: 2024-06-21 21:01
ogImage: 
  url: /assets/img/2024-06-21-FlutterFirebasePushNotificationsCompleteGuide_0.png
tag: Tech
originalTitle: "Flutter + Firebase Push Notifications (Complete Guide)"
link: "https://medium.com/@ChanakaDev/flutter-firebase-push-notifications-complete-guide-fae42c88f32a"
---


<img src="/assets/img/2024-06-21-FlutterFirebasePushNotificationsCompleteGuide_0.png" />

# 푸시 알림이란 무엇인가요?

푸시 알림은 모바일 앱이나 웹사이트에서 기기로 보내는 메시지로, 기기가 활발하게 사용되지 않는 경우에도 전송됩니다. 일반적으로 사용자에게 새로운 콘텐츠나 기능을 알리거나 관심이 있을 수 있는 내용을 상기시키기 위해 사용됩니다.

# 모바일 앱 개발에서 푸시 알림의 장점은 무엇인가요?

<div class="content-ad"></div>

- 사용자 참여 향상: 푸시 알림을 통해 사용자가 앱에 계속해서 참여하도록 유도할 수 있습니다. 사용자가 앱을 활발하게 사용하지 않을 때에도 이를 통해 전반적인 앱 사용량과 인기를 증가시킬 수 있습니다.
- 유지율 증가: 푸시 알림을 통해 사용자에게 앱을 상기시킬 수 있어, 유지율을 높이고 앱을 제거하는 사용자 수를 줄일 수 있습니다.
- 타겟팅 메시징: 푸시 알림은 사용자의 관심사나 행동을 기반으로 특정 사용자나 그룹을 대상으로 할 수 있습니다. 이를 통해 앱 개발자는 사용자에게 개인화되고 관련성 높은 메시지를 보낼 수 있어 알림의 효과를 높일 수 있습니다.
- 수익 증대: 푸시 알림을 통해 인앱 구매나 기타 수익화 기회를 홍보할 수 있어, 앱 개발자의 수익을 향상시킬 수 있습니다.
- 고객 서비스 향상: 푸시 알림을 통해 업데이트나 경고와 같은 시기적절하고 관련성 있는 정보를 제공할 수 있습니다. 이를 통해 전반적인 고객 경험과 앱에 대한 만족도를 향상시킬 수 있습니다.

# Firebase Cloud Messaging (FCM)이란?

![이미지](/assets/img/2024-06-21-FlutterFirebasePushNotificationsCompleteGuide_1.png)

Firebase에 따르면, FCM은 무료로 메시지를 신뢰할 수 있게 전송할 수 있는 크로스 플랫폼 메시징 솔루션이라고 합니다.

<div class="content-ad"></div>

FCM은 Android, iOS 및 웹 사용자에게 메시지와 알림을 보낼 수 있는 크로스 플랫폼 메시징 솔루션입니다. 구글은 FCM을 Firebase 스위트의 일부로 제공하여 모바일 앱 개발을 위한 도구 및 서비스를 제공합니다.

FCM을 사용하면 사용자 관심사, 앱 사용 방식 및 위치에 따라 특정 기기 또는 기기 그룹에 메시지를 보낼 수 있습니다. 알림, 푸시 알림 및 데이터 페이로드를 포함한 다양한 유형의 메시지를 보낼 수 있습니다. FCM은 또한 메시지 예약, 기기 그룹 관리 및 분석과 같은 기능을 제공합니다.

FCM은 기존 앱 인프라와 쉽게 통합되고 사용하기 쉽게 설계되었습니다. 간단한 API를 사용하며 Firebase Analytics와 같은 다른 Firebase 서비스와 통합하여 모바일 앱 개발을 위한 포괄적인 도구 세트를 제공합니다.

# 플러터 앱에서 Firebase FCM을 통해 푸시 알림을 수신하는 방법 — 구현

<div class="content-ad"></div>


![이미지](/assets/img/2024-06-21-FlutterFirebasePushNotificationsCompleteGuide_2.png)

플러터와 FCM에서 3가지 디바이스 상태

- Foreground(전경): 어플리케이션이 열려 있고 보여지며 사용 중일 때입니다.
- Background(최소화): 사용자가 장치에서 "홈" 버튼을 누르거나 앱 전환기를 통해 다른 앱으로 전환하거나 다른 탭(웹)에서 앱을 열었을 때 보통 발생합니다.
- Terminated(종료됨): 장치가 잠겨 있거나 어플리케이션이 실행되지 않을 때입니다. 사용자는 장치의 앱 전환기 UI를 통해 앱을 닫거나 탭(웹)을 닫아 어플리케이션을 종료할 수 있습니다.

이 프로세스가 어떻게 작동하는지 보려면 이 동영상을 시청해보세요.


<div class="content-ad"></div>

구현 단계

- CMD에서

- Node.js를 다운로드 및 설치하십시오. https://nodejs.org/en/
- firebase 도구 설치: npm install -g firebase-tools (CMD)
- "firebase login"을 실행하고 Google 계정을 선택하십시오 (CMD)

2. 플러터 프로젝트 터미널에서

<div class="content-ad"></div>

- 그런 다음 플러터 프로젝트를 열고 터미널에서 다음 명령을 실행하세요
- dart pub global activate flutterfire_cli
- flutterfire configure (만약 이 명령이 "flutterfire가 인식되지 않습니다."와 같은 오류를 발생시킨다면, 시스템 환경 변수에 "C:\Users\*사용자명*\AppData\Local\Pub\Cache\bin"을 새 항목으로 추가해야 합니다. 이제 오류 없이 명령을 실행할 수 있어야 합니다.) 

3. Firebase 콘솔에서

- 새 Firebase 프로젝트를 생성하고 Firebase FCM(메시징/클라우드 메시징으로도 알려짐)를 활성화하세요.

4. 그런 다음 플러터 프로젝트의 main.dart에 다음 종속성을 추가하세요.

<div class="content-ad"></div>

```js
// 의존성
import 'package:firebase_core/firebase_core.dart';
import '/firebase_options.dart'; // 이 파일은 "flutterfire config" 명령어로 생성됩니다.
import 'package:firebase_messaging/firebase_messaging.dart';
```

5. 이제 main.dart에 다음 라인을 추가하여 Firebase Messaging을 초기화합니다.

```js
// 초기화
WidgetsFlutterBinding.ensureInitialized();

await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);

FirebaseMessaging messaging = FirebaseMessaging.instance;

NotificationSettings settings = await messaging.requestPermission(
  alert: true,
  announcement: false,
  badge: true,
  carPlay: false,
  criticalAlert: false,
  provisional: false,
  sound: true,
);

print('사용자가 허용한 권한: ${settings.authorizationStatus}');
```

6. 이제 main.dart에 다음 라인을 추가하여 "백그라운드 메시지"를 받습니다.


<div class="content-ad"></div>

```dart
// 백그라운드 메시지 수신
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("백그라운드 메시지 처리 중: ${message.messageId}");
}
```

```dart
// 백그라운드 메시지 수신 대기
WidgetsFlutterBinding.ensureInitialized();
FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
```

7. 그런 다음 main.dart에 다음 줄을 추가하여 "전경 메시지"를 받습니다.

```dart
// 전경 메시지 수신
FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  print('전경에서 메시지를 받았어요!');
  print('메시지 데이터: ${message.data}');

  if (message.notification != null) {
    print('메시지에 알림도 포함되어 있어요: ${message.notification}');
  }
});
```

<div class="content-ad"></div>

# 중요

- (공통):
- 클라우드 메시징 패키지는 애플리케이션을 Firebase Cloud Messaging (FCM) 서비스에 연결합니다.
- 메시지 페이로드를 무료로 디바이스로 직접 보낼 수 있습니다.
- 각 메시지 페이로드는 최대 4KB까지 가능합니다.
- (iOS 전용):
- iOS 플랫폼에서 Firebase 메시징을 테스트하려면 실제 디바이스가 필요합니다.

# 받을 수 있는 3가지 메시지 유형

메시지 페이로드를 세 가지 유형 중 하나로 볼 수 있습니다.

<div class="content-ad"></div>

- 알림 전용 메시지: 페이로드에는 사용자에게 표시되는 알림 속성이 포함되어 있습니다.
- 데이터 전용 메시지: "silent message"로도 알려진 이 페이로드에는 데이터 속성 내에 사용자가 필요에 따라 사용할 수 있는 사용자 정의 키/값 쌍이 포함되어 있습니다. 이러한 메시지는 "우선 순위가 낮음"으로 간주됩니다(나중에 더 자세히 설명합니다).
- 알림 및 데이터 메시지: 알림 및 데이터 속성을 모두 포함하는 페이로드입니다.

# 상호 작용 처리

알림은 사용자에게 보이는 신호이므로 사용자가 해당 신호에 상호 작용하는 것이 일반적입니다(눌러서). Android 및 iOS 모두의 기본 동작은 애플리케이션을 열도록 하는 것입니다. 애플리케이션이 종료된 경우 시작되고, 백그라운드 상태인 경우 화면으로 가져옵니다.

알림의 내용에 따라 애플리케이션이 열릴 때 사용자 상호 작용을 처리하고 싶을 수 있습니다. 예를 들어, 알림을 통해 새로운 채팅 메시지가 전송되고 사용자가 그것을 누른 경우, 애플리케이션이 열릴 때 특정 대화를 열도록 하고 싶을 수 있습니다.

<div class="content-ad"></div>

firebase-messaging 패키지는 이 상호작용을 다루는 두 가지 방법을 제공합니다:

- getInitialMessage(): 애플리케이션이 종료된 상태에서 열리면 RemoteMessage가 포함된 Future가 반환됩니다. RemoteMessage를 사용하면 해당 메시지는 제거됩니다.
- onMessageOpenedApp: 백그라운드 상태에서 애플리케이션이 열릴 때 RemoteMessage를 게시하는 Stream입니다.

사용자에 대한 원활한 사용자 경험을 위해 두 시나리오를 모두 처리하는 것이 좋습니다. 아래의 코드 예시는 이를 어떻게 달성할 수 있는지 보여줍니다:

```js
class Application extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Application();
}

class _Application extends State<Application> {
  // 모든 메시지에 'type' 키를 포함하는 데이터 필드가 있다고 가정합니다.
  Future<void> setupInteractedMessage() async {
    // 애플리케이션이 종료된 상태에서 열린 이유가 된 메시지를 가져옵니다.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // 메시지가 'type'이 'chat'인 데이터 속성도 포함하고 있다면
    // 채팅 화면으로 이동합니다.
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // 애플리케이션이 백그라운드에 있을 때 상호작용을 다루기 위해 
    // Stream 리스너를 통해 처리합니다.
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }
  
  void _handleMessage(RemoteMessage message) {
    if (message.data['type'] == 'chat') {
      Navigator.pushNamed(context, '/chat', 
        arguments: ChatArguments(message),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    // initState()이 비동기일 수 없기 때문에 상호작용하는 메시지를 다루는 
    // 코드를 비동기 함수에서 실행합니다.
    setupInteractedMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Text("...");
  }
}
```

<div class="content-ad"></div>

# 특정 화면으로 이동하는 방법

```js
void _handleMessage(RemoteMessage message) {
    // 메시지 객체 내용 확인
    RemoteNotification? notification = message.notification;
    //AndroidNotification? android = message.notification?.android;

    print("notification: $notification");
    print("message data: ${message.data}");

    Get.toNamed(Routes.getNotificationDetailScreen(), arguments: [
      {"message": message}
    ]);
}

// 상호 작용 처리
FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
```

![이미지 1](/assets/img/2024-06-21-FlutterFirebasePushNotificationsCompleteGuide_3.png)

![이미지 2](/assets/img/2024-06-21-FlutterFirebasePushNotificationsCompleteGuide_4.png)

<div class="content-ad"></div>

## 참고 자료:

- https://www.youtube.com/watch?v=3lsP1jZNqjE
- https://stackoverflow.com/questions/70320263/the-term-flutterfire-is-not-recognized-as-the-name-of-a-cmdlet-function-scri
- https://firebase.flutter.dev/docs/cli/
- https://firebase.google.com/docs/cli#install-cli-windows
- https://firebase.flutter.dev/docs/overview/
- https://medium.com/@rysesoft/flutter-push-notification-with-fcm-6e7a95f5abb6
- https://firebase.flutter.dev/docs/messaging/apple-integration/
- https://www.youtube.com/watch?v=54vgoPgB8xE
- https://pub.dev/packages/flutterfire_cli/install
- https://pub.dev/packages/firebase_core/install
- https://www.youtube.com/watch?v=2tjuUwNx6qk
- https://firebase.flutter.dev/docs/messaging/usage/
- https://medium.com/firebase-developers/flutter-fcm-how-to-navigate-to-a-particular-screen-after-tapping-on-push-notification-8cb5d5111ee6
- https://pub.dev/packages/flutter_local_notifications
- https://firebase.flutter.dev/docs/messaging/usage/
- https://pub.dev/documentation/firebase_messaging_platform_interface/latest/firebase_messaging_platform_interface/RemoteMessage-class.html
- https://firebase.google.com/docs/cloud-messaging/flutter/receive