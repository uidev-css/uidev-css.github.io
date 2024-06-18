---
title: "아웃시스템 UI를 사용자 정의하는 포괄적인 CSS 가이드"
description: ""
coverImage: "/assets/img/2024-06-19-TheComprehensiveCSSGuideforCustomizingOutSystemsUI_0.png"
date: 2024-06-19 00:17
ogImage: 
  url: /assets/img/2024-06-19-TheComprehensiveCSSGuideforCustomizingOutSystemsUI_0.png
tag: Tech
originalTitle: "The Comprehensive CSS Guide for Customizing OutSystems UI"
link: "https://medium.com/itnext/the-comprehensive-css-guide-for-customizing-outsystems-ui-3a6e37f0cfb6"
---


모든 아웃시스템 열정가가 일생 동안 한 가지 일이 있다면 무엇일까요? 네, 있습니다. 아웃시스템 UI를 기반으로 응용 프로그램의 외관을 사용자 정의하는 것입니다.

리액티브 웹 앱을 생성할 때, 예제 화면, 템플릿 및 구성 요소가 준비되어 있어 실제 사용 사례에 배포하고 사용할 수 있습니다. 화면에는 버튼, 아이콘, 글꼴, 색상, 테두리 등이 들어 있어 회사가 필요로 하는 기능을 완벽하게 제공합니다.

다음 단계는 회사의 사내 정체성에 따라 응용 프로그램을 사용자 정의하는 것입니다. 아웃시스템 UI에서 기본 스타일링이 제공되는데, 사용자 정의 CSS를 추가하여 응용 프로그램의 시각적 외관을 사용자 정의할 수 있습니다.

아웃시스템 UI의 기본 테마를 올바르게 덮어쓰기 위해서는 브라우저가 CSS를 렌더링하는 방식을 이해해야 합니다.

<div class="content-ad"></div>

# 시작부터 시작해봅시다

먼저 MyDreamApp이라는 새 모듈을 만들고 Screen1이라는 빈 화면을 생성할 거예요.

제가 기존부터 새로운 반응형 웹 앱을 만들 때, 플랫폼은 자동으로 모듈에 2가지 테마를 추가해요.

OutSystems UI 테마에는 내장된 구성 요소를 위한 모든 CSS가 포함되어 있고, MyDreamApp 테마에는 우리가 직접 만든 CSS 코드를 넣을 거예요.

<div class="content-ad"></div>

기본적으로, 우리는 MyDreamApp 테마를 진입점으로 갖고 있습니다. 이 테마는 OutSystemsUI 테마로 정의되어 있습니다.

![이미지](/assets/img/2024-06-19-TheComprehensiveCSSGuideforCustomizingOutSystemsUI_0.png)

이 Base 테마 접근 방식을 사용하면 여러 개의 테마가 순차적으로 로드될 수 있습니다.

브라우저에서 Screen1을 렌더링할 때 미리 작성된 많은 CSS가 이미 함께 제공된다는 것을 확인할 수 있습니다.

<div class="content-ad"></div>

이 표를 분석해보겠습니다.

## _Basics.css

_Basics.css 파일은 플랫폼 코어에서 가져왔어요.
플랫폼 화면이 올바르게 렌더링되는 데 중요한 CSS 클래스가 처리되는 곳이에요. .OSInline, .OSFillParent 또는 .feedback-message와 같은 것들이 여기에서 정의되어 있어요.

## OutSystemsReactWidgets.css

<div class="content-ad"></div>

플랫폼 코어의 다른 파일은 OutSystemsReactWidgets.css입니다.
이 CSS 파일에서 플랫폼은 컨테이너, 목록, 입력란, 스위치, 표현식과 같은 위젯들의 스타일링을 다룹니다. 이 위젯들은 Service Studio 툴박스에서 얻을 수 있습니다. 이 위젯들은 OutSystems를 사용하여 개발된 것이 아니라 React 하이코드로 개발되었습니다.

이것들은 필수적인 CSS 파일이며, 우리 애플리케이션에서 제거할 수 없습니다. 이 파일들은 제품 개발을 담당하는 내부 OS 팀에 의해 유지됩니다.

## OutSystemsUI.css

이제 우리는 OutSystems 세계에 들어갑니다. OutSystemsUI.css는 거의 20,000 줄의 CSS 코드를 포함하며, OSUI 키트의 모든 것, 레이아웃 및 패턴, 수정자 클래스, 색상, 크기 등이 스타일링되는 곳입니다.

<div class="content-ad"></div>

위 모든 구성 요소는 OutSystems의 로우 코드를 사용하여 개발되었으며, 플랫폼을 즉시 사용하고 기록 시간에 애플리케이션을 생성할 수 있는 가속기 역할을 합니다.

## MyDreamApp.extra.css

OutSystems는 레이아웃과 화면을 구축하기 위해 간단한 열 기반 접근 방식을 사용합니다. 우리는 열의 수를 구성하고 전체 너비인지 또는 고정 너비인지를 결정하며, Service Studio는 이러한 모든 설정을 MyDreamApp.extra.css 파일에 저장합니다.

![The Comprehensive CSS Guide for Customizing OutSystems UI](/assets/img/2024-06-19-TheComprehensiveCSSGuideforCustomizingOutSystemsUI_1.png)

<div class="content-ad"></div>

"If we set Grid Type to (None), this file is not created.

## MyDreamApp.css

Finally, only one file remains: MyDreamApp.css. This is where we will do most of our work and write custom CSS to override OutSystems UI default styling."

<div class="content-ad"></div>

테마 편집기를 사용하여 몇 가지 설정을 사용자 정의하면, Service Studio가 CSS 변수를 생성하여 MyDreamApp.css 파일 안에 배치할 것입니다. 이러한 변수들은 우리 애플리케이션의 전반적인 모양과 느낌에 영향을 미칠 것입니다.

![이미지](/assets/img/2024-06-19-TheComprehensiveCSSGuideforCustomizingOutSystemsUI_2.png)

![이미지](/assets/img/2024-06-19-TheComprehensiveCSSGuideforCustomizingOutSystemsUI_3.png)

OutSystemsUI.css에도 동일한 CSS 변수들이 포함되어 있으며, 테마 편집기에 의해 사용자 정의할 수 있습니다. 또한, 모든 변수에 대한 미리 작성된 기본값이 있습니다.

<div class="content-ad"></div>

MyDreamApp.css 파일이 OutSystemsUI.css 파일보다 늦게 로드되기 때문에 우리의 사용자 정의 CSS 변수가 OSUI에서 오는 변수를 덮어씁니다.

이러한 변수들은 :root 요소에 적용되기 때문에 글로벌입니다.

테마 편집기에서 모든 스타일을 재설정하면 MyDreamApp.css 파일이 완전히 비어있게 됩니다.

이제 기본 제공 파일을 이해했으니 우리는 그것들을 재정의할 준비를 할 수 있습니다.

<div class="content-ad"></div>

OutSystems 플랫폼에서 많은 것들과 마찬가지로 CSS를 빠르게 많이 작성하는 것이 쉽습니다. 그러나 많은 작업을 하는 것이 모든 것을 잘 해결한다는 것을 의미하지는 않습니다. 그러므로 CSS가 실제로 어떻게 작동하는 지 알아보도록 하겠습니다.

# CSS가 작동하는 방식

OutSystems UI 테마를 가장 효과적으로 재정의하려면 다음과 같이 세 가지 CSS 주제에 대해 이야기해야 합니다:

- 캐스케이딩
- 상속
- 특이성

<div class="content-ad"></div>

# 계단식

CSS에서의 "cascading(계단식)"은 스타일 규칙이 여러 소스에서 "cascade(폭포처럼)" 내려간다는 사실을 의미합니다. 이는 CSS에는 내재된 계층 구조가 있어 우선순위가 높은 스타일이 우선순위가 낮은 규칙을 덮어 씁니다.

다음 예제를 분석해 봅시다:

```js
// first.css 파일
h1 {
  font-family: "Courier New";
  color: red;
}

// second.css 파일
h1 {
  color: green;
}
```

<div class="content-ad"></div>

다음은 `h1` 요소에 대한 계산된 스타일 결과입니다:

```js
color: green;
display: block;
font-family: "Courier New";
font-size: 2em;
font-weight: 700;
// ... 몇 가지 더
```

여기 몇 가지 주요 개념을 확인해 보겠습니다:

- "green" 색상은 "red" 색상 뒤에 나오기 때문에 우선권을 갖습니다
(그래서 CSS 파일을 작성하거나 가져올 때 순서가 중요한 이유입니다)
- 요소는 다른 셀렉터에서 여러 속성을 추가할 수 있습니다
(모두 요소에 추가되어 적용됩니다)
- HTML 요소에는 사용자 에이전트가 정의한 기본 속성이 있습니다
(이것이 브라우저 간에 차이가 나는 이유 중 하나입니다)

<div class="content-ad"></div>

# 상속

CSS의 맥락에서 상속은 HTML 요소의 특정 스타일 속성이 해당 요소의 하위 요소로 전달되는 과정입니다.

다음 속성들이 이에 해당합니다:

- color
- font-family
- font-size
- font-style
- font-weight
- text-align
- (다른 많은 속성들...)

<div class="content-ad"></div>

자손들에게 상속됩니다.

따라서 `body`에 색상이나 글꼴 크기를 설정하면 그 설정에 영향을 받는 모든 하위 요소에 영향을 줍니다.

이 동작은 매우 유용하지만 오용 시 매우 위험할 수도 있습니다.
예를 들어, 요소에 text-align: center를 사용하면 모든 하위 HTML 노드도 중앙 정렬됩니다.

다른 속성은 다중상속되지 않으며 각 요소마다 명시적으로 정의해야 합니다. 이에는 다음이 포함됩니다:

<div class="content-ad"></div>

- 배경색
- 테두리
- 표시
- 여백
- 안쪽여백
- (다른 많은 항목들…)

# 특이성

가장 중요하면서도 재미있게 다루는 항목입니다.

특이성은 브라우저가 요소에 적합한 CSS 선언을 결정하는 알고리즘이며, 이는 다시 요소에 적용할 속성 값을 결정합니다.

<div class="content-ad"></div>

다음 3개의 열을 고려해 봅시다: a, band c.

![image](/assets/img/2024-06-19-TheComprehensiveCSSGuideforCustomizingOutSystemsUI_4.png)

특이성은 각 열의 선택자 수를 세어 세 부분 값으로 형성됩니다. 다음은 작동 방식입니다:

- ID 선택자: 각 id 선택자에 1을 a 값에 추가합니다.
- 클래스 선택자, 속성 선택자 및 가상 클래스: 각각에 1을 b 값에 추가합니다.
- 유형 선택자 및 가상 요소: 각각에 1을 c 값에 추가합니다.

<div class="content-ad"></div>

가장 구체적인 예를 몇 가지 살펴봅시다:

- body .wrapper #header ' '
특이성: (1, 1, 1)
- #main ' '
특이성: (1, 0, 0)
- .container .content ' '
특이성: (0, 2, 0)
- div ' '
특이성: (0, 0, 1)

전체 선택자 *, 결합자 +, `, ~ 및 부정 가상 클래스 :not는 그 자체로 특이성을 추가하지 않습니다.

동일한 요소에 여러 CSS 규칙이 적용되는 경우 특이성이 가장 높은 규칙이 이길 것입니다. 특이성 값이 동일한 경우 CSS 파일에서 마지막으로 선언된 규칙이 적용되며, 앞에서 언급한 계단식을 따릅니다.

<div class="content-ad"></div>

## 인라인 스타일

인라인 스타일은 특이성을 고려하지 않습니다. 왜냐하면 이들은 계층의 일찍 평가됩니다. 이들의 규칙은 특이성 알고리즘이 평가하는 것보다 우선합니다.

## !important

CSS 선택자에 !important를 사용하면 특이성이나 인라인 스타일에 관계없이 다른 규칙을 재정의합니다. 그러나 CSS를 유지하는데 더 어렵게 만들기 때문에 조심해서 사용해야 합니다. 이것은 모든 것의 어머니입니다.

<div class="content-ad"></div>

# 개발자 도구

브라우저 개발자 도구는 CSS가 브라우저에서 어떻게 렌더링되는지 이해하는 데도 큰 도움이 됩니다.

다음 이미지를 분석해 봅시다. 동일한 파일인 OutSystemsUI.css에서 여러 CSS 선택자들이 있습니다:

![OutSystemsUI CSS Image](/assets/img/2024-06-19-TheComprehensiveCSSGuideforCustomizingOutSystemsUI_5.png)

<div class="content-ad"></div>

일부 중요한 개념들:

- CSS 선택자는 선택된 요소에 적용되는 순서대로 위에서 아래로 표시됩니다;
- CSS 선택자에 마우스를 올리면 브라우저가 계산된 특이성을 표시합니다. (0, 4, 1)이 어떻게 계산되었는지 이해할 수 있나요?
- 1845번 라인의 CSS 선택자(0,3,0)가 9419번 라인의 것(0,2,1)보다 더 구체적이며 그래서 계층구조에서 뒤에 위치합니다.

그러니 브라우저 개발자 도구를 열어 CSS가 실제로 해석되는 방법을 이해하는 데 궁극적인 도움을 받아보세요.

# 그 다음에는 무엇을 해볼까요?

<div class="content-ad"></div>

CSS 작성을 시작해보세요!

수정하고 싶은 속성을 식별한 다음, Developer Tools를 확인하여 대상이 되는 OutSystems UI CSS 클래스를 확인하세요.

우리가 작성한 사용자 정의 테마 파일 MyDreamApp.css는 OutSystemsUI.css 이후에 로드됩니다. 이는 같은 특이성을 갖는 규칙은 나중에 로드되므로 우선적으로 적용됨을 의미합니다.

하지만 이것만으로 OSUI 코드의 모든 것을 무시할 수 있는 것은 아닙니다.

<div class="content-ad"></div>

코드가 실제로 적용되려면 더 높은 구체성이 필요합니다.

이제 진짜 의미를 알게 되었어요. 😄

# 몇 가지 조언

- 불필요한 CSS 선택자를 작성하거나 OSUI에서 완전한 규칙을 코드베이스로 직접 복사하는 것을 피하세요. 때로는 OSUI 팀이 릴리스 사이에 구성 요소 구조를 변경하고 규칙이 작동을 멈출 수 있습니다. 절대 필요한 최소한만 사용하세요.
- 재사용 가능한 CSS 클래스를 만들고 구성 요소에 적용하여 사용자 정의 코드를 내부에 유지하세요.
- 래퍼 CSS 클래스만 있으면(예: 레이아웃에) b 구체성 열에 1 포인트를 추가하고 그 안의 모든 것을 대상으로 지정하고 재정의할 수 있습니다.
- 가능한 경우 수정자 CSS 클래스와 함께 ExtendedClass 입력 매개변수를 사용하세요.
때로는 CSS를 전혀 작성할 필요가 없을 수도 있어요. 😎
OutSystems UI에서 이미 사용 가능한 유틸리티 클래스와 CSS 변수를 확인해보세요. 🤩 https://outsystemsui.outsystems.com/OutSystemsUIWebsite/CheatSheet

<div class="content-ad"></div>

# 결론

OutSystems UI 킷은 사용 준비가 되어 있어서 그대로 사용하면 아름다운 애플리케이션을 만들 수 있습니다.

하지만 모든 제품이 같은 모습이어야 하는 것은 아닙니다! 때때로 우리는 애플리케이션의 외관을 일부 CSS 코드로 사용자 정의해야 합니다.

이 기사에 설명된 브라우저가 CSS를 렌더링하는 방법과 개념을 이해하면 OutSystems UI를 기반으로 한 애플리케이션의 외관을 최적화한 CSS 코드를 쓸 수 있어서 노력을 최소화하면서 애플리케이션의 외관을 수정할 수 있습니다.

<div class="content-ad"></div>

만약 이 글을 즐겼다면 👏 버튼을 눌러주세요.
다른 글들도 확인하시고 댓글로 연락주세요!

이 글이 도움이 되었다면, 더 많은 글을 쓸 동기부여가 되겠어요. 🥰

![이미지](/assets/img/2024-06-19-TheComprehensiveCSSGuideforCustomizingOutSystemsUI_6.png)