---
layout: post
title: "논리에 늦음
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/12/Screen-Shot-2020-12-07-at-1.27.19-PM.png
tags: LOGICAL PROPERTIES
---


2020 년에는 주요 브라우저에 또 다른 논리적 속성 기능이 도입되었으며 물리적 웹 스타일이 아닌 논리적 웹 스타일에 대한 투자를 완전히 즐겼습니다.
 코드 작성 횟수를 줄이고 글로벌 범위를 넓히는 박스 모델에 대해 말하는 새로운 방법을 배운 것 같습니다.
 

```css
p {
  /* 🚫 */ text-align: left;
  /* 👍 */ text-align: start;

  /* 🚫 */ margin-top: 1rem;
  /* 👍 */ margin-block-start: 1rem;
}
```

위에서 링크 한 web.dev 기사에서 설명한 것처럼 논리적 속성은 해당 언어 방향의 맥락에서 상자 모델의 측면, 모서리 또는 축을 참조하는 속성입니다.
 누군가의 오른팔이라고 가정하는 것이 아니라 누군가의 강한 팔을 언급하는 것과 비슷합니다.
 "오른쪽"은 물리적 팔 참조이고, "강한"은 개인의 상황에 맞는 논리적 팔 참조입니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/11/block-and-inline-visual-1.png?resize=801%2C577&ssl=1)

업데이트 된 구문의 요령을 알게되자 전 세계의 다른 곳에서 이미 비슷한 문제를 해결했음을 깨달았습니다!
 웹은 논리적 전문 용어에 늦었습니다.
 다음은 이미 논리적이었던 몇 가지 다른 장소입니다.
 

### 해상 방향
 

![image](https://paper-attachments.dropbox.com/s_0737047516C3C66639E2FEA168FC6A46D768372D29B0B7D43CDBD925E6240D77_1606237301785_ship.png)

항구와 우현은 선박과 관련된 선박의 논리적 측면입니다.
 나는 Wikipedia가 자신있게 말하는 방식을 좋아합니다.
 

> … 항해 방향의 용어는 선박의 왼쪽과 오른쪽을 각각 참조하는 선박의 구조를 명확하게 다루며, 선박에 탑승 한 관찰자가 앞을 내다보고 있습니다.”
 

선박 중심의 논리적 특성.
 선박과 함께 작업하는 동안 선박 언어를 사용하십시오.
 

### 스키어 및 무대
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/11/s_0737047516C3C66639E2FEA168FC6A46D768372D29B0B7D43CDBD925E6240D77_1606237290919_skiers.png?resize=641%2C427&ssl=1)

스키어의 왼쪽은 산 아래를 향한 스키어를 기반으로 한 논리적 방향입니다.
 논리적 언어가 없으면 스키어는 방향을 선언 할 때 서있는 위치에 따라 좌우로 혼란 스러웠습니다.
 산을 향한 체어 리프트를 타고있는 경우, 리프트에서 내려 산에서 다시 스키를 타기 시작하면 왼쪽이 오른쪽이고 오른쪽이 왼쪽입니다.
 그래서 그 커뮤니티는 방향에 대해 논리적으로 이야기하는 방법을 생각해 냈습니다.
 "스키어의 오른쪽"및 "스키어의 왼쪽"이라는 용어는 본질적으로 상황에 맞는 논리적 속성입니다.
 스키어와 함께 작업하는 동안 스키어 언어를 사용하십시오.
 

마찬가지로 영화 스튜디오에서는 "Stage One"및 "Camera Two"와 같은 용어를 사용합니다.
 상대적인 방향이 아니라 공통된 이해를 기반으로 모든 사람을 논리적으로 방향을 잡는 데 도움이됩니다.
 

### 논리적 결론
 

업계 또는 커뮤니티로서 우리는 신체 중심 스타일에 문제가있었습니다.
 버튼의 왼쪽과 오른쪽에 패딩을 추가하는 것은 일부 언어에서만 적합합니다.
 배에서 잘못된 길을 바라 보면서 패딩을 쓴 것과 같습니다.
 인라인 시작 및 인라인 끝을 통한 논리적 속성은 모든 언어에 적합합니다.
 배에서 어느 방향을 향하고 있는지는 중요하지 않습니다. 더 이상 당신에 관한 것이 아닙니다.
 

아래의 펜에서 논리적 속성을 활용하십시오.
 브라우저는 전 세계에서 콘텐츠를 읽을 수 있도록하기 위해 수많은 작업을 수행하고 있습니다.
 그래서 rad.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_yLaBMeZ" src="//codepen.io/anon/embed/yLaBMeZ?height=450&amp;theme-id=1&amp;slug-hash=yLaBMeZ&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed yLaBMeZ" title="CodePen Embed yLaBMeZ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

```css
button {
  padding-block: 1ch;
  padding-inline: 2ch;
  border-inline: 5px solid var(--brand-1);
}
```

해상 논리적 방향에서 Wikipedia가 가지고있는 확신을 모방하기 위해 : 이제 웹인 우리는 언어 방향에 따라 각 측면을 참조하여 상자의 구조를 모호하지 않게 다룰 수 있습니다.
 당신과 여전히 관련이 있지만 이제는 다른 모든 사람들에게도 관련된 방식으로 측면을 한 번 설명하십시오.
 덜 생각하고 더 많이 제공하십시오.
 

```css
p {
  max-inline-size: 50ch;
  margin-block: 1rem;
}
```

논리적 속성이 사람을 중심으로한다는 것이 저에게 중요합니다.
 언어 방향이 각각 사용자 중심입니다.
 논리적 속성을 사용하여 개인이 다양성, 복잡성 및 예측 불가능 성을 테이블에 가져 오도록 초대합니다.
 우리는 그것을 수용하고 브라우저 엔진에 의존하여 적절하게 배치 할 수 있습니다.
 

```css
hr {
  max-inline-size: 30ch;
  margin-inline: auto;
  border-block-start: 1px solid hsl(2rad 20% 20% / 20%);
}
```

"상단"및 "왼쪽"스타일의 사고를 버리고 "블록"및 "시작"스타일 속성을 사용하여 논리적으로 사고를 시작합니다.
 웹 상자로 작업하는 동안 웹 상자 언어를 사용하십시오.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/11/s_0737047516C3C66639E2FEA168FC6A46D768372D29B0B7D43CDBD925E6240D77_1606237326579_logical-properties.png?resize=720%2C480&ssl=1)

웹의 "매직 페이퍼"는 이제 사용자에게 최대한 자연스럽게 유지 될 수 있으므로 훨씬 더 마술 적입니다.
 나는 그것을 좋아한다.
 

추신
 Flexbox 이후로 논리적 속성을 훈련 받았습니다.
 