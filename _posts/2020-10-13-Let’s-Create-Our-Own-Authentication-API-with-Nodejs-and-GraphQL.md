---
layout: post
title: "Nodejs 및 Graph를 사용하여 자체 인증 API 생성QL"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/10/auth-lock-website.png
tags: APOLLO,AUTHENTICATION,GRAPHQL,NODE
---


인증은 GraphQL로 시작하는 개발자에게 가장 어려운 작업 중 하나입니다. 설정하기 쉬운 ORM, 보안 토큰 및 해시 암호 생성 방법, 심지어는 사용할 HTTP 라이브러리와 사용 방법 등 기술적인 고려사항이 많다.

이 기사에서는 로컬 인증에 중점을 두겠습니다. 이것은 아마도 현대 웹 사이트에서 인증을 처리하는 가장 일반적인 방법일 것이며 사용자의 전자 메일 및 암호를 요청하여 그렇게 할 것입니다(예: Google auth 사용).

또한, 이 문서는 아폴로 서버 2, JWT(JSON Web Token) 및 Supecialize ORM을 사용하여 노드를 포함한 인증 API를 구축한다.

### 인증 처리

에서와 같이 로그인 시스템:

- 인증은 사용자를 식별하거나 확인합니다.
- 권한 부여는 인증된 사용자가 액세스할 수 있는 경로(또는 앱의 일부)를 검증하는 중입니다.

이를 구현하기 위한 흐름은 다음과 같습니다.

- 사용자가 암호 및 전자 메일을 사용하여 등록합니다.
- 사용자의 자격 증명이 데이터베이스에 저장됩니다.
- 등록이 완료되면 사용자가 로그인으로 리디렉션됩니다.
- 인증되면 사용자에게 특정 리소스에 대한 액세스 권한이 부여됩니다.
- 사용자의 상태는 브라우저 저장 매체(예: `localStorage`, 쿠키, 세션) 또는 JWT에 저장됩니다.

### 전제조건

구현에 착수하기 전에 몇 가지 사항을 따라야 합니다.

- 노드 6 이상
- 실(권장) 또는 NPM
- 그래프QL 놀이터
- 그래프QL 및 노드의 기본 지식
- …궁금한 마음씨!

### 종속성

이 목록은 매우 크므로, 자세히 살펴보도록 하겠습니다.

- 아폴로 서버: 모든 종류의 GraphQL 클라이언트와 호환되는 오픈 소스 GraphQL 서버. 이 프로젝트에서는 서버에 Express를 사용하지 않습니다. 대신, 우리는 우리의 그래프QL API를 노출시키기 위해 아폴로 서버의 힘을 사용할 것입니다.
- bcryptjs: 데이터베이스에서 사용자 암호를 해시하고 싶습니다. 그래서 우리는 bcrypt를 사용할 것이다. 안전한 난수를 얻기 위해 Web Crypto API의 getRandomValues 인터페이스에 의존한다.
- dotenv: dotenv를 사용하여 `.env` 파일에서 환경 변수를 로드합니다.
- json 웹 토큰: 사용자가 로그인하면 이후의 각 요청에는 JWT가 포함되므로 사용자는 해당 토큰으로 허용된 경로, 서비스 및 리소스에 액세스할 수 있습니다. json webtoken은 사용자 인증에 사용될 JWT를 생성하는 데 사용됩니다.
- 노데몬: 디렉터리의 변경 사항이 감지되면 노드 응용 프로그램을 자동으로 재시작하여 노드 기반 응용 프로그램을 개발하는 데 도움이 되는 도구입니다. 코드가 변경될 때마다 서버를 닫고 시작하고 싶지 않습니다. Nodemon은 앱에서 매번 변경 사항을 검사하고 서버를 자동으로 다시 시작합니다.
- mysql2: 노드의 SQL 클라이언트입니다. 마이그레이션을 실행하려면 SQL 서버에 연결해야 합니다.
- 속편을 만들다: Secretize는 Postgres, MySQL, MariaDB, SQLite 및 Microsoft SQL Server를 위한 약속 기반 노드 ORM이다. Sequipalize를 사용하여 마이그레이션 및 모델을 자동으로 생성합니다.
- cli를 속편화하다. Secretize CLI를 사용하여 Secretize 명령을 실행합니다. 터미널에 yarn add --global supperize-cli를 사용하여 전세계에 설치합니다.

### 디렉토리 구조 및 개발 환경 설정

새로운 프로젝트를 만들어 봅시다. 새 폴더와 폴더 내부에 이 폴더를 만듭니다.

```terminal
yarn init -y
```

`-y` 플래그는 모든 `yarn init` 질문에 대해 `예스`를 선택하고 기본값을 사용하고 있음을 나타냅니다.

우리는 또한 `패키지`를 넣어야 한다.폴더에 있는 json` 파일이므로 프로젝트 종속성을 설치하겠습니다.

```terminal
yarn add apollo-server bcrpytjs dotenv jsonwebtoken nodemon sequelize sqlite3
```

다음으로 Bab을 개발 환경에 추가해 보겠습니다.

```terminal
yarn add babel-cli babel-preset-env babel-preset-stage-0 --dev
```

이제 Babel을 구성하겠습니다. 터미널에서 .babelrc를 터치합니다. 이렇게 하면 Babel 구성 파일이 생성되고 열립니다. 그러면 이 파일이 추가됩니다.

```.babelrc
{
  "presets": ["env", "stage-0"]
}
```

저희 서버도 시작하고 데이터도 마이그레이션하면 좋을 것 같습니다. 우리는 `패키지`를 업데이트함으로써 그것을 자동화할 수 있다.json with this:

```package.json
"scripts": {
  "migrate": " sequelize db:migrate",
  "dev": "nodemon src/server --exec babel-node -e js",
  "start": "node src/server",
  "test": "echo \"Error: no test specified\" && exit 1"
},
```

여기 우리의 소포가 있다.json 파일 전체:

```package.json
{
  "name": "graphql-auth",
  "version": "1.0.0",
  "main": "index.js",
  "scripts": {
    "migrate": " sequelize db:migrate",
    "dev": "nodemon src/server --exec babel-node -e js",
    "start": "node src/server",
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "dependencies": {
    "apollo-server": "^2.17.0",
    "bcryptjs": "^2.4.3",
    "dotenv": "^8.2.0",
    "jsonwebtoken": "^8.5.1",
    "nodemon": "^2.0.4",
    "sequelize": "^6.3.5",
    "sqlite3": "^5.0.0"
  },
  "devDependencies": {
    "babel-cli": "^6.26.0",
    "babel-preset-env": "^1.7.0",
    "babel-preset-stage-0": "^6.24.1"
  }
}
```

이제 우리의 개발 환경, 상황을 저장할 데이터베이스를 생각해 봅시다 설치되어 있다.

## 데이터베이스 설정

우리는 MySQL을 데이터베이스로 사용하고 우리의 관계를 위해 Supecialize ORM을 사용할 것이다. 이전에 전역으로 설치했다고 가정할 때 속편화를 실행합니다. 명령어는 `/config` `/models` 및 `/migration`의 세 가지 폴더를 생성해야 합니다. 이 시점에서, 우리의 프로젝트 디렉토리 구조는 형성되고 있다.

데이터베이스를 구성하겠습니다. 먼저 프로젝트 루트 디렉터리에 `.env` 파일을 생성하고 다음을 붙여넣으십시오.

```.env
NODE_ENV=development
DB_HOST=localhost
DB_USERNAME=
DB_PASSWORD=
DB_NAME=
```

그런 다음 방금 만든 `/config` 폴더로 이동하여 해당 파일의 이름을 `config.js`로 변경합니다. 그런 다음 이 코드를 여기에 넣습니다.

```js
require('dotenv').config()
const dbDetails = {
  username: process.env.DB_USERNAME,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  host: process.env.DB_HOST,
  dialect: 'mysql'
}
module.exports = {
  development: dbDetails,
  production: dbDetails
}
```

여기서는 `.env` 파일에 설정된 데이터베이스 세부 정보를 읽고 있습니다. process.env는 노드가 주입한 글로벌 변수이며 시스템 환경의 현재 상태를 나타내는 데 사용됩니다.

데이터베이스 세부 정보를 적절한 데이터로 업데이트하겠습니다. SQL 데이터베이스를 열고 `graphql_auth`라는 테이블을 생성합니다. Laragon을 로컬 서버로 사용하고 pphmyadmin을 사용하여 데이터베이스 테이블을 관리합니다.

어떤 것을 사용하든 `.env` 파일을 최신 정보로 업데이트하고자 합니다.

```.env
NODE_ENV=development
DB_HOST=localhost
DB_USERNAME=graphql_auth
DB_PASSWORD=
DB_NAME=<your_db_username_here>
```

Supecialize를 구성하겠습니다. 프로젝트의 루트에 `.sequelizer` 파일을 생성하고 다음을 붙여넣으십시오.

```js
const path = require('path')
 
module.exports = {
  config: path.resolve('config', 'config.js')
}
```

이제 구성을 모델에 통합해 보겠습니다. /models 폴더의 `index.js`로 이동하고 `config` 변수를 편집합니다.

```js
const config = require(__dirname + '/../../config/config.js')[env]
```

마지막으로, 우리 모델을 쓰자. 이 프로젝트를 위해서는 사용자 모델이 필요합니다. Supecialize를 사용하여 모델을 자동으로 생성해 보겠습니다. 터미널에서 이를 설정하기 위해 실행해야 할 사항은 다음과 같습니다.

```terminal
sequelize model:generate --name User --attributes username:string,email:string,password:string
```

우리를 위해 만들어진 모델을 편집해 봅시다. /models 폴더의 `user.js`로 이동하여 다음을 붙여넣으십시오.

```js
'use strict';
module.exports = (sequelize, DataTypes) => {
  const User = sequelize.define('User', {
    username: {
      type: DataTypes.STRING,
    },
    email: {
      type: DataTypes.STRING,  
    },
    password: {
      type: DataTypes.STRING,
    }
  }, {});
  return User;
};
```

여기서는 사용자 이름, 전자 메일 및 암호에 대한 특성 및 필드를 만들었습니다. 스키마의 변경 사항을 추적하기 위해 마이그레이션을 실행합니다.

```terminal
yarn migrate
```

이제 스키마와 해결사를 작성하겠습니다.

### 스키마 및 해결사를 GraphQL 서버와 통합

이 섹션에서는 스키마를 정의하고 해결 프로그램 기능을 작성하여 서버에 표시합니다.

src 폴더에서 `/schema`라는 새 폴더를 만들고 `schema.js`라는 파일을 만듭니다. 다음 코드에 붙여넣습니다.

```js
const { gql } = require('apollo-server')
const typeDefs = gql`
  type User {
    id: Int!
    username: String
    email: String!
  }
  type AuthPayload {
    token: String!
    user: User!
  }
  type Query {
    user(id: Int!): User
    allUsers: [User!]!
    me: User
  }
  type Mutation {
    registerUser(username: String, email: String!, password: String!): AuthPayload!
    login (email: String!, password: String!): AuthPayload!
  }
`
module.exports = typeDefs
```

아폴로 서버에서 그래프ql-태그를 가져왔습니다. 아폴로 서버는 우리 스키마를 `gql`로 포장해야 한다.

`src` 폴더에서 `/resolvers`라는 새 폴더를 만들고 `resolver.js`라는 파일을 만듭니다. 다음 코드에 붙여넣습니다.

```js
const bcrypt = require('bcryptjs')
const jsonwebtoken = require('jsonwebtoken')
const models = require('../models')
require('dotenv').config()
const resolvers = {
    Query: {
      async me(_, args, { user }) {
        if(!user) throw new Error('You are not authenticated')
        return await models.User.findByPk(user.id)
      },
      async user(root, { id }, { user }) {
        try {
          if(!user) throw new Error('You are not authenticated!')
          return models.User.findByPk(id)
        } catch (error) {
          throw new Error(error.message)
        }
      },
      async allUsers(root, args, { user }) {
        try {
          if (!user) throw new Error('You are not authenticated!')
          return models.User.findAll()
        } catch (error) {
          throw new Error(error.message)
        }
      }
    },
    Mutation: {
      async registerUser(root, { username, email, password }) {
        try {
          const user = await models.User.create({
            username,
            email,
            password: await bcrypt.hash(password, 10)
          })
          const token = jsonwebtoken.sign(
            { id: user.id, email: user.email},
            process.env.JWT_SECRET,
            { expiresIn: '1y' }
          )
          return {
            token, id: user.id, username: user.username, email: user.email, message: "Authentication succesfull"
          }
        } catch (error) {
          throw new Error(error.message)
        }
      },
      async login(_, { email, password }) {
        try {
          const user = await models.User.findOne({ where: { email })
          if (!user) {
            throw new Error('No user with that email')
          }
          const isValid = await bcrypt.compare(password, user.password)
          if (!isValid) {
            throw new Error('Incorrect password')
          }
          // return jwt
          const token = jsonwebtoken.sign(
            { id: user.id, email: user.email},
            process.env.JWT_SECRET,
            { expiresIn: '1d'}
          )
          return {
           token, user
          }
      } catch (error) {
        throw new Error(error.message)
      }
    }
  },
 
}
module.exports = resolvers
```

코드가 너무 많으니까 거기서 무슨 일이 일어나는지 봅시다.

먼저 bcrypt와 json웹토큰 모델을 수입한 뒤 환경변수를 초기화했다.

다음은 해결사 기능입니다. 쿼리 해결 방법에는 세 가지 기능(me, 사용자 및 모든 사용자)이 있습니다.

- `me` 쿼리는 현재 `contract`의 세부 정보를 가져옵니다.사용자 내. 사용자 개체를 컨텍스트 인수로 받아들입니다. 컨텍스트는 쿼리의 인수로 제공된 ID로 사용자의 데이터를 로드하는 데 사용되는 데이터베이스에 대한 액세스를 제공하는 데 사용됩니다.
- `user` 쿼리는 ID를 기준으로 사용자의 세부 정보를 가져옵니다. id를 컨텍스트 인수로, user 객체로 받아들인다.
- `all user` 쿼리는 모든 사용자의 세부 정보를 반환합니다.

사용자 상태가 `contract`인 경우 `user`는 개체가 됩니다.In과 사용자가 아니라면 Null이 됩니다. 우리는 돌연변이로 이 사용자를 만들 것입니다.

돌연변이 해결사에는 두 가지 기능(`registerUser`와 `loginUser`)이 있습니다.

- registerUser는 user의 username, e-메일, password를 받아들여 이 필드를 포함한 새 행을 데이터베이스에 만듭니다. bcryptjs 패키지를 사용하여 사용자 암호를 `bcrypt.hash(암호, 10)`로 해시했습니다. json webtoken.sign은 지정된 페이로드를 JSON 웹 토큰 문자열(이 경우 사용자 id 및 e-메일)에 동기적으로 서명합니다. 마지막으로, `registerUser`는 성공하면 JWT 문자열과 사용자 프로파일을 반환하고 문제가 발생하면 오류 메시지를 반환합니다.
- e-메일, 패스워드를 받아들인 뒤 제공된 e-메일, 패스워드와 e-메일, 패스워드가 일치하는지 확인한다. 먼저, 사용자 데이터베이스의 어딘가에 `e-mail` 값이 이미 존재하는지 확인합니다.

```js
models.User.findOne({ where: { email })
if (!user) {
  throw new Error('No user with that email')
}
```

그런 다음 bcrypt의 bcrypt.compare 방법을 사용하여 암호가 일치하는지 확인합니다.

```js
const isValid = await bcrypt.compare(password, user.password)
if (!isValid) {
  throw new Error('Incorrect password')
}
```

그런 다음 이전에 register User에서 했던 것처럼 json webtoken.sign을 사용하여 JWT 문자열을 생성합니다. 로그인 돌연변이는 토큰과 사용자 개체를 반환합니다.

이제 `JWT_SECRET`를 `.env` 파일에 추가해 보겠습니다.

```.env
JWT_SECRET=somereallylongsecret
```

드디어 서버다! 프로젝트의 루트 폴더에 `server.js`를 생성하고 다음을 붙여넣으십시오.

```js
const { ApolloServer } = require('apollo-server')
const jwt =  require('jsonwebtoken')
const typeDefs = require('./schema/schema')
const resolvers = require('./resolvers/resolvers')
require('dotenv').config()
const { JWT_SECRET, PORT } = process.env
const getUser = token => {
  try {
    if (token) {
      return jwt.verify(token, JWT_SECRET)
    }
    return null
  } catch (error) {
    return null
  }
}
const server = new ApolloServer({
  typeDefs,
  resolvers,
  context: ({ req }) => {
    const token = req.get('Authorization') || ''
    return { user: getUser(token.replace('Bearer', ''))}
  },
  introspection: true,
  playground: true
})
server.listen({ port: process.env.PORT || 4000 }).then(({ url }) => {
  console.log(`🚀 Server ready at ${url}`);
});
```

여기서는 스키마, 해결사 및 jwt를 가져오고 환경 변수를 초기화합니다. 먼저 `확인`을 사용하여 JWT 토큰을 검증한다. jwt.verify는 토큰과 JWT 암호를 매개 변수로 받아들입니다.

다음으로, 우리는 typeDefs와 resolvers를 받아들이는 `ApoloServer` 인스턴스로 우리의 서버를 만든다.

서버가 있습니다! 먼저 터미널에서 yarn dev를 실행하는 것으로 시작하겠습니다.

### API 테스트

이제 GraphQL 플레이그라운드를 사용하여 GraphQL API를 테스트해 보겠습니다. 단일 사용자를 포함한 모든 사용자를 ID별로 등록, 로그인 및 볼 수 있어야 합니다.

먼저 GraphQL Playground 앱을 열거나 브라우저에서 `localhost://4000`을 열기만 하면 액세스할 수 있습니다.

```js
mutation {
  registerUser(username: "Wizzy", email: "ekpot@gmail.com", password: "wizzyekpot" ){
    token
  }
}
```

우리는 이런 것을 얻어야 한다.

```js
{
  "data": {
    "registerUser": {
      "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTUsImVtYWlsIjoiZWtwb3RAZ21haWwuY29tIiwiaWF0IjoxNTk5MjQwMzAwLCJleHAiOjE2MzA3OTc5MDB9.gmeynGR9Zwng8cIJR75Qrob9bovnRQT242n6vfBt5PY"
    }
  }
}
```

이제 방금 만든 사용자 세부 정보로 로그인하겠습니다.

```js
mutation {
  login(email:"ekpot@gmail.com" password:"wizzyekpot"){
    token
  }
}
```

우리는 이런 것을 얻어야 한다.

```js
{
  "data": {
    "login": {
      "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTUsImVtYWlsIjoiZWtwb3RAZ21haWwuY29tIiwiaWF0IjoxNTk5MjQwMzcwLCJleHAiOjE1OTkzMjY3NzB9.PDiBKyq58nWxlgTOQYzbtKJ-HkzxemVppLA5nBdm4nc"
    }
  }
}
```

대단해!

단일 사용자를 쿼리하려면 사용자 토큰을 권한 부여 헤더로 전달해야 합니다. HTTP 헤더 탭으로 이동합니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/10/graphql-playground-httpheaders.png?resize=2468%2C1760&ssl=1)

…붙여넣기:

```js
{
  "Authorization": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTUsImVtYWlsIjoiZWtwb3RAZ21haWwuY29tIiwiaWF0IjoxNTk5MjQwMzcwLCJleHAiOjE1OTkzMjY3NzB9.PDiBKyq58nWxlgTOQYzbtKJ-HkzxemVppLA5nBdm4nc"
}
```

질문은 다음과 같습니다.

```js
query myself{
  me {
    id
    email
    username
  }
}
```

우리는 이와 같은 것을 얻어야 합니다.

```js
{
  "data": {
    "me": {
      "id": 15,
      "email": "ekpot@gmail.com",
      "username": "Wizzy"
    }
  }
}
```

좋습니다! 이제 ID로 사용자를 구하겠습니다.

```js
query singleUser{
  user(id:15){
    id
    email
    username
  }
}
```

모든 사용자를 위한 쿼리는 다음과 같습니다.

```js
{
  allUsers{
    id
    username
    email
  }
}
```

### 요약

인증은 인증확인을 필요로 하는 웹 사이트를 구축할 때 가장 어려운 작업 중 하나입니다. GraphQL을 통해 엔드포인트 하나로 전체 Authentication API를 구축할 수 있었습니다. 후속 ORM을 사용하면 SQL 데이터베이스와의 관계를 쉽게 만들 수 있어 모델에 대한 걱정을 거의 하지 않아도 되었습니다. 또한 Express와 같은 HTTP 서버 라이브러리가 필요하지 않았고 미들웨어로 Apollo GraphQL을 사용했다는 점도 주목할 만하다. 아폴로 서버 2는 이제 라이브러리 독립 GraphQL 서버를 만들 수 있게 되었습니다!

GitHub에서 이 튜토리얼의 소스 코드를 확인하십시오.