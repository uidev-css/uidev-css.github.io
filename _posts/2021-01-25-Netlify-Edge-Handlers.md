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

그래서 어떤 종류의 JavaScript를 작성하고 있습니까?
 꽤 집중되어 있습니다.
 95 %의 시간이 원래 응답을 완전히 대체한다고 생각합니다.
 마찬가지로 사이트의`/ blog`에 대한 HTML은 말 그대로 다음과 같습니다.

<pre rel="HTML" class="wp-block-csstricks-code-block  language-html" data-line=""><code markup="tt" class=" language-html">`&lt;!DOCTYPE html&gt;<br>&lt;html lang="en"&gt;<br>&lt;head&gt;<br>  &lt;meta charset="UTF-8"&gt;<br>  &lt;meta name="viewport" content="width=device-width, initial-scale=1.0"&gt;<br>  &lt;title&gt;Test a Netlify Edge Function&lt;/title&gt;<br>&lt;/head&gt;<br>&lt;body&gt;<br>  &lt;div id="blog-posts"&gt;&lt;/div&gt;<br>&lt;/body&gt;<br>&lt;/html&gt;`</code></pre>

Edge Handler를 사용하면 원래 응답을 얻고 클라우드 데이터를 호출하고 직감을 블로그 게시물로 대체하는 것이 특히 어렵지 않습니다.

<pre rel="JavaScript" class="wp-block-csstricks-code-block  language-javascript" data-line=""><code markup="tt" class=" language-javascript">`export function onRequest(event) {<br>  event.replaceResponse(async () =&gt; {<br>    // Get the original response HTML<br>    const originalRequest = await fetch(event.request);<br>    const originalBody = await originalRequest.text();<br><br>    // Get the data<br>    const cloudRequest = await fetch(<br>      `https://css-tricks.com/wp-json/wp/v2/posts`<br>    );<br>    const data = await cloudRequest.json();<br><br>    // Replace the empty div with content<br>    // Maybe you could use Cheerio or something for more robustness<br>    const manipulatedResponse = originalBody.replace(<br>      `&lt;div id="blog-posts"&gt;&lt;/div&gt;`,<br>      `<br>        &lt;h2&gt;<br>          &lt;a href="${data[0].link}"&gt;${data[0].title.rendered}&lt;/a&gt;<br>        &lt;/h2&gt;<br>        ${data[0].excerpt.rendered}<br>      `<br>    );<br><br>    let response = new Response(manipulatedResponse, {<br>      headers: {<br>        "content-type": "text/html",<br>      },<br>      status: 200,<br>    });<br><br>    return response;<br>  });<br>}`</code></pre>

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

<pre rel="Command Line" class="wp-block-csstricks-code-block  language-none" data-line=""><code markup="tt" class=" language-none">`netlify dev --trafficMesh`</code></pre>

… 개발과 배포 모두에서 훌륭하게 작동했습니다.

Netlify 대시 보드에서도 설정할 수있는`console.log ()`모든 항목 :

내 작동 에지 핸들러가있는 저장소가 있습니다.