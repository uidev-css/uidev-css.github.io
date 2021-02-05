---
layout: post
title: "기다리지 마세요! API를 조롱합니다."
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/07/mirage-js.png
tags: API,MIRAGE
---


오늘날에는 웹 애플리케이션의 프런트 엔드와 백 엔드가 느슨하게 연결되어 있습니다. 이들은 대개 별도의 팀에 의해 개발되며, 이러한 팀과 기술의 조화를 유지하는 것은 쉽지 않습니다. 이 문제의 일부를 해결하기 위해, 백엔드 기술이 정상적으로 생성하고 개발할 API 서버를 API나 엔드포인트가 이미 존재하는 것처럼 "가짜"할 수 있다.

구성 요소를 시뮬레이션하거나 "조작"하는 데 사용되는 가장 일반적인 용어는 조롱입니다. 모킹 기능을 사용하면 프런트 엔드를 변경하지 않고도 API를 시뮬레이션할 수 있습니다. 조롱을 성취하는 데는 여러 가지 방법이 있는데, 이것이 적어도 제 생각에는 대부분의 사람들이 조롱을 그렇게 무섭게 만드는 이유입니다.

좋은 API 조롱이 어떤 모습이어야 하는지, 조롱당한 API를 새로운 애플리케이션이나 기존 애플리케이션에 구현하는 방법에 대해 알아보자.

이제 보여드릴 구현은 프레임워크에 구애받지 않으므로 프레임워크나 바닐라 JavaScript 애플리케이션과 함께 사용할 수 있습니다.

### Mirage: 조롱하는 프레임워크

우리가 사용할 조롱 접근 방식은 다소 새로운 미라지(Marage)라고 합니다. 저는 많은 조롱의 틀을 시험해 보았고 최근에 이것을 발견했습니다. 그리고 그것은 제게는 판도를 바꾸어 놓았습니다.

Mirage는 최신 인터페이스와 함께 제공되는 프런트 엔드 친화적인 프레임워크로 마케팅됩니다. 클라이언트측 브라우저에서는 `XMLHttpRequest` 및 Fetch 요청을 가로채면 작동합니다.

우리는 조롱당한 API로 간단한 응용 프로그램을 만들고 그 동안 몇 가지 일반적인 문제를 다룰 것입니다.

### Mirage 설정

조롱하는 것을 보여주기 위해 표준 할 수 있는 응용 프로그램 중 하나를 만들어 봅시다. Vue를 제가 선택한 프레임워크로 사용하겠지만, 프레임워크에 구애받지 않는 접근 방식으로 작업하기 때문에 다른 것을 사용할 수 있습니다.

이제 프로젝트에 Mirage를 설치합니다.

```terminal
# Using npm
npm i miragejs -D
 
# Using Yarn
yarn add miragejs -D
```

Mirage 사용을 시작하려면 "서버"를 설정해야 합니다(인조 서버이기 때문에 따옴표로 묶음). 설정에 들어가기 전에 제가 찾은 폴더 구조가 가장 효과적이라고 생각되는 부분을 다루겠습니다.

```
/
├── public
├── src
│   ├── api
│   │   └── mock
│   │       ├── fixtures
│   │       │   └── get-tasks.js
│   │       └── index.js
│   └── main.js
├── package.json
└── package-lock.json
```

mock 디렉토리에서 새 `index.js` 파일을 열고 모의 서버를 정의합니다.

```js
// api/mock/index.js
import { Server } from 'miragejs';
 
export default function ({ environment = 'development' } = {}) {
  return new Server({
    environment,
 
    routes() {
      // We will add our routes here
    },
  });
}
```

기능 서명에 추가하는 환경 주장은 관례에 불과합니다. 우리는 필요에 따라 다른 환경에서 통과할 수 있습니다.

이제 앱 부트스트랩 파일을 여십시오. 우리의 경우, Vue와 함께 작업하고 있기 때문에 이것은 그의 `src/main.js` 파일입니다. createServer 기능을 가져와 개발 환경에서 호출합니다.

```js
// main.js
import createServer from './mock'
 
if (process.env.NODE_ENV === 'development') {
    createServer();
}
```

`process.env`를 사용하고 있습니다.여기서 NODE_ENV` 환경 변수는 일반적인 전역 변수입니다. 이 조건을 통해 Mirage는 운영 환경에서 트리 쉐이크를 사용할 수 있으므로 운영 번들에 영향을 미치지 않습니다.

Mirage를 설정하는 데 필요한 것은 이뿐입니다! 미라지의 DX는 이렇게 쉽게 만들 수 있습니다.

당사의 `서버 만들기` 기능은 이 문서를 간단하게 작성하기 위해 `개발` 환경으로 디폴트하는 것입니다. 대부분의 경우, 개발 모드에서는 한 번, 테스트 파일에서는 여러 번 "서버 만들기"를 호출하므로 이 기능은 기본적으로 "테스트"로 설정됩니다.

### 작동 방식

첫 번째 요청을 하기 전에 Mirage의 작동 방식을 빠르게 살펴보겠습니다.

Mirage는 클라이언트 측 모킹 프레임워크로, Mirage가 Pretender 라이브러리를 사용하여 수행하는 브라우저에서 모든 모킹이 발생합니다. Preender는 기본 `XMLHtpRequest` 및 Fetch 구성을 임시로 교체하고 모든 요청을 인터셉트한 후 Mirage에서 후크하는 작은 서비스로 전달합니다.

DevTools를 열고 Network 탭으로 향하면 Mirage 요청이 표시되지 않습니다. 그 이유는 요청이 Mirage에서 가로채어 처리되기 때문입니다(백엔드의 Pretender를 통해). Mirage는 모든 요청을 기록하므로 잠시 후에 가져올 수 있습니다.

### 요청합시다!

/api/tasks 끝점에 대한 요청을 만들어 작업관리 앱에 표시할 작업 목록을 반환합니다. 축을 사용하여 데이터를 가져오는 중입니다. 그건 그냥 제 취향이에요. 또한 Mirage는 네이티브 `XMLHtpRequest`, Fetch 및 기타 라이브러리와 함께 작동합니다.

```js
// components/tasks.vue
export default {
  async created() {
    try {
      const { data } = await axios.get('/api/tasks'); // Fetch the data
      this.tasks = data.tasks;
    } catch(e) {
      console.error(e);
    }
  }
};
```

JavaScript 콘솔 열기 - Mirage에서 다음 오류가 발생할 수 있습니다.

```
Mirage: Your app tried to GET '/api/tasks', but there was no route defined to handle this request.
```

즉, Mirage가 실행 중이지만 라우터가 아직 조롱당하지 않았습니다. 그 경로를 추가해서 이 문제를 해결합시다.

### 모킹 요청

mock/index.js 파일 안에는 "routes() 후크가 있습니다. 경로 처리기를 사용하면 Mirage 서버에서 처리해야 할 URL을 정의할 수 있습니다.

라우터 핸들러를 정의하려면 "routs()" 함수 내부에 추가해야 합니다.

```js
// mock/index.js
export default function ({ environment = 'development' } = {}) {
    // ...
    routes() {
      this.get('/api/tasks', () => ({
        tasks: [
          { id: 1, text: "Feed the cat" },
          { id: 2, text: "Wash the dishes" },
          //...
        ],
      }))
    },
  });
}
```

경로() 후크는 경로 처리기를 정의하는 방법입니다. this.get() 방법을 사용하면 GET 요청을 조롱할 수 있습니다. 모든 요청 함수의 첫 번째 인수는 우리가 취급하는 URL이고, 두 번째 인수는 일부 데이터로 응답하는 함수입니다.

Mirage는 모든 HTTP 요청 유형을 허용하며 각 유형의 시그니처는 동일합니다.

```js
this.get('/tasks', (schema, request) => { ... });
this.post('/tasks', (schema, request) => { ... });
this.patch('/tasks/:id', (schema, request) => { ... });
this.put('/tasks/:id', (schema, request) => { ... });
this.del('/tasks/:id', (schema, request) => { ... });
this.options('/tasks', (schema, request) => { ... });
```

잠시 후 콜백 기능의 스키마와 요청 파라미터에 대해 논의하겠습니다.

이를 통해 경로를 성공적으로 조롱했으며 콘솔 내에서 Mirage의 성공적인 응답을 확인할 수 있습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/07/image-32.png?resize=1208%2C296&ssl=1)

### 동적 데이터 사용

`GET` 응답의 데이터에 하드코딩된 값이 있으므로 앱에서 새로운 작업관리 기능을 추가하려고 할 수 없습니다. 이에 대한 Mirage의 솔루션은 데이터베이스 역할을 하는 경량 데이터 계층을 제공하는 것입니다. 지금까지 우리가 가진 것을 고칩시다.

경로() 후크처럼 Mirage는 "시드() 후크를 정의합니다. 서버에 대한 초기 데이터를 만들 수 있습니다. GET 데이터를 Mirage 데이터베이스에 푸시할 시드() 후크로 이동할 것입니다.

```js
seeds(server) {
  server.db.loadData({
    tasks: [
      { id: 1, text: "Feed the cat" },
      { id: 2, text: "Wash the dishes" },
    ],
  })
},
```

나는 우리의 정적 데이터를 GET 방식에서 "시드() 후크"로 옮겼고, 여기서 데이터는 가짜 데이터베이스에 로드된다. 이제 우리는 그 데이터베이스에서 데이터를 반환하기 위해 GET 방법을 재투자해야 한다. 이것은 실제로 매우 간단합니다. 즉, 모든 `route() 방법의 콜백 함수의 첫 번째 인수는 스키마입니다.

```js
this.get('/api/tasks', (schema) => {
  return schema.db.tasks;
})
```

이제 POST 요청을 통해 새로운 작업 항목을 앱에 추가할 수 있습니다.

```js
async addTask() {
  const { data } = await axios.post('/api/tasks', { data: this.newTask });
  this.tasks.push(data);
  this.newTask = {};
},
```

다음 `POST/api/tasks` 경로 처리기를 생성하여 Mirage에서 이 경로를 조롱합니다.

```js
this.post('/tasks', (schema, request) => {})
```

콜백 기능의 두 번째 매개 변수를 사용하면 전송된 요청을 볼 수 있습니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/07/image-33.png?resize=800%2C534&ssl=1)

request Body 속성 안에는 우리가 보낸 데이터가 들어 있습니다. 즉, 이제 새로운 작업을 생성할 수 있습니다.

```js
this.post('/api/tasks', (schema, request) => {
  // Take the send data from axios.
  const task = JSON.parse(request.requestBody).data
 
  return schema.db.tasks.insert(task)
})
```

작업의 `id`는 기본적으로 Mirage의 데이터베이스에 의해 설정됩니다. 따라서 실제 서버처럼 ID를 추적하여 요청과 함께 보낼 필요가 없습니다.

### 동적 경로? 물론이죠!

마지막으로 다룰 것은 동적 경로입니다. URL에서 동적 세그먼트를 사용할 수 있으므로 앱에서 단일 작업관리 항목을 삭제하거나 업데이트할 때 유용합니다.

우리의 삭제 요청, `/api/tasks/2` `/api/tasks/1` 등등 가야 한다. Mirage는 다음과 같이 URL에서 동적 세그먼트를 정의할 수 있는 방법을 제공합니다.

```js
this.delete('/api/tasks/:id', (schema, request) => {
  // Return the ID from URL.
  const id = request.params.id;
 
  return schema.db.tasks.remove(id);
})
```

URL에서 콜론(`:`)을 사용하면 URL에서 동적 세그먼트를 정의할 수 있습니다. 콜론 다음에는 특정 작업 항목의 ID에 매핑되는 세그먼트의 이름을 지정합니다. 우리는 `request.params` 객체를 통해 세그먼트의 값에 액세스할 수 있습니다. 여기서 속성 이름은 세그먼트 이름인 `request.params.id`에 해당합니다. 그런 다음 이 스키마를 사용하여 동일한 ID의 항목을 Mirage 데이터베이스에서 제거합니다.

지금까지의 모든 경로에는 `api/mc`라는 접두사가 붙어 있습니다. 이것을 반복해서 쓰는 것은 번거로울 수 있고 여러분은 그것을 더 쉽게 하고 싶을 수도 있다. Mirage는 도움이 될 수 있는 `namespace` 속성을 제공합니다. 경로 후크 내에서 namespace 속성을 정의할 수 있으므로 매번 작성할 필요가 없습니다.

```js
routes() {
 // Prefix for all routes.
 this.namespace = '/api';
 
 this.get('/tasks', () => { ... })
 this.delete('/tasks/:id', () => { ... })
 this.post('/tasks', () => { ... })
}
```

### 예, 기존 앱에 통합해 보겠습니다.

지금까지 살펴본 모든 것이 Mirage를 새 앱으로 통합했습니다. 기존 애플리케이션에 Mirage를 추가하는 것은 어떻습니까? Mirage에서는 전체 API를 조롱할 필요가 없도록 다뤘습니다.

먼저 알아야 할 점은 기존 애플리케이션에 Mirage를 추가하면 사이트에서 Mirage에서 처리되지 않는 요청을 할 경우 오류가 발생한다는 것입니다. 이를 방지하기 위해 Mirage에서 처리되지 않은 모든 요청을 통과하도록 지시할 수 있습니다.

```js
routes() {
  this.get('/tasks', () => { ... })
  
  // Pass through all unhandled requests.
  this.passthrough()
}
```

이제 우리는 기존 API 위에 Mirage를 사용하여 API의 누락된 부분만 처리할 수 있습니다.

Mirage는 요청을 캡처하는 기본 URL도 변경할 수 있습니다. 일반적으로 서버는 localhost:3000에서 사는 것이 아니라 사용자 지정 도메인에서 사는 것이기 때문에 유용합니다.

```js
routes() {
 // Set the base route.
 this.urlPrefix = 'https://devenv.ourapp.example';
 
 this.get('/tasks', () => { ... })
}
```

이제 모든 요청이 실제 API 서버를 가리키지만 Mirage는 새 앱으로 설정할 때와 마찬가지로 이러한 서버를 가로채게 됩니다. 즉, Mirage에서 실제 API로의 전환이 매우 원활하다는 것을 의미합니다. 모의 서버에서 경로를 삭제하고 진행하기에 좋습니다.

### 마무리하기

5년 동안, 저는 많은 조롱의 틀을 사용했지만, 저는 그 어떤 해결책도 진정으로 좋아한 적이 없습니다. 그 때가 바로 얼마 전이었는데, 저희 팀이 조롱거리가 되는 솔루션을 필요로 하는 상황에 직면했고 저는 Mirage에 대해 알게 되었습니다.

일반적으로 사용되는 JSON-Server와 같은 다른 솔루션은 프런트 엔드를 따라 실행해야 하는 외부 프로세스입니다. 게다가, 그것들은 종종 유틸리티 기능이 있는 익스프레스 서버에 지나지 않는다. 그 결과, 우리와 같은 프런트 엔드 개발자들은 미들웨어, NodeJS, 그리고 서버의 작동 방식 등에 대해 알아야 합니다. 우리들 중 많은 사람들이 다루기를 원하지 않을 것입니다. Mockoon과 같은 다른 시도들은 매우 필요한 기능들이 부족한 반면 복잡한 인터페이스를 가지고 있다. 인기 있는 SinonJS와 같이 테스트에만 사용되는 또 다른 프레임워크 그룹이 있습니다. 불행히도, 이러한 틀들은 규칙적인 행동을 조롱하는 데 사용될 수 없습니다.

저희 팀은 마치 실제 백엔드로 작업하는 것처럼 프런트 엔드 코드를 작성할 수 있는 기능 서버를 만들었습니다. 우리는 실행에 필요한 외부 프로세스나 서버 없이 프런트 엔드 코드베이스를 작성해서 실행했습니다. 이것이 내가 Mirage를 사랑하는 이유이다. 설치는 정말 간단하지만, 그것에 던져진 모든 것을 처리할 수 있을 만큼 강력합니다. 새 앱이든 기존 앱이든 상관없이 정적 어레이를 완전한 백엔드 앱으로 반환하는 기본 애플리케이션에 사용할 수 있습니다.

여기서 다룬 구현 외에도 Mirage에는 훨씬 더 많은 것이 있습니다. GitHub에서 다룬 내용의 작업 예를 확인할 수 있습니다. (재미 있는 사실: Mirage는 GraphQL과도 호환됩니다!) Mirage에는 여러 가지 단계별 튜토리얼이 포함된 잘 작성된 문서가 있습니다. 반드시 확인하십시오.