---
layout: post
title: "마우스 오버시 스크롤바
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2021/01/scrollbar-hover.jpg
tags: HOVER,SCROLLBARS
---


첫째, 스크롤바는 사용 성과 접근성의 요소입니다.
 둘째, 경험 법칙 : 영역이 스크롤되면 스크롤바가 표시되어야합니다.
 하지만 웹은 큰 공간이고 저는 트릭을 좋아하기 때문에 호버링시에만 공개하는 아이디어를 다루겠습니다.
 macOS 자체 ¹도 기본적으로 스크롤바를 숨겨서 상황에 따라 상호 작용할 때 표시합니다.
 iOS에서도 동일하므로 혼란스러운 순간이 생깁니다.
 

여기에 기본적으로 스크롤바를 숨기고 요소를 가리킬 때만 표시하는 방법이 있습니다.
 Thomas Gladdines에 의해 만들어졌으며 이에 대해 저에게 이메일을 보냈습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_vYXzWgW" src="//codepen.io/anon/embed/vYXzWgW?height=450&amp;theme-id=1&amp;slug-hash=vYXzWgW&amp;default-tab=css,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed vYXzWgW" title="CodePen Embed vYXzWgW" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

내 컴퓨터의 빠른 테스트에서 macOS 설정에 관계없이 Chrome, Firefox 및 Safari에서 작동합니다.
 매우 견고합니다.
 

트릭은 `마스크`가 스크롤바를 덮는다는 것입니다!
 따라서 스크롤바 (여기서는 17px가 덮을 것이라고 추측하고 있음)와 높이가 매우 높은 (둘 다 스크립트로 계산해야 함) 정확히 동일한 `마스크`를 만들면 다음을 수행 할 수 있습니다.
 스크롤바를 완벽하게 덮습니다.
 페이드 인 / 아웃 효과를 위장하여 마스크 위치를 `전환`할 수도 있습니다.
 매우 영리한.
 

특히 이것은 요소의 실제 스크롤바이며 가짜가 아닙니다.
 가짜는 또 다른 접근 방식이 될 수 있습니다.
 Ben Nadel은 Slack이 어떻게 수행하는지 설명했습니다.
 이들의 트릭은 오버플로에 의해 숨겨진 영역에서 스크롤바를 렌더링하도록 강제하고 네이티브 스크롤바를 모방 한 가상 스크롤바를 만드는 것입니다 (그러면 더 직접 제어 할 수 있음).
 스크롤바를 강요하는 것도 아니므로 동기가 부여되면 다른 작업을 수행 할 수 있습니다.
 그리고 이것에 관한 어떤 것도 당신이 스크롤바의 스타일을 지정하는 것을 방해하지 않습니다. 이것은 실제로 정확한 너비를 지정하는 것과 같은 몇 가지 이점을 가질 수 있습니다.
 