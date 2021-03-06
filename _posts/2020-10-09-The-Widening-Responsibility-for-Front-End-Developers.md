---
layout: post
title: "프런트엔드 개발자의 책임 확대"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/09/tree.png
tags: 
---


이것은 스트라이프가 발행하는 멋진 인크레인지 잡지에 실린 제 에세이 "When front-end is mean full-stack"의 확장판입니다. 그것은 또한 제 에세이 "The Great Divide"와 "웁스, 이제 우리는 풀스택 개발자가 된 것 같아."의 진화에 관한 것입니다.

중학교 때부터 대학까지 선택한 과정을 돌이켜보면 컴퓨터 위주의 수업과 미술 위주의 수업을 오갔기 때문에 직업으로 둘 다 할 수 있는 방법을 찾은 것은 놀라운 일이 아니라고 생각한다.

"Front-End Developer"라는 용어는 상당히 잘 정의되고 이해됩니다. 1인칭은 직책이죠. 여러분 중 몇몇은 말 그대로 명함을 가지고 있을 것입니다. 혹은 "Front-End Designer", "UX Developer" 또는 "UI Engineer"와 같은 다양한 종류의 명함을 가지고 있을 것입니다. 그것이 무엇을 의미하는지에 대한 토론은 나에게 특별히 흥미롭지 않다. 직종별, 회사별로 역할이 너무 다양해서 직함이 사물을 묘사하기에 결코 충분하지 않다는 것을 알게 되었습니다. 이 직업을 갖는 것은 다른 무엇보다도 당신이 무엇을 하고 있는지 당신이 알고 있다는 것을 증명하는 것이다.

제목 변화는 단지 뉘앙스일 뿐이다. 더 큰 그림은 이 일이 웹사이트를 만드는 동안 프런트엔더는 브라우저에 집중한다는 것이다. 말 그대로:

- 프런트 엔드 = 브라우저
- 백엔드 = 서버

비록 그 직업이 수십 년 동안 바뀌었지만, 그 구별은 여전히 크게 유지되고 있다.

"브라우저족"으로서, 놀이기구를 타기 위해 따르는 어떤 진리들이 있다. 하나는 다른 브라우저의 전체 환경이 있으며 표준 기관의 최선의 노력에도 불구하고 여전히 다소 다르게 동작한다는 것이다. 바로 오늘, 글을 쓰면서 제가 API에서 가지고 있던 날짜 문자열이 .to.ISOString() 자바스크립트 API를 사용하려다 파이어폭스가 오류를 일으킬 정도로 버그를 처리했지만 크롬에서는 괜찮았습니다. 그것은 단지 프런트 엔드 개발자로서의 삶일 뿐이다. 그게 일이야.

그 일의 가장 중요한 측면은? 이 브라우저를 사용하는 사용자입니다. 그래서 우리가 뭔가를 만들고 있는 겁니다. 제 미친 CSS 실력으로 제가 감명을 주고자 하는 사람들이에요. 이 사람들이 제가 제 위젯을 사려고 하는 사람들입니다. 내 모든 사업 차트가 누구에게 달려있는지. 누구의 반응이 내 감정을 미풍에 실처럼 흔들 수 있다. 우리가 이런 사용자들을 받침대에 올려놓는 것은 정당한 이유 때문인데, 브라우저보다 훨씬 넓은 시야를 가지고 있습니다. 그들은 다른 언어를 사용한다. 그들은 다른 것을 원한다. 그들은 다른 문제들을 해결하려고 노력하고 있다. 그들은 다른 신체적 능력을 가지고 있다. 그들은 다른 수준의 긴급함을 가지고 있다. 다시 말하지만, 그들을 돕는 것은 확실히 전방 개발자들의 손에 달려 있다. 텍스트 편집기에 입력하는 문자와 서비스하려는 사용자 사이에는 거의 차이가 없습니다.

프런트 엔드 개발자가 되는 것은 우리가 건설하는 것과 그것을 위해 건설하는 사람들 사이의 최전선에 서게 합니다. 그리고 그것은 우리들 중 몇몇은 정말로 즐겨 찾는 곳입니다.

정말 무거운 물건이죠, 그렇죠? 아직 리액트도 언급 안 했는데.

"우리는 사용자에 대해 관심이 있다"는 것이 약간 소중하게 느껴질 수도 있다. 저는 높은 기능을 하는 회사에서는 CEO부터 아래까지 모든 사용자가 관심을 가질 것이라고 생각합니다. 하지만 달라요. 우리가 `<button>`을 코딩할 때 우리는 말 그대로 사용자가 직접 상호작용하는 브라우저 창에 단추를 넣는 것이다. 색을 조정할 때, 우리는 시각적인 사용자가 우리의 작품을 볼 때 보는 것을 정확하게 조정하고 있습니다.

우리는 프런트 엔드 개발자가 브라우저 사용자라는 것을 확인했다. 그 일은 브라우저에서 잘 작동하도록 만드는 것이다. 그래서 우리는 브라우저가 말하는 언어, 즉 HTML, CSS, JavaScript를 이해해야 한다. 그것은 단지 제가 오래된 학교 근본주의자가 되는 것만이 아닙니다. 몇 십 년간의 일상적인 프런트 엔드 개발 작업을 통해서 기본적인 언어들을 아는 것이 우리가 일을 잘 하는 데 필수적인 것입니다. 우리가 그들과 직접 작업하지 않을 때에도 (HTML은 다른 언어로 된 템플릿에서 나올 수 있고, CSS는 전처리에서 생성될 수 있으며, 자바스크립트는 프레임워크의 준말로 쓰여질 수 있다.) 궁극적으로 브라우저는 HTML, CSS, 자바스크립트이다. 따라서 디버깅은 주로 일어나고 브라우저의 능력은 i.일을 시작하다

CSS는 언제나 내가 가장 좋아하는 것이고 HTML은 그것이 가장 많은 사랑을 필요로 하는 것처럼 느껴질 것이다. 그러나 자바스크립트는 우리가 정말로 조사해야 할 것이다. 지난 10년간 자바스크립트가 소수의 상호작용 효과에 사용되는 언어에서 웹 설계와 개발의 스택 전체에서 사용되는 지배적인 언어에 이르기까지 꽃을 피웠다. 웹 사이트에서 작업하고 JavaScript 외에는 아무것도 쓸 수 없습니다. 진정한 바다 변화.

JavaScript는 브라우저에서 모두 사용할 수 있습니다. 어떤 의미에서, 그것은 HTML과 CSS를 대체하는데, 자바스크립트에서 할 수 없는 어떤 언어도 없기 때문이다. HTML은 브라우저에 의해 구문 분석되고 DOM으로 바뀌는데, 이 DOM은 JavaScript가 완전히 만들고 조작할 수도 있다. CSS는 자체 모델인 CSSOM을 가지고 있는데, 이 모델은 자바스크립트가 만들고 조작할 수 있는 DOM의 요소에 스타일을 적용한다.

하지만 이것은 공평하지 않다. HTML은 브라우저가 사이트를 구축하는 데 필요한 나머지 작업을 수행하기 전에 구문 분석하는 첫 번째 파일입니다. 이러한 우선 순위는 HTML에만 국한되며 웹 사이트를 빠르게 만드는 중요한 부분입니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/09/Screen-Shot-2020-09-25-at-7.49.54-AM.png?resize=787%2C108&ssl=1)

실제로 HTML이 네트워크를 통해 들어오는 유일한 파일이었다면, 그 정도면 사이트의 기본 정보와 기능을 전달하기에 충분할 것이다.

그 철학은 진보적 강화라고 불린다. 저도 팬이지만, 항상 완벽하게 고수하지는 않아요. 예를 들어, 동작 속성이 양식을 처리할 수 있는 URL을 가리키면 HTML에서 `<form>`이 완전히 기능할 수 있습니다. 진보적 강화는 우리가 그것을 그렇게 만들도록 만들 것이다. 그런 다음 JavaScript가 실행되면 제출을 넘겨받아 Ajax를 통해 양식을 제출하게 되는데, 페이지를 새로 고치지 않아도 되므로 더 좋은 경험이 될 수 있습니다. 난 그게 좋아. 뿐만 아니라 양식 외부의 어떤 `버튼`도 JavaScript가 없으면 전혀 쓸모가 없으므로, Progressive Enhancement(진행적 향상)의 정신으로 자바스크립트가 실행될 때까지 기다려야 합니다. 그것은 우리 중 가장 좋은 의도를 가진 사람들조차도 항상 완벽하게 선을 긋지 않을 수 있는 그런 종류의 것이다. 버튼이나 넣어, 샘 아무도 죽지 않을 거야

특히 자바스크립트가 더욱 강력하고 인간공학적으로 발전하면서 자바스크립트에 내장된 프레임워크가 더욱 복잡해짐에 따라, 웹에서 작업하는 사람들에게 자바스크립트의 강력한 타겟이 되고 있다. 2015년에, 자바스크립트가 놀라운 사용 성장을 경험하고 있다는 것이 이미 너무나 분명했고, 워드프레스의 공동 설립자인 Matt Mullenweg는 개발자들에게 "JavaScript Deepth"라는 숙제를 내주었다. 그가 더 옳았을 리가 없다. 50년 후, 자바스크립트는 프런트 엔드 개발을 성공적으로 인수하였다. 특히 프런트엔드 개발 작업을 살펴보면 더욱 그렇습니다.

웹 매커니즘은 상위 조 사이트의 5%만이 jQuery를 포함하여 85%에 비해 React를 사용한다는 것을 보여줄 수 있지만, 프런트 엔드 개발 작업 요구 사항을 살펴보면 이러한 숫자는 거의 뒤집혀진다.

그 모든 것에는 화려한 경제적 이유가 있겠지만, 일자리는 사람들에게 중요한 만큼 중요하고 개인적인 것이기 때문에 매우 중요합니다.

그래서 우리는 자바스크립트 바다에 있는 브라우저 사람들이 사람들을 위해 무언가를 만들고 있습니다. 일상적인 작업 수준에서 작업을 살펴보면 다음과 같습니다.

그 첫 번째 총점이 대학 학위처럼 느껴져. 종합해보면, 그 모든 점들은 확실히 그렇다.

이 전체 목록은 좀 추상적이긴 하지만, 우리가 볼 수 있는 것에 적용해보자. 만약 이 웹사이트가 우리의 현재 프로젝트였다면요?

![image](https://paper-attachments.dropbox.com/s_6AC52F8D744ABA156A5C151CCEB4CEF78627ECE8A6493E48630C725F70EB7A84_1576625930131_image_processing20190814-21784-1edetsf.png)

우리의 뇌와 손가락은 날뛰어요!

계속 할 수 있어요. 적어도 제 경험이나 동료들과의 대화에서는 그렇게 생각하는 것이 프런트엔드 개발자들은 그렇게 생각합니다.

하지만 그런 많은 것들이 영원히 우리의 일이었습니다. 우리는 우리가 그것을 하는 동안 우리가 만든 모든 웹사이트에서 이러한 질문들을 묻고 답해왔습니다. 사이트마다 도전과제가 달라서 훌륭하고 이 일을 재미있게 해 주지만 반복도 많다.

제가 이 기사의 제목을 살펴보도록 하겠습니다.

저는 이 부품이 마음에 듭니다. 이를 통해 여러분과 여러분의 팀은 여러분과 여러분이 만들고 있는 것에 가장 적합한 추상화를 만들 수 있습니다.

카드 구성요소는 카드에 필요한 모든 작업을 수행합니다. 당신의 `양식` 구성 요소는 당신의 웹사이트가 양식을 해야 하는 방식을 형성한다. 하지만 저 같은 오래된 개발자들에게는 새로운 개념입니다. JavaScript의 구성요소는 서버측 구성요소가 하지 않는 방식으로 유지되었습니다. 저는 많은 워드프레스 웹사이트에서 제가 한 가장 잘한 일은 템플릿을 다소 자의적인 "포함()" 문장으로 세분하는 것이었습니다. 루비온 레일즈 사이트에서 지역 변수를 몇 개 잡아내는 부분들을 연구했습니다. 이러한 부품은 재사용 가능한 부품을 구축하는 데 유용하지만, 현재 JavaScript 프레임워크가 제공하는 강력한 구성 요소 모델과는 크게 다릅니다.

이러한 모든 맞춤형 구성 요소 생성은 이전에는 없었던 방식으로 저를 사이트 레벨 설계자로 만듭니다. 여기 예가 있습니다. 물론 버튼 구성품도 있습니다. 물론 나는 `아이콘` 부품을 가지고 있다. 카드 구성 요소에 사용할 것입니다. 내 카드 구성요소는 이들을 배치하고 호출하는 그리드 구성요소에 위치합니다. 전체 페이지는 실제로 구성요소로 작성됩니다. Header 구성 요소에는 SearchBar 구성 요소와 UserMenu 구성 요소가 있습니다. 사이드바 구성 요소에는 내비게이션 구성 요소와 광고 구성 요소가 있습니다. 전체 페이지는 단지 구성 요소의 특별한 조합일 뿐이며, 이는 아마도 제가 자바스크립트로 프런트 엔드를 구축하는 데 올인한다고 가정했을 때 URL을 기반으로 할 것입니다. 이제 저는 URL을 직접 다루고 있으며, 기본적으로 전체 사이트의 설계자입니다. [땀이 많이 난다]

내가 말했듯이, 새로운 책임들이 쌓여있어.

콘텐츠 표시를 담당하는 구성 요소는 데이터가 포함된 하드 코딩되지 않은 것이 거의 확실합니다. 템플릿으로 제작되었습니다. 이들은 데이터를 수용하고 해당 데이터를 기반으로 자체 구성하도록 구축됩니다. 옛날에는 이런 종류의 템플릿을 할 때, 데이터가 이미 작업 중인 페이지에 도착했을 것입니다. JavaScript 기반 앱에서는 해당 데이터를 JavaScript에서 가져올 가능성이 높습니다. 아마도 부품이 렌더링되면 내가 `가져올 것`이다. 현재 작업 중인 스택에서는 프런트 엔드가 리액트에 있고, API는 그래프QL에 있으며, 아폴로 클라이언트를 사용하여 데이터를 처리합니다. 반응 구성 요소에서 특수 "후크"를 사용하여 쿼리를 실행하여 필요한 데이터를 가져오고, 데이터를 변경해야 할 때는 또 다른 특수 후크를 사용한다. 그게 누구 짓인지 맞춰봐? 이 데이터 계층 작업을 전문으로 하는 다른 종류의 개발자인가요? 아니요, 프런트 엔드 개발자의 영역이 되었습니다.

데이터에 대해 말하자면, 웹 사이트에서 처리해야 하는 이 모든 다른 데이터는 데이터베이스나 API에서 오지 않습니다. 현재 웹사이트와만 관련이 있는 데이터입니다.

프런트 엔드 개발자들은 오랫동안 그런 상태를 다루어 왔습니다. 하지만 전에 우리를 곤경에 빠뜨린 것은 바로 이런 상태였습니다. 모달 대화 상자는 `<div class="install is-open">과 같은 간단한 수식어 클래스로 열 수 있으며 이 클래스를 전환하는 것은 `.classList.togle(.is-open)`으로 충분히 쉽습니다. 하지만 이것은 순수한 시각적 처리입니다. 페이지에 있는 다른 것들은 어떻게 그 모달의 오픈 여부를 알 수 있죠? DOM에 묻나요? 예전의 많은 jQuery 스타일의 앱에서는 그렇습니다. 어떤 의미에서, DOM은 우리 웹사이트의 "진실의 원천"이 되었다. 이 아키텍처에서 비롯되는 모든 종류의 문제가 있었는데, 이상한 음험한 방식으로 기능을 파괴하는 단순한 이름 변경에서부터 버그 수정을 어렵게 만드는 응용 논리에 대한 어려운 문제까지 다양했다.

프런트엔드 개발자들은 집단적으로 다음과 같이 생각했습니다: 우리가 좀 더 고려된 방식으로 주를 다루면 어떨까? 국가 경영은 개념으로서 하나의 것이 되었다. 자바스크립트 프레임워크 자체는 이 개념을 직접 구축했고, 타사 라이브러리는 그 기반을 닦고 계속해 왔다. 이것은 책임을 확대하는 또 다른 예이다. 누가 국가 관리를 설계합니까? 누가 그것을 시행하고 시행합니까? 다른 역할이 아니라, 프런트 엔드 개발자들입니다.

해야 할 일들의 체크리스트에는 책임감이 확대되어 있지만, 그것을 모두 함께 엮어내는 작업도 해야 한다. 개별 구성요소 수준에서 이 상태를 얼마나 처리할 수 있으며 더 높은 수준으로 처리해야 합니까? 개별 구성 요소 수준에서 얼마나 많은 데이터를 얻을 수 있으며 위에서 얼마나 많은 데이터를 수집해야 합니까? 디자인 자체가 작동하게 됩니다. 이 구성 요소의 스타일링 중 어느 정도 범위를 정해야 하며, 보다 글로벌한 스타일에서 어느 정도 범위를 정해야 합니까?

최근 몇 년간 디자인 시스템이 발전한 것은 놀랄 일이 아니다. 어쨌든 우리는 부품을 만들고 있습니다. 그래서 그것들을 체계적으로 생각하는 것은 자연스러운 일입니다.

설계를 다시 살펴보겠습니다.

![image](https://paper-attachments.dropbox.com/s_6AC52F8D744ABA156A5C151CCEB4CEF78627ECE8A6493E48630C725F70EB7A84_1576625930131_image_processing20190814-21784-1edetsf.png)

많은 새로운 생각들이 시작될 수 있습니다!

이러한 것들은 오늘날 우리가 이미 해야 할 모든 것 외에도 프런트 엔드 개발자들의 영역에 있는 모든 것들입니다. 설계, 의미론, 접근성, 성능 등 모든 것이 그대로 남아 있습니다. HTML, CSS, JavaScript, 그리고 브라우저의 작동 방식에는 여전히 능숙해야 합니다. 프런트 엔드 개발자가 되려면 성장하고 성장하는 데 필요한 기술이 산더미처럼 쌓여야 합니다. 그것은 웹이 커짐에 따른 자연스러운 결과입니다. 더 많은 사람들이 웹을 사용하고 인터넷 접속은 증가한다. 웹 주변의 경제는 성장한다. 브라우저의 기능이 향상됩니다. 웹에서 무엇이 가능한지 기대가 커진다. 이 주변은 축소되는 것이 많지 않다.

우리는 이미 대부분의 프런트 엔드 개발자들이 책임의 총체적인 부분을 알지 못하는 지경에 이르렀습니다. 여전히 많은 개발자들이 디자인 중심적이고 창의적이고 잘 구현된 HTML과 CSS에 뛰어납니다. 심지어 그것을 찾는 채용 게시물도 줄어들고 있습니다.

다른 회사가 설계 시스템을 구축하고 구현할 수 있도록 전문적으로 지원하는 시스템 중심 개발자와 전체 기관이 있습니다. 집에서 가장 많이 느끼는 데이터 중심 개발자가 있어 웹 사이트 전체에 데이터가 흐르고 비즈니스 로직으로 인해 뜨거워지고 무거워집니다. 이러한 모든 사람들이 자신의 명함에 "프런트 엔드 개발자"를 가지고 있을 수 있지만, 그들의 책임과 심지어 그들의 일에 대한 기대는 상당히 다를 수 있습니다. 괜찮아, 이 모든 것에 대해 제때에 얘기할 수 있는 방법을 찾을 수 있을 거야.

사실, 우리가 웹사이트를 만드는 것에 대해 말하는 방식은 지난 10년 동안 많이 바뀌었습니다. 웹 개발에 대한 저의 초기 소개 중 일부는 워드프레스를 통해서였습니다. WordPress는 실행할 웹 서버가 필요하고 PHP로 작성되며 MySQL 데이터베이스에 데이터를 저장합니다. 워드프레스가 진화한 만큼 모든 것은 여전히 똑같다. 우리는 LAMP, 또는 Linux, Apache, MySQL, PHP의 약자를 가진 "stack"에 대해 이야기한다. 전체 스택의 모든 것은 말 그대로 백엔드 기술로 구성됩니다. 프런트 엔드 개발자로서 LAMP에 대한 내용은 나와 관련이 없습니다.

하지만 그 이후로 다른 스택들도 생겨났습니다. 인기 있는 스택은 MONE(Mongo, Express, Angular, Node)입니다. 우리가 어떻게 더 많은 프런트 엔드 기술을 향해 나아가기 시작했는지 주목해 보십시오. Angular는 자바스크립트 프레임워크이기 때문에 이 스택이 인기를 얻으면서 프론트 엔드에 대해서도 스택의 중요한 부분으로 언급하였다. 노드와 익스프레스도 비록 서버측 변종이지만 자바스크립트이다.

노드의 존재는 이 이야기의 큰 부분이다. 노드는 JavaScript와 유사하지 않습니다. 문자 그대로 JavaScript입니다. 이미 자바스크립트에 숙달된 프런트엔드 개발자가 무리 없이 서버측 작업을 할 수 있게 한다.

"서버리스"는 훨씬 더 현대적인 기술 유행어이며, 클라우드 서버에서 작은 코드 조각들을 실행하는 것에 대해 주로 언급하고 있습니다. 대부분의 경우, 이러한 작은 코드 비트는 노드에 있으며 자바스크립트 개발자가 작성한다. 오늘날, 자바스크립트 중심의 프런트엔드 개발자는 서버 없는 기능을 직접 작성하고 있으며, 본질적으로 백엔드 개발자가 될 수 있다. 그들은 스스로를 풀스택 개발자로 생각할 것이고, 그들이 옳을 것입니다.

Shawn Wang은 올해 STAR 또는 Design System, TypeScript, Apollo, React라는 새로운 스택을 위한 용어를 만들었다. 이것은 저에게 놀라운 일입니다. 제가 그 스택을 좋아하기 때문만이 아니라, 스택이 완전히 프런트엔드 기술인 웹 사이트를 구동하는 방법에 대한 이야기이기 때문입니다. 꽤 많이 바뀌었네요.

이 글을 읽으면서 조금 불안하셨다면 사과드립니다. 만약 당신이 이 모든 것들을 이해하는 데 뒤쳐진다고 느낀다면, 당신은 혼자가 아닙니다.

사실, 저는 웹 사이트를 구축하는 전 세계에 대해 전적으로 편안함을 느낀다고 말해준 개발자와는 이야기하지 않은 것 같습니다. 모든 사람들은 약점이나 처음 당기는 것을 모르는 전체 영역을 가지고 있습니다. 전문화 할 수 있을 뿐만 아니라 전문화 하는 것도 꽤 좋은 생각이고, 결국 어느 정도 전문화하게 될 것이라고 생각합니다. 만약 당신이 계획할 행운이 있다면, 당신이 좋아하는 것을 고르세요. 잘 할 수 있을 거예요.

> 인생의 유일한 상수는 변화이다.

– 헤라클리투스
– 동기부여 포스터
– 크리스 코이어