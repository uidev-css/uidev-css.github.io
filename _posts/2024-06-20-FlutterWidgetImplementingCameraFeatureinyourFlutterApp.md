---
title: "플러터 위젯 플러터 앱에 카메라 기능 구현하기"
description: ""
coverImage: "/assets/img/2024-06-20-FlutterWidgetImplementingCameraFeatureinyourFlutterApp_0.png"
date: 2024-06-20 13:43
ogImage: 
  url: /assets/img/2024-06-20-FlutterWidgetImplementingCameraFeatureinyourFlutterApp_0.png
tag: Tech
originalTitle: "Flutter Widget: Implementing Camera Feature in your Flutter App"
link: "https://medium.com/@olasoji.od/flutter-widget-implementing-camera-feature-in-your-flutter-app-b083ebd74058"
---


안녕하세요 여러분, 어떻게 지내세요? 잠깐 사라졌다가 다시 돌아왔습니다. 지금은 플러터 애플리케이션에 카메라를 구현하는 방법에 대해 설명해 드릴게요.

저는 이 기능을 앱에 추가할 필요가 별로 없었지만, 최근에 작업 중인 애플리케이션에 이 기능을 추가해야 했어요. 여러분도 구현하고 싶어 했던 부분이라면 함께 고고씽해요:

단계 1: pub.dev 사이트에서 "camera"라는 플러터 패키지를 import해 주세요.

귀하의 애플리케이션에 카메라 패키지를 종속성으로 추가해야 합니다.

<div class="content-ad"></div>

링크: https://pub.dev/packages/camera

![이미지](/assets/img/2024-06-20-FlutterWidgetImplementingCameraFeatureinyourFlutterApp_0.png)

단계 2: 다른 OS(android 및 ios) 설정:

지금, 이 패키지를 앱에 구현하는 동안, 각 OS에 대한 플러터 앱 코드베이스를 변경해야 합니다.

<div class="content-ad"></div>

iOS 구현:

ios/Runner/Info.plist에 두 개의 행을 추가하세요:

- Privacy - Camera Usage Description 키와 사용 설명이 있는 한 줄을 추가해주세요.
- 그리고 Privacy - Microphone Usage Description 키와 사용 설명이 있는 한 줄을 더 추가해주세요.

만약 Info.plist를 텍스트로 편집하는 경우, 다음을 추가하세요:

<div class="content-ad"></div>

```js
<key>NSCameraUsageDescription</key>
<string>여기에 사용 설명 입력</string>
<key>NSMicrophoneUsageDescription</key>
<string>여기에 사용 설명 입력</string>
```

Android 구현:

android/app/build.gradle 파일에서 최소 Android SDK 버전을 21로 변경하세요.

```js
minSdkVersion 21
```

<div class="content-ad"></div>

Step 3: 퍼미션 핸들러 패키지와 패스 프로바이더 패키지 설치하기

이 패키지를 설치하는 이유는 사용자에게 우리 애플리케이션에서 장치의 카메라를 사용할 수 있도록 허용하도록 허락을 받으려고 하는 것입니다. 허가가 허용되지 않으면 장치에서 카메라를 사용할 수 없을 것 같습니다. 사진을 찍은 후에는 이미지가 장치에 어디에 저장되었는지 액세스할 수 있어야 하므로 path_provider를 사용합니다.

퍼미션 핸들러 링크: https://pub.dev/packages/permission_handler

![image](/assets/img/2024-06-20-FlutterWidgetImplementingCameraFeatureinyourFlutterApp_1.png)

<div class="content-ad"></div>

경로 제공 링크: [여기](https://pub.dev/packages/path_provider)

![이미지](/assets/img/2024-06-20-FlutterWidgetImplementingCameraFeatureinyourFlutterApp_2.png)

단계 4: 카메라 초기화 및 권한 요청

다음으로 할 일은 앱에서 카메라를 초기화하고 그 과정에서 기기에 있는 카메라 목록을 가져올 수 있습니다. 아래 코드는 권한이 부여되었고 카메라가 초기화된 주요 파일인 main.dart 파일이 어떻게 보이는지 예시입니다.

<div class="content-ad"></div>

```dart
late List<CameraDescription> _cameras;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _cameras = await availableCameras();

  runApp(const MyApp());
  // runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    requestStoragePermission();
  }

  void requestStoragePermission() async {
    // Check if the platform is not web, as web has no permissions
    if (!kIsWeb) {
      // Request storage permission
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }

      // Request camera permission
      var cameraStatus = await Permission.camera.status;
      if (!cameraStatus.isGranted) {
        await Permission.camera.request();
      }
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
```

제 5 단계 : 카메라 기능 구현

카메라 컨트롤러 초기화

_CameraAppState 클래스에서 initState 메서드에서 카메라 컨트롤러를 초기화합니다.```

<div class="content-ad"></div>

```js
late CameraController controller;
```

여기서, 카메라를 초기화하고 해상도 프리셋을 ResolutionPreset.max로 설정했습니다.

카메라 초기화 처리

카메라를 초기화하고 이 과정 중에 발생할 수 있는 모든 오류를 처리하기 위해 controller.initialize()를 사용합니다.

<div class="content-ad"></div>

```js
controller.initialize().then((_) {
  if (!mounted) {
    return;
  }
  setState(() {});
}).catchError((Object e) {
  if (e is CameraException) {
    switch (e.code) {
      case 'CameraAccessDenied':
        // 여기에서 액세스 오류를 처리합니다.
        break;
      default:
        // 다른 오류를 처리합니다.
        break;
    }
  }
});
```

UI 구축하기

UI는 카메라 피드를 표시하는 CameraPreview 위젯과 이미지를 캡처하는 FloatingActionButton으로 구성됩니다. 그래서 FloatingActionButton을 클릭하면 카메라에 의해 표시된 이미지를 캡처할 수 있습니다.

```js
return SafeArea(
  child: Scaffold(
    appBar: AppBar(
      // 앱 바 설정
    ),
    body: Stack(
      children: <Widget>[
        CameraPreview(controller),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: FloatingActionButton(
              onPressed: () {
                _takePicture(); // 사진 촬영 메서드 호출
              },
              child: Icon(Icons.camera),
              backgroundColor: Colors.white,
              foregroundColor: AppColors.deepBlue,
            ),
          ),
        ),
      ],
    ),
  ),
);
```

<div class="content-ad"></div>

이미지 캡처 및 보기

여기에 플로팅 액션 버튼에 연결한 함수를 구현했습니다. 이 함수는 이미지를 캡처하는 유일한 목적으로 사용됩니다:

```js
void _takePicture() async {
  try {
    final XFile picture = await controller.takePicture();
    setState(() {
      imageFile = picture;
    });
    // 이미지를 캡처한 후 이미지 뷰 페이지로 이동
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageViewPage(imagePath: imageFile!.path),
      ),
    );
  } catch (e) {
    print("사진 찍기 오류 발생: $e");
  }
}
```

캡처한 이미지 파일 경로를 가져와 다음 페이지에서 캡처한 이미지를 볼 수 있도록 탐색을 포함했습니다.

<div class="content-ad"></div>

이미지 보기

이제 사진을 찍은 후에는 찍은 이미지를 보고 싶을 것입니다, 맞죠? 찍은 이미지를 볼 수 있는 페이지로 이동하는 것을 허용하는 페이지가 여기 있습니다:

```js
class ImageViewPage extends StatefulWidget {
  final String imagePath;
  const ImageViewPage({super.key, required this.imagePath});

  @override
  State<ImageViewPage> createState() => _ImageViewPageState();
}

class _ImageViewPageState extends State<ImageViewPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Captured Image'),
      ),
      body: Center(
        child: Image.file(File(widget.imagePath)),
      ),
    );
  }
}
```

마무리

<div class="content-ad"></div>

이 가이드에서는 카메라 패키지를 사용하여 Flutter 응용 프로그램에서 간단한 카메라 기능을 구현했습니다. 카메라를 초기화하고 초기화 오류를 처리하며, 캡처 및 이미지 보기를 위한 사용자 친화적인 UI를 제공했습니다. 이는 Flutter 앱에서 이미지 필터, 비디오 녹화 등 더 고급 카메라 기능을 구축하기 위한 기본 단계입니다. 코딩을 즐기세요!

아래는 사진을 찍고 그 작업을 실행하는 페이지의 전체 코드 구현입니다:

```js
class CameraApp extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraApp({super.key, required this.cameras});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;
  late XFile? imageFile;  // 캡처된 이미지 파일을 저장하는 변수

  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.cameras[1], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // 여기서 액세스 오류 처리
            break;
          default:
            // 다른 오류 처리
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.deepBlue,
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text(
            '사진 찍기',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Stack(
          children: <Widget>[
            CameraPreview(controller),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: FloatingActionButton(
                  onPressed: () {
                    _takePicture();  // 사진 찍는 메서드 호출
                  },
                  child: Icon(Icons.camera),
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.deepBlue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 사진 찍는 메서드
  void _takePicture() async {
    try {
      final XFile picture = await controller.takePicture();
      setState(() {
        imageFile = picture;
      });
      // 이미지 캡처 후 이미지 뷰 페이지로 이동
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageViewPage(imagePath: imageFile!.path),
        ),
      );
    } catch (e) {
      print("사진 찍기 오류: $e");
    }
  }
}
```

<img src="https://miro.medium.com/v2/resize:fit:592/1*oqIKI2wzNfzOj1IJ-EDmoQ.gif" />
```

<div class="content-ad"></div>

텍스트를 위해 감사합니다 👏 재미있게 읽으셨다면 한 번 클릭해 주시고, 계속해서 많은 글 읽어주세요. 함께 해서 즐거웠습니다 😊✌️