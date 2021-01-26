---
layout: post
title: "React 및 스타일 구성 요소를 사용한 테마 및 테마 전환"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/12/react-sryled-components-themes.jpg
tags: REACT,REACT HOOKS,STYLED COMPONENTS,THEMING
---


최근 웹 사이트에서 테마를 지원해야하는 프로젝트가있었습니다.
 응용 프로그램이 주로 소수의 관리자에 의해 사용되기 때문에 약간 이상한 요구 사항이었습니다.
 더 큰 놀라움은 미리 만들어진 테마 중에서 선택하는 것뿐만 아니라 자신 만의 테마를 만들고 싶어한다는 것입니다.
 나는 사람들이 원하는 것을 원하는 것 같아요!

이를 더 자세한 요구 사항의 전체 목록으로 추출한 다음 완료하겠습니다.

- 테마 정의 (예 : 배경색, 글꼴 색상, 버튼, 링크 등)
- 여러 테마 생성 및 저장
- 테마 선택 및 적용
- 테마 전환
- 테마 사용자 지정

우리는 그것을 고객에게 정확히 전달했고, 마지막으로 들었을 때 그들은 즐겁게 사용하고있었습니다!

정확히 그것을 구축해 보겠습니다.
 React와 스타일 구성 요소를 사용할 것입니다.
 기사에 사용 된 모든 소스 코드는 GitHub 저장소에서 찾을 수 있습니다.

### 설정
verified_user

React 및 스타일 구성 요소로 프로젝트를 설정해 보겠습니다.
 이를 위해 create-react-app을 사용할 것입니다.
 React 애플리케이션을 빠르게 개발하고 테스트하는 데 필요한 환경을 제공합니다.

명령 프롬프트를 열고 다음 명령을 사용하여 프로젝트를 만듭니다.

```terminal
npx create-react-app theme-builder
```

마지막 인수 인`theme-builder`는 프로젝트 이름 (따라서 폴더 이름)입니다.
 원하는 것을 사용할 수 있습니다.

시간이 걸릴 수 있습니다.
 완료되면`cd theme-builder`를 사용하여 명령 줄에서 탐색합니다.
 `src / App.js` 파일을 열고 내용을 다음으로 바꿉니다.

```jsx
import React from 'react';

function App() {
  return (
    <h1>Theme Builder</h1>
  );
}

export default App;
```

이것은 곧 수정할 기본 React 구성 요소입니다.
 프로젝트 루트 폴더에서 다음 명령을 실행하여 앱을 시작합니다.

```terminal
# Or, npm run start
yarn start
```

이제 URL`http : // localhost : 3000`을 사용하여 앱에 액세스 할 수 있습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_3955FEF0416A7A6AA7B97764C92575A5AECBFE093EFDB1EECCFEC66F2777ADB4_1607061267860_1.png?resize=579%2C269&ssl=1)

create-react-app은 앱 구성 요소에 대한 테스트 파일과 함께 제공됩니다.
 이 기사의 일부로 구성 요소에 대한 테스트를 작성하지 않을 것이므로 해당 파일을 삭제하도록 선택할 수 있습니다.

앱에 대한 몇 가지 종속성을 설치해야합니다.
 그래서 우리가있는 동안 그것들을 설치합시다.

```terminal
# Or, npm i ...
yarn add styled-components webfontloader lodash
```

결과는 다음과 같습니다.

- styled-components : CSS로 React 컴포넌트를 스타일링하는 유연한 방법.
 `<ThemeProvider>`라는 래퍼 구성 요소를 사용하여 기본 테마 지원을 제공합니다.
 이 컴포넌트는 그 안에 래핑 된 다른 모든 React 컴포넌트에 테마를 제공하는 역할을합니다.
 우리는 이것을 잠시 후에 볼 것입니다.
- Web Font Loader : Web Font Loader는 Google Fonts, Adobe Fonts 등과 같은 다양한 소스에서 글꼴을로드하는 데 도움이됩니다. 테마가 적용될 때이 라이브러리를 사용하여 글꼴을로드합니다.
- lodash : 이것은 약간의 편리한 추가 기능을위한 JavaScript 유틸리티 라이브러리입니다.

### 테마 정의

이것이 우리의 첫 번째 요구 사항입니다.
 테마는 색상, 글꼴 등을 포함하여 모양을 정의하기위한 특정 구조를 가져야합니다. 응용 프로그램의 경우 다음 속성을 사용하여 각 테마를 정의합니다.

- 고유 식별자
- 테마 이름
- 색상 정의
- 글꼴

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/12/528-cdBI.png?resize=900%2C500&ssl=1)

더 많은 속성 및 / 또는 구조화 방법이있을 수 있지만 이것이 우리의 예에서 사용할 것입니다.

### 여러 테마 생성 및 저장

그래서 우리는 테마를 정의하는 방법을 보았습니다.
 이제 프로젝트의`src / theme` 폴더와`schema.json`이라는 파일을 추가하여 여러 테마를 만들어 보겠습니다.
 "빛"및 "바다 파도"테마를 설정하기 위해 해당 파일에 드롭 할 수있는 항목은 다음과 같습니다.

```js
{
  "data" : {
    "light" : {
      "id": "T_001",
      "name": "Light",
      "colors": {
        "body": "#FFFFFF",
        "text": "#000000",
        "button": {
          "text": "#FFFFFF",
          "background": "#000000"
        },
        "link": {
          "text": "teal",
          "opacity": 1
        }
      },
      "font": "Tinos"
    },
    "seaWave" : {
      "id": "T_007",
      "name": "Sea Wave",
      "colors": {
        "body": "#9be7ff",
        "text": "#0d47a1",
        "button": {
          "text": "#ffffff",
          "background": "#0d47a1"
        },
        "link": {
          "text": "#0d47a1",
          "opacity": 0.8
        }
      },
      "font": "Ubuntu"
    }
  }
}
```

`schema.json` 파일의 내용을 데이터베이스에 저장할 수 있으므로 테마 선택과 함께 모든 테마를 유지할 수 있습니다.
 지금은 브라우저의 `localStorage`에 저장하기 만하면됩니다.
 이를 위해`src / utils`에`storage.js`라는 새 파일이있는 다른 폴더를 만듭니다.
 `localStorage`를 설정하려면 몇 줄의 코드 만 있으면됩니다.

```jsx
export const setToLS = (key, value) => {
  window.localStorage.setItem(key, JSON.stringify(value));
}

export const getFromLS = key => {
  const value = window.localStorage.getItem(key);

  if (value) {
    return JSON.parse(value);
  }
}
```

브라우저의 `localStorage`에 데이터를 저장하고 거기에서 검색하는 간단한 유틸리티 함수입니다.
 이제 앱이 처음 표시 될 때 테마를 브라우저의 `localStorage`에로드합니다.
 그렇게하려면`index.js` 파일을 열고 내용을 다음으로 바꿉니다.

```jsx
import React from 'react';
import ReactDOM from 'react-dom';
import App from './App';

import * as themes from './theme/schema.json';
import { setToLS } from './utils/storage';

const Index = () => {
  setToLS('all-themes', themes.default);
  return(
    <App />
  )
}

ReactDOM.render(
  <Index />
  document.getElementById('root')
);
```

여기서는`schema.json` 파일에서 테마 정보를 가져와`all-themes` 키를 사용하여`localStorage`에 추가합니다.
 앱 실행을 중지 한 경우 다시 시작하고 UI에 액세스하십시오.
 브라우저에서 DevTools를 사용하여 테마가`localStorage`에로드되었는지 확인할 수 있습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_3955FEF0416A7A6AA7B97764C92575A5AECBFE093EFDB1EECCFEC66F2777ADB4_1607081516470_3.png?resize=1915%2C858&ssl=1)

### 테마 선택 및 적용

이제 테마 구조를 사용하여`<ThemeProvider>`래퍼에 테마 개체를 제공 할 수 있습니다.

먼저 커스텀 리 액트 후크를 생성합니다.
 테마가 올바르게로드되었는지 또는 문제가 있는지 확인하여 선택한 테마를 관리합니다.
 `src / theme` 폴더에있는 새`useTheme.js` 파일부터 시작해 보겠습니다.

```jsx
import { useEffect, useState } from 'react';
import { setToLS, getFromLS } from '../utils/storage';
import _ from 'lodash';

export const useTheme = () => {
  const themes = getFromLS('all-themes');
  const [theme, setTheme] = useState(themes.data.light);
  const [themeLoaded, setThemeLoaded] = useState(false);

  const setMode = mode => {
    setToLS('theme', mode)
    setTheme(mode);
  };

  const getFonts = () => {
    const allFonts = _.values(_.mapValues(themes.data, 'font'));
    return allFonts;
  }

  useEffect(() =>{
    const localTheme = getFromLS('theme');
    localTheme ? setTheme(localTheme) : setTheme(themes.data.light);
    setThemeLoaded(true);
  }, []);

  return { theme, themeLoaded, setMode, getFonts };
};
```

이 커스텀 React 후크는`localStorage`에서 선택한 테마를 반환하고 테마가 스토리지에서 올바르게로드되었는지를 나타내는 부울을 반환합니다.
 또한 테마를 프로그래밍 방식으로 적용하는 `setMode`함수도 제공합니다.
 우리는 그것에 대해 조금 후에 돌아올 것입니다.
 이를 통해 나중에 웹 글꼴 로더를 사용하여로드 할 수있는 글꼴 목록도 얻을 수 있습니다.

사이트의 배경색, 글꼴, 버튼 등을 제어하려면 전역 스타일을 사용하는 것이 좋습니다. styled-components는 테마 인식 전역 구성 요소를 설정하는`createGlobalStyle`이라는 구성 요소를 제공합니다.
 다음 코드를 사용하여`src / theme` 폴더에있는`GlobalStyles.js`라는 파일에서 설정해 보겠습니다.

```jsx
import { createGlobalStyle} from "styled-components";

export const GlobalStyles = createGlobalStyle`
  body {
    background: ${({ theme }) => theme.colors.body};
    color: ${({ theme }) => theme.colors.text};
    font-family: ${({ theme }) => theme.font};
    transition: all 0.50s linear;
  }

  a {
    color: ${({ theme }) => theme.colors.link.text};
    cursor: pointer;
  }

  button {
    border: 0;
    display: inline-block;
    padding: 12px 24px;
    font-size: 14px;
    border-radius: 4px;
    margin-top: 5px;
    cursor: pointer;
    background-color: #1064EA;
    color: #FFFFFF;
    font-family: ${({ theme }) => theme.font};
  }

  button.btn {
    background-color: ${({ theme }) => theme.colors.button.background};
    color: ${({ theme }) => theme.colors.button.text};
  }
`;
```

`<body>`, 링크 및 버튼에 대한 CSS 만 있으면됩니다.
 `App.js` 파일에서이를 사용하여 테마의 내용을 다음으로 대체하여 작동중인 테마를 볼 수 있습니다.

```jsx
// 1: Import
import React, { useState, useEffect } from 'react';
import styled, { ThemeProvider } from "styled-components";
import WebFont from 'webfontloader';
import { GlobalStyles } from './theme/GlobalStyles';
import {useTheme} from './theme/useTheme';

// 2: Create a cotainer
const Container = styled.div`
  margin: 5px auto 5px auto;
`;

function App() {
  // 3: Get the selected theme, font list, etc.
  const {theme, themeLoaded, getFonts} = useTheme();
  const [selectedTheme, setSelectedTheme] = useState(theme);

  useEffect(() => {
    setSelectedTheme(theme);
   }, [themeLoaded]);

  // 4: Load all the fonts
  useEffect(() => {
    WebFont.load({
      google: {
        families: getFonts()
      }
    });
  });

  // 5: Render if the theme is loaded.
  return (
    <>
    {
      themeLoaded && <ThemeProvider theme={ selectedTheme }>
        <GlobalStyles/>
        <Container style={{fontFamily: selectedTheme.font}}>
          <h1>Theme Builder</h1>
          <p>
            This is a theming system with a Theme Switcher and Theme Builder.
            Do you want to see the source code? <a href="https://github.com/atapas/theme-builder" target="_blank">Click here.</a>
          </p>
        </Container>
      </ThemeProvider>
    }
    </>
  );
}

export default App;
```

여기에서 몇 가지 일이 일어나고 있습니다.

- `useState` 및`useEffect` React 후크를 가져 와서 모든 상태 변수와 부작용으로 인한 변경 사항을 추적 할 수 있습니다.
 스타일 구성 요소에서`ThemeProvider` 및`styled`를 가져옵니다.
 `WebFont`도 가져 와서 글꼴을로드합니다.
 또한 사용자 정의 테마 `useTheme`와 전역 스타일 구성 요소 인 `GlobalStyles`도 가져옵니다.
- CSS 스타일과 `styled`구성 요소를 사용하여 `Container`구성 요소를 만듭니다.
- 상태 변수를 선언하고 변경 사항을 확인합니다.
- 앱에 필요한 모든 글꼴을로드합니다.
- 우리는 많은 텍스트와 링크를 렌더링합니다.
 그러나 선택한 테마를 소품으로 사용하는`<ThemeProvider>`래퍼로 전체 콘텐츠를 래핑합니다.
 `<GlobalStyles />`구성 요소도 전달합니다.

앱을 새로 고치면 기본 "light"테마가 활성화 된 것을 볼 수 있습니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_3955FEF0416A7A6AA7B97764C92575A5AECBFE093EFDB1EECCFEC66F2777ADB4_1607178376927_4.png?resize=1273%2C279&ssl=1)

테마 전환이 작동하는지 확인해야합니다.
 이제`useTheme.js` 파일을 열고 다음 줄을 변경해 보겠습니다.

```jsx
localTheme ? setTheme(localTheme) : setTheme(themes.data.light);
```

…에:

```jsx
localTheme ? setTheme(localTheme) : setTheme(themes.data.seaWave);
```

앱을 다시 새로 고침하면 "바다 물결"테마가 작동하는 것을 볼 수 있습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_3955FEF0416A7A6AA7B97764C92575A5AECBFE093EFDB1EECCFEC66F2777ADB4_1607178437520_5.png?resize=1428%2C317&ssl=1)

### 테마 전환

큰!
 테마를 올바르게 적용 할 수 있습니다.
 버튼 클릭만으로 테마를 전환하는 방법을 만드는 것은 어떻습니까?
 물론 그렇게 할 수 있습니다!
 테마 미리보기도 제공 할 수 있습니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_3955FEF0416A7A6AA7B97764C92575A5AECBFE093EFDB1EECCFEC66F2777ADB4_1607180590767_6.png?resize=1902%2C476&ssl=1)

이러한 각 상자를 `ThemeCard`라고 부르고 테마 정의를 소품으로 사용할 수 있도록 설정해 보겠습니다.
 모든 테마를 살펴보고 반복하여 각각을 `ThemeCard`구성 요소로 채 웁니다.

```jsx
{
  themes.length > 0 && 
  themes.map(theme =>(
    <ThemeCard theme={data[theme]} key={data[theme].id} />
  ))
}
```

이제`ThemeCard`의 마크 업으로 넘어가겠습니다.
 당신의 것들은 다르게 보일 수 있지만 우리가 자체 색상과 글꼴 속성을 어떻게 추출하고 그것들을 적용하는지 주목하십시오 :

```jsx
const ThemeCard = props => {
  return(
    <Wrapper>
      <span>Click on the button to set this theme</span>
      <ThemedButton
        onClick={ (theme) => themeSwitcher(props.theme) }
        >
        {props.theme.name}
      </ThemedButton>
    </Wrapper>
  )
}
```

다음으로`src` 폴더에`ThemeSelector.js`라는 파일을 만들어 보겠습니다.
 여기에서 콘텐츠를 복사하여 파일에 드롭하여 테마 전환기를 설정합니다. `App.js`에서 가져와야합니다.

```jsx
import ThemeSelector from './ThemeSelector';
```

이제`Container` 구성 요소 내에서 사용할 수 있습니다.

```jsx
<Container style={{fontFamily: selectedTheme.font}}>
  // same as before
  <ThemeSelector setter={ setSelectedTheme } />
</Container> 

```

이제 브라우저를 새로 고침하고 테마 전환이 어떻게 작동하는지 살펴 보겠습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_3955FEF0416A7A6AA7B97764C92575A5AECBFE093EFDB1EECCFEC66F2777ADB4_1607180745542_7.gif?resize=1518%2C676&ssl=1)

재미있는 부분은`schema.json` 파일에 많은 테마를 추가하여 UI에서로드하고 전환 할 수 있다는 것입니다.
 더 많은 테마를 보려면이`schema.json` 파일을 확인하십시오.
 적용된 테마 정보도 `localStorage`에 저장되므로 다음에 앱을 다시 열 때 선택 항목이 유지됩니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_3955FEF0416A7A6AA7B97764C92575A5AECBFE093EFDB1EECCFEC66F2777ADB4_1607180780281_8.png?resize=1506%2C729&ssl=1)

### 테마 사용자 지정

사용자는 한 테마의 일부 측면과 다른 테마의 측면을 좋아할 수 있습니다.
 테마 소품을 스스로 정의 할 수있는 능력을 부여 할 수 있는데 왜 그들 중 하나를 선택하게 만드나요!
 사용자가 원하는 모양 옵션을 선택하고 기본 설정을 저장할 수있는 간단한 사용자 인터페이스를 만들 수 있습니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_3955FEF0416A7A6AA7B97764C92575A5AECBFE093EFDB1EECCFEC66F2777ADB4_1607182088360_Demo_2.gif?resize=1881%2C844&ssl=1)

테마 생성 코드에 대한 자세한 설명은 다루지 않겠지 만 GitHub Repo의 코드를 따르면 쉽게 이해할 수 있습니다.
 메인 소스 파일은`CreateThemeContent.js`이며`App.js`에서 사용합니다.
 각 입력 요소 변경 이벤트에서 값을 수집하여 새 테마 개체를 만들고 테마 개체 컬렉션에 개체를 추가합니다.
 그게 다야.

### 끝내기 전에 ...

읽어 주셔서 감사합니다!
 여기에서 다룬 내용이 현재 작업중인 작업에 도움이 되었기를 바랍니다.
 테마 시스템은 재미 있습니다!
 실제로 CSS 사용자 정의 속성은이를 점점 더 중요하게 만들고 있습니다.
 예를 들어, Dieter Raber의 색상에 대한이 접근 방식과 Chris의 이번 라운드 업을 확인하십시오.
 Tailwind CSS와 함께 사용되는 맞춤 속성에 의존하는 Michelle Barker의이 설정도 있습니다.
 Andrés Galente의 또 다른 방법이 있습니다.

이 모든 것이 테마를 만드는 좋은 예인 경우이 기사가 속성을 저장하고, 테마간에 쉽게 전환하고, 사용자에게 테마를 사용자 지정하고, 이러한 기본 설정을 저장함으로써 해당 개념을 다음 단계로 끌어 올리는 데 도움이되기를 바랍니다.

연결합시다!
 댓글이있는 Twitter에서 나를 DM으로 보내거나 언제든지 팔로우 할 수 있습니다.