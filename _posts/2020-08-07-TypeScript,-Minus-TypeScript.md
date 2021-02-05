---
layout: post
title: "TypeScript, 빼기 TypeScript"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/08/typscript-hollow.png
tags: TYPESCRIPT
---


지난 몇 년 동안 바위 밑에 숨어 지낸 적이 없다면(그리고 돌 밑에 숨어 있는 것이 옳은 일이라고 느껴질 때도 있다) TypeScript에 대해 들어본 적이 있을 것입니다. TypeScript는 이름에서 알 수 있듯이 웹이 즐겨 사용하는 스크립팅 언어에 입력을 추가하는 자바스크립트의 구문 상위 집합이다.

TypeScript는 매우 강력하지만, 종종 초보자에게 읽기 어렵고 자바스크립트가 유효하지 않은 추가 구문 때문에 브라우저에서 실행하기 전에 컴파일 단계가 필요한 오버헤드를 수반한다. 많은 프로젝트에서 이것은 문제가 되지 않지만, 다른 프로젝트에서는 이러한 작업이 작업 수행에 방해가 될 수 있습니다. 다행히 TypeScript 팀은 JSDoc을 사용하여 check banilla JavaScript를 입력할 수 있게 되었다.

## 새 프로젝트 설정

새 프로젝트에서 TypeScript를 설정하고 실행하려면 NodeJS 및 npm이 필요합니다. 먼저 새 프로젝트를 만들고 npm을 실행하는 것으로 시작하겠습니다. 이 기사의 목적상, 우리는 VShttps://code.visual studio.comCode를 우리의 코드 편집기로 사용할 것이다. 모든 것이 설정되면 TypeScript를 설치해야 합니다.

```terminal
npm i -D typescript
```

설치가 완료되면 TypeScript에 코드를 어떻게 처리해야 하는지 알려주어야 하므로 `tsconfig.json`이라는 새 파일을 생성하고 다음을 추가해 보겠습니다.

```js
{
  "compilerOptions": {
    "target": "esnext",
    "module": "esnext",
    "moduleResolution": "node",
    "lib": ["es2017", "dom"],
    "allowJs": true,
    "checkJs": true,
    "noEmit": true,
    "strict": false,
    "noImplicitThis": true,
    "alwaysStrict": true,
    "esModuleInterop": true
  },
  "include": [ "script", "test" ],
  "exclude": [ "node_modules" ]
}
```

우리의 목적을 위해, 이 구성 파일의 중요한 줄은 `allowJs`와 `checkJs` 옵션이며, 둘 다 `true`로 설정되어 있다. 이들은 TypeScript가 우리의 JavaScript 코드를 평가하기를 원한다고 말합니다. 또한 TypeScript에 `/script` 디렉토리 내의 모든 파일을 확인하라고 지시했으므로, 해당 파일과 해당 디렉터리에 `index.js`라는 새 파일을 생성해 보겠습니다.

### 간단한 예

새로 생성된 JavaScript 파일 내에서 다음 두 개의 매개 변수를 사용하고 이를 함께 추가하는 간단한 추가 기능을 만들어 보겠습니다.

```js
function add(x, y) {
  return x + y;
}
```

아주 간단하죠? add(4, 2)는 6을 반환하지만 JavaScript가 동적으로 입력되므로 문자열과 숫자로 add를 호출하여 잠재적으로 예기치 않은 결과를 얻을 수도 있습니다.

```js
add('4', 2); // returns '42'
```

그것은 이상적이지 않다. 다행히도, JSDoc 주석을 기능에 추가하여 사용자에게 작동 방법을 알려줄 수 있습니다.

```js
/**
 * Add two numbers together
 * @param {number} x
 * @param {number} y
 * @return {number}
 */
function add(x, y) {
  return x + y;
}
```

우리는 코드에 대해 아무것도 바꾸지 않았습니다. 우리는 단순히 사용자들에게 그 기능이 어떻게 사용될 것인지 그리고 어떤 가치를 반환할 것으로 예상하는지 알려주기 위한 코멘트를 덧붙였을 뿐입니다. 우리는 곱슬곱슬한 교정기({})로 설정된 JSDoc의 @param 및 @return 주석을 활용하여 이 작업을 수행했다.

이전에 잘못된 코드 조각을 실행하려고 하면 VSCode에 오류가 발생합니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/07/image-25.png?resize=1024%2C445&ssl=1)

위의 예에서, TypeScript는 우리의 의견을 읽고 우리를 위해 그것을 확인하고 있습니다. 실제 TypeScript에서 현재 당사의 기능은 다음과 같습니다.

```js
/**
 * Add two numbers together
 */
function add(x: number, y: number): number {
  return x + y;
}
```

숫자형을 사용한 것처럼 문자열, 오브젝트, 어레이는 물론 HTMLlement, Mutation Record 등 수십 가지 내장형 JSDoc에 접근할 수 있다.

TypeScript의 사유 구문보다 JSDoc 주석을 사용함으로써 얻을 수 있는 한 가지 이점은 개발자가 인라인(우리 코드를 자체 문서화하는 긍정적인 습관을 장려할 수 있음)을 제공함으로써 인수 또는 유형 정의에 대한 추가 메타데이터를 제공할 수 있는 기회를 제공한다는 것이다.

또한 TypeScript에 특정 객체의 인스턴스에 예상이 있을 수 있음을 알릴 수 있습니다. 예를 들어, "WeakMap"은 모든 객체와 다른 데이터 간에 매핑을 생성하는 내장 JavaScript 객체이다. 이 두 번째 데이터 조각은 기본적으로 무엇이든 될 수 있지만, 만약 우리가 `WeakMap` 인스턴스가 문자열만을 값으로 사용하기를 원한다면, 우리는 우리가 원하는 것을 TypeScript에 말할 수 있다.

```js
/** @type {WeakMap<object>, string} */
const metadata = new WeakMap();
 
const object = {};
const otherObject = {};
 
metadata.set(object, 42);
metadata.set(otherObject, 'Hello world');
```

데이터가 문자열이 아니기 때문에 42로 설정하려고 하면 오류가 발생합니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/07/image-26.png?resize=1024%2C236&ssl=1)

### 고유한 유형 정의

TypeScript와 마찬가지로, JSDoc도 우리 자신의 유형을 정의하고 작업할 수 있게 해줍니다. 이름, 나이, 취미 등 다양한 속성을 가진 새로운 타입의 사람을 만들어 보자. TypeScript에서는 다음과 같이 표시됩니다.

```js
interface Person {
  name: string;
  age: number;
  hobby?: string;
}
```

JSDoc의 유형은 다음과 같습니다.

```js
/**
 * @typedef Person
 * @property {string} name - The person's name
 * @property {number} age - The person's age
 * @property {string} [hobby] - An optional hobby
 */
```

@typeef 태그를 사용하여 우리 유형의 `name`을 정의할 수 있습니다. 필요한 `이름`(문자열)과 `나이`(숫자) 속성과 세 번째 선택적 속성인 `취미`(문자열)를 가진 `사람`이라는 인터페이스를 정의해 보자. 이러한 속성을 정의하기 위해 주석 내부에 @property(또는 짧은 @prop 키)를 사용합니다.

@type 코멘트를 사용하여 새로운 객체에 `사용자` 타입을 적용하기로 선택하면 코드 작성 시 타입 확인과 자동 완료가 이루어집니다. 뿐만 아니라, 파일에 정의된 계약을 준수하지 않을 때도 다음과 같은 메시지가 표시됩니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/07/image-27.png?resize=1024%2C334&ssl=1)

이제 개체를 완료하면 다음 오류가 지워집니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/07/image-28.png?resize=1024%2C445&ssl=1)

그러나 경우에 따라서는 유형에 대해 완전한 개체를 원하지 않습니다. 예를 들어, 가능한 옵션의 제한된 집합을 제공할 수 있습니다. 이 경우, 우리는 조합 유형이라고 불리는 것을 이용할 수 있습니다.

```js
/**
 * @typedef {'cat'|'dog'|'fish'} Pet
 */
 
/**
 * @typedef Person
 * @property {string} name - The person's name
 * @property {number} age - The person's age
 * @property {string} [hobby] - An optional hobby
 * @property {Pet} [pet] - The person's pet
 */
```

이 예에서 우리는 `고양이`는 `개` 또는 `물고기`의 가능한 옵션 중 하나가 될 수 있는 `펫`이라는 조합 유형을 정의했다. 우리 지역의 다른 어떤 동물도 애완용으로 사용할 수 없기 때문에 만약 위의 `caleb`가 캥거루를 그의 가정에 입양하려 한다면, 우리는 다음과 같은 오류를 범하게 될 것이다.

```js
/** @type {Person} */
const caleb = {
  name: 'Caleb Williams',
  age: 33,
  hobby: 'Running',
  pet: 'kangaroo'
};
```

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/07/image-29.png?resize=1024%2C693&ssl=1)

동일한 기술을 사용하여 함수의 다양한 유형을 혼합할 수 있습니다.

```js
/**
 * @typedef {'lizard'|'bird'|'spider'} ExoticPet
 */
 
/**
 * @typedef Person
 * @property {string} name - The person's name
 * @property {number} age - The person's age
 * @property {string} [hobby] - An optional hobby
 * @property {Pet|ExoticPet} [pet] - The person's pet
 */
```

이제 우리 사람 타입은 애완동물이나 이국적인 애완동물을 가질 수 있다.

### 일반 작업

딱딱하고 빠른 타입을 원하지 않고 일관되고 강한 타입의 코드를 쓰면서 조금 더 융통성을 갖고 싶을 때가 있을 수 있습니다. 제네릭 유형을 입력하십시오. 일반적인 함수의 고전적인 예는 인수를 가져와서 사용자에게 반환하는 ID 함수이다. TypeScript에서는 다음과 같이 표시됩니다.

```js
function identity<T>(target: T): T {
  return target;
}
```

여기서는 새로운 일반 유형(T)을 정의하고 컴퓨터와 사용자에게 함수가 `target` 인수가 무엇이든 간에 유형을 공유하는 값을 반환한다고 말합니다. 이렇게 하면 여전히 숫자나 문자열 또는 `HTMLEment`를 전달할 수 있으며 반환된 값도 동일한 유형임을 보장할 수 있다.

`@template` 주석을 사용하여 JSDoc 표기법을 사용할 경우에도 동일한 작업이 가능합니다.

```js
/**
 * @template T
 * @param {T} target
 * @return {T}
 */
function identity(target) {
  return x;
}
```

제네릭은 복잡한 주제이지만 예를 포함하여 JSdoc에서 제네릭을 활용하는 방법에 대한 자세한 설명서는 해당 항목의 Google Closure Compiler 페이지를 읽을 수 있습니다.

### 유형 주조

강력한 타이핑은 종종 매우 유용하지만, TypeScript의 기본 제공 기대치는 사용 사례에 적합하지 않을 수 있습니다. 그런 경우라면, 새로운 유형에 객체를 캐스팅해야 할 수도 있습니다. 이것이 필요할 수 있는 한 가지 예는 이벤트 수신기를 사용하는 경우입니다.

TypeScript에서 모든 이벤트 수신기는 콜백(callback) 기능을 수행하며, 여기서 첫 번째 인수는 `EventTarget` 유형인 `Event` 대상 개체입니다. 이것은 DOM 표준에 따른 올바른 유형이지만, 종종 이벤트의 대상에서 우리가 원하는 정보의 비트는 `HTMLinputElement.prototype`에 존재하는 값 속성과 같은 `EventTarget`에 존재하지 않는다. 이로 인해 다음 코드가 유효하지 않습니다.

```js
document.querySelector('input').addEventListener(event => {
  console.log(event.target.value);
};
```

TypeScript는 개발자로서 <input>이 `값`을 갖는다는 것을 잘 알고 있음에도 불구하고 `이벤트 타겟`에 속성 `값`이 존재하지 않는다고 불평할 것이다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/07/image-30.png?resize=1024%2C215&ssl=1)

TypeScript에 `event.target`이 `HTMLinputElement`가 될 것임을 알 수 있도록 개체의 유형을 캐스트해야 합니다.

```js
document.getElementById('input').addEventListener('input', event => {
  console.log(/** @type {HTMLInputElement} */(event.target).value);
});
```

event.target을 괄호로 묶으면 value에 대한 호출과 구별된다. 괄호 앞에 형식을 추가하면 TypeScript에 `event.target`이 일반적으로 예상하는 것과 다르다는 것을 알 수 있다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/07/image-31.png?resize=1024%2C101&ssl=1)

그리고 특정 객체가 문제가 있는 경우, 우리는 TypeScript에 개체가 오류 메시지를 무시하도록 `@type {any}라고 항상 말할 수 있지만, 이는 일반적으로 불량 관행 디파짓이 핀치에서 유용하다고 여겨진다.

### 마무리하기

TypeScript는 많은 개발자들이 일관된 코드 표준을 기반으로 워크플로우를 간소화하기 위해 사용하고 있는 믿을 수 없을 정도로 강력한 툴입니다. 대부분의 응용 프로그램이 내장 컴파일러를 활용하지만 일부 프로젝트에서는 TypeScript가 제공하는 추가 구문을 사용할 수 있다고 결정할 수 있습니다. 또는 확장된 구문에 얽매이지 않고 표준을 고수하는 것이 더 편할 수도 있습니다. 이 경우 개발자들은 바닐라 자바스크립트를 쓰는 동안에도 여전히 TypeScript의 타입 시스템을 활용하는 이점을 얻을 수 있다.