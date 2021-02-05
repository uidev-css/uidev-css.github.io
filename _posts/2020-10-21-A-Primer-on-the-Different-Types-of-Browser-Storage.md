---
layout: post
title: "다양한 유형의 브라우저 스토리지에 대한 Primer"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2019/03/kv-storage-devtools-source.jpg
tags: CACHE,COOKIES,INDEXEDDB,KV STORAGE,LOCALSTORAGE,PARAMETERS
---


백엔드 개발에서 스토리지는 작업의 일반적인 부분입니다. 애플리케이션 데이터는 데이터베이스에 저장되고, 파일은 객체 스토리지에 저장되고, 임시 데이터는 캐시에 저장되며, 모든 종류의 데이터를 저장할 수 있는 가능성은 무궁무진해 보입니다. 그러나 데이터 스토리지는 백엔드에만 국한되지 않습니다. 프런트 엔드(브라우저)에는 데이터를 저장할 수 있는 여러 옵션도 탑재되어 있습니다. 이 스토리지를 활용하여 애플리케이션 성능을 높이고, 사용자 기본 설정을 저장하며, 여러 세션에서 애플리케이션 상태를 유지하거나, 심지어 다른 컴퓨터에서도 애플리케이션 상태를 유지할 수 있습니다.

이 기사에서는 브라우저에 데이터를 저장할 수 있는 다양한 가능성에 대해 살펴보겠습니다. 우리는 장단점을 파악하기 위해 각 방법에 대해 세 가지 사용 사례를 다룰 것입니다. 마지막으로, 사용 사례에 가장 적합한 스토리지를 결정할 수 있습니다. 자, 시작합시다!

### 로컬 스토리지 API

로컬 스토리지는 브라우저와 많은 개발자들에게 인기 있는 스토리지 옵션 중 하나이다. 데이터는 세션에 걸쳐 저장되고 서버와 공유되지 않으며 동일한 프로토콜 및 도메인의 모든 페이지에서 사용할 수 있습니다. 저장 용량은 최대 5MB로 제한됩니다.

놀랍게도, 구글 크롬 팀은 메인 스레드를 차단하고 웹 작업자와 서비스 작업자가 접근할 수 없기 때문에 이 옵션을 사용하는 것을 권장하지 않는다. 그들은 더 나은 버전으로 KV Storage라는 실험을 시작했지만, 아직 아무데도 가지 않은 것 같은 실험이었습니다.

localStorage API는 window.localStorage로 사용할 수 있으며 UTF-16 문자열만 저장할 수 있습니다. 데이터를 로컬 스토리지로 저장하기 전에 반드시 문자열로 변환해야 합니다. 주요 세 가지 기능은 다음과 같습니다.

- set Item(`key` agram `value`)
- get Item(`key`)
- 항목 제거(`키`)

모두 동기식이어서 작업하기가 간단하지만 주 스레드를 차단합니다.

로컬 스토리지에는 세션 스토리지라는 쌍둥이 스토리지가 있다는 점을 언급할 필요가 있다. 유일한 차이점은 `sessionStorage`에 저장된 데이터는 현재 세션에서만 지속되지만 API는 동일하다는 것이다.

실제로 보자. 첫 번째 예는 사용자의 기본 설정을 저장하는 데 `localStorage`를 사용하는 방법을 보여줍니다. 우리의 경우, 그것은 우리 사이트의 어두운 테마를 켜거나 끄는 부울 속성입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_ZEWZejb" src="//codepen.io/anon/embed/ZEWZejb?height=250&amp;theme-id=1&amp;slug-hash=ZEWZejb&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed ZEWZejb" title="CodePen Embed ZEWZejb" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

확인란을 선택하고 페이지를 새로 고쳐 세션에 걸쳐 상태가 저장되었는지 확인할 수 있습니다. 저장 및 로드 기능을 확인하여 값을 문자열로 변환하는 방법과 구문 분석 방법을 확인하십시오. 문자열만 저장할 수 있다는 점을 기억해야 합니다.

이 두 번째 예는 포켓몬스터의 이름을 불러오는 것이다.API.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 350px;"><iframe id="cp_embed_ExKJwvo" src="//codepen.io/anon/embed/ExKJwvo?height=350&amp;theme-id=1&amp;slug-hash=ExKJwvo&amp;default-tab=result" height="350" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed ExKJwvo" title="CodePen Embed ExKJwvo" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

우리는 fetch를 사용하여 GET 요청을 보내고 ul 요소에 모든 이름을 나열합니다. 응답을 받는 즉시 "로컬 스토리지"에 캐슁하여 다음 번 방문이 훨씬 빨라지거나 오프라인에서 작동할 수 있습니다. 데이터를 문자열로 변환하려면 JSON.stringify를 사용하고 캐시에서 데이터를 읽으려면 JSON.parse를 사용해야 합니다.

이 마지막 예에서는 사용자가 다른 포켓몬 페이지를 탐색할 수 있는 사용 사례를 보여 주고, 다음 방문 시 현재 페이지가 저장됩니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 350px;"><iframe id="cp_embed_jOqRaBa" src="//codepen.io/anon/embed/jOqRaBa?height=350&amp;theme-id=1&amp;slug-hash=jOqRaBa&amp;default-tab=result" height="350" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed jOqRaBa" title="CodePen Embed jOqRaBa" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이 경우 localStorage의 문제는 해당 상태가 로컬로 저장된다는 것입니다. 이 동작은 우리가 원하는 페이지를 친구들과 공유하지 못하게 합니다. 나중에, 우리는 이 문제를 어떻게 극복하는지 볼 것입니다.

다음 스토리지 옵션에서도 이 세 가지 예를 사용할 것입니다. 펜스를 포크해서 관련 기능만 바꿨어요. 전체적인 골격은 모든 방법에서 동일합니다.

### 인덱스됨DB API

IndexedDB는 브라우저의 최신 스토리지 솔루션입니다. 상당한 양의 구조화된 데이터(파일 및 블로그까지)를 저장할 수 있습니다. 모든 데이터베이스와 마찬가지로 색인화됨DB는 쿼리를 효율적으로 실행하기 위해 데이터를 색인화합니다. IndexedDB를 사용하는 것이 더 복잡합니다. 데이터베이스, 테이블 및 사용 트랜잭션을 만들어야 합니다.

`localStorage`와 비교했을 때 인덱싱됨DB에는 훨씬 많은 코드가 필요합니다. 이 예에서는 Promise 래퍼와 함께 네이티브 API를 사용하지만 타사 라이브러리를 사용하여 도움을 받을 것을 적극 권장합니다. 동일한 localStorage API를 사용하지만 브라우저에서 IndexedDB를 지원하는 경우 이를 사용하고, 그렇지 않으면 localStorage로 다시 이동하므로 localForage를 추천합니다.

코드를 입력하고 사용자 기본 설정 예를 살펴보겠습니다!

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_zYqXpwv" src="//codepen.io/anon/embed/zYqXpwv?height=250&amp;theme-id=1&amp;slug-hash=zYqXpwv&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed zYqXpwv" title="CodePen Embed zYqXpwv" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

idb는 낮은 수준의 이벤트 기반 API로 작업하는 대신 사용하는 Promise 래퍼입니다. 거의 비슷하니까 걱정하지 마세요. 먼저 알아야 할 점은 데이터베이스에 대한 모든 액세스는 비동기적이라는 것입니다. 즉, 기본 스레드를 차단하지 않습니다. 로컬 스토리지와 비교하면 큰 장점이다.

앱 전체에서 읽고 쓸 수 있도록 데이터베이스에 대한 연결을 열어야 합니다. 우리는 우리의 데이터베이스에 `my-db`, 스키마 버전, 1 그리고 버전 사이에 변경 사항을 적용하기 위한 업데이트 기능을 부여한다. 이것은 데이터베이스 마이그레이션과 매우 유사합니다. 데이터베이스 스키마는 단순합니다. 개체 저장소는 하나만 `기본 설정`입니다. 개체 저장소는 SQL 테이블과 동일합니다. 데이터베이스에서 쓰거나 읽으려면 트랜잭션을 사용해야 합니다. 이것은 IndexedDB를 사용하는 지루한 부분이다. 데모의 새로운 저장 및 로드 기능을 살펴 보십시오.

틀림없이 인덱스됨DB는 로컬 스토리지에 비해 오버헤드가 훨씬 많고 학습 곡선이 가파르다. 핵심 가치 사례의 경우 생산성을 높일 수 있는 로컬 스토리지나 타사 라이브러리를 사용하는 것이 더 합리적일 수 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 350px;"><iframe id="cp_embed_WNwWMob" src="//codepen.io/anon/embed/WNwWMob?height=350&amp;theme-id=1&amp;slug-hash=WNwWMob&amp;default-tab=result" height="350" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed WNwWMob" title="CodePen Embed WNwWMob" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

우리의 포켓몬 예에서와 같은 응용 프로그램 데이터는 인덱싱된 DB의 형식이다. 이 데이터베이스에 수백 메가바이트 이상을 저장할 수 있습니다. 모든 포켓몬을 인덱싱된 DB에 저장하고 오프라인에서 사용할 수 있으며 인덱싱도 가능합니다! 앱 데이터를 저장하기 위해 선택하는 것이 분명합니다.

인덱싱된 세 번째 예제의 구현을 건너뛰었습니다.DB는 localStorage와 비교했을 때 이 경우에 어떤 차이도 주지 않는다. IndexedDB를 사용하더라도 사용자는 선택한 페이지를 다른 페이지와 공유하거나 나중에 사용할 수 있도록 책갈피로 지정하지 않습니다. 둘 다 이 사용 사례에 적합하지 않습니다.

### 쿠키

쿠키 사용은 고유한 저장소 옵션입니다. 서버와 공유되는 유일한 저장소입니다. 쿠키는 모든 요청의 일부로 전송됩니다. 사용자가 앱의 페이지를 탐색하거나 Ajax 요청을 보낼 때일 수 있습니다. 이를 통해 클라이언트와 서버 간에 공유 상태를 만들 수 있으며 서로 다른 하위 도메인의 여러 응용 프로그램 간에 상태를 공유할 수도 있습니다. 이 문서에 설명된 다른 저장소 옵션에서는 이 작업을 수행할 수 없습니다. 한 가지 주의할 점은 쿠키가 모든 요청과 함께 발송된다는 것입니다. 즉, 적절한 요청 크기를 유지하기 위해 쿠키를 작게 유지해야 한다는 것입니다.

쿠키의 가장 일반적인 용도는 인증으로, 이 문서의 범위를 벗어납니다. 로컬 스토리지처럼 쿠키도 문자열만 저장할 수 있다. 쿠키는 세미콜론으로 구분된 하나의 문자열로 연결되고 요청의 쿠키 헤더로 전송됩니다. 만료, 허용된 도메인, 허용된 페이지 등 모든 쿠키에 대해 여러 가지 속성을 설정할 수 있습니다.

예제에서 클라이언트측을 통해 쿠키를 조작하는 방법을 보여주지만, 서버측 응용프로그램에서도 쿠키를 변경할 수 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_GRZVdjo" src="//codepen.io/anon/embed/GRZVdjo?height=250&amp;theme-id=1&amp;slug-hash=GRZVdjo&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed GRZVdjo" title="CodePen Embed GRZVdjo" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

서버가 쿠키를 활용할 수 있다면 사용자의 기본 설정을 쿠키에 저장하는 것이 적합할 수 있습니다. 예를 들어 테마 사용 사례에서 서버는 관련 CSS 파일을 제공하고 잠재적인 번들 크기를 줄일 수 있습니다(서버 측 렌더링 시). 또 다른 사용 사례는 데이터베이스 없이 여러 하위 도메인 앱에서 이러한 기본 설정을 공유하는 것일 수 있습니다.

JavaScript로 쿠키를 읽고 쓰는 것은 생각보다 간단하지 않습니다. 새 쿠키를 저장하려면 `document.cookie`를 설정해야 합니다. 위의 예에서 `저장` 기능을 확인하십시오. dark_teme 쿠키를 설정하고 max-age 속성을 추가하여 탭이 닫혔을 때 만료되지 않도록 합니다. 또한 SameSite와 Secure 속성을 추가합니다. 코드 펜은 iframe을 사용하여 예를 실행하므로 이러한 작업이 필요하지만 대부분의 경우 필요하지 않습니다. 쿠키를 읽으려면 쿠키 문자열을 구문 분석해야 합니다.

쿠키 문자열은 다음과 같습니다.

```
key1=value1;key2=value2;key3=value3
```

그래서 먼저 세미콜론으로 줄을 나누어야 합니다. 이제 `key1=value1` 형식의 쿠키 배열이 있으므로 배열에서 적합한 요소를 찾아야 합니다. 결국, 우리는 같은 기호로 나누어 새 배열의 마지막 요소를 얻습니다. 다소 지루하지만 get쿠키 기능을 구현(또는 내 예:P에서 복사)하면 잊어버릴 수 있습니다.

쿠키에 응용 프로그램 데이터를 저장하는 것은 좋지 않은 생각일 수 있습니다! 요청 규모를 대폭 늘리고 애플리케이션 성능을 떨어뜨린다. 또한 서버는 데이터베이스에 이미 있는 정보의 오래된 버전이기 때문에 이 정보를 이용할 수 없습니다. 만약 당신이 쿠키를 사용한다면, 그것들을 작게 유지하세요.

페이지 지정 예제는 또한 `localStorage` 및 IndexedDB와 같이 쿠키에 적합하지 않습니다. 현재 페이지는 다른 사용자와 공유하고 싶은 임시 상태이며, 이 방법 중 어떤 방법도 이를 달성하지 못합니다.

### URL 저장

URL은 저장소가 아니지만 공유 가능한 상태를 만드는 좋은 방법입니다. 실제로 현재 상태를 재생성하는 데 사용할 수 있는 쿼리 매개 변수를 현재 URL에 추가하는 것을 의미합니다. 가장 좋은 예는 검색 질의와 필터입니다. CSS-Tricks에서 flexbox라는 용어를 검색하면 URL이 https://css-tricks.com/?s=flexbox로 업데이트됩니다. URL을 사용하면 검색 쿼리를 쉽게 공유할 수 있는지 확인하십시오. 또 다른 장점은 새로 고침 버튼을 누르면 쿼리의 새로운 결과를 얻거나 책갈피로 표시할 수 있다는 것입니다.

URL에 문자열만 저장할 수 있고 최대 길이가 제한되어 있어서 공간이 부족합니다. 우리는 주를 작게 유지해야 할 것이다. 아무도 길고 위협적인 URL을 좋아하지 않는다.

다시 CodePen은 iframe을 사용하여 예를 실행하므로 URL이 실제로 변경되는 것을 볼 수 없습니다. 걱정하지 마세요, 왜냐하면 모든 조각들이 그곳에 있기 때문에 여러분이 원하는 곳에서 그것을 사용할 수 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_oNxKymG" src="//codepen.io/anon/embed/oNxKymG?height=250&amp;theme-id=1&amp;slug-hash=oNxKymG&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed oNxKymG" title="CodePen Embed oNxKymG" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

window.location을 통해 쿼리 문자열에 액세스할 수 있습니다.검색하면 운 좋게도 URLSearch Params 클래스를 사용하여 구문 분석할 수 있다. 복잡한 문자열 구문 분석을 더 이상 적용할 필요가 없습니다. 현재 값을 읽고 싶을 때 get 기능을 사용할 수 있습니다. 쓰기를 원할 때는 set를 사용하면 된다. 값을 설정하는 것만으로는 충분하지 않습니다. URL도 업데이트해야 합니다. 이것은 우리가 이루고자 하는 행동에 따라 `history.pushState`나 `history.placeState`를 사용하여 할 수 있다.

사용자가 방문하는 모든 URL에 이 상태를 추가해야 하고 사용자가 Google 검색의 링크를 클릭하는 경우 등 이 상태를 보장할 수 없으므로 URL에 사용자의 기본 설정을 저장하는 것을 권장하지 않습니다.

쿠키와 마찬가지로, 최소한의 공간이 있기 때문에 URL에 응용 프로그램 데이터를 저장할 수 없습니다. 그리고 비록 우리가 그것을 저장했다 하더라도, URL은 길어서 클릭하도록 초대하지 않을 것입니다. 일종의 피싱 공격처럼 보일 수 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 350px;"><iframe id="cp_embed_jOqgpOO" src="//codepen.io/anon/embed/jOqgpOO?height=350&amp;theme-id=1&amp;slug-hash=jOqgpOO&amp;default-tab=result" height="350" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed jOqgpOO" title="CodePen Embed jOqgpOO" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

페이지 지정 예제와 마찬가지로 임시 응용 프로그램 상태는 URL 쿼리 문자열에 가장 적합합니다. URL은 변경되지 않지만 URL은 페이지를 클릭할 때마다 `?page=x` 쿼리 매개 변수로 업데이트됩니다. 웹 페이지가 로드되면 이 쿼리 매개 변수를 찾고 그에 따라 오른쪽 페이지를 가져옵니다. 이제 우리는 이 URL을 우리의 친구들과 공유할 수 있어서 그들이 우리가 좋아하는 포켓몬을 즐길 수 있습니다.

### 캐시 API

캐시 API는 네트워크 수준의 저장소입니다. 네트워크 요청 및 응답을 캐시하는 데 사용됩니다. 캐시 API는 서비스 직원에 완벽하게 맞습니다. 서비스 작업자는 모든 네트워크 요청을 가로챌 수 있으며, 캐시 API를 사용하여 두 요청을 모두 쉽게 캐시할 수 있습니다. 또한 서비스 작업자는 기존 캐시 항목을 서버에서 가져오는 대신 네트워크 응답으로 반환할 수 있습니다. 이렇게 하면 오프라인에서도 네트워크 로드 시간을 줄이고 응용 프로그램을 작동할 수 있습니다. 원래는 서비스 근로자를 위해 만들어졌지만, 현대의 브라우저에서는 캐시 API를 창, iframe, worker 컨텍스트에서도 사용할 수 있다. 애플리케이션 사용자 환경을 획기적으로 개선할 수 있는 매우 강력한 API입니다.

인덱싱된 것처럼DB 캐시 API 저장소는 제한되지 않으며, 필요한 경우 수백 메가바이트 이상을 저장할 수 있습니다. API가 비동기적이므로 주 스레드를 차단하지 않습니다. 그리고 그것은 세계적인 부동산인 `캐시`를 통해 접근할 수 있다.

캐시 API에 대해 자세히 알아보기 위해 Google Chrome 팀은 훌륭한 튜토리얼을 만들었습니다.

Chris는 서비스 직종과 캐시 API를 결합하는 실제 사례를 통해 멋진 펜을 만들었습니다.

### 보너스: 브라우저 확장

브라우저 확장을 빌드하는 경우 데이터를 저장하는 다른 옵션이 있습니다. 내 확장자 daily.dev를 사용하다가 발견했어. Mozilla의 polyfill을 사용하는 경우 `chrome.storage` 또는 `browser.storage`를 통해 사용할 수 있습니다. 액세스 권한을 얻으려면 매니페스트에 저장 권한을 요청해야 합니다.

저장소 옵션에는 로컬 및 동기화의 두 가지 유형이 있습니다. 로컬 스토리지는 자동으로 설명됩니다. 즉, 로컬에서 공유 및 보관되지 않습니다. 동기화 저장소는 Google 계정의 일부로 동기화되며, 확장을 설치할 때마다 이 저장소가 동기화됩니다. 나한테 물어보면 꽤 멋진 모습이야. 둘 다 API가 동일하기 때문에 필요할 경우 앞뒤로 전환하기가 매우 쉽습니다. 비동기식 스토리지이므로 `localStorage`와 같은 메인 스레드를 차단하지 않습니다. 유감스럽게도 이 스토리지 옵션에 대한 데모를 만들 수 없습니다. 브라우저 확장이 필요하지만 사용하기가 매우 간편하고 거의 `localStorage`와 비슷하기 때문입니다. 정확한 구현에 대한 자세한 내용은 Chrome 문서를 참조하십시오.

### 결론

브라우저에는 데이터를 저장하는 데 사용할 수 있는 여러 가지 옵션이 있습니다. Chrome 팀의 조언에 따라 당사의 기본 스토리지는 IndexedDB가 되어야 합니다. 원하는 모든 것을 저장할 수 있는 충분한 공간이 있는 비동기식 스토리지입니다. 로컬 스토리지는 권장되지 않지만 IndexedDB보다 사용하기 쉽습니다. 쿠키는 서버와 클라이언트 상태를 공유하는 좋은 방법이지만 대부분 인증에 사용됩니다.

검색 페이지와 같이 공유 가능한 상태의 페이지를 작성하려면 URL의 쿼리 문자열을 사용하여 이 정보를 저장합니다. 마지막으로, 확장 기능을 구축하는 경우 "chrome.storage"에 대해 읽어보십시오.