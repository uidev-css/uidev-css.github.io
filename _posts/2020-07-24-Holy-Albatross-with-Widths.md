---
layout: post
title: "너비가 있는 성스러운 알바트로스"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/07/unholy-albatross.png
tags: FLEX-GROW,FLEX-SHRINK,FLEXBOX,MAX
---


Heydon`s Holy Albatross는 일련의 요소들이 특정한 폭의 요소들로 이루어진 기둥으로 쪼개지도록 하는 기술이다. 지정한 부모 너비, 미디어 쿼리와 같은 화면 너비가 아닙니다. 그러니까, 컨테이너 질의처럼 (알다시피, 우리가 모두 원하는 것은 아직 존재하지 않는 것들)

두 가지 요소에만 사용할 필요는 없고, 세 가지 이상의 요소를 사용할 때 홀리 알바트로스가 가장 유용하다는 점을 지적받았지만, 이전에도 사용해 본 적이 있습니다.

원래 기사 종류는 가로줄의 요소(둘 중 하나는 다른 요소보다 커야 한다는 뜻)에 폭을 설정하는 데 들어가지 않았지만, 후속 기사에는 플렉스 그로우(Flex-grow)를 사용하여 정확히 할 수 있다는 데모가 들어 있다. 그러나 샤오 주오 지아는 이것이 정확히 훌륭한 시스템이 아니라고 지적합니다.

> 문제는 폭이 해킹에 의해 점령되기 때문에 비적재 기둥으로 폭을 설정하기가 매우 어렵다는 점입니다.
Heydon의 제안 중 하나는 Flex-grow를 사용하는 것입니다. 문제는 다음과 같습니다.
1. 매우 의도치 않게 너비를 설정하는 방법입니다. 3열 레이아웃의 경우 1열의 너비를 50%로 설정하고, 유연한 확장을 2.333으로 설정해야 합니다.
2. 총 열 수를 알고 그에 따라 다른 열의 Flex-grow 값을 설정해야 합니다.
다른 방법은 이 코드펜에 표시된 것처럼 최소 너비와 최대 너비를 사용하는 것입니다. 100%보다 큰 것은 플렉스 축소로 인해 100%로 변경되기 때문에 max-width: 100%가 필요하다고 생각하지 않습니다. 그래서 우리는 실제로 min-width를 다루고 있습니다.
이 방법의 문제는 모든 열에 대해 최소 너비를 설정해야 한다는 것입니다. 그렇지 않으면 Flex-grow가 우리가 설정한 최소 너비로 열을 이어받아 확장하게 됩니다.
이거 하나도 재미없어.
살짝 둘러보니까 케이크도 먹을 수 있고…

샤오 주오 지아는 언홀리 알바트로스를 부른다. 이 기사의 일부인 How doating?을 통해 훌륭한 CSS 속임수를 볼 수 있습니다. max() 함수와 CSS 사용자 지정 속성을 풀백과 함께 사용하는 것과 관련이 있다. 여전히 홀리 알바트로스의 정신으로 느껴지며 픽셀 값이나 비율의 특정 요소에 대해 너비(--폭)를 설정할 수 있습니다. 게다가 격차를 줄여줍니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_GRoMdVa" src="//codepen.io/anon/embed/GRoMdVa?height=450&amp;theme-id=1&amp;slug-hash=GRoMdVa&amp;default-tab=css,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed GRoMdVa" title="CodePen Embed GRoMdVa" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

직접 링크 →