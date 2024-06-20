---
title: "Flet v0230에서 무슨 변화가 있을까요"
description: ""
coverImage: "/assets/img/2024-06-19-WhatsnewinFletv0230_0.png"
date: 2024-06-19 14:17
ogImage: 
  url: /assets/img/2024-06-19-WhatsnewinFletv0230_0.png
tag: Tech
originalTitle: "What’s new in Flet v0.23.0?"
link: "https://medium.com/python-in-plain-english/whats-new-in-flet-v0-23-0-25613d742db9"
---


알아야 할 모든 것!

![이미지](/assets/img/2024-06-19-WhatsnewinFletv0230_0.png)

플렛 버전 0.23.0 릴리스를 자랑스럽게 발표합니다! 🥳

모든 흥미로운 변경 사항을 바로 살펴보겠습니다...

<div class="content-ad"></div>

# 새로운 컨트롤들

아래는 알파벳 순서로 새로 추가된 컨트롤들입니다:

## AutoComplete

텍스트 필드에 입력하는 동안 제안 목록을 제공합니다. 사용자 경험을 향상시켜 입력을 예측하고 입력된 텍스트와 일치하는 제안을 제공함으로써 사용자가 빠르게 입력을 완료할 수 있도록 도와줍니다.

<div class="content-ad"></div>

<img src="/assets/img/2024-06-19-WhatsnewinFletv0230_1.png" />

## AutofillGroup

자동 채움 그룹은 자동 채움을 위해 여러 입력 필드를 그룹화합니다. 이는 시스템에 의해 관련 필드 (예: 사용자 이름 및 암호)의 자동 채움을 원활하게 하여, 양식 작성 효율성과 사용자 편의성을 향상시킵니다.

<img src="/assets/img/2024-06-19-WhatsnewinFletv0230_2.png" />

<div class="content-ad"></div>

## 손전등

이 모바일 기기의 플래시/손전등 빛을 제어할 수 있습니다. 응용 프로그램에서 직접 손전등을 켜고 끌 수 있어 손전등 앱이나 어둡고 가시성이 낮은 조건에서 시야를 높이는 기능에 유용합니다.

## 지리위치

지리위치 작업에 사용됩니다: 기기의 현재 위치를 검색하고, 위치 업데이트를 추적하며, 다양한 기반 위치 기능에 액세스할 수 있습니다. 지도, 내비게이션 또는 위치를 인식하는 기능을 필요로 하는 애플리케이션에 필수적입니다.

<div class="content-ad"></div>


![](/assets/img/2024-06-19-WhatsnewinFletv0230_3.png)

## 지도

커뮤니티에서 가장 요청이 많은 컨트롤 중 하나였습니다.

이를 통해 앱에 대화형 지도를 추가하고 다양한 유형의 레이어와 마커를 표시하며 사용자 상호작용을 처리하고 더 많은 작업을 할 수 있게 됩니다.


<div class="content-ad"></div>


![image](https://miro.medium.com/v2/resize:fit:1200/1*pVc2BkoTHzyI_Ym1JZV8xg.gif)

## PermissionHandler

앱 권한을 관리하며, 다양한 플랫폼에서 권한을 요청하고 확인하는 통합 방법을 제공합니다. 마이크, 위치 및 오디오와 같은 기능의 권한 처리 과정을 단순화하여 앱이 플랫폼별 권한 정책을 준수하도록 합니다.

![image](/assets/img/2024-06-19-WhatsnewinFletv0230_4.png)


<div class="content-ad"></div>

# 새로운 속성

기존 컨트롤에 다음과 같은 새로운 속성이 추가되었습니다:

- Option: content, text_style
- TextStyle: baseline, overflow, word_spacing
- Page: browser_context_menu, window

또한, Window와 관련된 새로운 속성이 추가되었습니다: shadow, alignment, wait_until_ready_to_show, always_on_bottom, icon, badge_label.

<div class="content-ad"></div>

# Impeller

Impeller는 Flutter를 위한 새로운 렌더링 런타임을 제공합니다.

현재 Android, iOS 및 macOS에서 사용할 수 있습니다. iOS에서는 기본적으로 활성화되어 있지만 macOS 및 Android에서는 기본적으로 비활성화되어 있어서 이 두 플랫폼에 대해 선택하기로 결정했습니다.

Impeller에 대해 더 자세히 알아보려면 여기를 확인하세요.

<div class="content-ad"></div>

# 오류 처리

몇몇 개발자가, 때때로 특정 상황에서 컨트롤이 시각적으로 손상되는 경우가 있고, 무엇이 그러한 손상을 일으킨 것인지 명확한 정보가 없다고 보고했습니다.

예를 들어, 이슈 #3149에서 @base-13이 “데이터 테이블에서 열의 수가 특정 행의 데이터셀 수보다 적으면 전체 테이블이 회색으로 표시되지만 오류가 발생하지 않는다”고 언급했습니다.

이를 고려하여, 대부분의 컨트롤에 더 많은 —주장— 확인을 추가하였습니다. 따라서 잘못된 값이 제공되면, 어떠한 오류가 발생했는지 명확하게 알려주는 AssertionError가 발생합니다.

<div class="content-ad"></div>

만약 일부 검사가 아직 누락된 것을 발견하면 지적해 주시기 바랍니다. 그러면 이를 해결할 수 있습니다.

# Command Line (CLI) Output

The output of the `flet build` 명령이 예쁘게 표시되었습니다.

- 상세 정보 없이 성공적으로 빌드된 경우 다음과 같이 나타납니다.

<div class="content-ad"></div>


![2024-06-19-WhatsnewinFletv0230_5.png](/assets/img/2024-06-19-WhatsnewinFletv0230_5.png)

- --show-platform-matrix 옵션이 추가되었습니다. 이 옵션을 이용하면 빌드 플랫폼 매트릭스를 포함한 테이블이 표시됩니다. 이 테이블은 "Command" (가능한 빌드 명령어)와 "Platform" (해당 명령어와 함께 사용해야 하는 장치) 열 헤더를 가지고 있습니다.

![2024-06-19-WhatsnewinFletv0230_6.png](/assets/img/2024-06-19-WhatsnewinFletv0230_6.png)

- 대상 플랫폼이 장치에서 빌드할 수 없는 경우, 정보를 제공하는 메시지와 함께 빌드 플랫폼 매트릭스가 포함된 테이블이 표시됩니다.


<div class="content-ad"></div>


![이미지](/assets/img/2024-06-19-WhatsnewinFletv0230_7.png)

# 중요 변경 사항

위에서 언급한 "오류 처리"를 수행하는 동안, 일부 중요한 속성을 필수로 표시해야 했습니다.

다음 속성은 이제 해당 클래스의 인스턴스를 생성할 때 "필수"로 지정되어 있습니다(제공되고 보이기 위해 필요함):



<div class="content-ad"></div>

위의 속성들을 제공하여 해당 클래스의 모든 인스턴스에 대해 간단히 마이그레이션을 완료할 수 있습니다.

# 버그 수정

- #3144: 상호 작용하지 않을 때 ScrollbarTheme.thickness 값이 존중되지 않음
- #3072: 고해상도 비디오가 Android TV 장치에서 느리게 재생됨
- #3023: (회귀) 일부 LineChart 색이 시각적으로 존중되지 않음
- #2989: 비활성화된 Dropdown의 색상이 비활성화 상태를 반영하지 않음
- #1753: Markdown 코드 블록이 선택할 수 없음
- #3097: 파일이 열릴 때 핫 리로드가 발생함
- #1647: Container.theme=None 일 때 Container.theme_mode가 존중되지 않음
- #3064: Container.on_click=None 일 때 Container.on_tap_down이 호출되지 않음

<div class="content-ad"></div>

# 사용 중단 사항

- 모든 Page.window_*** 속성은 더 이상 사용되지 않으며 Page.window 속성으로 이동되었습니다. 이 속성은 Window 유형입니다. 이전 방식에서 새로운 방식으로 마이그레이션하려면 아래와 같이 window_를 window.으로 변경하면 됩니다:

```js
# 이전 방식
page.window_height = 200
page.on_window_event = lambda e: print(e.type)

# 현재 방식
page.window.height = 200
page.window.on_event = lambda e: print(e.type)
```

- SafeArea: minimum 속성이 사용 중단되었으며 minimum_padding으로 이름이 변경되었습니다.
- MaterialState 열거형이 사용 중단되었으며 ControlState으로 이름이 변경되었습니다.
- NavigationDestination이 사용 중단되었으며 NavigationBarDestination으로 이름이 변경되었습니다.

<div class="content-ad"></div>

또한, 폐기 정책이 수정되었습니다. Flet이 1.0 미만 버전인 동안, 모든 폐기 항목은 다음 3개의 릴리스 이후 API에서 제거될 예정입니다.

따라서 v0.23.0에서 만든 위의 폐기 항목(및 이전 버전에서 만든 모든 다른 폐기 항목)은 v0.26.0에서 제거될 예정입니다.

# 결론

그러니 여전히 Flet 버전을 업데이트하지 않으셨다면, 아래 명령을 사용하여 업데이트할 수 있습니다:

<div class="content-ad"></div>

```bash
pip install flet --upgrade
```

정말 솔직히 말해서, Flet은 정말 빠르게 발전하고 있고 이미 파이썬에서 크로스 플랫폼 GUI 개발을 혁신할 것입니다!

이 모든 것은 활기찬 Flet 커뮤니티 덕분에 가능한 것입니다!

문제가 발생하거나 궁금한 점이 있으면 Flet Discord 서버에 참여하거나 Flet의 GitHub 리포지토리에서 새로운 토론을 열어보세요.

<div class="content-ad"></div>

읽어주셔서 감사해요 — 다음 시간에 뵙겠습니다!

그런데, 요즘 YouTube 채널을 시작했어요 — 구독해주셨나요? :)

# 쉽게 이해하는 영어로 🚀

In Plain English 커뮤니티의 일원이 되어 주셔서 감사합니다! 떠나시기 전에:

<div class="content-ad"></div>

- 작가를 환영하고 팔로우하는 것을 잊지 마세요! 👏
- 팔로우하기: X | LinkedIn | YouTube | Discord | Newsletter
- 다른 플랫폼 방문: CoFeed | Differ
- 자세한 콘텐츠: PlainEnglish.io