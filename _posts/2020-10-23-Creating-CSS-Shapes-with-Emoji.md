---
layout: post
title: "Emoji를 사용하여 CSS 도형 만들기"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/10/css-shape-emoji.png
tags: CSS SHAPES,EMOJI
---


CSS 도형은 지정된 도형을 따라 인라인 컨텐츠(일반적으로 텍스트)를 감싸게 하는 부동된 요소 위에 기하학적 도형을 만들 수 있는 표준입니다.

이러한 형태의 텍스트 흐름은 텍스트의 덩어리에서 시각적인 완화를 추가하기 위해 텍스트 집약적인 내용과 함께 작동하는 편집 설계 또는 설계에서 보기 좋다.

사용 중인 CSS 셰이프의 예는 다음과 같습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_yLJNyKV" src="//codepen.io/anon/embed/yLJNyKV?height=450&amp;theme-id=1&amp;slug-hash=yLJNyKV&amp;default-tab=css,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed yLJNyKV" title="CodePen Embed yLJNyKV" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

`shape-outside` 속성은 기본 형상 함수인 `circle()`ellipse() 또는 `inset()` 중 하나를 사용하거나 다음과 같은 이미지를 사용하여 부동 영역의 모양을 지정합니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_rNLVavz" src="//codepen.io/anon/embed/rNLVavz?height=450&amp;theme-id=1&amp;slug-hash=rNLVavz&amp;default-tab=css,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed rNLVavz" title="CodePen Embed rNLVavz" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

인라인 콘텐츠는 왼쪽 부동 소자의 오른쪽과 오른쪽 부동 소자의 왼쪽을 따라 래핑됩니다.

이 게시물에서는 흥미로운 텍스트 포장 효과를 만들기 위해 이모지와 함께 CSS Shapes의 개념을 사용할 것입니다. 이미지는 직사각형입니다. 우리가 CSS에서 그리는 도형들 중 많은 도형들 또한 박시적이거나 최소한 표준 도형으로 제한된다. 반면에, 이모지는 상자에서 벗어날 수 있는 깔끔한 기회를 제공합니다!

이렇게 하면 됩니다. 먼저 이모지로 이미지를 만든 다음 띄워 CSS Shape를 적용하면 됩니다.

저는 이미 창조적인 배경 패턴에 관한 이 게시물의 이모티콘을 이미지로 변환하는 여러 가지 방법을 다루었습니다. 그 점에서 저는 SVG <text>를 사용하여 변환하는 방법을 찾을 수 없다고 말했지만, 저는 지금 그것을 알아냈고 이 게시물에서 어떻게 표시되는지 보여드리겠습니다. 이 글이 말이 되기 위해 그 기사를 읽을 필요는 없지만, 보고 싶다면 거기에 있다.

### 이모티콘을 만들어보자.

이모티콘 이미지를 만드는 데 사용하는 세 가지 단계는 다음과 같습니다.

- SVG에서 이모지 모양의 컷아웃 생성
- SVG 코드를 데이터로 변환URL 인코딩을 통해 URL을 `data:image/svg+xml`로 접두사 지정
- 데이터 사용요소의 `background-image`의 `url()` 값으로 URL을 지정합니다.

다음은 이모지 모양의 컷아웃을 생성하는 SVG 코드입니다.

```svg
<svg width='150px' height='150px' xmlns='http://www.w3.org/2000/svg'> 
  <clipPath id='emojiClipPath'> 
    <text x='0' y='130px' font-size='130px'>🦕</text> 
  </clipPath> 
  <text x='0' y='130px' font-size='130px' clip-path='url(#emojiClipPath)'>🦕</text>
</svg> 

```

여기서 벌어지고 있는 일은 `clipPath`에 대한 이모티콘 문자가 포함된 `<text>` 요소를 제공하는 것이다. 클립 경로는 요소에 클립 경로를 적용할 때 계속 볼 수 있는 영역의 윤곽선입니다. 우리 코드에서, 그 윤곽은 이모지 캐릭터의 모양입니다.

그런 다음, 이모지의 클립 경로는 클립 경로 속성을 사용하여 동일한 이모지 문자를 전달하는 <텍스트> 요소로 참조되어 이모지 모양의 컷아웃을 만든다.

이제 SVG 코드를 데이터 URL로 변환합니다. 손으로 URL을 인코딩하거나 온라인 도구(이 도구와 같은 도구)를 사용하여 직접 인코딩할 수 있습니다.

CSS에서 .emoji 요소의 배경 이미지에 대한 `url() 값`으로 사용되는 데이터 URL 결과는 다음과 같습니다.

```css
.emoji {
  background: url("data:image/svg+xml,<svg width='150px' height='150px' xmlns='http://www.w3.org/2000/svg'> <clipPath id='emojiClipPath'> <text x='0' y='130px'  font-size='130px'>🦕</text> </clipPath> <text x='0' y='130px' font-size='130px' clip-path='url(%23emojiClipPath)'>🦕</text></svg>");
}
```

여기서 멈춰서 `.emoji` 요소 치수를 제공한다면 캐릭터가 배경 이미지로 표시되는 것을 볼 수 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 270px;"><iframe id="cp_embed_gOMwQdY" src="//codepen.io/anon/embed/gOMwQdY?height=270&amp;theme-id=1&amp;slug-hash=gOMwQdY&amp;default-tab=result" height="270" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed gOMwQdY" title="CodePen Embed gOMwQdY" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 이제 이것을 CSS 쉐입으로 바꾸자.

이 작업은 두 단계로 수행할 수 있습니다.

- 요소를 이모지 배경으로 부동합니다.
- 데이터 사용요소의 "shape-outside" 속성에 대한 "url() 값으로 URL을 지정함

```css
.emoji {
  --image-url: url("data:image/svg+xml,<svg width='150px' height='150px' xmlns='http://www.w3.org/2000/svg'> <clipPath id='emojiClipPath'> <text x='0' y='130px'  font-size='130px'>🦕</text> </clipPath> <text x='0' y='130px'  font-size='130px' clip-path='url(#emojiClipPath)'>🦕</text></svg>");
  background: var(--image-url);
  float: left;
  height: 150px;
  shape-outside: var(--image-url);
  width: 150px;
  margin-left: -6px; 
} 
 
 
 

```

데이터를 배치했습니다.사용자 지정 속성인 "--image-url"의 URL은 인코딩된 SVG의 빅올 문자열을 여러 번 반복하지 않고 "background"와 "shape-outside" 속성 모두에서 쉽게 참조할 수 있다.

이제 떠 있는 .emoji 요소 근처에 있는 모든 인라인 콘텐츠는 이모지 모양으로 흐를 것이다. 여백이나 도형 여백으로 사물을 더욱 조정하여 도형 주위에 공간을 추가할 수 있다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_YzWXPvd" src="//codepen.io/anon/embed/YzWXPvd?height=450&amp;theme-id=1&amp;slug-hash=YzWXPvd&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed YzWXPvd" title="CodePen Embed YzWXPvd" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

색상이 차단된 이모지 모양을 원하는 경우 SVG의 `<rect>` 요소에 클립 경로를 적용하여 이 작업을 수행할 수 있습니다.

```svg
<svg width='150px' height='150px' xmlns='http://www.w3.org/2000/svg'> 
    <clipPath id='emojiClipPath'> 
        <text x='0' y='130px' font-size='130px'>🦕</text> 
    </clipPath> 
    <rect x='0' y='0' fill='green' width='150px' height='150px' clip-path='url(#emojiClipPath)'/> 
</svg> 

```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_RwRGqdX" src="//codepen.io/anon/embed/RwRGqdX?height=450&amp;theme-id=1&amp;slug-hash=RwRGqdX&amp;default-tab=html,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed RwRGqdX" title="CodePen Embed RwRGqdX" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

같은 기술이 문자에도 통할 것입니다!

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_dyXoPjg" src="//codepen.io/anon/embed/dyXoPjg?height=450&amp;theme-id=1&amp;slug-hash=dyXoPjg&amp;default-tab=css,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed dyXoPjg" title="CodePen Embed dyXoPjg" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

Firefox가 항상 이모티콘 모양을 렌더링하는 것은 아닙니다. SVG 코드를 업데이트하면 그 문제를 해결할 수 있습니다.

```svg
<svg xmlns='http://www.w3.org/2000/svg' width='150px' height='150px'>
  <foreignObject width='150px' height='150px'>
    <div xmlns='http://www.w3.org/1999/xhtml' style='width:150px;height:150px;line-height:150px;text-align:center;color:transparent;text-shadow: 0 0 black;font-size:130px;'>🧗</div>
  </foreignObject>
</svg>
```

이를 통해 이모지를 투명하게 만들고 인라인 CSS로 텍스트 섀도우(text shadow)를 부여해 블록 컬러의 이모지 모양을 만든다. 그런 다음 이모지와 인라인 CSS 스타일이 포함된 <div>를 SVG의 <foreign Object> 요소에 삽입하여 SVG 네임스페이스 내에서 HTML <div> 코드를 사용할 수 있다. 이 기법의 나머지 코드는 지난번 것과 같다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_rNLVaZG" src="//codepen.io/anon/embed/rNLVaZG?height=450&amp;theme-id=1&amp;slug-hash=rNLVaZG&amp;default-tab=css,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed rNLVaZG" title="CodePen Embed rNLVaZG" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 자, 이제 중심을 잡아야 합니다.

CSS 셰이프는 부동한 요소에만 적용될 수 있으므로 텍스트는 부동한 측면에 따라 요소의 오른쪽 또는 왼쪽으로 흐릅니다. 요소 및 도형의 중심을 맞추기 위해 다음 작업을 수행합니다.

- 이모지를 반으로 나누세요.
- 이모지의 왼쪽 절반을 오른쪽으로, 오른쪽 절반을 왼쪽으로 띄웁니다.
- 양쪽 다 합치세요!

이 전략에 대한 한 가지 주의할 점은 설계에서 실행 문장을 사용하는 경우, 양쪽의 문자를 수동으로 정렬해야 한다는 것입니다.

NAT의 목표는 다음과 같습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 500px;"><iframe id="cp_embed_wvWaBYa" src="//codepen.io/anon/embed/wvWaBYa?height=500&amp;theme-id=1&amp;slug-hash=wvWaBYa&amp;default-tab=result" height="500" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed wvWaBYa" title="CodePen Embed wvWaBYa" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

먼저, 우리는 디자인의 왼쪽과 오른쪽의 HTML을 봅니다. 그것들은 아주 똑같은 겁니다.

```html
<div id="design">
  <p id="leftSide">A C G T A <!-- more characters --> C G T A C G T A C G T <span class="emoji"></span>A C G <!-- more characters --> C G T </p>
  <p id="rightSide">A C G T A <!-- more characters --> C G T A C G T A C G T <span class="emoji"></span>A C G <!-- more characters --> C G T </p>
</div>
```

#design 안의 p#leftSide와 p#rightSide가 나란히 그리드에 배열되어 있다.

```css
#design {
  border-radius: 50%; /* A circle */
  box-shadow: 6px 6px 20px silver;
  display: grid; 
  grid: "1fr 1fr"; /* A grid with two columns */
  overflow: hidden;
  width: 400px; height: 400px;
}
```

다음은 이모지에 대한 CSS입니다.

```css
span.emoji {
  filter: drop-shadow(15px 15px 5px green);
  shape-margin: 10px;
  width: 75px; 
  height: 150px;
}

/* Left half of the emoji */
p#leftSide>span.emoji {
  --image-url:url("data:image/svg+xml,<svg width='150px' height='150px' xmlns='http://www.w3.org/2000/svg'> <clipPath id='emojiClipPath'> <text x='0' y='130px'  font-size='130px'>🦎</text> </clipPath> <rect x='0' y='0' width='150px' height='150px' clip-path='url(%23emojiClipPath)'/></svg>");
  background-image: var(--image-url);
  float: right;
  shape-outside: var(--image-url);
}

/* Right half of the emoji */
p#rightSide>span.emoji {
  --image-url:url("data:image/svg+xml,<svg width='150px' height='150px' xmlns='http://www.w3.org/2000/svg'> <clipPath id='emojiClipPath'> <text x='-75px' y='130px'  font-size='130px'>🦎</text> </clipPath> <rect x='0' y='0' width='150px' height='150px' clip-path='url(%23emojiClipPath)'/></svg>");
  background-image: var(--image-url);
  float: left;
  shape-outside: var(--image-url);
}
```

이모지 이미지(span.emoji)를 고정하는 <span> 요소의 폭은 75px인 반면 SVG 이모지 이미지의 폭은 150px이다. 이렇게 하면 스팬 내부에 표시될 때 이미지가 자동으로 반으로 잘립니다.

설계 오른쪽에는 왼쪽 부동의 이모지(p#오른쪽 옆면 >span.emoji)가 있어 오른쪽 반을 나타내려면 왼쪽 반을 왼쪽으로 이동시켜야 하므로 데이터의 <텍스트>에 x 값이 있다.URL이 75px로 변경되었습니다. 이것이 데이터의 유일한 차이점입니다.설계의 왼쪽과 오른쪽의 URL.

결과는 다음과 같습니다.

다 됐다! 더 이상 어쩔 수 없다! 요소를 두 개로 나누고 CSS를 사용하여 반쪽을 다시 합칠 수 있는 한 CSS Shape의 중심을 맞추기 위해 위의 방법을 시도할 수 있습니다.