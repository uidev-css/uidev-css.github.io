---
title: "Flutter 앱에서 메모리 사용 최적화 방법 파트 1"
description: ""
coverImage: "/assets/img/2024-06-27-OptimizingMemoryUsageinFlutterAppsPart-1_0.png"
date: 2024-06-27 18:29
ogImage:
  url: /assets/img/2024-06-27-OptimizingMemoryUsageinFlutterAppsPart-1_0.png
tag: Tech
originalTitle: "Optimizing Memory Usage in Flutter Apps (Part-1)"
link: "https://medium.com/@gauravswarankar/optimizing-memory-usage-in-flutter-apps-part-1-1ad377b1e975"
---

<img src="/assets/img/2024-06-27-OptimizingMemoryUsageinFlutterAppsPart-1_0.png" />

안녕하세요 Medium 독자 여러분, 오늘은 플러터 애플리케이션의 메모리 최적화에 대해 이야기하려고 합니다. 메모리 사용을 최적화하면 부드럽고 반응성 있는 앱을 보장하여 사용자 경험을 향상시킵니다.

# 프로파일링 기술 (Flutter DevTools)

Flutter DevTools의 메모리 탭을 사용하여 플러터 앱이 메모리를 실시간으로 어떻게 사용하는지 분석하세요. 이를 통해 메모리 사용에 대한 자세한 정보를 얻을 수 있습니다.

<div class="content-ad"></div>

메모리 그래프를 확인하여 메모리 사용 방식을 파악하고 문제가 발생하는 영역을 찾아보세요. 너무 많은 메모리 사용이나 누수를 나타내는 패턴을 찾아보세요. 또한 메모리 사용량이 급증하는 부분을 확인하여 어플리케이션의 어떤 부분이 이러한 현상을 유발하는지 파악해보세요. 빈번한 메모리 사용량 변동이 있다면 메모리가 효율적으로 사용되고 있지 않을 수 있습니다.

# 메모리 최적화 기술

기본적으로 메모리 최적화 기술에는 2가지 방법이 있습니다.

## 풀링 및 객체 재사용으로 할당량 줄이기

<div class="content-ad"></div>

객체 풀링(Object Pooling): 반복적으로 새로운 객체를 만드는 대신에 객체를 재사용합니다. 이는 메모리 사용량을 크게 줄이고 가비지 수집 작업을 줄일 수 있습니다.

기본적인 객체 풀링의 예시를 살펴봅시다.

```js
// 예시: Worker 객체를 사용한 객체 풀링

class Worker {
  int id;
  Worker(this.id);

  void doWork() {
    print('Worker $id is doing work');
  }
}

class ObjectPool<T> {
  final List<T> _available = [];
  final List<T> _inUse = [];
  int _counter = 0;

  T getObject() {
    if (_available.isEmpty) {
      _available.add(_createObject());
    }
    final obj = _available.removeLast();
    _inUse.add(obj);
    return obj;
  }

  void releaseObject(T obj) {
    _inUse.remove(obj);
    _available.add(obj);
  }

  T _createObject() {
    // 고유 ID를 가진 Worker 객체 생성
    _counter++;
    return Worker(_counter) as T;
  }
}

void main() {
  final workerPool = ObjectPool<Worker>();

  // 풀에서 Worker를 가져와서 작업을 수행합니다
  Worker worker1 = workerPool.getObject();
  worker1.doWork();

  // 다른 Worker를 풀에서 가져와서 작업을 수행합니다
  Worker worker2 = workerPool.getObject();
  worker2.doWork();

  // 첫 번째 Worker를 풀에 반환합니다
  workerPool.releaseObject(worker1);

  // 풀에서 다른 Worker를 가져옵니다 (이전에 반환된 Worker를 재사용해야 합니다)
  Worker worker3 = workerPool.getObject();
  worker3.doWork();

  // 나머지 Worker들을 풀에 반환합니다
  workerPool.releaseObject(worker2);
  workerPool.releaseObject(worker3);
}
```

Worker 클래스에는 Worker가 일을 하는 상황을 알리는 메시지를 간단히 출력하는 doWork 메소드가 있습니다. Object Pool 클래스에서는 Worker 객체의 재사용을 관리하여 메모리 할당과 가비지 수집을 최소화합니다.

<div class="content-ad"></div>

- Object Pool 클래스에는 두 개의 리스트인 \_available(재사용 가능한 객체)와 \_inUse(현재 사용 중인 객체)가 포함되어 있습니다.
- \_counter는 새로 생성된 Worker 객체에 고유 ID를 할당하는 데 도움을 줍니다.
- getObject() 메서드는 풀에서 객체를 가져옵니다. 리스트가 비어 있다면 새로운 객체를 생성하고 \_available에서 가져온 객체를 \_inUse로 이동합니다.

Release object는 객체를 \_inUse에서 가져와 \_available로 다시 반환합니다.

\_createObject 메서드는 고유 ID가 있는 새 Worker 객체를 생성하고, 각 Worker가 고유 ID를 받을 수 있도록 \_counter를 증가시킵니다.

이제 main 함수인 void main()으로 넘어가 봅시다.

<div class="content-ad"></div>

우선 Worker 객체를 위한 ObjectPool을 생성합니다.

```js
void main() {
  final workerPool = ObjectPool<Worker>();
```

풀에서 Worker를 가져와 작업을 수행합니다.

```js
// 풀에서 Worker를 가져와 작업을 수행합니다
Worker worker1 = workerPool.getObject();
worker1.doWork();
```

<div class="content-ad"></div>

위 코드에서 getObject 메서드는 기존 Worker를 재사용하거나 새로운 Worker를 생성한 후에 Worker의 doWork 메서드를 호출합니다.

다음으로 풀에서 또 다른 Worker를 가져와 작업을 수행합니다.

```js
  // 풀에서 또 다른 Worker를 가져와 작업 수행
  Worker worker2 = workerPool.getObject();
  worker2.doWork();
```

첫 번째 Worker를 풀로 반납하세요.

<div class="content-ad"></div>

```js
// 첫 번째 워커를 풀에 반환합니다
workerPool.releaseObject(worker1);
```

이제 풀에서 다른 워커를 가져옵니다. 여기서 워커는 다시 사용되어야 합니다 (이 경우 worker1).

```js
  // 풀에서 다른 워커를 가져옵니다 (반환된 워커를 재사용해야 함)
  Worker worker3 = workerPool.getObject();
  worker3.doWork();
```

나머지 워커들을 풀에 반납합니다

<div class="content-ad"></div>

워커 객체가 모두 풀로 반환되도록 보장합니다.

```js
// 나머지 워커를 풀로 반환합니다
workerPool.releaseObject(worker2);
workerPool.releaseObject(worker3);
}
```

# 요약 :

- 객체 풀링은 객체를 반복적으로 생성하고 파괴하는 대신 재사용하는 디자인 패턴입니다.
- 이점: 메모리 할당 오버헤드를 줄이고 가비지 컬렉션을 최소화합니다.

<div class="content-ad"></div>

# 결론:

이번에는 Dart에서 객체 풀링에 대해 논의했습니다. 이는 빈번한 생성과 소멸 대신 객체를 재사용하는 데 도움이 됩니다. 이 기사의 다음 부분에서 메모리를 더 최적화하는 방법을 더 알아볼 수 있습니다. Dart 패드에서 코드를 자유롭게 테스트해보세요.

이 기사를 즐겁게 읽으셨길 바랍니다!

만약 이 기사가 도움이 되었다면 👏를 눌러주세요.

<div class="content-ad"></div>

안녕히 가세요!
