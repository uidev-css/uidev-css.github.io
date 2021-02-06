---
layout: post
title: "반응 및 Fauna를 사용한 GraphQL API의 완전한 개요DB"
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/08/heroku-fauna-apollo.png"
tags: 
---


웹 개발자로서, 새로운 응용 프로그램을 설정하는 데 항상 수반되는 흥미로운 비트가 있습니다. Ruby on Rails와 같은 전체 스택 웹 프레임워크를 사용하더라도 특히 오랜만에 설정 및 배포하는 데 문제가 없을 수 있습니다.

개인적으로 저는 항상 앱을 직접 설정하는 것보다 애플리케이션 로직의 실제 비트를 더 잘 파고 쓰고 있습니다. 최근에 저는 그래프QL API와 아폴로 라이브러리와 함께 React 애플리케이션의 열렬한 팬이 되었습니다.

React 애플리케이션을 설정하는 것은 지난 몇 년 동안 매우 쉬워졌지만 GraphQL API를 사용하여 백엔드를 설정하시겠습니까? 그렇게 많지는 않다. 그래서 최근에 프로젝트를 진행하면서 GraphQL API를 통합할 수 있는 더 쉬운 방법을 찾기로 결심했고 FaunaDB를 발견하게 되어 기뻤습니다.

FaunaDB는 서비스형 NoSQL 데이터베이스로, GraphQL API를 매우 간단한 프로세스로 만들고, 무료 계층까지 제공합니다. 솔직히 저는 제가 0에서 0으로 작동하는 API로 얼마나 빨리 갈 수 있었는지에 놀랐고 정말 감명받았습니다.

또한 이 서비스는 운영 준비 상태를 자랑하며, 백엔드 관리보다 훨씬 더 쉽게 확장할 수 있도록 하는 데 초점을 맞춥니다. 아직 좀 더 진보된 기능을 살펴보지는 않았지만, 첫인상과 비슷하다면 FaunaDB를 사용할 때의 전망과 시사점은 상당히 흥미롭다. 현재로선 대부분의 프로젝트에 대해 Retact 응용 프로그램과 함께 상태를 관리하는 데 탁월한 솔루션을 제공한다는 것을 확인할 수 있습니다.

프로젝트를 진행하는 동안 모든 프레임워크가 함께 작동하도록 할 때 몇 가지 구성 문제가 발생했는데, 애플리케이션 전체를 구성하는 데 초점을 맞춘 가이드가 이를 해결할 수 있었다고 생각합니다. 이 기사에서는 Heroku에 소규모 Retact 애플리케이션을 설치하고, 아폴로 라이브러리를 사용하여 FaunaDB를 통해 데이터를 유지하는 방법에 대해 살펴보겠습니다. 여기서 전체 소스 코드를 찾을 수 있습니다.

### 우리의 응용 프로그램

이 워크스루에서는 사용자가 다음 작업을 수행할 수 있는 작업관리 목록을 작성하고 있습니다.

- 새 항목 추가
- 항목을 완료로 표시
- 항목 제거

기술적인 관점에서 다음과 같은 작업을 수행하여 이를 달성할 수 있습니다.

- 반응 응용 프로그램 만들기
- Heroku에 애플리케이션 배포
- 새 FaunaDB 데이터베이스 프로비저닝
- GraphQL API 스키마 선언
- 새 데이터베이스 키 프로비저닝
- React 애플리케이션에서 Apollo가 API와 상호 작용하도록 구성
- 애플리케이션 로직을 작성하고 API를 사용하여 정보를 유지하는 중

다음은 최종 결과가 어떻게 나타날지에 대한 미리 보기입니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/08/image-14.gif?resize=322%2C270&ssl=1)

### 반응 응용 프로그램 만들기

먼저, 우리는 반응형 보일러를 만들고 그것이 동작하는지 확인할 것이다. create-react-app이 설치된 경우 새 애플리케이션을 생성하는 명령은 다음과 같습니다.

```terminal
create-react-app fauna-todo
cd fauna-todo
yarn start
```

그 후에는 `http://localhost:3000`으로 이동하여 생성된 홈페이지에서 응용 프로그램을 볼 수 있습니다.

### 헤로쿠에 배포

위에서 언급했듯이, React 애플리케이션을 구축하는 일은 지난 몇 년 동안 매우 쉬워졌습니다. Heroku를 사용하는 이유는 한동안 서비스로 전환되어 왔기 때문입니다. 하지만 Netliify와 같은 다른 서비스를 쉽게 사용할 수 있습니다(물론 구성은 약간 다를 수 있음). Heroku 계정이 설치되어 있고 Heroku CLI가 설치되어 있다고 가정하면 이 자료에는 React 애플리케이션을 생성하고 배포하는 데 몇 줄의 코드만 있으면 됩니다.

```terminal
git init
heroku create -b https://github.com/mars/create-react-app-buildpack.git
git push heroku master
```

앱이 배포되었습니다! 보려면 다음을 실행하십시오.

```terminal
heroku open
```

### FaunaDB 데이터베이스 프로비저닝

이제 Retact 앱을 실행 중이므로 FaunaDB를 사용하여 애플리케이션에 지속성을 추가해 보겠습니다. fauna.com으로 이동하여 무료 계정을 만드십시오. 계정이 있으면 대시보드에서 "새 데이터베이스"를 클릭하고 선택한 이름을 입력합니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/08/image-26.png?resize=392%2C197&ssl=1)

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/08/image-27.png?resize=525%2C432&ssl=1)

### Fauna에서 GraphQL Schema를 통한 API 생성DB

이 예에서는 GraphQL 스키마를 선언한 다음 이 파일을 사용하여 FaunaDB 내에서 API를 자동으로 생성하려고 합니다. 작업관리 응용 프로그램의 스키마를 처음 찌르기 위해 "이름"을 유일한 필드로 사용하는 "항목" 컬렉션이 있다고 가정해 보자. 나중에 이 스키마를 기반으로 스키마 자체를 한 눈에 볼 수 있는 것을 좋아하기 때문에 `schema.graphql` 파일을 만들어 리액트 응용 프로그램의 최상위 수준에 추가할 예정입니다. 다음은 이 파일의 내용입니다.

```schema.graphql
type Item {
 name: String
}
type Query {
 allItems: [Item!]
}
```

GraphQL 스키마를 정의하는 개념이 익숙하지 않은 경우, API 내에서 사용할 수 있는 개체 및 쿼리의 종류를 선언하는 매니페스트라고 생각하십시오. 이 경우 이름 문자열 필드가 있는 항목 유형이 있을 것이며 모든 항목 레코드를 조회하기 위한 명시적 질의 `all Item`을 갖게 될 것이라고 말합니다. 스키마에 대한 자세한 내용은 이 아폴로 기사에서 확인할 수 있으며, 유형은 이 graphql.org 기사에서 확인할 수 있습니다. 또한 FaunaDB는 스키마 파일을 선언하고 가져오기 위한 참조 문서를 제공합니다.

이제 이 `schema.graphql` 파일을 업로드하여 GraphQL API를 생성할 수 있습니다. FaunaDB 대시보드로 다시 이동하고 "GraphQL"을 클릭한 다음 새로 만든 스키마 파일을 여기에 업로드합니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/08/image-28.png?resize=896%2C460&ssl=1)

축하합니다! 완전한 기능을 갖춘 GraphQL API를 생성하였습니다. 이 페이지는 API와 상호 작용할 수 있는 "GraphQL Playground"로 바뀝니다. 사용 가능한 쿼리 및 돌연변이를 보려면 사이드바의 "문서" 탭을 클릭하십시오.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/08/image-29.png?resize=1410%2C687&ssl=1)

FaunaDB는 우리의 `all Items` 쿼리와 더불어 우리를 대신하여 다음과 같은 쿼리/변형을 자동으로 생성하였다.

- 항목 찾기아이디
- 항목 생성
- `업데이트 항목`
- `항목 삭제`

이 모든 것은 스키마 파일에 `Item` 유형을 선언하여 도출한 것입니다. 꽤 멋지지? 이 질문들과 돌연변이를 통해 우리 자신을 익숙해지도록 해보자. 우리는 "GraphQL 놀이터"에서 직접 질의와 돌연변이를 실행할 수 있다. 먼저 항목에 대한 쿼리를 실행합니다. 운동장의 왼쪽 창에 이 쿼리를 입력합니다.

```
query MyItemQuery {
 allItems {
   data {
    name
   }
 }
}
```

그런 다음 재생 버튼을 클릭하여 실행합니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/08/image-30.png?resize=1267%2C556&ssl=1)

결과가 오른쪽 창에 나열되고, 아직 항목을 만들지 않았으므로 결과가 반환되지 않습니다. 다행히 만들기Item은 스키마에서 자동으로 생성된 돌연변이 중 하나이며 이를 사용하여 샘플 항목을 채울 수 있습니다. 이 돌연변이를 실행해 봅시다.

```js
mutation MyItemCreation {
 createItem(data: { name: "My first todo item" }) {
   name
 }
}
```

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/08/image-31.png?resize=1271%2C439&ssl=1)

오른쪽 창에서 돌연변이의 결과를 볼 수 있습니다. 항목이 성공적으로 생성된 것처럼 보이지만 다시 확인하기 위해 첫 번째 쿼리를 다시 실행하여 결과를 확인할 수 있습니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/08/image-32.png?resize=1271%2C655&ssl=1)

플레이그라운드의 왼쪽 창에 첫 번째 쿼리를 다시 추가할 경우 재생 단추에서 수행할 작업을 선택할 수 있습니다. 마지막으로, 위 스크린샷의 3단계에서 우리 아이템이 성공적으로 만들어졌다는 것을 주목하세요.

위의 쿼리를 실행할 뿐만 아니라 FaunaDB의 "Collections" 탭에서 컬렉션을 직접 볼 수도 있습니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/08/image-33.png?resize=1600%2C605&ssl=1)

### 새 데이터베이스 키 프로비저닝

이제 데이터베이스 자체를 구성했으므로 React 애플리케이션이 데이터베이스에 액세스할 수 있는 방법이 필요합니다.

이 응용 프로그램의 단순성을 위해 이 작업은 Ract 응용 프로그램에 환경 변수로 추가할 수 있는 비밀 키로 수행됩니다. 개별 사용자에 대한 인증은 받지 않을 것입니다. 대신 항목을 생성, 읽기, 업데이트 및 삭제할 수 있는 권한이 있는 응용 프로그램 키를 생성합니다.

인증 및 인증은 자체적으로 중요한 주제입니다. FaunaDB가 이 가이드의 후속 연습으로 이를 처리하는 방법에 대해 자세히 알아보려면 여기에서 해당 주제에 대한 모든 내용을 읽어보십시오.

생성한 응용 프로그램 키에는 "역할"로 함께 그룹화된 관련 권한 집합이 있습니다. 먼저 항목에 대해 CRUD 작업을 수행할 수 있는 권한을 가진 역할을 정의하고 `모든 항목` 쿼리를 수행하는 것으로 시작하겠습니다. 먼저 "보안" 탭으로 이동한 다음 "역할 관리"를 클릭합니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/08/image-34.png?resize=956%2C523&ssl=1)

기본 역할인 admin과 Server가 2개 있습니다. 이론적으로는 이러한 역할을 키로 사용할 수 있지만, 이 키는 이 키에 액세스할 수 있는 모든 사용자가 새 컬렉션을 만들거나 데이터베이스 자체를 파괴하는 등의 데이터베이스 수준 작업을 수행할 수 있도록 허용하기 때문에 좋지 않은 생각입니다. 대신 "새 사용자 지정 역할" 단추를 클릭하여 새 역할을 만들어 보겠습니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/08/image-35.png?resize=925%2C541&ssl=1)

원하는 대로 역할 이름을 지정할 수 있습니다. 여기서는 ItemEditor라는 이름을 사용하고 항목을 읽고, 쓰고, 만들고, 삭제할 수 있는 역할 권한과 `모든 항목` 인덱스를 읽을 수 있는 권한을 부여합니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/08/image-36.png?resize=1600%2C776&ssl=1)

그런 다음 이 역할을 저장하고 "보안" 탭으로 이동하여 새 키를 만드십시오.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/08/image-37.png?resize=990%2C681&ssl=1)

키를 만들 때 역할 및 원하는 이름에 대해 "항목 편집기"를 선택해야 합니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/08/image-38.png?resize=767%2C517&ssl=1)

다음에는 복사해야 하는 비밀 키가 표시됩니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/08/image-39.png?resize=1487%2C546&ssl=1)

React가 키 값을 환경 변수로 로드하려면 React 응용 프로그램의 루트 수준에 있는 `.env.local`이라는 새 파일을 만듭니다. 이 파일에서 생성된 키에 대한 항목을 추가합니다.

```
REACT_APP_FAUNA_SECRET=fnADzT7kXcACAFHdiKG-lIUWq-hfWIVxqFi4OtTv
```

중요: 일반 텍스트로 소스 제어에 직접 암호를 저장하는 것은 좋지 않으므로 프로젝트의 루트 디렉터리에 .env.local을 포함하는 `.gitignore` 파일도 있어야 합니다. 그러면 gitrepo에 암호가 추가되어 다른 사용자와 공유되지 않습니다.

이 변수의 이름은 "REACT_APP_"로 시작하는 것이 중요합니다. 그렇지 않으면 응용 프로그램이 시작될 때 인식되지 않습니다. 이 값을 `.env.local` 파일에 추가하면 로컬에서 실행할 때 응용 프로그램에 대해 로드됩니다. 변경 내용을 확인하려면 `yarn start`를 사용하여 응용 프로그램을 명시적으로 중지했다가 다시 시작해야 합니다.

Create-react-app을 통해 생성된 앱에서 환경 변수가 로드되는 방법에 대해 자세히 알아보려면 여기를 참조하십시오. 이 비밀을 헤로쿠에서 환경변수로 추가하는 내용은 이 기사에서 다루겠습니다.

### 아폴로와 반응하여 FaunaDB 연결

React 애플리케이션이 GraphQL API와 상호 작용하기 위해서는 GraphQL 클라이언트 라이브러리 같은 것이 필요하다. 다행히도, 아폴로 클라이언트는 API 요청을 할 뿐만 아니라 결과를 캐싱하고 상호작용할 수 있는 우아한 인터페이스를 제공한다.

필요한 관련 아폴로 패키지를 설치하려면 다음을 실행하십시오.

```terminal
yarn add @apollo/client graphql @apollo/react-hooks
```

이제 응용 프로그램의 `src` 디렉터리에 다음과 같은 내용으로 `client.js`라는 새 파일을 추가하십시오.

```js
import { ApolloClient, InMemoryCache } from "@apollo/client";
export const client = new ApolloClient({
 uri: "https://graphql.fauna.com/graphql",
 headers: {
   authorization: `Bearer ${process.env.REACT_APP_FAUNA_SECRET}`,
 },
 cache: new InMemoryCache(),
});
```

여기서 우리가 하고 있는 것은 우리의 FaunaDB 데이터베이스에 대한 요청을 하기 위해 아폴로를 구성하는 것입니다. 특히 uri는 Fauna 자체에 요청을 한 다음 권한 부여 헤더에 이전에 생성한 제공된 키에 대한 특정 데이터베이스 인스턴스에 연결 중임을 나타냅니다.

이 코드 조각에는 두 가지 중요한 의미가 있습니다.

- 권한 부여 헤더는 "ItemEditor" 역할을 가진 키를 포함하고 있으며, 현재 어떤 사용자가 우리의 애플리케이션을 보고 있는지에 관계없이 동일한 헤더를 사용하도록 하드 코딩되어 있다. 각 사용자에 대해 다른 작업관리 목록을 표시하도록 이 응용 프로그램을 업데이트하려면 각 사용자에 대해 로그인하고 이 헤더에 전달할 수 있는 토큰을 생성해야 합니다. 다시 한 번, FaunaDB 문서에서는 이 개념에 대해 자세히 알고자 하는 경우 이 개념을 다룹니다.
- 시스템에 캐슁 계층을 추가할 때(Apollo를 사용하는 경우)와 마찬가지로 오래된 데이터가 있을 수 있습니다. FaunaDB의 작업은 매우 일관적이며, 오래된 데이터의 가능성을 최소화하도록 아폴로의 `페치 정책`을 구성할 수 있습니다. 캐시에 대한 오래된 읽기를 방지하기 위해, 우리는 재추적 쿼리와 돌연변이에 응답 필드를 지정하는 것의 조합을 사용할 것이다.

다음에는 홈 페이지 구성 요소의 내용을 교체하겠습니다. `App.js`로 이동하여 콘텐츠를 다음으로 교체합니다.

```jsx
import React from "react";
import { ApolloProvider } from "@apollo/client";
import { client } from "./client";
function App() {
 return (
   <ApolloProvider client={client}>
     <div style={ padding: "5px" }>
       <h3>My Todo Items</h3>
       <div>items to get loaded here</div>
     </div>
   </ApolloProvider>
 );
}
```

참고: 이 샘플 애플리케이션의 경우 프레젠테이션보다 기능에 중점을 두고 있습니다. 그러면 인라인 스타일이 표시됩니다. 프로덕션 등급 애플리케이션에는 이 제품을 추천하지 않지만, 적어도 소규모 데모에서는 가장 간단한 방식으로 추가된 스타일을 보여 줄 수 있다고 생각합니다.

http://localhost:3000을 다시 방문하면 다음과 같은 정보를 얻을 수 있습니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/08/image-40.png?resize=280%2C141&ssl=1)

위 jsx에서 설정한 하드코드 값을 포함합니다. 그러나 우리가 정말로 보고 싶은 것은 우리가 데이터베이스에서 만든 작업관리 항목이다. `src` 디렉토리에서 데이터베이스의 모든 항목을 나열하는 `ItemList`라는 구성 요소를 생성해 보겠습니다.

```jsx
import React from "react";
import gql from "graphql-tag";
import { useQuery } from "@apollo/react-hooks";
const ITEMS_QUERY = gql`
 {
   allItems {
     data {
       _id
       name
     }
   }
 }
`;
export function ItemList() {
 const { data, loading } = useQuery(ITEMS_QUERY);
if (loading) {
   return "Loading...";
 }
return (
   <ul>
     {data.allItems.data.map((item) => {
       return <li key={item._id}>{item.name}</li>;
     })}
   </ul>
 );
}
```

그런 다음 `App.js`를 업데이트하여 이 새 구성 요소를 렌더링합니다. 이 예제 소스 코드의 전체 커밋을 참조하여 이 단계를 전체적으로 확인하십시오. 앱을 다시 미리 보면 작업관리 항목이 로드된 것을 알 수 있습니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/08/image-41.png?resize=320%2C167&ssl=1)

지금이 당신의 진전을 약속할 좋은 시기입니다. Heroku를 사용하기 때문에 구축은 매우 간단합니다.

```terminal
git push heroku master
heroku open
```

그러나 `heroku open`을 실행하면 페이지가 비어 있는 것을 볼 수 있습니다. 네트워크 트래픽을 검사하고 FaunaDB에 요청하면 데이터베이스 암호가 누락된 방법에 대한 오류가 표시됩니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/08/image-42.png?resize=1024%2C555&ssl=1)

아직 헤로쿠에서 이 값을 구성하지 않았으니 말이 되는군요. Heroku 대시보드로 이동하여 응용 프로그램을 선택한 다음 "Settings"(설정) 탭을 클릭하여 설정해 보겠습니다. 여기에 앞의 .env.local 파일에 사용된 `REACT_APP_FAUNA_SECRET` 키와 값을 추가해야 합니다. 이 키를 다시 사용하면 시연할 수 있습니다. "실제" 응용프로그램에서는 각 환경에 대해 별도의 데이터베이스와 별도의 키를 가질 수 있습니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/08/image-43.png?resize=1024%2C579&ssl=1)

Heroku의 웹 인터페이스 대신 명령줄을 사용하려면 다음 명령을 사용하고 대신 암호를 키로 바꿀 수 있습니다.

```terminal
heroku config:set REACT_APP_FAUNA_SECRET=fnADzT7kXcACAFHdiKG-lIUWq-hfWIVxqFi4OtTv
```

중요: Heroku 문서에 나와 있는 대로 이 환경 변수를 앱에 적용하려면 배포를 트리거해야 합니다.

```terminal
git commit — allow-empty -m 'Add REACT_APP_FAUNA_SECRET env var'
git push heroku master
heroku open
```

이 마지막 명령을 실행한 후 Heroku 호스트된 앱이 나타나 데이터베이스에서 항목을 로드해야 합니다.

### 새 작업관리 항목 추가

이제 FaunaDB 데이터베이스에 로컬 및 호스팅된 Heroku 환경 모두에 액세스할 수 있는 모든 자료를 확보했습니다. 이제 항목을 추가하는 것은 이전에 GraphQL 놀이터에서 사용했던 돌연변이를 호출하는 것만큼 간단합니다. 맨본 html 양식을 사용하여 `create`를 호출하는 `AddItem` 구성 요소의 코드는 다음과 같습니다.항목 변이:

```jsx
import React from "react";
import gql from "graphql-tag";
import { useMutation } from "@apollo/react-hooks";
const CREATE_ITEM = gql`
 mutation CreateItem($data: ItemInput!) {
   createItem(data: $data) {
     _id
   }
 }
`;
const ITEMS_QUERY = gql`
 {
   allItems {
     data {
       _id
       name
     }
   }
 }
`;
export function AddItem() {
 const [showForm, setShowForm] = React.useState(false);
 const [newItemName, setNewItemName] = React.useState("");
const [createItem, { loading }] = useMutation(CREATE_ITEM, {
   refetchQueries: [{ query: ITEMS_QUERY }],
   onCompleted: () => {
     setNewItemName("");
     setShowForm(false);
   },
 });
if (showForm) {
   return (
     <form
       onSubmit={(e) => {
         e.preventDefault();
         createItem({ variables: { data: { name: newItemName } } });
       }
     >
       <label>
         <input
           disabled={loading}
           type="text"
           value={newItemName}
           onChange={(e) => setNewItemName(e.target.value)}
           style={ marginRight: "5px" }
         />
       </label>
       <input disabled={loading} type="submit" value="Add" />
     </form>
   );
 }
return <button onClick={() => setShowForm(true)}>Add Item</button>;
}
```

App 컴포넌트의 AddItem에 대한 참조를 추가한 후 항목 추가가 예상대로 작동하는지 확인할 수 있습니다. 이 단계를 다시 한 번 요약하기 위해 데모 앱에서 전체 커밋을 볼 수 있습니다.

### 새 작업관리 항목 삭제

자동으로 생성된 `AddItem` 돌연변이를 불러 새로운 항목을 추가하는 방법과 마찬가지로 생성된 `DeleteItem` 돌연변이를 불러 목록에서 항목을 제거할 수 있다. 이 돌연변이를 추가한 업데이트된 `ItemList` 구성 요소는 다음과 같습니다.

```jsx
import React from "react";
import gql from "graphql-tag";
import { useMutation, useQuery } from "@apollo/react-hooks";
const ITEMS_QUERY = gql`
 {
   allItems {
     data {
       _id
       name
     }
   }
 }
`;
const DELETE_ITEM = gql`
 mutation DeleteItem($id: ID!) {
   deleteItem(id: $id) {
     _id
   }
 }
`;
export function ItemList() {
 const { data, loading } = useQuery(ITEMS_QUERY);
const [deleteItem, { loading: deleteLoading }] = useMutation(DELETE_ITEM, {
   refetchQueries: [{ query: ITEMS_QUERY }],
 });
if (loading) {
   return <div>Loading...</div>;
 }
return (
   <ul>
     {data.allItems.data.map((item) => {
       return (
         <li key={item._id}>
           {item.name}{" "}
           <button
             disabled={deleteLoading}
             onClick={(e) => {
               e.preventDefault();
               deleteItem({ variables: { id: item._id } });
             }
           >
             Remove
           </button>
         </li>
       );
     })}
   </ul>
 );
}
```

앱을 다시 로드하고 다른 항목을 추가하면 다음과 같은 페이지가 나타납니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/08/image-44.png?resize=336%2C201&ssl=1)

항목에 대해 "제거" 버튼을 클릭하면 "DELETE_"Item` 돌연변이가 발생하고 전체 항목 목록은 `refetchQuery` 옵션에 지정된 대로 실행됩니다.

한 가지 눈에 띄는 점은 당사의 `ITEMS_QUARY`에서 질의 결과 집합에서 원하는 필드 중 하나로 `_id`를 지정하고 있다는 것입니다. 이 `_id` 필드는 FaunaDB에서 각 컬렉션의 고유 식별자로 자동 생성되며, 레코드를 업데이트하거나 삭제할 때 사용해야 합니다.

### 항목을 완료로 표시

항목을 완료로 표시할 수 없는 경우 이 작업관리 목록이 제대로 작동하지 않을 수 있습니다. 지금 바로 추가해 보겠습니다. 작업이 끝나면 앱이 다음과 같이 보일 것으로 예상됩니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/08/image-45.png?resize=479%2C235&ssl=1)

우리가 취해야 할 첫 번째 단계는 FaunaDB 내에서 Item 스키마를 업데이트하는 것입니다. 왜냐하면 지금 우리가 어떤 항목에 대해 저장하는 유일한 정보는 그것의 이름이기 때문입니다. `schema.graphql` 파일로 이동하여 항목의 완료 상태를 추적하는 새 필드를 추가할 수 있습니다.

```schema.graphql
type Item {
 name: String
 isComplete: Boolean
}
type Query {
 allItems: [Item!]
}
```

이제 FaunaDB 콘솔의 GraphQL 탭으로 이동하여 "Update Schema" 링크를 클릭하여 새로 업데이트된 스키마 파일을 업로드합니다.

참고: 원하는 경우 데이터베이스의 스키마를 처음부터 다시 쓰는 데 사용할 수 있는 "Schema 재정의" 옵션도 있습니다. 스키마를 완전히 재정의하도록 선택할 때 고려해야 할 한 가지 사항은 데이터가 데이터베이스에서 삭제된다는 것입니다. 테스트 환경에서는 이 방법이 괜찮을 수 있지만 테스트 또는 프로덕션 환경에서는 대신 적절한 데이터베이스 마이그레이션이 필요합니다.

여기서는 변경 사항이 추가되므로 기존 스키마와 충돌하지 않으므로 기존 데이터를 유지할 수 있습니다.

Fauna의 GraphQL Playground에서 돌연변이 자체와 돌연변이의 예상 스키마를 볼 수 있습니다.DB:

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/08/image-46.png?resize=1505%2C838&ssl=1)

이것은 우리가 `ItemInput` 유형의 데이터 매개 변수를 사용하여 `deleteItem` 돌연변이를 호출할 수 있음을 알려준다. 다른 요청들과 마찬가지로, 우리는 우리가 원한다면 운동장에서 이 돌연변이를 시험해 볼 수 있습니다. 지금은 응용 프로그램에 직접 추가할 수 있습니다. `ItemList.js`에서 예제 리포지토리에 설명된 대로 이 코드를 사용하여 이 돌연변이를 추가해 봅시다.

`UPDATE_`에 대한 참조ITEM은 우리가 수행한 가장 적절한 변경 사항입니다. 이 돌연변이에 대해 `리페치 쿼리` 매개 변수가 필요하지 않다는 점도 흥미롭다. 업데이트 돌연변이가 돌아오면, 아폴로는 식별자 필드(이 경우 `_id`)를 기반으로 캐시에서 해당 항목을 업데이트하므로, 우리의 리액트 구성요소는 캐시 업데이트에 따라 적절히 리렌더한다.

이제 초기 버전의 작업관리 응용 프로그램에 대한 모든 기능을 사용할 수 있습니다. 마지막 단계로 지점을 다시 한 번 Heroku로 이동합니다.

```html
git push heroku master
heroku open
```

### 결론

잠시 여러분의 등을 쓰다듬어 보세요! 새로운 React 애플리케이션을 만들고, FaunaDB를 통한 데이터베이스 레벨에서 지속성을 추가했으며, Heroku에 대한 지점을 통해 전 세계에 사용할 수 있는 배포를 수행할 수 있습니다.

이제 FaunaDB를 프로비저닝하고 FaunaDB와 상호 작용하기 위한 몇 가지 개념을 다루었으므로, 향후 유사한 프로젝트를 수립하는 것은 놀라울 정도로 빠른 프로세스입니다. 몇 분 만에 GraphQL 액세스 가능한 데이터베이스를 프로비저닝할 수 있다는 것은 새로운 프로젝트의 회전 속도를 높이는 데 있어 저에게 꿈입니다. 뿐만 아니라, 이것은 구성이나 확장에 대해 걱정할 필요가 없는 운영 등급 데이터베이스입니다. 대신 데이터베이스 관리자의 역할 대신 애플리케이션의 나머지 부분을 작성하는 데 집중해야 합니다.