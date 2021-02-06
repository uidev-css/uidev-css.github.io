---
layout: post
title: "Sass와 새 CSS 기능이 충돌하는 경우"
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/06/dithering-pixel-background-layers.png"
tags: CALC,CSS VARIABLES,CUSTOM PROPERTIES,FILTER,GRADIENTS,MAX,MIN,SASS
---


최근 CSS는 커스텀 속성과 새로운 기능 등 새로운 쿨 기능을 많이 추가했다. 이런 것들이 우리의 삶을 훨씬 더 쉽게 만들 수 있지만, 그것들은 또한 Sass와 같은 전처리장치와 재미있는 방식으로 상호작용하게 될 수도 있습니다.

그래서 이 게시물은 제가 접한 문제들, 제가 그 문제를 어떻게 다루는지, 그리고 왜 요즘에도 Sass가 필요하다고 생각하는지에 대한 게시물이 될 것입니다.

### 오류

새로운 min()과 max() 기능으로 플레이했다면 호환이 안 되는 장치 vh와 max()로 작업할 때 이런 오류 메시지가 나타날 수 있다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/06/err_0_incomp_units.png?resize=800%2C245&ssl=1)

이는 Sass가 자체 min() 기능을 갖고 있으며 CSS min() 기능을 무시하기 때문이다. 또한, Sass는 고정된 관계가 없는 단위를 가진 두 개의 값을 사용하여 어떤 종류의 계산도 수행할 수 없습니다.

예를 들어 cm와 in은 서로 관계가 정해져 있어서 sass는 min(20in, 50cm)의 결과를 파악할 수 있고, 코드에서 사용하려고 해도 오류를 발생시키지 않는다.

다른 부서도 마찬가지입니다. 예를 들어, 각도 단위는 모두 `1회전`, `1rad`, `1grad` 사이에 고정된 관계를 가지고 있다. 1000ms인 1s, 1000Hz인 1kHz, 96dpi인 1dppx, 96px인 1in도 마찬가지다. 그래서 사스가 변환해 연산과 자체 min() 함수 등 내부 기능에 섞을 수 있는 것이다.

그러나 이들 단위가 (이전처럼) 그들 사이에 일정한 관계가 없을 때 상황은 깨진다.

그리고 그것은 단지 다른 단위가 아닙니다. min() 안에 calc()를 사용하려다 오류가 발생하기도 한다. calc(20em + 7px) 같은 것을 시도하면 calc(20em + 7px)는 min의 숫자가 아니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/06/err_1_calc_NaN.png?w=500&ssl=1)

CSS 변수나 수학적 CSS 함수(예: `calc()min() 또는 `max()`)의 결과를 `invert()`와 같은 CSS 필터에서 사용하고자 할 때 또 다른 문제가 발생한다.

이 경우, "$컬러 var(--p, 0.85)는 invert의 색이 아니다"라는 말을 듣게 된다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/06/err_2_filter_var_NaC.png?w=500&ssl=1)

그레이스케일()$컬러=칼크(.2+var(--d,.3))는 그레이스케일의 색이 아니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/06/err_3_filter_calc_NaC.png?w=500&ssl=1)

같은 문제를 일으킨다. "$컬러: var(--p, 0.8)는 "color"의 색이 아닙니다."

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/06/err_4_filter_var_NaC.png?w=500&ssl=1)

그러나 sepia()pha()pha()pha()pha()pha()pha의 drop-shadow()pha()pha의 drop-shadow()와 hue-rotate() 등의 다른 필터 기능은 모두 CSS 변수와 함께 잘 작동한다.

현재 일어나고 있는 일이 min()과 max()의 문제와 비슷하다는 것이 밝혀졌다. Sass는 sepia()blur()drop-shadow()drop-shadow()contrast()hue-rotate()contrast()contrast()contrast()contrast() 기능이 내장되어 있지 않지만 회색조() 반전(invert)(opacity)과 불투명() 기능이 있으며 첫 번째 주장은 색상 값이다. 그런 주장을 발견하지 못했기 때문에 오류를 범하게 됩니다.

같은 이유로 최소 두 개의 hsl() 또는 hsla() 값을 나열하는 CSS 변수를 사용하려고 할 때도 문제가 발생한다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/06/err_5_hsl_wrong_arg_num.png?w=500&ssl=1)

반면 color: hsl(9, var(--sl, 95%, 65%)은 완벽하게 유효한 CSS이며 Sass 없이도 잘 작동한다.

rgb()와 rgba() 함수도 마찬가지다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/06/err_6_rgba_var_NaC.png?ssl=1)

또한 Compass를 가져와 `선형 그레이디언트() 내부 또는 `방사형 그레이디언트() 내부에서 CSS 변수를 사용하려고 하면 (즉, 브라우저가 지원하는 경우) `원뿔 그레이디언트()` 내부에서 변수를 사용하면 잘 작동하더라도 또 다른 오류가 발생한다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/06/err_7_grad_stop_num.png?w=500&ssl=1)

컴패스는 선형 그레이디언트()와 반지름 그레이디언트() 함수가 있지만 원뿔 그레이디언트() 함수는 추가한 적이 없기 때문이다.

이러한 모든 경우의 문제는 동일한 이름의 함수를 가진 Sass 또는 Compass에서 발생하며 이러한 함수를 코드에서 사용하려고 의도한 것으로 가정하는 것입니다.

제기랄!

### 해결책

여기서의 요령은 Sass는 대소문자를 구분하지만 CSS는 그렇지 않다는 것을 기억하는 것이다.

즉, 우리는 Min(20em, 50vh)을 쓸 수 있고 Sass는 그것을 Min() 기능으로 인식하지 않을 것이다. 오류가 발생하지 않으며, 여전히 유효한 CSS입니다. 마찬가지로 HSL()/HSLA()/RGB()/RGBA() 또는 Invert()를 쓰면 앞에서 살펴본 문제를 피할 수 있다.

그레이디언트는 SVG 버전에 가깝다는 이유만으로 선형 그레이디언트()와 반지름 그레이디언트()를 선호하지만 적어도 한 개의 대문자를 사용하면 된다.

### 그런데 왜?

거의 모든 Sass 관련 트윗을 할 때마다 CSS 변수가 생겼기 때문에 어떻게 하면 안 되는지에 대해 강의를 듣습니다. 나는 그 문제를 해결하고 내가 왜 동의하지 않는지 설명해야겠다고 생각했다.

첫째, CSS 변수가 매우 유용하고 지난 3년 동안 거의 모든 것에 사용되었지만, 성능 비용과 미로처럼 `calc()` 연산에서 잘못된 것이 어디에 있는지 추적하는 것은 우리의 현재 DevTools의 골칫거리가 될 수 있다는 것을 명심하는 것이 좋다. 저는 그것들을 사용하는 것의 단점이 이점을 능가하는 영역에 들어가는 것을 피하기 위해 그것들을 남용하지 않으려고 노력합니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/06/calc_headache.png?ssl=1)

일반적으로 상수처럼 동작한다면 요소 대 요소 또는 상태 대 상태(사용자 정의 속성이 확실히 가야 할 길임)를 변경하거나 컴파일된 CSS의 양을 줄이지 않을 것이다(프리픽스에 의해 생성된 반복 문제 해결).

둘째로, 변수는 항상 내가 Sass를 사용하는 이유의 아주 작은 부분이었다. 2012년 말에 Sass를 사용하기 시작했을 때, 주로 루핑을 위한 것이었는데, CSS에는 아직 없는 기능입니다. 이러한 루핑의 일부를 HTML 전처리로 옮겼지만(이것은 생성된 코드를 줄이고 HTML과 CSS를 나중에 수정할 필요가 없기 때문에), 여전히 많은 경우에 Sass 루프를 사용합니다. 예를 들어 값 리스트 생성, 그라데이션 함수 내부의 정지 리스트, 폴리곤 함수 내부의 포인트 리스트, 변환 목록 등이 있습니다.n

여기 예가 있습니다. 나는 전처리로 `n` HTML 항목을 생성하곤 했다. 전처리기 선택은 중요하지 않지만, 난 여기서 Pug를 사용할 거야.

```pug
- let n = 12;

while n--
  .item
```

그런 다음 "$n" 변수를 Sass로 설정하고(HTML의 변수와 같아야 함) 각 항목의 위치를 지정하는 변환을 생성하도록 루프업합니다.

하지만, 이것은 아이템의 수를 변경할 때 Pug와 Sass를 모두 변경해야 한다는 것을 의미했고, 생성된 코드는 매우 반복적이었습니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/06/gen_use_0_old.png?ssl=1)

그 후 나는 Pug가 지수를 사용자 지정 속성으로 생성하도록 한 다음 transform 선언에 있는 지수를 사용하도록 했다.

```js
- let n = 12;

body(style=`--n: ${n}`)
  - for(let i = 0; i < n; i++)
    .item(style=`--i: ${i}`)
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 435px;"><iframe id="cp_embed_JjGGvpp" src="//codepen.io/anon/embed/JjGGvpp?height=435&amp;theme-id=1&amp;slug-hash=JjGGvpp&amp;default-tab=result" height="435" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed JjGGvpp" title="CodePen Embed JjGGvpp" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이렇게 하면 생성된 코드가 크게 줄어듭니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/06/gen_use_0_new.png?w=800&ssl=1)

하지만, 내가 무지개 같은 것을 만들고 싶다면 Sass에서 루프하는 것은 여전히 필요하다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 200px;"><iframe id="cp_embed_GRooBJm" src="//codepen.io/anon/embed/GRooBJm?height=200&amp;theme-id=1&amp;slug-hash=GRooBJm&amp;default-tab=result" height="200" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed GRooBJm" title="CodePen Embed GRooBJm" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

물론 Pug에서 리스트 변수로 생성할 수도 있지만, 그렇게 하면 CSS 변수의 동적 특성을 활용할 수 없고 브라우저에 제공되는 코드도 줄어들지 않기 때문에 이점이 없습니다.

내 Sass(및 Compass) 사용의 또 다른 큰 부분은 내장 수학적 함수(예: 삼각함수)와 연결되어 있는데, 이 함수들은 현재 CSS 규격의 일부이지만 아직 어떤 브라우저에서도 구현되지 않았다. Sass도 이러한 기능을 가지고 있지 않지만 Compass는 그렇게 하고 이것이 내가 종종 Compass를 사용해야 하는 이유이다.

그리고, 물론, 나는 Sass에 내 자신의 그런 기능들을 쓸 수 있다. 저는 처음에 이것을 이용했는데, 컴퍼스가 역삼중계 함수를 지원하기 전에요. 저는 그것들이 정말 필요했기 때문에 테일러 시리즈를 바탕으로 제 것을 썼습니다. 하지만 컴패스는 오늘날 이런 종류의 기능을 제공하고 있고 그것들은 저보다 더 훌륭하고 더 성능이 뛰어납니다.

저는 예술가가 아니라 기술자이기 때문에 수학적 기능이 굉장히 중요합니다. 내 CSS의 값은 대개 수학적 계산에서 비롯된다. 그것들은 마법의 숫자나 순수하게 미학을 위해 사용되는 것이 아닙니다. 예를 들어 정규 또는 준정규 다각형을 만드는 클립 경로 점 목록을 생성하는 것이 있습니다. 직사각형이 아닌 아바타나 스티커 같은 것을 만들고자 하는 경우를 생각해보세요.

시작 원소의 반지름 `50%`인 원에 정점이 있는 정규 다각형에 대해 생각해 보자. 다음 데모에서 슬라이더를 끌면 서로 다른 수의 정점에 대한 점이 배치되는 위치를 확인할 수 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 500px;"><iframe id="cp_embed_QbBWZb" src="//codepen.io/anon/embed/QbBWZb?height=500&amp;theme-id=1&amp;slug-hash=QbBWZb&amp;default-tab=result" height="500" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed QbBWZb" title="CodePen Embed QbBWZb" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

Sass 코드에 넣으면 다음과 같은 이점이 있습니다.

여기서 우리는 또한 Looping과 Sass 없이 CSS를 사용할 때 정말 고통스러운 조건이나 모듈 같은 것들을 사용하고 있습니다.

약간 더 진화한 버전의 경우 각 정점의 각도에 동일한 오프셋 각도(`$oa`)를 추가하여 폴리곤을 회전시킬 수 있다. 이는 다음 데모에서 확인할 수 있습니다. 이 예는 항상 정점 수가 짝수이고 모든 홀수 지수 정점이 더 작은 반지름의 원 위에 위치한다는 점을 제외하고 유사한 방식으로 작동하는 별 혼합으로 토스한다(여기서 `$f`는 하위 단위이다).

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 320px;"><iframe id="cp_embed_PRMxwj" src="//codepen.io/anon/embed/PRMxwj?height=320&amp;theme-id=1&amp;slug-hash=PRMxwj&amp;default-tab=result" height="320" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed PRMxwj" title="CodePen Embed PRMxwj" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

우리는 또한 이렇게 통통한 스타들을 가질 수 있다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 500px;"><iframe id="cp_embed_KLyjBx" src="//codepen.io/anon/embed/KLyjBx?height=500&amp;theme-id=1&amp;slug-hash=KLyjBx&amp;default-tab=result" height="500" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed KLyjBx" title="CodePen Embed KLyjBx" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

또는 흥미로운 `경계` 패턴이 있는 스티커도 있습니다. 이 데모에서는 각 스티커가 하나의 HTML 요소로 생성되고, Sass에서는 clip-path, 루프, 수학으로 border 패턴은 "clip-path"로 생성된다. 사실, 꽤 많이요.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 500px;"><iframe id="cp_embed_XWJaXRp" src="//codepen.io/anon/embed/XWJaXRp?height=500&amp;theme-id=1&amp;slug-hash=XWJaXRp&amp;default-tab=result" height="500" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed XWJaXRp" title="CodePen Embed XWJaXRp" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

또 다른 예는 루프, 모듈 작동 및 지수 함수가 함께 작동하여 디더링 픽셀 배경 레이어를 생성하는 카드 배경입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 500px;"><iframe id="cp_embed_gOYxjLz" src="//codepen.io/anon/embed/gOYxjLz?height=500&amp;theme-id=1&amp;slug-hash=gOYxjLz&amp;default-tab=result" height="500" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed gOYxjLz" title="CodePen Embed gOYxjLz" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이 데모는 CSS 변수에도 크게 의존하게 된다.

그런 다음 범위 입력과 같은 스타일을 지정할 때 동일한 선언문을 반복해서 쓰지 않도록 믹신을 사용합니다. 브라우저마다 이러한 컨트롤의 구성 요소를 스타일링하기 위해 서로 다른 의사 요소를 사용하기 때문에 모든 구성 요소에 대해 우리는 여러 의사에서 모양을 제어하는 스타일을 설정해야 한다.

슬프게도, CSS에 이것을 넣는 것은 매우 매력적입니다.

```css
input::-webkit-slider-runnable-track, 
input::-moz-range-track, 
input::-ms-track { /* common styles */ }
```

…이 작동하지 않기 때문에 우리는 그것을 할 수 없습니다! 선택 도구 중 하나라도 인식되지 않으면 전체 규칙 집합이 삭제됩니다. 그리고 위의 세 가지를 모두 인식하는 브라우저가 없기 때문에 어떤 브라우저에도 스타일이 적용되지 않습니다.

우리가 우리의 스타일을 적용하기를 원한다면 우리는 이와 같은 것을 가져야 한다.

```css
input::-webkit-slider-runnable-track { /* common styles */ }
input::-moz-range-track { /* common styles */ }
input::-ms-track { /* common styles */ }
```

하지만 그것은 많은 동일한 스타일이 세 번 반복된다는 것을 의미할 수 있다. 그리고 트랙의 `배경`을 바꾸려면 `:-웹킷-슬라이더-런너블 트랙` 스타일, `:-모즈-레인지-트랙` 스타일, `:-ms-트랙` 스타일로 바꿔야 한다.

우리가 가진 유일한 해결책은 혼합물을 사용하는 것이다. 컴파일된 코드에서 스타일이 반복되는데, 우리는 더 이상 같은 것을 세 번 쓸 필요가 없습니다.

결론은, 그렇다, Sass는 2020년에 여전히 매우 필요하다.