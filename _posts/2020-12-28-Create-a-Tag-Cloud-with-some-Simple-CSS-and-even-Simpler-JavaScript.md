---
layout: post
title: "간단한 CSS와 더 간단한 JavaScript로 태그 클라우드 만들기
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/12/tag-cloud.jpg
tags: BLOGGING,LINKS
---


저는 항상 태그 클라우드를 좋아했습니다.
 나는 태그의 상대적인 글꼴 크기를보고 웹 사이트에서 가장 인기있는 태그를 보는 UX를 좋아합니다. 인기있는 태그는 더 큽니다.
 Wordle과 같은 도구의 일러스트레이션에서 사용되는 버전을 자주 볼 수 있지만 패션에서 벗어난 것 같습니다.
 

태그 클라우드를 만드는 것이 얼마나 어렵습니까?
 전혀 어렵지 않습니다.
 보자!
 

### 마크 업부터 시작하겠습니다
 

HTML의 경우 각 태그를`<ul class = "tags"> <ul>`목록에 넣을 것입니다.
 여기에 JavaScript를 삽입 할 것입니다.
 

태그 클라우드가 이미 HTML로되어 있고 상대적인 `글꼴 크기`작업을 수행하려는 경우 좋습니다.
 점진적 향상!
 나중에 자바 스크립트를 적용하여 해당 부분 만 수행 할 수 있어야하지만 반드시 태그 자체를 빌드하고 삽입 할 필요는 없습니다.
 

각 속성으로 태그가 지정된 일정량의 기사로 JSON을 조롱했습니다.
 JSON 피드를 가져 와서 세 가지 작업을 수행하기 위해 JavaScript를 작성해 보겠습니다.
 

먼저 목록의 각 항목에서`<li>`를 만듭니다.
 지금까지 HTML이 다음과 같다고 상상해보십시오.
 

```html
<ul class="tags">
  <li>align-content</li>
  <li>align-items</li>
  <li>align-self</li>
  <li>animation</li>
  <li>...</li>
  <li>z-index</li>
</ul>
```

둘째, 각 목록 항목 옆의 괄호 안에 각 속성에있는 기사 수를 입력합니다.
 이제 마크 업은 다음과 같습니다.
 

```html
<ul class="tags">
  <li>align-content (2)</li>
  <li>align-items (2)</li>
  <li>align-self (2)</li>
  <li>animation (9)</li>
  <li>...</li>
  <li>z-index (4)</li>
</ul>
```

셋째, 마지막으로 올바른 위치로 이동하는 각 태그 주변에 링크를 만듭니다.
 여기에서 속성에 태그가 지정된 기사 수에 따라 각 항목에 대한`font-size` 속성을 설정할 수 있으므로 기사가 13 개있는`animation`은 기사가 하나만있는`background-color`보다 훨씬 큽니다.
 .
 

```html
<li class="tag">
  <a
    class="tag__link"
    href="https://example.com/tags/animation"
    style="font-size: 5em">
    animation (9)
  </a>
</li>
```

### 자바 스크립트 부분
 

이를 위해 JavaScript를 살펴 보겠습니다.
 

```js
const dataURL =
  "https://gist.githubusercontent.com/markconroy/536228ed416a551de8852b74615e55dd/raw/9b96c9049b10e7e18ee922b4caf9167acb4efdd6/tags.json";
const tags = document.querySelector(".tags");
const fragment = document.createDocumentFragment();
const maxFontSizeForTag = 6;

fetch(dataURL)
  .then(function (res) {
    return res.json();
  })
  .then(function (data) {
    // 1. Create a new array from data
    let orderedData = data.map((x) => x);
    // 2. Order it by number of articles each tag has
    orderedData.sort(function(a, b) {
      return a.tagged_articles.length - b.tagged_articles.length;
    });
    orderedData = orderedData.reverse();
    // 3. Get a value for the tag with the most articles
    const highestValue = orderedData[0].tagged_articles.length;
    // 4. Create a list item for each result from data.
    data.forEach((result) => handleResult(result, highestValue));
    // 5. Append the full list of tags to the tags element
    tags.appendChild(tag);
  });
```

위의 자바 스크립트는 Fetch API를 사용하여`tags.json`이 호스팅되는 URL을`가져옵니다 `.
 이 데이터를 받으면 JSON으로 반환합니다.
 여기서 우리는`OrderedData`라는 새 배열로 속이어서 (원래 배열을 변경하지 않음) 기사가 가장 많은 태그를 찾습니다.
 나중에이 값을 글꼴 크기에 사용하여 다른 모든 태그에 상대적인 글꼴 크기를 지정합니다.
 그런 다음 응답에서`forEach` 결과가 나오면`handleResult ()`라는 함수를 호출하고`result`와`highestValue`를이 함수에 매개 변수로 전달합니다.
 또한 다음을 생성합니다.
 

- 결과에서 생성 한 각 목록 항목을 삽입하는 데 사용할`tags`라는 변수,
 
- 루프의 각 반복 결과를 저장할`fragment`에 대한 변수. 나중에`tags`에 추가합니다.
 
- 최대 글꼴 크기에 대한 변수로 나중에 글꼴 크기에서 사용할 것입니다.
 

다음은`handleResult (result)`함수입니다.
 

```js
function handleResult(result, highestValue) {
  const tag = document.createElement("li");
  tag.classList.add("tag");
  tag.innerHTML = `<a class="tag__link" href="${result.href}" style="font-size: ${result.tagged_articles.length * 1.25}em">${result.title} (${result.tagged_articles.length})</a>`;

  // Append each tag to the fragment
  fragment.appendChild(tag);
}
```

이것은`tag`라는 변수로 설정된 목록 요소를 생성 한 다음이 목록 요소에`.tag` 클래스를 추가하는 매우 간단한 함수입니다.
 생성되면 목록 항목의 `innerHTML`을 링크로 설정하고 해당 링크의 값을 JSON 피드의 값 (예 : 태그 링크에 대한 `result.href`)으로 채 웁니다.
 각`li`가 생성되면`fragment`에 문자열로 추가되고 나중에`tags` 변수에 추가됩니다.
 여기서 가장 중요한 항목은 기사 수 (`result.tagged_articles.length`)를 사용하여이 목록 항목에 대해`em` 단위를 사용하여 상대적 글꼴 크기를 설정하는 인라인`style` 태그입니다.
 나중에 기본 글꼴 배율을 사용하기 위해 해당 값을 수식으로 변경합니다.
 

이 자바 스크립트가 눈에 약간 못 생기고 힘들다는 것을 알고 있으므로 각 속성에 대한 몇 가지 변수와 간단한 글꼴 크기 조정 공식을 만들어 정리하고 읽기 쉽게 만들어 보겠습니다.
 

```js
function handleResult(result, highestValue) {
  // Set our variables
  const name = result.title;
  const link = result.href;
  const numberOfArticles = result.tagged_articles.length;
  let fontSize = numberOfArticles / highestValue * maxFontSizeForTag;
  fontSize = +fontSize.toFixed(2);
  const fontSizeProperty = `${fontSize}em`;

  // Create a list element for each tag and inline the font size
  const tag = document.createElement("li");
  tag.classList.add("tag");
  tag.innerHTML = `<a class="tag__link" href="${link}" style="font-size: ${fontSizeProperty}">${name} (${numberOfArticles})</a>`;
  
  // Append each tag to the fragment
  fragment.appendChild(tag);
}
```

HTML을 만들기 전에 몇 가지 변수를 설정하면 코드를 훨씬 쉽게 읽을 수 있습니다.
 또한 한 곳 이상에서`numberOfArticles` 변수를 사용할 수 있으므로 코드를 조금 더 건조하게 만듭니다.
 

이`.forEach` 루프에서 각 태그가 반환되면`fragment`에 함께 수집됩니다.
 그 후`appendChild ()`를 사용하여`tags` 요소에 추가합니다.
 이는 DOM이 루프가 실행될 때마다 조작되는 대신 한 번만 조작된다는 것을 의미합니다. 이는 많은 수의 태그가있는 경우 성능이 향상됩니다.
 

### 글꼴 크기 조정
 

우리가 지금 가지고있는 것은 우리에게 잘 작동 할 것이고 CSS 작성을 시작할 수 있습니다.
 그러나`fontSize` 변수에 대한 공식은 기사가 가장 많은 태그 (25로 "flex")가 6em (25/25 * 6 = 6)이되지만 기사가 하나만있는 태그는
 그 크기의 1/25 (1/25 * 6 = 0.24)이면 내용을 읽을 수 없게됩니다.
 100 개의 기사가 포함 된 태그가있는 경우 더 작은 태그가 더 나빠질 것입니다 (1/100 * 6 = 0.06).
 

이 문제를 해결하기 위해 반환되는`fontSize`가 1보다 작 으면`if`를 1로 설정하고`fontSize`를 1로 설정하는 간단한`if` 문을 추가했습니다. 그렇지 않으면 현재 크기로 유지합니다.
 이제 모든 태그는 소수점 이하 두 자리로 반올림 된 1em에서 6em의 글꼴 배율 내에 있습니다.
 가장 큰 태그의 크기를 늘리려면`maxFontSizeForTag`의 값을 변경하면됩니다.
 처리중인 콘텐츠의 양에 따라 가장 적합한 것을 결정할 수 있습니다.
 

```js
function handleResult(result, highestValue) {
  // Set our variables
  const numberOfArticles = result.tagged_articles.length;
  const name = result.title;
  const link = result.href;
  let fontSize = numberOfArticles / highestValue * maxFontSizeForTag;
  fontSize = +fontSize.toFixed(2);
  
  // Make sure our font size will be at least 1em
  if (fontSize <= 1) {
    fontSize = 1;
  } else {
    fontSize = fontSize;
  }
  const fontSizeProperty = `${fontSize}em`;
  
  // Then, create a list element for each tag and inline the font size.
  tag = document.createElement("li");
  tag.classList.add("tag");
  tag.innerHTML = `<a class="tag__link" href="${link}" style="font-size: ${fontSizeProperty}">${name} (${numberOfArticles})</a>`;

  // Append each tag to the fragment
  fragment.appendChild(tag);
}
```

### 이제 CSS!
 

각 태그의 너비가 다를 수 있으므로 레이아웃에 flexbox를 사용하고 있습니다.
 그런 다음`justify-content : center`로 가운데 정렬하고 목록 글 머리 기호를 제거합니다.
 

```css
.tags {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  max-width: 960px;
  margin: auto;
  padding: 2rem 0 1rem;
  list-style: none;
  border: 2px solid white;
  border-radius: 5px;
}
```

또한 개별 태그에 flexbox를 사용합니다.
 이렇게하면 글꼴 크기에 따라 높이가 달라 지므로`align-items : center`로 세로로 정렬 할 수 있습니다.
 

```css
.tag {
  display: flex;
  align-items: center;
  margin: 0.25rem 1rem;
}
```

태그 클라우드의 각 링크에는 약간의 패딩이있어 엄격한 크기에서 약간 벗어나 클릭 할 수 있습니다.
 

```css
.tag__link {
  padding: 5px 5px 0;
  transition: 0.3s;
  text-decoration: none;
}
```

나는 이것이 작은 화면에서 특히 링크를 탭하기가 더 어려운 사람들에게 편리하다는 것을 알았습니다.
 태그 클라우드의 각 텍스트 항목이 링크라고 가정 할 수 있으므로 초기 `텍스트 데코레이션`은 제거되어 특별한 데코레이션이 필요하지 않습니다.
 

좀 더 스타일링하기 위해 몇 가지 색상을 추가하겠습니다.
 

```css
.tag:nth-of-type(4n+1) .tag__link {
  color: #ffd560;
}
.tag:nth-of-type(4n+2) .tag__link {
  color: #ee4266;
}
.tag:nth-of-type(4n+3) .tag__link {
  color: #9e88f7;
}
.tag:nth-of-type(4n+4) .tag__link {
  color: #54d0ff;
}
```

이에 대한 색 구성표는 Chris의 블로그 롤에서 직접 도용했습니다. 태그 1에서 시작하는 네 번째 태그는 모두 노란색이고, 태그 2에서 시작하는 네 번째 태그는 모두 빨간색, 태그 3에서 시작하는 네 번째 태그는 모두 보라색입니다.
 태그 4에서 시작하는 모든 네 번째 태그는 파란색입니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_8FD09AF5AA8070900B6657484E0B5E2DB8235C7E88C2E98256A5BE4E2828BE69_1606208372002_chris-coyier-blogroll.png?resize=2390%2C792&ssl=1)

그런 다음 각 링크에 대해 포커스 및 호버 상태를 설정합니다.
 

```css
.tag:nth-of-type(4n+1) .tag__link:focus,
.tag:nth-of-type(4n+1) .tag__link:hover {
  box-shadow: inset 0 -1.3em 0 0 #ffd560;
}
.tag:nth-of-type(4n+2) .tag__link:focus,
.tag:nth-of-type(4n+2) .tag__link:hover {
  box-shadow: inset 0 -1.3em 0 0 #ee4266;
}
.tag:nth-of-type(4n+3) .tag__link:focus,
.tag:nth-of-type(4n+3) .tag__link:hover {
  box-shadow: inset 0 -1.3em 0 0 #9e88f7;
}
.tag:nth-of-type(4n+4) .tag__link:focus,
.tag:nth-of-type(4n+4) .tag__link:hover {
  box-shadow: inset 0 -1.3em 0 0 #54d0ff;
}
```

이 단계에서`--yellow : # ffd560` 등과 같은 색상에 대한 사용자 정의 변수를 만들 수 있었지만 IE 11 지원을 위해 장기적인 접근 방식을 사용하기로 결정했습니다.
 나는`box-shadow` 호버 효과를 좋아합니다.
 표준 밑줄이나 하단 테두리보다 훨씬 더 시각적으로 매력적인 것을 달성하는 것은 매우 적은 양의 코드입니다.
 여기서 `em`단위를 사용하면 커버해야하는 텍스트에 비해 그림자의 크기를 적절하게 제어 할 수 있습니다.
 

좋습니다. 마우스를 올릴 때 모든 태그 링크를 검은 색으로 설정하여 마무리하겠습니다.
 

```css
.tag:nth-of-type(4n+1) .tag__link:focus,
.tag:nth-of-type(4n+1) .tag__link:hover,
.tag:nth-of-type(4n+2) .tag__link:focus,
.tag:nth-of-type(4n+2) .tag__link:hover,
.tag:nth-of-type(4n+3) .tag__link:focus,
.tag:nth-of-type(4n+3) .tag__link:hover,
.tag:nth-of-type(4n+4) .tag__link:focus,
.tag:nth-of-type(4n+4) .tag__link:hover {
  color: black;
}
```

그리고 우리는 끝났습니다!
 최종 결과는 다음과 같습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 650px;"><iframe id="cp_embed_jOrgzbG" src="//codepen.io/anon/embed/jOrgzbG?height=650&amp;theme-id=1&amp;slug-hash=jOrgzbG&amp;default-tab=result" height="650" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed jOrgzbG" title="CodePen Embed jOrgzbG" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>