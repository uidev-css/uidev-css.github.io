---
layout: post
title: "글꼴 무게: 유해하다고 간주되는 300"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/08/font-weight-300.png
tags: FONT-WEIGHT
---


토마시 야누에크:

> 요즘 많은 웹페이지가 스타일시트에 300글씨로 돼 있다. DejaVu Sans를 선호하는 글꼴로 사용하면 읽기 어려운 매우 얇고 가벼운 텍스트를 만들 수 있는데, 그 이유는 "DejaVu Sans ExtraLight" 변형 (중량 200)이 어떤 이유에서인지 > 360 (Chrome; Firefox에서 최대 399까지)에 사용되고 있기 때문이다. 왜 이런 일이 일어나는지, 어떻게 할 수 있는지 조사해보자.

왜 사람들은 폰트급 300을 아예 설정할까. 글쎄, 맥피플, 아마도. macOS Catalina 컴퓨터에서 기본 글꼴과 기본 글꼴 중 400과 300의 차이점을 확인합니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/08/Screen-Shot-2020-08-05-at-3.25.12-PM.png?resize=1024%2C442&ssl=1)

디자이너가 어떤 경우에는 300kg을 쓴다고 해서 비난하지 않을 거예요. 사실, 11년 전, 저는 이것을 선전하는 "Better Helvetica"라는 단편소설을 출판했습니다.

```css
body {
   font-family: "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, "Lucida Grande", sans-serif; 
   font-weight: 300;
}
```

그러나 기본 글꼴이 DejaVu Sans(많은 Linux 및 Android 시스템에서 기본값)인 Tomá의 경우 글꼴이 얇으면 읽기 어렵다. 이슈의 일부는 폴백 폰트가 300을 가지고 있지 않다면, 규격은 필요할 경우 100까지 떨어질 수 있다고 말한다. 나는 그것에 대한 전문용어가 꽤 희박하다고 생각한다.

직접 피하거나 웹 글꼴이 있는 것으로 알고 있는 웹 글꼴을 로드할 때 사용합니다. 그러나 Tomá➡의 기사에서 이 문제가 여러 사이트에서 사용자를 괴롭힐 경우 컴퓨터에 대한 수정 사항을 확인하십시오. 이것은 실제로 다른 수준의 픽스를 생각나게 합니다.

직접 링크 →