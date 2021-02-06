---
layout: post
title: "스파게티 사용 레거시 코드베이스(또는 멋진 것을 가질 수 없는 경우)에 대한 반응형 jQuery"
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/07/spaghetti.jpg"
tags: JQUERY,REACTIVITY
---


저는 이제 여러분이 이렇게 외치는 것을 들을 수 있습니다. "도대체 더 좋은 도구가 있는데 왜 jQuery를 사용하려고 하십니까? 미친놈! 당신은 어떤 미치광이입니까?" 이것들은 합리적인 질문들이고, 저는 약간의 문맥을 가지고 대답할 것입니다.

현재 직장에서, 저는 레거시 웹 사이트의 관리와 급식을 담당하고 있습니다. 오래됐어요. 프런트 엔드는 jQuery에 의존하며, 대부분의 기존 시스템과 마찬가지로 최상의 상태가 아닙니다. 그것만으로도 최악은 아니지만, 저는 추가적인 제약으로 일하고 있습니다. 예를 들어, 우리는 시스템을 전면적으로 재작성하는 작업을 하고 있습니다. 그래서 대규모 리팩터링 작업은 승인되지 않고 있습니다. 그리고 저는 또한 완전한 보안 검토 없이는 기존의 시스템에 새로운 의존성을 추가할 수 없습니다. 역사적으로 최대 1년이 걸릴 수 있습니다. 사실상, jQuery는 이미 있기 때문에 내가 사용할 수 있는 유일한 자바스크립트 라이브러리이다.

우리 회사는 최근에서야 프런트 엔드 개발자들이 기여하는 중요한 기술을 가지고 있을 수 있다는 것을 깨닫게 되었고, 따라서 앱의 프런트 엔드는 모범 사례를 모르고 종종 그들의 과제를 경멸하는 개발자들에 의해 작성되었다. 결과적으로, 코드 품질은 매우 불균일하고 전체적으로 상당히 불량하고 단조롭다.

네, 저는 기존의 코드베이스에서 일합니다. 전형적인 jQuery 스파게티죠.

누군가는 해야 합니다. 그리고 세계에는 항상 그린필드 프로젝트보다 더 많은 레거시 코드가 있기 때문에, 항상 우리가 많이 있을 것입니다. 나도 당신의 동정을 바라지 않아요. 이런 것들을 다루면서, 그렇게 큰 규모로 프런트 엔드 스파게티를 다루는 법을 배우는 것은 저를 더, 더 까다롭더라도, 더 나은 개발자로 만들었습니다.

그럼 손에 스파게티 jQuery가 있는지 어떻게 알죠? 내가 발견한 믿을 만한 코드 냄새 하나는 존경할 만한 오래된 `.togle()의 부족이다. 한동안 jQuery에 대한 생각을 제대로 하지 못했다면, 이 라이브러리는 브라우저 간 호환성 문제를 해결하는 동시에 DOM 쿼리 및 돌연변이를 매우 쉽게 만들어 줍니다. 본질적으로 잘못된 것은 없지만, DOM 조작을 주의하지 않으면 확장하기가 매우 어려울 수 있습니다. DOM 조작을 많이 쓸수록 DOM 돌연변이에 대한 방어력이 높아집니다. 결국, 사용자는 전체 코드베이스를 그러한 방식으로 작성할 수 있으며, 이상적인 범위 관리보다 적은 범위 관리와 함께 모든 상태가 DOM에 있는 앱에서 작업하고 있으며, 변경을 수행해야 할 때 DOM이 어떤 상태에 있는지 신뢰할 수 없습니다. 앱의 어디에서든 변경 사항이 갑자기 발생할 수 있습니다. 좋든 싫든 간에. 코드는 보다 절차적이고 명확한 명령으로 상황을 부풀리고, DOM 자체에서 필요한 모든 데이터를 가져와 필요한 상태로 강제 적용하려고 합니다.

그래서 `토글()`이 먼저인 경우가 많은데, 요소의 가시성을 확신할 수 없으면 `.쇼()`와 `.히데()`를 대신 사용해야 한다. `.show`와 `.hide`가 `유해`로 간주되어야 한다는 것은 아니지만, 앞으로 더 큰 문제가 발생할 수 있다는 좋은 징조라는 것을 알게 되었습니다.

이걸 어떻게 이겨낼 수 있겠어요? 제 동료들과 제가 찾은 한 가지 해결책은 우리가 사용하는 반응형 프레임워크인 관찰 가능성과 상태 관리에서 직접 힌트를 얻습니다. 우리는 모두 DOM을 단방향 데이터 흐름 템플릿처럼 처리하면서 상태 객체와 이벤트 기반 업데이트 기능을 손으로 롤링하면 시간이 지남에 따라 변경하기가 더 쉬운 예측 가능한 결과를 얻을 수 있다는 것을 발견했다.

우리는 각각 그 문제에 조금 다르게 접근한다. 반응성 jQuery에 대한 나의 인식은 Vue 드롭인과 같은 독특한 맛이 나며 일부 "고급" CSS를 이용한다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_abOmPwW" src="//codepen.io/anon/embed/abOmPwW?height=450&amp;theme-id=1&amp;slug-hash=abOmPwW&amp;default-tab=html,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed abOmPwW" title="CodePen Embed abOmPwW" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

대본을 보시면 두 가지 다른 일들이 벌어지고 있는 것을 보실 수 있습니다. 첫째, 우리는 페이지의 모든 가치를 담고 있는 `국가` 객체가 있고, 우리는 큰 혼란이 있다.

```js
var State = {
  num: 0,
  firstName: "",
  lastName: "",
  titleColor: "black",
  updateState: function(key, value){
    this[key] = value;
        
    $("[data-text]").each(function(index, elem){
      var tag = $(elem).attr("data-tag");
      $(elem).text(State[tag]);
    });
    
    $("[data-color]").each(function(index, elem){
      var tag = $(elem).attr("data-tag");
      $(elem).attr("data-color", State[tag]);
    });
  }
};
```

저는 사용자 지정 HTML 속성을 매우 좋아하고 솔루션 전반에 걸쳐 자유롭게 적용했습니다. HTML 클래스가 CSS 훅과 JavaScript 훅으로 이중으로 작동하는 방식, 그리고 동시에 두 가지 용도로 클래스를 사용하면 스크립트에 민첩성을 도입하는 방식 등이 마음에 들어 본 적이 없습니다. 이 문제는 HTML 속성에서 완전히 사라집니다. 클래스는 다시 클래스가 되고 속성은 메타데이터 또는 스타일링 후크가 됩니다.

HTML을 보면, 데이터를 표시해야 하는 DOM의 모든 요소에는 표시할 데이터를 포함하는 `상태` 개체의 속성에 해당하는 값이 있는 `데이터 태그` 특성이 있고, 적용된 요소에 필요한 변환 종류를 설명하는 값이 없는 속성이 있습니다.o. 이 예에는 텍스트와 색이라는 두 가지 다른 종류의 변환이 있습니다.

```html
<h1 data-tag="titleColor" data-color>jDux is super cool!</h1>
```

이벤트를 진행합니다. 데이터에 대한 모든 변경 사항은 이벤트에 의해 실행됩니다. 스크립트에서 관심 있는 모든 이벤트는 고유한 .on() 메서드로 나열됩니다. 모든 이벤트는 업데이트 방법을 트리거하고 업데이트해야 하는 `상태` 개체의 속성과 새 값으로 두 가지 정보를 전송합니다.

```js
$("#inc").on("click", function(){
  State.updateState("num", State.num + 1)
});

$("#dec").on("click", function(){
  State.updateState("num", State.num - 1)
});

$("#firstNameInput").on("input", function(){
  State.updateState("firstName", $(this).val() )
});

$("#lastNameInput").on("input", function(){
  State.updateState("lastName", $(this).val() )
});

$('[class^=button]').on("click", function(e) {
  State.updateState('titleColor', e.target.innerText);
});
```

이렇게 하면 페이지가 상태 객체와 동기화되도록 하는 업데이트 기능을 통해 `State.updateState()로 이동합니다. 실행될 때마다 페이지에 태그가 지정된 모든 값이 업데이트됩니다. 매번 페이지의 모든 것을 다시 시작하는 것이 가장 효율적인 것은 아니지만, 훨씬 더 간단합니다. 그리고 제가 이미 분명히 밝혔기를 바라듯이, 이것은 불완전한 코드베이스에 대한 불완전한 해결책입니다.

```js
$(document).ready(function(){
  State.updateState();
});
```

업데이트 기능이 가장 먼저 수행하는 일은 수신 속성에 따라 값을 업데이트하는 것입니다. 그리고 나서 그것은 내가 말한 두 가지 변형을 실행한다. 텍스트 요소의 경우 모든 `데이터 텍스트` 노드의 목록을 만들고, 해당 `데이터 태그` 값을 캡처한 다음 태그가 지정된 속성에 있는 것으로 텍스트를 설정합니다. 색상은 약간 다르게 작동하여 데이터 컬러 속성을 태그된 속성 값으로 설정한 다음 CSS에 의존하여 데이터 컬러 속성을 스타일링하여 올바른 스타일을 보여준다.

로드 시 업데이트 기능을 실행하고 기본값을 표시할 수 있도록 `document.ready`도 추가했습니다. DOM 또는 AJAX 호출에서 기본값을 가져오거나, 여기에 입력한 대로 State 객체를 로드하기만 하면 됩니다.

바로 그거야! 우리가 하는 일은 자바스크립트에서 상태를 유지하고, 우리의 이벤트를 관찰하고, 변화가 일어날 때 반응하는 것이다. 간단하죠?

여기선 무슨 이득이 있나요? 이와 같은 패턴으로 작업하면 상태 객체에 사용자가 제어하고 신뢰할 수 있으며 적용할 수 있는 단일 진실 소스가 유지됩니다. DOM이 올바르다는 신뢰를 잃을 경우 인수 없이 업데이트 기능을 다시 실행하면 값이 상태 개체와 다시 일치합니다.

이런 종류의 호키와 원시적인가요? 당연하지. 이를 통해 전체 시스템을 구축하시겠습니까? 당치 않아요. 더 나은 도구를 사용할 수 있다면 사용해야 합니다. 하지만 저와 같이 매우 제한적인 레거시 코드베이스에 있다면, Reactive jQuery로 다음 기능을 작성하여 코드를 단순하게 만들 수 있는지 확인해 보십시오.