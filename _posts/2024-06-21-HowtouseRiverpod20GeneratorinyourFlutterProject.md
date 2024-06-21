---
title: "Flutter 프로젝트에서 Riverpod 20  Generator 사용법"
description: ""
coverImage: "/assets/img/2024-06-21-HowtouseRiverpod20GeneratorinyourFlutterProject_0.png"
date: 2024-06-21 20:19
ogImage: 
  url: /assets/img/2024-06-21-HowtouseRiverpod20GeneratorinyourFlutterProject_0.png
tag: Tech
originalTitle: "How to use Riverpod 2.0 + Generator in your Flutter Project"
link: "https://medium.com/@31carlton7/how-to-use-riverpod-2-0-generator-in-your-flutter-project-4f7f5faba4b2"
---


<img src="/assets/img/2024-06-21-HowtouseRiverpod20GeneratorinyourFlutterProject_0.png" />

Riverpod은 플러터(Flutter)에서 상태 관리 및 반응형 데이터 캐싱의 새로운 표준입니다. 두 번째 버전인 Riverpod 2.0은 꽤 오랫동안 출시되었지만, 새로운 데이터 관리 방법과 컨셉을 이해하기 어려울 수 있습니다.

# 우리가 배울 내용

- Riverpod 2.0의 새로운 프로바이더로 기존 프로바이더를 업데이트하는 방법.
- 앱 내에서 상태를 새로운 방식으로 관리하는 방법.
- Riverpod 2.0에서 퓨처(futures)를 다루는 방법.
- 프로바이더를 자동으로 생성하고 프로바이더 생성 프로세스를 간소화하는 방법.

<div class="content-ad"></div>

시작하기 전에, Riverpod가 무엇을 할 수 있는지 알아보아야 합니다. Riverpod는 상태를 관리하기 위해 providers라는 것을 사용하며, 다음은 2.0 이전에 존재했던 providers입니다. 다양한 유형의 providers를 빠르게 살펴보겠습니다:

- Provider: 이 provider는 값을 생성합니다. 반응적 상태나 메모리가 없기 때문에 대부분의 경우에 최적이 아니지만, 많은 정적 메소드를 가진 클래스나 접근하려는 종속성이 있는 경우 유용합니다.
- ChangeNotifierProvider, StateNotifierProvider, StateProvider: 이들은 앱 내부에서 로컬 상태를 생성, 액세스 및 캐싱하는 데 도움을 줍니다. 모두 반응적인 변경을 지원합니다.
- FutureProvider, StreamProvider: 이들은 앱 내에서 비동기 데이터를 캐싱하고 액세스하는 데 도움을 줍니다.

Riverpod 2.0에서는 이러한 모든 providers를 대체하는 2개의 providers가 있습니다... 하나만 제외하고요.

- NotifierProvider: 이는 변경 알림/동기 변경에 사용되며, ChangeNotifierProvider, StateNotifierProvider, StateProvider를 대체합니다.
- AsyncNotifier: 이는 비동기 변경에 사용되며, FutureProvider를 대체합니다. 2024년 6월 19일 현재, StreamProvider를 대체할 대안이 없습니다.

<div class="content-ad"></div>

이전에 언급한 대로, 생성기를 사용하여 우리의 프로바이더를 만들기도 할 겁니다. 생성기는 새로운 프로바이더 구문을 지원합니다 (StreamProviders를 제외하고). 또한 AutoDisposeProviders를 지원합니다. @riverpod 어노테이션을 사용하여 생성기에게 다음 함수를 프로바이더로 만들라고 알립니다.

새로운 프로바이더에 대해 익숙해졌으니, 생성기를 사용하여 어떻게 앱에서 사용할 지 살펴봅시다.

# 시작하기

가장 중요한 것은 앱에 Riverpod 2.0 패키지를 설치하는 것입니다. pubspec.yaml 파일에 다음 줄을 추가하세요.

<div class="content-ad"></div>

```yaml
# pubspec.yaml

dependencies:
  flutter_riverpod: ^2.1.3
  riverpod_annotation: ^1.1.1
dev_dependencies:
  build_runner:
  riverpod_generator: ^1.1.1
```

# HelloWorld Provider 생성

이제 가장 기본적인 provider 스타일을 만들고 사용하는 방법을 보여주는 다음 코드 조각을 살펴봅시다.

```dart
// main.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
// 생성기는 provider가 포함된 파일을 생성합니다. 전형적으로 "<filename>.g.dart" 구문을 따르도록 합니다.
// 또한 import 문 이후에 코드를 작성하는 것이 좋습니다.
part 'main.g.dart';

// 단순히 메서드를 생성하고 "@riverpod"로 주석을 달아 provider를 만듭니다.
// "HelloWorldRef" 객체를 생성하는 방법에 유의하세요.
// 이 객체는 아직 존재하지 않지만 "dart run build_runner watch" 명령을 실행하면 생성됩니다.
@riverpod
String helloWorld(HelloWorldRef ref) {
  return 'Hello world';
}

// provider를 사용하기 위해서는 동기식 provider를 사용하는 방식과 동일한 방식으로 사용합니다.
void main() {
  runApp(
    // 앱의 모든 provider 상태는 ProviderScope 내에 저장됩니다.
    // provider를 읽기 위해서는 이를 반드시 포함해야 합니다.
    ProviderScope(
      child: MyApp(),
    ),
  );
}

// Riverpod는 Stateless와 Stateful 위젯과 유사한 ConsumerWidget 및 ConsumerStatefulWidget 클래스 액세스를 제공합니다.
class MyApp extends ConsumerWidget {
  // ConsumerWidget의 build 메서드가 WidgetRef 객체를 가져오는 방식에 유의하세요.
  // WidgetRef는 provider를 읽는 데 사용됩니다.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // provider를 읽는 두 가지 방법이 있습니다.
    // 값을 읽고 변경 사항을 감시하려면 ref.watch(...)를 사용하고,
    // 함수를 호출하려면 ref.read(...)를 사용합니다.
    final String val = ref.watch(helloWorldProvider);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Hello World Example')),
        body: Center(
          child: Text(val),
        ),
      ),
    );
  }
}
```

<div class="content-ad"></div>

- 제너레이터는 프로바이더가 포함된 파일을 생성합니다. 일반적으로 이 구문을 따르도록 하려면 `filename`.g.dart 형식을 따르길 원합니다. 그리고 import 문 이후에 이를 유지하는 것이 좋습니다. 이 부분은 파일이 서로 관련되어 있음을 Dart에게 알려주는 부분입니다.
- 프로바이더를 만들기 위해서는 단순히 메서드를 만들고 이를 “@riverpod”으로 주석 처리하여 우리의 프로바이더를 생성합니다. "HelloWorldRef" 객체를 만든 방법에 주목해보세요. 아직 존재하지는 않지만 우리가 터미널에서 dart run build_runner watch 명령을 실행하면 생성될 것입니다. 따라서 해당 명령을 실행하고 `filename`.g.dart라는 파일을 생성하고 생성 중 발생한 오류를 해결하세요. 해당 파일은 다음과 같습니다:

```js
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';
// **************************************************************************
// RiverpodGenerator
// **************************************************************************
// ignore_for_file: avoid_private_typedef_functions, non_constant_identifier_names, subtype_of_sealed_class, invalid_use_of_internal_member, unused_element, constant_identifier_names, unnecessary_raw_strings, library_private_types_in_public_api
/// Dart SDK에서 복사함
class _SystemHash {
  _SystemHash._();
  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }
  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}
String $helloWorldHash() => r'8bbe6cff2b7b1f4e1f7be3d1820da793259f7bfc';
/// [helloWorld]도 참고하세요.
final helloWorldProvider = AutoDisposeProvider<String>(
  helloWorld,
  name: r'helloWorldProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : $helloWorldHash,
);
typedef HelloWorldRef = AutoDisposeProviderRef<String>;
```

- 생성된 프로바이더가 AutoDisposeProvider인 것을 주목하세요. 이는 상태가 없는 데이터와 유사하기 때문입니다.
- 파일을 저장한 후, dart run build_runner watch가 실행 중인 한 모든 생성된 프로바이더가 다시 생성됩니다.

# 위젯 트리 어디서든 프로바이더에 접근하기

<div class="content-ad"></div>

이제 당신은 앱 내에서 제공 업체의 데이터를 어디서든 읽을 수 있는지 궁금해 할 수도 있습니다. 이를 제공 업체 소비하기라고하며, 이를 위해 ref.watch(…) 메서드를 호출하는 WidgetRef 개체를 사용해야합니다. 위젯의 특정 부분만 제공 업체에 액세스해야하는 경우 Consumer 클래스를 사용할 수 있습니다.

다음은 Consumer 클래스를 사용한 예시입니다.

```dart
// main.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main.g.dart';

@riverpod
String helloWorld(HelloWorldRef ref) {
  return 'Hello world';
}

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Hello World Example')),
        body: Center(
          child: Consumer(
            builder: (context, ref, child) {
              final String val = ref.watch(helloWorldProvider);
              // Consumer has a return type of Widget.
              // Almost like using a Builder widget, but Riverpodified :)
              return Text(val);
            },
        ),
      ),
    );
  }
}
```

# 변수에 반응형 상태 추가하기

<div class="content-ad"></div>

더 복잡한 제공자 예제를 살펴봅시다. 클래스를 사용하는 것과 같은 예제입니다. 이는 체크박스 부울 값이나 요소 목록과 같은 반응성 상태가 필요한 변수가 있는 경우 유용할 수 있습니다.

다음 예제에서는 클래스를 사용하여 변수의 저장소로 사용하고 제공자로 변환하는 방법을 보여줍니다.

```js
@riverpod
class HelloWorld extends _$HelloWorld {
  String build() {
    return "hello world";
  }

  void toCamelCase() {
      // 변수 상태를 사용하여 제공자의 현재 상태에 액세스하는 방법에 주목해주세요.
      state = '${state[0].toUpperCase()}${state.substring(1).toLowerCase()}';
  }
}

ref.watch(helloWorldProvider); // hello world
ref.watch(helloWorldProvider.notifier).toCamelCase();
ref.watch(helloWorldProvider); // Hello World
```

이 예제에서는 우리의 클래스가 _$`클래스명`을 확장하고 제공자로 변환되어야 한다는 것을 riverpod에게 알려주기 위해 위에 riverpod 주석이 달렸습니다. 참고: 클래스로 만든 모든 제공자는 build() 메서드가 필요합니다. 이곳이 제공자의 초기 상태를 구성하는 곳입니다.

<div class="content-ad"></div>

제공자를 사용하는 것은 이전에 언급한 예제들만큼 간단합니다: 단순히 ref.watch(`생성된 제공자 이름`)을 호출하면 앱이 변경 사항을 감시합니다. 그리고 클래스의 접근자 메서드를 사용하려면 ref.watch(`생성된 제공자 이름`.notifier).`메서드 이름`()을 호출해야 합니다. .notifier를 꼭 포함하도록 하세요.

# 제공자의 현재 값 변경하기

이제 제공자 내의 현재 값을 변경하려면 클래스 내에 생성자를 사용하고 약간 수정해야 합니다. 즐겨 사용하는 단어 목록을 살펴보겠습니다.

```js
@riverpod
class FavoriteWordsRepository extends _$FavoriteWordsRepository {
  FavoriteWordsRepository(List<String> favoriteWords) {
    words = favoriteWords;
  }

  List<String> words = [];

  @override
  List<String> build() {
    return words;
  }
}
```

<div class="content-ad"></div>

main.g.dart 파일에서 FavoriteWordsRepository.new를 사용할 수 없다는 오류가 발생할 수 있습니다. 이 간단한 수정으로 해결할 수 있습니다:

```js
final favoriteWordsRepositoryProvider =
    AutoDisposeAsyncNotifierProvider<FavoriteWordsRepository, List<String>>(
  () => FavoriteWordsRepository([]), // FavoriteWordsRepository.new --> () => FavoriteWordsRepository([])
```

이것을 값으로 리스트를 초기화하는 것과 혼동하지 마세요. 이것은 단순히 시작점일 뿐이고 실제로 초기화된 리스트는 List`String` words = []; 입니다.

그리고 위젯 코드 내에서 provider의 상태를 다음과 같이 업데이트할 수 있습니다:

<div class="content-ad"></div>

```js
ref.watch(favoriteWordsRepositoryProvider.notifier).words = ['Cars', 'Dogs', 'Flutter'];
```

# 비동기 공급자 생성

지역 공급자 데이터 작업에 익숙해지면 futures를 다루는 방법도 알아봅시다! 아래 예시는 기본적인 future 공급자를 만드는 방법을 보여줍니다.

```js
@riverpod
Future<String> helloWorldFuture(HelloWorldFutureRef ref) async {
  try {
    await Future.delayed(const Duration(seconds: 3));
    return 'Hello World';
  } catch (e) {
    // 이 함수는 오류를 발생시킬 수 없습니다.
    // futures에 대한 Try/Catch 블록은 좋은 실천법입니다 :)
    rethrow;
  }
}
```

<div class="content-ad"></div>

우리의 함수는 다시 HelloWorldFutureRef를 가져와야 합니다. 이것은 단일 공급자에서 여러 제공자를 사용하는 데에 사용됩니다. 다음은 dio: ^4.0.6을 사용하여 예제 API에 HTTP 요청을하는 예제입니다:

```dart
// dio_provider.dart

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'dio_provider.g.dart';

@riverpod
Dio dio(DioRef ref, {Map<String, dynamic>? headers, String? subDomain}) {
  return Dio(BaseOptions(baseUrl: 'https://api.example.com', headers: headers));
}
```

그리고 우리의 공급자에서 액세스하는 방법은 다음과 같습니다:

```dart
// greeting_service.dart

import 'dio_provider.dart';
@riverpod
Future<String> getGreeting(GetGreetingRef ref, {required String name}) async {
  try {
    final response = await ref.watch(dioProvider()).get('/greeting');
    final result = response.data;
    final greeting = result + ', ' + name;
    return greeting; // Hello there, Carlton
  } catch (e) {
    rethrow;
  }
}
```

<div class="content-ad"></div>

다른 공급자를 사용해 공급자를 `.family`로 만들어요.

# build 메서드에 인수 전달하기

Riverpod은 초기화할 때 build 메서드로 인수를 전달할 수 있게 해줘요. 이를 코드에서 어떻게 할 수 있는지 알아볼게요.

```js
@riverpod
class MyRepository extends _$MyRepository {
  @override
  // 여기에 위치 인수를 추가하세요. 이름 지정도 가능해요.
  Future<String> build(String id, {bool value}) async {
    final String result = await myFuture(id, value);
    return anotherFutureThatReturnsAString(result);
  }
  // ...
}
```

<div class="content-ad"></div>

# AsyncProvider를 사용하는 방법

AsyncProvider를 사용하는 방법은 로컬 공급자를 사용하는 방법과 다르며 데이터와 상호 작용하는 방식이 변경됩니다. 주의 깊게 살펴보세요, 이것은 매우 중요합니다!

UI에서 공급자를 사용하려면 .when() 구문을 사용해야 합니다. 이 구문에는 3가지 다른 상태가 포함되어 있습니다: 데이터(완료), 로딩, 오류. ConnectionState를 확인하고 해당 위젯을 반환하는 것의 번거로움을 제거하기 때문에 FutureBuilders를 이것으로 교체할 수 있습니다. 아래는 완전한 앱의 예시를 살펴봅시다:

초기 앱 만들기

<div class="content-ad"></div>

```dart
// main.dart

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
      child: MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}
```

Creating foo class and provider

```dart
// foo.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'foo.g.dart';

class Foo {
  final int bar;
  int? baz;

  Foo(
    this.bar, {
    this.baz,
  });
}

@riverpod
class FooController extends _$FooController {
  FooController(this.foo);
  Foo foo;

  @override
  FutureOr<Foo> build() async {
    foo = await getFoo();
    return foo;
  }

  Future<Foo> getFoo() async {
    await Future.delayed(const Duration(seconds: 1));
    return Foo(1);
  }
}
```

Consuming foo provider
```dart
```

<div class="content-ad"></div>

```dart
// home.dart

class MyHomePage extends StatelessWidget {
  const MyHomePage({key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer(
        builder: (context, ref, _) {
          // Provider를 얻어와서 watch합니다
          final fooAsync = ref.watch(fooControllerProvider);
          // .when을 사용하여 Future로부터 UI를 렌더링합니다
          return fooAsync.when(
            data: (foo) => Text('bar: ${foo.bar}, baz: ${foo.baz}'),
            loading: () => const CircularProgressIndicator(),
            error: (err, stack) => Text(err.toString()),
          );
        },
      ),
    );
  }
}
```

이 예시에서는 Consumer 위젯을 사용하여 ref에 액세스하므로 ref.watch(fooControllerProvider)를 호출하여 AsyncData 유형을 반환할 수 있습니다. 그런 다음 .when(…) 함수가 제공하는 속성을 사용하여 UI를 매우 깨끗하고 관리하기 쉬운 형식으로 구성할 수 있습니다.

이 작업은 생성된 파일에서 provider의 초기값을 설정해야 합니다.

```dart
final fooControllerProvider = AutoDisposeAsyncNotifierProvider<FooController, Foo>(
  () => FooController(Foo(1)), // FooController.new --> FooController(Foo(1))
  name: r'fooControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : $FooControllerHash,
);
```

<div class="content-ad"></div>

# AsyncProvider의 현재 상태를 개체/가공 가능한 데이터처럼 가져오는 방법

현재 방법은 API 데이터에 빠르게 액세스하는 데 유용하지만 문제가 발생합니다. 미래 Provider 내부의 데이터를 어떻게 가공 가능한 데이터처럼 액세스할 수 있을까요? API에서 사용자 데이터를 요청하고, 사용자 설정에서 사용자의 이름을 업데이트하고 싶다고 가정해 봅시다. 우리는 ref.watch(`YourFutureProvider`)가 User 클래스가 아닌 AsyncData 유형을 반환하기 때문에 이렇게 할 수 없습니다. 일부 데이터를 알고 싶을 때마다 GET 요청을 완료하고 싶지 않으며, 특히 첫 번째로로드되고 사용 가능한 경우입니다. 두 Provider를 만들어야할 것으로 생각할 수 있지만, 하나는 AsyncProvider이고, 하나는 NotifierProvider로 대화해야 한다면 그것은 비효율적입니다. 다행히도 이를 처리하는 방법이 있습니다.

다음 코드는 AsyncProvider를 사용하고 로드된 데이터를 NotifierProvider처럼 사용하는 방법을 보여줍니다.

```js
// home.dart

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer(
        builder: (context, ref, _) {
          // Foo Provider를 가져와 상태를 설정합니다.
          // State Provider처럼 사용합니다.
          ref.watch(fooControllerProvider.notifier).foo = Foo(3);
          // UI에서 Foo 사용 (.requireValue는 변경 사항을 청취할 수 있도록 사용됨)
          final foo = ref.watch(fooControllerProvider).requireValue;
          // .when을 사용하여 미래에서 UI를 렌더링합니다.
          return Text('bar: ${foo.bar}, baz: ${foo.baz}');
        },
      ),
    );
  }
}
```

<div class="content-ad"></div>

# 결론

Riverpod는 플러터에서 상태 관리의 가장 추천되는 방법으로 나타났으며 완전히 반응적인 상태 프레임워크로 발전했습니다.

나중에 Provider와 같은 다른 패키지는 더 이상 유지되지 않을 수 있으므로 Riverpod를 배우는 것이 중요합니다 (물론 먼 훗날입니다). 또한 Riverpod는 새로운 제너레이터 덕분에 상태를 효과적으로 관리할 수 있는 유연성과 제어성을 제공하여 build_runner를 사용해 강력하고 메모리를 고려한 프로바이더를 쉽게 만들 수 있습니다.

이 글을 만드는 과정에서 도움이 된 멋진 자료를 제공해 준 다음 분들께 큰 박수를 보냅니다. 🎉

<div class="content-ad"></div>

- CodeWithAndrea
- Adnanjpg
- rrouselgit

이 글이 도움이 되셨기를 바랍니다. 만약 도움이 되었다면, 더 많은 튜토리얼, 경험, 그리고 안내서가 포함된 다른 글도 자유롭게 읽어보세요!

하나님을 신뢰합니다 🙏🏾