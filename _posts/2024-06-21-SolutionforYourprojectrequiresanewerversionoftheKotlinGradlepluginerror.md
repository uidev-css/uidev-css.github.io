---
title: "Your project requires a newer version of the Kotlin Gradle plugin 오류 해결 방법"
description: ""
coverImage: "/assets/img/2024-06-21-SolutionforYourprojectrequiresanewerversionoftheKotlinGradlepluginerror_0.png"
date: 2024-06-21 20:43
ogImage: 
  url: /assets/img/2024-06-21-SolutionforYourprojectrequiresanewerversionoftheKotlinGradlepluginerror_0.png
tag: Tech
originalTitle: "Solution for “Your project requires a newer version of the Kotlin Gradle plugin.” error"
link: "https://medium.com/@emrnel/solution-for-your-project-requires-a-newer-version-of-the-kotlin-gradle-plugin-error-3125f332c224"
---


안녕하세요 여러분,

이것은 제 첫 번째 미디엄 이야기입니다. 저는 저와 비슷한 사람들이 쉽게 이용 가능한 해결책을 찾지 못할 수도 있는 문제를 겪을 수 있을 것이라고 생각하기 때문에 이것을 쓰게 되었습니다.

저는 현재 플러터 앱을 개발하고 있으며 ARCore Flutter 플러그인을 활용하고 있습니다. 그러나 제 프로그램 실행 중 다음과 같은 오류를 만났습니다:

“Module was compiled with an incompatible version of Kotlin. The binary version of its metadata is 1.9.0, expected version is 1.7.0.”

<div class="content-ad"></div>

정확한 버전 번호는 다를 수 있지만, Kotlin과의 호환성 문제가 문제의 핵심이었습니다. 처음에는 모듈에 대한 호환되지 않는 Kotlin 버전이 무엇인지 확신이 없었습니다. 그러나 몇 시간 동안의 연구 끝에 Kotlin Gradle 버전을 수동으로 업데이트해야 한다는 것을 알게 되었습니다.

내가 발견한 해결책 중 많은 것들이 이전 버전의 Android Studio Bumblebee에 관한 것이었고, gradle 파일을 수정하는 방법에 대한 지침을 제공했습니다. 이러한 해결책들은 일반적으로 android/build.gradle의 buildscript 섹션을 수정하는 것을 제안했습니다. 아래는 추천 사항에서 일반적인 buildscript 섹션의 일부분입니다:

```js
buildscript {
    ext.kotlin_version = '1.3.50'
    repositories {
        google()
        jcenter()
    }

    dependencies {
        classpath 'com.android.tools.build:gradle:4.0.1'
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
    }
}
```

그러나 조만간 이 buildscript 구성이 Bumblebee 업데이트 이전에 존재했음을 깨달았습니다. 더 최근의 해결책들은 여전히 파일의 처음이나 다른 곳에 buildscript 블록을 수동으로 추가하는 것을 권장했습니다. 안타깝게도, 이러한 제안들 중 어느 것도 내 문제를 해결해 주지 못했습니다.

<div class="content-ad"></div>

1) android/settings.gradle 파일로 이동해주세요.

2) 다음과 비슷한 섹션을 만날 것입니다:

```js
pluginManagement {
    def flutterSdkPath = {
        def properties = new Properties()
        file("local.properties").withInputStream { properties.load(it) }
        def flutterSdkPath = properties.getProperty("flutter.sdk")
        assert flutterSdkPath != null, "local.properties에 flutter.sdk가 설정되지 않았습니다"
        return flutterSdkPath
    }
    settings.ext.flutterSdkPath = flutterSdkPath()

    includeBuild("${settings.ext.flutterSdkPath}/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id "dev.flutter.flutter-plugin-loader" version "1.0.0"
    id "com.android.application" version "7.3.0" apply false
    id "org.jetbrains.kotlin.android" version "1.7.10" apply false
}

include ":app"
```

3) plugins 섹션 아래에서 문제를 일으키는 id "org.jetbrains.kotlin.android" version "1.7.10" apply false 줄을 찾아보세요.

<div class="content-ad"></div>

여기서 Kotlin 버전을 변경하세요. 저의 경우에는 1.9.0으로 업데이트했고, 문제가 해결되었어요.

이 해결책이 동일한 오류를 겪는 다른 사람들에게 도움이 되기를 바랍니다. 즐거운 하루 되세요!