---
title: "GetX로 API 통합하기 Flutter를 이용한 쉬운 방법"
description: ""
coverImage: "/assets/img/2024-06-22-APIIntegrationusingGetXinflutter_0.png"
date: 2024-06-22 04:13
ogImage:
  url: /assets/img/2024-06-22-APIIntegrationusingGetXinflutter_0.png
tag: Tech
originalTitle: "API Integration using GetX in flutter"
link: "https://medium.com/@sanjaysharmajw/api-integration-using-getx-in-flutter-0337243b5cc0"
---

![APIIntegrationusingGetXinflutter](/assets/img/2024-06-22-APIIntegrationusingGetXinflutter_0.png)

플러터에서 API 통합은 앱과 외부 서비스 간의 데이터 통신을 활성화하여 동적이고 실시간이며 확장 가능한 기능을 제공하고 서로 다른 플랫폼 간에 일관된 경험을 제공하는 데 중요합니다.

API 통합은 플러터 애플리케이션이 외부 서비스와 상호 작용하고 데이터를 검색하고 다양한 기능을 수행할 수 있도록 가능하게 합니다. 다음은 플러터 개발에서 API 통합이 중요하게 간주되는 몇 가지 이유입니다:

- 데이터 검색: 대부분의 애플리케이션은 데이터베이스, 서버 또는 제3자 서비스와 같은 외부 소스에서 데이터를 필요로합니다. API 통합을 통해 플러터 앱이 이러한 데이터를 동적으로 가져와 표시하므로 사용자가 항상 최신 정보에 액세스할 수 있습니다.
- 실시간 업데이트: API를 사용하면 클라이언트(플러터 앱)와 서버 간의 실시간 통신이 가능해집니다. 이는 메시징 앱, 협업 도구 또는 실시간 데이터 피드와 같은 실시간 업데이트가 필요한 애플리케이션에 중요합니다.
- 오프라인 지원: API는 장치에 로컬로 정보를 캐싱하여 오프라인 데이터 액세스를 지원할 수 있도록 설계될 수 있습니다. 이는 일시적이거나 인터넷 연결이 없는 환경에서 기능해야 하는 애플리케이션에 중요합니다.
- 보안: API는 종종 인증 메커니즘을 통합하여 특정 데이터에만 인가된 사용자만이 액세스하거나 특정 작업을 수행할 수 있도록합니다. 이는 응용프로그램 및 데이터의 보안 유지에 도움이 됩니다.

<div class="content-ad"></div>

## Android Studio에 JsonToDart 플러그인 설치하기

플러그인: [JsonToDart](https://plugins.jetbrains.com/plugin/12562-jsontodart-json-to-dart-)

## HTTP 패키지 추가하기

HTTP 요청을 하기 위해 pubspec.yaml 파일에 http 패키지를 추가하고 flutter pub get을 실행하세요.

<div class="content-ad"></div>

## Getx 패키지 추가하기

GetX는 플러터를 위한 가벼우면서 강력한 솔루션입니다. 높은 성능의 상태 관리, 지능적인 의존성 주입, 빠르고 실용적인 라우트 관리를 결합하고 있습니다. GetX를 사용하려면 flutter pub add get 명령어를 실행하세요.

## main.dart 파일에 GetMaterialApp 추가하기

```js
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Get 패키지 가져오기
import 'UserListScreens.dart'; // 화면 파일 import하기

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primary: Colors.deepPurple), // 주요 색상 deepPurple로 설정
        useMaterial3: false,
      ),
      home: const UserListScreen(), // 처음 화면으로 UserListScreen 표시
    );
  }
}
```

<div class="content-ad"></div>

## APIConstant 클래스 생성

```js
import 'dart:io';

class APIConstant {

  static const url = 'https://reqres.in/api/users?page=2';

  static Map<String, String> authHeader = {
    HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
  };

}
```

## UserModels 클래스 생성

```js
class UserModels {
  UserModels({
    num? page,
    num? perPage,
    num? total,
    num? totalPages,
    List<Data>? data,
    Support? support,
  }) {
    _page = page;
    _perPage = perPage;
    _total = total;
    _totalPages = totalPages;
    _data = data;
    _support = support;
  }

  UserModels.fromJson(dynamic json) {
    _page = json['page'];
    _perPage = json['per_page'];
    _total = json['total'];
    _totalPages = json['total_pages'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _support = json['support'] != null ? Support.fromJson(json['support']) : null;
  }

  num? _page;
  num? _perPage;
  num? _total;
  num? _totalPages;
  List<Data>? _data;
  Support? _support;

  UserModels copyWith({
    num? page,
    num? perPage,
    num? total,
    num? totalPages,
    List<Data>? data,
    Support? support,
  }) => UserModels(
    page: page ?? _page,
    perPage: perPage ?? _perPage,
    total: total ?? _total,
    totalPages: totalPages ?? _totalPages,
    data: data ?? _data,
    support: support ?? _support,
  );

  num? get page => _page;
  num? get perPage => _perPage;
  num? get total => _total;
  num? get totalPages => _totalPages;
  List<Data>? get data => _data;
  Support? get support => _support;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = _page;
    map['per_page'] = _perPage;
    map['total'] = _total;
    map['total_pages'] = _totalPages;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    if (_support != null) {
      map['support'] = _support?.toJson();
    }
    return map;
  }

}

class Support {
  Support({
    String? url,
    String? text,
  }) {
    _url = url;
    _text = text;
  }

  Support.fromJson(dynamic json) {
    _url = json['url'];
    _text = json['text'];
  }

  String? _url;
  String? _text;

  Support copyWith({
    String? url,
    String? text,
  }) => Support(
    url: url ?? _url,
    text: text ?? _text,
  );

  String? get url => _url;
  String? get text => _text;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['text'] = _text;
    return map;
  }

}

class Data {
  Data({
    num? id,
    String? email,
    String? firstName,
    String? lastName,
    String? avatar,
  }) {
    _id = id;
    _email = email;
    _firstName = firstName;
    _lastName = lastName;
    _avatar = avatar;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _email = json['email'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _avatar = json['avatar'];
  }

  num? _id;
  String? _email;
  String? _firstName;
  String? _lastName;
  String? _avatar;

  Data copyWith({
    num? id,
    String? email,
    String? firstName,
    String? lastName,
    String? avatar,
  }) => Data(
    id: id ?? _id,
    email: email ?? _email,
    firstName: firstName ?? _firstName,
    lastName: lastName ?? _lastName,
    avatar: avatar ?? _avatar,
  );

  num? get id => _id;
  String? get email => _email;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get avatar => _avatar;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email'] = _email;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['avatar'] = _avatar;
    return map;
  }

}
```

<div class="content-ad"></div>

## UserListController 클래스 생성 및 GetxController를 상속받도록 클래스 확장

```js
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:post_project/Models/UserModels.dart';
import '../APIConstant.dart';

class UserListController extends GetxController implements GetxService {

  var isLoading = true.obs;
  var getUserList = <Data>[].obs;

  @override
  void onInit() {
    super.onInit();
    userList();
  }

  Future<dynamic> userList() async {
    try {
      final response = await http.get(
        Uri.parse(APIConstant.url),
        headers: APIConstant.authHeader,
      );
      debugPrint("UserList");
      debugPrint(response.body);
      const utf8Decoder = Utf8Decoder(allowMalformed: true);
      final decodedBytes = utf8Decoder.convert(response.bodyBytes);
      Map<String, dynamic> responseBody = json.decode(decodedBytes);
      if (response.statusCode == 200) {
        isLoading.value = false;
        UserModels model = UserModels.fromJson(responseBody);
        getUserList.value = model.data!;
      }
    } on TimeoutException catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    } on SocketException catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    } on Error catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

}
```

## listView를 위한 UserItems 위젯 작성

```js
import 'package:flutter/material.dart';
import 'package:post_project/Models/UserModels.dart';

class UserItems extends StatelessWidget {

  final Data data;
  const UserItems({Key key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Row(
          children: [
            SizedBox(
              height: 100,
              width: 70,
              child: Image.network(
                data.avatar.toString(),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${data.firstName} ${data.lastName}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5),
                  Text(data.email.toString()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
```

<div class="content-ad"></div>

## 이렇게 GetxController를 호출하세요

```js
final userListController = Get.put(UserListController(), permanent: true);
```

## UserListScreen 클래스를 생성하세요

전체 코드:

<div class="content-ad"></div>

```js
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:post_project/Controller/UserListController.dart';
import 'package:post_project/UserItems.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {

  final userListController = Get.put(UserListController(),permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.green,
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        titleSpacing: 5,
        centerTitle: false,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        title: const Text("User List",
            style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w600)),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return userListController.getUserList.isEmpty
                  ? const Center(
                      child: Text("data"),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: userListController.getUserList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return UserItems(
                            data: userListController.getUserList[index]);
                      });
            }),
          )
        ],
      ),
    );
  }
}
```

## 스크린샷:

<img src="/assets/img/2024-06-22-APIIntegrationusingGetXinflutter_1.png" />

## 소스 코드:

<div class="content-ad"></div>

GitHub 링크: [https://github.com/sanjaysharmajw/UserList](https://github.com/sanjaysharmajw/UserList)

## 저와 소통해요:

- LinkedIn: [https://www.linkedin.com/in/sanjaydeveloper/](https://www.linkedin.com/in/sanjaydeveloper/)
- Instagram: [https://www.instagram.com/sanjayjw/](https://www.instagram.com/sanjayjw/)

![이미지](/assets/img/2024-06-22-APIIntegrationusingGetXinflutter_2.png)

<div class="content-ad"></div>

이 기사를 즐겨 보셨기를 바라요! 제공된 정보를 감사하게 생각하신다면, 'Buy Me A Coffee'로 저를 지원할 수 있어요! 여러분의 작은 선행에 감사하겠습니다!
