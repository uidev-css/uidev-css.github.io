---
layout: post
title: "가변 비율 레이아웃의 유체 영상"
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/06/strawberry-pattern.png"
tags: ASPECT RATIO,RESPONSIVE IMAGES
---


요즘은 단독으로 레이아웃에 서 있을 때 유동적인 이미지를 만드는 것이 매우 쉽습니다. 그러나 보다 정교한 인터페이스를 통해 다음과 같은 대응 요소 내부에 이미지를 배치해야 하는 경우가 많습니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/06/image-19.png?fit=1024%2C249&ssl=1)

일단, 이 이미지는 의미론적 내용이 아니라 단지 장식이라고 합시다. 배경 이미지에 좋은 사용법입니다. 그리고 이러한 맥락에서 이미지에 객체가 포함되어 있기 때문에 반응성일 때 어떤 부품도 잘라낼 수 없기 때문에 `background size: contain`을 선택합니다.

여기서부터 까다로워지기 시작합니다. 모바일 기기에서는 이 카드가 방향을 전환하고 이미지를 맨 위에 놓고 수직이 됩니다. 우리는 어떤 종류의 CSS 레이아웃 기법으로도 그것을 가능하게 할 수 있고, 아마도 CSS 그리드나 플렉스 박스로 가장 잘 처리될 것이다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/06/image-20.png?resize=415%2C446&ssl=1)

그러나 `포함` 속성 때문에 더 작은 화면을 테스트할 때 다음과 같은 결과가 나타납니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/06/image-21.png?resize=428%2C603&ssl=1)

별로 좋지 않군요. 이미지 사이즈는 크기를 조정해 세부 사항을 자르지 않고 가로 세로 비율을 유지하고, 이미지가 중요한 내용이어서 잘려서는 안 되는 경우 배경 크기를 커버로 바꿀 수 없다.

이 시점에서 다음 번 시도에서는 배경 대신 이미지를 인라인으로 배치하는 것이 익숙할 수 있습니다.

데스크톱에서 이 작업은 정상적으로 작동합니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/06/image-22.png?fit=1024%2C249&ssl=1)

모바일에서도 나쁘지 않습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/06/image-23.png?resize=412%2C412&ssl=1)

하지만 작은 화면에서는, 모든 고정된 크기 때문에 이미지의 비율이 왜곡됩니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/06/image-24.png?resize=498%2C617&ssl=1)

우리는 이미지, 카드, 유연한 속성을 만지작거리면서 몇 시간을 보낼 수 있었습니다. 아니면, 우리는...

### 배경에서 기본 컨텐츠 분리

이는 반응하는 이미지에 대해 훨씬 더 많은 유연성과 복원력을 얻기 위한 기반입니다. 100%는 가능하지 않을 수 있지만, 많은 경우, 특히 이 접근법이 사전에 계획된 경우 사물의 설계 측면에서 약간의 노력으로 달성할 수 있다.

다음 번에는 투명한 배경에 딸기 이미지를 배치하고 대신 CSS로 래스터 이미지의 파란색을 설정합니다. 샘플 공간의 크기를 조정하여 이 데모에서 뷰포트 크기로 재생하십시오!

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 550px;"><iframe id="cp_embed_OJyRwNr" src="//codepen.io/anon/embed/OJyRwNr?height=550&amp;theme-id=1&amp;slug-hash=OJyRwNr&amp;default-tab=result" height="550" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed OJyRwNr" title="CodePen Embed OJyRwNr" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

스타일을 더 깊이 들여다보면, 우리가 이미지를 잡아주는 디브에도 패딩을 추가했다는 것을 알 수 있습니다. 그래서 딸기가 가장자리에 너무 가까이 오지 않습니다. 우리는 이 패딩을 통해 그들이 얼마나 가깝거나 멀리 있기를 원하는지 완전히 통제할 수 있습니다.

또한 외부 카드 포장지의 패딩을 보정하기 위해 음의 여백을 사용하는 방법에 주목하십시오. 그렇지 않으면 이미지 전체에 흰색 공간이 생깁니다.

### 인라인 이미지에 '개체 적합' 속성 사용

이전 데모가 효과가 있는 만큼 접근 방식도 개선할 수 있습니다. 지금까지 이미지가 의미 없는 내용이라고 가정해 왔습니다. 하지만 이 레이아웃으로 이미지 일러스트레이션은 장식 이상의 것이 될 수 있습니다.

만약 그렇다면, 우리는 확실히 이미지가 잘리는 것을 원하지 않습니다. 왜냐하면 그것은 본질적으로 데이터 손실에 해당하기 때문입니다. 이를 방지하기 위해 배경 대신 이미지를 인라인으로 배치하는 것이 의미론적으로 더 낫고, 이를 실현하기 위해 객체 적합 특성을 사용할 수 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 550px;"><iframe id="cp_embed_gOaEvVG" src="//codepen.io/anon/embed/gOaEvVG?height=550&amp;theme-id=1&amp;slug-hash=gOaEvVG&amp;default-tab=result" height="550" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed gOaEvVG" title="CodePen Embed gOaEvVG" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

우리는 배경에서 딸기를 추출했고 그것은 이제 인라인 밈(img) 요소가 되었습니다. 하지만 우리는 배경색을 같은 이미지 디브에 유지했습니다.

마지막으로, `객체 적합성: 함량`을 100% 너비와 결합하면 창의 크기를 조정하고 딸기의 가로 세로 비율을 유지할 수 있다. 그러나 이 접근 방식의 주의사항은 데스크톱 버전에서 이미지의 고정 높이를 설정해야 한다는 것입니다. 그렇지 않으면 설정된 너비의 비율에 따라 이미지가 변경되고 레이아웃을 변경할 수 있습니다. 여러 줄로 구분되는 다양한 양의 텍스트로 이러한 카드를 생성해야 할 경우, 이는 상황을 너무 제한적으로 만들 수 있습니다.

### 곧 출시될 예정: '평면비'

위의 우려에 대한 해결책은 곧 다가올 `측면비율` 부동산과 함께 코앞에 닥칠지도 모른다. 이렇게 하면 요소의 고정 비율을 다음과 같이 설정할 수 있습니다.

```css
.el {
  aspect-ratio: 16 / 9;
}
```

즉, 고정된 높이를 제거하고 계산된 가로 세로 비율로 대체할 수 있습니다. 예를 들어, 마지막 예제의 데스크톱 중단점의 치수는 다음과 같습니다.

```css
.image {
  /* ... */
  height: 184px;
  width: 318px;
}
```

가로 세로 비율을 사용하면 높이 선언을 없애고 계산을 통해 184에 이르는 가장 가까운 비율을 얻을 수 있다.

```css
.image {
  /* ... */
  width: 318px; /*  Base width */
  height: unset; /* Resets the height that was set outside the media query */
  aspect-ratio: 159 / 92; /* Amounts close to a 184px height */
}
```

앞으로 나올 숙박시설에 대해 자세히 알아보려면 이 기사를 참조하십시오.

결국, 가변 비율 레이아웃에서 신뢰할 수 있는 반응형 영상을 얻을 수 있는 여러 가지 방법이 있습니다. 그러나 이 작업을 더 쉽게, 더 좋게 만드는 방법은 반드시 CSS에 있는 것이 아닙니다. 전경을 배경에서 분리하거나(우리가 그랬던 것처럼) 가장자리의 상당 부분이 잘려도 여전히 작동하는 특정 이미지를 선택하는 것이 이미지를 조정하는 것만큼 간단할 수 있습니다.