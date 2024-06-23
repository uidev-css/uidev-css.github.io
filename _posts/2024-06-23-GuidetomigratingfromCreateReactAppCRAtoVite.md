---
title: "Create React App CRA에서 Vite로 마이그레이션하는 가이드"
description: ""
coverImage: "/assets/img/2024-06-23-GuidetomigratingfromCreateReactAppCRAtoVite_0.png"
date: 2024-06-23 15:09
ogImage: 
  url: /assets/img/2024-06-23-GuidetomigratingfromCreateReactAppCRAtoVite_0.png
tag: Tech
originalTitle: "Guide to migrating from Create React App (CRA) to Vite"
link: "https://medium.com/@mun1013/guide-to-migrating-from-create-react-app-cra-to-vite-5516f55aa410"
---


요즘 회사 내 보안 팀으로부터 웹 애플리케이션에서 발견된 모든 취약점을 가능한 한 빨리 해결하라는 안내를 받았어요.

Synk 보고서를 열어 보니, react-scripts 패키지와 관련된 중요도가 중간부터 높음까지 다양한 취약점이 나열되어 있었어요. 이에 대한 의존성 업그레이드가 필요합니다. 저희 웹 애플리케이션은 2년 전에 나온 리액트 스크립트 버전인 5.0.1을 사용하고 있는데, 더 이상 관리되지 않고 있어요.

그래서 의존성 버전을 덮어씌우는 대신 Vite을 사용해 보기로 결정했어요!

![이미지](/assets/img/2024-06-23-GuidetomigratingfromCreateReactAppCRAtoVite_0.png)

<div class="content-ad"></div>

CRA에서 Vite로 웹 애플리케이션을 전환하는 과정에서 따라한 단계별 안내서를 확인해보세요.

## 1. 의존성 설치 ⚡️

가장 먼저, 여러 의존성을 설치해야 합니다.

```js
npm install vite @vitejs/plugin-react vite-tsconfig-paths vite-plugin-svgr vite-plugin-commonjs --save-dev
```

<div class="content-ad"></div>

- vite
- @vitejs/plugin-react
- vite-tsconfig-paths

- vite-plugin-svgr
- vite-plugin-commonjs

## 2. Create `vite.config.ts` ⚡️

프로젝트 루트에 `vite.config.ts` 파일을 만드세요. 이 파일은 Vite가 프로젝트에서 작동하는 여러 측면을 제어하는 데 사용됩니다.

<div class="content-ad"></div>

```js
import path from 'path';
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig({
  base: './',
  plugins: [
    react(),
  ],
  server: {
    open: true, // 브라우저에서 앱 자동으로 열기
    port: 3000,
  },
  resolve: {
    alias: {
      screens: path.resolve(__dirname, './src/screens'),
    },
  },
  build: {
    outDir: 'build',
  },
});
```

각 구성 옵션을 살펴보겠습니다:

- base: 이는 애플리케이션의 기본 URL을 설정합니다. 애플리케이션이 https://abc.com/portal/에 배포되었다면 base를 `/portal/`로 설정해야 합니다.
- plugin: 이는 애플리케이션에 Vite 플러그인을 추가하는 것입니다. @vitejs/plugin-react에서 제공하는 React 플러그인은 JSX 및 기타 React 특정 기능을 처리하기 위해 필요합니다. 기타 선택적 플러그인으로는 commonjs(필요한 경우 CommonJS 모듈을 ES6 모듈로 변환), svgr(애플리케이션에 SVG가 있는 경우 React 컴포넌트로 직접 가져와야 함) 및 vite-tsconfig-paths(타입스크립트 경로 별칭을 해결하기 위해 사용) 등이 있습니다.

```js
// vite.config.ts
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import commonjs from 'vite-plugin-commonjs';
import svgr from 'vite-plugin-svgr';
import viteTsConfigPaths from 'vite-tsconfig-paths';

export default defineConfig({
  plugins: [
    react(),
    viteTsConfigPaths(),
    commonjs(),
    svgr({
      include: [
        'src/**/*.svg',
      ],
    }),
  ],
});

………………………………………………………………………………………………………………………………………………………………

// SVG 파일을 React 컴포넌트로 가져와야 합니다:
// Component.jsx
import Icon from './icon.svg?react'.

………………………………………………………………………………………………………………………………………………………………

// tsconfig.json
{
  "compilerOptions": {
    "paths": {
      "components/*": ["src/components/*"],
    }
  }
}

// 상대 경로를 사용하여 모듈을 가져오는 대신
import Button from '../../components/Button';

// 정의된 별칭을 사용할 수 있습니다
import Button from 'components/Button';
```

<div class="content-ad"></div>

- server: 개발 서버의 포트 번호를 구성하는 것입니다. 기본값은 포트 5173입니다.
- resolve: 별칭을 사용하여 가져오기 경로를 간소화하는 것입니다.
- build: Vite에서 빌드 프로세스를 사용자 정의하는 것입니다. 예를 들어, 출력 디렉토리의 이름을 설정하거나 CRA와 동일한 빌드 폴더를 유지하려면 build를 사용합니다. 기본값은 dist입니다. 또한 코드 분할을 구성할 수도 있습니다.

```js
import { defineConfig } from 'vite';

export default defineConfig({
  optimizeDeps: {
    force: true,
    esbuildOptions: {
      loader: {
        '.js': 'jsx',
      },
    },
  },
});
```

- OptimizeDeps: esbuild( Vite의 기본 번들러)를 사용하여 종속성의 사전 번들링을 구성하는 것입니다. force: true로 설정하면 Vite가 모든 개발 시작 시마다 종속성을 사전 번들링하여 항상 최신 상태를 유지하도록 합니다. 또한 loader: '`.js`: `jsx`'는 ESBuild가 JS 파일을 JSX 파일로 처리해야 함을 지정합니다. JS 파일에 JSX 구문이 포함되어 있는 경우 유용합니다.

## 3. vite-env.d.ts 파일 생성 ⚡️

<div class="content-ad"></div>

프로젝트 루트에 vite-env.d.ts라는 파일을 만들어주세요.

```js
// vite-env.d.ts
/// <reference types="vite/client" />
```

이 코드는 Vite의 전역 변수 및 클라이언트 특정 기능에 대한 타입 정의를 포함합니다. 이 파일은 사용자 정의 타입 및 모듈 선언에도 사용할 수 있으며 이는 TypeScript가 Vite 프로젝트의 다른 에셋 및 전역 변수를 처리하는 방법을 이해하는 데 도움이 됩니다.

## 4. index.html 파일 업데이트 ⚡️

<div class="content-ad"></div>

- public 폴더에서 index.html 파일을 루트 폴더로 이동하세요. CRA의 경우 index.html 파일은 public 폴더에 있어야 합니다. 그러나 Vite는 프로젝트의 루트에 이 파일이 있어야 합니다.
- %PUBLIC_URL%을 삭제하세요. Vite는 정적 자산과 공개 경로를 다르게 처리하며 JavaScript 파일에서 자산을 직접 가져오거나 HTML에서 상대 경로를 사용할 수 있도록 해줍니다.

```js
<!DOCTYPE html>
<html lang="en">
<head>
  <meta name="robots" content="noindex,nofollow" />
  <meta charset="utf-8" />
  <link rel="icon" href="%PUBLIC_URL%/favicon.png" />
  <link rel="manifest" href="%PUBLIC_URL%/manifest.json" />
  <title>CRA</title>
</head>

<body>
  <noscript>이 앱을 실행하려면 JavaScript를 활성화해야 합니다.</noscript>
  <div id="root"></div>
  <script src="%PUBLIC_URL%/src/main.jsx"></script>
</body>
</html>
```

```js
<!DOCTYPE html>
<html lang="en">
<head>
  <meta name="robots" content="noindex,nofollow" />
  <meta charset="utf-8" />
  <link rel="icon" href="/favicon.png" />
  <link rel="manifest" href="/manifest.json" />
  <title>CRA</title>
</head>

<body>
  <noscript>이 앱을 실행하려면 JavaScript를 활성화해야 합니다.</noscript>
  <div id="root"></div>
  <script src="/src/main.jsx"></script>
</body>
</html>
```

## 5. tsconfig.json 업데이트 ⚡️

<div class="content-ad"></div>

tsconfig.json을 업데이트해야 합니다. 특히 target, types 및 lib을 수정해야 합니다.

```js
{
  "compilerOptions": {
    "target": "ESNext",
    "types": ["vite/client", "vite-plugin-svgr/client"],
    "lib": ["dom", "dom.iterable", "esnext"],
    "allowJs": true,
    "skipLibCheck": true,
    "esModuleInterop": true,
    "allowSyntheticDefaultImports": true,
    "strict": true,
    "forceConsistentCasingInFileNames": true,
    "module": "esnext",
    "moduleResolution": "node",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "noFallthroughCasesInSwitch": true,
    "allowImportingTsExtensions": true,
    "jsx": "react-jsx"
  },
  "exclude": [
    "node_modules"
  ]
}
```

## 6. 환경 변수 ⚡️

Vite 프로젝트에서 process.env.REACT_APP_에서 import.meta.env.VITE_로 모든 환경 변수를 이관해야 합니다. Vite에서는 import.meta.env를 사용하여 환경 변수에 액세스하며, 반드시 접두사 VITE_로 시작해야 합니다.

<div class="content-ad"></div>

```js
// CRA
process.env.REACT_APP_API

// Vite
import.meta.env.VITE_API

console.log(import.meta.env) 
// { BASE_URL: '/', DEV: true, MODE: 'development', PROD: false, SSR: false }
```

import.meta.env에는 BASE_URL, DEV, MODE, PROD 및 SSR과 같은 몇 가지 미리 정의된 환경 변수가 있습니다. Vite는 실행할 때 import.meta.env.MODE를 development로 자동 설정하며, vite build를 실행할 때는 production으로 설정합니다. 또한 Vite 명령을 실행할 때 필요에 따라 모드를 지정할 수 있습니다. 예를 들어 vite build --mode staging와 같이 실행할 수 있습니다.

## 7. react-scripts 삭제하기 ⚡️

단순히 Vite로 대체했으므로 react-scripts를 삭제하고, 만약 craco.config.js 또는 config-overrides.js가 있다면 삭제하세요.

<div class="content-ad"></div>

```js
npm uninstall react-scripts
```

## 8. 패키지.json 파일의 스크립트 업데이트 ⚡️

react-scripts 패키지를 제거한 후에는 스크립트를 vite를 사용하도록 업데이트해야 합니다.

```js
"scripts": {
  "start": "vite",
  "build": "vite build",
  "serve": "vite preview"
},
```

<div class="content-ad"></div>

## 9. 애플리케이션 실행 ⚡️

npm start으로 애플리케이션을 실행하세요. 브라우저에서 즉시 애플리케이션이 열리는 것을 보게 될 거에요!

![2024-06-23-GuidetomigratingfromCreateReactAppCRAtoVite_1](/assets/img/2024-06-23-GuidetomigratingfromCreateReactAppCRAtoVite_1.png)

또한 npm run build로 정적 빌드를 수행한 후, npx serve -s build를 실행하여 프로덕션 빌드를 로컬에서 테스트할 수 있어요. 😋

<div class="content-ad"></div>

## 10. ESLint & Prettier 설정 ⚡️

CRA 및 Vite는 동일한 ESLint 및 Prettier 구성을 사용할 수 있으며 이동이 거의 필요하지 않아야 합니다. 제 경우 eslint를 실행할 때 "react-app" 설정을 불러오지 못해 오류가 발생하며 다음 패키지를 설치하여 문제를 해결할 수 있습니다.

```js
npm install eslint-config-react-app
```

## 오류 및 문제 해결 🔧

<div class="content-ad"></div>

Vite로 이주하면서 만난 몇 가지 오류와 내가 시도한 문제 해결 방법입니다.

🔗 해결: 파일 형식을 .js에서 .jsx로 변경하고, 작동하지 않거나 영향을 받는 파일이 많은 경우, vite.config.js에 JS 파일을 JSX로 처리하는 구성을 추가합니다.

🔗 해결: /src/assets/images/logo.svg?react로 대체하여 해결합니다. SVG를 React 컴포넌트로 변환하기 위해 vite.config.js에 이 플러그인을 추가해야 할 수 있습니다.

🔗 해결: npm install vite-plugin-commonjs을 실행하고, vite.config.js에 이 플러그인을 추가하여 해결할 수 있습니다.

<div class="content-ad"></div>

🔗 솔루션: process.env를 import.meta.env로 교체하세요.

🔗 솔루션: 이 설정을 구성했더니 작동했어요. 애플리케이션이 하위 디렉터리에 존재하는 경우에 대한 것입니다.

## 결론

CRA에서 Vite로 전환한 후, 웹 애플리케이션 개발 프로세스가 상당히 개선되었습니다.

<div class="content-ad"></div>

- Development server startup: 부팅 시간이 대략 14초에서 단 1초로 줄었습니다.
- NPM 설치: npm 설치 과정이 눈에 띄게 더 빨라져, 2분에서 1분 30초로 단축되었습니다.
- 빌드 시간: 빌드 시간이 45초에서 22초로 줄었습니다.

전체적으로, 마이그레이션에 만족하고 있습니다. 간단한데도 개발 경험을 더욱 원활하게 만들어주는 좋은 대안이라고 생각해요.