---
title: "Flutter에서 더 나은 오류 처리 방법  Error Stack 알아보기"
description: ""
coverImage: "/assets/img/2024-06-21-BetterErrorHandlingforFlutterErrorStack_0.png"
date: 2024-06-21 21:07
ogImage: 
  url: /assets/img/2024-06-21-BetterErrorHandlingforFlutterErrorStack_0.png
tag: Tech
originalTitle: "Better Error Handling for Flutter — Error Stack"
link: "https://medium.com/@agordn52/better-error-handling-for-flutter-error-stack-754a14fb9871"
---


## 플러터용 모던 오류 처리 UI가 있습니다. 이로 인해 버그를 더 빨리 해결할 수 있습니다

![이미지](/assets/img/2024-06-21-BetterErrorHandlingforFlutterErrorStack_0.png)

이 중간 이야기에서, 단 한 줄의 코드로 오류 화면을 멋지고 현대적인 오류 처리 UI로 변환하는 새 패키지를 공유하겠습니다. 이 패키지는 Android, iOS, Linux, macOS, Windows 및 웹에서 작동합니다.

# 플러터를 위한 에러 스택 소개 🎉

<div class="content-ad"></div>

pub.dev을 통해 이 패키지를 설치할 수 있어요. 공개 저장소는 GitHub에 호스팅돼요.

## 에러 스택 설치하기

아래 내용을 당신의 pubspec.yaml 파일에 추가하세요:

```yaml
dependencies:
  error_stack: ^1.7.3
```

<div class="content-ad"></div>

혹시 Flutter를 사용하시나요?

flutter pub add error_stack

프로젝트에 의존성으로 추가되었는지 확인하려면 flutter pub get을 실행해보세요.

# 에러 스택 초기화하기 🛠️

<div class="content-ad"></div>

에러 스택을 사용하려면 아래 예제처럼 main.dart 파일에 ErrorStack.init();을 추가하십시오.

```js
// main.dart 파일에 에러 스택 추가
...
import 'package:error_stack/error_stack.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ErrorStack.init(); // 에러 스택 초기화
  runApp(MyApp());
}
```

이제 에러 스택이 활성화되어 UI에서 발생하는 모든 오류를 캐치할 준비가 되었습니다. 테스트를 위해 에러를 시뮬레이션해 보겠습니다!

```js
import 'package:flutter/material.dart';

class ErrorExampleWidget extends StatefulWidget {
  
  ErrorExampleWidget({super.key});

  @override
  createState() => _ErrorExampleWidgetState();
}

class _ErrorExampleWidgetState extends State<ErrorExampleWidget> {

  dynamic title = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("에러 예제")
      ),
      body: SafeArea(
         child: Container(
           child: Text(title), // 타이틀에 대한 Subtype이 String이 아닙니다 💣
         ),
      ),
    );
  }
}
```

<div class="content-ad"></div>

에러 발생 예제 페이지(ErrorExamplePage)는 Text 위젯이 첫 번째 인수로 문자열만 허용하기 때문에 오류가 발생할 것입니다.

앱에서 이 위젯을 사용하려고 하면 에러 스택(Error Stack)이 나타납니다.

<img src="/assets/img/2024-06-21-BetterErrorHandlingforFlutterErrorStack_1.png" />

# 주요 기능 🚀

<div class="content-ad"></div>

- 웹 UI에서의 빠른 구글 검색을 통해 오류 해결
- 오류 메시지를 클립보드에 복사
- 라이트 모드 및 다크 모드 지원
- 디버그 및 릴리스 모드 오류 화면
- 릴리스 모드를 위한 사용자 정의 오류 페이지

![이미지](/assets/img/2024-06-21-BetterErrorHandlingforFlutterErrorStack_2.png)

## 빠른 구글 검색

내가 좋아하는 기능은 오류를 즉시 구글에서 검색할 수 있는 기능입니다. "이 오류로 구글에서 검색"을 탭하면 바로 검색 페이지로 이동하여 오류를 해결하는 방법을 배울 수 있습니다.

<div class="content-ad"></div>

## 앱 재시작

다른 유용한 기능은 디버그 모드에서 앱을 다시 시작할 수 있는 기능입니다. 이는 앱을 수동으로 종료하고 다시 빌드할 필요가 없다는 뜻입니다.

## 릴리스 모드 UI

릴리스 모드에서 앱이 충돌하는 경우, 오류 스택은 사용자에게 다른 UI를 표시할 것입니다. 그러나 사용자 정의 UI를 사용하고 싶다면, 아래 예시처럼 init 메서드에 errorWidget을 추가하십시오.

<div class="content-ad"></div>

```js
await ErrorStack.init(
  errorWidget: (errorDetails) => MaterialApp(
    home: Scaffold(
      body: Center(
        child: Text("An error occurred"),
      ),
    ),
  )
);
```

# 마무리하며

이번 미디엄 스토리가 유익했기를 바랍니다! Error Stack을 개발하는 것이 정말 재미있었는데, 더 나은 기능을 추가할 아이디어를 이미 몇 가지 생각해 두었습니다.

만약 궁금하시다면 GitHub의 공개 저장소에서 내부 동작을 확인해볼 수 있습니다. 여러분의 프로젝트에서 시도해보고 피드백을 보내주세요.

<div class="content-ad"></div>

위 문서를 읽어 주셔서 감사합니다.

안토니 고든

https://linktr.ee/agordn