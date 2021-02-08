---
layout: post
title: "Vue에서 로컬 스토리지를 사후 대응적으로 만드는 방법"
author: "Uidev Css"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/06/vue-glowing.png"
tags: LOCALSTORAGE,REACTIVITY,VUE,VUE MIXINS
---


리액티브는 뷰의 가장 큰 특징 중 하나이다. 만약 여러분이 그것이 뒤에서 무엇을 하고 있는지 모른다면 그것은 또한 가장 신비로운 것 중 하나입니다. localStorage와 같은 다른 것들이 아닌 객체와 어레이와 함께 작동하는 이유는 무엇입니까?

이 질문에 답해 보겠습니다. 이 질문에 답하는 동안 Vue는 로컬 스토리지에서 반응성을 발휘합니다.

다음 코드를 실행하면 카운터가 정적 값으로 표시되고 `localStorage`의 값이 변경되는 간격 때문에 예상한 것처럼 변경되지 않음을 알 수 있습니다.

```js
new Vue({
  el: "#counter",
  data: () => ({
    counter: localStorage.getItem("counter")
  }),
  computed: {
    even() {
      return this.counter % 2 == 0;
    }
  },
  template: `<div>
    <div>Counter: { counter }</div>
    <div>Counter is { even ? 'even' : 'odd' }</div>
  </div>`
});
```

```js
// some-other-file.js
setInterval(() => {
  const counter = localStorage.getItem("counter");
  localStorage.setItem("counter", +counter + 1);
}, 1000);
```

Vue 인스턴스 내의 카운터 속성은 반응형이지만 로컬 스토리지에서 원래 위치를 변경했다고 해서 변경되지 않습니다.

여기에는 여러 가지 솔루션이 있는데, 가장 좋은 방법은 Vuex를 사용하는 것이며 저장소 값을 `localStorage`와 동기화하는 것일 수 있습니다. 하지만 이 예에서와 같이 간단한 것이 필요하다면 어떻게 할까요? 우리는 Vue의 반응성 시스템이 어떻게 작용하는지에 대해 깊이 연구해야 한다.

### 리액티브 인 뷰

Vue가 구성 요소 인스턴스를 초기화할 때 `data` 옵션을 준수합니다. 즉, 데이터의 모든 속성을 살펴보고 `Object.defineProperty`를 사용하여 getter/setter로 변환합니다. Vue는 각 속성에 대한 사용자 지정 설정자를 사용하여 속성이 변경되는 시기를 알 수 있으며, 변경사항에 대응해야 하는 종속기업에 알릴 수 있습니다. 어떤 부양가족이 부동산에 의존하는지 어떻게 알 수 있을까요? Getter를 누르면 계산된 속성, 감시 기능 또는 렌더링 기능이 데이터 프로포트에 액세스할 때 등록할 수 있습니다.

```js
// core/instance/state.js
function initData () {
  // ...
  observe(data)
}
```

```js
// core/observer/index.js
export function observe (value) {
  // ...
  new Observer(value)
  // ...
}

export class Observer {
  // ...
  constructor (value) {
    // ...
    this.walk(value)
  }
  
  walk (obj) {
    const keys = Object.keys(obj)
    for (let i = 0; i < keys.length; i++) {
      defineReactive(obj, keys[i])
    }
  }
} 
 
export function defineReactive (obj, key, ...) {
  const dep = new Dep()
  // ...
  Object.defineProperty(obj, key, {
    // ...
    get() {
      // ...
      dep.depend()
      // ...
    },
    set(newVal) {
      // ...
      dep.notify()
    }
  })
}
```

그렇다면 `local storage`가 반응성이 없는 이유는 무엇일까요? 왜냐하면 그것은 속성을 가진 물체가 아니기 때문입니다.

하지만 기다려요. 어레이를 사용하여 Getter와 Settter를 정의할 수도 없지만 Vue의 어레이는 여전히 반응합니다. 왜냐하면 어레이는 Vue에서 특별한 경우이기 때문입니다. Vue는 사후 대응적인 어레이를 갖기 위해 백그라운드에서 어레이 방법을 재정의하고 Vue의 반응성 시스템과 함께 패치합니다.

로컬 스토리지와 비슷한 작업을 할 수 있을까요?

### localStorage 기능을 재정의하는 중

먼저 localStorage 방법을 재정의하여 `localStorage` 항목을 요청한 구성 요소 인스턴스를 추적하여 초기 예를 수정할 수 있습니다.

```js
// A map between localStorage item keys and a list of Vue instances that depend on it
const storeItemSubscribers = {};
 
const getItem = window.localStorage.getItem;
localStorage.getItem = (key, target) => {
  console.info("Getting", key);
 
  // Collect dependent Vue instance
  if (!storeItemSubscribers[key]) storeItemSubscribers[key] = [];
  if (target) storeItemSubscribers[key].push(target);
 
  // Call the original function 
  return getItem.call(localStorage, key);
};
 
const setItem = window.localStorage.setItem;
localStorage.setItem = (key, value) => {
  console.info("Setting", key, value);
 
  // Update the value in the dependent Vue instances
  if (storeItemSubscribers[key]) {
    storeItemSubscribers[key].forEach((dep) => {
      if (dep.hasOwnProperty(key)) dep[key] = value;
    });
  }
 
  // Call the original function
  setItem.call(localStorage, key, value);
};
```

```js
new Vue({
  el: "#counter",
  data: function() {
    return {
      counter: localStorage.getItem("counter", this) // We need to pass 'this' for now
    }
  },
  computed: {
    even() {
      return this.counter % 2 == 0;
    }
  },
  template: `<div>
    <div>Counter: { counter }</div>
    <div>Counter is { even ? 'even' : 'odd' }</div>
  </div>`
});
```

```js
setInterval(() => {
  const counter = localStorage.getItem("counter");
  localStorage.setItem("counter", +counter + 1);
}, 1000);
```

이 예에서는 `localStorage` 항목에 의존하는 구성 요소를 수집하고 알리기 위해 `getItem`과 `setItem`을 재정의한다. 새로운 `getItem`에서는 어떤 구성요소가 어떤 항목을 요청하는지, `setItem`에서는 해당 항목을 요청한 모든 구성요소에 접근하여 데이터 소포를 다시 작성합니다.

위의 코드가 작동하기 위해서는 getItem이라는 구성 요소 인스턴스에 대한 참조를 전달해야 하며, 이는 함수 서명을 변경합니다. 또한 이 값이 정확하지 않을 경우 화살표 기능을 더 이상 사용할 수 없습니다.

우리가 더 잘하려면 더 깊이 파고들어야 해. 예를 들어, 부양가족을 명시적으로 전달하지 않고 어떻게 추적할 수 있는가?

### Vue가 종속성을 수집하는 방법

영감을 얻기 위해, 우리는 Vue의 반응 시스템으로 돌아갈 수 있습니다. 우리는 이전에 데이터 속성의 게이터가 데이터 속성의 액세스 시 속성의 추가 변경에 호출자를 가입시키는 것을 보았다. 하지만 누가 전화했는지 어떻게 알 수 있죠? 데이터 소품을 받으면 발신자가 누구인지에 대한 정보가 입력되지 않습니다. Getter 기능에는 입력이 없습니다. 누가 부양가족으로 등록해야 하는지 어떻게 알 수 있나요?

각 데이터 속성은 Dep 클래스에서 응답해야 하는 종속성 목록을 유지합니다. 이 클래스를 자세히 살펴보면 종속성 자체가 등록될 때마다 정적 대상 변수에 이미 정의되어 있음을 알 수 있습니다. 이 목표는 지금까지 미스터리한 워처 클래스에 의해 설정되었다. 실제로 데이터 속성이 변경되면 이러한 관찰자에게 실제로 통보되며 구성요소 재렌더링이나 계산된 자산의 재계산 등을 시작하게 된다.

하지만, 또, 그들은 누구일까요?

언제 뷰는`data` 옵션 관측을 하면 또한 각computed 속성 기능뿐만 아니라 모든 시계 기능(는 Watcher 수업과 혼동하지 말아야 한다),에 전문가들을 만듭니다.모든 구성 요소의 렌더링 기능 예이다. 관찰자들은 이러한 기능들의 동료와 같다. 주로 두 가지 작업을 수행합니다.

- 생성 시 함수를 평가합니다. 종속성 컬렉션을 트리거합니다.
- 그들은 그들이 의지하는 가치가 변했다는 통보를 받았을 때 그들의 기능을 다시 실행한다. 이렇게 하면 궁극적으로 계산된 속성이 다시 계산되거나 전체 구성 요소가 다시 렌더링됩니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/06/image-12.png?fit=1024%2C806&ssl=1)

관찰자들이 그들이 책임지고 있는 기능을 부르기 전에 중요한 단계가 있다: 그들은 스스로를 Dep 클래스의 정적 변수에서 목표로 설정한다. 이렇게 하면 사후 대응적 데이터 속성에 액세스할 때 종속적으로 등록됩니다.

### localStorage 호출자 추적

우리는 Vue의 내부 역학에 접근할 수 없기 때문에 정확히 그렇게 할 수 없습니다. 그러나, 우리는 감시자가 그것이 담당하는 함수를 호출하기 전에 정적 속성에서 대상을 설정하도록 하는 Vue의 아이디어를 사용할 수 있다. localStorage가 호출되기 전에 구성 요소 인스턴스에 대한 참조를 설정할 수 있습니까?

데이터 옵션을 설정하는 동안 localStorage가 호출된다고 가정하면 beforeCreate와 created에 연결할 수 있습니다. 이 두 후크는 `데이터` 옵션을 초기화하기 전과 후에 트리거되므로, 현재 구성 요소 인스턴스(라이프사이클 후크에서 액세스할 수 있는)에 대한 참조를 사용하여 대상 변수를 설정했다가 지울 수 있다. 그런 다음, 사용자 정의 수집기에서 이 대상을 종속 대상으로 등록할 수 있습니다.

마지막 비트는 이러한 라이프사이클 후크를 모든 구성요소의 일부로 만드는 것입니다. 우리는 프로젝트 전체에 대한 글로벌 믹스인(mixin)을 통해 그렇게 할 수 있습니다.

```js
// A map between localStorage item keys and a list of Vue instances that depend on it
const storeItemSubscribers = {};

// The Vue instance that is currently being initialised
let target = undefined;

const getItem = window.localStorage.getItem;
localStorage.getItem = (key) => {
  console.info("Getting", key);

  // Collect dependent Vue instance
  if (!storeItemSubscribers[key]) storeItemSubscribers[key] = [];
  if (target) storeItemSubscribers[key].push(target);

  // Call the original function
  return getItem.call(localStorage, key);
};

const setItem = window.localStorage.setItem;
localStorage.setItem = (key, value) => {
  console.info("Setting", key, value);

  // Update the value in the dependent Vue instances
  if (storeItemSubscribers[key]) {
    storeItemSubscribers[key].forEach((dep) => {
      if (dep.hasOwnProperty(key)) dep[key] = value;
    });
  }
  
  // Call the original function
  setItem.call(localStorage, key, value);
};

Vue.mixin({
  beforeCreate() {
    console.log("beforeCreate", this._uid);
    target = this;
  },
  created() {
    console.log("created", this._uid);
    target = undefined;
  }
});
```

첫 번째 예제를 실행할 때 매초마다 숫자를 증가시키는 카운터를 얻게 됩니다.

```js
new Vue({
  el: "#counter",
  data: () => ({
    counter: localStorage.getItem("counter")
  }),
  computed: {
    even() {
      return this.counter % 2 == 0;
    }
  },
  template: `<div class="component">
    <div>Counter: { counter }</div>
    <div>Counter is { even ? 'even' : 'odd' }</div>
  </div>`
});
```

```js
setInterval(() => {
  const counter = localStorage.getItem("counter");
  localStorage.setItem("counter", +counter + 1);
}, 1000);
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 500px;"><iframe id="cp_embed_jObmwPZ" src="//codepen.io/anon/embed/jObmwPZ?height=500&amp;theme-id=1&amp;slug-hash=jObmwPZ&amp;default-tab=result" height="500" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed jObmwPZ" title="CodePen Embed jObmwPZ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 우리의 사고 실험의 끝

우리가 우리의 초기 문제를 해결했을 때, 이것은 대부분 사고 실험이라는 것을 명심하세요. 제거된 항목 처리 및 마운트 해제된 구성 요소 인스턴스 처리와 같은 몇 가지 기능이 없습니다. 또한 구성 요소 인스턴스의 속성 이름이 `localStorage`에 저장된 항목과 동일한 이름을 요구하기 때문에 제한이 있습니다. 그렇긴 하지만, 주된 목표는 뷰의 반응성이 뒤에서 어떻게 작용하는지 더 잘 알고 최대한 활용하는 것입니다. 그래서 저는 이것이 여러분이 이 모든 것에서 벗어나길 바랍니다.