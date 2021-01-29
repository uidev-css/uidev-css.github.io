---
layout: post
title: "내 개인 사이트의 작은 것들
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/10/wavy-fingerprint.png
tags: 
---


저번에 개인 웹 사이트를 업데이트했습니다.
 100 % 나만있는 몇 안되는 프로젝트이기 때문에 항상 재미있는 프로젝트입니다.
 이 사이트는 내가 약간의 재미를 느낄 수 있도록 만드는 것 외에 다른 목표가없는 내 개인 놀이터입니다.
 완전히 재 작성하는 것이 아니라 새로운 페인트입니다.
 

공유를 통한 학습 정신의 일부 속임수를 연마하기 위해 여기에 약간의 내용을 문서화 할 것이라고 생각했습니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/10/chriscoyier.net_-1.png?resize=3160%2C6068&ssl=1)

### Hoefler 글꼴
 

잉크 웰 가족은 정말 멋지다고 생각합니다.
 나는 가중치뿐만 아니라 serif와 sans-serif 및 caps vs not 혼합 및 일치를 좋아합니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/10/Screen-Shot-2020-10-26-at-7.51.24-AM.png?resize=1024%2C383&ssl=1)

지난 디자인에도 잉크 웰을 사용했지만 블로그 게시물 본문 카피에 너무 우스꽝스럽지 않을까 걱정되었습니다.
 내 글은 매우 캐주얼하지만 항상 그런 것은 아니며 Inkwell은 진지한 주제에 너무 유쾌합니다.
 나는 지난번에 바디 카피를 위해 Ideal Sans와 함께 갔지만 Inkwell과의 페어링은 약간 기분이 좋지 않았습니다.
 

이번에는 Whitney와 함께 일반 바디 카피를 위해 갔는데, 이것은 여전히 매우 가볍지 만 카피가 더 스트레이트 톤일 때 작동합니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/10/Screen-Shot-2020-10-23-at-4.34.17-PM.png?resize=627%2C328&ssl=1)

### Blogroll
 

테이블을 얼룩말 줄무늬로 만들려면 다음과 같이하면됩니다.
 

```css
tr:nth-child(even) {
  background-color: var(--color-1);
}
tr:nth-child(odd) {
  background-color: var(--color-2);
}
```

그래도 4 가지 색상을 회전하고 싶다면?
 여전히`: nth-child` 속임수로 4 명마다 선택하고 상쇄합니다.
 여기에서는 Sass의 목록 항목을 사용하여 수행합니다 (중첩이 좋으며 선택기를 반복 할 필요가 없음).
 

이것이 제가 색상 화 된 블로그 롤을 만들기 위해 한 일입니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/10/Screen-Shot-2020-10-26-at-8.04.14-AM.png?resize=1024%2C547&ssl=1)

위에서 사용 된 Sass에 주목하세요… 저는 Sass가 이미 프로젝트에서 사용 중이었기 때문에 사용했습니다.
 내가해야 할 일은 CodeKit을 열기 만하면 바로 처리 할 수있었습니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/10/Screen-Shot-2020-10-26-at-8.03.26-AM.png?resize=2108%2C1440&ssl=1)

아, 그리고 blogrolls는 다시 멋지다.
 

### 진정 YouTube
 

나는 여전히 매우 영리한이 클릭-투-로드 -YouTube- (전혀) 기술을 사용했다.
 YouTube 삽입과 똑같이 작동하는`<iframe>`을 사용하지만 리소스 힙과 힙이 아닌 단순한 정적 이미지 만로드하면 성능이 우수하고 기본적으로 일반 YouTube 삽입과 동일하게 작동합니다.
 

```html
<iframe
  width="560"
  height="315"
  src="https://www.youtube.com/embed/Y8Wp3dafaMQ"
  srcdoc="<style>*{padding:0;margin:0;overflow:hidden}html,body{height:100%}img,span{position:absolute;width:100%;top:0;bottom:0;margin:auto}span{height:1.5em;text-align:center;font:48px/1.5 sans-serif;color:white;text-shadow:0 0 0.5em black}</style><a href=https://www.youtube.com/embed/Y8Wp3dafaMQ?autoplay=1><img src=https://img.youtube.com/vi/Y8Wp3dafaMQ/hqdefault.jpg alt='Video The Dark Knight Rises: What Went Wrong? – Wisecrack Edition'><span>▶</span></a>"
  frameborder="0"
  allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"
  allowfullscreen
  title="The Dark Knight Rises: What Went Wrong? – Wisecrack Edition"
></iframe>
```

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/10/CleanShot-2020-10-27-at-08.21.26@2x.png?resize=2434%2C1312&ssl=1)

### 어디서나 맞춤 게시물 유형
 

저는 작업 할 구조화 된 데이터를 제공하는 것을 좋아합니다.
 WordPress-land에서 이는 종종 작업에 필요한 올바른 데이터를 위해 고급 사용자 정의 필드 플러그인과 같은 사용자 정의 게시물 유형을 의미합니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/10/Screen-Shot-2020-10-27-at-8.23.41-AM.png?resize=1024%2C536&ssl=1)

그런 다음 원하는대로 반복하여 출력 할 수 있습니다.
 그렇게 화려하지는 않지만 앞으로 원하는 모든 문을 훨씬 쉽게 열어줍니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/10/Screen-Shot-2020-10-27-at-8.24.58-AM.png?resize=666%2C463&ssl=1)

### 나만의 약력 구축
 

이것이 어떻게 작동하는지에 대한 환상은 없습니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/10/Screen-Shot-2020-10-27-at-8.26.13-AM.png?resize=1024%2C853&ssl=1)

나는 말 그대로 18 개의`<div>`요소 (3 개의 길이 * 2 개의 스타일 * 3 개의 코드 유형 = 18)를 만들고 현재 선택 사항을 기반으로 클래스 문자열을 계산하고 해당 클래스를 선택하고 숨김을 해제하는 약간의 JavaScript로 교체합니다.
 나머지는 숨 깁니다.
 

```jquery
$(".bio-choices input").on("change", function () {
  var lengthClass = ".bio-" + $("input[name=length]:checked").attr("id");
  var styleClass = ".bio-" + $("input[name=style]:checked").attr("id");
  var codeClass = ".bio-" + $("input[name=code]:checked").attr("id");
  var selector = lengthClass + styleClass + codeClass;

  $(".bio").hide();
  $(selector).show();
});
```

jQuery!
 그것이 이미 사이트에있는 것입니다. 또한 사이트는 반응 형 비디오를 위해 jQuery 버전의 FitVids를 사용합니다. 그래서 그냥 그대로 두겠다고 생각했습니다.
 

사이트의 이러한 부분을 다시 작성하려면 아마도 jQuery를 뜯어 내서 FitVids에 사용할 것입니다.
 그런 다음 3 개의 바이오스 (단어 교환으로 1 인칭 대 3 인칭을 처리하는 좋은 방법을 찾을 수없는 경우 6 개) 만있는 방법을 찾은 다음 어떻게 든 형식을 자동으로 변환하여 나머지를 얻을 수 있습니다 (클라우드 일 수도 있음).
 필요한 경우 기능).
 

### ztext.js
 

헤더에 ztext를 사용했습니다!
 웹이 나에게 더 많은 웹을 느끼게하는 것은 이런 것입니다.
 CSS-Tricks와 같은 사이트에서 너무 많은 움직임으로 무언가를 할 수 있을지 모르겠습니다 (사람들이 더 자주 방문하고 사이트에 머문 시간이 더 길기 때문입니다).
 하지만 사람들이 한 번 푸른 달에 착륙 할 수있는 사이트의 경우 적절한 수준의 쾌활한 경쾌함이 있다고 생각합니다.
 

### 배경 SVG
 

최근 SVG 배경 사이트가 업그레이드되는 것을보고 놀랐습니다.
 나는 거기에서 놀았고 예,이 일을하고 있습니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/10/Screen-Shot-2020-10-27-at-9.21.36-AM.png?resize=1024%2C710&ssl=1)

나는 내가 좋아하는`background-attachment : fixed` 모양으로 갔다.
 또한 데스크탑에 슬라이드 아웃 바닥 글 효과를 추가했지만 여기서 작동하는 것보다 판매가 적습니다.
 배경이 바뀌면 더 재미 있고 여기서는 일어나지 않습니다.
 바닥 글의 배경을 변경하거나 효과를 제거 할 것입니다.
 

### 링크에 대한 필터 트릭
 

사이트의 다른 섹션 중 일부는 다른 기본 강조 색상을 사용하며 해당 섹션의 링크는 해당 색상을 따릅니다.
 의심 스러울 수도 있지만 (아마 모든 링크가 파란색이어야 함) 지금까지는 괜찮은 것 같습니다 (여전히 호버 및 포커스 스타일이 있음).
 하지만 인터랙티브 요소에 대해 다양한 색상과 스타일이있는 경우 마우스 오버 및 포커스를위한 특별한 대체 스타일을 만들어야하는 경우가 많습니다.
 그것은 각 색상에 대한 맞춤형 색상 변경을 의미 할 수 있습니다.
 세상의 끝은 아니지만 모든 색상에서 일관된 모양으로 끝나는 인터랙티브 스타일에 대한이 작은 트릭을 정말 좋아합니다.
 

```css
a:focus, .button:focus,
a:hover, .button:hover {
  filter: brightness(120%);
}
```

어쨌든!
 이 사이트에 페인트 칠하는 데 몇 시간 밖에 걸리지 않았습니다.
 그 주에 블로그 롤이 CodePen 챌린지 였기 때문입니다.
 하지만 한동안 가지지 않은 사이트는 절대 건드리지 않고 한 가지만 할 수 있습니다.
 빨려 들어가서 더해야 돼!
 