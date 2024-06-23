---
title: "Keystore를 사용하여 Flutter 앱 서명하는 방법"
description: ""
coverImage: "/assets/img/2024-06-23-SigningyourflutterappwithKeystore_0.png"
date: 2024-06-23 14:57
ogImage: 
  url: /assets/img/2024-06-23-SigningyourflutterappwithKeystore_0.png
tag: Tech
originalTitle: "Signing your flutter app with Keystore"
link: "https://medium.com/@surajbhandari5502/signing-your-flutter-app-with-keystore-f425a7b31356"
---


파이널?에서 플러터는 기본적으로 앱이 디버그 키스토어로 서명됩니다. 이를 디버그 키스토어라고 합니다. 이 키스토어는 기본적으로 다음 위치에 있습니다.

C:\Users\LENOVO\.android\debug.keystore

기본/default SHA-1 및 다른 서명을 (C:\Users\LENOVO\.android\debug.keystore)에서 가져오려면

- 터미널 또는 명령 프롬프트를 엽니다.
- Flutter 프로젝트의 `android` 디렉터리로 이동합니다.
- 다음 명령을 실행하여 SHA-1 지문을 가져옵니다:
```bash
…..\android` ./gradlew signingReport
```

<div class="content-ad"></div>

위의 코드에서 SHA-1과 다른 지문을 찾아보세요.

![이미지](/assets/img/2024-06-23-SigningyourflutterappwithKeystore_0.png)

이 SHA-1 및 다른 키는 PC마다 항상 같습니다. 이 서명 키는 주로 디버깅 용도로만 사용할 것입니다.

예를 들어 Firebase에서 Google 기능에 로그인하기 위해 SHA-1 키가 필요한 경우가 있습니다. 앱이 개발 중인 동안 기본 서명을 Firebase에 추가할 수 있습니다. 동일한 앱에 여러 명의 개발자가 있을 수 있기 때문에 모든 앱이 Firebase 기능에 액세스해야 하므로 각 개발자가 생성한 여러 개의 SHA-1 키를 Firebase에 추가해야 합니다.

<div class="content-ad"></div>

# 키스토어의 적절한 관리 및 사용

다음 단계에서는 키스토어를 사용하여 APK에 서명하여 앱을 배포하는 방법 및 기타 여러 용도에 적절하게 논의할 것입니다.

APK에 서명하려면 signingConfigs에서 코드를 작성해야 합니다.

이것이 디버그 APK 및 프로덕션 APK용 app\build.gradle에서 signingConfigs를 설정하는 방법입니다.

<div class="content-ad"></div>

참고: 디버그 APK에 서명할 필요가 없습니다. 그것은 자체적으로 진행되며 아무것도 손대지 않아도 됩니다. 여기서 디버그 APK에 서명하는 것은 학습 목적으로 진행됩니다.

- 자체 디버그용 및 제품용 키스토어(1개씩 총 2개)를 생성하세요.

![image](/assets/img/2024-06-23-SigningyourflutterappwithKeystore_1.png)

키툴(`keytool`) 유틸리티를 사용하여 자바 개발 키트(JDK)에 함께 제공되는 만큼 많은 수의 키스토어를 생성할 수 있습니다.

<div class="content-ad"></div>

a. 터미널이나 명령 프롬프트를 열고 다음 명령을 실행하세요:

```bash
keytool -genkeypair -v -keystore your_keystore_name.keystore -alias your_alias_name -keyalg RSA -keysize 2048 -validity 10000
```

b. 정보 입력:

이름, 조직 및 위치와 같은 정보를 입력하라는 메시지가 표시됩니다. 필수 정보를 입력해주세요.

<div class="content-ad"></div>

c. 비밀번호 설정:
키스토어 및 키 쌍에 대한 비밀번호를 설정하라는 프롬프트가 표시됩니다. 나중에 이 비밀번호가 필요하므로 기억해 두세요.

2. 키스토어 이동:
생성된 키스토어 파일을 프로젝트 디렉토리의 안전하고 접근 가능한 위치로 이동하세요. 보안상의 이유로 프로젝트의 버전 관리 시스템 외부에 보관하는 것이 좋은 관행입니다.

![이미지](/assets/img/2024-06-23-SigningyourflutterappwithKeystore_2.png)

3. key.properties 파일 생성하기:

<div class="content-ad"></div>

안녕하세요! `android` 폴더 안에 `key.properties` 파일을 추가해주세요.

기억해주세요: `storePassword`와 `keyPassword`는 앞에서 입력한 비밀번호와 동일하니 `storePassword`는 항상 `keyPassword`와 동일할 겁니다. 그리고 `keyAlias`는 앞에서 입력한 `your_alias_name`과 동일해야 합니다.

<img src="/assets/img/2024-06-23-SigningyourflutterappwithKeystore_3.png" />

4. app/build.gradle 안의 `signingConfig`를 사용하여 APK에 서명하기

<div class="content-ad"></div>


![이미지1](/assets/img/2024-06-23-SigningyourflutterappwithKeystore_4.png)

![이미지2](/assets/img/2024-06-23-SigningyourflutterappwithKeystore_5.png)

프로덕션 APK의 SHA-1 키를 생성하려면 아래 단계를 따르세요.

1. Keystore 파일 찾기: 먼저, 앱을 위해 생성한 릴리스 keystore 파일을 찾으세요. 이 파일은 일반적으로 .jks 또는 .keystore 확장자를 가지고 있습니다.


<div class="content-ad"></div>

2. SHA-1 키 생성: SHA-1 키를 생성하려면 Java 개발 킷(JDK)과 함께 제공되는 keytool 명령줄 유틸리티를 사용할 수 있습니다. 터미널이나 명령 프롬프트를 열고 keystore 파일이 있는 디렉토리로 이동하세요.

3. keytool 명령 실행: 다음 명령을 사용하여 SHA-1 키를 생성하세요:

```js
keytool -list -v -keystore your_keystore_filename.jks -alias your_alias_name
```

your_keystore_filename.jks를 사용자의 keystore 파일 이름으로, your_alias_name을 keystore를 생성할 때 사용한 별칭으로 대체하세요(별칭을 지정하지 않았다면, 디버그 keystore에는 androiddebugkey를 사용하거나 릴리스 keystore 생성 시 사용한 별칭을 사용하세요).

<div class="content-ad"></div>

4. **Keystore 비밀번호 입력:** Keystore 비밀번호를 입력하라는 메시지가 표시됩니다. Keystore를 생성할 때 사용한 비밀번호를 입력하세요.

5. **SHA-1 키 가져오기:** 비밀번호를 입력한 후에는 도구가 Keystore에 대한 여러 정보를 표시합니다. 이 중 'SHA-1 key'를 찾아보세요. 'Certificate fingerprints' 섹션 하단에 있는 SHA1 항목을 확인해보세요.

6. **Firebase에 SHA-1 키 추가하기:**

![이미지](/assets/img/2024-06-23-SigningyourflutterappwithKeystore_6.png)

<div class="content-ad"></div>

SHA-1 키를 복사하여 Firebase 콘솔에 프로젝트를 추가해 주세요.

Firebase 프로젝트로 이동하시고, "Project Overview" 근처에 있는 설정 아이콘을 클릭한 후 "프로젝트 설정"을 클릭해주세요. 여기에서 SHA-1 키를 추가할 수 있습니다.

플러터와 모바일 앱 개발에 대해 더 알고 싶다면 도움이 될 겁니다.