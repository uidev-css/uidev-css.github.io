---
layout: post
title: "WordPress 블록 패턴으로 작업하는 방법"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/11/block-patterns-50714d9e-f968-4262-bb51-5aae3a70ca12.jpg
tags: WORDPRESS,WORDPRESS BLOCKS
---


이벤트 캘린더 블로그에 제가 쓴 글입니다.
 아이디어는 블록 집합을 WordPress에서 함께 그룹화 한 다음 그룹을 모든 페이지 또는 게시물에서 "블록 패턴"으로 사용할 수 있도록하는`register_block_pattern ()`함수에 등록 할 수 있다는 것입니다.
 

블록 패턴은 WordPress 블록 편집기에서 상위 수준의 시민이되고 있습니다.
 그들은 8 월에 워드 프레스 5.5에서 별다른 팡파르없이 발표되었지만 블록 삽입 기에서 블록 옆에 자체 탭이있는 눈에 띄는 부동산이 주어졌습니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/11/wordpress-block-patterns-tab.png?resize=2220%2C1858&ssl=1)

5.6 베타 3 릴리스 노트가 표시되면 기본 WordPress 테마에 더 많은 패턴이있는 것 같습니다.
 물론 블록 등록 함수에는 패턴을 선택 해제해야하는 경우 `unregister_block_pattern ()`동반자가 있습니다.
 

흥미로운 것은 블록 생태계가 어떻게 진화하고 있는지입니다.
 게시물에 삽입 할 수있는 기본 블록 세트로 시작했습니다.
 모든 게시물 페이지에서 일관된 콘텐츠로 블록 그룹을 조립하는 방법을 제공하는 재사용 가능한 블록이 있습니다.
 이제 우리는 동일한 작업을 수행 할 수 있지만 훨씬 더 유연하고 편집 가능한 방식으로 수행 할 수 있습니다.
 차이는 미묘하지만 사용 사례는 더 이상 다를 수 없습니다.
 우리는 실제로 다음과 같이 포스트 설명을 위해 CSS-Tricks에서 재사용 가능한 블록을 사용하고 있습니다.
 

부를 가치가 있거나 약간의 추가 설명이 필요하다고 생각 될 때 여기에 텍스트를 추가합니다.
 

재사용 가능한 블록은 "일반"블록으로 변환 할 수 있습니다.
 스타일은 유지되지만 내용은 유지되지 않습니다.
 이것이 우리의 프로세스 속도를 높이기위한 우리의 hack-y 접근 방식 이었지만 이제는 블록 패턴이 하나이므로 지금까지 사용하고있는 이전의 재사용 가능한 블록이 패턴으로 더 의미가 있습니다.
 

직접 링크 →
 