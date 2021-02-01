---
layout: post
title: "CSS의 Looney Tunes에서 Porky Pig 애니메이션 다시 만들기
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2021/01/3QtAnNyg.jpeg
tags: CSS ANIMATION,PERSPECTIVE,TRANSFORM
---


루니 툰 만화의 끝을 알리는 빨간 고리에서 나오는 돼지 돼지.
 우리는 거기에 도달 할 것입니다. 그러나 먼저 우리는 몇 가지 CSS 개념을 다루어야합니다.
 


<div class="video_wrapper" style="padding-top: 56.25%;">
    <iframe src="https://www.youtube.com/embed/b9434BoGkNQ" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen="" frameborder="0" name="fitvid0"></iframe>
</div>


CSS의 모든 것은 상자 또는 직사각형입니다.
 직사각형은 스택되며 다른 직사각형의 위 또는 아래에 표시 될 수 있습니다.
 직사각형은 다른 직사각형을 포함 할 수 있으며 내부 직사각형이 외부 직사각형 외부에 표시 (오버플로)되거나 외부 직사각형에 의해 잘 리도록 ( `오버 플로우 : 숨김`사용) 스타일을 지정할 수 있습니다.
 여태까지는 그런대로 잘됐다.
 

직사각형이 주변 직사각형 외부에 표시되지만 한쪽에만 표시되도록하려면 어떻게해야합니까?
 그건 불가능 하죠?
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2021/01/s_ABBFAB2AA570AB265E98074247A5EB7FC24264AF4BCDCA44A89222920DDDE514_1610632717975_Selection_716.png?resize=882%2C474&ssl=1)

아마도 위의 이미지를 볼 때 바퀴가 회전하기 시작합니다. 내부 사각형을 복사하고 절반을 잘라낸 다음 정확히 배치하면 어떨까요?
 그러나 문제가 발생하면 상단에서 오버플로 요소를 선택할 수없고 하단에서 클리핑하도록 선택할 수 없습니다.
 

아니면 할 수 있습니까?
 

### 3D 변환
 

3D 변환을 사용하여 3D 공간에서 요소를 회전, 변환 및 변환 할 수 있습니다.
 다음은 몇 가지 가능성을 보여주는 몇 가지 실용적인 예입니다.
 

3D 변환이 작업을 수행하려면 두 가지 CSS 속성이 필요합니다.
 

- 픽셀 값을 사용하여 3D 효과가 얼마나 뚜렷한 지 결정하는 `원근`
 
- `transform-style : preserve-3d` : 요소를 3D 공간에 배치하도록 브라우저에 지시합니다.
 

3D 변환에 대한 좋은 지원에도 불구하고 슬프게도 3D 변환이 `현장에서`많이 보이지는 않습니다.
 웹 사이트는 여전히 "2D"로 스크롤되는 평면 페이지입니다.
 그러나 3D 변형과 스카우팅 예제를 가지고 놀기 시작했을 때 3D 변형이 진행되는 한 가장 흥미로운 것을 발견했습니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2021/01/s_ABBFAB2AA570AB265E98074247A5EB7FC24264AF4BCDCA44A89222920DDDE514_1610632736598_Selection_630.png?resize=714%2C335&ssl=1)

이미지는 세 개의 평면을 명확하게 보여 주지만이 효과는 단일`<div>`를 사용하여 달성됩니다.
 다른 두 평면은`:: before` 및`:: after` 가상 요소로,`translate ()`를 사용하여 각각 위아래로 이동하여 3D 공간에서 서로 위에 쌓입니다.
 여기서 눈에 띄는 것은 일반적으로 요소 위에 배치되는`:: after` 요소가 해당 요소 뒤에있는 방식입니다.
 제작자는`transform : translateZ (-1px);`를 추가하여이를 달성 할 수있었습니다.
 

이것이 제가 지금까지 본 많은 3D 변환 중 하나 였지만 실제로 3D 공간에 요소를 배치하고 있다는 것을 깨닫게 한 것은 처음이었습니다.
 그렇게 할 수 있다면 요소를 교차시킬 수도 있습니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2021/01/s_ABBFAB2AA570AB265E98074247A5EB7FC24264AF4BCDCA44A89222920DDDE514_1610632744184_Selection_631.png?resize=714%2C335&ssl=1)

이런 일이 얼마나 유용할지 생각할 수 없었지만 그때 Porky Pig 만화 애니메이션을 보았습니다.
 그는 하단 프레임 뒤에서 나오지만 그의 얼굴이 겹치고 같은 프레임의 상단 가장자리 위에 쌓입니다. 이전에 본 것과 똑같은 종류의 클리핑 상황입니다.
 그때부터 내 바퀴가 돌아 가기 시작했습니다.
 CSS만으로 그 효과를 복제 할 수 있습니까?
 그리고 추가 크레딧을 위해 단일`<div>`를 사용하여 복제 할 수 있습니까?
 

나는 놀기 시작했고 비교적 빨리 이것을 보여주었습니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/s_ABBFAB2AA570AB265E98074247A5EB7FC24264AF4BCDCA44A89222920DDDE514_1610632754251_Selection_632.png?resize=692%2C389&ssl=1)

여기에`:: before`와`:: after` 유사 요소가있는 단일`<div>`가 있습니다.
 div 자체는 투명하고`:: before`에는 파란색 테두리가 있고`:: after`는 x 축을 따라 회전되었습니다.
 div에 `perspective`가 있기 때문에 모든 것이 3D로 배치되고, 따라서`:: after `가상 요소는 프레임 상단 가장자리의 테두리 위에 있고 프레임 하단 가장자리의 테두리 뒤에 있습니다.
 .
 

다음은 코드입니다.
 

```css
div {
  transform: perspective(3000px);
  transform-style: preserve-3d;
  position: relative;
  width: 200px;
  height: 200px;
}

div::before {
  content: "";
  width: 100%;
  height: 100%;
  border:10px solid darkblue;
}

div::after {
  content: "";
  position: absolute;
  background: orangered;
  width: 80%;
  height: 150%;
  display: block;
  left: 10%;
  bottom: -25%;
  transform: rotateX(-10deg);
}
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 550px;"><iframe id="cp_embed_ZEpQQdo" src="//codepen.io/anon/embed/ZEpQQdo?height=550&amp;theme-id=1&amp;slug-hash=ZEpQQdo&amp;default-tab=result" height="550" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed ZEpQQdo" title="CodePen Embed ZEpQQdo" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

`관점`을 사용하면 CSS 3D 공간의 `수평선`으로 간주 할 수있는 `z = 0`에서 시청자가 얼마나 멀리 떨어져 있는지 확인할 수 있습니다.
 원근감이 클수록 3D 효과가 덜 두드러지며 그 반대의 경우도 마찬가지입니다.
 대부분의 3D 장면의 경우 500 ~ 1,000 픽셀 사이의 `원근`값이 가장 잘 작동하지만 원하는 정확한 효과를 얻기 위해이 값을 가지고 놀 수 있습니다.
 이것을 원근법과 비교할 수 있습니다. 두 개의 수평선 점을 가깝게 그리면 매우 강한 원근감을 얻을 수 있습니다.
 하지만 멀리 떨어져 있으면 상황이 더 평평 해 보입니다.
 

### 직사각형에서 만화까지
 

직사각형은 재미 있지만 제가 정말로 만들고 싶었던 것은 다음과 같습니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/3QtAnNyg.jpeg?resize=1600%2C1262&ssl=1)

해당 이미지에서 잘 잘라낸 Porky Pig 버전을 찾거나 만들 수 없었지만 Wikipedia 페이지에 멋진 대안이 포함되어 있으므로이를 사용하겠습니다.
 

먼저 이미지를 세 부분으로 분할해야합니다.
 

- `<div>`: Porky 뒤의 파란색 배경
 
- `:: after` : 일종의 터널을 형성하는 모든 빨간색 원
 
- `:: before` : 영광스러운 돼지 자신, 배경 이미지로 설정
 

`<div>`부터 시작하겠습니다.
 이것이 나머지 요소의 배경이자 기초가 될 것입니다.
 또한 이전에 언급 한`perspective` 및`transform-style` 속성과 함께 일부 크기 및 배경색도 포함됩니다.
 

```css
div {
  transform: perspective(3000px);
  transform-style:preserve-3d;
  position: relative;
  width: 200px;
  height: 200px;
  background: #4992AD;
}
```

좋습니다. 다음은 빨간색 원으로 이동하겠습니다.
 요소 자체는 투명해야합니다. 그것이 Porky가 나오는 입구이기 때문입니다.
 그럼 우리는 어떻게할까요?
 이 기사 앞부분의 예제와 같이 테두리를 사용할 수 있지만 테두리가 하나만 있고 단색을 가질 수 있습니다.
 그라디언트를 수용 할 수있는 원이 필요합니다.
 대신`box-shadow`를 사용하여 속성 값에 여러 그림자를 연결할 수 있습니다.
 이를 통해 필요한 모든 원을 얻을 수 있으며, 넓은 확산 반경과 함께 블러 반경 값 `0`을 사용하여 여러 "테두리"모양을 만들 수 있습니다.
 

```css
box-shadow: <x-offset> <y-offset> <blur-radius> <spread-radius> <color>;
```

`<div>`자체만큼 큰`border-radius`를 사용하여`:: before`를 원으로 만듭니다.
 그런 다음 그림자를 추가합니다.
 넓게 퍼진 빨간색 원 몇 개를 추가하고 흐릿한 흰색을 추가하면 Porky의 터널과 매우 유사한 효과를 얻을 수 있습니다.
 

```css
box-shadow: 0 0 20px   0px #fff, 0 0 0  30px #CF331F,
            0 0 20px  30px #fff, 0 0 0  60px #CF331F,
            0 0 20px  60px #fff, 0 0 0  90px #CF331F,
            0 0 20px  90px #fff, 0 0 0 120px #CF331F,
            0 0 20px 120px #fff, 0 0 0 150px #CF331F;
```

여기에 각각 너비가 `30px`인 5 개의 원을 추가합니다.
 각 원에는 단색의 빨간색 배경이 있습니다.
 그리고 그 위에 블러 반경이 `20px`인 흰색 그림자를 사용하여 그라디언트 효과를 만듭니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/s_ABBFAB2AA570AB265E98074247A5EB7FC24264AF4BCDCA44A89222920DDDE514_1610632774234_Selection_629.png?resize=835%2C542&ssl=1)

배경과 원이 정렬 된 상태에서 이제 Porky를 추가하겠습니다.
 지금은 원 위에있는 그가 끝내 길 원하는 지점에 그를 추가하는 것으로 시작하겠습니다.
 

```css
div::before {
  position: absolute;
  content: "";
  width: 80%;
  height: 150%;
  display: block;
  left: 10%;
  bottom: -12%;
  background: url("Porky_Pig.svg") no-repeat center/contain;
}
```

`배경`의 ``중앙 / 포함 ``에 슬래시가 있음을 알 수 있습니다.
 이것이`background` 속기 CSS 속성에서 위치 (`center`)와 크기 (`contain`)를 모두 설정하는 구문입니다.
 슬래시 구문은`<font-size> / <line-height>`와 같이`font-size` 및`line-height`를 설정하는 데 사용되는`font` 축약 형 CSS 속성에서도 사용됩니다.
슬래시 구문은 향후 CSS 버전에서 더 많이 사용됩니다.
 예를 들어 업데이트 된`rgb ()`및`hsl ()`색상 구문은 다음과 같이 슬래시와 불투명도를 나타내는 숫자를 사용할 수 있습니다.`rgb (0 0 0 / 0.5)`.
 이렇게하면`rgb ()`와`rgba ()`간에 전환 할 필요가 없습니다.
 이것은 Internet Explorer 11을 제외한 모든 브라우저에서 이미 작동합니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2021/01/s_ABBFAB2AA570AB265E98074247A5EB7FC24264AF4BCDCA44A89222920DDDE514_1610632781420_Selection_628.png?resize=835%2C542&ssl=1)

여기의 크기와 위치는 모두 약간 임의적이므로 적합하다고 생각되는대로 사용해보십시오.
 우리가 원하는 것에 훨씬 더 가까워졌지만 이제 Porky의 아래쪽 부분이 빨간색 원 뒤에 있고 위쪽 절반이 표시되도록해야합니다.
 

### 트릭
 

3D 공간에서 원과 Porky를 모두 조옮김해야합니다.
 Porky를 회전하려면 충족해야 할 몇 가지 요구 사항이 있습니다.
 

- 그는 배경을 자르면 안됩니다.
 
- 이미지가 왜곡 될 정도로 그를 회전 시키면 안됩니다.
 
- 그의 하체는 빨간색 원 아래에 있어야하고 상체는 그 위에 있어야합니다.
 

Porky가 배경을 자르지 않도록 먼저 원을 Z 방향으로 이동하여 시청자에게 더 가깝게 보이도록합니다.
 `preserve-3d`가 적용 되었기 때문에 약간 확대되었다는 의미이지만 약간만 움직이면 확대 / 축소 효과가 눈에 띄지 않고 배경과 원 사이에 충분한 공간이 생깁니다.
 

```css
transform: translateZ(20px);
```

이제 포키.
 X 축을 중심으로 그를 회전시켜 그의 상체는 우리에게 더 가깝게 움직이고 아랫 부분은 멀어지게합니다.
 다음과 같이 할 수 있습니다.
 

```css
transform: rotateX(-10deg);
```

이것은 처음에는 꽤 나빠 보입니다.
 Porky는 부분적으로 파란색 배경 뒤에 숨겨져 있으며 이상한 방식으로 원을 자르고 있습니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2021/01/s_ABBFAB2AA570AB265E98074247A5EB7FC24264AF4BCDCA44A89222920DDDE514_1610632789083_Selection_626.png?resize=835%2C542&ssl=1)

우리는`translateZ ()`를 사용하여 Porky를 (원으로했던 것처럼) 우리에게 "더 가깝게"움직여서이 문제를 해결할 수 있지만 더 나은 해결책은 회전 점의 위치를 변경하는 것입니다.
 지금은 이미지 중앙에서 발생하여 이미지의 아래쪽 절반이 우리에게서 멀어지게 회전합니다.
 

회전의 시작점을 이미지 아래쪽으로 이동하거나 그 아래로 조금만 이동하면 이미지 전체가 우리쪽으로 회전합니다.
 그리고 우리는 이미 원을 우리에게 더 가깝게 옮겼 기 때문에 모든 것이 정상적으로 보입니다.
 

```css
transform: rotateX(-10deg);
transform-origin: center 120%;
```

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/s_ABBFAB2AA570AB265E98074247A5EB7FC24264AF4BCDCA44A89222920DDDE514_1610632802955_Selection_627.png?resize=835%2C542&ssl=1)

모든 것이 3D에서 어떻게 작동하는지 알아 보려면 다음 펜에서 "show debug"를 클릭하십시오.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 750px;"><iframe id="cp_embed_wvzMMEW" src="//codepen.io/anon/embed/wvzMMEW?height=750&amp;theme-id=1&amp;slug-hash=wvzMMEW&amp;default-tab=result" height="750" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed wvzMMEW" title="CodePen Embed wvzMMEW" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 생기
 

정적 인 이미지를 그대로 유지했다면이 모든 문제를 겪을 필요가 없었을 것입니다.
 하지만 애니메이션을 적용하면 레이어링을 드러내고 효과를 높일 수 있습니다.
 

제가 진행할 애니메이션은 다음과 같습니다. Porky는 원 뒤의 하단에서 작게 시작한 다음 확대되어 빨간색 원 위의 파란색 배경에서 나타납니다.
 그는 거기에 잠시 머물렀다가 다시 돌아옵니다.
 

최상의 성능을 얻기 위해 애니메이션에 `변환`을 사용합니다.
 그리고 우리는 그렇게하기 때문에`rotateX`도 거기에 유지해야합니다.
 

```css
@keyframes zoom {
  0% {
    transform: rotateX(-10deg) scale(0.66);
  }
  40% {
    transform: rotateX(-10deg) scale(1);
  }
  60% {
    transform: rotateX(-10deg) scale(1);
  }
  100% {
    transform: rotateX(-10deg) scale(0.66);
  }
}
```

곧 브라우저가 개별 CSS 속성으로 구현하기 시작 했으므로 곧 다양한 변환을 직접 설정할 수 있습니다.
 이는`rotateX (-10deg)`를 반복하는 것이 결국 불필요하다는 것을 의미합니다.
 하지만 지금은 약간의 중복이 있습니다.
 

`scale ()`함수를 사용하여 확대 / 축소하고 이미`transform-origin `을 설정했기 때문에 이미지의 중앙 하단에서 크기 조정이 이루어지며, 이는 정확히 원하는 효과입니다!
 Porky의 실제 크기의 최대 60 %까지 배율을 애니메이션하고 있으며, 가장 큰 지점에서 약간의 휴식을 취하여 원 프레임에서 완전히 튀어 나옵니다.
 

애니메이션은`:: before` 의사 요소에서 진행됩니다.
 애니메이션을 좀 더 자연스럽게 보이게하기 위해 시작과 끝에서 애니메이션 속도를 늦추는 `이즈 인 아웃`타이밍 기능을 사용하고 있습니다.
 

```css
div::before {
  animation-name: zoom;
  animation-duration: 4s;
  animation-iteration-count: infinite;
  animation-fill-mode:forwards;
  animation-timing-function: ease-in-out;
}
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 650px;"><iframe id="cp_embed_abmddja" src="//codepen.io/anon/embed/abmddja?height=650&amp;theme-id=1&amp;slug-hash=abmddja&amp;default-tab=result" height="650" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed abmddja" title="CodePen Embed abmddja" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 움직임 감소는 어떻습니까?
 

물어봐 주셔서 감사합니다!
 애니메이션에 민감하고 모션 감소를 선호하는 사람들을 위해 `prefers-reduced-motion`미디어 쿼리에 도달 할 수 있습니다.
 전체 애니메이션을 제거하는 대신 축소 된 모션을 선호하고 본격적인 애니메이션보다 더 미묘한 페이드 효과를 사용하는 사용자를 대상으로합니다.
 

```css
@media (prefers-reduced-motion: reduce) {
   @keyframes zoom {
    0% {
      opacity:0;
    }
    100% {
      opacity: 1;
    }
  }

  div::before {
    animation-iteration-count: 1;
  }
}
```

미디어 쿼리 내에서`@ keyframes`를 덮어 쓰면 브라우저가 자동으로 선택합니다.
 이런 식으로 우리는 여전히 원에서 나오는 Porky의 효과를 강조합니다.
 그리고`animation-iteration-count`를`1`로 설정함으로써 우리는 사람들에게 여전히 효과를 볼 수있게했지만 계속되는 움직임을 막기 위해 멈추었습니다.
 

### 마무리
 

이것을 좀 더 재미있게 만들기 위해 우리가 할 수있는 두 가지 더 :
 

- Porky가 나타날 때 커지고 뷰에 더 가깝게 확대되는 것처럼 보이는 그림자를 추가하여 이미지에 더 깊이를 만들 수 있습니다.
 
- 포키가 움직일 때마다 튀어 나오는 효과를 더욱 돋보이게 할 수 있습니다.
 

두 번째 부분은 동일한 애니메이션에서`rotateZ ()`를 사용하여 구현할 수 있습니다.
 쉬운 미풍.
 

그러나 첫 번째 부분에는 추가 트릭이 필요합니다.
 Porky에 이미지를 사용하기 때문에 Porky Pig의 모양이 아닌`:: before` 의사 요소의 상자 주위에 그림자를 만들기 때문에`box-shadow`를 사용할 수 없습니다.
 

여기서`filter : drop-shadow ()`가 구출됩니다.
 요소의 불투명 한 부분을보고 상자 주변 대신에 그림자를 추가합니다.
 

```css
@keyframes zoom {
  0% {
    transform: rotateX(-10deg) scale(0.66);
    filter: drop-shadow(-5px 5px 5px rgba(0,0,0,0));
  }
  40% {
    transform: rotateZ(-10deg) rotateX(-10deg) scale(1);
    filter: drop-shadow(-10px 10px 10px rgba(0,0,0,0.5));
  }

  60% {
    transform: rotateZ(-10deg) rotateX(-10deg) scale(1);
    filter: drop-shadow(-10px 10px 10px rgba(0,0,0,0.5));
  }

  100% {
    transform: rotateX(-10deg) scale(0.66);
    filter: drop-shadow(-5px 5px 5px rgba(0,0,0,0));
  }
}
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 650px;"><iframe id="cp_embed_yLJBymR" src="//codepen.io/anon/embed/yLJBymR?height=650&amp;theme-id=1&amp;slug-hash=yLJBymR&amp;default-tab=result" height="650" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed yLJBymR" title="CodePen Embed yLJBymR" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이것이 제가 Porky Pig의 Looney Tunes 애니메이션을 다시 만든 방법입니다.
 내가 지금 말할 수있는 것은“그게 다 여러분!”입니다.
 