---
title: "Flutter로 코드 생성하기  source_gen과 build_runner 사용 방법"
description: ""
coverImage: "/assets/img/2024-06-21-CodeGenerationusingFluttersource_genbuild_runner_0.png"
date: 2024-06-21 22:30
ogImage: 
  url: /assets/img/2024-06-21-CodeGenerationusingFluttersource_genbuild_runner_0.png
tag: Tech
originalTitle: "Code Generation using Flutter | source_gen | build_runner."
link: "https://medium.com/@yamen.abd98/code-generator-using-flutter-source-gen-build-runner-9cc1fe0e2ff2"
---


![2024-06-21-CodeGenerationusingFluttersource_genbuild_runner_0.png](/assets/img/2024-06-21-CodeGenerationusingFluttersource_genbuild_runner_0.png)

최근에는 전문적인 플러터 개발자로서 매일 개발 프로세스 중에 시간이 오래 걸리고 실수할 가능성이 있는 일상적인 반복 작업을 더 나은 방법과 안전한 방법으로 수행하고 싶었을 것입니다. 그러한 프로세스는 코드 생성입니다. 진보를 이루는 데 핵심은 효율성을 극대화하는 데 있습니다. 반복적인 작업은 지루하고 단조로운 성질 때문에 보편적으로 싫어하는데, 이러한 활동에서 사람들은 주목할 만큼 비효율적이며 종종 오류를 범합니다.

코드 생성은 특정 입력 데이터나 규칙을 기반으로 자동으로 코드를 생성하는 기술입니다. Flutter에서 코드 생성은 JSON 데이터, 데이터베이스 및 웹 서비스와 같은 다양한 목적으로 사용됩니다. 코드 생성은 반복적인 작업을 자동화하고 필요한 수동 코딩량을 줄임으로써 코드 작성과 유지를 쉽게 할 수 있습니다.

코드 생성기를 사용하는 많은 패키지들이 있습니다. json_serializable과 같은 패키지의 예시를 살펴보겠습니다. 이 패키지는 우리에게 fromJson, toJson과 같은 메서드를 생성하는 데 사용되는 일련의 주석을 제공하여, 해당 함수를 생성하려는 행에 주석을 넣기만 하면 이러한 메서드를 자동으로 생성합니다.

<div class="content-ad"></div>

예시:


| First Header  | Second Header |
| ------------- | ------------- |
| Content Cell  | Content Cell  |
| Content Cell  | Content Cell  |


<div class="content-ad"></div>

이 글에서는 사용자 정의 주석 및 생성기를 생성하여 주석이 달린 클래스에 대해 fromJson, toJson 및 copyWith 메서드를 생성하는 방법을 배우겠습니다.

우리가 자체 코드 생성기를 만들기 위해 필요한 패키지는 무엇인가요?

- source_gen | Dart 패키지 (pub.dev)
- build_runner | Dart 패키지 (pub.dev)

## source_gen

<div class="content-ad"></div>

API는 낮은 수준의 빌드 또는 분석기 패키지와 상호 작용 없이 코드를 생성하는 데 도움이 되는 다양한 유틸리티를 제공합니다. 이는 여러분의 삶을 훨씬 쉽게 만들어 줄 것입니다.

source_gen 패키지는 build 패키지의 확장판입니다. Dart 소스 코드 생성을 더 쉽게 만드는 일련의 유틸리티가 포함되어 있습니다.

## build_runner

이 패키지를 사용하면 생성기를 실행할 수 있습니다. 이는 개발 단계에서만 사용되는 dev_dependency 영역에 있을 것이므로 개발 단계에서만 사용할 것입니다.

<div class="content-ad"></div>

우리는 다음 명령어를 실행하여 코드를 생성할 수 있어요:

```dart
dart run build_runner `command`
```

사용할 수 있는 명령어는 다음과 같아요:

- build: 하나의 빌드를 실행하고 종료합니다.
- watch: 파일 시스템을 감시하는 지속적인 빌드 서버를 실행하며 필요 시 다시 빌드합니다.
- serve: watch와 동일하지만 개발 서버도 실행합니다.

<div class="content-ad"></div>

# 예시

GitHub에서 스타터 프로젝트를 다운로드하거나 수동으로 생성할 수 있습니다.

스타터 프로젝트에는 세 개의 프로젝트가 포함되어 있습니다:

- 예시: 이는 플러터 애플리케이션입니다. 이 애플리케이션은 생성기 코드를 테스트하는 데 사용됩니다.
- 어노테이션: 이는 플러터 패키지입니다. 이는 어노테이션을 포함하고 있으며, 생성기는 이를 사용하여 처리할 클래스를 인식합니다.
- 생성기: 이는 플러터 패키지입니다. 이 패키지에는 우리의 어노테이션에 의해 주석 처리된 코드를 방문하고 이를 위해 코드를 생성하는 코드 생성기가 포함되어 있습니다.

<div class="content-ad"></div>

시작해보세요. Custom Gen이라는 디렉토리를 만들고 터미널에서 열어서 다음을 입력하세요:

code .

그럼 VS Code가 열릴 거에요.

## 예제 프로젝트

<div class="content-ad"></div>

Ctrl + Shift + p를 눌러 Flutter: New Project를 선택한 다음 Application을 선택하고 example로 이름을 지어주세요.

## annotations 프로젝트

터미널에서 Custom Gen 폴더를 열기 위해 이전과 같은 단계를 따라주세요.

Ctrl + Shift + p를 눌러 Flutter: New Project를 선택한 다음 Package를 선택하고 annotation으로 이름을 지어주세요.

<div class="content-ad"></div>

## generators 프로젝트

터미널에서 이미지와 같이 'Custom Gen' 폴더를 열기 위해 이전과 같은 단계를 수행합니다.

Ctr + Shift + p를 눌러 Flutter: New Project를 선택하고 Package를 선택한 후 generator라고 이름을 지정하세요.

이제 이미지와 같이 세 개의 프로젝트가 생성됩니다.

<div class="content-ad"></div>

<img src="/assets/img/2024-06-21-CodeGenerationusingFluttersource_genbuild_runner_1.png" />

# 주석 프로젝트

주석이 무엇인가요?

Flutter에서 주석은 Dart 코드에 포함하여 도구나 라이브러리에 추가 정보를 전달하는 특별한 표식이거나 지시문입니다. 주석은 build_runner 및 코드 생성기와 같은 도구에 대한 힌트로 작용하여 주석이 달린 코드와 관련된 특정 작업이나 동작을 나타냅니다.

<div class="content-ad"></div>

annotations/lib에 src 폴더를 만들어서 생성자에 의해 사용될 주석 파일을 포함시킬 것입니다.

annotations/lib/annotations.dart와 annotations/test/annotations_test.dart의 예제 코드를 제거할 것입니다.

src 폴더에 acustom_annotation.dart 파일을 생성하여 주석을 작성할 것입니다. 이 주석은 CustomAnnotation으로 명명되었습니다.

```dart
// 우리의 주석
class CustomAnnotation {
  const CustomAnnotation();
}

// 이 변수는 코드를 생성하기 위한 주석으로 사용될 것입니다.
const customAnnotation = CustomAnnotation();
```

<div class="content-ad"></div>

annotations.dart 파일에서 CustomAnnotation을 export할 것입니다:

```js
library annotations;

export 'src/custom_annotation.dart';
```

다른 곳에서 이 주석 라이브러리를 사용하려면 각 파일을 개별적으로 호출하는 대신 annotations.dart를 import하기만 하면 됩니다.

좋아요! 이제 당신은 당신의 어노테이션을 만들었습니다. 축하해요. 🎉🎉

<div class="content-ad"></div>

# 제너레이터 프로젝트

먼저 generators/generators.dart 파일과 generators/test/generators_test.dart 파일의 초기 코드를 제거하세요.

그런 다음 generators/pubspec.yaml 파일에 몇 가지 종속성을 추가해야 합니다:

```js
dependencies:
  flutter:
    sdk: flutter
  
  build:
  source_gen:

  # Our annotation
  annotations:
    path: ../annotations/

dev_dependencies:
  flutter_test:
    sdk: flutter

  build_runner:
  flutter_lints: ^2.0.0
```

<div class="content-ad"></div>

태그를 Markdown 형식으로 변경하고 다음 명령을 실행하세요: flutter pub get.

- build: 이 패키지는 변수, 메소드 및 생성자와 같은 다양한 클래스 구성요소에 액세스하여 클래스를 검사하는 것을 가능하게 합니다.
- source_gen: analyzer 또는 build와 같은 하위 수준 패키지 위에 있는 API입니다. source_gen을 사용하여 소스 코드를 생성할 필요는 없습니다. 또한 제너레이터에 유용할 수 있는 일련의 라이브러리 API를 노출합니다.
- annotations: 이전에 작성된 annotation입니다.
- build_runner: 주석이 달린 클래스에서 코드를 생성합니다.

flutter pub get을 실행하는 중에 이와 같은 오류가 발생할 수 있습니다:

Publishable packages can’t have ‘path’ dependencies.
Try adding a publish_to: none entry to mark the package as not for publishing or remove the path dependency.

<div class="content-ad"></div>

이 작업은 필요합니다. 왜냐하면 패키지를 Dart Dev에 업로드할 계획이라면 경로가 올바르지 않을 수 있습니다. 따라서 pubspec.yaml에서 이 예제가 실제 업로드된 패키지가 아닌 것을 명시해야 합니다. 다음 코드를 pubspec.yaml에 추가해주세요:

```js
name: generator
description: A new Flutter package project.
version: 0.0.1
homepage:
publish_to: none # <- 이 코드를 추가하여 이 패키지가 Dart Dev에 게시되지 않도록 설정
```

## build.yaml 구성하기

build.yaml 파일은 build_runner에 의해 수행되는 코드 생성 프로세스의 설정과 구성을 지정하는 구성 파일입니다. 이 파일은 build_runner에 의해 호출되어 모든 생성기 구성을 읽기 전에 기능을 설정하며 Dart 빌드 시스템의 일부이며 Flutter 프로젝트에서 코드 생성 라이브러리를 사용할 때 생성기를 구성하는 용도로 사용됩니다. 생성된 파일의 확장자, 생성된 메서드, 생성기의 경로와 같은 설정을 지정하는 중요한 파일입니다.

<div class="content-ad"></div>

지금, 제너레이터 패키지 루트에 build.yaml 파일을 만들어서 다음 코드를 입력해주세요:

```js
targets:
  $default:
    builders:
      generators|annotations: # generators|annotations: 주석이 달린 파일을 다룰 때 simple_generator 빌더를 사용한다는 것을 의미합니다.
        enabled: true

builders:
  generators:
    target: ":generators" # 제너레이터 이름
    import: "package:generators/generators.dart"
    builder_factories: ["generateJsonMethods"] # 빌더 이름(BuilderOption)의 정의입니다.
    build_extensions: { ".dart": [".g.dart"] }
    auto_apply: dependents
    build_to: cache
    applies_builders: ["source_gen|combining_builder"]
```

1- import: 제너레이터 경로를 결정합니다.

2- builder_factories: 빌더 메서드의 이름을 나열합니다. 이 경우, "generateJsonMethods"라는 단일 팩토리를 포함하며 빌더를 반환합니다.

<div class="content-ad"></div>

3- build_extensions: 빌더의 입력 및 출력 파일 확장자를 정의합니다. 이는 빌더가 .dart 파일을 처리하고 .g.part '(.g.part) 파일을 생성함을 나타냅니다. 이는 build.yaml 파일의 auto_apply 키에 기반하여 파일의 가시성을 제어합니다.

4- auto_apply: 특정 빌더가 빌드 프로세스 중 자동으로 적용되어야 하는 시점을 지정하는 데 사용됩니다.

auto_apply 옵션에는 여러 가지 가능한 값이 있습니다:

- none: 빌더가 자동으로 적용되지 않습니다. 빌더를 명시적으로 builders 섹션에 지정하거나 build_runner 명령을 --build-filter 옵션과 함께 사용해야 합니다.
- dependents: 빌더가 build.yaml 파일을 포함하는 패키지에 의존하는 패키지에 자동으로 적용됩니다. 이는 다른 패키지가 귀하의 패키지에 의존하는 경우 해당 빌더가 해당 의존 패키지에도 적용됨을 의미합니다.
- all_packages: 의존성 여부에 관계없이 모든 패키지에 빌더가 자동으로 적용됩니다. 이 옵션은 드물며, 모든 패키지에 빌더가 필요하지 않은 경우 빌드 시간이 증가할 수 있습니다.

<div class="content-ad"></div>

5- build_to: 코드 생성에서 생성된 파일이 배치되어야 하는 디렉토리를 지정합니다.

다음은 build_to에 대한 일반적인 값들입니다:

- source: 이는 생성된 파일이 소스 파일과 동일한 디렉토리에 배치됨을 의미합니다. 소스 파일이 lib/src에 있으면 생성된 파일도 lib/src에 배치됩니다.
- cache: 이는 생성된 파일이 빌드 캐시 디렉토리에 배치됨을 의미합니다. 빌드 캐시는 빌드 성능을 향상시키기 위해 build_runner가 관리하는 디렉토리입니다.

# 생성기 생성

<div class="content-ad"></div>

이제 build.yaml 파일을 구성한 후, 코드 생성을 위한 모든 파일 및 구현체를 생성할 것입니다.

이 단계에서는 방문자(visitor) 클래스를 만들 것입니다; 이는 생성된 코드를 위해 생성자, 필드, 함수 등 모든 클래스 요소에 액세스하는 데 도움을 줍니다.

## 모델 방문자

lib/src 에 model_visitor.dart 파일을 만든 후, 다음 import 문을 사용할 것입니다:

<div class="content-ad"></div>


```dart
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
```

The first import comes from analyzer because both source_gen and build export it.

Create a ModelVisitor class and extend from SimpleElementVisitor:

```dart
class ModelVisitor extends SimpleElementVisitor<void>{

}
```


<div class="content-ad"></div>

SimpleElementVisitor에는 클래스를 검사하는 데 도움이 되는 여러 메서드가 포함되어 있습니다:

- visitFieldElement 메서드.
- visitConstructorElement 메서드.
- visitFunctionElement 메서드.

SimpleElementVisitor 클래스로 이동하여 클래스를 검사하는 데 유용한 모든 메서드를 살펴볼 수 있지만, 우리의 경우 visitConstructorElement 메서드를 사용하여 클래스 이름을 가져오고 visitFunctionElement 메서드를 사용하여 클래스의 모든 필드를 가져올 것입니다.

model_visitor.dart 파일의 전체 코드:

<div class="content-ad"></div>

```dart
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';

// 단계 1
class ModelVisitor extends SimpleElementVisitor<void> {
// 단계 2
  String className = '';
  Map<String, dynamic> fields = {};

// 단계 3
  @override
  void visitConstructorElement(ConstructorElement element) {
    final String returnType = element.returnType.toString();
// 단계 4
    className = returnType.replaceAll("*", ""); // ClassName* -> ClassName
  }

// 단계 5
  @override
  void visitFieldElement(FieldElement element) {
    /*
    {
      name: String,
      price: double
    }
     */

// 단계 6
    String elementType = element.type.toString().replaceAll("*", "");
    fields[element.name] = elementType;

  }
}
```

단계 1: SimpleElementVisitor 클래스를 상속받은 ModelVisitor 클래스로 확장함으로써 클래스 필드, 생성자 및 함수에 대한 다양한 유용한 메서드에 액세스할 수 있습니다.

단계 2: className 변수를 정의하여 클래스 이름을 저장하고, fields 변수를 정의하여 모든 클래스 필드를 저장합니다.

단계 3: 이 오버라이드된 메서드는 클래스 생성자를 방문하고 element.returnType을 통해 클래스 이름을 검색할 수 있도록 합니다.


<div class="content-ad"></div>

단계 4: element.returnType은 원소 유형 뒤에 '*'을 반환하므로 이를 제거합니다.

단계 5: 이 방법은 클래스의 각 필드에 대해 호출되며, 필드 이름과 필드 유형에 모두 액세스할 수 있습니다.

또한 더 많은 속성에 액세스할 수 있습니다.

단계 6: element.type은 원소 유형 뒤에 '*'을 반환하므로 이를 제거합니다.

<div class="content-ad"></div>

## 생성기

lib/src에 json_generator.dart라는 파일을 생성하세요:

```dart
import 'package:annotations/annotations.dart';
import 'package:source_gen/source_gen.dart';

class JsonGenerator extends GeneratorForAnnotation<CustomAnnotation> {
  // 이곳에 코드를 생성하는 메서드를 작성하세요!
}
```

이 파일은 생성기의 진입점을 나타냅니다. dart run build_runner build 명령을 실행한 후, build_runner은 먼저 build.yaml 파일을 확인합니다. 이후 예제 파일을 모두 스캔하고, 어노테이션이 존재하면 이 클래스가 인지하고, 상기 생성기 클래스의 재정의된 기능을 실행하도록 합니다.

<div class="content-ad"></div>

generateForAnnotatedElement을 오버라이드할 거에요. 이 메서드는 element를 인자로 받아요. 이 경우에는 클래스가 될 거예요. 이 간단한 예시에서는 다른 매개변수가 필요하지 않아요. 이 메서드는 생성된 코드를 나타내는 String 타입을 반환할 거에요.

```js
class JsonGenerator extends GeneratorForAnnotation<CustomAnnotation> {
  @override
  String generateForAnnotatedElement(
    Element element, // 이 경우에는 클래스를 나타냅니다.
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
  }
}
```

이 클래스가 생성기의 진입점이므로 ModelVisitor 클래스를 활용하여 주석이 달린 클래스의 모든 필드와 생성자를 가져올 거에요.

```js
class JsonGenerator extends GeneratorForAnnotation<CustomAnnotation> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final ModelVisitor visitor = ModelVisitor();
    // 클래스의 필드와 생성자를 방문한 후, visitor의 className과 fields 변수에 값이 들어갈 거에요.
    element.visitChildren(visitor);
  }
}
```

<div class="content-ad"></div>

클래스 이름과 필드를 가져온 후에는, `fromJson`, `toJson`, 그리고 `copyWith` 메서드를 생성하는 코드를 작성해봅시다.

## fromJson 메서드

- 생성된 메서드 예시:

```js
// From Json Method
Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      name: json['name'],
      price: json['price'],
    );
```

<div class="content-ad"></div>

- 위 예시를 생성하는 함수:

```js
// fromJSon 메소드를 생성하는 메서드
String generateFromJsonMethod(ModelVisitor visitor) {
  // 모델 방문자로부터 클래스 이름을 받아옴
  String className = visitor.className;

  // 생성된 클래스의 각 부분을 쓰기 위한 버퍼
  final buffer = StringBuffer();

  // --------------------fromJson 생성 코드 시작--------------------//
  buffer.writeln('// From Json 메소드');
  buffer.writeln(
      '$className _\$${className}FromJson(Map<String, dynamic> json) => ');
  buffer.write('$className(');

  for (int i = 0; i < visitor.fields.length; i++) {
    String fieldName = visitor.fields.keys.elementAt(i);
    String mapValue = "json['$fieldName']";

    buffer.writeln(
      "${visitor.fields.keys.elementAt(i)}: $mapValue,",
    );
  }
  buffer.writeln(');');
  buffer.toString();
  return buffer.toString();
  // --------------------fromJson 생성 코드 종료--------------------//
}
```

## toJson 메소드

- 생성된 메소드 예시:

<div class="content-ad"></div>

```js
// JSON으로 변환하는 메소드
Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
    };
```

- 위 예시를 생성하는 함수:

```js
// fromJSon 메소드를 생성하는 메소드
String generateToJsonMethod(ModelVisitor visitor) {
  // 모델 비지터에서 클래스 이름 가져오기
  String className = visitor.className;

  // 생성된 클래스 각 부분을 작성할 버퍼
  final buffer = StringBuffer();

  // --------------------toJson 생성 코드 시작--------------------//
  buffer.writeln('// JSON으로 변환하는 메소드');
  buffer.writeln(
      'Map<String, dynamic> _\$${className}ToJson($className instance) => ');
  buffer.write('<String, dynamic>{');
  for (int i = 0; i < visitor.fields.length; i++) {
    String fieldName = visitor.fields.keys.elementAt(i);
    buffer.writeln(
      "'$fieldName': instance.$fieldName,",
    );
  }
  buffer.writeln('};');
  return buffer.toString();
  // --------------------toJson 생성 코드 끝--------------------//
}
```

## copyWith 메소드


<div class="content-ad"></div>

- 생성된 메서드 예시:

```js
// Product 클래스에 'copyWith' 메서드를 제공하기 위한 확장
extension $ProductExtension on Product {
  Product copyWith({
    String? name,
    double? price,
  }) {
    return Product(
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }
```

- 위 예제를 생성하는 함수:

```js
// fromJSon 메서드를 생성하는 함수
String generateCopyWithMethod(ModelVisitor visitor) {
  // 모델 방문자로부터 클래스 이름 가져오기
  String className = visitor.className;

  // 생성된 클래스 각 부분을 작성할 버퍼
  final buffer = StringBuffer();

  // --------------------copyWith 생성 코드 시작--------------------//
  buffer.writeln(
      "// $className 클래스에 'copyWith' 메서드를 제공하기 위한 확장");
  buffer.writeln('extension \$${className}Extension on $className {');
  buffer.writeln('$className copyWith({');
  for (int i = 0; i < visitor.fields.length; i++) {
    String dataType =
        visitor.fields.values.elementAt(i).toString().replaceAll("?", "");
    String fieldName = visitor.fields.keys.elementAt(i);
    buffer.writeln(
      '$dataType? $fieldName,',
    );
  }
  buffer.writeln('}) {');
  buffer.writeln('return $className(');
  for (int i = 0; i < visitor.fields.length; i++) {
    buffer.writeln(
      "${visitor.fields.keys.elementAt(i)}: ${visitor.fields.keys.elementAt(i)} ?? this.${visitor.fields.keys.elementAt(i)},",
    );
  }
  buffer.writeln(');');
  buffer.writeln('}');
  buffer.writeln('}');
  buffer.toString();
  return buffer.toString();
  // --------------------copyWith 생성 코드 종료--------------------//
}
```  

<div class="content-ad"></div>

json_generator.dart 파일의 전체 코드:

```js
import 'package:analyzer/dart/element/element.dart';
import 'package:annotations/annotations.dart';
import 'package:build/build.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:generators/src/model_visitor.dart';
import 'package:source_gen/source_gen.dart';

class JsonGenerator extends GeneratorForAnnotation<CustomAnnotation> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final ModelVisitor visitor = ModelVisitor();
    // 클래스 필드 및 생성자 방문
    element.visitChildren(visitor);

    // 생성된 클래스의 각 부분을 작성할 버퍼
    final buffer = StringBuffer();

    // fromJson
    String generatedFromJSon = generateFromJsonMethod(visitor);
    buffer.writeln(generatedFromJSon);

    // toJson
    String generatedToJSon = generateToJsonMethod(visitor);
    buffer.writeln(generatedToJSon);

    // copyWith
    String generatedCopyWith = generateCopyWithMethod(visitor);
    buffer.writeln(generatedCopyWith);

    return buffer.toString();
  }

  // fromJSon 메서드 생성하는 메소드
  String generateFromJsonMethod(ModelVisitor visitor) {
    // 모델 방문자로부터 클래스 이름 가져오기
    String className = visitor.className;

    // 생성된 클래스의 각 부분을 작성할 버퍼
    final buffer = StringBuffer();

    // --------------------fromJson 생성 코드 시작--------------------//
    buffer.writeln('// From Json Method');
    buffer.writeln(
        '$className _\$${className}FromJson(Map<String, dynamic> json) => ');
    buffer.write('$className(');

    for (int i = 0; i < visitor.fields.length; i++) {
      String fieldName = visitor.fields.keys.elementAt(i);
      String mapValue = "json['$fieldName']";

      buffer.writeln(
        "${visitor.fields.keys.elementAt(i)}: $mapValue,",
      );
    }
    buffer.writeln(');');
    buffer.toString();
    return buffer.toString();
    // --------------------fromJson 생성 코드 끝--------------------//
  }

  // toJson 메서드 생성하는 메소드
  String generateToJsonMethod(ModelVisitor visitor) {
    // 모델 방문자로부터 클래스 이름 가져오기
    String className = visitor.className;

    // 생성된 클래스의 각 부분을 작성할 버퍼
    final buffer = StringBuffer();

    // --------------------toJson 생성 코드 시작--------------------//
    buffer.writeln('// To Json Method');
    buffer.writeln(
        'Map<String, dynamic> _\$${className}ToJson($className instance) => ');
    buffer.write('<String, dynamic>{');
    for (int i = 0; i < visitor.fields.length; i++) {
      String fieldName = visitor.fields.keys.elementAt(i);
      buffer.writeln(
        "'$fieldName': instance.$fieldName,",
      );
    }
    buffer.writeln('};');
    return buffer.toString();
    // --------------------toJson 생성 코드 끝--------------------//
  }

  // copyWith 메서드 생성하는 메소드
  String generateCopyWithMethod(ModelVisitor visitor) {
    // 모델 방문자로부터 클래스 이름 가져오기
    String className = visitor.className;

    // 생성된 클래스의 각 부분을 작성할 버퍼
    final buffer = StringBuffer();

    // --------------------copyWith 생성 코드 시작--------------------//
    buffer.writeln(
        "// $className 클래스에 'copyWith' 메소드를 제공하는 확장");
    buffer.writeln('extension \$${className}Extension on $className {');
    buffer.writeln('$className copyWith({');
    for (int i = 0; i < visitor.fields.length; i++) {
      String dataType =
          visitor.fields.values.elementAt(i).toString().replaceAll("?", "");
      String fieldName = visitor.fields.keys.elementAt(i);
      buffer.writeln(
        '$dataType? $fieldName,',
      );
    }
    buffer.writeln('}) {');
    buffer.writeln('return $className(');
    for (int i = 0; i < visitor.fields.length; i++) {
      buffer.writeln(
        "${visitor.fields.keys.elementAt(i)}: ${visitor.fields.keys.elementAt(i)} ?? this.${visitor.fields.keys.elementAt(i)},",
      );
    }
    buffer.writeln(');');
    buffer.writeln('}');
    buffer.writeln('}');
    buffer.toString();
    return buffer.toString();
    // --------------------copyWith 생성 코드 끝--------------------//
  }
}
```

이미 귀하는 프로페셔널하고 훌륭한 개발자이십니다. 🎉🎉

마지막 단계에서는 build.yaml 파일에서 builder_factories: ["generateJsonMethods"]를 볼 수 있습니다. 이는 최상위 수준 함수를 포함하고 있으며, build.yaml 파일을 확인한 후 build_runner가 호출하게 될 것이며, 그 다음에는 이전에 생성된 생성기(JsonGenerator)를 호출하게 될 것입니다.

<div class="content-ad"></div>

위의 정의는 다음과 같이 되어야 합니다:

```js
Builder 이름(BuilderOption) 
```

lib/generators.dart 파일에서:

```js
library generators;

import 'package:build/build.dart';
import 'package:generators/src/json_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder generateJsonMethods(BuilderOptions options) {
  // Step 1
  return SharedPartBuilder(
    [JsonGenerator()], // Step 2
    'json_generator', // Step 3
  );
}
```

<div class="content-ad"></div>

**단계 1:** [Builder]는 파일의 일부로 생성된 콘텐츠를 생성하는데 사용됩니다. 생성된 파일은 partId로 접두사가 붙어 있어 여러 [SharedPartBuilder]가 충돌하지 않고 일부 파일을 생성할 수 있습니다.

**단계 2:** 이것은 우리의 생성기 클래스입니다.

**단계 3:** partId 매개변수가 있습니다. 각 .dart 입력에 대해 어떤 파일이 생성될지 나타냅니다. 이 확장자는 다른 [SharedPartBuilder]와 충돌하지 않도록 고유해야 합니다.

좋아요! 이제 생성기를 만들었네요, 축하합니다. 🎉🎉

<div class="content-ad"></div>

이제 사용자 정의 주석 및 빌더를 테스트해 봅시다.

# 예제 프로젝트

pubspec.yaml 파일을 열어 주석 및 빌더 패키지의 종속성을 추가하세요.

```yaml
dependencies:
  flutter:
    sdk: flutter

  # 우리의 주석 패키지
  annotations:
    path: ../annotations/

dev_dependencies:
  flutter_test:
    sdk: flutter

  build_runner:
  # 우리의 생성기 패키지
  generators:
    path: ../generators/
```

<div class="content-ad"></div>

위 명령어를 실행하십시오: flutter pub get.

lib 폴더로 이동하여 새로운 클래스를 생성하십시오. 예를 들어 Product라는 이름의 클래스를 생성하십시오:

```js
import 'package:annotations/annotations.dart';

// 스텝 1
part 'product.g.dart'; // 파일 이름과 동일해야 함

// 스텝 2
@customAnnotation
class Product{
  final String name;
  final double price;

  const Product({required this.name, required this.price});

  /// 생성된 [_$ProductFromJson] 함수를 `fromJson` 팩토리와 연결합니다.
  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  /// 생성된 [_$ProductToJson] 함수를 `toJson` 메소드와 연결합니다.
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
```

스텝 1: 파일 상단에 part `파일이름.g.dart`라는 줄을 추가하여 이 파일이 생성된 코드의 일부임을 지정하십시오. part `파일이름.g.dart`의 파일 이름이 Dart 파일 이름과 일치하는지 확인하십시오.

<div class="content-ad"></div>

스텝 2: 제품 클래스에 우리의 주석을 추가하세요.

예제 프로젝트 터미널에서 다음 명령을 실행해보세요:

dart run build_runner build

예제 프로젝트 터미널에서 명령을 실행한 후 다음 출력이 표시됩니다:

<div class="content-ad"></div>


![Code Generation using Flutter](/assets/img/2024-06-21-CodeGenerationusingFluttersource_genbuild_runner_2.png)

Output/Generated file:

```js
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************  
// JsonGenerator  
// **************************************************************************

// From Json Method
Product _$ProductFromJson(Map<String, dynamic> json) => Product(
    name: json['name'],
    price: json['price'],
);

// To Json Method
Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
    'name': instance.name,
    'price': instance.price,
};

// Extension for a Product class to provide 'copyWith' method
extension $ProductExtension on Product {
    Product copyWith({
        String? name,
        double? price,
    }) {
        return Product(
            name: name ?? this.name,
            price: price ?? this.price,
        );
    }
}
```

Now you can build your annotation with more customization 🎉😎


<div class="content-ad"></div>

위 글을 읽어주셔서 감사합니다. 도움이 되셨으면 좋겣습니다. 궁금한 점이 있으면 언제든지 연락주세요.

소스 코드

질문이 있으면 LinkedIn 계정을 통해 연락주세요.