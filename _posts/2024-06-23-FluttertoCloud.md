---
title: "Flutter를 클라우드에 연결하는 방법 2024 최신 가이드"
description: ""
coverImage: "/assets/img/2024-06-23-FluttertoCloud_0.png"
date: 2024-06-23 14:55
ogImage: 
  url: /assets/img/2024-06-23-FluttertoCloud_0.png
tag: Tech
originalTitle: "Flutter to Cloud"
link: "https://medium.com/@gharib83/flutter-to-cloud-84429d3bd1ad"
---


# 소개

본 문서 시리즈의 목표는 AWS Amplify를 사용하여 Flutter 모바일 애플리케이션을 개발하고 필요에 따라 다른 방법으로 전환할 수 있는 환경을 구축하는 것입니다. 이 과정에서 발생하는 모든 문제에 대해 다룰 것입니다.

본 애플리케이션은 언어 학습용 간단한 플래시카드 애플리케이션이며, 개발하는 과정을 계속해서 업데이트할 예정입니다.

본 시리즈는 실시간 여정으로, 각 단계를 문서화하고 직면한 도전과정 및 그에 따른 결정 사항을 기록할 것입니다. 구조는 프로젝트의 요구에 따라 발전할 수 있습니다.

<div class="content-ad"></div>

여기 이 시리즈에서 다룰 내용입니다:

- 파트 1: 아키텍처
- 파트 2: Flutter 및 Amplify 설정
- 파트 3: GraphQL 스키마 정의
- 파트 4: 인증 구현
- 파트 5: 핵심 기능 개발
- 파트 6: UI 개발 및 상태 관리
- 파트 7: 추가 서비스 통합
- 파트 8: 배포 및 모니터링
- 파트 9: 대안 및 이전 이주 표 평가
- 파트 10: 반성 및 향후 방향

# 파트 1

## 아키텍처

<div class="content-ad"></div>

어떤 일을 하기 전에 먼저 해야 할 질문은 아키텍처에 관한 것입니다. 한쪽에서는 필요할 경우 클라우드 제공 업체를 변경할 유연성을 가지고 싶지만, 다른 한쪽에서는 BaaS가 내 요구사항을 충족시키지 못하는 경우, 최소한의 비용과 노력으로 나만의 백엔드를 구현할 수 있기를 원합니다. 이것은 제 첫 번째 BaaS 경험이며, 이 과정 중에 필요한 변경에 대비하고자 합니다. 이를 위해 간단한 플래시카드 앱을 만들 것입니다.

Clean Architecture는 소프트웨어 응용 프로그램에서 관심사 분리, 유지 관리 가능성 및 확장성을 보장하는 견고한 아키텍처 패턴입니다. 백엔드 개발자로서 이 아키텍처는 종종 올바른 선택입니다. 클린 아키텍처의 주요 아이디어는 로버트 C. 마틴이 “Clean Architecture” 책에서 쓴 것처럼, 비즈니스 규칙은 UI, 프레임워크, 데이터베이스 및 다른 외부 응용 프로그램과 쉽게 테스트할 수 있고 독립적이어야 한다는 것입니다.

클린 아키텍처를 컨셉으로 경험을 쌓는 과정에서 헥사고널 아키텍처를 탐구했습니다 (Alistair Cockburn, “Hexagonal Architecture”, and Tom Hombergs, “Get Your Hands Dirty on Clean Architecture”). 이 아키텍처는 소프트웨어를 유연하게 만들고 개발 비용을 줄입니다. 그러나 작은 애플리케이션의 경우, 헥사고널 아키텍처가 과도하게 복잡할 수 있다는 것을 발견했습니다.

Flutter로 새로운 모바일 애플리케이션을 시작할 때, 올바른 아키텍처와 코드 구조를 정의하는 것이 첫 번째 도전이었습니다. 모바일 애플리케이션을 위한 다양한 아키텍처와 디자인을 찾아보면 Model-View-Controller (MVC), Model-View-Presenter (MVP), Model-View-ViewModel (MVVM), Provider, Riverpod 및 Bloc과 같은 결과가 나오며, 각각 장단점이 있습니다.

<div class="content-ad"></div>

목표는 깨끗한 아키텍처 개념을 따르는 구조를 찾는 것이었습니다. UI와 비즈니스 로직을 분리하고 BaaS 제공업체를 쉽게 교체하거나 사용자 지정 백엔드로 이전할 수 있도록 하는 것이 목표였습니다. 본 문서에서는 Flutter 애플리케이션에서 Clean Architecture를 Riverpod를 사용하여 구현한 내용을 다루며, 해당 방법이 어떤 이점을 제공하며 클라우드 제공자 간 또는 사용자 지정 백엔드로 전환하는 것을 간단하게 만드는 방법에 대해 살펴보겠습니다.

다음 다이어그램에서 깨끗한 아키텍처의 주요 아이디어를 고려해 봅시다:

핵심은 엔티티이며, 다른 종속성과 독립적입니다. 프레임워크, 데이터베이스, UI 등에서 최대한 분리되어 유연하고 테스트 가능한 소프트웨어를 개발할 수 있습니다.

나는 육각형 아키텍처를 시도해 보기로 결정했지만, 소규모 애플리케이션에 대해 과도하게 설계된 것으로 간주될 수 있는 기업 앱이 아니기 때문에 곧 포기했습니다.

<div class="content-ad"></div>

여러 가지 아키텍처 패턴을 고려하며, Clean Architecture와 일치하는 아키텍처를 찾고, UI와 비즈니스 로직을 분리하는 것뿐만 아니라 BaaS 접근 방식을 다른 제공 업체로 교체하거나 BaaS에서 클라우드의 백엔드로 쉽게 이동할 수 있도록 해줍니다.

이 부분은 Riverpod를 상태 관리에 사용하는 Flutter 애플리케이션에서 Clean Architecture의 사용에 대해 설명합니다. 이 아키텍처의 장점을 살펴보고, 클라우드 제공 업체 간 전환이나 UI 레이어에 영향을 미치지 않고 사용자 정의 백엔드로 이동하는 것을 어떻게 간소화하는지 살펴볼 것입니다.

Clean Architecture로 진입하기 전에 다른 옵션을 간단히 살펴볼까요? 모바일 애플리케이션을 위한 아키텍처를 찾다 보면 다양한 용어가 등장합니다.

주로 Model–view–controller, Model-view-Presenter, MVVM, Provider, Riverpod, Bloc이 있습니다.

<div class="content-ad"></div>

# 모델 뷰 컨트롤러

MVC는 응용 프로그램을 세 가지 주요 구성 요소로 분리합니다:

모델: 응용 프로그램의 데이터와 비즈니스 로직을 나타냅니다.
뷰: UI 구성 요소와 프레젠테이션 로직을 나타냅니다.
컨트롤러: 모델과 뷰 사이의 중개자 역할을 하며 사용자 입력을 처리하고 둘 다 업데이트합니다.

![image](/assets/img/2024-06-23-FluttertoCloud_0.png)

<div class="content-ad"></div>

뷰와 로직을 분리하는 데 장점이 있지만, 일부 구현에서 컨트롤러가 뷰와 긴밀하게 결합되어 수정 또는 교체하기 어려워질 수 있습니다. 대부분의 핵심 비즈니스 로직은 컨트롤러에 있기 때문에 파일이 커져서 코드를 유지보수하기 힘들어지는 문제가 발생할 수 있습니다.

# 모델 뷰 프레젠터

MVP는 MVC의 문제를 해결하기 위해 나왔습니다. 세 가지 부분으로 구성되어 있습니다:
모델: 도메인 로직, 데이터베이스 및 네트워크 통신을 처리합니다.
뷰: UI 및 사용자 작업을 관리합니다.
프레젠터: 모델에서 데이터를 가져와 UI 로직을 적용하고 뷰 상태를 관리합니다.

이는 더 나은 모듈성을 제공하며 프로젝트 코드를 보다 쉽게 구조화하고 유닛 테스트 능력을 향상시킵니다.

<div class="content-ad"></div>

![이미지](/assets/img/2024-06-23-FluttertoCloud_1.png)

# Model View ViewModel

MVVM은 다음 구성 요소를 갖추고 있습니다:

Model: 데이터 소스를 추상화하고 ViewModel과 함께 데이터 작업을 처리합니다.

View: ViewModel을 관찰하고 비즈니스 로직을 포함하지 않고 사용자 작업을 알립니다.

ViewModel: Model과 View를 연결하여 관련 데이터 스트림을 View에 노출합니다.

<div class="content-ad"></div>

MPV와 비교하여 MVVM은 다음과 같은 점들이 개선되었습니다:

- Tight Coupling Issue: MVVM은 UI와 비즈니스 로직 간의 강한 결합을 줄여 업데이트와 유지보수를 쉽게 할 수 있습니다.
- 향상된 테스트 용이성: MVVM은 Android SDK 구성 요소에 대한 의존성을 최소화하여 단위 테스트를 더 간편하게 만들어줍니다.
- 관심사의 분리가 더 잘 이루어집니다: MVVM은 데이터 표현 로직과 핵심 비즈니스 로직을 더 명확하게 분리하여 더 조직적이고 유지보수가 쉬운 코드베이스를 제공합니다.

![사진](/assets/img/2024-06-23-FluttertoCloud_2.png)

더 자세한 비교는 https://www.geeksforgeeks.org/difference-between-mvp-and-mvvm-architecture-pattern-in-android/에서 확인할 수 있습니다.

<div class="content-ad"></div>

# BLOC 구조

BLOC은 MVVM과 많은 유사성을 가지고 있지만 ViewModel은 Bloc으로 대체됩니다. BLOC에서 상태를 관리하는 핵심 메커니즘은 스트림 또는 반응형 접근 방식의 사용입니다. 기본적으로 데이터는 BLOC과 UI 사이를 스트림으로 흐릅니다.

이는 데이터가 BLOC에서 UI로 지속적으로 전송되고, UI에서 다시 BLOC으로 돌아가는 것을 의미하며, 상태가 효율적이고 일관되게 관리되도록 보장합니다.

![이미지](/assets/img/2024-06-23-FluttertoCloud_3.png)

<div class="content-ad"></div>

# 클린 아키텍처 개요

클린 아키텍처는 응용 프로그램을 다음과 같이 명확하게 계층으로 나눕니다:

- 프리젠테이션 계층: UI 및 사용자 상호작용을 관리합니다.
- 응용 계층: 비즈니스 로직과 서비스를 포함합니다.
- 도메인 계층: 핵심 비즈니스 모델과 로직을 정의합니다.
- 데이터 계층: 데이터 검색 및 지속성을 처리합니다.

각 계층은 특정한 책임을 가지며 다른 계층과 명확한 인터페이스를 통해 통신하여 관심사의 명확한 분리를 보장합니다.

<div class="content-ad"></div>

# 깨끗한 아키텍처의 장점

- 관심사 분리
각 계층은 애플리케이션의 특정 측면에 집중하여 단일 책임을 촉진합니다:

- 프레젠테이션 계층: 사용자 인터페이스 및 상호 작용 로직을 관리합니다.
- 응용 계층: 애플리케이션별 비즈니스 규칙을 관리합니다.
- 도메인 계층: 핵심 비즈니스 로직 및 엔티티를 포함합니다.
- 데이터 계층: 데이터 원본 및 저장소를 관리합니다.

이러한 분리로 코드베이스를 이해, 테스트 및 유지보수하기 쉬워집니다.

<div class="content-ad"></div>

2. 확장성

시스템 구조는 확장이 가능하여, 새로운 기능을 추가할 때 기존 코드에 최소한의 영향을 미치게 합니다. 각 계층은 독립적으로 개발 및 테스트할 수 있어 병렬 개발을 용이하게 합니다.

3. 유지보수성

각 계층 사이에 명확한 경계가 존재함으로써 코드베이스를 유지하고 업데이트하는 것이 간단해집니다. 각 계층은 다른 계층에 영향을 주지 않고 수정할 수 있어 새로운 기능을 도입하거나 버그를 수정하기가 더 쉬워집니다.

<div class="content-ad"></div>

<img src="/assets/img/2024-06-23-FluttertoCloud_4.png" />

# 코드 구조 예시

플래시 카드와 덱을 모델로 하는 예시에서 코드 구조는 다음과 같을 수 있습니다. 각 패키지는 Riverpod 구조의 하나의 레이어를 나타냅니다:

```js
ib/
|-- presentation/
|   |-- widgets/
|   |   |-- flashcard_widget.dart
|   |   |-- deck_widget.dart
|   |-- states/
|   |   |-- flashcard_state.dart
|   |   |-- deck_state.dart
|   |-- controllers/
|       |-- flashcard_controller.dart
|       |-- deck_controller.dart
|-- application/
|   |-- services/
|       |-- flashcard_service.dart
|       |-- deck_service.dart
|       |-- transformation_utils.dart
|-- domain/
|   |-- models/
|       |-- flashcard.dart
|       |-- deck.dart
|       |-- domain_deck.dart
|       |-- domain_flashcard.dart
|       |-- ideck.dart
|       |-- iflashcard.dart
|       |-- model_provider.dart
|-- data/
|   |-- repositories/
|   |   |-- flashcard_repository_impl.dart
|   |   |-- deck_repository_impl.dart
|   |   |-- ideck_repository.dart
|   |   |-- iflashcard_repository.dart
|   |   |-- mappers.dart
|   |-- dtos/
|   |   |-- flashcard_dto.dart
|   |   |-- deck_dto.dart
|   |-- data_sources/
|       |-- deck_aws_data_source.dart
|       |-- flashcard_aws_data_source.dart
|-- amplifyconfiguration.dart
|-- main.dart
```

<div class="content-ad"></div>

# 아키텍처 선언

인터페이스와 구조 설명
인터페이스와 계층 구조를 사용하면 아키텍처에 여러 가지 이점이 있습니다:

- 추상화를 위한 인터페이스: 인터페이스(IDeck, IFlashcard, IDeckRepository, IFlashcardRepository)를 정의함으로써, 아키텍처는 구현 세부 정보를 비즈니스 로직과 분리합니다. 이를 통해 다른 구현을 동일한 인터페이스를 구현하여 상호 교환 가능하게 만들 수 있으며, 응용 프로그램의 나머지 부분에 영향을 미치지 않고 사용할 수 있습니다. 예를 들어, AWS Amplify를 다른 클라우드 제공 업체로 또는 사용자 지정 백엔드로 대체할 수 있습니다.

2. 표시 계층: UI 구성 요소를 포함하며 사용자 상호 작용을 관리합니다. 이 계층은 데이터를 표시하고 사용자 작업을 응용 프로그램 계층으로 전달하는 것에만 책임이 있습니다.

<div class="content-ad"></div>

3. Application Layer: 비즈니스 로직과 사용 사례를 포함하고 있습니다. 도메인 레이어와 상호 작용하여 데이터를 검색하고 조작한 후 표현 레이어를 업데이트합니다. UI와 비즈니스 로직을 분리함으로써 애플리케이션은 유지보수 가능하고 테스트 가능해집니다.

4. Domain Layer: 핵심 비즈니스 모델과 로직을 정의합니다. 이러한 모델은 다른 레이어에 의존성이 없는 간단한 Dart 클래스들로 구성되어 있어 독립적이고 재사용 가능하도록 보장합니다. 도메인 레이어에는 데이터 레이어에서 구현된 저장소에 대한 인터페이스가 포함되어 있습니다.

5. Data Layer: 데이터 검색 및 지속성을 관리합니다. 이 레이어에는 저장소 인터페이스의 구현이 포함되어 있으며, 이것들은 데이터 원본 (예: AWS Amplify)과 상호 작용합니다. 맵퍼를 사용하여 이 레이어는 도메인 모델과 데이터 전송 객체(DTO) 간에 데이터를 변환합니다.

# Riverpod이 아키텍처에 미치는 영향

<div class="content-ad"></div>

Riverpod은 Clean Architecture를 향상시키는 상태 관리 라이브러리로 다음을 제공합니다:

- 확장성: 복잡한 사용 사례를 지원하며 전체 응용 프로그램에서 상태를 쉽게 관리합니다.
- 테스트 용이성: Riverpod은 상태 관리의 쉬운 모의 및 테스트를 가능하게 합니다.
- 유연성: UI 구성 요소에서 상태 관리를 분리하여 Clean Architecture의 원칙을 준수합니다.

Riverpod을 사용하면 상태 관리 논리가 응용 프로그램 계층 내에 있어 관심사를 구분하고 표현 계층이 UI 관련 논리에 집중할 수 있습니다.

Bloc을 사용할 때 상태 변경은 데이터의 스트림으로 일관되게 표현됩니다. 반면에 Riverpod은 Streams, Futures, StateNotifiers, ChangeNotifiers를 비롯한 다양한 유형의 데이터를 감시할 수 있는 유연성을 제공합니다.

<div class="content-ad"></div>

이 다양성은 Riverpod가 다른 상태 메커니즘을 매끄럽게 관리할 수 있도록 합니다.

# 클라우드 제공 업체를 변경하거나 사용자 정의 백엔드로 이동하는 유연성

이 깔끔한 아키텍처 접근 방식을 따르면, 다른 BaaS(Backend as a Service)를 다른 것으로 교체하거나 심지어 사용자 정의 백엔드로 마이그레이션하는 것이 쉬워집니다.

이 아키텍처는 UI와 비즈니스 로직이 데이터 접근 레이어와 완전히 분리되어 있음을 보장합니다. 이 느슨한 결합은 마이그레이션 프로세스를 크게 용이하게 만듭니다.

<div class="content-ad"></div>

기능 분리: 아키텍처는 프레젠테이션, 도메인 및 데이터와 같이 잘 정의된 인터페이스를 통해 통신하는 주요 레이어로 응용 프로그램을 분리합니다. 이 분리는 한 레이어의 변경이 다른 레이어에 영향을 미치지 않도록 보장합니다.

느슨한 결합: 인터페이스와 의존성 주입 (우리의 경우 Riverpod 프로바이더를 통해)의 사용은 데이터 소스의 다양한 구현을 쉽게 교체할 수 있게 합니다. 예를 들어, AWS Amplify에서 사용자 정의 백엔드로 전환하는 경우 데이터 레이어에서만 변경이 필요합니다.

유지 관리성: 데이터 액세스 로직을 비즈니스 로직 및 UI에서 격리시킴으로써 응용 프로그램을 더 유지 보수 가능하고 이해하기 쉽게 만듭니다. 각 레이어에는 특정 책임이 있어 변경 사항을 할 때 우발적인 부작용의 위험을 줄입니다.

확장성: 이 아키텍처는 확장 가능하도록 설계되었습니다. 백엔드의 새로운 기능이나 변경 사항을 기존 코드베이스를 크게 수정하지 않고 수용할 수 있습니다. 이 확장성은 시간이 지남에 따라 다른 서비스와 통합해야 하는 진화하는 응용 프로그램에 필수적입니다.

<div class="content-ad"></div>

다음에는 Flutter 및 Amplify를 설정한 다음 스키마를 정의할 것입니다.

소스:
https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/
https://www.thenifemi.com/articles/ddd-series-part-2
https://codewithandrea.com/articles/comparison-flutter-app-architectures/#comparison-with-bloc-architecture
https://medium.com/@nikilapi/i-found-the-perfect-architecture-for-flutter-apps-59fc2dc8f00f
https://github.com/Uuttssaavv/flutter-clean-architecture-riverpod
https://codewithandrea.com/articles/flutter-presentation-layer/