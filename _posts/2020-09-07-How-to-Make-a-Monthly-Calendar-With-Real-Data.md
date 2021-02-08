---
layout: post
title: "실제 데이터를 사용하여 월별 달력을 만드는 방법"
author: "Uidev Css"
thumbnail: "undefined"
tags: PARCEL,SPA
---


여러분은 웹페이지에서 달력을 보고 그들이 어떻게 그런 짓을 했을까 생각해 본 적이 있나요? 이와 같은 경우에는 플러그인이나 내장형 Google 캘린더를 찾는 것이 당연할 수 있지만, 실제로 HTML, CSS, JavaScript의 3중창만 있으면 되는 것이 생각보다 쉽게 만들 수 있습니다. 같이 만들어요!

코드 샌드박스에 데모를 준비했습니다. 우리가 무엇을 목표로 하는지 보실 수 있도록 말이죠.

먼저 달력의 작업에 대한 몇 가지 요구 사항을 살펴보겠습니다. 다음을 수행해야 합니다.

- 지정된 달의 월 그리드 표시
- 그리드가 항상 가득 차도록 이전 및 다음 달의 날짜 표시
- 현재 날짜 표시
- 현재 선택한 달의 이름 표시
- 이전 및 다음 달로 이동
- 사용자가 한 번의 클릭으로 현재 월로 돌아갈 수 있도록 허용

아, 그리고 우리는 이것을 초경량 유틸리티 라이브러리인 Day.js에서 달력 날짜를 가져오는 단일 페이지 애플리케이션으로 만들 것입니다.

우리는 일을 쉽게 하기 위해 특정한 틀을 선택하는 것을 피할 것입니다. 이 설정을 위해 패키지 관리를 위해 구획을 사용하여 Babel로 쓰고, 항목을 묶고, 프로젝트에 대한 유일한 종속성을 관리할 수 있습니다. `패키지`자세한 내용은 코드 샌드박스에 있는 json 파일을 참조하십시오.

### 1단계: 기본 마크업과 스타일로 시작

먼저 일정관리에 대한 기본 템플리트 작성부터 시작하겠습니다. 이건 뭔가 화려할 필요는 없어요. 하지만 그것 또한 테이블에 의존하지 않고 해야 한다.

다음과 같은 세 가지 계층으로 마크업을 개략적으로 설명할 수 있습니다.

- 일정관리 머리글의 섹션입니다. 현재 선택한 달과 월 간 페이지 나누기를 담당하는 요소가 표시됩니다.
- 일정관리 그리드 헤더를 위한 섹션입니다. 다시 말씀드리지만, 양식 테이블에는 도착하지 않지만, 월요일부터 시작하는 요일 목록을 포함하는 표 머리글과 같습니다.
- 달력 그리드. 아시다시피, 현재 달의 매일은 그리드에서 정사각형으로 표시됩니다.

이것을 `index.js`라는 파일에 기록하자. 프로젝트 폴더의 `src` 폴더 안으로 들어갈 수 있습니다. 우리는 실제로 우리의 작업을 가져오는 프로젝트 루트에는 `index.html` 파일이 있을 것이지만, 일차 마크업은 자바스크립트 파일에 존재할 것이다.

```js
<!-- index.js -->
document.getElementById("app").innerHTML = `
<!-- Parent container for the calendar month -->
<div class="calendar-month">
  <!-- The calendar header -->
  <section class="calendar-month-header">
    <!-- Month name -->
    <div
      id="selected-month"
      class="calendar-month-header-selected-month"
    >
      July 2020
    </div>
 
    <!-- Pagination -->
    <div class="calendar-month-header-selectors">
      <span id="previous-month-selector"><</span>
      <span id="present-month-selector">Today</span>
      <span id="next-month-selector">></span>
    </div>
  </section>
  
  <!-- Calendar grid header -->
  <ol
    id="days-of-week"
    class="day-of-week"
  >
    <li>Mon</li>
    ...
    <li>Sun</li>
  </ol>
 
  <!-- Calendar grid -->
  <ol
    id="calendar-days"
    class="date-grid"
  >
    <li class="calendar-day">
      <span>
        1
      </span>
      ...
      <span>
        29
      </span>
    </li>
  </ol>
</div>
`;
```

이제 이 파일을 프로젝트의 루트 디렉터리에 있는 `index.html` 파일로 가져오도록 하겠습니다. 여기선 특별한 일이 없어요. 이것은 단지 우리 앱의 타겟이 되는 요소를 가진 HTML 보일러 플레이트로, 우리의 `index.js` 파일을 등록합니다.

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Parcel Sandbox</title>
    <meta charset="UTF-8" />
  </head>

  <body>
    <div id="app"></div>

    <script src="src/index.js"></script>
  </body>
</html>
```

이제 마크업도 좀 할 수 있게끔 스타일을 좀 맞춰보도록 하죠. 구체적으로 다음과 같이 설명합니다.

- 플렉스 박스를 사용하여 요소를 배치합니다.
- CSS 그리드를 사용하여 달력 프레임 만들기
- 셀 내에 레이블을 배치합니다.

먼저 `index.js`가 있는 동일한 `src` 폴더에 새 styles.css 파일을 생성하고 이 파일을 다음 위치에 삭제해 보겠습니다.

```css
body {
  --grey-100: #e4e9f0;
  --grey-200: #cfd7e3;
  --grey-300: #b5c0cd;
  --grey-800: #3e4e63;
  --grid-gap: 1px;
  --day-label-size: 20px;
}

.calendar-month {
  position: relative;
  /* Color of the day cell borders */
  background-color: var(--grey-200);
  border: solid 1px var(--grey-200);
}
 
/* Month indicator and selectors positioning */
.calendar-month-header {
  display: flex;
  justify-content: space-between;
  background-color: #fff;
  padding: 10px;
}
 
/* Month indicator */
.calendar-month-header-selected-month {
  font-size: 24px;
  font-weight: 600;
}
 
/* Month selectors positioning */
.calendar-month-header-selectors {
  display: flex;
  align-items: center;
  justify-content: space-between;
  width: 80px;
}
 
.calendar-month-header-selectors > * {
  cursor: pointer;
}
 
/* | Mon | Tue | Wed | Thu | Fri | Sat | Sun | */
.day-of-week {
  color: var(--grey-800);
  font-size: 18px;
  background-color: #fff;
  padding-bottom: 5px;
  padding-top: 10px;
}
 
.day-of-week,
.days-grid {
  /* 7 equal columns for weekdays and days cells */
  display: grid;
  grid-template-columns: repeat(7, 1fr);
}
 
.day-of-week > * {
  /* Position the weekday label within the cell */
  text-align: right;
  padding-right: 5px;
}
 
.days-grid {
  height: 100%;
  position: relative;
  /* Show border between the days */
  grid-column-gap: var(--grid-gap);
  grid-row-gap: var(--grid-gap);
  border-top: solid 1px var(--grey-200);
}
 
.calendar-day {
  position: relative;
  min-height: 100px;
  font-size: 16px;
  background-color: #fff;
  color: var(--grey-800);
  padding: 5px;
}
 
/* Position the day label within the day cell */
.calendar-day > span {
  display: flex;
  justify-content: center;
  align-items: center;
  position: absolute;
  right: 2px;
  width: var(--day-label-size);
  height: var(--day-label-size);
}
```

그리드를 구성하는 핵심 요소는 다음과 같습니다.

```css
.day-of-week,
.days-grid {
  /* 7 equal columns for weekdays and days cells */
  display: grid;
  grid-template-columns: repeat(7, 1fr);
}
```

달력 그리드 헤더와 달력 그리드 자체는 CSS 그리드를 사용하여 사물을 배치하고 있습니다. 우리는 일주일에 항상 7일이 있을 것을 알고 있기 때문에 "반복()" 함수를 사용하여 서로 비례하는 7개의 열을 만들 수 있다. 또한 일정관리의 일관성을 유지하기 위해 달력 날짜마다 최소 100px의 `최소 높이`를 선언합니다.

이러한 스타일을 마크업과 연계시켜야 하므로 `index.js` 파일의 상단에 추가해 보겠습니다.

```js
import "./styles.css";
```

여기까지 와서 우리가 지금까지 뭘 가졌는지 보기 좋은 장소야.

### 2단계: 현재 월 달력 설정

아마 아시겠지만 템플릿에는 현재 정적 데이터만 포함되어 있습니다. 월은 7월로 하드코딩되고 일수도 하드코딩된다. 바로 거기서 데이.js가 활동하게 됩니다. 실제 달력 데이터를 사용하여 특정 달의 정확한 요일에 날짜를 적절하게 배치하는 데 필요한 모든 데이터를 제공합니다. 이를 통해 데이터를 표시하는 데 필요한 모든 날짜 형식 지정 옵션부터 한 달 시작 날짜까지 원하는 항목을 가져오고 설정할 수 있습니다.

다음 작업을 수행합니다.

- 현재 월 가져오기
- 요일(주)을 배치할 위치 계산
- 이전 및 다음 달의 날짜를 표시하기 위한 날짜 계산
- 모든 요일을 단일 배열로 표시

먼저 Day.js를 가져오고 모든 정적 HTML(선택한 달, 평일 및 일)을 제거해야 합니다. 이 작업을 위해 스타일을 가져온 바로 위의 `index.js` 파일에 추가할 것입니다.

```js
import dayjs from "dayjs";
```

우리는 또한 도움을 받기 위해 데이.js 플러그인에 의존할 것이다. WeekDay는 일주일의 첫날을 설정하는 데 도움이 됩니다. 어떤 사람들은 일주일의 첫날로 일요일을 선호한다. 다른 사람들은 월요일을 선호한다. 음, 경우에 따라서는 금요일부터 시작하는 게 말이 되는 경우도 있어요. 월요일부터 시작할 거예요.

weekOfYear 플러그인은 해당 연도의 모든 주 중 현재 주에 대한 숫자 값을 반환합니다. 1년에 52주가 있기 때문에 1월 1일부터 시작하는 주가 1년 중 첫 주라고 할 수 있습니다.

따라서 수입 내역 바로 뒤에 `index.js`에 기재한 내용은 다음과 같습니다.

```js
const weekday = require("dayjs/plugin/weekday");
const weekOfYear = require("dayjs/plugin/weekOfYear");
 
dayjs.extend(weekday);
dayjs.extend(weekOfYear);
```

하드코딩된 일정관리 값을 제거하면 지금까지 `index.js`에 있는 내용은 다음과 같습니다.

```js
import dayjs from "dayjs";
import "./styles.css";
const weekday = require("dayjs/plugin/weekday");
const weekOfYear = require("dayjs/plugin/weekOfYear");
 
dayjs.extend(weekday);
dayjs.extend(weekOfYear);
 
document.getElementById("app").innerHTML = `
<div class="calendar-month">
  <section class="calendar-month-header">
    <div
      id="selected-month"
      class="calendar-month-header-selected-month"
    >
    </div>
    <div class="calendar-month-header-selectors">
      <span id="previous-month-selector"><</span>
      <span id="present-month-selector">Today</span>
      <span id="next-month-selector">></span>
    </div>
  </section>
  
  <ul
    id="days-of-week"
    class="day-of-week"
  >
  </ul>
  <ul
    id="calendar-days"
    class="days-grid"
  >
  </ul>
</div>
`;
```

이제 상수를 몇 개 설정하겠습니다. 특히, 요일 배열(예: 월요일, 화요일, 수요일 등):

```js
const WEEKDAYS = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
```

그런 다음 현재 연도를 가져와 `YYYY` 형식으로 설정합니다.

```js
const INITIAL_YEAR = dayjs().format("YYYY");
```

그리고 달력을 처음 로드할 때 현재 달을 시작점으로 설정하려고 합니다. 여기서 `M`은 월을 숫자 값으로 포맷합니다(예: 1월은 1).

```js
const INITIAL_MONTH = dayjs().format("M");
```

이제 달력 그리드 헤더를 요일로 채우겠습니다. 먼저 적절한 요소(`#days-of-week`)를 잡은 다음 `WEEKDAYS` 배열을 반복하여 배열의 각 항목에 대한 목록 항목 요소를 생성하고 각 항목의 이름을 설정합니다.

```js
// Select the calendar grid header element
const daysOfWeekElement = document.getElementById("days-of-week");
 
// Loop through the array of weekdays
WEEKDAYS.forEach(weekday => {
  // For each item in the array, make a list item element
  const weekDayElement = document.createElement("li");
  // Append a child element inside the list item...
  daysOfWeekElement.appendChild(weekDayElement);
  /// ...that contains the value in the array
  weekDayElement.innerText = weekday;
});
```

### 3단계: 캘린더 그리드 생성

그것은 꽤 간단했지만 이제 진정한 재미는 달력 그리드를 가지고 놀기 시작할 것이다. 그것을 바로잡기 위해 우리가 정말로 해야 할 일이 무엇인지 잠시 생각해 봅시다.

먼저 날짜 번호가 올바른 주중 열에 포함되기를 원합니다. 예를 들어, 2020년 7월 1일은 수요일이다. 여기서부터 날짜 번호가 매겨져야 합니다.

월 1일이 수요일이면 첫 주 월요일과 화요일에는 빈 그리드 항목이 있는 것입니다. 그 달의 마지막 날은 7월 31일로 금요일이다. 이는 그리드의 마지막 주에 토요일과 일요일이 비어 있다는 것을 의미한다. 우리는 달력 그리드가 항상 가득 차게 하기 위해 지난 달과 다음 달의 후행일과 선행일을 각각 채워 넣으러 갔다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/07/calendar-month-view-previous-past-months.png?resize=1024%2C682&ssl=1)

현재 달의 요일을 그리드에 추가하려면 현재 월에 며칠이 있는지 알아야 합니다. 우리는 Day.js에서 제공하는 daysInMonth 방법을 통해 그것을 얻을 수 있습니다. 이를 위한 도우미 방법을 만들어 보겠습니다.

```js
function getNumberOfDaysInMonth(year, month) {
  return dayjs(`${year}-${month}-01`).daysInMonth()
}
```

이 사실을 알게 되면 현재 달의 일 수와 같은 길이의 빈 배열을 만듭니다. 그런 다음 해당 배열을 매핑하고 각 배열에 대한 일별 객체를 만듭니다. 생성한 개체는 임의 구조를 가지고 있으므로 필요한 경우 다른 속성을 추가할 수 있습니다.

그러나 이 예에서는 특정 날짜가 현재 날짜인지 확인하는 데 사용할 `날짜` 속성이 필요합니다. 또한 라벨 역할을 하는 `day of month` 속성(예: 1, 2, 3 등)도 반환됩니다. isCurrentMonth는 날짜가 현재 월인지 그 밖의 것인지를 확인합니다. 만약 그것이 현재 월의 범위를 벗어난다면, 우리는 사람들이 그들이 현재 월의 범위를 벗어난다는 것을 알 수 있도록 그것들을 스타일링할 것이다.

```js
function createDaysForCurrentMonth(year, month) {
  return [...Array(getNumberOfDaysInMonth(year, month))].map((day, index) => {
    return {
      date: dayjs(`${year}-${month}-${index + 1}`).format("YYYY-MM-DD"),
      dayOfMonth: index + 1,
      isCurrentMonth: true
    };
  });
}
```

현재 월에 표시할 이전 달의 날짜를 가져오려면 선택한 달의 첫 번째 날의 주일이 무엇인지 확인해야 합니다. WeekDay 플러그인을 Day.js에 사용할 수 있습니다. 이를 위한 도우미 방법을 만들어 보겠습니다.

```js
function getWeekday(date) {
  return dayjs(date).weekday()
}
```

그럼 그 기준으로 전월의 마지막 월요일이 어느 날인지 확인이 필요합니다. 현재 월 뷰에서 전월에서 며칠까지 볼 수 있어야 하는지 알 수 있는 해당 값이 필요합니다. 우리는 이번 달 초하루에서 평일 값을 빼면 그것을 얻을 수 있습니다. 예를 들어, 월의 첫날이 수요일이면, 우리는 전월의 마지막 월요일을 얻기 위해 3일을 빼야 합니다. 이 값을 사용하면 이전 달의 마지막 월요일부터 해당 월 말까지 일별 개체 배열을 만들 수 있습니다.

```js
function createDaysForPreviousMonth(year, month) {
  const firstDayOfTheMonthWeekday = getWeekday(currentMonthDays[0].date);
 
  const previousMonth = dayjs(`${year}-${month}-01`).subtract(1, "month");
  
  // Account for first day of the month on a Sunday (firstDayOfTheMonthWeekday === 0)
  const visibleNumberOfDaysFromPreviousMonth = firstDayOfTheMonthWeekday ? firstDayOfTheMonthWeekday - 1 : 6
 
  const previousMonthLastMondayDayOfMonth = dayjs(
    currentMonthDays[0].date
  ).subtract(visibleNumberOfDaysFromPreviousMonth, "day").date();

  return [...Array(visibleNumberOfDaysFromPreviousMonth)].map((day, index) => {    
    return {
      date: dayjs(
        `${previousMonth.year()}-${previousMonth.month() + 1}-${previousMonthLastMondayDayOfMonth + index}`
      ).format("YYYY-MM-DD"),
      dayOfMonth: previousMonthLastMondayDayOfMonth + index,
      isCurrentMonth: false
    };
  });
}
```

이제 역순으로 다음 달부터 현재 달의 그리드를 채우려면 며칠이 필요한지 계산해 봅시다. 다행히 방금 만든 헬퍼를 전월 계산에 사용할 수 있습니다. 차이점은 그 평일 숫자 값을 7에서 빼서 다음 달부터 몇 일까지 볼 수 있는지 계산한다는 것입니다.

예를 들어, 월의 마지막 날이 토요일인 경우, 다음 달(일)부터 필요한 날짜 배열을 작성하려면 7에서 1일을 빼야 합니다.

```js
function createDaysForNextMonth(year, month) {
  const lastDayOfTheMonthWeekday = getWeekday(`${year}-${month}-${currentMonthDays.length}`)
 
  const visibleNumberOfDaysFromNextMonth = lastDayOfTheMonthWeekday ? 7 - lastDayOfTheMonthWeekday : lastDayOfTheMonthWeekday
 
  return [...Array(visibleNumberOfDaysFromNextMonth)].map((day, index) => {
    return {
      date: dayjs(`${year}-${Number(month) + 1}-${index + 1}`).format("YYYY-MM-DD"),
      dayOfMonth: index + 1,
      isCurrentMonth: false
    }
  })
}
```

네, 필요한 모든 요일을 생성하는 방법을 알고 있습니다. 방금 만든 방법을 사용하여 모든 요일을 이전 달과 다음 달의 채우기 날짜를 포함하여 현재 달의 모든 요일의 단일 배열로 병합해 보겠습니다.

```js
let currentMonthDays = createDaysForCurrentMonth(INITIAL_YEAR, INITIAL_MONTH)
let previousMonthDays = createDaysForPreviousMonth(INITIAL_YEAR, INITIAL_MONTH, currentMonthDays[0])
let nextMonthDays = createDaysForNextMonth(INITIAL_YEAR, INITIAL_MONTH)
 
let days = [...this.previousMonthDays, ...this.currentMonthDays, ...this.nextMonthDays]
```

방금 살펴본 `index.js`에 수록된 모든 내용은 다음과 같습니다.

```js
// Same as before ...
 
const WEEKDAYS = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
const INITIAL_YEAR = dayjs().format("YYYY");
const INITIAL_MONTH = dayjs().format("M");
const daysOfWeekElement = document.getElementById("days-of-week");
 
// Add weekdays to calendar header
WEEKDAYS.forEach(weekday => {
  const weekDayElement = document.createElement("li");
  daysOfWeekElement.appendChild(weekDayElement);
  weekDayElement.innerText = weekday;
});
 
let currentMonthDays = createDaysForCurrentMonth(INITIAL_YEAR, INITIAL_MONTH);
let previousMonthDays = createDaysForPreviousMonth(INITIAL_YEAR, INITIAL_MONTH);
let nextMonthDays = createDaysForNextMonth(INITIAL_YEAR, INITIAL_MONTH);
let days = [...previousMonthDays, ...currentMonthDays, ...nextMonthDays];
 
console.log(days);
 
function getNumberOfDaysInMonth(year, month) {
  return dayjs(`${year}-${month}-01`).daysInMonth();
}
 
function createDaysForCurrentMonth(year, month) {
  return [...Array(getNumberOfDaysInMonth(year, month))].map((day, index) => {
    return {
      date: dayjs(`${year}-${month}-${index + 1}`).format("YYYY-MM-DD"),
      dayOfMonth: index + 1,
      isCurrentMonth: true
    };
  });
}
 
function createDaysForPreviousMonth(year, month) {
  const firstDayOfTheMonthWeekday = getWeekday(currentMonthDays[0].date);
  const previousMonth = dayjs(`${year}-${month}-01`).subtract(1, "month");

  // Cover first day of the month being sunday (firstDayOfTheMonthWeekday === 0)
  const visibleNumberOfDaysFromPreviousMonth = firstDayOfTheMonthWeekday
    ? firstDayOfTheMonthWeekday - 1
    : 6;

  const previousMonthLastMondayDayOfMonth = dayjs(currentMonthDays[0].date)
    .subtract(visibleNumberOfDaysFromPreviousMonth, "day")
    .date();
 
  return [...Array(visibleNumberOfDaysFromPreviousMonth)].map((day, index) => {
    return {
      date: dayjs(
        `${previousMonth.year()}-${previousMonth.month() +
          1}-${previousMonthLastMondayDayOfMonth + index}`
      ).format("YYYY-MM-DD"),
      dayOfMonth: previousMonthLastMondayDayOfMonth + index,
      isCurrentMonth: false
    };
  });
}

function createDaysForNextMonth(year, month) {
  const lastDayOfTheMonthWeekday = getWeekday(
    `${year}-${month}-${currentMonthDays.length}`
  );
  const nextMonth = dayjs(`${year}-${month}-01`).add(1, "month");
  const visibleNumberOfDaysFromNextMonth = lastDayOfTheMonthWeekday
    ? 7 - lastDayOfTheMonthWeekday
    : lastDayOfTheMonthWeekday;
  return [...Array(visibleNumberOfDaysFromNextMonth)].map((day, index) => {
    return {
      date: dayjs(
        `${nextMonth.year()}-${nextMonth.month() + 1}-${index + 1}`
      ).format("YYYY-MM-DD"),
      dayOfMonth: index + 1,
      isCurrentMonth: false
    };
  });
}

function getWeekday(date) {
  return dayjs(date).weekday();
}
```

### 4단계: 달력 날짜 표시

네, 달력 기본 마크업과 현재 달의 날짜를 표시하는 데 필요한 데이터, 그리고 빈 그리드 항목을 채우기 위해 전월과 다음 달의 날짜가 있습니다. 이제 달력에 날짜를 추가해야 합니다!

우리는 이미 `#calendar-days`라는 달력 그리드를 위한 컨테이너를 가지고 있습니다. 그 요소를 잡읍시다.

```js
const calendarDaysElement = document.getElementById("calendar-days");
```

이제 일정관리 보기에 하루를 추가하는 기능을 만들어 보겠습니다.

```js
function appendDay(day, calendarDaysElement) {
  const dayElement = document.createElement("li");
  const dayElementClassList = dayElement.classList;
 
  // Generic calendar day class
  dayElementClassList.add("calendar-day");
 
  // Container for day of month number
  const dayOfMonthElement = document.createElement("span");
 
  // Content
  dayOfMonthElement.innerText = day.dayOfMonth;
 
  // Add an extra class to differentiate current month days from prev/next month days
  if (!day.isCurrentMonth) {
    dayElementClassList.add("calendar-day--not-current");
  }
 
  // Append the element to the container element
  dayElement.appendChild(dayOfMonthElement);
  calendarDaysElement.appendChild(dayElement);
}
```

이전 달과 다음 달에 오는 날짜를 확인하여 현재 달의 날짜와 다르게 스타일링할 수 있는 클래스를 추가할 수 있습니다.

```css
.calendar-day--not-current {
  background-color: var(--grey-100);
  color: var(--grey-300);
}
```

다 됐다! 더 이상 어쩔 수 없다! 우리 달력은 이제 우리가 원하는 대로 보여야 한다.

### 5단계: 현재 월 선택

지금까지의 정보는 꽤 괜찮지만 사용자가 현재 월부터 월부터 월까지 앞뒤로 페이지를 넘길 수 있기를 바랍니다. 대부분의 논리가 마련되어 있으므로 일 계산을 다시 실행하고 업데이트된 데이터로 달력을 다시 그리는 페이지 지정 버튼에 클릭(click) 수신기를 추가하면 된다.

시작하기 전에 코드 전체에서 참조할 수 있도록 현재 월, 이전 월, 다음 달에 있는 날짜에 대한 변수를 정의하겠습니다.

```js
let currentMonthDays;
let previousMonthDays;
let nextMonthDays;
```

이제 다른 달로 페이지를 넘길 때 일정관리 날짜를 다시 계산하고 일정관리를 다시 렌더링하는 방법을 만들어 보겠습니다. 우리는 그 기능을 `create calendar`라고 부를 것이다. 이 방법은 연도 및 월의 두 가지 속성을 사용하며, 이에 따라 달력은 새 데이터로 렌더링되고 새 페이지 로드 없이 다시 렌더링됩니다.

메소드는 선택한 월 레이블을 항상 표시하도록 헤더 내용을 바꿉니다.

```js
function createCalendar(year = INITIAL_YEAR, month = INITIAL_MONTH) {
  document.getElementById("selected-month").innerText = dayjs(
    new Date(year, month - 1)
  ).format("MMMM YYYY");
 
  // ...
```

그런 다음 일정관리 날짜 컨테이너를 가져와서 기존의 모든 날짜를 제거합니다.

```js
// ...
 
  const calendarDaysElement = document.getElementById("calendar-days");
  removeAllDayElements(calendarDaysElement);
 
  // ...
```

달력이 지워지면 이전에 만든 방법을 사용하여 표시할 새 일수가 계산됩니다.

```js
//...
 
currentMonthDays = createDaysForCurrentMonth(
  year,
  month,
  dayjs(`${year}-${month}-01`).daysInMonth()
);
 
previousMonthDays = createDaysForPreviousMonth(year, month);
 
nextMonthDays = createDaysForNextMonth(year, month);
 
const days = [...previousMonthDays, ...currentMonthDays, ...nextMonthDays];
 
// ...
```

그리고 마지막으로, 그것은 매일의 하루 요소를 추가할 것입니다.

```js
// ...
days.forEach(day => {
  appendDay(day, calendarDaysElement);
});
```

기존 달력을 지우는 remove AllDayElements 메소드라는 논리가 여전히 빠져 있다. 이 메서드는 첫 번째 일정관리 날짜 요소를 가져와서 제거한 후 다른 항목으로 바꿉니다. 여기서부터 모든 요소가 제거될 때까지 로직을 루프에서 실행합니다.

```js
function removeAllDayElements(calendarDaysElement) {
  let first = calendarDaysElement.firstElementChild;
 
  while (first) {
    first.remove();
    first = calendarDaysElement.firstElementChild;
  }
}
```

이제 우리는 월을 바꾸고 싶을 때 그 논리를 다시 사용할 수 있습니다. 구성 요소에 대한 정적 템플릿을 생성할 때의 첫 번째 단계를 호출합니다. 다음과 같은 요소를 추가했습니다.

```html
<div class="calendar-month-header-selectors">
  <span id="previous-month-selector"><</span>
  <span id="present-month-selector">Today</span>
  <span id="next-month-selector">></span>
</div>
```

이것은 몇 달 사이에 페이지를 넘기기 위한 조절 장치입니다. 변경하려면 현재 선택된 달을 저장해야 합니다. 그것이 무엇인지 추적하기 위해 변수를 만들고 그것의 초기 값을 현재 달로 설정해 봅시다.

```js
let selectedMonth = dayjs(new Date(INITIAL_YEAR, INITIAL_MONTH - 1, 1));
```

이제, 선택기가 작동하기 위해서는 자바스크립트가 조금 필요합니다. 좀 더 읽기 쉽게 하기 위해 initMonth Selectors라는 또 다른 방법을 만들 것이고 우리는 거기에 논리를 유지할 것이다. 이 방법은 이벤트 수신기를 선택기 요소에 추가합니다. 클릭 이벤트를 청취하고 선택한 달의 값을 새로 선택한 달의 이름으로 업데이트한 뒤 적절한 연도 및 월 값을 가진 캘린더 생성 방법을 실행할 예정이다.

```js
function initMonthSelectors() {
  document
  .getElementById("previous-month-selector")
  .addEventListener("click", function() {
    selectedMonth = dayjs(selectedMonth).subtract(1, "month");
    createCalendar(selectedMonth.format("YYYY"), selectedMonth.format("M"));
  });
 
  document
  .getElementById("present-month-selector")
  .addEventListener("click", function() {
    selectedMonth = dayjs(new Date(INITIAL_YEAR, INITIAL_MONTH - 1, 1));
    createCalendar(selectedMonth.format("YYYY"), selectedMonth.format("M"));
  });
 
  document
  .getElementById("next-month-selector")
  .addEventListener("click", function() {
    selectedMonth = dayjs(selectedMonth).add(1, "month");
    createCalendar(selectedMonth.format("YYYY"), selectedMonth.format("M"));
  });
}
```

다 됐다! 더 이상 어쩔 수 없다! 달력이 준비되었습니다. 그것도 좋지만, 현재 날짜를 표시해서 다른 날짜보다 돋보이게 하면 더 좋을 것 같아. 그렇게 어렵지 않을 거예요. 이미 선정된 달에는 없는 스타일링 데이니까, 그것과 비슷한 것으로 하자.

오늘로 설정된 변수를 만듭니다.

```js
const TODAY = dayjs().format("YYYY-MM-DD");
```

그런 다음 당월 외 날짜에 대해 클래스를 적용하는 `부록데이` 방법에서는 해당 요소가 오늘 날짜인지 확인하기 위해 다른 검사를 추가해야 합니다. 그렇다면 다음 요소에 클래스를 추가합니다.

```js
function appendDay(day, calendarDaysElement) {
  // ...
  if (day.date === TODAY) {
    dayElementClassList.add("calendar-day--today");
  }
}
```

이제 스타일링 할 수 있어!

```css
.calendar-day--today {
  padding-top: 4px;
}
 
.calendar-day--today > div {
  color: #fff;
  border-radius: 9999px;
  background-color: var(--grey-800);
}
```

Voil➡, 됐다! 최종 데모를 통해 모든 것이 조립되었는지 확인하십시오.