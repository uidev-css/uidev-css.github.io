---
title: "ASPNET 프로젝트를 IIS에 배포하는 단계별 안내"
description: ""
coverImage: "/assets/img/2024-06-19-AStep-by-StepGuidetoDeployingYourASPNETProjectinIIS_0.png"
date: 2024-06-19 00:32
ogImage: 
  url: /assets/img/2024-06-19-AStep-by-StepGuidetoDeployingYourASPNETProjectinIIS_0.png
tag: Tech
originalTitle: "A Step-by-Step Guide to Deploying Your ASP.NET Project in IIS"
link: "https://medium.com/@binaridissanayake/a-step-by-step-guide-to-deploying-your-asp-net-project-in-iis-3bf5be6366ef"
---


<img src="/assets/img/2024-06-19-AStep-by-StepGuidetoDeployingYourASPNETProjectinIIS_0.png" />

우선, ASP.NET과 IIS가 무엇을 의미하는지 알아봅시다. ASP.NET은 Microsoft에 의해 만들어진 크로스 플랫폼 오픈 소스 웹 프레임워크로, .NET을 기반으로 현대적인 웹 앱 및 서비스를 구축하는 데 사용됩니다.

Internet Information Service (IIS)는 Microsoft가 만든 유연하고 관리가 용이한 웹 서버로, Windows 시스템에서 실행되어 요청된 HTML 페이지나 파일을 제공합니다. IIS는 HTTP, HTTPS, FTP 등 다양한 프로토콜을 지원하며, 요청 처리, 보안, 로깅, 성능 모니터링 등의 중요한 기능을 제공하여 ASP.NET 애플리케이션을 호스팅하는 데 사용됩니다.

ASP.NET 프로젝트를 IIS에 배포하는 것은 개발 환경에서 프로덕션 환경으로 애플리케이션을 옮기는 중요한 단계입니다. IIS를 통해 애플리케이션이 사용자에게 접근 가능하며 강력한 보안 기능과 포괄적인 로깅 및 모니터링 기능을 제공합니다.

<div class="content-ad"></div>

이 가이드에서는 ASP.NET 프로젝트를 IIS에 배포하는 과정을 안내해 드리겠습니다. 배포를 위해 프로젝트를 준비하는 단계부터 IIS 설치 및 구성, 프로젝트 배포, 필요한 설정 구성, 배포 테스트까지 모두 다룰 것입니다. 이러한 단계를 따라하면 ASP.NET 애플리케이션을 성공적으로 배포하고 생산 환경에 준비할 수 있을 것입니다.

단계 1: ASP .NET 애플리케이션 준비하기

- Visual Studio에서 프로젝트 빌드
- 프로젝트를 게시
- 솔루션 탐색기에서 마우스 오른쪽 단추 클릭하고 게시 선택

![이미지](/assets/img/2024-06-19-AStep-by-StepGuidetoDeployingYourASPNETProjectinIIS_1.png)

<div class="content-ad"></div>

- 발행 대화 상자에서 발행 대상으로 "폴더"를 선택합니다.

![이미지](/assets/img/2024-06-19-AStep-by-StepGuidetoDeployingYourASPNETProjectinIIS_2.png)

- 로컬 컴퓨터에 발행된 파일이 저장될 폴더 경로를 지정합니다. 일반적으로 파일이 컴파일되고 배포를 위해 준비되는 임시 폴더입니다.

![이미지](/assets/img/2024-06-19-AStep-by-StepGuidetoDeployingYourASPNETProjectinIIS_3.png)

<div class="content-ad"></div>

- 이제 우리 애플리케이션 빌드가 성공했습니다. 대상 폴더에 파일을 확인할 수 있습니다.

![이미지 설명](/assets/img/2024-06-19-AStep-by-StepGuidetoDeployingYourASPNETProjectinIIS_4.png)

단계 2: IIS 설치

- 먼저 서버에 IIS가 설치되어 있는지 확인하십시오. 그렇지 않은 경우 다음 링크를 클릭하여 IIS를 설치하십시오.

<div class="content-ad"></div>

Step 3: IIS로 프로젝트 배포하기

서버로 파일 복사하기:

- 게시된 파일이 있는 로컬 컴퓨터의 파일 탐색기 창을 엽니다.
- 게시된 파일들(보통 게시된 폴더 안의 모든 것)을 모두 선택합니다.

<div class="content-ad"></div>

서버에 새 폴더를 만드세요:

- IIS가 설치된 서버에 원격 데스크톱 또는 다른 원격 액세스 방법을 사용하여 연결하세요.
- 서버에서 C:\inetpub\wwwroot로 이동하세요.
- wwwroot 디렉토리 내에서 마우스 오른쪽 버튼을 클릭하세요.
- 컨텍스트 메뉴에서 "새 폴더"를 선택하세요.
- 새 폴더에 웹사이트 이름(예: MyAspNetApp)으로 폴더 이름을 지정하세요.

발행된 파일 붙여넣기:

- C:\inetpub\wwwroot 내에 생성된 새 폴더(MyAspNetApp)를 더블 클릭하여 엽니다.
- 로컬 컴퓨터에서 복사한 파일과 폴더를 서버의 이 디렉토리에 붙여넣으세요.

<div class="content-ad"></div>

파일 전송 확인:

- ASP.NET 프로젝트의 모든 파일과 폴더가 서버의 C:\inetpub\wwwroot\MyAspNetApp으로 성공적으로 복사되었는지 확인하세요.

단계 4: IIS 구성

- 이제 제어판에서 IIS 관리자를 검색하세요. 그런 다음 다음과 같은 인터페이스가 표시됩니다. (서버에 관리자 권한이 있는지 확인하세요.)

<div class="content-ad"></div>


![Step 1](/assets/img/2024-06-19-AStep-by-StepGuidetoDeployingYourASPNETProjectinIIS_5.png)

- 그런 다음 서버 이름을 마우스 오른쪽 버튼으로 클릭한 후 웹 사이트 추가를 클릭하세요.

![Step 2](/assets/img/2024-06-19-AStep-by-StepGuidetoDeployingYourASPNETProjectinIIS_6.png)

- 웹 사이트 이름을 지정하고 애플리케이션 빌드가 배치된 물리적 경로를 제공하세요(예: C:\inetpub\wwwroot\MyAspNetApp).


<div class="content-ad"></div>


![A Step-by-Step Guide to Deploying Your ASP.NET Project in IIS 7](/assets/img/2024-06-19-AStep-by-StepGuidetoDeployingYourASPNETProjectinIIS_7.png)

- Give the website host name also.

![A Step-by-Step Guide to Deploying Your ASP.NET Project in IIS 8](/assets/img/2024-06-19-AStep-by-StepGuidetoDeployingYourASPNETProjectinIIS_8.png)

Step 4: Editing the Hosts File to Map IP Address to Hostname


<div class="content-ad"></div>

- C 드라이브를 열고 시스템 32 폴더를 찾아주세요. 드라이버 폴더를 열고, 그 후에 etc. 폴더를 열어주세요. 그리고 'Host' 파일을 열어주세요. (C:\Windows\System32\drivers\etc)

![이미지](/assets/img/2024-06-19-AStep-by-StepGuidetoDeployingYourASPNETProjectinIIS_9.png)

- 메모장을 사용하여 호스트 파일을 열어주세요.

호스트 파일 편집:

<div class="content-ad"></div>

- 호스트 파일의 맨 아래에 IP 주소와 매핑하려는 호스트 이름을 가진 새로운 줄을 추가하세요. 예를 들어:
192.168.1.100 idenitymanagement.com

![이미지](/assets/img/2024-06-19-AStep-by-StepGuidetoDeployingYourASPNETProjectinIIS_10.png)

- 192.168.1.100을 서버의 IP 주소로, idenitymanagement.com을 ASP.NET 응용 프로그램에 대한 원하는 호스트 이름으로 바꿔주세요.

이제 IIS 관리자로 이동하여 웹 사이트를 찾아보세요. 마우스 오른쪽 버튼 클릭 - `웹 사이트 관리 -` 둘러보기

<div class="content-ad"></div>


![Step 1](/assets/img/2024-06-19-AStep-by-StepGuidetoDeployingYourASPNETProjectinIIS_11.png)

Now the application is live in IIS.

![Step 2](/assets/img/2024-06-19-AStep-by-StepGuidetoDeployingYourASPNETProjectinIIS_12.png)

References


<div class="content-ad"></div>

https://learn.microsoft.com/en-us/iis/application-frameworks/scenario-build-an-aspnet-website-on-iis/configuring-step-1-install-iis-and-asp-net-modules

https://www.c-sharpcorner.com/article/deploying-asp-net-mvc-application-on-iis-server/