---
title: "플러터Flutter에서의 TabBar와 TabView"
description: ""
coverImage: "/assets/img/2024-06-19-TabBarandTabViewinFlutter_0.png"
date: 2024-06-19 14:25
ogImage: 
  url: /assets/img/2024-06-19-TabBarandTabViewinFlutter_0.png
tag: Tech
originalTitle: "TabBar and TabView in Flutter"
link: "https://medium.com/@MarvelApps_/tabbar-and-tabview-in-flutter-1d93008663aa"
---


TabBar는 홈 모듈, 프로필 모듈 등과 같은 애플리케이션의 주요 (또는 부수적인) 섹션에 빠르고 편리하게 접근할 수 있도록하는 중요한 부분입니다. TabBar는 항상 메인 화면에 표시되므로 사용자의 탐색이 편리해집니다.

이 블로그에서는 플러터 애플리케이션에 TabBar를 구현하는 방법을 알아보겠습니다. 네 개의 탭이 있는 TabBar에는 각각에 대한 개별 화면이 포함되어 있습니다.

![TabBar and TabView in Flutter](/assets/img/2024-06-19-TabBarandTabViewinFlutter_0.png)

터미널에서 다음 명령을 실행하여 새로운 플러터 프로젝트를 생성하는 것부터 시작하겠습니다.

```js
flutter create tab_view_demo
```

<div class="content-ad"></div>

프로젝트가 성공적으로 생성되면 lib/main.dart 파일에서 생성된 모든 코드를 제거한 후 아래 코드로 대체해주세요:

```js
import 'package:flutter/material.dart';
import 'package:tabview_flutter_module/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tab View Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const HomePage(),
    );
  }
}
```

HomePage를 만들어서 탭 바와 탭 뷰가 있는 화면을 만들어봅시다.

```js
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
```

<div class="content-ad"></div>

기본 플러터 홈 화면을 만들었습니다. 이제 탭 바 및 탭 뷰를 구축해 봅시다.

HomePage 위젯에 SingleTickerProviderStateMixin을 추가하고 HomePage 위젯 내에서 TabController를 선언하고 initState 메서드에서 초기화합니다.

```js
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
```

앱 바에 연결된 탭 바를 만들고 그 하단에 위치하도록 할 것입니다. 따라서 먼저 AppBar를 만들고 AppBar의 "bottom" 속성에 탭 바를 추가합니다.

<div class="content-ad"></div>

```markdown
위의 코드 스니펫에서 새로운 앱 바를 만들고, 현재 선택된 탭의 인덱스를 사용하여 앱 바의 제목을 추가했습니다. "bottom" 속성에는 앞서 생성한 TabController와 앱에 추가하려는 탭을 함께 포함한 TabBar 위젯을 추가했습니다.
Tab() 위젯은 해당 탭의 라벨로 사용될 "text" 매개변수를 사용하며, "icon"은 해당 탭에서 아이콘으로 사용할 위젯을 취합니다.

이제 탭이 생성되었으므로, 각 탭에 대한 탭 뷰를 만들어야 합니다. 탭 뷰는 탭을 선택할 때 표시할 보기/화면/위젯입니다. 다음과 같이 TabView() 위젯을 사용하여 Scaffold()의 "body"에 구현할 것입니다.

```

```markdown
```js
import 'package:flutter/material.dart';
import 'package:tabview_flutter_module/screens/screen_forth.dart';
import 'package:tabview_flutter_module/screens/screen_one.dart';
import 'package:tabview_flutter_module/screens/screen_three.dart';
import 'package:tabview_flutter_module/screens/screen_two.dart';
import '../constant/text_constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          //tabcontroller.index can be used to get the name of current index value of the tabview.
          title: Text(tabController.index == 0
              ? TextConstants.titleTab_1
              : tabController.index == 1
                  ? TextConstants.titleTab_2
                  : tabController.index == 2
                      ? TextConstants.titleTab_3
                      : TextConstants.titleTab_4),
          bottom: TabBar(controller: tabController, tabs: [
            Tab(
              text: TextConstants.titleTab_1,
              icon: Icon(
                Icons.home,
                color: Colors.indigo.shade500,
              ),
            ),
            Tab(
                text: TextConstants.titleTab_2,
                icon: Icon(
                  Icons.email,
                  color: Colors.indigo.shade500,
                )),
            Tab(
                text: TextConstants.titleTab_3,
                icon: Icon(
                  Icons.star,
                  color: Colors.indigo.shade500,
                )),
            Tab(
                text: TextConstants.titleTab_4,
                icon: Icon(
                  Icons.person,
                  color: Colors.indigo.shade500,
                ))
          ]),
        ),
        body: TabBarView(controller: tabController, children: [
          FirstScreen(
            tabController: tabController,
          ),
          SecondScreen(
            tabController: tabController,
          ),
          ThirdScreen(
            tabController: tabController,
          ),
          FourthScreen(
            tabController: tabController,
          )
        ]));
  }
}
```
```

<div class="content-ad"></div>

위 코드 스니펫에서는 TabController 및 TabBarView() 위젯의 탭 수를 전달했습니다. 화면 대신 children 속성에 모든 종류의 위젯을 전달할 수도 있습니다.

TabController는 서로 다른 탭 및 그 뷰 간의 탐색을 처리하며, 탭의 상태를 추적합니다.

위 예제에서 TabBar 및 TabBarView를 성공적으로 설정했지만, 내부 화면에서 다른 탭으로 이동해야하는 시나리오가 발생할 수 있습니다. 이 경우 탭의 TabController에 액세스하고 원하는 탭의 색인을 나타내는 정수 값을 사용하는 animateTo(tabIndex) 메서드를 호출하면 됩니다.

```js
tabController.animateTo(0); // 색인 0의 탭으로 이동
```

<div class="content-ad"></div>

저희가 이제 flutter 어플리케이션에 TabBar와 TabBarView를 구현했어요. 어플리케이션을 실행한 후에 이렇게 보일 거에요.

![TabBar and TabBarView](https://miro.medium.com/v2/resize:fit:704/1*mbJaDBvhZSNKqGzOo_SM-g.gif)

이 글에서 사용된 예제의 전체 소스 코드는 저장소에서 확인할 수 있어요.

만약 도움이 되었다면 이 블로그에 박수를 보내주세요. 👏👏👏👏

<div class="content-ad"></div>

❤❤ 읽어 주셔서 감사합니다!!! ❤❤