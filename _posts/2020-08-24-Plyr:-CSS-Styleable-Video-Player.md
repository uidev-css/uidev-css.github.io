---
layout: post
title: "Flyr: CSS 스타일링 가능한 비디오 플레이어"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/08/plyr-video.png
tags: AUDIO,VIDEO
---


저는 방금 샘 포츠(Sam Potts)의 플리르(Plyr)를 우연히 만났어요. 비디오 플레이어 스타일의 자바스크립트 라이브러리에서요. 제가 놀랐던 것은 유튜브 영상을 소스로 나열할 수 있다는 것입니다. 그래서 기본적으로 CSS 스타일의 유튜브 영상을 가질 수 있습니다. 멋있다.

HTML5 비디오 및 오디오의 경우 이러한 요소를 직접 대상으로 지정하고 라이브러리를 호출할 수 있습니다. YouTube의 경우 기본 임베드를 다음과 같이 포장합니다.

```html
<div class="plyr__video-embed" id="player">
  <!-- copy/paste from YouTube -->
  <iframe src="" ... ></iframe>
<div>
```

```js
const player = new Plyr("#player");
```

이제 CSS 파일만 로드하면 됩니다. CSS는 CSS 사용자 지정 속성으로 작성되었으므로 컬러 테마를 설정하는 단일 선언을 작성할 수 있습니다.

```css
html {
  --plyr-color-main: #f18f35;
}
```

만지작거려야 할 많은 관습적인 특성들이 있다. 펜 예제를 여기에 삭제하겠습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_OJNXzrN" src="//codepen.io/anon/embed/OJNXzrN?height=450&amp;theme-id=1&amp;slug-hash=OJNXzrN&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed OJNXzrN" title="CodePen Embed OJNXzrN" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

HTML/CSS에 내장된 비디오는 가로 세로 비율에 따라 반응하도록 설정되었다. 👍