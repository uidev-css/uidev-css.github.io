---
layout: post
title: "CSS 및 JavaScript를 사용하여 특정 문자 수정"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2019/02/text-wrap.png
tags: FONT-FACE,FONT-VARIANT,NTH-LETTER
---


CSS에서는 특정 문자를 변경하는 것이 어려울 수 있습니다. 종종 HTML에서 원하는 변경 사항을 하나씩 구현해야 합니다. 스팬 요소를 사용할 수도 있습니다. 그러나, 몇 가지 특정한 경우, CSS에 초점을 맞춘 솔루션이 여전히 가능할 수 있다. 이 기사에서는 자바스크립트로 전환해야 하는 시나리오를 고려하기 전에 문자 변경에 대한 CSS 우선 접근 방식을 살펴보는 것으로 시작할 것이다.

### CSS

현재 CSS는 HTML을 수정하지 않고서는 특정 문자를 타겟팅하는 데 뛰어나지 않지만, CSS가 대상이 될 수 있는 시나리오가 몇 가지 있다.

@font-face 규칙은 사용자 지정 글꼴을 만드는 데 정기적으로 사용되지만 유니코드 범위 속성을 통해 특정 문자를 대상으로 지정할 수도 있습니다.

예를 들어, 우리 사이트가 종종 앰퍼샌드를 제목에 포함한다고 상상해보라. 우리는 표제 글꼴을 사용하는 대신 좀 더 화려한 것을 원한다. 앰퍼샌드의 유니코드 값(U+0026)을 조회하고 유니코드 범위(unicode-range)를 활용해 특정 문자를 공략할 수 있다.

```css
@import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@300');

h1, h2, h3, h4, h5, h6 {
  font-family:  'Ampersand', Montserrat, sans-serif;
}

@font-face {
  font-family: 'Ampersand';
  src: local('Times New Roman');
  unicode-range: U+0026;
}
```

다음 HTML로 이 작업을 수행해 보십시오.

```html
<h1>Jane Austen Novels</h1>
<h2>Pride & Prejudice</h2>
<h2>Sense & Sensibility</h2>
```

::first-letter의 의사 요소는 주로 드롭 캡을 염두에 두고 설계되었으며 모든 주요 브라우저에서 지원됩니다.

```css
p::first-letter {
  font-size: 125%;
  font-weight: bold;
}
```

물론 이것은 비교적 제한된 수의 시나리오에서만 유용하다. 여기 CSS-Tricks를 포함하여 `:nth-letter` 사이비 요소에 대한 요구가 여러 번 있었지만, 지금은 그저 꿈일 뿐이다.

유사 요소인 `::after`와 `content` 속성을 사용하면 해당 문자가 항상 동일하기만 하면 최종 문자에도 유사한 효과를 얻을 수 있다. 예를 들어, 모든 `h2` 요소 뒤에 이탤릭체 느낌표를 추가하는 방법은 다음과 같습니다.

```css
h2::after {
  content: '\0021';
  color: red;
  font-style: italic;
}
```

마지막으로, `글꼴 변종 대체` 속성이 있습니다. 이것은 Firefox에서만 지원되므로 프로덕션에서는 권장되지 않지만, 실제로 특정 시나리오에서는 알 만한 가치가 있을 수 있습니다. 글꼴에 대체 글리프가 포함되어 있는 경우, 이 속성을 `문자 변화()` 함수와 함께 사용하여 선택한 문자에 대해 선호하는 글리프를 선택할 수 있습니다.

### 자바스크립트

특히 빌드 시 HTML 변경 기능을 실행하는 경우 JavaScript로 전환하면 성능 저하가 발생하지 않습니다. 가장 일반적인 사용 사례는 HTML에서 특정 문자를 찾아 스팬 요소로 대체하는 것입니다. 단순성을 위해 먼저 클라이언트 측 예를 들어 보겠습니다. 그런 다음 웹 팩으로 빌드하는 방법을 살펴보겠습니다.

우리 사이트의 헤더에 "LOGO"라는 텍스트가 있을 때마다 첫 번째 "O" 문자에만 특수 스타일을 추가하고 클래스 ".special-o"와 함께 "span" 요소로 그것을 포장한다고 가정해 보자.

```js
const headings = document.querySelectorAll("h1, h2, h3, h4, h5, h6");

for (const heading of headings) {
  heading.innerHTML = heading.innerHTML
    .replace(/\bLOGO\b/g, 'L<span class="special-o">O</span>GO');
}
```

위의 JavaScript에서는 모든 제목 태그에 대해 찾기 및 바꾸기를 수행하고 있습니다.

우리의 정규식은 로고가 더 큰 단어의 요소가 아니라 항상 단어라는 것을 보장하기 위해 메타 문자 `\b`를 사용한다. 예를 들어, 우리는 복수형 "LOGOS"와 매치하고 싶지 않다. 지금 당장은 CSS로 이것을 하는 것이 불가능할 것이다. 왜냐하면 우리는 단지 시퀀스의 첫 번째 "O"만을 목표로 하기 때문이다.

"O" 또는 전체 단어 "LOGO"를 이미지로 바꾸려는 경우에도 동일한 원칙이 적용됩니다.

많은 빌드 도구가 있지만 웹 팩이 매우 인기가 있기 때문에 이를 예로 들 수 있습니다. 다행히도 문자열 대체 로더라는 플러그인이 필요합니다. 웹 팩에 새로 추가된 로더는 파일을 사전 처리하는 데 사용됩니다. 여기서는 빌드의 일부로 특정 파일에 대해 찾기 및 바꾸기를 수행할 수 있습니다.

먼저 플러그인을 설치해야 합니다.

```terminal
npm install --save-dev string-replace-loader
```

그런 다음 `webpack.config.js`에서 다음을 추가합니다.

```js
module.exports = {
  // ...
  module: {
    rules: [
      {
        test: /\.html$/i,
        loader: 'string-replace-loader',
        options: {
          search: '/\bLOGO\b/g',
          replace: 'L<span class="special-o">O</span>GO',
        }
      }
    ]
  }
}
```

test 속성 값을 변경하여 JSX, TSX, PUG, 핸들바 또는 기타 템플릿 파일 형식을 지정할 수 있습니다.

```
/\.html$/i # HTML
/\.[jt]sx$/i # JSX or TSX
/\.pug$/i # PUG
/\.handlebars$/i # Handlebars
```

이 접근 방식의 이점은 불필요한 JavaScript가 클라이언트의 브라우저에서 실행되지 않는다는 것입니다.

### 기말노트

마지막으로, 글꼴을 만들고 편집하는 것이 편하고 CSS 또는 JavaScript를 피하는 것이 좋다면 위에서 설명한 많은 시나리오에서 사용자 지정 글꼴이 해결책이 될 수 있습니다. 디자인 중심 접근 방식을 시도하고자 하는 사람들을 위해 Font Forge 또는 Birdfont와 같은 무료 글꼴 편집 도구가 많이 있다.