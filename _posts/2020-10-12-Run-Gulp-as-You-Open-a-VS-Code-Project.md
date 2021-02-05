---
layout: post
title: "VS 코드 프로젝트를 열 때 Gulp 실행"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/10/gulp-vscode.png
tags: GULP,TERMINAL,VS CODE
---


제가 이 사이트에 대한 지역 프로젝트를 열었을 때, 이 명령을 먼저 실행해야 할 가능성이 100%인 `걸프입니다. 1년도 채 안 돼서 새로 설정해 놓았기 때문에 최신 및 최고의 기능을 사용하고 있고 작업 흐름도 마음에 듭니다. 저는 몇 달 후에 상황을 더 좋게 만들기 위해 몇 번 더 했습니다.

그때 VS Code Tasks에 대해 배웠습니다. 일반적으로 는 사용자가 이름으로 실행하도록 선택할 때마다 구성하는 명령줄 태스크만 실행할 수 있습니다. 하지만 저는 특히 여러분이 프로젝트를 열 때 그들이 실행할 수 있다는 생각에 사로잡혀 있습니다.

Gulp를 이렇게 쉽게 실행할 수 있습니다.

```js
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Run Gulp",
      "command": "gulp",
      "type": "shell",
      "runOptions": {
        "runOn": "folderOpen"
      }
    }
  ]
}
```

내 기계에 고장이 나기 시작했다는 것만 빼면요. nvm을 사용하여 노드 버전을 관리하고, Gulp와 잘 맞는 올바른 노드 버전으로 `nvm 별칭 default`하려는 최선의 노력에도 불구하고 노드 버전이 항상 잘못되어 gulp를 실행하지 못할 수 있습니다. 먼저 nvm use(내 .nvmrc 파일에서 올바른 버전을 설정)를 실행한 다음 gulp가 정상적으로 실행됩니다.

이 작업은 새 터미널 창에서 잘 작동하지만, 어떤 이유에서인지 명령어가 두 개의 태스크를 이렇게 실행하도록 할 수도 있습니다(세미콜론으로 연결).

```js
"command": "nvm use; gulp",
```

…그것은 여전히 실패할 것이다. 그것은 nvm이 무엇을 의미하는지 알지 못했다. 문제의 핵심이 정확히 무엇인지 모르겠지만(왜 한 터미널이 다른 터미널과 동일한 것을 알지 못하는지) 글로벌 nvm이 하나의 작업을 가진 셸 스크립트를 가지고 있는지(`nvm` 명령 정의) 확인했습니다. 따라서 그들이 말하는 것처럼 "출처"하고 "nvm" 명령이 작동합니다.

마지막 설정은 다음과 같습니다.

```js
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Run Gulp",
      "command": ". ~/.nvm/nvm.sh; nvm use; gulp",
      "type": "shell",
      "runOptions": {
        "runOn": "folderOpen"
      }
    }
  ]
}

```

사랑하는 독자 여러분, 제가 제 CSS-Tricks 프로젝트를 열었을 때, 그것이 바로 제가 원하던 것입니다.

하이파이브 저와 함께 이 여정을 떠나 결승점에 오도록 도와주신 젠 루커에게요. 🤚