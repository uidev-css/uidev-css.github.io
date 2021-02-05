---
layout: post
title: "프로그램적으로 이모티콘 피부톤 변경"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/09/emoji-skin-tone-modifiers.jpg
tags: EMOJI
---


그렇다면, 여러분은 얼마나 많은 이모지가 다른 피부톤을 가지고 있는지 알고 있나요? 이모티콘 피부톤은 특히 텍스트나 소셜 미디어에서 매우 인기가 있다. 검은 주먹 이모지(✊🏿)는 이모피디아의 월드 이모지 어워드에서 "The Most 2020 Emoji"로 선정되었다.

각 톤은 수식어이며 많은 이모티콘들은 특정 문자에 매핑되는 수식어와 기본 인코딩으로 구성되어 있다. 불행히도, 모든 이모지 라이브러리가 수식어를 지원하는 것은 아니다. 하지만, 그들의 인기를 감안할 때, 이모티콘 피부톤 수식어는 "갖기 좋은" 특징 그 이상이다. 게다가, 그것들은 우리가 더 모듈적이고 효율적인 코드를 쓸 수 있게 해주기 때문에 일하는 현명한 방법입니다.

이것이 바로 우리가 이 기사에서 하고 있는 것입니다: 이모티콘 수식어를 프로그래밍적으로 어떻게 사용하는지 알아내는 것입니다. 이렇게 하면 피부 톤 지원 없이 꼼짝 못하거나 다른 이모티콘의 사용자 정의 변형을 만들고 싶다면 방법을 알 수 있습니다!

### 피츠패트릭 저울을 만나보세요

2015년 유니코드 8.0의 일부로 스킨 톤 수정기가 이모지에 공식 추가되었다. 그것들은 사람의 피부톤을 공식적으로 분류하는 피츠패트릭 저울에 기초한다. 다음 차트는 이모티콘 문자가 피츠패트릭 유형과 어떻게 일치하는지 보여줍니다.

가장 간단한 사용 사례에서 이러한 문자 중 하나가 피부톤 수정기를 지원하는 이모지에 추가되면 이모지의 피부톤이 변경됩니다.

또 다른 방법은 🏽=👶🏽 + 🏽=👶🏽입니다.

### CSS를 사용하여 피부톤 수정기 적용

CSS를 사용하여 이모티콘을 교환하려면 기본 이모티콘 문자(👶)로 시작한 다음 `::after` 의사 표시를 사용하여 피부톤을 추가한다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_dyMOqjK" src="//codepen.io/anon/embed/dyMOqjK?height=450&amp;theme-id=1&amp;slug-hash=dyMOqjK&amp;default-tab=css,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed dyMOqjK" title="CodePen Embed dyMOqjK" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

렌더링된 이모티콘 문자 외에도 다음과 같은 유니코드 16진수 코드를 사용할 수 있습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_XWdNxWz" src="//codepen.io/anon/embed/XWdNxWz?height=450&amp;theme-id=1&amp;slug-hash=XWdNxWz&amp;default-tab=css,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed XWdNxWz" title="CodePen Embed XWdNxWz" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### JavaScript를 사용하여 피부톤 수정자 제거 및 교환

지금 작업 중인 이모티콘에 이미 스킨톤 수식어가 적용됐다면요? 그러기 위해서는 CSS를 넘어서야 합니다. 다음은 JavaScript를 사용한 예입니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_PoNbxge" src="//codepen.io/anon/embed/PoNbxge?height=450&amp;theme-id=1&amp;slug-hash=PoNbxge&amp;default-tab=js,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed PoNbxge" title="CodePen Embed PoNbxge" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

이게 무슨 일이야? 먼저 피츠패트릭 타입 4의 아기 이모티콘부터 시작하죠 그런 다음 피부톤 수정자를 검색하여 문자열에서 제거하는 removeModifier 함수로 전달합니다. 수식어가 없는 이모지가 생겼으니 마음에 드는 수식어를 달 수 있다.

이 접근 방식은 많은 이모티콘과 함께 작동하지만, 다른 수식어가 도입될 때 문제가 발생한다. 그렇기 때문에 이제 우리는 …에 대해 이야기해야 합니다.

### ZWJ 시퀀스 사용

ZWJ(Zero Width Joiner) 시퀀스는 유니코드의 합성어와 같습니다. 0폭 조인 U+200D가 결합된 2개 이상의 이모티콘으로 구성된다.

ZWJ 시퀀스는 이모지에 성별 수정자를 추가하는 데 가장 일반적으로 사용된다. 예를 들어, 리프팅 웨이트와 ZWJ, 그리고 여성 기호는 리프팅 웨이트(weight weights)와 같습니다. (weights🏋weights + ♀weights =🏋️♀️weights =🏋️♀️).

ZWJ 시퀀스를 사용할 때 명심해야 할 몇 가지 중요한 사항이 있습니다.

- 이 순서는 권장 사항일 뿐입니다. 이러한 프로토콜은 유니코드 컨소시엄에서 제공되므로 모든 플랫폼에서 지원되지 않습니다. 플랫폼에서 지원하지 않는 경우 대신 일반 이모지의 폴백 시퀀스가 표시됩니다.
- 피부톤 수정기(있는 경우)는 이모티콘 뒤에 ZWJ 앞에 포함되어야 합니다.
- 일부 ZWJ 시퀀스는 각각 다른 피부톤 수정자를 갖는 여러 이모티콘을 포함한다.

이 정보를 고려하여 이전 코드 예제를 다음과 같이 변경해야 합니다.

- 피부톤 수정자는 단순히 이모티콘 끝에 붙이지 말고 기본 이모티콘 바로 뒤에 삽입해야 한다.
- ZWJ 시퀀스에 피부톤 수정기가 있는 이모지가 여러 개 있는 경우 각 이모지에 대해 수식어를 교체해야 합니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_QWNOGRz" src="//codepen.io/anon/embed/QWNOGRz?height=450&amp;theme-id=1&amp;slug-hash=QWNOGRz&amp;default-tab=js,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed QWNOGRz" title="CodePen Embed QWNOGRz" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 제한사항

이 예제에서 일관성의 한계를 확인할 수 있습니다. 편집기 보기는 해당 이모티콘에 즉시 적용되는 스킨 톤 수정기를 제외하고 각 문자를 ZWJ 시퀀스로 개별적으로 표시합니다. 반면에 콘솔 또는 결과 보기는 전체 시퀀스에 대한 문자를 렌더링하려고 시도합니다.

이에 대한 지원은 플랫폼에 따라 달라집니다. 일부 편집자는 ZWJ 시퀀스를 렌더링하려고 시도할 수 있으며, 모든 브라우저가 동일한 ZWJ 시퀀스 집합을 지원하는 것은 아니다.

또한 ZWJ 시퀀스에서 피부 톤을 추가하려면 기본 이모티콘으로 사용되는 것이 무엇인지 알아야 합니다. 알려진 컬렉션에 의해 이모지가 제공되는 상황에서는 이것이 비교적 간단하겠지만, 사용자의 임의 입력을 처리할 수 있으려면 상황은 더 어려워진다.

또한, 이 게시물의 CSS 솔루션은 ZWJ 시퀀스와 호환되지 않습니다.

### 개발을 안내하는 질문

이모티콘 피부톤 수정기를 취급해야 하는 시스템을 설계할 때 몇 가지 질문을 정리합니다.

- 어떤 이모티콘과 상호작용할지를 제어하고 있습니까?
- 내 이모지 라이브러리에 어떤 이모지가 피부톤 수식어를 지원하는지에 대한 정보가 있습니까?
- 시스템에서 수정자를 추가, 제거 또는 변경해야 합니까?
- 내 플랫폼은 ZWJ 시퀀스를 지원합니까? 만약 그렇다면, 어떤 것인가요?
- 시스템이 여러 피부톤 수정기로 ZWJ 시퀀스를 지원해야 합니까?

이러한 질문에 대한 답변과 여기서 살펴본 예제 사이에 필요한 상황에서 이모티콘 피부톤 수식어를 지원하는 데 필요한 모든 것이 들어 있기를 바랍니다.