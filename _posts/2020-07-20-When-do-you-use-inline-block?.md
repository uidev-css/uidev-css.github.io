---
layout: post
title: "인라인 블록은 언제 사용하시나요?"
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/07/inline-block-columns.png"
tags: INLINE-BLOCK
---


디스플레이의 인라인 블록 값은 고전이다! 새로운 기능이 아니며 브라우저 지원도 걱정할 필요가 없습니다. 우리들 중 많은 사람들이 직관적으로 그것에 손을 뻗을 것이다. 하지만 한 가지 짚고 넘어가자. 실제로 어떤 용도로 유용합니까? 언제 다른 옵션들, 아마도 비슷한 옵션들 중에서 고르는가?

### 단추

제가 가장 많이 들었던 대답은, 항상 버튼에 사용한다는 것이었습니다.

궁극적으로, 나는 그것이 타당하다고 생각하지만, 그것은 내가 약간의 오해로 보는 것에 기여한다. 버튼처럼 보이는 요소(자연스럽게 하는 것처럼 ➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡➡ 약간 오해가 있는 부분은 디스플레이 인라인 요소에는 여백과 패딩이 있을 수 있고 예상대로 행동할 수 있다는 점이다.

까다로운 점은 다음과 같습니다.

- 인라인 요소의 블록 방향 여백은 완전히 무시됩니다.
- 인라인 요소의 패딩은 텍스트 줄의 높이에 영향을 주지 않습니다.

그래서, 버튼 자체는 꽤 괜찮은 스타일이지만, 상위 요소와 주변 텍스트는 그렇지 않을 수 있습니다. 다음은 데모입니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/07/Screen-Shot-2020-07-08-at-5.51.20-AM.png?resize=681%2C188&ssl=1)

인라인 버튼으로 래핑이 시작되면 상황은 더 악화됩니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/07/Screen-Shot-2020-07-08-at-5.51.58-AM.png?resize=384%2C309&ssl=1)

네, 인라인 블록은 제가 말하고자 하는 버튼에서 꽤 의미가 있습니다. 그런데...

### 인라인-플렉스와 인라인-그리드를 잊지 마십시오.

표시 값 인라인-플렉스와 인라인-그리드를 사용하면 인라인-블록에서와 같은 동작을 취할 수 있지만 요소(종종 버튼)는 더 강력한 인라인 레이아웃 시스템을 통해 이점을 얻을 수 있다.

다음과 같은 버튼 아이콘의 예를 들어보십시오.

```html
<a href="#" class="button>
  <svg> ... </svg>
  Text
</a>
```

텍스트와 아이콘이 중앙에 완벽하게 정렬되도록 하려면 다음과 같이 해야 합니다.

```html
.button svg {
  vertical-align: middle;
}
```

제대로 이해 못 하겠지만...

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/07/Screen-Shot-2020-07-09-at-6.30.32-AM.png?resize=715%2C129&ssl=1)

그러나 이는 `인라인 플렉스`로 쉽게 해결할 수 있는 방법입니다.

```html
.button {
  display: inline-flex;
  align-items: center;
}
```

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/07/Screen-Shot-2020-07-09-at-6.31.17-AM.png?resize=728%2C140&ssl=1)

인라인-플렉스 또는 인라인-그리드를 사용하면 인라인 방향으로 배치된 블록 내에서 Flexbox 또는 그리드 레이아웃 시스템의 모든 기능을 사용할 수 있습니다.

## 여전히 래핑할 수 있는 블록

인라인 블록 요소는 너비를 존중합니다. 그것은 그들과 직선적인 인라인 요소 사이의 또 다른 차이점이다. 사람들은 "인라인 블록"으로 기둥 배치 시스템을 구축하곤 했는데, 이는 기본적으로 플로트가 여기서 할 수 있는 일을 할 수 있기 때문이다. 플로트를 치우는 것에 대한 걱정 없이, 플로트가 할 수 있기 때문이다. 플로트가 플로트보다 약간 우아하게 포장되는 것을 이용할 수 있기 때문이다.

HTML 전자 메일에 미디어 쿼리(일부 전자 메일 클라이언트가 지원하지 않는)를 사용하지 않고 단일 열로 축소되는 다중 열 레이아웃을 작은 화면에서 사용할 수 있도록 하는 트릭이기 때문에(심지어 1열까지) 인라인 블록이 열처럼 동작한다는 아이디어는 오늘날까지 유효하다.

댄의 예.

### 인라인 요소에 대한 ➡

인라인 요소는 `변환`을 취할 수 없습니다. 그래서 그것이 필요하다면, "인라인 블록"이 필요할 것이다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_YzwLRYJ" src="//codepen.io/anon/embed/YzwLRYJ?height=450&amp;theme-id=1&amp;slug-hash=YzwLRYJ&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed YzwLRYJ" title="CodePen Embed YzwLRYJ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 중간에 깨지지 않는 기둥형 아이들

CSS 열은 텍스트 문단에서 사용할 수 있으며, 지정된 단락이 열을 가로지르더라도 상관 없습니다. 그러나 때때로 CSS 열은 어색한 블록에 사용됩니다. 그 블록들은 그들만의 배경과 패딩이 있다고 말한다. 휴식이 시각적으로 꽤 이상하다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/07/awkward-columns.png?resize=1488%2C1318&ssl=1)

내가 100% 이해한다고 말할 수 없는 이상한 수법이지만, 그 상자들 위에 디스플레이: 인라인 블록; 그리고 아마 "폭: 100%"를 던지면, 그것들이 깨지지 않고 패딩이 보존된다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/07/Screen-Shot-2020-07-12-at-1.52.23-PM.png?resize=1024%2C755&ssl=1)

### 목록을 수평으로 만드는 빠른 방법

이것은 내 원래 트윗에 대한 또 다른 인기 있는 대답이었다. 요소 스택 항목을 블록 수준 요소와 같이 수직으로 나열합니다. 그것들은 사실 블록이 아닙니다. 그것들은 `디스플레이: 리스트-아이템; 우리가 볼 수 있듯이 실제로 여기서 어느 정도 중요한 것이다. 인기 있는 사용 사례는 "내가 목록을 수평으로 배열하고 싶을 때"입니다.

그럼 리스트를...

```html
<ul>
  <li>Three</li>
  <li>Little</li>
  <li>Piggies</li>
</ul>
```

대신 연속해서 넘어뜨리고 싶다면...

```css
li {
  display: inline-block;
}
```

그리고 네가 가져.

보이스오버에서 잠깐 들었고 `인라인 블록` 리스트는 여전히 이 요소를 리스트로 발표하지만 총알 지점을 말하지 않는 것은 말이 된다. 그것이 목록 항목의 표시 자체를 목록 항목의 표시에서 다른 것으로 바꾸는 것의 중요한 점이다. 즉, 그들은 그들의, 아, 목록 항목-y-ness를 잃어버린다.

다른 대안으로는 부모를 플렉스 박스 컨테이너로 만드는 것이 있습니다.

```css
ul {
  display: flex;
}
```

…수평행(Flexbox 기본값)을 달성하지만 목록 항목 표시 자체를 변경하지 않을 때 글머리 기호는 그대로 유지됩니다. 원하는 경우 수동으로 제거할 수 있습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/07/Screen-Shot-2020-07-12-at-2.27.31-PM.png?resize=1024%2C764&ssl=1)

### 중심 리스트

리스트 얘기가 나와서 말인데, 제프 스타는 중심 텍스트 안에 있는 리스트의 아이디어에 대해 블로그를 했을 뿐인데, 이 아이디어 또한 어색해질 수 있다. 어색한 점은 목록 항목 내부의 텍스트를 가운데로 맞출 수 있지만 목록 항목 자체가 여전히 전체 너비로 되어 있어 총알이 왼쪽으로 정렬된 상태를 유지한다는 점이다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/07/center-left-list-01.png?resize=1236%2C644&ssl=1)

제프의 해결책은 전체 목록을 `인라인 차단`하는 것이었다. 이렇게 하면 목록의 폭이 콘텐츠의 자연 폭만큼만 유지되므로 총알이 왼쪽 가장자리를 벗어나 중앙 콘텐츠와 함께 이동할 수 있습니다. 전후 블록 레벨 요소가 있는 한 좋은 해결책이다.

대안으로, 목록의 너비를 내용의 너비로 축소하는 것이 목표라면, 이 또한 목록이 블록 레벨로 되는 것을 중단하지 않고 다음과 같이 달성할 수 있다.

```css
ul {
  width: max-content;
  margin: 0 auto;
  text-align: left;
}
```