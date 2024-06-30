---
title: "모바일 개발 탐색 플랫폼, 아키텍처, 그리고 HNG 인턴십 경험기"
description: ""
coverImage: "/assets/img/2024-06-30-NavigatingMobileDevelopmentPlatformsArchitecturesandMyJourneywithHNGInternship_0.png"
date: 2024-06-30 18:45
ogImage: 
  url: /assets/img/2024-06-30-NavigatingMobileDevelopmentPlatformsArchitecturesandMyJourneywithHNGInternship_0.png
tag: Tech
originalTitle: "Navigating Mobile Development: Platforms, Architectures, and My Journey with HNG Internship."
link: "https://medium.com/@adewoleemmanuel36/navigating-mobile-development-platforms-architectures-and-my-journey-with-hng-internship-3ead41159dfa"
---


# 소개

![이미지](/assets/img/2024-06-30-NavigatingMobileDevelopmentPlatformsArchitecturesandMyJourneywithHNGInternship_0.png)

모바일 개발은 계속적인 학습과 적응이 필요한 동적이고 빠르게 변화하는 분야입니다. HNG 인턴십과 함께하는 내 여정을 시작하면서, 특히 이 산업을 형성하는 플랫폼 및 일반적인 소프트웨어 아키텍처 패턴에 초점을 맞춰 모바일 개발 세계에 대한 인사이트를 공유하고자 합니다.

# 섹션 1: 모바일 개발 플랫폼 이해하기

<div class="content-ad"></div>

## iOS 개발:

![이미지](/assets/img/2024-06-30-NavigatingMobileDevelopmentPlatformsArchitecturesandMyJourneywithHNGInternship_1.png)

설명: 애플이 개발한 iOS는 iPhone 및 iPad 같은 기기를 작동시킵니다.

사용된 프로그래밍 언어: 개발자들은 Swift 또는 Objective-C를 사용하여 Xcode IDE에서 애플리케이션을 만듭니다.

<div class="content-ad"></div>

장점:
- 뛰어난 성능과 보안.
- 강력한 개발자 지원 및 방대한 문서.
- 앱에 지출할 의사가 있는 수요가 많고 수익성 높은 시장 접근.

단점:
- 개발을 위해 Mac이 필요합니다.
- 앱 스토어 승인 프로세스가 엄격하고 시간이 많이 소요될 수 있습니다.
- 안드로이드에 비해 제한된 사용자 정의 기능이 있습니다.

## ``안드로이드 개발:

<img src="/assets/img/2024-06-30-NavigatingMobileDevelopmentPlatformsArchitecturesandMyJourneywithHNGInternship_2.png" />

Description: Google이 개발한 안드로이드는 다양한 기기에서 사용되는 오픈 소스 플랫폼입니다.

<div class="content-ad"></div>

프로그래밍 언어 사용: 주로 안드로이드 스튜디오에서 Java 또는 Kotlin을 사용하여 개발합니다.

장점:
- 다양한 기기 호환성과 대규모 사용자 베이스.
- 높은 맞춤 및 유연성.
- 다중 앱 스토어를 통한 쉬운 앱 배포.

단점:
- 기기 및 OS 버전 간의 단편화로 인한 도전.
- 플랫폼의 개방적인 특성으로 인한 보안 문제.
- 다양한 기기로 인한 테스트의 복잡성.

## "크로스 플랫폼 개발:"

<div class="content-ad"></div>


![image](/assets/img/2024-06-30-NavigatingMobileDevelopmentPlatformsArchitecturesandMyJourneywithHNGInternship_3.png)

Description: 이름에서 알 수 있듯이, 크로스 플랫폼 접근법은 단일 코드 베이스를 사용하여 다양한 모바일 플랫폼에서 유사하게 작동하는 앱을 개발할 수 있게 합니다.

사용된 프로그래밍 언어: React Native, Flutter, Xamarin과 같은 크로스 플랫폼 프레임워크를 사용하여 iOS 및 Android용 앱을 개발할 수 있습니다.

장점:
- 여러 플랫폼 간에 코드를 공유하여 시간과 자원을 절약합니다.
- 보다 쉬운 유지보수 및 업데이트가 가능합니다.
- 더 적은 노력으로 보다 넓은 관객에게 접근할 수 있습니다.


<div class="content-ad"></div>

단점:
- 성능이 원래 앱보다 최적화되지 않을 수 있습니다.
- 플랫폼별 기능에 제한적인 액세스.
- 프레임워크의 지원 및 커뮤니티에 의존.

# 섹션 2: 모바일 개발에서 일반적인 소프트웨어 아키텍처 패턴

## `모델-뷰-컨트롤러 (MVC):

![이미지](/assets/img/2024-06-30-NavigatingMobileDevelopmentPlatformsArchitecturesandMyJourneywithHNGInternship_4.png)

<div class="content-ad"></div>

안녕! 아래는 애플리케이션을 세 가지 상호연결된 구성 요소로 분리하는 설명이에요:
- Model (데이터),
- View (UI),
- Controller (로직).

장점:
- 개발 및 유지 관리를 간편하게 해줘요.
- 관심사 분리가 명확해져요.
- 재사용 가능한 컴포넌트를 활용할 수 있어요.

단점:
- 복잡한 애플리케이션에서 대형 뷰 컨트롤러로 이어질 수 있어요.
- 구성 요소 간의 강한 결합이 유연성을 방해할 수 있어요.

## ``Model-View-ViewModel (MVVM):``

<div class="content-ad"></div>

아래는 Markdown 형식으로 변환되었습니다:

![image](/assets/img/2024-06-30-NavigatingMobileDevelopmentPlatformsArchitecturesandMyJourneywithHNGInternship_5.png)

설명: 프레젠테이션 로직을 처리하는 ViewModel 레이어를 추가하여 관심사의 분리를 강화합니다.

장점:
- 향상된 테스트 가능성 및 유지 관리성.
- MVC보다 더 나은 관심사의 분리.
- 복잡한 UI를 관리하기가 더 쉬움.

단점:
- ViewModel 추가로 복잡성이 증가.
- 초심자에게는 높은 학습 곡선.

<div class="content-ad"></div>

## Clean Architecture:

![Clean Architecture](/assets/img/2024-06-30-NavigatingMobileDevelopmentPlatformsArchitecturesandMyJourneywithHNGInternship_6.png)

Description: 관심사의 분리와 프레임워크의 독립성을 강조하여 코드를 레이어로 구성합니다(프레젠테이션, 도메인, 데이터).

장점:
-높은 테스트 용이성과 유지 보수성.
-책임의 명확한 분리.
-앱을 더 유연하게 만드는 프레임워크와의 독립성.

<div class="content-ad"></div>

단점:
- 더 가파른 학습 곡선 및 구현이 더 복잡합니다.
- 간단한 애플리케이션에는 오버 엔지니어링으로 이어질 수 있습니다.

# 섹션 3: HNG 인턴십과 함께 하는 나의 여정

Flutter로 시작한 신진 모바일 개발자로서, HNG 인턴십과의 여정을 시작하게 되어 기쁩니다. 그들에 대해 많은 이야기를 듣고, 인턴십이 얼마나 도전적인지 알고 있지만, 나는 도전을 좋아합니다. 이 기회는 기술에 대한 나의 열정과 모바일 개발 지식을 더 깊이 알고 싶은 욕구와 완벽하게 부합합니다.

이 인턴십을 통해 나는 다음을 목표로 합니다:

<div class="content-ad"></div>

- 나의 스킬 향상: 실제 프로젝트를 통해 실무 경험을 쌓고 산업 전문가로부터 배우세요.
- 네트워크 확장: 비슷한 목표를 갖고 있는 동료와 멘토들과 연결하여 경력에 대한 조언을 받고 그들의 재능 풀에서 최고의 재능으로 성장하세요.
- 포트폴리오 구축: 나의 능력과 창의성을 보여주는 애플리케이션을 개발하세요.
- 커뮤니티 기여: 내 학습 내용을 공유하고 다른 사람들의 개발 여정을 돕습니다.

HNG 인턴십은 능숙한 모바일 개발자가 되기 위한 제 목표를 이루는 한 걸음입니다. 이러한 도전과 기회를 함께해 주기를 고대하고 있습니다.

트위터에서 저와 연락하세요.