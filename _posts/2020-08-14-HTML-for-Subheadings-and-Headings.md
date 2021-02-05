---
layout: post
title: "하위 제목 및 머리글을 위한 HTML"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/08/headings-subheadings.png
tags: ACCESSIBILITY,HEADERS
---


두 가지 표제 상황이 진행 중이라고 가정해 봅시다. 큰 것 위에 작은 것. 하루에 10억 번 정도 올라오는 것 같아요. 어떤 HTML을 원하세요? 내가 감히 말하건대, 그게 달라지냐? 하지만 모든 옵션을 고려해 보셨나요? 그리고 이러한 옵션들은 어떻게 의미론적으로 그리고 접근성을 발휘합니까?

가끔 이 근처에서 하듯이, 선택지를 거닐어 봅시다.

## 시각적 예

이것들이 페이지의 <h1>이 아니라고 가정해 보자. 그 중 하나가 있다면 상황이 크게 달라질 것이 아니라 단지 무대를 꾸미는 것입니다. 저는 이것이 하위섹션이나 카드에 가장 많이 나타나는 경향이 있다고 생각합니다.

요전 날 한 친구가 대화에서 꺼낸 예는 다음과 같습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/07/Screen-Shot-2020-07-14-at-10.53.52-AM.png?resize=392%2C273&ssl=1)

제가 일전에 작업한 것도 있습니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/07/Screen-Shot-2020-07-23-at-8.32.42-AM.png?resize=395%2C232&ssl=1)

여기 클래식 카드가 있습니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/08/Screen-Shot-2020-08-03-at-12.41.02-PM.png?resize=395%2C244&ssl=1)

### 옵션 1: 구(舊)<h3>, 그 다음은<h2>

작은 것은 위에 있고 큰 것은 아래에 있고 분명한 것은 <h3>가 항상 <h2>보다 작다는 것이다.

```html
<h3>Subheading</h3>
<h2>Heading</h2>
```

이것은 아마도 꽤 흔한 생각이고 내가 가장 싫어하는 접근법일 것이다.

사용 중인 클래스 이름을 보고 스타일링을 해당 클래스로 구분합니다.

```html
<h3 class="card-subhead">Subheading</h3>
<h2 class="card-head">Heading</h2>
```

의미론적인 선택, 특히 접근성에 영향을 미치는 선택들은 순수하게 시각적인 처리에 기초하지 마세요.

더 큰 이상한 점은 두 개의 표제 요소를 사용하는 것입니다. 한 개의 콘텐츠에 두 개의 제목을 사용하는 것은 옳지 않다고 생각합니다. 이 조합은 다음과 같습니다. "여기 새로운 주요 섹션이 있습니다. 그리고 또 다른 하위 섹션이 있습니다. 왜냐하면 이 하위 섹션에는 더 많은 하위 섹션이 있기 때문에 이 하위 섹션은 첫 번째 하위 섹션만을 위한 것입니다." 하지만 다른 하위 섹션도 없고 다른 하위 제목도 없습니다. 그게 이상하지 않아도 하위섹션 제목이 먼저 나오니까 순서가 이상해요.

두 가지 다른 표제요소를 사용한다면, 제가 보기엔 표제가 작을수록 `<h2>`가 우리를…로 이끌기 때문에 더 말이 될 것 같습니다.

### 옵션 2: 소형 'n'강력 'h2'와 'h3'

강의가 마련되어 있고 부제목이 문맥상 더 지배적인 표제어로 작동한다면, 우리는 이렇게 할 수 있습니다.

```html
<h2 class="card-subheading">Subheading</h2>
<h3 class="card-heading">Heading</h3>
```

단지 <h2>가 시각적으로 작다고 해서 여전히 문서 개요에서 지배적인 표제가 될 수 없다는 것을 의미하지는 않는다. 위의 코드펜의 예를 보면, 제목 "Context Switching"이 다음 문장보다 표제어로 더 잘 작동하는 느낌이다. 그 작은 표제어에 <h2>를 사용하면 효과가 있고, <h2>가 먼저 나올수록 구조를 좀 더 `정상`(아마도)으로 유지한다고 생각한다.

그래도 한 부분에 두 개의 제목을 사용하는 것은 여전히 이상한 느낌이에요.

### 옵션 3: 하나의 제목, 하나의 div

둘 중 한 명만 헤딩하면 되는 건가요? 그것이 대체로 나에게 더 맞는 것 같다. 전에도 이런 일을 한 적이 있습니다.

```html
<div class="card-subheading">Subheading</div>
<h3 class="card-heading">Heading</h3>
```

괜찮네요. 서브헤드에 관련 내용이 있을 수 있다는 이상한 점만 빼면 사람들은 스크린 리더를 통해 머리로 가서 앞으로 읽으면 놓칠 수도 있어요. 시각적인 순서를 바꿀 수 있을 것 같은데…

```html
<hgroup> <!-- hgroup is deprecated, just defiantly using it anyway -->

  <h3 class="card-heading">Heading</h3>
  <div class="card-subheading">Subheading</div>

</hgroup>
```

```css
hgroup {
  display: flex;
  flex-direction: column;
}
hgroup .card-subheading {
  /* Visually, put on top, without affecting source order */
  order: -1;
}
```

하지만 저는 그런 시각적인 질서를 어지럽히는 것은 일반적으로 볼 수 없는 일이라고 생각합니다. 시각적인 화면 리더들에게는 어색한 일이죠. 그러니까 내가 그걸 보여줬다고 아무한테도 말하지 마.

### 옵션 4: 모든 것을 하나의 제목에 보관

어차피 한 가지 콘텐츠에 대한 표제만 보여드리니까 한 가지 표제만 쓰는 게 맞는 것 같아요.

```html
<h2>
  <strong>Subheading</strong>
  Heading
</h2>
```

그 안에 있는 <strong> 요소를 사용하면 CSS에서 동일한 유형의 스타일링을 할 수 있는 후크를 얻을 수 있습니다. 예를 들면…

```css
h2 strong {
  display: block;
  font-size: 75%;
  opacity: 0.75;
}
```

여기서의 요령은 표제어가 하나로 합쳐져야 한다는 것이다. 따라서, 그들은 자연스럽게 함께 읽거나, 콜론: 같은 것을 사용할 수 있습니다.

```html
<h2>
  <strong>New Podcast:</strong>
  Struggling with Basic HTML
</h2>
```

### ARIA 역할

자막 전용 ARIA 역할이 있는 것으로 나타났다.

예를 들어 다음과 같습니다.

```html
<h2 class="card-heading">Heading</h2>
<div role="doc-subtitle">Subheading</div>
```

저는 ARIA 역할에 따라 일반적인 스타일을 선호합니다(적절한 사용을 요구하기 때문에). 따라서 스타일을 직접 수행할 수 있습니다.

```css
[role="doc-subtitle"] { }
```

스티브와 레오니가 테스트한 결과 브라우저가 일반적으로 레벨 없는 헤딩으로 취급하는 것으로 나타났다. 괜찮은 것 같은데… 아마? 스티브는 심지어 부제목을 우선시하는 것이 괜찮다고 생각한다.

### 나쁜 사람과 못난 사람

여기서 일어나는 일은 부제목이 표제어에 일반적인 맥락을 제공하고 있다는 것입니다. 예를 들어, 표제를 붙이는 것과 같은 것이죠.

```html
<label for="card-heading-1">Subheading</label>
<h2 id="card-heading-1" class="card-heading">Heading</h2>
```

하지만 여기서는 양식 요소를 다루지 않습니다. 따라서 권장하지 않습니다. 하나의 표제어로 만드는 또 다른 방법은 의사 요소를 사용하여 다음과 같은 하위 표제를 배치하는 것입니다.

```html
<h2 class="card-heading" data-subheading="Subheading">Heading</h2>
```

```css
.card-head::before {
  content: attr(data-subheading);
  display: block;
  font-size: 75%;
  opacity: 0.75;
}
```

예전에는 스크린 독자들이 사이비 콘텐츠를 무시했지만, 여전히 완벽하지는 않지만 좋아졌다. 그래서 조금 더 유용하게 쓰이긴 하지만, 텍스트는 선택할 수 없고, 페이지도 찾을 수 없기 때문에 저는 여기에 가지 않는 것이 더 낫습니다.