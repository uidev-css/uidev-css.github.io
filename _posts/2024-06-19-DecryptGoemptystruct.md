---
title: "복호화 Go 빈 구조체"
description: ""
coverImage: "/assets/img/2024-06-19-DecryptGoemptystruct_0.png"
date: 2024-06-19 08:25
ogImage: 
  url: /assets/img/2024-06-19-DecryptGoemptystruct_0.png
tag: Tech
originalTitle: "Decrypt Go: empty struct"
link: "https://medium.com/gitconnected/decrypt-go-empty-struct-56640cd668e5"
---


<img src="/assets/img/2024-06-19-DecryptGoemptystruct_0.png" />

# 고(Go)에서 빈 구조체의 수수께끼: 사용법과 최적화를 이해해보세요

일반적으로 구조체는 메모리 블록을 차지합니다. 그러나 특별한 경우가 있습니다: 만약 빈 구조체라면, 크기는 제로입니다. 이것이 어떻게 가능한 것이고, 빈 구조체의 사용은 무엇일까요?

```js
type Test struct {
     A int
     B string
 }
 
 func main() {
     fmt.Println(unsafe.Sizeof(Test{}))
     fmt.Println(unsafe.Sizeof(struct{}{}))
 }
 
 /*
 24
 0
 */
```

<div class="content-ad"></div>

# 빈 구조체의 비밀

## 특별한 변수: zerobase

빈 구조체는 메모리 크기가 없는 구조체입니다. 이 문장은 맞지만, 더 정확하게 말하면 특별한 시작점이 있습니다: zerobase 변수입니다. 이는 8바이트를 차지하는 uintptr 전역 변수입니다. 무수히 많은 구조체 '' 변수가 정의될 때, 컴파일러는 이 zerobase 변수의 주소를 할당합니다. 다시 말해, Go에서 크기가 0인 모든 메모리 할당은 동일한 주소 &zerobase 를 사용합니다.

예제

<div class="content-ad"></div>

```go
package main

import "fmt"

type emptyStruct struct{}

func main() {
    a := struct{}{}
    b := struct{}{}
    c := emptyStruct{}

    fmt.Printf("%p\n", &a)
    fmt.Printf("%p\n", &b)
    fmt.Printf("%p\n", &c)
}

// 0x58e360
// 0x58e360
// 0x58e360
```

빈 구조체 변수의 메모리 주소는 모두 동일합니다. 이는 컴파일 시에 특수한 형식의 메모리 할당을 만나면 컴파일러가 &zerobase를 할당하기 때문입니다. 이 로직은 mallocgc 함수에 있습니다.

```go
//go:linkname mallocgc
func mallocgc(size uintptr, typ *_type, needzero bool) unsafe.Pointer {
    ...
    if size == 0 {
        return unsafe.Pointer(&zerobase)
    }
    ...
```

이것이 빈 구조체의 비밀입니다. 이 특수한 변수로 많은 기능을 수행할 수 있습니다.

<div class="content-ad"></div>

# 빈 구조체와 메모리 정렬

일반적으로 빈 구조체가 더 큰 구조체의 일부인 경우 메모리를 차지하지 않습니다. 그러나 빈 구조체가 마지막 필드인 경우에는 메모리 정렬이 트리거됩니다.

예시

```js
type A struct {
    x int
    y string
    z struct{}
}
type B struct {
    x int
    z struct{}
    y string
}

func main() {
    println(unsafe.Alignof(A{}))
    println(unsafe.Alignof(B{}))
    println(unsafe.Sizeof(A{}))
    println(unsafe.Sizeof(B{}))
}
```

결과:

```plaintext
8
8
32
24
```

<div class="content-ad"></div>

포인터가 필드를 가리키는 경우, 반환된 주소는 구조체 외부에 있을 수 있으며, 구조체가 해제될 때 해당 메모리가 해제되지 않으면 메모리 누수로 이어질 수 있습니다. 따라서 다른 구조체의 마지막 필드로 빈 구조체가 사용될 때는 안전을 위해 추가적인 메모리가 할당됩니다. 빈 구조체가 시작이나 중간에 위치할 경우, 그 주소는 다음 변수와 동일합니다.

```js
type A struct {  
    x int  
    y string  
    z struct{}  
}  
type B struct {  
    x int  
    z struct{}  
    y string  
}  

func main() {  
    a := A{}  
    b := B{}  
    fmt.Printf("%p\n", &a.y)  
    fmt.Printf("%p\n", &a.z)  
    fmt.Printf("%p\n", &b.y)  
    fmt.Printf("%p\n", &b.z)  
}

/**
0x1400012c008
0x1400012c018
0x1400012e008
0x1400012e008
**/
```

# 빈 구조체의 사용 사례

빈 구조체(struct{})의 존재 이유는 메모리를 절약하는 데 있습니다. 내용에 관심이 없지만 구조체가 필요할 때 빈 구조체를 사용하는 것을 고려해보세요. Go의 핵심 복합 구조체인 map, chan 및 slice 모두 빈 구조체를 사용할 수 있습니다.

<div class="content-ad"></div>

## 맵과 구조체

```go
// 맵 생성
m := make(map[int]struct{})
// 값 할당
m[1] = struct{}{}
// 키 존재 여부 확인
_, ok := m[1]
```

## 채널과 구조체

채널과 구조체를 결합하는 클래식한 시나리오에서는 구조체를 신호로 사용하고 내용에 대해 신경 쓰지 않습니다. 이전 글에서 분석한 대로 채널의 필수 데이터 구조는 관리 구조체와 링 버퍼가 함께합니다. 구조체를 요소로 사용하는 경우 링 버퍼는 제로 할당됩니다.

<div class="content-ad"></div>

chan과 struct를 함께 사용하는 유일한 목적은 빈 구조체 자체가 어떤 값을 전달할 수 없기 때문에 신호 전달에 사용된다는 것입니다. 일반적으로 버퍼가 없는 채널과 함께 사용됩니다.

```js
// 신호 채널 생성
waitc := make(chan struct{})
 
// ...
goroutine 1:
    // 신호 전송: 요소 추가
    waitc <- struct{}{}
    // 신호 전송: 종료
    close(waitc)
 
goroutine 2:
    select {
    // 신호 수신 및 해당 작업 수행
    case <-waitc:
    }
```

이 시나리오에서 struct가 꼭 필요할까요? 정말 필요하지는 않으며, 절약되는 메모리는 미미합니다. 핵심은 chan의 요소 값이 중요하지 않다는 것이며, 따라서 struct가 사용됩니다.

# 요약

<div class="content-ad"></div>

- 빈 구조체는 여전히 크기가 0인 구조체입니다.
- 모든 빈 구조체는 동일한 주소를 공유합니다: zerobase 주소입니다.
- 빈 구조체의 메모리를 차지하지 않는 기능을 활용하여 맵을 사용하여 집합 및 채널을 구현하는 등 코드를 최적화할 수 있습니다.

# 참고 자료

- 빈 구조체, Dave Cheney
- Go 최종 릴리스 - struct'' 빈 구조체가 정확히 무엇인가요?