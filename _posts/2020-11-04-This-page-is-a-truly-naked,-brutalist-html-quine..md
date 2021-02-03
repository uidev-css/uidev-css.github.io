---
layout: post
title: "이 페이지는 진정으로 알몸의 야만적 인 HTML 퀸입니다.
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/10/brutalist-html-quine.jpg
tags: 
---


secretGeek.net의 재미있는 페이지가 있습니다.
 당신은 일반적으로 잔인한 미니멀리즘으로 "재미있다"고 생각하지 않지만이 페이지에서 작동하도록 만드는 CSS 속임수는 확실히 그렇습니다.
 

HTML은 말 그대로 페이지에 태그로 표시됩니다.
 따라서 어떤 의미에서 HTML은 페이지 마크 업이자 콘텐츠입니다.
 디자인이 너무 최소화되어 (또는 "알몸") 코드가 누출됩니다!
 아주 멋지다.
 

페이지에서 요령을 설명하지만 여기서는 설명하겠습니다.
 

- 모든 것은`* {display : block;
 }`
 
- …`a, code, em, strong {display : inline}`과 인라인으로 유지되는 앵커, 코드, 강조 및 strong 제외
 
- `:: before` 및`:: after`를 사용하여 HTML 태그를 콘텐츠로 표시합니다 (예 :`p :: before {content : `<p>`}`).
 

이 페이지는 Josh Li의 "거의 모든 곳에서 멋지게 보이기위한 58 바이트 CSS"에서 발췌 한 멋진 스 니펫으로 끝납니다.
 

```css
html {
  max-width: 70ch;
  padding: 2ch;
  margin: auto;
  color: #333;
  font-size: 1.2em;
}
```

직접 링크 →
 