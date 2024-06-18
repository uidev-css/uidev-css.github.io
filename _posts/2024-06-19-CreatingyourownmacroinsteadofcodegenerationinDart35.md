---
title: "Dart 35에서 코드 생성 대신 매크로를 직접 만들어 봅시다"
description: ""
coverImage: "/assets/img/2024-06-19-CreatingyourownmacroinsteadofcodegenerationinDart35_0.png"
date: 2024-06-19 08:10
ogImage: 
  url: /assets/img/2024-06-19-CreatingyourownmacroinsteadofcodegenerationinDart35_0.png
tag: Tech
originalTitle: "Creating your own macro instead of code generation in Dart 3.5"
link: "https://medium.com/@alexey.inkin/creating-your-own-macro-instead-of-code-generation-in-dart-3-5-27274f8a5bf6"
---


Dart 3.5에는 주요한 새로운 기능인 매크로가 추가되었습니다. 이는 컴파일 시간에 메모리 내에서 완전히 발생하는 코드 생성으로 임시 파일이 필요하지 않습니다. 하지만 그 이상의 기능을 제공합니다.

현재 이는 베타 상태이고, Dart 팀은 불안정한 동안 너무 많은 내용을 공유하지 않도록 주의하고 있습니다. 그들의 공개 로드맵은 다음과 같습니다:

- 현재 @JsonCodable 매크로 하나만 있어서 json_serializable 패키지를 대체하고 그 부담을 크게 줄입니다. 이를 통해 이 기능에 익숙해질 수 있습니다.
- 이 단일 매크로는 2024년 어느 때에는 안정화될 것입니다.
- 자체 매크로를 작성하는 것은 2025년 초에 가능해질 것입니다.

하지만 지금 자체 매크로를 만들어보려고 하면 어떻게 될까요? 그들의 말투로 보면 활성화된 매크로의 화이트리스트와 같은 장애물이 있을 것 같았지만, 전혀 그렇지 않았습니다!

<div class="content-ad"></div>

자, 이제 나만의 매크로를 만들고 게시할 수 있다. 기다릴 필요 없어, 2025년까지 기다릴 필요 없어. 실험에는 제약이 없지만, 뭔가가 고장 날 수 있으니 운영에 사용하면 안 돼.

그러니 지금 몇 개의 나만의 매크로를 만들어봐! 다트 팀의 "hello-world" 매크로를 복제하고, 우리만의 "hello-world" 매크로를 작성하며, 커맨드 라인 인자 파서를 만들기 위한 내 매크로로 깊이 들어가보자.

# 실험 설정

<div class="content-ad"></div>

## 다트 3.5

Dart 3.5 베타 버전으로 전환하려면 공식 안내를 참고하세요: [https://dart.dev/language/macros#set-up-the-experiment](https://dart.dev/language/macros#set-up-the-experiment)

저는 방금 ZIP 파일을 다운로드하여 별도의 경로에 압축 해제했어요.

## VSCode

<div class="content-ad"></div>

최근 안정 버전의 Dart 플러그인을 사용하셔야 합니다. 이를 통해 매크로로 생성된 코드를 확인할 수 있습니다.

## pubspec.yaml

예제 매크로를 사용하려면 적어도 Dart 3.5.0-154 버전 이상이 필요합니다. 아래와 같이 pubspec.yaml 파일을 생성해주세요:

```yaml
name: macro_client
environment:
  sdk: ^3.5.0-154

dependencies:
  json: ^0.20.2
```

<div class="content-ad"></div>

## analysis_options.yaml

코드를 작성하는 도중에 만약 이 기능을 실험 중이라고 말하지 않는다면, 분석 도구가 경고를 표시할 것입니다. 아래의 analysis_options.yaml 파일을 생성해 주세요:

```yaml
analyzer:
  enable-experiment:
    - macros
```

## 코드 작성하기

<div class="content-ad"></div>

다트 팀이 제공하는 예제를 사용해보세요:

```dart
import 'package:json/json.dart';

@JsonCodable() // 매크로 주석.
class User {
  final int? age;
  final String name;
  final String username;
}

void main() {
  // 임의의 JSON이 주어진 경우:
  final userJson = {
    'age': 5,
    'name': 'Roger',
    'username': 'roger1337',
  };

  // 생성된 멤버 사용:
  final user = User.fromJson(userJson);
  print(user);
  print(user.toJson());
}
```

터미널에서 실험적 플래그와 함께 실행해보세요:

```bash
dart run --enable-experiment=macros lib/main.dart
```

<div class="content-ad"></div>

시도해보세요. settings.json에서 Markdown 형식의 표 태그를 수정할 수 있습니다:

![image1](/assets/img/2024-06-19-CreatingyourownmacroinsteadofcodegenerationinDart35_0.png)

다음과 같이 수정해보세요:

![image2](/assets/img/2024-06-19-CreatingyourownmacroinsteadofcodegenerationinDart35_1.png)

<div class="content-ad"></div>

요렇게 변경하면 작동하고 다음 내용이 출력됩니다:

```js
'User'의 인스턴스
{age: 5, name: Roger, username: roger1337}
```

클래스는 단 6줄뿐입니다:

```js
@JsonCodable()
class User {
  final int? age;
  final String name;
  final String username;
}
```

<div class="content-ad"></div>

동일한 클래스를 json_serializable로 나타내면 16줄이 됩니다:

```js
@JsonSerializable()
class User {
  const Commit({
    required this.age,
    required this.name,
    required this.username,
  });

  final int? age;
  final String name;
  final String username;

  factory User.fromJson(Map<String, dynamic> map) => _$UserFromJson(map);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
```

## 생성된 코드 보기

VSCode에서 @JsonCodable 매크로를 사용하면 "Augmentation으로 이동" 링크가 표시됩니다. 클릭하면 생성된 코드가 표시됩니다:

<div class="content-ad"></div>

<img src="/assets/img/2024-06-19-CreatingyourownmacroinsteadofcodegenerationinDart35_2.png" />

지난 코드 생성과는 달리, 이번 버전은 실제 파일이 아닌 메모리에 있어요. 편집할 수 없어요. 원본 main.dart에서 무언가를 변경하면 생성된 코드가 업데이트되어 별도로 생성기를 실행할 필요가 없어요.

만약 VSCode를 사용할 수 없다면, 동일한 코드를 보는 데 사용할 수 있는 내 도구를 확인해보세요.

## 작동 방식: augmentation

<div class="content-ad"></div>

여기 무슨 일이 벌어지고 있는 거죠? 이 코드는 augmentation이라는 새로운 Dart 기능을 사용하고 있어요. 이 기능은 원본 블록 외부에서 멤버를 추가하거나 본체를 교체함으로써 클래스나 함수를 변경하는 능력을 말해요.

이 기능은 매크로와 독립적이며, 가장 간단한 사용 방법은 다음과 같아요:

```js
class Cat {
  final String name; // "Uninitialized" error unless we have a constructor.
}

augment class Cat {
  Cat(this.name); //    Resolves the error.
}
```

이 augmentation은 원본 클래스와 별도의 파일에 있을 수 있어요. 매크로가 실제로 하는 것은 이와 같은 augmentation이 있는 파일을 생성하는 것이에요. 예전 코드 생성과의 실제 실용적인 차이는 이제 이것이 메모리에 있고 .g.dart 물리적인 파일에 있지 않다는 점이에요.

<div class="content-ad"></div>

만약 Dart 팀이 json_serializable 패키지를 augmentation을 사용하도록 업그레이드한다면, 당신의 코드는 생성자가 생성될 수 있기 때문에 매크로로 생성된 것과 같이 짧을 수 있고, toJson과 fromJson을 위한 보일러플레이트 포워더가 필요하지 않을 수도 있습니다.

늘 무시받았던 진짜 강력한 기능, augmentation을 찬양해 보세요. 매크로는 컴파일러에서 구현하기 훨씬 어렵지만 여기서는 보조적입니다.

# 나만의 hello-world 매크로 만들기

이 코드를 가진 hello.dart 파일로 hello-world 매크로를 만듭니다:

<div class="content-ad"></div>

```dart
import 'dart:async';

import 'package:macros/macros.dart';

final _dartCore = Uri.parse('dart:core');

macro class Hello implements ClassDeclarationsMacro {
  const Hello();

  @override
  Future<void> buildDeclarationsForClass(
    ClassDeclaration clazz,
    MemberDeclarationBuilder builder,
  ) async {
    final fields = await builder.fieldsOf(clazz);
    final fieldsString = fields.map((f) => f.identifier.name).join(', ');

    final print = await builder.resolveIdentifier(_dartCore, 'print');

    builder.declareInType(
      DeclarationCode.fromParts([
        'void hello() {',
        print,
        '("Hello! I am ${clazz.identifier.name}. I have $fieldsString.");}',
      ]),
    );
  }
}
```

이 매크로는 적용한 클래스에 hello라는 메서드를 만듭니다. 이 메서드는 클래스 이름과 갖고 있는 필드의 이름을 출력합니다.

이 매크로는 macro 수정자를 가진 클래스로 구현되었습니다. ClassDeclarationsMacro를 구현합니다. 이것은 컴파일러에게 해당 매크로가 클래스에 적용될 수 있고 선언을 업데이트할 시간이 되었을 때 실행될 수 있다고 알려줍니다. 매크로가 다양한 코드 엔티티에 적용되어 코드 생성의 다양한 단계에서 실행될 수 있도록 할 수 있는 많은 인터페이스가 있습니다. 제가 명령줄 인수 구문 분석 매크로에 도달하면 해당 내용에 대해 이야기하겠습니다.

이 인터페이스에는 구현해야 하는 buildDeclarationsForClass라는 메서드가 있으며 적절한 시점에 호출됩니다. 이 메서드에 전달되는 매개변수는: ```

<div class="content-ad"></div>

- 적용된 클래스에 대한 정보에 액세스하기 위한 클래스 선언입니다.
- 주어진 클래스를 조사하고 코드를 추가하는 메서드가 있는 빌더 객체입니다.

우리는 빌더를 사용하여 클래스의 필드를 가져옵니다.

실제 코드 생성은 쉽습니다. 빌더에는 증가시키는 클래스에 코드를 추가하기 위한 declareInType 메서드가 있습니다. 가장 간단한 코드는 문자열일 수 있지만 문자열로 print 함수를 호출할 수는 없는 것이 어려운 부분입니다.

이전에 본 JsonCodable 매크로에서의 예시 확장을 살펴보면 dart:core가 접두사와 함께 가져온 것을 발견할 수 있습니다:

<div class="content-ad"></div>

```dart
import 'dart:core' as prefix0;
```

이것은 자동으로 수행되어, 코드가 print와 같은 핵심적인 내용과 충돌하지 않도록합니다. 접두사는 동적이며 미리 알 수 없으므로 생성된 코드에서 단순히 print(something)을 작성할 수 없습니다. 이것이 우리가 식별자 print를 핵심 라이브러리에서 해결하고 나서 일부로부터 생성된 코드를 빌드하는 이유입니다:

```dart
final print = await builder.resolveIdentifier(_dartCore, 'print');

builder.declareInType(
  DeclarationCode.fromParts([
    'void hello() {',
    print,
    '("Hello! I am ${clazz.identifier.name}. I have $fieldsString.");}',
  ]),
);
```

일부는 마지막에 함께 붙이는 문자열과 식별자 참조의 조합일 수 있습니다. 이 과정에서 모든 식별자는 필요한 접두사와 함께 앞에 붙입니다.
```

<div class="content-ad"></div>

```kotlin
import 'hello.dart';

@Hello()
class User {
  const User({
    required this.age,
    required this.name,
    required this.username,
  });

  final int? age;
  final String name;
  final String username;
}

fun main() {
  val user = User(age = 5, name = 'Roger', username = 'roger1337')
  user.hello()
}
```  
["Augmentation" 페이지로 이동](/assets/img/2024-06-19-CreatingyourownmacroinsteadofcodegenerationinDart35_3.png)

<div class="content-ad"></div>

테이블 태그를 Markdown 형식으로 변경해주세요.

<div class="content-ad"></div>

```js
안녕! 저는 사용자입니다. 제 나이, 이름, 사용자명이 있어요.
```

# 진짜 유용한 매크로

더 배우기 위해 따라할 수 있는 두 가지 실제 세계 매크로가 있습니다:

## JsonCodable
```  

<div class="content-ad"></div>

다트 팀이 우리에게 학습하기 위해 출시한 패키지 마크로입니다. 코드를 꼼꼼히 읽는 것을 강력히 추천합니다. 거의 모든 것을 배운 곳이기도 해요.

## Args

이것은 내가 만든 패키지 마크로입니다.

터미널에서 실행되는 앱을 만드는 경우, 명령행 인수와 그들의 구문 분석에 익숙할 것입니다. 보통은 이를 위해 표준 args 패키지를 사용합니다.

<div class="content-ad"></div>

```js
import 'package:args/args.dart';

void main(List<String> argv) {
  final parser = ArgParser();
  parser.addOption('name');
  final results = parser.parse(argv);
  print('Hello, ' + results.option('name'));
}
```

다음과 같이 실행할 수 있습니다.

```js
dart run main.dart --name=Alexey
```

그리고 확인할 수 있습니다.

<div class="content-ad"></div>

```js
안녕, Alexey
```

문제는 많은 명령줄 옵션이 있는 경우 복잡해진다는 것이죠. 옵션들을 잊어버릴 수 있고, 옵션이 존재하고 특정 타입인지에 대한 컴파일 타임 보장이 없습니다. 옵션의 이름을 쉽게 변경할 수 없으며, 이 코드는 문자열 리터럴로 옵션의 이름을 다루기 때문에 어렵습니다.

그래서 저의 Args 매크로는 원하는 옵션들을 정의한 데이터 클래스로부터 파서를 생성하며, 옵션을 읽을 때 컴파일 타임 유형 안전성을 제공합니다:

```js
import 'package:args_macro/args_macro.dart';

@Args()
class HelloArgs {
  String name;
  int count = 1;
}

void main(List<String> argv) {
  final parser = HelloArgsParser(); // 생성된 클래스.
  final HelloArgs args = parser.parse(argv);

  for (int n = 0; n < args.count; n++)
    print('안녕, ${args.name}!');
}
```

<div class="content-ad"></div>

이 기능에 대해 자세히 알아보겠습니다. 이 기사의 두 번째 부분에서 제작과정을 소개하겠습니다. 기사가 공개되면 읽어보세요!

- 내 텔레그램 채널: ainkin_com
- 트위터: https://x.com/AlexeyInkin
- 링크드인: https://www.linkedin.com/in/alexey-inkin/