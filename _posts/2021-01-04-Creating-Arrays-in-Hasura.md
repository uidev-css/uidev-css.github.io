---
layout: post
title: "Hasura에서 배열 만들기"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/12/hasura.png
tags: ARRAYS,DATA,GRAPHQL,HASURA
---


Hasura는 내 애플리케이션을위한 관리 형 GraphQL API를 만드는 가장 좋아하는 방법 중 하나입니다.
 쉽고 간단하며 광범위한 사용 사례에 적합합니다.
 하지만 Hasura와 함께 일하면서 같은 질문이 계속해서 나오는 것을 보았습니다. 어레이를 어떻게 만들어야합니까?
 행의 `유형`드롭 다운에 `배열`과 `맵`이 제공되지 않는다는 사실을 감안할 때이를 수행하는 가장 좋은 방법은 무엇입니까?

사실 배열의 개념은 몇 가지 다른 방법으로 Hasura에 의해 포착 될 수 있으며, 다음은 이에 접근하는 방법의 분석입니다.
 개인적으로 선호하는 옵션은 마지막 옵션 인 JSONB이지만, 모든 옵션에는 약간의 이점이 있으므로 다른 경로를 선택하려는 경우 다른 옵션을 살펴 보겠습니다.

### 방법 1 : 리터럴 배열, 수동

Hasura는 `유형`으로 ``배열 `을 제공하지 않지만 다음과 같이`텍스트 `를 선택하고 끝에 대괄호를 추가하여 문자열 배열을 만들 수 있습니다.


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video controls="" src="https://css-tricks.com/wp-content/uploads/2020/12/CleanShot-2020-12-12-at-19.57.47.mp4" playsinline="" name="fitvid0"></video>
</div>


결과는`text []`이며 다음 두 가지 방법 중 하나로 배열을 생성하라는 메시지가 표시됩니다.

```js
["one", "two"] 
// or 
{"one", "two"}
```

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/12/CleanShot-2020-12-12-at-20.00.50@2x.png?resize=1034%2C118&ssl=1)

### 방법 2 : 관계 만들기

일련의 텍스트 요소 인 다른 테이블과의 관계를 만들 수도 있습니다.
 이렇게하려면 텍스트 유형이있는 행을 만듭니다.

또한 사이드 바의 "테이블 추가"버튼을 통해 새 테이블을 만들고 필요한`유형`에 대한 고유 키 (텍스트, 정수 또는 필요한 모든 항목)를 사용하여 매우 간단한 행을 만듭니다.
 자료.

이제 "관계"탭을 클릭하십시오.
 테이블에서 "배열 관계"옵션을 선택하고 이름을 지정한 다음 생성 된 원본 테이블을 참조합니다.

첫 번째 테이블의 `id`는 방금 만든 두 번째 테이블의 `id`와 관계가 있어야합니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/12/image8.png?resize=1999%2C1625&ssl=1)

저장 한 후에는 관계 방향을 나타내는 화살표와 함께 동일한 관계 탭의 표에 반영된 배열 관계를 볼 수 있습니다.

```
users.gameId → favoriteGames.id
```

이제“GraphiQL”탭에서 어레이를 조회 할 수 있습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/12/image5.png?resize=1999%2C1343&ssl=1)

### 방법 3 : JSONB

다음은 Hasura에서 배열을 만드는 가장 좋아하는 방법 중 하나입니다.
 정말 성능이 좋기 때문에 좋아합니다.
 "JSONB"유형을 사용하고 드롭 다운에서 JSONB를 선택하여 배열을 만들 수 있습니다.
 그러면`text []`옵션과 비슷한 방식으로 프롬프트됩니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/12/CleanShot-2020-12-12-at-20.04.05@2x.png?resize=1046%2C110&ssl=1)

작성되면 다음과 같이 표시됩니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/12/CleanShot-2020-12-12-at-20.04.24@2x.png?resize=1024%2C96&ssl=1)

여기에서 위와 같이 쿼리에 배열을 추가 할 수있을뿐만 아니라 여러 인덱스를 통해 태그로 검색 할 수도 있으며 GraphiQL 탭을 사용하여 쉽게 탐색 할 수 있습니다.
 "animation"이 포함 된 항목으로 태그를 필터링 할 때 확인하십시오.

```sql
query MyQuery {
  codesamples(where: {tags: {_contains: "animation"}}) {
    userId
    name
    id
  }
}
```

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/12/CleanShot-2020-12-12-at-20.17.24@2x.png?resize=2124%2C624&ssl=1)

그러나 이와 같은 조회는 특히 많은 양의 데이터가있는 경우 즉시 수행 할 수있는 것은 아닙니다.
 다행히 인덱싱 할 필드를 정의 할 수 있습니다.
 상단의 "데이터"탭에서 측면 패널의 "SQL"그룹을 선택하면 해당 영역에서 성능 조회를 유지하기 위해 인덱싱 할 필드를 정의 할 수 있습니다.
 이 예에서는 `태그`필드에 색인을 생성합니다.

```sql
create index codesample_gin on codesamples using gin(tags)
```

그러면 쿼리가 실행되고이 조회를 인덱싱하여 향후 성능이 향상됩니다.

## 마무리
verified_user

Hasura는 빠르고 사용하기 쉬운 GraphQL API를 설정할 수있는 훌륭한 개발자 경험을 가지고 있습니다.
 Hasura로 어레이를 설정하는 데 관심이있는 사람들에게이 기사가 도움이되기를 바랍니다.

이 게시물을 증명 한 Hasura의 Adron Hall에게 감사드립니다.