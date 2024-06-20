---
title: "9 JS를 사용하여 웹에서 Whatsapp 공유하기 고급 기능 UriBaba"
description: ""
coverImage: "/assets/img/2024-06-19-9WhatsappShareintheWebUsingJSAdvancedFeatureUriBaba_0.png"
date: 2024-06-19 00:38
ogImage: 
  url: /assets/img/2024-06-19-9WhatsappShareintheWebUsingJSAdvancedFeatureUriBaba_0.png
tag: Tech
originalTitle: "9. Whatsapp Share in the Web Using JS (Advanced Feature) @UriBaba"
link: "https://medium.com/@opensrc0/9-whatsapp-share-in-the-web-using-js-advanced-feature-uribaba-919fe89c1840"
---


## 고급 JavaScript 기능에 대한 심층 탐구

![이미지](/assets/img/2024-06-19-9WhatsappShareintheWebUsingJSAdvancedFeatureUriBaba_0.png)

JavaScript는 많이 발전해 왔고 전 세계에서 널리 사용되는 언어 중 하나입니다. 이 기사에서는 JavaScript의 고급 기능을 사용하여 웹에서 Whatsapp 공유 기능을 논의하고 있습니다. 이를 통해 휴대폰에서 Whatsapp이 열리고 사용자가 직접 Whatsapp에서 데이터를 공유할 수 있습니다. 코드와 함께 놀아 봅시다.

우리는 사용자 장치가 모바일인지 확인합니다. 모바일인 경우 공유할 휴대폰 번호나 메시지가 있어야 합니다. 둘 다 없는 경우에는 Whatsapp을 직접 열 수 없습니다. 웹의 경우 다른 URL로 리디렉션합니다.

<div class="content-ad"></div>

```js
if (navigator.userAgent.match(/iPhone|Android/i)) {
  if (mobile) {
    window.location.href = `https://wa.me/${mobile}/?text=${msg}`;
    console.log('성공적');
  } else if (msg) {
    window.location.href = `https://wa.me/?text=${msg}`;
    console.log('성공적');
  } else {
    console.log('에러');
  }
} else {
  window.location.href = `https://web.whatsapp.com/send?text=${msg}&phone=${mobile}`;
}
```

이제 봐요. 정말 멋지죠. window.location 리다이렉트를 사용하여 웹에서 Whatsapp 공유 기능을 사용할 수 있습니다(JavaScript의 고급 기능).

![이미지](/assets/img/2024-06-19-9WhatsappShareintheWebUsingJSAdvancedFeatureUriBaba_1.png)

fe-pilot npm 패키지로 웹 개발을 한 단계 높여보세요! https://github.com/opensrc0/fe-pilot


<div class="content-ad"></div>

이 혁신적인 JavaScript 라이브러리는 React로 제작되었으며, 웹 애플리케이션을 더욱 발전시키는 고급 기능을 제공합니다. fe-pilot는 일반적으로 상당한 코딩 노력이 필요한 고급 기능을 쉽게 통합하는 프로세스를 간소화합니다.

# 유용한 링크:

8. 공유: https://medium.com/@opensrc0/8-share-in-the-web-using-js-advanced-feature-uribaba-4bd0c7a1b210

9. 현재 당신은 Whatsapp 공유 기능을 읽고 있습니다.

<div class="content-ad"></div>

10. 곧 출시합니다.