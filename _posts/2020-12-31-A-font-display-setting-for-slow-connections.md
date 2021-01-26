---
layout: post
title: "느린 연결을위한 글꼴 표시 설정"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/12/performance-waterfall-fonts.jpg
tags: FONT-DISPLAY,PERFORMANCE,TYPOGRAPHY
---


나, 나는 FOUT을 정말 싫어한다.
 웹에서 빠르게 텍스트를 표시하지 않는 것은 좋지 않기 때문에 옵션 인 것이 좋습니다.
 나는`font-display : swap;`이 성능에 좋기 때문에 인기가 있다는 것을 알고 있지만, FOUT이 나를 괴롭힌다.
 Matt Hobbs :

> 독자들이이 글에서 빼 놓고 싶은 것이 있다면 그것은 'font-display : swap'이 빠른 인터넷 연결을 가진 사용자에게 매우 좋은 옵션이라는 것입니다.
 그러나 무한 스왑 기간은 매우 느리고 불안정한 연결을 사용하는 사용자에게 실망 스러울 수 있습니다.
 이러한 조건에서 사이트를 보는 사용자가있는 경우 (언젠가는 확신 할 수 있음)`font-display : fallback` 또는`font-display : optional`을 고려해 볼 가치가 있습니다.

Seeeee, 내가 말했어.
 나는`font-display : optional;`이 FOUT을 완전히 멈추는 방식을 좋아합니다.
 글꼴이 매우 빠르게 적용되거나 전혀 사용되지 않습니다 (하지만 여전히 비동기 적으로 다운로드 됨).
 다음 페이지로드시 글꼴이로드되고 캐시되어 사용됩니다.

이것은 느린 연결에 대한 것이며 사용자가 가능한 한 적은 데이터 사용을 선호하는 연결에 대한 것은 아닙니다.
 이 경우 Responsible, Conditional Loading에서 링크 한 최근 게시물 중 일부를 확인하세요.

안녕하세요, 올해 웹 성능 캘린더는 멋진 기사에 실 렸습니다.

직접 링크 →