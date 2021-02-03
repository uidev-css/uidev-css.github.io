---
layout: post
title: "CSS로 영역 차트를 만드는 방법
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/11/s_3B96DE4366834488A29D0D1C3D10A09AAB92882E189DDEECE4637A2D54E9C4CA_1605267833349_area-chart.png
tags: CHARTS,CLIP-PATH,DATA VISUALIZATION,FLEXBOX
---


순수한 CSS로 차트를 만드는 몇 가지 방법을 알고있을 것입니다.
 그중 일부는 여기 CSS-Tricks에서 다루고 있고 다른 많은 것들은 CodePen에서 찾을 수 있습니다. 그러나 저는 "영역 차트"(하단 영역이 채워진 라인 차트를 상상해보십시오)의 많은 예를 보지 못했습니다. 특히 HTML의 모든 것
 그리고 CSS 만.
 이 기사에서는 의미론적이고 액세스 가능한 HTML 기반을 사용하여이를 수행합니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/11/s_3B96DE4366834488A29D0D1C3D10A09AAB92882E189DDEECE4637A2D54E9C4CA_1605267833349_area-chart.png?resize=1200%2C600&ssl=1)

### HTML부터 시작하겠습니다.
 

단순화하기 위해`<ul>`태그를 래퍼로 사용하고 개별 데이터 항목에 대한`<li>`요소를 사용합니다.
 필요에 따라 프로젝트에서 다른 HTML 태그를 사용할 수 있습니다.
 

```html
<ul class="area-chart">
  <li> 40% </li>
  <li> 80% </li>
  <li> 60% </li>
  <li> 100% </li>
  <li> 30% </li>
</ul>
```

CSS는 내부 HTML 텍스트를 검색 할 수 없기 때문에 CSS 맞춤 속성을 사용하여 데이터를 CSS에 전달합니다.
 각 데이터 항목에는`--start` 및`--end` 사용자 지정 속성이 있습니다.
 

```html
<ul class="area-chart">
  <li style="--start: 0.1; --end: 0.4;"> 40% </li>
  <li style="--start: 0.4; --end: 0.8;"> 80% </li>
  <li style="--start: 0.8; --end: 0.6;"> 60% </li>
  <li style="--start: 0.6; --end: 1.0;"> 100% </li>
  <li style="--start: 1.0; --end: 0.3;"> 30% </li>
</ul>
```

### 고려해야 할 사항은 다음과 같습니다.
 

스타일링을 시작하기 전에 고려해야 할 몇 가지 디자인 원칙이 있습니다.
 

- 단위 데이터 : HTML에서 단위없는 데이터를 사용합니다 (예 :`px`,`em`,`rem`,`%`또는 기타 단위 없음).
 `--start` 및`--end` 사용자 지정 속성은 0과 1 사이의 숫자입니다.
 
- 열 너비 : 각`<li>`요소에 대해 고정 된`너비`를 설정하지 않습니다.
 얼마나 많은 항목이 있는지 알 수 없기 때문에`%`도 사용하지 않을 것입니다.
 각 열 너비는 총 데이터 항목 수로 나눈 기본 래퍼 너비를 기반으로합니다.
 여기서는`<ul>`요소의 너비를`<li>`요소의 수로 나눈 값입니다.
 
- 접근성 : 각`<li>`내의 값은 선택 사항이며`--start` 및`--end` 맞춤 속성 만 필요합니다.
 하지만 화면 판독기 및 기타 보조 기술에 대한 일종의 텍스트 또는 값을 포함하여 콘텐츠를 설명하는 것이 가장 좋습니다.
 

### 이제 스타일링을 시작하겠습니다!
 

먼저 일반적인 레이아웃 스타일부터 시작하겠습니다.
 차트 래퍼 요소는 플렉스 컨테이너로, 항목을 행으로 표시하고 각 하위 요소를 늘려 전체 영역이 채워집니다.
 

```css
.area-chart {
  /* Reset */
  margin: 0;
  padding: 0;
  border: 0;

  /* Dimensions */
  width: 100%;
  max-width: var(--chart-width, 100%);
  height: var(--chart-height, 300px);

  /* Layout */
  display: flex;
  justify-content: stretch;
  align-items: stretch;
  flex-direction: row;
}
```

영역 차트 래퍼가 목록 인 경우 스타일 지정 유연성을 높이기 위해 목록 스타일을 제거해야합니다.
 

```css
ul.area-chart,
ol.area-chart {
  list-style: none;
}
```

이 코드는 전체 차트의 모든 열의 스타일을 지정합니다.
 막대 차트를 사용하면 간단합니다. 각 열에 `배경색`과 `높이`를 사용합니다.
 영역 차트에서는`clip-path` 속성을 사용하여 표시 할 영역을 설정합니다.
 

먼저 각 열을 설정합니다.
 

```css
.area-chart > * {
  /* Even size items */
  flex-grow: 1;
  flex-shrink: 1;
  flex-basis: 0;

  /* Color */
  background: var(--color, rgba(240, 50, 50, .75));
}
```

전체 영역을 덮는 직사각형을 만들기 위해`clip-path` 속성에 도달하고 영역의 좌표를 포함하는`polygon ()`함수를 사용합니다.
 폴리곤이 모든 것을 덮기 때문에 기본적으로 현재 아무 작업도하지 않습니다.
 

```css
.area-chart > * {
  clip-path: polygon(
    0% 0%,     /* top left */
    100% 0%,   /* top right */
    100% 100%, /* bottom right */
    0% 100%    /* bottom left */
  );
}
```

이제 가장 좋은 부분입니다!
 

열의 일부만 표시하려면 해당 영역 차트와 같은 효과를 만들기 위해 잘라냅니다.
 원하는 영역 만 표시하려면`clip-path` 다각형 내부에`--start` 및`--end` 사용자 정의 속성을 사용합니다.
 

```css
.area-chart > * {
  clip-path: polygon(
    0% calc(100% * (1 - var(--start))),
    100% calc(100% * (1 - var(--end))),
    100% 100%,
    0% 100%
  );
}
```

진지하게,이 CSS가 모든 작업을 수행합니다.
 결과는 다음과 같습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_pobQbKd" src="//codepen.io/anon/embed/pobQbKd?height=450&amp;theme-id=1&amp;slug-hash=pobQbKd&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed pobQbKd" title="CodePen Embed pobQbKd" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 여러 데이터 세트 작업
 

이제 기본 사항을 알았으므로 여러 데이터 세트가있는 영역 차트를 만들어 보겠습니다.
 영역 차트는 종종 둘 이상의 데이터 세트를 측정하며 그 효과는 데이터의 계층 적 비교입니다.
 

![image](https://paper-attachments.dropbox.com/s_3B96DE4366834488A29D0D1C3D10A09AAB92882E189DDEECE4637A2D54E9C4CA_1605801751041_area-chart-multiple.png)

이러한 종류의 차트에는 여러 하위 요소가 필요하므로`<ul>`접근 방식을`<table>`로 대체 할 것입니다.
 

```html
<table class="area-chart">
  <tbody>
    <tr>
      <td> 40% </td>
      <td> 80% </td>
    </tr>
    <tr>
      <td> 60% </td>
      <td> 100% </td>
    </tr>
  </tbody>
</table>
```

테이블은 액세스 가능하고 검색 엔진 친화적입니다.
 어떤 이유로 든 스타일 시트가로드되지 않으면 모든 데이터가 마크 업에 계속 표시됩니다.
 

다시 말하지만, 0과 1 사이의 숫자로`--start` 및`--end` 사용자 정의 속성을 사용합니다.
 

```html
<table class="area-chart">
  <tbody>
    <tr>
      <td style="--start: 0; --end: 0.4;"> 40% </td>
      <td style="--start: 0; --end: 0.8;"> 80% </td>
    </tr>
    <tr>
      <td style="--start: 0.4; --end: 0.6;"> 60% </td>
      <td style="--start: 0.8; --end: 1.0;"> 100% </td>
    </tr>
  </tbody>
</table>
```

따라서 먼저`.area-chart` 클래스를 제공 한 래핑 요소 인 테이블의 일반 레이아웃 스타일을 지정합니다.
 

```css
.area-chart {
  /* Reset */
  margin: 0;
  padding: 0;
  border: 0;

  /* Dimensions */
  width: 100%;
  max-width: var(--chart-width, 600px);
  height: var(--chart-height, 300px);
}

```

다음으로`<tbody>`요소를 플렉스 컨테이너로 만들어`<tr>`항목을 행에 균등 한 크기로 표시합니다.
 

```css
.area-chart tbody {
  width: 100%;
  height: var(--chart-height, 300px);

  /* Layout */
  display: flex;
  justify-content: stretch;
  align-items: stretch;
  flex-direction: row;
}
.area-chart tr {
  /* Even size items */
  flex-grow: 1;
  flex-shrink: 1;
  flex-basis: 0;
}
```

이제`<td>`요소가 서로를 덮도록 만들어야합니다. 하나의 요소가 서로 겹쳐서 레이어 효과를 얻습니다.
 각`<td>`는이를 포함하는`<tr>`요소의 전체 영역을 포함합니다.
 

```css
.area-chart tr {
  position: relative;
}
.area-chart td {
  position: absolute;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
}
```

`clip-path : polygon ()`의 마법의 힘을 사용해 보겠습니다!
 0과 1 사이의 값인`--start`와`--end` 사용자 지정 속성 사이의 영역 만 표시합니다.
 

```css
.area-chart td {
  clip-path: polygon(
    0% calc(100% * (1 - var(--start))),
    100% calc(100% * (1 - var(--end))),
    100% 100%,
    0% 100%
  );
}
```

이제 각각에 색상을 추가해 보겠습니다.
 

```css
.area-chart td {
  background: var(--color);
}
.area-chart td:nth-of-type(1) {
  --color: rgba(240, 50, 50, 0.75);
}
.area-chart td:nth-of-type(2) {
  --color: rgba(255, 180, 50, 0.75);
}
.area-chart td:nth-of-type(3) {
  --color: rgba(255, 220, 90, 0.75);
}
```

더 좋은 효과를 얻으려면 불투명도가있는 색상을 사용하는 것이 중요하므로`rgba ()`값을 사용하는 것입니다.
 그렇게하는 경우 대신 여기에서`hsla ()`를 사용할 수 있습니다.
 

그리고 다음과 같이 :
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_dyXEzrw" src="//codepen.io/anon/embed/dyXEzrw?height=450&amp;theme-id=1&amp;slug-hash=dyXEzrw&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed dyXEzrw" title="CodePen Embed dyXEzrw" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 마무리
 verified_user

차트에 얼마나 많은 HTML 요소를 추가하는지는 중요하지 않습니다. 플렉스 기반 레이아웃은 모든 항목의 크기가 동일하도록합니다.
 이렇게하면 래핑 차트 요소의 너비 만 설정하면 항목이 반응 형 레이아웃에 맞게 조정됩니다.
 

순수 CSS를 사용하여 영역 차트를 만드는 한 가지 기술을 다루었습니다.
 고급 사용 사례의 경우 새로운 오픈 소스 데이터 시각화 프레임 워크 인 ChartsCSS.org를 확인할 수 있습니다.
 영역 차트 섹션을 참조하여 HTML 마크 업을 변경하지 않고 다른 방향, 축, 심지어 역순 등으로 영역 차트를 사용자 지정할 수있는 방법을 확인하십시오!
 