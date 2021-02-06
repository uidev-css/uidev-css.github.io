---
layout: post
title: "다음은 시도된 실제 디버깅 전략을 사용하여 이상한 버그를 해결한 방법입니다."
author: "CSS Dev"
thumbnail: "undefined"
tags: 
---


UI 관련 버그를 마지막으로 처리했을 때 몇 시간 동안 머리를 긁적이게 했던 것 기억하십니까? 문제가 무작위로 발생했거나 특정 환경(장치, OS, 브라우저, 사용자 작업)에서 발생했거나 프로젝트의 일부인 수많은 프런트엔드 기술 중 하나에 숨겨져 있었을까요?

나는 최근에 UI 버그가 얼마나 난해할 수 있는지 상기되었다. 최근에 뚜렷한 패턴이나 이유 없이 Safari 브라우저의 일부 SVG에 영향을 미치는 흥미로운 버그를 수정했습니다. 나는 무슨 일이 일어나고 있는지에 대한 단서를 얻기 위해 비슷한 문제를 찾아봤지만, 아무런 유용한 결과도 찾지 못했다. 장애물이 있었음에도 불구하고, 나는 그것을 간신히 고쳤다.

기사에서 다룰 몇 가지 유용한 디버깅 전략을 사용하여 문제를 분석했습니다. 수정안을 제출하고 나서, 얼마 전에 크리스가 트위터에 올린 조언이 생각났습니다.

…그리고 여기 있습니다.

### 여기에 문제가 있다.

제가 진행 중인 프로젝트에서 다음과 같은 버그를 발견했습니다. 이것은 생방송 사이트입니다.


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video controls="" src="https://css-tricks.com/wp-content/uploads/2020/08/safari-svg-bug.mov" name="fitvid0"></video>
</div>


당신이 직접 확인할 수 있도록 CodePen 예제를 만들어 문제를 입증했습니다. Safari에서 예제를 열면 로드 시 버튼이 예상대로 표시될 수 있습니다. 하지만 만약 우리가 처음 두 개의 큰 버튼을 클릭하면, 이 문제는 그것의 못생긴 머리를 뒤로 젖힌다.

브라우저 페인트 이벤트가 발생할 때마다 큰 버튼의 SVG가 잘못 렌더링됩니다. 그냥 끊길 뿐이죠. 로드 시 무작위로 발생할 수 있습니다. 화면의 크기가 조정될 때도 발생할 수 있습니다. 상황이 어떻든 간에, 그런 일은 일어나!

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/08/image-2.png?ssl=1)

제가 그 문제에 접근한 방법은 이렇습니다.

### 우선, 환경을 생각해 봅시다.

버그가 존재하는 환경과 조건을 이해하기 위해 프로젝트의 세부 사항을 검토하는 것은 항상 좋은 생각입니다.

- 이 특정 프로젝트는 React를 사용하지만 이 문서를 따르는 데 필요하지 않습니다.
- SVG는 React 구성 요소로 가져오며 웹 팩에 의해 HTML로 인라인됩니다.
- SVG는 설계 도구에서 내보냈으며 구문 오류가 없습니다.
- SVG는 스타일시트에서 일부 CSS를 적용하였다.
- 영향을 받는 SVG는 < HTML 요소 안에 위치합니다.
- 이 문제는 Safari에서만 발생합니다(버전 13에서 확인됨).

### 토끼굴을 따라 내려가다.

이 문제를 살펴보고 어떤 일이 일어나고 있는지 추측할 수 있는지 알아보자. 이런 벌레들은 난해해지고, 우리는 무슨 일이 일어나고 있는지 즉시 알 수 없을 것입니다. 첫 번째 시도에서 100% 정확할 필요는 없습니다. 단계별로 진행하여 가능한 원인을 좁히기 위해 테스트할 수 있는 가설을 세울 것이기 때문입니다.

### 가설 형성

처음에 이것은 CSS 문제처럼 보입니다. 일부 스타일은 SVG 그래픽의 레이아웃 또는 오버플로 속성을 깨는 호버 이벤트에 적용될 수 있습니다. 또한 Safari에서 페이지를 렌더링할 때마다 문제가 무작위로 발생하는 것처럼 보입니다(화면 크기 조정 시 페인트 이벤트, 호버, 클릭 등).

가장 간단하고 명확한 경로부터 시작해서 CSS가 문제의 원인이라고 가정해 봅시다. 예를 들어 Flex 레이아웃과 같은 특정 스타일이 SVG 요소에 적용될 때 Safari 브라우저에 SVG가 잘못 렌더링되도록 하는 버그가 있을 가능성을 고려할 수 있다.

그렇게 함으로써, 우리는 가설을 세웠다. 우리의 다음 단계는 그 가설을 확인하거나 반박할 수 있는 시험을 세우는 것이다. 각 테스트 결과는 버그에 대한 새로운 사실을 만들어내고 추가 가설을 세우는 데 도움을 줄 것이다.

### 문제 단순화

문제 단순화라는 디버깅 전략을 사용하여 문제를 정확히 찾아낼 것입니다. 코넬 대학의 CS 강의는 이 전략을 "버그와 관련이 없는 코드 부분을 점진적으로 제거하는 접근법"이라고 설명한다.

문제가 CSS 내에 있다고 가정하면 문제를 정확히 지적하거나 방정식에서 CSS를 제거하여 가능한 원인의 수와 문제의 복잡성을 줄일 수 있다.

우리의 가설을 확인해 보자. 브라우저가 아닌 모든 스타일시트를 일시적으로 제외하는 경우 문제가 발생하지 않아야 합니다. 나는 내 프로젝트에 다음 줄의 코드를 언급함으로써 그것을 내 소스 코드에서 했다.

```js
import 'css/app.css';
```

CSS를 포함하지 않고 이러한 요소를 시연하기 위해 편리한 CodePen 예제를 만들었습니다. React에서는 구성 요소로 SVG 그래픽을 가져오고 있으며 웹 팩을 사용하여 HTML로 인라인화됩니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 200px;"><iframe id="cp_embed_dyGrMbv" src="//codepen.io/anon/embed/dyGrMbv?height=200&amp;theme-id=1&amp;slug-hash=dyGrMbv&amp;default-tab=result" height="200" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed dyGrMbv" title="CodePen Embed dyGrMbv" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이 펜을 Safari에서 열고 버튼을 클릭해도 문제가 계속 발생하고 있습니다. 페이지가 로드될 때 계속 발생하지만 코드펜에서는 버튼을 클릭하여 강제로 페이지를 로드해야 합니다. 우리는 CSS가 범인이 아니라고 단정할 수 있지만, 다섯 개 중 두 개만 이 조건에서 파손되는 것을 볼 수도 있습니다. 이것을 명심하고 다음 가설로 넘어갑시다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/08/image-3-e1597165243918.png?resize=736%2C180&ssl=1)

### 문제 격리

우리의 다음 가설은 Safari가 HTML `<button> 요소 내에서 SVG를 렌더링할 때 버그가 발생한다는 것이다. 처음 두 버튼에서 문제가 발생했으므로 첫 번째 버튼을 분리하여 어떻게 되는지 보겠습니다.

Sarah Drasner는 고립의 중요성을 설명하고 디버깅 툴과 다른 접근 방식에 대해 자세히 알고 싶다면 그녀의 기사를 읽는 것을 적극 추천한다.

> 분리는 모든 디버깅에서 가장 강력한 핵심 개념일 수 있습니다. 우리의 코드베이스는 다양한 라이브러리, 프레임워크로 확장될 수 있으며, 여기에는 많은 기여자들, 심지어 더 이상 프로젝트를 진행하지 않는 사람들도 포함될 수 있습니다. 문제를 분리하는 것은 문제의 중요하지 않은 부분을 천천히 소거하여 우리가 특별히 해결책에 집중할 수 있도록 도와준다.

종종 "축소된 테스트 사례"라고도 합니다.

이 버튼을 별도의 빈 테스트 경로(빈 페이지)로 이동했습니다. 저는 그 상태를 보여주기 위해 다음과 같은 코드펜을 만들었습니다. 비록 CSS가 문제의 원인이 아니라고 결론지었지만, 버그의 진짜 원인을 알아낼 때까지 제외를 해야 문제를 간단하게 해결할 수 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 200px;"><iframe id="cp_embed_XWXGKPY" src="//codepen.io/anon/embed/XWXGKPY?height=200&amp;theme-id=1&amp;slug-hash=XWXGKPY&amp;default-tab=result" height="200" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed XWXGKPY" title="CodePen Embed XWXGKPY" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

Safari에서 이 펜을 열면 더 이상 문제를 재현할 수 없고 버튼을 클릭하면 예상대로 SVG 그래픽이 표시됩니다. 우리는 이 변화를 받아들일 수 있는 버그 수정으로 간주해서는 안 되지만, 이것은 최소한의 재현 가능한 예를 만드는 데 좋은 출발점을 제공한다.

### 최소 재현 가능한 예제

앞의 두 예와의 주요 차이점은 버튼 조합입니다. 가능한 모든 조합을 시도한 후 동일한 페이지의 작은 SVG 그래픽과 나란히 있는 더 큰 SVG 그래픽에서 페인트 이벤트가 발생할 때만 이 문제가 발생한다는 결론을 내릴 수 있습니다.

불필요한 요소 없이 버그를 재현할 수 있는 최소한의 재현 가능한 예를 만들었다. 최소 재현 가능한 예제를 사용하여 문제를 보다 자세히 연구하고 문제의 원인이 되는 코드 부분을 정확하게 찾아낼 수 있다.

최소 재현 가능한 예를 보여드리기 위해 다음 코드펜을 만들었습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 200px;"><iframe id="cp_embed_OJMGVmE" src="//codepen.io/anon/embed/OJMGVmE?height=200&amp;theme-id=1&amp;slug-hash=OJMGVmE&amp;default-tab=result" height="200" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed OJMGVmE" title="CodePen Embed OJMGVmE" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

Safari에서 이 데모를 열고 버튼을 클릭하면 이 두 SVG가 서로 충돌한다는 가설을 세울 수 있습니다. 첫 번째 SVG 그래픽 위에 두 번째 SVG 그래픽을 오버레이하면 첫 번째 SVG 그래픽에 있는 잘린 원의 크기가 더 작은 SVG 그래픽의 정확한 치수와 일치한다는 것을 알 수 있다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/08/iNLqCBSg.png?resize=320%2C271&ssl=1)

### 분열시켜 정복하다.

우리는 이 문제를 두 개의 SVG 그래픽의 조합으로 좁혔습니다. 이제 우리는 일을 망치고 있는 구체적인 SVG 코드로 범위를 좁힐 것입니다. SVG 코드에 대한 기본적인 이해만 하고 문제를 정확히 파악하려면 분할 및 정복 접근 방식으로 이진 트리 검색 전략을 사용할 수 있다. 코넬 대학교의 CS 강의에서는 다음과 같은 접근 방식을 설명합니다.

> 예를 들어, 큰 코드 조각에서 시작하여 코드 중간에 체크 표시를 합니다. 만약 오류가 그 지점에 나타나지 않는다면, 그것은 버그가 후반기에 발생한다는 것을 의미하고, 그렇지 않으면 전반부에 발생한다는 것을 의미한다.

SVG에서는 첫 번째 SVG에서 <필터>(그리고 <디프>도 삭제해 볼 수 있다. 먼저 `필터`가 무엇을 하는지 확인해 보겠습니다. Sara Soueidan의 이 기사가 가장 잘 설명해준다.

> SVG의 선형 그레이디언트, 마스크, 패턴 및 기타 그래픽 효과와 마찬가지로 필터도 편리한 이름의 전용 요소인 '<필터> 요소를 가지고 있다.
<필터> 요소는 직접 렌더링되지 않으며, SVG의 '필터' 속성 또는 CSS의 'url()' 함수를 사용하여 참조할 수 있는 것으로만 사용됩니다.

우리의 SVG에서 <필터>는 SVG 그래픽의 하단에 약간의 삽입 그림자를 적용한다. 첫 번째 SVG 그래픽에서 삭제하고 나면 내부 그림자가 사라질 것으로 예상됩니다. 이 문제가 지속되면, 우리는 SVG의 나머지 마크업에도 문제가 있다고 결론 내릴 수 있다.

이 테스트를 보여주기 위해 다음과 같은 코드펜을 만들었습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 200px;"><iframe id="cp_embed_rNxbVrx" src="//codepen.io/anon/embed/rNxbVrx?height=200&amp;theme-id=1&amp;slug-hash=rNxbVrx&amp;default-tab=result" height="200" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed rNxbVrx" title="CodePen Embed rNxbVrx" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

우리가 볼 수 있듯이, 그 문제는 어쨌든 지속된다. 코드를 제거했는데도 삽입된 하단 그림자가 표시됩니다. 뿐만 아니라 모든 브라우저에 버그가 나타납니다. 우리는 그 문제가 SVG 코드의 나머지 부분에 있다고 결론 내릴 수 있다. =g filter="url(#filter0_ii)"에서 나머지 id를 삭제하면 그림자가 완전히 제거됩니다. 무슨 일이야?

앞에서 언급한 `필터` 속성의 정의를 다시 한 번 살펴보고 다음 세부 사항을 살펴보도록 하겠습니다.

> <필터> 요소는 직접 렌더링되지 않으며, 유일한 용도는 SVG에서 '필터' 특성을 사용하여 참조할 수 있는 것으로만 사용됩니다.

(내 것을 강조함)

따라서 두 번째 SVG 그래픽의 필터 정의가 첫 번째 SVG 그래픽에 적용되어 오류가 발생한다는 결론을 내릴 수 있습니다.

## 문제 해결

우리는 이제 그 문제가 `필터` 속성과 관련이 있다는 것을 안다. 우리는 또한 두 SVG가 모두 필터 속성을 가지고 있다는 것을 안다. 왜냐하면 그들은 그것을 원 모양의 삽입된 그림자에 사용하기 때문이다. 두 SVG 간의 코드를 비교하여 문제를 설명하고 해결할 수 있는지 알아보겠습니다.

두 가지 SVG 그래픽의 코드를 단순화하여 상황을 명확하게 확인할 수 있도록 했습니다. 다음 조각은 첫 번째 SVG의 코드를 보여준다.

```svg
<svg width="46" height="46" viewBox="0 0 46 46">
  <g filter="url(#filter0_ii)">
    <!-- ... -->
  </g>
  <!-- ... -->
  <defs>
    <filter id="filter0_ii" x="0" y="0" width="46" height="46">
      <!-- ... -->
    </filter>
  </defs>
</svg>
```

그리고 다음 조각은 두 번째 SVG 그래픽의 코드를 보여준다.

```svg
<svg width="28" height="28" viewBox="0 0 28 28">
  <g filter="url(#filter0_ii)">
    <!-- ... -->
  </g>
  <!-- ... -->
  <defs>
    <filter id="filter0_ii" x="0" y="0" width="28" height="28">
      <!-- ... -->
    </filter>
  </defs>
</svg>
```

생성된 SVG는 동일한 id 속성 `id=filter0_ii`를 사용한다는 것을 알 수 있다. Safari는 마지막으로 읽은 필터 정의(우리의 경우 두 번째 SVG 마크업)를 적용했으며, 첫 번째 SVG가 두 번째 필터 크기(46px ~ 28px)로 잘려나갔다. ID 속성은 DOM에서 고유한 값을 가져야 합니다. 페이지에 둘 이상의 id 속성을 가지면 브라우저는 어떤 참조를 적용해야 하는지 이해할 수 없고, 필터 속성은 문제가 무작위로 나타나는 레이싱 조건에 따라 각 페인트 이벤트에서 재정의된다.

각 SVG 그래픽에 고유한 `id` 속성 값을 할당하여 문제가 해결되는지 확인해 보겠습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 200px;"><iframe id="cp_embed_MWKRwdK" src="//codepen.io/anon/embed/MWKRwdK?height=200&amp;theme-id=1&amp;slug-hash=MWKRwdK&amp;default-tab=result" height="200" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed MWKRwdK" title="CodePen Embed MWKRwdK" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

Safari에서 코드펜 예제를 열고 버튼을 클릭하면 각 SVG 그래픽 파일의 `<filter>` 속성에 고유 ID를 할당하여 문제를 해결했음을 알 수 있습니다. 우리가 id와 같은 속성에 대한 고유한 값을 가지고 있지 않다는 사실을 생각한다면, 그것은 이 문제가 모든 브라우저에 존재해야 한다는 것을 의미한다. 어떤 이유로, 크롬과 파이어폭스를 포함한 다른 브라우저들은 버그 없이 이 에지 케이스를 처리하는 것처럼 보이지만, 이것은 단지 우연일 수도 있다.

### 마무리하기

그거 정말 놀이기구였어! 우리는 겉으로 보기엔 닥치는 대로 생긴 문제에 대해 거의 아무것도 알지 못하기 시작했습니다. 완전히 이해하고 바로잡기 위해서였죠. 문제의 원인이 명확하지 않거나 난해한 경우 UI 디버깅과 시각적 버그 이해가 어려울 수 있다. 다행히도 유용한 디버깅 전략이 도움이 될 수 있습니다.

첫째, 우리는 문제와 무관한 구성요소(스타일, 마크업, 동적 이벤트 등)를 제거하는 데 도움이 되는 가설을 형성하여 문제를 단순화했다. 그 후, 우리는 마크업을 분리하여 단일 코드 청크에 집중할 수 있는 최소 재현 가능한 예를 발견했다. 마지막으로, 우리는 분할 및 정복 전략으로 문제를 정확히 파악하여 수정했습니다.

시간을 내어 이 기사를 읽어주셔서 감사합니다. 가기 전에, 코넬 대학의 CS 강의에 소개된 마지막 디버깅 전략을 하나 남겨두고 싶습니다.

잠시 휴식을 취하고 긴장을 풀고 디버깅 시도 사이에 마음을 비우는 것을 기억하라.

> 버그에 너무 많은 시간이 걸리면 프로그래머는 지치게 되고 디버깅은 역효과가 날 수 있다. 휴식을 취하고, 마음을 비우고, 휴식을 취한 후, 다른 관점에서 문제에 대해 생각하도록 노력하세요.

- 코넬 대학교 CS 312 강의 26 – 디버깅 기법
- 디버깅 팁 및 요령
- 테스트 사례 감소
- SVG 필터 101