---
layout: post
title: "객체 지향 프로그래밍의 향기(JavaScript)"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/09/js-wacky.png
tags: JAVASCRIPT,OOP
---


제가 조사한 바에 따르면, JavaScript에서 객체 지향 프로그래밍에 대한 네 가지 접근 방식이 있습니다.

어떤 방법을 사용해야 합니까? 어느 것이 "최고의" 방법인가요? 여기서 제 연구 결과를 귀하에게 적합한지 결정하는 데 도움이 될 수 있는 정보와 함께 발표하겠습니다.

이러한 결정을 내리기 위해, 우리는 단지 다양한 맛만을 보는 것이 아니라 그 맛들 사이의 개념적인 측면을 비교하려고 합니다.

### 객체 지향 프로그래밍이란?

개체 지향 프로그래밍은 공통 개체에서 다른 개체를 만들 수 있는 코드 작성 방법입니다. 공통 개체를 일반적으로 Blueprint라고 하는 반면 생성된 개체를 인스턴스라고 합니다.

각 인스턴스에는 다른 인스턴스와 공유되지 않는 속성이 있습니다. 예를 들어, 휴먼 Blueprint가 있는 경우 서로 다른 이름의 휴먼 인스턴스를 생성할 수 있습니다.

개체 지향 프로그래밍의 두 번째 측면은 여러 수준의 Blueprint가 있는 경우 코드를 구성하는 것입니다. 이를 일반적으로 상속 또는 하위 분류라고 합니다.

Object Oriented Programming의 세 번째 측면은 특정 정보를 개체 내에 숨겨 액세스할 수 없도록 하는 캡슐화입니다.

이 간단한 소개보다 더 많은 정보가 필요한 경우 객체 지향 프로그래밍의 이러한 측면을 소개하는 기사가 있습니다.

우선 객체 지향 프로그래밍의 네 가지 맛에 대한 소개인 기본 사항부터 살펴보겠습니다.

### 객체 지향 프로그래밍의 네 가지 맛

자바스크립트에서 객체 지향 프로그래밍을 쓰는 방법은 네 가지가 있다. 그 이유는 다음과 같습니다.

생성자는 이 키워드를 포함하는 함수입니다.

```js
function Human (firstName, lastName) {
  this.firstName = firstName
  this.lastName = lastName
}
```

`this`를 사용하면 각 인스턴스에 대해 생성된 고유 값을 저장(및 액세스)할 수 있습니다. 새 키워드를 사용하여 인스턴스를 만들 수 있습니다.

```js
const chris = new Human('Chris', 'Coyier')
console.log(chris.firstName) // Chris
console.log(chris.lastName) // Coyier

const zell = new Human('Zell', 'Liew')
console.log(zell.firstName) // Zell
console.log(zell.lastName) // Liew
```

클래스는 생성자 함수의 "합성 설탕"이라고 한다. 에서와 같이 클래스는 생성자 함수를 보다 쉽게 작성할 수 있는 방법입니다.

클래스가 나쁜지 여부를 놓고 심각한 논쟁이 벌어지고 있습니다. 우리는 이 논쟁에 대해 깊이 생각하지 않을 것이다. 대신, 클래스로 코드를 작성하는 방법을 살펴보고 작성한 코드를 기준으로 클래스가 생성자보다 나은지 여부를 결정할 것입니다.

클래스는 다음 구문을 사용하여 작성할 수 있습니다.

```js
class Human {
  constructor(firstName, lastName) {
    this.firstName = firstName
    this.lastName = lastName
  }
}
```

생성자 함수에 위의 생성자 구문과 동일한 코드가 포함되어 있습니까? 값을 이 값으로 초기화하려면 이렇게 해야 합니다.(초기화할 필요가 없다면 생성자를 건너뛸 수 있습니다. 자세한 내용은 나중에 상속)에서 확인할 수 있습니다.

언뜻 보기에는 클래스가 생성자보다 못한 것 같습니다. 쓸 코드가 더 많습니다! 이 시점에서 결론을 맺지 않아 진정하세요. 우리는 더 많은 것을 다룰 것이 있다. 수업은 나중에 빛나기 시작한다.

이전과 마찬가지로 `new` 키워드로 인스턴스를 만들 수 있습니다.

```js
const chris = new Human('Chris', 'Coyier')

console.log(chris.firstName) // Chris
console.log(chris.lastName) // Coyier
```

OLU는 카일 심슨에 의해 만들어지고 대중화되었다. OLU에서는 Blueprint를 일반 개체로 정의합니다. 그런 다음 인스턴스를 초기화하기 위해 메서드(종종 `init`라는 이름을 사용하지만 `compilator`가 클래스에 연결되는 방법에서는 필요하지 않음)를 사용합니다.

```js
const Human = {
  init (firstName, lastName ) {
    this.firstName = firstName
    this.lastName = lastName
  }
}
```

인스턴스를 만들려면 `Object.create`를 사용합니다. 인스턴스를 생성한 후에는 `init` 함수를 실행해야 합니다.

```js
const chris = Object.create(Human)
chris.init('Chris', 'Coyier')

console.log(chris.firstName) // Chris
console.log(chris.lastName) // Coyier
```

이것을 init에 반환하면 object.create 뒤에 init를 체인할 수 있다.

```js
const Human = {
  init () {
    // ...
    return this 
  }
}

const chris = Object.create(Human).init('Chris', 'Coyier')
console.log(chris.firstName) // Chris
console.log(chris.lastName) // Coyier
```

공장 함수는 객체를 반환하는 함수입니다. 모든 개체를 반환할 수 있습니다. 클래스 인스턴스 또는 OLU 인스턴스도 반환할 수 있으며, 여전히 유효한 팩토리(Factory) 기능이 됩니다.

공장 기능을 만드는 가장 간단한 방법은 다음과 같습니다.

```js
function Human (firstName, lastName) {
  return {
    firstName,
    lastName
  }
}
```

Factory 기능으로 인스턴스를 생성하는 데 `new`가 필요하지 않습니다. 단순히 함수를 호출하면 됩니다.

```js
const chris = Human('Chris', 'Coyier')

console.log(chris.firstName) // Chris
console.log(chris.lastName) // Coyier
```

이제 이러한 4가지 OOP 설정 가능성을 보았으니, 각 제품에 대한 속성과 방법을 선언하는 방법을 살펴보도록 하겠습니다. 그러면 더 큰 비교를 하기 전에 각 속성 및 방법을 사용하는 방법에 대해 좀 더 잘 이해할 수 있습니다.

### 속성 및 메서드 선언

메서드는 개체의 속성으로 선언된 함수입니다.

```js
const someObject = {
  someMethod () { /* ... */ }
}
```

개체 지향 프로그래밍에서는 두 가지 방법으로 속성과 메서드를 선언할 수 있습니다.

- 인스턴스에서 직접
- 프로토타입에서

둘 다 배워봅시다.

인스턴스에서 직접 속성을 선언하려면 생성자 함수 내부에 속성을 쓸 수 있습니다. 이 속성을 `이`의 속성으로 설정해야 합니다.

```js
function Human (firstName, lastName) {
  // Declares properties
  this.firstName = firstName
  this.lastname = lastName

  // Declares methods
  this.sayHello = function () {
    console.log(`Hello, I'm ${firstName}`)
  }
}

const chris = new Human('Chris', 'Coyier')
console.log(chris)
```

![image](https://paper-attachments.dropbox.com/s_AB4BC977DF2BBAB3F9B097592E16C7567C493B52A668B2A322B5360BC04D43E9_1597997536957_constructor-direct.png)

프로토타입은 인스턴스에서 동일한 방법을 사용할 수 있기 때문에 메소드는 일반적으로 프로토타입에 선언됩니다. "코드 설치 공간"이 더 작습니다.

프로토타입에 속성을 선언하려면 `프로토타입` 속성을 사용해야 합니다.

```js
function Human (firstName, lastName) {
  this.firstName = firstName
  this.lastname = lastName
}

// Declaring method on a prototype
Human.prototype.sayHello = function () {
  console.log(`Hello, I'm ${this.firstName}`)
}
```

![image](https://paper-attachments.dropbox.com/s_AB4BC977DF2BBAB3F9B097592E16C7567C493B52A668B2A322B5360BC04D43E9_1597997564925_constructor-prototype.png)

프로토타입에서 여러 메서드를 선언하려는 경우 이 방법은 복잡할 수 있습니다.

```js
// Declaring methods on a prototype
Human.prototype.method1 = function () { /*...*/ }
Human.prototype.method2 = function () { /*...*/ }
Human.prototype.method3 = function () { /*...*/ }
```

Object.assign과 같은 병합 기능을 사용하면 보다 쉽게 작업을 수행할 수 있습니다.

```js
Object.assign(Human.prototype, {
  method1 () { /*...*/ },
  method2 () { /*...*/ },
  method3 () { /*...*/ }
})
```

Object.assignment는 Getter와 Setter 함수의 병합을 지원하지 않습니다. 다른 도구가 필요해요. 그 이유는 이렇다. 여기 제가 만든 도구가 있습니다. Getters와 Setters를 병합하기 위해서요.

생성자 함수 내에서 각 인스턴스의 속성을 선언할 수 있습니다.

```js
class Human {
  constructor (firstName, lastName) {
    this.firstName = firstName
      this.lastname = lastName

      this.sayHello = function () {
        console.log(`Hello, I'm ${firstName}`)
      }
  }
}
```

![image](https://paper-attachments.dropbox.com/s_AB4BC977DF2BBAB3F9B097592E16C7567C493B52A668B2A322B5360BC04D43E9_1597997634570_class-direct.png)

프로토타입에서 방법을 선언하는 것이 더 쉽습니다. 생성자 뒤에 메소드를 일반 함수처럼 씁니다.

```js
class Human (firstName, lastName) {
  constructor (firstName, lastName) { /* ... */ }

  sayHello () {
    console.log(`Hello, I'm ${this.firstName}`)
  }
}
```

![image](https://paper-attachments.dropbox.com/s_AB4BC977DF2BBAB3F9B097592E16C7567C493B52A668B2A322B5360BC04D43E9_1597997758020_class-prototype.png)

생성자에 비해 클래스에 여러 메서드를 선언하는 것이 더 쉽습니다. `Object.assign` 구문은 필요하지 않습니다. 그냥 더 많은 기능만 쓰시면 됩니다.

참고: 클래스에는 메서드 선언 사이에 `격자`가 없습니다.

```js
class Human (firstName, lastName) {
  constructor (firstName, lastName) { /* ... */ }

  method1 () { /*...*/ }
  method2 () { /*...*/ }
  method3 () { /*...*/ }
}
```

인스턴스의 속성 및 메서드를 선언하는 데 동일한 프로세스를 사용합니다. 이 속성을 지정합니다.

```js
const Human = {
  init (firstName, lastName) {
    this.firstName = firstName
    this.lastName = lastName
    this.sayHello = function () {
      console.log(`Hello, I'm ${firstName}`)
    }

    return this
  }
}

const chris = Object.create(Human).init('Chris', 'Coyier')
console.log(chris)
```

![image](https://paper-attachments.dropbox.com/s_AB4BC977DF2BBAB3F9B097592E16C7567C493B52A668B2A322B5360BC04D43E9_1597997786485_oloo-direct.png)

프로토타입에서 메서드를 선언하려면 메서드를 일반 개체처럼 씁니다.

```js
const Human = {
  init () { /*...*/ },
  sayHello () {
    console.log(`Hello, I'm ${this.firstName}`)
  }
}
```

![image](https://paper-attachments.dropbox.com/s_AB4BC977DF2BBAB3F9B097592E16C7567C493B52A668B2A322B5360BC04D43E9_1597997806115_oloo-prototype.png)

속성 및 메서드를 반환된 개체에 포함하여 직접 선언할 수 있습니다.

```js
function Human (firstName, lastName) {
  return {
    firstName,
    lastName, 
    sayHello () {
      console.log(`Hello, I'm ${firstName}`)
    }
  }
}
```

![image](https://paper-attachments.dropbox.com/s_AB4BC977DF2BBAB3F9B097592E16C7567C493B52A668B2A322B5360BC04D43E9_1597997821635_ff-direct.png)

공장 기능을 사용할 때는 프로토타입에 메서드를 선언할 수 없습니다. 프로토타입에 대한 메서드를 정말로 원하는 경우 생성자, 클래스 또는 OLU 인스턴스를 반환해야 합니다. (이것은 의미가 없으므로 이 작업을 수행하지 마십시오.)

```js
// Do not do this
function createHuman (...args) {
  return new Human(...args)
}
```

### 속성 및 메서드를 선언할 위치

속성 및 메서드를 인스턴스에서 직접 선언해야 합니까? 아니면 최대한 프로토타입으로 해야 하는가?

많은 사람들은 자바스크립트가 프로토타이팔 언어(시제품을 사용한다는 뜻)라고 자부한다. 이 문장에서 "프로토타입"을 사용하는 것이 더 낫다고 가정할 수 있습니다.

실제 답은 다음과 같습니다. 상관없어.

인스턴스에서 속성 및 메서드를 선언하면 각 인스턴스가 메모리를 약간 더 차지하게 됩니다. 프로토타입에 메서드를 선언하면 각 인스턴스에서 사용하는 메모리가 줄어들지만 크게 감소하지는 않습니다. 이 차이는 오늘날의 컴퓨터 처리 능력에서는 중요하지 않다. 대신 코드 쓰기가 얼마나 쉬운지, 그리고 프로토타입을 애초에 사용할 수 있는지 알아보려고 합니다.

예를 들어, 클래스 또는 OLU를 사용하는 경우 코드를 쓰기 더 쉬우므로 프로토타입을 사용하는 것이 좋습니다. 공장 기능을 사용할 경우 프로토타입을 사용할 수 없습니다. 인스턴스에서 직접 속성 및 메서드만 생성할 수 있습니다.

자세한 내용을 알고 싶으시면 JavaScript 프로토타입에 대한 이해에 대해 별도로 기사를 작성했습니다.

### 예비판결

우리는 위에 쓴 코드로 몇 가지 메모를 할 수 있습니다. 이 의견들은 나만의 것이다!

- 클래스는 클래스에 여러 메서드를 쓰는 것이 더 쉽기 때문에 생성자보다 좋습니다.
- OLU는 Object.create 부분 때문에 이상하다. 한동안 OLU를 실행했지만 Object.create라고 쓰는 것을 항상 까먹는다. 내가 그걸 사용하지 않을 만큼 충분히 이상하다.
- 클래스 및 팩트리 기능은 가장 사용하기 쉽습니다. 문제는 공장 기능이 프로토타입을 지원하지 않는다는 점입니다. 하지만 말씀드렸듯이, 이것은 생산에는 별로 문제가 되지 않습니다.

2명으로 줄었어요. 그러면 클래스 또는 팩토리 기능을 선택해야 합니까? 비교해보자!

### 클래스 대 클래스 공장 기능 - 상속

클래스 및 팩토리 기능에 대한 논의를 계속하려면 객체 지향 프로그래밍과 밀접하게 연결된 세 가지 개념을 더 이해해야 합니다.

- 상속
- 캡슐화
- 이것

상속부터 시작하겠습니다.

상속은 로드된 단어입니다. 내 생각에 업계의 많은 사람들이 상속을 잘못 사용하고 있는 것 같아. "상속"이라는 단어는 당신이 어디선가 물건을 받을 때 사용됩니다. 예를 들어:

- 만약 여러분이 부모님으로부터 상속을 받는다면, 그것은 여러분이 부모님으로부터 돈과 자산을 받는다는 것을 의미합니다.
- 만약 여러분이 부모님으로부터 유전자를 물려받은다면, 그것은 여러분이 부모님으로부터 유전자를 얻는다는 것을 의미합니다.
- 만약 당신이 당신의 선생님으로부터 과정을 물려받은다면, 그것은 당신이 그들로부터 그 과정을 받는다는 것을 의미합니다.

아주 간단합니다.

JavaScript에서 상속은 상위 Blueprint에서 속성 및 메서드를 가져오는 것과 동일한 의미를 가질 수 있습니다.

즉, 모든 인스턴스가 실제로 Blueprint에서 상속됩니다. 두 가지 방법으로 속성 및 메서드를 상속합니다.

- 인스턴스 생성 시 속성 또는 메서드를 직접 생성
- 프로토타입 체인을 통해

이전 기사에서 두 가지 방법을 모두 수행하는 방법에 대해 논의했으므로 이러한 프로세스를 코드로 볼 수 있도록 도움이 필요하면 다시 참조하시기 바랍니다.

JavaScript의 상속에는 두 번째 의미가 있습니다. 여기서 상위 Blueprint에서 파생 Blueprint를 생성합니다. 이 프로세스를 서브클래싱이라고 더 정확하게 부르지만, 사람들은 이 프로세스를 상속이라고 부르기도 합니다.

서브클래싱은 공통 Blueprint에서 파생 Blueprint를 생성하는 것입니다. 개체 지향 프로그래밍 기능을 사용하여 하위 클래스를 만들 수 있습니다.

이해하기 쉽기 때문에 먼저 클래스 구문에 대해 말씀드리겠습니다.

하위 클래스를 만들 때 `확장` 키워드를 사용합니다.

```js
class Child extends Parent {
  // ... Stuff goes here
}
```

예를 들어, `인간` 클래스에서 `개발자` 클래스를 만들고 싶다고 가정해 보겠습니다.

```js
// Human Class
class Human {
  constructor (firstName, lastName) {
    this.firstName = firstName
    this.lastName = lastName
  }

  sayHello () {
    console.log(`Hello, I'm ${this.firstName}`)
  }
}
```

개발자 클래스는 휴먼을 다음과 같이 확장한다.

```js
class Developer extends Human {
  constructor(firstName, lastName) {
    super(firstName, lastName)
  }

    // Add other methods
}
```

참고: 슈퍼는 휴먼(부모라고도 함) 클래스라고도 합니다. 휴먼에서 건설자를 시작한다. 추가 초기화 코드가 필요하지 않으면 생성자를 완전히 생략할 수 있습니다.

```js
class Developer extends Human {
  // Add other methods
}
```

개발자가 코드를 만들 수 있다고 가정해 보자. 우리는 코드 방식을 개발자에 직접 추가할 수 있습니다.

```js
class Developer extends Human {
  code (thing) {
    console.log(`${this.firstName} coded ${thing}`)
  }
}
```

다음은 `개발자`의 예입니다.

```js
const chris = new Developer('Chris', 'Coyier')
console.log(chris)
```

![image](https://paper-attachments.dropbox.com/s_AB4BC977DF2BBAB3F9B097592E16C7567C493B52A668B2A322B5360BC04D43E9_1597998158380_class.png)

공장 기능을 사용하여 하위 클래스를 만드는 네 가지 단계는 다음과 같습니다.

- 새 출고 시 기능 생성
- 상위 Blueprint의 인스턴스 생성
- 이 인스턴스의 새 복사본 만들기
- 이 새 복사본에 속성 및 메서드 추가

프로세스는 다음과 같습니다.

```js
function Subclass (...args) {
  const instance = ParentClass(...args)
  return Object.assign({}, instance, {
    // Properties and methods go here
  })
}
```

이 프로세스를 설명하기 위해 동일한 예(`개발자` 하위 클래스 만들기)를 사용합니다. 휴먼 팩토리 기능은 다음과 같습니다.

```js
function Human (firstName, lastName) {
  return {
    firstName,
    lastName,
    sayHello () {
      console.log(`Hello, I'm ${firstName}`)
    }
  }
}
```

다음과 같은 `개발자`를 생성할 수 있습니다.

```js
function Developer (firstName, lastName) {
  const human = Human(firstName, lastName)
  return Object.assign({}, human, {
    // Properties and methods go here
  })
}
```

그런 다음 다음과 같은 코드 방법을 추가합니다.

```js
function Developer (firstName, lastName) {
  const human = Human(firstName, lastName)
  return Object.assign({}, human, {
    code (thing) {
      console.log(`${this.firstName} coded ${thing}`)
    }
  })
}
```

다음은 `개발자` 인스턴스의 예입니다.

```js
const chris = Developer('Chris', 'Coyier')
console.log(chris)
```

![image](https://paper-attachments.dropbox.com/s_AB4BC977DF2BBAB3F9B097592E16C7567C493B52A668B2A322B5360BC04D43E9_1597998202996_factory.png)

참고: Getters 및 Setters를 사용하는 경우에는 Object.assignment를 사용할 수 없습니다. 믹스 같은 다른 도구가 필요합니다. 나는 이 글에서 그 이유를 설명한다.

하위 클래스 내에서 상위 메소드를 덮어써야 하는 경우가 있습니다. 다음을 통해 이 작업을 수행할 수 있습니다.

- 동일한 이름의 메서드 생성
- 상위 메서드 호출(선택 사항)
- Subclass의 방법에 필요한 모든 항목 변경

프로세스는 다음과 같습니다. 클래스:

```js
class Developer extends Human {
  sayHello () {
    // Calls the parent method
    super.sayHello() 

    // Additional stuff to run
    console.log(`I'm a developer.`)
  }
}

const chris = new Developer('Chris', 'Coyier')
chris.sayHello()
```

![image](https://paper-attachments.dropbox.com/s_AB4BC977DF2BBAB3F9B097592E16C7567C493B52A668B2A322B5360BC04D43E9_1597998234988_overwrite.png)

공장 기능은 다음과 같습니다.

```js
function Developer (firstName, lastName) {
  const human = Human(firstName, lastName)

  return Object.assign({}, human, {
      sayHello () {
        // Calls the parent method
        human.sayHello() 

        // Additional stuff to run
        console.log(`I'm a developer.`)
      }
  })
}

const chris = new Developer('Chris', 'Coyier')
chris.sayHello()
```

![image](https://paper-attachments.dropbox.com/s_AB4BC977DF2BBAB3F9B097592E16C7567C493B52A668B2A322B5360BC04D43E9_1597998258294_overwrite.png)

`구성`에 대한 언급 없이 `상속`에 대한 이야기는 절대 끝나지 않습니다. 에릭 엘리엇 같은 전문가들은 종종 우리가 상속보다 작곡을 더 선호해야 한다고 제안한다.

> "클래스 상속보다 객체 구성을 선호" 4강 "디자인 패턴: 재사용 가능한 객체 지향 소프트웨어의 요소"
컴퓨터 공학에서 복합 데이터 유형(complex data type)은 프로그래밍 언어의 원시 데이터 유형과 기타 복합 데이터 유형을 사용하여 프로그램에서 구성할 수 있는 모든 데이터 유형입니다. […] 복합체를 구성하는 행위를 구성(composition)이라고 합니다.

그럼 이제 컴포지션에 대해 좀 더 자세히 살펴보고, 컴포지션이 무엇인지 이해해보도록 하겠습니다.

구성은 두 가지를 하나로 결합하는 행위입니다. 그것은 서로 결합하는 것입니다. 개체를 병합하는 가장 일반적인 방법은 `Object.assign`을 사용하는 것입니다.

```js
const one = { one: 'one' }
const two = { two: 'two' }
const combined = Object.assign({}, one, two)
```

예를 들어 Composition의 사용을 더 잘 설명할 수 있습니다. 이미 디자이너와 개발자라는 두 개의 서브클래스가 있다고 가정해 보자. 디자이너는 디자인을 할 수 있고 개발자는 코드를 만들 수 있다. 디자이너와 개발자 모두 휴먼 클래스에서 물려받는다.

지금까지의 코드는 다음과 같습니다.

```js
class Human {
  constructor(firstName, lastName) {
    this.firstName = firstName
    this.lastName = lastName
  }

  sayHello () {
    console.log(`Hello, I'm ${this.firstName}`)
  }
}

class Designer extends Human {
  design (thing) {
    console.log(`${this.firstName} designed ${thing}`)
  }
}

class Developer extends Designer {
  code (thing) {
    console.log(`${this.firstName} coded ${thing}`)
  }
}
```

이제 세 번째 서브클래스를 생성한다고 가정해 보겠습니다. 이 하위 클래스는 디자이너와 개발자가 혼합되어 설계 및 코딩이 가능합니다. 그것을 `디자이너 개발자`(혹은 `디벨로퍼 디자이너`는 어느 것이든 원하는 대로)라고 부르자.

세 번째 서브클래스를 어떻게 만들 것인가?

디자이너 수업과 개발자 수업을 동시에 연장할 수는 없다. 이것은 어떤 속성이 먼저인지 결정할 수 없기 때문에 불가능합니다. 이것은 종종 다이아몬드 문제라고 불립니다.

![image](https://paper-attachments.dropbox.com/s_AB4BC977DF2BBAB3F9B097592E16C7567C493B52A668B2A322B5360BC04D43E9_1597998354856_diamond.png)

다이아몬드 문제는 우리가 한 개체를 다른 개체보다 우선시하는 `Object.assign`과 같은 것을 하면 쉽게 해결될 수 있다. Object.assign 접근법을 사용한다면 이렇게 수업을 확장할 수 있을 것이다. 그러나 이것은 JavaScript에서 지원되지 않습니다.

```js
// Doesn't work
class DesignerDeveloper extends Developer, Designer {
  // ...
}
```

그래서 우리는 구성에 의존할 필요가 있다.

구성은 다음과 같습니다. 서브클래싱을 통해 `DesignerDeveloper`를 만드는 대신 공통 기능을 저장하는 새로운 객체를 만들어보자. 그런 다음 필요할 때마다 이러한 기능을 포함할 수 있습니다.

실제로 다음과 같이 보일 수 있습니다.

```js
const skills = {
  code (thing) { /* ... */ },
  design (thing) { /* ... */ },
  sayHello () { /* ... */ }
}
```

그런 다음 휴먼을 아예 건너뛰고 실력에 따라 세 가지 계층을 만들 수 있다.

다음은 `Designer Developer` 코드입니다.

```js
class DesignerDeveloper {
  constructor (firstName, lastName) {
    this.firstName = firstName
    this.lastName = lastName

    Object.assign(this, {
      code: skills.code,
      design: skills.design,
      sayHello: skills.sayHello
    })
  }
}

const chris = new DesignerDeveloper('Chris', 'Coyier')
console.log(chris)
```

![image](https://paper-attachments.dropbox.com/s_AB4BC977DF2BBAB3F9B097592E16C7567C493B52A668B2A322B5360BC04D43E9_1597998387266_composition-class.png)

개발자, 디자이너로도 가능합니다.

```js
class Designer {
  constructor (firstName, lastName) {
    this.firstName = firstName
    this.lastName = lastName 

    Object.assign(this, {
      design: skills.design,
      sayHello: skills.sayHello
    }) 
  }
}

class Developer {
  constructor (firstName, lastName) {
    this.firstName = firstName
    this.lastName = lastName 

    Object.assign(this, {
      code: skills.code,
      sayHello: skills.sayHello
    }) 
  }
}
```

인스턴스에서 직접 메서드를 생성하는 것을 알고 계십니까? 이것은 단지 하나의 선택일 뿐이다. 프로토타입에 아직 메소드를 넣을 수는 있지만 코드가 흐릿해 보입니다. (건설자 기능을 다시 쓰는 것 같습니다.)

```js
class DesignerDeveloper {
  constructor (firstName, lastName) {
    this.firstName = firstName
    this.lastName = lastName
  }
}

Object.assign(DesignerDeveloper.prototype, {
  code: skills.code,
  design: skills.design,
  sayHello: skills.sayHello
})
```

![image](https://paper-attachments.dropbox.com/s_AB4BC977DF2BBAB3F9B097592E16C7567C493B52A668B2A322B5360BC04D43E9_1597998407417_composition-class-2.png)

원하는 코드 구조는 무엇이든 자유롭게 사용하시기 바랍니다. 어쨌든 결과는 비슷비슷하다.

출고 시 함수를 사용한 구성은 기본적으로 반환된 개체에 공유 메서드를 추가하는 것입니다.

```js
function DesignerDeveloper (firstName, lastName) {
  return {
    firstName,
    lastName,    
    code: skills.code,
    design: skills.design,
    sayHello: skills.sayHello
  }
}
```

![image](https://paper-attachments.dropbox.com/s_AB4BC977DF2BBAB3F9B097592E16C7567C493B52A668B2A322B5360BC04D43E9_1597998425015_composition-factory.png)

상속과 구성을 동시에 사용할 수 없다고 말하는 사람은 없습니다. 할 수 있어요!

지금까지 살펴본 예를 들어 디자이너 개발자 디자이너 개발자 인간은 여전히 인간이다. 그들은 `인간`의 대상을 확장할 수 있다.

다음은 클래스 구문과 함께 상속 및 구성을 모두 사용하는 예입니다.

```js
class Human {
  constructor (firstName, lastName) {
    this.firstName = firstName
    this.lastName = lastName
  }

  sayHello () {
    console.log(`Hello, I'm ${this.firstName}`)
  }
}

class DesignerDeveloper extends Human {}
Object.assign(DesignerDeveloper.prototype, {
  code: skills.code,
  design: skills.design
})
```

![image](https://paper-attachments.dropbox.com/s_AB4BC977DF2BBAB3F9B097592E16C7567C493B52A668B2A322B5360BC04D43E9_1597998445525_both-class.png)

Factory 기능에서도 마찬가지입니다.

```js
function Human (firstName, lastName) {
  return {
    firstName,
    lastName,
    sayHello () { 
      console.log(`Hello, I'm ${this.firstName}`)
    }
  }
}

function DesignerDeveloper (firstName, lastName) {
  const human = Human(firstName, lastName)
  return Object.assign({}, human, {
    code: skills.code,
    design: skills.design
  }
}
```

![image](https://paper-attachments.dropbox.com/s_AB4BC977DF2BBAB3F9B097592E16C7567C493B52A668B2A322B5360BC04D43E9_1597998461471_both-factory.png)

서브클래싱 대 서브클래싱에 대한 마지막 요점. 작문. 비록 전문가들이 구성이 더 유연하다고 지적했지만(따라서 더 유용하게 쓰이지만) 서브클래싱은 여전히 장점이 있다. 오늘날 우리가 사용하는 많은 것들은 서브클래싱 전략으로 만들어진다.

예를 들어: 우리가 알고 사랑하는 클릭 이벤트는 마우스 이벤트다. 마우스이벤트는 UIEvent의 서브클래스로 이벤트 서브클래스가 된다.

![image](https://paper-attachments.dropbox.com/s_AB4BC977DF2BBAB3F9B097592E16C7567C493B52A668B2A322B5360BC04D43E9_1597998492616_image.png)

다른 예: HTML 요소는 노드의 하위 클래스입니다. 그렇기 때문에 노드의 모든 속성과 방법을 사용할 수 있습니다.

![image](https://paper-attachments.dropbox.com/s_AB4BC977DF2BBAB3F9B097592E16C7567C493B52A668B2A322B5360BC04D43E9_1597998504307_image.png)

클래스 및 팩토리 함수는 상속 및 구성을 모두 사용할 수 있습니다. 공장 기능에서 구성이 더 깔끔한 것 같지만, 그렇다고 클래스가 크게 이긴 것은 아닙니다.

다음에는 클래스 및 공장 기능에 대해 자세히 살펴보겠습니다.

### 클래스 대 클래스 공장 기능 - 캡슐화

지금까지 네 가지 객체 지향 프로그래밍 맛을 살펴보았습니다. 두 가지 기능인 클래스 및 팩토리 기능은 나머지 기능에 비해 사용하기 쉽습니다.

하지만 여전히 의문점은 남습니다. 당신은 어떤 것을 사용해야 합니까? 왜?

클래스 및 팩토리 기능에 대한 논의를 계속하려면 객체 지향 프로그래밍과 밀접하게 관련된 다음 세 가지 개념을 이해해야 합니다.

- 상속
- 캡슐화
- 이것

방금 상속 얘기를 했어요. 이제 캡슐화에 대해 이야기해 보겠습니다.

## 캡슐화

캡슐화는 큰 단어이지만 단순한 의미를 가지고 있습니다. 캡슐화는 한 사물을 다른 사물에 감싸서 안에 있는 사물이 새어나가지 않게 하는 행위입니다. 병에 물을 저장하는 것을 생각해 보세요. 그 병은 물이 새어나가는 것을 막는다.

JavaScript에서는 변수(함수를 포함할 수 있음)를 외부 범위로 유출되지 않도록 포함시키는 데 관심이 있습니다. 즉, 캡슐화를 이해하려면 범위를 이해해야 합니다. 설명을 살펴보겠지만, 이 문서를 사용하여 범위에 대한 지식을 강화할 수도 있습니다.

가장 간단한 형태의 캡슐화는 블록 범위입니다.

```js
{
  // Variables declared here won't leak out
}
```

블럭에 있으면 블럭 외부에 선언된 변수에 액세스할 수 있습니다.

```js
const food = 'Hamburger'

{
  console.log(food)
}
```

![image](https://paper-attachments.dropbox.com/s_AB4BC977DF2BBAB3F9B097592E16C7567C493B52A668B2A322B5360BC04D43E9_1597998693291_inside.png)

그러나 블럭 외부에 있는 경우에는 블럭 내부에 선언된 변수에 액세스할 수 없습니다.

```js
{
  const food = 'Hamburger'
}

console.log(food)
```

![image](https://paper-attachments.dropbox.com/s_AB4BC977DF2BBAB3F9B097592E16C7567C493B52A668B2A322B5360BC04D43E9_1597998704290_outside.png)

참고: `var`로 선언된 변수는 블록 범위를 존중하지 않습니다. 이래서 변수를 선언할 때 `let`이나 `const`를 사용하는 것이 좋습니다.

함수는 블록 범위처럼 작동합니다. 함수 내부에 변수를 선언하면 해당 함수에서 변수가 누출될 수 없습니다. var로 선언한 변수도 모든 변수에 적용된다.

```js
function sayFood () {
  const food = 'Hamburger'
}

sayFood()
console.log(food)
```

![image](https://paper-attachments.dropbox.com/s_AB4BC977DF2BBAB3F9B097592E16C7567C493B52A668B2A322B5360BC04D43E9_1597998746181_outside.png)

마찬가지로, 함수 내부에 있으면 해당 함수 외부에 선언된 변수에 액세스할 수 있습니다.

```js
const food = 'Hamburger'

function sayFood () {
  console.log(food)
}


sayFood()
```

![image](https://paper-attachments.dropbox.com/s_AB4BC977DF2BBAB3F9B097592E16C7567C493B52A668B2A322B5360BC04D43E9_1597998759919_inside.png)

함수는 값을 반환할 수 있습니다. 반환된 이 값은 함수 외부에서 나중에 사용할 수 있습니다.

```js
function sayFood () {
  return 'Hamburger'
}

console.log(sayFood())
```

![image](https://paper-attachments.dropbox.com/s_AB4BC977DF2BBAB3F9B097592E16C7567C493B52A668B2A322B5360BC04D43E9_1597998778207_inside.png)

폐쇄는 고급 형태의 캡슐화입니다. 그것들은 단순히 기능들로 포장된 것입니다.

```js
// Here's a closure
function outsideFunction () {
  function insideFunction () { /* ...*/ }
}
```

`외부`에서 선언된 변수내부에서는 함수를 사용할 수 있습니다.함수 "

```js
function outsideFunction () {
  const food = 'Hamburger'
  console.log('Called outside')

  return function insideFunction () {
    console.log('Called inside')
    console.log(food)
  }
}

// Calls `outsideFunction`, which returns `insideFunction`
// Stores `insideFunction` as variable `fn`
const fn = outsideFunction() 

// Calls `insideFunction`
fn()
```

![image](https://paper-attachments.dropbox.com/s_AB4BC977DF2BBAB3F9B097592E16C7567C493B52A668B2A322B5360BC04D43E9_1597998814108_closure.png)

개체를 만들 때 사용자가 사용할 수 있도록 일부 속성을 공개적으로 사용할 수 있도록 합니다. 그러나 일부 속성은 비공개로 유지하려고 합니다(다른 속성은 구현을 중단하지 않음).

상황을 더 명확하게 하기 위해 예를 들어 이 문제를 해결합시다. 우리가 `자동차`의 청사진을 가지고 있다고 가정해보자. 우리가 새 차를 생산할 때, 우리는 각각의 차에 50리터의 연료를 채운다.

```js
class Car {
  constructor () {
    this.fuel = 50
  }
}
```

여기서 우리는 `연료` 재산을 폭로했다. 사용자는 차에 남은 연료량을 얻기 위해 연료를 사용할 수 있다.

```js
const car = new Car()
console.log(car.fuel) // 50
```

사용자는 연료 속성을 사용하여 연료량을 설정할 수도 있습니다.

```js
const car = new Car()
car.fuel = 3000
console.log(car.fuel) // 3000
```

조건을 붙여서 차 한 대당 최대 용량이 100리터라고 하자. 이런 상태라면, 우리는 사용자들이 자동차를 망가뜨릴 수 있기 때문에 `연료`를 자유롭게 설정하게 하고 싶지 않다.

사용자가 `연료`를 설정하지 못하도록 하는 두 가지 방법은 다음과 같습니다.

- 관례상 비공개
- 실제 개인 구성원

JavaScript에서는 밑줄을 변수 이름에 붙이는 방법이 있습니다. 이것은 변수가 비공개이므로 사용해서는 안 된다는 것을 나타냅니다.

```js
class Car {
  constructor () {
    // Denotes that `_fuel` is private. Don't use it!
    this._fuel = 50
  }
}
```

우리는 종종 이 "비공개" _fuel 변수를 얻고 설정하는 방법을 만든다.

```js
class Car {
  constructor () { 
    // Denotes that `_fuel` is private. Don't use it!
    this._fuel = 50
  }

  getFuel () {
    return this._fuel
  }

  setFuel (value) {
    this._fuel = value
    // Caps fuel at 100 liters
    if (value > 100) this._fuel = 100
  }
}
```

사용자는 get fuel과 set fuel을 사용하여 연료를 얻고 설정해야 한다.

```js
const car = new Car() 
console.log(car.getFuel()) // 50 

car.setFuel(3000)
console.log(car.getFuel()) // 100 
```

그러나 `_fuel`은 사실 사적인 것이 아니다. 그것은 여전히 공공 변수이다. 여전히 접근할 수 있고, 사용할 수 있으며, 남용할 수도 있습니다(남용 부분이 사고일 경우에도 마찬가지입니다.

```js
const car = new Car() 
console.log(car.getFuel()) // 50 

car._fuel = 3000
console.log(car.getFuel()) // 3000
```

사용자의 액세스를 완전히 차단하려면 실제 개인 변수를 사용해야 합니다.

여기서 구성원은 변수, 함수 및 방법을 참조합니다. 그것은 총칭이다.

클래스를 사용하면 변수에 `#`을 붙여 개인 구성원을 만들 수 있습니다.

```js
class Car {
  constructor () {
    this.#fuel = 50
  }
}
```

생성자 함수 내에서 직접 #를 사용할 수는 없습니다.

![image](https://paper-attachments.dropbox.com/s_AB4BC977DF2BBAB3F9B097592E16C7567C493B52A668B2A322B5360BC04D43E9_1597998874977_class-private.png)

먼저 생성자 외부에서 개인 변수를 선언해야 합니다.

```js
class Car {
  // Declares private variable
  #fuel 
  constructor () {
    // Use private variable
    this.#fuel = 50
  }
}
```

이 경우 연료를 50으로 설정했기 때문에 속기를 사용하고 `#연료`를 먼저 선언할 수 있다.

```js
class Car {
  #fuel = 50
}
```

자동차 외에서는 #연료에 접근할 수 없다. 오류가 발생합니다.

```js
const car = new Car()
console.log(car.#fuel)
```

![image](https://paper-attachments.dropbox.com/s_AB4BC977DF2BBAB3F9B097592E16C7567C493B52A668B2A322B5360BC04D43E9_1597998905036_class-private.png)

#연료 변수를 사용하려면 방법(getfuel 또는 setFuel)이 필요합니다.

```js
class Car {
  #fuel = 50

  getFuel () {
    return this.#fuel
  }

  setFuel (value) {
    this.#fuel = value
    if (value > 100) this.#fuel = 100
  }
}

const car = new Car()
console.log(car.getFuel()) // 50

car.setFuel(3000)
console.log(car.getFuel()) // 100
```

참고: 나는 get fuel과 set fuel보다는 getters와 setters를 선호한다. 구문을 읽기 더 쉽다.

```js
class Car {
  #fuel = 50

  get fuel () {
    return this.#fuel
  }

  set fuel (value) {
    this.#fuel = value
    if (value > 100) this.#fuel = 100
  }
}

const car = new Car()
console.log(car.fuel) // 50

car.fuel = 3000
console.log(car.fuel) // 100
```

공장 기능은 자동으로 개인 구성원을 만듭니다. 변수를 일반 변수와 같이 선언하면 됩니다. 사용자는 다른 곳에서는 해당 변수를 가져올 수 없습니다. 그 이유는 변수가 함수 범위이므로 기본적으로 캡슐화되기 때문입니다.

```js
function Car () {
  const fuel = 50 
}

const car = new Car() 
console.log(car.fuel) // undefined 
console.log(fuel) // Error: `fuel` is not defined
```

우리는 이 민간 `연료` 변수를 사용하기 위해 getter와 setter 기능을 만들 수 있다.

```js
function Car () {
  const fuel = 50 

  return {
    get fuel () { 
      return fuel 
    },

    set fuel (value) {
      fuel = value 
      if (value > 100) fuel = 100
    }
  }
}

const car = new Car()
console.log(car.fuel) // 50

car.fuel = 3000
console.log(car.fuel) // 100
```

다 됐다! 더 이상 어쩔 수 없다! 간단하고 쉬워요!

공장 기능을 포함한 캡슐화는 더 간단하고 이해하기 쉽습니다. 이들은 JavaScript 언어의 큰 부분을 차지하는 범위에 의존합니다.

반면 클래스가 포함된 캡슐화는 개인 변수에 `#`을 붙여야 합니다. 이것은 사물을 탁하게 만들 수 있다.

다음 절에서는 `이것`이라는 개념에 대해 알아보겠습니다. 클래스 기능과 팩토리 기능의 비교를 완료하기 위한 개념입니다.

### 클래스 대 클래스 공장 기능 - '이' 변수

"this"(ha!)는 객체 지향 프로그래밍을 위한 클래스 사용에 반대하는 주요 논쟁 중 하나입니다. 그 이유는 무엇입니까? 이 값은 사용 방법에 따라 달라지기 때문입니다. 이는 많은 개발자(신규 개발자와 경험자 모두)에게 혼란을 줄 수 있습니다.

그러나 실제로는 이것이라는 개념이 비교적 단순하다. 이것을 사용할 수 있는 컨텍스트는 6개뿐이다. 이 여섯 가지 문맥을 마스터하면 `이`를 사용하는 데 문제가 없습니다.

여섯 가지 맥락은 다음과 같습니다.

- 글로벌 컨텍스트에서
- 객체 구조에서
- 개체 속성/ 메서드에서
- 간단한 기능에서
- 화살표 함수에서
- 이벤트 수신기

저는 이 여섯 가지 맥락을 자세히 다루었습니다. 이것을 이해하는 데 도움이 필요하면 읽어라.

참고: 이것을 사용하는 법을 배우는 것을 꺼리지 마세요. JavaScript를 마스터하려면 이 개념을 이해해야 합니다.

이것에 대한 지식을 굳힌 후에 이 기사로 돌아오세요. 클래스 및 팩토리 기능에서 `이것`을 사용하는 것에 대해 좀 더 심도 있게 논의하겠습니다.

아직 안 돌아왔어? 좋아, 가자!

`이`는 클래스에서 사용될 때의 인스턴스를 말합니다. (이것은 "In a object property / method" 컨텍스트를 사용합니다.) 그렇기 때문에 생성자 함수 내의 인스턴스에서 속성 및 메서드를 설정할 수 있습니다.

```js
class Human {
  constructor (firstName, lastName) {
    this.firstName = firstName
    this.lastName = lastName
    console.log(this)
  }
}

const chris = new Human('Chris', 'Coyier')
```

![image](https://paper-attachments.dropbox.com/s_AB4BC977DF2BBAB3F9B097592E16C7567C493B52A668B2A322B5360BC04D43E9_1597998979647_class.png)

함수 내부에 this를 사용하고 new를 사용하여 인스턴스를 생성하면 this가 인스턴스를 참조한다. 생성자 함수는 이렇게 생성됩니다.

```js
function Human (firstName, lastName) {
  this.firstName = firstName 
  this.lastName = lastName
  console.log(this)  
}

const chris = new Human('Chris', 'Coyier')
```

![image](https://paper-attachments.dropbox.com/s_AB4BC977DF2BBAB3F9B097592E16C7567C493B52A668B2A322B5360BC04D43E9_1597998999533_class.png)

Factory function 안에서 this를 사용할 수 있기 때문에 Constructor function을 언급하였습니다. 그러나 "this"는 "Windows"(ES6 Modules 또는 웹 팩과 같은 번들을 사용하는 경우 정의되지 않음)를 가리킵니다.

```js
// NOT a Constructor function because we did not create instances with the `new` keyword
function Human (firstName, lastName) {
  this.firstName = firstName 
  this.lastName = lastName
  console.log(this)  
}

const chris = Human('Chris', 'Coyier')
```

![image](https://paper-attachments.dropbox.com/s_AB4BC977DF2BBAB3F9B097592E16C7567C493B52A668B2A322B5360BC04D43E9_1597999027058_factory-1.png)

기본적으로 Factory 함수를 생성할 때 생성자 함수인 것처럼 "this"를 사용하면 안 됩니다. 이것은 사람들이 이것으로 경험하는 작은 딸꾹질이다. 나는 문제점을 부각시켜 분명히 하고 싶었다.

Factory 함수에서 "this"를 사용하는 올바른 방법은 "object property/method" 컨텍스트에서 사용하는 것입니다.

```js
function Human (firstName, lastName) {
  return {
    firstName,
    lastName,
    sayThis () {
      console.log(this)
    }
  }
}

const chris = Human('Chris', 'Coyier')
chris.sayThis()
```

![image](https://paper-attachments.dropbox.com/s_AB4BC977DF2BBAB3F9B097592E16C7567C493B52A668B2A322B5360BC04D43E9_1597999047100_factory-2.png)

Factory 기능에서 this를 사용할 수 있지만 사용할 필요는 없습니다. 인스턴스를 가리키는 변수를 만들 수 있습니다. 이렇게 하면 "this" 대신 변수를 사용할 수 있습니다. 여기 직장에서의 예가 있습니다.

```js
function Human (firstName, lastName) {
  const human = {
    firstName,
    lastName,
    sayHello() {
      console.log(`Hi, I'm ${human.firstName}`)
    }
  }

  return human
}

const chris = Human('Chris', 'Coyier')
chris.sayHello()
```

`인간.퍼스트네임`은 이것보다 더 명확하다.firstName은 human이 분명히 그 예를 가리키기 때문이다. 코드 보면 알잖아요.

만약 여러분이 자바스크립트에 익숙하다면, `인간`이라고 쓸 필요도 없다는 것을 알아차릴지도 모른다.애초에 firstName! `이름`이 어휘 범위에 있으므로 `이름`만으로 충분합니다. (범위 도움말이 필요한 경우 이 기사를 읽어 보십시오.)

```js
function Human (firstName, lastName) {
  const human = {
    firstName,
    lastName,
    sayHello() {
      console.log(`Hi, I'm ${firstName}`)
    }
  }

  return human
}

const chris = Human('Chris', 'Coyier')
chris.sayHello() 

```

![image](https://paper-attachments.dropbox.com/s_AB4BC977DF2BBAB3F9B097592E16C7567C493B52A668B2A322B5360BC04D43E9_1597999097985_hello.png)

지금까지 다룬 내용은 간단합니다. 충분히 복잡한 사례를 만들기 전까지는 이것이 실제로 필요한지 판단하기가 쉽지 않다. 자, 그렇게 합시다.

### 상세한 예

여기 설정이 있습니다. 우리가 인간 청사진을 가지고 있다고 가정해 보자. 이 휴먼에는 퍼스트네임과 성, 그리고 세이헬로(say hello)라는 속성이 있다.

우리는 인간에서 파생된 개발자의 청사진을 가지고 있다. 개발자는 코드를 만들 수 있으므로 코드 방법을 사용할 수 있습니다. 개발자들도 자신들이 개발자라고 선언하고 싶기 때문에 우리는 인사말을 덮어쓰고 나는 개발자라는 말을 콘솔에 추가해야 한다.

클래스 및 팩토리 기능을 사용하여 이 예제를 만듭니다. (Factory 기능에 대해 `this`와 `this`가 없는 예를 만들겠습니다.)

첫째, 우리는 `인간` 청사진을 가지고 있다. 이 휴먼(Human)은 퍼스트 네임(first Name)과 라스트 네임(last Name) 속성, 세이 헬로(say hello) 방식 등을 갖췄다.

```js
class Human {
  constructor (firstName, lastName) {
    this.firstName = firstName
    this.lastname = lastName 
  }

  sayHello () {
    console.log(`Hello, I'm ${this.firstName}`)
  }
}
```

우리는 인간에서 파생된 개발자의 청사진을 가지고 있다. 개발자는 코드를 만들 수 있으므로 코드 방법을 사용할 수 있습니다.

```js
class Developer extends Human {
  code (thing) {
    console.log(`${this.firstName} coded ${thing}`)
  }
}
```

개발자들 또한 자신들이 개발자라고 선언하고 싶어합니다. "SayHello"를 덮어쓰고 "I`m a Developer"를 콘솔에 추가해야 합니다. 우리는 휴먼의 세이 헬로(say hello) 방식으로 부른다. 우리는 `슈퍼`를 사용해서 이것을 할 수 있다.

```js
class Developer extends Human {
  code (thing) {
    console.log(`${this.firstName} coded ${thing}`)
  }

  sayHello () {
    super.sayHello()
    console.log(`I'm a developer`)
  }
}
```

다시, 첫째, 우리는 `인간` 청사진을 가지고 있다. 이 휴먼(Human)은 say hello(세이 헬로) 방식뿐만 아니라 퍼스트 네임(first Name)과 성(last Name) 속성도 갖고 있다.

```js
function Human () {
  return {
    firstName,
    lastName,
    sayHello () {
      console.log(`Hello, I'm ${this.firstName}`)
    }
  }
}
```

다음으로, 우리는 인간에서 파생된 개발자의 청사진을 가지고 있다. 개발자는 코드를 만들 수 있으므로 코드 방법을 사용할 수 있습니다.

```js
function Developer (firstName, lastName) {
  const human = Human(firstName, lastName)
  return Object.assign({}, human, {
    code (thing) {
      console.log(`${this.firstName} coded ${thing}`)
    }
  })
}
```

개발자들 또한 자신들이 개발자라고 선언하고 싶어한다. "SayHello"를 덮어쓰고 "I`m a Developer"를 콘솔에 추가해야 합니다.
우리는 휴먼의 세이 헬로(say hello) 방식으로 부른다. 우리는 `인간`의 예를 통해 이것을 할 수 있다.

```js
function Developer (firstName, lastName) {
  const human = Human(firstName, lastName)
  return Object.assign({}, human, {
    code (thing) {
      console.log(`${this.firstName} coded ${thing}`)
    },

    sayHello () {
      human.sayHello()
      console.log('I\'m a developer')
    }
  })
}
```

다음은 Factory 기능을 사용하는 전체 코드입니다(`이`).

```js
function Human (firstName, lastName) {
  return {
    firstName,
    lastName,
    sayHello () {
      console.log(`Hello, I'm ${this.firstName}`)
    }
  }
}

function Developer (firstName, lastName) {
  const human = Human(firstName, lastName)
  return Object.assign({}, human, {
    code (thing) {
      console.log(`${this.firstName} coded ${thing}`)
    },

    sayHello () {
      human.sayHello()
      console.log('I\'m a developer')
    }
  })
}
```

퍼스트 네임(first Name)이 휴먼(human)과 디벨로퍼(developer)의 어휘적 범위 내에서 사용 가능한 것을 알고 계십니까? 이를 생략하고 두 청사진에서 firstName을 직접 사용할 수 있다는 뜻이다.

```js
function Human (firstName, lastName) {
  return {
    // ...
    sayHello () {
      console.log(`Hello, I'm ${firstName}`)
    }
  }
}

function Developer (firstName, lastName) {
  // ...
  return Object.assign({}, human, {
    code (thing) {
      console.log(`${firstName} coded ${thing}`)
    },

    sayHello () { /* ... */ }
  })
}
```

보이지? 즉, Factory 기능을 사용할 때 코드에서 "this"를 안전하게 생략할 수 있습니다.

간단히 말하면, 클래스는 "이"를 필요로 하지만 팩토리 기능은 그렇지 않습니다. 다음과 같은 이유로 공장 기능을 선호합니다.

- `this`의 컨텍스트가 변경될 수 있습니다(혼란스러울 수 있음).
- 공장 함수로 작성된 코드는 이것을 쓰지 않고도 캡슐화된 변수를 사용할 수 있기 때문에 더 짧고 깨끗하다.#the #the").

다음은 클래스 및 팩토리 기능과 함께 간단한 구성 요소를 구축하는 마지막 섹션입니다. 여러분은 그것들이 어떻게 다른지, 그리고 각 향료와 함께 이벤트 청취자들을 어떻게 사용하는지를 볼 수 있습니다.

### 클래스 대 공장 기능 — 이벤트 수신기

대부분의 개체 지향 프로그래밍 기사에는 이벤트 수신기가 없는 예가 나와 있습니다. 이러한 예는 더 이해하기 쉬울 수 있지만, 우리가 프런트엔드 개발자로서 수행하는 작업을 반영하지는 않습니다. 우리가 하는 일은 간단한 이유로 이벤트 청취자를 필요로 합니다. 왜냐하면 우리는 사용자 입력에 의존하는 것들을 구축해야 하기 때문입니다.

이벤트 청취자가 `이것`의 맥락을 바꾸기 때문에, 그들은 수업을 다루기 어렵게 만들 수 있다. 동시에, 공장 기능을 더욱 매력적으로 만듭니다.

하지만 사실은 그렇지 않습니다.

클래스 및 팩토리 기능에서 모두 이것을 처리할 수 있는 방법을 알고 있다면 "이"의 변화는 중요하지 않다. 이 주제를 다루는 기사는 거의 없기 때문에 객체 지향 프로그래밍 맛을 이용하여 간단한 구성 요소로 이 기사를 완성하는 것이 좋을 것 같았다.

우리는 이 기사에서 간단한 카운터를 만들 것입니다. 개인 변수를 포함하여 이 기사에서 배운 모든 내용을 사용할 것입니다.

카운터에 두 가지가 있다고 가정해 보겠습니다.

- 카운트 자체
- 카운트를 늘리기 위한 버튼

다음은 카운터를 위한 가장 간단한 HTML입니다.

```html
<div class="counter">
  <p>Count: <span>0</span>
  <button>Increase Count</button>
</div>
```

간단한 작업을 위해 사용자에게 카운터의 HTML을 찾아서 `카운터` 클래스로 전달하도록 요청합니다.

```js
class Counter () {
  constructor (counter) {
    // Do stuff 
  } 
}

// Usage 
const counter = new Counter(document.querySelector('.counter'))
```

카운터 클래스에는 두 가지 요소가 필요합니다.

- 카운트가 포함된 `<span> - 카운트가 증가할 때 이 요소를 업데이트해야 합니다.
- `< 버튼> – 이 요소 클래스에 이벤트 수신기를 추가해야 합니다.

```js
Counter () {
  constructor (counter) {
    this.countElement = counter.querySelector('span')
    this.buttonElement = counter.querySelector('button')
  }
}
```

카운트 변수를 초기화하여 count Element가 표시하는 것으로 설정합니다. 카운트가 다른 곳에 노출되어서는 안 되기 때문에 우리는 사설 "#count" 변수를 사용할 것이다.

```js
class Counter () {
  #count
  constructor (counter) {
    // ...

    this.#count = parseInt(countElement.textContent)
  } 
}
```

사용자가 [<] 단추를 클릭하면 "#count"를 증가시키고자 합니다. 우리는 다른 방법으로 이것을 할 수 있다. 이 방법의 이름을 `증가수`로 지정합니다.

```js
class Counter () {
  #count
  constructor (counter) { /* ... */ }

  increaseCount () {
    this.#count = this.#count + 1
  }
}
```

다음으로, 우리는 DOM을 새로운 `#count`로 업데이트해야 합니다. 이를 위해 updateCount라는 메서드를 생성해 보겠습니다. updateCount에서 updateCount를 호출하겠습니다.

```js
class Counter () {
  #count
  constructor (counter) { /* ... */ }

  increaseCount () {
    this.#count = this.#count + 1
    this.updateCount()
  }

  updateCount () {
    this.countElement.textContent = this.#count
  }
}
```

이제 이벤트 수신기를 추가할 준비가 되었습니다.

이벤트 수신기를 `이것`에 추가할 것입니다.Element` 버튼을 누릅니다. 아쉽지만 당장 `증액수`를 콜백으로 쓸 수는 없다. 한번 해보면 오류가 납니다.

```js
class Counter () {
  // ...

  constructor (counter) {
    // ...
    this.buttonElement.addEventListener('click', this.increaseCount)
  }

  // Methods
}
```

![image](https://paper-attachments.dropbox.com/s_AB4BC977DF2BBAB3F9B097592E16C7567C493B52A668B2A322B5360BC04D43E9_1598524141485_error.gif)

`이`가 `버튼 요소`를 가리키기 때문에 오류가 발생합니다. (이것은 이벤트 수신기 컨텍스트입니다.) 콘솔에 "이"를 로그인하면 "Element" 버튼이 표시됩니다.

![image](https://paper-attachments.dropbox.com/s_AB4BC977DF2BBAB3F9B097592E16C7567C493B52A668B2A322B5360BC04D43E9_1598524192798_error2.gif)

일이 잘 풀리기 위해서는 이것의 가치를 `증가수`의 예시로 바꿔야 한다. 다음 두 가지 방법을 사용할 수 있습니다.

- 바인딩 사용
- 화살표 기능 사용

대부분의 사람들은 첫 번째 방법을 사용합니다.

`ㄹ`은 새로운 기능을 반환합니다. 이렇게 하면 `이`를 통과된 첫 번째 주장으로 변경할 수 있습니다. 사람들은 보통 bind(이것)를 불러서 이벤트 청취자를 만든다.

```js
class Counter () {
  // ...

  constructor (counter) {
    // ...
    this.buttonElement.addEventListener('click', this.increaseCount.bind(this))
  }

  // ...
}
```

이것은 효과가 있지만, 읽기에는 별로 좋지 않습니다. 바인드는 고급 자바스크립트 기능으로 인식되기 때문에 초보자 친화적이지도 않다.

두 번째 방법은 화살표 기능을 사용하는 것입니다. 화살표 함수는 어휘 컨텍스트에 `this` 값을 보존하기 때문에 작동합니다.

대부분의 사용자는 다음과 같이 화살표 함수 콜백 안에 메서드를 씁니다.

```js
class Counter () {
  // ...

  constructor (counter) {
    // ...
    this.buttonElement.addEventListener('click', _ => {
      this.increaseCount()
    })
  }

  // Methods
}
```

이것은 효과가 있지만, 그것은 멀리 떨어져 있다. 사실 지름길이 있어요.

화살표 기능을 사용하여 `증가수`를 생성할 수 있습니다. 이렇게 하면 "증가수"에 대한 "this" 값이 인스턴스의 값에 바로 바인딩됩니다.

필요한 코드는 다음과 같습니다.

```js
class Counter () {
  // ...

  constructor (counter) {
    // ...
    this.buttonElement.addEventListener('click', this.increaseCount)
  }

  increaseCount = () => {
    this.#count = this.#count + 1
    this.updateCounter()
  }

  // ...
}
```

다음은 (화살표 기능 사용) 클래스 기반 코드의 전체 버전입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_VwabbEE" src="//codepen.io/anon/embed/VwabbEE?height=450&amp;theme-id=1&amp;slug-hash=VwabbEE&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed VwabbEE" title="CodePen Embed VwabbEE" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

우리도 여기서 같은 일을 할 거야. 우리는 사용자들이 카운터의 HTML을 카운터 공장에 전달하도록 할 것이다.

```js
function Counter (counter) {
  // ...
}

const counter = Counter(document.querySelector('.counter'))
```

카운터(counter)에서 <span>과 <button>이라는 두 가지 요소를 얻을 필요가 있다. 여기서 (이것이 없는) 정규 변수는 이미 개인 변수이기 때문에 사용할 수 있습니다. 우리는 그들을 노출시키지 않을 거야

```js
function Counter (counter) {
  const countElement = counter.querySelector('span')
  const buttonElement = counter.querySelector('button')
}
```

HTML에 있는 값으로 카운트 변수를 초기화하겠습니다.

```js
function Counter (counter) {
  const countElement = counter.querySelector('span')
  const buttonElement = counter.querySelector('button')

  let count = parseInt(countElement.textContext)
}
```

우리는 "count" 방식으로 이 "count" 변수를 늘릴 것이다. 여기서 정상적인 기능을 선택하실 수 있지만, 저는 깔끔하고 깔끔하게 정리할 수 있는 방법을 만들고 싶습니다.

```js
function Counter (counter) {
  // ... 
  const counter = {
    increaseCount () {
      count = count + 1
    }
  }
}
```

마지막으로 updateCount 방법으로 카운트를 업데이트할 것입니다. 우리는 또한 `증가수`에서 `업데이트카운트`라고 부를 것이다.

```js
function Counter (counter) {
  // ... 
  const counter = {
    increaseCount () {
      count = count + 1
      counter.updateCount()
    }

    updateCount () {
      increaseCount()
    }
  }
}
```

알림: `this.updateCount` 대신 `counter.updateCount`를 사용했습니까? 카운터가 이것보다 더 선명해서 좋다.초보자도 팩토리 기능(나중에 다룰 내용)에 있는 this(이)를 틀릴 수 있기 때문에 이렇게 합니다.

버튼 요소에 이벤트 청취자를 추가할 수 있습니다. 이렇게 하면 counter.증가 카운트를 바로 콜백으로 사용할 수 있습니다.

이렇게 할 수 있는 것은 우리가 이걸 사용하지 않았기 때문에 듣는 사람이 이걸 바꿔도 상관없습니다.

```js
function Counter (counterElement) {
  // Variables 

  // Methods
  const counter = { /* ... */ }

  // Event Listeners
  buttonElement.addEventListener('click', counter.increaseCount)
}
```

Factory 기능에서 "this"를 사용할 수 있습니다. 그러나 메서드 컨텍스트에서 this를 사용해야 합니다.

다음 예에서 `counter.증가수`를 호출하면 JavaScript에서 `counter.updateCount`도 호출됩니다. 이것이 카운터 변수를 가리키기 때문에 효과가 있다.

```js
function Counter (counterElement) {
  // Variables 

  // Methods
  const counter = {
    increaseCount() {
      count = count + 1
      this.updateCount()
    }
  }

  // Event Listeners
  buttonElement.addEventListener('click', counter.increaseCount)
}
```

불행히도 이 값이 바뀌었기 때문에 이벤트 청취자가 작동하지 않았다. 이벤트 수신기를 다시 작동하려면 바인딩 또는 화살표 기능이 있는 클래스와 동일한 처리가 필요합니다.

그리고 이것은 나를 두번째 gotcha로 이끈다.

출고 시 함수 구문을 사용하는 경우 화살표 함수를 사용하여 메서드를 생성할 수 없습니다. 그 이유는 그 방법들이 단순한 `함수` 맥락에서 만들어지기 때문이다.

```js
function Counter (counterElement) {
  // ...
  const counter = {
    // Do not do this. 
    // Doesn't work because `this` is `Window`
    increaseCount: () => {
      count = count + 1
      this.updateCount()
    }
  }
  // ...
}
```

따라서 Factory 기능을 사용할 경우 "이"를 생략하는 것이 좋습니다. 그렇게 하는 게 훨씬 더 쉬워요.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_WNwjjaQ" src="//codepen.io/anon/embed/WNwjjaQ?height=450&amp;theme-id=1&amp;slug-hash=WNwjjaQ&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed WNwjjaQ" title="CodePen Embed WNwjjaQ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

듣는 사람도 이것의 가치를 바꾸기 때문에 우리는 이 값을 사용하는 것에 매우 주의해야 한다. 클래스를 사용할 경우 `bind`를 사용할 필요가 없도록 화살표 기능으로 이벤트 수신기 콜백을 만들 것을 권장합니다.

Factory 기능을 사용할 경우 혼동을 줄 수 있으므로 "이"를 생략하는 것이 좋습니다. 다 됐다! 더 이상 어쩔 수 없다!

### 결론

우리는 객체 지향 프로그래밍의 네 가지 맛에 대해 이야기했습니다. 그 이유는 다음과 같습니다.

- 생성자 함수
- 반
- 올루
- 공장기능

먼저, 우리는 코드와 관련된 관점에서 클래스 및 팩토리 기능을 사용하기 더 쉽다는 결론을 내렸다.

둘째, 우리는 클래스 및 팩토리 기능과 함께 서브클래스를 사용하는 방법을 비교했다. 여기서는 클래스를 사용하면 하위 클래스를 만들기가 더 쉽지만 공장 기능을 사용하면 구성 작업이 더 쉬워집니다.

셋째, 캡슐화를 클래스 및 공장 기능과 비교했다. 여기서 우리는 공장 캡슐화 함수가 JavaScript와 같이 자연스러운 반면 Classs를 사용하여 캡슐화하려면 변수 앞에 `#`을 추가해야 한다는 것을 알 수 있다.

넷째, 우리는 클래스 및 팩토리 기능에서 `이것`의 사용법을 비교했다. 이것은 애매할 수 있기 때문에 나는 여기서 공장 기능이 이긴다고 생각한다. 이거 쓰면서.#privateVariable은 privateVariable 자체보다 더 긴 코드를 생성하기도 한다.

마지막으로, 이 기사에서는 클래스 및 팩토리 기능을 모두 갖춘 간단한 카운터를 구축했습니다. 객체 지향 프로그래밍 맛에 이벤트 수신기를 추가하는 방법을 배웠습니다. 두 가지 맛이 모두 효과가 있습니다. 이걸 쓰든 말든 조심하면 된다.

다 됐다! 더 이상 어쩔 수 없다!

저는 이것이 자바스크립트에서 객체 지향 프로그래밍에 빛을 비추길 바랍니다. 이 기사가 마음에 드신다면 제 JavaScript 과정인 Learn JavaScript를 좋아하실 수 있습니다. 여기에서 JavaScript에 대해 알아야 할 모든 내용을 다음과 같이 명확하고 간결한 형식으로 설명합니다.

자바스크립트나 프런트엔드 개발에 대해 궁금한 점이 있으시면 언제든지 연락주세요. 내가 어떻게 도울 수 있는지 볼게!