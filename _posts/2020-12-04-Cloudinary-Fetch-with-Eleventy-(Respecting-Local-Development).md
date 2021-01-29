---
layout: post
title: "Eleventy를 사용한 Cloudinary Fetch (지역 개발 존중)
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/11/eleventy-cloudinary.png
tags: CLOUDINARY,ELEVENTY
---


이것은 당신이 궁극적으로 Cloudinary에서 호스팅하기를 원하는 이미지가있는 페이지가있는 정적 사이트 생성기 인 Eleventy와 같은 엄청나게 구체적인 기술 조합에 관한 것입니다.하지만이 상황에 처한 사람들이 상당히 많은 것처럼 들리므로 문서화하고 싶습니다.
 .
 

거래:
 verified_user

- Cloudinary에는 URL 가져 오기 기능이 있으므로 서비스를 사용하기 위해 실제로 아무것도 배울 필요가 없습니다 (좋아요!).
 계정이 있어야하지만 그 후 이미지에 Cloudinary URL을 접두사로 붙이면 Cloudinary가 이미지를 최적화, 크기 조정, 형식화하고 CDN이 이미지를 제공합니다.
 단.
 이를 수행하는 유일한 서비스는 아니지만 좋은 서비스입니다.
 
- 하지만… 이미지는 라이브 공용 인터넷에 있어야합니다.
 개발 중에는 이미지 URL이 아닐 수 있습니다.
 로컬에 저장되었을 가능성이 높습니다.
 따라서 이상적으로는 개발중인 이미지에 로컬 URL을 계속 사용하고 프로덕션에서 Cloudinary 가져 오기를 수행 할 수 있습니다.
 

여러 사람이이 문제를 다른 방법으로 해결했습니다.
 내가 어떻게했는지 (내가 가장 잘 이해하기 때문에) 문서화 할 것입니다. 또한 다른 여러 사람이 어떻게 했는지도 연결합니다 (더 똑똑 할 수 있습니다. 당신이 판사입니다).
 

목표:
 verified_user

- 개발시 이미지는`/ images / image.png`와 같습니다.
 
- 프로덕션에서 이미지는`https : //res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https : // production-website.com / images / image.png`와 같습니다.
 

따라서 템플릿을 사용하면 (여기에서 Nunjucks가 Eleventy가 지원하는 멋진 템플릿 언어라고 가정 해 보겠습니다) 다음과 같은 의사 코드를 얻게됩니다.
 

```html
<img src="
  {{CLOUDINARY_PREFIX}}{{FULLY_QUALIFIED_PRODUCTION_URL}}{{RELATIVE_IMAGE_URL}}
  "
  alt="Don't screw this up, fam."
/>
```

트릭은 그것들을 얻는 것입니다. 우리는 그것들을 전역 변수라고 부르겠습니까?… 설정합니다.
 아마도 처음 두 개일 것입니다.
 필요에 따라 손으로 작성하는 상대 이미지 경로입니다.
 

Eleventy는이를 위해 사용할 수있는 몇 가지 마법을 가지고 있습니다.
 `_data` 폴더에 넣은`* .js` 파일은 템플릿에서 사용할 수있는 변수로 바뀝니다.
 그래서 우리가`/ src / _data / sandwiches.js`처럼 만들면 다음과 같습니다.
 

```js
module.exports = {
  ham: true
}
```

템플릿에서`{{sandwiches.ham}}`를 사용할 수 있으며`{{true}}`로 정의됩니다.
 

이것은 JavaScript (노드)이기 때문에 다른 변수를 기반으로 일부 로직을 수행 할 수있는 능력이 있음을 의미합니다.
 우리의 경우 다른 전역 변수, 특히 Node가 제공하는`process.env` 변수가 유용합니다.
 많은 호스트 (Netlify, Vercel 등)는 "환경 변수"를 시스템에서 설정할 수있는 것으로 만들어서`process.env`가 시스템에서 빌드 프로세스를 실행할 때 사용할 수 있도록합니다.
 우리는 그렇게 할 수 있지만 그것은 다소 구체적이고 해당 호스트와 관련이 있습니다.
 Node 전역 변수를 설정하는 또 다른 방법은 명령을 실행하기 전에 명령 줄에서 문자 그대로 설정하는 것입니다.
 

```html
SANDWICH="ham" eleventy
```

그러면`process.env.SANDWICH`는 Node JavaScript의 모든 위치에서`ham`이됩니다.
 이 모든 것을 결합하여… 프로덕션 빌드 프로세스가 다음과 같이 프로덕션을 나타내는 변수를 설정한다고 가정 해 보겠습니다.
 

```js
PROD="true" eleventy
```

하지만 로컬 개발에서는 전역 변수없이 실행됩니다.
 따라서 이미지 소스를 구성하는 데 사용할 전역 변수를 설정하는 동안이 정보를 활용 해 보겠습니다.
 `/ src / _data / images.js` (전체 실제 예)에서 다음을 수행합니다.
 

```js
module.exports = {

  imageLocation:
    process.env.PROD === 'true' 
      ? 'https://coding-fonts.css-tricks.com' 
      : '',

  urlPrefix:
    process.env.PROD === 'true'
      ? 'https://res.cloudinary.com/css-tricks/image/fetch/w_1600,q_auto,f_auto/'
      : ''

};
```

또한 논리를 어떤 방식 으로든 변경하려는 경우`process.env.CONTEXT === `deploy-preview``를 확인하여 Netlify 배포 미리보기 URL을 테스트 할 수 있습니다.
 

이제 모든 템플릿에서`{{images.imageLocation}}`및`{{images.urlPrefix}}`를 사용하여 소스를 구축 할 수 있습니다.
 

```html
<img 
  src="
    {{images.urlPrefixLarge}}{{images.imageLocation}}/image.png
  "
  alt="Useful alternative text."
/>
```

그리고 우리는 간다.
 이는 개발시 로컬 / 상대적 소스가되고 프로덕션시 Cloudinary의 가져 오기가 작동하는이 접두사 및 정규화 된 URL이됩니다.
 

이제 Cloudinary에 있으므로 한 단계 더 나아갈 수 있습니다.
 접두사 URL을 조정하여 이미지 크기를 조정할 수 있습니다. 즉, 하나의 소스 이미지로도 반응 형 이미지에 대해 적절한 설정을 가져올 수 있습니다.
 다음은 전체 구문에 사용할 수 있도록 여러 접두사를 사용할 수있는 설정입니다.
 

최종 결과는 개발중인 로컬 상대 이미지를 의미합니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/11/Screen-Shot-2020-11-24-at-4.18.37-PM.png?resize=649%2C668&ssl=1)

… 그리고 Cloudinary는 프로덕션에서 URL을 가져옵니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/11/Screen-Shot-2020-11-24-at-4.18.51-PM.png?resize=645%2C628&ssl=1)

### 다른 사람들의 아이디어
 

Phil은 지난번에 Netlify 리디렉션을 사용하여이를 보여주었습니다.
 

그런 다음 로컬 개발의 비결은 404를 포착하고 더 많은 리디렉션을 사용하여 로컬로 리디렉션하는 것입니다.
 

자신 만의 반응 형 이미지 구문을 직접 만드는 것이 너무 힘들다면 추상화하는 것이 좋습니다.
 Eleventy-land에서 Nicolas Hoizey는 eleventy-plugin-images-responsiver라는 프로젝트를 가지고 있습니다.
 Eric Portis는 eleventy-respimg도 가지고 있는데, 여기에서 제가 여기있는 것처럼 특별히 Cloudinary를 사용합니다.
 

이 문제가 사람들의 마음 속에 있다는 것을 증명 한 Tim Kadlec은 방금 "Netlify로 Cloudinary 요청 프록시"블로그에 올렸습니다.
 그는 Phil의 트윗에 추가 성능 컨텍스트와 문제를 추가합니다.
 