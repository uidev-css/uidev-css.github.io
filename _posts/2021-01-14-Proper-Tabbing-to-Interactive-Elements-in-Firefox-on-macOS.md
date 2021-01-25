---
layout: post
title: "macOS의 Firefox에서 대화 형 요소에 적절한 탭 지정"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2021/01/jm..png
tags: 
---


Firefox에서 포커스 가능한 요소로 문제를 디버깅해야했습니다.
 누군가가 CodePen 임베딩 내의 특정 요소를 탭하면 스크롤 위치가 페이지 상단 (WTF ?!)으로 이동했다고보고했습니다.
 그래서 Firefox의 예제 페이지를 탭하여 문제를 디버그하려고했는데 이것이 제가 본 것입니다.


<div class="video_wrapper" style="padding-top: 56.25%;">
    <iframe src="https://player.cloudinary.com/embed/?public_id=firefox-tabbing_x0zfdv&amp;cloud_name=css-tricks&amp;player%5Bfluid%5D=true&amp;player%5Bcontrols%5D=true&amp;source%5Bsource_types%5D%5B0%5D=mp4" allow="autoplay; fullscreen; encrypted-media; picture-in-picture" allowfullscreen="" frameborder="0" name="fitvid0"></iframe>
</div>


나는 그것을 어떻게 만들지조차 몰랐습니다.
 탭할 수있는 요소와 같았지만 다른 요소는 아니 었나요?
 `<button>`에는 탭할 수 있지만`<a>`에는 탭할 수 없습니까?
 파이어 폭스에서 링크를 탭할 수 없다는 것이 옳지 않은 것 같습니다.

검색하고 물어 본 후 macOS의 OS 수준에서이 환경 설정이 나타납니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2021/01/jm..png?resize=1709%2C1565&ssl=1)

이 기능을 켜야하는 경우 Firefox도 다시 시작해야합니다.
 그런 다음 링크와 같이 탭할 수있을 것으로 예상되는 항목으로 탭할 수 있습니다.


<div class="video_wrapper" style="padding-top: 56.25%;">
    <iframe src="https://player.cloudinary.com/embed/?public_id=firefox-tabbing-fixed_jmpkiw&amp;cloud_name=css-tricks&amp;player%5Bfluid%5D=true&amp;player%5Bcontrols%5D=true&amp;source%5Bsource_types%5D%5B0%5D=mp4" allow="autoplay; fullscreen; encrypted-media; picture-in-picture" allowfullscreen="" frameborder="0" name="fitvid1"></iframe>
</div>


페이지 상단으로 스크롤하는 버그에 대해.
 CodePen Embed를 탭할 때 표시되는 "Skip Results Iframe"링크를 참조하십시오.
 `: focus`-ed 일 때만 표시됩니다 (요점은`<iframe> `을 탭하지 않고 건너 뛰는 것입니다).
 나는`position : absolute;
 상단 : -9999px;
 left : -9999px` 사물 (이전 근육 메모리), 초점이 맞을 때 해당 값을 제거합니다.
 어떤 이유로 탭하면 Firefox는 해당 값을 확인하고 포커스 스타일이 원래 위치로 다시 이동하더라도 페이지를 즉시 위로 이동합니다.
 일종의 경쟁 조건 이었음에 틀림 없다.

또한 해당 링크가 iframe 내부에있을 때 Firefox가 부모 페이지에이를 수행한다는 것은 매우 어리석은 일입니다.
 좀 더 검증 된 접근 가능한 숨기기 기술을 사용하여 수정했습니다.