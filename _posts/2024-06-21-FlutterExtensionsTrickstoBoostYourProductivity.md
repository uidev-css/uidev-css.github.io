---
title: "Flutter 확장 프로그램 생산성을 높이는 7가지 꿀팁 "
description: ""
coverImage: "/assets/img/2024-06-21-FlutterExtensionsTrickstoBoostYourProductivity_0.png"
date: 2024-06-21 21:39
ogImage:
  url: /assets/img/2024-06-21-FlutterExtensionsTrickstoBoostYourProductivity_0.png
tag: Tech
originalTitle: "Flutter Extensions: Tricks to Boost Your Productivity 💫"
link: "https://medium.com/stackademic/flutter-extensions-tricks-to-boost-your-productivity-88573b7efc0f"
---

![이미지](/assets/img/2024-06-21-FlutterExtensionsTrickstoBoostYourProductivity_0.png)

플러터 코드가 정체되어 있는 기분이 들죠? 반복적인 보일러플레이트를 작성하거나 기존 클래스에 슈퍼파워를 추가하고 싶은가요? 그렇다면, 플러터 개발자 여러분, 확실하게 할 일을 해야 합니다! 약간의 마법 같은 힘을 담아줄 확장 함수로 여러분의 작업 흐름에 활력을 불어넣어 보세요! 이 안내서에서는 이러한 다재다능한 코드 챔피언들의 비밀을 밝혀내어 기존 유형을 확장하고 코드를 간소화하며 플러터 게임의 수준을 높이도록 도와줄 것입니다. 이 강력한 확장 기능을 통해 반복적인 수고를 벗어던지고 더 깔끔하고 표현력이 풍부한 코드의 세계를 받아들이세요!

# A. BuildContext에 대한 Extension

먼저, 확장 기능을 만들고 이 확장 기능이 BuildContext를 확장한다는 것을 확실히하고 메서드를 확장 기능에 넣으세요:

<div class="content-ad"></div>

# 테이블 태그를 Markdown 형식으로 변경

```js
extension ContextExt on BuildContext {

    // 여기에 EXT 함수를 넣으세요

}
```

1. 테마에 쉽게 접근하기

```js
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get canvasColor => Theme.of(this).canvasColor;
  Color get cardColor => Theme.of(this).cardColor;
  Color get focusColor => Theme.of(this).focusColor;
  Color get dialogBackgroundColor => Theme.of(this).dialogBackgroundColor;
  Color get disabledColor => Theme.of(this).disabledColor;
  Color get dividerColor => Theme.of(this).dividerColor;
  Color get highlightColor => Theme.of(this).highlightColor;
  Color get hintColor => Theme.of(this).hintColor;
  Color get hoverColor => Theme.of(this).hoverColor;
  Color get indicatorColor => Theme.of(this).indicatorColor;
  Color get primaryDark => Theme.of(this).primaryColorDark;
  Color get primaryLight => Theme.of(this).primaryColorLight;
  Color get shadowColor => Theme.of(this).shadowColor;
```

2. MediaQuery에 쉽게 접근하기

<div class="content-ad"></div>

```js
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  double get aspectRatio => MediaQuery.of(this).size.aspectRatio;
  double get longestSide => MediaQuery.of(this).size.longestSide;
  double get shortestSide => MediaQuery.of(this).size.shortestSide;
  Orientation get orientation => MediaQuery.of(this).orientation;
  EdgeInsets get padding => MediaQuery.of(this).padding;
```

3. SnackBar 표시하기

```js
  void showSnackBar(String message) {
    if (!mounted) return;
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
```

4. AlertDialog 표시하기

<div class="content-ad"></div>

```js
  void displayAlertDialog({
    required String title,
    required String content,
    VoidCallback? onPositivePressed,
    String positiveButtonText = 'OK',
    VoidCallback? onNegativePressed,
    String negativeButtonText = 'Cancel',
  }) {
    if (!mounted) return;
    showDialog(
      context: this,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: onNegativePressed ??
                  () {
                    Navigator.of(this).pop();
                  },
              child: Text(negativeButtonText),
            ),
            TextButton(
              onPressed: onPositivePressed ??
                  () {
                    Navigator.of(this).pop();
                  },
              child: Text(positiveButtonText),
            ),
          ],
        );
      },
    );
  }
```

5. 방향 기반으로 위젯 작성하기

```js
  T orientationAction<T>({
    required T Function() onPortrait,
    required T Function() onLandscape,
  }) {
    if (MediaQuery.of(this).orientation == Orientation.landscape) {
      return onLandscape();
    }
    return onPortrait();
  }
```

<br>

<img src="https://miro.medium.com/v2/resize:fit:1200/1*aFEZr6_WdUFq3-DRjnYm9g.gif" />

<div class="content-ad"></div>

# 위젯 확장

위젯을 확장하려면 먼저 확장 프로젝트를 만들고 위젯에 적용하세요.

```js
extension WidgetExt on Widget {

    // 여기에 확장 함수를 넣으세요

}
```

- 위젯 확장하기

<div class="content-ad"></div>

```js
확장된확장({int flex = 1}) => Expanded(
        flex: flex,
        child: this,
      );
```

2. 투명도 설정

```js
투명도설정(double val) => Opacity(
        opacity: val,
        child: this,
      );
```

3. Padding 추가하기

<div class="content-ad"></div>

```js
Padding withPadding(EdgeInsets padding) => Padding(
        padding: padding,
        child: this,
      );
```

4. Wrap with SizedBox

```js
SizedBox box({double? width, double? height}) =>
      SizedBox(width: width, height: height, child: this);
```

5. Centerize It!

<div class="content-ad"></div>

```js
  Center center() => Center(
    child: this,
  );
```

6. 클릭 가능하게 만들기

```js
Widget onClick(Function() onClick) => InkWell(
        onTap: onClick,
        child: this,
      );
```

7. 회전하기!

<div class="content-ad"></div>

```js
RotatedBox rotate(int quarterTurns) => RotatedBox(
  quarterTurns: quarterTurns,
  child: this,
);
```

![image](https://miro.medium.com/v2/resize:fit:1200/1*4Wh8PWVfCj2Jf3wlfSELYA.gif)

# C. Extension on String

먼저 확장 기능을 만들고 문자열을 확장하세요.

<div class="content-ad"></div>

```js
extension StringExt on String {

  // 여기에 EXT 함수 추가하세요

}
```

- 텍스트 위젯으로 변환

```js
Text get text => Text(this);
```

2. 매치해 보세요!

<div class="content-ad"></div>

```js
// 8자리 문자, 소문자, 대문자, 숫자를 포함해야 함
bool isValidPassword() {
  return RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$').hasMatch(this);
}

bool isValidEmail() {
  return RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(this);
}

bool isURL() {
  // 간단한 URL 패턴에 대한 정규 표현식
  RegExp urlRegExp = RegExp(
    r'^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$',
    caseSensitive: false,
    multiLine: false,
  );

  return urlRegExp.hasMatch(this);
}
```

3. 기타 내용

```js
String append(String other) => '$this$other';

String get capitalizeFirstLetter =>
    this.isNotEmpty ? this[0].toUpperCase() + this.substring(1) : this;

String get removeWhitespace => this.replaceAll(RegExp(r'\s+'), '');

// 형식: yyyy-MM-dd HH:mm:ss
DateTime toDateTime() {
  return DateTime.parse(this);
}
```

# D. Num 확장

<div class="content-ad"></div>

먼저 Extension을 만들고 num을 확장하세요.

```js
extension NumExt on num {

    // 여기에 EXT 함수를 넣어주세요

}
```

- 수직 및 수평 간격을 간단하게 만듭니다.

```js
SizedBox get heightBox => SizedBox(
        height: toDouble(),
      );

SizedBox get widthBox => SizedBox(
        width: toDouble(),
      );
```

<div class="content-ad"></div>

2. 패딩으로 변환

```js
EdgeInsets get allPadding => EdgeInsets.all(toDouble());

EdgeInsets get verticalPadding => EdgeInsets.symmetric(vertical: toDouble());

EdgeInsets get horizontalPadding => EdgeInsets.symmetric(horizontal: toDouble());

EdgeInsets get leftPadding => EdgeInsets.only(left: toDouble());

EdgeInsets get rightPadding => EdgeInsets.only(right: toDouble());

EdgeInsets get topPadding => EdgeInsets.only(top: toDouble());

EdgeInsets get bottomPadding => EdgeInsets.only(bottom: toDouble());
```

3. 기간으로 변환

```js
Duration get microseconds => Duration(microseconds: toInt());

Duration get milliseconds => Duration(milliseconds: toInt());

Duration get seconds => Duration(seconds: toInt());

Duration get minutes => Duration(minutes: toInt());

Duration get hours => Duration(hours: toInt());

Duration get days => Duration(days: toInt());
```

<div class="content-ad"></div>

# 기타

- DateTime 확장

```js
extension DateTimeExt on DateTime {
  bool isToday() {
    final now = DateTime.now();
    return day == now.day && month == now.month && year == now.year;
  }

  bool isYesterday() {
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    return day == yesterday.day &&
        month == yesterday.month &&
        year == yesterday.year;
  }

  // yyyy-mm-dd
  String get stringFormat => toIso8601String().substring(0, 10);
}
```

2. 파일 확장

<div class="content-ad"></div>

```js
extension FileExt on File {
  Future<Uint8List?> toUint8List() async {
    try {
      List<int> bytes = await readAsBytes();
      Uint8List uint8List = Uint8List.fromList(bytes);
      return uint8List;
    } catch (e) {
      return null;
    }
  }

  bool isImageFile() {
    final String extension = path.split('.').last.toLowerCase();
    return ['jpg', 'jpeg', 'png', 'gif', 'bmp'].contains(extension);
  }

  bool isVideoFile() {
    final String extension = path.split('.').last.toLowerCase();
    return ['mp4', 'avi', 'mkv', 'mov', 'wmv', 'flv', 'webm'].contains(extension);
  }

  bool isAudioFile() {
    final String extension = path.split('.').last.toLowerCase();
    return ['mp3', 'wav', 'ogg', 'aac', 'flac', 'm4a', 'wma'].contains(extension);
  }
}
```

3. Scope Function Extension

```js
extension ScopeFunctionExt<T> on T {

  // Do Something on The Object and returns Something
  R map<R>(R Function(T) block) {
    return block(this);
  }

  // Do Something on The Object and returns The Object
  T apply(Function(T) block) {
    block(this);
    return this;
  }
}
```

플러터에서 확장 메서드에 대한 코드 팁을 보여드렸습니다. 생산성을 높이는 데 도움이 되는 내용일지 모릅니다. 만약 이 기사가 유익했다면 👏 박수를 보내주시고, 휴대폰 개발에 관한 다양한 기사를 확인하시려면 팔로우해주세요. 감사합니다. 계속해서 생산적이세요 🔥

<div class="content-ad"></div>

아래는 제 GitHub에서 제 쿨한 프로젝트들을 확인해보세요:

# 나와 소통하기:

- Medium
- GitHub
- LinkedIn

<div class="content-ad"></div>

# Stackademic

끝까지 읽어 주셔서 감사합니다. 떠나기 전에:

- 작가를 칭찬하고 팔로우해 주시면 감사하겠습니다! 👏
- Twitter(X), LinkedIn, YouTube에서 팔로우해 주세요.
- 세계적으로 프로그래밍 교육을 무료로 더 democra타이징하는 Stackademic.com 방문하기.
