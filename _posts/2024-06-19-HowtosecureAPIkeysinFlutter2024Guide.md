---
title: "2024년 플러터Flutter에서 API 키를 안전하게 보호하는 방법 안내"
description: ""
coverImage: "/assets/img/2024-06-19-HowtosecureAPIkeysinFlutter2024Guide_0.png"
date: 2024-06-19 14:27
ogImage: 
  url: /assets/img/2024-06-19-HowtosecureAPIkeysinFlutter2024Guide_0.png
tag: Tech
originalTitle: "How to secure API keys in Flutter (2024) Guide"
link: "https://medium.com/@letmeflutter123/how-to-secure-api-keys-in-flutter-2024-guide-cc83086404b8"
---


앱 빌드에 패킹된 거의 모든 것이 밝혀질 수 있다는 사실을 아셨나요? 이에는 테스트 계정 정보, 재미있는 할 일 목록, 실수로 추가한 장보기 목록, 심지어 API 키 등이 포함됩니다. 네, 어떤 사람들은 여전히 프로젝트에 장보기 목록을 저장해 둔 채로 있습니다!

## 그렇다면, 다른 좋은 옵션이 뭘까요?

우리는 .env 파일을 사용하여 비밀 정보를 저장할 수 있습니다. 그러면 그 정보에 접근하는 것이 쉬워집니다. flutter_dotenv를 사용하여 이에 대해 더 알아볼 수 있습니다. 하지만 여기서 문제가 하나 있습니다. 이 방법이 더 나은 것은 사실이지만, 여전히 이러한 비밀 정보를 파악하기는 꽤 쉽습니다. 왜냐하면 우리는 Dart 파일에서 이 정보를 사용하기 위해 pubspec.yaml에서 .env 파일들을 자산으로 나열해야 하기 때문입니다. 그리고 여기서 문제가 발생합니다: 자산은 어떤 복호화나 특별한 역공학 요령 없이도 쉽게 접근할 수 있습니다.

안드로이드 스튜디오의 "난독화" 플래그를 사용하여 정보를 숨기려고 해도, 자산에는 여전히 쉽게 접근할 수 있습니다. 그러므로 안타깝게도, 여러분의 비밀 정보는 실제로 안전하지 않습니다.

<div class="content-ad"></div>

<img src="/assets/img/2024-06-19-HowtosecureAPIkeysinFlutter2024Guide_0.png" />

## 환경 변수에 대해 들어 보셨나요?

결혼 기념일과 같은 중요한 정보를 전달하는 데 꽤 편리합니다. 여기에 사용 방법이 있습니다: VS Code의 launch.json 파일의 "toolArgs" 섹션에 " — dart-define"을 추가합니다. 그런 다음 코드에서 String.fromEnvironment('NAME')과 같은 방식으로 액세스할 수 있습니다. 이렇게 하면 비밀이 안전하게 보호됩니다.

```js
print(const String.fromEnvironment('ANNIVERSARY'));
```

<div class="content-ad"></div>

안녕하세요. 안드로이드 스튜디오에서도 똑같이 할 수 있어요.

![이미지](/assets/img/2024-06-19-HowtosecureAPIkeysinFlutter2024Guide_1.png)

잠시만 기다려주세요. 아직 해결되지 않은 문제가 있어요. 환경 변수를 사용하는 것은 비밀을 보호하는 좋은 방법이지만, 실행 구성을 통해 모든 것을 전달하게 되기 때문에 최선은 아닙니다. 물론, "dart-define-from-file"을 통해 데이터를 파일을 통해 전달하거나 안전을 위해 .gitignore에 추가하는 방법도 있어요. 그런데 여기서 한 가지 더 좋은 방법이 있어요.

# 우리의 슈퍼스타를 만나보세요: Envied

<div class="content-ad"></div>

Envied는 나에게 지금까지 최고의 옵션이에요.

Envied는 나에게 최고의 선택지로 떠오르는 이유가 있어요. 그 이유는 안전하기 때문이죠. .env 파일을 자산으로 추가하지 않아 노출 위험을 줄일 수 있어요. 게다가 인증 정보를 base64 형식으로 인코딩하여 다트 파일을 생성하므로, 비밀을 알아내려는 눈에게 어렵게 만들어줘요. 게다가 "obfuscate=true"를 통해 난독화를 활성화하여 추가적인 보안층도 더할 수 있어요.

무엇보다도, Envied는 서로 다른 플레이버를 사용하는 것을 공식적으로 지원하여 프로젝트 간의 호환성과 일관성을 보장해 줘요.

양쪽 플레이버에 대한 청사진을 스케치해 봅시다.

<div class="content-ad"></div>

String.fromEnvironment을 기억하시나요? 우리는 어떤 플레이버를 사용할지 정의하기 위해 ENV 키를 제공합니다. 그리고 AppSecret는 해당 플레이버의 비밀을 반환할 겁니다.

```js
abstract class AppSecret implements AppEnvFields {
  static const String environment = String.fromEnvironment('ENV', defaultValue: 'prod');

  static final AppSecret _instance =
      environment == 'prod' ? ProductionSecret() : DevelopmentSecret();

  factory AppSecret() => _instance;
}
```

이번에는 ProductionSecret 안으로 살짝 들여다보겠습니다. 먼저, 환경 파일에서 시크릿을 생성하기 위한 부분을 추가할 겁니다. 환경 파일의 경로와 함께 @Envied 어노테이션을 사용하고 "obfuscate=true"로 설정해주세요.

다음으로, AppSecret와 AppEnvFields를 구현할 겁니다. 이는 키가 어떻게 재정의되어야 하는지에 대해 합의되어 있는지 확인하는 것을 보장합니다. AppSecret가 정확히 같은 시크릿을 보유하고 있기 때문에, 다른 플레이버에서 문제를 발생시키지 않고 사용할 수 있습니다.

<div class="content-ad"></div>

"obfuscate=true"로 설정한 경우 각 키를 final로 선언해야 합니다. 그리고 환경 파일에서 해당 키 이름을 사용하여 @EnviedField로 각각 주석을 달겠습니다. 우리의 경우에는 "SECRET_KEY"입니다.

마지막으로 생성된 파일에서 값을 가져올 _ProductionSecret.secretKey를 호출할 것입니다.

```dart
part 'env_prod.g.dart';

@Envied(
  path: 'environment/.env.prod',
  obfuscate: true,
)
class ProductionSecret implements AppSecret, AppEnvFields {
  ProductionSecret();

  @override
  @EnviedField(varName: 'SECRET_KEY')
  final secretKey = _ProductionSecret.secretKey;
}
```

마지막으로 아래 명령 중 하나를 실행해야 합니다.

<div class="content-ad"></div>

```markdown
# dart
dart run build_runner build
# flutter
flutter pub run build_runner build
```

`.gitignore` 파일에 `.env`, `production_secret.dart`, `production_secret.g.dart`를 추가하는 걸 잊지 마세요. 이것들을 깃 저장소에 저장하고 싶지 않을 거예요.

# CI/CD 흐름에서 시크릿 키 사용하는 방법

만약 Github Actions나 CodeMagic와 같은 CI/CD 도구를 사용 중이라면, 이 플랫폼 내에서 키를 안전하게 저장하는 것이 중요합니다. 그리고 워크플로우에서 Envied 파일을 동적으로 생성할 수 있습니다.
```

<div class="content-ad"></div>

이렇게 함으로써 CI/CD 프로세스 중에도 중요 정보가 보호되면서 엑세스할 수 있게 됩니다. CodeMagic에서 어떻게 수행하는지 확인하려면 아래 링크를 확인하세요.

## 결론

이로써 마무리 지었습니다! 오늘의 통찰력이 도움이 되었기를 바라겠습니다. Envied가 시크릿을 안전하게 지킬 수 있는 좋은 도구라는 것을 기억하세요. 하지만 핵 코드를 저장하지는 말아주세요, 그냥 안전하게요!

이 기사가 유용하다고 느꼈다면 팔로우, 박수 및 공유를 잊지 말아주세요.

<div class="content-ad"></div>

읽어 주셔서 감사합니다!