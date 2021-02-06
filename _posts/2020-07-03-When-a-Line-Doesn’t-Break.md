---
layout: post
title: "선이 끊어지지 않을 때"
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/07/line-breaks.png"
tags: 
---


해당 줄의 텍스트가 상위 상자 경계에 도달하면 줄이 끊어질 것으로 예상됩니다. 우리는 단락을 만들 때마다 이것을 봅니다. 이것처럼요. 상위 상자에 줄의 다음 단어를 저장할 공간이 충분하지 않으면 해당 단어가 깨지고 다음 줄로 이동하여 해당 과정을 반복합니다.

단어들이 공백이나 다른 공백으로 분리될 때 그렇게 작용합니다. CSS에 관한 한, 선이 끊어지는 방법과 시기에 영향을 줄 수 있는 다섯 가지 (!) 속성이 있다. 하지만 다시는 그 모든 것에 관여하지 맙시다. 대신 줄이 끊어질 것 같지만 줄이 끊어지는 것에 대해 조금이나마 배울 수 있는 핑계가 되지 않는 상황을 보자.

브라우저가 중단해도 괜찮은 시기를 알 수 없는 상황에서는 어떻게 됩니까?

우리 스스로를 "태그 리스트"로 나쁜 상황에 빠지게 하고 거기서 벗어나자. 다음은 마크업입니다.

```html
<ul>
  <li>PHP</li>
  <li>JavaScript</li>
  <li>Rust</li>
  <!-- etc. -->
</ul>
```

다음으로, 목록 항목이 인라인으로 표시되도록 하여 기본 목록 스타일을 기본 수직 방향에서 수평 방향으로 덮어쓰는 CSS를 적용할 것입니다.

```css
ul {
  margin: 0;
  padding: 0;
  list-style: none;
}
 
li {
  display: inline;
  padding-right: 5px;
} 

```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_XWXRoWe" src="//codepen.io/anon/embed/XWXRoWe?height=250&amp;theme-id=1&amp;slug-hash=XWXRoWe&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed XWXRoWe" title="CodePen Embed XWXRoWe" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

그 목록은 우리가 원하는 것처럼 보인다. 리스트 아이템과 아이템 사이에 공간을 조금 추가해서 너무 붐비지 않는 것 같아요.

이제 혼합물에 포장재를 도입해 보겠습니다. 그것은 본질적으로 순서 없는 목록에 대한 div입니다. `.tags`라고 하는 수업을 할 수 있습니다.

```html
<div class="tags">
  <ul>
    <li>PHP</li>
    <li>JavaScript</li>
    <li>Rust</li>
  </ul>
</div> 
 

```

포장지에 200px의 고정 폭을 주고 싶다고 가정해 봅시다. 거기서 우리는 주문되지 않은 리스트가 포장지의 경계에 부딪히면서 줄 바꿈이 일어나는 것을 예상해야 한다.

```html
.tags {
  width: 200px;
}
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 350px;"><iframe id="cp_embed_jOWmXEr" src="//codepen.io/anon/embed/jOWmXEr?height=350&amp;theme-id=1&amp;slug-hash=jOWmXEr&amp;default-tab=result" height="350" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed jOWmXEr" title="CodePen Embed jOWmXEr" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

여기 흥미로운 부분이 있습니다. 많은 사람들이 불필요한 값을 제거하여 파일 크기를 줄이기 위해 빌드 프로세스에서 미니어를 사용합니다. 이러한 값 중 일부는 공백, 탭 및 줄 바꿈 문자(예: 캐리지 리턴 및 줄 바꿈)를 포함하지만 최종 결과와 무관하다고 간주하는 공백, 줄 바꿈 문자입니다.

새 줄을 제거하여 HTML을 "최소화"하면 다음과 같은 이점이 있습니다.

```html
<div class="tags"><ul><li>PHP</li><li>JavaScript</li><li>Rust</li></ul></div>
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_VwebqYV" src="//codepen.io/anon/embed/VwebqYV?height=450&amp;theme-id=1&amp;slug-hash=VwebqYV&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed VwebqYV" title="CodePen Embed VwebqYV" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

아, 보시다시피 리스트가 200px 경계선에서는 깨지지 않습니다. 왜죠? 지금 무엇이 달라졌는가? 개인적으로 나는 HTML이 백색 공간에 대해 신경쓰지 않는다고 생각했다. 기존 마크업과 미니어처 버전은 무엇이 그렇게 다른가요?

브라우저는 실제로 백색 공간에 대해 신경을 쓰지만 때로는 그러하기도 합니다. 그리고 이것이 바로 그러한 사례들 중 하나입니다. 페이지를 구문 분석할 때, 구문 분석가는 이 목록을 하나의 긴 단어로 봅니다. 왜냐하면, 그 관점에서는, 한 단어를 다른 단어와 구별하는 문자가 없기 때문입니다.

패딩을 입는 것이 사물에 영향을 미친다고 생각할 수 있다. 그러나 목록 항목에서 패딩을 제거해도 동일한 결과를 얻을 수 있습니다. 항목 간 간격은 없습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_OJMmrVL" src="//codepen.io/anon/embed/OJMmrVL?height=450&amp;theme-id=1&amp;slug-hash=OJMmrVL&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed OJMmrVL" title="CodePen Embed OJMmrVL" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

브라우저는 전체 목록을 하나의 단어로 봅니다.

### 우리는 특수 캐릭터로부터 자연스러운 줄 바꿈을 얻을 수 있다.

공백 외에 깨지지 않는 공간(`) 제외)

- 하이픈 후(`-`)
- 종료 후(`-`)
- Em dash 전후(`—`)
- 물음표 이후(`?`?)
- 0 폭의 백색 공간(`U+200B` 또는 `)

이러한 줄 바꿈은 렌더링 시 발생하므로 브라우저는 여전히 이 줄을 하나의 긴 단어로 봅니다. 이러한 문자가 포함된 새 목록 항목을 태그 목록에 추가하면 줄이 끊어집니다. "Objective-C"를 목록에 추가하겠습니다. 이름에는 하이픈이 포함되어 있으며, 하이픈이 어떤 영향을 미치는지 확인할 수 있습니다.

더 나은 가독성을 위해 코드 코드는 들여쓰기 및 새 줄을 갖습니다.

```html
<div class="tags">
  <ul>
    <li>PHP</li>
    <li>JavaScript</li>
    <li>Rust</li>
    <li>Objective-C</li>
  </ul>
</div> 

```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_yLebGNg" src="//codepen.io/anon/embed/yLebGNg?height=450&amp;theme-id=1&amp;slug-hash=yLebGNg&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed yLebGNg" title="CodePen Embed yLebGNg" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

잘 됐네요. 이 선들을 따라 우리의 비회선 목록에 대한 세 가지 해결책을 살펴봅시다.

우리는 방금 했던 것처럼 깨지는 캐릭터들로 계속해서 줄 바꿈을 강요할 수 있다. 그러나 미니어를 사용하는 경우 닫힘 태그의 내부 또는 뒤에 공백을 추가하면 모든 미니어가 동일한 방식으로 작동하는 것은 아니기 때문에 제거되지 않습니다.

```html
<div class="tags">
  <ul>
    <li>PHP </li>
    <li>JavaScript </li>
    <li>Rust </li>
    <li>Objective-C </li>
  </ul>
</div>
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 650px;"><iframe id="cp_embed_ExPmGjo" src="//codepen.io/anon/embed/ExPmGjo?height=650&amp;theme-id=1&amp;slug-hash=ExPmGjo&amp;default-tab=result" height="650" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed ExPmGjo" title="CodePen Embed ExPmGjo" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

CSS의 `::before` 및 `::fter` 의사 요소를 사용하여 중단 문자를 추가할 수도 있습니다. 이 솔루션을 효과적으로 만드는 것은 CSS가 적용될 때 공백이 추가되기 때문에 HTML 미니어처의 영향을 받지 않는다는 것입니다.

하지만, 다음 단계로 넘어가기 전에, 하얀 공간을 무너트리는 것에 대해 잠시 이야기 해 봅시다.

브라우저는 인라인 요소 내에서 선을 강제로 끊는 문자 앞뒤의 공백을 축소합니다. 이를 염두에 두고 백스페이스와 디스플레이 인라인 블록이 있는 컨텐츠 속성과::after를 사용하는 약간의 트릭이 있다. 인라인 블록 요소는 텍스트 끝에 중단 문자를 추가합니다. 그런 다음 컨텐츠 속성 공간은 인라인 블록 요소에 의해 생성된 중단 문자 뒤에 오며, 이로 인해 렌더링 시 공간이 제거됩니다. 즉, 화이트 스페이스 속성이 사전 설정으로 설정되지 않은 경우입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_Vwebqvq" src="//codepen.io/anon/embed/Vwebqvq?height=450&amp;theme-id=1&amp;slug-hash=Vwebqvq&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed Vwebqvq" title="CodePen Embed Vwebqvq" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

솔루션 3: 대신 인라인 블록 사용

아마도 당신은 전에 CSS에서 인라인 블록 요소들 사이의 공간과의 싸움에 부딪힌 적이 있을 것이다. 인라인 블록 요소에 필요한 추가 공간이 있기 때문에 표시 속성의 인라인 블록 값을 사용하여 선을 강제로 끊을 수 있습니다. 이것은 0 폭의 공백 문자를 추가하는 것과 비슷하지만 목록 항목에는 시각적 분리가 없습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 550px;"><iframe id="cp_embed_OJMmrMJ" src="//codepen.io/anon/embed/OJMmrMJ?height=550&amp;theme-id=1&amp;slug-hash=OJMmrMJ&amp;default-tab=result" height="550" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed OJMmrMJ" title="CodePen Embed OJMmrMJ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

솔루션 4: Flex 또는 인라인 유연성 사용

또 다른 해결책은 순서 없는 목록을 플렉스 컨테이너로 정의하여 목록의 방향을 설정하고 필요할 때 여러 줄로 확인할 수 있도록 하는 것이다.

우리는 또한 "인라인 블록" 솔루션 대신 "인라인 플렉스"로 눈을 돌릴 수 있다. 여기서 발상은 전체 유연한 컨테이너가 인라인으로 표시된다는 것입니다.

그래서 우리는 미니어처를 사용할 때 나타날 수 있는 상황을 가지고 이 글을 시작했습니다. 그렇긴 하지만, 미니어처와 그 문제에 대한 많은 라이브러리들은 똑똑하고, 이러한 줄 바꿈 문제가 발생하지 않도록 노력할 것이다.

물론, 그것은 마주치기 아주 흔한 상황은 아닙니다. 만약 우리가 주의를 기울이지 않는다면, 그것은 정말로 레이더 밑으로 날아갈 수 있는 것들 중 하나입니다. 하지만 만약 그런 일이 일어난다면, 적어도 우리는 그것을 다룰 수 있는 방법이 있다는 것을 압니다.