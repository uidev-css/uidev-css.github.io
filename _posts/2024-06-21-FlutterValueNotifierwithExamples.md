---
title: "예제와 함께 배우는 Flutter ValueNotifier 활용 방법"
description: ""
coverImage: "/assets/img/2024-06-21-FlutterValueNotifierwithExamples_0.png"
date: 2024-06-21 21:57
ogImage:
  url: /assets/img/2024-06-21-FlutterValueNotifierwithExamples_0.png
tag: Tech
originalTitle: "Flutter ValueNotifier with Examples"
link: "https://medium.com/@thekavak/flutter-valuenotifier-with-examples-66b3933d7036"
---

<img src="/assets/img/2024-06-21-FlutterValueNotifierwithExamples_0.png" />

소개
Flutter는 크로스 플랫폼 모바일 애플리케이션을 개발하기 위한 강력한 프레임워크입니다. 그 중요한 기능 중 하나는 애플리케이션의 상태를 관리하고 업데이트하기 위해 ValueNotifier를 사용할 수 있는 기능입니다. 이 블로그 포스트에서는 ValueNotifier의 기본 개념을 탐색하고 예제와 함께 사용하는 방법을 알아보겠습니다.

ValueNotifier란?

ValueNotifier는 Flutter에서 값을 저장하고 그 값이 변경될 때 청취자에게 알릴 수 있는 간단한 클래스입니다. 이는 다른 상태 관리 솔루션인 BLoC나 Provider와 같은 Flutter에서 사용 가능한 가벼운 대안입니다.

<div class="content-ad"></div>

예시 1: 카운터 앱
간단한 카운터 앱의 예시로 시작해보겠습니다. 화면에 카운터를 표시하고 사용자가 버튼을 탭할 때마다 증가시키는 앱을 만들어봅시다. 이를 위해 ValueNotifier를 사용하는 방법을 살펴보겠습니다:

```js
class Counter {
  final ValueNotifier<int> count = ValueNotifier<int>(0);

  void incrementCount() {
    count.value++;
  }
}

class CounterApp extends StatefulWidget {
  @override
  _CounterAppState createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  final Counter counter = Counter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('카운터 앱'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '카운트:',
            ),
            ValueListenableBuilder<int>(
              valueListenable: counter.count,
              builder: (BuildContext context, int value, child) {
                return Text(
                  '$value',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            counter.incrementCount();
          });
        },
        tooltip: '증가',
        child: Icon(Icons.add),
      ),
    );
  }
}
```

이 예시에서는 Count 클래스를 정의하고 그 안에 count라는 ValueNotifier를 포함시킵니다. 그런 다음 ValueListenableBuilder를 사용하여 count 값의 변경 사항을 감시하고 버튼이 눌릴 때 UI를 업데이트합니다.

예시 2: 폼 유효성 검사
ValueNotifier는 폼 유효성 검사에도 사용할 수 있습니다. 이 예시에서는 이메일과 패스워드 두 가지 필드로 구성된 폼의 유효성을 검사하려 합니다. 두 필드가 모두 입력되어야 폼이 유효합니다.

<div class="content-ad"></div>

```js
class LoginModel {
  final ValueNotifier<String> email = ValueNotifier<String>('');
  final ValueNotifier<String> password = ValueNotifier<String>('');

  // 이메일과 비밀번호가 비어있지 않은지 확인
  bool get isValid => email.value.isNotEmpty && password.value.isNotEmpty;
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final LoginModel model = LoginModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (String value) {
                setState(() {
                  model.email.value = value;
                });
              },
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            TextField(
              onChanged: (String value) {
                setState(() {
                  model.password.value = value;
                });
              },
              decoration: const InputDecoration(hintText: 'Password'),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: ValueNotifier<bool>(model.isValid),
              builder: (BuildContext context, bool isValid, child) {
                return ElevatedButton(
                  onPressed: () {
                    if (isValid) {
                      // 무언가를 수행
                      print("Valid");
                    } else {
                      print("Invalid");
                    }
                  },
                  child: const Text('Login'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
```

이 예제에서는 이메일과 비밀번호를 나타내는 두 개의 ValueNotifier가 포함된 LoginModel 클래스를 정의합니다. 그런 다음 ValueListenableBuilder를 사용하여 isValid 값의 변경 사항을 청취하고 로그인 버튼을 활성화/비활성화합니다.

예제 3: ValueNotifier로 UI 업데이트하기

ValueNotifier를 사용하여 상태가 변경될 때 UI를 업데이트할 수도 있습니다. 이 예제에서는 항목 목록을 표시하고 사용자가 스와이프하여 항목을 삭제할 수 있도록합니다.

<div class="content-ad"></div>

```js
class Item {
  final ValueNotifier<String> name;

  Item(String name) : name = ValueNotifier<String>(name);
}

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  final List<Item> items = [
    Item('아이템 1'),
    Item('아이템 2'),
    Item('아이템 3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            final Item item = items[index];

            return Dismissible(
              key: Key(item.name.value),
              onDismissed: (DismissDirection direction) {
                setState(() {
                  items.removeAt(index);
                });
              },
              child: ListTile(
                title: ValueListenableBuilder<String>(
                  valueListenable: item.name,
                  builder: (BuildContext context, String value, child) {
                    return Text(value);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
```

이 예시에서는 항목 이름에 대한 ValueNotifier`String`을 포함하는 Item 클래스를 정의합니다. 그런 다음 ValueListenableBuilder를 사용하여 이름 값의 변경을 감시하고 항목이 삭제되도록 스와이프될 때 UI를 업데이트합니다.

결론

ValueNotifier는 Flutter에서 다양한 용도로 사용할 수 있는 다재다능한 클래스로, 애플리케이션 상태 관리, 폼 유효성 검사 및 UI 업데이트를 포함한 여러 목적에 사용할 수 있습니다. ValueNotifier를 사용하여 개발자는 애플리케이션에서 상태를 관리하는 간단하고 효율적인 해결책을 만들 수 있습니다.

<div class="content-ad"></div>

![이미지](/assets/img/2024-06-21-FlutterValueNotifierwithExamples_1.png)

만약 내 미디엄 기사를 즐기신다면, 이 주제에 대한 연구와 학습을 지원하기 위해 커피 한 잔 사 주시면 감사하겠습니다.
