---
title: "선명한 이미지가 흐릿한 단어 천 개보다 나은 이유"
description: ""
coverImage: "/assets/img/2024-06-21-Asharpimageisworthathousandblurrywords_0.png"
date: 2024-06-21 23:48
ogImage: 
  url: /assets/img/2024-06-21-Asharpimageisworthathousandblurrywords_0.png
tag: Tech
originalTitle: "A sharp image is worth a thousand blurry words"
link: "https://medium.com/@smrutisagarpattanaik1997/a-sharp-image-is-worth-a-thousand-blurry-words-a36253abf293"
---


우리는 본능적으로 시각적인 생물입니다. MIT 연구에 따르면 인간 두뇌는 이미지를 13~33밀리초 안에 처리하는데, 이는 텍스트 보다 60,000배 빠르다고 합니다. 따라서 사용자 경험을 만드는 데 이미지를 광범위하게 사용하는 것이 중요합니다. 웹 사용자 경험을 위해 선명하고 선명한 이미지를 전달하는 뒤에 숨겨진 비밀을 발견하기 위해 이 기사를 살펴보겠습니다.

## 픽셀: 물리적 vs 논리적

어떤 화면이 이미지를 형성하려면 작은 정사각형으로 나뉘어집니다. 이 정사각형 중 하나를 물리적 픽셀이라고 합니다.

CSS를 사용하여 웹페이지에 스타일을 프로그래밍적으로 추가할 때, 엔지니어들은 페이지의 요소 크기와 위치를 정의하는 데 측정 단위로 픽셀을 사용합니다. 이것을 논리적 픽셀이라고 합니다.

<div class="content-ad"></div>

**논리적 픽셀**은 추상적인 개념이며 물리적 픽셀과 1대1 매핑될 수도 있고 그렇지 않을 수도 있습니다.

## 장치 픽셀 비율 (DPR)

동일한 화면 영역 안에서 더 높은 해상도의 화면은 낮은 해상도의 화면보다 더 많은 물리적 픽셀을 갖게 됩니다. 화면 영역을 하나의 논리적 픽셀로 간주했을 때, 장치 픽셀 비율은 동일한 영역에 존재하는 물리적 픽셀의 수와 동일합니다. 화면의 해상도는 장치 픽셀 비율과 직접적으로 비례합니다.

![이미지](/assets/img/2024-06-21-Asharpimageisworthathousandblurrywords_0.png)

<div class="content-ad"></div>

## 논리적 픽셀과 물리적 픽셀 매핑

HTML 문서의 뷰포트 메타 태그는 화면의 디바이스 픽셀 비율을 고려하여 논리적 픽셀을 물리적 픽셀로 매핑하도록 브라우저에 지시합니다.

```js
<meta name="viewport" content="width=device-width, initial-scale=1.0">
```

예를 들어, 화면의 DPR이 2인 경우, 논리적 픽셀 하나에 물리적 픽셀이 두 개 들어갈 수 있음을 의미합니다. 따라서 웹사이트 콘텐츠가 논리적으로 200 x 200 픽셀을 차지한다면 해당 화면에서는 물리적으로 400 x 400 픽셀을 차지할 것입니다.

<div class="content-ad"></div>

## 이미지 선택의 기술

동일한 차량의 두 개의 이미지가 있다고 가정해봅시다. Image_one은 Image_two보다 높은 해상도를 가지고 있습니다. 이는 Image_one에는 Image_two보다 더 많은 세부 사항이 표시됨을 의미합니다. 만약 차량의 이미지를 웹사이트에 논리적으로 600 x 400 픽셀로 원한다면, 높은 DPR 화면에는 높은 해상도 이미지를 사용하고 낮은 DPR 화면에는 낮은 해상도 이미지를 사용해야 합니다.

높은 DPR 화면에서는 논리적인 600 x 400 픽셀이 더 많은 물리적 픽셀 위에 펼쳐질 것이기 때문에 높은 해상도 이미지를 사용하면 더 많은 세부 사항이 표시되어 유용할 것입니다. 그러나 낮은 해상도 이미지를 사용하면 더 많은 세부 사항이 없기 때문에 흐릿해 보일 수 있으며, 느기적으로 펼치게 됩니다.


<img src="/assets/img/2024-06-21-Asharpimageisworthathousandblurrywords_1.png" />


<div class="content-ad"></div>

저해상도 화면에서는 논리적인 600 x 400 픽셀 이미지가 고해상도 화면보다 더 낮은 물리적 픽셀 수를 가질 것입니다. 따라서 더 높은 해상도의 이미지를 사용하면 작동할 것이지만 다운로드할 때 더 많은 네트워크 대역폭을 소비할 것입니다. 대신 더 낮은 해상도의 이미지를 사용하면 작동하며 다운로드할 때 더 적은 네트워크 대역폭을 소비합니다.

## 말보다 행동이 중요해요, 코드를 보여줘

HTML 문서에서는 아래와 같이 img 태그와 srcset 속성을 사용하여 위에서 논의한 것을 구현할 수 있습니다.

```js
<img src="image.jpg" srcset="image-2x.jpg 2x, image-4x.jpg 4x">
```

<div class="content-ad"></div>

이미지의 해상도는 다음과 같습니다:
image-4x.jpg ` image-2x.jpg ` image.jpg

DPR이 4인 화면에는 image-4x.jpg를, DPR이 2인 화면에는 image-2x.jpg를 보여주며, 그 외의 화면에는 기본적으로 image.jpg를 사용합니다.

## 결론

물리적 픽셀, 논리적 픽셀, DPR 및 viewport 메타 태그에 대한 충분한 이해는 srcset 속성의 힘을 이용하여 오늘날 사용자가 웹사이트를 보는데 사용하는 다양한 기기에서 우수한 이미지 품질을 제공하는 데 도움이 됩니다. 그래서 다음 번에 핸드폰, 태블릿 또는 컴퓨터에서 화려한 시각적 효과를 볼 때, 최적화된 이미지 전달의 마법을 기억해주세요!