---
layout: post
title: "함께 잘 어울리는 끈적 끈적한 풀 블리드 요소를 얻는 방법
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/12/sticky-full-bleed.png
tags: GRID,STICKY
---


요 전에 고유 한 요구 사항이있었습니다. 하나의 요소가 맨 위에 고정 된 상태로 풀 블리드 요소로 레이아웃을 구축하는 것입니다.
 이 작업을 수행하기가 다소 까다로워서 누군가이 동일한 효과를 재현해야 할 경우를 대비하여 여기에 문서화하고 있습니다.
 까다로운 부분은 작은 화면에서도 논리적 위치를 다루는 것이 었습니다.
 

효과를 설명하기 어렵 기 때문에 화면을 녹화하여 의미를 보여주었습니다.
 "오늘 Domino 사용해보기"헤더가있는 주요 클릭 유도 문안 섹션에 특히주의하십시오.
 


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video controls="" src="https://css-tricks.com/wp-content/uploads/2020/12/Screen-Cast-2020-11-08-at-11.58.06-AM.mp4" name="fitvid0"></video>
</div>


아이디어는 사용자가 더 큰 뷰포트에서 다른 섹션을 스크롤하면서 오른쪽에 주요 클릭 유도 문안을 표시하는 것입니다.
 더 작은 뷰포트에서 클릭 유도 문안 요소는 `평가판 시작`헤더가있는 메인 히어로 섹션 뒤에 표시되어야합니다.
 

여기에는 두 가지 주요 과제가 있습니다.
 

- 끈적 거리는 요소를 방해하지 않는 풀 블리드 요소 만들기
 
- HTML 복제 방지
 

몇 가지 가능한 솔루션 (및 그 한계)을 살펴보기 전에 먼저 의미 체계 HTML 구조를 설정해 보겠습니다.
 

### HTML
 

이러한 종류의 레이아웃을 구축 할 때 하나는 중복 클릭 유도 문안 섹션을 구축하려는 유혹을받을 수 있습니다. 하나는 데스크톱 버전 용이고 다른 하나는 모바일 버전 용이며 적절한 경우 가시성을 전환합니다.
 이렇게하면 HTML에서 완벽한 위치를 찾고 두 레이아웃 요구 사항을 모두 처리하는 CSS를 적용 할 필요가 없습니다.
 나는 때때로 그렇게하는 것에 대해 유죄임을 인정해야합니다.
 하지만 이번에는 HTML 복제를 피하고 싶었습니다.
 

고려해야 할 또 다른 사항은`.box--sticky` 요소에 고정 위치를 사용하고 있다는 것입니다. 즉, 제대로 작동하려면 풀 블리드 요소를 비롯한 다른 요소의 형제 여야합니다.
 

마크 업은 다음과 같습니다.
 

```html
<div class="grid">

  <div class="box box--hero">Hero Box</div>

  <div class="box box--sticky">Sticky Box</div>

  <div class="box box--bleed">Full-bleed Box</div>
  <div class="box box--bleed">Full-bleed Box</div>
  <!-- a bunch more of these -->

</div>
```

### 끈적 거리 자
 

CSS 그리드 레이아웃에서 고정 요소를 만드는 것은 매우 간단합니다.
 `.box--sticky` 요소에`top : 0` 오프셋을 사용하여`position : sticky`를 추가하여 고정 시작 위치를 나타냅니다.
 아, 그리고 768px보다 큰 뷰포트에서만 요소를 고정하고 있다는 점에 유의하십시오.
 

```css
@media screen and (min-width: 768px) {
  .box--sticky {
    position: sticky;
    top: 0;
  }
}
```

Safari를`overflow : auto`와 함께 사용할 때 고정 위치 지정과 관련된 알려진 문제가 있다는 점에 유의하세요.
 caniuse의 알려진 문제 섹션에 문서화되어 있습니다.
 

> 오버플로가`auto`로 설정된 부모는`position : sticky`가 Safari에서 작동하지 않도록합니다.
 

좋았어, 쉬웠 어.
 다음으로 풀 블리드 요소의 문제를 해결하겠습니다.
 

### 솔루션 1 : 의사 요소
 

첫 번째 해결책은 제가 자주 사용하는 것입니다 : 한 쪽에서 옆으로 뻗어있는 절대 위치의 의사 요소입니다.
 여기서 비결은 음수 오프셋을 사용하는 것입니다.
 

중앙 콘텐츠에 대해 이야기하는 경우 계산은 매우 간단합니다.
 

```css
.box--bleed {
  max-width: 600px;
  margin-right: auto;
  margin-left: auto;
  padding: 20px;
  position: relative; 
}

.box--bleed::before {
  content: "";
  background-color: dodgerblue; 
  position: absolute;
  top: 0;
  bottom: 0;
  right: calc((100vw - 100%) / -2);
  left: calc((100vw - 100%) / -2);
}
```

간단히 말해서, 음의 오프셋은 뷰포트의 너비 인 100vw에서 요소의 너비를 뺀 값인 100 %입니다. 두 개의 음의 오프셋이 필요하기 때문에 -2로 나눈 값입니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_abZPzoX" src="//codepen.io/anon/embed/abZPzoX?height=450&amp;theme-id=1&amp;slug-hash=abZPzoX&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed abZPzoX" title="CodePen Embed abZPzoX" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

100vw를 사용할 때 알려진 버그가 있으며 caniuse에서도 문서화되어 있습니다.
 

> 현재 Firefox를 제외한 모든 브라우저는 100vw를 세로 스크롤 막대를 포함하여 전체 페이지 너비로 잘못 간주하여 overflow : auto가 설정된 경우 가로 스크롤 막대가 발생할 수 있습니다.
 

이제 콘텐츠가 중앙에 있지 않을 때 풀 블리드 요소를 만들어 보겠습니다.
 동영상을 다시 보면 고정 요소 아래에 콘텐츠가 없음을 확인하세요.
 고정 요소가 콘텐츠와 겹치는 것을 원하지 않기 때문에이 특정 레이아웃에서 콘텐츠를 중앙에 배치하지 않았습니다.
 

먼저 그리드를 생성 할 것입니다.
 

```css
.grid {
  display: grid;
  grid-gap: var(--gap);
  grid-template-columns: var(--cols);
  max-width: var(--max-width);
  margin-left: auto;
  margin-right: auto;
}
```

속성을 다시 선언하지 않고도 최대 너비, 간격 및 그리드 열을 재정의 할 수있는 사용자 지정 속성을 사용하고 있습니다.
 즉,`grid-gap`,`grid-template-columns` 및`max-width` 속성을 다시 선언하는 대신 변수 값을 다시 선언합니다.
 

```css
:root {
  --gap: 20px;
  --cols: 1fr;
  --max-width: calc(100% - 2 * var(--gap));
}

@media screen and (min-width: 768px) {
  :root {
    --max-width: 600px;
    --aside-width: 200px;
    --cols: 1fr var(--aside-width);
  }
}

@media screen and (min-width: 980px) {
  :root {
    --max-width: 900px;
    --aside-width: 300px;
  }
}
```

너비가 768px 이상인 뷰포트에서 두 개의 열을 정의했습니다. 하나는 고정 너비 인`--aside-width`이고 다른 하나는 나머지 공간을 채우는 1fr 및 그리드 컨테이너의 최대 너비입니다.
 `-최대 너비`.
 

768px보다 작은 뷰포트에서는 단일 열과 간격을 정의했습니다.
 그리드 컨테이너의 최대 너비는 뷰포트의 100 %에서 각면의 간격을 뺀 것입니다.
 

이제 재미있는 부분이 있습니다.
 콘텐츠가 더 큰 뷰포트의 중앙에 있지 않으므로 계산이 생각만큼 간단하지 않습니다.
 모양은 다음과 같습니다.
 

```css
.box--bleed {
  position: relative;
  z-index: 0;
}

.box--bleed::before {
  content: "";
  display: block;
  position: absolute;
  top: 0;
  bottom: 0;
  left: calc((100vw - (100% + var(--gap) + var(--aside-width))) / -2);
  right: calc(((100vw - (100% - var(--gap) + var(--aside-width))) / -2) - (var(--aside-width)));
  z-index: -1;
}
```

부모 너비의 100 %를 사용하는 대신 간격 및 고정 요소의 너비를 고려합니다.
 즉, 풀 블리드 요소의 콘텐츠 너비가 히어로 요소의 경계를 초과하지 않습니다.
 이렇게하면 고정 요소가 중요한 정보와 겹치지 않도록합니다.
 

왼쪽 오프셋은 뷰포트 너비 (100vw)에서 요소의 너비 (100 %), 간격 (`--gap`) 및 고정 요소 (`--aside-width`) 만 빼면되기 때문에 더 간단합니다.
 ).
 

```css
left: (100vw - (100% + var(--gap) + var(--aside-width))) / -2);
```

오른쪽 오프셋은 이전 계산 인`--aside-width`와 간격`--gap`에 고정 요소의 너비를 추가해야하기 때문에 더 복잡합니다.
 

```css
right: ((100vw - (100% + var(--gap) + var(--aside-width))) / -2) - (var(--aside-width) + var(--gap));
```

이제 고정 요소가 풀 블리드 요소의 콘텐츠와 겹치지 않는다는 것을 확인했습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_KKMbqrm" src="//codepen.io/anon/embed/KKMbqrm?height=450&amp;theme-id=1&amp;slug-hash=KKMbqrm&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed KKMbqrm" title="CodePen Embed KKMbqrm" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

다음은 수평 적 버그가있는 솔루션입니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_vYKjEyb" src="//codepen.io/anon/embed/vYKjEyb?height=450&amp;theme-id=1&amp;slug-hash=vYKjEyb&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed vYKjEyb" title="CodePen Embed vYKjEyb" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

수평 적 버그 수정이있는 솔루션은 다음과 같습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_mdELEPp" src="//codepen.io/anon/embed/mdELEPp?height=450&amp;theme-id=1&amp;slug-hash=mdELEPp&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed mdELEPp" title="CodePen Embed mdELEPp" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

수정 사항은 본문의 x 축에 오버플로를 숨기는 것입니다. 어쨌든 일반적으로 좋은 생각 일 수 있습니다.
 

```css
body {
  max-width: 100%;
  overflow-x: hidden;
}
```

이것은 완벽하게 실행 가능한 솔루션이며 여기서 끝낼 수 있습니다.
 하지만 그게 어떤 재미일까요?
 일반적으로 무언가를 달성하는 방법은 여러 가지가 있으므로 다른 접근 방식을 살펴 보겠습니다.
 

### 솔루션 2 : 패딩 계산
 

중앙 그리드 컨테이너와 의사 요소를 사용하는 대신 그리드를 구성하여 동일한 효과를 얻을 수 있습니다.
 지난번에했던 것처럼 그리드를 정의하는 것으로 시작하겠습니다.
 

```css
.grid {
  display: grid;
  grid-gap: var(--gap);
  grid-template-columns: var(--cols);
}
```

다시, 사용자 지정 속성을 사용하여 간격과 템플릿 열을 정의합니다.
 

```css
:root {
  --gap: 20px;
  --gutter: 1px;
  --cols: var(--gutter) 1fr var(--gutter);
}
```

768px보다 작은 뷰포트에 세 개의 열이 표시됩니다.
 중앙 기둥은 가능한 한 많은 공간을 차지하고 다른 두 기둥은 수평 간격을 강제하는 데만 사용됩니다.
 

```css
@media screen and (max-width: 767px) {
  .box {
    grid-column: 2 / -2;
  }
}
```

모든 그리드 요소는 중앙 기둥에 배치됩니다.
 

768px보다 큰 뷰포트에서는 내부 열의 너비를 제한하는`--max-width` 변수를 정의합니다.
 또한 고정 요소의 너비 인`--aside-width`를 정의합니다.
 다시 말하지만 이렇게하면 고정 요소가 풀 블리드 요소 내부의 콘텐츠 위에 배치되지 않습니다.
 

```css
:root {
  --gap: 20px;
}

@media screen and (min-width: 768px) {
  :root {
    --max-width: 600px;
    --aside-width: 200px;
    --gutter: calc((100% - (var(--max-width))) / 2 - var(--gap));
    --cols: var(--gutter) 1fr var(--aside-width) var(--gutter);
  }
}

@media screen and (min-width: 980px) {
  :root {
    --max-width: 900px;
    --aside-width: 300px;
  }
}
```

다음으로 거터 너비를 계산합니다.
 계산은 다음과 같습니다.
 

```css
--gutter: calc((100% - (var(--max-width))) / 2 - var(--gap));
```

… 여기서 100 %는 뷰포트 너비입니다.
 먼저 뷰포트의 너비에서 내부 열의 최대 너비를 뺍니다.
 그런 다음 그 결과를 2로 나누어 거터를 만듭니다.
 마지막으로 격자의 간격을 빼서 거터 기둥의 정확한 너비를 얻습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_VwjRbMK" src="//codepen.io/anon/embed/VwjRbMK?height=450&amp;theme-id=1&amp;slug-hash=VwjRbMK&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed VwjRbMK" title="CodePen Embed VwjRbMK" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이제`.box--hero` 요소를 위로 밀어 그리드의 첫 번째 내부 열에서 시작합니다.
 

```css
@media screen and (min-width: 768px) {
  .box--hero {
    grid-column-start: 2;
  }
}
```

그러면 자동으로 스티커 상자가 밀려 영웅 요소 바로 뒤에서 시작됩니다.
 다음과 같이 고정 상자의 위치를 명시 적으로 정의 할 수도 있습니다.
 

```css
.box--sticky {
  grid-column: 3 / span 1;
}
```

마지막으로`grid-column`을`1 / -1`로 설정하여 풀 블리드 요소를 만들어 보겠습니다.
 이는 요소가 첫 번째 그리드 항목에서 콘텐츠를 시작하고 마지막 항목까지 확장하도록 지시합니다.
 

```css
@media screen and (min-width: 768px) {  
  .box--bleed {
    grid-column: 1 / -1;
  }
}
```

콘텐츠를 중앙에 배치하기 위해 왼쪽 및 오른쪽 패딩을 계산합니다.
 왼쪽 패딩은 거터 기둥의 크기에 그리드 간격을 더한 것과 같습니다.
 오른쪽 패딩은 왼쪽 패딩의 크기와 다른 격자 간격 및 고정 요소의 너비와 같습니다.
 

```css
@media screen and (min-width: 768px) {
  .box--bleed {  
    padding-left: calc(var(--gutter) + var(--gap));
    padding-right: calc(var(--gutter) + var(--gap) + var(--gap) + var(--aside-width));
  }
}
```

최종 해결책은 다음과 같습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_dyXePPj" src="//codepen.io/anon/embed/dyXePPj?height=450&amp;theme-id=1&amp;slug-hash=dyXePPj&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed dyXePPj" title="CodePen Embed dyXePPj" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

버그가있는 뷰포트 유닛을 사용하지 않기 때문에 첫 번째 솔루션보다이 솔루션을 선호합니다.
 

저는 CSS 계산을 좋아합니다.
 특히 100 %와 같이 다른 단위를 결합 할 때 수학적 연산을 사용하는 것이 항상 간단한 것은 아닙니다.
 100 %가 의미하는 바를 파악하는 것은 노력의 절반입니다.
 

저는 또한 CSS 만 사용하여 간단하지만 복잡한 레이아웃을 해결하는 것을 좋아합니다.
 최신 CSS에는 복잡하고 다소 무거운 JavaScript 솔루션을 제거하는 그리드, 고정 위치 지정 및 계산과 같은 기본 솔루션이 있습니다.
 더러운 일은 브라우저에 맡기자!
 

이에 대한 더 나은 솔루션이나 다른 접근 방식이 있습니까?
 나는 그것에 대해 듣고 기쁠 것입니다.
 