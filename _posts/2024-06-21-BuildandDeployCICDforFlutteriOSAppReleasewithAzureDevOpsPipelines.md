---
title: "Azure DevOps 파이프라인을 사용하여 Flutter iOS 앱을 빌드하고 배포하는 CICD 가이드"
description: ""
coverImage: "/assets/img/2024-06-21-BuildandDeployCICDforFlutteriOSAppReleasewithAzureDevOpsPipelines_0.png"
date: 2024-06-21 23:07
ogImage: 
  url: /assets/img/2024-06-21-BuildandDeployCICDforFlutteriOSAppReleasewithAzureDevOpsPipelines_0.png
tag: Tech
originalTitle: "Build and Deploy CI CD for Flutter iOS App Release with Azure DevOps Pipelines"
link: "https://medium.com/@binasadw/setting-up-ci-cd-for-flutter-ios-app-release-with-azure-devops-pipelines-30ee0eab0729"
---


인디 소프트웨어 개발자로서, 내 Flutter 앱을 App Store에 고객에게 제공하는 것은 불가능한 일처럼 보였어요. 인증서를 관리하고, App Store Connect를 탐색하고, 테스트 릴리스를 구성하는 사이에, 진전이 없이 몇 일 동안 좌절했죠.

Azure 파이프라인을 활용하여, 제가 iOS 배포를 위한 신뢰할 수 있고 반복 가능한 CI/CD 워크플로우를 설정할 수 있었어요. 더 이상 주말을 낭비하여 앱 업데이트를 수동으로 빌드, 테스트, 발행할 필요가 없어요.

이제 매번 커밋이 자동 빌드와 테스트 통과, 그리고 TestFlight로 피드백을 받는 릴리스를 발생시켜요. 

이 가이드는 얻어온 경험, 시행착오, 여러 번의 반복을 토대로 작성했어요. 제 목표는 동료 iOS 개발자들이 겪은 고통을 덜어드리는 거예요. 여기서 상세하고 실행 가능한 단계를 제시함으로써, 여러분은 iOS 애플리케이션을 위한 간소화된 CI/CD 파이프라인을 세우는 데 필요한 도구를 갖추게 될 거예요.

<div class="content-ad"></div>

# 전제 조건

- 활성화된 Apple 개발자 계정과 ​​App Store Connect 액세스
- XCode에서의 iOS 앱 프로젝트
- Azure DevOps 조직에 대한 액세스
- IOS 앱 서명 프로세스를 시작하기 위한 p12 및 모바일 Provisional 인증서에 대한 액세스

Azure DevOps Marketplace

- Apple App Store 확장 프로그램https://marketplace.visualstudio.com/items?itemName=ms-vsclient.app-store을 설치하십시오. 이를 통해 App Store API와 통합할 수 있습니다.
- Azure DevOps Marketplace에서 Flutter https://marketplace.visualstudio.com/items?itemName=Hey24sheep.flutter 확장 프로그램을 설치하십시오. 이를 통해 Flutter 앱을 빌드할 수 있습니다.

<div class="content-ad"></div>

# iOS 서명 인증서 설정하기

P12 인증서 생성하기

iOS 앱에 서명하기 위해 필요한 P12 인증서를 생성하는 방법에 대한 자세한 설명은 다음 문서를 활용해주세요: [iOS 앱을 서명하기 위한 CSR 및 P12 인증서 생성 방법](https://www.cheapsslsecurity.com).

해당 문서는 iOS 앱을 서명하기 위해 필요한 p12 인증서를 생성하는 방법에 대한 상세한 지침을 제공합니다.

<div class="content-ad"></div>

프로비저닝 프로필 생성하기

애플 개발자 페이지에서 Certificates, Identifiers & Profiles(`아이덴티파이어`) 섹션으로 이동하세요.

- Profiles에서 새 프로필을 추가하려면 클릭하세요.
- 앱을 앱 스토어에 제출하기 위한 배포용 프로비저닝 프로필을 생성하려면 App Store를 선택하세요.
- 계속해서 `Your_APP_ID` 앱 식별자를 선택하세요.
- 계속해서 프로비저닝 프로필을 생성하고 저장하고 다운로드하세요.

# Azure 파이프라인 설정하기

<div class="content-ad"></div>

- Azure DevOps 프로젝트에서, 파이프라인 `라이브러리` 보안 파일로 이동해 "mobileProvisional" 및 "p12" 인증서를 추가하세요. 이전에 생성한 인증서입니다.

![이미지](/assets/img/2024-06-21-BuildandDeployCICDforFlutteriOSAppReleasewithAzureDevOpsPipelines_0.png)

2. Pipelines로 이동하여 `새 파이프라인 생성` 을 클릭하세요.

![이미지](/assets/img/2024-06-21-BuildandDeployCICDforFlutteriOSAppReleasewithAzureDevOpsPipelines_1.png)

<div class="content-ad"></div>

2. 옵션으로 "전통적인 편집기 사용"을 선택합니다

![이미지](/assets/img/2024-06-21-BuildandDeployCICDforFlutteriOSAppReleasewithAzureDevOpsPipelines_2.png)

3. Azure 저장소를 선택합니다

![이미지](/assets/img/2024-06-21-BuildandDeployCICDforFlutteriOSAppReleasewithAzureDevOpsPipelines_3.png)

<div class="content-ad"></div>

4. "빈 작업"을 선택합니다.

![이미지](/assets/img/2024-06-21-BuildandDeployCICDforFlutteriOSAppReleasewithAzureDevOpsPipelines_4.png)

5. "+" 버튼을 클릭하고 파이프라인에 다음과 같은 라이트 그레이 작업을 추가하고 각 작업의 세부 정보를 모두 입력합니다. 아래의 YAML 파일을 참조로 사용해주세요.

- 에이전트에서 실행을 선택하고 에이전트 풀을 "Azure Pipelines"로 지정하고 에이전트 사양을 "macos-latest"로 지정합니다.
- 파이프라인을 준비한 후에 "저장 및 대기열"을 클릭하여 파이프라인을 트리거합니다.

<div class="content-ad"></div>


![이미지](/assets/img/2024-06-21-BuildandDeployCICDforFlutteriOSAppReleasewithAzureDevOpsPipelines_5.png)

아래는 참고용 yaml 코드입니다.

```js
pool:
  name: Azure Pipelines
  demands: xcode

steps:
- task: JavaToolInstaller@0
  displayName: 'Java 11 사용'
  inputs:
    versionSpec: 11
    jdkArchitectureOption: x64
    jdkSourceOption: PreInstalled

- task: InstallAppleCertificate@2
  displayName: 'P12 인증서 설치'
  inputs:
    certSecureFile: '<인증서_파일>'
    certPwd: '<비밀번호>'
    setUpPartitionIdACLForPrivateKey: false

- task: InstallAppleProvisioningProfile@1
  displayName: '프로비저닝 프로필 설치'
  inputs:
    provProfileSecureFile: '<프로비저닝_파일>'

- task: Hey24sheep.flutter.flutter-install.FlutterInstall@0
  displayName: 'Flutter 설치'
  inputs:
    version: custom
    customVersion: 3.7.9

- task: Hey24sheep.flutter.flutter-command.FlutterCommand@0
  displayName: 'Flutter Clean'
  inputs:
    arguments: clean

- task: Hey24sheep.flutter.flutter-build.FlutterBuild@0
  displayName: 'Flutter iOS 빌드'
  inputs:
    target: ios
    buildFlavour: prod
    buildNumber: '$(Build.BuildNumber)'
    entryPoint: 'lib/main_prod.dart'
    iosCodesign: false

- task: Xcode@5
  displayName: 'Xcode 빌드 prod'
  inputs:
    configuration: 'Release-prod'
    sdk: iphoneos
    xcWorkspacePath: '**/Runner.xcworkspace'
    scheme: prod
    packageApp: true
    archivePath: ./build/ios/iphoneos/Runner.xcarchive
    exportPath: ./build/ios/iphoneos/Runner.ipa
    exportOptions: plist
    exportOptionsPlist: ./ios/ExportOptions.plist
    signingOption: manual
    signingIdentity: '$(APPLE_CERTIFICATE_SIGNING_IDENTITY)'
    provisioningProfileUuid: '$(APPLE_PROV_PROFILE_UUID)'

- task: CopyFiles@2
  displayName: '파일 복사'
  inputs:
    SourceFolder: .
    Contents: '**/*.ipa'
    TargetFolder: '$(Build.ArtifactStagingDirectory)'

- task: PublishBuildArtifacts@1
  displayName: 'Prod Artifact 게시'
  inputs:
    ArtifactName: 'ios ipa'
```

상기 파이프라인은 여러분의 파이프라인 내에서 아티팩트를 게시하며, 이를 이후 배포 파이프라인에서 사용할 것입니다.


<div class="content-ad"></div>


![image](/assets/img/2024-06-21-BuildandDeployCICDforFlutteriOSAppReleasewithAzureDevOpsPipelines_6.png)

# Azure 서비스 연결 생성하기

Azure 앱 스토어 익스텐션을 사용하려면 앱 스토어에 앱을 게시할 수 있는 액세스 권한이 있는 서비스 자격 증명이 필요합니다. 계정에는 '앱 관리자 또는 관리자' 역할이 설정되어야 합니다.

- DevOps 프로젝트에서 프로젝트 설정으로 이동합니다.
- 서비스 연결 탭을 선택합니다.
- 새 서비스 연결을 추가하고 Apple App Store를 선택합니다.
- 새 연결에 이름을 지정하고 Apple 계정의 자격 증명을 입력합니다.
- 앱별 패스워드를 제공합니다 (계정이 2단계 인증을 사용 중인 경우). 계정이 2단계 인증을 사용하지 않는 경우 이 값을 전달할 필요가 없습니다.


<div class="content-ad"></div>

이 서비스 연결 이름은 파이프라인 릴리스 단계에서 사용할 수 있습니다.

## 이중 인증 프로세스

게시 계정에서 특정 응용 프로그램 비밀번호를 만들어야 합니다.

- http://appleid.apple.com/account/manage에 방문
- 새로운 응용 프로그램별 비밀번호를 생성
- 위 단계에서 사용할 이 비밀번호를 메모하세요

<div class="content-ad"></div>

# 앱 스토어 릴리스 파이프라인 설정

- Azure DevOps 프로젝트에서 파이프라인으로 이동하여 `릴리스` 새 릴리스 파이프라인을 만들고 템플릿을 "빈 작업"으로 선택합니다.
- "아티팩트 추가"를 선택한 다음 위에서 만든 파이프라인을 선택합니다. (이 아티팩트는 App Store Connect에 업로드하는 데 사용됩니다)

![이미지](/assets/img/2024-06-21-BuildandDeployCICDforFlutteriOSAppReleasewithAzureDevOpsPipelines_7.png)

- 스테이지에 빈 작업을 추가하고 아래의 작업 "Apple App Store 릴리스"를 추가합니다.

<div class="content-ad"></div>

- 에이전트에서 실행을 선택하고 에이전트 풀을 "Azure 파이프라인"으로 지정하고 에이전트 사양을 "macos-latest"로 지정합니다.
- 위에서 만든 서비스 연결을 선택합니다.
- 작업에서 빌드 처리 대기를 건너뜁니다.
- 앱 정보 내부에있는 번들 ID 및 App 특정 Apple ID를 추가합니다. 번들 ID 및 App 특정 Apple ID는 https://appstoreconnect.apple.com/ 에서 찾을 수 있습니다.
- 세 점을 클릭하여 아티팩트의 이진 경로를 선택합니다.

![이미지](/assets/img/2024-06-21-BuildandDeployCICDforFlutteriOSAppReleasewithAzureDevOpsPipelines_8.png)

4. 새 릴리스를 생성하면 로그에서 다음과 같은 성공 메시지가 표시됩니다. 이것은 아티팩트가 앱 스토어 커넥트 'Test Flight'에 업로드되었음을 확인합니다.

![이미지](/assets/img/2024-06-21-BuildandDeployCICDforFlutteriOSAppReleasewithAzureDevOpsPipelines_9.png)

<div class="content-ad"></div>

# 앱 스토어 테스트 플라이트 확인

![이미지](/assets/img/2024-06-21-BuildandDeployCICDforFlutteriOSAppReleasewithAzureDevOpsPipelines_10.png)

그리고 이것으로 iOS 앱을 위한 CI/CD를 구현하는 시작부터 끝까지의 가이드를 마무리합니다! 제 경험을 경험하면서 유용한 통찰을 얻을 수 있기를 바랍니다. 개발 단계에서 적용할 수 있도록 도움이 되기를 바랍니다.