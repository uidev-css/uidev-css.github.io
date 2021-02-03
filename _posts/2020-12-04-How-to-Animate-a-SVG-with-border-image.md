---
layout: post
title: "테두리 이미지로 SVG에 애니메이션을 적용하는 방법
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/11/animated-skull-border.png
tags: ANIMATING BORDER,BORDER-IMAGE,SVG ANIMATION
---


CSS의 `border-image`속성을 테두리를 따라 움직이는 애니메이션 SVG와 결합하는 방법을 살펴 보겠습니다.
 이 과정에서는 효과를 재현 할 수있을뿐만 아니라 직접 만들 수있는 크기 조정 가능한 9 슬라이스 애니메이션 SVG를 수작업으로 만드는 방법을 다룰 것입니다.
 

우리가 만드는 것은 다음과 같습니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/11/s_D483B2AEF87CCD242F70096AF2179E60F137F8E054938CBE114AA494BDA18708_1605525877582_high.gif?resize=1296%2C1272&ssl=1)

이것은 실제로 Arduino와 마이크로 컨트롤러의 내부를 탐구하기 위해 고안된 플래그 캡처 수수께끼 인 The Skull의 일부입니다.
 이와 같은 테두리 애니메이션 방법을 검색했지만 유용한 예를 찾지 못했습니다.
 내가 찾은 대부분의 물건은 행진하는 개미에 관한 것이지만, 불행히도 `스트로크-다샤 레이`트릭은 더 복잡한 모양은 말할 것도없고 두개골에서는 작동하지 않습니다.
 

그래서 학습과 공유의 정신으로 여기에서 여러분과 함께 블로그를 작성하고 있습니다!
 

## `background` 또는`border-image`를 사용해야합니까?
 

처음에는 `테두리 이미지`가 어떤 것인지도 몰랐습니다.
 첫 번째 시도에서`:: before` 의사 요소를 사용해 보았고`background-position` 속성에 애니메이션을 적용했습니다.
 그것은 나를 여기까지 얻었습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_zYBbGBV" src="//codepen.io/anon/embed/zYBbGBV?height=450&amp;theme-id=1&amp;slug-hash=zYBbGBV&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed zYBbGBV" title="CodePen Embed zYBbGBV" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

보시다시피 작동했지만 테두리를 완성하려면 최소한 8 개의 다른 요소 (또는 의사 요소)가 필요합니다.
 HTML을 그렇게 복잡하게 만드는 것은 이상적이지 않습니다.
 

이스라엘 CSS 개발자 페이스 북 그룹에 질문을 올렸는데 모두가 `border-image`속성에 대해 저를 지적했습니다.
 주석에 표시된대로 정확히 수행합니다. 요소의 테두리에 이미지 (또는 CSS 그래디언트)를 사용합니다.
 

`border-image`로 작업하려면 9 슬라이스 방식으로 사용되는 이미지를 제공해야합니다 (이미지 위에 tic-tac-toe 보드를 생각해보십시오).
 이러한 9 개 영역은 각각 테두리의 다른 부분을 나타냅니다. 위쪽, 오른쪽, 왼쪽 및 아래쪽, 각 네 모서리, 중간 (무시 됨)입니다.
 

예를 들어, 정적 두개골 만 원한다면 SVG 패턴을 활용하여 두개골을 9 번 반복 할 수 있습니다.
 먼저 두개골의 경로를 사용하여 24x24 패턴을 정의한 다음이 패턴을 72x72 직사각형의 `채우기`로 사용합니다.
 

```svg
<svg version="1.1" height="72" width="72" xmlns="http://www.w3.org/2000/svg">
 <defs>
  <pattern id="skull-fill" width="24" height="24" 
patternUnits="userSpaceOnUse">
    <path d="..." fill="red"/>
  </pattern>
 </defs>
 <rect fill="url(#skull-fill)" width="72" height="72" />
</svg>
```

![image](https://css-tricks.com/wp-content/uploads/2020/11/s_D483B2AEF87CCD242F70096AF2179E60F137F8E054938CBE114AA494BDA18708_1605529893979_skull-9.svg)

다음으로 테두리를 정의하고 대상 요소에 `border-image`를 설정합니다.
 

```css
.skulls {
  border: 24px solid transparent;
  border-image: url("https://skullctf.com/images/skull-9.svg") 24 round;
}
```

그리고 우리는 두개골로 만든 테두리를 얻습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 700px;"><iframe id="cp_embed_MWexpdX" src="//codepen.io/anon/embed/MWexpdX?height=700&amp;theme-id=1&amp;slug-hash=MWexpdX&amp;default-tab=result" height="700" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed MWexpdX" title="CodePen Embed MWexpdX" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### SVG 애니메이션 추가
 

이제 우리는 그 두개골을 애니메이션 할 수 있습니다!
 어, 대부분 작동합니다.
 

아이디어는 테두리 이미지의 각 영역에 대해 다른 애니메이션을 만드는 것입니다.
 예를 들어, 왼쪽 상단 모서리에는 오른쪽에서 왼쪽으로 이동하는 두개골 하나가 있고 두 번째 두개골은 동시에 위에서 아래로 이동합니다.
 

움직임에 대한`transform` 속성에 애니메이션을 적용합니다.
 또한 SVG의`<use>`를 활용하여 각 두개골에 대해 긴`<path>`정의를 반복하지 않도록합니다.
 

```svg
<svg version="1.1" height="96" width="96" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
 <style>
  @keyframes left {to {transform: translate(-32px, 0)}}
  @keyframes down {to {transform: translate(0, 32px)}}
 </style>
 <defs>
  <path id="skull" d="..." fill="red"/>
 </defs>

 <!-- Top-left corner: one skull goes left, another goes down -->
 <use href="#skull" x="0" y="0"  style="animation: down .4s infinite linear"/>
 <use href="#skull" x="32" y="0" style="animation: left .4s infinite linear"/>
</svg>
```

SVG 애니메이션 구문은 SMIL과 같은 일부 SVG 관련 구문이 아니라 CSS 애니메이션을 사용하기 때문에 익숙해 보일 수 있습니다.
 멋지죠?
 

이것이 우리가 얻는 것입니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/11/s_D483B2AEF87CCD242F70096AF2179E60F137F8E054938CBE114AA494BDA18708_1605530673459_skulls-top-left.gif?resize=328%2C284&ssl=1)

그리드를 추가하면이 애니메이션이 상단 및 왼쪽 가장자리도 어떻게 덮는 지 볼 수 있습니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/11/s_D483B2AEF87CCD242F70096AF2179E60F137F8E054938CBE114AA494BDA18708_1605531522585_skulls-top-left-grid.gif?resize=380%2C380&ssl=1)

나머지 세 개의 가장자리를 추가하면 더 인상적으로 보이기 시작하여 테두리 이미지의 8 개 영역을 모두 완전히 덮습니다.
 

```svg
<svg version="1.1" height="96" width="96" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
 <style>
  @keyframes left {to {transform: translate(-32px, 0)}}
  @keyframes down {to {transform: translate(0, 32px)}}
  @keyframes right {to {transform: translate(32px, 0)}}
  @keyframes up {to {transform: translate(0, -32px)}}
 </style>
 <defs>
  <path id="skull" d="..." fill="red"/>
 </defs>

 <!-- Top-left corner: one skull goes left, another goes down -->
 <use href="#skull" x="0" y="0"  style="animation: down .4s infinite linear"/>
 <use href="#skull" x="32" y="0" style="animation: left .4s infinite linear"/>

 <!-- Top-right corner: one skull goes up, another goes left -->
 <use href="#skull" x="64" y="0" style="animation: left .4s infinite linear"/>
 <use href="#skull" x="64" y="32" style="animation: up .4s infinite linear"/>

 <!-- Bottom-left corner: one skull goes down, another goes right -->
 <use href="#skull" x="0" y="32" style="animation: down .4s infinite linear"/>
 <use href="#skull" x="0" y="64" style="animation: right .4s infinite linear"/>

 <!-- Bottom-right corner: one skull goes right, another goes up -->
 <use href="#skull" x="32" y="64" style="animation: right .4s infinite linear"/>
 <use href="#skull" x="64" y="64" style="animation: up .4s infinite linear"/>
</svg>
```

그리고 이것은 우리에게 완전한 회로를 제공합니다.
 

![image](https://paper-attachments.dropbox.com/s_D483B2AEF87CCD242F70096AF2179E60F137F8E054938CBE114AA494BDA18708_1605532074421_skulls-circuit.gif)

모든 것을 종합하여 방금 만든 애니메이션 SVG를`테두리 이미지`로 사용하고 원하는 결과를 얻습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 700px;"><iframe id="cp_embed_oNLVWQY" src="//codepen.io/anon/embed/preview/oNLVWQY?height=700&amp;theme-id=1&amp;slug-hash=oNLVWQY&amp;default-tab=result" height="700" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed oNLVWQY" title="CodePen Embed oNLVWQY" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 하루 종일 이걸 가지고 놀 수 있어요 ...
 

이 작업을 수행 한 후 애니메이션 속성을 수정하기 시작했습니다.
 이것은 GIF 대신 SVG를 사용할 때의 장점 중 하나입니다. 애니메이션의 특성을 변경하는 것은 SVG 소스 파일에서 하나의 CSS 속성을 변경하는 것만 큼 쉬우 며, 더 작은 파일 크기는 말할 것도없고 결과를 즉시 확인할 수 있습니다 (
 특히 그라디언트를 다루는 경우), 풀 컬러 지원 및 선명한 스케일링.
 

우선, 애니메이션 타이밍 기능을 `ease`로 변경하면 어떻게되는지 알아 보려고했습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_WNGNEJg" src="//codepen.io/anon/embed/preview/WNGNEJg?height=450&amp;theme-id=1&amp;slug-hash=WNGNEJg&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed WNGNEJg" title="CodePen Embed WNGNEJg" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

두개골을 빨강과 녹색 사이에서 희미하게 만들 수도 있습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_eYdYGYm" src="//codepen.io/anon/embed/preview/eYdYGYm?height=450&amp;theme-id=1&amp;slug-hash=eYdYGYm&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed eYdYGYm" title="CodePen Embed eYdYGYm" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

고득점 테이블을 돌아 다닐 때 두개골의 방향을 변경할 수도 있습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_eYdYGVd" src="//codepen.io/anon/embed/preview/eYdYGVd?height=450&amp;theme-id=1&amp;slug-hash=eYdYGVd&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed eYdYGVd" title="CodePen Embed eYdYGVd" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

SVG 소스를 수정하고 직접 시도해볼 수있는 JavaScript 탭으로 이동합니다.
 

### 방에있는 거대한 🐘 (기침, Firefox)
 

이 작업을 처음 시작했을 때 매우 기뻤습니다.
 그러나주의해야 할 몇 가지주의 사항이 있습니다.
 무엇보다도 Firefox는 어떤 이유로 든 테두리 가장자리에서 애니메이션을 렌더링하지 않고 모서리에서만 렌더링합니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/11/s_D483B2AEF87CCD242F70096AF2179E60F137F8E054938CBE114AA494BDA18708_1605532956528_firefox.gif?resize=1220%2C1176&ssl=1)

재미있게도 SVG를 동일한 애니메이션의 GIF로 변경하면 완벽하게 작동했습니다.
 하지만 Chrome에서 가장자리 애니메이션이 중지됩니다!
 🤦‍♂️
 

어쨌든 브라우저 버그 인 것 같습니다.`border-image-repeat` 속성을`stretch`로 변경하면 Firefox가 가장자리에 애니메이션을 적용하지만 결과는 약간 기발합니다 (아마도
 페이지 테마) :
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/11/s_D483B2AEF87CCD242F70096AF2179E60F137F8E054938CBE114AA494BDA18708_1605533303818_skulls-firefox-stretch.gif?resize=1202%2C1176&ssl=1)

`border-image-repeat`값을 `space`로 변경하는 것도 작동하는 것처럼 보이지만 요소의 너비가 두개골 크기의 전체 배수가 아닌 경우에만 애니메이션에 약간의 간격이 생깁니다.
 

또한 컨테이너 크기가 패치 크기 (이 경우 32px)의 배수가 아닌 경우 두개골의 작은 검은 색 선과 같은 몇 가지 시각적 문제를 발견했습니다.
 나는 이것이 부동 소수점 반올림 문제와 관련이 있다고 생각합니다.
 또한 확대 할 때 깨지는 경향이 있습니다.
 

완벽하지는 않지만 확실히 끝났습니다!
 최종 버전이 실제로 작동하는 것을보고 싶다면 The Skull `s High Scores 페이지를 확인하십시오.
 조만간 귀하의 이름이 표시되기를 바랍니다.
 