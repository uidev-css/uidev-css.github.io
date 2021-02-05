---
layout: post
title: "CSS 전환을 통한 현실적인 모션 블러 생성 방법"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/10/motion-blur.png
tags: ANIMATION,BLUR,TRANSITION
---


CSS에서 사실적인 모션 블러에 대해 연구하기 전에, 모션 블러가 무엇인지 빠르게 살펴볼 필요가 있습니다. 그래서 우리는 재현하려는 것이 무엇인지 더 잘 알 수 있습니다.

특히 낮은 조명 아래서 무언가가 빠르게 움직이는 사진을 찍어서 흐릿한 줄무늬로 변한 적이 있나요? 아니면 카메라 전체가 흔들려서 총성이 연쇄적으로 된 것일까요? 이것은 움직임의 흐림이고, 카메라가 어떻게 작동하는지의 부산물입니다.

### 모션 블러 101

카메라를 상상해 보세요. 셔터가 있고, 문이 열려 빛이 들어오게 하고, 빛이 들어오는 것을 막습니다. 열려 있는 시간부터 닫히는 시간까지 하나의 사진 또는 움직이는 이미지의 단일 프레임입니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/10/mIrDoWPw.jpeg?resize=900%2C600&ssl=1)

셔터가 열려 있는 동안 프레임의 피사체가 움직이는 경우, 우리는 결국 프레임 사이로 움직이는 물체를 촬영하게 됩니다. 필름에서 이것은 시작점부터 끝까지 피사체가 무한히 많은 곳에 있는 꾸준한 비방처럼 보인다. 움직이는 물체는 또한 그 뒤에 보이는 배경의 일부와 함께 반투명하게 된다.

컴퓨터가 이것을 가짜로 만들기 위해 하는 일은 여러 서브프레임을 모델링한 다음 그것들을 불투명도의 극히 일부에서 함께 합성하는 것입니다. 동일한 물체의 많은 복사본을 모션 경로를 따라 약간 다른 위치에 배치하면 모션 블러와 같은 꽤 설득력 있는 모션이 만들어집니다.

비디오 합성 앱은 모션 블러에 몇 개의 하위 세그먼트가 있어야 하는지 설정하는 경향이 있습니다. 이 값을 정말 낮게 설정하면, 이와 같이 프레임당 4개의 샘플에서 간단한 흰색 점의 애니메이션 프레임이 어떻게 작동하는지 정확하게 확인할 수 있습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/10/w3Ovoa7A.png?resize=916%2C346&ssl=1)

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/10/1qYy5Nyg.png?resize=916%2C346&ssl=1)

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/10/0spk3Yag.png?resize=916%2C346&ssl=1)

설득력 있는 모션 블러를 만드는 데 필요한 샘플의 수는 전적으로 내용과 관련이 있습니다. 아주 빠르게 움직이는 날카로운 모서리가 있는 작은 것은 많은 서브프레임을 필요로 하지만, 천천히 움직이는 것은 몇 개만 필요할지도 모른다. 일반적으로, 더 많이 사용하는 것이 더 설득력 있는 효과를 만들어 낼 것이다.

### CSS에서 이 작업 수행

CSS에서 이 효과를 근사화하기 위해, 우리는 동일한 요소들을 1톤씩 만들어 반투명하게 만들고 그들의 애니메이션을 1초의 아주 작은 조각으로 상쇄시켜야 한다.

먼저 CSS 전환을 사용하여 원하는 애니메이션으로 베이스를 설정하겠습니다. 간단한 검은색 점으로 이동하여 호버(휴대폰 사용 중인 경우 탭)에 변환을 지정합니다. 또한 테두리 반지름과 색상을 애니메이션화하여 이 접근 방식의 유연성을 보여줍니다.

다음은 모션 블러가 없는 기본 애니메이션입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_dyMxvKY" src="//codepen.io/anon/embed/dyMxvKY?height=450&amp;theme-id=1&amp;slug-hash=dyMxvKY&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed dyMxvKY" title="CodePen Embed dyMxvKY" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

자, 검은 점을 20장 복사해봅시다. 모두 같은 위치에 절대 위치를 지정해 놓았습니다. 각 사본의 불투명도는 10%입니다. 수학적으로 정확할 수 있는 것보다 조금 더 많습니다. 하지만 충분히 견고해 보이려면 불투명하게 만들어야 합니다.

다음 단계는 마법이 일어나는 곳입니다. 점 개체의 각 복제본에 대해 약간 증가하는 전환 지연 값을 추가합니다. 모두 똑같은 애니메이션을 실행하지만 각각 3밀리초씩 오프셋됩니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_oNxKZOx" src="//codepen.io/anon/embed/oNxKZOx?height=450&amp;theme-id=1&amp;slug-hash=oNxKZOx&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed oNxKZOx" title="CodePen Embed oNxKZOx" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이 접근법의 장점은 그것이 수많은 다른 애니메이션에 효과가 있는 의사-모션 블러 효과를 만든다는 것이다. 우리는 거기에 색상 변화, 스케일링 전환, 홀수 타이밍, 그리고 모션 블러 효과가 여전히 작용합니다.

20개의 객체 클론을 사용하면 많은 빠르고 느린 애니메이션을 사용할 수 있지만, 적은 수의 객체 클론을 사용하면 여전히 적절한 모션 블러(motion blur)를 생성할 수 있습니다. 특정 애니메이션과 함께 작업하려면 복제된 개체의 수, 불투명도 및 전환 지연 시간을 조정해야 할 수 있습니다. 방금 살펴본 데모에서는 블러 효과를 약간 오버클럭 처리하여 더 두드러지게 만들었습니다.

결국, 컴퓨터 파워의 발전과 함께, 나는 몇몇 주요 브라우저들이 이 효과를 기본적으로 제공하기 시작할 것이라고 기대한다. 그러면 우리는 20개의 동일한 물체를 가지고 있다는 우스꽝스러움을 없앨 수 있습니다. 한편, 이것은 현실적인 모션 블러에 근사한 방법입니다.