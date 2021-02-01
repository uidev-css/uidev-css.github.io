---
layout: post
title: "책임감있는 조건부로드
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/12/network-info-c451ffd2ba.png
tags: PERFORMANCE,PREFERS-REDUCED-DATA,PREFERS-REDUCED-MOTION
---


Polypane 블로그 (바이 라인은 없지만 아마도 Kilian Valkhof 일 것입니다)에는 `prefers-reduced-data`미디어 쿼리에 대한 훌륭한 기사 인 Creating website with prefers-reduced-data가 있습니다.
 아직 브라우저 지원은 없지만 결국 CSS에서이를 사용하여 데이터 사용량을 줄이는 선택을 할 수 있습니다.
 이 기사에서 사용자가 낮은 데이터 사용량에 대한 기본 설정을 지정하지 않은 경우에만 웹 글꼴을로드하는 한 가지 예가 있습니다.
 

```css
@media (prefers-reduced-data: no-preference) {
  @font-face {
    font-family: 'Inter';
    font-weight: 100 900;
    font-display: swap;
    font-style: normal;
    font-named-instance: 'Regular';
    src: url('Inter-roman.var.woff2') format('woff2');
  }
}

body {
  font-family: Inter, system-ui, -apple-system, BlinkMacSystemFont,
               Segoe UI, Ubuntu, Roboto, Cantarell, Noto Sans, sans-serif,
               'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
}
```

좋은 패턴입니다.
 접근성과 `감소 된 움직임 선호`미디어 쿼리도 마찬가지입니다.
 JavaScript에서도 둘 다 사용할 수 있습니다.
 

또한 동일한 에너지 : Umar Hansa의 최근 블로그 게시물 JavaScript : Conditional JavaScript, 적절한 경우에만 다운로드하십시오.
 여기에는 많은 예제가 있지만 요점은`navigator` 객체가 장치, 인터넷 연결 및 사용자 환경 설정에 대한 정보를 가지고 있다는 것입니다. 따라서이를 ES 모듈과 결합하여 너무 많은 코드없이 리소스를 조건부로로드 할 수 있습니다.
 

```js
if (navigator.connection.saveData === false) {
    await import('./costly-module.js');
}
```

이 모든 아이디어에 관심이 있다면 Responsible JavaScript에 대한 Jeremy Wagner의 시리즈를 여기에서 살펴볼 수 있습니다.
 