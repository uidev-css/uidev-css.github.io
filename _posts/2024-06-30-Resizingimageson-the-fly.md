---
title: "이미지를 실시간으로 크기 조절하는 방법"
description: ""
coverImage: "/assets/img/2024-06-30-Resizingimageson-the-fly_0.png"
date: 2024-06-30 23:03
ogImage: 
  url: /assets/img/2024-06-30-Resizingimageson-the-fly_0.png
tag: Tech
originalTitle: "Resizing images on-the-fly"
link: "https://medium.com/apache-apisix/resizing-images-on-the-fly-d942485a9608"
---



![Resizing images on the fly](/assets/img/2024-06-30-Resizingimageson-the-fly_0.png)

웹 아키텍트로서 자산 관리는 많은 문제 중 하나입니다. 그리고 자산 중에서도 가장 중요한 문제는 이미지입니다. 하나의 단순한 접근 방식은 이미지를 설정하고 브라우저가 CSS를 통해 이미지를 크기 조정하도록 하는 것입니다:

```css
img {
    height: 100%;
    width: 100%;
    object-fit: contain;
}
```

하지만 이는 원본 이미지를 다운로드한다는 뜻입니다. 이로써 원본 이미지의 크기와 최적화되지 않은 브라우저 기반 크기 조정 두 가지 문제가 발생합니다.


<div class="content-ad"></div>

이 포스트에서는 두 가지 대안을 다룹니다: 전통적인 방법과 새로운 솔루션.

# 미리 크기 조정하기

단일 이미지 원본에 대한 전통적인 솔루션은 미리 크기를 조정하는 것이었습니다. 출시하기 전에 디자이너들은 다양한 해상도의 여러 이미지 버전을 제공하는 데 시간을 할애했습니다. 이 블로그에서는 이 기술을 사용하고 있습니다. 포스트의 주 이미지를 다양한 맥락에서 백그라운드 이미지로 표시하기 위해 세 가지 해상도를 제공합니다:

- 페이지의 포스트용 큰 크기
- 홈페이지의 포스트용 중간 크기
- 포스트 페이지에서 관련 포스트용 작은 크기

<div class="content-ad"></div>

저는 더 높은 용량 감소를 위해 JPEG 메타데이터도 제거합니다.

하지만 전통적인 방식은 HTML picture 태그를 활용하는 것입니다:

그리고 다음과 같이 사용할 수 있습니다:

```js
<picture>
    <source media="(max-width: 199px)" srcset="ai-generated-200.jpg" />
    <source media="(max-width: 399px)" srcset="ai-generated-400.jpg" />
    <source media="(max-width: 599px)" srcset="ai-generated-600.jpg" />
    <source media="(max-width: 799px)" srcset="ai-generated-800.jpg" />
    <source media="(max-width: 999px)" srcset="ai-generated-1000.jpg" />
    <img src="ai-generated.jpg" />
</picture>
```

<div class="content-ad"></div>

이 방식은 오랫동안 잘 작동했지만 두 가지 문제가 있습니다. 먼저, 각 이미지에 대해 여러 해상도를 제공하는 작업은 시간이 많이 소요됩니다. 이를 자동화하여 AI를 사용하면 좋은 결과를 얻을 수 있습니다.

그러나 필요한 저장 용량은 추가로 생성된 해상도의 수에 따라 원본 이미지의 두배 또는 세배가 될 수 있습니다. 자산이 풍부한 환경에서 예를 들어 전자 상거래와 같은 경우 비용이 크게 증가할 수 있습니다.

# 실시간 크기 조정

최근에 imgproxy라는 이미지 크기를 실시간으로 조정하는 구성 요소를 우연히 발견했습니다:

<div class="content-ad"></div>

imgproxy는 다음을 정의하는 인코딩된 URL을 보낼 수 있는 엔드포인트를 제공합니다:
- 변경할 이미지와 위치(로컬, HTTP URL, S3 버킷 등)
- 다양한 크기 조정 매개변수, 예를 들어, 차원, 맞출지 채울지 여부 등
- 형식. imgproxy는 JPEG 및 PNG과 같은 표준 형식을 지원하지만 WebP 및 AVIF와 같은 더 현대적인 형식도 지원합니다. 또한 'Accept' 헤더에 따라 최적의 형식을 선택할 수 있습니다.
- 워터마킹, 필터링, 회전 등 많은(정말 많은!) 다른 옵션들

imgproxy는 오픈 소스 무료 버전과 유료 버전을 제공합니다. 이 포스트에 포함된 모든 내용은 전자의 일부입니다.

한 가지 해결책은 웹 개발자가 HTML에 각 imgproxy URL을 직접 코딩하는 것입니다.

<div class="content-ad"></div>


<picture>
    <source media="(max-width: 199px)" srcset="http://imgproxy:8080//rs:fill/w:200/plain/http://server:3000/ai-generated.jpg@webp" />
    <source media="(max-width: 399px)" srcset="http://imgproxy:8080//rs:fill/w:400/plain/http://server:3000/ai-generated.jpg@webp" />
    <source media="(max-width: 599px)" srcset="http://imgproxy:8080//rs:fill/w:600/plain/http://server:3000/ai-generated.jpg@webp" />
    <source media="(max-width: 799px)" srcset="http://imgproxy:8080//rs:fill/w:800/plain/http://server:3000/ai-generated.jpg@webp" />
    <source media="(max-width: 999px)" srcset="http://imgproxy:8080//rs:fill/w:1000/plain/http://server:3000/ai-generated.jpg@webp" />
    <img src="ai-generated.jpg" />
</picture>


웹 페이지에 대한 토폴로지 관련 세부 정보가 노출됩니다. 이는 유지 관리하기 어려운 해결책입니다. 리버스 프록시나 API 게이트웨이를 사용하여 문제를 해결할 수 있습니다. 명백한 이유로 Apache APISIX를 사용하겠습니다.

이 방법을 통해 위의 HTML이 훨씬 간단해집니다:


<picture>
    <source media="(max-width: 199px)" srcset="/resize/200/ai-generated.jpg" />
    <source media="(max-width: 399px)" srcset="/resize/400/ai-generated.jpg" />
    <source media="(max-width: 599px)" srcset="/resize/600/ai-generated.jpg" />
    <source media="(max-width: 799px)" srcset="/resize/800/ai-generated.jpg" />
    <source media="(max-width: 999px)" srcset="/resize/1000/ai-generated.jpg" />
    <img src="ai-generated.jpg" />
</picture>


<div class="content-ad"></div>

Apache APISIX은 /resize로 시작하는 요청을 가로채어 URL을 imgproxy로 재작성하여 imgproxy에 재작성된 URL을 전달합니다. 전체 흐름은 다음과 같습니다:

![image](/assets/img/2024-06-30-Resizingimageson-the-fly_1.png)

해당 Apache APISIX 구성은 다음과 같습니다:

```js
routes:
  - uri: /resize/*
    plugins:
      proxy-rewrite:
        regex_uri:
          - /resize/(.*)/(.*)
          - /rs:fill/w:$1/plain/http://server:3000/$2@webp
    upstream:
      nodes:
        "imgproxy:8080": 1
```

<div class="content-ad"></div>

- **/resize**로 시작하는 요청 일치시키기
- URL 다시 작성
- 정규 표현식에서 너비와 이미지 캡처
- 이미지 프록시를 위한 URL 형식화. http://server:3000은 원본 이미지를 호스팅하는 서버이며, @webp은 브라우저가 지원하는 경우 WebP 형식을 선호함을 나타냄

위와 같이, Apache APISIX에게서 **/resize/200/ai-generated.jpg**를 받으면 imgproxy에서 **/rs:fill/w:200/plain/http://server:3000/ai-generated.jpg@webp**로 다시 작성됩니다.

# 테스트

Docker Compose를 사용하여 작은 테스트 샘플을 설정할 수 있습니다:

<div class="content-ad"></div>

```yaml
services:
  apisix:
    image: apache/apisix:3.5.0-debian
    volumes:
      - ./apisix/config.yml:/usr/local/apisix/conf/config.yaml:ro
      - ./apisix/apisix.yml:/usr/local/apisix/conf/apisix.yaml:ro
    ports:
      - "9080:9080"
  imgproxy:
    image: darthsim/imgproxy:v3.19
  server:                                                         #1
    build: content
```

- HTML 및 주 이미지를 호스팅하는 간단한 웹 서버

이제 위 설정을 브라우저의 개발자 도구를 사용하여 테스트할 수 있습니다. 작은 화면 장치인 iPhone SE를 흉내 내는 것입니다. 결과는 다음과 같습니다:

<img src="/assets/img/2024-06-30-Resizingimageson-the-fly_2.png" />


<div class="content-ad"></div>

- 화면 해상도 때문에 요청된 이미지는 원본 이미지가 아닌 400px 폭 이미지입니다. 요청 URL에서 확인할 수 있어요.
- 반환된 이미지는 WebP 형식이며, 용량은 14.4kb입니다.
- 원본 JPEG 이미지는 154kb로, 10배나 더 많은 용량을 차지합니다. 네트워크 대역폭을 아주 많이 절약하는 것이죠!

# 토론

저장 비용을 10배 줄이는 것은 당연히 큰 이점입니다. 하지만 모든 것이 완벽한 것은 아닙니다. 이미지 크기를 조정하는 것은 계산에 많은 비용이 드는 작업이에요. 각 요청마다 CPU 시간이 소요됩니다. 또한 imgproxy가 얼마나 효율적이든 이미지 생성에는 시간이 걸립니다. 우리는 저장 비용을 CPU 비용으로 교환하고, 결과적으로 성능에 약간의 저하가 발생합니다.

이를 해결하려면 앞 단에 캐싱 레이어가 필요합니다. 커스텀 캐싱이나 더 가능한 CDN 등을 사용할 수 있어요. 자산을 다시 저장할 것이라는 이의가 있을 수 있습니다. 따라서 저장 비용이 다시 증가할 거라는 거죠. 그러나 캐시는 사용된 이미지에만 작동하며, 이전 솔루션에서는 모든 이미지를 저장하기 위해 비용을 지불했습니다. 이외에도, 이미지가 필요한 경우에 캐시를 미리 로딩하는 등 캐싱에 대한 이미 알려진 레시피를 적용할 수도 있어요. 예를 들어, 이벤트 전에 필요한 이미지 그룹을 미리 로딩하는 것 등이죠.

<div class="content-ad"></div>

# 결론

이 게시물에서는 Apache APISIX와 imgproxy를 사용하여 여러 해상도의 이미지 저장 비용을 줄이는 방법을 설명했습니다. 캐싱을 추가하면 전체 아키텍처에 더 많은 구성 요소가 추가되지만 저장 비용이 줄어듭니다.

이 게시물은 Andreas Lehr의 StackConf 발표에서 영감을 받았습니다.

이 게시물의 전체 소스 코드는 GitHub에서 찾을 수 있습니다.

<div class="content-ad"></div>

더 알아보기:

- imgproxy 문서
- imgproxy 인터랙티브 데모

2023년 10월 1일에 A Java Geek에서 처음 발행되었습니다.