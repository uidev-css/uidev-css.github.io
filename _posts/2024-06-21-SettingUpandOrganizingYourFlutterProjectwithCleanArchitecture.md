---
title: "클린 아키텍처로 Flutter 프로젝트 설정하고 조직화하는 방법"
description: ""
coverImage: "/assets/img/2024-06-21-SettingUpandOrganizingYourFlutterProjectwithCleanArchitecture_0.png"
date: 2024-06-21 19:58
ogImage: 
  url: /assets/img/2024-06-21-SettingUpandOrganizingYourFlutterProjectwithCleanArchitecture_0.png
tag: Tech
originalTitle: "Setting Up and Organizing Your Flutter Project with Clean Architecture"
link: "https://medium.com/@baharudin-yusup/setting-up-and-organizing-your-flutter-project-with-clean-architecture-478f8615003d"
---


![이미지](/assets/img/2024-06-21-SettingUpandOrganizingYourFlutterProjectwithCleanArchitecture_0.png)

클린 아키텍처는 확장 가능하고 유지 보수 가능하며 테스트 가능한 애플리케이션을 구축하기 위한 견고한 구조를 제공합니다. 이 기사에서는 클린 아키텍처 원칙을 준수하여 플러터 프로젝트를 설정하고 구성하는 초기 단계를 안내해드립니다. 이를 통해 앱이 성장함에 따라 코드베이스가 깔끔하고 모듈식으로 유지되도록 보장합니다.

# 왜 클린 아키텍처를 사용해야 하나요?

로버트 C. 마틴 (엉클 밥)이 인기있게 만든 클린 아키텍처는 애플리케이션 내에서 관심사를 분리하는 것을 강조합니다. 앱을 구별되는 계층으로 나눔으로써 핵심 비즈니스 로직이 프레임워크와 사용자 인터페이스로부터 격리되어 코드가 더 모듈식이고 테스트 가능하며 유지 보수하기 쉬워집니다.

<div class="content-ad"></div>

## Clean Architecture의 주요 원칙

- 관심사의 분리: 응용 프로그램의 각 계층은 특정 책임을 갖고 있어 복잡성을 줄이고 코드를 이해하고 유지하기 쉽게 만듭니다.
- 의존성 규칙: 의존성은 안쪽으로 향합니다. 외부 계층은 내부 계층에 의존할 수 있지만, 내부 계층은 외부 계층에 의존해서는 안 됩니다.
- 프레임워크로부터 독립: 아키텍처는 특정 프레임워크에 의존해서는 안 되며, 최소한의 영향으로 프레임워크를 전환할 수 있어야 합니다.
- 테스트 가능성: 비즈니스 로직은 UI, 데이터베이스 또는 기타 외부 구성 요소와 독립적으로 테스트할 수 있어야 합니다.

# Flutter에서 Clean Architecture 적용하기

Flutter에서 Clean Architecture를 적용하는 것은 프로젝트를 UI와 비즈니스 로직 및 데이터 처리를 분리하는 방식으로 구성하는 것을 의미합니다. 여기서 Flutter 프로젝트를 구조화하는 방법에 대한 개요입니다.

<div class="content-ad"></div>


![이미지](/assets/img/2024-06-21-SettingUpandOrganizingYourFlutterProjectwithCleanArchitecture_1.png)

## 도메인 레이어

도메인 레이어는 앱의 핵심입니다. 비즈니스 로직과 엔티티가 포함되어 있습니다. 이 레이어는 다른 레이어에 독립적이며, 외부 프레임워크나 도구에 의존하지 않습니다.

- 엔티티: 앱 전반에서 사용되는 기본 데이터 구조입니다. 이들은 핵심 데이터 개체를 나타내는 일반적인 다트 클래스입니다.
- 유스 케이스: 비즈니스 로직을 포함하는 클래스입니다. 엔티티와 리포지토리 간의 데이터 흐름을 조정합니다. 유스 케이스는 다른 레이어나 프레임워크에 의존하지 않아야 합니다.
- 리포지토리: 데이터 작업을 정의하는 인터페이스입니다. 이들은 데이터 레이어에서 구현됩니다.


<div class="content-ad"></div>

## 데이터 계층

데이터 계층은 API에서 데이터를 가져오거나 로컬 데이터베이스에서 데이터 작업을 처리합니다. 다음과 같이 구성됩니다:

- 데이터 소스: 데이터 검색을 처리하는 클래스들입니다. 이들은 네트워크 요청(원격 데이터 소스) 또는 로컬 저장소(로컬 데이터 소스)에서 가져올 수 있습니다.
- 저장소: 도메인 계층에서 정의된 저장소 인터페이스의 구현체입니다. 데이터 작업을 처리하고 여러 소스에서 데이터를 조정합니다.
- 모델: 데이터를 파싱하고 직렬화하는 데 사용되는 데이터 구조입니다. 이러한 것들은 주로 데이터 소스로부터 받은 데이터의 형식을 나타냅니다.

## 표현 계층

<div class="content-ad"></div>

프레젠테이션 레이어는 UI와 사용자 상호작용을 관리합니다. 플러터에서 이 레이어에는 다음이 포함됩니다:

- State Management: BLoC (비지니스 로직 컴포넌트) 또는 Provider와 같은 패턴을 사용하여 상태와 비지니스 로직을 관리합니다.
- 위젯: 앱의 시각적 인터페이스를 구축하는 Flutter의 UI 구성 요소입니다.

## 핵심 레이어

전통적인 클린 아키텍처의 일부는 아니지만, 핵심 레이어는 앱 전반에 걸쳐 사용되는 공통 유틸리티와 구성을 제공합니다. 이 레이어는 앱 전체 설정과 도우미 함수를 구성하는 데 필수적입니다.

<div class="content-ad"></div>

- 유틸리티: 서로 다른 레이어에서 사용되는 도우미 함수 및 클래스들.
- 설정: 앱 전체에서 사용되는 설정 및 상수들.

# 프로젝트 구조 정의 및 구성

여기 플러터 앱을 Clean Architecture로 구성하는 권장된 프로젝트 구조입니다:

```js
configs/
scripts/
lib/
├── core/
│ ├── utils/
│ ├── env.dart
│ └── injection_container.dart
├── data/
│ ├── constants/
│ ├── datasources/
│ │ ├── local/
│ │ ├── remote/
│ │ └── cache/
│ ├── models/
│ │ ├── api/
│ │ │ ├── requests/
│ │ │ └── responses/
│ │ ├── cache/
│ │ ├── exception/
│ │ └── local/
│ ├── plugins/
│ ├── repositories/
│ └── utils/
├── domain/
│ ├── entities/
│ ├── errors/
│ ├── repositories/
│ └── usecases/
├── l10n/
├── presentation/
│ ├── blocs/
│ ├── components/
│ ├── routes/
│ ├── screens/
│ ├── services/
│ └── utils/
├── main_dev.dart
├── main_prod.dart
```

<div class="content-ad"></div>

# 디렉토리와 파일 설명

이 섹션은 각 주요 폴더의 목적에 대한 간단한 개요를 제공합니다. 더 자세하고 기술적인 설명은 GitHub 저장소를 참조해주세요.

## configs/

프로젝트의 설정 파일과 설정을 포함합니다. 이 구성에는 환경 설정, 빌드 구성 및 프로젝트에 필요한 다른 전역 설정이 포함됩니다.

<div class="content-ad"></div>

## scripts/

프로젝트 환경을 설정하거나 프로젝트를 빌드하는 등 자동화 작업을 위한 스크립트가 포함되어 있습니다.

## lib/core/

애플리케이션 전체에서 사용되는 중요한 기능 및 구성이 포함되어 있습니다. 이들은 앱의 다양한 계층에서 널리 사용되는 필수 구성 요소입니다.

<div class="content-ad"></div>

- utils/: 애플리케이션 전체에서 사용되는 유틸리티 클래스와 함수가 포함되어 있습니다.
- env.dart: envied를 사용하여 환경 구성을 하는 파일입니다.
- injection_container.dart: get_it을 사용하여 의존성 주입을 설정하는 파일입니다.

## lib/data/

데이터 관리를 다루며, 데이터 소스, 모델 및 리포지토리를 포함합니다. 이 계층은 데이터를 가져오고 저장하며 관리하는 역할을 합니다.

- constants/: 데이터 관리에 사용되는 상수를 정의합니다.
- datasources/: 다른 소스에서 데이터에 액세스하는 방법을 구현합니다.
- models/: 앱에서 사용되는 데이터의 구조를 나타내는 데이터 모델이 포함되어 있습니다.
- plugins/: 다양한 기능을 위한 사용자 정의 플러그인이 포함됩니다.
- repositories/: 리포지토리 패턴을 사용하여 데이터 작업을 관리합니다.
- utils/: 데이터 계층에서 사용되는 유틸리티 클래스와 함수가 포함되어 있습니다.

<div class="content-ad"></div>

## lib/domain/

애플리케이션의 핵심 비즈니스 로직과 엔티티를 정의합니다. 이 레이어는 다른 레이어에 독립적이며 비즈니스 규칙이 외부 요소에 영향을받지 않도록합니다.

- entities/: 메인 데이터 객체를 나타내는 핵심 엔티티.
- errors/: 오류 처리에 사용되는 실패 클래스를 정의합니다.
- repositories/: 레포지토리 패턴을 위한 인터페이스.
- usecases/: 비즈니스 로직을 캡슐화하는 애플리케이션별 유스케이스를 정의합니다.

## lib/l10n/

<div class="content-ad"></div>

애플리케이션의 다국어 지원을 위한 로컬라이제이션 파일이 포함되어 있습니다.

## lib/presentation/

애플리케이션의 UI 레이어 및 상태 관리를 관리합니다. 이 레이어는 도메인 레이어와 상호 작용하여 데이터를 사용자에게 제공합니다.

- blocs/: flutter_bloc을 사용하여 상태를 관리하는 BLoC (Business Logic Component) 클래스가 포함되어 있습니다.
- components/: 재사용 가능한 UI 컴포넌트가 포함되어 있습니다.
- routes/: 애플리케이션 내에서 탐색 경로를 관리합니다.
- screens/: 애플리케이션의 UI 페이지/스크린이 포함되어 있습니다.
- services/: 프레젠테이션 레이어에서 사용되는 서비스가 포함되어 있습니다.
- utils/: 프레젠테이션 레이어에서 사용되는 유틸리티 클래스와 함수가 포함되어 있습니다.

<div class="content-ad"></div>

## 주요 진입 지점

- main_dev.dart: 개발 환경을 위한 진입 지점. 앱을 개발 설정으로 구성합니다.
- main_prod.dart: 프로덕션 환경을 위한 진입 지점. 앱을 프로덕션 설정으로 구성합니다.

# 결론

Clean Architecture를 사용하여 Flutter 프로젝트를 설정하고 구성하면 코드베이스가 확장 가능하고 유지 관리 가능하며 테스트할 수 있게 됩니다. 이 원칙을 따르고 프로젝트를 적절하게 구조화함으로써 복잡성을 관리하고 코드를 깔끔하고 모듈식으로 유지할 수 있습니다.

<div class="content-ad"></div>

# 다음은 무엇일까요?

다음 글에서는 "플러터의 클린 아키텍처 도메인 레이어 탐구"에 대해 더 자세히 다룰 예정입니다. 엔티티, 유즈 케이스 및 레포지토리를 정의하는 가장 좋은 방법과 예시 구현에 대해 논의할 것입니다. 계속 주목해 주세요!

# 이전 글

지나치셨다면, 클린 아키텍처 소개를 확인하여 클린 아키텍처와 그 원칙에 대한 개요를 얻어보세요.

<div class="content-ad"></div>

# 참고 자료

- Flutter Clean Architecture & TDD Course — Reso Coder
- Clean Coder Blog