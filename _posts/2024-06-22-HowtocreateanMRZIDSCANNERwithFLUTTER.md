---
title: "Flutter로 MRZ ID 스캐너 만드는 방법"
description: ""
coverImage: "/assets/img/2024-06-22-HowtocreateanMRZIDSCANNERwithFLUTTER_0.png"
date: 2024-06-22 15:37
ogImage: 
  url: /assets/img/2024-06-22-HowtocreateanMRZIDSCANNERwithFLUTTER_0.png
tag: Tech
originalTitle: "How to create an MRZ ID SCANNER with FLUTTER"
link: "https://medium.com/@cferrercava/how-to-create-an-mrz-id-scanner-with-flutter-ddd6e950802c"
---


<img src="/assets/img/2024-06-22-HowtocreateanMRZIDSCANNERwithFLUTTER_0.png" />

기계 판독 영역(Machine-Readable Zone, MRZ)은 여권 및 신분증과 같은 다양한 신분증에서 사용되는 중요한 구성 요소로, 기계가 빠르고 정확하게 읽을 수 있는 형식으로 필수 정보를 인코딩합니다. MRZ에는 전화증 번호, 이름, 국적, 출생일 및 만료일과 같은 세부 정보가 포함된 고정 구조의 두 개 또는 세 개의 텍스트 라인이 일반적으로 포함됩니다.

본 프로젝트에서는 Flutter를 사용하여 MRZ 탐지 도구를 개발하여 효율적이고 신뢰할 수 있는 인식을 달성하기 위해 여러 고급 도구와 라이브러리를 활용했습니다. 이 구현의 핵심 구성 요소는 ML Kit의 텍스트 인식 API인데, 정규 표현식을 사용하여 MRZ 정보를 탐지하고 읽는 데 활용됩니다. 또한 메모리 및 성능을 효율적으로 관리하기 위해 Isolate Spawn을 활용하여 응용 프로그램이 집중적인 처리 작업 중에도 반응성이 유지되도록 보장했습니다. 마지막으로, Flutter 앱 내에서 고품질 카메라 기능을 용이하게 하는 Camera Awesome 패키지가 통합되었습니다.

이러한 강력한 도구를 결합하여, 응용 프로그램은 정확하게 MRZ 데이터를 탐지하고 처리하여, 신분증을 스캔하고 확인해야 하는 사용자들에게 원활한 경험을 제공할 수 있습니다.

<div class="content-ad"></div>

- 앱 만들기

![이미지](/assets/img/2024-06-22-HowtocreateanMRZIDSCANNERwithFLUTTER_1.png)

2. 종속 항목 추가

이러한 종속 항목은 이 프로젝트에서만 필요합니다.

<div class="content-ad"></div>

- camerawesome | Flutter package (pub.dev)
- google_mlkit_text_recognition | Flutter package (pub.dev)
- google_mlkit_commons | Flutter package (pub.dev)

3. 앱 구성하기

이 애플리케이션을 빌드하려면 특별한 요구 사항이 필요하지 않습니다. 그냥 각 패키지가 요청하는 대로 구현하면 됩니다 (제 경우에는 GITHUB가 통합되어 있습니다).
이 경우에는 podfile 구성과 최소 버전을 확인해야 합니다

![이미지](/assets/img/2024-06-22-HowtocreateanMRZIDSCANNERwithFLUTTER_2.png)

<div class="content-ad"></div>

<img src="/assets/img/2024-06-22-HowtocreateanMRZIDSCANNERwithFLUTTER_3.png" />

https://pub.dev/packages/google_mlkit_text_recognition#requirements에 가보세요. (google_ml_kit_commons도 유사한 요구 사항이 있습니다.)

Flutter 패키지인 camerawesome (pub.dev)

4. 시작하세요!

<div class="content-ad"></div>

먼저, 이 프로젝트에 Camera Awesome를 구현합니다.

그런 다음 카메라에 오버레이를 추가해야 합니다. 우리가 문서를 더 잘 보기 위해서는 화면 전체를 차지할 필요가 없으니, 가운데 부분에만 필요합니다.

그리고 나서 google_ml_kit_text_recognition을 사용하여 MRZ 코드를 인식하는 알고리즘을 구현할 것입니다.

마지막으로, 텍스트 처리 과정을 인식하는 클래스를 생성하고, 해당 클래스에는 2개의 메서드가 있습니다:

<div class="content-ad"></div>

A. firstDetectingProcess: MRZ 코드의 첫 번째 일치 검색

B. photoTextProcess: 여기서 MRZ 정보를 가져옵니다. 이 경우에는 콜롬비아 DNI에 필요하기 때문에 필요한 경우에 구현할 수 있습니다.

이것을 귀하의 응용 프로그램에 구현하려면 고립된 스폰을 사용하는 것을 권장합니다. 이렇게 하면 전화의 자원을 효율적으로 활용할 수 있습니다.
마지막으로, 고립체를 구현하려면 코드가 다음과 같아야 합니다.

코드를 실행하고 결과를 확인하세요:

<div class="content-ad"></div>

`<img src="/assets/img/2024-06-22-HowtocreateanMRZIDSCANNERwithFLUTTER_4.png" />`

이 글을 읽어주셔서 정말 감사합니다. 제가 이 포스트와 제 자신을 더 개선할 수 있는 방법에 대한 피드백을 정말 감사히 받겠습니다!