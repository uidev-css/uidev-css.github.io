---
title: "실시간 머신 러닝 Flutter 카메라 사용 방법"
description: ""
coverImage: "/assets/img/2024-06-22-Real-TimeMachineLearningWithFlutterCamera_0.png"
date: 2024-06-22 04:03
ogImage: 
  url: /assets/img/2024-06-22-Real-TimeMachineLearningWithFlutterCamera_0.png
tag: Tech
originalTitle: "Real-Time Machine Learning With Flutter Camera"
link: "https://medium.com/kbtg-life/real-time-machine-learning-with-flutter-camera-bbcf1b5c3193"
---


내 최근 과제는 플러터를 사용하여 실시간 기계 학습을 수행하는 것이었는데, 많은 문제에 직면했습니다. 약 한 달 동안 이 일에 매달려 작업한 후에, 앞으로 나 자신을 위해 블로그를 써야겠다고 결정했습니다. 비슷한 일을 해야 하는 사람을 위해 쓰는 것도 포함해서요. 이 기사가 다른 누군가에게 시간을 아낄 수 있도록 한다면 좋겠어요. 그래서 그들이 구현 방법을 찾고 찾아다니지 않아도 되도록요. 전체 이야기를 전할 테니까요: 첫 번째 기계 학습 시도부터 모든 경우에 작동할 것으로 희망하는 최종 버전까지 말이에요.

![image](/assets/img/2024-06-22-Real-TimeMachineLearningWithFlutterCamera_0.png)

나의 작업은 플러터에서 얼굴 활성화 감지를 구현하는 것이었어요. 이 프로세스는 셀카의 활동성을 확인하는 것을 목적으로 합니다. 예전에는 시민 신분증을 갖고 실제 은행 지점에서 은행 계좌를 개설하기 위해 은행 직원과의 대면이 필요했습니다. 이제 거의 아무도 은행에 이를 정도로 가지 않아요. 대면 회의는 eKYC 프로세스로 대체되었어요. 디지털 시스템은 당신의 얼굴을 ID와 비교하여 같은 사람인지 확인합니다. 한편, 우리는 우리에게 보내는 얼굴 이미지가 정통한 얼굴인지, 멈춘 사진인지 확인해야 해요. 그래서 이를 감지하기 위해 기기에 ML이 필요합니다. 이미지를 가져와 ML에 보내고, 이미지를 확인한 후 플러터로 다시 되돌려주어야 합니다.

# 첫 번째 버전

<div class="content-ad"></div>

셀피를 찍기 위해 타이머를 1초로 설정하여 사진을 찍었고, 그 사진들을 Uint8List, 이진 형식으로 변환한 후 Flutter로 전송해 ML에 공급하기 위해 이미지를 재구축했습니다. 이 첫 번째 버전은 고급 기기에서만 잘 작동했습니다. 사진을 찍으면 시스템이 Flutter로 사진을 전송하는 데 약 300~400ms가 소요되고, 다음 사진이 찍히기 전에 약 600ms가 남았습니다. 내 iPhone 11 Pro Max는 약 300~400ms가 걸렸는데, iPhone X는 약 1,200ms가 걸려 실시간으로 간주하기에는 충분히 빨랐습니다. 게다가 iOS는 셀피를 찍는 동안 새터음을 냅니다. 이로 인해 사용자가 얼굴 확인을 할 때 좋지 않은 경험을 하게 됩니다. 그럼에도 불구하고, 이 버전은 얼굴 라이브니스 기능을 테스트할 테스터에게 전달하기에 적합합니다.

# 두 번째 버전

일련의 사진을 찍는 것은 충분히 빠르지 않았기 때문에 이미지 스트림을 가져와 ML에 공급하기로 결정했습니다.

Flutter 카메라(https://pub.dev/packages/camera)에서 startImageStream라는 함수가 Flutter로 이미지를 스트리밍하는 기능이 있습니다.

<div class="content-ad"></div>

```js
controller.startImageStream((cameraImage) async {
   // 이미지를 ML에 제공
});
```

여기에는 CameraImage가 반환됩니다. ML 이미지에 대한 경우 대부분의 사람들은 이미 CameraImage를 수용하는 플러터용 Firebase ML을 사용할 것으로 예상됩니다. 그것을 ML에 입력하여 결과를 얻어 UI에 표시할 수 있습니다.

일부 경우에는 귀하의 요구 사항이 Firebase ML과 일치하지 않아 직접 모델을 구현해야 할 수도 있습니다. 물론 대부분의 ML 모델은 네이티브(스위프트 또는 코틀린)만 지원합니다. 즉, 플러터에서 카메라 이미지를 네이티브로 보내어 네이티브에서 작업을 수행하고 결과를 다시 보내야 합니다. 여기에 문제가 있습니다.

대부분의 SDK는 RGB 형식 (JPG 또는 PNG)을 제공해야 합니다. 대부분의 경우 JPG를 사용합니다. CameraImage도 JPG를 지원하지만 Android에서만 가능합니다. iOS에서는 JPG를 지원하지 않는다는 것을 알게 되었습니다. Android에서 JPG 이미지를 수신하도록 설정하기 시작했습니다. iOS의 경우 카메라 문서를 읽어보니 두 가지 형식을 지원한다는 것을 알았습니다: YUV420과 BGRA8888. 저는 BGRA8888을 선택했습니다. 이미지와 같은 형식이기 때문에 다른 형식은 비디오 형식과 더 유사합니다.

<div class="content-ad"></div>


<img src="/assets/img/2024-06-22-Real-TimeMachineLearningWithFlutterCamera_1.png" />

Android는 이미 JPG이기 때문에 어떠한 문제없이 동일한 기계 학습 모델에 공급할 수 있습니다. iOS는 두 형식을 JPG로 변환하는 방법을 찾아야 했습니다. 조사를 하다가 이를 발견했습니다.

이 지침에 따르면 JPG 이미지를 얻을 수 있었지만, 여전히 프레임이 끊기는 문제가 있어 만족스럽지 않았습니다. 지속적으로 공급해야 하니 계속 이미지를 변환해야 했죠. 위의 기본만 사용하면 하나의 이미지에는 문제가 없지만, 실시간 얼굴 라이브니스에는 문제가 있습니다.

이 문제를 해결하기 위해 저는 Flutter에서 스로틀링 기능을 추가했습니다. Flutter에서 보낸 각 카메라 이미지에 대해, 500ms마다 이미지를 한 번만 변환하는 방식으로 구현했습니다. Flutter는 이미지를 20~30ms마다 반환합니다. 시행착오 끝에, 30ms와 500ms가 사용 사례에 큰 차이가 없음을 느꼈습니다. 화면 중앙에 얼굴이 고정되어 움직임이 빠르지 않기 때문에 사용자는 지연을 느끼지 않을 것입니다.


<div class="content-ad"></div>

iOS에서 벽에 부딪혀 안달이 났을 때, 다른 방향으로 가기로 결정해서 Android로 전환하기로 했습니다. 적어도 한 플랫폼에서 잘 되게 만들어놓고, 나중에 나머지에 집중할 수 있게 하기 위해서였죠. Android에서는 JPG 형식이 잘 작동하며 성능도 꽤 좋았어요. 하지만 Kotlin으로 보낸 이미지들이 90도 회전된 채로 도착하는 문제가 있었습니다. 솔직히 이해가 안 가요. Flutter에서 왜 90도 회전된 이미지를 다시 보내야 할까요? 😢 그래도 전 세계 사람들이 사용하는 라이브러리니까 어떤 이유가 있겠죠. 나는 Kotlin 코드를 사용해서 비트맵을 만들고 이미지를 270도 회전하여 Matrix에 넣은 후 ML로 전달하기로 결정했어요. 중간 규모의 Android는 여전히 이미지를 만들고 회전시키고 바이너리로 변환하는 전체 프로세스가 많은 전력을 소비하여 조금 느렸어요. 하지만 여전히 사진을 찍고 ML에 보내는 것보다는 낫다고 생각했죠. 고급 Android는 잘 작동했지만 중간 규모는 약간 느렀고, 저급 Android는 사용할 수 없었습니다. 그래도 당시에는 충분했어요.

iOS로 돌아와서, Flutter에서 스레딩 아이디어를 생각해냈습니다. 이 기사의 지침을 따라했죠.

보통 Flutter에서는 대부분 await 함수가 스레드를 차단하지 않기 때문에 스레딩이 거의 필요하지 않죠. 그러나 iOS에서는 스레드를 생성하고 지속적으로 복잡한 작업을 스레드에 넣어야 하는 경우가 많아요.

Dart에서 처음으로 스레딩을 사용하기로 결정했습니다. 상기한 기사를 따라하니 decodeImage의 샘플을 얻고 Flutter의 Image 라이브러리를 사용해 BGRA를 RGB로 변환했습니다.

<div class="content-ad"></div>

와우! 결과가 완전히 다르게 나왔네요. 내 iPhone X는, BTS가 말하는 대로, 바터처럼 부드러웠어요 😄

이제 두 번째 버전이 중상 및 고상위 iOS 및 안드로이드를 지원할 수 있다는 것을 증명했습니다. 더 많은 사용자들로 시험해보는 시간이 왔어요.

더 넓은 테스트 후, 중요한 문제를 발견했습니다: ImageFormatGroup.jpeg 내의 JPG 플래그가 일부 기기에서 지원되지 않아요!!!

이 오류를 만났습니다: GetYUVPlaneInfo: 잘못된 형식이 전달되었어요: 0x21

<div class="content-ad"></div>

20개의 안드로이드 디바이스 중에서 이미지를 JPG로 스트리밍하려고 시도할 때 Xiaomi Note 8만 충돌했습니다. 이 문제가 이 모델에만 해당되었는지 또는 이 기능을 프로덕션 환경에 론칭했을 때 이 문제가 발생할 수 있는 다른 디바이스가 있는지 알 수 없습니다.

조사를 거친 결과 ImageFormatGroup.yuv420로 변경하면 문제가 발생하지 않는 것으로 보입니다. 제가 위험을 감수하고 기능을 프로덕션에 푸시하고 싶지 않아서 Flutter의 기본 형식인 YUV420로 결정했습니다. 조사를 통해 인터넷에서 이 코드를 얻었습니다. 이를 통해 CameraImage를 Android로 전달하여 이미지를 생성할 수 있었습니다.

```js
List<int> strides = Int32List(image.planes.length * 2);
int index = 0;
List<Uint8List> data = image.planes.map((plane) {
   strides[index] = (plane.bytesPerRow);
   index++;
   strides[index] = (plane.bytesPerPixel)!;
   index++;
   return plane.bytes;
}).toList();
await _channel.invokeMethod<Uint8List>("checkLiveness", {
  'platforms': data,
  'height': image.height,
  'width': image.width,
  'strides': strides
});
```

안드로이드에서는 YUV를 JPG로 변환하는 코드를 이 페이지에서 가져왔습니다.

<div class="content-ad"></div>

구현된 후에도 기능이 잘 작동했어요, 아직은 Android에서 JPG 문제를 해결한 것이 전부라서 조금 느리긴 했지만요.

이제 사용자 경험을 개선하기 위해 성능을 향상시키는 시간이에요.

Kotlin 코루틴을 연구해서 스레딩 작업을 수행하고, Kotlin 코드에 적용해서 프로세스를 더 부드럽게 만들었어요. 결과는 매우 긍정적이었고 Android가 매우 부드럽게 작동하고 모든 단계에서 잘 작동했어요. 심지어 가장 낮은 단계도 여전히 부드러워졌어요. 제 Oppo a3s에서도 레이븐스(?)가 약간 끊김 없이 작동해요.

# 최종 버전

<div class="content-ad"></div>

이번에는 저렴한 iOS 기기인 iPhone 6s, 6s Plus, 그리고 7를 조사했어요.

중간급 기기에는 Isolate가 버벅거리지 않고 잘 작동하는 것을 발견했지만, 저급 기기에는 그렇지 않았어요. Isolate가 작업을 완료하는 데 약 1-1.5초가 걸리고, 라이브니스 감지에는 또 1.5초가 소요되었는데, 이는 느린 디바이스에서는 사용자가 처리하기에 너무 많은 시간이 걸렸어요. 그래서 저는 네이티브로 전환하기로 결정했고, 그곳의 성능은 제 기대를 뛰어넘었어요. 1.5초에서 약 0.01초로 성능이 향상되었답니다!!! 제가 이미지 변환 코드를 기사 끝에 저장소로 변환하는 내용을 공유했어요. 여기 이미지를 변환하는 샘플 코드가 있어요.

```js
private func bytesToPixelBuffer(width: Int, height: Int, baseAddress: UnsafeMutableRawPointer, bytesPerRow: Int) -> CVBuffer? {
   var dstPixelBuffer: CVBuffer?
   CVPixelBufferCreateWithBytes(kCFAllocatorDefault, width, height,    kCVPixelFormatType_32BGRA, baseAddress, bytesPerRow,
   nil, nil, nil, &dstPixelBuffer)
   return dstPixelBuffer ?? nil
}
private func createImage(from pixelBuffer: CVPixelBuffer) -> CGImage? {
   var cgImage: CGImage?
   VTCreateCGImageFromCVPixelBuffer(pixelBuffer, options: nil,    imageOut: &cgImage)
   return cgImage
}
private func createUIImageFromRawData(data: Data, imageWidth: Int, imageHeight: Int, bytes: Int) -> UIImage? {
   data.withUnsafeBytes { rawBufferPointer in
      let rawPtr = rawBufferPointer.baseAddress!
      let address = UnsafeMutableRawPointer(mutating:rawPtr)
      guard let pxBuffer = bytesToPixelBuffer(width: imageWidth, height: imageHeight, baseAddress: address, bytesPerRow: bytes), let cgiImage = createImage(from: pxBuffer) else {
      return nil
   }
   return UIImage(cgImage: cgiImage)
}
```

마지막 문제와 마지막 큰 장벽: 플러터 이미지 스트림이었습니다.

<div class="content-ad"></div>

Flutter 프로젝트를 생성해보고, Flutter 카메라를 구현하여 이미지 스트림을 열어 어떤 작업도 수행하지 않았어요. 그런데 여전히 저사양 아이폰에서는 렉이 있었어요. 이미지 스트림을 끄면 미리보기가 다른 아이폰처럼 부드럽게 나타났어요. 그렇다면, 이미지 스트림에서 이미지를 얻지 않고 살아있는지 감지하는 방법은 무엇일까요?

결국, 이 문제를 해결하는 방법을 고민하다가 한 가지 방법을 찾아냈어요: 이미지 스트림을 시작한 후 50ms 후에 끄는 거예요. 면밀히 관찰해보면, Flutter 앱이 50ms 동안 렉이 발생하는 것 같지만 대부분의 경우에는 사용자가 느끼지 못할 거예요. 그 50ms 동안, 카메라 이미지에서 1~2개의 이미지를 얻고 이를 기계 학습에 사용했어요.

이렇게 한 후에, 작은 렉이 있더라도 iPhone 7 Plus로 얼굴 실시간 감지를 수행할 수 있었어요. iPhone 6s 및 6s Plus의 경우에는 훨씬 개선되었어요. 결과는 아래에서 확인할 수 있어요.

## 성능 검사

<div class="content-ad"></div>

iPhone 11 Pro Max - CPU 53%, Memory 190MB, image returns every 20-40 ms

![Image](/assets/img/2024-06-22-Real-TimeMachineLearningWithFlutterCamera_2.png)

iPhone 6s - CPU 118%, Memory 160MB, image returns every 20-30 ms

![Image](/assets/img/2024-06-22-Real-TimeMachineLearningWithFlutterCamera_3.png)

<div class="content-ad"></div>

iPhone 6s Plus - CPU 138%, Memory 187 MB, 이미지는 20-50 ms마다 반환됩니다.

![이미지](/assets/img/2024-06-22-Real-TimeMachineLearningWithFlutterCamera_4.png)

카메라 스트림 없는 iPhone 6s Plus에서는 카메라 미리보기만 열면 CPU 소비량이 46%입니다.

![이미지](/assets/img/2024-06-22-Real-TimeMachineLearningWithFlutterCamera_5.png)

<div class="content-ad"></div>

아이폰 6s Plus의 스트림을 켜고 끕니다. 배터리 수명이 50%에서 70% 사이로 오르내리고 있어요.

![이미지](/assets/img/2024-06-22-Real-TimeMachineLearningWithFlutterCamera_6.png)

안드로이드로는 저의 저가형 기기, 2018년 출시된 Oppo A3s를 사용 중입니다. 안드로이드 버전은 8.1.0이고 RAM은 2GB입니다. iPhone 6s보다 더 좋은 성능을 보여주고 있어요. 이미지 스트림은 항상 열려 있고 CPU 소비량은 14% 정도, RAM 소비량은 약 320MB 정도입니다.

![이미지](/assets/img/2024-06-22-Real-TimeMachineLearningWithFlutterCamera_7.png)

<div class="content-ad"></div>

한편, 네이티브 카메라를 사용하는 iPhone 6s Plus는 CPU 소비가 단 57%, 메모리는 39.1MB만 사용해요. 

![image](/assets/img/2024-06-22-Real-TimeMachineLearningWithFlutterCamera_8.png)

모든 중간급 iOS 및 모든 Android에서 모두 잘 작동하고 있어요. 그러나 제가 위에 공유한 코드에서 UIImage로 남은 문제가 하나 있어요. 라이브니스가 반환한 이미지를 사용해야 할 때, Thread 1: EXC_BAD_ACCESS 오류가 발생했어요.

![image](/assets/img/2024-06-22-Real-TimeMachineLearningWithFlutterCamera_9.png)

<div class="content-ad"></div>

CGDataProvider_BufferIsNotBigEnough 에 대한 해결 방법을 찾아보려고 구글링을 해봤지만, 제 문제와 관련된 내용을 찾을 수 없었어요. 어떤 사람들은 이미지가 너무 크거나 핸드폰이 오래되었다고 언급했더라구요! 저의 가장 빠른 장치인 iPhone 11 Pro Max 도 문제가 있었기 때문에 그것이 결코 아니었어요. 작은 이미지를 공급하고 더 천천히 이미지를 라이브네스에 공급하는 여러 방법을 시도해봤지만, 아무 것도 성공하지 못했어요. 제 마음은 완전히 공허했죠. 이게 뭐지? 라이브네스인가, 제 코드가 문제인가? 여러 실험과 오류를 통해 몇 일을 조사한 끝에, 마침내 라이브네스가 성공했을 때 SDK에 공급한 이미지가 값을 참조하는 형식으로 반환되었다는 것을 깨달았어요. 그 이미지는 값이 아닌 참조 유형으로 전달되었다는 걸 알게 되었죠. 그러면서 참조 타입을 값 타입으로 복사하는 방법을 찾다가, PixelBuffer에 대한 깊은 복사 함수를 찾았어요. 이를 프로젝트에 추가하고, 메모리 액세스 문제가 마침내 해결되었어요. 모든 게 이제 괜찮아졌어요. 휴..

# 최종 결론!!

![image](/assets/img/2024-06-22-Real-TimeMachineLearningWithFlutterCamera_10.png)

플러터는 개발 시간을 줄여주는 것이 목적이에요. 만약 이 목적을 제대로 이루지 못한다면, 우리는 그냥 네이티브 방식으로 할 수 있어요. 큰 문제없죠, 모든 문제를 해결하는 마법같은 해결책은 아니잖아요 😁 Flutter에 투자한 시간을 통해 모든 문제를 해결하는 대신 네이티브 방식으로 해결할 수 있다고 믿어요.

<div class="content-ad"></div>

업데이트: 2024년 12월 15일

Flutter 방식 대신 네이티브 방식으로 작동하도록 코드를 수정하고 다시 작성했습니다. 자세한 내용은 아래 Medium에서 확인할 수 있어요.

더 간단한 방법을 사용하려는 사람들을 위해 이 기사를 계속 따라가실 수 있어요.

여기에는 대본 샘플 프로젝트가 있어요: 최종 버전에서 배운 모든 것을 구현했습니다. Flutter로 계속 작업하고 싶은 사람은 이것을 확인하세요.

<div class="content-ad"></div>

이 비디오는 플러터 스트림을 사용하여 성능 비교를 보여주는 것입니다.

앱 내부 얼굴 라이브니스 감지와 모든 것을 구현한 후 최종 결과는 여기 있어요.

# 요약

플러터 카메라 이미지는 저렴한 기기에 적합하지 않습니다. 왜냐하면 그것은 지속적으로 이미지를 플러터로 돌려보냅니다. 플러터 카메라에 반환할 수 있는 프레임 속도의 매개변수가 있다면 많은 도움이 될 것이라고 생각합니다. 쓸모없는 오버헤드 이미지를 처리해야 하는 상황이었기 때문에 쓰로틀링을 해도 플러터는 여전히 이미지를 처리해야 했습니다. 20-30ms 마다 이미지를 가져오는 대신 대신 200ms 마다 이미지를 가져올 수 있다면, 작업이 90% 줄어들 것이라고 생각합니다!

<div class="content-ad"></div>

요청이 지금까지 2년 넘게 열려 있어요.

아마 곧 일어날 것 같진 않으니까, 일단 네이티브로 진행해보자. 이 카메라에 기능을 추가하기 위해 MR을 오픈하고 싶지만 할 수 있는 기회가 있을지 보자구.

자신의 프로젝트에 얼굴 라이브니스를 구현하고 싶은 사람이 있으면 플러터나 네이티브로, KBTG나 저에게 연락해주세요. 저는 여러분의 요청을 저희 팀에 전달해 드릴게요. 저희의 KBTG 얼굴 라이브니스는 iBeta가 테스트한 ISO 30107-3를 통과했습니다.

![이미지](/assets/img/2024-06-22-Real-TimeMachineLearningWithFlutterCamera_11.png)

<div class="content-ad"></div>

참고 웹사이트:

이와 같은 이야기를 더 읽고 싶나요? 또는 최신 기술 트렌드를 따라가고 싶나요? 더 많은 정보를 원하시면 www.kbtg.tech에서 확인해보세요.