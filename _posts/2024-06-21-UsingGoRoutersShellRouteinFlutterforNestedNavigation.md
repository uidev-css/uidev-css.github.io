---
title: "Flutter에서 GoRouter의 ShellRoute로 중첩 네비게이션 구현 방법"
description: ""
coverImage: "/assets/img/2024-06-21-UsingGoRoutersShellRouteinFlutterforNestedNavigation_0.png"
date: 2024-06-21 20:39
ogImage: 
  url: /assets/img/2024-06-21-UsingGoRoutersShellRouteinFlutterforNestedNavigation_0.png
tag: Tech
originalTitle: "Using GoRouter’s ShellRoute in Flutter for Nested Navigation"
link: "https://medium.com/@ahm4d.bilal/using-gorouters-shellroute-in-flutter-for-nested-navigation-777a9a20642f"
---


안녕하세요 개발자 여러분!

최근 go_router와 그 새로운 기능인 ShellRoute를 사용하여 영속하는 하단 내비게이션 바를 갖춘 중첩된 내비게이션 기능을 개발했는데, 예상대로 잘 작동합니다.

여러분, 제가 보스같이 해내는 걸 한번 보여드릴게요. (Valorant의 Pheonix 대사입니다.)

<img src="https://miro.medium.com/v2/resize:fit:1400/1*qQvZYaN08kuIFrN6dQEskg.gif" />

<div class="content-ad"></div>

# 1. 소개:

## GoRouter

go_router은 Flutter 앱 개발을 위한 패키지로, 앱 내에서 네비게이션을 처리하는 강력하고 유연한 방법을 제공합니다. 이 패키지는 라우터 시스템을 제공하여 앱 내에서 라우트를 정의하고 특정 위젯에 매핑할 수 있습니다. 그 중요한 기능 중 하나는 ShellRoute인데, 이는 앱 내에서 다양한 화면 또는 탭 간에 전환할 수 있는 지속적인 하단 네비게이션 바를 제공합니다.

## ShellRoute

<div class="content-ad"></div>

go_router의 ShellRoute 기능을 사용하면 부모 경로를 만들어 하단 네비게이션 바를 추가할 수 있어요. 그리고 각 탭이나 스크린으로 표시되는 다양한 하위 경로를 표시할 수 있습니다. 이 기능은 go_router v7.0.0에서 소개되었어요. 이를 통해 여러 화면을 왔다갔다 할 필요 없이 앱의 다른 섹션이나 기능 사이를 쉽게 이동할 수 있습니다. ShellRoute는 또한 각 화면의 상태를 유지하면서 다른 탭이나 스크린 간에 쉽게 전환할 수 있게 해줍니다.

전반적으로 go_router 패키지와 ShellRoute 기능은 Flutter 앱에서 네비게이션을 처리하는 강력하고 유연한 방법을 제공해주며, 앱의 다른 섹션이나 기능 사이를 전환하는 사용자 친화적이고 직관적인 방법을 제공합니다.

## 지속적인 하단 네비게이션 바의 중요성

잘 디자인된 지속적인 하단 네비게이션 바는 사용자 경험을 크게 향상시키고 앱을 더 사용자 친화적으로 만들 수 있어요. 사용자가 앱의 다양한 섹션과 기능을 쉽게 탐색할 수 있도록 도와주어 참여도와 유지율을 향상시킬 수 있습니다. 게다가 지속적인 하단 네비게이션 바는 앱에 더 깔끔하고 전문적인 느낌을 줄 수 있어서 전반적인 브랜드 이미지를 개선할 수 있습니다.

<div class="content-ad"></div>

요약하면, Flutter 앱에서 지속적인 하단 탐색 바는 쉬운 네비게이션을 제공하고 사용자 경험을 향상시키는 중요한 디자인 요소입니다.

![이미지](https://miro.medium.com/v2/resize:fit:800/1*n6GetP4BlzpIwFIHJezhng.gif)

# 2. 준비물:

- PC에 최신 Flutter SDK가 설치되어 있는지 확인하세요
- 다음 명령어를 실행하여 새 Flutter 프로젝트를 생성하세요:

<div class="content-ad"></div>

```js
플러터 create go_router_demo
```

3. 프로젝트에 go_router를 추가하려면 다음 명령을 실행하세요:

```js
flutter pub add go_router
```

# 3. 하단 네비게이션 바 스캐폴드:

<div class="content-ad"></div>

부모 화면을 만들어서 하단 네비게이션 바를 유지할 거에요. 이 화면은 자식 위젯을 인자로 받을 거에요. 이 자식 위젯을 이용해서 앱의 자식 경로를 표시하고, 하단 네비게이션 바를 모든 자식 경로에 계속 유지할 거에요.

```js
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        onTap: changeTab,
        backgroundColor: const Color(0xffe0b9f6),
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
        ],
      ),
    );
  }
```

changeTab 함수는 홈 및 채팅 탭 간에 이동하는 것을 다룰 거에요.

```js
void changeTab(int index) {
    switch(index){
      case 0:  
        context.go('/');
        break;
      case 1:  
        context.go('/chat');
        break;
      default:
        context.go('/');
        break;
    }
    setState(() {
      currentIndex = index;
    });
  }
```

<div class="content-ad"></div>


![image](https://miro.medium.com/v2/resize:fit:492/1*OsfeWqkayJSX0KYe-74j3Q.gif)

# 4. 라우터 설정하기:

여기서 모든 마법이 일어납니다.

이 가이드를 위해 4개의 페이지를 만들었습니다:


<div class="content-ad"></div>

- 홈
- 채팅
- 설정
- 서비스 약관

이러한 페이지에 중첩된 내비게이션을 가지려면 각 수준의 중첩에 대해 별도의 내비게이션 키가 필요합니다. 우리의 경우, 2개의 내비게이터 키를 생성할 것입니다:

```js
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
```

_rootNavigatorKey는 부모 내비게이션 스택에 사용되고, _shellNavigatorKey는 ShellRoute와 함께 중첩된 내비게이션에 사용될 것입니다.

<div class="content-ad"></div>

_rootNavigatorKey은 지속적인 BottomNavigationBar를 갖지 말아야 하는 모든 루트에 도움이 될 것이고, _shellNavigatorKey는 BottomNavigationBar가 있는 모든 루트에 사용될 것입니다.

그럼, 이 우리의 원귀적인 목적을 위해 다음과 같은 루트들을 생성해보도록 하겠습니다:

```js
final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) =>
          BottomNavigationBarScaffold(child: child),
      routes: [
        GoRoute(
          path: '/',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/chat',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) => const ChatPage(),
        ),
        GoRoute(
          path: '/settings',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) => const SettingsPage(),
          routes: [
            GoRoute(
              path: 'terms-of-services',
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) => const TermsOfServicesPage(),
            ),
          ],
        ),
      ],
    )
  ],
);
```

저는 다음과 같은 계층구조로 페이지들을 생성했습니다:

<div class="content-ad"></div>


-> 하단 내비게이션 바 스캐폴드
   -> 홈
   -> 채팅
   -> 설정
      -> 서비스 약관


서비스 약관을 제외한 모든 경로는 _shellNavigatorKey를 부모 네비게이터 키로 사용합니다. 이는 서비스 약관 페이지를 제외한 모든 경로가 하단 내비게이션 바 스캐폴드 내에서 탐색되도록 하고, 서비스 약관 페이지는 하단 내비게이션 바 없이 부모 네비게이션 스택에서 완전히 새로운 페이지로 열립니다.

# 5. 경로 간 탐색:

모두 완료되었습니다. 프로젝트에 중첩 네비게이션을 성공적으로 구현했습니다. 우후!! 


<div class="content-ad"></div>


![image](https://miro.medium.com/v2/resize:fit:480/1*-lKavvf7-diWZdV-9TCDcg.gif)

이제 할 일은 go_router에서 제공하는 context.go() 메소드를 사용하여 화면 간을 이동하기만 하면 됩니다. 방금 설정한 라우터가 모든 작업을 대신 처리해 줄 거에요. 멋지죠?!

참고:


<div class="content-ad"></div>

# 결론:

요약하면, go_router 패키지와 ShellRoute 기능은 플러터 앱에서 지속적인 하단 네비게이션 바를 구현하는 강력한 솔루션을 제공합니다. 위에 설명된 단계를 따라서 앱의 네비게이션 경험을 향상시키고 전체 사용자 인터페이스를 개선할 수 있습니다. 즐거운 코딩 하세요!

참고: 이 문서에서 제공된 코드 조각들은 예시를 위한 것이며, 특정 앱 구조와 디자인에 맞게 사용자 정의가 필요할 수 있습니다.

참고: 제는 정기적으로 댓글을 확인하며, 궁금한 점이 있거나 해결하기 어려운 문제에 대한 가이드를 작성해 달라면 아래 댓글을 남겨주시면 반드시 도와드리겠습니다!

<div class="content-ad"></div>

![Image](https://miro.medium.com/v2/resize:fit:500/1*FX70ARrhtMfCV40g0ttlAQ.gif)

다음 글에서 뵙겠습니다, 마아살라마!