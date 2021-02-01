---
layout: post
title: "내가 Tailwind를 사랑하는 이유"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/12/tailwind-card.png
tags: TAILWIND
---


Max Stoiber는 Tailwind를 좋아하는 이유에 대한 흥미로운 메모를 작성했습니다.
 (Max는 스타일링 된 구성 요소를 만들었으므로 스타일링 방법론 게임에 약간의 스킨이 있습니다.)이 게시물에는 Tailwind가 어떻게 등장하여 디자이너와 엔지니어 모두에게 귀중한 도구가되었는지에 대한 훌륭한 역사가 많이 있습니다.
 Tailwind 시스템의 핵심이며이 시스템을 매우 편리하게 만드는 이유는 다음과 같습니다.
 

> Tailwind의 인기의 핵심은 프레임 워크의 핵심에있는 디자인 토큰의 정성스럽게 구성된 시스템입니다.
 시스템의 신중하게 선택된 제약 조건은 개발자에게 올바른 가드 레일을 제공합니다.
 개별 단계 만 제공하여 선택이 좋은지 나쁜지 분명하게 만듭니다.
 

그는 twin.macro (전에 들어 보지 못했던 것)에 연결 한 다음 다음과 같은 예를 제공합니다.
 

```js
import "twin.macro"

<div tw="text-center md:text-left" />

// ↓↓↓↓↓ turns into ↓↓↓↓↓

import "styled-components/macro"

<div 
  css={
    textAlign: "center",
    "@media (min-width: 768px)": {
      "textAlign":"left"
    }
  }
/>
```

여기서 일어나는 일은 Tailwind에서와 마찬가지로 미리 정의 된 클래스를 사용할 수 있다는 것입니다. 간격을 추가하고 div 라운드를 만들고 특정 크기 등을 지정할 수 있습니다. twin.macro가하는 일은 이러한 클래스를 사용할 수 있도록하는 것입니다.
 CSS-in-JS.
 최대 쓰기 :
 

> 완전 자동으로 중요한 CSS 추출 및 코드 분할이 가능합니다.
 사용자는 요청한 페이지에 필요한 스타일 만로드합니다. 그 이상도 이하도 아닙니다!
 

저는 Tailwind를 축약 형으로 사용하여 프레임 워크가 아닌 CSS 위에있는 구문 설탕처럼 취급하는 것을 좋아합니다.
 매우 흥미로운 것들.
 

직접 링크 →
 