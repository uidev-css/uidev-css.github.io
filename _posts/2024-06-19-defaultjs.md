---
title: "디폴트js"
description: ""
coverImage: "/assets/img/2024-06-19-defaultjs_0.png"
date: 2024-06-19 00:56
ogImage:
  url: /assets/img/2024-06-19-defaultjs_0.png
tag: Tech
originalTitle: "default.js"
link: "https://nextjs.org/docs/app/api-reference/file-conventions/default"
---

# default.js

default.js 파일은 Next.js에서 전체 페이지 로드 후 슬롯의 활성 상태를 복구할 수 없을 때 병렬 경로 내에서 폴백을 렌더링하는 데 사용됩니다.

소프트 네비게이션 중에 Next.js는 각 슬롯에 대한 활성 상태(하위 페이지)를 추적합니다. 그러나 전체 페이지 로드 시 하드 네비게이션의 경우 Next.js는 활성 상태를 복구할 수 없습니다. 이 경우 현재 URL과 일치하지 않는 하위 페이지에 대해 default.js 파일을 렌더링할 수 있습니다.

다음과 같은 폴더 구조를 고려해보세요. @team 슬롯에는 설정 페이지가 있지만 @analytics에는 없습니다.

<div class="content-ad"></div>

<img src="/assets/img2024-06-19-defaultjs_0.png" />

/settings으로 이동하면 @team 슬롯은 설정 페이지를 렌더링하면서 @analytics 슬롯의 현재 활성 페이지를 유지합니다.

새로고침하면 Next.js가 @analytics에 default.js를 렌더링합니다. default.js가 없는 경우 404가 대신 렌더링됩니다.

추가로 children이 암시적인 슬롯인데, 부모 페이지의 활성 상태를 복원할 수 없을 때 Next.js가 대체 화면을 렌더링하기 위해 default.js 파일을 만들어야 합니다.

<div class="content-ad"></div>

## Props

### params (선택사항)

루트 세그먼트부터 슬롯 하위 페이지까지의 동적 라우트 매개변수가 포함된 객체입니다. 예를 들어:

```markdown
| Example                                  | URL        | params                            |
| ---------------------------------------- | ---------- | --------------------------------- |
| app/@sidebar/[artist]/default.js         | /zack      | { artist: 'zack' }                |
| app/@sidebar/[artist]/[album]/default.js | /zack/next | { artist: 'zack', album: 'next' } |
```
