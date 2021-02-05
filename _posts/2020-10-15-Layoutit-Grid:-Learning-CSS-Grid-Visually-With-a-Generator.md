---
layout: post
title: "Layoutit Grid: Generator로 CSS 그리드 학습"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/10/layoutit-grid.png
tags: GENERATOR,GRID,LEARNING
---


Layoutit Grid는 대화형 오픈 소스 CSS 그리드 생성기이다. 디자인을 그리고 진행하면서 코드를 볼 수 있습니다. 코드와 상호 작용하고 트랙 라인을 추가하거나 제거하고 트랙 라인을 끌어서 크기를 변경할 수 있습니다. 그러면 CSS와 HTML이 실시간으로 변경되는 것을 볼 수 있습니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/10/post-final.gif?resize=1024%2C576&ssl=1)

레이아웃이 완료되면 코드 펜을 만들거나 코드를 가져와 다음 프로젝트를 시작할 수 있습니다. 이 툴은 코드를 전면에 내세워 직접 작업할 때 CSS 그리드를 학습할 수 있도록 지원합니다.

### CSS Grid는 레이아웃에 대한 완전히 새로운 사고 방식입니다.

이제 웹 경험을 위한 강력한 응답 레이아웃을 만들 수 있습니다. 우리는 마침내 요소를 제자리에 밀어 넣기 위해 해킹 더미를 기억하는 대신 일관된 레이아웃 도구 세트를 사용하여 설계하는 법을 배울 수 있다.

저는 이런 발전기가 우리가 쓰는 코드를 알지 못한다는 것을 변명하는 것이 아닙니다. 우리는 모두 CSS Grid와 Flexbox의 작동 방식을 배워야 한다. 여러분의 아성이 자바스크립트라고 할지라도, 여러분의 아이디어를 전달할 때 CSS 지식의 견고한 토대가 되는 것은 강력한 동맹입니다. 구성 요소, UX 상호 작용 또는 온라인 샌드박스의 알고리즘에 대한 프로토타입을 공유할 때 작업 방식이 크게 달라질 수 있습니다. 적절한 레이아웃을 개발하고 이를 작성하는 스타일을 정의하는 기능은 기본입니다.

CSS에서 레이아웃을 만드는 것은 어려운 작업이 아니어야 한다. CSS Grid는 실제로 사용하기에 꽤 재미있습니다! 예를 들어 명명된 그리드 영역을 사용하는 것은 종이 위에 디자인을 그리는 ASCII 아트 버전처럼 느껴집니다. 사진 앱의 레이아웃, 사진 피드 및 기본 컨텐츠와 일반적인 머리글, 바닥글 및 구성 사이드바를 나란히 만들 수 있습니다.

```css
.photos-app {
  /* For our app layout, lets place things in a grid */
  display: grid;
  /* We want 3 columns and 3 rows, and these are the responsive
     track sizes using `fr` (fraction of the remaining space) */
  grid-template-columns: 20% 1fr 1fr;
  grid-template-rows: 0.5fr 1.7fr 0.3fr;
  /* Let's separate our tracks a bit */
  gap: 1em;
  /* We now have 3x3 cells, here is where each section is placed */
  grid-template-areas:
    "header header header"  /* a header stretching in the top row */
    "config photos people"  /* a left sidebar, and our app content */
    "footer footer footer"; /* and a footer along the bottom row  */
}

.the-header {
  /* In each section, let's define the name we use to refence the area */
  grid-area: "header";
}
```

이것은 CSS Grid로 만들 수 있는 것의 작은 부분집합입니다. 그 규격은 꽤 유연하다. 영역은 라인 번호나 이름을 사용하여 직접 배치하거나 브라우저에 의해 암시적으로 배치될 수 있으며, 콘텐츠가 그리드 내부에 자동으로 분산될 수 있습니다. 그리고 서브그리드와 같은 추가 기능과 함께 사양이 계속 증가하고 있습니다.

동시에, 새로운 사고방식을 필요로 하는 다른 것들과 마찬가지로 그리드를 다루는 일은 어려울 수 있습니다. 이런 일에 머리를 싸매는 데는 많은 시간이 걸린다. 이를 지원하는 한 가지 방법은 다음과 같습니다.

### 재생하는 동안 학습

CSS Grid를 배울 때, CSS Grid의 표기법과 의미론에 겁을 먹기가 쉽다. 당신이 그것을 위한 약간의 근육 기억을 발달시키기 전까지는, 시각적이고 상호 작용적인 도구들로 학습 과정을 시작하는 것은 그 조기 공포를 극복하는 훌륭한 방법이 될 수 있다. 많은 사람들이 그림자, 그라데이션, 마크다운 테이블 등을 만드는 방법을 배우면서 발전기를 사용해 왔습니다. 발전기는 조심해서 만든다면 훌륭한 학습 보조 도구이다.

Layoutit Grid를 사용하여 예에서 동일한 설계를 다시 생성해 보겠습니다.


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video controls="" poster="https://css-tricks.com/wp-content/uploads/2020/10/layoutit-grid-screenshot.png" src="https://css-tricks.com/wp-content/uploads/2020/10/layout-grid-final.mp4" playsinline="" name="fitvid0"></video>
</div>


이와 같은 발전기는 영원히 기댈 수 있는 것이 아닙니다. 그것들은 디딤돌입니다. 이 특별한 기능은 클릭 몇 번으로 디자인을 구체화하여 CSS 그리드의 성능을 경험하게 해 줍니다. 이를 통해 학습 프로세스를 추진하는 데 필요한 초기 승률을 얻을 수 있습니다. 우리들 중 일부에게는 발전기가 도구 상자에 영구적으로 남아 있다. 우리가 손으로 레이아웃을 만드는 방법을 모르기 때문이 아니라 시각적 피드백 루프를 갖는 것이 우리의 아이디어를 코드로 빠르게 변환하는 데 도움이 되기 때문이다. 그래서 우리는 그들과 계속 놀아요.

Sarah Drasner는 또한 체크 아웃할 가치가 있는 CSS Grid 생성기를 만들었습니다.

### 빌딩별 학습

Leniolabs는 최근 Layoutit Grid를 오픈 소스화했으며 대화형 코드 뷰, 영역 에디션, 히스토리 및 오프라인 지원과 같은 새로운 기능을 추가했다. 그리고 제작에는 몇 가지가 더 있습니다.

도구를 개선할 아이디어가 있으면 연락하십시오! 이슈를 열고 GitHub에 대해 논의해 봅시다. 메타 영역으로 들어가면 CSS 그리드 스펙에 대해서도 배울 수 있습니다.

이 앱을 사용하여 성능 대화형 웹 환경을 만드는 데 있어 모범 사례를 추적합니다. 이제 < 구성 요소를 사용하여 새로 출시된 Vue 3에 의해 구동되고 개발 중에 앱을 번들로 제공하지 않는 새로운 개발 도구인 Vite로 구축되어 개발 중에 즉각적인 피드백을 제공합니다. 만약 여러분이 궁금하고 우리와 함께 짓고 싶다면, 레포 포크를 만들고 함께 배워봅시다!