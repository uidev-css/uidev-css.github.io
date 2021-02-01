---
layout: post
title: "TypeScript와 Svelte 통합"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/12/typescript-svelte-logos.jpg
tags: SVELTE,TYPESCRIPT
---


Svelte는 최신 JavaScript 프레임 워크 중 하나이며 빠르게 인기를 얻고 있습니다.
 템플릿 기반 프레임 워크이지만 템플릿 바인딩 내에서 임의의 JavaScript를 허용하는 프레임 워크입니다.
 간단하고 유연하며 효과적인 뛰어난 반응성 이야기가 있습니다.
 그리고 AOT (Ahead-of-Time) 컴파일 된 프레임 워크로서 매우 인상적인 성능과 번들 크기를 제공합니다.
 이 게시물은 Svelte 템플릿 내에서 TypeScript를 구성하는 데 중점을 둡니다.
 Svelte를 처음 사용하는 경우 소개 튜토리얼 및 문서를 확인하시기 바랍니다.
 

코드를 따르고 싶거나 자신의 프로젝트에서 누락되었을 수있는 것을 디버깅하려는 경우 저장소를 복제 할 수 있습니다.
 제가 다룰 다양한 작품을 보여주기 위해 지점을 설정했습니다.
 

참고 : Svelte와 Typescript를 수동으로 통합 할 예정이지만 그린 필드 프로젝트를 시작하는 경우에도 동일한 작업을 수행하는 공식 Svelte 템플릿 사용을 고려할 수 있습니다.
 어느 쪽이든이 게시물은 템플릿을 사용하더라도 여전히 관련성이있는 TypeScript 구성을 다룹니다.
 

### 기본 TypeScript 및 Svelte 설정
 

기준 설정을 살펴 보겠습니다.
 저장소의`initial-setup` 브랜치로 이동하면 TypeScript를 사용하는 베어 Svelte 프로젝트가 설정되어 있습니다.
 명확하게 말하면 TypeScript는 독립 실행 형`.ts` 파일에서만 작동합니다.
 Svelte에 통합 된 것은 아닙니다.
 TypeScript 통합을 달성하는 것이이 게시물의 목적입니다.
 

주로 Svelte 템플릿에 TypeScript 지원을 추가하기 위해 조금씩 변경하므로 Svelte와 TypeScript가 작동하도록하는 몇 가지 부분을 살펴 보겠습니다.
 

먼저`tsconfig.json` 파일이 있습니다.
 

```js
{
  "compilerOptions": {
    "module": "esNext",
    "target": "esnext",
    "moduleResolution": "node"
  },
  "exclude": ["./node_modules"]
}
```

이 파일은 TypeScript에 최신 JavaScript를 사용하고 노드 해상도를 사용하고 컴파일에서`node_modules`를 제외하고 싶다고 알려줍니다.
 

그런 다음`typings / index.d.ts`에 다음이 있습니다.
 

```js
declare module "*.svelte" {
  const value: any;
  export default value;
}
```

이를 통해 TypeScript가 Svelte와 공존 할 수 있습니다.
 이것이 없으면 TypeScript는 Svelte 파일이 import 문으로로드 될 때마다 오류를 발생시킵니다.
 마지막으로, 우리는 `webpack.config.js`에서이 규칙을 사용하여 Svelte 파일을 처리하도록 webpack에 지시해야합니다.
 

```js
{
  test: /\.(html|svelte)$/,
  use: [
    { loader: "babel-loader" },
    {
      loader: "svelte-loader",
      options: {
        emitCss: true,
      },
    },
  ],
}
```

이 모든 것이 Svelte 구성 요소와 TypeScript 파일을 사용하는 프로젝트의 기본 설정입니다.
 모든 빌드를 확인하려면 두 개의 터미널을 열고 하나에서`npm start`를 실행하여 webpack watch를 시작하고 다른 하나에서는`npm run tscw`를 실행하여 TypeScript watch 작업을 시작합니다.
 두 가지 모두 오류없이 실행되기를 바랍니다.
 TypeScript 검사가 실행 중인지 실제로 확인하려면 다음을 변경할 수 있습니다.
 

```js
let x: number = 12;
```

…`index.ts`에서 :
 

```js
let x: number = "12";
```

… TypeScript 시계에 오류가 나타나는지 확인합니다.
 실제로 이것을 실행하고 싶다면 세 번째 터미널에서`node server`를 실행하고 (동일한 창에있는 탭 내에서 이러한 터미널을 실행할 수있는 iTerm2를 권장합니다)`localhost : 3001`을 누르십시오.
 

### Svelte에 TypeScript 추가
 

TypeScript를 Svelte 구성 요소에 직접 추가 한 다음 작동하도록 구성 변경이 필요한지 살펴 보겠습니다.
 먼저`Helper.svelte`로 이동하여`lang = "ts"`를 스크립트 태그에 추가합니다.
 이는 Svelte에게 스크립트 내부에 TypeScript가 있음을 알려줍니다.
 이제 실제로 TypeScript를 추가해 보겠습니다.
 `export let val : number;`를 통해 숫자로 확인할`val` prop을 변경해 보겠습니다.
 이제 전체 구성 요소는 다음과 같습니다.
 

```jsx
<script lang="ts">
  export let val: number;
</script>

<h1>Value is: {val}</h1>
```

이제 웹팩 창에 오류가 있지만 예상되는 문제입니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_872D76D2AA7F5E97E2477025072F7E7C17C1FB250C8B9FF31D75F08F2CCD4C86_1607053004169_image.png?resize=1236%2C466&ssl=1)

Svelte 로더에게 TypeScript를 처리하는 방법을 알려야합니다.
 다음을 설치하겠습니다.
 

```terminal
npm i svelte-preprocess svelte-check --save
```

이제 webpack 구성 파일로 이동하여`svelte-preprocess`를 가져옵니다.
 

```js
const sveltePreprocess = require("svelte-preprocess");
```

… 그리고 그것을 우리의 svelte-loader에 추가하십시오 :
 

```js
{
  test: /\.(html|svelte)$/,
  use: [
    { loader: "babel-loader" },
    {
      loader: "svelte-loader",
      options: {
        emitCss: true,
        preprocess: sveltePreprocess({})
      },
    },
  ],
}
```

좋습니다. 웹팩 프로세스를 다시 시작하면 빌드됩니다.
 

### 검사 추가
 

지금까지 우리가 빌드했지만 확인하지 않았습니다.
 Svelte 컴포넌트에 유효하지 않은 코드가있는 경우 오류가 발생합니다.
 이제`App.svelte`로 이동하여 동일한`lang = "ts"`를 스크립트 태그에 추가 한 다음`val` prop에 대해 다음과 같이 잘못된 값을 전달합니다.
 

```jsx
<Helper val={"3"} />
```

TypeScript 창을 보면 오류가 없지만 오류가 있어야합니다.
 일반 tsc 컴파일러로 Svelte 템플릿을 입력하지 않고 이전에 설치 한 svelte-check 유틸리티를 사용하는 것으로 나타났습니다.
 TypeScript watch를 중지하고 해당 터미널에서`npm run svelte-check`를 실행하겠습니다.
 이렇게하면 시계 모드에서 svelte-check 프로세스가 시작되고 예상했던 오류가 표시됩니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_872D76D2AA7F5E97E2477025072F7E7C17C1FB250C8B9FF31D75F08F2CCD4C86_1607053629541_image.png?resize=1240%2C684&ssl=1)

이제 `3`주위의 따옴표를 제거하면 오류가 사라집니다.
 

![image](https://paper-attachments.dropbox.com/s_872D76D2AA7F5E97E2477025072F7E7C17C1FB250C8B9FF31D75F08F2CCD4C86_1607053698186_image.png)

산뜻한!
 

실제로는 svelte-check와 tsc가 동시에 실행되기를 원하므로 TypeScript 파일과 Svelte 템플릿에서 두 오류를 모두 포착합니다.
 npm에는이를 수행 할 수있는 유틸리티가 많이 있습니다. 또는 iTerm2를 사용하여 동일한 창에서 여러 터미널을 분할 할 수 있습니다.
 여기서는 서버, webpack 빌드, tsc 빌드 및 svelte-check 빌드를 실행하는 데 사용하고 있습니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_872D76D2AA7F5E97E2477025072F7E7C17C1FB250C8B9FF31D75F08F2CCD4C86_1607053931708_image.png?resize=2106%2C1376&ssl=1)

이 설정은 저장소의 `기본 검사`브랜치에 있습니다.
 

### 누락 된 소품 잡기
 

아직 해결해야 할 문제가 하나 있습니다.
 방금 살펴본`val` 소품과 같은 필수 소품을 생략하면 여전히 오류가 발생하지 않지만`Helper.svelte`에 기본값을 지정하지 않았으므로 오류가 발생하지 않습니다.
 따라서 필요합니다.
 

```jsx
<Helper /> // missing `val` prop
```

TypeScript에 이것을 오류로보고하도록 지시하려면`tsconfig`로 돌아가서 두 개의 새 값을 추가하겠습니다.
 

```js
"strict": true,
"noImplicitAny": false 
```

첫 번째는 기본적으로 비활성화 된 TypeScript 검사를 활성화합니다.
 두 번째 `noImplicitAny`는 이러한 엄격한 검사 중 하나를 해제합니다.
 두 번째 줄이 없으면 유형이없는 변수 (암시 적으로 `any`로 입력 됨)는 이제 오류로보고됩니다 (암시 적 없음, 알겠습니까?).
 

`noImplicitAny`를 `true`로 설정해야하는지 여부에 대한 의견은 크게 다릅니다.
 너무 엄격하다고 생각하지만 많은 사람들이 동의하지 않습니다.
 실험하고 자신의 결론에 도달하십시오.
 

어쨌든 새로운 구성이 적용되면 svelte-check 작업을 다시 시작하고 예상했던 오류를 볼 수 있습니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_872D76D2AA7F5E97E2477025072F7E7C17C1FB250C8B9FF31D75F08F2CCD4C86_1607054476236_image.png?resize=476%2C222&ssl=1)

이 설정은 저장소의 `better-checking`브랜치에 있습니다.
 

### 잡동사니
 

주의해야 할 한 가지는 잘못된 속성을 포착하는 TypeScript의 메커니즘이 즉시 적용되며 해당 구성 요소가`$$ props` 또는`$$ restProps`를 참조하는 경우 구성 요소에 대해 되돌릴 수 없도록 해제된다는 것입니다.
 예를 들어 선언되지 않은 `정크`소품을 Helper 구성 요소에 전달하면 해당 구성 요소에 `정크`속성이 없기 때문에 예상대로 오류가 발생합니다.
 그러나`Helper` 구성 요소가`$$ props` 또는`$$ restProps`를 참조하면이 오류는 즉시 사라집니다.
 전자는 명시적인 선언없이 모든 prop에 동적으로 접근 할 수있게 해주는 반면`$$ restProps`는 선언되지 않은 props에 동적으로 접근하기위한 것입니다.
 

이것은 당신이 그것에 대해 생각할 때 의미가 있습니다.
 이러한 구조의 목적은 일반적으로 일종의 메타 프로그래밍을 위해 즉시 속성에 동적으로 액세스하거나 UI 라이브러리에서 일반적으로 사용되는 html 요소에 속성을 임의로 전달하는 것입니다.
 둘 중 하나의 존재는 선언되지 않았을 수있는 구성 요소에 대한 임의 액세스를 의미합니다.
 

`$$ props`의 또 다른 일반적인 용도는 예약어로 선언 된 props에 액세스하는 것입니다.
 `클래스`가 이에 대한 일반적인 예입니다.
 예를 들면 :
 

```js
const className = $$props.class;
```

…이후:
 

```js
export let class = "";
```

… 유효하지 않습니다.
 `class`는 자바 스크립트의 예약어이지만이 특정 경우에 해결 방법이 있습니다.
 다음은 동일한 소품을 선언하는 유효한 방법이기도합니다.이를 도와 준 Rich Harris에게 감사드립니다.
 

```js
let className;
export { className as class };
```

`$$ props`의 유일한 용도가 이름이 예약 된 prop에 액세스하는 것이라면이 대안을 사용하고 구성 요소에 대해 더 나은 유형 검사를 유지할 수 있습니다.
 

### 이별의 생각
 

Svelte는 제가 함께 작업 한 것 중 가장 유망하고 생산적이며 솔직히 재미있는 JavaScript 프레임 워크 중 하나입니다.
 TypeScript를 추가 할 수있는 상대적인 용이성은 맨 위에 체리와 같습니다.
 TypeScript에서 오류를 조기에 발견하면 생산성을 크게 높일 수 있습니다.
 이 게시물이이를 달성하는 데 도움이 되었기를 바랍니다.
 