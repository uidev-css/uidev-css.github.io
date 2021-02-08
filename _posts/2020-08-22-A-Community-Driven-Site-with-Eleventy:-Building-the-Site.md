---
layout: post
title: "커뮤니티가 주도하는 마천루 : 마천루 건설"
author: "CSS Dev"
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/08/weekly-pet-battle.png
tags: ELEVENTY,NETLIFY,NUNJUCKS
---

마지막 기사에서, 우리는 지역사회 중심 사이트의 계획에 무엇이 포함되는지 배웠습니다. Style Stage를 구축한 경험을 바탕으로 사용자 제출 수락에 필요한 고려 사항이 몇 가지인지 확인했습니다.

이제 계획을 다뤘으니 코드로 넘어가자! 함께 커뮤니티(또는 개인) 사이트의 시작점으로 사용할 수 있는 Eleventity 설정을 개발하겠습니다.

이 문서에서는 다음 내용을 다룹니다.

-   Elevant를 초기화하고 유용한 개발 및 빌드 스크립트를 작성하는 방법
-   권장 설치 사용자 지정
-   사용자 정의 데이터를 정의하고 여러 데이터 소스를 결합하는 방법
-   Nunjucks 및 Elevation Chain을 사용하여 레이아웃 만들기
-   Netlifify로 배포

### 비젼

사람들이 개와 고양이를 제출하고 서로 애교 경연대회에서 겨루게 하고 싶다고 가정해 봅시다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/08/YD_O3yWQ.png?resize=2010%2C1580&ssl=1)

우리는 이 기사에서 사용자 투표에 참여하지 않을 것이다. 그렇게 하면 정말 멋질 것 같지만(서버가 없는 기능에서 완전히 가능함) 우리의 초점은 반려동물 제출 자체에 있습니다. 즉, 사용자는 자신의 고양이와 개에 대한 프로필 세부사항을 제출할 수 있습니다. 우리는 그 제출물들을 이용하여 무작위로 뽑은 개와 홈페이지에서 무작위로 뽑은 개를 상대로 매주 격전을 벌이도록 하겠습니다. 어떤 것이 가장 순박한 것인지 말이죠.

### 11번 회전하자.

먼저 원하는 디렉토리에서 `npm init`를 실행한 후, 다음과 같이 Eleventity를 설치하는 것으로 새 프로젝트를 초기화합니다.

```
npm install @11ty/eleventy
```

완전히 선택적이지만 디렉토리에 추가된 `package-json` 파일을 열고 `scripts` 섹션을 다음과 같이 바꾸고 싶습니다.

```package.json
"scripts": {
  "develop": "eleventy --serve",
  "build": "eleventy"
},
```

이를 통해 우리는 지역 개발을 위해 브라우저 동기화 핫로딩을 포함하는 개발 환경(npm run develop)에서 Elevent를 개발할 수 있다. 또한 프로덕션 서버에 배포할 수 있도록 작업(npm run build)을 컴파일하고 빌드하는 명령도 추가합니다.

"npm 뭐?"라고 생각하신다면, 저희가 지금 하고 있는 일은 노드(Elevently Levelty)에 전화를 거는 것입니다. 여기에 명시된 명령은 선호하는 터미널에서 실행되도록 되어 있습니다. 이 터미널은 VS Code에서와 같이 추가 프로그램 또는 코드 편집기에 내장되어 있을 수 있습니다.

데이터 결합을 위해 잠시 후에 유용하게 사용할 수 있는 npm 패키지, 패스트글로브가 하나 더 필요합니다. 지금 설치하는 것이 좋습니다.

```
npm install --save-dev fast-glob.
```

### 디렉토리를 구성합니다.

11을 사용하면 입력 디렉토리(우리가 작업하는 곳)와 출력 디렉토리(빌트된 작업이 진행되는 곳)를 사용자 정의하여 약간의 추가 구성을 제공할 수 있습니다.

이를 구성하려면 프로젝트 디렉터리의 루트에 `evenent.js` 파일을 생성합니다. 그런 다음 입출력 디렉토리가 어디로 갈지 11번에게 알려드리겠습니다. 이 경우 입력에는 `src` 디렉토리를 사용하고 출력에는 `public` 디렉토리를 사용합니다.

```js
module.exports = function(eleventyConfig) {
    return {
        dir: {
            input: "src",
            output: "public"
        }
    };
};
```

다음으로, 우리는 사용자 제출로부터 얻은 애완동물 데이터를 저장할 `펫`이라는 디렉토리를 만들 것이다. 우리는 이 디렉토리를 좀 더 세분화하여 병합 충돌을 줄이고 고양이 데이터와 개 하위 디렉토리의 개 데이터를 명확하게 구분할 수 있다.

```
pets/
  cats/
  dogs/
```

데이터는 어떻게 보일까요? 사용자는 이 스키마를 따르는 JSON 파일을 보냅니다. 여기서 각 속성은 애완동물에 대한 데이터 지점입니다.

```js
{
  "name": "",
  "petColor": "",
  "favoriteFood": "",
  "favoriteToy": "",
  "photoURL": "",
  "ownerName": "",
  "ownerTwitter": ""
}
```

사용자에게 제출 프로세스를 명확히 하기 위해 `CONTRIB`를 작성할 수 있습니다.UTING.md은 프로젝트의 근저에 있는 파일이며 제출 지침서를 작성한다. GitHub은 이 파일의 내용을 가져와서 레포에 표시합니다. 이렇게 하면 좋아하는 음식, 좋아하는 음식 메모 등 이 스키마에 대한 안내를 할 수 있다.토이(Toy), 오너 트윗(Owner Twitte)은 선택 영역이다.

README.md 파일은 당신이 그 길을 가고 싶다면 그렇게 해도 좋다. 기부를 위한 표준 파일이 있다는 것은 좋은 일입니다.

공지사항 `사진URL`은 이러한 속성 중 하나입니다. 파일을 만들 수도 있었지만 보안과 호스팅 비용을 위해 URL을 대신 요청하려고 합니다. 당신은 당신이 실제 파일을 맡을 의향이 있다고 결정할 수도 있습니다. 그것은 아주 멋진 일이죠.

### 데이터로 작업해보자.

다음으로, 우리는 개별 고양이 파일과 개 파일에서 결합된 데이터 배열을 만들어야 합니다. 이를 통해 우리는 사이트 페이지를 만들고 주간 전투를 위해 무작위로 고양이와 개를 제출할 수 있습니다.

11은 `_data` 디렉토리 내에서 `module.exports` 노드를 허용합니다. 즉, 모든 고양이 파일을 찾는 기능을 만들고 모든 개 파일을 찾은 다음 각 세트에서 배열을 만드는 기능을 만들 수 있습니다. 이것은 마치 각각의 고양이 파일을 하나로 합쳐서 하나의 자바스크립트 파일에 하나의 데이터 세트를 만든 다음 개에게 동일한 작업을 하는 것과 같습니다.

`_data`에 사용된 파일 이름은 해당 데이터 세트를 저장하는 변수가 되므로, 이 안에 고양이와 개의 파일을 추가할 것입니다.

```html
_data/ cats.js dogs.js
```

각 파일의 기능은 거의 동일할 것이다. 우리는 단지 "cat"의 인스턴스를 "dog"와 교환하고 있을 뿐이다. 고양이를 위한 기능은 다음과 같습니다.

```js
const fastglob = require("fast-glob");
const fs = require("fs");

module.exports = async () => {
    // Create a "glob" of all cat json files
    const catFiles = await fastglob("./src/pets/cats/*.json", {
        caseSensitiveMatch: false
    });

    // Loop through those files and add their content to our `cats` Set
    let cats = new Set();
    for (let cat of catFiles) {
        const catData = JSON.parse(fs.readFileSync(cat));
        cats.add(catData);
    }

    // Return the cats Set of objects within an array
    return [...cats];
};
```

무섭게 보이나요? 걱정 말아라! 괜찮다! 저도 정기적으로 노드를 작성하지 않으며, 덜 복잡한 11개 사이트에 필요한 단계는 아닙니다. 대신 기여자들이 `_data`로 계속 성장하고 있는 단일 JSON 파일에 추가하도록 선택했다면 애당초 이 결합 단계는 필요하지 않을 것이다. 이 단계의 주요 이유는 개별 기여자 파일을 허용하여 병합 충돌을 줄이기 위함입니다. 이것이 우리가 혼합물에 빠른 장갑을 추가한 이유이기도 합니다.

### 데이터를 출력합시다.

지금은 UI를 위한 템플릿에 데이터를 연결하기 시작하는 것이 좋습니다. 실제로 JSON 파일 몇 개를 속성 데이터가 포함된 `애완동물/고양이`와 `애완동물/강아지` 디렉토리에 내려놓으면 바로 게이트 밖에서 작업할 수 있고 테스트도 할 수 있다.

src 디렉토리에 `index.njk` 파일을 추가하여 첫 번째 Elevent 페이지를 추가할 수 있습니다. 홈 페이지가 되며 Nunjucks 템플릿 파일 형식입니다.

Nunjucks는 Eleventity로 템플릿을 생성할 때 사용할 수 있는 옵션 중 하나입니다. 템플릿 옵션의 전체 목록은 문서를 참조하십시오.

먼저 데이터를 루프오버하고 고양이와 개 모두에 대해 순서가 지정되지 않은 목록을 출력합니다.

```html
<ul>
    <!-- Loop through cat data -->
    { for cat in cats }
    <li>
        <a href="/cats/{ cat.name | slug }/">{ cat.name }</a>
    </li>
    { endfor }
</ul>

<ul>
    <!-- Loop through dog data -->
    { for dog in dogs }
    <li>
        <a href="/dogs/{ dog.name | slug }/">{ dog.name }</a>
    </li>
    { endfor }
</ul>
```

참고로 cats와 dogs에 대한 참조는 \_data의 파일 이름과 일치한다. 루프 내에서 우리는 더블 컬리 브레이스(예: `{ cat.name})`를 사용하여 Nunjucks 템플릿 변수로 출력되는 `cat.name`에 표시된 것처럼 도트 표기법을 사용하여 JSON 키에 액세스할 수 있다.

### 애완동물 프로필 페이지를 만들자.

홈페이지(index.njk)의 고양이와 개 목록 외에 애완견에 대한 개별 프로필 페이지도 만들고자 합니다. 루프는 이러한 구조에 대해 `[펫 타입]/[name-slug](으)로 사용할 힌트를 사용하여`[pet type]/[name-slug]

데이터로부터 페이지를 작성하는 권장 방법은 데이터를 청크아웃할 수 있는 11개 개념의 페이지를 사용하는 것입니다.

우리는 `src` 디렉토리의 루트에 페이지화를 담당하는 파일을 만들 예정이지만, 이 파일이 src 내에 있고 여전히 Eleventity에서 발견될 수 있는 한, 사용자 지정 디렉토리에 파일을 중첩시킬 수 있습니다.

```
src/
  cats.njk
  dogs.njk
```

그런 다음 고양이용으로 표시된 페이지 정보를 앞부분 자료로 추가할 내용은 다음과 같습니다.

```src/cats.njk
---
pagination:
  data: cats
  alias: cat
  size: 1
permalink: "/cats/{ cat.name | slug }/"
---
```

`data` 값은 `_data`의 파일 이름입니다. 별칭 값은 선택 사항이지만 페이징된 배열에서 하나의 항목을 참조하는 데 사용됩니다. `size: 1`은 데이터 항목당 한 페이지를 생성 중임을 나타냅니다.

마지막으로, 페이지 출력을 성공적으로 생성하려면 원하는 퍼머링크 구조도 표시해야 합니다. 여기서 위의 별칭 값이 작동하며, 데이터 세트에서 이름 키에 액세스합니다. 그런 다음 문자열 값을 URL 친화적인 문자열(케이스를 낮추고 공간을 대시로 변환하는 등)로 변환하는 `슬러그`라는 내장 필터를 사용하고 있다.

### 지금까지의 내용을 다시 살펴보도록 하겠습니다.

지금은 npm run develop으로 일레븐틴을 불붙일 때다. 그러면 로컬 서버가 시작되고 프로젝트를 보는 데 사용할 수 있는 터미널의 URL이 표시됩니다. 터미널에 빌드 오류가 있는 경우 이를 표시합니다.

모든 작업이 성공적이었던 한, Eleventity는 다음을 포함하는 `public` 디렉토리를 생성합니다.

```
public/
  cats/
    cat1-name/index.html
    cat2-name/index.html
  dogs/
    dog1-name/index.html
    dog2-name/index.html
  index.html
```

그리고 브라우저에서는 인덱스 페이지에 고양이 이름의 링크된 목록과 연결된 개 이름의 다른 목록이 표시되어야 합니다.

### 애완견 프로필 페이지에 데이터를 추가하자.

고양이와 개에 대해 생성된 각 페이지는 현재 비어 있습니다. 작성에 사용할 수 있는 데이터가 있으니 작업해 봅시다.

11은 레이아웃 파일("템플릿") 또는 레이아웃에 포함된 템플릿 부분을 포함하는 `_include` 디렉토리를 예상한다.

두 개의 레이아웃을 만듭니다.

```
src/
  _includes/
    base.njk
    pets.njk
```

base.njk의 내용은 HTML 보일러 플레이트가 될 것입니다. 그 안의 `<body> 요소에는 특수 템플릿 태그인 {content | safe}이(가) 포함되어 있으며, 템플릿에 전달된 컨텐츠가 렌더링되는 곳에는 안전하게 전달된 HTML과 인코딩을 함께 렌더링할 수 있습니다.

그런 다음 다음과 같은 내용을 전면 자료로 추가하여 base.njk 레이아웃을 사용하도록 홈페이지 index.md을 지정할 수 있다. 이는 index.md에서 가장 먼저 발생할 수 있는 문제이며, 여기에는 다음과 같은 대시가 포함된다.

```index.md
---
layout: base.njk
---
```

public(공용) 디렉토리에서 컴파일된 HTML을 확인하면 우리가 만든 고양이와 개 루프의 출력이 base.njk(베이스.njk) 레이아웃의 <바디> 내에 있음을 알 수 있다.

다음으로, 동일한 전면 문제를 pets.njk에 추가하여 레이아웃 체인의 Elevent 개념을 활용하기 위해 base.njk 레이아웃도 사용할 것이라고 정의합니다. 이렇게 하면 pets.njk에 배치되는 콘텐츠는 HTML 보일러플레이트인 base.njk로 포장되므로 매번 해당 HTML을 작성할 필요가 없습니다.

단일 `pets.njk` 템플릿을 사용하여 고양이 및 개 프로파일 데이터를 모두 렌더링하기 위해 계산 데이터라고 하는 최신 Eleventity 기능 중 하나를 사용합니다. 이를 통해 `if` 문이나 두 개의 별도 템플릿(고양이에 대한 템플릿과 개에 대한 템플릿)을 사용하는 대신 고양이와 개 데이터의 값을 동일한 템플릿 변수에 할당할 수 있다. 다시 한 번 중복을 방지할 수 있는 이점이 있습니다.

cats.njk에 필요한 업데이트와 dogs.njk에 필요한 업데이트(cat을 dog로 대체):

```src/cats.njk
eleventyComputed:
  title: "{ cat.name }"
  petColor: "{ cat.petColor }"
  favoriteFood: "{ cat.favoriteFood }"
  favoriteToy: "{ cat.favoriteToy }"
  photoURL: "{ cat.photoURL }"
  ownerName: "{ cat.ownerName }"
  ownerTwitter: "{ cat.ownerTwitter }"
```

`EvenityComputed`는 이 전면 물질 배열 키를 정의한 다음 `cats` 데이터 세트의 값에 액세스하는 데 별칭을 사용합니다. 예를 들어, 이제 템플릿 변수가 동일하기 때문에 `{ title}`을 사용하여 고양이의 이름과 개의 이름에 액세스할 수 있습니다.

먼저 다음 코드를 pets.njk에 넣어 고양이 또는 개 프로파일 데이터를 성공적으로 로드하는 것으로 시작할 수 있습니다.

```html
<img src="{ photoURL }" />
<ul>
    <li><strong>Name</strong>: { title }</li>
    <li><strong>Color</strong>: { petColor }</li>
    <li><strong>Favorite Food</strong>: { favoriteFood if favoriteFood else 'N/A' }</li>
    <li><strong>Favorite Toy</strong>: { favoriteToy if favoriteToy else 'N/A' }</li>
    { if ownerTwitter }
    <li><strong>Owner</strong>: <a href="{ ownerTwitter }">{ ownerName }</a></li>
    { else }
    <li><strong>Owner</strong>: { ownerName }</li>
    { endif }
</ul>
```

우리가 이 모든 것을 하나로 묶어야 할 마지막 일은 캣츠njk와 dogs.njk의 전면 문제에 "애완동물.njk"를 추가하는 것이다.

이제 Elevelten을 실행하면 개별 펫 페이지를 방문하여 해당 프로필을 볼 수 있습니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/08/eArViDCA.png?resize=337%2C527&ssl=1)

우리는 이 기사에서 스타일링에 대해서는 언급하지 않지만, CSS가 어떻게 포함되어 있는지 샘플 프로젝트 보고서로 이동하시면 됩니다.

### 이것을 실운영에 배치해 봅시다!

이제 사이트가 작동 상태이며 호스팅 환경에 배포할 수 있습니다!

앞에서 권장한 바와 같이 Netliify는 제출물이 병합될 때마다 배포를 트리거하고 검토를 위해 전송하기 전에 제출의 미리 보기를 제공할 수 있기 때문에 특히 커뮤니티 기반 사이트에 적합합니다.

Netlifify를 선택하면 Netlifify 계정에 사이트를 추가하는 과정에서 선택할 수 있는 GitHub 레포에 사이트를 푸시합니다. 우리는 새로운 변경사항이 본사에 통합되면 Netliify에게 `public` 디렉토리와 `runnpm run build`에서 서비스하도록 지시할 것이다.

샘플 사이트에는 빌드 세부 정보를 포함하고 리포에서 Netliify에 의해 자동으로 감지되는 `netliify.toml` 파일이 포함되어 있어 새 사이트 흐름에서 세부 정보를 정의할 필요가 없습니다.

초기 사이트가 추가되면 설정 → Netliify에서 빌드 → Deploy를 방문하십시오. 배포 컨텍스트에서 "편집"을 선택하고 "배포 미리 보기" 선택을 "운영 분기/분기 배포 분기에 대한 임의의 풀 요청"으로 업데이트합니다. 이제 모든 풀 요청에 대해 풀 요청 검토 화면에서 직접 링크를 사용할 수 있는 미리보기 URL이 생성됩니다.

### 제출서류를 받기 시작하겠습니다!

Go를 통과하여 100달러를 모으기 전에, 첫 번째 게시물을 다시 방문하여 사용자 제출을 시작할 준비가 되었는지 확인하는 것이 좋습니다. 예를 들어, 커뮤니티 상태 파일이 아직 추가되지 않은 경우 프로젝트에 추가해야 합니다. 아마도 가장 중요한 것은 본점에 대한 지점 보호 규칙이 제대로 설정되어 있는지 확인하는 것입니다. 이는 꺼내기 요청을 병합하기 전에 승인이 필요함을 의미합니다.

기부자들은 GitHub 계정을 가져야 할 것이다. 이것이 장벽처럼 보일 수도 있지만, 익명성의 일부를 제거한다. 콘텐츠의 민감성 또는 대상 시청자에 따라 실제로 기여자를 검증하는 데 도움이 될 수 있습니다.

제출 절차는 다음과 같습니다.

-   웹 사이트 리포지토리를 포크로 만듭니다.
-   포크를 로컬 컴퓨터에 복제하거나 GitHub 웹 인터페이스를 사용하여 나머지 단계를 수행합니다.
-   필요한 데이터가 포함된 src/pets/cats 또는 src/pets/dog 내에 고유한 .json 파일을 생성합니다.
-   복제본에서 변경한 경우 변경 내용을 커밋하거나, 파일이 웹 인터페이스에서 편집된 경우 파일을 저장합니다.
-   기본 리포지토리로 끌어오기 요청을 다시 엽니다.
-   (선택사항) Netliify deploy 미리보기를 검토하여 정보가 예상대로 표시되는지 확인합니다.
-   변경 내용을 병합합니다.
-   Netliify는 새 애완동물을 라이브 사이트에 배포합니다.

FAQ 섹션은 참여자에게 풀 요청을 작성하는 방법을 알려주는 좋은 장소입니다. 스타일 스테이지에서 예를 확인할 수 있습니다.

### 이것으로 마치자.

우리가 가지고 있는 것은 프로젝트 레포에 대한 제출물로 사용자 기여를 받아들이는 완전한 기능을 갖춘 사이트입니다. 또한 이러한 기여가 통합될 때 자동으로 배포됩니다.

Eleventity로 구축된 커뮤니티 중심 사이트로 우리가 할 수 있는 일은 훨씬 더 많다. 예를 들어:

-   마크다운 파일은 버튼다운과 함께 보낸 이메일 뉴스레터의 내용에 사용할 수 있습니다. 마크를 Nunjucks 또는 Liquid와 혼합할 수 있는 11번째 아이템입니다. 따라서 예를 들어, 루프용 Nunjucks를 추가하여 최신 5개의 애완동물을 Markdown 구문으로 출력하고 Buttondown으로 픽업하는 링크로 출력할 수 있습니다.
-   소셜 네트워크 링크 미리보기를 위해 자동으로 생성된 소셜 미디어 미리보기 이미지를 만들 수 있다.
-   주석 시스템을 혼합에 추가할 수 있습니다.
-   Netliify CMS Open Authoring을 사용하여 사용자가 인터페이스를 사용하여 제출할 수 있습니다. 크리스의 작동 방식을 자세히 살펴보세요.

마이 야옹 대. BowWow 예는 GitHub에서 포크 할 수 있다. 라이브 프리뷰도 볼 수 있고, 네, 이 바보 같은 사이트에 애완동물을 제출할 수도 있습니다. 🙂

건강하고 번창하는 공동체를 만드는 행운을 빌어요!
