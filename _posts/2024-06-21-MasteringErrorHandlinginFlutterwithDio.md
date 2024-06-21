---
title: "Dio로 Flutter에서 에러 핸들링 마스터하는 방법"
description: ""
coverImage: "/assets/img/2024-06-21-MasteringErrorHandlinginFlutterwithDio_0.png"
date: 2024-06-21 22:06
ogImage: 
  url: /assets/img/2024-06-21-MasteringErrorHandlinginFlutterwithDio_0.png
tag: Tech
originalTitle: "Mastering Error Handling in Flutter with Dio"
link: "https://medium.com/@mohammadjoumani/error-handling-in-flutter-a1dfe81a2e0"
---


에러 처리를 설명하며 예외를 설명하는 가장 좋은 방법

![마스터링 플러터에서 Dio를 사용한 에러 처리](/assets/img/2024-06-21-MasteringErrorHandlinginFlutterwithDio_0.png)

소개:
모바일 앱 개발에서 에러를 우아하게 처리하는 것은 부드럽고 사용자 친화적인 경험을 제공하는 데 중요합니다. 플러터(Flutter)를 사용할 때 Dio는 강력한 HTTP 클라이언트 라이브러리로 네트워크 요청 중 에러를 처리하는 강력한 메커니즘을 제공합니다. 이 글에서는 Dio를 사용하여 플러터에서 에러를 효과적으로 처리하는 방법을 살펴보겠습니다. 이를 통해 앱이 신뢰성 있고 사용자 친화적인 상태를 유지할 수 있습니다.

1. Dio 소개:
Dio는 플러터 애플리케이션에서 HTTP 요청을 간단히 만들어주는 다양한 기능을 제공하는 다재다능한 패키지입니다. 취소, 인터셉터, 요청/응답 변환 및 에러 처리와 같은 기능을 제공합니다. 에러 처리는 네트워크 통신의 중요한 측면으로, 인터넷 연결 없음, 서버 에러 등과 같은 시나리오를 처리하도록 앱을 도와줍니다.

<div class="content-ad"></div>

2. Dio Configuration 및 인스턴스 생성:
에러 처리에 들어가기 전에 Dio 설정을 위해 적절한 구성으로 인스턴스를 만들어보겠습니다. 타임아웃, 기본 URL 및 다른 설정을 정의하여 Dio를 앱에 맞게 사용할 수 있습니다.

3. Interceptors를 사용한 전역 에러 처리:

```js
const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "en";
const String TOKEN = "token";
const String BASE_URL = "https://api.example.com";

class DioFactory {

  Future<Dio> getDio() async {
    Dio dio = Dio();

    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: TOKEN,
      DEFAULT_LANGUAGE: DEFAULT_LANGUAGE
    };

    dio.options = BaseOptions(
        baseUrl: BASE_URL,
        headers: headers,
        receiveTimeout: Constants.apiTimeOut,
        sendTimeout: Constants.apiTimeOut,
    );

    if (!kReleaseMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }

    return dio;
  }
}
```

3. DataSource enum:
다양한 데이터 소스를 정의하는 열거형입니다. 각각이 특정 유형의 실패와 연관되며 오류 유형을 실패 응답과 매핑하는 데 사용됩니다.

```js
enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT
}
```

<div class="content-ad"></div>

4. DataSourceExtension:
이 확장은 DataSource 열거형을 위한 getFailure라는 메서드를 추가합니다. 이 메서드는 열거형의 값에 따라 Failure 객체를 반환합니다.

```js
extension DataSourceExtension on DataSource {
  Failure getFailure() {
    var mContext = navigatorKey!.currentState!.context;
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(ResponseCode.SUCCESS, ResponseMessage.SUCCESS.tr(mContext));
      case DataSource.NO_CONTENT:
        return Failure(ResponseCode.NO_CONTENT, ResponseMessage.NO_CONTENT.tr(mContext));
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST.tr(mContext));
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN.tr(mContext));
      case DataSource.UNAUTORISED:
        return Failure(ResponseCode.UNAUTORISED, ResponseMessage.UNAUTORISED.tr(mContext));
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND.tr(mContext));
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMessage.INTERNAL_SERVER_ERROR.tr(mContext));
      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT.tr(mContext));
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL.tr(mContext));
      case DataSource.RECIEVE_TIMEOUT:
        return Failure(
            ResponseCode.RECIEVE_TIMEOUT, ResponseMessage.RECIEVE_TIMEOUT.tr(mContext));
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT.tr(mContext));
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR.tr(mContext));
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION.tr(mContext));
      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT.tr(mContext));
    }
  }
}
```

5. ResponseCode 클래스:
이 클래스는 표준 HTTP 상태 코드와 로컬 상태 코드에 대한 사용자 지정 상태 코드를 나타내는 정적 정수 상수를 정의합니다.

```js
class ResponseCode {
  static const int SUCCESS = 200; // 성공 및 데이터 포함
  static const int NO_CONTENT = 201; // 성공하지만 데이터가 없음 (내용 없음)
  static const int BAD_REQUEST = 400; // 실패, API가 요청을 거부함
  static const int UNAUTORISED = 401; // 실패, 사용자가 인가되지 않음
  static const int FORBIDDEN = 403; // 실패, API가 요청을 거부함
  static const int INTERNAL_SERVER_ERROR = 500; // 실패, 서버 측에서 오류 발생
  static const int NOT_FOUND = 404; // 실패, 찾을 수 없음

  // 로컬 상태 코드
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}
```

<div class="content-ad"></div>

6. ResponseMessage 클래스:
이 클래스는 다른 HTTP 상태 코드에 대한 응답 메시지를 나타내는 정적 문자열 상수를 정의합니다. 이러한 메시지는 국제화(로컬라이제이션)되어야 합니다.

```js
class ResponseMessage {
  static const String SUCCESS = AppStrings.success; // 데이터가 포함된 성공
  static const String NO_CONTENT = AppStrings.success; // 데이터가 없는 성공 (내용 없음)
  static const String BAD_REQUEST = AppStrings.strBadRequestError; // 실패, API가 요청을 거부함
  static const String UNAUTORISED = AppStrings.strUnauthorizedError; // 실패, 사용자가 권한이 없음
  static const String FORBIDDEN = AppStrings.strForbiddenError; // 실패, API가 요청을 거부함
  static const String INTERNAL_SERVER_ERROR = AppStrings.strInternalServerError; // 실패, 서버 측에서 충돌 발생
  static const String NOT_FOUND = AppStrings.strNotFoundError; // 실패, 서버 측에서 충돌 발생

  // 지역 상태 코드
  static const String CONNECT_TIMEOUT = AppStrings.strTimeoutError;
  static const String CANCEL = AppStrings.strDefaultError;
  static const String RECIEVE_TIMEOUT = AppStrings.strTimeoutError;
  static const String SEND_TIMEOUT = AppStrings.strTimeoutError;
  static const String CACHE_ERROR = AppStrings.strCacheError;
  static const String NO_INTERNET_CONNECTION = AppStrings.strNoInternetError;
  static const String DEFAULT = AppStrings.strDefaultError;
}
```

7. HandleError 함수:
이 비공개 함수는 DioException을 매개변수로 사용하여 Failure 객체를 반환합니다. DioException의 유형에 따라 switch 문을 사용하여 DataSource 열거형에서 정의된 일련의 값에 따라 다른 유형의 DioException을 해당하는 Failure 값으로 매핑합니다.

```js
Failure _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.RECIEVE_TIMEOUT.getFailure();
    case DioExceptionType.badResponse:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return Failure(error.response?.statusCode ?? 0,
            error.response?.statusMessage ?? "");
      } else {
        return DataSource.DEFAULT.getFailure();
      }
    case DioExceptionType.cancel:
      return DataSource.CANCEL.getFailure();
    default:
      return DataSource.DEFAULT.getFailure();
  }
}
```

<div class="content-ad"></div>

7. ErrorHandler 클래스:
이 클래스는 Exception 인터페이스를 구현하며, 예외 처리를 위한 것으로 의도되었음을 나타냅니다.
즉시 초기화되지 않는 타입이 Failure인 late 필드인 failure이 있습니다.
ErrorHandler 클래스에는 동적 오류 매개변수를 사용하는 handle이라는 생성자가 있습니다. 이 생성자는 오류의 타입에 따라 _handleError 함수를 호출하여 다양한 종류의 예외를 처리합니다.
만약 오류가 DioException 타입이라면, _handleError 함수를 호출하여 실패를 결정합니다.
만약 오류가 DioException이 아니라면, DataSource에서 가져온 기본 값으로 실패를 설정합니다.

```js
class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      // dio error so its an error from response of the API or from dio itself
      failure = _handleError(error);
    } else {
      // default error
      failure = DataSource.DEFAULT.getFailure();
    }
  }
}
```

8. 특정 요청에서 오류 처리:
전역 오류 처리가 중요하긴 하지만, 요청마다 오류를 처리할 수도 있습니다. Dio 요청 주변에 try-catch 블록을 사용하여 오류를 캡쳐하고 적절히 응답할 수 있습니다.

```js
Future<Either<Failure, ResponseDto>> getResponse(RequestDto requestDto) async {
    if (await _networkInfo.isConnected) {
      try {
        ...
        .
        .
        return Right(response);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
}
```

<div class="content-ad"></div>

9. 사용자 친화적인 오류 메시지 표시:
긍정적인 사용자 경험을 보장하기 위해 기술적인 오류 메시지를 사용자 친화적인 메시지로 변환하십시오. 오류 코드를 사용자가 어떻게 진행해야 하는지 안내하는 인간이 읽을 수 있는 메시지로 매핑하기 위해 도우미 함수를 사용할 수 있습니다.

```js
///영어 메시지
"success": "성공",
"bad_request_error": "잘못된 요청. 나중에 다시 시도해주세요",
"no_content": "콘텐츠 없이 성공",
"forbidden_error": "금지된 요청. 나중에 다시 시도해주세요",
"unauthorized_error": "사용자 권한이 없습니다. 나중에 다시 시도해주세요",
"not_found_error": "URL을 찾을 수 없습니다. 나중에 다시 시도해주세요",
"conflict_error": "충돌이 발생했습니다. 나중에 다시 시도해주세요",
"internal_server_error": "문제가 발생했습니다. 나중에 다시 시도해주세요",
"unknown_error": "문제가 발생했습니다. 나중에 다시 시도해주세요",
"timeout_error": "시간이 초과되었습니다. 나중에 다시 시도해주세요",
"default_error": "문제가 발생했습니다. 나중에 다시 시도해주세요",
"cache_error": "캐시 오류가 발생했습니다. 나중에 다시 시도해주세요",
"no_internet_error": "인터넷 연결을 확인해주세요"

//아랍어 메시지
"success": "تم بنجاح",
"bad_request_error": "طلب غير صالح. حاول مرة أخرى لاحقًا",
"no_content": "콘텐츠 없이 성공",
"forbidden_error": "طلب محظور. حاول مرة أخرى لاحقًا",
"unauthorized_error": "사용자 권한이 없습니다. 나중에 다시 시도해주세요",
"not_found_error": "URL을 찾을 수 없습니다. 나중에 다시 시도해주세요",
"conflict_error": "충돌이 발생했습니다. 나중에 다시 시도해주세요",
"internal_server_error": "문제가 발생했습니다. 나중에 다시 시도해주세요",
"unknown_error": "문제가 발생했습니다. 나중에 다시 시도해주세요",
"timeout_error": "시간이 초과되었습니다. 나중에 다시 시도해주세요",
"default_error": "문제가 발생했습니다. 나중에 다시 시도해주세요",
"cache_error": "캐시 오류가 발생했습니다. 나중에 다시 시도해주세요",
"no_internet_error": "인터넷 연결을 확인해주세요"
```

10. 결론:
효율적인 오류 처리는 견고하고 신뢰할 수 있는 Flutter 앱을 제공하는 데 중요합니다. Dio의 포괄적인 오류 처리 메커니즘과 사용자 친화적인 오류 메시지는 어려운 네트워크 상황에서도 사용자가 정보를 알 수 있도록 보장합니다. 이러한 전략을 구현하여 앱의 신뢰성을 높이고 전반적인 사용자 경험을 향상시킬 수 있습니다.

# Github 예시