---
layout: post
title: "웹 구성 요소의 실패한 약속"
author: 'CSS Dev'
thumbnail: undefined
tags: WEB COMPONENTS
---


리아에게는 다음과 같은 말이 있다.

> webcomponents.org의 구성 요소를 자세히 살펴보니 걱정스럽기만 합니다. JS를 쓰는 것이 아주 편합니다. JS를 쓰는 것은 생계를 위해서입니다! JS를 쓰지 못하는 사람들은 어떤 희망을 가지고 있을까? 디렉토리에서 사용자 정의 요소를 사용하는 것은 종종 npm 플뤼겔혼, 광대 신발 수입, 빌드 눅스 등의 의식이 선행되어야 한다. 왜냐하면 "여기 내 트럭의 의존성, 그래, 뭘"이기 때문이다. 심지어 많은 단계가 생략되기도 하는데, 이는 "명백한" 단계이기 때문일 수 있다.

Web Component Libraries에 ABIT를 썼을 때 제가 잘못 알고 있는 주된 사항은 다음과 같습니다.

> 그 아이디어는 도서관들이 코드를 덜 보낼 수 있도록 위에 세울 수 있는 원시적인 것을 만드는 것이었습니다. 항상 당신이 그들과 함께 도서관을 이용하려는 의도였다.

HTML 수입이 죽은 것은 수년 전이다. 그것은 오랫동안 웹 컴포넌트에 대한 데이브의 골칫거리였다. 그 이후로는 웹 컴포넌트를 위한 자바스크립트 또는 버스트 접근 방식이었던 것 같습니다. 말하기 싫지만, 좋은 점이라기보다는 큰 문제에 더 가까운 느낌이에요.

그래도 난 여전히 낙관적이다. Web Components는 Web Components만이 할 수 있는 매우 멋진 작업을 수행할 수 있습니다. 섀도우 DOM이 그 중 큰 부분을 차지합니다. 예를 들어, 나는 수년 전에 트위터가 (모든 면에서) 훨씬 더 빨랐기 때문에 (Iframe이 아닌) 웹 컴포넌트로 임베디드 트윗을 만드는 실험을 했던 것을 기억한다. 그런 일은 전혀 나타나지 않았지만(🤷♂️) 나에게는 정말 좋은 생각인 것 같았습니다.

스타일링 스토리는 정말 대단한 것 같아요. 스타일링이 그렇게 이상하지 않다면 적어도 조금 더 손을 뻗을 수 있을 거예요. 오늘 스콧이 그것에 대해 물어보는 것을 보았는데 75%의 사람들이 섀도우 DOM에 접속해서 일반적인 CSS에서 스타일링할 수 있는 방법이 있기를 바란다. 왜 보호되어야 하는지는 알겠는데(처음에는 Shadow DOM의 중요한 포인트입니다) 아주 분명하게 접근해야 하는 것은 제게 충분한 보호인 것 같습니다.

직접 링크 →