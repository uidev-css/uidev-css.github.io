---
layout: post
title: "동일 출처 정책을 사랑하는 법을 배웠습니다.
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/12/Screen-Shot-2020-12-17-at-8.05.36-AM.png
tags: 
---


나는 올해 내 직장 생활의 상당 부분을 (놀라운 Noam Rosenthal과 협력하여) 새로운 웹 플랫폼 기능, 즉 이미지의 고유 한 크기와 해상도를 수정하는 방법을 표준화하기 위해 노력했습니다.
 그리고 헤이!
 우리는 해냈다!
 그러나 소년, 그것은 학습 경험이었습니다.
 

이것은 나의 첫 번째 표준화 로데오가 아니었기 때문에 우리가 직면 한 많은 문제들에 대해 어느 정도 예상했습니다.
 브라우저의 강력한 부정적인 피드백.
 기본 프리미티브에 대한 이상하고 예상치 못한 문제.
 완전히 다시 생각하거나 두 가지.
 하지만 제가 예상하지 못했던 것은 이미지의 기본 표시 크기를 수정하는 것에 대한 "오직"이라는 우리의 제안이 웹의 기본 개인 정보 보호 및 보안 원칙에 위배된다는 것입니다.
 올해 이전에는 그 원칙을 잘 이해하지 못 했거든요.
 

테이블을 조금 설정하겠습니다.
 우리는 무엇을하려고 했습니까?
 

기본적으로 웹의 이미지는 그대로 표시됩니다.
 800x600 이미지를 삽입 하시겠습니까?
 CSS 또는 마크 업을 사용하여 이미지를 늘리거나 줄이지 않는 한 정확히 크기는 800 CSS 픽셀, 높이 600 CSS 픽셀입니다.
 이것이 이미지의 고유 (일명 "자연") 크기입니다.
 이것을 넣는 또 다른 방법은 기본적으로 웹의 모든 이미지의 고유 밀도가 1 배라는 것입니다.
 

CSS 또는 HTML에 액세스하지 않고 고밀도, 저밀도 또는 ✨ 가변 ✨ 밀도 이미지를 제공하려고 할 때까지 모든 것이 훌륭하고 좋습니다.
 이것은 내 고용주 인 Cloudinary와 같은 이미지 호스트가 자주 발견되는 상황입니다.
 

그래서 우리는 이미지의 본질적인 크기와 해상도를 수정할 수있는 도구를 우리 자신과 나머지 웹에 제공하기 시작했습니다.
 몇 번의 재검토 끝에 우리가 착수 한 해결책은 다음과 같습니다.
 

- 브라우저는 자체적으로 의도 한 디스플레이 크기와 해상도를 선언 할 수 있도록 이미지 리소스 자체에 포함 된 메타 데이터를 읽고 적용해야합니다.
 
- 최근 `이미지 방향`의 발자취에 따라 기본적으로 브라우저는이 메타 데이터를 존중하고 적용합니다.
 하지만 약간의 CSS (`이미지 해상도`) 또는 마크 업 (`srcset`의`x` 설명자)을 사용하여 재정의하거나 끌 수 있습니다.
 

우리는 이것에 대해 꽤 기분이 좋았습니다.
 유연하고 기존 패턴을 기반으로 구축되었으며 이전 제안에 대해 제기 된 모든 문제를 해결하는 것처럼 보였습니다.
 안타깝게도 HTML 사양의 편집자 중 한 명인 Anne van Kesteren은 다음과 같이 말했습니다.
 이것은 작동하지 않을 것입니다.
 그리고 `이미지 지향`도 긴급한 재검토가 필요했습니다.
 CSS 및 HTML을 사용하여 EXIF 메타 데이터의 효과를 켜고 끌 수있는이 패턴은 "동일 출처 정책"을 위반하기 때문입니다.
 

어 ... 뭐?
 

그냥 이미지 크기를 조정하고 회전하지 않습니까 ??
 

고백 시간!
 그 전에 저는 동일 출처 정책을 CORS 오류와 동일시하고 수년에 걸쳐 저에게 야기한 모든 좌절감을 어느 정도 동일시했습니다.
 하지만 지금은 동일 출처 정책이 제 사이에 서서 `가져 오기`를 처리하는 것이 아니라 주요 업무 이니셔티브를 유지하고있었습니다.
 그리고 저는 웹상의 보안과 개인 정보 보호에 대해 저보다 더 잘 아는 상사들에게 상황을 설명해야했습니다.
 배울 시간입니다!
 

제가 배운 내용은 다음과 같습니다.
 

- 동일 출처 정책은 하나의 단순한 규칙이 아닙니다.
 그리고 확실히 == CORS 오류가 아닙니다.
 
- 그것이 무엇인지는 시간이 지남에 따라 진화하고 웹 플랫폼에서 일관성없이 구현 된 철학입니다.
 
- 일반적으로 웹의 기본 보안 및 개인 정보 보호 경계는 출처입니다.
 웹상의 다른 것과 기원을 공유합니까?
 원하는대로 상호 작용할 수 있습니다.
 그렇지 않다면 몇 가지 농구를 거쳐야 할 수도 있습니다.
 
- 왜“그럴까요?”
 글쎄요, 기본적으로 많은 교차 출처 상호 작용이 허용됩니다!
 일반적으로 웹 사이트를 만들 때 여러 출처에서 작성할 수 있습니다 (양식을 통해 원하는 사람에게 `POST`요청을 전송하여).
 또한 사이트 방문자가 웹 사이트에서 볼 수있는 출처 간 리소스 (iframe, 이미지, 글꼴 등)를 포함 할 수도 있습니다.
 하지만 할 수없는 것은 교차 출처 리소스를 직접 살펴 보는 것입니다.
 특별히 부여 된 권한없이 (우리의 오랜 친구 인 CORS를 통해) 자바 스크립트에서 교차 출처 리소스에 대한 어떤 것도 읽을 수 없어야합니다.
 
- 최종 사용자로서 우리 모두는 서로 다른 전 세계 웹을 볼 수 있고 웹 사이트가 볼 수 없어야하기 때문에 교차 출처 읽기는 기본적으로 금지되어 있습니다.
 방문자의 눈을 통해 나머지 웹.
 쿠키를 포함하되 이에 국한되지 않는 개인의 다양한 로컬 브라우징 컨텍스트는 내가 gmail.com으로 이동할 때 주소 표시 줄에 동일한 URL을 입력 할 때 다른 것을 보게 될 것임을 의미합니다.
 "반환"을 누르십시오.
 다른 웹 사이트가 내 브라우저에서 내 쿠키를 사용하여 Gmail에 대한 요청을 시작하고 결과를 읽을 수 있다면 매우 나쁠 것입니다.
 

따라서 기본적으로 교차 출처 리소스로 많은 작업을 수행 할 수 있습니다.
 그러나 교차 출처 읽기를 방지하는 것은 일종의 야구 게임입니다.
 이러한 기본값은 사람들이 "동일 출처 정책"에 대해 이야기 할 때 말하는 내용입니다.
 

이 모든 것이 이미지의 고유 한 크기 및 해상도와 어떤 관련이 있습니까?
 

사용자가 현재 coolbank.com에 로그인했는지 여부에 따라 다른 리소스를 반환하는 이미지 URL `https://coolbank.com/hero.jpg`가 있다고 가정 해 보겠습니다.
 로그인했을 때 표시되는 버전에 EXIF 해상도 정보가 있지만 그렇지 않은 경우 표시되는 버전에는 없습니다.
 마지막으로, 내가 사악한 피셔 맨 인 척하여 귀하가 속한 은행을 파악하여 홈페이지를 속여서 내 사악한 양식에 은행 로그인 정보를 입력하도록 속일 수 있습니다.
 

그래서!
 악의 페이지에 `https://coolbank.com/hero.jpg`를 삽입합니다.
 본질적인 크기를 확인합니다.
 `이미지 해상도 : 없음`으로 EXIF 크기 조정을 해제 한 다음 크기를 다시 확인합니다.
 이제 CORS 제한으로 인해 이미지의 픽셀 데이터를 볼 수 없지만 EXIF 해상도 정보가 포함되어 있는지 여부를 알고 있습니다. 원본에 관계없이 해당 이미지의 작은 부분을 읽을 수있었습니다.
 이제 coolbank.com에 로그인했는지 여부를 알고 계정을 가지고 있습니다.
 

과격?
 혹시!
 그러나 웹은 상상할 수 없을 정도로 넓은 공간입니다.
 그리고 Jen Simmons가 말했듯이
 

웹 브라우징은 기본적으로 다른 사람의 신뢰할 수없는 악성 코드를 하루 종일 실행하는 것입니다.
 동일 출처 정책을 포함하여 웹 보안 및 개인 정보 보호의 기본 원칙은 이러한 안전을 가능하게하며 절대적으로 보호되어야합니다.
 우리가 의도하지 않게 동일 출처 정책에서 열려고하는 구멍은 처음에는 너무 작아 보였습니다.
 겉보기에 무해한 정보의 문자 그대로 몇 가지.
 그러나 출처 간 읽기는 작지만 출처 간 읽기이며 교차 출처 읽기는 허용되지 않습니다.
 

사양을 어떻게 수정 했습니까?
 우리는 EXIF 해상도 및 방향 정보를 해제 할 수 없도록하여 원본간에 읽을 수 없도록 만들었습니다. 원본 간 컨텍스트에서는 EXIF 수정이 항상 적용됩니다.
 EXIF에서 400x300으로 처리해야한다고 말하는 800x600 이미지는 400x300 이미지와 똑같이 작동합니다.
 문제를 이해하면 충분히 간단한 솔루션입니다.
 

보너스로 Same-Origin Policy와 웹의 기본 보안 정책 뒤에있는 이유를 이해 한 후에는 다른 웹 보안 부분이 제 자리에 있기 시작했습니다.
 

교차 사이트 요청 위조 공격은 기본적으로 교차 출처 쓰기가 허용된다는 사실을 이용합니다. API 엔드 포인트가 `POST`요청에 응답하는 방식에 대해주의하지 않으면 나쁜 일이 발생할 수 있습니다. 마찬가지로 콘텐츠 보안 정책을 사용하면 허용되는 삽입 유형을 세밀하게 제어 할 수 있습니다. 기본적으로 모두 포함되어 있으며 사이트 간 스크립팅 공격에 대한 문을 열어주기 때문입니다. 그리고 웹 보안 기능 (COOP, COEP, CORP 및 CORB)의 새로운 알파벳 수프는 출처 간 상호 작용을 완전히 차단하고, 동일 출처 정책이 수년에 걸쳐 구현 된 일관되지 않은 방식 중 일부를 수정하고 종료하는 것입니다. "교차 출처 격리"로 알려진 희박 상태를 달성하기 위해 가능한 모든 교차 출처 상호 작용을 감소시킵니다. Spectre와 친구들이 교차 출처로드를 이용하여 출처 간 읽기를 수행 할 수 있음을 의미하는 세계에서, 다양하고 새롭고 강력한 작업을 수행 할 때 안전을 보장하기 위해 완전한 출처 간 격리가 필요합니다.
 

요컨대 :
 

- 웹상의 보안 및 개인 정보 보호는 실제로 생각할 때 매우 놀랍습니다.
 
- 이는 플랫폼의 기본 정책의 산물이며 오리진 간의 상호 작용을 제한하는 것입니다.
 
- 기본적으로 아무도 할 수 없어야하는 한 가지는 원본에서 데이터를 읽는 것입니다 (특별 권한없이).
 
- 읽기가 금지 된 이유는 우리 모두가 다른 웹을보고 공격자가 잠재적 인 피해자의 눈을 통해 웹을 볼 수 없어야하기 때문입니다.
 
- ifs, ands 또는 buts가 없습니다!
 동일 출처 정책의 모든 구멍은 작지만 남용 할 수있는 표면적입니다.
 
- 2020 년에 저는 동일 출처 정책 (죄송합니다)에 작은 구멍을 뚫고 나서 위의 모든 것을 배웠습니다.
 

가능한 모든 의미에서 더 안전하고 더 안전한 2021 년이 되겠습니다.
 