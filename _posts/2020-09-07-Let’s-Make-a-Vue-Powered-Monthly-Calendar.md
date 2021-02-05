---
layout: post
title: "뷰파워 월간 달력을 만듭시다."
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/08/vue-calendar.png
tags: VUE
---


여러분은 웹페이지에서 달력을 보고 그들이 어떻게 그런 짓을 했을까 생각해 본 적이 있나요? 이와 같은 경우에는 플러그인이나 내장된 Google 캘린더를 찾는 것이 당연할 수 있지만, 실제로 생각보다 쉽게 만들 수 있습니다. 특히 Vue의 구성 요소 중심 전력을 사용할 때는 더욱 그렇습니다.

코드 샌드박스에서 데모를 준비했습니다. 우리가 무엇을 목표로 하는지 알 수 있도록 말이죠. 하지만 항상 우리가 하고자 하는 바를 설명하는 것이 좋습니다.

- 현재 달의 요일을 표시하는 월 보기 그리드 작성
- 그리드가 항상 가득 차도록 이전 및 다음 달의 날짜 표시
- 현재 날짜 표시
- 현재 선택한 달의 이름 표시
- 이전 및 다음 달로 이동
- 사용자가 한 번의 클릭으로 현재 월로 돌아갈 수 있도록 허용

아, 그리고 우리는 이것을 초경량 유틸리티 라이브러리인 Day.js에서 달력 날짜를 가져오는 단일 페이지 애플리케이션으로 만들 것입니다.

### 1단계: 기본 마크업부터 시작

템플릿으로 바로 넘어가겠습니다. 만약 여러분이 뷰에 처음 오신다면, 사라의 소개 시리즈는 시작하기에 좋은 장소입니다. 이 게시물 전체에 걸쳐 Vue 2 문서에 연결할 것이라는 점도 주목할 필요가 있습니다. Vue 3은 현재 베타 버전이며 해당 문서는 변경될 수 있습니다.

먼저 일정관리에 대한 기본 템플리트 작성부터 시작하겠습니다. 다음과 같은 세 가지 계층으로 마크업을 개략적으로 설명할 수 있습니다.

- 일정관리 머리글의 섹션입니다. 현재 선택한 달의 구성요소와 월 간 페이지 작성을 담당하는 구성요소가 표시됩니다.
- 일정관리 그리드 헤더를 위한 섹션입니다. 월요일부터 시작하여 요일을 포함하는 목록을 포함하는 표 머리말입니다.
- 달력 그리드. 아시다시피, 현재 달의 매일은 그리드에서 정사각형으로 표시됩니다.

이것을 `CalendarMonth.vue`라는 파일에 기록하자. 이것이 우리의 주요 구성 요소가 될 것이다.

```html
<!-- CalendarMonth.vue -->
<template>
  <!-- Parent container for the calendar month -->
  <div class="calendar-month">
     
    <!-- The calendar header -->
    <div class="calendar-month-header"
      <!-- Month name -->
      <CalendarDateIndicator />
      <!-- Pagination -->
      <CalendarDateSelector />
    </div>

    <!-- Calendar grid header -->
    <CalendarWeekdays />

    <!-- Calendar grid -->
    <ol class="days-grid">
      <CalendarMonthDayItem />
    </ol>
  </div>
</template>
```

이제 몇 가지 마크업이 진행되었으므로 한 단계 더 나아가 필요한 구성 요소를 만들어 보겠습니다.

### 2단계: 헤더 구성 요소

헤더에는 다음 두 가지 구성 요소가 있습니다.

- 달력 날짜Indicator`는 현재 선택된 달을 나타냅니다.
- `Calendar Date Selector`는 월 간 페이지 작업을 담당합니다.

`일정관리 날짜`로 시작하겠습니다.표시기"입니다. 이 구성 요소는 현재 날짜를 올바르게 포맷하여 사용자에게 표시하는 Day.js 개체인 `selectedDate` 속성을 수락합니다.

```html
<!-- CalendarDateIndicator.vue -->
<template>
  <div class="calendar-date-indicator">{ selectedMonth }</div>
</template>

<script>
export default {
  props: {
    selectedDate: {
      type: Object,
      required: true
    }
  },

  computed: {
    selectedMonth() {
      return this.selectedDate.format("MMMM YYYY");
    }
  }
};
</script>
```

그건 쉬웠어요. 이제 몇 개월 사이를 이동할 수 있는 페이지 지정 구성 요소를 만들어 보겠습니다. 여기에는 이전, 현재 및 다음 달 선택을 담당하는 세 가지 요소가 포함됩니다. 요소를 클릭하면 적절한 메서드를 실행하는 이벤트 수신기를 추가합니다.

```html
<!-- CalendarDateSelector.vue -->
<template>
  <div class="calendar-date-selector">
    <span @click="selectPrevious">﹤</span>
    <span @click="selectCurrent">Today</span>
    <span @click="selectNext">﹥</span>
  </div>
</template>
```

그런 다음 스크립트 섹션에서 구성 요소가 수락할 두 가지 소품을 설정합니다.

- "현재 날짜"를 사용하면 "오늘" 버튼을 클릭하면 현재 달로 돌아갈 수 있습니다.
- `선택된 날짜`는 현재 선택된 달을 알려줍니다.

우리는 또한 Day.js의 `감산`과 `추가` 방법을 사용하여 현재 선택된 날짜를 기준으로 새로운 선택된 날짜를 계산하는 방법을 정의할 것입니다. 각 방법은 새로 선택한 달과 함께 상위 구성요소로 이벤트를 `$emit`합니다. 이렇게 하면 선택한 날짜의 값을 한 곳에 유지할 수 있습니다. 즉, `Calendar Month`가 됩니다.vue` 구성 요소 - 모든 하위 구성 요소(예: 헤더, 일정관리 그리드)에 전달합니다.

```js
// CalendarDateSelector.vue
<script>
import dayjs from "dayjs";

export default {
  name: "CalendarDateSelector",

  props: {
    currentDate: {
      type: String,
      required: true
    },

    selectedDate: {
      type: Object,
      required: true
    }
  },

  methods: {
    selectPrevious() {
      let newSelectedDate = dayjs(this.selectedDate).subtract(1, "month");
      this.$emit("dateSelected", newSelectedDate);
    },

    selectCurrent() {
      let newSelectedDate = dayjs(this.currentDate);
      this.$emit("dateSelected", newSelectedDate);
    },

    selectNext() {
      let newSelectedDate = dayjs(this.selectedDate).add(1, "month");
      this.$emit("dateSelected", newSelectedDate);
    }
  }
};
</script>
```

이제 `달력의 달`로 돌아가 봅시다.vue의 컴포넌트를 사용하고 새로 생성된 컴포넌트를 사용합니다.

이러한 구성 요소를 사용하려면 먼저 구성 요소를 가져오고 등록해야 하며, 이러한 구성 요소에 대한 소품으로 전달되는 가치도 생성해야 합니다.

- 오늘을 올바르게 포맷하고 오늘 페이지 지정 단추의 값으로 사용합니다.
- `선택된 날짜`는 현재 선택된 날짜입니다(기본적으로 오늘 날짜로 설정됨).

구성 요소를 렌더링하기 전에 마지막으로 해야 할 일은 `선택한 날짜`의 값을 변경하는 방법을 만드는 것입니다. 이 메서드는 페이지 지정 구성 요소에서 이벤트가 수신되면 실행됩니다.

```js
// CalendarMonth.vue
<script>
import dayjs from "dayjs";
import CalendarDateIndicator from "./CalendarDateIndicator";
import CalendarDateSelector from "./CalendarDateSelector";

export default {
  components: {
    CalendarDateIndicator,
    CalendarDateSelector
  },

  data() {
    return {
      selectedDate: dayjs(),
      today: dayjs().format("YYYY-MM-DD")
    };
  },

  methods: {
    selectDate(newSelectedDate) {
      this.selectedDate = newSelectedDate;
    }
  }
};
</script>
```

이제 달력 머리글을 렌더링하는 데 필요한 모든 것을 얻었습니다.

```html
<!-- CalendarMonth.vue -->
<template>
  <div class="calendar-month">
    <div class="calendar-month-header">
      <CalendarDateIndicator
        :selected-date="selectedDate"
        class="calendar-month-header-selected-month"
      />
      <CalendarDateSelector
        :current-date="today"
        :selected-date="selectedDate"
        @dateSelected="selectDate"
      />
    </div>
  </div>
</template>
```

여기까지 와서 우리가 지금까지 뭘 가졌는지 보기 좋은 장소야. 달력 헤더가 원하는 모든 작업을 하고 있으므로 앞으로 이동하여 달력 그리드에 대한 구성 요소를 생성해 보겠습니다.

### 3단계: 캘린더 그리드 구성 요소

여기에도 두 가지 구성 요소가 있습니다.

- 달력 위크데이는 평일의 이름을 보여준다.
- 달력월요일 항목은 달력에서 단 하루를 나타냅니다.

CalendarWeekdays 구성 요소에는 평일 라벨을 통해 반복(v-for 지시어 사용)하는 목록이 포함되어 있습니다. 스크립트 부분에서는 평일을 정의하고 컴퓨팅 속성을 생성하여 템플릿에서 사용할 수 있도록 하고 결과를 캐슁하여 향후에 다시 계산할 필요가 없도록 해야 합니다.

```js
// CalendarWeekdays.vue
<template>
  <ol class="day-of-week">
    <li
      v-for="weekday in weekdays"
      :key="weekday"
    >
      { weekday }
    </li>
  </ol>
</template>
 
<script>
const WEEKDAYS = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

export default {
  name: 'CalendarWeekdays',

  computed: {
    weekdays() {
      return WEEKDAYS
    }
  }
}
</script>
```

다음은 `월요일 항목`입니다. 오브젝트인 `day` 속성을 수신하는 목록 항목이며, 현재 날짜임을 나타내기 위해 목록 항목을 스타일링할 수 있는 부울 소품인 `isToday`입니다. 또한 수신한 일 객체를 원하는 날짜 형식(`D` 또는 월의 숫자 일)으로 포맷하는 `계산된` 속성도 있습니다.

```js
// CalendarMonthDayItem.vue
<template>
  <li
    class="calendar-day"
    :class="{
      'calendar-day--not-current': !isCurrentMonth,
      'calendar-day--today': isToday
    }"
  >
    <span>{ label }</span>
  </li>
</template>
 
<script>
import dayjs from "dayjs";

export default {
  name: "CalendarMonthDayItem",

  props: {
    day: {
      type: Object,
      required: true
    },

    isCurrentMonth: {
      type: Boolean,
      default: false
    },

    isToday: {
      type: Boolean,
      default: false
    }
  },

  computed: {
    label() {
      return dayjs(this.day.date).format("D");
    }
  }
};
</script>
```

자, 이제 이 두 가지 구성 요소를 `월간` 구성 요소에 추가할 수 있는 방법을 알아보겠습니다.

우리는 우선 그것들을 수입하고 등록해야 합니다. 우리는 또한 우리의 시대를 대표하는 사물들의 배열을 반환할 `컴퓨팅`된 속성을 만들어야 한다. 일별에는 날짜 및 isCurrentMonth 속성이 포함됩니다.

```js
// CalendarMonth.vue
<script>
import dayjs from "dayjs";
import CalendarMonthDayItem from "./CalendarMonthDayItem";
import CalendarWeekdays from "./CalendarWeekdays";
 
export default {
  name: "CalendarMonth",

  components: {
    // ...
    CalendarMonthDayItem,
    CalendarWeekdays
  },

  computed: {
    days() {
      return [
        { date: "2020-06-29", isCurrentMonth: false },
        { date: "2020-06-30", isCurrentMonth: false },
        { date: "2020-07-01", isCurrentMonth: true },
        { date: "2020-07-02", isCurrentMonth: true },
        // ...
        { date: "2020-07-31", isCurrentMonth: true },
        { date: "2020-08-01", isCurrentMonth: false },
        { date: "2020-08-02", isCurrentMonth: false }
      ];
    }
  }
};
</script>
```

그러면 템플릿에서 구성 요소를 렌더링할 수 있습니다. 다시, 우리는 필요한 일 수 요소를 렌더링하기 위해 `v-for` 지시문을 사용한다.

```html
<!-- CalendarMonth.vue -->
<template>
  <div class="calendar-month">
    <div class="calendar-month-header">
      // ...
    </div>

    <CalendarWeekdays/>

    <ol class="days-grid">
      <CalendarMonthDayItem
        v-for="day in days"
        :key="day.date"
        :day="day"
        :is-today="day.date === today"
      />
    </ol>
  </div>
</template>
```

좋아, 이제 상황이 좋아지기 시작했어. 여기가 어딘지 한번 보세요. 보기 좋지만, 템플릿에는 현재 정적 데이터만 포함되어 있습니다. 월은 7월로 하드코딩되고 일수도 하드코딩된다. 우리는 특정 달에 어떤 날짜가 표시되어야 하는지 계산하여 그것을 변경할 것입니다. 암호로 들어가자!

### 4단계: 현재 월 달력 설정

특정 달에 보여야 할 날짜를 어떻게 계산할 수 있는지 생각해 봅시다. 바로 거기서 데이.js가 실제로 활동하게 됩니다. 실제 달력 데이터를 사용하여 특정 달의 정확한 요일에 날짜를 적절하게 배치하는 데 필요한 모든 데이터를 제공합니다. 이를 통해 데이터를 표시하는 데 필요한 모든 날짜 형식 지정 옵션부터 한 달 시작 날짜까지 원하는 항목을 가져오고 설정할 수 있습니다.

다음 작업을 수행합니다.

- 현재 월 가져오기
- 요일(주)을 배치할 위치 계산
- 이전 및 다음 달의 날짜를 표시하기 위한 날짜 계산
- 모든 요일을 단일 배열로 표시

우리는 이미 `Calendar Month` 구성 요소에서 Day.js를 수입했습니다. 우리는 또한 도움을 받기 위해 데이.js 플러그인에 의존할 것이다. WeekDay는 일주일의 첫날을 설정하는 데 도움이 됩니다. 어떤 사람들은 일주일의 첫날로 일요일을 선호한다. 다른 사람들은 월요일을 선호한다. 음, 경우에 따라서는 금요일부터 시작하는 게 말이 되는 경우도 있어요. 월요일부터 시작할 거예요.

WeekOfYear 플러그인은 해당 연도의 모든 주 중 현재 주에 대한 숫자 값을 반환합니다. 1년에 52주가 있기 때문에 1월 1일부터 시작하는 주가 1년 중 첫 주라고 할 수 있습니다.

여기 `달력의 달`에 저희가 넣은 것이 있습니다.이 모든 것을 사용할 수 있는 vue:

```js
// CalendarMonth.vue
<script>
import dayjs from "dayjs";
import weekday from "dayjs/plugin/weekday";
import weekOfYear from "dayjs/plugin/weekOfYear";
// ...
 
dayjs.extend(weekday);
dayjs.extend(weekOfYear);
// ...
```

그것은 꽤 간단했지만 이제 진정한 재미는 달력 그리드를 가지고 놀기 시작할 것이다. 그것을 바로잡기 위해 우리가 정말로 해야 할 일이 무엇인지 잠시 생각해 봅시다.

먼저 날짜 번호가 올바른 주중 열에 포함되기를 원합니다. 예를 들어, 2020년 7월 1일은 수요일이다. 여기서부터 날짜 번호가 매겨져야 합니다.

월 1일이 수요일이면 첫 주 월요일과 화요일에는 빈 그리드 항목이 있는 것입니다. 그 달의 마지막 날은 7월 31일로 금요일이다. 이는 그리드의 마지막 주에 토요일과 일요일이 비어 있다는 것을 의미한다. 우리는 달력 그리드가 항상 가득 차도록 각각 이전 달과 다음 달의 후행 날짜와 선행 날짜를 채우고 싶습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/08/hWx08SWA.png?resize=1024%2C682&ssl=1)

그리드에 현재 달의 요일을 추가하려면 현재 월에 며칠이 있는지 알아야 합니다. 우리는 Day.js에서 제공하는 daysInMonth 방법을 통해 그것을 얻을 수 있습니다. 이를 위해 `컴퓨팅` 속성을 생성해 보겠습니다.

```js
// CalendarMonth.vue
computed: {
  // ...
  numberOfDaysInMonth() {
      return dayjs(this.selectedDate).daysInMonth();
  }
}
```

이 사실을 알게 되면 현재 달의 일 수와 같은 길이의 빈 배열을 만듭니다. 그런 다음 해당 배열을 매핑하고 각 배열에 대한 일별 객체를 만듭니다. 생성한 개체는 임의 구조를 가지고 있으므로 필요한 경우 다른 속성을 추가할 수 있습니다.

그러나 이 예에서는 특정 날짜가 현재 날짜인지 확인하는 데 사용할 `날짜` 속성이 필요합니다. 또한 날짜가 현재 월인지 아닌지를 확인하는 `isCurrent Month` 값도 반환됩니다. 만약 그것이 현재 월의 범위를 벗어난다면, 우리는 사람들이 그들이 현재 월의 범위를 벗어난다는 것을 알 수 있도록 그것들을 스타일링할 것이다.

```js
// CalendarMonth.vue
computed: {
  // ...
  currentMonthDays() {
    return [...Array(this.numberOfDaysInMonth)].map((day, index) => {
      return {
        date: dayjs(`${this.year}-${this.month}-${index + 1}`).format("YYYY-MM-DD")
        isCurrentMonth: true
      };
    });
  },
}
```

현재 월에 표시할 이전 달의 날짜를 가져오려면 선택한 달의 첫날 평일이 얼마인지 확인해야 합니다. WeekDay 플러그인을 Day.js에 사용할 수 있습니다. 이를 위한 도우미 방법을 만들어 보겠습니다.

```js
// CalendarMonth.vue
methods: {
  // ...
  getWeekday(date) {
    return dayjs(date).weekday();
  },
}
```

그럼 그 기준으로 전월의 마지막 월요일이 어느 날인지 확인이 필요합니다. 현재 월 뷰에서 전월에서 며칠까지 볼 수 있어야 하는지 알 수 있는 해당 값이 필요합니다. 우리는 이번 달 초하루에서 평일 값을 빼면 그것을 얻을 수 있습니다. 예를 들어, 월의 첫날이 수요일이면 3일을 빼야 전달의 마지막 월요일을 얻을 수 있습니다. 이 값을 사용하면 이전 달의 마지막 월요일부터 해당 월 말까지 일별 개체 배열을 만들 수 있습니다.

```js
// CalendarMonth.vue
computed: {
  // ...
  previousMonthDays() {
    const firstDayOfTheMonthWeekday = this.getWeekday(this.currentMonthDays[0].date);
    const previousMonth = dayjs(`${this.year}-${this.month}-01`).subtract(1, "month");

    // Cover first day of the month being sunday (firstDayOfTheMonthWeekday === 0)
    const visibleNumberOfDaysFromPreviousMonth = firstDayOfTheMonthWeekday ? firstDayOfTheMonthWeekday - 1 : 6;

    const previousMonthLastMondayDayOfMonth = dayjs(this.currentMonthDays[0].date).subtract(visibleNumberOfDaysFromPreviousMonth, "day").date();

    return [...Array(visibleNumberOfDaysFromPreviousMonth)].map((day, index) = {
      return {
        date: dayjs(`${previousMonth.year()}-${previousMonth.month() + 1}-${previousMonthLastMondayDayOfMonth + index}`).format("YYYY-MM-DD"),
        isCurrentMonth: false
      };
    });
  }
}
```

이제 역순으로 다음 달부터 현재 달의 그리드를 채우려면 며칠이 필요한지 계산해 봅시다. 다행히 방금 만든 헬퍼를 전월 계산에 사용할 수 있습니다. 차이점은 그 평일 숫자 값을 7에서 빼서 다음 달부터 몇 일까지 볼 수 있어야 하는지 계산한다는 것입니다.

예를 들어, 월의 마지막 날이 토요일인 경우, 다음 달(일요일)부터 필요한 날짜 배열을 작성하려면 7일에서 하루를 빼야 합니다.

```js
// CalendarMonth.vue
computed: {
  // ...
  nextMonthDays() {
    const lastDayOfTheMonthWeekday = this.getWeekday(`${this.year}-${this.month}-${this.currentMonthDays.length}`);
    const nextMonth = dayjs(`${this.year}-${this.month}-01`).add(1, "month");
    const visibleNumberOfDaysFromNextMonth = lastDayOfTheMonthWeekday ? 7 - lastDayOfTheMonthWeekday : lastDayOfTheMonthWeekday;

    return [...Array(visibleNumberOfDaysFromNextMonth)].map((day, index) => {
      return {
        date: dayjs(`${nextMonth.year()}-${nextMonth.month() + 1}-${index + 1}`).format("YYYY-MM-DD"),
        isCurrentMonth: false
      };
    });
  }
}
```

네, 필요한 모든 요일을 생성하는 방법을 알고 있으므로, 하루 종일 이전 달과 다음 달의 채우기 날짜를 포함하여 현재 월에 표시할 모든 요일의 단일 배열로 병합해 보겠습니다.

```js
// CalendarMonth.vue
computed: {
  // ...
  days() {
    return [
      ...this.previousMonthDays,
      ...this.currentMonthDays,
      ...this.nextMonthDays
    ];
  },
}
```

Voil➡, 됐다! 최종 데모를 통해 모든 것이 조립되었는지 확인하십시오.