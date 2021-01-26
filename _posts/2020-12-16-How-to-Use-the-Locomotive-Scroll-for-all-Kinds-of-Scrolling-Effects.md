---
layout: post
title: "모든 종류의 스크롤 효과를 위해 기관차 스크롤을 사용하는 방법
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/09/scroll-to-top.png
tags: SCROLLING
---


최근에 프로젝트에서 스크롤 효과를 수행하는 방법을 찾고 있었는데 Locomotive Scroll 라이브러리를 발견했습니다.
 스크롤 지점에서 시차 및 애니메이션 트리거 / 제어와 같은 다양한 스크롤 효과를 수행 할 수 있습니다.
 

"부드러운 스크롤"라이브러리라고도 할 수 있지만 기본 부드러운 스크롤을 활용하지 않습니다. 스크롤을 가상화하고 항상 매끄럽게 유지함으로써 그 반대입니다.
 이 "스크롤 재킹"을 고려할 수 있으므로 일반적으로 싫어하는 경우 싫어할 수도 있지만 실제로 나쁜지 여부에 대한 UX 조사는 다소 혼합 된 것 같습니다.
 홈페이지는 그것이 어떻게 작동하고 느끼는지에 대한 좋은 감각을 줄 것입니다.
 

Locomotive-Scroll JavaScript 사용의 기본 사항과이를 활용하여 즐거운 사용자 경험을 제공하는 방법을 살펴 보겠습니다.
 

### 기관차 스크롤은 무엇입니까?
 

그들이 말하는 내용은 다음과 같습니다.
 

> Locomotive scroll은 ayamflow의 가상 스크롤 위에 레이어로 구축 된 간단한 스크롤 라이브러리로, 시차 효과 지원, 클래스 전환, 요소가 뷰포트에있을 때 이벤트 리스너 트리거와 함께 부드러운 스크롤을 제공합니다.
 

즉, 요소가 뷰포트에있는시기를 감지 한 다음 해당 요소의 CSS`transform` 속성 값을 변경하여 스크롤 효과를 만듭니다.
 

종종 스크롤링 효과를 시차라고하는데, 이는 일부 요소가 배경에 깊숙이있는 것처럼 보이도록 만들어서 스크롤이 발생하는 동안 전경에 더 가까운 다른 요소보다 느리게 움직이는 것처럼 보이게하는 것을 의미합니다.
 움직이는 차에서 창 밖을보고 있다고 상상해보십시오.
 멀리있는 나무들은 길을 따라있는 울타리가 빠르게 지나가는 곳으로 천천히 표류하는 것처럼 보입니다.
 Sarah Drasner의이 펜의 효과와 비슷합니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 550px;"><iframe id="cp_embed_rMEdjB" src="//codepen.io/anon/embed/preview/rMEdjB?height=550&amp;theme-id=1&amp;slug-hash=rMEdjB&amp;default-tab=result" height="550" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed rMEdjB" title="CodePen Embed rMEdjB" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 작동 방식은 다음과 같습니다.
 

Locomotive Scroll은 주로 HTML의 특정 속성을 통해 작동합니다.
 이러한 속성이있는 요소는 뷰포트에있을 때 JavaScript에서 이벤트 리스너를 트리거 한 다음 CSS`transform` 값을 인라인 스타일로 적용합니다.
 

항상 Locomotive를 호출하는 두 가지 주요 속성이 있습니다.
 

- `data-scroll` : 요소가 뷰포트에 있는지 여부를 감지합니다.
 
- `data-scroll-container` : 스크롤을 보려는 모든 HTML 콘텐츠를 래핑합니다.
 

`transform`속성 값이 HTML에서 인라인 스타일로 업데이트된다는 내용은 다음과 같습니다.
 


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video controls="" src="https://css-tricks.com/wp-content/uploads/2020/12/another-tricks-Brave-2020-11-28-09-02-42_Trim_Trim_Trim.mp4" name="fitvid0"></video>
</div>


### 설정하겠습니다.
 

원하는 경우 라이브러리를`<script>`태그로 바로 사용할 수 있습니다.
 CDN에 있으므로 다음과 같습니다.
 

```html
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/locomotive-scroll@3.5.4/dist/locomotive-scroll.css"> 
<script src="https://cdn.jsdelivr.net/npm/locomotive-scroll@3.5.4/dist/locomotive-scroll.min.js">
```

이제 컨테이너를 찾고 라이브러리를 시작합니다.
 

```js
const scroller = new LocomotiveScroll({
  el: document.querySelector('[data-scroll-container]'),
  smooth: true
});
```

라이브러리도 npm에 있으므로 일반적인`npm install locomotive-scroll` 대신 빌드에서 그런 방식으로 사용할 수 있습니다.
 

```js
import LocomotiveScroll from 'locomotive-scroll';

const scroll = new LocomotiveScroll();
```

즉, 다음과 같이 Skypack에서도 사용할 수 있습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_BazXPzp" src="//codepen.io/anon/embed/preview/BazXPzp?height=450&amp;theme-id=1&amp;slug-hash=BazXPzp&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed BazXPzp" title="CodePen Embed BazXPzp" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이것이 설정에 대한 전부입니다!
 플러그 앤 플레이 방식입니다.
 

### 여기 예시들이 있습니다
 verified_user

이와 같은 것에 대한 꽤 좋은 사용 사례를 생각할 수 있지만 Locomotive Scroll을 사용할 수있는 몇 가지 예를 살펴 보겠습니다.
 

이것부터 시작하겠습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_NWrQewe" src="//codepen.io/anon/embed/preview/NWrQewe?height=450&amp;theme-id=1&amp;slug-hash=NWrQewe&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed NWrQewe" title="CodePen Embed NWrQewe" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

그 HTML에는 모든 종류의`data-` 속성이 있습니다.
 우리는 이미`data-scroll`과`data-scroll-container`를 살펴 보았습니다.
 나머지는 무엇이고 그들이하는 일은 다음과 같습니다.
 

- `data-scroll-section` : 스크롤 가능한 섹션을 정의합니다.
 더 나은 성능을 위해 페이지를 섹션으로 분할하는 것이 좋습니다.
 
- `data-scroll-direction` : 요소가 이동하는 수직 또는 수평 방향을 정의합니다.
 
- `data-scroll-speed` : 요소가 이동하는 속도를 지정합니다.
 음수 값은 방향을 반대로하지만 `data-scroll-direction`이 동일한 요소에 적용되지 않는 한 수직으로 만 적용됩니다.
 
- `data-scroll-sticky` : 대상 요소가 여전히 뷰에있는 한 뷰포트에 고정되는 요소를 지정합니다.
 
- `data-scroll-target` : 특정 요소를 타겟팅합니다.
 다른 속성에 비해 고유 한 ID 선택기를 사용합니다.
 

따라서`data-scroll-sticky` 속성을 사용한다고 가정 해 보겠습니다.
 대상 요소는 일반적으로 다른 요소를 보유하는 컨테이너이기 때문에 항상`data-scroll-target` 속성도 설정해야합니다.
 

```html
<div class="container" id="stick" data-scroll-section >
  <p data-scroll data-scroll-sticky data-scroll-target="#stick">
    Look at me, I'm going to stick when you scroll pass me.
  </p>
</div>
```

이제 하나를 따로 선택 했으므로 다음은 몇 가지입니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_WNGeONo" src="//codepen.io/anon/embed/preview/WNGeONo?height=450&amp;theme-id=1&amp;slug-hash=WNGeONo&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed WNGeONo" title="CodePen Embed WNGeONo" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_MWjgNmx" src="//codepen.io/anon/embed/preview/MWjgNmx?height=450&amp;theme-id=1&amp;slug-hash=MWjgNmx&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed MWjgNmx" title="CodePen Embed MWjgNmx" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

다른 프레임 워크에서도 LocoMotive-Scroll을 사용할 수 있습니다.
 다음은 React의 예입니다.
 

### 스크롤을 타고!
 

기관차 스크롤의 힘을 충분히 강조 할 수 없습니다.
 작업중인 사이드 프로젝트에 스크롤 효과를 추가해야했는데이 작업은 매우 빠르고 사용하기 쉽습니다.
 프로젝트에서 사용할 수 있고 스크롤 효과에 얼마나 좋은지 경험할 수 있기를 바랍니다.
 