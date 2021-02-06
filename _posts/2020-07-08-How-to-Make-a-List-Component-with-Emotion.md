---
layout: post
title: "감정으로 목록 구성 요소를 만드는 방법"
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/07/emotion-lists.png"
tags: COMPONENTS,EMOTION,LISTS
---


이번 주에 Sentry에서 리팩터링을 했는데 프로젝트와 기능에 걸쳐 사용할 수 있는 일반적인 List 구성 요소가 없다는 것을 알게 되었습니다. 그래서 저는 하나를 시작했지만, 여기 문제가 있습니다. 우리는 Sentry에서 감정을 사용해서 스타일링을 합니다. 제가 단지 전달한 경험만 있고, 의사록에 다음과 같이 설명되어 있습니다.

> […] 자바스크립트로 css 스타일을 쓰도록 설계된 라이브러리. 소스 맵, 레이블 및 테스트 유틸리티와 같은 기능을 갖춘 뛰어난 개발자 경험과 더불어 강력하고 예측 가능한 스타일 구성을 제공합니다. 문자열 및 개체 스타일이 모두 지원됩니다.

만약 여러분이 Emotion에 대해 들어본 적이 없다면, 일반적인 생각은 이렇습니다. 우리가 많은 구성 요소를 가진 빅 코드베이스를 연구할 때, 우리는 우리가 CSS의 캐스케이드를 제어할 수 있도록 확실히 하고 싶습니다. 예를 들어, 한 파일에 .active 클래스가 있는데 ".active" 클래스가 있는 다른 파일의 완전히 다른 구성 요소 스타일에 영향을 미치지 않도록 해야 합니다.

감정은 클래스 이름에 사용자 지정 문자열을 추가하여 다른 구성 요소와 충돌하지 않도록 함으로써 이 문제를 해결합니다. 다음은 출력할 수 있는 HTML의 예입니다.

```html
<div class="css-1tfy8g7-List e13k4qzl9"></div>
```

꽤 멋지지, 응? CSS Module과 같이 매우 유사한 기능을 하는 툴과 워크플로우가 많이 있습니다.

구성 요소를 만들기 시작하려면 먼저 프로젝트에 Emotion을 설치해야 합니다. 환경이나 설정에 따라 달라질 것이기 때문에 저는 그런 것들을 검토하지 않을 것입니다. 그러나 이 작업이 완료되면 다음과 같은 새로운 구성 요소를 생성할 수 있습니다.

```js
import React from 'react';
import styled from '@emotion/styled';

export const List = styled('ul')`
  list-style: none;
  padding: 0;
`;
```

내가 보기에 이것은 꽤 이상하게 보인다. 왜냐하면 우리는 `울`이라는 요소를 위한 스타일을 쓰고 있을 뿐만 아니라, 그 구성 요소가 `울`을 만들어야 한다고 정의하고 있기 때문이다. 마크업과 스타일을 한 곳에 결합하는 것은 이상하지만 나는 그것이 얼마나 간단한지 좋아한다. 그것은 단지 내 멘탈 모델과 HTML, CSS, 그리고 자바스크립트 사이의 고민의 분리를 엉망으로 만들 뿐이다.

다른 구성 요소에서는 이 `<List>`를 가져와 다음과 같이 사용할 수 있습니다.

```js
import List from 'components/list';

<List>This is a list item.</List>
```

목록 구성요소에 추가한 스타일은 ".oefioaug"와 같은 클래스 이름으로 변환된 다음 구성요소에 정의된 ul" 요소에 추가됩니다.

하지만 우린 아직 끝나지 않았어! 리스트 디자인으로 나는 같은 구성 요소로 <울>과 <올>을 만들 수 있어야 했다. 각 목록 항목 안에 아이콘을 넣을 수 있는 버전도 필요했습니다. 이것처럼:

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/07/85650426-61a90480-b65a-11ea-942d-6b0da83fc4fe.png?resize=379%2C322&ssl=1)

Emotion의 멋진 점은 구성 요소를 가져올 때 렌더링할 HTML 요소를 선택하기 위해 as 속성을 사용할 수 있다는 것입니다. 이 속성을 사용하면 사용자 정의 유형 속성 등을 만들지 않고도 `올` 변형을 만들 수 있습니다. 그리고 그것은 이렇게 보입니다.

```js
<List>This will render a ul.</List>
<List as="ol">This will render an ol.</List>
```

그게 나한테 이상한 것만은 아니지? 하지만, 이것은 우리가 단지 마크업을 바꾸기 위해 요소 자체에 비자로 논리적인 것을 할 필요가 없다는 것을 의미하기 때문에 아주 깔끔합니다.

이 시점에서 저는 이 구성 요소를 위한 완벽한 API가 어떻게 보일지 기록하기 시작했습니다. 왜냐하면 거기서부터 다시 시작할 수 있기 때문입니다. 제가 상상했던 것은 이것입니다.

```js
<List>
  <ListItem>Item 1</ListItem>
  <ListItem>Item 2</ListItem>
  <ListItem>Item 3</ListItem>
</List>

<List>
  <ListItem icon={<IconBusiness color="orange400" size="sm" />}>Item 1</ListItem>
  <ListItem icon={<IconBusiness color="orange400" size="sm" />}>Item 2</ListItem>
  <ListItem icon={<IconBusiness color="orange400" size="sm" />}>Item 3</ListItem>
</List>

<List as="ol">
  <ListItem>Item 1</ListItem>
  <ListItem>Item 2</ListItem>
  <ListItem>Item 3</ListItem>
</List>
```

그래서 이 스케치를 만든 후 나는 두 개의 구성요소가 필요하다는 것을 알았다. 그리고 `<ListItem>에 아이콘 하위 구성요소를 중첩시키는 기능. 이렇게 시작할 수 있습니다.

```js
import React from 'react';
import styled from '@emotion/styled';

export const List = styled('ul')`
  list-style: none;
  padding: 0;
  margin-bottom: 20px;

  ol& {
    counter-reset: numberedList;
  }
`;
```

그 독특한 `올`

다음은 우리의 하위 구성 요소인 `<List Item>`입니다. Sentry에서는 TypeScript도 사용하므로 `<ListItem> 구성 요소를 정의하기 전에 먼저 소품을 설정해야 합니다.

```js
type ListItemProps = {
  icon?: React.ReactNode;
  children?: string | React.ReactNode;
  className?: string;
};
```

이제 `List Item` 내에 `Icon` 구성 요소의 크기를 결정하는 `IconWrapper` 구성 요소를 추가할 수 있습니다. 위의 예에서 기억하신다면, 저는 이것이 이렇게 생겼으면 합니다.

```js
<List>
  <ListItem icon={<IconBusiness color="orange400" size="sm" />}>Item 1</ListItem>
  <ListItem icon={<IconBusiness color="orange400" size="sm" />}>Item 2</ListItem>
  <ListItem icon={<IconBusiness color="orange400" size="sm" />}>Item 3</ListItem>
</List>
```

그 `아이콘 비즈니스` 부품은 기존 부품으로 우리는 그것을 스타일링할 수 있도록 스팬으로 포장하고 싶다. 다행히도 아이콘을 텍스트에 맞게 조정하기 위해 아주 작은 양의 CSS만 있으면 됩니다. `IconWrapper`는 이 모든 것을 처리할 수 있습니다.

```js
type ListItemProps = {
  icon?: React.ReactNode;
  children?: string | React.ReactNode;
  className?: string;
};

const IconWrapper = styled('span')`
  display: flex;
  margin-right: 15px;
  height: 16px;
  align-items: center;
`;
```

이렇게 하면 훨씬 복잡하지만 마침내 이 두 가지 아래에 `List Item` 구성 요소를 추가할 수 있습니다. 소품을 추가한 다음 아이콘 소품이 있을 때 위에 있는 <아이콘 래퍼>를 렌더링하고 전달된 아이콘 구성 요소도 렌더링할 수 있습니다. 또한 아래의 모든 스타일을 추가하여 각 모델의 스타일링을 확인할 수 있습니다.

```js
export const ListItem = styled(({icon, className, children}: ListItemProps) => (
  <li className={className}>
    {icon && (
      <IconWrapper>
        {icon}
      </IconWrapper>
    )}
    {children}
  </li>
))<ListItemProps>`
  display: flex;
  align-items: center;
  position: relative;
  padding-left: 34px;
  margin-bottom: 20px;
 
  /* Tiny circle and icon positioning */
  &:before,
 & > ${IconWrapper} {
    position: absolute;
    left: 0;
  }

  ul & {
    color: #aaa;
    /* This pseudo is the tiny circle for ul items */ 
    &:before {
      content: '';
      width: 6px;
      height: 6px;
      border-radius: 50%;
      margin-right: 15px;
      border: 1px solid #aaa;
      background-color: transparent;
      left: 5px;
      top: 10px;
    }
  
    /* Icon styles */
    ${p =>
      p.icon &&
      `
      span {
        top: 4px;
      }
      /* Removes tiny circle pseudo if icon is present */
      &:before {
        content: none;
      }
    `}
  }
  /* When the list is rendered as an <ol> */
  ol & {
    &:before {
      counter-increment: numberedList;
      content: counter(numberedList);
      top: 3px;
      display: flex;
      align-items: center;
      justify-content: center;
      text-align: center;
      width: 18px;
      height: 18px;
      font-size: 10px;
      font-weight: 600;
      border: 1px solid #aaa;
      border-radius: 50%;
      background-color: transparent;
      margin-right: 20px;
    }
  }
`;
```

그리고 네가 가지고 있어! Emotion을 사용하여 만든 비교적 단순한 <List> 구성요소입니다. 하지만 이 연습을 한 후에도 구문이 마음에 드는지 잘 모르겠어요. 저는 이것이 간단한 것들을 정말 간단하게 만들지만 중간 크기의 구성품들은 그것들보다 훨씬 더 복잡하다고 생각합니다. 게다가, 새로 온 사람에게 꽤 혼란스러울 수도 있고 그것은 나를 약간 걱정하게 한다.

하지만 모든 것은 배움의 경험인 것 같아. 어느 쪽이든, 저는 이 작은 부품을 다룰 기회가 있어서 기쁩니다. 왜냐하면 이 부품이 TypeScript, React, 그리고 우리의 스타일을 어느 정도 읽을 수 있도록 하기 위해 노력하는 것에 대한 몇 가지 좋은 점을 가르쳐줬기 때문입니다.