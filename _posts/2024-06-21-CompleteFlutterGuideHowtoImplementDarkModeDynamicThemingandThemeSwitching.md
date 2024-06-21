---
title: "완벽한 Flutter 가이드 다크 모드, 동적 테마 및 테마 전환 구현하는 방법"
description: ""
coverImage: "/assets/img/2024-06-21-CompleteFlutterGuideHowtoImplementDarkModeDynamicThemingandThemeSwitching_0.png"
date: 2024-06-21 20:35
ogImage: 
  url: /assets/img/2024-06-21-CompleteFlutterGuideHowtoImplementDarkModeDynamicThemingandThemeSwitching_0.png
tag: Tech
originalTitle: "Complete Flutter Guide: How to Implement Dark Mode, Dynamic Theming and Theme Switching"
link: "https://medium.com/@amazing_gs/complete-flutter-guide-how-to-implement-dark-mode-dynamic-theming-and-theme-switching-ddabaef48d5a"
---


# 소개

요즘 플러터 개발을 공부하고 있어요. 테마 전환은 사용자 경험을 향상시키는 중요한 방법이자, 플러터 학습에서 무시할 수 없는 주제입니다. 이 글에서는 플러터에서 테마 전환을 구현하는 방법을 자세히 설명하겠습니다.

# 주요 내용

이 글은 주로 다음 주제를 다룹니다:

<div class="content-ad"></div>

- 왜 앱이 테마 전환을 지원해야 하는지
- 플러터에서 테마를 설정하는 방법
- 플러터에서 주간 및 야간 모드 전환하는 방법
- 플러터에서 동적으로 색상 테마를 변경하는 방법
- Provider를 사용하여 동적 테마 전환 구현하는 방법

# 왜 앱이 테마 전환을 지원해야 하는지

- 사용자 경험 향상: 각 사용자는 각각의 미적 취향을 가지고 있습니다. 테마 전환이 더 많은 사용자의 시각적 취향을 충족시킬 수 있습니다.
- 맞춤화된 경험: 테마 전환은 앱의 맞춤 특성을 나타내고 사용자가 테마를 사용자 정의하여 경험을 개인화할 수 있게 합니다.
- 접근성 지원: 고대비 테마로 전환하는 것은 시각 장애가 있는 사용자들에게 접근성을 향상시킬 수 있습니다.

# 플러터에서 테마를 설정하는 방법

<div class="content-ad"></div>

플러터에서 테마를 설정하는 것은 매우 간단합니다. 단순히 테마 매개변수를 구성하면 됩니다. 테마를 설정하지 않아도 기본 테마를 사용할 수 있어요. 예를 들면:

![image](/assets/img/2024-06-21-CompleteFlutterGuideHowtoImplementDarkModeDynamicThemingandThemeSwitching_0.png)

다크 모드를 사용하고 싶다면, darkTheme: ThemeData.dark()를 추가하세요.

```dart
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("AppBar"),
        ),
        body: const Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
```

<div class="content-ad"></div>

앱은 시스템 설정에 따라 자동으로 테마 모드를 변경합니다. 테마 모드를 수동으로 지정하려면 코드에서 themeMode: ThemeMode.light로 설정할 수 있습니다. 이렇게 하면 앱의 테마 모드가 라이트 모드로 강제 지정됩니다.

# Material 3 설정 방법

Material 3를 설정하는 것은 더 간단합니다. useMaterial3: true를 지정하기만 하면 됩니다.

```js
class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true,),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("AppBar"),
        ),
        body: const Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
``` 

<div class="content-ad"></div>

Material 3은 애플리케이션의 전체 색상 테마를 단일 시드 색상에서 설정할 수 있습니다. 테마 생성자에서 colorSchemeSeed 매개변수를 설정하여 Flutter가이 항목에서 앱의 각 위젯에 대한 조화로운 색상 테마를 생성합니다.
예를 들어, 아래 색상 테마는 colorSchemeSeed를 사용하여 생성됩니다: const Color.fromARGB(86, 80, 14, 171)

```dart
class MainApp extends StatelessWidget {
  const MainApp({Key key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color.fromRGBO(86, 80, 14, 171),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: const Color.fromRGBO(86, 80, 14, 171),
      ),
      themeMode: ThemeMode.dark,
      home: const HomePage(),
    );
  }
}
```

![image1](/assets/img/2024-06-21-CompleteFlutterGuideHowtoImplementDarkModeDynamicThemingandThemeSwitching_1.png)

![image2](/assets/img/2024-06-21-CompleteFlutterGuideHowtoImplementDarkModeDynamicThemingandThemeSwitching_2.png)

<div class="content-ad"></div>

# 플러터에서 주간 모드와 야간 모드 전환하는 방법

어플리케이션에서 주간 모드와 야간 모드는 앱의 디스플레이 스타일을 의미합니다. 주간 모드는 일반적으로 밝은 색상과 높은 대비를 사용하며, 야간 모드는 어두운 배경과 낮은 대비를 사용합니다.

주간 모드는 밝은 환경에서 앱을 사용할 때 주로 사용됩니다. 밝은 색상과 높은 대비가 사용자가 콘텐츠를 더 쉽게 볼 수 있도록 도와줍니다. 야간 모드는 어두운 환경에서 앱을 사용할 때 주로 사용됩니다. 어두운 배경과 낮은 대비는 시력 피로를 줄일 수 있습니다.

![이미지](https://miro.medium.com/v2/resize:fit:844/1*2zyd9D-e4c6Z35u_2xPpeg.gif)

<div class="content-ad"></div>

플러터에서는 낮과 밤 모드 사이를 동적으로 전환하는 것이 매우 간단합니다. 테마 모드를 저장할 중간 변수를 추가하기만 하면 됩니다.

모드 전환을 구현하는 단계는 다음과 같습니다:

- 낮과 밤을 위한 두 가지 테마 세트를 정의합니다.
- 현재 테마 모드를 저장할 ThemeMode 변수를 추가합니다.
- 이 변수를 light/dark로 설정하여 테마 모드를 전환합니다.
- 전환 후 인터페이스가 새로운 테마를 적용하기 위해 자동으로 다시 빌드됩니다.

구체적인 코드는 다음과 같습니다:

<div class="content-ad"></div>

```dart
class _MainAppState extends State<MainApp> {
  ThemeMode themeMode = ThemeMode.system;
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      theme: ThemeData(
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      themeMode: themeMode,  // MaterialApp이 테마 모드 변수를 읽어서 테마를 전환합니다.
      home: Scaffold(
        appBar: AppBar(
          title: const Text("AppBar"),
        ),
        body: Column(
          children: [
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        themeMode = ThemeMode.light;
                      });
                    },
                    child: const Text("라이트")),
                TextButton(
                    onPressed: () {
                      setState(() {
                        themeMode = ThemeMode.dark;
                      });
                    },
                    child: const Text("다크")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

이 코드는 라이트 테마와 다크 테마를 갖춘 간단한 Flutter 앱을 정의합니다. 먼저 ThemeMode 변수 themeMode를 정의하고 ThemeMode.system으로 초기화합니다. 이는 앱이 일반적으로 안드로이드에서 라이트 테마, iOS에서 다크 테마를 사용하는 시스템의 기본 테마를 사용함을 의미합니다.

다음으로, 라이트 테마와 다크 테마가 정의됩니다. 라이트 테마는 ThemeData 클래스를 사용합니다. useMaterial3 속성은 새로운 Material 3 디자인 언어를 사용하기 위해 true로 설정됩니다. colorSchemeSeed 속성은 해당 테마의 기본 색상으로 사용될 특정 색상으로 설정됩니다.

다크 테마는 비슷한 방식으로 정의되지만 brightness 속성이 Brightness.dark로 설정됩니다.


<div class="content-ad"></div>

마지막으로, MaterialApp 위젯이 앱을 생성하는 데 사용됩니다. theme 속성은 밝은 테마로 설정되고, themeMode 속성은 themeMode 변수로 설정됩니다. 이것은 앱이 밝은 테마로 시작하지만 사용자가 해당 버튼을 탭하여 테마를 어둡게 변경할 수 있음을 의미합니다.

Scaffold 위젯은 앱의 기본 레이아웃을 만드는 데 사용됩니다. appBar 속성은 앱 바를 만들고, backgroundColor은 현재 테마의 기본 컨테이너 색상으로 설정됩니다. body 속성은 이 경우 간단한 목록과 두 개의 버튼으로 구성된 앱의 주요 콘텐츠를 만드는 데 사용됩니다.

두 버튼은 테마를 변경하는 데 사용됩니다. 사용자가 "light" 버튼을 탭하면 themeMode 변수가 ThemeMode.light로 설정되어 앱이 밝은 테마로 변경됩니다. 사용자가 "dark" 버튼을 탭하면 themeMode이 ThemeMode.dark로 설정되어 어두운 테마로 변경됩니다.

# 플러터에서 동적으로 색상 테마 변경하는 방법

<div class="content-ad"></div>

# 색 테마 설정하는 방법

플러터 앱의 색 테마를 구성하는 두 가지 방법이 있습니다:

- 토큰을 사용하여 테마 색상 설정
- 사용자 정의 색 구성표를 사용

# 테마 색상 설정을 위한 토큰 사용

<div class="content-ad"></div>

플러터의 머티리얼 디자인에서 "토큰"은 디자인 시스템과 관련된 개념으로, 특히 구글의 "Material You" 시스템에서 중요한 역할을 합니다. 이 시스템에서 토큰은 앱의 모양과 느낌을 정의하는 데 사용되는 매개변수 집합입니다. 이는 색상, 글꼴, 모양 및 기타 요소를 포함하여 앱에서 일관된 시각적 경험을 만들어내는 데 사용됩니다.

토큰은 특정 시각적 스타일을 나타내는 변수 또는 식별자로 생각할 수 있는 추상적인 개념입니다. 예를 들어, 색상 토큰은 테마의 주요 색상을 나타낼 수 있고, 글꼴 토큰은 앱에서 사용하는 헤드라인 글꼴을 나타낼 수 있습니다. 이를 통해 앱의 시각적 스타일이 머티리얼 디자인 요구 사항을 준수하고, 여러 페이지와 구성 요소 간에 일관된 스타일이 유지되도록 도와줍니다.

플러터에서는 ThemeData를 사용하여 이러한 토큰을 설정할 수 있습니다. 예를 들어, ThemeData의 primaryColor 및 accentColor 속성을 사용하여 앱의 주요 색상 및 강조 색상을 설정할 수 있습니다. 마찬가지로, textTheme을 사용하여 앱 전체에 걸쳐 글꼴 스타일을 설정할 수 있습니다.

머티리얼 3의 경우, 전체 앱에서 재사용할 수 있는 색상 토큰을 설정하는 아래 접근 방식을 사용할 수 있습니다.

<div class="content-ad"></div>

```dart
ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color.fromRGBO(86, 80, 14, 171),
      )
```

# 사용자 정의 색 구성표 사용하기

Flutter에서 Material 스타일 색 구성표를 사용자 정의하는 방법은 다음과 같습니다:

- colors.dart 파일을 생성하고 내부에 색 변수를 정의합니다. 예시:

<div class="content-ad"></div>

```dart
import 'package:flutter/material.dart';
const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF96416A),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFFFD8E6),
  onPrimaryContainer: Color(0xFF3D0024),
  secondary: Color(0xFF735761),
  ...
);
const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFFFB0D0),
  onPrimary: Color(0xFF5C113B),
  primaryContainer: Color(0xFF792952),
  onPrimaryContainer: Color(0xFFFFD8E6),
  secondary: Color(0xFFE1BDCA),
  onSecondary: Color(0xFF412A33),
  ...
);
```

- 이러한 사용자 정의 색상을 테마에서 참조하십시오:

```dart
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
// 이 위젯은 애플리케이션의 루트입니다.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: const Home(),
    );
  }
}
```

- 테마를 적용하려는 페이지에 colors.dart를 가져와서 Theme.of(context)를 통해 테마 설정 구성 스타일을 가져옵니다:

<div class="content-ad"></div>

```dart
최종 defaultColorScheme = Theme.of(context).colorScheme;
appBar: AppBar(
        title: const Text("AppBar"),
        backgroundColor: defaultColorScheme.primaryContainer,
      ),
```

4, 여러 테마를 만들 수도 있습니다. 테마를 전환할 때 다른 ThemeData 객체를 전달하세요:

```dart
MaterialApp(
  theme: lightTheme, 
  darkTheme: darkTheme,
)
```

5 테마에서 글꼴, 모양, 그림자 등을 포함한 다른 스타일을 사용자 정의할 수 있습니다.

<div class="content-ad"></div>

이렇게 하면 Material 소스 코드에 깊이 파지 않고 색상과 시각적 효과를 자유롭게 결합하여 사용자 정의된 브랜드 전용 테마를 구현할 수 있어요.

![Image](https://miro.medium.com/v2/resize:fit:1400/1*ekAvAGKVuYuCQb0WEbnxlA.gif)

# 테마 색상을 동적으로 변경하는 방법

![Image](https://miro.medium.com/v2/resize:fit:800/1*JQFs1GLX1gGM8T3roPhRmQ.gif)

<div class="content-ad"></div>

앱에서 테마 색상을 동적으로 전환할 수 있는 다양한 방법이 있습니다. 오늘은 주로 권장되는 방법인 Provider를 사용하는 방법을 소개하겠습니다.

Provider를 사용하면 테마의 중앙 상태 관리가 가능해져 테마를 동적으로 변경할 수 있습니다.

- 상태 관리를 담당하는 ThemeProvider 클래스를 만듭니다.
- 루트 페이지에 ThemeProvider를 설정합니다.
- 페이지에서 Consumer를 통해 인스턴스를 얻습니다.
- 테마 구성을 수정하기 위해 set 메서드를 호출합니다.
- 테마 변경이 인터페이스 업데이트를 트리거합니다.

# 1. 테마 프로바이더 생성

<div class="content-ad"></div>

우선 ThemeProvider 클래스를 만들어서 테마 상태를 저장합니다:

```js
// theme_provider.dart
import 'package:flutter/material.dart';
import 'color_schemes.g.dart';

class ThemeProvider with ChangeNotifier {
  late ThemeMode _themeMode = ThemeMode.system;
  late ColorScheme _darkScheme = darkColorScheme;
  late ColorScheme _lightScheme = lightColorScheme;

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode value) {
    _themeMode = value;
    notifyListeners();
  }

  ColorScheme get darkScheme => _darkScheme;

  void setDarkScheme(ColorScheme value) {
    _darkScheme = value;
    notifyListeners();
  }

  ColorScheme get lightScheme => _lightScheme;

  void setLightScheme(ColorScheme value) {
    _lightScheme = value;
    notifyListeners();
  }
}
```

이 코드는 앱의 밝은 테마와 어두운 테마를 동적으로 수정할 수 있는 ThemeProvider를 구현합니다.

# 2. ThemeProvider 제공

<div class="content-ad"></div>

루트 페이지에 다음 ThemeProvider를 제공하십시오:

```js
Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child:
            Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
          return MaterialApp(
            theme: ThemeData(
                useMaterial3: true, colorScheme: themeProvider.lightScheme),
            darkTheme: ThemeData(
                useMaterial3: true, colorScheme: themeProvider.darkScheme),
            themeMode: themeProvider.themeMode,
            home: const HomePage(),
          );
        }));
  }
```

이 구현 방식은 다음 이점을 가지고 있습니다:

- MaterialApp에서 ThemeProvider의 인스턴스를 Consumer를 통해 얻습니다.
- LightTheme 및 DarkTheme의 색상 체계는 ThemeProvider의 lightScheme 및 darkScheme를 직접 참조합니다.
- 테마 모드(themeMode)도 ThemeProvider의 themeMode 상태를 직접 참조합니다.
- ThemeProvider의 상태가 변경되면 notifyListeners를 통해 동적으로 재구성하기 위해 Consumer를 트리거하여 테마를 전환합니다.
- 홈 페이지나 다른 페이지에서는 context를 통해 ThemeProvider 인스턴스를 가져와서 테마 모드와 테마 색상을 변경하기 위해 setter 메서드를 호출할 수 있습니다.
- Provider를 사용하여 테마 데이터와 상태를 추출함으로써 UI 레이어에서 간단하게 재사용하여 느슨하게 결합된 동적 테마 전환을 달성합니다.
- ThemeProvider는 테마 상태 관리를 담당하며, UI 레이어는 디스플레이를 담당합니다. 책임의 분리는 디자인 원칙을 따릅니다.

<div class="content-ad"></div>

# 3. 테마 공급자 가져오기

필요한 페이지에서 공급자 인스턴스를 가져옵니다:

```js
final themeProvider = Provider.of<ThemeProvider>(context);
```

# 4. 테마 변경

<div class="content-ad"></div>

테마 색상을 변경하려면 setLightScheme 및 setDarkScheme를 호출하세요:

```js
themeProvider.setLightScheme(lightColorScheme); 
themeProvider.setDarkScheme(darkColorScheme);
```

이를 통해 공급자를 통해 서로 다른 페이지 간에 테마 구성을 공유하고 수정할 수 있습니다. 공급자를 사용하여 테마를 관리하면 중복 코드가 없어지며 반응형 테마 구성이 가능해집니다. Flutter에서 동적 테마를 구현하는 유연하고 간결한 방법입니다.

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0
  provider: ^6.0.5
```

<div class="content-ad"></div>

# 요약

플러터는 강력한 테마 사용자 정의 기능을 제공하여 테마 시스템을 통해 다양한 방식으로 테마를 자유롭게 전환하여 앱 경험과 접근성을 향상시킬 수 있습니다. 플러터의 테마 기구를 숙달하는 것은 고품질 앱을 개발하는 중요한 부분입니다.

위 내용은 플러터에서 테마 전환을 구현하는 전반적인 소개를 제공합니다. 다른 질문이 있으면 토론을 위해 언제든 댓글을 남겨주세요.

예를 들어, 테마 전환 버튼은 ThemeProvider의 세터를 호출하여 테마 모드를 전환할 수 있습니다. 다른 구성 요소는 스타일을 수정하기 위해 Provider를 통해 ThemeProvider 인스턴스를 얻을 수 있습니다.

<div class="content-ad"></div>

Provider가 테마 상태를 반응적으로 관리하면, 테마가 변경될 때 위젯들이 자동으로 다시 빌드됩니다. 이는 앱 전체 테마 업데이트를 수동으로 처리할 필요 없이 동적 런타임 테마 적용을 가능케 합니다. 전반적으로, Flutter는 사용자 경험을 즐겁게 만들기 위해 테마를 사용자 정의하고 동적으로 전환하기 쉽습니다.

# 참고 링크들

- [Material Theming Builder](https://m3.material.io/theme-builder#/custom)
- [Flutter Theming](https://juejin.cn/post/7078583859536723975)
- [Official Flutter documentation on theming](https://flutter.dev/docs/cookbook/design/themes)
- [Provider를 이용한 동적 테마 적용 튜토리얼](https://flutter.dev/docs/cookbook/design/themes/dynamic)
- [간단한 앱 예제를 이용한 동적 테마 비디오 튜토리얼](https://www.youtube.com/watch?v=-G75u5uoFFE)
- [Provider 상태 관리 패키지 Pub 페이지](https://pub.dev/packages/provider)
- [Flutter에서 테마 사용 가이드](https://flutter.dev/docs/cookbook/design/themes)
- [공식 Material Design 시스템 테마 자료](https://material.io/design/material-theming)
- [Flutter 웹에서 테마 전환하기](https://webmasters.googleblog.com/2021/07/theme-switching-in-flutter-web.html)
- [Flutter 테마 전환 가이드](https://gusibi-blog.vercel.app/article/flutter-theme-switching-guide)