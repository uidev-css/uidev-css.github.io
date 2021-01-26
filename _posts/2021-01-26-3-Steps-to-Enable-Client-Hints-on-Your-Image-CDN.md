---
layout: post
title: "Image CDN에서 클라이언트 힌트를 활성화하는 3 단계"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/12/imageengine-cdn.jpg
tags: 
---


클라이언트 힌트의 목표는 웹 경험이 제공되는 컨텍스트에 대해 서버에 알릴 때 브라우저 용 프레임 워크를 제공하는 것입니다.

> HTTP 클라이언트 힌트는 하이퍼 텍스트 전송 프로토콜에서 사전 컨텐츠 협상을 위해 제안 된 HTTP 헤더 필드 세트입니다.
 클라이언트는 이러한 필드를 통해 자신에 대한 정보를 알릴 수 있으므로 서버가 응답에 포함되어야하는 리소스를 결정할 수 있습니다.
— 위키 백과

해당 정보 (또는 힌트)를 사용하여 서버는 콘텐츠 협상이라고도하는 웹 경험을 개선하는 데 도움이되는 최적화를 제공 할 수 있습니다.
 이미지의 경우 더 나은 웹 경험은 더 빠른 로딩, 더 적은 데이터 페이로드, 간소화 된 코드베이스를 의미합니다.

클라이언트 힌트에는 고유 한 가치가 있지만 반응 형 이미지 구문과 함께 사용하여 반응 형 이미지를 덜 장황하고 유지 관리하기 쉽게 만들 수 있습니다.
 클라이언트 힌트를 사용하면 서버 측 (이 경우 이미지 CDN)은 실시간으로 이미지 크기를 조정하고 최적화 할 수 있습니다.

클라이언트 힌트는 2015 년 Chrome 35 이후로 한동안 사용되었습니다.
 그러나 대부분의 Chrome 브라우저에서는 버전 67의 개인 정보 보호 문제로 인해 부분적으로 지원이 중단되었습니다. 그 결과 클라이언트 힌트에 대한 액세스는 Android의 특정 Chrome 버전과 다른 Chrome 버전의 자사 출처로 제한되었습니다.

이제 마지막으로 Google은 Chrome 버전 84의 모든 기기에 대해 기본적으로 클라이언트 힌트를 활성화했습니다!

클라이언트 힌트를 사용하는 데 필요한 사항을 살펴 보겠습니다.

### 1) 클라이언트 힌트를 지원하는 이미지 CDN 선택

클라이언트 힌트를 지원하는 이미지 CDN은 많지 않습니다.
 Max Firtman은 클라이언트 힌트를 지원하는 이미지 CDN을 확인하는 광범위한 평가를 수행했습니다.
 ImageEngine은 고급 기능 외에도 전체 클라이언트 힌트 지원을 제공하는 최고의 이미지 CDN으로 돋보입니다.

ImageEngine은 이미지의 출처 (일반적으로 웹 위치 또는 S3 버킷)를 CDN 주소를 가리키는 도메인 이름에 매핑함으로써 대부분의 CDN과 같이 작동합니다.
 여기에서 무료 평가판에 등록하십시오.
 가입 후 평가판 사용자는`xxxzzz.cdn.imgeng.in`과 같은 전용 ImageEngine 배달 주소를 받게됩니다.
 ImageEngine 배달 주소는 CNAME DNS 레코드를 생성하여 자신의 도메인으로 맞춤 설정할 수도 있습니다.

다음 예제에서는 ImageEngine이 DNS의`images.example.com`에 매핑되어 있다고 가정합니다.

### 2) 브라우저에서 클라이언트 힌트 보내기

이제 평가판에 클라이언트 힌트를 완벽하게 지원하는 ImageEngine 계정이 있으므로 브라우저에 클라이언트 힌트를 ImageEngine에 보내기 시작하도록 지시해야합니다.
 이것은 기본적으로 웹 서버가 두 개의 특정 HTTP 헤더로 요청에 응답해야 함을 의미합니다.
 이 작업은 웹 사이트에서 수동으로 수행 할 수 있습니다. 예를 들어 사이트에서 WordPress를 실행중인 경우 플러그인을 사용할 수 있습니다.

헤더를 수동으로 추가하는 방법은 웹 사이트에 따라 다릅니다.

- 호스팅 제공 업체 또는 CDN은 아마도 http 헤더를 변경하는 설정을 제공 할 것입니다.
- 사이트 코드에 헤더를 추가 할 수 있습니다.
 이것이 수행되는 방법은 사용하는 프로그래밍 언어 또는 프레임 워크에 따라 다릅니다.
 "Add http headers <your programming language or framework>"을 검색해보십시오.
- 호스팅 제공자는 아파치를 실행하고 사용자가 .htaccess 구성 파일을 편집하도록 허용 할 수 있습니다.
 거기에 헤더를 추가 할 수도 있습니다.
- 예고편은 http-equiv 메타 요소를 사용하여`<head>`요소 내의 마크 업에 헤더를 추가 할 수도 있습니다.`<meta http-equiv = "Accept-CH"content = "DPR, Width, Viewport-Width">`
 .

첫 번째 헤더는 Accept-CH 헤더입니다.
 브라우저에 클라이언트 힌트 전송을 시작하도록 지시합니다.

```
Accept-CH: viewport-width, width, dpr
```

작성 당시 클라이언트 힌트를 타사에 위임하는 메커니즘은 기능 정책이라고합니다.
 그러나 권한 정책으로 이름이 변경 될 예정입니다.

그런 다음 클라이언트 힌트가 이미지 요청과 함께 1 단계에서 얻은 ImageEngine 배달 주소로 전송되도록하려면이 기능 정책 헤더도 서버 응답에 추가해야합니다.

기능 / 권한 정책은 어떤 출처 (도메인)가 어떤 브라우저 기능에 액세스 할 수 있는지 지정하는 HTTP 헤더입니다.

```
Feature-Policy: ch-viewport-width https://images.example.com;ch-width https://images.example.com;ch-dpr https://images.example.com;ch-device-memory https://images.example.com;ch-rtt https://images.example.com;ch-ect https://images.example.com;ch-downlink https://images.example.com
```

`example.com`은 일반 `xxxzzz.cdn.imgeng.in-type`이든 맞춤 배송 주소이든 ImageEngine을 참조하는 실제 주소로 바꿔야합니다.

함정 1 :`ch-` 접두사에 유의하십시오.
 표기법은`ch`– +`client-hint name`입니다.

함정 2 : 소문자 사용!
 문서와 예제가 예를 들어`Accept-CH : DPR`이라고 말하더라도 정책 헤더에`ch-dpr`을 사용해야합니다!

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/12/client-hints-inpsect-results.png?resize=512%2C305&ssl=1)

`accept-ch` 및 기능 정책 헤더가 설정되면 서버의 응답은 위의 화면 캡처와 유사합니다.

### 3) 크기 속성 설정

마지막으로, 마크 업의`<img>`요소를 업데이트해야합니다.

가장 중요한 것은`<img>`요소의 src가 ImageEngine 전달 주소를 가리켜 야한다는 것입니다.
 1 단계에서 사용하고 2 단계의 기능 정책 헤더에 언급 된 것과 동일한 주소인지 확인합니다.

다음으로,`<img>`요소에 sizes 속성을 추가합니다.
 크기는 브라우저가 이미지가 표시되는 특정 픽셀 크기를 계산할 수 있도록하는 반응 형 이미지 구문의 일부입니다.
 이 크기는 너비 클라이언트 힌트에서 이미지 CDN으로 전송됩니다.

```html
<img src="https://images.example.com/test.jpg" sizes="200px" width="200px" alt="image">
```

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/12/client-hints-img-w-delivery-address.png?resize=643%2C215&ssl=1)

CSS 또는 width 속성에 설정된 너비가 알려진 경우 해당 값을 크기로 복사하여 반응 형 이미지를 "개선"할 수 있습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/12/client-hints-example-request-headers.png?resize=512%2C423&ssl=1)

`<img>`요소에 이러한 작은 변경이 수행되면 ImageEngine에 대한 이미지 요청에는 위의 화면 캡처에 설명 된 것과 같은 클라이언트 힌트가 포함됩니다.
 "width"헤더는 ImageEngine에 이미지가 웹 페이지에 완벽하게 맞아야하는 정확한 크기를 알려줍니다.

### 완벽한 픽셀 이미지 즐기기

이제 Chrome 버전 84 이하와 같은 지원 브라우저에서 테스트하면 클라이언트 힌트가`images.example.com`으로 전달되어야합니다.

`<img>`요소는 짧고 간결하며 클라이언트 힌트가없는 클래식 클라이언트 측 구현보다 훨씬 더 잘 조정 된 반응 형 이미지를 제공하도록 조작되었습니다.
 코드가 적고 웹 서버에서 여러 크기의 이미지를 생성 할 필요가 없으며 리소스 선택은 여전히 브라우저에서 수행되지만 이미지 CDN에서 제공됩니다.
 두 세계에서 최고!

트라이얼 러는 glitch.com의이 참조 구현에서 작동중인 배관을 볼 수 있습니다.
 Chrome 버전 84 이상에서이를 테스트하십시오!

클라이언트 힌트를 지원하는 ImageEngine과 같은 이미지 CDN을 사용하면 위의 단계를 따를 때 사이트에서 필요 이상으로 큰 이미지를 제공하지 않습니다.
 또한 ImageEngine은 더 일반적인 이미지 형식 외에도 WebP, JPEG2000 및 MP4와 같은 형식간에 이미지를 최적화하고 변환합니다.

또한 위의 예에는 몇 가지 네트워크 또는 연결 관련 클라이언트 힌트가 포함되어 있습니다.
 ImageEngine은이 정보에 따라 이미지를 최적화 할 수도 있습니다.

클라이언트 힌트를 지원하지 않는 브라우저는 어떻습니까?
 ImageEngine은 CDN 에지의 고급 장치 감지 덕분에 이미지를 계속 최적화하고 크기를 조정합니다.
 이렇게하면 모든 장치와 브라우저에서 항상 적절한 크기의 이미지를 얻을 수 있습니다.

ImageEngine은 무료 평가판을 제공하며 누구나 여기에 등록하여 웹 사이트에서 클라이언트 힌트 구현을 시작할 수 있습니다.