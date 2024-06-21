---
title: "NET C에서 SOLID 원칙 이해하기 코드 예시와 함께하는 실용 가이드"
description: ""
coverImage: "/assets/img/2024-06-22-UnderstandingSOLIDPrinciplesinNETCAPracticalGuidewithCodeExamples_0.png"
date: 2024-06-22 04:25
ogImage: 
  url: /assets/img/2024-06-22-UnderstandingSOLIDPrinciplesinNETCAPracticalGuidewithCodeExamples_0.png
tag: Tech
originalTitle: "Understanding SOLID Principles in .NET (C#): A Practical Guide with Code Examples"
link: "https://medium.com/@jeslurrahman/understanding-solid-principles-in-net-c-a-practical-guide-with-code-examples-2e759010974e"
---


SOLID 원칙은 개발자가 쉽게 확장 가능한 코드를 작성하고 일반적인 코딩 오류를 피할 수 있게 도와줍니다.

이 원칙들은 Robert C. Martin에 의해 소개되었으며 객체 지향 프로그래밍의 기본 요소가 되었습니다.

.NET 개발에서 SOLID 원칙을 준수하면 코드가 더 모듈식, 유연하고 유지보수하기 쉬워질 수 있습니다. 이 글에서는 C#에서 실제 코딩 예제와 함께 각 SOLID 원칙을 자세히 살펴볼 것입니다.

다음은 다섯 가지 SOLID 디자인 원칙입니다:

<div class="content-ad"></div>


![Image](/assets/img/2024-06-22-UnderstandingSOLIDPrinciplesinNETCAPracticalGuidewithCodeExamples_0.png)

# 1. 단일 책임 원칙 (SRP)

SRP는 클래스가 변경되어야 하는 이유가 하나만 있어야 한다는 것을 말합니다. 즉, 하나의 책임만을 가져야 합니다. 이는 모듈화를 촉진하고 코드를 이해하고 유지보수하기 쉽게 만듭니다.

주요 아이디어: 클래스는 한 가지 일만을 해야 하며, 그 일을 잘 수행해야 합니다.


<div class="content-ad"></div>

실시간 예시: 레스토랑을 운영하거나 음식을 배달하는 것에만 전념하는 요리사를 생각해보세요.

C#에서의 실용적인 코딩 예시:

SRP를 적용하기 전:

```js
public class Report
{
    public void GenerateReport() { }
    public void SaveToFile() { }
}
```

<div class="content-ad"></div>

이 시나리오에서 Report 클래스는 리포트를 생성하고 파일로 저장하는 두 가지 책임을 갖고 있습니다. 이는 SRP를 위반합니다.

SRP 적용 후:

```js
public class Report
{
    public void GenerateReport() { }
}

public class ReportSaver
{
    public void SaveToFile() { }
}
```

이제 Report 클래스는 리포트 생성에만 책임이 있고, ReportSaver 클래스는 리포트 저장에 책임이 있습니다. 각 클래스는 단일 책임을 갖습니다.

<div class="content-ad"></div>

해석: SRP에 따르면, 한 클래스는 하나의 책임을 가져야합니다. 이 문제를 해결하기 위해 보고서 기능을 저장하기 위해 다른 클래스를 작성해야 합니다. 이 때 Report 클래스를 수정해도 ReportSaver 클래스에는 영향을 미치지 않습니다.

## 2. 개방/폐쇄 원칙 (OCP)

개방/폐쇄 원칙은 클래스가 확장에 대해 열려 있어야 하지만 수정에 대해서는 닫혀 있어야 한다고 제안합니다. 이것은 기존 코드를 변경하지 않고 새로운 기능을 추가할 수 있다는 것을 의미합니다.

주요 아이디어: 한 번 클래스를 작성하면 수정하는 것은 닫혀 있고, 확장하는 것은 열려 있어야 합니다.

<div class="content-ad"></div>

실시간 예시: 당신의 스마트폰 - 기능을 추가하려면 열지 않고도 앱을 다운로드하여 능력을 확장할 수 있습니다.

C#에서의 실용적인 코딩 예시:

OCP 신청 전:

```js
public class Rectangle
{
    public double Width { get; set; }
    public double Height { get; set; }
}

public class AreaCalculator
{
    public double CalculateArea(Rectangle rectangle)
    {
        return rectangle.Width * rectangle.Height;
    }
}
```

<div class="content-ad"></div>

새로운 도형을 추가할 때 이 디자인은 문제가 될 수 있습니다. 각 새로운 도형에 대해 AreaCalculator를 수정하면 OCP를 위반하게 됩니다.

OCP를 적용한 후:

```js
public interface IShape
{
    double CalculateArea();
}

public class Rectangle : IShape
{
    // 구현
}

public class Circle : IShape
{
    // 구현
}
```

인터페이스(IShape)를 도입하여 기존 코드를 수정하지 않고도 새로운 도형(예: Circle)을 추가할 수 있습니다. OCP를 준수하는 방법입니다.

<div class="content-ad"></div>

OCP에 따르면 클래스는 확장에 열려 있지만 수정에 대해 닫혀 있어야 합니다. 새로운 모양을 도입할 때는 그냥 인터페이스 IShape를 구현하면 됩니다. 그러면 IShape은 확장이 가능하지만 추가 수정은 불가능해집니다.

## 3. 리스코프 치환 원칙 (LSP)

리스코프 치환 원칙은 슈퍼클래스의 객체를 하위 클래스의 객체로 대체할 수 있어야 하며 프로그램의 정확성에 영향을 미치지 않아야 한다는 원칙입니다.

주요 아이디어: 부모 클래스를 사용하는 곳에 하위 클래스를 사용할 수 있어야 합니다.

<div class="content-ad"></div>

실시간 예시: 여러 브랜드의 TV에 모두 작동하는 원격 제어기를 가지고 있습니다.

C#에서의 실용적인 코딩 예시:

LSP를 적용하기 전:

```csharp
public class Bird
{
    public virtual void Fly() { /* 구현 */ }
}

public class Penguin : Bird
{
    public override void Fly()
    {
        throw new NotImplementedException("펭귄은 날지 못해요!");
    }
}
```

<div class="content-ad"></div>

여기서 펭귄 클래스는 Fly 메서드에 예외를 발생시켜 LSP를 위반합니다.

LSP를 적용한 후:

```js
public interface IFlyable
{
    void Fly();
}

public class Bird : IFlyable
{
    public void Fly()
    {
        // Bird에 특화된 구현
    }
}

public class Penguin : IFlyable
{
    public void Fly()
    {
        // 펭귄에 특화된 구현
        throw new NotImplementedException("펭귄은 날지 못해요!");
    }
}
```

IFlyable 인터페이스를 도입함으로써, Bird와 Penguin은 릴스코프 치환 원칙을 준수하게 되었습니다.

<div class="content-ad"></div>

설명: LSP에 따르면 파생 클래스는 기본 클래스의 유형 정의와 동작을 깨뜨리지 않아야 합니다. 이는 기본 클래스의 객체를 파생 클래스의 객체로 교체해도 응용 프로그램이 깨지지 않아야 함을 의미합니다. 이는 파생 클래스의 객체가 기본 클래스의 객체와 동일한 방식으로 동작해야 한다는 것을 필요로 합니다.

# 4. Interface Segregation Principle (ISP)

인터페이스 분리 원칙은 클래스가 사용하지 않는 인터페이스를 강제로 구현하도록 해서는 안 된다고 말합니다. 이 원칙은 작고 특정 클라이언트용 인터페이스를 생성하는 것을 권장합니다.

주요 아이디어: 클래스는 사용하지 않는 인터페이스를 구현하도록 강제되어서는 안 됩니다.

<div class="content-ad"></div>

실시간 예시: 음악 스트리밍 서비스에 가입하여 좋아하는 장르만 선택하는 상황을 상상해보세요.

C#에서의 실제 코딩 예시:

ISP 신청 전:

```js
public interface IWorker
{
    void Work();
    void Eat();
}

public class Manager : IWorker
{
    // 구현
}

public class Robot : IWorker
{
    // 구현
}
```

<div class="content-ad"></div>

로봇 클래스는 ISP를 위반하지 않도록 먹는 방법을 구현해야 합니다.

ISP를 적용한 후:

```js
public interface IWorkable
{
    void Work();
}

public interface IEatable
{
    void Eat();
}

public class Manager : IWorkable, IEatable
{
    // 구현
}

public class Robot : IWorkable
{
    // 구현
}
```

IWorkable 인터페이스를 IWorkable 및 IEatable 같은 작은 인터페이스로 분할하여, 각 클래스가 필요한 부분만 구현할 수 있도록 하여 ISP를 준수할 수 있습니다.

<div class="content-ad"></div>

설명: LSP에 따르면, 어떤 클라이언트도 해당 클라이언트와 관련이 없는 인터페이스를 강제로 사용해서는 안 됩니다. 다시 말해, 클라이언트는 사용하지 않는 메소드에 의존하도록 강요되어서는 안 됩니다.

# 5. 의존 역전 원칙 (DIP)

의존 역전 원칙은 고수준 모듈이 저수준 모듈에 의존하지 않아야 하며, 두 모듈 모두 추상화에 의존해야 한다는 것을 제안합니다. 또한, 추상화는 세부사항에 의존해서는 안 되며, 세부사항은 추상화에 의존해야 합니다.

주요 아이디어: 고수준 모듈은 저수준 모듈에 의존해서는 안 되며, 두 모듈 모두 추상화에 의존해야 합니다.

<div class="content-ad"></div>

실시간 예제: 레고 타워 만들기 - 브릭(고수준 및 저수준 모듈)은 작은 브릭(추상화)을 통해 연결됩니다.

C#에서의 실용적인 코딩 예제:

DIP를 적용하기 전:

```js
public class LightBulb
{
    public void TurnOn() { /* 구현 */ }
    public void TurnOff() { /* 구현 */ }
}

public class Switch
{
    private LightBulb bulb;

    public Switch(LightBulb bulb)
    {
        this.bulb = bulb;
    }

    public void Toggle()
    {
        if (bulb.IsOn)
            bulb.TurnOff();
        else
            bulb.TurnOn();
    }
}
```

<div class="content-ad"></div>

스위치 클래스는 이제 추상화에 의존하도록 변경되어 DIP(Dependency Inversion Principle)를 준수합니다.

<div class="content-ad"></div>

해석: DIP에 따르면 어플리케이션이 점점 커져갈 때 서로 강하게 결합된 코드를 작성하는 것은 유지보수하기 어려운 악몡이 될 수 있습니다. 한 클래스가 다른 클래스에 의존할 경우, 의존하는 클래스가 변경되면 해당 클래스도 수정해야 합니다. 항상 느슨하게 결합된 클래스를 작성하려고 노력해야 합니다.

결론

.NET 개발자들은 이러한 SOLID 원칙을 이해하고 적용함으로써 더 강력하고 유연하며 유지보수가 쉬운 소프트웨어를 만들 수 있습니다. 이러한 원칙이 함께 작동하여 서로 보완하며 객체지향 프로그래밍의 전체적인 설계 철학에 기여한다는 점을 명심하는 것이 중요합니다.

저자: Jeslur Rahman