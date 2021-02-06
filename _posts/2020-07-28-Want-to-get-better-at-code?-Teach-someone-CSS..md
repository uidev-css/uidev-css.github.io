---
layout: post
title: "코드를 더 잘하고 싶나요? 누군가에게 CSS를 가르쳐라."
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/07/teach-css-experiment.png
tags: LEARNING
---


내 친구가 최근에 그녀에게 코드를 가르쳐달라고 부탁했어. 그녀는 코딩이 실제로 무엇을 의미하는지 전혀 모르는 완벽한 초보자였다. 나는 HTML과 CSS를 시작하기로 결심했다. 코드펜을 사용해서 펜들을 위조하고 변형시키기 시작했죠. 곧, 배움의 길이 풀리기 시작했습니다.

이 글의 목적은 기본 CSS를 이미 알고 있는 사람들에게 가르치는 것이 아니라, 새로운 사람에게 영감을 준 것들을 강조하고 기회가 생긴다면 다른 사람들에게 지식을 전달하도록 영감을 주는 것이다. 누군가를 도와준다는 것은 기분 좋은 일이었고, 결국, 저는 제 코드에 대해 생각하는 방식을 바꾼 몇 가지 정말 가치 있는 교훈을 배웠습니다. 이겨라!

자, 여기 있습니다. 제가 누군가에게 CSS를 가르치면서 배운 다섯 가지 교훈입니다.

### 제1장: 처음부터 다시 시작하지 마십시오.

12년 전 웹 코딩을 시작했을 때, 저는 플로트, 여백, 패딩 및 위치 선언을 이용한 배치부터 시작했습니다. 요즘 시대에 뒤떨어진 것처럼 보일 수도 있지만, 그래도 여기가 바로 새로운 코딩 친구와 함께 갔던 곳이에요.

그렇게 잘 되진 않았어요.

짐작하시겠지만, "여기 빈 상자를 화면 가운데에 놓는 방법이 있습니다" 같은 것으로 시작한 것은 실수였습니다. 정말 재미없어! Flexbox가 화면 중앙에 요소를 배치하는 방법에 대해 설명할 수 있는 저만의 능력에 깊은 인상을 받았음에도 불구하고, 저는 즉시 많은 추가적인 위치 비지정 질문에 직면하게 되었습니다.

"그래서 색을 어떻게 바꾸나요?"

"지나가면 모양이 바뀔 수 있나요?"

"웹에서 사용할 수 있는 글꼴은 무엇입니까?"

난 우리가 그 모든 것들로부터 몇 주 떨어져 있는 줄 알았어.

그래서, 12단 격자망을 가르치려는 제 계획은 창 밖으로 나갔고, 우리는 크리스의 이름이 붙은 색 차트를 포크 펜 몇 개 옆에 놓고 장난치기 시작했습니다. 우선 캐시디 윌리엄스 넷플릭스/넷라이프 로고의 색상을 변경했습니다. 와! 순간 적중.

```html
<a class="container" href="https://netlify.com" target="_blank"> 
  <div class="logo">
    <div class="uno"></div>
    <div class="dos"></div>
    <div class="tres"></div>
  </div>
  <div class="name">Prettier</div>
</a>
```

그런 다음 몇 가지 간단한 CSS 수정:

```css
body {
  background: #F9F2DB;
  color: #092935;
  font-size: 50px;
}
 
a {
  color: #092935;
}
 
.logo .uno, .dos, .tres {
  background: #C61561;
}

.logo .dos {
  box-shadow: 0 0 20px #F9F2DB;
}

.logo::before {
  background: #F9F2DB;
}
 
.name {
  letter-spacing: 8px;
}
```

몇 분 안에, 내 친구는 푹 빠졌어요! 걱정해야 할 지루한 위치는 없었습니다. 단지 몇 줄의 간단한 코드들이 어떻게 그렇게 익숙한 것을 완전히 다른 것으로 바꿀 수 있는지에 대한 명확한 예일 뿐입니다.

그리고 나서 여러분은 어떤 것이든 색깔을 바꿀 수 있다는 것을 알게 되었어요! 우리는 브라우저에 몇 개의 잘 알려진 사이트를 로드하고 DevTools로 텍스트와 배경의 색을 변경했습니다. 모두 몇 분만에 말이죠. 임무 완수! 내 친구는 매력에 빠졌다.

배운 교훈: 처음부터 무언가를 만들려고 하는 것에 대해 걱정하지 마세요. 이미 있는 것을 가지고 놀아라!

### 제2장: 코멘트

원래 예정했던 수업은 여기가 아닌데 왜 CSS의 일부가 /*로 시작해서 */로 끝나는지에 대한 의문이 생겨 그대로 진행하게 되었습니다.

이건 정말 내 일에 대해 생각해보게 했어. 나는 정말로 내 코드를 충분히 언급하지 않는다. 새로운 코더가 모든 것을 논평하는 것을 보면서 (그리고 나는 모든 것을 의미한다) 코멘트가 여러분 자신뿐만 아니라 더 넓은 팀, 혹은 심지어 미래의 여러분에게 얼마나 도움이 되는지 상기시켜 주었다. (사라 드라스너는 이 주제에 대해 훌륭한 이야기를 한다.)

여기 중요한 것이 있습니다. 그때까지, 저는 제가 꽤 부지런히 논평을 하고 있다고 생각했습니다. 하지만, 다른 사람이 하는 것을 보면서 내가 얼마나 많은 코드(특히 자바스크립트)를 보고 있는지 알게 되었고, 내가 하고 있는 일을 상기시키기 위해 한두 줄을 그 안에 넣었더라면 하는 생각을 하게 되었다. 10초짜리 작업으로 인해 5분 정도 더 걸릴 수도 있습니다. 그것은 더해져 이제 내가 하고 있는 일이 되었다.

배운 교훈: 댓글 더 달아주세요.

### 제3장: 포지셔닝

우리는 기본적인 HTML로 시작했는데, 솔직히, 나는 거의 즉시 내 친구의 눈이 휘둥그레져 있는 것을 보았다. 미리 작성된 CSS 편집과 달리 당장 아무것도 할 수 없을 때 너무 지루해 보입니다. 하지만, 우리는 그것을 고수했고, 결과를 얻었습니다.

1픽셀 테두리가 있는 빈 < 요소를 배치하는 것으로 시작하지 마십시오. 당신은 청중을 매우 빨리 잃게 될 것이다. 강아지의 사진이나 아기 요다나 피자가 비어있는 원소가 아닌 다른 어떤 것이라도 거기에 넣어주세요.

그리고 나서 우리는 Flexbox로 눈을 돌렸다. 우리는 사실 처음에 CSS Grid를 너무 많이 발견했습니다. 우리는 CSS 그리드를 잠깐 살펴보았지만, 그것에 관한 많은 기사를 읽을 때, 많은 사람들이 독자가 이미 CSS, 특히 Flexbox에 익숙하다고 추측한다. 내 친구는 플렉스박스부터 시작하기로 했다.

제가 인정하는 부분: 저는 UI 프레임워크(특히 부트스트랩)를 사용하는 데 너무 익숙해서 직접 CSS를 작성함으로써 Flexbox에 어떤 것도 배치하는 일은 거의 없습니다. 어떻게 작동하는지 알고 있고 (대부분) 선언문도 알고 있지만, 비교적 쉬울 것 같은 상황에서도 여전히 직접 쓰는 일은 거의 없다. 가르침을 통해 UI 프레임워크에 대한 의존도를 전반적으로 생각해 볼 수 있었습니다. 그렇다, 그들은 의심할 여지 없이 놀랍고 우리의 프로젝트에 많은 시간을 절약한다. 하지만 나는 Bootboot를 근본적으로 두 페이지였고 아마도 그것이 필요하지 않았을지도 모르는 최근의 프로젝트에 사용했다고 회상했다.

배운 교훈: 만약 프로젝트가 최소한의 요소만 배치하는 작은 것이라면, 프레임워크와 코드를 처음부터 버리는 것을 고려해보세요! 최종 결과는 가볍고, 빠르고, 훨씬 더 만족스러울 것입니다!

### 제4장: 타이포그래피

나는 타이포그래피를 좋아한다. 지난 몇 년 동안 저는 운이 좋게도 훌륭한 디자이너들과 함께 일해왔으며, 그것이 제가 타입의 뉘앙스를 알아보는 데 도움을 주었습니다. 선 높이와 문자 간격과 같은 것에 대한 변화가 디자인을 평균에서 놀라운 수준으로 끌어올리는 데 얼마나 도움이 되는지 놀랍습니다. 이것은 내가 열심인 새 학생에게 깊은 인상을 주고 싶은 것이다. 글쎄요, 제가 신경 쓸 필요는 없었는데요, 처음에는 관심 있는 게 글꼴을 바꾸는 거였어요. 그리고 결정적으로 저는 우리가 사용할 수 있는 글꼴의 수가 엄청나게 많았거든요. 선택의 폭은 거의 없으며 웹 글꼴을 제공하는 서비스와 주조 공장은 지난 몇 년 동안 부하 시간에 거의 영향을 미치지 않으면서 모든 것이 가능한 속도로 폭발적으로 증가했습니다.

하지만 여기 디자이너(그리고 저와 같은 프런트 엔드 개발자들)에 관한 것이 있습니다: 우리는 글꼴 선택에 있어서 약간 편협할 수 있습니다. 디자인은 구현하기 쉽고 작동한다는 것을 알기 때문에 동일한 서비스(Roboto와 Open Sans 누구라도?)의 동일한 글꼴을 고수하는 경향이 있다. 무역에 처음 접하는 사람과 글꼴을 탐색하는 것은 오래된 스테이플을 넘어서서 몇 가지 새로운 것을 시도해야만 했습니다. 이제 함께 작동하는 새로운 페어링을 찾고 있습니다. 이 페어링이 화면 상에서 작동하는 방식과 디자인의 전체적인 모양과 느낌에 영향을 미치는 방식에 대해 알아보겠습니다. 요컨대, 다른 사람에게 타입에 대해 가르친다는 것은 아마도 2017년 같은 것에 갇혀있던 타입으로 제 자신의 여정을 개선시켜 주었습니다.

배운 교훈: 유형을 최신으로 유지합니다.

### 제5장:후버(hover)는 모든 것을 재미있게 한다.

이 시점까지는 모든 것이 잘 되어가고 있었지만, 아마 여러분이 상상할 수 있듯이, 상황은 여전히 꽤 정적이었습니다. 실제로 계획을 세우지 않고, 우리는 요소에 호버 효과를 더하기 시작했는데, 그것은 마치 그것이 처음으로 색을 바꾸는 것처럼 즉각적인 후크였다!

후버는 상호작용을 더하고 쉽게 감동을 주므로 신인이 함께 놀기에 좋다. 객체 크기 조정, 사각에서 원형으로 상자 변경, 콘텐츠 숨기기 등 모든 작업을 쉽게 수행할 수 있으므로 후버(hover)는 새로운 코더가 즉각적인 결과를 얻을 수 있는 이상적인 방법입니다. 그리고 여기 중요한 것이 있습니다. "놀기"는 이렇게 하면 다른 문을 열 수 있습니다. "이렇게만 하면 어쩌지?"라는 것은 많은 사람들이 일상 업무에서 스스로에게 좀처럼 묻지 않는 것이다. 정의된 설계에서 작업할 수 있는 경우 재생 가능성이 거의 없고 실험할 기회도 더 적은 경우가 많습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 700px;"><iframe id="cp_embed_QWybxmV" src="//codepen.io/anon/embed/QWybxmV?height=700&amp;theme-id=1&amp;slug-hash=QWybxmV&amp;default-tab=result" height="700" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed QWybxmV" title="CodePen Embed QWybxmV" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

자, 여기 마지막 교훈이 있습니다: 놀 시간을 내세요. "어떻게 이걸 그렇게 만들 수 있죠?"라는 질문만 들어도요. 새로운 것을 배우고, CSS의 새로운 것을 보고, 일상 업무에 다시 참여할 수 있는 방법을 찾아보도록 강요했습니다. 실험(또는 더 나은 연주를 하는 것)은 저를 더 나은 디자이너로 만들어 주었고, 저는 더 많은 일을 할 것입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_yLYmGEW" src="//codepen.io/anon/embed/yLYmGEW?height=450&amp;theme-id=1&amp;slug-hash=yLYmGEW&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed yLYmGEW" title="CodePen Embed yLYmGEW" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

배운 교훈: 시간을 내서 놀아라.

### 결론

만약 내가 CSS를 신입에게 가르치면서 배운 것이 있다면, 나는 더 이상 처음부터 코드를 거의 쓰지 않는다는 것이다. 코드 조각과 자동 완성은 몇 시간을 절약해 주지만, 정말 기본적인 것들은 잊어버리게 하는 것과 같은 편리함입니다. 내가 알아야 할 것들. 다른 사람을 가르침으로써, 비록 때때로 15분 동안일지라도, 제 코딩은 일반적으로 향상되었고, 제 눈은 제가 달리 고려하지 않았을지도 모르는 새로운 아이디어와 기술에 열려있습니다.

그리고 내 친구는? 글쎄, 그녀는 우리가 함께 짧은 시간에 CSS에 의해 너무 많이 받아들여져서 HTML을 포함하는 온라인 강좌를 지금 하고 있는데, 그녀는 그것이 무엇을 할 수 있는지 알 정도로 그렇게 지루해 보이지 않는다.