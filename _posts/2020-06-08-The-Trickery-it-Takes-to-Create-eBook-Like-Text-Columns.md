---
layout: post
title: "eBook과 같은 텍스트 열을 만드는 데 필요한 속임수"
author: "Uidev Css"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/06/pamental-swipeable-columns.png"
tags: COLUMNS,SCROLL-SNAP
---


제이슨 피멘탈의 최신 웹 폰트에는 몇 가지 흥미로운 CSS 속임수가 있다.

```css
columns: 100vw auto;
```

하지만 거기서부터 더 복잡하고 실망스럽죠.

열을 약간만 더 포맷하면 다음과 같은 이점이 있습니다.

```css
main {
  columns: 100vw auto;
  column-gap: 2rem;
  overflow-x: auto;
  height: calc(100vh - 2rem);
  font: 120%/1.4 Georgia;
}
```

우리는 이것을 안다:


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video controls="" src="https://css-tricks.com/wp-content/uploads/2020/06/columns.mp4" name="fitvid0"></video>
</div>


완벽에 가까워요!

이 효과를 데스크톱에 적용하지는 않을 것입니다. 하지만 미디어 쿼리는 바로 이 때문입니다. 모바일에서 얻을 수 있는 것은…


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video controls="" src="https://css-tricks.com/wp-content/uploads/2020/06/no-snap.mp4" name="fitvid1"></video>
</div>


그 허키 제르키 스크롤은 바로 그 곳에서 나쁜 경험을 하게 만들죠. 우리는 `-webkit-overflow-scrolling: touch;`를 통해 이 문제를 해결할 수 있다.


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video controls="" src="https://css-tricks.com/wp-content/uploads/2020/06/smooth-1.mp4" name="fitvid2"></video>
</div>


부드러움이 더 나을지 모르지만, 기둥들이 제자리에 끼워지지 않는다는 사실은 거의 독서 경험만큼이나 그것을 나쁜 것으로 만든다. 스크롤 스냅의 용도는 다음과 같습니다.

> 불행히도 스냅할 수 있는 블록 레벨 요소가 필요한 것으로 밝혀졌습니다. 인위적으로 생성된 열은 그렇게 계산되지 않습니다.

오오오오오오오오오오오오오오오오오오오. 아슬아슬해! 하지만 지금까지!

스크롤 스냅을 실제로 사용하려면 컨텐츠가 블록 레벨 요소(예: <div>)에 있어야 합니다. `div` 요소의 수평 행은 다음과 같은 플렉스 박스로 쉽게 설정할 수 있습니다.

```css
main {
  display: flex;
}
main > div {
  flex: 0 0 100vw;
}
```

하지만 몇 개의 div가 필요할까요? 누가 알겠어! 이것은 변경될 수 있는 임의 콘텐츠입니다. 우리가 알고 있다고 해도, 어떻게 하면 div들 사이에서 자연스럽게 컨텐츠를 흐를 수 있을까요? 그건 아무것도 아니야. 그래서 CSS 지역이 일어나지 않았다는 게 짜증나. 따라서 CSS에서 이러한 멋진 스위핑 경험을 가능하게 하려면 다음 중 하나가 필요합니다.

- 스크롤 스냅을 사용하여 열 작업 허용
- 컨텐츠에서 필요에 따라 반복 블록 레벨 요소를 자동 생성할 수 있는 CSS 영역 포함

지금은 둘 다 가능하지 않다.

제이슨은 거기서 멈추지 않았어! 그는 자바스크립트를 사용해서 무거운 스크롤 잭킹에 못 미치는 것을 알아냈습니다. 먼저, 그는 CSS 칼럼 기술의 폭이 얼마나 되는지 알아낸다. 그런 다음 스크롤 요소에 스페이서-div를 추가합니다. 각 요소는 페이지 너비와 스크롤 스냅을 통해 이동할 수 있습니다. 매우 총명하다.

지금은 서적 사이트에서 옵션 설정을 뒤집어 볼 수 있습니다.