---
title: "C Net에서의 멀티스레딩 소개 및 모범 사례"
description: ""
coverImage: "/assets/img/2024-06-19-MultithreadinginCNetIntroductionandBestpractices_0.png"
date: 2024-06-19 14:35
ogImage: 
  url: /assets/img/2024-06-19-MultithreadinginCNetIntroductionandBestpractices_0.png
tag: Tech
originalTitle: "Multithreading in C# .Net Introduction and Best practices"
link: "https://medium.com/@codebob75/multithreading-in-c-net-introduction-and-best-practices-fe32257e2956"
---


```markdown
![image](/assets/img/2024-06-19-MultithreadinginCNetIntroductionandBestpractices_0.png)

# Agenda

## I/ Introduction

- Threads in a Computer CPU
- Scheduler & Time slices
- Processes & Threads
- Concurrency and parallelism
- Asynchrony vs Multithreading
- Benefits of using multithreading in C#
```

<div class="content-ad"></div>

## II 스레드 C#에서

스레드 라이프사이클
스레드 생성, 시작 및 일시 중지
Join
Abort
Interrupt
스레드 취소: 스레드를 중지하는 더 나은 방법

## III/ 스레드 관련 문제

데드락과 레이스 컨디션
Join 및 Locks를 사용하여 레이스 컨디션 및 데드락 방지
AutoResetEvent
스레드 성능 문제

<div class="content-ad"></div>

## IV/ 스레드 풀

## V/ 동기화 메커니즘

Mutex
Semaphore
Monitor (lock)

## VI/ 스레드 관리하기

<div class="content-ad"></div>

포그라운드 대비 백그라운드 스레드
스레드 컨텍스트
스레드에 데이터 전달
스레드 우선순위
스레드 로컬 저장소
스레드 디버깅

## VII/ .Net에서 스레드를 다루는 추천 방법

# I/ 소개

## 컴퓨터 CPU에서의 스레드

<div class="content-ad"></div>

쓰레드(thread)와 병렬성(parallelism)에 대해 이해하기 전에, 기본적인 하드웨어 동작 원리를 잘 파악하는 것이 중요합니다.

CPU(중앙 처리 장치)는 컴퓨터의 뇌로, 애플리케이션을 실행하는 데 필요한 모든 명령을 실행하는 역할을 합니다.

현대 컴퓨터에는 종종 여러 개의 코어(core)가 있으며, 각각이 논리 프로세서(logical processor)로 분할될 수 있습니다.

<div class="content-ad"></div>

각 프로세서는 두 개의 논리 프로세서로 나눠집니다.

각 논리 코어는 이제 병렬로 여러 스레드를 처리할 수 있습니다! 예를 들어, 4코어 프로세서는 하이퍼스레딩 기술 덕분에 8개의 스레드를 동시에 처리할 수 있습니다.

<div class="content-ad"></div>

컴퓨터의 코어(core) 및 논리 코어(logical core) 수를 확인하려면 작업 관리자로 이동하여 '성능' 탭을 선택하세요.

![Task Manager Performance](/assets/img/2024-06-19-MultithreadinginCNetIntroductionandBestpractices_4.png)

또는 애플리케이션에서 다음 코드를 실행해도 됩니다:

```js
Console.WriteLine("코어 수: " + Environment.ProcessorCount);
```

<div class="content-ad"></div>

## 스케줄러 및 시간 조각

**스케줄러**

실제로 각 코어는 많은 명령을 동시에 실행합니다.

다른 작업을 블록하는 것을 방지하기 위해 각 작업에 일정한 시간을 할당합니다.

<div class="content-ad"></div>

모든 작업을 아주 빠른 속도로 전환하면, 모든 작업이 동시에 실행되는 것 같아요!

윈도우즈에서는 스케줄러라는 특별한 프로그램이 프로세서가 명령을 실행할 순서와 시간 프레임(프로세서 시간 조각이라고도 함)을 결정해요.

이 프로그램은 프로세서가 명령을 실행할 순서와 시간 프레임을 결정하는 역할을 해요.

![이미지](/assets/img/2024-06-19-MultithreadinginCNetIntroductionandBestpractices_5.png)

<div class="content-ad"></div>

프로세서 시간 조각

이 시간 프레임은 프로세서 시간 조각으로도 알려져 있어요.

이러한 시간 조각은 프로세서가 특정 명령을 처리하는 기간입니다. 너무 긴 명령이 전체 컴퓨터를 막는 것을 방지하기 위해 각 명령에는 특정 시간 조각이 부여됩니다.

![이미지](/assets/img/2024-06-19-MultithreadinginCNetIntroductionandBestpractices_6.png)

<div class="content-ad"></div>

## 프로세스 및 스레드

이제 프로세스와 스레드의 차이를 살펴보겠습니다.

![Image](/assets/img/2024-06-19-MultithreadinginCNetIntroductionandBestpractices_7.png)

프로세스는 실행 중인 프로그램입니다. 운영 체제는 실행 중인 응용 프로그램을 분리하기 위해 프로세스를 사용합니다. 스레드는 운영 체제가 프로세서 시간을 할당하는 기본 단위입니다.

<div class="content-ad"></div>

프로세스

- 기본적으로 프로그램을 실행하는 인스턴스
- 고유한 메모리 공간과 자원을 보유합니다.
- 다른 프로세스와 독립적으로 작동합니다.
- 스레드를 하나 이상 포함할 수 있습니다.

전형적인 시스템에는 수백 개의 프로세스가 동시에 실행될 수 있습니다.

각 프로세스는 스레드를 포함하는 컨테이너 역할을 합니다.

<div class="content-ad"></div>

프로세스가 시작되면 각각이 자체 메모리 및 리소스를 할당받아 스레드 사이에서 공유됩니다.

스레드

- 프로세스 내에서의 실행 단위
- 각각 자체 스택을 가짐
- 동일한 프로세스 내 다른 스레드와 힙 메모리를 공유함

<div class="content-ad"></div>

다음은 Markdown 형식으로 된 표입니다.

![이미지1](/assets/img/2024-06-19-MultithreadinginCNetIntroductionandBestpractices_9.png)

멀티 스레딩 프로세스에서 스레드는 힙 메모리를 공유합니다.

![이미지2](/assets/img/2024-06-19-MultithreadinginCNetIntroductionandBestpractices_10.png)

멀티스레딩은 프로그램이 여러 스레드를 실행할 수 있는 능력으로, 시스템 리소스를 효율적으로 활용할 수 있게 합니다.

<div class="content-ad"></div>

아래는 Markdown 형식으로 수정한 내용입니다.

![image](/assets/img/2024-06-19-MultithreadinginCNetIntroductionandBestpractices_11.png)

## Concurrency and parallelism

![image](/assets/img/2024-06-19-MultithreadinginCNetIntroductionandBestpractices_12.png)

Concurrency

<div class="content-ad"></div>

- 두 개 이상의 작업이 겹치는 시간 동안 시작, 실행 및 완료될 수 있는 경우
- 단일 쓰레드가 빠르게 전환하여 여러 작업을 처리하도록 하여 동시 실행의 환상을 주는 것

병렬 처리

- 둘 이상의 작업이 서로 다른 쓰레드에서 동시에 실행되는 경우
- 두 개의 쓰레드가 실행하는 두 가지 작업

![이미지](/assets/img/2024-06-19-MultithreadinginCNetIntroductionandBestpractices_13.png)

<div class="content-ad"></div>

## 비동기 처리 vs 멀티스레딩

동기

- 각 작업은 다음 작업이 시작되기 전에 완료되어야 합니다.
- 한 작업이 너무 오래 걸리는 경우 비효율성을 야기할 수 있으며, 작업이 완료될 때까지 앱이 멈추거나 블로킹될 수 있습니다.

작업은 순차적으로 실행됩니다.

<div class="content-ad"></div>

비동기 (단일 스레드)

- 한 스레드가 여러 작업을 처리하면서 그 사이를 전환함
- 흐름을 차단하지 않고 작업이 동시에 진행되도록 함

두 작업이 같은 스레드 내에서 시작되고 동시에 진행됨

비동기 (다중 스레드)

<div class="content-ad"></div>

- 여러 스레드가 동시에 서로 다른 작업을 처리합니다
- 두 작업을 빠르고 효율적으로 완료합니다

두 스레드를 사용하면 두 작업이 서로 독립적으로 동시에 진행됩니다

![이미지](/assets/img/2024-06-19-MultithreadinginCNetIntroductionandBestpractices_14.png)

## C#에서 멀티스레딩을 사용하는 장점

<div class="content-ad"></div>

성능

첫 번째 분명한 장점은 하드웨어 성능을 활용하여 작업을 병렬로 실행하여 속도를 높일 수 있다는 것입니다.

응답성

여러 프로세스가 동시에 실행되는 경우 데이터를 검색하기 위해 사용자가 클릭하더라도, 하나의 스레드가 데이터를 가져오는 동안 앱 전체가 반응성을 유지합니다.

<div class="content-ad"></div>

확장성

더 많은 요청을 처리하기 위해서는 각 작업에 대해 다른 스레드를 사용하여 동시에 처리하는 것이 가능합니다.

## II. C#에서의 스레드

이미 소개된 것처럼, 스레드는 CPU의 가장 낮은 작업 단위입니다.

<div class="content-ad"></div>

C#은 스레드를 다루기 쉽게 만드는 라이브러리를 제공합니다: Thread 클래스입니다. 이 클래스를 사용하면 전체 스레드 라이프사이클을 관리할 수 있어요!

![Thread Lifecycle](/assets/img/2024-06-19-MultithreadinginCNetIntroductionandBestpractices_15.png)

## Thread Lifecycle

일반적인 스레드는 다음과 같은 단계를 거칩니다.

<div class="content-ad"></div>

- 스레드가 생성되었습니다
- 스레드가 시작되었습니다
- 스레드가 메소드를 완료했습니다
- 스레드가 자동으로 종료되었습니다

## 스레드 생성, 시작 및 일시 중지

스레드를 생성하는 방법은 여러 가지가 있습니다

```js
// 새로운 스레드 생성
var thread = new Thread(new ThreadStart(Operation));

// 또는 더 간결한 방법으로
var thread = new Thread(Operation);

// 또는 람다를 사용하여
var thread = new Thread(() => { Operation(); });
```

<div class="content-ad"></div>

위에서 볼 수 있듯이 스레드는 인스턴스화되려면 메서드 대리자를 가져야 합니다.

```js
// 스레드는 작업(메서드 대리자)이 필요합니다
var thread = new Thread(Operation);

// 완료해야 할 작업이 스레드 내로 전달됩니다
private void Operation()
{
    Console.WriteLine("스레드에서 안녕하세요");
}
```

스레드가 생성되었더라도 명시적으로 시작해야 합니다.

```js
// 스레드 시작
thread.Start();
```

<div class="content-ad"></div>

한 번 시작되면 작업을 자동으로 수행하고 완료될 때까지 계속됩니다.

한 번 종료된 스레드는 다시 시작할 수 없습니다.

그러나 .Sleep 메서드를 사용하여 스레드를 일시 중지할 수 있습니다.

시간이 경과한 후 자동으로 다시 시작됩니다.

<div class="content-ad"></div>

```js
// 쓰레드를 일시 중지하고 중단하는 방법
Thread.Sleep(2000); // 밀리초나 TimeSpan을 사용합니다.
sleepingThread.Interrupt();
```

쓰레드를 중지하는 방법에는 장단점이 있는 여러 가지 방법이 있습니다:

- Join
- Abort
- Interrupt

## Join

<div class="content-ad"></div>

Thread.Join은 스레드를 "정상적으로" 중지시키므로 코드는 스레드가 중지될 때까지 기다립니다.

```js
Thread thread = new Thread(Work);
thread.Start();

// 스레드가 "정상적으로" 중지될 때까지 대기
thread.Join();

Console.WriteLine("스레드가 종료되었습니다.");
```

또한, 스레드가 완료될 때까지 무기한 대기하는 것을 피하기 위해 타임아웃을 전달하는 것도 가능합니다.

```js
Thread thread = new Thread(Work);
thread.Start();

// 스레드가 중지되거나 타임아웃 시간이 경과할 때까지 대기
bool didComplete = thread.Join(1000);
```

<div class="content-ad"></div>

주로 이 코드는 주 스레드가 1초 동안 대기하도록 하고 해당 스레드의 실행이 완료됐는지 확인합니다.

Join의 블로킹 특성

Thread.Join은 블로킹 호출이므로, 해당 스레드가 실행을 완료하거나 선택적으로 지정된 시간 제한이 경과할 때까지 반환하지 않습니다.

즉, 주 스레드가 해당 스레드의 완료를 기다려야 한다는 것을 의미합니다.

<div class="content-ad"></div>

예를 들어, Join을 현재 스레드에서 호출해서는 안 돼요.

현재 스레드에서 현재 스레드에 Thread.Join을 호출하면 현재 스레드가 자기 자신을 기다리기 때문에 애플리케이션이 응답하지 않게 될 거에요.

```js
Thread thread = Thread.CurrentThread;

// 이렇게 하면 데드락이 발생하여 애플리케이션이 응답하지 않게 됩니다
// thread.Join(); // 이렇게 하지 마세요

Console.WriteLine("현재 스레드에 Join을 호출하는 것을 피하세요.");
```

멀티스레드 환경에서 Join

<div class="content-ad"></div>

조인은 블로킹 호출이기 때문에 멀티스레딩(그리고 병렬) 목표에 부합하지 않아요!

하지만 언제는 유용할 수도 있어요. 다른 스레드가 객체를 조작하는 하나의 스레드를 기다려야 하는 경쟁 조건에서 유용할 수 있답니다 (나중에 더 설명할게요).

<img src="/assets/img/2024-06-19-MultithreadinginCNetIntroductionandBestpractices_16.png" />

## 중단

<div class="content-ad"></div>

쓰레드를 강제로 미리 종료하도록 하는 ThreadAbortException이 발생합니다.

그러나 스트림 연결을 닫지 않은 채로 갑작스럽게 스레드를 중지시킴으로써 메모리 누수나 리소스 누수가 발생할 수 있습니다.

게다가, 스레드가 중단될 때 스레드나 조작된 객체들의 상태가 불분명합니다.

이는 교착 상태, 리소스 누수 또는 메모리 누수로 이어질 수 있습니다!

<div class="content-ad"></div>

마크다운 형식의 표 태그를 바꿔보세요.

<div class="content-ad"></div>

인터럽트된 스레드가 Thread.Join 또는 Thread.Sleep를 호출했을 때에만 ThreadInterruptedException을 throw합니다.

이는 동기화된 코드 영역에 대한 액세스를 기다리거나 Thread.Sleep 중에 스레드를 차단하는 작업을 중지하는 데 사용할 수 있습니다.

```js
Thread thread = new Thread(Work);
thread.Start();

// 스레드가 시작할 시간을 줍니다
Thread.Sleep(500);

// 스레드를 인터럽트하여 ThreadInterruptedException을 발생시킵니다
thread.Interrupt();

// 스레드가 인터럽션을 처리하고 완료할 때까지 기다립니다
thread.Join();
```

Thread.Interrupt는 스레드가 차단된 상태에서만 스레드를 인터럽트합니다. Thread.Sleep와 같이 현재 블로킹 호출 중인 코드가 아닌 경우엔 제3자 코드를 임의로 중단하지 않습니다.

<div class="content-ad"></div>


Thread.Interrupt은 아직 지원되지만 CancellationToken을 사용한 협력적 취소가 더 예측 가능하고 관리하기 쉬운 스레드 중단 방법으로 자주 선호됩니다.

## 스레드 취소: 스레드를 중지하는 더 좋은 방법

그러나 .Net 5+부터 스레드 중단과 관련된 문제를 따라 Thread.Abort 또는 Thread.Interrupt 대신 스레드 취소를 사용하는 것을 Microsoft가 권장합니다.

이 접근 방식은 스레드를 갑작스럽게 종료하는 것과 관련된 예측할 수 없는 상황 및 잠재적인 리소스 누수를 방지합니다.

<div class="content-ad"></div>

```cs
// 취소 토큰을 인스턴스화합니다
CancellationTokenSource cts = new CancellationTokenSource();

// 스레드에 토큰 전달
Thread thread = new Thread(() => Work(cts.Token));
Thread.Start();

// 주 스레드에서 다른 작업 시뮬레이션
Thread.Sleep(1000);

// 1초 후 스레드 작업 취소
cts.Cancel();

// 스레드가 정상적으로 종료될 때까지 대기
thread.Join();
```

CancellationTokenSource: 이 클래스는 취소를 신호하는 메커니즘을 제공합니다. 스레드로 전달할 수 있는 CancellationToken을 생성합니다.

Work 메서드에 취소 토큰 전달

```cs
static void Work(CancellationToken cancellationToken)
{
    try
    {
        while (true)
        {
            // 취소 요청 확인
            cancellationToken.ThrowIfCancellationRequested();

            // 작업 시뮬레이션
            Thread.Sleep(500);
            Console.WriteLine("작업 중...");
        }
    }
    catch (OperationCanceledException)
    {
        Console.WriteLine("취소 요청 받음, 작업 종료.");
    }
    finally
    {
        Console.WriteLine("여기 정리 코드가 있습니다.");
    }
}
```

<div class="content-ad"></div>

ThrowIfCancellationRequested: 이 메서드는 취소가 요청된 경우 OperationCanceledException을 throw하여 스레드가 안전하게 종료될 수 있도록합니다.

CancellationToken을 사용하는 이점

- 안전한 종료: 스레드는 종료하기 전에 현재 작업을 마무리하고 자원을 적절히 정리할 수 있습니다.
- 예측 가능성: 스레드는 제어된 방식으로 종료되어 갑작스러운 종료의 위험을 피합니다.
- 협력적인 취소: 스레드는 주기적으로 토큰을 확인하여 중지해야 하는지 여부를 확인하여 스레드 관리에 협력적인 접근이 가능합니다.

현대 .NET 애플리케이션에서 스레드 라이프사이클을 관리하는 선호되는 방법은 CancellationToken을 사용하는 것입니다. 이를 통해 스레드가 예측 가능하고 안전하게 취소될 수 있습니다.

<div class="content-ad"></div>

# 쓰레드 관련 문제

## 데드락과 경쟁 조건

이미 소개된 대로, 각 쓰레드는 고유한 스택을 가지고 있지만 힙 메모리는 공유합니다.

![이미지](/assets/img/2024-06-19-MultithreadinginCNetIntroductionandBestpractices_18.png)

<div class="content-ad"></div>

여러 스레드가 하나의 공유된 값을 액세스하고 수정할 수 있다는 것을 의미합니다.

이는 레이스 조건이라고 불리는 것을 일으킬 수 있습니다. 기본적으로 두 스레드가 동시에 동일한 값을 변경하는 상황입니다.

![이미지 1](/assets/img/2024-06-19-MultithreadinginCNetIntroductionandBestpractices_19.png)

![이미지 2](/assets/img/2024-06-19-MultithreadinginCNetIntroductionandBestpractices_20.png)

<div class="content-ad"></div>

요청해주신 코드 예제를 확인해보세요

```js
// 공유 변수
public static int i = 0;

public static void ExecuteWork()
{
    // 스레드가 루프를 실행
    var t = new Thread(DoWork);
    t.Start();
    // 다른 스레드가 루프를 실행하면 경쟁 상태로 이어집니다
    DoWork();
}
// 두 스레드가 이 메서드를 실행함
public static void DoWork()
{
    for(i = 0;i < 5; i++)
    {
        Console.WriteLine("*");
    }
}
// "******"이 출력되어야 할 것을 5개가 아닌 6개 출력함
```

또다른 문제는 데드락인데, 이는 두 개 이상의 스레드가 영원히 차단되어 서로 다른 쓰레드가 리소스를 해제할 때를 기다리는 경우 발생합니다.

데드락은 여러 스레드가 동일한 리소스 세트가 필요하고 이를 서로 다른 순서로 획득할 때 발생할 수 있습니다.

<div class="content-ad"></div>

<img src="https://miro.medium.com/v2/resize:fit:520/0*QImExmL-baj0qzsk.gif" />

## Join과 Lock을 사용하여 경합 조건과 데드락 방지하기

경합 조건을 방지하려면 다음 중 하나를 할 수 있습니다:

- 스레드가 서로 기다릴 수 있도록 하기
- 스레드를 잠그기

<div class="content-ad"></div>

이전에 보았던 것처럼 `Thread.Join`을 사용하여 스레드를 대기할 수 있습니다.

```js
// 메인 스레드를 일시 중지합니다.
// 스레드가 완료될 때까지 대기합니다.
// 메인 스레드를 다시 실행합니다.
thread.Join();

// TimeSpan 또는 int Milliseconds도 사용할 수 있습니다.
bool Thread.Join(TimeSpan timeout);
```

다른 방법은 `Thread.Lock` 문을 사용하는 것입니다.

해당 문은 기본적으로 공유 객체를 "잠그고" 실행 중인 스레드만에게 액세스할 수 있도록 합니다.

<div class="content-ad"></div>

한 번 스레드가 끝나면 객체를 해제합니다.

```js
using System;
using System.Threading;

class Program
{
// 이 객체들은 공유됩니다
    private static readonly object lock1 = new object();
    private static readonly object lock2 = new object();

    public static void Main()
    {
        // 스레드 1
        var t1 = new Thread(Thread1);
        t1.Start();

        // 스레드 2
        var t2 = new Thread(Thread2);
        t2.Start();

        t1.Join();
        t2.Join();
    }

    public static void Thread1()
    {
        lock (lock1)
        {
            Thread.Sleep(100); // 일부 작업 시뮬레이션
            lock (lock2)
            {
                Console.WriteLine("Thread 1이 두 개의 락을 획득했습니다");
            }
        }
    }

    public static void Thread2()
    {
        lock (lock2)
        {
            Thread.Sleep(100); // 일부 작업 시뮬레이션
            lock (lock1)
            {
                Console.WriteLine("Thread 2가 두 개의 락을 획득했습니다");
            }
        }
    }
}
```

## AutoResetEvent

AutoResetEvent를 사용하면 스레드 간 통신을 동기화할 수 있습니다.

<div class="content-ad"></div>

다음은 작동 방법입니다:

- AutoResetEvent를 생성합니다 =` 이벤트가 생성됨
- 1번 스레드가 이벤트에 대해 WaitOne()을 호출합니다 =` 스레드1은 이벤트가 해제될 때까지 기다립니다
- 2번 스레드가 작업을 수행한 후 이벤트에 대해 set()을 호출합니다 =` 스레드1이 작업을 수행할 수 있습니다

```js
   static AutoResetEvent autoResetEvent = new AutoResetEvent(false);

    static void Thread1()
    {
        autoResetEvent.WaitOne(); // 이벤트가 신호를 받을 때까지 대기합니다
        // 여기에서 작업을 수행합니다
    }

    static void Thread2()
    {
        // 일부 작업을 시뮬레이션합니다.
        Thread.Sleep(2000); 
        autoResetEvent.Set(); // 이벤트를 신호하여 대기 중인 스레드 하나를 해제합니다
    }
```

이제 스레드 간 통신이 이루어지며 서로 작업을 수행할 수 있는 시기를 신호로 알릴 수 있습니다.

<div class="content-ad"></div>

로버스트한 통신을 위해서는 락을 피하기 위해 두 개의 AutoResetEvent와 함께 작업하는 것이 가장 좋습니다. 이렇게 하면 두 스레드가 필요할 때 Set 및 Wait를 시그널할 수 있습니다.

![이미지](/assets/img/2024-06-19-MultithreadinginCNetIntroductionandBestpractices_21.png)

## 스레드 성능 문제

새로운 스레드를 시작하는 것은 성능적으로 비용이 많이 드는데, 그 이유는 여러 가지가 있습니다:

<div class="content-ad"></div>

- 메모리 할당

새로운 스레드가 생성되면, 시스템은 해당 스레드의 스택과 스레드 제어 블록(TCB)을 위한 메모리를 할당합니다.

이러한 리소스를 할당하고 초기화하는 작업은 메모리와 시간을 모두 소모합니다.

- 운영 체제(OS) 오버헤드

<div class="content-ad"></div>

각 스레드의 수명주기를 관리해야 합니다. 이러한 작업에는 CPU 사이클이 필요하며 스레드를 시작하는 오버헤드에 기여합니다.

- 스레드 초기화

스레드를 생성하는 것은 즉각적으로 이루어지지 않습니다. 할당된 자원을 설정하고 실행 환경을 구성하고 스케줄러에 통보하는 시간이 필요합니다.

이 문제의 해결책은 스레드 풀을 사용하는 것입니다.

<div class="content-ad"></div>

```markdown
![ThreadPool](https://miro.medium.com/v2/resize:fit:720/0*9oNxhHqD2tltG8U4.gif)

# IV/ The ThreadPool

System.Threading.ThreadPool 클래스는 worker 스레드 풀을 제공합니다. 또한 스레드 풀 스레드를 사용할 수 있습니다.

새 스레드를 생성하는 대신 스레드 풀을 사용하면 기존 스레드를 재사용하여 성능을 향상시킬 수 있습니다.
```

<div class="content-ad"></div>

여기 과정이에요:

- 쓰레드풀이 작업을 받음
- 쓰레드풀이 쓰레드 할당
- 쓰레드가 작업 실행
- 쓰레드가 풀로 반환

.NET 프레임워크는 스레드 관리를 수동으로 하지 않고도 쓰레드 풀을 사용할 수 있게 해주는 내장 ThreadPool 클래스를 제공합니다.

그래서 이전에 하던 것처럼 쓰레드를 생성하는 대신 쓰레드를 쓰레드풀에 대기시키면 됩니다.

<div class="content-ad"></div>

```js
ThreadPool.QueueUserWorkItem(Worker);

void Worker()
{
    Console.WriteLine("작업이 실행되었습니다.");
}
```

관리되는 스레드 풀의 스레드는 백그라운드 스레드입니다.

언제든지 사용 가능한 스레드, 풀의 최대 및 최소 스레드를 볼 수 있습니다. 또한 이를 설정할 수도 있습니다!

```js
// 사용 가능한 스레드 얻기
ThreadPool.GetAvailableThreads(out int workerThreads, out int completionPortThreads);

// 최대 스레드 얻기
ThreadPool.GetMaxThreads(out int maxWorkerThreads, out int maxCompletionPortThreads);

// 최소 스레드 얻기
ThreadPool.GetMinThreads(out int minWorkerThreads, out int minCompletionPortThreads);

// 최대 스레드 설정
ThreadPool.SetMaxThreads(8, 8);

// 최소 스레드 설정
ThreadPool.SetMinThreads(4, 4);
```

<div class="content-ad"></div>

쓰레드 풀을 사용해도 공유 데이터를 사용할 때는 여전히 쓰레드를 동기화해야 해요.

# 동기화 메커니즘

Thread 클래스는 .NET의 동기화 기본 요소인 Mutex, Semaphore, Monitor와 원활하게 작동해요.

이러한 메커니즘은 공유 리소스에 대한 액세스를 관리하고, 데이터 일관성을 보장하며 경쟁 조건을 방지하는 데 도움이 돼요.

<div class="content-ad"></div>

## 뮤텍스

뮤텍스(Mutex: mutual exclusion의 줄임말)는 한 번에 하나의 스레드만 락을 획득할 수 있는 동기화 기본 요소입니다.

```js
Mutex mutex = new Mutex();

for (int i = 0; i < 5; i++)
{
   Thread thread = new Thread(EnterCriticalSection);
   thread.Start(i);
}

void EnterCriticalSection(object threadId)
{
  mutex.WaitOne(); // 뮤텍스 락 획득

  try
  {      
      Thread.Sleep(1000); // 작업 시뮬레이션
  }
  
  finally
  {
      mutex.ReleaseMutex(); // 뮤텍스 락 해제
  }
}
```

## 세마포어

<div class="content-ad"></div>

세마포어는 동시에 리소스에 접근할 수 있는 스레드 수를 제한하는 동기화 기본 요소입니다.

사용 가능한 리소스 수를 유지하고, 수가 0이 될 때 스레드를 차단합니다.

```js
Semaphore semaphore = new Semaphore(2, 2); // 2개의 스레드가 동시에 허용됨

for (int i = 0; i < 5; i++)
{
    Thread thread = new Thread(EnterCriticalSection);
    thread.Start(i);
}

static void EnterCriticalSection(object threadId)
{
    semaphore.WaitOne(); // 세마포어 획득
    try
    {
        // Critical section: 공유 리소스에 액세스
        Thread.Sleep(1000); // 작업 시뮬레이션
    }
    finally
    {
        semaphore.Release(); // 세마포어 해제
    }
}
```

## 모니터 (lock)

<div class="content-ad"></div>

Monitor 클래스는 C#의 lock 키워드를 사용하는 것과 유사하게 리소스에 대한 독점적 액세스 메커니즘을 제공합니다.

이는 한 번에 한 스레드만 코드의 중요한 섹션을 실행할 수 있도록 보장합니다.

```js
static object lockObject = new object();


for (int i = 0; i < 5; i++)
{
     Thread thread = new Thread(EnterCriticalSection);
     thread.Start(i);
    }
 }

static void EnterCriticalSection(object threadId)
{
   lock (lockObject) // 락을 획득합니다.
    {
      Thread.Sleep(1000); // 작업 시뮬레이션
    }
}
```

# VI/ 스레드 관리

<div class="content-ad"></div>

## Foreground vs background thread

기본적으로 .NET에서 생성된 쓰레드는 전경 스레드이므로 완료될 때까지 애플리케이션을 유지합니다.

그러나 쓰레드를 백그라운드 쓰레드로 명시적으로 설정할 수 있으며, 전경 스레드가 모두 실행을 마치면 자동으로 종료됩니다.

```js
// 쓰레드를 백그라운드로 명시적으로 설정합니다.
thread.IsBackground = true;
```

<div class="content-ad"></div>

```markdown
![Image](/assets/img/2024-06-19-MultithreadinginCNetIntroductionandBestpractices_22.png)

## 스레드 컨텍스트

스레드 컨텍스트에는 스레드가 실행을 중단하고 다시 시작할 수 있는 모든 정보가 포함되어 있습니다. 이에는 CPU 레지스터, 스택 및 기타 관련 데이터가 포함됩니다.

```js
// 스레드의 현재 상태에 대한 정보를 확인하려면 (실행 중, 백그라운드, 중지됨, 중단됨...)
 var threadState = thread.ThreadState;
```

<div class="content-ad"></div>

## 쓰레드에 데이터 전달하기

람다 표현식은 쓰레드를 초기화하고 데이터를 전달하는 데 자주 사용됩니다.

```js
// 한 개의 인수만 전달 가능
var thread = new Thread(() => Operation("Hello"));
```

```js
private void Operation(string name)
{
    Console.WriteLine("쓰레드에서의 안녕" + name);
}
```  

<div class="content-ad"></div>

그러나 race condition을 피하기 위해 공유 변수를 스레드에 전달할 때 주의해야 합니다. 상수 또는 지역 변수를 사용하는 것이 가장 좋습니다.

```js
const string greeting = "Hello";
var thread = new Thread(() => Operation(greeting));
```

## 스레드 우선순위

스레드는 실행 순서를 결정하는 서로 다른 우선순위를 가질 수 있습니다.

<div class="content-ad"></div>

더 높은 우선순위를 가진 스레드가 더 많은 CPU 시간을 받습니다. 기본 우선순위는 Normal입니다.

```js
thread.Priority = ThreadPriority.Highest;

// 가능한 옵션은:
Lowest
BelowNormal
Normal
AboveNormal
Highest
```

## 스레드 로컬 스토리지

Thread 클래스는 ThreadLocal`T` 클래스를 사용하여 스레드 로컬 스토리지를 지원합니다.

<div class="content-ad"></div>

각 스레드가 고유한 데이터를 가지도록하여 스레드 안전을 보장하고 데이터 손상을 방지합니다.

```js
ThreadLocal<int> threadLocalValue = new ThreadLocal<int>(() => 0);
```

## 스레드 디버깅

스레드에 이름을 지정하여 쉽게 디버깅할 수 있습니다.

<div class="content-ad"></div>

```markdown
![이미지](/assets/img/2024-06-19-MultithreadinginCNetIntroductionandBestpractices_23.png)

```js
thread.Name = "Bob Thread";
```

![이미지](/assets/img/2024-06-19-MultithreadinginCNetIntroductionandBestpractices_24.png)

다음과 같이 사용중인 스레드 정보를 얻을 수 있습니다:
```

<div class="content-ad"></div>

```js
ConsoleWriteLine("메인 스레드의 ID: " + Thread.CurrentThread.ManagedThreadId);
```

또한 디버깅 중에는 어떤 스레드가 무엇을 수행하고 있는지 확인할 수도 있어요

![이미지](/assets/img/2024-06-19-MultithreadinginCNetIntroductionandBestpractices_25.png)

위 내용은 아래 창을 표시합니다.```

<div class="content-ad"></div>

```markdown
![이미지](/assets/img/2024-06-19-MultithreadinginCNetIntroductionandBestpractices_26.png)

# VII/ .Net에서 스레드 작업 추천 방법

- Thread.Abort를 사용하지 마세요

해당 스레드에 예외를 throw하는 것과 유사하게 스레드를 강제로 종료시킵니다. 대신 취소 토큰을 사용하세요.
```

<div class="content-ad"></div>

- 다른 리소스를 필요로 하는 작업에는 여러 스레드를 사용하고 단일 리소스에 여러 스레드를 할당하는 것은 피하십시오.

I/O 작업을 포함하는 작업은 블록을 방지하고 전체 처리량을 향상시키기 위해 각각 자체 스레드를 가지는 것이 좋습니다.

마찬가지로 사용자 입력 처리와 같은 작업은 전용 스레드로 처리하는 것이 가장 좋습니다.

```js
ThreadPool.QueueUserWorkItem(PerformIOOperation);
ThreadPool.QueueUserWorkItem(ProcessUserInput);
```

<div class="content-ad"></div>

- 쓰레드에서 예외를 처리하세요.

쓰레드에서 처리되지 않은 예외는 일반적으로 프로세스를 종료시킵니다.

```js
ThreadPool.QueueUserWorkItem(DoWork);

void DoWork(object state)
{
    try
    {
        // 여기서 작업 수행
    }
    catch (Exception ex)
    {
        // 예외 처리
    }
}
```

- System.Threading.ThreadPool을 사용하여 쓰레드를 초기화하고 관리하세요.

<div class="content-ad"></div>

`System.Threading.ThreadPool` 클래스를 사용하여 스레드를 초기화하고 관리하세요. 특히 짧은 수명을 가진 작업과 비동기 작업에 유용합니다.

스레드 풀은 작업자 스레드의 풀을 효율적으로 관리하여 스레드 생성 및 소멸의 부하를 줄입니다.

```js
ThreadPool.QueueUserWorkItem(DoWork);
```

- 스레드 대신 작업들을 사용하세요!

<div class="content-ad"></div>

.NET Framework 4부터 멀티스레딩을 활용하는 권장 방법은 Task Parallel Library (TPL) 및 Parallel LINQ (PLINQ)를 사용하는 것입니다. 자세한 내용은 병렬 프로그래밍을 참조하십시오. (Microsoft)

![이미지](/assets/img/2024-06-19-MultithreadinginCNetIntroductionandBestpractices_27.png)

다음 블로그에서 다시 만나요! :)

## 언제 스레드를 사용해야 할까요?

<div class="content-ad"></div>

쓰레드는 작업과 같은 고수준 추상화로는 항상 달성할 수 없는 수준의 제어와 사용자 정의를 제공합니다.

쓰레드는 개발자에게 코드 실행을 저수준에서 직접 제어할 수 있는 기회를 제공합니다.

이는 특정 성능 중요한 상황이나 전문화된 시나리오에서 중요할 수 있는 리소스, 스케줄링 및 동기화의 정확한 관리를 가능하게 합니다.

쓰레드는 더 많은 제어와 유연성을 제공하지만 경합 조건, 데드락 및 동기화 문제와 같은 추가 복잡성과 잠재적인 함정도 동반합니다.

<div class="content-ad"></div>

따라서, 귀하의 애플리케이션 요구 사항에 기반을 두고 상호 작용 모델을 신중히 고려하고 적절한 동시성 모델을 선택하는 것이 중요합니다.

# 소스

## 비동기

https://www.udemy.com/course/ultimate-csharp-masterclass/

<div class="content-ad"></div>

## 쓰레드

[멀티쓰레드 C# 코드 작성 방법](https://www.udemy.com/course/how-to-write-multi-threaded-csharp-code)

## .Net에서 병렬 프로그래밍