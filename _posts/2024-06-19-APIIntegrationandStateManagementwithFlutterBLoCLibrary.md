---
title: "API 통합 및 상태 관리를 위한 Flutter BLoC 라이브러리"
description: ""
coverImage: "/assets/img/2024-06-19-APIIntegrationandStateManagementwithFlutterBLoCLibrary_0.png"
date: 2024-06-19 08:08
ogImage: 
  url: /assets/img/2024-06-19-APIIntegrationandStateManagementwithFlutterBLoCLibrary_0.png
tag: Tech
originalTitle: "API Integration and State Management with Flutter BLoC Library"
link: "https://medium.com/@praiseajepe/api-integration-and-state-management-with-flutter-bloc-library-408b9dda9690"
---


Flutter Bloc 라이브러리는 잘 정의된 아키텍처를 통해 응용 프로그램 상태를 효과적으로 관리하는 방법을 제공합니다.

![image](/assets/img/2024-06-19-APIIntegrationandStateManagementwithFlutterBLoCLibrary_0.png)

Flutter Bloc Library를 사용하면 다양한 응용 프로그램 상태를 명시적으로 관리할 수 있습니다.

이전에 작성한 기사에서 Flutter Bloc 아키텍처 및 이벤트 및 상태 이해에 대해 설명했습니다. setState를 사용하여 상태 관리의 기본 개념을 이미 알고 계시다면, 이 기사를 참고하시면 이해하기 쉬울 것입니다.

<div class="content-ad"></div>

통합 데이터 소스: 전자 상거래 또는 쇼핑 웹사이트용 가짜 상점 REST API 테스트 API는 네트워크 데이터 소스로 사용됩니다.

더미 JSON URL: https://dummyjson.com/products

본 문서에서는 하나의 엔드포인트(GET: 모든 제품 가져 오기: https://dummyjson.com/products)가 통합될 것입니다

![이미지](/assets/img/2024-06-19-APIIntegrationandStateManagementwithFlutterBLoCLibrary_1.png)

<div class="content-ad"></div>

이 엔드포인트를 통합하기 위해서는 Flutter BLoC 아키텍처를 구현하여 응용 프로그램을 세 개의 계층으로 분리해야 합니다.

- 데이터: 데이터 제공자, 도메인 (저장소, 모델)
- 비즈니스 로직: 비즈니스 로직 계층의 책임은 프리젠테이션 계층에서 발생하는 이벤트에 새로운 상태로 응답하는 것입니다. 이 계층은 응용 프로그램 상태를 구축하는 데 필요한 데이터를 검색하기 위해 하나 이상의 저장소에 의존할 수 있습니다.
- 프리젠테이션: 프리젠테이션 계층의 책임은 하나 이상의 블록 상태에 기반하여 자신을 렌더링하는 방법을 결정하는 것입니다. 또한 사용자 상호 작용 및 응용 프로그램 라이프사이클 이벤트를 처리해야 합니다.

이 3개의 계층 중에서 어떤 계층부터 시작해야 할까요?

그래, 데이터 계층부터 시작하겠습니다. 왜냐하면 데이터 계층에서 비즈니스 로직으로 순차적인 통신이 이루어지고, 비즈니스 로직에서 프리젠테이션으로 이어지기 때문이죠.

<div class="content-ad"></div>

특수한 경우에는 네트워크 및 데이터 시뮬레이션에 더 적합한 방법을 따를 수 있습니다.

데이터 레이어 구현으로 넘어가기 전에 필요한 종속성을 추가해 봅시다:

```markdown
![Dependency](/assets/img/2024-06-19-APIIntegrationandStateManagementwithFlutterBLoCLibrary_2.png)
```

HTTP: HTTP 요청을 만들기 위한 구성 가능한 미래 기반 라이브러리입니다.

<div class="content-ad"></div>

플러터 Bloc: 빠르고 반응성 있는 모바일 애플리케이션을 구축하기 위해 bloc과 함께 작동하는 강력한 플러터 위젯

Equatable: == 및 hashCode를 명시적으로 재정의할 필요 없이 값을 기반으로 한 등가성을 구현하는 데 도움이 되는 Dart 패키지입니다. Flutter Bloc에서는 동일한 상태가 발생하는 경우 상태 재구성을 방지하거나 결정하는 데 도움이 됩니다.

Intl: 숫자 형식 지정에 사용됩니다.

실행: `flutter pub get` 명령을 실행하여 종속성을 프로젝트에 추가하세요.

<div class="content-ad"></div>

# 1. 데이터 레이어

데이터 제공자: 데이터 제공자는 원시 데이터, 즉 HTTP 요청의 원시 응답을 받습니다.

대규모 애플리케이션을 구축할 때 모든 HTTP 메서드를 포함하는 단일 데이터 제공자를 사용할 수 있습니다. 이는 모든 원시 데이터가 HTTP 응답임을 고려한 것입니다.

데이터 제공자는 HTTP 메서드(PUT, GET, POST, DELETE)와 리포지토리에 의해 관리되는 다른 원시 데이터 소스(예: 로컬 저장소)를 포함할 수 있습니다.

<div class="content-ad"></div>

이 구현의 예는 데이터를 가져 오기 때문에 HTTP Get 요청만 수행됩니다.

HTTP 요청은 try-catch 블록 내에 있어 이 요청에서 발생할 수 있는 모든 예외를 잡아내고 해당 예외를 다시 던집니다. 이 예외는 데이터 제공자 클래스에서 처리되지 않고 리포지토리로 던져집니다.

모델

모델은 데이터 구조를 결정하는 데 도움이 되는 클래스입니다. 모델은 데이터베이스나 HTTP 응답을 반영하도록 작성될 수 있으며 이 경우 제품 JSON 응답을 얻는 것입니다.

<div class="content-ad"></div>

이 모델에는 데이터 제공자로부터 JSON 형식의 HTTP 응답을 특정 모델(Dart 객체)로 디코딩하는 데이터 역직렬화 방법도 포함됩니다.

데이터를 전송할 때(e.g. POST, PUT, PATCH 요청 등)는 인코딩된 json이 필요한 경우 요청 본문을 인코딩하기 위한 직렬화 방법을 추가할 수 있습니다.

저장소

저장소는 도메인으로서 우리의 데이터 계층을 추상화하고 블록 계층과의 통신을 용이하게 합니다. 이를 통해 우리 코드베이스의 나머지 부분은 특정 데이터 제공자가 아닌 저장소 계층에서 노출된 함수에만 의존하게 됩니다.

<div class="content-ad"></div>

`getProducts` 메서드는 List of Product (List`Product`)을 데이터 타입으로 반환하는 비동기 메서드입니다. Product는 product_model.dart에서 생성된 모델입니다. (Line: 6)

(Line: 5) 데이터 공급 업체는 get products 엔드포인트(“https://dummyjson.com/products”)를 파싱하는 getRequest 메서드를 호출하기 위해 인스턴스화됩니다.

데이터 공급 업체는 응답 본문, 응답 상태 코드 등에 액세스할 수 있는 raw HTPP 응답을 반환합니다. 상태 코드 200은 요청이 성공적이고 제품이 반환되었음을 나타내며, 요청이 성공적이지 않으면 예외(“Error loading product”)가 던져져 Bloc Layer에서 처리됩니다 (Line: 15).

또한 레포지토리에서 getRequest는 예외를 블록 레이어에서 처리하도록 다시 던지기 위한 try-catch 블록 내에 있습니다.

<div class="content-ad"></div>

# 2. BLOC

BLOC 레이어를 관리할 때, 우리는 이벤트 및 상태를 생성합니다. 이것이 응용 프로그램 상태를 우아하게 관리하는 Flutter Bloc의 핵심 부분입니다.

선호하는 IDE에서 Flutter Bloc 확장 프로그램을 사용하면 bloc을 더 빨리 생성할 수 있습니다. (이벤트, 상태, bloc을 포함하는) 보일러플레이트입니다.

Bloc 확장 프로그램 사용하기

<div class="content-ad"></div>

- Bloc을 extension에 설치하세요.
- Bloc 디렉토리를 만드세요.
- 이 디렉토리를 마우스 오른쪽 클릭하고 New `Bloc Class`를 선택하세요.
- 이름을 product으로 지정하면 _bloc, _event, _state가 클래스 이름에 추가됩니다. 또한 equatable를 확장할 수 있습니다.

![이미지](/assets/img/2024-06-19-APIIntegrationandStateManagementwithFlutterBLoCLibrary_3.png)

세 개의 bloc 파일(클래스)을 살펴봅시다. 먼저 고려해야 할 것은 product state 입니다.

product_state

<div class="content-ad"></div>

제품 상태는 원격 데이터 소스에서 제품을 가져오는 동안 애플리케이션이 있을 수있는 상태를 정의합니다.

- 제품 초기 상태: 이름 그대로 어떠한 프로세스도 시작되기 전에 애플리케이션의 초기 상태입니다.

```js
class ProductInitial extends ProductState {}
```

- 제품 로딩 상태: 원격 데이터 소스에서 제품을 가져오기 위한 요청이 시작됐을 때, 애플리케이션은 제품 로딩 상태를 나타내며, 이 상태는 Flutter Bloc 위젯을 통해 확인할 수 있습니다. 이 상태는 BlocListener, BlocConsumer, BlocBuilder를 통해 듣을 수 있으며, 사용자에게 요청 프로세스가 진행 중임을 보여줄 수 있도록 애플리케이션을 로딩 상태로 설정할 수 있습니다.

<div class="content-ad"></div>

```js
class ProductLoadingState extends ProductState {}
```

- Product Loaded State: 제품이 원격 데이터 소스에서 로드되어 화면에 표시될 수 있는 상태입니다.
- ProductLoadedState에는 생성자에서 제품 목록(List<Product> products)이 필요하며, 이는 이 상태가 가져온 제품을 화면에 표시하기 위해 발생시킵니다. (라인 13)

```js
class ProductLoadedState extends ProductState {
  const ProductLoadedState({required this.products});
  final List<Product> products;
  @override
  List<Object> get props => [products];
}
```

- Product Empty State: 명시적이고 표현 계층에 로직을 줄이기 위해 상품 조회가 성공했지만 제품 데이터가 비어 있는 상태를 관리합니다. (라인 20)
- Product Loading Failed State: 제품을 로드하는 중에 오류가 발생한 상태입니다. 이 오류는 HTTP 오류이거나 예외일 수 있습니다. 사용자 경험을 향상시키기 위해 페이지에 친절한 메시지를 표시하여 오류의 원인 또는 요청이 완료되지 않은 이유를 설명하는 것이 좋습니다. 이로 인해 ProductLoadingFailedState는 생성자에서 오류 메시지를 요구합니다. (라인 22)```

<div class="content-ad"></div>

플러터 Bloc을 사용할 때 애플리케이션에서 모든 것은 이벤트와 상태에 기반합니다. 단일 이벤트 초기화는 애플리케이션의 여러 상태와 관련될 수 있습니다.

이 시나리오에서 단일 이벤트인 GetProductEvent를 선언합니다. 이 단일 이벤트의 초기화는 다양한 애플리케이션 상태(ProductLoadingState, ProductLoadedState, ProductEmptyState, ProductLoadingFailedState)를 발생시킬 수 있습니다.

```dart
part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
  // TODO: implement props
  @override
  List<Object?> get props => [];
}

class GetProductEvent extends ProductEvent {}
```

그 다음, 이벤트를 상태로 매핑합니다. 이전 Bloc 클래스에서 최근 업데이트 이전에 사용된 용어로 (mapEventToState)를 사용하여 이벤트를 상태로 기본적으로 매핑하는 것이 매우 좋다고 생각합니다.

<div class="content-ad"></div>

이벤트와 상태 간의 매핑이 구현되어 있습니다. Bloc은 새로운 상태를 발생시킬 수 있는 Emitter를 사용합니다.

아래 Bloc은 단순히 이벤트의 초기화를 보여줍니다. Emitter는 Product State를 확장하여 다른 상태를 발생시킬 수 있습니다. 이 경우 GetProductEvent에서 Emitter`ProductState`를 사용합니다.

Bloc은 저장소로부터 디코딩된 응답과 통신하며, 저장소는 원시 데이터를 제공하는 데이터 제공자와 통신합니다.

ProductRepository는 BlocProvider 래퍼를 통해 프레젠테이션 레이어(위젯)에 주입되거나 제공될 것입니다. 그러나 먼저 Bloc에 집중해 보겠습니다.

<div class="content-ad"></div>

이 블록 파일은 이벤트를 상태에 매핑하는 것을 관리합니다:

- getProducts()는 제품 목록을 반환합니다 (17번 라인)
- getProducts()가 성공적으로 반환되면 제품이 비어 있는지 확인합니다 (18번 라인)
- 제품이 비어 있다면 ProductEmptyState를 발생시키고, 그렇지 않으면 제품 데이터로 getProducts()가 성공적입니다.
- ProductLoadedState를 발생시키면 반환된 제품이 ProductLoadedState에 의해 발생합니다 (21번 라인)
- 우리는 여기서 try-catch 메서드를 사용하는데, 예외는 handleExceptionWithMessage() 메서드로 처리됩니다. 이 함수는 예외를 캡처하고 친숙한 메시지를 반환하여 관리합니다. FormatException, SocketException, NetworkImageLoadException의 스택 추적을 사용자에게 보여주고 싶지 않을 것입니다.

예외 처리기

참고: 예외를 관리하는 더 많은 방법이 있습니다. 본 문서는 주로 예외 처리에 중점을 둔 것이 아니지만, 이 방법을 사용하여 Kosher!를 반복할 수 있습니다.

<div class="content-ad"></div>

```dart
import 'dart:async';
import 'dart:io';

String handleExceptionWithMessage(dynamic error) {
  if (error is SocketException) {
    return "인터넷에 연결되지 않은 것 같습니다.";
  } else if (error is TimeoutException) {
    return "요청 시간이 초과되었습니다. 안정적인 인터넷 연결이 있는지 확인해주세요.";
  } else {
    return "오류가 발생했습니다. 다시 시도해주세요.";
  }
}
```

handleExceptionWithMessage() 함수는 발생한 예외에 대한 설명을 반환합니다. 이 경우에는 두 가지 종류의 예외 유형(SocketException; 인터넷 연결이 없을 때 발생, TimeoutException; HTTP 요청의 설정된 시간 초과할 때 발생)만 확인합니다.

# 3. 프레젠테이션

데이터와 블록 레이어가 준비되어 있으며, 프레젠테이션에는 데이터를 표시하는 위젯이 포함되어 있습니다.
```

<div class="content-ad"></div>

Bloc 이벤트 또는 상태에 액세스하기 전에는 애플리케이션에 이 Bloc을 제공해야 합니다.

BlocProvider 및 Repository Provider를 사용한 의존성 주입(DI)

BlocProvider는 Flutter 위젯으로, BlocProvider.of` T`(context)를 통해 자식 위젯에 bloc을 제공합니다. 이는 의존성 주입(DI) 위젯으로 사용되어 서브트리 내에서 여러 위젯에 대해 단일 bloc 인스턴스를 제공할 수 있도록 합니다.

대부분의 경우 BlocProvider는 서브트리의 나머지 부분에서 사용할 새로운 bloc을 생성하는 데 사용되어야 합니다. 이 경우 BlocProvider는 bloc을 생성하는 것에 대한 책임이 있으므로 자동으로 그것을 닫아 줄 것입니다. (출처: Flutter Bloc 문서)

<div class="content-ad"></div>

이 Bloc을 main.dart의 최상위 부모 위젯 (MaterialApp)에 제공합니다.

Bloc 이벤트를 초기화하고 상태를 관리합니다

제품을 표시하는 페이지가 생성되었을 때 (initState) 이 페이지의 초기화에서 Bloc 이벤트 (GetProductEvent)를 호출하거나 추가합니다.

```dart
@override
void initState() {
  context.read<ProductBloc>().add(GetProductEvent());
  super.initState();
}
```

<div class="content-ad"></div>

GetProductEvent이 호출될 때, BlocBuilder는 상태를 통해 생성되는 위젯(제품 로딩 위젯, 제품 로딩 오류 위젯 등)을 관리할 수 있는 Bloc 위젯으로 추가됩니다.

만세! 위 예제를 통해 Flutter Bloc을 사용한 API 통합 및 상태 관리의 기본 개념이 설명되었습니다.

이 예제의 전체 프로젝트 코드는 GitHub에서 확인할 수 있습니다: https://github.com/waleajepe/flutter_bloc_api

이 개념을 더 잘 이해하기 위해 Flutter Bloc 라이브러리 팀 (Very Good Ventures 팀)이 제공하는 더 많은 예제를 읽고 확인하는 것이 좋습니다: https://bloclibrary.dev/getting-started/

<div class="content-ad"></div>

만약 이 기사가 도움이 되었다면 👏 몇 개 클랩(claps)도 부탁드려요. 댓글 섹션에 기여와 수정 사항을 남겨주셔도 됩니다. 건배! 👊😊