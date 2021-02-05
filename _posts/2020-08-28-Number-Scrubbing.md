---
layout: post
title: "번호 스크러빙"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2018/11/keyboard-focus.png
tags: FORM CONTROLS,KEYBOARD
---


= 입력 type="number"를 사용하는 경우 일부 브라우저는 위쪽/아래쪽 화살표(흔히 "spinner"라고 함)와 같이 숫자를 늘리기 위한 UI가 있는 입력을 제공합니다.


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video controls="" src="https://css-tricks.com/wp-content/uploads/2020/08/input-number.mp4" name="fitvid0"></video>
</div>


그것은 가끔 도움이 됩니다. 하지만 사람들은 확실히 그 숫자를 갱신하는 더 멋진 방법을 탐구해 왔다. "스크러빙"이 그 방법들 중 하나이다. 저는 항상 포토샵을 생각합니다. 포토샵은 오랫동안 이 상호작용을 지원해 왔습니다.


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video controls="" src="https://css-tricks.com/wp-content/uploads/2020/08/photshop-scrubbing.mp4" name="fitvid1"></video>
</div>


얼마 전에 도미니크 야니크의 데모를 봤는데 코드 블록 안에서 이런 걸 하는 거야 마우스를 사용하여 숫자 위에 마우스를 올려놓고 왼쪽에서 오른쪽으로 "스크러브"를 눌러 숫자를 늘리거나 줄일 수 있는 방법을 확인하십시오.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 490px;"><iframe id="cp_embed_XWdjrQv" src="//codepen.io/anon/embed/XWdjrQv?height=490&amp;theme-id=1&amp;slug-hash=XWdjrQv&amp;default-tab=result" height="490" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed XWdjrQv" title="CodePen Embed XWdjrQv" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

도미닉이 코드펜에 올리는 것 자체에 대해 문의했다. 그것도 멋질 것 같지만, 나도 예전에 스네이크에게 물린 적이 있기 때문에, 핵심 편집자에 대한 약간의 변화가 있다. 코드 미러 및/또는 모나코 및/또는 에이스 플러그인에 완벽한 종류입니다.

칸 아카데미 편집장이 편집장에서 지지하기 때문에 에이스에게는 이미 존재하는 것이 틀림없다.

다른 사례를 찾아 헤매다가 Fabrice Weinberg의 좋은 사례를 접하게 되었습니다. 다양한 옵션이 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 550px;"><iframe id="cp_embed_ICspx" src="//codepen.io/anon/embed/ICspx?height=550&amp;theme-id=1&amp;slug-hash=ICspx&amp;default-tab=result" height="550" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed ICspx" title="CodePen Embed ICspx" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

Lea Verou`s Dabblet가 이 일을 했던 기억이 있다고 생각했는데, 제가 잘못 기억한 것 같아요. 하지만 다음과 같은 멋진 팝업을 제공합니다.


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video controls="" src="https://css-tricks.com/wp-content/uploads/2020/08/dabblet-popups.mp4" name="fitvid2"></video>
</div>


숫자 증대를 위해 ➡+➡↑➡와 ➡+➡↓➡도 지원한다. 코드펜이 그렇게 해! 우리는 그 기능을 강화하는 Emmet을 지지한다.


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video controls="" src="https://css-tricks.com/wp-content/uploads/2020/08/nudge.mp4" name="fitvid3"></video>
</div>


정말 마음에 드는 UX를 우연히 본 적이 있나요?