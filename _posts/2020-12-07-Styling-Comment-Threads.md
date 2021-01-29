---
layout: post
title: "주석 스레드 스타일 지정
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2019/02/chat-dialogue.png
tags: 
---


주석 스레드는 올바르게 실행될 때 정말 단순 해 보이는 것들 중 하나입니다.
 직접 디자인 할 때 상당히 단순하다는 것을 알 수 있습니다.
 멋지고 사용 가능한 댓글 스레드를 디자인하는 데는 많은 것들이 있으며,이 기사에서는보기에 좋은 댓글 스레드를 작성하는 단계, 사용하는 즐거움을 안내하기 위해 최선을 다할 것입니다.
 

### 좋은 댓글 스레드는 무엇입니까?
 

코드를 디자인하고 작성하기 전에 실제로 좋은 댓글 스레드를 만드는 요소를 분석해 보겠습니다.
 좋은 댓글 스레드에는 다음과 같은 특성이 있습니다.
 

- 주석을 읽을 수 있으며 모든 중요한 데이터 포인트를 사용자가 한 눈에 볼 수 있습니다.
 여기에는 작성자, 투표 수, 타임 스탬프 및 콘텐츠가 포함됩니다.
 
- 댓글의 다른 부분은 시각적으로 구별되므로 사용자는 무엇이 무엇인지 즉시 이해할 수 있습니다.
 이는 작업 버튼 (예 : 답장, 신고) 및 링크에 특히 중요합니다.
 
- 주석 사이의 계층 구조에 대한 시각적 단서가 있어야합니다.
 이것은 중첩 된 주석을 갖기위한 요구 사항입니다. 즉, 하나의 주석은 다른 주석에 대한 응답입니다.
 
- 댓글, 특히 하위의 상위 댓글 (예 : 답글)로 빠르게 스크롤 할 수있는 쉬운 방법이 있어야합니다.
 
- 댓글에는 사용자가 댓글과 답글을 숨기고 표시 할 수있는 토글 기능도 있어야합니다.
 

보시다시피 고려할 사항이 상당히 많습니다!
 또한이 기사에서 다루지 않을 몇 가지 유용한 기능이 있지만 확실히 좋은 개선 사항입니다.
 

- 사용자는 댓글에 플래그를 지정하여 운영자가 부적절한 콘텐츠를 인식 할 수 있어야합니다.
 
- 댓글은 유용하거나 도움이되지 않는 댓글을 표시하는 방법으로 찬성 또는 반대 투표를 할 수 있습니다.
 
- 처음 몇 개의 댓글 만 표시되며 사용자는 더 많은 댓글을로드 할 수 있습니다.
 

위의 기능을 사용하려면 최소한 약간의 JavaScript가 필요합니다.
 또한 기술 스택에 따라 이러한 기능은 특히 투표 수와 댓글의 플래그 상태를 추적하는 등 서버 측에서 구현 될 수 있습니다.
 이것이 우리가이 기사에서 주석 스레드의 스타일링에만 집중하는 이유입니다.
 이제 첫 번째 요점을 제거하고 댓글 스레드를 디자인 해 보겠습니다.
 

### 기본 댓글 스레드
 

주석 자체는 매우 간단한 구조를 가지고 있습니다.
 다음은 단일 댓글의 골격입니다.
 

여태까지는 그런대로 잘됐다.
 답글의 왼쪽에 여백이 어떻게 추가되는지 확인하십시오.
 이는 시각적 계층 구조를 충족하기위한 것입니다 (위의 3 번 지점).
 위 구조의 마크 업은 다음과 같습니다.
 

```html
<div class="comment">

  <!-- Comment heading start -->
  <div class="comment-heading">

    <!-- Comment voting start -->
    <div class="comment-voting">
      <button type="button">Vote up</button>
      <button type="button">Vote down</button>
    </div>
    <!-- Comment voting end -->

    <!-- Comment info (author, # of votes, time added) start -->
    <div class="comment-info">
      <a href="#" class="comment-author">{{ author }}</a>
      <p>
        {{ # of votes }} • {{ time_added }}
      </p>
    </div>
    <!-- Comment info (author, # of votes, time added) end -->
  </div>
  <!-- Comment heading end -->

  <!-- Comment body start -->
  <div class="comment-body">
    <p>
      {{ comment_content }}
    </p>
    <button type="button">Reply</button>
    <button type="button">Flag</button>
  </div>
  <!-- Comment body end -->

  <!-- Replies start -->
  <div class="replies">
    <!-- ... -->
  </div>
  <!-- Replies end -->

</div>
```

여기서는 설명 할 것이 없습니다. 단지 몇 가지 기본 요소가 포함 된 컨테이너입니다.
 대신 답글이있는 댓글과 함께 실제 사례를 살펴 보겠습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_wvzwLKM" src="//codepen.io/anon/embed/wvzwLKM?height=450&amp;theme-id=1&amp;slug-hash=wvzwLKM&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed wvzwLKM" title="CodePen Embed wvzwLKM" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

꽤 멋지죠?
 위의 예는 처음 세 점을 충족하므로 이미 진행 중입니다.
 위 코드에 대해 이해해야 할 몇 가지 사항 :
 

- 응답은 계층 구조의 시각적 단서를 제공하기 위해 왼쪽에 추가 여백이 제공됩니다.
 
- 찬성 및 반대 투표 버튼은 아이콘에 HTML 문자 코드를 사용합니다.
 
- `.sr-only` 클래스는 스크린 리더를 제외한 모든 기기의 요소를 숨 깁니다.
 이렇게하면 투표 버튼에 액세스 할 수 있습니다.
 Bootstrap 또는 Halfmoon과 같은 프레임 워크를 사용하는 경우이 클래스가 자동으로 압축됩니다.
 

### 댓글로 이동하는 링크 추가
 

이제 기본 댓글 스레드가 준비되었으므로 사용자가 댓글로 빠르게 스크롤 할 수있는 기능을 추가해 보겠습니다.
 위에서 언급했듯이 이것은 누군가가 답글의 상위 댓글로 이동하려고 할 때 특히 유용합니다.
 

이를 구축하려면 이러한 링크가 어떻게 생겼는지 결정해야합니다.
 이것은 전적으로 주관적이지만 제가 정말 좋아하는 특정 디자인 중 하나는 댓글 왼쪽에있는 클릭 가능한 "테두리"입니다.
 

링크를 수용하기 위해 댓글 본문을 오른쪽으로 밀고 답글과 정렬합니다.
 이 디자인은 또한 왼쪽의 테두리 링크 수를보고 현재 읽고있는 주석의 중첩 수준을 결정할 수 있기 때문에 주석 사이의 계층 구조를 강화하는 추가 이점이 있습니다.
 물론 테두리 링크를 클릭하여 상위 레벨로 즉시 이동할 수도 있습니다.
 

실제로 이러한 테두리 링크를 만들려면 각 주석 내부에 앵커 요소 (`<a href="...">`)를 추가하고 클릭 할 수있는 테두리처럼 보이도록 이러한 앵커 요소의 스타일을 지정해야합니다.
 위의 첫 번째 코드 예제에 추가해 보겠습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_qBaWzOJ" src="//codepen.io/anon/embed/qBaWzOJ?height=450&amp;theme-id=1&amp;slug-hash=qBaWzOJ&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed qBaWzOJ" title="CodePen Embed qBaWzOJ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

변경 사항에 대해 이해해야 할 몇 가지 사항은 다음과 같습니다.
 

- 앵커 링크는 각 주석 내부에 추가되며 왼쪽 테두리처럼 보이도록 스타일이 지정됩니다.
 
- 이제 댓글 본문이 답글과 정렬됩니다.
 
- `.comment-heading` (투표, 작성자 및 추가 된 시간 포함)은`50px`의 고정`높이`를 갖습니다.
 따라서 테두리 링크에`position : absolute`,`top : 50px` 및`height : calc (100 %-50px)`속성을 제공하여 제목 바로 아래에서 시작하여 모두 이동하도록합니다.
 댓글 끝까지 내려갑니다.
 `calc ()`함수에 익숙하지 않다면 Chris의 멋진 가이드를 읽을 수 있습니다.
 
- 테두리 링크는 잘린 배경을 가지고 있으며 왼쪽과 오른쪽에`border-width`의`border-width`와 함께`12px`의`width`가 제공됩니다.
 즉, 가시 영역의 너비는 `4px`에 불과하지만 실제 클릭 가능한 영역의 너비는 `12px`입니다.
 더 넓은 표면은 사용자가 실제로 포인터를 링크에 배치하고 클릭하는 데 도움이되는 것입니다.`4px`는 너무 좁지 만 더 넓은 것은 시각적으로 보이지 않기 때문입니다.
 

이 모든 것을 통해 위에서 언급 한 첫 번째 네 가지 요점을 제거했습니다.
 코드 예제에 주석을 더 추가하여 어떻게 보이는지 살펴 보겠습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_BaLBgjo" src="//codepen.io/anon/embed/BaLBgjo?height=450&amp;theme-id=1&amp;slug-hash=BaLBgjo&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed BaLBgjo" title="CodePen Embed BaLBgjo" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 사용자가 클릭 한 번으로 댓글을 숨기거나 표시하도록 허용
 

이 시점에서 꽤 만족스러운 댓글 스레드가 있습니다.
 이 디자인은 그 자체로 많은 실제 사용 사례에서 작동 할 수 있습니다.
 하지만 한 단계 더 나아가 토글 기능 (예 : 클릭 한 번으로 댓글 숨기기 및 표시)을 추가해 보겠습니다.
 

사용자가 클릭 한 번으로 댓글을 숨기고 표시 할 수있는 가장 빠르고 쉬운 방법은`<details>`및`<summary>`요소를 사용하는 것입니다.
 간단히 말해서`<summary>`를 클릭하여 전체`<details>`의 가시성을 전환 할 수 있습니다.
 관련된 자바 스크립트가 없으며이 태그는 현재 약 96 %의 브라우저에서 지원됩니다.
 다시 한 번, 이러한 개념에 익숙하지 않은 경우 Chris의 또 다른 기사에서 더 많은 것을 배울 수 있습니다.
 

어쨌든 이것을 실제로 구현하려면 코드를 다음과 같이 변경해야합니다.
 

- 주석을`<div>`에서`<details>`로 변경합니다. 즉,`.comment` 클래스가있는 모든 요소가 이제`<details>`요소가됩니다.
 
- 주석 제목 (`.comment-heading`)을`<summary>`태그 안에 넣습니다.
 
- 댓글이 숨겨져 있는지 여부를 알려주는 시각적 신호를 사용자에게 제공합니다.
 

충분히 쉬운 것 같습니다.
 어쨌든 새로운 구현은 다음과 같습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_VwKZJeN" src="//codepen.io/anon/embed/VwKZJeN?height=450&amp;theme-id=1&amp;slug-hash=VwKZJeN&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed VwKZJeN" title="CodePen Embed VwKZJeN" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

변경 사항에 대해 이해해야 할 마지막 사항은 다음과 같습니다.
 

- 주석은 이제`<details>`이며 모두`open` 속성이 주어 지므로 기본적으로 표시됩니다 (즉, open).
 
- 이제 댓글 제목이`<summary>`태그 안에 포함됩니다.
 기본 화살표도 제거됩니다.
 
- 댓글의 가시성 상태에 대한 신호는 주로 댓글 오른쪽에 작은 텍스트를 사용하여 생성됩니다.
 이 텍스트의 내용은 상위`<details>`요소에`open` 속성이 있는지 여부에 따라 변경됩니다.
 텍스트 자체는`:: after` 선택기를 사용하여 만든 간단한 의사 요소입니다.
 또한 닫힌 댓글에는 하단에 테두리가있어 사용자에게 볼 것이 더 있음을 보여줍니다.
 
- CSS 코드의 맨 끝에`@media 화면과 (-ms-high-contrast : active), (-ms-high-contrast : none) {...}`선택기에서 몇 가지 스타일을 찾을 수 있습니다.
 이것은 Internet Explorer만을 대상으로하는 해킹입니다.
 IE는`<details>`를 지원하지 않으므로 항상 기본적으로 열려 있습니다.
 텍스트를 제거하고 커서를 재설정하면 IE 사용자는 실제로 주석 가시성을 전환하는 기능없이 일반 주석 스레드를 볼 수 있습니다.
 그래서, 해롭지 않고, 파울도 없습니다.
 

### 명예로운 언급
 

이 기사를 끝내기 전에 실제 애플리케이션에서 주석 스레드를 설계 할 때 고려해야 할 몇 가지 사항에 대해 더 이야기 해 보겠습니다.
 

이것은 해결하기 매우 간단한 문제 일 수 있지만 이러한 단순한 문제를 간과하기 쉽습니다.
 댓글 스레드에 댓글이없는 경우 (빈 상태),이를 사용자에게 명확하게 전달해야합니다.
 "아직 주석이 없습니다."라는 줄이 포함 된 간단한 단락입니다.
 텍스트 상자와 제출 버튼이 포함 된 양식과 함께 매우 먼 길을 갈 수 있으며 빈 상태를 처리 할 때 최소한으로해야합니다.
 더 나아가고 싶다면 양식과 함께 멋진 이미지 (메시지를 전달하는)를 가질 수도 있습니다.
 

댓글에 응답하는 양식의 경우 웹 사이트마다 구현 방식이 다릅니다.
 일부는 제출 버튼이있는 간단한 텍스트 상자 인 양식이 포함 된 새 페이지로 사용자를 리디렉션하는 구식 방식을 사용합니다.
 다른 사람들은 일반적으로 간단한 토글을 사용하여 주석 스레드 자체에서 바로 양식을 엽니 다.
 후자의 패러다임에는 분명히 JavaScript가 필요하지만 요즘에는 더 인기가 있습니다.
 예를 들어, 위의 예에서 다음과 같이 Reply 버튼을 클릭하여 토글 할 수있는 간단한 양식을 가질 수 있습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_ZEpGXNb" src="//codepen.io/anon/embed/ZEpGXNb?height=450&amp;theme-id=1&amp;slug-hash=ZEpGXNb&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed ZEpGXNb" title="CodePen Embed ZEpGXNb" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

위의 예에서 우리는 주석 본문 안에 간단한 양식을 추가하고 기본적으로`.d-none` 클래스를 부여하여`display : none;`을 설정하고보기에서 숨 깁니다.
 간단한 이벤트 리스너 덕분에`data-toggle = "reply-form"`및`data-target = "{{comment_reply_form_id}}`속성이있는 모든 버튼을 클릭하여 양식의 가시성을 전환 할 수 있습니다.
 응답 양식을 쉽게 처리하는 매우 간단한 예입니다.
 

사용자가 위에 표시된 것과 유사한 양식을 사용하여 댓글에 응답한다고 가정 해 보겠습니다.
 기존 답글 위 또는 아래에 표시합니까?
 대답은 사용자가 처음으로 게시 한 직후 다른 답글 위에 항상 표시되어야한다는 것입니다.
 한 사람이 양식을 작성하고 제출할 때 즉시 피드백이 작동했음을 알리기를 원합니다.
 따라서 다른 응답 위에 새 응답을 배치하여 사용자가 아래로 스크롤 할 필요없이이 피드백을 제공합니다.
 이후로드시 웹 사이트에 적합한 알고리즘에 따라 댓글 응답을 정렬 할 수 있습니다.
 

많은 웹 사이트, 특히 개발자 블로그는 주석에서 마크 다운 및 코드 블록을 지원해야합니다.
 이것은 훨씬 더 큰 토론이며 아마도이 주제에 대한 전용 기사가 필요합니다.
 그러나이 기사에서는 텍스트 상자에 쉽게 첨부 할 수있는 Markdown 편집기가 많이 있다고 가정 해 보겠습니다.
 대부분은 JavaScript와 함께 작동하므로 예제에 통합하기가 매우 쉽습니다.
 그러한 플러그인 중 하나는 허용 MIT 라이센스가있는 markdown-it입니다.
 WYSIWYG 편집기를 살펴볼 수도 있는데, 이는 웹 댓글과 관련하여 매우 유사한 목적을 제공합니다.
 

사용자에게 입력을 제공 할 양식을 제공하면 스팸이 오는 것을 보장 할 수 있으므로 댓글 스레드를 작성할 때 해결해야 할 문제입니다.
 스팸을 줄이는 가장 좋은 방법은 Google의 reCAPTCHA와 같은 서비스를 사용하는 것입니다.
 예를 들어, 위의 예에서 reCAPTCHA 상자는 응답 양식의 제출 버튼 바로 아래에 배치 될 수 있습니다.
 이것은 우리 웹 사이트를 남용으로부터 보호합니다.
 

스팸을 방지하는 또 다른 방법은 인증 된 사용자 만 댓글을 게시하도록 허용하는 것입니다. 즉, 사용자가 댓글을 게시하려면 계정이 있어야하며 로그인해야합니다.
 모든 댓글은 분명히 계정에 연결되어 있으므로 운영자가 지속적으로 스팸 또는 적은 노력의 콘텐츠를 게시하는 사용자를 처리 할 수 있다는 이점이 있습니다.
 UI에서 처리하는 측면에서 가장 좋은 방법은 사용자가 로그인하지 않은 경우 회신 또는 댓글 게시 버튼을 클릭 할 때 로그인 페이지로 리디렉션하는 것입니다. 인증 프로세스를 완료하면 간단하게
 댓글 스레드로 다시 리디렉션하고 양식을 엽니 다.
 

그리고 우리는 끝났습니다!
 우리는 다섯 가지 요점을 모두 충족했으며, 댓글로 이동하고 각 댓글의 가시성을 토깅하는 것과 같은 몇 가지 멋진 기능과 함께 사용 성과 접근성이 뛰어난 멋진 댓글 스레드를 설계했습니다.
 또한 주석 스레드 내의 양식에 대해 이야기하고 실제 응용 프로그램에서 고려해야 할 다른 사항에 대해서도 논의했습니다.
 대부분의 댓글 스레드는 CSS (자바 스크립트 없음) 만 사용하여 작동하며 CSS가 실제로 얼마나 멀리 왔는지 보여줍니다.
 