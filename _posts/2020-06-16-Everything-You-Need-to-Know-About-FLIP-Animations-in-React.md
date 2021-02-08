---
layout: post
title: "FLIP 애니메이션에 대해 알아야 할 모든 정보 반응"
author: "Uidev Css"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/06/react-flip.png"
tags: FLIP,REACT,WEB ANIMATION API
---


최신 Safari 업데이트로 웹 애니메이션 API(Web Animations API)가 현재 모든 최신 브라우저(IE 제외)에서 플래그 없이 지원됩니다. 다음은 브라우저에서 지원하는 기능을 확인할 수 있는 편리한 펜입니다. WAAPI는 네이티브이기 때문에 애니메이션(JavaScript에서 수행되어야 함)을 수행할 수 있는 좋은 방법입니다. 즉, 작동하는 데 추가 라이브러리가 필요하지 않습니다. WAAPI를 완전히 처음 접하셨다면 Dan Wilson의 좋은 소개를 들어보겠습니다.

애니메이션에 대한 가장 효율적인 접근법 중 하나는 FLIP입니다. FLIP은 약간의 자바스크립트를 필요로 한다.

WAAPI, FLIP을 사용하고 이를 React에 통합하는 교차점에 대해 살펴보겠습니다. 먼저 리액션 없이 시작할게요. 그리고 나서 시작하죠.

### FLIP 및 WAAPI

FLIP 애니메이션은 WAAPI를 통해 훨씬 더 쉽게 제작됩니다!

플립의 빠른 리프레셔: 중요한 아이디어는 여러분이 원하는 요소를 먼저 배치하는 것입니다. 그런 다음 변환을 적용하여 시작 위치로 이동합니다. 그런 다음 해당 변환을 적용 해제합니다.

애니메이션 변환은 매우 효율적이므로 FLIP는 매우 효율적입니다. WAAPI 이전에는 변환 설정을 위해 요소의 스타일을 직접 조작하고 다음 프레임이 설정 해제/반전될 때까지 기다려야 했습니다.

```js
// FLIP Before the WAAPI
el.style.transform = `translateY(200px)`;
 
requestAnimationFrame(() => {
  el.style.transform = '';
});
```

많은 도서관이 이 접근법에 기초하고 있다. 그러나 다음과 같은 몇 가지 문제가 있습니다.

- 모든 것이 거대한 해킹처럼 느껴진다.
- FLIP 애니메이션을 뒤집는 것은 매우 어렵습니다. CSS 변환은 클래스가 제거되면 "무료"로 반전되지만, 여기서는 그렇지 않다. 이전 버전이 실행되는 동안 새 FLIP를 시작하면 결함이 발생할 수 있습니다. 거꾸로 하려면 `getComputedStyles`로 변환 매트릭스를 구문 분석하여 새 애니메이션을 설정하기 전에 현재 치수를 계산하는 데 사용해야 합니다.
- 고급 애니메이션은 거의 불가능합니다. 예를 들어, 스케일링된 부모의 자녀가 왜곡되지 않도록 하려면 각 프레임에 현재 스케일 값에 액세스할 수 있어야 합니다. 변환 행렬을 구문 분석해야만 이 작업을 수행할 수 있습니다.
- 브라우저에 섀시가 많이 있습니다. 예를 들어 Firefox에서 FLIP 애니메이션이 완벽하게 작동하려면 `request AnimationFrame`을 두 번 호출해야 하는 경우가 있습니다.

```js
requestAnimationFrame(() => {
  requestAnimationFrame(() => {
    el.style.transform = '';
  });
});
```

우리는 WAAPI를 사용할 때 이러한 문제를 전혀 얻지 못합니다. 역기능을 이용하면 고통 없이 역기능을 할 수 있다.어린이들에 대한 역척도 가능하다. 그리고 버그가 있을 때 우리는 `요청 애니메이션 프레임`과 같은 것들을 뒤지기보다는 `애니메이션`이나 `역`과 같은 단순한 기능으로만 작업을 하기 때문에 정확한 범인을 정확히 집어내기가 쉽다.

다음은 WAAPI 버전의 개요입니다.

```js
el.classList.toggle('someclass');
const keyframes = /* Calculate the size/position diff */;
el.animate(keyframes, 2000);
```

### 플립 앤 리액션

FLIP 애니메이션이 React에서 작동하는 방식을 이해하려면 일반 JavaScript에서 작동하는 방법과 그 이유를 알아야 합니다. FLIP 애니메이션의 해부도를 불러옵니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/06/JakPwnSa.png?resize=299%2C723&ssl=1)

보라색 배경이 있는 모든 것은 렌더링의 "그림판" 단계 전에 이루어져야 합니다. 그렇지 않으면 잠시 동안 좋지 않은 새로운 스타일을 보게 될 것입니다. 모든 DOM 업데이트가 우리를 위해 이루어졌기 때문에 React의 상황은 조금 더 복잡해집니다.

FLIP 애니메이션의 매직은 브라우저가 그림을 그리기 전에 요소를 변환하는 것입니다. 그럼 리액션의 "전면 페인트" 순간을 어떻게 알 수 있을까요?

use layout effect(레이아웃 효과 사용) 후크를 충족합니다. 만약 여러분이 무엇을 위한 것인지 궁금하다면… 바로 이것입니다! 이 콜백에 전달된 모든 작업은 DOM 업데이트 후 페인트 전에 동기적으로 수행됩니다. 다시 말해, 이곳은 FLIP를 설정하기에 좋은 장소입니다!

이제 FLIP 기술이 DOM 위치 애니메이션에 매우 유용한 작업을 해보겠습니다. 요소가 한 DOM 위치에서 다른 DOM 위치로 이동하는 방식을 애니메이션화하려는 경우 CSS가 할 수 있는 일은 없습니다. (아래 펜의 항목을 클릭할 때와 같이 작업관리 목록에서 작업을 완료하고 "완료된" 작업 목록으로 이동하는 것을 상상해 보십시오.)

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_mdeYMdX" src="//codepen.io/anon/embed/mdeYMdX?height=450&amp;theme-id=1&amp;slug-hash=mdeYMdX&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed mdeYMdX" title="CodePen Embed mdeYMdX" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

가장 간단한 예를 보자. 다음 펜에서 두 개의 정사각형 중 하나를 클릭하면 위치가 바뀝니다. FLIP가 없다면, 그것은 즉시 일어날 것이다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_oNjaMrK" src="//codepen.io/anon/embed/oNjaMrK?height=450&amp;theme-id=1&amp;slug-hash=oNjaMrK&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed oNjaMrK" title="CodePen Embed oNjaMrK" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

거기엔 많은 일들이 있어. use Effect와 use Layout Effect와 같은 라이프사이클 후크 콜백 내에서 모든 작업이 어떻게 진행되는지 주목하십시오. 약간 혼란스러운 것은 FLIP 애니메이션의 타임라인은 두 개의 리액트 렌더링에 걸쳐 발생하기 때문에 코드만으로 명확하지 않다는 것이다. 다양한 작업 순서를 보여주는 Retact FLIP 애니메이션의 해부도는 다음과 같습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/06/kTkr-F7_.png?fit=1024%2C1024&ssl=1)

use Effect는 항상 use Layout Effect와 브라우저 페인트 후에 실행되지만, 첫 번째 렌더 후에 요소의 위치와 크기를 캐시하는 것이 중요합니다. 모든 DOM 업데이트 후 use Layout Effect가 실행되기 때문에 두 번째 렌더로는 할 수 없습니다. 하지만 이 과정은 바닐라 FLIP 애니메이션과 본질적으로 동일합니다.

### 주의사항

대부분의 경우와 마찬가지로, 반응에서 FLIP으로 작업할 때 주의해야 할 사항이 있습니다.

FLIP 애니메이션은 계산입니다. 계산에는 시간이 걸리고 부드러운 60fps 변환이 나타나기 전에 상당한 작업이 필요합니다. 100ms 미만일 경우 지연되는 것을 눈치채지 못하실 테니 그 이하로는 다 확인해보세요. DevTools의 Performance 탭은 이를 확인하는 데 유용합니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/06/6LqLR8Jc.png?fit=1024%2C275&ssl=1)

모든 `setState`는 불필요한 렌더링을 유발하고 앱 속도를 떨어뜨리기 때문에 캐시 크기, 위치 및 애니메이션 개체에 상태를 사용할 수 없습니다. 심지어 최악의 경우 버그를 일으킬 수도 있습니다. 대신 useRef를 사용해보고 렌더링 없이 변형할 수 있는 개체로 생각해보자.

브라우저 레이아웃을 반복적으로 트리거하지 않도록 합니다. FLIP 애니메이션의 경우, 즉, 요소를 순환하고 getBoundingClientRect로 위치를 읽는 것을 피한 다음 즉시 애니메이션으로 애니메이션을 만드는 것을 의미합니다. 가능하면 "읽기" 및 "쓰기"를 일괄 처리합니다. 이것은 매우 부드러운 애니메이션을 가능하게 할 것이다.

이전 데모에서 정사각형이 이동하는 동안 임의로 클릭한 다음 중지한 후에 다시 클릭합니다. 결점이 보일 것이다. 실제로 사용자는 이동하는 동안 요소와 상호 작용하므로 취소, 일시 중지 및 업데이트가 원활하게 수행되어야 합니다.

그러나 모든 애니메이션을 리버스(reverse)로 되돌릴 수는 없다. 때때로, 우리는 그들이 멈추었다가 새로운 위치로 이동하기를 원합니다 (원소 목록을 임의로 섞을 때처럼). 이 경우 다음을 수행해야 합니다.

- 이동 요소의 크기/위치를 구하다
- 최신 애니메이션을 완성하다
- 새로운 크기와 위치 차이를 계산하다
- 새로운 애니메이션을 시작하다

React에서 이것은 보기보다 어려울 수 있습니다. 나는 이것과 씨름하느라 많은 시간을 허비했다. 현재 애니메이션 개체를 캐시해야 합니다. 좋은 방법은 지도를 만들어 아이디로 애니메이션을 얻는 것이다. 그러면 이동 원소의 크기와 위치를 파악해야 합니다. 다음 두 가지 방법을 사용할 수 있습니다.

- 함수 구성 요소 사용: 함수의 본문에 있는 모든 애니메이션 요소를 루프 방식으로 순환하고 현재 위치를 캐시합니다.
- 클래스 구성 요소 사용: 업데이트 전 스냅샷 가져오기 수명 주기 방법을 사용하십시오.

실제로 공식 응답은 "렌더" 단계 수명 주기(예: "렌더" 단계 수명 주기)와 "커밋" 단계 수명 주기(예: "getSnapshot BeforeUpdate", "componentDidUpdate") 사이에 지연이 있을 수 있으므로 "getSnapshotBeforeUpdate"를 사용할 것을 권장합니다. 그러나 이 방법에는 아직 후크 상대가 없다. 기능부품의 본체를 사용해도 충분하다는 것을 알았습니다.

전에도 말했지만 브라우저와의 싸움은 피하고 브라우저가 할 수 있는 방식으로 하도록 노력하세요. 간단한 크기 변경을 애니메이션화해야 한다면 CSS가 충분한지 생각해 보십시오(예: `transform: scale()`). FLIP 애니메이션은 브라우저가 실제로 다음을 지원할 수 없는 경우에 가장 잘 사용됩니다.

- DOM 위치 변경 애니메이션화(위에서와 같이)
- 레이아웃 애니메이션 공유

두 번째는 첫 번째 것의 더 복잡한 버전이다. 하나의 위치가 변경되는 것처럼 행동하고 보이는 두 개의 DOM 요소가 있습니다(다른 요소는 마운트 해제/숨김). 이 요령은 멋진 애니메이션을 가능하게 한다. 예를 들어, 이 애니메이션은 다음과 같은 접근 방식을 사용하는 `react-easy-flip`이라는 라이브러리를 사용하여 만들어졌습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_wvKbeqy" src="//codepen.io/anon/embed/wvKbeqy?height=450&amp;theme-id=1&amp;slug-hash=wvKbeqy&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed wvKbeqy" title="CodePen Embed wvKbeqy" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

React에서 FLIP 애니메이션을 보다 쉽게 만들고, 보일러 플레이트를 추상화하는 라이브러리가 꽤 많습니다. 현재 활발하게 유지되고 있는 것은 `react-flip-toolkit`와 `react-easy-flip`이다.

좀 더 무겁지만 더 일반적인 애니메이션이 가능한 것을 꺼리지 않는다면, "framer-motion"을 확인해 보세요. 또한 멋진 공유 레이아웃 애니메이션도 제공합니다! 저 도서관을 파고드는 비디오가 있다.

### 리소스 및 참조

- Josh W. Comau의 Unico 테이블 애니메이션
- 성능 향상 확장 구축
- 맷 페리의 매직 인사이드 매직 모션
- @keyframers가 트윗한 JavaScript의 애니메이션 CSS 변수 사용
- 코사카 마리코의 최신 웹 브라우저(3부)를 살펴본다.
- Alex Holachek의 간단한 반응으로 복잡한 UI 애니메이션 제작
- David Khourshid의 FLIP 기술로 레이아웃 애니메이션
- 리액트 훅스로 애니메이션 매끄럽게 하기 Kirill Vasiltsov
- Jayant Bhawal의 React Hooks를 통한 공유 요소 전환