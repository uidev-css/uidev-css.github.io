---
layout: post
title: "수직 정렬 달성(감사합니다, 서브그리드!)"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/09/vertical-alignment-subgrid.png
tags: FLEXBOX,GRID,SUBGRID
---


우리의 수직 정렬 도구는 최근 들어 많이 좋아졌다. 웹 사이트 디자이너 시절에는 960px의 넓은 홈페이지 디자인을 배치하고 12단 그리드를 사용하여 페이지를 가로로 정렬했습니다. 언론의 질문이 이어졌고, 이에 따라 심각한 정신 전환이 필요했다. 물론 몇 가지 큰 문제를 해결했지만, 요소들이 겹치거나 레이아웃에서 이리저리 옮겨질 때 정렬을 다루는 것과 같은 새로운 문제를 도입했습니다.

한 가지 특별한 시나리오, 즉 단추가 몇 개 들어 있는 "바"를 살펴보겠습니다. 이 버튼에는 두 개의 그룹이 있으며, 각각은 `<전설>이 있는 `<필드 세트` 안에 포함되어 있다.

대형 화면에서는 다음과 같은 모든 것이 준비됩니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/09/Ta9HpreE.png?resize=1600%2C128&ssl=1)

여기에 이러한 레이아웃을 수행하는 매우 기본적인 CSS 방법이 있으며 모바일 중단점에서 두 개의 "행"으로 구분됩니다.

```css
.accessibility-tools fieldset {
  width: 48%;
  float: left;
  margin-right: 1%;
}
 
/* Mobile */
@media only screen and (max-width: 480px) {
  .accessibility-tools fieldset {
    width: 100%;
  }
}
```

작은 화면에서는 다음과 같은 결과가 나옵니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/09/v-4wXcfo.png?resize=894%2C294&ssl=1)

이것이 문제입니다. 수직 정렬의 부족입니다. 이 버튼을 버튼 가장자리가 서로 잘 정렬되는 보다 쾌적한 배열로 정렬하고 싶다고 가정해 보겠습니다.

우선 다음과 같은 매직넘버를 사용하여 요소들이 다양한 중단점에 잘 정렬되도록 하기 위해 고정 폭의 픽셀 기반 CSS 솔루션을 사용할 수 있다.

```css
/* Mobile */
@media only screen and (max-width: 480px) {
  legend {
    width: 160px;
  }
  button {
    width: 130px;
  }
}
```

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/09/N4S17THI.png?resize=1014%2C298&ssl=1)

그게 요령이다.

그러나 이 문제는 유연성이 떨어집니다. 매직 넘버(특정 콘텐츠에 따른 고정픽셀 값)는 차치하고 내가 할 수 있는 시간에서 벗어나려는 미디어 쿼리의 활용에도 의존했다. 저는 이 문제에 대해 블로그에 있는 "Sass에서 벗어나기"라는 게시물에서 논의했습니다.

> CSS의 최신 기능으로 이동하면서 고유 코드로 특정 화면 크기를 지정할 필요가 없어졌다.

응답할 각 버튼과 라벨이 필요합니다.

- 사용 가능한 공간
- 그들의 만족.

그리고!

- 주변의 다른 요소들

### 사용 가능한 공간

미디어 쿼리 사용의 문제는 조정 중인 요소 주변의 공간을 고려하지 않는다는 점입니다. Heydon Pickering의 "The Flexbox holy albatross"의 이미지에서는 이 점을 완벽하게 보여줍니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/09/cZnACNx8.png?resize=1200%2C482&ssl=1)

내가 진정으로 원하는 것은 두 번째 <필드 세트>가 한 줄에 더 이상 가지런히 들어맞을 수 없을 때에만 첫 번째 줄 아래를 감싸는 것이다.

### 플렉스 박스로 끝낼 수 있을까요?

Flexbox의 주요 판매 포인트는 주변 공간에 대응하는 요소를 만들 수 있는 기능입니다. 구성요소는 추가 공간을 채우도록 "변형"하고 더 작은 공간에 맞게 축소할 수 있습니다.

이런 상황에서 플렉스랩(Flex-wrap) 속성은 랩(wrap)으로 설정된다. 이는 두 요소 모두 더 이상 한 라인에 맞지 않는 순간 두 번째 선으로 마무리된다는 것을 의미한다.

```css
.wrapper--accessibility-tools {
  display: flex;
  flex-wrap: wrap;
}  

```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 300px;"><iframe id="cp_embed_VwLpGrm" src="//codepen.io/anon/embed/VwLpGrm?height=300&amp;theme-id=1&amp;slug-hash=VwLpGrm&amp;default-tab=result" height="300" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed VwLpGrm" title="CodePen Embed VwLpGrm" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

플렉스 랩 속성은 세 가지 값을 사용할 수 있습니다. 기본값은 `nowrap`으로, 항목은 한 줄에 남겨둡니다. `wrap` 값을 사용하면 요소가 여러 줄로 흐를 수 있습니다. 그 다음에는 `랩-리버스`가 있는데, 이것은 아이템을 포장할 수 있지만 - 기다려 - 반대로 (요소가 랩을 할 때, 요소들이 왼쪽에서 오른쪽의 상황에서 이전 행 위로 올라가는 것을 보는 것은 이상하다.)

플렉스박스를 사용하면 레이아웃이 상당히 경직되는 것을 막을 수 있지만 수직 정렬 문제를 제거하기 위해서는 여전히 `최소 폭` 값이 필요하다. 그래서: 가깝지만 시가는 없어요.

### 그리드가 도움이 될까요?

CSS 그리드(CSS Grid)는 웹 디자이너와 개발자가 직면한 지속적인 레이아웃 문제를 해결하기 위해 특별히 만들어진 최초의 CSS 모듈이다. Flexbox를 직접 대체하는 것이 아니라 일반적으로 두 모듈이 서로 잘 작동합니다.

플렉스 박스와 마찬가지로 그리드를 사용하여 각 `필드 세트`가 필요한 만큼의 공간 또는 적은 공간을 차지하도록 할 수 있다. 바로 가기 전에 자동 채우기 및 자동 맞춤 키워드(반복()를 활용하여 그리드 항목이 미디어 쿼리 없이 여러 줄로 흐를 수 있도록 할 수 있다. 그 차이는 다소 미묘하지만 사라 소이단의 "CSS 그리드의 자동 크기 조정 열: 자동 채우기 대 자동 맞춤"에서 잘 설명된다. 자동 맞춤을 사용합니다.

```css
.wrapper--accessibility-tools {
  display: grid;
  grid-template-columns: repeat(auto-fit, 450px);
  grid-gap: 10px;
} 

```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 300px;"><iframe id="cp_embed_PoqpyRL" src="//codepen.io/anon/embed/PoqpyRL?height=300&amp;theme-id=1&amp;slug-hash=PoqpyRL&amp;default-tab=result" height="300" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed PoqpyRL" title="CodePen Embed PoqpyRL" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

플렉스 박스 예와 마찬가지로 라벨 폭에 대한 절대값을 설정하여 `<fieldset> 요소를 쌓을 때 정렬해야 합니다.

### 그리드를 사용한 또 다른 접근 방식

CSS 그리드는 또한 유연한 그리드 트랙을 사용하여 요소들이 그들의 콘텐트를 기반으로 반응할 수 있게 한다. CSS 그리드는 백분율, 상대 단위 또는 픽셀과 같은 다른 길이 값 외에도 1fr이 사용 가능한 공간의 한 부분을 차지하며 2fr이 사용 가능한 공간의 두 부분을 차지하는 분수 단위(fr)를 사용합니다. 여기서 두 개의 동일한 열을 설정합니다.

```css
.wrapper--accessibility-tools {
  display: grid;
  grid-template-columns: 1fr 1fr;
  grid-gap: 10px;
} 

```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 300px;"><iframe id="cp_embed_poyeMgQ" src="//codepen.io/anon/embed/poyeMgQ?height=300&amp;theme-id=1&amp;slug-hash=poyeMgQ&amp;default-tab=result" height="300" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed poyeMgQ" title="CodePen Embed poyeMgQ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

또한 사용 가능한 공간에 맞춰 구부러지지만 지정된 크기보다 좁게 축소되지 않는 그리드 트랙을 생성하는 `minmax()` 기능도 있습니다.

```css
.wrapper--accessibility-tools {
  display: grid;
  grid-template-columns: minmax(auto, max-content) minmax(auto, max-content);
  grid-gap: 10px;
} 

```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 300px;"><iframe id="cp_embed_poyeMgQ" src="//codepen.io/anon/embed/poyeMgQ?height=300&amp;theme-id=1&amp;slug-hash=poyeMgQ&amp;default-tab=result" height="300" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed poyeMgQ" title="CodePen Embed poyeMgQ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이 두 데모 모두 작동하며 절대 값 또는 장치별 CSS가 없습니다. 결과는 이상과는 거리가 멀지만, 각 그리드는 이제 서로 다른 지점에서 반응합니다. 큰 문제는 아닐지 몰라도, 확실히 대단하지는 않다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/09/Screenshot-2020-09-22-at-14.25.56.png?resize=972%2C390&ssl=1)

이는 컨테이너에 `디스플레이: 그리드`를 추가할 때 해당 컨테이너의 직접 하위 항목만 그리드 항목이 되기 때문입니다. 이는 우리가 사용한 고유 크기 조정 단위가 동일한 그리드의 요소와만 관련이 있다는 것을 의미한다.

### 하위 그리드 사용

내 목표를 달성하기 위해서는 형제간 그리드 컨테이너의 요소에 반응할 단추와 라벨이 필요합니다. CSS 그리드 레벨 2에는 하위 그리드 기능이 포함되어 있습니다. 우리는 항상 그리드를 중첩시킬 수 있었지만, 각 그리드 컨테이너 내의 요소는 독립적이었다. 하위 그리드를 사용하면 상위 그리드 트랙을 사용하는 중첩(하위) 그리드를 설정할 수 있습니다.

이것은 이전에는 어려웠던 숫자 패턴을 훨씬 쉽게 만들 수 있게 해주며, 특히 서브그리드의 장점을 보여주는 가장 인기 있는 예로 보이는 "카드" 패턴은 더욱 그러하다. 서브그리드 없이 각 카드는 독립 그리드로 정의되며, 이는 첫 번째 카드의 트랙 사이징이 두 번째 카드의 높이 변화에 반응할 수 없음을 의미합니다. Rachel Andrew가 사용한 예를 들어, 다음은 간단한 카드 그룹입니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/09/mTmUNNzk.png?resize=1544%2C744&ssl=1)

하위 그리드를 사용하면 카드가 상위 그리드에 정의된 행을 사용할 수 있으며, 이는 카드가 주변 카드의 내용에 반응할 수 있음을 의미합니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/09/VCONPiQc.png?resize=1600%2C756&ssl=1)

이 예제의 각 카드는 여전히 세 개의 행 트랙에 걸쳐 있지만, 이러한 행은 이제 상위 그리드에 정의되어 각 카드가 동일한 양의 수직 공간을 차지할 수 있습니다.

지금까지 작업한 예에서는 행을 사용할 필요가 없습니다. 대신 형제 그리드의 내용을 기준으로 열의 크기를 조정해야 합니다. 먼저 상위 그리드를 두 개의 `<fieldset> 요소를 포함하도록 설정합니다. 이는 이전에 우리가 `자동 장착` 데모에서 살펴본 코드와 유사하다.

```css
.wrapper--accessibility-tools {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
  grid-gap: 10px;
}
```

그런 다음 각 하위 그리드를 상위 그리드에 배치합니다.

```css
.sub-grid {
  display: grid;
  grid-column: span 3;
  grid-template-columns: subgrid;
  align-items: center;
}
```

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/09/e8UUf53s.png?resize=1600%2C200&ssl=1)

이제 모든 라벨과 버튼이 상위 그리드의 트랙에 정렬되어 일관성을 유지합니다. 사용 가능한 공간에 따라 각각 동일한 너비를 갖습니다. 한 선의 각 중첩 그리드에 대한 공간이 충분하지 않으면 두 번째 줄에서 새 줄 바꿈이 됩니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/09/KazSyw9M.png?resize=1510%2C396&ssl=1)

이번에는 두 중첩된 그리드 항목이 완벽하게 정렬됩니다. 또한 버튼 중 하나에 더 긴 제목을 도입하면 다른 요소도 그에 따라 반응할 수 있다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/09/B8mha32A.png?resize=1600%2C191&ssl=1)

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/09/GqAJTENA.png?resize=1024%2C407&ssl=1)

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 300px;"><iframe id="cp_embed_YzPEgEz" src="//codepen.io/anon/embed/YzPEgEz?height=300&amp;theme-id=1&amp;slug-hash=YzPEgEz&amp;default-tab=result" height="300" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed YzPEgEz" title="CodePen Embed YzPEgEz" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 브라우저 호환성

서브 그리드에 대한 지원은 작성 시 크지 않습니다. 파이어폭스 71+에서만 지원되지만 다른 브라우저의 긍정적인 신호도 있다. CSS 기능 쿼리는 Chrome과 Edge에 대한 대체 스타일링을 제공하는 데 사용될 수 있다.

이 데모의 필드 집합 주위에 추가 래퍼를 사용하고 있습니다. 이것은 폼 요소, 그리드 및 플렉스 박스로 버그를 퇴치하기 위한 것입니다.

```html
<fieldset class="accessibility-tools__colour-theme">
  <div class="wrapper"></div>
</fieldset>
```

레이아웃 CSS는 필드가 `display:contents`로 설정된 래퍼에 적용됩니다.

```css
.accessibility-tools fieldset {
  display: contents;
  border: 0;
} 
```

### 그 문제에 관한 기타 글

- 미리암 수잔의 "카드 배치를 개선하기 위한 서브그리드"
- Rachel Andrew의 "CSS 그리드 레벨 2: Here Comes Subgrid"
- Heydon Pickering의 "The Flexbox holy albatross"