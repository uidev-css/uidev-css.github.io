---
layout: post
title: "Vue의 빠른 LocalStorage 사용
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/11/vue-localstorage.jpg
tags: LOCALSTORAGE,VUE
---


`localStorage`는 애플리케이션, 확장, 문서 및 다양한 사용 사례에 대한 경험을 만드는 데 매우 유용한 도구가 될 수 있습니다.
 개인적으로 각각 사용했습니다!
 영구적으로 보관할 필요가없는 사용자를 위해 작은 것을 저장하는 경우 `localStorage`가 우리의 친구입니다.
 `localStorage`와 Vue를 결합 해 보겠습니다. Vue는 개인적으로 훌륭하고 읽기 쉬운 개발자 경험이라고 생각합니다.
 

### 단순화 된 예
 

저는 최근에 Nuxt로 처음부터 끝까지 애플리케이션을 구축하는 Frontend Masters 과정을 가르쳤습니다.
 나는 우리가 그것을 더 작은 섹션으로 만드는 방식을 나누고, 우리가 다룰 것이 많았 기 때문에 우리가가는 동안 그들을 확인할 수있는 방법을 찾고 있었다.
 `localStorage`는 모든 사람이 실제로 자신의 진행 상황을 개인적으로 추적하고 있었기 때문에 모든 정보를 AWS 또는 Azure와 같은 곳에 저장할 필요가 없었기 때문에 골칫거리였습니다.
 

다음은 우리가 만들고있는 마지막 작업이며 간단한 할 일 목록입니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_JjXdNrO" src="//codepen.io/anon/embed/JjXdNrO?height=450&amp;theme-id=1&amp;slug-hash=JjXdNrO&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed JjXdNrO" title="CodePen Embed JjXdNrO" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

## 데이터 저장
 

확인하려는 모든 요소에 필요한 데이터와 사용자가 확인할 항목에 대한 빈 배열을 설정하는 것으로 시작합니다.
 

```js
export default {
  data() {
    return {
      checked: [],
      todos: [
        "Set up nuxt.config.js",
        "Create Pages",
        // ...
        ]
     }
   }
}
```

템플릿 태그의 페이지에도 출력합니다.
 

```html
  <div id="app">
    <fieldset>
      <legend>
        What we're building
      </legend>
      <div v-for="todo in todos" :key="todo">
        <input
          type="checkbox"
          name="todo"
          :id="todo"
          :value="todo"
          v-model="checked"
        />
       <label :for="todo"> todo</label>
     </div>
   </fieldset>
 </div>
```

## 장착 및 시청
 

현재 UI 변경 사항에 대응하고 있지만 아직 어디에도 저장하지 않고 있습니다.
 저장하려면 `localStorage`에 "이봐, 우리는 당신과 함께 일하는 데 관심이 있습니다."라고 말해야합니다.
 그런 다음 이러한 변경 사항을 업데이트하기 위해 Vue의 반응성에 연결해야합니다.
 구성 요소가 마운트되면`mounted` 후크를 사용하여 할 일 목록에서 선택한 항목을 선택한 다음 JSON으로 구문 분석하여`localStorage`에 데이터를 저장할 수 있습니다.
 

```js
mounted() {
  this.checked = JSON.parse(localStorage.getItem("checked")) || []
}
```

이제 `checked`속성의 변경 사항을 살펴보고 조정이 필요한 경우 `localStorage`도 업데이트합니다!
 

```js
watch: {
  checked(newValue, oldValue) {
    localStorage.setItem("checked", JSON.stringify(newValue));
  }
}
```

## 그게 다야!
 

이것이이 예에 필요한 전부입니다.
 이것은 단지 하나의 작은 사용 사례를 보여 주지만, 웹에서 수많은 성능과 개인적인 경험을 위해 어떻게`localStorage`를 사용할 수 있는지 상상할 수 있습니다!
 