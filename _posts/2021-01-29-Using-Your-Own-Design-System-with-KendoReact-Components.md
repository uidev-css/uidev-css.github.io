---
layout: post
title: "KendoReact 구성 요소와 함께 고유 한 디자인 시스템 사용
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/10/kendoreact-1.png
tags: KENDOREACT,PATTERN LIBRARIES,REACT
---


이미 KendoReact에 대해 들어 보셨거나 함께 작업 해 보셨을 것입니다.
 일상적인 대화 중 일부, 특히 디자인 시스템 및 React 작업에 대한 대화에서 나타납니다.
 KendoReact의 구성 요소가 훨씬 더 강력하다는 점을 제외하면 Bootstrap 또는 Material Design과 같은 구성 요소 라이브러리로 생각할 수 있습니다.
 이들은 대화 형 상태 기반 구성 요소로 즉시 완전한 UI를 구축 할 준비가되어 있습니다 (부트 스트랩을 테마로 사용하려는 경우에는 물론 가능합니다).
 

UI 라이브러리 사용을 고려할 때마다 스타일링 기능에 대해 생각해야합니다.
 이것들로 당신의 브랜드를 정말로 표현할 수 있습니까?
 스타일링을 의도 했습니까?
 스타일링 경험은 어떻습니까?
 

다행히 KendoReact는 스타일링을 전체 UI 라이브러리의 일류 시민으로 만듭니다.
 

KendoReact는 사이트 구축을위한 UI 구성 요소 모음입니다.
 꽤 방대한 것입니다.
 내 계산에 따르면 80 개가 넘고`<Grid />`제품군과 같은 무거운 리프터의 하위 구성 요소는 포함되지 않습니다.
 

다음은`<DropDownList />`이며 기본 테마 만 사용하는 것입니다 (선택 사항 인 경우에도).
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_qBNrQzP" src="//codepen.io/anon/embed/qBNrQzP?height=450&amp;theme-id=1&amp;slug-hash=qBNrQzP&amp;default-tab=js,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed qBNrQzP" title="CodePen Embed qBNrQzP" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

스타일을 지정하려면 특별한 독점 기술이 필요하지 않고 CSS 만 사용하면됩니다.
 다음은 몇 가지 간단한 CSS를 사용하여 다양한 색상과 글꼴로 완전히 새로운 모습을 보여줍니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_abZwrmq" src="//codepen.io/anon/embed/abZwrmq?height=450&amp;theme-id=1&amp;slug-hash=abZwrmq&amp;default-tab=js,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed abZwrmq" title="CodePen Embed abZwrmq" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

하지만, 아마도 당신은 임의의 오버라이드 CSS를 카우보이로 만드는 것보다 좀 더 체계적인 것을하고 싶을 것입니다.
 당신을 비난하지 않습니다.
 좋은 소식 : KendoReact 테마는 Sass 기반입니다.
 따라서 몇 가지 Sass 변수를 변경하여 많은 색상과 스타일을 제어 할 수 있습니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/10/Screen-Shot-2020-10-27-at-3.34.48-PM.png?resize=1592%2C1550&ssl=1)

그들은 당신이 필요한 것을 정확히 뱉어내는 사이트에서 바로 사용할 수있는 전체 테마 빌더를 가지고 있습니다.
 기본 테마에서 시작하여 거기에서 이동하려면 기본 테마를 선택하십시오.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/10/Screen-Shot-2020-10-27-at-3.38.01-PM.png?resize=2592%2C1850&ssl=1)

그런 다음 원하는대로 UI의 모든 색상을 사용할 수 있습니다.
 CSS-Tricks 색상이있는 테마를 살펴 보겠습니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/10/Screen-Shot-2020-10-27-at-3.42.07-PM.png?resize=1024%2C649&ssl=1)

내 빌드의 기본 테마 이전에 적용 할 수있는 SCSS 파일로 변수를 제공하는 사이트에서 다운로드 할 수 있습니다 (Telerik 블로그에이 작업을 수행하는 방법을 다루는 훌륭한 자습서가 있습니다).
 또한 내가 그렇게 사용하고 싶다면 테마의 전체 dang CSS 파일을 제공합니다. 간단하고 빠릅니다.
 해당 테마로 대화 형 채팅 위젯을 사용하는 것은 다음과 같습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 750px;"><iframe id="cp_embed_PozjMKd" src="//codepen.io/anon/embed/PozjMKd?height=750&amp;theme-id=1&amp;slug-hash=PozjMKd&amp;default-tab=result" height="750" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed PozjMKd" title="CodePen Embed PozjMKd" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

다시 말하지만, 부트 스트랩으로 시작하거나, 머티리얼로 시작하거나, 기본 테마로 시작하거나, 처음부터 시작할 수 있습니다.
 스타일링은 전적으로 나에게 달려 있습니다.
 각 테마에는 고유 한 특전이 있으며 예상대로 색상, 글꼴 및 기타 디자인 요소를 구성하는 한 매우 유연합니다.
 

정말로 이것에 익숙해지면 물론 그들의 문서를 참조하고 거기에서 길을 찾을 것입니다 (정말 포괄적 인 문서가 있다는 것을 아는 것이 좋습니다).
 모두 매우 간단하지만 잘할 것입니다!
 사용자 지정 기능이나 성능을 희생하지 않고 상태 기반 대화 형 인터페이스를 빠르게 구축해야하는 경우 KendoReact가 친구라는 것을 알게 될 것입니다.
 