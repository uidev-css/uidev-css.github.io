---
layout: post
title: "RedwoodJS, Fauna 및 Vercel을 사용하여 서버리스 Jamstack 사이트 배포
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/11/redwood-fauna-vercel.png
tags: FAUNA,JAMSTACK,REDWOODJS,SERVERLESS,VERCEL
---


이 문서는 Jamstack 및 서버리스와 관련된 새로운 도구 및 기술 에코 시스템에 관심이있는 모든 사용자를위한 것입니다.
 Fauna의 GraphQL API를 Redwood 프레임 워크로 구축되고 Vercel에서 원 클릭 배포로 배포되는 Jamstack 프런트 엔드 용 서버리스 백엔드로 사용할 것입니다.
 

즉, 배울 것이 많습니다!
 마지막에는 Jamstack과 서버리스 개념에 대해 알아볼 수있을뿐만 아니라 정말 마음에들 것 같은 기술의 정말 깔끔한 조합에 대한 실무 경험도 얻게 될 것입니다.
 

### Redwood 앱 만들기
 

Redwood는 React (프런트 엔드 구성 요소 용), GraphQL (데이터 용) 및 Prisma (데이터베이스 쿼리 용)를 결합하는 서버리스 애플리케이션 용 프레임 워크입니다.
 

여기서 사용할 수있는 다른 프런트 엔드 프레임 워크가 있습니다.
 한 가지 예는 Chris Ball이 만든 Bison입니다.
 Redwood와 유사한 방식으로 GraphQL을 활용하지만 Apollo Client 대신 Nexus 및 Redwood CLI 대신 GraphQL Codegen과 같이 약간 다른 GraphQL 라이브러리 라인업을 사용합니다.
 하지만 불과 몇 달 밖에되지 않았기 때문에이 프로젝트는 2019 년 6 월부터 개발중인 Redwood에 비해 여전히 매우 새로운 것입니다.
 

애플리케이션을 부트 스트랩하는 데 사용할 수있는 훌륭한 Redwood 스타터 템플릿이 많이 있지만 저는 Redwood 상용구 프로젝트를 생성하고 Redwood 앱을 구성하는 여러 부분을 살펴 보는 것으로 시작하고 싶습니다.
 그런 다음 프로젝트를 하나씩 구축합니다.
 

Redwood CLI를 사용하려면 Yarn을 설치해야합니다.
 잘 되었으면 터미널에서 실행할 작업은 다음과 같습니다.
 

```terminal
yarn create redwood-app ./csstricks
```

이제 새 프로젝트 디렉토리에`cd`를 입력하고 개발 서버를 시작합니다.
 

```terminal
cd csstricks
yarn rw dev
```

이제 프로젝트의 프런트 엔드가`localhost : 8910`에서 실행됩니다.
 백엔드는`localhost : 8911`에서 실행 중이며 GraphQL 쿼리를 수신 할 준비가되었습니다.
 기본적으로 Redwood에는 기사의 끝 부분에서 사용할 GraphiQL 플레이 그라운드가 함께 제공됩니다.
 

브라우저에서`localhost : 8910`으로 이동해 보겠습니다.
 모두 괜찮다면 Redwood 랜딩 페이지가로드되어야합니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/11/s_DF975FCF66DFF1AC9A98274CEDA6749B99C95E5BA01B75D9A58D53F8EA8B2145_1605198264374_ScreenShot2020-11-12at9.22.10AM.jpg?resize=1516%2C1389&ssl=1)

Redwood는 현재이 글을 쓰는 시점에서 0.21.0 버전입니다.
 문서는 공식적으로 1.0에 도달 할 때까지 프로덕션에서 사용하는 것에 대해 경고합니다.
 또한 자신과 같은 개발자의 피드백과 의견을 환영하는 커뮤니티 포럼이 있습니다.
 

Redwood는 구성보다 관습을 중시하고 기술 선택, 파일 구성 방법, 명명 규칙을 포함하여 많은 결정을 내립니다.
 이로 인해 이해하기 어려운 상용구 코드가 너무 많이 생성 될 수 있습니다. 특히이 코드를 처음으로 파헤치는 경우 더욱 그렇습니다.
 

프로젝트의 구조는 다음과 같습니다.
 

```
├── api
│   ├── prisma
│   │   ├── schema.prisma
│   │   └── seeds.js
│   └── src
│       ├── functions
│       │   └── graphql.js
│       ├── graphql
│       ├── lib
│       │   └── db.js
│       └── services
└── web
    ├── public
    │   ├── favicon.png
    │   ├── README.md
    │   └── robots.txt
    └── src
        ├── components
        ├── layouts
        ├── pages
        │   ├── FatalErrorPage
        │   │   └── FatalErrorPage.js
        │   └── NotFoundPage
        │       └── NotFoundPage.js
        ├── index.css
        ├── index.html
        ├── index.js
        └── Routes.js
```

이 모든 것이 의미하는 바에 대해 너무 걱정하지 마십시오.
 가장 먼저 주목할 점은 `web`과 `api`라는 두 개의 주요 디렉토리로 나뉘어져 있다는 것입니다.
 Yarn 작업 공간을 사용하면 각 측면이 코드베이스에서 자체 경로를 가질 수 있습니다.
 

`web`에는 다음에 대한 프런트 엔드 코드가 포함되어 있습니다.
 

- 페이지
 
- 레이아웃
 
- 구성품
 

`api`에는 다음에 대한 백엔드 코드가 포함되어 있습니다.
 

- 함수 핸들러
 
- 스키마 정의 언어
 
- 백엔드 비즈니스 로직을위한 서비스
 
- 데이터베이스 클라이언트
 

Redwood는 Prisma를 데이터 저장소로 가정하지만 대신 Fauna를 사용할 것입니다.
 Firebase를 쉽게 사용할 수 있는데 왜 Fauna입니까?
 글쎄, 그것은 단지 개인적인 취향 일뿐입니다.
 Google은 Firebase를 구입 한 후 원래 Firebase 실시간 데이터베이스의 후속 제품으로 실시간 문서 데이터베이스 인 Cloud Firestore를 출시했습니다.
 더 큰 Firebase 생태계와 통합하면 Fauna가 제공하는 것보다 더 광범위한 기능에 액세스 할 수 있습니다.
 동시에 Firestore 및 GraphQL을 실험 한 소수의 커뮤니티 프로젝트도 있지만 Google의 최고급 GraphQL 지원은 없습니다.
 

Fauna를 직접 쿼리 할 것이므로`prisma` 디렉토리와 그 안의 모든 것을 삭제할 수 있습니다.
 `db.js`의 모든 코드를 삭제할 수도 있습니다.
 Fauna 클라이언트에 연결하는 데 사용할 파일이므로 삭제하지 마십시오.
 

React 또는 기타 단일 페이지 애플리케이션 프레임 워크를 사용해 본 경험이있는 개발자에게 익숙해 보일 것이므로 `웹`측면부터 살펴 보겠습니다.
 

하지만 React 앱을 빌드하면 실제로 어떤 일이 발생합니까?
 전체 사이트를 가져 와서`index.js` 안에있는 하나의 큰 자바 스크립트 공에 넣은 다음, 그 JavaScript 공을`index.html`의 11 행에있는 "루트"DOM 노드에 넣습니다.
 

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="icon" type="image/png" href="/favicon.png" />
    <title><%= htmlWebpackPlugin.options.title %></title>
  </head>

  <body>
    <div id="redwood-app"></div> // HIGHLIGHT
  </body>
</html>
```

Redwood는 자체 문서화 및 마케팅에 Jamstack을 사용하지만 Redwood는 아직 Next 또는 Gatsby와 같은 사전 렌더링을 수행하지 않지만 정적 파일을 제공하고 데이터 용 JavaScript로 API를 적중한다는 점에서 여전히 Jamstack입니다.
 

`index.js`에는 루트 DOM 노드에 렌더링되는 루트 구성 요소 (자바 스크립트의 큰 공)가 포함되어 있습니다.
 `document.getElementById ()`는`redwood-app`을 포함하는`id`가있는 요소를 선택하고`ReactDOM.render ()`는 애플리케이션을 루트 DOM 요소로 렌더링합니다.
 

`<Routes />`구성 요소 (확장하면 모든 애플리케이션 페이지)는`<RedwoodProvider>`태그 내에 포함됩니다.
 Flash는 Context API를 사용하여 중첩 된 구성 요소간에 메시지 객체를 전달합니다.
 FlashContext에 제공된 메시지를 렌더링하기위한 일반적인 메시지 표시 장치를 제공합니다.
 

FlashContext의 공급자 구성 요소는`<RedwoodProvider />`구성 요소와 함께 패키지화되어 있으므로 즉시 사용할 수 있습니다.
 컴포넌트는 제공된 useFlash 후크를 통해 구독 ( "송신 및 수신")하여 메시지 객체를 전달합니다.
 

그러면 공급자 자체는`<FatalErrorPage>`를 소품으로받는`<FatalErrorBoundary>`구성 요소에 포함됩니다.
 다른 모든 방법이 실패하면 웹 사이트가 오류 페이지로 기본 설정됩니다.
 

```jsx
import ReactDOM from 'react-dom'
import { RedwoodProvider, FatalErrorBoundary } from '@redwoodjs/web'
import FatalErrorPage from 'src/pages/FatalErrorPage'
import Routes from 'src/Routes'
import './index.css'

ReactDOM.render(
  <FatalErrorBoundary page={FatalErrorPage}>
    <RedwoodProvider>
      <Routes />
    </RedwoodProvider>
  </FatalErrorBoundary>,

  document.getElementById('redwood-app')
)
```

`Router`에는 모든 경로가 포함되며 각 경로는 `Route`로 지정됩니다.
 Redwood Router는 현재 URL을 각 경로에 일치 시키려고 시도하고 일치 항목을 찾으면 중지 한 다음 해당 경로 만 렌더링합니다.
 유일한 예외는 일치하는 다른 경로가 없을 때 `notfound`prop으로 단일 `Route`를 렌더링하는 `notfound`경로입니다.
 

```jsx
import { Router, Route } from '@redwoodjs/router'

const Routes = () => {
  return (
    <Router>
      <Route notfound page={NotFoundPage} />
    </Router>
  )
}

export default Routes
```

### 페이지
 

이제 애플리케이션이 설정되었으므로 페이지를 만들어 보겠습니다!
 Redwood CLI`generate page` 명령을 사용하여`home`이라는 이름이 지정된 경로 함수를 생성합니다.
 URL 경로가`/`와 일치하면`HomePage` 구성 요소를 렌더링합니다.
 

또한 `redwood`대신 `rw`를 사용하고 `generate`대신 `g`를 사용하여 타이핑을 줄일 수도 있습니다.
 

```terminal
yarn rw g page home /
```

이 명령은 네 가지 개별 작업을 수행합니다.
 

- `web / src / pages / HomePage / HomePage.js`를 생성합니다.
 첫 번째 인수에 지정된 이름은 대문자가되고 끝에 "Page"가 추가됩니다.
 
- 테스트 기반 개발을 수행하는 것처럼 가장 할 수 있도록 단일 통과 테스트로`web / src / pages / HomePage / HomePage.test.js`에 테스트 파일을 생성합니다.
 
- `web / src / pages / HomePage / HomePage.stories.js`에 Storybook 파일을 생성합니다.
 
- `/`경로를`HomePage` 구성 요소에 매핑하는`web / src / Routes.js`에 새`<Route>`를 추가합니다.
 

`web / src / pages`로 이동하면`HomePage.js` 파일이 포함 된`HomePage` 디렉토리가 표시됩니다.
 내용은 다음과 같습니다.
 

```jsx
// web/src/pages/HomePage/HomePage.js

import { Link, routes } from '@redwoodjs/router'

const HomePage = () => {
  return (
    <>
      <h1>HomePage</h1>
      <p>
        Find me in <code>./web/src/pages/HomePage/HomePage.js</code>
      </p>
      <p>
        My default route is named <code>home</code>, link to me with `
        <Link to={routes.home()}>Home</Link>`
      </p>
    </>
  )
}

export default HomePage
```

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/11/s_DF975FCF66DFF1AC9A98274CEDA6749B99C95E5BA01B75D9A58D53F8EA8B2145_1605200326416_02-.jpg?resize=1184%2C438&ssl=1)

페이지 탐색을 재사용 가능한 레이아웃 구성 요소로 이동할 것입니다. 즉,`Link` 및`routes` 가져 오기는 물론`<Link to = {routes.home ()}> Home </ Link도 삭제할 수 있습니다.
 >`.
 이것이 우리에게 남은 것입니다.
 

```jsx
// web/src/pages/HomePage/HomePage.js

const HomePage = () => {
  return (
    <>
      <h1>RedwoodJS+FaunaDB+Vercel 🚀</h1>
      <p>Taking Fullstack to the Jamstack</p>
    </>
  )
}

export default HomePage
```

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/11/s_DF975FCF66DFF1AC9A98274CEDA6749B99C95E5BA01B75D9A58D53F8EA8B2145_1605200744868_03-.jpg?resize=1183%2C403&ssl=1)

`AboutPage`를 만들기 위해 방금했던 것과 거의 동일한 명령을 입력하지만`home` 대신`about`을 사용합니다.
 경로 이름과 동일하므로 경로를 지정할 필요도 없습니다.
 이 경우 이름과 경로가 모두 `about`으로 설정됩니다.
 

```terminal
yarn rw g page about
```

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/11/s_DF975FCF66DFF1AC9A98274CEDA6749B99C95E5BA01B75D9A58D53F8EA8B2145_1605200962914_04-.jpg?resize=1183%2C448&ssl=1)

```jsx
// web/src/pages/AboutPage/AboutPage.js

import { Link, routes } from '@redwoodjs/router'

const AboutPage = () => {
  return (
    <>
      <h1>AboutPage</h1>
      <p>
        Find me in <code>./web/src/pages/AboutPage/AboutPage.js</code>
      </p>
      <p>
        My default route is named <code>about</code>, link to me with `
        <Link to={routes.about()}>About</Link>`
      </p>
    </>
  )
}

export default AboutPage
```

홈페이지에서했던 것처럼 정보 페이지를 몇 가지 수정하겠습니다.
 여기에는`<Link>`및`routes` 가져 오기 및`Link to = {routes.about ()}> 정보 </ Link>`삭제가 포함됩니다.
 

최종 결과는 다음과 같습니다.
 

```jsx
// web/src/pages/AboutPage/AboutPage.js

const AboutPage = () => {
  return (
    <>
      <h1>About 🚀🚀</h1>
      <p>For those who want to stack their Jam, fully</p>
    </>
  )
}
```

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/11/s_DF975FCF66DFF1AC9A98274CEDA6749B99C95E5BA01B75D9A58D53F8EA8B2145_1605201037024_05-.jpg?resize=1184%2C404&ssl=1)

`Routes.js`로 돌아 가면`home` 및`about`에 대한 새 경로가 표시됩니다.
 레드 우드가 우리를 위해이 일을하는 것은 꽤 좋습니다!
 

```jsx
const Routes = () => {
  return (
    <Router>
      <Route path="/about" page={AboutPage} name="about" />
      <Route path="/" page={HomePage} name="home" />
      <Route notfound page={NotFoundPage} />
    </Router>
  )
}
```

### 레이아웃
 

이제 다른 페이지로 쉽게 가져올 수있는 탐색 링크가있는 헤더를 작성하려고합니다.
 레이아웃을 사용하여 페이지마다 코드를 작성하는 대신 컴포넌트를 가져 와서 원하는만큼의 페이지에 탐색을 추가 할 수 있습니다.
 

이제 "레이아웃을위한 생성기가 있습니까?"라고 궁금해하실 것입니다.
 그에 대한 답은 ... 물론입니다!
 명령은 경로의 이름과 경로가 뒤에 오는`rw g 페이지`대신`rw g 레이아웃`뒤에 레이아웃 이름이 오는 것을 제외하고는 지금까지했던 것과 거의 동일합니다.
 

```terminal
yarn rw g layout blog
```

```jsx
// web/src/layouts/BlogLayout/BlogLayout.js

const BlogLayout = ({ children }) => {
  return <>{children}</>
}

export default BlogLayout
```

서로 다른 페이지 사이에 링크를 만들려면 다음을 수행해야합니다.
 

- `@ redwoodjs / router`에서`BlogLayout.js`로`Link` 및`routes` 가져 오기
 
- 각 링크에 대해`<Link to = {}> </ Link>`구성 요소를 만듭니다.
 
- `routes.home ()`과 같은 명명 된 경로 함수를 각 경로의`to = {}`prop에 전달합니다.
 

```jsx
// web/src/layouts/BlogLayout/BlogLayout.js

import { Link, routes } from '@redwoodjs/router'

const BlogLayout = ({ children }) => {
  return (
    <>
      <header>
        <h1>RedwoodJS+FaunaDB+Vercel 🚀</h1>

        <nav>
          <ul>
            <li>
              <Link to={routes.home()}>Home</Link>
            </li>
            <li>
              <Link to={routes.about()}>About</Link>
            </li>
          </ul>
        </nav>

      </header>

      <main>
        <p>{children}</p>
      </main>
    </>
  )
}

export default BlogLayout
```

아직 브라우저에서 다른 점은 보이지 않습니다.
 `BlogLayout`을 만들었지 만 페이지로 가져 오지 않았습니다.
 이제`BlogLayout`을`HomePage`로 가져 와서 전체`return` 문을`BlogLayout` 태그로 래핑하겠습니다.
 

```jsx
// web/src/pages/HomePage/HomePage.js

import BlogLayout from 'src/layouts/BlogLayout'

const HomePage = () => {
  return (
    <BlogLayout>
      <p>Taking Fullstack to the Jamstack</p>
    </BlogLayout>
  )
}

export default HomePage 

```

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/11/s_DF975FCF66DFF1AC9A98274CEDA6749B99C95E5BA01B75D9A58D53F8EA8B2145_1605203122497_06-.jpg?resize=1183%2C473&ssl=1)

정보 페이지에 대한 링크를 클릭하면 해당 페이지로 이동하지만 아직 `BlogLayout`을 `AboutPage`로 가져 오지 않았기 때문에 이전 페이지로 돌아갈 수 없습니다.
 지금 해보겠습니다.
 

```jsx
// web/src/pages/AboutPage/AboutPage.js

import BlogLayout from 'src/layouts/BlogLayout'

const AboutPage = () => {
  return (
    <BlogLayout>
      <p>For those who want to stack their Jam, fully</p>
    </BlogLayout>
  )
}

export default AboutPage 

```

![image](https://paper-attachments.dropbox.com/s_DF975FCF66DFF1AC9A98274CEDA6749B99C95E5BA01B75D9A58D53F8EA8B2145_1605203219630_07-.jpg)

이제 탐색 링크를 클릭하여 페이지 사이를 앞뒤로 탐색 할 수 있습니다!
 다음으로, 데이터 작업을 시작할 수 있도록 GraphQL 스키마를 생성하겠습니다.
 

### 동물 군 스키마 정의 언어
 

이 작업을 수행하려면`sdl.gql`이라는 새 파일을 만들고 다음 스키마를 파일에 입력해야합니다.
 Fauna는이 스키마를 사용하여 몇 가지 변형을 수행합니다.
 

```js
// sdl.gql

type Post {
  title: String!
  body: String!
}

type Query {
  posts: [Post]
}
```

파일을 저장하고 Fauna의 GraphQL Playground에 업로드합니다.
 이 시점에서 계속하려면 Fauna 계정이 필요합니다.
 우리가하는 일에 딱 맞는 무료 등급이 있습니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/11/s_DF975FCF66DFF1AC9A98274CEDA6749B99C95E5BA01B75D9A58D53F8EA8B2145_1605204128838_playground.jpeg?resize=1758%2C846&ssl=1)

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/11/s_DF975FCF66DFF1AC9A98274CEDA6749B99C95E5BA01B75D9A58D53F8EA8B2145_1605228102916_ScreenShot2020-11-12at5.39.57PM.jpg?resize=2142%2C1178&ssl=1)

Redwood와 Fauna가 SDL에 동의하는 것은 매우 중요합니다. 따라서 Fauna 데이터베이스에 존재하는 유형을 더 이상 정확하게 표현할 수 없기 때문에 Fauna에 입력 된 원본 SDL을 사용할 수 없습니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/11/s_DF975FCF66DFF1AC9A98274CEDA6749B99C95E5BA01B75D9A58D53F8EA8B2145_1605228406095_ScreenShot2020-11-12at5.40.13PM.jpg?resize=416%2C623&ssl=1)

셸에서 기본 쿼리를 실행하면`Post` 컬렉션과 포스트`Index`가 변경되지 않은 상태로 표시되지만 Fauna는`data` 개체가있는 중간`PostPage` 유형을 생성합니다.
 

### 레드 우드 스키마 정의 언어
 

이`data` 객체는 데이터베이스의 모든`Post` 객체가있는 배열을 포함합니다.
 이 유형을 사용하여 Redwood 프로젝트의`api` 측에있는`graphql` 디렉토리에있는 또 다른 스키마 정의 언어를 생성합니다.
 

```jsx
// api/src/graphql/posts.sdl.js

import gql from 'graphql-tag'

export const schema = gql`
  type Post {
    title: String!
    body: String!
  }

  type PostPage {
    data: [Post]
  }

  type Query {
    posts: PostPage
  }
`

```

### 서비스
 verified_user

`posts`서비스는 Fauna GraphQL API에 쿼리를 보냅니다.
 이 쿼리는 게시물 배열, 특히 각각의 `title`및 `body`를 요청합니다.
 이들은`PostPage`의`data` 객체에 포함되어 있습니다.
 

```jsx
// api/src/services/posts/posts.js

import { request } from 'src/lib/db'
import { gql } from 'graphql-request'

export const posts = async () => {
  const query = gql`
  {
    posts {
      data {
        title
        body
      }
    }
  }
  `

  const data = await request(query, 'https://graphql.fauna.com/graphql')

  return data['posts']
}

```

이 시점에서 GraphQL 요청을 보내는 데 사용할 수있는 약속 기반 API를 사용하여 GraphQL 용 최소 클라이언트 인`graphql-request`를 설치할 수 있습니다.
 

```terminal
cd api
yarn add graphql-request graphql
```

### 요청 헤더에 Fauna 인증 토큰 연결
 

지금까지 데이터를위한 GraphQL, 해당 데이터를 모델링하는 Fauna, 쿼리를위한`graphql-request `가 있습니다.
 이제`graphql-request`와 Fauna 간의 연결을 설정해야합니다.`graphql-request`를`db.js`로 가져 와서`https :로 설정된`endpoint`를 쿼리하는 데 사용합니다.
 // graphql.fauna.com / graphql`.
 

```jsx
// api/src/lib/db.js

import { GraphQLClient } from 'graphql-request'

export const request = async (query = {}) => {
  const endpoint = 'https://graphql.fauna.com/graphql'

  const graphQLClient = new GraphQLClient(endpoint, {
    headers: {
      authorization: 'Bearer ' + process.env.FAUNADB_SECRET
    },
  })

  try {
    return await graphQLClient.request(query)
  } catch (error) {
    console.log(error)
    return error
  }
}

```

`GraphQLClient`는 인증 토큰으로 헤더를 설정하도록 인스턴스화되어 데이터가 앱으로 흐르도록합니다.
 

### 창조하다
 verified_user

Fauna Shell을 사용하고 몇 가지 FQL (Funa Query Language) 명령을 실행하여 데이터베이스를 시드합니다.
 먼저`title`과`body`가있는 블로그 게시물을 작성합니다.
 

```jsx
Create(
  Collection("Post"),
  {
    data: {
      title: "Deno is a secure runtime for JavaScript and TypeScript.",
      body: "The original creator of Node, Ryan Dahl, wanted to build a modern, server-side JavaScript framework that incorporates the knowledge he gained building out the initial Node ecosystem."
    }
  }
)
```

```jsx
{
  ref: Ref(Collection("Post"), "282083736060690956"),
  ts: 1605274864200000,
  data: {
    title: "Deno is a secure runtime for JavaScript and TypeScript.",
    body:
      "The original creator of Node, Ryan Dahl, wanted to build a modern, server-side JavaScript framework that incorporates the knowledge he gained building out the initial Node ecosystem."
  }
}
```

다른 하나를 만들어 보겠습니다.
 

```jsx
Create(
  Collection("Post"),
  {
    data: {
      title: "NextJS is a React framework for building production grade applications that scale.",
      body: "To build a complete web application with React from scratch, there are many important details you need to consider such as: bundling, compilation, code splitting, static pre-rendering, server-side rendering, and client-side rendering."
    }
  }
)
```

```jsx
{
  ref: Ref(Collection("Post"), "282083760102441484"),
  ts: 1605274887090000,
  data: {
    title:
      "NextJS is a React framework for building production grade applications that scale.",
    body:
      "To build a complete web application with React from scratch, there are many important details you need to consider such as: bundling, compilation, code splitting, static pre-rendering, server-side rendering, and client-side rendering."
  }
}
```

그리고 아마 하나만 더 채워야합니다.
 

```jsx
Create(
  Collection("Post"),
  {
    data: {
      title: "Vue.js is an open-source front end JavaScript framework for building user interfaces and single-page applications.",
      body: "Evan You wanted to build a framework that combined many of the things he loved about Angular and Meteor but in a way that would produce something novel. As React rose to prominence, Vue carefully observed and incorporated many lessons from React without ever losing sight of their own unique value prop."
    }
  }
)
```

```jsx
{
  ref: Ref(Collection("Post"), "282083792286384652"),
  ts: 1605274917780000,
  data: {
    title:
      "Vue.js is an open-source front end JavaScript framework for building user interfaces and single-page applications.",
    body:
      "Evan You wanted to build a framework that combined many of the things he loved about Angular and Meteor but in a way that would produce something novel. As React rose to prominence, Vue carefully observed and incorporated many lessons from React without ever losing sight of their own unique value prop."
  }
}
```

### 세포
 

셀은 데이터 가져 오기에 대한 간단하고 선언적인 접근 방식을 제공합니다.
 여기에는로드, 비어 있음, 오류 및 성공 상태와 함께 GraphQL 쿼리가 포함됩니다.
 각각은 셀이 어떤 상태에 있는지에 따라 자동으로 렌더링됩니다.
 

```jsx
yarn rw generate cell BlogPosts


export const QUERY = gql`
  query BlogPostsQuery {
    blogPosts {
      id
    }
  }
`
export const Loading = () => <div>Loading...</div>
export const Empty = () => <div>Empty</div>
export const Failure = ({ error }) => <div>Error: {error.message}</div>

export const Success = ({ blogPosts }) => {
  return JSON.stringify(blogPosts)
}
```

기본적으로 쿼리는 셀을 가져온 페이지에서`JSON.stringify`로 데이터를 렌더링합니다.
 쿼리를 작성하고 필요한 데이터를 렌더링하기 위해 몇 가지 사항을 변경하겠습니다.
 자, 그럼 :
 

- `blog Posts`를`posts`로 변경합니다.
 
- `BlogPostsQuery`를`POSTS`로 변경합니다.
 
- 각 게시물의`title`과`body`를 반환하도록 쿼리 자체를 변경합니다.
 
- 성공 구성 요소의 `데이터`개체에 매핑합니다.
 
- `data` 객체를 통해 반환 된`posts`의`title`과`body`로 구성 요소를 만듭니다.
 

그 모습은 다음과 같습니다.
 

```jsx
// web/src/components/BlogPostsCell/BlogPostsCell.js

export const QUERY = gql`
  query POSTS {
    posts {
      data {
        title
        body
      }
    }
  }
`
export const Loading = () => <div>Loading...</div>
export const Empty = () => <div>Empty</div>
export const Failure = ({ error }) => <div>Error: {error.message}</div>

export const Success = ({ posts }) => {
  const {data} = posts
  return data.map(post => (
    <>
      <header>
        <h2>{post.title}</h2>
      </header>
      <p>{post.body}</p>
    </>
  ))
}
```

`POSTS`쿼리는 `게시물`에 대한 쿼리를 보내고, 쿼리되면 게시물 배열이 포함 된 `데이터`개체를 반환합니다.
 우리는 그것을 반복하고 실제 포스트를 얻을 수 있도록`data` 객체를 꺼내야합니다.
 객체 디스트 럭처링을 사용하여`data` 객체를 얻은 다음`map ()`함수를 사용하여`data` 객체를 매핑하고 각 게시물을 가져옵니다.
 각 게시물의 `제목`은`<header>`내부에`<h2>`로 렌더링되고 본문은`<p>`태그로 렌더링됩니다.
 

### BlogPostsCell을 홈페이지로 가져 오기
 

```jsx
// web/src/pages/HomePage/HomePage.js

import BlogLayout from 'src/layouts/BlogLayout'
import BlogPostsCell from 'src/components/BlogPostsCell/BlogPostsCell.js'

const HomePage = () => {
  return (
    <BlogLayout>
      <p>Taking Fullstack to the Jamstack</p>
      <BlogPostsCell />
    </BlogLayout>
  )
}

export default HomePage
```

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/11/s_DF975FCF66DFF1AC9A98274CEDA6749B99C95E5BA01B75D9A58D53F8EA8B2145_1605245197580_ScreenShot2020-11-12at10.24.44PM.jpg?resize=1182%2C1408&ssl=1)

### Vercel
 

이 게시물의 제목에 Vercel을 언급했으며 마침내 필요한 시점에 도달했습니다.
 특히, 우리는이를 사용하여 프로젝트를 빌드하고 Vercel의 호스팅 플랫폼에 배포합니다.이 플랫폼은 코드가 프로젝트 저장소로 푸시 될 때 빌드 미리보기를 제공합니다.
 따라서 아직 계정이 없다면 Vercel 계정을 만드십시오.
 다시 말하지만 무료 가격 책정 계층은이 작업에 적합합니다.
 

Vercel이 Netlify를 넘은 이유는 무엇입니까?
 좋은 질문입니다.
 Redwood는 Netlify를 원래 배포 대상으로 시작하기도했습니다.
 Redwood는 여전히 잘 문서화 된 Netlify 통합을 많이 보유하고 있습니다.
 Netlify와의 긴밀한 통합에도 불구하고 Redwood는 가능한 한 많은 배포 대상에 보편적으로 이식 할 수 있도록 노력하고 있습니다.
 여기에는 이제 서버리스 프레임 워크, AWS Fargate 및 PM2에 대한 커뮤니티 통합과 함께 Vercel에 대한 공식 지원이 포함됩니다.
 예, 여기에서 Netlify를 사용할 수 있지만 사용 가능한 서비스를 선택할 수 있다는 점이 좋습니다.
 

Vercel과 통합하려면 프로젝트 구성을 한 번만 변경하면됩니다.
 `netlify.toml`을 열고`apiProxyPath`를` "/ api"`로 변경하겠습니다.
 그런 다음 Vercel에 로그인하고“Import Project”버튼을 클릭하여 서비스를 프로젝트 저장소에 연결합니다.
 여기에 Vercel이 리포지토리의 URL을 입력 한 다음 변경 사항이 감지되면 빌드를 트리거하고 배포 할 수 있습니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/11/s_DF975FCF66DFF1AC9A98274CEDA6749B99C95E5BA01B75D9A58D53F8EA8B2145_1605221107398_10-.jpg?resize=1264%2C547&ssl=1)

Redwood에는 Vercel에서 즉시 작동하는 사전 설정 빌드 명령이 있습니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/11/s_DF975FCF66DFF1AC9A98274CEDA6749B99C95E5BA01B75D9A58D53F8EA8B2145_1605221121195_11-.jpg?resize=1270%2C1051&ssl=1)

꽤 멀었지만 사이트가 현재 "라이브"상태이지만 데이터베이스는 연결되어 있지 않습니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/11/s_DF975FCF66DFF1AC9A98274CEDA6749B99C95E5BA01B75D9A58D53F8EA8B2145_1605221139296_12-.jpg?resize=2094%2C1126&ssl=1)

이 문제를 해결하기 위해 Fauna 계정의`FAUNADB_SECRET` 토큰을 Vercel의 환경 변수에 추가합니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/11/s_DF975FCF66DFF1AC9A98274CEDA6749B99C95E5BA01B75D9A58D53F8EA8B2145_1605221133300_13-.jpg?resize=1576%2C940&ssl=1)

이제 신청이 완료되었습니다!
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/11/s_DF975FCF66DFF1AC9A98274CEDA6749B99C95E5BA01B75D9A58D53F8EA8B2145_1605244837783_ScreenShot2020-11-12at10.19.07PM.jpg?resize=1180%2C1345&ssl=1)

우리는 해냈다!
 나는 이것이 당신이 Jamstack과 서버리스로 작업하는 것에 대해 매우 흥분하게 할뿐만 아니라 그 과정에서 몇 가지 새로운 기술을 맛볼 수 있기를 바랍니다.
 