---
layout: post
title: "페이지별 메뉴 표시애니메이션 회전"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/08/menu-reveal-swing-open-1.png
tags: CHECKBOX HACK,MENU,NAVIGATION
---


웹 사이트의 메뉴에는 다양한 접근 방식이 있습니다. 일부 메뉴는 영구적이며 항상 모든 옵션을 보고 표시합니다. 다른 메뉴는 설계에 의해 숨겨져 있으므로 선택사항을 보려면 열어야 합니다. 그리고 숨겨진 메뉴가 메뉴 항목을 어떻게 드러내는지에 대한 추가적인 접근법도 있다. 어떤 것은 날아가서 내용이 겹치고, 어떤 것은 내용을 밀어내고, 어떤 것은 전체 화면 거래를 할 것이다.

어떤 방식으로 접근하든, 그들은 모두 장단점을 가지고 있고, 올바른 방법은 그것이 사용되는 상황에 달려 있다. 솔직히, 저는 일반적으로 플라이아웃 메뉴를 좋아하는 편입니다. 물론 모든 경우에 해당되는 것은 아닙니다. 그런데 부동산에 인색하고 접근하기 쉬운 메뉴를 찾다가 보면 이기기 어렵다.

내가 그들을 좋아하지 않는 것은 그들이 페이지 내용과 얼마나 자주 충돌하느냐이다. 플라이아웃 메뉴는 기껏해야 콘텐츠를 흐리게 하고 최악의 경우 UI에서 완전히 제거합니다.

나는 다른 방법을 시도했다. 고정된 위치의 지속성과 가용성은 물론, 페이지의 현재 내용에서 사용자를 제거하지 않고 날아가는 숨겨진 메뉴의 공간 절약 특성을 가지고 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 700px;"><iframe id="cp_embed_KKVJOge" src="//codepen.io/anon/embed/KKVJOge?height=700&amp;theme-id=1&amp;slug-hash=KKVJOge&amp;default-tab=result" height="700" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed KKVJOge" title="CodePen Embed KKVJOge" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

내가 만든 방법은 이렇다.

### 토글

우리는 두 개의 상태가 있는 메뉴를 만들고 있습니다. 열림과 닫힘이 있고, 둘 사이를 전환합니다. 여기서 Checkbox Hack이 작동하게 됩니다. 확인란에는 이러한 상태를 트리거하는 데 사용할 수 있는 두 가지 공통 대화형 상태(체크됨과 선택 해제됨)가 있으므로 완벽합니다.

체크박스가 숨겨져 있고 CSS로 메뉴 아이콘 아래에 위치하기 때문에 사용자는 이 체크박스와 상호 작용해도 이를 볼 수 없다. 상자(또는 메뉴 아이콘)를 선택하면 메뉴가 표시됩니다. 선택을 취소하면 숨겨집니다. 간단합니다. 리프팅 작업에는 JavaScript도 필요 없습니다!

물론 Checkbox Hack만이 이 작업을 수행할 수 있는 유일한 방법은 아니며, JavaScript로 메뉴를 열고 닫도록 클래스를 전환하려면 괜찮습니다.

체크박스가 소스 코드의 주요 내용보다 우선하는 것이 중요합니다. 이 작업을 위해 최종적으로 작성할 `:checked` 선택기는 형제 선택기를 사용해야 하기 때문입니다. 레이아웃에 문제가 있는 경우, Grid 또는 Flexbox를 사용하면 소스 순서에 구애받지 않습니다. 예를 들어, CSS에서 이 장점을 사용한 것처럼, 레이아웃에 사용할 수 있습니다.

사용자가 확인란의 사각형을 볼 수 없도록 메뉴 아이콘과 함께 유사 요소를 추가하기 전에 `외형` CSS 속성을 사용하여 확인란의 기본 스타일(브라우저에서 추가)이 제거됩니다.

첫째, 기본 마크업:

```html
<input type="checkbox"> 
<div id="menu">
  <!--menu options-->
</div>
<div id="page">
  <!--main content-->
</div>
```

… 및 Checkbox Hack 및 메뉴 아이콘의 기준 CSS:

```css
/* Hide checkbox and reset styles */
input[type="checkbox"] {
  appearance: initial; /* removes the square box */
  border: 0; margin: 0; outline: none; /* removes default margin, border and outline */
  width: 30px; height: 30px; /* sets the menu icon dimensions */
  z-index: 1;  /* makes sure it stacks on top */
} 
 
/* Menu icon */
input::after {
  content: "\2255";
  display: block; 
  font: 25pt/30px "georgia"; 
  text-indent: 10px;
  width: 100%; height: 100%;
} 
 
/* Page content container */
#page {
  background: url("earbuds.jpg") #ebebeb center/cover;
  width: 100%; height: 100%;
}
```

풀사이즈 배경 이미지가 될 #페이지 콘텐츠 스타일도 함께 던졌다.

### 과도기

메뉴 컨트롤을 클릭하면 두 가지 현상이 발생합니다. 먼저 메뉴 아이콘이 × 표시로 바뀌어 메뉴를 닫을 수 있음을 나타냅니다. 따라서, 우리는 입력이 `:checked` 상태일 때 체크박스 입력의 `::after` 유사 요소를 선택한다.

```css
input:checked::after {
  content: "\00d7"; /* changes to × mark */
  color: #ebebeb;
}
```

둘째, 메인 콘텐츠(우리의 "이어버드" 이미지)가 변환되어 아래에 메뉴가 표시됩니다. 그것은 오른쪽으로 움직이고, 회전하고 축소되며, 그것의 왼쪽 모서리는 각이 진다. 휘청거리며 열리는 문처럼 콘텐츠가 뒤로 밀리는 모습을 주기 위해서다.

```css
input:checked ~ #page { 
  clip-path: polygon(0 8%, 100% 0, 100% 100%, 0 92%);
  transform: translateX(40%) rotateY(10deg) scale(0.8); 
  transform-origin: right center; 
  transition: all .3s linear;
} 
```

나는 `클립 경로`를 사용하여 이미지의 모서리를 변경했습니다.

변환에 대한 전환을 적용하고 있기 때문에, "#페이지"에 초기 "클립 경로" 값이 있어야 전환될 수 있습니다. 또한 "#페이지"에 대한 전환은 시작하자마자 원활하게 종료될 수 있도록 할 것입니다.

```css
#page {
  background: url("earbuds.jpeg") #ebebeb center/cover; 
  clip-path: polygon(0 0, 100% 0, 100% 100%, 0 100%);
  transition: all .3s linear;
  width: 100%; height: 100%;
}
```

우리는 기본적으로 핵심 디자인과 코드를 완성했습니다. 확인란을 선택하지 않으면(× 표시를 클릭하여) 이어버드 이미지의 변환이 자동으로 실행 취소되고 전면과 중앙으로 돌아갑니다.

### JavaScript의 요약

우리가 찾고 있는 것을 가지고 있다 하더라도, UX 부서에서 이것을 잘 발전시킬 수 있는 한 가지 다른 것이 있다: "#page" 요소를 클릭하거나 누를 때 메뉴를 닫는 것이다. 이렇게 하면 사용자는 컨텐츠로 돌아가기 위해 × 마크를 찾거나 사용할 필요가 없습니다.

이것은 메뉴를 숨기기 위한 추가적인 방법이기 때문에, 우리는 JavaScript를 사용할 수 있습니다. 그리고 JavaScript가 어떤 이유로 비활성화된 경우? 별일 아닙니다. 그것은 메뉴가 없으면 작동이 안 되는 개선사항일 뿐입니다.

```js
document.querySelector("#page").addEventListener('click', (e, checkbox = document.querySelector('input')) => { 
  if (checkbox.checked) { checkbox.checked = false; e.stopPropagation(); }
});
```

이 3-liner는 체크박스가 `:checked` 상태인 경우 확인란의 선택을 취소하는 `#page` 요소에 클릭 이벤트 핸들러를 추가하여 메뉴를 닫습니다.

우리는 수직/초상 디자인을 위해 만들어진 데모를 보고 있지만, 우리가 작업 중인 컨텐츠에 따라 더 큰 화면 크기에서도 잘 작동합니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 500px;"><iframe id="cp_embed_BaKQeRj" src="//codepen.io/anon/embed/BaKQeRj?height=500&amp;theme-id=1&amp;slug-hash=BaKQeRj&amp;default-tab=result" height="500" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed BaKQeRj" title="CodePen Embed BaKQeRj" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이는 일반적인 플라이아웃 메뉴에 대한 하나의 접근 방식 또는 선택일 뿐입니다. 애니메이션은 많은 가능성을 열어주고 여러분이 염두에 두고 있는 다른 아이디어들이 아마 수십 가지 있을 것이다. 사실, 저는 그것들을 듣고 싶으니까, 공유해주세요!