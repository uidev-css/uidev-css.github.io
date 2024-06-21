---
title: "Flutter에서 PDF를 표시하는 방법"
description: ""
coverImage: "/assets/img/2024-06-21-HowtoDisplayaPDFinFlutter_0.png"
date: 2024-06-21 23:11
ogImage: 
  url: /assets/img/2024-06-21-HowtoDisplayaPDFinFlutter_0.png
tag: Tech
originalTitle: "How to Display a PDF in Flutter"
link: "https://medium.com/@ahmedtahaelelemy/how-to-display-a-pdf-in-flutter-9523e38f4ea1"
---


플러터는 iOS 및 Android용 모바일 앱을 구축하기 위한 강력한 프레임워크입니다. 다양한 플러그인과 패키지를 활용하여 플러터를 사용하면 앱에서 PDF 문서를 표시할 수 있습니다. 이 튜토리얼에서는 flutter_pdfview 패키지를 사용하여 Flutter 앱에서 PDF를 표시하는 방법을 알아보겠습니다.

# 필요한 패키지 설치

먼저, 앱에 flutter_pdfview 패키지를 추가해야 합니다. 이를 위해 pubspec.yaml 파일의 종속성 섹션에 다음 라인을 추가해주세요:

```yaml
dependencies:
  flutter_pdfview: ^1.2.5
```

<div class="content-ad"></div>

pubspec.yaml 파일을 업데이트한 후에는 다음 명령을 실행하여 패키지를 설치하실 수 있어요:

```js
flutter pub get
```

# 앱에 PDF 파일 추가하기

앱에서 PDF를 표시하려면 프로젝트에 PDF 파일을 추가해야 해요. 기존 PDF를 사용하거나 Adobe Acrobat이나 Google 문서와 같은 도구를 사용하여 새로운 PDF를 만들 수 있어요.

<div class="content-ad"></div>

PDF 파일이 준비되었으면 Flutter 프로젝트 자산에 추가하세요. 이를 위해 다음 줄을 pubspec.yaml 파일의 자산 섹션에 추가해주세요:

```js
assets:
  - assets/my_document.pdf
```

PDF 파일이 프로젝트 루트의 assets라는 디렉토리에 추가되었다고 가정합니다. 프로젝트 내의 위치에 따라 PDF 파일의 경로를 변경할 수 있습니다.

# 앱에서 PDF 표시하기

<div class="content-ad"></div>

우리 앱에서 PDF를 표시하기 위해 flutter_pdfview 패키지의 PDFView 위젯을 사용하는 새 위젯을 생성할 것입니다. 이 위젯을 사용하는 방법 예시가 있습니다:

```js
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
```

```js
class MyPdfViewer extends StatefulWidget {
  final String pdfPath;
  MyPdfViewer({required this.pdfPath});
  @override
  _MyPdfViewerState createState() => _MyPdfViewerState();
}
class _MyPdfViewerState extends State<MyPdfViewer> {
  late PDFViewController pdfViewController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My PDF Document"),
      ),
      body: PDFView(
        filePath: widget.pdfPath,
        autoSpacing: true,
        enableSwipe: true,
        pageSnap: true,
        swipeHorizontal: true,
        onError: (error) {
          print(error);
        },
        onPageError: (page, error) {
          print('$page: ${error.toString()}');
        },
        onViewCreated: (PDFViewController vc) {
          pdfViewController = vc;
        },
        onPageChanged: (int page, int total) {
          print('page change: $page/$total');
        },
      ),
    );
  }
}
```

이 예시에서는 pdfPath 매개변수를 가지는 MyPdfViewer라는 새 위젯을 생성했습니다. 이 매개변수는 프로젝트 자산에 추가한 PDF 파일의 경로를 지정합니다.

<div class="content-ad"></div>

우리는 flutter_pdfview 패키지에서 PDFView 위젯을 사용하여 PDF를 표시했습니다. 이 위젯의 여러 속성을 설정했는데, 예를 들어 autoSpacing, enableSwipe, swipeHorizontal 등을 설정하여 PDF가 어떻게 표시되는지 제어했습니다.

또한 onError, onPageError, onViewCreated, onPageChanged 이벤트를 위한 여러 콜백 함수도 설정했습니다. 이러한 함수들은 PDF를 로딩하거나 표시하는 동안 오류가 발생할 때, 페이지별 오류가 발생할 때, PDF 컨트롤러가 생성될 때, 사용자가 PDF의 현재 페이지를 변경할 때와 같은 각종 이벤트 발생 시 호출됩니다.

# 앱에서 PDF 뷰어 사용하기

이제 MyPdfViewer 위젯을 생성했으니, 앱에서 다른 화면으로부터 해당 위젯으로 이동하여 사용할 수 있습니다. 이를 수행하는 방법의 예시는 다음과 같습니다:

<div class="content-ad"></div>

```js
import 'package:flutter/material.dart';
import 'my_pdf_viewer.dart';
```

```js
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyPdfViewer(pdfPath: 'assets/my_document.pdf'),
                ),
              );
            },
            child: Text('View PDF'),
          ),
        ),
      ),
    );
  }
}
```

이 예제에서는 버튼이 포함된 단일 화면이 있는 새로운 Flutter 앱을 만들었습니다. 사용자가 버튼을 탭하면 MyPdfViewer 화면으로 이동하고 PDF 파일의 경로를 전달합니다. 

# 파일이 Base64인 경우:

<div class="content-ad"></div>

플러터 앱에서 flutter_pdfview 패키지를 사용하여 PDF 파일을 base64 형식으로 표시할 수 있어요.

# flutter_pdfview 패키지 추가하기

먼저, Flutter 프로젝트에 flutter_pdfview 패키지를 추가해야 해요. 이를 위해 pubspec.yaml 파일에 다음 줄을 추가하세요:

```yaml
dependencies:
  flutter_pdfview: ^1.2.5
```

<div class="content-ad"></div>

이 줄을 추가한 후 터미널에서 flutter pub get 명령을 실행하여 패키지를 다운로드하고 설치하세요.

# MyPdfViewer 위젯 생성

다음으로 MyPdfViewer라는 새 위젯을 생성하세요. 이 위젯은 flutter_pdfview 패키지에서 제공하는 PDFView 위젯을 사용하여 PDF 파일을 표시합니다.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
```

<div class="content-ad"></div>

```dart
class MyPdfViewer extends StatefulWidget {
  final String base64Pdf;
  MyPdfViewer({@required this.base64Pdf});
  @override
  _MyPdfViewerState createState() => _MyPdfViewerState();
}
class _MyPdfViewerState extends State<MyPdfViewer> {
  PDFViewController pdfViewController;
  int currentPage = 0;
  int totalPages = 0;
  bool isReady = false;
  String errorMessage = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: Stack(
        children: [
          PDFView(
            filePath: null,
            fitEachPage: true,
            fitPolicy: FitPolicy.BOTH,
            onRender: (_pages) {
              setState(() {
                totalPages = _pages;
              });
            },
            onError: (error) {
              setState(() {
                errorMessage = error.toString();
              });
            },
            onPageError: (page, error) {
              setState(() {
                errorMessage = '$error';
              });
            },
            onViewCreated: (PDFViewController vc) {
              setState(() {
                pdfViewController = vc;
              });
              _loadPdf();
            },
          ),
          errorMessage.isEmpty
              ? !isReady
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
              : Center(
                  child: Text(errorMessage),
                ),
        ],
      ),
    );
  }
  _loadPdf() async {
    try {
      setState(() {
        isReady = false;
      });
      final data = base64Decode(widget.base64Pdf);
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/my_file.pdf');
      await file.writeAsBytes(data);
      setState(() {
        isReady = true;
      });
      await pdfViewController.loadFile(file.path);
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
  }
}
```

위젯은 이전 예제와 매우 유사하지만 몇 가지 차이가 있습니다. 첫째, 일반 파일 경로 대신 base64로 인코딩된 문자열을 인수로 사용합니다. 둘째, _loadPdf() 함수가 수정되어 PDFViewController로 로드하기 전에 디코딩된 데이터를 파일에 작성합니다. 마지막으로, 오류가 발생할 때 PDF를 로드하거나 표시하는 동안 발생한 모든 오류를 표시하는 errorMessage 상태 변수가 추가되었습니다.

# URL에서 파일을 가져오는 경우:

플러터(Flutter)에서 flutter_pdfview 패키지를 사용하여 URL로부터 PDF 파일을 표시할 수 있습니다.


<div class="content-ad"></div>

# flutter_pdfview 패키지 추가하기

먼저, Flutter 프로젝트에 flutter_pdfview 패키지를 추가해야 합니다. 이를 위해 pubspec.yaml 파일에 다음 줄을 추가해주세요:

```js
dependencies:
  flutter_pdfview: ^1.2.5
```

이 줄을 추가한 후 터미널에서 flutter pub get 명령을 실행하여 패키지를 다운로드하고 설치해주세요.

<div class="content-ad"></div>

# MyPdfViewer 위젯 생성

이제 MyPdfViewer라는 새로운 위젯을 생성하세요. 이 위젯은 flutter_pdfview 패키지에서 제공하는 PDFView 위젯을 사용하여 PDF 파일을 표시합니다.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
```

```dart
class MyPdfViewer extends StatefulWidget {
  final String pdfUrl;
  MyPdfViewer({@required this.pdfUrl});
  @override
  _MyPdfViewerState createState() => _MyPdfViewerState();
}
class _MyPdfViewerState extends State<MyPdfViewer> {
  PDFViewController pdfViewController;
  int currentPage = 0;
  int totalPages = 0;
  bool isReady = false;
  String errorMessage = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: Stack(
        children: [
          PDFView(
            filePath: null,
            fitEachPage: true,
            fitPolicy: FitPolicy.BOTH,
            onRender: (_pages) {
              setState(() {
                totalPages = _pages;
              });
            },
            onError: (error) {
              setState(() {
                errorMessage = error.toString();
              });
            },
            onPageError: (page, error) {
              setState(() {
                errorMessage = '$error';
              });
            },
            onViewCreated: (PDFViewController vc) {
              setState(() {
                pdfViewController = vc;
              });
              _loadPdf();
            },
          ),
          errorMessage.isEmpty
              ? !isReady
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
              : Center(
                  child: Text(errorMessage),
                ),
        ],
      ),
    );
  }
  _loadPdf() async {
    try {
      setState(() {
        isReady = false;
      });
      final data = await http.get(Uri.parse(widget.pdfUrl)).then((res) => res.bodyBytes);
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/my_file.pdf');
      await file.writeAsBytes(data);
      setState(() {
        isReady = true;
      });
      await pdfViewController.loadFile(file.path);
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
  }
}
```

<div class="content-ad"></div>

위젯은 이전 예제와 매우 유사하지만 몇 가지 차이가 있습니다. 첫째, 파일 경로나 base64로 인코딩된 문자열 대신 URL을 인수로 사용합니다. 둘째, _loadPdf() 함수가 수정되어 http 패키지를 사용하여 URL에서 PDF를 다운로드하고 파일로 쓴 후 PDFViewController로 로드되도록 변경되었습니다. 마지막으로 PDF를로드하거나 표시하는 동안 발생한 오류를 표시하는 errorMessage 상태 변수가 추가되었습니다.

# 결론

이 튜토리얼에서는 flutter_pdfview 패키지를 사용하여 Flutter 앱에서 PDF를 표시하는 방법을 살펴보았습니다. PDFView 위젯을 사용하는 MyPdfViewer라는 새 위젯을 생성했습니다. 또한이 위젯을 다른 화면에서 이동하여 앱에서 사용하는 방법을 살펴보았습니다.

flutter_pdfview 패키지는 초기 페이지 설정, 줌 레벨 제어, 텍스트 강조 표시 등 PDF 뷰어를 사용자 정의하는 다양한 옵션을 제공합니다. Flutter 앱에서 PDF를 표시해야하는 경우, flutter_pdfview 패키지는 고려할 가치가 있는 좋은 옵션입니다.