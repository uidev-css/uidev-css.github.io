---
title: "Svelte 다른 프레임워크와 차별화된 매력적인 경험은"
description: ""
coverImage: "/assets/img/2024-06-30-SvelteDifferentandEngagingExperienceUnlikeOthers_0.png"
date: 2024-06-30 18:48
ogImage: 
  url: /assets/img/2024-06-30-SvelteDifferentandEngagingExperienceUnlikeOthers_0.png
tag: Tech
originalTitle: "Svelte: Different and Engaging Experience Unlike Others"
link: "https://medium.com/trendyol-tech/svelte-different-and-engaging-experience-unlike-others-9fe641566104"
---


![이미지](/assets/img/2024-06-30-SvelteDifferentandEngagingExperienceUnlikeOthers_0.png)

# 소개

기술의 세계는 항상 혁신으로 넘쳐나지만, 웹 개발 분야에서 다양한 접근 방식과 해결책을 찾는 탐색은 결코 멈추지 않습니다. 이 여정에서 각 새로운 단계는 새로운 지평과 실용적인 해결책을 가져옵니다. 이 중 하나인 놀라운 발견은 바로 Svelte와의 만남입니다!

본문에서는 Svelte를 소개하고 제 개인적인 경험을 살펴볼 예정입니다.

<div class="content-ad"></div>

# 스벨트란 무엇인가요?

스벨트는 무료이자 오픈 소스인 프런트엔드 컴포넌트 프레임워크이자 언어입니다.

- HTML을 확장하여 자바스크립트 식을 마크업에 추가하고, 동작을 제어하고 입력에 반응하는 지시문, 조건, 반복 및 비동기 값을 사용하는 문법을 추가합니다.
- CSS를 확장하여 스타일이 서로 겹쳐지지 않도록 스코핑 메커니즘을 추가합니다.
- 자바스크립트를 확장하여 반응성을 언어의 기본 요소로 만듭니다.

스벨트는 JavaScript의 구문을 수정하지 않으면서도 그것을 해킹합니다. 더욱이, TypeScript와 같은 기존 도구와의 상호 작용에 방해가 되지 않습니다. 예를 들어, 보통 변수를 할당할 때, 실제로는 상태를 정의하고 있는 것입니다.

<div class="content-ad"></div>

# 어떤 상황에서 사용할 수 있을까요?

언제나 이 답변에 의지할 수 있다고 말해도 과언이 아닙니다. 이는 Svelte가 임베디드 기기에서도 성능 저하 없이 서비스를 제공할 수 있다는 점 때문입니다. 예를 들어, 브라질에서 사용되는 약 20만 대의 POS 장치가 Svelte 프레젠테이션에서 강조되며 언급될 정도입니다.

요약하자면, 리소스를 적게 사용하면서 고효율 애플리케이션을 만들고자 한다면, Svelte이 최상의 선택이 됩니다.

# 어디에 사용해야 할까요?

<div class="content-ad"></div>

## 코드를 덜 작성하기

더 적은 코드 라인을 작성하면 시간을 절약하고 버그를 줄이며 가독성을 높일 수 있습니다.

Svelte는 컴파일러 지향적 접근 방식 덕분에 대부분의 프레임워크에 있는 불필요한 코드를 필요로하지 않습니다. Svelte는 가독성에 희생함 없이 짧은 코드를 목표로 합니다.

![Svelte Image](/assets/img/2024-06-30-SvelteDifferentandEngagingExperienceUnlikeOthers_1.png)

<div class="content-ad"></div>

더 많은 예시와 다른 프레임워크를 비교하고 싶다면, 이 사이트를 추천해 드릴게요: [https://component-party.dev/](https://component-party.dev/)

## 가상 DOM이 없음

가상 DOM은 여러 JavaScript 프레임워크에서 사용되는 기술로, 실제 DOM을 흉내내는 메모리 구조를 만들고 이 구조를 변경합니다. 렌더링 프로세스 중에는 실제 DOM과 가상 DOM 간의 차이를 계산하고 실제 DOM을 업데이트합니다. 이 방법은 웹 애플리케이션의 성능을 향상시키는 데 목적을 두고 있습니다.

React와 같은 프레임워크에 가상 DOM이 유용한 이유는 상태가 업데이트될 때마다 전체 컴포넌트를 다시 렌더링하고 실제 DOM에 직접 반영하는 것은 좋지 않기 때문입니다.

<div class="content-ad"></div>

그러나 Svelte에서는 상태를 업데이트할 때 해당 상태에 의존하는 부분만 DOM에서 업데이트되기 때문에 이러한 상황이 적용되지 않습니다. 이 방법으로 가상 DOM이 필요하지 않고 더 효율적인 애플리케이션이 달성됩니다.

## 학습 곡선이 꽤 낮습니다

이미 HTML, CSS 및 JavaScript를 알고 있다면 Svelte는 꽤 직관적일 것입니다.

```js
<script>
  let name = "World";
</script>
<h1>Hello {name}!</h1>
<style>
h1 {
  color: red;
}
</style>
```

<div class="content-ad"></div>

위에 작성된 코드는 처음에는 HTML과 비슷해 보일 수 있지만, 실제로는 Svelte 코드입니다.

# 왜 그리고 어디에서 사용했나요?

트렌디올 광고팀은 풀스택 팀으로, 프론트엔드 프로젝트에는 React를 사용합니다. 그러나 React를 사용하여 높은 성능의 애플리케이션을 구축하는 것은 깊은 이해가 없는 경우 어려울 수 있습니다. 우리 팀은 풀스택이기 때문에 일부는 프론트엔드 개발을 선호하고, 다른 사람들은 백엔드 작업을 선호할 수 있습니다. 그럼에도 불구하고, 우리 모두가 모든 프로젝트에 기여합니다. 프론트엔드 개발에 익숙하지 않은 개발자들은 React의 가파른 학습 곡선으로 인해 매우 효율적인 코드를 작성하기 어려울 수 있습니다. 그래서 저희는 Svelte를 하나의 프로젝트에 사용해보기로 결정했습니다. Svelte는 학습 곡선이 낮고 더 빠른 애플리케이션을 만들 수 있는 잠재력을 갖고 있기 때문입니다.

저희가 Svelte에서 마주한 몇 가지 문제에 대해 이야기하고 싶습니다. Svelte에는 오류 경계(error boundary)가 없어서 어떤 컴포넌트에서든 처리되지 않은 오류가 전체 페이지를 다운시킬 수 있습니다. 관련 이슈는 여기에서 확인할 수 있습니다.

<div class="content-ad"></div>

Unit Tests를 작성하는 것은 React에서처럼 쉽지 않습니다. 때로는 일부 구성 요소에 대해 테스트 목적으로 새로운 컴포넌트를 만들어야 할 수도 있고, 이는 실제로 Svelte를 인라인으로 작성할 수 없기 때문입니다. 이 문제를 해결하는 몇 가지 플러그인을 본 적이 있지만, 제대로 작동하지 않았습니다. 다행히 Svelte Society의 레시피 덕분에 여기서 큰 문제가 발생하지는 않았습니다.

우리는 현재 브랜드 센터의 'Reklam Yönetimi' (광고 관리) 탭에서 Svelte를 사용하고 있습니다. 어떤 문제 없이 원활하게 작동합니다. Svelte에 기회를 주신 기술 리더 및 Trendyol의 문화에 감사드립니다. 그들의 도움으로 산업에서 Svelte를 한 단계 더 나아갔다고 생각합니다.

<img src="/assets/img/2024-06-30-SvelteDifferentandEngagingExperienceUnlikeOthers_2.png" />

# 팀 피드백

<div class="content-ad"></div>

우리는 Svelte에 관한 우리 팀원들의 경험과 피드백을 모았어요. 이 피드백은 긍정적 측면과 부정적 측면 두 가지 주요 항목 아래에서 수집했어요.

## 긍정적 측면

- 일부 팀원들은 네이티브 JavaScript를 작성하는 것처럼 코드를 작성하는 과정을 즐겼어요. 이는 자연스럽고 익숙한 경험을 만들어냈어요.
- 낮은 학습 곡선으로 인해 Svelte를 배우고 사용하기 쉬웠어요. 우리 팀원들은 언어의 기초를 빠르게 마스터하고 프로젝트에 빠르게 적응했어요.
- 코드 작성의 용이성과 코드베이스의 간결함으로 개발 과정이 가속화되었어요.
- 우리 팀은 코드를 효율적으로 작성하기 위해 추가 작업을 해야하지 않아서 좋았어요, 예를 들어 useMemo와 같은 것들을 다룰 필요가 없었어요.
- Svelte의 기본 기능들이 우리에게 추가 라이브러리가 필요하지 않고도 많은 작업을 수행할 수 있게 했어요.
- 슬롯 구조와 이벤트 디스패치의 용이성은 구성 요소간의 커뮤니케이션과 재사용성을 증가시켰어요.

## 부정적 측면

<div class="content-ad"></div>

- Svelte의 생태계와 커뮤니티는 아직 상대적으로 작습니다. 이는 특히 제3자 라이브러리 및 도구에 대한 통합과 지원 부족으로 이어질 수 있습니다.
- 큰 객체의 반응성에 문제가 있습니다. Store를 사용할 때 큰 객체를 사용하는 것은 도전적일 수 있습니다.
- WebStorm 인텔리센스의 부재가 개발 경험에 부정적인 영향을 미칩니다.

## 결론

전반적으로, 우리 팀은 Svelte와 함께 일할 수 있어 기쁘게 생각했습니다. 특히 성능, 단순함 및 사용 편의성에 대한 매우 긍정적인 피드백을 받았습니다. 그러나 생태계의 성숙도 및 일부 개발 경험적인 도전에 대한 우려가 표명되었습니다. Svelte는 특정 유형의 프로젝트에 강력한 옵션일 수 있지만, 다른 프레임워크에서 제공하는 광범위한 생태계와 커뮤니티 지원이 더 매력적일 수도 있습니다.

# 참고문헌

<div class="content-ad"></div>

- Gist - Svelte에 대한 진실
- 반응성에 대한 재고
- 컴포넌트 파티
- 레시피 - Svelte Society
- 소개 - SvelteKit

우리는 산업에서 가장 빛나는 두뇌들로 팀을 구축하고 있어요. 우리와 함께 일하고 싶으신가요? 우리가 오픈한 포지션에 대해 더 알아보려면 아래 페이지를 방문해 주세요.