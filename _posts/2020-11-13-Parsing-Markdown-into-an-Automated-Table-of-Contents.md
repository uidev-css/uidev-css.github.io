---
layout: post
title: "Markdown을 자동화 된 목차로 구문 분석
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2018/07/smooth-scroll-nav.gif
tags: INTERSECTIONOBSERVER,MARKDOWN,NAVIGATION,VUE ANIMATIONS
---


목차는 같은 페이지에있는 특정 콘텐츠 섹션으로 빠르게 이동할 수있는 링크 목록입니다.
 사용자에게 어떤 콘텐츠가 있는지에 대한 편리한 개요와 편리한 방법을 보여주기 때문에 긴 형식의 콘텐츠에 도움이됩니다.
 

이 자습서에서는 긴 Markdown 텍스트를 HTML로 구문 분석 한 다음 제목에서 링크 목록을 생성하는 방법을 보여줍니다.
 그런 다음 Intersection Observer API를 사용하여 현재 활성화 된 섹션을 확인하고, 링크를 클릭 할 때 스크롤 애니메이션을 추가하고, 마지막으로 Vue의`<transition-group>`을 사용하여 멋진
 현재 활성화 된 섹션에 따라 애니메이션 목록.
 

### Markdown 구문 분석
 

웹에서 텍스트 콘텐츠는 종종 Markdown의 형태로 제공됩니다.
 사용하지 않았다면 Markdown이 텍스트 콘텐츠에 탁월한 선택이되는 데는 여러 가지 이유가 있습니다.
 우리는 표시 (marked)라는 마크 다운 파서를 사용할 것이지만 다른 파서도 좋습니다.
 

GitHub의 Markdown 파일에서 콘텐츠를 가져옵니다.
 Markdown 파일을로드 한 후에는`marked (<markdown>, <options>)`함수를 호출하여 Markdown을 HTML로 구문 분석하기 만하면됩니다.
 

```js
async function fetchAndParseMarkdown() {
  const url = 'https://gist.githubusercontent.com/lisilinhart/e9dcf5298adff7c2c2a4da9ce2a3db3f/raw/2f1a0d47eba64756c22460b5d2919d45d8118d42/red_panda.md'
  const response = await fetch(url)
  const data = await response.text()
  const htmlFromMarkdown = marked(data, { sanitize: true });
  return htmlFromMarkdown
}
```

데이터를 가져오고 파싱 한 후 콘텐츠를`innerHTML`로 대체하여 파싱 된 HTML을 DOM에 전달합니다.
 

```js
async function init() {
  const $main = document.querySelector('#app');
  const htmlContent = await fetchAndParseMarkdown();
  $main.innerHTML = htmlContent
}
 
init();
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_vYKKLzZ" src="//codepen.io/anon/embed/vYKKLzZ?height=450&amp;theme-id=1&amp;slug-hash=vYKKLzZ&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed vYKKLzZ" title="CodePen Embed vYKKLzZ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 제목 링크 목록 생성
 

이제 HTML을 생성 했으므로 제목을 클릭 가능한 링크 목록으로 변환해야합니다.
 제목을 찾기 위해 마크 다운 컨테이너 내의 모든`<h1>`및`<h2>`요소를 선택하는 DOM 함수`querySelectorAll ( `h1, h2`)`을 사용합니다.
 그런 다음 제목을 살펴보고 태그 내부의 텍스트, 깊이 (1 또는 2), 각 제목에 연결하는 데 사용할 수있는 요소 ID 등 필요한 정보를 추출합니다.
 

```js
function generateLinkMarkup($contentElement) {
  const headings = [...$contentElement.querySelectorAll('h1, h2')]
  const parsedHeadings = headings.map(heading => {
    return {
      title: heading.innerText,
      depth: heading.nodeName.replace(/\D/g,''),
      id: heading.getAttribute('id')
    }
  })
  console.log(parsedHeadings)
}
```

이 스 니펫은 다음과 같은 요소 배열을 생성합니다.
 

```js
[
  {title: "The Red Panda", depth: "1", id: "the-red-panda"},
  {title: "About", depth: "2", id: "about"},
  // ... 
]
```

표제 요소에서 필요한 정보를 얻은 후 ES6 템플릿 리터럴을 사용하여 목차에 필요한 HTML 요소를 생성 할 수 있습니다.
 

먼저 모든 제목을 반복하고`<li>`요소를 만듭니다.
 `depth : 2`가있는`<h2>`로 작업하는 경우 들여 쓰기를 위해 추가 패딩 클래스`.pl-4`를 추가합니다.
 이렇게하면 링크 목록 내에서 들여 쓰기 된 부제목으로`<h2>`요소를 표시 할 수 있습니다.
 

마지막으로`<li>`스 니펫의 배열을 결합하고`<ul>`요소 안에 감 쌉니다.
 

```js
function generateLinkMarkup($contentElement) {
  // ...
  const htmlMarkup = parsedHeadings.map(h => `
  <li class="${h.depth > 1 ? 'pl-4' : ''}">
    <a href="#${h.id}">${h.title}</a>
  </li>
  `)
  const finalMarkup = `<ul>${htmlMarkup.join('')}</ul>`
  return finalMarkup
}
```

이것이 링크 목록을 생성하는 데 필요한 전부입니다.
 이제 생성 된 HTML을 DOM에 추가합니다.
 

```js
async function init() {
  const $main = document.querySelector('#content');
  const $aside = document.querySelector('#aside');
  const htmlContent = await fetchAndParseMarkdown();
  $main.innerHTML = htmlContent
  const linkHtml = generateLinkMarkup($main);
  $aside.innerHTML = linkHtml        
}
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_yLJJerd" src="//codepen.io/anon/embed/yLJJerd?height=450&amp;theme-id=1&amp;slug-hash=yLJJerd&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed yLJJerd" title="CodePen Embed yLJJerd" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 교차점 관찰자 추가
 

다음으로, 현재 읽고있는 콘텐츠 부분을 찾아야합니다.
 교차점 관찰자는이를위한 완벽한 선택입니다.
 MDN은 Intersection Observer를 다음과 같이 정의합니다.
 

> Intersection Observer API는 대상 요소와 상위 요소 또는 최상위 문서 뷰포트의 교차점에서 변경 사항을 비동기 적으로 관찰하는 방법을 제공합니다.
 

따라서 기본적으로 요소가 뷰포트 또는 상위 요소 중 하나와 교차하는 것을 관찰 할 수 있습니다.
 이를 생성하기 위해 새로운 옵저버 인스턴스를 생성하는 새로운`IntersectionObserver ()`를 호출 할 수 있습니다.
 새 관찰자를 만들 때마다 관찰자가 요소의 교차를 관찰했을 때 호출되는 콜백 함수를 전달해야합니다.
 Travis Almand가 읽을 수있는 Intersection Observer에 대한 자세한 설명이 있지만 지금 필요한 것은 첫 번째 매개 변수로 콜백 함수이고 두 번째 매개 변수로 옵션 객체입니다.
 

```js
function createObserver() {
  const options = {
    rootMargin: "0px 0px -200px 0px",
    threshold: 1
  }
  const callback = () => { console.log("observed something") }
  return new IntersectionObserver(callback, options)
}
```

관찰자가 생성되었지만 지금은 아무것도 관찰되지 않습니다.
 Markdown에서 표제 요소를 관찰해야하므로 반복해서 살펴보고`observe ()`함수를 사용하여 관찰자에 추가하겠습니다.
 

```js
const observer = createObserver()
$headings.map(heading => observer.observe(heading))
```

링크 목록을 업데이트하려고하므로 성능상의 이유로 업데이트 할 때마다 DOM을 다시 읽고 싶지 않기 때문에이를`$ links` 매개 변수로`observer` 함수에 전달합니다.
 `handleObserver`함수에서 제목이 뷰포트와 교차하는지 확인한 다음 `id`를 가져 와서 목차의 링크 클래스 업데이트를 처리하는 `updateLinks`라는 함수에 전달합니다.
 

```js
function handleObserver(entries, observer, $links) {
  entries.forEach((entry)=> {
    const { target, isIntersecting, intersectionRatio } = entry
    if (isIntersecting && intersectionRatio >= 1) {
      const visibleId = `#${target.getAttribute('id')}`
      updateLinks(visibleId, $links)
    }
  })
}
```

링크 목록을 업데이트하는 함수를 작성해 보겠습니다.
 모든 링크를 반복하고`.is-active` 클래스가있는 경우 제거하고 실제로 활성화 된 요소에만 추가해야합니다.
 

```js
function updateLinks(visibleId, $links) {
  $links.map(link => {
    let href = link.getAttribute('href')
    link.classList.remove('is-active')
    if(href === visibleId) link.classList.add('is-active')
  })
}
```

`init ()`함수의 끝은 관찰자를 만들고, 모든 제목을 관찰하고, 링크 목록을 업데이트하여 관찰자가 변경 사항을 발견하면 활성 링크가 강조 표시되도록합니다.
 

```js
async function init() {
  // Parsing Markdown
  const $aside = document.querySelector('#aside');
 
  // Generating a list of heading links
  const $headings = [...$main.querySelectorAll('h1, h2')];
 
  // Adding an Intersection Observer
  const $links = [...$aside.querySelectorAll('a')]
  const observer = createObserver($links)
  $headings.map(heading => observer.observe(heading))
}
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_NWrrNpV" src="//codepen.io/anon/embed/NWrrNpV?height=450&amp;theme-id=1&amp;slug-hash=NWrrNpV&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed NWrrNpV" title="CodePen Embed NWrrNpV" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 섹션 애니메이션으로 스크롤
 

다음 부분은 스크롤 애니메이션을 생성하여 목차의 링크를 클릭 할 때 사용자가 갑작스런 제목 위치로 스크롤되도록하는 것입니다.
 이를 종종 부드러운 스크롤이라고합니다.
 

스크롤 애니메이션은 사용자가 감소 된 동작을 선호하는 경우 해로울 수 있으므로 사용자가 달리 지정하지 않은 경우에만이 스크롤 동작을 애니메이션해야합니다.
 `window.matchMedia ( `(prefers-reduced-motion)`)`를 사용하면 사용자 선호도를 읽고 그에 따라 애니메이션을 조정할 수 있습니다.
 즉, 각 링크에 클릭 이벤트 리스너가 필요합니다.
 제목으로 스크롤해야하므로`$ headings` 및`motionQuery` 목록도 전달합니다.
 

```js
const motionQuery = window.matchMedia('(prefers-reduced-motion)');
 
$links.map(link => {
  link.addEventListener("click", 
    (evt) => handleLinkClick(evt, $headings, motionQuery)
  )
})
```

링크를 클릭 할 때마다 호출되는`handleLinkClick` 함수를 작성해 보겠습니다.
 먼저, 섹션으로 직접 점프하는 링크의 기본 동작을 방지해야합니다.
 그런 다음 클릭 된 링크의 `href`속성을 읽고 해당하는 `id`속성이있는 제목을 찾습니다.
 `tabindex` 값이 -1이고`focus ()`이면 사용자가 어디로 이동했는지 알 수 있도록 제목에 초점을 맞출 수 있습니다.
 마지막으로 창에서`scroll ()`을 호출하여 스크롤 애니메이션을 추가합니다.
 

여기에`motionQuery`가 들어갑니다. 사용자가 감소 된 모션을 선호하면 동작은`instant`가됩니다.
 그렇지 않으면 `부드럽게`됩니다.
 `top`옵션은 제목 상단에 약간의 스크롤 여백을 추가하여 창의 맨 위에 달라 붙지 않도록합니다.
 

```js
function handleLinkClick(evt, $headings, motionQuery) {
  evt.preventDefault()
  let id = evt.target.getAttribute("href").replace('#', '')
  let section = $headings.find(heading => heading.getAttribute('id') === id)
  section.setAttribute('tabindex', -1)
  section.focus()
 
  window.scroll({
    behavior: motionQuery.matches ? 'instant' : 'smooth',
    top: section.offsetTop - 20
  })
}
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_Pozzzmq" src="//codepen.io/anon/embed/Pozzzmq?height=450&amp;theme-id=1&amp;slug-hash=Pozzzmq&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed Pozzzmq" title="CodePen Embed Pozzzmq" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 링크 목록 애니메이션
 

마지막 부분에서는 목록 전환에 매우 유용한 Vue의`<transition-group>`을 사용합니다.
 다음은 Sarah Drasner의 Vue 전환에 대한 훌륭한 소개입니다.
 CSS 애니메이션에 쉽게 액세스 할 수있는 애니메이션 수명주기 후크를 제공하기 때문에 특히 좋습니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2017/01/transition.png?resize=1200%2C600&ssl=1)

Vue는 요소가 목록에서 추가 (`v-enter`) 또는 제거 (`v-leave`) 될 때 자동으로 CSS 클래스를 첨부하고 애니메이션이 활성화 될 때 (`v-enter-active`)
 및`v-leave-active`).
 이것은 목록에서 부제목이 추가되거나 제거 될 때 애니메이션을 변경할 수 있기 때문에 우리의 경우에 완벽합니다.
 이를 사용하려면 목차의`<li>`요소를`<transition-group>`요소로 래핑해야합니다.
 `<transition-group>`의 이름 속성은 CSS 애니메이션이 호출되는 방법을 정의하며 태그 속성은 상위`<ul>`요소 여야합니다.
 

```html
<transition-group name="list" tag="ul">
  <li v-for="(item, index) in activeHeadings" v-bind:key="item.id">
    <a :href="item.id">
      {{ item.text }}
    </a>
  </li>
</transition-group>
```

이제 실제 CSS 전환을 추가해야합니다.
 요소가 들어 오거나 나갈 때마다 보이지 않는 곳에서 애니메이션 (`불투명도 : 0`)하고 아래쪽으로 조금 이동해야합니다 (`transform : translateY (10px)`).
 

```css
.list-enter, .list-leave-to {
  opacity: 0;
  transform: translateY(10px);
}
```

그런 다음 애니메이션을 적용 할 CSS 속성을 정의합니다.
 성능상의 이유로`transform` 및`opacity` 속성 만 애니메이션화하려고합니다.
 CSS를 사용하면 다른 타이밍으로 전환을 연결할 수 있습니다. `변환`에는 0.8 초가 걸리고 페이딩에는 0.4 초가 걸립니다.
 

```css
.list-leave-active, .list-move {
  transition: transform 0.8s, opacity 0.4s;
}
```

그런 다음 새 요소가 추가 될 때 약간의 지연을 추가하여 상위 제목이 위 또는 아래로 이동 한 후 부제목이 페이드 인되도록합니다.
 이를 위해`v-enter-active` 후크를 사용할 수 있습니다.
 

```css
.list-enter-active { 
  transition: transform 0.8s ease 0.4s, opacity 0.4s ease 0.4s;
}
```

마지막으로 다른 요소가 애니메이션 중일 때 갑작스러운 점프를 피하기 위해 떠나는 요소에 절대 위치를 추가 할 수 있습니다.
 

```css
.list-leave-active {
  position: absolute;
}
```

스크롤링 상호 작용은 요소를 페이드 아웃 및 인으로 처리하므로 누군가가 매우 빠르게 스크롤하는 경우 스크롤 상호 작용을 디 바운스하는 것이 좋습니다.
 상호 작용을 디 바운싱함으로써 미완성 애니메이션이 다른 애니메이션과 겹치는 것을 방지 할 수 있습니다.
 자체 디 바운싱 함수를 작성하거나 단순히 lodash 디 바운스 함수를 사용할 수 있습니다.
 이 예제에서 미완성 애니메이션 업데이트를 피하는 가장 간단한 방법은 디 바운스 함수로 Intersection Observer 콜백 함수를 래핑하고 디 바운스 된 함수를 관찰자에게 전달하는 것입니다.
 

```css
const debouncedFunction = _.debounce(this.handleObserver)
this.observer = new IntersectionObserver(debouncedFunction,options)
```

### 다음은 최종 데모입니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_MWeKgGE" src="//codepen.io/anon/embed/MWeKgGE?height=450&amp;theme-id=1&amp;slug-hash=MWeKgGE&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed MWeKgGE" title="CodePen Embed MWeKgGE" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

다시 말하지만, 목차는 긴 형식의 콘텐츠에 큰 도움이됩니다.
 어떤 콘텐츠가 포함되는지 명확히하고 특정 콘텐츠에 빠르게 액세스 할 수 있습니다.
 Intersection Observer와 Vue의 목록 애니메이션을 사용하면 목차를 훨씬 더 상호 작용 적으로 만들고 읽기 진행률을 표시하는 역할도 할 수 있습니다.
 그러나 링크 목록 만 추가하더라도 이미 콘텐츠를 읽는 사용자에게 훌륭한 기능이 될 것입니다.
 