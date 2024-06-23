---
title: "컨트롤러는 이제 그만 Vertical Slice로 Blazor 웹 앱 더 잘 만들기"
description: ""
coverImage: "/assets/img/2024-06-23-GoodbyeControllersBuildingBetterBlazorWebAppswithVerticalSlices_0.png"
date: 2024-06-23 15:11
ogImage: 
  url: /assets/img/2024-06-23-GoodbyeControllersBuildingBetterBlazorWebAppswithVerticalSlices_0.png
tag: Tech
originalTitle: "Goodbye Controllers: Building Better Blazor Web Apps with Vertical Slices"
link: "https://medium.com/gitconnected/goodbye-controllers-building-better-blazor-web-apps-with-vertical-slices-3a8b9b413bac"
---


![이미지](/assets/img/2024-06-23-GoodbyeControllersBuildingBetterBlazorWebAppswithVerticalSlices_0.png)

안녕하세요! 이 기사에서는 수직 슬라이스 아키텍처를 어떻게 활용할 수 있는지 다시 살펴보려고 합니다. 이 기사는 콘트롤러 클래스가 필요 없는 서버 측 렌더링(SSR) .NET 8 Blazor 페이지에 기능 슬라이싱을 적용하는 방법을 자세히 살펴봅니다. 주요 포인트에 대한 명확한 설명과 실용적인 조언을 제공합니다:

- .NET 생태계 내에서 MediatR 라이브러리의 강력함을 이용하여 수직 슬라이스 아키텍처가 무엇이며 어떻게 작동하는지 이해하기.
- 수직 슬라이스와 마이크로서비스 사이의 차이와 각각이 적절한 시점.
- 전통적인 컨트롤러 기반 모델이 현대 웹 앱 디자인에서 필요하지 않을 수 있는 이유.
- 더 나은 유지 관리성과 확장성을 위해 간결하고 독립적인 기능 슬라이스를 제공하는 수직 슬라이스 접근 방식을 활용한 Razor 페이지를 만드는 실용적인 실전 안내서.

이 기사를 마치면 수직 슬라이스 아키텍처에 대해 철저히 이해하고 .NET 8 Blazor 프로젝트에서 활용하여 완성도와 모듈성을 향상시킬 수 있을 것입니다. 부디 여러분의 프로젝트에 적용하여 좀 더 견고하고 모듈화된 시스템을 구축해 보세요.

<div class="content-ad"></div>

# 수직 슬라이스 아키텍처란 무엇인가요?

먼저, 수직 슬라이스 아키텍처가 정확히 무엇을 의미하며 왜 응용 프로그램을 구축하는 좋은 방법인지 명확히 알아보고 싶습니다. 많은 패턴이 있지만 대부분은 결국 많은 의존성을 가진 코드베이스로 이끌려합니다. 좋은 개발자는 항상 코드를 개선하고 지속 가능한 것을 만들려고 노력해야 합니다. 제가 좋은 코드라고 말하는 것은 복잡한 게 아니라 읽고 이해하기 쉬워야 한다는 것입니다.

소프트웨어 시스템을 작은 조각으로 나누는 것이 좋은 방법인 이유에 대해 이야기해보죠. 큰 장점은 상호작용에 초점을 맞추는 것이라고 생각합니다. 즉, 슬라이스로 생각한다는 것은 정확히 하나의 입력-출력 쌍, 즉 하나의 상호작용에 집중한다는 것입니다. 그리고 모든 시스템은 상호작용으로 이루어져 있습니다. 각 슬라이스는 사용자(또는 다른 시스템)로부터 입력을 받고 출력을 제공해야 합니다.

<img src="/assets/img/2024-06-23-GoodbyeControllersBuildingBetterBlazorWebAppswithVerticalSlices_1.png" />

<div class="content-ad"></div>

환경과 교환되는 입력/출력 사이에는 구별하는 것이 중요합니다 (예: 양식 필드 또는 JSON). 이는 내부 처리를위한 포탈이 만들어낸 결과물과 다릅니다. 입력은 표준 사용자 인터페이스(예: GUI)를 통해 수동으로 제공되거나 HTTP 요청으로 제공될 수 있습니다. 출력물은 텍스트나 이미지와 같은 시각적인 것 또는 HTTP 응답일 수 있습니다.

스플라이스는 독립적이어야 합니다. 모듈을 나타내며 요청을 처리하는 데 필요한 모든 것을 포함합니다. 스플라이스 내에서는 높은 응집도를 가지고 있습니다. 이는 전통적인 계층 지향적 아키텍처 접근 방식과도 중요한 차이점입니다. 관심사를 수평적으로 나누어 보기 어렵게 만드는데, 즉 상호작용의 일관성을 알기 어렵게 만듭니다. 계층구조는 항상 시스템을 과도하게 기술적으로 볼 수 있는 문제로 이어집니다. 이는 추상화해서는 안 되는 개념 주위의 많은 추상화를 만듭니다. 예를 들어, 컨트롤러가 서비스와 대화해야 하고, 서비스가 리포지토리를 사용해야 하는 등입니다.

요컨대, 수직 슬라이스 아이디어는 비즈니스 요구에 따라 코드를 로컬라이징하는 것에 있습니다.

# 수직 슬라이스와 마이크로서비스의 차이점은 무엇인가요?

<div class="content-ad"></div>

일부 소프트웨어 시스템을 슬라이싱하는 것은 마이크로서비스 아키텍처 접근법과 비슷하게 들릴지도 모르겠네요, 그렇죠? 최근에 Vertical Slice Architecture에 관한 제 논문들을 쓴 후에, 어떻게 이것이 마이크로서비스와 다른지 자주 물어보는 분들이 많았어요. 두 접근법 모두 소프트웨어 시스템을 하나의 목적에 집중한 작은 조각으로 나누어 명확하고 유지보수 가능한 구조, 그리고 모듈성과 관심사 분리를 달성하려는 목표를 갖고 있어요.

두 가지 접근법 모두 사용 사례나 기능을 기반으로 구현 방법을 결정하는 것을 허용해주죠. 제가 말하고 싶은 것은, 예를 들어, 도메인 모델 패턴을 응용 전역적으로 사용해야 하는 것이 아니라 정말 필요한 곳에만 사용하면 된다는 것이에요. 때로는 간단한 트랜잭션 스크립트만으로도 충분할 때가 있어요. 우리는 새로운 기능을 추가하고 공통 코드에 대해 걱정하지 않고 적합한 패턴을 사용할 수 있어요.

하지만 두 접근법의 차이는 무엇인가요? 먼저, 마이크로서비스 접근법을 간단히 살펴볼까요?

<div class="content-ad"></div>

마이크로서비스는 기능 간 물리적 분리 아이디어에 기반을 두고 있어요. 이는 서비스를 독립적으로 개발하고 배포하는 것을 유용하게 합니다. 이러한 이점은 배포, 버전 관리, 코드 공유의 복잡성 증가와 함께 제공됩니다.

(나는 마이크로서비스를 구현하는 데 발생할 수 있는 잠재적인 문제에 대해 기사를 썼어. 지난 몇 년간의 경험을 기반으로 하고 있어.)

이전에 이 토론에서, 우리는 기능 슬라이스의 개념을 살펴봤어. 이는 우리의 코드 조직을 일관된 비즈니스 도메인 주변으로 중점을 두는 것입니다. 세로 슬라이스의 본질은 기능의 완전한 동작을 나타내는 요청-응답 쌍에 캡슐화되어 있어요.

![이미지](/assets/img/2024-06-23-GoodbyeControllersBuildingBetterBlazorWebAppswithVerticalSlices_3.png)

<div class="content-ad"></div>

명령 및 쿼리 분리 (CQS) 원칙을 준수하면 슬라이스를 명확하고 정확하게 식별하는 데 도움이 됩니다. 물리적 레이어 - API의 기초를 형성하거나 데이터베이스 스키마를 정의하는 레이어- 은(는) 그대로 유지됩니다. 각 슬라이스는 단일 비즈니스 기능이나 상호작용에 특화되어 있습니다. 슬라이스 간의 종속성을 최소화하고 슬라이스 내에서 높은 응집력을 유지하는 것이 관건입니다. 이 접근 방식은 일부 측면에서 마이크로서비스 접근 방식과 유사하지만, 응용 프로그램은 단일 배포 단위임을 유념해야 합니다.

# 컨트롤러가 더 이상 필요하지 않은 이유

좋은 소식이 있어요. .NET 8과 Blazor를 사용하면 컨트롤러를 공개할 필요가 없어집니다. 마침내.

이미 저는 다른 기사에서 컨트롤러에 대한 혐오를 표현해 왔는데, 이는 궁극적으로 너무 많은 것을 알고 있거나 일반적으로 너무 많은 종속성을 가진 컨테이너의 생성으로 이어진다는 것을 설명했습니다. 기능 슬라이스의 이상적인 세계에서 작업(상호작용)을 수행하는 데 필요한 모든 것을 포함하는 폴더가 있습니다. 그 폴더에 들어있는 것은 기능을 설명하므로 한 컨테이너(폴더)에 포함되어 있습니다. .NET에서는 이들이 동일한 네임스페이스에 속하게 됩니다. 이는 예를 들어 사용자 목록 기능에서 사용자의 표현을 설명할 때 사용자 세부 정보 보기와 다르다는 것을 의미합니다. 공유 모델은 없고 완전히 독립적입니다.

<div class="content-ad"></div>

또한 사용자 인터페이스를 통한 상호 작용 시, 뷰도 컨테이너에 포함되어야 합니다. .NET 8을 사용한 Blazor Web App 구현에서 예를 들어, Users.razor 페이지는 피쳐 슬라이스의 일부이므로 코드 다른 위치에 구성할 수 없습니다.

![이미지](/assets/img/2024-06-23-GoodbyeControllersBuildingBetterBlazorWebAppswithVerticalSlices_4.png)

다음 예제에서는 코드를 기능별로 구성하는 방법을 보여드리고 싶습니다. 계층적으로 생각하는 것을 그만 두세요. 각 기능 슬라이스에는 요청을 처리하기 위한 것(입력)과 응답을 생성하기 위한 것(출력)이 포함됩니다.

# 실습

<div class="content-ad"></div>

예시로 GetUserList 기능을 feature slice로 구현하고자 합니다. 이름에서도 알 수 있듯이 이는 쿼리입니다. 응용 프로그램의 맥락에서 보면 사용자가 UserList를 요청하고 출력물을 기대합니다. 웹 애플리케이션의 경우 사용자가 페이지를 요청하고 UI에서 사용자 목록을 받습니다. 따라서 여기서는 입력, 처리, 출력의 전형적인 패턴을 볼 수 있습니다.

이 간단한 예제를 구현하기 위해 .NET 8을 사용하고 이를 위한 Blazor Web App 프로젝트를 템플릿 기반으로 생성할 것입니다. 설명을 위해 이 예제에서는 Entity Framework InMemory 데이터베이스를 사용하고 일부 생성된 사용자 데이터를 사용할 것입니다. DbContext는 /Infrastructure/Database 폴더에 위치할 것입니다. 이 글에서는 데이터베이스 컨텍스트의 초기화에 대해 자세히 설명하지는 않겠지만, 해당 GitHub 저장소의 일부입니다.

우선 해야 할 일은 필요한 패키지를 추가하는 것입니다. 이것들은 MediatR과 Entity Framework Core 패키지입니다.

```js
dotnet add package MediatR --version 12.1.1
dotnet add package Microsoft.EntityFrameworkCore 
dotnet add package Microsoft.EntityFrameworkCore.InMemory
```

<div class="content-ad"></div>

프로젝트 루트에 새로운 Features 폴더를 추가해 보겠어요. 이 폴더에는 애플리케이션의 모든 기능이 저장될 거에요. 첫 번째 기능인 GetUserList를 추가할 거기 때문에 GetUserList라는 폴더도 함께 만들어 줄 거에요.
첫 번째 단계로는 해당 폴더에 UserList라는 기본 Razor 페이지를 간단히 추가할 거에요. 이 작업은 라우팅이 예상대로 작동하는지 확인하기 위한 것이에요.

```razor
@page "/users"
<h3>User List</h3>

@code {
    
}
```

이렇게 함으로써 애플리케이션을 실행하고 브라우저에서 페이지가 제대로 표시되는지 확인할 수 있어요.

아래 코드에서는 Blazor 웹 앱이 사용자 목록을 가져오는 방법에 대해 살펴볼 거에요. 하지만 이 작업은 컨트롤러 클래스가 필요 없이 깔끔하고 체계적으로 수행됩니다. 여기서 어떤 일이 벌어지고 있는지 살펴보겠습니다:

<div class="content-ad"></div>

사용자에게 요청하기 전에 준비가 돼 있습니다: GetUserListQuery는 종류별로 질의입니다. "안녕, 사용자 목록이 필요하긴 한데 한 번에 특정 수만 (PageSize에요) 가져와주세요. 그리고 보려는 사용자 목록의 페이지를 지정하고 싶어요 (Page에요)." 그 질의 코드는 아주 간단합니다.

```js
// 입력 (요청)
public record GetUserListQuery(int PageSize = 10, int Page = 1) : IRequest<GetUserListViewModel>;
```

IRequest<T> 인터페이스를 구현함으로써 이 요청은 GetUserListViewModel 형태의 응답을 예상한다는 것을 명확히 표현하며, 핸들러가 이행해야 하는 잘 정의된 계약을 보장합니다.

응답 준비: GetUserListViewModel은 GetUserListQuery를 위해 준비하는 응답입니다. 다음과 같이 요약된 시트 형식입니다.

<div class="content-ad"></div>

```js
// 출력 (응답)
public record GetUserListViewModel(IEnumerable<UserViewModel> Users, int TotalRecords, int Page, int TotalPages);
```

보시다시피 요청/응답 모델에 클래스 대신 레코드를 사용했습니다. C#의 레코드는 변경할 수 없는 객체를 정의하는 간결한 방법을 제공하므로 한 번 생성된 요청 또는 응답의 정보는 변경할 수 없어 데이터 처리의 일관성이 보장됩니다.

사용자 각각에 대해 설명: UserViewModel은 각 사용자에 대한 간소화된 프로필입니다. 이것은 우리에게 충분한 정보를 제공하는 이름표 같은 것이며 고유 ID와 사용자의 표시 이름을 제공합니다.

```js
// ViewModel
public record UserViewModel(Guid UserId, string DisplayName);
```

<div class="content-ad"></div>

요청 핸들러: GetUserListRequestHandler는 실제로 일어나는 곳입니다. 이 부분이 요청을 가져와 무엇을 해야할지 알아내는 부분입니다. 모든 사용자 정보가 저장된 데이터베이스와 대화하며 GetUserListQuery를 사용하여 무엇을 찾고 있는지 이해합니다.

```js
// 핸들러, 도메인 로직
public class GetUserListRequestHandler(AppDbContext dbContext) : IRequestHandler<GetUserListQuery, GetUserListViewModel>
{
    public async Task<GetUserListViewModel> Handle(GetUserListQuery request, CancellationToken cancellationToken)
    {
        var pageSize = request.PageSize; // 페이지당 레코드 수
        var pageNumber = request.Page; // 현재 페이지 번호

        var skip = (pageNumber - 1) * pageSize;

        var totalRecords = await dbContext.Users.CountAsync(cancellationToken);

        var users = await dbContext.Users
            .OrderBy(c => c.DisplayName)
            .Skip(skip)
            .Take(pageSize)
            .ToListAsync(cancellationToken);

        // 프로젝션: 결과를 뷰 모델로 매핑
        var viewModels = users.Select(u => new UserViewModel(u.UserId, u.DisplayName)).ToList();

        // 현재 페이지를 위한 뷰 모델 생성
        var totalPages = (int)Math.Ceiling((double)totalRecords / pageSize);
        var viewModel = new GetUserListViewModel(viewModels, totalRecords, pageNumber, totalPages);
        return viewModel;
    }
}
```

이 핸들러 내에서 사용자 목록에서 어디서부터 시작할지(건너 뛰기), 총 사용자 수가 얼마나 되는지(총 레코드) 세고, 페이지 크기와 번호(사용자)에 따라 필요한 사용자 하위 집합 만 가져옵니다.

GetUserListRequestHandler에서 IRequestHandler 인터페이스를 구현하는 것은 이 클래스가 특정 작업을 수행한다는 것을 의미합니다. GetUserListQuery에 응답해야 한다는 약속입니다. 이 핸들러가 이 유형의 요청을 정확히 처리하는 방법을 알고, 처리가 완료되면 GetUserListViewModel을 반환할 것입니다. 이 설계는 더 깔끔한 코드를 가져다줍니다. 각 핸들러가 특정 작업에 특화되어 있어서 이해하고 유지보수하기가 더 쉽습니다.

<div class="content-ad"></div>

MediatR가 요청을 처리하고 응답을 보낼 수 있도록하는 것을 확인하기 위해 program.cs에서 설정해야합니다. program.cs에서 한 줄의 코드로 수행됩니다:

Markdown 형식의 표태그를 로 변경하십시오.

```js
builder.Services.AddMediatR(config => config.RegisterServicesFromAssembly(typeof(Program).Assembly));
```

요청이 들어오면 MediatR은 적절한 핸들러를 찾기 위해 등록을 확인한 후 요청을 전달합니다. 이 등록 프로세스는 MediatR이 응용 프로그램과 원활하게 작동하기 위한 중요한 부분입니다.

그렇다면 요청을 MediatR에게 어디로 보내야하는지 궁금해집니다. UserList.razor 파일로 이동하여 필요한 코드를 다음과 같이 추가해봅시다.

<div class="content-ad"></div>

```js
@page "/users"

@attribute [StreamRendering(true)]
@attribute [RenderModeInteractiveServer]

@using MediatR
@using Microsoft.AspNetCore.Components.Web
@inject IMediator Mediator

<h3>User List</h3>

@if (_model == null)
{
    <p><em>Loading...</em></p>
}
else
{
    <p>User Count: @_model.TotalRecords</p>
    <div class="table-responsive">
        <table class="table mb-0 table-bordered table-hover table-striped small">
            ...
        </table>
        <p role="status">Page: @_currentPage of @_model.TotalPages</p>
        <button disabled="@(_currentPage == 1)" class="btn btn-primary" @onclick="PreviousPage">Previous Page</button>
        <button disabled="@(_currentPage == _model.TotalPages)" class="btn btn-primary" @onclick="NextPage">Next Page</button>
    </div>
}

@code {
    private GetUserListViewModel? _model;
    private int _currentPage = 1;
    private const int PageSize = 10;

    protected override async Task OnInitializedAsync()
    {
        _model = await Mediator.Send(new GetUserListQuery());
    }
    
    private async Task PreviousPage()
    {
        _currentPage--;
        _model = await Mediator.Send(new GetUserListQuery(PageSize, _currentPage));
    }
    
    private async Task NextPage()
    {
        _currentPage++;
        _model = await Mediator.Send(new GetUserListQuery(PageSize, _currentPage));
    }
}
```

UserList.razor Blazor 페이지에서는 사용자 목록을 표시하는 대화형 사용자 인터페이스를 설정했습니다. 이 페이지가 초기화될 때 MediatR에 첫 번째 사용자 데이터 세트를 요청합니다. GetUserListQuery를 사용하여 Mediator.Send를 호출하여 수행됩니다. 데이터가 준비되지 않은 경우에는 로딩 메시지가 표시됩니다. 데이터가 도착하자마자 페이지에 사용자 수, 사용자의 페이지별 표 및 페이지 간 탐색을 위한 버튼이 표시됩니다. '이전 페이지' 또는 '다음 페이지'를 클릭하면 해당 페이지의 데이터를 가져오기 위해 MediatR이 트리거되어 사용자 목록을 최신 상태로 유지합니다. 이는 복잡한 데이터 검색 및 페이지네이션 코드를 작성할 필요 없이 백엔드와 상호 작용하는 부드러운 방법입니다.

그러고 보면, Blazor의 서버 측 렌더링(SSR)의 효율성을 강조합니다. SSR로 인해 Blazor가 서버에서 데이터 검색 및 페이지네이션의 복잡성을 처리하므로 상세한 클라이언트 측 코드가 필요하지 않고 더 부드러운 사용자 경험을 제공할 수 있습니다.

사용자 세부 정보를 보는 다른 기능 슬라이스와의 상호 작용 및 테스트 데이터 생성을 포함한 전체 구현은 GitHub에서 찾을 수 있습니다.


<div class="content-ad"></div>

환영합니다!