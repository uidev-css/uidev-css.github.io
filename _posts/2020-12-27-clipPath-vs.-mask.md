---
layout: post
title: "clipPath 대 마스크
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/12/Screen-Shot-2020-12-26-at-1.54.16-PM.png
tags: CLIP-PATH,CLIPPING VS MASKING,MASK
---


이것들은 너무 비슷해서 똑바로 유지하기가 어렵습니다.
 이것은 viewBox의 멋진 작은 설명입니다 (멋진 이름과 URL, 나는 그들이 그것을 유지하기를 바랍니다).
 

가장 큰 점은`clipPath` (SVG의 요소와 CSS의`clip-path`)가 벡터이고 이것이 적용될 때 클리핑하는 것이 무엇이든 상관 없다는 것입니다.
 마스크를 사용하면 부분 투명도를 수행 할 수도 있습니다. 즉, 그라디언트를 사용하여 마스킹중인 것을 페이드 아웃 할 수 있습니다.
 그래서 마스크는 클립 패스가 할 수있는 모든 일을 할 수 있기 때문에 마스크가 더 강력하다고 생각합니다.
 

Sarah는 이것에 대한 전체 게시물을 가지고 있습니다.
 

마스크로 항상 내 두뇌를 구부리는 것은 `휘도`스타일이 될 수 있다는 생각입니다. 즉, 흰색은 투명하고 검은 색은 불투명하며 그 사이의 모든 것은 부분적으로 투명합니다.
 또는 픽셀의 알파 채널이 마스크의 알파인 `알파`스타일 일 수 있습니다.
 비교적 명확하게 느껴지지만 요소에 적용하면 완전히 반전되고 혼란스러워집니다.
 

직접 링크 →
 