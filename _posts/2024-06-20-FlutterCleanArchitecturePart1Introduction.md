---
title: "Flutter의 Clean Architecture 파트1 - 소개"
description: ""
coverImage: "/assets/img/2024-06-20-FlutterCleanArchitecturePart1Introduction_0.png"
date: 2024-06-20 13:46
ogImage: 
  url: /assets/img/2024-06-20-FlutterCleanArchitecturePart1Introduction_0.png
tag: Tech
originalTitle: "Flutter Clean Architecture Part 1 — Introduction"
link: "https://medium.com/@enesakbal00/flutter-clean-architecture-part-1-introduction-f5dadf1bf3ee"
---


```markdown
![image](/assets/img/2024-06-20-FlutterCleanArchitecturePart1Introduction_0.png)

소프트웨어 개발에서는 체계적이고 유지보수 가능한 코드베이스를 유지하는 것이 매우 중요합니다. 이때 Clean Architecture가 등장하여 코드베이스를 모듈식, 독립적이고 테스트 가능한 방식으로 구성하는 데 도움을 줍니다. 이 글에서는 Clean Architecture가 무엇인지, Flutter에서 어떻게 구현하는지, 그리고 프로젝트에 어떤 이점을 가져다 줄 수 있는지 살펴보겠습니다.

커피를 마시고 준비하세요! 오랜 여정이 시작됩니다.

## Flutter에서 Clean Architecture를 사용해야 하는 이유
```

<div class="content-ad"></div>

클린 아키텍처는 모듈화, 유지보수 가능성, 테스트 가능성을 향상시켜 주는 소프트웨어 설계 철학입니다. 각 층으로 코드를 분리하여 애플리케이션을 구조화하며, 크고 복잡한 앱에 특히 유용합니다.

## 장점

- 모듈성과 독립성: 애플리케이션을 독립적인 부분으로 분할하고 각각을 별도로 관리 및 개발합니다.
- 쉬운 테스트 가능성: 비즈니스 로직을 독립적으로 테스트하여 오류를 감지하기 쉽습니다.
- 테스트 주도 개발 (TDD): TDD 원칙과 잘 부합합니다. 먼저 비즈니스 로직에 대한 테스트를 작성한 후 그 테스트를 통과할 코드를 구현할 수 있습니다.
- 미래 확장성: 새로운 기능을 추가하거나 기존 기능을 수정하는 데 더 적은 노력이 필요합니다.
- 재사용성: 비즈니스 로직을 다른 프로젝트나 플랫폼에서 재사용할 수 있습니다.
- 관심사 분리: 비즈니스 로직과 사용자 인터페이스 (UI) 사이의 명확한 경계를 유지함으로써 팀 구성을 더 잘 조직화할 수 있습니다.
- 유지보수 용이성: 층 간 의존성을 줄여 코드 유지보수를 단순화합니다.
- 변경에 대한 유연성: 데이터 소스나 서비스를 변경하기 쉽게 합니다.
- 좋은 문서화: 프로젝트 이해와 유지보수를 위해 구조와 작동원리를 명확히 정의합니다.

클린 아키텍처는 데이터층, 도메인층, 프레젠테이션 층으로 구성되어 있습니다. 각 층은 구별된 책임과 제한된 의존성을 가지고 있습니다.

<div class="content-ad"></div>

```
![이미지](/assets/img/2024-06-20-FlutterCleanArchitecturePart1Introduction_1.png)

코딩을 시작하기 전에 짧게 예제에 대해 설명하겠습니다:

TMDB 플랫폼의 API를 사용하여 기본 영화 애플리케이션을 구축할 예정입니다. 이 응용 프로그램은 API에서 인기 있는 및 최상위 영화 목록을 검색하고 표시할 것입니다. 사용자는 배우 세부 정보를 포함한 영화 정보에 액세스할 수 있습니다.

![이미지](https://miro.medium.com/v2/resize:fit:600/1*opIWWgVq6ZlP_x5sdV0LDA.gif)
```

<div class="content-ad"></div>

사용할 패키지 목록

```js
dependencies:
  # 라우팅을 위해 => https://pub.dev/packages/auto_route
  auto_route: ^7.8.3

  # 이미지 캐싱을 위해 => https://pub.dev/packages/cached_network_image
  cached_network_image: ^3.3.0

  # 네트워크 요청을 위해 => https://pub.dev/packages/dio
  dio: ^5.3.3

  # 동등성을 위해 => https://pub.dev/packages/equatable
  equatable: ^2.0.5

  # 테마를 위해 => https://pub.dev/packages/flex_color_scheme
  flex_color_scheme: ^7.3.1

  flutter:
    sdk: flutter

  # 상태 관리를 위해 => https://pub.dev/packages/flutter_bloc
  flutter_bloc: ^8.1.3

  # 환경 변수를 위해 => https://pub.dev/packages/flutter_dotenv
  flutter_dotenv: ^5.1.0

  # 자산 코드 생성을 위해 => https://pub.dev/packages/flutter_gen
  flutter_gen: ^5.4.0

  # 유용한 훅을 위해 => https://pub.dev/packages/flutter_hooks
  flutter_hooks: ^0.20.3

  # 책임성을 위해 => https://pub.dev/packages/flutter_screenutil
  flutter_screenutil: ^5.9.0

  # SVG를 위해 => https://pub.dev/packages/flutter_svg
  flutter_svg: ^2.0.9

  # 함수형 프로그래밍을 위해 => https://pub.dev/packages/fpdart
  fpdart: ^1.1.0

  # 의존성 주입을 위해 => https://pub.dev/packages/get_it
  get_it: ^7.6.4

  # 테마 또는 로캘 관리를 위해 => https://pub.dev/packages/hydrated_bloc
  hydrated_bloc: ^9.1.2

  intl: ^0.19.0

  # 로컬 데이터 소스를 위해
  isar: ^3.1.0+1
  isar_flutter_libs: ^3.1.0+1

  # API 모델 생성을 위해 => https://pub.dev/packages/json_annotation
  json_annotation: ^4.8.1

  # 앱 데이터 디렉토리
  path_provider: ^2.1.1

  # 개발자를 위한 dio 인터셉터 => https://pub.dev/packages/pretty_dio_logger
  pretty_dio_logger: ^1.3.1

  # 반짝거림 효과를 위해 => https://pub.dev/packages/shimmer
  shimmer: ^3.0.0

  # URL 런처를 위해 => https://pub.dev/packages/url_launcher
  url_launcher: ^6.2.2

dev_dependencies:
  # auto_route 생성기 => https://pub.dev/packages/auto_route_generator
  auto_route_generator: ^7.3.1

  # bloc 테스트를 위해 => https://pub.dev/packages/bloc_test
  bloc_test: ^9.1.4

  build_runner: ^2.4.6
  flutter_gen_runner: ^5.4.0
  flutter_lints: ^3.0.1
  flutter_test:
    sdk: flutter

  # 로컬 데이터 소스
  isar_generator: ^3.1.0+1

  # API 모델 생성을 위해 => https://pub.dev/packages/json_serializable
  json_serializable: ^6.7.1

  # 테스트를 위해 => https://pub.dev/packages/mockito
  mockito: ^5.4.4
```

## HTTP 요청

flutter_dotenv 패키지를 사용하여 간단한 애플리케이션 상수 클래스를 만들어 봅시다.

<div class="content-ad"></div>

```js
class AppConstants {
  final baseUrl = '${dotenv.env['BASE_URL']}'; //* https://api.themoviedb.org/3
  final apiToken = '${dotenv.env['API_TOKEN']}'; //* your TMDB token. (sign up here https://developer.themoviedb.org/docs)
}
```

HTTP 요청을 위한 클래스를 만들어 봅시다. DioClient 클래스는 API 요청을 보내고 json 데이터를 반환할 것입니다. 여기서 주요 목적은 DioClient 클래스를 get, post, put, patch, delete 메서드로 제한하는 것입니다.

저희 애플리케이션에서는 하나의 API만 사용할 것이므로, Dio를 사용하기 때문에 DioClient라고 이름 짓겠습니다. 애플리케이션이 여러 개의 API와 통신해야 하는 경우, HTTP 요청을 보내는 DioClient와 유사한 클래스가 필요합니다. 이것은 각 네트워크 클래스가 관련된 데이터 원본과 관련되어야 하기 때문입니다.

예를 들어, 영화 데이터에 대해 TMDB API를 사용하고 배우에 대해 BlaBla API를 사용하는 경우, 명명 규칙에 유의해야 합니다. 네이밍의 예시로는 TmdbNetworkManager, BlaBlaClient, CatClient 등이 있을 수 있습니다.
```

<div class="content-ad"></div>

```js
class DioClient {
  Dio _dio;

  DioClient() {
    _dio = Dio();
    _dio
      ..options.baseUrl = AppConstants.baseUrl
      ..options.headers = {
        HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
        HttpHeaders.authorizationHeader: 'Bearer ${AppConstants.apiToken}',
      }
      ..options.connectTimeout = const Duration(milliseconds: 15000)
      ..options.receiveTimeout = const Duration(milliseconds: 15000)
      ..options.responseType = ResponseType.json
      ..interceptors.add(
        PrettyDioLogger(
          compact: false,
          logPrint: (object) => log(object.toString(), name: 'TMDB API'),
        ),
      );
  }

  /// * GET
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  /// * POST
  Future<Response> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  /// * PUT
  Future<Response> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  /// * PATCH
  Future<Response> patch(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  /// * DELETE
  Future<dynamic> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }
}
```

## 네트워크 오류 모델

네트워크 오류 모델을 만들어봅시다. 이 모델은 나쁜 응답 오류가 발생할 때 생성되므로 API에서 오류 메시지를 표시할 수 있습니다.

TMDB API의 오류 모델은 아래와 같습니다.```

<div class="content-ad"></div>

```json
@JsonSerializable()
class NetworkErrorModel extends Equatable {
  @JsonKey(name: 'status_code')
  final int? statusCode;
  @JsonKey(name: 'status_message')
  final String? statusMessage;

  const NetworkErrorModel({this.statusCode, this.statusMessage});

  factory NetworkErrorModel.fromJson(Map<String, dynamic> json) {
    return _$NetworkErrorModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NetworkErrorModelToJson(this);

  @override
  List<Object?> get props => [statusCode, statusMessage];
}
```

## 로컬 데이터베이스

데이터베이스에 접근하는 클래스를 만들어 봅시다.

```json
/// 로컬 데이터베이스를 나타내는 클래스.
///
/// 이 클래스는 Isar 데이터베이스를 초기화하고 액세스하는 방법을 제공합니다.
class LocalDatabase {
  late final Isar _isar;
  bool _isInitialized = false;

  /// 초기화된 Isar 데이터베이스 인스턴스를 반환합니다.
  ///
  /// 데이터베이스가 초기화되지 않은 경우 [IsarError]를 throw합니다.
  Isar get db => _isInitialized ? _isar : throw IsarError('Isar가 초기화되지 않았습니다.');

  /// Isar 데이터베이스를 초기화합니다.
  ///
  /// 데이터베이스가 이미 초기화된 경우 [IsarError]를 throw합니다.
  Future<void> initialize() async {
    if (_isInitialized) throw IsarError('Isar가 이미 초기화되었습니다.');

    final directory = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([MovieDetailCollectionSchema], directory: directory.path);

    _isInitialized = true;
  }
}
```

<div class="content-ad"></div>

## 에러 처리

DioException을 사용하여 네트워크 오류를 처리하는 클래스를 만들어 보겠습니다.

```js
class NetworkException extends Equatable implements Exception {
  late final String message;
  late final int? statusCode;

  NetworkException.fromDioError(DioException dioException) {
    statusCode = dioException.response?.statusCode;

    switch (dioException.type) {
      case DioExceptionType.cancel:
        message = 'API 서버로의 요청이 취소되었습니다';
        break;

      case DioExceptionType.connectionTimeout:
        message = 'API 서버와의 연결 시간 초과';
        break;

      case DioExceptionType.receiveTimeout:
        message = 'API 서버와의 연결 중 수신 시간 초과';
        break;

      case DioExceptionType.sendTimeout:
        message = 'API 서버와의 연결 중 송신 시간 초과';
        break;

      case DioExceptionType.connectionError:
        if (dioException.error.runtimeType == SocketException) {
          message = '인터넷 연결을 확인해주세요';
          break;
        } else {
          message = '예기치 않은 오류가 발생했습니다';
          break;
        }

      case DioExceptionType.badCertificate:
        message = '잘못된 인증서';
        break;

      case DioExceptionType.badResponse:
        final model = NetworkErrorModel.fromJson(dioException.response?.data as Map<String, dynamic>);
        message = model.statusMessage ?? '예기치 않은 오류가 발생했습니다';
        break;

      case DioExceptionType.unknown:
        message = '예기치 않은 오류가 발생했습니다';
        break;
    }
  }

  @override
  List<Object?> get props => [message, statusCode];
}
```

그리고 IsarError를 사용하여 로컬 데이터베이스 오류를 처리하는 클래스를 만들어 보겠습니다.

<div class="content-ad"></div>

```js
class DatabaseException extends Equatable implements Exception {
  late final String message;

  DatabaseException.fromIsarError(IsarError isarError) : message = isarError.message;

  @override
  List<Object?> get props => [message];
}
```

알겠어요! 여기까지입니다. 이 부분에서는 여기까지 언급할 거예요.

이제 Clean Architecture에 대해 준비되었습니다.

다음 파트
```