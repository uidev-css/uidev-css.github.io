---
layout: post
title: "시맨틱 HTML로 복사 편집
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/11/browser-copy-edit.png
tags: COPYWRITING,SEMANTICS
---


변경 내용 추적은 콘텐츠 버전을 비교하기위한 전형적인 복사 편집 기능입니다.
 워드 프로세싱 문서의 변경 사항을 추적하는 데 익숙하지만 실제로는이를 수행 할 수있는 HTML 요소가 있습니다.
 이 프로세스에 사용할 수있는 많은 요소가 있습니다.
 우리가 살펴볼 주요 항목은`<del>`,`<ins>`및`<mark>`입니다.
 그러나 앞으로 살펴 보 겠지만`<u>`,`<aside>`및 사용자 지정 마크 업을 비롯한 다른 요소와 쌍을 이루면 Word, Google Docs 또는
 심지어 WordPress.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/11/track-changes-pages-docs-wordpress.png?resize=2174%2C1270&ssl=1)

`<ins>`요소부터 시작하겠습니다.
 

`<ins>`는 삽입되어야하거나 삽입 된 텍스트를 지정합니다.
 `<ins>`태그가 편집을 제안하는 동안`<ins>`태그에 이미 삽입되어 있어야하기 때문에 동사 시제가 약간 불안정 해집니다.
 마치“이봐, 이미 기술적으로있는 이걸 넣어 라”고 말하는 것과 비슷합니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_mdEjemm" src="//codepen.io/anon/embed/mdEjemm?height=250&amp;theme-id=1&amp;slug-hash=mdEjemm&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed mdEjemm" title="CodePen Embed mdEjemm" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

브라우저가 삽입 된 텍스트에 어떻게 밑줄을 긋는 지 확인하십시오.
 `<u>`요소, 링크 또는 CSS`text-decoration` 속성을 사용하여 밑줄로 착각 할 수 있더라도 이러한 종류의 시각적 표시가 있으면 좋습니다.
 

삽입을`<del>`요소와 함께 사용하여 삭제해야하거나 삭제해야하는 텍스트를 제안합니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_OJXwyOz" src="//codepen.io/anon/embed/OJXwyOz?height=250&amp;theme-id=1&amp;slug-hash=OJXwyOz&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed OJXwyOz" title="CodePen Embed OJXwyOz" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

브라우저는 취소 선 (`<s>`) 요소처럼`<del>`스타일을 지정하지만 의미는 다릅니다.
 `<del>`은 삭제 / 편집해야하는 콘텐츠 (위의 소름 끼치는 섹션처럼)를위한 것이고`<s>`는 더 이상 사실이거나 부정확하지 않은 콘텐츠를위한 것입니다 (예 : 해당 섹션이 사랑 스러울 것이라는 편지 작성자의 믿음
 ).
 

좋습니다. 그래서 우리는 이러한 시맨틱 HTML 요소를 가지고 있으며 삽입되거나 삭제 된 콘텐츠에 대한 가벼운 시각적 표시기를 생성합니다.
 하지만 이러한 요소에 대해 알지 못하는 점이 있습니다. 변경 사항에 주석을 달 수있는 `cite`속성을 허용합니다.
 

`cite`는 변경 이유를 찾을 수있는 지점을 제공하는 올바른 형식의 URL을 사용합니다.
 어딘가는 기존 페이지의 앵커가 될 수도 있습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_WNxKQJg" src="//codepen.io/anon/embed/WNxKQJg?height=450&amp;theme-id=1&amp;slug-hash=WNxKQJg&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed WNxKQJg" title="CodePen Embed WNxKQJg" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

멋지지만 한 가지 문제는 인용 URL이 실제로 표시되거나 클릭 할 수 없다는 것입니다.
 CSS 마법을 사용하여 표시 할 수 있습니다.
 하지만 클릭해도 인용으로 이동하지 않으며 복사 할 수도 없습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_BazPovV" src="//codepen.io/anon/embed/BazPovV?height=450&amp;theme-id=1&amp;slug-hash=BazPovV&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed BazPovV" title="CodePen Embed BazPovV" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

즉, 편집의 일부와 그렇지 않은 부분을 의미 론적으로 명확하게합니다.
 `<ins>`와`<del>`을 링크 (또는 그 반대)로 감싸면 링크가 편집 된 콘텐츠의 일부인지 여부는 여전히 명확하지 않습니다.
 

그러나!
 `<ins>`와`<del>`이 모두 공유하는 두 번째 속성 인`datetime`이 있습니다.
 그리고 이것이 언제 편집이 이루어 졌는지 알 수있는 방법입니다.
 다시 말하지만, 이것은 사용자가 즉시 사용할 수는 없지만 편집의 일부와 그렇지 않은 부분을 의미 상으로 명확하게 유지합니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_yLJqYwd" src="//codepen.io/anon/embed/yLJqYwd?height=450&amp;theme-id=1&amp;slug-hash=yLJqYwd&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed yLJqYwd" title="CodePen Embed yLJqYwd" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

HTML의 `날짜 시간`형식은 컴퓨터에서 읽을 수있는 날짜 및 시간으로서 정밀도가 필요하므로 약간, 음, 까다로울 수 있지만 일반적인 테넌트는 그리 어렵지 않습니다.
 그러나`datetime`은`<time>`과 같은 다른 요소에 사용되는 반면`<ins>에 특정 일, 월, 연도를 포함하지 않는 방식으로 값의 형식을 지정합니다.
 `및`<del>`은 명확성을 제공하기보다는 편집 날짜와 시간을 가리는 문제가 될 수 있습니다.
 

CSS 마법을 조금 더 사용하면 더 명확하게 할 수 있습니다.
 예를 들어, 마우스 오버시 `datetime`값을 표시 할 수 있습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_JjKBGjE" src="//codepen.io/anon/embed/JjKBGjE?height=450&amp;theme-id=1&amp;slug-hash=JjKBGjE&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed JjKBGjE" title="CodePen Embed JjKBGjE" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

체크 박스도 작동합니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_mdEjVyx" src="//codepen.io/anon/embed/mdEjVyx?height=450&amp;theme-id=1&amp;slug-hash=mdEjVyx&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed mdEjVyx" title="CodePen Embed mdEjVyx" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

그러나 좋은 편집은 단순히 콘텐츠를 추가하고 삭제하는 것 이상입니다.
 질문을하고 저자가 의도 한 것이 무엇인지 파악하는 것입니다.
 (개인적으로는 당황스러운 철자법과 문법 오류로부터 저를 구하는 것이기도합니다.)
 

그래서`<mark>`요소를 만나보세요.
 

`<mark>`는 독자에게 특별한 관심이있는 텍스트를 가리 킵니다.
 일반적으로 콘텐츠 뒤에 노란색 배경으로 렌더링됩니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 525px;"><iframe id="cp_embed_jOrpQrz" src="//codepen.io/anon/embed/jOrpQrz?height=525&amp;theme-id=1&amp;slug-hash=jOrpQrz&amp;default-tab=result" height="525" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed jOrpQrz" title="CodePen Embed jOrpQrz" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

당신이 편집자이고 Stanly의 편지를 더 멋지게 (또는 최소한 덜 오싹하게 만드는) 제안과 함께 작가에게 메모를 작성하고 싶다면
 콘텐츠 (예 : 블록 레벨 요소), 메모는`<aside>`요소가 될 수 있습니다.
 

```html
<aside class="note">Mr. Meagher, I highly recommend you remove this list of preferred cheeses and replace it with things you love about the woman you are writing to. While I'm sure there are many people for whom your list would be interesting if not welcome, that list rarely includes a romantic interest in the midst of your profession of love. Though, honestly, if she is as perfect for you as you believe, it may be the exact thing you need to test that theory.</aside>
```

하지만 종종 문장 구조 나 단어 선택에 대해 지적하거나 의견을 제시하기 위해 인라인으로 무언가를하고 싶을 것입니다.
 안타깝게도 HTML에서 그렇게 할 수있는 방법은 없지만 약간의 독창성과 약간의 CSS 만 있으면 메모를 추가 할 수 있습니다.
 

```html
<span class="note">Cheesecake isn't really a "cheese"</span>
```

`<u>`요소 (링크와의 혼동을 두려워하여 웹 개발자에게 오랫동안 혐오감을 불러 일으키는 요소)는 실제로 유용합니다 (저도 알고 있습니다).
 맞춤법 오류를 지적하는 데 사용할 수 있습니다 (분명히 구불 구불 한 빨간색 밑줄은 표준 브라우저 렌더링 기능이 아님).
 실제 링크와 혼동 될 수있는 곳에서는 여전히 사용해서는 안되며, 사용시 반드시 링크와 구별되는 색상을 사용해야합니다.
 오류를 나타내는 데 빨간색이 적절할 수 있습니다.
 

```html
<p>Please, <u>Lura</u> tell me your answer. Will you wear my mathlete letter jacket?</p>
```

이 기사 전체에서 살펴본 것처럼 지금까지 살펴본 요소에 대한 브라우저의 기본 스타일은 확실히 도움이되지만 다른 유형의 콘텐츠와 거의 구별되지 않기 때문에 혼란 스러울 수도 있습니다.
 사용자가 문서가 편집 내용을 표시하고 있음을 모르는 경우 스타일이 사용자에 의해 오해되거나 오해 될 수 있습니다.
 따라서 무슨 일이 일어나고 있는지 명확히하는 데 도움이되는 몇 가지 추가 또는 대체 스타일을 제안합니다.
 

```css
ins {
  padding: 0 0.125em;
  text-decoration: none;
  background-color: lightgreen
}
del {
  padding: 0 0.125em;
  text-decoration: none;
  background-color: pink;
}
mark {
  padding: 0 0.125em;
}
.note {
  padding: 0 0.125em;
  background-color: lightblue;
}
aside.note {
  padding: 0.5em 1em;
}
u {
  text-decoration: none;
  border-bottom: 3px red dashed;
}
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 650px;"><iframe id="cp_embed_Bazxmox" src="//codepen.io/anon/embed/Bazxmox?height=650&amp;theme-id=1&amp;slug-hash=Bazxmox&amp;default-tab=result" height="650" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed Bazxmox" title="CodePen Embed Bazxmox" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

HTML에서 새로운 것을 배울 때마다 같은 질문을합니다. 어떻게 불필요하게 애니메이션을 적용 할 수 있습니까?
 

확인란을 클릭했을 때 편집 내용도 페이드 인되도록 변경 사항을 페이드 업할 수 있다면 좋을 것입니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_XWKqPPZ" src="//codepen.io/anon/embed/XWKqPPZ?height=450&amp;theme-id=1&amp;slug-hash=XWKqPPZ&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed XWKqPPZ" title="CodePen Embed XWKqPPZ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

`<del>`태그의 메모와 텍스트는 배경색 및 패딩과 같은 방식으로 CSS로 페이드 인 할 수 없습니다.
 또한 display : none을 사용하면 페이드가 전혀 발생하지 않습니다.
 배경을 포함하여 모든 것이 제자리로 돌아옵니다.
 그러나 CSS`visibility` 속성을`height` 및`width` 값 0으로 설정하면 배경이 부드럽게 페이드 인됩니다.
 

그리고 거기에 당신은 그것을 가지고 있습니다 : 웹에서 편집을 추적하기위한 사양과 몇 가지 전략 (그리고 연애 편지를 쓰지 않는 방법에 대한 훌륭한 예 (또는 아마도 하나를 너무 완벽하게 작성하여 그것에 긍정적 인 반응을하는 방법)
 당신이 영혼의 동반자라는 서명).
 

편집 : Adrian Roselli는 주석에 몇 가지 뛰어난 접근성 정보를 추가합니다.
 프로덕션에서 이러한 아이디어를 구현하기 전에 이러한 제안을 고려해야합니다.
 