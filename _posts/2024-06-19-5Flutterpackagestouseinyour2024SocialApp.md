---
title: "2024년 소셜 앱에서 사용할 5가지 플러터 패키지"
description: ""
coverImage: "/assets/img/2024-06-19-5Flutterpackagestouseinyour2024SocialApp_0.png"
date: 2024-06-19 08:03
ogImage: 
  url: /assets/img/2024-06-19-5Flutterpackagestouseinyour2024SocialApp_0.png
tag: Tech
originalTitle: "5 Flutter packages to use in your 2024 Social App"
link: "https://medium.com/@kanellopoulos.leo/5-flutter-packages-to-use-in-your-2024-social-app-20082ed8a42d"
---


패키지에 대한 다른 기사가 나왔네요. 이번에는 소셜 앱을 만들 때 선호하는 패키지를 공유하려고 해요. 회사에서는 사용자 간 상호 작용이 최소한인 작은 앱부터 완전한 소셜 네트워크까지 다양한 소셜 앱을 개발했어요. 소셜 앱을 만드는 것은 도전적일 수 있지만 사용자 사이의 직접적인 상호 작용을 항상 즐기며 앱이 어떻게 발전하는지 바뀌는 것을 관찰하는 것을 즐겨요.

그런 의미에서, 소셜 앱을 만들 때 선호하는 패키지를 살펴보겠어요.

- getstream.io — 활동 피드

![2024-06-19-5Flutterpackagestouseinyour2024SocialApp_0.png](/assets/img/2024-06-19-5Flutterpackagestouseinyour2024SocialApp_0.png)

<div class="content-ad"></div>

많은 사람들이 이 멋진 라이브러리/서비스를 이미 알고 있을 것이라고 확신합니다. 이 라이브러리는 몇 가지 인기있는 Flutter 앱에서 사용되고 있습니다. Stream (또는 getstream)은 모든 것을 처음부터 만들 필요 없이 앱용 소셜 피드/활동 피드를 구축하는 데 도움이 되는 패키지를 제공합니다. 이 패키지에는 좋아요, 댓글, 반응, 게시된 링크에 대한 자동 미리보기, 알림 및 앱에 필요한대로 피드를 표시하기 위한 사용자 정의 랭킹 시스템도 포함되어 있습니다.
피드에 대한 시스템은 일반적으로 직접 만듭니다. 그러나 getstream을 빠른 대안으로 사용할 수 있는 옵션을 갖는 것은 매우 환영할 만한 일입니다. 더욱 좋은 점은, 앱이 소규모이고 수익이 적다면, 서비스 전체가 무료*입니다(신청 후 며칠 후에 연락이 옵니다).
패키지를 확인하려면 여기를 클릭하세요.

---

마크다운 형식으로 변환된 텍스트입니다.너와 나는 getstream과 전혀 관련이 없다. 저는 앱을 개발할 때 사용하는 도구에 대한 솔직한 의견을 전하고 있습니다.

<div class="content-ad"></div>

3. flutter_reaction_button

![flutter_reaction_button](/assets/img/2024-06-19-5Flutterpackagestouseinyour2024SocialApp_1.png)

Flutter Reaction Button은 여러분이 직접 만든 Activity 피드(스트림을 사용하지 않고 모든 것을 처음부터 만든 경우)에서 Reactions을 제공할 수 있게 해주는 패키지입니다. 사용자 정의가 가능하며 여러분의 반응 이모티콘을 사용하여 버튼을 만들 수 있습니다.

사용법은 매우 간단합니다:

<div class="content-ad"></div>

```js
ReactionButton<String>(
    onReactionChanged: (Reaction<String>? reaction) {
        debugPrint('선택된 값: ${reaction?.value}');
    },
    reactions: <Reaction<String>>[
        Reaction<String>(
            value: 'like',
            icon: widget,
        ),
        Reaction<String>(
            value: 'love',
            icon: widget,
        ),
        ...
    ],
    initialReaction: Reaction<String>(
        value: 'like',
        icon: widget,
    ),
    selectedReaction: Reaction<String>(
        value: 'like_fill',
        icon: widget,
    ),
)
```

해당 패키지를 확인할 수 있습니다.

4. chat_bubbles

getstream을 사용하여 채팅/메시징 시스템을 구축할 수 있지만, 많은 사람들(저 포함, 앱에 따라 다름)은 자체 시스템을 구축하는 것을 선호할 수 있습니다. chat_bubbles 위젯은 Whatsapp 및 다른 인기있는 앱과 유사한 메시징 시스템을 위한 간단한 Bubble UI를 제공합니다.

<div class="content-ad"></div>

이는 텍스트, 이미지, 오디오 및 날짜를 위한 버블을 포함하고 있습니다. 그뿐만 아니라, 사용할 준비가 끝난 메시지 바도 제공되어서 만들고 싶은 채팅 UI에 신경 쓸 필요 없이 다른 작업에 집중할 수 있습니다. Firebase Firestore와 함께 빠른 메시지 시스템으로 사용할 수 있습니다.

이 패키지를 여기에서 확인할 수 있습니다.

5. any_link_preview

Any Link Preview는 이름에서 알 수 있듯이 정확히 그 역할을 합니다. URL이 게시된 경우(예: 사용자 활동 피드나 메시지 시스템 등), 앱은 Medium, Facebook 또는 기타 앱에서 발생하는 것과 동일한 미리보기를 생성합니다. 이 패키지는 Open Graph, Twitter Cards, JSON 등에서 메타데이터를 가져오는 것을 지원하며, 이전에 설명한 linkfy_text 패키지와 동일한 방식으로 사용됩니다. Text()를 AnyLinkPreview()로 대체하십시오. 위젯도 매우 사용자 정의가 가능하여 UI 요구 사항에 맞게 조정할 수 있습니다.

<div class="content-ad"></div>

예시:

```js
AnyLinkPreview(
    link: "https://vardaan.app/",
    displayDirection: UIDirection.uiDirectionHorizontal,
    showMultimedia: false,
    errorBody: '내 맞춤 오류 본문 표시',
    errorTitle: '내 맞춤 오류 제목 표시',
    errorWidget: Container(
        color: Colors.grey[300],
        child: Text('앗싸!'),
    ),
    errorImage: "https://google.com/",
    cache: Duration(days: 7),
    onTap: (){}, // 탭 이벤트 비활성화
)
```

5+1. insta_image_viewer

이 플러그인은 소셜 앱에 엄격히 제한되지는 않지만 많은 앱에서 사용되었습니다. 이를 사용하면 인스타그램과 같이 이미지를 전체 화면에 표시하는 간단한 위젯에 액세스할 수 있습니다. 이미지를 확대 및 축소하고 닫기를 스와이프할 수 있습니다. 사용자 아바타, 갤러리 이미지 또는 기타 용도로 사용할 수 있습니다.

<div class="content-ad"></div>

예시:

```js
SizedBox(
  width: 100,
  height: 140,
  child: InstaImageViewer(
    child: Image(
      image: Image.network("https://picsum.photos/id/507/1000").image,
    ),
  ),
),
```

우리 팀이 소셜 앱을 개발할 때 가장 일반적으로 사용하는 패키지들입니다. 기존 앱에서 이미 사용자가 알고 있는 기능을 제공하기 때문에 사용하기 편리합니다. 여러분이 소셜 앱 개발에 사용하는 패키지가 있다면 댓글로 알려주세요.

다음 글에서는 코드를 구성하는 방법에 대한 시리즈를 이어가며, 다음 글에서는 스타일과 에셋을 구성하는 방법에 대해 이야기할 예정이니 많은 기대 부탁드립니다. 아직 이 내용을 읽지 않으셨다면, 이전 이야기를 방문해보세요:

<div class="content-ad"></div>

다음에 또 만나요! Flutter를 즐기세요.