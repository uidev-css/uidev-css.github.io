---
title: "노선 정의하기"
description: ""
coverImage: "/assets/img/2024-06-19-DefiningRoutes_0.png"
date: 2024-06-19 06:52
ogImage:
  url: /assets/img/2024-06-19-DefiningRoutes_0.png
tag: Tech
originalTitle: "Defining Routes"
link: "https://nextjs.org/docs/app/building-your-application/routing/defining-routes"
---

# 루트 정의

> 계속하기 전에 라우팅 기본 사항 페이지를 읽기를 권장합니다.

이 페이지에서는 Next.js 어플리케이션에서 루트를 정의하고 구성하는 방법을 안내해 드립니다.

## 루트 생성

<div class="content-ad"></div>

Next.js(넥스트.제이에스)는 파일 시스템을 기반으로 하는 라우터를 사용합니다. 여기서 폴더는 경로를 정의하는 데 사용됩니다.

각 폴더는 URL 세그먼트에 매핑되는 경로 세그먼트를 나타냅니다. 중첩 된 경로를 만들려면 서로에게 폴더를 중첩시킬 수 있습니다.

이미지 파일
![이미지](/assets/img2024-06-19-DefiningRoutes_0.png)

특별한 page.js 파일을 사용하여 경로 세그먼트를 공개적으로 접근할 수 있습니다.

<div class="content-ad"></div>


![이미지](/assets/img2024-06-19-DefiningRoutes_1.png)

이 예시에서 /dashboard/analytics URL 경로는 공개적으로 접근할 수 없습니다. 왜냐하면 해당 페이지에 대응하는 page.js 파일이 없기 때문입니다. 이 폴더는 컴포넌트, 스타일시트, 이미지 또는 다른 동료 파일을 저장하는 데 사용될 수 있습니다.

> 참고: 특별한 파일에는 .js, .jsx 또는 .tsx 파일 확장자를 사용할 수 있습니다.

## UI 생성


<div class="content-ad"></div>

특별 파일 규칙을 사용하여 각 경로 세그먼트에 UI를 생성합니다. 가장 흔한 것은 경로에 고유한 UI를 보여주는 페이지이고, 여러 경로에서 공유되는 UI를 보여주는 레이아웃입니다.

예를 들어, 첫 번째 페이지를 만들기 위해 앱 디렉토리 내에 page.js 파일을 추가하고 React 컴포넌트를 내보냅니다:

```js
export default function Page() {
  return <h1>안녕, Next.js!</h1>;
}
```
