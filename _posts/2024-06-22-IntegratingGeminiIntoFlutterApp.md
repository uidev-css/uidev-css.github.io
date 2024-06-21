---
title: "Flutter 앱에 Gemini 연동 방법"
description: ""
coverImage: "/assets/img/2024-06-22-IntegratingGeminiIntoFlutterApp_0.png"
date: 2024-06-22 05:06
ogImage: 
  url: /assets/img/2024-06-22-IntegratingGeminiIntoFlutterApp_0.png
tag: Tech
originalTitle: "Integrating Gemini Into Flutter App"
link: "https://medium.com/@aysealmaci/integrating-gemini-into-flutter-app-39d19d135d1b"
---


안녕하세요 여러분! 이 기사에서는 플러터 프로젝트에서 제미니를 사용하는 방법에 대해 이야기하고 싶습니다.

![Gemini](/assets/img/2024-06-22-IntegratingGeminiIntoFlutterApp_0.png)

## 제미니란 무엇인가요?
제미니 AI는 구글의 최첨단 AI 모델로, 인공지능 분야에서의 중요한 발전을 이루었습니다. 이 모델은 다양한 형식인 텍스트, 이미지, 오디오 및 비디오와 같은 콘텐츠를 이해하고 처리할 수 있는 다재다능한 기능으로 눈에 띕니다.

<div class="content-ad"></div>

젬니의 능력과 다양한 변형:

젬니는 특정 사용자 요구 사항을 충족하기 위해 세 가지 다른 변형을 제공합니다:

젬니 1.5 Pro: 이 신기술 모델은 AI의 경계를 넓혀 다양한 입력 형식인 오디오, 시각, 비디오, 텍스트를 처리합니다. 이 모델은 텍스트 생성, 코딩, 문제 해결, 데이터 추출과 같은 복잡한 작업에 뛰어납니다.

젬니 1.5 Flash: 민첩성으로 유명한 이 모델은 다양한 형식의 입력을 신속하게 처리하여 텍스트 결과물을 생성합니다. 이 모델의 다재다능함으로 다양한 작업에 효과적입니다.

<div class="content-ad"></div>

젬니 1.0 Pro: 자연어 처리 작업에 특화된 이 모델은 다양한 텍스트 및 코드 대화, 코드 생성과 같은 영역에서 우수한 성능을 보여줍니다.

언어 지원 및 API 액세스

젬니 모델은 약 40가지 다른 언어에서 작동하도록 훈련되어 다양한 사용자를 대상으로 합니다. 게다가, 젬니 API를 통해 개발자들은 이 강력한 AI 모델을 자신의 프로젝트에 통합할 수 있는 기회를 제공받습니다.

![이미지](/assets/img/2024-06-22-IntegratingGeminiIntoFlutterApp_1.png)

<div class="content-ad"></div>

## 플러터 프로젝트에 Gemini 통합하기 단계별 안내

API 키를 안전하게 보관하고 절대 공개하지 마세요.

![Gemini 통합 이미지](/assets/img/2024-06-22-IntegratingGeminiIntoFlutterApp_2.png)

다음 명령을 실행하여 추가하세요:

<div class="content-ad"></div>


flutter pub add google_generative_ai


이 패키지를 사용하려면 다트 코드에 이 줄을 추가하세요:

```dart
import 'package:google_generative_ai/google_generative_ai.dart';
```

```dart
import 'package:google_generative_ai/google_generative_ai.dart';

final apiKey = Platform.environment['API_KEY'];

final model = GenerativeModel(model: 'MODEL_NAME', apiKey: apiKey);
```

<div class="content-ad"></div>

[model] 인자는 `gemini-1.5-flash-latest`와 같은 모델 이름 또는 `models/gemini-1.5-flash-latest`와 같은 모델 코드가 될 수 있습니다.

GenerativeModel을 자세히 살펴봅시다.

## GenerativeModel이란 무엇인가요?

GenerativeModel 클래스는 텍스트, 이미지 또는 기타 콘텐츠를 생성하는 데 상호 작용하는 큰 언어 모델 (LLM)을 나타냅니다.

<div class="content-ad"></div>

```js
(new) GenerativeModel GenerativeModel({
  필수 요소 String model,
  필수 요소 String apiKey,
  List<SafetySetting> safetySettings = const [],
  GenerationConfig? generationConfig,
  List<Tool>? tools,
  Client? httpClient,
  RequestOptions? requestOptions,
  Content? systemInstruction,
  ToolConfig? toolConfig,
})
```

model 및 apiKey는 필수입니다. 다른 매개변수들은 선택 사항입니다.

매개변수 설명

필수 요소 String model: 사용하려는 특정 LLM의 이름 또는 식별자입니다 (예: "models/text-bison-001"). Gemini는 다양한 기능을 가진 여러 모델을 제공합니다.

<div class="content-ad"></div>

다음은 문서의 번역입니다:

`apiKey` 필수 문자열: Google Cloud에서 획득한 API 키는 요청을 인증하고 Gemini API에 액세스하는 데 필요합니다.

List`SafetySetting` safetySettings: 안전 설정은 LLMs와 작업할 때 중요한 측면입니다. 이러한 설정을 사용하면 모델 출력에 적용되는 콘텐츠 필터를 제어하여 해로운 또는 부적절한 콘텐츠 생성을 방지할 수 있습니다.

GenerationConfig? generationConfig: 이 매개변수는 모델이 응답을 생성하는 방식을 구성합니다. 다음과 같은 옵션이 포함되어 있습니다.

- temperature: 출력의 무작위성을 제어합니다(높은 값은 더 창의적이지만 정확하지 않을 수 있음).
- topP: 무작위성을 제어하는 대안적인 방법입니다.
- topK: 각 단계에서 상위 K개의 가장 가능성이 높은 단어를 고려하도록 모델을 제한합니다.
- maxOutputTokens: 생성된 응답의 길이에 대한 최대 제한을 설정합니다.

<div class="content-ad"></div>

List`Tool`? tools: 일부 LLM(라이프사이클 매니저)는 특히 최신 버전은 외부 도구를 사용하여 기능을 강화할 수 있습니다. 예를 들어, 계산기 도구는 수학 문제를 해결하는 데 도움이 될 수 있습니다.

Client? httpClient: API 요청을 만들기 위한 사용자 지정 HTTP 클라이언트입니다. 일반적으로 특별한 네트워크 요구사항이 없는 경우 기본 클라이언트를 신뢰할 수 있습니다.

RequestOptions? requestOptions: API 요청 동작을 세밀하게 조정하기 위한 추가 옵션입니다.

Content? systemInstruction: LLM의 전반적인 동작과 응답을 안내하는 지침입니다.

<div class="content-ad"></div>

ToolConfig? toolConfig: 모델에서 사용하는 외부 도구에 대한 추가 구성 옵션입니다.

이제 플러터 프로젝트에서 Gemini AI를 사용할 수 있습니다.

## 사용 예시:

Gemini를 사용하여 스토리 앱을 만들고 싶다고 가정해 봅시다.

<div class="content-ad"></div>

```js
최종 모델 = 생성 모델(
    모델: '젬니 1.5 프로',
    apiKey: Apiclass.apiKey,
    시스템명령: Content.system('당신은 이야기꾼이에요. 당신은 짧은 공포 이야기를 만드는 것을 좋아해요.'),);
      
콘텐츠 = [
    Content.text(
        "이야기를 써라")
    ];

응답 = await model.generateContent(content);
```

이 코드를 사용하면 Gemini는 짧은 공포 이야기를 좋아하는 이야기꾼처럼 행동합니다. "응답"에는 짧은 공포 이야기가 생성됩니다.

일부 UI 디자인 코드를 추가하면 결과물은 다음과 같습니다:

![이미지](/assets/img/2024-06-22-IntegratingGeminiIntoFlutterApp_3.png)

<div class="content-ad"></div>

스토리 앱의 모든 코드에 접근하려면 제 Github 페이지를 방문해 주세요!

더 많은 정보를 얻으시려면 Gemini API 문서와 Google AI 포럼을 방문하는 것을 잊지 마세요.

제 글을 읽어 주셔서 감사합니다. 연락을 원하시면 LinkedIn과 Twitter 계정을 통해 저에게 연락하실 수 있습니다. 다음 글에서 뵙겠습니다!