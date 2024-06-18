---
title: "엔드 투 엔드 개발 환경을 설정하는 방법"
description: ""
coverImage: "/assets/img/2024-06-19-HowtoSetUpAnEnd-to-EndDevelopmentEnvironment_0.png"
date: 2024-06-19 08:27
ogImage: 
  url: /assets/img/2024-06-19-HowtoSetUpAnEnd-to-EndDevelopmentEnvironment_0.png
tag: Tech
originalTitle: "How to Set Up An End-to-End Development Environment?"
link: "https://medium.com/bitsrc/end-to-end-development-with-bit-d1d493e09d8e"
---


## Bit를 사용하여 End-To-End 개발 환경 구축하기

예를 들어, React.js와 Express.js 두 가지 프레임워크를 사용하는 프로젝트를 작업 중이라고 상상해보세요.

일반적으로 단일 모노 레포지토리에서 작업하거나 프로젝트를 진행할 때 폴리-레포 구조를 사용할 것입니다, 맞죠? 그리고 엔드-투-엔드 기능을 개발 중이라면 로컬 환경에서 프론트엔드와 백엔드를 각각 설정하고 독립적으로 실행해야 할 것입니다.

<div class="content-ad"></div>

예를 들어, 새 팀원이 프로젝트에 새 종속성을 설치하면, 당신은 설정에서 종속성을 수동으로 설치해야 합니다. 그렇지 않으면 오류가 발생할 수 있습니다.

그래서 오늘 우리가 바로 그것을 해결할 것입니다. 사실, 우리는 애플리케이션을 더 잘 확장할 수 있게 해주는 개발 환경을 유지하는 최적화된 방법을 살펴볼 것입니다.

# 들어가며, Bit

이를 위해 우리는 Bit라는 도구를 사용하여 독립 컴포넌트를 사용하여 애플리케이션을 구축할 것입니다.

<div class="content-ad"></div>

이는 앱의 한 부분에 작업을 수행하기 위해 전체 프로젝트에 액세스할 필요가 없다는 것을 의미합니다. 필요한 구성 요소만 있으면 작업을 진행할 수 있어요. 예를 들어, 다음 구성 요소 트리를 고려해 보세요:

자세히 살펴보면 Bit가 서로 의존하는 모든 구성 요소를 추적한다는 것을 알 수 있어요. 예를 들어, Text Icon은 Typography 구성 요소를 사용해요. 그래서 Typography 구성 요소를 수정하고 싶다면 아래와 같은 단계만 따르면 돼요:

- 구성 요소 가져오기
- 수정 작업 수행
- 구성 요소 내보내기

이후, Bit는 CI 서버인 Ripple CI를 활용하여 영향을 받는 전체 구성 요소 트리를 빌드하고 변경 사항을 전파하며 각 구성 요소가 기대한 대로 작동하는지 확인하기 위해 단위 테스트를 실행할 거에요.

<div class="content-ad"></div>

# 엔드 투 엔드 개발 환경 구축

이제 비트(Bit)가 무엇인지 알았으니, 도구를 사용하여 엔드 투 엔드 개발 환경을 구축해 봅시다.

## 단계 01: 준비 사항

우선, 비트를 설치해 보겠습니다. 아래 명령어를 실행해 주세요:

<div class="content-ad"></div>

```js
npx @teambit/bvm install
```

설치를 확인하려면 다음 명령을 실행하세요:

```js
bit --version
```

Bit를 성공적으로 설치한 경우 아래에 표시된 결과가 표시됩니다:

<div class="content-ad"></div>

<img src="/assets/img/2024-06-19-HowtoSetUpAnEnd-to-EndDevelopmentEnvironment_0.png" />

다음으로, Bit Cloud에 계정을 생성해야 합니다. Bit Cloud를 사용하면 원격 범위에서 개발 환경을 호스팅할 수 있습니다. 이를 통해 작업 중인 모든 프로젝트에서 환경을 사용할 수 있습니다.

Bit Cloud에 계정을 생성한 후 범위(scope)를 만들 수 있습니다.

이 기사에서는 end-to-end-environments라는 범위(scope)를 만들었습니다. 범위를 만든 후 개발 환경을 구축할 수 있습니다.

<div class="content-ad"></div>

## 단계 02: 비트 워크스페이스 만들기

다음으로는 비트 워크스페이스를 생성해야 합니다. 다음 명령어를 사용하여 이 작업을 수행할 수 있습니다:

```js
mkdir workspace && cd workspace && bit init
```

다음으로는 workspace.jsonc로 이동하여 defaultScope 항목을 다음과 같이 업데이트하세요 — ``당신의 비트 사용자명``.``당신의 스코프 이름``. 제 경우에는 다음과 같이 보일 것입니다:

<div class="content-ad"></div>

```markdown
![이미지](/assets/img/2024-06-19-HowtoSetUpAnEnd-to-EndDevelopmentEnvironment_1.png)

이렇게 하면이 작업 공간에서 만드는 모든 구성 요소가 기본적으로 지정된 범위에서 유지됩니다.

사실, 빈 디렉토리만 보게 될 것입니다:

![이미지](/assets/img/2024-06-19-HowtoSetUpAnEnd-to-EndDevelopmentEnvironment_2.png)
```

<div class="content-ad"></div>

## 개발 환경 이해하기

사실 컴포넌트를 구축하기 위해 "개발 환경"이 필요합니다. 여기서 우리는 실제로 엔드투엔드 환경을 구축합니다. 컴포넌트를 생성할 환경을 구축할 수 있습니다.

![이미지](/assets/img/2024-06-19-HowtoSetUpAnEnd-to-EndDevelopmentEnvironment_3.png)

따라서 완전히 기능적인 엔드투엔드 환경을 구축하기 위해 두 가지가 필요합니다:

<div class="content-ad"></div>

- 리액트 환경: 이것은 우리의 리액트 컴포넌트를 만드는 데 사용될 것입니다.
- Node.js 환경: 이것은 우리의 백엔드 컴포넌트를 만드는 데 사용될 것입니다.

## 단계 03: 리액트 환경 구축하기

MUI를 사용하여 리액트 컴포넌트를 구축 중이라고 가정해 봅시다. 따라서, 이상적으로는 우리의 리액트 환경은 리액트 컴포넌트에게 MUI를 사용할 수 있는 기능을 제공해야 합니다.

리액트 환경을 만들려면 다음 명령을 실행하세요:

<div class="content-ad"></div>

```js
bit create react-env envs/react-mui --aspect teambit.react/react-env
```

이 명령어는 우리의 필요에 맞게 사용자 정의 환경인 `react-mui`를 생성합니다. 생성 후 아래와 같은 출력이 표시됩니다:

![이미지](/assets/img/2024-06-19-HowtoSetUpAnEnd-to-EndDevelopmentEnvironment_4.png)

`env.jsonc` 파일을 열어봅시다. 이 파일은 환경에 대한 모든 종속성을 처리하는 파일입니다. 따라서 이 환경을 사용하는 모든 구성요소는 여기에서 정의한 종속성을 사용할 수 있습니다.```

<div class="content-ad"></div>

그래서 우리 경우에는, MUI 종속성을 포함해 봅시다:

```js
{
   /**
   * 컴포넌트 종속성을 표준화하세요.
   * @see https://bit.dev/docs/react-env/dependencies
   **/
  "policy": {
   /**
   * 해당 환경을 사용하는 컴포넌트에 대한 피어 종속성.
   */
     "peers": [
       {
         "name": "@emotion/react",
         "version": "^11.11.3",
         "supportedRange": "^11.11.3"
       },
       {
         "name": "@emotion/styled",
         "version": "^11.11.0",
         "supportedRange": "^11.11.0"
       },
       {
         "name": "@mui/material",
         "version": "^5.15.7",
         "supportedRange": "^5.15.7"
       },
       // 다른 피어 종속성
     ],
     // 기타...
  }
}
```

그리고 실제로 MUI를 활용하는 React 환경에 대한 설정은 여기까지입니다. 이제 MUI를 사용하는 React 컴포넌트를 만들 수 있습니다.

## 단계 04: 환경을 활용한 React 컴포넌트 작성하기

<div class="content-ad"></div>

환경을 사용하려면 React 컴포넌트를 만들어 보겠습니다. 다음 명령을 실행해주세요:

```js
bit create react ui/button --env envs/react-mui
```

아래와 같은 결과가 나타날 것입니다:

![이미지](/assets/img/2024-06-19-HowtoSetUpAnEnd-to-EndDevelopmentEnvironment_5.png)

<div class="content-ad"></div>

위에서 볼 수 있듯이 해당 구성 요소는 새로 생성된 env를 사용합니다. 이제 button.tsx 파일을 업데이트하여 Button을 구현해 봅시다:

```js
import { Button as MUIButton, ButtonProps as MUIButtonProps } from '@mui/material';

export type ButtonProps = {
} & MUIButtonProps;

export function Button({ children, variant = 'contained', ...rest }: ButtonProps) {
  return (
    <MUIButton
      variant={variant}
      {...rest}
    >
      {children}
    </MUIButton>
  );
}
```

보시다시피, 이제 구성 요소에서 MUI를 자유롭게 활용할 수 있습니다. 이제 아래 명령어를 사용하여 Bit 서버를 시작해 보세요:

```js
bit start
```

<div class="content-ad"></div>

다음으로, localhost:3000을 방문하여 서버를 열어보세요. 아래에 표시된 것처럼 당신의 Button 컴포넌트가 MUI와 함께 작동 중인 것을 볼 수 있어야 합니다:

![Button component](/assets/img/2024-06-19-HowtoSetUpAnEnd-to-EndDevelopmentEnvironment_6.png)

이제 Bit Cloud로 내보내어 Ripple이 작동하는 것을 확인해보겠습니다. 이를 위해 다음 명령을 실행하세요:

```js
bit tag && bit export
```

<div class="content-ad"></div>

결론적으로 Ripple Build가 범위 내에서 보이는지 확인할 수 있어야 합니다:

![Ripple Build](/assets/img/2024-06-19-HowtoSetUpAnEnd-to-EndDevelopmentEnvironment_7.png)

## 단계 05: Node.js 환경 구축

이제 프론트엔드 구성 요소를 빌드할 수 있으므로, 백엔드 환경을 만들어봅시다. 백엔드 환경을 만들기 위해 Node.js 환경을 만들어보겠습니다:

<div class="content-ad"></div>

```js
bit create node-env envs/node-environment --aspect bitdev.node/node-env
```

위 명령어를 입력하면 아래와 같은 출력을 확인할 수 있습니다:

<img src="/assets/img/2024-06-19-HowtoSetUpAnEnd-to-EndDevelopmentEnvironment_8.png" />

자, 그럼 앞으로 진행해서 Node 구성 요소의 env.jsonc 파일을 업데이트하여 Axios를 추가해 봅시다:

<div class="content-ad"></div>

```json
{
  /**
   * 컴포넌트 종속성을 표준화하세요.
   * @see https://bit.dev/docs/node-env/dependencies
   */
  "policy": {
    /**
     * 해당 환경을 사용하는 컴포넌트의 피어 종속성.
     */
    "peers": [
      {
        "name": "axios",
        "version": "^1.6.7",
        "supportedRange": "^1.6.7"
      },
      // 이어서
    }
  }
}
```

그런 다음, 이전에 한 것처럼 이를 태그하여 스코프로 내보냅니다. 이 작업을 완료하면 Ripple 빌드가 표시됩니다:

![2024-06-19-HowtoSetUpAnEnd-to-EndDevelopmentEnvironment_9.png](/assets/img/2024-06-19-HowtoSetUpAnEnd-to-EndDevelopmentEnvironment_9.png)

## 단계 05: 환경을 사용하여 Node.js 컴포넌트 빌드하기```

<div class="content-ad"></div>

다음은 Node.js 환경을 사용하여 Fetcher라는 구성 요소를 구축해 봅시다. 이 구성 요소는 주어진 URL에서 데이터를 가져올 것입니다.

아래 명령어를 사용하여 구성 요소를 생성해 봅시다:

```js
bit create node services/fetcher --env envs/node-environment
```

위 명령을 실행하면 다음 출력이 표시됩니다:

<div class="content-ad"></div>

아래는 Markdown 형식으로 표현한 표입니다.

```markdown
| 열1 | 열2 | 열3 |
|-----|-----|-----|
| 항목1 | 항목2 | 항목3 |
| 내용1 | 내용2 | 내용3 |
```

<div class="content-ad"></div>

다음으로, 컴포넌트를 태그하고 Bit Cloud에 내보낸 후 Ripple CI를 확인할 수 있습니다:

# 마무리

그러면 대략적으로 이것으로 끝이에요. 직관적이었죠? 이제 해야 할 일은 Backend 및 Frontend 컴포넌트를 빌드할 때 환경을 사용하는 것뿐입니다.

컴포넌트를 생성하고 나면 Bit에서 이 두 참조를 사용하여 Express API 및 React 앱을 만들 수 있습니다:

<div class="content-ad"></div>

이 완벽한 구현을 확인하려면 Bit Scope을 방문해 주세요.

이 글이 도움이 되셨기를 바랍니다.

읽어 주셔서 감사합니다!

# 더 배우기