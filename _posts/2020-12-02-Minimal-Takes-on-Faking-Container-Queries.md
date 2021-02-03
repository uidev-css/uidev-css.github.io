---
layout: post
title: "가짜 컨테이너 쿼리에 대한 최소한의 작업
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2019/12/container-queries.png
tags: CONTAINER-QUERIES
---


실제로 실제 컨테이너 쿼리를 얻을 가능성이 점점 더 커지고 있습니다.
 Google은 David Baron의 구문 아이디어를 프로토 타이핑하고 Miriam Suzanne이 개선했습니다.
 분명히 값에 대한 컨테이너 쿼리와 같은`switch ()`구문에 대한 프로토 타이핑이 이미 수행되었습니다.
 지금도 컨테이너 쿼리와 같은 값을 수행 할 수있는 Raven 기술과 같은 것이 있습니다.
 이 물건은 시간이 지남에 따라 흔들릴 것입니다.
 

오늘날 솔루션이 필요한 경우 대부분의 솔루션은 무슨 일이 일어나고 있는지 (예 : 컨테이너 너비) 모니터링 한 다음 일종의 스타일링 후크 (예 : 클래스)를 제공하는 JavaScript를 포함합니다.
 다음은 "최소 촬영"환경에 대한 간단한 검토입니다.
 

- Philip Walton이 `ResizeObserver`를 통해이를 홈 성장시키는 방법을 보여줍니다.
 크기 조정을보고 스타일링 후크에 대한 클래스를 적용하십시오.
 
- Heydon Pickering에는`ResizeObserver`를 활용하는`<watched-box>`웹 구성 요소가 있습니다.
 크기 조정을보고 스타일링 후크에 대한 클래스를 적용하십시오.
 (resizeasaurus와의 조합을 참조하십시오.)
 
- Scott Jehl은`ResizeObserver`를 활용하는`<c-q>`웹 구성 요소를 만들었습니다.
 크기 조정을보고 스타일링 후크에 대한 데이터 속성을 적용합니다.
 
- Eric Portis는 `ResizeObserver`를 활용하는 조건부 클래스와 스타일링 후크에 클래스를 적용하는 CSS 사용자 정의 속성을 포함하는 영리하고 유효한 구문을 만들었습니다.
 

또한 Tommy Hodgins의 EQCSS가 있습니다.이 EQCSS는 이러한 멋진 작업을 수행하는 발명 된 구문에 대해 CSS를 살펴봄으로써 컨테이너 쿼리 (및 기타 작업)를 수행합니다.
 나는 그것을 미니멀리스트라고 부르지 않을 것이며, 잘못된 CSS 구문을 제공하기 위해 약간 놀랐지 만 강력 해 보입니다.
 