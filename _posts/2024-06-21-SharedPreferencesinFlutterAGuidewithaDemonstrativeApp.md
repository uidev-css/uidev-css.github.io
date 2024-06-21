---
title: "Flutter에서 Shared Preferences 사용하기 데모 앱과 함께하는 가이드"
description: ""
coverImage: "/assets/img/2024-06-21-SharedPreferencesinFlutterAGuidewithaDemonstrativeApp_0.png"
date: 2024-06-21 20:38
ogImage: 
  url: /assets/img/2024-06-21-SharedPreferencesinFlutterAGuidewithaDemonstrativeApp_0.png
tag: Tech
originalTitle: "Shared Preferences in Flutter: A Guide with a Demonstrative App"
link: "https://medium.com/@ndubuisiaso/shared-preferences-in-flutter-a-guide-with-a-demonstrative-app-e03582ccce9a"
---


![image](/assets/img/2024-06-21-SharedPreferencesinFlutterAGuidewithaDemonstrativeApp_0.png)

모바일 앱 개발에서의 공유 환경은 사용자 기기에 키-값 쌍의 작은 데이터를 저장할 수 있게 해주는데요. 이 데이터는 영구적이며 앱이 종료된 후에도 접근할 수 있습니다. Flutter에서는 shared_preferences 패키지를 사용하여 공유 환경을 쉽게 관리할 수 있어요.

이 글에서는 Flutter에서의 공유 환경 기본을 살펴보고, 사용 방법을 보여줄 간단한 앱을 만들어볼 거에요.

shared_preferences 시작하기

<div class="content-ad"></div>

"shared_preferences" 패키지를 쉽게 추가할 수 있습니다. Flutter 프로젝트에 다음 줄을 pubspec.yaml 파일에 추가하세요:

```yaml
dependencies:
  shared_preferences: ^0.5.12+4
```

의존성을 추가했으면 Dart 파일에서 가져와 초기화할 수 있습니다:

```dart
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences prefs;

// 공유 설정 초기화
prefs = await SharedPreferences.getInstance();
```

<div class="content-ad"></div>

이제 공유 설정을 초기화했으니, 공유 설정에서 데이터를 저장하고 검색하는 방법을 알아보겠습니다.

공유 설정에 데이터 저장

공유 설정에 데이터를 저장하는 것은 간단하며 아래와 같이 수행할 수 있습니다:

```js
// 문자열 값을 저장
prefs.setString('키', '값');

// 정수 값을 저장
prefs.setInt('키', 42);

// 실수 값을 저장
prefs.setDouble('키', 3.14);

// 부울 값을 저장
prefs.setBool('키', true);
```

<div class="content-ad"></div>

공유 프리퍼런스에서 데이터를 검색하는 것은 데이터를 저장하는 것만큼 쉽습니다:

```js
// 문자열 값 검색
String stringValue = prefs.getString('key');

// 정수 값 검색
int intValue = prefs.getInt('key');

// 배정밀도 부동 소수점 값 검색
double doubleValue = prefs.getDouble('key');

// 부울 값 검색
bool boolValue = prefs.getBool('key');
```

시연용 앱

<div class="content-ad"></div>

이번에는 Flutter에서의 공유 환경 설정(shared preferences)의 기본적인 이해를 한 것 같네요. 이제 이를 활용한 간단한 앱을 만들어보겠습니다.

이 앱에서는 사용자 이름을 입력하는 TextField와 사용자 이름을 기억할지 여부를 나타내는 SwitchListTile이 있습니다. 스위치가 켜져 있고(true), "저장" 버튼이 눌리면 입력된 사용자 이름과 스위치 상태가 공유 환경 설정에 저장됩니다. 앱을 다음에 열면, 이전에 저장된 값이 공유 환경 설정에서 로드되어 Text에 표시되며, Switch는 여전히 true로 설정될 것입니다.

다음은 우리의 데모 앱 코드입니다:

```js
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // 공유 환경 설정 데이터를 저장하는 변수들
  String _username;
  bool _rememberMe;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  // 공유 환경 설정 데이터를 로드하는 메서드
  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? '';
      _rememberMe = prefs.getBool('rememberMe') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Shared Preferences Demo'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter your username',
                ),
                onChanged: (value) {
                  setState(() {
                    _username = value;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Remember me'),
                value: _rememberMe,
                onChanged: (value) {
                  setState(() {
                    _rememberMe = value;
                  });
                },
              ),
              RaisedButton(
                child: Text('Save'),
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setString('username', _username);
                  prefs.setBool('rememberMe', _rememberMe);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

<div class="content-ad"></div>

테이블 태그를 마크다운 형식으로 변경하세요.

<div class="content-ad"></div>

다음 앱에서 사용하시고 로컬 저장소의 아름다움을 즐기세요!!!

만약 유용하다고 느끼신다면, 좋아요를 남겨주세요

소스 코드: github