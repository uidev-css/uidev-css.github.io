---
layout: post
title: "포커스가 보이는 요령"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/10/focus-visible-trick.jpg
tags: :FOCUS-VISIBLE,FOCUS,OUTLINE
---


항상 반복할 가치가 있음: 모든 대화형 요소는 초점 스타일을 가져야 합니다. 이렇게 하면 키보드 사용자가 언제 초점을 해당 요소로 이동했는지 알 수 있습니다.

그러나 이것을 위해 ":focus"를 단독으로 사용한다면, 많은 사람들이 좋아하지 않는 부작용을 가지고 있다. 즉, 대화식 요소를 마우스로 클릭하면 포커스 스타일이 표시됩니다. 때문에 그냥 거기 서서 클릭한 당신의 커서 움직였다 이론의 여지는 있지만, 당신은 마우스 사용자로 그 피드백이 필요하지 않다. 여러분이 어떻게 생각하시든 간에, 수년 동안 너무 많은 사람들을 짜증나게 해서 그들은 포커스 스타일을 완전히 없애버립니다. 이것은 웹상에서 접근성에 대한 거의 순손실입니다.

마우스가 아니라 키보드가 초점을 맞추는 데 사용될 때만 포커스 스타일을 적용할 수 있다면 어떨까요? Lea Verou는 몇 년 전에 이것에 손가락을 대었다.

그것은 Chrome이 깃발 뒤에 기능을 떨어뜨린 것에 대한 응답이었다. 영리하다.

몇 년 후, 크롬은 그것을 깃발 없이 출시할 것이다. 그들은 리아의 아이디어에 동의하고 있다.

> ':focus-visible'을 ':focus'와 결합하면 한 걸음 더 나아가 사용자의 입력 장치에 따라 다른 포커스 스타일을 제공할 수 있다. 이 기능은 포커스 표시기가 입력 장치의 정밀도에 따라 달라지도록 하려는 경우에 유용합니다.

```css
/* Focusing the button with a keyboard will show a dashed black line. */
button:focus-visible {
  outline: 4px dashed black;
}
  
/* Focusing the button with a mouse, touch, or stylus will show a subtle drop shadow. */
button:focus:not(:focus-visible) {
  outline: none;
  box-shadow: 1px 1px 5px rgba(1, 1, 0, .7);
}
```

버튼 없이 선택기를 사용해 보는 것이 좋을 것 같아. 그러면 선택기가 전 세계에 적용될 수 있을 거야!

더 자세히 살펴볼 사항이 있습니다. 여기에 몇 가지 정보를 추가해 보겠습니다.

- 크롬 블로그 게시물은 셀렉터의 휴리스틱을 다룬다. 까다로워요. 이것은 마치 `:focus-visible`이 일치할 것인지 아닌지를 결정하는 알고리즘이 있는 것과 같으며, 여러분이 대체로 신뢰하면 됩니다. 파이어폭스가 오랫동안:-moz-focusring을 해왔다는 생각도 포함하지만, 일관된 동작을 위해 촬영한다면 사용하지 않는 것을 추천하지 않을 정도로 행동이 다르다.
- 마티아스 오트는 공식 폴리필을 사용하는 것과 DevTools에서 스타일을 제대로 보는 방법 등 몇 가지 좋은 정보를 가지고 그것에 대해 블로그를 했다.
- 저희가 취재한 적이 있어요. 그 안에서, 우리는 리아가 실제로 배송될 때 사용량은 폭발적으로 증가할 것이라고 생각한다는 트윗에 주목했다. 어디 보자!
- 연감 항목에는 많은 세부 사항이 있습니다.