---
title: "Execution failed for task appcheckDebugDuplicateClasses 에러 해결하는 방법"
description: ""
coverImage: "/assets/img/2024-06-21-HowtofixExecutionfailedfortaskappcheckDebugDuplicateClasses_0.png"
date: 2024-06-21 21:35
ogImage: 
  url: /assets/img/2024-06-21-HowtofixExecutionfailedfortaskappcheckDebugDuplicateClasses_0.png
tag: Tech
originalTitle: "How to fix Execution failed for task ‘:app:checkDebugDuplicateClasses’."
link: "https://medium.com/@Code-blast/how-to-fix-execution-failed-for-task-app-checkdebugduplicateclasses-fe0f420b0386"
---


```js
실패: 예외로 빌드가 실패했습니다.

* 무엇이 잘못되었나요:
:app:checkDebugDuplicateClasses 작업을 실행하는 동안 실행이 실패했습니다.
> com.android.build.gradle.internal.tasks.CheckDuplicatesRunnable을 실행하는 동안 오류가 발생했습니다.
   > 모듈 jetified-kotlin-stdlib-1.8.10 (org.jetbrains.kotlin:kotlin-stdlib:1.8.10)와 jetified-kotlin-stdlib-jdk8-1.6.21 (org.jetbrains.kotlin:kotlin-stdlib-jdk8:1.6.21)에서 발견된 중복 클래스 kotlin.collections.jdk8.CollectionsJDK8Kt
     모듈 jetified-kotlin-stdlib-1.8.10 (org.jetbrains.kotlin:kotlin-stdlib:1.8.10)와 jetified-kotlin-stdlib-jdk8-1.6.21 (org.jetbrains.kotlin:kotlin-stdlib-jdk8:1.6.21)에서 발견된 중복 클래스 kotlin.internal.jdk8.JDK8PlatformImplementations
     모듈 jetified-kotlin-stdlib-1.8.10 (org.jetbrains.kotlin:kotlin-stdlib:1.8.10)와 jetified-kotlin-stdlib-jdk8-1.6.21 (org.jetbrains.kotlin:kotlin-stdlib-jdk8:1.6.21)에서 발견된 중복 클래스 kotlin.internal.jdk8.JDK8PlatformImplementations$ReflectSdkVersion
     모듈 jetified-kotlin-stdlib-1.8.10 (org.jetbrains.kotlin:kotlin-stdlib:1.8.10)와 jetified-kotlin-stdlib-jdk8-1.6.21 (org.jetbrains.kotlin:kotlin-stdlib-jdk8:1.6.21)에서 발견된 중복 클래스 kotlin.jvm.jdk8.JvmRepeatableKt
     모듈 jetified-kotlin-stdlib-1.8.10 (org.jetbrains.kotlin:kotlin-stdlib:1.8.10)와 jetified-kotlin-stdlib-jdk8-1.6.21 (org.jetbrains.kotlin:kotlin-stdlib-jdk8:1.6.21)에서 발견된 중복 클래스 kotlin.random.jdk8.PlatformThreadLocalRandom
     모듈 jetified-kotlin-stdlib-1.8.10 (org.jetbrains.kotlin:kotlin-stdlib:1.8.10)와 jetified-kotlin-stdlib-jdk8-1.6.21 (org.jetbrains.kotlin:kotlin-stdlib-jdk8:1.6.21)에서 발견된 중복 클래스 kotlin.streams.jdk8.StreamsKt
     ...
  
* 해결 방법:
> 스택 트레이스를 가져오려면 --stacktrace 옵션을 사용하십시오.
> 더 많은 로그 출력을 얻으려면 --info 또는 --debug 옵션으로 실행하십시오.
> 전체 통찰을 얻으려면 --scan으로 실행하십시오.

* https://help.gradle.org에서 더 많은 도움을 받을 수 있습니다.

빌드 완료: 1 분 9 초 
Gradle 작업 'assembleDebug' 실행 중...                             72.5초
예외: Gradle 작업 assembleDebug의 종료 코드가 1로 실패했습니다
```

저는 zegocloud SDK를 활용한 앱을 생성하면서 이 오류를 만났어요.

이 오류를 해결하는 방법은 간단합니다. 아래 코드 라인을 추가하는 것뿐이에요.

```js
ext.kotlin_version = '1.8.0-Beta'
```

<div class="content-ad"></div>

Android build.gradle 파일에서 작업하고 있군요.

다음과 같이 수정하면 됩니다.

```js
buildscript {
    ext.kotlin_version = '1.7.10'
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath 'com.android.tools.build:gradle:7.2.0'
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
    }
}
```

<div class="content-ad"></div>

```kotlin
buildscript {
    ext.kotlin_version = '1.8.0-Beta'
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath 'com.android.tools.build:gradle:7.2.0'
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
    }
}
```

그 다음 앱을 다시 실행하면 문제가 해결될 것입니다.