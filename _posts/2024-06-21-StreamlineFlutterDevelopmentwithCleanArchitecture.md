---
title: "클린 아키텍처로 플러터 개발 효율적으로 하기"
description: ""
coverImage: "/assets/img/2024-06-21-StreamlineFlutterDevelopmentwithCleanArchitecture_0.png"
date: 2024-06-21 21:41
ogImage: 
  url: /assets/img/2024-06-21-StreamlineFlutterDevelopmentwithCleanArchitecture_0.png
tag: Tech
originalTitle: "Streamline Flutter Development with Clean Architecture"
link: "https://medium.com/simform-engineering/streamline-flutter-development-with-clean-architecture-a850b182cfb9"
---


## 모듈화, 유지보수 가능하고 테스트 가능한 Flutter 앱을 만드는 방법을 배워보세요.

올바른 아키텍처는 앱의 성패를 좌우할 수 있습니다. 개발 프로세스뿐만 아니라 최종 제품의 성능과 확장성에도 영향을 미칩니다.

로버트 C. 마틴이 만든 "Clean Architecture(깨끗한 아키텍처)"는 코드를 구성하여 비즈니스 로직과 기술 구현(데이터베이스, API, 프레임워크)을 분리하는 소프트웨어 디자인 철학입니다. 이 분리는 애플리케이션의 기능을 유지, 변경 및 테스트하기 쉽게 만듭니다.

# Clean Architecture가 왜 필요한가요?

<div class="content-ad"></div>

클린 아키텍처는 코드를 계층으로 분리하여 모듈화되고 유지보수 가능하며 테스트할 수 있는 앱을 만드는 데 도움이 됩니다. 특히 대규모 및 복잡한 앱에 유용한 방법론입니다.

# 클린 아키텍처 계층

클린 아키텍처는 세 가지 주요 계층으로 구성됩니다: 데이터 계층, 도메인 계층 및 프레젠테이션 계층. 각 계층은 구체적인 책임과 제한된 종속성을 갖습니다.

## 데이터 계층

<div class="content-ad"></div>

데이터 레이어에는 서버나 데이터베이스와 같은 외부 데이터 소스와 통신하는 코드가 포함되어 있습니다. 이것은 도메인 레이어에서 정의된 계약(추상 클래스)의 구현, 로컬/원격 데이터 소스, 서비스, 그리고 모델을 포함합니다.

## 도메인 레이어

도메인 레이어는 프레젠테이션 레이어와 데이터 레이어 사이에 위치하며 비즈니스 로직을 캡슐화합니다. 이 레이어에는 엔티티, 유스 케이스, 그리고 리포지토리의 추상 클래스인 계약이 포함되어 있습니다. 클린 아키텍처 원칙에 따르면, 이 레이어는 프레젠테이션 또는 데이터 레이어에서의 클래스, 함수 또는 임포트에 의존하지 않아야 합니다.

의존성 역전 원칙은 데이터 레이어와 도메인 레이어 사이의 간극을 메꾸는 역할을 합니다. 상위 수준 모듈은 하위 수준 모듈의 구체적인 구현이 아닌 추상화 또는 인터페이스에 의존해야 합니다. 의존성 역전 원칙에 대해 자세히 이해하려면 이 링크를 참조해주세요.

<div class="content-ad"></div>

## 프레젠테이션 레이어

프레젠테이션 레이어는 시스템의 UI와 관련됩니다. 실제적인 용어로는 화면에 정보를 표시하거나 UI 논리를 처리하는 모든 코드가 이 레이어에 있어야 합니다. 구체적으로 위젯, 컨트롤러 및 상태 보유자가 프레젠테이션 레이어의 구성원입니다.

이 레이어는 도메인 레이어에 의존하며 데이터 레이어에 어떠한 참조도 가지지 않아야 합니다.

## 카운터 앱의 예시로 살펴보기

<div class="content-ad"></div>

클린 아키텍처를 탐구하는데, 인크리먼트, 디크리먼트, 그리고 초기화 기능을 포함한 카운터 앱으로 로컬 데이터베이스인 Hive를 사용합니다. 상태 관리에는 MobX를 사용하고 서비스 로케이터로 get_it을 사용합니다.

![이미지](https://miro.medium.com/v2/resize:fit:582/1*sAj2VA36Rb7G0B0wyKOfKw.gif)

아래는 애플리케이션의 전체 프로젝트 파일 구조입니다.

```js
lib/
├── core/
│   ├── data/
│   │   ├── data_sources/
│   │   │   └── counter/
│   │   │       └── counter_local_data_source.dart
│   │   ├── models/
│   │   │   └── counter/
│   │   │       └── counter_model.dart
│   │   └── repositories/
│   │       └── counter/
│   │           └── counter_repository_impl.dart
│   ├── domain/
│   │   ├── entities/
│   │   │   └── counter/
│   │   │       └── counter_entity.dart
│   │   ├── repositories/
│   │   │   └── counter/
│   │   │       └── counter_repository.dart
│   │   └── usecases/
│   │       └── counter/
│   │           ├── get_counter_usecase.dart
│   │           ├── increment_counter_usecase.dart
│   │           ├── decrement_counter_usecase.dart
│   │           └── reset_counter_usecase.dart
│   └── presentation/
│       ├── controllers/
│       │   └── counter/
│       │       └── counter_controller.dart
│       └── screens/
│           └── counter/
│               └── counter_screen.dart
├── injection_container.dart
└── main.dart
```

<div class="content-ad"></div>

코드 플로우:

<img src="/assets/img/2024-06-21-StreamlineFlutterDevelopmentwithCleanArchitecture_0.png" />

참고: 상태 관리에 MobX를 사용했기 때문에 store에 대해서는 counter_controller.dart 하나만 필요합니다. 다른 상태 관리 솔루션을 사용할 계획이라면 파일을 적절히 업데이트하실 수 있습니다.

# 1. 데이터 레이어

<div class="content-ad"></div>

## 책임

데이터 레이어는 데이터베이스, 네트워크 서비스 또는 저장소와 같은 외부 데이터 소스와의 상호 작용을 관리합니다. 또한 데이터를 저장하고 검색합니다.

## 구성 요소

- 데이터 소스: 데이터베이스, API 또는 다른 외부 서비스와 상호 작용하는 저장소를 구현합니다.
- 데이터 모델: 외부 소스에 저장된 데이터 구조를 나타냅니다.
- 저장소: 데이터 액세스와 데이터 저장을 정의하는 추상 인터페이스입니다.

<div class="content-ad"></div>

```js
── data/
   ├── data_sources/
   │   └── counter/
   │       └── counter_local_data_source.dart
   ├── models/
   │   └── counter/
   │       └── counter_model.dart
   └── repositories/
       └── counter/
           └── counter_repository_impl.dart
```

# 2. 도메인 레이어

## 책임

도메인 레이어는 비즈니스 로직 또는 유즈 케이스 레이어로도 알려져 있으며, 특정 프레임워크와 독립적인 애플리케이션의 핵심 규칙과 로직을 보유합니다.

<div class="content-ad"></div>

## 구성요소

- Entities(개체들): 기본적인 비즈니스 객체나 개념들을 나타냅니다.
- 비즈니스 규칙 및 논리(저장소): 애플리케이션 도메인에 중요한 핵심 기능을 정의합니다.
- Use Cases(사용 사례들): 애플리케이션의 특정 비즈니스 규칙을 보유하며 데이터가 다른 부분으로 이동하는 방법을 관리합니다. 특정 작업이나 작업을 수행하는 데 책임이 있습니다.

## 모델이 있는데 왜 개체가 필요한가요?

개체와 모델은 소프트웨어 개발에서 서로 다른 역할을 하게 됩니다. 개체는 핵심 비즈니스 규칙과 논리에 초점을 맞추고, 모델은 다양한 시스템에서 데이터 저장 및 검색을 처리합니다. 이들을 분리하면 서로에게 영향을주지 않고 관리 및 수정이 쉬워지게 됩니다. 게다가, 개체는 외부 시스템과 독립적이기 때문에 테스트 및 유지 관리가 쉽고 모델을 변경해도 핵심 비즈니스 논리에 영향을주지 않습니다.

<div class="content-ad"></div>

```js
── domain/
   ├── entities/
   │   └── counter/
   │       └── counter_entity.dart
   ├── repositories/
   │   └── counter/
   │       └── counter_repository.dart
   └── usecases/
       └── counter/
           ├── get_counter_usecase.dart
           ├── increment_counter_usecase.dart
           ├── decrement_counter_usecase.dart
           └── reset_counter_usecase.dart
```

# 3. 표현 계층

## 책임

표현 계층은 사용자에게 정보를 표시하고 사용자 상호작용을 관리하는 역할을 합니다. 위젯, 화면 및 컨트롤러와 같은 모든 사용자 인터페이스 (UI) 구성 요소를 포함합니다.

<div class="content-ad"></div>

## 구성 요소

- 스크린: 이들은 기능 스크린을 나타냅니다.
- 위젯 및 UI 구성 요소: 이들은 애플리케이션의 시각적 요소를 나타냅니다. 이 접근 방식은 UI 구성 요소에 대한 코드 분리가 필요한 경우 유용합니다. 그러나 저희 예시에서는 사용하지 않았습니다.
- 컨트롤러: 이들은 정보 제공과 UI 구성 요소, 사용자 입력, 도메인 레이어의 유스 케이스 및 UI 조정과 상호 작용을 처리합니다.

```js
── presentation/
   ├── controllers/
   │   └── counter/
   │       └── counter_controller.dart
   └── screens/
       └── counter/
           └── counter_screen.dart
```

## 공통 파일:

<div class="content-ad"></div>

그게 예제 내용이에요.

# 클린 아키텍처의 장단점

## 장점:

- 모듈화 및 유지보수성: 클린 아키텍처는 컴포넌트를 각각의 계층으로 분리하여 모듈화를 촉진합니다. 이러한 분리는 유지보수성을 향상시켜 특정 부분의 업데이트나 수정을 전체 애플리케이션에 영향을 주지 않고 쉽게 수행할 수 있게 합니다.
- 테스트 용이성: 역할 분리로 인해 플러터에서 유닛 테스트가 용이해집니다. 코어 계층에 있는 비즈니스 로직은 외부 종속성에 영향을 받지 않고 독립적으로 테스트할 수 있어 더 견고하고 신뢰성 있는 테스트를 보장합니다.
- 프레임워크 독립성: 플러터의 핵심 비즈니스 로직은 특정 프레임워크나 라이브러리에 강하게 묶여 있지 않습니다. 이러한 독립성은 애플리케이션을 전환하거나 업그레이드할 때 핵심 기능을 손상시키지 않으면서 쉽게 수행할 수 있게 합니다.
- 유연성: 클린 아키텍처는 플러터의 다양한 계층의 기술 선택에서 유연성을 제공합니다. 예를 들어 다양한 상태 관리 솔루션, UI 라이브러리 또는 데이터 저장 옵션 간에 전환하면서도 핵심 비즈니스 로직을 크게 변경하지 않고 사용할 수 있습니다.
- 확장성: 클린 아키텍처의 모듈화된 구조는 플러터에서 더 나은 확장성을 제공합니다. 다양한 애플리케이션 부분을 독립적으로 확장할 수 있고, 팀이 서로 간섭하지 않고 특정 계층에서 작업할 수 있습니다.

<div class="content-ad"></div>

## 단점:

- 복잡성: Clean Architecture을 구현하는 것은 특히 초기 개발 단계에서 추가 복잡성을 도입할 수 있습니다. 관심사의 분리가 더 많은 파일과 디렉토리를 초래할 수 있으며, 작은 프로젝트에게는 압도적일 수도 있습니다.
- 학습 곡선: Clean Architecture에 새로운 개발자는 학습 곡선을 겪을 수 있습니다. 이 아키텍처의 원칙을 파악하고 올바르게 구현하는 데는 시간과 노력이 필요할 수 있습니다.
- 부가 코드: Clean Architecture은 특히 계층 간의 데이터 매핑에서 더 많은 부가 코드를 필요로 할 수 있습니다. 이는 개발 시간을 증가시킬 수 있지만, 지지자들은 유지 관리성의 장점이 이 단점을 상쇄한다고 주장합니다.
- 간단한 프로젝트의 경우 과도한 엔지니어링: Clean Architecture은 간단하거나 작은 프로젝트에 대해 과한 경우가 있습니다. 여기서 분리 및 모듈화의 이점이 두드러지지 않습니다.

이 게시물이 도움이 되었기를 바라며 새로운 것을 배우셨기를 기대합니다.

GitHub에서 전체 프로젝트 및 코드를 찾을 수 있습니다 — [소스 코드](https://github.com).