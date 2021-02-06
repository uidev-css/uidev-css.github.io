---
layout: post
title: "CSS를 사용한 배경 필터 효과"
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/07/bitton-background-filter.png"
tags: BACKDROP-FILTER
---


나는 잘 알려지지 않은 속성을 사용하여 CSS의 한 줄로 까다로운 디자인으로 해결되는 이 작은 게시물들을 좋아한다. 이 경우 설계는 프로스트 글라스 효과이고 CSS 속성은 백드롭 필터이다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/07/js572vt4pnpd3yqc7t7x.png.jpeg?resize=800%2C557&ssl=1)

접근법? 쉬운 평화:

```css
.container {
  backdrop-filter: blur(10px);
}
```

게시물의 댓글은 교차 브라우저 지원 문제를 다루고 있기 때문에 검토할 가치가 있습니다. 커버력은 사실 꽤 괜찮죠. Caniuse는 Firefox(그리고 예상대로 Internet Explorer)에 대한 지원이 부족한 전 세계 커버리지 83%를 보여주고 있다. 한 논평가는 그 효과를 약화시키는 작은 조정과 함께 멋진 단점을 제시했다.

```css
.container {
  background: rgba(0,0,0,0.8);
  backdrop-filter: saturate(180%) blur(10px);
}
```

좋아요. 하지만 우리의 `배경 필터` 알마낙 입구에서 보여지듯이 `@supports`를 그 안에 뿌리면 조금 더 나아갈 수 있어요.

```css
.container {
  background: rgba(0,0,0,0.8);
}

@supports (-webkit-backdrop-filter: none) or (backdrop-filter: none) {
  .container {
    -webkit-backdrop-filter: blur(10px);
    backdrop-filter: blur(10px);
  }
}
```

그 안에 있는 `-webkit` 접두사를 보세요. 오토프리서(Autopfixer)에 연결되어 있다고 해서 큰 문제는 아니지만, 여전히 프로덕션에서 사용할 가치가 있습니다. 여기 연감에서 나온 데모입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_PwRPZa" src="//codepen.io/anon/embed/PwRPZa?height=450&amp;theme-id=1&amp;slug-hash=PwRPZa&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed PwRPZa" title="CodePen Embed PwRPZa" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

좋아요, 그럼 한 줄짜리 해결책은 아닌 것 같군요. 하지만 CSS에서는 이런 종류의 것이 비교적 사소한 것이 멋집니다.

직접 링크 →