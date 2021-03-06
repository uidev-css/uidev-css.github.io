---
layout: post
title: "최근에 즐겨찾기에 추가하고 읽은 일부 성능 블로그 게시물"
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2019/12/css-tricks-logo-gradient-outline.png"
tags: PERFORMANCE
---


- Back/Forward 캐시—저는 항상 브라우저가 뒤로/앞으로 버튼을 사용하여 멋진 작업을 수행한다고 생각했고, 저희 개발자들은 거의 제어하지 못했습니다. Philip Walton은 우리에게 "무엇 때문에 페이지가 캐시 적중률을 극대화하기 위해 bfcache에 적합하고 적합하지 않다"는 것을 이해하는 것이 중요하다고 말합니다. 예를 들어, 언로드 이벤트를 사용할 경우 페이지는 즉시 캐시에서 제외됩니다.
- 등대 퍼레이드를 이용한 대형 사진 성능 분석 - 등대는 사이트의 한 페이지만 테스트합니다. 등대 퍼레이드는 사이트의 모든 URL을 테스트하고 결과를 집계합니다.
- 새로운 성능 기능으로 빠른 속도를 넘어, Jake Archibald는 CSS `콘텐츠-가시성` 속성(및 기타 몇 가지 사항)과 이것이 어떻게 놀라운 성능 향상을 가져올 수 있는지(브라우저에 무언가를 렌더링하지 않아도 된다고 말하는데 사용)을 합니다. 지금 당장 콘텐츠 가시성은 스크롤바(scroll bar)의 이상성과 접근성 문제 때문에 나를 불안하게 한다. 얼핏 보기에는 혼란스러웠고, 팀 캐들렉은 예약이 되어 있었다.
- 이미지 디코드
- CSS-in-JS 성능을 175배 향상하는 방법 — 리더는 CSS를 발송하는 것입니다. 여전히 작성자와 같이 CSS-in-JS를 사용할 수 있으며 빌드 프로세스에서 CSS를 생성하도록 할 수 있습니다. 그들은 그것을 리나리아처럼 "제로런타임"이라고 부른다.
- 성능 테스트 — Kelly Sutton: "성능 저하를 방지하기 위한 최선의 방법은 코드에 대한 정성적 평가를 사용하는 것입니다." 연주는 정말 다루기 힘든 야수이기 때문에, 오직 프로덕션에서만 어떤 일이 일어나는지 진정으로 알게 될 것입니다.
- Front-End Performance Checklist 2021 — 올해 성과에 대해 진지하게 생각하신다면 Vitaly의 가이드에 대해 알아보는 것이 좋을 것입니다.
- 우리는 무엇이 웹을 느리게 만드는지 알아보기 위해 백만 개의 웹 페이지를 제공했습니다. HTTP/2는 좋은 성능을 나타내는 큰 지표입니다.