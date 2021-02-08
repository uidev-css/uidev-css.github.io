---
layout: post
title: "그라데이션, CSS 모양 및 심지어 이모티콘을 사용한 창의적 배경 패턴"
author: "Uidev Css"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/06/surfer-pattern.jpg"
tags: BACKGROUND,GRADIENTS,PATTERNS
---


CSS에 스트라이프를 만들 수 있습니다. 오랫동안 CSS 배경 패턴에 대해 생각한 것은 그것뿐입니다. 줄무늬는 아무 문제가 없다. 줄무늬는 멋지다. 그들은 넓고 좁은 밴드로 커스터마이징될 수 있고, 체크 무늬로 십자형으로 교차될 수 있으며, 하드 스톱의 개념을 사용하여 다른 방법으로 플레이할 수 있다. 하지만 줄무늬도 지루할 수 있어요. 너무 인습적이고 유행에 뒤떨어지며 때로는 불쾌하기까지 하다.

고맙게도, 우리는 스트라이프와 비슷한 코드를 가진 CSS로 상상할 수 있는 것보다 훨씬 더 많은 배경 패턴을 생각해 낼 수 있다.

배경 패턴은 배경에 걸쳐 반복되는 이미지입니다. PNG 파일과 같은 외부 이미지를 참조하거나 CSS로 그릴 수 있으며, CSS 그라데이션으로 그릴 수 있다.

예를 들어, 선형 그레이디언트(및 반복 선형 그레이디언트)는 일반적으로 스트라이프에 사용됩니다. 하지만 멋진 배경 패턴을 만드는 다른 방법들이 있습니다. 어떻게 다른 방법으로 그레이디언트를 사용하고 CSS 모양이나 이모티콘과 같은 다른 방법으로 던져서 사물의 향을 돋우는지 봅시다.

### 그라데이션 패턴

CSS 그레이디언트에는 세 가지 유형이 있습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/06/G4UQFo_.png?fit=1024%2C328&ssl=1)

- 선형 그라데이션(): 색은 왼쪽에서 오른쪽으로, 위에서 아래로 또는 사용자가 선택한 각도에서 단일 방향으로 흐릅니다.
- 반지름 그라데이션() 색상은 한 지점에서 시작하여 바깥쪽으로 발산됩니다.
- 원뿔 그레이디언트()=원뿔 그레이디언트()의 개념은 방사형 그레이디언트와 비슷하지만 컬러 스톱은 중앙점에서 발산하지 않고 원 주위에 배치된다.

모든 그라데이션의 구문을 확인하여 그라데이션에서 색상을 시작하고 종료하는 방법을 완전히 이해할 것을 권장합니다.

먼저 반지름 구배를 살펴보죠. 왜냐하면 그것들은 우리에게 매우 유용한 것들을 주기 때문입니다. 원과 타원. 둘 다 매우 흥미로운 패턴에 사용될 수 있고 여러분을 위한 몇 가지 아이디어를 풀어줄 수 있습니다!

``` 
background: radial-gradient(<gradient values>)
```

이 기술을 사용하여 수박을 반복하는 패턴은 다음과 같습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 600px;"><iframe id="cp_embed_mdeKVeL" src="//codepen.io/anon/embed/mdeKVeL?height=600&amp;theme-id=1&amp;slug-hash=mdeKVeL&amp;default-tab=result" height="600" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed mdeKVeL" title="CodePen Embed mdeKVeL" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

```css
background: 
 radial-gradient(circle at 25px 9px, black 2px, transparent 2px), 
 radial-gradient(circle at 49px 28px, black 2px, transparent 2px), 
 radial-gradient(circle at 38px 1px, black 2px, transparent 2px), 
 radial-gradient(circle at 20px 4px, black 2px, transparent 2px), 
 radial-gradient(circle at 80px 4px, black 2px, transparent 2px), 
 radial-gradient(circle at 50px 10px, black 2px, transparent 2px), 
 radial-gradient(circle at 60px 16px, black 2px, transparent 2px), 
 radial-gradient(circle at 70px 16px, black 2px, transparent 2px), 
 radial-gradient(ellipse at 50px 0, red 33px, lime 33px, lime 38px, transparent 38px) 
 white;
background-size: 100px 50px;
```

먼저 요소에 배경 크기를 제공한 후 그 안에 그레이디언트를 쌓는다. 타원은 녹색과 빨간색 부분을 형성한다. 검은 원들이 수박씨를 나타내기 위해 흩어져 있다.

방사형 그라데이션 함수에 대한 처음 두 개의 파라미터는 그라데이션 모양이 원인지 타원인지와 그라데이션의 시작 위치를 결정합니다. 그 다음에는 그라데이션 내의 시작 위치와 끝 위치와 함께 그라데이션 색상 값이 나옵니다.

원뿔 모양의 구배는 광선과 같은 모양을 만듭니다. 선형 및 방사형 그라데이션과 마찬가지로 원뿔형 그라데이션은 기하학적 패턴을 만드는 데 사용될 수 있습니다.

```css
background: conic-gradient(<gradient values>)
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 600px;"><iframe id="cp_embed_BaoGPqo" src="//codepen.io/anon/embed/BaoGPqo?height=600&amp;theme-id=1&amp;slug-hash=BaoGPqo&amp;default-tab=result" height="600" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed BaoGPqo" title="CodePen Embed BaoGPqo" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

```css
background: 
  conic-gradient(yellow 40deg, blue 40deg, blue 45deg, transparent 45deg), 
  conic-gradient(transparent 135deg, blue 135deg, blue 140deg, transparent 140deg) ;
background-size: 60px 60px;
background-color: white;
```

원뿔 모양의 그라데이션이 있는 문제는 적어도 작성 당시에는 Firefox에서 지원되지 않는다는 것입니다. 더 깊은 지지를 받기 위해 항상 눈여겨볼 가치가 있다.

### 이모지 아이콘 패턴

여기서부터 일이 흥미로워지기 시작합니다. 그레이디언트처럼 기하학 패턴을 사용하기보다는 이제 이모티콘의 유기적인 모양을 사용하여 배경 패턴을 생성한다. 🎉

그것은 이모티콘으로 시작한다.

우리는 이모티콘에 투명한 컬러와 텍스트 섀도우를 부여하여 이모티콘을 만들 수 있습니다.

```css
color: transparent;
text-shadow: 0 0 black;
```

그런 다음 이러한 아이콘은 SVG를 사용하여 배경으로 사용할 수 있는 이미지로 바뀔 수 있습니다.

```html
<svg>
  <foreignObject>
    <!-- The HTML code with emoji -->
  </foreignObject>
</svg>
```

그런 다음 데이터 URL을 사용하여 SVG를 백그라운드 속성에 의해 참조할 수 있습니다.

```css
background: url("data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><!-- SVG code --></svg>");
```

그리고, voila! 우리는 이와 같은 것을 얻습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 600px;"><iframe id="cp_embed_bGVQjME" src="//codepen.io/anon/embed/bGVQjME?height=600&amp;theme-id=1&amp;slug-hash=bGVQjME&amp;default-tab=result" height="600" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed bGVQjME" title="CodePen Embed bGVQjME" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

```css
background: 
    url("data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><foreignObject width=%22100px%22 height=%22100px%22><div xmlns=%22http://www.w3.org/1999/xhtml%22 style=%22color:transparent;text-shadow: 0 0 %23e42100, -2px 2px 0 black;font-size:70px%22>🏄‍♀️</div></foreignObject></svg>"), 
    white; 
background-size: 60px 60px; 
```

이모지 말고도 CSS 도형을 그려 패턴으로 활용할 수도 있다. 하지만 이모티콘은 더 적은 작업이다. 그냥 하는 말이야.

일반 이모지 아이콘 대신 그라데이션 이모지 아이콘을 사용할 수 있습니다. 이렇게 하려면 이모티콘의 텍스트 그림자를 건너뜁니다. 뒤에 그라데이션 배경을 추가하고 배경 클립을 사용하여 그라데이션 배경을 이모티콘 모양으로 자른다.

```css
color: transparent;
background: linear-gradient(45deg, blue 20%, fuchsia);
background-clip: text; /* Safari requires -webkit prefix */
```

그런 다음 이전과 마찬가지로 SVG와 데이터 URL의 조합을 사용하여 배경 패턴을 생성합니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 600px;"><iframe id="cp_embed_WNQYKKx" src="//codepen.io/anon/embed/WNQYKKx?height=600&amp;theme-id=1&amp;slug-hash=WNQYKKx&amp;default-tab=result" height="600" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed WNQYKKx" title="CodePen Embed WNQYKKx" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이는 블록 색상의 이모티콘을 사용하는 것과 같습니다. 그러나 이번에는 텍스트 섀도우에 rgba() 또는 hsla() 값을 사용하여 색상의 불투명성을 제거한다.

```css
color: transparent;
text-shadow: 20px 10px rgba(0, 255, 0, .3), 
             0 0 red;
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 600px;"><iframe id="cp_embed_BaoGPOo" src="//codepen.io/anon/embed/BaoGPOo?height=600&amp;theme-id=1&amp;slug-hash=BaoGPOo&amp;default-tab=result" height="600" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed BaoGPOo" title="CodePen Embed BaoGPOo" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

우리는 이미 배경 패턴을 만들기 위해 제가 생각할 수 있는 모든 작업 방법을 살펴봤지만, 제가 시도한 이 다른 기술도 언급해야 할 것 같습니다. 제가 기대했던 것만큼 널리 지지받지 못하고 있습니다.

나는 `<foreign Object>를 사용하여 추가된 HTML 대신 SVG gtext 요소에 이모지를 배치해 보았다. 하지만 모든 브라우저에서는 그 뒤에 확실한 그림자를 만들 수 없었습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 600px;"><iframe id="cp_embed_JjYqqgV" src="//codepen.io/anon/embed/JjYqqgV?height=600&amp;theme-id=1&amp;slug-hash=JjYqqgV&amp;default-tab=result" height="600" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed JjYqqgV" title="CodePen Embed JjYqqgV" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

```css
background: 
  url("data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><text y=%221em%22 font-size=%2270%22 fill=%22transparent%22 style=%22text-shadow: 0 0 %23e42100, -2px 2px 5px black, 0 0 6px white; ;%22>🏄‍♀️</text></svg>")

```

혹시 모르니 그림자도 CSS 필터와 SVG 필터를 사용해 보았습니다. 그렇지 않았어요. 저는 또한 스트로크 속성을 사용해서 적어도 이모지에 대한 개요를 만들려 했지만, 그것 역시 효과가 없었습니다.

### CSS '요소()' 패턴

처음에 이모티콘이나 CSS 도형을 배경 이미지로 바꿀 생각을 했을 때는 SVG를 생각하지 못했어요. CSS 요소()를 시도했습니다. HTML 요소를 참조하고 사용할 수 있는 이미지로 직접 변환하는 기능입니다. 저는 이 접근 방식이 정말 마음에 들지만, 브라우저 지원은 매우 큰 주의 사항입니다. 이것이 제가 마지막에 언급하는 이유입니다.

기본적으로 다음과 같이 HTML에 요소를 삭제할 수 있습니다.

```html
<div id=snake >🐍</div>
```

…그리고 나서 이것을 다른 요소에 있는 이미지처럼 사용하기 위해 다음과 같이 `➡` 함수에 전달합니다.

```css
background: 
  -moz-element(#snake), /* Firefox only */
  linear-gradient(45deg, transparent 20px, blue 20px, blue 30px, transparent 30px) 
  white;
background-size: 60px 60px;
background-color: white; 

```

이 뱀 이모지는 기술적으로 우리가 패턴에 포함시킬 수 있는 이미지입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 600px;"><iframe id="cp_embed_ExVOpOR" src="//codepen.io/anon/embed/ExVOpOR?height=600&amp;theme-id=1&amp;slug-hash=ExVOpOR&amp;default-tab=result" height="600" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed ExVOpOR" title="CodePen Embed ExVOpOR" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

다시 말하지만, 브라우저 지원은 눈에 띄기 때문에 이 접근 방식은 매우 실험적이다.

이 방법에서 배경 패턴에 사용되는 원래의 이모티콘(또는 그 문제에 대한 CSS 모양)은 배경 패턴에도 나타나기 위해 화면에 렌더링해야 한다. 원래 이모지를 숨기기 위해 혼합 모드를 사용했습니다. 이 모드는 HTML에서 원래 이모지를 마스크하여 페이지에 표시되지 않도록 했습니다.

나는 당신이 이 게시물에 있는 방법들이 이런저런 방법으로 유용하고 그 과정에서 새로운 것을 배웠으면 좋겠어요! 한번 해보세요. 다른 이모티콘과 CSS 모양을 실험해 보세요. 그라데이션은 시원하지만 패턴을 만드는 유일한 방법은 아니기 때문입니다. 배경 속성은 여러 가지 가치를 가지고 있기 때문에 우리가 물건을 쌓을 수 있는 창의적인 방법을 생각할 수 있다.