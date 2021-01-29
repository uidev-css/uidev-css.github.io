---
layout: post
title: "WordPress 블록 편집기를 프런트 엔드 디자인처럼 보이게 만들기
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/10/wp-editor-dev-tools.jpg
tags: GUTENBERG,WORDPRESS
---


저는 WordPress 사용자입니다. 저와 같은 사람이라면 게시물을 편집 할 때 항상 두 개의 탭이 열려 있습니다. 하나는 새로운 멋진 바지 블록 편집기 (일명 Gutenberg)가있는 탭이고 다른 하나는 게시물 미리보기가있는 탭입니다.
 프론트 엔드에서 이상하게 보이지 않을 것임을 알고 있습니다.
 

WordPress 테마의 스타일이 웹 사이트의 프런트 엔드에만 영향을 미치는 것은 놀라운 일이 아닙니다.
 백엔드 posy 편집기는 일반적으로 프론트 엔드 결과와 같지 않습니다.
 우리는 그것에 익숙합니다.
 하지만 워드 프레스 편집기가 프런트 엔드 모양을 거의 미러링 할 수 있다고 말하면 어떻게 될까요?
 

필요한 것은 사용자 정의 스타일 시트입니다.
 

마음.
 부푼.
 권리?
 글쎄요, 그게 마음이 불지 않을 수도 있지만, 다른 것이 없다면 시간을 절약 할 수 있습니다.
 🙂
 

WordPress는 여기서 가능한 일에 대한 힌트를 제공합니다.
 WordPress와 함께 패키지화 된 기본 Twenty Twenty 테마를 실행하고 편집기를 실행하면 가벼운 스타일이 적용됩니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/10/wp-block-editor-styling.png?resize=2838%2C2018&ssl=1)

이 모든 것은 매우 기본적인 두 가지 변경 사항으로 구성됩니다.
 

- 테마의`functions.php` 파일에있는 몇 줄의 PHP는 편집기 스타일에 대한 사용자 정의 스타일 시트를로드 할 것인지 편집기에 알립니다.
 
- 사용자 정의 스타일 시트
 

그럼, 충분한 프리 와플!
 WordPress 편집기를 프런트 엔드처럼 보이게 만들어 보겠습니다.
 

### 1 단계 : functions.php 파일 열기
 

좋아, 거짓말을하고 있었어.
 직접 개발하지 않은 WordPress 테마를 사용하는 경우 기본 테마를 변경하기 전에 하위 테마를 설정하는 것이 가장 좋습니다.
 `</ pre-waffle>`
 

좋아하는 텍스트 편집기를 실행하고 일반적으로 테마 폴더의 루트에있는 테마의`functions.php` 파일을 엽니 다.
 파일 끝에 다음 줄을 추가합니다.
 

```php
// Gutenberg custom stylesheet
add_theme_support('editor-styles');
add_editor_style( 'editor-style.css' ); // make sure path reflects where the file is located
```

이 작은 코드 스 니펫은 WordPress에 Gutenberg에서 사용할 맞춤 스타일 시트에 대한 지원을 추가하도록 지시 한 다음 해당 스타일 시트 ( `editor-style.css`라고 함)가있는 위치를 가리 킵니다.
 워드 프레스는 좀 더 자세히 알고 싶다면`add_theme_support` 기능에 대한 확실한 문서를 가지고 있습니다.
 

### 2 단계 : CSS 트릭 (내가 거기서 무엇을했는지 확인하세요?!)
 

이제 우리는 바로 CSS를 작성하는 것입니다!
 

테마에`editor-styles` 지원을 추가 했으므로 다음으로 할 일은`functions.php`에서 정의한 스타일 시트에 CSS 기능을 추가하여 스타일이 Gutenberg에 올바르게로드되도록하는 것입니다.
 

수천 개의 워드 프레스 테마가 있기 때문에 편집기를 각 테마와 똑같이 만드는 스타일 시트를 작성할 수 없었습니다.
 대신 웹 사이트에서 사용하는 테마를 기반으로 한 예를 보여 드리겠습니다.
 이렇게하면 사이트의 `스타일 시트`를 빌드하는 방법에 대한 아이디어를 얻을 수 있습니다.
 시작하는 데 도움이되는 템플릿도 마지막에 포함하겠습니다.
 

이제`editor-style.css`라는 새 파일을 만들어 테마의 루트 디렉터리에 배치합니다 (타사 테마를 사용자 지정하는 경우 하위 테마).
 

블록 편집 기용 CSS 작성은 표준 CSS 요소를 사용하는 것만 큼 간단하지 않습니다.
 예를 들어 편집기 스타일 시트에서 다음을 사용하면 게시물의`<h2>`요소에 텍스트 크기가 적용되지 않습니다.
 

```css
h2 {
  font-size: 1.75em;
}
```

요소 대신 스타일 시트는 블록 편집기 블록을 대상으로해야합니다.
 이렇게하면 형식이 최대한 정확해야한다는 것을 알 수 있습니다.
 즉, 스타일을 지정하려면`<h2>`요소의 범위를`.rich-text.block-editor-rich-text__editable` 클래스로 지정해야합니다.
 

![image](https://paper-attachments.dropbox.com/s_0AA7E2873A90425628249B45B3CEF75A8CD55F4BAF07A09C0F16AEAB41DC09E0_1603476692897_wp-editor-h2-class.jpg)

```css
h2.rich-text.block-editor-rich-text__editable {
  font-size: 1.75em;
}
```

이 패턴에 따라 공통 블록 편집기 요소의 스타일을 지정하는 기준 CSS 파일을 만들었습니다.
 GitHub에서 부담없이 스타일을 바꾸어 테마를 보완하세요.
 

여기에서 스타일 시트를 계속 작성할 수 있지만 템플릿을 통해 자신의 스타일 시트에 무엇을 채워야하는지에 대한 아이디어를 얻을 수 있다고 생각합니다.
 좋은 시작점은 프런트 엔드의 스타일 시트를 살펴보고 거기에서 요소를 복사하는 것이지만 블록 편집기 창에 적용되도록 일부 요소 클래스를 변경해야 할 수 있습니다.
 

확실하지 않은 경우 브라우저의 DevTools에서 요소를 사용하여 어떤 클래스가 어떤 요소에 적용되는지 확인하세요.
 위에 링크 된 템플릿은 대부분의 요소를 캡처해야합니다.
 

### 결과
 

먼저 맞춤 스타일 시트가없는 WordPress 편집기의 모습을 살펴 보겠습니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/10/4k1-d_ZA.png?resize=1000%2C618&ssl=1)

내 테스트 사이트의 프런트 엔드와 비교해 보겠습니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/10/s_831154CD7AAAB96F7CB07A8F4D5CAD5AF04C9E76259A04EC7E154DEA95F58782_1602156735791_front-end-ui.png?resize=1000%2C783&ssl=1)

상황이 꽤 다르죠?
 여기에 여전히 단순한 디자인이 있지만 저는 그라디언트를 최대한 사용하고 있습니다!
 맞춤 글꼴, 버튼 스타일 및 인용구도 있습니다.
 컨테이너조차도 정확히 정사각형 모서리가 아닙니다.
 

좋아하든 싫어하든 이것이 기본 구텐베르크 편집기 UI에서 크게 벗어나는 것에 동의 할 것이라고 생각합니다.
 내 게시물을 미리보기 위해 별도의 탭을 열어야하는 이유가 무엇입니까?
 

이제 사용자 정의 스타일을로드하고 다음 사항을 확인해 보겠습니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/10/s_831154CD7AAAB96F7CB07A8F4D5CAD5AF04C9E76259A04EC7E154DEA95F58782_1602157093031_custom-gutenberg-editor-ui.png?resize=1000%2C772&ssl=1)

잘보세요!
 에디터 UI는 이제 제 웹 사이트의 프런트 엔드와 거의 똑같이 보입니다.
 콘텐츠 너비, 글꼴, 색상 및 다양한 요소는 모두 프런트 엔드와 동일합니다.
 게시물 제목에 대한 멋진 배경도 있습니다!
 

Ipso facto — 더 이상 다른 탭에서 미리보기가 없습니다.
 멋지죠?
 

WordPress 편집기를 프런트 엔드처럼 보이게 만드는 것은 매우 편리합니다.
 게시물을 편집 할 때 탭을 넘기면 프런트 엔드의 게시물이 어떻게 보이는지 확인하면 모조가 망가집니다.
 

이 두 가지 빠른 단계는 당신에게도 똑같이 할 수 있습니다!
 