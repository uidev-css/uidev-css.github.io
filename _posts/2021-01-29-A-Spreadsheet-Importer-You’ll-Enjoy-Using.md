---
layout: post
title: "즐겁게 사용할 수있는 스프레드 시트 가져 오기 도구
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/11/1200x628-%E2%80%93-Portal-Demo-v1.png
tags: 
---


훌륭한 개발자 도구는 일반적으로 개발자의 전체 작업이되는 고통스러운 작업을 수행하며이를 즐겁게 만듭니다.
 개인적인 예로, 과거에 여러 번 이미지 업로드 경험을 구축해야했습니다.
 나는 그것들을 직접 코딩했고 그렇게하는 데 너무 많은 고통을 경험했습니다.
 그런 다음 Filestack을 사용했고 모든 것이 훨씬 쉬워 졌을뿐만 아니라 개선되었습니다.
 

이미지 업로드보다 더 어려운 게 뭔지 알아?
 스프레드 시트 가져 오기.
 왜?
 사용자가 스프레드 시트를 업로드 할 때 단순히 파일을 호스팅하는 것이 아니라 스프레드 시트 내부의 데이터를 가져 오기 때문에 훨씬 까다로운 프로젝트입니다.
 필드는 올바른 위치에 매핑되어야합니다.
 백엔드에서 잘못된 데이터를 수정해야합니다.
 그리고 모든 것이 빠르고 직관적이어야합니다.
 Flatfile을 입력합니다.
 핵심 제품인 Portal을 사용하면 스프레드 시트 가져 오기 도구를 다시 만들 필요가 없습니다. 감사합니다.
 

이걸로 안내해 드리겠습니다.
 

### 사용자에게 데이터가 있습니다.
 

매우 유용한 작업을 수행하는 웹 소프트웨어 제품을 만들고 있다고 가정 해 보겠습니다.
 예를 들어 자동화 된 마케팅 이메일 등을 통해 도움이 될 수 있습니다.
 고객은 일부 고객 데이터를 앱으로 가져 와서 사용을 시작하려고합니다.
 스프레드 시트는 범용 데이터 전송 형식 (예 : 고객이 다른 제품에서 데이터를 내보냈을 수 있음)이기 때문에 스프레드 시트 (예 :`.csv` 또는`.xls` 파일)에이 데이터가있을 수 있습니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/11/Screen-Shot-2020-11-09-at-1.22.12-PM.png?resize=2162%2C1336&ssl=1)

### 수입 경험을 구축해야합니다.
 

고객이 데이터를 빠르고 쉽게 이동할 수 없다면 웹 앱은 고객에게 거의 유용하고 가치가 없습니다.
 따라서 직관적 인 가져 오기 경험을 구축하기 시작했습니다.
 개발자이므로이 작업을 수행 할 수 있습니다.
 파일 업로드 구성 요소를 빌드합니다.
 파일 파서를 빌드합니다.
 모든 작동 방식과 수입 업체의 데이터 기대치에 대한 문서를 작성합니다.
 글쎄, 그렇게 할 수는 있지만 개발 시간이 더 길지 않으면 몇 주가 걸리고 최종 결과는 (약속합니다) 부진합니다.
 강력한 오류 처리 기능이 없을 것입니다.
 세련된 UI가 없습니다.
 완전한 경험을 테스트하는 데 수없이 많은 시간이 걸리지 않을 것입니다.
 

### 아웃소싱 할 시간입니다.
 

그 모든 일 대신에 우리가 쓸 수 있다면 ...
 

```html
<FileImporter config={config} />
```

이것이 기본적으로 Flatfile이하는 일입니다!
 바로 여기에 데모가 있습니다.이 데모는 기능이 무엇인지 실제로 확인할 수있을만큼 충분히 복잡합니다.
 

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 450px;"><iframe id="cp_embed_YzWJdQN" src="//codepen.io/anon/embed/YzWJdQN?height=450&amp;theme-id=1&amp;slug-hash=YzWJdQN&amp;default-tab=result" height="450" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed YzWJdQN" title="CodePen Embed YzWJdQN" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

질문하기 전에… 안전한가요?
 예.
 GDPR을 준수합니까?
 예.
 SOC 2 유형 1?
 예.
 HIPAA?
 예.
 자신의 상자에서 실행할 수 있습니까?
 예.
 

### 우아한 수입 경험이 있습니다.
 

사용자가 버튼을 클릭하면 스프레드 시트를 가져 오거나 데이터를 수동으로 입력 할 수있는 전체 페이지 가져 오기 환경이 제공됩니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/11/Screen-Shot-2020-11-09-at-1.47.11-PM.png?resize=2744%2C1390&ssl=1)

앱에는 어떤 종류의 데이터를 예상하고 구성할지에 대한 요구 사항이 있습니다.
 그런 다음이 수입 업체는 고객의 데이터 형식을 확인하고 처음에 필요한 필드를 정확하게 매핑 할 수 있도록합니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/11/Screen-Shot-2020-11-09-at-1.50.07-PM.png?resize=2736%2C1476&ssl=1)

어 오!
 누락 된 데이터가 있습니다.
 Flatfile은 그것이 무엇인지 정확히 강조하는 훌륭한 작업을 수행합니다.
 고객은 가져 오는 동안 문제를 해결할 수 있습니다.
 CSV 파일을 다시 가져올 필요가 없습니다.
 사용자는 실제로 데이터를 정리하고 무슨 일이 일어나고 있는지 정확히 이해할 수있는 직관적 인 기회를 갖게됩니다.
 이것은 자신을 구축하는 데 매우 중요하지 않습니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/11/Screen-Shot-2020-11-09-at-1.51.37-PM.png?resize=1224%2C696&ssl=1)

문제를 해결하거나 잘못된 데이터를 버리고 가져 오기를 계속할 수 있습니다.
 

그리고 앱에서 사용할 상호 작용에서 깔끔한 JSON 데이터를 얻을 수 있습니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/11/Screen-Shot-2020-11-09-at-1.55.02-PM.png?resize=1510%2C754&ssl=1)

### 빌드 vs. 구매?
 

소프트웨어 제품을 구축 할 때 항상 이러한 사항을 평가해야합니다.
 내 경험상 구매하는 대신 빌드를 선택할 때 정말 확실합니다.
 특히 내가 구매하는 것이 내가 구축하는 것보다 부차적 인 경우 구매에 크게 무게를 둡니다.
 너무 많이 짓는 실수를 저질렀 기 때문에 그렇게 느낍니다.
 

우리 대부분은 업 로더 앱을 구축하지 않고 고객이 데이터를 가져 오기만하면되는 일부 앱을 구축하고 있습니다.
 나는 내 역할을 제대로하는 동안 다른 사람이 그 부분을 바로 잡도록 내버려두고 싶습니다.
 나를?
 하트 비트에서 스프레드 시트를 가져 오는 데 Flatfile을 사용합니다.
 