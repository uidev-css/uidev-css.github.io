---
layout: post
title: "grid-auto-flow : CSS 그리드 :: flex-direction : Flexbox
 "
author: 'CSS Dev'
thumbnail: undefined
tags: 
---


상위 요소를`display : flex`로 설정하면 하위 요소가 다음과 같이 왼쪽에서 오른쪽으로 정렬됩니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 200px;"><iframe id="cp_embed_e530f9dec0ccd071e611fdb177bf6f69" src="//codepen.io/anon/embed/e530f9dec0ccd071e611fdb177bf6f69?height=200&amp;theme-id=1&amp;slug-hash=e530f9dec0ccd071e611fdb177bf6f69&amp;default-tab=result" height="200" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed e530f9dec0ccd071e611fdb177bf6f69" title="CodePen Embed e530f9dec0ccd071e611fdb177bf6f69" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이제 flexbox로 할 수있는 멋진 작업 중 하나는 방향을 변경하여 자식 요소가 열에서 서로 위에 수직으로 쌓 이도록하는 것입니다.
 `flex-direction` 속성 (또는`flex-flow` 속기)을 사용하여이를 수행 할 수 있습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 300px;"><iframe id="cp_embed_93ce5a5d49665f1b1368ee882ba36ca4" src="//codepen.io/anon/embed/93ce5a5d49665f1b1368ee882ba36ca4?height=300&amp;theme-id=1&amp;slug-hash=93ce5a5d49665f1b1368ee882ba36ca4&amp;default-tab=css,result" height="300" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed 93ce5a5d49665f1b1368ee882ba36ca4" title="CodePen Embed 93ce5a5d49665f1b1368ee882ba36ca4" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

좋아.
 그러나 CSS Grid로 어떻게 이런 일을 할 수 있습니까?
 에서와 같이 모든 하위 요소를 다음과 같이 정렬하고 싶다고 가정 해 보겠습니다.
 

```html
1 3 5 7
--------
2 4 6 8
```

… 대신 :
 

```html
1 2 3 4
--------
5 6 7 8
```

기본적으로 CSS Grid를 사용하도록 부모 요소를 설정하면 요소는 flexbox와 같이 왼쪽에서 오른쪽으로 배치됩니다.
 아래 예에서는 그리드에 6 개의 열과 2 개의 행이 있다고 말한 다음 자식 요소가 두 번째 열을 채우기 전에 첫 번째 행의 각 열을 채우도록합니다.
 아시다시피 표준 줄 바꿈 동작입니다.
 

```css
.parent {
  display: grid;
  grid-template-columns: repeat(6, 1fr);
  grid-template-rows: repeat(2, 150px);
  gap: 20px;
}
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_fc23bc3fff9c4346e0335d41dfeba058" src="//codepen.io/anon/embed/fc23bc3fff9c4346e0335d41dfeba058?height=450&amp;theme-id=1&amp;slug-hash=fc23bc3fff9c4346e0335d41dfeba058&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed fc23bc3fff9c4346e0335d41dfeba058" title="CodePen Embed fc23bc3fff9c4346e0335d41dfeba058" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

기본적으로 여기서 원하는 것은 그 반대입니다. 자식 요소가 열 1, 행 1 및 행 2를 채우고 다음 열로 이동합니다.
 즉, 컬럼 랩핑!
 행과 열로 그리드를 만들면 해당 요소를 해당 위치에 개별적으로 배치 할 수 있다는 것을 알고 있습니다.
 이렇게 :
 

```css
.parent {
  display: grid;
  grid-template-columns: repeat(6, 1fr);
  grid-template-rows: repeat(6, 150px);
}

.child-1 {
  grid-column: 1;
  grid-row: 1;
}

.child-2 {
  grid-column: 1;
  grid-row: 2;
}

.child-3 {
  grid-column: 2;
  grid-row: 1;
}

/* etc, etc. */
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 430px;"><iframe id="cp_embed_65ed97f438b7150833c1db20c9e63fb3" src="//codepen.io/anon/embed/65ed97f438b7150833c1db20c9e63fb3?height=430&amp;theme-id=1&amp;slug-hash=65ed97f438b7150833c1db20c9e63fb3&amp;default-tab=result" height="430" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed 65ed97f438b7150833c1db20c9e63fb3" title="CodePen Embed 65ed97f438b7150833c1db20c9e63fb3" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

좋아요, 깔끔 해요!
 이것은 내가 원하는 것을 얻지 만 각 항목의 위치를 개별적으로 설정해야하는 엄청난 고통입니다.
 `위치 : 절대`를 사용하는 것 같고 특히 똑똑하지 않은 것 같아요.
 그렇다면이 레이아웃이 저를 위해 이루어지기를 원하면 각각의 새 자식 요소가 올바른 위치에 정렬됩니다.
 

내가 요청하는 것은 (제 생각에) 이것이`flex-direction : column`의 CSS 그리드 버전이 있습니까?
 

글쎄, 조금 둘러 본 후 Rachel Andrew는 그녀의 훌륭한 놀이터 인 Grid by Example에서 정답을 알려주었습니다.
 이 데모에서 볼 수 있듯이 Rachel은이를 수행하는 방법을 보여줍니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_QbewmG" src="//codepen.io/anon/embed/QbewmG?height=450&amp;theme-id=1&amp;slug-hash=QbewmG&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed QbewmG" title="CodePen Embed QbewmG" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

니토!
 Rachel은`grid-auto-flow` 속성을 사용하여이를 수행합니다. 이것은 그리드 컨테이너에 빈 공간을 자식 요소로 채우는 방법을 알려줍니다.
 그래서 다음과 같이 작성하면됩니다.
 

```css
.parent {
  display: grid;
  grid-auto-flow: column;
  /* set up columns and rows here */
}
```

기본적으로 그리드의 하위 요소는 행이 채워질 때까지 각 열을 채운 다음 그 아래의 다음 행으로 흐릅니다.
 그리드의 행을 먼저 채우므로`grid-auto-flow`의 기본값이`row`로 설정되는 이유입니다.
 그러나 `column`으로 설정하면 각 새 요소가 열 2로 이동하기 전에 열 1의 모든 공간을 채 웁니다.
 

```css
.parent {
  display: grid;
  grid-auto-flow: column;
  grid-template-columns: repeat(6, 1fr);
  grid-template-rows: repeat(2, 150px);
}
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_764a7963fcc82ec3db78cd46ee83efce" src="//codepen.io/anon/embed/764a7963fcc82ec3db78cd46ee83efce?height=450&amp;theme-id=1&amp;slug-hash=764a7963fcc82ec3db78cd46ee83efce&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed 764a7963fcc82ec3db78cd46ee83efce" title="CodePen Embed 764a7963fcc82ec3db78cd46ee83efce" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이것이 `grid-auto-flow`의 흐름 부분이 의미하는 바이며, 무섭게 보였기 때문에 오랫동안 나는 속성을 무시했습니다.
 `grid-auto-flow`라는 단어를 읽는 것만으로도 노트북을 끄고 바다에 들어가고 싶을 정도입니다.
 

그러나!
 이는 매우 유용한 속성이며 특히 `flex-direction`의 CSS 그리드 버전으로 생각하면 의미가 있습니다.
 