---
layout: post
title: "비디오를위한 Cloudinary 트릭
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/12/video-bumper.png
tags: CLOUDINARY,VIDEO
---


비디오 제작에는 시간이 많이 걸립니다.
 잘 만들어진 5 분짜리 동영상은 계획, 녹화, 편집하는 데 몇 시간이 걸릴 수 있습니다. 그 동영상을 사이트의 다른 모든 동영상과 일치시키는 것에 대해 이야기하기 전입니다.
 

Jamstack Explorers 프로젝트 (웹 개발자를위한 비디오 기반 교육 리소스)를 수행 할 때 품질과 배송의 적절한 균형을 찾고 싶었습니다. 필요한 시간과 단계 수를 줄이기 위해 비디오 제작 프로세스에서 무엇을 자동화 할 수 있습니까?
 품질 저하없이 비디오 콘텐츠를 만들려면?
 

Cloudinary의 도움으로 우리는 비디오를 만드는 사람들을위한 추가 편집 작업을 추가하지 않고도 모든 비디오 콘텐츠에서 일관된 브랜딩 접근 방식을 제공 할 수있었습니다.
 또한 보너스로 향후 브랜딩을 업데이트하면 전체 사이트의 모든 비디오 브랜딩을 한 번에 업데이트 할 수 있습니다. 비디오 편집이 필요하지 않습니다!
 

### "비디오 브랜딩"은 무엇을 의미합니까?
 

탐험가 사이트의 모든 동영상이 모두 어울리는 것처럼 보이게하기 위해 각 동영상에 몇 가지 공통 부분을 포함합니다.
 

- 타이틀 장면
 
- Jamstack Explorers 브랜딩을 보여주는 짧은 소개 범퍼 (비디오 클립)
 
- 다음 비디오까지 카운트 다운하거나 이것이 임무의 마지막 비디오 인 경우 "임무 완료"를 보여주는 짧은 아웃트로 범퍼
 

### 끝으로 건너 뛰기 : 브랜드 동영상의 모습은 다음과 같습니다.
 

브랜딩 추가의 영향을 보여주기 위해 다음은 브랜딩이없는 Jamstack Explorer의 동영상 중 하나입니다.
 


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video controls="" src="https://res.cloudinary.com/netlify/video/upload/q_auto,f_auto,w_600/v1608169888/explorers/LCA-07-lifecycle-hooks.mp4" playsinline="" name="fitvid0"></video>
</div>


이 비디오 (및 Ben Hong의 Vue 임무)는 합법적으로 훌륭합니다!
 하지만 갑작스럽게 시작하고 끝납니다.이 동영상이 어디에 있는지 알 수 없습니다.
 

우리는 Adam Hald와 협력하여 각 동영상에 자리를주는 데 도움이되는 브랜드 동영상 저작물을 만들었습니다.
 모든 탐험가 브랜딩이 적용된 동일한 동영상을 확인하세요.
 


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video controls="" src="https://res.cloudinary.com/netlify/video/upload/f_auto,q_auto/c_fill,h_720,q_auto,w_1280/c_fill,h_720,l_video:explorers:LCA-07-lifecycle-hooks,q_auto,w_1280/e_transition,l_video:explorers:transition/fl_layer_apply/fl_layer_apply/c_fill,h_720,l_video:explorers:countdown,q_auto,w_1280/e_transition,l_video:explorers:transition/fl_layer_apply/fl_layer_apply/c_fill,fl_splice,h_720,l_video:explorers:intro,q_auto,w_1280/ac_none,e_accelerate:-25,eo_3/c_fit,co_white,l_text:roboto_80_center:Lifecycle%20Hooks,w_1000/fl_layer_apply/fl_layer_apply,so_0/v1605555115/explorers/bumper.mp4" playsinline="" name="fitvid1"></video>
</div>


우리는 똑같이 훌륭한 콘텐츠를 얻었지만 이제 더 큰 이야기의 일부인 것처럼 느끼도록 약간의 va-va-voom을 추가했습니다.
 

이 기사에서는 Cloudinary를 사용하여 모든 비디오를 자동으로 사용자 정의하는 방법을 살펴 보겠습니다.
 

### Cloudinary는 어떻게 이것을 가능하게합니까?
 

Cloudinary는 미디어를 조작하고 변환 할 수있는 강력한 URL 기반 API를 제공하는 클라우드 기반 자산 전달 네트워크입니다.
 모든 종류의 자산 유형을 지원하지만 실제로 빛나는 부분은 이미지와 비디오입니다.
 

Cloudinary를 사용하려면 무료 계정을 만든 다음 자산을 업로드합니다.
 이 자산은 Cloudinary URL에서 사용할 수 있습니다.
 

```
https://res.cloudinary.com/netlify/image/upload/v1605632851/explorers/avatar.jpg
                           ^^^^^^^             ^^^^^^^^^^ ^^^^^^^^^^^^^^^^^^^
                              |                      |                |
                              V                      V                V
                      cloud (account) name    version (optional)  file name
```

이 URL은 원본 이미지를 가리키며`<img />`태그 및 기타 마크 업에서 사용할 수 있습니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/12/avatar.jpg?resize=300%2C300&ssl=1)

### 파일 형식 및 품질을 동적으로 조정하여 파일 크기 줄이기
 

웹 사이트에서이 이미지를 사용 중이고 사이트 성능을 개선하려는 경우 WebP, AVIF 등과 같은 차세대 형식을 사용하여이 이미지의 크기를 줄이기로 결정할 수 있습니다.
 이러한 새로운 형식은 훨씬 작지만 모든 브라우저에서 지원되지는 않습니다. 일반적으로 도구를 사용하여이 이미지의 여러 버전을 다른 형식으로 생성 한 다음`<picture>`요소 또는 기타 특수 마크 업을 사용하여 최신
 이전 브라우저를위한 JPG 대체 옵션이 있습니다.
 

Cloudinary를 사용하면 URL에 변환을 추가하기 만하면됩니다.
 

```
https://res.cloudinary.com/netlify/image/upload/q_auto,f_auto/v1605632851/explorers/avatar.jpg
                                                ^^^^^^^^^^^^
                                                      |
                                                      V
                                    automatic quality & format transformations

```

브라우저에서 보는 것은 시각적으로 동일합니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/12/avatar-2-1.jpg?resize=300%2C300&ssl=1)

파일 형식 및 품질 설정을 자동 (`f_auto, q_auto`)으로 설정함으로써 Cloudinary는 클라이언트가 지원하는 형식을 감지하고 합리적인 품질 수준에서 가장 효율적인 형식을 제공 할 수 있습니다.
 예를 들어 Chrome에서이 이미지는 97.6kB JPG에서 15.4kB WebP로 변환되며 URL에 몇 가지를 추가하기 만하면됩니다!
 

### 다양한 방법으로 이미지를 변형 할 수 있습니다!
 

크기 조정 ( `150px 너비로 크기 조정`의 경우 `w_150`) 및 색상 효과 ( `회색조 효과 적용`의 경우 `e_grayscale`)를 포함하여 다른 변환으로 더 나아갈 수 있습니다.
 

```
https://res.cloudinary.com/netlify/image/upload/q_auto,f_auto,w_150,e_grayscale/v1605632851/explorers/avatar.jpg
```

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/12/avatar-3.jpg?resize=150%2C150&ssl=1)

이것은 가능한 것의 작은 맛일뿐입니다. 더 많은 예제를 보려면 Cloudinary 문서를 확인하십시오!
 

### 좀 더 사람이 읽을 수있는 Node SDK가 있습니다.
 

앞으로 들어갈 내용과 같은 고급 변환의 경우 URL을 직접 작성하면 읽기가 약간 어려울 수 있습니다.
 결국 Cloudinary Node SDK를 사용하여 의견을 추가하고 각 변환이 수행하는 작업을 설명 할 수있게되었으며 이는 플랫폼을 유지 관리하고 발전시키는 데 큰 도움이되었습니다.
 

설치하려면 콘솔에서 Cloudinary API 키와 시크릿을 가져온 다음 npm을 사용하여 SDK를 설치합니다.
 

```terminal
# create a new directory
mkdir cloudinary-video

# move into the new directory
cd cloudinary-video/

# initialize a new Node project
npm init -y

# install the Cloudinary Node SDK
npm install cloudinary
```

다음으로`index.js`라는 새 파일을 만들고`cloud_name` 및 API 자격 증명으로 SDK를 초기화합니다.
 

```js
const cloudinary = require('cloudinary').v2;

// TODO replace these values with your own Cloudinary credentials
cloudinary.config({
  cloud_name: 'your_cloud_name',
  api_key: 'your_api_key',
  api_secret: 'your_api_secret',
});
```

API 자격 증명을 GitHub에 커밋하거나 어디서나 공유하지 마세요.
 환경 변수를 사용하여 안전하게 유지하십시오!
 환경 변수에 익숙하지 않은 경우 Colby Fayock이 환경 변수 사용에 대한 훌륭한 소개를 작성했습니다.
 

다음으로 약간 더 사람이 읽을 수있는 구성 설정을 사용하기 전과 동일한 변환을 만들 수 있습니다.
 

```js
cloudinary.uploader
  // the first argument should be the public ID (including folders!) of the
  // image we want to transform
  .explicit('explorers/avatar', {
    // these two properties match the beginning of the URL:
    // https://res.cloudinary.com/netlify/image/upload/...
    //                                    ^^^^^^^^^^^^
    resource_type: 'image',
    type: 'upload',

    // "eager" means we want to run these transformations ahead of time to avoid
    // a slow first load time
    eager: [
      {
        fetch_format: 'auto',
        quality: 'auto',
        width: 150,
        effect: 'grayscale',
      },
    ],

    // allow this transformed image to be cached to avoid re-running the same
    // transformations over and over again
    overwrite: false,
  })
  .then((result) => {
    console.log(result);
  });
```

터미널에`node index.js`를 입력하여이 코드를 실행 해 보겠습니다.
 출력은 다음과 같습니다.
 

```js
{
  asset_id: 'fca4abba96ffdf70ef89498aa340ae4e',
  public_id: 'explorers/avatar',
  version: 1605632851,
  version_id: 'b8a923931af20404e89d03852ff1bff1',
  signature: 'e7201c9ab36cb5b6a0545cee4f5f8ee27fb7f99f',
  width: 300,
  height: 300,
  format: 'jpg',
  resource_type: 'image',
  created_at: '2020-11-17T17:07:31Z',
  bytes: 97633,
  type: 'upload',
  url: 'http://res.cloudinary.com/netlify/image/upload/v1605632851/explorers/avatar.jpg',
  secure_url: 'https://res.cloudinary.com/netlify/image/upload/v1605632851/explorers/avatar.jpg',
  access_mode: 'public',
  eager: [
    {
      transformation: 'e_grayscale,f_auto,q_auto,w_150',
      width: 150,
      height: 150,
      bytes: 6192,
      format: 'jpg',
      url: 'http://res.cloudinary.com/netlify/image/upload/e_grayscale,f_auto,q_auto,w_150/v1605632851/explorers/avatar.jpg',
      secure_url: 'https://res.cloudinary.com/netlify/image/upload/e_grayscale,f_auto,q_auto,w_150/v1605632851/explorers/avatar.jpg'
    }
  ]
}
```

`eager` 속성 아래에 변환 된 이미지를보기위한 전체 URL과 함께 변환이 표시됩니다.
 

Node SDK는 아마도 이와 같은 간단한 변환에는 지나치지 만, 비디오 브랜딩을 추가하는 데 필요한 복잡한 변환을 살펴볼 때 정말 편리합니다.
 

### Cloudinary로 비디오 변환
 

Jamstack Explorer에서 동영상을 변환하기 위해 동일한 접근 방식을 따릅니다. 각 동영상은 Cloudinary에 업로드 된 다음 URL을 수정하여 크기를 조정하고 품질을 조정하고 타이틀 카드와 범퍼를 삽입합니다.
 

브랜딩을 추가하기 위해 다룰 몇 가지 주요 변형 범주가 있습니다.
 

- 오버레이
 
- 전환
 
- 텍스트 오버레이
 
- 접합
 

이러한 각 카테고리를 살펴보고 Ben의 동영상에서 Jamstack Explorer 브랜딩을 다시 구현할 수 없는지 확인해 보겠습니다.
 기본 동영상을 변환하기 위해`index.js`를 설정하여 설정해 보겠습니다.
 

```js
cloudinary.uploader
  .explicit('explorers/bumper', {
    // these two properties match the beginning of the URL:
    // https://res.cloudinary.com/netlify/image/upload/...
    //                                    ^^^^^^^^^^^^
    resource_type: 'video',
   type: 'upload',

    // "eager" means we want to run these transformations ahead of time to avoid
    // a slow first load time
    eager: [
      {
        fetch_format: 'auto',
        quality: 'auto',
        height: 360,
        width: 640,
        crop: 'fill', // avoid letterboxing if videos are different sizes
      },
    ],

    // allow this transformed image to be cached to avoid re-running the same
    // transformations over and over again
    overwrite: false,
  })
  .then((result) => {
    console.log(result);
  }); 
 
 
 
 

```

Ben의 원본 동영상 대신 `범퍼`라는 동영상을 사용하고 있음을 눈치 채 셨을 것입니다.
 이는 Cloudinary가 비디오를 추가 할 때 비디오를 주문하는 방식 때문입니다.
 다음 섹션에서 Ben의 비디오를 추가하겠습니다!
 

### Cloudinary를 사용하여 두 개의 비디오를 사용자 지정 전환으로 결합
 

범퍼를 추가하려면 두 번째 동영상을 오버레이로 추가하는 `eager`배열에 두 번째 변형 `레이어`를 추가해야합니다.
 

이를 위해`overlay` 변환을 사용하고`video : publicID`로 설정합니다. 여기서`publicID`는 슬래시 (`/`)가 콜론 (`:`)으로 변환 된 자산의 Cloudinary 공개 ID입니다.
 

또한 Cloudinary에게 두 비디오간에 전환하는 방법을 알려야합니다.이 작업은 비디오의 검은 색 영역으로 하나의 비디오를 마스크하고 흰색 영역으로 두 번째 비디오를 마스크 할 수있는 루마 매트라는 특별한 종류의 비디오를 사용하여 수행합니다.
 이로 인해 양식화 된 교차 페이드가 생성됩니다.
 

루마 매트 자체의 모양은 다음과 같습니다.
 


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video controls="" poster="https://css-tricks.com/wp-content/uploads/2020/12/Screen-Shot-2020-12-22-at-11.20.47-AM.png" src="https://res.cloudinary.com/netlify/video/upload/q_auto,f_auto,w_600/v1605286631/explorers/transition.mp4" playsinline="" name="fitvid2"></video>
</div>


비디오와 트랜지션은 모두 자체 변환이 있으므로 Cloudinary 변환에서 이들을 서로 다른 "레이어"로 처리해야합니다.
 즉, 개별 개체로 분할 한 다음 추가 개체를 추가하여 각 레이어를 "적용"하여 해당 섹션을 완료라고 부르고 기본 비디오에 더 많은 변환을 계속 추가 할 수 있습니다.
 

Cloudinary에게 이것이 다른 비디오가 아닌 루마 매트라고 알리기 위해`effect` 유형을`transition`으로 설정했습니다.
 

`index.js`에서 다음과 같이 변경하여이 모든 것을 제자리에 두십시오.
 

```js
const videoBaseTransformations = {
  fetch_format: 'auto',
  quality: 'auto',
  height: 360,
  width: 600,
  crop: 'fill',
}

cloudinary.uploader
  .explicit('explorers/bumper', {
    // these two properties match the beginning of the URL:
    // <https://res.cloudinary.com/netlify/image/upload/>...
    //
    resource_type: 'video',
    type: 'upload',

    // "eager" means we want to run these transformations ahead of time to avoid
    // a slow first load time
    eager: [
      videoBaseTransformations,
      {
        overlay: 'video:explorers:LCA-07-lifecycle-hooks',
        ...videoBaseTransformations,
      },
      {
        overlay: 'video:explorers:transition',
        effect: 'transition',
      },
      { flags: 'layer_apply' }, // <= apply the transformation
      { flags: 'layer_apply' }, // <= apply the actual video
    ],

    // allow this transformed image to be cached to avoid re-running the same
    // transformations over and over again
    overwrite: false,
  })
  .then((result) => {
    console.log(result);
  }); 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

```

모든 비디오에 동일한 형식, 품질 및 크기 변환이 필요하므로이를`videoBaseTransformations`라는 변수로 가져온 다음 오버레이를 포함 할 두 번째 개체를 추가했습니다.
 

`node index.js`로 실행하면 다음과 같은 비디오를 볼 수 있습니다.
 


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video controls="" src="https://res.cloudinary.com/netlify/video/upload/c_fill,f_auto,h_360,q_auto,w_600/c_fill,f_auto,h_360,l_video:explorers:LCA-07-lifecycle-hooks,q_auto,w_600/e_transition,l_video:explorers:transition/fl_layer_apply/fl_layer_apply/v1605555115/explorers/bumper.mp4" playsinline="" name="fitvid3"></video>
</div>


나쁘지 않다!
 이것은 이미 Jamstack Explorers 사이트의 일부인 것처럼 보이며 이러한 전환은 일반적인 범퍼에서 맞춤 동영상으로 멋진 흐름을 추가합니다.
 

아우트로 범퍼를 추가하는 것은 똑같이 작동합니다. 끝 범퍼와 전환을위한 또 다른 오버레이를 추가해야합니다.
 튜토리얼에서는이 코드를 표시하지 않지만 관심이있는 경우 소스 코드에서 볼 수 있습니다.
 

### 텍스트 오버레이를 사용하여 비디오에 타이틀 카드 추가
 

타이틀 카드를 추가하려면 두 가지 단계가 있습니다.
 

- 타이틀 카드 배경으로 사용할 짧은 비디오 클립 추출
 
- 동영상 제목과 함께 텍스트 오버레이 추가
 

다음 두 섹션에서는 각 단계를 개별적으로 안내하므로 두 섹션의 차이점을 확인할 수 있습니다.
 

Adam Hald가 탐험가 동영상 저작물을 만들 때 별이 빛나는 하늘에서 열리는 멋진 소개 동영상을 포함 시켰는데, 제목 카드에 딱 맞았습니다.
 Cloudinary를 사용하면 별이 빛나는 하늘을 몇 초간 캡처하여 모든 비디오에 타이틀 카드로 결합 할 수 있습니다!
 

`index.js`에서 다음 변환 블록을 추가합니다.
 

```js
cloudinary.uploader
  .explicit('explorers/bumper', {
    // these two properties match the beginning of the URL:
    // https://res.cloudinary.com/netlify/image/upload/...
    //
    resource_type: 'video',
    type: 'upload',

    // "eager" means we want to run these transformations ahead of time to avoid
    // a slow first load time
    eager: [
      videoBaseTransformations,
      {
        overlay: 'video:explorers:LCA-07-lifecycle-hooks',
        ...videoBaseTransformations,
      },
      {
        overlay: 'video:explorers:transition',
        effect: 'transition',
      },
      { flags: 'layer_apply' }, // <= apply the transformation
      { flags: 'layer_apply' }, // <= apply the actual video

      // add the outro bumper and a transition
      {
        overlay: 'video:explorers:countdown',
        ...videoBaseTransformations,
      },
      {
        overlay: 'video:explorers:transition',
        effect: 'transition',
      },
      { flags: 'layer_apply' },
      { flags: 'layer_apply' },

      // splice a title card at the beginning of the video
      {
        overlay: 'video:explorers:intro',
        flags: 'splice', // splice this into the video
        ...videoBaseTransformations,
      },
      {
        audio_codec: 'none', // remove the audio
        end_offset: 3, // shorten to 3 seconds
        effect: 'accelerate:-25', // slow down 25% (to ~4 seconds)
      },
      {
        flags: 'layer_apply',
        start_offset: 0, // put this at the beginning of the video
      },
    ],

    // allow this transformed image to be cached to avoid re-running the same
    // transformations over and over again
    overwrite: false,
  })
  .then((result) => {
    console.log(result);
  }); 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

```

`splice` 플래그를 사용하여 Cloudinary에 전환없이이 비디오를 직접 추가하도록 지시합니다.
 

다음 변형 세트에서는 이전에 보지 못한 세 가지 변형을 추가합니다.
 

- 이 비디오 세그먼트에서 사운드를 제거하기 위해`audio_codec`를`none`으로 설정합니다.
 
- `end_offset`을`3`으로 설정합니다. 즉, 동영상의 처음 3 초만 가져옵니다.
 
- 값이 `-25`인 `가속`효과를 추가하면 동영상 속도가 25 % 느려집니다.
 

이제`node index.js`를 실행하면 4 초 미만의 조용하고 별이 빛나는 하늘로 시작하는 동영상이 제공됩니다.
 


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video controls="" poster="https://css-tricks.com/wp-content/uploads/2020/12/Screen-Shot-2020-12-22-at-11.26.43-AM.png" src="https://res.cloudinary.com/netlify/video/upload/c_fill,f_auto,h_360,q_auto,w_600/c_fill,f_auto,h_360,l_video:explorers:LCA-07-lifecycle-hooks,q_auto,w_600/e_transition,l_video:explorers:transition/fl_layer_apply/fl_layer_apply/c_fill,f_auto,h_360,l_video:explorers:countdown,q_auto,w_600/e_transition,l_video:explorers:transition/fl_layer_apply/fl_layer_apply/c_fill,f_auto,fl_splice,h_360,l_video:explorers:intro,q_auto,w_600/ac_none,e_accelerate:-25,eo_3/fl_layer_apply,so_0/v1605555115/explorers/bumper.mp4" playsinline="" name="fitvid4"></video>
</div>


### Cloudinary를 사용하여 비디오에 텍스트 오버레이 추가
 

마지막 단계는 비디오 제목을 표시하기 위해 텍스트 오버레이를 추가하는 것입니다!
 

텍스트 오버레이는 다른 오버레이와 동일한 `overlay`속성을 사용하지만 글꼴 설정이 포함 된 개체를 전달합니다.
 Cloudinary는 다양한 글꼴을 지원합니다. 최종 목록을 찾을 수는 없지만 Google 글꼴이 많은 것 같습니다. 사용자 지정 글꼴을 사용하기위한 라이선스를 구입 한 경우에는 다음을 업로드 할 수 있습니다.
 사용자 지정 글꼴을 텍스트 오버레이에도 사용할 수 있도록 Cloudinary로 변환합니다.
 

```js
cloudinary.uploader
  .explicit('explorers/bumper', {
    // these two properties match the beginning of the URL:
    // <https://res.cloudinary.com/netlify/image/upload/>...
    //
    resource_type: 'video',
    type: 'upload',

    // "eager" means we want to run these transformations ahead of time to avoid
    // a slow first load time
    eager: [
      videoBaseTransformations,
      {
        overlay: 'video:explorers:LCA-07-lifecycle-hooks',
        ...videoBaseTransformations,
      },
      {
        overlay: 'video:explorers:transition',
        effect: 'transition',
      },
      { flags: 'layer_apply' }, // <= apply the transformation
      { flags: 'layer_apply' }, // <= apply the actual video

      // add the outro bumper and a transition
      {
        overlay: 'video:explorers:countdown',
        ...videoBaseTransformations,
      },
      {
        overlay: 'video:explorers:transition',
          effect: 'transition',
        },
        { flags: 'layer_apply' },
        { flags: 'layer_apply' },

        // splice a title card at the beginning of the video
        {
          overlay: 'video:explorers:intro',
          flags: 'splice', // splice this into the video
          ...videoBaseTransformations,
        },
        {
          audio_codec: 'none', // remove the audio
          end_offset: 3, // shorten to 3 seconds
          effect: 'accelerate:-25', // slow down 25% (to ~4 seconds)
        },
        {
        overlay: {
          font_family: 'roboto', // lots of Google Fonts are supported
          font_size: 40,
          text_align: 'center',
          text: 'Lifecycle Hooks', // this can be any text you want
        },
        width: 500,
        crop: 'fit',
        color: 'white',
      },
      { flags: 'layer_apply' },
      {
        flags: 'layer_apply',
        start_offset: 0, // put this at the beginning of the video
      },
    ],

    // allow this transformed image to be cached to avoid re-running the same
    // transformations over and over again
    overwrite: false,
  })
  .then((result) => {
    console.log(result);
  }); 
 
 
 
 
 
 
 
 
 
 
 

```

글꼴 크기와 정렬을 설정하는 것 외에도, 제목 텍스트가 타이틀 카드의 측면으로 스매싱되지 않도록 500px 너비 (기본적으로 중앙에 위치 함)를 적용하고`crop` 값을`fit
 `, 긴 제목을 래핑합니다.
 `color`를`white`로 설정하면 어둡고 별이 빛나는 배경에 텍스트가 표시됩니다.
 

`node index.js`를 실행하여 URL을 생성하면 타이틀 카드와 범퍼가 포함 된 전체 브랜드 동영상이 표시됩니다.
 


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video controls="" src="https://res.cloudinary.com/netlify/video/upload/c_fill,f_auto,h_360,q_auto,w_600/c_fill,f_auto,h_360,l_video:explorers:LCA-07-lifecycle-hooks,q_auto,w_600/e_transition,l_video:explorers:transition/fl_layer_apply/fl_layer_apply/c_fill,f_auto,h_360,l_video:explorers:countdown,q_auto,w_600/e_transition,l_video:explorers:transition/fl_layer_apply/fl_layer_apply/c_fill,f_auto,fl_splice,h_360,l_video:explorers:intro,q_auto,w_600/ac_none,e_accelerate:-25,eo_3/c_fit,co_white,l_text:roboto_40_center:Lifecycle%20Hooks,w_500/fl_layer_apply/fl_layer_apply,so_0/v1605555115/explorers/bumper.mp4" playsinline="" name="fitvid5"></video>
</div>


### 비디오 브랜딩을 한 번 구축하십시오.
 어디서나 사용
 

범퍼, 전환 및 타이틀 카드를 만드는 것은 많은 작업입니다.
 고품질 비디오 콘텐츠를 만드는 것도 많은 작업입니다.
 이러한 타이틀 카드와 범퍼를 삽입하기 위해 모든 Jamstack Explorers 동영상을 수동으로 편집해야했다면 실제로 그렇게했을 가능성이 거의 없습니다.
 

비디오를 일관되게 브랜딩 할 수있는 유일한 현실적인 방법은 브랜딩 추가로 인한 마찰을 줄이는 것이었고 Cloudinary는이를 완전히 자동화 할 수 있도록했습니다.
 즉, 수동 단계없이 일관성을 유지할 수 있습니다!
 

추가 보너스로, 앞으로 타이틀 카드 나 범퍼를 업데이트하면 한 곳에서 코드를 변경하여 모든 동영상의 모든 브랜딩을 업데이트 할 수 있습니다.
 탐험가가 시간이 지남에 따라 계속해서 성장하고 진화 할 것이라는 것을 알고 있기 때문에 이것은 우리에게 큰 안도감을줍니다.
 

### 다음에 할일
 verified_user

Cloudinary를 사용하여 사용자 지정 브랜딩을 추가하는 방법을 알았으므로 다음은 계속 학습하는 데 도움이되는 몇 가지 추가 리소스입니다.
 

- 이 튜토리얼의 소스 코드를 참조하십시오.
 
- 비디오 브랜딩에 대한 Jamstack Explorers 소스 코드를 참조하십시오.
 
- Cloudinary의 비디오 변환 API에 대해 자세히 알아보십시오.
 
- Jamstack Explorer에서 웹 개발에 대해 알아보세요.
 
- Cloudinary를 사용하여 사용자 지정 소셜 미디어 이미지를 만드는 방법을 알아 봅니다.
 
- 모든 것이 어떻게 결합되는지 확인하려면 Ben의 전체 임무를 시청하세요!
 

Cloudinary를 사용하여 무엇을 자동화 할 수 있습니까?
 비디오 편집 워크 플로우의 반복적 인 부분을 자동화하여 얼마나 많은 시간을 절약 할 수 있습니까?
 나는이 물건에 대해 이야기하는 것을 좋아하는 괴상한 사람이므로 트위터에 아이디어를 보내주세요!
 