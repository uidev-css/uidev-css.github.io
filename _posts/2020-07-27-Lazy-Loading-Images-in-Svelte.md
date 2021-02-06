---
layout: post
title: "슬리브에서 이미지를 느리게 로드"
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/07/svelte-images.png"
tags: 
---


웹 사이트의 속도를 향상시키는 한 가지 쉬운 방법은 필요한 경우에만 이미지를 다운로드하는 것입니다. 이미지는 뷰포트에 들어갈 때 다운로드하는 것입니다. 이 "게으름뱅이 로딩" 기법은 꽤 오래되었고 그것을 구현하는 방법에 대한 훌륭한 튜토리얼이 많이 있다.

그러나 모든 리소스를 사용하더라도 작업 중인 프로젝트나 사용 중인 프레임워크에 따라 느린 로드를 구현하는 것이 달라질 수 있습니다. 이 기사에서는 Svelte JavaScript 프레임워크로 이미지를 느리게 로드하기 위해 `onLoad` 이벤트와 함께 Intersection Observer API를 사용할 것입니다.

트라이스트람 톨리데이의 스벨트에 대한 소개를 확인해 보세요.

### 실제 사례를 들어 보겠습니다.

저는 이 접근 방식을 조합하여 Svelte와 Sapper 응용 프로그램인 Shop Ireland에서 속도를 테스트했습니다. 우리의 목표 중 하나는 우리가 할 수 있는 한 빨리 만드는 것이다. 우리는 브라우저가 화면에도 없는 많은 이미지들을 다운로드하기 때문에 홈페이지가 성능 적중하는 지점에 도달했습니다. 그래서 자연스럽게 우리는 대신 게으른 로딩으로 돌아섰습니다.


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video controls="" poster="https://css-tricks.com/wp-content/uploads/2020/07/Screen-Shot-2020-07-10-at-4.49.12-PM.png" src="https://videos.files.wordpress.com/Xeq7i1fa/shopireland_image_loading_hd.mp4" name="fitvid0"></video>
</div>


스벨트는 모든 코드가 미리 컴파일되어 있기 때문에 이미 상당히 빠르게 진행되고 있다. 하지만 일단 우리가 게으르게 영상을 찍기 시작하자, 상황은 정말 빨라지기 시작했습니다.

이것이 우리가 함께 작업하려는 것입니다. GitHub에서 이 데모에 대한 최종 코드를 가져오고 작동 방법에 대한 설명을 읽어보십시오.

여기서 마지막을 장식할 것입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_abdLERL" src="//codepen.io/anon/embed/abdLERL?height=450&amp;theme-id=1&amp;slug-hash=abdLERL&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed abdLERL" title="CodePen Embed abdLERL" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### Svelte를 빨리 시작하자.

이미 사용하고 싶은 Svelte 앱이 있을 수 있지만, 없을 경우 새 Svelte 프로젝트를 시작하고 로컬에서 작업해 보겠습니다. 명령줄에서 다음을 수행합니다.

```terminal
npx degit sveltejs/template my-svelte-project
cd my-svelte-project
npm install
npm run dev
```

이제 `http://localhost:5000`에서 초기 앱을 실행할 수 있습니다.

### 구성 요소 폴더 추가

초기 Svelte 데모에는 App.svelte 파일이 있지만 아직 컴포넌트는 없다. 이 데모에 필요한 구성 요소를 설정하겠습니다. 구성 요소 폴더가 없으므로 `src` 폴더에 생성해 보겠습니다. 해당 폴더 내에 `이미지` 폴더를 만듭니다. 이 폴더에는 데모에 대한 구성 요소가 포함됩니다.

우리는 우리의 구성 요소들이 두 가지 일을 하도록 할 것입니다. 먼저, 이미지가 뷰포트에 언제 입력되는지 확인합니다. 그런 다음 이미지가 입력되면 구성 요소는 이미지 파일이 로드될 때까지 기다렸다가 표시합니다.

첫 번째 구성 요소는 두 번째 구성 요소인 `ImageLoader`를 감싸는 `<Intersection Observer>`가 될 것입니다. 이 설정이 마음에 드는 것은 각 구성 요소가 단일 구성 요소에서 여러 작업을 일괄 처리하는 대신 하나의 작업에 집중할 수 있도록 한다는 것입니다.

먼저 `<Intersection Observer>` 구성 요소부터 살펴보겠습니다.

### 교차점 관찰

우리의 첫 번째 구성요소는 Intersection Observer API의 작업 구현이 될 것이다. 교차로 관찰자는 꽤 복잡한 것이지만 그것의 요지는 그것이 그것의 부모의 경계 상자에 들어갈 때 아이 요소를 지켜보고 우리에게 알려준다는 것이다. 이 이미지들은 어떤 상위 요소의 자녀가 될 수 있고, 그들이 시야로 스크롤할 때 우리는 헤딩을 할 수 있습니다.

Intersection Observer API의 안팎을 아는 것은 분명 좋은 생각이지만, Travis Almand는 이를 훌륭하게 기록했습니다. 우리는 리치 해리스가 svelte.dev를 위해 함께 만든 편리한 Svelte 부품을 사용할 것입니다.

정확히 뭘 하는지 조사하기 전에 먼저 준비하도록 하죠. 새 `IntersectionObserver.svelte` 파일을 만들어 `src/components/Image` 폴더에 놓습니다. 여기서 다음 코드를 사용하여 구성 요소를 정의합니다.

```js
<script>
  import { onMount } from 'svelte';
 
  export let once = false;
  export let top = 0;
  export let bottom = 0;
  export let left = 0;
  export let right = 0;
 
  let intersecting = false;
  let container;
 
  onMount(() => {
    if (typeof IntersectionObserver !== 'undefined') {
      const rootMargin = `${bottom}px ${left}px ${top}px ${right}px`;
 
      const observer = new IntersectionObserver(entries => {
        intersecting = entries[0].isIntersecting;
        if (intersecting && once) {
          observer.unobserve(container);
        }
      }, {
        rootMargin
      });
 
      observer.observe(container);
      return () => observer.unobserve(container);
    }

     // The following is a fallback for older browsers
    function handler() {
      const bcr = container.getBoundingClientRect();
 
      intersecting = (
        (bcr.bottom + bottom) > 0 &&
        (bcr.right + right) > 0 &&
        (bcr.top - top) < window.innerHeight &&
        (bcr.left - left) < window.innerWidth
      );
 
      if (intersecting && once) {
        window.removeEventListener('scroll', handler);
      }
    }
 
    window.addEventListener('scroll', handler);
    return () => window.removeEventListener('scroll', handler);
  });
</script>
 
<style>
  div {
    width: 100%;
    height: 100%;
  }
</style>
 
<div bind:this={container}>
  <slot {intersecting}></slot>
</div>
```

이 구성 요소를 다른 구성 요소를 감싸는 래퍼로 사용할 수 있으며, 래핑된 구성 요소가 뷰포트와 교차하는지 여부를 결정합니다.

Svelte 구성 요소의 구조에 익숙하다면 스크립트로 시작하고 스타일에 들어간 다음 마크업으로 끝나는 패턴을 볼 수 있습니다. 그것은 교차점이 시작되는 지점을 정의하는 화면 가장자리에서 상단, 오른쪽, 하단 및 왼쪽 거리에 대한 숫자 값과 함께 `한 번` 속성을 포함하여 우리가 전달할 수 있는 몇 가지 옵션을 설정한다.

우리는 거리는 무시하고 대신 `한 번`의 속성을 이용할 것이다. 이렇게 하면 이미지가 뷰포트에 들어갈 때 한 번만 로드됩니다.

구성 요소의 주요 논리는 `onMount` 섹션 내에 있습니다. 이렇게 하면 관찰자가 설정되며, 요소가 화면의 보이는 영역과 "교차"되는지 여부를 확인하는 데 사용됩니다.

이전 브라우저의 경우 스크롤할 때 요소가 표시되는지 여부를 확인하기 위해 스크롤 이벤트도 첨부하고, 실행 가능하고 `한 번`이 참이라고 판단되면 이 수신기가 제거됩니다.

### 영상 로드

`<Intersection Observer>` 구성 요소를 사용하여 `<ImageLoader> 구성 요소를 둘러 이미지를 조건부로 로드합니다. 다시 말하지만, 이 구성 요소는 `<Intersection Observer>`로부터 알림을 수신하여 이미지를 로드할 때라는 것을 알 수 있습니다.

즉, `구성 요소/이미지`에 새 구성 요소 파일이 필요합니다. 이것을 `ImageLoader`라고 부르자.비굴하게 하다 원하는 코드는 다음과 같습니다.

```js
<script>
  export let src
  export let alt
 
  import IntersectionObserver from './IntersectionObserver.svelte'
  import Image from './Image.svelte'
  
</script>
 
<IntersectionObserver once={true} let:intersecting={intersecting}>
  {#if intersecting}
    <Image {alt} {src} />
  {/if}
</IntersectionObserver>
```

이 구성 요소는 이미지의 실제 마크업을 만드는 데 사용할 이미지 관련 소품인 `src`와 `alt`를 사용합니다. 방금 만든 <인터섹션 관찰자>와 아직 만들지 않았지만 잠시 후에 시작할 <이미지>라는 두 가지 구성 요소를 스크립트 섹션에 가져올 예정입니다.

곧 만들어질 <이미지> 구성 요소를 감싸는 역할을 함으로써 <인터섹션 관찰자>가 작동하게 된다. 그 위에 있는 그 특성들을 확인해 보세요. 우리는 `한 번`을 `진실`로 설정하기 때문에 처음 볼 때만 이미지가 로드됩니다.

그리고 나서 우리는 스벨트의 슬롯 소품을 활용한다. 저것들은 무엇인가요? 그 다음은 취재합시다.

### 속성 값 슬롯 지정

우리의 `인터섹션 관찰자`와 같은 랩핑 구성품은 그것이 포함하고 있는 아이들에게 소품을 전달하는데 편리하다. 스벨트는 우리에게 슬롯 소품이라고 불리는 것을 줍니다.

당사의 `<Intersection Observer>` 구성 요소에서 다음과 같은 줄을 알아차렸을 수 있습니다.

```js
<slot {intersecting}></slot>
```

이것은 교차하는 소품을 우리가 주는 어떤 부품으로든 전달하는 것입니다. 이 경우 < 구성 요소는 래퍼를 사용할 때 프로포트를 수신합니다. 다음과 같이 let:conting={conting}을(를) 사용하여 소품에 액세스합니다.

```js
<IntersectionObserver once={true} let:intersecting={intersecting}>
```

그런 다음 교차 값을 사용하여 `<이미지> 구성 요소를 로드할 시기를 결정할 수 있습니다. 이 경우, 언제 시간이 되는지 확인하기 위해 if 조건을 사용합니다.

```js
<IntersectionObserver once={true} let:intersecting={intersecting}>
  {#if intersecting}
    <Image {alt} {src} />
  {/if}
</IntersectionObserver> 
```

교차로일 경우 <이미지>가 로드되고 알트(alt)와 src(src) 소품이 수신된다. 슬롯 소품에 대한 자세한 내용은 이 Svelte 튜토리얼에서 확인할 수 있습니다.

이제 화면에 스크롤할 때 `이미지` 구성 요소를 보여주는 코드가 준비되었습니다. 드디어 부품 제작에 착수합시다.

### 로드 시 이미지 표시

예, 짐작하셨겠죠? `이미지` 구성 요소의 `구성 요소/이미지` 폴더에 `이미지.svelte` 파일을 추가해 봅시다. 이것이 우리의 `알트`와 `src` 소품을 받아 `임그` 소자 위에 올려놓는 구성 요소다.

구성 요소 코드는 다음과 같습니다.

```js
<script>
  export let src
  export let alt
 
  import { onMount } from 'svelte'
 
  let loaded = false
  let thisImage
 
  onMount(() => {
    thisImage.onload = () => {
      loaded = true
    }
  }) 
 
</script>
 
<style>
  img {
    height: 200px;
    opacity: 0;
    transition: opacity 1200ms ease-out;
  }
  img.loaded {
    opacity: 1;
  }
</style>
 
<img {src} {alt} class:loaded bind:this={thisImage} />
```

즉, 우리는 이미지의 로드 여부를 저장하기 위한 loaded와 img DOM 요소 자체에 대한 참조를 저장하기 위한 this image라는 두 가지 변수를 정의하기 전에 alt와 src 소품을 수신하고 있다.

우리는 또한 "온마운트"라고 불리는 유용한 스벨트 방법을 사용하고 있습니다. 이렇게 하면 DOM에 구성 요소가 렌더링되면 함수를 호출할 수 있습니다. 이 경우 "ThisImage.onload"에 대한 콜백이 설정됩니다. 일반 영어에서는 이미지 로드가 완료되면 실행되며 로드된 변수를 `true` 값으로 설정합니다.

우리는 CSS를 사용하여 이미지를 공개하고 보기 좋게 희미하게 만들 것입니다. 이미지 세트에는 `opacity: 0`을 부여하여 처음에는 보이지 않지만 페이지에는 보이지 않도록 합니다. 그런 다음 뷰포트를 교차하고 `<ImageLoader>`에서 이미지를 로드할 수 있는 권한을 부여하면 이미지를 전체 불투명도로 설정합니다. 이미지 전환 속성을 설정해 매끄러운 전환으로 만들 수 있다. 데모에서는 전환 시간을 1200ms로 설정하지만 필요에 따라 속도를 높이거나 늦출 수 있습니다.

이는 파일의 마지막 줄인 `img` 요소에 대한 마크업으로 이어집니다.

```js
<img {src} {alt} class:loaded bind:this={thisImage} />
```

로드된 변수가 `true`인 경우 `class:loaded`를 사용하여 `.loaded` 클래스를 조건부로 적용합니다. 또한 bind:this 방법을 사용하여 이 DOM 요소를 이 이미지 변수와 연결합니다.

### 네이티브 게으른 부하

브라우저에서의 네이티브 게으른 로딩에 대한 지원이 거의 다 되어가지만, 현재 모든 안정된 버전에서는 아직 지원되지 않는다. 간단한 기능 검사를 통해 지원을 추가할 수 있습니다.

`ImageLoader`에서요.svelte 파일을 가져오면 "onMount" 기능을 사용할 수 있으며, 그 안에서 브라우저가 느린 로드를 지원하는지 확인합니다.

```js
import { onMount } from 'svelte'

let nativeLoading = false
// Determine whether to bypass our intersecting check
onMount(() => {
  if ('loading' in HTMLImageElement.prototype) {
    nativeLoading = true
  }
})
```

그런 다음 이 `native loading` 부울을 포함하도록 `if` 조건을 조정한다.

```js
{#if intersecting || nativeLoading}
  <Image {alt} {src} />
{/if}
```

마지막으로, Image.svelte에서는 브라우저에 loading="the"를 추가하여 loading="thead"를 사용하도록 합니다.

```js
<img {src} {alt} class:loaded bind:this={thisImage} loading="lazy" />
```

이를 통해 최신 브라우저와 미래 브라우저는 우리의 코드를 무시하고 느릿느릿한 로드를 기본적으로 처리할 수 있다.

### 모두 연결하자!

네, 이제 저희 부품을 실제로 사용해야 할 때입니다. `App.svelte` 파일을 열고 다음 코드를 삭제하여 구성 요소를 가져와 사용합니다.

```js
<script>
  import ImageLoader from './components/Image/ImageLoader.svelte';
</script>
 
<ImageLoader src="OUR_IMAGE_URL" alt="Our image"></ImageLoader>
```

다시 한 번 데모합니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_abdLERL" src="//codepen.io/anon/embed/abdLERL?height=450&amp;theme-id=1&amp;slug-hash=abdLERL&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed abdLERL" title="CodePen Embed abdLERL" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

그리고 GitHub에서 데모의 전체 코드를 다운로드하는 것을 환영한다는 것을 기억하십시오. 프로덕션 사이트에서 이 작업이 실행되는 것을 보려면 Shop Ireland 프로젝트를 확인하십시오. 게으른 로딩은 홈페이지, 카테고리 페이지, 검색 페이지에서 속도를 높이는 데 도움이 됩니다. 스벨트 프로젝트에 유용하게 쓰시길 바랍니다!