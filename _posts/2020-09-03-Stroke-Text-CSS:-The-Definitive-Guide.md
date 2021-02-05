---
layout: post
title: "Stroke Text CSS: Definitive Guide"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/09/stroke-text-guide.png
tags: STROKE,SVG
---


나는 웹에서 쓰다듬은 텍스트를 생각할 때마다: 아니다.

CSS에는 -webkit-text-stroke가 있지만, 문자의 벡터 아웃라인 가운데에 스트로크를 배치하여 문자가 제대로 보이지 않게 한다. Chrome이나 Safari에서 이것을 보세요. 역겨워. 할거면 적어도 정확한 타입을 위에 올려놓아서 원래 온전성을 가지도록 해. 하지만 그렇다고 해서, 비표준적이고 교차 브라우저 지원을 받을 수도 없습니다.

존 네고이타는 텍스트 스트로크를 여러 가지 다른 방법으로 커버한다. 이를 속이는 또 다른 방법은 텍스트 그림자를 여러 방향으로 사용하는 것이다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/09/stroke-text-css-shadow.jpg?resize=716%2C732&ssl=1)

위의 그림과 같이 네 가지 방법으로 자를 수 없기 때문에 그는 그것에 만족한다. SVG는 스트로크를 할 수 있습니다. 여러분이 생각하기에 훨씬 더 현명할 것입니다. 하지만 이것은 CSS가 스트래들 스트로크를 할 때와 같은 문제를 가지고 있습니다. 단지 조금 더 많은 제어 능력을 가지고 있을 뿐입니다.

저는 일반적으로 웹에서 획을 그은 텍스트를 피하게 될 것입니다. 단 한번의 일회성이 아니면 디자인 소프트웨어에서 SVG로 만들어 획을 그어 `배경 이미지`로 사용할 것입니다.

멋있어 보이는 것이 가능하다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/09/img_4636.jpg?resize=452%2C247&ssl=1)

직접 링크 →