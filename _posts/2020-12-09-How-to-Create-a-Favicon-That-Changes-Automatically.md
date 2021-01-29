---
layout: post
title: "자동으로 변경되는 Favicon을 만드는 방법
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/12/s_1F9BE3600BEDBA1B5BD220C345E3D4EABFE89DFCD1864FF02E136B57A6D68F19_1606518589522_ScreenShot2020-11-27at3.09.10PM.png
tags: FAVICON
---


요 전에이 Free Favicon Maker를 찾았습니다.
 파비콘 (이름 그대로)을 만드는 데 좋은 도구이지만 다른 파비콘 생성기와 달리이 도구를 사용하면 문자 나 그림 이모티콘으로 처음부터 새로 만들 수 있습니다.
 당연히 코드가 어떻게 작동하는지보기 위해 코드를보고 싶었고, 그렇게하는 동안 다른 방향으로 생각하게되었습니다.
 웹 사이트의 파비콘을 동적으로 변경할 수 있다는 내용을 읽었습니다.
 실제로 일부 웹 사이트는 사용자를위한 일종의 알림으로 사용합니다. 파비콘을 빨간색 점으로 변경하거나 페이지에서 어떤 일이 일어나고 있거나 변경되었음을 알리는 다른 표시기로 변경합니다.
 

영감을 얻기 위해 emojipedia.org를 통해 그림 이모티콘을 탐색하기 시작했는데 그 때가 떠 올랐습니다. 시계 그림 이모티콘 (🕛) 및 기타 관련 파비콘으로 시간을 표시해보세요.
 아이디어는 매 분마다 시간을 확인하고 현재 시간을 나타내는 해당 시계 이모티콘으로 파비콘을 설정하는 것입니다.
 

이 기사에서 정확히 수행 할 것이며 일반 JavaScript에서도 작동합니다.
 하지만 정적 사이트에 Gatsby를 자주 사용하므로 React에서 수행하는 방법도 보여줄 것입니다.
 거기에서 아이디어는 파비콘으로 무엇을하고 어떻게 할 것인지에 관계없이 사용할 수 있어야합니다.
 

다음은 그림 이모티콘을 매개 변수로 사용하고 이미지 (또는 파비콘!) 소스로 사용할 수있는 유효한 데이터 URL을 반환하는 함수입니다.
 

```js
// Thanks to https://formito.com/tools/favicon
const faviconHref = emoji =>
  `data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 width=%22256%22 height=%22256%22 viewBox=%220 0 100 100%22><text x=%2250%%22 y=%2250%%22 dominant-baseline=%22central%22 text-anchor=%22middle%22 font-size=%2280%22>${emoji}</text></svg>`
```

그리고 다음은`<head>`의 파비콘`<link>`를 타겟팅하고 해당 그림 이모티콘으로 변경하는 함수입니다.
 

```js
const changeFavicon = emoji => {
  // Ensure we have access to the document, i.e. we are in the browser.
  if (typeof window === 'undefined') return

  const link =
    window.document.querySelector("link[rel*='icon']") ||
    window.document.createElement("link")
  link.type = "image/svg+xml"
  link.rel = "shortcut icon"
  link.href = faviconHref(emoji)

  window.document.getElementsByTagName("head")[0].appendChild(link)
}
```

(존재하지 않는 경우 링크 생성에 대한 멋진 작은 트릭에 대해이 StackOverflow 답변에 외쳐주세요.)
 

자유롭게 시도해보세요!
 DevTools JavaScript 콘솔을 열고 위의 두 함수를 복사하여 붙여 넣은 다음`changeFavicon ( "💃")`을 호출합니다.
 이 웹 사이트에서 바로 할 수 있으며 파비콘이 멋진 춤추는 이모티콘으로 변경되는 것을 볼 수 있습니다.
 

시계 / 시간 프로젝트로 돌아가서 ... 올바른 시간을 보여주는 올바른 이모티콘 시계로 이모티콘을 표시하려면 현재 시간에서 결정해야합니다.
 예를 들어 10 시라면 🕙을 보여주고 싶습니다.
 4.30이면 🕟을 보여주고 싶습니다.
 매번 그림 이모티콘이있는 것은 아니므로 가장 좋은 그림 이모티콘을 보여 드리겠습니다.
 예를 들어, 9:45에서 10:14 사이에 10:00를 표시하는 시계를 표시하려고합니다.
 10:15부터 10:44까지 10.30을 표시하는 시계를 표시하려고합니다.
 

이 함수로 할 수 있습니다.
 

```js
const currentEmoji = () => {
  // Add 15 minutes and round down to closest half hour
  const time = new Date(Date.now() + 15 * 60 * 1000)

  const hours = time.getHours() % 12
  const minutes = time.getMinutes() < 30 ? 0 : 30

  return {
    "0.0": "🕛",
    "0.30": "🕧",
    "1.0": "🕐",
    "1.30": "🕜",
    "2.0": "🕑",
    "2.30": "🕝",
    "3.0": "🕒",
    "3.30": "🕞",
    "4.0": "🕓",
    "4.30": "🕟",
    "5.0": "🕔",
    "5.30": "🕠",
    "6.0": "🕕",
    "6.30": "🕡",
    "7.0": "🕖",
    "7.30": "🕢",
    "8.0": "🕗",
    "8.30": "🕣",
    "9.0": "🕘",
    "9.30": "🕤",
    "10.0": "🕙",
    "10.30": "🕥",
    "11.0": "🕚",
    "11.30": "🕦",
  }[`${hours}.${minutes}`]
}
```

이제 1 분마다`changeFavicon (currentEmoji ())`를 호출하면됩니다.
 일반 자바 스크립트로해야한다면 간단한`setInterval`이 트릭을 만들 것입니다.
 

```js
// One minute
const delay = 60 * 1000

// Change the favicon when the page gets loaded...
const emoji = currentEmoji()
changeFavicon(emoji)

// ... and update it every minute
setInterval(() => {
  const emoji = currentEmoji()
  changeFavicon(emoji)
}, delay)
```

### 반응 부분
 

내 블로그는 Gatsby에서 제공하므로 React 구성 요소 내에서이 코드를 사용하여 가능한 한 적게 변경하고 싶습니다.
 React의 선언적 특성과는 달리 본질적으로 필수적이며 매분 호출해야합니다.
 어떻게 할 수 있습니까?
 

Dan Abramov와 그의 놀라운 블로그 게시물을 입력하십시오.
 Dan은 복잡한 것을 명확하게 설명 할 수있는 훌륭한 작가이며, 특히 React Hooks에 대해 더 잘 이해하고 싶다면이 기사를 확인하는 것이 좋습니다.
 모든 것을 이해할 필요는 없습니다. 후크의 강점 중 하나는 내부 구현을 완전히 파악하지 않고도 사용할 수 있다는 것입니다.
 중요한 것은 그것을 사용하는 방법을 아는 것입니다.
 그 모습은 다음과 같습니다.
 

```js
import { useEffect } from "react"
import useInterval from "./useInterval"

const delay = 60 * 1000

const useTimeFavicon = () => {
  // Change the favicon when the component gets mounted...
  useEffect(() => {
    const emoji = currentEmoji()
    changeFavicon(emoji)
  }, [])

  // ... and update it every minute
  useInterval(() => {
    const emoji = currentEmoji()
    changeFavicon(emoji)
  }, delay)
}
```

마지막으로 루트 구성 요소에서`useTimeFavicon ()`을 호출하기 만하면됩니다.
 작동하는지보고 싶습니까?
 여기에 배포 된 CodePen 프로젝트가 있으며 여기에 프로젝트 코드 자체가 있습니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_1F9BE3600BEDBA1B5BD220C345E3D4EABFE89DFCD1864FF02E136B57A6D68F19_1606518589522_ScreenShot2020-11-27at3.09.10PM.png?resize=1212%2C562&ssl=1)

### 마무리
 verified_user

여기서 우리가했던 것은 우리가 원하는 결과를 얻기 위해 서로 다른 세 가지 소스에서 나온 세 가지 코드 조각을 결합하는 것이 었습니다.
 고대 로마인들은 Divide et Impera라고 말할 것입니다.
 (저는 이탈리아 사람이므로 라틴어를 조금 즐겨주세요!).
 그것은“분할하고 정복하라”는 뜻입니다.
 태스크를 단일 엔티티로 보면 약간 불안 할 수 있습니다. "내 React 웹 사이트에서 항상 최신 상태 인 현재 시간으로 파비콘을 표시하려면 어떻게해야합니까?"
 모든 세부 사항을 올바르게 파악하는 것은 간단하지 않습니다.
 

좋은 소식은 항상 모든 세부 사항을 동시에 다룰 필요는 없다는 것입니다. 문제를 하위 문제로 나누는 것이 훨씬 더 효과적이며, 이러한 문제가 이미 다른 사람에 의해 해결 된 경우에는 훨씬 더 효과적입니다.
 더 좋습니다!
 

웹 개발처럼 들리나요?
 현명하게 만한다면 다른 사람이 작성한 코드를 사용해도 문제가 없습니다.
 그들이 말했듯이, 바퀴를 재발 명 할 필요가 없으며 여기에서 얻은 것은 알림 표시, 시간 업데이트 또는 생각할 수있는 모든 웹 사이트에 대한 멋진 개선 사항입니다.
 