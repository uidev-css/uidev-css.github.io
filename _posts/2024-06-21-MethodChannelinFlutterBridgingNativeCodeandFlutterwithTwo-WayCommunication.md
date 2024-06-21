---
title: "플러터에서 네이티브 코드와의 양방향 통신을 위한 메소드 채널 사용 방법"
description: ""
coverImage: "/assets/img/2024-06-21-MethodChannelinFlutterBridgingNativeCodeandFlutterwithTwo-WayCommunication_0.png"
date: 2024-06-21 22:37
ogImage: 
  url: /assets/img/2024-06-21-MethodChannelinFlutterBridgingNativeCodeandFlutterwithTwo-WayCommunication_0.png
tag: Tech
originalTitle: "Method Channel in Flutter: Bridging Native Code and Flutter with Two-Way Communication"
link: "https://medium.com/@iiharish97ii/method-channel-in-flutter-bridging-native-code-and-flutter-with-two-way-communication-788d1e91c8c1"
---


플러터의 메소드 채널은 플러터와 플랫폼별 코드 간에 원활한 통신을 제공하는 강력한 메커니즘을 제공합니다. 이 블로그 포스트에서는 플러터에서 메소드 채널을 설정하고 네이티브 MainActivity.kt(Android) 및 AppDelegate.swift(iOS) 코드에서 데이터를 플러터 애플리케이션으로 반환하는 과정을 살펴보겠습니다. 함께 알아보겠습니다!

플러터에서 메소드 채널 설정하기: 먼저, 플러터 프로젝트에 메소드 채널을 설정해 봅시다.

- 의존성 추가: 플러터 프로젝트의 pubspec.yaml 파일에 flutter/services 패키지를 의존성으로 추가하세요:

```js
dependencies:
  flutter:
    sdk: flutter
  flutter/services:
    ^2.0.0
```

<div class="content-ad"></div>

- Method Channel 정의하기: 플러터 Dart 코드에서 Method Channel을 정의하세요:

```js
import 'package:flutter/services.dart';

// MethodChannel의 인스턴스 생성
final MethodChannel platformChannel = MethodChannel('your_channel_name');
```

Android에서 Method Channel 통신 구현하기: 이제 Android 플랫폼에서 Method Channel 통신을 구현해 봅시다.

- MainActivity.kt에서 메소드 호출 수신하기: MainActivity.kt 파일에서 onMethodCall 메소드를 오버라이드하여 Flutter로부터의 메소드 호출을 처리하고 데이터를 반환하세요:

<div class="content-ad"></div>

```kotlin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "your_channel_name"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Set up the MethodChannel with the same name as defined in Dart
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getDataFromNative") {
                // Perform platform-specific operations and obtain the result
                val data = getDataFromNative()

                // Send the result back to Flutter
                result.success(data)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getDataFromNative(): String {
        // Perform platform-specific operations to fetch the data
        return "Data from Native"
    }
}
```

iOS에서 Method Channel 통신 구현하기: 이제 iOS 플랫폼에서 메서드 채널 통신을 구현해봅시다.

- AppDelegate.swift에서 메서드 호출 받기: AppDelegate.swift 파일에 아래 코드를 추가하여 Flutter에서의 메서드 호출을 처리하고 데이터를 반환합니다:

```swift
import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    private let CHANNEL = "your_channel_name"

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Set up the MethodChannel with the same name as defined in Dart
        if let flutterViewController = window?.rootViewController as? FlutterViewController {
            let methodChannel = FlutterMethodChannel(name: CHANNEL, binaryMessenger: flutterViewController.binaryMessenger)
            methodChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: FlutterResult) in
                if call.method == "getDataFromNative" {
                    // Perform platform-specific operations and obtain the result
                    let data = self?.getDataFromNative()

                    // Send the result back to Flutter
                    result(data)
                } else {
                    result(FlutterMethodNotImplemented)
                }
            }
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func getDataFromNative() -> String {
        // Perform platform-specific operations to fetch the data
        return "Data from Native"
    }
}
```

<div class="content-ad"></div>

플러터에서 네이티브로 데이터 전달 및 결과 반환하기: 이제 플러터에서 네이티브에 데이터를 전달하고 결과를 다시 플러터에서 받는 방법을 살펴봅시다.

- 플러터에서 메소드 호출: 플러터 Dart 코드에서 플랫폼별 코드에서 메소드를 호출하고 결과를 처리하세요.

```js
void fetchDataFromNative() async {
  try {
    final String result = await platformChannel.invokeMethod('getDataFromNative');
    print('Result from Native: $result');
  } on PlatformException catch (e) {
    print('Error: ${e.message}');
  }
}
```

결론: 축하합니다! 이제 플러터에서 메서드 채널을 성공적으로 설정했습니다. 이를 통해 플러터와 플랫폼별 코드 간의 양방향 통신이 가능해졌습니다. 이 블로그 포스트에서 안내된 단계와 코드 예제를 따라 하시면, 네이티브 기능을 쉽게 통합하고 네이티브 측에서 플러터 응용 프로그램으로 데이터를 반환할 수 있습니다. 실험하고 탐색하며, 메서드 채널의 강력한 기능을 활용하여 플러터 프로젝트의 무한한 가능성을 발견하세요. 즐거운 코딩되세요!