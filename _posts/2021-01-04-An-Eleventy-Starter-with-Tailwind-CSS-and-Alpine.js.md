---
layout: post
title: "Tailwind CSS와 Alpine을 갖춘 11명의 스타터입니다.js"
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/07/eleventy-tailwind-alpine.png"
tags: ALPINE.JS,ELEVENTY,TAILWIND
---


현재 개인 웹 사이트를 기반으로 하기로 결정했을 때, 저는 그 바퀴를 다시 만들고 싶지 않았습니다. 나는 문서를 통해 스타터 프로젝트에서 찾을 수 있는 Tailwind CSS로 빌드된 11명의 모든 시동기를 테스트했습니다.

많은 시작점들이 Tailwind CSS를 복잡한 방식으로 통합하는 것처럼 보였다. 또한, 그들 중 일부는 웹 사이트에서 작업하는 동안 아무도 Tailwind의 구성을 즉시 업데이트하지 않는다고 추측하는 것 같았다. 그래서 저는 Elevent와 Tailwind CSS, Alpine.js를 통합했습니다. 제 솔루션의 단순함을 좋아하실 거라고 믿으실 만한 이유가 있습니다.

> 좋은 디자인은 가능한 한 적은 디자인이다.
—디터 램, 우수한 설계를 위한 10가지 원칙

세부 사항에 관심이 없으시면 언제든지 제 출발선수를 잡고 바로 뛰어들세요.

### 시작 중

Tailwind CSS, HTML, JavaScript, Nunjucks, 명령줄, npm에 대한 전반적인 이해는 있으실 겁니다.

새 폴더부터 시작해 명령행에 있는 폴더에 `cd`를 입력한 다음 `패키지`로 초기화합니다.json 파일:

```terminal
npm init -y
```

이제 우리는 Elevent와 Tailwind CSS를 설치할 수 있다. PostCSS도 함께 제출하겠습니다.

```terminal
npm install --save-dev @11ty/eleventy tailwindcss postcss-cli autoprefixer
```

우리는 우리가 성공적으로 설정했는지 테스트하기 위한 페이지를 만들어야 합니다. 실제 사용 사례에서 저희 페이지는 템플릿을 사용하기 때문에 여기에서도 사용할 수 있습니다. 그게 바로 Nunjuks가 혼합물에 들어맞는 부분이죠. 템플릿 엔진 역할을 하죠.

프로젝트 폴더에 `index.njk`라는 새 파일을 만들어 봅시다. 홈페이지로 지정해 드립니다.

```nunjucks
{% extends "_includes/default.njk" }
 
{% block title }It does work{% endblock }
 
{% block content }
  <div class="fixed inset-0 flex justify-center items-center">
    <div>
      <span class="text-change">Good design</span><br/>
      <span class="change">is<br/>as little design<br/>as possible</span>
    </div>
  </div>
{% endblock }
```

### 기본 템플릿

이제 프로젝트 폴더에 `_include`라는 폴더를 새로 만들겠습니다(예, 폴더 이름이 중요함). 이 새 폴더 안에 레이아웃의 기본 템플릿으로 사용할 `default.njk`라는 파일을 만듭니다. 기본 HTML 템플릿을 사용하여 간단한 작업을 수행할 수 있습니다.

```nunjucks
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>
      {% block title }Does it work?{% endblock }
    </title>
    <meta charset="UTF-8"/>
    {% if description }
      <meta name="description" content="{description}"/>
    {% endif }
    <meta http-equiv="x-ua-compatible" content="ie=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no, viewport-fit=cover"/>
    <link rel="stylesheet" href="/style.css?v={% version }"/>
    {% block head }{% endblock }
  </head>
  <body>
    {% block content }
      { content | safe }
    {% endblock }
  </body>
</html>
```

### Tailwind CSS 구성 중

가능한 한 적은 움직임으로 Tailwind CSS에 대한 테스트를 진행합시다. 먼저 `style`이라는 새 하위 폴더와 `tailwind.config.js`라는 파일을 만듭니다.

```js
module.exports = {
  purge: {
    content: ["_site/**/*.html"],
    options: {
      safelist: [],
    },
  },
  theme: {
    extend: {
      colors: {
        change: "transparent",
      },
    },
  },
  variants: {},
  plugins: [],
};
```

그런 다음 동일한 `스타일` 폴더에 `tailwind.css`라는 파일을 만듭니다.

```css
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer utilities {
  .change {
    color: transparent;
  }
}
```

일단 스타일 폴더 작업을 완료했습니다. 우리에게 필요한 것은 PostCS에게 Tailwind CSS를 사용하도록 지시하는 구성 파일인데, 이 파일은 프로젝트 폴더의 루트 디렉토리인 `postcs.config.js`에 새로운 파일을 만들어 얻을 수 있다. 다음은 Tailwind CSS 및 PostCS가 포함된 구성 파일이 필요한 방법입니다.

```js
module.exports = {
  plugins: [
    require(`tailwindcss`)(`./styles/tailwind.config.js`),
    require(`autoprefixer`),
  ],
};
```

### 프로젝트 시작 및 구축

이제 `.gitignore`라는 동일한 루트 디렉토리에 다른 새 파일을 만들어 보겠습니다. 이를 통해 GitHub와 같이 프로젝트를 repo에 커밋할 때 건너뛸 파일을 정의할 수 있습니다.

```
_site/
_tmp/
.DS_Store
node_modules/
package-lock.json
```

다음은 또 다른 새로운 파일인데, 이번에는 `.evenent nomore`라고 불리는 `Eventh`가 무시할 수 있는 것을 알려준다. 한 줄만 있으면 됩니다.

```
node_modules
```

이제 기본적으로 Elevent를 구성하는 `.evenent.js`(선행 점 참고!)라는 파일을 만들어 볼 파일과 작업 저장 위치를 알려줍니다.

```js
module.exports = function (eleventyConfig) {
  eleventyConfig.setUseGitIgnore(false);
 
  eleventyConfig.addWatchTarget("./_tmp/style.css");
 
  eleventyConfig.addPassthroughCopy({ "./_tmp/style.css": "./style.css" });
 
  eleventyConfig.addShortcode("version", function () {
    return String(Date.now());
  });
};
```

이제 패키지를 업데이트할 수 있습니다.개발 중에 사이트를 시작하고 구축하는 데 필요한 모든 스크립트가 포함된 json 파일입니다. 종속성은 초기 설정부터 이미 존재해야 합니다.

```js
{
  "scripts": {
    "start": "eleventy --serve & postcss styles/tailwind.css --o _tmp/style.css --watch",
    "build": "ELEVENTY_PRODUCTION=true eleventy & NODE_ENV=production postcss styles/tailwind.css --o _site/style.css"
  },
  "devDependencies": {
    "@11ty/eleventy": "^0.11.1",
    "autoprefixer": "^10.1.0",
    "postcss-cli": "^8.3.1",
    "tailwindcss": "^2.0.2"
  }
}
```

야, 잘했어! 우리는 그것을 만들었다. 초기 CSS를 생성하기 위한 프로젝트를 빌드합니다. 이 단계는 처음 설정할 때만 필요합니다. 명령줄에서 다음을 수행합니다.

```terminal
npm run build
```

그리고 -- 드럼 롤을 주세요. -- 사이트를 공식적으로 시작하겠습니다.

```terminal
npm run start
```

브라우저에서 `http://localhost:8080` 페이지를 엽니다. 그렇게 보이진 않겠지만, 브라우저 탭에서 페이지 제목을 확인하십시오.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/07/Screenshot-1.png?fit=1024%2C757&ssl=1)

모든 게 좋은지 확인하기 위해 조금 더 점검할 수 있어요. /style/tailwind.config.js를 열고 `투명` 색상 값을 다른 값으로 변경합니다. Tailwind의 구성은 브라우저의 페이지와 함께 다시 로드되어야 합니다.

브라우저의 시야를 잃지 말고 `투명`을 `검정`으로 다시 변경하여 `/스타일/테일윈드.css`를 편집하십시오. CSS 파일을 브라우저에서 다시 로드하고 새로 고쳐야 합니다.

이제 우리는 Elevent와 Tailwind CSS로 잘 작업할 수 있습니다!

### 출력 최적화

이 때, Tailwind CSS는 Elevententy와 함께 작동하지만 생성된 HTML은 중복된 새 줄 문자와 같은 것을 포함하고 있기 때문에 완벽하지 않다. 정리하자:

```terminal
npm install --save-dev html-minifier clean-css-cli
```

`.evenent.js` 파일의 시작 부분에 다음 줄을 추가합니다.

```js
const htmlmin = require("html-minifier");
```

또한 htmlmin을 .elevenent.js에 구성해야 합니다.

```js
eleventyConfig.addTransform("htmlmin", function (content, outputPath) {
    if (
      process.env.ELEVENTY_PRODUCTION &&
      outputPath &&
      outputPath.endsWith(".html")
    ) {
      let minified = htmlmin.minify(content, {
        useShortDoctype: true,
        removeComments: true,
        collapseWhitespace: true,
      });
      return minified;
    }
 
    return content;
});
```

우리는 여기서 변형을 사용하고 있습니다. 바로 `11`입니다. 변환은 템플릿의 출력을 수정할 수 있습니다. 이때 `.elevenent.js`는 다음과 같아야 한다.

```js
const htmlmin = require("html-minifier");
 
module.exports = function (eleventyConfig) {
  eleventyConfig.setUseGitIgnore(false);
 
  eleventyConfig.addWatchTarget("./_tmp/style.css");
 
  eleventyConfig.addPassthroughCopy({ "./_tmp/style.css": "./style.css" });
 
  eleventyConfig.addShortcode("version", function () {
    return String(Date.now());
  });
 
  eleventyConfig.addTransform("htmlmin", function (content, outputPath) {
    if (
      process.env.ELEVENTY_PRODUCTION &&
      outputPath &&
      outputPath.endsWith(".html")
    ) {
      let minified = htmlmin.minify(content, {
        useShortDoctype: true,
        removeComments: true,
        collapseWhitespace: true,
      });
      return minified;
    }
 
    return content;
  });
};
```

패키지의 `빌드` 스크립트를 업데이트합니다.json:

```html
{
  "scripts": {
    "start": "eleventy --serve & postcss styles/tailwind.css --o _tmp/style.css --watch",
    "build": "ELEVENTY_PRODUCTION=true eleventy && NODE_ENV=production postcss styles/tailwind.css --o _site/style.css && cleancss _site/style.css -o _site/style.css"
  },
  "devDependencies": {
    "@11ty/eleventy": "^0.11.1",
    "autoprefixer": "^10.1.0",
    "postcss-cli": "^8.3.1",
    "tailwindcss": "^2.0.2"
  }
}
```

다시 한 번 npm run start를 실행해 봅시다. 아무것도 변하지 않았다는 것을 알게 될 것입니다. 최적화는 빌드 중에만 이루어지기 때문입니다. 대신 npm run build를 사용해 본 다음 _site folder를 살펴봅시다. `index.html` 파일에 불필요한 문자가 하나만 있으면 안 됩니다. style.css 파일도 마찬가지다.

이렇게 만들어진 프로젝트는 이제 배포할 준비가 되었습니다. 잘했어! 🏆

### 알파인 통합.js

나는 개츠비.js에서 Eleventy로 바꾸기로 결정했다. 왜냐하면 그것은 나에게 너무 많은 자바스크립트처럼 느껴졌기 때문이다. 나는 알파인.js를 섞은 바닐라 자바스크립트의 합리적인 복용량에 더 관심이 있다. 여기서는 알파인.js의 구체적인 내용에 대해서는 언급하지 않겠지만, 완벽한 출발점이기 때문에 휴고 디 프란체스코의 프라이머를 확인해 볼 가치가 있다.

다음은 명령줄에서 프로젝트에 설치할 수 있는 방법입니다.

```terminal
npm install --save-dev alpinejs
```

이제 알파인을 통과하는 기능으로 .elevenent.js를 업데이트해야 합니다.js:

```js
eleventyConfig.addPassthroughCopy({
  "./node_modules/alpinejs/dist/alpine.js": "./js/alpine.js",
});

```

마지막으로 `_include/default.njk`를 열고 닫는 `/head` 태그 바로 앞에 Alpine.js를 추가합니다.

```nunjucks
<script src="/js/alpine.js?v={% version }"></script>
```

이것을 index.njk에 추가하면 알파인이 작동하는지 확인할 수 있다.

```nunjucks
{% extends "_includes/default.njk" }
 
{% block title }It does work{% endblock }
 
{% block content }
  <div class="fixed inset-0 flex justify-center items-center">
    <div>
      <span class="text-change">Good design</span><br/>
      <span class="change">is<br/>as little design<br/>as possible</span><br/>
      <span x-data="{message:'🤖 Hello World 🤓'}" x-text="message"></span>
    </div>
  </div>
{% endblock }
```

프로젝트 시작:

```terminal
npm run start
```

Alpine.js가 작동하면 브라우저에 "Hello World"가 표시됩니다. 축하해요, 2번! 🏆🏆

템플릿용 Nunjucks, 스타일용 Tailwind, 스크립트용 Alpine.js 등 Elevent 프로젝트 설정이 얼마나 빠를 수 있는지 확인해주셨으면 합니다. 신기술과 함께 일하는 것이 벅차고 혼란스러울 수 있다는 것을 알고 있으니, 시작에 문제가 있거나 이를 더욱 단순화하는 방법이 있다면 언제든지 csstricks@gregwolanski.com으로 이메일을 보내 주십시오.