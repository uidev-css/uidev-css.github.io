---
title: "flutter_background_service로 플러터 앱의 백그라운드 서비스 구현 방법"
description: ""
coverImage: "/assets/img/2024-06-21-ElevateYourFlutterAppwithBackgroundServicesusingflutter_background_service_0.png"
date: 2024-06-21 23:09
ogImage:
  url: /assets/img/2024-06-21-ElevateYourFlutterAppwithBackgroundServicesusingflutter_background_service_0.png
tag: Tech
originalTitle: "Elevate Your Flutter App with Background Services using flutter_background_service"
link: "https://medium.com/@hasibulhasan3590/elevate-your-flutter-app-with-background-services-using-flutter-background-service-131f4ba7ec8a"
---

플러터 애플리케이션을 개발할 때는 데이터 가져오기, 업데이트 처리, 또는 알림 처리와 같이 백그라운드에서 작업을 수행해야 하는 시나리오를 자주 마주하게 됩니다. 백그라운드 서비스를 효과적으로 관리하는 강력한 솔루션으로는 flutter_background_service 플러그인이 있습니다. 이 글에서는 해당 기능을 활용하고 Android 및 iOS 플랫폼에서 백그라운드 서비스를 초기화하고 구성하는 세부 사항을 살펴보겠습니다.

# 소개:

플러터에는 백그라운드 서비스용 다양한 플러그인과 패키지가 있으며 각각의 장점이 있습니다. flutter_background_service는 간편성과 사용 편의성으로 눈에 띕니다. 플러그인을 초기화하여 시작해 봅시다:

<div class="content-ad"></div>

```js
final service = FlutterBackgroundService();
```

코드 가독성을 높이기 위해 초기화 과정을 함수 내에 캡슐화하는 것이 좋습니다. initializeBackgroundService()라는 함수를 만들어보겠습니다:

```js
void initializeBackgroundService() async {
 try {
 // 백그라운드 서비스 초기화
 await service.initialize(onDataReceived: onDataReceivedFromBackground);
// iOS에 필요한 설정 수행
 configureIOSBackgroundService();
// 백그라운드 서비스 시작
 service.start(onStart: () {
 print('백그라운드 서비스 시작됨');
 }, onBackgroundTask: (String data) {
 // 여기에 백그라운드 작업 코드를 작성하세요
 print('백그라운드 작업이 데이터와 함께 시작됨: $data');
 service.sendData('백그라운드 작업 완료됨');
 });
 } catch (e) {
 print('백그라운드 서비스 초기화 오류: $e');
 }
}
```

# iOS 구성 :

<div class="content-ad"></div>

백그라운드 서비스의 한 가지 주목할만한 측면은 플랫폼별 구성에 관한 것입니다. Android는 일반적으로 추가 권한이 필요하지 않지만, iOS는 특정 설정이 필요할 수 있습니다. iOS 구성을 위한 플레이스홀더 함수를 여기에 제공합니다:

```js
void configureIOSBackgroundService() {
 // iOS에 특정 구성이 필요한 경우 수행
 // (예: 권한 요청, 백그라운드 모드 설정 등)
 // 이는 추가 플러그인 또는 네이티브 코드 사용이 포함될 수 있습니다.
}
```

# 네이티브 측면에서 서비스 호출하기:

전경 및 배경에서 네이티브 측면의 서비스를 활용하기 위해 제공된 함수를 사용할 수 있습니다. 서비스를 호출하는 방법을 보여주는 코드 조각을 여기에 제공합니다:

<div class="content-ad"></div>

```js
// 화면용 서비스 호출
service.invokeForegroundService();
// 배경용 서비스 호출
service.invokeBackgroundService();
// 서비스 중지
service.stopService();
```

이 호출을 귀하의 특정 요구 사항에 맞게 조정해 주세요.

# 백그라운드 작업: 날짜 및 시간 업데이트:

이제 우리의 주요 작업인 백그라운드에서 매 10초마다 날짜 및 시간 업데이트에 대해 다루어 보겠습니다. 이를 위해 타이머를 사용하겠습니다.

<div class="content-ad"></div>

```js
// onStart 함수 내부에서
Timer.periodic(const Duration(seconds: 10), (timer) async {
  if (service is AndroidServiceInstance) {
    service.setForegroundNotificationInfo(
      title: "백그라운드 앱...",
      content: "${DateTime.now()} 업데이트",
    );
  }
  service.invoke(
    'update',
    {
      "current_date": DateTime.now().toIso8601String(),
    },
  );
});
```

이 코드 조각은 10초마다 작업을 트리거하는 타이머를 설정합니다. 이 작업은 DateTime을 업데이트하고 백그라운드 서비스에 알립니다. 필요에 따라 특정 사용 사례에 맞게 이 로직을 사용자 정의할 수 있습니다.

# 백그라운드 서비스 활용:

이제 백그라운드 서비스를 초기화했으니, 플러터 앱에서 이를 활용해보세요. 실제 구현 세부 정보로 플레이스홀더를 교체해야 합니다. 플러그인은 onDataReceived 리스너를 제공하여 백그라운드로부터 수신된 데이터를 처리할 수 있습니다.

<div class="content-ad"></div>

```js
service.onDataReceived.listen((event) {
  print('백그라운드 데이터 수신됨: $event');
});
```

앱이 dispose될 때 백그라운드 서비스를 중지하는 것을 잊지 마세요:

```js
@override
void dispose() {
  service.stop();
  super.dispose();
}
```

# 마무리:

<div class="content-ad"></div>

flutter_background_service을 사용하면 Flutter에서 백그라운드 작업을 처리하는 것이 매끄럽게 이루어집니다. onStart 함수를 이해하고 DartPluginRegistrant를 초기화하며 네이티브 측에서 서비스를 호출함으로써 Flutter 앱의 기능을 향상시킬 수 있습니다. 특히, 타이머 기반 작업을 탐구한 것은 백그라운드 서비스에 동적인 요소를 추가하여 앱이 백그라운드에 있을 때도 주기적인 업데이트를 가능케 합니다.

flutter_background_service와 백그라운드 서비스의 힘을 받아 Flutter 앱의 성능과 사용자 경험을 향상시켜 보세요.

코딩 즐기세요!
