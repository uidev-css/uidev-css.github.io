---
layout: post
title: "JavaScript 탐색에 대한 세 가지 CSS 대안"
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/01/hamburger-menu.png"
tags: NAVIGATION
---


야, 빨리! 사이트에 대한 네비게이션을 만들고 모바일 동작에 대한 작업을 시작합니다. 어떤 패턴을 선택하시나요? 대부분의 사용자와 마찬가지로 이 메뉴를 클릭하면 탐색 링크의 수직 목록을 확장하는 데 작은 JavaScript를 사용하는 "햄버거" 메뉴일 수 있습니다.

하지만 그것만이 유일한 선택은 아닙니다.

탐색의 컨텍스트와 내용에 따라 보다 쉽게 액세스할 수 있는 환경을 제공하면서 작업을 수행하는 JavaScript가 없는 방법이 있을 수 있습니다.

가장 오래되고 성능이 떨어지는 기술을 가진 사용자를 위한 웹 페이지를 먼저 만든 다음 지원이 허용하는 대로 추가 기능을 도입하는 등 점진적인 강화 접근 방식을 사용하는 것이 모범 사례로 꼽힌다. 사용자에게 기본 기술을 제공하는 경우 웹 페이지에 JavaScript 기능이 필요한지 여부를 고려할 수 있습니다. JavaScript를 탐색에서 제외하면 JavaScript가 비활성화되거나 네트워크 문제로 인해 스크립트가 로드되지 않는 경우에도 사용자가 웹 사이트를 탐색할 수 있습니다(확실히 승리).

자바스크립트로 구동되는 햄버거 메뉴의 세 가지 다른 패턴을 살펴봅시다.

### 대안 1: 메뉴를 별도의 페이지에 배치합니다.

네비게이션이 모든 페이지의 머리글에 있어야 한다고 누가 말했나요? 프론트 엔드가 매우 가볍거나 탐색에 표시할 메뉴 항목의 목록이 긴 경우 가장 실용적인 방법은 모든 항목을 나열하는 별도의 페이지를 만드는 것입니다. 경량 워드프레스 테마 서스티는 이 방법을 내비게이션에 활용한다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/07/RQyb4Pwc.gif?resize=480%2C360&ssl=1)

이 패턴은 파일 시스템 라우팅을 사용하는 정적 웹 사이트에 특히 유용합니다. 정적 사이트 생성기를 사용하여 프로젝트를 빌드하는 경우 사용자가 페이지 로드를 인식하지 못할 수 있으며 템플릿을 최대한 모듈식으로 유지할 수 있는 추가적인 이점이 있습니다.

이 경우 기본적으로 사용자가 메뉴 페이지에 있을 때 "메뉴" 버튼을 닫기 버튼으로 바꾸기만 하면 됩니다. 이 옵션을 클릭하면 두 가지 방법으로 사용자를 마지막 페이지로 다시 이동할 수 있습니다. WordPress와 같은 서버측 CMS를 사용하는 경우 `$_SERVER[``를 사용하여 마지막 URL을 잡을 수 있습니다.HTTP_REPERER`]`````를 `닫기` 버튼 URL로 설정합니다.

하지만 서버측 설정을 사용하지 않는 경우 마지막 URL을 얻으려면 몇 줄의 JavaScript가 필요할 수 있습니다.

```html
<a href="https://MyHomePage.com" onclick="handleClick(event)">×</a>
 
<script>
  function handleClick(event) {
    // Don't follow the link
    event.preventDefault();
    // Go back to last visited page  
    window.history.back(); 
    // Bail out of the function
    return false;
  }
</script>
```

그래서 저는 이 방법과 패턴을 좋아하지만 프로젝트에 따라 자바스크립트가 필요할 수도 있습니다.

### 대안 2: 수평 스크롤러

이 접근 방식은 링크 목록 단축에 적합하며 사용자가 원하는 위치에서 아무것도 열거나 클릭하지 않고도 모든 탐색 항목에 액세스할 수 있습니다. GitHub은 하위 메뉴에 이 접근 방식을 사용한다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/07/NrorDMN4.gif?resize=381%2C500&ssl=1)

CSS에서 플럭박스와 스크롤 오버플로를 함께 사용하면 효과가 있습니다!

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_oNjdwwY" src="//codepen.io/anon/embed/oNjdwwY?height=450&amp;theme-id=1&amp;slug-hash=oNjdwwY&amp;default-tab=css,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed oNjdwwY" title="CodePen Embed oNjdwwY" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 대안 3: CSS 전용 햄버거 메뉴

햄버거 메뉴 패턴이 자바스크립트로 이루어진다고 해서 자바스크립트를 사용해야 하는 것은 아닙니다. CSS 의사 선택기와 HTML <input>를 사용하여 우리는 풍부한 모바일 메뉴를 만들고 자바스크립트를 실제로 필요로 하는 다른 기능을 위해 저장할 수 있다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_ExVLWOQ" src="//codepen.io/anon/embed/ExVLWOQ?height=450&amp;theme-id=1&amp;slug-hash=ExVLWOQ&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed ExVLWOQ" title="CodePen Embed ExVLWOQ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

보이시죠? 컨벤션이 인기 있다고 해서 그것이 일을 할 수 있는 유일한 방법이라는 것을 의미하지는 않습니다. 특히 항해에 관한 한 더 간단하고 접근하기 쉬운 방법이 종종 있다. JavaScript 없이 기능적이고, 가볍고, 몰입감 있는 탐색 기능을 만드는 것은 그리 어려운 일이 아니며, 그 과정에서 몇 가지 좋은 이점을 얻을 수 있습니다. 흥미로운 CSS 전용 탐색 패턴을 생성하셨다면 보고 싶습니다. 의견을 공유해 주십시오!