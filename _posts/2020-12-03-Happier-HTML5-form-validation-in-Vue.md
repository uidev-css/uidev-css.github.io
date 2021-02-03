---
layout: post
title: "Vue에서 더 행복한 HTML5 양식 유효성 검사
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2017/08/forms-guide.png
tags: FORM VALIDATION,VUE
---


CSS에서`input : invalid {}`를 수행하여 입력이 잘못된 상태에있을 때 스타일을 지정할 수 있다는 것은 일종의 깔끔합니다.
 그러나 정확히 그렇게 사용하면 UX는 상당히 나쁩니다.
 `<input type = "text"required>`가 있다고 가정합니다.
 사용자가 어떤 작업을 수행하기 전에는 즉시 무효화됩니다.
 그것은 야생에서 사용되는 것을 결코 볼 수 없을 정도로 부끄러운 UX입니다.
 그러나 우리가 그 한 가지만 피할 수 있다면,`: invalid` 선택자는 크고 멋진 라이브러리에 의지 할 필요없이 양식 유효성 검사에서 우리를 위해 많은 작업을 수행 할 수 있습니다.
 

Dave는 원래 2017 년 아이디어를 변형 한 아이디어를 가지고 있습니다.
 

기본적으로 :
 

```css
form.errors :invalid {
  outline: 2px solid red;
}
```

이제 양식을 오류 상태로 확인하고 클래스를 추가 한 경우에만 이러한 기본 오류 스타일을 조건부로 적용합니다.
 다행히도 테스트도 매우 쉽습니다.
 제출 버튼을 클릭하면 해당 클래스를 적용 할 수 있습니다.
 

```js
submitButton.addEventListener("click", (e) => {
  form.classList.toggle("errors", !form.checkValidity())
});
```

또는 입력이 흐려질 때 할 수 있습니다.
 각 입력 세트를 래퍼로 래핑하고 적절한 경우 래퍼에서 클래스를 토글 할 수도 있습니다.
 여기에 주석 처리 된 코드를 사용하면 거기로 갈 수 있습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_poEJPKX" src="//codepen.io/anon/embed/poEJPKX?height=450&amp;theme-id=1&amp;slug-hash=poEJPKX&amp;default-tab=js,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed poEJPKX" title="CodePen Embed poEJPKX" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

Dave는이 아이디어를 Vue에 넘겼습니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_d326872e64feef81eade1c28eeb8b8d6" src="//codepen.io/anon/embed/d326872e64feef81eade1c28eeb8b8d6?height=450&amp;theme-id=1&amp;slug-hash=d326872e64feef81eade1c28eeb8b8d6&amp;default-tab=js,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed d326872e64feef81eade1c28eeb8b8d6" title="CodePen Embed d326872e64feef81eade1c28eeb8b8d6" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

> 사용자가 양식을 제출할 때까지 오류 스타일을 원하지 않기 때문에 'errors : false'로 양식 구성 요소를 초기화합니다.
 `invalidateForm` 함수는`this.error = true`를 설정합니다.
 그것은 CSS`: invalid` 유사 클래스의 한 가지 문제이며 너무 열심입니다.
 '잘못된'이벤트에 연결하면 첫 번째 양식 제출 시도 후 양식에 오류가 있음을 알 수있을 때까지 스타일 지정이 지연됩니다.
 

(이미 사용하는 것 외에) 라이브러리를 사용하지 않는 것은 매우 좋습니다.
 HTML 양식 유효성 검사가 거의 있습니다.
 다음은 오류 메시지가 드러나는 Dave의 포크입니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_wvzazJg" src="//codepen.io/anon/embed/wvzazJg?height=450&amp;theme-id=1&amp;slug-hash=wvzazJg&amp;default-tab=js,result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed wvzazJg" title="CodePen Embed wvzazJg" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

직접 링크 →
 