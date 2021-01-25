---
layout: post
title: "유형 패턴 및 스타일 가이드"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2021/01/document-styles.jpg
tags: STYLE GUIDES,TYPOGRAPHY
---


지난 6 년 동안 저는 웹 디자인 작업에서 "타입 패턴"이라고 부르는 이러한 것들을 사용해 왔으며 제게 꽤 잘 작동했습니다.
 나는 그들이 무엇인지, 그들이 CSS에 어떻게 들어갈 수 있는지에 대해 파헤칠 것이며, 아이디어도 당신과 함께 클릭하여 당신의 일상적인 타이포그래피 요구에 도움이 될 것입니다.

QuarkXPress, Adobe InDesign 또는 CorelDraw와 같은 인쇄 디자인 데스크탑 소프트웨어를 사용한 적이 있다면이 아이디어가 "단락 스타일"의 HTML / CSS 번역이라고 상상해보십시오.

수백 페이지에 걸쳐있는 책을 디자인 할 때 전체 책의 제목 타이포그래피에 대해 (즉석에서) 변경하고 싶을 수 있습니다.
 특정 타이포그래피가 하나의 중앙 위치에서 작동하여 전체 프로젝트에 적용되는 방식을 정의 할 수 있습니다 (예 : 책).
 패턴을 제어해야합니다.

대부분의 프로그램은이 이름 지정 스타일을 사용하지만 사용자 인터페이스는 약간 다릅니다.

창을 열면 일반적으로 모든 기본 텍스트가 속한 "기본"단락 스타일이 있습니다.
 거기에서 원하는만큼 만들 수 있습니다.
 단락 스타일은 "블록"수준과 유사한 요소를위한 것이고 문자 스타일은 굵게 또는 고유 한 범위와 같은 "인라인"수준과 유사한 요소를위한 것입니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_4D1460787A5F1D7103C72142FE37900B0A21B7DDB005645C4A053C6A671E55B9_1604880957421_04-paragraph-pane-b.png?resize=2840%2C1040&ssl=1)

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_4D1460787A5F1D7103C72142FE37900B0A21B7DDB005645C4A053C6A671E55B9_1604881018931_05-paragraph-pane-c.png?resize=1494%2C1024&ssl=1)

사용자 인터페이스 세부 사항은 중요하지 않습니다. 그러나이 텍스트가 시각적으로 작동하는 방식을 정의하는 많은 컨트롤이 있음을 알 수 있습니다.
 내부적으로는 CSS 속성 : 값 쌍과 같은 키 : 값 쌍입니다.

```CSS
h1 {
  font-family: "Helvetica Neue", sans-serif; 
  font-size: 20px;
  font-weight: bold;
  color: fuchsia;
}
```

스타일을 정의하면 모든 텍스트에 적용 할 수 있습니다.
 이 경우 작은 `+`(아래 단락 스타일 이름 옆)는 스타일 정의가 변경되었음을 의미합니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_4D1460787A5F1D7103C72142FE37900B0A21B7DDB005645C4A053C6A671E55B9_1604881098474_06-redefining-style-a.png?resize=1946%2C1232&ssl=1)

이러한 변경 사항을 해당 단락 스타일이있는 모든 항목에 적용하려면 스타일을 "재정의"하면 프로젝트 전체에 적용됩니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_4D1460787A5F1D7103C72142FE37900B0A21B7DDB005645C4A053C6A671E55B9_1604881155133_07-redefinined-style-a.png?resize=1732%2C986&ssl=1)

내가 그렇게 말하면 생각하게 될 것입니다. 그것이 CSS 클래스입니다.

그러나 웹 사이트의 경우 상황이 조금 더 복잡합니다.
 웹 사이트가 어떤 크기로 표시 될지 알지 못합니다 (모바일 장치와 같이 작거나 데스크톱 모니터와 같이 거대 할 수도 있고, 아는 사람은 흑백 태블릿에서도 가능).
 클래스는 컨텍스트에 따라 변경됩니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_4D1460787A5F1D7103C72142FE37900B0A21B7DDB005645C4A053C6A671E55B9_1604881443500_08-various-screens.png?resize=2872%2C2036&ssl=1)

### 최소한의 타이포그래피 제어

개발자로서 초창기에는 다음과 같은 시맨틱 HTML을 접했을 수 있습니다.

```html
<h1>Here's some HTML stuff. I'm a heading level 1</h1>
<p>And some more. I'm a paragraph.</p>

<h2>This is a heading level 2</h2>
<p>And some more pragraph stuff.</p>
```

이러한 요소를 대상으로하고 다음과 같이 스타일을 적용하는 CSS와 쌍을 이룹니다.

```CSS
h1 {
  font-size: 50px; /* key: value pairs */
  color: #ff0066;
}

h2 {
  font-size: 32px;
  color: rgba(0,0,0,.8);
}

p {
  font-size: 16px;
  color: deepskyblue;
  line-height: 1.5;
}
```

작동합니다!

헤더를 대상으로하는 규칙을 작성하고 내림차순으로 스타일을 지정하여 가장 큰> 큰> 중간 등으로 지정할 수 있습니다.

또한 헤더에는 User Agent 스타일 (예 : 브라우저 자체에서 HTML에 적용되는 기본 스타일) 덕분에 정상적으로 허용되는 일부 스타일이 이미 있습니다.
 그들은 도움이되기위한 것입니다.
 헤더에 `font-weight`및 `margin`과 같은 것을 추가하고 여백을 축소합니다.
 이렇게하면-CSS없이-계층을 설정하기 위해 최소한 몇 가지 기본 스타일을 사용할 수 있습니다.
 이것은 초보자 친화적이고 대체 친화적이며 좋은 것입니다!

### 더 복잡한 사이트를 구축할수록 상황이 더 복잡해집니다.

페이지를 더 추가합니다.
 더 많은 모듈.
 더 많은 구성 요소.
 상황이 더 복잡해지기 시작합니다.
 모든 사소한 일에 대해 고유 한 클래스와 스타일을 추가하는 것으로 시작할 수 있지만 따라 잡을 것입니다.

먼저 특별한 상황을위한 수업을 시작합니다.

```html
<h1 class="page-title">
  Be <span class='super-ultra-magic-rainbow'>excellent</span> to each other
</h1>

<p class="special-mantra">Party on, <em>dudes</em>.</p>

<p>And yeah. I'm just a regular paragraph.</p>
```

그런 다음 모든 곳에서 클래스를 갖기 시작합니다 (대부분의 CSS 방법론에서는이를 권장합니다).

```html
<header class="site-header">
  <h1 class="page-title">
    Be <span class='ultra-magic-rainbow'>excellent</span> to each other
  </h1>
</header>

<main class="page-content">
  <section class="welcome">
    <h2 class="special-mantra">Party on <em>dudes</em></h2>

    <p class="regular-paragraph">And yeah. I'm just regular</p>
  </section>
</main>
```

새로 온 사람들은 기본 글꼴 크기와 축소 여백을 "재설정"하는 데 자신이 없을 경우이를 해결하려고 노력할 것입니다.

이것은 사람들이`margin-top : -20px`를 시도하기 시작하는 곳입니다.
 계속해서 더 많은 규칙을 작성하여 작업을 수행 할 때 실제로 원하는 작업 방식을 선언하는 대신 "고정"하는 것처럼 느껴질 것입니다.
 브라우저의 사용자 에이전트 스타일을 알지 못하는 경우 CSS 캐스케이드와 "싸움"하는 것처럼 빠르게 느낄 수 있습니다.

### 실제 사례

당신이 실제 일을하고 있고 당신의 상사 (또는 비주얼 디자이너)가이 "픽셀 완벽한"Adobe Photoshop 문서를 제공한다고 상상해보십시오.
 다양한 색상, 레이아웃 및 타이포그래피가 있습니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_4D1460787A5F1D7103C72142FE37900B0A21B7DDB005645C4A053C6A671E55B9_1604883500942_Screen_Shot_2020-11-08_at_4_54_32_PM.png?resize=1798%2C1740&ssl=1)

Photoshop을 열고 둘러보기 시작하지만 페이지가 너무 많고 유형 스타일이 너무 많아 인벤토리를 작성하고 조합하거나 조합하여 사용할 수있는 스타일을 수집해야합니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_4D1460787A5F1D7103C72142FE37900B0A21B7DDB005645C4A053C6A671E55B9_1604883460115_ScreenShot2020-11-08at4.53.59PM.png?resize=2994%2C1344&ssl=1)

시각적 레이아웃을 완성하고 전달하는 것이 기분이 좋습니다.
 그러나 Photoshop 문서에서 도대체 무슨 일이 일어나고 있는지 파악하기 위해 얼마나 많은 일을 보냈는지 말할 수 없습니다.
 예를 들어 때로는 작은 화면이 전혀 고려되지 않습니다.
 그런 경우 발견 한 패턴이 화면 유형에 따라 변경되기 때문에 각 그룹에서 항상 공유하는 것은 아닙니다.
 일부 글꼴은 16px에서 시작하여 18px까지 올라가고 다른 글꼴은 19px까지 올라가 기울임 꼴이됩니다.
 정적 모형에서 컨텍스트 변경을 어떻게 발견 할 수 있습니까?

때때로 이것은 열렬한 목적을 가지고 있습니다.
 다른 경우에는 비주얼 디자이너가 기분이 좋아지고 재사용 가능한 패턴을 만들기 위해 물건을 위아래로 반올림하는 것을 좋아합니다.
 그들에게 그것에 대해 이야기해야합니다.
 그러나이 기사는 우리가 프로세스 초기에 그것에 대해 이야기 할 것을 옹호합니다.

참조 할 스타일 가이드를 얻을 수 있습니다.
 그러나 그것조차도 문맥을 식별하기에 충분히 구체적이지 않을 수 있습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_4D1460787A5F1D7103C72142FE37900B0A21B7DDB005645C4A053C6A671E55B9_1603909503101_ScreenShot2020-10-28at11.20.25AM.png?resize=1557%2C924&ssl=1)

다음 지침 중 하나를 확대 해 보겠습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_4D1460787A5F1D7103C72142FE37900B0A21B7DDB005645C4A053C6A671E55B9_1603909569973_ScreenShot2020-10-28at11.21.00AM.png?resize=455%2C538&ssl=1)

픽셀 크기 나 다양한 화면 크기에 대한 메모가 전혀없는 형식적이지만 일반적인 스타일 가이드를 얻을 수도 있습니다!

오해하지 마세요. 이런 종류의 일은 확실히 좋은 생각이며 일부 고객 회의 같은 다른 사람에게도 유용 할 수 있습니다.
 그러나 프런트 엔드 개발이 진행되는 한 도움이되기보다는 혼란 스럽습니다.
 멋지게 보이고 글꼴 크기와 같은 항목에 대한 훌륭한 지침을 많이 제공했지만 함께 제공되는 Photoshop 문서와 완전히 일치하지 않는 매우 철저한 스타일 가이드를 받았습니다.
 스펙트럼의 다른 쪽 끝에는 상상할 수있는 모든 유형의 제목과 조합에 대해 거룩하지 않은 양의 세부 사항이 포함 된 스타일 가이드가 있습니다.

최선의 의도로도이 항목을 파싱하기는 어렵습니다!

개발 경력의 초기에는 "그것을 파악"하고 작업을 시작하고 모든 픽셀을 적어두고 이해하기 위해 최선을 다하는 것이 귀하의 일이라고 생각할 것입니다.
 가서 가져와!

그러나 모든 세부 사항을 코딩하기 시작하면 진행되는 중복의 양으로 인해 상황이 약간 압도 될 수 있습니다.
 여기서 반복되는 모든 속성을 살펴보십시오.

```CSS
.blog article p {
  font-family: 'Georgia', serif;
  font-size: 17px;
  line-height: 1.4;
  letter-spacing: 0.02em;
  margin-bottom: 10px;
}

.welcome .main-message {
  font-family: 'Georgia', serif;
  font-size: 17px;
  line-height: 1.4;
  letter-spacing: 0.02em;
  margin-bottom: 20px;
}

@media (min-width; 700px) {
  .welcome .main-message {
    font-size: 18px;
  }
}

.welcome .other-thing {
  font-family: 'Georgia', serif;
  font-size: 17px;
  line-height: 1.4;
  letter-spacing: 0.02em;
  margin-bottom: 20px;
}

.site-footer .link list a {
  font-family: 'Georgia', serif;
  font-size: 17px;
  line-height: 1.4;
  letter-spacing: 0.02em;
  margin-bottom: 20px;
}
```

공통 선언을 대신 본문에 적용 할 수 있습니다.
 소규모 프로젝트에서는 이것이 좋은 방법 일 수도 있습니다.
 캐스케이드를 유리하게 사용하는 방법과 너무 많은 것을 함께 묶는 것처럼 보이는 다른 방법이 있습니다.
 객체 지향 프로그래밍 언어에서와 마찬가지로 모든 것이 반드시 모든 것을 상속하는 것을 원하지는 않습니다.

```CSS
body {
  font-family: 'Georgia', serif;
  font-size: 17px;
  line-height: 1.4;
  letter-spacing: 0.02em;
}
```

일이 잘 될 것입니다.
 대부분의 웹은 이렇게 만들어졌습니다.
 우리는 더 나은 것을 찾고 있습니다.

### 디자인 수정 처리

언젠가 회의가있을 것입니다.
 그 회의에서 클라이언트와 비주얼 디자이너가 타이포그래피를 변경하기로 결정했음을 알게 될 것입니다.
 이제 돌아가서 CSS 파일의 293 개 위치에서 변경해야합니다.
 시간당 지불을 받으면 좋을 것입니다!

규칙을 조정하기 시작하면 상황이 충돌하기 시작합니다.
 두 가지에 효과가 있었던 그 규칙은 이제 하나에 만 효과가 있습니다.
 또는 이전보다 더 많은 곳에서 사용할 수있는 패턴을 발견 할 것입니다.
 CSS를 완전히 삭제하고 다시 시작하고 싶을 수도 있습니다!
 이런!

여기에 작성하지는 않겠지 만, 시간이 지남에 따라 여러 가지를 시도 할 것이며, 사람들은 일반적으로 클래스를 생성 할 수 있다는 결론에 도달합니다. 모든 규칙 / 선언을 복제하는 대신 요소에 추가합니다.
 요소.
 더 나아가 비주얼 디자이너의 문서에서 패턴을 끌어 내려고합니다.
 (말하지 않고 19px를 18px로 반올림 할 수도 있습니다…)

```CSS
.standard-text { /* or something */
  font-family: serif;
  font-size: 16px; /* px: up for debate */
  line-height: 1.4; /* no unit: so it's relative to the font-size */
  letter-spacing: 0.02em; /* em: so it's relative to the font-size */
}

.heading-1 {
  font-family: sans-Serif;
  font-size: 30px;
  line-height: 1.5;
  letter-spacing: 0.03em;
}

.medium-heading {
  font-family: sans-Serif;
  font-size: 24px;
  line-height: 1.3;
  letter-spacing: 0.04em;
}
```

그런 다음 필요한 모든 것에 수업을 적용합니다.

```html
<header class="site-header">
  <h1 class="page-title heading-1">
    Be <mark>excellent</mark> to each other
  </h1>
</header>

<main class="page-content">
  <section class="welcome">
    <h2 class="medium-heading">Party on <em>dudes</em></h2>

    <p class="standard-text">And yeah. I'm just regular</p>
  </section>
</main>
```

이러한 작업 방식은 모든 기술 수준의 사람들이 HTML을 변경하는 팀에 매우 유용 할 수 있습니다.
 이 CSS 클래스를 플러그 앤 플레이하여 새로운 인턴이더라도 원하는 스타일을 얻을 수 있습니다.

"레이아웃"요소 (구조 / 상위)의 개념과 "모듈"또는 "구성 요소"의 개념을 분리하면 정말 유용합니다.
 이러한 방식으로 텍스트 조각을 하위 수준 구성 요소로 취급합니다.

핵심은 타이포그래피를 레이아웃과 별도로 유지하는 것입니다.
 모든`.medium-heading` 요소가 동일한 여백이나 색상을 갖기를 원하지는 않습니다.
 위치에 따라 달라집니다.
 이렇게하면 상황에 따라 스타일을 지정할 수 있습니다.
 캐스케이드를 반드시 `사용`하는 것은 아니지만 기술을 분리하여 유지하기 때문에 싸우는 것도 아닙니다.

```CSS
.site-header {
  padding: 20px 0;
}

.welcome .medium-heading { /* the context — not the type-pattern */
  margin-bottom: 10px;
}
```

이것은 일을 합리적이고 깔끔하게 유지합니다.
 이 기술은 웹 전체에서 사용됩니다.

### CMS 작업

좋습니다.하지만 HTML을 변경할 수없는 상황은 어떻습니까?

빠른 CodePen이나 명함 사이트를 입력 할 수도 있습니다.
 이 경우 이러한 우려는 지나친 것처럼 보일 것입니다.
 반면에 무슨 일이 일어날 지 확신 할 수없는 CMS로 작업 할 수 있습니다.
 당신은 당신에게 던져 질 수있는 모든 것을 계획해야 할 수도 있습니다.
 이 경우 단순히 개별 요소에 클래스를 추가 할 수 없습니다.
 일부 템플릿 언어에서 HTML 덤프를 얻을 수 있습니다.

``` 
<?php echo getContent()?>
<?=getContent()?>
${data.content}
{{model.cmsContent}}
```

그렇다면 HTML로 작업 할 수 없다면 무엇을 할 수 있습니까?

```html
<article class="post cms-blog-dump">
  <h1>Talking type-patterns on CSS-tricks</h1>
  <p>Intoduction paragraph - and we'd like to style this with a slightly different size font then the next (normal) paragraphs</p>
  <h2>Some headings</h2>
  <h2>And maybe someone accidentally puts 2 headings in a row</h2>
  <ol>
    <li>and some <strong>list</strong></li>
    <li>and here</li>
  </ol>

  <p>Or if a blog post is too boring - then think of a list of bands on an event site. You never know how many there will be or which ones are headlining, so you have to write rules that will handle whatever happens.
</article>
```

이 마크 업을 제어 할 수 없으므로 클래스를 추가 할 수 없습니다. 즉, 만든 멋진 플러그 앤 플레이 클래스가 작동하지 않습니다.
 부엌 싱크대에 대한 규칙을 정의하는 더 큰`.article {}`클래스에 복사하여 붙여 넣을 수 있습니다.
 작동 할 수 있습니다.

사용할 수있는 다른 도구는 무엇입니까?

Sass를 사용하여 "유형 패턴"이라는 재사용 가능한 개념을 만들 수 있다면 클래스 작동 방식과 유사한 방식으로이를 적용 할 수 있습니다.

Less, Sass, Stylus 및 기타 CSS 전처리 기는 모두 이에 대한 자체 구문을 가지고 있습니다.
 이 예제에서는 Sass / SCSS를 사용하려고합니다. 작성 당시 가장 일반적이기 때문입니다.

`heading-1 ()`과`heading-2 ()`를 사용할 수 있으며 많은 유명 스타일 가이드에서이를 수행합니다.
 하지만 "제목"이 아닌 것에 이러한 유형 스타일을 사용하려면 어떻게해야합니까?
 저는 개인적으로 제목을 "크기"로 연결하지 않고 모든 종류의 다른 장소에서 패턴을 사용합니다.
 때때로 내 제목은 "평균"과 "강력한"입니다.
 단락 텍스트와 동일한 x 높이로 빨간색과 대문자를 뚫을 수 있습니다.

대신 콘텐츠의 "음성"이 전달되는 방식과 관련하여 시각적 스타일을 정의합니다.
 이는 또한 팀이 여러 분야에서 "톤"및 기타 콘텐츠 전략에 대해 논의하는 데 도움이됩니다.

예를 들어 Jason Santa Maria의 저서 인 On Web Typography에서 그는 "잠시 동안 입력"및 "함께 살고 자 입력"에 대해 이야기합니다.
 주의를 끌고 페이지를 나누는 유형이 있고 그 다음에는 그 문단이 정해집니다.
 `.standard-text` 또는`.normal-font` 대신 음성으로 스타일을 정리하는 아이디어를 즐기고 있습니다.
 이것은 사용자가 시간을 소비해야하는 모든 유형입니다.
 대부분의 단락과 목록에 사용할 가능성이 높으며 본문에는 설정하지 않습니다.

이 "음성"아이디어는 문맥에 따라 이름을 지정해야하므로 의미있는 내용을 유지하는 데 도움이됩니다.
 예를 들어 `heading-1b`라는 이름은 콘텐츠를 어떤 종류의 스토리 텔링이나 팀의 다른 사람들과 연결하는 데 도움이되지 않습니다.

이제 미스터리 기사의 스타일을 지정합니다.
 여기서는 SCSS 구문을 사용합니다.

예쁘죠?

하지만 그렇게 쉽지는 않 지요?
 아니요. 기사가 항상 동일하게 구성되거나 구성되는 것은 아니기 때문에 서로의 위 또는 아래에 무엇이 있는지 또는 무엇을 생략 할 수 있는지 모르기 때문에 조금 더 복잡합니다.
 CMS 작성자는 원하는 것을 거기에 넣을 수 있습니다!
 연속 된 세 개의`<h3>`요소?
 가능한 많은 결과에 대비해야합니다.

일반 CSS를 보려면 항상 CodePen에서 "View Compiled"를 사용할 수 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 550px;"><iframe id="cp_embed_dyMjvpo" src="//codepen.io/anon/embed/dyMjvpo?height=550&amp;theme-id=1&amp;slug-hash=dyMjvpo&amp;default-tab=result" height="550" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed dyMjvpo" title="CodePen Embed dyMjvpo" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

어떤 사람들은 로보 토마 이즈 된 올빼미 접근법 (`* + *`)에 정말 만족하지만 저는 보통 "단락 뒤에 오는 모든`<h2>`"에 대한 명시적인 규칙을 작성하고 정말 상세하게 만듭니다.
 결국 모든 사람이 읽고 싶어하는 글이 쓰여진 내용입니다. 정말 한 곳에서 한 번만 전화를 걸면됩니다.

"이상적인"워크 플로에 대해 생각하는 것이 좋습니다.
 이것을 재미있게 만들고 미래의 시스템에서 잘 작동하도록 브라우저가 구현할 수있는 것은 무엇입니까?

다음은 가장 많이 제거 된 전 처리기 구문의 예입니다.

솔직히 말해서 ... 전 스타일러스가 좋아요.
 나는 그것을 쓰는 것을 좋아하고 예제로 사용하는 것을 좋아합니다.
 그것은 사람들을 발가락에 유지합니다.
 CodePen에 입력하는 것이 너무 빠릅니다!
 이와 같은 스타일의 작은 프레임 워크가 이미 있다면 UI를 얼마나 빨리 만들 수 있는지 정말 놀랍습니다.
 그러나!
 툴링이 뒤쳐져 서 지금은 누구에게도 사용하지 않는 것이 좋습니다.

꿈을 꾸는 것이 중요하기 때문에 여기에 추가합니다.
 우리는 우리가 가진 것을 가지고 있지만 그것을 쓰는 새로운 방법을 발명 할 수 있다면 어떨까요?
 그것도 대화의 중요한 부분입니다.
 원하는 것을 설명 할 수 없으면 얻을 수 없습니다.

### 현재 위치 : 유형 패턴

이 모든 것이 어디로 가는지 볼 수 있습니까?

이러한 "패턴", "믹신"또는 "무엇이든"이라고 부르고 플러그 앤 플레이 할 수 있습니다.
 재미 있어요.
 그리고 유틸리티 클래스 아이디어와 완전히 결합 할 수도 있습니다 (필요한 경우).

```html
<p class="calm-voice">Welcome to this code snippet!</p>
```

공통 언어를 공유하고 "창작자"와 "코더"사이의 장벽을 허물 수 있다면 모든 사람이 처음부터 이러한 유형 패턴을 염두에두고 작업 할 수 있습니다.

때로는 스타일 가이드를 `브랜드`하위 도메인으로 게시하거나`/ style-guide`와 같이 사이트에 직접 게시 할 수 있습니다.
 웹에 떠 다니는 수많은 것들이 있습니다.
 요점은 일부 스타일 가이드는 독립형이고 다른 스타일 가이드는 사이트 자체에 내장되어 있다는 것입니다.
 어디를 가든지 "살아있는"것으로 간주되어 전 세계적으로 영향을 미치는 것을 한곳에서 개발하고 가이드 자체를 일종의 인공물로 사용할 수 있습니다.

유형 패턴을 핵심 개념으로 공유하는 라이브 스타일 가이드를 구축하면 모든 사람이 더 재미있게 지내고 서로의 의미를 파악하는 데 시간을 절약 할 수 있습니다.
 대기업 뿐만이 아닙니다.

다른 조직을위한 스타일 가이드를 볼 때주의하십시오.
 스타일 가이드는 사용하는 사람과 방법에 따라 다른 용도로 사용되므로 다른 사람의 작업에 뛰어 드는 것만으로도 실제로 더 많은 혼란을 일으킬 수 있습니다.

콘텐츠가 무엇인지 모를 때도 있습니다.
 그것은 CMS 물건뿐만 아니라 논리도 의미합니다.
 밴드 및 이벤트 목록이 있고 조건부 구성 요소로 가득 찬 모듈을 구축하고 있다면 어떻게 될까요?
 하나의 밴드… 다섯… 또는 두 명의 공동 헤드 라이너가있을 수 있습니다.
 이벤트가 취소 될 수 있습니다!

Ticketfly에 대한 템플릿 아이디어를 구상하려고 할 때 레이아웃과 유형 패턴에 대한 우려를 분리했습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 550px;"><iframe id="cp_embed_zwYRzR" src="//codepen.io/anon/embed/zwYRzR?height=550&amp;theme-id=1&amp;slug-hash=zwYRzR&amp;default-tab=result" height="550" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed zwYRzR" title="CodePen Embed zwYRzR" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

일부 패턴은 다양한 중단 점에서 크기를 변경합니다.

나는 이와 같은 일을했는데 약간의 부작용이 있었다.
 예를 들어 중단 점을 기반으로 플러그 앤 플레이하고 충돌하거나 미끄러지는 크기가있는 경우 어떻게됩니까?

`clamp ()`와`vmin` 유닛을 구출하세요!

이제 이론적으로 문지르지 않고 패턴 사이를 뛰어 넘을 수도 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_QWNyVxa" src="//codepen.io/anon/embed/QWNyVxa?height=450&amp;theme-id=1&amp;slug-hash=QWNyVxa&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed QWNyVxa" title="CodePen Embed QWNyVxa" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

그러나 이제 둘 다 동일한 속성을 가지고 있고 다른 사람과 충돌하거나 피를 흘리지 않도록해야합니다!
 새로운 가변 글꼴 옵션도 생각해보십시오.
 작은 화면에서는 제목이 약간 덜 무거워 지거나 공간에서 작업하기 위해 약간 더 커지기를 원할 수 있습니다.

이런!
 너는 나를 잡았다.
 저는 CSS 바이트 크기에 관심이있는 것보다 저작과 프로세스를 즐겁게 유지하는 데 더 관심이 있습니다.
 그래도 갈등이 있습니다.
 알겠습니다.
 그러나 솔루션은 파이프 라인의 다른 곳에서 발생해야한다고 생각합니다.
 기계어 코드를 직접 작성하지 않는 데에는 이유가 있습니다.

때로는 프로그래밍 패턴을 면밀히 조사하고 실제로 찌르고 그것이 얼마나 유용한 지 증명하기 위해 모든 곳에서 시도해야합니다.
 움직임에 대해 저를 유머러스하게 만들고이 유형 패턴과 기타 믹스 인을 사용하여 일반적인 "카드"인터페이스를 스타일링하는 방법을 살펴보세요.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_PozybwX" src="//codepen.io/anon/embed/PozybwX?height=250&amp;theme-id=1&amp;slug-hash=PozybwX&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed PozybwX" title="CodePen Embed PozybwX" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

어떤면에서 유형 패턴은 Bootstrap 또는 Tailwind의 유틸리티 클래스 스타일과 같습니다.
 그러나 이것들은 사람이 읽을 수 있습니다.
 패턴은 HTML 대신 CSS에 추가됩니다.
 개념은 동일합니다.
 누구나 리빙 스타일 가이드를보고 구성 요소에 뛰어 들어 스타일을 지정할 수 있다고 생각합니다.
 어떻게 생각해?

그래도 더 많은 CSS를 만들고 있습니다.
 그 킬로바이트가 쌓이고 있습니다.
 하지만 저는 우리가 단지 "가능한"것보다 이상적인 것을 향해 노력해야한다고 생각합니다.
 우리는 아마도 빌드 타임에 이것을 작동하는 무언가를 만들 수있을 것입니다.
 저는 CSSOM에 대해 더 많이 배워야 할 것이며, 전 처리기없이이를 가능하게 할 수있는 많은 새로운 것들이 파이프 라인 아래로 내려올 것입니다.

### CSS보다 큽니다.
 사람들에 관한 것입니다.

프로젝트에 유형에 대한 패턴 세트가 있으면 비주얼 디자이너가 마법에 집중할 수 있습니다.
 점점 더 브라우저에서 빠르게 구축하고 있습니다.
 비주얼 디자이너는 스타일 타일과 같은 간단한 프레임 워크를 사용하여 느낌과 타이포그래피 및 색상에 중점을 둡니다.
 그런 다음 개발자는 데이터, 리소스 구조 및 레이아웃을 구성 할 수 있으며 모든 사람이 동시에 작업 할 수 있습니다.
 우리는 전체 프로세스에 대해 더 명확한 의사 소통과 공유 이해를 가질 수 있습니다.
 우리는 모두 UX 디자이너입니다.

리빙 스타일 가이드를 팀으로 만들면 픽셀 푸싱이 훨씬 덜 필요합니다.
 비주얼 디자이너는 실제로 프로토 타입에서 아이디어를 생각하고 시도하는 데 더 많은 시간을 할애하고 불필요한 프로덕션 아트를 조롱하는 시간을 줄일 수 있습니다.
 이를 통해 브랜드 전체에서 작업하고 하나의 단일 소스 소스를 가질 수 있습니다.
 이처럼 정말 작은 사이트에서도 도움이됩니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_4D1460787A5F1D7103C72142FE37900B0A21B7DDB005645C4A053C6A671E55B9_1604891365591_ScreenShot2020-11-08at7.09.16PM.png?resize=2078%2C1584&ssl=1)

이러한 이유로 InDesign과 Illustrator에는 항상 "단락 스타일"과 "문자 스타일"이 있었지만 가변 화면 크기를 고려하지 않았습니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_4D1460787A5F1D7103C72142FE37900B0A21B7DDB005645C4A053C6A671E55B9_1608242454950_ScreenShot2020-12-17at1.57.09PM.png?resize=2226%2C1986&ssl=1)

몇 가지 패딩 유형 크기 / 비율, 일부 색상 및 일부 선 너비를 던져보세요.
 실제로 "픽셀 완벽"일 필요는 없지만 함께 작동하는 패턴 모음입니다.
 색상을 변수로 사용하고`$ thick`,`$ thin` 또는`$ pad * 2` 유형 규칙을 사용하면 디자인 패턴을 간소화 할 수 있습니다.

그래픽 프로그램에서 영감을 찾은 다음 라이브 스타일 가이드로 바로 이동할 수 있습니다.
 모든 배경을 가진 사람들은 CodePen에서 스타일로 플레이를 시작하고 여러 장치에서 다이얼 할 수 있습니다.

결국 실제 기기에 대한 세부 정보를 함께 결정하게됩니다.