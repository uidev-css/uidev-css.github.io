---
layout: post
title: "크로스 브라우저 지원을 랭 글링하는 동안 투명하게 비디오 오버레이
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/12/transparent-video-overlay.png
tags: OVERLAY,TRANSPARENCY,VIDEO
---


디자인과 관련하여 웹 사이트가 점점 더 역동적으로 변함에 따라 복잡한 애니메이션 요소를 통합해야하는 경우가 있습니다.
 CSS 전환에서 캔버스의 3D 렌더링 및 애니메이션 SVG에 이르기까지 다양한 방법이 있습니다.
 그러나`<video>`는 다소 효율적일 수 있고 시각적으로 가능한 거의 모든 것이 가능하기 때문에 사용하기가 더 쉽습니다.
 

그러나 해당 비디오에 투명한 배경이 필요하여 페이지의 다른 콘텐츠와 상호 작용하는 것처럼 보이도록 오버레이 할 수 있다면 어떨까요?
 가능하지만 까다로울 수 있습니다. 특히 크로스 브라우저입니다.
 그것을 탐구 해 봅시다.
 

### 여기에 예가 있습니다.
 

투명한 동영상 오버레이가 어떻게 작동하는지 알아보기 위해 재미 있고 공감할 수있는 예제를 준비했습니다.
 아이디어는 슬라이더가 진행됨에 따라 비디오 뒤에있는 콘텐츠가 변경되도록 비디오를 대화 형 콘텐츠와 통합하는 것입니다.
 오버레이에 강아지의 실제 영상을 담은 개밥을 광고하는 슬라이더로 리얼하고 귀여운 강아지가 전환율을 높일 수 있다고 확신합니다!
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 800px;"><iframe id="cp_embed_pobGVGK" src="//codepen.io/anon/embed/pobGVGK?height=800&amp;theme-id=1&amp;slug-hash=pobGVGK&amp;default-tab=result" height="800" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed pobGVGK" title="CodePen Embed pobGVGK" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이 기사를 따라 직접이 데모를 다시 만들 수 있습니다.
 이와 같은 동영상을 만드는 데 필요한 부분은 `이미지 시퀀스`입니다 (동영상으로 결합 할 알파 투명 이미지 묶음).
 예제에 사용한 이미지를 제공합니다.
 

### 가능성 탐구
 

이 효과를 얻기 위해 페이지에 투명한 배경이있는 애니메이션 콘텐츠를 삽입 할 수있는 모든 종류의 솔루션을 검색했습니다.
 

가장 먼저 나온 것은 GIF였습니다.
 GIF 형식은 30 년 전에 도입되었지만 여전히 널리 사용되고 있습니다.
 불행히도 한계가 있습니다.
 단순하고 작은 애니메이션 그래픽에는 완벽하게 작동하지만 다채롭고 긴 비디오 푸티 지에는 그다지 좋지 않으며 색 공간이 제한되어 있으며 복잡한 비디오의 경우 크기가 크게 늘어납니다.
 

다음으로 살펴본 옵션은 APNG로, 어떤 이유로 GIF만큼 인기가 없지만 훨씬 좋습니다.
 (존재하는지도 몰랐죠?) APNG는 애니메이션 GIF 파일과 유사하게 작동하면서 24 비트 이미지와 8 비트 투명도를 지원합니다.
 또한 일반 PNG와 역 호환됩니다.
 APNG가 지원되지 않는 경우 첫 번째 프레임이 표시됩니다.
 널리 사용되는 브라우저에서 지원되지만 Internet Explorer 11에서는 지원되지 않습니다 (예, 일부 사람들은 여전히 지원해야합니다).
 잠시 가야할 것 같았지만 파일 크기와 성능에 만족하지 못했습니다.
 

재미있는 사실 : Apple은 iOS 10 iMessage 앱의 애니메이션 스티커에 대해 선호하는 형식으로 APNG 형식을 채택했습니다.
 

다음으로, 조잡하지만 작동하는 아이디어가 떠 올랐습니다. PNG를 많이 사용하고 JavaScript로 반복하여 비디오를 모방했습니다.
 그러나 많은 데이터 전송 (각 비디오 프레임은 별도의 이미지가 됨)과 애니메이션을 적용 할 리소스 (사용자의 배터리를 빠르게 소모하거나 컴퓨터 팬을 미치게 만들 수 있음)를 사용해야합니다.
 

나는 그 아이디어를 빨리 포기했지만 나중에 유용하다는 것이 밝혀졌습니다.
 기사의 끝에서 다시 설명하겠습니다.
 

여기서`<img>`의 모든 형식이 실패했기 때문에 동영상을 조사하기 시작했습니다.
 2013 년에 게시 된 Chrome 동영상의 알파 투명성에 대한 기사를 찾았는데, 이는 알파 채널이있는 WebM에 대한 Google Chrome 지원을 알리는 것입니다.
 예제를 보여주고 사용 방법에 대한 팁도 공유합니다.
 나는 기사를 훑어 보았고 즉시 갈 길처럼 느껴졌습니다.
 내 이미지 시퀀스를 WebM으로 변환 한 후 훨씬 더 확신이 들었습니다. GIF의 무게는 5.8MB이고 투명성이있는 WebM은 동일한 프레임 속도와 풀 컬러를 사용하는 것이 540KB에 불과했기 때문입니다!
 더 나은 성능과 품질을 제공하면서 10 배 이상 작아졌습니다.
 대박!
 

하지만 기쁨은 오래 가지 못했습니다.
 iOS 폰에서 웹 사이트를 열 자마자 브라우저 호환성 확인부터 시작해야한다는 것을 깨달았습니다.
 안타깝게도 Safari (iOS 및 macOS)는 WebM에서 투명성을 지원하지 않습니다.
 내 비디오가 Chrome, Firefox 및 Edge에서 완벽하게 작동하는 동안 Safari는 추악한 검정색 배경으로 나를 맞이했습니다.
 

검색은 계속됩니다…
 

### 좋은 솔루션
 

고맙게도 WWDC 2019에서 iOS 13 및 macOS Catalina부터 Safari에 대한 Alpha 지원이 포함 된 HEVC 비디오를 발표하는 비디오를 발견했습니다.
 WebM과 동일한 기능을 제공하지만 Apple 장치에서 지원하는 것 같습니다.
 그래서 하이브리드 솔루션 인 Safari 용 HEVC와 다른 브라우저 용 WebM을 사용하기로 결정했습니다.
 

완벽한 솔루션 인 것 같습니다.
 하지만 이제 두 가지 작업이 있습니다.
 

- 알파 투명성을 가진 HEVC 만들기
 
- 올바른 형식을 제공하기 위해 Safari (및 버전) 감지
 

### 투명한 비디오 만들기
 

쉬운 부분 인 WebM 파일 만들기부터 시작하겠습니다.
 비디오 파일을 생성, 변환 또는 편집하려는 경우 FFmpeg가 친구입니다.
 매우 강력한 오픈 소스 멀티미디어 프레임 워크입니다. 멀티미디어 파일과 관련이있는 경우 많은 작업을 수행 할 수 있으므로 여기에서 시작하는 것이 좋습니다.
 FFmpeg 덕분에 화질 저하없이 비디오 파일 크기를 10 배 이상 줄일 수있었습니다.
 하지만 다시 투명성으로 돌아 갑시다.
 

내 경험상 웹 사이트 레이아웃에 애니메이션 요소를 포함해야하는 경우 PNG의 비디오 프레임 세트로 가져옵니다.
 예제 프로젝트에서 작업하는 동안에도 비디오에서 배경을 제거하는 도구가 나를 위해 이미지 세트를 생성했습니다.
 따라서 여기에서 계속해서 이미지 세트에서 비디오를 작성한다고 가정하겠습니다 (세트를 다운로드 할 수 있음을 기억하십시오). 대신 비디오 파일이 있어도 프로세스가 비슷해 보일 것입니다 (FFmpeg 옵션을
 필요).
 

이제 비디오를 만들 준비가되었습니다.
 명령 줄을 사용하여 PNG 파일이 포함 된 폴더로 이동하고 다음 명령을 실행합니다.
 

```terminal
ffmpeg -framerate 25 -i unscreen-%3d.png -c:v libvpx-vp9 -pix_fmt yuva420p output.webm
```

필요에 맞게 인수를 조정할 수 있습니다.
 

- `framerate` : 출력 비디오의 1 초에 사용될 이미지의 양
 
- `-i unscreen- % 3d.png` : 파일 이름 및 형식을 입력합니다.
 내 파일에는 001에서 150까지의 숫자가 있으므로`% 3d`를 마스크로 사용하여 이름에 3 자리 숫자가있는 모든 파일을 선택했습니다.
 
- `-c : v` : 사용할 코덱을 지정합니다.
 대부분의 웹 브라우저에서 지원하는 VP9로 비디오를 인코딩하고 싶습니다.
 
- `-pix_fmt` : 사용할 픽셀 형식을 지정합니다.
 우리 CAS에서는 알파 채널을 지원해야합니다.
 `ffmpeg``--pix_fmts`를 실행하면 지원되는 모든 형식을 볼 수 있습니다.
 
- `output.webm` : 원하는 출력 파일 이름을 마지막 인수로 제공합니다.
 

더 많은 옵션을 사용할 수 있지만 자세히 살펴 보려면 두 개 이상의 문서가 필요할 수 있으므로 자세히 설명하지는 않겠습니다.
 예제 명령에 제공된 것들은 우리의 사용 사례에서 잘 작동합니다.
 

프로세스가 완료되면 새`output.webm` 파일이 표시되며 지원되는 브라우저에서 열면 동영상이 표시됩니다.
 쉽죠?
 

### HEVC Alpha 만들기
 

WebP 파일이 준비되었으므로 사용할 두 번째 형식 인 알파 투명도가있는 HEVC로 이동할 때입니다.
 불행히도 글을 쓰는 시점에서 FFmpeg는 HEVC를 지원하지 않으므로 다른 도구를 사용해야합니다.
 내가 아는 한 알파로 HEVC를 만드는 유일한 방법은 Mac에서 Finder 또는 Compressor를 사용하는 것입니다.
 PC가 있다면 Mac 사용자에게 대신 요청해야 할 것입니다.
 Compressor 앱은 Final Cut Pro에서만 제공되므로 사용자 지정 설정이 필요한 경우 고려해 볼 가치가 있지만 사용하지 않을 것입니다.
 

macOS Catalina부터 Finder에는 비디오를 변환하는 미디어 인코딩 도구가 내장되어 있습니다.
 간단하고 무료이므로 우리의 요구를 충족시킵니다.
 

Finder는 비디오 파일을 입력으로 예상하므로 먼저 이미지 시퀀스를 ProRes 4444로 변환해야합니다. 미디어 인코딩 도구는 비디오 만 허용하지 않으므로이 단계는 중요한 단계입니다.
 허용되는 형식입니다.
 입력 파일에 대한 올바른 인코딩을 찾을 때까지 두통이 한두 번있었습니다.
 

FFmpeg를 사용하여 입력 비디오를 만들 수 있습니다.
 WebM을 만들 때와 마찬가지로 적절한 인수로 FFmpeg를 실행하면됩니다.
 

```terminal
ffmpeg -framerate 25 -i unscreen-%3d.png -c:v prores_ks -pix_fmt yuva444p10le -alpha_bits 16 -profile:v 4444 -f mov -vframes 150 output.mov
```

이 시점부터 Mac이 필요합니다.
 하지만 그 과정은 간단하고 터미널에 아무것도 입력하지 않아도되므로 Mac을 사용하는 비전문가에게 대신 해달라고 부탁해도 관리 할 수있을 것입니다.
 

ProRes4444 비디오가 준비되면 Finder에서 포함 된 폴더로 이동하여 해당 폴더를 마우스 오른쪽 버튼으로 클릭하고 컨텍스트 메뉴에서 선택한 비디오 파일 인코딩을 선택할 수 있습니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_98A57A0DD339D864F100D762957B6D664DCBD0952931F9A3611A07022E1D267D_1605982255608_Screenshot2020-11-15at11.57.38.png?resize=1486%2C950&ssl=1)

창이 나타납니다.
 원하는 HEVC 품질 (선택할 수있는 두 가지가 있음)을 선택하고 투명도 유지 옵션을 선택합니다.
 그런 다음 "계속"버튼을 클릭합니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_98A57A0DD339D864F100D762957B6D664DCBD0952931F9A3611A07022E1D267D_1605982261247_Screenshot2020-11-15at11.58.08.png?resize=1622%2C1010&ssl=1)

잠시 후 알파로 HEVC로 인코딩 된 새 파일이 표시됩니다.
 끝났다!
 Safari에서이 파일을 열면 투명도가 작동하는지 확인합니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_98A57A0DD339D864F100D762957B6D664DCBD0952931F9A3611A07022E1D267D_1605982265494_Screenshot2020-11-15at11.58.38.png?resize=1518%2C852&ssl=1)

마지막으로 웹 사이트에서 동영상을 사용할 때입니다!
 

### 모든 브라우저에 투명한 동영상 제공
 

`<video>`요소를 사용하여 동영상을 제공 할 수 있습니다.
 브라우저가`src` 속성에서 지정된 형식을 지원하면 작동합니다.
 하지만 앞서 언급했듯이 Safari에는 HEVC를, 다른 브라우저에는 WebM을 제공해야합니다.
 

주의해야 할 것이 하나 더 있습니다. 일부 브라우저는 WebM 또는 HEVC 자체를 지원하지만 투명성은 없습니다.
 이러한 브라우저는 비디오를 재생하지만 알파 채널 대신 검정색 배경을 사용합니다.
 예를 들어 Safari 12는 투명도없이 HEVC를 재생합니다.
 그것은 우리에게 용납되지 않습니다.
 

일반적으로 저는 <source /> 요소를 사용하여 여러 형식과 함께 비디오를 대체 형식으로 제공하고 브라우저에서 지원하는 형식을 선택합니다.
 그러나 특정 Safari 버전에서만 HEVC를 표시하고자하므로 JavaScript를 사용하는 대신 video`src` 속성을 설정해야합니다.
 

투명성이있는 HEVC는 iOS 13 및 Mac Safari 13에서 지원되므로 먼저이를 감지 해 보겠습니다.
 지원에 따라 웹 사이트 기능을 조정하는 권장 방법은 사용자 에이전트를 보는 대신 API의 존재를 감지하는 것이지만 브라우저가 비디오 형식의 투명도를 지원하는지 여부를 감지하는 간단한 방법을 찾지 못했습니다.
 대신 내 자신의 해결책을 생각해 냈습니다.
 예쁘지는 않지만 일을합니다.
 

```js
function supportsHEVCAlpha() {
  const navigator = window.navigator;
  const ua = navigator.userAgent.toLowerCase()
  const hasMediaCapabilities = !!(navigator.mediaCapabilities && navigator.mediaCapabilities.decodingInfo)
  const isSafari = ((ua.indexOf('safari') != -1) && (!(ua.indexOf('chrome')!= -1) && (ua.indexOf('version/')!= -1)))
  return isSafari && hasMediaCapabilities
}
```

이는 이전 버전에서 지원되지 않는`navigator.mediaCapabilities`를 살펴보고 브라우저가 전혀 Safari인지 확인하여 Safari 13 이상을 대상으로합니다.
 함수가 `true`를 반환하면 HEVC 알파를 사용하는 것이 좋습니다.
 다른 경우에는 WebM 동영상을로드하겠습니다.
 

다음은 이것이 HTML에서 어떻게 결합되는지에 대한 예입니다.
 

```html
<video id="player" loop muted autoplay playsinline></video>

<script>
const player = document.getElementById('player');
player.src = supportsHEVCAlpha() ? 'output.mov' : 'output.webm';
</script>
```

동영상 요소에 대한 `loop muted autoplay playsinline`인수에 대해 궁금하다면 GIF와 같은 경험을 복제하는 방법이 있습니다.
 

- `음소거`가 없으면 사용자 상호 작용없이 동영상이 재생되지 않습니다.
 
- `playsinline`을 사용하면 iOS에서 동영상이 전체 화면으로 열리지 않고 레이아웃에서 바로 재생됩니다.
 
- 루프를 사용하면 동영상이 계속 반복됩니다.
 
- `자동 재생`을 사용하면 페이지로드시 자동으로 동영상 재생을 시작합니다 ( `음소거`도 함께 설정되어있는 한).
 

그게 다야!
 투명 비디오를위한 가볍고 성능이 뛰어난 고품질 솔루션이 있으며 대부분의 최신 브라우저에서 작동합니다 (최소 최신 버전의 Chrome, Firefox, Safari 및 Edge 2 개 이상).
 기본 HTML 및 CSS를 추가하여 정적 콘텐츠를 통합하고 좀 더 현실적으로 만들거나 데모에있는 것과 동일한 아이디어를 사용할 수 있습니다.
 그다지 나쁘지 않았죠?
 

> 하지만 IE 11은 어떻습니까?
 우리 회사 전체가 그것을 사용하고 있습니다!
 

일반적으로 이와 같은 기능을 최신 브라우저로 제한하고 IE에서 동영상을 숨기는 것이 좋습니다.
 동영상은 웹 사이트의 중요한 요소가 아닐 수 있습니다.
 하지만 저는 IE 11 지원이 필수 인 상업 프로젝트에서 작업 했었는데 거기에서 투명한 비디오를 보여줄 무언가를 찾아야했습니다.
 결국 JavaScript로 PNG 이미지를 순환했습니다.
 프레임 수를 줄이고 타이머를 사용하여 프레임 사이를 전환했습니다.
 물론 성능은 끔찍했지만 효과가있었습니다.
 이 비디오는 전체 디자인에 매우 중요했기 때문에 전체 경험을 제공하기 위해 의도적으로 IE 11의 성능을 희생하기로 결정했습니다.
 

### 요약
 verified_user

알파 투명 동영상에 대한 아이디어를 연구하는 시간을 절약했고 이제 웹 사이트에 이와 같은 애니메이션 요소를 통합 할 수 있기를 바랍니다.
 언젠가는 필요할 것입니다!
 

투명한 비디오를 사용하는 방법에 대해 다른 생각이 있습니까?
 아니면 이미 그것에 대한 경험이 있습니까?
 댓글로 알려주세요.
 