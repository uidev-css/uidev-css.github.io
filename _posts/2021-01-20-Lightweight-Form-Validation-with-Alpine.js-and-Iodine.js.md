---
layout: post
title: "Alpine.js 및 Iodine.js를 사용한 경량 양식 유효성 검사"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/04/alpinejs.png
tags: ALPINE.JS,FORM VALIDATION,IODINE
---


그리고 어제 출시되었습니다!
 CSS Land에서 우리에게 큰 소식은 새 릴리스가 `aspect-ratio`속성을 지원한다는 것입니다.
 이것은 1 월 6 일에 출시 된 Safari Technology Preview 118에서 지원을 발표 한 Safari의 뒤를 잇는 것입니다. 이는 Edge, Firefox 및 기타 브라우저로 출시 될 때 기대할만한 무언가를 제공합니다.

다음은 `종횡비`지원으로 건너 뛴 출시 동영상입니다.


<div class="video_wrapper" style="padding-top: 56.25%;">
    <iframe src="https://www.youtube.com/embed/cqAO2xR7lzM?start=87" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen="" name="fitvid0"></iframe>
</div>


따라 잡는 사람들을 위해 :

- 가로 세로 비율은 요소 크기의 비율을 정의합니다.
 예를 들어 가로 세로 비율이 `1/1`인 상자는 완벽한 정사각형입니다.
 가로 세로 비율 `3/1`은 넓은 직사각형입니다.
 많은 동영상이 `16 / 9 `가로 세로 비율을 목표로합니다.
- 이미지 및 iframe과 같은 일부 요소에는 고유 한 종횡비가 있습니다.
 즉, 너비 또는 높이가 선언되면 다른 하나는 비율을 유지하는 방식으로 자동으로 계산됩니다.
- div와 같이 대체되지 않는 요소에는 고유 한 가로 세로 비율이 없습니다.
 우리는 동일한 효과를 얻기 위해 패딩 해킹을 사용했습니다.
- CSS의 `aspect-ratio`속성 지원을 통해 대체되지 않은 요소의 가로 세로 비율을 유지할 수 있습니다.
- 그것을 사용하는 몇 가지 트릭이 있습니다.
 예를 들어 `가로 세로 비율`로 요소에 `너비`를 정의하면 해당 `너비`값을 사용하여 요소의 높이를 계산하는 속성이 생성됩니다.
 대신 높이를 정의 할 때도 마찬가지입니다.
 그리고 요소의 `너비`와 `높이`를 모두 정의한다면?
 `종횡비`는 완전히 무시됩니다.

지금이 문제를 해결하기에 좋은시기 인 것 같습니다!

- CSS 상자 크기 조정 모듈 레벨 4 (공식 사양, 현재 편집자 초안)
- MDN 문서
- `종횡비`(CSS-Tricks)에 대한 첫 번째 검토
- CSS 용 종횡비 단위 정의 (Rachel Andrew, CSS-Tricks notes)

직접 링크 →