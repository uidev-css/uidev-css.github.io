---
layout: post
title: "그래픽 SVG"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/11/graphery.png
tags: SVG
---


이전에 SVG와 Canvas를 비교했습니다.
 둘 중 하나를 결정하려면 그것을 읽으십시오.
 이들의 가장 큰 차이점은 벡터 (SVG)와 래스터 (캔버스)입니다.
 하지만 두 번째 차이점은 그들과 함께 일하는 방식입니다.
 SVG는 속성과 콘텐츠를 통해 무엇인지를 표현하는 리터럴 요소에서와 같이 선언적입니다.
 캔버스는 따라야 할 지침을 스크립트로 작성하는 것처럼 필수적입니다.
 

Canvas는 JavaScript API이므로 JavaScript 개발자 또는 빌드중인 UI가 JavaScript 기반 인 환경과 잘 어울릴 수 있습니다.
 그러나 SVG는 DOM에 있으며 DOM에도 API가 있습니다!
 즉, 원하는 경우 SVG를 스크립팅 할 수 있습니다.
 단언 컨대 특히 편리하지는 않습니다.
 나는 그것을 바로 잡으려는 시도 인 Graphery SVG를 방금 보았다.
 

표준 DOM API를 사용하여 분홍색 직사각형 생성을 스크립팅하는 방법 :
 

```js
const div = document.querySelector('#drawing');
const svg = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
svg.setAttribute('width', '100%');
svg.setAttribute('height', '100%');
div.appendChild(svg);
const rect = document.createElementNS('http://www.w3.org/2000/svg', 'rect');
rect.setAttribute('x', '10');
rect.setAttribute('y', '10');
rect.setAttribute('width', '90');
rect.setAttribute('height', '90');
rect.setAttribute('fill', '#F06');
svg.appendChild(rect);
```

Graphery SVG 사용 :
 

```js
const svg = gySVG().width('100%').height('100%');
const rect = svg.add('rect').x(10).y(10).width(90).height(90).fill('#f06');
svg.attachTo('#drawing');
```

그 체인을 좋아해야합니다.
 하이 파이브, jQuery.
 

직접 링크 →
 