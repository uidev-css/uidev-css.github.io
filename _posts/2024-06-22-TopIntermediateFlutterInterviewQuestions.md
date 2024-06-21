---
title: "중급 Flutter 인터뷰 질문 상위 목록"
description: ""
coverImage: "/assets/img/2024-06-22-TopIntermediateFlutterInterviewQuestions_0.png"
date: 2024-06-22 04:02
ogImage: 
  url: /assets/img/2024-06-22-TopIntermediateFlutterInterviewQuestions_0.png
tag: Tech
originalTitle: "Top Intermediate Flutter Interview Questions"
link: "https://medium.com/@nooralibutt/top-intermediate-flutter-interview-questions-1add516daa30"
---


- Tree shaking이란 무엇인가요?

Tree shaking은 빌드 프로세스 중에 번들에서 사용되지 않는 모듈을 제거하는 최적화 기술입니다. 이는 코드를 최적화하기 위해 사용되는 미사용 코드 제거 기술입니다.

- 핫 리로드 vs 핫 리스타트

핫 리로드는 코드 변경 사항을 VM에로드하고 위젯 트리를 다시 빌드하여 응용 프로그램 상태를 보존합니다. 이는 main() 또는 initState()을 다시 실행하지 않습니다.

<div class="content-ad"></div>

핫 리스타트는 코드 변경 사항을 VM에 로드하고 Flutter 앱을 다시 시작하여 앱 상태를 잃게 됩니다.

풀 리스타트는 iOS, Android 또는 웹 앱을 다시 시작합니다. 네이티브 코드를 다시 컴파일하기 때문에 시간이 더 걸립니다. 웹에서는 Dart 개발 컴파일러도 다시 시작됩니다.

플러터 웹은 현재 핫 리스타트를 지원하지만 핫 리로드는 지원하지 않습니다.

<div class="content-ad"></div>

4. Package vs Plugin?

플러그인에는 Dart 및 네이티브 코드(kotlin/js/swift/...)가 모두 포함되어 있지만, 패키지에는 Dart 코드만 포함되어 있습니다. 그러나 패키지는 내부적으로 플러그인을 참조할 수 있습니다.

4. Inherited Widget이란 무엇인가요?

트리 아래로 정보를 효율적으로 전파하는 위젯의 기본 클래스입니다.

<div class="content-ad"></div>

5. Inherited Widget vs Provider?

대규모 애플리케이션에서 InheritedWidget을 사용하면 build 메서드가 항상 전체 build 메서드를 다시 만들어야 합니다. 그러나 Provider를 사용하면 특정 블록을 제어하는 매우 특정한 Consumer 위젯이 있으므로 더 효율적입니다.

6. Stateful Widget 라이프사이클 메서드 정의:

- createState: 이 메서드는 위젯의 상태 객체를 생성합니다.
- initState: 이 메서드는 위젯의 상태를 초기화하는 데 호출됩니다.
- didChangeDependencies: 이 메서드는 State 객체의 종속성이 InheritedWidget을 통해 변경될 때 호출됩니다.
- build: 위젯이 다시 빌드될 때마다 호출됩니다. initState, didChangeDependencies, didUpdateWidget 이후에 또는 setState를 통해 상태가 변경될 때 발생할 수 있습니다.
- didUpdateWidget: 이 메서드는 새로운 속성으로 위젯이 업데이트될 때 호출됩니다.
- setState: 업데이트를 트리거합니다.
- deactivate: 이 메서드는 GlobalKey를 사용하여 서브트리 A에서 State가 제거되고 서브트리 B로 재삽입될 때 호출됩니다.
- dispose: 이 메서드는 위젯이 영구적으로 파괴되기 직전에 호출됩니다.

<div class="content-ad"></div>

7. initState 메서드는 위젯에서 몇 번 호출될 수 있나요?

한 번만 호출됩니다.

8. Dart에서 게으른 초기화가 존재하나요? 존재한다면 어떻게 객체를 게으르게 초기화할 수 있나요?

네, late 키워드를 사용하여 게으르게 초기화할 수 있습니다.

<div class="content-ad"></div>

9. SizedBox vs Container

SizedBox는 크기 조정이나 여분 공간을 가지는 데 사용됩니다. 색상, borderRadius 등과 같은 장식적 속성은 포함되지 않습니다.

반면에 Container()는 수정할 수 있는 위젯입니다.

10. const vs final

<div class="content-ad"></div>

상수 값은 컴파일 시간에 알려져야 하지만, 최종 값은 실행 시간에 알려져야 합니다.

최종 변수는 재할당할 수 없지만, 객체는 변경할 수 있습니다.

11. const widget의 목적은 무엇인가요?

상태 변경(예: setState)의 경우, const 위젯은 다시 구축되지 않습니다.