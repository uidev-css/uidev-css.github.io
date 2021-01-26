---
layout: post
title: "블록 내부 및 외부 코드 스타일링"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/01/code-block-screenshot.png
tags: CODE
---


HTML에`<code>`태그가 있습니다.
 나는 말 그대로 이전 문장에서 그 태그를 감싸는 데 사용했습니다. 그래서 메타입니다.
 모든 종류의 코드를 나타내는 인라인 기본 요소입니다.
 고정 폭 글꼴 모음을 적용하는 기본 (사용자 에이전트) 스타일이 있으며, 이는 훌륭한 기본값처럼 느껴집니다 (사실상 대부분의 코드는 고정 폭으로 표시됨).

```css
/* User agent styles in all browsers */
code {
  font-family: monospace;
}
```

스타일 시트에서도 태그 자체로 스타일을 지정할 수 있습니다.
 스타일이없는 상태로 재설정하고 클래스가있는 스타일을 선택하는 것과는 반대로 원시 상태로 사용하는 것이 훨씬 더 자연스러운 요소 중 하나 일뿐입니다.

```css
/* You'll probably do this: */
code {
  /* custom styles */
}

/* Or maybe scope it to something like: */
article code {

}

/* It seems less common and more annoying to do this: */
code {
  /* reset styles */
}

code.some-class {
  /* opt-in styles */
}
```

지금이 사이트 (v18)에서 겸손한 스타일을 적용하고 텍스트 요소 내에서 일부 범위를 지정합니다.

```css
/* For all <code> */
code {
  font-family: MyFancyCustomFont, monospace;
  font-size: inherit;
}

/* Code in text */
p > code,
li > code,
dd > code,
td > code {
  background: #ffeff0;
  word-wrap: break-word;
  box-decoration-break: clone;
  padding: .1rem .3rem .2rem;
  border-radius: .2rem;
}
```

이것이 도움이되는 한 가지는 다음과 같습니다.

```html
<h3>The <code>.cool</code> Class</h3>
```

내 스타일은 여전히 멋진 고정 폭 글꼴을 만들고 헤더와 동일하게 크기를 조정하지만 텍스트 내의 코드에 대해 내가 좋아하는 배경색과 패딩을 적용하지 않습니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/12/Screen-Shot-2020-12-31-at-1.29.28-PM.png?resize=518%2C109&ssl=1)

`<code>`의 범위가 지정된 스타일과 관련하여 더 큰 문제는 다음과 같은 매우 일반적인 마크 업입니다.

```html
<pre><code>
  example code block
</code></pre>
```

`<pre>`태그는 HTML의 공백을 고려하므로 코드 블록을 표시하는 데 중요합니다.
 그러나 의미 상 "사전 서식이 지정된 텍스트"를 의미합니다.
 코드 블록 인 경우`<code>`태그도 포함되어야합니다.
 그러나`<code>`는 인라인 요소임을 기억하십시오.
 또한 문장 내에서보기를 원하는 방식과 블록에서 원하는 방식이 상당히 다를 가능성이 높습니다.

제이슨은 요 전에 이것에 대해 트윗했습니다.

스레드에서 다음과 같은 혼란이있었습니다.

```css
/* this was working */
.post :not(pre) code {

}

/* and this was not */
:not(pre) code {

}
```

두 번째 "루트에서"선택 자의 문제는`: not (pre)`이 항목 (`<body>`와 같은)과 일치하여 해당 스타일을 적용한다는 것입니다.
 게시물 (첫 번째 예) 내에서 단락 태그 및 이미지와 같은 항목 만 선택하므로 더 예상대로 작동합니다.
 좋은 접근 방식이라고 생각합니다.
 `<pre>`태그가 주요 관심사이므로 특정 요소 내에있는 동안 특정 스타일을 얻지 못하도록 해당`<code>`태그에 범위를 지정하는 다른 방법 일뿐입니다.

이 사이트에는 코드 블록이 많이 있으므로 좀 더 보호하려고 노력합니다.
 저는 특히`<pre>`태그 내에있는`<code>`요소를 많은 스타일로 스타일을 지정하여 원하는 방식을 얻고 잠재적으로 다른 바람직하지 않은 스타일에 맞서 싸울 수 있습니다.
 다음과 같은 것 :

```css
pre code {
  display: block;
  background: none;
  white-space: pre;
  -webkit-overflow-scrolling: touch;
  overflow-x: scroll;
  max-width: 100%;
  min-width: 100px;
  padding: 0;
}
```

내 실제 스타일은 그것보다 조금 더 장황합니다.
 그 스 니펫에는 영리한 것이 없습니다.
 나는 코드 블록이 제대로 나오도록하기 위해 꽤 좋은 스타일의 힙을 코드 블록에 적용한다는 것을 지적하고 있습니다.

컨텍스트에 따라 스타일을 다르게 지정하는 방식에서`<code>`요소가 다소 독특하다는 점이 흥미 롭습니다.