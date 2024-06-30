---
title: "Flutter에서 동적으로 앱 아이콘 변경하는 방법"
description: ""
coverImage: "/assets/img/2024-06-23-DynamicchangeAppIconFlutter_0.png"
date: 2024-06-23 14:51
ogImage:
  url: /assets/img/2024-06-23-DynamicchangeAppIconFlutter_0.png
tag: Tech
originalTitle: "Dynamic change App Icon Flutter"
link: "https://medium.com/@diego.mazega/dynamic-change-app-icon-flutter-061dae4da40e"
---

안녕하세요! 이번 기사에서는 앱 아이콘을 동적으로 변경하는 방법을 구성하고 코딩하는 방법을 살펴보겠습니다. 안드로이드에서는 원하는 경우 라벨도 변경할 수 있습니다.

우선, 새로운 Flutter 프로젝트를 만들어보세요. 저희 예시에서는 dynamic_icon_example이라는 프로젝트를 만들었습니다. 너무 많은 코딩 시간을 낭비하지 않도록 미리 만들어둔 예시 코드를 사용하겠습니다.

시작해봅시다. 첫 번째로 이해해야 할 것은 MethodChannel입니다. 이 클래스를 사용하면 Flutter 애플리케이션 내에서 네이티브 코드를 작성할 수 있으며 (iOS의 경우 Swift, Android의 경우 Kotlin), 이 코드를 호출할 수 있습니다. 실용적인 예시를 살펴보겠습니다.

앱 폴더 내에서 android → app → src → main → kotlin → MainActivity.kt 파일을 열어보세요. 다음과 같은 내용을 볼 수 있을 것입니다:

<div class="content-ad"></div>

![Dynamic Change App Icon](/assets/img/2024-06-23-DynamicchangeAppIconFlutter_0.png)

프로젝트를 생성할 때 생성된 이름이 첫 번째 줄입니다. 이제 Flutter 측에서 메소드를 호출하기 위한 코드를 작성해야 합니다. 여기에서 호출할 채널을 구성할 것인데, 그 채널의 이름은 "com.example.dynamic_icon_example/icon"으로 지정할 것입니다. 또한 몇 가지 import 문을 추가해야 합니다. 여기에 있습니다:

```js
package com.example.com.example.dynamic_icon_example

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
```

이제 도움이 될 몇 가지 속성을 만들 수 있습니다. MainActivity 클래스 내부에 두 개의 변수를 추가할 수 있습니다:

<div class="content-ad"></div>

```js
    private val CHANNEL = "app.com.get.number"
    var methodChannelResult: MethodChannel.Result? = null
```

CHANNEL 변수는 호출할 채널의 이름입니다; 원하는 이름을 넣을 수 있어요. 이후에 configureFlutterEngine을 오버라이드하고 우리의 메소드를 생성할 수 있어요.

```js
@Override
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor, CHANNEL).setMethodCallHandler { call, result ->
            try {
                methodChannelResult = result
                if (call.method.equals("odd")) {
                    result.success(1)
                } else if (call.method.equals("even")) {
                    result.success(2)
                } else {
                    result.success(-1)
                }
            } catch (e: Exception) {
                print(e)
            }
        }
    }
```

이렇게 하면 Flutter 측에서 우리의 메소드를 호출할 수 있어요. 마지막으로, 완전한 코드는 다음과 같아요:

<div class="content-ad"></div>

```kotlin
package com.example.dynamic_icon_example

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {

    private val CHANNEL = "app.com.get.number"
    var methodChannelResult: MethodChannel.Result? = null

    @Override
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor, CHANNEL).setMethodCallHandler { call, result ->
            try {
                methodChannelResult = result
                if (call.method.equals("odd")) {
                    result.success(1)
                } else if (call.method.equals("even")) {
                    result.success(2)
                } else {
                    result.success(-1)
                }
            } catch (e: Exception) {
                print(e)
            }
        }
    }
}
```

우리의 Android에서의 MethodChannel 설정이 완료되었습니다. 이제 iOS로 넘어갑시다. ios 폴더로 이동하여 `Runner` -> `AppDelegate.swift`로 이동해주세요.
![앱 아이콘을 동적으로 변경하는 플러터 앱의 스크린샷](/assets/img/2024-06-23-DynamicchangeAppIconFlutter_1.png)

여기가 iOS 측의 코드입니다. 코드는 다음과 같이 보일 것입니다:

<div class="content-ad"></div>

```js
import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let appIconChannel = FlutterMethodChannel(
      name: "com.example.dynamic_icon_example.get.number", binaryMessenger: controller.binaryMessenger)

    appIconChannel.setMethodCallHandler({
      [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
      if call.method == "odd" {
       result(1)
      } else if call.method == "even" {
        result(2)
      } else {
       result(-1)
        return
      }
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

위 코드를 설명하자면, 이 함수는 화면에서 선택한 홀수나 짝수에 따라 홀수나 짝수를 반환합니다. 이제 main.dart 파일로 돌아가서 코드를 작성할 수 있습니다. 소스 코드에서 모든 주석을 제거하고 \_incrementCounter라는 함수를 찾습니다. 이 함수를 비동기식으로 만듭니다. 상태(State) 내부에 채널을 호출할 변수를 만들 수 있습니다. 다음과 같이 채널을 호출하는 변수를 생성합니다:

```js
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final MethodChannel channel = const MethodChannel('com.example.dynamic_icon_example.get.number');
```

그리고 \_incrementCounter 함수 내부에서 메소드를 호출할 것입니다:

<div class="content-ad"></div>

```js
  Future<void> _incrementCounter() async {
    final int number =
        await channel.invokeMethod(_counter % 2 == 0 ? 'even' : 'odd');
    print(number);
    setState(() {
      _counter++;
    });
  }
```

그리고 디버그 콘솔에서 값들을 확인할 수 있습니다:

![이미지](/assets/img/2024-06-23-DynamicchangeAppIconFlutter_2.png)

이제 앱 아이콘을 동적으로 변경하는 방법에 대해 이야기해보겠습니다. 먼저 Android 및 iOS 앱을 구성해야 합니다.

<div class="content-ad"></div>

ANDROID

안녕하세요! 안드로이드 개발자 여러분!

android/app/src/main 폴더 안의 AndroidManifest.xml 파일을 열어주세요. `activity` 태그를 찾은 후, 그 안에 다음 코드를 추가해주세요:

```js
android: enabled = "false";
```

이후, 각 아이콘 변형에 대해 activity-alias를 생성할 건데요. 각 activity-alias 코드는 다음과 같이 보일 거에요:

<div class="content-ad"></div>

```js
<activity-alias
    android:name=".launcherAlias.one"
    android:enabled="false"
    android:icon="@mipmap/icon_launch"
    android:label="One"
    android:targetActivity=".MainActivity"
    android:exported="true">
    <intent-filter>
        <action android:name="android.intent.action.MAIN" />
        <category android:name="android.intent.category.LAUNCHER" />
    </intent-filter>
    <intent-filter>
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
    </intent-filter>
</activity-alias>

<activity-alias
    android:name=".launcherAlias.two"
    android:enabled="false"
    android:icon="@mipmap/icon_launch"
    android:label="Two"
    android:targetActivity=".MainActivity"
    android:exported="true">
    <intent-filter>
        <action android:name="android.intent.action.MAIN" />
        <category android:name="android.intent.category.LAUNCHER" />
    </intent-filter>
    <intent-filter>
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
    </intent-filter>
</activity-alias>

<activity-alias
    android:name=".launcherAlias.default"
    android:enabled="true"
    android:icon="@mipmap/icon_launch"
    android:label="Dynamic"
    android:targetActivity=".MainActivity"
    android:exported="true">
    <intent-filter>
        <action android:name="android.intent.action.MAIN" />
        <category android:name="android.intent.category.LAUNCHER" />
    </intent-filter>
    <intent-filter>
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
    </intent-filter>
</activity-alias>
```

2개의 추가 구성을 만들어 Android 앱 아이콘 및 앱 레이블을 변경할 것입니다. 아이콘만 변경하려면 각 activity-alias 정의에서 android:label 줄을 삭제하면 됩니다. 이제 이미지를 생성해야 합니다. 이미지를 생성하려면 이 사이트를 사용할 수 있습니다: AppIcon. 이제 각 activity-alias의 android:icon 속성을 mipmap 폴더 내의 이미지 이름과 일치하도록 변경하십시오. AndroidManifest.xml은 다음과 같아야 합니다:

```js
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <application
        android:label="Dynamic"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:enabled="false"
            android:launchMode="singleTop"
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            <!-- Specifies an Android theme to apply to this Activity as soon as
                 the Android process has started. This theme is visible to the user
                 while the Flutter UI initializes. After that, this theme continues
                 to determine the Window background behind the Flutter UI. -->
            <meta-data
                android:name="io.flutter.embedding.android.NormalTheme"
                android:resource="@style/NormalTheme"
            />
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
        <!-- Don't delete the meta-data below.
             This is used by the Flutter tool to generate GeneratedPluginRegistrant.java -->
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />

        <!-- 여기에 위의 activity-alias 코드를 붙여넣으세요 -->
    </application>
</manifest>

MainActivity.kt 파일이 있는 폴더로 이동하면, 각 alias에 대한 이름으로 파일을 생성해야 합니다. ".launcherAlias." 이후의 마지막 이름만 사용하면 됩니다. 제 경우에는 파일 이름이 Default.kt, One.kt, Two.kt 여야 합니다. 각 파일에 아래 코드를 복사하여 붙여넣고 이름만 변경하시면 됩니다.
```

<div class="content-ad"></div>

```kotlin
package com.example.dynamic_icon_example.launcherAlias

import io.flutter.embedding.android.FlutterActivity
// 각 alias의 이름을 변경합니다.
class Default: FlutterActivity() {
}
```

MainActivity에서는 앱의 아이콘과 라벨을 변경하는 코드를 만들 것입니다. CHANNEL의 이름을 변경하여 아이콘 변경을 나타내는 의미 있는 이름으로 바꿔주세요. 예를 들어, "app.com.get.change.icon"과 같은 이름을 사용했습니다.

다음은 사용할 주석이 달린 코드입니다:

```kotlin
package com.example.dynamic_icon_example

import android.content.ComponentName
import android.content.pm.PackageManager
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {

    // 채널의 이름
    private val CHANNEL = "app.com.get.change.icon"
    var methodChannelResult: MethodChannel.Result? = null
    // 초기 점을 제외한 모든 alias를 추가합니다.
    val aliases = listOf("launcherAlias.Default", "launcherAlias.One", "launcherAlias.Two")

    @Override
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor, CHANNEL).setMethodCallHandler { call, result ->
            try {
                methodChannelResult = result
                // 우리가 호출할 메소드
                if (call.method.equals("changeIcon")) {
                    // 전달된 이름을 복구합니다
                    val targetIcon = call.argument<String>("targetIcon") as String
                    // 변경을 수행할 함수를 호출합니다.
                    // 여기서 이미 "launcherAlias"를 추가했습니다.
                    setIcon("launcherAlias.$targetIcon")
                } else {
                    result.success(-1)
                }
            } catch (e: Exception) {
                print(e)
            }
        }
    }

    private fun setIcon(targetIcon: String) {
        try {
            // 사용할 패키지 이름을 포함하는 String을 작성합니다.
            val packageManager: PackageManager = applicationContext!!.packageManager
            val packageName = applicationContext!!.packageName
            val className = StringBuilder()
            className.append(packageName)
            className.append(".")
            className.append(targetIcon)

            aliases.forEach { alias ->
                // 모든 목록을 실행하고 설정할 것 외에는 모두 비활성화합니다.
                val state =
                    if (alias == targetIcon) PackageManager.COMPONENT_ENABLED_STATE_ENABLED
                    else PackageManager.COMPONENT_ENABLED_STATE_DISABLED

                // 새로운 아이콘과 라벨을 설정합니다.
                packageManager.setComponentEnabledSetting(
                    ComponentName(packageName, "com.example.dynamic_icon_example.$alias"),
                    state,
                    PackageManager.DONT_KILL_APP
                )
            }
        } catch (e: Exception) {
            print(e)
        }
    }
}
```

<div class="content-ad"></div>

플러터 쪽에서 main.dart의 \_incrementCounter 함수 내부에서:

```js
  Future<void> _incrementCounter() async {
// 네이티브 메서드를 호출하여 아이콘을 변경할 예정
// 아이콘의 최종 이름만 전달하면 "launcherAlias"는 kotlin 쪽에서 설정됨
    final dynamic number =
        await channel.invokeMethod('changeIcon', <String, dynamic>{'targetIcon': 'One'});
    print(number);
    setState(() {
      _counter++;
    });
  }
```

이제 테스트할 수 있습니다.

<img src="https://miro.medium.com/v2/resize:fit:1400/1*eICX4eVobzz-tyLme9W4Hg.gif" />

<div class="content-ad"></div>

본글에 나온 코드는 앱이 아이콘을 변경할 때 종료되는 문제를 해결하는 코드입니다. MainActivity 폴더로 돌아가 "SharedPref.kt"라는 다른 파일을 만들어 아래 코드를 붙여넣으세요:

```js
package com.example.dynamic_icon_example.helper

import android.content.Context
import android.content.Context.MODE_PRIVATE
import android.content.SharedPreferences

open class AppSharedPref {

    companion object {
        const val CONFIGURATION_PREF = "configurationPreference"

        /*런처 아이콘*/
        private const val KEY_LAUNCHER_IMAGE = "launcherIcon"
        private const val KEY_LAUNCHER_COUNT = "count"
        private const val KEY_LAUNCHER_SAVED_COUNT = "savedCount"

        fun getSharedPreference(context: Context, preferenceFile: String): SharedPreferences {
            return context.getSharedPreferences(preferenceFile, MODE_PRIVATE)
        }

        fun getSharedPreferenceEditor(
            context: Context,
            preferenceFile: String
        ): SharedPreferences.Editor {
            return context.getSharedPreferences(preferenceFile, MODE_PRIVATE).edit()
        }

        /* 설정 관련 함수 */

        fun getLauncherIcon(context: Context): String? {
            return getSharedPreference(context, CONFIGURATION_PREF)
                .getString(KEY_LAUNCHER_IMAGE, "launcherAlias.DefaultLauncherAlias")
        }

        fun setLauncherIcon(context: Context, launcherIcon: String) {
            getSharedPreferenceEditor(context, CONFIGURATION_PREF)
                .putString(KEY_LAUNCHER_IMAGE, launcherIcon)
                .apply()
        }

        fun getCount(context: Context): Int {
            return getSharedPreference(context, CONFIGURATION_PREF).getInt(KEY_LAUNCHER_COUNT, 0)
        }

        fun setCount(context: Context, count: Int) {
            getSharedPreferenceEditor(context, CONFIGURATION_PREF)
                .putInt(KEY_LAUNCHER_COUNT, count)
                .apply()
        }

        fun getSavedCount(context: Context): Int {
            return getSharedPreference(context, CONFIGURATION_PREF)
                .getInt(KEY_LAUNCHER_SAVED_COUNT, 0)
        }

        fun setSavedCount(context: Context, count: Int) {
            getSharedPreferenceEditor(context, CONFIGURATION_PREF)
                .putInt(KEY_LAUNCHER_SAVED_COUNT, count)
                .apply()
        }
    }
}
```

이 코드는 공유 설정을 사용하여 메모리에 아이콘 변경 정보를 저장합니다. 이제 MainActivity로 돌아가 일부 변경사항을 가해봅시다.

```js
package com.example.dynamic_icon_example

import android.content.ComponentName
import android.content.pm.PackageManager
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import com.example.dynamic_icon_example.helper.AppSharedPref

class MainActivity: FlutterActivity() {

    private val CHANNEL = "app.com.get.change.icon"
    var methodChannelResult: MethodChannel.Result? = null
    // initial dot을 뺀 모든 별칭을 추가하세요
    val aliases = listOf("launcherAlias.Default", "launcherAlias.One", "launcherAlias.Two")

    @Override
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor, CHANNEL).setMethodCallHandler { call, result ->
            try {
                methodChannelResult = result
                if (call.method.equals("changeIcon")) {
                    val targetIcon = call.argument<String>("targetIcon") as String
                    // 여기에서 정보를 저장하여 앱을 닫은 후 적용할 것입니다
                    AppSharedPref.setLauncherIcon(this, "launcherAlias.$targetIcon")
                    AppSharedPref.setCount(this, 0)
                } else {
                    result.success(-1)
                }
            } catch (e: Exception) {
                print(e)
            }
        }
    }

    // 우리 앱이 종료될 때 아이콘 및 레이블 변경을 호출할 메소드입니다
    override fun onDestroy() {
        setIcon(AppSharedPref.getLauncherIcon(this).toString())
        super.onDestroy()
    }

    private fun setIcon(targetIcon: String) {
        try {
            val packageManager: PackageManager = applicationContext!!.packageManager
            val packageName = applicationContext!!.packageName
            val className = StringBuilder()
            className.append(packageName)
            className.append(".")
            className.append(targetIcon)

            aliases.forEach { alias ->
                val state =
                    if (alias == targetIcon) PackageManager.COMPONENT_ENABLED_STATE_ENABLED
                    else PackageManager.COMPONENT_ENABLED_STATE_DISABLED

                packageManager.setComponentEnabledSetting(
                    ComponentName(packageName, "com.example.dynamic_icon_example.$alias"),
                    state,
                    PackageManager.DONT_KILL_APP
                )
            }
        } catch (e: Exception) {
            print(e)
        }
    }
}
```

<div class="content-ad"></div>

결과를 확인해봅시다:

<img src="https://miro.medium.com/v2/resize:fit:1400/1*yIABZsLhcIv84MjkGh1cWA.gif" />

IOS

iOS로 이동하여 Xcode로 열어주세요. Runner 디렉토리 내에 AlternativeIcons라는 폴더를 생성해주세요. 여기에 이미지를 저장하겠습니다.

<div class="content-ad"></div>

![이미지_이름](/assets/img/2024-06-23-DynamicchangeAppIconFlutter_3.png)

이제 Xcode의 Info.plist로 이동하여 "Icon files (iOS 5)"라는 매개변수를 Dictionary으로 추가하십시오. 이 매개변수 내에서 "CFBundleAlternateIcons"를 Dictionary로 추가하십시오. 그런 다음 사용하려는 각 새 이미지에 대해(예: "Default", "One", "Two") 새 항목을 만드십시오. 각 항목 내에서 "CFBundleIconFiles" 매개변수를 Array로 추가하십시오. 배열의 첫 번째 위치에는 이미지 이름을 @2x 또는 @3x 없이, .png 없이 사용하십시오.

최종적으로 아래와 같이 보여야 합니다:

![이미지_이름](/assets/img/2024-06-23-DynamicchangeAppIconFlutter_4.png)

<div class="content-ad"></div>

AppDelegate.swift 파일에 함수를 만들어 봅시다.

```js
import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    //우리 채널 이름이 업데이트됐어요
    let appIconChannel = FlutterMethodChannel(
      name: "app.com.get.change.icon", binaryMessenger: controller.binaryMessenger)

    appIconChannel.setMethodCallHandler({
      [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
      if call.method == "changeIcon" {
        // 변경을 수행하는 함수
       self?.changeAppIcon(call: call, result: result)
      } else {
       result(-1)
        return
      }
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func changeAppIcon(call: FlutterMethodCall, result: FlutterResult) {
    // 10.3 이상에서만 작동
    if #available(iOS 10.3, *) {
      guard UIApplication.shared.supportsAlternateIcons else {
        result(false)
        return
      }
      // 전달된 이름 복원
      guard let args = call.arguments as? [String : Any] else {return}
      let arguments: String = args["targetIcon"] as! String

      var iconName: String?

      // 현재 아이콘의 이름 확인
      if let currentIconName = UIApplication.shared.alternateIconName {
        iconName = currentIconName
      } else {
        iconName = "Normal"
      }
      // 두 번 변경하지 않도록하는 조건 설정
      if iconName == arguments {
        result(false)
        return
      }
      // 새 아이콘 적용
      UIApplication.shared.setAlternateIconName(arguments)
      result(true)

    } else {
      result(false)
    }
  }

  private func getIcon(call: FlutterMethodCall, result: FlutterResult) {
    result(UIApplication.shared.alternateIconName)
  }
}
```

작동 방식을 확인해 봅시다. 앱 아이콘을 "Default"로 변경해 보겠습니다:

<img src="/assets/img/2024-06-23-DynamicchangeAppIconFlutter_5.png" />

<div class="content-ad"></div>

![이미지](https://miro.medium.com/v2/resize:fit:1400/1*siJRg9-s1ba9LwJfuvvscQ.gif)

여기에서 소스 코드를 찾을 수 있습니다.

이 글이 도움이 되었기를 바랍니다. 읽어 주셔서 감사합니다!
