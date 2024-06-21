---
title: "플러터 앱 효율성 향상 여러 Futures를 동시에 처리하는 방법"
description: ""
coverImage: "/assets/img/2024-06-21-ImproveFlutterAppEfficiencyHandlingMultipleFuturesatOnce_0.png"
date: 2024-06-21 22:10
ogImage: 
  url: /assets/img/2024-06-21-ImproveFlutterAppEfficiencyHandlingMultipleFuturesatOnce_0.png
tag: Tech
originalTitle: "Improve Flutter App Efficiency: Handling Multiple Futures at Once"
link: "https://medium.com/@hpatilabhi10/improve-flutter-app-efficiency-handling-multiple-futures-at-once-158836bf2794"
---


<img src="/assets/img/2024-06-21-ImproveFlutterAppEfficiencyHandlingMultipleFuturesatOnce_0.png" />

## 소개

Flutter에서 여러 비동기 작업을 동시에 처리하면 앱의 성능과 응답성을 크게 향상시킬 수 있습니다. 로컬 저장소에서 사용자 이름과 이메일을 동시에 가져와야 한다고 상상해보세요. 전통적으로는 한 작업이 완료될 때까지 다음 작업을 시작하지 못할 수 있지만, 이를 더 효율적으로 수행할 수 있는 방법이 있습니다. 이 글에서는 Future.wait를 사용하여 두 개의 미래 함수를 동시에 호출하는 방법을 살펴보고 전통적인 방법과 성능상의 장점을 비교해보겠습니다.

## 전통적인 방법

<div class="content-ad"></div>

전통적인 방식부터 시작해봅시다. 이 방법에서는 각 비동기 작업을 순차적으로 실행합니다.

```js
void fetchUserData() async {
  LocalStorage localStorage = LocalStorage();
  try {
    final username = await localStorage.fetchUserName();
    final userEmail = await localStorage.fetchUserEmail();
    print("Username: $username, Email: $userEmail");
  } catch (error) {
    print("Error: $error");
  }
}
```

## 더 나은 방법: Future.wait 사용하기

전통적인 방법에서 두 번째 작업은 첫 번째 작업이 완료될 때까지 기다리므로 소중한 시간이 낭비될 수 있습니다. 대신, Future.wait를 사용하여 두 작업을 동시에 실행하여 프로세스를 크게 가속화할 수 있습니다.

<div class="content-ad"></div>

## 예시 코드

```js
void fetchUserData() async {
  LocalStorage localStorage = LocalStorage();
  final usernameFuture = localStorage.fetchUserName();
  final userEmailFuture = localStorage.fetchUserEmail();

  try {
    final results = await Future.wait([usernameFuture, userEmailFuture]);
    final username = results[0];
    final userEmail = results[1];
    print("사용자 이름: $username, 이메일: $userEmail");
  } catch (error) {
    print("오류 발생: $error");
  }
}
```

## 작동 방식

- Futures 시작: 두 futures (usernameFuture와 userEmailFuture)를 동시에 시작합니다.
- 완료 대기: Future.wait는 두 futures의 완료를 기다리고 그 결과를 리스트로 반환합니다.
- 결과 처리: 두 작업이 완료되면 결과를 함께 처리합니다.

<div class="content-ad"></div>

## 성능 비교

전통적인 방법

전통적인 방법에서 총 소요 시간은 두 작업의 합계입니다.

- 사용자 이름 가져오기 (예: 2초)
- 사용자 이메일 가져오기 (예: 2초)

<div class="content-ad"></div>

총 소요 시간: 4초

Future.wait 사용하기

Future.wait 메서드를 사용하면 두 작업이 동시에 실행됩니다.

- 사용자 이름 가져오기 (예: 2초)
- 사용자 이메일 가져오기 (예: 2초)

<div class="content-ad"></div>

총 시간: 2초 (둘 중 늦게 완료되는 시간)

## 속도 차이

Future.wait 사용하면 두 작업이 완료되는 시간을 절반으로 줄일 수 있어서 성능 상의 혜택이 명확히 나타납니다. 이 방법은 여러 개의 독립적인 비동기 작업을 처리할 때 특히 유용합니다.

## 결론

<div class="content-ad"></div>

플러터에서 Future.wait를 사용하여 동시에 여러 미래 함수를 호출하는 것은 앱 성능을 크게 향상시킬 수 있는 강력한 기술입니다. 비동기 작업을 동시에 실행함으로써 전체 소요 시간을 줄일 수 있어 앱을 더 반응적이고 효율적으로 만들 수 있습니다. 이 방법은 단순할 뿐만 아니라 매우 효과적이며, 플러터에서 여러 비동기 작업을 처리하는 데 가장 좋은 방법 중 하나입니다.

## 추가 팁

- 에러 처리: Future.wait를 사용할 때 강력한 에러 처리를 보장하십시오. 단일 실패가 전체 작업에 영향을 줄 수 있습니다.
- 확장성: 이 방법은 두 개 이상의 미래에 대해 잘 확장되며, 여러 동시 작업에 대한 성능이 더욱 향상됩니다.

Future.wait를 도입함으로써 플러터 앱의 성능을 향상시켜 사용자 경험을 더 부드럽고 빠르게 제공할 수 있습니다. 다음에 여러 미래를 처리해야 할 때 Future.wait를 사용해보고 성능 차이를 확인해보세요!

<div class="content-ad"></div>

친절한 톤으로 번역하면 다음과 같습니다.

유저 경험을 우선시하고 깔끔한 코드 관행을 유지하는 전문 Flutter 개발자를 찾고 계신가요? 흥미로운 협업을 위해 여기 있습니다. 제 전체 프로필을 확인하고 LinkedIn에서 저와 소통해보세요.

제 블로그가 도움이 되었기를 바라요! 궁금한 점이나 피드백이 있으시면 아래에 댓글을 남겨주세요.