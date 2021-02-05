---
layout: post
title: "AVIF가 착륙했습니다."
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/09/Screen-Shot-2020-09-08-at-2.07.31-PM.png
tags: AVIF,IMAGE COMPRESSION,IMAGE FORMATS
---


오늘 제이크의 블로그 게시물 때문에 모두가 AVIF에 대해 이야기하고 있다. 제가 AVIF를 배웠을 때 저는 오늘 이었습니다. 하지만 웹 기술이 한 번 앞서고 있기 때문에, 우리는 이미 그것을 이용할 수 있습니다.

응답성이 높은 이미지 구문을 추상화한 경우 이 작업이 더 쉬워집니다. `<그림>`을 사용하는 어디에서나 지원 브라우저가 이를 가져오고 비지원 브라우저가 다음을 수행하지 못하도록 `그림`을 슬립할 수 있습니다.

```html
<picture>
  <!-- use if possible -->
  <source type="image/avif" srcset="snow.avif">

  <!-- fallback -->
  <img alt="Hut in the snow" src="snow.jpg">
</picture>
```

지금 당장 가지고 놀래? Jake는 스푸쉬가 그것을 지지하도록 업데이트했다. 코드펜도 이를 지원합니다. 여기 펜이 있습니다. 쇼의 원작을 지웠습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 650px;"><iframe id="cp_embed_QWNQrzy" src="//codepen.io/anon/embed/QWNQrzy?height=650&amp;theme-id=1&amp;slug-hash=QWNQrzy&amp;default-tab=result" height="650" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed QWNQrzy" title="CodePen Embed QWNQrzy" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

Pug HTML에서 다른 소스들을 찾아보세요. 입력한 이미지의 URL이 CodePen의 Asset Hosting에 호스트되면 모든 변환이 자동으로 수행됩니다. 이미지는 변환 작업을 수행하는 Cloudflare Worker를 거치며 AVIF를 지원합니다. 새 이미지의 경우 AVIF가 캐시되기 전에 해당 첫 번째 요청에 대한 응답 시간 지연이 훨씬 더 많은 작업이 필요한 것처럼 느껴질 수 있습니다.

다른 형식과 마찬가지로 이미지 유형에 따라 다릅니다. 장난을 치면서 이미 압축된 JPG를 소스로 넣었는데 AVIF가 버전 크기를 두 배 이상 늘렸습니다. 그래서 여러분은 그것을 사용함으로써 일을 더디게 만들지 않도록 조심해야 할 거예요.

우리는 지금까지 새로운 이미지 포맷으로 만족해왔습니다. WebP는 거의 항상 최상의 형식이기 때문에 대부분의 논리는 if (webp_supported) {usage_webp}의 길을 걸어왔다. 하지만 지금은 AVIF가 더 작을 뿐만 아니라 압축하는 방식도 다른 시각적 결과를 낳기 때문에 크기가 작아도 외모가 마음에 들지 않을 수 있습니다.

내 이상적인 시나리오는 항상 `?format=auto`가 있는 일종의 이미지 CDN입니다.

직접 링크 →