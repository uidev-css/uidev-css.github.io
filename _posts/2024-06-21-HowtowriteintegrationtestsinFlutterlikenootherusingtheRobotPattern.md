---
title: "Robot 패턴을 사용한 Flutter 통합 테스트 작성법  이제껏 경험하지 못한 방법"
description: ""
coverImage: "/assets/img/2024-06-21-HowtowriteintegrationtestsinFlutterlikenootherusingtheRobotPattern_0.png"
date: 2024-06-21 23:30
ogImage: 
  url: /assets/img/2024-06-21-HowtowriteintegrationtestsinFlutterlikenootherusingtheRobotPattern_0.png
tag: Tech
originalTitle: "How to write integration tests in Flutter like no other, using the Robot Pattern"
link: "https://medium.com/flutter-community/how-to-write-integration-tests-in-flutter-like-no-other-using-the-robot-pattern-8edfd14dc081"
---


플러터에서 통합 테스트를 작성하고 싶다면, 더 이상 찾을 필요가 없어요! 전문가처럼 로봇 패턴을 사용하여 통합 테스트를 작성하는 방법을 정확히 보여드릴 거예요.

튜토리얼을 비디오 형식으로 따라가시길 원하신다면, 이 비디오를 확인해주세요.

바로 시작해봅시다!

통합 테스트를 작성하기 위해서는 먼저 무엇이 통합 테스트인지 배워야 해요.

<div class="content-ad"></div>

통합 테스트는 소프트웨어의 다른 모듈을 그룹으로 테스트하는 데 사용됩니다. 이러한 테스트는 종단 간 (End to End, E2E) 테스트로도 알려져 있습니다.

우리의 경우, 앱의 두 모듈을 그룹으로 테스트할 것입니다. 로그인 모듈과 홈 모듈입니다.

이것을 코드 따라하기 튜토리얼로 만들기로 했기 때문에, 여기에 템플릿을 업로드했습니다: [링크](https://github.com/Coffiie/personal_projects/tree/develop/code_along/robot_testing_flutter_gh)

프로젝트를 클론하고 저와 함께 단계별로 통합 테스트를 구현해보세요!

<div class="content-ad"></div>

만약 Medium에서 50명의 팔로워를 얻으면, GitHub에서 이를 위한 통합 플로우와 소스 코드를 모두 공개할 거에요!

그러기 전에 시작하기 전에, 테스트를 작성할 앱과 테스트를 구현할 패턴에 대해 살펴봐요.

저희 앱은 "1234" 앱이에요. 이 마법의 숫자로 홈페이지에 접속할 수 있어요.

하지만 잘못된 자격 증명을 입력하면, 화면 하단에 "잘못된 자격 증명" 메시지가 표시되는 스낵 바가 나타나요.

<div class="content-ad"></div>


![이미지](/assets/img/2024-06-21-HowtowriteintegrationtestsinFlutterlikenootherusingtheRobotPattern_0.png)

로봇 패턴은 일반 사용자가 하는 것과 같은 동작을 로봇을 통해 수행하여 통합 테스트를 작성하는 방법입니다.

이는 우리가 테스트하는 내용에 집중하도록 하며 어떻게 테스트하는지보다는 무엇을 테스트하는지에 중점을 두도록 합니다. 또한 코드를 더 읽기 쉽고 재사용 가능하도록 만듭니다.

이제 통합 테스트, 앱 및 로봇 패턴에 대한 일반적인 이해가 생겼으므로 통합 테스트 작성을 시작할 수 있습니다!


<div class="content-ad"></div>

## 단계 1: 통합 테스트 패키지 가져오기

![이미지](/assets/img/2024-06-21-HowtowriteintegrationtestsinFlutterlikenootherusingtheRobotPattern_1.png)

## 단계 2: 로그인 로봇 생성

Flutter 프로젝트의 루트에 integration_test라는 폴더를 만든 다음 그 폴더 안에 robots라는 폴더를 만드세요.

<div class="content-ad"></div>

우리의 모든 통합 테스트 플로우는 integration_test 폴더의 하위로 이동하게 될 것이고, 우리의 로봇들은 robots 폴더의 하위로 이동하게 될 거에요.

이제 robots 디렉토리 안에 robot을 만들어보고 login_robot.dart라고 이름 짓도록 해요.

이 파일 안에는 LoginRobot 클래스를 구현할 거고, 이 클래스는 테스트 프레임워크와 상호 작용하며 사용자가 하는 동일한 작업을 수행하여 로그인 화면을 테스트할 것입니다.

그래서 이제 우리는 이렇게 클래스에 WidgetTester 의존성을 추가할 수 있어요:

<div class="content-ad"></div>


![Image 1](/assets/img/2024-06-21-HowtowriteintegrationtestsinFlutterlikenootherusingtheRobotPattern_2.png)

## Step 3: 분석 로그인 페이지

소스 코드를 살펴보면, WidgetKeys 클래스에 할당된 여러 위젯을 볼 수 있습니다. 이러한 키는 테스트 프레임워크에서 위젯을 식별하는 데 유용하며, 테스트에서 위젯을 찾을 때 유리합니다.

![Image 2](/assets/img/2024-06-21-HowtowriteintegrationtestsinFlutterlikenootherusingtheRobotPattern_3.png)


<div class="content-ad"></div>

## 단계 4: 로그인 로봇 구현

LoginRobot 클래스에 다음 메서드를 추가합니다.

![이미지](/assets/img/2024-06-21-HowtowriteintegrationtestsinFlutterlikenootherusingtheRobotPattern_4.png)

- verify(): 로그인 화면에 존재하는지 테스트합니다.
- enterPassword, enterUsername 및 tapLoginButton은 실명있는 메서드입니다.
- verifyError(): 잘못된 자격 증명을 입력했을 때 나타나는 스낵 바를 테스트하는 데 사용됩니다.

<div class="content-ad"></div>

## 단계 5: 인증되지 않은 플로우 생성

이 앱에는 2가지 주요 플로우가 있습니다.

하나는 인증되지 않은 플로우이며, 여기서 사용자는 로그인할 수 없으며 잘못된 자격 증명을 입력한 사용자에게 스낵 바가 표시됩니다.

다른 플로우는 올바른 자격 증명으로 인증하고 홈 화면으로 이동할 수 있는 플로우입니다.

<div class="content-ad"></div>

이번 튜토리얼은 간단하게 유지하기 위해 인증되지 않은 흐름에만 초점을 맞추겠습니다.

구현을 시작하려면 integration_test 폴더에 e2e_unauth_test.dart라는 파일을 만들어주세요.

먼저 main() 메서드를 생성해주세요. 그런 다음 IntegrationTestWidgetsFlutterBinding.ensureInitialized()를 호출하여 통합 테스트 프레임워크가 준비되었는지 확인해주세요.

이 작업이 완료되면 LoginRobot 메서드를 호출하여 테스트 흐름을 신속하게 구현할 수 있습니다.

<div class="content-ad"></div>


![이미지](/assets/img/2024-06-21-HowtowriteintegrationtestsinFlutterlikenootherusingtheRobotPattern_5.png)

3번째 줄에 import를 주목하세요. 라인 14에서 Myapp 생성자를 직관적으로 호출하여 개발한 실제 앱을 펌핑할 수 있습니다.

## 단계 6: 테스트 실행

타다! 실행 옵션을 누름으로써 테스트를 실행하고 통과하는 것을 관찰할 수 있습니다! 
앱을 더 견고하게 만들어줄 코드를 성공적으로 작성하였습니다!


<div class="content-ad"></div>

## 명심해야 할 몇 가지 사항

- 통합 테스트는 소프트웨어의 다른 모듈을 그룹으로 테스트하는 데 사용됩니다. 또한 엔드 투 엔드 (E2E) 테스트로도 알려져 있습니다.
- 로봇 패턴에서는 각 화면에 대한 로봇을 작성하고 위젯 테스터를 사용하여 사용자가 하는 것과 유사한 테스트를 작성합니다.
- 로봇을 구현한 후에는 모든 구현이 로봇 내부에 추상화되어 있으므로 특정 작업을 실행해야 할 때마다 그들의 메소드를 호출하기만 하면 복잡한 흐름을 쉽게 만들 수 있습니다.

## 재미있는 활동

인증된 흐름을 구현해야 할 마지막 흐름이 남아 있습니다. 이를 만들고 완료되면 LinkedIn에서 DM(Direct Message)을 보내주세요. 당신의 솔루션을 보는 것을 기대할게요! :)

<div class="content-ad"></div>

# 만약 튜토리얼이 마음에 드셨다면...

저를 여기와 제 소셜 미디어 계정에서 팔로우해주세요!

팔로우하기:

Youtube: [링크](https://www.youtube.com/channel/UCD2BEqL0wC7leFKm4i9_aRg)
LinkedIn: [링크](https://www.linkedin.com/in/rawahamuhammad/)
Github: [링크](https://github.com/coffiie)
Medium: Rawaha Muhammad

<div class="content-ad"></div>

런타임 스니펫(Runtime Snippets)을 따라하세요 (조각처럼 작은 플러터/다트 튜토리얼)

Youtube: https://www.youtube.com/channel/UCD2BEqL0wC7leFKm4i9_aRg
LinkedIn: https://www.linkedin.com/company/100042850
Twitter: https://twitter.com/runtimesnippets