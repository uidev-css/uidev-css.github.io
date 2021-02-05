---
layout: post
title: "웹 공유 API에서"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/10/ios-shar-sheet.png
tags: WEB SHARE
---


Web Share API는 매우 멋진 것 같습니다. 간단히 말해, 플랫폼이 지원하는 경우 사용자가 어떤 플랫폼에 있든 기본 공유 기능을 활용할 수 있습니다.

맘에 들어:

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/10/IMG_DD9320F1F6C6-1.jpeg?resize=298%2C645&ssl=1)

이것보다 훨씬 더 많죠.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/10/Screen-Shot-2020-10-05-at-3.10.08-PM.png?resize=982%2C338&ssl=1)

왜요?

- Web Share API는 코드 두 줄입니다. 쉬워요! 이미지, 중량감 있는 JavaScript 또는 만약의 경우, 시대에 뒤떨어질 가능성이 없습니다(콜록, Google+).
- 사용자가 볼 수 있는 UI는 플랫폼에 맞게 사용자 지정되며 사용자가 원하는 것을 가질 수 있도록 사용자 지정될 수도 있습니다.

잘했어, 웹 표준

하지만 모든 곳에서 지원되지는 않습니다. 예를 들어, 이 블로그 게시물을 Chrome에 쓰고 있는데 데스크톱 Chrome에서는 작동하지 않습니다. 하지만 데스크탑 Safari에서는 사용할 수 있습니다!

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/10/Screen-Shot-2020-10-01-at-12.54.54-PM.png?resize=200%2C188&ssl=1)

그래서 제가 그것을 사용하려면 페이지의 버튼을 누르기 전에 지원을 테스트하는 것이 낫습니다. 매우 쉽습니다.

```js
if (navigator.share) {

}
```

다음은 API가 지원되는 경우 아티클에 `< 버튼>을 추가하는 예입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 570px;"><iframe id="cp_embed_KKzjQWO" src="//codepen.io/anon/embed/KKzjQWO?height=570&amp;theme-id=1&amp;slug-hash=KKzjQWO&amp;default-tab=js,result" height="570" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed KKzjQWO" title="CodePen Embed KKzjQWO" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

그 자바스크립트는 API에서 사용할 게시물의 제목과 첫 단락을 잡기 위해 약간의 화려한 춤을 춘다. 나는 제레미 키스가 페이지 레벨에서 하는 것을 좋아한다.

```js
if (navigator.share) {
  navigator.share(
    {
      title: document.querySelector('title').textContent,
      text: document.querySelector('meta[name="description"]').getAttribute('content'),
      url: document.querySelector('link[rel="canonical"]').getAttribute('href')
    }
  );
}
```

이 값들에 문자열도 넣을 수 있습니다. 이것은 여러분이 어떤 페이지에서도 동작하는 것을 역동적으로 하는 방법을 보여주는 것입니다.

Jeremy는 또한 JavaScript 옵션 버전의 Web Share API를 옹호하고 있으며, 다음과 같이 작동할 수 있다고 생각합니다.

```html
<button type="share">
```

그런 다음 제목과 텍스트를 지정합니다.

```html
<button type="share" value="title,text">
```

쉼표랑 같이 하니까 좀 웃겨우. 제목에 쉼표가 들어가면 어떡하지? URL을 지정하면 어떨까요? 모두 속성으로 나눌 수 있을까요? 나는 제레미가 뭐라고 말할지 알 것 같다: 이것은 단순한 선언적 버전이다. 기본 동작을 변경하려면 JavaScript를 사용해야 합니다.

그런데 브라우저가 지원하지 않으면 아예 있어야 하는 건가요? 물론입니다, 만약 당신이 그것을 다 채워준다면:

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_rNerbPE" src="//codepen.io/anon/embed/rNerbPE?height=450&amp;theme-id=1&amp;slug-hash=rNerbPE&amp;default-tab=js,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed rNerbPE" title="CodePen Embed rNerbPE" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이 폴리필은 지원되지 않을 경우 버튼을 `mail to:` 환경으로 전환합니다. 꽤 영리하군요. 제가 프로덕션에 속했다면 기능이 제대로 지원되었을 때만 버튼을 눌러야 할 것 같습니다.