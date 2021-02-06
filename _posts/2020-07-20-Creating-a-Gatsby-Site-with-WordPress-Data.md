---
layout: post
title: "워드프레스 데이터로 개츠비 사이트 만들기"
author: "CSS Dev"
thumbnail: "undefined"
tags: 
---


지난주 제 이전 기사에서는 부분적으로 포트된 WordPress-Gatsby 사이트를 만드는 것을 언급했습니다. 이 기사는 후드 아래를 한 걸음 한 걸음씩 걸어가는 연속물이다.

정적 사이트를 위한 리액트 기반 프레임워크인 개츠비는 자바스크립트 개발자는 물론 워드프레스 개발자와 사용자들의 관심을 끌고 있다. 많은 WordPress 사용자는 초고속 이미지 처리 및 해커로부터의 보안 보호 향상과 같은 이 기능이 매력적이라고 생각하지만, WordPress 관리자와 편집기를 사용하여 콘텐츠를 계속 관리하고 있습니다.

크리스는 여기 전에 CSS-Tricks에 개츠비와 워드프레스를 결합하는 아이디어를 다루었다. 워드프레스 애호가로서 한번 해보기로 했다. 이 글은 제가 그 동안 배우고 기록한 것을 바탕으로 한 것입니다.

WPgrapQL과 개츠비-cli는 이후 버전의 변경사항으로 지속적인 개발을 진행하고 있다는 점에 유의하시기 바랍니다. 이 프로젝트는 WPgrapQL 0.8.3, 개츠비-소스-wpgraphql 2.5.1, 개츠비-cli 2.12.21을 사용하여 수행되었다. 워드프레스와는 달리, 새로운 WPgrapQL 릴리스는 이전 버전과의 호환성을 지원하지 않는다. 공식 WPGrapQL을 참조하십시오.

개츠비 선발자 도서관에는 즉시 사용할 수 있는 프로젝트들이 있다. 두 가지 훌륭한 예는 알렉산드라 스팔라토의 개츠비 단어인 프레스 테마 블로그와 잭 고든과 무함마드 무신의 19개 게이트 바이-테마이다.

### 전제조건

계속 진행하려면 다음과 같이 하십시오.

- React 및 JavaScript의 기본 친숙함. 다음은 React 및 JavaScript용 시작 가이드입니다.
- 개츠비에 대한 기본적인 이해와 어떻게 역동적인 페이지가 만들어지는지에 대한 이해. 여기 개츠비를 배우기 위한 훌륭한 단계별 튜토리얼 가이드에 대한 링크가 있다.
- WordPress 및 작업 설치에 익숙합니다. 다음은 시작하는 데 도움이 되는 가이드입니다.

### 자산 및 리소스

저는 이미 과거에 몇 가지 개츠비 학습 프로젝트를 해왔기 때문에, 타이포그래피, 레이아웃, 그리고 여기에 적용할 수 있는 다른 재사용 가능한 부품들과 같은 자산들을 가지고 있었습니다. 또한 이 프로젝트를 준비하는 데 도움이 되는 다음과 같은 최근 튜토리얼 가이드를 살펴 보았습니다.

- 개요 – Henrik Wirth의 미리 보기, i18n 및 그 이상의 Gatsby Word Press Starter Advanced 가이드
- Jason Lensstorf의 Word Press 사이트를 Jamstack으로 마이그레이션
- 무함마드 무신의 스물아홉 단어 표제

Henrick Wirth의 가이드는 이해력이 뛰어나고 철저하다. Jason의 단계별 기사는 훌륭한 자료이며 프로세스가 진행되는 것을 볼 수 있도록 도와주는 매우 유용한 동영상도 포함하고 있습니다. 무함마드의 글은 개츠비가 만든 페이지 API로 정적 페이지가 어떻게 생성되는지 설명하고, 그 과정에서 다양한 기능, 템플릿 파일, 리액트 구성 요소를 분해하는 데 도움이 된다.

나는 대체로 헨릭의 가이드를 따라 이 기사를 비슷한 섹션으로 나누었다. Henrik의 가이드에는 여기에서 다루지 않는 ACF Flexible Content 기능을 갖춘 PageBuilder가 포함되어 있습니다.

### 섹션 1: 워드프레스 및 개츠비 설정

먼저 데이터 소스에 대한 WordPress 사이트를 설정하겠습니다. 이 사이트는 이미 존재하는 사이트이거나 새로 만든 사이트일 수 있습니다. 로컬 WordPress 설치도 괜찮습니다. 저는 이 프로젝트를 위한 새로운 테스트 WordPress 사이트에서 WordPress와 함께 제공되는 Twice Tweet 20 테마로 시작하기로 결정했습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/07/63LGG0lL.png?resize=998%2C580&ssl=1)

먼저 WordPress에 몇 개의 플러그인을 설치하는 것부터 시작하겠습니다. WPgrapQL을 사용하여 WordPress에서 GraphQL API를 활성화하고 WordPress를 데이터 소스로 개방하겠습니다. WPgrapiQL도 사용할 것입니다(이름의 "i"를 참고하십시오). 이것은 실제로 선택 사항이지만 WordPress 대시보드에서 GraphQL 쿼리를 직접 테스트하기 위한 인터페이스를 만들 수 있어 매우 편리하다. WordPress Plugin 디렉토리 대신 플러그인에 대한 GitHub 저장소에 연결하는 것을 알 수 있으며, 이는 의도적인 것입니다. 이 작성 시점의 디렉토리에서는 어떤 플러그인도 사용할 수 없습니다. 따라서 ZIP 파일을 다운로드하여 `/wp-content/plugins` 디렉토리를 통해 WordPress에 수동으로 설치합니다.

활성화된 후에는 WordPress 대시보드에 GraphiQL API가 표시됩니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/07/KL6KfPSE.png?resize=800%2C120&ssl=1)

그래피큐L API는 WordPress 사이트의 GraphQL 쿼리를 테스트할 수 있는 놀이터를 제공합니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/07/0EeyRIYv.png?fit=1024%2C529&ssl=1)

우리는 다음과 같은 명령행으로 프로젝트의 워드프레스개츠비 디렉토리에 개츠비의 초기 디폴트를 설치하여 개츠비 사이트를 설립할 것이다.

```terminal
#! create a new Gatsby site using the default starter
gatsby new wordpress-gatsby https://github.com/gatsbyjs/gatsby-starter-default
```

다시 시작`gatsby develop`과 서버, 그럼 `localhost:8000`에 새로운 브라우저 탭으로 항해하자. 우리는 브라우저에 시작 페이지가 있어야 합니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/07/uyDCEEDH.png?resize=800%2C280&ssl=1)

개츠비 문서를 통해 개츠비 사이트를 로컬로 만드는 방법에 대한 링크가 제공됩니다.

다음으로 개츠 소스-그래프ql 플러그인을 설치하고 구성합니다. WordPress를 설치할 때와 마찬가지로 개츠비 사이트에도 WPgrapQL을 설치하고 구성해야 한다.

```terminal
#! install wpgraphql plugin
#! add with yarn
yarn add gatsby-source-graphql
#! install with npm
npm install --save gatsby-source-graphql
```

이제 개츠비-소스-그래프ql 플러그인을 구성할 차례입니다. gatsby-config.js 파일을 열고 다음 설정을 사용합니다.

```js
// plugin configuration
module.exports = {
  plugins: [
    {
      resolve: "gatsby-source-graphql",
      options: {
        typeName: "WPGraphQL",
        fieldName: "wpcontent",
        // GraphQL endpoint, relative to your WordPress home URL.
        url: "https://tinjurewp.com/wp-gatsby/graphql",
        // GraphQL endpoint using env variable
       // url: "${process.env.WORDPRESS_URL}/graphql",
      },
    },
  ],
} 

```

내가 어떻게 이런 정확한 구성을 만들었을까? 나는 개츠비 문서에 기술된 것을 엄격하게 따랐다. 이 플러그인은 Gatsby 인스턴스에 GraphQL 끝점의 URL(위 강조 표시)과 원격 스키마 쿼리 유형인 `typeName`과 개츠비 쿼리에서 사용할 수 있는 `fieldName`의 두 가지 구성 옵션을 지정하여 추가되었다. 최신 WPGrapQL 문서는 가이드에 설명된 wpgraphql 대신 fieldName: wpcontent를 사용하는 것을 제안합니다.

선택적으로 dotenv npm 모듈을 사용하여 개발 환경을 사용자 지정하는 데 사용되는 환경 변수를 정의할 수 있었다. 헨릭은 그의 가이드에서도 이 방법을 사용한다.

이 방법을 사용하는 경우 WordPress URL을 노출하는 대신 `WORDPRESS_URL`과 같은 `.env.production` 플러그인 구성 파일의 변수를 정의하고 사용할 수 있습니다.

```
# .env.production
# Don't put any sensible data here!!!
WORDPRESS_URL=https://tinjurewp.com/wp-gatsby/
```

내 테스트 환경은 WordPress 인스턴스와 데이터를 `WPgrapQL`에 동일하게 노출합니다.

콜비 페이옥은 개츠비, 넷리파이와 함께 환경변수 사용에 대한 유용한 단계별 가이드를 가지고 있다.

개발 서버를 다시 시작한 후 WPgrapQL API는 Gatsby와 함께 WordPress 사이트에서 쿼리 및 검색하여 로컬 호스트 GraphQL URL을 통해 개츠비 사이트에 표시할 수 있다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/07/EGsltkuq.png?resize=1181%2C647&ssl=1)

### 섹션 2: WordPress의 게시물 및 페이지 포팅

개츠비에서, 게시물과 페이지는 빌드 시 GraphQL로 데이터를 쿼리하고 쿼리 결과를 게시물이나 페이지 템플릿에 매핑함으로써 생성될 수 있다. 이 과정은 데이터에서 페이지를 프로그래밍 방식으로 생성하는 개츠비 튜토리얼에 설명되어 있다. 개츠비는 `onCreateNode`와 `CreatePages`라는 두 가지 API를 활용하며, 자습서에는 이러한 API의 구현 방법에 대한 자세한 설명이 포함되어 있다.

여기 코드 조각들은 헨릭의 가이드에서 나온 것이다. WordPress는 다른 데이터 유형과 카테고리에 따라 데이터베이스에 데이터를 저장하는 방식 때문에 모든 콘텐츠를 포팅하는 것이 간단하지 않은 것으로 드러났습니다. 하지만 개츠비 `create Pags` API와 노드 API로 페이지와 게시물을 만드는 것에 대한 사전 지식으로 따라갈 수 있었다. 또한 많은 실제 스타터 사이트도 예로 참조할 수 있습니다.

아직 게시물이 없는 경우 WordPress 사이트에 게시물과 페이지를 추가하십시오. 해당 콘텐츠에 대한 페이지를 만들기 전에 개츠비 사이트의 페이지 폴더에서 index.js와 page-2.js를 삭제해야 한다. 이 두 파일은 포트 WordPress 데이터를 간섭하는 것 같습니다.

컨텐츠용 템플릿 파일 2개를 생성합니다. 하나는 게시물용(`/src/템플릿/posts/index.js`), 다른 하나는 페이지용(`/src/템플릿/페이지/index.js`)입니다.

여기 우리의 우편 템플릿이 있습니다. 기본적으로, 우리는 게시물 제목을 두 번 사용하고 있습니다. (하나는 SEO 페이지 제목이고 하나는 게시물 제목입니다.) 그리고 게시물 내용을 게시물 구성요소로 사용합니다.

```js
// src/templates/post/index.js
import React  from "react"
import Layout from "../../components/layout"
import SEO from "../../components/SEO"
 
const Post = ({ pageContext }) => {
  const post = pageContext.post
 
  return (
    <Layout>
      <SEO title={post.title} />
 
      <h1> {post.title} </h1>
      <div dangerouslySetInnerHTML={__html: post.content} />
 
    </Layout>
  )
}
 
export default Post
```

페이지 템플릿에 대해 거의 동일한 작업을 수행합니다.

```js
//src/templates/pages/index.js

import React  from "react"
import Layout from "../../components/layout"
import SEO from "../../components/seo"
 
const Page = ({ pageContext }) => {
  const page = pageContext.page
 
  return (
    <Layout>
      <SEO title={page.title} />
 
      <h1>{page.title}</h1>
      <div dangerouslySetInnerHTML={__html: page.content} />
 
    </Layout>
  )
}
 
export default Page
```

여기서 다루는 전체 코드는 `node.js` 파일에 기록될 수 있습니다. 그러나, 읽기 쉽도록, 게시물과 페이지는 Henrik`s Guide에 따라 프로젝트의 루트 디렉토리에 있는 create라는 이름의 폴더에 분리된다.

우리는 GraphQL `create Pages` API로 우리의 손을 더럽힐 것이다! 먼저 `gatsby-node.js`에 다음을 추가하는 것으로 시작하겠습니다.

```js
// gatsby-node.js
const createPages = require("./create/createPages")
const createPosts = require("./create/createPosts")
 
 exports.createPagesStatefully = async ({ graphql, actions, reporter }, options) => {
  await createPages({ actions, graphql, reporter }, options)
  await createPosts({ actions, graphql, reporter }, options)
 }
```

무함마드의 게시물은 여기서 전화할 가치가 있는 좋은 요점을 말해준다.

> CreatePages API는 개츠비가 노출하는 노드 API의 일부이다. 그것은 근본적으로 개츠비에게 페이지를 추가하라고 지시한다. 이 안에서 우리는 'sync/wait'(ECMAScript 2017의 기능)을 사용하여 몇 가지 방법을 호출하고 있다.

즉, 두 함수 모두 관련 정적 페이지를 생성합니다. 이를 고려하여 사용할 데이터를 정의하고 `create/createPages.js` 파일로 데이터를 가져오도록 하겠습니다. 큰 코드 덤프 미안해 하지만 헨릭의 코멘트는 무슨 일이 일어나고 있는지 설명하는 데 도움이 돼

```js
//create/createPages.js
const pageTemplate = require.resolve('../src/templates/page/index.js');
 
const GET_PAGES = `
  query GET_PAGES($first:Int $after:String) {
    wpgraphql {
      pages(
        first: $first
        after: $after
        # This will make sure to only get the parent nodes and no children
        where: {
          parent: null
         }
      ) {
        pageInfo {
          hasNextPage
          endCursor
        }
        nodes {
          id
          title
          pageId
          content
          uri
          isFrontPage
        }
      }
    }
  }
`
 
const allPages = []
let pageNumber = 0
const itemsPerPage = 10
 
/** This is the export which Gatbsy will use to process.
 * @param { actions, graphql }
 * @returns {Promise<void>} */
module.exports = async ({ actions, graphql, reporter }, options) => {
 
  /** This is the method from Gatsby that we're going
   * to use to create pages in our static site. */
  const { createPage } = actions
  /** Fetch pages method. This accepts variables to alter
   * the query. The variable `first` controls how many items to
   * request per fetch and the `after` controls where to start in
   * the dataset.
   * @param variables
   * @returns {Promise<*>} */
  const fetchPages = async (variables) =>
    /** Fetch pages using the GET_PAGES query and the variables passed in. */
    await graphql(GET_PAGES, variables).then(({ data }) => {
      /** Extract the data from the GraphQL query results */
      const {
        wpgraphql: {
          pages: {
            nodes,
            pageInfo: { hasNextPage, endCursor },
          },
        },
      } = data
 
      /** Map over the pages for later creation */
      nodes
      && nodes.map((pages) => {
        allPages.push(pages)
      })
 
      /** If there's another page, fetch more
       * so we can have all the data we need. */
      if (hasNextPage) {
        pageNumber++
        reporter.info(`fetch page ${pageNumber} of pages...`)
        return fetchPages({ first: itemsPerPage, after: endCursor })
      }
 
      /** Once we're done, return all the pages
       * so we can create the necessary pages with
       * all the data on hand. */
      return allPages
    })
 
  /** Kick off our `fetchPages` method which will get us all
   * the pages we need to create individual pages. */
  await fetchPages({ first: itemsPerPage, after: null }).then((wpPages) => {
 
    wpPages && wpPages.map((page) => {
      let pagePath = `${page.uri}`
 
      /** If the page is the front page, the page path should not be the uri,
       * but the root path '/'. */
      if(page.isFrontPage) {
        pagePath = '/'
      }
 
      createPage({
        path: pagePath,
        component: pageTemplate,
        context: {
          page: page,
        },
      })
 
      reporter.info(`page created: ${page.uri}`)
    })
 
    reporter.info(`# -----> PAGES TOTAL: ${wpPages.length}`)
  })
}
```

이번에도 무함마드의 게시물은 `createPages.js`와 `createPosts.js` 기능이 할 수 있는 일을 세분화해 주기 때문에 큰 도움이 된다. 헨릭의 가이드는 또한 각 단계에 대한 유용한 코멘트를 제공합니다.

createPosts.js 파일은 createPages.js와 거의 동일합니다. 유일한 차이점은 경로 앞에 blog/를 붙이고 코드 전체에서 "page"를 "posts"로 바꾼 것이다.

여기서 멈춰서 터미널의 `개츠 바이 디벨롭`으로 개발 서버를 재시작하면 개발 로그가 페이지 축적을 표시합니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/07/KFWzvFu8.png?resize=1006%2C262&ssl=1)

이제 브라우저에서 localhost:8000을 열면 404 오류가 발생합니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/07/6DbmT_FE.png?resize=1060%2C654&ssl=1)

그건 좀 언짢아도 괜찮아. 404 페이지의 링크를 클릭하면 WordPress 데이터 원본의 올바른 페이지 또는 게시물이 표시됩니다. 예를 들어 샘플 페이지 링크를 클릭하면 브라우저에 WordPress의 샘플 페이지 내용이 표시됩니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/07/JpiBGqol.png?resize=1004%2C368&ssl=1)

### 섹션 3: 내비게이션 작업

저희 사이트 탐색 메뉴로 이동하겠습니다. WordPress에는 페이지, 게시물, 아카이브, 분류법 및 사용자 정의 링크에 대한 링크를 사용하여 메뉴를 구성할 수 있는 탐색 관리 기능이 있습니다. 우리는 WordPress에 메인 메뉴에 대한 내비게이션을 만들어서 GraphQL로 보내서 우리 사이트에 대해 쿼리할 수 있기를 원합니다.

페이지와 포스트 링크를 포함한 내비게이션 링크는 개츠비에서 내장된 `<링크>` 컴포넌트와 `내비게이션` 기능을 모두 사용하는 개츠비 링크 API를 사용하여 생성된다. `<Link>` 구성 요소는 외부 링크에 연결하지 않고 내부 페이지에 연결하는 데 사용됩니다.

워드프레스에서 내비게이션 메뉴를 개츠비 사이트로 포팅하는 것은 `메뉴`와 `메뉴 아이템` 구성 요소를 만들고 그에 따라 `레이아웃` 구성 요소를 리팩터링해야 하는 까다로운 작은 작업으로 밝혀졌다. 작동 방식은 이렇습니다.

이 절에 사용된 코드 조각은 완전성을 위해 헨릭의 가이드에서 직접 가져온 것이지만, 이러한 코드 조각은 거의 변형되지 않은 다른 개츠비 워드프레스 시작기에서 사용되는 꽤 표준으로 보인다.

가이드에 설명된 대로 "Primary"라는 메뉴를 설정하는 것이 중요합니다. 이 메뉴는 20 테마에 정의되어 있습니다. 이 안에 세 개의 링크를 던질 것입니다.

- 홈: 당사 홈페이지 링크. 이 링크는 당사 사이트 인덱스를 가리키는 사용자 지정 링크가 될 것입니다.
- 샘플 페이지: WordPress가 새 WordPress 설치에 생성하는 기본 페이지입니다.
- 앞 페이지: 이것은 일반적으로 WordPress의 홈페이지 이름이다. 편집기에서 이 페이지를 작성해야 합니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/07/zU1yMZjC.png?resize=736%2C531&ssl=1)

다음은 `GraphiQL` 인터페이스에서 메뉴 항목에 대한 조회를 작성하겠습니다. 몇 개의 상자를 선택하면 탐색기를 사용하여 실제로 작성할 수 있습니다.

```js
query MyQuery {
  menuItems(where: {location: PRIMARY}) {
    nodes {
      label
      url
      title
      target
    }
  }
}
```

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/07/J4mdnHhf.png?fit=1024%2C576&ssl=1)

데이터의 URL이 전체 주소를 표시하는 절대적인 방법을 볼 수 있습니까? 이러한 URL을 상대 URL로 변환하려면 유틸리티 기능이 필요합니다. `<Link>` 구성 요소가 이를 지원하기 때문입니다.

Henrik의 가이드는 절대 WordPress URL을 개츠비에 필요한 상대 URL로 변환하기 위한 다음과 같은 유틸리티 기능을 제공한다.

```js
// src/utils/index.js
/** Parses a menu item object and returns Gatsby-field URI.
 * @param {object} menuItem a single menu item
 * @param wordPressUrl
 * @param blogURI */
export const CreateLocalLink = (menuItem, wordPressUrl, blogURI='blog/') => {
  const { url, connectedObject } = menuItem;
 
  if (url === '#') {
    return null;
  }
  /** Always want to pull of our API URL */
  let newUri = url.replace(wordPressUrl, '');
 
  /** If it's a blog link, respect the users blogURI setting */
  if (connectedObject && connectedObject.__typename === 'WPGraphQL_Post') {
    newUri = blogURI + newUri;
  }
 
  return newUri;
};
```

다음 단계는 이전 단계에서 생성된 유틸리티 기능을 활용하는 `<MenuItem> 구성 요소를 생성하는 것입니다. 그 결과는 개츠비 사이트 메뉴에 의해 소비되는 완전히 형성된 링크이다.

```js
// src/components/MenuItem.js
import React from "react"
import { CreateLocalLink } from "../utils"
import { Link } from "gatsby"
 
const MenuItem = ({ menuItem, wordPressUrl }) => {
  return (
    <Link style={marginRight: '20px' }
     to={CreateLocalLink(menuItem, wordPressUrl)}>
     {menuItem.label}
     </Link>
  )
}
 
export default MenuItem
```

네, URL과 기능하는 `<MenuItem>` 구성 요소를 생성했습니다. `<MenuItem>` 구성 요소를 이동할 수 있는 새로운 `<Menu> 구성 요소를 생성해 보겠습니다. Gatsby `StaticQuery` API는 GraphQL로 모든 기본 메뉴 항목을 쿼리하는 데 사용된다.

```js
// src/components/Menu.js
import React from "react"
import { StaticQuery, graphql } from "gatsby"
import MenuItem from "./MenuItem"
 
/** Define MenuItem fragment and get all primary menu items */
const MENU_QUERY = graphql`
  fragment MenuItem on WPGraphQL_MenuItem {
    id
    label
    url
    title
    target
  }
 
  query GETMAINMENU {
    wpgraphql {
      menuItems(where: {location: PRIMARY}) {
        nodes {
          ...MenuItem
        }
      }
      generalSettings {
        url
      }
    }
  }
`
 
const Menu = () => {
  return (
    <StaticQuery
      query={MENU_QUERY}
      render={(data) => {
        if (data.wpgraphql.menuItems) {
          const menuItems = data.wpgraphql.menuItems.nodes
          const wordPressUrl = data.wpgraphql.generalSettings.url
 
       return (
         <div style={ marginBottom: "20px" }>
           {
             menuItems &&
             menuItems.map((menuItem) => (
               <MenuItem key={menuItem.id}
               menuItem={menuItem} wordPressUrl={wordPressUrl}/>
             )
           )}
         </div>
       )
      }
      return null
   }
  />
  )
}
 
export default Menu
```

이 시점에서, 우리는 워드프레스 데이터를 사용하여 개츠비 사이트 메뉴를 구성하는데 필요한 모든 것을 가지고 있다. `<메뉴>` 구성 요소를 `<레이아웃> 구성 요소로 떨어뜨리면 됩니다.

```js
// src/components/layout.js
import React from "react"
import PropTypes from "prop-types"
import useSiteMetadata from '../components/siteMetadata';
import Header from "./Header"
import Footer from "./Footer"
import Menu from "./Menu"
import "./layout.css"
 
const Layout = ({ children }) => {
  const { title, description } = useSiteMetadata();
 
  return (
    <section>
      <Header siteTitle={title} description={description} />
      <div
      style={ margin: `0 auto`, maxWidth: 960,
               padding: `0 1.0875rem 1.45rem`,}>
        <Menu />
        <main>{children}</main>
        <Footer />
      </div>
    </section>
  )
}
 
Layout.propTypes = {
  children: PropTypes.node.isRequired,
}
 
export default Layout 
 

```

개츠비의 <링크> 컴포넌트에 관한 문서에서는 워드프레스 같은 외부 CMS에서 나온 데이터를 <링크> 컴포넌트에 의해 이상적으로 검사되어야 하며 개츠비의 <링크> 또는 그에 따라 일반 <a> 태그로 렌더링해야 한다고 설명하고 있다. 이렇게 하면 워드프레스 측의 진정한 외부 링크는 `<Link>` 구성요소와 충돌하지 않고 절대적인 상태를 유지할 수 있다.

이를 위해서는 정확히 그렇게 하는 또 다른 구성요소가 필요합니다. 개츠비 워드프로세서에서는 개츠비 호환의 <링크> 컴포넌트나 전통적인 <a> 요소를 반환하는 <유니버설 링크>라고 부른다.

```js
//src/components/UniversalLink.js
import React from "react"
import { Link as GatsbyLink } from "gatsby"
 
const UniversalLink = ({ children, to, activeClassName, partiallyActive, ...other }) => {
  const internal = /^\/(?!\/)/.test(to)
  // Use Gatsby Link for internal links, and <a> for others
  if (internal) {
    return (
      <GatsbyLink
        to={to}
        activeClassName={activeClassName}
        partiallyActive={partiallyActive}
        {...other}
      >
        {children}
      </GatsbyLink>
    )
  }
  return (
    <a href={to} {...other}>
      {children}
    </a>
  )
}
export default UniversalLink
```

이제 `<메뉴 항목>` 구성 요소로 돌아가서 `<유니버설 링크>를 사용하도록 업데이트하겠습니다.

```js
/ src/components/MenuItem.js
import React from "react"
import { CreateLocalLink } from "../utils"
import UniversalLink from "./UniversalLink"
 
const MenuItem = ({ menuItem, wordPressUrl }) => {
  return (
    <UniversalLink style={marginRight: '20px' }
      to={CreateLocalLink(menuItem, wordPressUrl)}>
      {menuItem.label}
    </UniversalLink>
  )
}
 
export default MenuItem 
 
 
 
 

```

확인하실 준비가 되셨습니까? gats by develop으로 로컬 서버를 재시작하면 브라우저에 상대 페이지 경로에 대한 링크가 포함된 항목이 포함된 탐색 메뉴가 표시됩니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/07/dVrWQ4-J.png?resize=901%2C310&ssl=1)

### 섹션 4: 개츠비에 블로그 게시물 표시

우리는 지금 상당히 좋은 상태에 있습니다. 하지만 우리가 해결해야 할 중요한 문제가 있습니다. 사이트에 페이지를 표시하는 것입니다. 우리는 `createPages.js`와 `createPosts.js`에서 모든 것을 묶기 전에 특히 블로그 포스트 템플릿과 포스트 이미지를 위한 몇 가지 새로운 구성 요소를 만드는 등 이 섹션에서 이러한 작업을 수행하기 위한 단계를 살펴볼 것이다.

당신은 이미 워드프레스에 당신의 페이지와 게시물을 작성했습니까? 그렇지 않다면, 지금이 바로 뛰어들어서 할 수 있는 좋은 시기입니다.

```js
// global variable
const Globals = {
  blogURI: ''
}
module.exports = Globals 

```

블로그URI = `` URL 경로는 워드프레스 관리자(`설정` → `읽기`)의 홈페이지 설정이 "최신 게시물" 옵션으로 설정되어 있을 때 사용됩니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/07/page-setting-scrn.png?resize=1011%2C768&ssl=1)

정적 페이지 옵션을 대신 사용할 계획이라면글로벌 변수 파일에는 URI= `global`을 사용해야 합니다.

이 템플릿은 게시된 모든 게시물 표시를 처리합니다. 여기에는 아직 존재하지 않는 포스트엔트리(PostEntry)와 페이지(Pagination)라는 두 가지 구성 요소가 사용됩니다. 잠시 후에 알려드리겠습니다.

```js
// src/templates/post/blog.js
import React from "react"
import Layout from "../../components/Layout"
import PostEntry from "../../components/PostEntry"
import Pagination from "../../components/Pagination"
import SEO from "../../components/SEO"
 
const Blog = ({ pageContext }) => {
  const { nodes, pageNumber, hasNextPage, itemsPerPage, allPosts }
  = pageContext
 
  return (
    <Layout>
      <SEO
        title="Blog"
        description="Blog posts"
        keywords={[`blog`]}
      />
      {nodes && nodes.map(post => <PostEntry key={post.postId}
        post={post}/>)}
      <Pagination
        pageNumber={pageNumber}
        hasNextPage={hasNextPage}
        allPosts={allPosts}
        itemsPerPage={itemsPerPage}
      />
    </Layout>
  )
}
 
export default Blog
```

이 구성 요소는 게시물을 통해 반복하기 위해 `archive.js` 및 기타 구성 요소 내에서 사용되며, 게시물 제목, 특징 이미지(있는 경우), 발췌, URL(WordPress 구문으로는 슬러그)을 표시합니다.

```js
// src/components/PostEntry.js
import React from "react"
import { Link } from "gatsby"
import Image from "./Image"
import { blogURI } from "../../globals"
 
const PostEntry = ({ post }) => {
  const { uri, title, featuredImage, excerpt } = post 
  return (
    <div style={ marginBottom: "30px" }>
      <header>
        <Link to={`${blogURI}/${uri}/`}>
          <h2 style={ marginBottom: "5px" }>{title}</h2>
          <Image image={featuredImage} style={ margin: 0 }/>
        </Link>
      </header>
 
      <div dangerouslySetInnerHTML={ __html: excerpt }/>
    </div>
  )
}

export default PostEntry
```

개츠비 디폴트 스타터는 이미지 컴포넌트와 함께 나오는데 대부분의 경우 잘 작동한다. 이 예에서는 WordPress에서 게시물의 피처링 이미지로 사용된 이미지 파일을 가져오고 Henrik의 가이드에 설명된 피처링 이미지가 없는 경우 예비 이미지를 지정합니다.

```js
// src/components/Image.js
import React from "react"
import { useStaticQuery, graphql } from "gatsby"
 
const Image = ({ image, withFallback = false, ...props }) => {
  const data = useStaticQuery(graphql`
    query {
      fallBackImage: file(relativePath: { eq: "fallback.svg" }) {
        publicURL
      }
    }
  `)
 
  /* Fallback image */
  if (!image) {
    return withFallback ? <img src={data.fallBackImage.publicURL}
      alt={"Fallback"} {...props}/> : null
  }
 
  return <img src={image.sourceUrl} alt={image.altText} {...props}/>
}
 
export default Image
```

기본 개츠비 구성 요소 파일에 있는 것처럼 `false`를 `false`로 설정하면 DOM 요소가 렌더링되지 않습니다.

Pagination 구성 요소를 사용하면 포스트 인덱스에서 페이지당 지정된 수의 게시물을 표시할 수 있습니다. WordPress에는 다음 및 이전 링크를 반환하여 한 번에 한 페이지씩 탐색하는 페이지 번호와 연결된 페이지 번호를 제공하는 페이지 유형이 있습니다. 우리는 이 구성 요소에서 전자와 협력하고 있습니다.

```js
// src/components/Pagination.js
import React from "react"
import { Link } from "gatsby"
import { blogURI } from "../../globals"
 
const Pagination = ({ pageNumber, hasNextPage }) => {
  if (pageNumber === 1 && !hasNextPage) return null
 
  return (
    <div style={ margin: "60px auto 20px", textAlign: "center" }>
      <div className="nav-links">
        {
          pageNumber > 1 && (
            <Link
              className="prev page-numbers"
              style={
                padding: "8px 8px 5px 4px",
              }
           to={pageNumber > 2 ? `${blogURI}/page/${pageNumber - 1}`: `${blogURI}/`}
            >
              ← <span> Previous</span>
            </Link>
          )
        }
          <span className="meta-nav screen-reader-text"></span>
          {pageNumber}
        </span>
 
        {
          hasNextPage && (
            <Link
              style={
                padding: "4px 8px 5px 8px",
              }
              className="next page-numbers"
              to={`${blogURI}/page/${pageNumber + 1}`
              }
            >
              <span>Next </span> →
            </Link>
          )
        }
      </div>
    </div>
  )
}
 
export default Pagination 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

```

7호선에는 `pageNumber === 1일 경우 `page`를 반환하는 조건문이 있습니다.

우리는 파일을 만든 이후 우리가 했던 모든 작업을 반영하기 위해 `createPages.js` 파일을 정리해야 합니다. 파일이 너무 커져서 추적 중인 모든 파일이 너무 커집니다. 설명서에 따르면 코드를 체계적이고 체계적으로 유지하기 위해 GraphQL 조각을 사용하면 "복잡한 쿼리를 더 작고 이해하기 쉬운 구성 요소로 분할할 수 있다"고 한다.

그래프QL 조각은 필드 집합을 구성하고 필요한 경우 쿼리에 포함할 수 있는 재사용 가능한 단위입니다.

Henrik의 안내에 따르면, 포스트 템플릿 및 포스트 프리뷰에 대한 GraphQL 쿼리 필드는 `data.js` 파일에 저장됩니다.

```js
// src/templates/posts/data.js
const PostTemplateFragment = `
  fragment PostTemplateFragment on WPGraphQL_Post {
    id
    postId
    title
    content
    link
    featuredImage {
      sourceUrl
    }
    categories {
      nodes {
        name
        slug
        id
      }
    }
    tags {
      nodes {
        slug
        name
        id
      }
    }
    author {
      name
      slug
    }
  }
`
 
const BlogPreviewFragment = `
  fragment BlogPreviewFragment on WPGraphQL_Post {
    id
    postId
    title
    uri
    date
    slug
    excerpt
    content
    featuredImage {
      sourceUrl
    }
    author {
      name
      slug
    }
  }
`
 
module.exports.PostTemplateFragment = PostTemplateFragment
module.exports.BlogPreviewFragment = BlogPreviewFragment
```

다음으로, 가이드에 설명된 대로 `create/createPosts.js` 파일을 리팩토링하려면 라인 4의 `const = GET_POSTs=` 쿼리 문 바로 위에 `createPosts.js`(라인 2-10)의 상단 섹션에 다음 코드를 추가해야 합니다.

```js
// create/createPosts.js
const {
  PostTemplateFragment,
  BlogPreviewFragment,
} = require("../src/templates/posts/data.js")
 
const { blogURI } = require("../globals")
 
const postTemplate = require.resolve("../src/templates/posts/index.js")
const blogTemplate = require.resolve("../src/templates/posts/blog.js")
 
const GET_POSTS = `
  # Here we make use of the imported fragments which are referenced above
  ${PostTemplateFragment}
  ${BlogPreviewFragment}
  query GET_POSTS($first:Int $after:String) {
    wpgraphql {
      posts(
       first: $first
       after: $after
       # This will make sure to only get the parent nodes and no children
       where: {
         parent: null
       }
      ) {
         pageInfo {
           hasNextPage
           endCursor
         }
         nodes {
           uri
 
           # This is the fragment used for the Post Template
           ...PostTemplateFragment
 
           #This is the fragment used for the blog preview on archive pages
          ...BlogPreviewFragment
        }
      }
    }
 }
` 
 
 
 
 
 
 
 
 
 
 
 

```

여기서, 이전 단계(9-10선)에서 생성된 조각 문자열은 `GET_POSTs` 쿼리(12호선) 외부에서 가져오고 등록되며, `GET_POSTs($first:)` 내에서 조각(34 및 37선)으로 사용됩니다.이후 $ 단위:문자열) 쿼리입니다.

createPosts.js 파일의 아래쪽에 있는 `blogPage` 경로는 글로벌 `blog`로 정의됩니다.URI 변수(36-41)와 코드를 추가하여 페이지 지정 블로그 페이지(99-111)를 만들었습니다.

```js
// create/createPosts.js
// Previous code excluded
 
const allPosts = []
const blogPages = [];
let pageNumber = 0;
const itemsPerPage = 10;
 
/** This is the export which Gatbsy will use to process.
 * @param { actions, graphql }
 * @returns {Promise<void>} */
module.exports = async ({ actions, graphql, reporter }, options) => {
 
  /** This is the method from Gatsby that we're going
   * to use to create posts in our static site */
  const { createPage } = actions
 
  /** Fetch posts method. This accepts variables to alter
   * the query. The variable `first` controls how many items to
   * request per fetch and the `after` controls where to start in
   * the dataset.
   * @param variables
   * @returns {Promise<*>} */
  const fetchPosts = async (variables) =>
    /** Fetch posts using the GET_POSTS query and the variables passed in */
    await graphql(GET_POSTS, variables).then(({ data }) => {
      /** Extract the data from the GraphQL query results */
      const {
        wpgraphql: {
          posts: {
            nodes,
            pageInfo: { hasNextPage, endCursor },
          },
        },
      } = data
 
      /** Define the path for the paginated blog page.
       * This is the url the page will live at
       * @type {string} */
      const blogPagePath = !variables.after
        ? `${blogURI}/`
        : `${blogURI}/page/${pageNumber + 1}`
 
      /** Add config for the blogPage to the blogPage array for creating later
       * @type {
       *   path: string,
       *   component: string,
       *   context: {nodes: *, pageNumber: number, hasNextPage: *} } */
      blogPages[pageNumber] = {
        path: blogPagePath,
        component: blogTemplate,
        context: {
          nodes,
          pageNumber: pageNumber + 1,
          hasNextPage,
          itemsPerPage,
          allPosts,
        },
      }
 
      /** Map over the posts for later creation */
      nodes
      && nodes.map((posts) => {
        allPosts.push(posts)
      })
 
     /** If there's another post, fetch more so we can have all the data we need */
      if (hasNextPage) {
        pageNumber++
        reporter.info(`fetch post ${pageNumber} of posts...`)
        return fetchPosts({ first: itemsPerPage, after: endCursor })
      }
 
      /** Once we're done, return all the posts so we can
       * create the necessary posts with all the data on hand */
      return allPosts
    })
 
  /** Kick off our `fetchPosts` method which will get us all
   * the posts we need to create individual posts */
  await fetchPosts({ first: itemsPerPage, after: null }).then((wpPosts) => {
 
    wpPosts && wpPosts.map((post) => {
      /** Build post path based of theme blogURI setting */
      const path = `${blogURI}${post.uri}`
 
      createPage({
        path: path,
        component: postTemplate,
        context: {
          post: post,
        },
      })
 
      reporter.info(`post created:  ${path}`)
    })
 
    reporter.info(`# -----> POSTS TOTAL: ${wpPosts.length}`)
 
    /** Map over the `blogPages` array to create the
     * paginated blog pages */
    blogPages
    && blogPages.map((blogPage) => {
      if (blogPage.context.pageNumber === 1) {
        blogPage.context.publisher = true;
        blogPage.context.label = blogPage.path.replace('/', '');
      }
      createPage(blogPage);
      reporter.info(`created blog archive page ${blogPage.context.pageNumber}`);
    });
  })
} 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

```

최종 업데이트된 `create/createPosts.js` 및 `create/createPage.js` 파일은 이 GitHub 저장소에서 사용할 수 있습니다.

무함마드는 그의 스물아홉 포팅 튜토리얼 게시물에서 개츠비의 `createPage`로 작성된 정적 페이지들이 이 예에서 사용된 거의 동일한 코드와 파일 구조를 어떻게 사용하는지 매우 상세하게 묘사하고 있다. 우리의 참고문헌들 사이에 일관성이 형성되어 있는 것을 보니 좋군요.

gats by develop으로 로컬 서버를 다시 시작한 뒤 게시물 제목과 발췌문을 포함한 게시물 루프를 보여주는 화면을 브라우저에 표시해야 한다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/07/4TCk_5oV.png?fit=1024%2C594&ssl=1)

### 섹션 5: 스타일링 및 전개

스타일링, 타이포그래피, 그리고 전개는 모두 우리가 여기서 다루는 범위 밖이지만, 우리는 그것들을 조금 건드릴 수 있습니다. 개츠비의 설명서는 스타일링과 배치/호스팅 옵션 모두에 대한 훌륭한 자료를 제공한다.

개츠비의 문서는 글로벌 CSS 파일, 모듈식 스타일시트 및 CSS-in-JS로 분류된다. Typography.js, Sass, JSS, Stylus, PostCSS 등 다른 스타일링 옵션을 사용할 수 있다.

무함마드는 19단어 프레스 테마를 개츠비에게 포팅하는 동안 테마의 스타일을 포함시켜 개츠비 사이트에서 그것들을 사용할 수 있게 한다. 그는 일부 단위와 가치가 개츠비와 양립할 수 없기 때문에 약간의 조정이 필요하다고 경고한다. 예를 들어 일부 구성 요소에 대해 Flexbox와 함께 사용하기 위해 CSS에서 vw 단위를 조정해야 했다. 비슷하게, Henrik은 Tweet Tweet의 주제를 개츠비에게 포팅하면서, 그의 개츠비의 시작인 Tweet Tweet에서도 글꼴뿐만 아니라 Tweet Tweet 스타일시트를 포팅하는 유사한 과정을 따랐다.

나는 내 프로젝트에 Sass를 사용하기로 결정했다. 이를 위해서는 gats-plugin-ass와 필요한 `노드-sass` 의존성을 설치해야 한다.

```terminal
#! install node-sass & gatsby-sass
yarn add node-sass gatsby-plugin-sass
#! or with npm
npm install --save node-sass gatsby-plugin-sass
```

그런 다음 플러그인을 `gatsby-config.js`에 추가하고 여기에 표시된 것처럼 구성할 수 있습니다.

```js
// gatsby-config.js
module.exports = {
  siteMetadata: {
    plugins: [
      `gatsby-plugin-sass`
    ],
  }
} 

```

이제 다른 Sass 프로젝트에서와 마찬가지로 .scss 파일에 스타일을 작성하고 가져올 수 있습니다.

```js
// using import in a component file
import("./src/styles/global.scss")
 
// using require in the gatsby-browser.js file
require('./src/styles/global.scss')
```

.scss 스타일시트는 글로벌 < 구성 요소가 가져오거나 gatsby-browser.js에 requires 문구와 함께 추가할 수 있다. 이 데모 프로젝트를 위해 메인 페이지에 개츠비의 기본 스타일링을 사용하고 있으며 내용을 그대로 게시했습니다. 나는 아주 기본적인 스타일링으로 `Header.js` 파일을 약간 리팩터링했다.

```js
//src/components/Header.js
import { Link } from "gatsby"
import PropTypes from "prop-types"
import React from "react"
import useSiteMetadata from '../components/siteMetadata';
import Menu from "./Menu"
import "../styles/header.css"
 
const Header = () =>{
  const { title } = useSiteMetadata();
 
  return (
    <header className="header">
      <div className="nav-container brand">
        <Link  to="/"> {title} </Link>
        {/* Menu here */}
        <Menu />
      </div>
    </header>
  )
}
 
Header.propTypes = {
  siteTitle: PropTypes.string,
  description: PropTypes.string,
}
 
Header.defaultProps = {
  siteTitle: ``,
  description: ``,
}
 
export default Header
```

이렇게 하면 "gats by develop"으로 서버를 재시작할 때 사이트 헤더를 얻을 수 있습니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/07/3kiL-KkT.png?resize=1009%2C201&ssl=1)

WordPress 블록 편집기에 대해 잘 알고 있으며 블록이 일반적으로 어떻게 작동하는지 잘 알고 계시리라 생각합니다. 블록 편집기를 릴리스한 이후 WordPress는 블록 콘텐츠에 대해 별도의 스타일 세트를 유지했습니다.

그것은 우리가 테마 스타일을 가진 개츠비에게 그들을 포팅하기 위한 추가 단계가 필요하다는 것을 의미한다. Jason Lengstorf는 그의 튜토리얼 가이드에서 보여준다. 먼저 WordPress 블록 패키지가 설치됩니다.

```terminal
# install wordpress/block-library
npm install @wordpress/block-library
# with yarn add
yarn add @wordpress/block-library
```

그리고 나서 우리는 그 스타일을 개츠비 요소로 가져올 수 있다. `[Layout]` 구성 요소를 살펴보겠습니다.

```js
// src/components/layout.js
import React from "react"
  import { Link } from "gatsby"
 
import "@wordpress/block-library/build-style/style.css"
  import "../styles/layout.css"
 
const Layout = ({ children }) => {
  return (
    <section>
      <header>
        <Link to="/" className="home">
          Gatsby + WP
        </Link>
      </header>
      <main>{children}</main>
    </section>
  )
}
 
export default Layout 

```

블록 편집기는 여전히 활발한 개발 중에 있으며, 이는 상황이 예기치 않게 변경되기 쉽다는 것을 의미합니다. 따라서 사용할 계획이라면 반드시 주의해서 진행하십시오.

Netlifify를 선택한 이유를 설명할 때, Netliify Functions 덕분에 프로젝트의 GitHubrepo에 연결되고 특정 지점으로 푸시할 때 자동으로 배포되기 때문에 이 제품을 선택했습니다.

Netliify는 개츠비 사이트를 Netliify와 연결하는 방법을 설명하는 단계별 가이드를 가지고 있다. 개츠비 문서는 또한 Netliify에 배치하는 것에 대해 설명한다.

마지막으로 내 Netlifify 배포 데모 사이트에 연결합니다.

다시 말해, 이를 통해 레포에 변경 사항이 적용되면 사이트가 자동으로 재구축되는 지속적인 배포가 가능합니다. 게시물 게시 또는 페이지 편집과 같이 WordPress를 변경할 때마다 유사한 프로세스를 원하는 경우 JAMstack Deployments 플러그인을 Jason의 가이드에 설명된 대로 사용할 수 있습니다.

### 아직 진행 중인 작업입니다!

개츠비에게 워드프레스 테마를 포팅하는 과정에서 배운 것이 블로그의 기본 구성 요소를 구축하는 데 아주 좋지만, 아직도 취재해야 할 일이 많다는 것을 깨달았다. 워드프레스는 저자, 카테고리, 태그, 게시물 상태, 사용자 지정 게시물 유형 등을 포함한 너무 많은 데이터를 저장하기 때문에 모든 데이터를 추가로 고려해야 합니다.

하지만 점점 더 많은 수의 분리된 개츠비 워드프레스 사이트 사례들이 있는데, 그 중 몇 가지는 참조용으로 아래에 나열하겠습니다. Henrik의 WordPress-Gatsby 리소스 목록은 WordPress-Gats에 대해 디커플링하여 더 자세히 알 수 있도록 매우 유용합니다.

- 1917년 12월 20일 (현지)
- 개츠비 사이트
- 개츠비 워드프레스 테마 블로그(데모 사이트)
- 개츠비위프소스원.
- Henrik Wirth의 WordPress-Gats 리소스 목록(GitHub 보기)
- GitHub – Tyler Barnes의 개츠비와 WordPress의 미래에 대한 토론

### 크레딧

제가 이 게시물 내내 언급했다는 것을 알지만, Henrick Wirth, Jason Lengstorf, Mohammad Muhsin에게 그들이 한 모든 일을 기록하고, Word Press를 개츠비에게 전달하는 데 필요한 것을 큰 소리로 외쳤습니다. 여기서 제가 취재한 모든 것은 그저 그들의 훌륭한 작품이 축적된 것일 뿐이고 저 같은 초보자에게도 적합한 그런 유익한 가이드를 만들어준 것에 대해 저마다 감사하게 생각합니다. 이 기사를 편집해 주신 CSS-Tricks의 Geoff Graham 씨에게 특별히 감사드립니다.