---
layout: post
title: "JavaScript의 가장 근접한 사용 사례"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/07/user-table.jpg
tags: 
---


JavaScript에서 DOM 노드의 상위 노드를 찾는 데 문제가 있었던 적이 있습니까? 하지만 이 노드로 이동하려면 얼마나 많은 단계를 통과해야 하는지 잘 모르십니까? 이 HTML을 예로 들어 보겠습니다.

```html
<div data-id="123">
  <button>Click me</button>
</div>
```

아주 간단하죠, 그렇죠? 사용자가 버튼을 클릭한 후 `data-id` 값을 얻고 싶다고 말합니다.

```js
var button = document.querySelector("button");
 
button.addEventListener("click", (evt) => {
  console.log(evt.target.parentNode.dataset.id);
  // prints "123"
});
```

바로 이 경우 Node.parentNode API로 충분합니다. 지정된 요소의 상위 노드를 반환합니다. 위의 예에서 `evt.target`은 클릭된 버튼이며, 상위 노드는 데이터 속성을 가진 div입니다.

하지만 HTML 구조가 그것보다 더 깊이 내포되어 있다면 어떨까요? 내용에 따라 역동적일 수도 있습니다.

```html
<div data-id="123">
  <article>
    <header>
      <h1>Some title</h1>
      <button>Click me</button>
    </header>
     <!-- ... -->
  </article>
</div>
```

HTML 요소를 몇 개 더 추가함으로써 우리의 일은 훨씬 더 어려워졌습니다. 물론, 우리는 element.parentNode.parentNode.parentNode.dataset.id과 같은 것을 할 수 있지만, 그것은 우아하고, 재사용 가능하고, 확장성이 없다.

### 기존 방식: 'while' 루프 사용

한 가지 해결책은 상위 노드가 발견될 때까지 실행되는 `while` 루프를 사용하는 것이다.

```js
function getParentNode(el, tagName) {
  while (el && el.parentNode) {
    el = el.parentNode;
    
    if (el && el.tagName == tagName.toUpperCase()) {
      return el;
    }
  }
  
  return null;
}
```

위에서와 동일한 HTML 예제를 다시 사용하면 다음과 같이 보입니다.

```js
var button = document.querySelector("button");
 
console.log(getParentNode(button, 'div').dataset.id);
// prints "123"
```

이 솔루션은 결코 완벽하지 않습니다. 태그 이름 대신 ID 또는 클래스 또는 다른 유형의 선택기를 사용할지 상상해 보십시오. 적어도 상위 노드와 소스 간에 가변적인 수의 하위 노드를 허용합니다.

### jQuery도 있습니다.

옛날에는 각 응용 프로그램에 대해 위에서 설명한 기능(실제로 사용하자, 누가 원하는가?)을 작성하기 싫었다면 jQuery와 같은 라이브러리가 유용하게 사용되었습니다(그래도 여전히 해당). 정확히 다음과 같은 .closest() 방법을 제공한다.

```jquery
$("button").closest("[data-id='123']")
```

## 새로운 방법: Element.closest() 사용

jQuery는 여전히 유효한 접근 방식이지만(여기, 우리 중 일부는 여기에 신세를 지고 있다), 이 한 가지 방법에 대해서만 프로젝트에 추가하는 것은 특히 네이티브 JavaScript와 동일한 방법을 사용할 수 있는 경우 오버킬입니다.

여기서 `Element.Closest`가 시작됩니다.

```js
var button = document.querySelector("button");
 
console.log(button.closest("div"));
// prints the HTMLDivElement
```

됐다! 그만큼 쉽게 만들 수 있고, 라이브러리나 추가 코드 없이도 가능합니다.

Element.closest()는 주어진 선택기와 일치하는 요소를 얻을 때까지 DOM을 통과할 수 있게 한다. 놀라운 점은 우리가 `Element`에게도 줄 수 있는 어떤 선택권도 넘길 수 있다는 것이다.쿼리 선택기` 또는 `요소`입니다.query Selector All`을 선택합니다. ID, 클래스, 데이터 속성, 태그 등일 수 있습니다.

```js
element.closest("#my-id"); // yep
element.closest(".some-class"); // yep
element.closest("[data-id]:not(article)") // hell yeah
```

Element.closest가 지정된 선택기를 기준으로 상위 노드를 찾는 경우, 해당 노드를 `document`와 동일한 방식으로 반환합니다.쿼리 선택기`를 선택합니다. 그렇지 않으면 부모 대신 널(null)을 반환하여 if 조건에서도 쉽게 사용할 수 있습니다.

```js
var button = document.querySelector("button");
 
console.log(button.closest(".i-am-in-the-dom"));
// prints HTMLElement
 
console.log(button.closest(".i-am-not-here"));
// prints null
 
if (button.closest(".i-am-in-the-dom")) {
  console.log("Hello there!");
} else {
  console.log(":(");
}
```

몇 가지 실제 사례를 들을 준비가 되셨습니까? 가자!

### 사용 사례 1: 드롭다운

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_vYENYJe" src="//codepen.io/anon/embed/vYENYJe?height=450&amp;theme-id=1&amp;slug-hash=vYENYJe&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed vYENYJe" title="CodePen Embed vYENYJe" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

우리의 첫 번째 데모는 최상위 메뉴 항목 중 하나를 클릭한 후 열리는 드롭다운 메뉴의 기본 구현이다. 드롭다운 안쪽의 아무 곳이나 클릭하거나 텍스트를 선택해도 메뉴가 열린 상태를 유지합니까? 하지만 바깥쪽을 클릭하면 닫힙니다.

Element.Closest API는 외부 클릭을 감지합니다. 드롭다운 자체는 .menu-dropdown 클래스가 있는 ul 요소이므로 메뉴 외부의 아무 곳이나 클릭하면 해당 요소가 닫힙니다. 이 클래스에 상위 노드가 없기 때문에 `evt.target.closest(.".menu-dropdown") 값이 `null`이 되기 때문입니다.

```js
function handleClick(evt) {
  // ...
  
  // if a click happens somewhere outside the dropdown, close it.
  if (!evt.target.closest(".menu-dropdown")) {
    menu.classList.add("is-hidden");
    navigation.classList.remove("is-expanded");
  }
}
```

handleClick(핸들 클릭) 콜백 기능 내에서 드롭다운 닫기라는 조건이 수행할 작업을 결정합니다. 정렬되지 않은 목록 내부의 다른 곳을 클릭하면 Element.Closest가 해당 목록을 찾아 반환하여 드롭다운이 열린 상태를 유지합니다.

## 사례 2 사용: 표

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_xxbWoaY" src="//codepen.io/anon/embed/xxbWoaY?height=450&amp;theme-id=1&amp;slug-hash=xxbWoaY&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed xxbWoaY" title="CodePen Embed xxbWoaY" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이 두 번째 예는 대시보드의 구성 요소처럼 사용자 정보를 표시하는 테이블을 렌더링합니다. 각 사용자는 ID를 가지고 있지만, ID를 표시하는 대신 각 `<tr> 요소에 대한 데이터 속성으로 저장합니다.

```html
<table>
  <!-- ... -->
  <tr data-userid="1">
    <td>
      <input type="checkbox" data-action="select">
    </td>
    <td>John Doe</td>
    <td>john.doe@gmail.com</td>
    <td>
      <button type="button" data-action="edit">Edit</button>
      <button type="button" data-action="delete">Delete</button>
    </td>
  </tr>
</table>
```

마지막 열에는 사용자를 편집하고 테이블에서 삭제하기 위한 두 개의 버튼이 있습니다. 첫 번째 버튼은 데이터 액션 속성 편집, 두 번째 버튼은 삭제다. 둘 중 하나를 클릭하면 서버에 요청을 보내는 등의 일부 작업을 트리거할 수 있지만, 이를 위해서는 사용자 ID가 필요합니다.

클릭 이벤트 수신기는 글로벌 창 개체에 연결되므로 사용자가 페이지의 어느 곳을 클릭할 때마다 콜백 기능인 `handleClick`이 호출됩니다.

```js
function handleClick(evt) {
  var { action } = evt.target.dataset;
  
  if (action) {
    // `action` only exists on buttons and checkboxes in the table.
    let userId = getUserId(evt.target);
    
    if (action == "edit") {
      alert(`Edit user with ID of ${userId}`);
    } else if (action == "delete") {
      alert(`Delete user with ID of ${userId}`);
    } else if (action == "select") {
      alert(`Selected user with ID of ${userId}`);
    }
  }
}
```

이 버튼 중 하나가 아닌 다른 곳에서 클릭이 발생하면 `데이터 액션` 특성이 없으므로 아무 작업도 수행되지 않습니다. 그러나 두 버튼 중 하나를 클릭하면 이벤트 위임이라는 작업이 결정되며 다음 단계로 `getUserId`를 호출하여 사용자 ID를 검색합니다.

```js
function getUserId(target) {
  // `target` is always a button or checkbox.
  return target.closest("[data-userid]").dataset.userid;
}
```

이 함수는 DOM 노드가 유일한 매개 변수일 것으로 예상하며, 호출되면 `Element.closest`를 사용하여 누른 버튼이 있는 테이블 행을 찾습니다. 그런 다음 서버에 요청을 보내는 데 사용할 수 있는 `data-userid` 값을 반환합니다.

### 사례 3 사용: 반응하는 표

표 예제를 고수하고 리액트 프로젝트에서 어떻게 처리할지 살펴보겠습니다. 다음은 테이블을 반환하는 구성 요소의 코드입니다.

```jsx
function TableView({ users }) {
  function handleClick(evt) {
    var userId = evt.currentTarget
    .closest("[data-userid]")
    .getAttribute("data-userid");
 
    // do something with `userId`
  }
 
  return (
    <table>
      {users.map((user) => (
        <tr key={user.id} data-userid={user.id}>
          <td>{user.name}</td>
          <td>{user.email}</td>
          <td>
            <button onClick={handleClick}>Edit</button>
          </td>
        </tr>
      ))}
    </table>
  );
}
```

이 사용 사례는 자주 나타납니다. 데이터 세트를 매핑하여 목록이나 테이블에 표시한 다음 사용자가 이 데이터 세트를 사용하여 작업을 수행할 수 있도록 하는 것이 매우 일반적입니다. 많은 사람들이 인라인 화살표 기능을 사용합니다.

```jsx
<button onClick={() => handleClick(user.id)}>Edit</button>
```

이것이 문제를 해결하는 효과적인 방법이기도 하지만, 나는 데이터 사용자 ID 기법을 사용하는 것을 선호한다. 인라인 화살표 함수의 단점 중 하나는 React가 목록을 다시 렌더링할 때마다 콜백 함수를 다시 생성하여 대량의 데이터를 처리할 때 성능 문제가 발생할 수 있다는 것이다.

콜백 함수에서 우리는 단순히 대상(버튼)을 추출하고 `data-userid` 값을 포함하는 상위 `<tr> 요소를 얻는 방식으로 이벤트를 처리한다.

```js
function handleClick(evt) {
  var userId = evt.target
  .closest("[data-userid]")
  .getAttribute("data-userid");
 
  // do something with `userId`
}
```

### 사용 사례 4: 모델

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_xxbjGGK" src="//codepen.io/anon/embed/xxbjGGK?height=450&amp;theme-id=1&amp;slug-hash=xxbjGGK&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed xxbjGGK" title="CodePen Embed xxbjGGK" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이 마지막 예는 여러분 모두가 언젠가 접한 또 다른 구성 요소인 모달입니다. 모델들은 접근성이 좋고 (이상적으로) 외모가 뛰어나면서 많은 기능을 제공해야 하기 때문에 종종 구현이 어렵다.

우리는 모달 닫는 방법에 초점을 맞추고 싶다. 이 예에서는 키보드에서 Esc를 누르거나 모달의 버튼을 클릭하거나 모달 외부의 아무 곳이나 클릭하면 가능합니다.

JavaScript에서는 모달의 클릭을 수신하려고 합니다.

```js
var modal = document.querySelector(".modal-outer");

modal.addEventListener("click", handleModalClick);
```

모달은 기본적으로 `.is-hidden` 유틸리티 클래스를 통해 숨겨집니다. 사용자가 큰 빨간색 단추를 클릭할 때만 이 클래스를 제거하여 모달 모양이 열립니다. 모달을 연 후에는 닫기 버튼을 제외하고 모달 내부의 아무 곳이나 클릭해도 모달은 실수로 닫히지 않습니다. 이벤트 수신기 콜백 기능은 다음을 담당합니다.

```js
function handleModalClick(evt) {
  // `evt.target` is the DOM node the user clicked on.
  if (!evt.target.closest(".modal-inner")) {
    handleModalClose();
  }
}
```

`evt.target`은 클릭되는 DOM 노드이며, 이 예에서는 모달 뒤에 있는 전체 배경인 <div class="incip-outer"입니다. 이 DOM 노드는 `=div class="inflosed" 내에 있지 않으므로 `Element.closest()`는 원하는 대로 버블업할 수 있으며 찾을 수 없습니다. 이 상태가 이를 확인하고 `handleModalClose` 기능을 트리거합니다.

노드 안쪽을 클릭하면 머리글과 같이 =div class="div-discount"가 상위 노드가 됩니다. 이 경우, 모달은 열린 상태로 남겨진 상태로 상태가 진실되지 않습니다.

### 아, 그리고 브라우저 지원에 대해서도…

새로운 자바스크립트 API와 마찬가지로 브라우저 지원도 고려해야 한다. 좋은 소식은 `Element.Closest`가 그리 새로운 것이 아니며, 94%에 달하는 엄청난 지원 범위로 상당 기간 동안 모든 주요 브라우저에서 지원된다는 것이다. 이것은 생산 환경에서 사용하기에 안전하다고 말할 수 있습니다.

어떠한 지원도 제공하지 않는 유일한 브라우저는 Internet Explorer(모든 버전)입니다. IE를 지원해야 하는 경우 jQuery 접근 방식을 사용하는 것이 더 나을 수 있습니다.

보다시피 엘리먼트 클로즈스트의 활용 사례는 꽤 탄탄하다. jQuery와 같은 라이브러리가 과거에 우리에게 비교적 쉽게 만들어졌던 것을 이제 바닐라 자바스크립트와 함께 기본적으로 사용할 수 있다.

좋은 브라우저 지원과 사용하기 쉬운 API 덕분에, 저는 많은 응용 프로그램에서 이 작은 방법에 크게 의존하고 있으며, 아직 실망하지 않았습니다.

다른 재미있는 사용 사례가 있습니까? 언제든지 말씀하세요.