---
layout: post
title: "CSS의 ARIA
 "
author: 'CSS Dev'
thumbnail: undefined
tags: ARIA
---


Jeremey는 적용중인 스타일이 ARIA 상태와 직접 관련이있을 때 클래스 대신`[aria-*]`선택기를 사용하는 것에 대해 Sara의 트윗에 반응합니다.
 

> … 이것이 제가 선호하는 CSS 및 JavaScript 상호 작용 연결 방법입니다.
 다음은 작동중인 것을 볼 수있는 오래된 CodePen입니다.
 

이 고전적인 대결은 무엇입니까?
 

```css
[aria-hidden='true'] {
  display: none;
}
```

더 많은 기회가 있습니다.
 탭 디자인 구성 요소를 가져옵니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_gOMPWgJ" src="//codepen.io/anon/embed/gOMPWgJ?height=450&amp;theme-id=1&amp;slug-hash=gOMPWgJ&amp;default-tab=css,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed gOMPWgJ" title="CodePen Embed gOMPWgJ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이러한 탭 (Reach UI 사용)은 이미 활성화 된 탭과 같은 항목에 대해 적절한 ARIA 상태를 적용하고 있으므로 클래스 이름 조작에 신경 쓰지 않습니다.
 활성 상태의 스타일을 지정하려면 다음과 같은 데이터 속성 및 ARIA 상태로`<button>`을 선택합니다.
 

```css
[data-reach-tab][aria-selected="true"] {
  background: white;
}
```

내용이있는 패널?
 ARIA 역할이 있으므로 다음과 같이 스타일이 지정됩니다.
 

```css
[role="tabpanel"] {
  background: white;
}
```

ARIA는 때때로 다음과 같은 변형과 일치합니다.
 

```html
[aria-orientation="vertical"] {
  flex-direction: column;
}
```

만약 그렇다면, ARIA는 무엇입니까?
 Heydon의 새 프로그램 Webbed Briefs는 ARIA를 파일럿 에피소드로 재미있게 소개합니다.
 