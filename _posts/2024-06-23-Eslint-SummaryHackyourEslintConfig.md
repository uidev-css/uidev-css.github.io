---
title: "2024 Eslint 설정을 해킹하는 방법  Eslint-Summary"
description: ""
coverImage: "/assets/img/2024-06-23-Eslint-SummaryHackyourEslintConfig_0.png"
date: 2024-06-23 15:03
ogImage: 
  url: /assets/img/2024-06-23-Eslint-SummaryHackyourEslintConfig_0.png
tag: Tech
originalTitle: "“Eslint-Summary” — Hack your Eslint Config"
link: "https://medium.com/itnext/eslint-summary-hack-your-eslint-config-396f91ffda34"
---



![Eslint Config Summary](/assets/img/2024-06-23-Eslint-SummaryHackyourEslintConfig_0.png)

# 소개

자주는 아니지만 프로젝트에서 사용되는 eslint-config의 규칙을 이해해야 할 때가 있습니다. 이에 대한 몇 가지 이유가 있을 수 있습니다:

- 제 3자 규칙의 제어. 개발자들이 다른 팀들의 미리 작성된 스타일 가이드를 사용하는 것이 더 유익합니다. 예를 들어 Google이나 Airbnb와 같은 경우입니다. 그러나 남들의 규칙을 추적하는 것은 극도로 불편할 수 있습니다, 특히 규칙이 계속해서 추가되고 변경될 때에는요.


<div class="content-ad"></div>

- 팀 구성원들에게 현재 스타일 가이드를 숙지시킵니다. 여러 플러그인으로 구성된 설정을 가지고 있으면, 사람들이 각 플러그인, 규칙, 그리고 책임 영역에 대해 수동으로 숙지하도록 강요하기보다 친숙해지도록 도와주세요.
- 피드백 수집: 시각적인 표현과 현재 규칙에 대한 이해는 팀으로부터 피드백을 수집하고 통합해 ESLint 구성을 더 개선하며, 모두에게 더 유용하고 편리하게 만들 수 있습니다.
- 중복되는 검사 피하기: 사용 중인 규칙을 이해하면 개발을 느리게 하거나 현재 구성을 복잡하게 만들 수 있는 중복 규칙을 피할 수 있습니다.

문제 예시

새로 합류해서 첫 업무 주를 시작하셨다고 가정해봅시다. 모든 액세스를 받았고, 저장소를 다운로드했으며 익숙한 파일 .eslintrc.json을 보았습니다.

이 파일을 열어보니...

<div class="content-ad"></div>

```json
{
 "extends": "next/core-web-vitals"
}
```

![Eslint SummaryHackyourEslintConfig](/assets/img/2024-06-23-Eslint-SummaryHackyourEslintConfig_1.png)

이 줄은 무슨 정보를 제공하나요? — 이름은 알려줄 뿐, 설정이름이죠. 스스로에게 묻는다, “플러그인을 찾고 그 규칙을 숙지하는 시간을 낭비할 것인가?” — 그렇지 않다고 생각해봅니다.

## 해결책은 무엇인가요?

<div class="content-ad"></div>

- 만약 eslint에 익숙하시다면, 다음 명령어를 호출할 수 있어요.

eslint --print-config ./.eslintrc.json

이 명령을 호출하면 설정에서 모든 규칙이 콘솔에 긴 목록으로 반환됩니다. 그러나 유감스럽게도, 각 규칙을 수동으로 검색해야 하고, 그 의미와 이유를 이해하고 현재 설정과 연결해야 합니다. 많은 규칙이 있다면 매우 불편할 수 있어요.
- 새로운 솔루션 "Eslint config inspector"를 사용해보실 수도 있어요. 이것은 현재 설정의 시각화입니다. 이 솔루션의 단점은 상속 체인을 따라 깊은 규칙 검색을 제공하지 않는다는 것이에요. 게다가 이것은 문서가 아니라 애플리케이션입니다.

- 저의 솔루션은 npm 패키지인 @dolgikh-maks/eslint-summary입니다.

# “Eslint-Summary”란?

현재 프로젝트, 사용자 정의 프로그램, 하위 프로젝트 및 다른 eslint 구성이 사용되는 가능한 시나리오에 대한 규칙 문서를 생성하는 npm 패키지에요.

<div class="content-ad"></div>

이 작업은 간단합니다 - 각 플러그인의 현재 구성에 대한 마크다운 파일을 생성하고 그 안에 관련된 규칙을 기재하는 것입니다.

"그런 규칙이 있다"라고 보여주는 것뿐만 아니라, 마치 플러그인 페이지를 보는 것처럼 모든 정보를 제공해야 합니다. 규칙의 목적, 자동 수정을 지원하는지 여부, 적용되는 파일 등을 이해할 수 있어야 합니다.

## 설치

npm 패키지를 설치하는 익숙한 명령어를 지정하면 됩니다.

<div class="content-ad"></div>

```js
npm i --save-dev @dolgikh-maks/eslint-summary
```

## 시작하기

만약 .eslintrc.js 파일을 기본 구성으로 사용하고 있다면, 추가 구성이 필요하지 않으며 다음 명령어를 사용하여 충분합니다.

```js
eslint-summary
```

<div class="content-ad"></div>

위 명령을 실행한 후 .eslintrc.md 파일이 포함된 eslint-summary-report 디렉토리가 생성됩니다.

## 보고서 파일

생성된 .eslintrc. md 파일을 열면 .eslintrc.js 구성에 관련된 각 플러그인에 대한 요약 테이블이 제공됩니다.

테이블에는 예약된 열이 있습니다.

<div class="content-ad"></div>

- Rule — eslint 플러그인의 rule 이름
- Extension *.`extension` — 특정 확장 파일에 대한 rule 설정을 보여주는 열

나머지 열들은 rule로부터의 메타 데이터를 표시하는 열입니다.

## 주요 기능

만약 rule에 대해 더 알고 싶다면, 검색 엔진을 통해 수동으로 찾을 필요가 없습니다. 테이블에서 원하는 rule을 선택하면 됩니다.

<div class="content-ad"></div>

이미 규칙의 이름에는 해당 문서로의 직접 링크가 포함되어 있습니다.

# 구성

패키지를 쉽게 구성하기 위해 .eslint-summary.`js | json | ts | yaml` 구성 파일을 사용합니다. 여기에는 패키지의 기본 설정에 만족하지 못한다면 보고서를 생성하기 위한 필요한 옵션을 지정합니다.

## 확장자

<div class="content-ad"></div>

디폴트 – [`js`]

보고서에서 각 파일 유형의 규칙 설정을 표시하기 위해 필요한 파일 확장자를 지정합니다.

이 옵션은 프로젝트에 json 또는 spec.js와 같은 다른 파일 유형이 포함되어 있고 이러한 파일 확장자와 함께 규칙이 어떻게 작동하는지 알고 싶을 때 매우 편리합니다.

중요: 어떤 값이든 지정하면 현재 [js] 설정을 덮어씁니다. js 파일에 대한 보고서를 저장하려면 해당 확장자도 지정해야 합니다.

<div class="content-ad"></div>

```js
/**
 * @type {import('@dolgikh-maks/eslint-summary').IConfig}
 */
module.exports = {
   extensions: [
       'json',
       'spec.js',
       'js'
   ],
};
```

## 출력

기본값 — `eslint-summary-report`

보고서 디렉토리 경로를 변경합니다.


<div class="content-ad"></div>

하위 디렉토리를 지원합니다. 생성 시작 시 해당 디렉토리가 없는 경우 자동으로 생성됩니다.

```js
/**
 * @type {import('@dolgikh-maks/eslint-summary').IConfig}
 */
module.exports = {
   output: './docs/eslint-summary',
};
```

## ignorePlugins

기본값 — []

<div class="content-ad"></div>

보고서에서 플러그인을 제외하세요.

가끔 다른 사람의 구성에는 타사 플러그인을 사용하는 경우가 있지만, 이는 우리 코드와 분석과 잘 작동하지 않을 수 있습니다. 예를 들어, eslint-config-prettier는 react, vue 및 flowtype 플러그인을 포함하고 있습니다.

```js
/**
 * @type {import('@dolgikh-maks/eslint-summary').IConfig}
 */
module.exports = {
   ignorePlugins: ['eslint-plugin-vue', "eslint-plugin-flowtype"],
};
```

## 구성

<div class="content-ad"></div>

기본값 — [`./.eslintrc.js`]

분석하고 문서를 생성하려는 eslint 구성을 지정합니다.

eslint 구성 파일 이름이 표준 이름(.eslintrc.js)과 다를 경우, 분석해야하는 파일의 위치와 구체적인 파일을 지정할 수 있습니다.

여러 개의 파일 또는 서브 프로젝트가 각각의 구성을 갖고 있는 경우, 이를 지정하는 것은 문제가 되지 않습니다.

<div class="content-ad"></div>

```js
/**
 * @type {import('@dolgikh-maks/eslint-summary').IConfig}
 */
module.exports = {
    configs: [
        './example-apps/angular/.eslintrc.js',
        './example-apps/next/.eslintrc.json'
    ],
};
```

생성기는 각 구성에 따라 해당 이름 및 위치에 다른 보고서를 생성합니다.

<img src="/assets/img/2024-06-23-Eslint-SummaryHackyourEslintConfig_2.png" />

# 사용 예시


<div class="content-ad"></div>

팀 스타일 가이드 작성에 관한 제 논문에서 @my-team/eslint-plugin을 생성하고 확장하는 방법을 살펴보았습니다.

![이미지](/assets/img/2024-06-23-Eslint-SummaryHackyourEslintConfig_3.png)

만약 우리 플러그인을 사용하는 사용자들에게 설정과 구성을 문서로 볼 수 있게 하려면 어떻게 해야 할까요? 아래와 같은 구조처럼 말이죠.

![이미지](/assets/img/2024-06-23-Eslint-SummaryHackyourEslintConfig_4.png)

<div class="content-ad"></div>

친절한 안내입니다:

- @dolgikh-maks/eslint-summary 패키지를 설치하세요.
- .eslint-summary.js 파일에서 원하는 설정을 지정하세요.

```js
/**
 * @type {import('@dolgikh-maks/eslint-summary').IConfig}
 */
module.exports = {
    extensions: [
        'ts',
        'html',
        'spec.ts',
    ],
    ignorePlugins: [
        'eslint-plugin-vue',
        'eslint-plugin-react',
        'eslint-plugin-flowtype',
    ],
    configs: [
        './configs/base.js',
        './configs/recommended.js',
        './configs/spec.js',
        './configs/strict.js',
        './plugins/rxjs/recommended.js',
        './plugins/prettier/index.js',
        // 기타 경로
    ],
    output: './docs',
};
```

- eslint-summary 명령어를 실행하세요.
- 각 구성에 대한 문서를 얻습니다. 🔥

<div class="content-ad"></div>

이제 플러그인 사용자들은 /docs 폴더로 이동하여 현재 플러그인 설정을 볼 수 있습니다.

예를 들어, plugins/prettier/index.md

![이미지](/assets/img/2024-06-23-Eslint-SummaryHackyourEslintConfig_5.png)

여기에서 전체 예제를 찾을 수 있습니다.

<div class="content-ad"></div>

# 결론

현재 npm 패키지는 개발 중이며 Eslint 9 및 해당 평면 구성과 같은 많은 요소를 고려하지 않습니다. 그러나 당신을 막는 것은 없습니다. Eslint 8 및 이전 버전과 함께 사용해보려고 하는 것은 막지 않습니다.