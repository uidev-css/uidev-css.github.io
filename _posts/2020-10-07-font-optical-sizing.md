---
layout: post
title: "글씨체체체체체체체체체체체체체체체체체체의"
author: 'CSS Dev'
thumbnail: undefined
tags: 
---


`font-optical-size` CSS 속성은 브라우저가 글꼴 글리프의 윤곽을 조정하여 다양한 크기로 보다 읽기 쉽게 만들 수 있도록 한다. 예를 들어, 작은 텍스트는 대비를 증가시키기 위해 더 두꺼운 윤곽선을 얻을 수 있습니다. 반면, 큰 텍스트는 사양을 따옴표로 묶기 위해 더 "상세하게" 표시될 수 있습니다.

```css
.element {
  font-optical-sizing: none;
}
```

### 글리프에 윤곽이 있다고요?

그들은 그렇다! 사실, 모든 글리프에는 그것들이 있고 글꼴 크기에 따라 크기가 조정됩니다. 문제는 작은 글꼴 크기의 초박막 윤곽선이 최상의 판독성을 위해 충분한 대비를 제공하지 못할 수 있다는 점이다. 마찬가지로 큰 크기의 두꺼운 윤곽선은 너무 많은 무게와 대비를 가질 수 있다. 글꼴 고정을 시도하는 것은 브라우저가 다른 척도로 더 잘 읽을 수 있도록 아웃라인을 만지작거리도록 하는 것이다. 그 결과 글자가 더 선명하고 글꼴 크기에 따라 텍스트 길이가 더 좁아지거나 더 넓어집니다.

### 이 기능은 광학 크기 조정을 지원하는 글꼴에서만 작동합니다.

그리고 광학 사이징을 지원하는 글꼴은 구글의 클래식 로보토의 가변 버전인 로보토 델타를 포함한 가변 글꼴이다. 또 다른 서체는 암스텔바이다. 두 글꼴 모두 유형 네트워크에서 유지됩니다.

글꼴이 가변적이더라도 광학 크기 조정을 기능으로 명시적으로 지원해야 합니다.

### 글꼴 크기를 최적화하는 다른 방법

글꼴 크기 조정 속성은 글꼴을 지원하는 글꼴 크기를 광학적으로 조정하는 가장 효율적인 방법이다. 이를 지원하는 가변 글꼴의 광학 크기 조정 키워드인 opsz로 광학 사이징을 제어할 수 있는 폰트 변형 설정(font-variation-settings) 속성을 활용하는 것도 방법이다.

글꼴 변형 설정을 사용하려면 글꼴 크기에 따라 opsz를 설정해야 모든 것이 올바르게 확장됩니다.

```css
.element {
  font-size: 18px;
  font-variation-settings: 'opsz', 18;
}
```

### 구문

```css
font-optical-sizing: auto | none;
```

- 초기: `자동`
- 적용 대상: 모든 요소
- 상속됨: 예
- 계산된 값: 지정된 키워드
- 애니메이션 유형: 이산형

### 가치

- `auto`: 기본값입니다. 브라우저가 읽기 쉽도록 다양한 글꼴 크기로 텍스트를 최적화할 수 있다.
- 없음: 브라우저가 텍스트를 수정할 수 없습니다.

상속, 이니셜, 언세트 등 글로벌 키워드 값도 허용된다.

### 데모

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 350px;"><iframe id="cp_embed_dyMxzVP" src="//codepen.io/anon/embed/dyMxzVP?height=350&amp;theme-id=1&amp;slug-hash=dyMxzVP&amp;default-tab=result" height="350" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed dyMxzVP" title="CodePen Embed dyMxzVP" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 브라우저 지원

### 관련 속성

- 폰트 패밀리
- 글꼴 고정 설정
- 글꼴 고르기
- `글씨
- 글꼴 고정 설정

### 추가 읽기

- CSS 글꼴 모듈 레벨 4(편집자 초안)
- MDN 설명서
- 가변 글꼴: 광학 크기, 사용자 지정 축 및 기타 호기심(응답형 웹 타이포그래피