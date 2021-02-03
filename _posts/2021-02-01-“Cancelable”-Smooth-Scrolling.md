---
layout: post
title: ""취소 가능"부드러운 스크롤
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/09/scroll-to-top.png
tags: SCROLL-BEHAVIOR,SCROLLING
---


상황은 다음과 같습니다. 사이트에서 `맨 위로 스크롤`버튼을 제공하고 부드러운 스크롤을 구현했습니다.
 페이지가 맨 위로 스크롤 될 때 사용자는 눈을 사로 잡는 무언가를보고 스크롤을 중지하기를 원하므로 마우스 휠, 트랙 패드 등에서 스크롤을 살짝 밉니다.
 이것이 취소 가능이라는 뜻입니다.
 추가 작업없이 스크롤 이벤트가 대상으로 이동합니다.
 취소 가능은 후속 스크롤로 중지 할 수 있음을 의미합니다.
 백업 할 데이터가 없지만 취소 가능한 동작이 더 나은 UX를 찾습니다.
 

이 모든 것이 어떻게 작동하는지에 대한 브라우저 간, CSS와 자바 스크립트간에 약간의 불일치를 발견했습니다.
 

이 데모에서 아래로 스크롤하여 한 번 시도해보세요.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_NWRmxGa" src="//codepen.io/anon/embed/NWRmxGa?height=450&amp;theme-id=1&amp;slug-hash=NWRmxGa&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed NWRmxGa" title="CodePen Embed NWRmxGa" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

쉽게 액세스 할 수있는 브라우저에서 경험 한 내용은 다음과 같습니다.
 

나에게 달려 있었다면 다음과 같이했습니다.
 

- CSS 또는 JavaScript를 통해 트리거되는 부드러운 스크롤 동작을 취소 할 수 있습니다.
 
- "취소 가능"을 정의하는 것은 정말 올바른 단어가 아니기 때문입니다.
 "중단"?
 아니면 "통제"?
 아이디어를 환영합니다!
 
- 속도를 제어 할 수 있도록하거나 그렇지 않은 경우 브라우저가 중간 속도 (스크롤 거리에 관계없이 일관성을 유지함)에 동의하도록하십시오.
 
- 사파리가 가지고 있습니다.
 부드러운 스크롤은 자바 스크립트가없는 캐 러셀과 같은 것을 매우 실용적으로 만들어줍니다. 특히 Apple 기기에서 iOS Safari가 강제 실행되는 모바일에서 특히 유용합니다.
 