---
title: "플러터에서 Cubit 상태 관리 사용하는 방법"
description: ""
coverImage: "/assets/img/2024-06-21-CubitStateManagementinFlutter_0.png"
date: 2024-06-21 23:02
ogImage:
  url: /assets/img/2024-06-21-CubitStateManagementinFlutter_0.png
tag: Tech
originalTitle: "Cubit State Management in Flutter"
link: "https://medium.com/@muhammadnaqeeb/cubit-state-management-in-flutter-cb3d357fd0f0"
---

![Cubit State Management in Flutter](/assets/img/2024-06-21-CubitStateManagementinFlutter_0.png)

상태 관리는 모바일 앱 개발에서 중요한 요소이며, 특히 UI가 반응적인 Flutter와 같은 프레임워크에서는 더욱 중요합니다. Flutter에서 다양한 상태 관리 기술 중 하나인 BLoC (Business Logic Component) 패턴이 상당한 인기를 얻었습니다. BLoC의 영역 내에서 두 가지 주요 접근 방식이 있습니다: Bloc State Management과 Cubit State Management.

# Cubit이란?

Cubit은 BLoC 패턴의 일부인 간단하고 직관적인 상태 관리 솔루션입니다. "Business Logic Component"의 약자입니다. 전통적인 BLoC와는 달리, Cubit은 더 가벼우며 더 간단한 API를 가지고 있어 더 작은 프로젝트나 간단한 상태 관리 필요에 쉽게 사용할 수 있습니다.

<div class="content-ad"></div>

플러터에서 Cubit 상태 관리를 시작하려면 flutter_bloc 패키지를 설치해야 합니다:

```js
dependencies:
   flutter_bloc: ^8.1.3
```

# Cubit을 사용한 카운터 앱

더 나은 이해를 위해 Cubit을 사용하여 간단한 카운터 앱을 구현해 봅시다. 단계별로 진행하겠습니다. 함께 따라와 주세요.

<div class="content-ad"></div>

친구야, Cubit 폴더를 만들어 그 안에 counter_cubit.dart 파일을 생성해보세요.

![이미지](/assets/img/2024-06-21-CubitStateManagementinFlutter_1.png)

파일 안에 Cubit을 확장한 클래스를 만들어주세요.

```js
class CounterCubit extends Cubit {}
```

<div class="content-ad"></div>

문제: 하지만 이렇게 하면 오류가 발생합니다. 수퍼 클래스 'Cubit`dynamic`'에는 인수가 없는 생성자가 없습니다.

그래서 생성자를 만들어 초기 상태를 전달해야 합니다.

```js
class CounterCubit extends Cubit {
  CounterCubit():super(0);
}
```

여기서 '0'은 초기 상태이지만 문자열, 클래스 등이 될 수 있습니다.

<div class="content-ad"></div>

## 이제 초기 상태를 화면에 표시해야 합니다

카운터 큐빗 클래스의 인스턴스를 만듭니다.

이제 이 객체를 사용하여 다양한 것에 액세스할 수 있습니다:

![Cubit State Management in Flutter](/assets/img/2024-06-21-CubitStateManagementinFlutter_2.png)

<div class="content-ad"></div>

지금은 .state를 필요로 합니다.

```js
final counter = CounterCubit().state;
```

필요한 곳에서 사용할 수 있습니다.

```js
Text("$counter");
```

<div class="content-ad"></div>

문제: 작은 문제가 있습니다. 이 카운터는 동적 타입이므로 코드를 망가뜨리지는 않지만, 동적 타입을 피해야 합니다.

![이미지](/assets/img/2024-06-21-CubitStateManagementinFlutter_3.png)

그래서 카운터 cubic 클래스에 타입을 지정해 주세요.

```js
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
}
```

<div class="content-ad"></div>

이제 초기 상태를 성공적으로 표시했어요.

## 값 증가, 상태 변경

이를 위해 카운터 커빗 클래스에 값을 증가시키는 함수를 만들고 모든 청취자에게 알립니다. 상태를 변경하기 위해 emit 함수를 사용합니다.

emit(state) // 제공된 [state]로 상태를 업데이트합니다.

<div class="content-ad"></div>

```js
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() {
    emit(state + 1);
  }
}
```

이제 이 함수를 버튼 클릭에 사용하세요

```js
onPressed: () => CounterCubit().increment(),
```

문제: 그러나 버튼을 클릭해도 상태가 변경되지 않습니다.

<div class="content-ad"></div>

이는 우리가 cubit의 두 개체를 생성하고 있기 때문입니다. 두 번째 cubit의 값을 업데이트하고 있습니다. 이것을 제거하려면 하나의 cubit만 사용해야 합니다.

단일 객체 생성

```js
final counterCubit = CounterCubit();
```

그리고 이것을 모두에서 사용하세요.

<div class="content-ad"></div>

```js
final counter = counterCubit.state; // 빌드 내부

```

버튼을 누르면

```js
onPressed: () => counterCubit.increment(),
```

문제점: 그러나 한 가지 더 빠진 것이 있습니다.

<div class="content-ad"></div>

한 번만 값을 받아서 상태를 업데이트하고 emit이 청취자에게 통지하지만 우리는 상태를 청취하고 있지 않습니다.

이제 BlocBuilder를 사용해야 합니다. 이는 flutter_bloc에서 제공하는 위젯이며 bloc과 builder라는 두 인수가 필요합니다.

```js
BlocBuilder<CounterCubit, int>(
      bloc: counterCubit, // 선택 사항
      builder: (context, counter) {
         return Text(
           '$counter',
         );
}),
```

# 완료 단계

<div class="content-ad"></div>

테이블 태그를 Markdown 형식으로 변경해주세요.

Create a separate class extend with cubit, give the initial state and a function to change the state.

```js
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() {
    emit(state + 1);
  }
}
```

Use the state by making a single object of the cubit class and use BlocBuilder where you need the changing state

```js
class _MyHomePageState extends State<MyHomePage> {
  final counterCubit = CounterCubit(); // (1: object)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            // (2: state value)
            BlocBuilder<CounterCubit, int>(
              bloc: counterCubit, // optional
              builder: (context, counter) {
                return Text(
                  '$counter',
                );
              }
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counterCubit.increment(), // (3: increment)
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

<div class="content-ad"></div>

## 감소 기능 추가

```js
 void decrement() {
    if (state == 0) {
      return;
    }
    emit(state - 1);
  }
```

```js
onPressed: () => counterCubit.decrement(),
```

참고: emit() 함수는 Cubit 외부에서 사용할 수 없습니다.

<div class="content-ad"></div>

# 질문: 두 개의 별도 페이지가 있는 경우

두 개의 별도 페이지가 있는 경우에는 상태를 표시하는 페이지와 그 상태를 변경하는 버튼이 있는 페이지가 따로 있는 것을 의미합니다.

그런데 앞서 언급한 대로 cubit 클래스의 두 개의 다른 객체를 사용할 수 없습니다.

![이미지](/assets/img/2024-06-21-CubitStateManagementinFlutter_4.png)

<div class="content-ad"></div>

이제 icc_dec_page에 버튼이 있고 home_page.dart에서 카운터를 표시하고 있습니다.

카운터 Cubit의 두 인스턴스를 만들 수 없기 때문에 작동하지 않습니다. 하나의 인스턴스만 사용해야 합니다. 이 문제를 해결하기 위해 BlocProvider를 사용합니다. BlocProvider는 블록의 인스턴스를 전달하는 데 사용됩니다.

따라서 main.dart에서 Material app을 BlocProvider로 래핑하고 cubit/bloc을 함수의 인수로 전달합니다.

Markdown 형식의 표로 변경:

Widget build(BuildContext context) {
return BlocProvider( // <-- 이 부분
create: (\_) => CounterCubit(),
child: MaterialApp(
title: 'Flutter Demo',
theme: ThemeData(
colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
useMaterial3: true,
),
home: const MyHomePage(title: 'Flutter Demo Home Page'),
),
);
}
}

<div class="content-ad"></div>

이제 앱 어디에서든 이 카운터 cubit 인스턴스에 액세스할 수 있습니다. 이전에 생성한 cubit 인스턴스를 제거하고 다음을 사용할 수 있습니다.

```js
final counterCubit = BlocProvider.of<CounterCubit>(context);
```

home_page.dart에서

```js
  Widget build(BuildContext context) {
    final counterCubit = BlocProvider.of<CounterCubit>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            BlocBuilder<CounterCubit, int>(
                bloc: counterCubit, // optional
                builder: (context, counter) {
                  return Text(
                    '$counter',
                  );
                }),
          ],
        ),
      ),
```

<div class="content-ad"></div>

inc_dec_page.dart 파일에서

```js
 @override
  Widget build(BuildContext context) {
    final counterCubit = BlocProvider.of<CounterCubit>(context);
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () => counterCubit.increment(),
            tooltip: '증가',
            icon: const Icon(Icons.add),
          ),
          const SizedBox(
            height: 10,
          ),
          IconButton(
            onPressed: () => counterCubit.decrement(),
            tooltip: '감소',
            icon: const Icon(Icons.minimize),
          ),
        ],
```

이 예시의 전체 코드는 제 GitHub 저장소에서 확인할 수 있습니다:

# 결론

<div class="content-ad"></div>

요약하자면, Cubit은 bloc 및 provider 패키지의 장점을 결합하여 상태를 관리하는 간단한 방법을 제공하며 이벤트의 복잡성 없이 상태를 관리할 수 있습니다. Cubit은 메서드 중심의 접근 방식과 최소한의 보일러플레이트 코드로 상태 관리를 간소화하므로 Flutter 개발자들에게 효율성과 구현 용이성을 위한 탁월한 선택지가 됩니다.

- 👔 LinkedIn: muhammadnaqeeb
- 💻 GitHub: muhammadnaqeeb
