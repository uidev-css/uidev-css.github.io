---
layout: post
title: "HTML에서 각주를 작성하는 (끔찍한?) 방법"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/12/details-summary-footnote.jpg
tags: DETAILS/SUMMARY,FOOTNOTES
---


Terence Eden은`<details>`/`<summary>`요소를 사용하여 각주를 작성하는 방법을 살펴 보았습니다.
 좀 영리하다고 생각합니다.
 다른 곳에서 각주를 설명하기 위해 아래로 점프하는 하이퍼 링크가 아니라 세부 사항이 텍스트 바로 옆에 있습니다.
 나는 코드에서 그 근접성을 좋아합니다.
 또한 공개 위젯의 기본 열기 / 닫기 상호 작용이 제공됩니다.

하지만 까다로운 부분이 있습니다.
 `<details>`요소는 블록 수준이므로 각주가 되려면 인라인이되어야하고 "올바르게"보이도록 크기 / 위치가 지정되어야합니다.
 `<p>`태그 안에 들어 가지 않아서 제 자신의 사용에는 비실용적이라고 생각합니다.

댓글에있는 Craig Shoemaker는 원본을 CSS로 만지작 거리게했고, 그게 저도 똑같이 할 수 있도록 영감을주었습니다.

각주 텍스트 자체를 바로 인라인으로 표시하는 대신 (매우 까다 롭습니다), 해당 콘텐츠를 페이지 하단의 고정 위치로 이동했습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_jOMZewP" src="//codepen.io/anon/embed/jOMZewP?height=450&amp;theme-id=1&amp;slug-hash=jOMZewP&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed jOMZewP" title="CodePen Embed jOMZewP" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

좋은 아이디어라고 100 % 확신하지는 못하지만 끔찍한 아이디어라고 확신하지도 않습니다.