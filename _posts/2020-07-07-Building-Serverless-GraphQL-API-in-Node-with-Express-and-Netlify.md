---
layout: post
title: "Express 및 Netlifify를 사용하는 노드의 서버리스 그래프QL API 구축"
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/07/graphql-express-netlify.png"
tags: API,EXPRESS,GRAPHQL,NETLIFY,NETLIFY FUNCTIONS
---


저는 항상 API를 만들고 싶었지만, 상황이 너무 복잡해 보여서 겁이 났습니다. 저는 그것이 왜 중요한지 설명하지 않고 "먼저 이 도서관과 이 도서관을 설치하라"로 시작하는 많은 자습서를 읽었습니다. 이런 일들에 대해서라면 전 루드다이트 같은 사람입니다.

음, 최근에 소매를 걷어올리고 손이 더러워졌어요. 저는 간단한 읽기 전용 API를 구축하여 배포하고 싶었습니다. 그리고 어쩌다 보니, 몇몇 무서운 의존성 목록과 화려한 최첨단 서비스가 저를 멈추게 하지 않을 생각이었죠.

제가 발견한 것은 많은 튜토리얼과 프로젝트 아래에는 작고 이해하기 쉬운 도구와 기술 세트가 있다는 것입니다. 1시간도 채 안되고 30줄의 코드만 있으면 누구나 자신만의 읽기 전용 API를 쓰고 구현할 수 있다고 생각합니다. 고급 풀 스택 엔지니어가 될 필요는 없습니다. JavaScript에 대한 기본적인 이해와 npm에 대한 경험만 있으면 됩니다.

이 문서에서는 서버 관리의 번거로움 없이 자신만의 API를 배포할 수 있습니다. 각 종속성을 나열하고 통합 이유를 설명하겠습니다. 또한 관련된 몇 가지 새로운 개념에 대한 소개와 심층적인 자료 링크를 제공해 드리겠습니다.

시작해 봅시다!

### API 개념에 대한 요약

API로 작업하는 몇 가지 일반적인 방법이 있습니다. 먼저 API의 모든 것을 설명하는 것부터 시작하겠습니다. 데이터 읽기 및 업데이트입니다.

지난 20년 동안 API를 구축하는 몇 가지 표준 방법이 등장했습니다. REST(표시 상태 전송의 줄임말)가 가장 일반적인 항목 중 하나입니다. REST API를 사용하려면 URL(`api.example.com/rest/books`)을 통해 서버에 전화를 걸어 JSON 또는 XML과 같은 형식의 책 목록을 다시 받아야 합니다. 단일 책을 얻으려면 URL(api.example.com/rest/books/123)의 서버로 돌아가서 #123 책을 읽어야 합니다. 새 책을 추가하거나 특정 책의 데이터를 업데이트하면 유사한 목적 정의 URL로 서버를 더 많이 이동할 수 있습니다.

이것이 우리가 여기서 살펴볼 두 개념의 기본 아이디어입니다: GraphQL과 Serverless.

데이터를 많이 가져오고 업데이트하는 애플리케이션은 API 호출을 많이 합니다. Twitter와 같은 복잡한 소프트웨어는 한 페이지에 대한 데이터를 얻기 위해 수백 통의 통화를 할 수 있다. 소수의 URL에서 올바른 데이터를 수집하여 포맷하는 것은 정말 골칫거리가 될 수 있습니다. 2012년부터 Facebook 개발자들은 데이터를 보다 효율적으로 가져오고 업데이트할 수 있는 새로운 방법을 모색하기 시작했습니다.

이들의 핵심 통찰력은 대부분의 복잡한 애플리케이션의 데이터가 다른 데이터와 관련이 있다는 것이었습니다. 사용자는 각 사용자 자신인 팔로워가 있으며, 각 팔로워는 자신의 팔로워를 가지고 있으며, 해당 팔로워는 다른 사용자의 응답을 가진 트윗을 가지고 있습니다. 데이터 결과와 해당 그래프 간의 관계를 그리면 서버가 많은 지능적인 작업 포맷 및 데이터 전송(또는 업데이트)을 수행하고 프런트 엔드 개발자의 시간과 낭비를 줄일 수 있습니다. 그래프 질의어(GraphQL)가 탄생했다.

그래프QL은 URL 및 쿼리 사용에서 REST API 접근법과 다르다. GraphQL을 사용하여 API에서 책 목록을 가져오려면 특정 URL(예: api.example.com/graphql/books)로 이동할 필요가 없습니다. 대신 최상위 단계인 API(예: api.example.com/graphql)를 불러와서 JSON 개체로 어떤 정보를 반환하고 싶은지 알려드립니다.

```js
{
  books {
    id
    title
    author
  }
}
```

서버는 해당 요청을 보고 데이터를 포맷한 다음 다른 JSON 개체로 다시 보냅니다.

```js
{
  "books" : [
    {
      "id" : 123
      "title" : "The Greatest CSS Tricks Vol. I"
      "author" : "Chris Coyier"
    }, {
      // ...
    }
  ]
}
```

세바스찬 숄은 그래프QL을 가상 칵테일 파티를 사용하여 REST와 비교한다. 결론: 그래프QL은 우리가 원하는 정확한 데이터를 요청할 수 있게 해주지만 REST는 URL의 모든 것을 덤프합니다.

### 개념 2: 서버리스

서버리스라는 단어를 볼 때마다 크리스 워터스턴의 유명한 스티커가 생각난다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/07/VLfy7tM.png?resize=265%2C225&ssl=1)

마찬가지로, 진정한 "서버 없는" 애플리케이션 같은 것은 없습니다. Chris Coyier nice는 "서버리스" 게시물을 요약합니다.

> 서버리스가 의미하는 바는 서버를 관리하고 비용을 지불하는 새로운 방법인 것 같습니다. 개별 서버는 구입하지 않습니다. 당신은 그들을 관리하지 않아요. 눈금을 매길 수 없습니다. 균형을 잡지 못하는군요. 당신은 그들에 대해 정말 책임이 없어요. 그냥 당신이 사용하는 것에 대한 대가를 치르세요.

서버 없는 접근 방식을 통해 백엔드 애플리케이션을 더 쉽게 구축하고 구현할 수 있습니다. 특히 저 같은 백엔드 개발 경험이 없는 사람들에게는 더더욱 쉬운 일입니다. 서버를 프로비저닝하고 유지하는 방법을 배우는 데 시간을 보내기보다는 종종 다른 사람에게(또는 어쩌면 다른 사람에게도) 힘든 작업을 넘깁니다.

서버 없는 모든 것에 대한 CSS-Tricks 가이드를 확인해 볼 가치가 있다. 아이디어 페이지에는 서버리스 API 구축에 대한 튜토리얼 링크도 있습니다!

### 도구 고르기

이 서버 없는 가이드를 살펴보시면 API를 구축하는 데 도움이 되는 툴과 리소스가 부족하지 않다는 것을 알 수 있습니다. 하지만 정확히 어떤 것을 사용하는지는 초기 생각과 계획이 필요합니다. 읽기 전용 API에 사용할 두 가지 도구를 다루겠습니다.

다시 말하지만, 백엔드 웹 개발 경험이 많지 않습니다. 하지만 제가 만난 몇 안 되는 것 중 하나는 Node.js입니다. 많은 분들이 알고 계시겠지만, 기본적으로 웹 브라우저 대신 서버에서 실행되는 JavaScript입니다. Node.js는 백엔드 언어를 사용하지 않고도 JavaScript에서 직접 작업할 수 있기 때문에 프런트 엔드 개발 쪽에서 오는 사람에게 적합합니다.

Express는 Node.js에 가장 인기 있는 프레임워크 중 하나이다. React가 왕(How Do You Do, Fellow Kids?)이기 전에 Express는 웹 응용 프로그램을 구축하는 데 필요한 도구였습니다. 라우팅, 템플릿, 오류 처리 등 모든 종류의 편리한 작업을 수행합니다.

솔직히 말하자면 익스프레스와 같은 틀은 나를 위협한다. 그러나 간단한 API의 경우 Express를 매우 쉽게 사용하고 이해할 수 있습니다. Express용 공식 GraphQL 도우미와 서버리스-http라는 서버리스 응용 프로그램을 만드는 플러그 앤 플레이 라이브러리가 있습니다. 깔끔하죠?

서버를 유지 관리하지 않고 애플리케이션을 실행한다는 생각은 너무 좋게 들립니다. 하지만 이것을 보세요: 여러분은 현대 마법의 위업을 성취할 수 있을 뿐만 아니라 무료로 그것을 할 수 있습니다. 걱정마세요.

Netliify는 한 달에 최대 125,000개의 API 호출을 제공하는 서버리스 기능을 갖춘 무료 요금제를 제공합니다. 아마존은 람다라고 불리는 비슷한 서비스를 제공합니다. 우리는 이 튜토리얼을 위해 Netliify를 따를 것이다.

Netlifify는 Netlifify 플랫폼용 CLI인 Netlifify Dev를 포함합니다. 기본적으로, 이 기술을 통해 로컬 컴퓨터의 안전 내에서 완전한 기능을 갖춘 생산 환경에서 시뮬레이션을 실행할 수 있습니다. 서버를 구축하지 않고도 서버 없는 기능을 구축하고 테스트할 수 있습니다.

이 시점에서, 서버리스 기능에서 Express를 실행하는 것이 좋은 생각이라는 데 모두가 동의하는 것은 아니라는 점에 주목할 필요가 있다고 생각합니다. Paul Johnston이 설명하듯이, 규모에 맞는 기능을 구축하려면 각 기능을 단일 목적 기능으로 세분화하는 것이 가장 좋습니다. Express를 사용하는 방법은 요청이 API로 이동할 때마다 전체 Express 서버를 처음부터 부팅해야 한다는 것을 의미하며, 이는 그다지 효율적이지 않습니다. 위험을 무릅쓰고 운영 환경에 구축합니다.

### 건물을 짓자!

이제 도구가 준비되었으니 프로젝트를 시작할 수 있습니다. 먼저 새 폴더를 만들고 터미널에 맞게 이동한 다음 `npm init`을 실행하는 것으로 시작하겠습니다. Once npm은 `패키지`를 생성합니다.json 파일, 우리는 우리가 필요로 하는 의존성을 설치할 수 있다. 이러한 종속성은 다음과 같습니다.

- 익스프레스
- 그래프QL 및 Express-graphql입니다. 이를 통해 GraphQL 요청을 수신하고 응답할 수 있습니다.
- 보디 파서. 이것은 우리가 JSON으로 오고 가는 요청을 번역하는 작은 레이어로, GraphQL이 기대하는 바이다.
- 서버리스-http. 이것은 응용프로그램이 Netliify와 같은 서버리스 플랫폼에서 사용될 수 있도록 하는 Express의 래퍼 역할을 합니다.

다 됐다! 더 이상 어쩔 수 없다! 한 번의 명령으로 모두 설치할 수 있습니다.

```terminal
npm i express express-graphql graphql body-parser serverless-http
```

또한 다음을 CLI로 사용하려면 Netlifify Dev를 글로벌 종속성으로 설치해야 합니다.

```terminal
npm i -g netlify-cli
```

### 파일 구조

API가 올바르게 작동하려면 몇 가지 파일이 필요합니다. 첫 번째는 프로젝트의 루트 디렉터리에 생성해야 하는 netliify.toml입니다. 이것은 Netlifify에게 프로젝트 처리 방법을 알려주는 구성 파일입니다. 시작 명령, 빌드 명령 및 서버리스 기능이 있는 위치를 정의하기 위해 파일에 필요한 내용은 다음과 같습니다.

```netlify.toml
[build]
 
  # This command builds the site
  command = "npm run build"
 
  # This is the directory that will be deployed
  publish = "build"
 
  # This is where our functions are located
  functions = "functions"
```

그 `기능` 라인은 매우 중요하다. 그것은 Netlifify에게 우리의 API 코드를 어디에 둘 것인지 알려준다.

그런 다음, 프로젝트의 루트에 `/functions` 폴더를 만들고 그 안에 `api.js`라는 새 파일을 만들어 봅시다. 이 페이지를 열고 다음 줄을 맨 위에 추가하여 종속성이 사용 가능하고 빌드에 포함되도록 합니다.

```js
const express = require("express");
const bodyParser = require("body-parser");
const expressGraphQL = require("express-graphql");
const serverless = require("serverless-http");
```

Express를 설정하는 데는 몇 줄의 코드만 필요합니다. 먼저 Express를 초기화하고 `서버리스-http` 서버리스 기능으로 포장합니다.

```js
const app = express();
module.exports.handler = serverless(app);
```

이러한 줄은 Express를 초기화하여 `serverless-http` 함수로 줄바꿈합니다. `module.exports.handler`를 통해 Netlifify는 우리의 서버리스 기능이 Express 기능임을 알 수 있다.

이제 Express 자체를 구성하겠습니다.

```js
app.use(bodyParser.json());
app.use(
  "/",
  expressGraphQL({
    graphiql: true
  })
);
```

이 두 선언은 익스프레스에게 우리가 어떤 미들웨어를 운영하는지 알려준다. 미들웨어는 요청과 응답 사이에서 우리가 원하는 것입니다. 우리의 경우, 우리는 `body parser`를 사용하여 JSON을 구문 분석하고 `express-graphql`로 처리하기를 원한다. `express-graphql`에 대한 graphiql:true 구성은 테스트를 위한 멋진 사용자 인터페이스와 놀이터를 제공할 것이다.

### 그래프QL 스키마 정의

요청을 이해하고 응답 형식을 지정하려면 그래프QL에서 데이터가 어떻게 표시되는지 알아야 합니다. 데이터베이스 관련 작업을 수행한 경우 이러한 데이터 Blueprint를 스키마라고 합니다. GraphQL은 이 잘 정의된 스키마를 다양한 종류의 데이터에 대한 정의와 결합하여 그 마법을 발휘합니다.

우리의 스키마가 가장 먼저 필요로 하는 것은 루트 쿼리이다. 이것은 우리의 API로 들어오는 모든 데이터 요청을 처리할 수 있습니다. API의 루트에서 액세스하기 때문에 "루트" 쿼리라고 합니다. 예를 들어 "api.example.com/graphql"입니다.

이 데모에서는 Hello world 예를 보여드리겠습니다. 루트 쿼리는 "Hello world"의 응답을 가져올 것입니다.

따라서, 우리의 GraphQL API는 루트 쿼리에 스키마(타입으로 구성된)가 필요하다. GraphQL은 스키마, 일반 오브젝트, 문자열 등 몇 가지 기성 유형을 제공한다.

가져오기 아래에 이 항목을 추가하여 이러한 정보를 얻읍시다.

```js
const {
  GraphQLSchema,
  GraphQLObjectType,
  GraphQLString
} = require("graphql");
```

그런 다음 다음과 같이 스키마를 정의합니다.

```js
const schema = new GraphQLSchema({
  query: new GraphQLObjectType({
    name: 'HelloWorld',
    fields: () => ({ /* we'll put our response here */ })
  })
})
```

개체의 첫 번째 요소는 `쿼리` 키를 사용하여 그래프QL에 루트 쿼리 처리 방법을 알려 줍니다. 이 값은 다음과 같은 구성의 GraphQL 개체입니다.

- `이름` – 문서화 목적으로 사용되는 참조
- `fields` – 서버가 응답할 데이터를 정의합니다. 여기에 개체를 반환하는 함수를 사용하는 것이 이상하게 보일 수 있지만, 이를 통해 먼저 정의할 필요 없이 파일의 다른 곳에 정의된 변수와 함수를 사용할 수 있습니다.

```js
const schema = new GraphQLSchema({
  query: new GraphQLObjectType({
    name: "HelloWorld",
    fields: () => ({
      message: {
        type: GraphQLString,
        resolve: () => "Hello World",
      },
    }),
  }),
});
```

필드` 함수는 객체를 반환하며 스키마는 지금까지 단일 `메시지` 필드만 가지고 있다. 우리가 응답하고자 하는 `메시지`는 문자열이므로, 우리는 그 유형을 `GraphQLS 문자열`로 지정한다. 확인 기능은 서버에서 실행되어 원하는 응답을 생성합니다. 이 경우 "Hello World"만 반환되지만 보다 복잡한 애플리케이션에서는 이 기능을 사용하여 데이터베이스로 이동하여 데이터를 검색할 수 있습니다.

그게 우리의 계획이야! Express 서버에 알려줘야 하므로 `api.js`를 열어 Express 구성이 다음과 같이 업데이트되도록 합니다.

```js
app.use(
  "/",
  expressGraphQL({
    schema: schema,
    graphiql: true
  })
);
```

### 로컬에서 서버 실행

믿거나 말거나, 서버를 시작할 준비가 되었습니다! 프로젝트의 루트 폴더에서 터미널에서 `netlifify dev`를 실행합니다. Netlifify Dev는 `netliify.toml` 구성을 읽고 `api.js` 함수를 번들로 묶어서 거기서 로컬로 사용할 수 있게 할 것이다. 모든 작업이 계획대로 진행되면 "서버가 이제 `http://localhost:8888`에서 준비되었습니다."와 같은 메시지가 표시됩니다.

처음처럼 로컬호스트(8888)로 가면 404 오류가 나기 조금 아쉬울 수 있다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/07/QXLQRC1o.gif?resize=320%2C234&ssl=1)

하지만 두려워 말라! Netlifify가 함수를 실행 중이며, 사용자가 예상하는 것과 다른 디렉토리(`/.netliify/functions`)에서만 실행됩니다. 따라서 `localhost:88888/.netliify/functions/api`로 이동하면 GraphiQL 인터페이스가 예상대로 표시됩니다. 성공!

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/07/y-GgnzjQ.png?fit=1024%2C684&ssl=1)

우리가 받은 화면은 GraphiQL 놀이터이며 API를 테스트하는 데 사용할 수 있습니다. 먼저 왼쪽 창에서 설명을 지우고 다음 항목으로 바꾸십시오.

```js
{
  message
}
```

약간 벌거벗은 것처럼 보일 수도 있지만 방금 GraphQL 쿼리를 작성하셨습니다! 우리가 말하는 것은 우리가 `api.js`에서 정의한 메시지 필드를 보고 싶다는 것이다. Run(실행) 버튼을 클릭하면 오른쪽에 다음 항목이 표시됩니다.

```js
{
  "data": {
    "message": "Hello World"
  }
}
```

너에 대해 잘 모르겠지만, 내가 처음 이 일을 할 때 주먹 펌프를 조금 했어. API를 구축했습니다!

### 보너스: 요청 리디렉션

Netlifify의 서버리스 기능에 대해 배우는 동안 나의 고민거리 중 하나는 /.netliify/functions 경로에서 실행된다는 것이다. 그것을 타이핑하거나 기억하는 것은 이상적이지 않았고 나는 다른 해결책을 찾기 위해 거의 도망쳤다. 그러나 Netfy에서 실행 및 배포할 때 요청을 쉽게 리디렉션할 수 있습니다. 프로젝트의 루트 디렉터리에 `_redirects`(확장할 필요 없음)라는 파일을 생성하기만 하면 됩니다.

```
/api /.netlify/functions/api 200!
```

이렇게 하면 Netlifify는 yoursite.com/api으로 가는 모든 트래픽을 /.netliify/https/api로 전송해야 합니다. 200! 비트는 서버에 200 상태 코드(모든 것이 정상이라는 뜻)를 다시 보내도록 지시한다.

### API 배포

프로젝트를 배포하려면 소스 코드를 Netfy에 연결해야 합니다. 나는 GitHubrepo에서 채굴을 진행하는데, 이것은 지속적인 배치를 가능하게 한다.

리포지토리를 Netfy에 연결한 후 나머지는 자동으로 처리됩니다. 코드가 처리되어 서버리스 기능으로 배포됩니다! Netlifify 대시보드에 로그인하여 모든 기능의 로그를 볼 수 있습니다.

### 결론

이와 같이, 우리는 몇 줄의 자바스크립트와 약간의 가벼운 구성으로 GraphQL을 사용하여 서버리스 API를 만들 수 있다. 그리고 우리는 무료로 배치도 할 수 있습니다.

가능성은 무한하다. 자신만의 개인 기술 자료나 디자인 토큰을 제공하는 도구를 만들 수도 있습니다. 어쩌면 네 손으로 직접 포켓을 만들고 싶을지도 몰라API. 또는 GraphQL에 관심이 있으실 수도 있습니다.

여러분이 무엇을 만들든 간에, 이런 종류의 기술들은 매일 점점 더 접근하기 쉬워지고 있습니다. 심층적인 기술적 백엔드 지식 없이도 최신 툴과 기법으로 작업할 수 있다는 것은 흥미로운 일입니다.

이 프로젝트의 전체 소스 코드를 보려면 GitHub에서 확인할 수 있습니다.

이 튜토리얼의 코드 중 일부는 Web Dev Simplified의 "Learn GraphQL in 40분" 기사에서 채택되었다. 그래프QL을 한 단계 더 깊이 들여다볼 수 있는 훌륭한 리소스입니다. 하지만 기존 서버 전체 Express에도 초점을 맞춥니다.