---
title: "Golang에서 오류 처리를 마스터하는 방법 최고의 실천 방법과 팁"
description: ""
coverImage: "/assets/img/2024-06-27-MasteringErrorHandlinginGolangBestPracticesandTips_0.png"
date: 2024-06-27 18:32
ogImage: 
  url: /assets/img/2024-06-27-MasteringErrorHandlinginGolangBestPracticesandTips_0.png
tag: Tech
originalTitle: "Mastering Error Handling in Golang: Best Practices and Tips"
link: "https://medium.com/itnext/mastering-error-handling-in-golang-best-practices-and-tips-f6dbfbd66cdd"
---


고랭(Golang)에서 에러를 우아하게 처리하는 방법을 배우고, 코드 신뢰성을 높이기 위한 에러 처리에 대한 종합 가이드를 제공합니다.

![이미지](/assets/img/2024-06-27-MasteringErrorHandlinginGolangBestPracticesandTips_0.png)

Go 언어에서는 일반적으로 에러를 표현하는 데 사용되는 인터페이스 타입인 error 타입이 정의됩니다.

```js
type error interface {
    Error() string
}
```

<div class="content-ad"></div>

에러 인터페이스에는 Error() 메서드라는 하나의 메서드만 있습니다. 이 메서드는 에러를 설명하는 문자열을 반환합니다. 이는 Error() 메서드를 구현하는 모든 타입을 에러 타입으로 사용할 수 있다는 것을 의미합니다.

일반적으로 Go 프로그램의 함수들은 에러가 발생했을 때 에러 타입의 값을 반환합니다. 이를 통해 호출자가 에러 정보를 처리하거나 기록할 수 있습니다.

에러를 어떻게 생성할까요?

Go 언어의 디자이너들은 Go 개발자들이 에러 값을 생성하는 두 가지 편리한 방법을 제공했습니다: errors.New와 fmt.Errorf.

<div class="content-ad"></div>

- errors.New() 함수는 오직 오류 메시지 문자열만 포함하므로 오류 값을 생성하는 가장 간단한 방법입니다. 이 방법은 간단한 오류 값을 생성하는 데 적합합니다.
- 반면에 fmt.Errorf() 함수는 fmt.Printf() 함수와 유사한 형식화된 오류 메시지를 구성할 수 있도록 합니다. 이 방법은 더 복잡한 오류 메시지를 구축해야 할 때 유용합니다.

이 두 가지 방법을 사용하여 아래 코드와 같이 error 인터페이스를 만족하는 오류 값을 손쉽게 구성할 수 있습니다:

```js
err := errors.New("hello error")
errWithCtx = fmt.Errorf("index %i is out of bounds", i)
```

이 두 가지 방법은 실제로 동일한 error 인터페이스를 구현하는 동일하지만 알려지지 않은 유형의 인스턴스를 반환합니다.

<div class="content-ad"></div>

이 비공개 타입은 errors.errorString이며, 그 정의는 다음과 같습니다:

```js
// $GOROOT/src/errors/errors.go
type errorString struct {
    s string
}

func (e *errorString) Error() string {
    return e.s
}
```

대부분의 경우에 이 두 가지 메서드를 사용하여 생성된 오류 값이 우리의 요구 사항을 충족할 것입니다.

그러나 이러한 메서드가 오류 값을 생성하는 데 편리하긴 하지만, 오류 처리기에 제공하는 오류 컨텍스트는 문자열 형태로 제공된 정보에 제한된다는 점을 알아야 합니다. 이 정보는 Error 메서드에서 반환하는 정보입니다.

<div class="content-ad"></div>

에러 유형을 사용자 정의하는 방법

일부 상황에서는 에러 핸들러가 적절한 에러 처리 경로를 선택하는 데 도움이 되도록 에러 값에서 더 많은 정보를 추출해야 할 수도 있습니다.

명확히 이 두 가지 메서드만으로는 그러한 경우에 충분하지 않습니다.

이러한 상황에서는 이러한 요구 사항을 충족시키기 위해 에러 유형을 사용자 정의할 수 있습니다. 다음은 예시입니다:

<div class="content-ad"></div>

```go
package main

import "fmt"

// 사용자 정의 오류 유형
type MyError struct {
  ErrorCode    int
  ErrorMessage string
}

// `error` 인터페이스의 `Error` 메서드 구현
func (e MyError) Error() string {
  return fmt.Sprintf("Error %d: %s", e.ErrorCode, e.ErrorMessage)
}

func someFunction() error {
  // 커스텀 오류 값 생성
  err := MyError{
    ErrorCode:    404,
    ErrorMessage: "Not Found",
  }
  return err
}

func main() {
  err := someFunction()
  fmt.Println("에러:", err)
}
```

또 다른 예시를 살펴보겠습니다. 표준 라이브러리의 net 패키지에 정의된 추가 컨텍스트를 가진 오류 유형입니다:

```go
// $GOROOT/src/net/net.go
type OpError struct {
    Op string
    Net string
    Source Addr
    Addr Addr
    Err error
}
```

이러한 유형의 오류 값이 제공하는 추가 컨텍스트 정보(예: Op, Net, Source 등)를 기반으로 에러 처리 경로를 결정할 수 있게끔 에러 핸들러가 결정을 내릴 수 있습니다.


<div class="content-ad"></div>

위의 표준 라이브러리에서 다음 코드 예시를 살펴보겠습니다:

```js
// $GOROOT/src/net/http/server.go
func isCommonNetReadError(err error) bool {
    if err == io.EOF {
        return true
    }
    if neterr, ok := err.(net.Error); ok && neterr.Timeout() {
        return true
    }
    if oe, ok := err.(*net.OpError); ok && oe.Op == "read" {
        return true
    }
    return false
}
```

위 코드에서는 타입 단언(Type Assertion)을 활용하여 err 변수의 동적 타입이 *net.OpError 또는 net.Error인지를 결정합니다.

err의 동적 타입이 *net.OpError인 경우, 타입 단언은 이 동적 타입의 값(oe에 저장)을 반환하고, 코드는 그 후 해당 Op 필드가 read인지 여부를 확인하여 CommonNetRead 유형의 에러인지 결정할 수 있습니다.

<div class="content-ad"></div>

오류 유형의 장점.

# 1. 오류를 처리하는 표준화된 방법을 제공합니다.

서로 다른 개발자, 다른 프로젝트 및 심지어 표준 라이브러리에서 코드를 사용할 때 오류 유형을 오류 인터페이스 변수의 형태로 일관되게 표현한다면 코드 가독성을 향상시키는 것뿐만 아니라 통일된 오류 처리 전략의 수립을 용이하게 합니다.

# 2. 오류는 모두 값입니다.

<div class="content-ad"></div>

우리가 만드는 오류들은 실제로 값들입니다. 이는 오류 인터페이스 유형의 변수에 할당되었을 때에도 ==와 !=와 같은 논리적 비교를 수행할 수 있음을 의미합니다. 정수 값들과 마찬가지로요.

오류를 검사하는 경험은 함수 호출자에게 동일합니다.

오류가 인터페이스 유형이기 때문에, 그의 기본 제로 값은 nil입니다.

그러므로, 일반적으로 함수에 의해 반환된 오류를 nil과 비교하여 함수가 성공했는지 여부 또는 오류가 발생했는지를 확인합니다.

<div class="content-ad"></div>

만약 반환된 오류가 nil이라면, 성공적으로 함수가 실행된 것이고, 그렇지 않다면 오류가 발생했음을 나타냅니다.

이 규칙을 따르면 오류 처리가 일관적이고 직관적으로 이루어집니다.

예를 들어, 다음과 같은 오류 확인 코드를 자주 볼 수 있습니다:

```js
func someFunction() error {
    return errors.New("Errors")
}

func main() {
    err := someFunction()

    if err != nil {
        fmt.Println("실패, 오류:", err)
    } else {
        fmt.Println("성공")
    }
}
```

<div class="content-ad"></div>

# 3. 쉽게 확장할 수 있습니다.

에러들은 에러 인터페이스 변수로 일관되게 표시됩니다. 사용자 정의 에러 타입을 만들어 우리의 에러 컨텍스트를 쉽게 확장할 수 있으며, 이는 Go 표준 라이브러리의 OpError 타입과 비슷합니다.

에러 인터페이스는 에러 값을 제공하는 제공자와 에러 처리를 담당하는 코드 간의 계약 역할을 합니다.

에러 인터페이스를 구현하는 사람은 에러 처리 코드에서 사용할 에러 컨텍스트를 제공하는 것이 책임입니다.

<div class="content-ad"></div>

이는 특정 오류 컨텍스트를 오류 인터페이스 유형과 분리하여 Go의 구성 가능성 및 직교성을 따르는 설계 철학과 일치합니다.

Go 오류 처리의 일반적인 관행.

## 1. 투명한 오류 처리 전략.

간단히 말해서, Go 언어에서의 오류 처리는 함수에 의해 반환된 오류 유형 변수에 의해 전달되는 오류 값 정보를 기반으로 의사 결정을 내리고 후속 코드 실행 경로를 선택하는 과정입니다.

<div class="content-ad"></div>

이 방식을 통해 가장 간단한 오류 전략은 반환된 오류 값이 전달하는 구체적인 컨텍스트 정보를 완전히 무시하는 것입니다.

대신, 오류가 발생할 때마다 하나의 오류 처리 실행 경로로 이어집니다. 예를 들어, 다음 코드를 참고해보세요:

```js
err := doSomething()
if err != nil {
    ... ...
    return err
}
```

이것은 Go 언어에서 가장 흔한 오류 처리 전략으로, 오류 처리 시나리오의 80% 이상을 차지합니다. 이 전략에서는 오류 핸들러가 오류 값의 컨텍스트에 신경을 쓰지 않기 때문에, 오류 생성자 (예: 예시의 doSomething 함수)는 Go 표준 라이브러리에서 제공하는 두 가지 기본 오류 값 생성 방법을 직접 사용할 수 있습니다.

<div class="content-ad"></div>

```js
func doSomething(...) error {
    ... ...
    return errors.New("일부 오류가 발생했습니다")
}
```

이러한 방식으로 생성된 오류 값은 오류 처리기에게 투명한 컨텍스트 정보를 나타냅니다.

오류 처리기가 오류 컨텍스트에 대해 인식할 필요가 없는 상황에서는 투명한 오류 처리 전략이 오류 처리기와 오류 값 생성자 간의 결합을 최소화합니다.

오류 컨텍스트가 오류 처리에 무관한 경우, 이 접근 방식은 오류 처리와 오류 값 생성 사이의 상호 의존성을 줄이는 데 효과적입니다.


<div class="content-ad"></div>

# 2. Sentinel 오류 처리 전략.

오류 핸들러가 투명한 오류 값에만 의존하여 오류 처리 결정을 내릴 수없는 경우, 반환된 오류 값을 검사하려고 시도할 수 있습니다. 아래 코드와 같이 이를 통해 발생하는 안티패턴이 발생할 수 있습니다:

```js
data, err := b.Peek(1)
if err != nil {
    switch err.Error() {
    case "bufio: negative count":
        // ... ...
        return
    case "bufio: buffer full":
        // ... ...
        return
    case "bufio: invalid use of UnreadByte":
        // ... ...
        return
    default:
        // ... ...
        return
    }
}
```

간단히 말해서, 이 안티패턴은 오류 핸들러가 오류 처리 결정을 내릴 때 "투명한 오류 값"이 제공하는 단일 컨텍스트 정보에 완전히 의존하는 경우를 나타냅니다.

<div class="content-ad"></div>

하지만 이 "안티-패턴"은 상당한 암시적 결합을 야기합니다.

즉, 오류 값 생성자에 의한 오류 설명 문자열의 미세한 변경조차도 오류 처리 동작에 변화를 일으킬 수 있습니다.

또한, 문자열 비교를 통해 오류 값들을 조사하는 이 방식은 성능적으로 효율적이지 않습니다.

그렇다면 해결책은 무엇일까요? Go 표준 라이브러리는 내보낸 "특정값(sentinel)" 오류 값의 정의를 통해 오류 핸들러들이 오류 값을 조사하고 오류 처리 결정을 내리는 데 도움을 주는 방식을 사용합니다.

<div class="content-ad"></div>

예를 들어, bufio 패키지에서 정의된 "sentinel errors"는 다음과 같습니다:

```js
// $GOROOT/src/bufio/bufio.go
var (
    ErrInvalidUnreadByte = errors.New("bufio: invalid use of UnreadByte")
    ErrInvalidUnreadRune = errors.New("bufio: invalid use of UnreadRune")
    ErrBufferFull        = errors.New("bufio: buffer full")
    ErrNegativeCount     = errors.New("bufio: negative count")
)
```

다음 코드 조각은 이전에 언급된 sentinel errors를 활용하여 에러 처리 분기에서 결정을 내리는 예시입니다:

```js
data, err := b.Peek(1)
if err != nil {
    switch err {
    case bufio.ErrNegativeCount:
        // ... ...
        return
    case bufio.ErrBufferFull:
        // ... ...
        return
    case bufio.ErrInvalidUnreadByte:
        // ... ...
        return
    default:
        // ... ...
        return
    }
}
```

<div class="content-ad"></div>

그러나 API 개발자의 경우, "sentinel" 오류 값 노출은 이러한 오류 값과 패키지의 공개 함수가 API의 일부가 되는 것을 의미합니다.

한 번 릴리스되면, 개발자는 효과적으로 유지 관리해야 합니다. 또한, "sentinel" 오류 값은 이를 사용하는 오류 처리기에 종속성을 만듭니다.

Go 1.13부터 표준 라이브러리 오류 패키지에서 Is 함수가 도입되어 오류 처리기가 오류 값으로 검사할 수 있습니다.

Is 함수는 다음 코드에서 보여지는 것처럼 오류 변수를 "sentinel" 오류 값과 비교하는 것과 유사합니다:

<div class="content-ad"></div>

```go
if errors.Is(err, ErrOutOfBounds) {
    // 뭔가를 수행
}
```

차이점은 에러 변수가 래핑된 에러를 포함하는 경우, errors.Is 메서드는 래핑된 에러 내에서 에러 체인을 탐색하여 일치하는 에러를 찾을 때까지 모든 래핑된 에러와 비교합니다.

다음은 Is 함수를 사용하는 예시입니다:

```go
var ErrSentinel = errors.New("기본 신호 에러")

func main() {
  err1 := fmt.Errorf("sentinel을 래핑: %w", ErrSentinel)
  err2 := fmt.Errorf("err1을 래핑: %w", err1)
  println(err2 == ErrSentinel) // false
  if errors.Is(err2, ErrSentinel) {
    println("err2는 ErrSentinel입니다.")
    return
  }

  println("err2는 ErrSentinel이 아닙니다.")
}
```

<div class="content-ad"></div>

이 예제에서는 fmt.Errorf 함수와 %w 동사를 사용하여 랩핑된 오류 변수 err1과 err2를 생성합니다.

err1은 "sentinel" 오류 값 ErrSentinel을 랩핑하고, err2는 err1을 랩핑하여 오류 체인을 생성합니다. 오류 체인의 맨 위에는 err2가 있고, 맨 아래에는 ErrSentinel이 있습니다.

그런 다음 값 비교와 errors.Is 함수를 모두 사용하여 err2와 ErrSentinel 간의 관계를 결정합니다.

코드를 실행할 때 다음과 같은 결과를 관찰할 수 있습니다:

<div class="content-ad"></div>

```js
false
err2 is ErrSentinel
```

보시다시피 동등 연산자를 사용하여 err2와 ErrSentinel을 비교하면 서로 다릅니다.

그러나 errors.Is 함수는 err2 안의 오류 체인을 탐색하여 가장 깊은 수준에서 랩핑된 "sentinel" 오류 값 ErrSentinel을 찾습니다.

Go 1.13 이상 버전을 사용하는 경우, 특정 "sentinel" 오류 값으로 랩핑된 예상 오류 값인지 여부를 확인하기 위해 errors.Is 메서드를 사용하는 것이 좋습니다.

<div class="content-ad"></div>

이 접근 방식은 특히 오류 래핑과 체인이 관련된 시나리오에서 더 견고하고 유연한 오류 처리를 제공합니다.

## 3. 오류 값 유형 검사 전략

이전에 살펴본 대로, Go 표준 라이브러리에서 제공하는 오류 값 구성 방법을 사용하여 구성된 "sentinel" 오류 값은 목표 값을 비교하는 기능 이상의 추가 오류 컨텍스트 정보를 제공하지 않습니다.

오류 처리기가 오류 값에서 더 많은 "오류 컨텍스트" 정보를 필요로 하는 경우, 이전에 논의된 전략 및 오류 값 구성 방법이 충분하지 않을 수 있습니다.

<div class="content-ad"></div>

이런 경우에는 추가 “에러 컨텍스트” 정보를 제공하기 위해 사용자 정의 에러 유형을 사용하여 에러 값을 구성해야 합니다.

모든 에러 값이 에러 인터페이스 변수를 통해 균일하게 표시되기 때문에 기저 에러 유형이 전달하는 에러 컨텍스트 정보를 얻으려면 Go의 타입 어설션 또는 타입 스위치 메커니즘을 사용해야 합니다.

에러 값을 검사하는 이 에러 처리 접근 방식은 “에러 값 타입 검사 전략”으로 참조할 수 있습니다.

우리의 이해를 깊이 있게 하기 위해 표준 라이브러리의 예제를 살펴보겠습니다. json 패키지에서 UnmarshalTypeError라는 사용자 정의 에러 유형이 정의되어 있습니다:

<div class="content-ad"></div>

에러 핸들러는 오류 값 유형 검사 전략을 사용하여 더 많은 오류 컨텍스트 정보를 얻을 수 있습니다. 아래는 이 전략을 활용하는 json 패키지의 메서드 구현 예시입니다:

```js
// $GOROOT/src/encoding/json/decode.go
func (d *decodeState) addErrorContext(err error) error {
    if d.errorContext.Struct != nil || len(d.errorContext.FieldStack) > 0 {
        switch err := err.(type) {
        case *UnmarshalTypeError:
            err.Struct = d.errorContext.Struct.Name()
            err.Field = strings.Join(d.errorContext.FieldStack, ".")
            return err
        }
    }
    return err
}
```

이 코드에서는 유형 스위치 문을 사용하여 err 변수가 나타내는 동적 유형 및 값을 결정하고, 일치하는 경우 분기에서 처리하기 위해 오류 컨텍스트 정보가 활용됩니다.

<div class="content-ad"></div>

일반적으로 사용자 정의된 내보낸 오류 유형은 XXXError 형식으로 명명됩니다.

"sentinel" 오류 처리 전략과 유사하게, 오류 값 유형 검사 전략은 사용자 정의 오류 유형을 오류 핸들러에 노출시켜, 해당 유형들이 API의 일부가 되도록 하며, 패키지의 공개 함수와 함께 사용될 수 있도록 합니다.

배포된 후에는 개발자가 이러한 사용자 정의 오류 유형을 유지 관리해야 합니다. 게다가, 이러한 유형을 검사하고 사용하는 오류 핸들러에 대한 의존성을 만듭니다.

Go 1.13부터 표준 라이브러리 errors 패키지는 오류 핸들러가 오류 값들을 검사할 수 있는 As 함수를 제공합니다.

<div class="content-ad"></div>

As 함수는 특정 사용자 정의 오류 유형인지를 결정하기 위해 타입 단언을 사용하는 것과 유사합니다. 아래 코드에서와 같이 err 변수가 특정 사용자 정의 오류 유형인지 확인합니다.

```js
var customErr *CustomError
if errors.As(err, &customErr) {
    // Handle the error as a CustomError
}
```

As 함수의 차이점은 오류 변수에 래핑된 오류가 포함되어 있는 경우, errors.As 함수가 래핑된 오류 내의 오류 체인을 횡단하며, 체인 내의 모든 래핑된 오류와 일치하는 오류 유형을 찾을 때까지 비교한다는 것입니다. 이는 errors.Is의 동작과 유사합니다.

As 함수 사용 예시가 여기 있습니다:

<div class="content-ad"></div>

```js
type MyError struct {
    e string
}

func (e *MyError) Error() string {
    return e.e
}

func main() {
    var err = &MyError{"MyError error demo"}
    err1 := fmt.Errorf("wrap err: %w", err)
    err2 := fmt.Errorf("wrap err1: %w", err1)
    var e *MyError
    if errors.As(err2, &e) {
        println("MyError is on the chain of err2")
        println(e == err)                  
        return                             
    }                                      
    println("MyError is not on the chain of err2")
} 
```

결과.

```js
MyError is on the chain of err2
true
```

마침내 출력된 결과처럼, errors.As 함수가 err2 내의 오류 체인을 성공적으로 탐지하여 가장 깊은 오류를 찾아내고, err2를 *MyError 유형과 일치시킵니다.

<div class="content-ad"></div>

성공적인 일치가 발생하면, errors.As는 일치한 오류 값을 As 함수의 두 번째 매개변수에 저장합니다. 따라서 println(e == err)을 실행하면 true가 반환됩니다.

Go 1.13 이상 버전을 사용 중이라면, 특정 사용자 정의 오류 유형의 인스턴스인지를 확인하기 위해 errors.As 메서드를 사용하는 것이 좋습니다.

이 접근 방식은 사용자 정의 오류를 처리하는 더 유연하고 효율적인 방법을 제공하며, 특히 래핑된 오류와 함께 작업할 때 유용합니다.

# 4. 오류 행동 특성 검사 전략.

<div class="content-ad"></div>

이전에 우리가 논의한 세 가지 전략 중에서는 첫 번째 전략인 "투명한 오류 처리 전략"만이 오류 생성자와 오류 처리자 간의 결합을 효과적으로 줄입니다.

두 번째와 세 번째 전략은 현실 세계의 코딩에서 실용적이지만, 여전히 오류 생성자와 오류 처리자 간의 결합을 어느 정도 도입합니다.

그래서, "투명한 오류 처리 전략"을 제외하고는 오류 처리자와 오류 값 생성자 간의 결합을 줄일 다른 방법이 있을까요?

Go 표준 라이브러리에서는 패키지 내에서 오류 유형을 분류하고 일반적인 오류 동작 특성을 추출하여 이러한 오류 동작 특성을 공개 인터페이스 유형으로 배치하는 다른 오류 처리 접근 방식을 찾을 수 있습니다.

<div class="content-ad"></div>

이 접근법은 "오류 동작 특성 검사 전략"으로 알려져 있습니다.

예를 들어, 표준 라이브러리의 net 패키지는 모든 패키지 내의 일반적인 오류 동작 특성을 추상화하고 net.Error 인터페이스에 넣습니다. 다음 코드에서 확인할 수 있습니다:

```js
// $GOROOT/src/net/net.go
type Error interface {
    error
    Timeout() bool  
    Temporary() bool
}
```

net.Error 인터페이스에는 오류 동작 특성을 확인하는 두 가지 메서드가 포함되어 있습니다: Timeout은 시간 초과 오류인지 확인하고 Temporary는 임시 오류인지 확인합니다.

<div class="content-ad"></div>

에러 핸들러는 특정 에러의 동작 특성을 검사하고 이 정보를 기반으로 후속 에러 처리 분기에 대한 결정을 내리기 위해이 공개 인터페이스에 의존해야합니다.

네트워크 패키지에서 가져온 다른 예제를 통해 에러 동작 특성 검사 전략을 사용하여 에러 처리를 더 향상시켜보겠습니다.

```js
// $GOROOT/src/net/http/server.go
func (srv *Server) Serve(l net.Listener) error {
    ... ...
    for {
        rw, e := l.Accept()
        if e != nil {
            select {
            case <-srv.getDoneChan():
                return ErrServerClosed
            default:
            }
            if ne, ok := e.(net.Error); ok && ne.Temporary() {
                ... ...
                time.Sleep(tempDelay)
                continue
            }
            return e
        }
        ...
    }
    ... ...
}
```

위의 코드 스니펫에서 Accept 메서드는 실제로 net 패키지 내의 사용자 지정 에러 유형 인 *OpError 유형의 에러를 반환합니다. OpError는 일반 에러 특성 인터페이스인 net.Error를 구현합니다. 아래 코드에서 확인할 수 있습니다:

<div class="content-ad"></div>

```js
// $GOROOT/src/net/net.go
type OpError struct {
    ... ...
    // Err is the error that occurred during the operation.
    Err error
}

type temporary interface {
    Temporary() bool
}

func (e *OpError) Temporary() bool {
  if ne, ok := e.Err.(*os.SyscallError); ok {
      t, ok := ne.Err.(temporary)
      return ok && t.Temporary()
  }
  t, ok := e.Err.(temporary)
  return ok && t.Temporary()
}
```

실제로 OpError 인스턴스는 오류 처리기에 의해 검사될 수 있으며 네트.Error 인터페이스에서 제공되는 메서드를 사용하여, 해당 동작이 Temporary나 Timeout과 같은 특성과 일치하는지 여부를 결정할 수 있습니다.

이를 통해 오류 처리기는 네트워크 관련 작업의 맥락에서 해당 오류의 특정 동작에 기반하여 신중한 결정을 내릴 수 있게 됩니다.

요약.

<div class="content-ad"></div>

Go 언어에서 통합된 오류 유형은 오류 인터페이스이며, 오류 값이 할당될 수 있는 빠르게 구성되는 오류 값 구성 함수인 errors.New, fmt.Errorf 등을 포함하여 다양한 함수가 제공됩니다.

또한 통합된 오류 유형을 오류 유형으로 사용하는 장점에 대해 논의했습니다.

이 개념을 깊이 있게 이해하는 것이 중요합니다.

- 투명한 오류 처리 전략: 오류 유형을 통합하고 추가 오류 컨텍스트를 제공하지 않음으로써 오류 처리를 간단하게 만들어 대부분의 경우에 적합합니다.
- 징표 오류 처리 전략: 상징적인 오류 값 세트를 정의함으로써 오류 처리기가 값 비교를 통해 오류 처리 경로를 선택할 수 있게 합니다.
- 오류 값 유형 검사 전략: 오류 유형을 사용자 정의하고 더 많은 오류 컨텍스트를 제공함으로써 추가 오류 컨텍스트가 필요하고 오류 유형을 검사하기 위해 타입 단언 또는 타입 스위치를 사용하는 시나리오에 적합합니다.
- 오류 동작 특성 검사 전략: 공개 인터페이스를 통해 오류 동작 특성을 정의함으로써 오류 처리기가 특정 유형이 아닌 오류 특성을 검사할 수 있게 하며, 오류 동작 특성이 중요한 시나리오에 적합합니다.

<div class="content-ad"></div>

각 전략마다 장점과 사용 사례가 있습니다. 적절한 전략을 선택하는 것은 유지 보수성, 결합도, 코드 복잡성 및 오류 컨텍스트 요구사항과 같은 프로그래밍에서의 특정 요구사항과 고려사항에 따라 달라집니다.

이러한 전략을 이해함으로써 오류를 더 잘 다루고 관리할 수 있으며, 코드 신뢰성과 유지 관리성을 향상시킬 수 있습니다.

이야기가 마음에 드시고 제 지원을 원하신다면 클랩(clap) 눌러주세요.

여러분의 지원은 제게 매우 중요합니다. 감사합니다.