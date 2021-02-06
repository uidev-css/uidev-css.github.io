---
layout: post
title: "보다 포괄적인 웹 성능 메트릭이 필요합니다."
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2019/08/website-lightning.png"
tags: PERFORMANCE
---


Scott Jehl은 First Contentful Paint 및 Large Contentful Paint와 같은 성능 지표가 웹 사이트에 대한 모든 사람들의 경험의 전체 그림을 제대로 캡처하지 못한다고 주장합니다.

> 이러한 지표는 종종 사용적합성이나 의미의 척도로 권장되지만, 모든 사람에게 반드시 의미 있는 것은 아니다. 특히 보조 기술(예: 화면 판독기)에 의존하는 사용자들은 DOM이 완료될 때까지 또는 나중에 자바스크립트가 그 프로세스를 차단하는 방법에 따라 페이지 로딩 프로세스의 단계를 인식하지 못할 수 있다. 또한 A.T.에서는 많은 애플리케이션이 외부 JavaScript를 통해 액세스 가능한 상호 작용을 제공하기 때문에 완전히 상호 작용하기 전까지는 페이지를 사용할 수 없습니다.

그리고 나서 스콧은 우리가 어떻게 그것을 할 수 있는지에 대해 몇 가지 생각을 적는다. 저는 이것이 항상 염두에 두기에 매우 유용하다고 생각합니다. 우리가 사이트에서 경험하는 것과 우리가 측정하는 것은 전체 그림이 아닐 수도 있습니다.

직접 링크 →