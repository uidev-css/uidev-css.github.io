---
layout: post
title: "CSS에서 사물을 숨기는 다양한 방법 비교
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/10/magic-stage-hiding-elements.jpg
tags: ACCESSIBILITY,HIDING
---


CSS로 콘텐츠를 숨기는 것은 간단하고 해결 된 문제라고 생각할 수 있지만, 각각 고유 한 여러 솔루션이 있습니다.
 

개발자는 가장 일반적으로`display : none`을 사용하여 페이지의 콘텐츠를 숨 깁니다.
 안타깝게도 콘텐츠를 숨기는 방법은 이제 화면 판독기가 콘텐츠에 "액세스 할 수 없기"때문에 방탄이 아닙니다.
 사용하고 싶은 유혹이 있지만 특히 시각적으로 만 숨길 수있는 경우에는 손을 뻗지 마세요.
 

사실은 CSS에서 항목을 "숨기는"방법이 여러 가지가 있으며 각 방법에는 사용 방법에 따라 장단점이 있습니다.
 여기에서 각 기술을 검토하고 어떤 기술을 언제 사용할지 결정하는 데 도움이되는 요약으로 요약 할 것입니다.
 

### 기술 간의 차이점을 발견하는 방법
 

콘텐츠를 숨기는 다양한 방법의 차이점을 확인하려면 몇 가지 메트릭을 도입해야합니다.
 방법을 비교하는 데 사용할 측정 항목입니다.
 저는 레이아웃, 성능 및 접근성에 영향을 미치는 네 가지 특정 영역에 초점을 맞춘 질문을 통해이를 분류하기로 결정했습니다.
 

- 접근성 : 숨겨진 콘텐츠를 스크린 리더로 읽습니까?
 
- 문서 흐름 : 숨겨진 요소가 문서 레이아웃에 영향을 줍니까?
 
- 렌더링 : 숨겨진 요소의 상자 모델이 렌더링됩니까?
 
- 이벤트 트리거 : 요소가 클릭 또는 초점을 감지합니까?
 

이제 기준을 벗어 났으므로 방법을 비교해 보겠습니다.
 다시 말하지만, CSS에서 항목을 숨길 때 결정을 내리는 데 참고 자료로 사용할 수 있도록 모든 것을 마지막에 정리합니다.
 

### 방법 1 :`display` 속성
 

`디스플레이`를 사용하여 콘텐츠를 숨기는 것에 대해주의하면서이 게시물을 시작했습니다.
 그리고 우리가 설정했듯이 요소를 숨기는 데 사용한다는 것은 요소가 전혀 생성되지 않음을 의미합니다.
 DOM에 있지만 실제로 렌더링되지는 않습니다.
 

요소는 마크 업에 계속 표시되며 페이지를 검사하면 요소를 볼 수 있습니다.
 상자 모델은 페이지에 생성되거나 나타나지 않으며 모든 하위 항목에도 적용됩니다.
 


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video autoplay="" controls="" loop="" muted="" src="https://css-tricks.com/wp-content/uploads/2020/10/display-toggle.mp4" playsinline="" name="fitvid0"></video>
</div>


또한 요소에 이벤트 리스너 (예 : 클릭 또는 마우스 오버)가 있으면 전혀 등록되지 않습니다.
 이미 논의했듯이 스크린 리더는 모든 콘텐츠를 무시합니다.
 여기에 두 개의 보이는 버튼과 `display : none`으로 숨겨진 하나가 있습니다.
 세 버튼 모두 클릭 이벤트가 있지만 보이는 버튼 두 개만 렌더링하고 클릭을 등록합니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_mdEJPwe" src="//codepen.io/anon/embed/mdEJPwe?height=450&amp;theme-id=1&amp;slug-hash=mdEJPwe&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed mdEJPwe" title="CodePen Embed mdEJPwe" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

디스플레이는 이미지 요청 실행에 영향을 미치는 유일한 속성입니다.
 이미지 태그 (또는 상위 요소)에 인라인 CSS 또는 선택기를 통해 `표시`속성이 `없음`으로 설정된 경우 이미지가 다운로드됩니다.
 반면에 이미지가 `배경`속성으로 적용된 경우 다운로드되지 않습니다.
 

HTML 문서가 파싱되고`<img>`태그가 발견 될 때 파서가 CSS를 적용하지 않았기 때문입니다.
 반면에 `background`속성이있는 요소에 이미지를 적용하면 파서가 이미지가 호출되는 CSS를 적용하지 않았기 때문에 이미지가 다운로드되지 않습니다.
 이 동작은 모든 최신 브라우저에서 일치합니다.
 유일한 예외는 두 경우 모두 이미지를 다운로드하는 IE 11입니다.
 

### 방법 2 :`visibility` 속성
 

요소의 `visibility`속성이 `hidden`으로 설정되면 해당 요소는 `시각적으로 숨겨집니다`.
 `시각적으로 숨겨진 다`는 것은 `display : none`이하는 것처럼 들리지만 요소가 생성되고 렌더링되지만 보이지 않는다는 점에서 엄청나게 다릅니다.
 즉, 요소의 상자 모델이 존재하므로 해당 요소가 나타나지 않는 것처럼 보이지만 화면에서 계속 공간을 차지하는 크기를 제공합니다.
 

다른 사람에게는 보이지 않는 보이지 않는 망토를 입고 있지만 여전히 사물에 부딪 힐 수 있다고 상상해보세요.
 육안으로는 보이지 않더라도 물리적으로 거기에 있습니다.
 

그러나 이것이 "시각적으로 숨김"과 "표시되지 않음"의 차이점이 끝나는 곳입니다.
 실제로`visibility` 및`display`로 숨겨진 요소는 접근성 및 이벤트 트리거 측면에서 동일하게 작동합니다.
 다음 데모에서 볼 수 있듯이 보이지 않는 요소는 스크린 리더에서 액세스 할 수 없으며 이벤트를 등록하지 않습니다. 이는 마지막 예와 똑같지 만 단순히`display : none`을`visibility : hidden`으로 바꿉니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_oNLXxWr" src="//codepen.io/anon/embed/oNLXxWr?height=450&amp;theme-id=1&amp;slug-hash=oNLXxWr&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed oNLXxWr" title="CodePen Embed oNLXxWr" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 방법 3 : '불투명도'속성
 

`opacity` 속성은 요소의 시각적 측면에만 영향을줍니다.
 요소의 `불투명도`를 0으로 설정하면 요소가 완전히 투명 해집니다.
 다시 말하지만, 보이지 않지만 여전히 물리적으로 존재하는 요소에 보이지 않는 망토를 드리 우는 `가시성 : 숨김`과 매우 유사합니다.
 

즉, 우리가 가지고있는 것은 다른 요소처럼 작동하는 속이 비어 있고 투명한 요소입니다.
 `가시성`방법과 비슷하게 들리 죠?
 차이점은 완전히 투명한 요소는 여전히 스크린 리더에서 액세스 할 수 있으며 다음 예에서 볼 수 있듯이 클릭과 같은 이벤트를 등록 할 수 있다는 것입니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_abZONWP" src="//codepen.io/anon/embed/abZONWP?height=450&amp;theme-id=1&amp;slug-hash=abZONWP&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed abZONWP" title="CodePen Embed abZONWP" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 방법 4 :`position` 속성
 

절대 위치 지정으로 요소를 화면 밖으로 밀어내는 것은 개발자가 종종 사물을 숨기는 또 다른 방법입니다.
 `top`과`left`를 사용하여 요소를 화면 밖으로 너무 멀리 밀어서 보이지 않게 할 수 있습니다.
 마치 집 밖에 쿠키 항아리를 숨겨서 아이들 (혹은 당신도!)이 찾을 수 없도록하는 것과 같습니다.
 

여기서 핵심어는 "절대"입니다.
 `position`을`absolute`로 설정하면 문서 흐름에서 요소가 제거됩니다. 즉, DOM에서 더 이상 원래 위치를 고수하지 않는다는 의미입니다.
 즉, 페이지는 공간을 예약하지 않으므로 요소가 시각적으로 정렬되지 않고 가장 가까운 위치에있는 요소 (있는 경우) 또는 문서 루트 (다른 것이 없으면 문서 루트)에 배치됩니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_jOrqLBe" src="//codepen.io/anon/embed/jOrqLBe?height=450&amp;theme-id=1&amp;slug-hash=jOrqLBe&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed jOrqLBe" title="CodePen Embed jOrqLBe" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

문서 흐름에서 "숨겨진"요소를 가져 와서 `-9999px`값으로 왼쪽 상단으로 오프셋하여 절대 위치 지정을 활용합니다.
 

```css
.hidden {
  position: absolute;
  top: -9999px;
  left: -9999px;
}
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_mdEJPWJ" src="//codepen.io/anon/embed/mdEJPWJ?height=450&amp;theme-id=1&amp;slug-hash=mdEJPWJ&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed mdEJPWJ" title="CodePen Embed mdEJPWJ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

숨겨진 요소에 포커스 가능한 콘텐츠가 포함 된 경우 페이지는 포커스가있는 요소로 스크롤되어 갑작스런 점프를 만듭니다.
 

### 방법 5 : "시각적으로 숨겨진"클래스
 

지금까지 `position`방법은 CSS에서 항목을 숨기는 접근성 친화적 인 방법에 가장 가깝습니다.
 그러나 갑작스러운 페이지 점프를 유발하는 집중 가능한 콘텐츠의 문제는 크지 않습니다.
 접근 가능한 숨김에 대한 또 다른 접근 방식은 절대 위치 지정,`clip` 속성 및 숨김 오버플로를 결합하는 것입니다.
 Scott O’Hara는 2017 년 블로그에 올렸습니다.
 

```css
.visually-hidden:not(:focus):not(:active) {
  clip: rect(0 0 0 0); 
  clip-path: inset(50%);
  height: 1px;
  overflow: hidden;
  position: absolute;
  white-space: nowrap; 
  width: 1px;
}
```

그것을 분해 해 보겠습니다.
 

문서 흐름에서 요소를 제거해야합니다.
 이를 수행하는 가장 좋은 방법은`position : absolute`를 사용하는 것입니다.
 이렇게하면 요소가 제거되지만 화면 밖으로 밀어 내지는 않습니다.
 

```css
.visually-hidden {
  position: absolute;
}
```

width 및 height 속성을 0으로 설정하여 요소를 숨길 수 있습니다.
 안타깝게도 일부 스크린 리더는 너비와 높이가 0 인 요소를 무시하므로 작동하지 않습니다.
 우리가 할 수있는 것은 두 번째로 낮은 값인 `1px`로 설정하는 것입니다.
 즉, 콘텐츠가 공간을 쉽게 넘칠 수 있으므로 시각적으로 넘치지 않도록 `overflow : hidden`도 필요합니다.
 

```css
.visually-hidden {
  height: 1px;
  overflow: hidden;
  position: absolute;
  width: 1px;
} 
 
 

```

1 픽셀 사각형을 숨기려면 CSS 클리핑 속성을 사용할 수 있습니다.
 스크린 리더에 영향을주지 않으므로이 상황에 적합합니다.
 내용은 있지만 다시 시각적으로 숨겨져 있습니다.
 주목할 점은`clip`이`clip-path` 대신 사용되지 않지만 이전 버전의 Internet Explorer를 지원해야하는 경우 여전히 필요하다는 것입니다.
 

```css
.visually-hidden {
  clip: rect(0 0 0 0);
  clip-path: inset(50%);
  height: 1px;
  overflow: hidden;
  position: absolute;
  width: 1px;
} 
 

```

"시각적으로 숨겨진"클래스 퍼즐의 또 다른 부분은 화면 밖에서 액세스 가능한 텍스트를 처리하는 것입니다.이 문제는 단어 사이의 공백을 제거하여 하나의 큰 단어 문자열처럼 소리내어 읽게하는 이상한 현상입니다.
 예를 들어, "Welcome back home"은 "Welcomebackhome"으로 읽혀집니다.
 

이 문제에 대한 간단한 해결책은`white-space : nowrap`을 설정하는 것입니다.
 

```css
.visually-hidden {
  clip: rect(0 0 0 0);
  clip-path: inset(50%);
  height: 1px;
  overflow: hidden;
  position: absolute;
  white-space: nowrap;
  width: 1px;
} 

```

그리고 마지막으로!
 마지막으로 고려해야 할 사항은 기본 포커스가있는 특정 요소와 활성 사이트가 포커스에있을 때 표시되도록 허용하는 동시에 단락과 같은 다른 요소가 계속 표시되지 않도록하는 것입니다.
 이를 위해`: not` 의사 선택기를 사용할 수 있습니다.
 

```css
.visually-hidden:not(:focus):not(:active) {
  clip: rect(0 0 0 0);
  clip-path: inset(50%);
  height: 1px;
  overflow: hidden;
  position: absolute;
  white-space: nowrap;
  width: 1px;
} 

```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_ExyjKZd" src="//codepen.io/anon/embed/ExyjKZd?height=450&amp;theme-id=1&amp;slug-hash=ExyjKZd&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed ExyjKZd" title="CodePen Embed ExyjKZd" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 명예로운 언급
 

우리가 다룬 5 가지 방법보다 더 많은 방법이 있습니다.
 예를 들어,`text-indent` 속성은`position` 메서드와 같이 텍스트를 화면 밖으로 밀어 낼 수 있습니다.
 

```css
.hidden {
  text-indent: -9999em;
}
```

안타깝게도이 방법은 RTL 쓰기 모드에 적합하지 않습니다.
 따라서 우리가 다룬 다른 솔루션보다 적응력이 떨어집니다.
 

또 다른 방법은 `변환`을 사용하여 요소를 확장하거나 이동하는 것입니다.
 `불투명도`처럼 시각적으로 만 동일하게 작동합니다.
 

```css
.hidden {
  transform: scale(0);
}
```

### 모든 것을 모 읍시다!
 

콘텐츠를 시각적으로 숨기지 만 액세스 할 수있는 솔루션을 찾았습니다.
 그렇다면`display : none` 사용을 중단해야합니까?
 아니요, 이것은 여전히 요소를 완전히 (시각적으로 그리고 접근 가능하게) 숨기는 가장 좋은 방법입니다.
 

즉, 반대의 결과를 얻으려면 화면 판독기에서 무언가를 숨기려면`aria-hidden = "true"`속성이 화면 판독기에서 콘텐츠를 숨기지 만 시각적으로는 숨기지 않는다는 점을 언급 할 가치가 있습니다.
 

이를 통해 모든 접근 방식을 비교하는 완전한 표가 있습니다.
 다음에 해당 상황에 처할 때 콘텐츠를 숨기는 방법에 대한 결정을 내리는 데 사용하십시오.
 