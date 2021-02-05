---
layout: post
title: "Parsel: 작고 관대한 CSS 선택기 파서"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/10/parsel.png
tags: POSTCSS
---


만약 여러분 스스로 생각해 보신 적이 있다면, 저는 이 CSS 선택기의 추상 구문 트리(AST)를 갖고 싶습니다. Lea는 여러분의 등을 가지고 있습니다.

만약 여러분이 전체 CSS 파일에 대해 같은 생각을 해본 적이 있다면, 이것이 PostCSS가 v8이 된 것입니다. 포스트CSS는 그 자체로는 아무것도 하지 않습니다, 기억하십시오. 그것은 단지 CSS로 AST를 만들고 플러그인 인터페이스를 제공하므로 플러그인은 그것으로 CSS를 변환하기 위해 쓸 수 있다. 포스트CSS에는 그늘이 없지만, "우린 포스트CSS를 사용한다"고 말하는 것이 "우린 Sass를 사용한다"는 식으로 아무 의미가 없다는 것은 우스운 일이다.

직접 링크 →