---
layout: post
title: "머리글에 ID 추가 시"
author: "Uidev Css"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/06/hashes-pattern.png"
tags: 
---


여기 2초짜리 리뷰가 있습니다. 요소에 ID가 있는 경우 자연스러운 브라우저 동작으로 요소에 연결할 수 있습니다. 종종 특정 내용 섹션에 직접 연결하는 것이 유용하기 때문에 제목에 이러한 내용이 있는 경우 유용합니다.

```html
<h3 id="step-2">Step 2</a>
```

내가 그렇게 마음이 내키면 이 제목에 바로 연결할 수 있다. https://my-website.com/#step-2와 같은 URL이나 다음과 같은 온페이지 링크에서 찾을 수 있다.

```html
<a href="#step-2">Jump to Step 2</a>
```

따라서 모든 헤더가 고유한 ID를 갖는 것이 좋습니다.

그러나 모든 머리글에 수동으로 ID를 추가하는 것은 너무 많은 작업임을 알게 되었습니다. 수년 동안 바로 이 사이트에서 jQuery를 사용하여 다음과 같이 했습니다.

```js
// Adjust this for targetting the headers important to have IDs
const $headers = $(".article-content > h3");

$headers.each((i, el) => {
  const $el = $(el);

  // Probably a flexbox layout style page
  if ($el.has("a").length != 0) {
    return;
  }

  let idToLink = "";

  if ($el.attr("id") === undefined) {
    // give it ID
    idToLink = "article-header-id-" + i;
    $el.attr("id", idToLink);
  } else {
    // already has ID
    idToLink = $el.attr("id");
  }

  const $headerLink = $("<a />", {
    html: "#",
    class: "article-headline-link",
    href: "#" + idToLink
  });

  $el.addClass("has-header-link").prepend($headerLink);
});
```

이 스크립트는 ID를 추가하는 것보다 한 단계 더 나아가 해당 제목에 연결되는 제목 바로 안에 # 링크를 추가합니다. 여기서 중요한 것은 헤더에 ID가 있고 마우스 오른쪽 버튼 복사 링크와 같은 작업을 쉽게 수행할 수 있다는 것입니다. 여기 데모가 있습니다. 보고 싶으시다면요.

문제! 갑자기 이게 작동을 멈췄어요.

대본 자체가 아니라, 그게 잘 되는데요. 그러나 페이지가 로드될 때 브라우저가 머리글으로 이동할 수 있도록 하는 기본 브라우저 동작은 중지된 것입니다. 레이스 조건이라고 생각합니다.

- HTML이 도착하다.
- 페이지가 렌더링하기 시작합니다.
- 브라우저가 아래로 스크롤할 URL에서 ID를 찾고 있습니다.
- 찾을 수 없어...
- 오, 저기서 기다려!
- 저기로 스크롤하세요.

Oh wait it is! 단계는 ID를 제목에 넣고 실행하는 스크립트의 단계입니다. 동적 삽입 링크로 이동하지 않는 브라우저 탓은 없습니다. 이게 그렇게 오랫동안 효과가 있었다는 게 놀랍네요.

HTML이 도착할 때쯤이면 아이디를 표제로 하는 것이 훨씬 낫다. 이 사이트는 워드프레스라서 어떤 종류의 콘텐츠 필터로 할 수 있을 줄 알았어요. 제가 신경 쓸 필요도 없었던 것은 물론, 거기에 대한 플러그인이 있기 때문입니다: Karolína Vysko➡ilová의 앵커 링크 추가. 나한테는 잘된 일이야. 앵커링크 자체에 아이디를 추가해 주는 것도 전혀 문제가 없다는 게 기술이다. 기존 아이디로 장난치는 걸 피하는 또 다른 방법인 것 같아.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/06/Screen-Shot-2020-06-11-at-10.50.01-AM.png?fit=1016%2C1024&ssl=1)

만약 내가 WordPress를 가지고 있지 않았다면, 나는 HTML 서버측을 처리해서 어떤 종류의 헤딩 링크가 발생하는지 확인할 수 있는 다른 방법을 찾아냈을 것이다. 하늘이 무너져도 솟아날 구멍이 있다. 사실, 빌드 프로세스나 서버측 필터에서 너무 이상하거나 번거롭거나 할 일이 있다면, 저는 서비스 직원에 가서 하는 것을 볼 것입니다. 저는 Cloudflare의 HTMLRewriter를 가지고 재미있게 놀았습니다. 이 모든 것이 가능합니다.