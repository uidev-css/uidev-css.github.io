---
slayout: post
title: "두더지 두드리기 : CSS 에디션"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/12/whack-a-mole-css.jpg
tags: CHECKBOX HACK,GAME
---


체크 박스 해킹과 CSS에서 완전한 상태 머신을 구축하는 데 사용되는 방법을 살펴 보았습니다.
 오늘 우리는 그 생각을 한 단계 더 나아가서 JavaScript를 건드리지 않고도 플레이어가 빠르게 반응해야 승리하는 간단한 Whack-A-Mole 게임을 만들 것입니다.

타이머 나 간격에 대한 개념이없는 언어에서는 약간 어리석은 것처럼 보일 수 있지만, 비결은 CSS가 수행한다는 것입니다. CSS 애니메이션이라는 작은 기능에 패키지로 포함되어 있습니다.

이 두 번 클릭 처리기를 살펴보십시오.
 CSS는 클릭이 무엇인지 알지 못하며 더블 클릭이 훨씬 적다는 점에 유의하세요.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 350px;"><iframe id="cp_embed_ExgZOzG" src="//codepen.io/anon/embed/ExgZOzG?height=350&amp;theme-id=1&amp;slug-hash=ExgZOzG&amp;default-tab=result" height="350" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed ExgZOzG" title="CodePen Embed ExgZOzG" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>
어떻게 작동합니까?
 다음은 색상을 변경하고 속도를 늦추는 중요한 요소에 대한 기록입니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_4AA4355BFFAFDCE6C1500774DCD6CA7437BE7CE99089DBFCA39361D4F2B91151_1608621462026_recording.gif?resize=473%2C92&ssl=1)

처음으로 버튼을 클릭하면 더블 클릭 요소가 커서 아래의 위치로 이동하지만 마스킹 요소가 위로 이동하여이를 덮기 시작합니다.

- 두 번째 클릭이 첫 번째 (녹화의 왼쪽에서와 같이) 이후에 충분히 빠르게 발생하면 더블 클릭 (파란색) 요소에서 발생합니다.
- 그렇지 않으면 (녹화의 오른쪽에서와 같이) 마스킹 (노란색) 요소에서 발생하며 단일 클릭 요소의 효과가 있습니다.

(자세한 설명은 여기에서 pure-CSS 두 번 클릭 처리기에 대한 저의 글을 참조하십시오.)

여기에는 두 가지 아이디어가 있습니다.

- 애니메이션은 설정된 패턴에 따라 상태를 관리하는 데 사용할 수 있습니다.
 (저는 "상태"라는 용어를 느슨하게 사용하고 있습니다.)
- 요소의 위치를 변경하여 사용자가 작업을 수행 할 수 있는지 여부를 변경할 수 있습니다.

그게 우리에게 필요한 전부입니다!

이제 타겟을 스크롤하는 대신 `animation-timing-function : step-end`를 사용하여 구멍 속의 두더지처럼 튀어 나오게 할 수 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 350px;"><iframe id="cp_embed_BaLdZZq" src="//codepen.io/anon/embed/BaLdZZq?height=350&amp;theme-id=1&amp;slug-hash=BaLdZZq&amp;default-tab=result" height="350" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed BaLdZZq" title="CodePen Embed BaLdZZq" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>
두더지를 제거하기 위해 몇 가지 다른 옵션을 시도해 보았고 절대 위치 (여기서는 `왼쪽`)를 변경하는 것이 가장 잘 작동하는 것 같습니다.
 번역을 사용하면 편리 할 수 있지만 불행히도 Gecko 레이아웃 엔진에서 `변환`을 변경해도 레이아웃이 다시 시작되지 않기 때문에 Firefox가 커서가 잘못된 요소에 있다고 생각하게됩니다.
 (일반적으로 이것은 성능상의 이유로 좋은 것이지만 우리의 작은 데모에는 그다지 많지 않습니다!)

약간의 스타일링을 통해 게임 요소처럼 보이게 만들 수 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 350px;"><iframe id="cp_embed_gOwxxdb" src="//codepen.io/anon/embed/gOwxxdb?height=350&amp;theme-id=1&amp;slug-hash=gOwxxdb&amp;default-tab=result" height="350" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed gOwxxdb" title="CodePen Embed gOwxxdb" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>
여기서 "두더지"는 기본적으로 체크 박스 해킹을 유발하는 스타일이 변경된 CSS 라벨입니다.
 구멍도 그렇습니다.
 두더지의 애니메이션이 구멍을 차지할 때 영역을 클릭하면 두더지의 라디오 입력이 트리거됩니다.
 두더지가 멀리 떨어져있을 때 클릭하면 구멍의 라디오 입력이 트리거됩니다.

다음 단계는 두 개의 구멍을 나란히 놓고 두더지가 서로 다른 부정적인 `애니메이션 지연`으로 그 사이에서 튀어 오르게하는 것입니다.
 상태 기계가 어떤 두더지가 맞았고 어떤 구멍이 무너 졌는지 판독하면 깔끔한 작은 게임이됩니다.

짧은 Python 스크립트를 사용하여 상태 머신 선택기와 두더지 키 프레임을 모두 생성했습니다.
 그렇지 않으면 손으로 코딩하기가 다소 어려워집니다.
 이는 CSS에도 난수 개념이 없기 때문에 "무작위"두더지 동작을 하드 코딩하는 것 외에는 선택의 여지가 없습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 350px;"><iframe id="cp_embed_eYdEPzj" src="//codepen.io/anon/embed/eYdEPzj?height=350&amp;theme-id=1&amp;slug-hash=eYdEPzj&amp;default-tab=result" height="350" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed eYdEPzj" title="CodePen Embed eYdEPzj" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>
여기에 완전히 HTML과 CSS로 된 완전한 반응 기반 게임이 있습니다.