---
title: "Flutter 프로젝트의 pubspecyaml에서 assets 추가하는 방법"
description: ""
coverImage: "/assets/img/2024-06-21-pubspecyamlflutterassets_0.png"
date: 2024-06-21 23:22
ogImage: 
  url: /assets/img/2024-06-21-pubspecyamlflutterassets_0.png
tag: Tech
originalTitle: "pubspec.yaml flutter assets"
link: "https://medium.com/@upendercheruku757/pubspec-yaml-flutter-assets-4d021bc3ff94"
---


네, 저는 플러터(Flutter) 프로젝트용 `pubspec.yaml` 파일이 어떻게 구조화되어야 하는지 예시를 제공할 수 있어요. 여기서는 이미지, 폰트 및 기타 파일과 같은 에셋을 정의하는 데 초점을 맞추겠어요. 이 파일은 플러터 프로젝트에서 의존성 및 에셋을 관리하는 데 중요합니다.

각 섹션을 자세하게 설명하는 주석이 포함된 예시 `pubspec.yaml` 파일은 다음과 같습니다:

```yaml
name: my_flutter_app
description: A new Flutter project.

# 애플리케이션의 버전
version: 1.0.0+1
```

<div class="content-ad"></div>

# 환경 및 Flutter SDK 버전 제약사항 정의
환경:
  sdk: “`=2.12.0 ❤.0.0” 
  flutter: “`=2.0.0”

# 응용 프로그램에서 사용하는 외부 패키지 의존성
의존성:
  flutter:
    sdk: flutter

# 앱에서 사용하는 추가 패키지
cupertino_icons: ^1.0.2
http: ^0.13.3
provider: ^6.0.0

# 테스트 및 앱 빌드를 위한 개발 의존성
dev_dependencies:
  flutter_test:
    sdk: flutter

<div class="content-ad"></div>

# Dart용 Linter 규칙
lint: ^1.5.0

# Flutter에 특화된 설정
flutter:

# assets 섹션에는 앱과 번들로 제공되는 자산을 정의합니다
assets:
- assets/images/
- assets/icons/
- assets/audio/

# 앱에서 사용되는 사용자 정의 글꼴 정의
fonts:
- family: Roboto
  fonts:
    - asset: assets/fonts/Roboto-Regular.ttf
    - asset: assets/fonts/Roboto-Bold.ttf
      weight: 700
    - asset: assets/fonts/Roboto-Italic.ttf
      style: italic

<div class="content-ad"></div>

# 앱이 플러그인을 사용하는 경우 여기에 플러그인 구성을 지정할 수 있습니다.
plugin:
platforms:
android:
package: com.example.my_flutter_app
pluginClass: MyFlutterAppPlugin

# 기타 구성 (선택 사항)
# 빌드 대상 정의, 포함되거나 제외되어야 하는 파일 지정 등의 예시


### `pubspec.yaml` 섹션 설명:

1. **기본 정보**:
— `name`: Flutter 애플리케이션의 이름
— `description`: 앱에 대한 간단한 설명
— `version`: 애플리케이션의 버전, 일반적으로 `major.minor.patch+build` 형식으로 되어 있습니다.

<div class="content-ad"></div>

2. **환경**:
- `sdk`: 앱에서 지원하는 Dart SDK 버전 범위를 지정합니다.
- `flutter`: 앱에서 지원하는 Flutter SDK 버전 범위를 지정합니다.

3. **의존성**:
- `dependencies`: 앱이 의존하는 패키지를 나열합니다.
- `dev_dependencies`: 테스트 또는 앱 빌드와 같은 개발 목적으로 사용되는 패키지를 나열합니다.

4. **Flutter 구성**:
- `flutter`: 이 섹션은 Flutter에 특화되어 있으며 에셋, 폰트 및 플러그인 구성을 포함합니다.
- `assets`: 앱에 에셋으로 포함할 디렉터리나 파일을 나열합니다. 앱은 이후에 이러한 에셋을 실행 시점에로드할 수 있습니다.
- `fonts`: 앱에서 사용되는 사용자 정의 폰트를 정의합니다. 각 폰트 패밀리는 서로 다른 무게와 스타일을 지정하는 여러 폰트 파일을 가질 수 있습니다.
- `plugin`: 앱에서 사용 중인 플러그인에 대한 설정을 지정하여 플랫폼별 설정을합니다.

### 에셋 관리 팁:
- **에셋 구성**: 에셋을 하위 디렉터리에 구성하여 프로젝트 구조를 깔끔하게 유지하세요 (예: `images`, `icons`, `audio`).
- **의미있는 이름 사용**: 에셋에 의미 있는 이름을 지어 코드에서 쉽게 식별하고 참조할 수 있도록 하세요.
- **에셋 선언**: 모든 에셋 디렉토리 및 파일이 앱에서 접근할 수 있도록 `pubspec.yaml` 파일에 선언되었는지 확인하세요.

<div class="content-ad"></div>

### 코드에서의 사용 예시:
`pubspec.yaml` 파일에서 선언된 이미지 애셋을 사용하려면:
```dart
Image.asset(‘assets/images/my_image.png’)
```

`pubspec.yaml` 파일에서 선언된 사용자 지정 폰트를 사용하려면:
```dart
Text(
‘안녕, 세상!’,
style: TextStyle(
fontFamily: ‘Roboto’,
fontWeight: FontWeight.bold,
),
)
```

이 구조를 따라가고 `pubspec.yaml` 파일을 적절히 구성함으로써 Flutter 프로젝트에서 의존성 및 애셋을 효율적으로 관리하고 개발 프로세스를 원할하게 진행할 수 있습니다.