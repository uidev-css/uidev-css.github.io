---
layout: post
title: "CSS 사용자 정의 속성을 사용하여 CSS 애니메이션을 재생하고 일시 중지하는 방법
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2021/01/circles-colors.jpg
tags: ANIMATION,CUSTOM PROPERTIES,DETAILS/SUMMARY,INTERSECTIONOBSERVER,KEYFRAMES
---


CSS`@ keyframes` 애니메이션을 살펴보고 구체적으로 일시 중지하고 제어하는 방법에 대해 살펴 보겠습니다.
 특별히 JavaScript로 제어 할 수있는 CSS 속성이 있지만 세부 사항에 대해 다루어야 할 뉘앙스가 많습니다.
 또한 많은 제어를 제공하는 내가 선호하는 설정 방법을 살펴 보겠습니다.
 힌트 : CSS 사용자 지정 속성이 포함됩니다.
 

### 애니메이션 일시 중지의 중요성
 

최근에이 기사의 뒷부분에서 보게 될 CSS 기반 슬라이드 쇼를 작업하는 동안 DevTools의 레이어 패널에서 애니메이션을 검사했습니다.
 이전에는 생각하지 못했던 흥미로운 점을 발견했습니다. 현재 뷰포트에없는 애니메이션이 여전히 실행 중이었습니다!
 

예상치 못한 일이 아닐 수도 있습니다.
 우리는 비디오가 그렇게한다는 것을 압니다.
 동영상은 일시 중지 할 때까지 계속됩니다.
 하지만 이러한 재생 애니메이션이 여전히 CPU / GPU를 사용하는지 궁금합니다.
 불필요한 처리 능력을 소비하여 페이지의 다른 부분을 느리게합니까?
 

DevTools의 성능 패널에서 프레임을 검사해도 "오프 스크린"프레임을 볼 수 없었기 때문에 더 이상 이에 대해 밝히지 않았습니다.
 그러나 첫 번째 슬라이드에서 "CSS 전용 슬라이드 쇼"에서 스크롤을 내린 다음 기다렸다가 뒤로 스크롤하면 슬라이드 5에있었습니다.
 애니메이션이 일시 중지되지 않았습니다.
 애니메이션은 일시 중지 할 때까지 실행되고 실행됩니다.
 

그래서 애니메이션이 언제, 어떻게, 왜, 언제 일시 중지되어야하는지 알아보기 시작했습니다.
 위의 결과를 고려할 때 성능은 분명한 이유입니다.
 또 다른 이유는 통제입니다.
 사용자는 제어권을 갖고 싶어 할뿐만 아니라 제어권도 갖고 있어야합니다.
 몇 년 전에 아내는 정말 심한 뇌진탕을 앓았습니다.
 그 이후로 그녀는 어지럽게 만드는 애니메이션이 너무 많은 웹 페이지를 피했습니다.
 결과적으로 접근성이 애니메이션 일시 중지를 허용하는 가장 중요한 이유라고 생각합니다.
 

모두 함께, 이것은 중요한 것입니다.
 구체적으로 CSS 키 프레임 애니메이션에 대해 이야기하고 있지만 광범위하게는 다음에 대해 이야기하고 있습니다.
 

- 공연
 
- 제어
 
- 접근성
 

### 애니메이션 일시 중지의 기본 사항
 

CSS에서 애니메이션을 진정으로 일시 중지하는 유일한 방법은 `paused`값과 함께 `animation-play-state`속성을 사용하는 것입니다.
 

```css
.paused {
  animation-play-state: paused;
}
```

자바 스크립트에서 속성은 `animationPlayState`로 `camelCased`이며 다음과 같이 설정됩니다.
 

```js
element.style.animationPlayState = 'paused';
```

`animationPlayState`의 현재 값을 읽어 애니메이션을 재생하고 일시 중지하는 토글을 만들 수 있습니다.
 

```js
const running = element.style.animationPlayState === 'running';
```

... 그런 다음 반대 값으로 설정합니다.
 

```js
element.style.animationPlayState = running ? 'paused' : 'running';
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 1100px;"><iframe id="cp_embed_rNMprwo" src="//codepen.io/anon/embed/rNMprwo?height=1100&amp;theme-id=1&amp;slug-hash=rNMprwo&amp;default-tab=result" height="1100" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed rNMprwo" title="CodePen Embed rNMprwo" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

애니메이션을 일시 중지하는 또 다른 방법은 `animation-duration`을 `0s`로 설정하는 것입니다.
 애니메이션이 실제로 실행 중이지만 기간이 없기 때문에 작업이 표시되지 않습니다.
 

하지만 값을 `3s`로 변경하면 :
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 1100px;"><iframe id="cp_embed_poEpZrK" src="//codepen.io/anon/embed/poEpZrK?height=1100&amp;theme-id=1&amp;slug-hash=poEpZrK&amp;default-tab=result" height="1100" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed poEpZrK" title="CodePen Embed poEpZrK" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

작동하지만 중요한주의 사항이 있습니다. 애니메이션이 기술적으로 여전히 실행 중입니다.
 애니메이션은 초기 위치와 시퀀스의 다음 위치 사이를 전환 할뿐입니다.
 

애니메이션을 완전히 제거하고 클래스를 통해 다시 추가 할 수 있지만 `animation-duration`과 마찬가지로 실제로 애니메이션이 일시 중지되지는 않습니다.
 

```css
.remove-animation {
  animation: none !important;
}
```

진정한 일시 중지는 우리가 여기서 추구하는 것이기 때문에 `애니메이션 재생 상태`를 고수하고 다른 사용 방법을 살펴 보겠습니다.
 

### 데이터 속성 및 CSS 사용자 정의 속성 사용
 

CSS에서 데이터 속성을 선택기로 사용하겠습니다.
 원하는대로 호출 할 수 있으므로 애니메이션을 재생 / 일시 중지하려는 모든 요소에`[data-animation]`속성을 사용하겠습니다.
 이렇게하면 다른 애니메이션과 구별 할 수 있습니다.
 

```html
<div data-animation></div>
```

그 속성은 선택자이고`animation` 속기는 우리가 모든 것을 설정하는 속성입니다.
 CSS 사용자 정의 속성 * (* Emmet- 약어 사용)을 값으로 사용합니다.
 

```css
[data-animation] {
  animation:
    var(--animn, none)
    var(--animdur, 1s)
    var(--animtf, linear)
    var(--animdel, 0s)
    var(--animic, infinite)
    var(--animdir, alternate)
    var(--animfm, none)
    var(--animps, running);
}
```

이를 통해이 데이터 속성이있는 모든 애니메이션은 완벽하게 애니메이션을 수용 할 수 있으며 사용자 지정 속성으로 애니메이션의 개별 측면을 제어 할 수 있습니다.
 일부 애니메이션에는 공통된 항목 (예 : 기간, 여유 유형 등)이 있으므로 대체 값도 사용자 지정 속성에 설정됩니다.
 

왜 CSS 사용자 정의 속성입니까?
 우선 CSS와 JavaScript에서 읽고 설정할 수 있습니다.
 둘째, 작성해야하는 CSS의 양을 크게 줄이는 데 도움이됩니다.
 또한`@ keyframes` (적어도 작성 당시 Chrome에서) 내에서 설정할 수 있기 때문에 애니메이션 작업에 새롭고 기존 방식을 제공합니다!
 

애니메이션 자체의 경우 클래스 선택기를 사용하고`[data-animation]`-selector에서 변수를 업데이트하고 있습니다.
 

```html
<div class="circle a-slide" data-animation></div>
```

왜 클래스와 데이터 속성인가?
 이 단계에서`data-animation` 속성은 일반 클래스 일 수도 있지만 나중에 더 고급 방식으로 사용할 것입니다.
 `.circle` 클래스 이름은 실제로 애니메이션과 아무 관련이 없습니다. 요소를 스타일링하기위한 클래스 일뿐입니다.
 

```css
/* Animation classes */
.a-pulse {
  --animn: pulse;
}
.a-slide {
  --animdur: 3s;
  --animn: slide;
}

/* Keyframes */
@keyframes pulse {
  0% { transform: scale(1); }
  25% { transform: scale(.9); }
  50% { transform: scale(1); }
  75% { transform: scale(1.1); }
  100% { transform: scale(1); }
}
@keyframes slide {
  from { margin-left: 0%; }
  to { margin-left: 150px; }
}
```

변경 될 값만 업데이트하면되므로 `data-animation`선택기의 대체 값에 몇 가지 공통 값을 사용하는 경우 애니메이션의 맞춤 속성 인 `--animn`이름 만 업데이트하면됩니다.
 

ol `체크 박스 해킹을 사용하여 모든 애니메이션을 일시 중지하려면 애니메이션 앞에 체크 박스를 만들어 보겠습니다.
 

```html
<input type="checkbox" data-animation-pause />
```

그리고`checked`되면`--animps` 속성을 업데이트합니다.
 

```css
[data-animation-pause]:checked ~ [data-animation] {
  --animps: paused;
}
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 1000px;"><iframe id="cp_embed_WNGEJWp" src="//codepen.io/anon/embed/WNGEJWp?height=1000&amp;theme-id=1&amp;slug-hash=WNGEJWp&amp;default-tab=result" height="1000" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed WNGEJWp" title="CodePen Embed WNGEJWp" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

그게 다야!
 확인란을 클릭하면 애니메이션이 재생 및 일시 중지간에 전환되며 JavaScript가 필요하지 않습니다.
 

### CSS 전용 슬라이드 쇼
 

이 아이디어 중 일부를 적용 해 보겠습니다!
 

최근에`<details>`태그를 많이 사용했습니다.
 아코디언의 명백한 후보이지만 툴팁, 토글 팁, 드롭 다운 ( `<select>`-like-look-a-likes 스타일), 메가 메뉴에도 사용할 수 있습니다.
 결국 공식 HTML 공개 요소입니다.
 모든 HTML 요소가 허용하는 전역 속성 및 전역 이벤트 외에도`<details>`에는 단일`open` 속성과 단일`toggle` 이벤트가 있습니다.
 따라서 체크 박스 해킹과 마찬가지로 상태를 전환하는 데 적합하지만 더 간단합니다.
 

```css
details[open] {
  --state: 1;
}
details:not([open]) {
  --state: 0;
}
```

저는 `자동 재생`이라는 기본 애니메이션을 통해 슬라이드가 자동으로 변경되는 슬라이드 쇼를하기로 결정했습니다. 각 슬라이드에는 고유 한 보조 애니메이션이 있습니다.
 `animation-play-state`는`--animps`- 속성에 의해 제어됩니다.
 각 개별 슬라이드는`--animn` 속성에 정의 된 고유 한 애니메이션을 가질 수 있습니다.
 

```html
<figure style="--animn:kenburns-top;--index:0;">
  <img src="some-slide-image.jpg" />
  <figcaption>Caption</figcaption>
</figure>
```

보조 애니메이션의`animation-play-state`는`--img-animps`- 속성에 의해 제어됩니다.
 Animista에서 멋진 Ken Burns-esque 애니메이션을 많이 찾았고 슬라이드의`--animn` 속성에서 전환했습니다.
 

GPU 과부하를 방지하기 위해 기본 애니메이션이 보조 애니메이션을 일시 중지하는 것이 이상적입니다.
 앞서 간단히 언급했지만 Chrome (작성 당시에는 약간 흔들림) 만`@ keyframe` 애니메이션에서 CSS 사용자 정의 속성을 업데이트 할 수 있습니다. 다음 예제에서`-
 bgc`-property 및`--counter`-properties는 다른 프레임에서 수정됩니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_WNGMoeV" src="//codepen.io/anon/embed/WNGMoeV?height=450&amp;theme-id=1&amp;slug-hash=WNGMoeV&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed WNGMoeV" title="CodePen Embed WNGMoeV" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

보조 애니메이션의 초기 상태 인`--img-animps` -property는 기본 애니메이션이 실행중인 경우에도 `일시 중지`되어야합니다.
 

```css
details[open] ~ .c-mm__inner .c-mm__frame {
  --animps: running;
  --img-animps: paused;
}
```

그런 다음 기본 애니메이션`@ keyframes`에서 속성이`running`으로 업데이트됩니다.
 

```css
@keyframes autoplay {
  0.1% {
    --img-animps: running; /* START */
    opacity: 0;
    z-index: calc(var(--z) + var(--slides))
  }
  5% { opacity: 1 }
  50% { opacity: 1 }
  51% { --img-animps: paused } /* STOP! */
  100% {
    opacity: 0;
    z-index: var(--z)
  }
}
```

Chrome 이외의 브라우저에서이 작업을 수행하려면 `@keyframe`에서 CSS 맞춤 속성을 업데이트 할 수 없으므로 초기 값이 `실행 중`이어야합니다.
 

다음은 자바 스크립트가 필요하지 않은 `세부 정보 해킹`재생 / 일시 중지 버튼이있는 슬라이드 쇼입니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 700px;"><iframe id="cp_embed_NWRGavM" src="//codepen.io/anon/embed/NWRGavM?height=700&amp;theme-id=1&amp;slug-hash=NWRGavM&amp;default-tab=result" height="700" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed NWRGavM" title="CodePen Embed NWRGavM" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### '감소 동작 선호'활성화
 

어떤 사람들은 애니메이션을 선호하지 않거나 최소한 움직임을 줄입니다.
 개인적인 취향 일 수도 있지만 의학적 상태 때문일 수도 있습니다.
 이 게시물의 맨 위에 애니메이션 접근성의 중요성에 대해 이야기했습니다.
 

macOS와 Windows에는 모두 사용자가 웹 사이트에서 움직임 감소를 선호한다고 브라우저에 알릴 수있는 옵션이 있습니다.
 이를 통해 Eric Bailey가 작성한 `prefers-reduced-motion`기능 쿼리에 도달 할 수 있습니다.
 

`[data-animation]`-selector를 사용하여`prefers-reduced-motion`이 활성화되었을 때 적용되는 다른 값을 제공하여 감소 된 동작을 만들어 보겠습니다 * : *
 

- `alternate` = 다른 애니메이션 실행
 
- `once` =`animation-iteration-count`를 1로 설정
 
- `slow` =`animation-duration`-property 변경
 
- `stop` =`animation-play-state`를`paused`로 설정
 

이것은 단지 제안 일 뿐이며 실제로 원하는 것은 무엇이든 될 수 있습니다.
 

```html
<div class="circle a-slide" data-animation="alternate"></div>
<div class="circle a-slide" data-animation="once"></div>
<div class="circle a-slide" data-animation="slow"></div>
<div class="circle a-slide" data-animation="stop"></div>
```

업데이트 된 미디어 쿼리 :
 

```css
@media (prefers-reduced-motion) {
  [data-animation="alternate"] {
   /* Change animation duration AND name */
    --animdur: 4s;
    --animn: opacity;
  }
  [data-animation="slow"] {
    /* Change animation duration */
    --animdur: 10s;
  }
  [data-animation="stop"] {
    /* Stop the animation */
    --animps: paused;
  }
}
```

이것이 너무 일반적이고 애니메이션 클래스 당 고유 한 대체 애니메이션을 선호하는 경우 다음과 같이 선택기를 그룹화합니다.
 

```css
.a-slide[data-animation="alternate"] { /* etc. */ }
```

다음은 `축소 된 동작 선호`를 시뮬레이션하는 체크 박스가있는 펜입니다.
 펜 내에서 아래로 스크롤하여 각 원의 동작 변화를 확인합니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 1000px;"><iframe id="cp_embed_BaLdxgz" src="//codepen.io/anon/embed/BaLdxgz?height=1000&amp;theme-id=1&amp;slug-hash=BaLdxgz&amp;default-tab=result" height="1000" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed BaLdxgz" title="CodePen Embed BaLdxgz" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### JavaScript로 일시 중지
 

자바 스크립트에서 `모든 애니메이션 일시 중지`체크 박스를 다시 만들려면 모든`[data-animation]`요소를 반복하고 동일한`--animps` 사용자 정의 속성을 전환합니다.
 

```html
<button id="js-toggle" type="button">Toggle Animations</button>
```

```js
const animations = document.querySelectorAll('[data-animation');
const jstoggle = document.getElementById('js-toggle');

jstoggle.addEventListener('click', () => {
  animations.forEach(animation => {
    const running = getComputedStyle(animation).getPropertyValue("--animps") || 'running';
    animation.style.setProperty('--animps', running === 'running' ? 'paused' : 'running');
  })
});
```

체크 박스 해킹과 정확히 동일한 개념으로 동일한 맞춤 속성 `--animps`를 사용하며 CSS 대신 자바 스크립트로만 설정합니다.
 이전 브라우저를 지원하려면 `animation-play-state`를 업데이트하는 클래스를 토글 할 수 있습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 1050px;"><iframe id="cp_embed_xxELjvm" src="//codepen.io/anon/embed/xxELjvm?height=1050&amp;theme-id=1&amp;slug-hash=xxELjvm&amp;default-tab=result" height="1050" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed xxELjvm" title="CodePen Embed xxELjvm" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### `IntersectionObserver` 사용
 

모든`[data-animation]`애니메이션을 자동으로 재생하고 일시 중지하기 위해 (따라서 불필요하게 GPU에 과부하가 걸리지 않도록)`IntersectionObserver`를 사용할 수 있습니다.
 

먼저 애니메이션이 전혀 실행되고 있지 않은지 확인해야합니다.
 

```css
[data-animation] {
  /* Change 'running' to 'paused' */
  animation: var(--animps, paused); 
}
```

그런 다음 관찰자를 만들고 요소가 뷰포트에서 25 % 또는 75 % 일 때 트리거합니다.
 후자가 일치하면 애니메이션 재생이 시작됩니다.
 그렇지 않으면 일시 중지됩니다.
 

기본적으로`[data-animation]`속성이있는 모든 요소가 관찰되지만`prefers-reduced-motion`이 활성화 된 경우 ( "reduce"로 설정)`[data-animation = "stop
 "]`은 무시됩니다.
 

```js
const IO = new IntersectionObserver((entries) => {
  entries.forEach((entry) => {
    if (entry.isIntersecting) {
      const state = (entry.intersectionRatio >= 0.75) ? 'running' : 'paused';
      entry.target.style.setProperty('--animps', state);
    }
  });
}, {
  threshold: [0.25, 0.75]
});

const mediaQuery = window.matchMedia("(prefers-reduced-motion: reduce)");
const elements = mediaQuery?.matches ? document.querySelectorAll(`[data-animation]:not([data-animation="stop"]`) : document.querySelectorAll('[data-animation]');

elements.forEach(animation => {
  IO.observe(animation);
});
```

`임계 값`값 및 / 또는 트리거 한 후 일부 애니메이션을 `관찰 해제`해야하는지 여부 등을 가지고 놀아야합니다. 새 콘텐츠 나 애니메이션을 동적으로로드하는 경우 부분을 다시 작성해야 할 수 있습니다.
 관찰자의
 모든 시나리오를 다룰 수는 없지만이를 기초로 사용하면 CSS 애니메이션 자동 재생 및 일시 중지를 시작할 수 있습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 500px;"><iframe id="cp_embed_WNGEybO" src="//codepen.io/anon/embed/WNGEybO?height=500&amp;theme-id=1&amp;slug-hash=WNGEybO&amp;default-tab=result" height="500" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed WNGEybO" title="CodePen Embed WNGEybO" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 보너스 : 최소한의 자바 스크립트로 슬라이드 쇼에`<audio>`추가
 

다음은 우리가 만든 슬라이드 쇼에 음악을 추가하는 아이디어입니다.
 먼저`audio`- 태그를 추가합니다.
 

```html
<audio src="/asset/audio/slideshow.mp3" hidden loop></audio>
```

그런 다음 Javascript에서 :
 

```js
const audio = document.querySelector('your-audio-selector');
const details = document.querySelector('your-details-selector');
details.addEventListener('toggle', () => {
  details.open ? audio.play() : audio.pause();
})
```

아주 간단 하죠?
 

여기에서 "무성 영화"(오디오 포함) 데모를했습니다. 여기서 제 괴짜 과거를 알 수 있습니다.
 🙂
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 650px;"><iframe id="cp_embed_poEbxyR" src="//codepen.io/anon/embed/poEbxyR?height=650&amp;theme-id=1&amp;slug-hash=poEbxyR&amp;default-tab=result" height="650" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed poEbxyR" title="CodePen Embed poEbxyR" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>