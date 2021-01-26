---
layout: post
title: "Svelte 및 Spring 애니메이션"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/12/svelte-spring.jpg
tags: SPRING ANIMATION,SVELTE
---


봄 애니메이션은 UI 상호 작용을 생생하게 만드는 멋진 방법입니다.
 일정 기간 동안 일정한 속도로 속성을 변경하는 것보다 스프링을 사용하면 스프링 물리학을 사용하여 사물을 이동할 수 있습니다. 이는 실제 움직이는 느낌을주고 사용자에게 더 자연스럽게 보일 수 있습니다.

이전에 봄 애니메이션에 대해 썼습니다.
 이 게시물은 React를 기반으로 애니메이션에 react-spring을 사용했습니다.
 이 게시물은 Svelte에서 유사한 아이디어를 탐색합니다.

CSS 개발자!
 애니메이션의 느낌을 제어 할 때 완화를 생각하는 것이 일반적입니다.
 "봄"애니메이션은 실제 물리를 기반으로하는 여유의 하위 범주로 생각할 수 있습니다.

Svelte는 실제로 외부 라이브러리 없이도 프레임 워크에 내장 된 스프링을 가지고 있습니다.
 React-Spring에 대한 이전 게시물의 전반부에서 다룬 내용을 다시 해보겠습니다.
 그러나 그 후에는 이러한 스프링을 Svelte와 함께 사용할 수있는 모든 방법에 대해 자세히 알아보고 실제 구현을 향후 게시물에 남겨 둘 것입니다.
 실망스러워 보일지 모르지만 Svelte는 React에 대응할 수없는 훌륭하고 독특한 기능을 많이 가지고 있으며 이러한 애니메이션 프리미티브와 효과적으로 통합 할 수 있습니다.
 우리는 그들에 대해 이야기하는데 시간을 할애 할 것입니다.

한 가지 다른 참고 : 더 분명한 효과를 내기 위해 스프링을 추가 "탄력"으로 구성했기 때문에 전체에 뿌려진 일부 데모가 이상하게 보일 수 있습니다.
 그들 중 하나에 대한 코드라면 당신에게 맞는 스프링 구성을 찾으십시오.

여기에 다양한 스프링 구성과 그 작동 방식을 보여주기 위해 만든 멋진 REPL Rich Harris가 있습니다.

### Svelte Stores에 대한 빠른 입문서

시작하기 전에 Svelte 매장을 매우 빠르게 살펴 보겠습니다.
 Svelte의 구성 요소는 상태를 저장하고 업데이트 할 수있는 것 이상이지만 Svelte에는 구성 요소 외부에 상태를 저장할 수있는 저장소 개념도 있습니다.
 Svelte의 Spring API는 Store를 사용하므로 여기에서 중요한 부분을 빠르게 소개하겠습니다.

스토어의 인스턴스를 생성하려면`writable` 유형을 가져 와서 다음과 같이 생성 할 수 있습니다.

```js
import { writable } from "svelte/store";
const clicks = writable(0);
```

`clicks` 변수는 값이 0 인 상점입니다. 상점의 새 값을 설정하는 방법에는`set` 및`update` 메소드 두 가지가 있습니다.
 전자는 스토어를 설정하는 값을 수신하고 후자는 콜백을 수신하여 현재 값을 수락하고 새 값을 반환합니다.

```js
function increment() {
  clicks.update(val => val + 1);
}
function setTo5() {
  clicks.set(5);
}
```

실제로 소비 할 수 없다면 상태는 쓸모가 없습니다.
 이를 위해 상점은 새 값에 대한 알림을받을 수있는`subscribe` 메소드를 제공합니다.하지만 컴포넌트 내부에서 사용할 때 상점 이름 앞에`$`문자를 붙여서 Svelte에게 표시 할뿐만 아니라
 상점의 현재 값이지만 변경 될 때 업데이트됩니다.
 예를 들면 :

```html
<h1>Value {$clicks}</h1>
<button on:click={increment}>Increment</button>
<button on:click={setTo5}>Set to 5</button>
```

다음은이 코드의 전체 작동 예입니다.
 상점은 상점을 함께 연결할 수있는 파생 상점, 읽을 수있는 상점, 상점이 처음 관찰 될 때 및 더 이상 관찰자가 없을 때 알림을받을 수있는 기능과 같은 여러 다른 기능을 제공합니다.
 그러나이 게시물의 목적을 위해 위에 표시된 코드는 우리가 걱정할 전부입니다.
 자세한 내용은 Svelte 문서 또는 대화 형 자습서를 참조하십시오.

### 스프링스 특강

스프링에 대한 간략한 소개와 그 기능을 살펴 보겠습니다.
 일부 요소 (불투명도 및 변형)의 표시 측면을 변경하는 간단한 UI를 살펴본 다음 해당 변경 사항을 애니메이션으로 적용하는 방법을 살펴 보겠습니다.

이것은 하나의`<div>`의 `불투명도`를 토글하고 다른 하나의 x 축 `변환`을 토글하는 (애니메이션없이) 최소 Svelte 구성 요소입니다.

```html
<script>
  let shown = true;
  let moved = 0;

  const toggleShow = () => (shown = !shown);
  const toggleMove = () => (moved = moved ? 0 : 500);
</script>

<div style="opacity: {shown ? 1 : 0}">Content to toggle</div>
<br />
<button on:click={toggleShow}>Toggle</button>
<hr />
<div class="box" style="transform: translateX({moved}px)">I'm a box.</div>
<br />
<button on:click={toggleMove}>Move it!</button>
```

이러한 변경 사항은 즉시 적용되므로 애니메이션을 적용 해 보겠습니다.
 이것이 스프링이 들어오는 곳입니다. Svelte에서 스프링은 원하는 값을 설정 한 상점이지만 즉시 변경하는 대신 상점은 내부적으로 스프링 물리학을 사용하여 값을 점차적으로 변경합니다.
 그런 다음 UI를이 변경 값에 바인딩하여 멋진 애니메이션을 얻을 수 있습니다.
 실제 동작을 봅시다.

```html
<script>
  import { spring } from "svelte/motion";

  const fadeSpring = spring(1, { stiffness: 0.1, damping: 0.5 });
  const transformSpring = spring(0, { stiffness: 0.2, damping: 0.1 });

  const toggleFade = () => fadeSpring.update(val => (val ? 0 : 1));
  const toggleTransform = () => transformSpring.update(val => (val ? 0 : 500));
  const snapTransform = () => transformSpring.update(val => val, { hard: true });
</script>

<div style="opacity: {$fadeSpring}">Content to fade</div>
<br />
<button on:click={toggleFade}>Fade Toggle</button>

<hr />

<div class="box" style="transform: translateX({$transformSpring}px)">I'm a box.</div>
<br />
<button on:click={toggleTransform}>Move it!</button>
<button on:click={snapTransform}>Snap into place</button>
```


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video controls="" src="https://css-tricks.com/wp-content/uploads/2021/01/Screen-Recording-2021-01-04-at-2.47.19-PM.mov" playsinline="" name="fitvid0"></video>
</div>


Svelte에서 스프링 함수를 가져오고, 불투명도에 대해 다른 스프링 인스턴스를 설정하고 애니메이션을 변환합니다.
 트랜스 폼 스프링 구성은 의도적으로 추가 스프링으로 설정되어 스프링 애니메이션을 일시적으로 끄고 원하는 변경 사항을 즉시 적용 할 수있는 방법을 나중에 보여줍니다 (나중에 유용 할 것임).
 스크립트 블록의 끝에는 원하는 속성을 설정하기위한 클릭 핸들러가 있습니다.
 그런 다음 HTML에서 변경되는 값을 요소에 직접 바인딩합니다. 그게 전부입니다!
 이것이 Svelte의 기본 스프링 애니메이션에 대한 전부입니다.

남은 항목은`snapTransform` 함수입니다. 여기서 transform spring을 현재 값으로 설정하고`hard : true`로 객체를 두 번째 인수로 전달합니다.
 애니메이션없이 원하는 값을 즉시 적용하는 효과가 있습니다.

이 데모와이 게시물에서 살펴볼 나머지 기본 예제는 다음과 같습니다.

### 애니메이션 높이

`높이`애니메이션은 다른 CSS 속성보다 까다 롭습니다. 애니메이션 할 실제 높이를 알아야하기 때문입니다.
 안타깝게도 `auto`값으로 애니메이션을 적용 할 수 없습니다.
 스프링에는 스프링 물리를 통해 올바른 값을 보간 할 수 있도록 실제 숫자가 필요하기 때문에 스프링에는 의미가 없습니다.
 또한 일반 CSS 전환으로 `자동`높이에 애니메이션을 적용 할 수도 없습니다.
 다행히 웹 플랫폼은 요소의 높이를 얻을 수있는 편리한 도구 인`ResizeObserver`를 제공합니다.이 도구는 브라우저간에 상당히 잘 지원됩니다.

요소의 원시 높이 애니메이션으로 시작하여 다른 예에서 점차적으로 다듬는 "슬라이드 다운"효과를 생성합니다.
 `ResizeObserver`를 사용하여 요소의 높이에 바인딩합니다.
 Svelte에는 요소의 높이를보다 직접적으로 바인딩하는 데 사용할 수있는`offsetHeight` 바인딩이 있지만 자식을받을 수있는 요소에서만 작동하도록하는`<iframe>`해킹으로 구현되어 있습니다.
 이것은 대부분의 사용 사례에 충분할 수 있지만 결국에는 멋진 추상화를 허용하기 때문에`ResizeObserver`를 사용할 것입니다.

먼저 요소의 높이를 바인딩합니다.
 요소를 수신하고 변경시 `height`값을 업데이트하는 `ResizeObserver`를 초기화하는 쓰기 가능한 저장소를 반환합니다.
 다음과 같이 표시됩니다.

```js
export default function syncHeight(el) {
  return writable(null, (set) => {
    if (!el) {
      return;
    }
    let ro = new ResizeObserver(() => el && set(el.offsetHeight));
    ro.observe(el);
    return () => ro.disconnect();
  });
}
```

`null`값으로 스토어를 시작합니다.이 값은 `아직 측정되지 않음`으로 해석됩니다.
 `writable`에 대한 두 번째 인수는 스토어가 활성화 될 때 Svelte에 의해 호출되며, 이는 구성 요소에서 사용되는 즉시 사용됩니다.
 이것은`ResizeObserver`를 실행하고 요소 관찰을 시작할 때입니다.
 그런 다음 저장소가 더 이상 어디에도 사용되지 않을 때 Svelte가 호출하는 정리 함수를 반환합니다.

이것이 실제로 작동하는지 봅시다 :

```html
<script>
  import syncHeight from "../syncHeight";
  import { spring } from "svelte/motion";

  let el;
  let shown = false;
  let open = false;
  let secondParagraph = false;

  const heightSpring = spring(0, { stiffness: 0.1, damping: 0.3 });
  $: heightStore = syncHeight(el);
  $: heightSpring.set(open ? $heightStore || 0 : 0);

  const toggleOpen = () => (open = !open);
  const toggleSecondParagraph = () => (secondParagraph = !secondParagraph);
</script>

<button on:click={ toggleOpen }>Toggle</button>
<button on:click={ toggleSecondParagraph }>Toggle More</button>
<div style="overflow: hidden; height: { $heightSpring }px">
  <div bind:this={el}>
    <div>...</div>
    <br />
    {#if secondParagraph}
    <div>...</div>
    {/if}
  </div>
</div>
```


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video controls="" src="https://css-tricks.com/wp-content/uploads/2021/01/Screen-Recording-2021-01-04-at-2.41.39-PM.mov" playsinline="" name="fitvid1"></video>
</div>


`el`변수에는 애니메이션 할 요소가 포함됩니다.
 우리는 Svelte에게`bind : this = {el}`을 통해 DOM 요소로 설정하도록 지시합니다.
 `heightSpring`은 요소가 열려있을 때 요소의 높이 값을 유지하고 닫힐 때 0을 유지하는 스프링입니다.
 `heightStore`는 요소의 현재 높이를 최신 상태로 유지하는 것입니다.
 `el`은 처음에는 정의되지 않았고`syncHeight`는 기본적으로 아무것도하지 않는 쓰기 가능한 정크 저장소를 반환합니다.
 `<div>`노드에`el`이 할당 되 자마자`$ :`구문 덕분에 해당 행이 다시 실행되고`ResizeObserver`가 수신하는 쓰기 가능한 저장소를 가져옵니다.

그런 다음이 줄 :

```js
$: heightSpring.set(open ? $heightStore || 0 : 0);
```

… 개방 값의 변경 사항을 듣고 높이 값도 변경합니다.
 두 경우 모두 봄 상점을 업데이트합니다.
 HTML로 높이를 바인딩하면 끝났습니다!

이 외부 요소에서`overflow`를`hidden`으로 설정하여 요소가 열린 상태와 닫힌 상태 사이를 전환 할 때 내용이 제대로 잘 리도록 설정해야합니다.
 또한 요소의 높이에 대한 변경 사항도 제자리에 애니메이션으로 적용되며 "추가 전환"버튼으로 확인할 수 있습니다.
 이전 섹션의 임베디드 데모에서 실행할 수 있습니다.

위의 줄은 다음과 같습니다.

```js
$: heightStore = syncHeight(el);
```

… 현재이 버그에 설명 된대로 SSR (서버 측 렌더링)을 사용할 때 오류가 발생합니다.
 SSR을 사용하지 않는 경우 걱정할 필요가 없습니다. 물론이 문서를 읽을 때 쯤이면 버그가 수정되었을 수 있습니다.
 그러나 해결 방법은 다음과 같이하는 것입니다.

```js
let heightStore;
$: heightStore = syncHeight(el);
```

… 작동하지만 이상적이지 않습니다.

처음 렌더링 할 때`<div>`가 열리기를 원하지 않을 것입니다.
 또한 오프닝 스프링 효과는 좋지만 닫을 때 일부 내용이 깜빡여 효과가 버벅 거립니다.
 우리는 그것을 고칠 수 있습니다.
 초기 렌더링이 애니메이션되는 것을 방지하기 위해 앞서 보았던`{hard : true}`옵션을 사용할 수 있습니다.
 `heightSpring.set`에 대한 호출을 다음과 같이 변경해 보겠습니다.

```js
$: heightSpring.set(open ? $heightStore || 0 : 0, getConfig($heightStore));
```

… 그런 다음 첫 번째 렌더링에 대해`true`로 설정된`hard` 속성이있는 객체를 반환하는`getConfig` 함수를 작성하는 방법을 살펴 봅니다.
 제가 생각 해낸 것은 다음과 같습니다.

```js
let shown = false;

const getConfig = val => {
  let active = typeof val === "number";
  let immediate = !shown && active;
  //once we've had a proper height registered, we can animate in the future
  shown = shown || active;
  return immediate ? { hard: true } : {};
};
```

우리의 높이 저장소는 처음에 null을 유지하고`ResizeObserver`가 실행되기 시작할 때만 숫자를 얻습니다.
 실제 숫자를 확인하여이를 활용합니다.
 숫자가 있고 아직 아무것도 표시하지 않은 경우 콘텐츠를 즉시 표시해야하며 즉시 값을 설정하여 표시합니다.
 이 값은 궁극적으로 이전에 보았던 봄에`hard` 구성 값을 트리거합니다.

이제 콘텐츠를 닫을 때 애니메이션을 약간 덜, 음, 탄력있게 조정하겠습니다.
 이렇게하면 물건이 닫힐 때 깜박이지 않습니다.
 처음에 스프링을 만들 때 강성과 감쇠를 지정했습니다.

```js
const heightSpring = spring(0, { stiffness: 0.1, damping: 0.3 });
```

`봄`객체 자체가 이러한 속성을 유지하며 언제든지 설정할 수 있습니다.
 이 줄을 업데이트하겠습니다.

```js
$: heightSpring.set(open ? $heightStore || 0 : 0, getConfig($heightStore));
```

이는 스프링을 업데이트하기 위해 오픈 값 (및`heightStore` 자체)의 변경을 감지합니다.
 열거 나 닫는 지 여부에 따라 스프링 설정도 업데이트 해 보겠습니다.
 다음과 같이 표시됩니다.

```js
$: {
  heightSpring.set(open ? $heightStore || 0 : 0, getConfig($heightStore));
  Object.assign(
    heightSpring,
    open ? { stiffness: 0.1, damping: 0.3 } : { stiffness: 0.1, damping: 0.5 }
  );
}
```

이제 새로운`open` 또는`height` 값을 얻으면 이전과 같이`heightSpring.set`을 호출하지만 요소가 있는지 여부에 따라 적용되는 스프링에`stiffness` 및`damping` 값도 설정합니다.
 열다.
 닫혀 있으면 `댐핑`을 0.5로 설정하여 탄력을 줄입니다.
 물론 이러한 모든 값을 조정하고 원하는대로 구성 할 수 있습니다.
 데모의 "Animate Height Different Springs"섹션에서이를 확인할 수 있습니다.

코드가 매우 빠르게 성장하기 시작하는 것을 알 수 있습니다.
 이러한 사용 사례 중 일부를 다루기 위해 많은 상용구를 추가 했으므로 정리하겠습니다.
 특히 스프링을 생성하고 스프링 구성, 초기 렌더링 등을 처리하기 위해`sync` 함수를 내보내는 함수를 만들 것입니다.

```js
import { spring } from "svelte/motion";

const OPEN_SPRING = { stiffness: 0.1, damping: 0.3 };
const CLOSE_SPRING = { stiffness: 0.1, damping: 0.5 };

export default function getHeightSpring() {
  const heightSpring = spring(0);
  let shown = false;

  const getConfig = (open, val) => {
    let active = typeof val === "number";
    let immediate = open && !shown && active;
    // once we've had a proper height registered, we can animate in the future
    shown = shown || active;
    return immediate ? { hard: true } : {};
  };

  const sync = (open, height) => {
    heightSpring.set(open ? height || 0 : 0, getConfig(open, height));
    Object.assign(heightSpring, open ? OPEN_SPRING : CLOSE_SPRING);
  };

  return { sync, heightSpring };
}
```

여기에는 많은 코드가 있지만 지금까지 작성한 코드는 모두 단일 함수로 패키징 된 것입니다.
 이제이 애니메이션을 사용하는 코드가 이렇게 단순화되었습니다.

```js
const { heightSpring, sync } = getHeightSpring();
$: heightStore = syncHeight(el);
$: sync(open, $heightStore);
```

데모의 "Animate Height Cleanup"섹션에서 확인할 수 있습니다.

### Svelte 특유의 트릭

잠시 멈춰서 Svelte가 React와 다른 점과이를 활용하여 우리가 가진 것을 더욱 향상시킬 수있는 방법을 고려해 보겠습니다.

첫째, 스프링을 유지하고 높이 값을 변경하는 데 사용했던 저장소는 React의 후크와 달리 컴포넌트 렌더링에 묶여 있지 않습니다.
 어디에서나 사용할 수있는 일반 자바 스크립트 개체입니다.
 그리고 위에서 언급했듯이, 우리는 그들이 변화하는 값을 수동으로 관찰 할 수 있도록 그것들을 반드시 구독 할 수 있습니다.

또한 행동이라고 부르는 것을 날씬하게 만듭니다.
 DOM 요소에 추가 할 수있는 함수입니다.
 요소가 생성되면 Svelte는 함수를 호출하고 요소를 첫 번째 인수로 전달합니다.
 또한 Svelte가 전달할 추가 인수를 지정하고 해당 값이 변경 될 때 Svelte가 다시 실행할 `update`함수를 제공 할 수 있습니다.
 우리가 할 수있는 또 다른 일은 Svelte가 요소를 파괴 할 때 호출 할`cleanup` 함수를 제공하는 것입니다.

지금까지 작성해 온 모든 애니메이션을 처리하기 위해 요소에 간단히 놓을 수있는 단일 작업으로 이러한 도구를 결합 해 보겠습니다.

```js
export default function slideAnimate(el, open) {
  el.parentNode.style.overflow = "hidden";

  const { heightSpring, sync } = getHeightSpring();
  const doUpdate = () => sync(open, el.offsetHeight);
  const ro = new ResizeObserver(doUpdate);

  const springCleanup = heightSpring.subscribe((height) => {
    el.parentNode.style.height = `${ height }px`;
  });

  ro.observe(el);

  return {
    update(isOpen) {
      open = isOpen;
      doUpdate();
    },
    destroy() {
      ro.disconnect();
      springCleanup();
    }
  };
}
```

우리의 함수는 애니메이션화하려는 요소와 열린 값으로 호출됩니다.
 요소의 부모가 `overflow : hidden`을 갖도록 설정합니다.
 그런 다음 이전과 동일한`getHeightSpring` 함수를 사용하고 ResizeObserver 등을 설정합니다. 진짜 마법이 여기에 있습니다.

```js
const springCleanup = heightSpring.subscribe((height) => {
  el.parentNode.style.height = `${height}px`;
});
```

`heightSpring`을 DOM에 바인딩하는 대신 수동으로 변경 사항을 구독 한 다음 직접 높이를 설정합니다.
 Svelte와 같은 JavaScript 프레임 워크를 사용할 때는 일반적으로 수동 DOM 업데이트를 수행하지 않지만이 경우 헬퍼 라이브러리 용이므로 제 생각에는 괜찮습니다.

반환하는 객체에서 `open`값이 변경 될 때 Svelte가 호출 할 `update`함수를 정의합니다.
 이 함수의 원래 인수를 업데이트하면 함수가 닫히고 (즉, 클로저 생성) 모든 것을 동기화하기 위해`update` 함수를 호출합니다.
 Svelte는 DOM 노드가 파괴되면 `destroy`함수를 호출합니다.

무엇보다도이 작업을 사용하는 것은 간단합니다.

```html
<div use:slideAnimate={open}>
```

그게 다입니다.
 `open`이 변경되면 Svelte는 `update`함수를 호출합니다.

계속 진행하기 전에 다른 부분을 조정 해 보겠습니다.
 "Toggle"버튼으로 창을 축소 할 때 스프링 구성을 변경하여 탄력성을 제거하는 방법에 주목하십시오.
 그러나 "Toggle More"버튼을 클릭하여 요소를 더 작게 만들면 일반적인 탄력으로 축소됩니다.
 나는 그것을 싫어하고 축소에 사용하는 것과 동일한 물리로 이동하는 축소 크기를 선호합니다.

`getHeightSpring` 함수에서 다음 줄을 제거하여 시작하겠습니다.

```js
Object.assign(heightSpring, open ? OPEN_SPRING : CLOSE_SPRING);
```

이 줄은`getHeightSpring`이 만든`sync` 함수 안에 있으며`open` 값을 기반으로 모든 변경 사항에 대해 스프링 설정을 업데이트합니다.
 이제 "개방형"스프링 구성으로 스프링을 시작할 수 있습니다.

```js
const heightSpring = spring(0, OPEN_SPRING);
```

이제 콘텐츠의 높이가 변경되거나 `open`값이 변경 될 때 스프링 설정을 변경해 보겠습니다.
 우리는 이미이 두 가지 변화를 관찰 할 수있는 능력을 가지고 있습니다. 콘텐츠의 크기가 변경되면`ResizeObserver` 콜백이 실행되고`open`이 변경 될 때마다 액션의`update` 기능이 실행됩니다.

`ResizeObserver` 콜백은 다음과 같이 변경할 수 있습니다.

```js
let currentHeight = null;
const ro = new ResizeObserver(() => {
  const newHeight = el.offsetHeight;
  const bigger = newHeight > currentHeight;

  if (typeof currentHeight === "number") {
    Object.assign(heightSpring, bigger ? OPEN_SPRING : CLOSE_SPRING);
  }
  currentHeight = newHeight;
  doUpdate();
});
```

`currentHeight`는 현재 값을 보유하고 있으며 크기 변경을 확인하여 이동하는 방향을 확인합니다.
 다음은 `업데이트`기능입니다.
 변경 후의 모습은 다음과 같습니다.

```js
update(isOpen) {
  open = isOpen;
  Object.assign(heightSpring, open ? OPEN_SPRING : CLOSE_SPRING);
  doUpdate();
},
```

같은 생각이지만 이제는 `open`이 `true`인지 `false`인지 만 확인합니다.
 데모의 "Slide Animate"및 "Slide Animate 2"섹션에서 이러한 반복을 확인할 수 있습니다.

### 전환

지금까지 이미 페이지에있는 애니메이션 항목에 대해 이야기했지만 처음 렌더링 할 때 개체에 애니메이션을 적용하는 것은 어떻습니까?
 그리고 그것이 마운트 해제되면?
 이를 전환이라고하며 Svelte에 내장되어 있습니다.
 문서는 일반적인 사용 사례를 다루는 훌륭한 작업을 수행하지만 아직 (직접) 지원되지 않는 한 가지가 있습니다. 바로 스프링 기반 전환입니다.

/ explanation Svelte가 "전환"이라고 부르는 것과 CSS가 "전환"이라고 부르는 것은 매우 다릅니다.
 CSS는 한 값을 다른 값으로 전환하는 것을 의미합니다.
 Svelte는 요소가 DOM 안팎으로 완전히 "전환"되는 요소를 참조합니다 (CSS가 전혀 도움이되지 않는 요소).

명확히하기 위해 여기서 수행하는 작업은 Svelte의 전환에 스프링 기반 애니메이션을 추가하기위한 것입니다.
 현재 지원되지 않으므로 몇 가지 트릭과 해결 방법이 필요합니다.
 스프링 사용에 신경 쓰지 않는다면 Svelte의 내장 전환을 사용할 수 있습니다. 이는 훨씬 더 간단합니다.
 다시 한 번 더 자세한 정보는 문서를 확인하십시오.

Svelte에서 전환이 작동하는 방식은 선택적 여유 함수와 함께 밀리 초 (`ms`) 단위의 지속 시간을 제공 한 다음 Svelte는 전환이 얼마나 멀리 있는지를 나타내는 0에서 1까지 실행되는 값으로 콜백을 제공한다는 것입니다.
 원하는 CSS로 바꿉니다.
 예를 들면 :

```js
const animateIn = () => {
  return {
    duration: 2000,
    css: t => `transform: translateY(${t * 50 - 50}px)`
  };
};
```

… 다음과 같이 사용됩니다.

```html
<div in:animateIn out:animateOut class="box">
  Hello World!
</div>
```

`<div>`가 처음 마운트되면 Svelte는 다음을 수행합니다.

- `animateIn` 함수를 호출합니다.
- 0에서 1까지의 값으로 결과 객체에 대해 CSS 함수를 미리 빠르게 호출합니다.
- 변경된 CSS 결과를 수집 한 다음
- 결과를 CSS 키 프레임 애니메이션으로 컴파일 한 다음 들어오는`<div>`에 적용합니다.

즉, 애니메이션이 메인 스레드의 JavaScript가 아닌 CSS 애니메이션으로 실행되어 무료로 성능을 향상시킬 수 있습니다.

변수`t`는 0에서 시작하여 -50px로 변환됩니다.
 `t`가 1에 가까워지면 번역은 최종 값인 0에 가까워집니다.
 아웃 전환은 거의 동일하지만 역으로 상자의 현재 번역 값을 감지하는 기능이 추가되었습니다.
 따라서 추가 한 다음 빠르게 제거하면 상자가 앞으로 점프하지 않고 현재 위치에서 나가기 시작합니다.
 하지만 떠나는 동안 다시 추가하면 점프 할 것입니다. 잠시 후에 이야기 할 것입니다.

데모의 "Basic Transition"섹션에서 실행할 수 있습니다.

애니메이션의 흐름을 변경하는 여러 여유 기능이 있지만 스프링을 직접 사용할 수있는 기능은 없습니다.
 하지만 우리가 할 수있는 것은 미리 스프링을 실행하고 결과 값을 수집하는 방법을 찾는 것입니다. 그리고 나서 우리의`css` 함수가 0에서 1까지 실행되는`t` 값으로 호출 될 때 오른쪽을 찾습니다.
 봄 가치.
 따라서 `t`가 0이면 당연히 봄의 첫 번째 값이 필요합니다.
 `t`가 0.5이면 중간에있는 값을 원합니다.
 또한 초당 60 프레임이 있으므로 `number_of_spring_values * 1000/60`인 기간이 필요합니다.

여기에 해당 코드를 작성하지 않습니다.
 대신 내가 시작한 프로젝트 인 svelte-helpers 라이브러리에 이미 존재하는 솔루션을 사용합니다.
 Svelte 코드베이스에서 하나의 작은 함수 인 `spring_tick`를 잡은 다음, 완료 될 때까지 반복적으로 호출하는 별도의 함수를 작성하여 그 과정에서 값을 수집했습니다.
 `t`에서 해당 배열의 올바른 요소로의 변환 (또는 직접 일치하는 항목이없는 경우 가중 평균) 만 있으면됩니다.
 Rich Harris는 후자에 대한 도움의 손길을주었습니다. 감사합니다.

큰 빨간색`<div>`가 우리가 안팎으로 애니메이션하려는 모달이라고 가정 해 보겠습니다.
 `animateIn` 함수는 다음과 같습니다.

```js
import { springIn, springOut } from "svelte-helpers/animation";
const SPRING_IN = { stiffness: 0.1, damping: 0.1 };

const animateIn = node => {
  const { duration, tickToValue } = springIn(-80, 0, SPRING_IN);
  return {
    duration,
    css: t => `transform: translateY(${ tickToValue(t) }px)`
  };
};
```

스프링 구성뿐만 아니라 스프링을 원하는 값을`springIn `함수에 제공합니다.
 그러면 기간과 현재`tickToValue`를 CSS에 적용 할 현재 값으로 변환하는 함수가 제공됩니다.
 그게 다야!

모달을 닫는 것도 하나의 작은 조정으로 동일합니다.

```js
const SPRING_OUT = { stiffness: 0.1, damping: 0.5, precision: 3 };

const animateOut = node => {
  const current = currentYTranslation(node);
  const { duration, tickToValue } = springOut(current ? current : 0, 80, SPRING_OUT);
  return {
    duration: duration,
    css: t => `transform: translateY(${ tickToValue(t) }px)`
  };
}; 
 

```

여기에서는 모달의 현재 변환 위치를 확인한 다음이를 애니메이션의 시작점으로 사용합니다.
 이렇게하면 사용자가 모달을 열었다가 빠르게 닫으면 0으로 순간 이동 한 다음 나가는 대신 현재 위치에서 나갑니다.
 이는 요소가 마운트 해제 될 때`animateOut` 함수가 호출되기 때문에 작동합니다.이 시점에서 애니메이션을 계산할 수 있도록`duration` 속성과`css` 함수를 사용하여 객체를 생성합니다.

안타깝게도 떠나는 과정에서 물체를 다시 장착하는 것은 적어도 잘 작동하지 않는 것 같습니다.
 `animateIn`함수는 de novo라고하는 것이 아니라 원래 애니메이션을 재사용하므로 항상 -80에서 시작됩니다.
 다행히도 일반적인 모달 구성 요소에는 거의 문제가되지 않습니다. 일반적으로 배경 오버레이와 같은 항목을 클릭하면 모달이 제거되므로 해당 오버레이가 애니메이션이 완료 될 때까지 다시 표시 할 수 없습니다.
 게다가 양방향 전환이있는 요소를 반복적으로 추가하고 제거하면 재미있는 데모가 될 수 있지만, 적어도 내 경험으로는 실제로 일반적이지 않습니다.

나가는 스프링 구성에 대한 마지막 빠른 메모 : 내가 정밀도를 엄청나게 높게 설정 한 것을 눈치 채 셨을 것입니다 (기본값이 0.01 인 경우 3).
 이를 통해 Svelte는 "완료"를 결정하기 전에 목표 값에 얼마나 근접했는지 알 수 있습니다.
 기본값을 0.01로두면 모달이 (거의) 대상에 도달 한 다음 완료 여부를 결정하기 전에 눈에 띄지 않게 가까워지는 데 몇 밀리 초를 소비 한 다음 DOM에서 제거합니다.
 이것은 모달이 멈췄거나 지연된 인상을줍니다.
 정밀도를 3 값으로 이동하면이 문제가 해결됩니다.
 이제 모달이 이동해야하는 위치 (또는 충분히 가까움)로 애니메이션 된 다음 빠르게 사라집니다.

### 더 많은 애니메이션

모달 예제에 마지막 조정을 추가하겠습니다.
 애니메이션하는 동안 페이드 인 및 페이드 아웃합니다.
 여기에도 스프링을 사용할 수 없습니다. 다시 한 번 전환에 대해 하나의 표준 기간이 필요하고 모션 스프링이 이미이를 제공하고 있기 때문입니다.
 그러나 봄 애니메이션은 일반적으로 실제로 움직이는 항목에 대해 의미가 있습니다.
 이제 이징 기능을 사용하여 페이드 애니메이션을 만들어 보겠습니다.

올바른 여유 기능을 선택하는 데 도움이 필요하면 Svelte 문서에서이 편리한 시각화를 확인하십시오.
 나는`quintOut`과`quadIn` 함수를 사용할 것입니다.

```js
import { quintOut, quadIn } from "svelte/easing";
```

우리의 새로운`animateIn` 함수는 매우 비슷해 보입니다.
 우리의`css` 함수는 이전에했던 작업을 수행하지만`quintOut` 여유 함수를 통해`tickToValue` 값을 실행하여`opacity` 값을 얻습니다.
 `t`는 in 전환 중에는 0에서 1로, out 전환 중에는 1에서 0으로 실행되므로`opacity `에 적용하기 전에 추가 작업을 수행 할 필요가 없습니다.

```js
const SPRING_IN = { stiffness: 0.1, damping: 0.1 };
const animateIn = node =>; {
  const { duration, tickToValue } = springIn(-80, 0, SPRING_IN);
  return {
    duration,
    css: t => {
      const transform = tickToValue(t);
      const opacity = quintOut(t);
      return `transform: translateY(${ transform }px); opacity: ${ opacity };`;
    }
  };
};
```

`animateOut`함수는 요소의 현재 `불투명도`값을 가져와 여기에서 강제로 애니메이션을 시작한다는 점을 제외하면 비슷합니다.
 따라서 요소가 불투명도 (예 : 0.3)로 페이드 인하는 과정에있는 경우이를 1로 재설정 한 다음 페이드 아웃하는 것을 원하지 않습니다.
 대신 0.3에서 페이드 아웃하고 싶습니다.

시작 불투명도에 여유 함수가 반환하는 값을 곱하면이를 수행 할 수 있습니다.
 `t`값이 1에서 시작하면 `1 * 0.3`은 0.3입니다.
 `t`가 0.95이면 0.3보다 약간 작은 값을 얻기 위해 `0.95 * 0.3`을 수행합니다.

기능은 다음과 같습니다.

```js
const animateOut = node => {
  const currentT = currentYTranslation(node);
  const startOpacity = +getComputedStyle(node).opacity;
  const { duration, tickToValue } = springOut(
    currentT ? currentT : 0,
    80,
    SPRING_OUT
  );
  return {
    duration,
    css: t => {
      const transform = tickToValue(t);
      const opacity = quadIn(t);
      return `transform: translateY(${ transform }px); opacity: ${ startOpacity * opacity }`;
    }
  };
};

```

"Spring Transition With Fade 구성 요소를 사용하여 데모에서이 예제를 실행할 수 있습니다.

### 이별의 생각

Svelte는 정말 재미 있습니다!
 나의 (허용되는 제한적) 경험에서, 그것은 매우 단순한 기본 요소를 제공하는 경향이 있고, 당신이 필요로하는 모든 것을 코딩하도록 남겨둔다.
 이 게시물이 웹 애플리케이션에서 스프링 애니메이션을 잘 활용할 수있는 방법을 설명하는 데 도움이 되었기를 바랍니다.

그리고 다른 애니메이션에서와 마찬가지로 스프링으로 작업 할 때 접근성을 고려하라는 간단한 알림입니다.
 이러한 기술을`prefers-reduced-motion`과 같은 기술과 함께 사용하면 애니메이션을 선호하는 사람 만 애니메이션을 얻을 수 있습니다.