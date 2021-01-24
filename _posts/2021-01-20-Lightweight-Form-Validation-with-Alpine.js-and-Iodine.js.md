---
layout: post
title: "Alpine.js 및 Iodine.js를 사용한 경량 양식 유효성 검사"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/04/alpinejs.png
tags: ALPINE.JS,FORM VALIDATION,IODINE
---


요즘 많은 사용자가 양식 유효성 검사에서 즉각적인 피드백을 기대합니다.
 작은 정적 사이트 나 서버 렌더링 Rails 또는 Laravel 앱을 구축 할 때 이러한 수준의 상호 작용을 어떻게 달성합니까?
 Alpine.js 및 Iodine.js는 기술적 부채가 거의없고 페이지로드 시간에 거의 영향을 미치지 않는 고도의 대화 형 양식을 만드는 데 사용할 수있는 두 개의 최소 JavaScript 라이브러리입니다.
 이와 같은 라이브러리를 사용하면 아키텍처를 복잡하게 만들 수있는 빌드 단계의 무거운 JavaScript 도구를 사용할 필요가 없습니다.

이 두 라이브러리의 API를 설명하기 위해 몇 가지 버전의 양식 유효성 검사를 반복 할 것입니다.
 완성 된 제품을 복사하여 붙여 넣으려면 여기에 우리가 만들 것입니다.
 누락되거나 잘못된 입력을 가지고 놀아보고 양식이 어떻게 반응하는지 확인하십시오.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 775px;"><iframe id="cp_embed_yLaYNbG" src="//codepen.io/anon/embed/yLaYNbG?height=775&amp;theme-id=1&amp;slug-hash=yLaYNbG&amp;default-tab=result" height="775" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed yLaYNbG" title="CodePen Embed yLaYNbG" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 도서관 둘러보기

자세히 알아보기 전에 사용중인 도구에 대해 알아 두는 것이 좋습니다.

Alpine은 CDN에서 프로젝트로 가져 오도록 설계되었습니다.
 빌드 단계, 번 들러 구성 및 종속성이 없습니다.
 문서화를 위해 짧은 GitHub`README` 만 필요합니다.
 압축 및 gzip 압축 된 8.36KB에 불과한이 크기는 create-react-app hello world 크기의 약 5 분의 1입니다.
 Hugo Di Fracesco는 그것이 어떻게 작동하는지에 대한 완전하고 철저한 개요를 제공합니다.
 그의 초기 설명은 매우 훌륭합니다.

> Alpine.js는 React / Vue / Svelte / WhateverFramework 경쟁자가 아닌 Vue 템플릿 기반의 jQuery 및 바닐라 JavaScript를 대체합니다.

반면에 Iodine은 Laravel / Vue / Tailwind 세계에서 일하는 Matt Kingshott가 만든 마이크로 폼 유효성 검사 라이브러리입니다.
 요오드는 양식 유효성 검사 도우미로 모든 프런트 엔드 프레임 워크와 함께 사용할 수 있습니다.
 이를 통해 여러 규칙으로 단일 데이터의 유효성을 검사 할 수 있습니다.
 또한 Iodine은 유효성 검사가 실패 할 때 합리적인 오류 메시지를 반환합니다.
 요오드의 원인을 설명하는 Matt의 블로그 게시물에서 자세한 내용을 읽을 수 있습니다.

### 요오드가 어떻게 작용하는지 간단히 살펴보기

다음은 요오드를 사용한 매우 기본적인 클라이언트 측 양식 유효성 검사입니다.
 양식이 제출 될 때 수신 할 바닐라 자바 스크립트를 작성한 다음 DOM 메서드를 사용하여 입력을 매핑하여 각 입력 값을 확인합니다.
 잘못된 경우 잘못된 입력에 "유효하지 않은"클래스를 추가하고 양식 제출을 방지합니다.

이 예에서는이 CDN 링크에서 요오드를 가져옵니다.

<pre rel="HTML" class="wp-block-csstricks-code-block  language-html" data-line=""><code markup="tt" class=" language-html">`&lt;script src="https://cdn.jsdelivr.net/gh/mattkingshott/iodine@3/dist/iodine.min.js" defer&gt;&lt;/script&gt;`</code></pre>

또는 Skypack을 사용하여 프로젝트로 가져올 수 있습니다.

<pre rel="JavaScript" class="wp-block-csstricks-code-block  language-javascript" data-line=""><code markup="tt" class=" language-javascript">`import kingshottIodine from "https://cdn.skypack.dev/@kingshott/iodine";`</code></pre>

Skypack에서 Iodine을 가져올 때 `kingshottIodine`을 가져와야합니다.
 이것은 여전히 우리의 global / window 범위에 `요오드`를 추가합니다.
 사용자 코드에서 라이브러리를 `Iodine`으로 계속 참조 할 수 있지만 Skypack에서 가져 오는 경우 `kingshottIodine`을 가져와야합니다.

각 입력을 확인하기 위해 Iodine에서`is` 메소드를 호출합니다.
 입력 값을 첫 번째 매개 변수로 전달하고 문자열 배열을 두 번째 매개 변수로 전달합니다.
 이러한 문자열은 입력이 유효하기 위해 따라야하는 규칙입니다.
 기본 제공 규칙 목록은 Iodine 문서에서 찾을 수 있습니다.

Iodine의 `is`메소드는 값이 유효하면 `true`를 반환하고 검사가 실패하면 실패한 규칙을 나타내는 문자열을 반환합니다.
 즉, 함수의 출력에 반응 할 때 엄격한 비교를 사용해야합니다.
 그렇지 않으면 자바 스크립트는 문자열을 `true`로 평가합니다.
 우리가 할 수있는 일은 각 입력에 대한 규칙에 대한 문자열 배열을 HTML 데이터 속성에 JSON으로 저장하는 것입니다.
 이것은 Alpine 또는 Iodine에 내장되어 있지는 않지만 제약 조건과 함께 입력을 함께 배치하는 좋은 방법이라고 생각합니다.
 이렇게하려면 JSON을 작은 따옴표로 묶고 속성 내부에 큰 따옴표를 사용하여 JSON 사양을 따라야합니다.

HTML에서 이것이 어떻게 보이는지 다음과 같습니다.

<pre rel="HTML" class="wp-block-csstricks-code-block  language-html" data-line=""><code markup="tt" class=" language-html">`&lt;input name="email" type="email" id="email" data-rules='["required","email"]'&gt;`</code></pre>

각 입력의 유효성을 확인하기 위해 DOM을 통해 매핑 할 때 요소의 입력 값으로 `Iodine`함수를 호출 한 다음 입력의 `dataset.rules`의 `JSON.encode ()`결과를 호출합니다.
 바닐라 자바 스크립트 DOM 메소드를 사용하면 다음과 같습니다.

<pre rel="JavaScript" class="wp-block-csstricks-code-block  language-javascript" data-line=""><code markup="tt" class=" language-javascript">`let form = document.getElementById("form");<br><br>// This is a nice way of getting a list of checkable input elements<br>// And converting them into an array so we can use map/filter/reduce functions:<br>let inputs = [...form.querySelectorAll("input[data-rules]")];<br><br>function onSubmit(event) {<br>  inputs.map((input) =&gt; {<br>    if (Iodine.is(input.value, JSON.parse(input.dataset.rules)) !== true) {<br>      event.preventDefault();<br>      input.classList.add("invalid");<br>    }<br>  });<br>}<br>form.addEventListener("submit", onSubmit);`</code></pre>

이 매우 기본적인 구현은 다음과 같습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 775px;"><iframe id="cp_embed_xxEVXGy" src="//codepen.io/anon/embed/xxEVXGy?height=775&amp;theme-id=1&amp;slug-hash=xxEVXGy&amp;default-tab=result" height="775" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed xxEVXGy" title="CodePen Embed xxEVXGy" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

알 수 있듯이 이것은 훌륭한 사용자 경험이 아닙니다.
 가장 중요한 것은 사용자에게 제출물에 어떤 문제가 있는지 알려주지 않는다는 것입니다.
 또한 사용자는 잘못된 것이 있는지 확인하기 전에 양식이 제출 될 때까지 기다려야합니다.
 그리고 실망스럽게도 모든 입력은 사용자가 유효성 검사 규칙을 따르도록 수정 한 후에도 "유효하지 않은"클래스를 유지합니다.

### 알파인이 등장하는 곳입니다.

양식과 상호 작용하는 동안 좋은 사용자 피드백을 제공하기 위해 가져 와서 사용하겠습니다.

양식 유효성 검사를위한 좋은 옵션은 입력이 흐려 지거나 흐려진 후 변경 사항에 대해 유효성을 검사하는 것입니다.
 이렇게하면 사용자가 쓰기를 마치기 전에 소리를 지르지 않고 잘못된 입력을 남기거나 돌아가서 입력 값을 수정하는 경우 즉시 피드백을 제공합니다.

CDN에서 Alpine을 가져옵니다.

<pre rel="HTML" class="wp-block-csstricks-code-block  language-html" data-line=""><code markup="tt" class=" language-html">`&lt;script src="https://cdn.jsdelivr.net/gh/alpinejs/alpine@v2.7.3/dist/alpine.min.js" defer&gt;&lt;/script&gt;`</code></pre>

또는 Skypack을 사용하여 프로젝트로 가져올 수 있습니다.

<pre rel="JavaScript" class="wp-block-csstricks-code-block  language-javascript" data-line=""><code markup="tt" class=" language-javascript">`import alpinejs from "https://cdn.skypack.dev/alpinejs";`</code></pre>

이제 각 입력에 대해 유지해야하는 두 가지 상태 만 있습니다.

- 입력이 흐려 졌는지 여부
- 오류 메시지 (이 항목이 없으면 유효한 입력이 있음을 의미 함)

우리가 형태로 보여주는 유효성 검사는이 두 가지 상태의 함수가 될 것입니다.

Alpine을 사용하면 부모 요소의`x-data` 속성에 일반 JavaScript 객체를 선언하여 구성 요소에이 상태를 유지할 수 있습니다.
 이 상태는 상호 작용을 생성하기 위해 하위 요소에 의해 액세스되고 변경 될 수 있습니다.
 HTML을 깨끗하게 유지하기 위해 양식에 필요한 모든 데이터 및 / 또는 함수를 반환하는 JavaScript 함수를 선언 할 수 있습니다.
 Alpine은이 함수를`x-data` 속성에 추가하면 JavaScript 코드의 전역 / 창 범위에서이 함수를 찾습니다.
 또한 여러 구성 요소 또는 여러 프로젝트에서 동일한 기능을 사용할 수 있으므로 논리를 공유하는 재사용 가능한 방법을 제공합니다.

`errorMessage`에 대한 빈 문자열과 blur라는 부울이라는 두 가지 속성이있는 각 입력 필드의 개체를 보유하도록 양식 데이터를 초기화 해 보겠습니다.
 각 요소의 이름 속성을 키로 사용합니다.

<pre rel="HTML" class="wp-block-csstricks-code-block  language-html" data-line=""><code markup="tt" class=" language-html">`<br>&lt;form id="form" x-data="form()" action=""&gt;<br>  &lt;h1&gt;Log In&lt;/h1&gt;<br><br>  &lt;label for="username"&gt;Username&lt;/label&gt;<br>  &lt;input name="username" id="username" type="text" data-rules='["required"]'&gt;<br><br>  &lt;label for="email"&gt;Email&lt;/label&gt;<br>  &lt;input name="email" type="email" id="email" data-rules='["required","email"]'&gt;<br><br>  &lt;label for="password"&gt;Password&lt;/label&gt;<br>  &lt;input name="password" type="password" id="password" data-rules='["required","minimum:8"]'&gt;<br><br>  &lt;label for="passwordConf"&gt;Confirm Password&lt;/label&gt;<br>  &lt;input name="passwordConf" type="password" id="passwordConf" data-rules='["required","minimum:8"]'&gt;<br><br>  &lt;input type="submit"&gt;<br>&lt;/form&gt;`</code></pre>

여기에 데이터를 설정하는 기능이 있습니다.
 키는 입력의`name` 속성과 일치합니다.

<pre rel="JavaScript" class="wp-block-csstricks-code-block  language-javascript" data-line=""><code markup="tt" class=" language-javascript">`window.form = () =&gt; { <br>  return {<br>    username: {errorMessage:'', blurred:false},<br>    email: {errorMessage:'', blurred:false},<br>    password: {errorMessage:'', blurred:false},<br>    passwordConf: {errorMessage:'', blurred:false},<br>  }<br>}`</code></pre>

이제 입력에 Alpine의`x-bind : class` 속성을 사용하여 입력이 흐리게 처리되고 구성 요소 데이터의 요소에 대한 메시지가있는 경우 "잘못된"클래스를 추가 할 수 있습니다.
 사용자 이름 입력에 표시되는 방식은 다음과 같습니다.

<pre rel="HTML" class="wp-block-csstricks-code-block  language-html" data-line=""><code markup="tt" class=" language-html">`&lt;input name="username" id="username" type="text" <br>x-bind:class="{'invalid':username.errorMessage &amp;&amp; username.blurred}" data-rules='["required"]'&gt;`</code></pre>

### 입력 변경에 응답

이제 입력 변경 및 흐리게 입력 상태에 응답 할 양식이 필요합니다.
 이벤트 리스너를 추가하여이를 수행 할 수 있습니다.
 Alpine은`x-on`을 사용하거나 Vue와 유사하게`@`기호를 사용할 수있는 간결한 API를 제공합니다.
 이들을 선언하는 두 가지 방법 모두 동일한 방식으로 작동합니다.

입력 이벤트에서 값이 유효하지 않은 경우 구성 요소 데이터의 `오류 메시지`를 오류 메시지로 변경해야합니다.
 그렇지 않으면 빈 문자열로 만듭니다.

`blur`이벤트에서 우리는 블러 링 된 요소의 이름과 일치하는 키를 가진 객체에서 `blurred`속성을 `true`로 설정해야합니다.
 또한 오류 메시지로 초기화 한 빈 문자열을 사용하지 않도록 오류 메시지를 다시 계산해야합니다.

따라서 흐리게 및 입력 변경에 반응하기 위해 양식에 두 가지 함수를 더 추가하고 이벤트 대상의 `name`값을 사용하여 변경할 구성 요소 데이터의 부분을 찾습니다.
 이러한 함수를`form ()`함수가 반환하는 객체의 속성으로 선언 할 수 있습니다.

다음은 이벤트 리스너가 연결된 사용자 이름 입력에 대한 HTML입니다.

<pre rel="JavaScript" class="wp-block-csstricks-code-block  language-javascript" data-line=""><code markup="tt" class=" language-javascript">`&lt;input <br>  name="username" id="username" type="text"<br>  x-bind:class="{'invalid':username.errorMessage &amp;&amp; username.blurred}" <br>  @blur="blur" @input="input"<br>  data-rules='["required"]'<br>&gt;`</code></pre>

그리고 이벤트 리스너에 응답하는 함수가있는 JavaScript :

<pre rel="JavaScript" class="wp-block-csstricks-code-block  language-javascript" data-line=""><code markup="tt" class=" language-javascript">`window.form = () =&gt; {<br>  return {<br>    username: {errorMessage:'', blurred:false},<br>    email: {errorMessage:'', blurred:false},<br>    password:{ errorMessage:'', blurred:false},<br>    passwordConf: {errorMessage:'', blurred:false},<br>    blur: function(event) {<br>      let ele = event.target;<br>      this[ele.name].blurred = true;<br>      let rules = JSON.parse(ele.dataset.rules)<br>      this[ele.name].errorMessage = this.getErrorMessage(ele.value, rules);<br>    },<br>    input: function(event) {<br>      let ele = event.target;<br>      let rules = JSON.parse(ele.dataset.rules)<br>      this[ele.name].errorMessage = this.getErrorMessage(ele.value, rules);<br>    },<br>    getErrorMessage: function() {<br>    // to be completed<br>    }<br>  }<br>}`</code></pre>

### 오류 가져 오기 및 표시

다음으로`getErrorMessage` 함수를 작성해야합니다.

Iodine 검사가 `true`를 반환하면 `errorMessage`속성을 빈 문자열로 설정합니다.
 그렇지 않으면 위반 된 규칙을 다른 Iodine 메서드 인`getErrorMessage`로 전달합니다.
 사람이 읽을 수있는 메시지를 반환합니다.
 다음과 같이 표시됩니다.

<pre rel="JavaScript" class="wp-block-csstricks-code-block  language-javascript" data-line=""><code markup="tt" class=" language-javascript">`getErrorMessage:function(value, rules){<br>  let isValid = Iodine.is(value, rules);<br>  if (isValid !== true) {<br>    return Iodine.getErrorMessage(isValid);<br>  }<br>  return '';<br>}`</code></pre>

이제 사용자에게 오류 메시지도 표시해야합니다.

각 입력 아래에`error-message` 클래스가있는`<p>`태그를 추가해 보겠습니다.
 이러한 요소에`x-show`라는 또 다른 Alpine 속성을 사용하여 오류 메시지가있을 때만 표시 할 수 있습니다.
 `x-show` 속성은 Alpine이 JavaScript 표현식이`true`로 확인되는지 여부에 따라 요소에서`display : none;`을 토글하도록합니다.
 입력의`show-invalid` 클래스에서 사용한 것과 동일한 표현식을 사용할 수 있습니다.

텍스트를 표시하기 위해 오류 메시지를`x-text`와 연결할 수 있습니다.
 그러면 구성 요소 상태를 사용할 수있는 JavaScript 표현식에`innertext`가 자동으로 바인딩됩니다.
 다음과 같이 표시됩니다.

<pre rel="HTML" class="wp-block-csstricks-code-block  language-html" data-line=""><code markup="tt" class=" language-html">`&lt;p x-show="username.errorMessage &amp;&amp; username.blurred" x-text="username.errorMessage" class="error-message"&gt;&lt;/p&gt;`</code></pre>

마지막으로 할 수있는 일은 Alpine을 가져 오기 전의`onsubmit` 코드를 재사용하는 것입니다.하지만 이번에는`@ submit`을 사용하여 양식 요소에 이벤트 리스너를 추가하고 구성 요소에서`submit` 함수를 사용할 수 있습니다.
 데이터.
 Alpine은`$ el`을 사용하여 컴포넌트 상태를 유지하는 부모 요소를 참조 할 수 있습니다.
 즉, 더 긴 DOM 메서드를 작성할 필요가 없습니다.

<pre rel="HTML" class="wp-block-csstricks-code-block  language-html" data-line=""><code markup="tt" class=" language-html">`&lt;form id="form" x-data="form()" @submit="submit" action=""&gt;<br>  &lt;!-- inputs...  --&gt;<br>&lt;/form&gt;`</code></pre>

<pre rel="JavaScript" class="wp-block-csstricks-code-block  language-javascript" data-line=""><code markup="tt" class=" language-javascript">`submit: function (event) {<br>  let inputs = [...this.$el.querySelectorAll("input[data-rules]")];<br>  inputs.map((input) =&gt; {<br>    if (Iodine.is(input.value, JSON.parse(input.dataset.rules)) !== true) {<br>      event.preventDefault();<br>    }<br>  });<br>}`</code></pre>

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 775px;"><iframe id="cp_embed_VwKaMmo" src="//codepen.io/anon/embed/VwKaMmo?height=775&amp;theme-id=1&amp;slug-hash=VwKaMmo&amp;default-tab=result" height="775" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed VwKaMmo" title="CodePen Embed VwKaMmo" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이것은 거기에 도착합니다

- 입력이 수정되면 실시간 피드백을받습니다.
- Google 양식은 사용자가 양식을 제출하기 전과 입력 내용을 흐리게 처리 한 후에 만 문제에 대해 알려줍니다.
- 유효하지 않은 속성이 있으면 양식이 제출되지 않습니다.

### 서버 측 렌더링 된 앱의 클라이언트 측에서 유효성 검사

이 버전에는 여전히 몇 가지 문제가 있지만 일부는 서버와 관련되어 있으므로 Pen에서 즉시 명확하지 않습니다.
 예를 들어 서버 측 렌더링 된 앱에서 클라이언트 측의 모든 오류를 확인하는 것은 어렵습니다.
 이메일 주소가 이미 사용중인 경우 어떻게합니까?
 아니면 복잡한 데이터베이스 레코드를 확인해야합니까?
 양식에는 서버에서 발견 된 오류를 표시하는 방법이 있어야합니다.
 AJAX로이를 수행하는 방법이 있지만 더 가벼운 솔루션을 살펴 보겠습니다.

각 입력의 다른 JSON 배열 데이터 속성에 서버 측 오류를 저장할 수 있습니다.
 대부분의 백엔드 프레임 워크는이를 수행하는 합리적으로 쉬운 방법을 제공합니다.
 `x-init`라는 또 다른 Alpine 속성을 사용하여 구성 요소가 초기화 될 때 함수를 실행할 수 있습니다.
 이 함수에서 DOM의 서버 측 오류를 각 입력의 구성 요소 데이터로 가져올 수 있습니다.
 그런 다음`getErrorMessage` 함수를 업데이트하여 서버 오류가 있는지 확인하고이를 먼저 반환 할 수 있습니다.
 존재하지 않는 경우 클라이언트 측 오류를 확인할 수 있습니다.

<pre rel="HTML" class="wp-block-csstricks-code-block  language-html" data-line=""><code markup="tt" class=" language-html">`&lt;input name="username" id="username" type="text" <br>x-bind:class="{'invalid':username.errorMessage &amp;&amp; username.blurred}" <br>@blur="blur" @input="input" data-rules='["required"]' <br>data-server-errors='["Username already in use"]'&gt;`</code></pre>

그리고 서버 측 오류가 전체 시간 동안 표시되지 않도록 사용자가 수정을 시작한 후에도 입력이 변경 될 때마다 빈 배열로 교체합니다.

init 함수는 다음과 같습니다.

<pre rel="JavaScript" class="wp-block-csstricks-code-block  language-javascript" data-line=""><code markup="tt" class=" language-javascript">`init: function () {<br>  this.inputElements = [...this.$el.querySelectorAll("input[data-rules]")];<br>  this.initDomData();<br>},<br>initDomData: function () {<br>  this.inputElements.map((ele) =&gt; {<br>  this[ele.name] = {<br>    serverErrors: JSON.parse(ele.dataset.serverErrors),<br>    blurred: false<br>    };<br>  });<br>}`</code></pre>

### 상호 의존적 입력 처리

일부 양식 입력은 유효성을 위해 다른 것에 의존 할 수 있습니다.
 예를 들어 암호 확인 입력은 확인중인 암호에 따라 달라집니다.
 또는 작업을 시작한 날짜는 생년월일 필드보다 늦게 값을 보유해야합니다.
 즉, 입력이 변경 될 때마다 양식의 모든 입력을 확인하는 것이 좋습니다.

모든 입력 요소를 통해 매핑하고 모든 입력 및 흐림 이벤트에 대한 상태를 설정할 수 있습니다.
 이렇게하면 서로 의존하는 입력이 오래된 데이터를 사용하지 않는다는 것을 알 수 있습니다.

이를 테스트하기 위해 비밀번호 확인을위한`matchingPassword` 규칙을 추가해 보겠습니다.
 요오드는`addRule` 메소드로 새로운 사용자 지정 규칙을 추가 할 수 있습니다.

<pre rel="JavaScript" class="wp-block-csstricks-code-block  language-javascript" data-line=""><code markup="tt" class=" language-javascript">`Iodine.addRule(<br>  "matchingPassword",<br>  value =&gt; value === document.getElementById("password").value<br>);`</code></pre>

이제 Iodine의`messages` 속성에 키를 추가하여 사용자 지정 오류 메시지를 설정할 수 있습니다.

<pre rel="JavaScript" class="wp-block-csstricks-code-block  language-javascript" data-line=""><code markup="tt" class=" language-javascript">`Iodine.messages.matchingPassword="Password confirmation needs to match password";`</code></pre>

이 규칙을 설정하기 위해`init` 함수에이 두 호출을 모두 추가 할 수 있습니다.

이전 구현에서는 "비밀번호"필드를 변경했을 수 있으며 "비밀번호 확인"필드를 유효하지 않게 만들지 않았습니다.
 하지만 이제 모든 변경 사항에 대한 모든 입력을 매핑하고 있으므로 양식은 항상 비밀번호와 비밀번호 확인이 일치하는지 확인합니다.

### 마무리 작업

우리가 할 수있는 작은 리 팩터 중 하나는 `getErrorMessage`함수가 입력이 흐릿한 경우에만 메시지를 반환하도록 만드는 것입니다. 이렇게하면 입력을 무효화할지 여부를 결정하기 전에 하나의 값만 확인하면되므로 HTML을 약간 더 짧게 만들 수 있습니다.
 이것은 우리의`x-bind` 속성이 다음과 같이 짧을 수 있음을 의미합니다.

<pre rel="HTML" class="wp-block-csstricks-code-block  language-html" data-line=""><code markup="tt" class=" language-html">`x-bind:class="{'invalid':username.errorMessage}"`</code></pre>

다음은 입력을 통해 매핑하고`errorMessage` 데이터를 설정하는 함수의 모습입니다.

<pre rel="JavaScript" class="wp-block-csstricks-code-block  language-javascript" data-line=""><code markup="tt" class=" language-javascript">`updateErrorMessages: function () {<br>  // Map through the input elements and set the 'errorMessage'<br>  this.inputElements.map((ele) =&gt; {<br>    this[ele.name].errorMessage = this.getErrorMessage(ele);<br>  });<br>},<br>getErrorMessage: function (ele) {<br>  // Return any server errors if they're present<br>  if (this[ele.name].serverErrors.length &gt; 0) {<br>    return input.serverErrors[0];<br>  }<br>  // Check using Iodine and return the error message only if the element has not been blurred<br>  const error = Iodine.is(ele.value, JSON.parse(ele.dataset.rules));<br>  if (error !== true &amp;&amp; this[ele.name].blurred) {<br>    return Iodine.getErrorMessage(error);<br>  }<br>  // Return empty string if there are no errors<br>  return "";<br>},`</code></pre>

부모 양식 요소에서 이러한 이벤트를 수신하여 모든 입력에서`@ blur` 및`@ input` 이벤트를 제거 할 수도 있습니다.
 그러나 이것에 문제가 있습니다.`blur` 이벤트는 버블 링되지 않습니다 (이 이벤트를 수신하는 부모 요소는 자식에서 발생할 때 전달되지 않습니다).
 다행히도 blur를 기본적으로 동일한 이벤트 인 `focusout`이벤트로 대체 할 수 있지만이 이벤트는 거품이 발생하므로 부모 요소 형식에서 수신 할 수 있습니다.

마지막으로, 우리 코드는 많은 상용구를 증가시키고 있습니다.
 입력 이름을 변경하려면 매번 함수의 데이터를 다시 작성하고 새 이벤트 리스너를 추가해야합니다.
 매번 구성 요소 데이터를 다시 쓰지 않도록`data-rules` 속성이있는 양식의 입력을 통해 매핑하여`init` 함수에서 초기 구성 요소 데이터를 생성 할 수 있습니다.
 이렇게하면 추가 양식에 코드를 더 재사용 할 수 있습니다.
 우리가해야 할 일은 자바 스크립트를 포함하고 규칙을 데이터 속성으로 추가하기 만하면됩니다.

아, 그리고 Alpine으로하기가 너무 쉽기 때문에 오류 메시지에주의를 기울이는 페이드 인 전환을 추가해 보겠습니다.

<pre rel="HTML" class="wp-block-csstricks-code-block  language-html" data-line=""><code markup="tt" class=" language-html">`&lt;p class="error-message" x-show.transition.in="username.errorMessage" x-text="username.errorMessage"&gt;&lt;/p&gt;`</code></pre>

그리고 여기에 최종 결과가 있습니다.
 최소한의 페이지로드 비용으로 반응적이고 재사용 가능한 양식 유효성 검사.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 775px;"><iframe id="cp_embed_yLaYNbG" src="//codepen.io/anon/embed/yLaYNbG?height=775&amp;theme-id=1&amp;slug-hash=yLaYNbG&amp;default-tab=result" height="775" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed yLaYNbG" title="CodePen Embed yLaYNbG" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이를 자신의 애플리케이션에서 사용하려면`form` 함수를 복사하여 우리가 작성한 모든 로직을 재사용 할 수 있습니다.
 HTML 속성을 구성하기 만하면 바로 사용할 수 있습니다.