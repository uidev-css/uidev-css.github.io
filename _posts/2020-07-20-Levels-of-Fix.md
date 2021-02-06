---
layout: post
title: "수정 수준"
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2017/04/tools.jpg"
tags: MAINTENANCE
---


웹에서, 우리는 사람들을 위한 것들을 고치는 일을 할 수 있는 기회를 가지고 있습니다. 이러한 수정의 범위가 얼마나 다를 수 있는지 매우 흥미롭습니다.

미디어 쿼리 `기본 설정 축소-모션`을 고려하십시오. 에릭은 이렇게 썼다.

> 또한 '선호감소운동'이 나타내는 진정한 가치를 지적할 필요가 있다고 생각한다. LinkedIn에서 유행어에 굶주린 채용자들을 끌어들이는 것이 아니라, 그것이 창출하는 효과로 이득을 보는 사람들의 삶의 질을 향상시키는 것이다. 이 미디어 쿼리를 사용하면 단순히 링크를 클릭하거나 페이지를 스크롤할 수 있는 호기심 때문에 누군가가 불필요하게 엄청난 고통을 감수하지 않아도 될 수 있다.

이 미디어 쿼리는 전적으로 사람들의 웹에서의 경험을 더 좋게 만들기 위한 것이다. 우리는 명시적으로 모션 축소를 요청한 사용자를 위해 모션 축소를 위한 코드를 작성할 수 있다.

사람들이 운동을 줄여달라고 요구하기 때문에 절대 제로 모션을 요구하는 것은 아니라는 사실에 주목할 필요가 있다. 하지만 그건 잠시 접어둡시다. 사용자에게 가장 적합한 감소 수준을 파악할 수 있는 미묘한 작업을 수행할 준비가 되어 있지 않다면 0으로 전환하는 것이 더 나을 수 있습니다.

사이트에 대한 모든 모션을 무효화한다고 가정해봅시다. 이렇게 할 수 있습니다.

```css
@media (prefers-reduced-motion: reduce), (update: slow) {
  *, ::before, ::after {
    animation-delay: -1ms !important;
    animation-duration: 1ms !important;
    animation-iteration-count: 1 !important;
    background-attachment: initial !important;
    scroll-behavior: auto !important;
    transition-duration: 0s !important;
    transition-delay: 0s !important;
  }
}
```

이를 통해 모든 사용자에게 더 적은 모션, 즉 하나의 사이트에 대해 더 적은 모션을 원하는 모든 사용자를 위해 사이트를 수정합니다. 그게 우리가 맞출 수 있는 범위 중 하나야.

우리가 웹 작업자로서 할 수 있는 또 다른 일은 브라우저 확장입니다. 기적적으로, 웹은 확장에 대한 표준화된 형식을 가지고 있기 때문에, 당신은 대체로 그것을 한 번 쓰고 어떤 데스크탑 브라우저에도 그것을 보낼 수 있다. 확장을 만들 때, 다른 사람에게 사용을 강요할 수 없습니다. 그리고 사이트를 방문하는 매우 낮은 비율의 사람들이 확장을 설치하게 될 것입니다. 혜택을 받을 수 있는 사람들은 더더욱 그렇지 않습니다. 그러나 이러한 사이트의 경우 한 개인에 대한 모든 사이트를 수정했습니다. 그것은 매우 다르지만 또한 매우 흥미롭고 강력한 범위입니다.

그렇다면 몇몇 사람들이 스스로 브라우저에서 작업하는 것에 매력을 느끼는 것도 당연하다. 또는 해당 작업을 안내하는 표준 조직을 위한 것입니다. 저는 브라우저가 CSS 수준에서 강제로 축소된 동작과 같은 것을 구현해야 한다고 말하는 것이 아닙니다. 하지만 그들은 그렇게 할 수 있습니다. 브라우저나 표준 수준에서 어떤 것을 고친다면, 모든 사용자들을 위한 어떤 것을 고칠 수 있을 것입니다. 이것이 가장 큰 범위입니다.

제게는 매우 흥미로운 것은 이 다른 영역입니다.

- 모든 사용자에 대해 하나의 사이트 수정
- 한 사용자에 대한 모든 사이트 수정
- 모든 사용자의 모든 사이트 수정

하나만 고르실 필요는 없습니다. 우리들 대부분은 아마 첫 번째 양동이로 일을 할 것이다. 하지만 당신의 어떤 작품이 다른 작품들을 향할 수 있을지 생각해 볼 가치가 있다.