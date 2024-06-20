---
title: "플러터에서 이미지를 다루는 일반적인 실수들"
description: ""
coverImage: "/assets/img/2024-06-19-CommonmistakeswithImagesinFlutter_0.png"
date: 2024-06-19 00:09
ogImage: 
  url: /assets/img/2024-06-19-CommonmistakeswithImagesinFlutter_0.png
tag: Tech
originalTitle: "Common mistakes with Images in Flutter"
link: "https://medium.com/@pomis172/common-mistakes-with-images-in-flutter-aba46288e20d"
---


이미지는 대부분의 앱에서 사용하는 핵심 기능 중 하나입니다. 그러나 많은 사용자들은 간단히 피할 수 있는 실수로 응용 프로그램 성능에 부정적인 영향을 줄 수 있습니다. 몇 가지 주요 사례를 살펴보겠습니다.

# 1. 대형 이미지 자산

이는 많은 메모리와 처리 시간을 차지할 수 있습니다. 메모리에 디코딩된 비트맵 크기는 그들의 해상도에 직접적으로 의존하며, 이는 앱 성능에 큰 영향을 미칠 수 있습니다.

## 번들화된 이미지 자산의 크기를 줄이세요

<div class="content-ad"></div>

대부분의 스마트폰은 화면 너비가 1200 픽셀 이하이므로 자산을 그에 맞게 조절하는 것이 좋습니다. 예를 들어, 7500x5000 픽셀의 사진을 살펴보겠습니다. 이러한 크기의 비트맵을 저장하는 데 사용되는 RAM 양은 112 Mb로, 이는 Flutter의 이미지 캐시의 기본 크기를 초과합니다. 여기서의 규칙은 비트맵 크기의 합이 단일 앱 세션에 100 Mb를 초과해서는 안 된다는 것입니다. 그렇지 않으면 이미지가 다시 디코딩되어 부드럽지 않은 사용자 경험으로 이어질 수 있습니다.

이미지 해상도를 1200x800으로 줄이면 비트맵 크기가 2.8 Mb로 줄어듭니다. 이러한 계산은 이 도구를 사용하여 수행됩니다.

그러나 파일을 통제할 수 있는 경우에만 이렇게 할 수 있습니다. 원격 소스에서 이미지가 오는 경우에는 어떻게 해야 할까요? 또는 동일한 이미지가 다른 크기의 레이아웃에 사용될 수 있는 경우엔 어떻게 해야 할까요?

## cacheWidth 및 cacheHeight 사용하기

<div class="content-ad"></div>

위의 매개변수를 제공함으로써 이미지의 디코딩 크기를 지정할 수 있어요. 계산에 MediaQuery.of(context).devicePixelRatio를 포함하는 것을 잊지 마세요. 같은 이미지 자산이라도 cacheHeight/cacheWidth가 다르면 캐시에서 서로 다른 이미지로 간주될 거예요.

```js
    Image.asset(
      "assets/6392956.jpg",
      height: 100,
      width: 300,
      cacheHeight: (100 * MediaQuery.of(context).devicePixelRatio).toInt(),
    );
```

캐시에 미치는 영향을 테스트해보려면 몇 가지 측정을 해봐요. 현재 캐시 크기에는 PaintingBinding 클래스를 통해 액세스할 수 있어요:

```js
PaintingBinding.instance.imageCache.currentSizeBytes;
```

<div class="content-ad"></div>

크기가 큰 이미지는 예상대로 캐시 크기가 증가합니다. 그러나 원본 이미지가 너무 크기 때문에 전혀 캐시에 추가되지 않았고, 결과적으로 이미지를 표시할 때마다 디코딩하는 문제가 발생했습니다. 어떻게 보이는지 살펴봅시다:

![image](https://miro.medium.com/v2/resize:fit:576/1*HXRzZzdr7z5qeMwa4IFV6g.gif)

위 동영상에서는 캐시 크기 제한을 초과하는 이미지가 포함된 화면이 열릴 때마다 지연이 발생하며, 크기가 조정된 이미지의 경우에는 화면이 처음 열릴 때만 지연이 발생합니다.

# 2. WebP 자산을 사용하지 않기

<div class="content-ad"></div>

번들된 에셋을 최적화하는 또 다른 방법은 WebP 형식을 사용하는 것입니다. 이를 이용하면 이미지 파일 크기를 크게 줄일 수 있습니다. 무료 온라인 변환 도구가 많이 있고, Flutter는 기본적으로 WebP를 지원합니다.

# 3. Opacity 위젯 사용 시 필요하지 않은 경우에

Opacity 위젯은 매우 유용하고 편리하지만, 우리가 원할 때마다 사용해서는 안 됩니다. 왜냐하면 사용할 때마다 새 렌더링 레이어를 생성하기 때문입니다. 이 위젯이 화면에 여러 번 포함되어 있는 경우 어떻게 되는지 살펴봅시다:

```js
    Opacity(
      opacity: 0.5, // <- 가능한 경우 이런식으로 하지 말기
      child: Image.asset(
        "assets/6392956.jpg",
        height: 100,
        width: 300,
      ),
    );
```  

<div class="content-ad"></div>

그럼 개발 도구를 열어서 렌더 레이어를 확인해보세요:

![image0](/assets/img/2024-06-19-CommonmistakeswithImagesinFlutter_0.png)

![image1](/assets/img/2024-06-19-CommonmistakeswithImagesinFlutter_1.png)

각 레이어는 독립적으로 렌더링되므로 많은 계산이 발생합니다. Opacity 위젯 대신 이미지와 색상을 혼합하는 것이 권장되는 방법이니 문서를 참고해주세요:

<div class="content-ad"></div>

```dart
Image.asset(
  "assets/6392956.jpg",
  height: 100,
  width: 300,
  color: Colors.white.withOpacity(0.5), // <- 이 부분
  colorBlendMode: BlendMode.modulate, // <- 그리고 이 부분
  cacheHeight: (100 * MediaQuery.of(context).devicePixelRatio).toInt(),
),
```

이렇게 하면 모든 이미지를 동일한 렌더링 레이어에 표시할 수 있습니다:

![Image](/assets/img/2024-06-19-CommonmistakeswithImagesinFlutter_2.png)

# 4. 이미지 에셋을 미리 로드하지 않기


<div class="content-ad"></div>

플러터는 이미지를 ImageCache에 수동으로 푸시할 수 있는 기능을 제공합니다. 한 가지 이전 이미지로 시도해 봅시다:

```js
TextButton(
  child: const Text("이미지 미리 캐시"),
  onPressed: () async {
    cacheSize() => PaintingBinding.instance.imageCache.currentSizeBytes.toString();
    print(cacheSize());
    final asset = Image.asset(
      "assets/6392956.jpg",
      height: 100,
      width: 300,
      cacheHeight: (100 * MediaQuery.of(context).devicePixelRatio).toInt(),
    );
    await precacheImage(asset.image, context); // <- 이미지 미리 캐싱
    print(cacheSize());
  },
)
```

출력:

<img src="/assets/img/2024-06-19-플러터에서이미지와관련된일반적인실수_3.png" />

<div class="content-ad"></div>

따라서 동일한 디코딩 크기를 갖는 이미지가 포함된 화면을 열 때 결과가 즉시 열리며 캐시에서 제거되지 않는 한 사용됩니다. 이 기술을 사용할 때 캐시의 크기가 제한되어 있음을 주의해야 합니다.

# 5. 네트워크 이미지 캐싱하지 않기

앱이 네트워크에서 이미지를 가져오는 경우, 매번 이러한 이미지를 로드하는 것은 의미가 없을 것입니다. 대신 cached_network_image 라이브러리나 다른 대안을 사용할 수 있습니다. 라이브러리 문서는 매우 설명이 자세히 되어 있습니다.

본 글이 유용하게 읽으셨기를 바랍니다. 새로운 유익한 기술을 발견할 때마다 이를 업데이트할 것이며, 최신 정보를 얻으려면 트위터에서 저를 팔로우해주세요. 전체 코드를 읽고 싶다면 리포지토리를 확인해주세요.

<div class="content-ad"></div>

![2024-06-19-CommonmistakeswithImagesinFlutter_4.png](/assets/img/2024-06-19-CommonmistakeswithImagesinFlutter_4.png)