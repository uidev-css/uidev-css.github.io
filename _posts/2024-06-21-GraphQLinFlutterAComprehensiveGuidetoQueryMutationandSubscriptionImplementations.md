---
title: "2024년 Flutter에서 GraphQL 사용법 쿼리, 뮤테이션, 서브스크립션 구현 완벽 가이드"
description: ""
coverImage: "/assets/img/2024-06-21-GraphQLinFlutterAComprehensiveGuidetoQueryMutationandSubscriptionImplementations_0.png"
date: 2024-06-21 22:20
ogImage: 
  url: /assets/img/2024-06-21-GraphQLinFlutterAComprehensiveGuidetoQueryMutationandSubscriptionImplementations_0.png
tag: Tech
originalTitle: "GraphQL in Flutter: A Comprehensive Guide to Query, Mutation, and Subscription Implementations"
link: "https://medium.com/@ahmedawwan/graphql-in-flutter-a-comprehensive-guide-to-query-mutation-and-subscription-implementations-cb868c07eab7"
---


![이미지](/assets/img/2024-06-21-GraphQLinFlutterAComprehensiveGuidetoQueryMutationandSubscriptionImplementations_0.png)

이 기사는 플러터(Flutter)에서 GraphQL을 마스터하는 데 필수적인 가이드입니다! 기본 개념 이해부터 쿼리(query), 뮤테이션(mutation), 구독(subscription)의 핵심 개념까지 모두 다룹니다. 뿐만 아니라 Flutter 앱에 GraphQL을 원활하게 통합하는 방법을 단계별 지침과 코드 샘플을 제공하면서 안내해드립니다.

# GraphQL이란?

GraphQL을 주문하듯이 생각해보세요. 일반 레스토랑(전통적인 API와 같은)에서는 특정 토핑이 올라간 고정된 피자를 주문합니다. 원하는 거랑 다르면 완전히 새로운 피자를 주문해야 합니다.

<div class="content-ad"></div>

지금은 GraphQL을 사용하면 피자에 원하는 대로 말하는 것과 같아요 — 크러스트, 소스, 토핑 종류를 정확하게 말하는 것과 같아요. 당신을 위해 특별히 만들어진 피자를 받게 되는거죠. 딱 필요한 만큼만요. 데이터에 대한 맞춤 주문처럼 생각해보세요 — 필요한 것을 요청하면 정확히 그것을 받게 되어 매우 효율적이고 요구 사항에 맞게 제작됩니다.

그 외에도, GraphQL은 데이터와 상호 작용하는 방법을 간소화하여 세 가지 주요 작업을 제공합니다: 쿼리, 뮤테이션, 그리고 구독.

- 쿼리: GraphQL에서 쿼리는 특정 데이터를 요청하는 것입니다. 서버에서 정보를 요청하는 것과 같이 특정 데이터와 그 구조를 명시합니다. 당신이 원하는 토핑과 크러스트 유형을 주문하는 것과 같은 거죠.
- 뮤테이션: GraphQL에서 뮤테이션은 데이터 수정을 다루는 작업들입니다. 새 데이터 추가, 기존 레코드 업데이트, 혹은 정보 삭제와 같은 작업을 할 수 있습니다. 피자 비유에서는 셰프에게 선호에 따라 토핑을 추가하거나 제거하도록 지시하는 것과 같아요.
- 구독: 구독은 GraphQL에서 실시간 업데이트를 가능하도록 합니다. 클라이언트(당신)와 서버(셰프) 사이에 지속적인 연결을 설정하여 서버가 가능한 즉시 새 정보를 클라이언트에게 푸시할 수 있게 합니다. 피자 준비 과정을 알려주는 셰프와 같이 데이터 변경 사항에 대한 실시간 알림을 받는 것과 같아요.

그래서, GraphQL은 주문을 맞춤 제작하는 것 이상이에요; 당신이 요구하는 대로 데이터를 조회, 수정하고 최신 상태를 유지할 수 있도록 효율적이고 요구 사항에 정확히 맞게 제작된 방법을 제공하는겁니다.

<div class="content-ad"></div>

# 플러터에서 GraphQL 구현하기

먼저, 다음 패키지를 pubspec.yaml 파일에 추가하고 flutter pub get을 실행하세요:

```js
  graphql_flutter: latest
  graphql: latest
```

이제 다음과 같이 GraphQL 클라이언트를 생성하세요:

<div class="content-ad"></div>

```js
  final HttpLink _httpLink = HttpLink(
    "<YOUR-BASE-URL>",
    defaultHeaders: {
      'Authorization': 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
      'AuthorizationSource': 'API',
    },
  );


  final ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
    link: _httpLink,
    cache: GraphQLCache(),
  ));
```

앱을 GraphQL 위젯을 사용하기위한 GraphQLProvider 상속 위젯으로 감싸세요:

```js
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'App',
        home: HomeScreen(),
      ),
    );
  }
```

그럼 GraphQL API를 소비해봅시다.

<div class="content-ad"></div>

# 쿼리

먼저 쿼리 문서를 정의해보겠습니다.

```js
final getUserQuery = gql(r'''
    query getUser($id: ID) {
      user(id: $id) {
        id
        first_name
        last_name
      }
    }
''');
```

쿼리 정의:

<div class="content-ad"></div>

- query getUser($id: ID): 이 줄은 getUser라는 GraphQL 쿼리의 정의를 시작합니다. $id는 쿼리에 전달할 수 있는 ID 유형의 변수입니다.

쿼리 본문:

- ' user(id: $id) ' ... ' ': 쿼리의 본문은 우리가 원하는 데이터를 지정합니다. 이 경우 주어진 id를 가진 사용자에 대한 정보를 요청하고 있습니다. 요청된 세 가지 필드는 id, first_name 및 last_name입니다.

변수 사용:

<div class="content-ad"></div>

- 쿼리 내에서 $id 변수는 요청을 매개변수화하는 데 사용됩니다. 이는 쿼리가 실행될 때 특정 ID로 동적으로 채워지는 자리 표시자입니다.

## 쿼리 위젯

이제 이 문서를 사용하여 GraphQL API에 요청을 보냅니다.

```js
Query(
  options: QueryOptions(
    document: getUserQuery,
    variables: const {
      "id": "1",
    },
  ),
  builder: (
    QueryResult result, {
    Future<QueryResult> Function(FetchMoreOptions)? fetchMore,
    Future<QueryResult?> Function()? refetch,
  }) {
    if (result.hasException) {
      return const Text("에러");
    }
    if (result.isLoading) {
      return const CircularProgressIndicator();
    }
    final user = result.data?["user"];
    return ListTile(
      title: Text(user["first_name"]),
      subtitle: Text(user["last_name"]),
    );
  },
)
```

<div class="content-ad"></div>

쿼리 위젯:

- 이 문구는 graphql_flutter 패키지에서 제공하는 Query 위젯의 일부분입니다. Query 위젯은 GraphQL 쿼리를 실행하는 데 사용됩니다.

쿼리의 옵션:

- 옵션 매개변수는 GraphQL 쿼리 실행에 필요한 세부 정보를 제공하는 데 사용됩니다.
- 문서: getUserQuery: 실행할 GraphQL 쿼리는 getUserQuery 변수를 사용하여 지정됩니다. 이 변수는 코드의 이전 부분에서 정의된 쿼리입니다.
- 변수: const '"id": "1"': 이는 쿼리에 필요한 변수를 제공합니다. 이 경우 "id" 변수를 "1"로 설정하고 있습니다.

<div class="content-ad"></div>

Builder 함수:

- builder는 GraphQL 쿼리의 결과로 호출되는 콜백 함수입니다.
- QueryResult result: GraphQL 쿼리 실행의 결과를 보유합니다.
- 빌더 안에서:
- result.hasException을 사용하여 예외를 확인합니다. 예외가 발생하면 "Error"를 표시하는 Text 위젯을 반환합니다.
- result.isLoading을 사용하여 쿼리가 여전히 로딩 중인지 확인합니다. true인 경우 CircularProgressIndicator를 반환합니다.
- 쿼리가 성공하고 로딩 중이 아닌 경우, 결과에서 사용자 데이터를 추출하고 ListTile에 표시합니다. ListTile에는 사용자의 성과 이름이 각각 제목과 부제목으로 나타납니다.

## 쿼리 메소드

응답을 그릴 때 더 많은 제어를 위해 GraphQL 클라이언트의 query 메소드를 사용하여 GraphQL API를 소비하는 다른 방법이 있습니다.

<div class="content-ad"></div>


# Mutation

이제 먼저 변이 문서를 정의해 봅시다.

```js
 final updateUserMutation = gql(r'''
    mutation updateUser($id: ID, $first_name: String, $last_name: String) {
    updateUser(
    input: {id: $id, first_name: $first_name, last_name: $last_name,}
      ) {
    user {
      id
      first_name
      last_name
    }
    messages {
      field
      message
    }
  }
}
''');
```

<div class="content-ad"></div>

이제 문서를 사용하여 GraphQL 클라이언트 객체를 사용하여 사용자 데이터를 업데이트해 봅시다.

```js
final result = await client.mutate(
        MutationOptions(
          document: updateUserMutation,
          variables: {
            "id": "1",
            "first_name": "John",
            "last_name": "Doe"
          },
        ),
```

GraphQL Mutation 실행:

- client.mutate: 이것은 GraphQL 클라이언트에서 mutate 메소드를 호출하는 것입니다. 클라이언트 객체는 GraphQL 클라이언트의 인스턴스입니다.

<div class="content-ad"></div>

돌변에 대한 옵션:

- 돌변 옵션은 GraphQL 돌변 실행에 대한 세부 정보를 제공하는 데 사용됩니다.
- 변수: '"id": "1", "first_name": "John", "last_name": "Doe"': 이는 돌변에 필요한 변수를 제공합니다. 사용자의 id와 함께 업데이트할 새로운 이름 및 성 값을 포함합니다.

결과 처리:

- 돌변 작업의 결과는 결과 변수에 저장됩니다.
- 결과의 실제 구조는 사용되는 GraphQL 클라이언트에 따라 다르지만 일반적으로 돌변에 의해 반환된 데이터, 오류 및 추가 메타데이터와 같은 정보를 포함합니다.

<div class="content-ad"></div>

# 구독

먼저 웹소켓을 위한 graphQL 클라이언트를 만들겠습니다.

```js
final WebSocketLink websocketLink = WebSocketLink(
    url: '<YOUR-GRAPHQL-SUBSCRIPTION-ENDPOINT>',
    config: SocketClientConfig(
    autoReconnect: true,
    inactivityTimeout: Duration(seconds: 30),
  ),
);

websocketClient = GraphQLClient(
  link: websocketLink,
  cache: GraphQLCache(),
);
```

웹소켓 링크 설정:

<div class="content-ad"></div>

- WebSocketLink은 GraphQL 구독용 WebSocket 전송의 구현체입니다. 지정된 GraphQL 서버 엔드포인트로 WebSocket 연결을 설정합니다.
- URL: `YOUR-GRAPHQL-SUBSCRIPTION-ENDPOINT`: 실제 웹소켓 엔드포인트로 대체합니다. 이는 GraphQL 서버에서 제공하는 실제 웹소켓 엔드포인트로 구독을 처리합니다. 이 URL은 일반적으로 ws:// 또는 wss://로 시작합니다.
- config: SocketClientConfig(...): WebSocket 연결에 대한 구성 옵션을 제공합니다.
- autoReconnect: true: 연결이 끊긴 경우 자동 재연결을 활성화합니다.
- inactivityTimeout: Duration(seconds: 30): 활동이 없거나 해당 시간 내에 통신이 발생하지 않을 경우 웹소켓 연결을 닫기 위한 타임아웃 기간을 설정합니다.

GraphQLClient 설정:

- GraphQLClient는 구독을 위한 통신 링크로 WebSocketLink를 사용하여 인스턴스화됩니다. 또한 캐싱을 위해 GraphQLCache를 사용합니다.
- link: websocketLink: GraphQL 클라이언트의 통신 링크로 WebSocketLink를 지정합니다. 이는 구독이 WebSocket 연결을 통해 처리되도록 합니다.
- cache: GraphQLCache(): GraphQL 클라이언트의 로컬 상태 및 쿼리 결과를 저장하고 관리하기 위한 캐시를 초기화합니다.

이제 GraphQL 구독 문서를 작성해 봅시다.

<div class="content-ad"></div>

```javascript
  static final userUpdatedMutation = gql(r'''
subscription userUpdatedSubscription($id: String) {
        userUpdatedSubscription(id: $id) {
            ...UserFragment
        }
    }
    fragment UserFragment on User {
        id
        first_name
        last_name
    }
    ''');
```

GraphQL Subscription:

- userUpdatedMutation은 사용자가 업데이트될 때 업데이트를 청취하는 GraphQL 구독(subscription)입니다. 사용자관련 정보를 관심 있는 사용자로 지정하기 위해 String 타입의 $id 매개변수를 가져옵니다.
- subscription userUpdatedSubscription($id: String): id 변수를 허용하는 userUpdatedSubscription이라는 이름의 구독을 선언합니다.
- userUpdatedSubscription(id: $id): 이 구독은 지정된 id를 가진 사용자에 대한 업데이트에 관심이 있다는 것을 나타냅니다.
- ' ...UserFragment ': 이 구독에는 fragment spread, ...UserFragment가 포함되어 있어서 UserFragment에서 지정된 필드를 수신하려는 것을 나타냅니다.

GraphQL Fragment:

<div class="content-ad"></div>

- GraphQL 프래그먼트 (UserFragment)는 여러 쿼리, 뮤테이션 또는 구독에서 사용할 수 있는 재사용 가능한 필드 세트를 정의합니다.
- UserFragment on User ' ... '의 프래그먼트는 User 유형에서 UserFragment라는 이름의 프래그먼트를 선언합니다.
- 이 프래그먼트에는 id, first_name, last_name과 같은 필드가 포함되어 있습니다. ...UserFragment 스프레드를 포함하는 모든 작업은 이러한 필드를 자동으로 포함합니다.
- 프래그먼트는 필드 정의의 중복을 피하고 코드 재사용성을 촉진하는 데 도움이 됩니다. 여러 작업이 공통 필드를 공유할 때 특히 유용합니다.

이제 이 구독을 들어보겠습니다

```js
void _subscribe() async {
  final subscription = await websocketClient.subscribe(
    SubscriptionOptions(
      document: userUpdatedMutation,
    ),
  );

  subscription.listen((result) {
    final userData = result.data?['user'];
    print('이름: ${userData["first_name"]}');
    print('성: ${userData["last_name"]}');
    // 실시간 업데이트 처리, 예를 들어 UI 업데이트
  });
}
```

Subscription Widget도 사용할 수 있습니다.

<div class="content-ad"></div>

```js
body: Subscription(
        options: SubscriptionOptions(
        document: userUpdatedMutation,
        ),
        builder: (result) {
          final user = result.data?["user"];
          return ListTile(
            title: Text(user["first_name"]),
            subtitle: Text(user["last_name"]),
          );
        },
      ),
```

# 결론

이 가이드를 통해 플러터에서 GraphQL 구현에 대한 포괄적인 이해를 제공했습니다. 쿼리, 뮤테이션 및 구독의 기본 사항부터 실제 통합 단계에 이르기까지의 내용이 담겨 있습니다. 실시간 업데이트를 통한 GraphQL 구독에 중점을 두고 뮤테이션 작업을 시연함으로써, 개발자들은 이제 플러터 프로젝트에 GraphQL을 원활하게 통합할 수 있습니다. 이 포괄적인 리소스는 모든 수준의 개발자가 데이터 검색을 최적화하고 앱의 효율성을 향상시키며, 플러터에서 GraphQL의 강력함을 통해 동적 사용자 경험을 제공할 수 있는 기술을 제공합니다.