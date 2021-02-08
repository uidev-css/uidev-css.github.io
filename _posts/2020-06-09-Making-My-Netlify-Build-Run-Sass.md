---
layout: post
title: "내 Netlifify 빌드를 sass로 실행"
author: "Uidev Css"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/06/netlify-build-plugins-sass.png"
tags: BUILD TOOL,JAMSTACK,NETLIFY,SASS
---


만약 당신이 엘레븐을 발전기로 삼아 부지를 건설하고 싶다고 가정해 봅시다. 요즘 인기 있는 선택! 만약 당신이 하고 싶은 것이라면, 11번째는 당신의 CSS를 전처리하는 특별한 방법이 없습니다. 그것을 하는 방법은 다양하며 아마도 자유는 11대 정신의 일부일 것이다.

저는 이것을 위해 굴프를 설정하는 사람들을 봤습니다. 멋집니다. 저는 여전히 굴프를 사용하고 어떤 것에 대해 굴프를 좋아합니다. 누군가 템플릿으로 사전 처리된 CSS를 돌려주는 걸 본 적이 있는데, 이상한 것 같지만, 어쨌든 효과가 있어요. 심지어 누군가가 처리를 위해 Levelty 구성 자체를 확장하는 것도 봤습니다.

지금까지 저에게 가장 의미 있는 것은 npm 스크립트를 사용하여 Sass를 처리하는 것입니다. 먼저 CSS를 한 다음 HTML을 npm-run-all로 한다. 그래서, 당신은 당신의 소포에 이와 같은 것을 설치했을 것이다.json:

```package.json
  "scripts": {
    "build": "npm-run-all build:css build:html",
    "build:css": "node-sass src/site/_includes/css/main.scss > src/site/css/main.css",
    "build:html": "eleventy",
    "watch": "npm-run-all --parallel watch:css watch:html",
    "watch:css": "node-sass --watch src/site/_includes/css/main.scss > src/site/css/main.css",
    "watch:html": "eleventy --serve --port=8181",
    "start": "npm run watch"
  },
```

꽤 괜찮은 것 같아요. 어차피 Eleventy는 CSS 처리 경로가 없기 때문에, Eleventy 처리에서 디커플링하는 것은 괜찮다고 느껴집니다.

하지만 Netlifify는 그들의 빌드 플러그인과 잘 어울리고 있다고 봅니다. 사라의 표현대로라면:

> 빌드 플러그인이 하는 일은 예를 들어 'OnPreBuild', 'OnPostBuild', 'OnSuccess' 등과 같은 프로세스 중에 주요 시점에 액세스할 수 있도록 합니다. 특정 시점에서 일부 논리를 실행할 수 있습니다.

그 구조에는 정말 직관적이고 좋은 무언가가 있다. 커뮤니티 또는 Netliify 자체에서 빌드 플러그인을 많이 생성합니다. UI를 통해 아이콘을 클릭하거나 구성에서 참조하기만 하면 됩니다. 하지만 Sass는 빌트인 프로젝트가 아닙니다. 제가 추측하는 것은 사람들이 CSS가 어떻게 처리되는지에 대해 꽤 의견이 분분하기 때문에 사람들이 스스로 CSS를 하도록 내버려두는 것이 타당하기 때문입니다. 자, 그렇게 합시다.

프로젝트에서는 플러그인 디렉토리를 생성한 다음 이 특정 플러그인에 대한 폴더를 작성합니다.

```project file structure
project-root/
  src/
  whatever/
  plugins/
    sass/
      index.js
      manifest.yml 
 

```

이 `index.js` 파일은 우리가 코드를 쓰는 곳이며, 우리는 특히 여기에서 `onPreBuild` 후크를 사용하기를 원할 것이다. 왜냐하면 우리는 빌드 프로세스가 진행되기 전에 Sass를 사전 처리하기를 원하기 때문이다.

```js
module.exports = {
  onPreBuild: async ({ utils: { run } }) => {
    await run.command(
      "node-sass src/site/_includes/css/main.scss src/site/css/main.css"
    );
  },
};
```

다음은 모든 관련 파일을 함께 살펴봅니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/06/Screen-Shot-2020-06-09-at-6.47.36-AM.png?fit=1024%2C597&ssl=1)

이제 명령줄에서 netlifine build를 실행하면 Netlifine 자체와 동일한 빌드 프로세스가 실행되어 플러그인에 연결되고 실행됩니다!

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/06/Screen-Shot-2020-06-09-at-6.51.27-AM.png?fit=1024%2C999&ssl=1)

한 가지 작은 점은 구성을 netliify.yml 형식으로 만들려고 했지만 플러그인이 작동하지 않았고 구성을 netliify.toml로 다시 수행해야 한다는 것입니다.

그래서 우리는 이 특별한 처리와 함께 Eleventity로부터 분리되어 Netliify로 연결되었습니다. 그냥 알아둬야 할 것 뿐이야 저는 이런 방식으로 빌드를 구성하는 것이 매우 좋고 그 안에서 많은 가능성을 볼 수 있기 때문에 이 점에 대해 낙담하고 있습니다.

나는 이 스타일의 좀 더 명확하고 분리된 구성이 더 좋다. 얼마나 더 깨끗한 포장인지 보세요.json은 다음을 얻습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/06/Screen-Shot-2020-06-09-at-7.03.51-AM.png?fit=1024%2C620&ssl=1)

### 난 아직도 이런 생각을 가지고 있어.

…사이트 구축: 빌드 프로세스 중에 할 수 있고 수행해야 하는 모든 작업의 개밥 예제를 제공합니다. 제가 이 사이트를 시작했는데, 아직 별로 효과가 없습니다. 빌드 플러그인을 통해 목록에 있는 모든 항목을(및 그 이상) 연결하는 것이 멋질 것 같습니다.

기여하고 싶으시면 언제든지 말씀해주세요. 이메일로 보내거나 이슈를 열어 보고 싶은 일에 대해 이야기해 볼 수도 있습니다. Pull Request(당기기 요청)도 자유롭게 할 수 있지만, 사전 커뮤니케이션이 없는 PR은 때때로 다소 까다롭습니다. 많은 노력을 기울이기 전에 우리의 비전이 일치하는지 확인하는 것이 어렵기 때문입니다.