---
title: "Flutter에서 Go Router를 사용해 타입-안전 내비게이션 구현하는 방법"
description: ""
coverImage: "/assets/img/2024-06-22-HowtoImplementType-SafeNavigationwithGoRouterinFlutter_0.png"
date: 2024-06-22 04:10
ogImage: 
  url: /assets/img/2024-06-22-HowtoImplementType-SafeNavigationwithGoRouterinFlutter_0.png
tag: Tech
originalTitle: "How to Implement Type-Safe Navigation with Go Router in Flutter"
link: "https://medium.com/canopas/how-to-implement-type-safe-navigation-with-go-router-in-flutter-b11315bd183b"
---


## Flutter에서 안전한 탐색: Go Router 및 Go Router Builder와 함께하는 가이드

<img src="/assets/img/2024-06-22-HowtoImplementType-SafeNavigationwithGoRouterinFlutter_0.png" />

# 배경

타입 안전한 네비게이션을 사용하면 탐색 로직이 일관되고 유지보수가 용이해지며 디버깅 및 향후 코드 수정이 상당히 간단해집니다.

<div class="content-ad"></div>

이 기술은 웹용 Flutter 앱을 구축할 때 특히 유용합니다. URL을 원활하게 관리하고 부드러운 네비게이션 경험을 보장해줍니다.

이 블로그에서는 go_router 및 go_router_builder 패키지를 사용하여 Flutter에서 유형 안전한 네비게이션을 구현하는 방법을 살펴볼 것입니다.

종료까지, 유형 안전한 라우트 설정, 코드 생성 및 Flutter 애플리케이션에서 네비게이션을 관리하는 방법에 대해 포괄적으로 이해하게 될 것입니다.

# 소개

<div class="content-ad"></div>

타입 안전한 네비게이션을 사용하면 네비게이션 로직이 일관되고 오류가 없음을 보장합니다.

매개변수를 잘못 구문 분석하거나 경로 이름과 매개변수에 오타를 쓰는 위험을 제거하여 코드를 유지 관리하기 쉽고 디버깅하기 쉬운 상태로 유지할 수 있습니다.

웹을 대상으로 하는 플러터 앱을 개발할 때 타입 안전한 네비게이션을 사용하여 URL을 쉽게 관리할 수 있습니다.

이 블로그를 통해 최종적으로 얻을 것은 무엇인가요?

<div class="content-ad"></div>

마크다운 형식으로 테이블 태그를 변경해주세요.

<div class="content-ad"></div>

우리는 우리가 반복적으로 하는 것이다. 훌륭함은 행위가 아니라 습관이다. Justly를 시도해보고 오늘부터 당신의 습관을 만들어보세요!

# 시작해봅시다

전체를 5단계로 나눠서 더 잘 이해할 수 있도록 설명해 드리겠습니다.

## 단계 1: 의존성 추가

<div class="content-ad"></div>

프로젝트의 pubspec.yaml 파일에 종속성을 추가해주세요.

```yaml
dependencies:
  # Router API 기반의 내비게이션을 활용하기 위해 필요합니다.
  go_router: <최신 버전> 

dev_dependencies:
  # go_router와 함께 타입 안전한 경로를 생성하기 위한 도구입니다.
  go_router_builder: <최신 버전>
  # go_router_builder의 코드 생성을 실행하는 도구입니다.
  build_runner: <최신 버전>
```

## 단계 2: 경로 정의

이제 각 화면에 대한 클래스를 만들어 GoRouteData로 확장하고, 최상위 경로에 @TypedGoRoute() 주석을 추가해주세요.

<div class="content-ad"></div>

모든 클래스를 하나의 파일에 작성하여 코드 생성을 보다 쉽게 할 수 있도록 해 보세요.

```js
@TypedGoRoute<HomeRoute>(
  path: '/',
  routes: [
    TypedGoRoute<ItemDetailsRoute>(path: 'items/:id')
  ],
) 
class HomeRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) 
    => const HomeScreen();
}

class ItemDetailsRoute extends GoRouteData {
  final String id;
  const ItemDetailsRoute({required this.id});

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ItemDetailsScreen(id: id);
}

@TypedGoRoute<SignInRoute>(
  path: '/sign-in',
  routes: [
    TypedGoRoute<VerifyOtpRoute>(path: "verify"),
  ], 
)
class SignInRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SignInScreen();
}

class VerifyOtpRoute extends GoRouteData {
  final String $extra;

  const VerifyOtpRoute({required this.$extra});

  @override
  Widget build(BuildContext context, GoRouterState state) => 
     VerifyOtpScreen(verificationId: $extra);
}
```

이 코드에서는 각 화면에 대한 클래스를 GoRouteData를 확장하고 TypedGoRoute로 주석 처리하여 생성했습니다. 또 다른 화면으로 데이터를 전달하기도 했습니다.

자세히 살펴보겠습니다.

<div class="content-ad"></div>

GoRouteData: GoRouteData은 화면이나 페이지를 반환하거나 사용자를 다른 페이지로 리디렉션하는 메서드를 오버라이드할 수 있는 추상 클래스입니다. 이 메서드들 중 하나를 반드시 사용해야 합니다.

```js
class HomeRoute extends GoRouteData {

  // 이렇게 parentNavigationKey를 정의할 수 있습니다. (선택 사항)
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    // 여기서 반환된 위젯은 사용자가 이 경로로 이동할 때 표시됩니다.
    return const HomeScreen();
}
  
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    // 여기서 반환된 Page는 사용자가 이 경로로 이동할 때 표시됩니다.
    // 여기서 CustomTransitionPage를 반환하여 페이지 전환을 설정할 수도 있습니다.
    return const CupertinoPage(child: HomeScreen());
  }

  @override
  String? redirect(BuildContext context, GoRouterState state){
      // 여기서 이 경로로 이동할 때 사용자를 리디렉션해야 할 위치나 경로를 지정할 수 있습니다.
      return "/login";
      // 리디렉션을 막으려면 null을 반환하세요.
  }
}
```

TypedGoRoute: TypedGoRoute 어노테이션은 경로 트리를 정의하는 데 사용됩니다. 맨 위 수준 경로 클래스마다 TypedGoRoute를 사용하여 경로 목록을 생성해야 합니다.

```js
@TypedGoRoute<TopLevelRoute>(
  path: '/top-level-route-path',
  routes: [
    // 여기에 서브 루트 어노테이션을 이렇게 정의할 수 있습니다.
    TypedGoRoute<SubRoute>(
        path: 'sub-route-path'
        routes: []
        name: 'sub route'
    )
  ],
  name: 'top level route' // 선택 사항
)
```

<div class="content-ad"></div>

```js
@TypedGoRoute<MyRouteGeneric>()
```

이제 쿼리 매개변수, 경로 매개변수 및 라우트에서 추가 매개변수를 어떻게 사용할 수 있는지 알아봅시다.

경로 매개변수:

- 경로 매개변수는 : 기호를 사용하여 라우트 경로 내에 정의됩니다 (예: /products/:id).
- URL 구조의 특정 부분을 나타냅니다.

<div class="content-ad"></div>

쿼리 매개변수:

- URL 뒤에 ? 기호를 붙여 데이터를 추가합니다 (예: /products?category=electronics).
- 요청을 수정하는 선택적인 필터와 같은 데이터에 사용됩니다.

추가: 경로나 쿼리 매개변수로 캡처되지 않는 경로로 데이터를 전달하는 방법, 추가 개체를 전달할 수 있습니다.

```js
@TypedGoRoute<ProductDetailsRoute>(path: '/details/:id')
class ProductDetailsRoute extends GoRouteData {
  // path에 정의된 변수 이름이 경로 매개변수로 사용됩니다.
  final String id; 

  // path에 정의되지 않은 변수 이름은 쿼리 매개변수로 사용됩니다.
  final String code;

  // 추가 데이터를 사용하려면 변수 이름을 $extra로 설정해야 합니다.
  final String $extra;
  
  const ProductDetailsRoute({required this.id, required this.code, required this.$extra});

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ProductDetails(pathParameterId: id, queryParameterCode:code, extraData: $extra);
}
```

<div class="content-ad"></div>

## 단계 3: 코드 생성

루트를 정의한 후에는 루트 목록과 확장을 생성해야 합니다. 이를 위해 build_runner를 사용해야 합니다.
현재 파일에 생성된 파일 파트를 추가해 보겠습니다.

```js
part 'routes.g.dart'; //part '<current-file>.g.dart';
```

이제 build_runner 명령어를 실행해 봅시다.

<div class="content-ad"></div>

```dart
dart run build_runner build --delete-conflicting-outputs
```

현재 파일 디렉토리에 routes.g.dart 파일이 생성됩니다.

## 단계 4: GoRouter 초기화

이제 $appRoutes를 routes에 전달할 수 있으며, 생성된 location getter를 사용하여 정확한 경로 위치를 가져올 수 있습니다.

<div class="content-ad"></div>

```dart
최종 라우터는 GoRouter(
  initialLocation: HomeRoute().location, // location getter is generated.
  //$appRoutes is generated
  routes: $appRoutes,
  redirect: (context, state) { // Optional
    // 여기서 경로 위치를 반환하여 리디렉션이 가능합니다.
    // 또한 사용자가 검색 URL을 통해 화면으로 이동하는 것을 방지할 수도 있습니다.
    // 리디렉트를 방지하려면 null을 반환합니다.
  }
  errorBuilder: (context, e) => ErrorScreen(e), // Optional
  navigatorKey: rootNavigationKey, //Optional
);
```

## 단계 5: 다른 화면으로 이동

이제 라우트를 설정했으니, 다른 화면으로 이동하는 네비게이션 방법을 살펴봅시다.

## Go:

<div class="content-ad"></div>

현재 화면 스택을 주어진 경로 대상으로 교체해주세요.

```js
await Screen2Route(id: id).go(context);
```

![이미지](https://miro.medium.com/v2/resize:fit:1000/1*ZO9gaACCAYOszpSV1_gbKQ.gif)

## 푸시:

<div class="content-ad"></div>

페이지 스택에 위치를 푸시하세요.

```js
await Screen2Route(id: id).push(context);

// push 과정에서 값 반환도 가능합니다
final result = await Screen2Route(id: id).push(context);
```

<img src="https://miro.medium.com/v2/resize:fit:1000/1*_xSN1WMXDp7Oc92CBl6HMA.gif" />

## Push Replacement:

<div class="content-ad"></div>

가장 위에 있는 페이지 스택을 해당 URL 위치로 대체합니다.

```js
await Screen2Route(id: id).pushReplacement(context);
```

![이미지](https://miro.medium.com/v2/resize:fit:1000/1*GNaChKuABcE4PejKUFFe9A.gif)

## 대체:

<div class="content-ad"></div>

가장 상단의 스택 페이지를 주어진 페이지로 교체하지만, 동일한 페이지로 취급합니다.

```js
await Screen2Route(id: id).replace(context);
```

![이미지](https://miro.medium.com/v2/resize:fit:1000/1*_S9SyTnfBPEFAUMNloXz1g.gif)

이제 네비게이션 구현을 마쳤습니다. 👏

<div class="content-ad"></div>


![image](https://miro.medium.com/v2/resize:fit:1000/0*QwBEMwvqVkuL2OUM.gif)

Now, let’s take a look at how we can implement a shell route with type-safe navigation using go_router and go_router_builder.

## Related Articles

We're grateful to have you on this journey with us!


<div class="content-ad"></div>

만약 읽은 내용이 마음에 드신다면, 아래에 👏 👏👏를 꼭 눌러주시기 바랍니다. 작가로서 이것은 정말 소중한 일이에요!

아래 댓글 섹션에서 의견을 공유해주세요. 여러분의 의견은 콘텐츠를 더욱 풍부하고 가치 있는 것으로 만들어주며, 더 많은 유익한 기사를 작성할 동기를 얻게 해줍니다.

흥미로운 기사 업데이트를 받으시려면 Canopas를 팔로우해주세요!