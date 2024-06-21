---
title: "웹에서의 Flutter 접근성 높이는 방법"
description: ""
coverImage: "/assets/img/2024-06-22-AccessibilityinFlutterontheWeb_0.png"
date: 2024-06-22 05:07
ogImage: 
  url: /assets/img/2024-06-22-AccessibilityinFlutterontheWeb_0.png
tag: Tech
originalTitle: "Accessibility in Flutter on the Web"
link: "https://medium.com/flutter/accessibility-in-flutter-on-the-web-51bfc558b7d3"
---


## Flutter가 어떻게 보조 기술을 사용하는 사용자에게 캔버스 렌더링 앱을 접근 가능하게 만들려고 하는가

Flutter 프레임워크가 지원하는 대상 플랫폼 중 하나는 웹입니다. Flutter 애플리케이션은 모든 UI 요소를 캔버스 요소에 렌더링하여 픽셀 완벽성과 플랫폼 일관성을 보장합니다. 그러나 기본적으로 캔버스 요소는 접근할 수 없습니다. 이 사례 연구에서는 이러한 캔버스 렌더링된 Flutter 앱을 위한 접근성 지원이 어떻게 작동하는지 설명합니다.

![image](/assets/img/2024-06-22-AccessibilityinFlutterontheWeb_0.png)

Flutter에는 자동으로 접근성 트리를 생성하는 많은 기본 위젯이 있습니다. 접근성 트리는 보조 기술이 속성 및 속성을 쿼리하고 작업을 수행할 수 있는 접근성 객체의 트리입니다. 사용자 지정 위젯의 경우, Flutter의 Semantics 클래스를 사용하여 개발자가 위젯의 의미를 설명할 수 있으며, 이는 보조 기술이 위젯 콘텐츠를 이해할 수 있도록 돕습니다.

<div class="content-ad"></div>

성능상의 이유로, 이 글을 작성하는 시점에서 플러터의 접근성은 기본적으로 사용자 동의를 받아야 합니다. 플러터 팀은 향후 플러터 웹에서 기본적으로 의미론을 활성화하고 싶어합니다. 그러나 현재는 상당 수의 경우에 성능에 미치는 비용이 두드러지며, 기본값을 변경하기 전에 최적화가 필요합니다. 항상 플러터의 접근성 모드를 활성화하려는 개발자는 다음 코드 조각을 사용할 수 있습니다.

```js
import 'package:flutter/semantics.dart';

void main() {
  runApp(const MyApp());
  if (kIsWeb) {
    SemanticsBinding.instance.ensureSemantics();
  }
}
```

플러터의 접근성 지원을 선택하면 HTML이 자동으로 변경되며, 이 페이지의 나머지 부분에서 설명하겠습니다.

# 플러터의 접근성 동의하기

<div class="content-ad"></div>

플러터의 선택 참여 메커니즘은 숨겨진 버튼입니다. 구체적으로 말하면, 버튼을 배치합니다. `flt-semantics-placeholder` 엘리먼트는 role="button"으로 만들어졌는데, 이는 시각적으로 보이지 않고 시각 장애가 있는 사용자들에게는 접근할 수 없습니다. 이 엘리먼트에는 스타일이 적용되어 사용자가 화면 판독기를 사용하지 않는 한 숨겨지고 선택할 수 없습니다.

```js
<flt-semantics-placeholder
  role="button"
  aria-live="polite"
  aria-label="접근성 활성화"
  tabindex="0"
  style="  
        position: absolute;  
        left: -1px;  
        top: -1px;  
        width: 1px;  
        height: 1px;"
></flt-semantics-placeholder>
```

```js
/* `<flt-semantics-placeholder>`는 `<flutter-view>`에서 상속됩니다. */
flutter-view {
  user-select: none;
}
```

# 선택 참여 후 변경사항

<div class="content-ad"></div>

스크린 리더 사용자가 이 버튼을 클릭하면 어떤 일이 발생합니까? 플러터 갤러리의 카드와 같이 복잡하지 않은 예시를 고려하세요. 다음 스크린샷에 표시된 것과 같이.

![카드 예시](/assets/img/2024-06-22-AccessibilityinFlutterontheWeb_1.png)

사용자가 버튼을 클릭할 때 변경되는 부분을 이해하기 위해 Chrome DevTools에서 접근성 트리를 검사하면서 전 후 스크린샷을 비교하십시오. 두 번째 스크린샷이 첫 번째보다 훨씬 많은 의미 정보를 제공합니다.

<div class="content-ad"></div>

<img src="/assets/img/2024-06-22-AccessibilityinFlutterontheWeb_2.png" />

동의 후:

<img src="/assets/img/2024-06-22-AccessibilityinFlutterontheWeb_3.png" />

# 실행 내용

<div class="content-ad"></div>

Flutter의 핵심 아이디어는 현재 캔버스에 표시된 내용을 반영하는 접근 가능한 DOM 구조를 생성하는 것입니다. 이는 `flt-semantics-host` 상위 사용자 지정 요소를 포함하며, 이 요소에는 차례로 중첩될 수 있는 `flt-semantics` 및 `flt-semantics-container` 하위 요소가 포함됩니다. 예를 들어 TextButton과 같은 버튼 위젯을 고려해보십시오. 이 위젯은 DOM에서 `flt-semantics` 요소로 표시됩니다. `flt-semantics` 요소의 ARIA 주석(예: role 또는 aria-label) 및 다른 DOM 속성(tabindex, 이벤트 처리기)은 화면 판독기가 사용자에게 해당 요소를 버튼으로 알릴 수 있게 하고 클릭하거나 탭하도록 지원합니다. 실제 `button` 요소가 아님에도 불구하고 사용자에게 버튼으로 발표하고 클릭하고 탭할 수 있게 합니다. 다음 스크린샷에서 공유 버튼은 이러한 버튼의 한 예입니다.

이 `flt-semantics` 요소는 해당 버튼이 캔버스에 그려진 위치에 정확히 나타나도록 절대 위치로 배치됩니다. 이는 Flutter가 모든 위젯의 레이아웃을 소유하고 모든 의미 노드의 위치와 크기를 미리 계산하기 때문입니다. 절대 레이아웃은 접근성 요소를 사용자가 기대하는 위치에 정확히 배치할 수 있게 합니다. 그러나 사용자가 스크롤할 때 위치를 조정해야 하므로 일부 상황에서는 비용이 많이 들 수도 있습니다.

# 모든 기본 위젯에 접근 방식을 확장하기

Flutter는 DOM 구조에서 `flt-semantics role="button"`로 표시된 내용이 원래 Flutter TextButton으로 표현되었음을 알기 때문에, 모든 기존 Flutter 위젯을 해당 WAI-ARIA 역할로 매핑하는 접근 방식을 쉽게 확장하고 구현할 수 있습니다. 이 접근 방식은 Flutter의 기본 위젯에 대해 기본적으로 제공됩니다. 예를 들어, 현재 Flutter는 다음 역할을 지원합니다:

<div class="content-ad"></div>

- 텍스트
- 버튼
- 체크박스
- 라디오 버튼
- 텍스트 필드
- 링크
- 대화상자
- 이미지
- 슬라이더
- 실시간 영역
- 스크롤 가능한
- 컨테이너 및 그룹

위의 역할 목록이 짧지만 다양한 위젯 범주가 종종 동일한 역할을 공유한다는 점에 유의하세요. 예를 들어, Material TextField와 CupertinoTextField는 동일한 텍스트 필드 역할을 공유할 수 있습니다. Stack, Column, Row, Flex 등과 같은 대부분의 레이아웃 위젯은 모두 컨테이너/그룹으로 표현될 수 있습니다.

# 사용자 정의 위젯에 대한 도전 과제

사용자 정의 위젯을 구축할 때, Flutter는 자동으로 올바른 역할을 적용하지 못할 수 있습니다. 위젯이 단순히 기존 위젯의 장식된 변형인 경우(예: EditableText 위에 래퍼인 경우), 올바르게 표시될 수 있습니다(텍스트 필드로). 그러나 처음부터 위젯을 작성하는 경우, Flutter는 사용자가 Semantics 위젯을 사용하여 이에 대한 접근성 속성을 설명하도록 요구합니다. WAI-ARIA는 다양한 위젯 역할을 정의합니다. Flutter는 역할의 하위 집합만 지원하지만 이러한 하위 집합은 지속적으로 확장됩니다.

<div class="content-ad"></div>

예를 들어, 아래 스크린샷에서 확인할 수 있듯이 I/O Flip 게임에서 팀 클래스 선택기를 실시간으로 탐색할 수 있습니다. 웹 용어로 말하자면, 이것은 본질적으로 `select` 또는 WAI-ARIA 용어로 말하면 리스트 상자입니다. 사용 가능한 옵션은 일반 텍스트로 표시되지만(오히려 `option` 요소여야 합니다), 더 큰 문제는 접근성 트리에서 위젯의 뷰포트 외에 선택할 옵션이 더 있다는 사실이 명확하지 않다는 것입니다. 스크롤하기 전에 접근성 트리에서 사용 가능한 옵션을 보고 스크롤을 한 후의 상황을 살펴봅니다.

스크롤 전:

![이미지](/assets/img/2024-06-22-AccessibilityinFlutterontheWeb_4.png)

스크롤 후:

<div class="content-ad"></div>

<img src="/assets/img/2024-06-22-AccessibilityinFlutterontheWeb_5.png" />

만약 소스 코드를 살펴보면, Semantics 클래스를 사용하지 않는다는 것을 알 수 있습니다. Semantics는 아직 listbox 및 option 역할 주석 사용 사례를 지원하지 않습니다. 그러나 ListWheelScrollView를 사용하여 일반 ListView와 유사하게 작동하므로 이것이 목록임을 인지합니다. 그러나 액세스 가능성 트리는 현재 보이는 항목과 뷰포트 위 아래에 몇 개의 항목만 표시되고 모든 항목은 절대 표시되지 않음에 주의하십시오. (웹에서 거의 네이티브로 얻은 앱 성능 요령으로 이것은 가끔 `virtual-scroller` 형식으로도 웹에서 얻을 수 있습니다.)

Flutter의 액세스 가능성 트리를 ARIA Authoring Practices Guide의 스크롤 가능한 listbox 예제와 비교해보면, 액세스 가능성 트리에 모든 옵션이 표시되지만 뷰포트 외부에 있는 것도 포함됩니다. 이 listbox 사용 사례를 완전히 지원하지 않는 것은 현재까지의 Flutter 솔루션의 단점이며 앞으로 처리될 것입니다.

# 텍스트 편집

<div class="content-ad"></div>

플러터에는 `flt-text-editing-host` 요소가 있습니다. 이 요소는 `input` 또는 `textarea` 중 하나가 하위 요소로 포함되어 있고 해당 캔버스 영역에 완벽하게 배치됩니다. 이는 자동 입력 외에도 브라우저의 편의 기능이 정상 작동한다는 것을 의미합니다. 이 기능은 항상 활성화되어 있으며 접근성이 활성화되었는지 여부에 관곝 받지 않습니다. 의미론적 트리에서 텍스트 필드는 `input` 요소로 표현되며, 해당 내용을 설명하는 ARIA 레이블이 있는 경우도 있습니다. 다음의 텍스트 필드 예시는 플러터 갤러리에서 찾을 수 있습니다. 사용자가 탭 키를 누를 때마다 `input` 필드가 동적으로 재배치되는 것을 확인할 수 있습니다.

시각 장애가 없는 사용자에게는 텍스트 입력란에 표시된 레이블 텍스트가 보여지지만, 스크린 리더 사용자에게는 "편집, 빈칸"이나 "텍스트 편집, 빈칸"과 같이 발표됩니다. 이는 현재 플러터에서 `label` 요소를 생성하지 않기 때문에 발생하는 현상입니다. VoiceOver on macOS에서 스크린 리더 출력을 아래 이미지에서 확인할 수 있습니다. 이 부분은 플러터가 미래에 해결할 문제입니다.

텍스트 필드가 적절히 레이블이 지정된 경우, 스크린 리더는 의도된 의미를 발표합니다. 아래의 순수 HTML 예시를 참고하세요.

<div class="content-ad"></div>

![2024-06-22-AccessibilityinFlutterontheWeb_7.png](/assets/img/2024-06-22-AccessibilityinFlutterontheWeb_7.png)

# 결론

이 사례 연구는 웹에서 Flutter 캔버스 애플리케이션 내에서 접근성 지원이 어떻게 기능하는지에 대해 심층적으로 다루었습니다. Flutter의 접근성은 구체적인 속성과 스타일을 가진 숨겨진 버튼을 통해 드러납니다. 활성화되면 이 접근 방식은 스크린 리더 및 기타 보조 기술을 사용하는 사용자들에게 경험을 크게 향상시킵니다. Flutter의 핵심 개념은 캔버스 디스플레이를 반영하는 접근 가능한 DOM 구조를 만드는 것으로, `flt-semantics-host`, `flt-semantics`, `flt-semantics-container` 등과 같은 사용자 정의 요소를 활용합니다.

Flutter는 기본 위젯을 WAI-ARIA 역할에 능숙하게 매핑하지만, 팀은 몇 가지 남아 있는 과제를 인정합니다. Flutter에서 텍스트 편집을 탐구하면 `input` 또는 `textarea`를 사용하는 `flt-text-editing-host`의 트릭을 보여 주며, 동적으로 입력 필드를 재배치하는 것을 보여줍니다.

<div class="content-ad"></div>

앞으로 Flutter의 접근성 프레임워크를 더욱 개선할 기회가 있습니다. 이미 팀이 작업을 시작했습니다. 이에는 사용자 정의 위젯에 대한 목록 상자 사용 사례를 해결하고 텍스트 편집을 위한 레이블 요소 생성을 개선하는 것이 포함됩니다. 예상되는 이러한 향상은 Flutter가 계속해서 웹 컴파일 대상의 지속적인 개선에 대한 약속을 반영하여, 더 포괄적이고 매끄러운 접근성 경험을 제공하는 것을 목표로 합니다.

# 감사의 글

이 사례 연구는 Flutter 팀의 Yegor Jbanov, Kevin Moore, Michael Thomsen 및 Shams Zakhour에 의해 정확성을 검토했습니다. 편집 리뷰는 Rachel Andrew와 Shams Zakhour가 맡았습니다.