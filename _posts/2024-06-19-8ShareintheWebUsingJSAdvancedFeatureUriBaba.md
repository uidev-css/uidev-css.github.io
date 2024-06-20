---
title: "8 웹에서 JS를 사용하여 공유하기 고급 기능 UriBaba"
description: ""
coverImage: "/assets/img/2024-06-19-8ShareintheWebUsingJSAdvancedFeatureUriBaba_0.png"
date: 2024-06-19 00:19
ogImage: 
  url: /assets/img/2024-06-19-8ShareintheWebUsingJSAdvancedFeatureUriBaba_0.png
tag: Tech
originalTitle: "8. Share in the Web Using JS (Advanced Feature) @UriBaba"
link: "https://medium.com/@opensrc0/8-share-in-the-web-using-js-advanced-feature-uribaba-4bd0c7a1b210"
---


## 고급 JavaScript 기능으로의 심층 탐구

![이미지](/assets/img/2024-06-19-8ShareintheWebUsingJSAdvancedFeatureUriBaba_0.png)

자바스크립트는 많이 발전해 왔으며 세계에서 널리 사용되는 언어 중 하나입니다. 이 기사에서는 고급 자바스크립트를 사용하여 웹에서 공유 기능에 대해 논의합니다. 이 기능을 사용하면 핸드폰의 앱 목록을 열고 사용자가 어떤 앱에서든 공유할 수 있습니다. 코드와 함께 놀아봅시다.

여러 브라우저에서 실패할 수 있기 때문에 Web API의 지원을 확인하고 있습니다.

<div class="content-ad"></div>

```js
// window 대신 globalThis를 사용할 수 있어요
const isBrowserSupport = () => globalThis.navigator?.share;
```

웹 공유 API는 web-share 권한 정책에 의해 제한됩니다. 권한은 지원되지만 부여되지 않았을 경우 canShare() 메서드는 false를 반환할 것입니다.

```js
const isShareAPIDataValid = (sharingData) => {
  if (navigator.canShare) {
    return navigator.canShare(sharingData);
  }
  
  return true;
};
```

그 다음 단계에서는 navigator.share를 사용하여 휴대폰 앱 목록을 열어서 사용자가 어떤 앱에서든 공유할 수 있도록 합시다.

<div class="content-ad"></div>

```js
const sharingData = { 
  title: '제목', 
  text: '설명', 
  url: 'https://medium.com/@opensrc0/5-scanner-qr-bar-code-upi-in-the-web-using-js-advanced-feature-uribaba-8407f08ddefd' 
};

navigator.share(sharingData)
  .then(() => console.log(sharingData))
  .catch((error) => console.log(error));
```

여기까지입니다. 정말 멋지죠. JavaScript의 고급 기능인 navigator.share를 사용하여 웹에서 공유 기능이 가능합니다. 아래는 결합된 코드입니다.

```js
const isBrowserSupport = () => globalThis.navigator?.share;

const isShareAPIDataValid = (sharingData) => {
  if (navigator.canShare) {
    return navigator.canShare(sharingData);
  }
  
  return true;
};

if (isBrowserSupport()) {
  if (isShareAPIDataValid(sharingData)) {
    navigator.share(sharingData)
      .then(() => console.log('성공'))
      .catch((e) => console.log('오류'));
  } else {
    console.log('허가 거부');
  }
} else {
  console.log('지원하지 않는 기능');
}
```

![이미지](/assets/img/2024-06-19-8ShareintheWebUsingJSAdvancedFeatureUriBaba_1.png)


<div class="content-ad"></div>

웹 개발을 fe-pilot npm 패키지로 업그레이드하세요! https://github.com/opensrc0/fe-pilot

React로 개발된 이 혁신적인 JavaScript 라이브러리는 웹 애플리케이션을 한 단계 높여주는 최신 기능을 제공합니다. fe-pilot은 일반적으로 많은 코딩 노력이 필요한 고급 기능을 쉽게 통합하는 프로세스를 간소화합니다.

# 유용한 링크:

7. 이미지 처리 및 QR 코드/바코드/UPI 세부 정보 가져오기: https://medium.com/@opensrc0/7-scanning-an-image-qr-bar-code-upi-in-the-web-using-js-advanced-feature-uribaba-d491139f5c02

<div class="content-ad"></div>

8. 지금은 Share Features를 읽고 계십니다.

9. Whatsapp Share: [https://medium.com/@opensrc0/9-whatsapp-share-in-the-web-using-js-advanced-feature-uribaba-919fe89c1840](https://medium.com/@opensrc0/9-whatsapp-share-in-the-web-using-js-advanced-feature-uribaba-919fe89c1840)