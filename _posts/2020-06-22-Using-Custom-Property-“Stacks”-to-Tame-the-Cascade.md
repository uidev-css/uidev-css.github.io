---
layout: post
title: "Custom Property 'Stacks'를 사용하여 계단식 길들이기"
author: "Uidev Css"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/06/custom-property-stacks.png"
tags: CASCADE,CUSTOM PROPERTIES,INHERITENCE
---


1994년 CSS가 시작된 이래, 캐스케이드와 상속은 우리가 웹에서 어떻게 디자인하는지를 정의해 왔다. 둘 다 강력한 특징이지만, 작가로서, 우리는 그들이 어떻게 상호작용하는지 거의 통제하지 못했습니다. 셀렉터 특수성과 소스 순서는 많은 뉘앙스 없이 약간의 최소한의 "레이어링" 제어를 제공하며 상속에는 중단 없는 계통이 필요합니다. 이제 CSS Custom Properties를 통해 캐스케이드와 상속을 새로운 방식으로 관리하고 제어할 수 있습니다.

제가 어떻게 Custom Property "stacks"를 사용하여 사람들이 계단식 구성 요소 스타일에서 보다 명확한 의도 계층화까지 직면하는 몇 가지 일반적인 문제를 해결했는지 보여드리고자 합니다.

### 사용자 지정 속성에 대한 빠른 소개

브라우저가 `-webkit-` 또는 `-moz-`와 같은 벤더 접두사를 사용하여 새 속성을 정의한 것과 동일한 방식으로 우리는 "빈" 접두사 `--`로 자신의 사용자 지정 속성을 정의할 수 있다. Sass 또는 JavaScript의 변수와 마찬가지로 값을 이름 짓고 저장하며 검색할 수 있지만 CSS의 다른 속성과 마찬가지로 값을 캐스케이드하여 DOM으로 상속합니다.

```css
/* Define a custom property */
html {
  --brand-color: rebeccapurple;
}
```

이러한 캡처된 값에 액세스하려면 `var()` 함수를 사용합니다. 여기에는 두 가지 부분이 있습니다. 먼저 사용자 지정 속성의 이름을 지정한 다음 해당 속성이 정의되지 않은 경우 폴백:

```css
button {
  /* use the --brand-color if available, or fall back to deeppink */
  background: var(--brand-color, deeppink);
}
```

이것은 이전 브라우저에 대한 지원 예비 프로그램이 아닙니다. 브라우저가 사용자 지정 속성을 이해하지 못하는 경우 전체 `var()` 선언을 무시합니다. 대신, 이것은 정의되지 않은 변수를 처리할 수 있는 기본 방식이며, 사용할 수 없을 때 예비 글꼴 패밀리를 정의하는 글꼴 스택과 유사합니다. 폴백을 제공하지 않으면 기본값은 "unset"입니다.

### 빌딩 변수 "스택스"

이러한 폴백을 정의하는 기능은 글꼴 패밀리 속성에 사용되는 글꼴 스택과 유사합니다. 첫 번째 패밀리를 사용할 수 없는 경우 두 번째 패밀리가 사용됩니다. var() 함수는 단일 폴백만 허용하지만 var() 함수를 중첩하여 모든 크기의 사용자 지정 속성 폴백 "stacks"를 생성할 수 있습니다.

```css
button {
  /* try Consolas, then Menlo, then Monaco, and finally monospace */
  font-family: Consolas, Menlo, Monaco, monospace;

  /* try --state, then --button-color, then --brand-color, and finally deeppink */
  background: var(--state, var(--button-color, var(--brand-color, deeppink)));
}
```

쌓인 속성에 대한 중첩 구문이 부피가 커 보이면 Sass와 같은 사전 프로세서를 사용하여 더 압축할 수 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_GRpmOjr" src="//codepen.io/anon/embed/GRpmOjr?height=450&amp;theme-id=1&amp;slug-hash=GRpmOjr&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed GRpmOjr" title="CodePen Embed GRpmOjr" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이러한 단일 폴백 제한은 글꼴 스택이나 계층화된 배경 이미지와 같은 쉼표가 포함된 폴백을 지원하기 위해 필요합니다.

```css
html {
  /* The fallback value is "Helvetica, Arial, sans-serif" */
  font-family: var(--my-font, Helvetica, Arial, sans-serif);
}
```

### 범위 정의

CSS 선택기를 사용하면 HTML DOM 트리로 드릴다운할 수 있으며 페이지의 아무 곳이나 또는 특정 중첩 컨텍스트의 요소를 스타일링할 수 있습니다.

```css
/* all links */
a { color: slateblue; }

/* only links inside a section */
section a { color: rebeccapurple; }

/* only links inside an article */
article a { color: deeppink; }
```

유용하지만, "모듈형" 객체 지향 또는 구성요소 중심 스타일의 현실을 포착하지는 못합니다. 다양한 구성으로 중첩된 여러 개의 아티클과 측면부가 있을 수 있습니다. 우리는 그것들이 겹칠 때 어떤 맥락이나 범위가 우선되어야 하는지를 명확히 할 수 있는 방법이 필요하다.

우리가 `.light` 테마와 `.dark` 테마가 있다고 가정해 보자. 루트 `<` 요소의 클래스를 사용하여 페이지 전체 기본값을 정의할 수 있지만, 다양한 방법으로 중첩된 특정 구성 요소에도 적용할 수 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_ExPYEVQ" src="//codepen.io/anon/embed/ExPYEVQ?height=450&amp;theme-id=1&amp;slug-hash=ExPYEVQ&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed ExPYEVQ" title="CodePen Embed ExPYEVQ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

색상 모드 클래스 중 하나를 적용할 때마다 배경 및 색상 속성이 재설정된 다음 중첩된 제목과 단락으로 상속됩니다. 우리의 주요 맥락에서 색은 `.light` 클래스에서 상속되는 반면, 내포된 제목과 단락은 `.dark` 클래스에서 상속된다. 상속은 직접 계보를 기반으로 하므로 정의된 값을 가진 가장 가까운 상위 항목이 우선합니다. 우리는 그것을 근접이라고 부른다.

상속은 근접성이 중요하지만, 특정성에 의존하는 선택자에게는 영향이 없다. 만약 우리가 어두운 색이나 밝은 색 용기 안에서 무언가를 스타일링하고 싶다면 그것은 문제가 된다.

여기서는 밝기 및 어두운 버튼의 변형을 모두 정의하려고 했습니다. 라이트 모드 버튼은 흰색 텍스트로 `리베커플`을, 다크 모드 버튼은 검은색 텍스트로 `플럼`을 사용해야 한다. 밝고 어두운 컨텍스트를 기준으로 직접 버튼을 선택하고 있지만 작동하지 않습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_NWxKYRN" src="//codepen.io/anon/embed/NWxKYRN?height=450&amp;theme-id=1&amp;slug-hash=NWxKYRN&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed NWxKYRN" title="CodePen Embed NWxKYRN" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

버튼 중 일부는 .light와 .dark 조상을 모두 포함하는 두 가지 맥락에 있다. 이 경우 우리가 원하는 것은 가장 가까운 테마(상속 근접 동작)가 이어받기를 원하지만, 대신 두 번째 셀렉터가 첫 번째 셀렉터(캐스케이드 동작)보다 우선하는 것입니다. 두 셀렉터가 동일한 특수성을 가지므로, 소스 순서가 승자를 결정합니다.

### 사용자 지정 속성 및 근접성

여기서 우리에게 필요한 것은 테마로부터 이러한 속성을 이어받지만 특정 아이들에게만 적용할 수 있는 방법입니다. 사용자 지정 속성을 사용하면 가능합니다! 밝은 색 및 어두운 색 컨테이너에 값을 정의하는 동시에 버튼과 같은 중첩된 요소에 대한 상속된 값만 사용할 수 있습니다.

먼저 사용자 지정 속성을 사용하도록 버튼을 설정하여 해당 속성이 정의되지 않은 경우 폴백 "기본값" 값을 사용합니다.

```css
button {
  background: var(--btn-color, rebeccapurple);
  color: var(--btn-contrast, white);
}
```

이제 이러한 값을 컨텍스트에 따라 설정할 수 있으며, 근접성과 상속을 기반으로 적절한 상위 항목으로 범위를 지정할 수 있습니다.

```css
.dark {
  --btn-color: plum;
  --btn-contrast: black;
}

.light {
  --btn-color: rebeccapurple;
  --btn-contrast: white;
}
```

추가 보너스로, 우리는 전체적으로 더 적은 코드를 사용하고 하나의 통합된 `버튼` 정의를 사용하고 있다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_QWyLrdr" src="//codepen.io/anon/embed/QWyLrdr?height=450&amp;theme-id=1&amp;slug-hash=QWyLrdr&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed QWyLrdr" title="CodePen Embed QWyLrdr" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

저는 이것을 버튼 컴포넌트에 사용 가능한 파라미터의 API를 만드는 것으로 생각합니다. Sara Soueidan과 Lea Verou는 최근 기사에서 이 점을 잘 다루었다.

### 구성요소 소유권

때로는 근접성이 범위를 정의하기에 충분하지 않습니다. 자바스크립트 프레임워크가 "범위 지정 스타일"을 생성할 때 특정 객체 요소 소유권을 설정한다. 탭 레이아웃 구성요소는 탭을 소유하지만 각 탭 뒤의 내용은 소유하지 않습니다. 이것은 BEM 협약이 복잡한 .block__lement 클래스 이름을 캡처하려고 시도하는 것이기도 하다.

니콜 설리반은 2011년에 이 문제에 대해 말하기 위해 "도넛 스코프"라는 용어를 만들었다. 저는 그녀가 그 문제에 대해 최근 생각을 가지고 있다고 확신하지만, 근본적인 문제는 바뀌지 않았습니다. 선택기와 특수성은 넓은 패턴 위에 세밀한 스타일을 구축하는 방법을 설명하는 데 매우 유용하지만, 명확한 소유 의식을 전달하지는 못합니다.

이 문제를 해결하기 위해 사용자 지정 속성 스택을 사용할 수 있습니다. 먼저 기본 색상에 해당하는 `<` 요소에 "글로벌" 속성을 만듭니다.

```css
html {
  --background--global: white;
  --color--global: black;
  --btn-color--global: rebeccapurple;
  --btn-contrast--global: white;
}
```

기본 글로벌 테마는 이제 참조할 수 있는 모든 곳에서 사용할 수 있습니다. 우리는 우리의 전경과 배경색을 적용하는 데이터 테마 속성을 가지고 그것을 할 것이다. 글로벌 값이 기본 폴백(fallback)을 제공하기를 원하지만 특정 테마로 재정의되는 옵션도 원합니다. 바로 여기에 "스택스"가 있습니다.

```css
[data-theme] {
  /* If there's no component value, use the global value */
  background: var(--background--component, var(--background--global));
  color: var(--color--component, var(--color--global));
}
```

이제 `*-구성 요소` 속성을 전역 속성의 반대로 설정하여 반전 구성 요소를 정의할 수 있습니다.

```css
[data-theme='invert'] {
  --background--component: var(--color--global);
  --color--component: var(--background--global);
}
```

그러나 이러한 설정이 소유의 도넛을 넘어 상속되는 것을 원치 않기 때문에 모든 테마에서 이 값을 초기값(정의되지 않음)으로 재설정합니다. 이 작업은 더 낮은 사양 또는 원본 순서보다 일찍 수행되므로 각 테마가 재정의할 수 있는 기본값을 제공합니다.

```css
[data-theme] {
  --background--component: initial;
  --color--component: initial;
}
```

초기` 키워드는 사용자 지정 속성에 사용할 때 특별한 의미를 가지며, 이 키워드를 보증됨-잘못된 상태로 되돌립니다. 즉, 사용자 지정 속성이 "background: initial" 또는 "color: initial"을 설정하는 대신 "definition되지 않음"이 되어 스택의 다음 값인 글로벌 설정으로 돌아갑니다.

버튼도 똑같이 할 수 있고, 각 부품에 반드시 데이터 테마를 적용할 수 있다. 특정 테마가 지정되지 않은 경우 각 구성 요소는 글로벌 테마로 기본 설정됩니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_VweaPGp" src="//codepen.io/anon/embed/VweaPGp?height=450&amp;theme-id=1&amp;slug-hash=VweaPGp&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed VweaPGp" title="CodePen Embed VweaPGp" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 오리진 정의

CSS 캐스케이드(CSS cascade)는 동일한 속성에 다중 값이 정의될 때 어떤 값이 우선해야 하는지를 결정하는 데 사용되는 일련의 필터링 계층이다. 우리는 종종 특이성 계층 또는 소스 순서에 기초한 최종 계층과 상호작용하지만, 캐스케이드 첫 번째 계층은 스타일의 "원점"이다. 오리진에는 브라우저(기본값), 사용자(기본 설정) 또는 작성자(우리) 등 스타일이 어디에서 왔는지 설명합니다.

기본적으로 작성자 스타일은 브라우저 기본값을 재정의하는 사용자 환경설정을 무시합니다. 누구나 스타일에 `!중요`를 적용하면 그 기원이 바뀌는데, 브라우저 `!중요` 스타일은 그 기원이 가장 높고, 그 다음에 중요한 사용자 선호도가 높으며, 그 다음에 우리의 작가인 중요한 스타일은 모든 일반적인 레이어보다 더 높다. 몇 가지 추가 출처가 있지만, 여기서는 다루지 않겠습니다.

사용자 지정 속성 "stacks"를 생성할 때 우리는 매우 유사한 동작을 만듭니다. 기존 기원을 사용자 지정 속성 스택으로 표현하려면 다음과 같은 모양이 됩니다.

```css
.origins-as-custom-properties {
  color: var(--browser-important, var(--user-important, var(--author-important, var(--author, var(--user, var(--browser))))));
}
```

이러한 계층은 이미 존재하므로 다시 생성할 이유가 없습니다. 하지만 위의 "글로벌" 스타일과 "구성 요소" 스타일을 계층화하면 "글로벌" 계층을 재정의하는 "구성 요소" 오리진 계층을 만들 수 있습니다. 이와 같은 접근 방식은 CSS의 다양한 계층화 문제를 해결하는 데 사용될 수 있으며, 이는 항상 특수성으로 설명될 수 없다.

- → 구성요소 → 테마 → 기본값 재정의
- 테마 → 설계 시스템 또는 프레임워크
- 상태 → 유형 → 기본값

버튼을 다시 봅시다. 기본 버튼 스타일, 비활성화 상태, 위험, 기본, 보조 등 다양한 버튼 유형이 필요합니다. 우리는 `사용불가능` 상태가 항상 유형 변동을 재정의하는 것을 원하지 않지만, 선택기가 다음과 같은 구별을 포착하지는 않습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_abdoYLa" src="//codepen.io/anon/embed/abdoYLa?height=450&amp;theme-id=1&amp;slug-hash=abdoYLa&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed abdoYLa" title="CodePen Embed abdoYLa" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

그러나 "유형" 계층과 "상태" 계층을 모두 우선 순위에 따라 제공하는 스택을 정의할 수 있습니다.

```css
button {
  background: var(--btn-state, var(--btn-type, var(--btn-default)));
}
```

이제 두 변수를 모두 설정하면 상태가 항상 우선합니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_abdNWwa" src="//codepen.io/anon/embed/abdNWwa?height=450&amp;theme-id=1&amp;slug-hash=abdNWwa&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed abdNWwa" title="CodePen Embed abdNWwa" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이 기술을 사용하여 레이어링에 따라 테스팅을 사용자 정의할 수 있는 Cascading Colors 프레임워크를 만들었습니다.

- HTML에서 미리 정의된 테마 속성
- 사용자 색 기본 설정
- 명암 모드
- 글로벌 테마 기본값

이러한 접근방식은 극단적으로 적용될 수 있지만, 대부분의 일상적인 사용 사례는 종종 위의 기술을 조합하여 두세 개의 값을 스택에서 처리할 수 있다.

- 도면층을 정의하는 변수 스택
- 근접성 및 범위를 기준으로 설정하기 위한 상속
- 중첩 요소를 스코프에서 제거하기 위해 `초기` 값을 주의 깊게 적용

OddBird의 프로젝트에 이러한 맞춤형 자산을 사용하고 있습니다. 우리는 여전히 계속 발견을 하고 있지만, 그것들은 이미 선택기와 특수성만을 사용하여 어려운 문제를 해결하는 데 도움이 되었습니다. 맞춤형 숙박시설로, 우리는 캐스케이드나 상속과 싸울 필요가 없습니다. 우리는 각 인스턴스에 어떻게 적용해야 하는지에 대한 더 많은 제어권을 가지고 그것들을 의도한 대로 포착하고 활용할 수 있다. 특히 스타일 프레임워크, 툴 및 시스템을 개발할 때 CSS가 큰 성공을 거두었습니다.