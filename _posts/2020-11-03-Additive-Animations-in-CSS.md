---
layout: post
title: "CSS의 추가 애니메이션"
author: 'CSS Dev'
thumbnail: undefined
tags: 
---


Daniel C. Wilson이 CSS`@ keyframe` 애니메이션을 사용하여 여러 애니메이션이 요소에 적용될 때 두 가지 모두 작동하는 방법을 설명합니다.
 그러나 속성이 반복되면 마지막 속성 만 작동합니다.
 그들은 서로를 무시합니다.
 중첩 된 요소에 키 프레임을 적용하여 이러한 제한을 극복하는 것을 보았으므로 이러한 문제를 처리 할 필요가 없습니다.
 

그러나 JavaScript의 WAAPI (Web Animation API)에는 추가 애니메이션을 수행하는 방법이 있습니다.
 옵션에`composite : "add"`를 추가하는 문제입니다.
 예를 들면 :
 

> 여백이 남아있는 상태로 항목을 20px + 30px 이동하는 경우에도 마찬가지입니다 (객체를 이동하는 가장 성능이 좋은 방법은 아니지만 길이 사용량을 보여줍니다). 애니메이션이 같은 시간에 같은 방향으로 동시에 실행되는 경우
 , 최종 결과는 50px의 움직임이됩니다.
 

멋있는.
 JavaScript 애니메이션에는 좋지만 CSS는 어떻습니까?
 우리는 그것을 얻을 수 있습니까?
 아마도.
 지금도 JavaScript 한 줄로 기존 CSS 애니메이션에 추가 애니메이션을 적용 할 수 있습니다.
 

```js
el.getAnimations().forEach(animation => {
  animation.effect.composite = 'add';
});
```

불확실한 체크 박스가 떠 오릅니다.
 그것들은 존재하지만 HTML이나 CSS로 표현할 수있는 방법이 없습니다. 자바 스크립트를 통해 그 상태에 넣어야합니다.
 

직접 링크 →
 