---
layout: post
title: "상태로 사용자 지정 속성
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2021/01/birds-clouds.jpg
tags: CUSTOM PROPERTIES,STATE
---


James Stanley의 재미있는 아이디어입니다. `계절별`색상 (예 : 봄은 초록색, 가을은 주황색)에 대한 CSS 맞춤 속성이 포함 된 CSS 파일 (아마도 매일 업데이트 됨)입니다.
 그런 다음 값을 사용하여 사이트의 테마를 지정합니다. 이러한 색상은 날마다 약간 씩 변합니다.
 

이것은 이것을 쓰는 동안 내가 얻은 것입니다.
 

```css
:root {
  --seasonal-bg: hsl(-68.70967741935485,9.419354838709678%,96%);
  --seasonal-bgdark: hsl(-68.70967741935485,9.419354838709678%,90%);
  --seasonal-fg: hsl(-68.70967741935485,9.419354838709678%,30%);
  --seasonal-hl: hsl(-83.70967741935485,30.000000000000004%,50%);
  --seasonal-hldark: hsl(-83.70967741935485,30.000000000000004%,35%);
}
```

제공된 CSS 파일이 사용자 정의 속성이고 다른 스타일 (본문 배경 설정 등)이 아니라면 더 재미있을 것이라고 생각합니다.
 이렇게하면 부작용없이 원하는 방식으로 색상을 구현할 수 있습니다.
 

### API로서의 CSS?
 

이로 인해 이와 같은 CDN 호스팅 CSS 파일에는 의사 콘텐츠에 사용되는 오늘 날짜 나 기타 특수한 시간에 민감한 항목과 같은 다른 유용한 항목이있을 수 있다고 생각합니다.
 아마도 달의 위상일까요?
 스포츠 점수?!
 오늘의 수프?!
 

```css
/* <div class="soup">The soup of the day is: </div> */
.soup::after {
  content: var(--soupOfTheDay); /* lol kinda */
}
```

매우 사용하기 쉬운 데이터 API와 거의 같습니다.
 요즘에는 의사 콘텐츠도 액세스 할 수있는 콘텐츠입니다.하지만 의사 요소의 텍스트를 선택할 수 없으므로 CSS를 콘텐츠 API로 사용하는 것을 실제로 보증하는 것으로 읽지 마세요.
 

### 사용자 지정 속성 유연성
 

Will Boyd는 사용자 지정 속성에 넣을 수있는 방법에 대해 블로그를 작성했습니다.
 그들은 엄청나게 유연합니다.
 거의 모든 것이 유효한 사용자 지정 속성 값이며 사용은 사용자가 생각하는대로 동작하는 경향이 있습니다.
 

```css
body {
  /* totally fine */
  --rgba: rgba(255, 0, 0, 0.1);
  background: var(--rgba);

  /* totally fine */
  --rgba: 255, 0, 0, 0.1;
  background: rgba(var(--rgba));

  /* totally fine */
  --rgb: 255 0 0;
  --a: 0.1;
  background: rgb(var(--rgb) / var(--a));
}

body::after {
  /* totally fine */
  --song: "I need quotes to be pseudo content \A and can't have line breaks without this weird hack \A but still fairly permissive (💧💧💧) ";
  content: var(--song);
  white-space: pre;
}
```

Bram Van Damme은 Will의 기사를 다루면서 이러한 유연성에 집중했습니다.
 

> 이것이 CSS 사용자 정의 속성을 사용하여 다음을 수행 할 수있는 이유입니다.
• 조건부 계산 수행
• CSS 내에서 JavaScript로 데이터 전달
• Emoji에 피부톤 / 머리 색 조절제 주입
• 하나의 사용자 지정 속성으로 여러 값 전환 (`--foo :;`해킹)
 

Bram은 사용자 정의 속성이 가져올 수있는 "기본"상태 변경 품질을 지적합니다.
 

```css
:root {
  --is-big: 0;
}

.is-big {
  --is-big: 1;
}

.block {
  padding: calc(
    25px * var(--is-big) +
    10px * (1 - var(--is-big))
  );
  border-width: calc(
    3px * var(--is-big) +
    1px * (1 - var(--is-big))
  );
}
```

몇 가지 복잡성을 추가하면 The Raven (사용자 지정 속성이있는 미디어 쿼리)을 얻을 수 있습니다.
 

이 작업을 더 쉽게하기 위해 CSS에서 어떤 일이 발생하는 것을보고 싶습니다.
 일반 상태에 CSS 사용자 정의 속성을 사용하는 것은 놀랍습니다.
 UI가 임의의 상태에있을 때 임의의 스타일을 적용 할 수 있습니다!
 현재 미디어 쿼리가 얼마나 유용한 지 또는 컨테이너 쿼리가 얼마나 유용한 지 생각해보십시오. 그러나 이러한 것들이 노출되는 상태뿐만 아니라 임의의 상태이기 때문에 복잡해집니다.
 

Bram은 Lea Verou가 "상위 수준의 사용자 지정 속성"이라고 부르는 것을 언급하면서이를 다뤘습니다.
 

```css
/* Theoretical! */

.square {
  width: 2vw;
  padding: 0.25vw;
  aspect-ratio: 1/1;

  @if (var(--size) = big) {
    width: 16vw;
    padding: 1vw;
  }
}

.my-input {
  @if(var(--pill) = on) {
    border-radius: 999px;
   }
}
```

### 그 이름에 대해
 

Will은이를 "CSS 변수"라고 부르는데 이는 매우 일반적이고 이해하기 쉽습니다.
 "CSS 변수 (CSS 사용자 정의 속성이라고도 함)"또는 "CSS 사용자 정의 속성 (CSS 변수라고도 함)"과 같은 문장을 자주 읽습니다 (그리고 제가 작성했습니다). Šime Vidas는 최근에 이들을 참조하는 다소 정확한 방법이 있다고 언급했습니다.
 것들 :`--this-part`는 사용자 정의 속성이고`var (-this-part)`는 변수로, 사양에서 사용하면 바로 나타납니다.
 

### 자바 스크립트 라이브러리 상태… 자동?
 

이 Vue 제안이 생각납니다.
 어디로 갔는지 확실하지 않지만 구성 요소의 상태가 CSS 사용자 정의 속성으로 자동으로 노출된다는 생각입니다.
 

```vue sfc
<template>
  <div class="text">Hello</div>
</template>

<script>
export default {
  data() {
    return {
      color: 'red'
    }
  }
}
</script>

<style vars="{ color }">
.text {
  color: var(--color);
}
</style>
```

이 구성 요소의 상태의 일부로 `색상`을 사용하기 때문에이 구성 요소의 CSS에 `--color`를 상태로 사용할 수 있습니다.
 좋은 생각이라고 생각합니다.
 

React에서`useState`를 사용할 때마다 CSS 사용자 정의 속성이`: root`에 추가되고 자동으로 업데이트되면 어떨까요?
 예를 들어 다음을 수행 한 경우 :
 

```jsx
import React, { useState } from 'https://cdn.skypack.dev/react@^16.13.1';
import ReactDOM from 'https://cdn.skypack.dev/react-dom@^16.13.1';

const App = () => {
  const [ activeColor, setActiveColor ] = useState("red");
  return(
    <div className="box">
      <h1>Active Color: {activeColor}</h1>
      <button onClick={() => {setActiveColor("red")}}>red</button>
      <button onClick={() => {setActiveColor("blue")}}>blue</button>
    </div>
  );
}

ReactDOM.render(<App />,
document.getElementById("root"))
```

그리고 다음과 같이 할 수 있다는 것을 알고 있습니다.
 

```css
.box {
  border-color: 2px solid var(--activeColor);
}
```

상태가 자동으로 사용자 지정 속성에 매핑되기 때문입니다.
 누군가`useStateWithCustomProperties` 후크를 만들어야합니다.
 #freeidea
 

React 및 Vue와 같은 라이브러리는 UI 구축을위한 것입니다.
 그들이 관리하는 상태가 CSS에 자동으로 노출된다는 것이 많은 의미가 있다고 생각합니다.
 

### 브라우저가 환경 변수로 더 많은 페이지 상태를 제공 할 수 있습니까?
 

CSS가 알아야 할 상태에 대해 말하자면, 현재 마우스 위치 또는 스크롤 위치와 같은 항목을 CSS에 매핑하여 재미있는 작업을 수행하는 데모를 많이 보았습니다.
 해당 데이터가 기본적으로 CSS에 노출되도록 요청하는 것이 전적으로 부당하다고 생각하지 않습니다.
 우리는 이미`env (safe-area-inset-top)`과 같은 환경 변수의 개념을 가지고 있으며`env (page-scroll-percentage)`또는`env (와 같은 페이지 상태를 노출하는 데 사용되는 것을 볼 수 있습니다.
 mouseY)`.
 