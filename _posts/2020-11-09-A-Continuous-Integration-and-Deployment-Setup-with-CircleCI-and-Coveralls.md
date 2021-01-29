---
layout: post
title: "CircleCI 및 Coveralls를 사용한 지속적인 통합 및 배포 설정
 "
author: 'CSS Dev'
thumbnail: undefined
tags: CONTINUOUS DEPLOYMENT,CONTINUOUS INTEGRATION,TESTING
---


CI (지속적 통합) 및 CD (지속적 배포)는 특히 팀에게 중요한 개발 방법입니다.
 모든 프로젝트는 크기에 관계없이 오류가 발생하기 쉽습니다.
 그러나 잘 작성된 테스트로 설정된 CI / CD 프로세스가있는 경우 이러한 오류를 찾아 수정하기가 훨씬 쉽습니다.
 

이 기사에서는 테스트 커버리지를 확인하고 CircleCI 및 Coveralls를 사용하는 CI / CD 프로세스를 설정하고 Vue 애플리케이션을 Heroku에 배포하는 방법을 살펴 보겠습니다.
 툴링의 정확한 칵테일이 차 한잔이 아니더라도 우리가 다루는 개념은 설정에 포함 된 모든 것에 여전히 도움이 될 것입니다.
 예를 들어 Vue는 다른 JavaScript 프레임 워크로 교체 할 수 있으며 기본 원칙은 여전히 관련이 있습니다.
 

바로 시작하기 전에 몇 가지 용어가 있습니다.
 

- 지속적인 통합 : 이것은 개발자가 코드를 초기에 자주 커밋하여 병합 또는 배포 전에 다양한 테스트 및 빌드 프로세스를 통해 코드를 작성하는 관행입니다.
 
- 연속 배포 : 이는 소프트웨어를 항상 프로덕션에 배포 할 수 있도록 유지하는 관행입니다.
 
- 테스트 범위 : 소프트웨어가 테스트되는 정도를 설명하는 데 사용되는 측정 값입니다.
 커버리지가 높은 프로그램은 대부분의 코드가 테스트를 거쳤 음을 의미합니다.
 

이 자습서를 최대한 활용하려면 다음이 있어야합니다.
 

- CircleCI 계정 : CircleCI는 자동화 된 배포에 사용할 CI / CD 플랫폼입니다 (배포 전에 애플리케이션 테스트 및 빌드 포함).
 
- GitHub 계정 : 프로젝트와 테스트를 저장소에 저장합니다.
 
- Heroku 계정 : Heroku는 애플리케이션 배포 및 확장에 사용되는 플랫폼입니다.
 배포 및 호스팅에 사용합니다.
 
- Coveralls 계정 : Coveralls는 코드 적용 범위를 기록하고 표시하는 데 사용되는 플랫폼입니다.
 
- NYC : 이것은 코드 커버리지를 확인하는 데 사용할 패키지입니다.
 

이 게시물에서 다룬 예제가 포함 된 저장소는 GitHub에서 사용할 수 있습니다.
 

### 설정하자
 

먼저 프로젝트 폴더에 NYC를 설치하겠습니다.
 

```terminal
npm i nyc
```

다음으로 테스트 커버리지를 확인하기 위해`package.json`의 스크립트를 편집해야합니다.
 단위 테스트를 실행하는 동안 적용 범위를 확인하려는 경우 테스트 스크립트를 편집해야합니다.
 

```js
"scripts": {
  "test:unit": "nyc vue-cli-service test:unit",
},
```

이 명령어는 `cue-cli-service`에 대한 참조를 포함하는 Vue로 앱을 빌드한다고 가정합니다.
 프로젝트에서 사용되는 프레임 워크를 반영하도록 명령을 변경해야합니다.
 

적용 범위를 별도로 확인하려는 경우 스크립트에 다른 줄을 추가해야합니다.
 

```js
"scripts": {
  "test:unit": "nyc vue-cli-service test:unit",
  "coverage": "nyc npm run test:unit"
}, 

```

이제 터미널 명령으로 커버리지를 확인할 수 있습니다.
 

```terminal
npm run coverage
```

다음으로 적용 범위를보고하고 표시하는 작업복을 설치합니다.
 

```terminal
npm i coveralls
```

이제`package.json`에 Coveralls를 다른 스크립트로 추가해야합니다.
 이 스크립트는 테스트 커버리지 보고서를 작업복에 저장하는 데 도움이됩니다.
 

```js
"scripts": {
  "test:unit": "nyc vue-cli-service test:unit",
  "coverage": "nyc npm run test:unit",
  "coveralls": "nyc report --reporter=text-lcov | coveralls"
}, 

```

Heroku 대시 보드로 이동하여 여기에 앱을 등록하겠습니다.
 Heroku는 호스팅에 사용할 것입니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/10/cavv1CkE.png?resize=1362%2C143&ssl=1)

CircleCI를 사용하여 CI / CD 프로세스를 자동화합니다.
 CircleCI 대시 보드로 이동하여 프로젝트를 설정합니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/10/GFXZcxtC.png?resize=1350%2C661&ssl=1)

CircleCI 사이드 바의 프로젝트 탭을 통해 프로젝트로 이동할 수 있습니다. 여기에서 GitHub 조직의 프로젝트 목록을 볼 수 있습니다.
 "프로젝트 설정"버튼을 클릭합니다.
 그러면 기존 구성을 사용할 것인지 묻는 새 페이지로 이동합니다.
 실제로 자체 구성이 있으므로 "기존 구성 사용"옵션을 선택하겠습니다.
 

그 후 선택한 프로젝트의 파이프 라인으로 이동합니다.
 큰!
 우리는 저장소를 CircleCI에 연결했습니다.
 이제 CircleCI 프로젝트에 환경 변수를 추가해 보겠습니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/10/MrClw8k4.png?resize=1366%2C665&ssl=1)

변수를 추가하려면 프로젝트 설정으로 이동해야합니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/10/ywfpjoFc.png?resize=1355%2C662&ssl=1)

프로젝트 설정에는 사이드 바에 환경 변수 탭이 있습니다.
 여기에 변수를 저장하고 싶습니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/10/maHAQR6Q.png?resize=1366%2C667&ssl=1)

이 자습서에 필요한 변수는 다음과 같습니다.
 

- Heroku 앱 이름 :`HEROKU_APP_NAME`
 
- Heroku API 키 :`HEROKU_API_KEY`
 
- Coveralls 저장소 토큰 :`COVERALLS_REPO_TOKEN`
 

Heroku API 키는 Heroku 대시 보드의 계정 섹션에서 찾을 수 있습니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/10/iDzf6rqg.png?resize=1343%2C662&ssl=1)

Coveralls 저장소 토큰은 저장소의 Coveralls 계정에 있습니다.
 먼저 Coveralls에 저장소를 추가해야합니다. 사용 가능한 저장소 목록에서 GitHub 저장소를 선택하면됩니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/10/cjnAMj6I.png?resize=1352%2C665&ssl=1)

이제 Coveralls에 저장소를 추가했습니다.
 저장소를 클릭하여 저장소 토큰을 얻을 수 있습니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/10/ug_Ux80t.png?resize=1350%2C493&ssl=1)

### CircleCI 통합
 

이미 Circle CI를 GitHub 저장소에 연결했습니다.
 즉, GitHub 저장소에서 변경이나 작업이 발생할 때마다 CircleCI에 알림이 전송됩니다.
 이제 우리가 원하는 것은 CircleCI가 repo에 대한 변경을 감지 한 후 실행할 작업을 CircleCI에 알리는 단계를 실행하는 것입니다.
 

로컬 프로젝트의 루트 폴더에`.circleci`라는 폴더를 만들고 그 안에`config.yml`이라는 파일을 만듭니다.
 여기에서 CircleCI의 모든 작업이 수행됩니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/10/cGszd9c8.png?resize=180%2C386&ssl=1)

해당 파일에 포함 된 코드는 다음과 같습니다.
 

```js
version: 2.1
orbs:
  node: circleci/node@1.1 // node orb 
  heroku: circleci/heroku@0.0.10 // heroku orb
  coveralls: coveralls/coveralls@1.0.6 // coveralls orb
workflows:
  heroku_deploy:
    jobs:
      - build
      - heroku/deploy-via-git: # Use the pre-configured job
        requires:
          - build
        filters:
          branches:
            only: master
jobs:
  build:
    docker:
      - image: circleci/node:10.16.0
    steps:
      - checkout
      - restore_cache:
        key: dependency-cache- checksum "package.json" 
      - run:
        name: install-npm-dependencies
        command: npm install
      - save_cache:
        key: dependency-cache- checksum "package.json" 
        paths:
          - ./node_modules
      - run: # run tests
        name: test
        command: npm run test:unit
      - run: # run code coverage report
        name: code-coverage
        command: npm run coveralls
      - run: # run build
        name: Build
        command: npm run build
      # - coveralls/upload
```

그것은 큰 코드 덩어리입니다.
 우리가 무엇을하는지 알 수 있도록 분석해 보겠습니다.
 

```js
orbs:
  node: circleci/node@1.1 // node orb 
  heroku: circleci/heroku@0.0.10 // heroku orb
  coveralls: coveralls/coveralls@1.0.6 // coveralls orb
```

Orbs는 프로젝트 전체에서 소프트웨어 및 패키지 통합을 단순화하는 데 사용되는 오픈 소스 패키지입니다.
 코드에서 우리는 CI / CD 프로세스에 사용중인 오브를 나타냅니다.
 우리는 JavaScript를 사용하고 있기 때문에`node` orb를 참조했습니다.
 자동화 된 배포를 위해 Heroku 워크 플로를 사용하고 있으므로 `heroku`를 참조합니다.
 그리고 마지막으로 Coveralls에 적용 범위 결과를 보낼 계획이므로`coveralls` 구를 참조합니다.
 

Heroku와 Coverall orbs는 외부 orbs입니다.
 따라서 지금 테스트를 통해 앱을 실행하면 오류가 발생합니다.
 오류를 제거하려면 CircleCI 계정의 "Organization Settings"페이지로 이동해야합니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/10/5iSnVvuP.png?resize=305%2C500&ssl=1)

그런 다음 보안 탭으로 이동하여 인증되지 않은 오브를 허용합니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/10/k1HYPT9c.png?resize=1359%2C667&ssl=1)

```js
workflows:
  heroku_deploy:
    jobs:
      - build
      - heroku/deploy-via-git: # Use the pre-configured job  
          requires:
            - build
          filters:
            branches:
              only: master
```

워크 플로는 작업 모음을 정의하고 순서대로 실행하는 데 사용됩니다.
 이 코드 섹션은 자동화 된 호스팅을 담당합니다.
 CircleCI에 프로젝트를 빌드 한 다음 배포하도록 지시합니다.
 `requires`는`heroku / deploy-via-git` 작업이 빌드를 완료해야 함을 의미합니다. 즉, 배포 전에 빌드가 완료 될 때까지 기다릴 것입니다.
 

```js
jobs:
  build:
    docker:
      - image: circleci/node:10.16.0
    steps:
      - checkout
      - restore_cache:
          key: dependency-cache- checksum "package.json" 
      - run:
          name: install-npm-dependencies
          command: npm install
      - save_cache:
          key: dependency-cache- checksum "package.json" 
          paths:
            - ./node_modules
```

작업은 단계 모음입니다.
 이 코드 섹션에서는`restore_cache` 작업을 통해 이전 빌드 중에 설치된 종속성을 복원합니다.
 

그런 다음 캐시되지 않은 종속 항목을 설치 한 다음 저장하여 다음 빌드 중에 다시 설치할 필요가 없습니다.
 

그런 다음 CircleCI에 프로젝트에 대해 작성한 테스트를 실행하고 프로젝트의 테스트 범위를 확인하도록 지시합니다.
 캐싱 종속성은 종속성을 저장하므로 다음 빌드 중에 해당 종속성을 설치할 필요가 없기 때문에 후속 빌드가 더 빨라집니다.
 

```js
- run: # run tests
    name: test
    command: npm run test:unit
  - run: # run code coverage report
    name: code-coverage
    command: npm run coveralls
# - coveralls/upload
```

이것은 우리가 실제로 단위 테스트를 실행하는 곳이기 때문에 Coveralls 마술이 일어나는 곳입니다.
 `package.json` 파일의`test : unit` 스크립트에`nyc` 명령을 추가 한 것을 기억하십니까?
 덕분에 단위 테스트는 이제 코드 범위를 제공합니다.
 

단위 테스트는 코드 커버리지를 제공하므로 커버리지 보고서에 포함됩니다.
 그것이 우리가 여기서 그 명령을 부르는 이유입니다.
 

마지막으로 코드는`package.json`에 추가 한 Coveralls 스크립트를 실행합니다.
 이 스크립트는 커버 올로 커버리지 보고서를 보냅니다.
 

`coveralls / upload` 줄이 주석 처리 된 것을 눈치 채 셨을 것입니다.
 이것은 프로세스의 마무리 특성을 의미했지만 결국 개발자 측면에서 차단기 또는 버그가되었습니다.
 다른 개발자의 트럼프 카드 일 수 있으므로 댓글을 달았습니다.
 

### 모든 것을 합치다
 

지속적인 통합 및 배포가 완료된 앱을 확인하십시오!
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/11/passimage.png?resize=1353%2C659&ssl=1)

지속적인 통합 및 배포는 많은 경우에 도움이됩니다.
 일반적인 예는 소프트웨어가 테스트 단계에있을 때입니다.
 이 단계에서는 많은 수정을 위해 많은 커밋이 발생합니다.
 개발자로서 마지막으로하고 싶은 일은 테스트를 수동으로 실행하고 사소한 변경이있을 때마다 내 애플리케이션을 수동으로 배포하는 것입니다.
 으으으.
 나는 반복이 싫어!
 

나는 당신에 대해 잘 모르지만 CI와 CD는 내가 한동안 알고 있던 것들이지만 너무 힘들거나 시간이 많이 걸리기 때문에 항상 밀어내는 방법을 찾았습니다.
 그러나 이제 설정이 얼마나 적은지, 그리고 그에 따른 이점을 확인 했으므로, 여러분이 직접 프로젝트를 시도해 볼 준비가 되었으면합니다.
 