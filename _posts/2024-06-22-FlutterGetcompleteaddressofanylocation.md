---
title: "Flutter 모든 위치의 전체 주소를 가져오는 방법"
description: ""
coverImage: "/assets/img/2024-06-22-FlutterGetcompleteaddressofanylocation_0.png"
date: 2024-06-22 04:06
ogImage: 
  url: /assets/img/2024-06-22-FlutterGetcompleteaddressofanylocation_0.png
tag: Tech
originalTitle: "(Flutter) Get complete address of any location"
link: "https://medium.com/@krishnabhdas3/flutter-get-complete-address-of-any-location-f22c12057824"
---


<img src="/assets/img/2024-06-22-FlutterGetcompleteaddressofanylocation_0.png" />

어떤 위치든 위도와 경도를 사용하여 완전한 주소(우편 번호 포함)를 쉽게 얻을 수 있습니다.

예를 들어:

이렇게 하는 법을 알아보겠습니다 ......

<div class="content-ad"></div>

🌞 먼저 아래 종속성을 pubspec.yaml 파일에 추가해주세요

```js
geocoding: ^2.1.1
```

🌞 그 후에 .dart 파일에서 종속성을 import해주세요

```js
import 'package:geocoding/geocoding.dart';
```

<div class="content-ad"></div>

🌞 이제 Lat, Long을 입력으로 받아 주소를 문자열로 반환하는 getPlacemark라는 간단한 함수를 만들어 보겠습니다.

함수를 비동기로 정의하고, 전체 내용을 try-catch로 감싸서 예외를 처리할 겁니다.

🌞 그래서 try 블록 안에서 placemarkFromCoordinates 작업을 사용하여 위도와 경도를 전달하여 플레이스마크를 가져올 것입니다. 다음과 같이:

```js
List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
```

<div class="content-ad"></div>

이 장소 표시는 위치의 모든 세부 정보를 포함하고 있어요.

그들을 추출하고 정리하기 위해 장소 표시를 반전하고 마지막 인덱스에 액세스할 수 있어요:

```js
String address = "";
address += '${placemarks.reversed.last.subLocality ?? ''}';
```

위와 같이 주소에 액세스하고 문자열에 추가할 수 있어요. 이때 널 체크를 수행하여, 위도와 경도에 어떠한 값도 포함되지 않을 경우 (즉, 널 값 반환) 대비가 되도록 해요.

<div class="content-ad"></div>

🌞 이제 Lat Long의 거리 주소를 얻는 방법은 다음 코드를 사용할 수 있습니다. 주소의 부분에 액세스하고 정리하여 정리된 거리 주소를 얻는 코드를 포함하고 있습니다:

```js
String address = "";

// 거리 주소 문자열 가져오기
var streets = placemarks.reversed
    .map((placemark) => placemark.street)
    .where((street) => street != null);

// 불필요한 부분 필터링
streets = streets.where((street) =>
    street!.toLowerCase() !=
    placemarks.reversed.last.locality!
        .toLowerCase()); // 도시 이름 제거
streets =
    streets.where((street) => !street!.contains('+')); // 코드 제거

address += streets.join(', ');
```

이 부분은 거리 주소를 가져와 도시 이름 등을 제거하여, 도시 이름에 개별적으로 액세스할 수 있도록 구체적으로 만듭니다.

🌞 아래 제공된 완전한 코드를 살펴보세요:

<div class="content-ad"></div>

```dart
import 'package:geocoding/geocoding.dart';

Future<String> getPlacemarks(double lat, double long) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);

    var address = '';

    if (placemarks.isNotEmpty) {

      // Address components without null values are concatenated
      var streets = placemarks.reversed
          .map((placemark) => placemark.street)
          .where((street) => street != null);

      // Unwanted parts are filtered out
      streets = streets.where((street) =>
          street!.toLowerCase() !=
          placemarks.reversed.last.locality!
              .toLowerCase()); // Remove city names
      streets =
          streets.where((street) => !street!.contains('+')); // Remove street codes

      address += streets.join(', ');

      address += ', ${placemarks.reversed.last.subLocality ?? ''}';
      address += ', ${placemarks.reversed.last.locality ?? ''}';
      address += ', ${placemarks.reversed.last.subAdministrativeArea ?? ''}';
      address += ', ${placemarks.reversed.last.administrativeArea ?? ''}';
      address += ', ${placemarks.reversed.last.postalCode ?? ''}';
      address += ', ${placemarks.reversed.last.country ?? ''}';
    }

    print("Your Address for ($lat, $long) is: $address");

    return address;
  } catch (e) {
    print("Error getting placemarks: $e");
    return "No Address";
  }
}
```

🧑🏿‍💻 Follow for more such blogs ☺️….
