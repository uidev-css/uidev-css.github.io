---
layout: post
title: "API 요청에 대한 축을 사용하여 DRY 유지"
author: "Uidev Css"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/06/mop-bucket.png"
tags: AXIOS
---


HTTP 요청은 백엔드 서버와 통신하는 웹 응용 프로그램의 중요한 부분입니다. 프런트 엔드는 일부 데이터가 필요하므로 네트워크 HTTP 요청(또는 호출되는 경향이 있는 Ajax)을 통해 데이터를 요청하고 서버가 응답을 반환합니다. 요즘 거의 모든 웹사이트들이 어떤 식으로 이것을 한다.

더 큰 부지가 있으면 더 많은 것을 볼 수 있을 것입니다. 더 많은 데이터, 더 많은 API 및 더 특별한 상황. 사이트가 이렇게 성장함에 따라 조직력을 유지하는 것이 중요하다. 한 가지 고전적인 개념은 DARY(Don`t Repeat Yourself의 줄임말)로, 코드를 추상화하여 반복하지 않도록 하는 과정이다. 한 번 쓰고 여러 곳에서 사용하고 각 인스턴스가 아닌 한 곳에서 업데이트할 수 있는 경우가 많기 때문에 이상적입니다.

우리는 또한 우리를 도와줄 도서관을 찾을지도 모른다. 아약스에게는 악시오가 인기 있는 선택이다. 이미 익숙할 수 있으며 개발 중에 독립적인 POST 및 GET 요청과 같은 용도로도 사용할 수 있습니다.

### 설치 및 기본 사항

npm(또는 실)을 사용하여 설치할 수 있습니다.

```terminal
npm install axios
```

Axios를 사용하는 독립적인 POST 요청은 다음과 같습니다.

```js
axios.post('https://axios-app.firebaseio.com/users.json', formData)
  .then(res => console.log(res))
  .catch(error => console.log(error))
```

Native JavaScript는 여러 가지 방법으로 JavaScript를 수행할 수 있습니다. 특히 `fetch()`fetch()이다. 그런데 왜 도서관을 이용하는 걸까요? 글쎄요, 우선, 오류 처리 작업은 꽤 위험합니다. 그것으로 바로 문을 나서면 더 좋은 시간을 보낼 수 있을 거야. 비교를 보시려면, 이런 것들로 추상화의 가치에 대해 이야기하는 기사도 있습니다.

또 다른 이유는? 드라이니스에 대한 더 많은 기회가 주어지므로, 그 점에 대해 알아보도록 하겠습니다.

### 글로벌 구성

axios와 함께 제공되는 기본 개체를 통해 설정된 표준 구성을 사용하여 모든 응용 프로그램 요청을 처리하는 전역 구성(예: `main.js` 파일)을 설정할 수 있다.

이 개체에는 다음이 포함됩니다.

- 기본 URL: 모든 요청의 접두사 역할을 하는 상대 URL이며 각 요청이 URL을 추가할 수 있습니다.
- ➡: 요청에 따라 설정할 수 있는 사용자 지정 헤더
- `timeout:` 요청이 중단되는 지점(일반적으로 밀리초 단위)입니다. 기본값은 `0`으로, 해당되지 않음을 의미합니다.
- `인증서 포함`: 자격 증명을 사용하여 사이트 간 액세스 제어 요청을 할지 여부를 나타냅니다. 기본값은 `false`입니다.
- 응답유형: 서버가 반환할 데이터 유형을 나타내며, `json`(기본값), `arraybuffe`r, `document`, `text`, `stream` 등의 옵션이 있습니다.
- `응답 인코딩`: 응답 디코딩에 사용할 인코딩을 나타냅니다. 기본값은 `utf8`입니다.
- `xsrfCookieName`: XSRF 토큰 값으로 사용할 쿠키의 이름. 기본값은 `XSRF-TOKEN`입니다.
- `xsrfHeaderName`: XSRF 토큰 값을 전달하는 HTTP 헤더의 이름입니다. 기본값은 `X-XSRF-TOKEN`입니다.
- `maxContentLength`: 허용되는 HTTP 응답 콘텐츠의 최대 크기를 바이트 단위로 정의합니다.
- `maxBodyLength`: 허용되는 HTTP 요청 내용의 최대 크기를 바이트 단위로 정의합니다.

대부분의 경우 `베이스`만 사용하게 됩니다.URL, 헤더 및 시간 초과일 수 있습니다. 나머지는 스마트 디폴트가 있기 때문에 필요한 빈도가 적지만, 요청을 수정해야 할 경우에 대비하는 것이 좋습니다.

이것은 직장에서의 건조함이다. 각 요청에 대해 `기본`을 반복할 필요가 없습니다.API의 URL 또는 모든 요청에 필요할 수 있는 중요한 헤더를 반복합니다.

다음은 API에 기반이 있지만 여러 개의 다른 끝점이 있는 예입니다. 먼저 몇 가지 기본값을 설정합니다.

```js
// main.js
import axios from 'axios';
 
axios.defaults.baseURL = 'https://axios-app.firebaseio.com' // the prefix of the URL
axios.defaults.headers.get['Accept'] = 'application/json'   // default header for all get request
axios.defaults.headers.post['Accept'] = 'application/json'  // default header for all POST request
 
Then, in a component, we can use axios more succinctly, not needing to set those headers, but still having an opportunity to customize the final URL endpoint:
 
// form.js component
import axios from 'axios';
 
export default {
  methods : {
    onSubmit () {
      // The URL is now https://axios-app.firebaseio.com/users.json
      axios.post('/users.json', formData)
        .then(res => console.log(res))
        .catch(error => console.log(error))
    }
  }
}
```

참고: 이 예는 Vue에 있지만, 개념은 모든 JavaScript 상황으로 확장됩니다.

### 사용자 정의 인스턴스

사용자 지정 인스턴스를 설정하는 것은 글로벌 구성과 유사하지만 지정된 구성 요소로 범위가 지정됩니다. 아직 DRY 기술이지만 위계질서가 있습니다.

사용자 지정 인스턴스를 새 파일로 설정합니다(auth라고 함).Axios.js)를 사용하여 "해당" 구성 요소로 가져옵니다.

```js
// authAxios.js
import axios from 'axios'
 
const customInstance = axios.create ({
  baseURL : 'https://axios-app.firebaseio.com'
})
customInstance.defaults.headers.post['Accept'] = 'application/json'
 
// Or like this...
const customInstance = axios.create ({
  baseURL : 'https://axios-app.firebaseio.com',
  headers: {'Accept': 'application/json'}
})
```

그런 다음 이 파일을 양식 구성 요소로 가져옵니다.

```js
// form.js component
 
// import from our custom instance
import axios from './authAxios'
 
export default {
  methods : {
    onSubmit () {
      axios.post('/users.json', formData)
      .then(res => console.log(res))
      .catch(error => console.log(error))
    }
  }
}
```

### 인터셉터

인터셉터는 글로벌 구성 또는 사용자 지정 인스턴스가 너무 일반적일 수 있는 경우에 도움이 됩니다. 즉, 개체 내에 헤더를 설정할 경우 영향을 받는 구성 요소 내의 모든 요청의 헤더에 해당 헤더가 적용됩니다. 인터셉터는 모든 객체 속성을 즉시 변경할 수 있습니다. 예를 들어, 우리는 인터셉터 내에서 선택한 조건에 따라 다른 헤더(개체에서 설정한 헤더라도)를 보낼 수 있다.

인터셉터는 `main.js` 파일이나 사용자 지정 인스턴스 파일에 있을 수 있습니다. 요청은 발송된 후 가로채어 응답 처리 방법을 변경할 수 있습니다.

```js
// Add a request interceptor
axios.interceptors.request.use(function (config) {
  // Do something before request is sent, like we're inserting a timeout for only requests with a particular baseURL
  if (config.baseURL === 'https://axios-app.firebaseio.com/users.json') { 
    config.timeout = 4000 
  } else { 
    return config
  }
  console.log (config)
    return config;
  }, function (error) {
  // Do something with request error
  return Promise.reject(error);
});
 
// Add a response interceptor
axios.interceptors.response.use(function (response) {
  // Do something with response data like console.log, change header, or as we did here just added a conditional behaviour, to change the route or pop up an alert box, based on the reponse status  
  if (response.status === 200 || response.status 201) {
    router.replace('homepage') }
  else {
    alert('Unusual behaviour')
  }
  console.log(response)
  return response;
}, function (error) {
  // Do something with response error
  return Promise.reject(error);
});
```

이름에서 알 수 있듯이, 인터셉터는 제공된 조건에 따라 다르게 작동하도록 요청과 응답을 모두 인터셉트합니다. 예를 들어 위의 요청 인터셉터에서는 요청에 특정 `베이스`가 있는 경우에만 조건부 시간 초과를 삽입했습니다.URL. 응답의 경우 상태 코드에 따라 경로를 변경하거나 경고 상자를 갖는 등 수신 내용을 가로채서 수정할 수 있습니다. 우리는 심지어 서로 다른 오류 코드를 바탕으로 여러 조건을 제공할 수 있습니다.

인터셉터는 프로젝트가 커지고 여러 경로와 중첩된 경로가 모두 서로 다른 트리거를 기반으로 서버와 통신하기 시작하면 유용합니다. 제가 위에서 정한 조건 이외에, 당신의 프로젝트에 근거해서, 요격기를 사용할 수 있는 많은 상황들이 있습니다.

흥미롭게도, 우리는 그것이 전혀 영향을 미치지 않도록 하기 위해 요격기를 꺼낼 수 있다. 인터셉터를 변수에 할당하고 적절한 이름의 `꺼내기` 방법을 사용하여 꺼내야 합니다.

```js
const reqInterceptor = axios.interceptors.request.use(function (config) {
  // Do something before request is sent, like we're inserting a timeout for only requests with a particular baseURL
  if (config.baseURL === 'https://axios-app.firebaseio.com/users.json') {
    config.timeout = 4000
  } else {
    return config
  }
  console.log (config)
  return config;
}, function (error) {    
  // Do something with request error
  return Promise.reject(error);
});
 
// Add a response interceptor
const resInterceptor = axios.interceptors.response.use(function (response) {
  // Do something with response data like console.log, change header, or as we did here just added a conditional behaviour, to change the route or pop up an alert box, based on the reponse status  
  if (response.status === 200 || response.status 201) {
    router.replace('homepage')
  } else {
    alert('Unusual behaviour')
  }
  console.log(response)
  return response;
}, function (error) {
  // Do something with response error
  return Promise.reject(error);
});
 
axios.interceptors.request.eject(reqInterceptor);
axios.interceptors.request.eject(resInterceptor);
```

덜 일반적으로 사용되지만, 조건문에 인터셉터를 넣고 가로채거나 일부 이벤트에 따라 제거할 수 있습니다.

이 방법을 통해 axios의 작동 방식과 API 요청을 애플리케이션에서 DARY 상태로 유지하는 데 사용할 수 있는 방법에 대해 잘 알 수 있기를 바랍니다. 일반적인 사용 사례와 구성을 불러와서 표면을 긁었지만, 축에는 요청을 취소하고 사이트 간 요청 위조로부터 보호하는 기능 등 문서상에서 살펴볼 수 있는 다른 많은 장점이 있습니다.