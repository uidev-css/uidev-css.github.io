---
title: "옵저버 디자인 패턴 - Dart"
description: ""
coverImage: "/assets/img/2024-06-19-ObserverDesignPatternDart_0.png"
date: 2024-06-19 00:11
ogImage: 
  url: /assets/img/2024-06-19-ObserverDesignPatternDart_0.png
tag: Tech
originalTitle: "Observer Design Pattern — Dart"
link: "https://medium.com/@tagizada.nicat/observer-design-pattern-dart-819536fe0298"
---



<img src="/assets/img/2024-06-19-ObserverDesignPatternDart_0.png" />

옵저버는 행동 디자인 패턴입니다. 우리는 데이터를 변경할 때 객체에 알리는 관찰자 패턴을 사용할 수 있습니다. 객체에게 "앗, 데이터가 변경되었어. 할 일을 해라"고 알립니다. 이는 플러터의 ChangeNotifier와 비슷합니다. 옵저버 패턴에는 Subject와 Observer 두 가지 타입의 클래스가 있습니다. Observer 클래스는 데이터 업데이트를 기다리고 우리의 사용자 정의 로직을 실행할 것입니다. Subject 클래스는 옵저버를 저장하고 데이터를 알림하기 위해 사용됩니다.

# 시작해보죠

<img src="https://miro.medium.com/v2/resize:fit:1000/1*MRIUs1xCFX0PjO88wG1AxQ.gif" />


<div class="content-ad"></div>

먼저, Observer 클래스와 update 메서드를 생성할 겁니다. 이 메서드에 대해 구체적인 옵저버들이 알림을 받겠죠.

```js
abstract class Observer {
  void update(bool atHome);
}
```

이제 Observer 추상 클래스를 구현하는 구체적인 옵저버들을 만들 수 있어요.

```js
class Kettle implements Observer {
  @override
  void update(bool atHome) {
    /// 여기에 사용자 정의 로직을 작성할 수 있어요
    if (atHome) {
      print('물 끓이는 중');
    } else {
      print('주전자가 꺼졌어요');
    }
  }
}

class Lights implements Observer {
  @override
  void update(bool atHome) {
    /// 여기에 사용자 정의 로직을 작성할 수 있어요
    if (atHome) {
      print('조명 켜짐');
    } else {
      print('모두 조명 끔');
    }
  }
}
```

<div class="content-ad"></div>

이제 Subject 클래스를 만들어 보겠습니다. 이것을 HomeManager라고 이름 짓겠습니다.

```js
class HomeManager {
  final List<Observer> _observersList = [];

  /// 변경 가능한 데이터 (상태 데이터)
  bool _atHome = false;

  /// 새로운 옵서버를 목록에 추가합니다
  void addListener(Observer observer) {
    _observersList.add(observer);
  }

  /// 옵서버를 목록에서 제거합니다
  void removeListener(Observer observer) {
    _observersList.remove(observer);
  }

  /// 데이터 업데이트
  void setData(bool atHome) {
    _atHome = atHome;
  }
  
  /// 추가된 모든 옵서버들에게 알립니다
  void notify() {
    for (var element in _observersList) {
      element.update(_atHome);
    }
  }
}
```

중요한 부분은 notify 메서드입니다. _observersList를 통해 반복하면서 각 옵서버 객체에 대해 update 메서드를 호출합니다. 따라서 각 옵서버는 그 데이터 변경 사항을 인식하게 됩니다. 모든 클래스를 함께 사용합시다. 주석과 함께 설명해 드렸습니다.

```js
import 'package:observer_design_pattern/observer.dart';

void main(List<String> arguments) {
  HomeManager homeManager = HomeManager();

  Lights lights = Lights();
  Kettle kettle = Kettle();

  /// 옵서버들을 목록에 추가합니다
  homeManager.addListener(lights);
  homeManager.addListener(kettle);

  /// 데이터 업데이트
  homeManager.setData(true);

  /// 모든 옵서버에게 알림
  ///
  /// Kettle과 Lights가 트리거됩니다
  homeManager.notify();

  print('------옵서버 제거------');

  /// Lights 옵서버를 제거합니다
  homeManager.removeListener(lights);

  homeManager.setData(false);

  /// Kettle만 트리거됩니다
  homeManager.notify();
}
```

<div class="content-ad"></div>

여기 결과입니다:

![옵저버 디자인 패턴](/assets/img/2024-06-19-ObserverDesignPatternDart_1.png)

그게 다에요. 간단한 예제를 활용하여 옵저버 디자인 패턴을 설명해보았어요. 마음에 드셨으면 좋겠네요... 의견 주시면 감사하겠어요! 아래에서 작동하는 예제(소스 코드)를 찾을 수 있어요.

![옵저버 패턴 예제](https://miro.medium.com/v2/resize:fit:1000/1*ufNPsZPqqgunmv1Bd2JrzQ.gif)