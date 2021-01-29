---
layout: post
title: "CSS 사용자 정의 속성 토글 트릭
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2019/09/custom-properties-code.png
tags: CUSTOM
---


2020 년 7 월에 저는 James0x57로부터 이메일을 받았습니다.
 

> 사용자 정의 CSS 속성에 대한 분기 조건 논리 및 대량 기능 전환의 전체 세계가 가능하며 CSS 사양의 작은 각주가 눈에 띄지 않았기 때문에 존재합니다.
 

그 라인은 :
 

> 참고 : <declaration-value>는 하나 이상의 토큰을 나타내야하지만 해당 토큰은 공백 일 수 있습니다.
 

즉,`--foo :;`가 유효합니다.
 

당신이 나와 같다면 이것은 거대한 문을 여는 거대한 계시로 읽히지 않지만 James0x57과 같은 똑똑한 사람들에게는 그렇게 읽습니다!
 블로그 게시물 초안 작업을 시작했지만 여러 가지 이유로 여기까지 완료되지 않았습니다.
 그 이유 중 하나는 제가 이해하지 못했기 때문입니다.
 조밀하다고 불러줘, 미안해 James0x57.
 내가 아주 멍청한 예제를 물었을 때 그들이 나에게 보낸 한 데모가 도움이되었고, 나는 그것이 나를 위해 일종의 클릭이라고 생각한다.
 제 해석은 다음과 같습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_abZBXde" src="//codepen.io/anon/embed/abZBXde?height=450&amp;theme-id=1&amp;slug-hash=abZBXde&amp;default-tab=css,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed abZBXde" title="CodePen Embed abZBXde" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

설명해 드리겠습니다.
 

- 여기에서 설정 한 중단 점은 900px `최대 너비`미디어 쿼리입니다.
 변수`--mq-sm`이`initial`에서 빈 공간 값으로 이동하는 것을 볼 수 있습니다.
 
- 브라우저 창이 900px보다 넓을 때`--mq-sm`의 값은`initial`입니다.
따라서 변수`--padding-when-small`에`initial`과`2rem`이라는 두 가지 값이 포함됩니다.이 값은 유효하지 않은 것 같습니다.
따라서 실제로 패딩을 설정하고`padding : var (-padding-when-small, var (-padding-when-large))`와 같은 변수를 호출 할 때 두 번째 값 ( "fallback")이 사용됩니다.
 첫 번째 값이 잘못되었습니다.
 
- 따라서 변수`--padding-when-small`에`initial`과`2rem`이라는 두 가지 값이 포함됩니다.이 값은 유효하지 않은 것 같습니다.
 
- 따라서 실제로 패딩을 설정하고`padding : var (-padding-when-small, var (-padding-when-large))`와 같은 변수를 호출 할 때 두 번째 값 ( "fallback")이 사용됩니다.
 첫 번째 값이 잘못되었습니다.
 
- 브라우저 창이 900px보다 좁 으면`--mq-sm` 값은 공백입니다.
그러면 변수`--padding-when-small` 값` "(space) 2rem"`이 유효하다고 생각합니다.
즉, 실제로 패딩을 설정하고`padding : var (-padding-when-small, var (-padding-when-large))`와 같은 변수를 호출하면 첫 번째 값이 사용됩니다.
 
- 그러면 변수`--padding-when-small` 값` "(space) 2rem"`이 유효하다고 생각합니다.
 
- 즉, 실제로 패딩을 설정하고`padding : var (-padding-when-small, var (-padding-when-large))`와 같은 변수를 호출하면 첫 번째 값이 사용됩니다.
 

이제 자리 표시 자 변수를 변경하여 두 값 사이의 패딩을 뒤집을 수 있습니다.
 

그것은 나를 위해 클릭합니다.
 

이것이 단순히 단일 값을 변경하는 것으로 볼 때 거의 어, 좋습니다. 일부 패딩을 변경하는 매우 복잡한 방법을 찾았지만 미디어 쿼리에서 패딩을 변경했을 수도 있습니다.
 하지만 트릭은 이제 변경된이 자리 표시 자 변수가 있고 여기에 입력하여 다른 값을 무제한으로 변경할 수 있다는 것입니다.
 

CSS에 이러한 자리 표시 자 변수 만 토글하고 값을 토글하기 위해 다른 곳에서 사용하는 단일 미디어 쿼리 (또는 미디어 쿼리 집합)가있을 수 있습니다.
 CSS 전체에 미디어 쿼리를 뿌리는 것과 비교할 때 멋지고 깔끔 할 수 있습니다.
 이전에는 없었던 IF / THEN 로직과 같은 CSS의 적절한 토글입니다.
 

James0x57은 그 생각을 AND, OR, XOR, NAND, NOR 및 XNOR과 같은 모든 논리적 가능성으로 확장했지만 다시는 나를 잃었습니다.
 여기 컴퓨터 과학자는 아닙니다.
 그러나이 물건의 실제 사용을보고 싶다면 그들의 작업을 따를 수 있습니다.
 

이 변수는 거칠고 매우 혼란스러워집니다.
 나는 아마도 까다로운 CSS 사용자 정의 속성을 다루는 Patrick Brosset의 최근 기사에서 언급했습니다.
 예를 들어 폴백은 다음과 같이 무한 중첩 될 수 있습니다.
 

```html
color: var(--foo, var(--bar, var(--baz, var(--are, var(--you, var(--crazy)))));
```

또한 CSS 사용자 정의 속성에 유효한 값은 다음과 같이 쉼표를 포함 할 수 있습니다.
 

```html
content: var(--foo, one, two, three);
```

정말 하나의 `1, 2, 3`값을 가진 하나의 폴백입니까?
 이것은 오히려 마음을 굽히는 것입니다.
 

어쨌든, 이제 몇 달을 빨리 감아보세요. CSS 속임수 마스터 Lea Verou는 다음과 같은 커스텀 속성의 공백에 관심을두고 있습니다.
 

> 단일 속성 값을 사용하여 여러 다른 속성과 여러 CSS 규칙에 걸쳐 여러 다른 값을 켜고 끌 수 있다고 말하면 어떻게됩니까?
 

같은 속임수입니다!
 하지만 Lea의 예에서는이 기능을 사용하여 다음을 수행합니다.
 

- 버튼에 변형을 설정하고
 
- 하나가 아닌 네 가지 속성을 설정합니다.
 

이것은 이것이 개념이 왜 그렇게 멋진 지에 대해 정말로 연마합니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_YzWpBaV" src="//codepen.io/anon/embed/YzWpBaV?height=450&amp;theme-id=1&amp;slug-hash=YzWpBaV&amp;default-tab=css,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed YzWpBaV" title="CodePen Embed YzWpBaV" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

Lea는 몇 가지 단점을 지적합니다.
 

> “ '--foo'가 설정되어 있으면 배경이 빨간색이어야하고 그렇지 않으면 흰색이어야합니다.”라고 말할 방법이 없습니다.
 이러한 조건문 중 일부는 추가를 영리하게 사용하여 에뮬레이션 할 수 있지만 대부분은 아닙니다.
그리고 물론 특정 가독성 문제가 있습니다.`--foo :;`는 실수처럼 보이며`--foo : initial`은이 기술을 알지 못한다면 꽤 이상해 보입니다.
 

우리는 확실히 사용자 지정 속성이 사용되는 다음 시대에 접어 들고 있습니다.
 먼저 전 처리기 변수처럼 사용했습니다.
 그런 다음 더 많은 캐스케이드 및 폴백 사용량을보기 시작했습니다.
 다음으로 JavaScript와 함께 더 자주 사용했습니다.
 이제 이거.
 

CSS 전 처리기 변수를 유지하는 것에 대해 더 많은 글이 있습니다. 그들이 할 수있는 일만 필요할 때가 아니라 색상 값을 조작하는 것과 같이 그들이 할 수있는 일에 대한 것입니다.
 