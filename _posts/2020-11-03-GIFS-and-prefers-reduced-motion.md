---
layout: post
title: "GIFS 및 선호 감소 모션"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/05/resp-images-thumb.png
tags: GIF,PICTURE,PREFERS-REDUCED-MOTION
---


`<picture>`요소에는 다양한 상황에서 다양한 이미지 형식을 표시하는 트릭이 있습니다.
 성능을위한 형식에만 관심이 있다면 다음과 같이 할 수 있습니다.
 

```html
<picture>
  <source srcset="img/waterfall.avif" type="image/avif">
  <source srcset="img/waterfall.webp" type="image/webp"> 
  <img src="img/waterfall.jpg" alt="A bottom-up shot of a huge waterfall in Iceland with green moss on either side.">
</picture>
```

그러나 거기에있는`<source>`요소에 주목하십시오.`media` 속성도 취할 수 있습니다!
 즉, 이미지를 다른 이미지로 교체 할 수 있다는 점에서 반응 형 이미지에 사용할 수 있습니다. 가로 세로 비율이 다른 이미지 (예 : 큰 화면의 넓은 자르기 직사각형 모양과 닫기
 작은 화면에서 사각형 모양 자르기).
 

`media` 속성은 화면 크기와 관련 될 필요는 없습니다.
 Brad Frost는이 트릭을 얼마 전에 기록했습니다.
 

```html
<picture>
  <source srcset="no-motion.jpg" media="(prefers-reduced-motion: reduce)"></source> 
  <img srcset="animated.gif" alt="brick wall">
</picture>
```

이는 움직임이 적은 것이 선호 될 때 (시스템 수준 선택) GIF를 정적 이미지로 교체하기 위해`prefers-reduced-motion` 미디어 쿼리를 사용하는 것입니다.
 영리한!
 얼마전에 마누엘의 트윗을 보았습니다.
 

얼마 전 Steve Faulkner의 아이디어에 대한 우리의 작은 rif를 기억하십니까?
 GIF를 완전히 중지하는 대신 애니메이션 이미지와 애니메이션 이미지가 아닌 이미지를 서로 겹쳐서 (`<details>`요소 내부) 필요에 따라 "재생"할 수 있습니다.
 우리는 그 smidge를 다시 변경하고 JavaScript의 smidge를 사용하여이 미디어 쿼리를 존중하도록 할 수 있습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 750px;"><iframe id="cp_embed_xxOdvxR" src="//codepen.io/anon/embed/xxOdvxR?height=750&amp;theme-id=1&amp;slug-hash=xxOdvxR&amp;default-tab=js,result" height="750" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed xxOdvxR" title="CodePen Embed xxOdvxR" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>