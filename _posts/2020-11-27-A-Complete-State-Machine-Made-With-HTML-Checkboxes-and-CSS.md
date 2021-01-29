---
layout: post
title: "HTML 체크 박스와 CSS로 만든 완전한 상태 머신
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/11/state-management.png
tags: STATE,STATE MACHINES,STATE MANAGEMENT
---


상태 머신은 일반적으로 웹에서 JavaScript로 표현되며 종종 인기있는 XState 라이브러리를 통해 표현됩니다.
 그러나 상태 머신의 개념은 놀랍게도 HTML과 CSS를 포함하여 거의 모든 언어에 적용 할 수 있습니다.
 이 기사에서 우리는 그것을 정확하게 할 것입니다.
 저는 최근에 "클라이언트 JavaScript 없음"제약 조건이 포함 된 웹 사이트를 만들었으며 특정 고유 한 대화 형 기능이 필요했습니다.
 

이 모든 것의 핵심은`<form>`및`<input type = "radio">`요소를 사용하여 상태를 유지하는 것입니다.
 이 상태는 다른 라디오`<input>`으로 토글되거나 재설정되거나 동일한`<form>`태그에 연결되어 있기 때문에 페이지의 어느 위치 에나있을 수있는`<button>`을 재설정합니다.
 나는이 조합을 무선 리셋 컨트롤러라고 부르며 기사의 끝에서 더 자세히 설명합니다.
 추가 양식 / 입력 쌍으로 더 복잡한 상태를 추가 할 수 있습니다.
 

궁극적으로 CSS의`: checked` 선택기가 UI 작업을 수행한다는 점에서 Checkbox Hack과 약간 비슷하지만 논리적으로 더 고급입니다.
 이 기사에서는 템플릿 언어 (Nunjucks)를 사용하여 관리 및 구성 가능하게 유지합니다.
 

### 신호등 상태 머신
 

모든 상태 기계 설명에는 필수 신호등 예제가 포함되어야합니다.
 아래는 HTML 및 CSS에서 상태 시스템을 사용하는 작동 신호등입니다.
 "다음"을 클릭하면 상태가 진행됩니다.
 이 Pen의 코드는 Pen에 맞게 상태 머신 템플릿에서 사후 처리됩니다.
 나중에 더 읽기 쉬운 방식으로 코드를 살펴 보겠습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 475px;"><iframe id="cp_embed_MWemBrd" src="//codepen.io/anon/embed/MWemBrd?height=475&amp;theme-id=1&amp;slug-hash=MWemBrd&amp;default-tab=result" height="475" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed MWemBrd" title="CodePen Embed MWemBrd" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 테이블 정보 숨기기 / 표시
 

신호등은 일상 생활에서 가장 실용적인 UI가 아닙니다.
 대신`<table>`은 어떻습니까?
 

UI 전체의 변경 사항에 영향을 미치는 디자인의 서로 다른 두 위치에서 변경된 두 가지 상태 (A 및 B)가 있습니다.
 이는 상태를 유지하는 빈`<form>`요소와`<input>`요소가 마크 업의 맨 위에 있으므로 일반 형제 선택기로 추론 할 수 있고 나머지 UI에 도달 할 수 있기 때문에 가능합니다.
 하위 선택자와 함께.
 여기에는 UI와 마크 업의 느슨한 결합이 있습니다. 즉, 페이지 어디에서나 페이지의 거의 모든 상태를 변경할 수 있습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 500px;"><iframe id="cp_embed_RwRVZVe" src="//codepen.io/anon/embed/RwRVZVe?height=500&amp;theme-id=1&amp;slug-hash=RwRVZVe&amp;default-tab=result" height="500" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed RwRVZVe" title="CodePen Embed RwRVZVe" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 일반적인 4 개 상태 구성 요소
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/11/v4trsktr3rwzl3ji237m.png?resize=440%2C350&ssl=1)

목표는 페이지의 원하는 상태를 제어하기위한 범용 구성 요소입니다.
 여기서 "페이지 상태"는 원하는 페이지 상태를 나타내고 "시스템 상태"는 컨트롤러 자체의 내부 상태를 나타냅니다.
 위의 다이어그램은 네 가지 상태 (A, B, C 및 D)가있는이 일반 상태 머신을 보여줍니다.
 이에 대한 전체 컨트롤러 상태 머신이 아래에 나와 있습니다.
 3 개의 무선 리셋 컨트롤러 비트를 사용하여 구축되었습니다.
 이들 중 세 개를 함께 추가하면 8 개의 내부 시스템 상태 (켜짐 또는 꺼짐 인 세 개의 독립 라디오 버튼)가있는 상태 머신이 형성됩니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/11/vj2cgxjia224nzxph3ax.png?resize=694%2C542&ssl=1)

"머신 상태"는 세 개의 라디오 버튼 (예 : M001 또는 M101)의 조합으로 작성됩니다.
 초기 M111에서 M011로 전환하려면 동일한 그룹에서 다른 라디오`<input>`을 클릭하여 해당 비트의 라디오 버튼을 설정 해제합니다.
 다시 전환하려면 해당 비트에 연결된`<form>`의 재설정`<button>`을 클릭하여 기본 선택 상태를 복원합니다.
 이 시스템에는 총 8 개의 상태가 있지만 특정 전환 만 가능합니다.
 예를 들어 M111에서 M100으로 직접 이동할 수있는 방법은 없습니다. 2 비트를 뒤집어 야하기 때문입니다.
 그러나 이러한 8 개 상태를 4 개 상태로 접어 각 페이지 상태가 두 개의 시스템 상태 (즉, A가 M111 및 M000을 공유 함)를 공유하면 모든 페이지 상태에서 다른 페이지 상태로 단일 전환이 발생합니다.
 

### 재사용 가능한 4 개 상태 구성 요소
 

재사용 성을 위해 구성 요소는 Nunjucks 템플릿 매크로로 빌드됩니다.
 이를 통해 원하는 유효한 상태 및 전환으로 상태 머신을 추가하기 위해 페이지에 드롭 할 수 있습니다.
 4 개의 필수 하위 구성 요소가 있습니다.
 

- 제어 장치
 
- CSS 로직
 
- 전환 컨트롤
 
- 상태 클래스
 

컨트롤러는 세 개의 빈 양식 태그와 세 개의 라디오 버튼으로 구성됩니다.
 각 라디오 버튼 `checked`속성은 기본적으로 `checked`입니다.
 각 단추는 양식 중 하나에 연결되며 고유 한 라디오 그룹 이름으로 서로 독립적입니다.
 이러한 입력은 직접 변경되거나 표시되지 않기 때문에`display : none`으로 숨겨집니다.
 이 세 입력의 상태는 시스템 상태를 구성하며이 컨트롤러는 페이지 상단에 있습니다.
 

```html
{% macro FSM4S_controller()%}
  <form id="rrc-form-Bx00"></form>
  <form id="rrc-form-B0x0"></form>
  <form id="rrc-form-B00x"></form>
  <input data-rrc="Bx00" form="rrc-form-Bx00" style="display:none" type="radio" name="rrc-Bx00" checked="checked" />
  <input data-rrc="B0x0" form="rrc-form-B0x0" style="display:none" type="radio" name="rrc-B0x0" checked="checked" />
  <input data-rrc="B00x" form="rrc-form-B00x" style="display:none" type="radio" name="rrc-B00x" checked="checked" />
{% endmacro %}
```

위의 컨트롤러를 페이지 상태에 연결하는 로직은 CSS로 작성됩니다.
 Checkbox Hack은 유사한 기술을 사용하여 확인란으로 형제 또는 하위 요소를 제어합니다.
 여기서 차이점은 상태를 제어하는 버튼이 선택하는 요소와 밀접하게 연결되어 있지 않다는 것입니다.
 아래 로직은 세 개의 컨트롤러 라디오 버튼 각각의 "확인"상태와`.M000` 클래스의 하위 요소를 기준으로 선택합니다.
 이 상태 머신은`display : none! important`를 설정하여`.M000` 클래스가있는 모든 요소를 숨 깁니다.
 여기서 `! important`는 논리의 중요한 부분이 아니며 제거 할 수 있습니다.
 다른 CSS에 의해 무시되지 않도록 숨기기에 우선 순위를 둡니다.
 

```html
{%macro FSM4S_css()%}
<style>
  /* Hide M000 (A1) */
  input[data-rrc="Bx00"]:not(:checked)~input[data-rrc="B0x0"]:not(:checked)~input[data-rrc="B00x"]:not(:checked)~* .M000  {
    display: none !important;
  }

  /* one section for each of 8 Machine States */

</style>
{%endmacro%}
```

페이지 상태를 변경하려면 사용자가 클릭하거나 키를 입력해야합니다.
 시스템 상태의 단일 비트를 변경하기 위해 사용자는 컨트롤러에있는 비트 중 하나의 동일한 양식 및 라디오 그룹에 연결된 라디오 버튼을 클릭합니다.
 이를 재설정하려면 사용자는 동일한 라디오 버튼에 연결된 양식의 재설정 버튼을 클릭합니다.
 라디오 버튼 또는 재설정 버튼은 현재 상태에 따라 표시됩니다. 유효한 전환에 대한 전환 매크로가 HTML에 추가됩니다.
 페이지 어디에나 여러 전환이있을 수 있습니다.
 현재 비활성 상태에 대한 모든 전환이 숨겨집니다.
 

```html
{%macro AtoB(text="B",class="", classBtn="",classLbl="",classInp="")%}
  <label class=" {{class}} {{classLbl}} {{showM111_A()}} "><input class=" {{classInp}} " form="rrc-form-Bx00" type="radio" name="rrc-Bx00" />{{text}}</label>
  <button class=" {{class}} {{classBtn}} {{showM000_A1()}} " type="reset" form="rrc-form-Bx00">{{text}}</button>
{%endmacro%}

```

위의 세 가지 구성 요소로 충분합니다.
 상태에 의존하는 모든 요소는 다른 상태에서 숨길 수 있도록 클래스를 적용해야합니다.
 이것은 지저분해진다.
 다음 매크로는 해당 프로세스를 단순화하는 데 사용됩니다.
 주어진 요소가 상태 A에만 표시되어야하는 경우`{{showA ()}}`매크로는 숨길 상태를 추가합니다.
 

```html
{%macro showA() %}
  M001 M010 M100 M101 M110 M011
{%endmacro%}

```

### 함께 모아서
 verified_user

신호등 예제에 대한 마크 업은 다음과 같습니다.
 템플릿 매크로는 파일의 첫 번째 줄에서 가져옵니다.
 CSS 로직이 머리에 추가되고 컨트롤러가 본문의 맨 위에 있습니다.
 상태 클래스는`.traffic-light` 요소의 각 조명에 있습니다.
 점등 된 신호에는`{{showA ()}}`매크로가있는 반면“off”버전의 신호에는 A 상태에서 숨길 수있는`.M000` 및`.M111` 클래스에 대한 기계 상태가 있습니다.
 상태 전환 버튼은 페이지 하단에 있습니다.
 

```html
{% import "rrc.njk" as rrc %}
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Traffic Light State Machine Example</title>
  <link rel="stylesheet" href="styles/index.processed.css">
  {{rrc.FSM4S_css()}}
</head>
<body>
  {{rrc.FSM4S_controller()}}
  <div>
    <div class="traffic-light">
      <div class="{{rrc.showA()}} light red-light on"></div>
      <div class="M111 M000 light red-light off"></div>
      <div class="{{rrc.showB()}} light yellow-light on"></div>
      <div class="M100 M011 light yellow-light off"></div>
      <div class="{{rrc.showC()}} light green-light on"></div>
      <div class="M010 M101 light green-light off"></div>
    </div>
    <div>
      <div class="next-state">
        {{rrc.AtoC(text="NEXT", classInp="control-input",
          classLbl="control-label",classBtn="control-button")}}
        {{rrc.CtoB(text="NEXT", classInp="control-input",
          classLbl="control-label",classBtn="control-button")}}
        {{rrc.BtoA(text="NEXT", classInp="control-input",
          classLbl="control-label",classBtn="control-button")}}
      </div>
    </div>
  </div>
</body>
</html>
```

### 더 많은 주로 확장
 

여기의 상태 머신 구성 요소에는 특히 한 페이지에서 여러 독립 상태 머신을 사용할 수 있으므로 많은 사용 사례에 충분한 최대 4 개의 상태가 포함됩니다.
 

즉,이 기술은 4 개 이상의 상태를 가진 상태 머신을 구축하는 데 사용할 수 있습니다.
 아래 표는 추가 비트를 추가하여 작성할 수있는 페이지 상태 수를 보여줍니다.
 짝수 비트는 효율적으로 축소되지 않으므로 3 비트와 4 비트가 모두 4 개의 페이지 상태로 제한됩니다.
 

### 무선 재설정 컨트롤러 세부 정보
 

JavaScript없이 페이지의 어느 곳에서나 HTML 요소를 표시하거나 숨기거나 제어 할 수있는 비결은 내가 라디오 재설정 컨트롤러라고 부르는 것입니다.
 세 개의 태그와 한 줄의 CSS를 사용하여 제어 버튼과 제어 요소를이 컨트롤러 뒤에 배치 할 수 있습니다.
 제어 측은 기본적으로 `선택`된 숨겨진 라디오 버튼을 사용합니다.
 이 라디오 버튼은 ID로 빈`<form>`요소에 연결됩니다.
 이 양식에는`type = "reset"`버튼과 함께 컨트롤러를 구성하는 또 다른 라디오 입력이 있습니다.
 

```html
<!-- RRC Controller -->
<form id="rrc-form"></form>
<label>
  Show
  <input form="rrc-form" type="radio" name="rrc-group" />
</label>
<button type="reset" form="rrc-form">Hide</button>

<!-- Controlled by RRC -->
<input form="rrc-form" class="hidden" type="radio" name="rrc-group" checked />
<div class="controlled-rrc">Controlled from anywhere</div>
```

이것은 최소한의 구현을 보여줍니다.
 숨겨진 라디오 버튼과 컨트롤이 제어하는 `div`는 형제 여야하지만 해당 입력은 숨겨져 있으며 사용자가 직접 상호 작용할 필요가 없습니다.
 기본 `checked`값으로 설정되고 다른 라디오 버튼으로 지워지고 양식 재설정 버튼으로 재설정됩니다.
 

```css
input[name='rrc-group']:checked + .controlled-rrc {
  display: none;
}
.hidden {
  display: none;
}
```

이 작업을 수행하려면 두 줄의 CSS 만 필요합니다.
 `: checked` 의사 선택기는 숨겨진 입력을 제어중인 형제에 연결합니다.
 다음 펜에 표시되는 단일 토글로 스타일을 지정할 수있는 라디오 입력 및 재설정 버튼을 추가합니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 350px;"><iframe id="cp_embed_MWyBNpB" src="//codepen.io/anon/embed/MWyBNpB?height=350&amp;theme-id=1&amp;slug-hash=MWyBNpB&amp;default-tab=result" height="350" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed MWyBNpB" title="CodePen Embed MWyBNpB" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 접근성… 이렇게해야합니까?
 

이 패턴은 작동하지만 모든 곳에 사용되어야한다고 제안하지는 않습니다.
 대부분의 경우 JavaScript는 웹에 상호 작용을 추가하는 올바른 방법입니다.
 나는 이것을 게시하는 것이 접근성 및 의미 론적 마크 업 전문가로부터 열을 얻을 수 있다는 것을 알고 있습니다.
 저는 접근성 전문가가 아니며이 패턴을 구현하면 문제가 발생할 수 있습니다.
 아니면 그렇지 않을 수도 있습니다.
 그렇지 않으면 숨겨진 입력에 의해 제어되는 페이지에 작업을 수행하는 적절하게 레이블이 지정된 단추가 제대로 작동 할 수 있습니다.
 접근성 토지의 다른 것과 마찬가지로 테스트가 필요합니다.
 

또한이 작업을 수행하는 방법에 대해 다른 사람이 작성하는 것을 본 적이 없으며 드문 상황이나 엣지 케이스 상황에서만 적절하더라도 지식이 유용하다고 생각합니다.
 