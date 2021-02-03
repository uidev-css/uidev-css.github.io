---
layout: post
title: "Vue에서 한 HTML 요소에서 다른 요소로 동적으로 전환
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2021/01/button-link-swap.jpg
tags: VUE,VUE COMPONENTS
---


한 친구가 저에게 연락하여 Vue의 템플릿 블록 내에서 하나의 HTML 요소를 다른 HTML 요소로 동적으로 변경하는 방법이 있는지 물었습니다.
 예를 들어, 일부 기준에 따라`<div>`요소를`<span>`요소로 이동합니다.
 트릭은 일련의`v-if` 및`v-else` 코드에 의존하지 않고이를 수행하는 것이 었습니다.
 

그런 일을해야하는 강력한 이유가 보이지 않았기 때문에 많이 생각하지 않았습니다.
 그렇게 자주 나오지 않습니다.
 하지만 같은 날 나중에 다시 연락하여 요소 유형을 변경하는 방법을 배웠다고 말했습니다.
 그는 Vue가 자신이 필요로하는 방식으로 동적 요소로 사용할 수있는 기본 제공 구성 요소를 가지고 있다는 점을 흥미롭게 지적했습니다.
 

이 작은 기능은 템플릿의 코드를 멋지고 깔끔하게 유지할 수 있습니다.
 `v-if`및 `v-else`과잉을 이해하고 유지 관리하기 쉬운 더 적은 양의 코드로 줄일 수 있습니다.
 이를 통해 메서드 또는 계산 된 메서드를 사용하여 스크립트 블록에서 멋지게 코딩되었지만 더 정교한 조건을 만들 수 있습니다.
 그것이 바로 템플릿 블록이 아니라 스크립트에있는 것입니다.
 

이 기사에 대한 아이디어는 주로 제가 작업하는 디자인 시스템의 여러 위치에서이 기능을 사용하기 때문입니다.
 당연히 큰 기능은 아니며 적어도 내가 말할 수있는 한 문서에서 거의 언급되지 않았습니다.
 그러나 구성 요소에서 특정 HTML 요소를 렌더링하는 데 도움이 될 가능성이 있습니다.
 

### Vue의 내장`<component>`요소
 

뷰를 쉽게 동적으로 변경할 수 있도록 Vue에서 사용할 수있는 몇 가지 기능이 있습니다.
 이러한 기능 중 하나 인 기본 제공`<component>`요소를 사용하면 구성 요소를 동적으로 만들고 필요에 따라 전환 할 수 있습니다.
 Vue 2 및 Vue 3 문서에는이 요소를 HTML 요소와 함께 사용하는 것에 대한 작은 참고 사항이 있습니다.
 이것이 우리가 지금 탐구 할 부분입니다.
 

아이디어는`<component>`요소의 이러한 측면을 활용하여 본질적으로 다소 유사한 공통 HTML 요소를 교체하는 것입니다.
 하지만 기능, 의미 또는 시각적 요소가 다릅니다.
 다음 기본 예제는 Vue 구성 요소를 깔끔하고 깔끔하게 유지하는 데 도움이되는이 요소의 잠재력을 보여줍니다.
 

### 버튼 또는 링크?
 

버튼과 링크는 종종 같은 의미로 사용되지만 기능, 의미, 시각적 요소까지도 큰 차이가 있습니다.
 일반적으로 버튼 (`<button>`)은 JavaScript 코드에 연결된 현재보기의 내부 작업을위한 것입니다.
 반면에 링크 (`<a>`)는 호스트 서버 또는 외부 리소스에있는 다른 리소스를 가리 킵니다.
 대부분 웹 페이지.
 단일 페이지 애플리케이션은 링크보다 버튼에 더 의존하는 경향이 있지만 둘 다 필요합니다.
 

링크는 버튼 모양을 만드는 Bootstrap의`.btn` 클래스와 같이 시각적으로 버튼으로 스타일이 지정되는 경우가 많습니다.
 이를 염두에두고 하나의 소품을 기반으로 두 요소 사이를 전환하는 구성 요소를 쉽게 만들 수 있습니다.
 구성 요소는 기본적으로 버튼이지만`href` prop이 적용되면 링크로 렌더링됩니다.
 

다음은 템플릿의`<component>`입니다.
 

```html
<component
  :is="element"
  :href="href"
  class="my-button"
>
  <slot />
</component>
```

이 바인딩 된 `is`속성은 `element`라는 계산 된 메서드를 가리키고 바인딩 된 `href`속성은 적절하게 명명 된 `href`소품을 사용합니다.
 이는 prop에 값이없는 경우 바운드 속성이 렌더링 된 HTML 요소에 나타나지 않는 Vue의 정상적인 동작을 활용합니다.
 슬롯은 최종 요소가 버튼인지 링크인지에 관계없이 내부 콘텐츠를 제공합니다.
 

계산 된 방법은 본질적으로 간단합니다.
 

```js
element () {
  return this.href ? 'a' : 'button';
}
```

`href` 소품이 있으면.
 그런 다음`<a>`요소가 적용됩니다.
 그렇지 않으면`<button>`을 얻습니다.
 

```html
<my-button>this is a button</my-button>
<my-button href="https://www.css-tricks.com">this is a link</my-button>
```

HTML은 다음과 같이 렌더링됩니다.
 

```html
<button class="my-button">this is a button</button>
<a href="https://www.css-tricks.com" class="my-button">this is a link</a>
```

이 경우이 두 가지가 시각적으로 비슷할 것이라는 기대가있을 수 있지만 의미 론적 및 접근성 요구 사항에 따라 분명히 다릅니다.
 즉, 두 출력 된 요소의 스타일을 동일하게 지정해야 할 이유가 없습니다.
 스타일 블록에서 `div.my-button`선택기와 함께 요소를 사용하거나 요소에 따라 변경되는 동적 클래스를 만들 수 있습니다.
 

전체적인 목표는 하나의 구성 요소가`v-if` 또는`v-else`없이 필요에 따라 두 개의 다른 HTML 요소로 잠재적으로 렌더링 할 수 있도록하여 작업을 단순화하는 것입니다!
 

### 정렬되었거나 정렬되지 않은 목록?
 

위의 버튼 예제와 비슷한 아이디어로 다른 목록 요소를 출력하는 구성 요소를 가질 수 있습니다.
 정렬되지 않은 목록과 정렬 된 목록은 자식과 동일한 목록 항목 (`<li>`) 요소를 사용하므로 간단합니다.
 `<ul>`과`<ol>`을 바꿉니다.
 설명 목록`<dl>`을 가질 수있는 옵션을 원하더라도 콘텐츠가`<li>`요소 또는`<dt>`/`<dd를 수용 할 수있는 슬롯 일 뿐이므로 쉽게 수행 할 수 있습니다.
 >`조합.
 

템플릿 코드는 버튼 예제와 거의 동일합니다.
 

```html
<component
  :is="element"
  class="my-list"
>
  <slot>No list items!</slot>
</component>
```

슬롯 요소 내부의 기본 콘텐츠에 유의하십시오. 잠시 후에 설명하겠습니다.
 

기본적으로`<ul>`로 사용되는 목록 유형에 대한 소품이 있습니다.
 

```js
props: {
  listType: {
    type: String,
    default: 'ul'
  }
}
```

다시 말하지만`element`라는 계산 된 메서드가 있습니다.
 

```js
element () {
  if (this.$slots.default) {
    return this.listType;
  } else {
    return 'div';
  }
}
```

이 경우 기본 슬롯이 존재하는지 테스트하고 있습니다. 즉, 렌더링 할 콘텐츠가 있습니다.
 그렇다면`listType` 소품을 통해 전달 된 목록 유형이 사용됩니다.
 그렇지 않으면 요소는 "No list items!"를 표시하는`<div>`가됩니다.
 슬롯 요소 내부의 메시지.
 이렇게하면 목록 항목이없는 경우 HTML이 항목이 없다는 하나의 항목이있는 목록으로 렌더링되지 않습니다.
 마지막 측면은 사용자에게 달려 있지만, 명백한 유효한 항목이없는 목록의 의미를 고려하는 것이 좋습니다.
 고려해야 할 또 다른 사항은 접근성 도구가 항목이 없다는 것을 나타내는 하나의 항목이 포함 된 목록임을 암시하는 잠재적 인 혼란입니다.
 

위의 버튼 예와 마찬가지로 각 목록의 스타일을 다르게 지정할 수도 있습니다.
 이는 클래스 이름이`ul.my-list` 인 요소를 대상으로하는 선택기를 기반으로 할 수 있습니다.
 또 다른 옵션은 선택한 요소에 따라 클래스 이름을 동적으로 변경하는 것입니다.
 

이 예제는 BEM과 유사한 클래스 이름 지정 구조를 따릅니다.
 

```html
<component
  :is="element"
  class="my-list"
  :class="`my-list__${element}`"
>
  <slot>No list items!</slot>
</component>
```

사용법은 이전 버튼 예제처럼 간단합니다.
 

```html
<my-list>
  <li>list item 1</li>
</my-list>

<my-list list-type="ol">
  <li>list item 1</li>
</my-list>

<my-list list-type="dl">
  <dt>Item 1</dt>
  <dd>This is item one.</dd>
</my-list>

<my-list></my-list>
```

각 인스턴스는 지정된 목록 요소를 렌더링합니다.
 그러나 마지막 항목은 표시 할 목록이 없기 때문에 목록 항목이 없음을 나타내는`<div>`가됩니다.
 

단순한 HTML 일 수있을 때 다른 목록 유형간에 전환하는 구성 요소를 만드는 이유가 궁금 할 것입니다.
 스타일 지정 및 유지 관리를 위해 구성 요소에 포함 된 목록을 유지하면 이점이있을 수 있지만 다른 이유도 고려할 수 있습니다.
 예를 들어, 어떤 형태의 기능이 다른 목록 유형에 연결되어 있다면?
 정렬 순서를 표시하기 위해`<ol>`로 전환 한 다음 완료되면 다시 전환하는`<ul>`목록의 정렬을 고려해보십시오.
 

### 이제 우리는 요소를 제어하고 있습니다
 

이 두 가지 예가 기본적으로 루트 요소 구성 요소를 변경하고 있지만 구성 요소에 대해 더 깊이 생각해보십시오.
 예를 들어 일부 기준에 따라`<h2>`에서`<h3>`로 변경해야하는 제목입니다.
 

몇 가지 속성 이상을 제어하기 위해 삼항 솔루션을 사용해야하는 경우 `v-if`를 고수하는 것이 좋습니다.
 속성, 클래스 및 속성을 처리하기 위해 더 많은 코드를 작성해야하는 것은`v-if`보다 코드를 더 복잡하게 만듭니다.
 이 경우`v-if`는 장기적으로 더 간단한 코드를 만들고 더 간단한 코드는 읽고 유지하기가 더 쉽습니다.
 

구성 요소를 만들 때 요소간에 전환 할 수있는 간단한`v-if`가있는 경우 주요 Vue 기능의이 작은 측면을 고려하십시오.
 

지금까지 다룬 모든 내용을 고려하여 유연한 카드 구성 요소에 사용합니다.
 이 카드 구성 요소의 예에서는 기사 레이아웃의 특정 부분에 세 가지 유형의 카드를 배치 할 수 있습니다.
 

- 영웅 카드 : 페이지 상단에 사용될 예정이며 다른 카드보다 더 많은 관심을 끌 것으로 예상됩니다.
 
- 클릭 유도 문안 카드 : 기사 전 또는 기사 내에서 사용자 액션 라인으로 사용됩니다.
 
- 정보 카드 : 인용문에 사용됩니다.
 

이들 각각을 디자인 시스템을 따르는 것으로 간주하고 구성 요소는 의미와 스타일을 위해 HTML을 제어합니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 750px;"><iframe id="cp_embed_a08618ebd574e3cbcb24b7588c529386" src="//codepen.io/anon/embed/a08618ebd574e3cbcb24b7588c529386?height=750&amp;theme-id=1&amp;slug-hash=a08618ebd574e3cbcb24b7588c529386&amp;default-tab=result" height="750" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed a08618ebd574e3cbcb24b7588c529386" title="CodePen Embed a08618ebd574e3cbcb24b7588c529386" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

위의 예에서 상단의 영웅 카드, 다음으로 클릭 유도 문안 카드 라인을 볼 수 있으며, 조금 아래로 스크롤하면 오른쪽에 정보 카드가 표시됩니다.
 

다음은 카드 구성 요소의 템플릿 코드입니다.
 

```html
<component :is="elements('root')" :class="'custom-card custom-card__' + type" @click="rootClickHandler">
  <header class="custom-card__header" :style="bg">
    <component :is="elements('header')" class="custom-card__header-content">
      <slot name="header"></slot>
    </component>
  </header>
  <div class="custom-card__content">
    <slot name="content"></slot>
  </div>
  <footer class="custom-card__footer">
    <component :is="elements('footer')" class="custom-card__footer-content" @click="footerClickHandler">
      <slot name="footer"></slot>
    </component>
  </footer>
</component>
```

카드에는 세 가지 "구성 요소"요소가 있습니다.
 각각은 카드 내부의 특정 요소를 나타내지 만 카드 종류에 따라 변경됩니다.
 각 구성 요소는 카드의 어느 섹션이 호출하는지 식별하는 매개 변수와 함께`elements ()`메소드를 호출합니다.
 

`elements ()`메서드는 다음과 같습니다.
 

```js
elements(which) {
  const tags = {
    hero: { root: 'section', header: 'h1', footer: 'date' },
    cta: { root: 'section', header: 'h2', footer: 'div' },
    info: { root: 'aside', header: 'h3', footer: 'small' }
  }
  return tags[this.type][which];
}
```

이를 처리하는 방법에는 여러 가지가있을 수 있지만 구성 요소의 요구 사항에 맞는 방향으로 이동해야합니다.
 이 경우 각 카드 유형의 각 섹션에 대한 HTML 요소 태그를 추적하는 개체가 있습니다.
 그런 다음 메서드는 현재 카드 유형과 전달 된 매개 변수에 따라 필요한 HTML 요소를 반환합니다.
 

스타일의 경우 카드 유형에 따라 카드의 루트 요소에 클래스를 삽입했습니다.
 이를 통해 요구 사항에 따라 각 카드 유형에 대한 CSS를 쉽게 만들 수 있습니다.
 HTML 요소 자체를 기반으로 CSS를 만들 수도 있지만 저는 클래스를 선호하는 경향이 있습니다.
 카드 구성 요소에 대한 향후 변경 사항은 HTML 구조를 변경할 수 있으며 클래스를 생성하는 논리를 변경할 가능성이 적습니다.
 

카드는 또한 영웅 카드의 헤더에서 배경 이미지를 지원합니다.
 이것은 헤더 요소`bg`에 배치 된 간단한 계산으로 수행됩니다.
 이것은 계산됩니다.
 

```js
bg() {
  return this.background ? `background-image: url(${this.background})` : null;
}
```

이미지 URL이`background` prop에 제공되면 계산 된 값은 이미지를 배경 이미지로 적용하는 인라인 스타일에 대한 문자열을 반환합니다.
 보다 강력하게 쉽게 만들 수있는 다소 간단한 솔루션입니다.
 예를 들어, 제공된 이미지가없는 경우 사용자 정의 색상, 그라디언트 또는 기본 색상을 지원할 수 있습니다.
 각 카드 유형에는 잠재적으로 개발자가 활용할 수있는 자체 옵션 소품이있을 수 있기 때문에 그의 예에서는 접근하지 못하는 가능성이 많습니다.
 

이 데모의 영웅 카드는 다음과 같습니다.
 

```html
<custom-card type="hero" background="https://picsum.photos/id/237/800/200">
  <template v-slot:header>Article Title</template>
  <template v-slot:content>Lorem ipsum...</template>
  <template v-slot:footer>January 1, 2011</template>
</custom-card>
```

카드의 각 섹션에 콘텐츠를위한 자체 슬롯이 있음을 알 수 있습니다.
 그리고 일을 단순하게 유지하기 위해 텍스트는 슬롯에서 예상되는 유일한 것입니다.
 카드 구성 요소는 카드 유형만을 기반으로 필요한 HTML 요소를 처리합니다.
 구성 요소가 텍스트를 기대하는 것은 본질적으로 구성 요소 사용을 다소 단순화합니다.
 HTML 구조에 대한 의사 결정의 필요성을 대체하고 카드가 간단히 구현됩니다.
 

비교를 위해 데모에서 사용되는 다른 두 가지 유형은 다음과 같습니다.
 

```html
<custom-card type="cta">
  <template v-slot:header>CTA Title One</template>
  <template v-slot:content>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</template>
  <template v-slot:footer>footer</template>
</custom-card>

<custom-card type="info">
  <template v-slot:header>Here's a Quote</template>
  <template v-slot:content>“Maecenas ... quis.”</template>
  <template v-slot:footer>who said it</template>
</custom-card>
```

다시 말하지만, 각 카드 유형은`elements ()`메소드에 정의 된대로 자체 HTML 요소를 생성하므로 각 슬롯은 텍스트 만 예상합니다.
 미래에 다른 HTML 요소를 사용해야한다고 생각되면 구성 요소를 업데이트하기 만하면됩니다.
 접근성을위한 기능 구축은 또 다른 잠재적 인 향후 업데이트입니다.
 카드 유형에 따라 상호 작용 기능도 확장 할 수 있습니다.
 

### 힘은 구성 요소에있는 구성 요소에 있습니다.
 

Vue 구성 요소에서 이상한 이름의`<component>`요소는 한 가지를위한 것이지만 종종 발생하는 것처럼 작은 부작용이있어 다른 방식으로 유용합니다.
 `<component>`요소는 필요에 따라 다른 구성 요소 내에서 Vue 구성 요소를 동적으로 전환하기위한 것입니다.
 이것의 기본 아이디어는 페이지 역할을하는 구성 요소 사이를 전환하는 탭 시스템 일 수 있습니다.
 실제로 Vue 문서에 설명되어 있습니다.
 그러나 HTML 요소로 동일한 작업을 지원합니다.
 

이것은 내가 사용한 Vue 기능의 벨트에서 놀랍도록 유용한 도구가 된 친구가 공유 한 새로운 기술의 예입니다.
 이 기사가이 작은 기능에 대한 아이디어와 정보를 전달하여 Vue 프로젝트에서이를 활용할 수있는 방법을 탐색하기를 바랍니다.
 