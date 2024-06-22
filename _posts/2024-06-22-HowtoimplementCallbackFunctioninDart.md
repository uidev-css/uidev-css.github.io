---
title: "Dart에서 콜백 함수 구현하는 방법"
description: ""
coverImage: "/assets/img/2024-06-22-HowtoimplementCallbackFunctioninDart_0.png"
date: 2024-06-22 15:39
ogImage: 
  url: /assets/img/2024-06-22-HowtoimplementCallbackFunctioninDart_0.png
tag: Tech
originalTitle: "How to implement Callback Function in Dart"
link: "https://medium.com/@alfonsinabeltref/how-to-implement-callback-function-in-dart-5f06d059df06"
---


<img src="/assets/img/2024-06-22-HowtoimplementCallbackFunctioninDart_0.png" />

다트를 사용하여 Callback을 사용할 수 있습니다.

Callback은 다른 함수나 메서드에 인수로 전달된 함수입니다. 이를 통해 수신 함수가 콜백 함수를 실행할 수 있습니다.

콜백에 대해 설명하려면 이 예시를 사용할 수 있습니다:

<div class="content-ad"></div>

**단계 1:** success와 인수로 다른 함수를 갖는 request 함수를 생성합니다. success 함수는 인수를 전달 받지 않습니다. success 함수는 request 함수 내에서 실행됩니다.

```js
request(Function success){
  success();
}
```

**단계 2:** 호출되었을 때 "success"를 출력하는 또 다른 함수를 생성합니다.

```js
printMessage(){
  print('Success'); //Success
}
```

<div class="content-ad"></div>

Step 3: 이 코드 조각에서는 우리의 코드를 실행할 Function Main을 생성할 것입니다.

```js
void main() {
   
}
```

만약 Function request를 호출한다면 함수에 인수로 전달해야 합니다. 하지만 이 함수를 이름으로 호출할 때는 괄호( )를 사용할 필요가 없습니다.

```js
void main() {
  request(printMessage); 
}
```

<div class="content-ad"></div>

여기 완성된 코드입니다:

 js
void main() {
  request(printMessage); 
}

request(Function() success){
    success();
}
    
printMessage(){
   print('Success'); //Success 
}


Callback을 사용하는 다른 옵션은 익명 함수를 사용하는 것입니다.

이 스니펫에서는 익명 함수를 인수로 사용하여 함수 요청에 전달합니다. 함수 요청을 호출할 때 함수의 구조를 직접 작성할 수 있습니다.

<div class="content-ad"></div>

```js
void main(){
  request((){
    print('Success'); // Success 
 }); 
}
```

Callback를 사용하는 또 다른 방법을 설명해 드리겠습니다.

단계 1: 인수로 다른 함수를 가지는 request 함수를 변경할 것입니다. 이 함수는 success라는 이름의 함수를 인수로 사용하며 String 타입을 반환하고 String 타입의 인수를 받습니다.

단계 2: success 함수에 인수를 추가하기 위해 request 함수에서 success 함수로 이동하여 인수를 전달할 것입니다.

<div class="content-ad"></div>

```js
  request( String Function(String text) success){
      print(success ('Hello world'));
}
```

Step 3: "request" 함수를 호출할 때 함수의 구조를 인수로 전달하고 받을 인수에 동작을 할당합니다.

코드를 실행하면 "Hello World Success"가 출력됩니다.

```js
void main(){
  request((text){
     return '$text Success'; 
 }); 
} // Hello World Success
```

<div class="content-ad"></div>

여기 완전한 코드입니다:

```js
void main(){
 
 request((text){ 
    return '$text 성공';
   }); 
  } //Hello World 성공
     
 request(String Function(String text) success){
    print(success('Hello World'));
}
```

이 글이 유용했기를 바랍니다. 귀하의 프로그램 코딩에 활용하실 수 있기를 기대합니다.

<img src="/assets/img/2024-06-22-HowtoimplementCallbackFunctioninDart_1.png" />