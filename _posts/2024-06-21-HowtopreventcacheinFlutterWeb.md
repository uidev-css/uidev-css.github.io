---
title: "Flutter 웹에서 캐시를 방지하는 방법"
description: ""
coverImage: "/assets/img/2024-06-21-HowtopreventcacheinFlutterWeb_0.png"
date: 2024-06-21 22:25
ogImage: 
  url: /assets/img/2024-06-21-HowtopreventcacheinFlutterWeb_0.png
tag: Tech
originalTitle: "How to prevent cache in Flutter Web"
link: "https://medium.com/codebrew/how-to-prevent-cache-in-flutter-web-dead8c8d3730"
---


![이미지](/assets/img/2024-06-21-HowtopreventcacheinFlutterWeb_0.png)

안녕하세요, 개발자님. 잘 지내시나요? 오늘의 주제는 조금 복잡할 수 있지만 걱정하지 마세요, 5분 안에 해결할 수 있을 거예요 :) 항상처럼 우리의 해결책은 간단하고 효과적입니다!

## 질문 1: 캐시란 무엇이며 브라우저가 캐시를 저장하는 이유는 무엇인가요?

- 브라우저 캐시는 웹 페이지, 이미지, 스크립트 등이 임시로 저장되는 장소로, 웹 브라우저가 여러분의 기기에 저장합니다. 웹 사이트를 방문하면 브라우저가 HTML, CSS, JavaScript 및 이미지와 같은 파일을 다운로드합니다. 매번 다운로드하는 대신 브라우저는 그 사본을 캐시에 저장합니다. 사이트를 재방문하면 브라우저가 파일 확인을 캐시에서 합니다. 그 파일들이 존재하고 유효 기간이 지나지 않았다면, 브라우저는 캐시에서 그 파일을 검색하여 페이지 로딩 속도를 높입니다.

<div class="content-ad"></div>

## 질문 2: 사람들이 캐시를 막거나 비활성화하려는 이유는 무엇인가요?

- 때로는 모든 콘텐츠(이미지 및 스타일 시트와 같은 리소스)가 매번 새로 고쳐져야 하는 중요성이 커질 수 있습니다. 놀랍게도 이러한 요소들은 특정 시나리오에서 중요할 수 있습니다.

이제 캐시에 대해 알았으니, 이어서 Flutter Web의 해결책을 살펴보겠습니다.

해결책은 간단합니다. Flutter Web에서 캐시 문제는 web/index.html 파일에 있는 main.dart.js라는 스크립트에서 발생합니다. 이를 해결하기 위해 이 스크립트 끝에 숫자나 변수를 추가하면 됩니다.

<div class="content-ad"></div>

우연히 손으로 매번 값 변경하거나 증가시키는 것을 피하기 위해 플러터는 index.html 파일에 "serviceWorkerVersion"이라는 미리 정의된 값을 제공합니다. 이 값을 수동으로 수정하는 대신 이 값을 사용할 수 있습니다.

플러터가 제공하는 "serviceWorkerVersion"을 사용하면 버전을 수동으로 갱신하는 대신 자동으로 증가되는 동적 해결책을 얻을 수 있습니다.

먼저 프로젝트로 이동하여 web/index.html 파일을 찾아보세요. 파일을 찾았다면, 이 페이지로 돌아와 다음 중 하나의 해결책을 적용하세요.

## Case 1: Flutter의 새로운 버전

<div class="content-ad"></div>

만약 새로운 Flutter 버전에서 캐시 문제를 방지해야 한다면, 몇 가지 스크립트를 수정해야 합니다. "main.dart.js" 스크립트는 기본적으로 존재하지 않기 때문에 직접 추가해야 합니다.

" _flutter.loader.loadEntrypoint"를 수정하고 추가 매개변수를 넣어야 합니다: "entrypointUrl: "main.dart.js?v=" + serviceWorkerVersion" 

최종적으로는 아래와 같이 스크립트 부분이 보여야 합니다:

```js
<script>
    window.addEventListener('load', function (ev) {
      // Download main.dart.js
      _flutter.loader.loadEntrypoint({
        entrypointUrl: "main.dart.js?v=" + serviceWorkerVersion,
        serviceWorker: {
          serviceWorkerVersion: serviceWorkerVersion,
        }
      }).then(function (engineInitializer) {
        return engineInitializer.initializeEngine();
      }).then(function (appRunner) {
        return appRunner.runApp();
      });
    });
  </script>
```

<div class="content-ad"></div>

이 작은 추가로 문제가 해결되었습니다! :)

## 케이스 2: Flutter의 이전 버전

이전 버전의 Flutter에서 캐시 문제를 방지해야하는 경우, web/index.html의 “scriptTag.src” 값이 다음과 같이 수정되어야 합니다: “scriptTag.src = ‘main.dart.js?v=’ + serviceWorkerVersion;”.

결국, 스크립트 섹션은 다음과 같이 보여야 합니다:

<div class="content-ad"></div>

```js
<script>
    var serviceWorkerVersion = null;
    var scriptLoaded = false;
    function loadMainDartJs() {
      if (scriptLoaded) {
        return;
      }
      scriptLoaded = true;
      var scriptTag = document.createElement('script');
      scriptTag.src = 'main.dart.js?v=' + serviceWorkerVersion;
      scriptTag.type = 'application/javascript';
      document.body.append(scriptTag);
    }

    if ('serviceWorker' in navigator) {
      // Service workers are supported. Use them.
      window.addEventListener('load', function () {
        // Wait for registration to finish before dropping the <script> tag.
        // Otherwise, the browser will load the script multiple times,
        // potentially different versions.
        var serviceWorkerUrl = 'flutter_service_worker.js?v=' + serviceWorkerVersion;
        navigator.serviceWorker.register(serviceWorkerUrl)
          .then((reg) => {
            function waitForActivation(serviceWorker) {
              serviceWorker.addEventListener('statechange', () => {
                if (serviceWorker.state == 'activated') {
                  console.log('Installed new service worker.');
                  loadMainDartJs();
                }
              });
            }
            if (!reg.active && (reg.installing || reg.waiting)) {
              // No active web worker and we have installed or are installing
              // one for the first time. Simply wait for it to activate.
              waitForActivation(reg.installing || reg.waiting);
            } else if (!reg.active.scriptURL.endsWith(serviceWorkerVersion)) {
              // When the app updates the serviceWorkerVersion changes, so we
              // need to ask the service worker to update.
              console.log('New service worker available.');
              reg.update();
              waitForActivation(reg.installing);
            } else {
              // Existing service worker is still good.
              console.log('Loading app from service worker.');
              loadMainDartJs();
            }
          });

        // If service worker doesn't succeed in a reasonable amount of time,
        // fallback to plaint <script> tag.
        setTimeout(() => {
          if (!scriptLoaded) {
            console.warn(
              'service worker disabled...',
            );
            loadMainDartJs();
          }
        }, 4000);
      });
    } else {
      // Service workers not supported. Just drop the <script> tag.
      loadMainDartJs();
    }
  </script>
```

With this small change, the problem is solved! :)

In this way, we have seen how to prevent the "Cache" problem in Flutter with simple solutions. I hope these solutions have been helpful to you.

If you have read this article and would like to support me, don't be shy — buy me a coffee! :) ☕☕☕


<div class="content-ad"></div>

커피 사줄래?

제가 이 글을 쓰는 데 도움이 된 몇 가지 링크가 있어요. 꼭 확인해 보세요!

- 문제 1 (반드시 확인해보세요!)
- 스택 오버플로우 1
- 스택 오버플로우 2
- 스택 오버플로우 3

이 글을 읽어 주셔서 감사합니다. 추가 질문이 있으시면 언제든지 댓글을 남겨 주세요. 그리고 박수 버튼 꾹 눌러주세요 :) 다음에 또 봐요, 개발자님 :)