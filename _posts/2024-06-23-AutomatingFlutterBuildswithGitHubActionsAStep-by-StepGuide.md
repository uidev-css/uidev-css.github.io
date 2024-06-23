---
title: "GitHub Actions로 Flutter 빌드 자동화 단계별 가이드"
description: ""
coverImage: "/assets/img/2024-06-23-AutomatingFlutterBuildswithGitHubActionsAStep-by-StepGuide_0.png"
date: 2024-06-23 14:45
ogImage: 
  url: /assets/img/2024-06-23-AutomatingFlutterBuildswithGitHubActionsAStep-by-StepGuide_0.png
tag: Tech
originalTitle: "Automating Flutter Builds with GitHub Actions: A Step-by-Step Guide"
link: "https://medium.com/@colonal/automating-flutter-builds-and-releases-with-github-actions-77ccf4a1ccdd"
---


![이미지](/assets/img/2024-06-23-AutomatingFlutterBuildswithGitHubActionsAStep-by-StepGuide_0.png)

안녕하세요! 이 기사에서는 GitHub Actions를 활용하여 Flutter 앱의 빌드 및 릴리스 프로세스를 자동화하는 방법을 알아볼 거에요. 이 방법을 통해 연속적인 통합/배포(CI/CD) 파이프라인을 유지할 수 있어 개발에 집중할 수 있게 해주죠. GitHub Actions가 빌드와 애플리케이션 릴리스를 처리하는 동안 무거운 작업을 자동으로 처리해줍니다.

# 소개

자동화는 현대 소프트웨어 개발의 중요한 구성 요소로, 개발자가 반복 작업을 간소화하고 인적 오류를 줄일 수 있게 해줍니다. Flutter 개발자들에게는 빌드 및 릴리스 프로세스를 자동화하면 생산성을 크게 향상시키고 일관된 배포를 보장할 수 있습니다. GitHub Actions는 GitHub 저장소에서 직접 워크플로를 자동화할 수 있는 강력한 플랫폼을 제공합니다. 이 기사에서는 Android 및 iOS 플랫폼용 Flutter 앱의 빌드 및 릴리스를 처리하며 버전 관리 및 keystore 관리까지 다루는 GitHub Actions 워크플로를 생성해볼 거에요.

<div class="content-ad"></div>

# 워크플로우 설정하기

이전에 언급했듯이 Github Actions와 함께 작업할 것이므로, 먼저 프로젝트를 위한 Github Repo를 생성해야 합니다. 프로젝트의 이름을 flutterGitHubAction으로 지정합시다.

![이미지 1](/assets/img/2024-06-23-AutomatingFlutterBuildswithGitHubActionsAStep-by-StepGuide_1.png)

![이미지 2](/assets/img/2024-06-23-AutomatingFlutterBuildswithGitHubActionsAStep-by-StepGuide_2.png)

<div class="content-ad"></div>

```js
$ git init
$ git add .
$ git commit -m "init app"
$ git remote add origin https://github.com/colonal/flutterGitHubAction.git
$ git push -u origin master
```

![image](/assets/img/2024-06-23-AutomatingFlutterBuildswithGitHubActionsAStep-by-StepGuide_3.png)

![image](/assets/img/2024-06-23-AutomatingFlutterBuildswithGitHubActionsAStep-by-StepGuide_4.png)

이제 사랑하는 VSCode로 돌아가서 작업을 시작해봅시다.

<div class="content-ad"></div>

- 프로젝트의 루트 폴더에 " .github "라는 새 디렉토리를 만듭니다.
- 새로 만든 디렉토리 아래에 또 다른 새 디렉토리를 만들고 " workflows "라고 이름 짓습니다.
- 마지막으로 workflows 디렉토리 안에 " main.yml "이라는 새 파일을 만듭니다.

![이미지](/assets/img/2024-06-23-AutomatingFlutterBuildswithGitHubActionsAStep-by-StepGuide_5.png)

- 이제 필요한 workflow를 작성해 봅시다.

```js
name: "Build & Release"   # 필요에 맞게 이름을 지정하세요
```

<div class="content-ad"></div>

- 이것은 GitHub Actions에서 실행하려는 workflow의 이름입니다.

```js
on:
  pull_request:
    branches:
      - dev
      - test
  push:
    branches:
      - dev
      - test 
```

- 이 작업을 트리거하고 싶은 경우들이며, 여기에서는 2가지 경우 [pull_request 및 push]에 대해 설정했으며, 청취하고 트리거할 브랜치를 지정했습니다. 여기에서는 [dev, test] 브랜치로 설정했습니다.
- 이것은 즉, 우리의 작업이 dev 또는 test 브랜치로 뭔가를 푸시하거나 dev 또는 test 브랜치에서 PR을 할 때마다 트리거될 것을 의미합니다.

```js
jobs:  # 어떤 작업이 필요한지 알려주는 부분
  build:      # 작성될 이름과 머신을 지정
    name: Build & Release  # 빌드 이름을 원하시는 대로 지정할 수 있습니다
    runs-on: macos-latest # 여기에서 우리는 ios 빌드를 얻기 위해 macos-latest를 선택했습니다
```

<div class="content-ad"></div>

이제 우리가 거쳐가길 원하는 단계를 구체적으로 지정해야 해요(위에 보여진 대로):

![Step Image](/assets/img/2024-06-23-AutomatingFlutterBuildswithGitHubActionsAStep-by-StepGuide_6.png)

# 1. 저장소 체크아웃

```yaml
- name: Checkout Repository
  uses: actions/checkout@v3
```

<div class="content-ad"></div>

설명: 여기서는 checkout이라는 미리 만들어 둔 작업을 사용하여 저장소 코드를 체크아웃하여 워크플로가 액세스할 수 있게 합니다. 이 작업과 많은 다른 작업은 GitHub Actions marketplace에서 찾을 수 있습니다. 각 작업에 이름을 지정하는 것은 필수는 아니지만 명확성을 위해 유용합니다.

## 2. Java 설정

```yaml
- name: Set Up Java
  uses: actions/setup-java@v3.12.0
  with:
    distribution: 'oracle'
    java-version: '17'
```

설명: 이 단계는 setup-java 작업을 사용하여 필요한 Java 환경을 설정합니다. 'Oracle'를 배포로, '17'을 Java 버전으로 지정합니다. 이는 Android 앱을 빌드하는 데 필요합니다. 모든 사용 가능한 배포본을 여기에서 찾을 수 있습니다.

<div class="content-ad"></div>

# 3. 플러터 설정하기

```js
- name: 플러터 설정
  uses: subosito/flutter-action@v2
  with:
    flutter-version: '3.22.2'
    channel: 'stable'
```

설명: 이 단계에서는 subosito/flutter-action을 사용하여 지정된 버전과 채널로 플러터 환경을 설정합니다. 이렇게 하면 빌드 프로세스 중에 올바른 버전의 플러터를 사용할 수 있습니다.

# 4. 종속성 설치하기

<div class="content-ad"></div>


- name: 의존성 설치
  run: flutter pub get


설명: 이 단계는 플러터 프로젝트에 필요한 종속성을 설치하기 위해 flutter pub get을 실행합니다. 이것은 로컬에서 명령을 실행하는 것과 동일하며, pubspec.yaml 파일에서 지정된 모든 종속성을 해결하는 데 중요합니다.

# 5. 키스토어 설정

Android 앱에 서명하려면 키스토어 파일 및 관련 속성을 안전하게 처리해야 합니다. 저장소에 직접 keystore.jks 파일을 추가하는 대신 (보안에 취약합니다), 해당 파일을 base64 문자열로 변환하여 GitHub 저장소에서 비밀로 저장합니다. 또한 필요한 다른 키스토어 속성을 비밀로 저장합니다. 아래는 자세한 단계입니다:


<div class="content-ad"></div>

## 단계별 안내:

- 키스토어 파일을 Base64로 변환하세요. 다음 명령을 사용하여 keystore.jks 파일을 base64 문자열로 변환하세요:

```js
base64 -w 0 keystore.jks > keystore.jks.base64
```

- keystore.jks.base64 파일의 내용을 복사하세요.
- GitHub 리포지토리에 시크릿 추가하기. 리포지토리 설정으로 이동하여 "Actions"에서 "Secrets and variables"로 이동한 후 다음 시크릿을 추가하세요:

<div class="content-ad"></div>

- KEYSTORE_BASE64: keystore.jks.base64의 내용입니다.
- KEYSTORE_PASSWORD: 키스토어의 비밀번호입니다.
- KEY_ALIAS: 키에 대한 별칭입니다.
- KEY_PASSWORD: 키 별칭의 비밀번호입니다.

![image](/assets/img/2024-06-23-AutomatingFlutterBuildswithGitHubActionsAStep-by-StepGuide_7.png)

## GitHub Actions Workflow 단계:

- Keystore 디코딩

<div class="content-ad"></div>

```yaml
- name: 키스토어 디코드
  run: |
    echo "${ secrets.KEYSTORE_BASE64 }" | base64 --decode > android/app/keystore.jks
```

설명: 이 단계는 GitHub 저장소에 저장된 시크릿을 사용하여 base64로 인코딩된 키스토어를 디코딩합니다. 디코딩된 키스토어는 android/app/keystore.jks에 저장됩니다. Android 앱을 서명하는 데 필요합니다.

2. key.properties 파일 생성하기

```yaml
- name: key.properties 파일 생성
  run: |
    echo "storePassword=${ secrets.KEYSTORE_PASSWORD }" > android/key.properties
    echo "keyPassword=${ secrets.KEY_PASSWORD }" >> android/key.properties
    echo "keyAlias=${ secrets.KEY_ALIAS }" >> android/key.properties
    echo "storeFile=keystore.jks" >> android/key.properties
```

<div class="content-ad"></div>

설명: 이 단계에서는 애플리케이션을 서명하는 데 필요한 속성을 갖는 key.properties 파일이 생성됩니다. 이러한 속성은 GitHub 저장소에 저장된 비밀 정보를 사용하여 채워집니다.

# 6. APK 빌드

```js
- name: APK 빌드
  run: flutter build apk --release
```

설명: 이 단계에서는 flutter build apk --release 명령어를 사용하여 Flutter 애플리케이션의 APK를 릴리스 모드로 빌드합니다.

<div class="content-ad"></div>

# 7. 앱 번들 빌드

```yaml
- name: 앱 번들 빌드 실행
  run: flutter build appbundle
```

설명: 이 단계는 flutter build appbundle 명령어를 사용하여 Flutter 애플리케이션의 Android 앱 번들(AAB)을 빌드합니다.

# 8. IPA 빌드(iOS 빌드)

<div class="content-ad"></div>

```yaml
- 이름: IPA 빌드
  실행: flutter build ipa --no-codesign
```

설명: 이 단계는 flutter build ipa --no-codesign 명령을 사용하여 코드 서명 없이 iOS 애플리케이션을 위한 IPA 파일을 빌드합니다. --no-codesign 플래그를 사용하면 로컬 개발을 위해 유효한 Apple 개발자 계정이 필요하지 않고 IPA를 빌드할 수 있습니다.

# 9. 아카이브와 IPA 압축

```yaml
- 이름: 아카이브 및 IPA 압축
  실행: |
    cd build
    tar -czf ios_build.tar.gz ios
```

<div class="content-ad"></div>

# 10. 아티팩트 업로드

```js
- name: 아티팩트 업로드
  uses: actions/upload-artifact@v2
  with:
    name: 릴리즈
    path: |
      build/app/outputs/flutter-apk/app-release.apk
      build/app/outputs/bundle/release/app-release.aab
      build/ios_build.tar.gz
```

설명: 이 단계는 iOS 빌드 디렉토리를 tar.gz 파일로 압축하여 저장 및 전송을 쉽게합니다. 이 단계는 upload-artifact 작업을 사용하여 빌드 아티팩트 (APK, AAB 및 압축된 iOS 빌드)를 업로드하여 나중에 다운로드할 수 있게 합니다. 이를 통해 빌드 출력물을 GitHub Actions 실행 페이지에서 액세스할 수 있습니다.

<div class="content-ad"></div>

# 11. 버전 추출

```js
- name: pubspec.yaml에서 버전 추출
  id: extract_version
  run: |
    version=$(grep '^version: ' pubspec.yaml | cut -d ' ' -f 2 | tr -d '\r')
    echo "VERSION=$version" >> $GITHUB_ENV
```

설명: 이 단계는 pubspec.yaml 파일에서 버전 번호를 추출하고 환경 변수로 설정합니다. grep 명령은 버전 라인을 검색하여 버전 번호를 추출하고 이를 VERSION 환경 변수에 저장합니다.

# 12. 태그의 존재 여부 확인

<div class="content-ad"></div>

```yaml
- name: 태그 여부 확인
  id: check_tag
  run: |
    if git rev-parse "v${ env.VERSION }" >/dev/null 2>&1; then
      echo "TAG_EXISTS=true" >> $GITHUB_ENV
    else
      echo "TAG_EXISTS=false" >> $GITHUB_ENV
    fi
```

설명: 이 단계는 저장소에 버전 태그가 이미 존재하는지 확인합니다. 태그가 있으면 TAG_EXISTS 환경 변수를 true로 설정하고, 그렇지 않으면 false로 설정합니다.

# 13. 태그 수정하기 (태그가 존재하는 경우)

```yaml
- name: 태그 수정
  if: env.TAG_EXISTS == 'true'
  id: modify_tag
  run: |
    new_version="${ env.VERSION }-build-${ github.run_number }"
    echo "VERSION=$new_version" >> $GITHUB_ENV
```

<div class="content-ad"></div>

설명: 이 단계에서는 이미 있는 태그인 경우, 버전 태그를 수정하여 버전 번호에 -build-`run_number`를 추가하여 고유 식별자가 포함되도록 합니다. 이렇게 하면 태그가 고유하게 유지되고 충돌을 피할 수 있습니다.

# 14. 릴리스 생성

```yaml
- name: 릴리스 생성
  uses: ncipollo/release-action@v1
  with:
    artifacts: "build/app/outputs/flutter-apk/app-release.apk,build/app/outputs/bundle/release/app-release.aab,build/ios_build.tar.gz"
    tag: v${ env.VERSION }
    token: ${ secrets.TOKEN }
```

설명: 이 단계에서는 ncipollo/release-action을 사용하여 지정된 아티팩트로 GitHub 릴리스를 생성합니다. (필요한 경우 수정된) 버전을 태그로 사용하고 GitHub 시크릿에 저장된 토큰을 인증에 사용합니다.

<div class="content-ad"></div>

# 마법을 볼 준비가 되셨나요?

```js
$ get add .
$ git commit -m "test github actions" 
$ git push -u origin dev
```

- 변경 사항을 dev 브랜치에 푸시하고 작동하는지 확인해 보세요.
- 레포지토리의 Actions 탭으로 이동해서 확인해 보세요.

![이미지](/assets/img/2024-06-23-AutomatingFlutterBuildswithGitHubActionsAStep-by-StepGuide_8.png)

<div class="content-ad"></div>

# 완성된 Workflow 코드

중요한 메모: 들여쓰기가 중요하니 주의하세요

```js
name: "Build"

on:
  pull_request:
    branches:
      - dev
      - test
  push:
    branches:
      - dev
      - test

jobs:  
  build:      
    name: Build & Release 
    runs-on: macos-latest 

    steps:
        #1 저장소 체크아웃
      - name: 저장소 체크아웃
        uses: actions/checkout@v3

        #2 Java 설정
      - name: Java 설정
        uses: actions/setup-java@v3.12.0
        with:
          distribution: 'oracle'
          java-version: '17'

        #3 Flutter 설정
      - name: Flutter 설정
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.22.2'
          channel: 'stable'

        #4 종속성 설치
      - name: 종속성 설치
        run: flutter pub get

        #5 Keystore 설정
      - name: Keystore 디코딩
        run: |
          echo "${ secrets.KEYSTORE_BASE64 }" | base64 --decode > android/app/keystore.jks
          
      - name: key.properties 생성
        run: |
          echo "storePassword=${ secrets.KEYSTORE_PASSWORD }" > android/key.properties
          echo "keyPassword=${ secrets.KEY_PASSWORD }" >> android/key.properties
          echo "keyAlias=${ secrets.KEY_ALIAS }" >> android/key.properties
          echo "storeFile=keystore.jks" >> android/key.properties
        
       #6 APK 빌드
      - name: APK 빌드
        run: flutter build apk --release

        #7 App Bundle (aab) 빌드
      - name: App Bundle 빌드
        run: flutter build appbundle

        #8 IPA 빌드 (iOS 빌드)
      - name: IPA 빌드
        run: flutter build ipa --no-codesign

      - name: 아카이브 및 IPA 압축
        run: |
          cd build
          tar -czf ios_build.tar.gz ios

        #9 아티팩트 업로드
      - name: 아티팩트 업로드
        uses: actions/upload-artifact@v2
        with:
          name: 릴리스
          path: |
            build/app/outputs/flutter-apk/app-release.apk
            build/app/outputs/bundle/release/app-release.aab
            build/ios_build.tar.gz

        #10 버전 추출
      - name: pubspec.yaml에서 버전 추출
        id: extract_version
        run: |
          version=$(grep '^version: ' pubspec.yaml | cut -d ' ' -f 2 | tr -d '\r')
          echo "VERSION=$version" >> $GITHUB_ENV

        #11 태그 확인
      - name: 태그 확인
        id: check_tag
        run: |
          if git rev-parse "v${ env.VERSION }" >/dev/null 2>&1; then
            echo "TAG_EXISTS=true" >> $GITHUB_ENV
          else
            echo "TAG_EXISTS=false" >> $GITHUB_ENV
          fi

        #12 태그 수정
      - name: 태그 수정
        if: env.TAG_EXISTS == 'true'
        id: modify_tag
        run: |
          new_version="${ env.VERSION }-build-${ github.run_number }"
          echo "VERSION=$new_version" >> $GITHUB_ENV
        
        #13 릴리스 생성
      - name: 릴리스 생성
        uses: ncipollo/release-action@v1
        with:
          artifacts: "build/app/outputs/flutter-apk/app-release.apk,build/app/outputs/bundle/release/app-release.aab,build/ios_build.tar.gz"
          tag: v${ env.VERSION }
          token: ${ secrets.TOKEN }
```

위 단계를 따라 완성된 Workflow 코드를 사용하면 Flutter 빌드 및 릴리스 프로세스를 자동화하여 CI/CD 파이프라인에서 일관성과 효율성을 확보할 수 있습니다.

<div class="content-ad"></div>

## 이제 첫 CI/CD 워크플로를 만들었어요, 축하드려요 🥳🥳