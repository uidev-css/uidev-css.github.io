---
layout: post
title: "마스크 출처
 "
author: 'CSS Dev'
thumbnail: undefined
tags: 
---


`mask-origin`은 마스크 레이어 이미지의 마스크 위치 영역을 지정합니다.
 즉, 테두리, 패딩 또는 내용 상자의 가장자리인지 여부에 관계없이 마스크 레이어 이미지의 원점을 정의합니다.
 

```css
.element {
  mask-image: url(star.svg);
  mask-origin: content-box;
} 

```

단일 상자로 렌더링 된 요소의 경우`mask-origin`은 마스크 위치 지정 영역을 지정합니다.
 여러 상자로 렌더링 된 요소 (예 : 여러 줄의 인라인 상자, 여러 페이지의 상자)의 경우 속성은 마스크 위치 지정 영역을 결정하기 위해 `box-decoration-break`가 작동하는 상자를 지정합니다.
 

이 속성은 SVG 요소에 적용되는 다른 초기 값과 세 개의 추가 값이 있다는 점을 제외하면`background-origin` 속성과 유사하게 작동합니다.
 

다음 데모에서 마스크 레이어 이미지의 원점을 변경할 수 있습니다.
 마스킹 효과를 더 잘 보여주고 테두리와 패딩 영역을 표시하는 동일한 이미지가 아래에 있습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_PozWxJy" src="//codepen.io/anon/embed/PozWxJy?height=450&amp;theme-id=1&amp;slug-hash=PozWxJy&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed PozWxJy" title="CodePen Embed PozWxJy" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 통사론
 

```css
mask-origin: <geometry-box> = content-box | padding-box | border-box | margin-box | fill-box | stroke-box | view-box
```

- 초기 값 :`border-box`
 
- 적용 대상 : 모든 요소.
 SVG에서는`<defs>`요소, 모든 그래픽 요소 및`<use>`요소를 제외한 컨테이너 요소에 적용됩니다.
 
- 상 속됨 : 아니요
 
- 애니메이션 유형 : 이산
 

### 가치
 

```css
/* Keywords */
mask-origin: content-box;
mask-origin: padding-box;
mask-origin: border-box;
mask-origin: margin-box;
mask-origin: fill-box;
mask-origin: stroke-box;
mask-origin: view-box;
 
/* Global values */
mask-origin: intial;
mask-origin: inherit;
mask-origin: unset;
```

### 가치 정의
 

- `content-box` : 위치는 콘텐츠 상자를 기준으로합니다.
 `마스크 이미지`의 원점은 콘텐츠 가장자리의 왼쪽 상단 모서리에 있습니다.
 
- `padding-box` : 위치는 패딩 상자를 기준으로합니다.
 `0 0`에있는 마스크 이미지의 원점은 패딩 가장자리의 왼쪽 상단 모서리에 위치하며 `100 % 100 %`는 오른쪽 하단 모서리입니다.
 
- `border-box` : 테두리 상자를 기준으로 위치를 설정하는 기본값입니다.
 
- `margin-box` : 위치는 여백 상자를 기준으로합니다.
 
- `fill-box` : 위치는 객체 경계 상자를 기준으로합니다.
 
- `stroke-box` : 위치는 획 경계 상자를 기준으로합니다.
 
- `view-box` : 가장 가까운 SVG 뷰포트를 참조 상자로 사용합니다.
 SVG 뷰포트 생성 요소에`viewBox` 속성이 지정되면 참조 상자는`viewBox` 속성에 의해 설정된 좌표계의 원점에 배치되고 참조 상자의 크기는`width` 및`
 `viewBox`속성의 높이 `값입니다.
 
- `initial` : 속성의 기본 설정 인`border-box`를 적용합니다.
 
- `inherit` : 상위의`mask-origin` 값을 채택합니다.
 
- `unset` : 요소에서 현재`mask-origin`을 제거합니다.
 

### 여러 값 사용
 

이 속성은 마스크 원본에 대해 쉼표로 구분 된 값 목록을 가져올 수 있으며, 각 값은 `mask-image`속성에 지정된 해당 마스크 레이어 이미지에 적용됩니다.
 다음 예제에서 첫 번째 값은 첫 번째 이미지의 원점을 지정하고 두 번째 값은 두 번째 이미지의 원점을 지정하는 식입니다.
 

```css
.element {
  mask-image: url(image1.png), url(image2.png), url(image3.png);
  mask-origin: padding-box, border-box, content-box;
} 

```

### 메모
 verified_user

- 관련 CSS 레이아웃 상자가없는 SVG 요소의 경우 `content-box`, `padding-box`및 `border-box`값이 `fill-box`로 계산됩니다.
 
- 연관된 CSS 레이아웃 상자가있는 요소의 경우 `fill-box`, `stroke-box`및 `view-box`값은 `border-box`인 `mask-origin`의 `초기`값으로 계산됩니다.
 

### 데모
 

마스크 레이어 이미지를 반복하면 첫 번째 인스턴스가 지정된 위치 지정 영역의 왼쪽 상단 모서리에 배치 된 다음 `mask-repeat`속성 값에 따라 해당 위치부터 반복됩니다.
 

다음 데모에서`mask-origin`의 값을 변경하여 무슨 일이 일어나고 있는지 더 잘 알 수 있습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_wvWgQPN" src="//codepen.io/anon/embed/wvWgQPN?height=450&amp;theme-id=1&amp;slug-hash=wvWgQPN&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed wvWgQPN" title="CodePen Embed wvWgQPN" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 브라우저 지원
 

### 관련 정보
 verified_user

### 관련 속성
 