---
layout: post
title: "스타일이 지정된 구성 요소 건조"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/11/styled-components-desert.png
tags: STYLED COMPONENTS
---


나는 스타일이있는 컴포넌트로 작업하는 것을 좋아합니다.
 이를 통해 JavaScript에서 CSS를 작성하여 단일 구성 요소에 대해 CSS를 JavaScript에 매우 근접하게 유지할 수 있습니다.
 웹 페이지를 분석하고 재사용 가능한 구성 요소로 나누는 것을 좋아하는 프런트 엔드 개발자로서 스타일 구성 요소에 대한 아이디어는 저에게 기쁨을줍니다.
 접근 방식은 깔끔하고 모듈 식이며 필요한 클래스가 이미 존재하는지 확인하기 위해 거대한 CSS 파일을 파헤칠 필요가 없습니다.
 끝이없는 CSS 파일에 클래스를 추가 할 필요도없고 이미 거대한 파일을 더 크게 만든 것에 대해 죄책감을 느낍니다.
 

그러나 스타일 구성 요소를 사용하는 과정을 계속 진행하면서 단일 구성 요소에 맞게 CSS 스타일을 분리하는 것이 좋지만 구성을 위해 많은 것을 반복하기 시작했다는 사실을 깨닫기 시작했습니다.
 구성 요소별로 내 스타일.
 저는 모든 구성 요소에 대해 새로운 CSS 선언, 즉 새로운 스타일 구성 요소를 만들고 있으며 CSS에서 많은 중복을보고 있습니다.
 아니요, 스타일 구성 요소가 항상 정확히 동일한 것은 아니지만 CSS의 세 줄 중 두 줄은 다른 구성 요소의 세 줄 중 두 줄과 일치합니다.
 이 스타일이 필요한 모든 곳에서이 코드를 반복해야합니까?
 

예를 들어, flexbox를 사용하십시오.
 Flexbox는 반응 형 레이아웃에 적합합니다.
 항목을 특정 방식으로 정렬하고 최소한의 변경으로 다양한 화면 크기에서 잘 보이도록 조정할 수 있습니다.
 그래서 종종 나는 다음과 같이 쓰고 있습니다.
 

```css
display: flex;
flex-direction: row; /* the default; in react native, column is the default */
```

거의 자주 나는 다음과 같은 글을 쓰고 있습니다.
 

```css
display: flex;
flex-direction: column;
```

위의 두 코드 스 니펫은 매우 일반적입니다. 첫 번째는 모든 하위 요소를 가져 와서 왼쪽에서 오른쪽으로 연속으로 배치합니다.
 두 번째는 모든 자식 요소를 가져 와서 열에서 위에서 아래로 서로 위아래로 배치합니다.
 이러한 각 코드 조각은보다 구체적으로 만들 수 있습니다.
 그러나 페이지에 자식 요소를 배치하는 방법을 추가로 지정하기 위해 다른 속성을 추가 할 수 있습니다.
 예를 들어 사용 가능한 화면 너비에 걸쳐 요소를 균등하게 배치하려면 각 코드 조각에 다음 줄을 추가 할 수 있습니다.
 

```css
justify-content: space-evenly;
```

또한 이러한 요소의 레이아웃을 추가로 사용자 정의하기 위해 추가 할 수있는`align-items`와 같은 다른 속성이 있습니다.
 따라서 모두 flexbox 레이아웃이 필요하지만 추가로 다른 속성이있는 세 가지 구성 요소가있는 경우 스타일이 지정된 구성 요소를 반복되지 않는 방식으로 사용할 수 있습니까?
 

처음에는 다음과 같이 각 구성 요소에 대해 세 가지 스타일 세트를 만드는 것이 좋습니다.
 

```jsx
// component one
const ComponentOne = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: flex-start;
`
 
// component two
const ComponentTwo = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: space-between;
`
 
// component three
const ComponentThree = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: space-evenly;
`
```

위에 나열된 스타일이 작업을 수행합니다.
 세 가지 구성 요소 모두에는 각 하위 요소 사이에 다른 간격을두고 왼쪽에서 오른쪽으로 배치 된 하위 요소가 한 줄로 배치되어 있습니다.
 그러나 동일한 두 줄의 코드를 세 번 반복하면 CSS 부풀림이 추가됩니다.
 

반복을 피하기 위해 기본 구성 요소를 다른 구성 요소 각각으로 확장 한 다음 해당 구성 요소에 필요한 추가 styes를 추가 할 수 있습니다.
 

```jsx
// flex row component
const ExampleFlex = `
  display: flex;
  flex-direction: row;
`
 
// component one
const ComponentOne = styled(ExampleFlex)`
  justify-content: flex-start;
`
 
// component two
const ComponentTwo = styled(ExampleFlex)`
  justify-content: space-between;
`
 
// component three
const ComponentThree = styled(ExampleFlex)`
  justify-content: space-evenly;
`
```

훨씬 기분이 좋습니다.
 `<ExampleFlex />`구성 요소를 확장 한이 버전은 반복적 인 코드를 제거 할뿐만 아니라 항목을 한 곳에 표시하는 것과 관련된 코드도 유지합니다.
 항목의 방향과 관련된 코드를 열로 업데이트해야하는 경우 세 개가 아닌 한 지점에서 수행 할 수 있습니다.
 

중요 사항 : 다른 구성 요소에서 스타일을 확장하는 경우 해당 기본 구성 요소에서 상속되는 스타일은 위의 예와 같이 기본 구성 요소 뒤에 나열되어야합니다.
 `<ComponentOne />`을`<ExampleFlex />`위에 배치하면 다음과 같은 오류가 발생합니다. Uncaught ReferenceError : Cannot access‘ExampleFlex’before initialize.
 

이 아이디어를 한 단계 더 발전시키기 위해 다음 데모에서는 페이지의 서로 다른 두 UI 요소에 유사한 스타일이 필요할 수 있지만 각 요소마다 약간의 차이가있는 상황을 보여줍니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_ExyEKBK" src="//codepen.io/anon/embed/ExyEKBK?height=450&amp;theme-id=1&amp;slug-hash=ExyEKBK&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed ExyEKBK" title="CodePen Embed ExyEKBK" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

보시다시피 페이지 상단에있는 탐색과 페이지 하단에있는 바닥 글은 모두 큰 화면에서 행 방향으로 배치 된 다음 모바일 장치에서 열 레이아웃으로 전환해야합니다.
 그러나 두 요소는 페이지 상단의 탐색을 왼쪽에 맞춰 오른쪽에 로고를위한 공간을 남겨두고 바닥 글 링크를 오른쪽에 정렬해야한다는 점에서 다릅니다.
 이러한 차이 때문에 이러한 각 요소에 대해 서로 다른 두 가지 스타일 구성 요소를 만드는 것이 합리적입니다.
 상단 탐색을위한`<Navigation />`요소와 페이지 탐색 하단을위한`<Footer />`구성 요소.
 

상위 탐색 스타일은 다음과 같습니다.
 

```jsx
const Navigation = styled.div`
  align-items: center;
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  padding: 10px;
  width: calc(100% - 20px);
 
  @media (max-width: 768px) {
    flex-direction: column;
  }
`
```

하단 바닥 글 스타일은 다음과 같습니다.
 

```jsx
const Footer = styled.div`
  align-items: center;
  display: flex;
  flex-direction: row; 
  justify-content: flex-end;
  padding: 10px;
  width: calc(100% - 20px);
 
  @media (max-width: 768px) {
    flex-direction: column;
  }
`
```

이 두 요소의 유일한 차이점은 무엇입니까?
 `justify-content` 속성.
 또한`<LeftSideNav />`구성 요소는 동일한 미디어 쿼리와 함께`display : flex`를 사용합니다.
 

동일한 CSS를 많이 공유하는이 세 가지 구성 요소 외에`<NavItem />`구성 요소와`<FooterNavItem />`은 약간의 차이가있는 매우 유사한 링크 구성 요소입니다.
 그래서 우리는 이것을 어떻게 말리나요?
 

아래의 예를 보면 여러 구성 요소에서 재사용되는 CSS를 자체 구성 요소로 가져 와서 더 구체적인 구성 요소에 필요한 특정 변경을 수행 할 수 있음을 알 수 있습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_KKMoMNP" src="//codepen.io/anon/embed/KKMoMNP?height=450&amp;theme-id=1&amp;slug-hash=KKMoMNP&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed KKMoMNP" title="CodePen Embed KKMoMNP" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

변경 사항이 적용되면 모든 스타일 구성 요소를 포함하는 JavaScript 파일이 이전 버전보다 10 줄 더 짧습니다.
 작은 차이처럼 보일 수 있지만 애플리케이션이 성장함에 따라 이러한 변경 사항은 스타일이 계속 추가됨에 따라 애플리케이션과 함께 제공되는 CSS를 최소화하는 데 도움이 될 수 있습니다.
 

### "as"다형성 소품도 있습니다!
 

한 구성 요소에서 다른 구성 요소로 스타일을 확장하는 것 외에도 스타일 구성 요소는 새 요소가 지정되어있는 한 주어진 구성 요소의 스타일을 다른 요소에 적용하는 "as"라는 다형성 소품을 제공합니다.
 이는 두 요소의 사용자 인터페이스가 동일하게 보일 수 있지만 두 요소의 기본 HTML 기능이 다른 상황에서 유용합니다.
 

버튼 스타일의 버튼과 링크를 예로 들어 보겠습니다.
 언뜻보기에는 비슷한 기능이있는 것처럼 보이지만 둘 다 클릭하여 작업을 트리거 할 수 있습니다. 두 기능은 기능적으로 다른 용도로 사용됩니다.
 버튼은 양식을 제출하거나 현재 페이지의 레이아웃을 변경하는 데 유용하지만 링크를 누르면 리소스로 이동합니다.
 

아래에이를 설명하는 펜을 만들었습니다.
 언뜻보기에 두 개의 버튼이 똑같이 보입니다.
 그러나 오른쪽에있는 것은 실제로 버튼 스타일의`<a>`요소이고 왼쪽에있는 것은 실제`<button>`요소입니다.
 이 두 버튼은 사이트 탐색의 일부가 될 수 있으며 하나는 외부 사이트에 연결해야합니다.
 이 두 가지 요소를 구축하는 첫 번째 시도에서 우리가 본 첫 번째 예제에서와 같이 각 구성 요소에 대한 코드를 보는 것이 합리적입니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 200px;"><iframe id="cp_embed_YzWaWev" src="//codepen.io/anon/embed/YzWaWev?height=200&amp;theme-id=1&amp;slug-hash=YzWaWev&amp;default-tab=result" height="200" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed YzWaWev" title="CodePen Embed YzWaWev" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이 두 요소가 똑같은 스타일을 가질 것이라는 것을 알고 있다면 각각의 스타일을`<Button />`으로 스타일링 할 수 있습니다. 스타일 구성 요소를 만들고있는 버튼과 함께 제공되는 JavaScript로 그룹화 할 수 있습니다.
 그런 다음 지정하는`<Link />`구성 요소에 정확히 동일한 스타일을 적용합니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 200px;"><iframe id="cp_embed_xxOWOzX" src="//codepen.io/anon/embed/xxOWOzX?height=200&amp;theme-id=1&amp;slug-hash=xxOWOzX&amp;default-tab=result" height="200" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed xxOWOzX" title="CodePen Embed xxOWOzX" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

위의 펜을 보면이 두 요소의 스타일과 관련된 모든 중복 CSS가 제거되었음을 알 수 있습니다.
 링크 컴포넌트에서 사용할 버튼에 대해 CSS를 반복하는 대신 다음과 같이 as prop에 값을 전달하는 것을 적용 할 수 있습니다.
 

```jsx
<Button as="a" href="#" ... >I am a Link!</Button>
```

이렇게하면 Button에 대해 이미 정의한 스타일을 유지하면서 요소를 HTML 태그로 변경할 수 있습니다.
 

베이스 라인 스타일을 확장하는 것 (그리고 아마도 그것들을 하나의`globalStyles.js` 파일에 함께 보관하는 것)은 스타일이있는 컴포넌트 코드를 DRY하는 효과적인 방법이며, 훨씬 더 관리하기 쉽게 만듭니다.
 CSS를 최소로 유지하면 웹 사이트의 성능이 향상 될뿐만 아니라 개발자가 향후 CSS 라인을 파헤 치지 않아도됩니다.
 