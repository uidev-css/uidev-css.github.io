---
title: "Dart에서 Extension Types으로 할 수 있는 것들"
description: ""
coverImage: "/assets/img/2024-06-22-WhatcanIdowithExtensionTypesinDart_0.png"
date: 2024-06-22 00:40
ogImage: 
  url: /assets/img/2024-06-22-WhatcanIdowithExtensionTypesinDart_0.png
tag: Tech
originalTitle: "What can I do with “Extension Types” in Dart?"
link: "https://medium.com/flutter-community/what-can-i-do-with-extension-types-in-dart-5dfa73e4b009"
---


Dart 3.3 확장 타입

![Image](/assets/img/2024-06-22-WhatcanIdowithExtensionTypesinDart_0.png)

공식 문서는 다음과 같이 시작합니다:

확장 타입은 강력한 타입 래퍼로 작용하는 컴파일 시간 추상화입니다. 성능 최적화를 위해 도입되었으며 네이티브 코드와의 향상된 상호작용을 제공합니다. Zero-cost 래퍼로서, 다른 언어와 통신할 때 Wrapper 클래스와 Helper 클래스와 관련된 전형적인 메모리 비용을 제거합니다.

<div class="content-ad"></div>

일반 클래스 래퍼는 런타임에서 작동하며 항상 클래스 및 객체 사용량의 오버헤드가 발생하여 메모리 사용량과 GC(Garbage Collection) 비용이 증가합니다. 단기간에 많은 래퍼 인스턴스가 생성되는 시나리오에서는 이 부담이 상당해집니다.

확장 유형은 특정 유형의 확장으로 컴파일 시간에 확인되므로 런타임에서는 원래 표현 유형으로 되돌아가며 추상화가 사라집니다. 따라서 확장 유형을 사용하면 응용 프로그램에 비용이 발생하지 않아 매우 효율적인 개발 방법이 됩니다.
확장 유형은 정적 JavaScript 상호 운용을 가능하게 하며, 기존 JavaScript 유형과의 원활한 상호 작용을 허용합니다.

# 혜택

<div class="content-ad"></div>

## 유연한 제한과 확장

기존 유형(예: int 또는 String)을 속성, 함수 및 다른 API를 추가하여 향상시킬 수 있습니다.

## 더 명확한 추상화

기본 표현 유형의 복잡성을 숨겨 의미 있는 확장을 가능하게 하여 코드 가독성과 유지 관리성을 향상시킵니다.

<div class="content-ad"></div>

## 편리하고 안전한 상호 운용성

Dart 사용자 정의 유형은 기본 유형에 액세스하는 것만큼 간단하여 유형 안전성을 제공합니다. 이는 네이티브 플랫폼 및 다른 언어와의 상호 운용성에 특히 유용하며, 프로세스를 간소화합니다.

## 향상된 성능

각 서비스마다 Wrapper 클래스를 생성하지 않아 추가 메모리 오버헤드가 발생하지 않습니다. 특히 대량 데이터 집합이나 빈번한 객체 작업을 처리할 때 성능에 민감한 시나리오에 이상적입니다.

<div class="content-ad"></div>

# 개발

확장 형식은 선언될 때 기본 생성자가 자동으로 포함됩니다.

```js
extension type MyId(int id) {}

void main(List<String> arguments) {
  final id = MyId(1);
  
  print(id); // 1 
  print(id.runtimeType); // int
}
```

어떤 경우에도 확장 형식에 의해 래핑된 형식은 "표현 형식"으로 불리며 서브타입이 아닙니다. 따라서 일반적으로 표현 형식과 사용자 정의 확장 형식은 서로 값 할당이 불가능합니다.

<div class="content-ad"></div>

사용자 정의된 새로운 속성과 함수 인터페이스가 없을 때에는 기능적인 작업이 없습니다. int의 원래 동작이 제한됩니다.

![extension types in Dart](/assets/img/2024-06-22-WhatcanIdowithExtensionTypesinDart_1.png)

기존 유형에 대해서는 더 많은 확장이나 유형의 제약 사항에 대해 노출되는 것이 아닌 사용 가능한 API만 노출되며, 그렇게 함으로써 일부 허용되지 않는 작업을 피할 수 있습니다. 우리가 필요로 하는 의미 있는 함수를 추가할 수 있습니다.

```dart
extension type MyId(int id) {
  operator >(MyId other) => id > other.id;
  
  bool isBiggerThan(MyId other) => id > other.id;
}

void main(List<String> arguments) {
  MyId safeId = MyId(200);
  safeId + 10; // Compile error: No '+' operator.
  safeId - 10; // Compile error: No '-' operator.
  safeId > 10; // Compile error: Wrong type.
  safeId > MyId(300); // ✅

  int number = 100;
  number = safeId; // Compile error: Wrong type.
  number = safeId as int; // ✅ Cast to representation type.
  safeId = number as MyId; // ✅ Cast to extension type.

  print(safeId.isBiggerThan(MyId(300))); // false
}
```

<div class="content-ad"></div>

서비스나 네이티브 API와 상호 작용 후 반환된 값은 int를 사용하여 가독성을 높일 수 있어요. 확장 유형을 통해 특정 이름을 지정할 수 있어요. 이렇게 하면 한눈에 이해하기 쉬워져요.

확장 유형과 표현 유형은 as 캐스팅을 사용하여 직접 변환할 수 있어요. 재미있는 점은 상속 관계가 아님에도 불구하고 강제로 변환할 수도 있어요.

```js
i = id as int; // ✅
i = -1;
id = i as Id;  // ✅
```

다트 클래스처럼 확장 유형을 일반적으로 처리하고 인스턴스화하고 사용자 정의 함수를 호출할 수 있는 예제가 있어요. 다트는 이를 일반 int로 컴파일해요.

<div class="content-ad"></div>

```dart
extension type Wrapper(int i) {
  void showValue() {
    print('my value is $i');
  }
}

void main() {
  final wrapper = Wrapper(42);
  wrapper.showValue(); // Prints 'my value is 42'
}
```

공식 설명에 따르면 익스텐션 타입은 네이티브 코드와의 상호 운용성을 위해 유용하며, 간접 비용을 발생시키지 않고 네이티브 타입을 직접 사용할 수 있으면서도 깔끔한 Dart API를 제공합니다.

# 제네릭

익스텐션 타입과 제네릭을 함께 사용하기:


<div class="content-ad"></div>

```dart
extension type MyList<T>(List<T> elements) {
 void add(T value) => elements.add(value);
}

void main(List<String> arguments) {
  MyList list = MyList<int>([1, 2]);
  list.add(3);

  final normalList = list as List<int>;
  print(list); // [1, 2, 3]
  print(normalList); // [1, 2, 3]
}
```

# 생성자

Extension 타입은 여러 개의 생성자를 가질 수 있습니다:

- 일반 생성자
- 명명된 생성자
- private 생성자 문법을 사용한 숨겨진 생성자


<div class="content-ad"></div>

```dart
extension type Password._(String value) {
  Password(this.value) {
    assert(value.length >= 8);
    
    if (value.length < 8) {
      throw Exception('Password must be at least 8 characters long');
    }
  }

  Password.random() : value = _generateRandomPassword();

  static String _generateRandomPassword() => ...;

  bool get isValid => value.length >= 8;
}

void main(List<String> arguments) {
  // 암시적 명명되지 않은 생성자.
  Password password = Password('abcdefghijklmnopqrstuvwxyz'); // ✅

  // 명명된 생성자.
  password = Password.random(); // ✅
  password = Password('hello12'); // Exception: Password must be at least 8 characters long
  password = 'hello' as Password; // ✅
}
```

기억하세요, 암시적 주 생성자에서는 assert() 체크나 다른 작업을 사용할 수 없습니다. 기본 생성자를 재정의하고 assert 체크를 추가하세요. 기본 생성자를 내부적으로(private) 만드세요.
```dart
extension type Password._(String value) {

  Password(this.value) {
    assert(value.length >= 8);
    
    if (value.length < 8) {
      throw Exception('Password must be at least 8 characters long');
    }
  }
  
}
```

# 안전한 Alias


<div class="content-ad"></div>

implements를 사용하면 Extension Types가 기본 유형을 노출하여 Representation 타입의 모든 멤버 및 사용자 지정 도우미 API에 액세스할 수 있습니다. 이는 원래 유형의 기능을 제공하면서도 별칭 및 타입 안전성 확인을 제공합니다.

```js
extension type Height(double _) implements double {}
extension type Weight(double _) implements double {}

double calculateBmi(Height height, Weight weight) => weight / ( height * height);

void main() {
  var height = Height(1.75);
  var weight = Weight(65);
  var bmi = calculateBmi(height, weight);
  print(bmi); // 21.22448979591837
  
  bmi = calculateBmi(1.64, 54.0);     // ❌ 컴파일 타임 오류
  bmi = calculateBmi(weight, height); // ❌ 컴파일 타임 오류
}
```

기존 타입에 새로운 인터페이스 추가하기:

```js
extension type MyId(int id) implements int {
  MyId get value => this;
}

void main(List<String> arguments) {
  final safeId = MyId(100);
  safeId + 1; // 101
  safeId - 1; // 99
  safeId * 2; // 200
  safeId / 2; // 50
  safeId % 3; // 1
  safeId.toString(); // '100'

  int normalId = safeId; // 100
  final safeId2 = safeId + normalId; // 200
  final safeId3 = 10 + safeId; // 110
}
```

<div class="content-ad"></div>

기존의 기능적 동작을 재정의하고 확장 타입의 멤버들은 완전히 부모 타입의 동일한 이름을 가진 멤버들을 대체하여 새 구현 방법을 제공합니다.

```js
확장 타입 MyId(int id)은 int를 구현합니다 {
  bool get isEven => true;
}

void main(List<String> arguments) {
  final myId = MyId(101);
  print(myId.isEven); // true
}
```

# 다른 시나리오

## 다중 타입 확장

<div class="content-ad"></div>

보통, 확장 유형은 하나의 유형을 확장합니다. 여러 정보가 있는 경우 Record를 사용할 수 있습니다.

```js
typedef UserInfo = ({String email, String password});

extension type User(UserInfo info) {
  void printInfo() => print("Email: ${info.email}, Password: ${info.password}");
}

void main(List<String> arguments) {
  final user = User(
    (
      email: 'extension@gmail.com',
      password: 'types',
    ),
  );
  user.printInfo(); // Email: extension@gmail.com, Password: types
}
```

## 테스트용 모의 데이터

테스트에서 Extension Types를 사용하는 것도 가능합니다. Mock 클래스에 따르면 코드를 약간 조정하기만 하면 됩니다. 일반 클래스와의 차이점은 인터페이스를 구현하지 않은 경우 일반 클래스는 컴파일 경고를 표시하지만, Extension Types는 표시하지 않는다.

<div class="content-ad"></div>


## JSON 접근

JSON 데이터에 대한 Extension Types 활용.

```js
final userMap = json.decode(r'''
  {
    "name": {
      "first": "Yii",
      "last": "Chen"
    },
    "email": "ab20803@gmail.com"
  }
'''); // Map<String, dynamic>

extension type User(Map<String, dynamic> _) {
  Name get name => _['name'] as Name;
  String get email => _['email'] as String;
}
extension type Name(Map<String, dynamic> _) {
  String get first => _['first'] as String;
  String get last => _['last'] as String;
}
void main() {
  final person = User(userMap);
  print(person.name.first);   // Yii
  print(person.name.last);    // Chen
  print(person.email);        // ab20803@gmail.com
  print(person.email.length); // 17
}
```


<div class="content-ad"></div>

# 상호 운용성

현재 Extension Types은 주로 dart: js_interop 패키지에서 사용되며, 익숙한 구문을 사용하여 JavaScript API에 액세스하고 상호 작용할 수 있도록 합니다. 이 패키지는 JSObject 및 JSAny와 같은 많은 JS 관련 유형을 정의하여 Dart와 네이티브 플랫폼 간의 안전한 통신을 보장합니다. C++와 같은 다른 언어도 이 접근 방식에서 혜택을 볼 수 있습니다.

![image](/assets/img/2024-06-22-WhatcanIdowithExtensionTypesinDart_2.png)

external → 이 키워드는 일반적으로 다른 언어에서 사용하는 외부 함수에 액세스할 수 있도록 합니다. 따라서 Dart 상호 운용성 개발에서 자주 볼 수 있습니다.

<div class="content-ad"></div>

@JS() → 만약 Dart 측에서 다른 이름을 구현하거나 동일한 JavaScript API를 가리키는 여러 Dart API를 작성하려는 경우, 상호 운용성을 위해 JS API의 이름을 정의할 수 있습니다.

## 패키지 예시

flutter_soloud는 C++을 기반으로 개발된 오디오 엔진 및 패키지로, 낮은 지연 시간, 고성능 플레이어를 제공합니다. 소스 코드에서 재생 기능을 실행하고자 할 때, player.cpp의 play 함수로 시작하여 최종적으로 Dart 측에서는 소리 작업의 ID를 얻기 위해 soloud.play()를 실행합니다.

사용자 정의 SoundHandle은 가독성과 성능을 보장하기 위해 ID를 래핑합니다.

<div class="content-ad"></div>

```dart
final soloud = SoLoud.instance;
await soloud.init();
final source = await soloud.loadAsset('path/to/asset.mp3');

SoundHandle soundHandle = await soloud.play(source); // id(int)

await soloud.stop(soundHandle);
await soloud.disposeSource(soundHandle);
```

전체 API 작업 프로세스를 간단히 살펴보겠습니다:

- player.cpp의 play()를 사용하여 오디오 핸들을 얻습니다.

![Extension Types in Dart](/assets/img/2024-06-22-WhatcanIdowithExtensionTypesinDart_3.png)


<div class="content-ad"></div>

2. 양쪽 간의 통신을 처리하기 위해 bindings_player_ffi.dart를 사용하여 얻은 핸들 ID를 SoundHandle으로 래핑합니다.

![image](/assets/img/2024-06-22-WhatcanIdowithExtensionTypesinDart_4.png)

3. Flutter 쪽에서는 soloud.dart를 사용하여 play()를 호출한 후 Record 유형의 결과를 반환합니다. 해당 newHandle을 추출하여 필요한 ID인 ID를 얻을 수 있습니다.

![image](/assets/img/2024-06-22-WhatcanIdowithExtensionTypesinDart_5.png)

<div class="content-ad"></div>

4. Dart 쪽에서는 음향 컨트롤 작업을 위해 의미 있는 확장 유형인 SoundHandle을 사용하여 id가 랩핑됩니다.

![이미지](/assets/img/2024-06-22-WhatcanIdowithExtensionTypesinDart_6.png)

# 고급 사용법

팩토리 생성자: 다른 유형의 확장이 Representation 유형에 적용될 수 있습니다. 이를 통해 연산을 여러 확장 유형에 재사용할 수 있습니다 (다중 상속과 유사).

<div class="content-ad"></div>

```js
extension type Number(int i) {
  const factory Number.zero() = Number2;
}

extension type Number2(int i) implements Number { 
  const Number2(int value) : this(i: value);
}
```

# 기억해주세요

확장 유형(Extension Type)은 컴파일 시간에 래핑 동작입니다. 런타임에는 존재하지 않습니다. 런타임에서는 어떤 유형의 쿼리나 작업이라도 표현 유형(Representation Type)에 적용됩니다. 이로 인해 확장 유형은 안전하지 않은 추상화이며 원래 표현 유형을 항상 찾을 수 있고 런타임에서 기본 객체에 액세스할 수 있습니다.

```js
extension type Id(int value) {}

void idToInt() {
  var id = Id(1);

  // 'id'의 런타임 유형은 표현 유형 'int'.
  if (id is int) print(id.value); // 1

  // 런타임에서 'id'에 'int' 메서드 사용 가능.
  if (id case int x) print(x.toString()); // 1
  switch (id) {
    case int(:final isEven):
      print("$id (${isEven ? "짝수" : "홀수"})"); // 1 (홀수)
  }
}

void intToId() {
  int i = 2;

  if (i is Id) print("예"); // 예

  if (i case Id id) print("값: ${id.value}"); // 값: 2

  switch (i) {
    case Id(:var value):
      print("값: $value"); // 값: 2
  }
}
```

<div class="content-ad"></div>

# 요약

- **확장 유형**은 기존 유형을 제한할 수도 있고, 새로운 기능을 제공할 수도 있습니다.
- **확장 유형**의 본질을 이해하는 것이 중요합니다. 이들은 컴파일 시에만 존재하며 런타임에서는 무시되며 **표현 유형**으로 표시됩니다.
- **확장 유형**은 특정 상황에서 비용을 절약하고, 특히 상호 운용성 개발에서 성능을 크게 향상시킬 수 있습니다.

# 확장 유형 비교

- **확장 메서드**: 기존 유형에 간단한 기능을 추가하는 데 적합합니다.
- **확장 유형**: 기존 유형을 향상시키고, 복잡한 기능을 구현하며, 다른 프로그래밍 언어와의 상호 운용성을 최적화하는 데 적합합니다.

<div class="content-ad"></div>

# 참고

- [Dart 언어 확장 유형](https://dart.dev/language/extension-types)
- [Dart 상호 운용성 및 JS 상호 운용 사용법](https://dart.dev/interop/js-interop/usage)
- [Dart 3.3 소개](https://medium.com/dartlang/dart-3-3-325bf2bf6c13)
- [Dart와 Flutter 확장 유형에 대한 소개](https://ildysilva.medium.com/what-are-flutter-and-dart-extension-types-896eda0a3ddf)
- [Dart 언어에 대한 유용한 기능과 팁](https://qiita.com/Cat_sushi/items/987e7eee469793369ef8)
- [Flutter와 Dart의 개요](https://qiita.com/Cat_sushi/items/87742dc3a886dd984f46)
- [imaNNeO 유튜브 채널](https://www.youtube.com/watch?v=YHsi1Gfz5UU&ab_channel=imaNNeO)
- [FlutterUruguay 유튜브 채널](https://www.youtube.com/watch?v=SyFNB81p-OY&t=3276s&ab_channel=FlutterUruguay)
- [Prof.DiegoAntunes 유튜브 채널](https://www.youtube.com/watch?v=2TJIOpBDMnU&ab_channel=Prof.DiegoAntunes)

# 다른 글들

- 2024년 4월 'Flutter Monthly' 😍
- 2024년 3월 'Flutter Monthly' 😍
- 2024년 2월 'Flutter Monthly' 😍
- Flutter 3.19 및 Dart 3.3 업데이트 포인트!
- 2024년 1월 'Flutter Monthly' 😍
- 개발 기술 향상을 위한 Dart 3 사용하기. 더 많은 예제와 팁.
- 2023년 12월 'Flutter Monthly' 😍
- 2023년 11월 'Flutter Monthly' 😍
- Dart 3를 숙지해서 삶을 쉽게 만들기!
- Flutter 3.16 및 Dart 3.2 요약!
- 2023년 10월 'Flutter Monthly' 😍
- 2023년 9월 'Flutter Monthly' 😍
- 2023년 8월 'Flutter Monthly' 😍
- 2023년 7월 'Flutter Monthly' 😍