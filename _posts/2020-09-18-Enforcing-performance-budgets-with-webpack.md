---
layout: post
title: "웹 팩으로 성능 예산 집행"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/09/piggy-bank.jpg
tags: PERFORMANCE BUDGET,WEBPACK
---


아시다시피 단일 단일 모놀리식 JavaScript 번들은 더 이상 최신 웹 애플리케이션을 위한 방법이 아닙니다. 연구에 따르면 대용량 번들로 인해 메모리 사용량과 CPU 비용이 증가하며, 특히 미드레인지 및 로우엔드 모바일 장치에서 이러한 비용이 증가하는 것으로 나타났습니다.

웹 팩에는 더 작은 번들을 달성하고 리소스의 로드 우선 순위를 제어하는 데 도움이 되는 많은 기능이 있습니다. 그 중 가장 주목할 만한 것은 코드 분할이며, 코드를 다양한 번들로 분할하여 요청 시 또는 병렬로 로드할 수 있는 방법을 제공합니다. 또 다른 하나는 성능 힌트로, 빌드 시 방출된 번들 크기가 지정된 임계값을 초과할 때 이를 표시하여 최적화를 수행하거나 불필요한 코드를 제거할 수 있습니다.

웹 팩의 프로덕션 빌드의 기본 동작은 자산 크기 또는 진입점의 크기가 250KB(244KiB)를 초과할 때 경고를 표시하는 것이지만, `webpack.config.js` 파일의 `performance` 개체를 통해 성능 힌트가 표시되는 방법과 임계값 크기를 구성할 수 있습니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/09/image.png?resize=1740%2C1392&ssl=1)

이 기능과 성능 저하에 대한 첫 번째 방어선으로 활용하는 방법에 대해 살펴보겠습니다.

### 먼저, 우리는 맞춤형 예산을 책정해야 한다.

자산 및 진입점의 기본 크기 임계값(웹 팩이 번들 생성을 시작하는 경우)은 항상 사용자의 요구 사항에 맞지는 않지만, 원하는 대로 구성할 수 있습니다.

예를 들어, 블로그는 매우 최소이며 예산 크기는 자산 및 진입점에서 모두 50KB(48.8KiB)에 불과합니다. 다음은 `webpack.config.js`의 관련 설정입니다.

```js
module.exports = {
  performance: {
    maxAssetSize: 50000,
    maxEntrypointSize: 50000,
  }
};
```

maxAssetSize와 maxEntrypointSize 속성은 각각 자산과 진입점의 임계값 크기를 제어하며 둘 다 바이트 단위로 설정됩니다. 후자는 `entry` 객체에 나열된 파일(일반적으로 JavaScript 또는 Sass 파일)에서 생성된 번들이 지정된 임계값을 초과하지 않도록 하는 반면, 전자는 웹 팩에서 방출되는 다른 자산(예: 이미지, 글꼴 등)에 대해 동일한 제한을 적용합니다.

### 임계값을 초과할 경우 오류를 표시하겠습니다.

웹 팩의 기본 경고는 예산 임계값을 초과할 때 발생합니다. 개발 환경에는 충분하지만 생산을 위해 건설할 때는 부족합니다. 대신 성능 개체에 힌트 속성을 추가하고 이를 `error`로 설정하여 오류를 트리거할 수 있습니다.

```js
module.exports = {
  performance: {
    maxAssetSize: 50000,
    maxEntrypointSize: 50000,
    hints: 'error',
  }
}; 

```

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/09/image-1.png?resize=1726%2C1392&ssl=1)

힌트(hints) 속성에 대한 다른 유효한 값도 있는데, 경고(warning)와 거짓(false)은 지정된 제한이 침해되어도 경고를 완전히 비활성화한다. 저는 생산 모드에서 false를 사용하는 것을 추천하지 않습니다.

### 예산에서 특정 자산을 제외할 수 있습니다.

웹 팩은 방출되는 모든 유형의 자산에 대해 크기 임계값을 적용합니다. 배출된 자산 중 하나라도 지정된 한도를 초과하면 오류가 발생하기 때문에 항상 좋은 것은 아닙니다. 예를 들어 이미지를 처리하도록 웹 팩을 설정할 경우 해당 중 하나만 임계값을 초과하면 오류가 발생합니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/09/image-2.png?resize=1752%2C1190&ssl=1)

`assetFilter` 속성은 성능 힌트를 계산하는 데 사용되는 파일을 제어하는 데 사용할 수 있습니다.

```js
module.exports = {
  performance: {
    maxAssetSize: 50000,
    maxEntrypointSize: 50000,
    hints: 'error',
    assetFilter: function(assetFilename) {
      return !assetFilename.endsWith('.jpg');
    },
  }
}; 
 
 

```

성능 힌트 계산을 실행할 때 웹 팩에 .jpg 확장자로 끝나는 모든 파일을 제외하도록 지시합니다. 환경, 파일 형식 및 기타 리소스에 대한 모든 종류의 조건을 충족하는 보다 복잡한 논리가 가능합니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/09/image-3.png?resize=1024%2C571&ssl=1)

### 제한사항

이것이 제게 좋은 해결책이었지만, 제가 깨달은 한계는 모든 자산과 진입점에 동일한 예산 임계값이 적용된다는 것입니다. 즉, JavaScript, CSS 및 이미지 파일에 대한 다른 제한과 같이 필요에 따라 여러 개의 예산을 책정할 수 없습니다.

즉, 이 제한을 제거해야 하는 공개 풀 요청이 있지만 아직 병합되지는 않았습니다. 확실히 지켜봐야 할 것 같아.

### 결론

성능 예산을 책정하는 것은 매우 유용하며 웹 팩으로 웹 팩을 적용하는 것은 프로젝트를 시작할 때 고려할 가치가 있습니다. 이것은 여러분의 의존성의 크기에 관심을 끌 것이고 여러분이 가능한 한 예산을 초과하지 않도록 더 가벼운 대안을 찾도록 격려할 것입니다.

하지만, 성능 예산은 여기서 끝나지 않습니다! 자산 크기는 성능에 영향을 미치는 여러 가지 요소 중 하나에 불과하므로 최적의 환경을 제공하기 위해 더 많은 작업을 수행해야 합니다. Lighthouse 테스트를 실행하는 것은 개선을 위한 제안뿐 아니라 사용할 수 있는 다른 메트릭스에 대해 알아보는 훌륭한 첫 번째 단계입니다.

읽어줘서 고마워, 그리고 행복한 코딩!