---
layout: post
title: "Git is here에 대한 CMDB+Z"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/07/tower_testimonials@2x.png
tags: GIT TOWER
---


Git을 이용한 버전 제어는 이제 "상품"이 되었다. 사실상 오늘날 모든 소프트웨어 프로젝트는 Git를 사용하고 있으며, 사실상 모든 개발자는 Git를 어느 정도 알고 있다. 이것이 제가 생계를 위해 무엇을 해야 하는지에 대해 이야기할 때 가끔 다음과 같은 질문을 듣는 이유입니다: "Git를 위한 데스크톱 클라이언트? 내가 왜 그걸 필요로 하지? 난 명령행에서 할 수 있어!“

운이 좋으면 그 질문이 떠오를 때 옆에 컴퓨터가 있어요. 그리고 저는 Git의 데스크탑 클라이언트인 Tower에서 몇 가지 작업을 합니다.

"Interactive Rebase"를 해본 사람이라면 누구나 타워에서 쉽게 사용할 수 있다는 것에 놀라움을 금치 못합니다. 드래그 앤 드롭으로 그것들을 커밋하거나 재주문할 수 있습니다. 그리고 "Interactive Rebase"를 아직 사용하지 않은 사람은 누구나 이 "Interactive Rebase"가 매우 복잡하고 복잡하여 명령줄에서 사용할 수 없기 때문에 매우 유용한 도구라는 것을 알게 되었습니다.

아니면 제가 실수를 할 수도 있습니다. 실수로 나뭇가지를 삭제하거나 끔찍한 방법으로 합병을 망치는 것입니다. 이제 텍스트 편집기에서와 같이 CMDB+Z를 눌러 방금 만든 문제를 해결할 수 있습니다.

그러면 사람들은 진짜 질문은 "명령줄에 있는 Git을 이용해서 얻을 수 있을까?"가 아니라는 것을 깨닫기 시작한다. 더 중요한 질문은 다음과 같습니다.

- Git의 모든 전원을 사용할 수 있습니까? (사용하기 어려울 수도 있지만 매우 가치 있는 고급 기능까지…)
- Git과 생산적인 방식으로 작업할 수 있습니까? (매개변수를 조회할 필요도 없고 워크플로우에 많은 시간을 할애할 필요도 없습니다.)
- Git과 쉽게 협력할 수 있을까요? (너무 많이 생각할 필요 없이…)

불과 9명으로 구성된 소규모 팀인 저희 팀은 지난 10년 동안 타워를 건설하여 이러한 질문에 답했습니다.

## 실수를 취소하는 방법

Git의 가장 큰 특징 중 하나는 거의 모든 것을 되돌릴 수 있다는 것입니다. 그러나 특정 종류의 혼란을 정확히 실행 취소하는 방법을 알기 위해서는 상당한 경험이 필요합니다. 실패한 병합은 삭제된 분기와 다르게 정리되어야 합니다!

오랜 시간 동안 작업한 후, 이제 타워에서는 CMDB+Z!를 누르면 거의 모든 작업을 실행 취소할 수 있습니다(참고: "Undo" 기능은 Mac 버전의 타워에서 처음 사용할 수 있는 최신 기능입니다). 곧 Windows(윈도우)에도 출시됩니다.


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video autoplay="" controls="" loop="" src="https://css-tricks.com/wp-content/uploads/2020/07/undo-mistakes.mp4" playsinline="" name="fitvid0"></video>
</div>


병합을 망치거나, 분기를 실수로 삭제하거나, 중요한 로컬 변경 사항을 무시하거나, 너무 빨리 원격에 분기를 게시하거나, 단순히 "CMD+Z"처럼 단순하게 생명을 구할 수 있으며, 언제든지 사용할 수 있습니다.

## 쌍방향 철근의 힘

인터랙티브 리베이스는 Git의 더 강력한 기능을 보여주는 훌륭한 예입니다. 이렇게 하면…

- 이전 커밋 편집(메시지와 변경 내용 세트 모두!)
- 여러 개의 커밋을 하나로 합치다
- 약속을 다시 정하다.
- …더 이상 필요 없는 커밋도 삭제!

이 모든 것이 코드베이스를 깨끗하고 체계적으로 유지하는 데 많은 도움이 될 수 있습니다. 하지만 매우 강력한 도구인 Interactive Rebase는 사용하기 매우 복잡한 Git 기능의 한 예이기도 합니다.

많은 초보자들은 이 복잡성에 겁을 먹고 있습니다 – 이것은 물론 그들이 이 기능의 장점을 놓치게 된다는 것을 의미합니다! 경험이 풍부한 많은 개발자들은 Interactive Rebase를 알고 사용하지만, 이 기능을 사용하기 어렵기 때문에 많은 시간이 소요되거나 때때로 실수를 하기도 합니다.

이것을 알고, 우리는 인터랙티브 리베이스를 타워에 통합하는 두 가지 목표를 가지고 있었습니다. 한편으로는, 우리는 가능한 한 그것의 복잡성을 줄이고 싶었습니다. 다른 한편으로, 우리는 이 기능에 쉽게 접근할 수 있도록 하고 싶었습니다.

그 결과, Interactive Rebase는 이제 "커밋 히스토리"에 바로 통합되어 단순한 드래그로 액세스할 수 있게 되었습니다.


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video autoplay="" controls="" loop="" src="https://css-tricks.com/wp-content/uploads/2020/07/interactive-rebase.mp4" playsinline="" name="fitvid1"></video>
</div>


커맨드 라인에서 인터랙티브 리베이스를 전혀 사용하지 않았을 수많은 개발자들이 현재 타워에서 매일 사용하고 있다.

## 빠른 작업

크기와 거의 무관하게 코드베이스에서 작업한다는 것은 검색하는데 많은 시간을 소비한다는 것을 의미합니다. 예를 들어 특정 분기(분지 로트 제외) 또는 특정 파일(파일 로트 제외)에 대한 검색입니다.

타워를 사용하면 데이터를 검색하지 않고도, 키보드에서 손을 떼지 않고도 대부분의 일상적인 작업을 수행할 수 있습니다. "빠른 실행" 대화 상자는 거의 모든 입력을 사용하며 이 입력에 대해 간단히 수행할 수 있도록 합니다.

- 지점 이름을 지정하면 체크아웃을 할 수 있습니다.
- 파일 이름을 지정하면 파일 기록에 표시할 수 있습니다.
- 커밋 해시를 주면 커밋의 세부 사항을 보여줄 수 있습니다.


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video autoplay="" controls="" loop="" src="https://css-tricks.com/wp-content/uploads/2020/07/quick-actions.mp4" playsinline="" name="fitvid2"></video>
</div>


많은 데이터를 검색하고 검색하지 않고도 키보드에서 바로 많은 작업을 수행할 수 있기 때문에 개발자로서의 생활이 훨씬 수월해질 수 있습니다.

## 자신감으로 갈등 해결

모든 사람들은 병합(또는 기준)이 중지되고 여러 가지 충돌이 발생하는 그 순간을 싫어합니다 😱 그러면 여러 가지 질문이 프로그래머의 마음에 빠르게 떠오릅니다.

- 변경 사항은 무엇입니까? 다른 사람의 것은 무엇입니까?
- 실제로 무슨 일이 일어났는가?
- 왜 하필 나야?

타워는 이러한 질문에 모두 답할 수는 없지만 상황을 훨씬 더 이해할 수 있도록 도와주는 특별한 "갈등 마법사"를 제공합니다.


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video autoplay="" controls="" loop="" src="https://css-tricks.com/wp-content/uploads/2020/07/conflict-wizard_fullwindow_mac.mp4" playsinline="" name="fitvid3"></video>
</div>


변경사항이 발생한 위치를 쉽게 알 수 있으며 어떤 버전을 사용할지(또는 전용 병합 도구로 이동)를 선택하기만 하면 충돌을 해결할 수 있습니다. 이는 병합 충돌이 추상적인 혼란이 아닌 이러한 방식으로 시각화될 때 상황을 훨씬 쉽게 만듭니다.

## 생산성 향상

타워를 건설하고 개선할 때, 우리는 항상 사용자들을 더 쉽게, 그리고 더 생산적으로 만들기 위해 노력하고 있습니다. 이 정보가 타워에 표시되는 몇 가지 예를 들어 보겠습니다.

- 더 이상 암호, 토큰, SSH 키 없음: GitHub / GitLab / Bitbucket / Azure DevOps 계정을 Tower와 쉽게 연결할 수 있습니다. 연결된 후에는 암호, 인증, 토큰, 사용자 이름 및 SSH 키와 더 이상 씨름할 필요가 없습니다. 따라서 원격 저장소를 복제하고 상호 작용하는 것은 클릭 한 번만으로 가능합니다.
- 단일 라인 스테이징


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video autoplay="" controls="" loop="" src="https://css-tricks.com/wp-content/uploads/2020/07/single-line-staging.mp4" playsinline="" name="fitvid4"></video>
</div>


- 새 차이 뷰어: 가장 최근의 업데이트에서, 우리는 내부 Diff Viewer를 전면 개편했습니다. 이제 인라인 변경 사항을 강조 표시하고, 공백 변경 사항을 표시하거나 숨길 수 있으며, 전체 파일을 표시할 수 있으며, 테마로 완전히 사용자 정의할 수 있습니다!


<div class="video_wrapper" style="padding-top: 56.25%;">
    <video autoplay="" controls="" loop="" src="https://css-tricks.com/wp-content/uploads/2020/07/diff-viewer.mp4" playsinline="" name="fitvid5"></video>
</div>


- 지루한 작업을 위한 자동화: 탑은 깃 주변의 많은 투덜거리는 일을 처리한다. 두 가지 예만 들자면, 원격에서 정기적으로 새 업데이트를 가져올 필요도 없고 분기/합병하기 전에 커밋되지 않은 변경 사항을 준비할 필요도 없습니다. 타워가 자동으로 그렇게 해 줍니다.

제가 가장 좋아하는 어플리케이션을 생각해보면, 그들은 모두 공통점을 가지고 있습니다. 그것들은 제 삶을 더 쉽게 만들어주고, 저를 더 생산적으로 만들어주며, 그것들 없이는 제가 하기 힘들었던 것들을 제가 할 수 있게 해줍니다. 많은 사용자들이 타워를 그들이 가장 좋아하는 앱 중 하나로 생각해줘서 기쁘고 고마워!

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/07/tower_testimonials@2x.png?fit=1024%2C470&ssl=1)

타워를 한번 해보고 싶다면 저희 웹사이트에서 다운받아서 30일 무료 테스트만 하시면 됩니다. 그리고 만약 여러분이 학생이나 선생님이라면, 여러분은 무료로 타워를 이용할 수 있어요!