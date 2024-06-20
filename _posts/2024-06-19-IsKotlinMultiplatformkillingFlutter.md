---
title: "코틀린 멀티플랫폼이 플러터를 죽일까요"
description: ""
coverImage: "/assets/img/2024-06-19-IsKotlinMultiplatformkillingFlutter_0.png"
date: 2024-06-19 00:14
ogImage: 
  url: /assets/img/2024-06-19-IsKotlinMultiplatformkillingFlutter_0.png
tag: Tech
originalTitle: "Is Kotlin Multiplatform killing Flutter?"
link: "https://medium.com/@thomasmiddel/is-kotlin-multiplatform-killing-flutter-c35f7a06e0ac"
---



<img src="https://miro.medium.com/v2/resize:fit:1400/1*9tMerLCXlni2rnhmZXZKRQ.gif" />

현재 크로스 플랫폼 솔루션의 옵션들은 무수히 많습니다. 솔직히 말해서, 옳고 그른 것은 없죠. KMP와 Compose은 플러터에게 심각한 위협으로 보입니다. 하지만 걱정해야 할 문제인지, 또는 그들이 공존할 수 있는 중요한 차이가 있는지에 대해 이야기해 봐야 할 것 같습니다.

언제나 그런 질문 중 하나죠: "왜 플러터를 선택해야 하나요?", "플러터가 ...보다 뛰어나나요?" 그리고 항상 다음과 같이 친절히 말씀드리겠습니다. (아니, Ionic이나 Cordova와 같은 웹 기반 프레임워크를 선택하지 않는 한) 옳고 그른 대답은 없다는 거 말이죠. (모바일 개발이라고 부를 수 있을까요?)

저는 플러터를 좋아하지만, 만약 그게 무리하다면 강요하지는 않을 거에요. 이미 존재하는 제품, 기술 스택, 팀, 또는 스킬셋을 고려해보면 React Native와 같은 것을 사용하는 것이 더 합리적일 수 있어요. 그렇지 않으면 플러터 지식을 가진 새로운 개발자를 고용해야 하거나, 기존 팀에 교육을 받게 해야 하거나, 혹은 직접 공부를 해야 할 수도 있어요. 재미있긴 하지만, 비즈니스적으로 항상 합당한 이유는 아니거든요.


<div class="content-ad"></div>

지금, Kotlin Multiplatform을 사용하면 다른 또 하나의 후보가 나타나면서 여러분에게 가장 먼저 선택받고 싶어합니다. 하지만 여러분은 그를 선택해야 하는 이유가 무엇일까요?

Kotlin Multiplatform은 안드로이드, iOS, 데스크톱 및 웹과 같이 여러 플랫폼에서 기능하며, 플러터와 같이 작동합니다. 그러나 이는 UI 프레임워크가 아닙니다. Kotlin Multiplatform을 사용하면 여러 플랫폼에 배포할 비즈니스 로직을 모두 작성할 수 있지만, 지원하려는 각 플랫폼마다 별도의 UI 레이어를 작성해야 합니다.
반면 플러터는 비즈니스 로직부터 UI까지 코드를 한 번만 작성하고 각 플랫폼에 배포하는 완전한 크로스 플랫폼 프레임워크입니다.

이 중요한 차이점이 여러분에게 명확한 선택을 제시하고, 그들의 조화로운 공존을 '증명'해줄 것입니다. 구글 자체도 이 분리와 기술 선택을 지지합니다:

- 여러 플랫폼 간에 비즈니스 로직을 공유해야 한다면 Kotlin Multiplatform을 선택하세요.
- 여러 플랫폼 간에 비즈니스 로직과 UI를 공유하고 모든 것에 대해 단일 코드베이스를 갖길 원한다면 플러터를 사용하세요.

<div class="content-ad"></div>

## 그런데 Compose Multiplatform은 어떨까요?

Kotlin Multiplatform과 Flutter의 차이점은 명확하지만, JetBrains의 크로스 플랫폼 UI 기술인 Compose Multiplatform을 추가해보면 어떨까요?

지금으로부터 Compose Multiplatform은 아직 진행 중인 프로젝트입니다. 안정적인 Android 및 데스크톱 플랫폼용으로 사용할 수 있지만, 웹에서는 알파 단계이며 iOS에서는 베타 단계입니다. 이런 의미에서 현재 플러터가 더 나은, 보다 성숙한 옵션임은 분명합니다. 그럼에도 Compose Multiplatform이 어떻게 발전해 나갈지 궁금합니다. 둘 다 캔버스에 픽셀을 그리는 기술을 사용한다는 점, React Native와 같은 프레임워크처럼 네이티브 컴포넌트로의 브리징이 아닌 점, 선언형 UI 및 강력한 유형 언어를 사용한다는 공통점이 있으며, 두 스택 모두 풀 스택 개발에 적합하며 기존 네이티브 앱과의 상호 운용성을 제공합니다. 비슷한 플랫폼에 공간이 있을까요?

## 플러터를 버려야 할까요?

<div class="content-ad"></div>

Compose Multiplatform은 확실히 유망해 보여요. Flutter가 어떻게 될지는 Flutter의 현재 채택 정도, 커뮤니티 지원과 참여(매우 좋은 편!), Compose의 추가 혜택과 성능, 그리고 Compose Multiplatform의 내부 아키텍처에 달려 있어요. Flutter는 새 플랫폼을 지원해야 할 때 작은 플랫폼별 레이어만 작성하면 되도록 설정되어 있어요. Flutter는 각 플랫폼에서 같은 것을 활용하면서 자체 엔진을 실행하며, 차이는 플랫폼 자체와의 작은 통신 레이어뿐이에요. 이는 Flutter가 빠르게 움직일 수 있고 매우 유연한 솔루션이라는 것을 의미해요. 그래서 안드로이드나 iOS가 언젠가 없어진다 해도 Flutter 사용에 큰 지장이 없을 거예요. 이외에도, Skia 렌더링 엔진에서 Compose가 사용하는 Impeller 렌더링으로 전환함으로써 다른 솔루션과 다른 차이점을 만들어 더 향상된 것이 좋았어요.

동시에 기존 네이티브 플랫폼과의 상호 운용성은 때로 어려울 수 있는데, Compose Multiplatform이 활용하는 솔루션이 아주 쉽고 매끄러운 설정인 것으로 보여요. 또한, Compose Multiplatform이 가진 이점 중 하나는 이미 프레임워크 채택 시 기존 개발자 풀에서 고를 수 있다는 점이에요. 안드로이드는 여러 해 동안 Kotlin을 실행해왔고, Compose는 2021년부터 그들의 네이티브 솔루션이었기 때문에 Compose Multiplatform 및 Kotlin Multiplatform에 익숙한 개발자들이 이미 많이 존재해요.

지금은 걱정할 필요가 없어요, 구글도 최근 블로그 중 하나에서 그렇다고 말하고 있어요. 하지만 개발 상황을 주의 깊게 지켜보세요. Flutter는 안전한 선택이지만 결국 치열한 경쟁이 될 수도 있어요. 하지만 결국 Flutter는 문제에 대한 해결책일 뿐이에요, 그리고 새로운 프레임워크들이 계속해서 등장해 같은 질문들을 던질 겁니다. 누가 다음 핫한 새로운 주인공이 될지 아무도 모르죠!

지금까지 읽어주셔서 감사해요! 제 팔로우를 시작해주시면 정말 도움이 될 거예요 🙏 이미 했나요? 함께 해 주셔서 감사해요! 이런 기사들을 놓치고 싶지 않다면 알림을 받도록 구독해주세요.

<div class="content-ad"></div>

열정적으로 지속하고, 배고픈 마음을 잃지 말고, 코딩을 계속해보세요 🐦