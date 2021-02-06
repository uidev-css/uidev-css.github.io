---
layout: post
title: "Netliify의 Million Devs SVG 애니메이션 사이트 제작"
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/08/CleanShot-2020-08-01-at-16.29.48@2x.png"
tags: SVG ACCESSIBILITY,SVG ANIMATION,VUE COMPONENTS,VUEX STORE
---


다음 글은 Netlifify를 위한 Million Developers 마이크로 사이트 구축 과정을 보여줍니다. 이 프로젝트는 몇몇 사람들에 의해 만들어졌고, 우리는 이 프로젝트를 만드는 과정의 일부를 포착했습니다. 주로 애니메이션에 초점을 맞추고 있습니다. 비슷한 경험을 쌓는 다른 사람들에게 도움이 될 경우를 대비해서 말이죠.

- Million Developer 마이크로사이트 방문
- 깃허브레포

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/08/CleanShot-2020-08-01-at-20.30.04.gif?resize=800%2C505&ssl=1)

## SVG를 통한 Vue App 구축

SVG의 아름다움은 여러분이 생각할 수 있는 것과 좌표계를 전투함의 큰 게임으로 생각할 수 있다는 것입니다. 당신은 x, y, 폭, 높이 면에서 정말 고민하고 있군요.

```html
<div id="app">
   <app-login-result-sticky v-if="user.number" />
   <app-github-corner />

   <app-header />

   <!-- this is one big SVG -->
   <svg id="timeline" xmlns="http://www.w3.org/2000/svg" :viewBox="timelineAttributes.viewBox">
     <!-- this is the desktop path -->
     <path
       class="cls-1 timeline-path"
       transform="translate(16.1 -440.3)"
       d="M951.5,7107..."
     />
     <!-- this is the path for mobile -->
     <app-mobilepath v-if="viewportSize === 'small'" />

     <!-- all of the stations, broken down by year -->
     <app2016 />
     <app2017 />
     <app2018 />
     <app2019 />
     <app2020 />

     <!-- the 'you are here' marker, only shown on desktop and if you're logged in -->
     <app-youarehere v-if="user.number && viewportSize === 'large'" />
   </svg>
 </div>

```

더 큰 앱 컴포넌트 안에 큰 헤더를 가지고 있지만, 보시다시피, 나머지는 하나의 거대한 SVG입니다. 여기서부터, 우리는 거대한 SVG의 나머지 부분을 몇 가지 요소로 분해했습니다.

- Vuex 스토어의 상태로 표시되는 데스크톱 및 모바일용 캔디랜드 유형 경로
- 27개의 역이 있고, 텍스트 역이 포함되지 않으며, 덤불, 나무, 가로등 등 많은 장식 부품들이 있는데, 이는 한 요소에서 추적할 수 있는 것이 많기 때문에 해마다 세분화된다.
- `당신이 여기 있습니다` 마커는 데스크톱에만 표시되며 로그인한 경우에만 표시됩니다.

SVG는 좌표계 내에서 절대적이고 상대적인 모양과 경로를 그릴 수 있을 뿐만 아니라 SVG 내에서도 SVG를 그릴 수 있기 때문에 매우 유연하다. 우리는 단지 그러한 SVG의 x, y, 폭, 높이만 정의하면 되고, 우리는 그것들을 더 큰 SVG 안에 탑재할 수 있는데, 이것은 우리가 이 모든 부품들로 정확히 무엇을 할 것이므로 필요할 때마다 위치를 조정할 수 있다. 구성 요소 내의 <g>는 `그룹`을 의미하며 HTML의 `div`와 약간 비슷하다고 생각할 수 있다.

연도 내 구성 요소는 다음과 같습니다.

```html
<template>
 <g>
   <!-- decorative components -->
   <app-tree x="650" y="5500" />
   <app-tree x="700" y="5550" />
   <app-bush x="750" y="5600" />

   <!-- station component -->
   <app-virtual x="1200" y="6000" xSmall="50" ySmall="15100" />
   <!-- text component, with slots -->
   <app-text
     x="1400"
     y="6500"
     xSmall="50"
     ySmall="15600"
     num="20"
     url-slug="jamstack-conf-virtual"
   >
     <template v-slot:date>May 27, 2020</template>
     <template v-slot:event>Jamstack Conf Virtual</template>
   </app-text>

   ...
 </template>

<script>
...

export default {
 components: {
   // loading the decorative components in syncronously
   AppText,
   AppTree,
   AppBush,
   AppStreetlamp2,
   // loading the heavy station components in asyncronously
   AppBuildPlugins: () => import("@/components/AppBuildPlugins.vue"),
   AppMillion: () => import("@/components/AppMillion.vue"),
   AppVirtual: () => import("@/components/AppVirtual.vue"),
 },
};
...
</script>
```

이러한 구성 요소에서는 다음과 같은 다양한 패턴을 볼 수 있습니다.

- 우리는 소품을 통해 x와 y 값을 통해 주변에 뿌릴 수 있는 장식용 덤불과 나무를 가지고 있다.
- 개별 스테이션 구성 요소를 가질 수 있으며, 두 가지 위치 지정 값도 있습니다. 하나는 크고 작은 장치용입니다.
- 텍스트 구성 요소는 3개의 슬롯, 1개의 날짜, 2개의 다른 텍스트 라인에서 사용할 수 있습니다.
- 장식용 구성품도 동시에 로드하고, 무거운 SVG 스테이션도 비동기식으로 로드하고 있습니다.

## SVG 애니메이션

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/08/CleanShot-2020-08-01-at-17.03.56.gif?resize=714%2C800&ssl=1)

SVG 애니메이션은 GSAP(GreenSock)와 함께 새로운 Scroll Trigger 플러그인으로 수행됩니다. 저는 올해 초 GSAP의 최신 3.0 릴리즈에 대한 작업 지침을 작성했습니다. 이 라이브러리가 익숙하지 않은 경우, 그곳을 시작하는 것이 좋습니다.

플러그인으로 작업하는 것은 매우 간단합니다. 다음은 필요한 기능의 기초입니다.

```js
import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger.js";
import { mapState } from "vuex";

gsap.registerPlugin(ScrollTrigger);

export default {
 computed: {
   ...mapState([
     "toggleConfig",
     "startConfig",
     "isAnimationDisabled",
     "viewportSize",
   ]),
 },
 ...
 methods: {
   millionAnim() {
     let vm = this;
     let tl;
     const isScrollElConfig = {
       scrollTrigger: {
         trigger: `.million${vm.num}`,
         toggleActions: this.toggleConfig,
         start: this.startConfig,
       },
       defaults: {
         duration: 1.5,
         ease: "sine",
       },
     };
   }
 },
 mounted() {
   this.millionAnim();
 },
};

```

먼저, 우리는 Gsap과 필요한 패키지와 Vuex 스토어에서 주를 수입하고 있습니다. ToggleActions와 start(시작) 구성 설정을 스토어에 넣고 각 구성 요소에 전달한 이유는 작업을 하는 동안 UI에서 애니메이션을 트리거하고 싶은 지점을 실험해야 했기 때문에 각 구성 요소를 별도로 구성하지 않아도 되었기 때문입니다.

스토어의 이러한 구성은 다음과 같습니다.

```js
export default new Vuex.Store({
  state: {
    toggleConfig: `play pause none pause`,
    startConfig: `center 90%`,
  }
}
```

이 구성은 다음과 같이 구분됩니다.

- ToggleConfig: 페이지를 지나갈 때 애니메이션을 재생합니다(다시 시작한다고 말하면 다시 트리거됨). 뷰포트를 벗어나면 일시 중지됩니다(이것은 성능 향상에 약간 도움이 될 수 있음). 페이지를 다시 올릴 때 역방향 트리거되지 않습니다.
- startConfig는 요소의 중심이 뷰포트 높이에서 90% 아래로 내려가면 애니메이션이 시작되도록 트리거한다는 것을 나타냅니다.

이 프로젝트를 위해 우리가 결정한 설정들이야, 다른 것도 많아! 이 비디오를 통해 모든 옵션을 이해할 수 있습니다.

이 특정 애니메이션의 경우 스크롤에서 트리거할 필요가 없는 배너 애니메이션이거나 타임라인에서 나중에 트리거할 경우 약간 다르게 처리해야 했습니다. 우리는 소품으로 전달했고, 소품의 숫자에 따라 그 구성을 전달하기 위해 그것을 사용했습니다.

```js
if (vm.num === 1) {
  tl = gsap.timeline({
    defaults: {
      duration: 1.5,
      ease: "sine",
    },
  });
} else {
  tl = gsap.timeline(isScrollElConfig);
}
```

그리고 애니메이션 그 자체에 대해서, 저는 타임라인의 라벨이라고 불리는 것을 사용하고 있습니다. 여러분은 그것을 여러분이 애니메이션이나 기능을 매달아 놓기를 원하는 시점을 플레이헤드에서 식별하는 것과 같이 생각할 수 있습니다. 우리는 라벨에도 숫자 프로펠러를 사용해야 하므로 머리글과 바닥글 구성 요소의 시간대를 구분합니다.

```js
tl.add(`million${vm.num}`)
...
.from(
  "#front-leg-r",
  {
    duration: 0.5,
    rotation: 10,
    transformOrigin: "50% 0%",
    repeat: 6,
    yoyo: true,
    ease: "sine.inOut",
  },
  `million${vm.num}`
)
.from(
  "#front-leg-l",
  {
    duration: 0.5,
    rotation: 10,
    transformOrigin: "50% 0%",
    repeat: 6,
    yoyo: true,
    ease: "sine.inOut",
  },
  `million${vm.num}+=0.25`
);
```

백만장자의 애니메이션에는 많은 일들이 일어나고 있습니다. 그래서 저는 단지 하나의 움직임을 분리해서 분해하려고 합니다. 위에는 소녀들이 다리를 흔들고 있습니다. 우리는 양다리를 따로 흔들고 있고, 양다리는 몇 번이고 반복되고 있고, 요요: 참이라는 말은 GSAP가 내가 다른 모든 변화를 뒤집기를 원한다는 것을 알게 해 준다. 다리를 회전시키고 있지만, 사실적인 것은 원점이 다리의 중앙 상단에서 시작된다는 것입니다. 그래서 원점이 회전할 때 무릎 축을 중심으로 회전합니다:)

## 애니메이션 토글 추가

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/08/animationtoggle.gif?resize=800%2C605&ssl=1)

우리는 사용자에게 전정맥 장애가 있는 경우 애니메이션 없이 사이트를 탐색할 수 있는 능력을 주고 싶었습니다. 그래서 우리는 애니메이션 재생 상태를 위한 토글을 만들었습니다. 토글은 특별한 것이 아닙니다. Vuex 스토어의 상태를 돌연변이를 통해 업데이트합니다.

```js
export default new Vuex.Store({
  state: {
    ...
    isAnimationDisabled: false,
  },
  mutations: {
    updateAnimationState(state) {
      state.isAnimationDisabled = !state.isAnimationDisabled
    },
  ...
})
```

실제 업데이트는 모든 애니메이션과 트리거를 수집한 다음 저장소의 상태를 기준으로 조정하는 최상위 App 구성 요소에서 발생합니다. 우리는 `is animation Disabled` 속성이 변경되는 것을 `보고` 있으며, 변경되면 앱에서 스크롤 트리거 애니메이션의 모든 인스턴스를 캡처합니다. 애니메이션을 .kill(살해)하지 않습니다. 한 가지 옵션만 있다면 다시 시작할 수 없기 때문입니다.

대신 애니메이션이 비활성화된 경우 진행률을 최종 프레임으로 설정하거나, 다시 시작하는 경우 진행률을 0으로 설정하여 페이지에서 실행되도록 설정할 수 있습니다. 여기서 .restart()를 사용했다면 모든 애니메이션이 재생되었을 것이고 페이지를 계속 내려가면서 트리거되는 것을 볼 수 없었을 것입니다. 둘 다 최고야!

```js
watch: {
   isAnimationDisabled(newVal, oldVal) {
     ScrollTrigger.getAll().forEach((trigger) => {
       let animation = trigger.animation;
       if (newVal === true) {
         animation && animation.progress(1);
       } else {
         animation && animation.progress(0);
       }
     });
   },
 },

```

## SVG 내게 필요한 옵션

저는 결코 접근성 전문가가 아니므로, 제가 여기서 실수를 했는지 알려주십시오. 하지만 저는 이 사이트에서 상당한 양의 연구와 테스트를 했고, 보이스오버를 통해 Macbook을 테스트했을 때, 사이트의 관련 정보를 전달할 수 있다는 사실에 매우 흥분했습니다. 그래서 저는 우리가 그곳에 가기 위해 한 일을 공유하고 있습니다.

모든 문제를 해결한 초기 SVG의 경우 화면 판독기가 화면 내에서 통과하도록 역할을 적용하지 않았습니다. 나무와 덤불에는 `role=img`를 적용해 화면 판독기가 생략하고, 보다 세밀한 방송국에는 SVG 내 첫 번째 요소인 `id`와 `di`를 적용했다. 또한 "role="presentation"을 적용했습니다.

```html
<svg
   ...
   role="presentation"
   aria-labelledby="analyticsuklaunch"
 >
   <title id="analyticsuklaunch">Launch of analytics</title>
```

저는 이 많은 것을 헤더 밀리오리시의 글과 레오니 왓슨의 훌륭한 글에서 배웠습니다.

SVG 내의 텍스트는 페이지를 통해 탭하면 저절로 알려지며 링크가 발견되고 모든 텍스트가 읽힙니다. 위에 언급된 슬롯과 함께 텍스트 구성요소는 이렇게 생겼습니다.

```html
<template>
 <a
   :href="`https://www.netlify.com/blog/2020/08/03/netlify-milestones-on-the-road-to-1-million-devs/#${urlSlug}`"
 >
   <svg
     xmlns="http://www.w3.org/2000/svg"
     width="450"
     height="250"
     :x="svgCoords.x"
     :y="svgCoords.y"
     viewBox="0 0 280 115.4"
   >
     <g :class="`textnode text${num}`">
       <text class="d" transform="translate(7.6 14)">
         <slot name="date">Jul 13, 2016</slot>
       </text>
       <text class="e" transform="translate(16.5 48.7)">
         <slot name="event">Something here</slot>
       </text>
       <text class="e" transform="translate(16.5 70)">
         <slot name="event2" />
       </text>
       <text class="h" transform="translate(164.5 104.3)">View Milestone</text>
     </g>
   </svg>
 </a>
</template>

```

다음은 Mac에서 SVG를 탭하면 어떤 소리가 나는지 보여주는 비디오입니다.


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video controls="" src="https://css-tricks.com/wp-content/uploads/2020/08/voiceover-million.mp4" name="fitvid0"></video>
</div>


개선을 위한 추가 제안이 있다면 저희에게 알려주십시오!

- Million Developer 마이크로사이트 방문
- 깃허브레포

코드를 체크아웃하거나 PR 파일을 작성하려는 경우에도 리포는 오픈 소스입니다.

저와 함께 작업한 제 동료 Zach Leatherman과 Hugues Tennier에게 100만 달러(펀이 의도된) 덕분에, 그들의 투입과 작업은 프로젝트에 매우 소중했습니다. 이 작업은 오직 팀워크로부터 그 선을 넘어야 합니다! 그리고 알레한드로 알바레즈(Alejandro Alvarez)에게 많은 존경을 표했습니다. 그리고 멋진 일을 해냈죠. 하이파이브 사방방곡곡. 🙌