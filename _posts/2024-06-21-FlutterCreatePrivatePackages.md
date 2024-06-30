---
title: "Flutter 프라이빗 패키지 만드는 방법"
description: ""
coverImage: "/assets/img/2024-06-21-FlutterCreatePrivatePackages_0.png"
date: 2024-06-21 20:13
ogImage:
  url: /assets/img/2024-06-21-FlutterCreatePrivatePackages_0.png
tag: Tech
originalTitle: "[Flutter] Create Private Packages"
link: "https://medium.com/@fz3hra/flutter-create-private-packages-a9eb2504e60e"
---

![Flutter Create Private Packages](/assets/img/2024-06-21-FlutterCreatePrivatePackages_0.png)

Flutter 패키지와 함께한 나의 여정은 처음부터 하나를 만들어야 했을 때 시작되었습니다. 오늘은 이 주제에 대한 나의 경험과 통찰을 공유하는 것에 흥분하고 있습니다. Google I/O’23에서도 이에 대해 논의했지만, 여기에서는 개념을 이해하고 자신만의 패키지를 구축하려는 분들을 위한 내용입니다.

# 패키지와 플러그인 이해

<div class="content-ad"></div>

패키지는 라이브러리, 리소스, 앱, 테스트, 이미지, 글꼴 및 예시로 이루어진 다트 코드의 자체 포함 컬렉션이에요. 이것들은 어떤 네이티브 플랫폼에도 독립적이에요. 예를 들어, UI 구성 요소의 구현에 사용될 수 있어요.

플러그인

플러그인은 플랫폼별 및 다트 코드로 작성된 API를 포함하고 있어요. 플러그인은 카메라와 같은 기기 특성에 접근하기 위해 필수적이에요.

# 의존성 관리

<div class="content-ad"></div>

패키지 생성의 구성을 자세히 살펴보기 전에 의존성 관리가 무엇인지 이해하는 것이 중요합니다. 개발자들이 플러터 프로젝트에서 사용할 수 있는 의존성을 추적하고 관리할 수 있도록 해줍니다. 이를 통해 프로젝트에 빠르게 기능을 구현할 수 있는 패키지의 버전을 추적하고, 이러한 패키지들이 서로 호환되도록 보장할 수 있습니다.

프로젝트에 패키지가 추가되면 의존성이 됩니다. 세 가지 유형의 의존성 구성이 있습니다:

- dependencies
- dev dependencies
- dependency overrides

이 구성 간의 차이는 간단합니다:

<div class="content-ad"></div>

- dependencies와 dependency_overrides은 컴파일 후 프로젝트에서 사용할 수 있는 패키지입니다.
- dev_dependencies은 개발 환경에서만 사용할 수 있습니다.

의존성 분류

의존성은 다음과 같이 분류할 수 있습니다:

- 중간 의존성: 프로젝트와 직접 관련된 의존성입니다.
- 전이적 의존성: 다른 패키지에 의존하는 패키지입니다.

<div class="content-ad"></div>

# 버전 관리

의존성이 추가되고 제약 조건과 함께 추가되었을 때, 앱에서 생성된 락 파일은 추가된 특정 버전만 사용합니다.

![image](/assets/img/2024-06-21-FlutterCreatePrivatePackages_1.png)

위의 예시 이미지를 살펴보면, package_a 및 package_c가 의존성에 추가되었으며, package_b는 개발 의존성에 있고 package_c는 의존성 재정의에 있습니다. 락 파일은 "의존성"에 추가된 것이 아닌 버전 2.1.0의 Package_c를 사용할 것입니다.

<div class="content-ad"></div>

# 플러터 패키지 만들기

자, 이제 실제 플러터 패키지를 만드는 과정에 대해 알아봅시다. 다음 명령어를 사용하여 패키지를 생성하세요:

```bash
flutter packages pub publish
```

- [packages] — 플러터 프로젝트에서 패키지를 관리합니다.
- [pub] — 패키지에 문제나 누락된 정보를 확인하는 데 사용되는 유효성 검사기입니다.
- [publish] — 패키지를 게시하는 명령어입니다.

<div class="content-ad"></div>

패키지는 사용 사례에 따라 공개적으로 또는 비공개적으로 배포할 수 있습니다. 비공개 패키지는 pub.dev에 게시할 수 없습니다. 대신 GitHub와 같은 플랫폼이나 서비스로 다트 저장소에 호스팅할 수 있습니다. 일부 서비스로는 다음이 있습니다:

- OnePub
- Cloudsmith
- Ifrog 저장소
- Jetbrains Space

# OnePub을 활용하기

OnePub에 연결하여 패키지를 게시하려면 다음 단계를 따르세요:

<div class="content-ad"></div>

```js
flutter pub global active onepub
cd <내 패키지>
flutter pub publish
```

패키지를 비공개로 호스팅하려면 publish를 사용해 저장소를 가리키도록합니다:

![이미지](/assets/img/2024-06-21-FlutterCreatePrivatePackages_2.png)

한 번 발행되면 패키지를 비공개로 호스팅하여 권한이있는 사용자에게만 액세스 가능하도록 할 수 있습니다.

<div class="content-ad"></div>

<img src="/assets/img/2024-06-21-FlutterCreatePrivatePackages_3.png" />

# 보안 고려 사항

- 어택에게 코드를 역공학으로 복원하기 어렵게 만들기 위해 --obfuscate를 사용하세요.
- 보안 취약점이 소개되지 않도록 코드와 종속성을 자주 검토하세요.
- 제 3자 종속성을 사용할 경우 보안 및 취약성을 확인하세요.
- 공격자가 미인가된 액세스를 얻지 못하도록 민감한 정보를 삭제하세요.
- 취약점을 검사하여 보안 문제를 식별하고 해결하는 데 도움이 됩니다.

여기서 플러터 패키지를 만드는 방법에 대해 알아보았습니다. 필요한 경우 댓글에서 추가로 의견을 남겨주세요. 함께 학습할 수 있도록 도와드리겠습니다.

<div class="content-ad"></div>

# 참고 자료

패키지 발행하기

Dart 패키지를 pub.dev에 발행하는 방법을 배우세요.

![이미지](/assets/img/2024-06-21-FlutterCreatePrivatePackages_4.png)

<div class="content-ad"></div>

```js
Dart

![image](/assets/img/2024-06-21-FlutterCreatePrivatePackages_5.png)

Developing packages & plugins

How to write packages and plugins for Flutter.
```

<div class="content-ad"></div>

아래가 markdown 형식으로 변환됐습니다.

![Flutter Logo](/assets/img/2024-06-21-FlutterCreatePrivatePackages_6.png)

![Package dependencies](/assets/img/2024-06-21-FlutterCreatePrivatePackages_7.png)

<div class="content-ad"></div>

앱에 다른 패키지를 추가해보세요. 패키지 위치, 버전 제한 등을 명시하세요.

![image1](/assets/img/2024-06-21-FlutterCreatePrivatePackages_8.png)

Dart

![image2](/assets/img/2024-06-21-FlutterCreatePrivatePackages_9.png)

<div class="content-ad"></div>

저에 대해

안녕하세요! 제 이름은 Zaahra입니다. 구글 Women Techmakers 대사로 활동하고 있습니다. 사람들을 지도하고 기술적인 내용을 쓰는 것을 즐기며, 개발자로서 여러분의 여정을 도울 수 있는 기술 콘텐츠에 대해 글을 쓰는 것을 즐깁니다. 또한 실생활 문제를 해결하기 위해 무언가를 만드는 것을 즐깁니다.

제게 연락하려면:

<div class="content-ad"></div>

마크다운 형식으로 변환하겠습니다.

LinkedIn: [https://www.linkedin.com/in/faatimah-iz-zaahra-m-0670881a1/](https://www.linkedin.com/in/faatimah-iz-zaahra-m-0670881a1/)

X (이전 Twitter): \_fz3hra

GitHub: [https://github.com/fz3hra](https://github.com/fz3hra)

건배,

<div class="content-ad"></div>

Umme Faatimah-Iz-Zaahra Mujore | Google Women TechMakers 대사 | 소프트웨어 엔지니어
