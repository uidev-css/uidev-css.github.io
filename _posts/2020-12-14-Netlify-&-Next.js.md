---
layout: post
title: "Netlify 및 Next.js
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/12/nextplugin.png
tags: 
---


Cassidy Williams는 Netlify 블로그에서 Blogvent (한 달 동안 매일 블로깅)를하고 있습니다.
 많은 블로그 게시물이 Next.js에 관한 것입니다.
 Next.js에 대해 좋아할 것이 많이 있습니다.
 방금 캐시디의 스타터 중 하나를 재미로 뽑았습니다.
 React Fast-Refresh가 내장되어 있다는 것이 매우 좋습니다.
 나는 어떤 "페이지"에서 가져 와서`<Head>`를 사용하여`<head>`에있는 것을 제어하는 방법을 좋아합니다.
 이것이 넥스트와의 첫 작은 플레이 였으니, 내 기본을 용서해주세요.
 

하지만 Next.js의 가장 매력적인 점은 전체 렌더링 스펙트럼을 얼마나 쉽게 지원하는지입니다.
 기본적으로 정적 파일 렌더링 (스마트)을 수행하도록 권장하고, 서버 측 렌더링 (SSR)을 수행해야하는 경우 주어진 페이지 구성 요소를 업데이트하여 다음을 갖도록합니다.
 

```js
export async function getServerSideProps() {
  // Fetch data from external API
  const res = await fetch(`https://.../data`)
  const data = await res.json()

  // Pass data to the page via props
  return { props: { data } }
}
```

페이지를 렌더링하기 위해 데이터를 위해 서버에 접속해야하기 때문에 SSR을 수행하고 있지만 필요한 경우 JavaScript없이 페이지를 빠르게 렌더링 할 수 있도록 서버 측에서 수행하는 것을 선호한다고 가정합니다 (SEO에 적합).
 ).
 그것은 노드 서버가 작업을 수행 할 준비가되어 있다고 가정합니다.
 Netlify에서 이는 함수 (노드 Lambda)를 의미하지만`netlify.toml` 파일에 다음을 입력하기 때문에 거의 생각할 필요가 없습니다.
 

```netlify.toml
[[plugins]]
  package = "@netlify/plugin-nextjs"
```

이제 필요한 곳에서는 정적이고 필요한 곳에서는 서버에서 렌더링 할 수 있지만 클라이언트 측 렌더링도 포기하지 않습니다. 사이트가 모두 부팅 된 후 훌륭하고 빠릅니다.
 나는 그것이 JSON이나 무언가, 프레임 워크 마술을 쏘고 있다고 생각합니다.
 

내 홈페이지에서 빠른 SSR 경로를 설정하여 플레이를했고, 내 홈페이지 (정적)와 `/ cool`경로 (SSR) 모두로드시 정적 HTML을 반환한다는 것을 분명히 알 수 있습니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/12/Screen-Shot-2020-12-14-at-2.18.49-PM.png?resize=1024%2C925&ssl=1)

나는 React에서 일하는 것을 좋아하고 Next.js는 단순성과 힘의 균형 때문에 그것을 할 수있는 멋진 프레임 워크입니다.
 Netlify에서 매우 쉽게 실행된다는 점이 좋습니다.
 