---
title: "Azure CosmosDB, 중복 검증 스트레로이드 버전"
description: ""
coverImage: "/assets/img/2024-06-19-AzureCosmosDBZodDataValidationonSteroids_0.png"
date: 2024-06-19 14:45
ogImage: 
  url: /assets/img/2024-06-19-AzureCosmosDBZodDataValidationonSteroids_0.png
tag: Tech
originalTitle: "Azure CosmosDB , Zod: Data Validation on Steroids"
link: "https://medium.com/@mingyang-li/azure-cosmosdb-zod-data-validation-on-steroids-af28adf73335"
---



![Azure CosmosDB](/assets/img/2024-06-19-AzureCosmosDBZodDataValidationonSteroids_0.png)

데이터베이스 보호 및 Azure 요금 절감

Azure CosmosDB는 다른 NoSQL 데이터베이스들처럼 훌륭합니다. 빠르고 신뢰할 수 있으며 매우 유연합니다.

그러나 자유는 언제나 대가가 따릅니다. 완전히 스키마 없는 데이터베이스의 경우, 데이터베이스에 들어가는 내용과 데이터를 검색하는 방법에 대해 계산된 결정을 내리게 됩니다. 개발자인 우리에게 책임이 떨어집니다.


<div class="content-ad"></div>

가장 흔한 사용 사례 중 하나는 ID별로 레코드/항목을 찾는 것입니다.

이게 얼마나 중요한가요?

그냥 SELECT * FROM c WHERE c.id = "some-id" 를 사용하면 될 일이 아닙니까?

또는 Azure CosmosDB SDK를 사용하여 간단히 이렇게 할 수 있습니다:

<div class="content-ad"></div>

```js
await container.item("some-id", "some-id").read();
```

둘 다 맞아요.

하지만 처음부터 데이터베이스와 통신할 필요가 없는 경우도 있습니다. 예를 들어:

- ID 입력이 정의되지 않은 경우
- ID 입력이 null 인 경우
- ID 입력이 빈 문자열인 경우: ""
- ID 입력에 공백 문자가 포함된 경우: " some-id", "some -id", 또는 "some-id"는 모두 CosmosDB가 허용하지 않는 잘못된 ID입니다.
- 특별한 사용 사례: ID 입력이 이미 데이터베이스에 적용한 사용자 지정 ID 형식을 준수하지 않는 경우. 예: 모든 ID는 USER-xxx-xxxx-xxxx 등의 형식을 따라야 합니다.

<div class="content-ad"></div>

이 문제를 해결하기 위해 2가지 방법이 있습니다:

- 사용자 정의 함수 작성
- 스키마 유효성 검사 도구 사용 (예: zod, yup, valibot, typia 등)

두 가지 모두 API로 들어오는 데이터를 어떤 형식으로든 수동으로 유효성을 검사해야 합니다.

방법 1: 사용자 정의 함수 작성

<div class="content-ad"></div>

```js
import { ResultAsync, err, ok } from 'neverthrow';
import { CosmosClient } from '@azure/cosmos';

// CosmosDB 연결 초기화
const endpoint = `데이터베이스_엔드포인트`;
const key = `데이터베이스_키`;
const client = new CosmosClient({ endpoint, key });

// 작업을 수행할 "컨테이너" 설정
const container = client.database(`데이터베이스_이름`).container(`컨테이너_이름`);

export type Post = {
  id: string;
  // 다른 속성들
};

export const findOnePost = async (
  id: string,
): Promise<ResultAsync<Post, Error>> => {
  // 입력 유효성 검사 - 매우 수동적
  if (id === undefined || id === null) {
    return err(new Error(`ID는 정의되거나 null일 수 없습니다`));
  }
  if (id === ``) {
    return err(new Error(`ID는 빈 문자열일 수 없습니다`));
  }
  if (id.includes(` `)) {
    return err(new Error(`ID에는 공백 문자가 포함될 수 없습니다`));
  }
  // ... ID가 규격을 준수해야하는 다른 규칙들

  // 데이터베이스 호출
  const result = await fromPromise(
    await container.item<Post>(id, id).read(),
    (e) => e,
  );
  if (result.isErr()) {
    return err(new Error(`데이터베이스에서 항목을 검색하는 데 실패했습니다. 오류 코드: ${result.error['code']}`));
  }

  // 선택 사항: 데이터베이스에서 검색된 데이터 유효성 검사

  // 게시물 데이터 반환
  return ok<Post>(result.value.resource);
};
```

접근 방법 2: 스키마 유효성 검사 도구(Zod) 사용

```js
import { z } from 'zod';
import { fromError } from 'zod-validation-error';
import { ResultAsync, err, ok } from 'neverthrow';
import { CosmosClient } from '@azure/cosmos';

// CosmosDB 연결 초기화
const endpoint = `데이터베이스_엔드포인트`;
const key = `데이터베이스_키`;
const client = new CosmosClient({ endpoint, key });

// 작업을 수행할 "컨테이너" 설정
const container = client.database(`데이터베이스_이름`).container(`컨테이너_이름`);

// ID 스키마
const IdSchema = z
  .string()
  .min(8)
  .refine((value) => {
    return !value.includes(` `);
  }, `ID에 공백 문자를 포함할 수 없습니다`)
  .describe(
    `입력을 문자열로, 적어도 8자 이상이어야하며 공백 문자를 포함해서는 안됩니다`,
  );

export type Post = {
  id: string;
  // 다른 속성들
};

export const findOnePost = async (
  id: string,
): Promise<ResultAsync<Post, Error>> => {
  // 입력 유효성 검사 - zod 사용
  const validateInput = IdSchema.safeParse(id);
  if (!validateInput.success) {
    const { message } = fromError(validateInput.error);
    return err(new Error(message));
  }

  // 데이터베이스 호출
  const result = await fromPromise(
    await container.item<Post>(id, id).read(),
    (e) => e,
  );
  if (result.isErr()) {
    return err(new Error(`데이터베이스에서 항목을 검색하는 데 실패했습니다. 오류 코드: ${result.error['code']}`));
  }

  // 선택 사항: 데이터베이스에서 검색된 데이터 유효성 검사

  // 게시물 데이터 반환
  return ok<Post>(result.value.resource);
};
```

두 가지 접근 방법이 모두 작동함을 확인할 수 있습니다. 둘 다 Azure CosmosDB 호출 전에 ID 입력의 유효성을 검사합니다.


<div class="content-ad"></div>

만약 더 많은 코드를 작성하거나 앱이 매우 작다거나 새로운 npm 패키지를 추가하고 싶지 않다면 첫 번째 방법을 사용하세요.

더 적은 코드를 작성하고 코드베이스의 여러 곳에 동일한 유효성을 적용하려면 두 번째 방법을 사용하세요.

그러나 주요 아이디어는 데이터베이스에 여행을 하기 전에 ID가 유효한지 확인해야 한다는 것입니다.

아래 다이어그램에서는 주황색으로 둘러싸인 부분을 추가하는 중입니다.

<div class="content-ad"></div>


![Azure CosmosDB Zod Data Validation on Steroids](/assets/img/2024-06-19-AzureCosmosDBZodDataValidationonSteroids_1.png)

데이터베이스를 요청하지 않으면 매우 사소한 것처럼 보일 수 있지만, 모든 달러가 중요합니다. Azure CosmosDB를 쿼리하는 시기, 방법 및 빈도를 신중히 다루면 큰 Azure 송장에서 자신을 보호할 수 있습니다.

생각을 공유하고 댓글을 달아주세요!
