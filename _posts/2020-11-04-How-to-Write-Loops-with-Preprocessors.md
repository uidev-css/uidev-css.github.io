---
layout: post
title: "전처리기로 루프를 작성하는 방법
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2018/11/loops.png
tags: LOOPS,PREPROCESSING
---


루프는 매일 필요하지 않은 기능 중 하나입니다.
 하지만 그렇게 할 때 네이티브 HTML과 CSS는 할 수 없기 때문에 전처리 기가 할 수 있다는 것은 정말 멋진 일입니다.
 

### Sass (SCSS)
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 350px;"><iframe id="cp_embed_Vwjwwmy" src="//codepen.io/anon/embed/Vwjwwmy?height=350&amp;theme-id=1&amp;slug-hash=Vwjwwmy&amp;default-tab=css,result" height="350" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed Vwjwwmy" title="CodePen Embed Vwjwwmy" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 350px;"><iframe id="cp_embed_XWKWWpj" src="//codepen.io/anon/embed/XWKWWpj?height=350&amp;theme-id=1&amp;slug-hash=XWKWWpj&amp;default-tab=css,result" height="350" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed XWKWWpj" title="CodePen Embed XWKWWpj" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_yLJLLbN" src="//codepen.io/anon/embed/yLJLLbN?height=450&amp;theme-id=1&amp;slug-hash=yLJLLbN&amp;default-tab=css,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed yLJLLbN" title="CodePen Embed yLJLLbN" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 적게
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_NWrdavY" src="//codepen.io/anon/embed/NWrdavY?height=450&amp;theme-id=1&amp;slug-hash=NWrdavY&amp;default-tab=css,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed NWrdavY" title="CodePen Embed NWrdavY" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

(그것이 위의 내용입니다.`when` 절은 정확히`while`로 생각할 수 있습니다.)
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_eYzgGeo" src="//codepen.io/anon/embed/eYzgGeo?height=450&amp;theme-id=1&amp;slug-hash=eYzgGeo&amp;default-tab=css,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed eYzgGeo" title="CodePen Embed eYzgGeo" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 첨필
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_MWeJEBx" src="//codepen.io/anon/embed/MWeJEBx?height=450&amp;theme-id=1&amp;slug-hash=MWeJEBx&amp;default-tab=css,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed MWeJEBx" title="CodePen Embed MWeJEBx" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

스타일러스의 `for`루프 만.
 

`for` 루프는 실제로`each` 루프처럼 동작하므로 다음은 더 분명한`each` 루프 예제입니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_wvWgPKY" src="//codepen.io/anon/embed/wvWgPKY?height=450&amp;theme-id=1&amp;slug-hash=wvWgPKY&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed wvWgPKY" title="CodePen Embed wvWgPKY" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 이긴 흙
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_MWemxER" src="//codepen.io/anon/embed/MWemxER?height=450&amp;theme-id=1&amp;slug-hash=MWemxER&amp;default-tab=html,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed MWemxER" title="CodePen Embed MWemxER" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_XWKRGVr" src="//codepen.io/anon/embed/XWKRGVr?height=450&amp;theme-id=1&amp;slug-hash=XWKRGVr&amp;default-tab=html,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed XWKRGVr" title="CodePen Embed XWKRGVr" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_LYZQZbQ" src="//codepen.io/anon/embed/LYZQZbQ?height=450&amp;theme-id=1&amp;slug-hash=LYZQZbQ&amp;default-tab=html,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed LYZQZbQ" title="CodePen Embed LYZQZbQ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### Haml
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_BazpwgV" src="//codepen.io/anon/embed/BazpwgV?height=450&amp;theme-id=1&amp;slug-hash=BazpwgV&amp;default-tab=html,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed BazpwgV" title="CodePen Embed BazpwgV" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_zYBRBWE" src="//codepen.io/anon/embed/zYBRBWE?height=450&amp;theme-id=1&amp;slug-hash=zYBRBWE&amp;default-tab=html,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed zYBRBWE" title="CodePen Embed zYBRBWE" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_GRqQqmz" src="//codepen.io/anon/embed/GRqQqmz?height=450&amp;theme-id=1&amp;slug-hash=GRqQqmz&amp;default-tab=html,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed GRqQqmz" title="CodePen Embed GRqQqmz" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 날씬한
 verified_user

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_oNLELyP" src="//codepen.io/anon/embed/oNLELyP?height=450&amp;theme-id=1&amp;slug-hash=oNLELyP&amp;default-tab=html,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed oNLELyP" title="CodePen Embed oNLELyP" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_JjKpKeZ" src="//codepen.io/anon/embed/JjKpKeZ?height=450&amp;theme-id=1&amp;slug-hash=JjKpKeZ&amp;default-tab=html,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed JjKpKeZ" title="CodePen Embed JjKpKeZ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_wvWyWEB" src="//codepen.io/anon/embed/wvWyWEB?height=450&amp;theme-id=1&amp;slug-hash=wvWyWEB&amp;default-tab=html,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed wvWyWEB" title="CodePen Embed wvWyWEB" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>