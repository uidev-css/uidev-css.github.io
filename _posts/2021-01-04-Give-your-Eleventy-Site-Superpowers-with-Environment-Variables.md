---
layout: post
title: "환경 변수를 사용하여 Eleventy 사이트에 슈퍼 파워 제공"
author: "CSS Dev"
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/12/eleventy-env-fun-mode.png
tags: ELEVENTY ENVIRONMENT VARIABLES
---

Eleventy는 멋지고 간단한 웹 사이트를 만들 수 있기 때문에 인기가 높아지고 있습니다. 또한 개발자 친화적이기 때문입니다.
우리는 그것으로 대규모의 복잡한 프로젝트도 만들 수 있습니다.
이 튜토리얼에서 우리는 강력하고 인간 친화적 인 환경 변수 솔루션을 결합하여 확장 된 기능을 보여줄 것입니다.

### 환경 변수 란 무엇입니까?

환경 변수는 코드가 자신을 찾는 환경 내에서 정의되는 편리한 변수 / 구성 값입니다.

예를 들어 WordPress 사이트가 있다고 가정 해 보겠습니다. 라이브 사이트의 한 데이터베이스에 연결하고 스테이징 및 로컬 사이트에 대해 다른 데이터베이스에 연결하려고 할 것입니다.
이러한 값을`wp-config.php`에 하드 코딩 할 수 있지만 연결 세부 정보를 비밀로 유지하고 Git과 같은 소스 제어에서 코드를 쉽게 유지하는 좋은 방법은 코드에서 이러한 값을 정의하는 것입니다.

다음은 하드 코딩 된 값이있는 표준판 WordPress`wp-config.php` 스 니펫입니다.

```php
<?php

define( 'DB_NAME', 'my_cool_db' );
define( 'DB_USER', 'root' );
define( 'DB_PASSWORD', 'root' );
define( 'DB_HOST', 'localhost' );
```

`wp-config.php` 파일의 동일한 예제를 사용하여 phpdotenv와 같은 도구를 도입하고 대신 다음과 같이 변경하고 코드에서 값을 정의 할 수 있습니다.

```php
<?php

$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

define( 'DB_NAME', $_ENV['DB_NAME'] );
define( 'DB_USER', $_ENV['DB_USER'] );
define( 'DB_PASSWORD', $_ENV['DB_PASSWORD'] );
define( 'DB_HOST', $_ENV['DB_HOST'] );
```

이러한 환경 변수 값을 정의하는 방법은 소스 제어에서 일반적으로 무시되는 텍스트 파일 인`.env` 파일을 사용하는 것입니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_18B5305DD73B93DCECD2B6B8D1FCED695BA525F0324EA16E93606B0F2506A622_1607713183163_0_zvyKJDoh3Ur1Bp20.png?resize=674%2C212&ssl=1)

그런 다음 dotenv 또는 phpdotenv와 같은 도구를 사용하여 기본적으로 코드에서 사용할 수없는 이러한 값을 파악합니다.
dotenv와 같은 도구는`.env` 파일, Docker 스크립트 또는 배포 스크립트에서 이러한 변수를 정의 할 수 있기 때문에 매우 유용합니다.이 변수는 제가 가장 좋아하는 도구 유형입니다.

소스 제어 ( `.gitignore`를 통해)에서이를 무시하는 경향이있는 이유는 종종 비밀 키 또는 데이터베이스 연결 정보를 포함하기 때문입니다.
이상적으로는 세부 정보를 최대한 안전하게 유지하기 위해 GitHub와 같은 원격 저장소에서 멀리 유지하는 것이 좋습니다.

### 시작하기

verified_user

이 튜토리얼에서는 약간의 시간을 절약하기 위해 몇 가지 시작 파일을 만들었습니다.
우리를 위해 지루한 부분을 모두 갖춘 기본, 베어 본 Eleventy 사이트입니다.

이 튜토리얼의 1 단계는 시작 파일을 다운로드하고 작업하려는 위치에 압축을 푸는 것입니다.
파일의 압축이 풀리면 터미널에서 폴더를 열고`npm install`을 실행합니다.
그런 다음`npm start`를 실행합니다.
`http : // localhost : 8080`에서 브라우저를 열면 다음과 같이 표시됩니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/12/11ty-env-ss-1-scaled.jpg?resize=2560%2C1650&ssl=1)

또한 설정하는 동안`.env`라는 비어있는 새 파일을 만들고 기본 파일 폴더의 루트에 추가합니다.

### 친숙한 인터페이스 만들기

환경 변수는 모두 대문자를 사용하기 때문에 종종 매우 우스꽝 스럽습니다.
제가 선호하는 것은 이러한 값을 사용하고이를 인간 친화적이고 네임 스페이스로 내보내는 자바 스크립트 인터페이스를 만드는 것입니다. 따라서 환경 변수를 사용중인 코드를 보면 알 수 있습니다.

`.env` 파일에 정의되어있을 수있는`HELLO = hi there`와 같은 값을 사용하겠습니다.
이에 액세스하기 위해 우리는 몇 번의 호출 후 약간 지루 해지는`process.env.HELLO`를 사용합니다.
그 값이 정의되어 있지 않으면 어떻게 될까요?
이러한 시나리오에 대한 대체 방법을 제공하는 것이 편리합니다.
JavaScript 설정을 사용하면 다음과 같은 일을 할 수 있습니다.

```js
require("dotenv").config();

module.exports = {
    hello: process.env.HELLO || "Hello not set, but hi, anyway 👋"
};
```

여기서 수행하는 작업은 해당 환경 변수를 찾고 필요한 경우 OR 연산자 (`||`)를 사용하여 정의되지 않은 경우 값을 반환하는 기본값을 설정하는 것입니다.
그런 다음 템플릿에서`env.hello`를 수행 할 수 있습니다.

이제이 기술이 어떻게 작동하는지 알았으니 실행 해 보겠습니다.
시작 파일 폴더에는 빈`env.js` 파일이있는`src / _data`라는 디렉토리가 있습니다.
그것을 열고 다음 코드를 추가하십시오.

```js
require("dotenv").config();

module.exports = {
    otherSiteUrl: process.env.OTHER_SITE_URL || "https://eleventy-env-vars-private.netlify.app",
    hello: process.env.HELLO || "Hello not set, but hi, anyway 👋"
};
```

데이터 파일이`env.js`이기 때문에`env` 접두사를 사용하여 템플릿에서 액세스 할 수 있습니다.
환경 변수 앞에`environment`를 붙이려면 데이터 파일의 이름을`environment.js`로 변경합니다.
Eleventy 문서에서 더 많은 것을 읽을 수 있습니다.

여기에 `hello`값이 있으며, 환경 변수 구성에 따라 사람들이 사이트의 다른 버전을 볼 수 있도록하는 데 사용하는 `otherSiteUrl`값도 있습니다.
이 설정은 JavaScript를 실행하고 출력을 정적 데이터로 반환 할 수있는 Eleventy JavaScript 데이터 파일을 사용합니다.
비동기 코드도 지원합니다!
이 JavaScript 데이터 파일은 아마도 제가 가장 좋아하는 Eleventy 기능 일 것입니다.

이제이 자바 스크립트 인터페이스를 설정 했으므로 콘텐츠로 이동하여 몇 가지 변수를 구현해 보겠습니다.
`src / index.md`를 열고 파일 하단에 다음을 추가합니다.

```nunjucks
Here’s an example: The environment variable, HELLO is currently: “ env.hello ”. This is called with { raw }env.hello { endraw }.

```

꽤 멋지죠?
Eleventy를 통해 콘텐츠에서 이러한 변수를 바로 사용할 수 있습니다!
이제`.env` 파일에서`HELLO` 값을 정의하거나 변경하고`npm start` 작업을 다시 시작하면 콘텐츠 업데이트가 표시됩니다.

이제 사이트가 다음과 같이 표시됩니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/12/11ty-env-ss-2-scaled.jpg?resize=2560%2C1650&ssl=1)

도대체`{ raw }`가 무엇인지 궁금 할 것입니다.
무시해야 할 영역을 정의 할 수있는 Nunjucks 태그입니다.
그것이 없으면 Nunjucks는`env.hello`부분을 평가하려고 할 것입니다.

### 이미지 기본 경로 수정

우리가 한 첫 번째 예는 멋졌지만이 접근 방식이 어떻게 유용 할 수 있는지 살펴 보겠습니다.
종종 프로덕션 이미지에 일종의 CDN이 표시되기를 원하지만 사이트를 개발할 때 이미지가 로컬에서 실행되기를 원할 수도 있습니다.
이것이 의미하는 바는 성능 및 다양한 이미지 형식 지원을 돕기 위해 종종 CDN을 사용하여 이미지를 제공하고 이러한 CDN은 종종`/ images` 폴더와 같은 사이트에서 직접 이미지를 제공합니다.
이것이 ImgIX를 사용하여 Piccalilli에서 수행하는 작업이지만 이러한 CDN은 사이트의 로컬 버전에 액세스 할 수 없습니다.
따라서 CDN과 로컬 이미지 사이를 전환 할 수있는 것이 편리합니다.

이 문제에 대한 해결책은 환경 변수에서 거의 사소한 것입니다. 특히 Eleventy 및 dotenv에서는 환경 변수가 사용 시점에 정의되어 있지 않으면 오류가 발생하지 않기 때문입니다.

`src / _data / env.js`를 열고 다음 속성을 객체에 추가합니다.

```js
imageBase: process.env.IMAGE_BASE || '/images/',
imageProps: process.env.IMAGE_PROPS,
```

`/ images /`의`imageBase`에 기본값을 사용하여`IMAGE_BASE`가 정의되지 않은 경우 로컬 이미지를 찾을 수 있습니다.
필요하지 않는 한 비어있을 수 있기 때문에`imageProps`에 대해 동일한 작업을 수행하지 않습니다.

`_includes / base.njk`를 열고`<h1> {title} </ h1>`비트 뒤에 다음을 추가합니다.

```html
<img src=" env.imageBase  mountains.jpg  env.imageProps " alt="Some lush mountains at sunset" />
```

기본적으로 이것은`/ images / mountains.jpg`를로드합니다.
멋있는!
이제`.env` 파일을 열고 다음을 추가합니다.

```js
IMAGE_BASE=https://assets.codepen.io/174183/
IMAGE_PROPS=?width=1275&height=805&format=auto&quality=70
```

Eleventy를 중지 (터미널에서 `Ctrl`+ `C`) 한 다음 `npm start`를 다시 실행 한 다음 브라우저에서 소스를 보면 렌더링 된 이미지가 다음과 같아야합니다.

```html
<img src="https://assets.codepen.io/174183/mountains.jpg?width=1275&height=805&format=auto&quality=70" alt="Some lush mountains at sunset" />
```

즉, 필요할 때만 CodePen 자산 최적화를 활용할 수 있습니다.

### Eleventy로 개인 및 프리미엄 콘텐츠 강화

환경 변수를 사용하여 개인 모드와 같은 모드를 기반으로 콘텐츠를 조건부로 렌더링 할 수도 있습니다.
이 기능은 개인적으로 중요한 기능입니다. 왜냐하면 비용을 지불 한 사람들에게만 프리미엄 콘텐츠를 보여주는 Eleventy가 제공하는 Eleventy Course와 CSS 책이 있기 때문입니다.
서비스 워커 및 API를 사용하면 모든 종류의 기술 마법이 뒤에서 일어나고 있지만 핵심은 콘텐츠가 JavaScript 인터페이스의 `env.mode`를 기반으로 조건부로 렌더링 될 수 있다는 것입니다.

이제 예제에 추가해 보겠습니다.
`src / _data / env.js`를 열고 다음을 객체에 추가합니다.

```js
mode: process.env.MODE || "public";
```

이 설정은 기본적으로 `모드`가 공개됨을 의미합니다.
이제`src / index.md`를 열고 파일 하단에 다음을 추가합니다.

```nunjucks
{ if env.mode === 'private' }

## This is secret content that only shows if we’re in private mode.

This is called with { raw }` env.mode `{ endraw }. This is great for doing special private builds of the site for people that pay for content, for example.
```

로컬 버전을 새로 고침하면 방금 추가 한 콘텐츠를 볼 수 없습니다.
이것은 우리에게 완벽하게 작동합니다. 특히 우리가 그것을 보호하기를 원하기 때문입니다.
이제 환경 변수를 사용하여 보여 드리겠습니다.
`.env`를 열고 다음을 추가하십시오.

```js
MODE = private;
```

이제 Eleventy를 다시 시작하고 사이트를 다시로드하십시오.
이제 다음과 같은 내용이 표시됩니다.

![image](https://i1.wp.com/assets.codepen.io/174183/11ty-env-ss-3.jpg?ssl=1)

템플릿 내에서도이 조건부 렌더링을 실행할 수 있습니다.
예를 들어 모든 페이지 콘텐츠를 비공개로 만들고 대신 페이 월을 렌더링 할 수 있습니다.
예를 들어 라이선스없이 내 과정에 가면 구매를위한 클릭 유도 문안이 표시됩니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/12/11ty-env-ss-4-scaled.jpg?resize=2560%2C1650&ssl=1)

### 펀 모드

지금까지 정말 유용한 콘텐츠 였으면 좋겠습니다. 지금까지 배운 내용을 확장하고 재미있게 즐겨보세요!

디자인을 좀 더 재미있는 것으로 완전히 바꾸는 "재미 모드"를 만들어 마무리하고 싶습니다.
`src / _includes / base.njk`를 열고 닫는`</ head>`태그 바로 앞에 다음을 추가합니다.

```html
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Lobster&display=swap" />
<style>
    body {
        font-family: "Comic Sans MS", cursive;
        background: #fc427b;
        color: #391129;
    }
    h1,
    .fun {
        font-family: "Lobster";
    }
    .fun {
        font-size: 2rem;
        max-width: 40rem;
        margin: 0 auto 3rem auto;
        background: #feb7cd;
        border: 2px dotted #fea47f;
        padding: 2rem;
        text-align: center;
    }
</style>
```

이 스 니펫은 `funMode`환경 변수가 `true`인지 확인하고, 그렇다면 `재미있는`CSS를 추가합니다.

여전히`base.njk`에서 여는`<article>`태그 바로 앞에 다음 코드를 추가합니다.

```html
<div class="fun">
    <p>🎉 <strong>Fun mode enabled!</strong> 🎉</p>
</div>
```

이 코드는 동일한 로직을 사용하고 `funMode`가 `true`인 경우 재미있는 배너를 렌더링합니다.
이를위한 환경 변수 인터페이스를 만들어 보겠습니다.
`src / _data / env.js`를 열고 내 보낸 객체에 다음을 추가합니다.

```js
funMode: process.env.FUN_MODE;
```

`funMode`가 정의되지 않은 경우 `undefined`는 잘못된 값이므로 `false`로 작동합니다.

다음으로`.env` 파일을 열고 다음을 추가합니다.

```js
FUN_MODE = true;
```

이제 Eleventy 작업을 다시 시작하고 브라우저를 다시로드하십시오.
다음과 같이 표시되어야합니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/12/11ty-env-ss-5-scaled.jpg?resize=2560%2C1650&ssl=1)

꽤 시끄 럽죠?!
이 디자인이 꽤 끔찍해 보이지만 (rad : 읽기)이 환경 설정으로 얼마나 많이 변경할 수 있는지 보여 주길 바랍니다.

### 마무리

verified_user

모든 차이점을 확인하기 위해 동일한 코드를 실행하는 동일한 사이트의 세 가지 버전을 만들었습니다.

-   표준 사이트
-   비공개 콘텐츠 표시
-   펀 모드

이러한 모든 사이트는 동일한 코드로 구동되며 각 사이트의 유일한 차이점은이 예에서는 Netlify 대시 보드에서 정의한 환경 변수입니다.

이 기술이 최고의 정적 사이트 생성기 인 Eleventy를 사용하여 모든 종류의 가능성을 열어 주길 바랍니다!
