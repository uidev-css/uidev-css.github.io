---
layout: post
title: "잼 스택을 느리게 만들 수 있습니까? 도전 수락됨."
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/07/jamstack-snail.png"
tags: JAMSTACK,LIGHTHOUSE,PERFORMANCE
---


"Jamstack은 느린 wwww." 그런 말 자주 듣는 거 아니죠? 특히, Jamstack의 주요 판매 포인트 중 하나가 성능입니다. 하지만 Jamstack 사이트도 다른 사이트와 마찬가지로 성능에 타격을 입을 수 있습니다.

Jamstack을 선택함으로써 성능에 대해 더 이상 생각할 필요가 없다고 생각하지 마십시오. Jamstack은 매우 빠를 수 있지만 올바른 선택을 해야 합니다. Jamstack 사이트를 "느리게" 만들 수 있는 몇 가지 잘못된 결정을 찾을 수 있는지 확인해 보겠습니다.

그러기 위해서, 우리는 정말 느린 개츠비 사이트를 만들 것입니다. 이상한 것 같죠? 왜 우리가 고의로 그런 짓을 했을까? 이러한 방식을 통해 Jamstack 성능에 미치는 영향과 병목 현상을 방지하는 방법에 대해 더 잘 이해할 수 있을 것입니다.

지속적인 성능 테스트와 Google Lighthouse를 사용하여 모든 변경 사항을 감사할 것입니다. 이는 모든 코드 변경 테스트의 중요성을 강조합니다. 저희 사이트는 등대 최고점수 100점으로 시작할 것입니다. 거기서부터 우리는 17점 만점에 도달할 때까지 변화를 줄 것이다. 그것은 여러분이 생각하는 것보다 더 쉽습니다!

시작해 봅시다!

### Jamstack 사이트 생성

우리는 개츠비를 시험장에 사용할 것이다. 먼저 설치된 Gatsby CLI를 살펴보겠습니다.

```terminal
npm install -g gatsby-cli
```

우리는 이 명령을 사용하여 새로운 개츠비 사이트를 개설할 수 있다.

```terminal
gatsby new slow-jamstack
```

slow-jamstack 프로젝트 디렉터리에 cd를 넣고 개발 서버를 시작하겠습니다.

```html
cd slow-jamstack
gatsby develop
```

Lighthouse를 혼합물에 추가하기 위해서는 개츠비 제작이 필요하다. 우리는 Vercel을 사용하여 사이트를 호스팅할 수 있습니다. Lighthouse가 테스트를 진행할 수 있는 방법을 제공합니다. 이를 위해서는 Vercel 명령줄 도구를 설치하고 로그인해야 합니다.

```terminal
npm install -g vercel-cli
vercel
```

이렇게 하면 Vercel에 사이트가 생성되어 라이브 서버에 저장됩니다. 다음은 테스트에 사용할 이미 설정한 예제입니다.

Chrome을 사용하여 DevTools에서 직접 액세스하고 성능 감사를 실행해야 합니다. 기본 개츠비 사이트는 빠른 것이 당연하다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/07/image.jpeg?resize=1196%2C1053&ssl=1)

100점이면 가장 빨리 받을 수 있어요. 속도를 늦추기 위해 우리가 할 수 있는 것을 봅시다.

### 느린 CSS

CSS 프레임워크는 훌륭하다. 그들은 여러분을 위해 무거운 물건을 많이 들 수 있습니다. CSS 프레임워크를 결정할 때 모듈식 또는 CSS-in-JS를 사용하는 것을 사용하여 필요한 유일한 CSS가 로드된 것이 되도록 합니다.

하지만 버튼 구성 요소를 스타일링하기 위해 전체 프레임워크에 도달하는 잘못된 결정을 내리도록 합시다. 사실, 우리가 하는 동안 가장 무거운 틀을 잡자. 다음은 널리 사용되는 몇 가지 프레임워크의 크기입니다.

좋아, 시맨틱UI입니다! 이 프레임워크를 로드하는 "올바른" 방법은 필요한 프레임워크의 일부를 선택할 수 있는 Sass 또는 Less 패키지를 사용하는 것입니다. 잘못된 방법은 모든 CSS 및 JavaScript 파일을 HTML의 `<head>`에 로드하는 것입니다. 이것이 전체 시맨틱을 사용하여 수행할 작업입니다.UI 스타일시트. 또한 의미론적이기 때문에 jQuery를 연결할 것입니다.UI 종속성.

우리는 머리 속에 파일에 하중이 `html.js의 파일 안에의 점프도록 합시다. 다음 명령을 실행하여 캐시에서 기본값을 복사하기 전에는 `src` 디렉토리에서 이 기능을 사용할 수 없습니다.

```terminal
cp .cache/default-html.js src/html.js
```

src 디렉토리에서 html.js를 제공한다. 이 페이지를 열고 필요한 스타일시트와 스크립트를 추가합니다.

```html
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.css"></link>
<script src="https://code.jquery.com/jquery-3.1.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.js"></script>  
```

이제 변경 내용을 프로덕션 URL로 바로 푸시하겠습니다.

```terminal
vercel --prod
```

자, 이제 감사 내용을 살펴보겠습니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/07/image-1.jpeg?resize=1199%2C1046&ssl=1)

우리는 사이트의 속도를 66점으로 줄였습니다. 우리는 지금 이 프레임워크조차 사용하지 않고 있다는 것을 기억하세요. 우리가 한 일은 파일을 헤드에 로드하는 것 뿐이고, 그 결과 성능 점수가 1/3로 떨어졌습니다. 우리의 TTI(Time to Interactive)는 1.9초의 빠른 시간에서 4.9초의 놀라운 시간으로 뛰어올랐다. 그리고 Lighthouse의 추천을 통해 얻을 수 있는 가능한 절감 효과를 보세요.

### 느린 마케팅 의존성

다음으로, 마케팅 태그와 이러한 타사 스크립트가 성능에 어떤 영향을 미칠 수 있는지 살펴보겠습니다. 마케팅 부서와 협력하면 Google Analytics로 트래픽 측정을 시작하려고 합니다. 그들은 또한 페이스북 캠페인을 벌이고 그것을 추적하기를 원한다.

그들은 우리가 모든 것을 작동시키기 위해 추가해야 할 스크립트의 세부 사항을 우리에게 알려준다. 첫째, Google Analytics의 경우:

```html
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-4369823-4"></script>
<script
  dangerouslySetInnerHTML={ __html: `
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'UA-4369823-4');
  `}
/>
```

그러면 Facebook 캠페인을 위해:

```html
<script
  dangerouslySetInnerHTML={ __html: `
    !function(f,b,e,v,n,t,s)
    {if(f.fbq)return;n=f.fbq=function(){n.callMethod?
    n.callMethod.apply(n,arguments):n.queue.push(arguments)};
    if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
    n.queue=[];t=b.createElement(e);t.async=!0;
    t.src=v;s=b.getElementsByTagName(e)[0];
    s.parentNode.insertBefore(t,s)}(window, document,'script',
    'https://connect.facebook.net/en_US/fbevents.js');
    fbq('init', '3180830148641968');
    fbq('track', 'PageView');
    `}
/>

<noscript><img height="1" width="1" src="https://www.facebook.com/tr?id=3180830148641968&ev=PageView&noscript=1"/></noscript>
```

이 스크립트는 닫기 전에 </ 섹션에 있는 html.js 내부에 배치할 것입니다.

전과 마찬가지로 베르셀에 가서 등대를 다시 운영해 봅시다.

```terminal
vercel --prod
```

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/07/image-2.jpeg?resize=1200%2C1047&ssl=1)

와, 사이트는 이미 51개로 줄었고 우리가 한 건 한 가지 프레임워크와 몇 가지 간단한 스크립트뿐이야. 다 합쳐서 49점이라는 엄청난 점수를 줄였는데, 우리가 시작한 곳의 거의 절반에 가까운 점수였다.

### 느린 이미지

아직 사이트에 이미지를 추가하지는 않았지만, 실제 시나리오에서는 반드시 그럴 것이라는 것을 알고 있습니다. 우리는 그 페이지에 100개의 이미지를 추가할 것입니다. 물론, 100은 한 페이지에 많은 양이지만, 우리는 이미지가 종종 부풀어 오른 웹 페이지의 가장 큰 원인이라는 것을 알고 있기 때문에 우리는 그것들을 빛나게 하는 편이 낫습니다.

우리는 https://placeimg.com에서 직접 이미지를 핫로딩함으로써 상황을 조금 더 악화시킬 것입니다.

index.js를 열고 이 코드를 삭제하여 100개의 이미지 인스턴스를 순환합니다.

```js
const IndexPage = () => {
  const items = []
  for(var i = 0; i < 100; i++) {
    const url = `http://placeimg.com/640/360/any?=${i}`
    items.push(<img key={i} alt={i} src={url} />)
  }
  
  return (
    <Layout>
      // ...
      {items}
      // ...
    </Layout>
  )
}
```

100개의 이미지가 모두 다르며 페이지가 로드되면 모두 로드되어 렌더링이 차단됩니다. 좋아, 베르셀에게 가서 무슨 일인지 보자.

```terminal
vercel --prod
```

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/07/image-3.jpeg?resize=1024%2C893&ssl=1)

이제 매우 느린 Jamstack 사이트가 생겼습니다. 이미지가 페이지 렌더링을 차단하고 있으며 TTI는 현재 무려 16.5초입니다. 우리는 매우 빠른 Jamstack 사이트를 방문하여 Lighthouse 점수인 17점으로 83점 감점했습니다!

이제, 여러분은 앱을 만들 때 이런 형편없는 결정을 내리지 않을 것이라고 생각할지도 모릅니다. 그러나 당신은 요점을 놓치고 있다. 우리가 하는 모든 선택은 성능에 영향을 미칩니다. 그것은 균형이고 성능은 자유롭지 못하다. 심지어 Jamstack 사이트에서도.

### Jamstack을 다시 빠르게 만들기

Jamstack을 사용할 때 클라이언트측 성능을 무시할 수 없다는 것을 확인했습니다.

그러면 왜 사람들은 Jamstack이 빠르다고 말할까요? 일반적으로 정적 사이트 생성기를 사용하는 Jamstack의 주요 이점은 캐싱입니다. 정적 파일은 TTFB(Time to First Byte)를 줄이는 에지에 캐시됩니다.

페이지를 생성하기 전에 단일 오리진 웹 서버로 이동하는 것보다 항상 빠릅니다. 이것은 Jamstack의 훌륭한 특징이며 Lighthouse에서 100을 칠 수 있는 페이지를 만들 수 있는 좋은 기회를 제공합니다. (하지만, 참고로, 좋은 점수가 항상 실제 사용자 경험을 나타내는 것은 아닙니다.)

내가 잼스택을 느리게 만들 수 있다고 했잖아! 속도를 늦출 수 있는 다른 많은 것들이 있습니다. 하지만 이것이 핵심을 향해 나아가길 바랍니다.

성능에 대해 이야기하는 동안 CSS-Tricks에서 가장 좋아하는 성능 관련 기사 몇 가지를 소개합니다.

- 게으른 이미지 로딩에 대한 전체 가이드
- CSS-in-JS에 대한 다양한 관점
- 타사 스크립트