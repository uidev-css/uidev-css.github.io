---
layout: post
title: "선호 감소 데이터로 웹 사이트 만들기
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/12/polypane-prefers-reduced-data.png
tags: MEDIA QUERIES,PREFERS-REDUCED-DATA
---


스포일러 경고 : 아직 지원되지 않습니다.
 그러나 `prefers-color-scheme`및 `prefers-reduced-motion`과 같은 다른 최근의 친숙한 사용자 선호 기능을 포함하는 Media Queries Level 5 사양에 정의되어 있습니다.
 

Polypane 블로그는 특히 우리가 아직 야생에서 보지 못한 것에 대해`prefers-reduced-data`에 대해 믿을 수 없을만큼 깊이있게 설명합니다.
 이것이 바로 Polypane 팀을 주제에 대한 이상적인 목소리로 만드는 이유입니다.
 이 제품은 Chromium 플래그 뒤에있는 기능을 에뮬레이션 할 수있는 브라우저입니다.
 

동시에이 사양은 현재 상태에서이 기능과 관련된 두 가지 중요한 잠재적 문제를 언급하고 있습니다.
 

- 제한된 데이터로 저소득을 향한 편향과 함께 원치 않는 지문 인식 소스 일 수 있습니다.
 
- 이 기능은 초기 초안이며, CSS-WG는 생산시 제공 할 준비가되어 있다고 생각하지 않습니다.
 

그러나 그것이 우리가 그것에 대해 알기 시작할 수 없다는 것을 말하는 것은 아닙니다.
 작동 방식은 다음과 같습니다.
 

```css
@media (prefers-reduced-data: reduce) {
  /* Stuff for reduced data preferences */
}

@media (prefers-reduced-data: no-preference) {
  /* Stuff for no data preferences */
}
```

이 게시물에서 감사하게 생각하는 것은 그것이 나열한 가능한 사용 사례가 많다는 것입니다.
 요약하겠습니다.
 

- 조건부로 글꼴을로드합니다.
 에서와 같이`@ font-face` 선언을 한 다음 본문에서 글꼴을 호출합니다.`no-preference` 사용자가 사용자 정의 글꼴을 가져 오려면 한 번,`reduced` 사용자가 더 가벼운 스택을 가져 오려면 다시 한 번 호출합니다.
 
- 배경 이미지.
 전체 너비 히어로 구성 요소의 배경으로 거대한 스플래시 이미지를 사용한 적이 있습니까?
 아마도 그것은 `선호가없는`사람들에게만 제공 될 수있는 반면 `감소 된`사람들은 더 작은 변형을 얻거나 전혀 이미지가없는 사람들에게 제공 될 수 있습니다.
 
- HTML의 더 작은 이미지.
 `<source>`요소에`media` 속성이 있다는 것을 기억하기 때문에 이것은 영리합니다.
 따라서`<picture>`로 작업 할 때 브라우저에 특정 이미지를 사용하도록 지시 할 수 있습니다.`<source srcset = "small.jpg"media = "(prefers-reduced-data : reduce)"/>`.
 
- 조건부로 동영상을 미리로드하고 자동 재생합니다.
 HTML에서이 기능으로 작업 할 수있는 것처럼`window.matchMedia ( `(prefers-reduced-data : no-preference)`). matches`를 사용하여`autoplay`를 설정하고 JavaScript에서도 사용할 수 있습니다.
 데이터 환경 설정을 기반으로 동영상의 속성을 `사전로드`합니다.
 
- 무한 스크롤을 버리십시오.
 저는 일반적으로이 패턴을 처음부터 버리고 싶지만, 데이터 축소를 선호하는 사용자가 페이지 끝에 도달하는 것만으로 더 많은 콘텐츠 (따라서 더 많은 데이터)를 강제로 공급하지 않도록 확실히 비활성화 할 수 있습니다.
 

물론 이것은 최종 아이디어 목록이 아닙니다!
 우리는 적시에 적시에 적임자에게 적법한 자산을 제공하는 것에 대해 항상 이야기하며이 미디어 기능은 특정 상황에서 그렇게하는 데 도움이되는 훌륭한 도구입니다.
 다음 사항도 고려하십시오.
 

- 다운로드 한 자산 (예 : PDF)의 저해상도 버전 제공
 
- 경험이 많은 특정 사이트 또는 페이지에 연결
 
- 환경 설정에 따라 전체 스크립트, 스타일 시트 또는 라이브러리를 조건부로로드
 
- 아마 수백만 가지의 다른 영리한 것들 일 것입니다 ...
 

그리고이 조언은 황금입니다.
 

> `prefers-reduced-motion`과 마찬가지로`prefers-reduced-data : reduce` 옵션을 기본 옵션으로 생각하는 것이 좋습니다. 사람들은 간결하고 빠른 경험을 얻을 수 있으며`no-preference`를 표시 할 때만
 그들에게 더 많은 데이터를 보냅니다.
 이렇게하면 미디어 쿼리를 지원하지 않는 이전 브라우저가 기본적으로 간결한 환경을 제공합니다.
 

네.
 "모바일 우선"반응 형 디자인과 같은 종류의 아이디어 : 축소 된 데이터를위한 디자인에서 시작하여 확장 할 때 개선합니다.
 

직접 링크 →
 