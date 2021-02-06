---
layout: post
title: "스크롤에서 솔리드 텍스트에서 녹아웃 텍스트로 이동"
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2021/01/solid-knockout-text.png"
tags: CLIP,FIXED POSITION,TYPOGRAPHY
---


여기 여러분의 친구들을 보여주는 재미있는 CSS 속임수가 있습니다: 배경 이미지가 제자리로 스크롤되면서 솔리드 컬러에서 녹아웃 텍스트로 전환되는 큰 제목입니다. 그리고 우리는 플레인 올 HTML과 CSS를 이용해서 할 수 있어!

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/background-clip-final-1.gif?resize=1000%2C569&ssl=1)

이 효과는 고정된 <h1> 요소를 가진 두 컨테이너를 렌더링하여 생성됩니다. 첫 번째 컨테이너는 흰색 바탕에 녹아웃 텍스트가 있습니다. 두 번째 컨테이너에는 흰색 텍스트가 있는 배경 이미지가 있습니다. 그런 다음 몇 가지 화려한 클리핑 기술을 사용하여 사용자가 경계를 넘어 스크롤할 때 첫 번째 컨테이너의 텍스트를 숨긴다. 이것은 텍스트 배경이 변하고 있다는 착각을 불러일으킨다.

시작하기 전에 이전 버전의 Internet Explorer에서는 이 기능이 작동하지 않습니다. 또한 모바일 WebKit 브라우저에서는 고정 배경 이미지가 번거로울 수 있습니다. 이러한 상황에 대한 폴백 행동에 대해 반드시 생각해 보세요.

### HTML 설정

먼저 일반적인 HTML 구조를 만드는 것부터 시작하겠습니다. 외부 래퍼 안에서 우리는 각각 `.title_wrapper`로 포장된 `<h1>` 요소를 가진 두 개의 동일한 컨테이너를 생성한다.

```html
<header>

  <!-- First container -->
  <div class="container container_solid">
    <div class="title_wrapper">
      <h1>The Great Outdoors</h1>
    </div>
  </div>

  <!-- Second container -->
  <div class="container container_image">
    <div class="title_wrapper">
      <h1>The Great Outdoors</h1>
    </div>
  </div>

</header>
```

각 컨테이너에는 글로벌 `.container` 클래스와 고유 식별자 클래스인 `.container_solid` 및 `.container_image` 클래스가 모두 있습니다. 그래야 공통 기본 스타일을 만들 수 있고 CSS로 각 컨테이너를 별도로 공략할 수 있습니다.

### 초기 스타일

이제 컨테이너에 CSS를 추가해 보겠습니다. 우리는 각 컨테이너가 화면의 전체 높이가 되기를 원합니다. 첫 번째 컨테이너는 견고한 흰색 배경이 필요하며, 이는 ".container_solid" 클래스에서 수행할 수 있습니다. 또한 고정 배경 이미지를 두 번째 컨테이너에 추가하고자 하는데, 이 컨테이너의 `.container_image` 클래스에서 수행할 수 있습니다.

```css
.container {
  height: 100vh;
}

/* First container */
.container_solid {
  background: white;
}

/* Second container */
.container_image {
  /* Grab a free image from unsplash */
  background-image: url(/path/to/img.jpg);
  background-size: 100vw auto;
  background-position: center;
  background-attachment: fixed;
}
```

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2021/01/s_8DF948557000858756DDAABAAF8B1B62C7B90683C58FA3DAF5D26EC0EFB4B079_1611085759872_with-background.gif?resize=1292%2C572&ssl=1)

다음으로, 우리는 <h1> 요소를 약간 스타일링할 수 있습니다. .container_image 안의 텍스트는 단순히 흰색일 수 있습니다. 그러나 컨테이너_이미지 안에 있는 <h1> 요소의 녹아웃 텍스트를 얻으려면 배경 이미지를 적용한 다음 텍스트 채우기 색상과 배경 클립 CSS 속성을 파악하여 배경을 >1 요소의 경계가 아닌 텍스트 자체에 적용해야 한다. <h1> 배경은 당사의 .container_image 요소와 크기가 같습니다. 일이 잘 되도록 하는 것이 중요하다.

```css
.container_solid .title_wrapper h1 {
  /* The text background */
  background: url(https://images.unsplash.com/photo-1575058752200-a9d6c0f41945?ixlib=rb-1.2.1&q=85&fm=jpg&crop=entropy&cs=srgb&ixid=eyJhcHBfaWQiOjE0NTg5fQ);
  background-size: 100vw auto;
  background-position: center;
  
  /* Clip the text, if possible */
  /* Including -webkit` prefix for bester browser support */
  /* https://caniuse.com/text-stroke */
  -webkit-text-fill-color: transparent;
  text-fill-color: transparent;
  -webkit-background-clip: text;
  background-clip: text;
  
  /* Fallback text color */
  color: black;
}

.container_image .title_wrapper h1 {
  color: white;
}
```

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2021/01/s_8DF948557000858756DDAABAAF8B1B62C7B90683C58FA3DAF5D26EC0EFB4B079_1611085772765_with-text-styles.gif?resize=1292%2C572&ssl=1)

이제, 우리는 텍스트를 레이아웃의 중앙에 고정시키기를 원합니다. 글로벌 `.title_wrapper` 클래스에 고정 위치를 추가하고 창의 수직 중앙에 고정합니다. 그런 다음 텍스트 정렬을 사용하여 <h1> 요소의 중심을 수평으로 맞춥니다.

```css
.header-text {
  display: block;
  position: fixed; 
  margin: auto;
  width: 100%;
  /* Center the text wrapper vertically */
  top: 50%;
  -webkit-transform: translateY(-50%);
      -ms-transform: translateY(-50%);
          transform: translateY(-50%);
}

.header-text h1 {
  text-align: center;
}
```

이때 각 용기의 <h1>은 사용자가 스크롤할 때 창 중앙에 고정되어야 한다. 여기 텍스트 위치를 더 잘 볼 수 있도록 그림자가 추가된 전체 구성 코드입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_ExgOKEO" src="//codepen.io/anon/embed/ExgOKEO?height=450&amp;theme-id=1&amp;slug-hash=ExgOKEO&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed ExgOKEO" title="CodePen Embed ExgOKEO" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 텍스트 및 컨테이너 클리핑

여기서부터 일이 정말 흥미로워지기 시작합니다. 현재 스크롤 위치가 상위 컨테이너의 경계 내에 있을 때만 컨테이너의 <h1>이 표시되기를 원합니다. 일반적으로 상위 컨테이너의 `overflow:hidden;`을 사용하여 이 문제를 해결할 수 있습니다. 그러나 두 가지 `h1` 요소 모두 고정 포지셔닝을 사용하므로 이제 상위 요소보다는 브라우저 창에 상대적으로 배치된다. 이 경우 `overflow:hidden;`을 사용하면 아무 효과도 없다.

상위 컨테이너가 고정 오버플로 콘텐츠를 숨기려면 CSS `clip` 속성을 절대 포지셔닝과 함께 사용할 수 있습니다. 브라우저에 요소의 경계 밖에 있는 내용을 숨깁니다. .container 클래스의 스타일을 대체하여 오버플로 요소를 표시하지 않도록 합니다. 단, 이러한 요소가 고정 포지셔닝을 사용하더라도 마찬가지입니다.

```css
.container {
  /* Hide fixed overflow contents */
  clip: rect(0, auto, auto, 0);

  /* Does not work if overflow = visible */
  overflow: hidden;

  /* Only works with absolute positioning */
  position: absolute;

  /* Make sure containers are full-width and height */
  height: 100vh;
  left: 0;
  width: 100%;
}
```

이제 우리 컨테이너는 절대 위치 지정을 사용하므로, 정상적인 컨텐츠 흐름에서 제거됩니다. 그리고, 그 때문에, 우리는 각각의 부모 요소에 비례하여 그들을 수동으로 배치해야 합니다.

```css
.container_solid {
  /* ... */

  /* Position this container at the top of its parent element */
  top: 0;
}

.container_image {
  /* ... */

/* Position the second container below the first container */
  top: 100vh;
}
```

이 시점에서, 효과는 구체화되어야 한다. 스크롤하면 녹아웃 텍스트가 배경을 변경하는 것처럼 보이는 착시 현상이 나타납니다. 실제로 화면 중앙과 겹치는 상위 컨테이너에 따라 다른 <h1> 요소를 보여주는 클리핑 마스크일 뿐입니다.

### 사파리를 행복하게 만들자.

Safari를 사용하는 경우 스크롤할 때 렌더링 엔진이 보기를 제대로 새로 고치지 않는 것을 알 수 있습니다. 다음 코드를 `.container` 클래스에 추가하여 올바르게 새로 고치도록 합니다.

```css
.container {
  /* ... */

  /* Safari hack */
  -webkit-mask-image: -webkit-linear-gradient(top, #ffffff 0%,#ffffff 100%);
}
```

여기 이 시점까지의 전체 코드가 있다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_MWjLZzg" src="//codepen.io/anon/embed/MWjLZzg?height=450&amp;theme-id=1&amp;slug-hash=MWjLZzg&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed MWjLZzg" title="CodePen Embed MWjLZzg" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 청소시간

HTML이 접근성 베스트 프랙티스를 따르고 있는지 확인해 보겠습니다. 보조 기술을 사용하지 않는 사용자는 본 문서에 두 개의 동일한 < 요소가 있음을 알 수 없지만 화면 판독기를 사용하는 사용자는 두 개의 제목이 모두 발표되기 때문에 반드시 알 수 있습니다. 두 번째 용기에 아리아 히든을 추가하여 스크린 독자들에게 순수하게 장식적이라는 것을 알리자.

```html
<!-- Second container -->
<div class="container container_image" aria-hidden="true">
  <div class="title_wrapper">
    <h1>The Great Outdoors</h1>
  </div>
</div> 

```

스타일링에 관한 한 세상은 우리의 굴입니다. 원하는 대로 텍스트를 만들기 위해 글꼴과 글꼴 크기를 자유롭게 수정할 수 있습니다. 시차 효과를 더하거나 배경 이미지를 동영상으로 대체함으로써 이것을 더 발전시킬 수도 있습니다. 하지만, 그 시점에서, 접근성을 위해 약간의 추가 작업을 해야 합니다. 그래서 움직임을 덜 원하는 사람들은 적절한 경험을 할 수 있도록 말이죠.

그렇게 어려운 일은 아니었죠?

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_MWwGpmR" src="//codepen.io/anon/embed/MWwGpmR?height=450&amp;theme-id=1&amp;slug-hash=MWwGpmR&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed MWwGpmR" title="CodePen Embed MWwGpmR" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>