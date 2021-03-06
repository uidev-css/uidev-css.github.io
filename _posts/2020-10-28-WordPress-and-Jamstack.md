---
layout: post
title: "WordPress 및 Jamstack
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/10/wordpress-jamstack-scale.jpg
tags: JAMSTACK,NETLIFY,WORDPRESS
---


저는 최근 Netlify의 가상 Jamstack Conf에서 Netlify CEO Matt Biilman과 Automattic 설립자 Matt Mullenweg를 포함한 패널을 중재했습니다.
 모든 것이 "Jamstack vs. WordPress"대결로 만들어졌습니다.
 

저는 이것에 대해 많은 생각을 가지고 있고 제가 중재자보다 전문가로서 더 유용하다고 생각합니다.
 이것은 지금 제가 기술 분야에서 가장 좋아하는 대화 중 하나입니다!
 그래서 블로그를 할 수 있습니다.
 

공개 : Automattic과 Netlify는 모두이 사이트의 적극적인 후원자입니다.
 두 가지를 모두 사용하는 프로덕션 사이트가 있는데 솔직히이 두 가지를 모두 좋아합니다.이 점을 가장 중요하게 생각합니다.
 나는 또한 이것을 WordPress 사이트에 쓰고 게시하고 있습니다.
 

### 역사
 verified_user

- Richard MacManus는 "WordPress 공동 창립자 인 Matt Mullenweg는 JAMstack의 팬이 아닙니다"를 발표했습니다. Matt는 "JAMstack을 채택한 대다수의 사람들에게 퇴보입니다."라고 말한 이메일 대화 내용을 인용했습니다.
 
- Matt Biilmann은 "Mullenweg와 Jamstack – 회귀 또는 미래?"라는 답변을 게시했습니다.
 "WordPress 시대의 끝"이라는 제목의 전체 섹션이 있습니다.
 
- 사람들은 길을 따라 차를 몰았다.
 Netlify 이사회 멤버 Ohad Eder-Pressman이 공개 서한을 썼습니다.
 Sarah Gooding은 WP Tavern (Matt Mullenweg 소유)의 일부 활동을 정리했습니다.
 나도 끼어 들었다.
 
- Matt Mullenweg는 몇 가지 새로운 zingers로 발언을 명확히했습니다.
 

토론은 10 월 6 일 Jamstack Conf Virtual 2020에서 열렸습니다. 공개 동영상은 없습니다 (죄송합니다).
 

### 스택
 

Jamstack과 WordPress를 비교하는 것은 약간 이상합니다.
 비교 가능한 것은 둘 다 웹 사이트를 구축 할 때 여행 할 수있는 도로라는 사실입니다.
 이 게시물의 대부분은이를 염두에두고 두 가지를 비교합니다.
 직접 비교할 수없는 이유는 다음과 같습니다.
 

- Jamstack은 동적 요구 사항에 대해 CDN 및 JavaScript 액세스 서비스의 정적 파일을 권장하는 아키텍처 철학의 느슨한 설명자입니다.
 
- WordPress는 LAMP 스택의 CMS입니다.
 

그런 것들은 사과와 사과가 아닙니다.
 

우리가 잠시 스택을 고수한다면 비교는 다음과 같습니다.
 

- 정적 호스팅 + 서비스
 
- 램프
 

Static + Services의 예는 Netlify를 호스팅 (정적)에 사용하고 서비스를 사용하여 필요한 동적 작업을 수행하는 것입니다.
 Netlify의 자체 양식 및 인증 기능과 데이터 저장을 위해 Hasura를 사용할 수 있습니다.
 

LAMP 스택에는 데이터를 저장할 MySQL이 있으므로 외부 서비스에 접근 할 수 없습니다.
 PHP도 사용할 수 있습니다.
 따라서 (오픈 소스 소프트웨어 외에도) 인증에 필요한 것이 있습니다.
 서비스를 요청하지 않는다는 의미는 아닙니다.
 이미 보유하고있는 서버에서 더 많은 기술을 손쉽게 사용할 수 있으므로 자주 수행하지 않아도됩니다.
 

Matt B.는 LAMP 스택을 "모놀리스"라고 불렀습니다.
 Matt M.은이 용어에 반대했고이를 "통합 접근 방식"이라고 불렀습니다.
 저는 컴퓨터 과학자는 아니지만 어느 쪽이든 진행되는 것을 볼 수 있습니다.
 다음은 Wikipedia입니다.
 

> […] 모 놀리 식 애플리케이션은 사용자 인터페이스와 데이터 액세스 코드가 단일 프로그램으로 결합 된 단일 계층 소프트웨어 애플리케이션을 설명합니다.
 

그렇게 정의하면 워드 프레스는 모놀리스처럼 보이지만 위키피디아 기사는 계속됩니다.
 

> […] 모 놀리 식 애플리케이션은 모듈화없이 설계된 소프트웨어 애플리케이션을 설명합니다.
 

그런 식으로 보아 WordPress를 단일체로 간주하지 않는 것으로 보입니다.
 WordPress의 후크 및 플러그인 아키텍처는 모듈 식입니다.
 🤷‍♂️
 

이 두 사람이 거기에서 뉘앙스를 파헤치는 것을 듣는 것은 흥미로울 것입니다. 그러나 소프트웨어는 그 자체입니다.
 자체 호스팅 WordPress 사이트는 전체 기술 스택을 사용할 수있는 서버에서 실행됩니다.
 가능한 한 많은 서버에 요청하는 것이 좋습니다 (예 : 통합).
 Jamstack 접근 방식에서 서버는 사용자로부터 추상화됩니다.
 다른 모든 작업은 서로 다른 서비스로 분할됩니다 (예 : 통합되지 않음).
 

WordPress 접근 방식은 외부 서비스에 도달하지 않는다는 의미는 아닙니다.
 두 스택 모두에서 eCommerce API에 Stripe와 같은 것을 사용할 수 있습니다.
 강력한 미디어 저장 및 서비스를 위해 Cloudinary와 같은 것을 찾을 수 있습니다.
 WordPress의 Jetpack 서비스 (내가 사용하고 좋아하는)조차도 타사 서비스처럼 작동하고 자산 호스팅 및 검색 기술과 같은 것을 서버로 이동하여 자체 서버에서 이동함으로써 자체 호스팅 WordPress 사이트에 많은 힘을 제공합니다.
 클라우드 서버에.
 두 스택 모두 기술의 집합체입니다.
 

어느 스택도 다른 스택보다 더 "하우스 오브 카드"가 아니거나 경향이 없습니다.
 모든 웹 사이트에는 "가장 약한 링크만큼만 강하다"는 비유가 적용됩니다.
 WordPress 플러그인이 지루한 버전을 제공하거나 업로드시 어떻게 든 손상된 경우 수정하기 전까지 사이트가 망가질 수 있습니다.
 내 API 키가 내 서버리스 데이터베이스에 대해 유효하지 않게되면 내가 수정할 때까지 내 Jamstack 사이트가 호스로 묶일 수 있습니다.
 Stripe가 다운되면 백업 될 때까지 어떤 종류의 사이트에서도 제품을 판매하지 않습니다.
 

### 가격
 

WordPress.com은 무료 요금제를 제공하며 사이트를 구축 할 수있는 곳입니다.
 (여러 개가 있습니다.)하지만 월 25 달러의 사업 계획을 세우기 전까지는 개발자 스타일의 액세스 권한이 없습니다.
 자체 호스팅 WordPress 자체는 오픈 소스이며 무료이지만 무료로 자체 호스팅 WordPress 사이트를 시작할 수있는 곳을 찾지 못할 것입니다.
 저렴하게 시작하고 확장됩니다.
 WordPress를 실행하려면 LAMP 호스팅이 필요합니다.
 다음은 상당히 저렴한 호스팅 계획을 살펴 봅니다.
 

- "공유"Bluehost 플랜은 월 $ 3.95부터 시작합니다.
 
- Flywheel의 최저 요금제는 월 $ 14입니다.
 (이 사이트는 상위 플라이휠 계획에 있습니다.)
 
- Media Temple에는 월 20 달러부터 시작하는 WordPress 전용 호스팅이 있습니다.
 (이 사이트는 오랫동안 높은 계층의 Media Temple 계획에있었습니다.)
 
- Automattic의 Pressable 서비스에는 월 $ 25부터 시작하는 요금제가 있습니다.
 

방망이에서 바로 관련된 돈이 있습니다.
 

무료로 시작하는 것은 Jamstack에서 훨씬 더 일반적이며 다른 지점에서 비용이 발생합니다.
 Jamstack이 더 새로워졌지만 여전히 스스로 파악하고있는 시장처럼 느껴집니다.
 

- Vercel은 팀 구성원이나 암호로 보호 된 사이트와 같은 기능이 필요할 때까지 무료입니다.
 암호로 보호 된 단일 사이트는 월 $ 150입니다.
 추가 비용없이 Apache가있는 모든 서버에서 기본 인증을 버릴 수 있습니다.
 
- Netlify는 매우 유사하여 더 높은 계획에서 기능을 잠금 해제하고 분석 ($ 9 / 월) 및 인증 (5,000 명의 활성 사용자는 $ 99 / 월)과 같은 사이트 별 기능을 제공합니다.
 
- AWS Amplify는 무료로 시작되지만 AWS의 모든 것과 마찬가지로 구축 시간, 스토리지 및 대역폭과 같은 다양한 수준에서 사용량이 측정됩니다.
 웹 앱에 대한 계산의 예가 일일 활성 사용자가 10,000 명이고 한 달에 두 번 업데이트되며 비용은 한 달에 $ 65.98입니다.
 
- Azure Static Web Apps는 아직 가격을 발표하지 않았지만 거의 확실하게 무료 계층 또는 무료 사용량 또는 어떤 종류가 있습니다.
 

이 모든 것은 Netlify가 Jamstack 게임에서 유일한 것이 아님을 상기시켜줍니다.
 Jamstack은 정적 호스팅과 서비스를 의미합니다.
 

Jamstack이 더 저렴하다고 포괄적으로 말할 수는 없습니다.
 사이트의 사용과 필요에 너무 많이 의존합니다.
 사용량이 많고 프리미엄 서비스가 많은 Jamstack (일반적으로 서버리스와 매우 유사)은 매우 비쌀 수 있습니다.
 Jamstack은 엔터프라이즈 가격이 월 3,000 달러부터 시작하며 인증, 양식 및 미디어 처리와 같은 것을 얻을 수 있지만 CMS 나 데이터 저장소를 얻지 못해 훨씬 더 높은 가격을 책정 할 수 있다고 말합니다.
 

이 워드 프레스 사이트는 기업이 아니지만 월 1,000 달러 근처에 서버가 필요하며 Cloudflare가 호스트로 직접 대역폭을 줄이고 미디어 호스팅과 같은 작업을 처리하는 Jetpack이 그 앞에 있다고 가정합니다.
 및 검색 기능.
 Mailchimp는 뉴스 레터를 보냅니다.
 Wufoo는 우리의 형태를 강화합니다.
 Advanced Custom Fields Pro 및 몇 가지 WooCommerce 애드온과 같은 유료 플러그인도 있습니다.
 그게 다가 아닙니다.
 아마 한 달에 수천 개 정도일 것입니다.
 이는 통합 접근 방식에만 국한되지는 않지만 WordPress 사이트의 비용도 상당히 높을 수 있음을 보여줍니다.
 그들은 가격 (일반적인 기업 전술)을 게시하지 않지만 Automattic의 자체 WordPress VIP 호스팅 서비스는 타사 항목을 추가하기 전에 반드시 4 자리 중반부터 시작됩니다.
 

결론 : 여기에서는 가격에 큰 변화가 없습니다.
 

### 공연
 

웹 성능의 80 %는 프런트 엔드 문제입니다.
 

이는 실화이지만 서버를 기반으로 구축되기도합니다 (처음 20 %를 차지함).
 세계에서 가장 빠른 프런트 엔드는 서버로부터의 첫 번째 요청에 몇 초가 걸리더라도 전혀 빠르다고 느끼지 않습니다.
 빠른 사이트를 원하면 첫 번째 요청이 빠르게 흡연되는지 확인해야합니다.
 

초고속이 뭔지 알아?
 정적 파일을 제공하는 글로벌 CDN.
 이것이 스택에 관계없이 모든 웹 사이트에서 일어나고 싶은 것입니다.
 이것이 Jamstack (정적 CDN 지원 호스팅)의 기초이지만 WordPress가이를 수행 할 수 없다는 의미는 아닙니다.
 

정적 콘텐츠가 포함 된`index.html` 파일을 Netlify에 올리면 빠르게 작동 할 것입니다.
 정적 사이트 생성기가 해당 파일을 만들 수도 있습니다 (이는 WordPress에서 콘텐츠를 가져올 수 있다는 점을 지적 할 가치가 있습니다).
 그 견고 함과 꾸준한 기반에 대해 아주 좋은 점이 있습니다.
 

기본적으로 WordPress는 전역 CDN에서 캐싱 할 수있는 정적 파일을 만들지 않습니다.
 WordPress는 단일 출처의 요청에 응답하고 PHP를 실행하여 응답을 수집하기 전에 데이터베이스에 물건을 요청한 다음 마지막으로 페이지를 반환합니다.
 속도는 상당히 빠르지 만 글로벌 CDN의 정적 파일보다 훨씬 덜 견고하며 요청을 압도하기가 훨씬 쉽습니다.
 

WordPress 호스트는이를 알고 있으며 호스팅 수준에서 문제를 해결하려고합니다.
 WP Engine의 접근 방식을 살펴보십시오.
 아무것도하지 않고 페이지 캐시를 사용하므로 사이트가 PHP를 실행하거나 데이터베이스에 접속할 필요없이 기본적으로 정적 자산을 반환 할 수 있습니다.
 가능한 최상의 캐싱을 수행하기 위해 Cloudflare와의 제휴를 포함하여 모든 종류의 다른 캐싱도 사용합니다.
 이 글을 쓰는 동안 내 shoptalkshow.com 사이트가 말 그대로 다운되었습니다.
 나는 진행자 플라이휠 (Flywheel)에게 편지를 썼다.
 스테이징 사이트를 켜기 위해 거기에 갔을 때 잘못된 스위치를 켜고 캐싱을 끄는 것으로 나타났습니다.
 사이트는 트래픽을 처리 할 수 없어서 죽었습니다.
 캐싱 스위치를 다시 켜면 즉시 해결되었습니다.
 사이트 앞에 Cloudflare가 없었지만 있어야합니다.
 

Cloudflare는 WordPress를 빠르게 만드는 마법 소스의 일부입니다.
 자체 호스팅 WordPress 사이트 앞에 두는 것만으로도 빠르고 안정적으로 만드는 데 많은 노력을 기울일 것입니다.
 누락 된 부분 중 하나는 HTML 자체의 훌륭한 캐싱이었습니다. HTML 자체는 문자 그대로 이번 달에 처리했으며 지금은 캐싱도 가능합니다.
 WordPress 캐싱은 요청을 정적 HTML 및 정적 자산으로 캐싱하고 글로벌 CDN에서 서비스를 제공하는 것을 의미한다는 점에서 재미있는 아이러니가 있습니다.
 

Matt M.은 WordPress.com이 특정 수준의 트래픽에서 시작되는 글로벌 CDN을 사용한다고 언급했습니다.
 Cloudflare인지 아닌지는 모르겠지만 의심하지 않습니다.
 

WordPress 사이트 앞에 Cloudflare를 사용하면 Cloudflare가없는 Netlify 사이트에서와 동일한 첫 번째 응답 숫자를 볼 수 있습니다 (Netlify에서 호스팅하는 사이트 앞에서 Cloudflare를 사용하는 것은 권장하지 않기 때문입니다).
 2 자리 중반 밀리 초 숫자입니다. 매우 훌륭합니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/10/Screen-Shot-2020-10-20-at-8.36.39-AM.png?resize=687%2C68&ssl=1)

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/10/Screen-Shot-2020-10-20-at-8.37.27-AM.png?resize=687%2C73&ssl=1)

그 토대에서 성능에 대한 모든 논의는 프런트 엔드에 따라 달라집니다.
 속도에 대한 프런트 엔드 전술은 서버, 호스팅 또는 CMS 상황이 백 엔드에 있더라도 동일합니다.
 

### 보안
 

Jamstack 사이트보다 WordPress 사이트가 해킹 당했다는 이야기가 훨씬 더 많습니다.
 그러나 WordPress가 덜 안전하다고 말하는 것이 공평합니까?
 WordPress는 수십 년의 역사를 가지고 있으며 Jamstack보다 몇 배 더 많은 사이트를 구축했습니다.
 보안은 제쳐두고 WordPress에서이 숫자로 더 많은 스토리를 얻을 수 있습니다.
 

Matt M은 whitehouse.gov가 WordPress에 있으며, 이는 분명히 최고 수준의 보안을 필요로하는 사이트라고 말했습니다.
 WordPress 자체가 안전하지 않은 소프트웨어는 아닙니다.
 그것은 당신이 그것으로하는 일입니다.
 안전하지 않은 암호가 있습니까?
 어떤 플랫폼을 사용하든 안전하지 않습니다.
 파일 권한이나 액세스 수준을 통해 서버 자체가 안전하지 않습니까?
 그것은 정확히 소프트웨어의 잘못은 아니지만 소프트웨어 때문에 그 위치에있을 수 있습니다.
 최신 버전의 WordPress를 실행하고 있습니까?
 사용은 기껏해야 세분화되어 있으며 이전 버전 일수록 보안 수준이 떨어집니다.
 교활한.
 

보안 벡터에 대해 생각하는 것이 더 흥미로울 수 있습니다.
 즉, 어떤 지점에서 해킹을 당할 수 있습니다.
 정적 호스팅에 정적 파일이있는 경우 공격 벡터가 거의 없다고 말하는 것이 안전하다고 생각합니다.
 그러나 여전히 몇 가지가 있습니다.
 

- 호스팅 계정이 해킹되었을 수 있습니다.
 
- Git 저장소가 해킹 당할 수 있습니다.
 
- Cloudflare 계정이 해킹되었을 수 있습니다.
 
- 귀하의 도메인 이름이 도용 될 수 있습니다.
 

WordPress 사이트에서도 마찬가지입니다. 다음과 같은 추가 공격 벡터 만 있습니다.
 

- 서버 측 코드 : XSS, 잘못된 플러그인, 원격 실행 등
 
- 데이터베이스 취약성
 
- 오래된 버전의 WordPress 실행
 
- 로그인 시스템은 사이트 자체에 있습니다.
 나쁜 사람들은`/ wp-login.php`를 망치질 수 있습니다.
 

WordPress 사이트에 더 많은 공격 벡터가 있다고 말하는 것이 타당하다고 생각하지만 모든 사이트에는 많은 벡터가 있습니다.
 모든 사이트의 호스팅 계정은 큰 벡터입니다.
 DNS 체인에있는 모든 것.
 로그인이있는 모든 타사 서비스.
 API 키가있는 모든 것.
 

개인적인 경험 :이 사이트는 WordPress에 있으며 해킹 된 적이 없지만 시도가 부족하지는 않았습니다.
 정적 사이트 생성기로만 구축 된 사이트보다 WordPress 사이트의 보안에 대해 더 많이 생각해야 할 것 같습니다.
 

### 스케일링
 

두 방법 중 하나를 확장하려면 비용이 듭니다.
 이 WordPress 사이트는 대규모로 확장되지는 않지만 보급형 서버 요구 사항에서 적절한 확장이 필요합니다.
 저는 Cloudflare를 통해 모든 트래픽을 처리하므로 지난 30 일의 최고치는 한 달에 5TB의 대역폭을 제공한다는 것을 의미합니다.
 

Netlify Business 계획 (99 달러에 600GB의 트래픽, 추가 100GB 당 20 달러)에서 계산하면 979 달러가됩니다.
 이 사이트에 월 $ 1,000 정도의 서버가 필요하다고 말했던 것을 기억하십니까?
 이 숫자를 실행하기 전에 썼기 때문에 매우 가까웠습니다.
 이 사이트의 규모에서 Jamstack 대 WordPress는 꽤 목이 맞습니다.
 모든 호스트는 대역폭에 대해 요금을 부과하고 초과 요금에 대한 제한이 있습니다.
 Amplify는 월 15GB 한도에 대해 GB 당 0.15 달러를 청구합니다.
 Flywheel (내 WordPress 호스트)은 월간 방문자 한도를 기준으로 요금을 부과하며 그 이상은 1000 당 $ 1입니다.
 

WordPress 확장에 대한 이야기는 다음과 같습니다.
 

- 이를 처리 할 수 있고 자체적으로 입증 된 캐싱 전략이있는 호스트를 사용하십시오.
 
- 모든 것을 CDN합니다 (일반적으로 Cloudflare를 앞에 두는 것을 의미 함).
 
- 궁극적으로 비용을 지불하게됩니다.
 

Jamstack 확장의 이야기는 다음과 같습니다.
 

- 호스트와 서비스는 확장 가능하도록 구축되었습니다.
 
- 이 서비스가이 문제를 처리 할 수 있는지, 아니면 이동해야하는지 측면에서 축소에 대해 생각해야합니다.
 
- 모든 서비스의 모든 측면에 주시해야하는 가격 책정이 적용된다는 점에서 확장에 대해 생각해야합니다.
 
- 궁극적으로 비용을 지불하게됩니다.
 

WordPress 호스팅을 약간 이동하여 사이트의 현재 요구 사항과 일치하는 호스트를 찾아야했습니다.
 WordPress 사이트를 이동하는 것은 사소한 일이 아니지만 다른 CMS로 이동하는 것보다 훨씬 쉽습니다.
 예를 들어 너무 비싸게되는 헤드리스 CMS에 Jamstack 사이트를 구축하는 경우 호스트를 전환하는 것보다 이동 비용이 더 큽니다.
 

나는 Dave Rupert가 두 사람의 성능을 비교하는 것에 대해 (Slack 대화에서) 쓴 글을 좋아합니다.
 

> Jamstack : 무엇이든 사용하여 제작하고, 도움이되는 애드온이 있으며, 무너지지 않도록 CDN에 배포하는 데 사용하세요.
워드 프레스 : 우리 물건을 사용하여 물건을 만들고, 도움이되는 애드온이 있으며, 넘어지지 않도록 특정 호스트를 사용해야합니다.
 

다른 종류의 "확장"도 있습니다.
 저는 사용자 수와 같은 것을 생각합니다.
 이는 모든 종류의 서비스가 가격 책정 계층에 사용하는 것으로 이해할 수있는 측정 항목입니다.
 하지만 WordPress에서는 무료입니다.
 원하는만큼 미묘한 권한을 가진 많은 사용자를 가질 수 있습니다.
 이는 CMS 일 뿐이므로 다른 서비스를 추가하면 여전히 비용이 청구될 수 있습니다.
 Vercel 또는 Netlify는 팀 계정에 대해 책임자가 청구합니다.
 Contentful (인기있는 헤드리스 CMS)은 팀의 경우 월 $ 489부터 시작합니다.
 무료 계정으로는 할 수없는 일이 필요한 경우 GitHub의 팀 등급도 사용자 당 4 달러입니다.
 

### 앞뒤 분할
 

이것은 사람들이 Jamstack으로 구축하는 것에 대해 흥분하게 만드는 큰 요소 중 하나입니다.
 내 사이트의 모든 기능과 콘텐츠가 API 뒤에있는 경우 원하는대로 구축 할 수있는 프런트 엔드를 확보 할 수 있습니다.
 

- 모든 정적 사이트를 만들고 싶습니까?
 좋아, 빌드 프로세스 중에 해당 API를 누르고 수행하십시오.
 
- React 또는 Vue 등으로 클라이언트 렌더링 사이트를 구축하고 싶습니까?
 좋아, API 클라이언트 측을 누르십시오.
 
- 중간을 분할하고 일부는 미리 렌더링하고 일부는 클라이언트에서 렌더링하고 일부는 서버에서 렌더링하고 싶습니까?
 멋집니다. API이므로 원하는대로 사용할 수 있습니다.
 

이러한 유연성은 그린 필드 빌드에서 깔끔하지만 사람들은 이론적 미래 유연성에 대해서도 흥분합니다.
 모든 기능과 콘텐츠가 API 기반이라면 전면과 후면을 완전히 분리 한 것입니다. 즉, 앞으로 더 유연하게 변경할 수 있습니다.
 

- API가 프런트 엔드가 기대하는 것을 계속 뱉어내는 한 프런트 엔드 문제없이 백 엔드를 다시 설계 할 수 있습니다.
 
- 필요한 데이터를 얻는 한 백엔드 문제없이 프런트 엔드를 다시 설계 할 수 있습니다.
 

이러한 종류의 분할은 특정 크기와 규모의 사이트에 대해 "미래에 안전"하다고 느낍니다.
 스케일 번호가 무엇인지 손가락을 댈 수는 없지만 거기에 있습니다.
 

한 쪽 또는 다른 쪽을 수용하기 위해 주요 사이트 재 아키텍처를 수행 한 적이 있다면 백엔드와 프런트를 분리 한 시스템으로 이동하는 것이 현명한 움직임처럼 느껴질 것입니다.
 

WordPress 사이트를 분할 할 수 있지만 ( `둘 다 사용하기`섹션에서 다룰 것입니다) 기본적으로 WordPress는 매우 WordPress 전용 API를 사용하여 PHP의 테마로 프런트 엔드를 구축하는 통합 접근 방식입니다.
 전혀 분할되지 않습니다.
 

### 개발자 경험
 

Jamstack은 개발자 경험 (DX)의 우선 순위를 매우 높게 지정하는 일을 훌륭하게 수행했습니다.
 누군가가 이것을 "지역 최적"이라고 부르는 것을 들었습니다. 즉, Jamstack은 지역 개발 (및 지역 개발자) 경험을 중심으로 설계되었습니다.
 

- 현지에서 일해야합니다.
 자신 만의 편안한 (로컬, 빠른, 맞춤형) 개발 환경에서 작업합니다.
 
- 힘내는 일류 시민입니다.
 프로덕션 브랜치 (예 :`master` 또는`main`)로 푸시하면 빌드 프로세스가 실행되고 사이트가 배포됩니다.
 모든 풀 리퀘스트에 대한 프로덕션 사이트의 미리보기 URL도 얻을 수 있습니다. 이는 인상적인 기능입니다.
 
- 원하는 도구를 사용하십시오.
 Hugo에서 사이트를 사전 구축하고 싶습니까?
 그것을 위해 가십시오.
 학교에서 `create-react-app`을 배웠나요?
 그것을 사용하십시오.
 멋진 새 프레임 워크로 실험하고 싶으세요?
 그것을 가져라.
 빌드를 실행하고 원하는 저장소의 폴더를 배포 할 수 있다는 사실을 활용하여 원하는대로 빌드 할 수있는 많은 자유가 있습니다.
 
- 하지 않아도되는 것도 중요합니다.
 HTTPS를 다룰 필요도없고 캐싱을 다룰 필요도없고 파일 권한에 대해 걱정할 필요도없고 CDN을 구성 할 필요도 없습니다.
 고급 개발자조차도 적은 일을해야한다는 점을 높이 평가합니다.
 

WordPress가 개발자 경험을 고려하지 않는 것은 아니지만 (예를 들어 CLI가 있고 스캐 폴드 블록과 같은 유용한 작업을 수행 할 수 있음) DX는 나에게 프로젝트의 핵심이라고 생각하지 않습니다.
 

- WordPress를 로컬에서 실행하는 것은 까다롭기 때문에 악명 높은 타사 소프트웨어와 관련된 (X) AMP 스택을 실행해야합니다.
 Flywheel의 Local에 감사드립니다.
 몇 가지 지침이 있지만 우선 순위가 아닌 것 같습니다.
 
- Git에서 무엇을해야합니까?
 지금까지도 잘 모르겠지만 주로`/ wp-content` 폴더 전체를 정해 놓았습니다.
 지침이나 명백한 모범 사례가 없다는 것이 나에게 이상하다고 느낍니다.
 
- 배포는 전적으로 혼자서 할 수 있습니다.
 WordPress 전용 호스트조차도 여기에 못 박히지 않습니다.
 대체로 다음은 SFTP 사용자 인증 정보입니다.
 
- 좋은 로컬 개발 및 배포 파이프 라인이 설정되어 있어도 (저는 만족합니다) 데이터베이스 이동을 처리하는 데 실제로 도움이되지 않으므로 거기에서도 스스로 할 수 있습니다.
 

이것들은 모두 해결할 수있는 것들이고 워드 프레스 커뮤니티는 너무 커서 그것에 대한 많은 정보를 찾을 수있을 것입니다.하지만 저는 워드 프레스가 DX를 핵심으로 가지고 있지 않다고 말하는 것이 타당하다고 생각합니다.
 오랜 세월이 지난 후에도 약간 거친 서부입니다.
 

사실 건강한 지역 개발 환경에 대한 장려가 너무 부조리해서 많은 사람들이 전혀 갖고 있지 않다는 것을 알게되었습니다.
 이것은 일화이지만 이제는 완전히 프로덕션 전용으로 작동하는 다른 사람들의 사이트에 참여한 지 두 배가되었습니다.
 대부분의 기본 동작을 가진 매우 단순한 사이트라면 그것은 하나 일 것이지만, 이것들은 아무것도 아닙니다.
 공개 사용자 로그인, 유료 멤버십 및 권한, 페이지 빌더, 사용자 정의 단축 코드, 사용자 정의 CSS 및 수많은 움직이는 부분과 관련된 매우 복잡합니다 (이 사이트보다 훨씬 더 많음).
 그것은 나를 죽음에 이르게했다.
 나는 아무것도 만지고 싶지 않았습니다.
 사람들이 농담으로 부르는 것처럼 그들은 일을 작동시키기 위해 PHP를 라이브 편집하고있었습니다.
 하나의 구문 오류와 사이트가 꽉 차서보고있는 바로 그 페이지 일 수도 있습니다.
 

특히 좋은 DX없이 WordPress가 웹의 거대한 범위를 지원한다는 사실은 매우 흥미 롭습니다.
 DX 없이는 Jamstack이 없습니다.
 전적으로 개발자 중심의 것입니다.
 WordPress를 사용하면 대부분의 사이트에 개발자가 전혀 없을 것입니다.
 설치 (또는 WordPress.com의 경우 활성화)되고 사이트 소유자가 여기에서 가져옵니다.
 사이트 소유자는 많은 권한을 가지고 있지만 코드를 전혀 작성하지 않는다는 점에서 개발자와 같습니다.
 

이를 위해 WordPress가 DX보다 UX에 훨씬 더 중점을두고 있다고 말하고 싶습니다. 이는이 모든 것의 큰 부분입니다.
 

### CMS 및 최종 사용자 UX
 

WordPress는 망할 훌륭한 CMS입니다.
 마음에 들지 않더라도 그렇게하는 사람은 엄청나게 많고 숫자는 스스로를 대변합니다.
 WordPress로 사이트를 구축하기로 결정했을 때 얻을 수있는 것은 원하는 거의 모든 종류의 사이트를 구축 할 수있는 능력을 제공하는 것입니다.
 워드 프레스를 사용하여 구석 구석에 자신을 그려 넣은 그런 문제가있을 것 같지 않습니다.
 

그것은 큰 문제입니다.
 Jenn은 WordPress를 사용하는 사람들이 개발자의 요구 사항보다 더 큰 이야기라는 점을 지적하면서이 문제를 지적했습니다.
 

WordPress는 다음과 같은 일을 할 수 있습니다.
 

- 블로그 (또는 모든 유형의 콘텐츠 기반 CMS 스타일 사이트)…
Jamstack에서는 가능하지만 까다로운 콘텐츠 미리보기
 
- Jamstack에서는 가능하지만 까다로운 콘텐츠 미리보기
 
- 사용자 / 권한 처리…
관리자 / CMS 수준에서
전방을 향한 수준 (예 : 포럼, 구독, 소셜 등)
 
- 관리자 / CMS 수준에서
 
- 전방을 향한 수준 (예 : 포럼, 구독, 소셜 등)
 
- 전자 상거래
 
- 프로세스 양식
 
- 달과 뒤로 플러그인 처리
 

Jamstack은 이러한 모든 작업을 절대적으로 수행 할 수 있지만 이제는 Wild West 영역에있는 Jamstack입니다.
 데이터 저장 방법에 대한 자습서를 볼 때 종종 클라우드 데이터베이스에 대한 개별 CRUD 함수를 작성하는 방법을 설명하는 내용이 포함됩니다.
 그것은 매우 강력 할 수있는 금속 재료에 달려 있지만 몇 개의 버튼을 클릭하는 것과는 거리가 멀다. WordPress가 많은 시간을 느끼는 것처럼 느껴진다.
 

Stripe API와 함께 기본적인 Jamstack eCommerce 설정을 조합 할 수있을 것입니다. 매우 멋집니다.
 하지만 재고 관리, 배송 지역, 제품 변형에 대해 생각할 필요가있을 때 긴장하고 전자 상거래 분야에서 복잡 해지는 다른 것이 무엇인지 누가 알 수 있습니다.
 .
 

때때로 우리 개발자는 우리만을위한 사이트를 구축하지만 (저는 공정한 몫보다 더 많은 일을합니다) 개발자들은 대부분 다른 사람들을 위해 사이트를 구축하고 있다고 말하고 싶습니다.
 그래서 가장 중요한 질문은 내가 그것을 구축하는 사람들에게 힘을 실어주는 무언가를 만들고 있는가?
 

어떤 일이 있어도 좋은 사이트 관리자 경험을 얻을 수 있지만 WordPress는 사용자 지정 개발 측면에서 크게 묻지 않고 해당 부서에서 제공한다는 것을 확실히 입증했습니다.
 

Jamstack에는 내가 WordPress에서 풀고 싶은 몇 가지 트릭이 있습니다.
 저에게 큰 문제는 사용자가 제출 한 콘텐츠와 업데이트입니다.
 나는 말 그대로 이것으로부터 혜택을받는 3 개의 웹 사이트를 가지고있다.
 컨퍼런스에 대한 사이트, 서버리스에 대한 사이트 및 글꼴 코딩에 대한 향후 사이트입니다.
 WordPress는이 세 사이트 모두에서 절대적으로 훌륭한 일을 할 수있었습니다.
 하지만 제가 정말로 원하는 것은 사람들이 제가 할 수있는 방식으로 콘텐츠를 업데이트하고 제출할 수 있도록하는 것입니다. 예, 좋아 보인다, 합쳐집니다.
 Jamstack 접근 방식을 사용함으로써 콘텐츠는 공개 GitHub 저장소에 있으며 누구나 참여할 수 있습니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/10/Screen-Shot-2020-10-20-at-3.53.48-PM.png?resize=501%2C455&ssl=1)

정말 대단하다고 생각합니다.
 Netlify CMS에는 편집을위한 UI를 사용하여 브라우저에서 전체 기여 경험을 유지하는 개방형 저작이라는 개념이 있으므로 일반 대중이 Git 또는 GitHub를 알고 있거나 이해해야하는 것은 아닙니다.
 

### 둘 다 사용
 

이것은 내가 많이 자란 것을 보는 큰 것입니다.
 Netlify조차도 "대결이 없습니다"라고 말합니다.
 

거래는 다음과 같습니다.
 

- "Jam"의 "A"는 API를 의미합니다.
 API를 사용하여 빌드시 또는 클라이언트 측에서 사이트를 빌드하십시오.
 
- 기본적으로 WordPress 사이트에는 REST API가 있습니다 (GraphQL API도 포함 할 수 있음).
 
- 따라서 Jamstack 사이트에서 CMS 데이터 용 API를 누르세요.
 

네, 완전히 요.
 이것은 작동하고 사람들은 그것을합니다.
 꽤 멋지다고 생각합니다.
 

그러나…
 

- Jamstack 사이트 외에 다른 곳에서 WordPress 사이트를 운영한다는 것은 Jamstack 사이트 외에 WordPress 사이트를 운영한다는 의미입니다.
 여기에는 비용과 기술적 부채가 있습니다.
 
- 종종 WordPress의 모든 가치를 얻지 못합니다.
 데이터 용 API를 사용하는 것만으로도 충분할 수 있지만 이것은 WordPress 테마를 구축하는 것과는 매우 다른 방식으로 사이트를 구축하는 것입니다.
 WordPress의 다른 가치를 얻지 못합니다.
 다음과 같은 상황을 생각합니다. 사이트에 멋진 Gutenberg 블록을 추가하는 깔끔한 플러그인을 찾습니다.
 이는 WordPress 사이트에서 "그냥 작동"할 수 있지만 API에서 HTML을 빨아들이는 것이라면 작동하지 않는 특별한 프런트 엔드 동작이있을 수 있습니다.
 프런트 엔드가 호스팅되는 위치를 통합하는 방법을 파악하고 업데이트를 유지하기 위해 직접 수행 할 몇 가지 추가 스크립트 및 스타일을 대기열에 추가 할 수 있습니다.
 

다음은 모두 "둘 다 사용"하는 고유 한 접근 방식을 가진 일부 플레이어입니다.
 

- Frontity : WordPress 용 React 프레임 워크.
 WordPress 사이트 외에도 Node 서버를 사용하여 실행합니다.
 Node 서버는 React를 HTML로 렌더링하므로 모든 페이지에 대한 서버 측 렌더링을 얻지 만 여전히 SPA를 구축하고 있습니다.
 
- WP2Static : 사이트의 정적 버전을 구축하고 변경시 자동 배포 할 수있는 WordPress 플러그인입니다.
 
- Strattic : 그들은 당신을 위해 동적 워드 프레스 사이트 ( "스테이징"이라고 함)를 호스팅하고 당신은 워드 프레스에서 정상적으로 작업합니다.
 그런 다음 배포를 선택하면 사이트의 정적 버전도 호스팅됩니다.
 
- Shifter : Shifter는 WordPress 사이트를 호스팅합니다.
 두 가지 옵션이 있습니다. 1) 헤드리스로 실행 (따라서 데이터의 경우 API, REST 또는 GraphQL에 연결) 또는 2) 정적으로 실행 (원하는 곳에 WordPress에 모든 것이있을 때 배포,
 사이트의 정적 버전을 생성하여 호스팅하거나 Netlify와 같은 다른 곳으로 푸시 할 수 있습니다.
 

둘 다 통합하는 다른 방법이 많이 있습니다.
 여기 Geoff와 Sarah가 REST API와 함께 Vue / Nuxt를 사용하고 Netlify에서 호스팅하여 WordPress와 Jamstack을 함께 사용하는 방법에 대해 이야기합니다.
 

### 둘 다 사용하지 않음
 

이것이 명확하지 않은 경우를 대비하여 웹 사이트를 구축하는 방법은 절대적으로 많습니다.
 Ruby on Rails 사이트를 구축하는 경우 Jamstack이나 WordPress가 아닙니다.
 서버가 필요하고 가능한 한 많은 작업을 수행하기 위해 해당 서버를 사용한다는 점에서 WordPress 사이트와 비슷하다고 주장 할 수 있습니다.
 정적 호스팅은 아니지만 API를 사용하고 서비스를 함께 연결하도록 장려한다는 점에서 Jamstack과 더 비슷하다고 주장 할 수도 있습니다.
 

웹은 큰 공간, 갱단이며 이것은 제로섬 게임이 아닙니다.
 웹 자체가 성장하고 있기 때문에 WordPress가 계속 성장하고 Jamstack이 계속 성장할 것으로 기대합니다.
 우리가 시장 점유율의 비율만을 고려하더라도, 둘 다 성장하여 다른 것은 더 작은 조각으로 밀어 낼 것이라고 확신합니다.
 

### 고르는
 verified_user

나는 여기에 가지 않을 것입니다.
 좋아하는 게임을 피해서가 아니라 필요하지 않기 때문입니다.
 웹 사이트 구축을 위해 WordPress 또는 Jamstack 접근 방식 중 하나를 결정하려고 손톱을 물어 뜯는 개발자를 보지 못했습니다.
 우리는 프로세스가 다음과 같이 진행될만큼 기술이 충분히 이해되고있는 시점에 있습니다.
 

- 성인용 바지 입기
 
- 요구 사항 및 결과 평가
 
- 기술 선택
 