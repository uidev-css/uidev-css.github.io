---
layout: post
title: "응답성 설계를 위한 브라우저 비교"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/08/Screen-Shot-2020-08-26-at-11.16.23-AM.png
tags: BROWSER,BROWSER EXTENSION,DEVTOOLS,LIVERELOAD,RESPONSIVE
---


여러 데스크톱 앱 중에서 여러 차원으로 동시에 사이트를 표시하는 것이 목표입니다. 예를 들어, CSS를 작성하여 모든 보기 포트에서 한눈에 작동하는지 확인할 수 있습니다.

그들은 모두 매우 비슷하다. 예를 들어, 한 창이나 장치에서 스크롤하면 다른 모든 창도 클릭, 입력 등과 함께 "이벤트 미러링"을 수행합니다. 또한 축소된 여러 장치를 한 번에 볼 수 있도록 확대/축소할 수도 있습니다. 우리가 어떤 차이점들을 뿌리뽑을 수 있는지 봅시다.

### 시지

- Windows, Mac 및 Linux
- "Solo" 계획은 매달 5달러부터 시작되며, 그 이후 계획이 수립됩니다.


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video controls="" src="https://css-tricks.com/wp-content/uploads/2020/08/universal-inspect-010.mp4" name="fitvid0"></video>
</div>


다음과 같은 개발자 중심의 멋진 기능이 많이 있습니다.

- 포트 번호를 입력하기만 하면 포트 제거
- 범용 검사 모드가 있지만 모든 창과 장치에 동시에 영향을 미치는 DevTools 변경 사항을 적용할 수는 없지만 적어도 모든 창에서 검사할 수 있으며 이 모드를 클릭하면 올바른 DevTools 세션이 활성화됩니다.
- 클릭 한 번으로 조정 또는 오프라인으로 전환
- 클릭 한 번으로 JavaScript 끄기
- 클릭 한 번으로 설계 모드를 설정합니다(예: 모든 요소에 `내용 가능한` 요소가 있음).
- 이미지 숨기기, 모든 스타일 끄기, 모든 요소 개요 등을 위해 전환합니다.
- Google 글꼴 선택으로 글꼴 재정의

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/08/Screen-Shot-2020-08-19-at-7.45.40-AM.png?resize=1024%2C703&ssl=1)

### 응답성 앱

- Windows, Mac 및 Linux
- 오픈 소스(무료)


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video controls="" src="https://css-tricks.com/wp-content/uploads/2020/08/customizable-layouts.mp4" name="fitvid1"></video>
</div>


- 올바른 DevTools 컨텍스트를 선택하는 범용 검사 모드
- 로컬 HTTPS에 문제가 발생할 경우 "SSL 유효성 검사 사용 안 함" 옵션이 현명합니다.
- 클릭 한 번으로 다크 모드 전환

### 블리스크

- 윈도 및 맥
- 무료, 프리미엄 업그레이드(월 10달러) 제공 스크롤 동기화 및 자동 새로 고침과 같은 일부 기능은 프리미엄 기능으로 나열되어 있습니다. 이는 무료 버전이 어떤 식으로든 이러한 기능을 제한한다는 것을 의미합니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/08/Screen-Shot-2020-08-26-at-10.59.53-AM.png?resize=1024%2C599&ssl=1)

- 자동 새로 고침은 멋진 생각입니다. 특정 폴더에 있는 특정 파일 형식에 대해 "감시자"를 설정한 후 변경되면 페이지가 새로 고쳐집니다. 대부분의 개발 환경은 일종의 스타일 주입 또는 핫 모듈 재로드가 있다고 생각하지만, 그래도 사용할 수 있는 환경은 그렇지 않은 환경에 유용합니다.
- 범용 DevTools 검사기는 없지만 DevTools를 개별적으로 열 수 있으며 요소의 박스 모델 치수를 표시하는 사용자 지정 범용 검사 도구가 있습니다.
- 사용자 정의 오류 보고서 화면이 있습니다.
- "브라우징 모드"를 사용하면 모든 고급 장치 항목을 끄고 반정규 브라우저로 사용할 수 있습니다.

### 폴리페인

- Windows, Mac 및 Linux
- 무료, 월 10달러부터 시작할 수 있는 프리미엄 요금제입니다. 등록하면 일주일 동안 많은 양의 온보드 전자 메일을 받을 수 있습니다(선택 사항 포함).


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video controls="" src="https://css-tricks.com/wp-content/uploads/2020/08/intro-polypane.mp4" name="fitvid2"></video>
</div>


- 현재 탭을 Polypane에 팝업하기 위해 다른 브라우저에 대한 브라우저 확장 기능이 있습니다.
- 범용 검사 모드는 여러 번 중에서 가장 원활해 보이지만, 지금까지 변경 내용이 창과 장치에 전파되지는 않았습니다. 누군가 이걸 해야 해! 라이브 CSS 창은 열려 있는 모든 장치에 추가 CSS를 주입하지만 멋집니다.
- CSS의 중단점을 기반으로 장치를 열 수 있으며 실제로 작동합니다!

### 듀오

- 5달러에 맥 앱스토어에 있지만, 웹사이트가 오프라인 상태여서 죽은 것 같아요.
- 그것은 전혀 멋지지 않은 특징을 가지고 있다. 이름에서 알 수 있듯이 크기가 조정될 수 있는 두 열에 동일한 사이트가 나란히 표시됩니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/08/Screen-Shot-2020-08-26-at-11.11.09-AM.png?resize=1024%2C617&ssl=1)

### 리:뷰

- 별도의 브라우저 앱이 아니라 브라우저 확장입니다. 저는 이것이 마음에 들어요. 제가 이미 익숙한 표준 브라우저에 머물 수 있기 때문에 말이죠. 정기적으로 업데이트를 받고 있어요.
- "중단점" 관점은 현명한 생각이다. 당신의 CSS의 중단점에 당신의 사이트를 보여줘야 한다고 믿는데, 제가 보기에는 고장이 난 것 같습니다. 이것이 현재 개발 중인 프로젝트인지 잘 모르겠습니다. (내 생각엔 아닌 것 같아.)

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/08/Screen-Shot-2020-08-26-at-11.16.23-AM.png?resize=1024%2C638&ssl=1)

### 그래요?

뭐, 우승자를 뽑으라는 거야?

폴리패인의 후프 점프와 보딩이 조금 꺼졌지만, 가장 잘 고려된 기능 세트가 있는 것 같다. Sizzy는 가깝지만 인터페이스는 필요 없어 보이는 방식으로 더 어수선하다. 저는 블리스크가 "모바일 뷰만 보고 나머지는 더 큰 뷰로 채울 것"에 초점을 맞추고 있다는 것을 인정합니다. 왜냐하면 제가 실제로 일하는 방식에 더 가깝기 때문입니다. (사소한 다른 모바일 스크린의 "장치 벽"을 볼 필요가 거의 없습니다.)

Responsibly가 자유롭고 오픈 소스라는 사실은 매우 멋집니다. 하지만 그것이 지속 가능한 것일까요? 비즈니스로 운영되는 앱을 파고드는 것이 더 안전하다고 생각합니다. Re: 일반 브라우저에만 있는 사실:뷰는 실제로 사용할 가능성이 가장 높다는 것을 의미하지만, 지금은 죽은 프로젝트처럼 느껴져서 아마 사용하지 않을 것입니다. 그래서 지금은 폴리페인을 왕좌에 앉혀야 할 것 같아요.