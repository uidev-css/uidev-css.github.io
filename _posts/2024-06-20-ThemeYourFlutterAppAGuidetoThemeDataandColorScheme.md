---
title: "Flutter 앱을 테마화해보세요 ThemeData와 ColorScheme에 대한 안내"
description: ""
coverImage: "/assets/img/2024-06-20-ThemeYourFlutterAppAGuidetoThemeDataandColorScheme_0.png"
date: 2024-06-20 13:49
ogImage: 
  url: /assets/img/2024-06-20-ThemeYourFlutterAppAGuidetoThemeDataandColorScheme_0.png
tag: Tech
originalTitle: "Theme Your Flutter App: A Guide to ThemeData and ColorScheme"
link: "https://medium.com/@nikhithsunil/theme-your-flutter-app-a-guide-to-themedata-and-colorscheme-d8bca920a6b5"
---


다음을 먼저 말씀드리기 전에 알아두어야 할 점이 있어요. 많은 기사들이 이 주제에 대해 매체와 다른 소스에서 제공되고 있기 때문에, 이 기사의 필요성이 무엇인지 궁금해졌죠?

이 기사에서는 ThemeData 위젯의 주요 포인트와 저의 개발 경험 중 가장 많이 사용하는 매개변수에 초점을 맞추어, 각 매개변수가 어떻게 애플리케이션에 영향을 미치는지에 대해 간단한 설명을 제공할 예정이에요.

궁금하신가요? 계속 읽어보세요 🤗.

## ThemeData 사용의 주요 이점

<div class="content-ad"></div>

- 일관된 외관 유지: 앱의 색상 팔레트, 글꼴, 모양 및 기타 시각 요소를 캡슐화하는 단일 ThemeData 객체를 정의하세요. 이 테마를 모든 화면에 일관되게 적용하여 통일된 및 인식할 수 있는 브랜드 아이덴티티를 유지하세요.
- 다양한 테마를 생성하세요: 밝은 모드, 어플리케이션 섹션 또는 사용자 환경에 따라 여러 ThemeData 객체를 정의하세요.
- 한 번 테마를 정의하고 모든 곳에서 사용하세요: 개별 위젯에 시각적 스타일을 수동으로 설정하는 대신 앱에서 적절한 ThemeData를 적용하세요. 이렇게 하면 코드 중복이 줄어들고 유지 관리가 간단해집니다.
- 중앙 통제 및 업데이트: ThemeData 객체를 변경하면 해당 변경 사항이 자동으로 앱 전체에 퍼지므로 일관성이 유지되고 반복적인 편집이 줄어듭니다.
- 접근성 있는 변형 만들기: 시각 장애가 있는 사용자를 위한 고대비 테마와 같은 특정 접근성 요구를 가진 사용자를 위한 별도의 ThemeData 객체를 구축하세요.

그래서, ThemeData가 어떻게 도움이 되는지 알게 되었으니, 이것을 어떻게 앱에 구현하는지 알아볼까요? 저랑 함께 하세요 😊.

다크 모드 및 라이트 모드를 위한 기본 테마를 구현하는 간단한 가이드가 여기 있습니다.

## 전역 클래스 생성

<div class="content-ad"></div>

먼저 애플리케이션 내에서 ThemeData를 관리하는 전역 클래스를 만드는 것이 첫 번째 단계입니다. 이 클래스에는 ColorSheme를 사용하여 다른 ThemeData 인스턴스를 만드는 메서드가 포함되어 있습니다.

```dart
class GlobalThemData {
  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(colorScheme: colorScheme, focusColor: focusColor);
  }
}
```

focusColor : 이 색상은 TextFields 및 TextFormField와 같은 위젯에 사용되며 위젯이 기본 포커스를 갖고 있음을 나타냅니다.

나중에 이 기사에서 ColorSheme에 대해 자세히 논의할 수 있습니다.

<div class="content-ad"></div>

이제 GlobalThemeData 클래스에서 직접 액세스할 수 있는 추가적인 공용 변수를 만들 수 있습니다.

- lightColorScheme: 라이트 테마용 ColorScheme을 보유합니다.
- darkColorScheme: 다크 테마용 ColorScheme을 보유합니다.
- lightThemeData: 라이트 테마용 ThemeData을 보유합니다.

<div class="content-ad"></div>

`darkThemeData`: 다크 테마를 위한 ThemeData를 보유합니다.

```js
class GlobalThemData {
  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);
```

```js
  static ThemeData lightThemeData = themeData(lightColorScheme, _lightFocusColor);
     
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);
  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(colorScheme: colorScheme, focusColor: focusColor);
  }
  static const ColorScheme lightColorScheme = ColorScheme();
  static const ColorScheme darkColorScheme = ColorScheme();
}
```

제 코드를 함께 작성 중이라면 ColorSheme()에서 필수 매개변수 오류 경고를 받을 수 있습니다.

<div class="content-ad"></div>

다음 단계에서 이를 고칠 수 있어요.

## ColorSheme

ColorSheme의 색상은 쌍으로 구성되어 있어요. 첫 번째는 색상 자체이고, 두 번째는 해당 색상에 사용할 수 있는 색상으로, 텍스트 및 다른 요소 등이 있어요.

![ColorSheme](/assets/img/2024-06-20-ThemeYourFlutterAppAGuidetoThemeDataandColorScheme_0.png)

<div class="content-ad"></div>

플러터 ThemData에 컬러 테마를 만들 때 필수 컬러 10가지입니다. 각 컬러의 값은 선택사항입니다.

- primary: 애플리케이션에서 가장 많이 사용되는 색상입니다.

- onPrimary: 텍스트, 아이콘 등 프라이머리 컬러 위에 색상이 적용되는 요소에 사용됩니다.

- secondary: 프라이머리 컬러보다 눈에 띄지 않지만 필요한 요소(필터 칩, 토글 버튼, 배경 요소 등)에 대한 보조 색상을 정의합니다.

<div class="content-ad"></div>

onSecondary: 이 색은 보조 색 위에 적용되는 요소의 색상을 지정하는 데 사용됩니다.

error: 이 색은 오류 메시지나 경고와 같이 문제를 나타내는 데 사용됩니다. 마치 문제를 나타내기 위해 깜박이는 빨간 불빛인 것처럼요.

onError: 이 색상은 에러 색상 위에 잘 어울리는 텍스트 색으로, 쉽게 읽을 수 있도록 하기 위해 빨간 표지판에 표시되는 흰색 텍스트와 같은 색상이에요.

background: 전체 애플리케이션의 주요 배경색입니다. 이는 모든 다른 UI 요소가 배치되는 캔버스로 생각할 수 있습니다.

<div class="content-ad"></div>

배경색 위에 있는 요소를 색칠하는 데 사용되는 색입니다.

 표면 : 카드, 시트, 대화 상자 등과 같은 UI 요소의 기본 색상으로 사용됩니다.

 표면 위에 있는 요소에 색칠하는 데 사용됩니다.

그래서 우리는 lightColorScheme 및 darkColorScheme 변수를 다음과 같이 설정할 수 있습니다.

<div class="content-ad"></div>

```dart
static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFFB93C5D),
    onPrimary: Colors.black,
    secondary: Color(0xFFEFF3F3),
    onSecondary: Color(0xFF322942),
    error: Colors.redAccent,
    onError: Colors.white,
    background: Color(0xFFE6EBEB),
    onBackground: Colors.white,
    surface: Color(0xFFFAFBFB),
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
  );
```

```dart
static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFFFF8383),
    secondary: Color(0xFF4D1F7C),
    background: Color(0xFF241E30),
    surface: Color(0xFF1F1929),
    onBackground: Color(0x0DFFFFFF),
    error: Colors.redAccent,
    onError: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    brightness: Brightness.dark,
  );
```

지금까지 우리는 밝은 테마(light)와 어두운 테마(dark)를 위한 ColorScheme을 설정했어요. 이제 이를 ThemeData에서 어떻게 사용하는지 알아볼게요.

## ThemeData 생성

<div class="content-ad"></div>

우리는 GlobalThemeData의 themeData 메서드를 수정하여 전달할 적절한 ColorScheme 값을 사용하여 ThemeData를 구성해야 합니다.

```js
static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
        colorScheme: colorScheme,
        canvasColor: colorScheme.background,
        scaffoldBackgroundColor: colorScheme.background,
        highlightColor: Colors.transparent,
        focusColor: focusColor
       );
  }
```

- canvasColor: 전체 화면이나 앱 창의 배경색상을 나타내는 속성입니다. 다른 모든 UI 요소를 배치하는 기본 색상을 정의합니다.
- scaffoldBackgroundColor: 이것은 특히 scaffold 자체의 배경색상을 정의합니다. 앱 바, 본문 콘텐츠 영역 및 하단 내비게이션 바 (있는 경우)을 포함합니다.
- highlightColor: 이 속성은 사용자가 위젯을 누르고 누르고 있을 때 잠시 표시되는 색상을 정의합니다. 사용자에게 상호 작용이 등록되었음을 시각적으로 알려줍니다.
- focusColor: 이 속성은 현재 포커스를 받은 요소를 시각적으로 나타내는 데 사용되는 색상을 정의합니다. 이것은 현재 키보드 입력을 받을 요소를 강조하는데 유용할 수 있습니다.

이것들은 예시일 뿐이며, 살펴볼 다른 ThemeData 옵션이 더 많이 있습니다.

<div class="content-ad"></div>

그래서 최종 GlobalThemeData 클래스는 이렇게 보일 것입니다.

```js
class GlobalThemData {
  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);
  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      focusColor: focusColor
    );
  }
  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFFB93C5D),
    onPrimary: Colors.black,
    secondary: Color(0xFFEFF3F3),
    onSecondary: Color(0xFF322942),
    error: Colors.redAccent,
    onError: Colors.white,
    background: Color(0xFFE6EBEB),
    onBackground: Colors.white,
    surface: Color(0xFFFAFBFB),
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
  );
  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFFFF8383),
    secondary: Color(0xFF4D1F7C),
    background: Color(0xFF241E30),
    surface: Color(0xFF1F1929),
    onBackground: Color(0x0DFFFFFF),
    error: Colors.redAccent,
    onError: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    brightness: Brightness.dark,
  );
}
```

예! 우리는 어플리케이션을 위한 아름다운 테마를 만들었어요. 그 다음 단계는 무엇일까요?

<div class="content-ad"></div>

## ThemeData 설정

MaterialApp에서 원하는 테마를 설정합니다.

```dart
class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.light, // 또는 ThemeMode.dark
      theme: GlobalThemData.lightThemeData,
      darkTheme: GlobalThemData.darkThemeData,
      home: const ShowCaseHome(),
    );
  }
}
```

이렇게 하면 기본적인 라이트 테마가 앱에 적용됩니다. 다크 모드로 전환할 수도 있습니다. 동적으로 전환하기 위해 InheritedWidget 또는 Provider의 강력함을 탐험할 수 있습니다. 이 내용은 이 글의 범위를 벗어납니다. 필요하면 향후 글에서 자세히 논의할 수 있습니다.

<div class="content-ad"></div>

소중한 정보를 얻으셨길 바라요. 읽어 주셔서 감사합니다! 🤗