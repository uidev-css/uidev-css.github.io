---
layout: post
title: "투명 텍스트 클리핑에서 이모티콘 제외"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2018/05/emoji-trio.jpg
tags: EMOJI,HOVER,LINKS
---


CSS-Tricks는 이렇게 멋진 스타일의 링크들을 가지고 있다. 기본적으로 텍스트는 상당히 일반적인 파란색입니다. 하지만 링크들을 맴돌면, 그것들은 선형 구배들로 채워집니다.

꽤 깔끔하죠? 그리고 그 속임수는 그렇게 복잡하지 않다. 대기 중...

- 링크에 선형 그라데이션 배경을 제공합니다.
- 텍스트에 배경을 자르고
- 텍스트에 투명한 채우기를 부여하여 배경을 표시합니다.

CSS에서는 다음과 같습니다.

```css
a {
  color: #007db5;
}

a:hover {
  background: linear-gradient(90deg,#ff8a00,#e52e71);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}
```

현재 필요한 `-webkit-` 접두사를 참고하십시오. 여기 CSS-Tricks에 대한 실제 구현에는 조금 더 많은 것이 있습니다. 하지만 이 작은 조각은 우리가 찾고자 하는 것을 우리에게 가져다 줍니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 350px;"><iframe id="cp_embed_oNxwXwo" src="//codepen.io/anon/embed/oNxwXwo?height=350&amp;theme-id=1&amp;slug-hash=oNxwXwo&amp;default-tab=result" height="350" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed oNxwXwo" title="CodePen Embed oNxwXwo" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

하지만 여기서 중요한 건 그게 아니야. 바로 요전 날, 브래드 웨스트폴이 전화를 걸어 이 기술이 다른 텍스트와 마찬가지로 공기부양에 투명하게 채워지는 이모티콘에도 적용된다는 것을 알려주었습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 350px;"><iframe id="cp_embed_JjXyOLZ" src="//codepen.io/anon/embed/JjXyOLZ?height=350&amp;theme-id=1&amp;slug-hash=JjXyOLZ&amp;default-tab=result" height="350" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed JjXyOLZ" title="CodePen Embed JjXyOLZ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

그는 그것이 우리 게시물 중 한 곳의 링크에서 일어나는 것을 알아챘다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/08/Screen-Shot-2020-08-28-at-11.50.51-AM.png?resize=1126%2C106&ssl=1)

최악은 아니야. 그리고 그것은 완전히 이치에 맞는다. 내 말은, 이모티콘은 다른 글씨처럼 글씨체 안에 있는 글씨체잖아? 그것들은 우연히 컬러 폰트이며 이미지의 형태를 취하게 됩니다. 물론 이런 상황에서는 다른 글리프처럼 취급될 수 있습니다. 이 글리프들은 충만감을 없애기 위해서죠.

그러나 이모티콘에 색을 그대로 유지하는 것이 필수 조건이라면 이모티콘을 스팬으로 감싸 다시 채우기를 초기 상태로 설정함으로써 해결할 수 있다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 350px;"><iframe id="cp_embed_wvGeKyW" src="//codepen.io/anon/embed/wvGeKyW?height=350&amp;theme-id=1&amp;slug-hash=wvGeKyW&amp;default-tab=result" height="350" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed wvGeKyW" title="CodePen Embed wvGeKyW" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

하지만 누가 링크에 이모지가 나타날 때마다 스팬을 쓰고 싶어할까? 👎

CSS 솔루션을 찾고 계신다면 운이 없으실 겁니다. 그러나 CSS 글꼴 모듈 레벨 4 사양에는 제안된 글꼴 변형-emoji 속성에 대한 정의가 포함되어 있다. 하지만, 지금은 별로 (찾을 수 있는) 것이 없고, 이런 종류의 것을 위해 디자인된 것처럼 보이지 않습니다. 제안과 관련된 몇 가지 논의를 간단히 훑어보면, 일부 브라우저나 시스템이 유니코드를 이모티콘으로 자동 변환하는 방법과 그 동작을 제어하는 방법이 더 중요함을 알 수 있습니다.

색 글꼴을 제어하는 방법인 것처럼 보이는 동일한 초안 사양에서 글꼴 팔레트에 대한 제안된 정의가 있습니다. 이것이 결국 이모티콘입니다. 하지만 이것도 해결책이 아닙니다.

그것은 이모지의 충만함이 스팬 없이 바뀌는 것을 막는 유일한 방법은 일종의 자바스크립트 솔루션인 것 같다. WordPress, Dropbox, Facebook, Twitter와 같은 서비스를 살펴보세요. 그들은 모두 그들만의 맞춤형 이모티콘 세트를 구현한다. 그리고 그들은 무엇을 사용하나요? 이미지들

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/08/Screen-Shot-2020-08-28-at-11.32.07-AM.png?resize=1024%2C843&ssl=1)

그것이 그것을 하는 한 가지 방법이 될 것이다. 이모지가 이미지(이 특정 예에서 SVG)로 대체된 경우 링크 텍스트와 함께 채워지는 것은 확실히 제외됩니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 350px;"><iframe id="cp_embed_poywgBB" src="//codepen.io/anon/embed/poywgBB?height=350&amp;theme-id=1&amp;slug-hash=poywgBB&amp;default-tab=result" height="350" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed poywgBB" title="CodePen Embed poywgBB" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

아니면, 왜 우리가 그 상황에 빠지는 것을 막고 링크 바깥에 매달리는 것을 막지 않는가?

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 350px;"><iframe id="cp_embed_mdPwepd" src="//codepen.io/anon/embed/mdPwepd?height=350&amp;theme-id=1&amp;slug-hash=mdPwepd&amp;default-tab=result" height="350" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed mdPwepd" title="CodePen Embed mdPwepd" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

그게 우리가 줄곧 걸었어야 할 길일 거야. 하지만 이모지는 연결의 시작이나 끝에 오는 것이 아니라 중간 어딘가에 올 수 있습니다. 그것은 단지 여기서 통제력을 갖는 것이 도움이 될 수 있는 경우가 있다는 점을 강조하고 있다.