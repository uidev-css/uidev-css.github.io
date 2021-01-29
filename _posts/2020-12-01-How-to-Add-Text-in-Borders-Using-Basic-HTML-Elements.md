---
layout: post
title: "기본 HTML 요소를 사용하여 테두리에 텍스트를 추가하는 방법
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/11/border-text-fieldset-legend.jpg
tags: BORDER,FIELDSET,FORMS,LEGEND
---


일부 HTML 요소에는 `<input type = "checkbox">`요소의 불편할 정도로 작은 사각형,`<meter>`요소의 제한된 색상 막대, "뭔가 신경 쓰이는"화살표와 같은 미리 설정된 디자인이 함께 제공됩니다.
 `<details>`요소.
 기능을 사용하면서 웹 사이트의 현대적인 미학과 일치하도록 스타일을 지정할 수 있습니다.
 현대 웹 디자인에서는 기본 모양과 기능이 덜 필요하기 때문에 거의 사용되지 않는 많은 요소가 있습니다.
 

이러한 HTML 요소 중 하나는 하위 요소 인`<legend>`와 함께`<fieldset>`입니다.
 

`<fieldset>`요소는 전통적으로 양식 컨트롤을 그룹화하고 액세스하는 데 사용됩니다.
 화면에서 그룹화 된 콘텐츠 주위에 테두리가있어 그룹화를 시각적으로 알 수 있습니다.
 이 그룹의 캡션은`<fieldset>`의 첫 번째 하위 항목으로 추가 된`<legend>`요소 내에 제공됩니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_yLaLXJb" src="//codepen.io/anon/embed/yLaLXJb?height=250&amp;theme-id=1&amp;slug-hash=yLaLXJb&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed yLaLXJb" title="CodePen Embed yLaLXJb" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

`<fieldset>`과`<legend>`의 조합은 테두리가있는 곳에 캡션이 배치되고 테두리의 선이 텍스트를 통과하지 않는 고유 한 기성품 `테두리의 텍스트`디자인을 만듭니다.
 경계선은 캡션 텍스트의 시작 부분을 만나면 "끊어지고"텍스트가 끝난 후 다시 시작됩니다.
 

이 게시물에서는`<fieldset>`및`<legend>`콤보를 사용하여 빠르고 쉽게 코딩하고 업데이트 할 수있는보다 현대적인 테두리 텍스트 디자인을 만듭니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_bGeOqzv" src="//codepen.io/anon/embed/bGeOqzv?height=450&amp;theme-id=1&amp;slug-hash=bGeOqzv&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed bGeOqzv" title="CodePen Embed bGeOqzv" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

네 테두리의 경우 각각 내부에`<legend>`요소를 포함하는 네 개의`<fieldset>`요소가 필요합니다.
 `<legend>`요소 내부의 테두리에 표시 될 텍스트를 추가합니다.
 

```html
<fieldset><legend>Wash Your Hands</legend></fieldset>
<fieldset><legend>Stay Apart</legend></fieldset>
<fieldset><legend>Wear A Mask</legend></fieldset>
<fieldset><legend>Stay Home</legend></fieldset>
```

시작하려면`<fieldset>`요소를 그리드 셀에 쌓고 테두리를 지정합니다.
 원하는 방식으로 스택 할 수 있습니다. 반드시 그리드 일 필요는 없습니다.
 

기본적으로`<legend>`요소의 텍스트가`<fieldset>`의 상단 테두리에 나타나기 때문에 각`<fieldset>`요소의 상단 테두리 만 표시되고 나머지 가장자리는 투명합니다.
 

또한 모든`<fieldset>`요소에`border-box` 값이있는`box-sizing` 속성을 제공하므로`<fieldset>`요소의 너비와 높이에 테두리 및 패딩 크기도 포함됩니다.
 나중에 이렇게하면`<legend>`요소의 스타일을 지정할 때 평탄한 디자인이 생성됩니다.
 

```css
body {
  display: grid; 
  margin: auto; /* to center */
  margin-top: calc(50vh - 170px); /* to center */
  width: 300px; height: 300px; 
}

fieldset {
  border: 10px solid transparent; 
  border-top-color: black; 
  box-sizing: border-box; 
  grid-area: 1 / 1; /* first row, first column */
  padding: 20px; 
  width: inherit; 
}
```

그런 다음 상단 테두리를 디자인의 측면 및 하단 테두리로 사용하기 위해 마지막 세 개의`<fieldset>`요소를 회전합니다.
 

```css
/* rotate to right */
fieldset:nth-of-type(2){ transform: rotate(90deg); }
/* rotate to bottom */
fieldset:nth-of-type(3){ transform: rotate(180deg); }
/* rotate to left */
fieldset:nth-of-type(4){ transform: rotate(-90deg); }
```

다음은`<legend>`요소의 스타일링입니다.
 `<legend>`요소를 사용하여 부드러운 테두리 텍스트를 만드는 핵심은`line-height`를 0 (또는 충분히 작게)하는 것입니다.
 선 높이가 크면 해당 테두리의 위치가 바뀌고 테두리가 아래로 밀립니다.
 그리고 테두리가 선 높이와 함께 이동하면 디자인의 네면을 모두 연결할 수 없으며 테두리를 다시 조정해야합니다.
 

```css
legend {
  font: 15pt/0 'Averia Serif Libre'; 
  margin: auto; /* to center */
  padding: 0 4px; 
}

fieldset:nth-of-type(3) > legend { 
  transform: rotate(180deg);
}
```

나는`font` 속기 속성을 사용하여`<legend>`요소의`font-size`,`line-height` 및`font-family` 속성에 대한 값을 제공했습니다.
 

디자인의 하단 테두리에 텍스트를 추가하는`<legend>`요소 인`fieldset : nth-of-type (3)> legend`는 회전 된`<fieldset>`상위 요소로 인해 거꾸로되어 있습니다.
 `<legend>`요소를 수직으로 뒤집어 텍스트를 오른쪽 위로 표시합니다.
 

첫 번째`<fieldset>`요소에 이미지를 추가하면 다음과 같은 결과가 나타납니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_bGeOqzv" src="//codepen.io/anon/embed/bGeOqzv?height=450&amp;theme-id=1&amp;slug-hash=bGeOqzv&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed bGeOqzv" title="CodePen Embed bGeOqzv" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

측면 여백은 테두리를 따라 텍스트를 이동할 수 있습니다.
 `자동`값이있는 왼쪽 및 오른쪽 여백은 위의 펜에서 볼 수 있듯이 텍스트를 중앙에 배치합니다.
 `auto`값이있는 왼쪽 여백 만 오른쪽 여백에 대해 텍스트를 오른쪽으로 플러시하고 그 반대의 경우도 마찬가지입니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_yLJWVdR" src="//codepen.io/anon/embed/yLJWVdR?height=450&amp;theme-id=1&amp;slug-hash=yLJWVdR&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed yLJWVdR" title="CodePen Embed yLJWVdR" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

보너스 : 간단한 기하학적 우회 후 동일한 기술을 사용하여 만든 팔각형 디자인이 있습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_JjKqbQj" src="//codepen.io/anon/embed/JjKqbQj?height=450&amp;theme-id=1&amp;slug-hash=JjKqbQj&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed JjKqbQj" title="CodePen Embed JjKqbQj" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>