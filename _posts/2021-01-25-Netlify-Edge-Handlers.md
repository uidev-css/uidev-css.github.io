---
layout: post
title: "Netlify Edge 핸들러"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2021/01/edge-handler.jpg
tags: NETLIFY,NETLIFY EDGE HANDLERS
---


Netlify Edge Handlers는 Early Access에 있지만 (요청 가능) 매우 멋지고 지금은 당신의 두뇌를 감싸는 가치가 있다고 생각합니다.
 나는 그들이 Jamstack의 성격을 바꾸고 있다고 생각합니다.

CDN에 대해 알고 있습니다.
 그들은 글로벌합니다.
 그들은 지리적으로 사람들과 가까운 자산을 호스팅하므로 웹 사이트가 더 빨라집니다.
 Netlify는 모든 작업을 수행합니다.
 CDN에 더 많이 넣을수록 좋습니다.
 Jamstack은 사전 렌더링 된 콘텐츠뿐만 아니라 자산이 글로벌 CDN에 있어야한다는 개념을 홍보합니다.
 속도는 그것의 주요 이점입니다.

Jamstack과 CDN의 정신적 수학은 전통적으로 다음과 같이 진행되었습니다. 저는 절충안을 만들고 있습니다.
 속도를 위해 글로벌 CDN에 있기를 원하기 때문에 렌더링 시간이 아니라 빌드 시간에 더 많은 작업을 수행하고 있습니다.
 하지만 그렇게하면서 서버 사용의 동적 인 힘을 잃고 있습니다.
 또는 여전히 동적 작업을 수행하고 있지만 클라이언트에서 렌더링 할 때 수행해야하기 때문에 수행합니다.

그 수학이 변하고 있습니다.
 Edge Handlers가 말하는 것은 : 그 트레이드 오프를 할 필요가 없다는 것입니다.
 동적 서버 작업을 수행하고 글로벌 CDN을 유지할 수 있습니다.
 여기에 예가 있습니다.

- 사이트 영역이`/ blog`에 있고 클라우드 데이터베이스 어딘가에있는 최근 블로그 게시물을 반환하고 싶습니다.
 이 Edge Handler는 `/ blog`에서만 실행하면되므로 해당 URL에서만 실행되도록 Edge Handler를 구성합니다.
- 자바 스크립트 파일에서 해당 게시물을 `가져 오기`하는 코드를 작성하고 `/edge-handlers/getBlogPosts.js`에 넣습니다.
- 이제 빌드하고 배포 할 때 해당 코드는 해당 URL에서만 실행되고 작업을 수행합니다.

그래서 어떤 종류의 JavaScript를 작성하고 있습니까?
 꽤 집중되어 있습니다.
 95 %의 시간이 원래 응답을 완전히 대체한다고 생각합니다.
 마찬가지로 사이트의`/ blog`에 대한 HTML은 말 그대로 다음과 같습니다.

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Test a Netlify Edge Function</title>
</head>
<body>
  <div id="blog-posts"></div>
</body>
</html>
```

Edge Handler를 사용하면 원래 응답을 얻고 클라우드 데이터를 호출하고 직감을 블로그 게시물로 대체하는 것이 특히 어렵지 않습니다.

```js
export function onRequest(event) {
  event.replaceResponse(async () => {
    // Get the original response HTML
    const originalRequest = await fetch(event.request);
    const originalBody = await originalRequest.text();

    // Get the data
    const cloudRequest = await fetch(
      `https://css-tricks.com/wp-json/wp/v2/posts`
    );
    const data = await cloudRequest.json();

    // Replace the empty div with content
    // Maybe you could use Cheerio or something for more robustness
    const manipulatedResponse = originalBody.replace(
      `<div id="blog-posts"></div>`,
      `
        <h2>
          <a href="${data[0].link}">${data[0].title.rendered}</a>
        </h2>
        ${data[0].excerpt.rendered}
      `
    );

    let response = new Response(manipulatedResponse, {
      headers: {
        "content-type": "text/html",
      },
      status: 200,
    });

    return response;
  });
}
```

(이 사이트의 REST API를 예제 클라우드 데이터 저장소로 사용하고 있습니다.)

일부 데이터를 요청한 후 DOM을 조작하는 대신 응답이 브라우저에 처음으로 전달되기 전에 발생한다는 점을 제외하면 클라이언트 측 `가져 오기`와 매우 유사합니다.
 CDN 자체 ( "엣지")에서 실행되는 코드입니다.

따라서 응답하기 전에 추가 네트워크 요청을해야하기 때문에 사전 렌더링 된 CDN 콘텐츠보다 느려 야합니다.
 약간의 오버 헤드가 있지만 생각보다 빠릅니다.
 네트워크 요청은 네트워크 자체에서 발생하므로 연기가 나는 빠른 네트워크에서 빠른 컴퓨터를 연기합니다.
 아마도 몇 밀리 초가 될 것입니다.
 어쨌든 50ms의 실행 시간 만 허용됩니다.

액세스 권한이 부여 된 계정에서이 모든 것을 실행하고 실행할 수있었습니다.
 다음을 사용하여 로컬에서 테스트 할 수 있다는 것이 매우 좋습니다.

```Command Line
netlify dev --trafficMesh
```

… 개발과 배포 모두에서 훌륭하게 작동했습니다.

<img loading="lazy" width="1690" height="1248" src="https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-19-at-10.13.17-AM.png?resize=1690%2C1248&amp;ssl=1" alt="" class="wp-image-333062 jetpack-lazy-image" data-recalc-dims="1" data-lazy-srcset="https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-19-at-10.13.17-AM.png?w=1690&amp;ssl=1 1690w, https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-19-at-10.13.17-AM.png?resize=300%2C222&amp;ssl=1 300w, https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-19-at-10.13.17-AM.png?resize=1024%2C756&amp;ssl=1 1024w, https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-19-at-10.13.17-AM.png?resize=768%2C567&amp;ssl=1 768w, https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-19-at-10.13.17-AM.png?resize=1536%2C1134&amp;ssl=1 1536w, https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-19-at-10.13.17-AM.png?resize=1000%2C738&amp;ssl=1 1000w" data-lazy-sizes="(min-width: 735px) 864px, 96vw" data-lazy-src="https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-19-at-10.13.17-AM.png?resize=1690%2C1248&amp;is-pending-load=1#038;ssl=1" srcset="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7"><noscript><img loading="lazy" width="1690" height="1248" src="https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-19-at-10.13.17-AM.png?resize=1690%2C1248&#038;ssl=1" alt="" class="wp-image-333062" srcset="https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-19-at-10.13.17-AM.png?w=1690&amp;ssl=1 1690w, https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-19-at-10.13.17-AM.png?resize=300%2C222&amp;ssl=1 300w, https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-19-at-10.13.17-AM.png?resize=1024%2C756&amp;ssl=1 1024w, https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-19-at-10.13.17-AM.png?resize=768%2C567&amp;ssl=1 768w, https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-19-at-10.13.17-AM.png?resize=1536%2C1134&amp;ssl=1 1536w, https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-19-at-10.13.17-AM.png?resize=1000%2C738&amp;ssl=1 1000w" sizes="(min-width: 735px) 864px, 96vw" data-recalc-dims="1" /></noscript>

Netlify 대시 보드에서도 설정할 수있는`console.log ()`모든 항목 :

<img loading="lazy" width="2276" height="1682" src="https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-19-at-10.14.22-AM.png?resize=2276%2C1682&amp;ssl=1" alt="" class="wp-image-333064 jetpack-lazy-image" data-recalc-dims="1" data-lazy-srcset="https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-19-at-10.14.22-AM.png?w=2276&amp;ssl=1 2276w, https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-19-at-10.14.22-AM.png?resize=300%2C222&amp;ssl=1 300w, https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-19-at-10.14.22-AM.png?resize=1024%2C757&amp;ssl=1 1024w, https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-19-at-10.14.22-AM.png?resize=768%2C568&amp;ssl=1 768w, https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-19-at-10.14.22-AM.png?resize=1536%2C1135&amp;ssl=1 1536w, https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-19-at-10.14.22-AM.png?resize=2048%2C1514&amp;ssl=1 2048w, https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-19-at-10.14.22-AM.png?resize=1000%2C739&amp;ssl=1 1000w" data-lazy-sizes="(min-width: 735px) 864px, 96vw" data-lazy-src="https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-19-at-10.14.22-AM.png?resize=2276%2C1682&amp;is-pending-load=1#038;ssl=1" srcset="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7"><noscript><img loading="lazy" width="2276" height="1682" src="https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-19-at-10.14.22-AM.png?resize=2276%2C1682&#038;ssl=1" alt="" class="wp-image-333064" srcset="https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-19-at-10.14.22-AM.png?w=2276&amp;ssl=1 2276w, https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-19-at-10.14.22-AM.png?resize=300%2C222&amp;ssl=1 300w, https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-19-at-10.14.22-AM.png?resize=1024%2C757&amp;ssl=1 1024w, https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-19-at-10.14.22-AM.png?resize=768%2C568&amp;ssl=1 768w, https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-19-at-10.14.22-AM.png?resize=1536%2C1135&amp;ssl=1 1536w, https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-19-at-10.14.22-AM.png?resize=2048%2C1514&amp;ssl=1 2048w, https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-19-at-10.14.22-AM.png?resize=1000%2C739&amp;ssl=1 1000w" sizes="(min-width: 735px) 864px, 96vw" data-recalc-dims="1" /></noscript>

내 작동 에지 핸들러가있는 저장소가 있습니다.