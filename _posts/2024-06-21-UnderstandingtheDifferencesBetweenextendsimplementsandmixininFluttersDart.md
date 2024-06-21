---
title: "플러터 다트에서 extends, implements, mixin의 차이점 완벽 이해하기"
description: ""
coverImage: "/assets/img/2024-06-21-UnderstandingtheDifferencesBetweenextendsimplementsandmixininFluttersDart_0.png"
date: 2024-06-21 23:00
ogImage: 
  url: /assets/img/2024-06-21-UnderstandingtheDifferencesBetweenextendsimplementsandmixininFluttersDart_0.png
tag: Tech
originalTitle: "Understanding the Differences Between “extends”, “implements”, and “mixin” in Flutter’s Dart"
link: "https://medium.com/@lakshithlfvithana/understanding-the-differences-between-extends-implements-and-mixin-in-flutters-dart-f4bb152dd464"
---


![image](/assets/img/2024-06-21-UnderstandingtheDifferencesBetweenextendsimplementsandmixininFluttersDart_0.png)

안녕하세요!

Flutter는 크로스 플랫폼 모바일 애플리케이션을 만들기 위한 강력한 프레임워크입니다. 기본적으로 Flutter는 Dart 프로그래밍 언어를 사용하며, 개발자가 깨끗하고 유지보수가 쉬운 코드를 작성하는 데 도움을 주는 여러 기능을 제공합니다. Dart의 한 가지 측면 중 초보자들에게 혼란스러울 수 있는 부분은 "extends", "implements" 및 "mixin"의 차이점입니다. 이 블로그 포스트에서는 이러한 개념을 쉽게 이해할 수 있도록 탐구할 것입니다. 이 글을 끝까지 읽으시면 Flutter 프로젝트에서 각 키워드를 언제 어떻게 사용해야 하는지 명확히 이해하게 될 것입니다.

- "extends" 이해하기.

<div class="content-ad"></div>

닷(Dart)에서는 "extends" 키워드를 사용하여 다른 클래스, 즉 수퍼클래스로부터 속성 및 동작을 상속하는 클래스를 만듭니다. 클래스가 다른 클래스를 확장하면 수퍼클래스에서 정의된 모든 변수, 메서드 및 생성자에 액세스할 수 있습니다. 이 개념을 상속이라고 합니다.

- 상속 계층 구조: 상속을 통해 클래스를 계층 구조로 구성할 수 있으며 맨 위에는 베이스 또는 부모 클래스가 있고 그 아래에 파생 또는 자식 클래스가 있습니다. 이 계층 구조를 통해 공통 속성과 동작을 공유할 수 있습니다.
- 구문 및 예제: Dart에서 "extends"를 사용하는 구문은 다음과 같습니다:

```js
class 자식클래스 extends 부모클래스 {
  // 자식클래스 멤버
}
```

- 다음은 "extends"의 사용법을 보여주는 예제입니다:

<div class="content-ad"></div>

```dart
// 슈퍼클래스 생성
class Animal {
  String name;

  Animal(this.name);

  void makeSound() {
    print("동물이 소리를 냅니다");
  }
}

// 'extends'를 사용하여 서브클래스 생성
class Dog extends Animal {
  String breed;

  Dog(String name, this.breed) : super(name);

  @override
  void makeSound() {
    print("개가 짖습니다");
  }
}

void main() {
  // 서브클래스의 인스턴스 생성
  var myDog = Dog("버디", "골든 리트리버");
  print(myDog.name); // 출력: Buddy
  print(myDog.breed); // 출력: Golden Retriever
  myDog.makeSound(); // 출력: The dog barks
}
```

2. "implements" 탐색.

"extends"는 클래스 상속에 사용되는 반면, "implements" 키워드는 Dart에서 인터페이스를 구현하는 데 사용됩니다. 인터페이스는 클래스가 해당 인터페이스의 메소드를 구현함으로써 준수해야 하는 계약을 정의합니다. 클래스가 인터페이스를 구현하면 인터페이스에서 지정된 필수 기능을 제공하기로 동의합니다.

- 인터페이스란 무엇인가? 인터페이스는 클래스가 준수해야 하는 메소드 세트를 정의하는 방법으로 생각할 수 있습니다. 인터페이스를 준수하는 클래스에서 예상되는 동작을 지정합니다.
- 인터페이스 구현: 인터페이스를 구현하려면 클래스가 인터페이스에서 선언된 모든 메소드를 정의해야 합니다. 이를 통해 클래스가 필요한 기능을 제공하도록 합니다.
- 아래 예제는 "implements" 사용법을 보여줍니다.

<div class="content-ad"></div>

```dart
// 인터페이스 생성하기
abstract class Flyable {
  void fly();
}

// 인터페이스 구현하기
class Bird implements Flyable {
  String name;

  Bird(this.name);

  @override
  void fly() {
    print("$name가 날고 있습니다");
  }
}

void main() {
  // 인터페이스를 구현하는 클래스의 인스턴스 생성
  var myBird = Bird("참새");
  myBird.fly(); // 출력: 참새가 날고 있습니다
}
```

- 이 예제에서 "Bird" 클래스는 "Flyable" 인터페이스를 구현하여 "fly" 메서드에 대한 구현을 제공합니다.
- 다중 인터페이스: Dart는 클래스가 여러 인터페이스를 구현할 수 있도록 허용하여 여러 계약을 준수할 수 있습니다. 이 유연성은 코드 재사용과 다양한 시나리오에서의 적응성을 가능하게 합니다.

3. "mixin"의 힘을 이해하기.

Dart는 상속 없이 여러 클래스 간에 코드를 재사용할 수 있게 하는 "mixin"이라는 개념을 소개합니다. Mixin은 다른 클래스에 적용할 수 있는 행동을 구성하여 코드 모듈성과 재사용성을 향상시킵니다.


<div class="content-ad"></div>

- 믹신이 뭡니까? 믹신은 클래스 계층 구조를 만들지 않고 여러 클래스 사이에서 코드를 재사용하는 방법을 제공합니다. 믹신은 관련이 없는 클래스 사이에서 공유할 수 있는 행동을 구성하는 것을 가능하게 합니다.

- 구성 vs. 상속: 상속은 클래스 간에 계층적인 관계를 만드는 데 유용하지만, 믹신은 코드 재사용에 더 유연하고 모듈식 접근 방식을 제공합니다. 믹신을 사용하면 클래스가 엄격한 클래스 계층 구조의 제약으로 인해 제한받지 않고 특정 행동을 채택할 수 있습니다.

- 믹신 선언: Dart에서 믹신을 선언하려면 믹신 이름 뒤에 "mixin" 키워드를 사용하면 됩니다. 다음은 예시입니다:

```js
mixin Swimmer {
  void swim() {
    print("The object is swimming");
  }
}
```

- 믹신 적용: 클래스에서 믹신을 사용하려면 믹신 이름 뒤에 "with" 키워드를 사용하면 됩니다. 다음은 예시입니다:

```js
class Dolphin with Swimmer {
  String name;

  Dolphin(this.name);
}
```

<div class="content-ad"></div>

- 이 예시에서는 "Dolphin" 클래스가 "Swimmer" 믹스인을 적용하여 "swim" 메서드를 얻습니다.
- 코드 예시: 실용적인 예시로 "Person" 클래스와 "Walker" 믹스인이 있는 경우를 고려해 봅시다:

```js
mixin Walker {
  void walk() {
    print("The person is walking");
  }
}

class Person with Walker {
  String name;

  Person(this.name);
}

void main() {
  var person = Person("John");
  person.walk(); // 출력: The person is walking
}
```

- 이 예시에서 "Person" 클래스는 "Walker" 믹스인을 적용하여 "walk" 메서드를 사용할 수 있게 됩니다.

결론

<div class="content-ad"></div>

Dart에서 'extends', 'implements', 그리고 'mixin'의 차이를 이해하는 것은 효율적이고 유지보수 가능한 Flutter 애플리케이션을 작성하는 데 중요합니다. 'extends'는 클래스 상속을 가능하게 하며, 'implements'는 인터페이스 계약을 준수하는 데 도움을 줍니다. 'mixin'은 복잡한 클래스 계층 구조를 만들지 않고도 코드 재사용을 촉진합니다. 이러한 개념을 이해함으로써 탄탄한 기반을 갖추어 견고한 Flutter 애플리케이션을 설계하고 Dart의 능력을 활용할 수 있을 것입니다.

계속해서 Flutter와 Dart의 세계를 탐험하는 동안, 이러한 개념을 마스터하는 데 있어서 연습이 중요하다는 것을 기억해 주세요. 직접 프로젝트에 적용해 보고 다양한 시나리오를 실험하여 깊은 이해를 얻어보세요.

더 많은 정보는 아래 링크에서 확인할 수 있습니다:

- Flutter Documentation: https://flutter.dev/docs
- Dart Language Tour: https://dart.dev/guides/language/language-tour