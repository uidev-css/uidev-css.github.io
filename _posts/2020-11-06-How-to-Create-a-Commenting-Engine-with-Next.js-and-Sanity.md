---
layout: post
title: "Next.js 및 Sanity를 사용하여 주석 엔진을 만드는 방법
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/10/next-sanity-comments.jpg
tags: COMMENTS,NEXT.JS,SANITY
---


웹 사이트 구축을위한 Jamstack 접근 방식에 반대하는 주장 중 하나는 기능 개발이 복잡해지고 종종 여러 다른 서비스가 필요하다는 것입니다.
 예를 들어, 주석을보십시오.
 Jamstack 사이트에 대한 댓글을 설정하려면 종종 Disqus, Facebook 또는 별도의 데이터베이스 서비스와 같은 타사 솔루션이 필요합니다.
 이러한 타사 솔루션은 일반적으로 귀하의 댓글이 콘텐츠와 연결이 끊어진 상태로 라이브를 의미합니다.
 

타사 시스템을 사용할 때 다른 사람의 코드를 사용하는 단점을 감수해야합니다.
 플러그 앤 플레이 솔루션을 얻을 수 있지만 비용은 얼마입니까?
 사용자에게 표시되는 광고?
 최적화 할 수없는 불필요한 자바 스크립트?
 댓글 내용이 다른 사람의 소유라는 사실?
 이것들은 확실히 고려할 가치가있는 것들입니다.
 

워드 프레스와 같은 모 놀리 식 서비스는 모든 것을 동일한 애플리케이션에 보관함으로써이 문제를 해결했습니다.
 컨텐츠와 동일한 데이터베이스 및 CMS에 댓글을 보관하고 컨텐츠를 쿼리하는 것과 동일한 방식으로 쿼리하고 프런트 엔드에 동일한 프레임 워크로 표시 할 수 있다면 어떨까요?
 

이 특정 Jamstack 애플리케이션은 개발자와 편집자 모두에게 훨씬 더 응집력있는 느낌을줍니다.
 

### 우리만의 코멘트 엔진을 만들어 보자
 

이 기사에서는 Next.js 및 Sanity.io를 사용하여 이러한 요구 사항을 충족하는 주석 엔진을 만들 것입니다.
 콘텐츠, 편집자, 댓글 작성자 및 개발자를위한 단일 통합 플랫폼입니다.
 

Next.js는 Vercel 팀이 만든 React 용 메타 프레임 워크입니다.
 서버리스 기능, 정적 사이트 생성 및 서버 측 렌더링을위한 기본 제공 기능이 있습니다.
 

작업을 위해 대부분 서버리스 기능과 정적 사이트 생성 기능에 내장 된 "API 경로"를 사용합니다.
 API 경로는 프로젝트를 상당히 단순화하지만 Netlify와 같은 것에 배포하는 경우 이러한 기능을 서버리스 기능으로 변환하거나 Netlify의 차세대 Netlify 패키지를 사용할 수 있습니다.
 

Next.js를 이와 같은 프로젝트를위한 훌륭한 솔루션으로 만드는 것은 정적, 서버 렌더링 및 서버리스 함수의 교차점입니다.
 

Sanity.io는 구조화 된 콘텐츠를위한 유연한 플랫폼입니다.
 핵심은 개발자가 콘텐츠를 구조화 된 데이터로 생각하도록 장려하는 데이터 저장소입니다.
 종종 Sanity Studio라는 오픈 소스 CMS 솔루션과 함께 제공됩니다.
 

댓글과 같은 사용자 생성 콘텐츠와 함께 작성자의 콘텐츠를 유지하기 위해 Sanity를 사용할 것입니다.
 결국 Sanity는 강력한 API와 구성 가능한 CMS를 갖춘 콘텐츠 플랫폼으로 이러한 요소를 하나로 묶는 데 필요한 사용자 지정을 허용합니다.
 

### Sanity 및 Next.js 설정
 

이 프로젝트를 처음부터 시작하지는 않을 것입니다.
 Vercel에서 만든 간단한 블로그 스타터를 사용하여 Next.js 및 Sanity 통합 작업을 시작하겠습니다.
 Vercel 스타터 저장소에는 프런트 엔드와 Sanity Studio가 분리되어 있으므로 두 가지를 모두 포함하는 단순화 된 저장소를 만들었습니다.
 

이 저장소를 복제하여 주석 기반을 만드는 데 사용합니다.
 최종 코드를보고 싶으십니까?
 이 "스타터"는 저장소, Vercel 프로젝트 및 Sanity 프로젝트가 모두 연결된 상태로 설정합니다.
 

스타터 저장소는 Next.js에서 제공하는 프런트 엔드와 Sanity Studio의 두 부분으로 나뉩니다.
 더 진행하기 전에 로컬에서 실행해야합니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/10/szou8MEg.png?resize=3584%2C2016&ssl=1)

시작하려면 Next에서 데이터를 사용하도록 콘텐츠와 CMS를 설정해야합니다.
 먼저 Studio를 실행하고 Sanity API에 연결하는 데 필요한 종속성을 설치해야합니다.
 

```terminal
# Install the Sanity CLI globally
npm install -g @sanity/cli
# Move into the Studio directory and install the Studio's dependencies
cd studio
npm install
```

설치가 끝나면`/ studio` 디렉토리 내에서 CLI로 새 프로젝트를 설정할 수 있습니다.
 

```terminal
# If you're not logged into Sanity via the CLI already
sanity login
# Run init to set up a new project (or connect an existing project)
sanity init
```

`init` 명령은 모든 것을 설정하기 위해 몇 가지 질문을합니다.
 Studio 코드에는 이미 몇 가지 구성 값이 있으므로 CLI는이를 재구성할지 묻는 메시지를 표시합니다.
 우리는하다.
 

거기에서 연결할 프로젝트 또는 새 프로젝트를 구성할지 묻는 메시지가 표시됩니다.
 

설명이 포함 된 프로젝트 이름으로 새 프로젝트를 구성합니다.
 생성중인 "데이터 세트"의 이름을 지정하라는 메시지가 표시됩니다.
 이것은 완벽하게 괜찮은 "production"으로 기본 설정되지만 프로젝트에 적합한 이름으로 재정의 할 수 있습니다.
 

CLI는 프로젝트의 ID와 데이터 세트 이름으로`~ / studio / sanity.json` 파일을 수정합니다.
 이 값은 나중에 중요하므로이 파일을 편리하게 보관하십시오.
 

지금은 Studio를 로컬에서 실행할 준비가되었습니다.
 

```terminal
# From within /studio
npm run start
```

Studio가 컴파일 된 후 `http : // localhost : 3333`의 브라우저에서 열 수 있습니다.
 

이 시점에서 관리자로 이동하여 테스트 콘텐츠를 만드는 것이 좋습니다.
 프런트 엔드가 제대로 작동하려면 적어도 하나의 블로그 게시물과 한 명의 작성자가 필요하지만 추가 콘텐츠는 항상 좋은 느낌을줍니다.
 콘텐츠는 localhost의 Studio에서 작업하는 경우에도 데이터 저장소에 실시간으로 동기화됩니다.
 즉시 쿼리 할 수 있습니다.
 콘텐츠를 공개적으로 사용할 수 있도록 게시를 푸시하는 것을 잊지 마십시오.
 

콘텐츠가 준비되면 Next.js 프로젝트를 실행할 차례입니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/10/d8R9vh2N.png?resize=3584%2C1848&ssl=1)

Next.js에 필요한 대부분의 항목은 이미 저장소에 설정되어 있습니다.
 우리가해야 할 가장 중요한 것은 Sanity 프로젝트를 Next.js에 연결하는 것입니다.
 이를 위해`/ blog-frontent / .env.local.example`에 설정된 환경 변수 세트의 예가 있습니다.
 해당 파일에서`.example`을 제거한 다음 적절한 값으로 환경 변수를 수정합니다.
 

Sanity 프로젝트의 API 토큰이 필요합니다.
 이 값을 만들기 위해 Sanity 대시 보드로 이동하겠습니다.
 대시 보드에서 현재 프로젝트를 찾고 설정 → API 영역으로 이동합니다.
 여기에서 프로젝트에 사용할 새 토큰을 만들 수 있습니다.
 많은 프로젝트에서 읽기 전용 토큰을 만드는 것만으로 충분합니다.
 프로젝트에서 데이터를 Sanity에 다시 게시 할 예정이므로 읽기 + 쓰기 토큰을 만들어야합니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/10/image.png?resize=2166%2C1204&ssl=1)

"새 토큰 추가"를 클릭하면 토큰 값이 포함 된 팝업이 표시됩니다.
 일단 닫히면 토큰을 다시 회수 할 수 없으니 꼭 챙기세요!
 

이 문자열은`.env.local` 파일에`SANITY_API_TOKEN`의 값으로 들어갑니다.
 이미`manage.sanity.io`에 로그인되어 있으므로 프로젝트 페이지 상단에서 프로젝트 ID를 가져 와서`NEXT_PUBLIC_SANITY_PROJECT_ID` 값으로 붙여 넣을 수도 있습니다.
 `SANITY_PREVIEW_SECRET`는 Next.js를 `미리보기 모드`로 실행하려는 경우에 중요하지만이 데모에서는이를 입력 할 필요가 없습니다.
 

Next 프런트 엔드를 실행할 준비가 거의되었습니다.
 Sanity 대시 보드가 아직 열려있는 동안 설정 → API보기를 한 번 더 변경해야합니다.
 Next.js 로컬 호스트 서버가 요청을 할 수 있도록 허용해야합니다.
 

CORS Origins에서 새 오리진을 추가하고 현재 로컬 호스트 포트 인`http : // localhost : 3000`으로 채 웁니다.
 인증 된 요청을 보낼 수있을 필요가 없으므로이 기능을 해제 할 수 있습니다. 이것이 활성화되면 프로덕션 URL과 함께 추가 Origin을 추가하여 라이브 사이트에서도 요청을 할 수 있도록해야합니다.
 

이제 블로그를 로컬에서 실행할 준비가되었습니다!
 

```terminal
# From inside /blog-frontend
npm run dev
```

위의 명령을 실행 한 후 이제 Sanity API에서 가져온 데이터를 사용하여 컴퓨터에서 블로그가 실행됩니다.
 `http : // localhost : 3000`을 방문하여 사이트를 볼 수 있습니다.
 

### 주석 스키마 만들기
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/10/WGhyRvAA.png?resize=2168%2C1812&ssl=1)

Studio의 뷰를 사용하여 데이터베이스에 주석을 추가하려면 데이터에 대한 스키마를 설정해야합니다.
 

스키마를 추가하기 위해`/ studio / schemas` 디렉토리에`comment.js`라는 새 파일을 추가합니다.
 이 JavaScript 파일은 전체 데이터 구조의 정의를 포함 할 개체를 내 보냅니다.
 그러면 Studio에 데이터를 표시하는 방법과 프런트 엔드로 반환 할 데이터를 구성하는 방법을 알려줍니다.
 

댓글의 경우 댓글 세계의 `기본값`으로 간주 될 수있는 항목이 필요합니다.
 사용자 이름, 이메일을위한 필드, 주석 문자열을위한 텍스트 영역이 있습니다.
 이러한 기본 사항과 함께 특정 게시물에 댓글을 첨부하는 방법도 필요합니다.
 Sanity의 API에서 필드 유형은 다른 유형의 데이터에 대한 "참조"입니다.
 

사이트가 스팸을 받기를 원하면 거기서 끝낼 수 있지만 승인 프로세스를 추가하는 것이 좋습니다.
 사이트에 댓글을 표시할지 여부를 제어하는 부울 필드를 댓글에 추가하여이를 수행 할 수 있습니다.
 

```js
export default {
  name: 'comment',
  type: 'document',
  title: 'Comment',
  fields: [
    {
      name: 'name',
      type: 'string',
    },
    {
      title: 'Approved',
      name: 'approved',
      type: 'boolean',
      description: "Comments won't show on the site without approval"
    },   
    {
      name: 'email',
      type: 'string',
    },
    {
      name: 'comment',
      type: 'text',
    },
    {
      name: 'post',
      type: 'reference',
      to: [
        {type: 'post'}
      ]
    }
  ],
}
```

이 문서를 추가 한 후`/ studio / schemas / schema.js` 파일에 추가하여 새 문서 유형으로 등록해야합니다.
 

```js
import createSchema from 'part:@sanity/base/schema-creator'
import schemaTypes from 'all:part:@sanity/base/schema-type'
import blockContent from './blockContent'
import category from './category'
import post from './post'
import author from './author'
import comment from './comment' // <- Import our new Schema
export default createSchema({
  name: 'default',
  types: schemaTypes.concat([
    post,
    author,
    category,
    comment, // <- Use our new Schema
    blockContent
  ])
})

```

이러한 변경이 이루어지면 Studio를 다시 살펴보면 기본 콘텐츠 목록에 댓글 섹션이 표시됩니다.
 아직 프런트 엔드에 UI를 구축하지 않았기 때문에 테스트를 위해 첫 번째 주석을 추가 할 수도 있습니다.
 

현명한 개발자는 댓글을 추가 한 후 댓글 목록보기 미리보기가별로 도움이되지 않음을 알 수 있습니다.
 이제 데이터가 있으므로 해당 목록보기에 대한 사용자 지정 미리보기를 제공 할 수 있습니다.
 

### 목록보기에서 주석에 대한 CMS 미리보기 추가
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/10/F0Wjg_ZF.png?resize=1000%2C434&ssl=1)

`fields` 배열 뒤에`preview` 객체를 지정할 수 있습니다.
 `preview` 개체는 표시 할 데이터와 구성을 Sanity의 목록보기에 알려줍니다.
 이 개체에 속성과 메서드를 추가합니다.
 `select` 속성은 스키마에서 데이터를 수집하는 데 사용할 수있는 객체입니다.
 이 경우 댓글의`name`,`comment` 및`post.title` 값을 사용합니다.
 이 새로운 변수를`prepare ()`메서드에 전달하고이를 사용하여 목록보기에서 사용할`title`과`subtitle`을 반환합니다.
 

```js
export default {
  // ... Fields information
  preview: {
      select: {
        name: 'name',
        comment: 'comment',
        post: 'post.title'
      },
      prepare({name, comment, post}) {
        return {
          title: `${name} on ${post}`,
          subtitle: comment
        }
      }
    }
  }

}
```

제목이 크게 표시되고 자막이 더 작아지고 희미 해집니다.
 이 미리보기에서는 제목을 댓글 작성자의 이름과 댓글의 게시물이 포함 된 문자열로 만들고 댓글 본문 자체의 부제를 사용합니다.
 필요에 맞게 미리보기를 구성 할 수 있습니다.
 

이제 데이터가 존재하고 CMS 미리보기가 준비되었지만 아직 사이트로 가져 오지 않았습니다.
 각 게시물에 대한 의견을 가져 오기 위해 데이터 가져 오기를 수정해야합니다.
 

### 각 게시물의 댓글 표시
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/10/fI5JNsLA.png?resize=3240%2C1894&ssl=1)

이 저장소에는 Sanity의 API와 상호 작용하는 데 사용할 수있는 함수 전용 파일이 있습니다.
 `/ blog-frontend / lib / api.js` 파일에는 사이트에서 다양한 경로의 사용 사례에 대한 특정 내보내기 기능이 있습니다.
 이 파일의`getPostAndMorePosts` 함수를 업데이트하여 각 게시물에 대한 데이터를 가져와야합니다.
 현재 페이지의 슬러그와 관련된 게시물에 대한 적절한 데이터와 함께 표시 할 새 게시물 선택을 반환합니다.
 

이 함수에는 현재 게시물에 대한 데이터를 가져 오는 쿼리와 추가 게시물에 대한 쿼리가 있습니다.
 수정해야하는 요청이 첫 번째 요청입니다.
 

쿼리는 데이터 저장소에서 데이터를 가져 오기 위해 Sanity에서 사용하는 오픈 소스 그래프 기반 쿼리 언어 GROQ로 만들어집니다.
 쿼리는 세 부분으로 나뉩니다.
 

- 필터 – 찾아서 다시 보낼 데이터 세트`* [_ type == "post"&& slug.current == $ slug]`
 
- 선택적 파이프 라인 구성 요소 — 구성 요소가 왼쪽에있는`|
 order (_updatedAt desc)`
 
- 선택적 투영 — 쿼리에 대해 반환 할 특정 데이터 요소입니다.
 이 경우 대괄호 (`{}`) 사이의 모든 것입니다.
 

이 예에는 대부분의 쿼리에 필요한 필드의 변수 목록과 블로그 게시물의 `본문`데이터가 있습니다.
 `body`바로 다음에이 게시물과 관련된 모든 댓글을 가져오고 싶습니다.
 

이를 위해 반환 된 객체에` `comments``라는 명명 된 속성을 만든 다음 현재 게시물 컨텍스트에 대한 참조를 포함하는 주석을 반환하는 새 쿼리를 실행합니다.
 

전체 필터는 다음과 같습니다.
 

```js
*[_type == "comment" && post._ref == ^._id && approved == true]
```

필터는 대괄호 (`[]`)의 내부 기준을 충족하는 모든 문서와 일치합니다.
 이 경우`_type == "comment"`의 모든 문서를 찾습니다.
 그런 다음 현재 게시물의`_ref`가 댓글의`_id`와 일치하는지 테스트합니다.
 마지막으로 댓글이 `approved == true`인지 확인합니다.
 

해당 데이터가 있으면 선택적 프로젝션을 사용하여 반환 할 데이터를 선택합니다.
 예측이 없으면 각 댓글에 대한 모든 데이터를 얻을 수 있습니다.
 이 예에서는 중요하지 않지만 좋은 습관입니다.
 

```js
curClient.fetch(
    `*[_type == "post" && slug.current == $slug] | order(_updatedAt desc) {
        ${postFields}
        body,
        'comments': *[_type == "comment" && post._ref == ^._id && approved == true]{
            _id, 
            name, 
            email, 
            comment, 
            _createdAt
        }
    }`,
 { slug }
 )
 .then((res) => res?.[0]),
```

Sanity는 응답에서 데이터 배열을 반환합니다.
 이는 많은 경우에 유용 할 수 있지만 배열의 첫 번째 항목 만 필요하므로 응답을 인덱스의 0 위치로 제한합니다.
 

개별 게시물은`/ blog-frontend / pages / posts / [slug] .js` 파일에있는 코드를 사용하여 렌더링됩니다.
 이 파일의 구성 요소는 이미 API 파일에서 업데이트 된 데이터를 받고 있습니다.
 메인`Post ()`함수는 레이아웃을 반환합니다.
 여기에서 새 구성 요소를 추가합니다.
 

댓글은 일반적으로 게시물 콘텐츠 뒤에 표시되므로 닫는`</ article>`태그 바로 뒤에 추가하겠습니다.
 

```jsx
// ... The rest of the component
</article>
// The comments list component with comments being passed in
<Comments comments={post?.comments} />
```

이제 컴포넌트 파일을 만들어야합니다.
 이 프로젝트의 구성 요소 파일은`/ blog-frontend / components` 디렉토리에 있습니다.
 구성 요소의 표준 패턴을 따릅니다.
 이 구성 요소의 주요 기능은 전달 된 배열을 가져와 적절한 마크 업으로 정렬되지 않은 목록을 만드는 것입니다.
 

이미`<Date />`구성 요소가 있으므로이를 사용하여 날짜 형식을 올바르게 지정할 수 있습니다.
 

```js
# /blog-frontend/components/comments.js

import Date from './date'

export default function Comments({ comments = [] }) {
  return (
    <>
     <h2 className="mt-10 mb-4 text-4xl lg:text-6xl leading-tight">Comments:</h2>
      <ul>
        {comments?.map(({ _id, _createdAt, name, email, comment }) => (
          <li key={_id} className="mb-5">
            <hr className="mb-5" />
            <h4 className="mb-2 leading-tight"><a href={`mailto:${email}`}>{name}</a> (<Date dateString={_createdAt}/>)</h4>
            <p>{comment}</p>
            <hr className="mt-5 mb-5" />
         </li>
        ))
      </ul>
    </>
  )
}
```

`/ blog-frontend / pages / posts / [slug] .js` 파일로 돌아가서이 컴포넌트를 맨 위에 가져와야합니다. 그러면 댓글이있는 게시물에 대한 댓글 섹션이 표시됩니다.
 

```js
import Comments from '../../components/comments'
```

이제 수동으로 입력 한 주석이 나열됩니다.
 훌륭하지만 대화 형은 아닙니다.
 사용자가 데이터 세트에 댓글을 제출할 수 있도록 페이지에 양식을 추가해 보겠습니다.
 

### 블로그 게시물에 댓글 양식 추가
 

댓글 양식에서 휠을 재발 명 한 이유는 무엇입니까?
 우리는 이미 Next.js를 사용하는 React 생태계에 있으므로이를 활용하는 것이 좋습니다.
 react-hook-form 패키지를 사용하지만 모든 양식 또는 양식 구성 요소가 사용됩니다.
 

먼저 패키지를 설치해야합니다.
 

```terminal
npm install react-hook-form
```

설치하는 동안 계속해서 Form 구성 요소를 설정할 수 있습니다.
 Post 컴포넌트에서 새로운`<Comments />`컴포넌트 바로 뒤에`<Form />`컴포넌트를 추가 할 수 있습니다.
 

```jsx
// ... Rest of the component
<Comments comments={post.comments} />
<Form _id={post._id} />
```

현재 게시물 `_id`값을 새 구성 요소에 전달하고 있습니다.
 이것이 우리의 댓글을 게시물에 연결하는 방법입니다.
 

주석 구성 요소와 마찬가지로`/ blog-frontend / components / form.js`에이 구성 요소에 대한 파일을 만들어야합니다.
 

```js
export default function Form ({_id}) {

  // Sets up basic data state
  const [formData, setFormData] = useState() 
        
  // Sets up our form states 
  const [isSubmitting, setIsSubmitting] = useState(false)
  const [hasSubmitted, setHasSubmitted] = useState(false)
        
  // Prepares the functions from react-hook-form
  const { register, handleSubmit, watch, errors } = useForm()

  // Function for handling the form submission
  const onSubmit = async data => {
    // ... Submit handler
  }

  if (isSubmitting) {
    // Returns a "Submitting comment" state if being processed
    return <h3>Submitting comment…</h3>
  }
  if (hasSubmitted) {
    // Returns the data that the user submitted for them to preview after submission
    return (
      <>
        <h3>Thanks for your comment!</h3>
        <ul>
          <li>
            Name: {formData.name} <br />
            Email: {formData.email} <br />
            Comment: {formData.comment}
          </li>
        </ul>
      </>
    )
  }

  return (
    // Sets up the Form markup
  )
}
```

이 코드는 주로 양식의 다양한 상태를 처리하기위한 상용구입니다.
 양식 자체는 우리가 반환하는 마크 업이 될 것입니다.
 

```js
// Sets up the Form markup
<form onSubmit={handleSubmit(onSubmit)} className="w-full max-w-lg" disabled>
  <input ref={register} type="hidden" name="_id" value={_id} />
         
  <label className="block mb-5">
    <span className="text-gray-700">Name</span>
    <input name="name" ref={register({required: true})} className="form-input mt-1 block w-full" placeholder="John Appleseed"/>
    </label>
                                                         
  <label className="block mb-5">
    <span className="text-gray-700">Email</span>
    <input name="email" type="email" ref={register({required: true})} className="form-input mt-1 block w-full" placeholder="your@email.com"/>
  </label>

  <label className="block mb-5">
    <span className="text-gray-700">Comment</span>
    <textarea ref={register({required: true})} name="comment" className="form-textarea mt-1 block w-full" rows="8" placeholder="Enter some long form content."></textarea>
  </label>
                                     
  {/* errors will return when field validation fails  */}
  {errors.exampleRequired && <span>This field is required</span>}
 
  <input type="submit" className="shadow bg-purple-500 hover:bg-purple-400 focus:shadow-outline focus:outline-none text-white font-bold py-2 px-4 rounded" />
</form>
```

이 마크 업에는 몇 가지 특별한 경우가 있습니다.
 먼저,`<form>`요소에는`handleSubmit ()`후크를 허용하는`onSubmit` 속성이 있습니다.
 패키지에서 제공하는 후크는 양식 제출을 처리하는 함수 이름을 사용합니다.
 

댓글 양식의 첫 번째 입력은 게시물의 `_id`를 포함하는 숨겨진 필드입니다.
 모든 필수 양식 필드는 `ref`속성을 사용하여 react-hook-form의 유효성 검사에 등록합니다.
 양식이 제출되면 제출 된 데이터로 무언가를해야합니다.
 이것이 우리의`onSubmit ()`함수의 목적입니다.
 

```js
// Function for handling the form submission
const onSubmit = async data => {
  setIsSubmitting(true)
        
  setFormData(data)
        
  try {
    await fetch('/api/createComment', {
      method: 'POST',
     body: JSON.stringify(data),
     type: 'application/json'
    })  
    setIsSubmitting(false)
    setHasSubmitted(true)
  } catch (err) {
    setFormData(err)
  }
}
```

이 기능에는 두 가지 주요 목표가 있습니다.
 

- 앞서 만든 상태로 제출하는 과정을 통해 양식의 상태를 설정합니다.
 
- `fetch ()`요청을 통해 서버리스 함수에 데이터를 제출합니다.
 Next.js에는`fetch ()`가 내장되어 있으므로 추가 패키지를 설치할 필요가 없습니다.
 

양식에서 제출 된 데이터 (양식 핸들러의`data` 인수)를 가져 와서 생성해야하는 서버리스 함수에 제출할 수 있습니다.
 

이를 Sanity API에 직접 게시 할 수 있지만 쓰기 액세스 권한이있는 API 키가 필요하며 프런트 엔드 외부의 환경 변수로이를 보호해야합니다.
 서버리스 기능을 사용하면 방문자에게 비밀 토큰을 노출하지 않고이 로직을 실행할 수 있습니다.
 

### Next.js API 경로를 사용하여 Sanity에 댓글 제출
 

자격 증명을 보호하기 위해 양식 처리기를 서버리스 함수로 작성합니다.
 Next.js에서는 "API 경로"를 사용하여 서버리스 기능을 만들 수 있습니다.
 이는`api` 디렉토리의`/ blog-frontent / pages` 디렉토리에있는 페이지 경로와 함께 있습니다.
 여기서`createComment.js`라는 새 파일을 만들 수 있습니다.
 

Sanity API에 쓰려면 먼저 쓰기 권한이있는 클라이언트를 설정해야합니다.
 이 데모의 앞부분에서 읽기 + 쓰기 토큰을 설정하고`/ blog-frontent / .env.local`에 넣었습니다.
 이 환경 변수는 이미`/ blog-frontend / lib / sanity.js`의 클라이언트 개체에서 사용 중입니다.
 토큰을 사용하여 미리보기 모드에 대해 게시되지 않은 변경 사항을 가져 오는 `previewClient`라는 이름으로 설정된 읽기 + 쓰기 클라이언트가 있습니다.
 

`createClient` 파일의 맨 위에서 서버리스 함수에서 사용할 개체를 가져올 수 있습니다.
 Next.js API 경로는 요청 및 응답 인수가있는 기본 함수로 핸들러를 내 보내야합니다.
 함수 내에서 요청 객체의 본문에서 양식 데이터를 분해하고이를 사용하여 새 문서를 만듭니다.
 

Sanity의 JavaScript 클라이언트에는 데이터 객체를받는`create ()`메서드가 있습니다.
 데이터 객체에는 저장하려는 데이터와 함께 생성하려는 문서 유형과 일치하는`_type`이 있어야합니다.
 이 예에서는 이름, 이메일, 댓글을 전달합니다.
 

게시물의`_id`를 Sanity의 게시물에 대한 참조로 바꾸려면 약간의 추가 작업이 필요합니다.
 `post`속성을 참조로 정의하고 `_id`를이 개체의 `_ref`속성으로 지정합니다.
 API에 제출 한 후 Sanity의 응답에 따라 성공 상태 또는 오류 상태를 반환 할 수 있습니다.
 

```js
// This Next.js template already is configured to write with this Sanity Client
import {previewClient} from '../../lib/sanity'

export default async function createComment(req, res) {
  // Destructure the pieces of our request
  const { _id, name, email, comment} = JSON.parse(req.body)
  try {
    // Use our Client to create a new document in Sanity with an object  
    await previewClient.create({
      _type: 'comment',
      post: {
        _type: 'reference',
        _ref: _id,
      },
     name,
     email,
     comment
    })
  } catch (err) {
    console.error(err)
    return res.status(500).json({message: `Couldn't submit comment`, err})
  }
    
  return res.status(200).json({ message: 'Comment submitted' })
}
```

이 서버리스 기능이 배치되면 블로그 게시물로 이동하여 양식을 통해 의견을 제출할 수 있습니다.
 승인 프로세스가 마련되어 있으므로 의견을 제출 한 후 Sanity Studio에서 검토하고 승인, 거부 또는 보류 상태로 둘 수 있습니다.
 

### 댓글 엔진을 더욱 발전 시키세요
 

이것은 우리에게 코멘트 시스템의 기본 기능을 제공하고 우리의 콘텐츠와 직접적으로 연결됩니다.
 이 흐름의 양쪽을 제어 할 때 많은 잠재력이 있습니다.
 이 주석 엔진을 더 발전시키기위한 몇 가지 아이디어가 있습니다.
 

- SendGrid 또는 기타 메일 서비스를 사용하여 새 메시지에 대한 전자 메일 알림을 만들고 보냅니다.
 
- Sanity의 구조 빌더를 사용하여 승인 됨, 승인되지 않음 및 보류중인 주석을 표시하는 Sanity Studio API 섹션.
 
- Google의 보이지 않는 reCAPTCHA로 스팸 방지를 구현하세요.
 
- 댓글이 저장되면 Gravatar와 통합됩니다.
 