---
layout: post
title: "종이 프로토타입 규칙"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/09/paper-waves.jpg
tags: ANIMATION
---


저는 운이 좋게도 제냐 린주크, 루이 파케, 마리아 데 라 파즈 바르가스, 그리고 미디어몽크에서 수십 명의 놀라운 디자이너들과 함께 일했습니다. 우리가 작업한 많은 프로젝트들은 개발자들이 완전히 창의적이고 CSS와 JavaScript로 가능하다고 생각하는 것의 한계를 뛰어넘을 수 있도록 하는 맞춤형 애니메이션과 가이드라인을 필요로 한다.

그리고 자원이 부족한 다른 프로젝트도 있습니다. 이러한 것들은 개발자로서 특정 UI 요소가 어떻게 애니메이션화되는지, 그리고 우리가 만든 가이드라인이 훌륭한 사용자 환경에 보탬이 되는지에 대해 주도적으로 설명할 수 있는 기회가 될 것입니다. 이러한 프로젝트들은 일반적으로 간단한 트릭이 우리가 올바른 방향으로 가고 있는지 판단하는 데 도움이 되는 프로젝트입니다.

저는 우연히 제 애니메이션이 적중했는지 빠르게 테스트하는 데 도움이 되는 간단한 트릭을 하나 갖게 되었습니다. 지금 당신과 공유하고 싶습니다. 저는 이것을 종이 프로토타입 규칙이라고 부릅니다.

### 인쇄 사고방식

웹 디자인(아마도 무의식적으로)은 인쇄 디자인으로부터 많은 것을 물려받는다. 생각해보면, 아코디언이나 탭과 같은 가장 기본적인 상호 작용적인 웹 패턴은 우리가 과거에 물리적으로 정보를 저장했던 방식을 디지털로 표현한 것입니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/09/cq8kLskr.jpeg?resize=700%2C350&ssl=1)

비록 산업이 디지털 우선주의 사고방식을 더 많이 취했고 지난 10년 동안 인쇄 패러다임을 넘어섰지만, 우리는 종종 그러한 인쇄 사고방식을 벗어나기 위해 고군분투합니다. 개발자로서, 마치 우리가 움직이는 종이 조각의 기준을 넘지 않는 지루한 표준 방식으로 UI 요소에 연결된 것처럼 느낄 수 있습니다.

### 종이 프로토타입 규칙

저는 몇 년 동안 다른 사람들과 함께 일하면서 몇 가지 조언과 모범 사례를 찾아냈고, 그것들을 애니메이션으로 작업하기 위한 몇 가지 간단한 규칙으로 발전시켰습니다. 저는 규칙을 지침이나 개인 참고 자료로 더 많이 고려하지만, 최근 팀원들에게 규칙을 전달함으로써 더 많은 가치를 창출하고 있습니다.

그리고 다음과 같은 내용을 담은 종이 프로토타입 규칙 덕분입니다.

> 종이 프로토타입을 사용하여 애니메이션을 재생성할 수 있다면 애니메이션에 더 많은 시간을 할애해야 할 것입니다.

애니메이션을 지나치게 복잡하게 만드는 것이 아니라 인쇄 컨셉에서 나온 디지털 경험을 만드는 이점을 수용하는 것이 목적입니다. 그리고 그 원리는 꽤 간단합니다. 애니메이션을 종이로 프로토타이핑할 수 있습니까? 만약 그렇다면, 우리는 더 잘 할 수 있어요. 만약 안된다면, 우린 뭔가 할 수 있어.

### 실제 종이 프로토타입 규칙

오해하지 마세요. 종이 프로토타이핑은 사용자 테스트를 위한 훌륭한 도구임이 입증되었습니다. 하지만 우리는 그 성질의 단순함을 이용하여 우리의 상호작용이 너무 단순한 때를 결정할 수 있습니다.

예를 들어보자.

거의 모든 표준 웹사이트는 일종의 네비게이션을 가지고 있다. 그러면 활성 및 비활성 탐색 상태 모두에 대한 방향을 제공하는 설계 컴파일을 상속한다고 가정해 보겠습니다. 네, 그렇게 할 수 있어요. 그렇게 어렵지 않아요.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_GRoGaVQ" src="//codepen.io/anon/embed/GRoGaVQ?height=450&amp;theme-id=1&amp;slug-hash=GRoGaVQ&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed GRoGaVQ" title="CodePen Embed GRoGaVQ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이 경험을 인쇄물로 복제할 수 있습니까? 물론 할 수 있습니다. 한 장의 종이를 다른 종이 위에 쌓기만 하면 됩니다. 우리는 더 잘 할 수 있다.

우리가 받은 comp들이 열린 메뉴 상태와 닫힌 메뉴 상태 사이의 전환에 대한 어떤 방향도 부족하다고 가정하면, 우리는 변환 속성으로 애니메이션을 더 잘 만들 수 있다. 이것만으로도 환경이 크게 개선됩니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_WNrgjmz" src="//codepen.io/anon/embed/WNrgjmz?height=450&amp;theme-id=1&amp;slug-hash=WNrgjmz&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed WNrgjmz" title="CodePen Embed WNrgjmz" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

메뉴의 활성 상태를 왼쪽에서 오른쪽으로 간단히 슬라이딩하면 사용자가 전환을 이해하는 데 도움이 되고 현재 위치에 대한 컨텍스트를 제공할 수 있습니다. 메뉴가 페이지 내용을 포함하는 오버레이임은 의심의 여지가 없습니다. 우리가 변형을 추가하기 전에는 분명하지 않았다. 간단한 CSS 라인으로 우리는 지금 일을 마무리하고 있다고 말할 수 있습니다.

그럼 우리 스스로에게 질문을 해보죠: 이 상호작용이 종이 프로토타입으로 표현될 수 있을까요? 제 즉각적인 대답은: 네. 이것은 개선의 여지가 많다는 것을 의미한다.

우리는 우리의 디지털 사고방식을 사용하여 단순히 일을 완수하는 것이 아니라 경험을 향상시키는 것을 만들 수 있습니다. 우리는 페이딩, 마스킹, 시차, 비틀거림 또는 단순히 메뉴를 독립적으로 움직이는 다른 조각으로 분할하는 것과 같은 기술을 가지고 놀 수 있다. 이것은 창의력을 얻고 우리의 프런트 엔드 칩을 사용하여 독특한 디지털 경험을 만들 수 있는 기회입니다.

간단한 작업을 수행하기 위해 몇 가지 기본 기술을 적용한 후 어떤 모습을 보여줄지 살펴보겠습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_wvMEdZP" src="//codepen.io/anon/embed/wvMEdZP?height=450&amp;theme-id=1&amp;slug-hash=wvMEdZP&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed wvMEdZP" title="CodePen Embed wvMEdZP" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

됐다! 이제 우리는 종이 심리로부터 벗어나기 시작했습니다. 용지가 왼쪽에서 오른쪽으로 미끄러질 수 있습니까? 네. 하지만 오프셋 애니메이션으로 콘텐츠를 안팎으로 희미하게 만들 수 있을까요? 내가 본 것 만큼은 아니야!

그리고 앞서 말씀드렸듯이, 우리가 여기서 할 수 있는 일이 훨씬 더 많습니다. 하지만 난 네가 요점을 이해한다고 생각해. 애니메이션으로 "완벽한" 상호 작용을 찾기 위해 더 많은 시간을 보낼 수 있지만, 이는 프로젝트에 크게 좌우됩니다. 이 규칙의 목표는 인쇄 디자인 사고방식에서 벗어나 독특한 디지털 경험을 만들 수 있는 가능성을 수용하는 것입니다.

개발 프로세스의 일부로 종이 프로토타입 규칙을 실천하기 시작하면, 계속해서 기술을 개선할 수 있는 도구를 찾기 위해 애쓰는 자신을 발견할 수 있을 것입니다. 나는 항상 기본적인 애니메이션 원리에 대해 읽고 항상 다른 웹사이트에서 신선한 영감을 얻기를 권한다.

다음 번에 회전식, 모달 또는 기타 대화형 구성 요소를 작업할 때 잠시 시간을 내어 애니메이션 접근 방식을 확인하십시오. 종이 프로토타입 테스트를 통과했습니까?