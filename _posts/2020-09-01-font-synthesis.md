---
layout: post
title: "글씨체로 된"
author: 'CSS Dev'
thumbnail: undefined
tags: 
---


CSS의 글꼴-시제 속성은 지정된 글꼴-패밀리가 포함되지 않을 때 글꼴 굵기와 기울임꼴 문자를 처리하는 방법을 브라우저에 제공한다.

Google Fonts의 Lato를 예로 들어 보겠습니다. 글씨체에는 10가지 다른 변형이 있다고 되어 있습니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/08/lato-specimen.png?resize=1024%2C854&ssl=1)

각각의 글꼴 변형은 기술적으로 다른 글꼴 파일이다. 특정 가중치와 스타일을 사용하려면 브라우저에서 로드할 수 있도록 해당 파일을 링크해야 합니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/08/lato-variations-1.jpg?resize=1024%2C140&ssl=1)

그러나 모든 글꼴이 무게와 스타일을 처리하기 위한 파일을 포함하는 것은 아닙니다. 이 경우 브라우저는 모양 자체를 "동기화"합니다. 브라우저는 최선을 다하지만 가짜 볼드체나 스타일은 텍스트를 읽기 쉽게 만드는 경우가 있다. 즉, 실제로 설계된 버전보다 읽기 쉽게 만드는 경우가 있다. 가장 가벼운 경우에는 문자가 겹치는 경우가 있습니다. 더 심각한 경우에는 중국어, 일본어, 한국어 및 기타 로그 스크립트와 같은 언어에서 발생할 수 있는 것처럼 텍스트를 완전히 읽을 수 없거나 의미를 변경할 수도 있습니다.

바로 여기에 `글꼴 합성`이 들어온다. 브라우저가 합성할 수 있는 서체를 제어합니다.

### 구문

```css
.element {
  font-synthesis: none | [ weight || style ];
}
```

일반 영어에서 `font-synthesis`는 다음을 받아들인다.

- 없음 값
- 무게와 스타일 중 하나
- 무게와 스타일 모두

폰트 합성은 속기 속성으로 간주된다는 점에 주목할 필요가 있다. 이 규격에 따르면 auto(자동)나 none(없음)의 값을 모두 수용하는 폰트 합성 가중치와 폰트 합성 방식의 결합이다. 속기를 사용해서 같은 효과를 얻을 수 있기 때문에, 아마 그게 가장 좋은 방법일 거예요.

### 가치

- 없음: 굵거나 비스듬하지 않음
- `weight`: 브라우저에서 볼드를 합성할 수 있습니다.
- style: 브라우저에서 사선을 합성할 수 있습니다.

```css
font-synthesis: none; /* browser will not synthesize any font faces */
font-synthesis: style; /* browser will not synthesize a bold font face */
font-synthesis: weight; /* browser will not synthesize an oblique font face */
font-synthesis: weight style; /* browser will synthesize bold and oblique faces if they are unavailable */
```

### 사용법

글꼴 고정을 `::첫글자` 및 `::첫줄` 유사 고리를 포함한 모든 요소와 함께 사용할 수 있습니다.

브라우저가 전체 언어에 대해 굵고 비스듬하게 합성하지 못하게 하는 경우가 있을 수 있는데, 둘 중 어느 것이든 문자를 모호하게 할 수 있기 때문이다. 다음은 아랍어 문자를 포함하는 합성된 굵고 사선 글꼴을 사용하지 않도록 설정하는 규격에서 가져온 예입니다.

```css
/* Disables synthetic bolded and obliqued characters in Arabic */
*:lang(ar) { font-synthesis: none; }
```

### 데모

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_dyMbmmO" src="//codepen.io/anon/embed/dyMbmmO?height=450&amp;theme-id=1&amp;slug-hash=dyMbmmO&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed dyMbmmO" title="CodePen Embed dyMbmmO" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 브라우저 지원

글쓰기를 할 때, `글꼴 합성` 속성에 대한 전 세계 적용범위는 20.21%였다.

이메일에 `font-synthesis`를 사용하시겠습니까? Campaign Monitor는 다음과 같은 클라이언트에서 지원되는 것으로 보고합니다.

- 애플 메일 10+
- Mac용 아웃룩
- AOL Alto iOS 앱
- iOS 메일 10+
- 참새
- G 스위트
- 지메일
- Google 받은 편지함

### 추가 정보

- CSS 글꼴 모듈 레벨 4 사양
- Eric Meyer의 CSS3 테스트 폰트 합성법
- Chris Coyier의 "이탤릭체화하는 방법"