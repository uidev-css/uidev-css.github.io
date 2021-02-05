---
layout: post
title: "웹 구성 요소를 만드는 모든 방법"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/09/color-pencils.png
tags: WEB COMPONENTS
---


수많은 라이브러리를 웹 구성 요소와 비교하는 깔끔한 페이지입니다. "A Bit on Web Components Libraries"를 게시하고 알게 된 것 중 하나는 웹 플랫폼 API가 그 주변에 도서관이 구축될 수 있도록 설계되었다는 것이다. 흥미롭죠?

이 페이지는 카운터 구성요소를 만듭니다. HTML 요소를 기본적으로 확장하여 1293바이트로 만든 다음 각 라이브러리에서 그 위에 항목을 추가합니다. Vue와 React와 같은 큰 라이브러리들은 분명히 훨씬 더 크다. 가장 큰 것 중 하나는 CanJS(230,634바이트)로, 작은 것을 목표로 하는 것이 아니라, "긴 미래를 내다보고 복잡한 애플리케이션을 구축하는 경험 많은 개발자들을 대상으로 한다"는 것이다. 만약 목표가 작다면, 스벨트는 거의 3,592 바이트로 끝나는 그것의 임무에 충실합니다. 그것은 아주 작은 lit-html 크기의 3분의 1과 uhtml 크기의 절반 크기입니다. 둘 다 더 나은 템플릿과 리렌더를 제공하는 아주 작은 추상화입니다.

직접 링크 →