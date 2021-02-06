---
layout: post
title: "웹 팩 동적 주석이 포함된 Vue의 유휴 로드 경로"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2021/02/QKxdL.png
tags: 
---


일반적으로 JavaScript에서 라우팅이 작동하는 방식은 렌더링할 구성 요소에 대해 상대 URL 패턴을 지정하는 것입니다. 따라서 `/정보`의 경우 `정보/` 구성 요소를 렌더링해야 합니다. 느린 로딩으로 Vue/Vue Router에서 이 작업을 수행하는 방법을 살펴보고, 가능한 한 깨끗하게 수행해 보겠습니다. 나는 이 작은 팁을 항상 내 일에 사용한다.

GitHub에서 이 게시물에 포함된 모든 내용을 포함하는 보고서를 이용할 수 있습니다.

Vue 경로(URL)는 다음과 같습니다.

```js
import Vue from 'vue'
import VueRouter from 'vue-router'

import Home from '../views/Home.vue'
import About from '../views/About.vue'
import Login from '../views/Login.vue'

Vue.use(VueRouter)

const routes = [
  { path: '/', name: 'Home', component: Home },
  { path: '/about', name: 'About', component: About },
  { path: '/login', name: 'Login', component: Login }
]

const router = new VueRouter({
  routes
})

export default router
```

그러면 //경로에는 ➡홈 / ➡구성요소가, /어바웃 경로에는 ➡로그인 / ➡구성요소가 로드된다.

그러나 이러한 세 가지 구성 요소는 모두 필요에 따라 동적으로 로드되지 않고 함께 번들링되므로 코드 분할이 잘 수행되지 않습니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/s_10C39F714FB1A05A3C9E4B5DAA94209E7CACDA9076CFDC74EFB5C80C1C04BDD1_1611775373470_main.png?resize=1205%2C600&ssl=1)

다음은 동적 가져오기 문과 웹 팩 청크 이름으로 코드를 분할하는 다른 방법입니다.

```js
const routes = [
  {
    path: '/',
    name: 'Home',
    component: () => import(/* webpackChunkName: "Home" */ '../views/Home.vue')
  },
  {
    path: '/about',
    name: 'About',
    component: () => import(/* webpackChunkName: "About" */ '../views/About.vue')
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import(/* webpackChunkName: "Login" */ '../views/Login.vue')
  }
]
```

이것은 아주 괜찮고 약간의 장황하고 반복적인 것 외에는 큰 단점이 없다. 우리는 훌륭한 개발자들이기 때문에, 우리가 ".map"할 `array`를 사용하여 도움을 주는 추상화를 좀 해보자.

```js
const routeOptions = [
  { path: '/', name: 'Home' },
  { path: '/about', name: 'About' },
  { path: '/login', name: 'Login' }
]

const routes = routeOptions.map(route => {
  return {
    ...route,
    component: () => import(`@/views/${route.name}.vue`)
  }
})

const router = new VueRouter({
  routes
})
```

이제 "이름"이라는 경로를 "가져오기" 함수의 매개 변수로 사용하여 "구성 요소" 키의 사용을 줄였습니다.

그러나 청크 이름을 설정하려면 어떻게 해야 합니까?

빌드 단계 없이 JavaScript에서 동적 코멘트를 사용할 수 없는 것으로 알고 있습니다. 그래서 우리는 이 경우에 코드를 적게 써야 한다는 이유로 코멘트(웹 팩 ChunkName)를 희생시키고 있다. 네가 원하는 것은 전적으로 너에게 달려 있다.

농담이야, 고치자.

웹 팩 2.6.0에서 자리 표시자 `[index]`와 `[request]`가 지원되므로 생성된 청크의 이름을 다음과 같이 설정할 수 있습니다.

```js
// ...

const routeOptions = [
  { path: '/', name: 'Home' },
  { path: '/about', name: 'About' },
  { path: '/login', name: 'Login' }
]

const routes = routeOptions.map(route => {
  return {
    ...route,
    component: () => import(/* webpackChunkName: "[request]" */ `../views/${route.name}.vue`)
  }
})

const router = new VueRouter({
  routes
})
```

좋아! 이제 모든 동력과 이름이 붙은 동적 로드가 확보되었어. Vue 2 및 Vue 3과 함께 작동하며 터미널에서 npm run build를 실행하여 확인할 수 있습니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2021/02/lazy-load-request.png?resize=1024%2C602&ssl=1)

Buuuuut, 우리는 게으르게 로드된 경로를 개별 구성 요소가 아닌 명명된 청크로 그룹화함으로써 이것을 한 단계 더 진전시킬 수 있다. 예를 들어 가장 중요한 구성 요소를 함께 그룹화하고 나머지는 다른 "중요하지 않은" 그룹으로 그룹화할 수 있습니다. 앞에서 사용한 `[request] 자리 표시자 대신 웹 팩 청크 이름만 업데이트합니다.

```js
const routes = [
  {
    path: "/",
    name: "Home",
    component: () =>
      import(/* webpackChunkName: "VeryImportantThings" */ "../views/Home.vue")
  },
  {
    path: "/about",
    name: "About",
    component: () =>
      import(/* webpackChunkName: "VeryImportantThings" */ "../views/About.vue")
  },
  {
    path: "/login",
    name: "Login",
    component: () =>
      import(/* webpackChunkName: "NotSoImportant" */ "../views/Login.vue")
  },
  {
    path: "/contact",
    name: "Contact",
    component: () =>
      import(/* webpackChunkName: "NotSoImportant" */ "../views/Contact.vue")
  }
];
```

이제 우리의 네 가지 구성 요소는 두 개의 분리된 덩어리로 그룹화됩니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2021/01/s_10C39F714FB1A05A3C9E4B5DAA94209E7CACDA9076CFDC74EFB5C80C1C04BDD1_1611790249597_5-grouped-chunks.png?resize=1205%2C681&ssl=1)

여기 있어요! Vue에서 경로를 느리게 로드하는 방법과 빌드 시 함께 이름을 지정하고 그룹화하는 방법에 대한 몇 가지 아이디어를 제공합니다.