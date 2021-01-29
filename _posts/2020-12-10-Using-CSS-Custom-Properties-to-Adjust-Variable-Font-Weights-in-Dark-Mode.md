---
layout: post
title: "CSS 사용자 정의 속성을 사용하여 다크 모드에서 가변 글꼴 두께 조정
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/12/dark-mode-font-weight.png
tags: DARK,VARIABLE FONTS
---


블랙이 항상 슬리밍되는 것은 아닙니다.
 

최근에 내 사이트 중 하나에 대한 다크 모드 옵션을 테스트 할 때이 기사에서 Robin Rendle이 언급 한 문제를 직접 경험했습니다.
 다크 모드로 전환했을 때 모든 페이지 텍스트 (제목 및 본문 문구)가 대량으로 표시되었습니다.
 그리고 어떤 글꼴을 사용했는지, 어떤 브라우저를 사용했는지는 중요하지 않았습니다.
 그들 모두에게 같은 일이 일어났습니다.
 

예를 들어 Windows 용 Chrome에서 Adobe의 Source Sans Pro는 다음과 같이 처리됩니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_11ADE8066BDA656E85D38D4A3C608C6A59895CF399F2DA91F836EA0190B5E285_1600352364072_DarkModeRaw.png?resize=586%2C229&ssl=1)

환상이 아닙니다.
 밝은 문자는 실제로 어두운 배경에 비해 더 무겁습니다.
 더 잘보기 위해 확대 할 수 있습니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_11ADE8066BDA656E85D38D4A3C608C6A59895CF399F2DA91F836EA0190B5E285_1600352384961_DarkModeZoom.png?resize=350%2C173&ssl=1)

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_11ADE8066BDA656E85D38D4A3C608C6A59895CF399F2DA91F836EA0190B5E285_1600352393477_DarkModeZoom2.png?resize=490%2C156&ssl=1)

그리고 우리가 그 이미지의 어두운 모드 부분을 반전하면 정말 분명해집니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_11ADE8066BDA656E85D38D4A3C608C6A59895CF399F2DA91F836EA0190B5E285_1600352504547_DarkModeZoomInvert.png?resize=350%2C173&ssl=1)

![image](https://paper-attachments.dropbox.com/s_11ADE8066BDA656E85D38D4A3C608C6A59895CF399F2DA91F836EA0190B5E285_1600352498041_DarkModeZoom2Invert.png)

### 하나의 솔루션
 

가변 글꼴은 광범위한 브라우저 지원을 제공하므로이 문제를 해결하는 데 사용할 수 있습니다.
 아래 세 개의 패널은 우리가 진행할 솔루션을 보여줍니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_11ADE8066BDA656E85D38D4A3C608C6A59895CF399F2DA91F836EA0190B5E285_1600703292673_image.png?resize=618%2C368&ssl=1)

이 개선 된 효과를 얻을 수있는 방법은 다음과 같습니다.
 

- 다음 방법 중 하나를 사용하여 다크 모드에서`font-weight` 속성을 줄입니다.
다크 모드 미디어 쿼리에서 직접 각`font-weight` 할당을 수동으로 변경합니다.
다크 모드에서 값을 변경하는 단일 `--font-weight-multiplier`맞춤 속성을 만들고 각 요소의 기본 `font-weight`값을 곱할 수 있습니다.
동일하지만 각 요소의 `font-weight`속성을 개별적으로 계산하는 대신 CSS 변수 범위 지정 및 범용 선택기 ( `*`)를 활용하여 승수 계산을 한 번에 적용합니다.
 
- 다크 모드 미디어 쿼리에서 직접 각`font-weight` 할당을 수동으로 변경합니다.
 
- 다크 모드에서 값을 변경하는 단일 `--font-weight-multiplier`맞춤 속성을 만들고 각 요소의 기본 `font-weight`값을 곱할 수 있습니다.
 
- 동일하지만 각 요소의 `font-weight`속성을 개별적으로 계산하는 대신 CSS 변수 범위 지정 및 범용 선택기 ( `*`)를 활용하여 승수 계산을 한 번에 적용합니다.
 
- 가변 글꼴의 등급 ( "GRAD") 축을 조정합니다.
 모든 가변 글꼴이이 특정 기능을 지원하는 것은 아니지만 Roboto Flex는 지원합니다.
 이 축 값을 변경하면 글자 너비에 영향을주지 않고 글꼴의 겉보기 두께가 변경됩니다.
 
- 가변 글꼴의 darkmode (` "DRKM"`) 축을 조정합니다.
 Dalton Maag의 이름이 다크 모드 인 다크 모드 (darkmode)는 이것에 매우 적합합니다.
 Roboto Flex의 등급 축과 마찬가지로 Darkmode의 darkmode 축을 조정하면 글꼴의 겉보기 두께가 변경됩니다.
 그러나 그레이드 축은 값의 미세 조정이 필요하지만 다크 모드 축은 단순히 켜거나 (얇게) 끄거나 (일반).
 

첫 번째 그룹의 기술은 대부분의 가변 글꼴에 적용됩니다.
 Robin이 그의 기사에서 사용하는 솔루션은 실제로 그룹의 첫 번째 항목입니다.
 다크 모드에서 글꼴 두께를 자동으로 조정하는 데 도움이되는 사용자 지정 속성을 도입하여 그룹의 두 번째 및 세 번째 항목을 확장하겠습니다.
 

두 번째와 세 번째 그룹은 덜 일반적인`font-variation-settings` 축을 포함합니다.
 이러한 전략은 적은 수의 서체에 적용되지만 사용 가능한 경우 선호 될 수 있습니다.
 트릭은 가변 글꼴을 선택하기 전에 지원하는 것을 아는 것입니다.
 

이 기사에서 다루는 모든 전략이 포함 된 데모 페이지를 만들었습니다.
 라이트 모드, 조정이없는 어두운 모드, 문자를 얇게 만드는 솔루션을 사용하여 어두운 모드에서 다양한 가변 글꼴이 어떻게 보이는지 확인할 수 있습니다.
 

위에 나열된 전략 외에도 항상 한 가지 옵션이 더 있습니다. 아무것도하지 마세요!
 글꼴이 밝고 어두운 모드에서 충분히 좋아 보인다고 생각하거나 현재 리플 로우, 요소 크기 조정, 브라우저 / 디스플레이 불일치 및 유지 관리 할 추가 CSS와 씨름 할 대역폭이없는 경우 변경하지 않아도됩니다.
 일.
 사이트의 나머지 부분에 집중하고 나중에이 주제를 다시 방문 할 수있는 가능성을 열어 두십시오.
 

### 전략 1 :`font-weight` 값 줄이기
 

대부분의 가변 텍스트 글꼴에는 가중치 축이 있으므로 해당 글꼴에 사용할 수있는 가중치 범위 (예 : 0-1000, 300-800 등) 내에서 특정 `font-weight`값을 할당 할 수 있습니다.
 이 전략의 각 기술은 가중치 축에 대한이 미세 제어를 활용하여 다크 모드에서 `글꼴 가중치`값을 줄입니다.
 (이러한`font-weight` 정밀도에 대한 필요성은 대부분의 가변 글꼴이이 솔루션에 적합하지 않게 만드는 원인이기도합니다.)
 

로컬에있는 가변 글꼴을 사용하는 경우 Wakamai Fondue에서 축과 값 범위를 확인할 수 있습니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_11ADE8066BDA656E85D38D4A3C608C6A59895CF399F2DA91F836EA0190B5E285_1606083672995_wakamai.png?resize=1024%2C956&ssl=1)

`@ font-face` 규칙을 사용하여 글꼴을로드하는 경우 각 글꼴에 대해 동시에`font-weight` 범위를 설정해야합니다.
 

```css
@font-face {
  src: url('Highgate.woff2') format('woff2-variations');
  font-family: 'Highgate';
  font-weight: 100 900;
}
```

이 단계를 무시하면 일부 가변 글꼴이 현재 Chromium 브라우저의 특정 `font-weight`값을 제대로 반영하지 못할 수 있습니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_11ADE8066BDA656E85D38D4A3C608C6A59895CF399F2DA91F836EA0190B5E285_1601653963708_DarkModeFontVarSettings.png?resize=500%2C80&ssl=1)

## 기본 솔루션 : 각 중량을 수동으로 입력
 

다음은 우리 대부분이 접근 할 수있는 기술입니다.
 기본값보다 약간 낮은 `font-weight`값을 입력하는 다크 모드 미디어 쿼리를 생성합니다.
 

```css
/* Default (light mode) CSS */ 
body {
  font-weight: 400;
}

strong, b, th, h1, h2, h3, h4, h5, h6 {
  font-weight: 700;
}

/* Dark mode CSS */
@media (prefers-color-scheme: dark) {
  body {
    font-weight: 350;
  }

  strong, b, th, h1, h2, h3, h4, h5, h6 {
    font-weight: 600;
  }
}
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 350px;"><iframe id="cp_embed_gOrqKOY" src="//codepen.io/anon/embed/gOrqKOY?height=350&amp;theme-id=1&amp;slug-hash=gOrqKOY&amp;default-tab=result" height="350" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed gOrqKOY" title="CodePen Embed gOrqKOY" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

작동하며 유지 관리하는 데 문제가 없습니다. 사이트에서 다른 가중치를 추가하거나 편집 할 계획이없는 한!
 그러나 더 많은 가중치를 통합하기 시작하면 다루기가 어려워 질 수 있습니다.
 `prefers-color-scheme` 미디어 쿼리 외부와 내부에 각 선택기 / 속성 조합을 입력해야합니다.
 각 요소에 대한 다크 모드 속성 값을 결정하기 위해 몇 가지 수동 계산 (또는 추측)을 수행해야합니다.
 

저는 일반적으로 Mike Riethmuller의 "미디어 쿼리는 사용자 지정 속성의 값을 변경하는 데만 사용됩니다"라는 신조를 고수하려고합니다.
 이것이 바로이 솔루션에서 개선 된 것입니다.
 다크 모드 안팎의 모든 요소에 대한 글꼴 두께를 입력 할 필요없이 미디어 쿼리에 넣는 유일한 것은`--font-weight-multiplier` 사용자 지정 속성입니다.
 

```css
@media (prefers-color-scheme: dark) {
  :root {
    --font-weight-multiplier: .85;
  }
}
```

그런 다음 스타일 시트 전체의 모든 `font-weight`속성에 대해 변수 값에 각 요소에 대해 선호하는 기본 가중치 값을 곱하여 다크 모드에서 글꼴 두께를 15 % 낮 춥니 다.
 다크 모드가 아닌 경우 기본 가중치에 1을 곱합니다. 즉, 전혀 변경되지 않습니다.
 

제가 의미하는 바는 다음과 같습니다.
 일반적으로이를 사용하여 본문 글꼴 두께를 400으로 설정합니다.
 

```css
body {
  font-weight: 400;
}
```

이 솔루션의 경우 다음을 사용합니다.
 

```css
body {
  font-weight: calc(400 * var(--font-weight-multiplier, 1));
}
```

`var ()`함수에서 변수의 폴백 값이 1임을 확인하십시오.`--font-weight-multiplier`는 다크 모드에서만 설정되므로이 폴백 값이 나머지 시간 동안 사용됩니다.
 따라서 기본적으로 본문 텍스트의 글꼴 두께는 400 (`400 * 1`)으로 유지됩니다.
 그러나 다크 모드에서는 가중치가 340 (`400 * .85`)으로 감소합니다.
 

굵은 요소로도이 작업을 수행합니다.
 

```css
strong, b, th, h1, h2, h3, h4, h5, h6 {
  font-weight: calc(700 * var(--font-weight-multiplier, 1));
}
```

이러한 가중치는 다크 모드에서 700에서 595 (`700 * .85`)로 감소합니다.
 

그리고 기본적으로 `font-weight`를 400이 아닌 다른 값으로 설정하려는 다른 요소에 대해서도 동일한 기술을 사용할 수 있습니다.
 

저는`--font-weight-multiplier`에 .85 값을 사용하고 있습니다. 왜냐하면 대부분의 글꼴 (예 : 대부분의 글꼴에서 사용하는 무료 서체 인 Adobe Source Sans Pro와 같은)에 대해 좋은 일반 값이라는 것을 알았 기 때문입니다.
 이 기사의 데모).
 그러나 그 숫자로 자유롭게 놀아보십시오.
 

이것이 어떻게 합쳐 지는지 다음과 같습니다.
 

```css
/* DARK-MODE-SPECIFIC CUSTOM PROPERTIES */
@media (prefers-color-scheme: dark) {
  :root {
    --font-weight-multiplier: .85;
  }
}

/* DEFAULT CSS STYLES... */
body {
  font-weight: calc(400 * var(--font-weight-multiplier, 1));
}

strong, b, th, h1, h2, h3, h4, h5, h6 {
  font-weight: calc(700 * var(--font-weight-multiplier, 1));
}
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 350px;"><iframe id="cp_embed_LYNqXgb" src="//codepen.io/anon/embed/LYNqXgb?height=350&amp;theme-id=1&amp;slug-hash=LYNqXgb&amp;default-tab=result" height="350" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed LYNqXgb" title="CodePen Embed LYNqXgb" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

많은 CSS 사용자 정의 속성을 사용할 때 많은 사람들이 "필요에 따라 설정하고 모든 곳에 수동으로 적용"방식을 고수한다고 생각합니다.
 이것이 이전 솔루션이하는 일입니다.
 사용자 정의 속성 값을`: root`에 설정 (및 / 또는 대체 값 사용)하고 미디어 쿼리에서 다시 설정 한 다음 스타일 시트 전체에`calc ()`및`var ()`함수를 사용하여 적용합니다.
 `font-weight`값을 할당 할 때
 

코드는 다음과 같습니다.
 

```css
h1 {
  font-weight: calc(800 * var(--font-weight-multiplier, 1);
}

summary {
  font-weight: calc(600 * var(--font-weight-multiplier, 1);
}
```

그러나 다양한 요소에이 기법을 사용하면`font-weight` 값을 할당 할 때마다 다음 세 가지 작업을 수행해야 함을 알 수 있습니다.
 

- `calc ()`함수 포함
 
- `var ()`함수 포함
 
- `--font-weight-multiplier` 사용자 정의 속성의 이름과 기본값을 기억하십시오.
 

대신 최근에 특정 작업에 대해이 접근 방식을 반전하기 시작했습니다. "모든 곳에 설정하고 한 번만 적용"방법으로 CSS 변수 범위를 활용합니다.
 이 기법에서는 스타일 시트의 모든`font-weight` 속성을`--font-weight` 변수로 바꾸고, 단순성을 위해 대시를 제외하고 이름을 동일하게 유지합니다.
 그런 다음이 값을 특정 선택기의 기본 가중치 (예 : 본문 텍스트의 경우 400)로 설정합니다.
 아직`calc ()`도`var ()`도 필요하지 않습니다.
 이것이 우리가 모든 곳에 설정하는 방법입니다.
 

그런 다음 유니버설 선택기를 통해 모든 텍스트 요소의 가중치를 설정하는 스타일 시트의 유일한 `font-weight`속성을 사용하여 한 번 적용합니다.
 위의 스 니펫을 수정하면 이제 다음과 같이됩니다.
 

```css
h1 {
  --font-weight: 800;
}

summary {
  --font-weight: 600;
}

* {
  font-weight: calc(var(--font-weight, 400) * var(--font-weight-multiplier, 1);
}
```

`calc ()`함수는 각`--font-weight` 사용자 정의 속성에 multiplier 변수를 곱한 다음`font-weight` 속성이 값을 적절한 요소에 적용합니다.
 

스타일 시트의 각 맞춤 속성에 대해 단일 `var ()`만 사용할 필요는 없습니다.
 하지만 여기서처럼 계산을 수행하거나 도우미 변수를 사용하는 것을 좋아합니다.
 즉, 이것이 글꼴 두께를 조정하는 가장 영리한 기술이지만 모든 프로젝트에 가장 적합한 기술은 아닙니다.
 하나 이상의 심각한 경고가 있습니다.
 

범용 선택기 기술을 사용하는 주요 이점 (모든 것에 적용됨)은 또한 주요 위험을 초래합니다.
 우리가 얇게 만들고 싶지 않은 요소가있을 수 있습니다!
 예를 들어, 양식 요소가 어두운 모드에서 밝은 배경에 어두운 텍스트를 유지하는 경우에도 범용 선택기에 의해 스팀 롤링 될 수 있습니다.
 

이 위험을 완화하는 방법이 있습니다.
 `*`를 씬 아웃 할 요소 목록 만 포함하는 긴 선택기 문자열로 대체 할 수 있습니다 (계산에 옵트 인).
 또는 영향을받지 않으려는 요소에 대한 글꼴 두께를 하드 코딩 할 수 있습니다 (선택 해제).
 

```css
* {
  font-weight: calc(var(--font-weight, 400) * var(--font-weight-multiplier, 1));
}

button, input, select, textarea {
  font-weight: 400;
}
```

이러한 수정은 궁극적으로 이전 기술과 마찬가지로 코드를 복잡하게 만들 수 있습니다.
 따라서 어떤 것이 프로젝트에 적합한 지 판단해야합니다.
 여전히 성능, 코드 복잡성에 대한 우려가 있거나이 기술이 원치 않는 (예측 불가능한) 결과를 가져올 수 있다고 생각되는 경우 이전 기술이 가장 안전 할 수 있습니다.
 

최종 코드 :
 

```css
/* DEFAULT CUSTOM PROPERTIES */
:root {
  --font-weight: 400;
  --font-weight-multiplier: 1;
}
strong, b, th, h1, h2, h3, h4, h5, h6 {
  --font-weight: 700;
}

/* DARK-MODE-SPECIFIC CUSTOM PROPERTIES */
@media (prefers-color-scheme: dark) {
  :root {
    --font-weight-multiplier: .85;
  }
}

/* APPLYING THE CUSTOM PROPERTIES... */
* {
  font-weight: calc(var(--font-weight, 400) * var(--font-weight-multiplier, 1));
}
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 350px;"><iframe id="cp_embed_QWNJwBg" src="//codepen.io/anon/embed/QWNJwBg?height=350&amp;theme-id=1&amp;slug-hash=QWNJwBg&amp;default-tab=result" height="350" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed QWNJwBg" title="CodePen Embed QWNJwBg" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

위 코드에서 기본`--font-weight : 400` 및`--font-weight-multiplier : 1` 사용자 지정 속성을 설정할 필요가 없습니다.`var ()에 대체 값을 포함했기 때문입니다.
 )`함수.
 그러나 코드가 더 복잡 해짐에 따라 나중에 찾아서 변경하고 싶을 경우를 대비하여 논리적 위치에 할당하는 것을 좋아합니다.
 

이 전략에 대한 마지막 참고 사항 :`font-weight` 대신`font-variation-settings` 속성과` "wght"`축 값을 사용하여 가중치를 적용 할 수도 있습니다.
 축이 여러 개인 서체를 사용하는 경우 이러한 방식으로 모든 글꼴을 조정하는 것이 더 관리하기 쉬울 수 있습니다.
 13 개의 축이있는 글꼴 (Type Network의 Roboto Flex,이 문서의 뒷부분에서 사용)을 알고 있습니다.
 

`font-variation-settings` 속성을 통해 솔루션을 적용하는 방법은 다음과 같습니다.
 

```css
* {
  --wght: calc(var(--font-weight, 400) * var(--font-weight-multiplier, 1));
  font-variation-settings: "wght" var(--wght);
}
```

### 전략 1 부록 : '문자 간격'처리
 

유형 가중치를 낮추는 한 가지 부작용은 대부분의 고정 폭이 아닌 글꼴의 경우 문자가 좁아진다는 것입니다.
 

승수로 Source Sans Pro를 밝게 할 때 일어나는 일이 다시 있습니다.
 아래 상단의 두 패널은 기본적으로 밝고 어두운 모드의 Source Sans Pro를 보여줍니다.
 그리고 하단 패널은 더 가벼운 버전을 보여줍니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_11ADE8066BDA656E85D38D4A3C608C6A59895CF399F2DA91F836EA0190B5E285_1600703292673_image-1.png?resize=618%2C368&ssl=1)

조정하지 않으면 밝은 모드와 어두운 모드의 문자 너비가 동일합니다.
 그러나 글꼴 두께를 줄이면 이제 해당 문자가 더 적은 공간을 차지합니다.
 이 변경 사항이 흐름 또는 요소 크기 (예 : 좁은 버튼)에 미치는 영향이 마음에 들지 않을 수 있습니다.
 그리고 일부 디자이너는 어쨌든 어두운 모드에서 문자 간격을 추가하는 것이 좋다고 생각합니다.
 따라서 원하는 경우 다른 사용자 지정 속성을 만들어 공간을 추가 할 수 있습니다.
 

`font-weight` 승수 변수에서했던 것처럼, 다크 모드에서 재정의되는 기본값으로 문자 간격 변수를 만들 것입니다.
 기본 (라이트 모드)`: root`에서 새로운`--letter-spacing` 사용자 정의 속성을 지금은 0으로 설정합니다.
 

```css
:root {
  /* ...other custom variables... */
  --letter-spacing: 0;
}
```

그런 다음 다크 모드 쿼리에서 값을 0보다 큰 값으로 올립니다. 여기에`.02ch`로 입력했습니다 (`--font-weight-multiplier` 값 .85와 잘 결합 됨).
 .
 원하는 경우 글꼴 두께 및 / 또는 크기에 따라 몇 가지 계산을 통해 영리하게 조정하고 미세 조정할 수도 있습니다.
 하지만 지금은이 하드 코딩 된 값을 사용하겠습니다.
 

```css
@media (prefers-color-scheme: dark) {
  :root {
    /* ...other custom variables... */
    --letter-spacing: .02ch;
  }
}
```

마지막으로 범용 선택기를 통해 적용합니다 (대체 값 0).
 

```css
* {
  /* ...other property settings... */
  letter-spacing: var(--letter-spacing, 0);
}
```

참고 :이 예에서는`ch` 단위를 사용하지만 원하는 경우`em`도 사용할 수 있습니다.
 Source Sans Pro의 경우 `.009em`값은 `.02ch`와 거의 같습니다.
 

다음은 글자 간격이있는 글꼴 두께 승수에 대한 전체 코드입니다.
 

```css
/* DEFAULT CSS CUSTOM PROPERTIES */
:root {
  --font-weight: 400;
  --font-weight-multiplier: 1;
  --letter-spacing: 0;
}

strong, b, th, h1, h2, h3, h4, h5, h6 {
  --font-weight: 700;
}

/* DARK MODE CSS CUSTOM PROPERTIES */
@media (prefers-color-scheme: dark) {
  :root {
    /* Variables to set the dark mode bg and text colors for our demo. */
    --background: #222;
    --color: #fff;

    /* Variables that affect font appearance in dark mode. */
    --font-weight-multiplier: .85;
    --letter-spacing: .02ch;
  }
}

/* APPLYING CSS STYLES... */
* {
  font-weight: calc(var(--font-weight, 400) * var(--font-weight-multiplier, 1));
  letter-spacing: var(--letter-spacing, 0);
}

body {
  background: var(--background, #fff);
  color: var(--color, #222);
}

```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 350px;"><iframe id="cp_embed_NWNLPXX" src="//codepen.io/anon/embed/NWNLPXX?height=350&amp;theme-id=1&amp;slug-hash=NWNLPXX&amp;default-tab=result" height="350" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed NWNLPXX" title="CodePen Embed NWNLPXX" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

고정 폭 글꼴 외에도 개별 문자가 무게에 관계없이 동일한 양의 가로 공간을 차지하도록 특별히 설계된 다른 서체가 있습니다.
 예를 들어 "i"가 400의 가중치로 5 개의 수평 픽셀 공간을 차지하고 "w"가 동일한 가중치로 13 개의 픽셀을 차지하는 경우 가중치가
 700.
 

Arrow Type의 Recursive Sans는 그러한 서체 중 하나입니다.
 다음 이미지는 Recursive의 문자가 글꼴 두께 승수를 사용하여 라이트 모드, 기본 어두운 모드 및 어두운 모드에서 각각 동일한 너비를 유지하는 방법을 보여줍니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_11ADE8066BDA656E85D38D4A3C608C6A59895CF399F2DA91F836EA0190B5E285_1600715869660_image.png?resize=755%2C369&ssl=1)

Recursive와 같은 다중 글꼴은 어두운 모드에서 글꼴 두께를 변경할 때 문자 간격을 조정할 필요가 없도록 설계되었습니다.
 요소 크기와 페이지 흐름은 그대로 유지됩니다.
 

### 전략 2 : 가변 글꼴의 등급 축 조정
 

등급 축 (` "GRAD"`)은 실제 `글꼴 두께`값이나 문자 너비를 변경하지 않고 글꼴의 겉보기 두께를 변경합니다.
 이 축에 글꼴을 사용할 때 글꼴 가중치 승수 변수가 전혀 필요하지 않을 수 있습니다.
 

Type Network의 무료 Roboto Flex 글꼴의 경우 등급 -1은 가장 얇고 0 (기본값)은 보통, 1은 가장 굵습니다.
 이 글꼴을 사용하여 어두운 모드에 대해 등급 축에 약 -.75 값을 할당하여 시작합니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/12/tKkKNJNg.png?resize=627%2C366&ssl=1)

```css
:root {
  --GRAD: 0;
}

@media (prefers-color-scheme: dark) {
  :root {
    --GRAD: -.75;
  }
}

body {
  font-variation-settings: "GRAD" var(--GRAD, 0);
}
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 350px;"><iframe id="cp_embed_OJNoyay" src="//codepen.io/anon/embed/OJNoyay?height=350&amp;theme-id=1&amp;slug-hash=OJNoyay&amp;default-tab=result" height="350" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed OJNoyay" title="CodePen Embed OJNoyay" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

그러니 기울기 축을 조정하는 것이 가능하다면 완벽한 해결책처럼 보입니다. 맞죠?
 글쎄, 아마도.
 그것을 고려할 때 염두에 두어야 할 몇 가지가 있습니다.
 

첫째, 모든 글꼴의 비율이 항상 -1에서 1이되는 것은 아닙니다. 일부 범위는 0에서 1까지입니다. 최소 하나의 서체는 백분율을 사용하므로 100이 기본값이됩니다.
 다른 글꼴은 등급 척도를 글꼴 두께에 맞추므로 범위는 100-900과 같을 수 있습니다.
 후자의 경우 등급 축을 사용하려면 모든 글꼴 가중치를 기본값 인 400으로 설정 한 다음 모든 가중치 변경에 등급 축을 사용해야 할 수 있습니다.
 다크 모드의 경우 기본적으로 글꼴 가중치 승수 솔루션 에서처럼 등급을 처리 할 수 있습니다. 승수를`글꼴 변형 설정`의` "GRAD"`축에 적용합니다.
 

두 번째주의 사항은 일부 서체에서는 글꼴을 기본 두께보다 낮은 값으로 등급을 매길 수 없다는 것입니다.
 그래서 학년은 그것을 전혀 밝힐 수 없습니다.
 Apple의 샌프란시스코 서체 (Apple 기기에서`font-family : system-ui;`를 통해 테스트 할 수 있음)에는이 두 가지 문제가 모두 있습니다.
 macOS Catalina부터 샌프란시스코에는 등급 축이 있습니다.
 글꼴 두께와 일치하도록 크기가 조절되며 최소값은 400입니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_11ADE8066BDA656E85D38D4A3C608C6A59895CF399F2DA91F836EA0190B5E285_1600878564188_image.png?resize=701%2C76&ssl=1)

등급을 400보다 낮은 값으로 설정할 수 없기 때문에 어두운 모드에서 글꼴을 기본값 인 400에서 밝게 할 수 없습니다.
 더 낮추려면 대신 가중치 축 값을 낮춰야합니다.
 

### 전략 3 : 가변 글꼴 다크 모드 축 조정
 

현재이 글을 쓰는 시점에 다크 모드 (` "DRKM"`) 축이있는 서체는 Dalton Maag의 Darkmode입니다.
 

다크 모드 축은 기본적으로 미세 조정이없는 그레이드 축입니다.
 어두운 모드에서 더 얇게 보이려면 켜고 (`1`) 일반 디스플레이에서는 끄십시오 (기본값 :`0`).
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_11ADE8066BDA656E85D38D4A3C608C6A59895CF399F2DA91F836EA0190B5E285_1600891115629_image.png?resize=696%2C369&ssl=1)

```css
:root {
  --DRKM: 0;
}

@media (prefers-color-scheme: dark) {
  :root {
    --DRKM: 1;
  }
}

body {
  font-variation-settings: "DRKM" var(--DRKM, 0);
}
```

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 350px;"><iframe id="cp_embed_bGpxVZw" src="//codepen.io/anon/embed/bGpxVZw?height=350&amp;theme-id=1&amp;slug-hash=bGpxVZw&amp;default-tab=result" height="350" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed bGpxVZw" title="CodePen Embed bGpxVZw" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

저는 Darkmode 글꼴을 많이 좋아합니다.
 하지만 전문가 용으로 필요한 상용 라이선스라는 점에 유의하세요.
 Dalton Maag는 "학업, 투기 또는 투고 목적으로 만"사용할 수있는 평가판을 제공합니다.
 이 서체가 더 많은 Dalton Maag 가족이 darkmode 축을 얻을 수있는 파일럿이되기를 바랍니다. 그러면 다른 글꼴 파운드리가이를 따르기를 바랍니다!
 

### 고려해야 할 기타 요소
 

다크 모드 컨텍스트에서 가변 글꼴로 작업하기위한 몇 가지 큰 전략을 다루었습니다.
 그러나 대부분의 경우와 마찬가지로 하나 또는 다른 솔루션으로 당신을 움직일 수있는 다른 고려 사항이 있습니다.
 

픽셀 밀도가 높은 화면 (예 : 대부분의 최신 휴대폰, MacBook, iMac 등)에서는 다크 모드의 두껍게하는 효과가 덜 두드러지는 경우가 많습니다.
 따라서 이러한 화면에서 글꼴을 너무 얇게 만들고 싶지 않을 수도 있습니다.
 

그래도 글꼴을 약간 밝게하려면 다른 미디어 쿼리를 추가하여 효과를 덜 심하게 만들 수 있습니다.
 사용중인 솔루션에 따라`--font-weight-multiplier` 값을 1에 가깝게 높이거나`--GRAD` 값을 0에 가깝게 높이거나`--DRKM`을 모두 비활성화 할 수 있습니다 (둘 중 하나이기 때문에
 켜짐 또는 꺼짐, 중간 없음).
 

이 쿼리를 추가하는 경우 원래`prefers-color-scheme` 쿼리 아래에 배치해야합니다. 그렇지 않으면 효과가 없을 수 있습니다.
 미디어 쿼리는 CSS 특이성을 추가하지 않으므로 순서가 중요합니다!
 

```css
@media (prefers-color-scheme: dark) and (-webkit-min-device-pixel-ratio: 2), 
       (prefers-color-scheme: dark) and (min-resolution: 192dpi) { 
  :root {
    --font-weight-multiplier: .92;
    /* Or, if you're using grade or darkmode axis instead: */
    /* --GRAD: -.3; */
    /* --DRKM: 0; */
  }
}
```

어두운 모드의 고밀도 화면에서 글꼴을 전혀 밝게하지 않으려면 원래의 어두운 모드`prefers-color-scheme` 쿼리를 다음으로 업데이트하여 이러한 화면을 생략 할 수 있습니다.
 

```css
@media (prefers-color-scheme: dark) and (-webkit-max-device-pixel-ratio: 1.9), 
       (prefers-color-scheme: dark) and (max-resolution: 191dpi) { 

  /* Custom properties for dark mode go here. */

}
```

사이트에서 둘 이상의 서체를 사용하는 경우 이러한 조정이 모든 서체에 미칠 수있는 영향을 고려해야합니다.
 예를 들어 교차하는 축이있는 여러 글꼴을 사용하는 경우 실수로 여러 전략의 효과를 결합 할 수 있습니다 (예 : 등급과 가중치를 동시에 줄임).
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_11ADE8066BDA656E85D38D4A3C608C6A59895CF399F2DA91F836EA0190B5E285_1606160621835_image.png?resize=757%2C133&ssl=1)

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 500px;"><iframe id="cp_embed_KKMOoZR" src="//codepen.io/anon/embed/KKMOoZR?height=500&amp;theme-id=1&amp;slug-hash=KKMOoZR&amp;default-tab=result" height="500" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed KKMOoZR" title="CodePen Embed KKMOoZR" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

사이트의 모든 글꼴이 가변적이고 배율 및 범위가 일치하는 등급 축이있는 경우 (예 : 모두 범위가 -1에서 1 인 경우) 이것이 제가 권장하는 솔루션입니다.
 그러나 이러한 기준을 충족하지 않는 다른 글꼴을 나중에 추가하려는 경우에는이를 다시 확인해야합니다.
 더 널리 퍼지면 darkmode 축도 마찬가지입니다.
 

모든 글꼴이 가변적이지만 모두 동일한 축 (예 : 등급 및 어두운 모드)을 공유하지 않는 경우 `--font-weight-multiplier`맞춤 속성 만 사용하는 것이 가장 안전한 방법 일 수 있습니다.
 

마지막으로, 가변 및 비가 변 글꼴을 혼합하는 경우 일부 예외를 제외하고는 이러한 솔루션을 사용해도 비가 변 글꼴의 모양이 변경되지 않습니다.
 예를 들어 `font-weight`속성과 함께 글꼴 두께 승수를 사용하는 경우 글꼴 두께의 일부 (전부는 아닐 수도 있음)가 다음으로 낮은 가중치 이름으로 이동할 수있을만큼 충분히 변경 될 수 있습니다.
 

사이트에 일반 (400), 세미 볼드 (600) 및 굵게 (700)의 세 가지 가중치가있는 글꼴이 있다고 가정 해보십시오.
 어두운 모드에서는 굵은 텍스트가 약간 밝아 져서 약간 굵게 표시 될 수 있습니다.
 그러나 일반 글꼴은 여전히 규칙적으로 유지됩니다 (사이트에 포함 된 가장 낮은 가중치).
 이러한 불일치를 방지하려면 `font-weight`가 아닌 `font-variation-settings`를 통해 가변 글꼴 가중치를 적용하여 가변 글꼴이 전혀 영향을받지 않도록 할 수 있습니다.
 그들은 항상 다크 모드에서 기본 가중치를 유지합니다.
 

### 마지막으로
 

보완 기술이 거의 동시에 공통적으로 사용되는 것은 언제나 행복한 우연입니다.
 다크 모드와 가변 글꼴의 인기가 높아짐에 따라 후자를 사용하여 전자의 문제 중 하나를 완화 할 수 있습니다.
 가중치, 등급 및 어두운 모드 축과 함께 CSS 사용자 정의 속성을 사용하면 밝은 모드와 어두운 모드 모두에서 텍스트 모양에 일관성을 가져올 수 있습니다.
 

이 기사의 글꼴과 축이있는 대화식 데모를 방문 할 수 있습니다.
 