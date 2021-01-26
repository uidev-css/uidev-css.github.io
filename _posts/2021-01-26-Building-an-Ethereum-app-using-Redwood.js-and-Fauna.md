---
layout: post
title: "Redwood.js 및 Fauna를 사용하여 이더 리움 앱 빌드"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2021/01/ETH-redwood-fauna.png
tags: 
---


최근 비트 코인 가격이 2 만 달러 이상으로 상승하고 최근 3 만 달러를 돌파하면서 이더 리움 애플리케이션을 만드는 데 다시 깊이 들어가 볼 가치가 있다고 생각했습니다. 지금까지 알아야 할 이더 리움은 분산 된 합의 및 데이터 처리 네트워크 역할을하는 공개 (의미, 제한없이 모든 사람에게 공개) 블록 체인이며 데이터는 "트랜잭션"( txns). 그러나 Ethereum의 현재 기능은 저장 (가스 요금에 의해 제한됨) 및 처리 (블록 크기 또는 합의에 참여하는 당사자의 크기에 의해 제한됨)를 너무 많은 txns 및 txns / 초로 제한합니다. 이제이 글은 Redwood and Fauna와 함께 구축하는 방법에 대한 글이며“어떻게 […]”에 대한 글이 아니기 때문에 이더 리움이 어떻게 작동하는지, 어떤 제약이 있고 어떤 역할을하는지에 대한 기술적 세부 사항은 더 이상 다루지 않겠습니다. 가지고 있지 않습니다. 대신 독자로서 이미 이더 리움과 이더 리움을 구축하는 방법에 대해 어느 정도 이해하고 있다고 가정합니다.

나는 이더 리움에 대한 사전 경험이없는 새로운 사람들이이 게시물에 걸려 넘어 질 것이라는 것을 깨달았고,이 시청자들에게 어떤 방향을 제시해야 할 것입니다.
 고맙게도이 재 작성 당시 Ethereum은 최근 수많은 리소스와 튜토리얼로 개발자 페이지를 개선했습니다.
 나는 새로운 이민자들에게 그것을 강력히 추천합니다!

비록 Ethereum 앱, Redwood.js 앱 또는 Fauna에 의존하는 앱을 빌드하는 데 익숙한 사람이이 튜토리얼의 내용을 쉽게 따를 수 있도록 진행하면서 관련 세부 정보를 제공 할 것입니다.
 그 길을 벗어나면 뛰어 들자!

### 예선

이 프로젝트는 앱 제작자 중 한 명인 Patrick Gallagher가 팀의 Superfluid 해커 톤 제출을 위해 작성한 블로그 게시물에 잘 설명 된 프로젝트 인 Emanator monorepo의 포크입니다.
 Patrick의 앱은 데이터베이스로 Heroku를 사용했지만 동일한 앱으로 Fauna를 사용하는 방법을 보여 드리겠습니다!

이 프로젝트는 포크이므로 계속하기 전에 MetaMask 브라우저 확장을 다운로드했는지 확인하십시오.

Fauna는 웹 네이티브 GraphQL 인터페이스로, 맞춤형 비즈니스 로직을 지원하고 서버리스 에코 시스템과의 통합을 통해 개발자가 코드를 단순화하고 더 빠르게 제공 할 수 있습니다.
 전 세계적으로 분산 된 기본 스토리지 및 컴퓨팅 패브릭은 최신 보안 인프라를 통해 빠르고 일관 적이며 안정적입니다.
 Fauna는 시작하기 쉽고 관리 할 것이없는 100 % 서버리스 환경을 제공합니다.

Fauna는 또한 우리 데이터베이스의 파티션을 포함하는 전 세계에 위치한 각 서버에 고 가용성 솔루션을 제공하여 데이터베이스 사본 또는 트랜잭션이 생성 된 각 요청과 함께 데이터를 비동기 적으로 복제합니다.

Fauna 사용의 이점은 다음과 같이 요약 할 수 있습니다.

- 거래
- 다중 문서
- 지리적으로 분산

간단히 말해, Fauna는 개발자가 단일 또는 다중 문서 솔루션에 대해 걱정하지 않아도됩니다.
 일관성 문제를 방지하기 위해 시스템을 모델링하는 방법에 대해 개발자에게 부담을주지 않으면 서 일관성있는 데이터를 보장합니다.
 Fauna가이를 수행하는 방법에 대한 개요를 보려면 FaunaDB 분산 트랜잭션 프로토콜에 대한이 블로그 게시물을 참조하십시오.

다음과 같이 Fauna를 사용하는 대신 선택할 수있는 몇 가지 다른 대안이 있습니다.

- 중포 기지
- 카산드라
- MongoDB

그러나 이러한 옵션은 Fauna가 수행하는 ACID 보장을 제공하지 않아 확장 성을 저하시킵니다.
 ACID는 다음을 의미합니다.

- 원 자성 : 모든 트랜잭션은 모두 통과하거나 통과하지 않는 단일 진실 단위입니다.
 동일한 요청에 여러 트랜잭션이있는 경우 둘 다 양호하거나 둘 다 좋지 않은 경우 하나는 실패 할 수없고 다른 하나는 성공합니다.
- 일관성 : 트랜잭션은 하나의 유효한 상태에서 다른 상태로만 데이터베이스를 가져올 수 있습니다. 즉, 데이터베이스에 기록 된 모든 데이터는 데이터베이스가 설정 한 규칙을 따라야합니다. 이렇게하면 모든 트랜잭션이 합법적입니다.
- 격리 : 트랜잭션이 생성되거나 생성 될 때 동시 트랜잭션은 각 요청이 순차적으로 이루어진 경우와 동일하게 데이터베이스 상태를 유지합니다.
- 내구성 : 생성되고 데이터베이스에 커밋 된 모든 트랜잭션은 시스템의 중단 시간이나 오류에 관계없이 데이터베이스에 유지됩니다.

Fauna를 여러 번 사용했기 때문에 Fauna의 데이터베이스를 직접 보증 할 수 있으며, 제가 좋아하는 모든 것 중에서 가장 좋아하는 점은 사용하기가 얼마나 간단하고 쉽다는 것입니다!
 뿐만 아니라 Fauna는 Apollo Client 및 Apollo Server와 같은 GraphQL 및 GraphQL 도구와 쉽게 페어링 할 수 있습니다 !!
 그러나 우리는 Apollo Client와 Apollo Server를 직접 사용하지 않을 것입니다.
 대신 Apollo Client / Server와 함께 사전 패키지로 제공되는 풀 스택 JavaScript / TypeScript (프로덕션 준비가 아님) 서버리스 프레임 워크 인 Redwood.js를 사용할 것입니다!

Redwood.js 사이트와 GitHub 페이지에서 확인할 수 있습니다.

Redwood.js는 목공예에서 나온 새로운 프레임 워크이며 (웃음) Tom Preston-Werner (GitHub 창립자 중 한 명)가 시작했습니다.
 그렇다하더라도 이미 많은 개발 환경 결정을 내린 독보적 인 웹 앱 프레임 워크라는 점에 유의하십시오.
 일부 사람들은이 접근 방식을 좋아하지 않을 수 있지만,이 게시물은 이더 리움 앱을 빌드하는 더 빠른 방법을 제공합니다.

이더 리움 애플리케이션 작업의 과제 중 하나는 블록 확인입니다.
 확인을 차단하는 결과는 txn 확인 (예 : 데이터)이며 확인에는 시간이 걸립니다. 즉, 사용자가 시작한 계산 (UI를 통해 직접 또는 다른 스마트 계약을 통해 간접적으로)까지 기다려야하는 시간 (일반적으로 몇 분)이 고려됨을 의미합니다.
 진실하거나 신뢰할 수 있습니다.
 Superfluid는 현금 흐름 또는 txn 스트림을 도입하여 실시간 금융 애플리케이션을 가능하게함으로써이 문제를 해결하는 것을 목표로하는 프로토콜입니다.
 그건;
 사용자가 더 이상 txn 확인을 기다릴 필요가없고 다음 계산 작업 세트에 대해 즉시 후속 조치를 취할 수있는 앱.

설명서를 읽고 Superfluid에 대해 자세히 알아보십시오.

### Emanator

Patrick의 팀은 정말 멋진 일을했고 Superfluid의 스트리밍 기능을 NFT에 적용하여 사용자가 "NFT를 지속적으로 공급"할 수 있도록했습니다.
 이 NFT 스트림은 경매를 통해 판매 될 수 있습니다.
 emanator 앱의 또 다른 흥미로운 부분은 이러한 NFT가 크리에이터, 아티스트 👩‍🎨 또는 뮤지션 🎼을위한 것입니다.

Superfluid Instant Distribution Agreement (IDA) 사용, 경매 당 수익 분배, 경매 프로세스 및 스마트 계약 자체와 같이이 애플리케이션이 작동하는 방법에 대한 더 많은 기술적 세부 사항이 있습니다.
 그러나 이것은 "방법"이고 "방법은 […]"자습서가 아니므로 자세한 내용을 보려면 원래 Emanator `monorepo`의 README.md에 대한 링크를 남겨 두겠습니다.
 .

마지막으로 코드를 살펴 보겠습니다!

### 설정
verified_user

1.`redwood-eth-with-fauna`에서 저장소를 다운로드합니다.

Git은 터미널, 즐겨 찾는 텍스트 편집기 또는 IDE에서`redwood-eth-with-fauna` 저장소를 복제합니다.
 보다 쉽게인지 할 수 있도록이 자습서에서는 VSCode를 사용하겠습니다.

2. 앱 종속성 설치 및 환경 변수 설정 🔐

저장소를 복제 한 후이 프로젝트의 종속 항목을 설치하려면 다음을 실행하세요.

```bash
yarn
```

… 디렉토리의 루트에 있습니다.
 그런 다음 .env.example 파일에서 .env 파일을 가져와야합니다.
 실행하려면 다음을 수행하십시오.

```bash
cp .env.example .env
```

.env 파일에서 여전히`INFURA_ENDPOINT_KEY`를 제공해야합니다.
 처음에 생각했던 것과는 달리이 변수는 실제로 Infura 앱의 `PROJECT ID`입니다.

Infura 계정이없는 경우 무료로 만들 수 있습니다!
 🆓 🕺

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/euoat3o1uxuwmhwzkdio.png?resize=1600%2C863&ssl=1)

내`redwood-eth-with-fauna` 앱에 대한 Infura 대시 보드의 예제보기입니다.
 `PROJECT ID`를 복사하여`INFURA_ENDPOINT_KEY`와 같이`.env` 파일에 붙여 넣습니다.

3. GraphQL 스키마 업데이트 및 데이터베이스 마이그레이션 실행

에서 찾은 스키마 파일 :

```bash
api/prisma/schema.prisma 
```

… 경매 모델에 필드를 추가해야합니다.
 이것은이 필드가 실제로 monorepo에서 누락 된 코드의 버그 때문입니다.
 따라서 앱이 작동하려면 추가해야합니다!

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/ce4ds58ixgciucu8x30u.png?resize=1600%2C887&ssl=1)

33 행,`String` 유형의`contentHash` 필드를 추가하여 경매를 데이터베이스에 추가 한 다음 사용자에게 표시 할 수 있습니다.

그런 다음 프로젝트 코드의 일부를 자동으로 업데이트하는 Redwood.js 명령을 사용하여 데이터베이스 마이그레이션을 실행해야합니다.
 (이 책임을 우리에게서 추상화하는 데 레드 우드 개발자가 얼마나 관대한지;이 명령은 작동합니다!) 그렇게하려면 다음을 실행하십시오.

```bash
yarn rw db save redwood-eth-with-fauna && yarn rw db up
```

이 프로세스가 성공하면 다음과 같은 내용이 표시됩니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/p9lvx3akjgvb58a7cwk2-1.png?resize=1600%2C746&ssl=1)

이 시점에서 다음을 실행하여 앱을 시작할 수 있습니다.

```bash
yarn rw dev
```

… 그리고 생성 한 다음 첫 번째 NFT를 생성하십시오!
 🎉 🎉

참고 : 새 NFT를 만들 때 다음 오류가 발생할 수 있습니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/td03o3uc0qhp2kdtdw2j.png?resize=1600%2C218&ssl=1)

그렇다면 페이지를 새로 고침하여 오른쪽에 새 NFT를 확인하세요!

새 NFT의 이름을 클릭하여 아래 표시된 것과 같은 경매 세부 정보를 볼 수도 있습니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2021/01/1l8tbptrov68qlj8bqp4-1.png?resize=1508%2C1600&ssl=1)

이 페이지로 이동할 때 Redwood가 API 리졸버를 업데이트한다는 것을 터미널에서 확인할 수도 있습니다.

설정이 끝났습니다!
 안타깝게도 UI의이 부분을 사용하는 방법은 다루지 않겠습니다. 자세한 내용은 Emanator의 `monorepo`를 방문해주세요.

이제 앱에 Fauna를 추가하고 싶습니다.

### 동물 군 추가

Redwood 앱에 Fauna를 추가하기 전에 CTL + C (macOS의 경우)를 눌러 전원을 꺼야합니다.
 Redwood는 핫 리로딩을 처리하고 수정하는 동안 페이지를 자동으로 다시 렌더링합니다. 수정하는 동안 상당히 성 가실 수 있습니다.
 따라서 Fauna 추가를 마칠 때까지 앱을 잠시 중단하겠습니다.

다음으로, Fauna의 대시 보드에서 생성 한 Fauna 데이터베이스의 Fauna 비밀 API 키가 있는지 확인하려고합니다 (그 방법을 살펴 보지는 않겠지 만이 유용한 문서는 잘 설명합니다!).
 키 암호를 복사 한 후`<FAUNA_SECRET_KEY>`를 대체하여`.env` 파일에 붙여 넣으십시오.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-05-at-12.24.52-PM.png?resize=434%2C225&ssl=1)

인용 부호는 제자리에 두십시오!

프로젝트의 GraphQL 스키마를 Fauna로 가져 오려면 먼저 3 개의 개별 스키마를 함께 스키마를 연결해야합니다.이 프로세스는 수동으로 수행 할 것입니다.
 새 파일`api / src / graphql / fauna-schema-to-import.gql`을 만듭니다.
 이 파일에서 다음을 추가합니다.

```gql
type Query {
 bids: [Bid!]!
  auctions: [Auction!]!
 auction(address: String!): Auction
  web3Auction(address: String!): Web3Auction!
 web3User(address: String!, auctionAddress: String!): Web3User!
}
 
# ------ Auction schema ------
type Auction {
 id: Int!
 owner: String!
 address: String!
 name: String!
 winLength: Int!
 description: String
 contentHash: String
 createdAt: String!
 status: String!
 highBid: Int!
 generation: Int!
 revenue: Int!
 bids: [Bid]!
}
 
input CreateAuctionInput {
 address: String!
 name: String!
 owner: String!
 winLength: Int!
 description: String!
 contentHash: String!
 status: String
 highBid: Int
 generation: Int
}
 
# Comment out to bypass Fauna `Import your GraphQL schema' error
# type Mutation {
#   createAuction(input: CreateAuctionInput!): Auction
# }

# ------ Bids ------
type Bid {
 id: Int!
 amount: Int!
 auction: Auction!
 auctionAddress: String!
}
 
 
input CreateBidInput {
 amount: Int!
 auctionAddress: String!
}
 
input UpdateBidInput {
 amount: Int
 auctionAddress: String
}
 
# ------ Web3 ------
type Web3Auction {
 address: String!
 highBidder: String!
 status: String!
 highBid: Int!
 currentGeneration: Int!
 auctionBalance: Int!
 endTime: String!
 lastBidTime: String!
 # Unfortunately, the Fauna GraphQL API does not support custom scalars.
 # So, we'll this field from the app.
 # pastAuctions: JSON!
 revenue: Int!
}
 
type Web3User {
 address: String!
 auctionAddress: String!
 superTokenBalance: String!
 isSubscribed: Boolean!
}
```

이 스키마를 사용하여 이제 Fauna 데이터베이스로 가져올 수 있습니다.

또한 3 개의 별도 스키마 파일 `api / src / graphql / auctions.sdl.js`, `api / src / graphql / bids.sdl.js`및 `api / src`에 필요한 변경을 수행하는 것을 잊지 마십시오.
 / graphql / web3.sdl.js`는 새로운 Fauna GraphQL 스키마에 대응합니다 !!
 이는 앱의 GraphQL 스키마와 Fauna 간의 일관성을 유지하는 데 중요합니다.

심층 분석을 통해이 프로젝트를 시작하고 실행하는 데 필요한 변경 사항을 배우고 싶다면 좋습니다!
 다음 섹션으로 가세요 !!

그렇지 않고 빠르게 시작하고 실행하려는 경우이 섹션이 적합합니다.

이 프로젝트 저장소의 루트 디렉토리에있는`integrating-fauna` 브랜치를 git checkout 할 수 있습니다.
 이를 수행하려면 다음 명령을 실행하십시오.

```bash
git checkout integrating-fauna
```

그런 다음, 온 전성 검사를 위해 yarn을 다시 실행하십시오.

```bash
yarn
```

앱을 시작하려면 다음을 실행할 수 있습니다.

```bash
yarn rw dev
```

이제 프로젝트를 진행하기위한 몇 가지 단계가 더 있습니다!

1.`faunadb` 및`graphql-request` 설치

먼저 Fauna JavaScript 드라이버`faunadb`와`graphql-request`를 설치하겠습니다.
 Fauna를 추가하기 위해 데이터베이스 스크립트 폴더에 대한 주요 수정에이 두 가지를 모두 사용할 것입니다.

설치하려면 다음을 실행하십시오.

```bash
yarn workspace api add faunadb graphql-request
```

2.`api / src / lib / db.js` 및`api / src / functions / graphql.js`를 편집합니다.

이제`api / src / lib / db.js`의`PrismaClient` 인스턴스를 Fauna 인스턴스로 대체합니다.
 파일의 모든 항목을 삭제하고 다음으로 바꿀 수 있습니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-05-at-11.55.00-AM.png?resize=1222%2C958&ssl=1)

그런 다음`api / src / functions / graphql.js` 파일을 다음과 같이 약간 업데이트해야합니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-05-at-11.56.23-AM.png?resize=1144%2C1052&ssl=1)

3.`api / src / lib / fauna-client.js` 생성

이 간단한 파일에서는 다음 단계에서 사용할 두 개의 변수로 Fauna 데이터베이스의 클라이언트 측 인스턴스를 인스턴스화합니다.
 이 파일은 다음과 같이 표시되어야합니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-05-at-12.01.37-PM.png?resize=1144%2C460&ssl=1)

4.`api / src / services / auctions / auctions.js`에서 첫 번째 서비스를 업데이트합니다.

여기 어려운 부분이 있습니다.
 서비스를 실행하려면 모든 Prisma 관련 명령을 방금 만든`fauna-client.js`의 Fauna 클라이언트 인스턴스를 사용하는 명령으로 대체해야합니다.
 이 부분은 처음에는 간단 해 보이지 않지만 깊이 생각하고 생각하면 필요한 모든 변경 사항이 Fauna의 FQL 명령이 작동하는 방식을 이해하는 데 적용됩니다.

FQL (Fauna Query Language)은 Fauna 쿼리를위한 Fauna의 기본 API입니다.
 FQL은 표현 지향적이므로 여러 기능 명령을 연결하는 것처럼 간단하게 사용할 수 있습니다.
 따라서`api / services / auctions / auctions.js`의 첫 번째 변경 사항에 대해 다음을 수행합니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-05-at-12.11.27-PM.png?resize=1176%2C1324&ssl=1)

이것을 조금 나누기 위해 먼저 적절한 프로젝트 파일 경로에서 클라이언트 변수와`db` 인스턴스를 가져옵니다.
 그런 다음 11 행을 제거하고 13 ~ 28 행으로 바꿉니다 (지금은 주석을 무시할 수 있지만 나머지 부분을 정말로보고 싶다면이 프로젝트의`integrating-fauna` 브랜치를 확인할 수 있습니다.)
 완전한 차이점을 보려면 repo).
 여기서 우리가하는 일은 FQL을 사용하여 Fauna 데이터베이스에서 모든 경매 데이터를 가져 오기 위해 Fauna Index의 경매 인덱스를 쿼리하는 것입니다.
 `console.log (auctionsRaw)`를 실행하여이를 테스트 할 수 있습니다.

console.log ()를 실행하면 이전에 18 행이었던 데이터를 업데이트하는 데 필요한 데이터를 얻기 위해 객체 구조화를 수행해야 함을 알 수 있습니다.

```js
const auctions = await auctionsRaw.map(async (auction, i) => {
```

객체를 다루지 만 배열이 필요하므로`const auctionsRaw` 선언을 마친 후 다음 줄에 다음을 추가합니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-05-at-12.40.03-PM.png?resize=930%2C292&ssl=1)

이제 우리는 올바른 데이터 형식을 얻고 있음을 알 수 있습니다.

다음으로`auctionsRaw`의 호출 인스턴스를 새로운`auctionsDataObjects`로 업데이트 해 보겠습니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-05-at-12.42.29-PM.png?resize=1358%2C92&ssl=1)

이 파일을 업데이트 할 때 가장 어려운 부분이 있습니다.
 `auction` 및`createAuction` 함수의 간단한 return 문을 업데이트하려고합니다.
 사실 우리가 만드는 변경 사항은 실제로 매우 유사합니다.
 따라서 다음과 같이 경매 기능을 업데이트 해 보겠습니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-05-at-12.46.38-PM.png?resize=1060%2C462&ssl=1)

다시 말하지만,이 주석은 변경 이전에 있었던 기본 설정 return 명령문을 참고하기위한 것이므로 주석을 무시할 수 있습니다.

이 쿼리는 "경매 컬렉션에서이 주소가있는 특정 경매를 찾습니다"라고 말합니다.

이`createAuctin` 함수를 완료하기위한이 다음 단계는 확실히 해커입니다.
 이 튜토리얼을 만드는 동안 Fauna의 GraphQL API가 사용자 지정 스칼라를 지원하지 않는다는 것을 깨달았습니다 (GraphQL 문서의 제한 사항 섹션에서 자세한 내용을 읽을 수 있습니다).
 이것은 슬프게도 Emanator의 monorepo의 GraphQL 스키마가 즉시 작동하지 않는다는 것을 의미했습니다.
 결국 이로 인해 앱이 경매 생성을 제대로 실행하기 위해 많은 사소한 변경을해야했습니다.
 따라서이 섹션을 자세히 살펴 보는 대신 먼저 차이점을 보여준 다음 변경 목적을 간략하게 요약하겠습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-05-at-12.56.12-PM.png?resize=1163%2C1600&ssl=1)

100과 101의 녹색 선을 보면 여기서 사용하는 기능 명령이 크게 다르지 않다는 것을 알 수 있습니다.
 여기서는 인덱스에서 읽는 대신 경매 컬렉션에 새 문서를 만드는 중입니다.

이`createAuction` 함수의 데이터 필드로 돌아가서 우리는 인수로`input`이 주어 졌음을 알 수 있습니다. 이것은 실제로 홈페이지에서 새로운 NFT 경매 양식의 UI 입력 필드를 참조합니다.
 따라서`input`은`address`,`name`,`owner`,`winLength`,`description`,`contentHash`의 6 개 필드로 구성된 객체입니다.
 그러나 경매 유형에 대한 GraphQL 스키마를 이행하는 데 필요한 다른 4 개의 필드가 아직 누락되었습니다!
 따라서 내가 만든 다른 변수`id`,`dateTime`,`status`,`highBid`는이 함수가 성공적으로 완료 될 수 있도록 다소 하드 코딩 된 변수 I입니다.

마지막으로 `Auction`상수 내보내기를 완료해야합니다.
 이를 위해 Fauna 클라이언트를 다시 한 번 사용하여 다음과 같이 변경합니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-05-at-1.04.46-PM.png?resize=1206%2C676&ssl=1)

그리고 드디어 첫 서비스 🎊, 휴!

지금 쯤이면 GraphQL 서비스 업데이트로 인한 이러한 변경으로 인해 약간 피곤할 수 있습니다 (필요한 변경 사항을 배우는 동안 그랬다는 것을 알고 있습니다!).
 따라서이 앱이 작동하는 시간을 절약하기 위해 전체를 살펴 보는 대신 저장소에서 이미 작업 한`integrating-fauna` 브랜치의 git diff를 다시 공유 할 것입니다.
 공유 후 변경 사항을 요약하겠습니다.

업데이트 할 첫 번째 파일은`api / src / services / bids / bids.js`입니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-05-at-1.09.16-PM.png?resize=1072%2C1600&ssl=1)

그리고 마지막 GraphQL 서비스 업데이트 :

![image](https://lh6.googleusercontent.com/w2LIbwT8mRi4LY7t7DVi3yBB37jgs9JjyWXT6uaJXiAuB1HuQ132EiAe5y9UF-ajd7HpYkrjaYwgh3muT9G8tInm5ZdW_IjxgCEwpfHxbDGeEO_6PwmNhjuKUUoDf6LuL-3Sl0yv)

마지막으로`web / src / components / AuctionCell / AuctionCell.js`의 마지막 변경 사항 :

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-05-at-1.14.30-PM.png?resize=1169%2C1600&ssl=1)

따라서 사용자 지정 스칼라를 지원하지 않는 Fauna로 돌아갑니다.
 Fauna는 커스텀 스칼라를 지원하지 않기 때문에`web3.js` 서비스 쿼리에서`pastAuctions` 필드를 주석 처리해야했습니다 (GraphQL 스키마에서 주석 처리 함).

`web / src / components / AuctionCell / AuctionCell.js`에서 이루어진 마지막 변경은 새로 생성 된 NFT 주소 도메인을 만들기위한 또 다른 해키 변경입니다.
 새 NFT를 만든 후 홈페이지 오른쪽에 있음) 오류없이 클릭 할 수 있습니다.
 😄

### 결론

마지막으로 다음을 실행할 때 :

```bash
yarn rw dev
```

… 새 토큰을 만들면 이제 Fauna를 사용하여 만들 수 있습니다 !!
 🎉🎉🎉🎉

두 가지주의 사항이 있습니다.
 먼저, 생성하고 MetaMask로 거래를 확인한 후 NFT 생성 폼 위에이 성가신 오류 메시지가 나타납니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-05-at-1.31.09-PM.png?resize=1508%2C230&ssl=1)

안타깝게도 페이지 새로 고침 외에는 이에 대한 해결책을 찾을 수 없습니다.
 그래서 우리는 원래 Emanator monorepo 버전에서했던 것처럼 이것을 할 것입니다.

그러나 페이지를 새로 고치면 오른쪽에 새 반짝이는 토큰이 표시됩니다!
 👏

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-05-at-1.50.50-PM.png?resize=1600%2C1430&ssl=1)

그리고 이것은 Fauna에서 가져온 NFT 토큰 데이터입니다!
 🙌 🕺 🙌🙌

두 번째 경고는 `web / src / components / AuctionCell / AuctionCell.js`버그로 인해 새 NFT의 페이지를 렌더링 할 수 없다는 것입니다.

이것은 제가 해결할 수없는 또 다른 문제입니다.
 그러나 여기에서 커뮤니티가 참여할 수 있습니다!
 이 저장소`redwood-eth-with-fauna`는 Emanator 앱의 작동하는 (현재 😅) 버전이있는 (현재) 완성 된`integrating-fauna` 브랜치와 함께 GitHub에서 공개적으로 사용할 수 있습니다.
 따라서이 앱에 정말 관심이 있고이 앱을 Fauna와 함께 활용하는 방법을 알아보고 싶다면 자유롭게 프로젝트를 포크하고 탐색하거나 변경하세요!
 언제든지 GitHub에서 연락을받을 수 있으며 항상 기꺼이 도와 드리겠습니다!
 😊

이것으로이 혀를 완성했습니다. 즐겁게 보내셨기를 바랍니다.
 GitHub에 대한 질문이 있으면 언제든지 문의하십시오!