---
layout: post
title: "불규칙한 SVG 스트로크로 필기 애니메이션을 얻는 방법"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/09/svg-handwriting-animation.jpg
tags: STROKE-DASHARRAY,SVG ANIMATION
---


저는 글씨체를 위한 글씨체 애니메이션을 만들고 싶었습니다. 마치 글씨가 눈에 보이지 않는 펜에 의해 쓰여지는 것처럼 애니메이션처럼 말이죠. 서예 글꼴은 획 폭이 고르지 않기 때문에(실제로 SVG로 따지면 획조차 되지 않는다) 일반적인 경로 애니메이션 기술로는 이런 식의 작업을 거의 할 수 없었다. 그러나 몇 분 만에 이러한 영향을 달성하기 위한 SVG 마스킹의 혁신적인 응용 프로그램을 발견했다.

이 방법을 조사하는 동안, 저는 여러 출처에서 정보를 수집했습니다. 그것들을 합쳐서 최종적인 효과를 낼 수 있었습니다.


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video controls="" poster="https://css-tricks.com/wp-content/uploads/2020/09/Screen-Shot-2020-09-02-at-8.46.48-AM.png" src="https://css-tricks.com/wp-content/uploads/2020/09/marketing-lab-1.mp4" playsinline="" name="fitvid0"></video>
</div>


같이 만들자!

### SVG 마스킹

만약 한 단어나 문장의 모든 글자의 획 폭이 전체적으로 고른다면, 크레이그 로블레스키는 손글씨를 애니메이션으로 만드는 멋진 방법을 가지고 있다. 이것은 SVG 스트로크 대시 어레이 및 스트로크 오프셋 속성을 애니메이션하는 영리한 기법이다.

우리가 여기서 애니메이션하고 싶은 서예 글꼴은 글자 전체에 획 폭이 고르지 않기 때문에 `<path>`여야 하며 그런 식으로 애니메이션화하면 안 된다. 요령은 SVG 마스킹을 사용하는 것이다.

먼저 어떤 글꼴을 사용할지 알아봅시다. 제가 이 기사를 통해 사용하게 될 것은 글씨체하기에 딱 좋은 붓놀림 외모를 가진 Have HeartOne입니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/09/Klt1Jv_A.png?resize=1698%2C356&ssl=1)

애니메이션으로 만들고 싶은 문장으로 <가면>을 만들어 문장의 맨 위에 배치하자는 것이다. 다시 말해, 같은 문장의 두 층이 있을 것이다. 마스크가 위에 있기 때문에 흰색으로 제작해서 원래 문장을 아래에 숨길 수 있도록 하겠습니다. 애니메이션 실행 시 하단 레이어가 드러나도록 마스크를 애니메이션화하겠습니다.

### 레이어 만들기

이 트릭의 기본은 실제로 두 개의 개별 레이어를 생성한다는 것입니다. 하나는 다른 레이어 위에 있습니다.

- 맨 아래 계층은 원하는 글꼴을 가진 단어입니다(내 경우 HaveHeartOne).
- 맨 위 계층은 단어와 근사한 수작업 경로입니다.

수작업으로 만든 경로는 생각보다 어렵지 않습니다. 우리는 그 문장을 애니메이션하고 밝히기 위한 연속적인 경로가 필요하다. 이것은 `문자`가 아니라는 뜻이다. 그러나 일러스트레이터를 비롯한 많은 앱이 문자를 경로로 변환할 수 있습니다.

- 단어를 선택합니다.
- [속성] 패널을 열고 [개요 작성]을 누릅니다.

그리고 마법처럼, 글자들은 모양을 따르는 벡터 점들로 윤곽이 됩니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/09/Qrf0CLRQ.png?resize=1796%2C746&ssl=1)

이 때 계층으로 저장된 이러한 경로에 의미 있는 이름을 지정하는 것이 매우 중요합니다. 우리가 SVG에 이것을 예상할 때, 앱은 코드를 생성할 것이고 ID와 클래스로 그 계층 이름을 사용한다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/09/qvOvyXnQ.png?resize=1842%2C714&ssl=1)

개별 문자에 `채움`이 있지만 `스트로크`가 없는 경우:

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/09/g7-hEJHA.png?resize=1836%2C624&ssl=1)

SVG에서는 스트로크를 원하는 방식으로 애니메이션할 수 있으므로 이를 두 번째 주 레이어인 마스크로 만들어야 합니다. 우리는 펜 도구를 사용하여 글자를 추적할 수 있습니다.

- 펜 도구를 선택합니다.
- 채우기 옵션을 "없음"으로 설정합니다.
- 획 너비는 사용 중인 글꼴에 따라 달라집니다. 스트로크 너비 옵션을 5px로 설정하고 색상을 검은색으로 설정하고 있습니다.
- 그림을 시작하세요!


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video controls="" src="https://css-tricks.com/wp-content/uploads/2020/09/mask-making_1m.mov" playsinline="" name="fitvid1"></video>
</div>


제 펜 도구 실력은 별로지만 괜찮습니다. 중요한 것은 완벽함이 아니라 마스크가 그 아래 층을 덮는 것이다.

각 문자에 대해 마스크를 만들고 레이어에 적합한 이름을 사용해야 합니다. 또한 같은 문자가 두 개 이상 있는 경우 마스크를 재사용하십시오. 동일한 "A" 문자를 반복해서 다시 그릴 필요가 없습니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/09/sCVplW5w.png?resize=2514%2C1402&ssl=1)

### 내보내기

다음은 SVG 파일을 내보내야 합니다. 사용 중인 응용 프로그램에 따라 달라질 수 있습니다. Illustrator에서 File → Export → Export → SVG로 내보낼 수 있습니다.

SVG 옵션 팝업이 열립니다. 아래는 이 예에서 내보낼 기본 설정입니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/09/aAOE0z5g.png?resize=1270%2C678&ssl=1)

이제 모든 앱이 SVG를 동일한 방식으로 내보내는 것은 아닙니다. 어떤 사람들은 슬림하고 효율적인 코드를 만드는 데 탁월합니다. 다른 것들은, 그렇게 많지 않다. 어느 쪽이든, 코드 편집기에서 파일을 여는 것은 좋은 생각이다.

SVG와 협력할 때 성능을 위해 최대한 가볍게 사용할 수 있도록 몇 가지 팁을 고려해 볼 수 있습니다.

- 포인트가 적을수록 파일이 가벼워집니다.
- 더 작은 `viewBox`를 사용하면 도움이 될 수 있습니다.
- SVG를 훨씬 더 최적화할 수 있는 툴이 많이 있습니다.

### SVG 코드 수동 편집

이제 모든 앱이 SVG를 동일한 방식으로 내보내는 것은 아닙니다. 어떤 사람들은 슬림하고 효율적인 코드를 만드는 데 탁월합니다. 다른 것들은, 그렇게 많지 않다. 어느 쪽이든 코드 편집기에서 파일을 열고 몇 가지 변경을 하는 것이 좋습니다.

할 만한 가치가 있는 몇 가지 사항:

- 최종 설계 크기에 맞게 설정된 <svg> 요소 `폭`과 `높이` 속성을 부여한다.
- `<title>` 요소를 사용하십시오. 우리가 경로를 통해 작업하고 있기 때문에, 화면 독자들이 실제로 단어를 인식하지 못합니다. 초점을 맞출 때 읽을 필요가 있다면, 이것이 도움이 될 것입니다.
- 일러스트레이션 앱에 이름이 붙은 레이어를 기반으로 한 ID를 가진 그룹 요소(<g>)가 있을 것으로 보인다. 이 특정 데모에서는 그룹 요소인 #marketing-lab(개요)과 #marketing-masks(마스크)가 있습니다. 마스크를 `defs` 요소로 이동합니다. 이것이 우리가 원하는 것을 시각적으로 숨기는 것입니다.
- 마스크 그룹 내부에 경로가 있을 수 있습니다. 그렇다면 변환 속성을 제거하십시오.
- 각 경로 요소를 `<mask>로 싸서 `.mask` 클래스와 마스크된 문자를 나타내는 ID를 부여합니다.

예를 들어:

```svg
<mask id="mask-marketing-M">
  <path class="mask" id="mask-M" ... />
</mask>
```

개요 그룹(`#marketing-lab` ID를 부여한 경우) 내에서 `mask=`url(#mask-marketing-M)`을 사용하여 해당 문자 경로 요소에 마스크를 적용합니다.

```svg
<g id="marketting-lab">
  <path mask="url(#mask-marketing-M)" id="marketting-char-M" d="M427,360, ... " />
</g>
```

위의 모든 수정 사항을 사용하는 한 문자의 코드는 다음과 같습니다.

```html
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 381 81" class="marketing-lab">
  <title>Marketing Lab</title>
  <defs>
    <g id="marketing-masks">
      <mask id="mask-marketing-M">
        <path class="mask" id="mask-M"
          d="M375.5, ... ,9-10" stroke-linecap="square" stroke-linejoin="bevel" stroke-width="7" />
      </mask>
    </g>
  </defs>
  <g id="marketting-lab">
    <path
      mask="url(#mask-marketing-M)" id="marketting-char-M" 
      d="M427,360.22c-.11.08-.17.14-.17.18H427c0" />
  </g>
</svg>
```

마지막으로, 스트로크 색상을 흰색으로 재정의하는 `.mask` 요소에 대한 CSS를 추가하여 문서의 배경색에 대해 숨길 것입니다.

```css
.mask {
  fill: none;
  stroke: #fff;
}
```

### 애니메이션

CSS `스트로크-대시 어레이` 속성을 애니메이션화하여 지속적인 라인 노출 효과를 얻을 것입니다. 우리는 CSS와 JavasScript 또는 Greensock(GSAP)으로 애니메이션을 할 수 있다. 두 가지 접근 방식을 모두 살펴보겠습니다.

이것을 CSS만으로 하는 것은 매우 간단하다. JavaScript를 사용하여 경로 길이를 계산한 다음 반환된 값을 사용하여 경로를 애니메이션할 수 있습니다. JavaScript를 전혀 사용하지 않으려면 경로 길이를 한 번 계산하고 이 값을 CSS에 하드 코딩할 수 있습니다.

```css
/* Set the stroke-dasharray and stroke-dashoffset */
.mask {
  stroke-dasharray: 1000;
  stroke-dashoffset: 1000;
}
 
/* Animation the stroke-dashoffset to a zero length */
@keyframes strokeOffset {
  to {
    stroke-dashoffset: 0;
  }
}
 
/* Apply the animation to each mask */
#mask-M {
  animation: strokeOffset 1s linear forwards;
}
```

대신 해당 경로로 이동하려면 JavaScript를 사용하여 카운트를 계산할 수 있습니다.

```js
// Put the masks in an array
const masks = ['M', 'a', 'r', 'k-1', 'k-2', 'e', 't-line-v', 't-line-h', 'i-2', 'i-dot', 'n', 'g', 'lab-l', 'lab-a', 'lab-b']
 
masks.forEach((mask, index, el) => {
  const id = `#mask-${mask}` // Prepend #mask- to each mask element name
  let path = document.querySelector(id)
  const length = path.getTotalLength() // Calculate the length of a path
  path.style.strokeDasharray = length; // Set the length to stroke-dasharray in the styles
  path.style.strokeDashoffset = length; // Set the length to stroke-dashoffset in the styles
})
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 350px;"><iframe id="cp_embed_d623930e42f68682cb80376644958233" src="//codepen.io/anon/embed/d623930e42f68682cb80376644958233?height=350&amp;theme-id=1&amp;slug-hash=d623930e42f68682cb80376644958233&amp;default-tab=result" height="350" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed d623930e42f68682cb80376644958233" title="CodePen Embed d623930e42f68682cb80376644958233" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

GSAP가 무승부를 기록했습니다.SVG `path`<polyline><polyline><polygon><a lect>의 스트로크를 점진적으로 표시하거나 숨길 수 있는 SVG 플러그인 후드 아래에서 CSS `stroke-dash offset`과 `stroke-dasharray` 속성을 사용한다.

작동 방식은 다음과 같습니다.

- GSAP 포함 및 그리기코드의 SVG 스크립트입니다.
- 처음에 autoAlpha를 사용하여 그래픽을 숨깁니다.
- 시간 표시줄을 만듭니다.
- 그래픽에서 autoAlpha를 true로 설정합니다.
- 모든 문자 경로 마스크 ID를 적절한 순서로 타임라인에 추가합니다.
- 추첨 사용SVG는 모든 캐릭터를 애니메이션화합니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_d8f5285a84699aa4741a78ce1a423d1e" src="//codepen.io/anon/embed/d8f5285a84699aa4741a78ce1a423d1e?height=450&amp;theme-id=1&amp;slug-hash=d8f5285a84699aa4741a78ce1a423d1e&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed d8f5285a84699aa4741a78ce1a423d1e" title="CodePen Embed d8f5285a84699aa4741a78ce1a423d1e" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

- Jake Archibald의 SVG 애니메이션 도면선
- 캐시 에반스가 만든 내 로고 애니메이션 만들기