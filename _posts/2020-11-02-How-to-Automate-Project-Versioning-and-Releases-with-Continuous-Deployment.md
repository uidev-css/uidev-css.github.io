---
layout: post
title: "지속적 배포를 통해 프로젝트 버전 관리 및 릴리스를 자동화하는 방법
    "
author: "CSS Dev"
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/10/senantic-versioning-github-actions.jpg
tags: COMMIT,CONTINUOUS INTEGRATION,GITHUB ACTIONS,VERSION CONTROL
---

의미에 따라 버전이 지정된 소프트웨어를 사용하면 소프트웨어의 변경 사항을 쉽게 유지 관리하고 전달할 수 있습니다.
이 작업은 쉽지 않습니다.
PR을 수동으로 병합하고 커밋에 태그를 지정하고 릴리스를 푸시 한 후에도 릴리스 노트를 작성해야합니다.
많은 다른 단계가 있으며 많은 단계가 반복적이며 시간이 걸립니다.

플러그인 시맨틱 버전 관리를 통해 지속적 배포 프로세스로 릴리스 프로세스를 완전히 자동화하고보다 효율적인 흐름을 만드는 방법을 살펴 보겠습니다.

### 시맨틱 버전 관리

의미 체계 버전은 마침표로 구분 된 세 개의 숫자로 구성된 숫자입니다.
예를 들어 `1.4.10`은 시맨틱 버전입니다.
각 숫자에는 특정한 의미가 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_oNLXwEB" src="//codepen.io/anon/embed/oNLXwEB?height=450&amp;theme-id=1&amp;slug-hash=oNLXwEB&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed oNLXwEB" title="CodePen Embed oNLXwEB" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

의미 론적 버전 관리를`Breaking. 기능. 수정`.
해석의 여지를 남기지 않는 버전 번호를보다 정확하게 설명하는 방법입니다.

### 커밋 형식

의미 론적 버전 번호를 올바로 증가시켜 올바른 버전을 릴리스하고 있는지 확인하려면 커밋 메시지를 표준화해야합니다.
커밋 메시지에 대한 표준화 된 형식을 가짐으로써 언제 어떤 숫자를 증가 시킬지 알 수 있고 릴리스 노트를 쉽게 생성 할 수 있습니다.
Angular 커밋 메시지 규칙을 사용할 예정이지만 나중에 다른 것을 선호하는 경우 변경할 수 있습니다.

다음과 같이 진행됩니다.

```html
<header>
    <optional body> <optional footer></optional></optional>
</header>
```

각 커밋 메시지는 머리글, 본문 및 바닥 글로 구성됩니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/10/xye2qRnc.png?resize=817%2C299&ssl=1)

헤더는 필수입니다.
유형, 선택적 범위 및 주제를 포함하는 특수 형식이 있습니다.

헤더의 유형은 커밋 내용이 다음 버전에 미치는 영향을 알려주는 필수 필드입니다.
다음 유형 중 하나 여야합니다.

-   묘기 : 새로운 기능

-   수정 : 버그 수정

-   docs : 문서 변경

-   스타일 : 코드의 의미에 영향을주지 않는 변경 (예 : 공백, 서식 지정, 세미콜론 누락 등)

-   리팩터링 : 버그를 수정하거나 기능을 추가하지 않는 변경

-   perf : 성능을 향상시키는 변경

-   테스트 : 기존 테스트에 누락 된 테스트 또는 수정 사항 추가

-   쵸어 : 문서 생성과 같은 빌드 프로세스 또는 보조 도구 및 라이브러리 변경

범위는 API, 앱의 대시 보드 또는 사용자 계정 등과 같이 커밋이 관련된 하위 시스템을 지정하는 그룹화 속성입니다. 커밋이 둘 이상의 하위 시스템을 수정하는 경우 별표 (`)를 사용할 수 있습니다. *`) 대신.

헤더 제목에는 수행 된 작업에 대한 간단한 설명이 있어야합니다.
하나를 작성할 때 몇 가지 규칙이 있습니다.

-   명령형 현재 시제를 사용합니다 (예 : "변경"또는 "변경"대신 "변경").

-   첫 번째 단어의 첫 글자를 소문자로합니다.

-   끝에 마침표 (`.`)를 생략합니다.

-   80 자보다 긴 제목은 작성하지 마십시오. 커밋 본문입니다.

헤더 제목과 마찬가지로 본문에 명령형 현재 시제를 사용하십시오.
변화에 대한 동기를 포함하고이를 이전 행동과 대조해야합니다.

바닥 글은 주요 변경 사항에 대한 정보를 포함해야하며이 커밋이 종료되는 문제를 참조하는 장소이기도합니다.

브레이킹 체인지 정보는`BREAKING CHANGE :`로 시작하고 그 뒤에 공백 또는 두 개의 새 줄이 와야합니다.
나머지 커밋 메시지는 여기에 표시됩니다.

### 커밋 형식 적용

팀 작업은 모든 사람이 준수해야하는 모든 것을 표준화해야 할 때 항상 어려운 일입니다.
모든 사람이 동일한 커밋 표준을 사용하도록하기 위해 Commitizen을 사용할 것입니다.

Commitizen은 일관된 커밋 형식을 더 쉽게 사용할 수있게 해주는 명령 줄 도구입니다.
저장소를 Commitizen 친화적으로 만드는 것은 팀의 모든 구성원이`git cz`를 실행하고 커밋 메시지를 작성하기위한 자세한 프롬프트를받을 수 있음을 의미합니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/10/yhHmY8SO.png?resize=2088%2C1256&ssl=1)

### 릴리스 생성

이제 커밋이 일관된 표준을 따르는 것을 알았으므로 릴리스 및 릴리스 노트 생성 작업을 할 수 있습니다.
이를 위해 semantic-release라는 패키지를 사용합니다.
여러 CI (지속적 통합) 플랫폼을 잘 지원하는 잘 관리 된 패키지입니다.

semantic-release는 다음을 포함하여 릴리스에 필요한 모든 단계를 수행하므로 여정의 핵심입니다.

-   게시 한 마지막 버전 파악

-   마지막 릴리스 이후 추가 된 커밋을 기반으로 릴리스 유형 결정

-   마지막 릴리스 이후 추가 된 커밋에 대한 릴리스 노트 생성

-   `package.json` 파일 업데이트 및 새 릴리스 버전에 해당하는 Git 태그 생성

-   새 릴리스 추진

모든 CI가 가능합니다.
이 기사에서는 타사 솔루션을 찾기 전에 플랫폼의 기존 기능을 사용하는 것을 좋아하기 때문에 GitHub Action을 사용합니다.

semantic-release를 설치하는 방법은 여러 가지가 있지만 단계별로 제공하는 semantic-release-cli를 사용합니다.
터미널에서`npx semantic-release-cli setup`을 실행 한 다음 대화 형 마법사를 작성해 보겠습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/10/qrzM7dlj.png?resize=2088%2C1256&ssl=1)

스크립트는 몇 가지 작업을 수행합니다.

-   제공된 NPM 정보와 함께`npm adduser`를 실행하여`.npmrc`를 생성합니다.

-   GitHub 개인 토큰을 생성합니다.

-   `package.json`을 업데이트합니다.

CLI가 완료되면`package.json`에 semantic-release를 추가하지만 실제로 설치하지는 않습니다.
`npm install`을 실행하여 다른 프로젝트 종속성과 함께 설치합니다.

남은 것은 GitHub 작업을 통해 CI를 구성하는 것입니다.
semantic-release를 실행할 워크 플로를 수동으로 추가해야합니다.
`.github / workflows / release.yml`에서 출시 워크 플로를 만들어 보겠습니다.

```release.yml
name: Release
on:
  push:
    branches:
      - main
jobs:
  release:
    name: Release
    runs-on: ubuntu-18.04
    steps:
      - name: Checkout
        uses: actions/checkout@v2
      - name: Setup Node.js
        uses: actions/setup-node@v1
        with:
          node-version: 12
      - name: Install dependencies
        run: npm ci
      - name: Release
        env:
          GITHUB_TOKEN:  secrets.GITHUB_TOKEN
        # If you need an NPM release, you can add the NPM_TOKEN
        #   NPM_TOKEN:  secrets.NPM_TOKEN
        run: npm run release
```

Steffen Brewersdorff는 이미 GitHub Actions로 CI를 다루는 훌륭한 작업을 수행하고 있지만 여기서 무슨 일이 일어나고 있는지 간단히 살펴 보겠습니다.

이는`main` 브랜치에 대한 푸시가 발생하기를 기다린 다음 파이프 라인을 실행합니다.
하나, 둘 또는 모든 분기에서 작동하도록 자유롭게 변경하십시오.

```release.yml
on:
  push:
    branches:
      - main
```

그런 다음`checkout`으로 저장소를 가져 와서 npm을 사용하여 프로젝트 종속성을 설치할 수 있도록 Node를 설치합니다.
원하는 경우 테스트 단계를 진행할 수 있습니다.

```release.yml
- name: Checkout
uses: actions/checkout@v2
- name: Setup Node.js
uses: actions/setup-node@v1
with:
    node-version: 12
- name: Install dependencies
run: npm ci
# You can add a test step here
# - name: Run Tests
# run: npm test
```

마지막으로 semantic-release가 모든 마법을 수행하도록합니다.

```release.yml
- name: Release
run: npm run release
```

변경 사항을 푸시하고 조치를보십시오.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/10/KtN0UAl4.png?resize=1456%2C786&ssl=1)

이제 지정된 브랜치에 커밋 (또는 병합) 할 때마다 작업이 실행되고 릴리스 정보가 포함 된 릴리스를 만듭니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/10/pRVMk8vz.png?resize=1461%2C1087&ssl=1)

### 출시 파티!

CI / CD 시맨틱 릴리스 워크 플로를 성공적으로 만들었습니다!
그렇게 고통스럽지 않죠?
설정은 비교적 간단하며 시맨틱 릴리스 워크 플로를 갖는 데 단점이 없습니다.
변경 사항을 훨씬 쉽게 추적 할 수 있습니다.

semantic-release에는 훨씬 더 고급 자동화를 만들 수있는 많은 플러그인이 있습니다.
예를 들어 프로젝트가 성공적으로 배포되면 프로젝트 채널에 게시 할 수있는 Slack 릴리스 봇도 있습니다.
업데이트를 찾기 위해 GitHub로 이동할 필요가 없습니다!
