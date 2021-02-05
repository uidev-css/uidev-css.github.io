---
layout: post
title: "도커 컨테이너를 개발 환경으로 사용하기 위한 온화한 소개"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/09/docker-logo.png
tags: DOCKER,VS CODE
---


빈정거림 부인: 이 글은 대부분 빈정거린다. 저는 제가 실제로 딜런 토마스를 대변한다고 생각하지 않습니다. 그리고 저는 여러분이 그것을 원하지 않는 사람들에게 가벼운 주제를 강요하도록 결코 권하지 않을 것입니다. 그들이 얼마나 잘못되었든 간에.

딜런 토마스가 "그 좋은 밤으로 살살 들어가지 말라"는 말을 썼을 때, 그는 죽음에 대해 말하고 있었다. 하지만 그가 오늘 살아있다면 리눅스 컨테이너에 대해 말하고 있을지도 모릅니다. 1953년 세상을 떠났기 때문에 확실히 알 수 있는 방법은 없지만, 이것이 인터넷이기 때문에 그를 대신해 권위적으로 말하는 것에 대한 자신감이 극도로 느껴진다.

제 자신감은 제가 최근에 도커 컨테이너를 개발 환경으로 구성하려 했다는 사실과 함께 제 기술과 지능에 대한 완전히 과대평가에서 비롯되었습니다. 그리고 나는 내가 나인 것처럼 하는 모든 시도를 도커가 거절하고 제임스 왕이 "내 집에는 없어!"라고 소리치는 동안 빛이 죽어가는 것에 대해 격노하는 자신을 발견했다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/09/7A7fvLrA.gif?resize=495%2C275&ssl=1)

고통은 훌륭한 선생님이다. 그리고 저는 여러분을 아끼고 다른 어떤 다른 다른 다른 동기가 없기 때문에, 그 경험을 이용해서 도커 컨테이너를 개발 환경으로 사용하는 것에 대해 "신사하게" 소개해 드리고 싶습니다. 하지만 먼저, 왜 yyyyyyyyy가 당신이 그것을 하기를 원하는지에 대해 이야기해 봅시다.

### 그런데 왜죠?

눈을 감고 이것을 상상해보라: 여우처럼 차려입은 다 큰 남자.

잠깐만요, 시나리오가 틀렸어요

대신, 소스 코드뿐만 아니라 전체 개발 환경과 앱에 필요한 모든 종속성과 실행 시간을 포함하는 프로젝트를 상상해 보십시오. 그런 다음 해당 프로젝트를 (여우 사나이와 같은) 모든 사용자에게 제공할 수 있으며, 자신의 환경에 대한 구성 변경 없이 프로젝트를 실행할 수 있습니다.

이것이 바로 도커 컨테이너가 하는 일입니다. 도커 파일은 단일 파일로 전체 런타임 환경을 정의합니다. 그 컨테이너 안에서 발전하는 방법만 있으면 됩니다.

기다려봐…

### VS 코드 및 원격 – 컨테이너

VS Code에는 프로젝트를 Docker 컨테이너 안에 로드하고 VS Code로 연결할 수 있는 Remote – Containers라는 확장자가 있습니다. 바로 인셉션 수준입니다. (그가 알아냈나요?) 부적은 실제로 회전을 멈추지 않습니다.) 우리가 (그리고 "우리"에 의해) 그것을 행동으로 본다면 더 이해하기 쉽다.

### 프로젝트에 컨테이너 추가

잠시 여러분이 아이들을 위해 만든 고급 게임용 PC에 있다고 가정해 보겠습니다. 내 말은, 왜 그들이 다시 새 컴퓨터를 가질 자격이 있는 거지? 아, 맞아요. 그들은 그렇지 않다. 그들은 매주 일요일마다 쓰레기를 버릴 수도 없어요.

WSL2와 Docker가 설치된 새 Windows 컴퓨터입니다. 이 시스템에서 Node.js 프로젝트를 실행하려고 한다면 Powershell은 당신이 말하는 것이 무엇인지 전혀 모르고 당신이 철자를 잘못 썼을 수도 있다고 말할 것이다. 공평하게 말하면 철자를 잘 못 쓰잖아요 여러분이 "프라이드"라고 철자할 수 없었기 때문에 철자 맞추기 대회 첫 라운드에서 낙제했을 때인 4℃의 학년을 기억하세요. "Y"가 없어!

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/09/sYn8lPG4.png?resize=1038%2C407&ssl=1)

이제 이것은 큰 문제가 아닙니다. 언제든지 Node.js를 건너뛰고 설치할 수 있습니다. 하지만 잠깐 동안 여러분은 그것을 하는데 귀찮아 할 수 없고 여러분은 건너뛰는 것이 어른들이 하는 일이 아니라고 꽤 확신한다고 가정해봅시다.

대신 Node.js가 이미 설치되어 있는 컨테이너에서 실행되도록 이 프로젝트를 구성할 수 있습니다. 이미 얘기했듯이 도커를 어떻게 사용하는지 모르겠어요. 나는 전자레인지를 거의 사용할 수 없다. 다행히도 VSCode가 프로젝트를 어느 정도 구성할 것입니다.

명령 팔레트에서 "Add Development Container Configuration Files..." 명령이 있습니다. 이 명령은 프로젝트를 보고 적절한 컨테이너 정의를 추가하려고 합니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/09/58XuX62A.png?resize=870%2C187&ssl=1)

이 경우 VSCode는 여기에 노드 프로젝트가 있다는 것을 알고 Node.js 14를 선택하겠습니다. 네, 저는 12가 LTS라는 것을 알고 있습니다. 하지만 한 달에 14번 체크워치가 될 것이고 저는 얼리 어답터입니다. 제가 2020년에 컨테이너 기술에 관심을 가지고 있다는 것을 증명합니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/09/RP6TABAw.png?resize=866%2C542&ssl=1)

이렇게 하면 일부 자산이 포함된 .dev 컨테이너 폴더가 추가됩니다. 하나는 우리가 사용할 Node.js 이미지가 들어 있는 도커 파일이고, 다른 하나는 프로젝트 수준의 구성이 진행 중인 devcontainer.json입니다.

이제 아무거나 터치하고 모든 항목을 분리하기 전에 명령 팔레트에서 "컨테이너에서 재구성 및 다시 열기"를 선택할 수 있습니다. 그러면 VSCode가 다시 시작되고 컨테이너 구축을 시작합니다. 작업이 완료되면(아이들이 결코 기쁨을 알 수 없는 고급 게임 PC에 있지 않을 경우 처음으로 시간이 걸릴 수 있음) 컨테이너 내부에서 프로젝트가 열립니다. VS Code는 컨테이너에 연결되어 있고 왼쪽 하단 모서리에 이렇게 표시되어 있습니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/09/KW1cmtxx.png?resize=965%2C217&ssl=1)

이제 VS Code에서 터미널을 열면 Powershell이 눈에 띄게 없어집니다. 왜냐하면 우리는 더 이상 Windows에 있지 않기 때문입니다, Dorthy. 우리는 지금 리눅스 컨테이너 안에 있다. 그리고 우리는 이 마법의 땅에서 `npm install`과 `npm start` 둘 다 할 수 있다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/09/2-YO-N5B.png?resize=1024%2C416&ssl=1)

이 앱은 Express App이므로 포트 3000에서 실행되어야 합니다. 하지만 당신이 그 항구를 방문하려고 하면, 그것은 적재되지 않을 것입니다. 컨테이너의 포트를 로컬 호스트의 3000에 매핑해야 하기 때문입니다. 하는 것처럼.

다행히도, 이것에 대한 UI가 있습니다.

Remote Containers 확장은 "Remote Explorer" 아이콘을 수행 표시줄에 배치합니다. 왼쪽은 당신, 오른쪽은 저입니다. 내가 옮겼으니까 너도 그래야지.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/09/wQKnBaHd.png?resize=1024%2C682&ssl=1)

여기 3개의 섹션이 있습니다. 하지만 아래쪽에 있는 포트 포워딩이라고 적혀있는 것을 보세요. 저는 상추가 가장 많은 샌드위치는 아닙니다. 하지만 저는 이것이 우리가 여기서 원하는 것이라고 확신합니다. "포트 전달"을 클릭하고 "3000"을 입력하면 됩니다. 이제 브라우저에서 앱을 실행해 보면...

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/09/yizlNKZX.png?resize=1022%2C495&ssl=1)

대부분 "그냥 먹혀들었어" 그러나 구성 또한 매우 간단합니다. 프로젝트 자체의 몇 가지 측면을 자동화하여 이 설정을 사용자 지정할 수 있는 방법을 살펴보겠습니다. 프로젝트별 구성은 `devcontainer.json` 파일에서 수행됩니다.

### 프로젝트 구성 자동화

먼저 포트 포워딩 변수를 추가하고 3000을 값으로 지정하면 포트 포워딩을 자동화할 수 있다. postCreateCommand 속성을 지정하여 npm install 명령을 자동화할 수도 있습니다. 그리고 현실을 직시하자, 우리 모두는 적어도 npm 설치를 한 번 줄일 수 있다.

```js
{
  // ...
  // Use 'forwardPorts' to make a list of ports inside the container available locally.
  "forwardPorts": [3000],
  // Use 'postCreateCommand' to run commands after the container is created.
  "postCreateCommand": "npm install",
  // ...
}
```

또한 VS Code 확장 기능을 포함할 수 있습니다. Docker 컨테이너에서 실행되는 VS Code는 설치한 모든 확장을 자동으로 가져오지 않습니다. 컨테이너에 설치하거나, 여기처럼 포함시켜야 합니다.

Pretty나 ESLint와 같은 확장은 이런 종류의 시나리오에 안성맞춤이다. 우리는 또한 이 기회를 통해 어두운 주제가 읽기와 이해에 더 나쁜 것으로 밝혀지기 때문에 모든 사람들에게 가벼운 주제를 강요할 수 있다. 나는 예언자가 된 기분이다.

```js
// For format details, see https://aka.ms/vscode-remote/devcontainer.json or this file's README at:
// https://github.com/microsoft/vscode-dev-containers/tree/v0.128.0/containers/javascript-node-14
{
  // ...
  // Add the IDs of extensions you want installed when the container is created.
  "extensions": [
    "dbaeumer.vscode-eslint",
    "esbenp.prettier-vscode",
    "GitHub.github-vscode-theme"
  ]
  // ...
}
```

확장 ID를 어디서 찾을지 궁금하면 해당 ID가 설치된 경우 지능형(Cctl/Cmd+Shift)으로 표시됩니다. 그렇지 않은 경우 확장 마켓플레이스를 검색한 후 마우스 오른쪽 버튼을 클릭하고 "확장 ID 복사" 또는 "devcontainer.json에 추가"를 선택하십시오.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/09/irGleq6g.png?resize=817%2C360&ssl=1)

기본적으로 VSCode에서 제공하는 Node.js 컨테이너에는 git 및 cURL과 같은 것들이 이미 설치되어 있습니다. "cowsay"가 없는 것은, "cowsay"입니다. 그리고 우리는 soesay 없이는 리눅스 환경을 가질 수 없습니다. 그것은 리눅스 양법안에 있다. 나는 규칙을 만들지 않는다. 이 컨테이너를 사용자 정의하여 추가해야 합니다.

### 환경 구성 자동화

여기가 나를 위해 일이 꼬인 곳이야. 개발 컨테이너에 소프트웨어를 추가하려면 Docker 파일을 편집해야 합니다. 그리고 리눅스는 당신의 세너니건이나 실수에 대한 관용이 없다.

VS Code의 컨테이너 구성과 함께 제공되는 기본 Docker 컨테이너는 Debian Linux입니다. 데비안 리눅스는 apt-get 의존성 관리자를 사용한다.

```terminal
apt-get install cowsay
```

Docker 파일 끝에 추가할 수 있습니다. apt-get에서 설치할 때마다 apt-get update를 먼저 apt-get update를 실행합니다. 이 명령은 패키지 및 패키지 리포지토리 목록을 업데이트하여 가장 최신 목록을 캐시하도록 합니다. 이렇게 하지 않으면 컨테이너 빌드가 실패하고 "cowsay"를 찾을 수 없다는 메시지가 표시됩니다.

```terminal
# To fully customize the contents of this image, use the following Dockerfile instead:
# https://github.com/microsoft/vscode-dev-containers/tree/v0.128.0/containers/javascript-node-14/.devcontainer/Dockerfile
FROM mcr.microsoft.com/vscode/devcontainers/javascript-node:0-14
# ** Install additional packages **
RUN apt-get update \
  && apt-get -y install cowsay
```

여기서 몇 가지 유의할 사항이 있습니다.

- RUN 명령은 도커(Docker) 명령으로 새로운 "레이어"를 생성합니다. 레이어는 컨테이너를 재구성할 때 컨테이너가 변경된 내용과 업데이트해야 하는 내용을 파악하는 방법입니다. 그것들은 케이크 층과 비슷하지만, 거대한 케이크들이 멋있기 때문에 여러분이 많은 것을 원하지 않는다는 것을 제외하면요. 거대한 컨테이너는 그렇지 않습니다. 불필요한 레이어를 만들지 않도록 관련 논리를 동일한 `RUN` 명령으로 함께 유지하고 시도해야 합니다.
- 이 `\`는 줄의 끝에 있는 줄 바꿈을 나타냅니다. 다중 회선 명령에 필요합니다. 그만 두면 많은 도커 빌드 실패의 고통을 알게 될 거야.
- 더
- `-y` 플래그는 기본적으로 apt-get에서 방금 설치하려고 했던 것을 정말로 설치하려는 것을 확인하라는 메시지를 표시하므로 중요합니다. 이렇게 되면 Y나 N을 말할 사람이 없어 컨테이너 빌드가 실패하게 됩니다. `-y`라는 깃발은 `당신의 바보 같은 확인 프롬프트로 나를 귀찮게 하지 말라`는 줄임말이다. 분명히 모든 사람들은 이미 이 사실을 알고 있어야 한다. 나는 약 4시간 전에야 그것을 알았다.

명령 프롬프트를 사용하여 "컨테이너 재구성"을 선택합니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/09/2SQV4Gxq.png?resize=835%2C170&ssl=1)

그리고, 바로 그것처럼…

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/09/IKZ5oCRh.png?resize=861%2C205&ssl=1)

안 되는데요.

이것은 제가 "Linux Vertigo"라고 부르는 것의 첫 번째 교훈입니다. 리눅스의 배포판이 너무 많고 모든 것을 같은 방식으로 다루지는 않습니다. 왜 한 곳에서 일이 잘 되고(Mac, WSL2) 다른 곳에서는 왜 안 되는지 알아내기가 어려울 수 있습니다. 데비안이 cowsay를 사용할 수 없는 이유는 pATH 환경변수에 포함되지 않은 /usr/games에 cowsay를 넣기 때문이다.

한 가지 해결책은 도커 파일의 `PATH`에 그것을 추가하는 것이다. 이렇게...

```terminal
FROM mcr.microsoft.com/vscode/devcontainers/javascript-node:0-14
RUN apt-get update \
  && apt-get -y install cowsay
ENV PATH="/usr/games:${PATH}"
```

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/09/SszspSFQ.png?resize=845%2C346&ssl=1)

훌륭합니다. 우리는 여기서 진짜 문제를 풀고 있습니다, 여러분. 사람들은 소의 한 줄타기를 좋아한다. 어디선가 내가 그걸 모을 수 있을 것 같아.

요약하면 프로젝트 구성(포트 포워딩, 프로젝트 종속성 설치 등)은 `devcontainer.json`에서, 환경 구성(소프트웨어 설치)은 `Docker 파일`에서 이루어진다. 이제 용기를 내서 좀 더 신경질적인 것을 해보자.

### 고급 구성

잠시 동안 여러분이 정말로 용기에 넣고 싶은 화려하고 매력적인 터미널 설정을 가지고 있다고 가정해 보겠습니다. 제 말은, 단지 컨테이너 안에서 개발한다고 해서 터미널이 지루할 필요는 없어요. 하지만 여러분이 여는 모든 프로젝트에 대해 가식적인 zsh 설정을 재구성하고 싶지는 않을 것입니다. 그것도 자동화할 수 있을까요? 알아보자.

다행히 zsh가 이미 이미지에 설치되어 있습니다. 유일한 문제는 컨테이너가 열릴 때 기본 셸이 아니라는 것입니다. 일반적인 도커 시나리오에서 zsh를 기본 셸로 만들 수 있는 방법은 여러 가지가 있지만 여기서는 모두 작동하지 않습니다. 컨테이너를 만드는 방법을 제어할 수 없기 때문입니다.

대신 신뢰할 수 있는 devcontainer.json 파일을 다시 살펴보십시오. 그 안에는 "설정" 블록이 있다. 실제로 기본 터미널이 ""/bin/bash"로 설정되어 있음을 보여주는 줄이 이미 있습니다. "/bin/zsh"로 변경

```js
// Set *default* container specific settings.json values on container create.
"settings": {
  "terminal.integrated.shell.linux": "/bin/zsh"
}
```

참고로 여기서 임의 VS 코드 설정을 지정할 수 있습니다. 예를 들어, 사이드바를 오른쪽으로 옮기는 것 같은 거죠. 여기요. 제가 고쳐드렸어요.

```js
// Set default container specific settings.json values on container create.
"settings": {
  "terminal.integrated.shell.linux": "/bin/zsh",
  "workbench.sideBar.location": "right"
},
```

그리고 다른 사람들보다 당신을 더 낫게 만드는 가식적인 플러그인은 어떨까요? 이 경우 `.zshrc` 파일이 필요합니다. 컨테이너에 이미 oh-my-zsh가 들어 있고 "root" 폴더에 있습니다. .zshrc의 맨 위에 있는 ZSH로 경로를 설정하여 루트를 가리키도록 하면 됩니다. 이렇게...

``` 
# Path to your oh-my-zsh installation.
export ZSH="/root/.oh-my-zsh"
 
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="cloud"
 
# Which plugins would you like to load?
plugins=(zsh-autosuggestions nvm git)
 
source $ZSH/oh-my-zsh.sh
```

그런 다음 섹시한 `.zshrc` 파일을 Docker 파일의 루트 폴더에 복사할 수 있습니다. 저는 그 .zshrc 파일을 제 프로젝트의 .dev 컨테이너 폴더에 넣었습니다.

``` 
COPY .zshrc /root/.zshrc
```

설치하기 전에 플러그인을 다운로드해야 하는 경우 `RUN` 명령을 사용하여 도커 파일에서 다운로드하십시오. 각 RUN은 새 계층이므로 이 모든 명령을 하나의 명령으로 그룹화해야 합니다. 이제 컨테이너 전문가에 가깝습니다. 다음 단계는 그것에 대한 블로그 글을 쓰고 당신이 발명했던 것과 같은 도커의 방식을 사람들에게 가르치는 것입니다.

``` 
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

아름다운 터미널을 보세요! 색깔을 보세요! 가지를 알려주고 번개모지를 추가하는 깃 플러그인! 사용자 정의된 터미널처럼 "나는 내가 뭘 하는지 안다"는 말은 없습니다. 나는 스타벅스에 내 것을 가지고 가서 사람들이 그것을 실제로 보게 하고 내가 연예인이 아닌지 궁금해하는 것을 좋아해.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/09/sJY2rnlX.png?resize=921%2C352&ssl=1)

### 살살 가라

바라건대, 여러분은 이렇게 생각하셨기를 바랍니다. "이런, 이 사람은 심각하게 과민반응을 하고 있어요. 그렇게 어렵지 않아요." 만약 그렇다면, 나는 당신을 성공적으로 구했습니다. 천만예요 나한테 고마워 할 필요가 없다. 네, 아마존 위시리스트가 있어요.

데이터베이스 추가 또는 Docker Composite와 같은 작업을 수행하는 방법과 같은 원격 컨테이너에 대한 자세한 내용은 100% 덜 신경질적인 설명과 함께 훨씬 더 명확한 설명을 제공하는 공식 원격 컨테이너 문서를 참조하십시오.