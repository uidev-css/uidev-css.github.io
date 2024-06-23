---
title: "Flutter GetX 상태 관리 쉽게 이해하기"
description: ""
coverImage: "/assets/img/2024-06-23-FlutterGetXStateManagement_0.png"
date: 2024-06-23 14:58
ogImage: 
  url: /assets/img/2024-06-23-FlutterGetXStateManagement_0.png
tag: Tech
originalTitle: "Flutter GetX State Management"
link: "https://medium.com/@anugrahdwi1005/flutter-getx-state-management-9c7731b46628"
---



<img src="/assets/img/2024-06-23-FlutterGetXStateManagement_0.png" />

GetX는 가벼우면서 뛰어난 성능을 제공하는 Flutter 패키지입니다. 상태 관리에 국한되지 않고 네비게이션, 의존성 주입 및 국제화 기능도 포함하고 있어 Flutter 개발자를 위한 다목적 도구상자입니다. GetX는 그 간결함, 성능 및 다양한 기능으로 알려져 있습니다. Flutter 개발에서 일반적인 작업을 위한 추가적인 유틸리티와 함께 가벼우면서 반응적인 상태 관리 솔루션을 선호하는 개발자들에게 적합한 선택입니다. 이 패키지의 유연성과 사용 편의성은 Flutter 커뮤니티 내에서 인기를 끌고 있습니다.

## GetX 상태 관리의 주요 기능:

<img src="/assets/img/2024-06-23-FlutterGetXStateManagement_1.png" />


<div class="content-ad"></div>

Reactive State Management:

```js
final count = 0.obs;

// In the UI:
Obx(() => Text('Count: ${controller.count}'));
```

의존성 주입:

```js
Get.lazyPut<MyService>(() => MyService());
```

<div class="content-ad"></div>

경로 관리:

```js
Get.toNamed('/next');
```

스낵바 및 대화상자:

```js
Get.snackbar('제목', '이것은 스낵바입니다');
```

<div class="content-ad"></div>

StateMixin:

```js
class MyController extends GetxController with StateMixin<String> {
  @override
  void onInit() {
    super.onInit();
    change('Initial Data', status: RxStatus.success());
  }
}
```

GetX Service:

```js
class MyService extends GetxService {
  // ...
}
```

<div class="content-ad"></div>

국제화 (i18n):

```js
'hello'.tr;
```

GetX 빌더:

```js
GetBuilder<MyController>(
builder: (_) {
return Text('Value: ${_.myValue}');
},
)
```

<div class="content-ad"></div>

# GetX 설정하기

GetX를 Flutter 프로젝트에서 사용하려면, 다음 종속성을 `pubspec.yaml` 파일에 추가해주세요:

```yaml
dependencies:
  get: ^4.6.6
```

get install | Flutter 패키지 (pub.dev)

<div class="content-ad"></div>

# GetX를 사용한 간단한 카운터 예제

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class CounterController extends GetxController {
  // observable 변수 선언 (RxInt)
  RxInt count = 0.obs;

  // 카운터 증가 함수
  void increment() {
    count++;
  }
}

class MyApp extends StatelessWidget {
  // 카운터 컨트롤러 인스턴스화
  final CounterController controller = CounterController();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GetX 카운터 앱',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('GetX 카운터 앱'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Obx 위젯은 observable 변수의 변경 사항을 감지
              Obx(() => Text(
                '카운트: ${controller.count}',
                style: TextStyle(fontSize: 24),
              )),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // 버튼을 눌렀을 때 increment 함수 호출
                  controller.increment();
                },
                child: Text('증가'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```