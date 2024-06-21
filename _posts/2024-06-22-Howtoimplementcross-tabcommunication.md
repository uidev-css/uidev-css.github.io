---
title: "탭 간 통신 구현하는 방법"
description: ""
coverImage: "/assets/img/2024-06-22-Howtoimplementcross-tabcommunication_0.png"
date: 2024-06-22 05:52
ogImage: 
  url: /assets/img/2024-06-22-Howtoimplementcross-tabcommunication_0.png
tag: Tech
originalTitle: "How to implement cross-tab communication"
link: "https://medium.com/@Nacabacu/how-to-implement-cross-tab-communication-3fa94021733b"
---


<img src="/assets/img/2024-06-22-Howtoimplementcross-tabcommunication_0.png" />

## 🌐 제 블로그에서 이 게시물을 읽어보세요

웹 개발 여정 중 어느 순간, 웹 애플리케이션이 탭 간에 통신해야 하는 경우가 있을 수 있습니다. 아직 그런 적이 없다면, 왜 그럴 필요가 있는지 궁금할 수도 있겠죠.

# 🗣️ 그럴 필요가 있는 이유는 무엇일까요?

<div class="content-ad"></div>

좋아요~ 첫 번째 단락을 마무리하게 해 주셔서 감사합니다. 이제 상호 테이블 통신이 유용한 많은 상황들이 있습니다. 몇 가지 살펴보겠습니다.

- 세션 관리 — 웹사이트의 여러 탭을 여는 상황을 상상해봅시다. 한 창에서 로그인하면, 다른 모든 창도 로그인해 있는 것을 기대합니다. 로그아웃도 동일하게 적용됩니다.
- 공유 상태 — 테마, 로케일화, 또는 실시간 데이터와 같이 애플리케이션에서 탭 간에 상태를 공유해야 할 수 있습니다.
- 메시지 브로드캐스트 — 한 탭에서 다른 탭으로 메시지를 브로드캐스트하고 싶을 때, 예를 들어 양식을 제출하거나 다른 사용자 작업 등

여기까지 보셔서 정말 편리하다는 걸 느끼지 않으셨나요? 이제...어떻게 구현할 수 있는지 궁금하시죠? 

# 🗣️ 어떻게 구현할 수 있을까요?

<div class="content-ad"></div>

헉, 두 번째로 방해하네요. 괜찮아요... 간단한 예제를 통해 어떻게 구현하는지 몇 가지 일반적인 방법을 선택해볼게요

- 로컬 스토리지
- 브로드캐스트 채널
- 공유 워커

위 세 가지 방법 모두 동일 출처 정책을 따르며, 즉 우리 애플리케이션이 동일한 출처를 가졌을 때만 작동하는 것을 의미해요

## 로컬 스토리지

<div class="content-ad"></div>

가장 간단하고 인기 있는 방법일 수 있어요.

```js
// 발신자
sender.setItem('channel', 'some message');

// 수신자
window.addEventListener('storage', (event) => {
  if (event.key === 'channel') {
    // 메시지는 event.newValue에 들어 있어요
  }
});
```

정말 간단하죠! 수신 창에만 저장 이벤트 리스너를 추가하면 돼요. 그럼 로컬스토리지의 데이터가 변경되면 핸들러가 호출돼요.

## 브로드캐스트 채널

<div class="content-ad"></div>

Broadcast Channel을 사용한 방법은 매우 간단합니다.

```js
const broadcastChannel = new BroadcastChannel('channel');

// 발신자
broadcastChannel.postMessage('일부 메시지');

// 수신자
broadcastChannel.onmessage = (event) => {
  // 메시지는 event.data에 있습니다.
};
```

먼저, BroadcastChannel의 새 인스턴스를 생성하고 채널 이름을 인수로 전달해야 합니다.

이후에는 저가 언급한 대로 간단합니다. 제가 설명을 하지 않아도 예시 코드가 자체적으로 설명할 수 있습니다. 😆 장난이죠! 우리는 단순히 postMessage를 사용하여 메시지를 보내고, 수신자는 onmessage 이벤트 리스너를 생성하면 됩니다.

<div class="content-ad"></div>

## 공유 워커

마지막으로, 세 가지 방법 중에서 가장 복잡한 것이에요. 제가 가능한 한 간단하게 설명해 드릴게요.

아마 이미 알고 있겠지만, 웹 애플리케이션은 하나의 스레드에서 실행된다는 것을 의미합니다. 이는 일부 실행이 UI를 렌더링하는 데 차단할 수 있다는 것을 의미합니다. 웹 워커는 이러한 문제를 해결하는 데 도움이 됩니다!

우리는 공유 워커가 웹 애플리케이션 간의 중계 역할을 한다고 말할 수 있으며, 탭 간의 메시지 전달에 적합하다고 할 수 있어요.

<div class="content-ad"></div>

```js
const sharedWorker = new SharedWorker('./worker.js');

// sender
sharedWorker.port.postMessage('메시지 전송');

// receiver
sharedWorker.port.onmessage = (event) => {
  // 수신된 메시지는 event.data에 있습니다
};
```

위의 코드 예제를 보면 Broadcast Channel의 구현과 매우 유사하다는 것을 알 수 있어요. 그러나 worker.js라는 파일 뒤에 비밀스러운 마법이 숨어있어요.

```js
// worker.js
let ports = [];

onconnect = function(e) {
  const currentPort = e.ports[0];

  ports.push(currentPort);

  currentPort.onmessage = function(event) {
    const message = event.data;

    ports.forEach(port => {
      if (currentPort !== port) {
        port.postMessage(message);
      }
    });
  };
};
```

여기서 마법처럼 동작하는 로직이 수행되어요. onconnect 핸들러는 동일한 출처의 스크립트 중 어떤 것이든 worker.js를 Shared Worker로 로드할 때마다 호출될 거에요.

<div class="content-ad"></div>

우리는 각 탭에서 전달된 MessagePort가 담긴 MessagePort 배열을 정의했어. 발신자가 postMessage를 호출할 때마다 Shared Worker가 다른 탭의 다른 MessagePort로 메시지를 브로드캐스트할 거야.

그리고 이렇게 우리가 탭 간 통신을 하는 세 가지 방법을 설명했지. 그런데 어떤 걸 사용해야 할까...

# 🗣️ 그럼 어떤 걸 선택해야 할까?

😑 ← 이게 지금 내 표정... 그건 우리가 구현하는 기능에 따라 다르다는 걸로...

<div class="content-ad"></div>

- 상태를 공유하고 싶다면 → Local Storage
- 메시지를 브로드캐스트하려면 → Broadcast Channel
- 응용 프로그램이 많은 처리를 필요로 한다면 → Shared Worker

그러나 올바른 선택을 결정하기 전에 다른 조건들을 고려해야 합니다.

# 데모

간단한 데모를 만들어서 사용해 볼 수 있습니다.

<div class="content-ad"></div>

데모 사이트
소스 코드

여기까지 입니다! 더 많은 블로그를 punn.dev에서 확인해보세요!

다음 포스트에서 만나요! 👋🏼