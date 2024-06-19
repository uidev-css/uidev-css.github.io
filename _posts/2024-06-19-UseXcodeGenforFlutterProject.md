---
title: "XcodeGen을 Flutter 프로젝트에 활용해보세요"
description: ""
coverImage: "/assets/img/2024-06-19-UseXcodeGenforFlutterProject_0.png"
date: 2024-06-19 14:26
ogImage: 
  url: /assets/img/2024-06-19-UseXcodeGenforFlutterProject_0.png
tag: Tech
originalTitle: "Use XcodeGen for Flutter Project"
link: "https://medium.com/@lllttt06/use-xcodegen-for-flutter-project-6084b695a7b6"
---


# 소개

저는 Flutter용 XcodeGen을 사용하여 ios/Runner.xcodeproj를 생성하는 샘플 리포지토리를 만들었습니다.

project.yml은 두 가지 flavor dev 및 prd 간에 다음을 전환할 수 있도록 구성되어 있습니다:
- 앱 아이콘
- 앱 표시 이름
- 번들 식별자
- Firebase 프로젝트

# project.pbxproj의 고통

<div class="content-ad"></div>

Flutter로 iOS 앱을 개발할 때가 있습니다. Xcode에서 열고 편집해야 할 때가 있습니다. Xcode의 GUI로 편집한 후에는 ios/Runner.xcodeproj/project.pbxproj와 같이 이해하기 어려운 차이점을 볼 수도 있습니다:

![차이점](/assets/img/2024-06-19-UseXcodeGenforFlutterProject_0.png)

iOS 개발에서 Xcode를 사용하는 여러 사람은 종종 이 파일에서 충돌을 일으킵니다. 이 문제를 해결하는 도구 중 하나가 XcodeGen입니다.

# XcodeGen이란?

<div class="content-ad"></div>

XcodeGen은 project.yml과 같은 yml 파일로부터 .xcodeproj를 생성하는 도구입니다. Flutter에서는 ios/Runner.xcodeproj 하위에 생성된 파일들이 해당 범주에 속합니다.

```js
yaml:project.yml
name: Runner
options:
  xcodeVersion: '15.4.0'
  developmentLanguage: ja
  deploymentTarget:
    iOS: 16.0
include:
  - xcodegen/setting/base.yml
configs:
  Debug: Debug
  Debug-dev: Debug-dev
  Debug-prd: Debug-prd
  Profile: Profile
  Profile-dev: Profile-dev
  Profile-prd: Profile-prd
  Release: Release
  Release-dev: Release-dev
  Release-prd: Release-prd
...
```

XcodeGen의 자세한 사용법 및 설명은 많은 기사들을 참고해주시기 바랍니다.

# SPM (Swift Package Manager)와의 비교

<div class="content-ad"></div>

2024 년 6 월 기준으로 SPM 사용이 iOS 커뮤니티에서 비슷한 문제에 대한 솔루션으로 더 인기가 있어지고 있습니다. Flutter에는 SPM 지원을 위한 PR도 있습니다.
그러나 Flutter v3.22.0에서는 사용할 수 없고, 패키지가 지원하지 않으면 CocoaPods를 함께 사용해야 하기 때문에 이번에는 채택하지 않았습니다.

# Flutter 개발에서 XcodeGen 사용

Flutter 개발에서 project.pbxproj은 드물게 충돌하지만, 차이가 복잡할 수 있어 PR 리뷰를 어렵게 만들 수 있습니다. 대부분의 XcodeGen 관련 문서 및 정보는 네이티브 iOS 개발을 대상으로 하기 때문에, Flutter 개발에서 XcodeGen을 사용하기 위한 샘플 저장소를 만들었습니다.

이 저장소는 두 가지 flavor, 개발 및 프로덕션,을 가진 Flutter 앱을 위해 project.yml을 생성하여 .xcodeproj를 생성합니다. 일반적인 Flutter 사용 사례를 가정하여 다음 요소를 각 flavor에 나누어 분리합니다:
- 앱 아이콘
- 앱 표시 이름
- 번들 ID
- Firebase 프로젝트사용은 간단합니다; .tool-versions에 정의된 도구를 준비한 후, 다음 명령을 실행하여 .xcodeproj를 생성하고 앱을 실행할 수 있습니다.

<div class="content-ad"></div>

```js
sh
cd ios && xcodegen generate
flutter run --flavor dev(or prd)
```

# XcodeGen 파일 구조

XcodeGen과 관련된 파일 구조는 다음과 같습니다:

```js
ios
├── project.yml
└── xcodegen
   ├── script
   │ ├── check_pods_manifest.sh
   │ ├── copy_pods_resources.sh
   │ ├── crashlytics_upload_symbols.sh
   │ ├── embed_pods_frameworks.sh
   │ ├── run_script.sh
   │ ├── select_google_service_info_plist.sh
   │ └── thin_binary.sh
   └── setting
      ├── base.yml
      ├── debug-dev.yml
      ├── debug-prd.yml
      ├── debug.yml
      ├── profile-dev.yml
      ├── profile-prd.yml
      ├── profile.yml
      ├── release-dev.yml
      ├── release-prd.yml
      └── release.yml
```

<div class="content-ad"></div>

ios/xcodegen/script/ 디렉토리에서는 Xcode의 Build Phases 탭에 정의된 스크립트가 추출됩니다.

```js
#!/bin/sh

/bin/sh "$FLUTTER_ROOT/packages/flutter_tools/bin/xcode_backend.sh" build
```

![이미지](/assets/img/2024-06-19-UseXcodeGenforFlutterProject_1.png)

ios/xcodegen/setting/ 디렉토리에는 각 구성에 대한 빌드 설정 탭 내용이 설명되어 있습니다. base.yml은 각 구성에 대한 값의 포함과 공통 설정의 설명을 처리합니다.

<div class="content-ad"></div>

해당 main project.yml 파일의 전체 구조는 다음과 같습니다. 각 항목의 상세 설명은 공식 문서를 참조해주세요.

```yaml
name: Runner

options:
  xcodeVersion: '15.4.0'
  developmentLanguage: ja
  deploymentTarget:
    iOS: 16.0

include:
  - xcodegen/setting/base.yml

configs:
  Debug: Debug
  Debug-dev: Debug-dev
  Debug-prd: Debug-prd
  Profile: Profile
  Profile-dev: Profile-dev
  Profile-prd: Profile-prd
  Release: Release
  Release-dev: Release-dev
  Release-prd: Release-prd

targets:
  Runner:
    type: application
    platform: iOS
    configFiles:
      Debug: Flutter/Debug.xcconfig
      Debug-dev: Flutter/Debug.xcconfig
      Debug-prd: Flutter/Debug.xcconfig
      Profile: Flutter/Profile.xcconfig
      Profile-dev: Flutter/Profile.xcconfig
      Profile-prd: Flutter/Profile.xcconfig
      Release: Flutter/Release.xcconfig
      Release-dev: Flutter/Release.xcconfig
      Release-prd: Flutter/Release.xcconfig

    sources:
      # - GoogleService-Info.plist
      - Flutter/AppFrameworkInfo.plist
      - Flutter/Generated.xcconfig
      - Flutter/Debug.xcconfig
      - Flutter/Profile.xcconfig
      - Flutter/Release.xcconfig
      - path: Runner/

    dependencies:
      - sdk: Pods_Runner.framework
        embed: false
        link: true

    preBuildScripts:
      - name: '[CP] Check Pods Manifest.lock'
        path: xcodegen/script/check_pods_manifest.sh
        inputFiles:
          - ${PODS_PODFILE_DIR_PATH}/Podfile.lock
          - ${PODS_ROOT}/Manifest.lock
        outputFiles:
          - $(DERIVED_FILE_DIR)/Pods-Runner-checkManifestLockResult.txt
      - name: Run Script
        path: xcodegen/script/run_script.sh

    # If you use different Firebase Project for each environment, you can use this script.
    # postCompileScripts:
    #   - name: Select GoogleService-Info.plist
    #     path: xcodegen/script/select_google_service_info_plist.sh
    #     outputFiles:
    #       - ${SRCROOT}/GoogleService-Info.plist

    postBuildScripts:
      - name: Thin Binary
        path: xcodegen/script/thin_binary.sh
        inputFiles:
          - ${TARGET_BUILD_DIR}/${INFOPLIST_PATH}

      # If you use Firebase Crashlytics, you can use this script.
      # - name: '[firebase_crashlytics] Crashlytics Upload Symbols'
      #   path: xcodegen/script/crashlytics_upload_symbols.sh
      #   inputFiles:
      #     - ${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}
      #     - ${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Resources/DWARF/${PRODUCT_NAME}
      #     - ${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Info.plist
      #     - $(TARGET_BUILD_DIR)/$(UNLOCALIZED_RESOURCES_FOLDER_PATH)/GoogleService-Info.plist
      #     - $(TARGET_BUILD_DIR)/$(EXECUTABLE_PATH)


    settings:
      base:
        ASSETCATALOG_COMPILER_INCLUDE_ALL_APPICON_ASSETS: NO
        CLANG_ENABLE_MODULES: YES
        CURRENT_PROJECT_VERSION: '$(FLUTTER_BUILD_NUMBER)'
        # TODO: DEVELOPMENT_TEAM
        # DEVELOPMENT_TEAM: YOUR_TEAM_ID
        ENABLE_BITCODE: NO
        INFOPLIST_FILE: Runner/Info.plist
        SWIFT_OBJC_BRIDGING_HEADER: 'Runner/Runner-Bridging-Header.h'
        SWIFT_VERSION: 5.0
        VERSIONING_SYSTEM: 'apple-generic'
      configs:
        Profile-prd:
          ASSETCATALOG_COMPILER_APPICON_NAME: 'AppIcon-prd'
          PRODUCT_BUNDLE_IDENTIFIER: com.example.flutterXcodegenSample
          PRODUCT_NAME: 'PRD'

        Profile-dev:
          ASSETCATALOG_COMPILER_APPICON_NAME: 'AppIcon-dev'
          PRODUCT_BUNDLE_IDENTIFIER: com.example.flutterXcodegenSample.dev
          PRODUCT_NAME: 'DEV'

        Release-prd:
          ASSETCATALOG_COMPILER_APPICON_NAME: 'AppIcon-prd'
          PRODUCT_BUNDLE_IDENTIFIER: com.example.flutterXcodegenSample
          PRODUCT_NAME: 'PRD'

        Release-dev:
          ASSETCATALOG_COMPILER_APPICON_NAME: 'AppIcon-dev'
          PRODUCT_BUNDLE_IDENTIFIER: com.example.flutterXcodegenSample.dev
          PRODUCT_NAME: 'DEV'

        Debug-prd:
          ASSETCATALOG_COMPILER_APPICON_NAME: 'AppIcon-prd'
          PRODUCT_BUNDLE_IDENTIFIER: com.example.flutterXcodegenSample
          PRODUCT_NAME: 'PRD'
          SWIFT_OPTIMIZATION_LEVEL: '-Onone'

        Debug-dev:
          ASSETCATALOG_COMPILER_APPICON_NAME: 'AppIcon-dev'
          PRODUCT_BUNDLE_IDENTIFIER: com.example.flutterXcodegenSample.dev
          PRODUCT_NAME: 'DEV'
          SWIFT_OPTIMIZATION_LEVEL: '-Onone'

        Debug:
          ASSETCATALOG_COMPILER_APPICON_NAME: 'AppIcon-prd'
          PRODUCT_BUNDLE_IDENTIFIER: com.example.flutterXcodegenSample
          PRODUCT_NAME: 'NONE'
          SWIFT_OPTIMIZATION_LEVEL: '-Onone'

        Release:
          ASSETCATALOG_COMPILER_APPICON_NAME: 'AppIcon-prd'
          PRODUCT_BUNDLE_IDENTIFIER: com.example.flutterXcodegenSample
          PRODUCT_NAME: 'NONE'

        Profile:
          ASSETCATALOG_COMPILER_APPICON_NAME: 'AppIcon-prd'
          PRODUCT_BUNDLE_IDENTIFIER: com.example.flutterXcodegenSample
          PRODUCT_NAME: 'NONE'


schemes:
  Runner:
    build:
      targets:
        Runner: all
    run:
      config: Debug
    test:
      config: Debug
    profile:
      config: Profile
    analyze:
      config: Debug
    archive:
      config: Release
  dev:
    build:
      targets:
        Runner: all
    run:
      config: Debug-dev
    test:
      config: Debug-dev
    profile:
      config: Profile-dev
    analyze:
      config: Debug-dev
    archive:
      config: Release-dev
  prd:
    build:
      targets:
        Runner: all
    run:
      config: Debug-prd
    test:
      config: Debug-prd
    profile:
      config: Profile-prd
    analyze:
      config: Debug-prd
    archive:
      config: Release-prd
```

<div class="content-ad"></div>

파이어베이스 프로젝트 설정을 완료한 후, 각 flavor에 사용하려는 GoogleService-Info.plist를 ios/GoogleService/'Flavor' 아래에 배치하세요. 또한, 빌드 중에 각 flavor용 GoogleService-Info.plist를 ios/로 복사하는 스크립트를 실행해야 합니다. 이 설정들은 주석 처리되어 있으므로 필요에 따라 주석을 해제해주세요.

```js
# 각 환경에 별도의 Firebase 프로젝트를 사용하는 경우, 다음 스크립트를 사용할 수 있습니다.
# postCompileScripts:
#   - name: Select GoogleService-Info.plist
#     path: xcodegen/script/select_google_service_info_plist.sh
#     outputFiles:
#       - ${SRCROOT}/GoogleService-Info.plist
## Firebase Crashlytics를 사용할 때
```

콘솔 로그를 더 가독성 있게 만들기 위해, postBuildPhase에 dSYM을 업로드해야 합니다. 이 또한 주석 처리되어 있으니 필요에 따라 주석을 해제해주세요.

```js
# Firebase Crashlytics를 사용한다면, 다음 스크립트를 사용할 수 있습니다.
# - name: '[firebase_crashlytics] Crashlytics Upload Symbols'
#   path: xcodegen/script/crashlytics_upload_symbols.sh
#   inputFiles:
#     - ${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}
#     - ${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Resources/DWARF/${PRODUCT_NAME}
#     - ${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Info.plist
#     - $(TARGET_BUILD_DIR)/$(UNLOCALIZED_RESOURCES_FOLDER_PATH)/GoogleService-Info.plist
#     - $(TARGET_BUILD_DIR)/$(EXECUTABLE_PATH)
```

<div class="content-ad"></div>

# 결론

처음에 XcodeGen을 이해하는 것은 어려울 수 있지만, 이 문서가 도움이 되기를 바랍니다! 모든 지침에 대해 cokaholic🐰🍁☄️🪐에게 특별히 감사드립니다!