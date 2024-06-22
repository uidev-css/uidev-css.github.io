---
title: "iOS와 Android에서 QR 코드를 스캔하는 방법 Flutter 사용하기"
description: ""
coverImage: "/assets/img/2024-06-22-ScanningQRCodeinFlutteroniOSandAndroid_0.png"
date: 2024-06-22 15:41
ogImage: 
  url: /assets/img/2024-06-22-ScanningQRCodeinFlutteroniOSandAndroid_0.png
tag: Tech
originalTitle: "Scanning QR Code in Flutter on iOS and Android"
link: "https://medium.com/@rishi_singh/scanning-qr-code-in-flutter-on-ios-and-android-b9caa26c4e74"
---


## 플러터 앱에서 QR 코드 스캔 기능을 구현하는 방법을 배워보세요

![QR 코드 스캔](/assets/img/2024-06-22-ScanningQRCodeinFlutteroniOSandAndroid_0.png)

플러터는 구글의 오픈 소스 UI 툴킷으로, 시각적으로 매력적이고 고성능의 크로스 플랫폼 애플리케이션을 만들 수 있는 능력으로 개발자들 사이에서 엄청난 인기를 얻었습니다. 이 글에서는 플러터에서 QR 코드 스캐너를 구현하는 과정을 자세히 살펴보겠습니다. 이를 통해 앱 사용자들이 자신의 디바이스 카메라를 사용하여 QR 코드를 쉽게 스캔할 수 있게 됩니다.

이 튜토리얼을 완료하면 애플리케이션에 QR 코드 스캔 기능을 통합하는 방법에 대해 확실한 이해를 가지게 될 것입니다.

<div class="content-ad"></div>

시작해 봅시다.

## 1. 프로젝트 설정

먼저 아래 명령어를 사용하여 시작하는 Flutter 프로젝트를 생성해야 합니다. qr_code_scanner를 앱 이름으로 바꿔주세요.

```js
flutter create qr_code_scanner
```

<div class="content-ad"></div>

위 내용은 친절하고 쉬운 어조로 한국어로 번역하면 다음과 같습니다.

당신을 위해 기본 카운터 앱을 만들어 드릴 거에요. 프로젝트 폴더 내에서 다음 명령어를 실행하여 mobile_scanner 플러그인을 프로젝트에 추가해 보세요.

```js
flutter pub add mobile_scanner
```

이제 작동하도록 이를 위해 일부 플랫폼 설정을 해야 합니다.

## - Android

<div class="content-ad"></div>

안녕하세요! 안드로이드 `app` 폴더의 build.gradle 파일로 이동해서 minSdkVersion을 21로 업데이트해주세요.

```js
defaultConfig {
    applicationId "com.example.qr_code_scanner"
    minSdkVersion 21
    targetSdkVersion flutter.targetSdkVersion
    versionCode flutterVersionCode.toInteger()
    versionName flutterVersionName
}
```

## - iOS

ios`Runner` 폴더의 info.plist 파일로 이동해서 아래 두 가지 키를 추가해주세요.

<div class="content-ad"></div>

```yaml
<key>NSCameraUsageDescription</key>
<string>QR 코드 스캐너는 QR 코드를 스캔하기 위해 카메라 액세스가 필요합니다</string>

<key>NSPhotoLibraryUsageDescription</key>
<string>QR 코드 스캐너는 사진 액세스가 필요합니다. 사진 라이브러리에서 QR 코드를 가져오기 위함입니다</string>
```

## 2. 코딩 시작하기

이제 QR 코드 스캐너를 만들 준비가 되었습니다. 아래 코드를 추가해주세요

mobile_scanner를 main.dart 파일에 import 해주세요


<div class="content-ad"></div>

```dart
import 'package:mobile_scanner/mobile_scanner.dart';
```

```dart
// 스캐너 추가하기
MobileScanner(
  onDetect: (capture) {
    final List<Barcode> barcodes = capture.barcodes;
    for (final barcode in barcodes) {
      print(data);
    }
  },
)
```

전체 코드:

```dart
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR 코드 스캐너',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'QR 코드 스캐너'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR 코드 스캐너')),
      body: SizedBox(
        height: 400,
        child: MobileScanner(onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            print(barcode.rawValue ?? "QR 코드에 데이터를 찾을 수 없음");
          }
        }),
      ),
    );
  }
}
```

<div class="content-ad"></div>

그럼 이제 앱에 QR 코드 스캔 기능을 추가했군요.

자세한 내용을 원하시면, 이 프로젝트에 대한 내 Github 저장소를 확인해보세요.

이 글을 통해 얻은 지식으로 플러터 앱에 QR 코드 스캐너를 구현하는 데 잘 대비되셨습니다. 그래서 이제 프로젝트에 이 기능을 통합해보세요. 즐거운 코딩되세요!

이 글을 읽어주셔서 감사합니다 ❤
뭔가 잘못된 점이 있나요? 댓글로 알려주세요. 개선해 드릴게요.

<div class="content-ad"></div>

만약 이 기사가 도움이 되었다면 👏 박수를 치세요!