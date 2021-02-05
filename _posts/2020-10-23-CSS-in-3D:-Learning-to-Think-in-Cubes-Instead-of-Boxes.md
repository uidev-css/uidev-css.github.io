---
layout: post
title: "3D CSS: 박스 대신 큐브에서 생각하는 법 배우기"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/10/jhey-workspace.png
tags: 3D,ANIMATIONS,CSS SHAPES,PERSPECTIVE
---


내가 CSS를 배우는 길은 조금 특이했다. 저는 프런트엔드 개발자로 시작하지 않았습니다. 나는 자바 개발자였다. 사실, CSS에 대한 나의 초기 기억은 Visual Studio에서 색들을 고르는 것이었다.

나중에야 비로소 나는 프런트 엔드에 대한 내 사랑을 찾을 수 있었다. 그리고 CSS를 탐구하는 것은 나중에 이루어졌다. CSS3가 이륙할 무렵이였는데 3D와 애니메이션이 블록에서 가장 멋있는 아이들이었습니다. 그들은 거의 내가 CSS를 배울 수 있도록 만들어 주었다. 그들은 나를 끌어들였고 레이아웃, 색상 등과 같은 다른 것들보다 CSS에 대한 나의 이해를 더 구체화했다.

저는 1분 동안 3D CSS의 모든 것을 하고 있습니다. 여러분이 많은 시간을 보내는 모든 것과 마찬가지로, 여러분은 결국 그 기술을 연마하면서 수년간 여러분의 과정을 다듬게 됩니다. 이 기사는 제가 현재 어떻게 3D CSS에 접근하고 있는지 살펴보고 여러분에게 도움이 될 만한 몇 가지 팁과 요령에 대해 살펴보는 기사입니다!

### 모든 것은 입체적이다.

대부분의 경우, 우리는 정육면체를 사용할 수 있습니다. 우리는 확실히 더 복잡한 모양을 만들 수 있지만, 그것들은 보통 조금 더 많은 것을 고려합니다. 곡선은 특히 단단하고 곡선을 처리하는 데 몇 가지 요령이 있습니다(그러나 나중에 추가).

우리는 CSS에서 큐보이드 만드는 방법에 대해 이야기하지 않을 것입니다. Ana Tudor의 게시물을 참조하거나, 제가 만든 스크린캐스트를 확인할 수 있습니다.


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video controls="" src="https://css-tricks.com/wp-content/uploads/2020/10/use-css-transforms-to-create-configurable-3d-cuboids.mp4" playsinline="" name="fitvid0"></video>
</div>


그 중심에서, 우리는 하나의 원소를 이용하여 큐비오이드로 감싸고 그 안에 있는 6개의 원소를 변형시킵니다. 각 원소는 우리 입방체의 한 변으로 작용한다. 우리가 `변형 방식: 보존-3d`를 적용하는 것이 중요하다. 그리고 어디에나 그것을 바르는 것도 나쁘지 않다. 상황이 더 복잡해지면 우리는 중첩된 큐빅을 다룰 것입니다. 브라우저 간에 깡충깡충 뛰면서 누락된 `변형식`을 디버깅하는 것은 고통스러울 수 있다.

```css
* { transform-style: preserve-3d; }
```

몇 개 이상의 얼굴을 가진 3D 창작물을 위해 큐보이드로 만들어진 전체 장면을 상상해 보십시오. 실제 예를 들어, 3D 책의 이 데모를 생각해 보십시오. 네 칸짜리야. 표지에 한 장씩, 척추에 한 장씩, 페이지에 한 장씩. 배경 이미지 활용이 우리에게 남은 몫이다.

### 장면 설정

우리는 큐빅을 레고 조각처럼 사용할 것입니다. 하지만, 우리는 장면을 설정하고 비행기를 만들어 우리의 삶을 조금 더 쉽게 만들 수 있습니다. 그 평면은 우리의 창조물이 앉을 곳이고 우리가 전체 창조물을 회전시키고 이동시키는 것을 더 쉽게 만듭니다.

저는 씬(scene)을 생성할 때 X축과 Y축에서 먼저 회전하는 것을 좋아합니다. 그리고 나서 나는 그것을 `회전제 X(90도)`로 평평하게 했다. 그런 식으로, 장면에 새로운 큐빅을 추가하고 싶을 때 평면 요소 안에 추가합니다. 여기서 제가 할 또 다른 일은 모든 큐빅에 절대적인 위치를 설정하는 것입니다.

```css
.plane {
  transform: rotateX(calc(var(--rotate-x, -24) * 1deg)) rotateY(calc(var(--rotate-y, -24) * 1deg)) rotateX(90deg) translate3d(0, 0, 0);
}
```

### 보일러 플레이트부터 시작

다양한 크기의 큐보이드와 평면을 가로지르는 큐보이드 생성은 각 생성물에 대해 많은 반복을 만듭니다. 이러한 이유로, 저는 퍼그를 사용하여 믹신을 통해 큐빅을 만듭니다. 퍼그에 대해 잘 모르시는 분은 제가 5분짜리 소개서를 작성했습니다.

일반적인 장면은 다음과 같습니다.

```pug
//- Front
//- Back
//- Right
//- Left
//- Top
//- Bottom
mixin cuboid(className)
  .cuboid(class=className)
    - let s = 0
    while s < 6
      .cuboid__side
      - s++
.scene
  //- Plane that all the 3D stuff sits on
  .plane
    +cuboid('first-cuboid')
```

CSS에 대해서는요. 큐보이드 클래스는 현재 다음과 같습니다.

```css
.cuboid {
  // Defaults
  --width: 15;
  --height: 10;
  --depth: 4;
  height: calc(var(--depth) * 1vmin);
  width: calc(var(--width) * 1vmin);
  transform-style: preserve-3d;
  position: absolute;
  font-size: 1rem;
  transform: translate3d(0, 0, 5vmin);
}
.cuboid > div:nth-of-type(1) {
  height: calc(var(--height) * 1vmin);
  width: 100%;
  transform-origin: 50% 50%;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%) rotateX(-90deg) translate3d(0, 0, calc((var(--depth) / 2) * 1vmin));
}
.cuboid > div:nth-of-type(2) {
  height: calc(var(--height) * 1vmin);
  width: 100%;
  transform-origin: 50% 50%;
  transform: translate(-50%, -50%) rotateX(-90deg) rotateY(180deg) translate3d(0, 0, calc((var(--depth) / 2) * 1vmin));
  position: absolute;
  top: 50%;
  left: 50%;
}
.cuboid > div:nth-of-type(3) {
  height: calc(var(--height) * 1vmin);
  width: calc(var(--depth) * 1vmin);
  transform: translate(-50%, -50%) rotateX(-90deg) rotateY(90deg) translate3d(0, 0, calc((var(--width) / 2) * 1vmin));
  position: absolute;
  top: 50%;
  left: 50%;
}
.cuboid > div:nth-of-type(4) {
  height: calc(var(--height) * 1vmin);
  width: calc(var(--depth) * 1vmin);
  transform: translate(-50%, -50%) rotateX(-90deg) rotateY(-90deg) translate3d(0, 0, calc((var(--width) / 2) * 1vmin));
  position: absolute;
  top: 50%;
  left: 50%;
}
.cuboid > div:nth-of-type(5) {
  height: calc(var(--depth) * 1vmin);
  width: calc(var(--width) * 1vmin);
  transform: translate(-50%, -50%) translate3d(0, 0, calc((var(--height) / 2) * 1vmin));
  position: absolute;
  top: 50%;
  left: 50%;
}
.cuboid > div:nth-of-type(6) {
  height: calc(var(--depth) * 1vmin);
  width: calc(var(--width) * 1vmin);
  transform: translate(-50%, -50%) translate3d(0, 0, calc((var(--height) / 2) * -1vmin)) rotateX(180deg);
  position: absolute;
  top: 50%;
  left: 50%;
}
```

기본적으로 다음과 같은 것이 있습니다.

### CSS 변수에 의해 작동됨

CSS 변수(사용자 지정 속성이라고도 함)가 상당히 적습니다. 이것은 큰 시간 절약이다. CSS 변수로 큐보이드 전원을 켜고 있어요.

- `--폭`: 평면에 있는 입방체의 너비
- `--높이`: 평면에서의 입방체의 높이
- `--깊이`: 평면의 입방체의 깊이
- -x: 비행기의 X 위치
- Y자: 비행기의 Y자세

저는 모든 것에 반응하기 위해 "vmin"을 주로 사이징 단위로 사용합니다. 스케일링할 무언가를 만든다면, 대응 가능한 유닛을 만들 수 있을 것입니다. 우리는 이전 기사에서 이 기법을 언급했습니다. 다시, 나는 비행기를 평평하게 눕혔다. 이제 저는 제 큐빅을 높이, 너비, 깊이가 있다고 말할 수 있습니다. 이 데모에서는 치수를 변경하면서 평면 주위를 큐비오이드로 이동하는 방법을 보여줍니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_BaKqQLJ" src="//codepen.io/anon/embed/BaKqQLJ?height=450&amp;theme-id=1&amp;slug-hash=BaKqQLJ&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed BaKqQLJ" title="CodePen Embed BaKqQLJ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### dat으로 디버깅하고 있습니다.GUI

오른쪽 상단에 있는 작은 패널로 저희가 다룬 데모 중 일부를 보실 수 있습니다. 바로 데이터입니다.GUI. 자바스크립트용 경량 컨트롤러 라이브러리로 3D CSS 디버깅에 매우 유용합니다. 코드가 많지 않으면 실행 시 CSS 변수를 변경할 수 있는 패널을 설정할 수 있습니다. 제가 하고 싶은 일 중 하나는 X축과 Y축의 평면을 회전시키는 것입니다. 이렇게 하면 처음에 보이지 않을 수 있는 부분에서는 어떻게 사물이 정렬되어 있는지 또는 작동되는지 확인할 수 있습니다.

```js

const {
  dat: { GUI },
} = window
const CONTROLLER = new GUI()
const CONFIG = {
  'cuboid-height': 10,
  'cuboid-width': 10,
  'cuboid-depth': 10,
  x: 5,
  y: 5,
  z: 5,
  'rotate-cuboid-x': 0,
  'rotate-cuboid-y': 0,
  'rotate-cuboid-z': 0,
}
const UPDATE = () => {
  Object.entries(CONFIG).forEach(([key, value]) => {
    document.documentElement.style.setProperty(`--${key}`, value)
  })
}
const CUBOID_FOLDER = CONTROLLER.addFolder('Cuboid')
CUBOID_FOLDER.add(CONFIG, 'cuboid-height', 1, 20, 0.1)
  .name('Height (vmin)')
  .onChange(UPDATE)
CUBOID_FOLDER.add(CONFIG, 'cuboid-width', 1, 20, 0.1)
  .name('Width (vmin)')
  .onChange(UPDATE)
CUBOID_FOLDER.add(CONFIG, 'cuboid-depth', 1, 20, 0.1)
  .name('Depth (vmin)')
  .onChange(UPDATE)
// You have a choice at this point. Use x||y on the plane
// Or, use standard transform with vmin.
CUBOID_FOLDER.add(CONFIG, 'x', 0, 40, 0.1)
  .name('X (vmin)')
  .onChange(UPDATE)
CUBOID_FOLDER.add(CONFIG, 'y', 0, 40, 0.1)
  .name('Y (vmin)')
  .onChange(UPDATE)
CUBOID_FOLDER.add(CONFIG, 'z', -25, 25, 0.1)
  .name('Z (vmin)')
  .onChange(UPDATE)
CUBOID_FOLDER.add(CONFIG, 'rotate-cuboid-x', 0, 360, 1)
  .name('Rotate X (deg)')
  .onChange(UPDATE)
CUBOID_FOLDER.add(CONFIG, 'rotate-cuboid-y', 0, 360, 1)
  .name('Rotate Y (deg)')
  .onChange(UPDATE)
CUBOID_FOLDER.add(CONFIG, 'rotate-cuboid-z', 0, 360, 1)
  .name('Rotate Z (deg)')
  .onChange(UPDATE)
UPDATE()
```

만약 당신이 이 트윗에서 시간 경과 비디오를 본다면. 장면을 만들면서 내가 비행기를 많이 회전시킨다는 것을 알 수 있을 것이다.

그 데이터.GUI 코드가 약간 반복됩니다. 우리는 구성을 취하고 컨트롤러를 생성하는 기능을 만들 수 있습니다. 당신의 요구를 충족시키기 위해서는 약간의 손놀림이 필요하다. 저는 이 데모에서 동적으로 생성된 컨트롤러로 게임을 시작했습니다.

### 센터링

기본적으로 각 입방체는 평면 아래 절반과 위쪽에 있습니다. 의도적이네요. 이것도 제가 최근에 시작한 일입니다. 왜죠? 왜냐하면 우리는 큐보이드들의 함유된 요소를 큐보이드 중심부로 사용하고 싶기 때문입니다. 이것은 애니메이션을 더 쉽게 만듭니다. 특히, 우리가 Z축을 중심으로 회전하는 것을 고려한다면요. 나는 이것을 "CSS is Cake"를 만들 때 알게 되었다. 케이크를 만든 후, 저는 각각의 조각들이 상호작용을 하는 것을 원한다고 결심했습니다. 그 후 저는 되돌아가서 플립 슬라이스의 회전 중심을 고정하기 위해 제 구현을 변경해야 했습니다.

여기서 저는 이 데모에 대해 자세히 설명했습니다. 센터와 오프셋 센터를 갖는 것이 데모에 어떤 영향을 미치는지 말이죠.

### 포지셔닝

좀 더 복잡한 장면을 작업한다면, 다른 부분으로 나눌 수도 있습니다. 여기가 바로 서브플레인의 개념이 유용한 곳입니다. 개인 작업 공간을 다시 만든 데모를 생각해 보십시오.

여기 꽤 많은 일들이 일어나고 있고 모든 큐빅을 추적하는 것은 어렵습니다. 이를 위해, 우리는 서브플레인을 소개할 수 있다. 그 데모 좀 분해해 봅시다. 그 의자는 자체 보조 비행기가 있다. 따라서 다른 어떤 것에도 영향을 주지 않고 씬(scene)을 쉽게 이동하고 회전할 수 있습니다. 사실, 우리는 발을 움직이지 않고도 팽이를 돌릴 수 있어요!

### 미학

일단 구조를 잡으면, 미학을 연구할 때입니다. 이 모든 것은 여러분이 무엇을 만드느냐에 달려 있습니다. 하지만 여러분은 특정한 기술을 사용함으로써 몇 가지 빠른 승리를 얻을 수 있습니다. 저는 처음에는 못생긴 것으로 시작해서 다시 돌아가서 모든 색상에 맞는 CSS 변수를 만들어서 적용하는 편이에요. 특정 사물에 대한 세 가지 색조는 우리가 육면체의 측면을 시각적으로 구별할 수 있게 해줍니다. 이 토스터의 예를 들어보자. 3가지 색조가 토스터의 측면을 덮습니다.

아까의 Pug mixin을 사용하면 큐보이드 클래스 이름을 정의할 수 있습니다. 측면에 색상을 적용하면 대개 다음과 같은 모양이 됩니다.

```css
/* The front face uses a linear-gradient to apply the shimmer effect */
.toaster__body > div:nth-of-type(1) {
  background: linear-gradient(120deg, transparent 10%, var(--shine) 10% 20%, transparent 20% 25%, var(--shine) 25% 30%, transparent 30%), var(--shade-one);
}
.toaster__body > div:nth-of-type(2) {
  background: var(--shade-one);
}
.toaster__body > div:nth-of-type(3),
.toaster__body > div:nth-of-type(4) {
  background: var(--shade-three);
}
.toaster__body > div:nth-of-type(5),
.toaster__body > div:nth-of-type(6) {
  background: var(--shade-two);
}
```

Pug mixin에 추가 요소를 포함시키는 것은 좀 어렵습니다. 하지만 잊지말자, 우리 정육면체의 모든 면에 두 개의 유사 요소가 있다는 것을. 우리는 이것을 다양한 디테일에 사용할 수 있습니다. 예를 들어 토스터 슬롯과 측면의 핸들 슬롯은 유사 요소입니다.

세부 정보를 추가하기 위해 배경 이미지를 활용하는 것도 방법이다. 예를 들어, 3D 작업 공간을 고려하십시오. 배경 레이어를 사용하여 음영을 생성할 수 있습니다. 실제 이미지를 사용하여 질감 있는 표면을 만들 수 있습니다. 마루와 깔개는 반복되는 배경 이미지다. 사실, 텍스처에 의사 요소를 사용하는 것은 매우 좋다. 왜냐하면 필요하다면 타일 이미지를 회전하는 것처럼 변환할 수 있기 때문이다. 저는 또한 어떤 경우에는 정육면체 측과 직접적으로 일하면서 깜빡이는 경우도 있다는 것을 발견했습니다.

질감을 위해 이미지를 사용하는 것의 한 가지 문제는 우리가 어떻게 다른 색조를 만드는가 하는 것입니다. 우리는 서로 다른 면을 구별하기 위해 음영이 필요하다. 필터 속성이 여기에 도움이 될 수 있습니다. 입방체의 다른 면에 밝기() 필터를 적용하면 밝기가 가벼워지거나 어두워질 수 있다. 이 CSS 플립 테이블을 고려하십시오. 모든 표면은 텍스처 이미지를 사용합니다. 그러나 측면을 구별하기 위해 밝기 필터가 적용됩니다.

### 스모크 및 미러 관점

유한한 요소 집합을 사용하여 불가능해 보이는 모양을 만드는 것은 어떨까요? 때때로 우리는 작은 교묘한 속임수로 눈을 속일 수 있다. 우리는 3D 감각과 같은 "가짜"를 제공할 수 있습니다. Zdog 라이브러리는 이것을 잘 하고 이것의 좋은 예이다.

이 풍선 뭉치를 생각해 보세요. 현을 고정하는 문자열은 정확한 원근법을 사용하며 각 문자열은 자체 회전, 기울기 등을 갖습니다. 하지만 풍선 자체는 평평합니다. 우리가 평면을 회전시키면, 풍선은 평면의 회전을 유지합니다. 그리고 이것은 "가짜" 3D 인상을 줍니다. 데모를 테스트하고 카운터를 끕니다.

때때로 그것은 틀에 박히지 않은 사고를 필요로 한다. 3D 작업 공간을 만들면서 하우스 플랜트를 제안받았습니다. 방에 몇 개 있어요. 처음에 생각한 것은, "아니, 네모난 냄비를 만들 수 있는데, 어떻게 모든 잎을 만들 수 있을까?"였습니다. 사실, 이것도 눈속임으로 할 수 있어요. 나뭇잎이나 식물의 주식 이미지를 잡으세요. remove.bg과 같은 도구로 배경을 제거하세요. 그런 다음 여러 이미지를 동일한 위치에 배치하고 각 이미지를 특정 양만큼 회전시킵니다. 자, 그것들이 회전할 때, 우리는 3D 공장의 느낌을 받습니다.

### 어색한 모양에 대처

어색한 모양은 일반적인 방법으로 덮기 어렵다. 모든 창조물에는 고유의 장애물이 있다. 하지만, 여러분이 문제를 해결하는 아이디어를 내는 데 도움이 될 수 있는 몇 가지 예가 있습니다. 나는 최근에 레고 인터페이스 패널의 UX에 관한 기사를 읽었다. 사실, 3D CSS 작업에 레고 세트처럼 접근하는 것도 나쁘지 않습니다. 그러나 LEGO 인터페이스 패널은 CSS로 만들 수 있는 모양입니다(스터드 제외). 저는 최근에야 이 패널을 이렇게 불렀습니다). 그건 큐비오이드로 시작하죠. 그런 다음 상단 표면을 자르고, 끝 면을 투명하게 만들고, 의사 요소를 회전시켜 결합할 수 있습니다. 우리는 의사 요소를 사용하여 일부 배경 레이어로 세부 정보를 추가할 수 있다. 아래 데모에서 와이어 프레임을 켜고 끄십시오. 만약 우리가 얼굴의 정확한 높이와 각도를 원한다면, 우리는 가설 사용 등을 위해 약간의 수학을 사용할 수 있습니다.

커버하기 곤란한 또 다른 것은 커브이다. 구형 모양은 CSS 휠 하우스에 없습니다. 이 시점에서 우리는 다양한 옵션을 가지고 있다. 한 가지 방법은 그 사실을 받아들이고 한정된 수의 변을 가진 다각형을 만드는 것입니다. 또 하나는 둥근 모양을 만들고 식물과 함께 우리가 언급한 회전 방법을 사용하는 것입니다. 각 옵션이 작동할 수 있습니다. 하지만 다시 말하지만, 이것은 사용 사례에 기초하고 있습니다. 각각 장단점이 있다. 폴리곤을 사용하면 곡선을 포기하거나 원소를 너무 많이 사용하므로 거의 곡선에 가깝습니다. 후자의 경우 성능 문제가 발생할 수 있습니다. 관점의 트릭으로 인해 성능 문제가 발생할 수도 있습니다. 우리는 또한 모양이 없는 "측면"을 스타일링할 수 있다는 것 또한 포기한다.

### Z 파이팅

마지막으로, "Z-fighting"에 대해 언급할 가치가 있습니다. 이는 평면의 특정 요소가 겹치거나 바람직하지 않은 깜박임을 유발할 수 있는 부분이다. 이것의 좋은 예를 들기는 어렵습니다. 그것에 대한 일반적인 해결책은 없다. 그것은 사안별로 해결해야 할 문제이다. 주요 전략은 DOM에서 적절하게 물건을 주문하는 것입니다. 하지만 때때로 그것만이 문제가 아니다.

정확하다는 것은 때때로 문제를 일으킬 수 있다. 3D 작업 공간을 다시 한 번 살펴보겠습니다. 벽에 있는 캔버스를 생각해 보세요. 그림자는 유사 요소이다. 만약 우리가 캔버스를 벽에 정확히 대어 놓는다면, 우리는 쟁점들에 부딪힐 것이다. 그렇게 하면 그림자와 벽이 앞자리를 차지하기 위해 싸울 거예요. 이를 극복하기 위해 우리는 사물을 조금씩 번역할 수 있다. 그렇게 하면 문제가 해결되고 무엇이 앞에 앉아야 하는지를 선언할 수 있다.

"캔버스 오프셋"을 켜고 끈 상태에서 데모 크기를 조정해 보십시오. 오프셋이 없을 때 그림자가 깜박이는 것을 알 수 있습니까? 그림자와 벽이 시야를 다투고 있기 때문이다. 오프셋은 --x를 "--cm"로 명명된 "1vmin"의 분수로 설정합니다. 그것은 그 창작에 사용되는 반응성 단위입니다.

### 바로 그거예요!

CSS를 다른 차원으로 이동합니다. 몇 가지 팁을 사용하여 직접 만들고 공유하며 3D 창작물을 공유하십시오! 네, CSS로 3D를 만드는 것은 힘들 수 있고 우리가 진행하면서 분명히 다듬을 수 있는 과정입니다. 사람마다 다른 접근방식이 효과가 있고 인내는 필수 요소이다. 난 네가 어디서 접근하는지 보고 싶어!

가장 중요한 것? 재미있게 놀아!