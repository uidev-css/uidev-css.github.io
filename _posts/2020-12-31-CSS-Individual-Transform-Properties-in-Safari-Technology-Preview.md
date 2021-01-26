---
layout: post
title: "Safari 기술 미리보기의 CSS 개별 변환 속성"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/12/webkit-transform.jpg
tags: ROTATE,SCALE,TRANSFORM,TRANSLATE
---


WebKit 블로그는 최신 버전의 Safari Technology Preview에서 개별 CSS 변환 속성을 사용하는 방법을 자세히 설명합니다.
 이렇게하면 브라우저가 CSS Transforms Module Level 2 사양과 일치하여`transform` 속성의`translate ()`,`rotate ()`및`scale ()`함수를 개별 속성으로 분리합니다.`
 translate`,`scale` 및`rotate`.

따라서`transform` 속성에이 세 가지 함수를 연결하는 대신 :

```css
.some-element {
  transform: translate(50px 50px) rotate(15deg) scale(1.2);
}
```

… 우리는 그것들을 자신의 속성으로 개별적으로 작성할 수 있습니다.

```css
.some-element {
  translate: 50px 50px;
  rotate: 15deg;
  scale: 1.2;
}
```

당신이 나와 같다면, 당신의 마음은 즉시 "왜 우리가 더 많은 코드를 작성하고 싶을까요?"
 내 말은, 우리는`background`,`border`,`font`,`margin`,`padding`에서 본 것처럼 개별 속성이 속기의 하위 속성이되는 것을 보는 데 익숙합니다.
 ,`place-items` 등.

그러나 WebKit 팀은이 작업을 수행하려는 몇 가지 확실한 이유를 설명합니다.

- `transform : scale (2);`대신`scale : 2;`처럼 하나의 함수 만 필요한 경우 단일 속성을 작성하는 것이 더 간단합니다.
- 다른`transform` 속성이 서로 연결되어있을 때 실수로 재정의 할 염려가 훨씬 적습니다.
- `변환`으로 중간 값을 연결할 때 중간 값을 `미리 계산`하고 `재 계산`하는 것보다 개별 속성에서 키 프레임 애니메이션을 변경하는 것이 훨씬 간단합니다.
- 개별 속성의 타이밍과 키 프레임을보다 세밀하게 제어 할 수 있습니다.

이 게시물은 몇 가지 유용한 팁도 지적합니다.
 마찬가지로, 새로운 개별 변환 속성은 `transform`속성의 함수보다 먼저 `translate`, `rotate`, `scale`순서대로 적용됩니다.

아, 그리고 우리는 브라우저 지원을 간과 할 수 없습니다!
 작성 당시에는 극히 제한되어 있습니다. 기본적으로 Safari Technology Preview 117 및 Firefox 72 이상으로 무려 3.9 %의 글로벌 지원을 제공합니다.

- `번역`
- `회전`
- `스케일`

이 게시물은 속성 사용을 시작하려면`@ supports` 사용을 제안합니다.

```css
@supports (translate: 0) {
  /* Individual transform properties are supported */
  div {
    translate: 100px 100px;
  }
}

@supports not (translate: 0) {
  /* Individual transform properties are NOT supported */
  div {
    transform: translate(100px, 100px);
  }
}
```

이것이 바로 게시물에서 가져온 코드 예제입니다.
 이를 수정하면 `not`연산자를 사용하지 않는 데 도움이됩니다.
 이것이 코드의 개선인지 아닌지는 확실하지 않지만 다음과 같은 작업을 수행하는 것이 점진적 개선 인 것 같습니다.

```css
div {
  transform: translate(100px, 100px);
}

@supports (translate: 0) {
  /* Individual transform properties are supported */
  div {
    transform: none;
    translate: 100px 100px;
  }
}
```

이렇게하면 축약 형 함수를 지우고 개별 속성을위한 방법을 만들지 만 지원되는 경우에만 가능합니다.