---
title: "Flutter 앱에 디자인 시스템 적용하는 방법 단계별 가이드"
description: ""
coverImage: "/assets/img/2024-06-22-HowtoimplementyourdesignsysteminaFlutterapp12_0.png"
date: 2024-06-22 05:11
ogImage:
  url: /assets/img/2024-06-22-HowtoimplementyourdesignsysteminaFlutterapp12_0.png
tag: Tech
originalTitle: "How to implement your design system in a Flutter app (1 2)"
link: "https://medium.com/@mregnauld/how-to-implement-your-design-system-in-a-flutter-app-1-2-d2e21b5fcffd"
---

<img src="/assets/img/2024-06-22-HowtoimplementyourdesignsysteminaFlutterapp12_0.png" />

코드를 깔끔하게 작성할 때 우리는 종종 앱의 기능을 위해 최상의 디자인 및 아키텍처 패턴을 구현하는 것을 먼저 생각합니다. 이것은 확실히 좋은 실천 방법이며, 여러분에게 충분히 권장할 수밖에 없어요.

하지만 프론트엔드 코드는 어떻게 해야 할까요? 어떻게 앱에서 디자인 시스템을 적절하게 구현할 수 있을까요? 그리고 디자인 시스템이란 무엇인가요? 그 목적과 가치는 무엇일까요?

이 글은 Aloïs Deniel의 작업에서 영감을 받았습니다. 해당 작업은 여기에서 찾아볼 수 있어요.

<div class="content-ad"></div>

# 디자인 시스템? 디자인 시스템이 정확히 뭘까요?

우선 시작해 봅시다.

디자인 시스템은 재사용 가능한 컴포넌트, 스타일 가이드(글꼴, 색상, 크기 등), 표준들의 집합으로, 디지털 제품의 디자인에서 일관성과 효율성을 촉진하기 위해 구성됩니다. 다양한 플랫폼과 애플리케이션에서 시각적 외형, 동작 및 사용자 경험의 일관성을 보장하기 위해 디자이너와 개발자들을 위한 중앙화된 자원으로 작용합니다.

모바일 앱의 경우, 디자인 시스템은 보통 3가지 카테고리로 나뉘어 집니다(이 사용 사례에 대해서 이 글의 나머지 부분도 이에 고수할 것입니다):

<div class="content-ad"></div>

- 원자 수준: 이 수준에서는 디자인 시스템의 매우 기본적인 부분인 색상, 글꼴, 그림자, 공통 간격, 카드의 반지름(있는 경우), 아이콘 등과 관련된 모든 내용을 찾을 수 있습니다.
- 분자 수준: 이 수준에서는 버튼, 체크박스, 라디오 버튼, 구분선, 입력 필드 등과 같은 가장 기본적이고 일반적인 위젯을 찾을 수 있습니다.
- 세포 수준: 이 수준에서는 앱바, 복잡한 카드 또는 사용자 정의 위젯(CustomPainter를 사용하는) 등과 같은 더 복잡한 위젯을 찾을 수 있습니다. 이러한 위젯은 앱 전체 또는 특정 페이지에 특화될 수 있습니다.

# 그러면 Material Design 또는 Cupertino Design으로 작업할 수 있겠네요.

음, 예... 하지만 사실은 아닙니다.

확실한 것은, Flutter SDK에서 제공하는 기본 테마를 사용하여 앱을 디자인할 수 있습니다. 그러나 빠르게 막히게 되고, 앱이 초보 학생이 만든 기본적인 앱처럼 보일 가능성이 높습니다.

<div class="content-ad"></div>

예를 들어, 기본 테마의 텍스트 테마의 제목 스타일을 사용자 정의할 수 있지만, 큰, 중간, 작은 3단계로 제한됩니다. 이것이 너무 제한적일 수 있습니다.

## 알아야 할 점. 어디서 시작해야 하나요?

### 전용 패키지

디자인 시스템을 위한 전용 패키지를 생성하는 것이 좋습니다. 필수는 아니지만, 중간 규모의 프로젝트에서도 이 부분을 완전히 건너뛸 수 있지만, 두 가지 이유로 이렇게 하는 것을 권장합니다:

<div class="content-ad"></div>

- 여러 앱 간에 쉽게 구현된 디자인 시스템을 공유할 수 있습니다.
- 앱의 로직에 대해 위젯이 알고 있는 것이 전혀 없다는 것이 보장됩니다.

## 네이밍 규칙

디자이너와 협업 중이라면 네이밍 규칙에 동의하는 것을 적극 권장합니다. 특히 앱의 서로 다른 화면을 구현하기 시작할 때 이는 특히 중요합니다. 각 화면의 각 구성 요소의 이름을 알고 있다면 (특히 Figma나 유사한 도구를 사용하는 경우) 설계 시스템 문서와 IDE 간에 오가며 작업 중인 문서에 해당하는 올바른 위젯을 찾아야 하는 번거로움을 피할 수 있습니다.

# 이제 디자인 시스템을 구현하는 시간입니다!

<div class="content-ad"></div>

## 테마 확장

테마 확장은 사용자 정의 테마를 만드는 데 훌륭한 도구입니다. 일반적으로 색상에 사용되지만 때로는 여러 위젯에서 공유되는 사용자 정의 텍스트 테마와 차원에도 사용됩니다.

먼저 색상부터 시작해보겠습니다. 다음과 같이 AppColorsTheme이라는 새 클래스를 생성하세요:

```js
class AppColorsTheme extends ThemeExtension<AppColorsTheme>
{
  // 참조 색상:
  static const _grey = Color(0xFFB0B0B0);
  static const _green = Color(0xFF00C060);
  static const _red = Color(0xFFED4E52);

  // 앱 전체에서 사용되는 실제 색상:
  final Color backgroundDefault;
  final Color backgroundInput;
  final Color snackbarValidation;
  final Color snackbarError;
  final Color textDefault;

  // 비공개 생성자 (아래의 팩토리를 대신 사용하세요):
  const AppColorsTheme._internal({
    required this.backgroundDefault,
    required this.backgroundInput,
    required this.snackbarValidation,
    required this.snackbarError,
    required this.textDefault,
  });

  // 라이트 모드용 팩토리:
  factory AppColorsTheme.light() {
    return AppColorsTheme._internal(
      backgroundDefault: _grey,
      backgroundInput: _grey,
      snackbarValidation: _green,
      snackbarError: _red,
      textDefault: _grey
    );
  }

  // 다크 모드용 팩토리:
  factory AppColorsTheme.dark() {
    return AppColorsTheme._internal(...);
  }

  @override
  ThemeExtension<AppColorsTheme> copyWith({bool? lightMode})
  {
    if (lightMode == null || lightMode == true) {
      return AppColorsTheme.light();
    }
    return AppColorsTheme.dark();
  }

  @override
  ThemeExtension<AppColorsTheme> lerp(
    covariant ThemeExtension<AppColorsTheme>? other,
    double t) => this;
}
```

<div class="content-ad"></div>

여기 몇 가지 언급할 사항이 있어요:

- 내 앱에서 실제로 사용되는 색상과 기본 색상을 의도적으로 분리했어요. 이유는 경우에 따라 다른 위젯들이 한 모드에서 동일한 색상을 공유하더라도, 다른 모드에서는 다른 색상이 필요할 수 있기 때문이에요. 이는 꽤 드물긴 하지만요.
- 여기서 팩토리를 사용하면 다양한 모드를 생성하는 것이 매우 간편해져요. 그래서 각 모드에 필요한 색상을 매우 쉽게 선택할 수 있어요. 분명히 몇 분 안에 새 모드를 추가할 수 있어요! 그리고 단지 다크 모드와 라이트 모드로만 제한되지 않고, 추가하고 싶은 어떤 색상 모드든 추가할 수 있어요!
- 저는 lerp() 메서드를 단순히 this로 다시 반환하여 재정의했지만, 만약 다른 색상 모드들 간의 부드러운 전환을 만들고 싶다면 여기서 보여주는 대로 Color.lerp()를 사용할 수 있어요. 크게 유용하진 않겠지만, 어쨌든 말이죠.

이제 글꼴에 대해 계속해봅시다. 아래와 같이 새 클래스인 AppTextsTheme을 생성해보세요:

```js
class AppTextsTheme extends ThemeExtension<AppTextsTheme>
{
  static const _baseFamily = "Base";

  final TextStyle labelBigEmphasis;
  final TextStyle labelBigDefault;
  final TextStyle labelDefaultEmphasis;
  final TextStyle labelDefaultDefault;

  const AppTextsTheme._internal({
    required this.labelBigEmphasis,
    required this.labelBigDefault,
    required this.labelDefaultEmphasis,
    required this.labelDefaultDefault,
  });

  factory AppTextsTheme.main() => AppTextsTheme._internal(
    labelBigEmphasis: TextStyle(
      fontFamily: _baseFamily,
      fontWeight: FontWeight.w400,
      fontSize: 18,
      height: 1.4,
    ),
    labelBigDefault: TextStyle(
      fontFamily: _baseFamily,
      fontWeight: FontWeight.w300,
      fontSize: 18,
      height: 1.4,
    ),
    labelDefaultEmphasis: TextStyle(
      fontFamily: _baseFamily,
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 1.4,
    ),
    labelDefaultDefault: TextStyle(
      fontFamily: _baseFamily,
      fontWeight: FontWeight.w300,
      fontSize: 16,
      height: 1.4,
    ),
  );

  @override
  ThemeExtension<AppTextsTheme> copyWith()
  {
    return AppTextsTheme._internal(
      labelBigEmphasis: labelBigEmphasis,
      labelBigDefault: labelBigDefault,
      labelDefaultEmphasis: labelDefaultEmphasis,
      labelDefaultDefault: labelDefaultDefault,
    );
  }

  @override
  ThemeExtension<AppTextsTheme> lerp(
    covariant ThemeExtension<AppTextsTheme>? other,
    double t) => this;
}
```

<div class="content-ad"></div>

여기 몇 가지 언급할 사항이 있습니다:

- 가능한 한 적은 글꼴을 사용하도록 노력하고, 앱에서 사용하는 글꼴에 대한 설계팀과의 명명 규칙에 합의하는 것이 중요합니다. 자주 사용할 수 있기 때문에 모의 구성에서 사용해야 할 올바른 글꼴을 알고있는 것은 매우 소중한 시간과 에너지를 절약할 수 있습니다.
- 이 사용 사례에서는 lerp() 메서드가 무용지물이므로 그냥 이를 반환합니다.
- 간단함을 위해 여기서 글꼴 크기를 하드코딩했지만, 나중에 화면 크기에 따라 글꼴 크기가 다양할 수 있도록 일부 응답 형식을 추가하는 방법을 보겠습니다.

마지막으로, 다음과 같이 차원에 대한 새로운 클래스인 AppDimensionsTheme을 생성합시다:

```js
class AppDimensionsTheme extends ThemeExtension<AppDimensionsTheme>
{
  final double radiusHelpIndication;
  final EdgeInsets paddingHelpIndication;

  const AppDimensionsTheme._internal({
    required this.radiusHelpIndication,
    required this.paddingHelpIndication,
  });

  factory AppDimensionsTheme.main() => AppDimensionsTheme._internal(
    radiusHelpIndication: 8,
    paddingHelpIndication: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  );

  @override
  ThemeExtension<AppDimensionsTheme> copyWith()
  {
    return AppDimensionsTheme._internal(
      radiusHelpIndication: radiusHelpIndication,
      paddingHelpIndication: paddingHelpIndication,
    );
  }

  @override
  ThemeExtension<AppDimensionsTheme> lerp(
    covariant ThemeExtension<AppDimensionsTheme>? other,
    double t) => this;
}
```

<div class="content-ad"></div>

여기 몇 가지 언급할 사항이 있어요:

- 앱의 각 차원에 이 클래스를 사용해야 할까요? 절대 그렇지 않아요. 차원을 한 곳에만 설정해야 하는 경우나 동일 위젯 내에서 여러 곳에 설정할 경우 해당 위젯에 유지하세요(예: const로). 위의 글꼴 및 색상 테마와는 달리 해당 클래스를 여러 위젯에서 차원을 공유해야 하는 경우에만 추천드립니다.
- 예상하신 대로, 반응성을 구현하는 좋은 출발점이기도 하지만, 이에 대해서는 나중에 다루겠습니다.

# 멋져요. 어떻게 사용하나요?

## 주 파일

<div class="content-ad"></div>

먼저 main.dart 파일로 이동하신 후, MaterialApp() 위젯 안에 ThemeData? 타입의 theme 속성이 있습니다. 단순히 아래와 같이 확장을 추가할 수 있습니다:

```js
MaterialApp(
  ...
  theme: Theme.of(context).copyWith(
    extensions: [
      AppDimensionsTheme.main(),
      AppColorsTheme.light(),
      AppTextsTheme.main(),
    ],
  ),
  ...
),
```

## ThemeData extension

다음 단계, 필수는 아니지만, 확장에 액세스하는 보일러플레이트 코드를 피하고 코드 구문을 간소화하는 데 매우 유용합니다. 다음과 같이 ThemeData 확장을 만드세요:

<div class="content-ad"></div>

```js
확장자 ThemeDataExtended에서 ThemeData에 대한 다음과 같은 테이블 태그를 Markdown 형식으로 변경하십시오.

## 구현 예시

이제 다음 예시와 같이 테마를 사용할 수 있습니다.

Text(
  "내 텍스트 예시",
  style: Theme.of(context).appTexts.labelDefaultEmphasis.copyWith(
    color: Theme.of(context).appColors.textDefault,
  ),
)

<div class="content-ad"></div>

# 반응형에 대해 이야기했었죠. 테마 파일에 적용할 수 있을까요?

물론이죠! 함께 알아봅시다.

## FlutterView 확장

다시 말씀드리지만, 다음 단계는 필수는 아닙니다. 그러나 앱에서 적합한 반응형을 구현하는 데 매우 도움이 될 수 있습니다. 또한, 이는 단순히 예시일 뿐이니 필요에 맞게 수정해 사용해주시기 바랍니다.

<div class="content-ad"></div>

위의 내용을 한국어로 번역해 드리겠습니다:

먼저 다음과 같이 FlutterView 확장을 생성해 봅시다:

extension FlutterViewExtended on FlutterView
{
  static const double responsive360 = 360;
  static const double responsive480 = 480;
  static const double responsive600 = 600;
  static const double responsive800 = 800;
  static const double responsive900 = 900;
  static const double responsive1200 = 1200;

  double get logicalWidth => physicalSize.width / devicePixelRatio;
  double get logicalHeight => physicalSize.height / devicePixelRatio;
  double get logicalWidthSA => (physicalSize.width - padding.left - padding.right) / devicePixelRatio;
  double get logicalHeightSA => (physicalSize.height - padding.top - padding.bottom) / devicePixelRatio;

  bool get isSmallSmartphone
  {
    if (logicalWidthSA < logicalHeightSA)
    {
      return (logicalWidthSA <= responsive360 || logicalHeightSA <= responsive600);
    }
    else
    {
      return (logicalWidthSA <= responsive600 || logicalHeightSA <= responsive360);
    }
  }

  bool get isRegularSmartphoneOrLess
  {
    if (logicalWidthSA < logicalHeightSA)
    {
      return (logicalWidthSA <= responsive480 || logicalHeightSA <= responsive800);
    }
    else
    {
      return (logicalWidthSA <= responsive800 || logicalHeightSA <= responsive480);
    }
  }

  bool get isSmallTabletOrLess
  {
    if (logicalWidthSA < logicalHeightSA)
    {
      return (logicalWidthSA <= responsive600 || logicalHeightSA <= responsive900);
    }
    else
    {
      return (logicalWidthSA <= responsive900 || logicalHeightSA <= responsive600);
    }
  }

  bool get isRegularTabletOrLess
  {
    if (logicalWidthSA < logicalHeightSA)
    {
      return (logicalWidthSA <= responsive800 || logicalHeightSA <= responsive1200);
    }
    else
    {
      return (logicalWidthSA <= responsive1200 || logicalHeightSA <= responsive800);
    }
  }
}

isSmallSmartphone 및 이후의 getter들이 필수는 아니지만, 위젯을 반응형으로 구현하고 싶을 때마다 다양한 값의 여러 개의 브레이크포인트를 추가하는 것보다 훨씬 간단하고 깔끔한 방식으로 반응형을 구현하는 데 도움이 될 것입니다. 이제 이전에 만든 AppDimensionsTheme로 돌아가서 다음과 같이 수정할 수 있습니다:

<div class="content-ad"></div>

클래스 AppDimensionsTheme은 ThemeExtension<AppDimensionsTheme>으로 확장됩니다.
{
  ...

  factory AppDimensionsTheme.main(FlutterView flutterView) => AppDimensionsTheme._internal(
    radiusHelpIndication: flutterView.isSmallSmartphone ? 8 : 16, // <- 여기서 반응형이 사용됩니다!
    paddingHelpIndication: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  );

  ...
}

보시는 대로, FlutterView의 인스턴스를 AppDimensionsTheme.main의 인수로 전달합니다. 이전에 생성한 확장을 import하는 것을 잊지 마세요.

그리고 main.dart 파일을 다음과 같이 업데이트하는 것을 잊지 마세요:

MaterialApp(
  ...
  theme: Theme.of(context).copyWith(
    extensions: [
      AppDimensionsTheme.main(View.of(context)),
      ...
    ],
  ),
  ...
)
```

<div class="content-ad"></div>

자 이제 앱에서 radiusHelpIndication을 사용할 때마다, 작은 스마트폰에서는 자동으로 8을 반환하고 그렇지 않으면 16을 반환합니다. 정말 간단하죠.

그런데 기다려주세요! MediaQuery 대신에 FlutterView를 사용하는 이유는 뭘까요? 실은 둘 중 어느 것이라도 상호 교환해서 사용할 수 있습니다. 거의요.

하지만 사실은 약간 다른 점이 있습니다. 위의 예시에서 View.of(context) 대신에 MediaQuery.of(context)를 사용하고 싶다고 가정해봅시다. 이것도 잘 동작하지만, MediaQuery를 사용하는 경우 위젯이 FlutterView를 사용할 때보다 더 자주 생성될 수 있는 경우가 있습니다.

그 예로는 가상 키보드를 열고 닫을 때(예: TextFormField에 포커스를 주거나 해제할 때) 추가적으로 빌드가 발생하는 것이 있습니다. 물론 MediaQuery.sizeOf(context)와 같은 것을 사용하여 이를 수정할 수 있지만, 그것을 덜 편한 것으로 여기기도 합니다. 최종적으로 어떻게 할지는 여러분에게 달려 있습니다.

<div class="content-ad"></div>

이제 2부로 계속하실 수 있습니다.
