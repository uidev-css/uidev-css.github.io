---
layout: post
title: "CSS 도장 순서"
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/07/stacking-contexts.jpg"
tags: STACKING CONTEXTS,Z-INDEX
---


보통, 제가 "그림의 순서"나 "쌓여 있는 상황"과 같은 용어들을 볼 때, 제 뇌는 꺼지기 시작하고 제 눈은 얼버무릴 것입니다. 보통 뇌가 자주 꺼지지 않는 것은 아니지만, 그것은 또 다른 주제입니다.

이갈리아에 있는 마틴 로빈슨은 이런 개념들에 대해 언급했습니다. 예를 들자면, 심지어 저조차도 쉽게 이해할 수 있습니다. 그는 네거티브 여백과 겹치는 두 개의 상자로 시작한다.

```html
<div class="blue box">1</div>
<div class="green box">2</div>
```

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/07/boxes-01.png?resize=187%2C171&ssl=1)

그리고 나서 그는 녹색 상자의 아이인 세 번째 상자를 소개한다. 녹색 상자에는 -1의 `z-index`가 부여된다. 예상하신 대로 녹색 및 노란색 상자는 모두 파란색 상자 아래에 쌓입니다.

```html
<div class="blue box">0</div>
<div class="green box" style="position: relative; z-index: -1;">-1
  <div class="yellow box">-1</div>
</div>
```

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/07/boxes-02.png?resize=216%2C193&ssl=1)

여기서부터 제 뇌가 녹기 시작했죠. 만약 그린 박스의 `z-지수`가 -1로 그대로 유지되지만, 우리는 아이들에게 엄청난 가치를 준다면, 예를 들어 1,000이라고 하자면, 상황은 완전히 똑같아 보인다.

```html
<div class="blue box">0</div>
<div class="green box" style="position: relative; z-index: -1;">-1
  <div class="yellow box" style="position: relative; z-index: 1000;">1000</div>
</div>
```

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/07/boxes-03.png?resize=211%2C187&ssl=1)

비록 노란색 상자의 `z-index`를 바꾸면 대신 파란색 상자가 위에 있어야 한다는 것을 암시하지만, 여러분 중 많은 사람들은 이미 파란색 상자가 위에 있는 이유를 추측할 수 있을 것입니다. 하지만 저는 그렇지 않았습니다. 마틴은 부록 E 깊숙이 묻혀 있는 CSS2 규격에서 기술적 해답을 찾아냈는데, 그는 이를 정중히 연결해주었다. 그렇지 않았다면 나는 결코 그것을 찾지 못했을 것이다.

> 우리는 스택 컨텍스트가 원자적으로 색칠된 페이지 항목의 집합이라는 것을 부록 E에서 배운다. 이것은 무엇을 의미합니까? 쉽게 말하면, 그것은 쌓기 문맥 안에 있는 것들이 하나의 단위로 함께 그려지고 쌓기 내용 밖의 물건들은 그 사이에 절대 그려지지 않는다는 것을 의미합니다. 활성 'z-index'를 갖는 것은 CSS에서 스택 컨텍스트 생성을 트리거하는 상황 중 하나입니다. 세 번째 요소가 처음 두 요소와 동일한 스택 컨텍스트에 속하도록 위의 예제를 조정할 수 있는 방법이 있습니까? 정답은 두 번째 요소에 의해 생성된 스택 컨텍스트에서 제거해야 한다는 것입니다.

그래, 그래. 노란색 상자가 녹색 상자의 자식인 한, 두 사람은 파란색 상자가 속한 부분이 없는 스택 컨텍스트를 형성합니다. 파란색 위에 노란색을 표시하려면 녹색의 쌓기 컨텍스트에서 노란색을 제거해야 합니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/07/boxes-04.png?resize=2314%2C580&ssl=1)

그게 마틴의 직책의 핵심이긴 하지만, 마틴은 더 나아가서 저쪽으로 갈 가치가 있어요. 이렇게 하면 쌓기 순서가 어떻게 보나피드 CSS 트릭으로 이어지는지 알 수 있습니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/07/boxes-05.png?resize=407%2C232&ssl=1)

우리가 z-index가 레벨 플레이 필드가 아니라는 증거를 처음으로 연결한 것은 아니기 때문에 다음 번(그리고 필연적으로) 스택 요소들과 씨름할 때를 기억하기 위해 이 일을 하려고 한다.

직접 링크 →