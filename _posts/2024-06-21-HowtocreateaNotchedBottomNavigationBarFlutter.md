---
title: "Flutter에서 노치가 있는 하단 내비게이션 바 만드는 방법"
description: ""
coverImage: "/assets/img/2024-06-21-HowtocreateaNotchedBottomNavigationBarFlutter_0.png"
date: 2024-06-21 22:41
ogImage:
  url: /assets/img/2024-06-21-HowtocreateaNotchedBottomNavigationBarFlutter_0.png
tag: Tech
originalTitle: "How to create a Notched Bottom Navigation Bar Flutter"
link: "https://medium.com/@akhil-ge0rge/how-to-create-a-notched-bottom-navigation-bar-flutter-39b571afd570"
---

이 가이드는 하단 네비게이션 앱 바에 노치가 있는 플로팅 액션 버튼을 추가하는 방법을 보여줍니다. 하단 바의 노치가 있는 플로팅 액션 버튼은 앱의 사용자 인터페이스를 더욱 미려하게 만들어줍니다. 더 자세한 정보는 아래 코드를 참조해주세요:

![Notched Floating Action Button](/assets/img/2024-06-21-HowtocreateaNotchedBottomNavigationBarFlutter_0.png)

시작해 봅시다

플로팅 액션 버튼이 있는 BottomAppBar는 아래 코드를 사용하여 앱에 추가할 수 있습니다.

<div class="content-ad"></div>

```js
Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 60,
        color: Colors.cyan.shade400,
        notchMargin: 5,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.print,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.people,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
```

아래는 코드의 출력이고 실행하면 앱에 사용 가능한 FloatingActionButton이 있는 BottomAppBar가 표시됩니다.

<img src="/assets/img/2024-06-21-HowtocreateaNotchedBottomNavigationBarFlutter_1.png" />

시작하려면, Scaffold 위젯의 floatingActionButtonLocation 속성을 사용하여 FloatingActionButton 버튼의 위치를 조정하세요.
아래에 표시된 centerDocked를 사용하여 중앙에 위치하도록 설정할 것입니다:

<div class="content-ad"></div>

아래와 같이 `BottomAppBar`에 모양을 적용하세요.

```js
shape: const CircularNotchedRectangle()
```

<img src="/assets/img/2024-06-21-HowtocreateaNotchedBottomNavigationBarFlutter_2.png" />

<div class="content-ad"></div>

`extendBody: true`을 지정하면 스캐폴드의 본문이 하단 네비게이션 바의 노치를 통해 보이게 됩니다.

```js
 extendBody: true,
```

<img src="/assets/img/2024-06-21-HowtocreateaNotchedBottomNavigationBarFlutter_3.png" />

그게 다에요. 🎉🎉

<div class="content-ad"></div>

풀 코드:

```js
 return Scaffold(
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 60,
        color: Colors.cyan.shade400,
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.print,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.people,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
```

감사합니다! :)
