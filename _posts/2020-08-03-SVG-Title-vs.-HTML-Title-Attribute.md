---
layout: post
title: "SVG 타이틀 vs. HTML 제목 속성"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/07/title-attribute.jpg
tags: ACCESSIBILITY,ICONS,SVG,TITLE
---


제목 속성을 아세요? 할 수 있습니다.

```html
<div title="The Title">
  I'm a div with a `title`
</div>
```

이제 마우스 포인터가 있는 장치에 커서를 놓으면...

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/07/title-on-div.png?resize=349%2C228&ssl=1)

어, 어, 뭐 그런 것 같아요. 저는 때때로 그것을 속기를 사용하는 요소에 확대된 날짜나 시간을 붙이는 것과 같은 용도로 사용합니다. 이것은 시각적인 마우스 사용자만을 위한 UX의 작은 도움입니다.

하지만 제가 이해한 바로는 그다지 유용하지 않습니다. 이레 아데리노쿤이 abbr 요소(일반적으로 인용되는 예)에 어떻게 사용되는지를 파헤친 결과 혼자서는 그리 대단하지 않다는 것을 알게 되었다. 그녀는 JavaScript를 강화한 패턴을 제안합니다. 그녀는 또한 JAWS에 타이틀 발표 설정이 포함되어 있다고 언급했는데, 그것은 흥미롭습니다(기본적으로 해제된 것처럼 들리지만).

솔직히 제목이 화면 독자들에게 얼마나 유용한지는 모르겠지만 분명 미묘한 차이가 있을 것이다.

제목에 대해 배운 것이 있습니다만, 이 방법은 효과가 없습니다.

```svg
<!-- Incorrect usage -->
<svg title="Checkout">
</svg>
```

해당 요소 위에 마우스를 놓으면 제목 표시가 나타나지 않습니다. 이렇게 해야 합니다.

```svg
<!-- Correct usage -->
<svg>
  <title id="unique-id">Checkout</title>
  
  <!-- More detail -->
  <desc>A shopping cart icon with baguettes and broccoli in the cart.</desc>
</svg>
```

흥미롭게도, 파이어폭스 79는 이제 막 지원을 시작했습니다.

이와 같은 제목을 사용할 때 제목 팝업을 나타내는 호버 가능 영역은 `<svg>의 전체 직사각형입니다.

투명 픽셀이 있는 곳이 아니라 SVG의 `채워진` 픽셀 위를 맴돌 때만 제목 팝업창이 뜨는 듯한 상황에 처한 사람으로부터 흥미로운 이메일을 받았기 때문에 이 모든 것을 보고 있었다. 이상하다, 나는 생각했다. 시험에서도 복제를 못 했어요.

알고 보니 이런 상황이 있었다. `사용` 요소 내에서 `<제목>을 적용할 수 있으며, `사용`을 통해 들어오는 픽셀에만 제목이 적용됩니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_qBbvrzN" src="//codepen.io/anon/embed/qBbvrzN?height=450&amp;theme-id=1&amp;slug-hash=qBbvrzN&amp;default-tab=html,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed qBbvrzN" title="CodePen Embed qBbvrzN" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

흰색 부분을 제거하면 "검은색 부분"이 검은색 픽셀 위에만 나타납니다. 브라우저 전체에서 일관성이 있는 것 같습니다. 만약 그런 식으로 제목을 적용한다면 조심해야 할 것 같아요.