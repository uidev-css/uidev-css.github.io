---
layout: post
title: "HTML 및 CSS가 포함 된 동적 크기의 고정 사이드 바
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/11/sticky-sidebar.png
tags: STICKY
---


스크롤 할 때 뷰포트에 고정되는 페이지 콘텐츠 (예 : 앵커로 이동 메뉴 또는 섹션 제목)를 만드는 것이 그 어느 때보 다 쉬워졌습니다.
 CSS 규칙 세트에`position : sticky`를 넣고 방향 오프셋 (예 :`top : 0`)을 설정하면 최소한의 노력으로 팀원을 감동시킬 준비가 된 것입니다.
 이 CSS-Tricks 기사를 확인하여 실제 멋진 고정 위치 사용 사례를 확인하십시오.
 

하지만 고정 위치 지정은 약간 까다로울 수 있습니다. 특히 높이와 스크롤 할 수없는 위치에 콘텐츠를 숨기는 위험한 상황의 경우에는 더욱 그렇습니다.
 무대를 설정하고 문제와 해결 방법을 보여 드리겠습니다.
 

저는 최근에 우리 모두에게 익숙한 데스크탑 레이아웃, 즉 옆에 사이드 바가있는 메인 콘텐츠 영역을 작업했습니다.
 이 특정 사이드 바에는 기본 콘텐츠와 관련된 작업 항목 및 필터가 포함되어 있습니다.
 페이지 섹션이 스크롤 될 때이 구성 요소는 뷰포트에 고정되어 있으며 상황에 따라 액세스 할 수 있습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 750px;"><iframe id="cp_embed_oNLZmvV" src="//codepen.io/anon/embed/oNLZmvV?height=750&amp;theme-id=1&amp;slug-hash=oNLZmvV&amp;default-tab=result" height="750" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed oNLZmvV" title="CodePen Embed oNLZmvV" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

레이아웃 스타일은 앞서 언급 한 것처럼 구현하기 쉬웠습니다.
 하지만 한 가지 문제가있었습니다. 구성 요소의 높이는 내용에 따라 달라집니다.
 나는 그것을`max-height`로 제한하고`overflow-y : auto`를 설정하여 구성 요소 콘텐츠를 스크롤 가능하게 만들 수 있습니다.
 이것은 내 노트북 화면과 일반적인 뷰포트 높이에서 잘 작동했지만 수직 공간이 적은 더 작은 뷰포트에서는 사이드 바의 높이가 뷰포트를 초과합니다.
 


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video controls="" src="https://css-tricks.com/wp-content/uploads/2020/11/sticky-sidebar-component-cutoff.mp4" name="fitvid0"></video>
</div>


그것이 문제가 된 곳입니다.
 

### 솔루션을 통해 생각
 

처음에는 미디어 쿼리에 도달하는 것을 고려했습니다.
 아마도 미디어 쿼리를 사용하여 고정 위치를 제거하고 구성 요소를 사이드 바 컨테이너의 상단에 상대적으로 배치 할 수 있습니다.
 이렇게하면 전체 콘텐츠에 대한 액세스 권한이 부여됩니다.
 그렇지 않으면 페이지를 스크롤 할 때 고정 구성 요소의 콘텐츠가 상위 섹션의 끝에 도달 할 때까지 뷰포트 하단에서 잘립니다.
 

그런 다음 끈적 끈적한 구성 요소의 높이가 동적이라는 것을 기억했습니다.
 

> 그런 일을 처리 할 미디어 쿼리에 어떤 마법의 가치를 사용할 수 있습니까?
 대신 페이지로드시 구성 요소가 뷰포트 경계를 넘어가는지 확인하는 JavaScript 함수를 작성할 수 있습니까?
 그런 다음 구성 요소의 높이를 업데이트 할 수 있습니다.
 

그것은 가능성이었습니다.
 

하지만 사용자가 창 크기를 조정하면 어떻게 될까요?
 크기 조정 이벤트 핸들러에서 동일한 기능을 사용해야합니까?
 옳지 않다고 생각합니다.
 이것을 구축하는 더 나은 방법이있을 것입니다.
 

밝혀졌고 작업을 완료하기 위해 CSS 속임수를 사용했습니다!
 

### 페이지 섹션 설정
 

메인 요소에`flex` 디스플레이로 시작했습니다.
 고정 된 데스크톱 너비의 사이드 바에`flex-basis` 값이 설정되었습니다.
 그런 다음 아티클 요소가 사용 가능한 나머지 수평 뷰포트 공간을 채웠습니다.
 

미디어 쿼리없이 더 작은 뷰포트를 위해 두 개의 컨테이너를 쌓을 수있는 방법이 궁금하다면 The Flexbox Holy Albatross 트릭을 확인하세요.
 

사이드 바에`align-self : start`를 추가하여 높이가 본문과 함께 늘어나지 않도록했습니다 (`stretch`가 기본값 임).
 이것은 내 위치 속성에 마법을 걸 수있는 능력을 부여했습니다.
 

```css
.sidebar {
  --offset: var(--space);
  /* ... */
  position: sticky;
  top: var(--offset);
}
```

확인해보세요!
 이 두 가지 CSS 속성을 사용하면 사이드 바 요소가 오프셋을 사용하여 뷰포트 상단에 고정되어 숨을 쉴 수있는 공간을 제공합니다.
 `top` 값은 범위가 지정된 CSS 사용자 정의 속성으로 설정됩니다.
 이제`--offset` 변수를 사이드 바 내의 모든 하위 요소에서 재사용 할 수 있습니다.
 이는 나중에 고정 사이드 바 구성 요소의 최대 높이를 설정할 때 유용합니다.
 

CodePen 데모에서`: root` 규칙 세트의 오프셋 값에 사용되는`--space` 변수를 포함하여 전역 CSS 변수 선언 목록을 찾을 수 있습니다.
 

### 끈적한 사이드 바
 

구성 요소 자체는 끈적 거리는 것이 아닙니다.
 사이드 바 자체입니다.
 일반적인 레이아웃과 위치는 일반적으로 부모가 처리해야합니다.
 이는 구성 요소에 더 많은 유연성을 제공하고 응용 프로그램의 다른 영역에서 사용하기 위해 더 모듈화됩니다.
 

이 구성 요소의 구조를 살펴 보겠습니다.
 데모에서는 레이아웃 스타일에 초점을 맞추기 위해 아래 장식 속성을 제거했습니다.
 

```css
.component {
  display: grid;
  grid-template-rows: auto 1fr auto;
}
 
.component .content {
  max-height: 500px;
  overflow-y: auto;
}
```

- 이 구성 요소는 CSS Grid와 1-Line Layouts의 팬케이크 스택 아이디어를 사용하여이 템플릿의 행을 구성합니다.
 머리글과 바닥 글 (`auto`)은 자식의 높이에 맞게 조정되고 내용 (`1fr` 또는 하나의 분수 단위)은 나머지 열린 수직 공간을 채 웁니다.
 
- 콘텐츠의 `최대 높이`는 더 큰 화면 크기에서 구성 요소의 성장을 제한합니다.
 구성 요소가 뷰포트 높이를 채우기 위해 늘어나는 것이 선호되는 경우에는 필요하지 않습니다.
 
- `overflow-y : auto`를 사용하면 필요한 경우 콘텐츠를 스크롤 할 수 있습니다.
 

요소가 사이드 바에서 사용되는 경우 뷰포트 높이를 초과하지 않도록 `최대 높이`가 필요합니다.
 이전에`.sidebar` 클래스로 범위가 지정된`--offset`은 고정 사이드 바의 상단 오프셋과 일치하는 요소 하단에 여백을 생성하기 위해 두 배가됩니다.
 

```css
.sidebar .component {
  max-height: calc(100vh - var(--offset) * 2);
}
```

이것으로이 끈끈한 사이드 바 구성 요소의 어셈블리를 마쳤습니다!
 일부 장식 스타일을 적용한 후이 프로토 타입은 테스트 및 검토 할 준비가되었습니다.
 시도 해봐!
 CodePen에서 데모를 열고 그리드 항목을 클릭하여 사이드 바에 추가합니다.
 브라우저 창 크기를 조정하여 메인 콘텐츠 섹션을 스크롤 할 때 뷰포트에서 구성 요소가 어떻게 구부러 지는지 확인합니다.
 

이 레이아웃은 데스크톱 브라우저에서 잘 작동 할 수 있지만 더 작은 기기 나 뷰포트 너비에 완전히 적합하지는 않습니다.
 그러나 여기에있는 코드는 UI에 개선 사항을 쉽게 추가 할 수있는 견고한 기반을 제공합니다.
 

한 가지 간단한 아이디어 : 버튼을 클릭하면 페이지를 사이드 바 콘텐츠로 이동시키는 뷰포트 창에 부착 할 수 있습니다.
 또 다른 아이디어 : 사이드 바를 화면 밖으로 숨길 수 있고 토글 버튼을 사용하여 왼쪽 또는 오른쪽에서 밀어 넣을 수 있습니다.
 반복 및 사용자 테스트는 이러한 경험을 올바른 방향으로 유도하는 데 도움이됩니다.
 