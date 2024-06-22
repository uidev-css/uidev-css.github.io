---
title: "Flutter 상태 관리 BLoC와 Provider 비교 어떤 걸 선택해야 할까"
description: ""
coverImage: "/assets/img/2024-06-22-FlutterStateManagementBLoCVSProvider_0.png"
date: 2024-06-22 15:47
ogImage: 
  url: /assets/img/2024-06-22-FlutterStateManagementBLoCVSProvider_0.png
tag: Tech
originalTitle: "Flutter State Management BLoC VS Provider"
link: "https://medium.com/@Victor.Ahmad/bloc-vs-provider-flutter-state-management-a-detailed-comparison-5a932e9033dd"
---


세부 비교

![flutter-state-management](/assets/img/2024-06-22-FlutterStateManagementBLoCVSProvider_0.png)

상태 관리는 모든 애플리케이션을 구축하는 중요한 측면이며 특히 모바일 앱에서 중요합니다. 플러터(Flutter)에서 상태 관리는 앱에서 변경될 수 있는 데이터를 관리하고 해당 데이터를 사용자 인터페이스에 반영하는 과정입니다.

플러터에서 상태 관리에는 여러 패턴이 있지만, 가장 인기 있는 두 가지는 BLoC (Business Logic Component)와 Provider입니다. 이 두 패턴은 모두 플러터 앱의 상태를 관리하기 쉽게 만들어 주지만 각각 다른 방식으로 작동하며 다른 사용 사례에 적합합니다.

<div class="content-ad"></div>

BLoC(Business Logic Component)은 애플리케이션의 비즈니스 로직을 사용자 인터페이스에서 분리하는 디자인 패턴입니다. 이는 UI와 BLoC 간에 데이터를 전달하는 데 스트림을 사용하며, 애플리케이션의 상태를 관리하기 위해 Provider 패키지와 함께 사용할 수 있습니다.

반면에 Provider는 애플리케이션의 상태를 관리하기 위한 패키지입니다. InheritedWidget을 사용하여 상태를 위젯 트리 아래로 전파합니다. BLoC를 사용하는 더 단순하고 가벼운 대안이지만, 덜 강력하고 유연하지 않습니다.

이 블로그 포스트에서는 이 두 상태 관리 패턴을 자세히 살펴보고, Flutter 앱에서 언제 사용해야 하는지, 어떻게 작동하는지, 또한 BLoC와 Provider를 상세히 비교하고 각 패턴의 장점과 단점을 논의할 것입니다.

BLoC(Business Logic Component) 패턴은 애플리케이션의 비즈니스 로직을 사용자 인터페이스에서 분리하는 방법입니다. UI와 BLoC 간에 데이터를 전달하기 위해 스트림을 사용하여 Flutter 앱의 상태를 쉽게 관리할 수 있습니다.

<div class="content-ad"></div>

BLoC 패턴의 기본 구성 요소는 BLoC 자체입니다. 이는 비즈니스 로직을 처리하는 역할을 담당합니다. BLoC는 이벤트 스트림(예: 사용자 입력)을 가져와서 상태 스트림을 업데이트하는 데 사용합니다. 그런 다음 UI는 상태 스트림을 청취하고 그에 따라 업데이트할 수 있습니다.

다음은 카운터를 증가하는 간단한 BLoC 예제입니다:

```js
class CounterBloc {
  final _counterController = StreamController<int>();
  Stream<int> get counter => _counterController.stream;
  void increment() {
    _counterController.sink.add(_counterController.value + 1);
  }
  void dispose() {
    _counterController.close();
  }
}
```

이 예제에서 CounterBloc 클래스에는 비공개 _counterController StreamController와 공개 counter 스트림이 있습니다. increment 메서드는 이벤트를 가져와 스트림의 현재 값에 1을 추가하고, dispose는 더 이상 필요하지 않을 때 스트림을 닫는 데 사용됩니다.

<div class="content-ad"></div>

BLoC 사용의 장점은 다음과 같습니다:

- 코드 구성: BLoC는 비즈니스 로직과 UI 로직을 분리하여 유지 관리, 테스트, 가독성을 높입니다.
- 확장성: BLoC의 모듈식 접근 방식은 앱을 성장시킬 때 확장하기 쉽게 만듭니다.

다음은 위의 BLoC를 플러터 위젯 트리에 구현하는 예시입니다:

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      create: (context) => CounterBloc(),
      child: MaterialApp(
        home: CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
      body: Center(
        child: StreamBuilder<int>(
          stream: bloc.counter,
          initialData: 0,
          builder: (context, snapshot) {
            return Text('${snapshot.data}');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bloc.increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
```

<div class="content-ad"></div>

BLoC을 사용하는 한 가지 단점은 설정 및 사용이 더 복잡할 수 있고 구현하는 데 더 많은 시간과 노력이 필요할 수 있다는 것입니다. 또한 몇 가지 경우에는 단순한 경우에 스트림 컨트롤러 및 스트림 빌더의 필요가 하나의 Provider가 더 적합한 경우도 있을 수 있습니다.

Provider 패턴은 Flutter 애플리케이션의 상태를 관리하기 위한 패키지입니다. InheritedWidget을 사용하여 상태를 위젯 트리 아래로 전파하여 앱 전체에서 상태에 쉽게 액세스하고 업데이트할 수 있도록 돕습니다.

Provider에서 앱 상태를 보유하는 ChangeNotifier와 ChangeNotifier를 보유하는 ChangeNotifierProvider가 있습니다. ChangeNotifierProvider는 ChangeNotifier의 인스턴스를 취하고 위젯 트리 안에 있는 위젯에 노출합니다.

다음은 Provider를 사용한 간단한 Counter 앱 예시입니다.

<div class="content-ad"></div>

```js
class CounterModel with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}
```

이 예시에서 CounterModel 클래스는 카운터를 나타내는 int 값이 있는 ChangeNotifier이며, 카운터를 업데이트하는 increment 메서드와 UI에 변경 사항을 알리기 위해 notifyListeners()를 호출하는 기능을 가지고 있습니다.

위의 CounterModel을 Flutter 위젯 트리에 구현하는 예시는 아래와 같습니다.

```js
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CounterModel(),
      child: MaterialApp(
        home: CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<CounterModel>(context);

    return Scaffold(
      body: Center(
        child: Text('${counter.count}'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counter.increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
```

<div class="content-ad"></div>

Provider를 사용하는 장점 중 하나는 사용하기 쉽고 간단하다는 것입니다. 특히 작고 간단한 앱에 사용하기에 매우 간편합니다.

하지만, Provider는 BLoC에 비해 강력하고 유연성이 부족하며, 더 크고 복잡한 앱의 상태를 관리하기 어려울 수 있습니다. 또한 코드 구성을 위한 구체적인 구조를 제공하지 않아 애플리케이션이 성장함에 따라 더 복잡하고 이해하기 어려운 코드로 이어질 수 있습니다.

이 섹션에서는 BLoC (비즈니스 로직 컴포넌트)와 Provider를 아키텍처, 코드 구성, 사용 편의성, 확장성 및 디버깅/테스트 측면에서 비교할 것입니다.

- BLoC는 응용 프로그램의 비즈니스 로직을 사용자 인터페이스에서 분리하는 더 복잡하고 강력한 패턴입니다. UI와 BLoC 간에 데이터를 통신하는 데 스트림을 사용하며, Provider 패키지와 함께 사용할 수 있습니다. 반면에 Provider는 InheritedWidget을 사용하여 상태를 위젯 트리 아래로 전파하는 더 간단하고 가벼운 패턴입니다.

<div class="content-ad"></div>

- BLoC은 비즈니스 로직과 UI 로직을 분리하여 상태를 관리하는 더 모듈화되고 조직적인 방식을 따릅니다. 이로 인해 코드가 유지보수 가능하고 테스트 가능하며 가독성이 높아집니다. Provider는 간단한 해결책이지만 애플리케이션이 커짐에 따라 더 복잡하고 이해하기 어려운 코드로 이어질 수 있습니다. Provider는 특정 구조를 제공하지 않기 때문입니다.

- Provider는 일반적으로 설정하고 사용하기 쉽다고 여겨지며 특히 작고 간단한 앱에 적합합니다. 반면에 BLoC은 설정하고 사용하기에 더 복잡할 수 있으며 구현하는 데 더 많은 시간과 노력을 필요로 할 수 있습니다.

- BLoC은 더 크고 복잡한 앱에 더 적합하며, 상태를 관리하는 더 조직화되고 모듈화된 방식을 허용하여 앱이 성장할수록 더 쉽게 확장할 수 있습니다. 반면에 Provider는 작거나 간단한 앱에 더 적합하며 큰 앱의 복잡성을 쉽게 처리하지 못할 수 있습니다.

- BLoC 아키텍처는 버그를 감지하고 코드를 테스트하고 다른 부분에 영향을 주지 않고 변경하는 것이 쉽습니다. Provider는 BLoC만큼 디버깅과 테스트하기에 적합하지 않으며 독립성과 모듈성의 수준을 제공하지 않기 때문입니다.

<div class="content-ad"></div>

이 문서에서는 플러터 앱용 두 가지 인기있는 상태 관리 패턴인 BLoC (Business Logic Component)과 Provider에 대해 논의했습니다. 이 두 패턴은 플러터 앱의 상태를 더 쉽게 관리할 수 있도록 설계되었지만, 접근 방식이 다르며 다른 사용 사례에 적합합니다.

BLoC는 애플리케이션의 비즈니스 로직을 사용자 인터페이스와 분리하는 강력하고 유연한 패턴입니다. 이는 UI와 BLoC 간에 데이터를 통신하는 데 스트림을 사용하며, 대규모 및 복잡한 앱에 적합합니다. 반면 Provider는 더 간단하고 가벼운 패턴으로, InheritedWidget을 사용하여 상태를 위젯 트리 아래로 전파합니다. 이는 더 작거나 간단한 앱에 적합합니다.

이 글의 주요 요점은 다음과 같습니다:

- BLoC는 대규모 및 복잡한 앱에 적합한 강력하고 유연한 패턴입니다.
- Provider는 더 작거나 더 간단한 앱에 적합한 더 간단하고 가벼운 패턴입니다.
- BLoC와 Provider는 플러터 앱의 상태를 관리하는 데 유용하며, 다른 사용 사례에 적합합니다.
- 상태 관리 패턴을 선택할 때 앱의 특정 요구 사항을 고려하는 것이 중요합니다. 이는 앱의 크기와 복잡성뿐만 아니라 그로 인해 달성하려는 목표도 포함해야 합니다.

<div class="content-ad"></div>

만약 당신의 앱이 작고 간단하며 비즈니스 로직과 UI 로직을 분리할 필요가 없다면, Provider가 좋은 선택일 것입니다. 만약 당신의 앱이 더 복잡하거나 비즈니스 로직과 UI 로직을 분리하고 싶다면, BLoC가 더 나은 선택일 것입니다. 그러나 결국, 당신의 앱의 구체적인 요구사항을 평가하고 사용 사례에 가장 잘 맞는 상태 관리 패턴을 선택하는 것이 항상 더 나은 방법입니다.

이 블로그 게시물 작성 시 다음 소스가 사용되었습니다:

- Flutter 상태 관리 문서: https://flutter.dev/docs/development/data-and-backend/state-mgmt
- BLoC 패턴: https://www.didierboelens.com/2018/08/reactive-programming---streams---bloc/
- Provider 패키지: https://pub.dev/packages/provider

Flutter에서 상태 관리에 대해 더 자세히 알고 싶은 독자들을 위해 다음 리소스들이 유용할 수 있습니다:

<div class="content-ad"></div>

- **Provider 패키지에 대한 Flutter 문서**: [여기](https://pub.dev/packages/provider#-readme-tab)
- **BLoC 패턴에 대한 Flutter 문서**: [여기](https://flutter.dev/docs/development/data-and-backend/state-mgmt/options#bloc--rx)
- **Flutter에서의 고급 상태 관리**: [여기](https://www.youtube.com/watch?v=RS36gBEp8OI&t=898s)

그 외 다양한 Flutter 상태 관리 옵션과 패키지가 있다는 점도 알아두면 좋아요. 필요에 따라 몇 가지 다른 옵션들을 탐색해보실 수도 있습니다.