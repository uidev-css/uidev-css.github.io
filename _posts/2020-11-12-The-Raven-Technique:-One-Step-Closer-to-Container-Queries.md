---
layout: post
title: "레이븐 기법 : 컨테이너 쿼리에 한 걸음 더 가까움
 "
author: 'CSS Dev'
thumbnail: undefined
tags: CALC,CLAMP,CONTAINER-QUERIES,MAX,MIN,RESPONSIVE
---


백만 번째 : CSS에서 컨테이너 쿼리가 필요합니다!
 그리고 우리가 그 방향으로 가고있는 것처럼 보입니다.
 

웹 사이트 용 구성 요소를 만들 때 해당 구성 요소가 어떻게 사용되는지 항상 알 수있는 것은 아닙니다.
 아마도 브라우저 창만큼 넓게 렌더링 될 것입니다.
 아마 두 사람이 나란히 앉을 것입니다.
 좁은 기둥에있을 수도 있습니다.
 너비가 항상 브라우저 창의 너비와 관련이있는 것은 아닙니다.
 

구성 요소의 CSS에 대한 컨테이너 기반 쿼리가 매우 편리한 지점에 도달하는 것이 일반적입니다.
 이에 대한 해결책을 웹에서 검색하면 몇 가지 JavaScript 기반 솔루션을 찾을 수 있습니다.
 그러나 추가 종속성, JavaScript를 필요로하는 스타일링, 오염 된 애플리케이션 논리 및 디자인 논리 등의 대가가 따릅니다.
 

저는 관심사 분리를 강력하게 믿고 있으며 레이아웃은 CSS 문제입니다.
 예를 들어,`IntersectionObserver`만큼 멋진 API처럼 CSS에서`: in-viewport`와 같은 것을 원합니다!
 그래서 CSS 전용 솔루션을 계속 찾고 있었는데 Heydon Pickering의 The Flexbox Holy Albatross를 발견했습니다.
 컬럼에 대한 좋은 솔루션이지만 더 원했습니다.
 원래 알바트 로스 (The Unholy Albatross와 같은)의 일부 개선 사항이 있지만 여전히 약간 엉망이며 일어나는 모든 일은 행에서 열로 전환하는 것입니다.
 

나는 여전히 더 원한다!
 실제 컨테이너 쿼리에 더 가까워지고 싶습니다!
 그렇다면 CSS에는 제가 활용할 수있는 제안이 무엇입니까?
 저는 수학적 배경이 있으므로`calc ()`,`min ()`,`max ()`및`clamp ()`와 같은 함수는 제가 좋아하고 이해하는 것입니다.
 

다음 단계 : 컨테이너 쿼리와 유사한 솔루션을 구축합니다.
 

계속 읽기 전에 무엇이 가능한지 알고 싶으십니까?
 다음은이 기사에서 논의한 아이디어로 무엇을 할 수 있는지 보여주는 CodePen 컬렉션입니다.
 

### 왜 "Raven"입니까?
 

이 작품은 Heydon의 알바트 로스에서 영감을 얻었지만이 기술은 더 많은 트릭을 할 수 있기 때문에 까마귀는 매우 영리한 새이기 때문에 까마귀를 선택했습니다.
 

### 요약 : CSS의 수학 함수
 

`calc ()`함수는 CSS에서 수학 연산을 허용합니다.
 보너스로 단위를 결합 할 수 있으므로`calc (100vw-300px)`와 같은 것도 가능합니다.
 

`min ()`및`max ()`함수는 두 개 이상의 인수를 취하고 가장 작은 또는 가장 큰 인수를 각각 반환합니다.
 

`clamp ()`함수는 매우 유용한 방식으로`min ()`과`max ()`의 조합과 같습니다.
 함수`clamp (a, x, b)`는 다음을 반환합니다.
 

- x가 a보다 작 으면 a
 
- b x가 b보다 크고
 
- x가 a와 b 사이에 있으면 x
 

그래서 그것은`clamp (smallest, relative, large)`와 비슷합니다.
 이를`min (max (a, x), b)`의 약자로 생각할 수 있습니다.
 자세한 내용을 보려면 여기에 대한 자세한 정보가 있습니다.
 

이 기사에서는 또 다른 CSS 도구 인 CSS 사용자 정의 속성을 사용할 것입니다.
 `--color : red;`또는`--distance : 20px`와 같은 것입니다.
 본질적으로 변수.
 우리는 그것들을 너무 많이 반복하지 않는 것처럼 CSS를 깔끔하게 유지하기 위해 사용할 것입니다.
 

이 Raven 기술을 시작하겠습니다.
 

### 1 단계 : 구성 변수 만들기
 

설정을위한 몇 가지 CSS 사용자 정의 속성을 만들어 보겠습니다.
 

쿼리의 기반이되는 기본 크기는 무엇입니까?
 컨테이너 쿼리 동작을 촬영하고 있으므로 `100 %`가됩니다. `100vw`를 사용하면 컨테이너가 아니라 브라우저 창의 너비이기 때문에 미디어 쿼리처럼 동작합니다.
 

```css
--base_size: 100%;
```

이제 중단 점에 대해 생각합니다.
 말 그대로 새로운 스타일을 적용하기 위해 나누기를 원하는 컨테이너 너비.
 

```css
--breakpoint_wide: 1500px; 
/* Wider than 1500px will be considered wide */
--breakpoint_medium: 800px;
/* From 801px to 1500px will be considered medium */
/* Smaller than or exact 800px will be small */
```

실행 예제에서는 세 개의 간격을 사용하지만이 기술에는 제한이 없습니다.
 

이제 중단 점으로 정의 된 간격에 대해 반환 될 일부 (CSS 길이) 값을 정의 해 보겠습니다.
 다음은 리터럴 값입니다.
 

```css
--length_4_small: calc((100% / 1) - 10px); /* Change to your needs */
--length_4_medium: calc((100% / 2) - 10px); /* Change to your needs */
--length_4_wide: calc((100% / 3) - 10px); /* Change to your needs */
```

이것이 구성입니다.
 사용합시다!
 

### 2 단계 : 지표 변수 생성
 

간격에 대한 몇 가지 지표 변수를 생성합니다.
 부울 값과 비슷하지만 길이 단위 (`0px` 및`1px`)를 사용합니다.
 이러한 길이를 최소값과 최대 값으로 고정하면 일종의 "참"및 "거짓"표시기 역할을합니다.
 

따라서`--base_size`가`--breakpoint_wide`보다 큰 경우에만`1px` 인 변수를 원합니다.
 그렇지 않으면`0px`를 원합니다.
 이것은`clamp ()`로 할 수 있습니다 :
 

```css
--is_wide: clamp(0px,
  var(--base_size) - var(--breakpoint_wide),
  1px
);
```

`var (-base_size)-var (-breakpoint_wide)`가 음수이면`--base_size`가`--breakpoint_wide`보다 작으므로이 경우`clamp ()`는`0px`를 반환합니다.
 

반대로`--base_size`가`--breakpoint_wide`보다 크면 계산은`1px`보다 크거나 같은 양의 길이를 제공합니다.
 즉,`clamp ()`는`1px`를 반환합니다.
 

빙고!
 "wide"에 대한 표시 변수가 있습니다.
 

"중간"간격에 대해이 작업을 수행합니다.
 

```css
--is_medium: clamp(0px,
  var(--base_size) - var(--breakpoint_medium),
  1px
); /*  DO NOT USE, SEE BELOW! */
```

이것은 우리에게 작은 간격의 경우 `0px`를 제공하지만 중간 및 넓은 간격의 경우 `1px`를 제공합니다.
 그러나 우리가 원하는 것은 넓은 간격의 경우 `0px`이고 중간 간격의 경우에만 `1px`입니다.
 

`--is_wide` 값을 빼서이 문제를 해결할 수 있습니다.
 넓은 간격에서 `1px-1px`는 `0px`입니다.
 중간 간격에서`1px-0px`는`1px`입니다.
 그리고 작은 간격의 경우`0px-0px`는`0px`를 제공합니다.
 완전한.
 

그래서 우리는 다음을 얻습니다.
 

```css
--is_medium: calc(
  clamp(0px, 
  var(--base_size) - var(--breakpoint_medium), 
  1px) 
  - var(--is_wide)
); 
```

아이디어가 보이십니까?
 표시기 변수를 계산하려면 테두리로`0px` 및`1px`를 사용하고 고정 된 값으로`--base_width` 및`--breakpoint_whatever`의 차이를 사용하여`clamp ()`를 사용합니다.
 그런 다음 더 큰 간격에 대해 모든 지표의 합계를 뺍니다.
 이 논리는 최소 간격 표시기에 대해 다음을 생성합니다.
 

```css
--is_small: calc(
  clamp(0px,
    (var(--base_size) - 0px,
    1px)
  - (var(--is_medium) + var(--is_wide))
); 
```

small의 중단 점이`0px`이고`--base_size`가 양수이므로 여기서 클램프를 건너 뛸 수 있습니다. 따라서`--base_size-0px`는 항상`1px`보다 크고`clamp ()`는 항상`1px를 반환합니다.
 `.
 따라서`--is_small`의 계산을 다음과 같이 단순화 할 수 있습니다.
 

```css
--is_small: calc(1px - (var(--is_medium) + var(--is_wide))); 
```

### 3 단계 : 지표 변수를 사용하여 간격 값 선택
 

이제 이러한 "지표 변수"에서 유용한 것으로 이동해야합니다.
 픽셀 기반 레이아웃으로 작업한다고 가정 해 보겠습니다.
 당황하지 마십시오. 나중에 다른 장치를 처리합니다.
 

여기에 질문이 있습니다.
 이것은 무엇을 반환합니까?
 

```css
calc(var(--is_small) * 100);
```

`--is_small`이`1px`이면`100px`를 반환하고`--is_small`이`0px`이면`0px`를 반환합니다.
 

이것이 어떻게 유용합니까?
 이것 좀 봐:
 

```css
calc(
  (var(--is_small) * 100) 
  +
  (var(--is_medium) * 200) 
);
```

그러면 작은 간격으로`100px + 0px = 100px`가 반환됩니다 (여기서`--is_small`은`1px`이고`--is_medium`은`0px`입니다).
 중간 간격 (`--is_medium`은`1px`이고`--is_small`은`0px`)에서`0px + 200px = 200px`를 반환합니다.
 

아이디어를 얻었습니까?
 이해하기 복잡 할 수 있으므로 여기서 진행되는 작업에 대해 자세히 알아 보려면 Roman Komarov의 기사를 참조하십시오.
 

픽셀 값 (단위 없음)에 해당 표시기 변수를 곱하고이 모든 항을 합산합니다.
 따라서 픽셀 기반 레이아웃의 경우 다음과 같이 충분합니다.
 

```css
width: calc(
    (var(--is_small)  * 100) 
  + (var(--is_medium) * 200) 
  + (var(--is_wide)   * 500) 
  );

```

하지만 대부분의 경우 우리는 픽셀 기반 값을 원하지 않습니다.
 "전체 너비"또는 "세 번째 너비"와 같은 개념 또는 `2rem`, `65ch`등과 같은 다른 단위를 원합니다.
 우리는 여기에 계속 가야합니다.
 

### 4 단계 :`min ()`과 엄청나게 큰 정수를 사용하여 임의 길이 값 선택
 

첫 번째 단계에서는 정적 픽셀 값 대신 다음과 같이 정의했습니다.
 

```css
--length_4_medium: calc((100% / 2) - 10px);
```

그러면 어떻게 사용할 수 있습니까?
 구조에`min ()`함수!
 

하나의 도우미 변수를 정의 해 보겠습니다.
 

```css
--very_big_int: 9999; 
/* Pure, unitless number. Must be bigger than any length appearing elsewhere. */
```

이 값에 인디케이터 변수를 곱하면`0px` 또는`9999px`가됩니다.
 이 값의 크기는 브라우저에 따라 다릅니다.
 Chrome은 `999999`를 사용하지만 Firefox는 높은 숫자를 허용하지 않으므로 `9999`는 둘 다에서 작동하는 값입니다.
 주변에`9999px`보다 큰 뷰포트가 거의 없으므로 괜찮습니다.
 

그렇다면 우리가`9999px`보다 작지만`0px`보다 큰 값으로 이것을`min ()`하면 어떻게 될까요?
 

```css
min(
  var(--length_4_small), 
  var(--is_small) * var(--very_big_int) 
);
```

`--is_small`이`0px` 인 경우에만`0px`를 반환합니다.
 `--is_small`이`1px`이면 곱셈은`9999px` (`--length_4_small`보다 큼)를 반환하고`min`은`--length_4_small`을 반환합니다.
 

이것이 인디케이터 변수에 따라 길이 (즉,`9999px`보다 작지만`0px`보다 큼)를 선택할 수있는 방법입니다.
 

9999px보다 큰 뷰포트를 처리하는 경우`--very_big_int` 변수를 조정해야합니다.
 이것은 약간 못 생겼지 만 순수 CSS가 표시기 변수에서 단위를 제거하기 위해 값에 단위를 떨어 뜨릴 수있는 순간에 수정할 수 있습니다 (그리고 길이에 직접 곱하기).
 지금은 작동합니다.
 

이제 모든 부품을 결합하여 레이븐을 날리게 만들 것입니다!
 

### 5 단계 : 모두 통합
 

이제 다음과 같이 동적 컨테이너 너비 기반의 중단 점 기반 값을 계산할 수 있습니다.
 

```css
--dyn_length: calc(
    min(var(--is_wide)   * var(--very_big_int), var(--length_4_wide)) 
  + min(var(--is_medium) * var(--very_big_int), var(--length_4_medium))
  + min(var(--is_small)  * var(--very_big_int), var(--length_4_small))
);

```

각 라인은 4 단계의 `min ()`입니다. 모든 라인은 3 단계와 같이 합산되고 표시기 변수는 2 단계에서 생성되었으며 모두 1 단계에서 수행 한 구성을 기반으로합니다.
 공식!
 

그것을 시도하고 싶습니까?
 여기에 사용할 펜이 있습니다 (CSS의 메모 참조).
 

이 펜은 flexbox, 그리드, 플로트를 사용하지 않습니다.
 일부 div.
 이것은 이러한 종류의 레이아웃에서 도우미가 불필요하다는 것을 보여주기위한 것입니다.
 하지만 더 복잡한 레이아웃을 수행하는 데 도움이되므로 이러한 레이아웃과 함께 Raven을 자유롭게 사용하십시오.
 

### 다른 건 없나요?
 

지금까지 고정 픽셀 값을 중단 점으로 사용했지만 컨테이너가 뷰포트의 절반에서 10px를 뺀 크기보다 크거나 작 으면 레이아웃을 변경하고 싶습니까?
 문제 없어요:
 

```css
--breakpoint_wide: calc(50vw - 10px);
```

작동합니다!
 다른 수식도 작동합니다.
 이상한 동작을 피하기 위해 다음과 같은 것을 사용하고 싶습니다.
 

```css
--breakpoint_medium: min(var(--breakpoint_wide), 500px);
```

… `500px`너비로 두 번째 중단 점을 설정합니다.
 2 단계의 계산은`--breakpoint_wide`가`--breakpoint_medium`보다 작지 않다는 사실에 따라 달라집니다.
 중단 점을 올바른 순서로 유지하십시오.`min ()`및 / 또는`max ()`는 여기서 매우 유용합니다!
 

### 높이는 어떻습니까?
 

모든 계산의 평가는 느리게 수행됩니다.
 즉,`--dyn_length`를 속성에 할당 할 때 계산은이 위치에서`--base_size`가 평가하는 모든 것을 기반으로합니다.
 따라서 높이 설정은`--base_size`가`100 %`인 경우 100 % 높이를 기준으로 중단 점을 설정합니다.
 

컨테이너의 너비에 따라 높이를 설정하는 방법을 (아직) 찾지 못했습니다.
 따라서`100 %`는 패딩 너비로 평가되므로`padding-top`을 사용할 수 있습니다.
 

### 사물을 표시하고 숨기는 것은 어떻습니까?
 

Raven 방식으로 사물을 표시하고 숨기는 가장 간단한 방법은 적절한 표시기 변수에서 너비를 `100px`(또는 다른 적절한 너비)로 설정하는 것입니다.
 

```css
.show_if_small {
  width: calc(var(--is_small) * 100);
}
.show_if_medium {
  width: calc(var(--is_medium) * 100);
}
.show_if_wide {
  width: calc(var(--is_wide) * 100);
}
```

다음을 설정해야합니다.
 

```css
overflow: hidden;
display: inline-block; /* to avoid ugly empty lines */
```

… 또는`width : 0px` 상자 안에 사물을 숨기는 다른 방법.
 상자를 완전히 숨기려면`margin`,`padding` 및`border-width`를 포함한 추가 상자 모델 속성을`0px`로 설정해야합니다.
 Raven은 일부 속성에 대해이 작업을 수행 할 수 있지만 `0px`로 수정하는 것만 큼 효과적입니다.
 

또 다른 대안은`position : absolute;`를 사용하고`left : calc (var (-is _ ???) * 9999);`를 통해 요소를 화면 밖으로 그리는 것입니다.
 

### 테이크 아웃
 

컨테이너 쿼리 동작의 경우에도 JavaScript가 전혀 필요하지 않을 수 있습니다!
 확실히 우리는 실제로 CSS 구문에서 컨테이너 쿼리를 가져 오면 사용하고 이해하기가 훨씬 더 쉬울 것이지만 오늘날 CSS에서 모든 것이 가능하다는 것도 매우 멋집니다.
 

이 작업을하는 동안 CSS가 사용할 수있는 다른 것들에 대한 몇 가지 의견을 개발했습니다.
 

- 너비에 따라 높이를 설정하는`conW` 및`conH`와 같은 컨테이너 기반 단위.
 이러한 단위는 현재 스택 컨텍스트의 루트 요소를 기반으로 할 수 있습니다.
 
- 게으른 평가의 문제를 극복하기위한 일종의 "가치 평가"기능.
 이것은 렌더링 시간에 작동하는 "strip unit"기능과 잘 작동합니다.
 

참고 : 이전 버전에서는 단위에`cw`와`ch`를 사용했지만 이름이 같은 CSS 단위와 쉽게 혼동 될 수 있다는 점이 지적되었습니다.
 팁에 대한 의견에 Mikko Tapionlinna와 Gilson Nunes Filho에게 감사드립니다!)
 

두 번째 것이 있으면 색상 (깨끗한 방식으로), 테두리,`box-shadow`,`flex-grow`,`background-position`,`z-index`,`scale ()을 설정할 수 있습니다.
 )`및 기타 레이븐과 함께.
 

구성 요소 기반 단위와 함께 하위 치수를 상위와 동일한 종횡비로 설정하는 것도 가능합니다.
 단위로 값을 나눌 수 없습니다.
 그렇지 않으면`--indicator / 1px`가 Raven의 "스트립 단위"로 작동합니다.
 

### 보너스 : 부울 논리
 

표시기 변수는 부울 값처럼 보입니다. 그렇죠?
 유일한 차이점은 "px"단위가 있다는 것입니다.
 그것들의 논리적 조합은 어떻습니까?
 "컨테이너가 화면의 절반보다 넓습니다"및 "레이아웃이 2 열 모드에 있습니다."와 같은 것을 상상해보십시오.
 CSS 기능이 다시 구출됩니다!
 

`OR` 연산자의 경우 모든 인디케이터에 대해`max ()`를 사용할 수 있습니다.
 

```css
--a_OR_b: max( var(--indicator_a) , var(--indicator_b) );

```

`NOT`연산자의 경우 `1px`에서 표시기를 뺄 수 있습니다.
 

```css
--NOT_a: calc(1px - var(--indicator_a));

```

논리 순수 주의자는`NOR (a, b) = NOT (OR (a, b))`가 완전한 부울 대수이기 때문에 여기서 멈출 수 있습니다.
 하지만 재미를 위해 여기에 몇 가지 더 있습니다.
 

`그리고`:
 

```css
--a_AND_b: min(var(--indicator_a), var(--indicator_b)); 

```

두 표시기가 모두 `1px`인 경우에만 `1px`로 평가됩니다.
 

`min ()`및`max ()`는 두 개 이상의 인수를 사용합니다.
 두 개 이상의 표시기 변수에 대해 여전히 `AND`및 `OR`로 작동합니다.
 

`XOR` :
 

```css
--a_XOR_b: max(
  var(--indicator_a) - var(--indicator_b), 
  var(--indicator_b) - var(--indicator_a)
);

```

두 인디케이터가 동일한 값을 갖는 경우 (만) 두 개의 차이는 모두`0px`이고`max ()`는이를 반환합니다.
 표시기의 값이 다른 경우 한 용어는 `-1px`를, 다른 용어는 `1px`를 제공합니다.
 이 경우`max ()`는`1px`를 반환합니다.
 

두 지표가 동일한 경우에 관심이있는 사람이 있으면 다음을 사용하십시오.
 

```css
--a_EQ_b: calc(1px - 
  max(
    var(--indicator_a) - var(--indicator_b), 
    var(--indicator_b) - var(--indicator_a)
  )
);

```

그리고 네, 이것은`NOT (a XOR b)`입니다.
 나는 이에 대한 "더 좋은"해결책을 찾을 수 없었습니다.
 

평등은 단순히 표시기 변수에 사용되는 것이 아니라 일반적으로 CSS 길이 변수에 대해 흥미로울 수 있습니다.
 `clamp ()`를 다시 사용하면 도움이 될 수 있습니다.
 

```css
--a_EQUALS_b_general: calc(
  1px -
  clamp(0px,
        max(
          var(--var_a) - var(--var_b),
          var(--var_b) - var(--var_a)
        ),
        1px)
  );

```

단위없는 변수 (정수)에 대한 일반적인 동등성을 얻으려면`px` 단위를 제거하십시오.
 

나는 이것이 대부분의 레이아웃에 대해 충분한 부울 논리라고 생각합니다!
 

### 보너스 2 : 그리드 레이아웃의 열 수 설정
 

Raven은 CSS 길이 값을 반환하도록 제한되어 있기 때문에 그리드의 열 수를 직접 선택할 수 없습니다 (단위가없는 값이기 때문에).
 그러나 작동하도록하는 방법이 있습니다 (위와 같이 표시기 변수를 선언했다고 가정).
 

```css
--number_of_cols_4_wide: 4;
--number_of_cols_4_medium: 2;
--number_of_cols_4_small: 1;
--grid_gap: 0px;

--grid_columns_width_4_wide: calc(
(100% - (var(--number_of_cols_4_wide) - 1) * var(--grid_gap) ) / var(--number_of_cols_4_wide));
--grid_columns_width_4_medium: calc(
(100% - (var(--number_of_cols_4_medium) - 1) * var(--grid_gap) ) / var(--number_of_cols_4_medium));
--grid_columns_width_4_small: calc(
(100% - (var(--number_of_cols_4_small) - 1) * var(--grid_gap) ) / var(--number_of_cols_4_small));

--raven_grid_columns_width: calc( /*  use the Raven to combine the values  */
  min(var(--is_wide) * var(--very_big_int),var(--grid_columns_width_4_wide)) 
  + min(var(--is_medium) * var(--very_big_int),var(--grid_columns_width_4_medium))
  + min(var(--is_small) * var(--very_big_int),var(--grid_columns_width_4_small))
  );
```

다음으로 그리드를 설정하십시오.
 

```css
.grid_container{
  display: grid;
  grid-template-columns: repeat(auto-fit, var(--raven_grid_columns_width));
  gap: var(--grid_gap)
};
```

어떻게 작동합니까?
 

- 각 간격에 대해 원하는 열 수를 정의합니다 (1, 2, 3 행).
 
- 각 간격 (5, 6, 7 행)에 대한 열의 완벽한 너비를 계산합니다.
여기서 무슨 일이 일어나고 있습니까?
먼저 열에 사용할 수있는 공간을 계산합니다.
 이것은 `100 %`에서 틈새가 차지할 위치를 뺀 값입니다.
 `n` 열의 경우`(n-1)`간격이 있습니다.
 그런 다음이 공간을 원하는 열 수로 나눕니다.
 
- Raven을 사용하여 실제`--base_size`에 대한 오른쪽 열의 너비를 계산합니다.
 

그리드 컨테이너에서이 행은 다음과 같습니다.
 

```css
grid-template-columns: repeat(auto-fit, var(--raven_grid_columns_width));
```

… 그런 다음 Raven이 제공 한 값에 맞도록 열 수를 선택합니다 (위에서`--number_of_cols_4 _ ???`변수가 생성됨).
 

Raven은 열 수를 직접 제공 할 수 없지만`repeat` 및`autofit`이 우리가 원하는 수를 계산할 수 있도록 길이를 제공 할 수 있습니다.
 

하지만`minmax ()`를 사용한`auto-fit`은 같은 일을합니다. 맞죠?
 아니!
 위의 솔루션은 3 개 (또는 5 개) 열을 제공하지 않으며 컨테이너 너비에 따라 열 수를 늘릴 필요가 없습니다.
 이 펜에서 다음 값을 설정하여 Raven이 완전히 비행하는 것을 확인하십시오.
 

```css
--number_of_cols_4_wide: 1;
--number_of_cols_4_medium: 2;
--number_of_cols_4_small: 4;
```

### 보너스 3 :`linear-gradient ()`로`background-color` 변경
 

이것은 좀 더 마음을 굽히는 것입니다.
 까마귀는 길이 값에 관한 것입니다. 그렇다면 어떻게 색상을 얻을 수 있습니까?
 음, 선형 그래디언트는 둘 다 처리합니다.
 길이 값으로 정의 된 특정 영역의 색상을 정의합니다.
 코드를 시작하기 전에이 개념을 자세히 살펴 보겠습니다.
 

실제 그래디언트 부분을 해결하려면 색상 정지를 두 배로 늘려서 `0px`내에서 그래디언트 부분을 효과적으로 만드는 것이 잘 알려진 기술입니다.
 이것이 어떻게 수행되는지 보려면이 코드를보십시오.
 

```css
background-image:linear-gradient(
  to right,
  red 0%,
  red 50%,
  blue 50%,
  blue 100%
);
```

그러면 배경이 왼쪽에 빨간색, 오른쪽이 파란색이됩니다.
 첫 번째 인수는 "오른쪽으로"입니다.
 이는 백분율 값이 왼쪽에서 오른쪽으로 수평으로 평가됨을 의미합니다.
 

Raven 변수를 통해 `50 % `값을 제어하면 원하는대로 색상 중지를 변경할 수 있습니다.
 그리고 더 많은 색상 정지 점을 추가 할 수 있습니다.
 실행 예제에서는 세 가지 색상이 필요하므로 내부 색상 중지가 두 배가됩니다.
 

색상 및 색상 중지에 대한 몇 가지 변수를 추가하면 다음과 같은 결과를 얻을 수 있습니다.
 

```css
background-image: linear-gradient(
  to right,
  var(--color_small) 0px,
  var(--color_small) var(--first_lgbreak_value),
  var(--color_medium) var(--first_lgbreak_value),
  var(--color_medium) var(--second_lgbreak_value),
  var(--color_wide) var(--second_lgbreak_value),
  var(--color_wide) 100%
);
```

하지만`--first_lgbreak_value`와`--second_lgbreak_value`의 값을 어떻게 계산할까요?
 보자.
 

첫 번째 값은`--color_small`이 표시되는 위치를 제어합니다.
 작은 간격에서는 `100 %`, 다른 간격에서는 `0px`이어야합니다.
 까마귀로 이것을하는 방법을 보았습니다.
 두 번째 변수는`--color_medium`의 가시성을 제어합니다.
 작은 간격의 경우 `100 %`, 중간 간격의 경우 `100 %`, 넓은 간격의 경우 `0px`여야합니다.
 컨테이너 너비가 작은 간격 또는 중간 간격 인 경우 해당 표시기는 `1px`여야합니다.
 

인디케이터에서 부울 논리를 수행 할 수 있으므로 다음과 같습니다.
 

```css
max(--is_small, --is_medium)
```

… 올바른 지표를 얻으려면.
 이것은 다음을 제공합니다.
 

```css
--first_lgbreak_value: min(var(--is_small) * var(--very_big_int), 100%);
--second_lgbreak_value: min(
  max(var(--is_small), var(--is_medium)) * var(--very_big_int), 100%);

```

조합하면이 CSS 코드가 너비에 따라 `배경색`을 변경합니다 (간격 표시기는 위와 같이 계산 됨).
 

```css
--first_lgbreak_value: min(
      var(--is_small) * var(--very_big_int), 100%);
--second_lgbreak_value: min(
    max(var(--is_small), var(--is_medium)) * var(--very_big_int), 100%);

--color_wide: red;/* change to your needs*/
--color_medium: green;/* change to your needs*/
--color_small: lightblue;/* change to your needs*/

background-image: linear-gradient(
  to right,
  var(--color_small) 0px,
  var(--color_small) var(--first_lgbreak_value),
  var(--color_medium) var(--first_lgbreak_value),
  var(--color_medium) var(--second_lgbreak_value),
  var(--color_wide) var(--second_lgbreak_value),
  var(--color_wide) 100%
);
```

작동 방식을 볼 수있는 펜이 있습니다.
 

### 보너스 4 : 중첩 변수 제거
 

Raven으로 작업하는 동안 이상한 문제가 발생했습니다.`calc ()`에서 사용할 수있는 중첩 변수의 수에 제한이 있습니다.
 너무 많은 중단 점을 사용할 때 몇 가지 문제가 발생할 수 있습니다.
 내가 아는 한,이 제한은 스타일을 계산하는 동안 페이지 차단을 방지하고 더 빠른 원 참조 검사를 허용하기위한 것입니다.
 

제 생각에는 가치 평가와 같은 것이 이것을 극복하는 좋은 방법이 될 것입니다.
 그럼에도 불구하고이 제한은 CSS의 한계를 뛰어 넘을 때 골칫거리가 될 수 있습니다.
 이 문제는 앞으로 해결 될 것입니다.
 

(깊이) 중첩 변수 없이도 Raven에 대한 표시 변수를 계산하는 방법이 있습니다.
 `--is_medium` 값에 대한 원래 계산을 살펴 보겠습니다.
 

```css
--is_medium:calc(
  clamp(0px, 
        var(--base_size) - var(--breakpoint_medium), 
        1px) 
        - var(--is_wide)
); 
```

`--is_wide` 빼기 문제가 발생합니다.
 이로 인해 CSS 파서가`--is_wide`의 전체 공식 정의에 붙여 넣습니다.
 `--is_small`의 계산에는 이러한 유형의 참조가 더 많이 있습니다.
 (`--is_wide`에 대한 정의는`--is_medium`의 정의 내에 숨겨져 있고 직접 사용되기 때문에 두 번 붙여 넣기도합니다.)
 

다행히도 더 큰 중단 점에 대한 지표를 참조하지 않고 지표를 계산하는 방법이 있습니다.
 

표시기는`--base_size`가 간격의 하위 중단 점보다 크고 간격의 상위 중단 점보다 작거나 같은 경우에만 참입니다.
 이 정의는 다음 코드를 제공합니다.
 

```css
--is_medium: 
  min(
    clamp(0px, var(--base_size) - var(--breakpoint_medium), 1px),
    clamp(0px, 1px + var(--breakpoint_wide) - var(--base_size), 1px)
  );

```

- `min ()`은 논리 AND 연산자로 사용됩니다.
 
- 첫 번째`clamp ()`는 "`--base_size`가`--breakpoint_medium`보다 큽니다."
 
- 두 번째`clamp ()`는 "`--base_size`가`--breakpoint_wide`보다 작거나 같음"을 의미합니다.
 
- `1px`스위치를 `작음`에서 `작거나 같음`으로 추가합니다.
 이것은 우리가 정수 (픽셀) 숫자를 다루기 때문에 작동합니다 (`a <= b`는 정수에 대해`a <(b + 1)`을 의미합니다).
 

표시기 변수의 전체 계산은 다음과 같이 수행 할 수 있습니다.
 

```css
--is_wide: clamp(0px, var(--base_size) - var(--breakpoint_wide), 1px);

--is_medium: min(clamp(0px, var(--base_size) - var(--breakpoint_medium), 1px),
                 clamp(0px, 1px + var(--breakpoint_wide) - var(--base_size), 1px)
             );

--is_small: clamp(0px,1px + var(--breakpoint_medium) - var(--base_size), 1px);

```

`--is_wide` 및`--is_small`에 대한 계산은 더 간단합니다. 각각에 대해 하나의 주어진 중단 점 만 확인하면되기 때문입니다.
 

이것은 우리가 지금까지 살펴본 모든 것에 적용됩니다.
 여기에 예제를 결합한 펜이 있습니다.
 

### 마지막 생각들
 verified_user

Raven은 미디어 쿼리가 할 수있는 모든 일을 할 수 없습니다.
 하지만 CSS에 미디어 쿼리가 있기 때문에 그렇게 할 필요는 없습니다.
 사이드 바 위치 나 메뉴 재구성과 같은 "큰"디자인 변경에 사용하는 것이 좋습니다.
 이러한 일은 전체 뷰포트 (브라우저 창의 크기) 컨텍스트 내에서 발생합니다.
 

그러나 구성 요소의 경우 미디어 쿼리는 구성 요소의 크기를 알 수 없기 때문에 다소 잘못되었습니다.
 

Heydon Pickering은이 이미지로이 문제를 보여주었습니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/10/RT_x4UFA.png?resize=1200%2C482&ssl=1)

Raven이 컴포넌트에 대한 반응 형 레이아웃을 만드는 문제를 극복하고 "CSS로 수행 할 수있는 작업"의 한계를 조금 더 밀어 붙이는 데 도움이되기를 바랍니다.
 

오늘날 가능한 것을 보여줌으로써 "실제"컨테이너 쿼리는 구문 설탕과 아주 작은 새로운 함수 (`conW`,`conH`, "strip-unit"또는 "evaluate-to-pixels"등)를 추가하여 수행 할 수 있습니다.
 ).
 CSS에 "`1px`"를 공백으로 다시 쓰고 "`0px`"를 "`initial`"으로 다시 쓸 수있는 함수가 있다면 Raven을 Custom Property Toggle Trick과 결합하여 모든 CSS 속성을 변경할 수 있습니다.
 길이 값뿐만 아니라
 

이를 위해 자바 스크립트를 피하면 자바 스크립트 다운로드 또는 실행에 의존하지 않기 때문에 레이아웃이 더 빠르게 렌더링됩니다.
 자바 스크립트가 비활성화되어 있어도 상관 없습니다.
 이러한 계산은 메인 스레드를 차단하지 않으며 애플리케이션 로직이 설계 로직으로 복잡하지 않습니다.
 

훌륭한 CSS-Tricks 기사를 제공해 주신 Chris, Andrés Galante, Cathy Dutton, Marko Ilic 및 David Atanda에게 감사드립니다.
 그들은 내가 Raven으로 무엇을 할 수 있는지 탐구하는 데 정말로 도움이되었습니다.
 