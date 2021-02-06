---
layout: post
title: "CSS 미디어 쿼리에 대한 전체 가이드"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/10/guide-media-queries.png
tags: MEDIA QUERIES
---


미디어 쿼리는 특정 특성, 기능 및 사용자 환경설정에 따라 브라우저를 대상으로 지정한 다음 스타일을 적용하거나 이를 기반으로 다른 코드를 실행할 수 있는 방법입니다. 아마도 세계에서 가장 일반적인 미디어 쿼리는 특정 뷰포트 범위를 대상으로 하고 사용자 정의 스타일을 적용하는 쿼리일 것이며, 이는 반응형 설계에 대한 전체 아이디어를 탄생시켰다.

```css
/* When the browser is at least 600px and above */
@media screen and (min-width: 600px) {
  .element {
    /* Apply some styles */
  }
}
```

뷰포트 폭 외에도 우리가 목표로 삼을 수 있는 많은 것들이 있다. 이는 화면 해상도, 장치 방향, 운영 체제 기본 설정 또는 콘텐츠 스타일 지정에 쿼리하고 사용할 수 있는 모든 것들 중에서 더 많이 발생할 수 있습니다.

전화, 태블릿, 노트북과 같은 표준 장치의 뷰포트를 기반으로 한 미디어 쿼리의 빠른 목록을 찾고 계십니까? 우리의 조각 모음을 확인해 보세요.

### 미디어 쿼리 사용

미디어 쿼리는 일반적으로 CSS와 연결되지만 HTML과 JavaScript에서도 사용할 수 있다.

### 미디어 쿼리의 해부도

이제 미디어 쿼리가 사용될 수 있는 몇 가지 예를 보았으니, 미디어 쿼리가 실제로 무엇을 하고 있는지 살펴보도록 하겠습니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/09/media-query-anatomy.jpg?resize=2361%2C156&ssl=1)

### 미디어 쿼리가 정말 필요하십니까?

미디어 쿼리는 흥미로운 숨겨진 보석이 있는 CSS 도구 상자의 강력한 도구입니다. 하지만 만약 당신이 당신의 디자인을 가능한 모든 상황에 맞추면, 당신은 결국 너무 복잡한 코드베이스를 갖게 될 것입니다. 우리 모두가 알다시피, CSS는 곰의 새끼와 같습니다. 귀엽고 공격적이지 않지만, 그것이 성장하면 당신을 산 채로 잡아먹을 것입니다.

그래서 라날드 메이스의 유니버설 디자인 컨셉을 따를 것을 권하는 것인데, "적응이나 전문화된 디자인 없이도 가능한 한 모든 사람이 사용할 수 있는 제품의 디자인"이다.

모두를 위한 접근성에 대해 Laura Kalbag은 접근성과 유니버설 디자인의 차이가 미묘하지만 중요하다고 설명합니다. 접근 가능한 설계자는 휠체어를 탄 사람들이 들어갈 수 있는 큰 문을 만드는 반면, 범용 설계자는 그들의 능력을 무시한 채 누구나 들어갈 수 있는 항목을 만들 것이다.

웹상에서 유니버설 디자인에 대해 이야기하는 것이 어렵고 거의 건전한 유토피아적이라는 것을 압니다. 하지만 생각해보세요. 사용자 선호도의 조합은 150개 정도 됩니다. 앞서 말씀드린 바와 같이 24000개 이상의 서로 다른 안드로이드 기기만 가지고 있습니다. 즉, 콘텐츠가 표시될 수 있는 사례가 최소 1,800만 건 이상일 수 있습니다. 환상적인 미리암 수잔의 말을 빌리자면 CSS는 무한하고 알려지지 않은 캔버스에서 운영체제, 인터페이스 전반에 걸쳐 알려지지 않은 콘텐츠의 그래픽 디자인을 시도하고 있습니다.

그렇기 때문에 제품을 설계, 개발 및 생각할 때 가정을 버리고 미디어 쿼리를 사용하여 콘텐츠가 모든 연락처와 사용자 앞에 올바르게 표시되도록 하는 것은 매우 위험한 일입니다.

### 최소- 및 최대-를 사용하여 값 범위 일치

이전 절에서 설명하는 `폭`, `높이`, `색상`, `색상지수` 등 많은 미디어 기능들은 최소 또는 최대 제약 조건을 표현하기 위해 `min-` 또는 `max-`로 접두사를 붙일 수 있다. 우리는 이미 많은 사례들을 통해 이러한 것들이 사용되고 있는 것을 보았으나, 요점은 우리가 특정한 값을 선언하는 대신에 일치시킬 수 있는 가치의 범위를 만들 수 있다는 것입니다.

다음 조각에서, 우리는 뷰포트 폭이 30em보다 넓고 80em보다 좁을 때 몸의 배경을 보라색으로 칠하고 있습니다. 뷰포트 너비가 값의 범위와 일치하지 않으면 흰색으로 바뀝니다.

```css
body {
  background-color: #fff;
}

@media (min-width: 30em) and (max-width: 80em) {
  body {
    background-color: purple;
  }
}
```

미디어 쿼리 수준 4는 (`=`), (````보다 작거나 (`=`) 연산자보다 크거나 같은 연산자를 사용하여 새롭고 간단한 구문을 지정합니다. 불행히도 글을 쓸 때는 파이어폭스에 의해서만 지원된다.

### 중첩 및 복잡한 의사 결정

CSS를 사용하면 괄호를 사용하여 at-rule 또는 그룹 문을 중첩할 수 있으므로 복잡한 작업을 평가할 수 있습니다.

```css
@media (min-width: 20em), not all and (min-height: 40em) {  
  @media not all and (pointer: none) { ... }
  @media screen and ( (min-width: 50em) and (orientation: landscape) ), print and ( not (color) ) { ... }
}
```

주의하세요! 강력하고 복잡한 표현을 만들 수 있다고 해도, 여러분은 매우 긍정적이고 질문을 유지하기가 어려울 수도 있습니다. Brad Frost의 말처럼, "우리의 인터페이스가 더 복잡할수록, 우리는 그것들을 적절히 유지하기 위해 더 많은 생각을 해야 합니다."

### 접근성

미디어 쿼리 수준 4에 추가된 많은 기능은 접근성을 중심으로 합니다.

➡-➡-➡-motion은 사용자가 동작과 애니메이션의 양을 최소화하기 위해 동작 선호도가 감소했는지 여부를 감지합니다. 다음 두 가지 값을 사용합니다.

- `무선호`: 사용자가 시스템에 기본 설정을 알리지 않았음을 나타냅니다.
- `줄이다`: 사용자가 이동량이나 애니메이션의 양을 최소화하는 인터페이스를 선호한다고 시스템에 통보했음을 나타냅니다(선택 사항으로 모든 비필수 이동이 제거된 지점).

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/09/macos-preference-motion.png?resize=780%2C588&ssl=1)

이 선호도는 일반적으로 전정맥 장애나 현기증을 앓고 있는 사람들이 사용하는데, 다른 움직임으로 인해 균형감각, 편두통, 메스꺼움 또는 청력 손실이 발생한다. 만약 여러분이 빨리 회전하려고 시도하고 어지러워진 적이 있다면, 여러분은 그것이 어떤 기분인지 알 것입니다.

에릭 베일리의 환상적인 기사에서, 그는 이 코드로 모든 애니메이션을 중단하라고 제안했습니다.

```css
@media screen and (prefers-reduced-motion: reduce) {  
  * {
    /* Very short durations means JavaScript that relies on events still works */
    animation-duration: 0.001ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.001ms !important;
  }
}
```

부트스트랩과 같은 널리 사용되는 프레임워크에는 기본적으로 이 기능이 설정되어 있습니다. 내 생각에는 `선호감소운동`을 안 쓸 이유가 없다. 그냥 써라.

prefer-contrast 기능은 사용자가 시스템 기본 설정 또는 브라우저 설정에서 대비를 증가 또는 감소하도록 선택했는지 여부를 알려줍니다. 다음 세 가지 값이 필요합니다.

- `무선호`: 사용자가 시스템에 기본 설정을 알리지 않은 경우. 부울로 사용하면 잘못된 것으로 평가됩니다.
- `높음`: 사용자가 더 높은 대비 수준을 표시하는 옵션을 선택한 경우.
- low: 사용자가 낮은 대비 수준을 표시하는 옵션을 선택한 경우.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/09/macos-preference-contrast.png?resize=780%2C588&ssl=1)

현재 이 기능은 어떤 브라우저에서도 지원되지 않습니다. 마이크로소프트는 마이크로소프트 엣지 v18 이하 버전(크롬 기반 버전은 지원하지 않는)에서만 작동하는 `-ms-고대비` 기능으로 초기에 비표준화했다.

```css
.button {
  background-color: #0958d8;
  color: #fff;
}

@media (prefers-contrast: high) {
  .button {
    background-color: #0a0db7;
  }
}
```

이 예제는 사용자가 고대비를 켤 때 클래스 버튼의 대비를 AAA에서 AAA로 증가시키는 것이다.

반전된 색상은 사용자가 시스템 기본 설정에서 색상을 반전하도록 선택했는지 또는 브라우저 설정에서 반전하도록 선택했는지 여부를 알려줍니다. 이 옵션은 고대비 대신 사용되는 경우가 있습니다. 다음 세 가지 값이 필요합니다.

- `없음`: 색상이 정상적으로 표시되는 경우
- ➡: 사용자가 색상 반전 옵션을 선택한 경우

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/09/macos-preference-invert-colors.png?resize=780%2C588&ssl=1)

투자된 색상의 문제는 이미지와 비디오의 색도 뒤집어 X선 이미지처럼 보이게 한다는 것입니다. CSS 반전 필터를 사용하여 모든 영상 및 비디오를 선택하고 다시 반전할 수 있습니다.

```css
@media (inverted-colors) {
  img, video { 
    filter: invert(100%);
  }
}
```

작성 시 이 기능은 Safari에서만 지원됩니다.

다크 모드 색 구성표를 갖는 것은 요즘 우리가 훨씬 더 많이 볼 수 있는 것이고, 선호 색상 체계 기능 덕분에 우리는 사용자의 시스템이나 브라우저 선호도를 이용하여 어두운 테마를 제공하는지, 밝은 테마를 제공하는지를 결정할 수 있다.

다음 두 가지 값을 사용합니다.

- `빛`: 사용자가 라이트 테마를 선호하거나 활성 환경설정이 없는 경우
- `dark`: 사용자가 설정에서 다크 디스플레이를 선택한 경우

![image](https://paper-attachments.dropbox.com/s_0BFBF55A2024DE950EFA25781444032C5BBE17E7EC9DD277E9E0361558E9B210_1595791834440_Screen+Shot+2020-07-26+at+4.28.13+PM.png)

```css
body {
  --bg-color: white; 
  --text-color: black;

  background-color: var(--bg-color);
  color: var(--text-color);
}

@media screen and (prefers-color-scheme: light) {
  body {
    --bg-color: black;
    --text-color:white;
  }
}
```

Adhham이 Dark Mode에 대한 완전한 가이드에서 설명하듯이, 배경의 색을 바꾸는 것 이상의 것이 있다. 다크 모드를 실행하기 전에 스마트한 구현 전략이 없으면 코드베이스를 유지 관리하기 어려울 수 있다는 점을 기억하십시오. CSS 변수는 그것에 놀라운 일을 할 수 있지만 그것은 다른 기사의 주제이다.

### 앞에 뭐가 있지?

미디어 쿼리 레벨 5는 현재 작업 초안 상태이며, 이는 현재와 권장 사항이 되는 시점 사이에 많은 항목이 변경될 수 있음을 의미합니다. 그러나 그것은 화면을 타겟으로 하고 매우 특정한 조건에 맞게 디자인을 조정하는 새로운 방법을 열어주기 때문에 언급할 가치가 있는 흥미로운 기능들을 포함하고 있다.

이봐, 우리가 막 마지막 섹션에서 다뤘어! 아, 그래요. 이러한 기능은 사용자 에이전트 또는 운영 체제 수준에서 사용자의 실제 설정을 통해 알려지기 때문에 매우 유용합니다.

이거 깔끔하네요. 일부 브라우저는 스타일을 렌더링하는 데 사용할 수 있는 색상 수를 제한합니다. 이를 "강제 색상 모드"라고 하며, 브라우저 설정에서 활성화된 경우 사용자는 페이지에서 사용할 제한된 색상 집합을 선택할 수 있습니다. 그 결과 사용자는 콘텐츠를 읽기 편하게 만드는 색상 조합과 대비를 정의할 수 있다.

강제 색상 기능을 사용하면 강제 색상 팔레트가 활성 값과 함께 사용 중인지 탐지할 수 있습니다. 일치하는 경우 브라우저는 CSS 시스템 색상을 통해 필요한 색상 팔레트를 제공해야 합니다. 브라우저는 또한 페이지의 배경색이 밝은지 어두운지 판단할 수 있는 여유를 부여받으며, 필요한 경우 "기본 설정 색-구성표" 값을 트리거하여 페이지를 조정할 수 있도록 한다.

일부 장치(및 브라우저)는 매우 밝은 디스플레이, 광범위한 색상 및 높은 색상 간 대비 비율을 제공할 수 있다. 높은 키워드가 이 장치와 일치하고 표준 키워드가 다른 모든 장치와 일치하는 동적 범위 기능을 사용하여 이러한 장치를 탐지할 수 있습니다.

현재로선 어떤 측정값이 "높은" 밝기와 대비 수준을 구성하는지에 대한 불확실성이 여전히 존재하기 때문에, 이러한 변화가 나타날 것으로 보입니다. 브라우저가 이러한 결정을 내릴 수 있습니다.

이 규격은 TV와 같이 비디오와 그래픽을 별도의 "평면"에 표시할 수 있는 일부 화면에 대해 이야기하는데, 이는 비디오 프레임을 화면의 다른 요소와 구별하는 방법이 될 수 있다. 이와 같이, 미디어 쿼리 레벨 5는 색 채광과 동적 범위를 포함한 비디오 특성을 감지하기 위한 새로운 미디어 기능 세트를 제안하고 있다.

비디오 높이, 폭, 해상도를 탐지하자는 제안도 있지만, 배심원단은 그것들이 비디오를 다루는 올바른 방법인지에 대해 아직 결정을 내리지 못하고 있다.

### 브라우저 지원

브라우저가 계속 발전하고 이 게시물을 읽을 때쯤 이 기능에 대한 브라우저 지원이 변경될 수 있으므로 MDN 업데이트 브라우저 호환성 표를 확인하십시오.

### 사양

- 미디어 쿼리 레벨 4(후보 추천)
- 미디어 쿼리 레벨 5(작업 초안)

이 가이드를 검토하는 데 도움을 준 Sarah Rambacher에게 특별한 감사를 드립니다.