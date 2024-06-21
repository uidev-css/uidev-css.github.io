---
title: "Flutter에서 Clean Architecture 시작하기"
description: ""
coverImage: "/assets/img/2024-06-21-IntroductiontoCleanArchitectureinFlutter_0.png"
date: 2024-06-21 20:21
ogImage: 
  url: /assets/img/2024-06-21-IntroductiontoCleanArchitectureinFlutter_0.png
tag: Tech
originalTitle: "Introduction to Clean Architecture in Flutter"
link: "https://medium.com/@baharudin-yusup/introduction-to-clean-architecture-in-flutter-41260acdda3d"
---



![Clean Architecture in Flutter](/assets/img/2024-06-21-IntroductiontoCleanArchitectureinFlutter_0.png)

Flutter는 빠르게 인기를 얻은 프레임워크로, 크로스 플랫폼 모바일 애플리케이션을 구축하는 데 사용됩니다. 사용하기 쉽고 강력한 기능으로 많은 개발자들에게 선택되는 이유입니다. 그러나 앱이 성장함에 따라 깨끗하고 확장 가능하며 테스트 가능한 코드를 유지하는 것이 어려워질 수 있습니다. 이때 Clean Architecture가 필요합니다.

# Clean Architecture란?

Clean Architecture는 로버트 C. 마틴 (Uncle Bob)이 만든 용어로, 관심사 분리를 촉진하여 시스템이 유지 가능하고 확장 가능하며 테스트 가능하도록 하는 소프트웨어 디자인 접근 방식입니다. 핵심 아이디어는 앱을 계층으로 나누어 각각에 특정 책임을 부여하여 내부 계층이 외부 계층에 의존하지 않도록 하는 것입니다.


<div class="content-ad"></div>

<img src="/assets/img/2024-06-21-IntroductiontoCleanArchitectureinFlutter_1.png" />

## Clean Architecture의 주요 원칙

- 염려 사항의 분리: 기능에 따라 응용 프로그램을 구분된 섹션으로 분할합니다. 이는 복잡성을 줄이고 코드 가독성을 향상시킵니다.
- 의존성 규칙: 모든 소스 코드 의존성은 내부로 향해야 합니다. 상위 레이어는 하위 레이어에 의존해서는 안 되며, 내부 레이어는 외부 레이어에 대해 알 필요가 없습니다.
- 프레임워크로부터 독립: 아키텍처는 특정 프레임워크의 존재에 의존해서는 안 됩니다. 이렇게 하면 시스템을 프레임워크에 의존시키는 대신에 도구로써 프레임워크를 사용할 수 있습니다.
- 테스트 가능성: 비즈니스 로직을 UI, 데이터베이스, 웹 서버 또는 다른 외부 요소 없이 테스트할 수 있어 자동화된 테스트가 쉬워집니다.
- UI의 독립성: UI를 변경할 때 시스템의 나머지 부분에 영향을 미치지 않습니다. 예를 들어, 웹 UI를 비즈니스 규칙을 변경하지 않고 콘솔 UI로 교체할 수 있습니다.
- 데이터베이스의 독립성: 비즈니스 규칙은 데이터베이스에 종속되지 않으므로 데이터베이스 간 쉬운 전환을 허용합니다.
- 모든 외부 기관의 독립성: 비즈니스 규칙은 외부 세계에 대해 아무것도 알지 못하도록 하여 일관성과 안정성을 보장합니다.

# Clean Architecture 코네

<div class="content-ad"></div>

Clean Architecture 콘은 Clean Architecture 원칙을 따라 설계된 시스템의 구조를 보여줍니다. 다이어그램에는 여러 원이 나란히 그려져 있습니다. 각각 다른 애플리케이션 계층을 나타냅니다. 최외부 원에는 저수준의 구체적인 세부 사항이 들어 있고, 최내부 원에는 고수준의 추상적인 정책이 포함되어 있습니다.

![Clean Architecture Cone](/assets/img/2024-06-21-IntroductiontoCleanArchitectureinFlutter_2.png)

## Clean Architecture Cone의 계층

- Entities (기업 비즈니스 규칙): 핵심 데이터 구조와 비즈니스 규칙을 나타냅니다. 이러한 계층은 매우 안정적이며 변경될 가능성이 매우 낮습니다.
- Use Cases (애플리케이션 비즈니스 규칙): 응용 프로그램별 비즈니스 규칙을 포함하며 엔티티 및 외부 세계 간 데이터 흐름을 조정합니다.
- Controllers, Gateways, Presenters (인터페이스 어댑터): UI와 비즈니스 로직 간 통신을 처리하고 계층 간 데이터를 적응시킵니다. 이는 상태 관리 솔루션 및 프레젠테이션 로직을 포함합니다.
- User Interface, Database, Devices (프레임워크 및 드라이버): 최외부 계층으로, 데이터베이스, 웹 프레임워크, UI, 장치 등과 같은 외부 요소를 포함합니다. 이 계층은 외부 세계와 상호 작용하며 변경될 가능성이 가장 높습니다.

<div class="content-ad"></div>

# 플러터에 Cone 적용하기

이제 이러한 개념들이 플러터 프로젝트로 어떻게 전환되는지 탐색해보겠습니다. Clean Architecture의 각 계층을 구체적인 구성 요소로 매핑하는 방법을 이해하면 견고하고 유지보수 가능한 애플리케이션을 구축하는 데 도움이 됩니다.

- 사용자 인터페이스, 데이터베이스, 장치: 플러터에서 이 계층은 플러터 SDK 자체, 외부 패키지 및 플러그인을 포함합니다. 예를 들어, 플러터 SDK에는 UI를 구축하는 위젯이 포함되어 있습니다.
- 컨트롤러, 게이트웨이, 프레젠터: 이 계층은 BLoC와 Provider와 같은 플러터의 상태 관리 솔루션을 포함하며 데이터 및 UI 상태의 흐름을 관리합니다.
- 사용 사례: 비즈니스 규칙을 처리하는 사용 사례 클래스를 사용하여 애플리케이션별 로직을 구현합니다.
- 엔티티: 핵심 데이터 구조와 비즈니스 규칙을 일반적인 Dart 클래스로 정의합니다.

# 실전에서의 의존성 규칙

<div class="content-ad"></div>

의존성 규칙은 모든 종속성이 안쪽으로 향해야 함을 보장합니다. 내부 원 안의 코드는 외부 원에 대해 아무것도 알지 못해야 합니다. 이 규칙을 준수하면 비즈니스 로직을 격리된 상태로 테스트하는 것이 더 쉬워지며, 내부 레이어에 영향을 주지 않고 외부 레이어를 변경하는 유연성이 향상됩니다.

# 플러터에서 클린 아키텍처의 장점

플러터 프로젝트에서 클린 아키텍처를 채택함으로써 다음과 같은 혜택을 누릴 수 있습니다:

- 향상된 코드 품질: 역할의 명확한 분리로 인해 더 깨끗하고 가독성 있는 코드를 작성할 수 있습니다.
- 쉬운 테스트: 레이어 간의 명확한 경계는 테스트를 작성하고 유지보수하기 쉽게 만듭니다.
- 더 나은 확장성: 모듈식 코드를 통해 새로운 기능을 추가하거나 변경을 가할 때 다른 부분에 영향을 주지 않고 진행할 수 있습니다.
- 향상된 유지보수성: 더 깔끔한 아키텍처는 코드를 이해하고 디버깅하며 확장하는 데 용이하게 만듭니다.

<div class="content-ad"></div>

# 결론

플러터에서의 Clean Architecture는 확장 가능하고 테스트 가능하며 유지보수가 용이한 애플리케이션을 구축하는 데 도움이 됩니다. 앱을 다양한 계층으로 분리함으로써 복잡성을 관리하고 코드를 깔끔하고 모듈화된 상태로 유지할 수 있습니다.

# 다음은 무엇인가요?

다음 기사에서는 "Clean Architecture로 플러터 프로젝트 설정 및 구성하기"를 안내해 드리겠습니다. 프로젝트 구조 설정, 의존성 구성, 그리고 깔끔하고 견고한 플러터 애플리케이션 구축에 시작하는 방법에 대해 다룰 것입니다. 기대해 주세요!

<div class="content-ad"></div>

# 참고 자료

- Clean Coder 블로그
- Clean Architecture에 대한 간단한 소개