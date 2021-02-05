---
layout: post
title: "CSS 사용자 지정 속성에 @ 속성 사용"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/08/at-property.png
tags: @PROPERTY,CUSTOM PROPERTIES
---


Una Kravetz는 이제 Chrome이 단순히 문자열이 아닌 더 많은 정보를 가지고 CSS로부터 CSS 사용자 지정 속성을 직접 선언할 수 있게 하는 방법을 파헤친다.

그래서 이런 것 보다는:

```css
html {
  --stop: 50%;
}
```

…은 다음과 같은 세부 정보와 함께 선언할 수 있습니다.

```css
@property --stop {
  syntax: "<percentage>";
  initial-value: 50%;
  inherits: false;
}
```

그러면 브라우저는 이 특정 사용자 지정 속성이 문자열이 아닌 백분율임을 알게 됩니다. 또 다른 유용한 물건인 <정수><정수>와 <색채>와 같은. 이제 이런 종류의 정보를 브라우저에 전달하는 방법이 생겼기 때문에, 우리는 두 가지 가치 사이에서 전환할 수 있는 것과 같은 새로운 능력을 얻게 되었습니다.

장난을 치면서, 나는 당신이 (전속적인 `전환`은 그것을 할 수 없기 때문에) 아주 구체적으로 그 부동산 이전을 불러야 한다는 것을 알았다. UNA가 게시물에서 수행한 작업을 재현한 이 데모에서 잠시 기다려 보십시오.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_YzqQqNY" src="//codepen.io/anon/embed/YzqQqNY?height=450&amp;theme-id=1&amp;slug-hash=YzqQqNY&amp;default-tab=css,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed YzqQqNY" title="CodePen Embed YzqQqNY" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

컬러 스톱의 위치(백분율)를 애니메이션하고 있지만, 컬러도 애니메이션을 시도하고 있지만 여전히 작동하지 않습니다. 나는 이 새로운 특징과 함께 할 것이라고 생각했다. 나는 사람들이 오랫동안 그레이디언트를 애니메이션화할 수 없다는 것에 대해 혼란스러워했다는 것을 안다. (Ana Tudor의 기사를 참조하십시오.)

사용자 지정 속성을 읽을 수 없는 브라우저를 "지원"하기 위해 상위 레벨 위치에 있는 속성을 언제든지 다시 선언할 수 있습니다. 그 얘기를 하니까 좀 웃긴 것 같아. 사파리는 Houdini에 기반을 둔 이 제품에 대한 강한 관심을 나타내는 듯 보이지만, 아직까지는 그렇지 않습니다. 파이어폭스? 아이시, 나도 몰라. 우리가 가장 잘 아는 것은 그들이 해고되기 전에 그것을 "Worth Prototifing"이라고 불렀다는 것이다.

이는 뉴스레터에서 언급한 CSS 사용자 지정 속성의 이상한 예비 문제에도 도움이 될 것입니다.

> 다른 사용자 지정 속성과 마찬가지로 var를 사용하거나 값을 설정(쓰기/다시 쓰기)할 수 있지만 Houdini 사용자 지정 속성의 경우 재정의할 때 잘못된 값을 설정하면 CSS 렌더링 엔진이 라인을 무시하는 대신 초기 값(폴백 값)을 보냅니다.