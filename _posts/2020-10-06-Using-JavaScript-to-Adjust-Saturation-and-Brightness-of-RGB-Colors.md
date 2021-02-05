---
layout: post
title: "자바스크립트를 사용하여 RGB 색채의 채도와 밝기 조정"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2019/10/stripe-accessible-colors.png
tags: COLOR,HSL,RGBA
---


최근에 저는 제가 뉴질랜드에서 온 곳에서 색상으로 디자인하는 것에 대해 알아보고 있습니다. 이 주제에 대한 Adam Wathan과 Steve Schroger의 조언을 보면, 애플리케이션을 구축할 때 색상 팔레트 생성기의 멋진 육각 코드 5개 이상이 필요하다는 것을 알 수 있습니다. 회색과 몇 가지 원색이 필요합니다. 이러한 기본 색상에서 우리는 다양한 수준의 밝기와 포화도를 원합니다.

응용 프로그램을 개발할 때 주로 16진수 코드나 RGB 색상을 사용해 왔는데, 단일 색상에서 다양한 수준의 밝기와 포화도를 측정하려고 하면 속도가 느려진다는 것을 알게 되었습니다. VSCode에서 색상 선택기를 조심스럽게 이동하거나 육각 색상 도구를 계속 열어 RSI를 얻는 것을 방지하기 위해 이러한 색상을 조작하는 데 도움이 되는 코드를 살펴보겠습니다.

### HSL 값

웹 색을 쓰는 효과적인 방법은 HSL 값을 사용하는 것입니다. 특히 색을 수동으로 변경하려는 경우 더욱 그렇습니다. HSL은 색조, 포화도, 밝기를 나타냅니다. HSL을 사용하여 0에서 360 사이의 숫자로 색상을 선언할 수 있습니다. 그런 다음 포화도와 밝기를 각각 백분율로 적어둘 수 있습니다. 예를 들어:

```css
div {
  background-color: hsl(155, 30%, 80%);
}
```

이렇게 하면 가볍고 음소거한 민트 그린 컬러를 연출할 수 있습니다. 만약 우리가 이 div에 어두운 텍스트를 던져야 한다면? 검은색에 가깝지만 배경과 일치하는 색상을 사용할 수 있습니다. 예를 들어 동일한 HSL 값을 잡고 명암을 5%로 낮출 수 있습니다.

```css
div {
  background-color: hsl(155, 30%, 80%);
  color: hsl(155, 30%, 5%);
}
```

좋아요. 이제 검정색에 가깝지만 좀 더 자연스러워 보이는 텍스트와 배경과 연결되어 있습니다. 하지만 만약 이것이 텍스트의 한 단락이 아니라, 대신 행동하기 위한 호출 버튼이었다면요? 채도를 높이고 배경에 밝기를 약간 낮춤으로써 더 많은 관심을 끌 수 있습니다.

```css
.call-to-action {
  background-color: hsl(155, 80%, 60%);
  color: hsl(155, 30%, 5%);
}
```

아니면, 별로 중요하지 않은 텍스트가 있다면요? 우리는 텍스트의 밝기를 되돌리고 포도를 낮출 수 있습니다. 이렇게 하면 대비가 일부 없어지고 중요하지 않은 텍스트가 배경으로 더 많이 사라집니다. 그렇긴 하지만, 접근성과 가독성을 위해 충분한 대비를 유지할 수 있도록 주의해야 합니다. 따라서 배경을 다시 한 번 강조해 보겠습니다.

```css
div {
  background-color: hsl(155, 30%, 80%);
  color: hsl(155, 30%, 5%);
}

.lessimportant {
  color: hsl(155, 15%, 40%);
}
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 300px;"><iframe id="cp_embed_bGpxWvO" src="//codepen.io/anon/embed/bGpxWvO?height=300&amp;theme-id=1&amp;slug-hash=bGpxWvO&amp;default-tab=result" height="300" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed bGpxWvO" title="CodePen Embed bGpxWvO" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

HSL 값은 모든 주요 브라우저에서 지원되며 RGB에 비해 우수한 색상 정의 방법입니다. 색채의 색채, 채도, 밝기에 대해 보다 선언적인 태도를 취할 수 있기 때문입니다.

하지만 RGB 값을 사용하기로 이미 약속한 경우에는 어떻게 해야 합니까? 또는 상사로부터 "IE 8에서 작동합니까?"라는 이메일을 받게 됩니다.

### 라이브러리

HSL 값을 다시 16진수 코드 또는 RGB 색으로 변환할 수 있는 훌륭한 컬러 라이브러리가 많이 있습니다. 대부분 컬러 배색에 도움이 되는 다양한 조작 기능도 갖추고 있다.

다음은 제가 알고 있는 몇 가지 라이브러리 목록입니다.

- 포맷 간 변환이 문제라면 Pilipp Mildenberger로 collvertize를 시도해 보세요. 이것은 많은 변환 방법과 몇 가지 조작 방법을 제공하는 경량 라이브러리입니다.
- 그리고 조쉬 주논이 관리하는 색이 있습니다. 이렇게 하면 유창한 인터페이스를 사용하여 색상을 선언, 처리 및 추출할 수 있습니다. 다양한 변환 및 조작 방법을 제공합니다.
- 또 다른 하나는 유틸리티 기능뿐만 아니라 많은 입력 유형을 처리할 수 있는 Brian Grinceover의 Tiny Color이다. 또한 색 구성표를 생성하는 데 도움이 되는 몇 가지 기능도 제공합니다.

또한 컬러 포맷 변환에 관한 CSS-Tricks의 훌륭한 기사도 있다.

### 컬러 그리드 도구

또 다른 방법은 제가 만든 컬러 그리드라는 컬러 도구를 사용해 보는 것입니다. 리팩토링 UI를 인용하자면, "그만큼 매력적인 것은, 완벽한 색상 팔레트를 만들기 위해 수학에만 의존할 수 없습니다."

자연스럽게, 이 글을 읽고 나서, 저는 수학적으로 색 팔레트를 만들기 위해 리액트 앱을 만들었습니다. 좋아요, 모든 문제가 해결되진 않겠지만, 몇 가지 선택 사항으로 시작할 수도 있어요. 선택한 색조를 기준으로 100가지 수준의 포화도 및 밝기를 만듭니다. 그리드 항목을 클릭하여 16진수 코드를 복사하거나 끝에 있는 텍스트 영역에서 색상을 CSS 사용자 지정 속성으로 복사할 수 있습니다. 만약 여러분이 한 두 개의 색조로부터 변화를 얻을 수 있는 빠른 방법이 필요하다면, 이것은 시도해 볼 만한 것이 될 수 있다.

여기 RGB 색상을 사용하고 있고 변환하는 방법이 필요한 경우 RGB 색상을 처리하기 위해 배운 몇 가지 기술들이 있습니다.

### RGB 색상의 밝기를 찾는 방법

거부권: 이 기법은 색조의 본질적 가치를 설명하지 않는다. 색조의 본질적인 가치는 흑색이나 백색을 추가하기 전의 고유의 밝기이다. 순수한 노란색이 순수한 보라색보다 훨씬 더 밝게 보인다는 사실에서 잘 드러납니다.

이 기술은 백색 또는 흑색이 얼마나 혼합되어 있는지에 대한 프로그램적인 측정을 기반으로 밝기 수준을 산출한다. 인식된 밝기는 이 측정치 이상의 영향을 받으므로 눈을 사용하여 필요한 빛의 수준을 판단해야 합니다.

RGB 색상의 밝기 수준은 RGB 값 중 가장 높은 값과 가장 낮은 값의 평균을 찾은 다음 255로 나누면 확인할 수 있다(중간 색상은 밝기에 영향을 주지 않음).

이렇게 하면 0과 밝기를 나타내는 1 사이의 소수점이 됩니다. 다음은 JavaScript 기능입니다.

```js
function getLightnessOfRGB(rgbString) {
  // First convert to an array of integers by removing the whitespace, taking the 3rd char to the 2nd last then splitting by ','
  const rgbIntArray = (rgbString.replace(/ /g, '').slice(4, -1).split(',').map(e => parseInt(e)));
 
  // Get the highest and lowest out of red green and blue
  const highest = Math.max(...rgbIntArray);
  const lowest = Math.min(...rgbIntArray);
 
  // Return the average divided by 255
  return (highest + lowest) / 2 / 255;
}
```

다음은 이 기능을 사용하는 코드 펜입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_RwaOPEb" src="//codepen.io/anon/embed/RwaOPEb?height=450&amp;theme-id=1&amp;slug-hash=RwaOPEb&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed RwaOPEb" title="CodePen Embed RwaOPEb" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 밝기 또는 색조를 변경하지 않고 RGB 색상을 포화시키는 방법

RGB의 밝기를 찾을 수 있는 새로운 기능으로 무엇을 할 수 있을까? 밝기를 변경하지 않고도 RGB 색상을 포화시킬 수 있습니다.

RGB를 포화 상태로 만드는 데에는 몇 가지 문제가 있다.

- 그레이 컬러의 RGB 포맷에는 그레이의 색조가 없기 때문에 포화 버전이 어떻게 보일지 알 수 있는 정보가 없다. 그래서 색을 포화시키는 기능을 쓰려면, 이 사례를 다루어야 합니다.
- 50%의 밝기가 아니면 사실 순수한 색조를 낼 수 없습니다. 다른 것은 검은색이나 흰색에 의해 희석될 것입니다. 그래서 우리는 우리가 색을 포화시키는 것과 같은 밝기를 유지할 것인지, 아니면 가장 활기찬 버전을 얻기 위해 색깔을 50%의 밝기로 옮길 것인지를 선택할 수 있습니다. 이 예에서는 동일한 수준의 밝기를 유지합니다.

먼저 밝은 청록색의 rgb(205, 228, 219) 색상으로 시작해보자. 색상을 포화시키려면 가장 낮은 RGB 값과 가장 높은 RGB 값의 차이를 늘려야 한다. 이렇게 하면 순수한 색조로 바뀔 것입니다.

만약 우리가 밝기를 동일하게 유지하려면, 우리는 가장 높은 값을 증가시키고 가장 낮은 값을 같은 양만큼 감소시켜야 합니다. 그러나 RGB 값은 0에서 255 사이에 고정되어야 하므로 색상이 더 밝거나 어두울 때 포화도 옵션이 제한됩니다. 즉, 주어진 밝기에 사용할 수 있는 포화도 범위가 있다는 뜻입니다.

우리 색깔에 사용 가능한 포화도 범위를 잡읍시다. 우리는 이 두 가지 중 가장 낮은 것을 찾아서 해결할 수 있습니다.

- 우리의 색상과 동일한 밝기를 가진 회색의 RGB 값과 255의 차이
- 우리의 색상과 동일한 밝기를 가진 회색의 RGB 값과 0(회색 값 자체만 해당) 사이의 차이

전체 회색 버전을 얻으려면 `getLightnessOf`의 최종 결과를 가져올 수 있습니다.RG는 이전 섹션에서 기능하며 255를 곱한다. 그러면 이 숫자를 우리의 RGB 값 세 개 모두에 사용하여 원래 색과 동일한 밝기를 얻을 수 있습니다.

지금 이렇게 하자:

```js
// Using the previous "getLightnessOfRGB" function
const grayVal = getLightnessOfRGB('rgb(205, 228, 219)')*255; // 217
// So a gray version of our color would look like rgb(217,217,217);
// Now let's get the saturation range available:
const saturationRange =  Math.round(Math.min(255-grayVal,grayVal)); // 38
```

우리가 색깔을 50%까지 포화시키고 싶다고 가정해 보자. 이를 위해 가장 높은 RGB 값을 증가시키고 가장 낮은 RGB 값을 포화 범위의 50%까지 감소시키기를 원한다. 그러나 이 경우 255 이상 또는 0 이하가 될 수 있으므로 다음 두 값 중 최소값으로 변경 사항을 고정해야 합니다.

- 가장 높은 RGB 값과 255 사이의 차이
- 최저 RGB 값과 0 사이의 차이(값 자체)

```js
// Get the maximum change by getting the minimum out of: 
// (255 - the highest value) OR (the lowest value)
const maxChange = Math.min(255-228, 205); // 27
 
// Now we will be changing our values by the lowest out of:
// (the saturation range * the increase fraction) OR (the maximum change)
const changeAmount = Math.min(saturationRange/0.5, maxChange) // 19
```

즉, 가장 높은 RGB 값(녹색)에 19를 추가하고 가장 낮은 RGB 값에서 19를 빼야 한다.

```js
const redResult = 205 - 19; // 186
const greenResult= 228 + 19; // 247
```

세 번째 값은 어떻습니까?

여기서 상황이 좀 더 복잡해집니다. 중간 값에서 회색까지의 거리는 그 사이의 비율과 다른 두 값 중 하나의 회색으로부터의 거리로 작동할 수 있습니다.

가장 높은 값과 가장 낮은 값을 회색에서 더 멀리 이동하면 중간 값이 그에 비례하여 증가/감소합니다.

이제 가장 높은 값과 최대 회색의 차이를 알아보겠습니다. 그런 다음 중간 값과 전체 회색의 차이입니다. 그러면 우리는 이것들 사이의 비율을 얻을 수 있을 거예요. 또한 그레이 값을 산출하는 과정에서 반올림을 제거하여 보다 정확하게 만들 것입니다.

```js
const grayVal = getLightnessOfRGB('rgb(205, 228, 219)')*255;
const highDiff = grayVal - 228; // -11 subtracting green - the highest value
const midDiff = grayVal - 219; // -2 subtracting blue - the middle value
const middleValueRatio = midDiff / highDiff; // 0.21739130434782608
```

그리고 나서 우리가 해야 할 일은 새로운 RGB 녹색 값과 (19를 추가한 후) 그레이 값 사이의 차이를 얻은 다음 이것을 우리의 비율에 곱하는 것이다. 이 값을 회색 값에 더하면 새로 포화 상태에 이른 파란색에 대한 해답입니다.

```js
// 247 is the green value after we applied the saturation transformation
const newBlue = Math.round(grayVal+(247-grayVal)*middleValueRatio); // 223
```

그래서 우리가 변형을 적용한 후, 우리는 RGB 색상의 RGB를 갖게 되는데, 이것은 우리가 시작한 색상의 보다 활기찬 버전입니다. 그러나 그것은 빛과 빛깔을 유지했다.

다음은 색을 10% 포화시키기 위해 함께 작동하는 자바스크립트 기능 몇 가지이다. 여기서 두 번째 함수는 RGB 값을 나타내는 객체 배열을 크기 순서대로 반환합니다. 이 두 번째 함수는 이 기사의 나머지 모든 함수에 사용됩니다.

회색으로 표시하면 동일한 색상이 반환됩니다.

```js
function saturateByTenth(rgb) {
  const rgbIntArray = (rgb.replace(/ /g, '').slice(4, -1).split(',').map(e => parseInt(e)));
  const grayVal = getLightnessOfRGB(rgb)*255;
  const [lowest,middle,highest] = getLowestMiddleHighest(rgbIntArray);
 
  if(lowest.val===highest.val){return rgb;}
  
  const saturationRange =  Math.round(Math.min(255-grayVal,grayVal));
  const maxChange = Math.min((255-highest.val),lowest.val);
  const changeAmount = Math.min(saturationRange/10, maxChange);
  const middleValueRatio =(grayVal-middle.val)/(grayVal-highest.val);
  
  const returnArray=[];
  returnArray[highest.index]= Math.round(highest.val+changeAmount);
  returnArray[lowest.index]= Math.round(lowest.val-changeAmount);
  returnArray[middle.index]= Math.round(grayVal+(returnArray[highest.index]-grayVal)*middleValueRatio);
   return (`rgb(${[returnArray].join()})`);
}
 
function getLowestMiddleHighest(rgbIntArray) {
  let highest = {val:-1,index:-1};
  let lowest = {val:Infinity,index:-1};
 
  rgbIntArray.map((val,index)=>{
    if(val>highest.val){
      highest = {val:val,index:index};
    }
    if(val<lowest.val){
      lowest = {val:val,index:index};
    }
  });
 
  if(lowest.index===highest.index){
    lowest.index=highest.index+1;
  }
  
  let middle = {index: (3 - highest.index - lowest.index)};
  middle.val = rgbIntArray[middle.index];
  return [lowest,middle,highest];
}
```

### RGB 색소정렬 방법

만약 우리가 완전히 색을 더럽힌다면, 우리는 결국 회색빛을 띠게 될 것이다. RGB 그레이는 항상 3개의 동일한 RGB 값을 가지므로 이전 함수의 `회색 Val`을 사용하여 주어진 색과 동일한 밝기의 회색 색상을 만들 수 있다.

만약 우리가 회색으로 직행하는 것을 원하지 않고 단지 색을 약간만 꾸미고 싶다면? 우리는 앞의 예를 뒤집어서 이것을 할 수 있습니다.

다른 예를 들어 보겠습니다. rgb(173, 31, 104)로 시작하면 포화 연지가 된다. 밝기의 십진법을 잡고 255를 곱해서 회색 버전을 구합시다.

```js
const grayVal = Math.round(getLightnessOfRGB('rgb(173, 31, 104)') * 255); // 102
```

즉, 이 색상을 회색으로 완전히 분해하면 rgb(102, 102, 102)가 됩니다. 30%까지 절약을 합시다.

먼저 색상의 포화 범위를 다시 찾아야 합니다.

```js
const saturationRange = Math.round(Math.min(255-grayVal,grayVal)); // 102
```

우리의 색을 30%까지 퇴색시키기 위해 우리는 가장 높고 낮은 색을 이 범위의 30%까지 완전한 회색으로 옮기고 싶다. 하지만 우리는 또한 이 두 색상 사이의 거리(가장 높은 색과 가장 낮은 색 사이의 거리는 동일)와 전체 회색 사이의 거리만큼 변화량을 고정할 필요가 있습니다.

```js
// Get the maximum change by getting the difference between the lowest (green) and the gray value
const maxChange = grayVal-31; // 71
// Now grab the value that represents 30% of our saturation range
const changeAmount = Math.min(saturationRange * 0.3, maxChange) // 30.59999
```

그리고 이 변경 금액을 가장 낮은 RGB 값에 더하고 가장 높은 값에서 뺍니다.

```js
const newGreen =Math.Round(31+changeAmount); // 62
const newRed =Math.Round(173-changeAmount); // 142
```

그런 다음 마지막 함수와 동일한 비율 기법을 사용하여 세 번째 색상의 값을 찾습니다.

```js
const highDiff = grayVal - 173; // -71 subtracting red - the highest value
const midDiff = grayVal - 104; // -2 subtracting blue - the middle value
const middleValueRatio = midDiff / highDiff; // 0.02816901408
const newBlue = Math.Round(grayVal+(142.4-grayVal)*middleValueRatio); // 103
```

즉, 30% 포화 상태의 연지의 RGB 표현은 `rgb(142, 62, 103)`가 된다. 색과 밝기는 똑같지만, 생기가 조금 떨어집니다.

여기 색을 10%까지 축약하는 자바스크립트 기능이 있습니다. 이것은 기본적으로 이전 기능의 역방향입니다.

```js
function desaturateByTenth(rgb) {
  const rgbIntArray = (rgb.replace(/ /g, '').slice(4, -1).split(',').map(e => parseInt(e)));
  //grab the values in order of magnitude 
  //this uses the getLowestMiddleHighest function from the saturate section
  const [lowest,middle,highest] = getLowestMiddleHighest(rgbIntArray);
  const grayVal = getLightnessOfRGB(rgb) * 255;
 
  if(lowest.val===highest.val){return rgb;}
  
  const saturationRange =  Math.round(Math.min(255-grayVal,grayVal));
  const maxChange = grayVal-lowest.val;
  const changeAmount = Math.min(saturationRange/10, maxChange);
                               
  const middleValueRatio =(grayVal-middle.val)/(grayVal-highest.val);
  
  const returnArray=[];
  returnArray[highest.index]= Math.round(highest.val-changeAmount);
  returnArray[lowest.index]= Math.round(lowest.val+changeAmount);
  returnArray[middle.index]= Math.round(grayVal+(returnArray[highest.index]-grayVal)*middleValueRatio);
  return (`rgb(${[returnArray].join()})`);
}
 
```

다음은 포화도 함수의 효과를 실험하기 위한 코드 펜입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_MWyRezZ" src="//codepen.io/anon/embed/MWyRezZ?height=450&amp;theme-id=1&amp;slug-hash=MWyRezZ&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed MWyRezZ" title="CodePen Embed MWyRezZ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

RGB 값을 가볍게 하고 색조를 동일하게 유지하려면 각 RGB 값을 값과 255 사이의 동일한 비율만큼 증가시켜야 한다. 이 색상이 있다고 가정합시다. rgb(0, 153, 255) 그것은 완전히 포화상태의 청색/시안이다. 각 RGB 값과 255 사이의 차이를 살펴보겠습니다.

- 빨간색은 0이고, 차이는 255입니다.
- 녹색은 153이고, 차이는 102입니다.
- 파란색은 255이므로 차이가 0입니다.

이제 색을 밝게 할 때, 우리는 각 RGB 값을 차이의 같은 비율로 증가시킬 필요가 있다. 한가지 주목할 것은 우리가 본질적으로 우리의 색깔에 흰색을 섞고 있다는 것이다. 이것은 색이 밝아질수록 서서히 포화를 잃게 된다는 것을 의미합니다.

이 색상의 밝기를 10분의 1로 높입시다. 가장 낮은 RGB 값인 빨간색부터 시작하겠습니다. 이 값에 255의 10분의 1을 더합니다. 또한 값이 255 이상 증가하지 않도록 Math.min을 사용해야 합니다.

```js
const red = 0;
const newRed = Math.round( red + Math.min( 255-red, 25.5 )); // 26
```

이제 다른 두 RGB 값은 255까지 거리의 동일한 부분만큼 증가해야 합니다.

이를 해결하기 위해, 우리는 가장 낮은 RGB 값(증가하기 전)과 255 사이의 차이를 얻는다. 빨간색은 0이여서 우리의 차이는 255입니다. 그런 다음 변환에서 가장 낮은 RGB 값을 얻는다. 빨간색은 0에서 26으로 증가했고, 따라서 우리의 증가량은 26입니다.

증가분을 원래 색과 255의 차이로 나누면 다른 값을 알아내는 데 사용할 수 있는 분율이 됩니다.

```js
const redDiff = 255 - red; // 255
const redIncrease = newRed - red; // 26
const increaseFraction = redIncrease / redDiff; // 0.10196
```

이제 우리는 다른 RGB 값과 255 사이의 차이를 이 분수로 곱한다. 이것은 우리가 각 값에 추가해야 할 양을 제공합니다.

```js
const newGreen = Math.round(153 + (255 - 153) * increaseFraction); // 163
const newBlue = Math.round(255 + (255 - 255) * increaseFraction); // 255
```

이것은 우리가 끝내는 색이 "rgb (26, 163, 255)"라는 것을 의미합니다. 그것은 여전히 같은 색이지만 터치 라이터입니다.

이 기능을 수행하는 기능은 다음과 같습니다.

```js
function lightenByTenth(rgb) {

  const rgbIntArray = rgb.replace(/ /g, '').slice(4, -1).split(',').map(e => parseInt(e));
  // Grab the values in order of magnitude 
  // This uses the getLowestMiddleHighest function from the saturate section
  const [lowest,middle,highest]=getLowestMiddleHighest(rgbIntArray);
  
  if(lowest.val===255){
    return rgb;
  }
  
  const returnArray = [];

  // First work out increase on lower value
  returnArray[lowest.index]= Math.round(lowest.val+(Math.min(255-lowest.val,25.5)));

  // Then apply to the middle and higher values
  const increaseFraction  = (returnArray[lowest.index]-lowest.val)/ (255-lowest.val);
  returnArray[middle.index]= middle.val +(255-middle.val)*increaseFraction ;
  returnArray[highest.index]= highest.val +(255-highest.val)*increaseFraction ;
  
  // Convert the array back into an rgb string
  return (`rgb(${returnArray.join()})`);
}
```

### 색조를 동일하게 유지하는 RGB 색상을 어둡게 하는 방법

RGB 색상을 어둡게 하는 것은 매우 유사합니다. 255를 얻기 위해 값에 추가하는 대신, 0을 얻기 위해 값에서 빼는 것입니다.

또한 우리는 가장 높은 값을 줄이고 이 감소의 일부를 얻는 것으로 전환을 시작합니다. 이 분수를 사용하여 다른 두 값의 거리를 0으로 줄인다. 이것은 우리가 색을 밝게 했던 것을 뒤집은 것입니다.

색을 어둡게 하는 것은 또한 서서히 포화도를 잃게 할 것이다.

```js
function darkenByTenth(rgb) {
  
  // Our rgb to int array function again
  const rgbIntArray = rgb.replace(/ /g, '').slice(4, -1).split(',').map(e => parseInt(e));
  //grab the values in order of magnitude 
  //this uses the function from the saturate function
  const [lowest,middle,highest]=getLowestMiddleHighest(rgbIntArray);
  
  if(highest.val===0){
    return rgb;
  }

  const returnArray = [];

  returnArray[highest.index] = highest.val-(Math.min(highest.val,25.5));
  const decreaseFraction  =(highest.val-returnArray[highest.index])/ (highest.val);
  returnArray[middle.index]= middle.val -middle.val*decreaseFraction; 
  returnArray[lowest.index]= lowest.val -lowest.val*decreaseFraction;              
                            
  // Convert the array back into an rgb string
  return (`rgb(${returnArray.join()}) `);
}

```

다음은 밝기 함수의 효과를 실험하기 위한 코드 펜입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_xxVeerV" src="//codepen.io/anon/embed/xxVeerV?height=450&amp;theme-id=1&amp;slug-hash=xxVeerV&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed xxVeerV" title="CodePen Embed xxVeerV" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

RGB 색상으로 작업해야 하는 경우 이러한 기능을 통해 작업을 시작할 수 있습니다. HSL 형식과 브라우저 지원을 확장할 색 라이브러리 및 변환을 위한 색 그리드 도구를 제공할 수도 있습니다.