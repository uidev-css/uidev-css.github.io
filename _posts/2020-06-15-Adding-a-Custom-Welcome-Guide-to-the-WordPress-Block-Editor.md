---
layout: post
title: "WordPress 블록 편집기에 사용자 정의 시작 안내서 추가"
author: "Uidev Css"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/06/blocks-waving.png"
tags: GUTENBERG,WORDPRESS
---


나는 워드프레스 플러그인을 만들고 있는데 그것을 사용할 때 약간의 학습 곡선이 있다. 사용자에게 플러그인 사용법에 대한 프리머를 제공하고 싶지만, 사용자들을 경험에서 벗어나게 하기 때문에 플러그인 웹사이트의 문서로 옮기는 일은 피하고 싶습니다.

플러그인이 설치되면 사용자가 즉시 사용을 시작하지만 현재 사용 중인 경우 유용한 팁에 액세스할 수 있는 것이 좋습니다. 워드프레스에는 이런 것에 대한 기본 기능은 없지만 우리는 만들 수 있습니다. 왜냐하면 워드프레스는 그렇게 매우 유연하기 때문입니다.

자, 이렇게 하죠. 우리는 문서를 플러그인에 직접 구워서 블록 편집기에서 쉽게 접근할 수 있도록 할 것입니다. 이렇게 하면 사용자는 작업 중인 위치에서 일반적인 질문에 대한 답변을 얻으면서 플러그인을 즉시 사용할 수 있습니다.

내 플러그인은 여러 CPT(사용자 지정 게시 유형)를 통해 작동합니다. 우리가 구축하고자 하는 것은 기본적으로 사용자가 이러한 CPT를 이용할 때 얻을 수 있는 팝업 모달입니다.

WordPress 블록 편집기는 React에 내장되어 있어 다양한 상황에 맞게 사용자 지정 및 재사용할 수 있는 구성 요소를 활용합니다. 그것이 우리가 만들고 있는 것의 경우이다. 이것을 `<가이드> 컴포넌트라고 하자. 모달처럼 동작하지만 사용자가 페이지를 넘길 수 있는 여러 페이지로 구성되어 있다.

WordPress 자체에는 블록 편집기를 처음 열 때 환영 가이드를 표시하는 `<Guide> 구성 요소가 있습니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/06/image-3.jpeg?resize=1172%2C876&ssl=1)

가이드는 개별 페이지로 분할된 내용으로 채워진 컨테이너입니다. 다른 말로 하자면, 그것은 우리가 원하는 것 중 거의 대부분이다. 즉, 이 프로젝트를 통해 휠을 재창조할 필요가 없습니다. 동일한 개념을 플러그인에 재사용할 수 있습니다.

정확히 그렇게 합시다.

### 우리가 이루고 싶은 것

해결책에 도달하기 전에, 최종 목표에 대해 이야기해 봅시다.

설계는 WordPress용 GraphQL 서버인 플러그인의 요구사항을 만족시킨다. 플러그인은 사용자 지정 블록을 통해 편집되는 다양한 CPT를 제공하며, 차례로 템플릿을 통해 정의됩니다. 총 두 개의 블록이 있습니다. 하나는 GraphiQL 클라이언트로, 하나는 GraphQL 쿼리를 입력하기 위한 "GraphiQL 클라이언트"이고 다른 하나는 실행 동작을 사용자 정의하기 위한 "Persisted Query Options"입니다.

GraphQL에 대한 쿼리를 만드는 것은 간단한 작업이 아니기 때문에, 나는 그 CPT의 편집기 화면에 가이드 구성요소를 추가하기로 결정했다. 문서 설정에서 "Welcome Guide"라는 패널로 사용할 수 있습니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/06/image-4.jpeg?resize=1172%2C876&ssl=1)

패널을 열면 사용자가 링크를 얻을 수 있습니다. 그 링크는 모달리티를 촉발시킬 것이다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/06/image-5.jpeg?resize=274%2C342&ssl=1)

모달 자체를 위해, 나는 첫 페이지에 CPT 사용에 관한 튜토리얼 비디오를 표시하고, 그 다음 페이지에서 CPT에서 사용할 수 있는 모든 옵션을 자세히 설명하기로 결정했다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/06/image-6.jpeg?resize=1172%2C876&ssl=1)

이 레이아웃이 사용자에게 문서를 보여주는 효과적인 방법이라고 생각합니다. 그것은 방해가 되지 않지만, 여전히 편리하게 행동 가까이에 있다. 물론, 우리는 `<Guide>의 용도를 변경하는 대신 다른 설계를 사용하거나 심지어 다른 구성 요소를 사용하여 모달 트리거를 다른 곳에 배치할 수도 있지만, 이것은 완벽하게 좋다.

### 구현 계획

구현 단계는 다음과 같습니다.

- 사용자 지정 사이드바 패널을 등록하기 위해 새 스크립트 비계
- 사용자 지정 게시 유형에 대해서만 편집기에 사용자 지정 사이드바 패널 표시
- 가이드 작성
- 가이드에 내용 추가

시작하자!

### 1단계: 스크립트 비계 지정

WordPress 5.4부터는 `PluginDocumentSettingPanel`이라는 구성 요소를 사용하여 다음과 같은 편집기의 Document 설정에 패널을 추가할 수 있습니다.

```jsx
const { registerPlugin } = wp.plugins;
const { PluginDocumentSettingPanel } = wp.editPost;
 
const PluginDocumentSettingPanelDemo = () => (
  <PluginDocumentSettingPanel
    name="custom-panel"
    title="Custom Panel"
    className="custom-panel"
  >
    Custom Panel Contents
  </PluginDocumentSettingPanel>
);
registerPlugin( 'plugin-document-setting-panel-demo', {
  render: PluginDocumentSettingPanelDemo,
  icon: 'palmtree',
} );
```

블록 편집기에 익숙하고 이 코드를 실행하는 방법을 이미 알고 있는 경우 건너뛰어도 됩니다. 블록 편집기로 코딩한 지 3개월도 채 되지 않았는데, React/npm/webpack을 사용하는 것은 저에게 새로운 세상입니다. 이 플러그인은 블록 편집기를 사용하는 첫 번째 프로젝트입니다! 구텐베르그 레포에 있는 문서들이 저 같은 초보자에게 항상 적합한 것은 아니라는 것을 알게 되었습니다. 그리고 때로는 문서가 아예 빠져버리기 때문에 답을 찾기 위해 소스 코드를 파헤쳐야 했습니다.

구성 요소의 설명서에서 위의 해당 코드를 사용하라고 표시했을 때, `PluginDocumentSettingPanel`은 블록이 아니며 새로운 블록의 비계나 코드를 추가할 수 없기 때문에 다음에 무엇을 해야 할지 모르겠습니다. 또한 JSX와 함께 작업하고 있습니다. 즉, 코드를 컴파일하려면 JavaScript 빌드 단계가 필요합니다.

그러나 동일한 ES5 코드를 찾았습니다.

```js
var el = wp.element.createElement;
var __ = wp.i18n.__;
var registerPlugin = wp.plugins.registerPlugin;
var PluginDocumentSettingPanel = wp.editPost.PluginDocumentSettingPanel;
 
function MyDocumentSettingPlugin() {
  return el(
    PluginDocumentSettingPanel,
    {
      className: 'my-document-setting-plugin',
      title: 'My Panel',
    },
    __( 'My Document Setting Panel' )
  );
}
 
registerPlugin( 'my-document-setting-plugin', {
  render: MyDocumentSettingPlugin
} );
```

ES5 코드는 컴파일할 필요가 없으므로 WordPress의 다른 스크립트처럼 로드할 수 있습니다. 하지만 난 그걸 사용하고 싶지 않아. ESNext와 JSX의 완전하고 현대적인 경험을 원합니다.

제 생각은 이렇습니다. 블록이 아니라서 블록 비계 도구를 사용할 수도 없고 스크립트를 어떻게 컴파일해야 할지 모르겠습니다(나 혼자 웹팩을 세팅하지는 않을 것임). 꼼짝도 못하겠어요.

하지만 기다려요! 블록과 일반 스크립트의 유일한 차이점은 WordPress에 등록된 방법뿐입니다. 블록은 다음과 같이 등록됩니다.

```php
wp_register_script($blockScriptName, $blockScriptURL, $dependencies, $version);
register_block_type('my-namespace/my-block', [
  'editor_script' => $blockScriptName,
]);
```

일반 스크립트는 다음과 같이 등록됩니다.

```php
wp_register_script($scriptName, $scriptURL, $dependencies, $version);
wp_enqueue_script($scriptName);
```

블록 비계 도구를 사용하여 사물을 수정한 다음 블록 대신 일반 스크립트를 등록할 수 있으며, 이를 통해 ESNext 코드를 컴파일할 수 있는 웹 팩 구성에 액세스할 수 있다. 사용 가능한 툴은 다음과 같습니다.

- WP CLI `scapold` 명령
- 아흐마드 아와이스의 창조-구텐-블록 패키지
- 공식 @wordpress/create-block 패키지

@wordpress/create-block 패키지는 구텐베르크를 개발하는 팀에서 관리하고 있기 때문에 사용하기로 했습니다.

블록의 비계를 만들기 위해 명령행에서 다음을 수행합니다.

```terminal
npm init @wordpress/block
```

블록 이름, 제목 및 설명을 포함한 모든 정보 프롬프트를 완료하면 툴은 다음과 유사한 코드를 포함하는 PHP 파일로 단일 블록 플러그인을 생성합니다.

```php
/**
 * Registers all block assets so that they can be enqueued through the block editor
 * in the corresponding context.
 *
 * @see https://developer.wordpress.org/block-editor/tutorials/block-tutorial/applying-styles-with-stylesheets/
 */
function my_namespace_my_block_block_init() {
  $dir = dirname( __FILE__ );
 
  $script_asset_path = "$dir/build/index.asset.php";
  if ( ! file_exists( $script_asset_path ) ) {
    throw new Error(
      'You need to run `npm start` or `npm run build` for the "my-namespace/my-block" block first.'
    );
  }
  $index_js     = 'build/index.js';
  $script_asset = require( $script_asset_path );
  wp_register_script(
    'my-namespace-my-block-block-editor',
    plugins_url( $index_js, __FILE__ ),
    $script_asset['dependencies'],
    $script_asset['version']
  );
 
  $editor_css = 'editor.css';
  wp_register_style(
    'my-namespace-my-block-block-editor',
    plugins_url( $editor_css, __FILE__ ),
    array(),
    filemtime( "$dir/$editor_css" )
  );
 
  $style_css = 'style.css';
  wp_register_style(
    'my-namespace-my-block-block',
    plugins_url( $style_css, __FILE__ ),
    array(),
    filemtime( "$dir/$style_css" )
  );
 
  register_block_type( 'my-namespace/my-block', array(
    'editor_script' => 'my-namespace-my-block-block-editor',
    'editor_style'  => 'my-namespace-my-block-block-editor',
    'style'         => 'my-namespace-my-block-block',
  ) );
}
add_action( 'init', 'my_namespace_my_block_block_init' );
```

우리는 이 코드를 플러그인에 복사하고 적절히 수정하여 블록을 일반 스크립트로 변환할 수 있습니다. (참고로 CSS 파일도 제거하는 중이지만 필요할 경우 보관할 수 있습니다.)

```php
function my_script_init() {
  $dir = dirname( __FILE__ );
 
  $script_asset_path = "$dir/build/index.asset.php";
  if ( ! file_exists( $script_asset_path ) ) {
    throw new Error(
      'You need to run `npm start` or `npm run build` for the "my-script" script first.'
    );
  }
  $index_js     = 'build/index.js';
  $script_asset = require( $script_asset_path );
  wp_register_script(
    'my-script',
    plugins_url( $index_js, __FILE__ ),
    $script_asset['dependencies'],
    $script_asset['version']
  );
  wp_enqueue_script(
    'my-script'
  );
}
add_action( 'init', 'my_script_init' );
```

`패키지를 복사하자.json` 파일 오버:

```js
{
  "name": "my-block",
  "version": "0.1.0",
  "description": "This is my block",
  "author": "The WordPress Contributors",
  "license": "GPL-2.0-or-later",
  "main": "build/index.js",
  "scripts": {
    "build": "wp-scripts build",
    "format:js": "wp-scripts format-js",
    "lint:css": "wp-scripts lint-style",
    "lint:js": "wp-scripts lint-js",
    "start": "wp-scripts start",
    "packages-update": "wp-scripts packages-update"
  },
  "devDependencies": {
    "@wordpress/scripts": "^9.1.0"
  }
}
```

이제 `src/index.js` 파일의 내용을 위에서 ESNext 코드로 대체하여 `PluginDocumentSettingPanel` 구성 요소를 등록할 수 있습니다. npm start(또는 생산을 위한 npm run build)를 실행하면 코드가 `build/index.js`로 컴파일된다.

마지막으로 해결해야 할 문제가 있는데, `플러그인 문서 설정 패널` 구성 요소는 정적으로 가져오지 않고 대신 `wp.editPost`에서 얻어진 것이며, wp는 런타임에 워드프레스가 로드한 글로벌 변수이기 때문에 `index.asset`에는 이러한 종속성이 존재하지 않는다.php`(빌드 중에 자동으로 생성됨). 스크립트를 등록할 때 `wp-edit-post` 스크립트에 종속성을 수동으로 추가하여 다음 스크립트보다 먼저 로드되도록 해야 합니다.

```php
$dependencies = array_merge(
  $script_asset['dependencies'],
  [
    'wp-edit-post',
  ]
);
wp_register_script(
  'my-script',
  plugins_url( $index_js, __FILE__ ),
  $dependencies,
  $script_asset['version']
);
```

이제 스크립트 설정이 완료되었습니다!

이 플러그인은 구텐베르크의 끊임없는 개발 주기로 업데이트될 수 있다. npm run packages-update를 실행하여 npm 종속성(그리고 결과적으로 패키지 `@wordpress/scripts`에 정의된 웹 팩 구성)을 지원되는 최신 버전으로 업데이트합니다.

이 때, 당신은 내가 어떻게 우리의 스크립트 앞에 "wp-edit-post" 스크립트에 의존성을 추가할 수 있었는지 궁금할 것이다. 구텐베르크의 소스 코드를 파헤쳐야 했어요 `플러그인 문서 설정 패널`의 설명서는 다소 미완성이어서 구텐베르크의 설명서가 특정 장소에서 얼마나 부족한지 보여주는 완벽한 사례다.

코드를 파헤치고 문서를 탐색하면서 몇 가지 깨달은 점을 발견했습니다. 예를 들어 스크립트를 코드화하는 방법에는 ES5 또는 ESNext 구문을 사용하는 두 가지가 있습니다. ES5는 빌드 프로세스가 필요하지 않으며 런타임 환경의 코드 인스턴스(대부분 글로벌 wp 변수)를 참조합니다. 예를 들어, 아이콘을 만드는 코드는 다음과 같습니다.

```js
var moreIcon = wp.element.createElement( 'svg' );
```

ESNext는 모든 종속성을 해결하기 위해 웹 팩에 의존하므로 정적 구성 요소를 가져올 수 있습니다. 예를 들어 아이콘을 만드는 코드는 다음과 같습니다.

```js
import { more } from '@wordpress/icons';
```

이것은 거의 모든 곳에 적용된다. 그러나 ESNext의 런타임 환경을 참조하는 `PluginDocumentSettingPanel` 구성 요소는 그렇지 않습니다.

```js
const { PluginDocumentSettingPanel } = wp.editPost;
```

그래서 우리는 "wp-edit-post" 스크립트에 의존성을 추가해야 합니다. 여기서 wp.editPost 변수가 정의됩니다.

`<PluginDocumentSettingsPanel>`을 직접 가져올 수 있는 경우, "wp-edit-post"에 대한 종속성은 종속성 추출 웹 팩 플러그인을 통해 블록 편집기에서 자동으로 처리됩니다. 이 플러그인은 `index.asset`을 생성하여 정적에서 런타임으로 브리지를 빌드합니다.런타임 환경 스크립트에 대한 모든 종속성을 포함하는 php 파일. 이 파일은 패키지 이름의 `@wordpress/`를 `wp-`로 대체하여 가져옵니다. 따라서 "@wordpress/edit-post" 패키지는 "wp-edit-post" 런타임 스크립트가 된다. 이렇게 해서 의존성을 더할 스크립트를 알아냈습니다.

### 2단계: 다른 모든 CPT에서 사용자 지정 사이드바 패널 블랙리스트 지정

패널에는 특정 CPT에 대한 문서가 표시되므로 해당 CPT에만 등록해야 합니다. 즉, 다른 게시물 유형에 나타나지 않도록 블랙리스트를 작성해야 합니다.

라이언 웰처(`PluginDocumentSettingPanel` 구성 요소를 생성함)는 패널을 등록할 때 다음 프로세스에 대해 설명합니다.

```jsx
const { registerPlugin } = wp.plugins;
const { PluginDocumentSettingPanel } = wp.editPost
const { withSelect } = wp.data;
 
const MyCustomSideBarPanel = ( { postType } ) => {
 
  if ( 'post-type-name' !== postType ) {
    return null;
  }
 
  return(
    <PluginDocumentSettingPanel
      name="my-custom-panel"
      title="My Custom Panel"
    >
      Hello, World!
    </PluginDocumentSettingPanel>
  );
}
 
const CustomSideBarPanelwithSelect = withSelect( select => {
  return {
    postType: select( 'core/editor' ).getCurrentPostType(),
  };
} )( MyCustomSideBarPanel);
 
 
registerPlugin( 'my-custom-panel', { render: CustomSideBarPanelwithSelect } );
```

그는 또 선택과 함께가 아니라 선택과 함께 사용법을 택해 대안을 제시하기도 한다.

그렇다고 해서, 자바스크립트 파일이 필요하지 않더라도 여전히 로드되어야 하기 때문에 웹사이트가 성능 향상을 이룰 수 밖에 없기 때문에, 저는 이 솔루션을 완전히 납득할 수 없습니다. 자바스크립트를 사용하지 않기 위해 자바스크립트를 실행하는 것보다 자바스크립트 파일을 등록하지 않는 것이 더 말이 되지 않나요?

PHP 솔루션을 만들었습니다. 나는 그것은 약간hacky을 느끼지만 이는 일을 인정합니다. 먼저 생성 또는 편집 중인 개체와 관련된 게시 유형을 확인합니다.

```php
function get_editing_post_type(): ?string
{
  if (!is_admin()) {
    return null;
  }
 
  global $pagenow;
  $typenow = '';
  if ( 'post-new.php' === $pagenow ) {
    if ( isset( $_REQUEST['post_type'] ) && post_type_exists( $_REQUEST['post_type'] ) ) {
      $typenow = $_REQUEST['post_type'];
    };
  } elseif ( 'post.php' === $pagenow ) {
    if ( isset( $_GET['post'] ) && isset( $_POST['post_ID'] ) && (int) $_GET['post'] !== (int) $_POST['post_ID'] ) {
      // Do nothing
    } elseif ( isset( $_GET['post'] ) ) {
      $post_id = (int) $_GET['post'];
    } elseif ( isset( $_POST['post_ID'] ) ) {
      $post_id = (int) $_POST['post_ID'];
    }
    if ( $post_id ) {
      $post = get_post( $post_id );
      $typenow = $post->post_type;
    }
  }
  return $typenow;
}
```

그런 다음 CPT와 일치하는 경우에만 스크립트를 등록합니다.

```php
add_action('init', 'maybe_register_script');
function maybe_register_script()
{
  // Check if this is the intended custom post type
  if (get_editing_post_type() != 'my-custom-post-type') {
    return;
  }
 
  // Only then register the block
  wp_register_script(...);
  wp_enqueue_script(...);
}
```

이 게시물이 어떻게 작동하는지 자세히 알아보려면 이 게시물을 참조하십시오.

### 3단계: 사용자 지정 가이드 생성

WordPress `<Guide> 구성 요소를 기반으로 플러그인 가이드 기능을 설계했습니다. 처음에는 제가 그렇게 할 줄 몰랐는데, 이렇게 알아낼 수 있었습니다.

- 소스 코드를 검색하여 해당 코드가 어떻게 수행되었는지 확인합니다.
- 구텐베르크의 Storybook에서 사용 가능한 모든 구성 요소의 카탈로그를 살펴보십시오.

먼저 블록 에디터 모달에 있는 내용을 복사하고 기본 검색을 했습니다. 결과는 이 파일을 가리켰다. 거기서 저는 이 구성 요소가 `<Guide>`라고 불리며, 이 코드를 간단히 복사하여 내 플러그인에 붙여넣을 수 있다는 것을 알게 되었습니다.

그리고 나서 나는 그 부품의 설명서를 찾아보았다. @wordpress/components 패키지(추측한 바와 같이 구성 요소가 구현되는 곳)를 찾아보았더니 구성 요소의 README 파일이 검색되었습니다. 이를 통해 나만의 맞춤 가이드 구성 요소를 구현하는 데 필요한 모든 정보를 얻을 수 있었습니다.

나는 또한 구텐베르크의 Storybook에서 사용 가능한 모든 구성 요소의 카탈로그를 탐색했다(실제로 이 구성 요소들이 WordPress의 맥락 밖에서 사용될 수 있음을 보여준다). 나는 그들 모두를 클릭해서 마침내 <가이드>를 발견했다. 스토리북은 몇 가지 예(또는 스토리)에 대한 소스 코드를 제공합니다. 소품을 통해 구성요소를 사용자 지정하는 방법을 이해하는 데 유용한 리소스입니다.

이 시점에서 나는 <가이드>가 내 구성 요소의 탄탄한 기반이 될 것이라는 것을 알았다. 그러나 누락된 요소가 하나 있습니다. 클릭 시 가이드를 트리거하는 방법입니다. 난 이걸 위해 머리를 짜내야 했어!

이 버튼은 클릭 시 모달을 여는 수신기입니다.

```jsx
import { useState } from '@wordpress/element';
import { Button } from '@wordpress/components';
import { __ } from '@wordpress/i18n';
import MyGuide from './guide';
 
const MyGuideWithButton = ( props ) => {
  const [ isOpen, setOpen ] = useState( false );
  return (
    <>
      <Button onClick={ () => setOpen( true ) }>
        { __('Open Guide: “Creating Persisted Queries”') }
      </Button>
      { isOpen && (
        <MyGuide 
          { ...props }
          onFinish={ () => setOpen( false ) }
        />
      ) }
    </>
  );
};
export default MyGuideWithButton;
```

블록 편집기가 숨기려고 해도, 우리는 리액트 내에서 운영되고 있습니다. 지금까지 JSX와 구성 요소를 다루어 왔습니다. 그러나 이제는 리액션에 특화된 use State 훅이 필요하다.

WordPress 블록 편집기를 마스터하려면 React를 잘 파악해야 한다고 생각합니다. 그 방도가 없다.

### 4단계: 가이드에 내용 추가

거의 다 왔어! 각 콘텐츠 페이지에 대한 `<GuidePage> 구성 요소를 포함하는 `<Guide> 구성 요소를 생성해 보겠습니다.

컨텐츠는 HTML을 사용할 수 있고, 다른 구성 요소 등을 포함할 수 있습니다. 특히 이 경우 HTML만을 사용하여 CPT에 대한 < 가이드 페이지 3개 인스턴스를 추가했는데, 첫 페이지는 비디오 튜토리얼을 포함하고 다음 두 페이지는 자세한 지침을 포함하고 있습니다.

```jsx
import { Guide, GuidePage } from '@wordpress/components';
import { __ } from '@wordpress/i18n';
 
const MyGuide = ( props ) => {
  return (
    <Guide { ...props } >
      <GuidePage>
        <video width="640" height="400" controls>
          <source src="https://d1c2lqfn9an7pb.cloudfront.net/presentations/graphql-api/videos/graphql-api-creating-persisted-query.mov" type="video/mp4" />
          { __('Your browser does not support the video tag.') }
        </video>
        // etc.
      </GuidePage>
      <GuidePage>
        // ...
      </GuidePage>
      <GuidePage>
        // ...
      </GuidePage>
    </Guide>
  )
}
export default MyGuide;
```

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/06/image-1.gif?resize=1120%2C748&ssl=1)

나쁘지 않아! 그러나 몇 가지 문제가 있습니다.

- 재생 버튼을 클릭하면 가이드가 닫히기 때문에 동영상을 <가이드> 안에 넣을 수 없었습니다. 그 이유는 if 프레임이 가이드의 테두리를 벗어나기 때문인 것 같다. 결국 S3에 동영상 파일을 업로드하고 `비디오`로 서비스를 하게 되었습니다.
- 가이드의 페이지 전환이 매우 원활하지 않습니다. 모든 페이지의 높이가 비슷해서 블록 편집기의 모달은 괜찮아 보이지만, 이 페이지의 전이는 꽤 갑작스럽습니다.
- 버튼에 대한 호버 효과를 개선할 수 있습니다. 구텐베르그 팀이 제 CSS가 없기 때문에 그들만의 목적을 위해 이것을 고쳐야 할 것입니다. 내 실력이 형편없다는 것이 아니라 존재하지 않는다.

하지만 난 이런 문제들을 잘 견뎌낼 수 있어. 기능 면에서는 가이드가 필요한 작업을 수행했습니다.

### 보너스: 독립적으로 문서 열기

우리의 <가이드>의 경우 HTML을 이용하여 각 <가이드페이지> 컴포넌트의 콘텐츠를 직접 만들었지만, 이 HTML 코드를 자율 컴포넌트를 통해 추가한다면 다른 사용자 상호 작용에 재사용할 수 있다.

예를 들어, 구성 요소 `<CacheControlDescription`은 HTTP 캐시에 대한 설명을 표시합니다.

```jsx
const CacheControlDescription = () => {
  return (
    <p>The Cache-Control header will contain the minimum max-age value from all fields/directives involved in the request, or "no-store" if the max-age is 0</p>
  )
}
export default CacheControlDescription;
```

이 구성 요소는 이전과 같이 `<GuidePage>` 내부에 추가할 수 있으며, `<Modal> 구성 요소에도 추가할 수 있습니다.

```jsx
import { useState } from '@wordpress/element';
import { Button } from '@wordpress/components';
import { __ } from '@wordpress/i18n';
import CacheControlDescription from './cache-control-desc';
 
const CacheControlModalWithButton = ( props ) => {
  const [ isOpen, setOpen ] = useState( false );
  return (
    <>
      <Button 
        icon="editor-help"
        onClick={ () => setOpen( true ) }
      />
      { isOpen && (
        <Modal 
          { ...props }
          onRequestClose={ () => setOpen( false ) }
        >
          <CacheControlDescription />
        </Modal>
      ) }
    </>
  );
};
export default CacheControlModalWithButton;
```

우수한 사용자 환경을 제공하기 위해 사용자가 블록과 상호 작용할 때만 문서를 표시하도록 제안할 수 있습니다. 이를 위해 `isSelected` 값에 따라 버튼을 표시하거나 숨깁니다.

```jsx
import { __ } from '@wordpress/i18n';
import CacheControlModalWithButton from './modal-with-btn';
 
const CacheControlHeader = ( props ) => {
  const { isSelected } = props;
  return (
    <>
      { __('Cache-Control max-age') }
      { isSelected && (
        <CacheControlModalWithButton />
      ) }
    </>
  );
}
export default CacheControlHeader;
```

마지막으로, `CacheControlHeader` 구성 요소가 해당 컨트롤에 추가됩니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/06/image-2.gif?resize=1120%2C748&ssl=1)

### 타다아아아아아아아아🎉

워드프레스 블록 편집기는 아주 작은 소프트웨어이다! 나는 그것 없이는 할 수 없었을 일들을 그것으로 이룰 수 있었다. 사용자에게 문서를 제공하는 것이 예나 사용 사례 중에서 가장 뛰어나지는 않을 수도 있지만, 매우 실용적이고 다른 많은 플러그인과 관련이 있습니다. 자신의 플러그인에 사용하시겠습니까? 화이팅!