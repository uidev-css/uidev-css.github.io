---
title: "외부 패키지 없이 Flutter에서 Google Autocomplete Places API 통합하기 종합 가이드"
description: ""
coverImage: "/assets/img/2024-06-21-IntegratingGoogleAutocompletePlacesAPIinFlutterWithoutExternalPackagesAComprehensiveGuide_0.png"
date: 2024-06-21 20:41
ogImage:
  url: /assets/img/2024-06-21-IntegratingGoogleAutocompletePlacesAPIinFlutterWithoutExternalPackagesAComprehensiveGuide_0.png
tag: Tech
originalTitle: "Integrating Google Autocomplete Places API in Flutter Without External Packages: A Comprehensive Guide"
link: "https://medium.com/@axiftaj/integrating-google-autocomplete-places-api-in-flutter-without-external-packages-a-comprehensive-a86f37aa8b90"
---

![image](/assets/img/2024-06-21-IntegratingGoogleAutocompletePlacesAPIinFlutterWithoutExternalPackagesAComprehensiveGuide_0.png)

소스 코드: [https://github.com/axiftaj/Flutter-Google-Map-Tutorials/tree/main](https://github.com/axiftaj/Flutter-Google-Map-Tutorials/tree/main)

Google Autocomplete Places API는 위치 제안 및 예측을 심층적으로 통합할 수 있는 강력한 솔루션을 제공합니다. 이 기능을 통합하는 데 사용할 수 있는 패키지는 있지만 기본 API 호출을 이해하면 개발자가 더 많은 제어와 사용자 정의 기능을 갖게 됩니다. 이 안내서에서는 외부 패키지에 의존하지 않고 Flutter에서 Google Autocomplete Places API를 직접 구현하는 과정을 탐색해 보겠습니다.

필수 사항: 계속하기 전에 다음 사전 요구 사항이 충족되었는지 확인하세요:

<div class="content-ad"></div>

- 플러터 SDK가 설치되어 있어야 합니다
- 안드로이드 스튜디오 또는 VS CODE
- 결제가 활성화된 Google Cloud Platform (GCP) 계정 및 Places API가 활성화되어 있어야 합니다

단계 1: Google Cloud Platform 프로젝트 설정

- Google Cloud Platform 콘솔로 이동: https://console.cloud.google.com/
- 스크린샷에 표시된 대로 새 프로젝트를 만들거나 기존 프로젝트를 선택하세요

![image](/assets/img/2024-06-21-IntegratingGoogleAutocompletePlacesAPIinFlutterWithoutExternalPackagesAComprehensiveGuide_1.png)

<div class="content-ad"></div>

3. 프로젝트용 Google Places API를 활성화하세요. API 라이브러리로 이동하여 "Places API"를 검색하고 활성화하세요.

왼쪽 상단 모서리에 있는 햄버거 아이콘을 클릭하고 API 및 서비스 라이브러리를 선택한 후, 우측 하단 구석에 있는 Place API를 클릭하세요.

![이미지](/assets/img/2024-06-21-IntegratingGoogleAutocompletePlacesAPIinFlutterWithoutExternalPackagesAComprehensiveGuide_2.png)

활성화될 때와 같이 보일 것입니다.

<div class="content-ad"></div>

<img src="/assets/img/2024-06-21-IntegratingGoogleAutocompletePlacesAPIinFlutterWithoutExternalPackagesAComprehensiveGuide_3.png" />

4. “Credentials” 탭으로 이동하여 API 자격 증명을 생성하세요. “Create Credentials”를 선택하고 “API Key”를 선택한 후 지침에 따라 API 키를 생성하세요.

상단 좌측 구석의 햄버거 아이콘을 클릭한 후 API 및 서비스 “Credentials”를 선택하고 CREATE CREDENTIALS를 클릭한 후 API Key를 선택하세요. 이렇게 하면 API 키가 생성되며, 이를 다른 사람과 공유하지 마세요.

<img src="/assets/img/2024-06-21-IntegratingGoogleAutocompletePlacesAPIinFlutterWithoutExternalPackagesAComprehensiveGuide_4.png" />

<div class="content-ad"></div>

## 플러터 프로젝트를 생성하고 다음 패키지들을 추가해봐요

```js
uuid: ^4.3.3
http:
```

uuid 패키지는 세션을 관리하는 데 사용될 거에요(세션이 무엇인지는 마지막에 설명할게요)

코드 설명:

<div class="content-ad"></div>

먼저 사용자로부터 입력을 받기 위해 Text Field를 사용하는 컨트롤러를 만들었습니다. 그리고 uuid 인스턴스를 초기화하였는데, 이는 새로운 세션을 생성하는 데 도움이 됩니다. 그리고 initState() 메서드에서는 컨트롤러의 변경사항을 감지하고 사용자가 무언가를 입력할 때 getSuggestion(\_controller.text) 함수를 호출합니다.

\_placeList에는 API 호출이 성공했을 때 화면에 자동완성 추천을 저장합니다.

```js
final _controller = TextEditingController();
var uuid = const Uuid();
String _sessionToken = '1234567890';
List<dynamic> _placeList = [];

@override
void initState() {
  super.initState();
  _controller.addListener(() {
    _onChanged();
  });
}

_onChanged() {
  if (_sessionToken == null) {
    setState(() {
      _sessionToken = uuid.v4();
    });
  }
  getSuggestion(_controller.text);
}
```

<div class="content-ad"></div>

이 함수에서는 http 패키지를 사용하여 입력 요청을 Google 서버로 보냅니다. 성공적으로 처리되면 해당 데이터를 배열에 저장하고 화면을 새로 고침하여 보여줍니다.

API 키는 안전한 저장소에 보관하거나 다른 좋은 방법을 따라 오용되지 않도록 합니다.

```js
void getSuggestion(String input) async {


  const String PLACES_API_KEY = "";

  try{
    String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&key=$PLACES_API_KEY&sessiontoken=$_sessionToken';
    var response = await http.get(Uri.parse(request));
    var data = json.decode(response.body);
    if (kDebugMode) {
      print('mydata');
      print(data);
    }
    if (response.statusCode == 200) {
      setState(() {
        _placeList = json.decode(response.body)['predictions'];
      });
    } else {
      throw Exception('Failed to load predictions');
    }
  }catch(e){
    print(e);
  }

}
```

전체 소스 코드:

<div class="content-ad"></div>

```js
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GoogleMapSearchPlacesApi extends StatefulWidget {
  const GoogleMapSearchPlacesApi({Key? key}) : super(key: key);


  @override
  _GoogleMapSearchPlacesApiState createState() => _GoogleMapSearchPlacesApiState();
}

class _GoogleMapSearchPlacesApiState extends State<GoogleMapSearchPlacesApi> {


  final _controller =  TextEditingController();
  var uuid =  const Uuid();
  String _sessionToken = '1234567890';
  List<dynamic> _placeList = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _onChanged();
    });
  }

  _onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {


    const String PLACES_API_KEY = "your api key";

    try{
      String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request = '$baseURL?input=$input&key=$PLACES_API_KEY&sessiontoken=$_sessionToken';
      var response = await http.get(Uri.parse(request));
      var data = json.decode(response.body);
      if (kDebugMode) {
        print('mydata');
        print(data);
      }
      if (response.statusCode == 200) {
        setState(() {
          _placeList = json.decode(response.body)['predictions'];
        });
      } else {
        throw Exception('Failed to load predictions');
      }
    }catch(e){
      print(e);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Search places Api' ,),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Search your location here",
                focusColor: Colors.white,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                prefixIcon: const Icon(Icons.map),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.cancel), onPressed: () {
                  _controller.clear() ;
                },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _placeList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {

                  },
                  child: ListTile(
                    title: Text(_placeList[index]["description"]),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
 }
```

세션 토큰에 대해 자세히 알아보고 사용한 이유에 대해 이해하십시오.

감사합니다. 여러분이 무언가 좋은 것을 배웠기를 바랍니다.

이 블로그가 도움이 되었다면 좋아요와 공유를 부탁드립니다.
