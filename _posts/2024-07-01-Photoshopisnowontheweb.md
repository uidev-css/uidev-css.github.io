---
title: "포토샵 웹 버전 출시 브라우저에서 바로 사용해보세요"
description: ""
coverImage: "/assets/img/2024-07-01-Photoshopisnowontheweb_0.png"
date: 2024-07-01 17:18
ogImage: 
  url: /assets/img/2024-07-01-Photoshopisnowontheweb_0.png
tag: Tech
originalTitle: "Photoshop is now on the web!"
link: "https://medium.com/@addyosmani/photoshop-is-now-on-the-web-38d70954365a"
---


WebAssembly + Emscripten, Web Components + Lit, Service Workers + Workbox 및 새로운 Web API를 통해 가능해졌어요. Chrome과 Adobe가 함께 협력하여 이를 즐기고 있어요.

웹(photoshop.adobe.com)에 Photoshop 데스크톱 애플리케이션을 가져오는 것은 브라우저로 매우 복잡하고 그래픽 집중적인 소프트웨어를 가져오는 데 거대한 새로운 이정표를 의미해요. 이는 Adobe 엔지니어들의 년에 걸친 노력과 Chrome과 같은 브라우저 공급업체와의 협력을 통해 가능하게 되었어요.

이 사례 연구에서는 고급 웹 기능의 잠금을 해제하는, 성능 최적화 및 가능성을 살펴볼 거예요. '웹으로의 Photoshop 여정'도 훌륭한 읽을거리에요.

# 비전: 브라우저에서의 Photoshop

<div class="content-ad"></div>

수십 년간 Photoshop은 이미지 편집과 그래픽 디자인 분야에서의 금잔디로, Windows와 macOS에서 창의력을 불어넣어 왔습니다. 하지만 데스크톱에서 해방되면 새로운 기회의 문이 열립니다.

웹은 어디에서나, 원활하게 접근할 수 있는 약속을 제공합니다. 사용자는 브라우저만 있으면 즉시 편집을 시작하고 협업을 시작할 수 있습니다. 설치가 필요하지 않습니다. 그리고 다양한 기기에서 신속하게 이어서 작업할 수 있습니다.

링크 기능은 워크플로우 공유를 가능하게 합니다. Photoshop 문서는 파일 시스템에 숨기지 않고 URL을 통해 액세스할 수 있습니다. 창조자는 협업자에게 쉽게 링크를 보낼 수 있습니다.

플랫폼 간 유연성. 웹을 사용한 런타임은 기본 운영 체제를 추상화시킵니다. Photoshop은 다중 플랫폼의 사용자에게 도달할 수 있습니다.

<div class="content-ad"></div>

하지만 상당한 기술적 어려움이 이 빛깔을 실현하는데 있어 장애물이 되었습니다. 특히 포토샵과 같이 강력한 앱이 웹에서 어떻게 작동할지에 대해 다시 고민할 필요가 있었습니다.

# 새로운 웹 기능이 포토샵의 잠재력을 발휘

최근 몇 년간, 표준화 및 구현을 통해 드디어 포토샵 수준의 애플리케이션을 가능하게 하는 새로운 웹 플랫폼 기능이 등장했습니다. Adobe 엔지니어들은 여러 핵심 차세대 API를 혁신적으로 활용하였습니다:

# 원본 개인 파일 시스템을 통한 고성능 로컬 파일 액세스

<div class="content-ad"></div>

포토샵 작업은 대용량 PSD 파일을 읽고 쓰는 것을 포함합니다. 이를 위해서 로컬 파일 시스템에 효율적으로 접근해야 합니다. 새 Origin Private File System API(OPFS)는 빠르고 특정 원점 가상 파일 시스템을 제공합니다.

```js
const opfsRoot = await navigator.storage.getDirectory();
```

OPFS를 사용하면 파일을 빠르게 생성, 읽기, 쓰기 및 삭제할 수 있습니다. 예를 들어:

```js
// 파일 생성
const file = await opfsRoot.getFileHandle('image.psd', {create: true}); 

// 읽기/쓰기 핸들 가져오기
const handle = await file.createSyncAccessHandle();

// 내용 쓰기  
handle.write(buffer); 

// 내용 읽기
handle.read(buffer);

// 파일 삭제
await file.remove();
```

<div class="content-ad"></div>

가장 빠른 동기 작업을 위해서는 Web Workers가 FileSystemSyncAccessHandle을 얻을 수 있습니다.

로컬 고성능 파일 시스템은 브라우저에서 Photoshop의 요구하는 파일 워크플로우를 구현하는 데 중요합니다.

# 웹어셈블리의 힘 발휘

WebAssembly는 JavaScript에서 Photoshop의 계산 집약적인 그래픽 처리를 재현하는 데 필수 요소였습니다. Adobe는 Emscripten 컴파일러를 사용하여 기존의 C/C++ 코드베이스를 WebAssembly 모듈로 이식했습니다.

<div class="content-ad"></div>

웹어셈블리(WebAssembly)의 여러 기능이 중요했어요:

- 쓰레드 — 포토샵은 이미지 타일 처리와 같은 작업을 병렬로 실행하기 위해 워커 스레드를 사용합니다:

```js
// 쓰레드 함수
void* tileProcessor(void* data) {
  // 이미지 타일 데이터 처리
  return NULL;
}

// 워커 스레드 시작
pthread_t thread1, thread2;
pthread_create(&thread1, NULL, tileProcessor, NULL);
pthread_create(&thread2, NULL, tileProcessor, NULL);

// 스레드가 작업을 완료할 때까지 대기
pthread_join(thread1, NULL);
pthread_join(thread2, NULL);
```

- SIMD — SIMD 벡터 명령어는 픽셀 처리 및 필터링을 가속화합니다.
- 예외 처리 — C++ 예외는 포토샵 코드베이스 전반에 널리 사용됩니다.
- 스트리밍 인스턴스화 — 포토샵의 80MB 이상의 WASM 모듈은 스트리밍 컴파일을 필요로 합니다.
- 디버깅 — 크롬의 웹어셈블리 디버깅 지원이 개발도구에서 큰 도움이 되었습니다.

<div class="content-ad"></div>

# 광범위한 P3 컬러 감마 활용하기

sRGB의 컬러 스펙트럼은 넓은 P3 감마와 비교하면 창의 앞에서 치졌지만, 웹에서는 오랫동안 유일한 옵션이었습니다.

![Photoshop is now on the web](/assets/img/2024-07-01-Photoshopisnowontheweb_0.png)

Photoshop은 새로운 color() 함수와 Canvas API를 사용하여 P3의 전체 삶을 끌어내어 더욱 정확한 컬러 표현을 가능하게 합니다.

<div class="content-ad"></div>

```js
color: color(display-p3 1 0.5 0)
```

# 웹 구성 요소와 UI 유연성

포토샵은 Adobe의 포괄적인 크리에이티브 클라우드 생태계의 일부입니다. Lit을 기반으로 한 표준화된 웹 구성 요소 전략을 사용하면 응용 프로그램 간에 일관된 UI를 제공할 수 있습니다.

포토샵의 UI 요소는 Adobe의 디자인 시스템을 구현하는 Adobe의 Spectrum 웹 구성 요소 라이브러리에서 가져옵니다.

<div class="content-ad"></div>

스펙트럼 웹 컴포넌트는 다음과 같습니다:

- 기본적으로 접근성을 고려함 — 보조 기술을 지원하기 위해 기존 및 새로운 브라우저 사양을 고려하여 개발되었습니다.
- 가벼움 — LitElement을 사용하여 최소한의 오버헤드로 구현되었습니다.
- 표준 기반 — 맞춤 요소(custom elements) 및 쉐도우 DOM과 같은 웹 컴포넌트 표준에 기반하여 구축되었습니다.
- 프레임워크에 중립적 — 브라우저 수준의 지원을 통해 모든 프레임워크와 작동할 수 있습니다.

또한, 전체 포토샵 앱은 Lit을 기반으로 한 웹 컴포넌트를 사용하여 구축되었습니다. Lit의 템플릿 및 가상 DOM 차이 비교(diffing) 기능을 통해 효율적인 UI 업데이트를 가능케 합니다. 또한 웹 컴포넌트 캡슐화를 통해 다른 팀에서 React 코드를 필요할 때 쉽게 통합할 수 있었습니다.

앞서 설명한 대로, 웹 컴포넌트의 브라우저 네이티브 맞춤 요소와 Lit의 성능이 조화를 이루어, 효율성을 유지하면서 포토샵의 복잡한 UI를 구축하는 데 필요한 유연성을 제공했습니다.

<div class="content-ad"></div>

# 브라우저에서 Photoshop 성능 최적화

새로운 웹 기능은 기본을 제공했지만, Photoshop과 같은 엄청난 데스크톱 응용 프로그램은 여전히 우수한 온라인 경험을 제공하기 위해 포괄적인 추적과 성능 작업이 필요했습니다.

![이미지](/assets/img/2024-07-01-Photoshopisnowontheweb_1.png)

# 서비스 워커를 사용하여 에셋 및 코드 캐싱하기

<div class="content-ad"></div>

서비스 워커는 웹 앱이 초기 방문 후에 로컬로 자산, 코드 및 기타 리소스를 캐시하여 훨씬 더 빠른로드 시간을 제공할 수 있습니다. 아직 완전히 오프라인 작동 가능한 앱은 아니지만, 포토샵은 이미 서비스 워커를 활용하여 WebAssembly 모듈, 스크립트 및 기타 자산을 캐시합니다.

이 캐싱은 로드 성능에 현격한 차이를 만들어냅니다. 첫 방문 후에는 일반적으로 로드가 매우 빨라집니다 (M1 Macbook):

Adobe는 Workbox 라이브러리를 사용하여 서비스 워커 캐싱을 더 쉽게 빌드 프로세스에 통합했습니다.

캐시된 리소스의 V8 최적화

<div class="content-ad"></div>

V8는 서비스 워커 캐시에서 리소스가 반환될 때 몇 가지 최적화를 적용합니다:

- 설치 중에 캐시된 리소스는 일관된 빠른 성능을 위해 즉시 컴파일되고 코드가 캐시 됩니다.
- 플레이어로 가져온 캐시 API를 통해 캐시된 리소스는 일반적인 캐싱보다 빠르게 최적화되어 2차로 로드됩니다.
- V8는 캐시되고 중요도 있는 리소스를 감지하고 더 적극적으로 컴파일합니다.

이러한 최적화를 통해 Photoshop의 대규모 캐시된 Wasm 모듈을 최적화할 수 있습니다.

![Photoshop is now on the web](/assets/img/2024-07-01-Photoshopisnowontheweb_2.png)

<div class="content-ad"></div>

# 대규모 WebAssembly 모듈의 스트리밍 및 캐싱

포토샵의 코드는 80MB 이상인 여러 대규모 WebAssembly 모듈을 필요로 합니다. V8 및 Chrome의 스트리밍 컴파일 지원을 통해 이러한 거대한 모듈을 효율적으로 처리할 수 있습니다.

또한, Service Worker로부터 처음으로 WebAssembly 모듈을 요청할 때 V8는 최적화된 버전을 생성하고 캐시에 저장합니다. 이것은 포토샵의 대규모 코드 크기에 필수적입니다.

# 병렬 그래픽 작업을 위한 멀티스레딩

<div class="content-ad"></div>

많은 중요한 이미지 처리 작업들은 픽셀 변환과 같은 Photoshop의 핵심 이미지 처리 작업들이 스레드 간 병렬 실행을 통해 대규모로 가속화될 수 있습니다. WebAssembly의 스레드 지원은 계산 집약적인 그래픽 작업을 수행하기 위해 다중 코어 장치를 활용할 수 있게 합니다.

이를 통해 Photoshop은 성능에 중점을 둔 이미지 처리 기능을 웹어셈블리로 이식할 때 데스크탑에서 사용하는 동일한 다중 스레딩 접근 방식을 활용할 수 있습니다.

# 최적화를 위한 웹어셈블리 디버깅

WebAssembly를 최적화하기 위해 튼튼한 웹어셈블리 디버깅 지원은 개발 중 성능 병목 현상을 진단하고 해결하는 데 중요합니다.

<div class="content-ad"></div>

Chrome DevTool은 WASM 코드를 프로파일링하고 중단점을 설정하며 다양한 변수를 검사할 수 있는 능력이 JavaScript의 디버깅 가능성과 유사합니다:

# TensorFlow.js를 활용한 기기 내 기계 학습 통합

웹상의 최신 Photoshop 버전에는 TensorFlow.js를 활용한 인공 지능 기능이 포함되어 있습니다. 클라우드가 아니라 기기에서 모델을 실행하는 것은 개인 정보 보호, 응답 속도, 비용면에서 개선되었습니다.

선택 주제 기능은 머신러닝을 사용하여 이미지에서 주요 전경 객체를 자동으로 추출하므로 복잡한 선택을 빠르게 처리할 수 있습니다.

<div class="content-ad"></div>

모델을 TensorFlow에서 TensorFlow.js로 변환하여 로컬 실행이 가능하도록 했어요:

```js
// 선택된 주제 모델 로드
const model = await tf.loadGraphModel('select_subject.json');

// 이미지 텐서에서 추론 실행  
const {mask, background} = model.execute(imgTensor);

// 마스크에서 선택을 정밀화하기
```

Adobe와 Google은 Photoshop의 WebAssembly 코드와 TensorFlow.js 간의 동기화 문제를 해결하기 위해 Emscripten을 위한 프록시 API를 개발하면서 협력했어요. 이를 통해 프레임워크 간의 원활한 통합이 가능해졌어요.

Conv2D와 같은 성능에 중점을 둔 중요한 작업에 초점을 맞춘 주요 모델이 최적화되었어요. Photoshop은 성능 요구 사항에 따라 장치 내 또는 클라우드에서 모델을 실행할지 선택할 수 있어요.

<div class="content-ad"></div>

TensorFlow.js 포토샵 문서에서 더 많은 내용을 확인해 보세요.

# 웹 상의 포토샵 미래

웹 상의 포토샵 일반 공개는 엄청난 이정표를 의미하지만, 가능성은 아직도 한계에 다다르지 않았습니다.

웹 상에서 포토샵은 계속해서 발전할 것이며, 브라우저 업체들이 표준과 성능을 진화시키면서 더 많은 기능이 점진적으로 추가될 것입니다. 그리고 포토샵은 단순히 시작에 불과합니다. Adobe는 웹 상에서 전체 크리에이티브 클라우드 스위트를 적극적으로 구축할 계획이며, 브라우저에서 더욱 정교한 디자인 응용 프로그램을 개발해 나갈 것입니다.

<div class="content-ad"></div>

Adobe와 브라우저 엔지니어들 간의 협력은 표준과 성능 개선을 통해 더욱 적극적인 응용 프로그램을 위한 웹 플랫폼으로의 전진을 이끌어나갈 것입니다. 미래에는 흥미로운 시기가 기다리고 있어요!

# 웹에서 포토샵 사용해보기

웹 상에서의 포토샵은 현재 다음의 데스크톱 버전 브라우저에서 이용 가능합니다:

- Chrome 102+
- Edge 102+
- Firefox 111+

<div class="content-ad"></div>

그리고 Safari에 대한 지원 갭을 메우기 위한 작업이 진행 중입니다.

오늘 photoshop.adobe.com에서 시도해 볼 수 있어요. 웹 상의 창의성과 디자인의 미래가 손끝에서 펼쳐집니다!