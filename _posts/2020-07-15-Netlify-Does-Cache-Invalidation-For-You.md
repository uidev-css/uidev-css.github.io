---
layout: post
title: "Netlifine 캐시 무효화"
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2018/09/kool-aid-man.jpg"
tags: 
---


이것은 내가 가장 좋아하는 Netliify 기능 중 하나이다. 사이트에서 작업하는 경우 CSS, JavaScript 또는 이미지 파일과 같은 자산으로 변경된다고 가정해 보겠습니다. 우리 일을 하는 것처럼 말이야 Netlifify에서는 배포, 브라우저 및 캐시에서 이러한 작업이 어떻게 수행될지에 대해 생각할 필요가 없습니다. Netlifify는 당신을 위해 그것을 처리한다.

Netliify는 Netliify의 "로켓 주스"의 일부인 이 인스턴트 캐시 무효화를 호출합니다.

Netlifify에서 작업하지 않는 모든 사이트에서 생각해봐야 합니다. 바로 이 웹 사이트 소스를 보면 다음과 같은 스타일시트에 대한 링크가 표시됩니다.

```html
<link href="https://css-tricks.com/wp-content/themes/CSS-Tricks-17/style.css?cache_bust=1594590986788" rel="stylesheet">
```

스타일시트 URL 끝에 있는 `?cache_cash=`가 보이시죠? 날짜() 호출을 기준으로 URL에 수동으로 입력하는 횡설수설한 문자일 뿐이어서 파일을 변경하면 CDN과 사용자 자신의 브라우저 캐시가 모두 깨지고 새 파일이 만들어집니다. 그렇게 하지 않으면 캐시가 모두 만료되거나 사용자가 수동으로 제거할 때까지 제가 푸시한 변경 사항이 표시되지 않습니다. 이는 잘못된 것입니다. 버그를 고치고 있을지도 몰라! 또는 새 기능을 릴리스합니다! 이는 CSS가 공격적으로 캐시되지 않는 HTML과 함께 사용될 수 있고 HTML과 예상 CSS의 불일치로 이어질 수 있기 때문에 더욱 나쁘다.

캐시 버스팅 문자열을 자동화하는 것이 귀찮아서 직접 변경하는 사이트에서 작업합니다. 보통은 자동화하지만요. 저는 최근에 제가 손으로 직접 작성한 Gulp 파일을 공유했고, 그 중 일부는 캐시 버스팅을 다루고 있습니다. 그것은 쓰기, 유지 관리, 개발 중에 사용하는 작업이다. 심지어 그 게시물에 달린 댓글도 읽을 수 있고, 내가 하는 것과는 다른 일을 하는 다른 사람들의 전략도 볼 수 있습니다. 본문을 캐시 버싱하는 동안 오류가 발생했습니다.

Netliify에 없습니다.

Netlifify는 자산을 변경하고 이를 강화하면 해당 자산이 변경되었음을 알고 모든 캐시 버스팅을 수행할 수 있습니다. 스타일시트를 다음과 같이 연결할 수 있습니다.

```html
<link href="dont-even-worry-about-it.css" rel="stylesheet" />
```