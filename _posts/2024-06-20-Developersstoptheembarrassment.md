---
title: "개발자 여러분, 창피하지 마세요"
description: ""
coverImage: "/assets/img/2024-06-20-Developersstoptheembarrassment_0.png"
date: 2024-06-20 14:02
ogImage: 
  url: /assets/img/2024-06-20-Developersstoptheembarrassment_0.png
tag: Tech
originalTitle: "Developers, stop the embarrassment"
link: "https://medium.com/user-experience-design-1/developers-stop-the-embarrassment-5c75de8f4c06"
---


<img src="/assets/img/2024-06-20-개발자_0.png">

# 소개

WebAIM의 밀리언 리포트는 상위 백만 홈페이지의 웹 접근성 테스트입니다. 저번 글에서 언급했듯이, 결과가 부끄러울 정도입니다.

당신의 사이트가 어떻게 되는지 확인하고 싶다면, WebAIM의 WAVE 도구에 URL을 입력해보세요.

<div class="content-ad"></div>

여기 나열된 변경 사항을 적용하면 웹 상위 100만 사이트 대부분보다 더 나은 접근성을 갖게 될 거에요.

# 낮은 대조 텍스트

순응 색상을 찾는 데 필요한 시간: ~ 10초

보통 접근성 도구가 이를 감지하지만 항상 그렇지는 않아요 — 특히 그라데이션 색상이나 다른 허튼 짓을 사용하는 경우에요.

<div class="content-ad"></div>

만약 Chrome이나 Edge를 사용 중이라면 텍스트의 충분한 색 대비를 확인하고, 그렇지 않은 경우 권장 값을 얻을 수 있습니다. 참고로, 제 알기로 Firefox는 이 기능을 제공하지 않습니다. 하지만 색상이 준수되지 않았다는 메시지는 표시될 것입니다.

텍스트를 검사해보세요 (텍스트 위에서 마우스 오른쪽 버튼을 클릭하고, 컨텍스트 메뉴에서 "검사"를 클릭합니다). 페이스북 홈페이지의 "비밀번호를 잊으셨나요?" 링크에 대해 시도해보겠습니다:


![Screenshot](/assets/img/2024-06-20-Developersstoptheembarrassment_1.png)


개발자 도구에서 "비밀번호를 잊으셨나요?" 링크의 `a` 요소가 강조 표시되었는지 확인하세요. 스타일을 살펴보세요:

<div class="content-ad"></div>

![이미지](/assets/img/2024-06-20-Developersstoptheembarrassment_2.png)

가장 상단에 있는 색상 스타일을 살펴보세요. 이 경우, 선택기인 ._8icy ._6ltj a에서 (#1877F2라는) 값을 가지고 있어요. (네, 그 클래스들이 무슨 의미인지 알 필요는 없어요)

색상 값을 보려면 파란색 정사각형을 클릭하고 색상 선택기 대화상자가 표시됩니다:

![이미지](/assets/img/2024-06-20-Developersstoptheembarrassment_3.png)

<div class="content-ad"></div>

여기서 최소 4.5:1 비율을 준수하지 않는다는 것을 알 수 있을 거에요. "콘트라스트 비율 4.23" 텍스트는 아코디언에 있어요. 그 영역 어디에서든 클릭하면 (단, "no" 또는 "ban" 아이콘을 누르지는 말아 주세요) 색에 관한 추가 정보를 얻을 수 있어요.

<img src="/assets/img/2024-06-20-Developersstoptheembarrassment_4.png" />

참고: "no" / "ban" 아이콘을 클릭하면 색 대비에 관한 기사로 이동해요.

이 편리한 작은 영역에서 Chrome/Edge는 준수하는 유사한 색을 제공해요. Level AA(4.5:1) 및 Level AAA(7:1)용으로 각각 한 가지 색을 제공해요. 해당 파란색 사각형을 클릭하면 HEX 값이 준수하는 색으로 업데이트되고 페이지의 색도 업데이트돼요. 여기에 기본, AA, AAA 세 가지가 어떻게 보이는지 알려드릴게요:

<div class="content-ad"></div>


<img src="/assets/img/2024-06-20-Developersstoptheembarrassment_5.png" />

이제 말해봐요: 그 기본 색상을 어떤 사용자에게 이득을 제공하나요? 기본과 AAA 레벨 색상 사이에도 같은 말을 할 수 있어요. 시각적으로 색상 지각 도전이 없는 사용자들에게도 AAA 레벨 색상보다 더 연한 파란색을 가지는 것이 정말 더 나은가요?

어쨌든, 스타일을 준수하는 색상으로 업데이트하고 모든 텍스트 색상에 적용해주시고, 끝났어요.

축하합니다! 이 변경만으로 귀하의 사이트는 836,000개의 인기 있는 백만 홈페이지 중 텍스트 색 대비 측면에서 더 접근성이 높아졌어요.


<div class="content-ad"></div>

그게 어렵다고 생각하셨나요?

# 이미지 (대체 텍스트)

하나의 이미지 수정에 필요한 시간: ~ 10초

홈페이지 중 58% 이상의 이미지에는 대체 속성이 없었습니다.

<div class="content-ad"></div>

친구야! 왜 이게 아직도 문제야?!

먼저 페이지에 있는 이미지 수를 최소화해 보세요. 아마 현재 있는 것만큼 많이 필요하지는 않을 거에요.

두 번째로, 이미지가 콘텐츠나 페이지의 맥락에 아무것도 추가하지 않는다면 제거해야 해요. 하지만 남겨야 한다면 다음 속성을 부여해 주세요: alt="". 이것은 보조 기술에게 이미지가 시각적으로만 있는 것이라는 것을 전달하고 공백과 동등한 역할을 합니다.

만약 이미지가 콘텐츠나 맥락에 도움이 된다면 관련된 alt 속성 값을 제공해 주세요.

<div class="content-ad"></div>

# 빈 링크

하나의 깨진 링크를 고치는 데 걸리는 시간: ~ 10 초

어떤 이유에서인지 (*허다* *허다* UI 프레임워크 *허다*), href 속성이 없는 링크들이 정말 많이 있네요.

테스트한 페이지 중 절반 이상이 빈 링크를 가지고 있었어요. 절반도 이상하다구요!

<div class="content-ad"></div>

매우 명확하게 말씀드리겠습니다. 유효한 href 속성이 없는 앵커 요소 (`a`)는 잘못된 요소입니다.

유효한(존재하는) href 대상을 제공하거나 다른 요소로 변경하십시오.

예를 들어, 앵커 요소를 `button`으로 사용하는 경우, 이를 `button` 요소로 변경해주세요.

# 라벨

<div class="content-ad"></div>

한 라벨을 고치는 데 필요한 시간: 15초 정도

함께 말해봅시다: 플레이스홀더는 라벨이 아니에요!
사실, 너 자신(그리고 웹도)에게 호의를 베푸어 플레이스홀더가 존재하지 않는 것처럼 잊어버려야 해요.
그리고 부디 부유 라벨에 관한 것도 말하지 말아 주세요.

페이스북으로 다시 돌아가보죠 (한숨). 여기가 E메일 필드에 대한 마크업입니다:

```js
<input type="text" class="inputtext _55r1 _6luy" name="email" id="email" 
data-testid="royal_email" placeholder="이메일 또는 전화번호" autofocus="1" 
aria-label="이메일 또는 전화번호">
```

<div class="content-ad"></div>

그리고 여기가 렌더링된 제어 요소입니다:

![Control](/assets/img/2024-06-20-Developersstoptheembarrassment_6.png)

본문 상 태그 변화를 무료로 쉽게 구현할 수 있다는 걸 보여주기 위해 무료 스크린 리더인 NVDA를 사용 중입니다. 이 텍스트 상자를 위해 NVDA가 읽은 내용은 다음과 같습니다:

이메일 주소 또는 전화번호를 받는 필드를 갖는 것이 성공 기준 1.3.5 위반임을 무시하고 얼래빠지자 (전화번호를 허용하지만 그렇게 식별되지 않고 이메일 필드로만 식별됩니다).

<div class="content-ad"></div>

이 마크업을 세 가지 빠른 변경으로 수정할 수 있어요:

- placeholder 속성을 제거해주세요. (필요하지 않아요.)
- aria-label 속성을 제거해주세요. (라벨이 있다면 필요하지 않아요.)
- 암시적 라벨을 추가해주세요. (텍스트 상자를 label 요소로 감싸세요.)

```js
<label>Email or phone number
<input type="text" class="inputtext _55r1 _6luy" name="email" id="email" 
data-testid="royal_email" autofocus="1">
</label>
```

이렇게 렌더링되요:

<div class="content-ad"></div>

<img src="/assets/img/2024-06-20-Developersstoptheembarrassment_7.png" />

여기서 라벨을 왼쪽 정렬로 스타일링하고 (아마도) 더 크게 만들 수 있습니다.

NVDA가 읽는 내용은 다음과 같습니다:

그게 다에요. 이러한 다음 텍스트 상자를 찾아서 변경하고 반복하세요. 끝났어요.

<div class="content-ad"></div>

# 빈 버튼

한 버튼을 고치는 데 걸리는 시간: 약 10초

테스트한 홈페이지 중 27% 이상이 빈 버튼을 보유하고 있습니다. 빈 버튼이란 텍스트나 읽을 수 있는 내용이 없는 버튼을 의미합니다.

다시 한 번 얘기하지만, 이 문제는 타사 UI 프레임워크의 잘못입니다. 만약 버튼에 텍스트가 없다면, 그것은 버튼일 자격이 없다고 할 수 있습니다.

<div class="content-ad"></div>

버튼에 텍스트를 추가하거나 다른 내용으로 변경해주세요.

# 언어 값

유효한 언어 값 입력에 소요되는 시간: 약 5초

테스트된 페이지 중 약 19%가 `html` 요소에 lang 값을 지정하지 않았습니다. 얼마나 부주의한 행동인가요?

<div class="content-ad"></div>

만약 페이지의 기본 언어가 영어인 경우, lang="en"을 사용합니다. 그렇지 않은 경우, IANA Language Subtag 레지스트리에서 언어 값을 찾아보세요.

# 제목

건너 뛴 제목을 수정하는 데 걸리는 시간: ~ 5초

테스트된 사이트 중 42% 이상이 건너 뛴 제목을 가지고 있었습니다.

<div class="content-ad"></div>

아래 작업을 수행해주세요:

- 스타일을 위해 제목 요소(h1 ~ h6) 사용을 중단하세요.
- 페이지 당 하나의(h1 하나만) `h1` 요소가 있어야 합니다.
- 다른 제목 요소는 그 상위 요소가 한 단계 높아야 합니다. 예를 들어, 각 `h2`는 `h1`의 자식이어야 하고, 각 `h3`는 `h2`의 자식이어야 합니다.
- 이러한 제목 요소의 스타일을 귀중한 ​​디자인 니즈에 맞게 업데이트하세요.

![image](/assets/img/2024-06-20-Developersstoptheembarrassment_8.png)

# 결론

<div class="content-ad"></div>

여기에는 ARIA 속성, 표(table), 영역(region) 및 건너뛰기 링크(skip links)와 같은 다른 항목을 포함할 수 있습니다. 그러나 이 중에서 가장 흔한 문제입니다.

WebAIM의 Million Report 결과가 분명한 것은, 이러한 문제들이 가장 쉽게 수정할 수 있는 접근성 오류 중 일부라는 점입니다. 그러나 지난 몇 년간의 결과에 따르면, 개선이 없었습니다. 이는 최상위 사이트조차 이를 우선시하지 않았다는 것을 의미합니다. 이는 창피한 일입니다.

기본으로 돌아가기만 하면 접근성은 어렵지 않습니다. 의도된 방법대로 요소를 사용하세요.

우리는 웹을 망쳤습니다. 올해는 그것을 바로 잡아봅시다.

<div class="content-ad"></div>

# 링크

## 언급된 내용

- WebAIM의 백만 리포트
- 우리는 모두 웹에 부끄러워해야 합니다: WebAIM의 2023 웹 접근성 보고서
- WebAIM의 WAVE 도구
- Facebook의 홈페이지
- Web.dev 색상 및 명암 접근성
- NVDA (무료 스크린 리더)
- 성공 기준 1.3.5: 입력 목적 식별
- IANA 언어 하위 태그 레지스트리

## 추가 읽을거리

<div class="content-ad"></div>

- Lukas Oppermann님의 WCAG 컬러 대조를 올바르게 설정하기
- Alexa Heinrich님의 대체 텍스트의 기술
- Michael Wilson님의 헤딩 태그 이해 및 왜 많은 웹사이트들이 잘못 사용하는지
- Adam Silver님의 플로팅 레이블은 문제가 있다