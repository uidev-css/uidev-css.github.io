---
title: "Flutter TextField 레벨업 디자인과 기능 팁 모음"
description: ""
coverImage: "/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_0.png"
date: 2024-06-21 23:16
ogImage: 
  url: /assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_0.png
tag: Tech
originalTitle: "Elevate Your Flutter TextField Game: Design and Functionality Tips"
link: "https://medium.com/@AryanBeast/elevate-your-flutter-textfield-game-design-and-functionality-tips-75bb69f52ccd"
---


![image](/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_0.png)

플러터에서 가장 자주 사용되는 텍스트 입력 위젯은 TextField입니다. 이 위젯은 사용자가 키보드로 앱 내의 입력을 수집할 수 있게 합니다. 텍스트 필드를 사용하면 사용자가 앱에 텍스트를 입력할 수 있습니다. 이들은 양식을 작성하고 메시지를 보내며 검색 경험을 만드는 데 사용됩니다. 이 레시피에서는 텍스트 필드를 생성하고 스타일링하는 방법을 살펴보겠습니다.

플러터는 두 가지 텍스트 필드를 제공합니다: TextField와 TextFormField.

이 문서에서는 TextField에 대해서만 다루고, TextFormField에 대해서는 다른 시간에 다루겠습니다.

<div class="content-ad"></div>

# 기본 TextField 생성하기

시간을 낭비하지 않고 직접 기본 TextField를 만드는 방법을 살펴보겠습니다.

```js
TextField()
```

네, 그렇습니다! 이렇게 간단합니다. 다음과 같이 새로운 TextField가 생성됩니다 :-

<div class="content-ad"></div>


![이미지](/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_1.png)

정보 검색

텍스트 필드에서 정보를 검색하는 것은 중요한 부분 중 하나입니다. 이를 수행하는 방법은 2가지가 있습니다.

- 이 작업을 수행하는 가장 쉬운 방법은 onChanged 메서드를 사용하여 현재 값을 간단한 변수에 저장하는 것입니다. 아래는 그에 대한 샘플 코드입니다:


<div class="content-ad"></div>

```js
String value = ""; 
TextField(
  onChanged: (text) {
    value = text;
  },
)
```

두 번째 방법은 TextEditingController를 사용하는 것입니다. 제가 항상 이 방법을 선호하는 이유는 필요에 따라 텍스트를 설정할 수 있는 유연성을 제공하기 때문입니다. (Flutter에서도 권장됩니다..) 컨트롤러는 TextField에 첨부되어 텍스트를들을 수 있게 해주며 텍스트를 제어할 수도 있습니다.

```js
TextEditingController controller = TextEditingController(); 
TextField(
  controller: controller,
)
```

변화를 감지할 수 있습니다.  

<div class="content-ad"></div>

```js
controller.addListener(() {
  // 여기에 무엇이든 입력하세요.
});
```

그리고 다음을 사용하여 값을 가져오거나 설정하세요.

```js
debugPrint(controller.text); // 문자열이 표시됩니다
controller.text = "원하는 문자열으로 설정"; 
```

textField의 FocusMode

<div class="content-ad"></div>

"포커스"가 TextField에 있다는 것은 해당 TextField가 활성화되어 있고 키보드로부터의 입력이 해당 TextField에 입력되는 것을 의미합니다. 텍스트 필드가 선택되어 입력을 받을 때 "포커스"를 가지고 있다고 말합니다. 일반적으로 사용자들은 탭을 통해 텍스트 필드로 포커스를 이동시킵니다.

# 1. autofocus 사용하기

위젯이 생성될 때 TextField에 자동 포커스를 맞추려면 autofocus 필드를 true로 설정하세요.

```dart
TextField(
  autofocus: true,
),
```

<div class="content-ad"></div>

위 코드는 기본적으로 TextField에 초점을 맞춥니다.\TextField에서 초점 사용하기

TextField에 "초점"을 맞춘다는 것은 해당 TextField가 활성화되어 있고 키보드로부터의 입력이 초점이 맞춰진 TextField에 입력되는 것을 의미합니다.

# 1. 자동 초점 설정하기

위젯이 생성될 때 TextField에 자동 초점을 맞추려면 autofocus 필드를 true로 설정하십시오.

<div class="content-ad"></div>

```js
TextField(
  autofocus: true,
),
```

기본적으로 이것은 TextField에 포커스를 설정합니다.

<img src="https://miro.medium.com/v2/resize:fit:1400/0*On1n1k1VJNmk3VwG.gif" />

기본적으로 TextField로 포커스가 이동합니다.

<div class="content-ad"></div>

# 2. 사용자 지정 포커스 변경 작업

자동 초점이 아니라 필요에 맞게 초점을 변경하려면 어떻게 해야 할까요? 다음에 어떤 TextField에 포커스를 맞출지를 참조할 수 있는 방법이 필요하기 때문에 TextField에 FocusNode를 부착하고 이를 사용하여 포커스를 전환합니다.

```js
// 빌드 메서드 외부에서 초기화
FocusNode nodeOne = FocusNode();
FocusNode nodeTwo = FocusNode();// 빌드 메서드 내부에서 수행
TextField(
  focusNode: nodeOne,
),
TextField(
  focusNode: nodeTwo,
),
RaisedButton(
  onPressed: () {
    FocusScope.of(context).requestFocus(nodeTwo);
  },
  child: Text("Next Field"),
),
```

우리는 두 개의 포커스 노드를 생성하고 이를 TextFields에 부착합니다. 버튼을 누르면 FocusScope를 사용하여 다음 TextField에 포커스를 요청합니다.

<div class="content-ad"></div>


![image](https://miro.medium.com/v2/resize:fit:1400/0*n8F5Z1LUpUIloga9.gif)

When you press the button, the focus changes.

# Changing Keyboard Properties for TextFields

In Flutter, you can customize properties related to the keyboard for a TextField.


<div class="content-ad"></div>

# 1. 키보드 타입

TextField를 사용하면 TextField이 포커스를 얻을 때 나타나는 키보드의 유형을 사용자 정의할 수 있습니다. 이를 위해 keyboardType 속성을 변경합니다.

```js
TextField(
  keyboardType: TextInputType.number,
),
```

유형은 다음과 같습니다:

<div class="content-ad"></div>

- TextInputType.text (기본 완전 키보드)
- TextInputType.number (숫자 키보드)
- TextInputType.emailAddress ("@"가 포함된 일반 키보드)
- TextInputType.datetime ("/" 및 ":"이 포함된 숫자 키보드)
- TextInputType.numberWithOptions (부호 및 소수 모드를 활성화할 수 있는 숫자 키보드)
- TextInputType.multiline (여러 줄 정보에 최적화된 키보드)

# 2. TextInputAction

TextField의 textInputAction을 변경하면 키보드 자체의 작업 버튼을 변경할 수 있습니다.

예를 들어:

<div class="content-ad"></div>

```js
TextField(
  textInputAction: TextInputAction.continueAction,
),
```

이렇게 하면 "완료" 버튼이 "계속" 버튼으로 대체됩니다:

![이미지](/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_2.png)

또는

<div class="content-ad"></div>


```js
TextField(
  textInputAction: TextInputAction.send,
),
```

원인

<img src="/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_3.png" />

전체 목록은 여기에 표시하기에 너무 많지만 꼭 확인해보세요.


<div class="content-ad"></div>

해당 TextField에 대해 자동 수정을 활성화 또는 비활성화합니다. 이를 설정하기 위해 autocorrect 필드를 사용하세요.

```js
TextField(
  autocorrect: false,
),
```

이렇게 하면 제안 기능이 비활성화됩니다.

# 4. 텍스트 대문자화

<div class="content-ad"></div>

TextField는 사용자 입력에서 글자 대문자화하는 몇 가지 옵션을 제공합니다.

```js
TextField(
  textCapitalization: TextCapitalization.sentences,
),
```

타입은 다음과 같습니다:

- TextCapitalization.sentences

<div class="content-ad"></div>

이것은 우리가 기대하는 일반적인 대문자화 유형입니다. 모든 문장의 첫 글자가 대문자로 쓰여 있습니다.

![image](/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_4.png)

2. TextCapitalization.characters

문장의 모든 문자를 대문자로 바꿉니다.

<div class="content-ad"></div>


![Image](/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_5.png)

3. TextCapitalization.words

Capitalizes the first letter of each word.

![Image](/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_6.png)


<div class="content-ad"></div>

# 텍스트 스타일, 정렬 및 커서 옵션

Flutter를 사용하면 TextField 내부 텍스트의 스타일 및 정렬과 TextField 내부 커서에 대한 사용자 정의가 가능합니다.

# TextField 내부의 텍스트 정렬

텍스트 정렬을 조정하려면 textAlign 속성을 사용하세요.

<div class="content-ad"></div>


TextField(
  textAlign: TextAlign.center,
),


이로 인해 커서와 텍스트가 TextField의 중간에서 시작됩니다.

<img src="/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_7.png" />

이것은 일반적인 정렬 속성을 갖고 있습니다: start, end, left, right, center, justify.


<div class="content-ad"></div>

# 텍스트 필드 내의 텍스트 스타일링

텍스트 필드 내의 텍스트를 변경하려면 style 속성을 사용합니다. 색상, 글꼴 크기 등을 변경하는 데 사용됩니다. 이는 Text 위젯의 style 속성과 유사하므로 이에 대해 너무 많은 시간을 들이지는 않겠습니다.

```js
TextField(
  style: TextStyle(color: Colors.red, fontWeight: FontWeight.w300),
),
```

<img src="/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_8.png" /> 

<div class="content-ad"></div>

# 텍스트 필드에서 커서 변경하기

텍스트 필드 위젯에서 커서를 사용자 정의할 수 있어요.

커서의 색상, 너비 및 모서리의 반지름을 변경할 수 있습니다. 예를 들어, 여기서는 아무 이유없이 빨간색 동그란 커서를 만들었어요.

```js
TextField(
  cursorColor: Colors.red,
  cursorRadius: Radius.circular(16.0),
  cursorWidth: 16.0,
),
```

<div class="content-ad"></div>


![이미지](/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_9.png)

## TextField 안에서 크기 및 최대 길이 제어하기

TextField는 안에 입력된 문자의 최대 수, 최대 줄 수를 제어하고 텍스트가 입력됨에 따라 확장될 수 있습니다.

## 최대 문자 수 제어하기


<div class="content-ad"></div>

```js
TextField(
  maxLength: 4,
),
```

![이미지](/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_10.png)

maxLength 속성을 설정하면 최대 길이가 강제되며 기본적으로 TextField에 카운터가 추가됩니다.

# 확장 가능한 TextField 만들기

<div class="content-ad"></div>

가끔 한 줄이 끝나면 확장되는 TextField가 필요합니다. 플러터에서 이것을 조금 이상하게 (하지만 쉽게) 할 수 있습니다. 이를 위해 기본적으로 1인 maxLines를 null로 설정합니다. null로 설정하는 것은 익숙하지 않겠지만, 그래도 쉽게 할 수 있습니다.

![이미지](/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_11.png)

참고: maxLines를 직접 값으로 설정하면 해당 줄 수로 자동 확장됩니다.

```js
TextField(
  maxLines: 3,
)
```

<div class="content-ad"></div>

<img src="/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_12.png" />

# 텍스트 숨기기

TextField에서 텍스트를 숨기려면 obscureText를 true로 설정하세요.

```js
TextField(
  obscureText: true,
  obscuringCharacter: "*",
),
```

<div class="content-ad"></div>

테이블 태그를 마크다운 형식으로 변경해보세요.


We can also change what should we visible instead of character we typed using obsuringCharacter Property.


![TextField](/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_13.png)

# 마지막으로, 텍스트 필드 꾸미기

지금까지 텍스트 필드의 기능에 대해 이야기했습니다. 이제 우리는 앱 UI가 기능만큼 중요하다는 것을 알아볼 것입니다. 그래서 먼저 간단한 것부터 시작해봅시다.

<div class="content-ad"></div>

# 힌트와 레이블

힌트와 레이블은 사용자가 텍스트 필드에 입력할 정보를 이해하는 데 도움이 되는 문자열입니다. 두 가지의 차이점은 사용자가 입력을 시작하면 힌트가 사라지지만 레이블은 텍스트 필드 위에 떠다닙니다.

![이미지](/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_14.png)

힌트

<div class="content-ad"></div>


![image](/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_15.png)

Label

# You can add icons using “icon”, “prefixIcon” and “suffixIcon”

You can add icons directly to TextFields. You can also use prefixText and suffixText for Text instead.


<div class="content-ad"></div>


```js
TextField(
  decoration: InputDecoration(
    icon: Icon(Icons.print)
  ),
),
```

![Image](/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_16.png)

Icon using the icon property

```js
TextField(
  decoration: InputDecoration(
    prefixIcon: Icon(Icons.print)
  ),
),
```


<div class="content-ad"></div>


![Image](/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_17.png)

Icon using the `prefixIcon` property

# Similarly for any other widget, use "prefix" instead of "prefixIcon"

To use a generic widget instead of an icon, use the `prefix` field. Again for no apparent reason, let's add a circular progress indicator in a TextField.


<div class="content-ad"></div>

```js
TextField(
  decoration: InputDecoration(
    prefix: CircularProgressIndicator(),
  ),
),
```

<img src="/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_18.png" />

# 각 속성인 힌트, 레이블 등에는 각각의 스타일 필드가 있습니다.

힌트를 스타일링하려면 hintStyle을 사용하세요. 레이블을 스타일링하려면 labelStyle을 사용하세요.


<div class="content-ad"></div>

```dart
TextField(
  decoration: InputDecoration(
    hintText: "데모 텍스트",
    hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.red)
  ),
),
```

![2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_19.png](/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_19.png)

참고: 이 예시에서는 한 색으로 힌트 색을 변경했지만 일반적으로는 사용자에게 혼란을 줄 수 있으니 힌트 색을 변경하지 않는 것이 좋습니다.

# 레이블을 원하지 않지만 사용자에게 계속 나타낼 메시지가 필요한 경우 “helperText”를 사용하세요.

<div class="content-ad"></div>

```js
TextField(
  decoration: InputDecoration(
    helperText: "안녕하세요"
  ),
),
```

<img src="/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_20.png" />

# “decoration: null” 또는 InputDecoration.collapsed를 사용하여 TextField의 기본 밑줄을 제거하세요

이를 사용하여 TextField의 기본 밑줄을 제거하세요.

<div class="content-ad"></div>

```dart
TextField(
  decoration: InputDecoration.collapsed(hintText: "")
),
```

<img src="/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_21.png" />

# 텍스트 필드에 테두리를 주려면 “border”를 사용하세요

```dart
TextField(
  decoration: InputDecoration(
    border: OutlineInputBorder()
  )
),
```

<div class="content-ad"></div>

더 많은 장식을 넣을 수 있지만, 한 기사에 모든 것을 다 다룰 수는 없습니다. 그래도 이 내용이 Flutter TextFields를 쉽게 사용자 정의하는 방법을 이해하는 데 도움이 됐으면 좋겠네요.

# TextFields에서 포커스 다루기

TextField에 "포커스"가 있다는 것은 TextField가 활성화되어 있고, 키보드로부터 입력을 받을 때 해당 TextField에 데이터가 입력된다는 것을 의미합니다.

# 1. autofocus 사용하기

<div class="content-ad"></div>

위젯이 생성될 때 TextField에 자동 초점이 맞추어지도록 하려면 autofocus 필드를 true로 설정하십시오.

```dart
TextField(
  autofocus: true,
),
```

기본적으로 이렇게 TextField에 초점이 설정됩니다.

<img src="https://miro.medium.com/v2/resize:fit:1400/0*qcE5ix5ik3ma0S8m.gif" />

<div class="content-ad"></div>

기본적으로 TextField로 초점이 이동됩니다.

# 2. 사용자 정의 초점 변경 작업

만약 우리가 포커스를 원하는 대로 변경하고 싶다면 어떻게 해야 할까요? 자동 초점 설정뿐만 아니라 필요에 따라 포커스를 변경할 방법이 필요합니다. 다음에 초점을 맞출 TextField를 지칭하기 위해 TextField에 FocusNode를 첨부하고 이를 사용하여 포커스를 전환합니다.

```js
// build 메서드 외부에 초기화
FocusNode nodeOne = FocusNode();
FocusNode nodeTwo = FocusNode();// 빌드 메서드 내에서 수행
TextField(
  focusNode: nodeOne,
),
TextField(
  focusNode: nodeTwo,
),
RaisedButton(
  onPressed: () {
    FocusScope.of(context).requestFocus(nodeTwo);
  },
  child: Text("다음 필드로"),
),
```

<div class="content-ad"></div>

두 개의 포커스 노드를 생성하고 TextFields에 연결합니다. 버튼을 누르면 FocusScope를 사용하여 다음 TextField로 포커스를 요청합니다.

![example image](https://miro.medium.com/v2/resize:fit:1400/0*9tzzhPOL9PWuXv7v.gif)

버튼을 누를 때 포커스가 변경됩니다.

# 텍스트 필드를 위한 키보드 속성 변경

<div class="content-ad"></div>

플러터의 TextField를 사용하면 키보드와 관련된 속성을 사용자가 맞춤 설정할 수 있어요.

### 1. 키보드 유형

TextField를 사용하면 TextField가 포커스를 맞추면 표시되는 키보드 유형을 맞춤 설정할 수 있어요. 이를 위해 keyboardType 속성을 변경할 수 있어요.

```dart
TextField(
  keyboardType: TextInputType.number,
),
```

<div class="content-ad"></div>

위의 내용을 친근하게 번역해 드리겠습니다.

다양한 종류가 있습니다:

- TextInputType.text (일반 완전한 키보드)
- TextInputType.number (숫자 키보드)
- TextInputType.emailAddress ("@"이 포함된 일반 키보드)
- TextInputType.datetime ("/"와 ":"이 포함된 숫자 키보드)
- TextInputType.numberWithOptions (부호 및 십진 모드를 활성화할 수 있는 숫자 키보드)
- TextInputType.multiline (여러 줄 정보에 최적화된 키보드)

# 2. TextInputAction

TextField의 textInputAction을 변경하면 키보드의 동작 버튼을 변경할 수 있습니다.

<div class="content-ad"></div>

예를 들어:

```js
TextField(
  textInputAction: TextInputAction.continueAction,
),
```

이렇게 하면 "완료" 버튼이 "계속" 버튼으로 바뀝니다:

<img src="/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_22.png" />

<div class="content-ad"></div>

Markdown 형식으로 변경해보면 다음과 같습니다.


```js
TextField(
  textInputAction: TextInputAction.send,
),
```

Causes

<img src="/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_23.png" />


<div class="content-ad"></div>

전체 목록은 여기에 표시하기에 너무 크지만 꼭 확인해보세요.

특정 텍스트 필드의 자동 교정 기능을 활성화 또는 비활성화합니다. 이를 설정하려면 autocorrect 필드를 사용하세요.

```js
TextField(
  autocorrect: false,
),
```

이렇게 하면 제안도 비활성화됩니다.

<div class="content-ad"></div>

# 4. 텍스트 대문자화

TextField는 사용자 입력에서 글자를 대문자로 표시하는 몇 가지 옵션을 제공합니다.

```js
TextField(
  textCapitalization: TextCapitalization.sentences,
),
```

이 유형은 다음과 같습니다:

<div class="content-ad"></div>

- TextCapitalization.sentences

우리가 기대하는 일반적인 대소문자 표기입니다. 각 문장의 첫 글자가 대문자로 쓰입니다.

![이미지](/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_24.png)

2. TextCapitalization.characters

<div class="content-ad"></div>

이미지 태그를 마크다운 형식으로 변경해주세요.


![이미지](/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_25.png)


3. TextCapitalization.words

각 단어의 첫 글자를 대문자로 씁니다.

<div class="content-ad"></div>

<img src="/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_26.png" />

# 텍스트 스타일, 정렬 및 커서 옵션

Flutter는 TextField 안의 텍스트 스타일링 및 정렬 및 TextField 내부의 커서에 대한 사용자 정의를 허용합니다.

# TextField 내부의 텍스트 정렬

<div class="content-ad"></div>

텍스트 필드 안에 커서가 있는 위치를 조정하려면 textAlign 속성을 사용하세요.

```js
TextField(
  textAlign: TextAlign.center,
),
```

이렇게 하면 커서와 텍스트가 텍스트 필드의 중앙에서 시작됩니다.

<img src="/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_27.png" />

<div class="content-ad"></div>

표 태그를 Markdown 형식으로 변경해 주세요.

# TextField 내의 텍스트 스타일링

TextField 내부 텍스트의 모양을 변경하려면 style 속성을 사용합니다. 이를 통해 색상, 글꼴 크기 등을 변경할 수 있습니다. Text 위젯의 style 속성과 유사하며, 자세히 살펴볼 시간이 부족하기 때문에 간단히 설명하겠습니다.

```js
TextField(
  style: TextStyle(color: Colors.red, fontWeight: FontWeight.w300),
),
```

<div class="content-ad"></div>

<img src="/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_28.png" />

# 텍스트 필드에서 커서 변경하기

커서는 TextField 위젯에서 직접 사용자 정의할 수 있습니다.

커서의 색상, 너비 및 꼭지점의 반지름을 변경할 수 있습니다. 예를 들어, 여기서는 아무 이유없이 원형의 빨간색 커서를 만들어보겠습니다.

<div class="content-ad"></div>

```js
TextField(
  cursorColor: Colors.red,
  cursorRadius: Radius.circular(16.0),
  cursorWidth: 16.0,
),
```

<img src="/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_29.png" />

# 텍스트 필드의 크기 및 최대 길이 제어

텍스트 필드는 내부에 작성된 문자 수를 제어하고, 최대 라인 수 및 글자가 입력됨에 따라 확장할 수 있습니다.

<div class="content-ad"></div>

# 최대 글자 수 제어하기

```js
TextField(
  maxLength: 4,
),
```

![이미지](/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_30.png)

maxLength 속성을 설정하면 최대 길이가 강제되며 TextField에는 기본적으로 카운터가 추가됩니다.

<div class="content-ad"></div>

# 확장 가능한 TextField 만들기

가끔, 한 줄이 끝나면 확장되는 TextField가 필요할 때가 있습니다. Flutter에서는 이를 조금 이상하게 (하지만 쉽게) 할 수 있습니다. 이를 위해 maxLines를 기본값인 1로 설정된 null로 설정해야 합니다. 우리가 익숙하지 않은 값으로 설정하지만 그럼에도 쉽게 할 수 있습니다.

![이미지](/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_31.png)

참고: maxLines를 직접값으로 설정하면 기본적으로 해당 수의 줄로 확장됩니다.

<div class="content-ad"></div>

```dart
TextField(
  maxLines: 3,
)
```

![Image](/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_32.png)

# 텍스트 가리기

텍스트를 가리려면 TextField에서 obscureText를 true로 설정하세요.

<div class="content-ad"></div>


TextField(
  obscureText: true,
),


![Image](/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_33.png)

# 그리고 마지막으로, TextField 장식하기

지금까지는 입력을 위해 Flutter에서 제공하는 기능에 중점을 두었습니다. 이제는 실제로 화려한 TextField를 디자인하고 디자이너의 의견을 거부하지 않을 것입니다.


<div class="content-ad"></div>

텍스트 필드를 꾸미려면 InputDecoration을 취하는 decoration 속성을 사용합니다. InputDecoration 클래스가 방대하기 때문에 중요한 속성 대부분을 빠르게 살펴보겠습니다.

# 사용자에게 정보를 제공하기 위해 힌트와 라벨 속성 사용

힌트(hint)와 라벨(label)은 텍스트 필드에 입력해야 할 정보를 사용자에게 이해시켜주는 문자열입니다. 차이점은 힌트는 사용자가 입력을 시작하면 사라지지만 라벨은 텍스트 필드 위를 떠다닙니다.

![이미지](/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_34.png)

<div class="content-ad"></div>

힌트


![Hint](/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_35.png)


라벨

# "아이콘", "prefixIcon", "suffixIcon"을 사용하여 아이콘을 추가할 수 있습니다.

<div class="content-ad"></div>

TextFields에 아이콘을 직접 추가할 수 있습니다. 또한 Text에 대해 prefixText와 suffixText를 사용할 수도 있습니다.

```js
TextField(
  decoration: InputDecoration(
    icon: Icon(Icons.print)
  ),
),
```

<img src="/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_36.png" />

icon 속성을 사용한 아이콘

<div class="content-ad"></div>

```dart
TextField(
  decoration: InputDecoration(
    prefixIcon: Icon(Icons.print)
  ),
),
```

![Image](/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_37.png)

`prefixIcon` 속성을 사용한 아이콘

# 다른 위젯에 대해서도 “prefixIcon” 대신에 “prefix”를 사용하세요.

<div class="content-ad"></div>

일반 위젯 대신 아이콘 대신에 prefix 필드를 사용하려면 이렇게 해보세요. 아무 이유없이 TextField에 원형 진행 표시기를 추가해보겠습니다.

```js
TextField(
  decoration: InputDecoration(
    prefix: CircularProgressIndicator(),
  ),
),
```

<img src="/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_38.png" />

# hint, label 등 각 속성은 각각의 스타일 필드를 가지고 있습니다.

<div class="content-ad"></div>

힌트를 수정하려면 hintStyle을 사용하세요. 라벨을 스타일링하려면 labelStyle을 사용하세요.

```js
TextField(
  decoration: InputDecoration(
    hintText: "데모 텍스트",
    hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.red)
  ),
),
```

![이미지](/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_39.png)

참고: 이 예시에서는 했지만, 일반적으로 힌트의 색상을 변경하지 마세요. 사용자에게 혼란스러울 수 있습니다.

<div class="content-ad"></div>

# 사용자에게 계속 보이는 메시지를 표시하고 싶지만 라벨은 필요하지 않은 경우 "helperText"를 사용해보세요.

```js
TextField(
  decoration: InputDecoration(
    helperText: "안녕하세요"
  ),
),
```

<img src="/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_40.png" />

# TextField의 기본 밑줄을 제거하려면 "decoration: null" 또는 InputDecoration.collapsed를 사용하세요.

<div class="content-ad"></div>

```dart
TextField(
  decoration: InputDecoration.collapsed(hintText: "")
),
```

![이미지](/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_41.png)

# 텍스트 필드에 경계선을 주려면 "border"를 사용하세요.

<div class="content-ad"></div>


TextField(
  decoration: InputDecoration(
    border: OutlineInputBorder()
  )
),


![image](/assets/img/2024-06-21-ElevateYourFlutterTextFieldGameDesignandFunctionalityTips_42.png)

더 많은 꾸밈 작업이 가능하지만, 한 기사로는 모든 것을 다 다룰 수 없습니다. 그러나 플러터 텍스트필드를 사용자 정의하는 것이 얼마나 쉬운지 이해하는 데 도움이 되었으면 합니다.

Aryan Bisht님으로부터 더 많은 내용을 확인하세요.


<div class="content-ad"></div>

당신은 커피를 사줄 수 있어:- [여기](https://www.buymeacoffee.com/aryanbisht)

# 코딩과 개발 여정을 함께 레벨업해요

우리 커뮤니티의 일원이 되어 주셔서 감사합니다! 떠나시기 전에:

- 👏 만약 도움이 되셨다면 이야기에 박수를 치고 저자를 팔로우해주세요 👉
- 🔔 팔로우하기: LinkedIn