---
layout: post
title: "현대 개발에서 테이블과 수레 방어"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/10/table-on-clouds.png
tags: FLOAT,TABLE-LAYOUT,TABLES
---


20 년 전에는 테이블이 웹 페이지를 HTML로 만드는 주요 방법이었습니다.
 웹 빌더는 일부 "디자인"을 사용하여 페이지를 구성하는 일관된 제어를 제공했습니다.
 더 이상 사이트는 선형 방식으로 위에서 아래로만있을 필요가 없었습니다. 왼쪽에서 오른쪽으로, 위에서 아래로 정렬되는 열로 설정할 수 있습니다.
 그 당시에는 엄청난 돌파구로 여겨졌습니다.
 

그러나 테이블은 페이지를 레이아웃하도록 설계되지 않았으며 실제로 오늘날 이러한 방식으로 사용하면 모든 종류의 문제가 발생합니다.
 편리한 해킹 이었지만 그 당시에는 특히 이전 방식으로는 처리 할 수 없었던 매우 구체적인 레이아웃을 달성하려는 사람들에게 매우 반가 웠습니다.
 

현대로 빠르게 넘어 가면 이제 테이블 레이아웃 접근 방식과 관련된 수많은 문제가 분명해졌습니다.
 접근성은 큰 문제입니다 .` <table>`,`<th>`,`<tr>`및`<td>`요소는 특히 여러 수준 깊이 중첩 된 경우 정확하게 액세스 할 수 없습니다.
 화면 판독기 (웹 콘텐츠를 읽고 접근성 준수의 척도 역할을하는 장치)는이를 일관된 콘텐츠 블록으로 구문 분석하는 데 어려움을 겪습니다.
 그렇다고 테이블이 나쁘다는 것은 아닙니다.
 단순히 레이아웃 메커니즘으로 의도 된 것이 아닙니다.
 

이 테이블 레이아웃을 확인하십시오.
 VoiceOver 또는 액세스 할 수있는 화면 읽기 소프트웨어를 통해 자유롭게 실행하십시오.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_dyMwNoO" src="//codepen.io/anon/embed/dyMwNoO?height=450&amp;theme-id=1&amp;slug-hash=dyMwNoO&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed dyMwNoO" title="CodePen Embed dyMwNoO" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

예,이 예는 일반적인 웹 사이트 레이아웃과 매우 유사하지만 표만으로 제작되었습니다.
 표 형식 데이터 이외의 다른 용도로 사용하기 시작하는 순간 얼마나 빨리 비대 해지고 액세스 할 수 없게되는지 확인할 수 있습니다.
 

그래서 20 년이 넘는 시간이 지나면 테이블을 아예 피해야한다고 생각할 수 있습니다.
 테이블 기반 레이아웃을 출시 한 적이 없다면 의심 할 여지없이 우리의 전쟁 이야기를 들어 보셨을 것입니다. 그런 이야기는 결코 친절하지 않습니다.
 마치 표를 "HTML 요소의 Internet Explorer"로 만든 것과 같습니다.
 

그러나 테이블은 실제로 웹상의 목적을 충족시키고 올바르게 사용되면 실제로 액세스 할 수 있기 때문에 완전히 공정하지 않습니다.
 

테이블은 의미 상 관련이 있고 선형과 유사한 형식으로 가장 잘 표시되는 데이터를 처리하도록 설계되었습니다.
 그렇습니다. 우리는 2020 년에 오늘 테이블을 사용할 수 있으며, 이는 앞으로도 몇 년 동안 계속해서 적용될 것입니다.
 

다음은 표 형식 데이터를 정확히 표시하는 데 사용되는 표입니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_JjXwEvW" src="//codepen.io/anon/embed/JjXwEvW?height=450&amp;theme-id=1&amp;slug-hash=JjXwEvW&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed JjXwEvW" title="CodePen Embed JjXwEvW" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

2000 년대 초 웹 표준을 향한 추진으로 테이블은 다른 접근 방식, 특히 CSS`float` 속성을 선호하는 레이아웃 솔루션으로 밀려났습니다.
 디자이너와 개발자 모두 기뻐했습니다. 처음으로 마크 업이 필요한 마크 업 작업을 수행하도록하고, 필요한 시각적 작업을 수행하는 CSS에 대한 우려를 완전히 분리했기 때문입니다.
 그 결과 코드가 더 깨끗하고 유지 관리가 쉬워졌고 결과적으로 접근성과 같은 진정한 표준과 SEO와 같은 다른 관행에 실제로 집중할 수있었습니다.
 

이 예의 차이점을 보거나 듣습니까?
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 550px;"><iframe id="cp_embed_wvWwZRJ" src="//codepen.io/anon/embed/wvWwZRJ?height=550&amp;theme-id=1&amp;slug-hash=wvWwZRJ&amp;default-tab=result" height="550" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed wvWwZRJ" title="CodePen Embed wvWwZRJ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

우리 중 많은 사람들이 과거에 수레를 사용했습니다.
 원래는 콘텐츠가 왼쪽이나 오른쪽으로 떠있는 이미지 주위로 흐르면서도 문서 흐름에 남아 있도록 설계되었습니다.
 이제 우리는 그리드 및 플렉스 박스와 같은 새로운 레이아웃 기능을 얻었으므로 플로트도 일종의 길가에 떨어졌습니다.
 오랫동안 (ab) 사용 된 후 테이블로 랩.
 

그러나 수레는 여전히 유용하고 관련성이 있습니다!
 사실, 우리는`shape-outside` 속성이 작동하기 위해 그것들을 사용해야합니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_abNPMVN" src="//codepen.io/anon/embed/abNPMVN?height=450&amp;theme-id=1&amp;slug-hash=abNPMVN&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed abNPMVN" title="CodePen Embed abNPMVN" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

합법적 인`float` 사용 사례는 스타일이 지정된`<blockquote>`주위에 콘텐츠를 래핑하는 것일 수 있습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_zYqQeyE" src="//codepen.io/anon/embed/zYqQeyE?height=450&amp;theme-id=1&amp;slug-hash=zYqQeyE&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed zYqQeyE" title="CodePen Embed zYqQeyE" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

그리드, 플렉스 박스 및 다중 열 레이아웃과 같은 CSS 기능은 오늘날 우리가 작업해야하는 훌륭한 도구 중 하나입니다.
 더 많은 레이아웃 가능성, 더 깔끔하고 더 쉽게 액세스 할 수있는 코드를 통해 향후 수년 동안 우리의 레이아웃 접근 방식을 유지할 것입니다.
 

이 기사 전체에서 살펴본 것과 동일한 레이아웃의이 flexbox 예제에는 해킹이나 추가 코드가 없습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 575px;"><iframe id="cp_embed_GRqKbNX" src="//codepen.io/anon/embed/GRqKbNX?height=575&amp;theme-id=1&amp;slug-hash=GRqKbNX&amp;default-tab=result" height="575" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed GRqKbNX" title="CodePen Embed GRqKbNX" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

따라서 다음에 테이블이나 수레를 고려할 때 자신감을 가지고 손을 뻗으십시오!
 음, 상황이 의도 된 용도와 일치한다는 것을 알고있을 때.
 나는 당신이 테이블과 수레에 대한 활력을 되찾은 열정으로 여기서 벗어나기를 기대하는 것과는 다릅니다.
 올바르게 사용하면 완벽하게 유효한 기술이며 전체 도구 세트에서 없어서는 안될 부분입니다.
 