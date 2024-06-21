---
title: "Supabase를 사용한 Flutter Google 로그인 인증 구현 방법"
description: ""
coverImage: "/assets/img/2024-06-21-ImplementingGoogleSign-InAuthenticationinFlutterwithSupabase_0.png"
date: 2024-06-21 21:44
ogImage: 
  url: /assets/img/2024-06-21-ImplementingGoogleSign-InAuthenticationinFlutterwithSupabase_0.png
tag: Tech
originalTitle: "Implementing Google Sign-In Authentication in Flutter with Supabase"
link: "https://medium.com/@fianto74/implementing-google-sign-in-authentication-in-flutter-with-supabase-acf7f33a98b1"
---



![이미지](/assets/img/2024-06-21-ImplementingGoogleSign-InAuthenticationinFlutterwithSupabase_0.png)

# 소개

모바일 앱 개발의 계속 발전하는 지형에서 인증은 사용자 경험과 보안에 직접적으로 영향을 미치는 중요한 측면입니다. 본 문서에서는 Supabase의 백엔드 서비스를 활용하여 Flutter 앱에 Google Sign-In 인증을 통합하는 과정을 안내해 드리겠습니다.

# 배경


<div class="content-ad"></div>

구현에 들어가기 전에, 관련 기술들을 간단히 살펴보겠습니다:

- Flutter (https://flutter.dev/): Google에서 제공하는 인기 있는 오픈 소스 UI 소프트웨어 개발 툴킷으로, 단일 코드베이스에서 모바일, 웹, 데스크톱용 네이티브 컴파일된 애플리케이션을 구축할 수 있습니다.
- Supabase (https://supabase.com/): 오픈 소스 Firebase 대안인 Supabase는 애플리케이션을 위한 확장 가능하고 안전한 백엔드 서비스(BaaS) 인프라를 제공합니다.

# 준비사항

시작하기 전에, 다음의 준비사항이 있는지 확인해주세요:

<div class="content-ad"></div>

- Flutter SDK가 설치되어 있습니다. 사용한 버전은 v3.16.0 입니다.
- Supabase 계정 및 프로젝트가 설정되어 있습니다.
- Flutter와 Dart 프로그래밍 언어에 대한 기본적인 이해가 있어야 합니다.

# 우리가 만들고 있는 것

우리의 미니멀한 Flutter 앱은 두 개의 페이지로 구성될 것입니다:

- 로그인 페이지: 애플리케이션의 진입점인 로그인 페이지는 Google Sign-In을 활용하여 사용자에게 편리하고 안전한 인증 프로세스를 제공합니다. 사용자는 Google 자격 증명을 사용하여 로그인할 수 있어 스무스한 온보딩 경험을 보장합니다.
- 프로필 페이지: 인증된 후 사용자는 프로필 페이지로 이동할 것입니다. 여기서 우리는 Supabase라는 강력한 백엔드 서비스에 중요한 사용자 데이터를 저장하는 방법을 탐구할 것입니다. 프로필 페이지는 사용자 정보를 표시하기 위한 것뿐만 아니라 Flutter 앱과 Supabase 간의 강력한 통합을 증명하는 것입니다.

<div class="content-ad"></div>

자, 한 단계씩 가이드를 시작해보겠습니다. 플러터 UI 툴킷의 효율성, Google Sign-In의 간편함, 그리고 Supabase의 견고함을 결합하여 이 페이지들을 살아있게 만들어봅시다.

한 단계씩 가이드:

- 플러터 프로젝트 설정

다음 명령을 사용하여 새로운 플러터 프로젝트를 생성하여 시작해보세요:

<div class="content-ad"></div>

```js
flutter create your_project_name
```

2. 프로젝트 디렉토리를 변경한 후 아래 명령을 실행하여 종속성을 설치하세요

```js
flutter pub add supabase_flutter google_sign_in
```

3. Supabase 설정. Supabase.com에서 로그인 또는 회원가입을 하고 프로젝트를 생성하세요. 주의하세요, 실제 프로덕션 앱에서 사용자가 거주하는 지역 또는 근처 지역을 선택해야 합니다.

<div class="content-ad"></div>


<img src="/assets/img/2024-06-21-ImplementingGoogleSign-InAuthenticationinFlutterwithSupabase_1.png" />

4. 프로젝트가 준비되면 'Auth Provider' 페이지로 이동하세요,

인증 - 공급자(provider)로 이동한 다음 Google을 선택하고 Google로 로그인 허용을 확인하고 iOS 클라이언트에서 nonce(일회용 숫자) 확인을 건너뛰는 것을 확인하세요. 이후에는 Google 콘솔(이후에 설정합니다)에서 허가된 클라이언트 ID를 입력하고 저장을 클릭하세요.

<img src="/assets/img/2024-06-21-ImplementingGoogleSign-InAuthenticationinFlutterwithSupabase_2.png" />


<div class="content-ad"></div>

5. 구글 클라우드 플랫폼(GCP) 설정하기

https://console.cloud.google.com/에 로그인하고 새 프로젝트를 만듭니다.

![이미지](/assets/img/2024-06-21-ImplementingGoogleSign-InAuthenticationinFlutterwithSupabase_3.png)

프로젝트 이름과 조직을 입력하세요.

<div class="content-ad"></div>

6. 검색 창에서 OAuth 동의를 검색하고, 외부, 생성을 선택하세요.

![이미지](/assets/img/2024-06-21-ImplementingGoogleSign-InAuthenticationinFlutterwithSupabase_4.png)

7. OAuth 동의 화면 양식을 작성하세요.

![이미지](/assets/img/2024-06-21-ImplementingGoogleSign-InAuthenticationinFlutterwithSupabase_5.png)

<div class="content-ad"></div>

안녕하세요! 다음은 한글로 번역된 내용입니다.


![이미지](/assets/img/2024-06-21-ImplementingGoogleSign-InAuthenticationinFlutterwithSupabase_6.png)

앱 이름, 사용자 지원 이메일 및 인가된 도메인이 필요합니다. 인가된 도메인에는 Supabase의 Google 제공자 섹션에서 콜백 URL을 입력하세요. 저장 및 계속하기를 클릭하세요.

8. OAuth 클라이언트 ID를 만들기 위해 자격 증명으로 이동합니다.

이 페이지에서는 웹 클라이언트 ID, 안드로이드 클라이언트 ID 및 iOS 클라이언트 ID 3개의 OAuth 클라이언트 ID를 생성합니다.


<div class="content-ad"></div>


![Image 1](/assets/img/2024-06-21-ImplementingGoogleSign-InAuthenticationinFlutterwithSupabase_7.png)

8.1. 웹 클라이언트 ID 생성

이름을 입력하고 승인된 리디렉션 URI를 추가하세요. URI를 얻으려면, supabase로 돌아가세요,

![Image 2](/assets/img/2024-06-21-ImplementingGoogleSign-InAuthenticationinFlutterwithSupabase_8.png)


<div class="content-ad"></div>

<img src="/assets/img/2024-06-21-ImplementingGoogleSign-InAuthenticationinFlutterwithSupabase_9.png" />

8.2. 안드로이드 클라이언트 만들기.

패키지 이름과 SHA-1 인증서를 입력하세요.
참고 : SHA-1 인증서를 받으려면 키스토어를 생성해야 하며, app/build.gradle에서 환경설정을 해야 합니다.

<img src="/assets/img/2024-06-21-ImplementingGoogleSign-InAuthenticationinFlutterwithSupabase_10.png" />

<div class="content-ad"></div>

9. 앱을 게시하기

![Publish app](/assets/img/2024-06-21-ImplementingGoogleSign-InAuthenticationinFlutterwithSupabase_11.png)

10. 플러터를 Supabase와 통합해 봅시다.

코드 구조, 상태 관리, 라우팅 등을 선호하는 대로 프로젝트를 자유롭게 설정할 수 있습니다.

<div class="content-ad"></div>

먼저 main.dart 파일의 상단에 Supabase를 초기화하세요.

```js
await Supabase.initialize(
  url: '당신의 Supabase URL',
  anonKey:
      '당신의 익명 키',
);
```

Supabase 대시보드에서 URL과 익명 키를 가져오세요. 설정 - API로 이동하세요.

![이미지](/assets/img/2024-06-21-ImplementingGoogleSign-InAuthenticationinFlutterwithSupabase_12.png)

<div class="content-ad"></div>

11. 로그인 페이지 만들기

최소한 구글 로그인 버튼이 있는 페이지입니다.

12. 구글을 이용한 로그인 로직 생성

```js
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

...

Future<AuthResponse> _googleSignIn() async {
  /// 수정해야 할 부분: 자체 웹 클라이언트 ID로 업데이트하세요.
  ///
  /// Google Cloud에 등록한 웹 클라이언트 ID입니다.
  const webClientId = 'my-web.apps.googleusercontent.com';

  /// 수정해야 할 부분: 자체 iOS 클라이언트 ID로 업데이트하세요.
  ///
  /// Google Cloud에 등록한 iOS 클라이언트 ID입니다.
  const androidClientId = 'my-android.apps.googleusercontent.com';

  // 안드로이드에서 Google 로그인을 위해 Android 클라이언트 ID를 제공하지 않아도 작동합니다.

  final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId: iosClientId,
    serverClientId: webClientId,
  );
  final googleUser = await googleSignIn.signIn();
  final googleAuth = await googleUser!.authentication;
  final accessToken = googleAuth.accessToken;
  final idToken = googleAuth.idToken;

  if (accessToken == null) {
    throw 'Access Token을 찾을 수 없습니다.';
  }
  if (idToken == null) {
    throw 'ID Token을 찾을 수 없습니다.';
  }

  return supabase.auth.signInWithIdToken(
    provider: Provider.google,
    idToken: idToken,
    accessToken: accessToken,
  );
}
...
```

<div class="content-ad"></div>

13. 홈 / 대시보드 페이지 생성
로그인 성공 후에는 다른 페이지로 이동해야 합니다. 우리의 경우에는 홈 페이지로 이동해야 합니다.

페이지를 자유롭게 디자인할 수 있습니다. 사용자 데이터를 얻으려면 supabase.auth.currentUser를 사용할 수 있습니다.

```js
final user = supabase.auth.currentUser;
final profileImageUrl = user?.userMetadata?['avatar_url'];
final fullName = user?.userMetadata?['full_name'];
```

14. 로그아웃

<div class="content-ad"></div>

로그아웃하려면 await supabase.auth.signOut()을 사용하세요.

# 결론

이 기사에서는 Google 로그인 및 Supabase SDK for Flutter를 활용하여 Flutter 애플리케이션에 인증을 통합하는 과정을 다루었습니다. 상태 관리, 라우팅 등을 더 탐구할 수 있으니 이것은 간단/최소한의 예시에 불과하다는 점을 유의해 주세요.