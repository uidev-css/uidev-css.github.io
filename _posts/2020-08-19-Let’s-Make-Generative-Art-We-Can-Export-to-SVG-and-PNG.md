---
layout: post
title: "SVG와 PNG에 수출할 수 있는 창조적 예술을 만들자"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/08/generative-art.png
tags: ART,GENERATOR,RANDOMIZE
---


당신이 디자이너라고 가정해 봅시다. 잘됐네요. 회의를 위해 디자인 작업을 맡으셨군요. 온갖 종류의 물건들. 웹사이트. 인쇄된 일정입니다. 방에 붙이는 커다란 포스터. 슬라이드를 사전 롤링합니다. 뭐든지 말씀해 보세요.

그래서 여러분은 이 모든 것에 대한 미적 감각을 만들어냅니다. 이 모든 것을 하나로 묶고 응집력을 느끼게 하는 디자인 분위기입니다. 그러나 각 용도는 고유하고 다를 것입니다. 좋아, 거기서부터 가자.

여러분은 디자인 소프트웨어에서 빈둥거리고 있습니다. 그리고 여러분이 생각해낸 아름다움은 모든 재료에서 사용할 수 있다고 생각되는 특정한 제한된 색상 팔레트와 무작위화된 패턴으로 겹치는 직사각형들입니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/08/Screen-Shot-2020-08-12-at-2.21.08-PM.png?resize=1024%2C548&ssl=1)

이봐, 물론이지. 재미있는 배경 무늬네요. 흰색 상자를 그 위에 올려놓아 종류든 뭐든 설정할 수 있습니다. 이것은 여러분이 넓게 사용할 수 있는 일반적인 배경 미학입니다.

하지만 디자인 소프트웨어에서는 랜덤하지 않습니다. 그렇죠? 소프트웨어를 스크립팅하는 방법을 알아 낼 수 있을 것 같은데요. 하지만 우리는 웹피플이니까 그걸로 웹을 해보자. 자바스크립트와 SVG에 기대어 시작해보자.

다음과 같이 프로그래밍 방식으로 색상 팔레트를 정의할 수 있습니다.

```js
const colorPalette = ["#9B2E69", "#D93750", "#E2724F", "#F3DC7B", "#4E9397"];
```

그런 다음 주어진 최소값과 최대값을 기준으로 랜덤 직사각형 묶음을 만드는 함수를 작성합니다.

```js
const rand = (max) => {
  return Math.floor(Math.random() * max);
};

const makeRects = (maxX, maxY) => {
  let rects = "";
  for (let i = 0; i < 100; i++) {
    rects += `
      <rect
        x="${rand(maxX + 50) - 50}"
        y="${rand(maxY + 50) - 50}"
        width="${rand(200) + 20}"
        height="${rand(200) + 20}"
        opacity="0.8${rand(10)}"
        fill="${colorPalette[rand(5)]}"
      />
    `;
  }
  return rects;
};
```

당신은 그 기능을 `svg`라고 부르고 모든 직사각형을 `<svg>로 쳐서 멋진 창작 예술품을 얻을 수 있을 것이다.

이제 당신의 일은 쉬워요! 새로운 코드를 만들기 위해 코드를 여러 번 실행하면 필요한 모든 용도로 사용할 수 있는 멋진 SVG를 얻게 됩니다.

고객이 작업 중인 다른 작업에 대한 배경으로 사용할 이 아트워크의 일부를 요청한다고 가정해 보겠습니다. 그들은 다른 차원을 가진 배경이 필요해요! 다른 종횡비로! 지금 당장 필요하대!

브라우저에서 이 작업을 수행한다는 사실이 여기에서 매우 도움이 됩니다. 브라우저 창의 크기를 쉽게 조정할 수 있습니다. 와, 나도 알아. 그러면 상위 SVG의 크기를 전체 뷰포트에 맞춥니다. SVG는 이 기능을 호출하여 모든 랜덤 사각형을 만듭니다.

```js
const makeSVG = () => {
  const w = document.body.offsetWidth;
  const h = document.body.offsetHeight;
  const svg = `<svg width="${w}" height="${h}">
    ${makeRects(w, h)}
  </svg>`;
  return svg;
};
```

따라서 브라우저에서 이 작업을 수행할 경우 브라우저가 매우 넓고 분할된 SVG 결과를 얻을 수 있습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/08/art-4.png?resize=1024%2C239&ssl=1)

하지만 어떻게 하면 브라우저에서 실제 SVG 파일로 만들 수 있을까요? 글쎄요, 아마 그것을 할 수 있는 기본적인 플랫폼 방법들이 있을 겁니다. 하지만 저는 구글에서 빠져나올 방법을 찾았고, 그 속임수를 쓸 수 있는 코드 조각들을 발견했습니다. 저는 SVG를 문자열로 삼아 데이터 URL에 링크의 href로 채우고 그 링크를 가짜로 클릭합니다. 나는 버튼 클릭 한 번으로 그것을 한다.

```js
function download(filename, text) {
  var pom = document.createElement("a");
  pom.setAttribute(
    "href",
    "data:text/plain;charset=utf-8," + encodeURIComponent(text)
  );
  pom.setAttribute("download", filename);

  if (document.createEvent) {
    var event = document.createEvent("MouseEvents");
    event.initEvent("click", true, true);
    pom.dispatchEvent(event);
  } else {
    pom.click();
  }
}

const downloadSvgButton = document.querySelector("#download-svg-button");
downloadSvgButton.addEventListener("click", () => {
  download("art.svg", window.globalSVGStore);
});
```

> 하지만 난 PNG가 필요해!

…고객을 안심시킵니다. 당연하죠. 모든 사람이 SVG를 보고 처리할 수 있는 소프트웨어를 가지고 있는 것은 아닙니다. 그냥 그 페이지의 스크린샷을 찍으시면 됩니다. 그리고, 솔직히, 그게 좋은 방법일 수도 있어요. 저는 화소 밀도가 높은 디스플레이를 가지고 있는데, 그 스크린샷들은 아주 잘 나와요.

하지만 이제 SVG용 다운로드 시스템을 구축했으므로 PNG에서도 사용할 수 있습니다. 이번에는 내 Googleing이 FileSaver.js로 이어졌다. 만약 내가 `캔버스`를 가지고 있다면, 나는 그것을 블러빙해서 파일에 저장할 수 있다. 그리고 나는 유세를 통해 나의 <svg>를 <캔버스>로 바꿀 수 있다.

그래서 우리가 SVG를 만들기 위해 우리의 기능을 호출할 때, 우리는 그것을 캔버스에 칠할 것입니다. 이것은 자동적으로 우리가 뷰포트를 덮을 수 있는 크기인 SVG와 같은 크기가 될 것입니다.

```js
const setup = () => {
  const v = canvg.Canvg.fromString(ctx, makeSVG());
  v.start();
};
```

언제든지 설정 기능을 호출할 수 있으므로, 브라우저 창의 크기가 조정될 때 호출하는 것이 좋습니다. 여기 실행 중입니다.


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video controls="" src="https://css-tricks.com/wp-content/uploads/2020/08/export.mp4" name="fitvid0"></video>
</div>


마지막은 이렇습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_OJNVywW" src="//codepen.io/anon/embed/OJNVywW?height=450&amp;theme-id=1&amp;slug-hash=OJNVywW&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed OJNVywW" title="CodePen Embed OJNVywW" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

훨씬 더 똑똑할 수도 있어요. 예를 들어 뷰포트 볼륨을 기준으로 그릴 직사각형 수를 결정할 수 있습니다. 저는 디자인 자산, 특히 실제 고객 문제를 해결하기 위해 예술 창작 기계를 만드는 것이 아주 멋지다고 생각합니다.

이 아이디어는 제가 실제 몇몇 디자이너들이 이렇게 만든 도구를 훔쳐본 것입니다. 그들의 것은 훨씬 더 멋졌고 더 많은 선택권이 있었습니다. 그리고 저는 그들이 누구를 위해 그것을 만들었는지 알고 있습니다. 왜냐하면 그것이 저에게 그것을 보여준 사람이기 때문입니다. 나는 그 디자이너에게 연락했지만 그들은 너무 바빠서 이런 글쓰기를 할 수 없었다.