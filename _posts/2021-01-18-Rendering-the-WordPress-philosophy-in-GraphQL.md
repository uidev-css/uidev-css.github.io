---
layout: post
title: "GraphQL에서 WordPress 철학 렌더링"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/12/wordpress-graphql.jpg
tags: GRAPHQL,HEADLESS CMS,WORDPRESS,WORDPRESS BLOCKS,WORDPRESS PLUGINS
---


WordPress는 PHP로 코딩 된 CMS입니다.
 그러나 PHP가 기반 임에도 불구하고 WordPress는 개발자 편의보다 사용자 요구를 우선시하는 철학을 가지고 있습니다.
 이 철학은 WordPress 테마 및 플러그인을 구축하는 개발자와 WordPress 사이트를 관리하는 사용자 간의 암시 적 계약을 설정합니다.

GraphQL은 서버에서 데이터를 검색하고 서버로 데이터를 제출할 수있는 인터페이스입니다.
 GraphQL 서버는 GraphQL 사양을 구현하는 방식에있어 특정 동작의 우선 순위를 다른 것보다 우선시 할 수 있습니다.

서버 측 아키텍처에 의존하는 WordPress 철학이 API를 통해 데이터를 전달하는 JavaScript 기반 쿼리 언어와 공존 할 수 있습니까?

이 질문을 따로 골라서 제가 작성한 GraphQL API WordPress 플러그인이 두 아키텍처 사이의 다리를 어떻게 설정하는지 설명하겠습니다.

WPGraphQL을 알고있을 수 있습니다.
 WordPress 용 플러그인 GraphQL API (또는 지금부터 "GraphQL API")는 다양한 기능을 가진 WordPress 용 다른 GraphQL 서버입니다.

### GraphQL 서비스 내에서 WordPress 철학 조정

이 표에는 WordPress 애플리케이션 또는 플러그인의 예상 동작과 WordPress에서 실행되는 GraphQL 서비스에서이를 해석하는 방법이 포함되어 있습니다.

GraphQL API가 이러한 아이디어를 어떻게 수행하는지 살펴 보겠습니다.

### 데이터 액세스

REST와 마찬가지로 GraphQL 서비스는 PHP 함수를 통해 코딩되어야합니다.
 누가 이것을 어떻게 할 것인가?

GraphQL 스키마에는 유형, 필드 및 지시문이 포함됩니다.
 이들은 PHP 코드의 일부인 리졸버를 통해 처리됩니다.
 누가 이러한 리졸버를 만들어야합니까?

가장 좋은 전략은 GraphQL API가 WordPress의 모든 알려진 엔터티 (게시물, 사용자, 댓글, 카테고리 및 태그 포함)로 기본 GraphQL 스키마를 이미 충족하고 사용자 지정 게시물 유형과 같은 새로운 리졸버를 간단하게 도입하는 것입니다.
 (CPT).

이것이 사용자 엔티티가 이미 플러그인에 의해 제공되는 방식입니다.
 `User` 유형은 다음 코드를 통해 제공됩니다.

```PHP
class UserTypeResolver extends AbstractTypeResolver
{
  public function getTypeName(): string
  {
    return 'User';
  }

  public function getSchemaTypeDescription(): ?string
  {
    return __('Representation of a user', 'users');
  }

  public function getID(object $user)
  {
    return $user->ID;
  }

  public function getTypeDataLoaderClass(): string
  {
    return UserTypeDataLoader::class;
  }
}
```

유형 해석기는 데이터베이스에서 객체를 직접로드하지 않고 대신이 작업을`TypeDataLoader` 객체 (위의 예에서`UserTypeDataLoader`에서)에 위임합니다.
 이 디커플링은 SOLID 원칙을 따르고, 코드를 유지 관리하고 확장 가능하며 이해하기 쉽게 만들기 위해 서로 다른 책임을 다룰 수있는 서로 다른 엔티티를 제공합니다.

`username`,`email` 및`url` 필드를`User` 유형에 추가하는 것은`FieldResolver` 객체를 통해 수행됩니다.

```PHP
class UserFieldResolver extends AbstractDBDataFieldResolver
{
  public static function getClassesToAttachTo(): array
  {
    return [
      UserTypeResolver::class,
    ];
  }

  public static function getFieldNamesToResolve(): array
  {
    return [
      'username',
      'email',
      'url',
    ];
  }

  public function getSchemaFieldDescription(
    TypeResolverInterface $typeResolver,
    string $fieldName
  ): ?string {
    $descriptions = [
      'username' => __("User's username handle", "graphql-api"),
      'email' => __("User's email", "graphql-api"),
      'url' => __("URL of the user's profile in the website", "graphql-api"),
    ];
    return $descriptions[$fieldName];
  }

  public function getSchemaFieldType(
    TypeResolverInterface $typeResolver,
    string $fieldName
  ): ?string {
    $types = [
      'username' => SchemaDefinition::TYPE_STRING,
      'email' => SchemaDefinition::TYPE_EMAIL,
      'url' => SchemaDefinition::TYPE_URL,
    ];
    return $types[$fieldName];
  }

  public function resolveValue(
    TypeResolverInterface $typeResolver,
    object $user,
    string $fieldName,
    array $fieldArgs = []
  ) {
    switch ($fieldName) {
      case 'username':
        return $user->user_login;

      case 'email':
        return $user->user_email;

      case 'url':
        return get_author_posts_url($user->ID);
    }

    return null;
  }
}
```

관찰 할 수 있듯이 GraphQL 스키마에 대한 필드의 정의와 그 해상도는 여러 함수로 분할되었습니다.

- `getSchemaFieldDescription`
- `getSchemaFieldType`
- `resolveValue`

기타 기능은 다음과 같습니다.

- `getSchemaFieldArgs` : 필드 인수 선언 (이름, 설명, 유형 및 필수 여부 포함)
- `isSchemaFieldResponseNonNullable` : 필드가 널이 아닌지 여부를 나타냅니다.
- `getImplementedInterfaceClasses` : 필드에 의해 구현 된 인터페이스에 대한 리졸버 정의
- `resolveFieldTypeResolverClass` : 필드가 연결 일 때 유형 해석기를 정의합니다.
- `resolveFieldMutationResolverClass` : 필드가 변형을 실행할 때 해석기를 정의합니다.

이 코드는 단일 함수 또는 구성 배열을 통해 모든 기능이 충족되는 경우보다 읽기 쉬우므로 리졸버를 구현하고 유지 관리하기가 더 쉽습니다.

플러그인이 새로운 유형 및 필드 리졸버를 생성하여 데이터를 GraphQL 스키마에 통합하지 않으면 어떻게됩니까?
 그러면 사용자가 GraphQL을 통해이 플러그인의 데이터를 쿼리 할 수 있습니까?

예를 들어 WooCommerce가 제품에 대한 CPT를 가지고 있지만 GraphQL 스키마에 해당하는`Product` 유형을 도입하지 않는다고 가정 해 보겠습니다.
 제품 데이터를 검색 할 수 있습니까?

CPT 엔티티와 관련하여 해당 데이터는 일종의 와일드 카드 역할을하는`GenericCustomPost` 유형을 통해 가져올 수 있으며 사이트에 설치된 모든 사용자 정의 포스트 유형을 포함합니다.
 레코드는`Root.genericCustomPosts (customPostTypes : [cpt1, cpt2, ...])`를 쿼리하여 검색됩니다 (이 필드 표기법에서`Root`는 유형이고`genericCustomPosts`는 필드입니다).

그런 다음 이름이` "wc_product"`인 CPT에 해당하는 제품 데이터를 가져 오기 위해 다음 쿼리를 실행합니다.

```
{
  genericCustomPosts(customPostTypes: "[wc_product]") {
    id
    title
    url
    date
  }
}
```

그러나 사용 가능한 모든 필드는 `제목`, `URL`, `날짜`등 모든 CPT 항목에있는 필드뿐입니다. 제품의 CPT에 가격 데이터가있는 경우 해당 필드 `가격`을 사용할 수 없습니다.
 .
 `wc_product`는 WooCommerce 플러그인으로 만든 CPT를 의미하므로 WooCommerce 또는 웹 사이트 개발자가 `Product`유형을 구현하고 자체 맞춤 필드를 정의해야합니다.

CPT는 종종 API를 통해 노출되어서는 안되는 개인 데이터를 관리하는 데 사용됩니다.
 이러한 이유로 GraphQL API는 처음에 `Page`유형 만 노출하며 데이터를 공개적으로 쿼리 할 수있는 다른 CPT를 정의해야합니다.

![image](https://i2.wp.com/d1c2lqfn9an7pb.cloudfront.net/css-tricks/Rendering%20the%20WordPress%20philosophy%20in%20GraphQL/images/settings-generic-custom-posts.jpg?ssl=1)

GraphQL은 플러그인으로 제공되지만 WordPress에는 WP REST API를 통해 REST에 대한 기본 지원이 있습니다.
 경우에 따라 WP REST API로 작업하는 개발자는 GraphQL로 전환하는 데 문제가있을 수 있습니다.

예를 들어 다음과 같은 차이점을 고려하십시오.

- REST 끝점에는 자체 URL이 있으며`GET`을 통해 쿼리 할 수 있지만 GraphQL은 일반적으로 단일 끝점을 통해 작동하며`POST`를 통해서만 쿼리됩니다.
- REST 끝점은 서버 측에서 캐시 할 수 있지만 (`GET`을 통해 쿼리 할 때) GraphQL 끝점은 일반적으로

결과적으로 REST는 캐싱에 대한 더 나은 기본 지원을 제공하여 애플리케이션의 성능을 높이고 서버의 부하를 줄입니다.
 대신 GraphQL은 Apollo 클라이언트에서 지원하는 것처럼 클라이언트 측의 캐싱에 더 중점을 둡니다.

REST에서 GraphQL로 전환 한 후 개발자가 클라이언트 측에서 애플리케이션을 다시 설계하여 캐싱 계층을 도입하기 위해 Apollo 클라이언트를 도입해야합니까?
 그것은 후회할 것입니다.

"지속적 쿼리"기능은 이러한 상황에 대한 솔루션을 제공합니다.
 지속 형 쿼리는 REST와 GraphQL을 함께 결합하여 다음을 수행 할 수 있습니다.

- GraphQL을 사용하여 쿼리를 생성하고
- REST 엔드 포인트와 유사한 자체 URL에 쿼리를 게시합니다.

지속 형 쿼리 엔드 포인트는 REST 엔드 포인트와 동일한 동작을합니다. `GET`을 통해 액세스 할 수 있으며 서버 측에 캐시 할 수 있습니다.
 그러나 GraphQL 구문을 사용하여 생성되었으며 노출 된 데이터에는 언더 / 오버 페칭이 없습니다.

### 확장 성

GraphQL API의 아키텍처는 자체 확장을 추가하는 것이 얼마나 쉬운 지 정의합니다.

GraphQL API는 Publish-subscribe 패턴을 사용하여 필드가 유형에 "구독"되도록합니다.

이전부터 필드 리졸버 재평가 :

```PHP
class UserFieldResolver extends AbstractDBDataFieldResolver
{
  public static function getClassesToAttachTo(): array
  {
    return [UserTypeResolver::class];
  }

  public static function getFieldNamesToResolve(): array
  {
    return [
      'username',
      'email',
      'url',
    ];
  }
}
```

`User` 유형은 만족할 필드를 미리 알지 못하지만 대신 필드 리졸버에 의해이 유형 (`username`,`email` 및`url`)이 유형에 삽입됩니다.

이렇게하면 GraphQL 스키마를 쉽게 확장 할 수 있습니다.
 단순히 필드 리졸버를 추가함으로써 모든 플러그인은 기존 유형에 새 필드를 추가하거나 (예 : WooCommerce가`User.shippingAddress`에 대한 필드를 추가 함) 필드가 해결되는 방식을 재정의 할 수 있습니다 (예 : 반환 할`User.url` 재정의).
 대신 사용자의 웹 사이트).

플러그인은 GraphQL 스키마를 확장 할 수 있어야합니다.
 예를 들어 새로운`Product` 유형을 사용 가능하게 만들고`Post` 유형에 추가`coauthors` 필드를 추가하거나`@ sendEmail` 지시문을 제공하거나 다른 모든 것을 제공 할 수 있습니다.

이를 위해 GraphQL API는 런타임시 스키마가 PHP 코드에서 생성되는 코드 우선 접근 방식을 따릅니다.

SDL 우선 (스키마 정의 언어)이라고하는 대체 접근 방식은 예를 들어 일부`.gql` 파일을 통해 스키마를 미리 제공해야합니다.

이 두 접근 방식의 주요 차이점은 코드 우선 접근 방식에서 GraphQL 스키마가 동적이며 다양한 사용자 또는 애플리케이션에 적용 할 수 있다는 것입니다.
 이는 단일 사이트가 여러 응용 프로그램 (웹 사이트 및 모바일 앱 등)에 전원을 공급하고 다른 클라이언트에 맞게 사용자 지정할 수있는 WordPress에 적합합니다.
 GraphQL API는 "사용자 지정 끝점"기능을 통해이 동작을 명시 적으로 만들어 다른 사용자 또는 응용 프로그램에 대해 다른 GraphQL 스키마에 액세스하여 다른 끝점을 만들 수 있습니다.

성능 저하를 방지하기 위해 스키마를 디스크 또는 메모리에 캐싱하여 정적으로 만들고 스키마를 확장하는 새 플러그인이 설치되거나 관리자가 설정을 업데이트 할 때마다 다시 생성됩니다.

코드 우선 접근 방식을 사용할 때의 또 다른 이점은 GraphQL 사양에서 지원하기 전에 선택할 수있는 새로운 기능을 제공 할 수 있다는 것입니다.

예를 들어, 사양에 대해 중첩 된 변형이 요청되었지만 아직 승인되지 않았습니다.
 GraphQL API는 표준 스키마에 노출 된대로 각각 쿼리 및 변형을 처리하기 위해`QueryRoot` 및`MutationRoot` 유형을 사용하여 사양을 준수합니다.
 그러나 옵트 인 `중첩 된 변형`기능을 사용 설정하면 스키마가 변환되고 쿼리와 변형이 모두 단일 `루트`유형으로 처리되어 중첩 된 변형을 지원합니다.

이 새로운 기능이 실제로 작동하는지 살펴 보겠습니다.
 이 질의에서는 먼저`Root.post`를 통해 게시물을 질의 한 다음`Post.addComment` 변형을 실행하고 생성 된 주석 객체를 얻은 다음 마지막으로`Comment.reply` 변형을 실행하고 일부 데이터를 질의합니다.
 (댓글을 추가 할 수 있도록 사용자를 로그인하기위한 첫 번째 변형의 주석 처리를 제거하십시오) :

```
# mutation {
#   loginUser(
#     usernameOrEmail:"test",
#     password:"pass"
#   ) {
#     id
#     name
#   }
# }
mutation {
  post(id:1459) {
    id
    title
    addComment(comment:"That's really beautiful!") {
      id
      date
      content
      author {
        id
        name
      }
      reply(comment:"Yes, it is!") {
        id
        date
        content
      }
    }
  }
}
```

### 동적 행동

WordPress는 후크 (필터 및 작업)를 사용하여 동작을 수정합니다.
 후크는 트리거 될 때마다 값을 재정의하거나 사용자 지정 작업을 실행할 수있는 간단한 코드 조각입니다.

GraphQL에 상응하는 것이 있습니까?

GraphQL에 대한 유사한 메커니즘을 검색 한 결과, 지시문이 어느 정도 WordPress 후크와 동등하다고 간주 될 수 있다는 결론에 도달했습니다. 필터 후크와 마찬가지로 지시문은 필드의 값을 수정하여 일부를 증가시키는 함수입니다.
 다른 기능.

예를 들어 다음 쿼리를 사용하여 게시물 제목 목록을 검색한다고 가정 해 보겠습니다.

```
query {
  posts {
    title
  }
}
```

…이 응답을 생성합니다.

```js
{
  "data": {
    "posts": [
      {
        "title": "Scheduled by Leo"
      },
      {
        "title": "COPE with WordPress: Post demo containing plenty of blocks"
      },
      {
        "title": "A lovely tango, not with leo"
      },
      {
      "title": "Hello world!"
      },
    ]
  }
}
```

이 결과는 영어입니다.
 스페인어로 어떻게 번역 할 수 있습니까?
 필드`title` (이 지시문 해석기를 통해 구현 됨)에 적용된`@ translate` 지시문을 사용하여 필드 값을 입력으로 가져오고 Google Translate API를 호출하여이를 번역하고 그 결과가 원래 입력을 재정의합니다.
 이 쿼리에서와 같이 :

```
query {
  posts {
    title @translate(from:"en", to"es")
  }
}
```

…이 응답을 생성합니다.

```js
{
  "data": {
    "posts": [
      {
        "title": "Programado por Leo"
      },
      {
        "title": "COPE con WordPress: publica una demostración que contiene muchos bloques"
      },
      {
        "title": "Un tango lindo, no con leo"
      },
      {
        "title": "¡Hola Mundo!"
      }
    ]
  }
}
```

지시문이 입력이 누구인지에 대해 어떻게 무관심한지 주목하십시오.
 이 경우에는`Post.title` 필드 였지만`Post.excerpt`,`Comment.content` 또는`String` 유형의 다른 필드 일 수 있습니다.
 그런 다음 필드를 확인하고 해당 값을 재정의하는 것이 명확하게 분리되고 지시문은 항상 재사용 가능합니다.

WordPress가 지속적으로 웹의 OS가됨에 따라 (현재 모든 사이트의 39 %를 다른 소프트웨어보다 더 많이 사용) 외부 서비스와의 상호 작용도 점진적으로 증가합니다 (결제 용 Stripe, 알림 용 Slack, 호스팅 용 AWS S3 등)
 자산 및 기타).

위에서 살펴본 것처럼 지시문을 사용하여 필드의 응답을 재정의 할 수 있습니다.
 그러나 새로운 가치는 어디에서 오는 것일까 요?
 일부 로컬 함수에서 올 수 있지만 일부 외부 서비스에서도 완벽하게 비롯 될 수 있습니다 (앞에서 살펴본 `@translate`지시문의 경우 Google 번역 API에서 새 값을 검색 함).

이러한 이유로 GraphQL API는 지시문이 외부 API와 쉽게 통신 할 수 있도록하기로 결정하여 다음과 같은 쿼리를 실행할 때 이러한 서비스가 WordPress 사이트의 데이터를 변환 할 수 있도록합니다.

- 번역,
- 이미지 압축,
- CDN을 통한 소싱 및
- 이메일, SMS 및 Slack 알림 보내기.

실제로 GraphQL API는 쿼리 해결 자체가 디렉티브 파이프 라인을 기반으로하는 경우에도 서버 아키텍처에서 하위 수준 구성 요소를 만들어서 가능한 한 강력한 디렉티브를 만들기로 결정했습니다.
 이는 지시문에 응답의 권한 부여, 유효성 검사 및 수정을 수행 할 수있는 권한을 부여합니다.

### 현지화

SDL 우선 접근 방식을 사용하는 GraphQL 서버는 스키마에서 정보를 현지화하기가 어렵다는 것을 발견했습니다 (사양에 대한 해당 문제는 4 년 이상 전에 생성되었지만 아직 해결 방법이 없음).

하지만 코드 우선 접근 방식을 사용하면 GraphQL API는`__ ( `some text`, `domain`)`PHP 함수를 통해 간단한 방식으로 설명을 현지화 할 수 있으며 현지화 된 문자열은 POT 파일에서 검색됩니다.
 WordPress 관리자에서 선택한 지역 및 언어에 해당합니다.

예를 들어 앞서 살펴본 것처럼이 코드는 필드 설명을 지역화합니다.

```PHP
class UserFieldResolver extends AbstractDBDataFieldResolver
{
  public function getSchemaFieldDescription(
    TypeResolverInterface $typeResolver,
    string $fieldName
  ): ?string {
    $descriptions = [
      'username' => __("User's username handle", "graphql-api"),
      'email' => __("User's email", "graphql-api"),
      'url' => __("URL of the user's profile in the website", "graphql-api"),
    ];
    return $descriptions[$fieldName];
  }
}
```

### 사용자 인터페이스

GraphQL 생태계는 서비스와 상호 작용할 수있는 오픈 소스 도구로 가득 차 있으며, 많은 도구가 WordPress에서 기대하는 것과 동일한 사용자 친화적 인 경험을 제공합니다.

GraphQL 스키마 시각화는 GraphQL Voyager로 수행됩니다.

![image](https://i1.wp.com/d1c2lqfn9an7pb.cloudfront.net/css-tricks/Rendering%20the%20WordPress%20philosophy%20in%20GraphQL/images/graphql-voyager-admin.jpg?ssl=1)

이는 자체 CPT를 만들고 액세스 할 수있는 방법과 위치, 노출 된 데이터를 확인할 때 특히 유용 할 수 있습니다.

![image](https://i1.wp.com/d1c2lqfn9an7pb.cloudfront.net/css-tricks/Rendering%20the%20WordPress%20philosophy%20in%20GraphQL/images/interactive-schema.gif?ssl=1)

GraphQL 끝점에 대한 쿼리 실행은 GraphiQL로 수행됩니다.

![image](https://i2.wp.com/d1c2lqfn9an7pb.cloudfront.net/css-tricks/Rendering%20the%20WordPress%20philosophy%20in%20GraphQL/images/graphiql.png?ssl=1)

그러나 사용자는 GraphQL 쿼리 구문에 대한 지식이 있어야하므로이 도구는 모든 사람에게 간단하지 않습니다.
 따라서 필드를 클릭하여 GraphQL 쿼리를 작성하기 위해 GraphiQL Explorer가 그 위에 설치됩니다.

![image](https://i0.wp.com/d1c2lqfn9an7pb.cloudfront.net/css-tricks/Rendering%20the%20WordPress%20philosophy%20in%20GraphQL/images/graphiql-with-explorer.gif?ssl=1)

### 액세스 제어
verified_user

WordPress는 사용자 권한을 관리하기 위해 다양한 사용자 역할 (관리자, 편집자, 작성자, 기고자 및 구독자)을 제공하며, 사용자는`wp-admin` (예 : 직원)에 로그인하고 공개 사이트 (
 예 : 클라이언트), 로그인하지 않았거나 계정 (모든 방문자)이 있습니다.
 GraphQL API는이를 고려하여 다른 사용자에게 세분화 된 액세스 권한을 부여해야합니다.

GraphQL API를 사용하면 GraphiQL 및 Voyager 클라이언트에 액세스 할 수있는 사용자를 구성하여 스키마를 시각화하고 이에 대해 쿼리를 실행할 수 있습니다.

- 관리자 만?
- 직원?
- 클라이언트?
- 모든 사람에게 공개적으로 액세스 할 수 있습니까?

보안상의 이유로 플러그인은 기본적으로 관리자에게만 액세스를 제공하고 인터넷에 서비스를 공개적으로 노출하지 않습니다.

이전 섹션의 이미지에서 GraphiQL 및 Voyager 클라이언트는 `wp-admin`에서 사용할 수 있으며 관리자 만 사용할 수 있습니다.
 관리자는 다음 설정을 통해 다른 역할 (편집자, 작성자, 기여자)이있는 사용자에게 액세스 권한을 부여 할 수 있습니다.

![image](https://i0.wp.com/d1c2lqfn9an7pb.cloudfront.net/css-tricks/Rendering%20the%20WordPress%20philosophy%20in%20GraphQL/images/editor-access.jpg?ssl=1)

클라이언트 또는 개방형 인터넷의 모든 사용자에게 액세스 권한을 부여하기 위해 WordPress 관리자에 대한 액세스 권한을 부여하고 싶지 않습니다.
 그런 다음 설정을 통해 새로운 공개 URL (예 :`mywebsite.com / graphiql` 및`mywebsite.com / graphql-interactive`)에서 도구를 노출 할 수 있습니다.
 이러한 공개 URL을 노출하는 것은 관리자가 명시 적으로 설정 한 옵트 인 선택입니다.

![image](https://i1.wp.com/d1c2lqfn9an7pb.cloudfront.net/css-tricks/Rendering%20the%20WordPress%20philosophy%20in%20GraphQL/images/graphql-voyager-public.jpg?ssl=1)

WP REST API는 사용자 인터페이스가 제공되지 않고 코드를 통해 수행되어야하므로 엔드 포인트 내의 일부 엔드 포인트 또는 필드에 액세스 할 수있는 사용자를 쉽게 사용자 정의 할 수 없습니다.

대신 GraphQL API는 GraphQL 스키마에서 이미 사용 가능한 메타 데이터를 사용하여 사용자 인터페이스 (WordPress 편집기에서 제공)를 통해 서비스 구성을 활성화합니다.
 결과적으로 비전문 사용자도 코드 줄을 건드리지 않고도 API를 관리 할 수 있습니다.

스키마에서 다른 필드 (및 지시문)에 대한 액세스 제어를 관리하려면 해당 필드를 클릭하고 드롭 다운에서 로그인 한 사용자 또는 특정 기능을 가진 사용자와 같은 사용자를 선택하여 액세스 할 수 있습니다.

![image](https://i1.wp.com/d1c2lqfn9an7pb.cloudfront.net/css-tricks/Rendering%20the%20WordPress%20philosophy%20in%20GraphQL/images/access-control.gif?ssl=1)

### 갈등 방지

네임 스페이스는 두 플러그인이 유형에 동일한 이름을 사용할 때마다 충돌을 방지하는 데 도움이됩니다.
 예를 들어 WooCommerce와 Easy Digital Downloads가 모두 `Product`라는 유형을 구현하면 제품을 가져 오는 쿼리를 실행하는 것이 모호해집니다.
 그런 다음 네임 스페이스는 유형 이름을`WooCommerceProduct` 및`EDDProduct`로 변환하여 충돌을 해결합니다.

그러나 그러한 갈등이 발생할 가능성은 그리 높지 않습니다.
 따라서 가장 좋은 전략은 스키마를 가능한 한 단순하게 유지하기 위해 기본적으로 비활성화하고 필요한 경우에만 활성화하는 것입니다.

활성화되면 GraphQL 서버는 해당 PHP 패키지 이름 (모든 패키지가 PHP 표준 권장 사항`PSR-4`를 따르는)을 사용하여 유형을 자동으로 네임 스페이스 화합니다.
 예를 들어,이 일반 GraphQL 스키마의 경우 :

![image](https://i1.wp.com/d1c2lqfn9an7pb.cloudfront.net/css-tricks/Rendering%20the%20WordPress%20philosophy%20in%20GraphQL/images/regular-schema.png?ssl=1)

… 네임 스페이스를 활성화하면 `Post`는 `PoPSchema_Posts_Post`가되고 `Comment`는 `PoPSchema_Comments_Comment`가됩니다.

![image](https://i2.wp.com/d1c2lqfn9an7pb.cloudfront.net/css-tricks/Rendering%20the%20WordPress%20philosophy%20in%20GraphQL/images/namespaced-schema.png?ssl=1)

### 그게 다야, 여러분

WordPress와 GraphQL은 모두 그 자체로 매혹적인 주제이므로 WordPress와 GraphQL의 통합이 매우 사랑 스럽습니다.
 지금까지 몇 년 동안 일해 왔기 때문에 이전 CMS가 콘텐츠를 관리하고 새로운 인터페이스가 콘텐츠에 액세스 할 수있는 최적의 방법을 설계하는 것은 추구 할 가치가있는 도전이라고 말할 수 있습니다.

나는 WordPress 철학이 WordPress에서 실행되는 GraphQL 서비스의 구현에 어떻게 영향을 미칠 수 있는지 계속 설명 할 수 있으며,이 글에 포함되지 않은 많은 자료를 사용하여 몇 시간 동안이라도 그것에 대해 이야기 할 수 있습니다.
 하지만 멈춰야 해요 ... 그러니 이제 멈출 게요.

이 기사가 WordPress 용 GraphQL API 플러그인에서 수행 한 것처럼 GraphQL의 WordPress 철학을 만족시키는 이유와 방법에 대한 좋은 개요를 제공하기를 바랍니다.