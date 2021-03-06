---
layout: post
title: "Chrome DevTools의 2020년 새로운 기능 보기"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2018/02/chrome-devtools.jpg
tags: CHROME,DEVTOOLS
---


Chrome DevTools의 몇 가지 새로운 기능을 여러분과 공유하게 되어 기쁩니다. 아래에 간략한 소개가 있으며, 새로운 DevTools의 많은 기능에 대해 살펴보겠습니다. 다른 브라우저에서도 어떤 일이 일어나고 있는지 알아보겠습니다. 온라인에서 찾을 수 있는 가장 큰 DevTools 팁 모음인 DevTips를 만들면서 이러한 정보를 계속 확인할 수 있습니다.

DevTools는 지속적으로 발전하고 새로운 기능은 개발 및 디버깅 환경을 개선하고 지원할 수 있도록 특별히 설계되었기 때문에 무엇이 변경되었는지 알아보는 것이 좋습니다.

가장 최신의 가장 위대한 것에 대해 알아보자. 공용의 안정적인 버전의 크롬은 이러한 기능들을 대부분 가지고 있지만, 저는 출혈의 가장자리에 머무르는 것을 좋아하기 때문에 크롬 카나리아를 사용하고 있습니다.

### 등대

Lighthouse는 일반적으로 성능, SEO, 접근성 등을 중심으로 웹 페이지를 감사하기 위한 오픈 소스 도구이다. Lighthouse는 한동안 DevTools의 일부로 번들로 제공되었으므로 다음과 같은 이름을 가진 패널에서 찾을 수 있습니다. 등대!

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/07/image-18.png?resize=2372%2C1586&ssl=1)

나는 Lighthouse가 DevTools에서 사용하기 가장 쉬운 부분 중 하나이기 때문에 Lighthouse를 정말 좋아한다. 보고서 생성을 클릭하면 다음과 같이 사용자가 읽을 수 있는 웹 페이지의 노트가 즉시 표시됩니다.

> 문서는 읽기 쉬운 글꼴 크기를 100% 읽기 쉬운 텍스트로 사용한다.

또는:

> 과도한 DOM 크기(1,189개 요소)를 사용하지 마십시오.

거의 모든 감사 링크는 감사 실패 방법과 감사 개선을 위해 수행할 수 있는 작업을 설명하는 개발자 문서에 연결됩니다.

Lighthouse를 시작하는 가장 좋은 방법은 웹 사이트에서 감사를 실행하는 것입니다.

- 사이트 중 하나에 있을 때 DevTools를 열고 Lighthouse 패널로 이동합니다.
- 감사할 항목을 선택합니다(Best Practice가 좋은 시작점임).
- 보고서 생성을 클릭합니다.
- 통과/실패한 감사를 클릭하여 결과를 조사합니다.

Lighthouse는 2017년부터 한동안 DevTools에 속해 있었지만, 다음과 같은 사용자 대면 기능을 계속 제공하고 있기 때문에 여전히 언급할 가치가 있습니다.

- 앵커 요소가 URL로 확인되는지 확인하는 감사(Funfact: 내가 이 일을 해냈어!
- 가장 큰 내용물 도장 세밀도가 빠른지 여부를 확인하는 감사
- 사용하지 않은 JavaScript를 경고하기 위한 감사

### 더 나은 "검사 요소"

이것은 미묘하고, 어떤 면에서는 매우 작은 특징이지만, 우리가 웹 접근성을 어떻게 다루는지에 큰 영향을 미칠 수 있습니다.

작동 방식은 이렇습니다. DevTools의 가장 일반적인 용도인 Inspect Element를 사용하면 접근성에 대한 추가 정보가 포함된 툴팁이 제공됩니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/07/image-19.png?resize=1986%2C1404&ssl=1)

제가 이것이 큰 영향을 미칠 수 있는 이유는 DevTools가 오랫동안 접근성 기능을 가지고 있었기 때문입니다. 하지만 실제로 사용하는 사람은 얼마나 될까요? Inspect Element와 같이 일반적으로 사용되는 기능에 이 정보를 포함하면 훨씬 더 많은 가시성과 접근성을 얻을 수 있습니다.

도구 설명에는 다음이 포함됩니다.

- 텍스트의 대비 비율(전경 텍스트가 배경 색과 대비되는 수준 또는 불량)
- 텍스트 표현
- ARIA 역할
- 검사된 요소가 키보드 포커스가 가능한지 여부

이를 확인하려면 요소의 오른쪽 버튼(또는 `Cmd` + `Shift` + `C`)을 클릭하고 검사를 선택하여 DevTools에서 확인하십시오.

저는 Chrome DevTools를 사용한 Accessibility 디버깅에 대한 14분짜리 비디오를 만들었는데, 이 비디오 중 일부는 좀 더 자세히 다루고 있습니다.

### 시력결핍을 모방한다.

주석에 표시된 대로 Chrome DevTools를 사용하여 시력 장애를 에뮬레이트할 수 있습니다. 예를 들어, 우리는 시야가 흐릿한 렌즈를 통해 사이트를 볼 수 있습니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/07/image-20.png?resize=2196%2C1470&ssl=1)

DevTools에서 이 작업을 수행할 수 있는 방법은 무엇입니까? 다음과 같은 경우:

- DevTools를 엽니다(우클릭하여 "Inspect" 또는 "Cmd" + "Shift" + "C").
- DevTools Command 메뉴(Mac에서는 `Cmd` + `Shift` + `P`, Windows에서는 `Ctrl` + `Shift` + `P`)를 엽니다.
- Command 메뉴에서 Show Rendering(렌더 표시)
- 렌더링 창에서 결점을 선택합니다.

우리는 흐릿한 시야를 예로 들었지만, DevTools는 프로토노피아, 중수소안경, 트리타노피아, 그리고 무채색증을 포함한 다른 선택권을 가지고 있다.

이러한 성격의 툴과 마찬가지로 기존의 접근성 스킬을 보완하도록 설계되었습니다. 다시 말해, 이는 교육적인 것이 아니라 우리가 만든 디자인과 사용자 경험에 영향을 미칩니다.

다음은 저시력 접근성 및 에뮬레이션에 대한 몇 가지 추가 리소스입니다.

- 저시력자의 접근성 요구사항(W3C)
- 비전 결함을 모방하여 페이지 접근성 향상

### 성능 타이밍 가져오기

DevTools의 Performance Panel은 때때로 모양과 색상이 혼동되는 것처럼 보일 수 있습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/07/image-21.png?resize=2172%2C1456&ssl=1)

이 업데이트는 의미 있는 성능 메트릭스를 표면화하는 데 더 효과적이기 때문에 좋습니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/07/image-22.png?resize=2353%2C1637&ssl=1)

우리가 살펴보고자 하는 것은 성능 패널 기록의 "타이밍"에 표시된 추가 타이밍 직사각형입니다. 이 기능은 다음과 같습니다.

- DOM 컨텐츠 로드됨: 초기 HTML이 로드될 때 트리거되는 이벤트
- 첫 번째 그림판: 브라우저가 처음 화면에 픽셀을 그리는 경우
- 첫 번째 내용 그림판: 브라우저가 DOM에서 콘텐츠를 끌어와서 사용자에게 콘텐츠가 로드되고 있음을 나타내는 지점
- Onload: 페이지 및 모든 리소스 로드가 완료된 경우
- 가장 큰 내용물 도장: 뷰포트에 렌더링되는 가장 큰 이미지 또는 텍스트 요소

성능 패널 레코딩에서 가장 큰 내용 표시 그림판 이벤트를 찾은 경우 이 이벤트를 클릭하여 추가 정보를 얻을 수 있습니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/07/image-23.png?resize=1024%2C685&ssl=1)

여기에는 많은 황금 정보가 있지만, "관련 노드"는 LCP 이벤트에 기여한 요소를 정확하게 지정하기 때문에 잠재적으로 가장 유용한 항목이다.

이 기능을 사용해 보려면:

- DevTools를 열고 성능 패널로 이동합니다.
- 프로파일링 시작 및 페이지 다시 로드"를 누릅니다.
- 기록의 타이밍 섹션에서 타이밍 메트릭 관찰
- 개별 메트릭을 클릭하여 얻을 수 있는 추가 정보 확인

### 성능 모니터링

DevTools를 사용하여 성능을 신속하게 분석하고 이미 Lighthouse를 사용해 봤다면 Performance Monitor 기능을 사용하는 것이 좋습니다. 이는 WebPageTest.org이 CPU 사용량과 같은 기능을 바로 이용할 수 있는 것과 같습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/07/image-24.png?resize=2520%2C1620&ssl=1)

액세스 방법은 다음과 같습니다.

- DevTools 열기
- 명령 메뉴 열기(Mac에서는 `Cmd` + `Shift` + `P`, Windows에서는 `Ctrl` + `Shift` + `P`)
- 명령 메뉴에서 "성능 모니터 표시"를 선택합니다.
- 웹 사이트 상호 작용 및 탐색
- 결과를 관찰합니다.

Performance Monitor는 Lighthouse와 달리 흥미로운 측정 기준을 제공할 수 있습니다. Lighthouse를 해석하고 조치를 취하는 방법을 알아내는 것입니다. 제안이 제공되지 않습니다. CPU 사용량 차트를 살펴보고 90% 정도가 사이트에 적합한 수준인지(아마 그렇지 않은 경우) 물어보는 것은 사용자의 몫입니다.

성능 모니터에는 다음과 같은 메트릭을 켜거나 끌 수 있는 대화형 범례가 있습니다.

- CPU 사용량
- JS 힙 크기
- DOM 노드
- JS 이벤트 수신기
- 문서.
- 문서 프레임
- 레이아웃/초
- 스타일 재계산/초

### CSS 개요 및 로컬 재정의

CSS-Tricks는 이미 이러한 기능에 대해 다뤘으니, 가서 확인해 보세요!

- CSS 개요: 페이지에서 사용 중인 CSS에 여러 가지 흥미로운 통계를 제공하는 편리한 DevTools 패널
- 로컬 재정의: 운영 웹 사이트를 로컬 리소스로 재정의하여 변경사항을 쉽게 미리 볼 수 있는 강력한 기능

### 그렇다면, 다른 브라우저의 DevTool은 어떨까요?

제가 이 기사 내내 크롬을 사용하고 있다는 것을 눈치챘을 거예요. 제가 개인적으로 사용하는 브라우저입니다. 그렇긴 하지만 고려할 가치가 있습니다.

- Firefox DevTools는 현재 매우 좋아 보입니다.
- Microsoft Edge가 Chromium에서 확장됨에 따라 이러한 DevTools 기능을 활용할 수 있습니다.
- Safari Technology Preview 릴리스 노트(해당 페이지에서 Web Inspector 검색)에서 알 수 있듯이 Safari DevTools는 많은 성과를 거뒀습니다.

다시 말해서, 이곳은 빠르게 진화하는 공간이기 때문에 주목하세요!

### 결론

우리는 짧은 공간에서 많은 것을 커버했어요!

- 등대: 성능, 접근성, SEO 및 모범 사례에 대한 팁과 제안을 제공하는 패널.
- 요소 검사: Inspect Element 도구 설명에 대한 접근성 정보를 제공하는 Inspect Element 기능의 향상
- 시력 결핍을 에뮬레이트합니다. 낮은 시력의 렌즈를 통해 페이지를 보는 렌더링 창의 기능입니다.
- 성능 패널 타이밍: 성능 패널 기록의 추가 메트릭(최대 내용 그림판과 같은 사용자 지향 통계 표시)
- 성능 모니터 – CPU 사용량 및 DOM 크기 등 현재 웹 사이트의 성능 메트릭스를 실시간으로 시각화

최신 업데이트를 계속 준수하고 200개 이상의 웹 개발 팁을 받으려면 내 메일 목록인 Dev Tips를 확인하십시오! 또한 ModernDevTools.com에서 프리미엄 비디오 강좌를 수강하고 있습니다. 그리고 저는 트위터에 보너스 웹 개발 자료들을 많이 올리는 편입니다.