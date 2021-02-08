---
layout: post
title: "복잡한 CSS 그림을 위한 조언"
author: "Uidev Css"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/06/jigglypuff.png"
tags: ART,CSS SHAPES
---


프런트 엔드 개발에 대해 가장 많이 듣는 질문이 있다면 바로 그 질문입니다."어떻게 하면 CSS를 더 잘 할 수 있을까요?" 그 질문은 제가 만든 CSS 일러스트를 공유한 후에 나오는 질문입니다. 코드펜에서 다시 하고 싶은 거야

많은 사람들에게 CSS는 길들일 수 없는 신화 속의 짐승이다. 크리스가 보낸 이 트윗은 저를 웃게 만들었습니다. 아이러니하지만, 많은 진실이 있기 때문입니다. 그렇긴 하지만, 만약 여러분이 원하는 것을 창조하는 데 단지 몇 가지 특성이나 기술만 있다면 어떨까요? 진실은 당신이 정말로 그만큼 가깝다는 것입니다.

한동안 이런 기사를 쓰고 싶었지만, 너무 많은 가능성과 기법이 너무 많아 같은 일을 해내는 방법이 한두 가지가 아닌 경우가 많아 취재하기 어려운 주제다. CSS 삽화에서도 마찬가지다. 그것을 하는 옳고 그른 방법은 없다. 우리는 모두 같은 캔버스를 사용하고 있습니다. 페이지의 픽셀을 얻기 위한 많은 다양한 도구들이 있을 뿐입니다.

CSS 일러스트레이션에 대한 "하나의 크기만 적합" 접근 방식은 없지만, 제가 제공할 수 있는 것은 여러분의 여정에 도움이 될 수 있는 일련의 기술들입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 500px;"><iframe id="cp_embed_mLaXRe" src="//codepen.io/anon/embed/mLaXRe?height=500&amp;theme-id=1&amp;slug-hash=mLaXRe&amp;default-tab=result" height="500" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed mLaXRe" title="CodePen Embed mLaXRe" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 시간과 연습

CSS 삽화는 많은 시간과 연습이 필요하다. 더 정확하고 복잡한 삽화일수록 시간이 더 오래 걸릴 것입니다. 시간이 많이 걸리는 부분은 보통 어떤 속성을 사용할지 어떻게 사용할지를 결정하는 것이 아니라, 어떤 것을 올바르게 보이게 하는지를 결정하는 것입니다. 브라우저 개발 도구의 스타일 검사기에 익숙해질 준비를 하세요! 저는 VisBug를 사용해 보지 않으셨다면 추천합니다.

두 명의 환상적인 CSS 아티스트는 벤 에반스와 다이애나 스미스이다. 두 사람 모두 최근 CSS 일러스트를 언급하며 시간소비에 대해 언급한 바 있다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/06/image-16.png?resize=2050%2C1902&ssl=1)

나는 컵에 관한 밈 같은 사진을 올렸고 벤의 반응은 완벽하게 요약되었다.

> 처음에 트윗을 보고 CSS로 만들고 싶었는데 답장이 한 달 정도 걸릴 것 같아서요.

시간이 걸려요!

### 추적은 완벽하게 허용된다.

우리는 종종 우리가 설명하고 싶은 것이 무엇인지에 대한 생각을 한다. 이 기사는 결국 디자인에 관한 것이 아니다.DOM과 CSS로 이미지를 만들어 렌더링하는 것입니다. 나는 이 기술이 태초부터 존재해 왔다고 확신한다. 하지만, 지난 몇 달 동안 공유해 온 것입니다.

- 설명하려는 항목의 이미지를 찾거나 만듭니다.
- `img` 태그를 사용하여 HTML로 끌어옵니다.
- 그림 아래에 배치할 수 있도록 배치합니다.
- 너무 과하게 보이지 않도록 영상 불투명도를 줄입니다.
- DOM으로 추적합니다.

놀랍게도, 이 기술은 일반적인 지식이 아닙니다. 하지만 이것은 정확한 CSS 삽화를 만드는 데 매우 중요합니다.

여기서 이 트릭을 확인하십시오.

여기서 시도해 보세요.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_OJMNVZR" src="//codepen.io/anon/embed/OJMNVZR?height=450&amp;theme-id=1&amp;slug-hash=OJMNVZR&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed OJMNVZR" title="CodePen Embed OJMNVZR" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 대응력에 유의하십시오.

이 글에서 취할 두 가지 테이크 어웨이 기법이 있다면 위의 "추적" 기법과 다음 기법으로 하자.

CSS 일러스트레이션의 몇 가지 환상적인 예가 있습니다. 하지만 그것들 중 일부는 작은 스크린에서 스타일링하거나 심지어 볼 수 없다는 것이 한 가지 아쉬운 점이죠. 우리는 기술에 대한 첫인상이 중요한 시대에 살고 있다. CSS로 표시된 키보드의 예를 생각해 보자. 누군가가 여러분의 작품을 우연히 발견하고, 스마트폰으로 열어보면, 그들은 단지 절반의 삽화나 작은 부분만을 받게 됩니다. 그들은 아마도 데모의 가장 멋진 부분을 놓쳤을 것이다!

다음은 그림에서 뷰포트 유닛을 활용하고 스케일링 유닛을 직접 만드는 요령입니다.

크기 조정 및 배치를 위해 축소된 단위 또는 백분율을 사용할 수 있습니다. 이 기능은 속성이 보기 포트 단위를 허용하지만 백분율은 허용하지 않으므로 상자 그림자를 사용해야 할 때 특히 유용합니다.

위에서 만든 CSS egghead.io 로고를 생각해 보세요. 사용하고자 하는 이미지를 찾아서 img 태그로 DOM에 터뜨렸습니다.

```html
<image src='egghead.png'/>
```

```css
img {
  height: 50vmin;
  left: 50%;
  opacity: 0.25;
  position: fixed;
  top: 50%;
  transform: translate(-50%, -50%);
}
```

높이 50 vmin은 CSS 일러스트레이션의 원하는 크기이다. 불투명도가 감소하면 진행하면서 그림을 "추적"할 수 있습니다.

그런 다음 스케일링 유닛을 만듭니다.

```css
/**
  * image dimensions are 742 x 769
  * width is 742
  * height is 769
  * my desired size is 50vmin
*/
:root {
  --size: 50;
  --unit: calc((var(--size) / 769) * 1vmin);
}
```

이미지 치수가 갖추어지면, 우리는 우리의 이미지와 함께 확장될 통일된 단위를 만들 수 있습니다. 우리는 높이가 가장 큰 단위라는 것을 알고 있습니다. 그래서 우리는 그것을 분수 단위를 만들기 위해 베이스로 사용합니다.

우리는 이와 같은 것을 얻습니다.

```css
--unit: 0.06501950585vmin;
```

어색해 보이긴 하지만, 날 믿어, 괜찮아. 이것을 사용하여 `calc()를 사용하여 그림의 용기 크기를 조정할 수 있다.

```css
.egg {
  height: calc(769 * var(--unit));
  position: relative;
  width: calc(742 * var(--unit));
  z-index: 2;
}
```

만약 우리가 CSS 일러스트레이션의 컨테이너 안에 요소들을 스타일링하기 위해 백분율이나 새로운 "-unit" 사용자 지정 속성을 사용한다면, 우리는 반응하는 CSS 일러스트를 얻을 수 있을 것이다. 그리고 그것은 CSS 변수를 이용한 수학의 몇 줄 뿐이었다.

이 데모의 크기를 조정하면 50Vmin을 항상 크기 조정 제약 조건으로 사용하여 모든 것이 비례합니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_rNOzYJZ" src="//codepen.io/anon/embed/rNOzYJZ?height=450&amp;theme-id=1&amp;slug-hash=rNOzYJZ&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed rNOzYJZ" title="CodePen Embed rNOzYJZ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 두 번 재어 한 번 자른다.

또 다른 팁은 물건을 측정하는 것입니다. 물리적 물체를 다룰 때는 줄자를 잡기도 해!

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_BaNGKPw" src="//codepen.io/anon/embed/BaNGKPw?height=450&amp;theme-id=1&amp;slug-hash=BaNGKPw&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed BaNGKPw" title="CodePen Embed BaNGKPw" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

약간 웃기게 보일 수도 있지만 제가 이 장면을 재봤습니다. 내 라운지에 있는 TV 콤보 장치야. 그 측정값은 센티미터와 같다. 나는 TV의 실제 높이를 기준으로 반응하는 유닛을 얻기 위해 그것들을 사용했어요. 사용자 지정 속성 덕분에 이름을 쉽게 기억할 수 있습니다.

```css
:root {
  --light-switch: 15;
  --light-switch-border: 10;
  --light-switch-top: 15;
  --light-switch-bottom: 25;
  --tv-bezel: 15;
  --tv-unit-bezel: 4;
  --desired-height: 25vmin;
  --one-cm: calc(var(--desired-height) / var(--tv-height));
  --tv-width: 158.1;
  --tv-height: 89.4;
  --unit-height: 42;
  --unit-width: 180;
  --unit-top: 78.7;
  --tv-bottom: 114.3;
  --scaled-tv-width: calc(var(--tv-width) * var(--one-cm));
  --scaled-tv-height: calc(var(--tv-height) * var(--one-cm));
  --scaled-unit-width: calc(var(--unit-width) * var(--one-cm));
  --scaled-unit-height: calc(var(--unit-height) * var(--one-cm));
}
```

변수를 계산하기만 하면 어디에서나 사용할 수 있습니다. 내 TV는 가로 158.1cm, 세로 89.4cm로 알고 있어. 설명서를 확인했어요. 하지만 CSS 그림에서는 항상 25Vmin로 확장됩니다.

### 모든 것에 절대적인 위치를 지정하세요.

이렇게 하면 키 입력을 몇 번 줄일 수 있습니다. 종종 요소들의 위치를 확실히 정하려고 할 것입니다. 몸을 아끼고 이 규칙을 어디다 두어라.

```css
/* Your class name may vary */
.css-illustration *,
.css-illustration *:after,
.css-illustration *:before,
.css-illustration:after,
.css-illustration:before {
  box-sizing: border-box;
  position: absolute;
}
```

키보드가 고마워할 거야!

포지셔닝은 CSS에서 까다로운 개념입니다. 사용 방법에 대한 자세한 내용은 CSS Almanac에서 확인할 수 있습니다.

또는 이 작은 포지셔닝 운동장과 함께 플레이할 수 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_pogyJbw" src="//codepen.io/anon/embed/pogyJbw?height=450&amp;theme-id=1&amp;slug-hash=pogyJbw&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed pogyJbw" title="CodePen Embed pogyJbw" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 접근 방식을 고수하라.

이것은 단연코 가장 하기 힘든 일이다. CSS 일러스트레이션에 어떻게 접근합니까? 어디서부터 시작하는 거야? 가장 바깥쪽 부분부터 시작해서 안으로 들어갈까요? 그건 별로 효과가 없어요.

아마도 당신은 몇 가지 방법을 시도해보고 더 나은 방법을 찾을 것이다. 여러분은 분명 앞뒤로 조금씩 할 것입니다. 하지만 여러분이 더 많이 연습할수록, 여러분에게 가장 적합한 패턴을 발견하고 접근 방식을 개발하는 데 더 잘하게 될 것입니다.

저는 제 접근 방식을 어떻게 하면 그림이 층으로 구성된 벡터 이미지를 만들 수 있는지와 연관짓는 경향이 있습니다. 필요하다면 분할해서 종이에 스케치하세요. 하지만, 밑바닥부터 시작해서 네 쪽으로 나아가라. 이것은 처음에는 더 큰 도형을 의미하고 나중에는 더 세밀한 도형을 의미하는 경향이 있다. 때 주변 요소 이동할 필요가 있으면 언제나 그 물건을 쌓아 올리고 지수를 함부로 만질 수 있다.

### 스타일에 맞는 견고한 구조 유지

그것이 우리를 구조물로 이끈다. 그림에 대해 평평한 DOM 구조를 피하십시오. 원자성을 유지하면 그림의 일부를 쉽게 이동할 수 있습니다. 그것은 또한 삽화의 일부를 보여주고 숨기거나 심지어 나중에 애니메이션화하는 것을 훨씬 더 쉽게 만들 것이다. CSS Snolax 데모를 생각해 보십시오. 팔, 발, 머리 등은 별개의 요소이다. 그 덕분에 저는 단순히 `.snorlax__arm-left` 클래스에 애니메이션을 적용할 수 있었기 때문에, 제가 사물을 함께 유지하려고 노력했을 때보다 팔을 애니메이션하는 것이 훨씬 더 쉬워졌습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_yLYXVJa" src="//codepen.io/anon/embed/yLYXVJa?height=450&amp;theme-id=1&amp;slug-hash=yLYXVJa&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed yLYXVJa" title="CodePen Embed yLYXVJa" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

여기 제가 데모를 만드는 장면이 타임랩스샷입니다.

### 어색한 모양 처리

여기 CSS-Tricks에 관한 꽤 좋은 기사가 있습니다. CSS로 도형을 만드는 것에 관한 것이죠. 하지만 긴 곡선이나 심지어 바깥쪽 곡선처럼 더 "어색한" 모양은 어떨까요? 이러한 시나리오에서, 우리는 틀에서 벗어나 생각할 필요가 있다. 오버플로우, 국경 반지름, 클립 경로 등 부동산이 큰 도움을 주고 있다.

이 CSS Jigglypuff 데모를 생각해 보십시오. 확인란을 전환합니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_gOaVJMB" src="//codepen.io/anon/embed/gOaVJMB?height=450&amp;theme-id=1&amp;slug-hash=gOaVJMB&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed gOaVJMB" title="CodePen Embed gOaVJMB" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

그것이 곡선 모양을 만드는 열쇠입니다! 우리는 신체보다 훨씬 더 큰 원소를 가지고 있으며, `경계 반지름`을 적용하고 있다. 그런 다음 신체에 `오버플로우: 히든`을 발라 그 부분을 잘라낸다.

외부 곡선은 어떻게 만들 수 있을까요? 이건 좀 까다로워요. 하지만 제가 사용하는 요령은 테두리가 두꺼운 투명한 요소입니다. 그런 다음 테두리 반경을 적용하고 필요한 경우 초과 부분을 잘라낸다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_ZEbgNKO" src="//codepen.io/anon/embed/ZEbgNKO?height=450&amp;theme-id=1&amp;slug-hash=ZEbgNKO&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed ZEbgNKO" title="CodePen Embed ZEbgNKO" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

토글을 누르면 해당 모서리를 가로지르는 데 사용하는 요소가 표시됩니다. 다른 요령은 배경색과 일치하는 원을 겹치는 것일 수 있습니다. 배경색을 바꿀 때까지는 괜찮습니다. 해당 색상에 맞는 변수나 다른 변수가 있으면 괜찮습니다. 하지만, 이것은 유지하기가 조금 더 어렵게 만들 수 있습니다.

### 'clip-path'는 당신의 친구입니다.

마지막 데모에서 클립 경로를 포함하여 몇 가지 흥미로운 CSS 속성을 발견했을 수 있습니다. 복잡한 CSS 도형을 만들려면 "클립 경로"가 필요할 것입니다. 특히 상위 상자 오버플로를 숨기면 해당 요소를 차단할 때 유용합니다.

여기 제가 얼마 전에 만든 다른 `클립 경로` 가능성을 보여주는 작은 데모입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_XqVQqa" src="//codepen.io/anon/embed/XqVQqa?height=450&amp;theme-id=1&amp;slug-hash=XqVQqa&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed XqVQqa" title="CodePen Embed XqVQqa" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

CSS의 형상 기사에서 아이디어를 얻어 clip-path로 다시 만든 데모도 있다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_gOpLBEa" src="//codepen.io/anon/embed/gOpLBEa?height=450&amp;theme-id=1&amp;slug-hash=gOpLBEa&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed gOpLBEa" title="CodePen Embed gOpLBEa" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### '국경선녀'는 너의 다른 친구다.

곡선을 그리려면 `경계 반지름`이 필요합니다. 한 가지 흔하지 않은 수법은 "이중" 구문을 사용하는 것입니다. 이렇게 하면 각 모서리에 대해 수평 및 수직 반지름을 만들 수 있습니다.

이 데모로 `국경 반지름`의 힘을 제대로 감상해 보세요. 상황에 대응력을 유지하기 위해 전반적으로 백분율을 사용하는 것을 지지합니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_XWmvwYg" src="//codepen.io/anon/embed/XWmvwYg?height=450&amp;theme-id=1&amp;slug-hash=XWmvwYg&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed XWmvwYg" title="CodePen Embed XWmvwYg" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 음영 기법

모양도 다 있고, 모든 것이 잘 정돈되어 있고, 모든 적절한 색깔도 갖추어져 있지만, 여전히 뭔가 안 좋은 것 같아요. 음영이 부족할 가능성이 높습니다.

쉐이딩은 깊이를 더하고 실감나는 느낌을 줍니다. Gal Shir 일러스트레이션의 새로운 모습을 생각해 보십시오. 갈은 아름다운 일러스트를 만들기 위해 음영과 그라데이션의 활용에 환상적이다. 재현을 하고 음영 전환 스위치를 넣어 음영이 어떤 차이가 나는지 알아보는 것도 재미있을 것 같았다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_OJMNyVg" src="//codepen.io/anon/embed/OJMNyVg?height=450&amp;theme-id=1&amp;slug-hash=OJMNyVg&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed OJMNyVg" title="CodePen Embed OJMNyVg" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

음영 효과는 종종 상자 그림자와 배경 이미지 조합으로 생성된다.

이러한 속성의 핵심은 쉼표로 구분된 목록으로 쌓을 수 있다는 것입니다. 예를 들어 데모의 솥에는 몸 전체에 걸쳐 사용되는 기울기 목록이 있습니다.

```css
.cauldron {
  background:
    radial-gradient(25% 25% at 25% 55%, var(--rim-color), transparent),
    radial-gradient(100% 100% at -2% 50%, transparent, transparent 92%, var(--cauldron-color)),
    radial-gradient(100% 100% at -5% 50%, transparent, transparent 80%, var(--darkness)),
    linear-gradient(310deg, var(--inner-rim-color) 25%, transparent), var(--cauldron-color);
}
```

여기서 "방사선 그라데이션()"과 "선형 그라데이션()"이 사용되고 있으며 항상 완벽하게 둥근 숫자 값이 있는 것은 아닙니다. 다시 말하지만, 그 수치들은 괜찮습니다. 사실, 여러분은 스타일 검사관에 있는 것들을 고치고 만지작거리는데 많은 시간을 보낼 것입니다.

일반적으로 박스 섀도우도 마찬가지입니다. 그러나 이를 통해 삽입 값을 사용하여 까다로운 테두리 및 추가 깊이를 만들 수도 있습니다.

```css
.cauldron__opening {
  box-shadow:
    0 0px calc(var(--size) * 0.05px) calc(var(--size) * 0.005px) var(--rim-color) inset,
    0 calc(var(--size) * 0.025px) 0 calc(var(--size) * 0.025px) var(--inner-rim-color) inset,
    0 10px 20px 0px var(--darkness), 0 10px 20px -10px var(--inner-rim-color);
}
```

원하는 효과를 얻기 위해 필터:드롭 섀도우()로 가는 것이 더 말이 될 때가 분명히 있다.

Lynn Fisher`s a.singlediv.com은 이러한 속성들이 실제로 작용하고 있다는 것을 보여주는 훌륭한 예입니다. 그 장소를 한번 둘러보고 그림에서 상자 그림자와 배경 이미지를 사용할 수 있는 좋은 방법이 있는지 몇 가지 삽화들을 살펴보도록 하자.

박스-캐스팅은 너무 강력해서 그것으로 당신의 일러스트를 전부 만들 수 있다. 나는 한때 1달러의 CSS 일러스트를 만드는 것에 대해 농담을 한 적이 있다.

나는 하나의 div로 일러스트를 만들기 위해 발전기를 사용했다. 하지만 알바로 몬토로는 조금 더 멀리 가서 박스 섀도우로 대신 작동하는 발전기를 썼습니다.

### 사전 프로세서는 매우 유용합니다.

필수 사항은 아니지만, 사전 프로세서를 사용하면 코드를 깔끔하고 깔끔하게 유지할 수 있습니다. 예를 들어, Pug는 HTML을 더 빨리 쓸 수 있게 해주는데, 특히 반복 요소들을 처리하기 위해 루프를 사용할 때 그러하다. 여기서 우리는 스타일을 한 번만 정의하면 되는 방식으로 CSS 사용자 지정 속성을 범위로 지정할 수 있으며, 필요한 곳에 덮어쓸 수 있다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 500px;"><iframe id="cp_embed_xJXvjP" src="//codepen.io/anon/embed/xJXvjP?height=500&amp;theme-id=1&amp;slug-hash=xJXvjP&amp;default-tab=result" height="500" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed xJXvjP" title="CodePen Embed xJXvjP" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

다음은 DRY 구조를 보여주는 또 다른 예입니다. 플라워는 동일한 마크업으로 구성되지만 각각에 범위 CSS 속성을 적용하는 데 사용되는 자체 인덱스 클래스가 있다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_eYpjXvj" src="//codepen.io/anon/embed/eYpjXvj?height=450&amp;theme-id=1&amp;slug-hash=eYpjXvj&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed eYpjXvj" title="CodePen Embed eYpjXvj" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

첫 번째 꽃은 다음과 같은 특성을 가지고 있습니다.

```css
.flower--1 {
  --hue: 190;
  --x: 0;
  --y: 0;
  --size: 125;
  --r: 0;
}
```

첫 번째 작품이라 다른 작품들은 다 그런 걸 바탕으로 하고 있어요. 두 번째 꽃이 오른쪽으로 꺾이고 위로 약간 올라간 것을 주목하세요. 동일한 사용자 지정 속성에 다른 값을 할당하기만 하면 됩니다.

```css
.flower--2 {
  --hue: 320;
  --x: 140;
  --y: -75;
  --size: 75;
  --r: 40;
}
```

### 다 됐다! 더 이상 어쩔 수 없다!

계속하여, 이 팁을 사용하여 자신만의 정보를 만들고, 공유하고, CSS 걸작을 공유하세요! 그리고 만약 여러분 자신의 조언이 있다면, 여러분도 그것을 공유하세요! 이것은 분명 많은 시행착오를 통해 학습되는 종류의 것입니다. 제게 맞는 것은 여러분에게 맞는 것과 다르게 보일 수 있고 우리는 이러한 다양한 접근법으로부터 배울 수 있습니다.