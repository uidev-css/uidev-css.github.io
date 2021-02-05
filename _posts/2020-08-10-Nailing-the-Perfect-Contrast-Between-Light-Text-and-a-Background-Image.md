---
layout: post
title: "라이트 텍스트와 배경 이미지의 완벽한 대비에 대한 네일링"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/07/contrast-bg.png
tags: ACCESSIBILITY,CANVAS,JAVASCRIPT
---


여러분은 밝은 배경 이미지 위에 가벼운 텍스트가 놓여 있는 사이트를 본 적이 있나요? 만약 있다면, 여러분은 그것이 얼마나 읽기 어려운지 알게 될 것입니다. 이를 피하는 일반적인 방법은 투명 오버레이를 사용하는 것입니다. 하지만 이것은 중요한 질문으로 이어집니다. 이 오버레이가 얼마나 투명해야 하는가? 우리가 항상 동일한 글꼴 크기, 가중치, 색상을 다루는 것은 아닙니다. 물론, 다른 이미지가 다른 대비를 낳습니다.

배경 이미지에 좋지 않은 텍스트 대비를 없애려고 하는 것은 Whac-a-Mole을 연주하는 것과 매우 비슷하다. 추측 대신 HTML <캔버스>와 약간의 수학으로 이 문제를 해결할 수 있다.

다음과 같은 경우:

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 625px;"><iframe id="cp_embed_oNbEqGV" src="//codepen.io/anon/embed/oNbEqGV?height=625&amp;theme-id=1&amp;slug-hash=oNbEqGV&amp;default-tab=result" height="625" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed oNbEqGV" title="CodePen Embed oNbEqGV" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

우리는 "문제 해결!"이라고 말하고 이 기사를 여기서 간단히 끝낼 수 있습니다. 하지만 그 재미는 어디에 있지? 제가 보여드리고자 하는 것은 이 툴의 작동 방식입니다. 따라서 이 모든 일반적인 문제를 해결할 수 있는 새로운 방법이 있습니다.

### 계획은 이렇다

우선, 우리의 목표에 대해 구체적으로 알아보자. 우리는 배경 이미지 위에 읽을 수 있는 텍스트를 원한다고 말했지만, "읽을 수 있는"이라는 것이 무엇을 의미합니까? 우리의 목적을 위해, 우리는 한 색이 다른 색보다 4.5배 더 밝도록 텍스트와 배경색이 그것들 사이의 충분한 대조가 필요하다는 AA 수준의 가독성에 대한 WCAG 정의를 사용할 것이다.

시작점으로 텍스트 색, 배경 이미지 및 오버레이 색을 선택하겠습니다. 이러한 입력을 고려하여 이미지를 너무 많이 숨기지 않고 텍스트를 읽을 수 있도록 하는 오버레이 불투명도 수준을 찾기를 원한다. 좀 더 복잡하게 하려면 어두운 공간과 밝은 공간을 모두 가진 이미지를 사용하고 오버레이가 이를 고려하도록 하겠습니다.

우리의 최종 결과는 텍스트를 배경보다 4.5배 더 가볍게 만드는 적절한 양의 투명도를 제공하는 오버레이의 CSS `opacity` 속성에 적용할 수 있는 값이 될 것이다.

최적의 중첩 불투명도를 찾기 위해 다음 네 단계를 수행합니다.

- 우리는 이미지를 HTML `<canvas>`에 넣을 것이며, 이것은 우리가 이미지의 각 픽셀의 색상을 읽을 수 있게 해 줄 것이다.
- 텍스트와 대조가 가장 적은 픽셀을 이미지에서 찾을 수 있습니다.
- 그런 다음 해당 픽셀의 색상 위에 다른 불투명도 수준을 테스트하는 데 사용할 수 있는 색상 혼합 공식을 준비합니다.
- 마지막으로 텍스트 대비가 가독성 목표에 도달할 때까지 오버레이의 불투명도를 조정합니다. 그리고 이것은 단순한 추측이 아닙니다. 우리는 이 과정을 빠르게 하기 위해 이진 검색 기술을 사용할 것입니다.

시작해 봅시다!

### 1단계: 캔버스에서 이미지 색 읽기

캔버스를 사용하면 이미지에 포함된 색상을 "읽을" 수 있습니다. 그러기 위해서는 이미지를 <캔버스> 요소에 "그려놓은" 다음 캔버스 컨텍스트(ctx) getImageData() 방식을 사용하여 이미지 색상 목록을 만들어야 한다.

```js
function getImagePixelColorsUsingCanvas(image, canvas) {
  // The canvas's context (often abbreviated as ctx) is an object
  // that contains a bunch of functions to control your canvas
  const ctx = canvas.getContext('2d');
 
  // The width can be anything, so I picked 500 because it's large
  // enough to catch details but small enough to keep the
  // calculations quick.
  canvas.width = 500;
 
  // Make sure the canvas matches proportions of our image
  canvas.height = (image.height / image.width) * canvas.width;
 
  // Grab the image and canvas measurements so we can use them in the next step
  const sourceImageCoordinates = [0, 0, image.width, image.height];
  const destinationCanvasCoordinates = [0, 0, canvas.width, canvas.height];
 
  // Canvas's drawImage() works by mapping our image's measurements onto
  // the canvas where we want to draw it
  ctx.drawImage(
    image,
    ...sourceImageCoordinates,
    ...destinationCanvasCoordinates
  );
 
  // Remember that getImageData only works for same-origin or 
  // cross-origin-enabled images.
  // https://developer.mozilla.org/en-US/docs/Web/HTML/CORS_enabled_image
  const imagePixelColors = ctx.getImageData(...destinationCanvasCoordinates);
  return imagePixelColors;
}
```

getImageData() 방법은 각 픽셀의 색상을 나타내는 숫자 목록을 제공합니다. 각 픽셀은 빨간색, 녹색, 파란색, 불투명도(알파라고도 함)의 4개의 숫자로 표시됩니다. 이것을 알면, 우리는 픽셀 목록을 순환해서 필요한 정보를 찾을 수 있습니다. 이 기능은 다음 단계에서 유용합니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/07/image-35.png?resize=851%2C561&ssl=1)

## 2단계: 대비가 가장 낮은 픽셀 찾기

이 작업을 수행하기 전에 대비를 계산하는 방법을 알아야 합니다. 우리는 `getcontrast()`라는 두 가지 색상을 취해서 둘 사이의 대조도를 나타내는 숫자를 뱉어내는 함수를 쓸 것이다. 숫자가 높을수록 판독성을 위한 대비가 좋습니다.

제가 이 프로젝트를 위해 색깔을 연구하기 시작했을 때, 저는 간단한 공식을 찾기를 기대하고 있었습니다. 알고 보니 여러 단계가 있었습니다.

두 색상 간의 대비를 계산하려면 휘도 수준을 알아야 하는데, 이는 본질적으로 밝기이다(Stacie Arellano는 확인할 가치가 있는 휘도에 대해 심층 분석한다).

W3C 덕분에 우리는 휘도를 사용하여 대비를 계산하는 공식을 알고 있다.

```js
const contrast = (lighterColorLuminance + 0.05) / (darkerColorLuminance + 0.05);
```

색상의 휘도를 얻는다는 것은 웹에서 사용되는 일반적인 8비트 RGB 값(각 색이 0-255인 경우)에서 선형 RGB로 색상을 변환해야 한다는 것을 의미한다. 이렇게 해야 하는 이유는 색이 변하면서 밝기가 고르게 올라가지 않기 때문입니다. 우리는 색상 변화에 따라 밝기가 균일하게 변하는 형식으로 색상을 변환해야 합니다. 그것은 우리가 적절하게 휘도를 계산할 수 있게 해준다. W3C는 여기서도 도움이 됩니다.

```js
const luminance = (0.2126 * getLinearRGB(r) + 0.7152 * getLinearRGB(g) + 0.0722 * getLinearRGB(b));
```

하지만 기다려, 더 있어! 8비트 RGB(0~255)를 선형 RGB로 변환하려면 0~1의 척도로 표준 RGB(sRGB라고도 함)를 거쳐야 한다.

따라서 프로세스는 다음과 같습니다.

```
8-bit RGB → standard RGB  → linear RGB → luminance
```

그리고 우리가 비교하고자 하는 두 가지 색상의 휘도를 갖게 되면, 우리는 휘도 값을 연결하여 각각의 색들 사이의 대조를 얻을 수 있습니다.

```js
// getContrast is the only function we need to interact with directly.
// The rest of the functions are intermediate helper steps.
function getContrast(color1, color2) {
  const color1_luminance = getLuminance(color1);
  const color2_luminance = getLuminance(color2);
  const lighterColorLuminance = Math.max(color1_luminance, color2_luminance);
  const darkerColorLuminance = Math.min(color1_luminance, color2_luminance);
  const contrast = (lighterColorLuminance + 0.05) / (darkerColorLuminance + 0.05);
  return contrast;
}
 
function getLuminance({r,g,b}) {
  return (0.2126 * getLinearRGB(r) + 0.7152 * getLinearRGB(g) + 0.0722 * getLinearRGB(b));
}
function getLinearRGB(primaryColor_8bit) {
  // First convert from 8-bit rbg (0-255) to standard RGB (0-1)
  const primaryColor_sRGB = convert_8bit_RGB_to_standard_RGB(primaryColor_8bit);
 
  // Then convert from sRGB to linear RGB so we can use it to calculate luminance
  const primaryColor_RGB_linear = convert_standard_RGB_to_linear_RGB(primaryColor_sRGB);
  return primaryColor_RGB_linear;
}
function convert_8bit_RGB_to_standard_RGB(primaryColor_8bit) {
  return primaryColor_8bit / 255;
}
function convert_standard_RGB_to_linear_RGB(primaryColor_sRGB) {
  const primaryColor_linear = primaryColor_sRGB < 0.03928 ?
    primaryColor_sRGB/12.92 :
    Math.pow((primaryColor_sRGB + 0.055) / 1.055, 2.4);
  return primaryColor_linear;
}
```

이제 대비를 계산할 수 있으므로 이전 단계에서 이미지를 보고 각 픽셀을 순환하여 픽셀 색상과 전경 텍스트 색상의 대비를 비교해야 합니다. 이미지의 픽셀을 순환하면서 지금까지의 최악의 (최저) 대비를 추적하고, 루프 끝에 도달하면 이미지에서 최악의 대비 색상을 알게 됩니다.

```js
function getWorstContrastColorInImage(textColor, imagePixelColors) {
  let worstContrastColorInImage;
  let worstContrast = Infinity; // This guarantees we won't start too low
  for (let i = 0; i < imagePixelColors.data.length; i += 4) {
    let pixelColor = {
      r: imagePixelColors.data[i],
      g: imagePixelColors.data[i + 1],
      b: imagePixelColors.data[i + 2],
    };
    let contrast = getContrast(textColor, pixelColor);
    if(contrast < worstContrast) {
      worstContrast = contrast;
      worstContrastColorInImage = pixelColor;
    }
  }
  return worstContrastColorInImage;
}
```

### 3단계: 오버레이 불투명도 수준을 테스트할 색상 혼합 공식 준비

이제 이미지에서 최악의 대비 색상을 알게 되었으므로, 다음 단계는 오버레이가 얼마나 투명해야 하는지를 정하고 텍스트와의 대비를 어떻게 변화시키는지 확인하는 것입니다.

처음 구현할 때는 별도의 캔버스를 이용해 색을 섞고 결과를 읽었습니다. 하지만, Ana Tudor의 투명성에 대한 기사 덕분에, 저는 이제 기본 색상과 투명 오버레이를 섞어서 결과적인 색상을 계산할 수 있는 편리한 공식이 있다는 것을 알게 되었습니다.

각 색상 채널(빨간색, 녹색, 파란색)에 대해 다음 공식을 적용하여 혼합 색상을 얻습니다.

```
mixedColor = baseColor + (overlayColor - baseColor) * overlayOpacity
```

코드로 보면 다음과 같습니다.

```js
function mixColors(baseColor, overlayColor, overlayOpacity) {
  const mixedColor = {
    r: baseColor.r + (overlayColor.r - baseColor.r) * overlayOpacity,
    g: baseColor.g + (overlayColor.g - baseColor.g) * overlayOpacity,
    b: baseColor.b + (overlayColor.b - baseColor.b) * overlayOpacity,
  }
  return mixedColor;
}
```

이제 색상을 혼합할 수 있게 되었으므로 중첩 불투명도 값이 적용될 때의 대비를 테스트할 수 있습니다.

```js
function getTextContrastWithImagePlusOverlay({textColor, overlayColor, imagePixelColor, overlayOpacity}) {
  const colorOfImagePixelPlusOverlay = mixColors(imagePixelColor, overlayColor, overlayOpacity);
  const contrast = getContrast(textColor, colorOfImagePixelPlusOverlay);
  return contrast;
}
```

그러면 최적의 중첩 불투명도를 찾는 데 필요한 모든 도구가 확보됩니다!

### 4단계: 조영 목표에 도달하는 중첩 불투명도 찾기

오버레이의 불투명도를 테스트하여 텍스트와 이미지 간의 대비에 어떤 영향을 미치는지 확인할 수 있습니다. 우리는 여러 가지 불투명도 수준을 시도해보려고 합니다. 텍스트가 배경보다 4.5배 더 밝은 곳에 있는 표시에 맞는 대비를 찾을 때까지 말이죠. 말도 안 되는 소리 같지만 걱정하지 마세요. 우리는 아무렇게나 추측하지는 않을 것입니다. 우리는 이진 검색을 사용할 것입니다. 이것은 우리가 정확한 결과를 얻을 때까지 가능한 일련의 답을 빠르게 좁힐 수 있게 해주는 과정입니다.

이진 검색의 작동 방식은 다음과 같습니다.

- 중간에서 맞춰보세요.
- 추측이 너무 높으면, 우리는 정답의 상위 절반을 제거한다. 너무 낮아요? 대신 아랫쪽 반쪽을 제거한다.
- 그 새로운 범위의 중간에 맞춰보세요.
- 값을 얻을 때까지 이 과정을 반복합니다.

저는 이것이 어떻게 작동하는지 보여줄 수 있는 그대로입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 650px;"><iframe id="cp_embed_ExPpBJW" src="//codepen.io/anon/embed/ExPpBJW?height=650&amp;theme-id=1&amp;slug-hash=ExPpBJW&amp;default-tab=result" height="650" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed ExPpBJW" title="CodePen Embed ExPpBJW" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이 경우 불투명도 값이 0과 1 사이인지 추측하려고 합니다. 중간에서 대조가 너무 높은지 낮은지 여부를 검정하고 절반의 옵션을 제거한 다음 다시 추측합니다. 이진수 검색을 8개의 추측으로 제한하면, 우리는 단숨에 정확한 답을 얻을 수 있을 것입니다.

검색을 시작하기 전에 처음부터 오버레이가 필요한지 확인할 수 있는 방법이 필요합니다. 필요 없는 오버레이를 최적화해도 소용없어!

```js
function isOverlayNecessary(textColor, worstContrastColorInImage, desiredContrast) {
  const contrastWithoutOverlay = getContrast(textColor, worstContrastColorInImage);
  return contrastWithoutOverlay < desiredContrast;
}
```

이제 이진 검색을 사용하여 최적의 중첩 불투명도를 찾을 수 있습니다.

```js
function findOptimalOverlayOpacity(textColor, overlayColor, worstContrastColorInImage, desiredContrast) {
  // If the contrast is already fine, we don't need the overlay,
  // so we can skip the rest.
  const isOverlayNecessary = isOverlayNecessary(textColor, worstContrastColorInImage, desiredContrast);
  if (!isOverlayNecessary) {
    return 0;
  }
 
  const opacityGuessRange = {
    lowerBound: 0,
    midpoint: 0.5,
    upperBound: 1,
  };
  let numberOfGuesses = 0;
  const maxGuesses = 8;
 
  // If there's no solution, the opacity guesses will approach 1,
  // so we can hold onto this as an upper limit to check for the no-solution case.
  const opacityLimit = 0.99;
 
  // This loop repeatedly narrows down our guesses until we get a result
  while (numberOfGuesses < maxGuesses) {
    numberOfGuesses++;
 
    const currentGuess = opacityGuessRange.midpoint;
    const contrastOfGuess = getTextContrastWithImagePlusOverlay({
      textColor,
      overlayColor,
      imagePixelColor: worstContrastColorInImage,
      overlayOpacity: currentGuess,
    });
 
    const isGuessTooLow = contrastOfGuess < desiredContrast;
    const isGuessTooHigh = contrastOfGuess > desiredContrast;
    if (isGuessTooLow) {
      opacityGuessRange.lowerBound = currentGuess;
    }
    else if (isGuessTooHigh) {
      opacityGuessRange.upperBound = currentGuess;
    }
 
    const newMidpoint = ((opacityGuessRange.upperBound - opacityGuessRange.lowerBound) / 2) + opacityGuessRange.lowerBound;
    opacityGuessRange.midpoint = newMidpoint;
  }
 
  const optimalOpacity = opacityGuessRange.midpoint;
  const hasNoSolution = optimalOpacity > opacityLimit;
 
  if (hasNoSolution) {
    console.log('No solution'); // Handle the no-solution case however you'd like
    return opacityLimit;
  }
  return optimalOpacity;
}
```

실험이 완료됨에 따라, 우리는 이제 배경 이미지를 너무 많이 숨기지 않고 텍스트를 읽을 수 있도록 하기 위해 오버레이가 얼마나 투명해야 하는지 정확히 알게 되었다.

우리가 해냈어!

### 개선 및 제한 사항

지금까지 살펴본 방법은 텍스트 색상과 오버레이 색상의 대비가 시작하기에 충분한 경우에만 작동합니다. 예를 들어 오버레이와 동일한 텍스트 색상을 선택하는 경우 이미지에 오버레이가 필요하지 않은 경우 최적의 솔루션이 없습니다.

게다가, 비록 그 대조가 수학적으로 허용된다고 해도, 그것이 항상 그것이 멋지게 보일 것이라고 보장하지는 않는다. 이것은 특히 밝은 오버레이와 사용 중인 배경 이미지가 있는 어두운 텍스트의 경우에 해당됩니다. 이미지의 다양한 부분이 텍스트에서 산만하여 대조가 수치적으로 양호한 경우에도 읽기 어려울 수 있습니다. 그래서 어두운 배경에 가벼운 텍스트를 사용하는 것이 인기 있는 추천입니다.

또한 픽셀이 어디에 위치하는지, 각 색상이 몇 개인지도 고려하지 않았습니다. 그것의 한 가지 단점은 구석에 있는 픽셀이 결과에 너무 많은 영향을 미칠 수 있다는 것이다. 그러나 장점은 이미지 색상이 어떻게 분포되어 있는지 또는 텍스트가 어디에 있는지 걱정할 필요가 없다는 것입니다. 왜냐하면 최소한의 대비만 있다면 다른 곳에서도 안전하기 때문입니다.

### 나는 도중에 몇 가지를 배웠다.

이 실험 후에 제가 가지고 간 몇 가지가 있는데, 여러분과 나누고자 합니다.

- 목표에 대해 구체적으로 알아보는 것은 정말 도움이 됩니다! 우리는 이미지에 읽을 수 있는 텍스트를 원한다는 막연한 목표에서 시작했고, 결국 우리가 노력할 수 있는 특정한 대비 수준을 갖게 되었다.
- 조건을 명확히 하는 것이 매우 중요합니다. 예를 들어, 표준 RGB는 제가 기대했던 것과 달랐습니다. 저는 제가 "일반" RGB (0 ~ 255)라고 생각했던 것을 8비트 RGB라고 합니다. 또한, 나는 의미“밝기”조사 방정식에 실제로“광도.”와 혼동되지는 않습니다“휘도,”을 의미하는“L”생각했다. 용어를 정리하면 코드화 방법과 최종 결과에 대해 논의하는 방법에 도움이 됩니다.
- 복잡하다고 해결될 수 없는 것은 아닙니다. 어렵게 들리는 문제는 더 작고 다루기 쉬운 부분으로 나눌 수 있습니다.
- 길을 걷다 보면 지름길을 발견하게 된다. 검은색 투명 오버레이에 흰색 텍스트가 있는 일반적인 경우 WCAG AA 수준의 가독성을 달성하기 위해 0.54 이상의 불투명도가 필요하지 않습니다.

### 요약하면…

이제 너무 많은 이미지를 희생하지 않고도 배경 이미지에서 텍스트를 읽을 수 있는 방법을 사용할 수 있습니다. 여기까지 오셨다면, 제가 이 모든 것이 어떻게 돌아가는지 대략적으로 알려드릴 수 있었기를 바랍니다.

배경 이미지에 대해 텍스트가 읽기 어렵거나 배경 이미지가 오버레이에 의해 지나치게 가려지는 웹 사이트 배너를 너무 많이 보고 만들었기 때문에 이 프로젝트를 처음 시작했습니다. 저는 그것에 대해 뭔가를 하고 싶었고, 다른 사람들에게도 똑같이 할 수 있는 방법을 주고 싶었습니다. 저는 당신이 웹상에서 가독성을 더 잘 이해하기를 바라며 이 기사를 썼습니다. 여러분도 멋진 캔버스 묘기를 배웠기를 바랍니다.

가독성이나 캔버스로 재미있는 일을 하셨다면 댓글로 듣고 싶어요!