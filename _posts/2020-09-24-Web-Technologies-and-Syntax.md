---
layout: post
title: "웹 기술 및 구문"
author: 'CSS Dev'
thumbnail: undefined
tags: !IMPORTANT,OPTIONAL CHAINING
---


JavaScript에는 선택적 체인이라고 하는 (새로운) 기능이 있습니다. 다음과 같은 코드가 있다고 말합니다.

```html
const name = Data.person.name;
```

만약 `데이터`에 `사람`이 존재하지 않는다면, 나는 힘들고, 멈추는 오류를 갖게 될 것이다. 선택적 체인으로 다음을 쓸 수 있습니다.

```html
const name = Data.person?.name;
```

이제 사람이 없으면 이름은 오류를 발생시키지 않고 정의되지 않은 이름이 된다. 당신이 나에게 물어보면 그것은 꽤 유용하다. 어떻게 보면, 완전히 폭발하는 스크립트의 가능성이 적기 때문에, 그것은 더 탄력적인 코드를 만든다. 하지만 실제로 복원력이 떨어지는 코드라는 주장이 있습니다. 문제를 근본 수준(불량 데이터)에서 해결하는 대신 문제에 반창고를 붙이기 때문입니다.

짐 닐슨은 CSS에서 옵션 체인과 `!!`의 연결을 중요하게 한다. "정의되지 않은 속성"의 오류는 모든 JavaScript 오류 중 가장 일반적인 것일 수 있으며 선택적 체인은 빠른 해결 방법입니다. 원하는 대로 캐스케이드하지 않는 스타일은 (아마도?) 모든 CSS 문제 중 가장 일반적인 문제와 `!중요`는 빠른 해결 방법입니다.

> CSS에 익숙한 사람이라면 누구나 '!중요'를 사용한다고 해서 문제가 항상 해결되는 것은 아니라는 것을 안다. 사실, 그것은 당신에게 더 많은 문제를 일으킬지도 모릅니다. JavaScript에서 선택적 체인을 위해 편집하면 수정보다 더 많은 문제가 발생할 수 있습니다(아직 충분히 오래되지 않았기 때문에 아직 알 수 없습니다).

그 테이크 맘에 들어

새로운 기능에 대해 부정적인 견해를 갖는 것은 단지 클릭 한 번으로 바보 같은 짓일 뿐이지만, 때때로 생각할 좋은 점들이 묻혀 있다. 옵션 체인은 CSS에 있는 `!중요`와 같이 자바스크립트에서 멋진 패턴으로 정착될 것입니다. 최근 내가 듣는 CSS의 중요!에 대한 가장 많은 잡담은 진심에서 우러나올 때 그것을 어떻게 사용해야 하는지에 관한 것이다.

직접 링크 →