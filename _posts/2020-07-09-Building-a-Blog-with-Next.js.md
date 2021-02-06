---
layout: post
title: "Next.js를 사용하여 블로그 작성"
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/07/next-js-blog.png"
tags: NEXT.JS
---


이 기사에서는 Next.js를 사용하여 지킬에서 영감을 받은 디자인과 구조로 정적 블로그 프레임워크를 구축할 것이다. 저는 항상 지킬이 어떻게 초보자들이 블로그를 쉽게 설정할 수 있도록 하는가에 대한 열렬한 팬이었고 동시에 고급 사용자들에게 블로그의 모든 측면에 대한 엄청난 통제력을 제공합니다.

최근 몇 년 동안 Next.js의 도입으로 리액트의 인기와 결합되어 정적 블로그를 탐색할 수 있는 새로운 길이 열렸다. next.js를 사용하면 구성이 거의 또는 전혀 필요 없이 파일 시스템 자체를 기반으로 정적 웹 사이트를 쉽게 구축할 수 있습니다.

전형적인 맨본 지킬 블로그의 디렉토리 구조는 다음과 같습니다.

```
.
├─── _posts/          ...blog posts in markdown
├─── _layouts/        ...layouts for different pages
├─── _includes/       ...re-usable components
├─── index.md         ...homepage
└─── config.yml       ...blog config
```

아이디어는 블로그에 정의된 게시물과 구성을 간단히 재사용함으로써 지킬에서 블로그를 마이그레이션하는 것이 더 쉬워지도록 가능한 한 이 디렉토리 구조에 대한 우리의 프레임워크를 설계하는 것이다.

지킬에 익숙하지 않은 사람들을 위해, 그것은 당신의 평범한 텍스트를 정적 웹사이트와 블로그로 바꿀 수 있는 정적 사이트 생성기이다. 지킬과 함께 일어나서 달리려면 빠른 시작 가이드를 참조하십시오.

또한 이 자료에서는 React에 대한 기본 지식을 갖추고 있다고 가정합니다. 그렇지 않다면, Return`s starting`s starting page.

### 설치

next.js는 React에서 전원을 공급받으며 Node.js로 작성된다. 따라서 npm을 먼저 설치해야 다음, react, react-dom을 프로젝트에 추가할 수 있다.

```terminal
mkdir nextjs-blog && cd $_
npm init -y
npm install next react react-dom --save
```

명령줄에서 Next.js 스크립트를 실행하려면 `package`의 `scripts` 섹션에 `next` 명령을 추가해야 합니다.제이슨의

```html
"scripts": {
  "dev": "next"
}
```

이제 처음으로 명령줄에서 npm run dev를 실행할 수 있습니다. 어떻게 되는지 봅시다.

컴파일러가 프로젝트 루트에 누락된 페이지 디렉토리에 대해 불평하고 있습니다. 다음 섹션에서 페이지의 개념에 대해 알아보겠습니다.

### 페이지 개념

next.js는 페이지 개념을 중심으로 작성되었습니다. 각 페이지는 파일 이름을 기준으로 라우트에 매핑되는 `.js` 또는 `.jsx` 유형의 Retact 구성 요소입니다. 예를 들어:

```
File                            Route
----                            -----
/pages/about.js                 /about
/pages/projects/work1.js        /projects/work1
/pages/index.js                 /
```

프로젝트의 루트에 `페이지` 디렉토리를 생성하고 첫 페이지인 `index.js`를 기본 Retact 구성 요소로 채우도록 하겠습니다.

```js
// pages/index.js
export default function Blog() {
  return <div>Welcome to the Next.js blog</div>
}
```

npm run dev를 다시 실행하여 서버를 시작한 후 브라우저에서 http://localhost:3000으로 이동하여 블로그를 처음 봅니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/07/r2LmPyTM.png?resize=1390%2C816&ssl=1)

개봉 즉시 다음과 같은 이점을 얻을 수 있습니다.

- 모든 코드 변경 시 브라우저를 새로 고칠 필요가 없도록 핫 다시 로드합니다.
- /pages/** 디렉토리 내의 모든 페이지의 정적 생성.
- `/public/**` 디렉토리에 있는 자산에 대한 정적 파일 서비스.
- 404 에러페이지.

로컬 호스트의 임의 경로로 이동하여 실행 중인 404 페이지를 확인합니다. 사용자 정의 404 페이지가 필요한 경우 Next.js 문서에는 훌륭한 정보가 있습니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/07/4Ee3BuaM.png?fit=1024%2C645&ssl=1)

### 동적 페이지

정적 경로가 있는 페이지는 홈페이지 구축, 페이지 작성 등에 유용합니다. 그러나 모든 게시물을 동적으로 구축하기 위해 Next.js의 동적 경로 기능을 사용할 것이다. 예를 들어:

```
File                        Route
----                        -----
/pages/posts/[slug].js      /posts/1
                            /posts/abc
                            /posts/hello-world
```

/posts/1 , /posts/abc 등과 같은 모든 경로는 /posts/[slug]로 일치합니다.js` 및 slug 매개 변수는 페이지로 쿼리 매개 변수로 전송됩니다. 이 기능은 게시물당 하나의 파일을 만들고 싶지 않기 때문에 블로그 게시물에 특히 유용합니다. 대신 해당 게시물을 렌더링하기 위해 슬라이더를 동적으로 전달할 수 있습니다.

### 블로그의 해부학

이제 Next.js의 기본 구성 요소를 이해했으므로 블로그의 구조를 정의해 보겠습니다.

```
.
├─ api
│  └─ index.js             # fetch posts, load configs, parse .md files etc
├─ _includes
│  ├─ footer.js            # footer component
│  └─ header.js            # header component
├─ _layouts
│  ├─ default.js           # default layout for static pages like index, about
│  └─ post.js              # post layout inherts from the default layout
├─ pages
│  ├─ index.js             # homepage
|  └─ posts                # posts will be available on the route /posts/
|     └─ [slug].js       # dynamic page to build posts
└─ _posts
   ├─ welcome-to-nextjs.md
   └─ style-guide-101.md
```

### 블로그 API

기본 블로그 프레임워크에는 다음 두 가지 API 기능이 필요합니다.

- `_posts` 디렉토리에 있는 모든 게시물의 메타데이터를 가져오는 함수
- 전체 HTML 및 메타데이터를 사용하여 지정된 `슬러그`에 대한 단일 게시물을 가져오는 함수

선택적으로, 우리는 `config.yml`에 정의된 모든 사이트 구성을 모든 구성 요소에서 사용할 수 있기를 바란다. 그래서 우리는 YAML 구성을 네이티브 객체로 구문 분석하는 기능이 필요합니다.

마크다운(md), YAML(md) 등 자바스크립트가 아닌 파일을 많이 다루게 되므로 문자열 등의 파일을 로드하여 처리하기 쉽도록 할 것이다.

```
npm install raw-loader --save-dev
```

다음으로 프로젝트 루트에 `next.config.js` 파일을 생성하여 .md 및 .yml 파일 형식을 가져올 때 Next.js에 원시 로더를 사용하도록 지시해야 합니다(자세한 정보).

```js
module.exports = {
  target: 'serverless',
  webpack: function (config) {
    config.module.rules.push({test:  /\.md$/, use: 'raw-loader'})
    config.module.rules.push({test: /\.yml$/, use: 'raw-loader'})
    return config
  }
}
```

next.js 9.4는 상대 경로로 인한 수입 명세서 스파게티를 정리하는 데 도움이 되는 상대적인 수입을 위한 별칭을 도입했다. 별칭을 사용하려면 기본 경로와 프로젝트에 필요한 모든 모듈 별칭을 지정하는 프로젝트의 루트 디렉터리에 `jsconfig.json` 파일을 생성하십시오.

```js
{
  "compilerOptions": {
    "baseUrl": "./",
    "paths": {
      "@includes/*": ["_includes/*"],
      "@layouts/*": ["_layouts/*"],
      "@posts/*": ["_posts/*"],
      "@api": ["api/index"],
    }
  }
}
```

예를 들어 다음과 같은 방법으로 레이아웃을 가져올 수 있습니다.

```js
import DefaultLayout from '@layouts/default'
```

이 함수는 `_posts` 디렉토리의 모든 Markdown 파일을 읽고, 게시물의 시작 부분에 정의된 전면 물질을 회색 물질을 사용하여 구문 분석하며, 모든 게시물에 대한 메타데이터 배열을 반환합니다.

```js
// api/index.js
import matter from 'gray-matter'
 
export async function getAllPosts() {
  const context = require.context('../_posts', false, /\.md$/)
  const posts = []
  for(const key of context.keys()){
    const post = key.slice(2);
    const content = await import(`../_posts/${post}`);
    const meta = matter(content.default)
    posts.push({
      slug: post.replace('.md',''),
      title: meta.data.title
    })
  }
  return posts;
}
```

일반적인 Markdown 게시물은 다음과 같습니다.

```markdown
---
title:  "Welcome to Next.js blog!"
---
**Hello world**, this is my first Next.js blog post and it is written in Markdown.
I hope you like it!
```

----로 약술된 부분은 제목, 퍼머링크, 태그 등 게시물의 메타데이터를 보관하는 프론트 머티어라고 한다. 출력은 다음과 같습니다.

```js
[
  { slug: 'style-guide-101', title: 'Style Guide 101' },
  { slug: 'welcome-to-nextjs', title: 'Welcome to Next.js blog!' }
]
```

먼저 `npm install gray-matter --save-dev` 명령을 사용하여 npm부터 gray-matter 라이브러리를 설치해야 합니다.

주어진 슬러그의 경우, 이 함수는 `_posts` 디렉토리에서 파일을 찾고, 표시된 라이브러리로 Markdown을 구문 분석하고 메타데이터가 있는 출력 HTML을 반환합니다.

```js
// api/index.js
import matter from 'gray-matter'
import marked from 'marked'
 
export async function getPostBySlug(slug) {
  const fileContent = await import(`../_posts/${slug}.md`)
  const meta = matter(fileContent.default)
  const content = marked(meta.content)    
  return {
    title: meta.data.title, 
    content: content
  }
}
```

샘플 출력:

```js
{
  title: 'Style Guide 101',
  content: '<p>Incididunt cupidatat eiusmod ...</p>'
}
```

먼저 `npm install marked --save-dev` 명령을 사용하여 npm부터 표시된 라이브러리를 설치해야 합니다.

Next.js 블로그에 대한 지킬 구성을 다시 사용하기 위해, 우리는 `js-yaml` 라이브러리를 사용하여 YAML 파일을 구문 분석하고 여러 구성 요소에서 사용할 수 있도록 이 구성을 내보낼 것이다.

```js
// config.yml
title: "Next.js blog"
description: "This blog is powered by Next.js"
 
// api/index.js
import yaml from 'js-yaml'
export async function getConfig() {
  const config = await import(`../config.yml`)
  return yaml.safeLoad(config.default)
}
```

먼저 `npm install js-yaml --save-dev` 명령을 사용하여 npm에서 `js-yaml`을 설치해야 합니다.

### 포함한다

우리의 `_포함` 디렉토리는 `_layouts` 디렉토리에 정의된 서로 다른 레이아웃 구성 요소에 사용될 두 가지 기본 Retact 구성 요소인 `<Header>와 `<Footer>를 포함한다.

```js
// _includes/header.js
export default function Header() {
  return <header><p>Blog | Powered by Next.js</p></header>
}
 
// _includes/footer.js
export default function Footer() {
  return <footer><p>©2020 | Footer</p></footer>
}
```

### 레이아웃

우리는 `_layouts` 디렉토리에 두 개의 레이아웃 구성 요소를 가지고 있습니다. 하나는 다른 모든 레이아웃 구성요소가 작성될 기본 레이아웃인 <Default Layout>입니다.

```js
// _layouts/default.js
import Head from 'next/head'
import Header from '@includes/header'
import Footer from '@includes/footer'
 
export default function DefaultLayout(props) {
  return (
    <main>
      <Head>
        <title>{props.title}</title>
        <meta name='description' content={props.description}/>
      </Head>
      <Header/>
      {props.children}
      <Footer/>
    </main>
  )
}
```

두 번째 레이아웃은 `Post Layout` 구성 요소로, `Post Layout`에 정의된 제목을 Post 제목으로 재정의하고 게시물의 HTML을 렌더링합니다. 그것은 또한 홈페이지로의 링크도 포함하고 있다.

```js
// _layouts/post.js
import DefaultLayout from '@layouts/default'
import Head from 'next/head'
import Link from 'next/link'
 
export default function PostLayout(props) {
  return (
    <DefaultLayout>
      <Head>
        <title>{props.title}</title>
      </Head>
      <article>
        <h1>{props.title}</h1>
        <div dangerouslySetInnerHTML={__html:props.content}/>
        <div><Link href='/'><a>Home</a></Link></div> 
      </article>
    </DefaultLayout>
  )
}
```

next/head는 페이지의 >head에 요소를 추가하는 내장 구성요소입니다. next/link는 페이지 디렉토리에 정의된 경로 간의 클라이언트 측 전환을 처리하는 기본 제공 구성 요소입니다.

### 홈페이지

인덱스 페이지의 일부로 홈페이지 등 `_posts` 디렉토리에 있는 모든 게시물을 나열하겠습니다. 목록에는 게시물 제목과 개별 게시물 페이지에 대한 영구 링크가 포함됩니다. 인덱스 페이지에는 <기본 레이아웃>이 사용되며, 홈페이지의 구성을 가져와 제목과 설명을 레이아웃에 전달합니다.

```js
// pages/index.js
import DefaultLayout from '@layouts/default'
import Link from 'next/link'
import { getConfig, getAllPosts } from '@api'
 
export default function Blog(props) {
  return (
    <DefaultLayout title={props.title} description={props.description}>
      <p>List of posts:</p>
      <ul>
        {props.posts.map(function(post, idx) {
          return (
            <li key={idx}>
              <Link href={'/posts/'+post.slug}>
                <a>{post.title}</a>
              </Link>
            </li>
          )
        })}
      </ul>
    </DefaultLayout>
  )
} 
 
export async function getStaticProps() {
  const config = await getConfig()
  const allPosts = await getAllPosts()
  return {
    props: {
      posts: allPosts,
      title: config.title,
      description: config.description
    }
  }
}
```

`GetStaticProps`는 빌드 시 호출되어 페이지의 기본 구성 요소에 `prop`를 전달하여 페이지를 미리 렌더링합니다. 빌드 시 모든 게시물의 목록을 가져오고 홈페이지에 게시물 보관을 렌더링하기 위해 이 기능을 사용합니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/07/KJidSMgw.png?resize=1544%2C904&ssl=1)

### 포스트 페이지

이 페이지는 컨텍스트의 일부로 제공되는 `슬러그`에 대한 게시물의 제목과 내용을 렌더링합니다. 포스트 페이지에는 `Post Layout` 구성 요소가 사용됩니다.

```js
// pages/posts/[slug].js
import PostLayout from '@layouts/post'
import { getPostBySlug, getAllPosts } from "@api"
 
export default function Post(props) {
  return <PostLayout title={props.title} content={props.content}/>
}
 
export async function getStaticProps(context) {
  return {
    props: await getPostBySlug(context.params.slug)
  }
}
 
export async function getStaticPaths() {
  let paths = await getAllPosts()
  paths = paths.map(post => ({
    params: { slug:post.slug }
  }));
  return {
    paths: paths,
    fallback: false
  }
}
```

페이지에 동적 경로가 있는 경우 Next.js는 빌드 시 가능한 모든 경로를 알아야 합니다. getStaticPaths는 빌드 시 HTML로 렌더링해야 하는 경로 목록을 제공합니다. 예비 속성을 사용하면 경로 목록에 없는 경로를 방문할 경우 404 페이지가 반환됩니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/07/AXQYtDL4.png?resize=1542%2C908&ssl=1)

### 생산 준비 완료

`패키지`에서 `빌드`와 `스타트`에 대해 다음 명령을 추가합니다.json은 `npm` 섹션에서 `npm run build`를 실행한 다음 `npm run start`를 실행하여 정적 블로그를 구축하고 프로덕션 서버를 시작한다.

```js
// package.json
"scripts": {
  "dev": "next",
  "build": "next build",
  "start": "next start"
}
```

이 문서의 전체 소스 코드는 이 GitHub 저장소에서 사용할 수 있습니다. 로컬에서 복제하고 자유롭게 가지고 놀 수 있습니다. 리포지토리에는 또한 블로그에 CSS를 적용할 수 있는 몇 가지 기본 자리 표시자도 포함되어 있습니다.

### 개선사항

블로그는 기능적이긴 하지만 대부분의 평균적인 경우에 비해 너무 기본적일 수 있다. 프레임워크를 확장하거나 패치를 제출하면 다음과 같은 몇 가지 기능이 추가될 수 있습니다.

- 페이지화
- 구문 강조 표시
- 게시물에 대한 범주 및 태그
- 스타일링

전반적으로 Next.js는 블로그와 같은 정적 웹 사이트를 구축하기 매우 유망해 보입니다. 정적 HTML을 내보낼 수 있는 기능과 함께 서버 없이도 진정한 독립 실행형 앱을 구축할 수 있습니다!