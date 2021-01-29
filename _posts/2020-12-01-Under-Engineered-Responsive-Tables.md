---
layout: post
title: "저조한 반응 형 테이블
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2019/07/table-pattern.png
tags: RESPONSIVE TABLES
---


저는 2011 년에 반응 형 데이터 테이블에 대해 처음 블로그를 썼습니다. 반응 형 웹 디자인이 처음 등장했을 때는 뛰어 내려야하는 데이터 테이블과 같은 장애물이 거의 없었습니다.
 `<table>`요소의 특성은 포함 된 콘텐츠에 따라 최소 너비가 있고 작은 화면 장치의 너비를 쉽게 초과 할 수 있다는 것입니다.
 

내가 만든이 이미지는 여전히 문제를 잘 다루고 있습니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/11/doublesuck.png?resize=570%2C723&ssl=1)

빼고는 ... 아마 그들은 똑같이 안좋을 수도 있습니다.
 왼쪽의 이미지를 스크롤 할 수 있었다면 실제로는 ... 그렇게 나쁘지 않습니다.
 사실, 이것이 제가 CSS-Tricks에서 최근에 한 일입니다.
 테이블에 어떤 내용이 있는지 모를 때 반응 형 테이블을 처리하는 가장 안전한 방법이라고 생각합니다.
 여기에서 표를 포함 할 수있는 블로그 게시물에 적용되는 기본 표 스타일을 설정해야하는 경우가 여기에 해당합니다.
 

스크롤 가능한 테이블 아이디어의 핵심은`overflow : auto;`가있는`<div>`로 감싸는 것입니다.
 이렇게하면 내부의`<table>`이 부모의 너비를 자유롭게 초과 할 수 있지만 `너비를 날려 버리지`않고 대신 스크롤바를 트리거합니다.
 이것만으로는 충분하지 않습니다. 여기 진짜 특종을 가진 Adrian Roselli가 있습니다.
 래핑`<div>`는 초점을 맞출 수 있고 레이블이 지정되어야합니다.
 

```html
<div role="region" aria-labelledby="Caption01" tabindex="0">
  <table>
    <caption id="Caption01">Appropriate caption</caption>
    <!-- ...  -->
  </table>
</div>
```

그런 다음 다른 모든 작업을 올바르게 수행 한 상태에서 스크롤 및 포커스 스타일을 적용합니다.
 

```css
[role="region"][aria-labelledby][tabindex] {
  overflow: auto;
}

[role="region"][aria-labelledby][tabindex]:focus {
  outline: .1em solid rgba(0,0,0,.1);
}
```

반응 형 테이블을 추가로 엔지니어링하려는 경우 모든 종류의 옵션이 있습니다.
 고전적인 방법 중 하나는 많은 요소를`display : block`하는 것입니다. 즉, 한 행의 모든 데이터 (`<tr>`)가 누적 된 콘텐츠 덩어리가되어
 부모 요소의 너비.
 의사 요소를 사용하여 모든 데이터 레이블을 올바르게 가져올 수 있습니다.
 그러나 이것은 개별 콘텐츠 행이 단독으로 완벽 할 때만 의미가 있습니다.
 모든 테이블에 해당되는 것은 아닙니다.
 테이블의 목적은 데이터를 상호 참조하는 것일 수 있으며이 경우이 접근 방식을 사용하면 데이터를 망칠 수 있습니다.
 다시 말하지만, 테이블의 내용과 목적을 정확히 알고있을 때 반응 형 테이블에 대한 좋은 접근 방식이 있습니다.
 하지만 모르는 경우 가장 반응이 빠른 솔루션은 스 와이프 할 수 있는지 확인하는 것입니다.
 

직접 링크 →
 