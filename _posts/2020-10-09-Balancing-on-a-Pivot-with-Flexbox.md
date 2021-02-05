---
layout: post
title: "Flexbox를 사용하여 피벗의 균형 조정"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/10/1st.png
tags: FLEXBOX
---


제가 최근에 발견한 피벗(pivot)을 중심으로 한 여러 요소들을 보여주는 방법을 보여드리겠습니다. 펑키한 HTML은 문제될 것이 없고 당신은 그 일을 완수하기 위해 어떤 최첨단 CSS도 알 필요가 없을 것이라고 약속드립니다.

저는 워드 게임에 관심이 많아서 최근에 제 웹사이트의 메인 메뉴를 크로스워드 퍼즐에 대한 끄덕임으로, 제 이름을 세로 단어로, 그리고 가로로 제 웹사이트의 메인 부분을 다시 상상했습니다.

대신 일부 색상의 이름을 사용하는 디자인은 다음과 같습니다.

다음은 이 퍼즐을 이끄는 HTML의 예입니다.

```html
<div class="puzzle">
  <div class="word">
    <span class="letter">i</span>
    <span class="letter">n</span>
    <span class="letter">d</span>
    <span class="letter">i</span>
    <span class="letter pivot">g</span>
    <span class="letter">o</span>
  </div>
  <!-- MORE WORDS -->
</div> 

```

이 예에서 문자 g는 피벗입니다. 중간 지점에 없는 거 보이죠? 그것이 바로 이 도전의 묘미입니다.

우리는 하드 코딩된 CSS 또는 인라인 사용자 지정 속성을 사용하여 각 단어에 오프셋을 적용하고 물러날 수 있었다. 확실히 문제를 해결하는 가장 분명한 방법이라는 점에서 상을 받지만, 단점이 있습니다. ".pivot" 클래스 외에도, 우리는 단어 하나하나에 대한 오프셋을 지정해야 합니다. 제 머릿속 목소리는 불필요한 중복을 더하고, 유연성이 떨어지며, 단어를 추가하거나 변경할 때마다 필요 없는 추가 짐이 필요하다는 것을 말해줍니다.

대신 한 걸음 뒤로 물러서서 퍼즐의 균형을 잡지 않고 어떻게 보이는지 봅시다.

피벗 앞에 있는 모든 문자를 숨기기 위해 `디스플레이: 없음`을 사용하는 경우를 잠시 상상해 보십시오. 이제 피벗과 피벗 뒤에 있는 모든 문자를 볼 수 있습니다.

더 이상의 변화가 없다면, 우리의 피벗은 이미 정렬되어 있을 것이다. 하지만 우리는 말의 시작을 잃었고, 숨겨진 부분들을 재도입할 때, 각각의 단어들이 오른쪽으로 밀려나고 모든 것이 다시 어긋나게 됩니다.

대신 후행 문자를 숨기면 여전히 잘못 정렬된 피벗이 남게 됩니다.

이 모든 것들이 약간 무의미해 보이지만, 제 문제에 대한 대칭성을 드러냅니다. 만약 우리가 오른쪽에서 왼쪽으로 읽는 방식을 사용한다면, 우리는 정반대의 문제를 가지게 될 것이다. 우리는 오른쪽을 풀 수 있을 것이다. 하지만 왼쪽은 모두 틀릴 것입니다.

양쪽이 동시에 줄을 설 수 있는 방법이 있다면 좋지 않을까요?

사실, 있습니다.

이미 절반의 해결책이 있다고 가정하면, 분할과 정복이라는 알고리즘의 개념을 빌려보자. 일반적인 생각은 문제를 부품별로 세분화하여 부품에 대한 해결책을 찾아냄으로써 전체 해결책을 찾을 수 있다는 것입니다.

그렇다면, 우리의 문제를 두 부분의 배치로 세분화해 봅시다. 첫 번째는 "머리" 또는 피벗 앞에 있는 모든 것입니다.

다음은 피벗과 그 뒤의 모든 것을 더한 "테일"입니다.

Flex 디스플레이 유형은 여기에 도움이 됩니다. 잘 모르면 Flex는 요소를 1차원으로 배치하는 프레임워크입니다. 여기서의 요령은 컨테이너의 왼쪽과 오른쪽 끝을 이용하여 정렬을 실시하는 것입니다. 이를 위해 우리는 헤드보다 더 작은 `순서` 속성 값을 사용하여 헤드와 테일 부품을 교환할 것이다. 순서 속성은 유연한 레이아웃에서 요소의 순서를 결정하는 데 사용됩니다. 더 작은 숫자는 흐름의 앞부분에 배치된다.

별도의 HTML 없이 머리와 꼬리 요소를 구분하기 위해 모든 문자에 스타일을 적용할 수 있으며, 이후 CSS의 계단식 특성을 사용하여 후속 형제 선택기 `.pivot ~ .letter`를 사용하여 피벗과 모든 것을 재정의합니다.

현재 상황은 다음과 같습니다.

자, 이제 머리가 꼬리 끝에 부딪혀서 내려앉았네요. 잠깐, 그것에 대해 불평하지 마! 꼬리 끝 요소의 오른쪽에 여백: auto를 적용하면 이것을 고칠 수 있다. 그것은 또한 우연히도 그 단어의 마지막 글자가 되었는데, 그 글자는 지금 가운데 어딘가에 놓여 있다. 자동 마진을 추가하면 머리를 꼬리로부터 멀리 밀어내고 용기 오른쪽 끝까지 밀어내는 역할을 합니다.

이제 다음과 같은 것이 있습니다.

남은 것은 우리의 조각들을 올바른 순서로 다시 꿰매는 것뿐이다. 모든 글자에 위치:상대적`을 적용한 뒤 꼬리 부분에 왼쪽:50%, 머리 부분에 오른쪽:50%를 붙이면 쉽게 할 수 있다.

여기 우리가 방금 사용한 코드의 일반화된 버전이 있습니다. 보시다시피, 간단한 CSS 15줄만 있습니다.

```css
.container {
  display: flex;
}
.item:last-child {
  margin-right: auto;
}
.item {
  order: 2;
  position: relative;
  right: 50%;
}
.pivot, .pivot ~ .item {
  order: 1;
  left: 50%;
}
```

또한 `변환 방향`을 `열` 값으로 설정하여 수직 레이아웃에 이 방식을 사용할 수도 있습니다. 머리와 꼬리 요소를 자신의 포장지에 붙이면 같은 결과를 얻을 수 있지만, 이는 훨씬 덜 유연하면서도 더 많은 마크업과 상세한 CSS를 필요로 할 것이다. 예를 들어, 우리의 백엔드가 동적으로 생성된 클래스로 포장되지 않은 요소 목록을 이미 생성하고 있다면 어떻게 될까?

매우 의미심장하게, 이 솔루션은 스크린 리더와도 잘 어울린다. 비록 우리가 두 부분을 거꾸로 주문하고 있지만, 우리는 상대적인 위치를 통해 그것들을 제자리로 다시 옮기고 있습니다. 그래서 요소들의 최종 순서는 우리의 마크업과 일치합니다. 비록 잘 중심적이긴 하지만요.


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video controls="" src="https://css-tricks.com/wp-content/uploads/2020/10/balancing.mp4" name="fitvid0"></video>
</div>


다음은 CodePen의 마지막 예입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_rNeRoxa" src="//codepen.io/anon/embed/rNeRoxa?height=450&amp;theme-id=1&amp;slug-hash=rNeRoxa&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed rNeRoxa" title="CodePen Embed rNeRoxa" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 결론

개발자들은 곡예사보다 균형을 잘 잡는다. 못 믿겠다는 거야? 생각해 보십시오. 우리가 직면하는 많은 일반적인 과제는 성능과 가독성, 스타일과 기능, 심지어 확장성과 단순성에 이르기까지 경쟁적 요구사항 사이에서 유리한 위치를 찾아야 합니다. 틀림없이 균형잡힌 행동이지

그러나 우리가 균형을 찾는 시점이 항상 이것과 다른 것의 중간인 것은 아니다. 균형은 종종 그 사이의 설명할 수 없는 지점에서 발견되거나, 우리가 방금 본 것처럼 임의 HTML 요소 주변에서 발견됩니다.

자, 이제 다 됐군요! 친구들한테 가서 네가 최고의 곡예사라고 말해.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/09/friends-ross-pivot.gif?resize=480%2C270&ssl=1)