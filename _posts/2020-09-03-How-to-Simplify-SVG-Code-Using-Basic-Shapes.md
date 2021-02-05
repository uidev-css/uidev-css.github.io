---
layout: post
title: "기본 도형을 사용하여 SVG 코드를 단순화하는 방법"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/08/n5iIkClg.png
tags: 
---


아이콘으로 작업하는 방법에는 여러 가지가 있지만, 가장 좋은 솔루션에는 항상 SVG가 포함되어 있습니다(인라인으로 구현되거나 이미지 파일로 연결됨). 그 이유는 코드로 "그려져" 있기 때문에 어떤 맥락에서든 유연하고, 적응력이 뛰어나며, 확장성이 뛰어나기 때문입니다.

하지만 SVG를 사용할 때는 불필요한 코드를 많이 포함할 가능성이 항상 있습니다. 경우에 따라서는 인라인 SVG의 코드가 길어서 문서를 스크롤하는 데 더 오래 걸리고, 작업하기에 불편하며, 필요한 것보다 조금 더 무겁습니다.

우리는 이 코드 조각 재사용을 `사용` 요소로 해결하거나 기본 변수를 적용하여 SVG 스타일을 한 곳에서 관리할 수 있다. 또는 서버측 환경에서 작업하는 경우, 항상 작은 PHP(또는 이와 유사한)를 뿌려 SVG 파일의 내용을 바로 삭제하는 대신 추출할 수 있습니다.

괜찮습니다만, 코드 기반 접근 방식에 의존하지 않고 파일 레벨에서 이 문제를 해결할 수 있다면 좋지 않을까요? 저는 다른 관점에 초점을 맞추고 싶습니다. 어떻게 하면 기본 도형을 이용해서 코드를 적게 가지고 같은 도형을 만들 수 있을까 하는 것입니다. 이렇게 하면 품질이나 시각적 변화를 희생시키지 않고도 프로젝트에서 작고, 제어 가능하며, 의미론적 아이콘의 이점을 얻을 수 있다. 일반적으로 사용되는 아이콘의 코드와 우리가 만들 수 있는 가장 쉬운 SVG 모양을 사용하여 다시 그릴 수 있는 방법을 살펴보는 여러 가지 예를 살펴보겠습니다.

작업 중인 아이콘은 다음과 같습니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/08/n5iIkClg.png?resize=1600%2C506&ssl=1)

코드를 작고 간단하게 만드는 데 사용할 수 있는 기본 모양을 살펴봅시다.

holasvg.com에서 만든 간단한 아이콘의 더 긴 목록이 있습니다! 이 문서 다음에는 해당 문서를 수정하고 직접 만드는 방법에 대해 알아봅니다.

### '<라인> 요소를 사용하여 닫기 아이콘 단순화

이 코드는 flaticon.com에서 다운로드하여 픽셀 단위로 만든 "닫기" 또는 "십자" 아이콘의 코드입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 550px;"><iframe id="cp_embed_gOPJOjJ" src="//codepen.io/anon/embed/gOPJOjJ?height=550&amp;theme-id=1&amp;slug-hash=gOPJOjJ&amp;default-tab=html,result" height="550" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed gOPJOjJ" title="CodePen Embed gOPJOjJ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이 예에서는 모든 것이 데이터 속성(d)에 명령과 매개 변수가 많은 <path> 내부에서 발생합니다. 이 SVG는 국경에서 모양을 추적하고 있습니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/08/3Bsd6AZw.gif?resize=600%2C339&ssl=1)

일러스트레이터에 익숙하다면, 이것은 두 개의 별도의 선을 그어 모양에 변환한 다음 두 선을 모두 경로 검색기와 결합하여 하나의 복합 모양을 만드는 것과 같습니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/08/ilustrator-shape.gif?resize=1024%2C548&ssl=1)

<path> 요소를 사용하면 복잡한 도형을 그릴 수 있지만, 이 경우 동일한 모양을 유지하면서 두 개의 선으로 동일한 도형을 만들 수 있습니다.

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 50 50" width="50" height="50" overflow="visible" stroke="black" stroke-width="10" stroke-linecap="round">
   <line x1="0" y1="0" x2="50" y2="50" />
   <line x1="50" y1="0" x2="0" y2="50" />
</svg>
```

우리는 viewBox를 0.0에서 50,50으로 정의하는 것으로 시작했다. 원하는 모든 치수를 선택할 수 있습니다. SVG는 항상 사용자가 정의하는 폭과 높이에 맞게 적절하게 조정됩니다. 이 경우 보다 쉽게 하기 위해 인라인 폭과 높이도 50개로 정의했는데, 이는 도면에서 추가 계산을 피할 수 있습니다.

`<선>` 요소를 사용하기 위해 선 첫 번째 점의 좌표와 선 마지막 점의 좌표를 선언합니다. 이 경우 x=0 y=0에서 시작하여 x=50 y=50으로 끝났습니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/08/ikq7mzlU.png?resize=255%2C255&ssl=1)

코드는 다음과 같습니다.

```svg
<line x1="0" y1="0" x2="50" y2="50" />
```

두 번째 줄은 `x=50 y=0`에서 시작하여 `x=0 y=50`에서 끝납니다.

```html
<line x1="50" y1="0" x2="0" y2="50" />
```

SVG 스트로크에는 기본적으로 색상이 지정되어 있지 않으므로 "stroke" 속성에 "black" 값을 추가했습니다. 우리는 또한 원래 디자인의 둥근 모서리를 복제하기 위해 가로세로 폭 10단위, 세로줄 캡을 `둥근` 값으로 부여했다. 이 속성은 lines 태그에 직접 추가되어 두 줄 모두 상속됩니다.

```svg
<svg ... stroke="black" stroke-width="10" stroke-linecap="round" ...>
```

스트로크가 기본 크기인 1단위로 10단위가 커졌으니 viewBox에 의해 줄이 끊어질 수도 있다. viewBox 안에 있는 포인트 10개를 옮기거나 스타일에 ➡=➡을 추가할 수 있습니다.

0이 기본값이기 때문에 0과 같은 값을 제거할 수 있습니다. 즉, 두 줄은 매우 작은 두 줄의 코드로 끝납니다.

```svg
<line x2="50" y2="50" />
<line x1="50" y2="50" />
```

단지 `<path>`를 `<line>`으로 변경함으로써 우리는 더 작은 SVG 파일을 만들었을 뿐만 아니라 향후의 유지보수를 훨씬 더 쉽게 만드는 의미 있고 제어 가능한 코드 덩어리를 만들었다. 그리고 시각적 결과는 원본과 정확히 같습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 300px;"><iframe id="cp_embed_PoZvoxM" src="//codepen.io/anon/embed/PoZvoxM?height=300&amp;theme-id=1&amp;slug-hash=PoZvoxM&amp;default-tab=html,result" height="300" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed PoZvoxM" title="CodePen Embed PoZvoxM" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

같은 십자가, 다른 코드.

### ➡원 및 ➡경로 요소를 사용하여 시계 아이콘 단순화

저는 명사 프로젝트의 Barracuda가 만든 시계 아이콘의 예를 들어 보았습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_qBbzLZo" src="//codepen.io/anon/embed/qBbzLZo?height=450&amp;theme-id=1&amp;slug-hash=qBbzLZo&amp;default-tab=html,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed qBbzLZo" title="CodePen Embed qBbzLZo" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이 셰이프도 `<path>`로 그렸지만 사용된 소프트웨어와 SVG에 영향을 주지 않고 삭제할 수 있는 파일의 라이센스와 관련된 많은 네임스페이스와 XML 지침을 가지고 있다. 아이콘을 만들기 위해 어떤 일러스트 에디터가 사용되었는지 알 수 있나요?

동그라미와 간단한 명령을 사용하여 처음부터 다시 만들어 보겠습니다. 다시 말씀드리지만 이번에는 0에서 10,100까지 `뷰박스`로 시작해서 그 단위들에 맞는 폭과 높이로 시작해야 합니다.

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" width="100" height="100" fill="none" stroke="black" stroke-width="10" stroke-linecap="round" stroke-linejoin="round">
  <circle cx="50" cy="50" r="40"/>
  <path d="M50 25V50 H75" /> 
</svg>
```

우리는 <svg> 태그 안에 이전의 아이콘과 같은 스타일을 유지한다. fill은 기본적으로 black이므로 none 값을 명시적으로 부여해야 제거할 수 있다. 그렇지 않으면, 원은 다른 모양을 가리는 검은색 채우기를 갖게 됩니다.

`원`을 그리려면 반지름이 위치할 중심점을 표시해야 한다. 우리는 cx(중심 x)와 cy(중심 y)로 그것을 달성할 수 있다. 그러면 r(반경)이 우리 원의 크기를 선언할 것이다. 이 예에서 반지름은 viewBox보다 약간 작기 때문에 스트로크의 폭이 10단위일 때 잘리지 않는다.

그 편지들 왜 저러지? SVG 구문에 대한 프라이머는 Chris Coyier의 그림 가이드를 참조하십시오.

시계 바늘에는 매우 유용하고 간단한 명령어가 있기 때문에 우리는 시계 바늘에 <path>를 사용할 수 있다. d(데이터) 내에서는 M(이동) 명령 다음에 50,25(원 위 중심 부근)인 좌표를 그려야 한다.

V(수직) 명령 후에는 음수 또는 양수만 사용하여 위아래로 이동할 수 있기 때문에 하나의 값만 필요합니다. 양의 숫자는 감소합니다. H(수평)도 마찬가지이고 오른쪽으로 쏠리는 양수(75)도 그 뒤를 잇는다. 모든 명령은 대문자로 표시되므로 선택한 숫자는 그리드에서 점이 됩니다. 소문자(상대 명령)를 사용하기로 결정한 경우 숫자는 좌표계의 절대점이 아니라 한 방향으로 이동하는 단위의 양이 됩니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 300px;"><iframe id="cp_embed_PoZrXWM" src="//codepen.io/anon/embed/PoZrXWM?height=300&amp;theme-id=1&amp;slug-hash=PoZrXWM&amp;default-tab=html,result" height="300" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed PoZrXWM" title="CodePen Embed PoZrXWM" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

같은 시계, 다른 코드.

### ➡수정 및 ➡다선 요소를 사용하여 봉투 아이콘 단순화

나는 원래 모양을 확장하지 않고 일러스트레이터에 봉투 아이콘을 그렸습니다. 내보내기에서 가져온 코드는 다음과 같습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 500px;"><iframe id="cp_embed_dyMWyKy" src="//codepen.io/anon/embed/dyMWyKy?height=500&amp;theme-id=1&amp;slug-hash=dyMWyKy&amp;default-tab=html,result" height="500" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed dyMWyKy" title="CodePen Embed dyMWyKy" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

일러스트레이터는 그래픽을 내보낼 수 있는 몇 가지 SVG 옵션을 제공합니다. CSS 속성 드롭다운에서 "Style Elements"를 선택하여 CSS 파일로 이동할 수 있는 클래스를 포함하는 "<style>" 태그를 가질 수 있습니다. 하지만 물론 SVG에서 스타일을 적용하는 방법은 다양합니다.

이 코드에는 이미 기본 도형이 있습니다! Illustrator에서 "Shape to paths" 옵션을 선택 취소하여 많은 도움이 되었습니다. 우리는 SVGOMG를 사용하여 코멘트, XML 명령 및 빈 요소와 같은 불필요한 데이터를 제거하기 위해 이를 더욱 최적화할 수 있다. 필요한 경우 다른 추가 기능을 수동으로 제거할 수 있습니다.

이미 좀 더 간결한 것이 있습니다.

```svg
<svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" x="0" y="0" viewBox="0 0 310 190" xml:space="preserve">
  <style>.st0{fill:none;stroke:#000;stroke-width:10;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10}
  </style><rect x="5" y="5" class="st0" width="300" height="180"/>
  <polyline class="st0" points="5 5 155 110 305 5"/>
</svg>
```

봉투의 시각적 모양에 영향을 주지 않고 다음과 같은 더 많은 물건을 제거할 수 있습니다.

- `version="1.1" (SVG 2 이후 더 이상 사용되지 않음)
- `id="Layer_1"(이것은 의미 또는 용도가 없음)
- `x="0"(기본값)
- `y=`0`(기본값)
- "xml:space="discount" (SVG 2 이후 더 이상 사용되지 않음)

```svg
<svg xmlns="http://www.w3.org/2000/svg" x="0" y="0" viewBox="0 0 310 190">
  <style>.st0{fill:none;stroke:#000;stroke-width:10;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10}
  </style>
  <rect x="5" y="5" class="st0" width="300" height="180"/>
  <polyline class="st0" points="5 5 155 110 305 5"/>
</svg>
```

우리가 정말 공격적이기를 원한다면 CSS 스타일을 다른 스타일시트로 옮길 수 있습니다.

【정확】 [정확한 【정확한 【정확한 】 [정확한 【정확한 】 [정확한 【정확한 【정확한 【정확한 【정확한 】 [정확한 】]의 시작점이 필요하니, 우리 왼쪽 상단 포인트인 【x=5】를 사용하자. 거기서부터 가로 300단위, 세로 180단위의 직사각형을 만들겠습니다. 시계 아이콘과 마찬가지로 좌표가 0,0이면 잘리는 10단위의 스트로크가 있기 때문에 5,5단을 출발점으로 삼겠습니다.

<선>은 <선>과 비슷하지만 우리가 정의하는 무한한 양의 점들이 하나 둘씩 차례로 점 속성 안에 있는데, 여기서 두 번째 숫자는 x를 나타내고 두 번째 숫자는 y를 나타낸다. 쉼표로 순서를 읽는 것이 더 쉽지만 결과에 영향을 미치지 않고 공백으로 바꿀 수 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_zYqwYbX" src="//codepen.io/anon/embed/zYqwYbX?height=450&amp;theme-id=1&amp;slug-hash=zYqwYbX&amp;default-tab=html,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed zYqwYbX" title="CodePen Embed zYqwYbX" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

같은 봉투, 다른 코드.

### 보너스 모양!

`폴리곤`과 `엘립스` 모양으로 단순화할 수 있는 아이콘의 예는 포함하지 않았지만, 이를 사용하는 빠른 방법이 있다.

이 요소만이 항상 닫힌 모양을 정의하게 되는 <<<<<>>와 같다. MDN에서 직접 제공하는 예는 다음과 같습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 400px;"><iframe id="cp_embed_jOqmEZd" src="//codepen.io/anon/embed/jOqmEZd?height=400&amp;theme-id=1&amp;slug-hash=jOqmEZd&amp;default-tab=html,result" height="400" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed jOqmEZd" title="CodePen Embed jOqmEZd" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

아까 시계 아이콘으로 그린 원 기억나? r(반경)을 rx와 rry로 교체한다. 이제 반지름에 대한 두 가지 값이 있습니다. MDN의 다른 예는 다음과 같습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 300px;"><iframe id="cp_embed_bGpWNax" src="//codepen.io/anon/embed/bGpWNax?height=300&amp;theme-id=1&amp;slug-hash=bGpWNax&amp;default-tab=html,result" height="300" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed bGpWNax" title="CodePen Embed bGpWNax" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 마무리하기

짧은 시간에 여기서 많은 걸 다뤘어! 예를 들어 SVG 최적화 프로세스를 시연하는 데 사용했지만, 이 게시물에서 벗어나길 바랍니다.

- 압축은 그림 소프트웨어에서 SVG를 그리는 방법에서 시작됩니다.
- SVOMG와 같은 사용 가능한 도구를 사용하여 SVG를 압축합니다.
- 필요한 경우 불필요한 메타데이터를 수동으로 제거합니다.
- 복잡한 경로를 기본 모양으로 바꿉니다.
- <usage>는 SVG를 "인라인"하는 좋은 방법일 뿐만 아니라 재사용 가능한 아이콘 라이브러리를 설정하는 데에도 유용합니다.

holasvg.com/icons,에서 목록을 작성하고 있습니다. 여기에 더 많은 아이콘과 기능을 계속 업로드하고 있습니다. 이제 몇 가지 숫자만 변경해도 쉽게 수정할 수 있습니다. 어서 네 것으로 만들어!