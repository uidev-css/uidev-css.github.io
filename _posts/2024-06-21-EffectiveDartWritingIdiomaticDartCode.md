---
title: "효과적인 Dart 2024년 최신 다트 관용구 작성하기"
description: ""
coverImage: "/assets/img/2024-06-21-EffectiveDartWritingIdiomaticDartCode_0.png"
date: 2024-06-21 20:32
ogImage: 
  url: /assets/img/2024-06-21-EffectiveDartWritingIdiomaticDartCode_0.png
tag: Tech
originalTitle: "Effective Dart: Writing Idiomatic Dart Code"
link: "https://medium.com/@gautam007/effective-dart-writing-idiomatic-dart-code-5a062ce3e62f"
---


# 깨끗하고 효율적이며 관용적인 다트 코드 작성하는 방법

유지보수가 간편하고 성능이 우수한 애플리케이션을 만들기 위해 깨끗하고 효율적이며 관용적인 다트 코드를 작성하는 것은 중요합니다. 다트는 플러터 애플리케이션 등을 만드는 데 사용되는 다재다능한 언어로, 올바르게 활용하면 코드 품질을 크게 향상시킬 수 있습니다. 이 안내서는 가장 좋은 관행, 고급 언어 기능 및 피해야 할 일반적인 함정을 다루어 관용적인 다트 코드를 작성하는 데 도움이 됩니다.

![이미지](/assets/img/2024-06-21-EffectiveDartWritingIdiomaticDartCode_0.png)

# 1. 널 안전성 활용하기

<div class="content-ad"></div>

# 널 안전성이란 무엇인가요?

널 안전성이란 Dart의 특성으로, 모든 유형을 기본적으로 null이 아닌 값으로 만들어 널 오류를 피하도록 도와줍니다. 변수를 명시적으로 nullable하게 표시해야 합니다. ? 구문을 사용합니다.

# 예시

```js
String? name;
name = 'Dart';
```

<div class="content-ad"></div>

# 2. Final 및 Const 사용 선호

# Final 및 Const를 사용해야 하는 경우

- Final: 한 번 초기화된 후에 변경되지 않는 변수에 대해 final을 사용합니다.
- Const: 컴파일 시간 상수에 대해 const를 사용합니다.

# 예제

<div class="content-ad"></div>

```kotlin
val greeting: String = "Hello"
const val pi: Double = 3.14159
```

# 3. Collection if 및 Spread 연산자 사용하기

# 리스트 생성 향상

Dart의 collection if와 spread 연산자(`...`와 `...?`)를 사용하면 더 유연하고 가독성이 좋은 리스트 생성이 가능합니다.

<div class="content-ad"></div>

# 예제

```js
var isLoggedIn = true;
var items = [
  '홈',
  isLoggedIn ? '프로필' : '',
  '설정',
];

var extraItems = ['도움말', '로그아웃'];
var allItems = [
  '홈',
  ...extraItems,
  '설정',
];
```

# 4. 확장에 대해 긍정적으로 생각하세요

# 기능 확장

<div class="content-ad"></div>

Dart의 확장은 소스 코드를 수정하지 않고 기존 라이브러리와 클래스에 기능을 추가할 수 있도록 해줍니다.

# 예시

```js
extension StringExtension on String {
  String get reversed {
    return split('').reversed.join('');
  }
}

void main() {
  print('hello'.reversed); // prints 'olleh'
}
```

# 5. 믹스인의 힘을 활용하세요

<div class="content-ad"></div>

# 코드 재사용

믹스인은 클래스의 코드를 여러 클래스 계층 구조에서 재사용하는 방법으로, 여러 원본에서 메서드와 속성을 섞어 사용할 수 있도록합니다.

# 예시

```js
mixin Fly {
  void fly() => print('날기');
}

mixin Swim {
  void swim() => print('수영');
}

class Duck with Fly, Swim {}

void main() {
  var duck = Duck();
  duck.fly();
  duck.swim();
}
```

<div class="content-ad"></div>

# 6. 함수 유형에 대한 Typedef 활용

# 함수 시그니처 간단히하기

Typedef를 사용하면 함수 시그니처를 간단히할 수 있고 코드 가독성을 향상시킬 수 있습니다.

# 예제

<div class="content-ad"></div>

```dart
typedef IntBinaryOperation = int Function(int, int);

int add(int a, int b) => a + b;
int subtract(int a, int b) => a - b;

void main() {
  IntBinaryOperation operation;

  operation = add;
  print(operation(3, 4)); // 7 출력

  operation = subtract;
  print(operation(3, 4)); // -1 출력
}
```

# 7. 효과적인 Dart 가이드라인을 따르세요

# 코드 일관성

Google의 효과적인 Dart 가이드라인은 일관성 있는 Dart 코드를 작성하기 위한 포괄적인 권장 사항을 제공합니다. 이 가이드라인은 네이밍 규칙부터 문서화와 디자인 원칙까지 모든 것을 다룹니다.

<div class="content-ad"></div>

# 예시

- 네이밍: 변수, 매개변수 및 함수 이름에는 카멜케이스를 사용하십시오. 클래스 이름에는 UpperCamelCase를 사용하십시오.
- 문서화: 공개 API에 대한 명확하고 간결한 문서를 제공하기 위해 ///를 사용하십시오.

```js
/// 이 함수는 두 숫자를 더합니다.
int add(int a, int b) => a + b;
```

# 8. 오류를 공손하게 처리하기

<div class="content-ad"></div>

# 예외 처리 사용하기

Dart는 예외를 사용하여 견고한 오류 처리 메커니즘을 제공합니다. 항상 예외를 잡고 정상적으로 처리하세요.

# 예시

```js
try {
  var result = riskyOperation();
  print(result);
} catch (e) {
  print('오류가 발생했습니다: $e');
}

int riskyOperation() {
  throw Exception('문제가 발생했습니다');
}
```

<div class="content-ad"></div>

# 9. async 및 await을 사용하여 성능 최적화

# 비동기 프로그래밍

Dart의 async 및 await 키워드는 비동기 프로그래밍을 간단하고 코드를 더 읽기 쉽고 유지보수하기 쉽게 만듭니다.

# 예시

<div class="content-ad"></div>

```dart
Future<void> fetchData() async {
  var data = await fetchDataFromServer();
  print(data);
}

Future<String> fetchDataFromServer() async {
  // 네트워크 지연을 시뮬레이션합니다.
  await Future.delayed(Duration(seconds: 2));
  return '데이터 가져오기 완료';
}
```

# 10. 흔한 함정 피하기

# 흔한 문제점

- 사용되지 않는 Imports: 코드를 깨끗하게 유지하기 위해 사용되지 않는 imports를 제거합니다.
- Dynamic 남용: 타입 체크를 우회하고 런타임 오류를 유발할 수 있기 때문에, 꼭 필요한 경우를 제외하고 dynamic 사용을 피하세요.

<div class="content-ad"></div>

# 예시

```dart
// 이렇게 피하세요
dynamic foo = 'bar';

// 이렇게 선호하세요
String foo = 'bar';
```

# 결론

다트 언어의 강력한 기능을 활용하고 최상의 관행을 준수하며 흔히 하는 실수를 피함으로써 관용적인 다트 코드를 작성할 수 있습니다. 널 안전성, final 및 const, 확장(extensions), mixin, 그리고 기타 고급 언어 기능을 활용하여 깔끔하고 효율적이며 유지보수가 용이한 다트 코드를 작성할 수 있습니다. 이러한 지침을 따르고 지속적으로 코딩 관행을 개선하여 더 효과적인 다트 개발자가 되세요. 즐거운 코딩하세요!