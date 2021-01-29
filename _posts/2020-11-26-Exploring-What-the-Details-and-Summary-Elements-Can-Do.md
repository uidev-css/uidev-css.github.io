---
layout: post
title: "세부 정보 및 요약 요소로 수행 할 수있는 작업 탐색"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/11/details-tooltip.png
tags: DETAILS/SUMMARY,FOOTNOTES,TOOLTIP
---


앞서`<details>`및`<summary>`요소가 얼마나 훌륭한 지 언급했습니다.
 터치, 마우스 및 키보드 입력에 액세스 할 수있는 아코디언을 빠르게 만드는 데 좋습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_jzmjPJ" src="//codepen.io/anon/embed/jzmjPJ?height=250&amp;theme-id=1&amp;slug-hash=jzmjPJ&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed jzmjPJ" title="CodePen Embed jzmjPJ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

`<details>`및`<summary>`는 GIF 재생 / 일시 중지에도 사용할 수 있습니다!
 이 이미지의 오른쪽 상단에있는 일시 중지 버튼을 클릭하여 실제 작동을 확인하세요.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_pogQJER" src="//codepen.io/anon/embed/pogQJER?height=450&amp;theme-id=1&amp;slug-hash=pogQJER&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed pogQJER" title="CodePen Embed pogQJER" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

깔끔 하죠?
 그러나이 요소들은 또 무엇을 할 수 있습니까?
 오랫동안 아코디언을 만드는 방법으로 `디테일`만 생각했습니다.
 하지만 다른 날에 나는 그것에 대해 조금 생각하기 시작했고, 가장 먼저 깨달은 것은 아마도 그들과 함께 더 나은 각주를 만들 수 있다는 것입니다.
 

다음은 일반적으로 HTML만으로 각주를 작성합니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_f7948ea36e02a0af7ea548e423792671" src="//codepen.io/anon/embed/f7948ea36e02a0af7ea548e423792671?height=450&amp;theme-id=1&amp;slug-hash=f7948ea36e02a0af7ea548e423792671&amp;default-tab=html,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed f7948ea36e02a0af7ea548e423792671" title="CodePen Embed f7948ea36e02a0af7ea548e423792671" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

단락의 링크를 클릭하면 각주 설명이있는 페이지 하단으로 이동합니다.
 요소의 ID를 앞뒤로 연결하여이를 수행합니다.
 그러나!
 각주를 인라인으로 만들 수있는 BigFoot과 같은 jQuery 플러그인이 있습니다.
 

다음은 BigFoot 스크립트와 jQuery가 적용된 동일한 예입니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 400px;"><iframe id="cp_embed_c4cc43d15642955cccdcd3b50a489881" src="//codepen.io/anon/embed/c4cc43d15642955cccdcd3b50a489881?height=400&amp;theme-id=1&amp;slug-hash=c4cc43d15642955cccdcd3b50a489881&amp;default-tab=result" height="400" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed c4cc43d15642955cccdcd3b50a489881" title="CodePen Embed c4cc43d15642955cccdcd3b50a489881" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

깔끔 하죠?
 BigFoot는 액세스 가능한 마크 업을 가져 와서 모든 링크 항목을 제거하고 작은 버튼과 툴팁으로 바로 인라인으로 표시합니다.
 

하지만`<details>`와`<summary>`를 사용하여 각주에이 jQuery와 일반 ol `HTML을 대체 할 수 있다면 어떨까요?
 글쎄요, 안타깝게도 할 수 없습니다.
 이러한 요소 중 하나를`<p>`태그 내에 배치하려고하면 브라우저는 해당 요소를`<p>`요소 외부에 렌더링합니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_7708a64726b423851282ce43c3bc2942" src="//codepen.io/anon/embed/7708a64726b423851282ce43c3bc2942?height=450&amp;theme-id=1&amp;slug-hash=7708a64726b423851282ce43c3bc2942&amp;default-tab=html,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed 7708a64726b423851282ce43c3bc2942" title="CodePen Embed 7708a64726b423851282ce43c3bc2942" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

어쩌다!
 이것은 성가신 일이지만 왜 이렇게 작동하는지 알 수 있습니다.
 이러한 모든 링크의 복잡성과 페이지 위아래로 이동하는 엉뚱한 경험을 대체 할 수 있다면 좋을 것입니다.
 그러나 우리는 할 수 없습니다.
 

그렇게 할 수 없다면`<details>`와`<summary>`를 다른 용도로 사용할 수 있습니까?
 이것은 제가 생각하게했습니다. 툴팁은 어떻습니까?
 그래, 그래!
 우리는 절대적으로 할 수 있습니다.
 표시된 날짜를 확장하는 다음과 같은 마크 업이 있다고 가정 해 보겠습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 300px;"><iframe id="cp_embed_2d91690944f6a29254257418be58647c" src="//codepen.io/anon/embed/2d91690944f6a29254257418be58647c?height=300&amp;theme-id=1&amp;slug-hash=2d91690944f6a29254257418be58647c&amp;default-tab=html,result" height="300" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed 2d91690944f6a29254257418be58647c" title="CodePen Embed 2d91690944f6a29254257418be58647c" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

꽤 표준 적입니다. 우리는 이것을 전에 본 적이 있습니다.
 하지만 이제 흥미로운 스타일링에 대해 알아 보겠습니다.
 먼저`<details>`요소를 처리해야합니다.
 

이렇게하면 세부 정보 요소 내에서 정보를 절대적으로 배치 할 수 있지만 도구 설명이 배경이있는 클릭 버튼처럼 약간 더 느껴질 수 있습니다.
 다음으로 다음을 수행하여`summary` 요소의 기본 화살표를 취소 할 수 있습니다.
 

```css
summary {
  background: url("https://assets.codepen.io/14179/Info.svg") 11px 11.5px no-repeat;
  list-style: none;
  padding: 10px;
  padding-left: 33px;
}
```

마지막으로 `details`요소 내에있는 단락을 절대적으로 배치해야합니다.
 그리고 나머지 툴팁을 가리키는 작은 삼각형을 만듭니다.
 

```css
details p {
  cursor: auto;
  background: #eee;
  padding: 15px;
  width: 250px;
  position: absolute;
  left: 0;
  top: 35px;
  border-radius: 4px;
  right: 0;
}

// Tiny triangle that points up
details p:before {
  content: "";
  border-bottom: 12px solid #eee;
  border-left: 8px solid transparent;
  border-right: 8px solid transparent;
  height: 0;
  left: 10px;
  position: absolute;
  top: -10px;
  width: 0;
}
```

이것은 이와 같은 결과로 이어집니다.
 도구 설명을 클릭하여 그 아래에 설명이 표시되는지 확인하세요.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 350px;"><iframe id="cp_embed_32b26a9c8dc28978ce326cc0f122934a" src="//codepen.io/anon/embed/32b26a9c8dc28978ce326cc0f122934a?height=350&amp;theme-id=1&amp;slug-hash=32b26a9c8dc28978ce326cc0f122934a&amp;default-tab=result" height="350" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed 32b26a9c8dc28978ce326cc0f122934a" title="CodePen Embed 32b26a9c8dc28978ce326cc0f122934a" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

여기서 할 수있는 한 가지 좋은 일은 툴팁이 열렸을 때 애니메이션을 추가하는 것입니다.
 

```css
details[open] p {
  animation: animateDown 0.2s linear forwards;
}

@keyframes animateDown {
  0% {
    opacity: 0;
    transform: translatey(-15px);
  }
  100% {
    opacity: 1;
    transform: translatey(0);
  }
}
```

그리고 거기에 있습니다!
 툴팁을 클릭하면 팝업이 열리고 탭하고 스페이스를 클릭하면 열리기도합니다.
 

그러나 우리는 이것을 조금 더 취할 수 있습니다.
 우리가 원하지 않는 것은이 툴팁이 여기 저기에 열리는 것입니다.
 툴팁을 많이 사용하면 매우 어색하고 시각적으로 산만해질 수 있습니다.
 우리가해야 할 일은 바깥 쪽을 클릭 할 때 툴팁을 닫는 것입니다.
 그리고 우리는 가벼운 자바 스크립트로 그렇게 할 수 있습니다.
 

```js
const tooltip = document.querySelector(".tooltip");

document.addEventListener("click", function (e) {
  var insideTooltip = tooltip.contains(e.target);

  if (!insideTooltip) {
    tooltip.removeAttribute("open");
  }
});
```

이제 툴팁을 클릭하면 닫힙니다.
 니토!
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 350px;"><iframe id="cp_embed_c80891a45a0445735ec19c650e60a5e1" src="//codepen.io/anon/embed/c80891a45a0445735ec19c650e60a5e1?height=350&amp;theme-id=1&amp;slug-hash=c80891a45a0445735ec19c650e60a5e1&amp;default-tab=result" height="350" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed c80891a45a0445735ec19c650e60a5e1" title="CodePen Embed c80891a45a0445735ec19c650e60a5e1" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

`<details>`및`<summary>`요소는 모든 작업을 수행 할 수는 없지만 확실히 많은 편리한 작업을 수행 할 수 있습니다. 이러한 요소 조합으로 수행 할 수있는 작업이 훨씬 더 많다고 생각합니다.
 우리는 그들을 찾아야 만합니다.
 사실, 여기에 주제에 대한 더 좋은 게시물이 있습니다.
 