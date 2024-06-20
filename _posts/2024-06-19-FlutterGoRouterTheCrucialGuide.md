---
title: "플러터 Go 라우터 필수 가이드"
description: ""
coverImage: "/assets/img/2024-06-19-FlutterGoRouterTheCrucialGuide_0.png"
date: 2024-06-19 08:13
ogImage: 
  url: /assets/img/2024-06-19-FlutterGoRouterTheCrucialGuide_0.png
tag: Tech
originalTitle: "Flutter Go Router : The Crucial Guide"
link: "https://medium.com/@vimehraa29/flutter-go-router-the-crucial-guide-41dc615045bb"
---



![FlutterGoRouter](/assets/img/2024-06-19-FlutterGoRouterTheCrucialGuide_0.png)

Go_router은 Flutter에서 라우팅을 위한 서드 파티 패키지로, 기본 플러터 라우팅 옵션보다 더 유연하고 사용하기 쉬운 솔루션을 제공하기 위해 만들어졌습니다. 라우트가 어떻게 정의되고 관리되는지에 대해 더 많은 제어를 원하는 경우 유용할 수 있습니다. 또한 웹에 대한 좋은 지원을 제공하기 때문에 애플리케이션에 좋은 선택일 수 있습니다.

URL 패턴을 정의하고, URL을 사용하여 탐색하며, 딥 링크를 처리하고, 기타 여러 네비게이션 관련 시나리오를 다룰 수 있습니다.

# 특징


<div class="content-ad"></div>

고 라우터(GoRouter)는 네비게이션을 간단하게 만들기 위한 다양한 기능을 제공합니다:

- Navigator API와의 하위 호환성
- Material 및 Cupertino 앱을 지원
- StatefulShellRoute를 사용하여 중첩된 탭 탐색 지원
- 목적지에 대한 여러 화면 표시 (하위 라우트)
- 템플릿 구문을 사용하여 경로 및 쿼리 매개변수 구문 분석
- 리디렉션 지원 — 사용자를 다른 URL로 리디렉션할 수 있으며,예를 들어 사용자가 인증되지 않은 경우에는 로그인 페이지로 이동할 수 있습니다.

# 시작하기

시작하려면 pubspec.yaml에 go_router를 추가하세요. 이 문서에서는 ^13.2.0을 사용하겠습니다.

<div class="content-ad"></div>

```yaml
dependencies:
  go_router: ^13.2.0
```

# 라우트 구성

이제 그렇게 한 다음에 GoRouter 구성을 앱에 추가해 봅시다:

```dart
import 'package:go_router/go_router.dart';

// GoRouter 구성
final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'home', // 선택사항, 라우트에 이름 추가. 경로 대신 이름으로 이동 가능
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      name: 'shope',
      path: '/shope',
      builder: (context, state) => ShopeScreen(),
    ),
  ],
);
```

<div class="content-ad"></div>

그럼 MaterialApp.router 또는 CupertinoApp.router 생성자를 사용하고 routerConfig 매개변수를 GoRouter 구성 객체로 설정할 수 있어요:

```js
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
```

이것으로 준비 끝이에요 🙂 go_router를 사용해보세요 !!!

# 매개변수

<div class="content-ad"></div>

경로 매개변수를 지정하려면 경로 세그먼트 앞에 콜론(:) 문자를 붙이고 고유한 이름(:userId와 같은)을 따라야 합니다. 빌더 콜백에 제공된 GoRouterState 객체를 통해 매개변수 값을 액세스할 수 있습니다:

```js
GoRoute(
  path: '/fruits/:id',
  builder: (context, state) {
     final id = state.pathParameters["id"]! // URL에서 "id" 매개변수 가져오기
     return FruitsPage(id: id);
  },
),
```

# 하위 루트 추가

일치하는 경로는 네비게이터에서 여러 화면이 표시되는 결과를 가져올 수 있습니다. 이는 push()를 호출한 것과 동일한 효과이며, 새 화면이 이전 화면 위에 표시되고 AppBar 위젯에 인앱 뒤로 가기 버튼이 제공됩니다.

<div class="content-ad"></div>

다음과 같이 부모 라우트와 그 자식 라우트를 추가해 보세요:

```js
GoRoute(
  path: '/fruits',
  builder: (context, state) {
    return FruitsPage();
  },
  routes: <RouteBase>[ // 자식 라우트 추가
    GoRoute(
      path: 'fruits-details', // 참고: 라우터의 부모에 "/" 문자를 명시할 필요가 없습니다.
      builder: (context, state) {
        return FruitDetailsPage();
      },
    ),
  ],
)
```

# 화면 간 이동

go_router를 사용하여 목적지 간에 이동하는 다양한 방법이 있습니다.

<div class="content-ad"></div>

새 화면으로 이동하려면 URL과 함께 context.go()를 호출하십시오:

```js
build(BuildContext context) {
  return TextButton(
    onPressed: () => context.go('/fruits/fruit-detail'),
  );
}
```

URL 대신 이름을 사용하여 탐색할 수도 있습니다. context.goNamed()를 호출하면 됩니다.

```js
build(BuildContext context) {
  return TextButton(
    // 라우트에 "name"을 추가하지 않으면 오류가 발생할 수 있습니다
    onPressed: () => context.goNamed('fruit-detail'),
  );
}
```

<div class="content-ad"></div>

URI에 경로 매개변수를 포함하여 만들려면 Uri 클래스를 사용할 수 있어요:

```js
context.go(
  Uri(
    path: '/fruit-detail',
    pathParameters: {'id': '10'},
  ).toString(),
);
```

context.pop()을 사용하면 현재 화면에서 뒤로 이동할 수 있어요.

# 중첩된 탭 탐색

<div class="content-ad"></div>

일부 앱은 화면의 하위 섹션에 목적지를 표시합니다. 예를 들어, 화면 간을 이동할 때 항상 화면 상에 남아 있는 BottomNavigationBar와 같은 경우입니다.

StatefulShellRoute를 사용하여 중첩된 탐색을 설정했습니다.

이 StatefulShellRoute 클래스는 루트 네비게이터와 다른 네비게이터에 하위 루트를 배치합니다. 그러나 이 루트 클래스는 각 중첩 분기에 대해 별도의 네비게이터를 생성하므로 (즉, 병렬 탐색 트리), 상태가 있는 중첩된 네비게이션을 구축할 수 있습니다.

예를 들어 BottomNavigationBar를 구현하는 경우, 각 탭에 대한 지속적인 네비게이션 상태가 있는 UI를 구현하는 것이 편리합니다.

<div class="content-ad"></div>

상태 유지 쉘 라우트는 상태 유지 브랜치를 나타내는 각각의 StatefulShellBranch 항목 목록을 지정하여 생성됩니다. StatefulShellBranch는 브랜치를 위한 루트 라우트와 네비게이터 키 (GlobalKey) 및 선택적 초기 위치를 제공합니다.

구현 방법을 살펴보겠습니다 🙂

먼저 라우터를 만들어 시작합니다. StatefulShellRoute.indexedStack()을 라우트에 추가할 것이며, 이 클래스는 중첩된 내비게이션을 생성하는 역할을 맡게 됩니다.

StatefulShellRoute.indexedStack()은 중첩된 네비게이터에 IndexedStack을 사용하는 StatefulShellRoute를 생성합니다.

<div class="content-ad"></div>

이 생성자는 분기 네비게이터를 나타내는 위젯을 관리하는 컨테이너(navigatorContainerBuilder)에 대한 IndexedStack 기반 구현을 제공합니다.

```dart
// `root` 및 `section` 네비게이터를 위한 키 생성하여 불필요한 재구성을 피합니다
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey = GlobalKey<NavigatorState>();


final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // 커스텀 쉘(예: BottomNavigationBar)을 구현하는 위젯을 반환합니다.
        // 다른 분기로 상태를 유지하면서 이동할 수 있도록 [StatefulNavigationShell]이 전달됩니다.
        return ScaffoldWithNavbar(navigationShell);
      },
      branches: [
        // 1번 탭을 위한 루트 분기
        StatefulShellBranch(
          navigatorKey: _sectionNavigatorKey,
          // 이 분기의 루트 추가
          // 가능한 경우 하위 루트가 있는 각 루트(예: feed/uuid/details)를 추가합니다
          routes: <RouteBase>[
            GoRoute(
              path: '/shope',
              builder: (context, state) => const ShopePage(),
              routes: <RouteBase>[
                GoRoute(
                  path: 'detail',
                  builder: (context, state) => const FeedDetailsPage(),
                )
              ],
            ),
          ],
        ),

        // 2번 탭을 위한 루트 분기
        StatefulShellBranch(routes: <RouteBase>[
          // 이 분기의 루트 추가
          // 가능한 경우 하위 루트가 있는 각 루트(예: shope/uuid/details)를 추가합니다
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomePage(),
          ),
        ])
      ],
    ),
  ],
);
```

우리의 루트에 StatefulShellRoute.indexedStack()를 추가했습니다. 이것은 우리의 분기를 생성하고 사용자 정의 쉘(이 경우 BottomNavigationBar)을 반환합니다.

- 빌더: (context, state, navigationShell)에서는 사용자 정의 쉘인 Scaffold with BottomNavigationBar를 반환하며, 이 페이지로 이동할 때 navigationShell을 전달해야 합니다(예: Shope == Home).
- branches:[]에서는 StatefulShellBranch(분기) 목록을 제공합니다. 이전에 생성한 _sectionNavigatorKey를 첫 번째 분기에 navigatorKey 속성으로 전달하지만, 다른 분기에는 기본 키가 사용됩니다. 또한 해당 분기에 대한 지원 루트 목록인 RouteBase 목록을 제공합니다.

<div class="content-ad"></div>

우리의 빌더가 커스텀 쉘을 반환하는 것을 확인할 수 있습니다. 이 쉘에는 BottomNavigationBar가 포함되어 있어요. 그러니 이제 그것을 만들어 봅시다. 👇🏿

```js
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavbar extends StatelessWidget {
  const ScaffoldWithNavbar(this.navigationShell, {super.key});

  /// 브랜치 네비게이터를 위한 네비게이션 쉘 및 컨테이너입니다.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Shope'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        ],
        onTap: _onTap,
      ),
    );
  }

  void _onTap(index) {
    navigationShell.goBranch(
      index,
      // 바텀 네비게이션 바를 사용할 때 일반적인 패턴은 현재 활성화된 아이템을 탭했을 때 초기 위치로 이동하는 것을 지원하는 것입니다. 이 예제에서는 goBranch의 initialLocation 매개변수를 사용하여 이 동작을 지원하는 방법을 보여줍니다.
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
```

기본적으로 BottomNavigationBar가 있는 Scaffold를 반환하며, 본문은 라우터에서 얻은 navigationShell이 될 것입니다.

또한 `_onTap(index)`가 있습니다. 여기서는 `navigationShell.goBranch(index)`를 사용하여 브랜치 간에 전환할 수 있습니다.

<div class="content-ad"></div>

그럼 이제 여러분의 프로젝트에 이를 구현할 준비가 끝났어요 🥳🎉

자세한 예시는 아래의 저장소를 확인해주세요 👇🏿

# Guards

특정 경로를 보호하기 위해, 예를 들어 인증되지 않은 사용자로부터, GoRouter를 통해 전역 리디렉션이 설정될 수 있습니다. 가장 일반적인 예는 /login이 아닌 모든 경로를 보호하는 리디렉트 설정이며, 사용자가 인증되지 않은 경우 /login으로 리디렉트됩니다.

<div class="content-ad"></div>

리다이렉션은 GoRouterRedirect 유형의 콜백입니다. 일부 응용 프로그램 상태에 따라서 들어오는 위치를 변경하려면 GoRouter 또는 GoRoute 생성자에 콜백을 추가하세요:

```js
GoRouter(
  redirect: (BuildContext context, GoRouterState state) {
    final isAuthenticated = // 사용자가 인증되었는지 확인하는 논리를 여기에 작성하세요
    if (!isAuthenticated) {
      return '/login';
    } else {
      return null; // 리디렉트 없이 의도한 경로를 표시하려면 "null"을 반환하세요
    }
  },
  ...
```

- GoRouter 생성자에서 리다이렉트를 정의할 수 있습니다. 모든 탐색 이벤트보다 먼저 호출됩니다.
- GoRoute 생성자에서 리다이렉트를 정의할 수 있습니다. 탐색 이벤트가 경로를 표시하기 직전에 호출됩니다.

# 전환 애니메이션

<div class="content-ad"></div>

GoRouter를 사용하면 각 GoRoute에 대한 전환 애니메이션을 사용자 정의할 수 있어요. 사용자 정의 전환 애니메이션을 구성하려면 GoRoute 생성자에 pageBuilder 매개변수를 제공하세요:

```js
GoRoute(
  path: '/fruit-details',
  pageBuilder: (context, state) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: FruitDetailsScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // 애니메이션의 값에 따라 화면의 불투명도를 변경합니다. 
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
          child: child,
        );
      },
    );
  },
),
```

전체 예제는 전환 애니메이션 샘플을 참조하세요.

# 에러 처리 (404 페이지)

<div class="content-ad"></div>

기본적으로, go_router는 MaterialApp 및 CupertinoApp용 기본 오류 화면과 사용되지 않는 경우의 기본 오류 화면이 함께 제공됩니다. 또한 errorBuilder 매개변수를 사용하여 기본 오류 화면을 대체할 수도 있습니다:

```js
GoRouter(
  /* ... */
  errorBuilder: (context, state) => ErrorPage(state.error),
);
```

# 이전에 이동하기 전에 !!

go_router에는 아직도 좋은 기능이 있습니다. GoRouter에 NavigatorObserver를 추가하여 Navigator의 동작을 관찰하고 route가 푸시, 팝 또는 대체될 때마다 알림을 받습니다. 이를 위해 NavigatorObserver를 확장하는 클래스를 만들어 보겠습니다:

<div class="content-ad"></div>

```dart
class MyNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('did push route');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('did pop route');
  }
```

이제 MyNavigatorObserver를 GoRouter에 추가해 봅시다.

```dart
GoRouter(
  ...
  observers: [ // 내비게이터 옵저버 추가
    MyNavigatorObserver(),
  ],
...
)
```

이벤트가 발생하면 내비게이터에 알림이 전달됩니다.
