---
layout: post
title: "Autogrowing Textareas를위한 가장 깨끗한 트릭
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/11/Frame-1.svg
tags: GRID,TEXTAREA
---


올해 초에 나는 자동 증가하는 텍스트 영역과 입력에 대해 약간 썼다.
 아이디어는`<textarea>`를`<div>`와 비슷하게 만들어 현재 값을 포함하기 위해 필요한만큼 높이가 확장되도록하는 것이 었습니다.
 이것에 대한 간단한 기본 솔루션이 없다는 것이 거의 이상하지 않습니까?
 그 기사를 돌이켜 보면 제 아이디어 중 특별히 좋은 것은 하나도 없었습니다.
 하지만 마지막에 연결 한 Stephen Shaw의 아이디어는 실제로 이것에 대한 아주 좋은 아이디어입니다. 그래서 저는이 UX에 대한 최종 답인 것처럼 보이므로 그것에 대해 조명을 비추고 작동 방식에 대해 이야기하고 싶었습니다.
 네이티브하고 더 나은 것을 얻을 때까지 할 수 있습니다.
 

다음은 실제 예제를 원하는 경우를위한 데모입니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_XWKEVLy" src="//codepen.io/anon/embed/XWKEVLy?height=450&amp;theme-id=1&amp;slug-hash=XWKEVLy&amp;default-tab=css,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed XWKEVLy" title="CodePen Embed XWKEVLy" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 트릭은 높이를 자동으로 확장 할 수있는 요소에`<textarea>`의 내용을 정확하게 복제하고 크기와 일치하는 것입니다.
 

따라서 높이를 자동으로 확장 할 수없는`<textarea>`가 있습니다.
 

대신 다른 요소에서 요소의 모양, 내용 및 위치를 정확하게 복제합니다.
 복제본을 시각적으로 숨 깁니다 (기술적으로 작동하는 복제본을 그대로 둘 수도 있음).
 

![image](https://css-tricks.com/wp-content/uploads/2020/11/Frame-1.svg)

이제 세 가지 요소가 모두 서로 연결되어 있습니다.
 가장 큰 아이는 부모를 그 높이로 밀고 다른 아이는 따라갈 것입니다.
 즉,`<textarea>`의 최소 높이가 "기본"높이가되지만 복제 된 텍스트 요소가 커지면 모든 항목이 함께 커집니다.
 

매우 영리한.
 난 그것을 너무 좋아한다.
 verified_user

### 복제 된 요소가 정확히 동일한 지 확인해야합니다.
 

동일한 글꼴, 동일한 패딩, 동일한 여백, 동일한 테두리… 모든 것.
 `visibility : hidden;`으로 시각적으로 숨겨져있는 동일한 사본입니다.
 정확히 똑같지 않다면 모든 것이 정확히 함께 성장하지 못할 것입니다.
 

또한 복제 된 텍스트에 `white-space : pre-wrap;`이 필요합니다. 이것이 텍스트 영역이 작동하는 방식이기 때문입니다.
 

### 이것은 가장 이상한 부분입니다
 

내 데모에서는 복제 된 텍스트에`:: after`를 사용하고 있습니다.
 이것이 최선의 방법인지 아닌지 잘 모르겠습니다.
 깨끗하게 느껴지지만`<div aria-hidden = "true">`를 사용하는 것이 스크린 리더에게 더 안전한지 궁금합니다.
 아니면 `visibility : hidden;`만으로 충분할까요?
 어쨌든 그것은 이상한 부분이 아닙니다.
 이것은 이상한 부분입니다.
 

```css
content: attr(data-replicated-value) " ";
```

필자는 유사 요소를 사용하고 있기 때문에 요소에서`data` 속성을 가져 와서 추가 공간 (이상한 부분)이있는 페이지에 콘텐츠를 렌더링하는 줄입니다.
 그렇게하지 않으면 최종 결과가 "빠르게"느껴집니다.
 완전히 이해한다고 말할 수는 없지만 텍스트 영역과 텍스트 요소에서 줄 바꿈 동작을 더 잘 존중하는 것 같습니다.
 

유사 요소를 사용하고 싶지 않다면, 괜찮습니다. 삐걱 거리는 동작을 조심하세요.
 

Shaw의 기술이 얼마나 영리한지를 상기시키기 위해 같은 날에 무작위로 이메일을 보낸 Will Earp과 Martin Tillmann에게 특별한 하이 파이브입니다.
 다음은 Martin이 Alpine.js 및 Tailwind로 만든 예입니다.이 예는 마치 한 줄짜리처럼 끝납니다 (하지만 어떻게 갑작스러운 일이 진행되는지 주목하세요).
 

나는 당신이 Vue와 React로 이것을 어떻게 할 것인지, 그리고 텍스트 영역과 다른 요소에서 상태를 매우 쉽게 유지할 수있는 방식으로 상상할 수있을 것이라고 확신합니다.
 부분적으로는 게으 르기 때문에 여기에 예제를 포함하지 않겠습니다.하지만 대부분은 이것이 어떻게 작동하는지 이해해야한다고 생각하기 때문입니다.
 그것은 당신을 더 똑똑하게 만들고 당신의 사이트를 더 잘 이해할 것입니다.
 