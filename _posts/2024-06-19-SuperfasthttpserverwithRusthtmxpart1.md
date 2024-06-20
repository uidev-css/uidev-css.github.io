---
title: "슈퍼 빠른 http 서버 만들기 with Rust  htmx 파트 1"
description: ""
coverImage: "/assets/img/2024-06-19-SuperfasthttpserverwithRusthtmxpart1_0.png"
date: 2024-06-19 14:31
ogImage: 
  url: /assets/img/2024-06-19-SuperfasthttpserverwithRusthtmxpart1_0.png
tag: Tech
originalTitle: "Super fast http server with Rust + htmx (part 1)"
link: "https://medium.com/gitconnected/super-fast-http-server-with-rust-htmx-part-1-bfcddbd6e8bc"
---



![SuperfasthttpserverwithRusthtmxpart1_0](/assets/img/2024-06-19-SuperfasthttpserverwithRusthtmxpart1_0.png)

내 첫 번째 글 중 하나에서는 다양한 아키텍처에서 Rust의 사용에 대해 이야기했습니다. 내가 임베디드 리눅스 시스템에서 작업하면서, 사용 가능한 하드웨어 자원을 최적으로 활용하는 효율적인 프로그래밍 언어를 채용하는 것이 반드시 필요해집니다. 이전 논의는 Rust에서의 크로스 컴파일의 간단함에 초점을 맞추었지만, 이는 프로세스의 최초 단계에 불과합니다.

내 작업을 고려할 때, 고객에게 장치를 관리할 수 있는 인터페이스를 제공하는 것이 흔한 요구사항입니다. 이 측면을 임베디드 웹 서버라고 적절히 표현할 수 있습니다.

이 주제에 대한 정보를 찾기 위해 웹을 뒤지면 다양하고 흥미로운 글과 자습서를 만날 수 있습니다. 그러나 문제는 이러한 리소스의 거의 90%가 내 것보다 훨씬 강력한 하드웨어를 위한 맞춤형 우수한 솔루션을 제공한다는 것입니다. 보통 그들은 다음과 같은 주제를 다룹니다:


<div class="content-ad"></div>

- 백엔드와 프론트엔드의 분리.
- 마이크로서비스 아키텍처 활용.
- 메시지 브로커 구현.
- 고급 데이터베이스 사용.

이러한 측면들은 서버 배포에 기본적으로 중요하지만, 임베디드 리눅스 솔루션에서는 지나치게 복잡할 수 있습니다. 이에 따라 지난 달에 htmx를 탐색하여 더 가벼운 것을 설계하고자 시작했습니다. 임베디드 웹 서버의 제약 사항 내에서 쾌적한 사용자 경험을 보장하기 위함입니다. 오늘은 제가 배운 내용을 공유하고 향후 구현에 대해 이야기하고자 합니다.

## 사용 기술 스택

시작하기 전에, 비교적 간단한 애플리케이션을 구성하는 데 사용할 구성 요소를 살펴봅시다. 이 애플리케이션은 정적 HTML을 제공하지만 htmx로 구동되는 반응성이 있습니다. 사용할 샌드박스 설정은 다음과 유사할 것입니다.

<div class="content-ad"></div>

- Rust: (믿을 수 있니?)
- Axum: 정적 자산을 제공하고 백엔드 API를 구동하기 위해
- Askama: HTML 템플릿팅에 사용되며, 레이아웃, 스크립트, CSS 등을 공유하는 데 도움이 됩니다.
- htmx: UI의 반응성을 위해 사용합니다.
- Tailwind: 내장되어 있다고 해도 미적이어야만 하는 것은 아니죠?

## 첫 번째 설정

먼저 필요한 종속성을 Cargo.toml 파일에 추가해보겠습니다.

```js
[package]
name = "rust-htmx"
authors = ["Davide Ferrero"]
description = "Rust-Axum-Askama-HTMX: 경량 임베디드 웹 서버 만들기"
version = "0.1.0"
edition = "2021"

[dependencies]
anyhow = "1.0.79"
askama = "0.12.1"
axum = "0.7.4"
tokio = { version = "1.36.0", features = ["full"] }
tower = "0.4.13"
tower-http = { version = "0.5.1", features = ["fs"] }
tracing = "0.1.40"
tracing-subscriber = { version = "0.3.18", features = ["env-filter"] }
```

<div class="content-ad"></div>

cargo-watch라는 편리한 핫 리로드 기능을 위해서 cargo-watch를 설치하는 것을 추천해드립니다. 매번 변경사항을 확인하려고 할 때마다 `cargo run`을 입력할 필요가 없어져요. 전역으로 설치하려면, 간단히 `cargo install cargo-watch`를 사용하시면 됩니다. 한 번 설치하면 `cargo-watch -x run`으로 실행할 수 있어요.

이제 우리는 모든 종속성을 다운로드하고 컴파일하기 위해 cargo build를 실행할 준비가 되었어요. 컴파일 중에는 main.rs 파일에서 추적기를 설정하고 구성할 수 있어요.

```rust
use tracing::info;
use tracing_subscriber::{layer::SubscriberExt, util::SubscriberInitExt};

#[tokio::main]
async fn main() {
    tracing_subscriber::registry()
        .with(
            tracing_subscriber::EnvFilter::try_from_default_env()
                .unwrap_or_else(|_| "rust_htmx=debug".into()),
        )
        .with(tracing_subscriber::fmt::layer())
        .init();

    info!("내장 웹 서버가 말합니다: 안녕, 세상아!");
}
```

트레이서를 사용해본 적이 없다면, 제 앱의 이름이 `rust-htmx`이지만 EnvFilrer에서는 `rust_htmx`를 사용해야 한다는 것을 주목하세요. 앱을 실행하면 다음과 같은 내용이 표시될 거예요.

<div class="content-ad"></div>

```js
   Compiling rust-htmx v0.1.0 (C:\Users\davide.ferrero\Documents\Rust\rust-htmx)
    Finished dev [unoptimized + debuginfo] target(s) in 1.88s
     Running `target\debug\rust-htmx.exe`
2024-02-05T14:54:56.118052Z  INFO rust_htmx: Embedded Web Server says: Hello, World!
```

이제 main.rs에서 axum 라우트를 추가하여 askama 템플릿을 제공하겠습니다.

```js
use anyhow::Context;
use askama::Template;
use axum::{
    http::StatusCode,
    response::{Html, IntoResponse, Response},
    routing::get,
    Router,
};
use tracing::info;
use tracing_subscriber::{layer::SubscriberExt, util::SubscriberInitExt};

#[tokio::main]
async fn main() -> anyhow::Result<()> {
    tracing_subscriber::registry()
        .with(
            tracing_subscriber::EnvFilter::try_from_default_env()
                .unwrap_or_else(|_| "rust_htmx=debug".into()),
        )
        .with(tracing_subscriber::fmt::layer())
        .init();

    info!("router init...");

    let router = Router::new().route("/", get(hello));
    let port = 8086_u16;
    let listener = tokio::net::TcpListener::bind(format!("0.0.0.0:{}", port))
        .await
        .unwrap();

    info!("router init complete: now listening on port {}", port);

    axum::serve(listener, router).await.unwrap();

    Ok(())
}

async fn hello() -> impl IntoResponse {
    let template = HelloTemplate {};
    HtmlTemplate(template)
}

#[derive(Template)]
#[template(path = "app.html")]
struct HelloTemplate;

/// Askama로 파싱된 HTML을 axum에서 제공할 수 있는 형태로 캡슐화하는 래퍼 타입입니다.
struct HtmlTemplate<T>(T);

/// Askama HTML 템플릿을 axum에서 응답으로 제공할 수 있도록 변환합니다.
impl<T> IntoResponse for HtmlTemplate<T>
where
    T: Template,
{
    fn into_response(self) -> Response {
        // Askama로 템플릿 렌더링을 시도합니다.
        match self.0.render() {
            // 템플릿을 성공적으로 파싱하고 집계할 수 있는 경우 제공합니다.
            Ok(html) => Html(html).into_response(),
            // 그렇지 않은 경우 에러를 반환하거나 대체 HTML 조각을 제공합니다.
            Err(err) => (
                StatusCode::INTERNAL_SERVER_ERROR,
                format!("Failed to render template. Error: {}", err),
            )
                .into_response(),
        }
    }
}
```

이제 hello 함수 다음에 오류가 발생할 수 있습니다. 이는 Askama가 템플릿 폴더에서 app.html 파일을 찾기 때문입니다. 그러나 현재 이 두 구성 요소가 없습니다. 이를 해결하려면 루트 디렉토리에 templates라는 폴더를 만들고 그 안에 app.html이라는 파일을 생성하십시오. 내용을 자유롭게 추가할 수 있으며, 예를 들어 `h1`인사말: 임베디드 웹 서버로부터`/h1`을 작성했습니다. 이제 코드를 실행하면 localhost:8086에서 유사한 결과를 관찰해야합니다.

<div class="content-ad"></div>

<img src="/assets/img/2024-06-19-SuperfasthttpserverwithRusthtmxpart1_1.png" />

페이지를 보니 개선할 여지가 있네요. 외관을 개선하여 현재에 맞추어 보겠습니다. 저는 다양한 유틸리티를 제공하는 Tailwind를 선호합니다.

Tailwind는 다양한 기술 스택에 대한 통합 가이드를 제공하지만, Axum으로 구성된 Rust 기반의 정적 파일 서빙은 아직 다루지 않았습니다. 걱정하지 마세요. Tailwind의 기본 전략을 활용하여 스타일링을 추가할 수 있습니다.

Tailwind에 익숙하지 않다면 설명서를 참조하고 디자인 시스템 철학을 이해해보세요. 우리는 최적화를 활용할 것이며, Tailwind의 주요 장점 중 하나는 CSS를 최소화하여 번들된 스타일을 간결하게 유지해준다는 점입니다.

<div class="content-ad"></div>

우리는 이제 Tailwind를 프로젝트에 통합하기 위해 프로젝트의 루트 폴더에 간단한 package.json 파일을 생성해야 합니다. npm init을 입력하세요.

```js
{
  "name": "rust-htmx",
  "version": "0.1.0",
  "description": "Rust-Axum-Askama-HTMX: 경량 임베디드 웹 서버 제작",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "Davide Ferrero",
  "license": "ISC"
}
```

패키지 매니페스트가 설정되었으니, 몇 가지 추가를 해보겠습니다.

```js
npm add -D tailwindcss prettier prettier-plugin-tailwindcss
```

<div class="content-ad"></div>

이제 우리는 불필요한 부분을 제거하고 린팅 목적을 위해 빠른 스크립트를 추가하여 JSON을 개선할 수 있습니다.

```js
{
  "name": "rust-htmx",
  "version": "0.1.0",
  "scripts": {
    "format": "prettier --write --ignore-unknown ."
  },
  "license": "ISC",
  "devDependencies": {
    "prettier": "^3.2.5",
    "prettier-plugin-tailwindcss": "^0.5.11",
    "tailwindcss": "^3.4.1"
  }
}
```

이제 터미널에서 npm run format을 실행하여 코드를 포맷할 수 있습니다. 이제 app.html 파일로 돌아가서 몇 가지 추가를 해보겠습니다. 파일 상단의 존재하지 않는 main.css에 대해 걱정하지 마세요. 이 CSS 파일은 Tailwind의 CLI가 생성하는 컴파일된 출력을 저장할 것입니다. CLI는 /templates 디렉토리의 HTML 파일을 스캔하여 불필요한 유틸리티 클래스를 식별하고 제외합니다. 이 최적화는 번들링된 CSS 파일의 크기를 줄여 사용자 브라우저에 전달될 것입니다.

```js
<!doctype html>
<html lang="en">
    <head>
        <link href="/assets/main.css" rel="stylesheet" />
    </head>
    <body>
        <h1 class="text-indigo-500">임베디드 웹 서버에서 인사드립니다!</h1>
    </body>
</html>
```

<div class="content-ad"></div>

이전에 언급했듯이, 이것은 생성된 파일이며 기본적으로 포함되지 않을 수 있습니다. 시작하려면 Tailwind가 HTML 템플릿에서 사용하는 유틸리티를 생성하는 데 사용할 CSS 파일을 추가해야 합니다. styles 디렉토리에 tailwind.css라는 파일을 생성해 봅시다:

```js
@tailwind base;
@tailwind components;
@tailwind utilities;
```

CLI를 활용하여 tailwind.css 파일을 입력으로 읽고, HTML에서 사용된 유틸리티를 분석하고, 제공을 위한 최적화된 스타일시트를 생성할 것입니다. 첫 번째 작업을 시작해 봅시다:

```js
npx tailwindcss -i styles/tailwind.css -o styles/main.css --watch

재빌드 중...

warn - 소스 파일에서 유틸리티 클래스가 감지되지 않았습니다. 이 점이 예상치 않은 것이라면 Tailwind CSS 구성의 'content' 옵션을 다시 확인하세요.
warn - https://tailwindcss.com/docs/content-configuration

182ms 내에 완료되었습니다.
```

<div class="content-ad"></div>

잘 하고 계신데요! 그러나 Tailwind는 제거를 위한 유틸리티 클래스를 감지하지 못했습니다. 이는 우리가 Tailwind가 마크업을 분석하는 것을 안내할 설정 파일이 없기 때문입니다. 한 가지 추가해봅시다:

```js
npx tailwindcss init     

Tailwind CSS 구성 파일 생성됨: tailwind.config.js
```

그리고 생성된 파일에 약간의 수정을 가해봅시다:

```js
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ['./templates/*.html'],
  theme: {
    extend: {},
  },
  plugins: [],
}
```

<div class="content-ad"></div>

그리고 ESLint과의 호환성을 보장하기 위해 확장자를 .cjs로 변경하겠습니다. Tailwind에 익숙하지 않은 분들을 위해 말씀드리자면, 이는 주로 유틸리티 클래스를 찾을 위치를 Tailwind에 지시하는 구성 파일입니다. 이제 main.rs 파일로 돌아와서 Axum에게 Tower 서비스 라우트를 통해 'assets' 폴더에서 Tailwind로 컴파일된 CSS 파일을 제공하도록 지시해야 합니다.

```rust
// 라우터에 assets 추가
let assets_path = std::env::current_dir().unwrap();
let router = Router::new().route("/", get(hello)).nest_service(
    "/assets",
    ServeDir::new(format!("{}/assets", assets_path.to_str().unwrap())),
);
```

Tailwind CLI를 다시 실행하면 main.css 파일이 업데이트되며 페이지를 새로 고치면 인디고 색상으로 된 h1 블록이 최종적으로 표시됩니다.

## 템플릿 구조 확장

<div class="content-ad"></div>

저희 현재 템플릿 생성 시스템에는 필수적인 요소가 부족합니다: 템플릿 상속 기능이 없습니다. 추가적인 Axum 루트들이 HTML을 제공하도록 도입한다면, 각 파일마다 `head` 태그를 포함해야 하는 불편함이 발생할 것입니다. 이는 개발자 경험이 최적화되지 않는 것이죠. 이상적으로는 우리가 공통 head 메타데이터를 포함하는 기본 마크업 파일을 확장할 수 있는 템플릿을 원할 것입니다.

다행히도, Askama가 이 문제에 대한 해결책을 제공합니다. 우리는 개별 루트 템플릿이 확장할 수 있는 기본 템플릿 레이아웃을 정의할 수 있습니다. 모든 템플릿에 중복되는 보일러플레이트 HTML을 줄이고 개발 프로세스를 간소화하기 위해, `base.html` 파일을 생성해 보겠습니다. 이 파일은 모든 공유 head 메타데이터를 포함하여 일관되고 효율적인 접근 방법의 기반이 될 것입니다.

이제 우리는 `app.html`을 다음과 같이 정리할 수 있습니다:

<div class="content-ad"></div>

```js
<!-- prettier-ignore -->
{ extends "base.html" }

{ block title }App{ endblock }

{ block content }
<h1 class="text-indigo-500">임베디드 웹 서버에서 인사드립니다!</h1>
{ endblock }
```

우리가 이제 좋은 확장 가능한 페이지 모델을 갖고 있다는 것을 증명하기 위해, 홈페이지에 라우팅되는 링크가 있는 다른 페이지를 추가해 보겠습니다. 이 새로운 페이지는 아주 잘 지어진 템플릿인 another-page.html을 사용할 것입니다.

```js
<!-- prettier-ignore -->
{ extends "base.html" }

{ block title }다른 페이지!{ endblock }

{ block content }
<h1 class="font-bold text-red-500">다른 페이지</h1>
{ endblock }
```

이제 /another-page 프론트엔드 경로에 액섬 라우트를 통합하여, 사용자가 이 템플릿을 요청했을 때의 응답을 처리해보겠습니다.

<div class="content-ad"></div>


```js
let router = Router::new()
    .route("/", get(hello))
    .route("/another-page", get(another_page))
    .nest_service(
        "/assets",
        ServeDir::new(format!("{}/assets", assets_path.to_str().unwrap())),
    );

........

async fn another_page() -> impl IntoResponse {
    let template = AnotherPageTemplate {};
    HtmlTemplate(template)
}

#[derive(Template)]
#[template(path = "another-page.html")]
struct AnotherPageTemplate;
```

만약 이전에 Tailwind CLI를 중지했다면, 최근에 추가된 스타일로 main.css 파일을 업데이트하려면 다시 시작해야 합니다. 그 이후에 로컬호스트 경로에서 다른 페이지로 직접 이동하면 이제 빨간색으로 스타일이 적용된 두 번째 페이지가 표시될 것입니다. 멋지네요!

## 다음 단계

오늘은 여기까지입니다! 다음 세그먼트에서는 네비게이션 기능을 통합하고 간단한 앱을 향상시키기 위해 몇 가지 흥미로운 htmx 기능을 구현하기 시작할 것입니다. 직접 리포지토리를 다운로드하길 원하시면 여기로 시작할 수 있는 링크가 있습니다. 이 첫 번째 부분이 흥미롭다고 생각되었으면서, 도전적인 문제에 부딪히거나 질문이 있으면 망설이지 말고 문의해 주세요. 다음 시간까지, 감사합니다. 다음 세션에서 뵙겠습니다!
