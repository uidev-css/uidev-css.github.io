---
title: "Flutter 상태 관리 비교 Provider, BLoC, GetX, Riverpod, GetIt, 그리고 MobX"
description: ""
coverImage: "/assets/img/2024-06-21-FlutterStateManagementProviderBLoCGetXRiverpodGetItandMobX_0.png"
date: 2024-06-21 23:25
ogImage:
  url: /assets/img/2024-06-21-FlutterStateManagementProviderBLoCGetXRiverpodGetItandMobX_0.png
tag: Tech
originalTitle: "Flutter State Management: Provider, BLoC, GetX, Riverpod, GetIt and MobX"
link: "https://medium.com/@alvaro.armijoss/flutter-state-management-provider-bloc-getx-riverpod-getit-and-mobx-c9db3168a834"
---

본 기사에서는 상태 관리의 일반적인 개요를 검토한 후 가장 흥미로운 상태 관리 방법인 Provider, BLoC, GetX, Riverpod, GetIt, 그리고 MobX를 살펴보겠습니다.

![image](/assets/img/2024-06-21-FlutterStateManagementProviderBLoCGetXRiverpodGetItandMobX_0.png)

# 일반적인 개요

모바일 앱을 개발하는 동안, 화면 간이나 전체 앱을 통해 앱 상태를 공유해야 하는 시점이 찾아옵니다.

<div class="content-ad"></div>

<img src="/assets/img/2024-06-21-FlutterStateManagementProviderBLoCGetXRiverpodGetItandMobX_1.png" />

이 예에서는 MyLoginScreen, MyCatalog 및 MyCart의 3 개 화면이 있습니다. MyCatalog에서는 제품이 이미 쇼핑 카트에 있는지 확인하기 위해 애플리케이션의 상태를 알아야 합니다. 그리고 MyCart에서는 추가된 모든 제품과 총 구매액을 보고 싶습니다. 두 화면 모두 카트의 상태를 알아야 합니다. 이것은 애플리케이션 상태의 예시이며, 나중에 자세히 검토할 예정입니다.

- Android 또는 iOS 개발에서 추측할 수 있는 많은 가정이 Flutter에는 해당하지 않습니다. 예를 들어, Flutter에서 UI의 일부를 수정하는 대신 처음부터 다시 빌드하는 것은 괜찮습니다. Flutter는 이를 수행할 만큼 충분히 빠릅니다. 필요하다면 매 프레임마다 가능합니다.
- Flutter는 선언적입니다. 이것은 Flutter가 현재 상태 애플리케이션을 반영하기 위해 UI를 빌드한다는 것을 의미합니다.
- 예를 들어 앱 상태가 변경되면, 예를 들어 설정 화면이 있고 사용자가 스위치를 누르는 경우, 그것은 상태를 변경하고 이것은 UI 디자인을 트리거합니다. 이것은 명령형 UI 변경이 아니며, 변경되는 것은 상태이며 UI는 처음부터 다시 빌드됩니다.
- UI 프로그래밍의 선언적 스타일에는 많은 이점이 있습니다. 모든 상태에 대해 UI가 어떻게 보이는지 설명하고 한 번만 설명하면 됩니다.

<img src="/assets/img/2024-06-21-FlutterStateManagementProviderBLoCGetXRiverpodGetItandMobX_2.png" />

<div class="content-ad"></div>

# Transient State와 앱 상태의 차이점

![이미지](/assets/img/2024-06-21-FlutterStateManagementProviderBLoCGetXRiverpodGetItandMobX_3.png)

앱 상태는 응용 프로그램이 실행 중일 때 메모리에 있는 모든 요소를 포함합니다. 이는 자산, 변수, 애니메이션 상태, 글ꔼ자 등을 포함합니다.

우리가 관리하는 상태는 일시적인 상태와 앱 상태로 나뉠 수 있습니다.

<div class="content-ad"></div>

## 일시적 상태

단일 위젯을 포함할 수 있는 상태입니다. 예를 들어:

- 위젯에서 현재 페이지
- 애니메이션의 진행 상황
- BottomNavigationBar에서 선택한 탭

다시 말해, 이 유형의 상태에서는 상태 관리 기술을 사용할 필요가 없습니다. 필요한 것은 StatefulWidget뿐입니다.

<div class="content-ad"></div>

## 앱 상태

당연히, 이것은 일시적이지 않은 상태이며 응용 프로그램의 여러 부분에서 공유하고 사용자 세션 사이에서 유지하고 싶은 상태입니다. 응용 프로그램 상태의 예시:

- 사용자의 선호도
- 로그인 정보
- 전자 상거래 응용 프로그램의 쇼핑 카트

여기서 우리는 상태 관리가 필요할 수 있습니다.

<div class="content-ad"></div>

저희가 모든 상태 관리를 위해 개발할 예제를 보여드리겠습니다.

![이미지](/assets/img/2024-06-21-FlutterStateManagementProviderBLoCGetXRiverpodGetItandMobX_4.png)

# Provider

만약 플러터를 처음 시작하시는 초보자이고 다른 접근 방식을 선택할 확실한 이유가 없다면, 아마도 이 접근 방식부터 시작하는 것이 좋을 것입니다. Provider 패키지는 이해하기 쉽고 코드 양이 많지 않습니다. 또한 다른 접근 방식에서 사용되는 개념을 사용합니다.

<div class="content-ad"></div>

앱에는 MyCart 및 MyCatalog 위젯으로 나타낸 카탈로그 및 장바구니라는 두 개의 별도 화면이 있습니다. 카탈로그 화면에는 앱 바와 항목 목록이 포함되어 있습니다.

우리는 몇 가지 위젯이 있습니다. 그 중 많은 위젯이 다른 위치에 "소속된" 상태에 액세스해야 합니다. 예를 들어, 카탈로그의 각 항목은 장바구니에 추가할 수 있습니다. 현재 표시된 항목이 이미 장바구니에 있는지 확인하려고 할 수도 있습니다.

<div class="content-ad"></div>

이로써 첫 번째 질문으로 이어집니다: 장바구니의 현재 상태를 어디에 두어야 할까요?

- 플러터에서는 상태를 사용하는 위젯 위에 상태를 두는 것이 합리적으로 보입니다. 왜 그럴까요? 플러터와 같은 선언형 프레임워크에서는 UI를 변경하려면 다시 생성해야 합니다. 다시 말해, 외부에서 메서드를 호출하여 위젯을 명령형으로 변경하는 것은 어렵습니다.
- 현재 UI 상태를 고려하고 새 데이터를 적용해야 합니다. 이런 방식으로 버그를 피하기 어렵습니다.
- 플러터에서는 컨텐츠가 변경될 때마다 새 위젯을 빌드합니다.

이전 질문에 대한 답변은 앱 수준에 장바구니 상태를 두어야 합니다. 이렇게 하면 MyCart와 MyCatalog에서 상태에 액세스할 수 있습니다. MyCatalog 레벨에 상태를 둔다면 MyCart에서 액세스할 수 없습니다. 플러터에서는 불필요한 UI 다시 빌드를 피하기 위해 가능한 한 앱 상태를 위젯 트리의 낮은 위치에 두는 것이 좋은 실천법입니다.

![이미지](/assets/img/2024-06-21-FlutterStateManagementProviderBLoCGetXRiverpodGetItandMobX_7.png)

<div class="content-ad"></div>

이제 코드를 리뷰해 봅시다.

먼저, 우리에게는 3가지 상태가 있습니다: 초기 상태, 로딩 상태, 성공 상태.

```js
enum Status {
  initial,
  loading,
  success,
}
```

Provider를 사용할 때 이해해야 할 3가지 개념이 있습니다: ChangeNotifier, ChangeNotifierProvider 및 Consumer.

<div class="content-ad"></div>

## ChangeNotifier

ChangeNotifier은 Flutter SDK에 포함된 간단한 클래스로, 청취자에게 변경 알림을 제공합니다. 즉, 무언가가 ChangeNotifier이면 해당 변경 사항에 구독할 수 있습니다.

provider에서 ChangeNotifier는 응용 프로그램 상태를 캡슐화하는 한 가지 방법입니다. 매우 간단한 앱의 경우에는 하나의 ChangeNotifier로 작업할 수 있습니다. 복잡한 앱의 경우 여러 가지 모델이 있고, 따라서 여러 개의 ChangeNotifier가 있을 것입니다.

ChangeNotifier에 특정한 유일한 코드는 notifyListeners()를 호출하는 부분입니다. 이 메서드를 호출하여 모델에 변경 사항이 있을 때마다 UI가 변경될 수 있는지 확인하세요. CartModel에서의 나머지 코드는 모델 자체와 비즈니스 로직입니다.

<div class="content-ad"></div>

우리의 DataProvider 클래스를 확인해주세요:

```js
class DataProvider extends ChangeNotifier {
  /// 데이터 공급자의 내부적인, 비공개 상태입니다.
  Status _state = Status.initial;

  /// 데이터 공급자의 상태입니다.
  Status get state => _state;

  /// 데이터 공급자의 상태를 업데이트합니다. 데이터 공급자를 외부에서 수정하는 유일한 방법입니다.
  void fecthData() async {
    _state = Status.loading;
    // 이 호출은 해당 모델을 듣고 있는 위젯에게 rebuild해야 함을 알립니다.
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _state = Status.success;
    notifyListeners();
  }
}
```

## ChangeNotifierProvider

ChangeNotifierProvider은 ChangeNotifier 인스턴스를 후손들에게 제공하는 위젯입니다. provider 패키지에서 제공됩니다.

<div class="content-ad"></div>

ChangeNotifierProvider를 어디에 배치해야 하는지 이미 알고 계시네요: 액세스해야 하는 위젯들 위에요. CartModel의 경우, MyCart와 MyCatalog 둘 다 위쪽에 어딘가에 있어야 합니다.

우리 예제에서 ChangeNotifierProvider와 HomeProvider (UI)를 자식으로 하는 ProviderPage가 있습니다.

```js
class ProviderPage extends StatelessWidget {
  static const route = 'provider-page';

  const ProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: const HomeProvider(),
    );
  }
}
```

## Consumer

<div class="content-ad"></div>

요소별로 Translation을 제공합니다:

Consumer 위젯을 가능한 깊이까지 Tree 안에 두는 것이 최선의 방법입니다. 어딘가의 세부 사항이 변경되었을 때 UI의 큰 부분을 다시 빌드하고 싶지 않으니까요.

```js
class HomeProvider extends StatefulWidget {
  const HomeProvider({super.key});

  @override
  State<HomeProvider> createState() => _HomeProviderState();
}

class _HomeProviderState extends State<HomeProvider> {
  late DataProvider provider;

  @override
  void initState() {
    provider = Provider.of<DataProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Provider Page')),
      // Consumer 위젯을 가능한 깊이까지 Tree 안에 두는 것이 최선의 방법입니다.
      // 어딘가의 세부 사항이 변경되었을 때 UI의 큰 부분을 다시 빌드하고 싶지 않으니까요.
      body: Consumer<DataProvider>(
        builder: (context, data, child) {
          if (data.state == Status.initial) {
            return const Center(child: Text('Press the Button'));
          }
          if (data.state == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (data.state == Status.success) {
            return const Center(child: Text('Success'));
          }
          return Container();
        },
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: const Icon(Icons.play_arrow),
            onPressed: () => provider.fecthData(),
          ),
        ],
      ),
    );
  }
}
```

그 결과는 다음과 같습니다:

![이미지](/assets/img/2024-06-21-FlutterStateManagementProviderBLoCGetXRiverpodGetItandMobX_8.png)

<div class="content-ad"></div>

## 장점

- Flutter를 처음 사용하는 경우 시작해야 할 접근 방식입니다. 이해하기 쉽고 많은 코드를 사용하지 않습니다.
- Devtool 친화적 — Provider를 사용하면 애플리케이션의 상태가 Flutter devtool에서 볼 수 있습니다.
- 데이터 할당 및 자원 (데이터) 해제를 간소화합니다.

## 단점

- 불필요한 업데이트를 실수로 호출할 수 있습니다. 객체의 상태가 변경되었을 때마다 업데이트를 트리거할 필요는 없습니다. 그러나 Provider를 사용하는 경우 변경이 발생할 때마다 항상 업데이트를 트리거합니다.
- 확장성

<div class="content-ad"></div>

# BLoC

- 이 패키지의 목적은 UI와 비즈니스 로직을 분리하는 것을 용이하게 하는 것입니다.
- 이 패키지는 패턴의 반응적 부분을 추상화하여 개발자가 비즈니스 로직 작성에 집중할 수 있도록 합니다.
- Bloc은 이벤트를 기반으로 한 상태 변경을 트리거하는 메서드 대신 메서드 대신 사용하는 고급 클래스입니다. Bloc은 이벤트를 수신하고 수신된 이벤트를 발생한 이벤트로 변환합니다.

![image](/assets/img/2024-06-21-FlutterStateManagementProviderBLoCGetXRiverpodGetItandMobX_9.png)

이 부분을 좀 더 잘 이해하기 위해 이벤트가 UI에서 추가되고 BLoC에서 이를 처리하고 이러한 이벤트에 대한 상태 변경으로 응답합니다. bloc 라이브러리를 사용하면 Presentation, Business Logic 및 Data가 세 개의 레이어로 나뉘도록 응용 프로그램을 분리할 수 있습니다.

<div class="content-ad"></div>

상태 변경은 이벤트가 추가될 때 블록이 시작되며 onEvent을 트리거합니다. 그런 다음, 이벤트는 EventTransformer를 통해 흘러갑니다. 기본적으로 각 이벤트는 병렬로 처리되지만 사용자 정의 EventTransformer를 제공하여 들어오는 이벤트 스트림을 조작할 수 있습니다. 해당 이벤트 유형에 대해 등록된 모든 EventHandlers는 들어오는 이벤트와 함께 호출됩니다. 각 EventHandler는 이벤트에 대한 응답으로 제로 이상의 상태를 발행하는 책임이 있습니다. 마지막으로, 상태가 업데이트되기 직전에 onTransition이 호출되며 현재 상태, 이벤트 및 다음 상태를 포함합니다.

![이미지](/assets/img/2024-06-21-FlutterStateManagementProviderBLoCGetXRiverpodGetItandMobX_10.png)

BLoC 구현에서는 data_bloc, data_event 및 data_state 총 3개의 파일이 필요합니다.

![이미지](/assets/img/2024-06-21-FlutterStateManagementProviderBLoCGetXRiverpodGetItandMobX_11.png)

<div class="content-ad"></div>

블록 상태에서는 세 가지 상태를 가질 것입니다: 초기, 로딩 및 성공.

```js
part of 'data_bloc.dart';


abstract class DataState {}

class Initial extends DataState {}

class Loading extends DataState {}

class Success extends DataState {}
```

또한, 블록 이벤트에서는 FetchDataEvent만 사용할 것입니다.

```js
part of 'data_bloc.dart';

abstract class DataEvent {}

class FetchDataEvent extends DataEvent {}

<div class="content-ad"></div>

In DataBloc, when the FetchDataEvent is added, the _onFetchDataEvent method is triggered.

import 'package:flutter_bloc/flutter_bloc.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(Initial()) {
    on<FetchDataEvent>(_onFetchDataEvent);
  }

  void _onFetchDataEvent(
    FetchDataEvent event,
    Emitter<DataState> emit,
  ) async {
    emit(Loading());
    await Future.delayed(const Duration(seconds: 2));
    emit(Success());
  }
}

In this example, we have a BlocPage that includes a BlocProvider with HomeBloc as a child.

class BlocPage extends StatelessWidget {
  static const route = 'bloc-page';

  const BlocPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DataBloc(),
      child: const HomeBloc(),
    );
  }
}

<div class="content-ad"></div>

class HomeBloc extends StatefulWidget {
  const HomeBloc({super.key});

  @override
  State<HomeBloc> createState() => _HomeBlocState();
}

class _HomeBlocState extends State<HomeBloc> {
  late DataBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<DataBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BLoC 페이지')),
      body: BlocBuilder<DataBloc, DataState>(
        builder: (context, state) {
          if (state is Initial) {
            return const Center(child: Text('버튼을 눌러주세요'));
          }
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is Success) {
            return const Center(child: Text('성공'));
          }
          return Container();
        },
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: const Icon(Icons.play_arrow),
            onPressed: () => bloc.add(FetchDataEvent()),
          ),
        ],
      ),
    );
  }
}

그리고 Bloc 결과입니다:

<img src="/assets/img/2024-06-21-FlutterStateManagementProviderBLoCGetXRiverpodGetItandMobX_12.png" />

## 장점
```

<div class="content-ad"></div>

- 애플리케이션의 상태를 언제든지 파악할 수 있습니다.
- 앱이 적절하게 응답하는지 확인하기 위해 모든 케이스를 쉽게 테스트할 수 있습니다.
- 애플리케이션에서 모든 사용자 상호 작용을 기록하여 데이터 기반 결정을 내릴 수 있습니다.
- 빠르고 반응성 있는 앱을 개발할 수 있습니다.
- 대규모 데이터 크기에 대해 더 나은 성능을 제공합니다.

## 단점

- 대형 애플리케이션을 가지고 있을 때만 효과적입니다.
- 두 방향으로 스트림을 사용해야 하므로 Provider보다 더 많은 보일러플레이트가 발생할 수 있습니다.
- 복잡한 시나리오에서는 너무 제한적일 수 있으며 하나의 입력과 출력만 다루는 BLoC를 생성할 수 있습니다.
- 특히 앱의 여러 부분에 유사한 비즈니스 로직을 구현해야할 경우 코드 중복으로 이어질 수 있습니다.

# GetX

<div class="content-ad"></div>

- 플러터에 대한 가벼우면서도 강력한 솔루션입니다. 고성능 상태 관리, 스마트한 의존성 주입, 라우트 관리를 빠르고 실용적으로 결합합니다.
- 성능과 자원 최소 소비에 중점을 둡니다. GetX는 Streams나 ChangeNotifier를 사용하지 않습니다.
- 사용하기 쉽고 즐거운 구문을 사용합니다.
- 뷰, 표현 로직, 비즈니스 로직, 의존성 주입, 네비게이션의 완전한 분리를 허용합니다.

다음 이미지에서 모든 GetX 기능을 확인할 수 있습니다:

![GetX Functions](/assets/img/2024-06-21-FlutterStateManagementProviderBLoCGetXRiverpodGetItandMobX_13.png)

하지만 우리에게 가장 중요한 것은 반응형 상태 관리자입니다.

<div class="content-ad"></div>

## 반응성 상태 관리자

반응형 프로그래밍은 복잡하다고 말리기 때문에 많은 사람들을 멀리하곤 합니다. GetX는 반응형 프로그래밍을 꽤 간단하게 만들어 줍니다:

- StreamControllers를 만들 필요가 없습니다.
- 각 변수마다 StreamBuilder를 만들 필요가 없습니다.
- 각 상태마다 클래스를 만들 필요가 없습니다.
- 초기 값에 대한 get을 만들 필요가 없습니다.

이름 변수가 있고 이 변수를 변경할 때마다 사용하는 모든 위젯이 자동으로 변경되기를 원한다고 상상해 봅시다.

<div class="content-ad"></div>

여기 당신의 계수 변수가 있어요:

```js
var name = "Jonatas Borges";
```

이를 관찰 가능하도록 만들기 위해서는 그 뒤에 ".obs"를 추가하기만 하면 돼요:

```js
var name = "Jonatas Borges".obs;
```

<div class="content-ad"></div>

UI에서 해당 값이 표시되고 값이 변경될 때 화면을 업데이트하려면 다음과 같이 하면 됩니다:

```js
Obx(() => Text("${controller.name}"));
```

단순합니다.

이제 코드로 넘어갑니다. GetX에서 Controller가 정의됩니다. 이 경우 GetxController를 확장한 Controller 클래스를 만듭니다.

<div class="content-ad"></div>

```js
열거형 Status {
  초기,
  로딩,
  성공,
}
```

```js
class Controller extends GetxController {
  // GetX는 반응형이기 때문에 변수가 변경되면 자동으로 화면에서 변경됩니다.
  // 변수 앞에 ".obs"를 추가하기만 하면 이미 반응형입니다.
  var state = Status.initial.obs;

  /// 컨트롤러의 상태를 업데이트합니다. 이 방법이 컨트롤러를 외부에서 수정하는 유일한 방법입니다.
  void fetchData() async {
    state.value = Status.loading;
    //update();

    await Future.delayed(const Duration(seconds: 2));

    state.value = Status.success;
  }
}
```

UI에서 우리는 GetXPage가 있습니다. 그 안에는 간단한 HomeGetX 위젯이 자식으로 있습니다. 이 방식으로 정의되었는데, Provider 및 Bloc과의 차이를 보려고 했습니다. Provider나 Bloc을 자식 위젯에 제공하기 위해 ChangeNotifierProvider나 BlocProvider의 부모 위젯을 정의해야 했던 과정과의 차이점을 볼 수 있습니다.

```js
class GetXPage extends StatelessWidget {
  static const route = 'getx-page';

  const GetXPage({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomeGetX();
  }
}
```

<div class="content-ad"></div>

```js
class HomeGetX extends StatefulWidget {
  const HomeGetX({super.key});

  @override
  State<HomeGetX> createState() => _HomeGetXState();
}

class _HomeGetXState extends State<HomeGetX> {
  late Controller c;

  @override
  void initState() {
    c = Get.put(Controller());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GetX Page')),
      //최상위에 Consumer 위젯을 가능한 깊게 두는 것이 가장 좋습니다.
      //어딘가의 세부 사항이 변경되었기 때문에 UI의 큰 부분을 다시 빌드하고 싶지 않습니다.
      body: GetX<Controller>(
        builder: (context) {
          if (c.state.value == Status.initial) {
            return const Center(child: Text('Press the Button'));
          }
          if (c.state.value == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (c.state.value == Status.success) {
            return const Center(child: Text('Success'));
          }
          return Container();
        },
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: const Icon(Icons.play_arrow),
            onPressed: () => c.fecthData(),
          ),
        ],
      ),
    );
  }
}
```

결과는 다음과 같습니다:

<img src="/assets/img/2024-06-21-FlutterStateManagementProviderBLoCGetXRiverpodGetItandMobX_14.png" />

## 장점

<div class="content-ad"></div>

- 몇 줄의 코드로 작성된 간단한 상태 업데이터입니다. 최소한의 CPU 영향을 주도록 단순하게 만들었고, 단일 목적을 충족하고 가능한 한 최소한의 리소스를 사용하기 위해 제작되었습니다.
- 강력한 상태 관리자이며 변수가 아닌 흐름(Flow)으로 작동하며, 내부적으로는 모든 것이 스트림(Stream)입니다.
- 코드 생성기나 장식품(Decoration) 없이도 실제로 BLoC 접근 방식입니다. .obs를 사용하여 모든 것을 "Observable"로 변환할 수 있습니다.

## 단점

- 문제들이 많이 발생할 수 있으며 중복될 수도 있습니다. 문제 해결, 답변, 태깅, 중복 제거 등에 대해 아무도 관심을 가지지 않는 것이 분명합니다.
- GetX가 너무 많은 작업을 수행하고 이 프로젝트가 단 한 사람에게는 너무 큽니다.
- 핫 리로드 문제 - GetX는 자체 종속성 주입 시스템을 가지고 있으며, 이는 GetX 모듈의 거의 모든 곳에서 사용되지만 아직 안정적이지 않습니다.
- GetX로 단위 및 위젯 테스트를 작성하는 것은 정말 어렵고 몇 가지 경우에는 일부 기능을 테스트하는 것이 불가능합니다.

# Riverpod

<div class="content-ad"></div>

- Provider와 유사하며 컴파일 안전성과 테스트 가능성을 갖추고 있습니다.
- Riverpod은 Provider에서 영감을 받았지만 동일한 유형의 여러 공급자 지원; 비동기 공급자 대기; 어디서든 공급자 추가와 같은 주요 문제들을 해결합니다.
- 이제 main.dart와 UI 파일 간에 이동할 필요가 없어졌습니다.
- 공유 상태 코드를 필요한 곳에 배치하고, 별도의 패키지에 있든 위젯 옆에 있든 테스트 가능성을 잃지 않고 유지하세요.

Providers는 Riverpod 앱의 가장 중요한 요소입니다. Provider는 상태 조각을 캡슐화하고 해당 상태를 청취할 수 있는 개체입니다.

```js
enum Status {
  initial,
  loading,
  success,
}
```

```js
class RiverpodProvider extends StateNotifier<Status> {
  RiverpodProvider() : super(Status.initial);

  Future<void> fetchData() async {
    state = Status.loading;

    await Future.delayed(const Duration(seconds: 2));

    state = Status.success;
  }
}

final riverpodProvider =
    StateNotifierProvider.autoDispose((ref) => RiverpodProvider());
```

<div class="content-ad"></div>

UI에서 다음과 같이 하고 있습니다:

```js
class RiverpodPage extends StatelessWidget {
  static const route = 'riverpod-page';

  const RiverpodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
      child: HomeRiverpod(),
    );
  }
}
```

위젯이 프로바이더를 읽을 수 있도록 하려면 전체 애플리케이션을 "ProviderScope" 위젯으로 감싸야 합니다. 이곳에는 프로바이더의 상태가 저장됩니다.

```js
class HomeRiverpod extends ConsumerWidget {
  const HomeRiverpod({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.read(riverpodProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Riverpod Page')),
      // 소비자 위젯을 가능한 깊게 트리 안에 배치하는 것이 가장 좋습니다.
      // 어딘가의 세부 사항이 변경되었을 때 UI의 큰 부분을 다시 빌드하고 싶지 않습니다.
      body: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(riverpodProvider);
          if (state == Status.initial) {
            return const Center(child: Text('Press the Button'));
          }
          if (state == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state == Status.success) {
            return const Center(child: Text('Success'));
          }
          return Container();
        },
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: const Icon(Icons.play_arrow),
            onPressed: () => data.fetchData(),
          ),
        ],
      ),
    );
  }
}
```

<div class="content-ad"></div>

## 제공자들과 상호 작용하는 ref 사용하기

"ref"를 사용하는 주요 용도는 다음과 같습니다:

- ref.watch를 사용하여 제공자의 값을 얻고 변경 사항을 청취하는 것입니다. 값이 변경되면 해당 위젯이나 제공자가 다시 빌드되는 기능입니다.
- ref.listen을 사용하여 제공자에서 리스너를 추가하여 해당 제공자가 변경될 때 새 페이지로 이동하거나 모달을 표시하는 등의 동작을 실행하는 것입니다.
- ref.read를 사용하여 변경 사항을 무시하고 제공자의 값을 얻는 것입니다. "클릭"과 같은 이벤트에서 제공자의 값을 필요로 할 때 유용합니다.

이 결과는 다음과 같습니다:

<div class="content-ad"></div>

빠른 대답을 위해 노력중입니다!

<div class="content-ad"></div>

- Riverpod은 앱에서 상태를 구현하는 데 너무 많은 자유를 제공합니다. 이는 새로운 개발자들에게 가장 좋은 접근 방식을 선택하는 데 어려움을 줄 수 있습니다.
- 공유 상태를 위젯 트리 전체에 분산시키는 나쁜 안티패턴을 촉진합니다. 이는 코드가 매우 찾기 어렵도록 (중앙화되지 않음) 하고, Provider 간에 과도한 의존성 체인과 결합으로 디버깅을 추적하기 어렵게 만들 수 있습니다.

# GetIt

GetIt은 상태 관리 솔루션이 아닙니다! 객체의 로케이터이므로 스트림이나 ValueNotifiers와 같은 다른 방법을 사용하여 UI에 변경을 알릴 필요가 있습니다. 그러나 get_it_mixin과 함께 사용하면 get_it에 등록된 객체와 통합되는 완전한 기능의 쉬운 상태 관리 솔루션이 됩니다.

GetIt은:

<div class="content-ad"></div>

- 극히 빠름
- 배우고 사용하기 쉬움
- Provider나 Redux처럼 데이터에 액세스하기 위해 특별한 위젯을 UI 트리에 추가하지 않음

저희의 구현은 다음과 같습니다:

```js
enum Status {
  initial,
  loading,
  success,
}
```

```js
class GetItProvider extends ChangeNotifier {
  /// GetItProvider의 내부 및 비공개 상태입니다.
  Status _state = Status.initial;

  /// GetItProvider의 상태입니다.
  Status get state => _state;

  /// GetItProvider의 상태를 업데이트합니다. 이는 외부에서 GetItProvider를 수정하는 유일한 방법입니다.
  void fecthData() async {
    _state = Status.loading;
    // 이 호출은 이 모델을 듣고 있는 위젯에게 다시 빌드하도록 지시합니다.
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _state = Status.success;
    notifyListeners();
  }
}
```

<div class="content-ad"></div>

만약 주목했다면, GetItProvider가 Provider를 검토할 때 우리가 구현한 DataProvider와 동일하다는 것을 알 수 있어요.

객체에 액세스하기 전에는 GetIt에 그들을 등록해야 합니다. 보통 initState 코드 내에서 직접 등록합니다.

```js
class GetItPage extends StatefulWidget {
  static const route = 'get-it-page';

  const GetItPage({super.key});

  @override
  State<GetItPage> createState() => _GetItPageState();
}

class _GetItPageState extends State<GetItPage> {
  @override
  void initState() {
    //시작할 때 모든 객체를 등록합니다.
    //나중에 액세스하려는 객체들을 이렇게 등록하세요:
    GetIt.I.registerSingleton<GetItProvider>(GetItProvider());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HomeGetIt();
  }
}
```

GetIt로 데이터를 읽는 것은 이미 간단합니다. 하지만 mixin을 추가하면 더욱 쉬워집니다. StatelessWidget에 GetItMixin을 추가하고 get`T`를 호출하면 됩니다:

<div class="content-ad"></div>

```js
class HomeGetIt extends StatelessWidget with GetItMixin {
  HomeGetIt({super.key});

  @override
  Widget build(BuildContext context) {
    // 보기 쉽게! view 가 rebuild 되기를 원할 때는 watchOnly 를 호출하여 상태가 변경될 때마다 알려줄 수 있습니다:
    final state =
        watchOnly((GetItProvider getItProvider) => getItProvider.state);

    return Scaffold(
      appBar: AppBar(title: const Text('GetIt 페이지')),
      body: Builder(
        builder: (context) {
          if (state == Status.initial) {
            return const Center(child: Text('버튼을 눌러보세요'));
          }
          if (state == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state == Status.success) {
            return const Center(child: Text('성공'));
          }
          return Container();
        },
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: const Icon(Icons.play_arrow),
            // 이후 아래와 같이 GetItProvider 클래스에 접근할 수 있습니다:
            onPressed: () => get<GetItProvider>().fecthData(),
          ),
        ],
      ),
    );
  }
}
```

보통 데이터 원본 타입에 대한 다양한 watch 메서드가 있습니다. ChangeNotifier, ValueNotifier, Stream 및 Future를 포함합니다.

watch 메서드의 주요 이점은 ValueListenableBuilders, StreamBuilder 등을 사용하지 않아도 된다는 것입니다. 각 바인딩마다 한 줄만 사용되며 중첩이 없으므로 가독성이 좋습니다.

<div class="content-ad"></div>

![alt text](/assets/img/2024-06-21-FlutterStateManagementProviderBLoCGetXRiverpodGetItandMobX_16.png)

## 장점

- 간단하고 사용하기 쉽며, Flutter에 의존하지 않아서 모든 Dart 코드와 함께 사용할 수 있습니다.
- 매우 빠르고 배우기/사용하기 쉽습니다. UI 트리를 특별한 위젯으로 엮지 않고 데이터에 액세스할 수 있습니다.

## 단점

<div class="content-ad"></div>

- 위젯 트리의 본질적인 부분이 아니기 때문에 항목을 수동으로 폐기하거나 등록 해제해야 할 수도 있습니다.
- 동일한 형식의 인스턴스를 제공하는 문제가 있지만 등록할 때 이름 필드를 노출하기 때문에 문제에 대한 합리적인 해결책을 제공합니다.
- GetIt 싱글톤의 전역적인 성격을 선호하지 않는 개발자들도 있을 수 있으며, 이는 riverpod나 Provider의 더 제한적인 스코핑 모델을 선호할 수도 있습니다. 다른 개발자들은 이것을 이점으로 생각할 수도 있습니다.

# MobX

MobX는 응용 프로그램의 반응형 데이터와 UI를 간단히 연결하는 상태 관리 라이브러리입니다. 이 연결은 완전히 자동적이며 매우 자연스럽게 느껴집니다. 응용 프로그램 개발자는 UI에서 (그리고 다른 곳에서) 소비해야 하는 반응형 데이터에 순수하게 집중할 뿐, 두 가지를 동기화할 필요없이 고민할 필요가 없습니다.

실제로 마법은 아니지만, 소비되는 것(observable)과 어디에서(reactions) 소비되는지에 관한 지혜가 있으며, 이를 자동으로 추적합니다. observable이 변경되면 모든 reactions가 다시 실행됩니다. 흥미로운 점은 이러한 reactions가 간단한 콘솔 로그에서 네트워크 호출 또는 UI 다시 렌더링까지 모두 될 수 있다는 것입니다.

<div class="content-ad"></div>

MobX의 핵심에는 Observables, Actions 및 Reactions이라는 세 가지 중요한 개념이 있습니다.

![image](/assets/img/2024-06-21-FlutterStateManagementProviderBLoCGetXRiverpodGetItandMobX_17.png)

## Observables

- Observables는 응용 프로그램의 반응형 상태를 나타냅니다. 단순 스칼라부터 복잡한 객체 트리까지 될 수 있습니다. 응용 프로그램의 상태를 Observables 트리로 정의함으로써, 반응형 상태 트리를 노출하여 UI(또는 응용 프로그램의 다른 관찰자)에서 사용할 수 있습니다.

<div class="content-ad"></div>

## 작업

- 작업은 옵저버를 변이시키는 방법입니다. 직접 변이시키는 대신 작업은 변이에 의미를 부여합니다. 예를 들어 value++를 하는 대신 increment() 작업을 실행하면 더 많은 의미가 전달됩니다. 또한, 작업은 모든 알림을 일괄 처리하고 변경 사항은 완료된 후에만 알림을 보내도록 보장합니다. 따라서 옵저버는 작업의 원자적 완료 후에만 알림을 받습니다.

## 반응

- 반응은 MobX의 옵저버, 작업 및 반응의 삼합체를 완성합니다. 이들은 반응형 시스템의 옵저버이며 추적 중인 옵저버가 변경될 때마다 알림을 받습니다. 반응에는 아래에 나열된 몇 가지 종류가 있습니다. 이들은 모두 ReactionDisposer를 반환하며, 이는 반응을 폐기하기 위해 호출할 수 있는 함수입니다. 반응의 두드러진 특징 중 하나는 옵저버를 명시적으로 연결하지 않아도 자동으로 모든 옵저버를 추적한다는 것입니다. 반응 내에서 옵저버를 읽는 행위만으로도 추적이 가능합니다!

<div class="content-ad"></div>

MobX의 스토어는 관련 observable 상태를 하나의 클래스 아래에 수집하는 방법입니다. 이 스토어를 사용하면 주석을 사용하고 코드를 간단하게 유지할 수 있습니다.

```js
enum Status {
  initial,
  loading,
  success,
}
```

```js
// 이것은 코드베이스의 나머지 부분에서 사용되는 클래스입니다.
// ignore: library_private_types_in_public_api
class DataStore = _DataStore with _$DataStore;

// 스토어 클래스
abstract class _DataStore with Store {
  @observable
  Status state = Status.initial;

  @action
  Future<void> fetchData() async {
    state = Status.loading;

    await Future.delayed(const Duration(seconds: 2));

    state = Status.success;
  }
}
```

주석을 사용하여 클래스의 observable 속성을 표시하는 방법에 유의하십시오. 주석은 mobx_codgen 패키지를 통해 사용할 수 있습니다.

<div class="content-ad"></div>

여기서 흥미로운 부분은:

- Store mixin을 포함하는 추상 클래스 \_DataStore입니다. 모든 스토어 관련 코드는 이 추상 클래스 내에 배치되어야 합니다. build_runner에서 코드를 조합하기 위해 DataStore 클래스를 생성합니다.
- 생성된 코드는 part 파일인 data*store.g.dart에 포함됩니다. 이를 part 지시문으로 포함해야 build_runner가 출력물을 생성합니다. 생성된 파일에는 *$DataStore mixin이 포함됩니다.
- 값을 observable로 표시하는 @observable 어노테이션.
- increment() 메서드를 action으로 표시하기 위한 @action 사용.

<img src="/assets/img/2024-06-21-FlutterStateManagementProviderBLoCGetXRiverpodGetItandMobX_18.png" />

프로젝트 폴더 내에서 다음 명령을 실행하세요. 이는 counter.g.dart에 코드를 생성하며, 이미 part 파일로 포함해 두었습니다.

<div class="content-ad"></div>

```js
flutter pub run build_runner build
```

이제 UI를 살펴보겠습니다:

```js
final dataStore = DataStore(); // 스토어를 인스턴스화합니다.

class MobXPage extends StatelessWidget {
  static const route = 'mobx-page';

  const MobXPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomeMobX();
  }
}
```

Observer 위젯(flutter_mobx의 일부)은 빌더 함수에서 사용된 observables의 세부적인 옵저버를 제공합니다. 이러한 observables이 변경될 때마다 Observer가 다시 빌드되고 렌더링됩니다.

<div class="content-ad"></div>

```js
class HomeMobX extends StatelessWidget {
  const HomeMobX({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MobX 페이지')),
      // 가능한 깊은 곳에 Consumer 위젯을 배치하는 것이 가장 좋습니다.
      // 어딘가의 세부 사항이 변경되어도 대규모 UI의 큰 부분을 다시 빌드하고 싶지 않을 것입니다.
      body: Observer(
        builder: (_) {
          if (dataStore.state == Status.initial) {
            return const Center(child: Text('버튼을 눌러주세요'));
          }
          if (dataStore.state == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (dataStore.state == Status.success) {
            return const Center(child: Text('성공'));
          }
          return Container();
        },
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: const Icon(Icons.play_arrow),
            onPressed: () => dataStore.fecthData(),
          ),
        ],
      ),
    );
  }
}
```

그 결과는:

<img src="/assets/img/2024-06-21-FlutterStateManagementProviderBLoCGetXRiverpodGetItandMobX_19.png" />

## 장점

<div class="content-ad"></div>

- 반응형 앱 데이터를 UI와 쉽게 연결할 수 있습니다.
- 학습을 쉽게하는 친숙한 구문과 간단한 핵심 API를 사용하여 옵저버 패턴을 구현합니다.
- 크고 복잡한 프로젝트에서 사용할 수 있으며 확장 가능합니다.
- 성능이 좋고 테스트하기 쉽습니다.
- 코드 생성 덕분에 보일러플레이트를 줄일 수 있습니다.

## 단점

- 코드 생성에 시간이 걸리고 상태 변경 시마다 코드 생성기를 실행해야 할 수도 있습니다.
- 상태가 변경될 때 어떤 이벤트가 그것을 일으킨 것인지 파악하기 어려울 수 있습니다. 복잡한 앱에서 이러한 추적 불가능성은 디버깅과 상태 관리를 어렵게 만들 수 있습니다.
- Mobx 생성기는 단순성을 높이는 데 좋지만 동시에 추상화 수준을 추가합니다. 이는 내부 작업을 실제로 보고 이해하기 어렵게 만듭니다.

# 결론

<div class="content-ad"></div>

- 상태 관리는 가장 중요한 측면 중 하나입니다. 이는 사용자가 UI에 가한 모든 변경 사항을 추적하는 방법입니다.
- Flutter의 상태 관리 라이브러리들은 상태 변경의 유형과 상관없이 애플리케이션을 개발하고 관리하기 쉽게 만들어 줍니다.
- 올바른 Flutter 상태 관리자를 선택하는 것은 사용하는 것만큼 중요합니다. 상태 관리자의 선택지는 다양하지만, 어떤 것을 사용할지 선택하는 것은 우리에게, 우리의 취향에, 편안한 느낌에, 또한 프로젝트 유형, 요구 사항에 달려 있습니다. 작은 프로젝트인 경우 한 가지 접근 방식을 사용할 수 있고, 확장 가능한 프로젝트를 만들고 싶다면 다른 접근 방식을 사용할 수 있습니다.

마침내 기대하던 것, 여기에서 전체 예제를 찾을 수 있습니다:

마음에 든다면 커피 한 잔 사주세요!

![이미지](/assets/img/2024-06-21-FlutterStateManagementProviderBLoCGetXRiverpodGetItandMobX_20.png)
