---
layout: post
title: "사용자에게 제어 권한 부여 : 미디어 세션 API
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2019/11/audio-wavelength.png
tags: 
---


다음은 시나리오입니다.
 열려있는 여러 브라우저 탭 중 하나에서 Kendrick Lamar 트랙을 시작합니다.
 당신은 그것을 좋아하지만 누군가가 당신의 공간으로 걸어 들어와 당신은 그것을 일시 중지해야합니다.
 어느 탭입니까?
 브라우저는이를 약간 도와 주려고합니다.
 전체 시스템 오디오를 음소거 할 수 있습니다.
 하지만 해당 탭으로 돌아갈 필요없이 실제로 오디오 재생을 제어하는 것이 좋지 않을까요?
 

Media Session API는이를 가능하게합니다.
 재생중인 브라우저 탭 외부의 사용자에게 미디어 재생 액세스 권한을 제공합니다.
 구현되면 다음을 포함하여 장치의 다양한 위치에서 사용할 수 있습니다.
 

- 많은 휴대 기기의 알림 영역,
 
- 다른 웨어러블에서
 
- 많은 데스크탑 장치의 미디어 허브 영역.
 

또한 Media Session API를 사용하면 Siri, Google Assistant, Bixby 또는 Alexa와 같은 음성 비서 및 미디어 키로 미디어 재생을 제어 할 수 있습니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_B4FDC13572C3BFB831628BBAFC832AFD1E5082A4E169106B418D5F09A64E026F_1606496534217_media-control.png?resize=1024%2C1004&ssl=1)

### 미디어 세션 API
 

미디어 세션 API는 주로 다음 두 가지 인터페이스로 구성됩니다.
 

- `MediaMetadata`
 
- `MediaSession`
 

`MediaMetadata` 인터페이스는 재생중인 미디어에 대한 데이터를 제공합니다.
 미디어의 제목, 앨범, 아트 워크 및 아티스트 (이 예에서는 Kendrick Lamar)를 알려주는 책임이 있습니다.
 `MediaSession` 인터페이스는 미디어 재생 기능을 담당합니다.
 

주제에 대해 자세히 알아보기 전에 기능 감지에 유의해야합니다.
 구현하기 전에 브라우저가 기능을 지원하는지 확인하는 것이 좋습니다.
 브라우저가 Media Session API를 지원하는지 확인하려면 JavaScript 파일에 다음을 포함해야합니다.
 

```js
if ('mediaSession' in navigator) {
  // Our media session api that lets us seek to the beginning of Kendrick Lamar's &quot;Alright&quot;
}
```

생성자`MediaMetadata.MediaMetadata ()`는 새로운`MediaMetadata` 객체를 생성합니다.
 생성 후 다음 속성을 추가 할 수 있습니다.
 

- `MediaMetadata.title`은 재생중인 미디어의 제목을 설정하거나 가져옵니다.
 
- `MediaMetadata.artist`는 아티스트 또는 재생중인 미디어 그룹의 이름을 설정하거나 가져옵니다.
 
- `MediaMetadata.album`은 재생중인 미디어가 포함 된 앨범의 이름을 설정하거나 가져옵니다.
 
- `MediaMetadata.artwork`는 미디어 재생과 관련된 이미지 배열을 설정하거나 가져옵니다.
 

`MediaMetadata` 객체의`artwork` 속성 값은`MediaImage` 객체의 배열입니다.
 `MediaImage` 객체는 미디어와 관련된 이미지를 설명하는 세부 정보를 포함합니다.
 개체에는 다음 세 가지 속성이 있습니다.
 

- `src` : 이미지의 URL
 
- `sizes` : 이미지의 크기를 나타내므로 한 이미지의 크기를 조정할 필요가 없습니다.
 
- `type` : 이미지의 MIME 유형
 

Kendrick Lamar의 To Pimp a Butterfly 앨범에서 "Alright"에 대한`MediaMetadata` 개체를 만들어 보겠습니다.
 

```js
if ('mediaSession' in navigator) {
  navigator.mediaSession.metadata = new MediaMetadata({
    title: 'Alright',
    artist: 'Kendrick Lamar',
    album: 'To Pimp A Butterfly',
    artwork: [
      { src: 'https://mytechnicalarticle/kendrick-lamar/to-pimp-a-butterfly/alright/96x96', sizes: '96x96', type: 'image/png' },
      { src: 'https://mytechnicalarticle/kendrick-lamar/to-pimp-a-butterfly/alright/128x128', sizes: '128x128', type: 'image/png' },
      // More sizes, like 192x192, 256x256, 384x384, and 512x512
    ]
  });
}
```

앞서 언급했듯이 이것은 사용자가 미디어의 재생을 제어 할 수있는 것입니다.
 이 인터페이스를 통해 재생중인 미디어에 대해 다음 작업을 수행 할 수 있습니다.
 

- `play` : 미디어 재생
 
- `pause` : 미디어 일시 중지
 
- `previoustrack` : 이전 트랙으로 전환
 
- `nexttrack` : 다음 트랙으로 전환
 
- `seekbackward` : 현재 위치에서 몇 초 뒤로 탐색
 
- `seekforward` : 현재 위치에서 몇 초 앞으로 탐색
 
- `seekto` : 현재 위치에서 지정된 시간을 찾습니다.
 
- `stop` : 미디어 재생 중지
 
- `skipad` : 재생중인 광고가있는 경우 건너 뛰기
 

`MediaSessionAction` 열거 유형은 이러한 작업을 문자열 유형으로 사용할 수 있도록합니다.
 이러한 작업을 지원하려면`MediaSession`의`setActionHandler ()`메서드를 사용하여 해당 작업에 대한 핸들러를 정의해야합니다.
 이 메서드는 작업을 수행하고 사용자가 작업을 호출 할 때 호출되는 콜백을받습니다.
 그것을 더 잘 이해하기 위해 너무 깊이 들어 가지 마십시오.
 

`play` 및`pause` 작업에 대한 핸들러를 설정하기 위해 JavaScript 파일에 다음을 포함합니다.
 

```js
let alright = new HTMLAudioElement();

if ('mediaSession' in navigator) {
  navigator.mediaSession.setActionHandler('play', () => {
    alright.play();
  });
  navigator.mediaSession.setActionHandler('pause', () => {
    alright.pause();
  });
}
```

여기에서는 사용자가 재생할 때 재생되도록 트랙을 설정하고 미디어 인터페이스를 통해 일시 중지 할 때 일시 중지합니다.
 

`previoustrack` 및`nexttrack` 작업의 경우 다음이 포함됩니다.
 

```js
let u = new HTMLAudioElement();
let forSaleInterlude = new HTMLAudioElement();

if ('mediaSession' in navigator) {
  navigator.mediaSession.setActionHandler('previoustrack', () => {
    u.play();
  });
  navigator.mediaSession.setActionHandler('nexttrack', () => {
    forSaleInterlude.play();
  });
}
```

Kendrick Lamar 팬이별로 없다면 완전히 설명 할 수는 없지만 요점을 알 수 있습니다.
 사용자가 이전 트랙을 재생하고 싶을 때 이전 트랙을 재생하도록 설정합니다.
 다음 트랙이면 다음 트랙입니다.
 

`seekbackward` 및`seekforward` 작업을 구현하기 위해 다음을 포함합니다.
 

```js
if ('mediaSession' in navigator) {
  navigator.mediaSession.setActionHandler('seekbackward', (details) => {
    alright.currentTime = alright.currentTime - (details.seekOffset || 10);
  });
  navigator.mediaSession.setActionHandler('seekforward', (details) => {
    alright.currentTime = alright.currentTime + (details.seekOffset || 10);
  });
}
```

자명 한 내용을 고려하지 않았으므로 `뒤로 탐색`및 `탐색`작업에 대해 간결하게 설명하고 싶습니다.
 이름에서 알 수 있듯이 사용자가 몇 초 동안 앞뒤로 탐색하려고 할 때 `뒤로 탐색`및 `탐색`작업에 대한 핸들러가 모두 실행됩니다.
 `MediaSessionActionDetails` 사전은`seekOffset` 속성에 "몇 초"를 제공합니다.
 그러나 모든 사용자 에이전트가 동일한 방식으로 작동하는 것은 아니기 때문에`seekOffset` 속성이 항상 존재하는 것은 아닙니다.
 그것이 존재하지 않을 때, 우리는 우리가 이해할 수있는 "몇 초"만큼 앞뒤로 탐색하도록 트랙을 설정해야합니다.
 따라서 우리는 꽤 많은 시간이기 때문에 10 초를 사용합니다.
 간단히 말해, 제공되는 경우 `seekOffset`초 단위로 트랙을 검색하도록 설정합니다.
 제공되지 않으면 10 초 검색합니다.
 

Media Session API에`seekto` 기능을 추가하기 위해 다음 스 니펫을 포함합니다.
 

```js
if ('mediaSession' in navigator) {
  navigator.mediaSession.setActionHandler('seekto', (details) => {
    if (details.fastSeek && 'fastSeek' in alright) {
      alright.fastSeek(details.seekTime);
      return;
    }
    alright.currentTime = details.seekTime;
  });
}
```

여기서`MediaSessionActionDetails` 사전은`fastSeek` 및`seekTime` 속성을 제공합니다.
 `fastSeek`는 기본적으로 빨리 감기 나 되감기와 같이 빠르게 수행되는 검색이고, `seekTime`은 트랙이 검색해야하는 시간입니다.
 `fastSeek`는 선택적 속성이지만 `MediaSessionActionDetails`사전은 항상 `seekto`작업 핸들러에 대한 `seekTime`속성을 제공합니다.
 따라서 기본적으로 속성을 사용할 수 있고 사용자가 빠르게 검색 할 때 트랙을 `seekTime`으로 `fastSeek`로 설정하고 사용자가 지정된 시간 만 검색 할 때 `seekTime`으로 설정합니다.
 

Kendrick 노래를 중단하려는 이유는 알 수 없지만`MediaSession` 인터페이스의`stop` 액션 핸들러를 설명해도 나쁘지 않습니다.
 

```js
if ('mediaSession' in navigator) {
  navigator.mediaSession.setActionHandler('stop', () => {
    alright.pause();
    alright.currentTime = 0;
  });
} 
```

사용자는 광고가 재생 중일 때 `skipad`(예 : `skip pad`가 아닌 `skip ad`) 액션 핸들러를 호출하여 Kendrick Lamar의 `Alright`트랙을 계속들을 수 있도록 광고를 건너 뛰려고합니다.
 솔직히 말하자면 `skipad`액션 핸들러의 전체 세부 정보는 `미디어 세션 API`이해 범위를 벗어납니다.
 따라서 실제로 구현하려는 경우이 기사를 읽은 후 직접 찾아보아야합니다.
 

### 마무리
 verified_user

우리는 무언가에 주목해야합니다.
 사용자가 트랙을 재생하거나, 재생 속도를 찾거나, 변경할 때마다 Media Session API에서 제공하는 인터페이스의 위치 상태를 업데이트해야합니다.
 이를 구현하기 위해 사용하는 것은 다음과 같이`mediaSession` 객체의`setPositionState ()`메소드입니다.
 

```js
if ('mediaSession' in navigator) {
  navigator.mediaSession.setPositionState({
    duration: alright.duration,
    playbackRate: alright.playbackRate,
    position: alright.currentTime
  });
}
```

또한 사용자의 모든 브라우저가 모든 작업을 지원하는 것은 아닙니다.
 따라서 다음과 같이`try ... catch` 블록에 작업 핸들러를 설정하는 것이 좋습니다.
 

```js
const actionsAndHandlers = [
  ['play', () => { /*...*/ }],
  ['pause', () => { /*...*/ }],
  ['previoustrack', () => { /*...*/ }],
  ['nexttrack', () => { /*...*/ }],
  ['seekbackward', (details) => { /*...*/ }],
  ['seekforward', (details) => { /*...*/ }],
  ['seekto', (details) => { /*...*/ }],
  ['stop', () => { /*...*/ }]
]
 
for (const [action, handler] of actionsAndHandlers) {
  try {
    navigator.mediaSession.setActionHandler(action, handler);
  } catch (error) {
    console.log(`The media session action, ${action}, is not supported`);
  }
}
```

우리가 한 모든 것을 넣으면 다음과 같이됩니다.
 

```js
let alright = new HTMLAudioElement();
let u = new HTMLAudioElement();
let forSaleInterlude = new HTMLAudioElement();

const updatePositionState = () => {
  navigator.mediaSession.setPositionState({
    duration: alright.duration,
    playbackRate: alright.playbackRate,
    position: alright.currentTime
  });
}
 
const actionsAndHandlers = [
  ['play', () => {
    alright.play();
    updatePositionState();
  }],
  ['pause', () => { alright.pause(); }],
  ['previoustrack', () => { u.play(); }],
  ['nexttrack', () => { forSaleInterlude.play(); }],
  ['seekbackward', (details) => {
    alright.currentTime = alright.currentTime - (details.seekOffset || 10);
    updatePositionState();
  }],
  ['seekforward', (details) => {
    alright.currentTime = alright.currentTime + (details.seekOffset || 10);
    updatePositionState();
  }],
  ['seekto', (details) => {
    if (details.fastSeek && 'fastSeek' in alright) {
      alright.fastSeek(details.seekTime);
      updatePositionState();
      return;
    }
    alright.currentTime = details.seekTime;
    updatePositionState();
  }],
  ['stop', () => {
    alright.pause();
    alright.currentTime = 0;
  }],
]
 
if ( 'mediaSession' in navigator ) {
  navigator.mediaSession.metadata = new MediaMetadata({
    title: 'Alright',
    artist: 'Kendrick Lamar',
    album: 'To Pimp A Butterfly',
    artwork: [
      { src: 'https://mytechnicalarticle/kendrick-lamar/to-pimp-a-butterfly/alright/96x96', sizes: '96x96', type: 'image/png' },
      { src: 'https://mytechnicalarticle/kendrick-lamar/to-pimp-a-butterfly/alright/128x128', sizes: '128x128', type: 'image/png' },
      // More sizes, like 192x192, 256x256, 384x384, and 512x512
    ]
  });
 
  for (const [action, handler] of actionsAndHandlers) {
    try {
      navigator.mediaSession.setActionHandler(action, handler);
    } catch (error) {
      console.log(`The media session action, ${action}, is not supported`);
    }
  }
}
```

다음은 API 데모입니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_vYKQVqQ" src="//codepen.io/anon/embed/vYKQVqQ?height=250&amp;theme-id=1&amp;slug-hash=vYKQVqQ&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed vYKQVqQ" title="CodePen Embed vYKQVqQ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

나는 여섯 가지 행동을 구현했다.
 여가 시간에 나머지는 자유롭게 시도하십시오.
 

모바일 장치에서 펜을 보면 알림 영역에 어떻게 표시되는지 확인하십시오.
 