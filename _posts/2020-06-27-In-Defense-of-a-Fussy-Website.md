---
layout: post
title: "까다로운 웹 사이트를 방어하기 위해"
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/06/12.jpg"
tags: CARE,INTENTION,PORTFOLIO,UX
---


요전 날 저는 트위터를 망각하고 있었는데, "조식사 건"이라는 제목의 즐거운 기사를 보았습니다. 저는 음식과 특히 아침식사를 좋아합니다. 그리고 유행병이 강타한 이후로 저는 회의 사이에 휴식시간을 이용하여 베이컨, 수란, 야채 접시를 만드시고 있습니다. 그래서 저는 그 기사에 정말 빠져들었습니다. 하루 중 가장 중요한 식사를 위해 나 자신을 위한 공간을 만드는 이 작은 기쁨은 제게 의미 있는 일이었습니다. 다른 모든 것들이 통제 불능으로 느껴질 때, 어떤 의식을 즐기는 것은 우리의 집단적 상황의 강도를 상쇄시키는 작은 역할을 했습니다.

그것은 나에게 이 "혼란"이 다른 중요하지 않은 기쁨에 적용되는 것이라고 생각하게 했다. 산책이요. 목욕. 프로그래밍은 어때요?

우리 모두는 최신 기능과 최신 소프트웨어 및 최고의 라이트하우스 점수를 제공하는 데 집중하고 있지만, 저는 웹상에서 약간의 즐거움을 놓치고 있습니다. 앱은 현재 UX, 안내, 풍요로움, 그리고 컴퓨터를 통해 소통하려는 사람들을 위해 많은 노력을 기울이고 있습니다.

저는 웹이 단순한 문서 리더로서 보여지는 것에 조금 지겨워지고 있습니다. 그리고 저는 저를 건강한 등대 점수로 사랑하지만, 이러한 포인트 매트릭스들 중 일부는 우리가 큰 무게를 들이지 않고 할 수 있는 것을 실제로 고려하기 보다는 개발자의 자아에 의해 더 살고 죽는 것 같습니다. SVG는 매우 작지만 여전히 영향을 미칠 수 있습니다. 일부 효과들은 CSS의 작은 비트들이다. JS 애니메이션은 게으르게 로딩될 수 있다. 여러분은 심지어 단어, 색, 배치로 현혹할 수 있습니다. 만약 여러분이 약간 모험적이기를 원한다면, 전혀 무게가 없습니다!

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/06/CleanShot-2020-06-25-at-12.11.00@2x.png?fit=1024%2C606&ssl=1)

최근에 제가 가장 좋아하는 개발자 사이트로는 조쉬 코마우, 존슨 오그워루, 캐시 에반스가 있습니다. 작은 기쁨과 감동, 작은 아하 순간들이 저를 스테이로 만듭니다. 저는 그 사이트를 돌아다니면서, 마치 이력서의 PDF를 보는 것 보다는 실제로 각각의 인간들과 더 많이 연결되어 있다고 느끼고, 탐구하고, 배우고, 느낍니다. 그들은 근육을 풀어주고, 무언가를 만드는 것에 대한 자부심을 보여주며, 그것은 나를 흥미롭게 한다. 이 작은 조각들은 많은 사람들이 "과도한" 것을 묘사하는 솜털 이상의 것이다: 그들은 웹이 의도하는 일을 한다. 우리는 우리의 확장으로서 이 도구인 컴퓨터를 사용하여 의사소통하고 있다.

뉘앙스는 어려울 수 있다. 프로그래머로서 절대적인 것에 얽매이기 쉽습니다. 그리고 최근에 있었던 일들 중 하나는 만약 여러분이 어떤 재미, 어떤 스타일을 즐기고 있다면, 그것은 "쓸데없는" 것을 의미한다는 것입니다. 솔직히, 나는 그 반대라는 주장을 할 거야. 감정은 변연계에 달라붙어 기억을 기억하기 쉽게 만든다. 만약 당신의 사이트가 텍스트의 작은 부분이라면, 누가 그것을 기억하겠는가?

여러분은 전 세계 기업 팀들이 기억하고 영감을 주는 사이트를 만들고 싶지 않나요? 저는 사람들이 Stripe를 닮고자 하는 사이트로 언급했던 4개의 다른 회사에 다녔습니다. 스트라이프가 모험을 했다. 스트라이프가 이야기를 했어요. 스트라이프는 개발자들의 상상력을 동원했고, 우리에게 직접 말했습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/06/CleanShot-2020-06-25-at-12.12.49@2x.png?fit=1024%2C550&ssl=1)

스트라이프가 어떤 위치에 있었는지 생각해 본 후, 대부분의 회사들이 스트라이프를 탐험하면서 배운 것을 많이 무시했다는 아이러니를 인정하게 되어 슬프다. 창의성, 위험성, 의도는 천천히, 하나하나, "유용함"이라는 북소리에 의해 깨져나갔고, 나무를 위한 숲을 놓쳤다.

사이트가 주의와 흥분을 다하면 알 수 있다. 당신이 방문했을 때, 당신은 그것을 느낍니다, 의도의 웅웅거림. 기술, 응집력, 세세한 것에 대한 관심은 명백합니다. 그리고 차례로, 당신은 그들을 중간에서 만난다. 이러한 사이트는 낮은 바운스 비율, 최고의 참여 지표, "기여할 수 있습니까?"와 같은 질문을 받는 사이트입니다. 속임수는 필요 없다.

시간이 안 되면 어떡하지? 물론, 우리는 모두 선을 넘어야 합니다. 아마도 하나의 도전일 것입니다: 누군가가 알아차릴 수 있는 작은 것을 통합할 수 있는가? 한 가지 세부 사항으로 시작할 수 있습니까? 아침 식사 때 수란으로 시작하지 않았는데, 어느 날 바보 같은 스크램블을 만들었어요. 거기서부터 계속됐어요. 여러분은 작은 새로운 기술을 배우려고 도전할 수 있나요? 그래픽 하나를 아웃소싱할 수 있습니까? 작은 부활절 달걀을 소개해줄 수 있나요? 일반적인 기업 용어와 조금 다르게 말하세요?

만약 여러분에게 뭔가 의미 있는 일이 있다면, 여러분이 모일 청중들도 그 의미를 찾는 사람들이 될 것입니다.