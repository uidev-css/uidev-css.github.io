---
layout: post
title: "WooCommerce on CSS-Tricks"
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/07/woocommerce-poster.png"
tags: WOOCOMMERCE
---


저는 어떤 일을 성취할 때 항상 흥분하지만, 그 일을 완수하고 "음, 그건 쉬웠어요"라고 생각할 때, 저는 더 흥분합니다. 저는 기술을 만지작거리는 것을 즐기는 만큼 잘 세팅된 기술의 혜택을 더욱 누리고 있습니다. 그렇기 때문에 저는 여전히 워드프레스에 대해 매우 흥분하고 있습니다. 저는 엄청난 시간과 노력 없이 큰 일을 해낼 수 있다는 것이 매우 강력하다고 느낍니다.

지난달에 이곳 CSS-Tricks에 WooCommerce를 설치했을 때, 저는 바로 그 느낌을 받았습니다.

제가 어떻게 설정했는지 보여드리죠. 제가 하는 것보다 같은 일을 하고 이 설정을 훨씬 더 활용할 수 있는 많은 분들이 있을 테니까요!

### WooCommerce 기반 멤버십

당신이 회원 사이트를 갖고 싶다고 가정해 보자. 아마도 당신은 피트니스 웹사이트를 가지고 있고 훈련 비디오를 만들고 그 비디오와 훈련 연대를 표시하는 페이지에 대한 회원 자격 지불을 할 것이다. 또는 요리 웹 사이트가 있고 유료 회원은 저장된 쇼핑 목록과 같은 추가 기능에 액세스할 수 있습니다.

유료 회원을 위한 시스템을 갖는 것은 온라인에서 돈을 벌기 위한 기초적인 개념이며, 일반적으로 작은 일이 아니다. 다행히도, 우커머스는 그것을 재빨리 처리한다. (무료) WooCommerce 플러그인 외에 ($199) WooCommerce Memberships 플러그인이 필요합니다.

만약 당신이 WooCommerce의 유료 플러그 인이 소진된다면, 당신은 당신의 달력에서 7월 28일에 동그라미를 칠지도 모릅니다. 그날은 우커머스의 날인데 큰 폭의 판매가 있을 거예요.

이 기능을 설치하면 WooCommerce 영역 내에 WordPress 관리자에 Membership 탭이 표시됩니다. 회원 가입 계획 영역에는 계획을 설정할 수 있습니다. 우리는 매우 간단한 원플랜 설정을 가지고 있습니다: CSS-Tricks Member.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/07/Screen-Shot-2020-07-05-at-1.39.16-PM.png?fit=1024%2C690&ssl=1)

원한다면 다양한 계획을 세울 수 있습니다(예: 청동, 은,

이러한 계획은 아직 혼자서 모든 작업을 수행할 수 없습니다. 이러한 계획은 사용자 역할일 뿐이며 액세스 제어는 나중에 수행됩니다. 관리자만 사용자를 추가할 수 있고, 누구나 무료로 등록할 수 있으며, 가입하려면 제품을 구입해야 합니다. 마지막은 eCommerce 설정에 유용한 것입니다!

참고 사항으로, 구성원 자격의 기간을 제한할 수 있습니다. 무제한으로 만들 수는 있지만, 정해진 시간이 지나면 만료되는 회원 자격부터 시작하는 것이 더 현명할 수 있으므로 평생 약속할 수 있는 것은 아닙니다.

저는 멤버십을 판매하기 때문에, MVP 서포터라는 상품의 판매에 멤버십 플랜을 묶었습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/07/Screen-Shot-2020-07-05-at-1.45.09-PM.png?fit=1024%2C919&ssl=1)

그 멤버십 요금제에 접속하는 방법은 이 제품을 구입하는 것입니다. 또한 항상 수동으로 사용자를 관리자로 계획에 추가할 수 있습니다.

이 상품은 무제한 회원제 구상을 뒷받침하는 일회성 요금일 수 있었지만, 세상의 대부분의 회원제처럼 반복 요금제로 설정하고 싶었다. 그것은 우리가 약간의 추가 설정이 필요하다는 것을 의미한다.

### 회원 가입

나는 이것이 약간 혼란스럽다는 것을 알았다. 구성원 자격 플러그인이 해당 구성원 자격에 대해 반복 청구하는 아이디어를 지원할 수 있다고 가정할 수 있지만, 이는 즉시 수행되지는 않습니다. 이를 위해 두 번째 플러그인이 필요합니다. WooCommerce Subscriptions.

서브스크립션 플러그인은 또 다른 $199이므로 이 설정은 $400을 약간 부담합니다. 초기 비용만 내면 됩니다. 지원 및 업데이트가 필요한 경우 내년에 라이센스를 갱신하기만 하면 됩니다(원하는 바입니다). 저는 그 비용이 이렇게 효율적으로 작동하는 시스템에 비해 공정하다고 생각합니다. 하지만 여러분 자신을 위해 사업 계산을 해야 할 것입니다.

플러그인이 설치되면 생성하는 모든 제품이 구독 제품일 수 있습니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/07/Screen-Shot-2020-07-05-at-2.01.24-PM.png?resize=827%2C341&ssl=1)

여기 CSS-Tricks에서는 연간 20달러의 멤버십 비용을 청구합니다. 누군가가 가입하면 다음 해에 20달러로 재청구될 것이다. 그것은 회원 가입 계획의 길이와 일치하는데, 이것은 중요한 단계이다. 강요하는 것은 없지만 실제 갱신 날짜와는 다른 날짜에 요금을 부과하는 것은 이상할 것입니다.

### 회원 전용 게시물 액세스

설치의 가장 큰 두 가지 부분을 수행했습니다.

- 구성원 자격 계획 작성
- 해당 요금제에 가입하는 사람이 구입할 수 있는 제품 생성

이제 멤버들에게 어떤 혜택을 주는 부분에 대해서요! 저는 이 사이트에서 호스팅되는 "책"에 대한 액세스를 판매할 계획입니다. 그 책은 사실 게시물 모음집일 뿐이다. "Chapters"라고 하는 사용자 지정 게시 유형입니다. 장 편집기의 내용 아래에는 장을 회원제 계획에 잠그는 데 사용할 수 있는 회원제 영역이 있습니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/07/Screen-Shot-2020-07-05-at-2.13.57-PM.png?resize=801%2C510&ssl=1)

이 예에서는 사용자 지정 게시 유형을 사용하지만 모든 페이지 또는 게시 유형이 될 수 있습니다! 말 그대로 멤버십 벽 뒤에 무언가를 넣기 위한 스위치 뒤집기입니다.

콘텐츠 제한이 있는 게시물의 "면"에는 두 가지가 있습니다.

- 구성원이 보는 내용: 내용
- 비구성원이 보는 내용: 내용 잠금 해제 방법에 대한 발췌 및 메시지

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/07/Screen-Shot-2020-07-05-at-2.21.53-PM.png?fit=1024%2C948&ssl=1)

좋은 시스템인 것 같아요. 그것은 사람들에게 만약 그들이 회원이라면 무엇을 읽을 수 있는지 정확히 보여주고 어떻게 그들이 회원이 될 수 있는지를 보여준다.

이제 사용자 지정 CSS가 몇 개 발생하고 있지만, 많지 않습니다! 저는 단지 기본 기능을 사용하고, 페이지에 출력되는 내용을 확인합니다. 그리고 항상 적절한 클래스 이름이 있어야만 스타일링을 할 수 있습니다. 바로 그 방법이 바로 그것입니다.

### 구성원을 위해 프로그래밍 방식으로 작업 수행

우리의 경우, 회원이 되면 얻을 수 있는 가장 큰 혜택은 아마도 책에 접근할 수 있는 것이지만, 거기서 멈출 필요는 없다. 나는 유료 회원에게 가능한 한 많이 주는 것이 일반적으로 좋은 생각이라고 생각한다. 그리고 광고는 이 사이트의 주요 비즈니스 모델이기 때문에, 만약 당신이 유료 서포터즈 멤버십을 가지고 있다면, 그러한 광고를 없애는 것이 공평해 보입니다.

필요한 모든 것에 연결할 수 있는 다양한 종류의 API가 있습니다. 하지만 저는 가능한 한 간단하게 하는 것을 좋아합니다. 예를 들어, 템플릿에서 사용자가 회원인지 여부를 확인할 수 있습니다.

```php
<?php if ( !wc_memberships_is_user_active_member() ) { ?>
  <div>
     <!-- Show an ad if you're not a member. -->
  </div>
<?php } ?>
```

또한 다른 사이트의 JavaScript를 실행하기 전에 이 작업을 수행하므로 사용자가 회원인지 여부를 JavaScript에서 알 수 있습니다.

```php
<?php if ( wc_memberships_is_user_active_member() ) { ?>
    <script>
      window.activeMember = true;
    </script>
<?php } ?>
```

이 사이트의 일부 광고는 JavaScript로 구동되기 때문에 전혀 요청하지 않는 `!window.activeMember` 로 전화를 포장할 수 있습니다.

### 주문형 인쇄

회원가입과 가입은 제가 WooCommerce에서 하고 있는 일 중 두 가지에 불과합니다. 다른 하나는 제가 수년간 손봐온 물리적 제품을 판매하는 것입니다. 사실, 우리는 제품을 우체국에 가져가서 모든 주문을 수작업으로 처리하곤 했어요! 또한 과거에는 이행 업체와 파트너 관계를 맺었지만, 여전히 많은 인벤토리를 미리 인쇄해야 했습니다.

그 이후로 많은 일들이 일어났고, 온 디맨드로 인쇄하는 많은 회사들이 있습니다! 그런 회사 중 하나는 Printify입니다. 인쇄 회사에서 기대하는 것, 티셔츠, 후드티, 머그컵 등 온갖 종류의 물건을 팔고 있는데, 가장 좋은 점은 우커머스와 바로 연결된다는 것입니다.

지금까지, 우리는 가게에 포스터를 쌓아뒀어! Printify(인쇄) 측면에서는 제품을 선택하고, 예술을 업로드하고, 몇 가지 옵션을 선택하면 바로 그것입니다!

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/07/Screen-Shot-2020-07-06-at-3.14.30-PM.png?resize=2350%2C1578&ssl=1)

그 과정의 마지막 단계는 지금까지 저에게 완벽하게 효과가 있었던 "당신의 WooCommerce 스토어에 제품을 게시"하는 것입니다. Printify와 WooCommerce의 연결고리를 형성하고 있어야만 Printify가 주문을 받고 들어오면 이를 이행할 수 있기 때문에 효과가 있다고 믿습니다.

여기에서 제품이 내 사이트에 나타나고 필요한 경우 WordPress에서 편집하거나 사용자 정의할 수 있습니다(복사본 등).

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/07/Screen-Shot-2020-07-06-at-3.16.21-PM.png?fit=1024%2C505&ssl=1)

주문, 생산, 준비 및 배송되는 주문을 언제든지 확인하고 볼 수 있습니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/07/orders.png?fit=1024%2C417&ssl=1)

포스터도 제가 직접 주문했으니까, 다른 사람들 앞에 붙이기 전에 한번 써 볼 수 있을 것 같아요. 포스터는 두꺼운 밝은 흰색 종이 위에 완벽한 상태로 멋진 삼각형 모양의 튜브로 들어왔습니다. 사무실 컴퓨터 바로 옆에 걸어놨습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/07/IMG_3787.jpeg?resize=768%2C1024&ssl=1)

### 모바일 앱

저와 같이 작은 가게가 어떻게 돌아가는지 보고, 영업 알림을 받는다면, 모바일 앱이 있습니다.

주문 상태를 업데이트하거나 리뷰 등을 관리할 필요가 없었는데, 그것도 다 들어있어요.

여기엔 많은 기술이 적용되고 있어!

하지만 내 실제 시간 약속은 미미했다. 이 모든 eCommerce 관련 정보를 설정하는 것보다 블로그 게시물을 작성하는 데 더 오랜 시간이 걸렸습니다. 난 그저 통합자일 뿐이야 저는 어떤 것도 발명하지 않습니다. 단지 제 아이디어를 실현하기 위해 동급 최강의 소프트웨어를 이용하는 것입니다.