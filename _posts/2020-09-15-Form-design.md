---
layout: post
title: "양식 설계"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/01/custom-form-inputs.png
tags: FORMS
---


게리 레이드의 건축 양식에 대한 아주 소화가 잘 되는 가이드입니다. 코드가 아니라 코드를 안내해야 하는 설계 및 UX 원칙입니다.

> 은행의 디자인 시스템을 만드는 일은 나에게 양식에 대해 많은 것을 가르쳐 주었다. 우리 실험실에서 시험하는 거 봤어 저는 전문 접근성 기관의 전문가들과 함께 일해왔습니다. 저는 장애인과 보조 기술 사용자가 테스트한 양식을 본 적이 있습니다. 저는 또한 많은 연구를 읽었습니다.
이 모든 학습으로부터 나는 나만의 베스트 프랙티스 지침을 만들었다.

일반적인 양식 조언에 관해서는 항상 코드와 관련된 한 가지를 생각합니다. 모든 입력에는 부착된 라벨이 필요합니다.

```html
<label for="name">Name:</label>
<input type="text" id="name" name="name">

<!-- or -->

<label>
  Name:
  <input type="text" name="name">
</label>
```

HTML 101인데 많은 양식이 실패해요. 한 번은 시각장애 대학생들이 어떤 형태로든 입력정보를 원하는지 알 수 없어 구체적으로 대학에 지원할 수 없다는 이야기를 들은 적이 있다. 그들은 그 경험 후에 스스로 대학을 갈 수 있을지 재추측하기 시작했다.

`이것을 막을 방법이 없다`는 기사를 양파에서 어떻게 인쇄하는지 아세요? `이런 일이 정기적으로 일어나는 나라만 말한다`는 기사를 말 그대로 대량학살이 있을 때마다 말이죠. 나는 누군가가 "No Way To Prevent This"와 같은 헤드라인과 함께 이 테스트에서 실패하는 모든 웹사이트를 가리키는 기사를 게재하는 웹사이트를 만들어야 한다고 생각한다.