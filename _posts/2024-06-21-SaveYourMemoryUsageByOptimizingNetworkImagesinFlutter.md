---
title: "Flutter에서 네트워크 이미지 최적화로 메모리 사용량 줄이는 방법"
description: ""
coverImage: "/assets/img/2024-06-21-SaveYourMemoryUsageByOptimizingNetworkImagesinFlutter_0.png"
date: 2024-06-21 21:32
ogImage: 
  url: /assets/img/2024-06-21-SaveYourMemoryUsageByOptimizingNetworkImagesinFlutter_0.png
tag: Tech
originalTitle: "Save Your Memory Usage By Optimizing Network Images in Flutter"
link: "https://medium.com/make-android/save-your-memory-usage-by-optimizing-network-image-in-flutter-cbc9f8af47cd"
---



![이미지](/assets/img/2024-06-21-SaveYourMemoryUsageByOptimizingNetworkImagesinFlutter_0.png)

플러터에서 네트워크 이미지를 가져와 표시할 때 기억해야 할 중요한 요소는 무엇인가요?

이미지 위젯을 사용할 때 더 나은 사용자 경험(UX)을 제공하기 위해 네트워크에서 이미지를로드하기 전에 페이드-인 애니메이션을 적용하거나 로딩 표시기를 표시하는 것을 고려할 수 있습니다.

이러한 UX 고려사항이 중요하지만 네트워크 이미지를 렌더링할 때 메모리 사용량을 줄이는 것도 중요합니다. 이는 더 큰 이미지가 렌더링 프로세스 중에 상당한 양의 메모리를 요구하기 때문입니다.


<div class="content-ad"></div>

이를 설명하기 위해 개인 프로젝트 예시를 공유하고 싶습니다. 내 앱에서 화면이 버벅거리고 비정상적으로 종료되는 문제가 발생했습니다. 앞서 언급했듯이, 문제의 원인은 화면에 고해상도 네트워크 이미지를 표시할 때 과도한 메모리 사용이었습니다.

![이미지](/assets/img/2024-06-21-SaveYourMemoryUsageByOptimizingNetworkImagesinFlutter_1.png)

동일한 실수를 피하려면, 화면에 이미지를 로드할 때 렌더링을 최적화하는 방법을 이해해야 합니다. 이 게시물에서는 메모리 사용량을 줄이면서 효과적으로 네트워크 이미지를 렌더링하는 방법을 소개하겠습니다. 유용한 팁을 모아두세요!

# 과도하게 큰 이미지 진단하기

<div class="content-ad"></div>

먼저, 네트워크 이미지를 렌더링할 때 메모리 사용량이 과도한지 진단하는 것이 중요합니다. 간단한 예를 통해 이를 확인해 보겠습니다.

<img src="/assets/img/2024-06-21-SaveYourMemoryUsageByOptimizingNetworkImagesinFlutter_2.png" />

```js
Image.network(
    imageUrl,
    width: 250,
),
```

위의 이미지 위젯이 효율적으로 렌더링되었습니까? 알아내는 간단한 방법이 있습니다.

<div class="content-ad"></div>

아래는 Markdown 형식으로 변경한 표입니다.

![이미지1](/assets/img/2024-06-21-SaveYourMemoryUsageByOptimizingNetworkImagesinFlutter_3.png)

Flutter Inspector에서 "Highlight oversized images" 버튼을 활성화하세요.

![이미지2](/assets/img/2024-06-21-SaveYourMemoryUsageByOptimizingNetworkImagesinFlutter_4.png)

그러면 화면에 표시된 이미지가 색상이 반전되고 수직으로 뒤집힌 것을 알 수 있습니다. 이는 이미지 디코딩 과정에서 필요한 것보다 더 많은 메모리가 사용되었다는 것을 나타냅니다.

<div class="content-ad"></div>

# 화면 크기 및 디코딩 크기

에러 로그를 확인하면 더 구체적인 정보를 얻을 수 있습니다.

```js
Image [...]의 화면 크기는 750×421이지만 디코딩 크기는 3840×2160으로,
기기 픽셀 비율이 3.0을 가정했을 때 추가적인 41552KB를 사용합니다.
```

화면에 표시된 이미지의 크기는 750x421이지만, 디코딩된 크기는 3840×2160으로, 추가로 41552KB의 메모리를 사용하고 있습니다.

<div class="content-ad"></div>

디스플레이 크기는 이미지를 디코딩하는 크기를 나타냅니다. 다시 말해, 화면에 실제로 표시될 때, 필요한 디스플레이 크기는 750×421에 불과합니다. 따라서 이미지의 전체 원본 크기, 3840×2160(디코드 크기),를 디코딩하는 것은 불필요합니다.

더 쉽게 이해하기 위해 비유를 들어보겠습니다.

![이미지](/assets/img/2024-06-21-SaveYourMemoryUsageByOptimizingNetworkImagesinFlutter_5.png)

친구와 찍은 사진을 기반으로 화가에게 그림을 그리도록 부탁했다고 상상해보세요. 화가에게 사진을 제공할 때, 그림을 만드는 데 필요한 것보다 훨씬 큰 대형 게시판 크기의 사진을 제공할 필요는 없습니다. 사실, 그러한 큰 사진은 화가의 작업을 방해할 수 있습니다.

<div class="content-ad"></div>


![이미지](/assets/img/2024-06-21-SaveYourMemoryUsageByOptimizingNetworkImagesinFlutter_6.png)

정확하고 빠른 그림을 그리려면 예당 크기의 사진만 있으면 됩니다. 이 개념은 Flutter에서 네트워크 이미지를 로드할 때도 적용됩니다. 이미지의 크기가 화면에 표시될 크기(표시 크기)보다 훨씬 크면 Flutter 엔진이 디코딩 프로세스 중에 메모리를 낭비합니다.

# 이미지 크기 조정

그렇다면 이미지의 크기를 어떻게 조정해야 할까요? 다음 오류 로그는 이미지 크기를 조정하는 방법에 대한 안내를 제공합니다.


<div class="content-ad"></div>

```js
이제 코드 수정을 통해 기록에 기반한 변경을 가해보겠습니다.

Image.network(
  imageUrl,
  width: 250,
  cacheWidth: 750,
),
const Divider(),
Image.network(
  imageUrl,
  width: 250,
),

<div class="content-ad"></div>

비교를 위해 cacheWidth 속성이 설정되지 않은 위젯을 추가했습니다. (한 가지 캐시 속성을 설정하면 다른 이미지도 비율을 유지하면서 크기를 조정할 수 있습니다)

![image](/assets/img/2024-06-21-SaveYourMemoryUsageByOptimizingNetworkImagesinFlutter_7.png)

cacheWidth를 설정한 이미지는 과도한 오류 없이 표시되지만, 다른 이미지는 색상과 방향이 반전되고 수직으로 뒤집힙니다. cacheWidth를 올바르게 설정함으로써 이미지의 크기를 조정하여 디코딩 프로세스에서 메모리 사용량을 최적화했습니다.

# 장치별 화소 비율

<div class="content-ad"></div>

그러나 여전히 문제가 발생할 수 있습니다.

![image](/assets/img/2024-06-21-SaveYourMemoryUsageByOptimizingNetworkImagesinFlutter_8.png)

cacheWidth가 설정된 동일한 코드에서 iPhone 12 mini에서 이미지가 올바르게 표시되지만, 화면 크기가 작은 iPhone SE에서는 여전히 크기가 너무 크다는 표시가 있습니다.

이 문제가 발생하는 이유는 무엇일까요? 오류 로그를 다시 확인해 보죠.

<div class="content-ad"></div>

## iPhone 12 미니

Image [...]의 디스플레이 크기는 750×421이지만 디코딩 크기는 3840×2160으로, 기기 픽셀 비율을 3.0으로 가정할 때 추가 41552KB가 사용됩니다.

미리 자산의 크기를 조정하거나 cacheWidth 매개변수를 750, cacheHeight 매개변수를 421로 제공하거나 ResizeImage를 사용하는 것을 고려해보세요.

iPhone 12 미니의 경우, 이미지의 디스플레이 폭은 750이며, 기기 픽셀 비율은 3.0입니다.

## iPhone SE

<div class="content-ad"></div>

이미지 [...]는 표시 크기가 500×281이지만 디코딩 크기는 3840×2160 이며, 장치 픽셀 비율이 2.0일 때 추가로 42467KB를 사용합니다.

미리 에셋 크기를 조정하고, cacheWidth 매개변수를 500, cacheHeight 매개변수를 281로 제공하거나 ResizeImage를 사용하는 것을 고려해보세요.

반면에 iPhone SE의 경우, 이미지의 표시 크기는 500이며, 장치 픽셀 비율은 2.0입니다.

이 차이는 각 장치의 다른 디바이스 픽셀 비율 때문에 발생합니다.

디바이스 픽셀 비율은 디바이스 화면에 표시되는 픽셀 밀도를 나타내며, 특정 장치의 화면 크기 당 픽셀 수를 나타냅니다.
```

<div class="content-ad"></div>

![image](/assets/img/2024-06-21-SaveYourMemoryUsageByOptimizingNetworkImagesinFlutter_9.png)

화소 밀도는 일반적으로 특정 디바이스의 화면 크기에 따라 다양한 값을 갖는 ppi(인치당 픽셀)로 측정됩니다. 예를 들어 고해상도 장치는 화면 크기 당 픽셀이 더 많아 더 높은 화소 밀도를 가지게 됩니다.

요약하자면, iPhone SE는 디바이스 픽셀 비율이 2.0이며, 이는 물리적 픽셀 당 2개의 픽셀을 표시한다는 것을 의미하며, iPhone 12 mini는 디바이스 픽셀 비율이 3.0이며, 즉 물리적 픽셀 당 3개의 픽셀을 표시합니다. 따라서 iPhone 12 mini를 기준으로 cacheWidth를 설정할 때, iPhone SE의 낮은 픽셀 비율로 인해 여전히 불필요한 디코딩 크기가 남아 있습니다.

# 이미지 캐시 크기 동적으로 결정하기

<div class="content-ad"></div>

이제 모든 단서가 모였으니, 기기의 픽셀 비율을 기반으로 cacheWidth 값을 계산할 수 있어요.

```js
250 (위젯 크기) X 2 (iPhone SE 기기 픽셀 비율) = 500 (캐시 크기)
```

250의 목표 위젯 크기와 iPhone SE의 1인치 당 2픽셀의 표시 방법을 고려하여, 위젯 크기에 기기 픽셀 비율을 곱하면 적절한 디스플레이 크기인 500이 나옵니다.

다음은 코드 표현입니다.

<div class="content-ad"></div>


이미지 네트워크 (
  imageUrl,
  width: 250,
  cacheWidth: (250 * MediaQuery.of(context).devicePixelRatio).round(),
)


MediaQuery를 사용하여 장치의 픽셀 비율을 결정하고 이미지 위젯의 너비와 곱하여 cacheWidth 값을 설정합니다. cacheWidth 속성은 정수 값을 필요로 하므로 round 메소드를 사용하여 가장 가까운 정수로 반올림합니다. 이 코드를 사용하면 장치의 픽셀 비율에 따라 이미지 크기를 조정할 수 있습니다.

더불어 코드를 더 간결하게 만들기 위해 이미지 크기 계산을 확장(extension)으로 구현할 수 있습니다. 확장을 사용한 코드 예시는 다음과 같습니다.


확장 ImageExtension on num {
  int cacheSize(BuildContext context) {
    return (this * MediaQuery.of(context).devicePixelRatio).round();
  }
}


<div class="content-ad"></div>

그럼, 이미지 위젯의 확장 기능을 사용하여 필요한 캐시 값을 간결하게 설정할 수 있어요.

```js
Image.network(  
  imageUrl,  
  width: 250,  
  cacheWidth: 250.cacheSize(context),  
)
```

# 캐시 크기 지정 고려 사항

원본 이미지의 종횡비가 대상 위젯의 종횡비와 다를 때, 그리고 이미지 위젯에 fit: BoxFit.cover를 사용할 때 캐시 크기를 설정할 때 특정 측면을 고려해야 해요. 일반적으로 fit: BoxFit.cover를 사용하면 이미지가 위젯에 맞게 잘립니다. 이러한 경우에는 이미지의 표시 크기를 결정할 때 종횡비를 고려해야 해요.

<div class="content-ad"></div>

만약 원본 이미지와 위젯의 종횡비가 다르다면, 이미지를 최적화하는 동안 원본 이미지의 종횡비를 유지하기 위해 작은 차원(너비 또는 높이)을 기준으로 캐시 크기를 설정해야 합니다.

그 반대로 설정하면 해상도가 낮은 이미지가 표시될 수 있습니다.

예를 살펴보겠습니다.

```js
Image.network(  
  imageUrl,  
  width: 250,  
  height: 250,  
  cacheWidth: 250.cacheSize(context),  
  fit: BoxFit.cover,
)
```

<div class="content-ad"></div>


![Network Images in Flutter](/assets/img/2024-06-21-SaveYourMemoryUsageByOptimizingNetworkImagesinFlutter_10.png)

- 이미지 크기: 3000 x 1688
- 이미지 가로 세로 비율: 1.7
- 디코딩된 이미지의 표시 크기: 500 x 282
- 이미지 위젯 크기: 250 x 250
- 이미지 위젯 가로 세로 비율: 1

이미지 위젯은 250 x 250 크기이며 디바이스의 픽셀 비율을 곱한 값인 500을 cacheWidth로 설정하면 이미지의 표시 높이를 자동으로 결정하고 이미지의 가로 세로 비율을 유지합니다. 그러나 원본 이미지의 가로가 세로보다 큰 비율을 가지고 있고, 이는 위젯의 표시에 필요한 가로 세로 비율과 다르기 때문에, 디코딩된 이미지의 표시 높이(281)가 목표 표시 높이(500)보다 낮아져 이미지가 흐릿하게 보일 수 있습니다. 예시 사진에 나와 있습니다.

반면, cacheHeight를 설정하면…


<div class="content-ad"></div>

```js
Image.network(
  imageUrl,
  width: 250,
  height: 250,
  cacheHeight: 250.cacheSize(context),
  fit: BoxFit.cover,
)
```

<img src="/assets/img/2024-06-21-SaveYourMemoryUsageByOptimizingNetworkImagesinFlutter_11.png" />

캐시 높이를 설정하면 이미지의 종횡비를 유지하면서 최소 표시 크기로 크기를 조정하여 이미지의 해상도를 유지합니다.

기존의 오버사이즈된 오류 로그는 여전히 발생하지만, 이미지의 크기를 크게 줄이고 종횡비를 유지하여 선명한 이미지를 제공하도록 최적화되었습니다.

<div class="content-ad"></div>

# 이미지 종횡비를 고려한 캐시 크기 동적 설정

대부분의 경우에는 프런트엔드 개발자가 네트워크 이미지의 종횡비를 사전에 알지 못합니다. 이러한 상황에서는 원본 이미지의 종횡비가 0보다 큰지 여부를 기반으로 캐시 크기를 동적으로 결정할 수 있습니다.

```js
Builder(  
  builder: (context) {  
    int? cacheWidth, cacheHeight;  
    Size targetSize = const Size(250, 250);  
    const double originImgAspectRatio = 1.7;  
   
    // 원본 이미지의 종횡비가 0보다 큰 경우, 이미지가 세로보다 넓은 것을 의미합니다.
    if (originImgAspectRatio > 0) {  
      cacheHeight = targetSize.height.cacheSize(context);  
    } else {  
      cacheWidth = targetSize.width.cacheSize(context);  
    }  
  
    return Image.network(  
      imageUrl,  
      width: targetSize.width,  
      height: targetSize.height,  
      cacheWidth: cacheWidth,  
      cacheHeight: cacheHeight,  
      fit: BoxFit.cover,  
    );  
  },  
)
```

위 코드에서는 원본 이미지의 종횡비(originImgAspectRatio)를 사용하여 조건부로 cacheWidth 또는 cacheHeight를 캐시 크기로 설정합니다. 앞서 언급한 대로 캐시 크기 속성 중 하나만 설정하면 이미지가 종횡비에 맞게 크기가 조정되므로 다른 속성을 null로 설정해도 괜찮습니다.

<div class="content-ad"></div>

# CacheNetworkImage 패키지

Flutter는 네트워크에서 이미지를로드하기 위한 Image.network 위젯을 제공하지만 이미지 캐싱에는 cached_network_image 패키지를 사용하는 것이 좋습니다. 이 패키지는 세밀한 캐싱 제어를 제공하여 성능을 향상시킬 수 있습니다. 아래는 cached_network_image 패키지를 사용하는 예시입니다.

```js
CachedNetworkImage(  
  imageUrl: imageUrl,  
  memCacheHeight: 320.cacheSize(context),  
  memCacheWidth: 250.cacheSize(context),  
)
```

CachedNetworkImage 위젯을 사용하면 Image.network 위젯과 유사하게 캐시 크기를 지정하기 위해 memCacheHeight 및 memCacheWidth 속성을 사용할 수 있습니다.

<div class="content-ad"></div>

# 결론

이 글에서는 Flutter에서 네트워크 이미지를 효율적으로 로드하고 메모리 사용량을 최적화하는 방법을 살펴보았습니다. 앱 개발 중 가장 중요한 측면 중 하나이지만 쉽게 간과될 수 있는 문제로, 특히 애플리케이션에서 고해상도 이미지를 다룰 때 부드러운 사용자 경험을 위해 중요합니다.

Flutter에서 이미지 처리에 대한 더 많은 팁과 모범 사례에 관심이 있다면, 잘 문서화된 "Flutter를 사용한 최상의 UX 성능을 위한 12가지 이미지 팁과 모범 사례" 문서를 참고하실 수 있습니다.

본 글에서 논의된 예제 코드에 대해 궁금하시다면, 제 GitHub 저장소에서 확인하실 수 있습니다.

<div class="content-ad"></div>

위 내용을 읽어 주셔서 감사합니다!

# 참고 자료

- https://www.themoviedb.org/tv/1396-breaking-bad/images/backdrops?language=ko
- https://api.flutter.dev/flutter/painting/debugInvertOversizedImages.html
- https://github.com/flutter/flutter/issues/56239