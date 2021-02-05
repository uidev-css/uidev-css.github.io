---
layout: post
title: "JavaScript 미디어 쿼리 작업"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/08/image-47.png
tags: JAVASCRIPT,MEDIA QUERIES
---


미디어 질의를 하면 가장 먼저 떠오르는 것은 무엇인가요? CSS 파일에 다음과 같은 내용이 있을 수 있습니다.

```css
body {
  background-color: plum;
}
 
@media (min-width: 768px) {
  body {
    background-color: tomato;
  }
}
```

CSS 미디어 쿼리는 반응성 설계의 핵심 요소이다. 다양한 컨텍스트에 다양한 스타일을 적용할 수 있습니다. 뷰포트 크기, 모션 선호도, 선호 색 구성, 특정 상호 작용 및 프린터, TV, 프로젝터와 같은 특정 장치도 마찬가지입니다.

그런데 자바스크립트에 대한 미디어 쿼리가 있다는 것을 알고 있었나요? 사실이야! JavaScript에서 자주 볼 수는 없지만, 여러 해 동안 슬라이더와 같은 응답성 플러그인을 만드는 데 도움이 되는 사용 사례가 분명히 있습니다. 예를 들어, 특정 해상도에서 슬라이더 항목을 다시 그리고 다시 계산해야 할 수 있습니다.

자바스크립트에서 미디어 쿼리로 작업하는 것은 CSS에서 미디어 쿼리와 일하는 것과는 매우 다르다. 비록 개념은 비슷하지만, 일부 조건을 일치시키고 어떤 것을 적용한다.

### 매치 미디어 사용()

문서가 JavaScript의 미디어 쿼리 문자열과 일치하는지 확인하기 위해 "matchMedia() 방법을 사용합니다. 공식적으로 워킹 드래프트 상태인 CSS 오브젝트 모델 뷰 모듈 사양의 일부이지만, 브라우저 지원은 98.6%의 전 세계 커버리지로 Internet Explorer 10까지 거슬러 올라간다.

사용량은 CSS 미디어 쿼리와 거의 동일합니다. 미디어 쿼리 문자열을 matchmedia()에 전달한 다음 .matches 속성을 확인합니다.

```js
// Define the query
const mediaQuery = window.matchMedia('(min-width: 768px)')
```

정의된 미디어 쿼리는 `MediaQueryList` 개체를 반환합니다. 미디어 쿼리에 대한 정보를 저장하는 개체이며 필요한 주요 속성은 .matches입니다. 이 속성은 문서가 미디어 쿼리와 일치할 경우 `true`를 반환하는 읽기 전용 부울 속성입니다.

```js
// Create a media condition that targets viewports at least 768px wide
const mediaQuery = window.matchMedia('(min-width: 768px)')
 
// Check if the media query is true
if (mediaQuery.matches) {
  // Then trigger an alert
  alert('Media Query Matched!')
}
```

이는 JavaScript에서 미디어 조건을 일치시키기 위한 기본 사용법입니다. 개체(MediaQueryList)를 반환하고 개체(MediaQueryList)와 대조(Match)한 다음 조건이 참으로 평가되면 작업을 수행하는 매치 조건(`matchMedia()`matchMedia()`을 생성합니다. 완전히 CSS와 다르지 않습니다!

하지만 더 많은 것이 있다. 예를 들어, 우리가 우리의 목표 창 크기보다 작은 창 크기를 변경한다면, 어떤 것도 CSS를 즉시 사용할 수 있는 방법을 업데이트하지 않는다. .matches는 일회성 검사에는 완벽하지만 지속적으로 변경 사항을 확인할 수 없기 때문이다. 그 말은 우리가…

### 변경 사항 청취

MediaQueryList에는 미디어 쿼리 상태가 변경될 때 호출되는 콜백 함수(.onchanges 이벤트로 표시됨)를 허용하는 `addListener( 및 후속 `removeListener()` 메서드가 있습니다. 즉, 조건이 변경될 때 추가 기능을 발사하여 업데이트된 조건에 "대응"할 수 있습니다.

```js
// Create a condition that targets viewports at least 768px wide
const mediaQuery = window.matchMedia('(min-width: 768px)')
 
function handleTabletChange(e) {
  // Check if the media query is true
  if (e.matches) {
    // Then log the following message to the console
    console.log('Media Query Matched!')
  }
}
 
// Register event listener
mediaQuery.addListener(handleTabletChange)

// Initial check
handleTabletChange(mediaQuery)
```

매치미디어()와 미디어쿼리리스트(MediaQueryList)의 원투펀치는 CSS가 제공하는 미디어 조건뿐만 아니라 업데이트된 조건에도 적극적으로 대응할 수 있는 힘을 준다.

이벤트 수신기를 `Add Listener()`에 등록하면 처음에 실행되지 않습니다. 이벤트 핸들러 기능을 수동으로 호출하고 미디어 쿼리를 인수로 전달해야 합니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_QWNpVjV" src="//codepen.io/anon/embed/QWNpVjV?height=450&amp;theme-id=1&amp;slug-hash=QWNpVjV&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed QWNpVjV" title="CodePen Embed QWNpVjV" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 옛날 방식

맥락을 위해, 그리고 약간의 향수를 위해, 저는 자바스크립트에서 "미디어 쿼리"를 하는 오래된 방식이지만 여전히 인기 있는 방법을 다루려고 합니다(예, 이 인용문은 중요합니다). 가장 일반적인 접근 방식은 window.innerWidth 또는 window.innerHeight를 확인하는 크기 조정 이벤트 수신기를 바인딩하는 것이다.

야생에서는 여전히 이와 같은 것을 볼 수 있습니다.

```js
function checkMediaQuery() {
  // If the inner width of the window is greater then 768px
  if (window.innerWidth > 768) {
    // Then log this message to the console
    console.log('Media Query Matched!')
  }
}
 
// Add a listener for when the window resizes
window.addEventListener('resize', checkMediaQuery);
```

크기 조정 이벤트는 각 브라우저 크기 조정에서 호출되므로 비용이 많이 드는 작업입니다! 빈 페이지가 성능에 미치는 영향을 보면 그 차이를 알 수 있습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/08/image-47.png?resize=924%2C338&ssl=1)

더 간단한 차이점 확인 방법은 콘솔 로그의 도움을 받는 것입니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/08/image-48.png?resize=300%2C300&ssl=1)

성능 문제를 지나쳐도 인쇄나 방향과 같은 고급 미디어 쿼리를 쓸 수 없다는 점에서 크기 조정은 제한적입니다. 따라서 뷰포트 폭을 일치시켜 "미디어 쿼리" 동작을 흉내내기는 하지만, 다른 많은 것들을 일치시킬 수는 없습니다. 그리고 진정한 미디어 쿼리는 훨씬 더 많은 것을 가능하게 합니다.

### 결론

이는 JavaScript에서 미디어 쿼리를 살펴보는 것입니다. 매치미디어()가 미디어 조건을 어떻게 정의할 수 있는지 알아보고, 미디어 쿼리 목록 객체에 대해 일회성(매치)과 영구적(AddListener() 검사를 하여 기능을 호출하여 변경(변경 시)에 대응할 수 있도록 했다.

우리는 또한 창문의 "크기 조정" 행사를 들으며 "옛" 방식으로 일을 하는 것을 보았다. 여전히 널리 사용되며 `window.innerWidth`의 크기에 대한 변화에 대응하는 완전히 합법적인 방법이지만 고급 미디어 상태에 대한 검사를 수행할 수는 없습니다.

여기서 그 기사를 끝내는 것은 옛날 방식으로는 달성할 수 없는 유용한 예이다. 미디어 쿼리를 사용하여 사용자가 가로 모드인지 확인합니다. HTML5 게임을 개발할 때 흔히 볼 수 있는 접근 방식으로 모바일 기기에서 가장 잘 볼 수 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_xxVqarV" src="//codepen.io/anon/embed/xxVqarV?height=450&amp;theme-id=1&amp;slug-hash=xxVqarV&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed xxVqarV" title="CodePen Embed xxVqarV" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>