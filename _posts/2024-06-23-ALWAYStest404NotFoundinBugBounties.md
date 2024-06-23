---
title: "버그 바운티에서 꼭 테스트해야 하는 404 Not Found 오류"
description: ""
coverImage: "/assets/img/2024-06-23-ALWAYStest404NotFoundinBugBounties_0.png"
date: 2024-06-23 15:13
ogImage: 
  url: /assets/img/2024-06-23-ALWAYStest404NotFoundinBugBounties_0.png
tag: Tech
originalTitle: "ALWAYS test 404 Not Found in Bug Bounties!"
link: "https://medium.com/@mares.viktor/always-test-404-not-found-in-bug-bounties-2be47801b4c0"
---


안녕하세요 여러분, 오늘은 항상 "/" 디렉토리가 없는 웹 사이트를 테스트해야 하는 이유와 다른 많은 버그 바운티 헌터들이 놓치고 있는 것을 보여드리고 싶습니다.

솔직히 말해서, 버그 바운티 헌팅은 피곤할 수 있습니다, 특히 풀타임으로 취약점 테스터/웹 개발자 등으로 일하고 있는 경우 더욱 그렇습니다. 주로 야간에만 테스트할 수 있으며 이는 유연성이 없는 상황을 만듭니다 - 취약점을 빨리 찾아야 합니다(우리는 모두 중복을 싫어합니다) 그리고 실력이 있어야 합니다.

그러나 최근에 중요/높음 수준의 취약점을 찾기 위해 노력 중인 많은 헌터들이 아래와 같이 보이는 웹 사이트에 관심을 덜어 주는 것을 알아냈습니다:

<img src="/assets/img/2024-06-23-ALWAYStest404NotFoundinBugBounties_0.png" />

<div class="content-ad"></div>

다음 속담이 딱 맞아요:

많은 Hunter들은 그런 웹사이트(내용이 없는 것처럼 보이는)를 빨리 떠날 거에요. 그러나 / 디렉토리에 내용이 없다고 해서 전혀 내용이 없는 것은 아닙니다.

## 예시 1:

와일드카드 서브도메인 Scope (*.example.com)에서 버그 바운티 헌팅을 할 때, 서브도메인 열거를 위해 평소처럼 도구를 이용하다가 어느 순간 404 Not Found를 반환하는 서브도메인에 걸립니다. 익명화를 위해 예시 서브도메인으로 example1.example.com을 사용해봅시다.

<div class="content-ad"></div>

그 웹 사이트를 식별한 후 - `단계 1은 컨텐츠 발견을 시작하는 것입니다. 저는 dirsearch 툴과 제 자체 워드리스트를 사용하여 이 작업을 수행합니다:

[https://github.com/ViktorMares/ultimate_discovery](https://github.com/ViktorMares/ultimate_discovery)

따라서, 다음 명령을 사용하여 컨텐츠 발견을 시작합니다:

<div class="content-ad"></div>

그리고 결과는 다음과 같습니다:

![이미지](/assets/img/2024-06-23-ALWAYStest404NotFoundinBugBounties_2.png)

따라서 404 Not Found에서 몇 개의 정적 페이지를 볼 수 있습니다.

우리는 하나씩 각 정적 페이지로 이동하여 소스 코드에서 다음 부분을 찾을 수 있습니다

<div class="content-ad"></div>


![Image](/assets/img/2024-06-23-ALWAYStest404NotFoundinBugBounties_3.png)

With the AWS Access Key and Secret Key, we may gain access to S3 buckets and the AWS infrastructure.

To verify the validity of the AWS secrets, you can use the repository below:

Try using the AWS Access Key and Secret Key values and run the tool.


<div class="content-ad"></div>

![이미지](/assets/img/2024-06-23-ALWAYStest404NotFoundinBugBounties_4.png)

위에서 볼 수 있듯이, AWS IAM 자격 증명을 발견했습니다. 사용자는 API에 액세스할 수도 있지만, 증명 목적으로 위 이미지만 표시했습니다.

그래서 우리는 이 취약점을 상세하게 보고하고 다음과 같은 응답을 받았습니다:

![이미지](/assets/img/2024-06-23-ALWAYStest404NotFoundinBugBounties_5.png)

<div class="content-ad"></div>

# 예제 2:

다시 한 번 서브도메인 (와일드카드 범위)을 찾기 시작하면 / 디렉토리 뒤에 아무 것도 없는 또 다른 웹 사이트 (example2.example.com)를 발견합니다.

![image](/assets/img/2024-06-23-ALWAYStest404NotFoundinBugBounties_6.png)

우리는 사용자 정의 워드리스트로 dirsearch 명령어를 실행하고 /sites 웹 페이지 - `https://example2.example.com/sites` 를 찾았으며 결과는 다음과 같습니다:

<div class="content-ad"></div>


![Image](/assets/img/2024-06-23-ALWAYStest404NotFoundinBugBounties_7.png)

이 HTML 내용을 보면 정적 사이트를 불러오기 위해 ?SiteID 매개변수를 사용할 수 있다는 것을 보여줍니다. 그러나 SiteID 매개변수는 Reflected Cross-Site Scripting에 취약합니다. 거기에는 매개변수의 길이가 제한되어 있어서 가능한 가장 짧은 XSS Payload를 사용해야 합니다. 즉, `svg/onload=alert()`

![Image](/assets/img/2024-06-23-ALWAYStest404NotFoundinBugBounties_8.png)

한번 더 발견을 보고하자, 폭발!


<div class="content-ad"></div>

![image](/assets/img/2024-06-23-ALWAYStest404NotFoundinBugBounties_9.png)

이 방법론이 흥미로웠으면 좋겠고, 당신은 어떤 웹사이트도 건드리지 않고 지나치지 않기를 바랍니다. 향후 업무와 버그 바운티에서 도움이 될 수 있기를 바랍니다!

이야기를 읽어주셔서 감사합니다. 정말 즐거우셨다면, 제 프로젝트를 지원해주시려면 아래 링크를 통해 아피리에이트 매체 멤버십을 받아보시기 바랍니다: https://medium.com/@mares.viktor/membership

행운을 빕니다!