---
title: "웹 개발자가 알아야 할 5가지 JavaScript 기능"
description: ""
coverImage: "/assets/img/2024-06-19-5JavaScriptFeaturesEveryWebDeveloperShouldKnow_0.png"
date: 2024-06-19 08:31
ogImage: 
  url: /assets/img/2024-06-19-5JavaScriptFeaturesEveryWebDeveloperShouldKnow_0.png
tag: Tech
originalTitle: "5 JavaScript Features Every Web Developer Should Know"
link: "https://medium.com/gitconnected/5-javascript-features-every-web-developer-should-know-2118f26d7e89"
---


<img src="/assets/img/2024-06-19-5JavaScriptFeaturesEveryWebDeveloperShouldKnow_0.png" />

안녕하세요! 이 글에서는 모든 웹 개발자가 알아야 할 5가지 JavaScript 기능을 소개해 드리겠습니다.

## 1. Default Parameters

Default parameters(기본 매개변수)는 함수 매개변수의 기본 값을 설정할 수 있는 간단하지만 유용한 기능입니다.

<div class="content-ad"></div>

가끔 함수가 매개변수를 받는지 확실하게 알 수 없을 때가 있습니다. 따라서 대체 값을 설정하면 예기치 못한 오류를 방지하는 데 도움이 됩니다.

```js
function greet(name = '손님') {
    console.log(`안녕하세요, ${name}님!`);
}

greet(); // 출력: 안녕하세요, 손님!
greet('Alice'); // 출력: 안녕하세요, Alice님!
```

기본 매개변수를 사용하여 일반적인 버그를 피하고 함수를 보다 견고하고 가독성 좋게 만들 수 있습니다.

## 2. 구조 분해 할당

<div class="content-ad"></div>

구조 분해 할당을 사용하면 배열에서 값이나 객체의 속성에서 값을 추출하여 별도의 변수로 할당할 수 있습니다. 이를 통해 코드를 더 깔끔하고 간결하게 만들 수 있습니다.

구조 분해는 배열과 객체 모두에서 사용할 수 있습니다:

배열:

```js
const [first, second, third] = [1, 2, 3];
console.log(first, second, third); // 결과: 1 2 3
```

<div class="content-ad"></div>

오브젝트:

```js
const person = { name: 'Alice', age: 30 };
const { name, age } = person;
console.log(name, age); // 결과: Alice 30
```

## 3. 펼침 연산자

펼침 연산자 ...은 배열이나 오브젝트의 요소를 확장할 수 있게 해줍니다. 이는 배열과 오브젝트를 결합하거나 복사하거나 조작하는 등 다양한 목적으로 활용될 수 있는 도구입니다.

<div class="content-ad"></div>

배열 결합:

```js
const arr1 = [1, 2, 3];
const arr2 = [4, 5, 6];
const combined = [...arr1, ...arr2];
console.log(combined); // 출력: [1, 2, 3, 4, 5, 6]
```

객체 복사:

```js
const original = { name: 'Alice', age: 30 };
const copy = { ...original, city: 'Wonderland' };
console.log(copy); // 출력: { name: 'Alice', age: 30, city: 'Wonderland' }
```

<div class="content-ad"></div>

펼침 연산자를 사용하면 무제한 개수의 인수를 가지는 함수를 만들 수도 있어요. 함수가 받을 인수의 개수를 모를 때 유용할 수 있어요.

```js
function funcWithUnlimitedArguments(...args) {
    for (let arg of args) {
        console.log(arg);
    }
}

funcWithUnlimitedArguments(1,2,3,4,5,6,7);
```

## 4. 템플릿 리터럴

템플릿 리터럴은 ES6에 도입된 기능으로, 문자열을 만드는 더 간단한 방법을 제공해요.

<div class="content-ad"></div>

템플릿 리터럴을 만들려면 따옴표 대신 역 따옴표 ``를 사용하세요. 역 따옴표 안에 일반적인 문자열을 정의할 수 있을 뿐만 아니라 코드를 내장할 수도 있습니다.

```js
const name = 'Alice';
const age = 30;
const message = `Hello, my name is ${name} and I am ${age} years old.`;

console.log(message);
// 출력: Hello, my name is Alice and I am 30 years old.
```

템플릿 리터럴을 사용하면 HTML 예시처럼 다음과 같이 간단하게 여러 줄의 문자열을 만들 수도 있습니다.

```js
// 템플릿 리터럴을 사용하여 동적 HTML 콘텐츠 작성
const person = {
    name: 'Alice',
    age: 30,
    city: 'Wonderland'
};

const markup = `
    <div class="person">
        <h2>${person.name}</h2>
        <p>Age: ${person.age}</p>
        <p>Location: ${person.city}</p>
    </div>
`;

document.body.innerHTML = markup;
```

<div class="content-ad"></div>

## 5. Async / Await

async 및 await은 ES8에서 소개된 키워드로, 비동기 JavaScript 코드를 처리하는 더 읽기 쉽고 직관적인 방법을 제공합니다.

Async는 비동기 함수를 선언하는 데 사용됩니다. 비동기 함수는 항상 프로미스를 반환하며 일반적인 동기식 코드 실행 흐름 외부에서 실행됩니다.

Async 함수 내부에서는 Promise가 해결되기를 기다리며 async 함수의 실행을 일시 중지하는 await 표현식을 사용할 수 있습니다. 해결되면 async 함수를 다시 시작하고 해결된 값을 반환합니다.

<div class="content-ad"></div>

```js
// 비동기 함수 예시
async function fetchData() {
    try {
        const response = await fetch('https://api.example.com/data');
        const data = await response.json();
        return data;
    } catch (error) {
        console.error('데이터를 불러오는 중 오류 발생:', error);
        throw error;
    }
}
```

## 결론

이러한 기능을 알면 JavaScript 코드를 개선하고 더 읽기 쉽게 만들 수 있습니다.

읽어 주셔서 감사합니다! 즐거운 하루 되세요!
