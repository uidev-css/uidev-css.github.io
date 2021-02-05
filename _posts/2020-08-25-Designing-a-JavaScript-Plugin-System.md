---
layout: post
title: "JavaScript 플러그인 시스템 설계"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/08/plugs.png
tags: JAVASCRIPT DESIGN PATTERNS,PLUGIN
---


WordPress에 플러그인이 있습니다. jQuery에 플러그인이 있습니다. 개츠비, 엘레븐, 뷰도.

플러그인은 라이브러리와 프레임워크의 일반적인 기능이며, 적절한 이유로 개발자가 안전하고 확장 가능한 방식으로 기능을 추가할 수 있다. 이를 통해 핵심 프로젝트를 더욱 가치 있게 만들고 커뮤니티를 구축하여 유지 보수 부담을 가중시키지 않아도 됩니다. 정말 대단하다!

그럼 플러그인 시스템을 구축하는 방법은 무엇일까요? 자바스크립트에 우리만의 것을 만들어서 그 질문에 답해 봅시다.

저는 "플러그인"이라는 단어를 사용하지만, 이러한 것들을 "확장", "추가 기능" 또는 "모듈"과 같은 다른 이름으로 부르기도 합니다. 당신이 그들을 뭐라고 부르든, 그 개념과 이익은 똑같다.

### 플러그인 시스템을 구축하겠습니다.

BetaCalc라는 예시 프로젝트부터 시작하겠습니다. 베타캘c의 목표는 다른 개발자들이 "버튼"을 추가할 수 있는 미니멀리스트 자바스크립트 계산기가 되는 것이다. 시작하기 위한 몇 가지 기본 코드는 다음과 같습니다.

```js
// The Calculator
const betaCalc = {
  currentValue: 0,
  
  setValue(newValue) {
    this.currentValue = newValue;
    console.log(this.currentValue);
  },
  
  plus(addend) {
    this.setValue(this.currentValue + addend);
  },
  
  minus(subtrahend) {
    this.setValue(this.currentValue - subtrahend);
  }
};
 
// Using the calculator
betaCalc.setValue(3); // => 3
betaCalc.plus(3);     // => 6
betaCalc.minus(2);    // => 4
```

우리는 계산기를 단순함을 유지하기 위해 객체-리터럴로 정의하고 있습니다. 계산기는 `console.log`를 통해 결과를 인쇄하는 방식으로 작동합니다.

지금은 기능이 매우 제한되어 있습니다. 우리는 숫자를 취해서 화면에 표시하는 `setValue` 방식을 가지고 있다. 현재 표시된 값에 대한 연산을 수행할 플러스(plus)와 마이너스(minus) 방식도 있습니다.

이제 더 많은 기능을 추가할 때입니다. 먼저 플러그인 시스템을 만드는 것부터 시작하겠습니다.

### 세계에서 가장 작은 플러그인 시스템

먼저 다른 개발자가 베타Calc에 플러그인을 등록하는 데 사용할 수 있는 `register` 방법을 만드는 것부터 시작하겠습니다. 이 방법의 작업은 간단합니다. 외부 플러그인을 가져와서 해당 `exec` 기능을 잡고 새로운 방법으로 계산기에 연결합니다.

```js
// The Calculator
const betaCalc = {
  // ...other calculator code up here
 
  register(plugin) {
    const { name, exec } = plugin;
    this[name] = exec;
  }
};
```

다음은 플러그 인의 예입니다. 이 플러그 인은 계산기에 "제곱" 버튼을 제공합니다.

```js
// Define the plugin
const squaredPlugin = {
  name: 'squared',
  exec: function() {
    this.setValue(this.currentValue * this.currentValue)
  }
};
 
// Register the plugin
betaCalc.register(squaredPlugin);
```

대부분의 플러그인 시스템에서는 일반적으로 플러그인의 두 가지 부분이 있습니다.

- 실행할 코드
- 메타데이터(이름, 설명, 버전 번호, 종속성 등)

플러그인에서 `exec` 함수는 우리의 코드를 포함하고, `name`은 우리의 메타데이터이다. 플러그인이 등록되면 실행 함수가 BetaCalc 개체에 메서드로 직접 연결되어 BetaCalc의 "this"에 액세스할 수 있습니다.

이제 BetaCalc는 직접 호출할 수 있는 새로운 "제곱" 버튼을 갖게 되었습니다.

```js
betaCalc.setValue(3); // => 3
betaCalc.plus(2);     // => 5
betaCalc.squared();   // => 25
betaCalc.squared();   // => 625
```

이 시스템은 마음에 드는 것이 많다. 플러그인은 우리의 기능에 전달될 수 있는 단순한 객체-리터럴이다. 즉, 플러그인을 npm을 통해 다운로드하고 ES6 모듈로 가져올 수 있습니다. 간편한 배포는 매우 중요합니다!

하지만 우리 시스템에는 몇 가지 결함이 있습니다.

플러그인에 베타Calc의 `this`에 대한 액세스 권한을 부여함으로써, 플러그인은 모든 베타Calc의 코드에 대한 읽기/쓰기 액세스 권한을 갖게 된다. 이 값은 현재 값을 가져오고 설정하는 데 유용하지만 위험하기도 합니다. 플러그인이 내부 함수(예: setValue)를 재정의하는 경우 베타Calc 및 기타 플러그인에 예기치 않은 결과가 발생할 수 있습니다. 이는 소프트웨어 엔터티가 확장에는 개방적이지만 수정에는 폐쇄되어야 한다는 열린 폐쇄 원칙을 위반한다.

또한, "제곱" 기능은 부작용을 발생시킴으로써 작동합니다. 특히 다른 플러그인이 동일한 내부 상태에 있을 수 있는 경우 JavaScript에서는 이러한 현상이 드물지 않습니다. 좀 더 기능적인 접근 방식은 우리의 시스템을 더 안전하고 예측 가능하게 만드는 데 큰 도움이 될 것이다.

### 더 나은 플러그인 아키텍처

더 나은 플러그인 아키텍처에 대해 다시 한 번 살펴보겠습니다. 다음 예에서는 계산기와 해당 플러그인 API를 모두 변경합니다.

```js
// The Calculator
const betaCalc = {
  currentValue: 0,
  
  setValue(value) {
    this.currentValue = value;
    console.log(this.currentValue);
  },
 
  core: {
    'plus': (currentVal, addend) => currentVal + addend,
    'minus': (currentVal, subtrahend) => currentVal - subtrahend
  },
 
  plugins: {},    
 
  press(buttonName, newVal) {
    const func = this.core[buttonName] || this.plugins[buttonName];
    this.setValue(func(this.currentValue, newVal));
  },
 
  register(plugin) {
    const { name, exec } = plugin;
    this.plugins[name] = exec;
  }
};
  
// Our Plugin
const squaredPlugin = { 
  name: 'squared',
  exec: function(currentValue) {
    return currentValue * currentValue;
  }
};
 
betaCalc.register(squaredPlugin);
 
// Using the calculator
betaCalc.setValue(3);      // => 3
betaCalc.press('plus', 2); // => 5
betaCalc.press('squared'); // => 25
betaCalc.press('squared'); // => 625
```

여기서 몇 가지 주목할 만한 변화가 있습니다.

첫째, 우리는 플러그인을 자체 플러그인 객체에 넣어 코어 계산기 방법(예: 플러스, 마이너스)과 분리했다. 플러그인을 `plugin` 개체에 저장하면 시스템이 안전해집니다. 이제 이 액세스 플러그인은 베타Calc 속성을 볼 수 없으며 `betaCalc.plugins` 속성만 볼 수 있습니다.

둘째, 버튼의 기능을 이름으로 조회한 뒤 호출하는 프레스(press) 방식을 구현했습니다. 이제 플러그인의 exec 함수를 호출하면 현재 계산기 값(current Value)을 전달하여 새로운 계산기 값을 반환할 것으로 예상한다.

본질적으로, 이 새로운 `프레스` 방법은 우리의 모든 계산기 버튼을 순수한 기능으로 변환한다. 값을 가져와서 작업을 수행한 다음 결과를 반환합니다. 이렇게 하면 많은 이점이 있습니다.

- API를 단순화합니다.
- BetaCalc 및 플러그인 자체에서 테스트를 더 쉽게 수행할 수 있습니다.
- 그것은 우리 시스템의 의존성을 줄여 더 느슨하게 결합되게 만든다.

이 새로운 아키텍처는 첫 번째 예보다 더 제한적이지만 좋은 방식으로는 한계가 있습니다. 기본적으로 플러그 인 작성자를 위한 보호 난간을 설치했습니다. 사용자가 원하는 변경사항만 지정할 수 있도록 제한했습니다.

사실, 너무 제한적일 수도 있어요! 이제 계산기 플러그인은 `current Value`에서만 작업을 수행할 수 있습니다. 플러그인 작성자가 "메모리" 버튼이나 기록을 추적하는 방법 같은 고급 기능을 추가하기를 원한다면, 그들은 할 수 없을 것이다.

괜찮을지도 몰라. 플러그인 작성자에게 제공하는 힘의 양은 미묘한 균형입니다. 그들에게 너무 많은 힘을 주면 프로젝트의 안정성에 영향을 미칠 수 있습니다. 하지만 너무 적은 전력을 공급하면 문제를 해결하기 어렵습니다. 이 경우 플러그인이 없을 수도 있습니다.

### 우리가 뭘 더 할 수 있겠어요?

우리의 시스템을 개선하기 위해 우리가 할 수 있는 일이 훨씬 더 많습니다.

이름을 정의하지 않거나 값을 반환하는 경우 플러그인 작성자에게 알리는 오류 처리를 추가할 수 있습니다. QA 개발자와 같이 생각하여 시스템이 어떻게 중단되어 이러한 사례를 능동적으로 처리할 수 있는지 상상해 보는 것이 좋습니다.

플러그인이 할 수 있는 일의 범위를 넓힐 수 있습니다. 현재 BetaCalc 플러그인은 버튼을 추가할 수 있습니다. 그러나 계산기가 값을 표시하려고 할 때와 같이 특정 라이프사이클 이벤트에 대한 콜백을 등록할 수 있다면 어떨까요? 또는 여러 상호 작용에 걸쳐 하나의 상태를 저장할 수 있는 전용 장소가 있다면 어떨까요? 그러면 새로운 사용 사례가 몇 개 생길까요?

플러그인 등록도 확대할 수 있습니다. 플러그인을 초기 설정으로 등록할 수 있으면 어떻게 합니까? 그러면 플러그인이 더 유연해질 수 있을까요? 플러그인 작성자가 "BetaCalc Statistics Pack"과 같은 단일 버튼 대신 전체 버튼을 등록하려고 하면 어떻게 될까요? 그것을 뒷받침하기 위해 어떤 변화가 필요할까?

### 플러그인 시스템

BetaCalc와 플러그인 시스템은 모두 의도적으로 단순하다. 프로젝트가 더 클 경우 다른 플러그인 아키텍처를 살펴보려고 합니다.

시작하기에 좋은 한 가지 장소는 성공적인 플러그인 시스템의 예를 위해 기존 프로젝트를 살펴보는 것이다. 자바스크립트에서, 그것은 jQuery, Gatsby, D3, CKEditor 또는 다른 것들을 의미한다.

다양한 자바스크립트 디자인 패턴에 익숙해지기를 원할 수도 있습니다. (Addy Osmani는 주제에 관한 책을 가지고 있습니다.) 각 패턴은 서로 다른 인터페이스와 결합 정도를 제공하므로 선택할 수 있는 좋은 플러그인 아키텍처 옵션을 많이 제공합니다. 이러한 옵션을 인식하면 프로젝트를 사용하는 모든 사용자의 요구를 보다 효과적으로 조정할 수 있습니다.

패턴 그 자체 외에도, 이런 종류의 결정을 내릴 수 있는 좋은 소프트웨어 개발 원칙들이 많이 있습니다. 그 동안 (개방형 원칙과 느슨한 결합과 같은) 몇 가지를 언급했지만, 다른 관련 사항으로는 디미터 법칙과 의존성 주입이 있습니다.

많이 들린다는 건 알지만 조사를 해봐야 해요. 플러그인 아키텍처를 변경해야 했기 때문에 모든 사용자가 플러그인을 다시 쓰도록 하는 것만큼 고통스러운 일은 없습니다. 그것은 신뢰를 잃고 사람들이 미래에 기여하는 것을 단념시키는 빠른 방법이다.

### 결론

처음부터 좋은 플러그인 아키텍처를 쓰는 것은 어렵습니다! 모든 사람의 요구에 맞는 시스템을 구축하기 위해서는 많은 고려사항의 균형을 맞춰야 합니다. 그게 충분히 간단한가요? 충분히 강력하다고요? 그게 장기적으로 효과가 있을까요?

그래도 노력한 보람이 있어요. 좋은 플러그인 시스템을 갖는 것은 모두에게 도움이 된다. 개발자들은 그들의 문제를 해결할 자유를 얻는다. 최종 사용자는 선택할 수 있는 많은 옵션 기능을 얻을 수 있습니다. 그리고 프로젝트를 둘러싼 생태계와 공동체를 성장시킬 수 있습니다. 그것은 윈-윈-윈하는 상황이다.