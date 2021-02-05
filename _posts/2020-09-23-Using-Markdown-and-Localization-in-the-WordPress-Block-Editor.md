---
layout: post
title: "WordPress Block Editor에서 Markdown 및 Localization 사용"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/09/markdown-locale-wordpress.png
tags: LOCALIZATION,MARKDOWN,WORDPRESS,WORDPRESS BLOCKS
---


WordPress 편집기에서 사용자에게 직접 문서를 보여줘야 하는 경우, 가장 좋은 방법은 무엇입니까?

블록 편집기는 React를 기반으로 하기 때문에, 우리는 문서에 React 컴포넌트와 HTML 코드를 사용하고자 할 수 있습니다. 그것이 내가 이전 기사에서 따랐던 접근법인데, 이것은 모달 창에서 문서를 보여주는 방법을 보여주었다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/09/IKNbFQC.gif?resize=1120%2C748&ssl=1)

그러나 Retact 구성 요소와 HTML 코드를 통해 문서를 추가하는 작업은 유지관리가 어려울 뿐만 아니라 매우 상세해질 수 있기 때문에 이 솔루션은 완벽하지 않습니다. 예를 들어, 위의 이미지의 모달에는 다음과 같은 Retact 구성 요소의 설명서가 포함되어 있습니다.

```jsx
const CacheControlDescription = () => {
  return (
    <p>The Cache-Control header will contain the minimum max-age value from all fields/directives involved in the request, or <code>no-store</code> if the max-age is 0</p>
  )
}
```

HTML 대신 Markdown을 사용하면 작업을 더 쉽게 수행할 수 있습니다. 예를 들어, 위의 문서를 Retact 구성 요소에서 벗어나 `/https/cache-control.md`과 같은 Markdown 파일로 이동할 수 있습니다.

```markdown
The Cache-Control header will contain the minimum max-age value from all fields/directives involved in the request, or `no-store` if the max-age is 0
```

순수 HTML과 비교하여 Markdown을 사용할 때의 장점과 단점은 무엇입니까?

단점과 관련하여, 반응 구성요소를 사용할 수 없는 것은 적어도 간단한 문서화의 경우 문제가 되지 않을 수 있습니다. 그러나 현지화의 부족이 주요 쟁점이다. 자바스크립트 `__` 기능을 통해 추가된 리액트 구성요소의 텍스트는 POT 파일의 번역을 사용하여 추출 및 교체가 가능하다. 마크다운의 콘텐츠는 이 기능에 액세스할 수 없습니다.

문서화를 위한 현지화는 필수이기 때문에 보완이 필요할 것 같습니다. 이 기사에서는 다음 두 가지 목표를 추구합니다.

- Markdown을 사용하여 문서 작성(WordPress 편집기의 블록으로 표시됨)
- 문서를 사용자의 언어로 변환

시작하자!

### 마크다운 컨텐츠 로드 중

Markdown 파일 `/html/cache-control.md`을 생성하면 다음과 같이 컨텐츠(HTML로 렌더링됨)를 가져와 Retact 구성 요소에 주입할 수 있습니다.

```jsx
import CacheControlDocumentation from '../docs/cache-control.md';
 
const CacheControlDescription = () => {
  return (
    <div
      dangerouslySetInnerHTML={ { __html: CacheControlDocumentation } }
    />
  );
}
```

이 솔루션은 WordPress 편집기의 핵심에 있는 모듈 번들러인 웹 팩에 의존합니다.

WordPress 편집기는 현재 웹 팩 4.42를 사용하지만, 웹 팩 사이트에 처음 표시된 설명서는 버전 5(아직 베타 버전)에 해당합니다. 버전 4에 대한 설명서는 하위 사이트에 있습니다.

콘텐츠는 웹 팩의 로더를 통해 마크다운에서 HTML로 변환되며, 블록은 웹 팩 구성을 사용자 정의해야 하며 마크다운로더와 HTML로더를 사용하기 위한 규칙을 추가한다.

이렇게 하려면 다음 코드를 사용하여 블록의 루트에 `webpack.config.js` 파일을 추가하십시오.

```js
// This is the default webpack configuration from Gutenberg
const defaultConfig = require( '@wordpress/scripts/config/webpack.config' );
 
// Customize adding the required rules for the block
module.exports = {
  ...defaultConfig,
  module: {
    ...defaultConfig.module,
    rules: [
      ...defaultConfig.module.rules,
      {
        test: /\.md$/,
        use: [
          {
            loader: "html-loader"
          },
          {
            loader: "markdown-loader"
          }
        ]
      }
    ],
  },
};
```

그리고 해당 패키지를 설치합니다.

```terminal
npm install --save-dev markdown-loader html-loader
```

우리가 그것을 하는 동안 작은 개선점 하나를 적용하자. 문서 폴더에는 프로젝트의 모든 위치에 있는 구성 요소에 대한 문서가 포함될 수 있습니다. 각 구성 요소에서 해당 폴더로 상대 경로를 계산하지 않으려면 webpack.config.js에 별칭 `@docs`를 추가하여 `/docs` 폴더로 확인할 수 있습니다.

```js
const path = require( 'path' );
config.resolve.alias[ '@docs' ] = path.resolve( process.cwd(), 'docs/' )
```

이제 가져오기 작업이 간소화됩니다.

```jsx
import CacheControlDocumentation from '@docs/cache-control.md';
```

다 됐다! 더 이상 어쩔 수 없다! 이제 외부 Markdown 파일의 문서를 React 구성 요소에 주입할 수 있습니다.

### 문서를 사용자의 언어로 변환

마크다운 콘텐츠에 대해 .po 파일을 통해 문자열을 번역할 수는 없지만 다른 언어에 대해 다른 마크다운 파일을 만들 수도 있습니다. 그런 다음 단일 파일(`/https/cache-control.md`)을 사용하는 대신 각 파일을 해당 언어 코드로 저장할 수 있습니다.

- `/https/en/cache-control.md`
- `/https/fr/cache-control.md`
- `/오피니언/오피니언/cache-control.md
- 등

우리는 또한 언어와 지역 모두에 대한 번역을 지원할 수 있으며, 미국과 영국 영어가 서로 다른 버전을 가질 수 있고, 지역에 대한 번역이 제공되지 않을 때 언어 전용 버전으로 기본 설정될 수 있다(예: `en_CA`는 `en`에서 처리됨).

- `/오렌지/엔`US/cache-control.md
- `/docs/en_GB/cache-control.md`
- `/https/en/cache-control.md`

문제를 단순화하기 위해 지역 없이 다양한 언어를 지원하는 방법만 설명하겠습니다. 하지만 코드는 거의 비슷하다.

이 기사에서 증명된 코드는 내가 만든 WordPress 플러그인의 소스 코드에서도 볼 수 있다.

### 블록에 사용자 언어 입력

WordPress의 사용자 언어는 `get_locale()에서 검색할 수 있습니다. 로케일에 언어 코드와 지역(예: `en_US`)이 포함되기 때문에 언어 코드를 추출하기 위해 구문 분석합니다.

```jsx
function get_locale_language(): string 
{
  $localeParts = explode( '_', get_locale() );
  return $localeParts[0];
}
```

wp_localize_script()를 통해 글로벌 변수(이 경우 graphqlApiCacheControl) 아래의 userLang 속성으로 블록에 언어 코드를 제공합니다.

```jsx
// The block was registered as $blockScriptRegistrationName
wp_localize_script(
  $blockScriptRegistrationName,
  'graphqlApiCacheControl',
  [
    'userLang' => get_locale_language(),
  ]
);
```

이제 블록에서 사용자의 언어 코드를 사용할 수 있습니다.

```jsx
const lang = window.graphqlApiCacheControl.userLang; 
```

### 동적 가져오기

런타임에 사용자의 언어만 알 수 있습니다. 그러나 import(가져오기) 문구는 동적(dynamic)이 아니라 정적(static)이다. 따라서 이 작업을 수행할 수 없습니다.

```jsx
// `lang` contains the user's language
import CacheControlDocumentation from '@docs/${ lang }/cache-control.md';
```

즉, 웹 팩은 기본적으로 요청된 모듈을 별도의 청크로 분할하여(즉, 주 컴파일된 `build/index.js` 파일에 포함되지 않음) 가져오기 기능을 통해 모듈을 동적으로 로드할 수 있게 한다.

이 동작은 앞에 로드되지 않고 사용자 액션에 의해 트리거되는 모달 창에 설명서를 표시하는 데 적합합니다. `import`는 모듈의 위치에 대한 일부 정보를 수신해야 하므로 이 코드가 작동합니다.

```jsx
import( `@docs/${ lang }/cache-control.md` ).then( module => {
  // ...
});
```

그러나 유사한 것으로 보이는 이 코드는 다음과 같지 않다.

```jsx
const dynamicModule = `@docs/${ lang }/cache-control.md`
import( dynamicModule ).then( module => {
  // ...
});
```

파일의 내용은 가져온 개체의 키 `기본값`에서 액세스할 수 있습니다.

```jsx
const cacheControlContent = import( `@docs/${ lang }/cache-control.md` ).then( obj => obj.default )
```

우리는 이 논리를 언어와 함께 마크다운 파일의 이름을 전달하여 getMarkdownContent라는 함수로 일반화할 수 있다.

```jsx
const getMarkdownContent = ( fileName, lang ) => {
  return import( `@docs/${ lang }/${ fileName }.md` )
    .then( obj => obj.default )
} 
```

### 청크 관리

블록 자산을 정리하려면 문서 청크를 `/docs` 하위 폴더(`빌드/` 폴더 내에 생성될)에 그룹화하고 파일 이름을 설명하도록 합니다.

이어 cache-control.md과 cache-purging.md이 3개 언어(영어, 프랑스어, 중국어)로 구성된 두 개의 문서(cache-control.md)를 통해 다음과 같은 덩어리가 제작된다.

- `build/cash/en-cache-control-md.js`
- `build/build/fr-cache-control-md.js`
- `build/cash/cache-control-md.js`
- `build/filen-cache-filen-md.js`
- `build/fr-cache-fr-cache-md.js`
- `build/fileng/fileng-cache-filk-md.js`

이 작업은 "가져오기" 인수 바로 앞에 있는 `/* 웹 팩 ChunkName: "docs/[request]" */`이라는 매직 코멘트를 사용하여 수행됩니다.

```jsx
const getMarkdownContent = ( fileName, lang ) => {
  return import( /* webpackChunkName: "docs/[request]" */ `@docs/${ lang }/${ fileName }.md` )
    .then(obj => obj.default)
} 
```

### 청크의 공용 경로 설정

webpack은 `publicPath` 구성 옵션 덕분에 청크를 가져올 위치를 알고 있습니다. 제공되지 않은 경우 WordPress 편집기의 현재 URL인 `/wp-admin/ism`이 사용되며, 청크가 다른 위치에 있으므로 404를 생성합니다. 내 블록의 경우 /wp-content/plugins/graphql-api/blocks/cache-control/build/build/mith 아래에 있습니다.

만약 블록이 우리 자신을 위한 것이라면, 우리는 webpack.config.js에서 publicPath를 하드코드화하거나 ASSET_PATH 환경변수를 통해 제공할 수 있다. 그렇지 않으면 런타임에 공개 경로를 블록으로 전달해야 합니다. 이를 위해 블록의 `빌드/` 폴더에 대한 URL을 계산합니다.

```jsx
$blockPublicPath = plugin_dir_url( __FILE__ ) . '/blocks/cache-control/build/';
```

그런 다음 블록을 현지화하여 JavaScript 측에 주입합니다.

```jsx
// The block was registered as $blockScriptRegistrationName
wp_localize_script(
    $blockScriptRegistrationName,
    'graphqlApiCacheControl',
    [
      //...
      'publicPath' => $blockPublicPath,
    ]
);
```

그런 다음 `__webpack_public_path__` JavaScript 변수에 대한 공개 경로를 제공합니다.

```jsx
__webpack_public_path__ = window.graphqlApiCacheControl.publicPath;
```

### 기본 언어로 돌아가기

사용자의 언어에 대한 번역이 없으면 어떻게 됩니까? 이 경우 Get MarkdownContent를 호출하면 오류가 발생합니다.

예를 들어 언어가 독일어로 설정되면 브라우저 콘솔에 다음과 같은 내용이 표시됩니다.

```
Uncaught (in promise) Error: Cannot find module './de/cache-control.md'
```

해결 방법은 오류를 포착한 다음 기본 언어로 콘텐츠를 반환하는 것입니다. 이 언어는 블록에서 항상 충족합니다.

```jsx
const getMarkdownContentOrUseDefault = ( fileName, defaultLang, lang ) => {
  return getMarkdownContent( fileName, lang )
    .catch( err => getMarkdownContent( fileName, defaultLang ) )
}
```

React 컴포넌트 내 HTML로, 그리고 외부 Markdown 파일로 번역이 완료되지 않았을 때 코딩 문서와는 다른 동작에 주목해 주세요. 첫 번째 경우 문자열이 번역되었지만 다른 문자열이 번역되지 않은 경우(`.po` 파일에) Retact 구성 요소는 혼합 언어를 표시합니다. 두 번째 경우 모두 또는 전혀 그렇지 않습니다. 문서가 완전히 번역되었거나 번역되지 않았습니다.

### 설명서를 모달로 설정

지금쯤이면 우리는 Mark down 파일에서 문서를 검색할 수 있습니다. 모달에 어떻게 표시하는지 봅시다.

먼저 구텐베르크의 `모달` 구성 요소를 포장하여 HTML로 콘텐츠를 주입합니다.

```jsx
import { Modal } from '@wordpress/components';
 
const ContentModal = ( props ) => {
  const { content } = props;
  return (
    <Modal 
      { ...props }
    >
      <div
        dangerouslySetInnerHTML={ { __html: content } }
      />
    </Modal>
  );
};
```

그런 다음 Markdown 파일에서 콘텐츠를 검색하여 page라는 상태 후크를 사용하여 소품으로 모달에 전달합니다. 동적으로 콘텐츠를 로드하는 작업은 비동기 작업이기 때문에 구성 요소에서 부작용을 수행하기 위해 효과 후크도 사용해야 합니다. Markdown 파일의 내용을 한 번만 읽으면 되므로 빈 배열을 "use Effect"에 대한 두 번째 인수로 전달합니다(또는 후크가 계속 트리거됨).

```jsx
import { useState, useEffect } from '@wordpress/element'; 
const CacheControlContentModal = ( props ) => {
  const fileName = 'cache-control'
  const lang = window.graphqlApiCacheControl.userLang
  const defaultLang = 'en'
 
  const [ page, setPage ] = useState( [] );
 
  useEffect(() => {
    getMarkdownContentOrUseDefault( fileName, defaultLang, lang ).then( value => {
      setPage( value )
    });
  }, [] );
 
  return (
    <ContentModal
      { ...props }
      content={ page }
    />
  );
};
```

한번 해봅시다. 문서가 들어 있는 청크가 느리게 로드되는 경우(즉, 블록을 편집할 때 트리거됨)에 유의하십시오.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/09/TU3ftj9Q.gif?resize=1018%2C722&ssl=1)

### 타다아아아아아아아아🎉

문서 작성은 여러분이 세상에서 가장 좋아하는 것이 아닐 수도 있지만, 쓰고 유지하기 쉽게 하는 것은 그 고통을 없애는 데 도움이 될 수 있습니다.

순수한 HTML 대신 Markdown을 사용하는 것이 확실히 그것을 위한 한 가지 방법이다. 방금 살펴본 접근 방식은 작업 흐름을 개선할 뿐만 아니라 WordPress 사용자를 위한 멋진 기능까지 제공하기를 바랍니다.