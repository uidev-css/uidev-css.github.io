---
layout: post
title: "서체를 아는"
author: 'CSS Dev'
thumbnail: undefined
tags: 
---


CSS `font-kning` 속성은 특정 문자 쌍들의 간격을 정의한다.

글꼴에는 종종 문자의 왼쪽과 오른쪽 가장자리에 있는 숨쉴 수 있는 공간에 대한 정보가 포함되어 있습니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/09/font-sidebearing.png?resize=400%2C175&ssl=1)

두 문자가 서로 옆에 놓이면 사이드 베어링이 합산되어 문자 사이의 실제 공간을 형성합니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/09/font-sidebearing-two.png?resize=400%2C175&ssl=1)

글꼴 디자이너는 두 개의 특정 문자 사이의 사이드 베어링을 조정하여 서로 더 잘 어울리게 합니다. 그것이 알고 있는 것이고 그것이 바로 `글꼴 아는` 속성이 우리에게 결정하게 하는 것이다: 우리가 글꼴을 아는 것을 사용할 것인지 아니면 아예 사용하지 않을 것인지. 따라서 작업 중인 글꼴이 알 수 있는 데이터를 지원하지 않는 경우 이 속성은 해당 글꼴에 영향을 미치지 않습니다.

### 구문

```css
font-kerning: auto | normal | none
```

- 초기값: `자동`
- 적용 대상: 모든 요소
- 상속됨:
- 계산된 값:
- 애니메이션 유형: 이산형

### 가치

`font-kning`은 다음 값을 사용합니다.

- auto: 브라우저가 글꼴 고르기 사용 여부를 결정할 수 있습니다.
- `normal`: 글꼴에 저장된 knowing을 사용할 수 있습니다.
- none: knowing을 비활성화합니다.

### 데모

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 300px;"><iframe id="cp_embed_PoNVXjX" src="//codepen.io/anon/embed/PoNVXjX?height=300&amp;theme-id=1&amp;slug-hash=PoNVXjX&amp;default-tab=result" height="300" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed PoNVXjX" title="CodePen Embed PoNVXjX" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 브라우저 지원

### 관련 속성

- `글씨
- `글씨
- `글씨체-대립자`
- `글씨체 문자`
- `글씨체로 된 서체
- `글씨체 문자`
- `편지 발송인