---
layout: post
title: "블로그를 위한 멋진 CSS 그리드 기술"
author: "Uidev Css"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/06/auto-grid-image-gallery.jpg"
tags: GRID,TRICK
---


10년 전쯤 제가 만든 블로그의 모양을 수정하려다가 CSS를 발견했습니다. 곧, 저는 멋진 것들을 좀 더 수학적으로 코딩할 수 있게 되었습니다. 따라서, 변환과 같은 더 이해하기 쉬운 특징들로요. 그러나 레이아웃과 같은 CSS의 다른 영역은 지속적인 고통의 근원으로 남아 있다.

이 게시물은 제가 10년 전쯤 접한 문제에 관한 것인데, 최근까지 어떻게 스마트하게 풀어야 할지 몰랐습니다. 구체적으로는, 제가 어떻게 현대적인 CSS 그리드 기술을 사용하여 오랫동안 지속되는 문제에 대한 해결책을 찾았는지에 관한 것입니다. 그 과정에서, 제가 생각했던 것보다 훨씬 더 멋진 결과를 얻을 수 있었습니다.

이것은 CSS 그리드를 가장 잘 사용하는 방법에 대한 튜토리얼이 아니라 나만의 학습 과정을 통해 걷는 것에 더 가깝다는 점에 유의한다.

### 문제

그 블로그에 처음 올려놓곤 했던 것 중 하나는 도시의 무작위 사진들이었습니다. 그래서 저는 고정된 크기의 썸네일 그리드에 대한 아이디어를 가지고 있었습니다. 좀 더 보기 좋게, 저는 이 그리드를 위아래의 문단에 대해 중간 정렬하고 싶었지만, 동시에 마지막 행의 축소판 그림들이 그리드에 대해 왼쪽 정렬되기를 원했습니다. 한편, 기둥의 폭(그리고 그 안의 그리드의 폭)은 뷰포트에 따라 달라진다.

HTML은 다음과 같습니다.

```html
<section class='post__content'>
  <p><!-- some text --></p>
  <div class='grid--thumbs'>
    <a href='full-size-image.jpg'>
      <img src='thumb-image.jpg' alt='image description'/>
    </a>
    <!-- more such thumbnails -->
  </div>
  <p><!-- some more text --></p>
</section>
```

간단해 보일지 모르지만, 지금까지 내가 겪었던 CSS 문제 중 가장 어려운 문제 중 하나로 밝혀졌습니다.

### 이상적인 솔루션보다 적음

이런 것들은 제가 몇 년 동안 시도하거나 본 것들이지만, 저를 실제로 어디에도 끌어들이지 못했습니다.

Floats는 막다른 골목으로 밝혀졌습니다. 저는 어떻게 그리드를 가운데 정렬시킬 수 있는지 알 수 없었기 때문입니다.

```css
.grid--thumbs { overflow: hidden; }

.grid--thumbs a { float: left; }
```

아래 데모에서는 플로트 시도를 보여 줍니다. 서로 다른 뷰포트 폭에서 어떻게 동작하는지 볼 수 있도록 임베드 크기를 조정합니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper"><iframe id="cp_embed_ZEbmLMa" src="//codepen.io/anon/embed/ZEbmLMa?height=500&amp;theme-id=1&amp;slug-hash=ZEbmLMa&amp;default-tab=result" height="500" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed ZEbmLMa" title="CodePen Embed ZEbmLMa" class="cp_embed_iframe" style="width:100%;overflow:hidden">CodePen Embed Fallback</iframe></div>

처음에는 이것이 더 나은 아이디어처럼 보였습니다.

```css
.grid--thumbs { text-align: center }

.grid--thumbs a { display: inline-block }
```

알고 보니 그게 아니었어:

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper"><iframe id="cp_embed_JjYeWao" src="//codepen.io/anon/embed/JjYeWao?height=550&amp;theme-id=1&amp;slug-hash=JjYeWao&amp;default-tab=result" height="550" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed JjYeWao" title="CodePen Embed JjYeWao" class="cp_embed_iframe" style="width:100%;overflow:hidden">CodePen Embed Fallback</iframe></div>

이 경우 마지막 행이 정렬되어 있지 않습니다.

어느 순간 코드펜에서 우연히 CSS 자동완료를 한 덕분에 블록의 마지막 줄이 어떻게 정렬되는지를 결정하는 `text-align-last`라는 속성을 알게 되었다.

불행하게도 그리드에서 "text-align-last: left"를 설정하는 것도 제가 찾던 해결책은 아니었습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper"><iframe id="cp_embed_LYpXWoN" src="//codepen.io/anon/embed/LYpXWoN?height=550&amp;theme-id=1&amp;slug-hash=LYpXWoN&amp;default-tab=result" height="550" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed LYpXWoN" title="CodePen Embed LYpXWoN" class="cp_embed_iframe" style="width:100%;overflow:hidden">CodePen Embed Fallback</iframe></div>

이 시점에서, 저는 사실 중간 정렬 그리드에 대한 생각을 버리는 것을 고려했습니다. 그리드에서 텍스트 정렬: 정당화 및 텍스트 정렬-마지막: 왼쪽을 조합하면 더 좋은 결과를 얻을 수 있을까?

글쎄, 알고 보니 그렇지 않아. 즉, 마지막 행에 썸네일만 있고 열 사이의 간격이 너무 크지 않은 경우입니다. 내 뜻을 확인하려면 아래 임베드의 크기를 조정하십시오.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper"><iframe id="cp_embed_QWjJvWJ" src="//codepen.io/anon/embed/QWjJvWJ?height=550&amp;theme-id=1&amp;slug-hash=QWjJvWJ&amp;default-tab=result" height="550" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed QWjJvWJ" title="CodePen Embed QWjJvWJ" class="cp_embed_iframe" style="width:100%;overflow:hidden">CodePen Embed Fallback</iframe></div>

이것이 제가 2년 전 이 문제에 대한 해결책을 제시하지 못하고 9년 동안 노력한 끝에 제가 있던 곳입니다.

처음에는 효과가 있을 것 같았던 Flexbox 솔루션은 그리드에 "::after" 의사 요소를 추가하고 미리 보기와 이 의사 요소 모두에 "flex:1"을 설정하는 것이었습니다.

```scss
.grid--thumbs {
  display: flex;
  flex-wrap: wrap;
 
  a, &::after { flex: 1; }
 
  img { margin: auto; }
 
  &:after { content: 'AFTER'; }
}
```

아래 데모에서는 이 방법의 작동 방식을 보여 줍니다. 저는 어떤 일이 일어나고 있는지 더 쉽게 볼 수 있도록 미리 보기와 `::after` 사이비 요소의 윤곽을 보여드렸습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper"><iframe id="cp_embed_GRpwmqQ" src="//codepen.io/anon/embed/GRpwmqQ?height=550&amp;theme-id=1&amp;slug-hash=GRpwmqQ&amp;default-tab=result" height="550" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed GRpwmqQ" title="CodePen Embed GRpwmqQ" class="cp_embed_iframe" style="width:100%;overflow:hidden">CodePen Embed Fallback</iframe></div>

미리 보기 그리드가 중간 정렬되어 있지 않기 때문에 이것이 제가 원했던 것은 아닙니다. 그렇긴 하지만, 마지막 행이 다른 행보다 정확히 한 개의 항목보다 적은 이미지를 가지고 있는 한 그리 나쁘지 않아 보입니다. 그러나 변경되는 즉시 더 많은 항목이 누락되거나 없는 경우 레이아웃이 중단됩니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/05/screen_flex_after_issue.png?ssl=1)

그것은 하나의 진부한 생각이었다. 또 다른 방법은 의사 요소를 사용하지 않고 미리 보기 뒤에 빈 div를 원하는 열만큼 추가하는 것입니다.

예상 열 수는 미리 보기 크기가 고정되어 있고 전체 화면의 너비에 걸쳐 펼쳐지는 텍스트가 시각적으로 읽기에 지칠 수 있기 때문에 게시물의 최대 너비를 설정할 수 있기 때문에 근사할 수 있어야 한다. 최대 너비를 고정된 썸네일 너비로 나누면 이 경우 최대 열 수를 얻을 수 있습니다.

첫 번째 빈 요소는 미리 보기로 완전히 채워지지 않은 행의 전체 너비를 차지하며, 나머지는 다른 행으로 퍼집니다. 하지만 이들의 키는 0이기 때문에 시각적으로 문제가 되지 않을 것이다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper"><iframe id="cp_embed_VwvVqxv" src="//codepen.io/anon/embed/VwvVqxv?height=550&amp;theme-id=1&amp;slug-hash=VwvVqxv&amp;default-tab=result" height="550" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed VwvVqxv" title="CodePen Embed VwvVqxv" class="cp_embed_iframe" style="width:100%;overflow:hidden">CodePen Embed Fallback</iframe></div>

이런 종류의 속임수는 효과가 있지만, 다시 말하지만, 그것은 여전히 내가 원하는 정확한 결과를 만들어내지 못한다. 왜냐하면 그것은 때때로 크고 보기 흉한 기둥들 사이의 틈새로 끝나기 때문이다.

그리드 레이아웃은 이름이 주어졌을 때 항상 정답처럼 들렸습니다. 문제는 그때까지 제가 본 모든 예들은 미리 정의된 수의 열을 사용한다는 것이었고, 이는 뷰포트 폭에 따라 열의 수가 결정되는 이 특정 패턴에는 적용되지 않는다는 것이었습니다.

작년에 순수 CSS 배경 패턴인 하나의 요소 모음을 코딩하면서, 나는 Grid-template-columns를 설정하는 데 사용되는 열 수에 따라 CSS 변수인 --n을 수정하는 미디어 쿼리를 여러 개 생성하려고 생각했다.

```scss
$w: 13em;
$h: 19em;
$f: $h/$w;
$n: 7;
$g: 1em;

--h: #{$f*$w};
display: grid;
grid-template-columns: repeat(var(--n, #{$n}), var(--w, #{$w}));
grid-gap: $g;
place-content: center;
 
@for $i from 1 to $n {
  @media (max-width: ($n - $i + 1)*$w + ($n - $i + 2)*$g) {
    --n: #{$n - $i}
  }
}
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper"><iframe id="cp_embed_GRRpzNX" src="//codepen.io/anon/embed/GRRpzNX?height=600&amp;theme-id=1&amp;slug-hash=GRRpzNX&amp;default-tab=result" height="600" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed GRRpzNX" title="CodePen Embed GRRpzNX" class="cp_embed_iframe" style="width:100%;overflow:hidden">CodePen Embed Fallback</iframe></div>

저는 사실 그 당시에 이 아이디어가 매우 자랑스러웠습니다. 비록 지금 그것을 돌이켜보면 움츠러들지만요. 그리드 폭이 뷰포트 너비와 동일하지 않지만 여전히 유연하며 형제자매 너비에 따라 달라지는 경우, 가능한 모든 열 수에 대한 하나의 미디어 쿼리가 정확히 이상적인 것은 아닙니다.

### 마법의 해결책

나는 마침내 CSS 그리드를 사용하다가 더 나은 해결책을 발견했는데 왜 `반복()` 기능이 특정 상황에서 작동하지 않는지 이해하지 못했다. 너무 답답해서 MDN에 가게 되었는데, 마침 자동 맞춤이라는 키워드가 눈에 띄었고 설명을 이해하지 못하다가 다른 문제에도 도움이 될 것 같은 예감이 들어서 하던 일을 모두 그만두고 시도해 보았다.

제가 얻은 것은 다음과 같습니다.

```css
.grid--thumbs {
  display: grid;
  justify-content: center;
  grid-gap: .25em;
  grid-template-columns: repeat(auto-fit, 8em);
}
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper"><iframe id="cp_embed_eYpQbQx" src="//codepen.io/anon/embed/eYpQbQx?height=500&amp;theme-id=1&amp;slug-hash=eYpQbQx&amp;default-tab=result" height="500" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed eYpQbQx" title="CodePen Embed eYpQbQx" class="cp_embed_iframe" style="width:100%;overflow:hidden">CodePen Embed Fallback</iframe></div>

그리드 항목의 고정 크기 대신 사용할 수 있는 minmax() 기능도 발견했습니다. 저는 아직도 `minmax()`가 어떻게 작동하는지 정확히 이해하지 못했으며, 게임을 하면 할수록 이해가 덜 갑니다. 하지만 이 상황에서 그리드를 만든 다음 사용 가능한 모든 공간을 채울 때까지 기둥을 똑같이 늘립니다.

```css
grid-template-columns: repeat(auto-fit, minmax(8em, 1fr));
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper"><iframe id="cp_embed_eYpbQgd" src="//codepen.io/anon/embed/eYpbQgd?height=550&amp;theme-id=1&amp;slug-hash=eYpbQgd&amp;default-tab=result" height="550" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed eYpbQgd" title="CodePen Embed eYpbQgd" class="cp_embed_iframe" style="width:100%;overflow:hidden">CodePen Embed Fallback</iframe></div>

우리가 여기서 할 수 있는 또 다른 멋진 일은 이미지가 그리드 요소보다 더 넓을 때 넘쳐나는 것을 막는 것입니다. 최소 8em을 min(8em, 100%)으로 바꾸면 된다. 그러면 기본적으로 이미지가 100%를 초과하지 않고 8em 이하가 되지 않습니다. 크리스가 이런 제안을 해줘서 고마워!

최소() 함수는 염색체 이전 Edge에서 작동하지 않습니다!

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper"><iframe id="cp_embed_ZEbVVpv" src="//codepen.io/anon/embed/ZEbVVpv?height=550&amp;theme-id=1&amp;slug-hash=ZEbVVpv&amp;default-tab=result" height="550" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed ZEbVVpv" title="CodePen Embed ZEbVVpv" class="cp_embed_iframe" style="width:100%;overflow:hidden">CodePen Embed Fallback</iframe></div>

여기서 사용한 사각 이미지처럼 모든 이미지의 가로 세로 비율이 동일한 경우에만 좋은 결과를 얻을 수 있습니다. 제 블로그의 경우, 모든 사진이 제 소니 에릭슨 W800i 폰으로 찍혔기 때문에 이것은 문제가 되지 않았습니다. 그리고 그것들은 모두 같은 가로 세로 비율을 가지고 있었습니다. 하지만 가로 세로 비율이 다른 이미지를 떨어뜨린다면 그리드는 더 이상 좋아 보이지 않을 것입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper"><iframe id="cp_embed_dyYwazO" src="//codepen.io/anon/embed/dyYwazO?height=650&amp;theme-id=1&amp;slug-hash=dyYwazO&amp;default-tab=result" height="650" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed dyYwazO" title="CodePen Embed dyYwazO" class="cp_embed_iframe" style="width:100%;overflow:hidden">CodePen Embed Fallback</iframe></div>

물론 이미지 높이를 고정 값으로 설정할 수는 있지만, 우리가 `객체 적합성`을 `커버`로 설정하지 않는 한 이미지를 왜곡하여 문제를 해결한다!

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper"><iframe id="cp_embed_JjYwzmL" src="//codepen.io/anon/embed/JjYwzmL?height=450&amp;theme-id=1&amp;slug-hash=JjYwzmL&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed JjYwzmL" title="CodePen Embed JjYwzmL" class="cp_embed_iframe" style="width:100%;overflow:hidden">CodePen Embed Fallback</iframe></div>

다른 아이디어는 첫 번째 섬네일을 모든 그리드 열에 걸쳐 있는 배너로 바꾸는 것입니다. 한 가지 문제는 뷰포트에 따라 달라지기 때문에 열 수를 모른다는 것입니다. 하지만 해결책이 있습니다. 그리드-칼럼-엔드(grid-column-end)를 -1로 설정할 수 있습니다!

```scss
.grid--thumbs {
  /* same styles as before */
 
  a:first-child {
    grid-column: 1/ -1;
  
    img { height: 13em }
  }
}
```

첫 번째 이미지는 다른 모든 이미지보다 더 큰 `높이`가 된다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper"><iframe id="cp_embed_vYNbJJo" src="//codepen.io/anon/embed/vYNbJJo?height=650&amp;theme-id=1&amp;slug-hash=vYNbJJo&amp;default-tab=result" height="650" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed vYNbJJo" title="CodePen Embed vYNbJJo" class="cp_embed_iframe" style="width:100%;overflow:hidden">CodePen Embed Fallback</iframe></div>

물론, 마지막 열을 제외한 모든 열에 이미지가 포함되도록 하려면 -2로 설정했을 것입니다. 음의 열 인덱스가 중요합니다!

MDN에서 본 또 다른 그리드 속성 키워드인 오토필(auto-fill)은 비주얼이 없는 긴 텍스트 벽이라 특별히 유용하지는 않았다. 설상가상으로 위의 그리드 데모에서 자동 맞춤을 자동 채우기로 바꾸면 전혀 차이가 없다. 기사를 확인하거나 예를 들어 장난친 후에도 그들이 실제로 어떻게 일하고 어떻게 다른지 여전히 수수께끼로 남아 있다.

그러나 여러 가지 방법을 시도하고 여러 시나리오에서 일어나는 일들을 보면서 고정형(8em)이 아닌 최소()열 폭을 사용한다면 자동 맞춤보다는 자동 채우기(auto-fill)를 사용하는 것이 좋겠다는 결론을 내렸다.아래 대화형 데모에 의해 등급이 지정됩니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper"><iframe id="cp_embed_QWjovRV" src="//codepen.io/anon/embed/QWjovRV?height=650&amp;theme-id=1&amp;slug-hash=QWjovRV&amp;default-tab=result" height="650" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed QWjovRV" title="CodePen Embed QWjovRV" class="cp_embed_iframe" style="width:100%;overflow:hidden">CodePen Embed Fallback</iframe></div>

제가 개인적으로 가장 좋아하는 것은 중간 정렬의 썸네일 그리드에 대한 초기 아이디어이며, 대부분 고정된 열 너비를 가지고 있지만 15em이 아닌 최소(100%, 15em)를 사용하고 있습니다. 결국 개인 취향의 문제이며 아래 데모에서 볼 수 있는 것은 저에게 더 잘 보이기 때문입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper"><iframe id="cp_embed_yLYPzgd" src="//codepen.io/anon/embed/yLYPzgd?height=650&amp;theme-id=1&amp;slug-hash=yLYPzgd&amp;default-tab=result" height="650" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed yLYPzgd" title="CodePen Embed yLYPzgd" class="cp_embed_iframe" style="width:100%;overflow:hidden">CodePen Embed Fallback</iframe></div>

이 데모에서는 auto-fill과 같은 결과를 내고 한 글자 더 짧기 때문에 auto-fit을 사용하고 있습니다. 하지만, 이것을 만들 때 이해하지 못했던 것은 두 키워드 모두 같은 결과를 만들어 낸다는 것입니다. 왜냐하면 갤러리에 한 줄로 채워야 하는 것보다 더 많은 항목이 있기 때문입니다.

그러나 이렇게 바뀌면 아래 그림과 같이 자동 맞춤과 자동 채우기는 다른 결과를 낳습니다. `합리화-내용` 값과 그리드에 배치된 항목 수를 변경할 수 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper"><iframe id="cp_embed_gOayvpb" src="//codepen.io/anon/embed/gOayvpb?height=750&amp;theme-id=1&amp;slug-hash=gOayvpb&amp;default-tab=result" height="750" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed gOayvpb" title="CodePen Embed gOayvpb" class="cp_embed_iframe" style="width:100%;overflow:hidden">CodePen Embed Fallback</iframe></div>

어떤 것이 더 나은 선택인지 정말 모르겠어요. 이것도 개인 취향에 따라 다를 것 같아요. 정당성-내용-중심(center)과 함께 오토필(auto fill)이 더 논리적으로 보이지만 동시에 오토핏(auto-fit)이 더 나은 결과를 낳는다.