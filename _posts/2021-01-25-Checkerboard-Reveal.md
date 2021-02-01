---
layout: post
title: "바둑판 공개
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2021/01/checkerboard-reveal.png
tags: CSS ANIMATION,GRID
---


10 살 때 사촌이 우리 집을 방문했던 것을 기억합니다.
 그는 플로피 디스크에 자체 프로그래밍 된 체스 게임을 가져 오는 멋진 아이였습니다.
 그리고 그의 체스 버전은 움직일 때마다 보드 조각이 사라질 것이기 때문에 그와 마찬가지로 멋졌습니다.
 

더 멋진가요?
 게임 판에서 사라지는 각 조각은 매우 매끄러운 그림을 보여주었습니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2021/01/chess-reveal.jpg?resize=1400%2C1400&ssl=1)

나는 같은 종류의 아이디어가 꽤 매끄러운 UI를 만들 것이라고 생각했습니다.
 단, 배경을 표시하기 위해 사용자 상호 작용을 요구하는 대신 단순히 애니메이션으로 재생할 수 있습니다.
 내가 도착한 곳은 다음과 같습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 1000px;"><iframe id="cp_embed_NWREbov" src="//codepen.io/anon/embed/NWREbov?height=1000&amp;theme-id=1&amp;slug-hash=NWREbov&amp;default-tab=result" height="1000" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed NWREbov" title="CodePen Embed NWREbov" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

아이디어는 매우 간단하고 다른 방법도 많이 있지만 여기에 제가 따라온 토끼 흔적이 있습니다.
 

### 먼저 마크 업을 만들었습니다.
 

이미지는 CSS의`<body>`또는 특정 크기로 설계된 일부`<div>`의 배경으로 처리 할 수 있습니다.
 따라서 아직 처리 할 필요가 없습니다.
 

그러나 바둑판은 흥미 롭습니다.
 그것은 CSS 그리드가 전체에 쓰여진 패턴이므로, 그 안에 다른`<div>`요소가있는 그리드 컨테이너 역할을하는 요소를 사용했습니다.
 합법적 인 체스 판이 얼마나 많은 타일 / 스퀘어 / 무엇을 가지고 있는지 모르겠습니다. 그래서 저는 단지 허공에서 숫자 7을 선택하고 제곱하여 총 49 개의 사각형을 얻었습니다.
 

```html
<div class="grid">
  <div></div>
  <!-- etc. -->
  <div></div>
</div>
```

예, 모든 div를 작성하는 것은 고통이며 JavaScript가 확실히 도움이 될 수 있습니다.
 하지만 실험을하고 있고 개발자의 편의 만 필요하다면 Haml을 사용하는 것이 도움이 될 수 있습니다.
 

```haml
.grid
  - 49.times do
    %div
```

결국 모두 똑같이 나옵니다.
 어느 쪽이든 스타일링을 시작하는 데 필요한 모든 마크 업을 얻었습니다!
 

## 배경 이미지 설정
 

다시 말하지만, 이것이 사용되는 방식에 따라`<body>`또는 다른 요소의`배경 이미지`로 발생할 수 있습니다 (전체 공간을 포함하는 한).
 어쨌든 그리드 컨테이너가 필요했기 때문에 그것을 사용하기로 결정했습니다.
 

```css
.checkerboard {
  background-image: url('walrus.jpg');
  background-size: cover;
  /* Might need other properties to position the image just right */
}
```

그래디언트는 래스터 이미지 파일의 일부이지만`: after`와 같은 의사 요소를 사용하여`<body>`에 일종의 오버레이를 적용 할 수있었습니다.
 이것은 CSS-Tricks의 현재 디자인에서 널리 사용되는 기술입니다.
 

## 그리드 스타일링
 

그리고 예, 저는 CSS Grid를 사용했습니다.
 7x7 그리드를 만드는 것은 그렇게 간단합니다.
 

```css
.checkerboard {
  background-image: url('walrus.jpg');
  background-size: cover;
  display: grid;
  grid-template-columns: repeat(7, 1fr);
  grid-template-rows: repeat(7, 1fr);
} 
 
 

```

적어도 내가 올바르게 이해한다면 `종횡비`가 널리 지원되는 것을 보면 이것이 훨씬 더 나아질 것이라고 생각합니다.
 지금 제가 가진 문제는 그리드가 어떤 비율로도 유지되지 않는다는 것입니다.
 즉, 바둑판의 타일이 모두 다른 뷰포트 크기에서 삐걱 거리는 것처럼 보입니다.
 우우.
 그동안 우리가 할 수있는 작은 일들이 아주 중요하지만 저는 그대로두기로했습니다.
 

### 타일 스타일링
 

흰색과 어두운 회색 음영이 번갈아 표시되므로 다음과 같습니다.
 

```css
.checkerboard > div {
  background-color: #fff;
}
.checkerboard > div:nth-child(even) {
  background-color: #2f2f2f;
}
```

믿거 나 말거나 마크 업과 스타일링이 완료되었습니다!
 남은 건 ...
 

### 타일 애니메이션
 

애니메이션이해야 할 일은 각 타일을`opacity : 1;`에서`opacity : 0;`으로 전환하는 것뿐입니다. CSS 애니메이션은 이에 적합합니다.
 

```css
@keyframes poof {
  to {
    opacity: 0;
  }
}
```

큰!
 시작 키 프레임도 설정할 필요가 없었습니다!
 내가해야 할 일은 타일의 애니메이션을 호출하는 것뿐이었습니다.
 

```css
.checkerboard > div {
  animation-name: poof;
  animation-duration: 0.25s;
  animation-fill-mode: forwards;
  background: #fff;
} 
 
 

```

예, 여기에 `animation`속기 속성을 사용할 수 있었지만 구성 속성을 개별적으로 분리하는 것이 더 쉬운 경우가 많습니다. 왜냐하면… 음, 너무나도 많고, 한 줄로 읽고 식별하기가 어렵 기 때문입니다.
 .
 

여기에 `animation-fill-mode`가 필요한 이유가 궁금하다면 `forwards`로 설정했을 때 애니메이션이 애니메이션의 시작 부분으로 되돌아가는 것을 방지하기 때문입니다.
 즉, 애니메이션이 다시보기로 돌아 오지 않고 완료되면 각 타일이 `opacity : 0;`으로 유지됩니다.
 

타일의 `애니메이션 지연`을 엇갈리게하기 위해 정말 똑똑하고 영리한 일을하고 싶었지만, 벽을 많이 치고 궁극적으로 가벼운 SCSS를 위해 100 % 바닐라 CSS를 사용하기로 결정했습니다.
 이렇게하면 모든 타일을 반복하고 꽤 표준 기능으로 각 타일에 대한 애니메이션을 오프셋 할 수 있습니다.
 그래서 갑작스러운 전환에 대해 죄송합니다!
 그것은 여정의 일부에 불과했습니다.
 

이를 분석해 보겠습니다.
 

- 그리드 열 수 (`$ columns`), 그리드 행 (`$ rows`) 및 총 셀 수 (`$ cells`)에 대한 변수가 있습니다.
 마지막 하나는 처음 두 개를 곱한 결과입니다.
 우리가 항상 완벽한 정사각형 그리드로 작업하고 있다는 것을 안다면 지수가있는 셀 수를 계산하기 위해 약간 리팩토링 할 수 있습니다.
 
- 그런 다음`1`과 총`$ cells` 수 (이 경우 49 개) 사이의 모든 셀 인스턴스에 대해 각 개별 타일은`: nth-child ()`값을 기준으로`animation-delay`를 얻습니다.
 .
 따라서 첫 번째 타일은`div : nth-child (1)`, 그다음`div : nth-child (2)`등입니다.
 데모에서 컴파일 된 CSS를 보면 모든 것이 어떻게 진행되는지 확인할 수 있습니다.
 

```css
.checkerboard > div:nth-child(1) {}
.checkerboard > div:nth-child(2) {}
/* etc. */
```

- 마지막으로 `animation-delay`는 `1`과 `$ cells`사이의 임의의 숫자를 값에 초가 추가 된 `$ columns`수로 나눈 계산입니다.
 이것이 최선의 방법입니까?
 몰라요.
 그것은 약간의 물건을 가지고 놀면서 당신에게“옳은”느낌을주는 것에 착수하는 것으로 귀결됩니다.
 이것은 나에게“옳다”고 느꼈습니다.
 

저는 정말 창의력을 발휘하고 SCSS에 의존하는 대신 CSS 사용자 정의 속성을 사용하고 싶었습니다.
 계산 된 값이 빌드시 컴파일되고 그대로 유지되는 SCSS와 달리 사용자 지정 속성과 값을 클라이언트 측에서 업데이트 할 수 있다는 점이 마음에 듭니다.
 다시 말하지만, 이것이 바로 내가 JavaScript를 대신 사용하고 싶은 유혹이있는 곳입니다.
 하지만 침대를 정리하고 그 안에 눕습니다.
 

이전에 컴파일 된 CSS를 살펴 보았다면 계산 된 값을 보았을 것입니다.
 

```css
/* Yes, Autoprefixer is in there... */
.checkerboard > div:nth-child(1) {
  -webkit-animation-delay: 4.5714285714s;
          animation-delay: 4.5714285714s;
}

.checkerboard > div:nth-child(2) {
  -webkit-animation-delay: 5.2857142857s;
          animation-delay: 5.2857142857s;
}

.checkerboard > div:nth-child(3) {
  -webkit-animation-delay: 2.7142857143s;
          animation-delay: 2.7142857143s;
}

.checkerboard > div:nth-child(4) {
  -webkit-animation-delay: 1.5714285714s;
          animation-delay: 1.5714285714s;
}
```

### 음, 아마도 그 애니메이션은 선택 사항이어야합니다 ...
 

어떤 사람들은 움직임과 움직임에 민감하므로 사용자가 선호하는 경우에만 타일에 스타일과 애니메이션이 적용되도록 항목을 전환하는 것이 좋습니다.
 그것에 대한 미디어 쿼리가 있습니다!
 

```css
@media screen and (prefers-reduced-motion: no-preference) {
  .checkerboard > div {
    animation-name: poof;
    animation-duration: 0.25s;
    animation-fill-mode: forwards;
    background: #fff;
  }
  .checkerboard > div:nth-child(even) {
    background: #2f2f2f;
  }
}
```

### 거기 있습니다!
 

한 번 더 데모입니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 1000px;"><iframe id="cp_embed_NWREbov" src="//codepen.io/anon/embed/NWREbov?height=1000&amp;theme-id=1&amp;slug-hash=NWREbov&amp;default-tab=result" height="1000" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed NWREbov" title="CodePen Embed NWREbov" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>