---
title: "Serverpod 시작하기 인증  첫 번째 파트"
description: ""
coverImage: "/assets/img/2024-06-21-GettingStartedwithServerpodAuthenticationPart1_0.png"
date: 2024-06-21 21:49
ogImage:
  url: /assets/img/2024-06-21-GettingStartedwithServerpodAuthenticationPart1_0.png
tag: Tech
originalTitle: "Getting Started with Serverpod: Authentication — Part 1"
link: "https://medium.com/serverpod/getting-started-with-serverpod-authentication-part-1-72c25280e6e9"
---

## 서버파드에서 이메일 및 비밀번호 인증 구현 단계별 가이드

![이미지](/assets/img/2024-06-21-GettingStartedwithServerpodAuthenticationPart1_0.png)

# 인증 시리즈

부분 1 — 이메일 및 비밀번호 인증
부분 2 — 구글 인증
부분 2.5 — 구글 API
부분 3 — 애플 인증

<div class="content-ad"></div>

# 소개

서버포드에서 인증에 관한 시리즈의 제1부에 오신 것을 환영합니다! 본 문서에서는 서버포드 및 플러터 애플리케이션에서 이메일 및 비밀번호 인증을 구현하는 데 초점을 맞춥니다. 이메일 및 비밀번호 인증은 대부분의 애플리케이션에 있어 일반적이고 필수적인 기능으로, 사용자가 계정을 만들고 로그인하여 데이터에 안전하게 접근할 수 있게 합니다.

우리는 서버포드 프로젝트를 생성부터 서버포드 인증 모듈을 설정하는 과정까지 전체 과정을 안내해 드리겠습니다. 또한 서버 측 코드 설정과 제3자 메일 서버와 통합하는 방법, 사용자 인터페이스를 구축하고 서버와 연결하는 방법에 대한 지침도 제공할 것입니다.

본 문서를 마치면 서버포드-플러터 애플리케이션에서 이메일 및 비밀번호 인증을 어떻게 구현하는지에 대한 탄탄한 이해를 갖추게 되며, 향후 시리즈 뒷부분의 추가적인 인증 방법 탐색을 위한 기초가 마련될 것입니다.

<div class="content-ad"></div>

이 튜토리얼에서 생성하는 완전한 예제 프로젝트는 여기에서 확인할 수 있습니다.

시작해 봅시다!

## 전제 조건

Serverpod로 이메일 및 비밀번호 인증을 구현하기 전에 필요한 몇 가지 전제 조건이 있습니다. 이미 Serverpod CLI 및 Docker를 비롯한 필요한 도구를 설치했다고 가정합니다. 아직 이 도구들을 설정하지 않은 경우, 공식 Serverpod 문서를 참고하여 시작하십시오.

<div class="content-ad"></div>

또한, 이 글에서 나중에 생성할 데이터베이스 및 테이블을 검토하기 위해 Postico2, PgAdmin, 또는 DBeaver와 같은 데이터베이스 뷰어를 다운로드하고 설치하는 것을 권장합니다. 선호하는 데이터베이스 뷰어를 사용할 수 있습니다. 이 글에서는 Postico2를 사용할 예정입니다.

# 서버포드 프로젝트 만들기

새로운 서버포드 프로젝트를 생성합니다: 다음 명령을 실행하여 새로운 서버포드 프로젝트를 만듭니다:

```js
serverpod create my_project
```

<div class="content-ad"></div>

프로젝트 디렉토리로 이동하세요: 프로젝트 내 서버 디렉토리로 작업 디렉토리를 변경하세요:

```js
cd my_project/my_project_server
```

Windows 환경에서: 윈도우 환경이라면, 서버팟을 위한 필요한 데이터베이스 테이블을 만들기 위해 설정 중에 이 추가 단계를 수행해야 합니다. 서버 프로젝트 내에서 setup-tables.cmd라는 cmd 파일을 찾을 수 있을 것입니다. 이 스크립트를 실행하세요! 이는 generate/tables-serverpod.pgsql에 위치한 psql 파일을 실행할 것입니다. 리눅스와 맥에서는 프로젝트를 생성할 때 이 단계가 자동으로 수행됩니다.

컨테이너 시작하기: 서버팟 프로젝트에 필요한 Docker 컨테이너를 시작하기 위해 다음 명령을 실행하세요:

<div class="content-ad"></div>

```js
docker-compose up --build --detach
```

# 서버팟\_인증 모듈 설치 및 구성하기

서버팟*인증 모듈은 Serverpod 프로젝트에서 인증을 관리하는 데 필수적인 기능을 제공합니다. 사용자 등록, 로그인, 비밀번호 해싱 및 세션 관리와 같은 기능이 포함되어 있습니다. 이 섹션에서는 서버팟*인증 모듈 설치 및 구성 프로세스를 안내하고 데이터베이스를 업데이트하는 방법을 안내합니다.

## 서버 쪽 설정

<div class="content-ad"></div>

서버파드 프로젝트(my_project_server)의 pubspec.yaml 파일을 열고 다음 줄을 의존성 섹션 아래에 추가해주세요:

```js
dependencies:
  serverpod_auth_server: ^2.0.0
```

참고: 모든 서버파드 종속성의 버전은 동일해야 합니다! serverpod_auth를 버전 2.0.0으로 추가하는 경우, serverpod와 설치한 다른 서버파드 패키지도 2.0.0이어야 합니다.

버전 2.0 이상인 경우 서버파드 객체에 authenticationHandler를 등록하세요: main.dart 파일에 다음 코드를 추가해주세요. 이 콜백은 클라이언트로부터 수신된 요청을 인증하는 데 사용됩니다. 이전 버전은 이 단계를 완료할 필요가 없습니다.

<div class="content-ad"></div>

```js
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;

void run(List<String> args) async {
  var pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
    authenticationHandler: auth.authenticationHandler, // 이 줄을 추가하세요
  );

  await pod.start();
}
```

의존성 가져오고 필요한 파일 생성하기: 프로젝트의 루트 디렉토리에서 다음 명령을 실행하여 새로운 종속성을 가져오고 서버 구성에 따라 필요한 파일을 생성하세요:

```js
dart pub get
serverpod generate
```

기존 데이터베이스에 필요한 테이블 업데이트하기: Serverpod auth 모듈에는 모듈이 작동하는 데 필요한 데이터베이스 테이블 세트가 함께 제공됩니다. 이를 생성해봅시다.

<div class="content-ad"></div>

만약 Serverpod 버전 1.2 이상을 사용하고 있다면, 마이그레이션 시스템을 사용해야 해요! 다음 명령어로 새 마이그레이션을 만들어보세요:

```js
serverpod create-migration
```

그리고 새 마이그레이션을 적용하려면 아래 명령어를 사용하세요:

```js
dart bin/main.dart --apply-migrations --role=maintenance
```

<div class="content-ad"></div>

유지 관리 역할을 설정하면 서버가 부팅되어 데이터베이스에 연결한 후 종료됩니다.

버전 1.1 이하:

- 새 SQL 파일 만들기: 기존 tables-serverpod.pgsql 파일이 있는 폴더에 tables-serverpod-auth.pgsql이라는 새 파일을 만듭니다. 이 파일에는 새 테이블을 생성하는 SQL 코드가 포함될 것입니다.
- SQL 코드 복사: serverpod_auth 모듈의 테이블을 생성하는 SQL 코드에 액세스하려면 다음 링크를 엽니다: serverpod_auth tables.pgsql. 파일 전체 내용을 복사합니다.
- SQL 코드를 새 파일에 붙여넣기: 새로 생성된 tables-serverpod-auth.pgsql 파일을 열고 복사한 SQL 코드를 붙여넣습니다.
- Docker 컨테이너 이름 찾기: `docker ps`를 실행하거나 Docker 대시보드를 확인하여 Docker 컨테이너 이름을 찾습니다. 아래 스크린샷을 참고할 수도 있습니다.

![이미지](/assets/img/2024-06-21-GettingStartedwithServerpodAuthenticationPart1_1.png)

<div class="content-ad"></div>

포스트그레SQL 파일을 컨테이너로 복사하고 SQL 코드를 실행하려면 다음 단계를 따르세요: `container_name`을(를) Docker 컨테이너 이름으로 바꿔주세요.

```js
docker cp ./tables-serverpod-auth.pgsql <container_name>:/docker-entrypoint-initdb.d/tables-serverpod-auth.pgsql

docker exec -u postgres <container_name> psql my_project postgres -f /docker-entrypoint-initdb.d/tables-serverpod-auth.pgsql
```

## 데이터베이스에 Postico 연결하기

시작하려면 Postico2를 열고 "새 서버"를 클릭하여 새 연결을 만드세요. 로컬 포스트그레SQL 서버의 연결 세부 정보를 입력해야 합니다. 이 정보는 Serverpod 프로젝트의 config/development.yaml 및 config/passwords.yaml 파일에서 찾을 수 있습니다.

<div class="content-ad"></div>

아래는 Markdown 형식으로 표 태그를 변경한 내용입니다.

![GettingStartedwithServerpodAuthenticationPart1_2](/assets/img/2024-06-21-GettingStartedwithServerpodAuthenticationPart1_2.png)

![GettingStartedwithServerpodAuthenticationPart1_3](/assets/img/2024-06-21-GettingStartedwithServerpodAuthenticationPart1_3.png)

모든 테이블이 성공적으로 생성되었습니다. 다음 단계로 넘어가겠습니다.

## 클라이언트 라이브러리 설정

<div class="content-ad"></div>

클라이언트 측에서 serverpod_auth 모듈을 사용하려면 클라이언트 프로젝트에 serverpod_auth_client 종속성을 추가해야 합니다.

클라이언트 프로젝트의 pubspec.yaml 파일을 열고 다음 라인을 dependencies 섹션 아래에 추가하세요:

```js
dependencies:
  ...
  serverpod_auth_client: ^2.0.0
```

이 패키지에는 서버로 이메일 및 비밀번호 인증을 위한 API 호출을 만들기 위해 필요한 클라이언트 측 라이브러리 코드가 포함되어 있습니다. serverpod_auth_email_flutter가 제공하는 미리 빌드된 UI 구성 요소를 사용 중이라면 해당 종속성은 엄격히 필요하지는 않지만 모든 생성된 인증 엔드포인트가 포함되어 있어 상호 작용할 수 있으므로 여기에 추가하는 것이 좋습니다.

<div class="content-ad"></div>

## 플러터 앱 설정

Serverpod를 사용하여 이메일 및 비밀번호 인증에 필요한 서버 측 변경 사항을 구현한 후, 다음 단계는 Flutter 앱과 통합하는 것입니다. 다행히도 Serverpod는 이 프로세스를 가능한한 원활하게 만들기 위해 미리 구축된 UI 컴포넌트를 제공합니다.

먼저, Flutter 앱에 필요한 클라이언트 측 종속성을 추가해야 합니다. Serverpod 프로젝트(my_project_flutter)의 pubspec.yaml 파일을 열고 다음과 같은 라인을 dependencies 섹션 아래 추가해주세요:

```js
dependencies:
  ...
  serverpod_auth_email_flutter: ^2.0.0
  serverpod_auth_shared_flutter: ^2.0.0
```

<div class="content-ad"></div>

pubspec.yaml 파일에 필요한 종속성을 추가한 후에는 터미널에서 flutter pub get을 실행하여 종속성을 업데이트해야 합니다.

이러한 패키지에는 사전 제작된 UI 구성 요소 및 서버 통합을 최대한 간단하게 만드는 기타 도구가 포함되어 있습니다. 그러나 자체 UI 구성 요소를 만들기를 선호하는 경우, 생성된 클라이언트 라이브러리와 통합할 수 있고 이 경우에는 이러한 종속성이 필요하지 않습니다.

# 서버 시작 및 클라이언트 실행

축하합니다! 이제 모든 필요한 종속성이 설정된 프로젝트가 있습니다. 다음으로 진행하기 전에 모든 것이 올바르게 작동하는지 확인해 봅시다.

<div class="content-ad"></div>

서버를 시작하려면 터미널에서 my_project_server 디렉토리로 이동한 다음 다음 명령어를 실행하세요:

```js
cd my_project_server
dart bin/main.dart
```

<img src="/assets/img/2024-06-21-GettingStartedwithServerpodAuthenticationPart1_4.png" />

다음으로, 새 터미널 창에서 my_project_flutter 디렉토리로 이동한 다음 다음 명령어를 실행하여 Flutter 앱을 시작하세요:

<div class="content-ad"></div>

```js
cd my_project_flutter
flutter run
```

크롬에서 실행하여 메시지를 보내는 테스트를 선택하세요!

<img src="/assets/img/2024-06-21-GettingStartedwithServerpodAuthenticationPart1_5.png" />

## 문제 해결

<div class="content-ad"></div>

문제가 발생하면 문제를 진단하는 데 도움이 되는 몇 가지를 확인할 수 있습니다:

- 이 가이드의 이전 단계를 모두 올바르게 따랐는지 확인하세요.
- 서버가 오류 없이 실행 중인지 확인하세요. 오류가 있으면 서버를 시작한 터미널에 표시됩니다.
- 필요한 데이터베이스 테이블이 모두 생성되었는지 확인하세요. 이를 확인하려면 Postgres나 pgAdmin과 같은 도구를 사용하여 데이터베이스에 연결하고 public 스키마에있는 테이블을 확인하세요. 테이블이 누락 된 경우 해당 테이블을 만들기 위해 SQL 스크립트를 실행했는지 확인하세요.
- 여전히 문제가 발생하는 경우 앱의 콘솔 또는 로그에서 추가 컨텍스트를 제공 할 수있는 오류 메시지를 확인하세요.

# 이메일/비밀번호 인증 구현

이제 서버와 클라이언트 라이브러리를 설정 했으므로 Flutter 앱에서 인증을 구현할 시간입니다. 이전에 추가 한 serverpod_auth_email_flutter 및 serverpod_auth_shared_flutter 패키지를 사용합니다.

<div class="content-ad"></div>

첫 번째 단계는 Client 및 SessionManager 객체를 초기화하는 것입니다. 먼저 my_project_flutter/lib/src/ 폴더 안에 serverpod_client.dart 파일을 생성해보세요.

```js
import 'package:my_project_client/my_project_client.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

late SessionManager sessionManager;
late Client client;

Future<void> initializeServerpodClient() async {
  // 안드로이드 에뮬레이터는 기본적으로 로컬호스트에 액세스할 수 없습니다.
  // const ipAddress = '10.0.2.2'; // 호스트에 대한 안드로이드 에뮬레이터 IP 주소

  // 실제 장치에서는 ipAddress를 컴퓨터의 IP 주소로 대체하십시오.
  const ipAddress = 'localhost';

  // 어플리케이션 어디서든 사용할 수 있는 싱글톤 클라이언트 객체를 설정합니다.
  // 해당 클라이언트는 서버 코드에서 생성됩니다.
  // 클라이언트는 로컬 서버의 기본 포트에서 실행 중인 Serverpod에 연결하도록 설정됩니다.
  // 스테이징이나 프로덕션 서버에 연결하려면 수정해야 합니다.
  client = Client(
    'http://$ipAddress:8080/',
    authenticationKeyManager: FlutterAuthenticationKeyManager(),
  )..connectivityMonitor = FlutterConnectivityMonitor();

  // 세션 관리자는 사용자의 로그인 상태를 추적합니다.
  // 사용자가 현재 로그인되어 있는지 확인하고 사용자 정보를 가져올 수 있습니다.
  sessionManager = SessionManager(
    caller: client.modules.auth,
  );

  await sessionManager.initialize();
}
```

본 함수는 클라이언트와 서버 간 통신에 사용되는 싱글톤 Client 객체를 설정하고, 사용자의 로그인 상태를 추적하는 SessionManager 객체를 초기화합니다.

이전 단계에서 생성된 Client 객체를 사용하려면 main() 함수에서 싱글톤 인스턴스로 초기화해야 합니다. 이를 위해 main.dart 파일의 main() 함수에서 WidgetsFlutterBinding.ensureInitialized()를 호출하여 Flutter가 완전히 초기화된 후에 SessionManager를 사용할 수 있도록 해야 합니다. 그 후에 방금 만든 initializeServerpodClient() 함수를 호출할 수 있습니다. 마지막으로 runApp() 함수를 호출하여 어플리케이션을 시작할 수 있습니다. 아래는 업데이트된 main() 함수의 예시입니다:

<div class="content-ad"></div>

```js
void main() async {
  // runApp을 호출하기 전에 Flutter 바인딩을 사용하는 SessionManager를 호출해야 합니다.
  WidgetsFlutterBinding.ensureInitialized();

  await initializeServerpodClient();

  runApp(const MyApp());
}
```

다음으로 사용자에게 로그인 양식을 표시할 SignInPage 위젯을 만들겠습니다. 또한 사용자가 성공적으로 로그인한 후에 표시될 AccountPage 위젯도 만들겠습니다.

## SignIn 페이지 생성

Flutter 앱에서 이메일 및 비밀번호 인증을 활성화하기 위해 serverpod_auth_email_flutter 패키지에서 제공하는 SignInWithEmailButton이라는 미리 만들어진 위젯을 사용하여 로그인 페이지를 생성할 것입니다. 이 위젯은 로그인 버튼을 생성하며 로그인 흐름을 처리하는 대화 상자를 제공합니다.

<div class="content-ad"></div>

먼저, Flutter 앱의 lib/src/widgets 폴더에 sign_in_page.dart란 이름의 새 파일을 만들어주세요.

다음으로, StatelessWidget을 확장하는 SignInPage라는 새 클래스를 만들어주세요. 이 클래스는 Dialog 위젯으로 감싸진 로그인 버튼을 반환할 것입니다:

```js
import 'package:flutter/material.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';
import 'package:my_project_flutter/src/serverpod_client.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        child: Container(
          width: 260,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SignInWithEmailButton(
                caller: client.modules.auth,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

위 코드에서, SignInWithEmailButton 위젯은 caller라는 인자를 가져오는데, 이는 Serverpod에서 제공하는 생성된 클라이언트 라이브러리의 인스턴스입니다. 이를 통해 위젯이 Serverpod 서버와 통신할 수 있게 됩니다.

<div class="content-ad"></div>

## 홈페이지에 SignInPage 추가하기

앱의 홈페이지에 SignInPage를 추가하려면 lib/ 폴더의 루트에 위치한 main.dart 파일 내에 정의된 MyHomePage 클래스를 수정해야 합니다.

기존의 MyHomePage 클래스를 다음 코드로 변경하세요. 이 클래스 아래에 있는 내용은 모두 제거해도 됩니다.

```js
class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const SignInPage(),
    );
  }
}
```

<div class="content-ad"></div>

잊지 말고 SignInPage 위젯에 대한 import 문을 추가해주세요:

```js
import "package:my_project_flutter/src/widgets/sign_in_page.dart";
```

전체 main.dart 파일은 다음과 같이 보여야 합니다:

```js
import 'package:my_project_flutter/src/serverpod_client.dart';
import 'package:my_project_flutter/src/widgets/sign_in_page.dart';
import 'package:flutter/material.dart';

void main() async {
  // runApp을 호출하기 전에 Flutter 바인딩을 사용하는 SessionManager를 초기화해야 합니다.
  WidgetsFlutterBinding.ensureInitialized();

  await initializeServerpodClient();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Serverpod demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Serverpod Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const SignInPage()
    );
  }
}
```

<div class="content-ad"></div>

앱을 새로고침하면 이제 로그인 버튼을 볼 수 있어요! 아직 끝나지 않았지만 실제로 서버와 통신할 수 있어야 해요!

![이미지](/assets/img/2024-06-21-GettingStartedwithServerpodAuthenticationPart1_6.png)

이제 우리 앱의 홈 페이지에 로그인 페이지를 통합했고 계정을 생성할 수 있어요. 그러나 로그인 프로세스를 완료하기 위해 서버에서 전송된 인증 코드가 필요해요. 계정 등록을 위해 사용자는 회원 가입 페이지의 필수 필드를 작성하고 양식을 제출할 수 있어요. 제출하면 서버가 제공된 이메일 주소로 인증 코드를 보내줄 거에요. 현재 우리는 인증 코드에 액세스하지 못하므로 로그인 프로세스를 아직 완료할 수 없어요. 이 문제를 해결해 봐요!

## 이메일 인증 콜백 통합하기

<div class="content-ad"></div>

회원 가입 프로세스를 완료하려면 검증 이메일을 보내는 콜백을 추가해야 합니다. Serverpod은 회원 가입을 위한 검증 코드 및 비밀번호 재설정을 위한 메일을 보내는 데 유용한 몇 가지 콜백을 제공합니다. 지금은 콘솔에 코드를 출력하여 기능을 테스트하기 위한 빠르고 간단한 솔루션을 구현해 봅시다.

서버 프로젝트의 server.dart 파일에 다음 구성을 추가하여 콜백을 설정할 수 있습니다:

```js
import 'package:serverpod_auth_server/module.dart' as auth;

void run(List<String> args) async {
  ...
  auth.AuthConfig.set(auth.AuthConfig(
    sendValidationEmail: (session, email, validationCode) async {
      // TODO: 메일 서버와 연동
      print('검증 코드: $validationCode');
      return true;
    },
    sendPasswordResetEmail: (session, userInfo, validationCode) async {
      // TODO: 메일 서버와 연동
      print('검증 코드: $validationCode');
      return true;
    },
  ));

  ...
  await pod.start();
}
```

run() 메서드 내에서 pod.start()를 호출하기 전에 이 코드를 추가하여 콜백이 제대로 설정되도록 해줍니다.

<div class="content-ad"></div>

위에 바꾼 사항들이 적용되도록 하려면 Serverpod 서버를 다시 시작해야 합니다. 서버를 시작한 터미널로 이동하여 "CTRL + C"를 눌러 중지한 후, "dart bin/main.dart"를 실행하여 서버를 다시 시작합니다.

지금 테스트해 봅시다!

로그인 버튼을 생성하고 정보를 입력해 봅시다!

![이미지](/assets/img/2024-06-21-GettingStartedwithServerpodAuthenticationPart1_7.png)

<div class="content-ad"></div>

지금은 이메일을 받지 않을 거에요. 대신에 서버를 실행한 터미널에서 확인 코드를 찾아보셔야 해요.

마크다운(Markdown) 형식으로 테이블 태그를 변경해주세요.

![이미지 1](/assets/img/2024-06-21-GettingStartedwithServerpodAuthenticationPart1_8.png)

![이미지 2](/assets/img/2024-06-21-GettingStartedwithServerpodAuthenticationPart1_9.png)

# 데이터베이스에서 사용자 생성 확인

<div class="content-ad"></div>

이제 어플리케이션에 가입 기능을 설정했으니, 사용자 데이터가 데이터베이스에 올바르게 저장되는지 확인해야 합니다. 아직 Flutter 앱에서 사용자 페이지를 구현하지 않았으므로 Postico2를 사용하여 사용자 생성을 확인할 수 있습니다.

Postico2를 열고 이전에 설정 섹션에서 한 것과 같이 데이터베이스에 연결하십시오. 데이터베이스에 연결한 후 'serverpod_user_info' 테이블을 클릭하십시오. 방금 생성한 사용자를 확인할 수 있어야 합니다.

<img src="/assets/img/2024-06-21-GettingStartedwithServerpodAuthenticationPart1_10.png" />

# 계정 페이지 구현

<div class="content-ad"></div>

지금 로그인 페이지가 작동되고 있다면, 이제 계정 페이지를 구현해 보겠습니다. 이 페이지는 현재 로그인한 사용자에 대한 정보를 보여줄 것입니다. 이를 위해 이전에 만들었던 SessionManager 객체를 사용할 것입니다. SessionManager는 사용자의 로그인 상태를 추적하고 사용자에 대한 정보에 액세스할 수 있는 기능을 제공합니다.

SessionManager가 제공하는 일부 함수를 살펴보겠습니다:

- isSignedIn(): 이 함수는 사용자가 현재 로그인되어 있는 경우 true를 반환하고 그렇지 않으면 false를 반환합니다.
- getSignedInUser(): 이 함수는 현재 로그인한 사용자에 대한 정보(이메일 주소 및 표시 이름과 같은)가 포함된 UserInfo 유형의 객체를 반환합니다.
- signOut(): 이 함수는 사용자를 로그아웃하고 인증 상태를 지웁니다.

CircularUserImage 위젯은 Serverpod 프레임워크가 제공하는 사전 제작된 위젯으로, UserInfo 객체를 입력으로 받아서 원형 프로필 이미지를 표시합니다. sessionManager와 이 위젯을 조합하여 멋진 디자인의 계정 페이지를 만들 수 있습니다.

<div class="content-ad"></div>

lib/src/widgets 디렉토리 안에 account_page.dart라는 새 파일을 만들고 다음 코드를 추가할 거에요:

```js
import 'package:flutter/material.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

import 'package:my_project_flutter/src/serverpod_client.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          leading: CircularUserImage(
            userInfo: sessionManager.signedInUser,
            size: 42,
          ),
          title: Text(sessionManager.signedInUser!.userName),
          subtitle: Text(sessionManager.signedInUser!.email ?? ''),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () {
              sessionManager.signOut();
            },
            child: const Text('로그아웃'),
          ),
        ),
      ],
    );
  }
}
```

UserInfo 객체를 사용하여 사용자의 이름과 이메일을 가져와 UI에 표시할 수 있어요. 또한 사용자가 Sign out 버튼을 누르면 sessionManager.signOut();이 호출되어 응용프로그램에서 로그아웃할 수 있어요.

이제 사용자가 로그인한 경우 AccountPage를 표시해야 해요. 사용자가 로그인했는지 여부에 따라 로그인 페이지와 계정 페이지를 전환하기 위해 main.dart 파일을 수정하고 build 메서드 내에서 const SignInPage()를 이 코드로 바꿔주세요:

<div class="content-ad"></div>

```js
sessionManager.isSignedIn ? const AccountPage() : const SignInPage(),
```

사용자가 로그인한 경우 AccountPage()를 렌더링하고, 로그인되지 않은 경우 SignInPage()를 렌더링합니다.

세션 상태 변경에 따라 사용자 인터페이스를 업데이트하려면 main.dart의 MyHomePageState 내에 다음 코드를 추가해야 합니다.

```js
@override
void initState() {
  super.initState();

  // 로그인 상태 변경 시 페이지를 다시 빌드하도록 합니다.
  sessionManager.addListener(() {
    setState(() {});
  });
}
```

<div class="content-ad"></div>

이 코드는 sessionManager에 리스너를 설정하여 세션 상태 변경 시 페이지를 다시 빌드합니다. 이렇게 함으로써 사용자가 로그인했는지 여부에 따라 앱이 사용자 인터페이스를 업데이트할 수 있도록 합니다.

전체 클래스는 다음과 같이 보여야 합니다:

```js
class MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    // 사용자 로그인 상태 변경 시 페이지 다시 빌드하도록 설정
    sessionManager.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:
          sessionManager.isSignedIn ? const AccountPage() : const SignInPage(),
    );
  }
}
```

이러한 변경 사항을 통해 사용자가 로그인하지 않은 경우 로그인 페이지가 표시되고, 로그인한 경우 사용자 계정 페이지가 표시됩니다.

<div class="content-ad"></div>

![2024-06-21-GettingStartedwithServerpodAuthenticationPart1_11](/assets/img/2024-06-21-GettingStartedwithServerpodAuthenticationPart1_11.png)

이제 직접 해보세요! 이제 데이터베이스에 사용자 데이터가 저장되는 완전한 기능을 갖춘 가입 및 로그인 흐름이 구현되었습니다! 마지막 단계는 이제까지 연기해 왔던 메일 서버 통합입니다.

# 메일 서버 통합

인증 코드와 비밀번호 재설정 링크를 보내기 위해 앱을 외부 메일 서버와 통합해야 합니다. SendGrid, Mailjet 등 여러 옵션이 있지만, 이 튜토리얼의 목적을 위해 Gmail을 메일 서버로 사용할 것입니다.

<div class="content-ad"></div>

프로덕션 앱에는 좋지 않은 솔루션이라는 것을 알아두는 것이 중요합니다. 앱에서 Gmail을 사용하여 이메일을 보내면 전달 문제가 발생할 수 있습니다. 스팸으로 지목당하거나 계정이 제한될 수도 있습니다. 프로덕션 앱에 대해서는 전문적인 이메일 서비스를 사용하는 것을 강력히 권장합니다.

그렇다면, 이제 Gmail을 사용하여 앱을 통합해 봅시다.

먼저, 서버 프로젝트에 mailer 패키지를 추가해야 합니다. 터미널에서 다음 명령을 실행하여 이 작업을 수행할 수 있습니다:

```js
dart pub add mailer
```

<div class="content-ad"></div>

다음으로, 이메일을 보내는 데 사용할 Gmail 계정을 설정해야 합니다. Gmail 계정이 없는 경우 무료로 하나 만들 수 있습니다. https://accounts.google.com/signup 에서 만들어보세요.

Gmail 계정을 만든 후 다음 단계를 따르세요:

- Google 계정 보안 페이지로 이동합니다.
- "Google에 로그인하는 방법" 아래에서 "2단계 인증"을 켭니다.
- 계정에 2단계 인증을 설정하기 위해 안내에 따라 진행합니다. 확인 코드를 받을 전화번호를 제공해야 합니다.
- 2단계 인증을 설정한 후, 계정용 앱 비밀번호를 만듭니다. 이 비밀번호는 우리 앱이 이메일을 보내는 데 사용할 것입니다.

<img src="/assets/img/2024-06-21-GettingStartedwithServerpodAuthenticationPart1_12.png" />

<div class="content-ad"></div>

<img src="/assets/img/2024-06-21-GettingStartedwithServerpodAuthenticationPart1_13.png" />

이제 서버팟 프로젝트의 passwords 파일에 암호를 추가해 보겠습니다. 이 파일은 config/passwords.yaml 경로에 있습니다. 여기서 주의할 점은 이 파일을 버전 관리에 저장하지 마십시오. 실제로 서버팟 프로젝트는 이 파일을 .gitignore에 추가하여 사전 구성되어 있습니다. 대신에 항상 프로젝트 외부에서 비밀을 관리하고, 프로덕션 배포 시에는 CI/CD 파이프라인의 비밀 변수로 유지하십시오.

key/valuesgmailEmail 및 gmailPassword를 추가하세요.

```js
# 이들은 개발 모드에서 로컬 서버를 실행할 때 사용되는 암호입니다.
development:
  database: '9S8rYW7XeIA8bmGY9FBzOSLwQZtQEFNr'
  redis: 'V7YogaG9K2rnIpS1odXIKrqsW8kkfddt'
  gmailEmail: '<your gmail email>'
  gmailPassword: '<your gmail key>'

  # 서비스 비밀은 서버 간 통신 및 서비스 프로토콜에 액세스하는 데 사용됩니다.
  serviceSecret: 'IWtaP1Z-Db-F70IBJpWGf3D7x9F3AYGg'
```

<div class="content-ad"></div>

우리는 비밀번호 파일에 키를 추가하여 나중에 코드에서 쉽게 가져와 사용할 수 있습니다. 이렇게 하면 서버에 시크릿을 삽입하는 편리한 방법입니다.

이제 Gmail 계정과 설정한 시크릿이 준비되었으니, 이메일로 validationCode를 보내는 로직을 구현할 수 있습니다. 이를 위해 이전에 서버 프로젝트 내 server.dart에 만들어둔 AuthConfig를 수정해야 합니다.

먼저, session.serverpod 객체에서 getPassword 함수를 호출하여 Gmail SMTP 서버의 자격 증명을 가져옵니다. 이 함수는 이전 단계에서 추가한 시크릿을 가져올 것입니다.

```js
// 자격 증명 가져오기
final gmailEmail = session.serverpod.getPassword('gmailEmail')!;
final gmailPassword = session.serverpod.getPassword('gmailPassword')!;
```

<div class="content-ad"></div>

그럼, 우리는 검색한 이메일과 비밀번호를 사용하여 Gmail용 SMTP 클라이언트를 생성합니다:

```js
// Gmail용 SMTP 클라이언트 생성
final smtpServer = gmail(gmailEmail, gmailPassword);
```

그런 다음, 유효성 코드를 사용하여 이메일 메시지를 만듭니다:

```js
// 검증 코드를 포함한 이메일 메시지 생성
final message = Message()
  ..from = Address(gmailEmail)
  ..recipients.add(email)
  ..subject = 'Serverpod를 위한 검증 코드'
  ..html = '귀하의 검증 코드는 다음과 같습니다: $validationCode';
```

<div class="content-ad"></div>

마지막으로, mailer 패키지의 send 함수를 사용하여 이메일 메시지를 전송하는 시도를 합니다. 이메일 전송에 실패하면 false를 반환합니다:

```js
// 이메일 메시지를 전송합니다.
try {
  await send(message, smtpServer);
} catch (_) {
  // 이메일 전송에 실패한 경우 false를 반환합니다.
  return false;
}

return true;
```

모든 코드를 한데 모아서 sendValidationEmail 및 sendPasswordResetEmail을 구현할 때 아래와 같이 코드가 보여야 합니다.

```js
// 이메일로 로그인하는 경우의 구성.
auth.AuthConfig.set(auth.AuthConfig(
  sendValidationEmail: (session, email, validationCode) async {
    // 자격 증명 가져오기
    final gmailEmail = session.serverpod.getPassword('gmailEmail')!;
    final gmailPassword = session.serverpod.getPassword('gmailPassword')!;

    // Gmail용 SMTP 클라이언트 생성
    final smtpServer = gmail(gmailEmail, gmailPassword);

    // 검증 코드가 포함된 이메일 메시지 생성
    final message = Message()
      ..from = Address(gmailEmail)
      ..recipients.add(email)
      ..subject = 'Serverpod의 인증 코드'
      ..html = '귀하의 인증 코드는 다음과 같습니다: $validationCode';

    // 이메일 메시지 전송
    try {
      await send(message, smtpServer);
    } catch (_) {
      // 이메일 전송에 실패한 경우 false를 반환합니다.
      return false;
    }

    return true;
  },
  sendPasswordResetEmail: (session, userInfo, validationCode) async {
    // 자격 증명 가져오기
    final gmailEmail = session.serverpod.getPassword('gmailEmail')!;
    final gmailPassword = session.serverpod.getPassword('gmailPassword')!;

    // Gmail용 SMTP 클라이언트 생성
    final smtpServer = gmail(gmailEmail, gmailPassword);

    // 비밀번호 재설정 링크가 포함된 이메일 메시지 생성
    final message = Message()
      ..from = Address(gmailEmail)
      ..recipients.add(userInfo.email!)
      ..subject = 'Serverpod의 비밀번호 재설정 링크'
      ..html = '다음은 비밀번호 재설정 코드입니다: $validationCode';

    // 이메일 메시지 전송
    try {
      await send(message, smtpServer);
    } catch (_) {
      // 이메일 전송에 실패한 경우 false를 반환합니다.
      return false;
    }

    return true;
  },
));
```

<div class="content-ad"></div>

새 변경 사항이 적용되었는지 확인하려면 서버를 다시 시작하는 것을 잊지 마세요. 그러고 나면 테스트해 보는 시간입니다! 새 계정을 만들어서 이메일을 통해 인증 코드를 받는지 확인해 보세요. 모든 것이 기대한 대로 작동한다면, 축하합니다! 이메일 서비스 제공 업체와 Serverpod를 성공적으로 통합했습니다.

# 결론

이 튜토리얼에서는 serverpod_auth_google_flutter를 Flutter 앱과 통합하는 기본 사항을 다뤘습니다. 이를 통해 사용자 계정을 만들고 로그인하고 이메일 주소를 인증할 수 있었습니다. 또한, 메일 서버 통합과 테스트 목적으로 Gmail을 보내는 사람으로 사용하는 mailer 패키지를 간단히 논의했습니다.

다음 시리즈에서는 Google 소셜 로그인을 serverpod_auth_google_flutter와 통합하는 방법에 대해 논의할 것입니다. 이를 통해 사용자가 새로운 계정을 만들 필요 없이 Google 계정으로 로그인하도록 설정하여 사용자가 간편하고 편리하게 가입하고 로그인할 수 있도록 지원할 수 있게 될 것입니다.

<div class="content-ad"></div>

이 시리즈를 마치면 serverpod_auth를 사용하여 플러터 앱에 인증을 통합하는 견고한 기반을 갖추게 될 것입니다. 이를 통해 사용자가 계정을 만들고 로그인하여 안전한 콘텐츠에 액세스할 수 있습니다.
