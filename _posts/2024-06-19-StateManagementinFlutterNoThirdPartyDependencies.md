---
title: "State Management in Flutter  외부 라이브러리 종속성 없이"
description: ""
coverImage: "/assets/img/2024-06-19-StateManagementinFlutterNoThirdPartyDependencies_0.png"
date: 2024-06-19 00:11
ogImage:
  url: /assets/img/2024-06-19-StateManagementinFlutterNoThirdPartyDependencies_0.png
tag: Tech
originalTitle: "State Management in Flutter — No Third Party Dependencies"
link: "https://medium.com/prolog-app/state-management-in-flutter-no-third-party-dependencies-847dbc0ed3d0"
---

<img src="/assets/img/2024-06-19-StateManagementinFlutterNoThirdPartyDependencies_0.png" />

저희가 네이티브 안드로이드 앱을 플러터로 이꟮리는 작업을 시작한 이후로, 프로젝트에 관한 많은 어럽한 결정을 내려야 했습니다. 네이티브 앱을 개발할 때 한 실수를 반복하지 않기 위해서였죠.

Flutter 환경에서 제공되는 모든 상태 관리 솔루션을 다뤄보고 어떤 것을 사용할지 결정해야 했습니다. 이 일은 실제로 힘들었습니다. Provider, Riverpod, Bloc, Cubit, MobX, GetX, Redux 등 다양한 옵션들이 있었기 때문이죠. 각각을 이해하는 데 많은 노력이 필요했고, 다양한 솔루션들을 읽고 시도한 뒤에 우리는 내부에서 너무 많은 마술이 일어나고 있다고 더 확신을 얻을 수 있었습니다.

조사를 진행하다가, 서드파티 라이브러리 없이 상태 관리를 하는 방법을 사용하는 많은 앱들이 상점에 있다는 것을 알게되는 기사를 찾았습니다. 좀 더 조사해보니, 플러터에서 상태 관리를 아주 멋지게 구현한 다른 기사도 찾았습니다. 이러한 콘텐츠에서 영감을 받아 우리는 서드파티 라이브러리 없이 솔루션을 찾기 위해 조사를 시작했습니다. 이어서 저희가 어떻게 앱에서 플러터의 네이티브 자원만을 사용하여 상태 관리를 구현했는지 알려드릴게요.

<div class="content-ad"></div>

## 앱 패턴

저희는 Flutter 앱의 아키텍처로 MVVM (Model-View-ViewModel) 패턴을 선택했습니다. 네이티브 안드로이드 앱에서 편안하게 사용했던 이 패턴을 Flutter 프로젝트에도 충분히 적용할 수 있다고 확신했기 때문입니다.

MVVM 패턴은 주로 세 가지 클래스로 구성됩니다:

- Model: 화면에 표시할 데이터를 보유하는 클래스입니다.
- View: Flutter에서는 이것이 화면을 나타내는 위젯입니다.
- ViewModel: 여기에는 로직이 포함됩니다. 화면(View)과의 모든 상호작용은 ViewModel에서 메소드 호출을 일으켜야 합니다.

<div class="content-ad"></div>

<img src="/assets/img/2024-06-19-StateManagementinFlutterNoThirdPartyDependencies_1.png" />

## MVVM과 플러터 네이티브 리소스 병합하기

우선적으로, 우리 예제를 구축하는 데 도움이 되는 몇 개의 클래스를 생성해야 합니다. 아래에는 우리 예제를 재현하기 위해 만들어야 하는 클래스들이 나와 있습니다:

- user_dto.dart: 이 파일에는 DTO(Data Transfer Object)를 나타내는 클래스가 포함됩니다.

<div class="content-ad"></div>

```js
class UserDto {
  final String name;

  UserDto({required this.name});
}
```

2. user_repository.dart: 이 파일은 HTTP 페치 요청을 담당하는 클래스가 위치할 것입니다.

```js
import 'package:teste_artigo/user_dto.dart';

class UserRepository {
  Future<UserDto> getUserData() async {
    // 사용자 데이터를 가져오는 시뮬레이션, API 호출일 수도 있습니다. 리포지토리 파일에 위치할 것입니다.
    await Future.delayed(const Duration(seconds: 2), () {});
    return UserDto(name: 'John Doe');
  }
}
```

그런 다음 우리는 MVVM 구조를 마칠 수 있습니다.

<div class="content-ad"></div>

ValueNotifier과 ValueListenableBuilder를 사용하여 Model, View 및 ViewModel 간의 연결을 설정했어요.

먼저 home_screen_state.dart 파일을 만들어볼게요. 각 화면에는 로딩 상태, 오류 상태, 성공 상태 등이 있습니다. 이러한 상태를 클래스 유형을 사용하여 구분할 거에요:

```js
abstract class HomeScreenState {}

class HomeScreenLoadingState extends HomeScreenState {}

class HomeScreenSuccessfulState extends HomeScreenState {
  final String userName;

  HomeScreenSuccessfulState(this.userName);
}

class HomeScreenErrorState extends HomeScreenState {
  final String errorMessage;

  HomeScreenErrorState(this.errorMessage);
}
```

우리는 원하는 만큼 많은 상태를 가질 수 있으며 각 상태는 필요한 변수를 가질 수 있어요. 심지어 abstract HomeScreenState 클래스 내에 공통 변수를 가질 수도 있어요.

<div class="content-ad"></div>

다음으로, ViewModel 클래스를 생성해야 합니다:

```js
import 'package:flutter/cupertino.dart';
import 'package:teste_artigo/home_screen_state.dart';
import 'package:teste_artigo/user_repository.dart';

class HomeScreenViewModel {
  var state = ValueNotifier<HomeScreenState>(HomeScreenLoadingState());
  final userRepository = UserRepository();

  Future<void> onInit() async {
    _tryToFetchUserData();
  }

  Future<void> onRefreshUserData() async {
    _tryToFetchUserData();
  }

  Future<void> _tryToFetchUserData() async {
    try {
      state.value = HomeScreenLoadingState();
      final response = await userRepository.getUserData();
      state.value = HomeScreenSuccessfulState(response.name);
    } catch (e) {
      state.value = HomeScreenErrorState('An error occurred');
    }
  }
}
```

이 클래스에서 우리는 공개 메서드 이름이 UI 클래스에 대한 콜백을 나타내는 것을 확인할 수 있습니다. 메서드 이름에서 사용자 데이터를 가져올 것이라는 것을 명시적으로 명시하지 않습니다.
대신, UI가 초기화되거나 사용자 데이터를 새로 고침하길 요청할 때 특정 메서드가 호출되어야 함을 간단히 나타냅니다. 로직은 UI에서 숨어 있는 비공개 메서드인 `_tryToFetchUserData` 메서드 내부에 있습니다.

또한, 데이터를 업데이트해야 할 때 적절한 상태 유형 및 매개변수와 함께 state 변수의 값을 업데이트해야 함을 알 수 있습니다.
이 변수는 스트림입니다. 이미 변경되면 청취자에게 알리는 책임을 지고 있습니다.

<div class="content-ad"></div>

마지막으로 UI가 있습니다:

```js
import 'package:flutter/material.dart';
import 'package:teste_artigo/home_screen_view_model.dart';

import 'home_screen_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({key});

  @override
  State<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  late final HomeScreenViewModel _vm;

  @override
  void initState() {
    super.initState();
    _vm = HomeScreenViewModel();
    _vm.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('상태 관리'),
      ),
      floatingActionButton: _buildFloatingActionButton(),
      body: _buildBody(),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () => _vm.onRefreshUserData(),
      tooltip: '새로 고침',
      child: const Icon(Icons.refresh),
    );
  }

  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ValueListenableBuilder(
          valueListenable: _vm.state,
          builder: (context, state, _) {
            switch (state.runtimeType) {
              case HomeScreenLoadingState:
                return const Center(child: CircularProgressIndicator());
              case HomeScreenSuccessfulState:
                final successfulState = state as HomeScreenSuccessfulState;
                return Center(child: Text(successfulState.userName));
              case HomeScreenErrorState:
                final errorState = state as HomeScreenErrorState;
                return Center(child: Text(errorState.errorMessage));
              default:
                return Container();
            }
          },
        )
      ],
    );
  }
}
```

ValueListenableBuilder 내에서 "마법"이 일어납니다: 상태의 유형에 따라 특정 위젯을 렌더링하여 표시합니다.

빌더 함수는 ViewModel에서 상태 변수가 변경될 때마다 호출되므로 setState를 호출하거나 다른 작업을 걱정할 필요가 없습니다. 코드의 더 깊은 부분에서 ValueListenableBuilder를 사용하여 전체 화면을 다시 렌더링하는 것을 피할 수도 있습니다. 그러나 중요한 점은 그것이 필요하지 않다는 것입니다: Flutter는 이미 전체 화면을 렌더링하도록 최적화되어 있으며, setState를 사용하여 화면을 업데이트하도록 만들어졌기 때문에 기존에 렌더링 된 것을 다시 렌더링하는 방법을 알고 있습니다.

<div class="content-ad"></div>

## 결론

이게 다에요! 별도의 외부 의존성이 없어 매우 간단해요.

이것은 아주 간단한 예시라는 것을 이해합니다. 더 복잡한 화면을 만들기 시작하면 더 많은 질문이 생겨나고, 이렇게 간단한 해결책을 유지하는 것이 더 어려워질 수도 있습니다. 그러나 저희는 이 방법을 성공적으로 사용하여 매우 복잡한 화면을 만들고 있습니다 (실제로 회사의 주요 제품인 전체 앱을 Flutter로 이주 중이기도 합니다), 그리고 이 방법이 저희에게 아주 잘 작동하고 있어요.

의문이 있거나 의견을 주고 싶다면, 언제든지 LinkedIn에서 제게 직접 메시지를 남겨주세요. 언제든지 대화를 나누기 위해 친절히 준비되어 있을게요.

<div class="content-ad"></div>

이 예제의 코드는 이 저장소에서 찾을 수 있어요.
