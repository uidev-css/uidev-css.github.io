---
layout: post
title: "커버링 요소를위한 유틸리티 클래스
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/12/a-utility-class-for-covering-elements-01.jpg
tags: ABSOLUTE POSITION,GRID,LOGICAL PROPERTIES,UTILITY CLASSES
---


여기에서 Michelle Barker와 동일하게
 

> CSS에서 몇 번이고해야 할 일이 있습니다. 한 요소를 다른 요소로 완전히 덮습니다.
 매번 동일한 CSS입니다. 첫 번째 요소 (가려야하는 요소)에는 '위치 : 상대'가 적용됩니다.
 두 번째는 'position : absolute'를 가지며 네면이 모두 첫 번째 요소의 가장자리에 정렬되도록 배치됩니다.
 

```css
.original-element {
  position: relative;
}

.covering-element {
  position: absolute;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
}
```

나는 `bottom`과 `right`를 사용하는 것이 "그만큼 신뢰할 수 없다"는 것과 `top`과 `left`를 설정 한 다음 `width : 100 %`와 `height`를 설정하는 것이 더 안전하다는 것을 내 머릿속에 찔렀다.
 100 %`.
 하지만 왜 더 이상 기억이 나지 않습니다. 아마도 오래된 브라우저 였을까요?
 

근대화에 대해 말하자면 Michelle의 기사에서 제가 가장 좋아하는 부분은 다음과 같습니다.
 

```css
.overlay {
  position: absolute;
  inset: 0;
}
```

`inset` 속성은 논리적 속성이며 여기에서 분명히 매우 편리합니다!
 CSS 그리드와 관련된 또 다른 트릭에 대한 기사를 읽어보십시오.
 

직접 링크 →
 