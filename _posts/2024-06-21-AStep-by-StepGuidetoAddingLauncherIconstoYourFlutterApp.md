---
title: "Flutter 앱에 런처 아이콘 추가하는 단계별 가이드"
description: ""
coverImage: "/assets/img/2024-06-21-AStep-by-StepGuidetoAddingLauncherIconstoYourFlutterApp_0.png"
date: 2024-06-21 22:12
ogImage: 
  url: /assets/img/2024-06-21-AStep-by-StepGuidetoAddingLauncherIconstoYourFlutterApp_0.png
tag: Tech
originalTitle: "A Step-by-Step Guide to Adding Launcher Icons to Your Flutter App"
link: "https://medium.com/@nikhilsomansahu/a-step-by-step-guide-to-adding-launcher-icons-to-your-flutter-app-98b5d7e3bb04"
---


소개: 모바일 앱 개발 세계에서 시각적으로 매력적이고 인식하기 쉬운 런처 아이콘을 만드는 것은 사용자에게 지속적으로 영향을 줄 수 있는 중요한 요소입니다. 플러터(Flutter)는 구글의 네이티브 컴파일된 애플리케이션을 구축하는 UI 툴킷으로, 앱에 런처 아이콘을 추가하는 간단한 프로세스를 제공합니다.

이 가이드에서는 당신의 플러터 앱이 설치되는 순간부터 돋보이도록 보장하기 위한 단계별 프로세스를 안내해 드리겠습니다.

![아이콘 디자인 준비](/assets/img/2024-06-21-AStep-by-StepGuidetoAddingLauncherIconstoYourFlutterApp_0.png)

## 단계 1: 아이콘 디자인 준비

<div class="content-ad"></div>

기술적인 세부 정보에 들어가기 전에 잘 디자인된 런처 아이콘이 있는지 확인해주세요. Flutter에서 런처 아이콘의 권장 크기는 512x512 픽셀입니다. 아이콘이 앱의 본질을 명확하고 간결하게 시각적으로 나타내도록 해주세요.

# 단계 2: 필요한 이미지 자산 생성

Flutter는 런처 아이콘을 포함한 자산을 관리하기 위해 pubspec.yaml이라는 구성 파일을 사용합니다. 시작하려면 pubspec.yaml 파일에 다음 줄을 추가해주세요:

```yaml

<div class="content-ad"></div>

flutter:
  assets:
    - assets/

프로젝트 디렉토리 내 "assets" 폴더에 아이콘 이미지를 넣어주세요.

# 단계 3: Flutter Launcher Icons 패키지 설치

다양한 플랫폼용 런처 아이콘을 생성하는 과정을 간소화하기 위해 "flutter_launcher_icons" 패키지를 사용할 수 있습니다. 다음 의존성을 pubspec.yaml 파일에 추가해주세요:

<div class="content-ad"></div>

YAML

```
dev_dependencies:
  flutter_launcher_icons: ^0.13.1


터미널에서 `flutter pub get`을 실행하여 패키지를 가져오세요.

# 단계 4: 런처 아이콘 구성하기

<div class="content-ad"></div>

패키지를 설치한 후에는 `pubspec.yaml` 파일에 다음 줄을 추가하여 구성해야 합니다:

```yaml
flutter_icons:
  android: true
  ios: true
  image_path: "assets/icon/icon.png"
```

"assets/icon/icon.png"을 사용자의 아이콘 이미지 경로로 변경해주세요.

<div class="content-ad"></div>

# 단계 5: 플러터 런처 아이콘 명령 실행

이제 필요한 파일을 생성하고 새 런처 아이콘으로 앱을 업데이트할 명령을 실행할 시간입니다. 터미널에서 다음 명령을 실행하세요:

```bash
flutter pub run flutter_launcher_icons:main
```

<div class="content-ad"></div>

이 명령어는 Android 및 iOS용 필요한 아이콘 파일을 생성합니다.

# 단계 6: 앱 실행하기

새로 생성된 런처 아이콘을 사용하여 Flutter 앱을 Android 및 iOS 기기 또는 에뮬레이터에서 실행하여 변경 사항이 적용되는지 확인하세요.

Flutter 앱에 사용자 정의 런처 아이콘을 추가하는 것은 간단하면서도 효과적인 방법으로 세련되고 전문적인 사용자 경험을 제공할 수 있습니다. 이 단계를 따르고 디자인 세부 사항에 주의를 기울이면 앱에 대한 기억에 남는 첫인상을 만들어낼 수 있습니다. 런처 아이콘을 사용자 정의하는 것은 앱의 미적인 면을 개선할 뿐만 아니라, 모바일 애플리케이션의 경쟁적인 세계에서 강력한 브랜드 아이덴티티를 구축하는 데 도움이 됩니다.

<div class="content-ad"></div>

제 트위터 팔로우해주세요 - https://twitter.com/Nikhilsomansah