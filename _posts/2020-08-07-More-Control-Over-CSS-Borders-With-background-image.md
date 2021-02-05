---
layout: post
title: "배경 이미지를 사용하여 CSS 경계에 대한 추가 제어"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/08/background-borders.png
tags: BACKGROUND-IMAGE,BORDER
---


일반적인 CSS `경계`를 점선 또는 점선으로 만들 수 있습니다. 예를 들어:

```css
.box {
   border: 1px dashed black;
   border: 3px dotted red;
}
```

대쉬나 틈이 얼마나 큰지, 긴지에 대한 통제력이 별로 없습니다. 그리고 여러분은 확실히 대쉬를 기울이거나, 사라지거나, 애니메이션을 줄 수 없습니다! 하지만 속임수로도 그런 것들을 할 수 있어요.

아밋 쉰이 정말 깔끔한 파선 보더 생성기를 제작했습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 850px;"><iframe id="cp_embed_xxZeyjO" src="//codepen.io/anon/embed/xxZeyjO?height=850&amp;theme-id=1&amp;slug-hash=xxZeyjO&amp;default-tab=result" height="850" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed xxZeyjO" title="CodePen Embed xxZeyjO" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

네 가지 배경을 사용하는 것이 요령이다. 배경 속성은 쉼표로 구분된 값을 가지므로 네 개의 배경(상단, 오른쪽, 하단, 왼쪽)을 설정하고 경계선처럼 보이도록 크기를 조정하면 이 모든 제어의 잠금을 해제한다.

예를 들어 다음과 같습니다.

```css
.box {
  background-image: repeating-linear-gradient(0deg, #333333, #333333 10px, transparent 10px, transparent 20px, #333333 20px), repeating-linear-gradient(90deg, #333333, #333333 10px, transparent 10px, transparent 20px, #333333 20px), repeating-linear-gradient(180deg, #333333, #333333 10px, transparent 10px, transparent 20px, #333333 20px), repeating-linear-gradient(270deg, #333333, #333333 10px, transparent 10px, transparent 20px, #333333 20px);
  background-size: 3px 100%, 100% 3px, 3px 100% , 100% 3px;
  background-position: 0 0, 0 0, 100% 0, 0 100%;
  background-repeat: no-repeat;
}
```

저는 껌을 좋아해요.