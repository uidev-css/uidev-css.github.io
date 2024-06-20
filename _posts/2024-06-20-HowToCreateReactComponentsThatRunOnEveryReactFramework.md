---
title: "React 프레임워크에서 모두 작동하는 React 컴포넌트를 만드는 방법"
description: ""
coverImage: "/assets/img/2024-06-20-HowToCreateReactComponentsThatRunOnEveryReactFramework_0.png"
date: 2024-06-20 13:57
ogImage: 
  url: /assets/img/2024-06-20-HowToCreateReactComponentsThatRunOnEveryReactFramework_0.png
tag: Tech
originalTitle: "How To Create React Components That Run On Every React Framework?"
link: "https://medium.com/bitsrc/create-react-components-in-nextjs-bea5ce6d7171"
---


## React 프레임워크와 호환되는 React 컴포넌트 구축하기 - Next.js, Gatsby, React Native 및 그 외!

React는 2023년 현재 180만 개 이상의 웹사이트에서 사용되고 있습니다. 이는 일반적인 React.js뿐만 아니라 Next.js, React Native 및 Gatsby와 같이 더 복잡한 프레임워크를 사용하는 것을 포함합니다.

따라서 여러 프로젝트에서 이러한 프레임워크를 활용하는 조직의 구성원이라면, 모든 이 프레임워크에 걸쳐 사용할 수 있는 디자인 시스템이 필요할 것입니다. 서로 다른 프레임워크 간에 React 컴포넌트를 사용할 때 성능 또는 호환성 문제를 직면하고 싶지 않을 것입니다.

이것이 바로 내 글이 자리잡는 곳입니다. 여러분에게 모든 React 프레임워크에 적합한 하나의 React 디자인 시스템을 유지하는 방법을 안내해 드릴 것입니다!

<div class="content-ad"></div>

# 모든 프레임워크를 지원하는 React 컴포넌트 개발하기

![이미지](/assets/img/2024-06-20-HowToCreateReactComponentsThatRunOnEveryReactFramework_0.png)

만일 Bit에 대해서 잘 모르시겠다면, 그것은 컴포저블 소프트웨어를 빌드할 수 있는 차세대 빌드 시스템입니다. Bit를 사용하면 독립적인 환경에서 구성, 개발 및 컴포넌트를 빌드할 수 있어서 어떤 프로젝트에서든 어디에서든 사용할 수 있습니다!

이로써 Bit는 모든 프레임워크에서 실행되는 컴포넌트를 빌드하는 완벽한 후보가 됩니다.

<div class="content-ad"></div>

# 단계 01: 준비 사항

우선 Bit을 설치해 봅시다. 다음 명령어를 실행하세요:

```js
npx @teambit/bvm install
```

설치를 확인하려면 다음 명령어를 실행하세요:

<div class="content-ad"></div>

```js
bit --version
```

Bit를 성공적으로 설치했다면, 아래와 같은 출력이 표시될 것입니다:

![Bit Version Output](/assets/img/2024-06-20-HowToCreateReactComponentsThatRunOnEveryReactFramework_1.png)

다음으로, Bit Cloud에 계정을 만들어야 합니다. Bit Cloud를 사용하면 원격 scope에 컴포넌트를 호스팅할 수 있어 다른 프로젝트가 구축 중인 컴포넌트 라이브러리를 사용할 수 있습니다.```

<div class="content-ad"></div>

<img src="/assets/img/2024-06-20-HowToCreateReactComponentsThatRunOnEveryReactFramework_2.png" />

Bit Cloud에 계정을 만든 후에 scope를 생성할 수 있습니다.

<img src="/assets/img/2024-06-20-HowToCreateReactComponentsThatRunOnEveryReactFramework_3.png" />

이 글에서는 scope인 react-component-library를 만들었습니다. scope를 만든 후에는 라이브러리를 구축할 수 있습니다.

<div class="content-ad"></div>

# 단계 02: Bit 워크스페이스 설정하기

라이브러리를 빌드하기 위해 개발자 머신에 워크스페이스를 생성해봅시다. 다음 명령어를 실행하세요:

```js
mkdir workspace && cd workspace && bit init
```

아래 출력 결과를 확인할 수 있어요:

<div class="content-ad"></div>

<img src="/assets/img/2024-06-20-HowToCreateReactComponentsThatRunOnEveryReactFramework_4.png" />

다음으로, IDE에서 워크스페이스를 열고 workspace.jsonc 파일을 다음과 같이 업데이트합니다:

```js
"defaultScope": <<BIT_USERNAME>>.<<SCOPE_NAME>>,
```

이 변경 사항을 워크스페이스 구성 파일에 적용하십시오. 이렇게 하면 정의한 스코프에서 생성된 모든 구성 요소가 호스팅됩니다. 이 글에서는 defaultScope를 다음과 같이 업데이트했습니다:

<div class="content-ad"></div>

```js
"defaultScope": dummyorg.react-component-library
```

이를 이전에 생성한 scope 및 Bit 사용자 이름으로 업데이트할 수 있습니다.

다음으로 특별한 작업을 수행할 것입니다. "환경"을 만들어봅시다. 이 환경은 독립적인 개발을 가능하게 합니다. 현재 당신의 작업 공간은 어떤 프레임워크와도 묶여 있지 않습니다. 당신의 작업 공간에서는 Node.js, Angular, Vue.js, Stencil, React.js 및 더 많은 컴포넌트를 개발할 수 있습니다.

그러니 React 환경을 만들어봅시다. 아래 명령어를 실행하세요:```

<div class="content-ad"></div>

```js
bit create react-env envs/react-18 --aspect teambit.react/react-env
```

![이미지](/assets/img/2024-06-20-HowToCreateReactComponentsThatRunOnEveryReactFramework_5.png)

환경을 만든 후에는 새로운 환경을 기반으로 하는 모든 컴포넌트를 생성할 수 있습니다.

# 단계 03: 모든 프레임워크에서 사용할 수 있는 React 컴포넌트 작성하기
```

<div class="content-ad"></div>

그 다음은 어떤 프레임워크에서도 작동하는 React 컴포넌트를 만들어 봅시다! 이를 보여주기 위해 Next.js 및 React 환경에서 실행할 수 있는 이미지 컴포넌트를 만들어 보겠습니다.

이를 위해 패키지인 next/image를 사용하겠습니다. 우리는 이를 위해 컴포넌트에 Next.js 라이브러리 세트를 설치해야 합니다. 이 작업은 다음 명령어를 실행하여 수행할 수 있습니다:

```js
bit install next  --add-missing-deps  --type peer
```

이렇게 하면 해당 라이브러리가 워크스페이스 내에서 피어 종속성으로 설치됩니다. next 라이브러리를 사용하는 모든 컴포넌트가 자동으로 번들에 포함됩니다.

<div class="content-ad"></div>

다음으로, React 컴포넌트를 생성해 보겠습니다:

```js
bit create react elements/image --env envs/react-18
```

이 명령은 "image"라는 컴포넌트를 생성하고 이전에 만든 새로운 환경을 사용합니다. 이제 React 컴포넌트가 있으니 컴포넌트를 확인해 봅시다. 그러려면 다음 명령을 사용하여 Bit 서버를 시작해 보겠습니다:

```js
bit start
```

<div class="content-ad"></div>

로컬호스트인 localhost:3000에 방문해서 컴포넌트를 확인해보세요:

![이미지](/assets/img/2024-06-20-HowToCreateReactComponentsThatRunOnEveryReactFramework_6.png)

이제 컴포넌트를 만들어봅시다. image.tsx 파일을 열고 다음 스니펫을 추가해보세요:

```js
import React from 'react';
import NextImage from 'next/image';
```

<div class="content-ad"></div>

```js
export type ImageProps = {
  isNextJs?: boolean
  source: string
  name: string
};
export function Image({ isNextJs = false, source, name }: ImageProps) {
  return (
    <NextImage
      src={source}
      alt={name}
      fill
      unoptimized={!isNextJs}
    />
  );
}
```

위와 같이, 우리는 Next.js의 Image 컴포넌트를 활용했고, 다른 프레임워크에 대한 렌더링 전략을 제어하기 위해 unoptimized prop을 활용했습니다.

그 후에는 컴포넌트 미리보기를 생성하기 위해 구성을 만들 수 있습니다.

```js
import React from 'react';
import { Image } from './image';
```

<div class="content-ad"></div>

```js
export const BasicImage = () => {
  return (
    <Image
      name='샘플 이미지'
      source='https://fujifilm-x.com/wp-content/uploads/2021/01/gfx100s_sample_04_thum-1.jpg'
      isNextJs={false}
    />
  );
}
```

그 다음으로 개발 서버로 돌아가면 아래와 같이 출력된 결과를 확인할 수 있습니다:

<img src="/assets/img/2024-06-20-HowToCreateReactComponentsThatRunOnEveryReactFramework_7.png" />

그저 그런 것뿐이에요. 다음으로 해당 명령어를 사용하여 원격 범위로 공유할 수 있어요: 
```

<div class="content-ad"></div>

```js
bit tag && bit export
```

Bit의 Ripple CI에서 빌드를 시작하고 구성 요소를 공개 사용을 위해 빌드합니다. 빌드를 여기에서 확인할 수 있습니다:

![빌드](/assets/img/2024-06-20-HowToCreateReactComponentsThatRunOnEveryReactFramework_8.png)

이후에는 Bit 자체에서 사용할 수 있거나 NPM 패키지로도 사용할 수 있습니다.

<div class="content-ad"></div>

<img src="/assets/img/2024-06-20-HowToCreateReactComponentsThatRunOnEveryReactFramework_9.png" />

여기에서 컴포넌트를 확인할 수 있어요.

# 단계 04: 어떤 프레임워크에서도 컴포넌트 사용하기

그 다음, 이를 테스트해보기 위해 두 개의 앱을 만들어봐요:

<div class="content-ad"></div>

- 리액트 앱
- 넥스트.js 앱

다행히도 Bit은 넥스트.js와 리액트 앱을 모두 지원합니다. 각각의 앱에 대한 App 구성 요소를 생성할 수 있습니다. 이를 위해 다음 명령어를 실행해주세요:

```js
// 리액트 앱 생성
bit create react-app apps/my-app --aspect bitdev.react/react-env
```

```js
// 넥스트.js 앱 생성
bit create nextjs apps/my-nextjs-app --aspect frontend.nextjs/nextjs-env
```

<div class="content-ad"></div>

다음으로, Markdown 포맷으로 표 태그를 변경해보세요.

```markdown
| 작업 | 비고 |
|------|------|
| A    | B    |
| C    | D    |
```

<div class="content-ad"></div>

다음으로, Next.js 앱에서 page.tsx 파일을 열고 아래 코드를 업데이트하세요:

```js
import { Image } from '@dummyorg/react-component-library.elements.image';
import React from 'react';
```

```js
export default function Home() {
  return (
    <Image
      name='샘플 이미지'
      source='https://fujifilm-x.com/wp-content/uploads/2021/01/gfx100s_sample_04_thum-1.jpg'
      isNextJs={true}
    />
  )
}
```

이후, 다음 명령어를 사용하여 앱을 실행하세요:

<div class="content-ad"></div>

```js
bit run my-nextjs-app
```

아래에 표시된 출력을 볼 수 있습니다:

<img src="/assets/img/2024-06-20-HowToCreateReactComponentsThatRunOnEveryReactFramework_11.png" />

그게 다 입니다! 이제 여러분은 어떤 프레임워크에서도 실행할 수 있는 컴포넌트를 만들었습니다!

<div class="content-ad"></div>

# 마무리

쉬웠죠? Bit를 사용하면 어떤 프레임워크에서든 실행할 수 있는 컴포넌트를 만들 수 있어요! 뿐만 아니라 React로 끝나지 않아요. Bit를 사용하면 Node.js, Angular, Vue.js 등 다양한 프레임워크에서 컴포넌트를 만들고 공유할 수 있어요.

예를 들어, 풀스택 개발을 고려 중이라면, Bit를 사용하여 엔티티와 유틸 함수를 프론트엔드와 백엔드 모두에서 쉽게 공유할 수 있어요.

만약 이 내용이 마음에 드시면, 꼭 직접 이 데모를 실행해 보세요!

<div class="content-ad"></div>

감사합니다! 계속 읽어주셔서 감사합니다!

## 더 알아보기