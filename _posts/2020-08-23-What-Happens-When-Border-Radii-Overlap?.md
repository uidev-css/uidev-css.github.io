---
layout: post
title: "경계선이 겹치면 어떻게 됩니까?"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/07/border-radius-overlap.jpg
tags: BORDER-RADIUS
---


나는 우리가 CSS에서 박스 모서리를 반올림할 때, 우리는 테두리에 균일한 테두리 반지름 값을 적용한다고 장담한다. 여러 가지 디자인으로 된 멋진 광택감이에요. 하지만 코너마다 다른 반지름을 원할 때가 있습니다. 쉽죠? 이렇게 하면 속성이 네 가지 값을 갖습니다. 글쎄요, 밝혀진 바와 같이, 둥근 테두리가 서로 겹칠 수 있기 때문에 우리 자신을 구석에 그리는 것은 실제로 가능합니다.

우리들 중 많은 사람들은 "알약 모양의" 직사각형을 얻기 위한 일반적인 "999em 해킹"을 알고 있다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 200px;"><iframe id="cp_embed_qBbYjQM" src="//codepen.io/anon/embed/qBbYjQM?height=200&amp;theme-id=1&amp;slug-hash=qBbYjQM&amp;default-tab=result" height="200" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed qBbYjQM" title="CodePen Embed qBbYjQM" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

우리는 국경 반지름을 999em이나 999vmax와 같이 터무니없이 큰 수로 설정했고, 어떤 식으로든 불가능한 Escher-esque möbius 스트립이 되는 대신 모서리가 반원형으로 잘 둥글게 되어 있다. 이것은 우리가 이 효과를 얻기 위해 사각형의 치수를 알 필요가 없다는 것을 의미하기 때문에 편리합니다. 그것은 "그냥 효과가 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_jOWgrEe" src="//codepen.io/anon/embed/jOWgrEe?height=450&amp;theme-id=1&amp;slug-hash=jOWgrEe&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed jOWgrEe" title="CodePen Embed jOWgrEe" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이 트릭의 기원은 나에게 불분명하지만, 나는 Lea Verou의 블로그에서 데이비드 바론의 초기 사례를 발견했다.

하지만, 많은 "해크"와 마찬가지로, 우리는 특정한 가장자리에 있는 경우에서 이상한 행동을 만날 수 있습니다. 예를 들어, 다음과 같이 작동하지 않는 이유는 무엇입니까?

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 200px;"><iframe id="cp_embed_PoZejXo" src="//codepen.io/anon/embed/PoZejXo?height=200&amp;theme-id=1&amp;slug-hash=PoZejXo&amp;default-tab=css,result" height="200" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed PoZejXo" title="CodePen Embed PoZejXo" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

우리는 직사각형의 오른쪽이 "알약 모양"이고 왼쪽이 40px로 둥근 모서리를 가지길 원합니다. 하지만 우리의 40px 코너는 사라졌어! 그들은 어디로 갔을까?

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/07/overlapping-border-radius.png?resize=688%2C245&ssl=1)

정답은 그들이 어디에도 가지 않았다는 것입니다. 브라우저는 그들의 가치를 0에 가깝게 낮추었기 때문에 그들은 단지 사라진 것처럼 보일 뿐입니다.

브라우저가 우리가 요청한 값과 다소 차이가 나는데, 언제 어떻게 개입하기로 결정하나요? 사양을 확인해 보겠습니다.

> f = min(Li/Si)으로 하자. 여기서 i는 {top, 오른쪽, 아래쪽, 왼쪽, Si는 side i의 모서리의 해당 반지름 2개의 합이며, Ltop = Lbottom = 상자의 너비 및 Lleft = Lright = 박스 높이입니다. f < 1이면 모든 모서리 반경은 f를 곱하여 감소한다.

아, 설명이 되네요! 남은 한 주 잘 보내세요! : 결정적으로 손:

…물론 농담입니다. 약간의 해독이 필요합니다. 수학적으로나 기하학적으로나 두 가지 방법으로 살펴보죠. 이 공식의 목적은 반지름이 겹치지 않도록 하는 것이라는 점을 항상 염두에 두십시오. 사실, 이것이 "999em 해킹"이 처음부터 효과가 있는 이유입니다!

내 말은 이렇다.

간단한 영어에서 브라우저는 기본적으로 다음과 같이 생각합니다. "모든 반지름을 비례적으로 축소하여 겹치지 않도록 하십시오." (반경이 겹치면 안 됩니다. 원은 실제로 겹칠 수 있습니다.

하지만 컴퓨터는 영어를 이해하지 못합니다. 그래서 공식이 하는 것은 이것입니다.

먼저, 직사각형의 각 면에 있는 길이와 거기에 닿는 반지름의 합의 비율을 계산합니다. 따라서 NAT의 표준 "pill hack"에서는 다음과 같은 이점을 제공합니다.

```
[Width of Side] / [Adjacent Border Radius 1 + Adjacent Border Radius 2]
Top: 200px / (400px + 400px) = 0.25
Right: 100px / (400px + 400px) = 0.125
Bottom: 200px / (400px + 400px) = 0.25
Left: 100px / (400px + 400px) = 0.125
```

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/07/overlapping-border-radius-ratios.png?resize=1024%2C223&ssl=1)

그런 다음 모든 반경을 이 비율 중에서 가장 작은 비율로 곱합니다. 가장 작은 비율은 0.125입니다. 초기 400px 반경을 곱해 보겠습니다.

```
400px * 0.125 = 50px
```

그러면 모든 라디오가 50px로 남습니다. 가장 짧은 면이 100px인 직사각형의 경우, 이것은 우리에게 완벽한 알약 모양을 제공합니다. 좋아요! 다음 애니메이션을 보세요.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 950px;"><iframe id="cp_embed_rNxvwXJ" src="//codepen.io/anon/embed/rNxvwXJ?height=950&amp;theme-id=1&amp;slug-hash=rNxvwXJ&amp;default-tab=result" height="950" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed rNxvwXJ" title="CodePen Embed rNxvwXJ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

(더 쉽게 볼 수 있도록 999em이 아닌 "엄청나게 큰" 반지름에 400px를 사용하고 있습니다. 직사각형의 가장 짧은 면의 절반 길이인 한 겹칠 것입니다.)

지정한 반지름을 나타내는 원은 요청된 크기에서 시작한 다음 위의 공식에 의해 지정된 비율에 따라 축소됩니다. 주목해야 할 것은 그것들이 모두 같은 비율로 줄어든다는 것이다. 어차피 같은 크기로 시작하니까 더 직관적일 수 있어요.

이제 모든 것을 시작했던 "깨진" 예시로 돌아가 보겠습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 200px;"><iframe id="cp_embed_PoZejXo" src="//codepen.io/anon/embed/PoZejXo?height=200&amp;theme-id=1&amp;slug-hash=PoZejXo&amp;default-tab=result" height="200" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed PoZejXo" title="CodePen Embed PoZejXo" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이게 무슨 일이야? 이러한 축소로 인해 영향을 받지만 사실상 사라지지 않는 경계선을 보여 주는 덜 극단적인 예를 들어 보겠습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_WNrJExj" src="//codepen.io/anon/embed/WNrJExj?height=250&amp;theme-id=1&amp;slug-hash=WNrJExj&amp;default-tab=css,result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed WNrJExj" title="CodePen Embed WNrJExj" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

왼쪽 상단과 왼쪽 하단 모서리에서 우리가 요구하는 40px 반경은 얻지 못하고 있는 것을 볼 수 있습니다. 하지만 우리는 뭔가를 얻고 있습니다. 이 공식을 다시 살펴보고, 먼저 모든 안경다리와 인접 반지름 사이의 비율을 알아봅시다.

```
Top: 200px / (40px + 400px) = 0.455
Right: 100px / (400px + 400px) = 0.125
Bottom: 200px / (40px + 400px) = 0.455
Left: 100px / (40px + 40px) = 1.25
```

다시, 우리의 가장 낮은 비율은 0.125입니다. 그래서 우리는 지정된 모든 반경을 그 양으로 곱합니다. 오른쪽 모서리는 50px 반지름이고 왼쪽 모서리는 5px 반지름을 줍니다.

여기서 공식이 보장하는 것은 직사각형의 오른쪽에 있는 두 개의 큰 반경이 겹치지 않는다는 것입니다. 그러나 그렇게 함으로써 사각형 왼쪽의 작은 반경이 위쪽, 아래쪽, 왼쪽의 반경이 겹치는 것을 막기 위해 "필요한" 것보다 더 많이 줄어들었습니다.

여기 다양한 상황에서 일어나는 일을 보여주는 더 풍부한 예가 있습니다. 어떤 일이 일어나는지 보기 위해 몇 가지 값을 가지고 놀아라. 또한 큰 크기는 코드에서 지정한 반지름이고 작은 크기는 브라우저가 겹치지 않도록 조정한 방법입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 750px;"><iframe id="cp_embed_WNrXLoL" src="//codepen.io/anon/embed/WNrXLoL?height=750&amp;theme-id=1&amp;slug-hash=WNrXLoL&amp;default-tab=result" height="750" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed WNrXLoL" title="CodePen Embed WNrXLoL" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

왜 오즈 같은 투기꾼들이 이런 식으로 일을 하기로 결정했을까요? 처음부터 모든 반경을 축소하지 말고 먼저 큰 경계선을 축소하는 것이 어떻겠습니까?

물론 그들의 마음을 읽을 수는 없지만, 이 접근법의 이점은 방사선이 서로 비율을 유지한다는 것입니다. 브라우저에 겹침이 없을 때까지 또는 두 번째로 큰 반지름과 같을 때까지 최대 반지름을 줄이도록 지시했다면, 우리의 "하이브리드 알약 해킹"은 효과가 있었을 것입니다. 그러나 사용자가 매우 다른 크기를 요구했을 때 4개의 동일한 반지름을 가질 수 있는 경우도 있습니다. 즉, 구현이 어떻게 해서든 숫자에 `불성실`해야 하고, 이것이 그들이 선택한 방식(지혜적으로, 나는 생각한다)이라는 것이다.

"사라지는 라디오" 문제를 처음 알게 된 제 동료 캐서린과 제가 스펙을 이해하도록 도와주신 제임스에게 감사드립니다!