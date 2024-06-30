---
title: "Flutter 앱 테마 커스터마이즈 라이트와 다크 모드 전환 및 익스텐션 사용 방법"
description: ""
coverImage: "/assets/img/2024-06-23-CustomizeFlutterAppThemesSwappingBetweenLightDarkModesandUsingExtensions_0.png"
date: 2024-06-23 14:53
ogImage:
  url: /assets/img/2024-06-23-CustomizeFlutterAppThemesSwappingBetweenLightDarkModesandUsingExtensions_0.png
tag: Tech
originalTitle: "Customize Flutter App Themes: Swapping Between Light Dark Modes and Using Extensions"
link: "https://medium.com/@9dan_/customize-flutter-app-themes-swapping-between-light-dark-modes-and-using-extensions-66b1586aae1b"
---

플러터는 테마 지원을 통해 개발자들이 다양한 테마 기능으로 애플리케이션을 사용자 정의할 수 있도록 훌륭한 지원을 제공합니다. 이 글에서는 두 가지 핵심 테마 기능에 중점을 두겠습니다:

A) 다크 테마와 라이트 테마 간 전환하기.

B) 테마 확장을 사용하여 추가 테마 데이터 클래스를 생성하여 더 많은 사용자 정의를 할 수 있습니다.

完전한 작동하는 샘플 코드에 대한 접근은 동봉된 GitHub 저장소를 참조해주세요.

<div class="content-ad"></div>

![image](/assets/img/2024-06-23-CustomizeFlutterAppThemesSwappingBetweenLightDarkModesandUsingExtensions_0.png)

# 다크 테마와 라이트 테마 사이를 전환하세요

다크 테마와 라이트 테마 사이를 전환하는 것은 다음 예시에서 알 수 있듯이 매우 간단합니다:

```js
return MaterialApp(
  ...
  themeMode: themeMode,
  darkTheme: ThemeData.dark(),
  theme: ThemeData.light(),
  ...
);
```

<div class="content-ad"></div>

이 세 가지 필드는 앱이 적용해야 하는 테마의 유형을 지정할 수 있습니다. 기본적으로 themeMode는 darkTheme 또는 theme을 사용할지를 결정합니다.

ThemeMode에는 세 가지 값이 있습니다:

- ThemeMode.light: 앱에 밝은 테마를 사용하도록 지시합니다.
- ThemeMode.dark: 앱에 어두운 테마를 사용하도록 지시합니다.
- ThemeMode.system: 앱이 시스템의 테마와 일치하도록 지시합니다.

애플리케이션의 테마를 동적으로 변경하려면 코드가 반응해야 합니다. 실제적이고 효율적인 방법은 변경 사항에 응답할 수 있는 상태를 App 위젯 위에 배치하는 것입니다. 이 상태는 원하는 방식으로 관리할 수 있습니다. 현재, 저는 애플리케이션의 상태 관리에 플러터 프로바이더를 사용하고 있습니다.

<div class="content-ad"></div>

```js
return Solid(
  providers: [
    Provider<Signal<ThemeMode>>(create: () => Signal(ThemeMode.system)),
  ],
  builder: (context) {
    final themeMode = context.observe<ThemeMode>();
    return MaterialApp(
      ...
      themeMode: themeMode,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      ...
    );
  },
);
```

그 후, 애플리케이션 어디서든 메서드를 호출하여 프로바이더에게 값을 변경하도록 지시할 수 있습니다. 이는 애플리케이션을 그에 맞게 다시 빌드합니다:

```js
context.get<Signal<ThemeMode>>().value = newThemeMode;
```

앱이 시작할 때마다 ThemeMode를 저장하고 가져와서 사용자의 테마 선호도를 유지해야 합니다. 이렇게 하면 사용자의 선택사항이 기억되고 일관되게 적용됩니다.

<div class="content-ad"></div>

# 테마 확장 사용하기

다크 테마와 라이트 테마를 전환하는 것만으로도 좋지만, Flutter를 사용하면 테마 확장을 통해 더 많은 사용자 정의가 가능합니다. 테마 확장은 표준 ThemeData를 넘어 사용자 정의 속성과 스타일을 정의할 수 있게 해줍니다.

다음은 ThemeExtension을 확장한 클래스의 일부 코드입니다:

```js
class MyCustomThemeExtension extends ThemeExtension<MyCustomThemeExtension> {
  const MyCustomThemeExtension({
    required this.customColor,
  });

  MyCustomThemeExtension.light() : customColor = Colors.yellow.shade900;

  MyCustomThemeExtension.dark() : customColor = Colors.green.shade900;

  final Color customColor;

  @override
  ThemeExtension<MyCustomThemeExtension> copyWith({
    Color? customColor,
  }) {
    return MyCustomThemeExtension(customColor: customColor ?? this.customColor);
  }

  @override
  ThemeExtension<MyCustomThemeExtension> lerp(
    covariant ThemeExtension<MyCustomThemeExtension>? other,
    double t,
  ) {
    if (other is! MyCustomThemeExtension) return this;
    return MyCustomThemeExtension(
      customColor: Color.lerp(customColor, other.customColor, t)!,
    );
  }
}
```

<div class="content-ad"></div>

저는 이 클래스를 매우 간단하게 유지하여 효과적으로 사용하는 방법을 보여주기 위해 노력했습니다.

먼저, 이 클래스를 ThemeData에 추가하여 확장하고 해당 확장을 서브트리 내에서 접근할 수 있도록 해야 합니다:

```js
return ThemeData(
  ...
  extensions: [MyCustomThemeExtension.light()],
  ...
);
```

우리가 이전에 선언한 customColor를 활용하기 위해서는 해당 확장에 접근하면 됩니다:

<div class="content-ad"></div>

```js
마지막 색상 = Theme.of(context)
                        .extension<MyCustomThemeExtension>()!
                        .customColor;
```

ThemeExtension의 사용은 특히 Material 사양과 긴밀히 연결되지 않은 디자인 시스템을 코딩할 때 특히 유용하다고 생각합니다. 이러한 경우에는 ThemeData의 기본 필드가 충분하지 않거나 디자인 시스템의 요구 사항과 의미적으로 일치하지 않을 수 있습니다.

# 결론

테마 전환을 통해 개발자는 더 동적이고 현대적인 애플리케이션을 만들 수 있을 뿐만 아니라 사용자의 요구를 존중할 수 있다고 생각합니다. 저는 개인적으로 다크 모드를 많이 사용하고 애플리케이션이 그것을 지원하지 않을 때 약간 긴장을 느낍니다.

<div class="content-ad"></div>

테이블 태그를 Markdown 형식으로 변경해 드렸어요.

좋은 하루 보내세요!

## 참고문헌
