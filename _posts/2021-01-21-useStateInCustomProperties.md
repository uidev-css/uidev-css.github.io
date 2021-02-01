---
layout: post
title: "useStateInCustomProperties
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2021/01/custom-properties-state.gif
tags: CUSTOM PROPERTIES,STATE
---


최근의 "Custom Properties as State"게시물에서 제가 언급 한 것 중 하나는 이론적으로 React 및 Vue와 같은 UI 라이브러리가 관리하는 상태를 CSS 사용자 지정 속성에 자동으로 매핑하여 다음과 같은 경우 해당 상태를 바로 사용할 수 있다는 것입니다.
 우리는 원했습니다.
 

> 누군가`useStateWithCustomProperties` 후크를 만들어야합니다.
 #freeidea
 

Andrew Bloyce는 그 아이디어에 대해 저를 받아 들였습니다.
 

내가 바라던대로 작동합니다.
 후크는 사용자 지정 속성 "경계"인 구성 요소를 반환하고 전달하는 모든 상태는 해당 사용자 지정 속성에 매핑됩니다.
 기본 데모 :
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_NWROdEJ" src="//codepen.io/anon/embed/NWROdEJ?height=450&amp;theme-id=1&amp;slug-hash=NWROdEJ&amp;default-tab=js,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed NWROdEJ" title="CodePen Embed NWROdEJ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이것은 이미 영리하고 유용하지만, 더 높은 수준의 사용자 지정 속성 개념이 적용되면 매우 유용 할 것입니다.
 아이디어는 하나의 사용자 정의 속성을 뒤집고 전체 스타일 변경 블록을 가질 수 있다는 것입니다. 이는 우리가 이미 미디어 쿼리를 통해 즐기고 있으며 이것이 얼마나 유용한 지 알고 있습니다.
 