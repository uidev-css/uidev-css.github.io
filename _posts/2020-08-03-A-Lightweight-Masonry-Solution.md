---
layout: post
title: "경량 석공 솔루션"
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/05/bricks-with-gaps.png"
tags: CSS,GRID,JAVASCRIPT,LAYOUT,MASONRY
---


지난 5월, 나는 파이어폭스가 CSS 그리드에 메이커리를 추가하는 것에 대해 배웠다. 석공 배치는 아주 오랫동안 처음부터 혼자 하고 싶었지만 어디서부터 시작해야 할지 몰랐다. 그래서 자연스럽게 데모를 확인하고 나서 이 새로운 CSS 기능이 어떻게 동작하는지 이해하게 된 순간이 있었습니다.

현재로선 당연히 파이어폭스로만 지원이 제한되지만(그리고 거기에서도), 현재 지원이 부족한 브라우저를 포괄하는 자바스크립트 구현의 시작점을 충분히 제시해 주었다.

파이어폭스가 CSS에서 석공법을 구현하는 방법은 (예와 같이) `그리드-템플릿-열` 또는 `그리드-템플릿-열`을 `메이슨리` 값으로 설정하는 것이다.

내 접근 방식은 브라우저 지원(즉, 현재로서는 Firefox만 해당)에 이 기능을 사용하고 나머지는 JavaScript 예비 버전을 만드는 것이었습니다. 이미지 그리드의 특정 사례를 사용하여 이 기능이 어떻게 작동하는지 살펴보겠습니다.

### 먼저 플래그를 활성화합니다.

이를 위해 파이어폭스에 있는 about:config로 가서 masonry를 검색한다. 그러면 `layout.css.grid-template-masonry-value.enabled` 플래그가 나타나며, 이 플래그의 값은 `false`(기본값)에서 `true`로 두 번 클릭하면 활성화됩니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/07/enable_flag_firefox.png?ssl=1)

### 마크업부터 시작하겠습니다.

HTML 구조는 다음과 같습니다.

```html
<section class="grid--masonry">
  <img src="black_cat.jpg" alt="black cat" />
  <!-- more such images following -->
</section>
```

### 이제 몇 가지 스타일을 적용해 보겠습니다.

우리가 하는 첫 번째 일은 최상위 요소를 CSS 그리드 컨테이너로 만드는 것이다. 다음으로, 이미지의 최대 너비를 정의합니다(예: `10em`). 또한 뷰포트가 단일 `10em` 열 그리드를 수용할 수 없을 정도로 좁아지면 이러한 이미지가 그리드의 `콘텐츠 박스`에 사용할 수 있는 공간으로 축소되기를 원하므로 실제로 설정한 값은 `최소(10em, 100%)`이다. 요즘은 반응성이 중요하기 때문에 정해진 수의 컬럼을 사용하는 것이 아니라 이 폭의 컬럼을 최대한 많이 자동 맞춤으로 사용한다.

Sass 충돌을 피하기 위해 Min()이 아닌 Min()을 사용했습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 550px;"><iframe id="cp_embed_WNrgjYM" src="//codepen.io/anon/embed/WNrgjYM?height=550&amp;theme-id=1&amp;slug-hash=WNrgjYM&amp;default-tab=result" height="550" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed WNrgjYM" title="CodePen Embed WNrgjYM" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

음, 그건 격자야!

그리 예쁜 것은 아니니 가로로 내용물을 가운데에 두고 그 다음에 간격 값($s)과 같은 격자 갭(grid gap)과 패딩(padding)을 추가하자. 우리는 또한 `배경`을 설정해서 눈에 쉽게 띄도록 했다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 550px;"><iframe id="cp_embed_JjGavZv" src="//codepen.io/anon/embed/JjGavZv?height=550&amp;theme-id=1&amp;slug-hash=JjGavZv&amp;default-tab=result" height="550" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed JjGavZv" title="CodePen Embed JjGavZv" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

그리드를 좀 더 구체화한 후, 우리는 그리드 항목, 즉 이미지에 대해 동일한 작업을 합니다. 조금 더 균일하게 보이도록 `필터`를 바르고 약간 둥근 모서리와 `박스 그림자`로 포인트를 주자.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 550px;"><iframe id="cp_embed_mdVGzRJ" src="//codepen.io/anon/embed/mdVGzRJ?height=550&amp;theme-id=1&amp;slug-hash=mdVGzRJ&amp;default-tab=result" height="550" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed mdVGzRJ" title="CodePen Embed mdVGzRJ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이제 `메이슨리`를 지원하는 브라우저에 대해 우리가 해야 할 일은 그것을 선언하는 것이다.

대부분의 브라우저에서는 작동하지 않지만 앞에서 설명한 대로 플래그가 활성화된 상태에서 Firefox에서 원하는 결과를 생성합니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/07/firefox_masonry_solution.png?ssl=1)

하지만 다른 브라우저는 어떨까요? 여기서 우리는 ...이 필요합니다.

### JavaScript 예비

브라우저에서 실행해야 하는 JavaScript를 경제적으로 사용하기 위해 먼저 해당 페이지에 .grid-masonry 요소가 있는지, 브라우저가 `grid-template-rows`에 대한 `masonry` 값을 이해하고 적용했는지 여부를 확인합니다. 이 방법은 페이지에 이러한 그리드가 여러 개 있을 수 있다고 가정하는 일반적인 접근 방식입니다.

```js
let grids = [...document.querySelectorAll('.grid--masonry')];

if(grids.length && getComputedStyle(grids[0]).gridTemplateRows !== 'masonry') {
  console.log('boo, masonry not supported 😭')
}
else console.log('yay, do nothing!')
```

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/08/console_test_support_collage.png?ssl=1)

새로운 석조 기능이 지원되지 않으면 모든 석조 그리드에 대해 `행-갭`과 그리드 항목을 얻은 다음 여러 열(각 그리드에 대해 처음에는 `0`인 열)을 설정합니다.

```js
let grids = [...document.querySelectorAll('.grid--masonry')];

if(grids.length && getComputedStyle(grids[0]).gridTemplateRows !== 'masonry') {
  grids = grids.map(grid => ({
    _el: grid, 
    gap: parseFloat(getComputedStyle(grid).gridRowGap), 
    items: [...grid.childNodes].filter(c => c.nodeType === 1), 
    ncol: 0
  }));
  
  grids.forEach(grid => console.log(`grid items: ${grid.items.length}; grid gap: ${grid.gap}px`))
}
```

하위 노드가 요소 노드인지 확인해야 합니다(즉, `노드`가 있다는 의미입니다).`1`의 유형). 그렇지 않으면 항목 배열에서 캐리지 리턴으로 구성된 텍스트 노드로 끝날 수 있다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/08/console_test_items_gap.png?ssl=1)

더 진행하기 전에 페이지가 로드되어 있고 요소가 계속 이동하지 않는지 확인해야 합니다. 일단 우리가 그것을 처리한 후에, 우리는 각 그리드를 가지고 그것의 현재 열 수를 읽습니다. 이 값이 기존 값과 다르면 기존 값을 업데이트하고 그리드 항목을 다시 정렬합니다.

```js
if(grids.length && getComputedStyle(grids[0]).gridTemplateRows !== 'masonry') {
  grids = grids.map(/* same as before */);
 
  function layout() {
    grids.forEach(grid => {
      /* get the post-resize/ load number of columns */
      let ncol = getComputedStyle(grid._el).gridTemplateColumns.split(' ').length;

      if(grid.ncol !== ncol) {
        grid.ncol = ncol;
        console.log('rearrange grid items')
      }
    });
  }
 
  addEventListener('load', e => {  
    layout(); /* initial load */
    addEventListener('resize', layout, false)
  }, false);
}
```

레이아웃() 함수를 호출하는 것은 초기 로드와 크기 조정 시 모두 수행해야 하는 작업입니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/08/console_test_items_rearrange.png?ssl=1)

그리드 항목을 재정렬하려면 첫 번째 단계는 그리드 항목의 위쪽 여백을 제거하는 것입니다(현재 크기 조정 전에 석조 효과를 얻기 위해 0이 아닌 값으로 설정되었을 수 있음).

뷰포트가 한 칸만 있을 정도로 좁으면 끝이에요!

그렇지 않으면 첫 번째 `ncol` 항목은 건너뛰고 나머지는 반복한다. 고려된 각 항목에 대해, 우리는 위 항목의 하단 가장자리의 위치와 상단 가장자리의 현재 위치를 계산한다. 이것은 우리에게 우리들이 얼마나 수직으로 항목의 바닥 가장자리 위로 아래의 위쪽 가장자리는 그리드 격차 나아가야 합니다. 계산할 수 있습니다.

```js
/* if the number of columns has changed */
if(grid.ncol !== ncol) {
  /* update number of columns */
  grid.ncol = ncol;

  /* revert to initial positioning, no margin */
  grid.items.forEach(c => c.style.removeProperty('margin-top'));

  /* if we have more than one column */
  if(grid.ncol > 1) {
    grid.items.slice(ncol).forEach((c, i) => {
      let prev_fin = grid.items[i].getBoundingClientRect().bottom /* bottom edge of item above */, 
          curr_ini = c.getBoundingClientRect().top /* top edge of current item */;
      
      c.style.marginTop = `${prev_fin + grid.gap - curr_ini}px`
    })
  }
}
```

이제 크로스 브라우저 솔루션을 사용할 수 있습니다!

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 550px;"><iframe id="cp_embed_mdVzrXa" src="//codepen.io/anon/embed/mdVzrXa?height=550&amp;theme-id=1&amp;slug-hash=mdVzrXa&amp;default-tab=result" height="550" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed mdVzrXa" title="CodePen Embed mdVzrXa" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 몇 가지 사소한 개선 사항

실제 시나리오에서는 각 이미지를 전체 크기에 대한 링크로 싸서 큰 이미지가 라이트 박스에 열리게 하거나 축소판 그림으로 이동할 가능성이 더 높습니다.

```html
<section class='grid--masonry'>
  <a href='black_cat_large.jpg'>
    <img src='black_cat_small.jpg' alt='black cat'/>
  </a>
  <!-- and so on, more thumbnails following the first -->
</section>
```

이것은 우리가 CSS도 약간 변경해야 한다는 것을 의미합니다. 그리드 항목이 링크이므로 더 이상 그리드 항목에 `폭`을 명시적으로 설정할 필요는 없지만 이미지와는 달리 기본적으로 전체 행 높이를 커버하기 위해 확장되기 때문에 `얼라인 셀프: 시작`을 설정할 필요가 있다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 600px;"><iframe id="cp_embed_BajGQgQ" src="//codepen.io/anon/embed/BajGQgQ?height=600&amp;theme-id=1&amp;slug-hash=BajGQgQ&amp;default-tab=result" height="600" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed BajGQgQ" title="CodePen Embed BajGQgQ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

첫 번째 항목이 전체 그리드에 가로로 펼쳐지도록 할 수도 있습니다(즉, `높이`를 제한하고 이미지가 넘치거나 왜곡되지 않도록 해야 합니다).

또한 그리드 항목 목록을 얻을 때 다른 필터 기준을 추가하여 이 확장 항목을 제외해야 합니다.

```js
grids = grids.map(grid => ({
  _el: grid, 
  gap: parseFloat(getComputedStyle(grid).gridRowGap), 
  items: [...grid.childNodes].filter(c => 
    c.nodeType === 1 && 
    +getComputedStyle(c).gridColumnEnd !== -1
  ), 
  ncol: 0
})); 

```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 600px;"><iframe id="cp_embed_gOPQmGd" src="//codepen.io/anon/embed/gOPQmGd?height=600&amp;theme-id=1&amp;slug-hash=gOPQmGd&amp;default-tab=result" height="600" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed gOPQmGd" title="CodePen Embed gOPQmGd" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이 솔루션을 블로그와 같은 용도로 사용하고 싶다고 가정해 보겠습니다. 우리는 정확히 동일한 JS와 거의 동일한 석공별 CSS를 유지한다. 우리는 열이 가질 수 있는 최대 폭만 변경하고 첫 번째 항목에 대한 `최대 높이` 제한을 삭제한다.

아래 데모에서 볼 수 있듯이, NAT 솔루션은 블로그 게시물 그리드가 있는 이 경우에도 완벽하게 작동합니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 600px;"><iframe id="cp_embed_rNxXRGB" src="//codepen.io/anon/embed/rNxXRGB?height=600&amp;theme-id=1&amp;slug-hash=rNxXRGB&amp;default-tab=result" height="600" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed rNxXRGB" title="CodePen Embed rNxXRGB" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

또한 뷰포트의 크기를 조정하여 이 경우 뷰포트가 어떻게 작동하는지 확인할 수 있습니다.

그러나 예를 들어, 열의 너비가 다소 유연해지기를 원하는 경우 다음과 같은 예를 들 수 있습니다.

그런 다음 크기 조정에 문제가 있습니다.

텍스트 내용이 다르다는 사실과 결합된 그리드 항목의 폭의 변화는 특정 임계값을 초과할 때 그리드 항목의 텍스트 라인 수(따라서 `높이` 변경)를 얻을 수 있지만 다른 항목에 대해서는 그렇지 않다는 것을 의미한다. 열의 수가 변하지 않으면 수직 간격띄우기가 다시 계산되지 않고 겹치거나 더 큰 간격이 생기게 됩니다.

이를 수정하기 위해서는 적어도 한 항목의 `높이`가 현재 그리드에 대해 변경될 때마다 오프셋을 다시 계산해야 한다. 이는 현재 그리드의 0개 이상의 항목이 `높이`를 변경했는지도 테스트해야 함을 의미한다. 그런 다음 다음 "if" 블록 끝에 있는 이 값을 재설정하여 다음 번에 불필요하게 항목을 재배치하지 않도록 해야 합니다.

```js
if(grid.ncol !== ncol || grid.mod) {
  /* same as before */
  grid.mod = 0
}
```

좋아요, 하지만 이 `grid.mod` 값을 어떻게 바꾸죠? 첫 번째 아이디어는 크기 조정 관찰기를 사용하는 것이었습니다.

```js
if(grids.length && getComputedStyle(grids[0]).gridTemplateRows !== 'masonry') {
  let o = new ResizeObserver(entries => {
    entries.forEach(entry => {
      grids.find(grid => grid._el === entry.target.parentElement).mod = 1
    });
  });
  
  /* same as before */
  
  addEventListener('load', e => {
    /* same as before */
    grids.forEach(grid => { grid.items.forEach(c => o.observe(c)) })
  }, false)
}
```

이렇게 하면 그리드 열의 수가 변경되지 않더라도 필요한 경우 그리드 항목을 재배치하는 작업이 수행됩니다. 하지만 그것은 만약의 조건도 무의미하게 만든다!

최소 한 항목의 높이나 너비가 바뀔 때마다 grid.mod를 1로 바꾸기 때문이다. 폭 변화로 인해 텍스트 흐름으로 인해 항목의 높이가 변경됩니다. 그러나 너비 변화는 뷰포트의 크기를 조정할 때마다 발생하며 반드시 높이에 변화를 일으키는 것은 아니다.

그래서 나는 결국 이전 항목 높이를 저장하고 크기 조정 시 `grid.mod`가 `0`으로 유지되는지 여부를 확인하기 위해 이러한 항목 높이를 확인하기로 결정했다.

```js
function layout() {
  grids.forEach(grid => {
    grid.items.forEach(c => {
      let new_h = c.getBoundingClientRect().height;
    
      if(new_h !== +c.dataset.h) {
        c.dataset.h = new_h;
        grid.mod++
      }
    });
   
    /* same as before */
  })
}
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 600px;"><iframe id="cp_embed_QWyeXBY" src="//codepen.io/anon/embed/QWyeXBY?height=600&amp;theme-id=1&amp;slug-hash=QWyeXBY&amp;default-tab=result" height="600" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed QWyeXBY" title="CodePen Embed QWyeXBY" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

다 됐다! 더 이상 어쩔 수 없다! 우리는 이제 멋진 경량 솔루션을 갖게 되었습니다. 미니어처 자바스크립트는 800바이트 이하이며, 석공 관련 스타일은 300바이트 이하이다.

### 하지만, 하지만...

자, `@supports`는 여기에서 사용되는 어떤 새로운 CSS 기능보다 브라우저 지원이 더 잘 되기 때문에, 우리는 좋은 것을 안에 넣을 수 있고 비지원 브라우저용 기본 비모조 그리드를 가질 수 있다. 이 버전은 IE9까지 계속 작동합니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/07/ie_fallback_screen.png?ssl=1)

똑같지는 않을 수도 있지만, 괜찮아 보이고 완벽하게 기능적이죠. 브라우저를 지원한다고 해서 모든 시각적 사탕이 복제되는 것은 아닙니다. 그것은 페이지가 작동되고 깨지거나 끔찍해 보이지 않는다는 것을 의미한다.

흠, 우리는 자바스크립트를 통해 추가하는 루트 요소에 js 클래스가 있어야만 화려한 스타일을 적용할 수 있어! 그렇지 않으면 모든 품목의 크기가 동일한 기본 그리드를 얻을 수 있습니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/07/no_js_fallback_screen.png?ssl=1)