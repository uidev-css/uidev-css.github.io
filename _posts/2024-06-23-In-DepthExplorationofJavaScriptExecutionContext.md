---
title: "자바스크립트 실행 컨텍스트 심층 탐구"
description: ""
coverImage: "/assets/img/2024-06-23-In-DepthExplorationofJavaScriptExecutionContext_0.png"
date: 2024-06-23 15:14
ogImage: 
  url: /assets/img/2024-06-23-In-DepthExplorationofJavaScriptExecutionContext_0.png
tag: Tech
originalTitle: "In-Depth Exploration of JavaScript Execution Context"
link: "https://medium.com/@Choco23/in-depth-exploration-of-javascript-execution-context-82974bb068c7"
---


자바스크립트 초심자든 전문가든, 면접이건 일상적인 개발 작업이건, 우리는 종종 다음과 같은 상황을 맞닥뜨립니다: 몇 줄의 코드가 주어졌을 때, 그들이 무엇을 출력하며 어떤 순서로 실행되는지 알아야 합니다. 🧑‍💻 자바스크립트는 싱글 스레드 언어이기 때문에 우리는 다음 결론을 내릴 수 있습니다:

자바스크립트는 문장을 나타난 순서대로 실행합니다. 📜

이 시점에서, "나는 JS가 한 줄씩 실행된다는 것을 알아, 왜 강조하는 거지?"라고 하실 수 있습니다. 🤔 우리는 JS가 한 줄씩 실행된다고 가정하기 때문에 이런 식으로 모든 JS가 동작한다고 가정합니다.

```js
let a = '1';
console.log(a);

let b = '2';
console.log(b);
```

<div class="content-ad"></div>

하지만 실제로 JavaScript는 다음과 같이 실행됩니다:

```js
setTimeout(function(){
  console.log('Timer started')
});
new Promise(function(resolve){
  console.log('For loop is about to be executed');
  for(var i = 0; i < 10000; i++){
    i == 99 && resolve();
  }
}).then(function(){
  console.log('Execute then function')
});
console.log('Code execution ends');
```

JavaScript가 문장을 순서대로 실행한다는 개념을 따라, 예상 출력을 자신 있게 적었습니다:

1. 타이머 시작. ⏱️
2. for 루프가 실행됩니다. 🔄
3. then 함수를 실행합니다. ➡️
4. 코드 실행 종료. 🛑

<div class="content-ad"></div>

그러나 Chrome에서 확인했을 때 결과가 완전히 잘못되어 순간적으로 혼란스러웠어요. 😕 예상대로 줄 단위로 실행되어야 하는 것이 아니었나요? 🤨

이 혼란을 해소하기 위해 JavaScript의 실행 메커니즘을 완전히 이해해야 합니다.

# JavaScript에 대해

JavaScript는 단일 스레드 언어입니다. 🧵 최신 HTML5에서 Web Workers가 소개되었지만, JavaScript의 단일 스레드 코어는 변하지 않았습니다. 따라서 JavaScript의 모든 "다중 스레딩"은 단일 스레드를 사용하여 모의되며, 모든 다중 스레딩은 속임수입니다!

<div class="content-ad"></div>

# 자바스크립트 이벤트 루프

자바스크립트는 한 번에 하나의 작업만 처리하기 때문에, 한 창만 있는 은행과 같아요; 고객들은 차례로 업무를 처리하기 위해 줄을 서야 합니다. 🏦 마찬가지로, 자바스크립트 작업들은 하나씩 실행되어야 해요. 만약 어떤 작업이 너무 오래 걸린다면, 다음 작업은 기다려야 해요.

그래서 질문이 생깁니다: 우리가 뉴스를 보려고 하는데, 뉴스에 있는 고화질 사진들이 느리게 로드된다면, 사진이 완전히 표시될 때까지 웹 페이지가 멈춰 있어야 할까요?

똑똑한 프로그래머들은 이 문제를 두 가지 범주로 작업을 나누어 해결합니다:

<div class="content-ad"></div>

1. 동기 작업 🕒 
2. 비동기 작업 ⏩

웹사이트를 열 때, 렌더링 프로세스는 페이지 골격과 요소를 렌더링하는 등 많은 동기 작업으로 구성됩니다. 🖥️ 사진이나 음악 파일과 같이 많은 리소스를 사용하고 오랜 시간이 걸리는 작업들은 비동기 작업입니다.

더 쉽게 이해하기 위해 마인드 맵을 사용하여 설명하겠습니다:

![마인드 맵](/assets/img/2024-06-23-In-DepthExplorationofJavaScriptExecutionContext_0.png)

<div class="content-ad"></div>

마음의 맵 콘텐츠를 설명하는 단어를 사용하면:

1. 동기 작업과 비동기 작업은 서로 다른 실행 "장소"로 들어갑니다. 🕒⏩
2. 동기 작업은 주 스레드로 들어가고, 비동기 작업은 이벤트 테이블에 들어가서 함수를 등록합니다. 🧵📋
3. 지정된 작업이 완료되면, 이벤트 테이블은 이 함수를 이벤트 큐로 이동시킵니다. 📤
4. 주 스레드의 작업이 실행되고 나면, 해당 함수는 이벤트 큐에서 읽혀 주 스레드에서 실행됩니다. 🔄
5. 이 프로세스는 계속해서 반복되며, 이를 이벤트 루프라고 합니다. 🔁

여러분은 아마 궁금해 할지도 모릅니다. 주 스레드 실행 스택이 비어있는지 어떻게 알 수 있을까요? 🤔 자바스크립트 엔진은 주 스레드 실행 스택이 비어있는지 계속 확인하는 모니터링 프로세스가 있습니다. 한 번 비어지면, 이벤트 큐로 이동하여 호출을 기다리는 함수가 있는지 확인할 것입니다.

위 설명 이후에, 코드 한 줄이 더 직관적일지 모릅니다:

<div class="content-ad"></div>

```js
let data = [];
$.ajax({
  url: 'www.javascript.com',
  data: data,
  success: () => {
    console.log('Send successful');
  }
})
console.log('Code execution completed');
```

여기에 간단한 AJAX 요청 코드 예시가 있어요:

1. AJAX가 이벤트 테이블에 들어가며 콜백 함수 success를 등록해. 📋
2. console.log(`Code execution ended`)를 실행해. 🖨️
3. AJAX 이벤트가 완료되고 콜백 함수 success가 이벤트 대기열에 들어갔어. 📤
4. 메인 스레드가 이벤트 대기열에서 콜백 함수 success를 읽고 실행해. 🔄

위의 텍스트와 코드를 통해 JavaScript의 실행 순서에 대해 간단히 이해했을 거라고 믿어.

<div class="content-ad"></div>

🧑‍💻 다음으로, 고급 주제인 setTimeout을 공부해 봅시다.

# setTimeout에 대한 사랑과 미움

우리가 모두 알다시피, setTimeout에 대해 자세한 소개는 필요하지 않습니다. ⏳ 우리의 첫인상은 지연 후 비동기적으로 실행될 수 있다는 것입니다. 우리는 종종 3초 지연 실행을 구현하기 위해 사용합니다:

```js
setTimeout(() => {
  task();
}, 3000);
console.log('콘솔 실행');
```

<div class="content-ad"></div>

그러나 setTimeout을 계속 사용할수록 문제가 발생합니다. 때로는 코드에서 3초의 지연을 지정해도 함수가 5 또는 6초 이후에 실행되기도 합니다. 🤯 그 이유가 무엇일까요? 🤔

예시를 살펴봅시다:

```js
setTimeout(() => {
    task();
}, 3000)
console.log('콘솔 실행');
```

이전 결론에 따르면, setTimeout은 비동기적이므로 동기 작업인 console.log이 먼저 실행되어야 합니다. 따라서 우리의 결론은 다음과 같습니다:

<div class="content-ad"></div>

- 콘솔 실행
- task()

확인해보세요. 결과가 맞다면 지난 코드를 수정해봅시다:

```js
setTimeout(() => {
    task();
}, 3000)
sleep(10000000)
```

처음에는 비슷해 보이지만, 이 코드를 Chrome에서 실행하면 콘솔 실행 시간이 3초보다 훨씬 길다는 것을 알 수 있습니다. 왜 이제 시간이 오래 걸릴까요?

<div class="content-ad"></div>

지금 선언해야 하는 것은 setTimeout을 재정의하는 것입니다. 위의 코드의 실행 프로세스를 논의해 봅시다:

- task()가 이벤트 테이블에 등록되어 타이밍이 시작됩니다.
- sleep 함수를 아주 천천히 실행하고 타이밍이 계속됩니다.
- 3초 후에 타임아웃 이벤트가 완료됩니다. task()가 이벤트 큐에 입력됩니다. 그러나 sleep 함수는 아직 완료되지 않아서 대기해야 합니다.
- 마지막으로 sleep 함수가 실행되고 task()가 마침내 이벤트 큐에서 메인 스레드로 이동되어 실행됩니다.

위의 과정을 거친 후, setTimeout 함수는 지정된 시간이 지난 후 작업(이 경우 task())을 이벤트 큐에 추가함을 이해할 수 있습니다. 작업은 단일 스레드 환경에서 하나씩 실행되기 때문에, 이전 작업이 실행하는 데 너무 오래 걸리면 실행 시간이 3초를 크게 초과할 수 있습니다.

우리는 종종 setTimeout(fn, 0)와 같은 코드를 볼 수 있습니다. "0초 후 실행"이란 무엇을 의미하는 걸까요? 즉시 실행될 수 있을까요?

<div class="content-ad"></div>

답변은 아니요. setTimeout(fn, 0)은 주 스레드의 가장 빠른 유휴 시간에 실행할 작업을 지정하는 것을 의미합니다. 추가적인 초를 기다리지 않고 호출되며, 모든 동기 작업이 완료되고 스택이 비어있는 상태가 되었을 때 실행됩니다. 예를 들어:

```js
// 코드 1
console.log('이 부분은 먼저 실행됩니다');
setTimeout(() => {
  console.log('실행됨')
}, 0);

// 코드 2
console.log('이 부분은 먼저 실행됩니다');
setTimeout(() => {
  console.log('실행됨')
}, 3000);
```

코드 1의 출력 결과는:

- 이 부분은 먼저 실행됩니다
- 실행됨

<div class="content-ad"></div>

코드 2의 출력은:

- 먼저 여기에서 실행
- ... 3초 후
- 실행됨

setTimeout에 대해 주목해야 할 점은 주 스레드가 유휴 상태라도 0밀리초까지 달성할 수 없다는 것입니다. HTML 표준에 따르면 최소 값은 4밀리초입니다. 관심 있는 학생들은 스스로 탐구해 볼 수 있습니다.

# 쌍둥이 동생 setInterval

<div class="content-ad"></div>

setTimeout에 관해서 이야기할 때는, 그 둘둥이 형제 setInterval을 빠트릴 수 없어요. ⏳🔁 이 둘은 매우 비슷하지만, 후자는 루프에서 실행됩니다. 실행 순서 측면에서, setInterval로 등록된 함수는 각 지정된 간격마다 이벤트 큐에 넣을 거예요. 이전 작업이 너무 오래 걸린 경우에도 기다려야 해요. ⏱️

유의할 점은 setInterval(fn, ms)의 경우, fn이 ms초마다 실행되는 것이 아니라, fn의 새 인스턴스가 ms초 간격으로 이벤트 큐에 들어간다는 것이에요. 📤 만약 setInterval의 콜백 함수 fn이 지연 시간 ms보다 오래 걸린다면, 명백한 시간 간격이 없을 거예요. 이 문장을 신중하게 생각해보세요.

# Promises와 process.nextTick(callback)

이제 전통적인 타이머를 살펴본 후에, Promise와 process.nextTick(callback)의 동작을 알아보겠어요.

<div class="content-ad"></div>

이 글에서는 Promise의 정의와 기능을 자세히 다루지 않을 것입니다. process.nextTick(callback)은 Node.js에서 "setTimeout"와 유사하며, 콜백 함수를 다음 라운드의 이벤트 루프에서 호출합니다.

이해를 돕기 위해 바로 요점에 들어가보겠습니다. 동기적 및 비동기적 작업의 일반적인 정의 외에도 작업에 대한 더 구체적인 정의가 있습니다:

- 🕰️ Macro-task(매크로 작업): 전체 코드, setTimeout, setInterval을 포함합니다.
- 🎯 Micro-task(마이크로 작업): Promise, process.nextTick을 포함합니다.

다른 유형의 작업은 해당하는 이벤트 큐에 들어가게 됩니다. 예를 들어, setTimeout과 setInterval은 동일한 이벤트 큐에 들어갑니다.

<div class="content-ad"></div>

이벤트 루프의 순서는 JavaScript 코드가 실행되는 순서를 결정합니다. 전체 코드(매크로태스크)를 입력한 후 첫 번째 루프를 시작합니다. 그런 다음 모든 마이크로태스크를 실행합니다. 다음으로, 매크로태스크에서 시작하여 태스크 큐가 완료될 때까지 다시 시작하고, 다시 모든 마이크로태스크를 실행합니다. 약간 복잡해 보일 수 있지만, 지금 이 기사에서 한 코드 스니펫을 사용하여 설명해보겠습니다:

```js
setTimeout(function() {
    console.log('setTimeout');
})

new Promise(function(resolve) {
    console.log('promise');
}).then(function() {
    console.log('then');
})

console.log('console');
```

- 🔄 이 코드는 매크로태스크로 주 스레드로 들어갑니다.
- setTimeout을 만나면 해당 콜백 함수가 등록되어 매크로태스크 이벤트 큐로 전달됩니다.
- 그 다음 Promise를 만나면 즉시 새 Promise가 실행되고 then 함수가 마이크로태스크 이벤트 큐로 전달됩니다.
- console.log()을 만나면 즉시 실행됩니다.
- 매크로태스크로 전체 코드를 실행한 후, 어떤 마이크로태스크가 있는지 살펴봅니다. 마이크로태스크 이벤트 큐에서 then을 찾아 실행합니다.
- 첫 번째 이벤트 루프가 끝났습니다. 이제 매크로태스크 이벤트 큐에서 두 번째 라운드를 시작합니다. 이 큐에서 setTimeout에 해당하는 콜백 함수가 바로 실행됩니다.
- ✅ 실행 완료.

이벤트 루프, 매크로태스크 및 마이크로태스크 사이의 관계는 다음 그림에 나와 있습니다:

<div class="content-ad"></div>


![Exploration of JavaScript ExecutionContext](/assets/img/2024-06-23-In-DepthExplorationofJavaScriptExecutionContext_1.png)

# 요약

🔄 JavaScript 비동기성: JavaScript는 단일 스레드 언어로 동작합니다. 비동기성을 달성하기 위한 새로운 프레임워크와 구문이 있지만, 기본적으로 동기적 방법을 사용합니다. 이 단일 스레드 특성을 이해하는 것이 중요합니다.

🌀 이벤트 루프: 이벤트 루프는 JavaScript의 비동기 작업을 처리하고 실행 흐름을 관리하는 메커니즘입니다.


<div class="content-ad"></div>

🖥️ JavaScript 실행과 실행 방법: JavaScript의 실행은 Node.js, 브라우저 및 기타 환경(예: Ringo)에서 다양하게 이뤄집니다. 반면 "실행"이라는 용어는 일반적으로 JavaScript 파싱 엔진의 일관된 동작을 나타냅니다.

⏰ setImmediate: 마이크로태스크 및 매크로태스크와 함께, setImmediate는 비동기 작업의 한 유형입니다. 그들은 예약 및 실행 방법에 대해 일반적인 특성을 공유합니다.