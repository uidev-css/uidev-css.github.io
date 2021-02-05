---
layout: post
title: "Cloudflare 근로자를 통한 전혀 다른 사이트의 워드프레스 기반 랜딩 페이지"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/07/codepen-blog-editor.png
tags: CLOUD FUNCTIONS,CLOUDFLARE,FETCH
---


한 사이트에 일부 콘텐츠가 있는데 다른 사이트에 해당 콘텐츠를 표시하려면 어떻게 합니까? 우리는 브라우저에서 이것을 할 수 있습니다. 우리는 그것을 `집어내서` 페이지 위에 띄울 수 있다.

아약스 맞죠? 이제 성능, 속도 또는 복원력에 적합하지 않은 클라이언트측 렌더링 사이트 영역에 도달했습니다.

해당 내용을 가져와 서버측 기본 페이지에 연결할 수 있다면 어떨까요? 하지만 서버측에서는 적절한 단어가 아닙니다. 글로벌 CDN 수준에서 할 수 있다면 어떨까요? 그들이 말하는 것처럼 가장자리에 대고 하세요. 그것이 우리가 코드펜에서 해왔던 일입니다. 그래서 우리는 사랑스러운 워드프레스 블록 편집기로 페이지를 만들 수 있지만 우리의 메인 사이트에서 그것들을 서비스할 수 있습니다.

직접 링크 →