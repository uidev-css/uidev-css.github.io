---
title: "CSS 네이티브 중첩 기능 완벽 해부하기"
description: ""
coverImage: "/assets/img/2024-06-21-UnpackingNativeCSSNesting_0.png"
date: 2024-06-21 23:52
ogImage: 
  url: /assets/img/2024-06-21-UnpackingNativeCSSNesting_0.png
tag: Tech
originalTitle: "Unpacking Native CSS Nesting"
link: "https://medium.com/mamitech/unpacking-native-css-nesting-0bdb94fc3fbe"
---



![이미지](/assets/img/2024-06-21-UnpackingNativeCSSNesting_0.png)

CSS와 씨름한 시간이 있다면(솔직히 말해서 누가 안 했겠어요?), 그것이 약간 혼란스러워질 수 있다는 것을 알고 계실 겁니다. 선택자가 쌓이고 규칙이 곳곳에 흩어지며, 이 모든 것은 어떤 개발자라도 더 간단한 방법을 열망하게 만듭니다.

좋은 소식이 있습니다! 여러분의 호소가 들려졌습니다. 이제 우리에게는 기본 CSS 중첩이 있습니다. 새끼 새의 아늑한 집처럼 들릴지도 모르지만, 믿어봐요. 실제로 그것보다 더 멋집니다.

## 무슨 큰일인가요?


<div class="content-ad"></div>

옛날에는 (좋아, 몇 년 전) CSS 규칙을 중첩해서 더 정리된 모습으로 만들고 싶다면 Sass나 Less와 같은 전처리기를 사용해야 했습니다. 이 도구들은 좋았지만, 워크플로에 추가 단계를 넣는 번거로움이 있었습니다. 브라우저가 이해할 수 있도록 코드를 컴파일해야 했습니다.

기본 CSS 중첩을 통해 추가 도구가 필요하지 않은 상태에서 CSS 파일 내에서 규칙을 중첩할 수 있습니다. 마치 항상 원하던 내장형 캐비닛 정리함을 얻은 것 같은 느낌이에요 (모든 것이 자리를 차지하고 있어요), 그리고 필요한 것을 찾기가 훨씬 쉽습니다.

## 코드 보여줘!

그만 얘기하고, 몇 가지 예제로 이 작업이 어떻게 작동하는지 확인해보세요:

<div class="content-ad"></div>

기본 중첩:

```js
/* 중첩 없이 */
.card { 배경색: 흰색; 패딩: 20px; }
.card h2 { 글꼴 크기: 24px; }
.card p { 줄 높이: 1.6; }
.card a { 색상: 파란색; }


/* 중첩 사용 */
.card {
  배경색: 흰색;
  패딩: 20px;

  h2 { 글꼴 크기: 24px; }
  p { 줄 높이: 1.6; }
  a { 색상: 파란색; }
}
```

가상 클래스와 함께 중첩:

```js
/* 중첩 없이 */
.btn { /* ...버튼 스타일... */ }
.btn:hover { 배경색: #0056b3; 색상: 흰색; }
.btn:active { 박스 그림자: inset 0 3px 5px rgba(0, 0, 0, 0.125); }


/* 중첩 사용 */
.btn {
  /* ...버튼 스타일... */

  &:hover {
    배경색: #0056b3;
    색상: 흰색;
  }

  &:active {
    박스 그림자: inset 0 3px 5px rgba(0, 0, 0, 0.125);
  }
}
```

<div class="content-ad"></div>

미디어 쿼리와 중첩 사용하기:

```js
/* 중첩 없이 */
.container { width: 960px; margin: 0 auto; }
@media (max-width: 768px) {
  .container { width: 100%; padding: 0 15px; }
}


/* 중첩 사용 */
.container {
  width: 960px;
  margin: 0 auto;

  @media (max-width: 768px) {
    width: 100%;
    padding: 0 15px;
  }
}
```

## 중첩을 채택해야 하는 이유

- 가독성: 관련된 스타일을 함께 유지하여 코드를 읽고 이해하기 쉽게 만듭니다 (누가 깔끔한 코드를 싫어하겠어요?).
- 유지보수성: 무언가를 변경해야 할 때 관련 규칙을 찾기가 훨씬 간단합니다.
- 반복 최소화: 동일한 부모 선택기를 반복해서 입력할 필요가 없습니다. (솔직히 말해서, 할 일이 아직 많은데 말이죠.)
- 효율성: 네이티브 CSS 중첩을 사용하면 반복되는 선택기를 제거하여 파일 크기를 조금 줄일 수도 있습니다.

<div class="content-ad"></div>

## 주의 사항 몇 가지

- 브라우저 지원: 중첩은 상대적으로 새로운 개념이므로 전면적으로 도입하기 전에 각 브라우저가 지원하는지 확인해보세요. (호환성을 확인하려면 caniuse.com과 같은 도구를 사용할 수 있습니다.)
- 과도한 중첩: 중첩을 지나치게 사용하지 마세요. 너무 많은 수준은 코드를 이해하기 어렵게 만들 수 있습니다. (프로젝트에 "적절한" 중첩 수준을 찾아보세요.)

## 중첩해 보세요!

기본 CSS 중첩은 스타일시트의 구조와 가독성을 개선하는 간단하면서도 강력한 방법입니다. 그러니 더 이상 기다릴 이유가 있나요? 중첩을 시작해서 업무 흐름에서 만드는 차이를 보세요.

<div class="content-ad"></div>

네이티브 CSS 중첩에 대해 더 알아보기 위해 문서를 확인해보세요:

- [MDN Native CSS Nesting](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_nesting)
- [Chrome DevTools CSS Nesting](https://developer.chrome.com/docs/css-ui/css-nesting)

그리고, 도움이 되었다면 팔로우하기를 잊지마세요! 소프트웨어 엔지니어링 및 특히 웹 개발의 흥미로운 세계에 대한 팁, 통찰력 및 업데이트를 공유하는 걸 좋아합니다. 즐겨 사용하세요!