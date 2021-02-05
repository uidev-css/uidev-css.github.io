---
layout: post
title: "복합 레이블 스타일링"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/10/pricing-cards.png
tags: ACCESSIBILITY,HTML,LABELS
---


Danielle Romo는 단어 `=라벨`이 있을 때 필요한 HTML 패턴을 `=input type=`라디오`의 화려한 스타일링으로 커버한다.

속임수요? 읽을 레이블을 포함하는 old `=span class=`hidden-true`와 비주얼 전용 콘텐츠를 포함하는 =spana-hidden=`true`입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_ZEQWyaZ" src="//codepen.io/anon/embed/ZEQWyaZ?height=450&amp;theme-id=1&amp;slug-hash=ZEQWyaZ&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed ZEQWyaZ" title="CodePen Embed ZEQWyaZ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

저는 사람들이 얼마나 자주 이 패턴에 착륙하는지가 흥미롭다고 생각합니다. 이단의 전 세계 작품 봤어요? 그가 말하는 드롭캡 패턴은 본질적으로 같은 패턴입니다.

```html
<span aria-hidden="true">
  Markup for the visual experience only,
  where you can (somewhat safely) use markup 
  that would be crap for screen readers.  
</span>

<span class="visually-hidden">
  Markup for the read experience only, that
  you keep very clean on purpose.
</span>
```

그 수업은 이렇습니다.

직접 링크 →