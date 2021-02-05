---
layout: post
title: "페인트칠을 하다"
author: 'CSS Dev'
thumbnail: undefined
tags: 
---


CSS `그림판 순서` 속성은 채우기, 스트로크 및 사용 중인 마커를 포함하여 SVG 도형과 텍스트가 그려지는 순서를 설정합니다. 기본적으로 이러한 속성은 채우기, 스트로크 및 마커와 같은 순서로 그려집니다. 이 속성을 사용하면 이 속성을 전환할 수 있으므로 결과적으로 나타나는 모양을 보다 효과적으로 제어할 수 있습니다.

이 특성이 실제로 빛을 발하는 곳은 SVG 텍스트, 특히 충만과 스트로크가 모두 있는 <텍스트> 요소이다. 다음과 같은 경우:

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_wvGEMde" src="//codepen.io/anon/embed/wvGEMde?height=250&amp;theme-id=1&amp;slug-hash=wvGEMde&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed wvGEMde" title="CodePen Embed wvGEMde" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

아, 그 뇌졸중은 보기 흉하네요. 폭은 6px밖에 안 되는데, 속이 좀 가려지네요. 그 이유는 충만감이 먼저 그려지고, 기본적으로는 스트로크가 이어지기 때문입니다. 그러나 페인트 주문 속성을 사용하여 이를 뒤집으면 채우기 부분이 마지막으로 칠해지고 스트로크의 보기 흉한 부분을 덮게 된다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_NWNLxrg" src="//codepen.io/anon/embed/NWNLxrg?height=250&amp;theme-id=1&amp;slug-hash=NWNLxrg&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed NWNLxrg" title="CodePen Embed NWNLxrg" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

어머나, 그게 훨씬 낫네요! 우리는 실제로 본문을 읽을 수 있고 획은 예전보다 문자의 모양에 더 충실합니다.

### 구문

```css
paint-order: normal | [ fill || stroke || markers ]
```

- 초기값: `정상`
- 적용 대상: 도형 및 텍스트 내용 요소
- 상속됨: 예
- 애니메이션 유형: 이산형

### 가치

```css
/* Normal */
paint-order: normal;

/* Single values */
paint-order: stroke; /* same as: stroke fill markers */
paint-order: markers; /* same as: markers fill stroke */

/* Multiple values */
paint-order: stroke fill; /* same as: stroke fill markers */
paint-order: markers stroke fill;
```

한 가지 가치를 전달하는 것은 완전히 합법적이라는 것을 주목할 필요가 있다. 예를 들어, 다음과 같은 작업을 수행할 수 있습니다.

```css
paint-order: stroke;
```

…그러면 `스트로크`가 먼저 그려지고 그 다음에 다른 값이 기본 순서로 그려집니다. 이 예제는 이를 고려하여 다음과 같습니다.

이는 기본적으로 속성이 정상 값 또는 채우기, 스트로크, 마커의 조합 중 하나를 칠해야 하는 순서로 수용한다는 것을 의미한다.

```css
paint-order: stroke fill markers
```

그리고 값이나 유효하지 않은 값이 제공되지 않을 경우 어떻게 됩니까? 채우기, 스트로크, 마커의 기본 순서가 사용됩니다.

### 브라우저 지원

### 관련 속성

- 채우다
- 획
- 스트로크 폭

### 추가 읽기

- 확장 가능한 벡터 그래픽스(SVG) 레벨 2 사양(후보 추천)