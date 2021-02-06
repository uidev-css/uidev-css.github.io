---
layout: post
title: "새로운 Chrome: CSS 개요"
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/06/chrom-devtools-css-overview.png"
tags: DEVTOOLS
---


여기 크롬의 새로운 실험 기능이 있습니다! 이제 사이트에서 사용되는 CSS의 개요(색상 수부터 사용되지 않은 선언 수까지)를 정의된 총 미디어 쿼리 수까지 확인할 수 있습니다.


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video controls="" muted="" src="https://css-tricks.com/wp-content/uploads/2020/06/css-overview.mp4" name="fitvid0"></video>
</div>


다시 말하지만, 이것은 실험적인 특징입니다. 이는 아직 진행 중임을 의미할 뿐만 아니라 DevTools에서 사용할 수 있도록 해야 한다는 뜻입니다.

- DevTools(`Command`+`Option`+`) 열기Mac에서 I; 제어 + 시프트 +Windows에서)
- DevTool Settings(Mac에서는 `?` 또는 `Function`+`F1`, Windows에서는 `?` 또는 `F1`)로 이동합니다.
- Experiments 섹션을 클릭합니다.
- CSS 개요 옵션 사용

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/06/chrome-devools-css-overview.png?fit=1024%2C709&ssl=1)

그리고, 오, 이봐, 저것 좀 봐! 설정이 닫히면 DevTools 메뉴 트레이에 "CSS 개요" 탭이 새로 표시됩니다. 보이지 않을 경우 오버플로우 메뉴에 숨겨져 있지 않은지 확인하십시오.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/06/Screen-Shot-2020-06-30-at-7.55.15-AM.png?fit=1024%2C722&ssl=1)

보고서는 색상, 글꼴 정보, 사용되지 않은 선언 및 미디어 쿼리를 포함한 여러 섹션으로 구분됩니다. 그것은 바로 우리 손끝에 있는 작은 공간에서 이용할 수 있는 많은 정보입니다.

그래도 꽤 근사하죠? 저는 이런 도구가 브라우저로 옮겨가기 시작했다는 것이 좋습니다. 이것이 프런트엔더로서뿐만 아니라 디자이너들과 어떻게 협력할 수 있는지에 대해서도 생각해 보십시오. 디자이너가 이걸 열고 컬러 팔레트에서 폰트 스택에 이르기까지 모든 것이 제대로 작동하는지 확인할 수 있습니다.