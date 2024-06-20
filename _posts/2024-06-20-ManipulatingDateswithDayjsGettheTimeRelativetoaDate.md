---
title: "날짜 조작하기 Dayjs로 날짜에 상대적인 시간 가져오기"
description: ""
coverImage: "/assets/img/2024-06-20-ManipulatingDateswithDayjsGettheTimeRelativetoaDate_0.png"
date: 2024-06-20 14:06
ogImage: 
  url: /assets/img/2024-06-20-ManipulatingDateswithDayjsGettheTimeRelativetoaDate_0.png
tag: Tech
originalTitle: "Manipulating Dates with Day.js — Get the Time Relative to a Date"
link: "https://medium.com/javascript-in-plain-english/manipulating-dates-with-day-js-get-the-time-to-a-date-efcb149945ab"
---


```markdown
![Day.js로 날짜 조작하기](/assets/img/2024-06-20-ManipulatingDateswithDayjsGettheTimeRelativetoaDate_0.png)

Day.js는 앱에서 날짜를 조작할 수 있게 해주는 JavaScript 라이브러리입니다.

이 글에서는 JavaScript 앱에서 Day.js를 사용하여 날짜를 조작하는 방법을 살펴보겠습니다.

# 현재까지의 시간 구하기
```

<div class="content-ad"></div>

상대시간 플러그인과 함께 사용할 수 있는 toNow 메서드를 사용하여 현재까지의 상대 시간 문자열을 얻을 수 있습니다.

예를 들어 다음과 같이 작성할 수 있습니다:

```js
const dayjs = require("dayjs");
const relativeTime = require("dayjs/plugin/relativeTime");
dayjs.extend(relativeTime);
const result = dayjs("1999-01-01").toNow();
console.log(result);
```

1999년 1월 1일부터 현재까지 얼마나 시간이 지났는지 확인할 수 있습니다.

<div class="content-ad"></div>

따라서, 2021년에 '23년 후'라는 결과가 나옵니다.

또한, toNow에 true를 전달하여 접미사를 제거할 수 있습니다.

그리고 결과로 `23년`을 얻을 수 있습니다.

# 주어진 시간까지 남은 시간 가져오기

<div class="content-ad"></div>

"relativeTime" 플러그인을 사용할 수 있는 "to" 메서드로 현재로부터 상대적인 시간의 문자열을 얻을 수 있습니다.

예를 들어, 다음과 같이 작성할 수 있습니다:

```js
const dayjs = require("dayjs");
const relativeTime = require("dayjs/plugin/relativeTime");
dayjs.extend(relativeTime);
const a = dayjs("2020-01-01");
const result = dayjs("1999-01-01").to(a);
console.log(result);
```

1999년 1월 1일부터 2020년 1월 1일까지 얼마나 오랜 시간이 걸렸는지 확인할 수 있습니다.

<div class="content-ad"></div>

그러므로 결과는 `in 21 years‘입니다.

또한 두 번째 인수로 true를 전달하여 접미사를 제거할 수 있습니다.

결과로는 `21 years`를 얻을 수 있습니다.

# 결론

<div class="content-ad"></div>

Day.js는 우리 앱에서 날짜를 조작할 수 있게 해주는 JavaScript 라이브러리입니다.

# 쉽게 이해하기 🚀

In Plain English 커뮤니티에 참여해 주셔서 감사합니다! 떠나시기 전에:

- 작성자를 클랩하고 팔로우하세요 ️👏️️
- 팔로우하기: X | LinkedIn | YouTube | Discord | Newsletter
- 다른 플랫폼에서도 만나보세요: CoFeed | Differ
- PlainEnglish.io에서 더 많은 콘텐츠를 만나보세요.