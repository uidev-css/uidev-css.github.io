---
layout: post
title: "텍스트 기울임꼴로 만드는 방법"
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/07/italic.png"
tags: EMPHASIS,ITALIC
---


HTML과 CSS는 우리에게 텍스트를 기울임꼴로 만드는 기능을 제공한다. 저는 이런 문자를 말하는 거예요. 당신이 알아야 할 모든 것을 다루자.

### 기울임꼴 텍스트란 무엇이며, 텍스트를 기울임꼴로 만드는 이유는 무엇입니까?

텍스트를 기울이기 위해 가장 자주 이탤릭체로 표시합니다. 글자 그대로 단어를 강조하기 위해서, 문장을 읽는 누군가가 여러분이 작가로서 의도하는 것처럼 그 단어나 구절에게 특별한 의미를 부여하도록 하기 위해서입니다. 또는, 그것은 어떤 것의 제목을 이탤릭체로 바꾸는 것과 같은 특정한 스타일 가이드를 따르는 것일 수도 있다, 라고 출판된 기사는 말한다.

### '<' 태그 사용

`em`의 `그들`은 글자 그대로 강조를 의미한다. 브라우저는 기본적으로 HTML `em` 태그로 포장된 텍스트를 기울임꼴로 만듭니다.

```html
<p>
  That was a <em>wonderful</em> party, Bebe.
</p>
```

그 문장의 소리를 상상해보세요. 독자가 그 단어를 강조하면서 문장을 다르게 느낄 수 있도록 말이죠.

### 'i' 태그 사용

`i`의 요소는 강조하지 않고 텍스트에 이탤릭체를 적용하는 것이다. 그것은 독자가 그 단어에 추가적인 무게를 가하고 있다는 것을 암시하지 않고 다른 텍스트와 시각적으로 다른 텍스트를 설정하기 위한 것이다. 아마도 다음과 같은 경우일 것이다.

```html
<p><i>Miranda thought:</i> What an interesting metaphor on the global economy.</p>
<p><i>Chris thought:</i> Is that mustard?</p>
```

### 'i'와 'em'의 차이점은 무엇입니까?

한 번 더:

- 강조하기 위한 것이다.
- <i>는 이탤릭체용이다.

만약 당신이 어떤 것의 제목에 `i`를 사용하고 싶다면, 다음과 같은 것.

```html
<p>
  The book 
  <!-- Not the end of the world, but... --> 
  <i>Mr. Penumbra's 24-Hour Bookstore</i>
  is good.
</p>

<p>
  The book 
  <!-- ...this is more semantically correct. --> 
  <cite>Mr. Penumbra's 24-Hour Bookstore</cite>
  is good.
</p>
```

다행히도 브라우저는 `i`와 마찬가지로 `cite` 태그로 포장된 콘텐츠를 이탤릭체로 만들기 때문에 작품(예: Moby Dick)이나 출판물(예: 출판물)을 인용하는 경우에는 더 이상의 작업이 필요하지 않다. 뉴욕 타임즈.

### 사용자 자신의 HTML 클래스 및 CSS 사용

본문을 시각적으로 구분하는 것이 목표라면, 우리는 `i` 요소에 도달할 필요가 없다. 스팬은 의미적 의미가 없으며 시각적 강조를 위해 스타일링할 수 있다.

```html
<p>
  Shoes are <span class="emphasis">on sale</span> this week!
</p>
```

```css
.emphasis {
  background: lightyellow;
  font-style: italic;
}
```

CSS 속성 `font-style`은 텍스트를 기울임꼴로 만드는 데 필요한 속성으로, 원하는 선택기에 적용할 수 있습니다.

### "Faux Italic"을 조심하세요.

일부 글꼴에 기울임꼴 문자가 있는 것은 아닙니다. 또는 글꼴의 기울임꼴 버전이 로드되지 않은 경우일 수 있습니다. 어느 경우든 브라우저는 거의 항상 끔찍해 보이는 (또는 적어도 실제 기울임꼴을 사용하는 것보다 훨씬 더 나쁜) 가짜를 시도한다.

이것에 대해 아무것도 당신에게 경고하지 않을 것이다. 당신은 단지 그것에 대한 안목이 필요할 뿐이다. 다음은 Merriweather의 faux Italic입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 350px;"><iframe id="cp_embed_NWxWoJV" src="//codepen.io/anon/embed/NWxWoJV?height=350&amp;theme-id=1&amp;slug-hash=NWxWoJV&amp;default-tab=result" height="350" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed NWxWoJV" title="CodePen Embed NWxWoJV" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 유니코드 이탤릭체

유니코드에서 사용할 수 있는 문자는 이탤릭체 느낌을 가진 문자를 포함하여 수십억 개입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 350px;"><iframe id="cp_embed_WNrXWKB" src="//codepen.io/anon/embed/WNrXWKB?height=350&amp;theme-id=1&amp;slug-hash=WNrXWKB&amp;default-tab=html,result" height="350" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed WNrXWKB" title="CodePen Embed WNrXWKB" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

트윗을 작성할 때 트위터에서 기울임꼴과 같은 작업을 수행하기 위해 HTML 컨트롤이 없을 때 이 기능을 사용할 수 있습니다.

이것의 접근성은 끔찍하다. 그것은 각각의 캐릭터에게 개별적으로 도달하여, 그 단어를 이해하기 어렵게 만들 것입니다. 이것을 다 사용해도 매우 조심해서 사용하세요.

### 가변 글꼴의 기울임꼴

이것은 약간 발전된 개념이지만, 가변 글꼴이라고 불리는 것들이 있습니다. 브라우저에서는 바로 사용자 지정 기능을 제공합니다. 굵은 글꼴의 두 번째 파일이 아니라 하나의 파일로 굵게 표시할 수 있는 정보가 들어 있습니다. 그러나 "bold"는 가변 글꼴이 제공하는 예일 뿐입니다. 그들 모두가 꼭 그렇지는 않다.

가변 글꼴에는 "기울기" 또는 "이탈기" 옵션이 있을 수 있으며 이러한 모양을 적용할 수 있습니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/07/Screen-Shot-2020-07-12-at-4.34.56-PM.png?resize=1024%2C421&ssl=1)

이탤릭체를 언제 이탤릭체로 쓸 것인가 하는 문제에 대한 다섯 가지 다른 대답이 있습니다. 다음 논리적인 질문에도 도움이 되었으면 합니다. 어떤 방법을 사용해야 합니까?