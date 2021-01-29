---
layout: post
title: "JavaScript에서 Math.random ()을 사용하는 다양한 방법"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/11/math-random.png
tags: JAVASCRIPT,MATH,RANDOM
---


`Math.random ()`은 JavaScript의 API입니다.
 난수를주는 함수입니다.
 반환되는 숫자는 0 (실제 0이 반환 될 수 있음)에서 1 (실제 1이 반환 될 수 없음) 사이입니다.
 

```js
Math.random(); // returns a random number lower than 1
```

이것은 게임, 애니메이션, 무작위 데이터, 생성 아트, 무작위 텍스트 생성 등에 매우 유용합니다!
 웹 개발, 모바일 애플리케이션, 컴퓨터 프로그램 및 비디오 게임에 사용할 수 있습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 300px;"><iframe id="cp_embed_vYKxNZp" src="//codepen.io/anon/embed/vYKxNZp?height=300&amp;theme-id=1&amp;slug-hash=vYKxNZp&amp;default-tab=result" height="300" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed vYKxNZp" title="CodePen Embed vYKxNZp" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

작업에서 무작위 화가 필요할 때마다이 기능을 사용할 수 있습니다!
 이를 사용할 수있는 8 가지 방법을 살펴 보겠습니다.
 이 예제는 모두이 API로 흥미로운 작업을 수행하는 여러 작성자의 것입니다.
 

### 생기
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_mJzOWJ" src="//codepen.io/anon/embed/mJzOWJ?height=450&amp;theme-id=1&amp;slug-hash=mJzOWJ&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed mJzOWJ" title="CodePen Embed mJzOWJ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

개체를 생성하고 애니메이션하려면 `Math.random`을 사용합니다.
 네온 라인은 자발적인 육각형을 형성하지만 무작위 화도 생성 스파크에 있습니다.
 

### 컴퓨터 생성 음악
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 550px;"><iframe id="cp_embed_zxoOjG" src="//codepen.io/anon/embed/zxoOjG?height=550&amp;theme-id=1&amp;slug-hash=zxoOjG&amp;default-tab=result" height="550" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed zxoOjG" title="CodePen Embed zxoOjG" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이 프로그램은 "Auld Lang Syne"의 전통적인 멜로디를 가져와 피아노로 무작위 음을 연주합니다.
 카운트 데이터에서 변경 패키지가 생성되고 값을 선택하기 위해 난수가 생성됩니다.
 옥타브도 무작위로 선택됩니다.
 

### 임의의 이미지 표시
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 600px;"><iframe id="cp_embed_RQEOWm" src="//codepen.io/anon/embed/RQEOWm?height=600&amp;theme-id=1&amp;slug-hash=RQEOWm&amp;default-tab=result" height="600" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed RQEOWm" title="CodePen Embed RQEOWm" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이미지는 배열에 저장됩니다.
 숫자가 생성되고`array.length `를 통해 배열의 이미지 수로 곱해집니다.
 그런 다음`Math.floor`는 값을 반올림하여 페이지가로드되거나 버튼을 클릭 할 때 HTML에 이미지 src를 설정합니다.
 

### 임의의 배경색
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_RerqjG" src="//codepen.io/anon/embed/RerqjG?height=450&amp;theme-id=1&amp;slug-hash=RerqjG&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed RerqjG" title="CodePen Embed RerqjG" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이것이 마법이 일어나는 곳입니다.
 

```js
const random = (min, max) => {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}
```

코드의 첫 번째 줄은 배열을 무작위로 섞고 두 번째 줄은 0에서 10 사이의 임의의 umber를 반환합니다. 무작위 색상 배경의 예에서 색상 범위와 색조, 채도 및 음영과 같은 세부 사항을 설정할 수 있습니다.
 

임의의 16 진수 색상을 생성하는 또 다른 방법은 Chris Coyer의이 기사를 참조하십시오.
 

### 생성 예술
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 700px;"><iframe id="cp_embed_iCgfj" src="//codepen.io/anon/embed/iCgfj?height=700&amp;theme-id=1&amp;slug-hash=iCgfj&amp;default-tab=result" height="700" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed iCgfj" title="CodePen Embed iCgfj" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이 모핑 프랙탈 곡선에서 Math.random은 그라디언트의 색상을 설정하는 데 두 번 사용되고 곡선의 최대 반경에 대해 한 번 더 사용됩니다.
 반복 할 때마다 완전히 새로운 모습을 만드는 좋은 방법입니다!
 

### 단어 생성기
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_OJRVXXG" src="//codepen.io/anon/embed/OJRVXXG?height=450&amp;theme-id=1&amp;slug-hash=OJRVXXG&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed OJRVXXG" title="CodePen Embed OJRVXXG" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

헤더를`Math.random`을 사용하여 배열에서 임의로 선택한 단어로 바꿉니다.
 

```js
var word = words[Math.floor(Math.random() * words.length)] + "!";
```

이것은 임의의 이미지 예제와 매우 비슷합니다. 초보자를위한 완벽한 연습입니다!
 

### API 키 생성기
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_rxOmMJ" src="//codepen.io/anon/embed/rxOmMJ?height=450&amp;theme-id=1&amp;slug-hash=rxOmMJ&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed rxOmMJ" title="CodePen Embed rxOmMJ" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

다음은 난수에 대한 실제 사용 사례입니다.
 데모는 16 개의 난수를 생성하여 API에 대한 액세스를 제공하는 키로 사용할 수있는 UUID (Universally Unique Identifier)를 만듭니다.
 

### 텍스트 스크램블
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_mErPAK" src="//codepen.io/anon/embed/mErPAK?height=250&amp;theme-id=1&amp;slug-hash=mErPAK&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed mErPAK" title="CodePen Embed mErPAK" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

Math.random에서 선택한 구문 사이에 임의의 문자가있는 문자를 뒤섞는 애니메이션으로 구분 된 몇 개의 구문이 저장되고 순서대로 표시됩니다.
 

### 가위 바위 보
 verified_user

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_ONjyMo" src="//codepen.io/anon/embed/ONjyMo?height=450&amp;theme-id=1&amp;slug-hash=ONjyMo&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed ONjyMo" title="CodePen Embed ONjyMo" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

어린 시절의 가위 바위 보 게임에서 Math.random은 컴퓨터가 상대로 플레이 할 때 무작위 동작을 생성하는 데 사용됩니다.
 사용 가능한 세 가지 동작 중에서 선택합니다.
 

### 강력한 암호 생성기
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_YeMOVv" src="//codepen.io/anon/embed/YeMOVv?height=450&amp;theme-id=1&amp;slug-hash=YeMOVv&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed YeMOVv" title="CodePen Embed YeMOVv" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이 암호 생성기는 Math.random을 사용하여 대문자와 소문자로 채워진 암호 배열을 가져온 다음 생성 된 암호에 임의의 숫자를 추가합니다.
 이것은 또 다른 훌륭한 실용적인 예입니다!
 

### 몇 가지 메모…
 

이 예에서 Math.random을 본 후에 질문이있을 수 있습니다.
 자주 오는 커플이 있는데…
 

정확히.
 Math.random ()은 의사 난수를 반환합니다.
 이 알고리즘을 의사 난수 생성기 (또는 PRNG)라고합니다.
 이는 임의 화가 특정 상황에서 재현 될 수 있음을 의미합니다.
 

무작위 화는 브라우저에서 실행중인`xorshift128 +`알고리즘을 기반으로합니다.
 

그래서 무작위입니다.
 

반복하지 않고 고유 한 값을 달성하는 방법에는 여러 가지가 있습니다.
 Fisher-Yates는 시퀀스를 섞어서 같은 숫자를 두 번 얻지 않도록하는 좋은 방법 중 하나입니다.
 Math.random은 아래 코드 조각에서 보여주는 유한 시퀀스의 섞인 배열에서 값을 선택합니다.
 

```js
function shuffle (array) {
  var i = 0
    , j = 0
    , temp = null

  for (i = array.length - 1; i > 0; i -= 1) {
    j = Math.floor(Math.random() * (i + 1))
    temp = array[i]
    array[i] = array[j]
    array[j] = temp
  }
}
```

이 기사에서 보셨 듯이 Math.random ()은 굉장합니다!
 그러나 민감한 애플리케이션을 처리하고 더 안전한 무작위 화 방법이 필요한 경우 WebCrypto를 권장합니다.
 WebCrypto를 사용하려는 이유에는 임시 확인 코드, 임의 암호 생성, 임의 복권 번호 등이 포함됩니다.
 

사이버 보안, 암호화 또는 통계 목적으로 무작위 화가 필요한 경우,`window.crypto.getRandomValues` 함수를 사용하고 WebCrypto API에 대한 Mozilla 문서를 확인하세요.
 