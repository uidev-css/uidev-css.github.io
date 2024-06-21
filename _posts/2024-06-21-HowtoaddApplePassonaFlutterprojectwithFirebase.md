---
title: "Firebase로 Flutter 프로젝트에 애플 패스 추가하는 방법"
description: ""
coverImage: "/assets/img/2024-06-21-HowtoaddApplePassonaFlutterprojectwithFirebase_0.png"
date: 2024-06-21 22:23
ogImage: 
  url: /assets/img/2024-06-21-HowtoaddApplePassonaFlutterprojectwithFirebase_0.png
tag: Tech
originalTitle: "How to add Apple Pass on a Flutter project with Firebase"
link: "https://medium.com/@giordanolucaa.98/how-to-add-apple-pass-on-a-flutter-project-with-firebase-fa730c5676b0"
---


<img src="/assets/img/2024-06-21-HowtoaddApplePassonaFlutterprojectwithFirebase_0.png" />

이 글에서는 Firebase 함수를 사용하여 Flutter 프로젝트에 Apple Pass를 통합하는 방법을 설명하겠습니다.

저는 백엔드 개발과 Apple Pass 디자인에 대한 전문가가 아니기 때문에 정보가 부족하거나 부정확할 수 있습니다. 더 자세한 내용은 문서를 참조해주세요.

# 단계 1: 인증서 준비하기

<div class="content-ad"></div>

가장 먼저 할 일은 인증서를 준비하는 것입니다. 세 가지 요소를 다운로드해야 합니다:

- 서명자 인증서 (개발자)
- 서명자 인증서 키 (개발자)
- WWDR (애플 월드와이드 개발자 관계) G4 인증서

- 새로운 패스 유형 식별자(직접 링크)를 생성하고 설명 및 역도메인 식별자(“pass.”로 시작)를 제공하세요. pass.json 파일 또는 프로퍼티 값으로 이 식별자를 passTypeIdentifier에 넣어야 합니다.
- Keychain Access를 열고 파일 `인증서 보조도구` `인증서 요청`으로 이동하여 양식을 작성한 후 “디스크에 저장” 옵션을 선택하고 계속하세요. 새 파일이 생성됩니다.
- 패스 유형 식별자 목록(필터링)에서 새 패스 ID를 클릭하여 편집합니다.
- “인증서 생성”을 클릭하세요. 패스 인증서 이름을 입력하고 Keychain Access로 방금 생성된 파일을 업로드하세요. 그런 다음 인증서를 다운로드하고 두 번 클릭하여(Keychain Access에 추가하는) 열어주세요.
- Keychain Access로 돌아가서 “패스 유형ID: xxxx”를 마우스 오른쪽 버튼으로 클릭하고 “패스 유형ID: xxxx”를 내보내세요. 마음에 드는 곳에 저장하고(.p12 확장자와 함께) 암호를 생성해야 합니다. 이것은 나중에 필요할 것입니다.
- 이 .p12 파일을 저장한 위치에서 터미널을 열고 다음 명령어를 입력하세요:

```js
# -passin용 <your-password>는 P12의 비밀번호입니다.
$ openssl pkcs12 -in <cert-name>.p12 -clcerts -nokeys -out signerCert.pem -passin pass:<your-password>

# -passin용 <your-password>는 P12의 비밀번호입니다. <secret-passphrase>는 passkit-generator에 전달할 privateKey를 복호화하는 데 사용할 암호입니다.
$ openssl pkcs12 -in <cert-name>.p12 -nocerts -out signerKey.pem -passin pass:<your-password> -passout pass:<secret-passphrase>
```

<div class="content-ad"></div>

에러가 발생하면 명령 끝에 "-legacy"를 추가하거나 이 링크를 따르세요.

암호구절을 저장해두세요. 나중에 필요할 겁니다.

필요한 3개 인증서 중 2개가 생성되었습니다.

마지막 인증서를 위해서는 이 링크를 열어보세요.

<div class="content-ad"></div>

# 단계 2: 서버 측 준비

우리가 말했듯이, 우리는 Firebase 함수를 사용하여 우리의 패스 생성기를 호스팅할 것입니다.

주의: 이 작업을 위해 Blaze 요금제가 필요합니다 (무료가 아닌 "사용한 만큼 지불" 형태입니다). Firebase를 사용하지 않으려면 우리가 만들 백엔드를 원하는 곳에 호스팅하시면 됩니다.

우리의 패스를 생성하기 위해 passkit-generator를 사용할 것입니다.

<div class="content-ad"></div>

시작해봅시다:

- 터미널에서 Firebase CLI를 설치하세요.
- 새 Firebase 프로젝트 생성하기
- "pass-generator-be"라는 폴더를 만들고 여기서 터미널을 열고 다음을 실행하세요.

```js
flutter login
```

- 명령어를 입력하세요.

<div class="content-ad"></div>

```js
firebase init
```

“Functions: Configure a Cloud Functions directory and its files”을 선택하고 방금 만든 프로젝트를 선택하세요. 그런 다음 "JavaScript"를 선택하고 "Y"로 모든 질문에 답하십시오. 단, "가능한 버그를 잡고 스타일을 강제하기 위해 ESLint를 사용하시겠습니까?"에서는 (배포할 때 Lint 예외가 발생하지 않도록 하기 위해) "N"을 선택하시면 됩니다. 이것이 괜찮다면 그대로 두셔도 됩니다.

- 이제 코드 에디터와 함께 생성된 "functions" 폴더를 열어보세요.
- 프로젝트 내부의 터미널을 열고 아래 의존성을 설치하세요.

```js
yarn add passkit-generator
yarn add path
yarn add file-system
```

<div class="content-ad"></div>

- 프로젝트 내부에 "certs" 폴더를 만들어서 우리가 생성한 3개의 인증서를 붙여넣으세요.
- 또한 "model" 폴더를 만들어서 패스 모델을 넣을 것입니다.

간단한 패스 모델을 사용할 예정이며, 레이블과 이미지만 포함됩니다. 다른 모델에 관심이 있다면, 이 링크를 따라가서 사용자 정의 JSON 파일을 만들어보세요. 여기서 샘플을 찾을 수 있습니다.

- 패스 폴더를 준비했다면 (예: "auditor.pass", JSON 파일과 이미지가 포함된), 이를 프로젝트 내부의 "model" 폴더에 복사하세요.

프로젝트 구조는 다음과 같이 보일 것입니다:

<div class="content-ad"></div>


![image](/assets/img/2024-06-21-HowtoaddApplePassonaFlutterprojectwithFirebase_1.png)

My pass.json file is:

Warnings:

- passTypeIdentifier: has to be the same as the one we registered at the beginning
- teamIdentifier: has to be your team identifier


<div class="content-ad"></div>

"index.js"로 이동해보세요:

- 의존성 가져오기

```js
const functions = require("firebase-functions");
const { PKPass } = require("passkit-generator");
var fs = require("file-system");
var path = require("path");
```

PKPass를 사용하여 패스를 생성하세요

<div class="content-ad"></div>

```js
PKPass.from({
        model: "./model/auditor.pass",
        certificates: {
            wwdr: fs.readFileSync("./certs/wwdr.pem"),
            signerCert: fs.readFileSync("./certs/signerCert.pem"),
            signerKey: fs.readFileSync("./certs/signerKey.pem"),
            signerKeyPassphrase: "YOUR PASSPHRASE"
        }

    },{})
```

모두 함께

흐름은 매우 간단합니다:

- 새 요청이 도착하면 패스가 생성됩니다
- 그런 다음 요청 내의 정보를 사용하여 패스를 채웁니다
- 패스가 클라이언트로 되돌아갑니다

<div class="content-ad"></div>

알림: 주석 처리된 “fs.writeFileSync(“auditor.pkpass”, bufferData)”는 개발 중에 생성된 .pkpass 파일을 프로젝트 폴더에 저장하는 데 유용합니다. 에뮬레이터에서 결과를 확인하기 쉽게 할 수 있습니다.

백엔드를 로컬에서 실행하려면 다음 명령어를 입력하세요.

```js
firebase emulators:start    
```

그러면 “http://127.0.0.1:5001/XXXX/us-central1/pass”와 같은 URL을 제공해줄 겁니다.

<div class="content-ad"></div>

로컬 개발을 마치고 프로덕션 환경으로 이동하려면 다음 명령어를 사용하여 서버를 배포하세요.

```js
firebase deploy
```

# 단계 3: 플러터 앱

우리 앱에서 할 일이 매우 적습니다.

<div class="content-ad"></div>

- 먼저 flutter_wallet_card와 dio(또는 다른 http 클라이언트)를 가져와주세요.
- 제안된 이미지를 사용하여 "Apple Wallet에 추가" 기능을 제공해주세요.
- onTap 동작을 처리하는 함수를 작성해주세요.

그러고 나서 XCode로 iOS 모듈을 열고 Runner 아래에서 'Signing & Capabilities'를 클릭한 후 "+ Capability"를 클릭해주세요. 마지막으로 "특정 종류의 패스 허용"을 선택하고 처음에 생성한 패스를 선택해주세요.

![이미지](/assets/img/2024-06-21-HowtoaddApplePassonaFlutterprojectwithFirebase_2.png)

그리고...... 이게 전부에요!

<div class="content-ad"></div>

당신의 앱은 이제 "Apple Wallet에 추가" 기능을 구현하고 있습니다.

![이미지](https://miro.medium.com/v2/resize:fit:600/1*CSrT10rYaB124vi-MuXDFw.gif)