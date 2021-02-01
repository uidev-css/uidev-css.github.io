---
layout: post
title: "JavaScript로 경량 네이티브 이벤트 버스를 만들어 보겠습니다."
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/12/event-bus-js-vw.jpg
tags: EVENT BUS
---


이벤트 버스는 서로 다른 구성 요소 간의 통신을 단순화하는 데 사용할 수있는 디자인 패턴입니다 (여기서는 JavaScript에 대해 설명하지만 모든 언어의 디자인 패턴).
 발행 / 구독 또는 pubsub로 생각할 수도 있습니다.
 

아이디어는 구성 요소가 이벤트 버스를 수신하여 작업을 언제 수행해야하는지 알 수 있다는 것입니다.
 예를 들어 "탭 패널"구성 요소는 활성 탭을 변경하라는 이벤트를 수신 할 수 있습니다.
 물론 탭 중 하나를 클릭하면 발생할 수 있으므로 해당 구성 요소 내에서 전적으로 처리됩니다.
 그러나 이벤트 버스를 사용하면 다른 요소가 탭을 변경하도록 지시 할 수 있습니다.
 특정 탭 내에서 사용자에게 경고해야하는 오류를 발생시키는 양식 제출을 상상해보십시오. 그러면 양식은 탭 구성 요소에 활성 탭을 오류가있는 탭으로 변경하라는 메시지를 이벤트 버스에 보냅니다.
 그것이 이벤트 버스를 타고있는 모습입니다.
 

해당 상황에 대한 의사 코드는 다음과 같습니다.
 

```js
// Tab Component
Tabs.changeTab = id => {
  // DOM work to change the active tab.
}
MyEventBus.subscribe("change-tab", Tabs.changeTab(id));

// Some other component...
// something happens, then:
MyEventBus.publish("change-tab", 2);  
```

이것에 JavaScript 라이브러리가 필요합니까?
 (트릭 질문 : JavaScript 라이브러리가 필요하지 않습니다).
 글쎄, 거기에는 많은 옵션이 있습니다.
 

- PubSubJS
 
- EventEmitter3
 
- Postal.js
 
- jQuery는이 패턴과 밀접한 관련이있는 사용자 지정 이벤트도 지원했습니다.
 

또한 200 바이트 만 gzip으로 압축 된 라이브러리 인 Mitt를 확인하십시오.
 이 간단한 패턴에는 사람들이 가능한 가장 간결한 방식으로 스스로 해결하도록 영감을주는 무언가가 있습니다.
 

우리 스스로 해보자!
 우리는 타사 라이브러리를 전혀 사용하지 않고 우리 모두가 알고 사랑하는`addEventListener`를 사용하여 이미 JavaScript에 내장 된 이벤트 수신 시스템을 활용할 것입니다.
 

### 첫째, 약간의 맥락
 

JavaScript의`addEventListener` API는`EventTarget` 클래스의 멤버 함수입니다.
 `click` 이벤트를 버튼에 바인딩 할 수있는 이유는`<button>`(`HTMLButtonElement`)의 프로토 타입 인터페이스가`EventTarget`에서 간접적으로 상속되기 때문입니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_EEDF7EEC71CD55E8242F1743FD7AB20E1FEDAA582E464ED2795C01607BFBC94E_1606036602705_image.png?resize=527%2C138&ssl=1)

대부분의 다른 DOM 인터페이스와 달리`EventTarget`은`new` 키워드를 사용하여 직접 만들 수 있습니다.
 모든 최신 브라우저에서 지원되지만 최근에야 지원됩니다.
 위의 스크린 샷에서 볼 수 있듯이`Node`는`EventTarget`을 상속하므로 모든 DOM 노드에는`addEventListener` 메소드가 있습니다.
 

### 여기에 트릭이 있습니다.
 

이벤트 수신 버스 역할을하는 매우 가벼운 `노드`유형 인 HTML 주석 (`<!-``comment``->`)을 제안합니다.
 

브라우저 렌더링 엔진에서 HTML 주석은 개발자를위한 설명 텍스트 이외의 기능이없는 코드의 메모 일뿐입니다.
 그러나 주석은 여전히 HTML로 작성되기 때문에 DOM에서 실제 노드로 끝나고`Node`를 상속하는 자체 프로토 타입 인터페이스 인`Comment`를 갖습니다.
 

`Comment` 클래스는`EventTarget`이 할 수있는 것처럼`new`에서 직접 만들 수 있습니다.
 

```js
const myEventBus = new Comment('my-event-bus');
```

오래되었지만 널리 지원되는`document.createComment` API를 사용할 수도 있습니다.
 댓글의 내용 인 `data`매개 변수가 필요합니다.
 빈 문자열 일 수도 있습니다.
 

```js
const myEventBus = document.createComment('my-event-bus');
```

이제`Event` 객체를받는`dispatchEvent`를 사용하여 이벤트를 내보낼 수 있습니다.
 사용자 정의 이벤트 데이터를 전달하려면 `CustomEvent`를 사용하세요. 여기서 `detail`필드는 모든 데이터를 포함하는 데 사용할 수 있습니다.
 

```js
myEventBus.dispatchEvent(
  new CustomEvent('event-name', { 
    detail: 'event-data'
  })
);
```

Internet Explorer 9-11은`CustomEvent`를 지원하지만 어떤 버전도`new CustomEvent`를 지원하지 않습니다.
 `document.createEvent`를 사용하여 시뮬레이션하는 것은 복잡하므로 IE 지원이 중요한 경우이를 폴리 필하는 방법이 있습니다.
 

이제 이벤트 리스너를 바인딩 할 수 있습니다.
 

```html
myEventBus.addEventListener('event-name', ({ detail }) => {
  console.log(detail); // => event-data
});
```

이벤트가 한 번만 트리거되도록하려면 일회성 바인딩에`{once : true}`를 사용할 수 있습니다.
 다른 옵션은 여기에 맞지 않습니다.
 이벤트 리스너를 제거하려면 기본`removeEventListener`를 사용할 수 있습니다.
 

### 디버깅
 

단일 이벤트 버스에 바인딩 된 이벤트 수는 엄청날 수 있습니다.
 제거하는 것을 잊은 경우에도 메모리 누수가 발생할 수 있습니다.
 `myEventBus`에 바인딩 된 이벤트 수를 알고 싶다면 어떻게해야합니까?
 

`myEventBus`는 DOM 노드이므로 브라우저에서 DevTools로 검사 할 수 있습니다.
 여기에서 요소 → 이벤트 리스너 탭에서 이벤트를 찾을 수 있습니다.
 `문서`및 `창`에 바인딩 된 이벤트를 숨기려면 `조상`을 선택 취소해야합니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_EEDF7EEC71CD55E8242F1743FD7AB20E1FEDAA582E464ED2795C01607BFBC94E_1606037405793_image.png?resize=694%2C213&ssl=1)

### 예
 

한 가지 단점은`EventTarget`의 구문이 약간 장황하다는 것입니다.
 간단한 래퍼를 작성할 수 있습니다.
 아래는 TypeScript의 데모입니다.
 

```js
class EventBus<DetailType = any> {
  private eventTarget: EventTarget;
  constructor(description = '') { this.eventTarget = document.appendChild(document.createComment(description)); }
  on(type: string, listener: (event: CustomEvent<DetailType>) => void) { this.eventTarget.addEventListener(type, listener); }
  once(type: string, listener: (event: CustomEvent<DetailType>) => void) { this.eventTarget.addEventListener(type, listener, { once: true }); }
  off(type: string, listener: (event: CustomEvent<DetailType>) => void) { this.eventTarget.removeEventListener(type, listener); }
  emit(type: string, detail?: DetailType) { return this.eventTarget.dispatchEvent(new CustomEvent(type, { detail })); }
}
    
// Usage
const myEventBus = new EventBus<string>('my-event-bus');
myEventBus.on('event-name', ({ detail }) => {
  console.log(detail);
});

myEventBus.once('event-name', ({ detail }) => {
  console.log(detail);
});

myEventBus.emit('event-name', 'Hello'); // => Hello Hello
myEventBus.emit('event-name', 'World'); // => World
```

다음 데모는 컴파일 된 JavaScript를 제공합니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_OJRPJaN" src="//codepen.io/anon/embed/OJRPJaN?height=450&amp;theme-id=1&amp;slug-hash=OJRPJaN&amp;default-tab=js,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed OJRPJaN" title="CodePen Embed OJRPJaN" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

그리고 우리는 그것을 가지고 있습니다!
 한 구성 요소가 다른 구성 요소에 작업을 트리거하는 변경 사항을 알릴 수있는 종속성없는 이벤트 수신 버스를 방금 만들었습니다.
 이런 종류의 작업을 수행하기 위해 전체 라이브러리가 필요하지 않으며 가능성은 무궁무진합니다.
 