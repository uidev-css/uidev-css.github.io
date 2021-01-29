---
layout: post
title: "SVG에서 UI 구성 요소 만들기
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/11/CleanShot-2020-11-15-at-12.36.14@2x.png
tags: COMPONENTS,REACT,SVG,UX,VUE
---


저는 SVG가 웹에서 인터페이스를 구축하는 전체 세계를 열어 준다고 확신합니다.
 처음에는 SVG를 배우는 것이 어려울 수 있지만 모양을 만들도록 설계된 사양이 있지만 텍스트, 링크 및 아리아 레이블과 같은 요소를 사용할 수 있습니다.
 CSS에서 동일한 효과 중 일부를 수행 할 수 있지만 특히 뷰포트 전체에서 그리고 반응 형 개발을 위해 올바른 위치를 잡는 것이 좀 더 구체적입니다.
 

SVG의 특별한 점은 모든 포지셔닝이 Battleship 게임과 비슷하게 좌표계를 기반으로한다는 것입니다.
 즉, 모든 것이 어디로 가고 어떻게 그려 지는지, 서로 상대적인 방식을 결정하는 것은 정말 간단하게 추론 할 수 있음을 의미합니다.
 CSS 포지셔닝은 레이아웃을위한 것입니다. 문서의 흐름 측면에서 서로 일치하는 것이 있기 때문에 좋습니다.
 이 긍정적 인 특성은 중첩되고 정확하게 배치 된 요소를 사용하여 매우 특수한 구성 요소를 만드는 경우 작업하기가 더 어렵습니다.
 

실제로 SVG를 배우면 무엇이든 그릴 수 있으며 모든 장치에서 크기를 조정할 수 있습니다.
 이 사이트조차도 위의 아바타와 같은 사용자 정의 UI 요소에 SVG를 사용합니다 (메타!).
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/11/CleanShot-2020-11-15-at-14.20.15@2x.png?resize=3282%2C670&ssl=1)

이 게시물에서 SVG에 대한 모든 것을 다루지는 않겠지 만 (여기, 여기, 여기 및 여기에서 이러한 기본 사항 중 일부를 배울 수 있습니다), SVG가 UI 구성 요소 개발을 위해 열 수있는 가능성을 설명하기 위해 한 가지 특정 용도를 살펴 보겠습니다.
 맞춤 제작에 대해 어떻게 생각할지 분석합니다.
 

### 타임 라인 작업 목록 구성 요소
 

최근에 Netlify 팀과 함께 프로젝트를 진행하고있었습니다.
 우리는 시청자가 현재 시청하고있는 과정의 동영상 시리즈 중 어떤 동영상을 시청하고 있는지 보여주고 싶었습니다.
 즉, 우리는 할 일 목록과 같은 것을 만들고 싶었지만 항목이 완료됨에 따라 전반적인 진행 상황을 보여줍니다.
 (우리는 공간을 테마로 한 무료 학습 플랫폼을 만들었는데 정말 멋지네요. 예, 제가 말했습니다.)
 

그 모습은 다음과 같습니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/11/CleanShot-2020-11-17-at-20.30.17.gif?resize=800%2C483&ssl=1)

그럼 우리는 어떻게할까요?
 두 프레임 워크에서 어떻게 작동하는지 볼 수 있도록 Vue와 React에서 예제를 보여 드리겠습니다.
 

### Vue 버전
 

Google은 Dogfood 목적으로 Next.js에서 플랫폼을 만들기로 결정했지만 (예 : Netlify 빌드 플러그인에서 자체 Next를 사용해보기) Vue에 더 능숙하기 때문에 Vue에서 초기 프로토 타입을 작성하고 React로 포팅했습니다.
 

다음은 전체 CodePen 데모입니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_d38f00eada935255c164d4739441a2db" src="//codepen.io/anon/embed/d38f00eada935255c164d4739441a2db?height=450&amp;theme-id=1&amp;slug-hash=d38f00eada935255c164d4739441a2db&amp;default-tab=js,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed d38f00eada935255c164d4739441a2db" title="CodePen Embed d38f00eada935255c164d4739441a2db" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이 코드를 조금 살펴 보겠습니다.
 먼저, 이것은 단일 파일 구성 요소 (SFC)이므로 템플릿 HTML, 반응 스크립트 및 범위가 지정된 스타일이 모두이 하나의 파일에 캡슐화됩니다.
 

각 작업이 완료되었는지 여부를 포함하여 일부 더미 작업을 `데이터`에 저장합니다.
 또한 상태가 완료되었는지 여부를 전환 할 수 있도록 click 지시문에서 호출 할 수있는 메서드를 만들 것입니다.
 

```js
<script>
export default {
  data() {
    return {
      tasks: [
        {
          name: 'thing',
          done: false
        },
        // ...
      ]
    };
  },
  methods: {
    selectThis(index) {
      this.tasks[index].done = !this.tasks[index].done
    }
  }
};
</script>

```

이제 우리가하고 싶은 것은 요소의 양에 따라 유연한`viewBox`가있는 SVG를 만드는 것입니다.
 또한 스크린 리더에게 이것이 프리젠 테이션 요소이며 `timeline`이라는 고유 ID가있는 제목을 제공 할 것임을 알리고 싶습니다.
 (액세스 가능한 SVG 생성에 대한 자세한 정보를 얻으십시오.)
 

```html
<template>
  <div id="app">
    <div>
      <svg :viewBox="`0 0 30 ${tasks.length * 50}`"
           xmlns="http://www.w3.org/2000/svg" 
           width="30" 
           stroke="currentColor" 
           fill="white"
           aria-labelledby="timeline"
           role="presentation">
           <title id="timeline">timeline element</title>
        <!-- ... -->
      </svg>
    </div>
  </div>
</template>
```

`stroke`는 약간의 유연성을 허용하기 위해`currentColor`로 설정됩니다. 구성 요소를 여러 위치에서 재사용하려는 경우 캡슐화 div에서 사용되는`color`를 상속합니다.
 

다음으로 SVG 내부에 작업 목록의 길이 인 수직선을 만들고 싶습니다.
 선은 매우 간단합니다.
 우리는`x1`과`x2` 값 (선이 x 축에 그려지는 곳)과 마찬가지로`y1`과`y2`를 가지고 있습니다.
 

```svg
<line x1="10" x2="10" :y1="num2" :y2="tasks.length * num1 - num2" />
```

x 축은 왼쪽에서 오른쪽이 아닌 아래쪽으로 선을 그리므로 10 개로 일관되게 유지됩니다.
 데이터에 두 개의 숫자를 저장할 것입니다. 간격을 원하는 양 ( `num1`)과 마진을 원하는 양 ( `num2`)입니다.
 

```js
data() {
  return {
    num1: 32,
    num2: 15,
    // ...
  }
}
```

y 축은 끝과 여백에서 빼는`num2`로 시작합니다.
 `tasks.length`는`num1` 인 공백으로 곱해집니다.
 

이제 선에있는 원이 필요합니다.
 각 원은 작업이 완료되었는지 여부를 나타내는 표시기입니다.
 각 작업에 대해 하나의 원이 필요하므로 색인 인 고유 한 `키`와 함께 `v-for`를 사용합니다 (순서가 다시 지정되지 않으므로 여기서 사용하는 것이 안전합니다).
 `click`지시문을 메서드와 연결하고 색인도 매개 변수로 전달합니다.
 

SVG의 CIrcles는 세 가지 속성으로 구성됩니다.
 원의 중앙은 `cx`와 `cy`에 플로팅 된 다음 `r`로 반지름을 그립니다. 선과 마찬가지로 `cx`는 10에서 시작합니다. 반지름은 4입니다.이 축척에서 읽을 수 있기 때문입니다.
 `cy`는 줄과 같이 간격이 지정됩니다. 인덱스 곱하기 간격 (`num1`)에 여백 (`num2`)을 더합니다.
 

마지막으로 `fill`을 설정하기 위해 삼항을 사용합니다.
 작업이 완료되면`currentColor`로 채워집니다.
 그렇지 않은 경우 `흰색`(또는 배경이 무엇이든)으로 채워집니다.
 예를 들어 밝은 원과 어두운 원이있는 배경에서 전달되는 소품으로 채울 수 있습니다.
 

```html
<circle 
  @click="selectThis(i)" 
  v-for="(task, i) in tasks"
  :key="task.name"
  cx="10"
  r="4"
  :cy="i * num1 + num2"
  :fill="task.done ? 'currentColor' : 'white'"
  class="select"/>
```

마지막으로 CSS 그리드를 사용하여 div를 작업 이름과 정렬합니다.
 이는 작업을 반복하는 것과 같은 방식으로 배치되며 완료 상태를 토글하기 위해 동일한 클릭 이벤트에 연결됩니다.
 

```html
<template>
  <div>
    <div 
      @click="selectThis(i)"
      v-for="(task, i) in tasks"
      :key="task.name"
      class="select">
      {{ task.name }}
    </div>
  </div>
</template>
```

## React 버전
 

여기에 우리가 React 버전으로 끝났습니다.
 전체 코드와 해당 내역을 볼 수 있도록 오픈 소싱을 위해 노력하고 있습니다.
 다음은 몇 가지 수정 사항입니다.
 

- 우리는 Vue에서 SCF 대신 CSS 모듈을 사용하고 있습니다.
 
- Next.js 링크를 가져 와서 "완료"상태를 전환하는 대신 Next.js의 동적 페이지로 이동합니다.
 
- 우리가 사용하는 작업은 실제로 과정의 단계 (또는 우리가 부르는 "미션")이며 구성 요소에 의해 유지되는 것이 아니라 여기에 전달됩니다.
 

대부분의 다른 기능은 동일합니다. :)
 

```jsx
import styles from './MissionTracker.module.css';
import React, { useState } from 'react';
import Link from 'next/link';

function MissionTracker({ currentMission, currentStage, stages }) {
 const [tasks, setTasks] = useState([...stages]);
 const num1 = 32;
 const num2 = 15;

 const updateDoneTasks = (index) => () => {
   let tasksCopy = [...tasks];
   tasksCopy[index].done = !tasksCopy[index].done;
   setTasks(tasksCopy);
 };

 const taskTextStyles = (task) => {
   const baseStyles = `${styles['tracker-select']} ${styles['task-label']}`;

   if (currentStage === task.slug.current) {
     return baseStyles + ` ${styles['is-current-task']}`;
   } else {
     return baseStyles;
   }
 };

 return (
   <div className={styles.container}>
     <section>
       {tasks.map((task, index) => (
         <div
           key={`mt-${task.slug}-${index}`}
           className={taskTextStyles(task)}
         >
           <Link href={`/learn/${currentMission}/${task.slug.current}`}>
             {task.title}
           </Link>
         </div>
       ))}
     </section>

     <section>
       <svg
         viewBox={`0 0 30 ${tasks.length * 50}`}
         className={styles['tracker-svg']}
         xmlns="http://www.w3.org/2000/svg"
         width="30"
         stroke="currentColor"
         fill="white"
         aria-labelledby="timeline"
         role="presentation"
       >
         <title id="timeline">timeline element</title>

         <line x1="10" x2="10" y1={num2} y2={tasks.length * num1 - num2} />
         {tasks.map((task, index) => (
           <circle
             key={`mt-circle-${task.name}-${index}`}
             onClick={updateDoneTasks(index)}
             cx="10"
             r="4"
             cy={index * +num1 + +num2}
             fill={
               task.slug.current === currentStage ? 'currentColor' : 'black'
             }
             className={styles['tracker-select']}
           />
         ))}
       </svg>
     </section>
   </div>
 );
}

export default MissionTracker;
```

## 최종 버전
 

여기에서 최종 작업 버전을 볼 수 있습니다.
 

이 구성 요소는 크고 작은 목록, 여러 브라우저 및 반응 형 크기 조정을 수용 할 수있을만큼 유연합니다.
 또한 사용자가 코스 진행 상황을 더 잘 이해할 수 있습니다.
 

그러나 이것은 하나의 구성 요소에 불과합니다.
 노브, 컨트롤, 진행률 표시기, 로더 등 원하는 수의 UI 요소를 만들 수 있습니다.
 CSS 또는 인라인 스타일로 스타일을 지정할 수 있습니다. 소품, 컨텍스트, 반응 형 데이터를 기반으로 업데이트 할 수 있습니다. 한계가 없습니다!
 이것이 웹에서보다 매력적인 UI 요소를 개발할 수있는 방법에 대한 문을 열었 으면합니다.
 