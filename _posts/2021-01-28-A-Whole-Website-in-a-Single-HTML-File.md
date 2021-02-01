---
layout: post
title: "단일 HTML 파일의 전체 웹 사이트
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2021/01/target-pseudo-website.png
tags: :TARGET
---


이 사이트에 대한 생각을 멈출 수 없습니다.
 꽤 표준 운임처럼 보입니다.
 다른 페이지에 대한 링크가있는 웹 사이트.
 집에 쓸 것은 아무것도 없습니다. 웹 사이트 전체가 하나의 HTML 파일 안에 들어 있습니다.
 

탐색 링크를 클릭하는 것은 어떻습니까?
 각 링크는 HTML의 특정 부분 만 표시하고 숨 깁니다.
 

```html
<section id="home">
  <!-- home content goes here -->
</section>
<section id="about">
  <!-- about page goes here -->
</section>
```

각`<section>`은 CSS로 숨겨집니다.
 

```css
section { display: none; }
```

기본 탐색의 각 링크는 페이지의 앵커를 가리 킵니다.
 

```html
<a href="#home">Home</a>
<a href="#about">About</a>
```

링크를 클릭하면 해당 링크에 대한`<섹션>`이 다음을 통해 표시됩니다.
 

```css
section:target { display: block; }
```

`: target` 의사 선택자가 보이십니까?
 그게 마법입니다!
 물론 몇 년 동안 사용되어 왔지만 확실하게 사용할 수있는 현명한 방법입니다.
 대부분의 경우 앵커 링크를 클릭하면 페이지에서 앵커를 강조 표시하는 데 사용됩니다.
 이는 사용자가 방금 이동 한 위치를 알 수있는 편리한 방법입니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_LYRKKxj" src="//codepen.io/anon/embed/LYRKKxj?height=450&amp;theme-id=1&amp;slug-hash=LYRKKxj&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed LYRKKxj" title="CodePen Embed LYRKKxj" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

어쨌든 이렇게`: target`을 사용하는 것은 정말 똑똑한 일입니다!
 클릭하면 일반 웹 사이트처럼 보입니다.
 


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video controls="" src="https://css-tricks.com/wp-content/uploads/2021/01/target-pseudo-website.mov" playsinline="" name="fitvid0"></video>
</div>


직접 링크 →
 