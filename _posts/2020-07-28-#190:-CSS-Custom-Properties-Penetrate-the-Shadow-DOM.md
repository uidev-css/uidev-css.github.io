---
layout: post
title: "#190: 섀도 DOM에 침투하는 CSS 사용자 지정 속성"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/07/shadow-dom-thumb.png
tags: 
---


비디오 다운로드
(MVP 서포터즈만 오프라인에서 볼 수 있는 원본 고품질 녹화를 다운로드할 수 있습니다.)

섀도 DOM의 주요 포인트 중 하나는 캡슐화를 제공한다는 것입니다. 스타일 아웃도 없고, 스타일 인도 없습니다. 그러나 Shadow DOM을 통해 "통행"하는 방법이 있으며, 그 중 매우 멋지고 유용한 방법은 특정 요소/속성에 CSS 사용자 지정 속성을 사용하는 것이다.