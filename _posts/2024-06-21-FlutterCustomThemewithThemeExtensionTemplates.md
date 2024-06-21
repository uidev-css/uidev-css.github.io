---
title: "ThemeExtension으로 Flutter 맞춤 테마 만들기  템플릿 제공"
description: ""
coverImage: "/assets/img/2024-06-21-FlutterCustomThemewithThemeExtensionTemplates_0.png"
date: 2024-06-21 20:46
ogImage: 
  url: /assets/img/2024-06-21-FlutterCustomThemewithThemeExtensionTemplates_0.png
tag: Tech
originalTitle: "Flutter Custom Theme with ThemeExtension + Templates"
link: "https://medium.com/@alexandersnotes/flutter-custom-theme-with-themeextension-792034106abc"
---


<img src="/assets/img/2024-06-21-FlutterCustomThemewithThemeExtensionTemplates_0.png" />

이 글에서는 ThemeExtensions를 사용하여 Flutter에서 사용자 정의 테마를 만드는 과정을 안내해 드리겠습니다. Color 및 TextStyle 확장을 위한 템플릿을 제공해 드릴 것이며, 내장 ColorScheme 및 TextTheme을 사용하지 않는 것을 권장하는 이유도 설명해 드리겠습니다(대부분의 경우 99%는 Material 사양을 따르지 않기 때문입니다).

빠른 이동:

- 문제점
- 사용자 정의 색상 추가 방법
- 밝은 모드와 어두운 모드 구현 방법
- 사용자 정의 텍스트 스타일 추가 방법
- Text 위젯에 대한 기본 TextStyle
- 마무리(추가 링크)

<div class="content-ad"></div>

## 문제

새로운 Flutter 프로젝트를 시작할 때마다 앱에 재사용 가능한 스타일을 정의해야 합니다. 보통, 디자인 시스템에 기반한 스타일을 정의하며, 그것은 대개(사실은 절대로) Material입니다. TextStyle 토큰들(headlineLarge, bodyMedium, ...)은 Material 명명 규칙을 따르지 않습니다; 디자인 항목들은 팔레트(빨간색, 회색, ...)에서 색상을 사용하고, 색상 체계(accent, primary, background, ...)에서는 사용하지 않습니다. 이 모든 것을 살펴보고 Flutter 앱에 어떻게 적용해야 할지 모를 때가 있습니다.

먼저, ThemeData를 확장하거나 고유한 사용자 정의 테마 클래스를 작성할 수 있다고 생각할 수 있지만, 그렇게 하지 마십시오. 이 기사에서 보여드리는 Flutter 앱에 자연스럽게 통합되는 훨씬 더 나은 방법이 있습니다(ThemeExtension). 하지만 먼저, 왜 내장된 Material ColorScheme 및 TextTheme에 디자인을 통합하기를 추천하지 않는지 살펴보겠습니다.

## ColorScheme 및 TextTheme가 디자인에 적합하지 않은 이유

<div class="content-ad"></div>

플러터는 전역 앱 테마를 설정하기 위해 ThemeData 클래스를 제공합니다. 이 클래스에는 여러 내장 위젯을 위한 많은 속성이 포함되어 있지만, 주요 속성은 ColorScheme과 TextTheme이라고 할 수 있어요. 이것들은 "괜찮은"데요, 하지만 여러분의 디자인이 머티리얼 사양을 따르는 경우에만 해당합니다. 그렇지 않으면 대부분의 경우, 디자인 시스템은 서로 다른 이름 및 색상 및 텍스트 스타일 토큰 수를 가지게 될 거에요.

어쩌면 일부 색상 및 텍스트 스타일 토큰이 일치할 수도 있지만, 나머지는 일치하지 않을 수 있어요. 일부 토큰을 매핑해 볼 수도 있겠죠 (디자인: h1 - 코드: headlineLarge), 그리고 다른 토큰을 별도의 위치에 넣어 볼 수도 있어요 (ThemeExtension 또는 다른 곳). 하지만 이것은 좋은 해결책이 될 수 없어요. 이것은 이해하기 어려운 토큰 이름 매핑과 유지 및 수정이 어려운 앱 테마의 분산 선언으로 이어질 거에요. 왜 굳이 사용자 지정 디자인 시스템을 머티리얼에 넣으려고 하나요?

그래서 나는 모든 사용자 지정 스타일을 완전히 제어할 수 있는 사용자 정의 ThemeExtension(s)에 넣으라고 권장해요. 혜택:

- 필요한 속성을 추가, 이름 변경, 삭제할 수 있어요.
- 머티리얼 사양이나 플러터 업데이트에 의존하지 않아요.
- 모든 관련된 스타일이 1곳에 모이며 ColorScheme과 ExtraColorScheme 사이로 흩어지지 않아요.

<div class="content-ad"></div>

게다가 GitHub Copilot 또는 제가 제공할 템플릿을 사용하면 매우 쉽게 작성할 수 있습니다.

내가 여전히 Theme과 ThemeData를 사용하고 직접 클래스를 만들지 말 것을 추천하는 이유는 Flutter가 이미 이러한 클래스를 사용하여 필요한 모든 것을 갖추고 있기 때문입니다. UI 부분을 위한 테마 재정의, 내장 위젯의 기본 스타일링, 기본 텍스트 스타일 설정, 라이트 및 다크 모드 전환 지원 등이 모두 포함되어 있습니다. 이미 존재하는 것(ThemeExtensions)을 확장하는 것이 더 쉬울 때에는 직접 클래스를 작성할 필요가 없습니다.

# Flutter에서 ThemeExtension을 사용하여 사용자 정의 색상 추가하는 방법

Flutter 앱에 사용자 정의 색상을 추가하려면 3단계만 거치면 됩니다:

<div class="content-ad"></div>

- 사용자 정의 색상 정의
- 색상을 위한 ThemeExtension 생성
- Light 및 Dark 모드를 위한 확장 기능 초기화

## 단계 1: AppPalette

AppPalette는 디자인 시스템에서 사용되는 색상 코드를 정의하는 클래스입니다. 복잡한 것은 아니며, 단순히 정적 속성을 가진 클래스일 뿐입니다:

```js
abstract class AppPalette {
  // 빨강
  static const red = Colors.red;
  static const imperialRed = Color(0xFFE54B4B);

  // 흰색
  static const seashell = Color(0xFFF7EBE8);

  // 회색
  static const grey = _GreyColors();
}

/// 팔레트에서 색상을 그룹화하는 대체 방법.
/// 
/// 단점은 이러한 값들이 상수가 아니기 때문에
/// 생성자 기본 값으로 사용할 수 없다는 것입니다.
///
/// 사용 예: `AppPalette.grey.grey50`.
class _GreyColors {
  const _GreyColors();

  final grey50 = const Color(0xFFFAFAFA);
  final grey100 = const Color(0xFFF5F5F5);
}
```

<div class="content-ad"></div>

노트:

- AppPalette는 추상입니다. 왜냐하면 우리는 이를 실체화할 필요가 없기 때문입니다.
- _GreyColors는 비공개입니다. 직접 액세스하는 것이 아니라 AppPalette를 통해서만 액세스를 허용합니다.

## 단계 2: AppColorsExtension + 템플릿

여기서는 테마 익스텐션을 정의하고 copyWith() 및 lerp() 메소드를 구현해야 합니다. 이 예제에서는 주요 및 배경 속성만 있는데도 간단한 작업에 대해 너무 많은 코드처럼 보일 수 있지만, 코드 생성 없이는 이를 해결할 방법이 없습니다. (링크는 엔딩 섹션에 있음).

<div class="content-ad"></div>

```dart
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  AppColorsExtension({
    required this.primary,
    required this.background,
  });

  final Color primary;
  final Color background;

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    Color? primary,
    Color? background,
  }) {
    return AppColorsExtension(
      primary: primary ?? this.primary,
      background: background ?? this.background,
    );
  }

  @override
  ThemeExtension<AppColorsExtension> lerp(
    covariant ThemeExtension<AppColorsExtension>? other,
    double t,
  ) {
    if (other is! AppColorsExtension) {
      return this;
    }

    return AppColorsExtension(
      primary: Color.lerp(primary, other.primary, t)!,
      background: Color.lerp(background, other.background, t)!,
    );
  }
}
```

참고:

- lerp()는 다른 ThemeExtension 개체와 선형 보간을 수행하고 테마를 변경할 때 애니메이션을 만듭니다.

전체 확장 템플릿 링크는 여기에 있습니다. 현재 내장 ColorScheme과 모든 속성이 동일하지만 필요에 맞게 추가, 이름 바꾸기 및 삭제할 수 있습니다.


<div class="content-ad"></div>

🔗 AppColorsExtension 템플릿

## 단계 3: 밝은 모드와 어두운 모드

이 단계는 다음 섹션에서 진행될 예정이에요 😅

참고로, Chopper 요청에 HTTP Authorization 헤더를 추가하고 401 Unauthorized 응답일 때 재시도하는 방법에 대한 제 다른 글도 확인해보시기를 추천해요.

<div class="content-ad"></div>

이제 다시 플러터 테마링으로 돌아왔어요! 🙂

# 플러터에서 라이트 모드와 다크 모드를 구현하는 방법

다시 한 번, 3가지 간단한 단계만 따르면 돼요:

- 라이트와 다크 테마 데이터를 정의하세요.
- MaterialApp에 그 데이터들을 전달하세요.
- MaterialApp에 올바른 ThemeMode를 전달하세요.

<div class="content-ad"></div>

## 단계 1: App 테마

이 클래스는 ThemeExtensions와 테마 모드를 프로그래밍적으로 전환할 수 있는 기능을 가진 라이트 및 다크 모드용 Flutter ThemeData 게터를 포함하고 있습니다. 우선 게터를 구현해봅시다.

```js
class AppTheme {
  //
  // 라이트 테마
  //

  static final light = ThemeData.light().copyWith(
    extensions: [
      _lightAppColors,
    ],
  );

  static final _lightAppColors = AppColorsExtension(
    primary: const Color(0xff6200ee),
    onPrimary: Colors.white,
    secondary: const Color(0xff03dac6),
    onSecondary: Colors.black,
    error: const Color(0xffb00020),
    onError: Colors.white,
    background: Colors.white,
    onBackground: Colors.black,
    surface: Colors.white,
    onSurface: Colors.black,
  );

  //
  // 다크 테마
  //

  static final dark = ThemeData.dark().copyWith(
    extensions: [
      _darkAppColors,
    ],
  );

  static final _darkAppColors = AppColorsExtension(
    primary: const Color(0xffbb86fc),
    onPrimary: Colors.black,
    secondary: const Color(0xff03dac6),
    onSecondary: Colors.black,
    error: const Color(0xffcf6679),
    onError: Colors.black,
    background: const Color(0xff121212),
    onBackground: Colors.white,
    surface: const Color(0xff121212),
    onSurface: Colors.white,
  );
}
```

참고:

<div class="content-ad"></div>

- 여기서는 템플릿에서 AppColorsExtension의 전체 버전을 사용했습니다.

❗중요. 공식 문서에서는 다음과 같이 확장을 액세스합니다: Theme.of(context).extension`MyColors`()! 하지만 이것은 너무 길고 사용하기 어려울 수 있습니다. Dart 확장 메서드의 강력함을 활용하는 좋은 솔루션이 없다는 것이 안타깝습니다.

```js
extension AppThemeExtension on ThemeData {
  /// 사용 예시: Theme.of(context).appColors;
  AppColorsExtension get appColors =>
      extension<AppColorsExtension>() ?? AppTheme._lightAppColors;
}
```

참고:

<div class="content-ad"></div>

- 만약 이 확장 기능이 AppTheme._lightAppColors에 액세스해야 한다면 AppTheme과 같은 파일에 작성되어야 합니다.

❗또 하나의 개선점입니다. 매번 Theme.of(context)를 작성하는 것이 너무 길 수 있으므로 BuildContext에 다른 확장 메소드를 추가하는 것을 선호합니다:

```js
extension ThemeGetter on BuildContext {
  // 사용 예: `context.theme`
  ThemeData get theme => Theme.of(this);
}
```

최종 사용 방법은 다음과 같습니다: context.theme.appColors. 멋지죠? ✨ 추가로 유용한 확장 기능은 'Flutter에서 누락된 확장 기능'에 대한 제 논문에서 찾아볼 수 있습니다:

<div class="content-ad"></div>

## 단계 2-3: 플러터에서 라이트 모드와 다크 모드 전환하는 방법

플러터에서 라이트 모드와 다크 모드를 전환하려면 MaterialApp에서 theme 및 darkTheme 속성을 지정해야 합니다. 또한 앱의 현재 테마 모드를 결정하는 themeMode 속성도 제공해야 합니다. ThemeMode은 3가지 옵션을 가지고 있는 enum입니다:

- ThemeMode.light
- ThemeMode.dark
- ThemeMode.system

상태 관리를 위해 저는 ChangeNotifier를 사용했습니다. 더 복잡한 것을 사용할 필요가 없어서입니다. 나중에 BuildContext 없이 ThemeMode를 변경해야 할 경우 get_it 또는 사용하는 다른 패키지에 이 클래스를 등록할 수도 있습니다.

<div class="content-ad"></div>

```js
class AppTheme with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }

  ...
}
```

이제 MaterialApp에 넣어 봅시다:

```js
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // 1. MaterialApp 위에 AppTheme를 제공하여
      // 모든 페이지에서 사용할 수 있습니다.
      create: (_) => AppTheme(),
      builder: (context, _) => MaterialApp(
        title: 'Flutter Demo',
        // 2. 라이트 테마를 제공합니다.
        theme: AppTheme.light,
        // 3. 다크 테마를 제공합니다.
        darkTheme: AppTheme.dark,
        // 4. AppTheme 변경 사항 (ThemeMode)을 감시합니다.
        themeMode: context.watch<AppTheme>().themeMode,
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
```

참고:


<div class="content-ad"></div>

- ChangeNotifierProvider은 provider 패키지에서 제공됩니다. 이미 알고 계실 거라 믿어요 😅

테마모드를 업데이트해보세요:

```js
void darkMode() {
  context.read<AppTheme>().themeMode = ThemeMode.dark;
}
```

축하합니다 🎉 ThemeExtension을 사용하여 사용자 정의 앱 테마를 만드셨군요. 이제는 커스텀 텍스트 스타일도 추가해볼까요?

<div class="content-ad"></div>

# 플러터에서 ThemeExtension을 사용하여 사용자 지정 텍스트 스타일 추가하는 방법

텍스트 스타일은 라이트 모드와 다크 모드 사이에 변경되지 않기 때문에 대부분의 경우, 테마 확장을 생성할 필요가 없고 간단한 const TextStyle 선언이 충분합니다. 그러나 두 가지 방법을 모두 보여드리겠습니다. 두 단계만으로 완성됩니다.

## 단계 1: AppTypography

이 클래스는 AppPalette와 동일한 용도로 사용되며 코드에서 디자인의 스타일을 정의합니다.

<div class="content-ad"></div>


추상 클래스 AppTypography {
  고정된 body1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  고정된 h1 = TextStyle(
    fontSize: 96,
    fontWeight: FontWeight.w300,
  );
}


참고:

- 만일 색상을 추가 클래스와 함께 그룹화하는 두 번째 방법이 마음에 들었다면, 이곳에서도 사용할 수 있습니다.

이제 이러한 스타일을 다음과 같이 사용할 수 있습니다:


<div class="content-ad"></div>

```dart
style: AppTypography.h1.copyWith(color: context.theme.appColors.error)
```

## 플러터에서 Text 위젯을 위한 기본 TextStyle

Text 위젯을 위한 기본 TextStyle을 설정하려면 TextTheme에서 bodyMedium을 설정해야 합니다. 다음은 예제입니다:

```dart
static final light = () {
    final defaultTheme = ThemeData.light();

    return defaultTheme.copyWith(
      textTheme: defaultTheme.textTheme.copyWith(
        // 참고: Text 위젯을 위한 기본 텍스트 스타일
        bodyMedium: AppTypography.body1.copyWith(color: Colors.black),
      ),
      extensions: [
        _lightAppColors,
      ],
    );
  }();
```

<div class="content-ad"></div>

## 단계 2: AppTextThemeExtension + 템플릿

텍스트 스타일을 위한 ThemeExtension을 생성하려면 색상과 같은 방법을 따라야합니다.

```js
class AppTextTheme extends ThemeExtension<AppTextTheme> {
  const AppTextTheme({
    required this.body1,
    required this.h1,
  });

  final TextStyle body1;
  final TextStyle h1;

  @override
    ThemeExtension<AppTextTheme> copyWith({
    TextStyle? body1,
    TextStyle? h1,
  }) {
    return AppTextTheme(
      body1: body1 ?? this.body1,
      h1: h1 ?? this.h1,
    );
  }

  @override
  ThemeExtension<AppTextTheme> lerp(
    covariant ThemeExtension<AppTextTheme>? other,
    double t,
  ) {
    if (other is! AppTextTheme) {
      return this;
    }

    return AppTextTheme(
      body1: TextStyle.lerp(body1, other.body1, t)!,
      h1: TextStyle.lerp(h1, other.h1, t)!,
    );
  }
}
```

위는 간단한 예제이지만, 여기에서는 내장된 TextTheme과 동일한 모든 (사용되지 않는) 속성을 갖춘 전체 템플릿을 제공합니다. 필요한 대로 추가, 이름 변경, 삭제할 수 있습니다.

<div class="content-ad"></div>

🔗 AppTextThemeExtension 템플릿

친구야! Light와 Dark ThemeData에 이 확장 프로그램을 추가하지 않도록 잊지 마세요:

```js
class AppTheme with ChangeNotifier {

  ...

  static final light = () {
    final defaultTheme = ThemeData.light();

    return defaultTheme.copyWith(
      textTheme: defaultTheme.textTheme.copyWith(
        // 참고: Text 위젯에 대한 기본 텍스트 스타일입니다.
        bodyMedium: AppTypography.body1.copyWith(color: Colors.black),
      ),
      extensions: [
        _lightAppColors,
        // 1. 여기
        _lightTextTheme,
      ],
    );
  }();

  static final _lightAppColors = ...;

  // 2. 여기
  static final _lightTextTheme = AppTextThemeExtension(
    body1: AppTypography.body1.copyWith(color: _lightAppColors.onBackground),
    h1: AppTypography.h1.copyWith(color: Colors.black),
  );

  ...

}

extension AppThemeExtension on ThemeData {
  AppColorsExtension get appColors =>
      extension<AppColorsExtension>() ?? AppTheme._lightAppColors;

  // 3. 그리고 여기
  AppTextThemeExtension get appTextTheme =>
      extension<AppTextThemeExtension>() ?? AppTheme._lightTextTheme;
}
```

🎉 다시 한 번 축하드려요! 이제는 TextStyles에 대한 ThemeExtension이 생겼어요. 아래 전체 소스 코드를 확인해보세요.

<div class="content-ad"></div>

# 마무리

## 소스 코드

템플릿:

- 🔗 AppColorsExtension
- 🔗 AppTextThemeExtension

<div class="content-ad"></div>

풀 앱 예시:

## 확장 가능한 부분

- get_it이나 다른 패키지에 AppTheme을 등록하여 BuildContext 없이 액세스할 수 있습니다.
- 선택한 ThemeMode를 shared_preferences에 저장합니다.

## Flutter ThemeExtension 생성기

<div class="content-ad"></div>

그 패키지는 ThemeExtension을 생성하는 것을 볼 수 있었지만, 나는 항상 최소한의 생성이 좋다고 생각해서 사용해보지는 않았어. 게다가, GitHub Copilot을 사용하면 필요한 보일러플레이트 코드를 쉽게 작성할 수 있어.

## 더 많은 자료

- 테마 문서.
- ThemeExtension 문서.
- DefaultTextStyle.merge() — 사용자 정의 위젯에서 기본 TextStyle을 처리하는 데 도움이 됨.

읽어주셔서 감사합니다. 안녕 👋