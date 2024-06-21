---
title: "Flutter에서 폼과 유효성 검사 실용 가이드"
description: ""
coverImage: "/assets/img/2024-06-21-FormsandValidationinFlutterAPracticalGuide_0.png"
date: 2024-06-21 22:50
ogImage: 
  url: /assets/img/2024-06-21-FormsandValidationinFlutterAPracticalGuide_0.png
tag: Tech
originalTitle: "Forms and Validation in Flutter: A Practical Guide"
link: "https://medium.com/@sparkleotech/forms-and-validation-in-flutter-a-practical-guide-45c614679272"
---


모바일 폼은 스마트폰, 태블릿 등의 모바일 장치로 접근할 수 있는 전자 버전의 종이 양식입니다.

현재의 대부분의 모바일 및 웹 애플리케이션은 양식을 어떤 형태로든 사용합니다. 주로 사용자가 앱과 소통하고 정보를 제공할 수 있는 방법으로 기능합니다. 비즈니스 요구 사항 및 논리의 성격에 따라 다양한 기능을 수행할 수 있습니다. 일반적으로 다음과 같은 일반적인 기능이 포함됩니다:

1. 사용자 인증

2. 사용자 추가

<div class="content-ad"></div>

3. 검색

4. 필터링

5. 정렬

6. 예약

<div class="content-ad"></div>

양식에 포함될 수 있는 요소로는 다음과 같은 것들이 있을 수 있습니다:

1. 텍스트 필드

2. 버튼

3. 체크박스

<div class="content-ad"></div>

4. 라디오 버튼

디지턈 양식의 장점은 다음과 같이 언급됩니다:

1. 정보의 이동성이 크다.

2. 기민성이 향상된다.

<div class="content-ad"></div>

3. 높은 정밀도

4. 더 뛰어난 응답 능력

5. 더 빠른 콘텐츠 수정

# 폼 관리의 중요성

<div class="content-ad"></div>

양식 관리는 데이터 수집과 결정을 위해 양식을 생성, 보급, 완료, 평가하고 자동화하는 프로세스를 의미합니다.

양식은 옛날에는 물리적인 물건이었지만, 많은 기업들이 종이 양식 대신 전자 문서를 사용하도록 전환했습니다. 자동화는 기존에 인간이 처리하던 작업을 기술을 사용하여 처리하는 것을 의미하며, 양식 관리도 그 예외가 아닙니다.

# 양식

종이 양식의 온라인 버전인 디지털 양식은 조직 내에서 빠르게 흘러가는 데이터를 캡처하는 데 사용됩니다. 기업이 데이터를 정확하게 기록하고 작업을 시작하는 주요 방법으로 종이 양식을 빠르게 대체하고 있습니다.

<div class="content-ad"></div>

디지턈 폼으로 전환함으로써 놀라운 많은 이점이 있습니다. 실시간 위치 공유, 이미지 촬영 및 추가, 신속한 계산 수행, 시간 추적 및 바코드 스캔 등 다양한 기능을 제공합니다.

디지턈 폼을 사용하면 데이터의 구성이 간단합니다. 위치, 신원, 주소 또는 기타 중요 정보와 같은 데이터를 수집하고 구성할 수 있습니다. 모든 데이터가 한 곳에서 처리 및 저장되기 때문에 사용자는 언제든지 어디서든 데이터에 액세스할 수 있습니다.

폼을 디지턈화함으로써 수집된 모든 정보를 신속하고 효과적으로 체계적으로 보관할 수 있습니다. 이러한 조정은 비즈니스가 시간과 비용을 절약하며 일상적인 작업 생산성과 효율성을 향상시킬 수 있도록 도와줄 것입니다.

# Flutter forms

<div class="content-ad"></div>

요즘에는 모바일 애플리케이션이나 웹 애플리케이션에서 양식이 필수적인 구성 요소입니다. 사용자 정보는 양식을 사용하여 수집됩니다. 플러터는 양식 위젯을 제공하여 양식을 개발할 수 있습니다. 이 양식 위젯의 컨테이너 기능을 사용하여 여러 양식 필드를 그룹화할 수 있습니다. 양식을 생성할 때 고유하게 식별할 수 있도록 GlobalKey가 필요하며 양식 필드를 유효성 검사할 수 있습니다.

사용자가 텍스트를 입력할 수 있도록 하려면 양식 위젯이 자식 위젯인 TextFormField를 사용합니다. 이 위젯은 머티리얼 디자인의 텍스트 필드를 제공하며 발생하는 유효성 검사 문제를 보여줄 수 있습니다.

사용자는 앱에서 자주 텍스트 필드에 데이터를 입력해야 합니다. 예를 들어, 이메일 주소와 비밀번호를 사용하여 사용자가 로그인해야 할 수도 있습니다. 애플리케이션을 안전하고 사용하기 쉽도록 만들기 위해 제공된 정보의 유효성을 확인하십시오. 사용자가 양식을 올바르게 작성했을 경우 데이터를 처리하십시오. 잘못된 정보를 제출할 경우 사용자에게 문제를 알리는 유용한 오류 메시지를 표시하십시오.

# 양식 유효성 검사

<div class="content-ad"></div>

특정 기준을 수정하거나 확인할 수 있는 기술을 검증이라고 합니다. 데이터 입력의 신뢰성을 보장합니다. 양식 유효성 검사는 모든 디지털 거래에서의 표준 절차입니다. Flutter에서 양식을 유효성 검사하는 데 필요한 세 가지 단계를 구현해야 합니다.

1. Form 위젯과 함께 전역 키를 사용합니다.
   
2. TextFormField를 사용하여 입력 필드에 validator 속성을 제공합니다.
   
3. 양식 필드를 확인하고 오류를 표시할 버튼을 만듭니다.

<div class="content-ad"></div>

# 양식 생성

다음 단계를 따라 양식을 만들어보세요:

## GlobalKey가 포함된 양식 만들기

먼저 Form을 만들어보세요. Form 위젯을 사용하여 여러 양식 필드를 모아 유효성을 검사할 수 있습니다. 양식을 만들 때 GlobalKey를 지정해 주세요. 이를 통해 양식 유효성을 확인하고 양식을 고유하게 식별할 수 있게 됩니다.

<div class="content-ad"></div>

# 유효성 검사 로직이 추가된 TextFormField를 추가해야 합니다

양식은 있지만 사용자가 사용할 수 있는 텍스트 입력 필드가 없습니다. TextFormField의 역할은 이를 수행하는 것입니다. TextFormField 위젯은 텍스트 필드를 재료 디자인으로 표시하고 유효성 검사 문제를 표시할 수 있습니다. TextFormField에 입력을 확인하는 validator() 함수를 제공하세요. validator 메서드는 사용자의 입력이 잘못된 경우 오류 메시지가 포함된 문자열을 반환합니다. 오류가 없는 경우 validator는 null을 반환해야 합니다.

# 양식을 유효성 검사하고 제출하기 위해 버튼 만들기

양식에 텍스트 필드가 있는지 확인한 후 사용자가 정보를 제출할 수 있는 버튼을 제공하세요. 사용자가 제출하려고 할 때 양식의 유효성을 검사하세요. 유효한 경우 성공 메시지를 표시하세요. 텍스트 필드가 비어 있다면 오류 메시지를 표시하세요.

<div class="content-ad"></div>

# 단일 필드 폼을 위한 코드

단일 필드 플러터 폼을 만들려면 Flutter를 열고 새 프로젝트를 만든 다음 다음 코드를 사용하십시오 [2]:

```js
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = '테스트 폼';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

// 폼 위젯을 만듭니다.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// 해당 State 클래스를 만듭니다.
// 이 클래스는 폼과 관련된 데이터를 보유합니다.
class MyCustomFormState extends State<MyCustomForm> {
  // 폼 위젯을 고유하게 식별하는 전역 키를 만들어 폼의 유효성을 검사할 수 있게 합니다.
  //
  // 참고: 이것은 GlobalKey<FormState>이며
  // GlobalKey<MyCustomFormState>가 아닙니다.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // 위에서 만든 _formKey를 사용하여 폼 위젯을 빌드합니다.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            // validator는 사용자가 입력한 텍스트를 받습니다.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '텍스트를 입력해주세요';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                // 폼이 유효하면 true를 반환하고 그렇지 않으면 false를 반환합니다.
                if (_formKey.currentState!.validate()) {
                  // 폼이 유효하면 스낵바를 표시합니다. 실제로는
                  // 서버를 호출하거나 정보를 데이터베이스에 저장하는 경우가 많습니다.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('데이터 처리 중')),
                  );
                }
              },
              child: const Text('제출'),
            ),
          ),
        ],
      ),
    );
  }
}
```

결과:

<div class="content-ad"></div>


![이미지](/assets/img/2024-06-21-FormsandValidationinFlutterAPracticalGuide_0.png)

# 설명

스텝 1에서 생성된 _formKey를 활용하여 폼을 검증하세요. Form을 생성할 때 자동으로 생성되는 FormState에 접근하려면 _formKey.currentState() 메서드를 사용하세요. validate() 메서드는 FormState 클래스의 일부입니다. 폼의 각 텍스트 필드는 validate() 메서드가 호출될 때 validator() 함수를 가지며, 모두 정상인 경우 true를 반환합니다. validate() 함수는 어떠한 오류 경고도 표시하고, 텍스트 필드 중에 오류가 있는 경우 false를 반환합니다.

[인터랙티브 예시2](링크)에서 코드를 작성하고 온라인에서 테스트할 수 있으며, 결과를 즉시 확인할 수 있습니다.


<div class="content-ad"></div>

# 비동기 유효성 검사

폼에서 필드를 유효성 검사하려면 백엔드 서비스를 활용해 정보를 찾는 것이 종종 도움이 됩니다. 로그인 및 비밀번호를 데이터베이스에서 유효성을 검사하는 것이 전형적인 예입니다. 플러터의 비동기 폼 유효성 검사 기능은 사용자 인터페이스가 제대로 나오지 않을 수 있기 때문에 개발자가 동기식과 비동기식 유효성 검사기를 부적절하게 조합하거나 문제를 식별하기 어려울 수 있습니다. 따라서 플러터 팀은 비동기 유효성 검사 지원을 제공하지 않습니다. 그러나 이 문제에 대한 해결책이 있습니다[3]. 이 문제를 다음과 같은 세 가지 부분으로 나눌 수 있습니다:

1. 먼저 비동기 호출 결과의 성공 또는 실패를 추적하는 로컬 부울을 생성하세요. 그런 다음, 이를 동기식 유효성 검사에 포함하여 실패 상태를 설명하는 비동기 유효성 검사 메시지(예: "잘못된 사용자 이름")를 생성합니다.

2. 폼을 제출하고 동기식 유효성 검사를 통과한 후 백엔드로 비동기 호출을 하는 등의 비동기 호출을 수행하세요. 비동기 호출의 결과가 완료되면 로컬 부울을 해당 호출의 성공 또는 실패로 설정한 후 SetState()를 호출합니다. 그런 다음, 폼이 다시 그려집니다. 그러나 비동기 유효성 검사는 다시 시작되지 않습니다.

<div class="content-ad"></div>

3. build() 메서드를 호출하여 명시적으로 async validator를 다시 실행합니다. Form이 재생성되기 전에 async validator가 다시 실행됩니다. Async validator 결과 (있는 경우)는 Form이 재구성을 마치면 예상대로 Form에 표시됩니다.

# 참고 자료:

[1] https://www.javatpoint.com/flutter-forms

[2] https://docs.flutter.dev/cookbook/forms/validation

<div class="content-ad"></div>

[3]https://medium.com/@nocnoc/the-secret-to-async-validation-on-flutter-forms-4b273c667c03#:~:text=Once%20the%20sync%20validator%20passes,the%20correct%20user%2Fpass%20combination.