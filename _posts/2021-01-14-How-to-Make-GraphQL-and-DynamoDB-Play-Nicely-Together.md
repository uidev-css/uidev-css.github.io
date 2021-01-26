---
layout: post
title: "GraphQL과 DynamoDB가 함께 잘 작동하도록 만드는 방법"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2021/01/graphql-dynamodb-logo.png
tags: DATABASE,DYNAMODB,GRAPHQL
---


서버리스, GraphQL 및 DynamoDB는 웹 사이트 구축을위한 강력한 조합입니다.
 처음 두 개는 사랑을 받지만 DynamoDB는 종종 오해를 받거나 적극적으로 피합니다.
 "대규모"로만 노력할 가치가 있다고 생각하는 사람들은 종종이를 무시합니다.

그것은 내 가정이기도했고, 서버리스 앱을 위해 SQL 데이터베이스를 고수하려고했습니다.
 하지만 DynamoDB를 배우고 사용한 후에는 모든 규모의 프로젝트에 대한 이점을 확인했습니다.

내가 의미하는 바를 보여 드리기 위해 실제로 진행되는 작업을 숨기는 무거운 ORM (Object Relational Mapper) 또는 GraphQL 프레임 워크없이 처음부터 끝까지 API를 빌드 해 보겠습니다.
 완료되면 DynamoDB를 다시 살펴볼 수 있습니다.
 노력할만한 가치가 있다고 생각합니다.

### DynamoDB 및 GraphQL에 대한 주요 반대

DynamoDB에 대한 주요 이의는 배우기가 어렵다는 것입니다.하지만 그 힘에 대해 논쟁하는 사람은 거의 없습니다.
 학습 곡선이 매우 가파르다는 데 동의합니다.
 그러나 SQL 데이터베이스는 서버리스 애플리케이션에 가장 적합하지 않습니다.
 그 SQL 데이터베이스는 어디에 있습니까?
 그것에 대한 연결을 어떻게 관리합니까?
 이러한 것들은 서버리스 모델과 잘 맞지 않습니다.
 DynamoDB는 설계 상 서버리스 친화적입니다.
 당신은 미래의 고통에서 자신을 구하기 위해 어려운 것을 배우는 선행 고통을 거래하고 있습니다.
 애플리케이션이 성장할 때만 커지는 미래의 고통.

DynamoDB에서 GraphQL을 사용하지 않는 경우는 조금 더 미묘합니다.
 GraphQL은 많은 문서, 자습서 및 예제에서 가정하기 때문에 부분적으로 관계형 데이터베이스와 잘 맞는 것 같습니다.
 Alex Debrie는 DynamoDB 전문가로 깊이 학습 할 수있는 훌륭한 리소스 인 The DynamoDB Book을 작성했습니다.
 심지어 그는 GraphQL 리졸버가 종종 과도한 데이터베이스 읽기를 초래할 수있는 순차적 독립 데이터베이스 호출로 작성되는 방식 때문에 두 가지를 함께 사용하지 말 것을 권장합니다.

또 다른 잠재적 인 문제는 액세스 패턴을 미리 알고있을 때 DynamoDB가 가장 잘 작동한다는 것입니다.
 GraphQL의 강점 중 하나는 REST보다 설계 상 임의의 쿼리를 더 쉽게 처리 할 수 있다는 것입니다.
 이것은 사용자가 임의의 쿼리를 작성할 수있는 공용 API의 문제입니다.
 실제로 GraphQL은 클라이언트와 서버를 모두 제어하는 비공개 API에 자주 사용됩니다.
 이 경우 실행하는 쿼리를 알고 제어 할 수 있습니다.
 GraphQL API를 사용하면 모든 데이터베이스를 방해하는 쿼리를 작성할 수 있습니다.

### 기본 데이터 모델

이 예제 API에서는 팀, 사용자 및 인증으로 조직을 모델링합니다.
 엔터티 관계형 다이어그램은 아래와 같습니다.
 각 팀에는 많은 사용자가 있으며 각 사용자는 많은 인증을 가질 수 있습니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/s_66B809EE0EB7C811A5F52B9A75FEF33524B47A2F34C8FCF96BC3504A179C9E5E_1607051519409_conceptual-erd.png?resize=501%2C41&ssl=1)

### 관계형 데이터베이스 모델

최종 목표는이 데이터를 DynamoDB 테이블에서 모델링하는 것이지만 SQL 데이터베이스에서 모델링했다면 다음 다이어그램과 같습니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/s_66B809EE0EB7C811A5F52B9A75FEF33524B47A2F34C8FCF96BC3504A179C9E5E_1607051560861_physical-erd.png?resize=701%2C131&ssl=1)

인증에 대한 사용자의 다 대다 관계를 나타 내기 위해 "Credential"이라는 중간 테이블을 추가합니다.
 이 테이블의 유일한 속성은 만료 날짜입니다.
 각 테이블에 대해 다른 속성이있을 수 있지만 단순화를 위해 각 테이블의 이름으로 줄입니다.

### 액세스 패턴

DynamoDB 용 데이터 모델 설계의 핵심은 액세스 패턴을 미리 파악하는 것입니다.
 관계형 데이터베이스에서는 정규화 된 데이터로 시작하고 데이터에 대한 조인을 수행하여 액세스합니다.
 DynamoDB에는 조인이 없으므로 액세스하려는 방식과 일치하는 데이터 모델을 구축합니다.
 이것은 반복적 인 프로세스입니다.
 목표는 시작할 가장 빈번한 패턴을 식별하는 것입니다.
 이들 중 대부분은 GraphQL 쿼리에 직접 매핑되지만 일부는 권한을 인증하거나 확인하기 위해 내부적으로 만 백엔드에서 사용할 수 있습니다. 관리자가 일주일에 한 번 확인하는 것과 같이 거의 사용되지 않는 액세스 패턴은
 설계 할 필요가 없습니다.
 매우 비효율적 인 것 (예 : 테이블 스캔)이 이러한 쿼리를 처리 할 수 있습니다.

가장 자주 액세스 :

- 아이디 또는 이름으로 사용자
- ID 또는 이름으로 팀
- ID 또는 이름으로 인증

자주 액세스 :

- 팀 ID 별 팀의 모든 사용자
- 특정 사용자에 대한 모든 인증
- 모든 팀
- 모든 인증

거의 액세스하지 않음

- 팀 사용자의 모든 인증
- 인증을 보유한 모든 사용자
- 팀에 대한 인증이있는 모든 사용자

### DynamoDB 단일 테이블 설계

DynamoDB에는 조인이 없으며 기본 키 또는 사전 정의 된 인덱스를 기준으로 만 쿼리 할 수 있습니다.
 데이터베이스에 의해 부과 된 항목에 대한 집합 스키마가 없으므로 여러 유형의 항목을 단일 테이블에 저장할 수 있습니다.
 실제로 데이터 스키마에 권장되는 모범 사례는 단일 쿼리로 관련 항목에 액세스 할 수 있도록 모든 항목을 단일 테이블에 저장하는 것입니다.
 아래는 데이터를 나타내는 단일 테이블 모델입니다.
 이 스키마를 설계하려면 위의 액세스 패턴을 취하고 일치하는 키 및 색인에 대한 속성을 선택합니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2021/01/s_66B809EE0EB7C811A5F52B9A75FEF33524B47A2F34C8FCF96BC3504A179C9E5E_1608693494018_single-table-fields.png?resize=821%2C321&ssl=1)

여기서 기본 키는 파티션 / 해시 키 (pk)와 정렬 키 (sk)의 조합입니다.
 DynamoDB에서 항목을 검색하려면 파티션 키를 정확히 지정하고 정렬 키에 대해 단일 값 또는 값 범위를 지정해야합니다.
 이렇게하면 파티션 키를 공유하는 경우 둘 이상의 항목을 검색 할 수 있습니다.
 여기서 색인은 gsi1pk, gsi1sk 등으로 표시됩니다. 이러한 일반 속성 이름은 색인 (예 : gsi1pk)에 사용되므로 동일한 색인을 사용하여 다른 액세스 패턴을 가진 다른 유형의 항목에 액세스 할 수 있습니다.
 복합 키를 사용하면 정렬 키를 비워 둘 수 없으므로 정렬 키가 필요하지 않을 때 자리 표시 자로 "#"을 사용합니다.

### 데이터베이스 스키마

우리는 응용 프로그램에서 "데이터베이스 스키마"를 시행합니다.
 DynamoDB API는 강력하지만 장황하고 복잡합니다.
 많은 사람들이 직접 ORM을 사용하여 단순화합니다.
 여기서는 `Team`항목에 대한 스키마를 생성하기 위해 아래의 도우미 함수를 사용하여 데이터베이스에 직접 액세스합니다.

```js
const DB_MAP = {
  TEAM: {
    get: ({ teamId }) => ({
      pk: 'T#'+teamId,
      sk: '#',
    }),
    put: ({ teamId, teamName }) => ({
      pk: 'T#'+teamId,
      sk: '#',
      gsi1pk: 'Team',
      gsi1sk: teamName,
      _tp: 'Team',
      tn: teamName,
    }),
    parse: ({ pk, tn, _tp }) => {
      if (_tp === 'Team') {
        return {
          id: pk.slice(2),
          name: tn,
          };
        } else return null;
        },
    queryByName: ({ teamName }) => ({
      IndexName: 'gsi1pk-gsi1sk-index',
      ExpressionAttributeNames: { '#p': 'gsi1pk', '#s': 'gsi1sk' },
      KeyConditionExpression: '#p = :p AND #s = :s',
      ExpressionAttributeValues: { ':p': 'Team', ':s': teamName },
      ScanIndexForward: true,
    }),
    queryAll: {
      IndexName: 'gsi1pk-gsi1sk-index',
      ExpressionAttributeNames: { '#p': 'gsi1pk' },
      KeyConditionExpression: '#p = :p ',
      ExpressionAttributeValues: { ':p': 'Team' },
      ScanIndexForward: true,
    },
  },
  parseList: (list, type) => {
    if (Array.isArray(list)) {
      return list.map(i => DB_MAP[type].parse(i));
    }
    if (Array.isArray(list.Items)) {
      return list.Items.map(i => DB_MAP[type].parse(i));
    }
  },
};
```

데이터베이스에 새 팀 항목을 넣으려면 다음을 호출하십시오.

```js
DB_MAP.TEAM.put({teamId:"t_01",teamName:"North Team"})
```

이는 데이터베이스 API에 전달되는 색인 및 키 값을 형성합니다.
 `parse` 메소드는 데이터베이스에서 항목을 가져 와서 애플리케이션 모델로 다시 변환합니다.

```graphql
type Team {
  id: ID!
  name: String
  members: [User]
}
type User {
  id: ID!
  name: String
  team: Team
  credentials: [Credential]
}
type Certification {
  id: ID!
  name: String
}
type Credential {
  id: ID!
  user: User
  certification: Certification
  expiration: String
}
type Query {
  team(id: ID!): Team
  teamByName(name: String!): [Team]
  user(id: ID!): User
  userByName(name: String!): [User]
  certification(id: ID!): Certification
  certificationByName(name: String!): [Certification]
  allTeams: [Team]
  allCertifications: [Certification]
  allUsers: [User]
}
```

### 리졸버로 GraphQL과 DynamoDB 간의 격차 해소

해석기는 GraphQL 쿼리가 실행되는 곳입니다.
 리졸버를 작성하지 않고도 GraphQL에서 먼 길을 갈 수 있습니다.
 하지만 API를 구축하려면 몇 가지를 작성해야합니다.
 위 GraphQL 스키마의 각 쿼리에 대해 아래에 루트 확인자가 있습니다 (여기에는 팀 확인 자만 표시됨).
 이 루트 확인자는 쿼리 결과의 일부와 함께 promise 또는 개체를 반환합니다.

쿼리가 결과로 `Team`유형을 반환하면 실행은 `Team`유형 해석기로 전달됩니다.
 이 리졸버에는 `팀`의 각 값에 대한 함수가 있습니다.
 주어진 값 (예 :`id`)에 대한 리졸버가 없으면 루트 리졸버가 이미이를 전달했는지 확인합니다.

쿼리는 4 개의 인수를 사용합니다.
 `루트`또는 `부모`라고하는 첫 번째는 부분 결과와 함께 위의 리졸버에서 전달 된 객체입니다.
 두 번째는`args`라고하며 쿼리에 전달 된 인수를 포함합니다.
 세 번째 `컨텍스트`는 애플리케이션이 쿼리를 해결하는 데 필요한 모든 것을 포함 할 수 있습니다.
 이 경우 데이터베이스에 대한 참조를 `컨텍스트`에 추가합니다.
 `info`라는 마지막 인수는 여기에서 사용되지 않습니다.
 여기에는 추상 구문 트리와 같은 쿼리에 대한 자세한 정보가 포함되어 있습니다.

아래 해석기에서`ctx.db.singletable`은 모든 데이터를 포함하는 DynamoDB 테이블에 대한 참조입니다.
 `get` 및`query` 메소드는 데이터베이스에 대해 직접 실행되며`DB_MAP.TEAM ....`은 앞서 작성한 도우미 함수를 사용하여 스키마를 데이터베이스로 변환합니다.
 `parse` 메소드는 GraphQL 스키마에 필요한 데이터를 다시 변환합니다.

```js
const resolverMap = {
  Query: {
    team: (root, args, ctx, info) => {
      return ctx.db.singletable.get(DB_MAP.TEAM.get({ teamId: args.id }))
        .then(data => DB_MAP.TEAM.parse(data));
    },
    teamByName: (root, args, ctx, info) =>; {
      return ctx.db.singletable
        .query(DB_MAP.TEAM.queryByName({ teamName: args.name }))
        .then(data => DB_MAP.parseList(data, 'TEAM'));
    },
    allTeams: (root, args, ctx, info) => {
      return ctx.db.singletable.query(DB_MAP.TEAM.queryAll)
        .then(data => DB_MAP.parseList(data, 'TEAM'));
    },
  },
  Team: {
    name: (root, _, ctx) => {
      if (root.name) {
        return root.name;
      } else {
        return ctx.db.singletable.get(DB_MAP.TEAM.get({ teamId: root.id }))
          .then(data => DB_MAP.TEAM.parse(data).name);
      }
    },
    members: (root, _, ctx) => {
      return ctx.db.singletable
        .query(DB_MAP.USER.queryByTeamId({ teamId: root.id }))
        .then(data => DB_MAP.parseList(data, 'USER'));
    },
  },
  User: {
    name: (root, _, ctx) => {
      if (root.name) {
        return root.name;
      } else {
        return ctx.db.singletable.get(DB_MAP.USER.get({ userId: root.id }))
          .then(data => DB_MAP.USER.parse(data).name);
      }
    },
    credentials: (root, _, ctx) => {
      return ctx.db.singletable
        .query(DB_MAP.CREDENTIAL.queryByUserId({ userId: root.id }))
        .then(data =>DB_MAP.parseList(data, 'CREDENTIAL'));
    },
  },
};
```

이제 아래 쿼리 실행을 따라 해 보겠습니다.
 먼저`team` 루트 리졸버는`id`로 팀을 읽고`id`와`name`을 반환합니다.
 그런 다음`Team` 유형 해석기가 해당 팀의 모든 구성원을 읽습니다.
 그런 다음 각 사용자가 모든 자격 증명과 인증을 얻기 위해`User` 유형 확인자가 호출됩니다.
 팀에 5 명의 구성원이 있고 각 구성원에 5 개의 자격 증명이있는 경우 데이터베이스에 대해 총 7 회의 읽기가 수행됩니다.
 너무 많다고 주장 할 수 있습니다.
 SQL 데이터베이스에서 이것은 4 개의 데이터베이스 호출로 줄어들 수 있습니다.
 7 개의 DynamoDB 읽기가 많은 경우에 4 개의 SQL 읽기보다 저렴하고 빠르다고 주장합니다.
 그러나 이것은 많은 요인에 따라 많은 양의“의존”을 동반합니다.

```query
query { team( id:"t_01" ){
  id
  name
  members{
    id
    name
    credentials{
      id
      certification{
        id
        name
      }
    }
  }
}}
```

### 오버 페칭과 N + 1 문제

GraphQL API를 최적화하려면 여기서 다루지 않을 많은 장단점을 균형있게 조정해야합니다.
 그러나 DynamoDB와 SQL의 결정에 큰 비중을 차지하는 두 가지는 오버 페칭과 N + 1 문제입니다.
 여러면에서 이들은 같은 동전의 반대편입니다.
 오버 페칭은 리졸버가 쿼리에 응답하는 데 필요한 것보다 더 많은 데이터를 데이터베이스에서 요청하는 경우입니다.
 가능한 한 많은 데이터를 얻기 위해 루트 리졸버 또는 유형 리졸버 (예 : 위의 `팀`유형 리졸버의 멤버)에서 데이터베이스를 한 번 호출하려고 할 때 종종 발생합니다.
 쿼리가`name` 속성을 요청하지 않은 경우 낭비되는 노력으로 보일 수 있습니다.

N + 1 문제는 거의 반대입니다.
 모든 읽기가 최하위 레벨 리졸버로 푸시 다운되면`team` 루트 리졸버와 멤버 리졸버 (`Team` 유형의 경우)는 데이터베이스에 최소한의 요청 만하거나 요청하지 않습니다.
 그들은 단지 ID를`Team` 유형과`User` 유형 리졸버로 전달합니다.
 이 경우 회원이 5 명의 회원을 모두 가져 오기 위해 한 번의 호출을하는 대신 `사용자`로 푸시 다운하여 5 개의 개별 읽기를 수행합니다.
 이로 인해 위 쿼리에 대해 잠재적으로 36 개 이상의 개별 읽기가 발생합니다.
 실제로 이것은 최적화 된 서버가 미들웨어 역할을하는 DataLoader 라이브러리와 같은 것을 사용하여 36 개의 호출을 가로 채서 데이터베이스에 대한 4 개의 호출로 일괄 처리하기 때문에 발생하지 않습니다.
 DataLoader (또는 유사한 도구)가 더 적은 수의 읽기로 효율적으로 일괄 처리 할 수 있도록 이러한 작은 원자 적 읽기 요청이 필요합니다.

따라서 SQL을 사용하여 GraphQL API를 최적화하려면 일반적으로 가장 낮은 수준에 작은 리졸버를두고이를 최적화하기 위해 DataLoader와 같은 것을 사용하는 것이 가장 좋습니다.
 그러나 DynamoDB API의 경우 작성된 단일 테이블 데이터베이스의 액세스 패턴과 더 잘 일치하는 "더 스마트 한"리졸버를 상위에 두는 것이 좋습니다.
 이 경우에 발생하는 오버 페칭은 일반적으로 두 가지 악 중 더 적은 것입니다.

### 60 초 내에이 예제 배포

여기에서 서버리스 GraphQL과 함께 DynamoDB를 사용하여 얻을 수있는 모든 이점을 실현할 수 있습니다.
 이 예제는 Architect로 작성했습니다.
 AWS를 직접 사용하는 데 따르는 골칫거리없이 AWS에서 서버리스 앱을 구축 할 수있는 오픈 소스 도구입니다.
 저장소를 복제하고`npm install`을 실행하면 단일 명령으로 로컬 개발 용 앱 (기본 제공 로컬 버전의 데이터베이스 포함)을 시작할 수 있습니다.
 뿐만 아니라 준비가되면 단일 명령으로 AWS의 프로덕션 인프라 (DynamoDB 포함)에 직접 배포 할 수도 있습니다.