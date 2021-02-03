---
layout: post
title: "방탄 플래그 구성 요소
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2021/01/flag-header.svg
tags: GRID
---


Jay Freestone의 CSS 그리드를 영리하게 사용하여 유연하지 않고 탄력적이지 않은 매직 넘버없이 미디어 개체 디자인 패턴 (이미지가 제목 중앙에 위치)의 특정 변형을 수행합니다.
 

비결은 제목 위와 아래에 "추가"행을 사용하는 것입니다.
 

![image](https://res.cloudinary.com/css-tricks/image/upload/f_auto,q_auto/v1611934765/flag-large-signifier-postLg_thetnw.avif)

이미지는 첫 번째 열의 처음 세 행으로 이동하고 콘텐츠는 명명 된 격자 영역을 사용하여 두 번째 열의 마지막 세 행으로 이동합니다.
 

```css
grid-template-areas:
  'signifier .'
  'signifier content'
  'signifier content'
  '.         content';
```

완전히 탄력적으로 만드는 데 필요한 약간의 속임수에 대해서는 Jay의 게시물을 읽어보십시오.
 

저는 이와 같은 CSS 그리드 뒤의 멘탈 모델에 초점을 맞춘 포스트를 좋아합니다.
 이 디자인에 가장 적합하도록 정렬 유형에 관계없이 셀의 임의의 직사각형 조합에 항목을 배치 할 수 있다는 사실을 알고있는이 디자인을 임의의 열과 행으로 분할하려면 어떻게해야합니까?
 

직접 링크 →
 