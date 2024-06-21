---
title: "Flutter에서 리프레시 토큰 사용하는 방법 모바일"
description: ""
coverImage: "/assets/img/2024-06-21-FlutterRefreshtokenmobileside_0.png"
date: 2024-06-21 23:50
ogImage: 
  url: /assets/img/2024-06-21-FlutterRefreshtokenmobileside_0.png
tag: Tech
originalTitle: "Flutter Refresh token (mobile side)"
link: "https://medium.com/@mohammadjoumani/flutter-refresh-token-mobile-side-0eb890a4bfa7"
---


플러터에서 Dio를 사용하여 토큰을 새로 고치는 방법

![image](/assets/img/2024-06-21-FlutterRefreshtokenmobileside_0.png)

현대 모바일 애플리케이션에서는 사용자 인증 세션을 원활하게 유지하는 것이 사용자 경험에 매우 중요합니다. 인증을 관리하는 효과적인 방법 중 하나는 리프레시 토큰을 사용하는 것입니다. 이 기사에서는 Dio를 사용하여 플러터 애플리케이션에서 리프레시 토큰을 처리하는 방법에 대해 살펴보겠습니다.

토큰이란 무엇인가요?
토큰은 토큰 기반 인증에서 애플리케이션이 API에 액세스할 수 있도록 허용하는 데 사용됩니다. 사용자가 성공적으로 인증하고 액세스 권한을 부여한 후 애플리케이션은 액세스 토큰을 받아들이고 대상 API를 호출할 때 자격 증명으로서 액세스 토큰을 전달합니다. 전달된 토큰은 API에게 전달된 토큰의 소유자가 API에 액세스할 권한이 있으며 승인 중에 부여된 범위에 따라 특정 조치를 수행할 수 있음을 알립니다.

<div class="content-ad"></div>

리프레시 토큰이 무엇인가요?
리프레시 토큰은 사용자가 다시 인증을 받지 않고 새로운 엑세스 토큰을 얻는 메커니즘입니다. 일반적으로 엑세스 토큰은 보안상의 이유로 수명이 짧지만, 리프레시 토큰은 더 오래 지속됩니다. 엑세스 토큰이 만료되면 리프레시 토큰을 사용하여 새로운 엑세스 토큰을 얻을 수 있어 사용자의 세션을 중단시키지 않고 유지할 수 있습니다.

단계별로 리프레시 토큰 구현하기

Dio의 인스턴스를 구성하고 초기화하는 'DioFactory' 클래스를 만드세요.

```js
class DioFactory {

  Future<Dio> getDio() async {
    Dio dio = Dio();

    Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,
    };

    dio.options = BaseOptions(
      baseUrl: ConstantsApi.baseUrl,
      headers: headers,
      receiveTimeout: const Duration(milliseconds: Constants.apiTimeOut),
      sendTimeout: const Duration(milliseconds: Constants.apiTimeOut),
      connectTimeout: const Duration(milliseconds: Constants.apiTimeOut),
    );

    if (!kReleaseMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          error: true,
        ),
      );
    }

    return dio;
  }
}
```

<div class="content-ad"></div>

ApiService 클래스는 Dio를 사용하여 API 요청을 처리하고 인증 토큰을 관리하기 위해 설계된 포괄적인 서비스 레이어입니다. 이 클래스와 기능에 대한 자세한 설명을 제공합니다.

01- 클래스 선언 및 필드
“_dio1”과 “_dio2”는 "Dio"의 인스턴스입니다. “_dio1”은 일반 API 요청에 사용되고, “_dio2”는 토큰 갱신 요청에 사용됩니다.

```js
class ApiService {
  final Dio _dio1;
  final Dio _dio2;
  final AppPreferences _appPref;

  ApiService(
    this._dio1,
    this._dio2,
    this._appPref,
  ) {
    _dio1.interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequest,
        onError: _onError,
      ),
    );
  }
}
```

02- 인터셉터

<div class="content-ad"></div>

생성자는 요청 및 오류 처리를 처리하기 위해 "dio"에 인터셉터를 추가합니다.

오류 인터셉터:
이 메서드는 오류를 처리합니다. 특히, 오류가 401 Unauthorized인 경우 토큰을 새로 고치려고 시도합니다.

```js
_onError(DioException e, ErrorInterceptorHandler handler) async {
  if(e.response?.statusCode == 401) {
    _refreshToken(e, handler);
  } else {
    handler.next(e);
  }
}
```

03- 토큰 새로고침 로직
" _refreshToken "메서드는 새 액세스 토큰을 받아오기 위해 리프레시 토큰을 사용하려고 시도합니다.

<div class="content-ad"></div>

- 성공하면 저장된 토큰을 업데이트하고 원래 요청을 다시 시도합니다.
- 새로 고침이 실패하는 경우 (특히 새로 고침 토큰도 잘못된 경우), 사용자를 로그아웃 처리하고 오류를 거절합니다.

```js
  Future<void> _refreshToken(DioException e, ErrorInterceptorHandler handler) async {
    try {
      final refreshToken = _appPref.getRefreshToken();
      final response = await _dio2.post(
        ConstantsApi.refreshTokenUrl,
        data: {'refreshToken': refreshToken},
      );
      _appPref.setToken(response.data['accessToken']);
      _appPref.setRefreshToken(response.data['refreshToken']);
      handler.resolve(await _dio1.fetch(e.requestOptions));
    } catch (error) {
      if (error is DioException) {
        if (error.response?.statusCode == 401) {
          _logout();
          handler.reject(e);
        } else {
          handler.next(error);
        }
      } else {
        handler.next(e);
      }
    }
  }
```

위 단계를 따라 하면 Dio를 사용하여 Flutter 애플리케이션에서 새로 고침 토큰을 처리할 수 있어서 사용자가 원할한 경험을 얻을 수 있습니다. 이 방법은 Dio 인스턴스의 구성을 중앙 집중화하고 토큰을 효율적으로 관리하는 데 도움이 됩니다.