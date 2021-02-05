---
layout: post
title: "Vue용 폰트형 SVG 아이콘 시스템"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/07/vue-svg-icons.png
tags: SVG ICONS,VUE
---


Vue 앱에서 사용자 지정 아이콘 모음을 관리하는 것은 때때로 어려울 수 있습니다. 아이콘 글꼴은 사용하기 쉽지만 사용자 정의하려면 타사 글꼴 생성기에 의존해야 하며 글꼴은 이진 파일이기 때문에 병합 충돌을 해결하기 어려울 수 있습니다.

대신 SVG 파일을 사용하면 이러한 문제를 해결할 수 있습니다. 하지만 어떻게 하면 아이콘을 쉽게 추가하거나 제거할 수 있을까요?

이상 아이콘 시스템은 다음과 같습니다.

- 아이콘을 추가하려면 아이콘을 지정된 `아이콘` 폴더에 넣기만 하면 됩니다. 아이콘이 더 이상 필요하지 않으면 아이콘을 삭제하기만 하면 됩니다.
- 템플릿에서 rocket.svg 아이콘을 사용하려면 구문이 `=svg-icon="rocket" />처럼 간단합니다.
- 아이콘 글꼴과 같은 CSS 글꼴 크기 및 색상 속성을 사용하여 아이콘 크기를 조정하고 색을 지정할 수 있습니다.
- 페이지에 동일한 아이콘의 인스턴스가 여러 개 나타나면 SVG 코드가 매번 중복되지 않습니다.
- 웹 팩 구성 편집은 필요하지 않습니다.

이것은 두 개의 작은 단일 파일 구성 요소를 작성하여 작성할 것입니다. 이 구현에는 몇 가지 구체적인 요구 사항이 있지만, 많은 마법사들이 다른 프레임워크와 빌드 툴을 위해 이 시스템을 재작업할 수 있을 것입니다.

- 웹 팩: Vue CLI를 사용하여 앱의 비계를 만든 경우 이미 웹 팩을 사용하고 있습니다.
- svg-svg-svg-svg-svg: 이를 통해 SVG 코드를 모두 로드하고 원치 않는 부분을 정리할 수 있습니다. 터미널에서 npm install svg-inline-loader --save-dev를 실행하여 시작하십시오.

### SVG 스프라이트 구성 요소

페이지에 있는 아이콘의 각 인스턴스에 대해 SVG 코드를 반복하지 않아야 하는 우리의 요구 사항을 충족하기 위해, 우리는 SVG "스프라이트"를 구축해야 한다. SVG 스프라이트에 대해 들어본 적이 없다면 다른 SVG가 들어 있는 숨겨진 SVG라고 생각해 보십시오. 아이콘을 표시해야 할 경우, 다음과 같은 `사용` 태그에 있는 아이콘 ID를 참조하여 스프라이트에서 아이콘을 복사할 수 있습니다.

```html
<svg><use xlink:href="#rocket" /></svg>
```

이러한 작은 코드는 본질적으로 우리의 `SvgIcon` 구성 요소가 어떻게 동작할 것인가 하는 것이지만, 먼저 `SvgSprite` 구성 요소를 만들어 봅시다. 여기 전체 SvgSprite가 있습니다.vue 파일: 처음에는 다소 부담스러워 보일 수 있지만, 나는 그것을 모두 분해할 것이다.

```js
<!-- SvgSprite.vue -->

<template>
  <svg width="0" height="0" style="display: none;" v-html="$options.svgSprite" />
</template>

<script>
const svgContext = require.context(
  '!svg-inline-loader?' + 
  'removeTags=true' + // remove title tags, etc.
  '&removeSVGTagAttrs=true' + // enable removing attributes
  '&removingTagAttrs=fill' + // remove fill attributes
  '!@/assets/icons', // search this directory
  true, // search subdirectories
  /\w+\.svg$/i // only include SVG files
)
const symbols = svgContext.keys().map(path => {
  // get SVG file content
  const content = svgContext(path)
   // extract icon id from filename
  const id = path.replace(/^\.\/(.*)\.\w+$/, '$1')
  // replace svg tags with symbol tags and id attribute
  return content.replace('<svg', `<symbol id="${id}"`).replace('svg>', 'symbol>')
})
export default {
  name: 'SvgSprite',
  svgSprite: symbols.join('\n'), // concatenate all symbols into $options.svgSprite
}
</script>
```

템플릿에서 우리의 유일한 `svg` 요소는 그 내용이 `$options.svgSprite`에 바인딩되어 있다. $options에 익숙하지 않은 경우 Vue 구성 요소에 직접 연결된 속성을 포함합니다. 구성 요소 데이터에 svgSprite를 부착할 수도 있었지만, 앱이 구축될 때만 SVG 로더가 실행되기 때문에 Vue가 이에 대한 대응성을 설정할 필요는 없다.

스크립트에서는 `require.context`를 사용하여 모든 SVG 파일을 검색하여 정리합니다. 우리는 `svg-inline-loader`를 호출하고 쿼리 문자열 매개 변수와 매우 유사한 구문을 사용하여 여러 매개 변수를 전달한다. 이해하기 쉽게 여러 줄로 나누었습니다.

```js
const svgContext = require.context(
  '!svg-inline-loader?' + 
  'removeTags=true' + // remove title tags, etc.
  '&removeSVGTagAttrs=true' + // enable removing attributes
  '&removingTagAttrs=fill' + // remove fill attributes
  '!@/assets/icons', // search this directory
  true, // search subdirectories
  /\w+\.svg$/i // only include SVG files
)
```

여기서는 `(/asset/icons)` 특정 디렉터리에 있는 SVG 파일을 정리하여 필요할 때 어디서나 사용할 수 있도록 합니다.

태그 제거 매개 변수는 제목, 스타일 등 아이콘에 필요 없는 태그를 제거합니다. 특히 제목 태그는 원치 않는 툴팁을 유발할 수 있기 때문에 이를 제거하고 싶다. 아이콘에 하드 코딩된 스타일을 유지하려면 추가 매개 변수로 `제거 Tags=tages`를 추가하여 `tags` 태그만 제거됩니다.

우리는 또한 나중에 CSS로 "fill" 색상을 설정할 수 있도록 "fill" 속성을 제거하라고 로더에게 말한다. `채움` 색상은 그대로 사용할 수도 있습니다. 그런 경우 `제거SVGTagAttrs` 및 `제거TagAttrs` 매개 변수를 제거하기만 하면 됩니다.

마지막 로더 매개 변수는 SVG 아이콘 폴더의 경로입니다. 그런 다음 하위 디렉터리를 검색하고 SVG 파일만 로드하도록 두 개의 매개 변수가 더 있는 require.context를 제공한다.

SVG 스프라이트 안에 우리의 모든 SVG 요소를 내포하기 위해, 우리는 그것들을 `svg` 요소에서 SVG `symbol` 요소로 변환해야 한다. 이것은 태그를 변경하고 파일 이름에서 추출한 고유한 `id`를 각자에게 부여하는 것만큼 간단합니다.

```js
const symbols = svgContext.keys().map(path => {
  // extract icon id from filename
  const id = path.replace(/^\.\/(.*)\.\w+$/, '$1')
  // get SVG file content
  const content = svgContext(path)
  // replace svg tags with symbol tags and id attribute
  return content.replace('<svg', `<symbol id="${id}"`).replace('svg>', 'symbol>')
})
```

이 <SvgSprite> 구성 요소는 어떻게 해야 할까요? 페이지에 의존하는 아이콘 앞에 배치합니다. 앱의 상단에 추가하는 것을 추천합니다.vue 파일

```js
<!-- App.vue -->
<template>
  <div id="app">
    <svg-sprite />
<!-- ... -->
```

### 아이콘 구성 요소

이제 `Svg아이콘`을 만들어 보겠습니다.vue 성분

```js
<!-- SvgIcon.vue -->

<template>
  <svg class="icon" :class="{ 'icon-spin': spin }">
    <use :xlink:href="`#${icon}`" />
  </svg>
</template>

<script>
export default {
  name: 'SvgIcon',
  props: {
    icon: {
      type: String,
      required: true,
    },
    spin: {
      type: Boolean,
      default: false,
    },
  },
}
</script>

<style>
svg.icon {
  fill: currentColor;
  height: 1em;
  margin-bottom: 0.125em;
  vertical-align: middle;
  width: 1em;
}
svg.icon-spin {
  animation: icon-spin 2s infinite linear;
}
@keyframes icon-spin {
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(359deg);
  }
}
</style>
```

이 구성 요소는 훨씬 간단합니다. 앞에서 언급한 바와 같이, 우리는 스프라이트 내부의 id를 참조하기 위해 `사용` 태그를 사용한다. 그 `id`는 우리 부품의 `아이콘` 소품에서 나온 것이다.

나는 거기에 .icon-spin 클래스를 선택적 애니메이션 비트로 전환하는 `spin` 소품을 추가했다. 예를 들어, 이것은 스피너 아이콘을 로드하는 데 유용할 수 있습니다.

```html
<svg-icon v-if="isLoading" icon="spinner" spin />
```

필요에 따라 회전 또는 플립과 같은 소품을 추가할 수 있습니다. 원하는 경우 소품을 사용하지 않고 구성 요소에 직접 클래스를 추가할 수 있습니다.

우리 컴포넌트의 콘텐츠 대부분은 CSS입니다. 회전하는 애니메이션을 제외한 대부분의 애니메이션은 SVG 아이콘이 아이콘 폰트인 ➡와 더 비슷하게 동작하도록 하기 위해 사용됩니다. 아이콘을 텍스트 기준선에 맞추기 위해 0.125em의 하단 여백과 함께 `수직 정렬: 중간`을 적용하는 것이 대부분의 경우에 효과가 있다는 것을 발견했다. 우리는 또한 fill 속성 값을 current Color로 설정해서 아이콘에 텍스트와 똑같이 색을 칠할 수 있습니다.

```html
<p style="font-size: 2em; color: red;">
  <svg-icon icon="exclamation-circle" /><!-- This icon will be 2em and red. -->
  Error!
</p>
```

다 됐다! 더 이상 어쩔 수 없다! 아이콘 구성 요소를 필요한 모든 구성 요소로 가져올 필요 없이 앱의 어느 곳에서나 아이콘 구성 요소를 사용하려면 `main.js` 파일에 해당 구성 요소를 등록해야 합니다.

```js
// main.js
import Vue from 'vue'
import SvgIcon from '@/components/SvgIcon.vue'
Vue.component('svg-icon', SvgIcon)
// ...
```

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/07/image-9.png?resize=404%2C289&ssl=1)

### 마지막 생각

다음은 이 솔루션의 접근성을 유지하기 위해 의도적으로 생략한 몇 가지 개선 아이디어입니다.

- 비율을 유지하기 위해 정사각형이 아닌 치수를 갖는 아이콘 크기 조정
- 추가 구성 요소 없이 SVG 스프라이트를 페이지에 삽입합니다.
- Vue 크리에이터 Evan You의 새롭고 빠른(웹 팩이 없는) 빌드 도구인 vite와 함께 사용할 수 있습니다.
- Vue 3 구성 API를 활용합니다.

이러한 구성 요소를 빠르게 전환하려면 기본 vue-cli 템플릿을 기반으로 데모 앱을 만들었습니다. 이것이 앱의 요구에 맞는 구현을 개발하는 데 도움이 되기를 바랍니다!