---
layout: post
title: "Tello를 Super Simple CMS로 사용"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/07/trello-board.png
tags: API,CMS,JSON
---


때때로 우리의 사이트들은 약간의 컨텐츠 관리를 필요로 한다. 항상은 아냐. 많지 않은. 그런데 약간. CMS 시장은 저렴하고 접근성이 좋은 제품으로 성업하고 있습니다. 따라서 선택권이 부족하지 않습니다. 고맙게도, 이 세상은 기업들이 1조 1천억 달러를 쏟아내도록 강요하던 것과는 아주 다른 세상입니다. (정확한 비용은 아닙니다.) 저는 가장 가까운 Bazillion)로 이동했습니다. All-contracted, All-conflicting, all-personalizing, big-competicated™ CMS 플랫폼을 구입했습니다.

그러나 때로는 새로운 CMS를 사용하기 보다는 사이트에서 콘텐츠를 업데이트하는 모든 사람이 이미 익숙한 매우 간단한 도구를 사용하는 것이 좋습니다.

저는 아이디어와 업무를 관리하는 데 있어서 트렐로를 많이 좋아합니다. API도 있습니다. 웹 사이트의 콘텐트 소스로 사용하는 것이 어떻습니까? 제 말은, 만약 우리가 구글 시트로 그것을 할 수 있다면, 우리가 다른 것들을 시도하지 못하게 막을 수 있는 것은 무엇일까요?

### 안녕하세요, 트렐로

다음은 간단한 탐색 사이트입니다. 이 Tello 보드에서 콘텐츠를 가져오고 해당 콘텐츠가 섹션으로 표시됩니다. 각 섹션은 Tello 보드에 있는 카드의 제목 및 설명 필드로 채워집니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/07/screenshots.jpg?resize=1600%2C1006&ssl=1)

트렐로는 마크다운을 이용해요. 여기 유용하죠. Tello 카드에서 콘텐츠를 편집하는 모든 사용자는 기본 텍스트 형식을 적용할 수 있으며 사이트로 동일한 Markdown 흐름을 가지고 빌드 프로세스에 의해 HTML로 변환됩니다.

### 집짓기 블록

저는 다양한 피드와 소스의 콘텐츠를 가져온 다음 템플릿으로 함께 매치하여 웹 사이트의 HTML을 생성하는 빌드를 운영하는 이 모델의 열렬한 팬입니다. 그것은 프레젠테이션을 컨텐츠 관리(현대 CMS 제품에서 "디커플링(decoupled)"이라는 용어는 현대의 인기 있는 CMS 제품에서 유래한다. 그리고 이것은 우리가 여기서 배운 모든 현란한 기술과 기술로 우리가 원하는 방식으로 웹사이트를 만들 수 있다는 것을 의미합니다. CSS-Tricks.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/07/trello-data-flow.png?resize=1166%2C562&ssl=1)

빌드 시 콘텐츠를 끌어오기 때문에 사이트가 널리 사용되고 트래픽이 많이 유입되면 데이터 소스의 사용 할당량이나 성능에 대해 걱정할 필요가 없습니다. 왜 안 그럴까요? 우리가 얼마나 예쁘게 만들었는지 봐!

### 나 놀고 싶어!

좋아요. 이 사이트의 코드 사본을 가지고 마음껏 돌아다닐 수 있어요. 이 버전에는 자신만의 Tello 보드를 만들어 빌드의 콘텐츠 소스로 사용하는 방법에 대한 정보가 포함되어 있습니다.

- GitHub의 사이트 코드 저장소 예제
- 데모 사이트
- 몇 번의 클릭으로 자신의 복사본을 복제 및 배포

만약 여러분이 직접 뛰어들기 보다는 어떻게 작동하는지 먼저 살펴보고 싶다면, 계속 읽어보세요.

### API 검색

Tello는 잘 문서화된 API와 개발자 자원 세트를 가지고 있다. API 인증 및 상호 작용 작업을 단순화할 수 있는 편리한 노드 모듈도 있습니다. 그러나 Tello 보드를 탐색할 때 URL을 사용하여 API를 탐색할 수도 있습니다.

예를 들어, 위의 Tello 보드의 URL은 다음과 같습니다.

```
https://trello.com/b/Zzc0USwZ/hellotrello
```

해당 URL에 .json을 추가하면 Tello가 JSON으로 표시된 콘텐츠를 보여줍니다. 한번 보세요.

우리는 이 기술을 사용하여 트렐로 전체의 기본 데이터를 검사할 수 있습니다. 다음은 특히 한 카드의 URL입니다.

```
https://trello.com/c/YVxlSEzy/4-sections-from-cards
```

이 작은 트릭을 사용하여 URL에 `.json`을 추가하면 해당 카드를 설명하는 데이터가 표시됩니다.

게시판의 고유 ID, 목록 및 카드와 같은 흥미로운 항목을 찾을 수 있습니다. 우리는 카드의 내용과 많은 메타데이터를 볼 수 있습니다.

나 이거 하는 거 좋아해! 이 멋진 자료들 좀 보세요! 어떻게 사용할까요?

### 보드 사용 방법 결정

이 예에서는 관리 가능한 콘텐츠가 한 페이지밖에 없는 사이트가 있다고 가정해 보겠습니다. 우리 게시판의 목록이나 칼럼은 그 페이지의 섹션을 조절하는 데 이상적일 것이다. 편집자는 제목과 내용을 제공하고 원하는 순서로 끌어다 놓을 수 있습니다.

API로 접속하려면 목록의 ID가 필요합니다. 다행히도, 우리는 이미 그것을 발견하는 방법을 알아냈습니다. 문제의 목록에 있는 카드의 데이터를 살펴보십시오. 각각 IDBoard 속성이 있습니다. 빙고!

### 사이트 생성

Tello에서 데이터를 가져와 일부 템플릿에 적용하여 사이트를 채울 계획입니다. 대부분의 정적 사이트 생성기(SSG)가 이 작업을 수행합니다. 그것이 그들이 잘하는 것이다. 이해하기가 가장 간단한 개념인 것 같아서 11번을 쓰겠습니다. 또한 Nunjuks(인기 템플릿 언어)를 사용하여 데이터를 얻고 깨끗한 HTML을 생성하는 데 매우 효율적입니다.

템플릿에서 `trello`라는 JavaScript 개체에 있는 각 항목에 대해 `섹션` 요소를 출력하는 식을 사용할 수 있습니다.

```html
<!-- index.njk -->
{% for card in trello %}
<section>
  <h2>{ card.name }</h2>
  <div>
    {% markdown %}
      {- card.desc | safe }
    {% endmarkdown %}
  </div>
</section>
{% endfor %}
```

### 빌드에 대한 데이터 가져오기

이와 같은 Jamstack 사이트에서 널리 사용되는 기술은 Gulp, Grunt 또는 [insert new build 스크립트 hotness hotness hotness] 빌드를 실행하여 다양한 API와 피드에서 데이터를 가져오고 SSG에 적합한 형식으로 데이터를 쌓은 다음 SSG를 실행하여 HTML을 생성하는 것이다.

Highth는 데이터 파일에서 JavaScript 실행을 지원함으로써 여기서 작업을 간소화합니다. 즉, JSON이나 YAML로 저장된 데이터만 활용하는 것이 아니라 자바스크립트에서 반환되는 모든 데이터를 사용할 수 있어, Eleventity 빌드가 실행될 때 API에 직접 요청을 할 수 있는 문이 열린다. 먼저 데이터를 가져오기 위해 별도의 빌드 단계가 필요하지 않습니다. 열한 살이면 될 거야.

이를 통해 템플릿에 있는 trello 객체에 대한 데이터를 얻읍시다.

우리는 Tello Node 클라이언트를 사용하여 API를 조회할 수 있지만, 우리가 원하는 모든 데이터가 JSON에 바로 게시판을 위해 있습니다. 전부 다! 한 가지 부탁이 있습니다! 한 번에 가져올 수 있어!

```js
// trello.js
module.exports = () => {
  const TRELLO_JSON_URL='https://trello.com/b/Zzc0USwZ/hellotrello.json';

  // Use node-fetch to get the JSON data about this board
  const fetch = require('node-fetch');
  return fetch(TRELLO_JSON_URL)
    .then(res => res.json())
    .then(json => console.log(json));
};
```

하지만, 우리는 그 보드의 모든 데이터를 보여주고 싶지는 않습니다. 다른 목록에 있는 카드, 닫혔다가 삭제된 카드 등이 있습니다. 그러나 자바스크립트의 필터 방식 덕분에 우리는 관심 있는 카드만 포함하도록 필터링할 수 있다.

```js
// trello.js
module.exports = () => {
   const TRELLO_JSON_URL='https://trello.com/b/Zzc0USwZ/hellotrello.json'
   const TRELLO_LIST_ID='5e98325d6d6bd120f2b7395f',
 
   // Use node-fetch to get the JSON data about this board
   const fetch = require('node-fetch');
   return fetch(TRELLO_JSON_URL)
   .then(res => res.json())
   .then(json => {
 
     // Just focus on the cards which are in the list we want
     // and do not have a closed status
     let contentCards = json.cards.filter(card => {
       return card.idList == TRELLO_LIST_ID && !card.closed;
     });
 
     return contentCards;
 });
};
```

그걸로 충분해! 이것을 Eleventy의 데이터 디렉토리에 있는 trello.js라는 파일에 저장하면, 우리는 trello라는 객체의 템플릿에서 사용할 수 있도록 이 데이터를 준비하게 될 것이다.

완료! 🎉

하지만 우린 더 잘할 수 있어. 또한 첨부된 이미지를 처리하고 콘텐츠가 라이브로 전환되기 전에 검토를 위해 스테이징할 수 있는 방법을 추가해 보겠습니다.

### 이미지 첨부 파일

트렐로의 카드에 파일을 첨부할 수 있습니다. 이미지를 첨부하면 해당 이미지는 데이터에 설명된 자산의 소스 URL과 함께 카드에 표시됩니다. 우린 그걸 이용할 수 있어!

카드에 이미지 첨부 파일이 있는 경우 원본 URL을 가져와 빌드 시 템플릿이 페이지에 삽입하는 항목에 이미지 태그로 추가합니다. 즉, JSON의 설명 속성(`card.desc`)에서 이미지에 대한 Markdown을 Markdown에 추가하는 것입니다.

그러면 우리는 그것을 다른 모든 것들과 함께 우리를 위해 HTML로 바꾸도록 할 수 있습니다. 이 코드는 JSON에서 카드를 찾고 데이터를 필요한 모양으로 마사지합니다.

```js
// trello.js

// If a card has an attachment, add it as an image 
// in the description markdown
contentCards.forEach(card => {
  if(card.attachments.length) {
    card.desc = card.desc + `\n![${card.name}](${card.attachments[0].url} '${card.name}')`;
  }
});
```

이제 우리는 우리의 컨텐츠에서도 이미지를 이동할 수 있습니다. 편리해!

### 컨텐츠 준비 중

Tello를 사용하여 사이트의 컨텐츠를 관리하는 방법에 한 가지 더 추가해 보겠습니다.

콘텐츠를 전 세계에 출시하기 전에 미리 보기를 원하는 몇 가지 방법이 있습니다. 저희 트렐로 보드에는 스테이징용 리스트와 프로덕션 컨텐츠용 리스트가 하나씩 있을 수 있습니다. 하지만 그렇게 되면 이미 출판된 컨텐츠와 함께 새로운 컨텐츠가 어떻게 살아가는지 상상하기가 어려워질 것입니다.

더 나은 아이디어는 트렐로의 레이블을 사용하여 어떤 카드가 라이브로 게시되고, 어떤 카드가 사이트의 준비된 버전에만 포함되어야 하는지를 나타내는 것입니다. 이렇게 하면 작업 흐름이 좋아집니다. 우리는 올바른 위치에 새 카드를 추가하여 더 많은 콘텐츠를 추가할 수 있습니다. "스테이지"로 라벨을 붙이고 저희 생산 지점에 나타나는 카드에서 걸러내세요.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/07/Screenshot-2020-07-14-at-18.06.41.png?resize=1600%2C1150&ssl=1)

JavaScript 개체에 대한 조금 더 많은 필터링이 필요합니다.

```js
// trello.js

// only include cards labelled with "live" or with
// the name of the branch we are in
contentCards = contentCards.filter(card => {
  return card.labels.filter(label => (
    label.name.toLowerCase() == 'live' ||
    label.name.toLowerCase() == BRANCH
   )).length;
 });
```

스테이징 여부에 관계없이 모든 빌드 버전에 `라이브`라는 레이블이 지정된 콘텐츠가 표시되기를 원합니다. 또한 "Branch"라는 변수와 일치하는 레이블이 있는 카드도 포함하려고 합니다.

어째서? 그게 뭐야?

여기가 우리가 교활해지는 곳이야! Netliify에서 이 사이트를 호스팅하기로 선택했습니다(거부자: 나는 그곳에서 일한다. 즉, Netliify의 CI/CD 환경에서 빌드를 실행할 수 있습니다. 이렇게 하면 Git 저장소에 변경 사항을 적용할 때마다 사이트를 다시 배포하고 이 사이트에 매우 유용한 몇 가지 다른 항목에 액세스할 수 있습니다.

하나는 Branch 배포입니다. 사이트에 대한 새 환경을 원하는 경우 Git 리포지토리에 새 분기를 만들어 사이트를 만들 수 있습니다. 빌드는 해당 컨텍스트에서 실행되고 사용자의 사이트는 분기 이름을 포함하는 하위 도메인에 게시됩니다. 이것처럼.

한번 보시면 오렌지색 "스테이지" 라벨이 붙어 있는 카드를 포함하여 저희 리스트의 모든 카드가 보일 것입니다. 레이블과 빌드 컨텍스트의 분기 이름이 일치하기 때문에 이 빌드에 포함시켰습니다. 브랜치는 빌드가 운영하는 지점을 포함하는 환경 변수였다.

```js
label.name.toLowerCase() == BRANCH
```

이론적으로, 우리는 원하는 만큼 분기와 라벨을 만들 수 있고, 모든 종류의 스테이징과 테스트 환경을 가질 수 있습니다. "무대"에서 "살다"로 무언가를 홍보할 준비가 되셨습니까? 라벨을 바꾸면 가도 좋다!

### 그런데 어떻게 업데이트 되는 거죠?

Netlifify와 같은 CI/CD에서 사이트 빌드를 실행함으로써 얻을 수 있는 두 번째 이점은 원할 때마다 빌드를 실행할 수 있다는 것입니다. Netliify를 사용하면 빌드 후크를 만들 수 있습니다. HTTP POST를 보낼 때 새 배포를 시작하는 웹 후크입니다.

Tello가 웹 후크도 지원하는 경우 이러한 서비스를 함께 연결하여 Tello 보드가 변경될 때마다 사이트를 자동으로 새로 고칠 수 있습니다. 그리고 그들이 뭘 하는지 맞춰보세요! 호호라!

Netlifify 빌드 후크를 만들려면 사이트의 관리 패널을 방문해야 합니다. (이 데모 사이트를 몇 번의 클릭으로 새 Netliify 사이트로 부트스트랩할 수 있습니다.)

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/07/build-hook.png?resize=1354%2C829&ssl=1)

이제 새로운 빌드 후크 URL로 무장한 Tello 웹 후크를 등록해야 합니다. 이 웹 후크는 내용이 변경되면 이를 호출합니다. Tello에서 웹 후크를 만드는 방법은 Tello의 API를 통해서이다.

이 사이트의 보고서에는 Tello API를 호출하고 웹 후크를 만들 수 있는 작은 유틸리티가 포함되어 있습니다. 하지만 Tello 개발자 토큰과 키가 필요합니다. 다행히 트렐로 개발자 포털을 방문해 `클라이언트 인증`에 따른 지침을 따르면 무료로 만들 수 있다.

알아들었어? 좋습니다! 프로젝트의 `.env` 파일에 저장할 경우 다음 명령을 실행하여 Tello 웹 후크를 설정할 수 있습니다.

```terminal
npm run hook --url https://api.netlify.com/build_hooks/XXXXX
```

이를 통해 간단한 사이트에서 컨텐츠를 관리하기 위한 작은 흐름을 만들어냈습니다. 원하는 대로 프런트 엔드를 만들 수 있으며, 변경 사항이 있을 때마다 사이트를 자동으로 업데이트하는 Tello 보드에서 컨텐츠 업데이트를 수행할 수 있습니다.

### 그래도 이걸 써도 될까요?

이것은 간단한 예시이다. 그건 디자인으로 한 거예요. 저는 디커플링의 개념과 외부 서비스의 API를 사용하여 사이트의 컨텐츠를 구동하는 개념을 보여주고 싶었습니다.

이는 더 많은 관련 프로젝트를 위해 모든 기능을 분리한 CMS를 대체하지는 못합니다. 하지만 그 원칙들은 더 복잡한 사이트에도 완전히 적용된다.

그러나 이 모델은 독립 상점, 술집, 레스토랑과 같은 사업체를 위해 우리가 보는 웹사이트의 종류와 아주 잘 어울릴 수 있다. 트렐로 게시판이 레스토랑의 홈 페이지를 관리하고 메뉴 항목을 관리하는 목록을 가지고 있다고 상상해 보십시오. 레스토랑 직원이 관리하기에 매우 편리하며, 메뉴가 변경될 때마다 새로운 PDF를 업로드하는 것보다 훨씬 더 좋습니다.

사례를 살펴보고 자신만의 보드 및 컨텐츠를 사용해 실험할 준비가 되셨습니까? 시도해 보십시오.

- 위에서 예제를 복제 및 배포하고 변경 작업을 시작하십시오.
- Netliify 분기 빌드를 사용하여 수행할 수 있는 작업 자세히 알아보기
- Tello 개발자 리소스를 더 깊이 조사하십시오.