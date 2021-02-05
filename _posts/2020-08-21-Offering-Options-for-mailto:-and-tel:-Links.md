---
layout: post
title: "메일 수신: 및 텔: 링크에 대한 제공"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/08/mailgo-options.png
tags: MAILTO,TEL
---


나는 일반적으로 mailto: 링크를 좋아한다. 그러나 나는 "mail to:" 링크의 냄새를 맡을 수 있을 것 같다. 마치 엄청나게 쓸모없는 초능력처럼. 기본 메일 클라이언트 설정이 있는 경우 해당 링크를 클릭하면 원하는 작업이 수행되고, 원하는 경우 마우스 오른쪽 단추를 클릭하면 브라우저에 "전자 메일 주소 복사" 옵션이 제공되어 원하는 작업을 수행할 수 있습니다.

멋진 일이긴 하지만, Adam Silver와 Amy Hupe는 최근 이러한 링크의 작동 방식에 대한 문제점을 열거했습니다.

> 첫째, 전자 메일 주소를 다른 사람과 공유하려는 경우처럼 링크에 메일을 보내면 주소를 복사하기가 어렵습니다.
두 번째로, 일부 사용자는 둘 이상의 메일 앱을 사용하며, 링크는 다른 앱을 사용할 수 있는 선택권을 부여하지 않고 기본값으로 설정된 메일 앱을 사용합니다.
마지막으로, 많은 사용자들이 이메일 어플리케이션을 설정하지 않았습니다. 즉, 링크는 그들을 막다른 골목이나 토끼굴로 데려갈 수 있다는 뜻입니다.

이들의 UI 실험은 결국 `mail to:` 링크를 사용했지만, 전체 이메일 주소를 링크에 넣음으로써 링크가 무엇을 하는지 확실히 알 수 있게 하는 동시에, 약간의 UX 보너스를 위한 복사 버튼을 제공하게 되었다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/08/mailto3.png?resize=1024%2C328&ssl=1)

"전화:" 링크는 그들을 보는 많은 장치들이 어떠한 전화 접속 기능도 가지고 있지 않다는 점에서 더 이상하다. 이러한 경우 여러 앱이 이러한 작업을 수행할 수 있다는 점에서 이메일 링크와 유사합니다(예: WhatsApp, FaceTime 또는 기본 전화 앱).

이 모든 것의 UX의 어려운 부분은 사용자에게 이러한 특별한 링크 타입이 원하는 것에 대한 선택권을 제공한다는 것이다. 그것이 바로 메일고에서 해결하려는 것입니다. 클릭 시 UI를 제공하는 작은 JavaScript 라이브러리입니다.

라이브 데모:

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_RmeQEr" src="//codepen.io/anon/embed/RmeQEr?height=450&amp;theme-id=1&amp;slug-hash=RmeQEr&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed RmeQEr" title="CodePen Embed RmeQEr" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

약간 맘에 들어. 이러한 링크를 클릭할 때 이러한 정보가 표시되더라도 상관없습니다. 특히, 원하는 경우 "오픈 디폴트" 옵션이 있기 때문입니다. 모든 상자에 이러한 유형의 특수 링크가 가질 수 있는 문제가 있는지 확인하는 것 같습니다.