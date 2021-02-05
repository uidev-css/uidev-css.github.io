---
layout: post
title: "Netliify 기능 및 Fauna가 포함된 FAQ Slack 앱을 생성합니다.DB"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/10/slack-app.png
tags: 
---


간혹 빠른 답변을 원하는 경우 다른 사람이 질문에 응답하기를 기다리지 않고 FAQ 시스템을 사용하는 것이 매우 유용합니다. 슬랙이 우리를 위해 이 FAQ에 대답해 주면 좋지 않을까? 이 튜토리얼에서는 사용자 FAQ에 응답하는 Slash 명령어인 Slack에 대해 설명합니다. FQL을 사용하여 데이터베이스를 검색하고 Netliify 기능을 사용하여 Slack과 FaunaDB를 연결하는 서버 없는 끝점을 제공하는 FaunaDB에 답변을 저장합니다.

### 전제조건

이 튜토리얼에서는 다음과 같은 요구 사항이 있다고 가정합니다.

- Netliify 및 Fauna에 로그인하고 코드를 저장하는 데 사용되는 Github 계정
- 새 앱을 만들고 설치할 수 있는 권한으로 작업 공간을 늘립니다.
- Node.js v12

### npm 패키지 생성

시작하려면 새 폴더를 만들고 원하는 패키지 관리자를 사용하여 pm 패키지를 초기화하고 폴더 내부에서 npm in-y를 실행하십시오. 패키지가 생성된 후 몇 개의 npm 패키지를 설치할 수 있습니다.

이 튜토리얼에 필요한 모든 패키지를 설치하려면 이 옵션을 실행합니다.

```terminal
npm install express body-parser faunadb encoding serverless-http netlify-lambda
```

이러한 패키지는 아래에 설명되어 있지만, 이미 익숙하다면 언제든지 건너뛸 수 있습니다.

인코딩은 작성 시 @netliify/plugin-functions-core에서 발생한 플러그인 오류로 인해 설치되었으며 이 튜토리얼을 따를 때 필요하지 않을 수 있습니다.

Express는 기능을 위해 여러 엔드포인트 쓰기를 단순화할 수 있는 웹 애플리케이션 프레임워크입니다. Netlifify 기능을 사용하려면 각 끝점에 대한 처리기가 필요하지만, sexpress와 serverless-http를 함께 사용하면 끝점을 한 곳에 모두 쓸 수 있습니다.

Body-parser는 Slack이 우리의 기능에 보낼 `application/x-ww-w-form-url 인코딩` 데이터를 처리할 수 있는 고속 미들웨어이다.

Faunadb는 FaunaDB Javascript 드라이버를 통해 데이터베이스와 상호 작용할 수 있는 npm 모듈입니다. 답변을 얻기 위해 기능에서 데이터베이스로 쿼리를 전달할 수 있습니다.

Serverless-http는 Express 애플리케이션을 Netlifify 기능에 의해 예상되는 형식으로 포장하는 모듈로서, 로컬 개발에서 Netlifify로 전환할 때 코드를 다시 작성할 필요가 없습니다.

Netlifify-lambda는 Netlifify에 구축되고 배치되는 것과 동일한 방식으로 로컬에서 기능을 구축하고 제공할 수 있는 도구입니다. 즉, 코드를 Netliify로 푸시하기 전에 로컬에서 개발하여 워크플로우 속도를 높일 수 있습니다.

### 함수 생성

npm 패키지가 설치되었으므로 이제 기능 작업을 시작해야 합니다. 서버리스(서버리스)를 사용하여 고속 앱을 랩핑할 수 있습니다. 그러면 나중에 Netliify에 배포할 수 있습니다. 시작하려면 `netliify.toml` 파일을 만들고 다음 파일을 추가하십시오.

```html
[build]
  functions = "functions"
```

node_module 및 함수 폴더가 나중에 git에 추가되는 것을 방지하기 위해 .gitignore 파일을 사용합니다. .gitignore라는 파일을 생성하고 다음을 추가합니다.

기능/기능

node_contract/

src라는 폴더와 server.js라는 파일도 필요합니다. 최종 파일 구조는 다음과 같아야 합니다.

![image](https://lh5.googleusercontent.com/IWqCTL4f57n2uC2mG9V-Wj-0xE9gYv27wPDWMgNmFmjyU3UNOdHBGYj8EvDhdsiLxqCKtLmC_wNMoyROaqci5sGxBh7nJJvGNX8nCFX40l0bvKlqIJBYduN_J5uWwKqg_O3pOFIe)

이 기능을 사용하면 아래 코드를 server.js에 삽입하여 기본 Express 앱을 만듭니다.

```js
const express = require("express");
const bodyParser = require("body-parser");
const fauna = require("faunadb");
const serverless = require("serverless-http");
 
const app = express();
 
module.exports.handler = serverless(app);
```

최종 줄을 확인해 보세요. 일반 익스프레스 앱과는 조금 다르게 보입니다. 포트에서 수신을 하지 않고 앱을 서버리스에 전달하여 Netliify가 기능을 호출할 수 있도록 처리기로 사용하고 있습니다.

애플리케이션/x-www-form-url 인코딩된 데이터를 사용하고 라우터를 배치하도록 바디 파서를 설정해 봅시다. app 정의 후 server.js에 다음을 추가합니다.

```js
const router = express.Router();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use("/.netlify/functions/server", router);
```

라우터가 끝점으로 `/.netliify/functions/server`를 사용하고 있습니다. 따라서 Netlifify는 튜토리얼 뒷부분에서 이 기능을 올바르게 배포할 수 있습니다. 즉, 함수를 호출하려면 기본 URL에 이 기능을 추가해야 합니다.

기본 앱이 설치된 상태에서 테스트 경로를 만들어 모든 것이 작동하는지 점검해 보겠습니다. 다음 코드를 삽입하여 단순 json 개체를 반환하는 단순 GET 경로를 생성합니다.

```js
router.get("/test", (req, res) => {
 res.json({ hello: "world" });
});
```

이 경로를 통해 로컬 호스트에 대한 기능을 활성화하고 응답이 있는지 확인합니다. 우리는 netliify-lambda를 사용하여 우리의 앱을 서비스할 것입니다. 그래야 우리가 포트 9000에서 로컬로 netliify 기능을 모방할 수 있습니다. 우리 포장에.json, 스크립트 섹션에 다음 행을 추가합니다.

```js
"start": "./node_modules/.bin/netlify-lambda serve src",
   "build": "./node_modules/.bin/netlify-lambda build src"
```

이를 통해 파일을 저장한 후 npm start를 실행하여 포트 9000에서 ntliify-lambda를 시작할 수 있습니다.

빌드 명령은 나중에 Netliify에 배포할 때 사용됩니다.

가동 후 실행되면 `http://localhost:9000/.netliify/functions/server/test`를 방문하여 기능이 정상적으로 작동하는지 확인할 수 있습니다.

![image](https://lh3.googleusercontent.com/nr2cf65GBJgggqLjKqQT9Dm_SD2Ky440R5GrlKUhmVCDz0L9OOVsu8dDJdSdJ0jiQ3oLN0S41S66Mbm9Yl4Qb3dV6YalQRBxqkG9yM8C1rTri-o0cskzZTIUP5NjgwQuY-0vVKCL)

netlify-lambda의 장점은 코드 변경 사항을 수신하고 업데이트할 때마다 자동으로 다시 컴파일하여 본 튜토리얼의 기간 동안 실행할 수 있다는 것입니다.

### 시작록 URL

이제 로컬 컴퓨터에서 테스트 경로가 작성되었습니다. 온라인에서 사용할 수 있도록 해 보겠습니다. 이를 위해, 우리는 우리의 기능을 위한 공개 URL을 제공하는 ngrok, 그리고 pm 패키지를 사용할 것입니다. ngrok이 설치되어 있지 않은 경우 먼저 npm install-gangrok을 실행하여 컴퓨터에 설치합니다. 그런 다음 포트 9000에서 실행되는 우리 함수로 트래픽을 자동 전달하는 `ngrok http 9000`을 실행합니다.

![image](https://lh3.googleusercontent.com/VbHVST9eOn8ad83msp-vvItk5gDZ_v_bI2pcq5XMtsiXaT7YenTxlmyxFmfYYaPp6LcMdAxeMzaaspPqe1g6h6R3UxZWxhlhuOLuUqOyCjkrpMVUl0b1FEtH7Ynupb3kyrV-Xs48)

ngrok을 시작한 후 터미널에 포워딩 URL이 표시되어 서버를 온라인으로 사용할 수 있는지 확인할 수 있습니다. 이 기본 URL을 브라우저에 복사한 후 `/.netlifify/functions/server/test`로 따르십시오. localhost에서 전화를 걸었을 때와 동일한 결과가 나타납니다. 즉, 이제 이 URL을 Slack의 끝점으로 사용할 수 있습니다!

ngrok을 다시 시작할 때마다 새 URL이 생성되므로 언제든지 중지해야 하는 경우 Slack에서 URL 끝점을 업데이트해야 합니다.

### 슬랙 설정

이제 기능이 준비되었으니 슬랙으로 이동하여 앱과 슬래시 명령을 생성해야 합니다. 우리는 이 앱을 작업 공간에 배치해야 할 뿐만 아니라, 우리의 기능을 연결하기 위해 코드를 몇 가지 업데이트해야 할 것이다. 새 슬래시 명령을 생성하는 방법에 대한 자세한 지침은 Slash 공식 설명서를 참조하십시오. 간소화된 지침을 보려면 아래 절차를 따르십시오.

먼저 이러한 FAQ에 대한 새로운 Slack 앱을 만들어 보겠습니다. https://api.slack.com/apps을 방문하여 Create New App(새 앱 만들기)을 선택하여 시작하십시오. 앱 이름을 지정하고(Fauna FAQ를 사용했습니다) 앱의 개발 작업 공간을 선택합니다.

앱을 만든 후에는 슬래시 명령을 추가하여 앱과 상호 작용할 수 있도록 해야 합니다. 앱이 생성된 후 메뉴에서 슬래시 명령을 선택한 다음 새 명령을 만듭니다. 다음 양식에 명령 이름(/faq 사용)과 ngrok의 URL을 입력하십시오. 끝에 `/.netliify/functions/server/`를 추가하는 것을 잊지 마십시오!

![image](https://lh6.googleusercontent.com/UwWJJnefw8bAkwGhMwKoNDYSHynVtq9Xzw6rs5YdaSyGSkh-_D3NPIQRR6Kx5vuDMSa67NGdV_I3yIKAbzC6oMw4c8LnjsuUMbUPAmcSoF-PP3rIJ8-ZNsg-qkTTFzxQwLV_0_Iu)

슬래시 명령을 작성했으면 왼쪽 사이드바에서 기본 정보를 클릭하여 앱의 기본 페이지로 돌아갑니다. 여기서 "작업영역에 앱 설치" 드롭다운을 선택하고 단추를 클릭하여 설치합니다.

![image](https://lh5.googleusercontent.com/jWz9Ozrz4z3uYO4GN4LpqAuABkFgPwPl4O6DemP85Kj8jJaVH2F51BEjFhPVZl48xh7FO8pQpB7RTFdsxoggor7mkbdqtwGfuN0cag8wWpTsOx8qtgje5Mt8RZ5Vg4RMQFmN2hhJ)

액세스를 허용하면 앱이 설치되고 작업 공간에서 슬래시 명령을 사용할 수 있습니다.

새 앱이 설치되면 Slack이 요청을 보낼 새 끝점을 만들어야 합니다. 이를 위해 단순성을 위해 루트 끝점을 사용합니다. 엔드포인트는 `application/x-www-form-url 인코딩` 데이터로 사후 요청을 받은 다음 메시지와 함께 200 상태 응답을 반환할 수 있어야 합니다. 이렇게 하려면 `server.js`에 다음 코드를 추가하여 루트에 새 사후 경로를 생성합시다.

```js
router.post("/", async (req, res) => {
 
});
```

엔드포인트를 확보했으므로 상태를 설정하기 전에 다음 줄을 추가하여 느슨하게 전송된 텍스트를 추출하고 볼 수도 있습니다.

```js
const text = req.body.text;
console.log(`Input text: ${text}`);
```

지금은 이 텍스트를 응답에 전달한 후 즉시 다시 전송하여 느슨한 앱과 기능이 통신하도록 하겠습니다.

```js
res.status(200);
res.send(text);
```

이제 슬랙 채널에 /faq <some question>을 입력하면 슬랙 슬래시 명령에서 동일한 메시지를 다시 받아야 합니다.

단순 텍스트만 돌려보내는 것이 아니라 Slack의 Block Kit를 활용하여 전문 UI 요소를 사용하여 답변의 모양을 개선할 수 있습니다. 보다 복잡한 레이아웃을 만들려면 Slack(슬랙)에서 레이아웃을 시각적으로 설계할 수 있는 Block Kit Builder를 제공합니다.

일단은, 우리는 모든 것을 단순하게 하고, 각각의 대답이 구분자로 구분되는 응답을 제공하려고 합니다. 다음 기능을 사후 경로 후 server.js 파일에 추가합니다.

```js
const format = (answers) => {
 if (answers.length == 0) {
   answers = ["No answers found"];
 }
 
 let formatted = {
   blocks: [],
 };
 
 for (answer of answers) {
   formatted["blocks"].push({
     type: "divider",
   });
   formatted["blocks"].push({
     type: "section",
     text: {
       type: "mrkdwn",
       text: answer,
     },
   });
 }
 
 return formatted;
};
```

이 기능을 사용하면 답변을 슬랙으로 반환하기 전에 형식을 지정하기 위해 답변을 이 기능에 전달해야 합니다. 루트 사후 경로에서 다음을 업데이트합니다.

```js
let answers = text;
const formattedAnswers = format(answers);
```

이제 슬래시 앱에 동일한 명령을 입력하면 동일한 메시지가 반환되지만 이번에는 포맷된 버전으로 표시됩니다!

### Fauna 설정

느슨한 앱이 설치되어 있고 앱에 연결할 수 있는 기능이 있기 때문에 이제 답변을 저장할 데이터베이스 작업을 시작해야 합니다. FaunaDB로 데이터베이스를 설정한 적이 없는 경우, 빠르게 시작하는 방법에 대한 유용한 문서가 있습니다. 데이터베이스 및 수집에 대한 간략한 단계별 개요는 다음과 같습니다.

먼저 새 데이터베이스를 작성해야 합니다. 온라인으로 Fauna 대시보드에 로그인한 후 새 데이터베이스를 클릭합니다. 새 데이터베이스에 기억할 이름을 지정하고("slack-faq") 데이터베이스를 저장합니다.

이 데이터베이스를 구축하려면 컬렉션이 필요합니다. 대시보드에 표시될 "새 컬렉션" 단추를 클릭하고 컬렉션 이름을 지정합니다(나는 "faq"를 사용함). 기록 일수 및 TTL 값은 기본값으로 둘 수 있지만 TTL 필드에 값을 추가하지 않도록 해야 합니다. 특정 시간이 지나면 문서가 자동으로 제거되지 않도록 해야 합니다.

이제 데이터베이스와 컬렉션이 준비되었습니다. 여기에 몇 가지 문서를 추가할 수 있습니다. 각 문서는 다음 구조를 따라야 합니다.

```js
{
   question: "a question string",
   answer: "an answer string",
   qTokens: [
       "first token",
       "second token",
       "third token"
   ]
}
```

qToken 값은 질문에 정확하게 일치시킬 수 없을 때 토큰화된 검색에 사용하기 때문에 질문의 핵심 용어여야 합니다. 각 질문에 원하는 만큼 q토큰을 추가할 수 있습니다. 토큰이 관련성이 높을수록 더 정확한 결과가 나올 것이다. 예를 들어, 만약 우리의 질문이 "화장실은 어디인가"라면, 우리는 qTokens "화장실", "화장실", "화장실", "화장실" 그리고 사람들이 욕실에 대한 정보를 찾을 때 검색할 것이라고 생각하는 다른 용어들을 포함해야 한다.

개념 증명을 개발하는 데 사용한 질문은 다음과 같습니다.

```js
{
  question: "where is the lobby",
  answer: "On the third floor",
  qTokens: ["lobby", "reception"],
},
{
  question: "when is payday",
  answer: "On the first Monday of each month",
  qTokens: ["payday", "pay", "paid"],
},
{
  question: "when is lunch",
  answer: "Lunch break is *12 - 1pm*",
  qTokens: ["lunch", "break", "eat"],
},
{
  question: "where are the bathrooms",
  answer: "Next to the elevators on each floor",
  qTokens: ["toilet", "bathroom", "toilets", "bathrooms"],
},
{
  question: "when are my breaks",
  answer: "You can take a break whenever you want",
  qTokens: ["break", "breaks"],
}
```

이 시간을 할애하여 원하는 만큼의 문서를 추가하고 각 질문에 필요한 만큼 qToken을 추가해 주시면 다음 단계로 넘어가겠습니다.

이러한 질문이 있으면 데이터베이스를 검색할 수 있도록 두 개의 인덱스를 만들 것입니다. 먼저, "answers_by_question"이라는 인덱스를 만들어, 용어로 질문을 선택하고 값으로 답변을 선택합니다. 이렇게 하면 모든 답변을 관련 질문별로 검색할 수 있습니다.

그런 다음 "answers_by_q"라는 인덱스를 만듭니다.토큰", 용어로 qTokens를 선택하고 값으로 답을 선택합니다. 이 인덱스를 사용하여 데이터베이스에 있는 모든 항목의 qTokens를 검색할 수 있습니다.

데이터베이스에서 검색을 실행하기 위해 두 가지 작업을 수행합니다. 먼저 질문에 대한 정확한 일치 항목을 검색하므로 사용자에게 단일 답변을 제공할 수 있습니다. 둘째, 이 검색에서 결과가 발견되지 않으면 각 답변의 qTokens에 대한 검색을 수행하여 일치하는 결과를 반환합니다. Fauna의 온라인 셸을 사용하여 이러한 쿼리를 시연하고 설명하는 데 사용할 것입니다.

토큰을 검색하기 전에 입력 질문을 정확하게 일치시킬 수 있는지 테스트합니다. 사용자가 요청한 내용에 대한 최상의 답변을 얻을 수 있습니다. 질문을 검색하려면 "answers_by_question" 인덱스와 비교한 후 답변을 페이지화합니다. 다음 코드를 온라인 Fauna 셸에 복사하여 이 코드를 확인합니다.

```js
q.Paginate(q.Match(q.Index("answers_by_question"), "where is the lobby"))
```

위의 "로비는 어디에 있습니까" 예와 일치하는 질문이 있다면, 그 결과 "3층에 있습니다"의 예상 답변을 볼 수 있습니다.

데이터베이스에 정확히 일치하는 항목이 없는 경우, 관련 답변을 찾기 위해 qTokens를 사용해야 합니다. 이를 위해 "answers_by_q"와 일치시킵니다.토큰" 인덱스를 만들고 답변을 다시 페이지화했습니다. 다음을 온라인 셸에 복사하여 이 작동 방식을 확인하십시오.

```js
q.Paginate(q.Match(q.Index("answers_by_qTokens"), "break"))
```

예제 질문의 qToken "break"에 대한 질문이 있는 경우 결과로 반환되는 모든 답변을 볼 수 있습니다.

### Fauna에 연결 기능

검색을 수행했지만 현재 온라인 셸에서만 실행할 수 있습니다. 이러한 기능을 사용하기 위해서는 몇 가지 구성과 함께 기능 코드에 대한 업데이트가 필요합니다.

기능에서 Fauna에 연결하려면 서버 키를 생성해야 합니다. 데이터베이스의 대시보드에서 왼쪽 사이드바에서 보안을 선택하고 새 키를 만듭니다. 새 키의 이름을 지정하고 드롭다운에 관리자가 아닌 서버가 선택되어 있는지 확인합니다. 마지막으로 키가 생성되면 테스트 경로 전에 다음 코드를 server.js에 추가하여 fa 값을 Fauna가 제공하는 암호로 대체한다.

```js
const q = fauna.query;
const client = new fauna.Client({
 secret: "<secretKey>",
});
```

이 키를 코드에서 직접 저장하는 것이 아니라 Netliify의 환경 변수에 저장하는 것이 바람직하지만, 그것은 본 자습서의 범위를 벗어난다. 환경 변수를 사용하려면 이 Netliify 게시물에서 해당 방법을 설명합니다.

기능에 새 검색 쿼리를 포함하려면 다음 코드를 사후 경로 뒤에 있는 `server.js`에 복사하십시오.

```js
const searchText = async (text) => {
 console.log("Beginning searchText");
 const answer = await client.query(
   q.Paginate(q.Match(q.Index("answers_by_question"), text))
 );
 console.log(`searchText response: ${answer.data}`);
 return answer.data;
};
 
const getTokenResponse = async (text) => {
 console.log("Beginning getTokenResponse");
 let answers = [];
 const questionTokens = text.split(/[ ]+/);
 console.log(`Tokens: ${questionTokens}`);
 for (token of questionTokens) {
   const tokenResponse = await client.query(
     q.Paginate(q.Match(q.Index("answers_by_qTokens"), text))
   );
   answers = [...answers, ...tokenResponse.data];
 }
 console.log(`Token answers: ${answers}`);
 return answers;
};
```

이러한 함수는 이전에 온라인 Fauna 셸에서 실행했던 쿼리와 동일한 기능을 복제하지만, 이제 우리는 우리의 함수에서 그것들을 활용할 수 있다.

### Netliify에 배포

이제 기능은 데이터베이스를 검색하는 것입니다. 이제 로컬 컴퓨터가 아닌 클라우드에 데이터베이스를 설치하는 일만 남았습니다. 이를 위해 GitHub 저장소에서 배포된 Netliify 기능을 사용할 것입니다.

먼저, Github에 대한 새로운 보고서를 추가하고 코드를 입력합니다. 코드가 확인되면 Netliify로 이동하여 Github 프로필을 사용하여 로그인하거나 로그인합니다. Netlifify의 홈 페이지에서 "Git에서 새 사이트"를 선택하여 Github에서 방금 만든 보고서를 사용하여 새 사이트를 배포합니다.

Netlifify에서 사이트를 배포한 적이 없는 경우 이 게시물은 git에서 배포하기 위한 프로세스를 설명합니다.

새 사이트를 생성하는 동안 배포 전에 Netliify가 기능을 빌드하도록 빌드 명령이 npm 실행 빌드로 설정되어 있는지 확인합니다. 게시 디렉터리는 공백으로 둘 수 있습니다. 다른 페이지가 아니라 기능만 배포하기 때문입니다.

Netliify는 이제 보고서를 작성하고 배포하여 사이트 배포에 사용할 고유한 URL을 생성합니다. 이 기본 URL을 사용하여 이전 버전의 기능 테스트 끝점에 액세스하여 제대로 작동하는지 확인할 수 있습니다.

![image](https://lh4.googleusercontent.com/1MEnunnaMI8xeAMc9IEk0vsyu6aZeAozhmu6o8FmTc1aUruqR0vPwOkH57pDS7wZnIPu5MD2R1FfT2msHTwcVgYbdoo8i0X-aouiHMKXfVV7M0gcAJ0El8GuXZgch2kYEypdRu6Z)

마지막으로 Slack 끝점을 새 URL로 업데이트하십시오! 앱으로 이동한 다음 왼쪽 사이드바에서 `슬래시 명령`을 선택하십시오. 연필 아이콘을 클릭하여 슬래시 명령을 편집하고 함수의 새 URL에 붙여넣습니다. 마지막으로, 모든 인증된 Slack 채널에서 새 슬래시 명령을 사용할 수 있습니다!

### 결론

여기에 완전히 서버 없이 기능적인 슬랙슬래시 명령이 있습니다. 우리는 답변을 저장하기 위해 FaunaDB를 사용하고 Netliify 기능을 통해 그것에 연결했습니다. 또한 Express를 사용하면 새로운 질문 추가 기능에 엔드포인트를 추가할 수 있으며, 이 프로젝트를 더욱 확장하기 위해 생각할 수 있는 다른 모든 기능을 사용할 수 있습니다! 바라건대, 지금 여러분은 여러분의 질문에 대답할 누군가를 기다리는 대신, /faq를 사용하여 즉시 답을 얻을 수 있습니다!

매튜 윌리엄스는 기술의 미래가 서버리스라고 믿는 호주 멜버른의 소프트웨어 엔지니어입니다. 그에게서 더 많은 것에 관심이 있다면, 그의 매체 기사나 GitHub 보고서를 확인해 보세요.