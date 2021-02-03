---
layout: post
title: "Netlify, Gatsby 및 Fauna를 사용하여 클라이언트 서버리스 Jamstack 앱을 만드는 방법
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/12/list-app.png
tags: 
---


Jamstack은 클라이언트 측 JavaScript, 재사용 가능한 API 및 사전 빌드 된 마크 업을 기반으로하는 최신 웹 개발 아키텍처입니다.
 

Jamstack 애플리케이션의 주요 측면은 다음과 같습니다.
 

- 전체 앱은 CDN (또는 ADN)에서 실행됩니다.
 CDN은 Content Delivery Network의 약자이며 ADN은 Application Delivery Network입니다.
 
- 모든 것이 Git에 있습니다.
 
- 개발자가 코드를 푸시하면 자동화 된 빌드가 워크 플로와 함께 실행됩니다.
 
- 사전 제작 된 마크 업을 CDN / ADN에 자동 배포합니다.
 
- 재사용 가능한 API는 많은 서비스와 번거 로움없이 통합됩니다.
 몇 가지 예를 들어, 결제 및 체크 아웃을위한 Stripe, 이메일 서비스를위한 Mailgun 등을들 수 있습니다. 특정 사용 사례를 대상으로하는 맞춤형 API를 작성할 수도 있습니다.
 이 기사에서는 이러한 사용자 지정 API의 예를 살펴 보겠습니다.
 
- 사실상 서버리스입니다.
 더 명확하게 말하면, 우리는 서버를 유지하지 않고 기존 서비스 (이메일, 미디어, 데이터베이스, 검색 등) 또는 서버리스 기능을 사용합니다.
 

이 기사에서는 다음을 포함하는 Jamstack 애플리케이션을 빌드하는 방법을 배웁니다.
 

- GraphQL을 지원하는 글로벌 데이터 스토어로 데이터를 쉽게 저장하고 가져옵니다.
 이를 위해 Fauna를 사용할 것입니다.
 
- Fauna 데이터 저장소에서 데이터를 가져 오는 API 역할도하는 서버리스 함수입니다.
 이를 위해 Netlify 서버리스 기능을 사용합니다.
 
- Gatsbyjs라는 정적 사이트 생성기를 사용하여 앱의 클라이언트 측을 빌드합니다.
 
- 마지막으로 Netlify CDN에서 구성하고 관리하는 CDN에 앱을 배포합니다.
 

### 그래서 우리는 오늘 무엇을 만들고 있습니까?
 

우리는 모두 쇼핑을 좋아합니다.
 모든 쇼핑 노트를 중앙에서 관리하는 것이 얼마나 멋질까요?
 그래서 우리는 가게 노트를 관리 할 수있는 `shopnote`라는 앱을 만들 것입니다.
 메모에 하나 이상의 항목을 추가하고, 완료로 표시하고, 긴급으로 표시하는 등의 작업을 수행 할 수도 있습니다.
 

이 기사의 끝에서 우리의 shopnote 앱은 다음과 같이 보일 것입니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/11/shopnote.png?resize=1600%2C919&ssl=1)

### TL; DR
 

이 기사에서는 단계별 접근 방식으로 내용을 배웁니다.
 소스 코드 또는 데모로 더 빨리 들어가고 싶다면 여기에 링크가 있습니다.
 

- https://shopnote.netlify.app/에서 상점 노트 데모에 액세스 할 수 있습니다.
 
- 이 기사에서 사용 된 모든 소스 코드는 내 GitHub 저장소에 있습니다.
 소스 코드를 자주 업데이트하고 있으므로 자유롭게 따라 해보세요.
 https://github.com/atapas/shopnote
 

### Fauna 설정
 

Fauna는 클라이언트-서버리스 애플리케이션을위한 데이터 API입니다.
 기존 RDBMS에 익숙하다면 Fauna와의 주요 차이점은 레거시 RDBMS의 모든 기능을 제공하는 관계형 NOSQL 시스템입니다.
 확장 성과 성능을 손상시키지 않으면 서 매우 유연합니다.
 

Fauna는 데이터 액세스를 위해 여러 API를 지원합니다.
 

- GraphQL : 오픈 소스 데이터 쿼리 및 조작 언어.
 GraphQL을 처음 사용하는 경우 https://graphql.org/에서 자세한 내용을 확인할 수 있습니다.
 
- Fauna Query Language (FQL) : Fauna를 쿼리하기위한 API입니다.
 FQL에는 JavaScript, Java, Go 등과 같은 언어로 유연하게 사용할 수있는 언어 별 드라이버가 있습니다. 여기에서 FQL에 대한 자세한 내용을 확인하십시오.
 

이 기사에서는 ShopNote 애플리케이션에서 GraphQL의 사용법을 설명합니다.
 

먼저이 URL을 사용하여 가입하십시오.
 일일 사용량이 넉넉하고 사용량에 충분한 무료 요금제를 선택하세요.
 

다음으로, 원하는 데이터베이스 이름을 제공하여 데이터베이스를 만듭니다.
 데이터베이스 이름으로 shopnotes를 사용했습니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/11/create_db.png?resize=628%2C596&ssl=1)

데이터베이스를 생성 한 후 GraphQL 스키마를 정의하고 데이터베이스로 가져옵니다.
 GraphQL 스키마는 데이터의 구조를 정의합니다.
 데이터 유형과 이들 간의 관계를 정의합니다.
 스키마를 사용하여 허용되는 쿼리 유형을 지정할 수도 있습니다.
 

이 단계에서 프로젝트 폴더를 생성하겠습니다.
 이름이 shopnote 인 하드 드라이브 어딘가에 프로젝트 폴더를 만듭니다.
 다음 내용으로 이름이`shopnotes.gql` 인 파일을 만듭니다.
 

```js
type ShopNote {
  name: String!
  description: String
  updatedAt: Time
  items: [Item!] @relation
}
 
type Item {
  name: String!
  urgent: Boolean
  checked: Boolean
  note: ShopNote!
}
 
type Query {
  allShopNotes: [ShopNote!]!
}
```

여기에서는 각 `ShopNote`에 이름, 설명, 업데이트 시간 및 항목 목록이 포함 된 shopnote 목록 및 항목에 대한 스키마를 정의했습니다.
 각`Item` 유형에는 이름, 긴급, 확인 및 그것이 속한 shopnote와 같은 속성이 있습니다.
 

여기에서`@ relation` 지시문을 확인하십시오.
 `@ relation` 지시문으로 필드에 주석을 달아 대상 유형과의 양방향 관계에 참여하도록 표시 할 수 있습니다.
 이 경우`ShopNote`와`Item`은 일대 다 관계에 있습니다.
 즉, 하나의 `ShopNote`에는 여러 개의 항목이있을 수 있으며 각 항목은 최대 하나의 ShopNote와 관련 될 수 있습니다.
 

여기에서`@ relation` 지시문에 대해 자세히 알아볼 수 있습니다.
 GraphQL 관계에 대한 자세한 내용은 여기에서 찾을 수 있습니다.
 

다음 단계로 IMPORT SCHEMA 버튼을 사용하여 Fauna 대시 보드에서`shopnotes.gql` 파일을 업로드합니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/11/Import_schema.png?resize=653%2C274&ssl=1)

GraphQL 스키마를 가져올 때 FaunaDB는 다음 리소스를 자동으로 생성, 유지 및 업데이트합니다.
 

- 네이티브가 아닌 각 GraphQL 유형에 대한 컬렉션
 이 경우 ShopNote 및 Item입니다.
 
- 스키마에 의해 생성 된 각 컬렉션에 대한 기본 CRUD 쿼리 / 변형 (예 :
 `createShopNote``allShopNotes`;
 각각은 FQL에 의해 구동됩니다.
 
- 특정 GraphQL 지시문 : 관계 설정을위한 사용자 지정 인덱스 또는 FQL (예 :`@ relation`), 고유성 (`@ unique`) 등!
 

이면에서 Fauna는 문서를 자동으로 생성하는 데 도움을줍니다.
 우리는 잠시 후에 그것을 보게 될 것입니다.
 

Fauna는 스키마없는 개체 관계형 데이터 모델을 지원합니다.
 Fauna의 데이터베이스에는 컬렉션 그룹이 포함될 수 있습니다.
 컬렉션에는 하나 이상의 문서가 포함될 수 있습니다.
 각 데이터 레코드가 문서에 삽입됩니다.
 이것은 다음과 같이 시각화 할 수있는 계층을 형성합니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/11/Fauna.png?resize=900%2C500&ssl=1)

여기서 데이터 레코드는 배열, 객체 또는 기타 지원되는 유형일 수 있습니다.
 Fauna 데이터 모델을 사용하여 인덱스를 생성하고 제약을 적용 할 수 있습니다.
 동물 색인은 여러 컬렉션의 데이터를 결합 할 수 있으며 계산을 수행 할 수 있습니다.
 

이 단계에서 Fauna는 이미 ShopNote 및 Item이라는 두 가지 컬렉션을 만들었습니다.
 레코드 삽입을 시작하면 문서도 생성되는 것을 볼 수 있습니다.
 레코드를보고 쿼리 할 수 있으며 인덱스의 힘을 활용할 수 있습니다.
 잠시 후에 Fauna 대시 보드에 데이터 모델 구조가 표시되는 것을 볼 수 있습니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/11/pasted-image-0.png?resize=1530%2C707&ssl=1)

여기에서 각 문서는 고유 한 `ref`속성으로 식별됩니다.
 문서에 대한 최근 수정의 타임 스탬프를 반환하는`ts` 필드도 있습니다.
 데이터 레코드는 `데이터`필드의 일부입니다.
 이러한 이해는 FQL 내장 함수를 사용하여 컬렉션, 문서, 레코드와 상호 작용할 때 정말 중요합니다.
 그러나이 기사에서는 Netlify 함수와 함께 GraphQL 쿼리를 사용하여 상호 작용할 것입니다.
 

이러한 모든 이해를 바탕으로 성공적으로 생성되고 사용할 준비가 된 Shopenotes 데이터베이스 사용을 시작하겠습니다.
 

스키마를 가져 왔고 기본 항목이 제자리에 있지만 아직 문서가 없습니다.
 하나를 만들어 보겠습니다.
 이를 위해 다음 GraphQL 돌연변이 쿼리를 GraphQL 플레이 그라운드 화면의 왼쪽 패널에 복사하고 실행합니다.
 

```js
mutation {
  createShopNote(data: {
    name: "My Shopping List"
    description: "This is my today's list to buy from Tom's shop"
    items: {
      create: [
        { name: "Butther - 1 pk", urgent: true }
        { name: "Milk - 2 ltrs", urgent: false }
        { name: "Meat - 1lb", urgent: false }
      ]
    }
  }) {
    _id
    name
    description
    items {
      data {
        name,
        urgent
      }
    }
  }
}
```

Fauna는 이미 백그라운드에서 GraphQL 뮤 테이션 클래스를 생성 했으므로`createShopNote`와 같이 직접 사용할 수 있습니다.
 성공적으로 실행되면 편집기 오른쪽에서 ShopNote 생성에 대한 응답을 볼 수 있습니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/11/crate_query.png?resize=1549%2C925&ssl=1)

새로 생성 된 `ShopNote`문서에는 생성하는 동안 전달한 모든 필수 세부 정보가 있습니다.
 우리는`ShopNote`가`Item`과 일대 다 관계를 갖는 것을 보았습니다.
 shopnote 응답에 항목 데이터가 중첩되어있는 것을 볼 수 있습니다.
 이 경우 하나의 shopnote에 세 개의 항목이 있습니다.
 이것은 정말 강력합니다.
 스키마와 관계가 정의되면 해당 관계를 염두에두고 문서가 자동으로 생성됩니다.
 

이제 모든 shopnote를 가져와 보겠습니다.
 GraphQL 쿼리는 다음과 같습니다.
 

```js
query {
    allShopNotes {
    data {
      _id
      name
      description
      updatedAt
      items {
        data {
          name,
          checked,
          urgent
        }
      }
    }
  }
}
```

이전처럼 플레이 그라운드에서 쿼리를 시도해 보겠습니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/11/query.png?resize=1547%2C916&ssl=1)

이제 스키마가있는 데이터베이스가 있으며 생성 및 가져 오기 기능으로 완벽하게 작동합니다.
 마찬가지로 shopnote에 항목을 추가, 업데이트, 제거하고 shopnote를 업데이트 및 삭제하기위한 쿼리를 생성 할 수 있습니다.
 이러한 쿼리는 나중에 서버리스 함수를 만들 때 사용됩니다.
 

GraphQL 편집기에서 다른 쿼리를 실행하려면 여기에서 찾을 수 있습니다.
 

다음으로, 데이터베이스에 대한 액세스가 인증되고 승인되었는지 확인하기 위해 보안 서버 키를 만들어야합니다.
 

FaunaDB 인터페이스에서 사용 가능한 보안 옵션을 클릭하여 키를 생성합니다.
 

![image](https://lh6.googleusercontent.com/dnbZmi7WBmwOUTSJlWmP8ZYZpOh-T9LUTMI4D4JrAlZ3kGMOh6uRgyIgKeScAHzZ60jjCyBsSW4Y4y6OcdTpEzfd7KoIm4nt-WxKPjmC4FAK09-ua2GP24eWAcLy8vgT3u4aoAJd)

키가 성공적으로 생성되면 키의 비밀을 볼 수 있습니다.
 복사하여 안전한 곳에 저장하십시오.
 

![image](https://lh6.googleusercontent.com/U-Yd5eSSRcSAVGNbKY-1H-kfq5F-EPCAKWgp8QZrNcCCFRVLoz1Jh_bMT8bzKS62MBVEiwB00-diljHfOULJZ58XeqT6jAgEbTo-m96a_Qo8Rqmr1kDd-T6d9z7QlUhRpDVk3O9k)

우리는 다른 사람이이 키에 대해 알기를 원하지 않습니다.
 소스 코드 저장소에 커밋하는 것도 좋은 생각이 아닙니다.
 이 비밀을 유지하려면 프로젝트 폴더의 루트 수준에`.env`라는 빈 파일을 만듭니다.
 

`.env` 파일을 편집하고 여기에 다음 줄을 추가합니다 (`<YOUR_FAUNA_KEY_SECRET>`대신 생성 된 서버 키 붙여 넣기).
 

```js
FAUNA_SERVER_SECRET=<YOUR_FAUNA_KEY_SECRET>
```

`.gitignore` 파일을 추가하고 다음 내용을 작성합니다.
 이는 실수로 .env 파일을 소스 코드 저장소에 커밋하지 않도록하기위한 것입니다.
 또한 모범 사례로 node_modules를 무시하고 있습니다.
 

```.gitignore
.env
```

Fauna의 설정과 관련된 모든 작업이 완료되었습니다.
 다음 단계로 넘어 가서 Fauna 데이터 저장소의 데이터에 액세스하기위한 서버리스 함수 및 API를 생성하겠습니다.
 이 단계에서 디렉토리 구조는 다음과 같습니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/11/Dir_structure_1.png?resize=461%2C347&ssl=1)

### Netlify 서버리스 기능 설정
 

Netlify는 번거롭지 않은 서버리스 기능을 만들 수있는 훌륭한 플랫폼입니다.
 이러한 함수는 데이터베이스, 파일 시스템 및 메모리 내 개체와 상호 작용할 수 있습니다.
 

Netlify 함수는 AWS Lambda에 의해 구동됩니다.
 AWS Lambda를 자체적으로 설정하는 것은 상당히 복잡한 작업 일 수 있습니다.
 Netlify를 사용하면 간단히 폴더를 설정하고 함수를 삭제합니다.
 간단한 함수 작성은 자동으로 API가됩니다.
 

먼저 Netlify로 계정을 만드십시오.
 이것은 무료이며 FaunaDB 프리 티어와 마찬가지로 Netlify도 매우 유연합니다.
 

이제 npm 또는 yarn을 사용하여 몇 가지 종속성을 설치해야합니다.
 nodejs가 설치되어 있는지 확인하십시오.
 프로젝트 폴더의 루트에서 명령 프롬프트를 엽니 다.
 다음 명령을 사용하여 노드 종속성으로 프로젝트를 초기화하십시오.
 

```terminal
npm init -y
```

서버리스 기능을 로컬에서 실행할 수 있도록 netlify-cli 유틸리티를 설치하십시오.
 

```terminal
npm install netlify-cli -g
```

이제 두 개의 중요한 라이브러리 인 axios와 dotenv를 설치할 것입니다.
 axios는 HTTP 호출에 사용되며 dotenv는`.env` 파일의`FAUNA_SERVER_SECRET` 환경 변수를`process.env`로로드하는 데 도움이됩니다.
 

```terminal
yarn add axios dotenv
```

또는:
 

```terminal
npm i axios dotenv
```

프로젝트 폴더의 루트에`functions`라는 이름의 폴더를 만듭니다.
 우리는 모든 서버리스 기능을 그 아래에 둘 것입니다.
 

이제`functions` 폴더 아래에`utils`라는 하위 폴더를 만듭니다.
 `utils` 폴더 아래에`query.js`라는 파일을 만듭니다.
 모든 서버리스 기능에 대해 데이터 저장소를 쿼리하려면 몇 가지 공통 코드가 필요합니다.
 공통 코드는`query.js` 파일에 있습니다.
 

먼저 axios 라이브러리 기능을 가져오고`.env` 파일을로드합니다.
 다음으로 쿼리와 변수를받는 비동기 함수를 내 보냅니다.
 비동기 함수 내에서 비밀 키가있는 axios를 사용하여 호출합니다.
 마지막으로 응답을 반환합니다.
 

```js
// query.js
 
const axios = require("axios");
require("dotenv").config();
 
module.exports = async (query, variables) => {
  const result = await axios({
      url: "https://graphql.fauna.com/graphql",
      method: "POST",
      headers: {
          Authorization: `Bearer ${process.env.FAUNA_SERVER_SECRET}`
      },
      data: {
        query,
        variables
      }
 });
 
 return result.data;
};
```

`functions` 폴더 아래에`get-shopnotes.js`라는 이름의 파일을 만듭니다.
 모든 상점 노트를 가져 오는 쿼리를 수행합니다.
 

```js
// get-shopnotes.js
 
const query = require("./utils/query");
 
const GET_SHOPNOTES = `
   query {
       allShopNotes {
       data {
         _id
         name
         description
         updatedAt
         items {
           data {
             _id,
             name,
             checked,
             urgent
         }
       }
     }
   }
 }  
`;
 
exports.handler = async () => {
  const { data, errors } = await query(GET_SHOPNOTES);
 
  if (errors) {
    return {
      statusCode: 500,
      body: JSON.stringify(errors)
    };
  }
 
  return {
    statusCode: 200,
    body: JSON.stringify({ shopnotes: data.allShopNotes.data })
  };
};
```

API와 같은 서버리스 기능을 테스트 할 시간입니다.
 여기서 한 번 설정해야합니다.
 프로젝트 폴더의 루트에서 명령 프롬프트를 열고 다음을 입력합니다.
 

```terminal
netlify login
```

그러면 브라우저 탭이 열리고 로그인하고 Netlify 계정에 대한 액세스 권한을 부여하라는 메시지가 표시됩니다.
 승인 버튼을 클릭하십시오.
 

다음으로 프로젝트 폴더의 루트에`netlify.toml`이라는 파일을 만들고이 내용을 추가합니다.
 

```js
[build]
    functions = "functions"
 
[[redirects]]
   from = "/api/*"
   to = "/.netlify/functions/:splat"
   status = 200
```

이것은 우리가 작성한 함수의 위치를 Netlify에 알려 빌드시에 알 수 있도록하기위한 것입니다.
 

Netlify는 함수에 대한 API를 자동으로 제공합니다.
 API에 액세스하기위한 URL은`/ .netlify / functions / get-shopnotes` 형식으로되어있어 사용자 친화적이지 않을 수 있습니다.
 우리는`/ api / get-shopnotes`와 같은 리디렉션을 작성했습니다.
 

좋아, 우리는 끝났다.
 이제 명령 프롬프트 유형에서
 

```terminal
netlify dev
```

기본적으로 앱은 localhost : 8888에서 실행되어 서버리스 기능에 API로 액세스합니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/11/netlify_dev.png?resize=974%2C394&ssl=1)

브라우저 탭을 열고 다음 URL을 시도합니다.`http : // localhost : 8888 / api / get-shopnotes` :
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/11/get_netlify_function.png?resize=629%2C638&ssl=1)

축하합니다!!!
 첫 번째 서버리스 기능을 실행했습니다.
 

이제 `ShopNote`를 생성하는 다음 서버리스 함수를 작성해 보겠습니다.
 이것은 간단 할 것입니다.
 `functions` 폴더 아래에`create-shopnote.js`라는 파일을 만듭니다.
 필수 매개 변수를 전달하여 변형을 작성해야합니다.
 

```js
//create-shopnote.js
 
const query = require("./utils/query");
 
const CREATE_SHOPNOTE = `
  mutation($name: String!, $description: String!, $updatedAt: Time!, $items: ShopNoteItemsRelation!) {
    createShopNote(data: {name: $name, description: $description, updatedAt: $updatedAt, items: $items}) {
      _id
      name
      description
      updatedAt
      items {
        data {
          name,
          checked,
          urgent
        }
      }
    }
  }
`;
 
exports.handler = async event => {
  
  const { name, items } = JSON.parse(event.body);
  const { data, errors } = await query(
    CREATE_SHOPNOTE, { name, items });
 
  if (errors) {
    return {
      statusCode: 500,
      body: JSON.stringify(errors)
    };
  }
 
  return {
    statusCode: 200,
    body: JSON.stringify({ shopnote: data.createShopNote })
  };
};
```

매개 변수`ShopNotesItemRelation`에주의하십시오.
 스키마에서`ShopNote`와`Item` 사이에 관계를 생성 했으므로 쿼리를 작성하는 동안에도이를 유지해야합니다.
 

페이로드에서 필요한 정보를 가져 오기 위해 페이로드를 구조화했습니다.
 그것들을 얻었을 때 우리는`ShopNote`를 생성하기 위해 쿼리 메소드를 호출했습니다.
 

좋습니다. 테스트 해 보겠습니다.
 우편 배달부 또는 원하는 다른 도구를 사용하여 API처럼 테스트 할 수 있습니다.
 다음은 우편 배달부의 스크린 샷입니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/11/create_shopnote.png?resize=1460%2C783&ssl=1)

좋아, 우리는 쇼핑 마트에서 사고 싶은 모든 항목으로 `ShopNote`를 만들 수 있습니다.
 기존`ShopNote`에 항목을 추가하려면 어떻게해야합니까?
 이를위한 API를 만들어 보겠습니다.
 지금까지 우리가 알고있는 지식으로 정말 빠를 것입니다.
 

`ShopNote`와 `Item`은 관련되어 있다는 것을 기억하십니까?
 따라서 아이템을 생성하기 위해서는 어떤`ShopNote`에 포함될 것인지 반드시 알려야합니다.
 다음은 기존`ShopNote`에 항목을 추가하는 서버리스 기능입니다.
 

```js
//add-item.js
 
const query = require("./utils/query");
 
const ADD_ITEM = `
  mutation($name: String!, $urgent: Boolean!, $checked: Boolean!, $note: ItemNoteRelation!) {
    createItem(data: {name: $name, urgent: $urgent, checked: $checked, note: $note}) {
      _id
      name
      urgent
      checked
      note {
        name
      }
    }
  }
`;
 
exports.handler = async event => {
  
  const { name, urgent, checked, note} = JSON.parse(event.body);
  const { data, errors } = await query(
    ADD_ITEM, { name, urgent, checked, note });
 
  if (errors) {
    return {
      statusCode: 500,
      body: JSON.stringify(errors)
    };
  }
 
  return {
    statusCode: 200,
    body: JSON.stringify({ item: data.createItem })
  };
};
```

이름, 긴급한 경우 확인 값 및 항목이 포함되어야하는 메모와 같은 항목 속성을 전달합니다.
 우체부를 사용하여이 API를 호출하는 방법을 살펴 보겠습니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/11/add_item.png?resize=1461%2C693&ssl=1)

보시다시피 항목을 생성하는 동안 메모의`id `를 전달합니다.
 

이 문서의 나머지 API 기능 (예 : 상점 노트 업데이트, 삭제, 항목 업데이트, 삭제 등)을 작성하지 않겠습니다. 관심이있는 경우 GitHub 저장소에서 해당 기능을 살펴볼 수 있습니다.
 

그러나 나머지 API를 만든 후에는 다음과 같은 디렉토리 구조가 있어야합니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/11/Dir_structure_2.png?resize=453%2C786&ssl=1)

우리는 성공적으로 Fauna를 사용하여 데이터 저장소를 만들고, 사용하도록 설정하고, Netlify 함수를 사용하여 서버리스 함수로 지원되는 API를 만들고 이러한 함수 / 경로를 테스트했습니다.
 

축하합니다. 해냈습니다.
 다음으로 상점 노트를 표시하고 항목을 추가하는 사용자 인터페이스를 구축해 보겠습니다.
 이를 위해 우리는 매우 멋진 React 기반 정적 사이트 생성기 인 Gatsby.js (일명 Gatsby)를 사용할 것입니다.
 

다음 섹션에서는 ReactJS에 대한 기본 지식이 필요합니다.
 처음 사용하는 경우 여기에서 배울 수 있습니다.
 Angular, Vue 등과 같은 다른 사용자 인터페이스 기술에 익숙하다면 다음 섹션을 건너 뛰고 지금까지 설명한 API를 사용하여 직접 빌드하십시오.
 

### Gatsby를 사용하여 사용자 인터페이스 설정
 

시작 프로젝트를 사용하거나 수동으로 초기화하여 Gatsby 프로젝트를 설정할 수 있습니다.
 우리는 그것을 더 잘 이해하기 위해 처음부터 무언가를 만들 것입니다.
 

gatsby-cli를 전역 적으로 설치하십시오.
 

```terminal
npm install -g gatsby-cli
```

개츠비 설치, 반응 및 반응 돔
 

```terminal
yarn add gatsby react react-dom
```

`package.json` 파일의 scripts 섹션을 편집하여`develop`에 대한 스크립트를 추가합니다.
 

```js
"scripts": {
  "develop": "gatsby develop"
 }
```

Gatsby 프로젝트에는`gatsby-config.js`라는 특수 구성 파일이 필요합니다.
 다음 내용으로 프로젝트 폴더의 루트에`gatsby-config.js`라는 파일을 생성하세요.
 

```js
module.exports = {
  // keep it empty    
}
```

Gatsby로 첫 페이지를 만들어 보겠습니다.
 프로젝트 폴더의 루트에`src`라는 이름의 폴더를 만듭니다.
 `src` 아래에`pages`라는 하위 폴더를 만듭니다.
 다음 내용으로`src / pages` 아래에`index.js`라는 파일을 만듭니다.
 

```js
import React, { useEffect, useState } from 'react';    
 
export default () => {    
  const [loading, setLoading ] = useState(false);    
  const [shopnotes, setShopnotes] = useState(null);    
 
  return (
    <>    
      <h1>Shopnotes to load here...</h1>
    </>        
  )    
}

```

실행 해 봅시다.
 일반적으로 앱을 로컬에서 실행하려면 `gatsby`develop 명령을 사용해야합니다.
 netlify 함수를 사용하여 클라이언트 측 애플리케이션을 실행해야하므로`netlify dev` 명령을 계속 사용할 것입니다.
 

```terminal
netlify dev
```

그게 다야.
 `http : // localhost : 8888`에서 페이지에 액세스 해보세요.
 다음과 같은 것이 보일 것입니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/11/initial_screen.png?resize=630%2C250&ssl=1)

Gatsby 프로젝트 빌드는 소스 코드 저장소로 푸시하고 싶지 않을 수있는 두 개의 출력 폴더를 생성합니다.
 원하지 않는 소음이 발생하지 않도록`.gitignore` 파일에 몇 가지 항목을 추가하겠습니다.
 

`.cache`,`node_modules` 및`public`을`.gitignore` 파일에 추가합니다.
 다음은 파일의 전체 내용입니다.
 

```.gitignore
.cache
public
node_modules
*.env
```

이 단계에서 프로젝트 디렉토리 구조는 다음과 일치해야합니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/11/Dir_structure_3.png?resize=405%2C685&ssl=1)

`ShopNote` 사용자 인터페이스를 구현하기 위해 작은 논리적 구성 요소를 만들 것입니다.
 구성 요소는 다음과 같습니다.
 

- 머리글 : 머리글 구성 요소는 로고, 머리글 및 쇼핑 노트를 만들기위한 만들기 버튼으로 구성됩니다.
 
- Shopenotes :이 구성 요소에는 상점 노트 목록 (`Note` 구성 요소)이 포함됩니다.
 
- 참고 : 이것은 개별 참고 사항입니다.
 각 메모에는 하나 이상의 항목이 포함됩니다.
 
- 품목 : 각 품목.
 항목 이름과 항목을 추가, 제거, 편집하기위한 작업으로 구성됩니다.
 

아래 그림에 표시된 섹션을 볼 수 있습니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/11/shopnote_sections.png?resize=1600%2C919&ssl=1)

사용자 인터페이스가 작동하고보기 좋게 보이기 위해 필요한 몇 가지 종속성을 더 설치할 것입니다.
 프로젝트 폴더의 루트에서 명령 프롬프트를 열고 이러한 종속성을 설치하십시오.
 

```terminal
yarn add bootstrap lodash moment react-bootstrap react-feather shortid
```

Reactjs`useEffect` 후크를 사용하여 API를 호출하고 shopnotes 상태 변수를 업데이트합니다.
 다음은 모든 상점 노트를 가져 오는 코드입니다.
 

```js
useEffect(() => {
  axios("/api/get-shopnotes").then(result => {
    if (result.status !== 200) {
      console.error("Error loading shopnotes");
      console.error(result);
      return;
    }
    setShopnotes(result.data.shopnotes);
    setLoading(true);
  });
}, [loading]);
```

마지막으로 반품 섹션을 변경하여 shopnotes 데이터를 사용합니다.
 여기에서 데이터가로드되었는지 확인합니다.
 그렇다면 API를 사용하여받은 데이터를 전달하여`Shopnotes` 구성 요소를 렌더링합니다.
 

```js
return (
  <div className="main">
    <Header />
    {
      loading ? <Shopnotes data = { shopnotes } /> : <h1>Loading...</h1>
    }
  </div>
); 

```

여기에서 전체 index.js 파일 코드를 찾을 수 있습니다.`index.js` 파일은 사용자 인터페이스에 대한 초기 경로 (`/`)를 생성합니다.
 `Shopnotes`, `Note`및 `Item`과 같은 다른 구성 요소를 사용하여 UI가 완전히 작동하도록합니다.
 우리는 이러한 각 UI 구성 요소를 이해하는 데 많은 시간을 할애하지 않을 것입니다.
 `src` 폴더 아래에 components라는 폴더를 만들고 여기에서 구성 요소 파일을 복사 할 수 있습니다.
 

이제 더보기 좋게 만들기 위해 CSS 파일이 필요합니다.
 `pages` 폴더 아래에`index.css`라는 파일을 만듭니다.
 이 CSS 파일의 콘텐츠를`index.css` 파일로 복사합니다.
 

```html
import 'bootstrap/dist/css/bootstrap.min.css';
import './index.css'
```

그게 다야.
 우리는 끝났습니다.
 지금까지 만든 모든 상점 노트를 사용하여 앱을 실행해야합니다.
 여기서는 항목에 대한 각 작업에 대한 설명과 기사를 매우 길게 만들지 않습니다.
 GitHub 리포지토리에서 모든 코드를 찾을 수 있습니다.
 이 단계에서 디렉토리 구조는 다음과 같습니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/11/shopnote_sections-1.png?resize=1600%2C919&ssl=1)

GitHib 리포지토리에 Create Note UI 구현을 포함하지 않았습니다.
 그러나 우리는 이미 API를 만들었습니다.
 Shopnote를 추가하기 위해 프런트 엔드를 구축하는 것은 어떻습니까?
 헤더에 버튼을 구현하는 것이 좋습니다.이 버튼을 클릭하면 이미 정의한 API를 사용하여 Shopnote가 생성됩니다.
 시도 해봐!
 

### 배포하자
 

지금까지 모두 좋습니다.
 그러나 한 가지 문제가 있습니다.
 우리는 로컬에서 앱을 실행하고 있습니다.
 생산적이지만 대중이 액세스하는 것은 이상적이지 않습니다.
 몇 가지 간단한 단계로 문제를 해결하겠습니다.
 

모든 코드 변경 사항을 Git 저장소 (예 : shopnote)에 커밋해야합니다.
 이미 Netlify에 계정이 있습니다.
 로그인 후 Git의 새 사이트 버튼을 클릭하십시오.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/11/deploy_1.png?resize=1162%2C157&ssl=1)

다음으로 프로젝트 소스 코드가 푸시되는 관련 Git 서비스를 선택합니다.
 제 경우에는 GitHub입니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/11/deploy_2.png?resize=1340%2C681&ssl=1)

프로젝트를 찾아 선택하십시오.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/11/deploy_3.png?resize=1254%2C814&ssl=1)

아래 이미지에 표시된대로 빌드 명령, 공개 디렉토리와 같은 구성 세부 사항을 제공하십시오.
 그런 다음 버튼을 클릭하여 고급 구성 정보를 제공하십시오.
 이 경우 .env 파일에서`FAUNA_SERVER_SECRET` 키 값 쌍을 전달합니다.
 각 필드에 붙여 넣기를 복사하십시오.
 배포를 클릭하십시오.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/11/deploy_4.png?resize=1153%2C1042&ssl=1)

몇 분 안에 빌드가 성공하는 것을 볼 수 있으며 사이트는 그 직후에 활성화됩니다.
 

### 요약하자면
 verified_user

요약:
 verified_user

- Jamstack은 클라이언트 측 JavaScript, 재사용 가능한 API 및 사전 빌드 된 마크 업을 기반으로하는 최신 웹 개발 아키텍처입니다.
 
- 한때 사용자 지정 백엔드가 필요했던 기능의 70 % – 80 %는 이제 프런트 엔드에서 수행하거나 활용할 수있는 API, 서비스가 있습니다.
 
- Fauna는 클라이언트-서버리스 애플리케이션을위한 데이터 API를 제공합니다.
 GraphQL 또는 Fauna의 FQL을 사용하여 상점과 대화 할 수 있습니다.
 
- Netlify 서버리스 기능은 GraphQL 변형 및 쿼리를 사용하여 Fauna와 쉽게 통합 할 수 있습니다.
 이 접근 방식은 Netlify 기능과 Auth0과 같은 유연한 솔루션으로 구축 된 사용자 지정 인증이 필요한 경우 유용 할 수 있습니다.
 
- Gatsby 및 기타 정적 사이트 생성기는 빠른 최종 사용자 경험을 제공하기 위해 Jamstack에 큰 기여를합니다.
 

여기까지 읽어 주셔서 감사합니다!
 연결합시다.
 Twitter (@tapasadhikary)에서 @ me에 댓글을 달거나 자유롭게 팔로우 할 수 있습니다.
 