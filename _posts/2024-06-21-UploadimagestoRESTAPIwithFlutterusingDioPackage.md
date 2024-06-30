---
title: "Dio 패키지를 사용하여 Flutter에서 REST API에 이미지 업로드하는 방법"
description: ""
coverImage: "/assets/img/2024-06-21-UploadimagestoRESTAPIwithFlutterusingDioPackage_0.png"
date: 2024-06-21 22:44
ogImage:
  url: /assets/img/2024-06-21-UploadimagestoRESTAPIwithFlutterusingDioPackage_0.png
tag: Tech
originalTitle: "Upload images to REST API with Flutter using Dio Package"
link: "https://medium.com/@kashifchandio/upload-images-to-rest-api-with-flutter-using-dio-package-421111389c27"
---

플러터 개발자들로부터 받은 엄청난 반응 뒤에 http 패키지를 사용하여 REST API에 이미지를 업로드하는 방법에 대한 이야기를 공유한 후, 많은 사람들이 dio 패키지를 사용하여 그렇게 하는 데 어려움을 겪는 것을 보았습니다. 초보자들은 일반적으로 사용할 수 있는 코드 스니펫을 찾을 수 있는 자세하고 쉽게 배울 수 있는 자료를 원합니다.  
이 이야기에서는 flutter에서 이미지를 업로드하는 방법에 대해 dio 패키지를 사용하여 작성하겠습니다. 가능한 모든 측면에 대해 설명하기 위해 최선을 다하겠지만, 빠진 부분이 있다고 생각하거나 의겢가 있으면 의겢를 남겨주시고 학습 과정에서 도와주십시오.

우선 dio 패키지를 앱에 추가하는 방법부터 시작해봅시다.

Dio는 다트를위한 강력한 HTTP 클라이언트로서 내 flutter 앱에서 서버에 연결하는 동안 응답의 직렬화 및 역직렬화와 같은 여러 측면에서 도움이 됩니다.

프로젝트 디렉토리 터미널에서 다음 명령을 실행합니다.

<div class="content-ad"></div>

```js
 $ dart pub add dio
```

기기 갤러리나 카메라에서 이미지를 가져 오기 위해 Image Picker 패키지를 사용했어요.

프로젝트 디렉토리 터미널에서 다음 명령어를 실행해주세요:

```js
$ flutter pub add image_picker
```

<div class="content-ad"></div>

여기 갤러리에서 이미지를 가져 오는 코드입니다.

```js
Future<File> getImage() async {
  final ImagePicker _picker = ImagePicker();
  // 이미지 선택
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  // XFile을 파일로 변환
  File file = File(image!.path);
  // print(‘이미지 선택됨');
  return file;
}
```

이제 갤러리에서 이미지를 선택했습니다. 다음은 MultipartRequest를 수행 할 dart 파일에서 dio 패키지를 가져 오는 방법입니다.

```js
import "package:dio/dio.dart";
```

<div class="content-ad"></div>

그럼 REST API에 전송할 이미지를 포함하는 fromMap이라는 이름의 이름이 지정된 생성자를 사용하여 FormData 객체를 만들어보겠습니다.

```js
var formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(empFace.path, filename: empCode),
      });
```

여기서 'file' 키를 사용하여 파일을 Map에 포함했습니다. 이는 서버로 보낼 FormData 객체를 반환하며, 우리는 이 객체를 사용하여 서버로 전송할 것입니다. 카메라 이미지의 파일을 사용하여 MultipartFile을 생성하고, 이를 인터넷을 통해 전송할 수 있습니다.

마지막으로 dio를 사용하여 REST API에 요청을 보내보세요:

<div class="content-ad"></div>

```js
최종 응답 = await Dio().post(
        '당신의 API URL',
        data: formData,
      );
```

우리는 formData를 post 메소드에 전달했고, 자동으로 contentType을 처리해줄 것입니다. 일반적으로 서버로 이미지를 보낼 때 form-data 헤더를 사용합니다.:

```js
headers: {
    'Content-Type': 'multipart/form-data'
  },
```

dio를 사용하면 헤더에서 content-type을 명시적으로 지정할 필요가 없습니다.

<div class="content-ad"></div>

여기에서 시나리오와 사용 사례를 더 잘 이해하기 위한 완전한 코드입니다:

```js
Future<bool> registerEmployeeFace(
      {required File empFace, required String empCode}) async {
    final url =
        '내 API URL';
    try {
      var formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(empFace.path, filename: empCode),
      });
      final response = await Dio().post(
        url,
        data: formData,
      );
      if (response.statusCode == 200) {
        var map = response.data as Map;
        print('success');
        if (map['status'] == 'Successfully registered') {
          return true;
        } else {
          return false;
        }
      } else {
        // BotToast는 pub.dev에서 사용 가능한 토스트 패키지입니다.
        BotToast.showText(text: '에러');
        return false;
      }
    } on DioError catch (error) {
      log(error.message);
      throw YourException(error);
    } catch (_) {
      log(_.toString());
      throw '문제가 발생했습니다';
    }
  }
```

초보자들도 이 요청을 쉽게 수행하고 복잡한 API를 빠르게 통합할 수 있기를 바랍니다. 더 많은 Github를 위해

<div class="content-ad"></div>

만약 도움이 되었다면 좋아요 버튼을 눌러주시고 친구들과 공유해주세요.
