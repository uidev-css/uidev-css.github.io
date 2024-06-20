---
title: "ASPNET Minimal API를 사용하여 단축 URL 앱 만들기 "
description: ""
coverImage: "/assets/img/2024-06-19-BuildaShortenedURLAppUsingASPNETMinimalAPI_0.png"
date: 2024-06-19 08:17
ogImage: 
  url: /assets/img/2024-06-19-BuildaShortenedURLAppUsingASPNETMinimalAPI_0.png
tag: Tech
originalTitle: "Build a Shortened URL App Using ASP.NET Minimal 🚀API"
link: "https://medium.com/@shahedbd/build-a-shortened-url-app-using-asp-net-minimal-api-d2572d6fd75a"
---


오늘날의 디지털 세상에서 URL 단축 서비스는 긴 웹 주소를 관리하고 공유하기 쉽게 만들기 위해 필수적입니다. 이러한 서비스는 URL의 가독성을 향상시키는 것뿐만 아니라 마케터와 개발자들을 위한 추적 기능과 분석을 제공합니다. 자신만의 URL 단축 서비스를 구축하고 싶다면, ASP.NET Minimal API를 사용하면 간소화되고 효율적인 방법으로 이를 달성할 수 있습니다.

![이미지](/assets/img/2024-06-19-BuildaShortenedURLAppUsingASPNETMinimalAPI_0.png)

본 안내서는 ASP.NET Minimal API를 사용하여 URL 단축 애플리케이션을 만드는 과정을 안내합니다. 프로젝트 설정부터 URL을 단축하고 리다이렉트하는 엔드포인트를 만드는 방법까지 모두 다룰 것이며, 최소 API의 단순함과 성능 장점을 활용할 것입니다.

경험 많은 ASP.NET 개발자이거나 막 시작한 분이든, 본 튜토리얼을 통해 견고하고 확장 가능한 URL 단축 서비스를 구축하는 데 필요한 지식을 습득할 수 있습니다. 지금 바로 시작해봅시다! 🚀

<div class="content-ad"></div>

아래는 Markdown 형식으로 표로 변경한 내용입니다.

![이미지](/assets/img/2024-06-19-BuildaShortenedURLAppUsingASPNETMinimalAPI_1.png)

ASP.NET Minimal API를 이용하여 URL 단축 애플리케이션을 만드는 작업은 몇 가지 중요한 단계로 이루어져 있습니다: 프로젝트 설정, 서비스 생성, URL을 단축하고 리디렉션하기 위한 엔드포인트 생성, URL 매핑 관리 등이 있습니다.

다음은 단계별 가이드입니다:

## Step 1: 새 ASP.NET Minimal API 프로젝트 만들기

<div class="content-ad"></div>

먼저 .NET CLI를 사용하여 새 ASP.NET Minimal API 프로젝트를 만들어 보세요:

```js
dotnet new web -o ShortenedUrlAPIApp
cd ShortenedUrlAPIApp
```

<img src="/assets/img/2024-06-19-BuildaShortenedURLAppUsingASPNETMinimalAPI_2.png" />

# 단계 2: URL 매핑 모델 정의하기

<div class="content-ad"></div>

간단한 모델을 만들어서 원본 URL과 그에 대한 단축판을 저장하는 클래스를 추가하세요. `ShortenedUrl.cs`라는 새 클래스 파일을 만들어주세요:

```csharp
public class ShortenedUrl
{
    public Guid Id { get; set; }
    public string LongUrl { get; set; } = string.Empty;
    public string ShortUrl { get; set; } = string.Empty;
    public string Code { get; set; } = string.Empty;
    public DateTime CreatedOnUtc { get; set; }
}
```

# 단계 3: Entity Framework ORM 설정

URL 매핑 데이터를 관리하기 위해 MSSQL 데이터베이스와 함께 Entity Framework를 사용할 것입니다.

<div class="content-ad"></div>

<img src="/assets/img/2024-06-19-BuildaShortenedURLAppUsingASPNETMinimalAPI_3.png" />

MSSQL Database Connection: appsettings.json

```json
{
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft.AspNetCore": "Warning"
    }
  },
  "AllowedHosts": "*",
  "ConnectionStrings": {
    "connMSSQLNoCred": "Server=DESKTOP-HLGBAEE\\MSSQLSERVER2017;Database=ShortenedUrlAPIApp;Trusted_Connection=True;MultipleActiveResultSets=true;TrustServerCertificate=true",
    "connMSSQL": "Server=DESKTOP-99Q87I2\\MSSQLSERVER2017;Database=ShortenedUrlAPIApp;User ID=sa;Password=dev123456;MultipleActiveResultSets=true;TrustServerCertificate=true"
  }
}
```

### Step 4: Create Services to Generate Unique Codes

<div class="content-ad"></div>

단축된 URL에 대한 고유 코드를 생성하는 서비스를 추가하는 것은 각 단축된 URL이 고유하다는 것을 보장하기 위한 중요한 단계입니다. 이 서비스는 문자열을 무작위로 생성하고 데이터베이스에 이미 존재하는지 확인합니다. 이미 존재한다면 고유한 코드가 발견될 때까지 새로운 코드를 생성합니다.

![image](/assets/img/2024-06-19-BuildaShortenedURLAppUsingASPNETMinimalAPI_4.png)

# 단계 5: 엔드포인트 구성

Program.cs 파일을 열고 URL을 단축하고 원본 URL로 리디렉션하기 위한 엔드포인트를 설정하세요.

<div class="content-ad"></div>

<img src="/assets/img/2024-06-19-BuildaShortenedURLAppUsingASPNETMinimalAPI_5.png" />

# 단계 6: 애플리케이션 실행

.NET CLI를 사용하여 애플리케이션을 실행하세요:

```js
dotnet run
```

<div class="content-ad"></div>


![2024-06-19-BuildaShortenedURLAppUsingASPNETMinimalAPI_6](/assets/img/2024-06-19-BuildaShortenedURLAppUsingASPNETMinimalAPI_6.png)

![2024-06-19-BuildaShortenedURLAppUsingASPNETMinimalAPI_7](/assets/img/2024-06-19-BuildaShortenedURLAppUsingASPNETMinimalAPI_7.png)

![2024-06-19-BuildaShortenedURLAppUsingASPNETMinimalAPI_8](/assets/img/2024-06-19-BuildaShortenedURLAppUsingASPNETMinimalAPI_8.png)

ASP.NET Minimal API를 사용하여 URL 단축기를 만드는 것은 현대의 웹 개발 도구의 강력함과 효율성을 보여줍니다. 최소한의 부가 코드와 간단한 구성으로 ASP.NET Minimal API를 사용하면 신속하게 기능적이고 확장 가능한 애플리케이션을 생성할 수 있습니다. 이 튜토리얼에서는 프로젝트 설정, 필요한 모델 정의, 엔드포인트 생성 및 MSSQL 데이터베이스에서 URL 매핑 처리하는 것을 안내했습니다.


<div class="content-ad"></div>

ASP.NET Minimal API를 활용하면 마이크로서비스 및 소규모 애플리케이션에 이상적인 가벼운 프레임워크의 혜택을 누릴 수 있어요. 이 기초를 바탕으로, 영구 저장소, 사용자 정의 URL 슬러그, 자세한 분석과 같은 기능을 손쉽게 추가할 수 있어요. 여기에서 다루는 기술과 개념은 다른 많은 웹 개발 프로젝트에도 적용할 수 있어요.

이제 ASP.NET Minimal API의 기능을 보여주는 완전히 기능적인 URL 단축 서비스가 준비되었어요. 계속해서 실험하고 최적화하며, 이 프로젝트를 특정 요구에 맞춰 발전시켜 보세요.

코딩 즐기세요! 🚀

👋 .NET 어플리케이션 모음
🚀 내 유튜브 채널
💻 내 깃허브
👉 전체 프로젝트