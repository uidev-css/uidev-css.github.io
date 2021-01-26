---
layout: post
title: "세부 요소의 스타일을 지정하는 두 가지 문제 및 해결 방법"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2021/01/details-summary-issues.jpg
tags: DETAILS/SUMMARY
---


그리 멀지 않은 과거에는 기본적인 아코디언과 같은 상호 작용에도 JavaScript 이벤트 리스너 나 CSS… 속임수가 필요했습니다.
 그리고 사용 된 솔루션에 따라 기본 HTML 편집이 복잡해질 수 있습니다.

이제`<details>`및`<summary>`요소 (결합하여 `공개 위젯`이라고 함)가 이러한 구성 요소의 생성 및 유지 관리를 비교적 간단하게 만들었습니다.

제 직장에서 우리는 자주 묻는 질문과 같은 것에 사용합니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/s_FC84367ED1BBCDA1AEB8810DE2D2DB22AB8E788D8AA725E57A592022FD7C64CC_1598805119030_image.png?resize=691%2C252&ssl=1)

### 고려해야 할 몇 가지 문제가 있습니다.

확장 및 축소 상호 작용이 이미`<details>`및`<summary>`HTML 태그에 포함되었으므로 이제 JavaScript 또는 CSS없이 공개 위젯을 만들 수 있습니다.
 그러나 여전히 일부를 원할 수 있습니다.
 스타일이 지정되지 않은`<details>`공개 위젯은 두 가지 문제를 제시합니다.

`<summary>`섹션은 상호 작용을 초대하지만 요소의 기본 커서는 예상 할 수있는 가리키는 손가락이 아닌 텍스트 선택 아이콘입니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2021/01/s_337AEA1AD6EBFD16B84BDF2D9E44CAED940FDE1EB7F05F648F43401932D4350B_1607716879577_CursorDemo.png?resize=420%2C80&ssl=1)

`<summary>`요소 안에 블록 수준 요소 (예 : 제목)를 중첩하면 해당 콘텐츠를 인라인으로 유지하는 대신 화살표 마커 아래로 밀어 넣습니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2021/01/s_337AEA1AD6EBFD16B84BDF2D9E44CAED940FDE1EB7F05F648F43401932D4350B_1607717448427_SummaryHeader.png?resize=420%2C119&ssl=1)

이러한 문제를 해결하기 위해 스타일 시트의 재설정 섹션에 다음 두 가지 스타일을 추가 할 수 있습니다.

```css
details summary { 
  cursor: pointer;
}

details summary > * {
  display: inline;
}
```

각 문제와 해당 솔루션에 대해 자세히 알아보십시오.

### `<summary>`커서 값 변경

사용자가 페이지의 요소 위로 마우스를 가져 가면 항상 "해당 요소에 대한 예상 사용자 상호 작용을 반영하는"커서가 표시되기를 원합니다.

우리는`<summary>`요소가 상호 작용 적이지만 (링크 또는 양식 버튼과 같이) 기본 커서는 일반적으로 이러한 요소에 대해 보는 포인팅 핑거가 아니라는 사실에 대해 간략히 설명했습니다.
 대신, 우리는 일반적으로 페이지에서 텍스트를 입력하거나 선택할 때 기대하는`text` 커서를 얻습니다.

이 문제를 해결하려면 커서 값을 `포인터`로 전환하세요.

```css
details summary { 
  cursor: pointer;
}
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_MWyvxOb" src="//codepen.io/anon/embed/MWyvxOb?height=450&amp;theme-id=1&amp;slug-hash=MWyvxOb&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed MWyvxOb" title="CodePen Embed MWyvxOb" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

일부 주목할만한 사이트는`<details>`요소의 스타일을 지정할 때 이미이 속성을 포함하고 있습니다.
 요소 자체의 MDN 웹 문서 페이지가 정확히이를 수행합니다.
 GitHub는 또한 리포지토리를보고, 별표 표시하고, 분기하는 작업과 같은 특정 항목에 대해 공개 위젯을 사용합니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2021/01/s_337AEA1AD6EBFD16B84BDF2D9E44CAED940FDE1EB7F05F648F43401932D4350B_1608233600043_image.png?resize=417%2C82&ssl=1)

사용자가 요약 텍스트 (나머지 공개 위젯의 콘텐츠와 함께)를 선택할 수 있음을 나타 내기 위해 기본`cursor : text` 값이 선택되었다고 생각합니다.
 하지만 대부분의 경우`<summary>`요소가 상호 작용적임을 나타내는 것이 더 중요하다고 생각합니다.

요약 텍스트는 커서 값을 `텍스트`에서 `포인터`로 변경 한 후에도 계속 선택할 수 있습니다.
 커서를 변경하면 기능이 아닌 모양에만 영향을줍니다.

### 중첩 된`<summary>`내용을 인라인으로 표시

이전에 공유 한 FAQ 항목의 각`<summary>`섹션에서 일반적으로 페이지 개요에 따라 적절한 제목 태그로 질문을 묶습니다.

```html
<details>
  <summary>
    <h3>Will my child's 504 Plan be implemented?</h3>
  </summary>
  <p>Yes. Similar to the Spring, case managers will reach out to students.</p>
</details>
```

`<summary>`안에 제목을 중첩하면 다음과 같은 몇 가지 이유로 도움이 될 수 있습니다.

- 일관된 시각적 스타일.
 내 페이지의 다른 제목처럼 보이는 FAQ 질문이 마음에 듭니다.
- 제목을 사용하면`<details>`요소를 지원하지 않는 Internet Explorer 및 Chrome 이전 버전의 Edge 사용자에게 페이지 구조가 유효하게 유지됩니다.
 (이러한 브라우저에서 이러한 콘텐츠는 대화 형이 아닌 항상 표시됩니다.)
- 적절한 제목은 보조 기술 사용자가 페이지 내에서 탐색하는 데 도움이 될 수 있습니다.
 (즉,`<summary>`요소 내의 제목은 아래에 자세히 설명 된 것처럼 고유 한 경우를 나타냅니다. 일부 스크린 리더는 이러한 제목을 그대로 해석하지만 다른 것은 그렇지 않습니다.)

`<summary>`요소는 약간 이상한 오리라는 것을 명심하십시오.
 여러면에서 버튼처럼 작동합니다.
 실제로 암시 적 `role = button`ARIA 매핑도 있습니다.
 그러나 버튼과 매우 달리 제목은`<summary>`요소 내부에 직접 중첩 될 수 있습니다.

이것은 우리와 브라우저 및 보조 기술 개발자를 모순으로 만듭니다.

- 페이지 내 탐색 지원을 제공하기 위해`<summary>`요소에 제목이 허용됩니다.
- 버튼은 그 안에 중첩 된 모든 것 (헤딩과 같은)에서 의미를 제거합니다.

안타깝게도 보조 기술은 이러한 상황을 처리하는 방식이 일치하지 않습니다.
 NVDA 및 Apple의 VoiceOver와 같은 일부 화면 읽기 기술은`<summary>`요소 내부의 제목을 인식합니다.
 반면 JAWS는 그렇지 않습니다.

이것이 의미하는 바는`<summary>`안에 제목을 배치하면 제목의 모양을 지정할 수 있다는 것입니다.
 그러나 우리는 우리의 제목이 실제로 제목으로 해석 될 것이라고 보장 할 수 없습니다!

즉, 거기에 제목을 넣어도 아프지 않을 것입니다.
 항상 도움이되는 것은 아닙니다.

`<summary>`에서 직접 제목 태그 (또는 다른 블록 요소)를 사용할 때`display` 스타일을`inline`으로 변경하고 싶을 것입니다.
 그렇지 않으면 제목 옆이 아니라 제목 위에 표시되는 확장 / 축소 화살표 아이콘과 같이 원하지 않는 줄 바꿈이 표시됩니다.

다음 CSS를 사용하여`inline`의`display` 값을 모든 제목과`<summary>`내부에 직접 중첩 된 다른 요소에 적용 할 수 있습니다.

```css
details summary > * { 
  display: inline;
}
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_NWNPbNK" src="//codepen.io/anon/embed/NWNPbNK?height=450&amp;theme-id=1&amp;slug-hash=NWNPbNK&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed NWNPbNK" title="CodePen Embed NWNPbNK" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이 기술에 대한 몇 가지 참고 사항입니다.
 첫째, 제목 텍스트가 한 줄 이상으로 확장 될 때 줄 바꿈 문제가 여전히`inline-block`에서 발생하므로`inline-block`이 아닌`inline`을 사용하는 것이 좋습니다.

둘째, 중첩 된 요소의`display` 값을 변경하는 대신`<summary>`요소의 기본`display : list-item` 값을`display : flex`로 바꾸고 싶을 수 있습니다.
 적어도 나는 있었다!
 그러나 이렇게하면 화살표 마커가 사라집니다.
 이런!

### 보너스 팁 : 스타일에서 Internet Explorer 제외

앞서 Internet Explorer 및 Edge의 이전 Chromium (a.k.a. EdgeHTML) 버전은`<details>`요소를 지원하지 않는다고 언급했습니다.
 따라서 이러한 브라우저에 폴리 필을 사용하지 않는 한 맞춤 공개 위젯 스타일이 적용되지 않도록해야 할 수 있습니다.
 그렇지 않으면 모든 인라인 스타일이 요소를 왜곡하는 상황이 발생합니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2021/01/s_337AEA1AD6EBFD16B84BDF2D9E44CAED940FDE1EB7F05F648F43401932D4350B_1608828576103_image.png?resize=702%2C76&ssl=1)

또한이 경우`<summary>`요소는 더 이상 상호 작용하지 않으므로 커서의 기본`텍스트`스타일이`포인터`보다 더 적합합니다.

재설정 스타일이 적절한 브라우저만을 대상으로하기로 결정한 경우 IE 및 EdgeHTML에서 스타일이 적용되지 않도록하는 기능 쿼리를 추가 할 수 있습니다.
 다음은 `@supports`를 사용하여 해당 브라우저에서만 지원하는 기능을 감지하는 방법입니다.

```css
@supports not (-ms-ime-align: auto) {

  details summary { 
    cursor: pointer;
  }

  details summary > * { 
    display: inline;
  }

  /* Plus any other <details>/<summary> styles you want IE to ignore.
}
```

IE는 실제로 기능 쿼리를 전혀 지원하지 않으므로 위 블록의 모든 내용을 무시합니다. 괜찮습니다!
 EdgeHTML은 기능 쿼리를 지원하지만`-ms-ime-align`을 지원하는 유일한 브라우저 엔진이기 때문에 블록 내에서 아무것도 적용하지 않습니다.

여기서 가장주의 할 점은`<details>`를 지원하지만 기능 쿼리를 지원하지 않는 Chrome (즉, 12-27) 및 Safari (macOS 및 iOS 버전 6-8)의 이전 버전도 몇 가지 있다는 것입니다.
 기능 쿼리를 사용한다는 것은 전 세계 사용량의 약 0.06 % (2021 년 1 월 현재)를 차지하는 이러한 브라우저가 사용자 지정 공개 위젯 스타일도 적용하지 않음을 의미합니다.

`@supports not (-ms-ime-align : auto)`대신`@supports selector (details)`블록을 사용하는 것이 이상적인 솔루션입니다.
 그러나 선택기 쿼리는 속성 기반 기능 쿼리보다 브라우저 지원이 훨씬 적습니다.

### 마지막 생각들
verified_user

HTML 구조를 설정하고 두 개의 CSS 재설정 스타일을 추가 한 후에는 모든 공개 위젯을 원하는대로 꾸밀 수 있습니다.
 단순한 테두리 및 배경 색상 스타일조차도 미학과 유용성에 큰 도움이 될 수 있습니다.
 `<summary>`마커를 사용자 지정하는 것은 약간 복잡 할 수 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_OJNgGMb" src="//codepen.io/anon/embed/OJNgGMb?height=450&amp;theme-id=1&amp;slug-hash=OJNgGMb&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed OJNgGMb" title="CodePen Embed OJNgGMb" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>