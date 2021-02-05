---
layout: post
title: "CSS를 사용하여 반대쪽에 수직 스크롤 막대 배치"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/04/scrollbar-progress.png
tags: 
---


공정한 경고: 일반적으로 이 기능을 추천할 수 없는 이유는 스크롤바가 어디에 있는지 매우 큰 기대를 저버리기 때문입니다. 스크롤바는 많은 사람들에게 유용하며, 많은 사람들에게 핵심 접근성 기능을 제공합니다.

하지만 그것은 매혹적인 CSS 속임수이고 웹은 때때로 이상한 해결책이 필요한 알 수 없는 상황의 크기를 가진 큰 장소입니다.

### 기법 #1: 방향 요령

여기서의 요령은 스크롤 부모 요소가 `방향:rtl`(또는 주 방향과 반대)을 사용하도록 하고 스크롤 요소의 안쪽을 원래대로 되돌리는 것이다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_ExPdXxz" src="//codepen.io/anon/embed/ExPdXxz?height=450&amp;theme-id=1&amp;slug-hash=ExPdXxz&amp;default-tab=css,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed ExPdXxz" title="CodePen Embed ExPdXxz" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 기술 #2: 회전 속임수

문자 방향이 아닌 목적으로 문자 방향을 가지고 장난치는 것은 항상 나에게 조금 무섭게 느껴져서 이 속임수는 덜 익살스럽게 느껴져. 부모 180deg를 돌린 뒤 아이가 180deg를 돌려 다시 똑바로 서도록 하는 게 요령이다.

첫 번째 회전으로 인해 스크롤 막대는 반대쪽에 있게 됩니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_vYLVZNK" src="//codepen.io/anon/embed/vYLVZNK?height=450&amp;theme-id=1&amp;slug-hash=vYLVZNK&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed vYLVZNK" title="CodePen Embed vYLVZNK" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이것은 두 가지 이유로 특히 어색하다.

- 스크롤 요소는 기본적으로 맨 아래로 스크롤됩니다.
- 스크롤 방향은 스크롤 휠과 반대로 느껴집니다. 스크롤 막대 자체는 예상대로 동작해야 하지만 트랙패드 또는 마우스 스크롤 휠은 해당 요소에서 스크롤 방향이 반대로 바뀐 것처럼 느껴집니다.

만우절 장난이라기보다는 진짜 쓰실 수 있을 거예요. 바이러스성 트윗이 욕설을 퍼부었어, 맞아.