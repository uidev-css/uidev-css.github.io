---
title: "Flutter로 처음부터 앱 작성 시 고려할 사항 7가지"
description: ""
coverImage: "/assets/img/2024-06-21-FlutterconsiderationsforwritinganAppfromthescratch_0.png"
date: 2024-06-21 23:37
ogImage: 
  url: /assets/img/2024-06-21-FlutterconsiderationsforwritinganAppfromthescratch_0.png
tag: Tech
originalTitle: "Flutter: considerations for writing an App from the scratch"
link: "https://medium.com/stackademic/flutter-considerations-for-writing-an-app-from-the-scratch-1be5aec4dd76"
---


## 앱을 작성할 때 고려해야 할 주제

![image](/assets/img/2024-06-21-FlutterconsiderationsforwritinganAppfromthescratch_0.png)

앱을 작성한 지 여러 해가 지났습니다. 다양한 앱 템플릿을 구축했고, 다양한 패키지를 사용했습니다. 많은 변화가 있었지만 고려 사항은 동일한 비율로 변하지는 않았습니다. 몇 가지 패턴을 감지했습니다.

이 게시물에서는 내 생각을 체계적으로 정리하고, 처음부터 앱을 시작할 때 주의해야 할 사항 목록을 작성했습니다.

<div class="content-ad"></div>

- 귀하의 요구에 맞는 상태 관리 시스템을 선택하세요.
- 개발을 시작하기 전에 응용 프로그램의 아키텍처를 정의하세요.
- 미래에 쉽게 변경할 수 있도록 서드 파티 라이브러리를 래핑하세요.
- 처음부터 다국어 지원에 대비하세요.
- 응용 프로그램에 맞는 내비게이션 스키마를 선택하세요.
- 오류를 효과적으로 처리하여 원활한 사용자 경험을 보장하세요.
- 응용 프로그램을 활기차게 만들기 위해 뷰 레이아웃을 작성하세요.
- 로컬 데이터를 영구히 보관하고 필요에 따라 데이터 스키마를 업그레이드하는 방법을 정의하세요.
- 개발, 스테이징 및 프로덕션을 위한 다른 환경을 정의하세요.
- 문제를 쉽게 추적하고 수정할 수 있는 로그 메커니즘과 정책을 정의하세요.

# 상태 관리 선택

이것은 꼭 해야 할 일 중에 첫 번째라고 생각해요. 상태 관리는 귀하가 할 가장 중요한 결정입니다. 앱을 작성하는 방식을 결정하며, 클래스를 구성하는 방법을 결정합니다. 따라서 상태 관리를 선택하는 것은 중요합니다. 선택하지 않을 수 없습니다. 상태 관리는 Flutter 앱의 핵심이 되므로 중요합니다. 저는 BLoC 패턴을 좋아합니다만, 여러 옵션이 있습니다:

- Bloc
- Provider
- GetX
- Riverpod
- 기타

<div class="content-ad"></div>

제가 작성한 상태 관리에 관한 글을 확인해보세요:

# 아키텍처 정의

아키텍처는 코드를 구성합니다. 당신의 코드를 전문적으로 만들 뿐만 아니라 전문적으로 보이게 할 수 있습니다. 좋은 아키텍처는 재사용 가능하고 확장 가능하며 쉽게 유지 관리할 수 있는 코드를 제공해야 합니다. 현재 트렌드인 깔끔한 아키텍처를 선택할지라도, 응용 프로그램에 가장 적합한 것을 선택하되, SOLID 원칙을 무시하지 말아야 합니다.

이에 대해 이야기한 글을 작성했습니다:

<div class="content-ad"></div>

# 외부 라이브러리 래핑하기

이거 좋아요. 이 방법은 외부 라이브러리를 자신의 코드에서 분리하는 쉬운 방법이에요.

이렇게 하는 대신에:

```js
ThirdPartyLibrary.doSomething();
```

<div class="content-ad"></div>

여기 변경하세요:


MyWrapperOfThirdPartyLibrary.doSomething();

...

class MyWrapperOfThirdPary{
  public void doSomething(){
    ThirdPartyLibrary.doSomething();  
  }
}


# 멀티 언어를 지원할 앱을 준비하세요

이것은 여러 언어로 확장 가능한 앱으로 변화시키기 위해 시간을 소모하면서 낮은 노력으로 자원을 투자할 수 있는 한 가지 방법입니다.

<div class="content-ad"></div>

# 네비게이션 스키마 선택

네비게이션 흐름을 먼저 정의해야 합니다. 네비게이션은 앱을 조직하는 데 사용되며, 이를 해결하는 여러 패키지를 활용해야 합니다.

저는 다양한 방식을 사용해왔지만, 최근 앱에서는 Go Router를 선택했습니다. 이는 깔끔하고 쉽습니다.

# 에러 처리하기

<div class="content-ad"></div>

에러를 어떻게 처리할지 정의해야 합니다. 에러는 발생할 수 있으며, 방치해서는 안 됩니다.

저는 앱에서 에러를 처리하는 데 데코레이터를 정의했습니다:

# 뷰를 위한 레이아웃 만들기

뷰를 범주별이나 유형별로 구성하면 재사용성이 향상됩니다. 각 유형의 페이지를 위한 템플릿이나 레이아웃을 만들고 여러 뷰에서 사용할 수 있습니다. 이렇게 하면 변경 사항을 구현하기가 더 쉬워집니다.

<div class="content-ad"></div>

레이아웃에 관한 내 게시물을 확인해보세요:

# 로컬 데이터를 유지하는 방법 정의

요즘에는 로컬 데이터를 관리하는 것이 매우 유용합니다. 사용자에게 오프라인 사용 가능성을 제공해야 하는 방법입니다. Shared Preferences와 같이 간단할 수도 있고, 데이터베이스와 같이 더 복잡할 수도 있습니다.

데이터베이스를 사용해야 하는 경우에는 해당 로컬 데이터베이스의 스키마를 업그레이드하는 메커니즘을 정의해야 합니다. 상상할 수 있겠지만, 이미 이에 대해 글을 썼습니다:

<div class="content-ad"></div>

# 다양한 환경을 정의하세요: 개발, 스테이징, 프로덕션

앱을 개발할 때 유용하고 필수적입니다. 환경을 청결하게 관리할 수 있어야 합니다. 몇 가지 변수를 변경하면 스테이징 또는 프로덕션으로 전환할 수 있습니다.

물론, 이에 대해 이야기한 포스트가 있습니다!

# 로그 메커니즘 및 정책을 정의하세요

<div class="content-ad"></div>

앱에 로그를 갖는 것이 매우 중요해요. 문제가 발생하고 문제가 있을 거에요. 이를 감지할 준비를 해야 해요. 처음부터 메커니즘을 정의하면 쉬울 거에요.

여러 접근 방식과 앱 메시지를 로깅하는 다양한 패키지를 찾을 수 있어요.

저는 그에 대해 이야기한 게시물이 있어요.

# 결론

<div class="content-ad"></div>

- 신선한 공기를 마시고 생각해보세요.
- 미친 듯이 앱 작성을 시작하지 마세요.
- 핵심 주제에 대해 생각하고 어떻게 관리할지 정의해보세요.

읽어주셔서 감사합니다. 좋았다면 박수를 쳐주세요!

![이미지](/assets/img/2024-06-21-FlutterconsiderationsforwritinganAppfromthescratch_1.png)

아래에 의견을 남겨주세요.

<div class="content-ad"></div>

# Stackademic 🎓

끝까지 읽어 주셔서 감사합니다. 떠나시기 전에:

- 클로밍하고 작가를 팔로우해주시면 감사하겠습니다! 👏
- 다음 사이트도 팔로우해주세요: X | LinkedIn | YouTube | Discord
- 다른 플랫폼도 방문해보세요: In Plain English | CoFeed | Venture | Cubed
- 알고리즘 콘텐츠를 다루는 블로깅 플랫폼에 지쳤나요? Differ를 시도해보세요.
- Stackademic.com에서 더 많은 콘텐츠를 만나보세요.