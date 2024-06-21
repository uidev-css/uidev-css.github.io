---
title: "Flutter 프로젝트 05 광학 문자 인식OCR 앱 만들기"
description: ""
coverImage: "/assets/img/2024-06-21-FlutterProjects05BuildinganOpticalCharacterRecognitionOCRApp_0.png"
date: 2024-06-21 21:19
ogImage: 
  url: /assets/img/2024-06-21-FlutterProjects05BuildinganOpticalCharacterRecognitionOCRApp_0.png
tag: Tech
originalTitle: "Flutter Projects #05: Building an Optical Character Recognition (OCR) App"
link: "https://medium.com/@frojho/flutter-projects-05-building-an-optical-character-recognition-ocr-app-639c165f857d"
---


<img src="/assets/img/2024-06-21-FlutterProjects05BuildinganOpticalCharacterRecognitionOCRApp_0.png" />

이 튜토리얼에서는 Flutter를 사용하여 광학 문자 인식 (OCR) 애플리케이션을 만드는 단계를 안내합니다. google_mlkit_text_recognition 패키지를 사용하여 이미지에서 텍스트를 추출할 것입니다. 이 안내서는 초보자에게 이상적이며 코드의 각 부분을 자세히 설명할 것입니다.

이 글은 플러터로 첫 번째 애플리케이션을 만드는 초보 개발자들을 돕기 위해 다양한 프로젝트를 만드는 일련의 기사 중 일부입니다. 따라서 UI 조립, 프로그래밍 로직, 그리고 좋은 프로그래밍 관행을 연습할 수 있습니다. 이전 기사를 놓친 경우 이를 확인할 수 있습니다.

- 초보자를 위한 플러터 프로젝트 #01: BMI 계산기 구축
- 초보자를 위한 플러터 프로젝트 #02: 할 일 목록 구축
- 초보자를 위한 플러터 프로젝트 #03: 다크 모드 및 라이트 모드 전환
- 초보자를 위한 플러터 프로젝트 #04: 채팅 GPT 앱 구축

<div class="content-ad"></div>

![image](https://miro.medium.com/v2/resize:fit:960/1*MHgy2Jl-x4X3NG0UYAL9qQ.gif)

# 플러터 프로젝트 시작하기

먼저 할 일은 플러터 프로젝트를 설정하는 것입니다. 이미 플러터가 설치되어 있는지 확인하세요. 그렇지 않다면, https://flutter.dev/docs/get-started/install 에서 설치 지침을 따를 수 있습니다.

다음으로, 터미널에서 다음 명령을 사용하여 새 플러터 프로젝트를 생성하세요:

<div class="content-ad"></div>

```js
flutter create flutter_ocr
```

프로젝트 디렉토리로 이동하고 다음 명령어로 VSCode에서 프로젝트를 엽니다:

```js
cd flutter_ocr && code .
```

# 초기 설정


<div class="content-ad"></div>

자, 이제 실제 코드 작성을 시작해봅시다. 먼저 main.dart 파일에서 몇 가지 작은 변경사항을 시작해보겠습니다.

자동으로 생성된 주석을 삭제하고 MyHomePage 클래스도 제거해주세요(우리만의 사용자 정의 위젯을 만들 예정이에요). 그리고 MyApp 위젯의 내용을 잘라서 my_app.dart 라는 파일에 추가해주세요. 그런 다음, 이 새 파일을 main.dart에서 내보내세요.

당신의 main.dart 파일은 다음과 같은 모습이어야 합니다:

```js
import 'package:flutter/material.dart';
import 'package:flutter_ocr/src/my_app.dart';

void main() => runApp(const MyApp());
```

<div class="content-ad"></div>

그리고 당신의 my_app.dart 파일은 다음과 같이 보여야 합니다:

```js
import 'package:flutter/material.dart';
import 'package:flutter_ocr/src/pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter OCR',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
```

# HomePage Widget 생성하기

프로젝트를 더 잘 구성하기 위해, 'lib' 폴더 안에 'pages'라는 폴더를 생성한 다음 그 안에 'home_page.dart'라는 새 파일을 만드세요.

<div class="content-ad"></div>

이 새 파일 안에 build 메서드에서 Scaffold를 가지는 새 StatefulWidget을 생성해 보세요. 예시 코드는 다음과 같을 것입니다:

```js
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter OCR')),
      body: const Column(
        children: [],
      ),
    );
  }
}
```

# 패키지의 설치 및 구성

OCR 앱을 시작하기 위해 Flutter 프로젝트에 필요한 종속 항목을 추가하는 단계를 따라보세요.

<div class="content-ad"></div>

이 프로젝트에서는 세 가지 패키지를 사용할 거에요:

- image_picker: 갤러리나 카메라에서 이미지를 선택하는 데 사용돼요.
- image_cropper: 선택한 이미지를 자르는 데 사용돼요.
- google_mlkit_text_recognition: 이미지에서 텍스트 인식을 수행하는 데 사용돼요.

## 종속성 추가하기

pubspec.yaml 파일을 열고 다음 종속성을 추가해주세요:

<div class="content-ad"></div>

```yaml
dependencies:
  flutter:
    sdk: flutter

  cupertino_icons: ^1.0.6 
  image_picker: ^1.1.2
  image_cropper: ^7.0.5
  google_mlkit_text_recognition: ^0.13.0
```

의존성을 추가한 후 아래 명령을 실행하여 설치하십시오:

```bash
flutter pub get
```

Android에서 image_cropper 패키지가 올바르게 작동하려면 추가 구성이 필요합니다. AndroidManifest.xml 파일을 열어 `manifest` 태그 안에 다음 코드를 추가하십시오:


<div class="content-ad"></div>

```js
<activity
    android:name="com.yalantis.ucrop.UCropActivity"
    android:screenOrientation="portrait"
    android:theme="@style/Theme.AppCompat.Light.NoActionBar"/>
```

이제 여러분의 프로젝트에서 필요한 모든 패키지를 사용할 수 있는 준비가 되었습니다.

# 홈페이지 UI 만들기

먼저, widgets라는 새 폴더를 만들고 이 폴더 안에 picker_option_widget.dart라는 파일을 생성하십시오. 이러면 다음과 같이 보일 것입니다:

<div class="content-ad"></div>

```js
import 'package:flutter/material.dart';

class PickerOptionWidget extends StatelessWidget {
  const PickerOptionWidget({
    super.key,
    required this.color,
    required this.label,
    required this.icon,
    this.onTap,
  });

  final Color color;

  final String label;

  final IconData icon;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: color.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 38.0,
                color: color,
              ),
              const SizedBox(height: 10.0),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

이 위젯을 사용하여 코드를 더 정리하고 반복을 피할 거예요. 이 버튼은 기기 갤러리나 카메라를 열기 위해 사용될 거에요.

## 그러면 이제 HomePage의 구조를 설정할 수 있어요.

HomePage에서 String 타입의 _extractedText라는 변수를 만들어주세요. 이 변수는 이미지로부터 추출된 텍스트를 저장할 거에요.

<div class="content-ad"></div>

```js
/// 이미지에서 추출된 텍스트를 저장할 변수
String _extractedText = '';
```

이제 이전에 만든 위젯을 사용하여 Scaffold를 구성할 수 있습니다. 다음과 같이 보여야 합니다:

```js
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Flutter OCR')),
    body: Column(
      children: [
        const Text(
          '옵션을 선택하세요',
          style: TextStyle(fontSize: 22.0),
        ),
        const SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 20.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PickerOptionWidget(
                label: '갤러리에서',
                color: Colors.blueAccent,
                icon: Icons.image_outlined,
                onTap: () {
                  /// 갤러리에서 이미지 가져오는 코드
                },
              ),
              const SizedBox(width: 10.0),
              PickerOptionWidget(
                label: '카메라에서',
                color: Colors.redAccent,
                icon: Icons.camera_alt_outlined,
                onTap: () {
                  /// 카메라에서 이미지 가져오는 코드
                },
              ),
            ],
          ),
        ),
        if (_extractedText.isNotEmpty) ...{
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 10.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '이전에 읽은 내용',
                  style: TextStyle(fontSize: 22.0),
                ),
                IconButton(
                  onPressed: () {
                    /// 텍스트를 클립 보드에 복사하는 코드
                  },
                  icon: const Icon(Icons.copy),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 20.0,
                  ),
                  child: Text(_extractedText),
                ),
              ),
            ),
          )
        },
      ],
    ),
  );
}
```

## 이 코드에 대한 몇 가지 설명:


<div class="content-ad"></div>

- 사용자 정의 위젯 PickerOptionWidget은 두 번 사용되며 각각 버튼과 같은 UI 요소를 나타냅니다. 갤러리에서 이미지를 선택하는 경우(갤러리에서)와 카메라로 이미지를 촬영하는 경우(카메라에서).
- 두 위젯은 서로 다른 스타일(색상 및 아이콘)을 가지며 사용자 상호 작용을 처리하는 onTap 콜백이 정의되어 있습니다(구현 예정).
- _extractedText가 비어 있지 않은지 확인합니다(_extractedText.isNotEmpty). 만약 true이면 다음과 같이 렌더링됩니다:
- "이전에 읽은 내용"이라는 텍스트와 복사 아이콘(Icons.copy)을 가진 IconButton이 있는 행(Row). 클립보드로 텍스트를 복사하는 onPressed 콜백이 정의되어 있습니다(구현 예정).
- 스타일이 적용된 Container를 포함하는 Expanded 위젯.
- 컨테이너 안에는 _extractedText를 표시하는 Text 위젯이 포함된 SingleChildScrollView가 있습니다.

이제 우리는 기본 구조를 만들었고 다음에 생성할 메소드를 받아들일 준비가 되었습니다.

# 필요한 메소드 생성

이제 이미지 선택, 선택한 이미지 자르기 및 텍스트 추출을 담당할 함수를 만들어 봅시다.

<div class="content-ad"></div>

각 부분을 각각의 메소드로 분리하여 조직화하고 이해하기 쉽도록 유지할 것입니다.

먼저 사용할 패키지를 가져오겠습니다:

```js
import 'dart:io';
...
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
```

## 이미지 선택기

<div class="content-ad"></div>

먼저, 장치에서 이미지를 선택할 수 있도록 하는 메소드를 만들어봅시다.

```js
Future<File?> _pickerImage({required ImageSource source}) async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: source);
  if (image != null) {
    return File(image.path);
  }
  return null;
}
```

설명:

- final ImagePicker picker = ImagePicker();: ImagePicker 클래스의 인스턴스를 생성하여 장치의 이미지 선택기 기능에 액세스합니다.
- final XFile? image = await picker.pickImage(source: source);: 이 줄은 ImagePicker 인스턴스의 pickImage 메소드를 사용하여 장치의 이미지 선택기 인터페이스를 엽니다. 사용자가 이미지를 선택할 때까지 기다립니다. source 매개변수는 갤러리 또는 카메라를 여는지를 지정합니다. 결과는 XFile? 유형의 변수 image에 저장됩니다.
- if (image != null) ': 사용자가 실제로 이미지를 선택했는지 확인합니다. 이미지가 null이 아닌 경우 이미지가 선택된 것을 의미합니다.
- return File(image.path);: 이미지가 선택된 경우, 이 줄은 이미지의 파일 경로를 사용하여 XFile을 File로 변환하고 반환합니다.

<div class="content-ad"></div>

## 이미지 크롭

이제 선택한 이미지를 자르는 기능을 만들어 보겠습니다. 특정 영역에서 텍스트만을 추출하고 싶은 큰 이미지가 있는 경우 매우 유용합니다.

```js
Future<CroppedFile?> _cropImage({required File imageFile}) async {
  CroppedFile? croppedfile = await ImageCropper().cropImage(
    sourcePath: imageFile.path,
    uiSettings: [
      AndroidUiSettings(
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
      ),
      IOSUiSettings(
        minimumAspectRatio: 1.0,
      ),
    ],
  );

  if (croppedfile != null) {
    return croppedfile;
  }

  return null;
}
```

- ImageCropper().cropImage(: ImageCropper의 인스턴스를 생성하고 즉시 cropImage 메서드를 호출합니다.
- sourcePath: imageFile.path,: 자르려는 imageFile의 경로를 sourcePath 매개변수로 지정합니다.
- AndroidUiSettings 및 IOSUiSettings: 각각 Android 및 iOS 플랫폼에서 자르기에 대한 UI 설정을 정의합니다.
- aspectRatioPresets: Android에서 사용 가능한 자르기용 가로세로 비율을 지정합니다. 예시로는 square, 3:2, original, 4:3, 16:9 등이 있습니다.
- minimumAspectRatio: iOS에서 자르기에 허용되는 최소 가로세로 비율을 정의합니다. 여기서는 1.0으로 설정했습니다.
- await ImageCropper().cropImage(...): 제공된 설정을 기반으로 자르기 작업을 비동기적으로 시작하고 사용자가 자르기 작업을 수행할 때까지 대기합니다.
- croppedfile이 null이 아닌 경우(즉, 사용자가 이미지를 성공적으로 자르는 경우), 해당 croppedfile을 반환합니다.

<div class="content-ad"></div>

## Google의 ML Kit 텍스트 인식

이제 이미지에서 텍스트 인식을 수행하는 책임을 가지는 메소드를 작성해봅시다.

```js
Future<String> _recognizeTextFromImage({required String imgPath}) async {
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  final image = InputImage.fromFile(File(imgPath));
  final recognized = await textRecognizer.processImage(image);

  return recognized.text;
}
```

- final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);: TextRecognitionScript.latin 스크립트를 사용하여 TextRecognizer 인스턴스를 생성합니다. TextRecognitionScript는 텍스트 인식에 사용할 언어 스크립트를 지정합니다.
- final image = InputImage.fromFile(File(imgPath));: imgPath에서 지정된 파일에서 InputImage 객체를 생성합니다. File 클래스는 장치에서 파일에 액세스하고 조작하는 데 사용됩니다.
- final recognized = await textRecognizer.processImage(image);: textRecognizer의 processImage 메소드를 호출하여 이미지에서 텍스트 인식 작업을 수행합니다. 이 작업은 비동기적으로 실행되므로 (await을 사용함) 텍스트 인식이 완료될 때까지 메소드가 기다릴 수 있습니다.
- return recognized.text;: 이미지에서 추출된 인식된 텍스트를 반환합니다. recognized 객체에는 텍스트 인식 프로세스의 결과인 추출된 텍스트가 포함되어 있습니다.

<div class="content-ad"></div>

## 클립 보드에 복사

프로세스 결과를 클립 보드에 복사할 수 있는 메소드를 만들어 보겠습니다.

```js
void _copyToClipBoard() {
  Clipboard.setData(ClipboardData(text: _extractedText));

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('클립 보드에 복사되었습니다'),
    ),
  );
}
```

## 이미지 처리

<div class="content-ad"></div>

모든 과정을 한 메서드로 결합하는 함수를 만들어 봅시다.

```js
Future<void> _processImageExtractText({
  required ImageSource imageSource,
}) async {
  final imageFile = await _pickerImage(source: imageSource);

  if (imageFile == null) return;

  final croppedImage = await _cropImage(
    imageFile: imageFile,
  );

  if (croppedImage == null) return;

  final recognizedText = await _recognizeTextFromImage(
    imgPath: croppedImage.path,
  );

  setState(() => _extractedText = recognizedText);
}
```

- `final imageFile = await _pickerImage(source: imageSource);`: `_pickerImage` 메서드를 호출하여 지정된 `imageSource`에서 이미지를 선택합니다. 선택 과정이 완료될 때까지 기다렸다가 결과를 `imageFile`에 할당합니다.
- `final croppedImage = await _cropImage(imageFile: imageFile);`: 선택된 `imageFile`을 자르기 위해 `_cropImage` 메서드를 호출합니다. 자르기 과정이 완료될 때까지 기다렸다가 잘린 이미지(`CroppedFile`)를 `croppedImage`에 할당합니다.
- `final recognizedText = await _recognizeTextFromImage(imgPath: croppedImage.path);`: 자른 이미지의 경로(`croppedImage.path`)에 대해 텍스트 인식을 수행하기 위해 `_recognizeTextFromImage` 메서드를 호출합니다. 인식 과정이 완료될 때까지 기다렸다가 인식된 텍스트(`String`)를 `recognizedText`에 할당합니다.
- `setState(() => _extractedText = recognizedText);`: `_extractedText` 상태 변수를 `recognizedText`로 업데이트합니다. 이는 UI를 다시 빌드하여 추출된 텍스트를 표시하는 역할을 합니다.

# 모든 것을 자리에 놓기

<div class="content-ad"></div>

우리가 메소드를 생성하고 인터페이스를 설정해 놨으니, 이제 각 구현을 올바른 위치에 추가하기만 하면 됩니다.

먼저, 사용자가 이미지를 선택할 옵션을 고르는 위젯에서 이미지를 처리하는 함수를 호출할 것입니다. 이미 필요한 모든 것이 구현된 함수이므로 onTap 이벤트에 이를 추가하고 소스를 지정해주기만 하면 됩니다.

```js
...
child: Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    PickerOptionWidget(
      label: '갤러리에서 선택',
      color: Colors.blueAccent,
      icon: Icons.image_outlined,
      onTap: () => _processImageExtractText(
        imageSource: ImageSource.gallery,
      ),
    ),
    const SizedBox(width: 10.0),
    PickerOptionWidget(
      label: '카메라로 촬영',
      color: Colors.redAccent,
      icon: Icons.camera_alt_outlined,
      onTap: () => _processImageExtractText(
        imageSource: ImageSource.camera,
      ),
    ),
  ],
),
...
```

마지막으로, 결과를 클립보드 영역에 복사하는 함수를 추가하면 됩니다.

<div class="content-ad"></div>

```js
...
child: Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    const Text(
      '이전에 읽은 항목',
      style: TextStyle(fontSize: 22.0),
    ),
    IconButton(
      onPressed: _copyToClipBoard,
      icon: const Icon(Icons.copy),
    )
  ],
),
...
```

이제 모든 준비가 완료되었어요.

# 최종 결과물

<img src="https://miro.medium.com/v2/resize:fit:1200/1*FY0xUZ88uI-MJlc-dkbdCw.gif" />

<div class="content-ad"></div>

이 튜토리얼에서는 이미지에서 광학 문자 인식(OCR)을 수행하는 Flutter 애플리케이션을 생성했습니다. Flutter 환경을 설정하고, 갤러리 또는 카메라에서 이미지를 선택할 수 있는 옵션을 포함한 사용자 인터페이스를 디자인했습니다. Google ML Kit을 사용하여 이미지 자르기와 텍스트 추출을 포함한 이미지 처리 방법을 구현했으며 추출된 텍스트를 클립보드에 복사하는 기능을 통합했습니다. 이 과정에서 중요한 Flutter 패키지를 통합하는 방법, 이미지 처리를 위한 비동기 작업 관리, 동적 UI 업데이트를 통해 사용자 상호작용을 향상하는 방법 등을 배웠습니다. 이 튜토리얼은 이미지 처리 및 OCR을 위해 Flutter의 기능을 최대한 활용하는 실용적인 통찰을 제공하여 개발자들이 자신의 애플리케이션에 비슷한 기능을 효과적으로 구현할 수 있는 기술을 갖추도록 도와줍니다.

![Animation](https://miro.medium.com/v2/resize:fit:536/1*mVI3BmDdc3duwtvixvNU9A.gif)

프로젝트의 완전한 소스 코드는 이 글의 맨 끝에서 찾을 수 있습니다.

이 내용이 마음에 드셨다면, 박수를 보내주시고 제 포스트를 업데이트 받고 싶다면 팔로우해주세요! 👏👏👏

<div class="content-ad"></div>

힘이 함께하기를 바랍니다. 🤓