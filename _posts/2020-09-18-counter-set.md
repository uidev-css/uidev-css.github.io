---
layout: post
title: "반격의"
author: 'CSS Dev'
thumbnail: undefined
tags: 
---


카운터 집합 CSS 속성은 이름에 참이며 CSS 카운터의 시작 값을 설정합니다. 순서 리스트가 1에서 시작해서 거기서부터 어떻게 증가하는지 아세요? 카운터 집합 속성을 사용하면 시작 값을 -1 또는 2. 또는 200으로 설정할 수 있습니다! 순서가 지정된 목록 대신 CSS 카운터에 적용된다는 점만 제외합니다.

그러면, 챕터 이름 앞에 챕터 번호가 붙어 있는 북 챕터 목록에 대한 사용자 지정 카운터가 있다고 가정해 보겠습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/09/counter-set-chapters-h2.png?resize=1024%2C634&ssl=1)

먼저 카운터 재설정 속성을 가진 카운터를 정의하는 것부터 시작하겠습니다. 이것을 챕터라고 부르고 창의적으로 .chapters라고 하는 챕터의 상위 컨테이너 클래스에 대해 정의하겠습니다.

```css
.chapters {
  counter-reset: chapter;
}
```

다음으로, 우리는 `반증가` 속성을 사용하는 요소에 `장` 카운터를 할당할 것이다. 이 책들은 책장이기 때문에 책 제목이 <h1>이라고 가정하고 그것들을 <h2> 요소에 적용할 것이다. 우리는 이것을 실제의 <h2> 요소에 카운터를 붙일 수 있기 때문에 실제로 `:before` 의사 요소에 할당하고 있습니다.

```css
h2:before {
  counter-increment: chapter;
}
```

좋아, 카운터에 무엇을 진열해야 하는지 알려주는 건 절대 필요 없어. 이는 카운터() 기능을 통해 컨텐츠 속성에서 수행됩니다. 디자인상 필요하니 카운터에 컬러도 조금 넣어드릴게요.

```css
h2:before {
  color: red;
  content: "Chapter " counter(chapter) ": ";
  counter-increment: chapter;
} 
 

```

야, 우리 보기 좋아!

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 750px;"><iframe id="cp_embed_oNxMGQq" src="//codepen.io/anon/embed/oNxMGQq?height=750&amp;theme-id=1&amp;slug-hash=oNxMGQq&amp;default-tab=result" height="750" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed oNxMGQq" title="CodePen Embed oNxMGQq" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

하지만 기다려요! 난 우리가 1장에서 시작한다는 사실을 파헤치고 있지 않아. 내 말은, "Forward"는 사실 챕터가 아니야. 뭐랄까, 0과 같아.

바로 거기에 카운터셋이 들어온다! 0으로 시작하도록 설정하겠습니다.

```css
h2:first-of-type::before {
  counter-set: chapter;
}
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 800px;"><iframe id="cp_embed_VwaEpVL" src="//codepen.io/anon/embed/VwaEpVL?height=800&amp;theme-id=1&amp;slug-hash=VwaEpVL&amp;default-tab=result" height="800" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed VwaEpVL" title="CodePen Embed VwaEpVL" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

됐다! 그게 더 낫다. 속성 값을 카운터 이름으로 설정하기만 하면 챕터 리스트가 0장에서 시작됩니다. 100장과 같은 다른 것에서 쉽게 시작할 수 있었습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 800px;"><iframe id="cp_embed_eYZPvQP" src="//codepen.io/anon/embed/eYZPvQP?height=800&amp;theme-id=1&amp;slug-hash=eYZPvQP&amp;default-tab=css,result" height="800" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed eYZPvQP" title="CodePen Embed eYZPvQP" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

그리고 브라우저가 `카운터셋`을 지원하지 않는 경우? 아무 것도 아니야, 정말. 간단히 무시되고 목록은 기본값인 `1`에서 시작됩니다.

### 구문

```css
[ <custom-ident> <integer>? ]+ | none
```

이는 기본적으로 부동산이 주문 카운터(사용자 정의 ID)의 이름과 시작 값(정수 값)을 사용한다는 화려한 표현이다. 또는 `없음`으로 설정하면 기본 시작점인 `1`에서 번호가 시작됩니다.

- 초기값: `없음`
- 적용 대상: 모든 요소(비시각적 요소 포함)
- 상속됨: 아니요
- 애니메이션 유형: 계산된 값 유형별

### 가치

```css
/* Set "awesome-counter" to 0 */
counter-set: awesome-counter;

/* Set "awesome-counter" to -10 */
counter-set: awesome-counter -10;

/* Set "awesome1" to 0, and "awesome2" to 2 */
counter-set: awesome1 awesome2 2;

/* Wipe out any other settings that may have been declared elsewhere */
counter-set: none;

/* Global values */
counter-set: inherit;
counter-set: initial;
counter-set: unset;
```

이에 대해 선언된 카운터 이름이 다른 곳에 아직 정의되지 않은 경우 카운터 집합은 새 카운터를 만듭니다.

### 브라우저 지원

### 관련 속성

- 반격자
- 역재설정
- `내용

### 추가 읽기

- CSS 목록 모듈 레벨 3 사양(작업 초안)
- CSS 카운터를 사용하여 현재 단계 표시
- CSS 카운터 및 그리드를 사용한 카운트
- CSS 사용자 지정 카운터를 되돌리는 방법