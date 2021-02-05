---
layout: post
title: "미디어 쿼리 응답성이 낮은 카드 구성 요소를 만드는 방법"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/08/recipe-card-component.png
tags: CLAMP,FLEX-BASIS,FLEX-GROW,FLUID TYPE,OBJECT-FIT,RESPONSIVE
---


재미있는 사실: 미디어 쿼리 없이도 응답성 있는 구성 요소를 만들 수 있습니다. 확실히 컨테이너 쿼리가 있다면 구성요소 수준에서 응답성 설계에 매우 유용할 것입니다. 하지만 우리는 그렇지 않다. 컨테이너 쿼리가 있든 없든 간에 구성 요소가 놀라울 정도로 반응하도록 작업을 수행할 수 있습니다. 우리는 젠 시몬스가 우리에게 가져온 내재적 웹 디자인의 개념을 사용할 것입니다.

아래 설명된 사용 사례와 CSS의 실제 상태에 대한 솔루션, 그리고 제가 여러분에게 드릴 몇 가지 다른 요령들에 대해 함께 알아보겠습니다.

### 응답성이 뛰어난 "Cooking Recipe" 카드

최근 트위터를 통해 피자 레시피를 활용해 만든 반응형 카드 데모 영상과 펜을 예로 들었다.(여기 기술에는 중요하지 않지만 맛도 좋고 글루텐도 없어 마지막에 레시피를 떨어뜨렸다.)

이 데모는 스테파니 월터의 강연에서 나온 개념에 기초한 첫 시도였다. 다음은 카드의 작동 방식을 보여주는 비디오입니다.


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video autoplay="" controls="" loop="" muted="" preload="auto" src="https://css-tricks.com/wp-content/uploads/2020/08/pizza-responsive.mp4" name="fitvid0"></video>
</div>


그리고 지금 당장 가지고 놀고 싶다면, 여기 펜이 있습니다.

### 반응형 레이아웃을 정의하겠습니다.

계획의 핵심은 당신이 작업하고 있는 실제 컨텐츠와 그 세부 사항의 중요성을 아는 것입니다. 우리가 어떤 시점에서든 컨텐츠를 숨겨야 한다는 것이 아니라 레이아웃과 디자인적인 이유로, 무엇이 먼저 전달되어야 하는지 아는 것이 좋습니다. 레이아웃의 크기나 모양에 상관없이 동일한 내용을 표시합니다.

가장 중요한 것에 집중할 수 있도록 도와주는 모바일 우선 사고방식을 가진 컨텐츠를 상상해 보십시오. 그런 다음 바탕화면과 같이 화면이 더 크면, 우리는 멋진 화이트 스페이스나 더 큰 타이포그래피 같은 것들을 위한 추가 공간을 사용할 수 있습니다. 일반적으로 이와 같은 약간의 우선 순위 지정만으로도 모든 뷰포트 크기에서 카드에 필요한 콘텐츠를 확인할 수 있습니다.

요리 레시피 티저를 예로 들어 보겠습니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/08/5DlFADj0.png?resize=1024%2C561&ssl=1)

그녀의 강연에서 스테파니는 이미 그 일을 했고 우리 카드의 내용을 우선시했다. 중요도 순으로 요약한 내용은 다음과 같습니다.

- 이미지: 이것은 요리법이기 때문에, 여러분은 눈으로 먹습니다!
- 제목: 당신이 무엇을 요리할 것인지 확실히 하세요.
- 키워드: 주요 정보를 한눈에 볼 수 있습니다.
- 등급 정보: 사회적 증거입니다.
- 짧은 설명: 읽는 사람들을 위한 것입니다.
- 사용자가 이 카드에 대해 수행할 작업입니다.

많은 것 같지만, 우리는 이 모든 것을 하나의 스마트 카드 레이아웃으로 만들 수 있습니다!

제가 보여드릴 기술의 제약 중 하나는 컨테이너 폭에 따른 확장 가능한 타이포그래피를 얻을 수 없다는 것입니다. 확장 가능한 타이포그래피("fluid type")는 일반적으로 상위 요소가 아닌 뷰포트를 기반으로 하는 뷰포트 폭(`vw`) 단위를 사용하여 수행됩니다.

따라서, 카드에 있는 콘텐츠에 대한 비미디어 쿼리 솔루션으로 유체 유형에 도달하고자 할 수도 있지만, 불행히도 용기 폭이나 요소 폭 자체의 일부에 기반한 유체 유형을 사용할 수는 없습니다. 하지만 그렇다고 해서 우리의 목표가 막히지는 않을 거예요!

여기서 양쪽 모두에게 이야기합시다.

디자이너: 픽셀 퍼펙트는 매우 이상적입니다. 그리고 우리는 확실히 부품 수준에서 정밀해질 수 있습니다. 하지만 배치 수준에서 절충이 있어야 합니다. 즉, 몇 가지 변형은 제공하지만, 이 사이의 인바이어는 유연해야 합니다. 가능한 모든 화면 폭에서 대응 가능한 레이아웃과 정밀도의 변화는 어려운 과제입니다. 우리는 여전히 모든 규모에서 멋지게 보일 수 있습니다!

개발자: 설계에서 지정된 레이아웃 사이의 간격을 채워 해당 상태 간에 내용을 읽고 일관성을 유지할 수 있어야 합니다. 좋은 연습으로, 나는 또한 가능한 한 자연스러운 흐름을 유지하려고 노력하는 것을 추천한다.

화소 완성 상태에 대한 아흐마드의 훌륭한 기사도 읽을 수 있다.

### 미디어 쿼리 제로 레시피

우리가 노력하고 있는 것은 단지 응답 카드일 뿐 아니라 미디어 쿼리에 의존하지 않는 카드라는 것을 기억하십시오. 미디어 질의를 피해야 한다는 것이 아니라 CSS가 다른 옵션을 사용할 수 있을 만큼 강력하고 유연한지 여부입니다.

우리의 대응 카드를 만들기 위해, 나는 플렉스 박스가 충분한지 아니면 CSS 그리드로 대신 해야 하는지 궁금합니다. 이번에는 CSS의 플렉스랩(Flex-wrap)과 플렉스베이스(Flex-basis) 속성의 동작과 마법을 이용해 우리에게 충분히 플렉스박스가 들어왔습니다.

플렉스랩의 핵심은 콘텐츠 공간이 너무 좁아지면 요소들이 새로운 선으로 진입할 수 있도록 한다는 것이다. 이 데모에서는 랩이 없는 값과 랩핑이 있는 플렉스의 차이를 확인할 수 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 600px;"><iframe id="cp_embed_BajEZYa" src="//codepen.io/anon/embed/BajEZYa?height=600&amp;theme-id=1&amp;slug-hash=BajEZYa&amp;default-tab=result" height="600" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed BajEZYa" title="CodePen Embed BajEZYa" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

flex-basis 값 200px는 브라우저에 대한 제안이라기보다는 명령어에 가깝지만 컨테이너에 충분한 공간을 제공하지 못하면 요소들이 새로운 선으로 이동한다. 열 사이의 여백은 심지어 초기 줄바꿈을 강제합니다.

저는 이 포장 논리를 이용해서 카드의 베이스를 만들었습니다. Adam Argyle은 또한 이것을 10줄의 CSS와 함께 4개의 폼 레이아웃에 사용하였다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_LYEegOO" src="//codepen.io/anon/embed/LYEegOO?height=450&amp;theme-id=1&amp;slug-hash=LYEegOO&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed LYEegOO" title="CodePen Embed LYEegOO" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

그의 예에서 Adam은 e-메일 입력이 이름 입력 또는 버튼에 의해 차지하는 공간의 3배를 차지하도록 하기 위해 Flex-basis와 Flex-grow(Flex-grow)를 사용한다. 브라우저가 동일한 행에 모든 내용을 표시할 공간이 충분하지 않다고 추정하면 미디어 쿼리의 변경 사항을 관리할 필요 없이 레이아웃 자체가 여러 줄로 분할됩니다.

클램프() 기능도 사용하여 유연성을 더했습니다. 이 기능은 일종의 마법과도 같습니다. 이를 통해 최소()와 최대() 계산을 단일 함수에서 해결할 수 있습니다. 구문은 다음과 같습니다.

```
clamp(MIN, VALUE, MAX)
```

max()와 min() 함수의 조합을 해결하는 것과 같다.

```
max(MIN, min(VAL, MAX))
```

모든 종류의 속성에 사용할 수 있다: `<길이><frequency><각도><time><percentity><percentity><time><percentity> 또는 `정수>.

이 모든 새로운 형태의 CSS 파워로, 저는 미디어 쿼리 없이 유연한 응답 카드를 만들었습니다. 이 데모를 새 탭에서 보거나 아래 임베드에서는 0.5배 옵션을 사용하는 것이 가장 좋습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_OJMaMxa" src="//codepen.io/anon/embed/OJMaMxa?height=450&amp;theme-id=1&amp;slug-hash=OJMaMxa&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed OJMaMxa" title="CodePen Embed OJMaMxa" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

당신이 즉시 주목하고 싶은 것은 두 카드의 HTML 코드가 정확히 같다는 것입니다. 유일한 차이점은 첫 번째 카드는 65% 와이드 컨테이너 안에 있고 두 번째 카드는 35% 와이드 컨테이너 안에 있다는 것입니다. 또한 창의 크기를 사용하여 응답성을 테스트할 수도 있습니다.

이 데모에서 코드의 중요한 부분은 다음과 같은 선택기에 있습니다.

- .container는 상위 플렉스 컨테이너입니다.
- .cdp-box는 카드 이미지를 담는 용기인 플렉스 아이템입니다.
- .content는 두 번째 플렉스 항목이며 카드 컨텐츠의 컨테이너입니다.

이제 플렉스랩이 어떻게 작동하는지, 플렉스베이스와 플렉스그로우(Flex-basis)가 요소 사이징에 어떤 영향을 미치는지 알았으니 클램프() 기능을 빨리 설명하면 된다.

calc()와 사용자 지정 속성을 사용하여 상위 컨테이너의 너비를 기준으로 글꼴 크기를 계산하고 싶었지만 100% 값은 상황에 따라 해석이 달라 방법을 찾을 수 없었습니다. 클램프() 기능의 중간 가치를 위해 보관했지만 최종 결과가 지나치게 조작돼 기대했던 대로 작동하지 않았다.

```css
/* No need, really */
font-size: clamp(1.4em, calc(.5em * 2.1vw), 2.1em);
```

대신 착륙한 곳은 여기입니다.

```css
font-size: clamp(1.4em, 2.1vw, 2.1em);
```

카드 타이틀의 크기를 화면 크기에 맞게 조정하기 위해 그렇게 했는데, 액상 타입에 대해 얘기했을 때 훨씬 전에 얘기했던 것처럼, 우리는 본문의 크기를 부모 용기의 너비로 맞출 수 없을 거예요.

대신, 우리는 기본적으로 CSS의 한 줄로 이렇게 말하고 있습니다.

> 폰트 크기는 2.1vw(뷰포트 폭의 2.1%)와 같기를 원하지만 1.4em 이하 또는 2.1em 이상은 되도록 하지 말아주세요.

이렇게 하면 제목은 다른 내용보다 크게 유지하면서도 읽을 수 있으므로 우선순위가 높은 중요도를 유지할 수 있습니다. 그리고, 야, 그것은 여전히 화면 크기에 따라 커지고 줄어들게 해!

그리고 반응하는 이미지를 잊지 맙시다. 컨텐츠 요구 사항에 따르면 이미지가 여러 개에서 가장 중요한 부분이라고 합니다. 따라서 우리는 반드시 이미지를 설명하고 모든 화면 크기에 맞게 잘 보이도록 해야 합니다. 이제, 여러분은 이런 것을 하고 싶을지도 모릅니다:

```css
max-width: 100%;
height: auto;
```

하지만 이것이 항상 최상의 이미지 렌더링 결과를 낳는 것은 아닙니다. 대신, 우리는 이미지의 내용 상자의 높이와 너비에 반응할 뿐만 아니라 이미지를 자르고 `개체 위치` 속성과 함께 사용할 때 상자 내부에서 어떻게 펼쳐지는지를 제어할 수 있는 `개체 적합` 속성을 가지고 있다.

```css
img {
  max-width: 100%;
  min-height: 100%;
  width: auto;
  height: auto;
  object-fit: cover;
  object-position: 50% 50%;
} 
 

```

보시다시피, 그것은 적어야 할 많은 재산입니다. HTML `img` 코드의 명시적 폭과 높이 속성 때문에 필수입니다. 성능상의 이유로 권장하지 않는 HTML 부분을 제거하면 CSS에 `object-*` 속성을 유지하고 다른 속성을 제거할 수 있습니다.

### 미디어 쿼리 없이 사용할 수 있는 대체 방법

플렉스-그로스(Flex-grow)를 유닛 기반 성장 가치로 활용하는 것도 기술인데 플렉스-베이스(Flex-basis)에 터무니없이 큰 가치를 두고 있다. 이 아이디어는 헤이든 피커링의 위대한 "Holy Albatross" 데모에서 바로 도난당했다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 650px;"><iframe id="cp_embed_zYrXdpe" src="//codepen.io/anon/embed/zYrXdpe?height=650&amp;theme-id=1&amp;slug-hash=zYrXdpe&amp;default-tab=result" height="650" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed zYrXdpe" title="CodePen Embed zYrXdpe" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

코드의 흥미로운 부분은 다음과 같습니다.

```css
/* Container */
.recipe {
  --modifier: calc(70ch - 100%);
 
  display: flex;
  flex-wrap: wrap;
}
 
/* Image dimension */
.pizza-box {
  flex-grow: 3;
  flex-shrink: 1;
  flex-basis: calc(var(--modifier) * 999);
}
 
/* Text content dimension */
.recipe-content {
  flex-grow: 4;
  flex-shrink: 1;
  flex-basis: calc(var(--modifier) * 999);
}
```

비례 차원은 `플렉스로`에 의해 생성되는 반면, `플렉스로` 차원은 유효하지 않거나 매우 높을 수 있다. calc(70ch - 100%)가 --modifier(--modifier)의 값에 도달하면 값이 매우 높아진다. 값이 매우 높으면 각 값이 열 레이아웃을 만드는 공간을 채우고 값이 유효하지 않으면 인라인으로 배치됩니다.

70ch 값은 Recipe 구성 요소의 중단점(대부분 컨테이너 쿼리)과 같은 역할을 합니다. 필요에 따라 변경합니다.

### 재료들을 다시 한 번 분해해 봅시다.

미디어 쿼리가 없는 카드 구성 요소에 사용한 CSS 구성 요소는 다음과 같습니다.

- clamp() 기능은 "기본 설정" vs. "최소" vs. "최대" 값
- 음수 값을 가진 "플렉시베이스" 속성은 레이아웃이 여러 줄로 분할될 때를 결정합니다.
- 플렉스그로우(Flex-grow) 부동산은 비례성장을 위한 단위 가치로 사용된다.
- vw 단위는 반응하는 타이포그래피에 도움이 된다.
- 객체-파이(object-fi-t) 속성은 왜곡 없이 이미지의 치수를 변경할 수 있기 때문에 카드 이미지에 대한 보다 세밀한 응답성을 제공한다.

### 수량 조회 진행

또 다른 방법이 있습니다. 컨테이너의 품목 수에 따라 레이아웃을 조정할 수 있습니다. 이는 실제로 컨테이너의 치수가 아니라 컨텐츠가 놓여 있는 컨텍스트에서 비롯되는 반응성입니다.

항목 수에 대한 실제 미디어 쿼리가 없습니다. 아이템의 수를 거꾸로 세어 스타일 수정을 적용하는 것은 작은 CSS 트릭입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 650px;"><iframe id="cp_embed_BajEwyJ" src="//codepen.io/anon/embed/BajEwyJ?height=650&amp;theme-id=1&amp;slug-hash=BajEwyJ&amp;default-tab=result" height="650" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed BajEwyJ" title="CodePen Embed BajEwyJ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

데모에서는 다음 선택기를 사용합니다.

```css
.container > :nth-last-child(n+3),
.container > :nth-last-child(n+3) ~ * {
  flex-direction: column;
}
```

까다로워 보이죠? 이 선택기를 사용하면 마지막 아이부터 모든 형제자매의 스타일을 적용할 수 있습니다. 멋지다!

우나 크라베츠는 이 개념을 정말 잘 설명해준다. 다음과 같이 특정 용도를 번역할 수 있습니다.

- `.nth-last-last-child(n+3)`: 그룹의 마지막 .container 요소 중 세 번째 .container 요소 이상입니다.
- .container > :nth-last-child(n+3) ~ *`: 동일한 항목이지만 마지막 요소 다음에 .container 요소를 선택합니다. 이것은 우리가 추가하는 다른 카드를 설명하는 데 도움이 됩니다.

Hugo Giraudel의 "Selectors Descripted" 도구는 이러한 선택기가 작동하는 방식에 대한 다른 번역을 원할 경우 복잡한 선택기를 쉬운 영어로 변환하는 데 도움이 됩니다.

CSS에서 "양량" 컨테이너를 얻는 또 다른 방법은 이진 조건을 사용하는 것이다. 하지만 그 구문은 쉽지 않고 약간 진부해 보인다. Twitter로 연락하시면 됩니다. CSS나 디자인에 관한 다른 요령과 팁도요.

### 이것이 미래의 증거입니까?

제가 여러분께 보여드린 모든 기술들은 오늘날 생산 환경에서 사용될 수 있습니다. 그들은 좋은 지원을 받고 있으며 우아한 타락의 기회를 제공한다.

최악의 경우? Internet Explorer 9과 같은 일부 지원되지 않는 브라우저는 지정한 조건에 따라 레이아웃을 변경하지 않지만 내용은 읽을 수 있습니다. 따라서 지원되지만 이상적인 환경을 위해 "최적화"되지는 않을 수 있습니다.

언젠가는 드디어 야생에서 컨테이너 문의의 성배를 볼 수 있을 것입니다. 여기서 사용한 내장형 웹 디자인 패턴이 귀하를 만족시키고 그 동안 유연하고 "본질적으로 반응하는" 구성 요소를 구축하는 데 도움이 되기를 바랍니다.

이 게시물에 대한 "지역"의 이유를 알아보자… 피자! 🍕

### 글루텐 프리 팬 피자 레시피

토핑을 고르시면 됩니다. 중요한 부분은 밀가루 반죽입니다. 그리고 여기에 다음이 있습니다.

- 글루텐 무첨가 분말 3컵
- 흑설탕 1큰술, 흑설탕 1작은술 더하기
- 코셔 소금 2티스푼
- 효모 1/2입방체
- 통아몬드 우유 2컵(400ml)
- 녹인 마가린 4테이블스푼
- 메이지나 1테이블스푼

- 모든 마른 재료들을 함께 섞으세요.
- 액체를 넣어라.
- 2시간 동안 두 배로 해주세요. 나는 반죽이 있는 그릇 위에 젖은 식기 수건을 올려놓고 뜨거운 곳에 접시를 놓는 것을 추천하고 싶다.
- 팬에 기름을 두른다. 약 1시간 동안 두 배로 해주세요.
- 오븐에서 250도로 20분간 요리하세요.

Stéphanie에게 😁 레시피를 주셔서 감사합니다.