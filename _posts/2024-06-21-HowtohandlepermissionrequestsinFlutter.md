---
title: "Flutter에서 권한 요청 처리하는 방법"
description: ""
coverImage: "/assets/img/2024-06-21-HowtohandlepermissionrequestsinFlutter_0.png"
date: 2024-06-21 23:39
ogImage: 
  url: /assets/img/2024-06-21-HowtohandlepermissionrequestsinFlutter_0.png
tag: Tech
originalTitle: "How to handle permission requests in Flutter"
link: "https://medium.com/@prashantv03/how-to-handle-permission-requests-in-flutter-617707f4e7a6"
---



![Screenshot](/assets/img/2024-06-21-HowtohandlepermissionrequestsinFlutter_0.png)

Flutter에서 권한 요청 처리하는 방법— 이 강의에서는 Flutter에서 안드로이드와 IOS에서 권한을 요청하고 확인하는 방법을 살펴볼 것입니다.

## 패키지

- 권한 핸들러 (permission_handler)


<div class="content-ad"></div>

## 설치

플러터 패키지를 설치하는 과정은 매우 간단합니다. pubspec.yaml 파일을 열고 해당 패키지를 의존성 블록 섹션에 추가하면 됩니다.

```js
dependencies:
  permission_handler:
```

팁: caret 버전을 사용하여 패키지 버전을 특정 주 버전으로 제한할 수 있습니다. 예를 들어, permission_handler: ^11.0.0는 버전 11로 제한되지만 주 버전 업데이트와 보안 패치를 모두 받게 됩니다.

<div class="content-ad"></div>

## 권한

먼저, 앱이 필요로하는 권한을 결정해야 합니다. 앱은 필요한 권한을 공개적으로 선언해야 합니다. 인터넷과 같은 민감하지 않은 권한은 자동으로 허용됩니다. 그 외의 민감한 권한인 위치, 연락처 등은 사용 전 사용자 승인이 필요합니다.

## iOS 권한

iOS에서는 필요한 권한과 그 이유를 함께 기재하는 정보 속성 목록 파일(info.plist)에 권한을 추가함으로써 이를 처리할 수 있습니다.

<div class="content-ad"></div>

```js
<key>NSPhotoLibraryUsageDescription</key>
<string>이 앱은 사용자 갤러리에 이미지를 저장해야 합니다</string>
```

플러터의 경우, 프로젝트의 루트 디렉토리인 iOS/Runner 폴더의 info.plist에 해당합니다. info.plist에 대해 더 알아보려면 여기를 참고하세요.

모든 권한 목록은 여기에서 찾을 수 있으며 iOS에서 권한을 요청하는 가이드라인은 여기에서 확인할 수 있습니다.

## Android 권한요청

<div class="content-ad"></div>

안드로이드에서는 `uses-permission` 태그를 android manifest에 추가하여 동일한 결과를 얻을 수 있습니다. 이 파일은 android/src/main/AndroidManifest.xml 디렉토리에 있습니다.

```js
<manifest ...>
    <uses-permission android:name="android.permission.SEND_SMS"/>
    <application ...>
        ...
    </application>
</manifest>
```

여기서 안드로이드에서 권한에 대해 더 알아보고 최선의 방법을 알아볼 수 있습니다.

## 권한 요청하기

<div class="content-ad"></div>

사용 권한을 요청하려면 먼저 패키지를 가져와야 합니다:

```js
import 'package:permission_handler/permission_handler.dart';
```

그리고요, 연락처 권한을 요청하려면 다음과 같이 할 수 있어요. 한 번에 필요한 여러 권한을 요청할 수 있는 권한 목록을 전달합니다.

## 사용 방법

<div class="content-ad"></div>

다양한 권한들이 있어요. 권한의 상태를 확인할 수 있는데, 그 상태는 허용됨(granted), 거부됨(denied), 제한(restricted), 영구적으로 거부됨(permanentlyDenied), 제한된(limited), 또는 임시적인(provisional) 상태 중 하나일 거예요.

```js
var status = await Permission.camera.status;
if (status.isDenied) {
  // 아직 권한을 요청하지 않았거나 권한이 이전에 거부되었지만 영구적으로 거부되지는 않았어요.
}

// 권한 상태에 대해 직접 물어볼 수도 있어요.
if (await Permission.location.isRestricted) {
  // OS가 접근을 제한했어요. 예를 들어, 부모용 제어 설정 때문일 수도 있어요.
}
```

요청하려는 권한에 request()를 호출해주세요. 이미 이전에 허용된 경우, 아무 일도 일어나지 않아요.
request()는 권한의 새로운 상태를 반환할 거예요.

```js
if (await Permission.contacts.request().isGranted) {
  // 권한이 이미 허용되었거나 사용자가 방금 허용한 경우일 수 있어요.
}
```

<div class="content-ad"></div>

```js
// 한 번에 여러 권한을 요청할 수 있습니다.
Map<Permission, PermissionStatus> statuses = await [
  Permission.location,
  Permission.storage,
].request();
print(statuses[Permission.location]);
```

일부 권한, 예를 들어 위치나 가속도 센서 권한과 같은 것들은 활성화 또는 비활성화할 수 있는 관련 서비스가 있습니다.

```js
if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
  // 위치 사용
}
```

앱 설정도 열 수 있습니다.

<div class="content-ad"></div>

```js
만약 (await Permission.speech.isPermanentlyDenied) {
  // 사용자가 앱의 이 권한 요청 대화상자를 다시 보지 않기로 선택했습니다.
  // 권한 상태를 변경하는 유일한 방법은 사용자가 시스템 설정에서 직접 활성화하는 것입니다.
  openAppSettings();
}
```

Android에서 권한을 사용하는 근거를 표시할 수 있습니다:

```js
bool isShown = await Permission.contacts.shouldShowRequestRationale;
```

일부 권한은 사용자에게 요청된 권한을 허용하거나 거부할 것을 요청하는 대화상자를 표시하지 않을 수 있습니다.
이는 앱에 대한 OS 설정이 해당 권한에 대한 권한을 나타내는 경우입니다.
설정의 상태가 권한을 허용할지 거부할지를 결정합니다.
