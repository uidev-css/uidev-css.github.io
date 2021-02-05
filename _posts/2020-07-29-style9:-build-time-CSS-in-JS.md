---
layout: post
title: "style9: 빌드 시간 CSS-in-JS"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2018/05/css-in-js.jpg
tags: CSS-IN-JS
---


작년 4월, 페이스북은 큰 새로운 재설계를 공개했습니다. 야심찬 프로젝트, 그것은 엄청난 양의 사용자가 있는 큰 사이트를 재건한 것이었다. 이를 달성하기 위해, 그들은 React, GraphQL, Relay, stylex라고 불리는 새로운 CSS-in-JS 라이브러리와 같이 그들이 만들고 오픈 소스화한 몇 가지 기술을 사용했다.

이 새로운 라이브러리는 페이스북 내부에 있지만, 그들은 오픈 소스 구현인 style9를 가능하게 하기 위해 그것에 대한 충분한 정보를 공유했다.

### 왜 또 다른 CIJ 도서관이죠?

이미 많은 CSS-in-JS 라이브러리가 존재하기 때문에 다른 라이브러리가 필요한 이유는 분명하지 않을 수 있다. style9은 범위 선택기, 데드 코드 제거, 결정론적 해상도, CSS와 자바스크립트 사이의 값을 공유하는 능력을 포함하여 크리스토퍼 체도에 의해 표현된 모든 다른 CIJ 솔루션들과 같은 장점을 가지고 있다.

그러나 스타일 9를 독특하게 만드는 몇 가지가 있다.

비록 자바스크립트에서 스타일이 정의되지만, 컴파일러에 의해 일반 CSS 파일로 추출된다. 즉, 최종 JavaScript 파일에 스타일이 제공되지 않습니다. 남은 것은 일반적인 경우와 마찬가지로 최소 런타임이 조건부로 적용되는 최종 클래스 이름뿐입니다. 따라서 코드 번들이 작아지고 메모리 사용량이 감소하며 렌더링 속도가 빨라집니다.

값은 컴파일 시 추출되므로 진정한 동적 값을 사용할 수 없습니다. 이러한 기능은 다행히 매우 흔하지 않으며 고유하므로 인라인으로 정의되는 데 어려움을 겪지 않습니다. 더 일반적인 것은 스타일을 조건부로 적용하는 것인데, 물론 이러한 스타일은 지원됩니다. babel의 path.evaluate 덕분에 로컬 상수와 수학 식도 마찬가지입니다.

style9의 작동 방식 때문에 모든 속성 선언을 단일 속성으로 자체 클래스로 만들 수 있습니다. 따라서 예를 들어, 코드 내 여러 곳에서 `opacity: 0`을 사용하면 생성된 CSS에 한 번만 존재할 수 있습니다. 이것의 이점은 CSS 파일이 선언의 총량이 아니라 고유 선언의 수에 따라 증가한다는 것이다. 대부분의 속성이 여러 번 사용되기 때문에 CSS 파일이 훨씬 더 작아질 수 있습니다. 예를 들어, 페이스북의 예전 홈페이지는 413KB의 gziped CSS를 사용했다. 재설계는 모든 페이지에 74KB를 사용합니다. 또한 파일 크기가 작아지면 성능이 향상됩니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/07/logarithmic.jpg?resize=1024%2C576&ssl=1)

일부는 생성된 클래스 이름이 의미적이지 않고 불투명하며 계단식 이름을 무시하고 있다고 불평할 수 있다. 이것은 사실입니다. 우리는 CSS를 컴파일 대상으로 취급하고 있습니다. 하지만 그럴만한 이유가 있어. 이전에 가정한 모범 사례에 의문을 제기함으로써 사용자와 개발자의 경험을 모두 개선할 수 있습니다.

또한 style9에는 TypeScript를 사용하는 유형, 사용되지 않는 스타일 제거, JavaScript 변수 사용 기능, 미디어 쿼리, 의사 선택기 및 키 프레임 지원 등 많은 다른 훌륭한 기능이 있다.

### 사용 방법은 다음과 같습니다.

먼저 평소와 같이 설치합니다.

```terminal
npm install style9
```

style9은 롤업, 웹팩, 개츠비, 넥스트.js를 위한 플러그인을 가지고 있으며, 이 플러그인은 모두 바벨 플러그인을 기반으로 한다. 이러한 장치의 사용 방법에 대한 지침은 저장소에서 확인할 수 있습니다. 여기 웹팩 플러그인을 사용하겠습니다.

```js
const Style9Plugin = require('style9/webpack');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');

module.exports = {
  module: {
    rules: [
      // This will transform the style9 calls
      {
        test: /\.(tsx|ts|js|mjs|jsx)$/,
        use: Style9Plugin.loader
      },
      // This is part of the normal Webpack CSS extraction
      {
        test: /\.css$/i,
        use: [MiniCssExtractPlugin.loader, 'css-loader']
      }
    ]
  },
  plugins: [
    // This will sort and remove duplicate declarations in the final CSS file
    new Style9Plugin(),
    // This is part of the normal Webpack CSS extraction
    new MiniCssExtractPlugin()
  ]
};
```

### 스타일 정의

스타일을 만드는 구문은 다른 라이브러리와 매우 유사합니다. 먼저 style9.create를 스타일 객체와 함께 호출합니다.

```js
import style9 from 'style9';

const styles = style9.create({
  button: {
    padding: 0,
    color: 'rebeccapurple'
  },
  padding: {
    padding: 12
  },
  icon: {
    width: 24,
    height: 24
  }
});
```

모든 선언은 원자 클래스로 이어지기 때문에 속성을 여러 개 설정하기 때문에 flex:1과 background: blue와 같은 단축어는 작동하지 않는다. 패딩, 마진, 오버플로우 등 확장 가능한 속성이 롱핸드 모델로 자동 전환된다. TypeScript를 사용하면 지원되지 않는 속성을 사용할 때 오류가 발생합니다.

### 스타일 결정

클래스 이름을 생성하기 위해 이제 style9.create에서 반환되는 함수를 호출할 수 있습니다. 이것은 우리가 사용하고자 하는 스타일의 키를 인수로 받아들인다.

```js
const className = styles('button');
```

이 함수는 오른쪽 스타일이 우선하며 `Object.assign`과 같은 왼쪽 스타일과 병합되는 방식으로 작동합니다. 다음은 12px의 패딩과 `rebeccapple` 텍스트의 요소를 나타낸다.

```js
const className = styles('button', 'padding');
```

다음 형식 중 하나를 사용하여 스타일을 조건부로 적용할 수 있습니다.

```js
// logical AND
styles('button', hasPadding && 'padding');
// ternary
styles('button', isGreen ? 'green' : 'red');
// object of booleans
styles({
  button: true,
  green: isGreen,
  padding: hasPadding
});
```

이러한 함수 호출은 컴파일 중에 제거되고 직접 문자열 연결로 대체됩니다. 위 코드의 첫 번째 줄은 `c1r9f2e5` + has 패딩 ? `cu2kwdz :`와 같은 것으로 대체될 것이다.

### 스타일 결합

우리는 유형 객체를 속성 이름으로 액세스하여 style9로 전달함으로써 확장할 수 있습니다.

```js
const styles = style9.create({ blue: { color: 'blue; } });
const otherStyles = style9.create({ red: { color: 'red; } });

// will be red
const className = style9(styles.blue, otherStyles.red);
```

함수 호출과 마찬가지로 오른쪽 스타일이 우선합니다. 그러나 이 경우 클래스 이름을 정적으로 확인할 수 없습니다. 대신 속성 값이 클래스로 대체되고 런타임에 조인됩니다. 속성은 이전과 마찬가지로 CSS 파일에 추가됩니다.

### 요약

CSS-in-JS의 이점은 매우 현실적이다. 즉, 우리는 코드에 스타일을 포함시킬 때 성능 비용을 부과하고 있다. 빌드 시간 동안 값을 추출하면 두 가지 모두를 최대로 활용할 수 있습니다. 마크업과 스타일을 공동 배치하고 기존 JavaScript 인프라를 사용할 수 있는 동시에 최적의 스타일시트를 생성할 수 있다는 이점이 있다.

만약 스타일 9가 당신에게 흥미롭게 들린다면, 레포 한 번 보고 시도해 보세요. 그리고 궁금한 점이 있으면 언제든지 이슈를 열거나 연락하세요.

주세페 구론(Guuseppe Gurgone)은 스타일시트와 dss에 대한 그의 연구, 리액티브 네이티브 웹(react-native web), 사티아지트 사후(Satyajit Sahoo)와 콜스택(Callstack)의 모든 사람, 크리스토퍼 체도(Christopher Chedau), 세바스티안 맥켄지(Sebastian McKenzie), 프랭크 얀(Frank Yan), 애슐린, 애슐린, 애슐린, 애슐린, 애슐린, 나만(Ashinkkins), 나만(Ash 그리고 내가 그리워한 다른 사람은.

- 요한 홀메린/스타일9
- React, GraphQL 및 릴레이를 통한 새로운 facebook.com 구축 – 2019년 4월 30일
- 리액트 앤 릴레이를 통한 새로운 페이스북 구축 | Frank Yan – 2019년 10월 30일
- 새로운 Facebook.com을 위한 기술 스택 재구축 – 2020년 5월 8일
- Johan holmerin/style 9-components.disc: 스타일 9를 위한 스타일 구성 요소 API – 실험