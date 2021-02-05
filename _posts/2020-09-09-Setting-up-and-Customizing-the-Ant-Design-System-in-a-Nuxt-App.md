---
layout: post
title: "NuxT App에서 Ant Design 시스템 설정 및 사용자 정의"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/09/ant-design-vue.jpg
tags: ANT DESIGN,LESS,NUXT,VUE
---


UI 라이브러리는 번거롭고 재정의하기 어려우며, 이로 인해 더부룩해질 수 있기 때문에 저는 일반적으로 UI 라이브러리를 사용하지 않습니다. 하지만 Ant Design은 사용하기 쉽고, 기본값이 확장되며, 섬세한 디자인이 특징이기 때문에 최근에 제 애정을 좀 얻고 있습니다.

Nuxt와 Ant Design은 Nuxt의 새로운 정적 대상 배포 옵션은 말할 것도 없고 부분적으로 Nuxt의 코드 분할 및 트리 흔들기 기능 때문에 함께 잘 작동한다. 나는 Ant Design을 사용하여 우수한 성능 점수로 앱을 서비스할 수 있습니다.

둘을 결합하는 것은 좀 까다로웠고 그것을 어떻게 하는지에 대한 문서 작성에 많은 방해가 되지 않기 때문에, 당신이 그것을 설정하는 데 필요한 단계는 다음과 같다. 시작하겠습니다!

### Ant. 디자인 설치

첫 번째 단계는 Less.js 및 Less-loader와 함께 ant-design-vue 패키지를 설치하는 것입니다. 이 패키지는 Less 변수를 생성해야 합니다.

```
yarn add ant-design-vue less less-loader
# or
npm i ant-design-vue less less-loader
```

이제 Nux에게 플러그인을 통해 전세계적으로 사용하라고 전달하겠습니다. `antd-ui.js`라는 파일을 만듭니다.

```js
import Vue from 'vue'
import Antd from 'ant-design-vue/lib'

Vue.use(Antd)
```

Ant Design 시작 가이드에 설명된 프로세스와 달리, 우리는 그들이 언급한 글로벌 CSS 파일을 가져오지 않습니다. 그 이유는 기본 변수 Less 파일을 수동으로 가져와 재정의할 수 있기 때문입니다.

우리는 `nux.config.js` 파일에 몇 가지 할 일이 있습니다. 먼저 방금 만든 플러그인을 등록하겠습니다.

```js
plugins: ["@/plugins/antd-ui"],
```

다음으로, 웹 팩에 Less:를 빌드하고 싶다는 것을 알립니다.

```js
build: {
   loaders: {
     less: {
       lessOptions: {
         javascriptEnabled: true,
       },
    },
  },
}
```

마지막으로 Ant Design의 기본값과 재정의 값을 가져오는 변수에 대한 글로벌 스타일시트를 생성해야 합니다.

```js
css: [
  "~/assets/variables.less"
],
```

이 파일이 `/자산` 폴더에 존재한다는 것을 알 수 있으니 만들어 봅시다. 여기서 `variables.less`라는 파일을 생성하고 Ant Design`s Less 변수를 가져옵니다.

이 선 아래에는 재정의할 수 있는 변수가 무수히 많습니다. 이것은 단지 표본 추출일 뿐입니다. 나머지 변수는 여기에 있으며 해당 변수를 @에 포함시켜야 하며 원하는 대로 변경할 수 있습니다.

우린 갈 수 있어! Nuxt가 처리할 것이기 때문에 우리가 필요로 하는 것을 모든 구성요소로 가져올 필요는 없다. 변수에 포함되지 않은 매우 특정 스타일을 재정의하려면 관련 클래스를 찾아서 `레이아웃/기본값`에서 재정의할 수 있습니다.vue 파일도 마찬가지입니다.

Ant.design 및 Nuxt를 사용하면 애플리케이션을 매우 빠르고 쉽게 구축할 수 있는 훌륭한 프레임워크를 얻을 수 있습니다. 맛있게 드세요!