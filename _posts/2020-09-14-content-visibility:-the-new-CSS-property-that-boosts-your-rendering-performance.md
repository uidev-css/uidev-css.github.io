---
layout: post
title: "컨텐츠 가시성: 렌더링 성능을 향상시키는 새로운 CSS 속성"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/09/content-visibility-perf.png
tags: CONTENT-VISIBILITY,PERFORMANCE
---


우나 크라베츠와 블라디미르 레빈:

> […] 'content-visibility'라는 다른 CSS 속성을 사용하여 필요한 격납을 자동으로 적용할 수 있습니다. 컨텐츠 가시성은 개발자로서 최소한의 노력으로 브라우저가 제공할 수 있는 최대의 성능 향상을 보장합니다.
컨텐츠 가시성은 몇 가지 값을 허용하지만 자동은 즉각적인 성능 향상을 제공하는 속성이다.

완벽한 이점은 매우 큰 것 같습니다.

> 이 예에서는 232ms의 렌더링 시간이 30ms의 렌더링 시간으로 증가했음을 알 수 있습니다. 성능이 7배 향상되었습니다.

그래도 수작업이죠. 페이지의 큰 세로 덩어리를 직접 "섹션"하고 "콘텐츠 가시성: auto;"를 적용한 다음 "contain-intrinic size: 1000px;"와 같은 높이에 대해 측정해야 합니다. 제가 보기엔 그 부분이 너무 이상해요. 높이로 맞춰봐? 아니면 어떡해? 제가 공연을 망칠 수 있을까요? 작은 화면과 큰 화면의 높이 차이가 큰 경우 서로 다른 뷰포트에서 값을 변경할 수 있습니까?

이 문제를 해결하려면 상당히 숙련된 기술자가 되어야 할 것 같고, DevTools에서 렌더링 프로필을 보고 비교하는 방법을 알아야 할 것 같습니다. 웹퍼펙트가 그 자신의 천직이라는 증거가 더욱 많다.