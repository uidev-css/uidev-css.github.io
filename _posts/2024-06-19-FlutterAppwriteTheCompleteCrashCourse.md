---
title: "Flutter Appwrite  완벽한 크래시 코스"
description: ""
coverImage: "/assets/img/2024-06-19-FlutterAppwriteTheCompleteCrashCourse_0.png"
date: 2024-06-19 00:13
ogImage: 
  url: /assets/img/2024-06-19-FlutterAppwriteTheCompleteCrashCourse_0.png
tag: Tech
originalTitle: "Flutter Appwrite — The Complete Crash Course"
link: "https://medium.com/@tomicriedel/flutter-appwrite-the-complete-crash-course-20eea45bdb65"
---


<img src="/assets/img/2024-06-19-FlutterAppwriteTheCompleteCrashCourse_0.png" />

Appwrite는 지난 몇 달 동안 점점 더 인기를 얻고있는 자체 호스팅된 백엔드 솔루션입니다. 개인 및 상업용 앱에 유용하며 훌륭한 기능을 제공합니다. 이 글에서는 Appwrite를 사용하는 방법을 배우고, Flutter에서 가장 쉽게 사용할 수 있는 백엔드 솔루션이라는 것을 확인할 수 있을 것입니다.

즐거운 읽기 되세요!

# 설치

<div class="content-ad"></div>

우리 앱을 만든 후에 해야 할 첫 번째 일은 Appwrite를 추가하는 것입니다. 이를 위해 flutter pub add appwrite 명령어를 사용할 것입니다.

하지만 그겣만으로 충분하지 않습니다. Appwrite는 백엔드 솔루션이기 때문에, 우리는 우리의 기계에 다운로드해야 합니다. Digital Ocean 또는 Gitpod을 사용하는 경우, 여기 있는 링크를 클릭하여 One-Click 설정을 할 수 있습니다.

만약 둘 중 하나를 사용하지 않는다면, 도커를 사용하여 설치할 수 있습니다. 이곳을 클릭하여 설치할 수 있습니다. 아직 도커를 설치하지 않았다면, 이곳을 클릭하여 설치할 수 있습니다.

# Appwrite 프로젝트 생성

<div class="content-ad"></div>

이제 Appwrite 프로젝트를 설정해 봅시다. 도커 CLI가 실행 중인지 확인하여 로컬호스트를 통해 Appwrite 대시보드에 액세스할 수 있습니다. Appwrite 클라우드를 사용 중이라면 Appwrite 클라우드 대시보드로 이동해주세요.

거기에서 프로젝트 생성을 클릭하세요. 지시 사항을 따르고 생성을 클릭하세요. 이제 프로젝트에 새로운 Flutter 플랫폼을 추가해야 합니다. 생성한 프로젝트에서 "플랫폼 추가"를 클릭하세요. Flutter를 선택하고 App 자격 증명을 추가하세요.

여러 플랫폼으로 앱을 빌드하는 경우 각 플랫폼에 대해 몇 가지 단계를 수행해야 합니다. 아래 모든 링크를 참조하세요:

- 안드로이드
- iOS
- Linux
- macOS
- Web
- Windows

<div class="content-ad"></div>

# 첫 단계 및 사용자 인증

먼저 SDK를 초기화하는 것부터 시작해보겠습니다. 앱라이트 대시보드의 설정으로 이동하여 프로젝트 ID 및 엔드포인트를 확인해주세요.

![image](/assets/img/2024-06-19-FlutterAppwriteTheCompleteCrashCourse_1.png)

Appwrite를 가져와서 Client 유형의 새 변수를 만듭니다. 이제 엔드포인트를 설정할 수 있습니다. 로컬호스트로 설정하세요.

<div class="content-ad"></div>

```dart
import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Client client = Client()
    .setEndpoint("https://localhost/v1") // 만약 Appwrite cloud를 사용 중이라면 https://cloud.appwrite.io/v1을 사용하세요
    .setProject("<YOUR_PROJECT_ID>");
  
  runApp(MaterialApp();
}
```

자, 이제 첫 번째 요청을 보내 봅시다. 우리는 계정을 만들 것입니다. 이를 위해 account라는 새 변수를 만들고 .create()를 호출합니다. 여기에 대해 몇 가지를 지정할 수 있습니다. 그 값들은 텍스트 필드에서 가져올 수 있습니다:

```dart
// 계정 변수 생성
Account account = Account(client);

// 새 계정 생성. 이름은 옵션입니다.
await account.create(
  userId: ID.unique(), 
  email: email, 
  password: password, 
  name: name,
);
```

하지만 이렇게 하면 계정만 생성되고 사용자가 로그인되지는 않습니다. 사용자를 로그인하려면 createEmailPasswordSession을 사용할 수 있습니다:
```

<div class="content-ad"></div>

```dart
// 로그인
await account.createEmailPasswordSession(email: email, password: password);

// 사용자 정보 가져오기. 예를 들어 상태 관리에서 저장하여 나중에 접근할 수 있습니다 (예: userProvider 사용)
final user = await account.get();
```

사용자를 로그아웃하려면 deleteSession()을 호출하면 됩니다 (걱정 마세요, 이 작업은 계정을 삭제하는 것이 아니라 현재 세션만 삭제합니다):

```dart
await widget.account.deleteSession(sessionId: 'current');
```

그런데 계정을 삭제하려면 어떻게 해야 할까요? 이 작업은 그렇게 간단하지 않습니다. 왜냐하면 User API(계정 API가 아닌)와 작업해야하기 때문입니다. User API는 서버 측에서 통합되어 있으며 관리자 범위에서 작동하는 반면, Account API는 현재 로그인한 사용자의 범위에서 작동하며 일반적으로 클라이언트 측 통합을 사용합니다. Appwrite가 서버 측 Dart SDK 코드를 지원하므로 우리는 여전히 Dart 코드를 사용할 수 있지만, dart_appwrite 패키지를 추가해야 합니다. 또한 해당 함수를 배포하고 그에 대한 응답을 받아야 합니다. 이 내용은 초보자를 위한 Appwrite 튜토리얼이므로 이 부분에 대해 다루지는 않겠습니다. 하지만 기본적인 코드는 다음과 같을 것입니다:```

<div class="content-ad"></div>

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
  .setEndpoint('https://cloud.appwrite.io/v1') // API 엔드포인트를 입력해주세요
  .setProject('5df5acd0d48c2') // 프로젝트 ID를 입력해주세요
  .setKey('919c2d18fb5d4...a2ae413da83346ad2'); // 시크릿 API 키를 입력해주세요

Users users = Users(client);

await users.delete(
  // 함수에 전달된 인수를 사용자 ID로 설정해주세요
  userId: '<사용자 ID>',
);

// 물론 응답을 반환해야 해요
```

# 데이터베이스 사용하기

데이터베이스를 만들려면 프로젝트로 돌아가서 "Database"로 이동하세요. 거기서 데이터베이스를 만들 수 있어요. 각 데이터베이스는 콜렉션으로 나뉩니다. 앱을 위해 여러 데이터베이스를 만들 필요는 없지만, 더 큰 애플리케이션을 위해서는 권장됩니다. 콜렉션 안에서 다양한 속성을 추가할 수 있어요. 할 일 목록 애플리케이션에서는 예를 들어 날짜, 텍스트, 그리고 완료 여부를 나타냅니다. 콜렉션의 설정에서 권한을 "문서 수준"으로 설정하면 UserID를 따로 지정하지 않아도 됩니다. 또한, ID를 걱정할 필요도 없어요. Appwrite가 자동으로 ID를 할당하기 때문이죠 (기존에 지정한 속성이 없을 경우).

하지만 이제는 당연히 데이터베이스 항목을 가져오고 싶어요. 먼저 모든 문서를 나열할 거에요:
```

<div class="content-ad"></div>

```dart
final databases = Databases(client);

try {
  final documents = await databases.listDocuments(
      databaseId: '<DATABASE_ID>',
      collectionId: '[COLLECTION_ID]',
      queries: [
        // No queries means everything. Read more about queries here: [queries](https://appwrite.io/docs/products/databases/queries)
      ]
  );
} on AppwriteException catch(e) {
  print(e);
}
```

컬렉션 ID는 컬렉션의 설정에서 얻을 수 있고 데이터베이스 ID는 데이터베이스의 설정에서 얻을 수 있습니다.

하지만 사용자가 할 일을 클릭하고 모든 정보에 액세스하려면 어떻게 해야 할까요? 그럴 경우 한 항목만 가져와야 합니다. 이 작업도 Appwrite를 사용하면 매우 쉽습니다.

```dart
try {
  Document result = await databases.getDocument(
      databaseId: '<DATABASE_ID>',
      collectionId: '<COLLECTION_ID>',
      documentId: '<DOCUMENT_ID>',
  );
} on AppwriteException catch(e) {
  print(e);
}
```

<div class="content-ad"></div>

모든 문서를 가져왔지만 사용자는 아직 문서를 생성하지 않았습니다. 그래서 지금 바로 해보겠습니다:

```js
try {
  Document result = await databases.createDocument(
      databaseId: '<DATABASE_ID>',
      collectionId: '<COLLECTION_ID>',
      documentId: '<DOCUMENT_ID>',
      data: {
        "text": "Go for a walk",
        "done": false,
        // ...
      },
      permissions: ["read("any")"], //permissions에 대해 더 알아보기
   );
} on AppwriteException catch(e) {
  print(e);
}
```

# 추가 읽을거리 및 결론

이 글에서는 백엔드 솔루션 "Appwrite"의 기본을 배웠습니다. 이것이 얼마나 유용하고 사용하기 쉬운지 보았습니다. 내 의견으로는, Firebase, AWS, 그리고 Supabase 중에서 Appwrite가 가장 쉽게 사용할 수 있는 백엔드 솔루션이라고 생각합니다.

<div class="content-ad"></div>

아래는 Appwrite의 매우 간단한 개요에 불과하며 모든 내용을 다 다루지는 않습니다. 발견할 것이 아주 많습니다. 더 고급된 기사를 원하시면 댓글을 남겨주세요!

한편, Appwrite 문서를 확인해주세요: [Appwrite 문서](https://appwrite.io/docs)

다음 몇 개의 글에서는 더 복잡한 패키지를 소개하고 설명하겠습니다. 이를 놓치고 싶지 않다면 저를 팔로우하는 것을 추천합니다. 누구나 이해할 수 있는 가장 쉬운 튜토리얼을 작성하기 위해 최선을 다해보았습니다. 이 작업에 감사드리며, 이 퀄리티 콘텐츠를 지원해주시고 몇 개의 박수를 보내 주시면 정말 감사하겠습니다!

독자 여러분의 읽어 주셔서 감사합니다. 즐거운 하루 보내세요! 🌟