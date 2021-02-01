---
layout: post
title: "CSS 그리드를 사용한 성배 레이아웃
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2021/01/holy-grail-wire.jpg
tags: GRID,HOLY GRAIL
---


독자는 CSS Flexbox에서이 레이아웃을 구축하는 방법을 구체적으로 묻는 글을 썼습니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2021/01/unnamed.png?resize=193%2C193&ssl=1)

내 대답 : 그것은 CSS Flexbox의 레이아웃이 아닙니다.
 필요한 경우 해제 할 수 있지만 탐색 및 기사를 상위 요소로 그룹화하는 것과 같은 일종의 자만심이 필요합니다 (더 많은 그룹화가 아닌 경우).
 CSS Grid는 이런 종류의 레이아웃을 설명하기 위해 탄생했으며, 브라우저 지원이 요즘 거의 동일하다는 것은 말할 것도없고 작업하기 훨씬 쉬울 것입니다.
 

### “성배”란 무엇을 의미합니까?
 

보세요, 아이들, 웹의 레이아웃이 너무 버벅 거 렸기 때문에 위의 믿을 수없는 간단한 다이어그램은 상대적으로 풀기가 어려웠습니다. 특히 높이를 맞추기 위해 "열"이 필요한 경우에는 더욱 그렇습니다.
 말도 안되지만 그게 거래 였어
 우리는 매우 이상한 해킹을 사용하여 (예 : 포지티브 패딩과 짝을 이루는 큰 음의 여백) 시간이 지남에 따라 더 깨끗한 트릭 (예 : 열을 모방 한 배경 이미지)으로 진화했습니다.
 그것을 이끌어내는 기술은 그것을 성배라고 불렀습니다.
 (더 명확하게하기 위해 일반적으로 성배는 중간에 콘텐츠가있는 3 열 레이아웃을 의미하지만 주요 포인트는 동일한 높이 열이었습니다).
 

CSS는 이제 훨씬 더 강력 해 졌으므로이 기본 레이아웃을 수행하는 것과 같은 합리적인 작업을 수행하기 위해 해킹에 의존하지 않고도 사용할 수 있습니다.
 

### 여기 CSS 그리드에 있습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_ZEpPWKO" src="//codepen.io/anon/embed/ZEpPWKO?height=450&amp;theme-id=1&amp;slug-hash=ZEpPWKO&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed ZEpPWKO" title="CodePen Embed ZEpPWKO" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이 그리드는`grid-template-columns` 및`grid-template-rows`로 설정됩니다.
 이렇게하면 이러한 주요 사이트 섹션의 위치를 구체적으로 지정할 수 있습니다.
 

### 나는 여분의 물건을 넣었다
 

- 다른 날 그리드 영역 사이에 1px 선을 작성하는 것에 대해 다른 질문이 왔습니다.
 트릭은 부모가 배경색을 갖고`gap : 1px;`를 사용하는 것처럼 간단하므로 위의 데모에서 수행했습니다.
 
- 작은 화면이 단일 열 레이아웃으로 이동할 가능성이 높습니다.
 위의 미디어 쿼리에서 그렇게했습니다.
 가끔 부모에서`display : block;`을 사용하여 그리드를 끄지 만 여기서는`grid`를 켜고 열과 행을 재설정했습니다.
 이런 식으로 우리는 여전히 갭을 확보하고 필요한 경우 모든 것을 섞을 수 있습니다.
 
- 제가 최근에 물어 본 또 다른 질문은 위의 데모에서 볼 수있는 미묘한 "본체 테두리"효과입니다.
 나는 바디와 그리드 래퍼 사이에 약간의 패딩을 사용하여 가능한 한 간단하게했습니다.
 원래 본문과 HTML 요소 사이에했지만 전체 페이지 격자의 경우 격자에 본문을 사용하는 것보다 래퍼 div를 사용하는 것이 더 현명하다고 생각합니다.
 이렇게하면 몸에 물건을 주입하는 타사 제품이 레이아웃을 이상하게 만들지 않습니다.
 