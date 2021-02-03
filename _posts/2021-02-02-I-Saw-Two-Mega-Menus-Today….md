---
layout: post
title: "오늘 메가 메뉴 2 개 봤는데…
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-20-at-10.50.52-AM.png
tags: NAVIGATION
---


하나는 (이전) 미국 정부 웹 사이트의 바닥 글이었습니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-20-at-10.50.12-AM.png?resize=1890%2C1542&ssl=1)

다른 하나는 AWS 콘솔에서 AWS 서비스에 대한 탐색이었습니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-20-at-10.50.52-AM.png?resize=2232%2C2040&ssl=1)

둘 다 다음과 같은 분위기를 가지고 있습니다. 이런 젠장, 우리는 많은 것들을 가지고 있습니다. 우리는 그 모든 것에 대한 방대한 링크 그리드를 만들 것입니다.
 

차이점은 AWS 콘솔 상단에 검색 표시 줄이 있다는 것입니다.
 주요 기능은 해당 메뉴에서 항목을 찾는 것입니다 (하지만 더 넓은 사이트도 검색합니다).
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-20-at-10.51.01-AM.png?resize=1166%2C802&ssl=1)

"이미 페이지에있는 항목의 목록 검색"아이디어는 고전적인 jQuery `포함`선택자를 상기시킵니다.
 저를 허용하십시오 :
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_ExgqWab" src="//codepen.io/anon/embed/ExgqWab?height=450&amp;theme-id=1&amp;slug-hash=ExgqWab&amp;default-tab=js,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed ExgqWab" title="CodePen Embed ExgqWab" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>