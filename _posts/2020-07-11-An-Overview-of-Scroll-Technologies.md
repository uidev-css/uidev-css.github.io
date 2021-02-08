---
layout: post
title: "스크롤 기술 개요"
author: "Uidev Css"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2019/03/scroll-position.png"
tags: SCROLL
---


스크롤 관련 애니메이션은 수년 동안 웹에서 사용되어 왔다. 최근 몇 년 동안, 기기가 더 높은 성능을 발휘하여 더 많은 애니메이션을 처리할 수 있기 때문에 이러한 장치가 더욱 보편화되기 시작했습니다.

여러 스크롤 관련 기술이 나와 있습니다. 따라서 이 기사에서는 스크롤에 대한 개요와 사용자에게 적합한 스크롤을 선택하는 데 도움이 되는 도구를 제공하는 것을 목표로 합니다. 저는 이 기술들을 두 가지 광범위한 범주로 나눌 수 있다고 주장합니다. 특정한 스크롤 관련 동작과 좀 더 일반적인 스크롤 관련 동작에 대한 기술입니다.

### 특정 스크롤 관련 동작을 위한 기술

현대 브라우저에서 지원하는 몇 가지 간단한 네이티브 CSS 스크롤 효과가 있다. 일부 제한된 사용 사례에서는 스크롤 애니메이션 요구에 충분할 수 있습니다.

요소가 페이지 일부에 대해 스크롤의 동일한 위치에 있으면 `위치: 끈적임`을 사용하는 것이 좋습니다. 그것은 간단하고 현대식 브라우저에 내장되어 있다. 즉, IE 지원과 일부 모바일 브라우저의 경우 폴리필이 필요하다. 확실한 개요는 Prethi로 이 문서를 참조하십시오.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 600px;"><iframe id="cp_embed_38ed324172db614edc8263557ef22e72" src="//codepen.io/anon/embed/38ed324172db614edc8263557ef22e72?height=600&amp;theme-id=1&amp;slug-hash=38ed324172db614edc8263557ef22e72&amp;default-tab=result" height="600" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed 38ed324172db614edc8263557ef22e72" title="CodePen Embed 38ed324172db614edc8263557ef22e72" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이 기술은 기술만큼 대단한 기술은 아니지만, 스크롤을 통해 다양한 페이지 조각이 서로 다른 속도로 이동하기를 원하는 단순한 시차 효과에는 꽤 편리합니다. 이 기술은 Alligator.io에 잘 기록되어 있고, CodePen에는 여러 가지 예가 있습니다. 파이어워치 헤더와 같은 것들이죠. 저에게 가장 큰 단점은 시차 효과를 정확하게 얻기 위해 관점을 설정하고 변혁하기 위해 어떤 가치를 사용해야 하는지 이해하기 어렵다는 것입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 600px;"><iframe id="cp_embed_50fa723dc4c4fea3ed22bb82035e9359" src="//codepen.io/anon/embed/50fa723dc4c4fea3ed22bb82035e9359?height=600&amp;theme-id=1&amp;slug-hash=50fa723dc4c4fea3ed22bb82035e9359&amp;default-tab=result" height="600" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed 50fa723dc4c4fea3ed22bb82035e9359" title="CodePen Embed 50fa723dc4c4fea3ed22bb82035e9359" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

스크롤 스냅 포인트를 사용하면 브라우저가 사용자가 일반 스크롤을 완료한 후 설정한 특정 스크롤 위치로 스냅할 수 있습니다. 특정 요소를 계속 볼 수 있도록 하는 데 유용합니다. 다만, API가 아직 유동적이므로 최신 API를 최대한 활용하고, 생산에 의존할 수 있도록 주의하시기 바랍니다. 맥스 콜러가 쓴 이 CSS-Tricks 기사는 지금 당장 그것에 대해 배우기에 좋은 장소이다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 600px;"><iframe id="cp_embed_LYpbezM" src="//codepen.io/anon/embed/LYpbezM?height=600&amp;theme-id=1&amp;slug-hash=LYpbezM&amp;default-tab=result" height="600" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed LYpbezM" title="CodePen Embed LYpbezM" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

자바스크립트의 window.scrollTo() 또는 CSS의 스크롤 동작 속성을 사용하여 페이지 내에서 섹션 간에 이동할 때 부드러운 스크롤이 기본적으로 지원됩니다. 마우스 휠 동작을 부드럽게 하는 일반적인 부드러운 스크롤은 현재 모든 브라우저에서 기본적으로 지원되지 않습니다. 마우스휠 동작을 위해 부드러운 스크롤 지원을 추가하려는 다양한 자바스크립트 라이브러리가 있지만, 버그가 없고 다른 모든 스크롤 기술로 잘 작동하는 라이브러리를 아직 찾지 못했다. 게다가, 처음부터 부드러운 스크롤이 항상 좋은 것은 아닙니다.

### 일반적인 스크롤 동작을 위한 기술

현재, 단지 CSS를 사용하여 스크롤 위치에 기초한 일반 애니메이션을 만들거나 실행할 방법이 없다(먼 미래에 CSS에서 어떤 형태의 일반 스크롤 기반 애니메이션을 지원할 수 있는 제안이 있지만). 따라서 스크롤에서 요소를 애니메이션화하려면 원하는 효과를 생성하려면 최소한 일부 JavaScript를 사용해야 합니다. 자바스크립트를 사용하여 스크롤에서 애니메이션을 실행하는 방법은 교차로 관찰자를 사용하는 방법과 스크롤 이벤트를 사용하는 두 가지가 있다.

애니메이션에 필요한 정보가 뷰포트에 표시되는 요소 유무 및 표시량과 관련된 정보라면 교차로 관찰자가 좋습니다. 이것은 그들을 애니메이션 공개에 좋은 선택으로 만든다. 그럼에도 불구하고 요소가 뷰포트에 들어가는 방향에 따라 다른 애니메이션을 발사하는 것과 같은 교차로 관찰자를 사용하여 (불가능하지는 않지만) 어떤 것은 어렵다. 요소가 시작점과 끝점 사이에 있고 겹치지 않을 때 스크롤 애니메이션을 수행하려는 경우에도 교차로 관찰자는 그다지 도움이 되지 않습니다.

스크롤 이벤트를 사용하면 스크롤의 애니메이션을 가장 자유롭게 제어할 수 있습니다. 뷰포트의 위치에 관계없이 스크롤의 요소에 영향을 미치고 프로젝트에 필요한 시작점과 끝점을 정확하게 설정할 수 있습니다.

따라서 올바르게 조절되지 않고 특정 동작을 만들 수 있는 편리한 API가 없는 경우에도 성능에 집중될 수 있습니다. 이러한 이유로 사용자가 조절 기능을 처리하고 사용할 수 있는 보다 편리한 API를 제공하는 좋은 스크롤 라이브러리를 사용하는 것이 도움이 되는 경우가 많습니다. 어떤 사람들은 여러분을 위해 사이즈 조절 문제를 많이 다룰 수도 있어요!

### 일반적인 스크롤 동작을 만드는 도구

모든 계산을 직접 수행하지 않고도 스크롤에 있는 애니메이션을 완벽하게 제어할 수 있는 몇 가지 전체적인 스크롤 라이브러리가 있습니다.

ScrollMagic은 스크롤에 대한 다양한 효과를 생성할 수 있는 비교적 단순한 API를 제공하며 GSAP와 Velocity.js와 같은 다른 애니메이션 라이브러리에 연결할 수 있다. 하지만 지난 몇 년간 유지관리가 덜 되어 Scroll Scene이 탄생하게 되었다.

ScrollScene은 기본적으로 ScrollMagic 및/또는 교차로 관찰자를 더 쉽게 사용할 수 있도록 하기 위한 래퍼입니다. 사용자 정의의 ScrollMagic 버전을 사용하며 비디오 재생, 중단점의 장면, 장면 지속 시간 중단점과 같은 추가 기능을 추가합니다. GSAP도 활용한다.

스크롤 트리거는 GSAP용 공식 GreenSock 플러그인입니다. 기능 목록이 길고 어떤 스크롤 라이브러리보다도 사용하기 쉬운 API를 가지고 있다. 이 기능을 사용하면 스크롤 애니메이션의 시작 및 끝 위치를 정의하고, 스크롤에서 임의의 항목(WebGL, 캔버스, SVG, DOM 등)을 애니메이션으로 만들고, 애니메이션이 실행되는 동안 요소를 고정하는 등의 작업을 수행할 수 있습니다. 부드럽게 스크롤할 수 있는 라이브러리에 연결할 수도 있습니다. 그러면 라이브러리가 함께 잘 작동합니다. 또한 GreenSock 및 GreenSock 포럼을 지원합니다.

위에서 언급한 다른 라이브러리들처럼 스크롤 라이브러리를 포괄적으로 구성하려고 하지는 않지만, Locomotive Scroll은 사용자 정의 매끄러운 스크롤을 제공하는 데 초점을 맞추고 있다. 데이터 속성을 추가하거나 `onscrol` 이벤트에 연결하여 다른 유형의 개체를 애니메이션할 수도 있습니다.

### 요약하면

끈적거리는 위치결정과 시차같은 특정한 스크롤 애니메이션 효과의 경우, 적어도 그러한 속성을 지원하지 않는 브라우저에 폴리필을 사용할 때 CSS 기술은 충분할 것이다.

나는 일반적으로 GSAP의 Scroll Trigger를 사용하는 것을 추천한다. 왜냐하면 그것은 CSS 속성뿐만 아니라 더 많은 것들을 할 수 있기 때문이다. Scroll Trigger(스크롤 트리거)는 애니메이션에 집중할 수 있도록 브라우저 지원 및 계산을 처리합니다!

다음은 특정 효과를 생성하는 데 사용할 수 있는 도구에 대한 표입니다.

다음은 스크롤 기술의 다양한 다른 측면을 비교하는 표입니다.