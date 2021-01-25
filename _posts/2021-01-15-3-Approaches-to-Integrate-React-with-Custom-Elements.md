---
layout: post
title: "React를 커스텀 요소와 통합하는 3 가지 접근법"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2018/09/react-recompose-hand.png
tags: CUSTOM ELEMENTS,REACT
---


디자인과 코드의 교차점에있는 웹 개발자로서의 제 역할에서 저는 그들의 이식성 때문에 웹 컴포넌트에 끌립니다.
 사용자 정의 요소는 모든 최신 브라우저에서 작동하는 모든 기능을 갖춘 HTML 요소이며, Shadow DOM은 사용자 정의를위한 적절한 표면 영역으로 올바른 스타일을 캡슐화합니다.
 특히 Angular, Svelte 및 Vue와 같은 여러 프레임 워크에서 일관된 사용자 경험을 만들고자하는 대규모 조직에 매우 적합합니다.

그러나 내 경험상 많은 개발자가 커스텀 요소가 작동하지 않는다고 믿는 이상 치가 있습니다. 특히 React로 작업하는 개발자는 현재 가장 인기있는 프런트 엔드 라이브러리입니다.
 사실, React는 웹 구성 요소 사양과의 호환성을 높일 수있는 확실한 기회가 있습니다.
 그러나 React가 웹 컴포넌트와 깊이 통합 할 수 없다는 생각은 신화입니다.

이 기사에서는 React 애플리케이션을 Web Components와 통합하여 (거의) 완벽한 개발자 경험을 만드는 방법을 살펴볼 것입니다.
 React의 모범 사례와 제한 사항을 살펴본 다음 사용자 지정 요소와 오늘날 가장 인기있는 프레임 워크를보다 밀접하게 결합하기 위해 일반 래퍼와 사용자 지정 JSX pragma를 만듭니다.

### 선 색칠

React가 색칠하기 책이라면-은유를 용서하세요. 저는 색칠하기를 좋아하는 두 명의 어린 아이들이 있습니다. 사용자 정의 요소로 작업하기 위해 줄 안에 머물 수있는 확실한 방법이 있습니다.
 먼저 텍스트 입력을 Shadow DOM에 연결하고 값이 변경 될 때 이벤트를 내보내는 매우 간단한 맞춤 요소를 작성하겠습니다.
 단순함을 위해 LitElement를 기본으로 사용하지만 원하는 경우 처음부터 사용자 정의 요소를 작성할 수 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_ExgoXdY" src="//codepen.io/anon/embed/ExgoXdY?height=250&amp;theme-id=1&amp;slug-hash=ExgoXdY&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed ExgoXdY" title="CodePen Embed ExgoXdY" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div> 

우리의`super-cool-input` 요소는 기본적으로 맞춤 이벤트를 생성하는 일반 ol ``<input>`요소에 대한 몇 가지 스타일이있는 래퍼입니다.
 사용자에게 가능한 가장 불쾌한 방법으로 현재 값을 알려주는`reportValue` 메소드가 있습니다.
 이 요소가 가장 유용하지 않을 수도 있지만 React에 연결하는 동안 설명 할 기술은 다른 사용자 정의 요소 작업에 도움이 될 것입니다.

### 접근법 1 : 참조 사용

웹 컴포넌트에 대한 React의 문서에 따르면 "웹 컴포넌트의 명령형 API에 액세스하려면 참조를 사용하여 DOM 노드와 직접 상호 작용해야합니다."

React는 현재 네이티브 DOM 이벤트를 수신 할 수있는 방법이없고 (대신 고유 한 `SyntheticEvent`시스템을 사용하는 것을 선호 함), A를 사용하지 않고 현재 DOM 요소에 선언적으로 액세스 할 수있는 방법이 없기 때문에 필요합니다.
 심판.

React의`useRef` 후크를 사용하여 우리가 정의한 네이티브 DOM 요소에 대한 참조를 생성합니다.
 또한 React의`useEffect` 및`useState` 후크를 사용하여 입력 값에 액세스하고이를 앱에 렌더링합니다.
 또한 값이 "rad"라는 단어의 변형 인 경우 ref를 사용하여`super-cool-input`의`reportValue` 메서드를 호출합니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 300px;"><iframe id="cp_embed_dypJRBO" src="//codepen.io/anon/embed/dypJRBO?height=300&amp;theme-id=1&amp;slug-hash=dypJRBO&amp;default-tab=result" height="300" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed dypJRBO" title="CodePen Embed dypJRBO" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>
위의 예에서 주목해야 할 점은 React 컴포넌트의`useEffect` 블록입니다.

```jsx
useEffect(() => {
  coolInput.current.addEventListener('custom-input', eventListener);
  
  return () => {
    coolInput.current.removeEventListener('custom-input', eventListener);
  }
});
```

`useEffect` 블록은 부작용 (React에서 관리하지 않는 이벤트 리스너 추가)을 생성하므로, 의도하지 않은 메모리 누수가 발생하지 않도록 구성 요소를 변경해야 할 때 이벤트 리스너를 제거하는 데주의해야합니다.

위의 예제는 단순히 이벤트 리스너를 바인딩하지만 이는 DOM 속성 (React props 또는 DOM 속성이 아닌 DOM 개체의 항목으로 정의 됨)에 바인딩하는 데 사용할 수있는 기술이기도합니다.

이것은 나쁘지 않습니다.
 React에서 작동하는 커스텀 요소가 있고 커스텀 이벤트에 바인딩하고 여기에서 값에 액세스하고 커스텀 요소의 메서드도 호출 할 수 있습니다.
 작동하지만 장황하고 실제로 React처럼 보이지 않습니다.

### 접근 방식 2 : 래퍼 사용

React 애플리케이션에서 커스텀 요소를 사용하려는 다음 시도는 요소에 대한 래퍼를 만드는 것입니다.
 래퍼는 단순히 소품을 요소로 전달하고 일반적으로 React에서 사용할 수없는 요소의 일부와 인터페이스하기위한 API를 생성하는 React 구성 요소입니다.

여기에서는 복잡성을 맞춤 요소의 래퍼 구성 요소로 이동했습니다.
 새로운`CoolInput` React 구성 요소는 모든 소비 구성 요소가 다른 React 구성 요소와 마찬가지로 props를 전달할 수 있도록 이벤트 리스너를 추가 및 제거하는 동안 ref 생성을 관리합니다.

```JSX
function CoolInput(props) {
  const ref = useRef();
  const { children, onCustomInput, ...rest } = props;
  
  function invokeCallback(event) {
    if (onCustomInput) {
      onCustomInput(event, ref.current);
    }
  }
  
  useEffect(() => {
    const { current } = ref;
    current.addEventListener('custom-input', invokeCallback);
    return () => {
      current.removeEventListener('custom-input', invokeCallback);
    }
  });
  
  return <super-cool-input ref={ref} {...rest}>{children}</super-cool-input>;
}
```

이 구성 요소에서 우리는 존재하는 경우 부모 구성 요소에서 이벤트 콜백을 트리거하는 소품 `onCustomInput`을 만들었습니다.
 일반 이벤트 콜백과 달리, 우리는`CoolInput`의 내부 참조의 현재 값을 전달하는 두 번째 인수를 추가하기로 선택했습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_abmELOV" src="//codepen.io/anon/embed/abmELOV?height=450&amp;theme-id=1&amp;slug-hash=abmELOV&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed abmELOV" title="CodePen Embed abmELOV" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>
이와 동일한 기술을 사용하여 Mathieu Puech의이`reactifyLitElement` 구성 요소와 같은 사용자 정의 요소에 대한 일반 래퍼를 만들 수 있습니다.
 이 특정 구성 요소는 React 구성 요소를 정의하고 전체 수명주기를 관리합니다.

### 접근법 3 : JSX pragma 사용

또 다른 옵션은 JSX pragma를 사용하는 것입니다. 이는 React의 JSX 파서를 가로 채고 언어에 자체 기능을 추가하는 것과 같습니다.
 아래 예에서는 Skypack에서 jsx-native-events 패키지를 가져옵니다.
 이 pragma는 React 요소에 추가 prop 유형을 추가하고`onEvent `접두사가 붙은 모든 prop은 호스트에 이벤트 리스너를 추가합니다.

pragma를 호출하려면 사용중인 파일로 가져 와서 파일 맨 위에있는`/ ** @jsx <PRAGMA_NAME> * /`주석을 사용하여 호출해야합니다.
 JSX 컴파일러는 일반적으로이 주석으로 무엇을해야하는지 알고 있습니다 (그리고 Babel은이 주석을 전역으로 만들도록 구성 할 수 있습니다).
 Emotion과 같은 라이브러리에서 이것을 보았을 것입니다.

`onEventInput = {callback}`prop이있는`<input>`요소는 이름이` `input`` 인 이벤트가 전달 될 때마다`callback` 함수를 실행합니다.
 이것이 우리의 `Super-cool-input`을 어떻게 찾는 지 봅시다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 300px;"><iframe id="cp_embed_abmEVOX" src="//codepen.io/anon/embed/abmEVOX?height=300&amp;theme-id=1&amp;slug-hash=abmEVOX&amp;default-tab=result" height="300" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed abmEVOX" title="CodePen Embed abmEVOX" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>
pragma의 코드는 GitHub에서 사용할 수 있습니다.
 React props 대신 네이티브 속성에 바인딩하려면 react-bind-properties를 사용할 수 있습니다.
 그것에 대해 간단히 살펴 보겠습니다.

```JSX
import React from 'react'

/**
 * Convert a string from camelCase to kebab-case
 * @param {string} string - The base string (ostensibly camelCase)
 * @return {string} - A kebab-case string
 */
const toKebabCase = string => string.replace(/([a-z0-9]|(?=[A-Z]))([A-Z])/g, '$1-$2').toLowerCase()

/** @type {Symbol} - Used to save reference to active listeners */
const listeners = Symbol('jsx-native-events/event-listeners')

const eventPattern = /^onEvent/

export default function jsx (type, props, ...children) {
  // Make a copy of the props object
  const newProps = { ...props }
  if (typeof type === 'string') {
    newProps.ref = (element) => {
      // Merge existing ref prop
      if (props && props.ref) {
        if (typeof props.ref === 'function') {
          props.ref(element)
        } else if (typeof props.ref === 'object') {
          props.ref.current = element
        }
      }

      if (element) {
        if (props) {
          const keys = Object.keys(props)
          /** Get all keys that have the `onEvent` prefix */
          keys
            .filter(key => key.match(eventPattern))
            .map(key => ({
              key,
              eventName: toKebabCase(
                key.replace('onEvent', '')
              ).replace('-', '')
            })
          )
          .map(({ eventName, key }) => {
            /** Add the listeners Map if not present */
            if (!element[listeners]) {
              element[listeners] = new Map()
            }

            /** If the listener hasn't be attached, attach it */
            if (!element[listeners].has(eventName)) {
              element.addEventListener(eventName, props[key])
              /** Save a reference to avoid listening to the same value twice */
              element[listeners].set(eventName, props[key])
            }
          })
        }
      }
    }
  }
  
  return React.createElement.apply(null, [type, newProps, ...children])
}
```

기본적으로이 코드는`onEvent` 접두사가있는 기존 소품을 변환하고 이벤트 이름으로 변환하여 해당 소품에 전달 된 값 (겉보기에는`(e : Event) => void` 서명이있는 함수)을 가져와 추가합니다.
 요소 인스턴스의 이벤트 리스너로.

### 기대

이 글을 쓰는 시점에서 React는 최근 버전 17을 출시했습니다. React 팀은 처음에 커스텀 요소와의 호환성을위한 개선을 출시 할 계획이었습니다.
 안타깝게도 이러한 계획은 버전 18로 되돌아 간 것 같습니다.

그때까지는 커스텀 엘리먼트가 React에서 제공하는 모든 기능을 사용하려면 약간의 추가 작업이 필요합니다.
 바라건대, React 팀은 React와 웹 플랫폼 간의 격차를 해소하기 위해 계속해서 지원을 개선 할 것입니다.