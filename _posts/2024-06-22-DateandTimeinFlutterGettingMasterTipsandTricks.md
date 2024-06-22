---
title: "Flutter에서 날짜와 시간 다루기  전문가 되는 팁과 트릭"
description: ""
coverImage: "/assets/img/2024-06-22-DateandTimeinFlutterGettingMasterTipsandTricks_0.png"
date: 2024-06-22 15:40
ogImage: 
  url: /assets/img/2024-06-22-DateandTimeinFlutterGettingMasterTipsandTricks_0.png
tag: Tech
originalTitle: "Date and Time in Flutter | Getting Master ~ Tips and Tricks"
link: "https://medium.com/@fakgun/date-and-time-in-flutter-getting-master-tips-and-tricks-7d5667aee966"
---


<img src="/assets/img/2024-06-22-DateandTimeinFlutterGettingMasterTipsandTricks_0.png" />

개발자로서, 우리는 종종 강력하고 사용자 친화적인 플러터 애플리케이션을 구축하는 데 중요한 날짜와 시간 조작이 필요한 시나리오에 직면합니다. 날짜를 표시 형식에 맞게 형식화하거나 시간 차이를 계산하거나 시간대를 통합하는 것 모두 날짜와 시간 조작을 숙달하는 데 중요합니다. 이 기사에서는 플러터에서 날짜와 시간 작업의 세계로 뛰어들어, 여러분에게 필요한 지식과 실용적인 팁을 제공하여 날짜와 시간을 효과적으로 처리할 수 있도록 돕겠습니다. DateTime 클래스 이해부터 타임스탬프 저장을 위해 Firebase를 활용하는 방법까지, 이 포괄적인 안내서는 여러분이 앱의 기능을 강화하고 매끄러운 사용자 경험을 제공할 수 있도록 도와줄 것입니다.

<img src="/assets/img/2024-06-22-DateandTimeinFlutterGettingMasterTipsandTricks_1.png" />

- 플러터에서 날짜와 시간 객체 이해
- 날짜와 시간 형식 지정
- 시간 차이와 기간 계산
- 시간대 작업
- 고급 날짜 및 시간 작업
- 효율적인 날짜 및 시간 조작 기술
- 날짜와 시간 저장을 위해 Firebase 통합
- 날짜와 시간 조작을 위한 최선의 방법

<div class="content-ad"></div>

## 플러터에서의 날짜 및 시간 개념 이해

플러터에서는 DateTime 클래스를 사용하여 날짜와 시간을 나타냅니다. 이 클래스는 날짜와 시간 값을 조작하고 처리하기 위한 다양한 속성과 메소드를 제공합니다. 이해해야 할 중요한 개념은 다음과 같습니다:

```dart
DateTime now = DateTime.now();
int year = now.year;
int month = now.month;
int day = now.day;
int hour = now.hour;
int minute = now.minute;
int second = now.second;
```

## 날짜와 시간 형식 지정

<div class="content-ad"></div>

intl: Flutter에서는 국제화 및 로컬라이제이션을 위해 일반적으로 intl 패키지를 사용하지만, 고급 날짜 및 시간 포맷팅을 위한 DateFormat 클래스도 제공됩니다. 다양한 형식 패턴을 제공하여 다른 지역 설정에 따라 날짜와 시간을 표시할 수 있습니다.

날짜 및 시간 객체 포맷팅:

```js
import 'package:intl/intl.dart';

DateTime now = DateTime.now();
String formattedDate = DateFormat('MMMM dd, yyyy').format(now);
print(formattedDate);  // 예시 출력: "7월 03, 2023"
int month = now.month; // 월이 정수 값으로 표시되는 것을 전제로
print(month); // 결과: 7
String monthName = DateFormat('MMMM').format(DateTime(currentYear, month));
print(monthName); // 결과: "7월"
```

로케일 지정하여 날짜 및 시간 객체 포맷팅하기:

<div class="content-ad"></div>

```dart
import 'package:intl/intl.dart';

DateTime now = DateTime.now();
int currentYear = DateTime.now().year;
String formattedDate = DateFormat('d MMMM yyyy', 'fr_FR').format(now);
print(formattedDate);  // Example output: "3 juillet 2023"
```

여기서는 DateFormat의 두 번째 인수로 로캘 `fr_FR`을 전달하여 프랑스어로 날짜를 형식화합니다. 이렇게 하면 결과로 나오는 형식화된 날짜 문자열이 프랑스 로캘 규칙을 따릅니다.

이 원활한 코드 예제들은 Flutter에서 intl 패키지를 사용하여 DateTime 객체를 형식화하는 방법을 보여줍니다. 다양한 형식 패턴과 로캘을 지정하여 Flutter 애플리케이션에서 로컬화된 및 사용자 정의된 날짜 및 시간 표현을 생성할 수 있습니다.

## 시간 차이와 기간 계산하기


<div class="content-ad"></div>

플러터에서는 두 개의 DateTime 객체 간의 차이를 계산하고 Duration 클래스를 사용하여 기간을 다룰 수 있습니다. 다음은 중요한 개념과 부드러운 코드 예제입니다:

```js
DateTime firstDate = DateTime(2023, 7, 1);
DateTime secondDate = DateTime(2023, 7, 5);

Duration difference = secondDate.difference(firstDate);
print(difference.inDays); // 출력: 4
```

이 예제에서는 서로 다른 날짜를 나타내는 두 DateTime 객체인 firstDate와 secondDate가 있습니다. 두 번째 날짜에 difference 메서드를 호출하고 첫 번째 날짜를 인수로 전달하여 두 날짜 간의 차이를 나타내는 Duration 객체를 얻습니다. 이 경우, 차이는 4일입니다.

기간을 다루는 방법:

<div class="content-ad"></div>

```js
Duration duration = Duration(hours: 2, minutes: 30, seconds: 45);

print(duration.inHours);   // 출력: 2
print(duration.inMinutes); // 출력: 150
print(duration.inSeconds); // 출력: 9045

// Duration을 문자열로 포맷팅:
Duration duration = Duration(hours: 2, minutes: 30);

String formattedDuration = '${duration.inHours}시간 ${duration.inMinutes.remainder(60)}분';
print(formattedDuration); // 출력: "2시간 30분"
```

여기서는 "X시간 Y분" 형식의 문자열 표현으로 기간을 포맷팅합니다 (예: "2시간 30분"). inHours 및 inMinutes 속성을 결합하고 나머지 메서드를 사용하여 시간을 뺀 후 남은 분을 가져와서 원하는 포맷팅된 기간 문자열을 만듭니다.

이 원활한 코드 예제는 DateTime 객체 사이의 시간 차이를 계산하고 Flutter에서 기간을 사용하는 방법을 보여줍니다. 날짜 간 차이를 결정하거나 디스플레이를 위해 기간을 포맷하는 경우 Duration 클래스는 Flutter 애플리케이션 내에서 시간과 관련된 작업을 처리하는 데 필요한 도구를 제공합니다.

## 타임존 사용하기

<div class="content-ad"></div>

플러터에서는 intl 패키지와 DateTime 클래스를 사용하여 시간대를 처리할 수 있어요. 여기 몇 가지 주요 개념과 부드러운 코드 예시가 있습니다.

특정 시간대로 DateTime 변환하기:

```js
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

DateTime dateTime = DateTime.now();
String timezone = 'America/New_York';

tz.TZDateTime convertedDateTime =
    tz.TZDateTime.from(dateTime, tz.getLocation(timezone));

print(convertedDateTime); // 출력: 2023-07-03 09:30:00.000 EDT
```

다른 시간대에서 DateTime 표시하기:

<div class="content-ad"></div>

```Dart
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

DateTime dateTime = DateTime.now();
String timezone = 'Asia/Tokyo';

tz.TZDateTime convertedDateTime =
    tz.TZDateTime.from(dateTime, tz.getLocation(timezone));

String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm').format(convertedDateTime);

print(formattedDateTime); // 출력: 2023-07-04 01:30
```

이 부드러운 코드 예제들은 플러터에서 시간대를 다루는 방법을 보여줍니다. 형식 지정에는 intl 패키지를 사용하고 시간대 처리에는 timezone 패키지를 활용하여 Flutter 애플리케이션에서 다른 시간대의 DateTime 객체를 정확하게 변환하고 표시할 수 있습니다.

## 고급 날짜 및 시간 연산

<div class="content-ad"></div>

```js
DateTime now = DateTime.now();
DateTime newDateTime = now.add(Duration(days: 7, hours: 3));

print(newDateTime); // 출력: 2023-07-10 12:30:00.000
```

특정 구성 요소 추출:

```js
DateTime now = DateTime.now();
int year = now.year;
int month = now.month;
int day = now.day;
int hour = now.hour;
int minute = now.minute;
int second = now.second;

print('$year-$month-$day $hour:$minute:$second'); // 예시 출력: "2023-7-3 10:15:30"
```

윤년 확인:  

<div class="content-ad"></div>

```js
int year = 2024;
bool isLeapYear = DateTime(year).isLeapYear;

print(isLeapYear); // Output: true
```

## 효율적인 날짜 및 시간 조작 기술

비교를 위해 UTC 사용:

```js
DateTime now = DateTime.now();
DateTime futureDate = now.add(Duration(days: 7));

bool isFuture = futureDate.isAfter(now);
print(isFuture); // Output: true
```

<div class="content-ad"></div>

중복으로 파싱하고 형식을 변경하지 마십시오:

```js
String formattedDate = '2023-07-03';
DateTime parsedDate = DateTime.parse(formattedDate);

String reFormattedDate = parsedDate.toIso8601String();
print(reFormattedDate); // 출력: 2023-07-03T00:00:00.000
```

캐시된 인스턴스 활용하기:

```js
DateTime now = DateTime.now();
DateTime cachedNow = now;

// 캐시된 인스턴스를 사용하여 여러 작업 수행
DateTime futureDate = cachedNow.add(Duration(days: 7));
bool isFuture = futureDate.isAfter(cachedNow);

print(isFuture); // 출력: true
```

<div class="content-ad"></div>

## Firebase를 사용하여 날짜와 시간 저장하기

Firebase는 Firestore와 같은 실시간 데이터베이스를 제공하는 인기 있는 백엔드 플랫폼입니다. Flutter 애플리케이션에서 다른 데이터와 함께 날짜와 시간을 저장하기 위해 Firebase Firestore를 활용할 수 있습니다. Firebase를 사용하여 날짜와 시간을 저장하는 방법은 다음과 같습니다:

Firestore에 날짜와 시간 저장하기:

```dart
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

void saveDateTime() {
  DateTime now = DateTime.now();

  firestore.collection('your_collection').add({
    'timestamp': now,
  });
}
```

<div class="content-ad"></div>

파이어스토어로부터 날짜와 시간 얻기:

```dart
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

void retrieveDateTime() async {
  DocumentSnapshot documentSnapshot = await firestore
      .collection('your_collection')
      .doc('your_document_id')
      .get();

  DateTime timestamp = documentSnapshot['timestamp'].toDate();

  print(timestamp); // 출력: 2023-07-03 10:30:45.000
}
```

플러터 앱에 Firebase Firestore를 통합하면 다른 데이터와 함께 날짜와 시간을 저장하고 검색할 수 있습니다. 이를 통해 Firebase의 실시간 능력을 활용한 효율적이고 원활한 데이터 관리가 가능해집니다.

## 날짜와 시간 조작을 위한 모범 사례

<div class="content-ad"></div>

Flutter에서 날짜와 시간을 다룰 때는 코드 가독성, 유지 보수성 및 정확성을 보장하기 위해 최상의 사례를 따르는 것이 중요합니다. 다음은 주요 사례와 부드러운 코드 예제입니다:

기술적인 변수 이름 사용하기:

```js
DateTime currentDate = DateTime.now();
int selectedYear = 2023;
int selectedMonth = 7;
int selectedDay = 3;
```

currentDate, selectedYear, selectedMonth 및 selectedDay와 같은 기술적 변수 이름은 코드의 가독성과 이해를 높입니다. 이러한 이름은 명확한 문맥을 제공하며 각 변수의 목적을 이해하기 쉽게 만듭니다.

<div class="content-ad"></div>

에지 케이스 다루기:

```js
DateTime date = DateTime(2023, 2, 30);

if (date.month == DateTime.february && date.day > 28) {
  // 잘못된 날짜 처리
}
```

2월 30일과 같은 유효하지 않은 날짜와 같은 예외 사례에 주의하십시오. 해당 사례를 처리하면 예기치 않은 동작이나 오류를 방지할 수 있습니다. 이 예에서는 월이 2월인지(DateTime.february) 확인하고 날짜가 28을 초과하는지 검사하여 유효하지 않은 날짜 시나리오에 대응합니다.

시간대 변환을 고려해 보세요.

<div class="content-ad"></div>

```js
DateTime utcDateTime = DateTime.now().toUtc();
DateTime localDateTime = utcDateTime.toLocal();
```

시간대를 다룰 때는 UTC (협정 세계 표준시)와 지역 시간 간의 변환에 주의해야 합니다. DateTime 객체를 UTC로 변환하려면 toUtc() 메서드를 사용하고, 다시 지역 시간대로 변환하려면 toLocal()을 사용하세요.

따라오느라 감사합니다. 아래 댓글에 생각을 자유롭게 남겨주세요.

트위터에서 저를 팔로우해주세요.


<div class="content-ad"></div>

만나서 반가워요!