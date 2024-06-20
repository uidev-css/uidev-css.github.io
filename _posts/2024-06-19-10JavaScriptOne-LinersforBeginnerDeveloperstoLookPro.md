---
title: "10개의 JavaScript 원 라이너 - 초보 개발자들이 전문가 같이 보이는 방법"
description: ""
coverImage: "/assets/img/2024-06-19-10JavaScriptOne-LinersforBeginnerDeveloperstoLookPro_0.png"
date: 2024-06-19 08:20
ogImage: 
  url: /assets/img/2024-06-19-10JavaScriptOne-LinersforBeginnerDeveloperstoLookPro_0.png
tag: Tech
originalTitle: "10 JavaScript One-Liners for Beginner Developers to Look Pro"
link: "https://medium.com/@pinjarirehan/10-javascript-one-liners-for-beginner-developers-to-look-pro-b9548353330a"
---


이미지 태그를 수정하여 마크다운 형식으로 변환해보세요.


![image](/assets/img/2024-06-19-10JavaScriptOne-LinersforBeginnerDeveloperstoLookPro_0.png)

코딩을 하고 있는데 다른 사람이 들어와서 한 줄의 JavaScript로 문제를 해결할 때가 있나요? 마치 코딩 마술 같은 느낌이죠.

이것이 원라이너의 힘입니다. 이러한 짧은 코드 스니펫은 매우 효과적일 수 있으며, 자바스크립트 프로처럼 느끼게 할 수 있습니다.

하지만 코드의 모든 부분에 원라이너를 넣기 전에, 함께 알아보겠습니다.


<div class="content-ad"></div>

한 줄 코드는 기능을 한 줄로 압축하는 JavaScript 코드의 짧은 스니펫들이에요.

더 간결한 코드를 작성하는 데 도움이 되고 때로는 가독성을 향상시키기도 해요.

어떤 이점이 있을까요? 시간을 절약할 수 있고 깔끔한 코드를 만들 수 있으며 다른 개발자들에게 조금은 인상을 심어줄 수도 있어요.

지금은 당신에게 빠른 성과를 가져다줄 실용적이고 초보자 친화적인 한 줄 코드에 집중하고 있어요.

<div class="content-ad"></div>

당신의 JavaScript 도구 상자에 추가할 수 있는 좋은 옵션들이 있어요:

![image](https://miro.medium.com/v2/resize:fit:1400/1*auHv7HaK3_NOxX4hSUBDwQ.gif)

# 1. 배열 필터링

시험 점수 배열이 있고 A를 모두 찾아야 할 때 (이 경우 짝수), 한 줄로 쉽게 해결할 수 있어요!

<div class="content-ad"></div>

```js
const scores = [85, 92, 73, 98, 80];
const evenScores = scores.filter(num => num % 2 === 0);

// evenScores will be [92, 98, 80]
```

이 코드는 filter 메서드를 사용하여 테스트를 통과한 요소만 포함하는 새 배열을 생성합니다.

화살표 함수 `(num => num % 2 === 0)` 는 각 숫자가 짝수인지를 확인합니다.

사용 시기: 배열에서 원치 않는 요소를 제거하는 필터링은 흔한 작업입니다. 이 한 줄은 데이터를 정리할 때 유용합니다.

<div class="content-ad"></div>

# 2. 배열 매핑

만약 여러 변 길이가 담긴 배열이 있고, 각 정사각형의 넓이를 구하고 싶다면 이 한 줄 코드를 사용하여 배열의 각 원소를 해당 수의 제곱으로 변환할 수 있습니다:

```js
const sideLengths = [5, 3, 7];
const areas = sideLengths.map(num => num * num);

// areas will be [25, 9, 49]
```

map 메서드는 원본 배열의 모든 요소에 제공된 함수를 호출한 결과를 가지고 새로운 배열을 생성합니다.

<div class="content-ad"></div>

여기서 이 함수는 각 숫자를 제곱합니다.

사용 시기: 이 한 줄 코드는 배열의 각 요소에 대해 수학 연산을 수행하기에 유용합니다.

## 3. 배열 평탄화

가끔 중첩된 배열을 만날 수 있습니다. 예를 들어, 각 변형별 하위 항목이 있는 식료품 가게 제품 목록과 같은 경우입니다. 한 줄 코드를 사용하여 이러한 구조를 평탄화하는 데 도움을 줄 수 있습니다.

<div class="content-ad"></div>

```js
const nestedGroceries = [
  ["사과", ["빨간색", "초록색"]],
  ["우유", ["전체", "2%"]]
];
const flatGroceries = nestedGroceries.flat(); 

// flatGroceries는 ["사과", "빨간색", "초록색", "우유", "전체", "2%"]가 됩니다.
```

flat 메서드(ES6 이상에서 이용 가능)는 모든 하위 배열 요소를 연결하여 새 배열을 만듭니다.

이것은 데이터 조작 작업을 단순화할 수 있습니다.

사용 시기: 중첩된 배열을 평탄화하면 데이터를 한 차원으로 더 쉽게 다룰 수 있습니다.

<div class="content-ad"></div>

# 4. 중복 없이 고유한 요소 찾기

아마도 중복된 항목이 있는 손님 명단이 있을 수 있습니다.

한 줄 코드는 모두가 고유한 초대장을 받을 수 있도록 도와줍니다 (어색한 "어, 내가 두 개 받았어?" 상황을 피하기 위해).

```js
// 중복 항목이 포함된 원래 손님 명단
const guestList = ["Alice", "Bob", "Charlie", "Alice"];

// 배열을 Set으로 변환하고 다시 배열로 변환하여 중복 제거
const uniqueGuestList = [...new Set(guestList)];

// uniqueGuestList은 ["Alice", "Bob", "Charlie"]가 됩니다
console.log(uniqueGuestList);
```

<div class="content-ad"></div>

이 한 줄은 세트의 마법을 사용합니다. 세트는 고유한 값을 저장합니다.

우리는 원래 목록에서 고유한 손님들을 포함한 세트에서 요소들을 (...) 펼쳐서 새 배열로 넘깁니다.

사용 시기: 데이터 정리는 종종 배열에서 중복을 제거하는 것을 의미합니다. 이 한 줄은 데이터를 깔끔하고 정돈된 상태로 유지해줍니다.

# 5. 줄임 조건문

<div class="content-ad"></div>

한 줄로 된 if...else 문을 여러 줄에 걸쳐 작성한 적이 있나요? 그렇게 하지 않고도 더 간결한 방법이 있어요:

```js
// 사용자의 나이 정의
const age = 18;

// 사용자의 나이에 따라 메시지 결정
const message = age >= 18 ? "환영합니다!" : "죄송합니다, 아직은 미성년자입니다.";

// 메시지 출력
console.log(message);
```

위 코드는 삼항 연산자를 활용해 한 줄로 짧은 if-else 문을 작성한 것이에요.

조건 (age `= 18)을 확인하고, 해당 값 ("환영합니다!" 또는 "죄송합니다, 아직은 미성년자입니다.")을 message 변수에 할당해요.

<div class="content-ad"></div>

언제 사용하나요: Shorthand 조건문은 상황에 따라 간단한 할당을 수행할 때 효율적이고 코드를 깔끔하게 유지할 수 있어요.

## 6. 문자열 뒤집기

한 줄로 문자열을 역순으로 만들 수도 있어요! 회문인지 확인해보려면 어떨까요 (거꾸로 읽어도 같은 단어, 예를 들어 "racecar" 같은 단어) ?

```js
const str = "Hello, world!";
const reversedStr = str.split('').reverse().join('');

// reversedStr 결과는 "!dlrow ,olleH"가 됩니다.
```

<div class="content-ad"></div>

이 한 줄 코드는 문자열을 문자 배열로 나누어 순서를 뒤집은 다음 새 문자열로 다시 결합합니다!

사용 시기: 문자열 조작 작업 중에 일회성 코드로 문자열을 뒤집거나 부분 문자열을 추출하는 작업을 간단히 처리할 수 있습니다.

## 7. 객체 속성 존재 여부

사용자 프로필 시스템을 만들고 특정 속성(예: "이메일")이 사용자 객체에 있는지 확인해야 한다고 상상해보세요. 이 한 줄 코드가 도움이 될 수 있습니다:

<div class="content-ad"></div>

```js
const user = { name: "Alice", age: 30 };

// 사용자 객체에 'email' 속성이 있는지 확인합니다.
const hasEmail = "email" in user;

// 'email' 속성이 사용자 객체에 없으므로 hasEmail은 false가 됩니다.
```

in 연산자는 객체 내에 속성이 존재하는지 확인합니다. 여기서는 사용자 객체에 "email" 속성이 있는지 확인합니다.

사용 시기: 객체 내에서 지정된 속성의 존재 여부에 따라 데이터를 유효성 검사하는 것은 일상적인 상황입니다. 이 1줄짜리 코드는 간단한 해결책을 제공합니다.

# 8. 기본 매개변수 값


<div class="content-ad"></div>

얼마나 이름이 제공되지 않았을 때 백업 값을 사용하여 사용자에게 인사하는 작업을 생성하는 것은 어떨까요? 원 라이너는 이것을 처리할 수 있어요:

```js
const greet = (name = "손님") => `안녕하세요, ${name}!`;
console.log(greet());

// 출력: 안녕하세요, 손님!

console.log(greet("밥"));
// 출력: 안녕하세요, 밥!
```

이 원 라이너는 ES6 기본 매개변수를 사용합니다. 여기서 greet 함수를 호출할 때 이름이 제공되지 않으면 "손님"의 기본 값이 사용됩니다.

언제 사용할까요: 기본 매개변수는 함수가 적절한 인수 없이 호출될 때 오류를 피하며 코드를 더 견고하게 만듭니다.

<div class="content-ad"></div>

# 9. Compact Arrays

가끔 비어있는 값이나 null 요소를 포함한 배열을 만날 수 있습니다. 한 줄의 코드로 이러한 불필요한 요소를 제거하는 데 도움이 될 수 있어요:

```js
const numbers = [1, 0, null, 3]; // 원본 배열
const compactNumbers = numbers.filter(Boolean); // Boolean을 콜백 함수로 사용한 filter 메서드

// compactNumbers은 Boolean(1)이 true, Boolean(0)이 false, Boolean(null)이 false, 그리고 Boolean(3)이 true이기 때문에 [1, 3]이 될 거에요
```

이 한 줄의 코드는 filter 메서드를 다시 활용합니다. 다만, 이번에는 Boolean 생성자를 사용하여 "falsy" 값 (null, undefined, 0, "", NaN 등)을 확인하는 것이 특징이에요.

<div class="content-ad"></div>

False로 평가되는 요소는 새 배열에서 제외됩니다.

언제 사용하면 좋을까요: 불필요한 요소를 제거하여 배열을 정리하면 중요한 데이터만 다루고 있음을 보장할 수 있습니다.

# 10. 동적 객체 키

한 줄로 작성된 코드로 심지어 작업 이후에 결정되는 키를 가진 객체를 만들 수도 있습니다. 놀랐나요?

<div class="content-ad"></div>

```js
const prop = "score";
const person = { [prop]: 90 };

// person will be {score: 90}
```

이 한 줄은 계산된 속성 이름을 사용합니다. prop 변수의 값은 객체를 생성할 때 중괄호 내부에서 키 이름으로 사용됩니다.

이를 통해 변수나 표현식을 기반으로 한 동적 키 생성이 가능해집니다.

사용 시기: 동적 객체 키는 구조가 미리 설정되지 않은 것을 만드는 데 유용합니다.

<div class="content-ad"></div>

# 마지막으로

자바스크립트 코드를 개선하기 위해 멋진 원 라이너를 몇 가지 배웠으면 좋겣습니다.

원 라이너는 강력한 도구이지만 코드의 명확성과 유지 보수성을 보장하기 위해 신중하게 사용해야 합니다.

JavaScript 개념을 더 깊이 파고들고 새로운 코딩 모험에 나서게 될 향후 포스트를 기대해 주세요!

<div class="content-ad"></div>


![image 1](/assets/img/2024-06-19-10JavaScriptOne-LinersforBeginnerDeveloperstoLookPro_1.png)

![image 2](/assets/img/2024-06-19-10JavaScriptOne-LinersforBeginnerDeveloperstoLookPro_2.png)
