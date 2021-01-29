---
layout: post
title: "Lighthouse CI 및 GitHub 작업을 통한 지속적인 성능 분석
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/12/lighthouse-scores.jpg
tags: BUILD TOOL,LIGHTHOUSE,PERFORMANCE,PERFORMANCE BUDGET
---


Lighthouse는 웹 사이트의 성능, 접근성, 점진적 웹 앱 측정 항목, SEO 등을 평가하기위한 무료 오픈 소스 도구입니다.
 사용하는 가장 쉬운 방법은 Chrome DevTools 패널을 사용하는 것입니다.
 DevTools를 열면 "Lighthouse"탭이 표시됩니다.
 "보고서 생성"버튼을 클릭하면 웹 페이지에서 일련의 테스트가 실행되고 Lighthouse 탭에 바로 결과가 표시됩니다.
 이를 통해 공개 여부에 관계없이 모든 웹 페이지를 쉽게 테스트 할 수 있습니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_6C7EF8B1D383A545D26D634F97F613F2012B561C02AB5C628FED19D510243DBA_1606484728780_lighthouse-12.png?resize=2271%2C1721&ssl=1)

Chrome 또는 Microsoft Edge 또는 Brave와 같은 Chromium 기반 브라우저를 사용하지 않는 경우 웹 인터페이스를 통해 Lighthouse를 실행할 수 있지만 공개적으로 사용 가능한 웹 페이지에서만 작동합니다.
 명령 줄에서 Lighthouse 감사를 실행하려는 사용자를 위해 Node CLI 도구도 제공됩니다.
 

위에 나열된 모든 옵션에는 어떤 형태의 수동 개입이 필요합니다.
 지속적 통합 프로세스에 Lighthouse 테스트를 통합하여 코드 변경의 영향을 각 pull 요청과 함께 인라인으로 표시하고 특정 성능 임계 값이 정해지지 않은 경우 빌드에 실패 할 수 있다면 좋지 않을까요?
 이것이 바로 Lighthouse CI가 존재하는 이유입니다!
 

성능 측면뿐만 아니라 SEO, 접근성, 오프라인 지원 및 기타 모범 사례 측면에서 특정 코드 변경이 사이트에 미치는 영향을 식별하는 데 도움이되는 도구 모음입니다.
 실적 예산을 집행 할 수있는 좋은 방법을 제공하고보고 된 각 측정 항목을 추적하여 시간이 지남에 따라 어떻게 변했는지 확인할 수 있습니다.
 

이 문서에서는 Lighthouse CI를 설정하고 로컬에서 실행하는 방법을 살펴본 다음 GitHub 작업을 통해 CI 워크 플로의 일부로 작동하도록하는 방법을 살펴 봅니다.
 Lighthouse CI는 GitHub 작업을 사용하지 않으려는 경우 Travis CI, GitLab CI 및 Circle CI와 같은 다른 CI 공급자와도 함께 작동합니다.
 

### Lighthouse CI를 로컬로 설정
 

이 섹션에서는 컴퓨터에서 로컬로 Lighthouse CI 명령 줄 도구를 구성하고 실행합니다.
 계속하기 전에 Node.js v10 LTS 이상과 Google Chrome (안정적)이 컴퓨터에 설치되어 있는지 확인한 다음 전역 적으로 Lighthouse CI 도구를 설치합니다.
 

```terminal
$ npm install -g @lhci/cli
```

CLI가 성공적으로 설치되면 ru`lhci --help`에서 도구가 제공하는 사용 가능한 모든 명령을 확인합니다.
 작성 시점에 사용 가능한 8 개의 명령이 있습니다.
 

```terminal
$ lhci --help
lhci <command> <options>

Commands:
  lhci collect      Run Lighthouse and save the results to a local folder
  lhci upload       Save the results to the server
  lhci assert       Assert that the latest results meet expectations
  lhci autorun      Run collect/assert/upload with sensible defaults
  lhci healthcheck  Run diagnostics to ensure a valid configuration
  lhci open         Opens the HTML reports of collected runs
  lhci wizard       Step-by-step wizard for CI tasks like creating a project
  lhci server       Run Lighthouse CI server

Options:
  --help             Show help  [boolean]
  --version          Show version number  [boolean]
  --no-lighthouserc  Disables automatic usage of a .lighthouserc file.  [boolean]
  --config           Path to JSON config file
```

이제 프로젝트에 대한 CLI를 구성 할 준비가되었습니다.
 Lighthouse CI 구성은 구성 파일, 환경 변수 또는 CLI 플래그를 통해 (우선 순위가 높은 순서대로) 관리 할 수 있습니다.
 Yargs API를 사용하여 구성 옵션을 읽습니다. 이는 구성 방법에 많은 유연성이 있음을 의미합니다.
 전체 문서가 모든 것을 다룹니다.
 이 게시물에서는 구성 파일 옵션을 사용합니다.
 

계속해서 프로젝트 디렉토리의 루트에`lighthouserc.js` 파일을 만듭니다.
 Lighthouse CI는 Git 리포지토리에서 빌드 컨텍스트 설정을 자동으로 유추하므로 프로젝트가 Git으로 추적되고 있는지 확인합니다.
 프로젝트에서 Git을 사용하지 않는 경우 대신 환경 변수를 통해 빌드 컨텍스트 설정을 제어 할 수 있습니다.
 

```terminal
touch lighthouserc.js
```

다음은 정적 웹 사이트 프로젝트에 대한 Lighthouse 보고서를 실행 및 수집하고 임시 공용 저장소에 업로드하는 가장 간단한 구성입니다.
 

```js
// lighthouserc.js
module.exports = {
  ci: {
    collect: {
      staticDistDir: './public',
    },
    upload: {
      target: 'temporary-public-storage',
    },
  },
};
```

`ci.collect` 객체는 Lighthouse CI가 테스트 보고서를 수집하는 방법을 제어하는 여러 옵션을 제공합니다.
 `staticDistDir` 옵션은 정적 HTML 파일의 위치를 나타내는 데 사용됩니다. 예를 들어 Hugo는`public` 디렉토리에 빌드하고 Jekyll은 빌드 파일을`_site` 디렉토리에 배치합니다.
 빌드가있는 위치에`staticDistDir` 옵션을 업데이트하기 만하면됩니다.
 Lighthouse CI가 실행되면 그에 따라 테스트를 실행할 수있는 서버가 시작됩니다.
 테스트가 완료되면 서버가 자동으로 종료됩니다.
 

프로젝트에서 커스텀 서버를 사용해야하는 경우 `startServerCommand`속성을 통해 서버를 시작하는 데 사용되는 명령어를 입력 할 수 있습니다.
 이 옵션을 사용하는 경우 `url`옵션을 통해 테스트 할 URL도 지정해야합니다.
 이 URL은 지정한 사용자 정의 서버에서 제공 할 수 있어야합니다.
 

```js
module.exports = {
  ci: {
    collect: {
      startServerCommand: 'npm run server',
      url: ['http://localhost:4000/'],
    },
    upload: {
      target: 'temporary-public-storage',
    },
  },
};
```

Lighthouse CI가 실행되면`server` 명령을 실행하고`listen` 또는`ready` 문자열을 감시하여 서버가 시작되었는지 확인합니다.
 10 초 후에도이 문자열을 감지하지 못하면 서버가 시작된 것으로 간주하고 테스트를 계속합니다.
 그런 다음 `url`배열의 각 URL에 대해 Lighthouse를 세 번 실행합니다.
 테스트 실행이 완료되면 서버 프로세스를 종료합니다.
 

각각`startServerReadyPattern` 및`startServerReadyTimeout` 옵션을 통해 감시 할 패턴 문자열과 시간 초과 기간을 모두 구성 할 수 있습니다.
 각 URL에 대해 Lighthouse를 실행할 횟수를 변경하려면`numberOfRuns` 속성을 사용하세요.
 

```js
// lighthouserc.js
module.exports = {
  ci: {
    collect: {
      startServerCommand: 'npm run server',
      url: ['http://localhost:4000/'],
      startServerReadyPattern: 'Server is running on PORT 4000',
      startServerReadyTimeout: 20000 // milliseconds
      numberOfRuns: 5,
    },
    upload: {
      target: 'temporary-public-storage',
    },
  },
};
```

`ci.upload`개체 내의 `target`속성은 테스트가 완료된 후 Lighthouse CI가 결과를 업로드하는 위치를 구성하는 데 사용됩니다.
 `temporary-public-storage` 옵션은 보고서가 Google의 Cloud Storage에 업로드되고 며칠 동안 보관됨을 나타냅니다.
 링크가있는 모든 사용자가 인증 없이도 사용할 수 있습니다.
 보고서 저장 방법을보다 세부적으로 제어하려면 설명서를 참조하십시오.
 

이 시점에서 Lighthouse CI 도구를 실행할 준비가되어 있어야합니다.
 아래 명령을 사용하여 CLI를 시작하십시오.
 제공된 URL에 대해 Lighthouse를 세 번 실행하고 (`numberOfRuns` 옵션을 통해 변경하지 않는 한) 중앙값 결과를 구성된 대상에 업로드합니다.
 

```terminal
lhci autorun
```

출력은 아래 표시된 것과 유사해야합니다.
 

```terminal
✅  .lighthouseci/ directory writable
✅  Configuration file found
✅  Chrome installation found
⚠️   GitHub token not set
Healthcheck passed!

Started a web server on port 52195...
Running Lighthouse 3 time(s) on http://localhost:52195/web-development-with-go/
Run #1...done.
Run #2...done.
Run #3...done.
Running Lighthouse 3 time(s) on http://localhost:52195/custom-html5-video/
Run #1...done.
Run #2...done.
Run #3...done.
Done running Lighthouse!

Uploading median LHR of http://localhost:52195/web-development-with-go/...success!
Open the report at https://storage.googleapis.com/lighthouse-infrastructure.appspot.com/reports/1606403407045-45763.report.html
Uploading median LHR of http://localhost:52195/custom-html5-video/...success!
Open the report at https://storage.googleapis.com/lighthouse-infrastructure.appspot.com/reports/1606403400243-5952.report.html
Saving URL map for GitHub repository ayoisaiah/freshman...success!
No GitHub token set, skipping GitHub status check.

Done running autorun.

```

지금은 GitHub 토큰 메시지를 무시할 수 있습니다.
 GitHub 작업으로 Lighthouse CI를 설정할 때 구성합니다.
 브라우저에서 Lighthouse 보고서 링크를 열어 도달 URL에 대한 중앙값 테스트 결과를 볼 수 있습니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_6C7EF8B1D383A545D26D634F97F613F2012B561C02AB5C628FED19D510243DBA_1606485282041_lighthouse-1.png?resize=2282%2C1510&ssl=1)

### 어설 션 구성
 

Lighthouse CI 도구를 사용하여 Lighthouse 보고서를 실행하고 수집하면 충분하지만 한 단계 더 나아가 테스트 결과가 특정 기준과 일치하지 않는 경우 빌드가 실패하도록 도구를 구성 할 수 있습니다.
 이 동작을 제어하는 옵션은`assert` 속성을 통해 구성 할 수 있습니다.
 다음은 샘플 구성을 보여주는 스 니펫입니다.
 

```js
// lighthouserc.js
module.exports = {
  ci: {
    assert: {
      preset: 'lighthouse:no-pwa',
      assertions: {
        'categories:performance': ['error', { minScore: 0.9 }],
        'categories:accessibility': ['warn', { minScore: 0.9 }],
      },
    },
  },
};
```

`preset` 옵션은 Lighthouse 어설 션을 구성하는 빠른 방법입니다.
 세 가지 옵션이 있습니다.
 

- `lighthouse : all` : 모든 감사가 만점을 받았다고 주장합니다.
 
- `lighthouse : recommended` : 성과 외부의 모든 감사가 만점을 받았다고 주장하고 메트릭 값이 90 점 미만으로 떨어지면 경고합니다.
 
- `lighthouse : no-pwa` :`lighthouse : recommended`와 동일하지만 PWA 감사가 없습니다.
 

`assertions` 개체를 사용하여 사전 설정을 재정의 또는 확장하거나 처음부터 사용자 지정 어설 션 집합을 만들 수 있습니다.
 위의 구성은 `성능`및 `접근성`카테고리에 대해 기본 점수 90 점을 주장합니다.
 차이점은 전자에서 실패하면 0이 아닌 종료 코드가 생성되고 후자는 그렇지 않다는 것입니다.
 Lighthouse의 모든 감사 결과를 주장 할 수 있으므로 여기에서 할 수있는 일이 너무 많습니다.
 사용 가능한 모든 옵션을 찾으려면 설명서를 참조하십시오.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_6C7EF8B1D383A545D26D634F97F613F2012B561C02AB5C628FED19D510243DBA_1606485522030_lighthouse-2.png?resize=2052%2C1245&ssl=1)

`budget.json` 파일에 대해 어설 션을 구성 할 수도 있습니다.
 수동으로 생성하거나 performancebudget.io를 통해 생성 할 수 있습니다.
 파일이 있으면 아래와 같이`assert` 개체에 제공합니다.
 

```js
// lighthouserc.js
module.exports = {
  ci: {
    collect: {
      staticDistDir: './public',
      url: ['/'],
    },
    assert: {
      budgetFile: './budget.json',
    },
    upload: {
      target: 'temporary-public-storage',
    },
  },
};
```

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_6C7EF8B1D383A545D26D634F97F613F2012B561C02AB5C628FED19D510243DBA_1606485573655_lighthouse-3.png?resize=2436%2C1490&ssl=1)

### GitHub 작업으로 Lighthouse CI 실행
 

Lighthouse CI를 개발 워크 플로에 통합하는 유용한 방법은 프로젝트의 GitHub 저장소에 대한 각 커밋 또는 가져 오기 요청에 대한 새 보고서를 생성하는 것입니다.
 이것이 GitHub Actions가 작동하는 곳입니다.
 

설정하려면 프로젝트의 루트에`.github / workflow` 디렉토리를 만들어야합니다.
 여기에 프로젝트의 모든 워크 플로가 배치됩니다.
 GitHub 작업을 처음 사용하는 경우 워크 플로를 이벤트가 트리거 된 후 실행될 하나 이상의 작업 집합으로 생각할 수 있습니다 (예 : 저장소에 새 pull 요청이 생성 될 때).
 Sarah Drasner는 GitHub Actions 사용에 대한 훌륭한 입문서를 가지고 있습니다.
 

```terminal
mkdir -p .github/workflow
```

다음으로`.github / workflow` 디렉토리에 YAML 파일을 만듭니다.
 `.yml` 또는`.yaml` 확장자로 끝나는 한 원하는 이름을 지정할 수 있습니다.
 이 파일은 Lighthouse CI에 대한 워크 플로 구성이 배치되는 위치입니다.
 

```terminal
cd .github/workflow
touch lighthouse-ci.yaml
```

`lighthouse-ci.yaml` 파일의 내용은 프로젝트 유형에 따라 다릅니다.
 다른 유형의 프로젝트에 적용 할 수 있도록 내 Hugo 웹 사이트에 어떻게 설정했는지 설명하겠습니다.
 전체 구성 파일은 다음과 같습니다.
 

```yaml
# .github/workflow/lighthouse-ci.yaml
name: Lighthouse
on: [push]
jobs:
  ci:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v2
        with:
          token: secrets.PAT 
          submodules: recursive

      - name: Setup Hugo
        uses: peaceiris/actions-hugo@v2
        with:
          hugo-version: "0.76.5"
          extended: true

      - name: Build site
        run: hugo

      - name: Use Node.js 15.x
        uses: actions/setup-node@v2
        with:
          node-version: 15.x
      - name: Run the Lighthouse CI
        run: |
          npm install -g @lhci/cli@0.6.x
          lhci autorun
```

위의 구성은 Ubuntu 인스턴스에서 실행되고 코드가 저장소의 브랜치에 푸시 될 때마다 트리거되는 단일 작업 (`ci`)으로 구성된`Lighthouse`라는 워크 플로를 만듭니다.
 작업은 다음 단계로 구성됩니다.
 

- Lighthouse CI가 실행될 저장소를 확인하십시오.
 Hugo는 테마에 하위 모듈을 사용하므로 저장소의 모든 하위 모듈도 체크 아웃해야합니다.
 하위 모듈이 개인 저장소에있는 경우`repo` 범위가 활성화 된 새 개인 액세스 토큰을 생성 한 다음`https://github.com/ <username> / <repo>에서 저장소 암호로 추가해야합니다.
 / settings / secret`.
 이 토큰이 없으면 개인 저장소를 발견하면이 단계가 실패합니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_6C7EF8B1D383A545D26D634F97F613F2012B561C02AB5C628FED19D510243DBA_1606485742307_lighthouse-4.png?resize=2260%2C1253&ssl=1)

- 사이트 구축에 사용할 수 있도록 GitHub Action 가상 머신에 Hugo를 설치합니다.
 이 Hugo 설정 작업은 여기에서 사용한 것입니다.
 GitHub 작업 마켓 플레이스에서 다른 설정 작업을 찾을 수 있습니다.
 
- `hugo` 명령을 통해 사이트를`public` 폴더로 빌드합니다.
 
- setup-node 작업을 통해 가상 머신에 Node.js를 설치하고 구성합니다.
 
- Lighthouse CI 도구를 설치하고`lhci autorun` 명령을 실행합니다.
 

구성 파일을 설정했으면 변경 사항을 커밋하고 GitHub 저장소에 푸시 할 수 있습니다.
 구성이 올바르게 설정된 경우 방금 추가 한 워크 플로가 트리거됩니다.
 프로젝트 저장소의 작업 탭으로 이동하여 가장 최근 커밋에서 워크 플로의 상태를 확인합니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_6C7EF8B1D383A545D26D634F97F613F2012B561C02AB5C628FED19D510243DBA_1606485797795_lighthouse-5.png?resize=2318%2C633&ssl=1)

`ci`작업을 클릭하여 확장하면 작업의 각 단계에 대한 로그가 표시됩니다.
 제 경우에는 모든 것이 성공적으로 실행되었지만 내 주장은 실패했습니다. 따라서 실패 상태입니다.
 로컬에서 테스트를 실행할 때 확인한 것처럼 결과는 임시 공용 저장소에 업로드되며 로그에서 해당 링크를 클릭하여 볼 수 있습니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_6C7EF8B1D383A545D26D634F97F613F2012B561C02AB5C628FED19D510243DBA_1606485830484_lighthouse-6.png?resize=2397%2C1310&ssl=1)

### GitHub 상태 확인 설정
 

현재 Lighthouse CI는 코드가 브랜치로 직접 또는 풀 요청을 통해 리포지토리로 푸시되는 즉시 실행되도록 구성되었습니다.
 테스트 상태는 커밋 페이지에 표시되지만 보고서 링크를 포함한 전체 세부 정보를 보려면 로그를 클릭하고 확장해야합니다.
 

빌드 보고서가 pull 요청에 직접 표시되도록 GitHub 상태 확인을 설정할 수 있습니다.
 설정하려면 Lighthouse CI GitHub 앱 페이지로 이동하여 "구성"옵션을 클릭 한 다음 사용하려는 GitHub 저장소를 소유 한 조직 또는 GitHub 계정에 설치하고 인증합니다.
 그런 다음 확인 페이지에 제공된 앱 토큰을 복사하고 이름 필드를`LHCI_GITHUB_APP_TOKEN`으로 설정하여 저장소 보안 비밀에 추가합니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_6C7EF8B1D383A545D26D634F97F613F2012B561C02AB5C628FED19D510243DBA_1606485939916_lighthouse-9.png?resize=2234%2C1215&ssl=1)

이제 상태 확인을 사용할 준비가되었습니다.
 새로운 풀 요청을 열거 나 이미 존재하는 풀 요청에 커밋을 푸시하여 시도해 볼 수 있습니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_6C7EF8B1D383A545D26D634F97F613F2012B561C02AB5C628FED19D510243DBA_1606485978195_lighthouse-10.png?resize=1863%2C619&ssl=1)

### Lighthouse CI Server를 통한 기록보고 및 비교
 

임시 공용 저장소 옵션을 사용하여 Lighthouse 보고서를 저장하는 것은 시작하기에 좋은 방법이지만 데이터를 비공개로 유지하거나 더 오래 유지하려는 경우에는 충분하지 않습니다.
 Lighthouse CI 서버가 도움이 될 수있는 곳입니다.
 과거 Lighthouse 데이터를 탐색 할 수있는 대시 보드를 제공하고 빌드 간의 차이점을 파악할 수있는 훌륭한 비교 UI를 제공합니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_6C7EF8B1D383A545D26D634F97F613F2012B561C02AB5C628FED19D510243DBA_1606486015345_lighthouse-11.png?resize=3163%2C1615&ssl=1)

Lighthouse CI 서버를 활용하려면 자체 인프라에 배포해야합니다.
 Heroku 및 Docker에 배포하기위한 자세한 지침 및 레시피는 GitHub에서 찾을 수 있습니다.
 

### 결론
 

구성을 설정할 때 좋은 테스트 범위를 보장하기 위해 몇 가지 다른 URL을 포함하는 것이 좋습니다.
 일반적인 블로그의 경우 홈페이지, 사이트의 콘텐츠 유형을 대표하는 게시물 한두 개 및 기타 중요한 페이지를 포함 할 수 있습니다.
 

Lighthouse CI 도구로 수행 할 수있는 작업을 모두 다루지는 않았지만이 문서가이 도구를 시작하고 실행하는 데 도움이 될뿐만 아니라 다른 작업을 수행 할 수있는 좋은 아이디어를 제공하기를 바랍니다.
 읽어 주셔서 감사합니다. 즐거운 코딩 되세요!
 