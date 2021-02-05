---
layout: post
title: "Netliify의 대기열 점프"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/08/netlify-queue-jump.png
tags: NETLIFY
---


추적하기: Netlifify의 비즈니스 또는 엔터프라이즈 팀에 속해 있는 경우 빌드를 클릭하여 대기열에서 다음에 실행할 수 있습니다. 예를 들어, 실제로 시간에 민감한 문제(예: 프로덕션으로 가는 버그 수정)가 있는 경우, 일부 랜덤 개발 지사 건물보다 훨씬 앞서 나갈 수 있습니다. 이제 자세히 설명하겠습니다.

Netlifify의 로켓 주스의 일부는 그것이 당신을 위해 당신의 건물을 운영한다는 것입니다. 당신이 지킬 사이트를 가지고 있다고 말하세요. 빌드 명령은 아마도 `지킬 빌드`일 것이다. Netlifify에 실행할 명령이라고 말하고, 이 명령이 성공하면 배포합니다.

그 빌드 명령은 전적으로 당신에게 달려 있습니다. "npm run build"일 수 있으며 이를 통해 패키지의 빌드 명령이 호출됩니다.사용자 지정 스크립트를 시작하는 json입니다. 또한 빌드 플러그인을 사용하면 프로세스를 제어할 수 있습니다(예: Sass를 쉽게 실행할 수 있습니다). 바로 CI/CD입니다!

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/08/Screen-Shot-2020-06-09-at-6.47.36-AM.png?resize=1024%2C597&ssl=1)

Gitrepo를 연결한다고 가정할 때, 이는 단순히 빌드가 실행되는 메인 브랜치로만 푸시하는 것이 아니라 모든 브랜치에 있습니다. 여러 가지 이유로 아주 좋아요. 우선, 여러분의 체격도 아마 테스트를 하고 있을 것입니다. 그래서 정직함을 유지하고 있습니다. 다른 것에 대해 Netlifify는 각각의 푸시에게 정확한 코드 세트의 배포된 버전에 대한 퍼머링크를 제공한다. 그것은 매우 유용합니다. 스테로이드를 복용하는 것 같아요. 필요한 사람은 누구나 사이트 미리 보기를 받을 수 있습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/08/CleanShot-2020-08-18-at-07.56.22@2x.png?resize=1024%2C505&ssl=1)

특정 프로젝트에서는 개발자로 구성된 팀이 여러 지점에서 작업하고 코드를 커밋하며 빌드를 실행할 수 있습니다. 그래서 Netliify는 그 모든 일을 하느라 매우 바쁠지도 모른다. 네 체격이 다른 사람의 물건 뒤에 처질지도 몰라. 그건 전혀 문제가 되지 않을지도 몰라. 또는 2분 후에 중요한 미팅이 있을 수 있으며 모든 사용자가 볼 수 있도록 배포 미리보기가 필요할 수 있습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/08/monitor-builds-prioritized-build.jpg?resize=1024%2C628&ssl=1)

이제 (비즈니스 또는 엔터프라이즈 계정에 속한) 팀에 있는 경우 대기열을 이동하여 다음 단계로 진행하도록 선택할 수 있습니다. 사람들이 볼 수 있을 거야 그렇게 한 건 너였잖아, 너도 알다시피, 약간의 예의를 갖춰야 해.