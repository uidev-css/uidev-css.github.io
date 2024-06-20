---
title: "제 자동화된 문서 작성 도구로 새로운 Toolips를 만들기"
description: ""
coverImage: "/assets/img/2024-06-19-CreatingMyNewAutomatedDocumentationWithToolips_0.png"
date: 2024-06-19 00:27
ogImage: 
  url: /assets/img/2024-06-19-CreatingMyNewAutomatedDocumentationWithToolips_0.png
tag: Tech
originalTitle: "Creating My New Automated Documentation With Toolips"
link: "https://medium.com/chifi-media/creating-my-new-automated-documentation-with-toolips-3b59f6e35122"
---


## 소개

올해는 기존의 모든 소프트웨어를 패키징하는 데 상당한 노력을 기울이고, 크게 보완하고 있습니다. 내년에는 가정 서버에서 대형 개인 프로젝트를 배포할 수 있기를 희망하며 이를 위해 노력하고 있습니다. 현재 두 개의 생태계에 진입하여 세 번째를 완성하기 위해 노력 중입니다. 그동안 코딩을 하면서 한 가지 미뤘던 일이 있습니다. 아주 큰 생태계를 먼저 만들 것을 기대했던 럭셔리 Toolips를 이용한 소프트웨어 문서 웹사이트입니다.

이 일을 오랫동안 미루었지만, 소프트웨어 문서 웹사이트를 만드는 시간은 항상 다른 곳에 쓸 수 있지만, 문서 웹사이트를 통해 더 많은 사람이 쉽게 내 소프트웨어를 사용할 수 있는 기회가 되기도 합니다. 또한 프로젝트 주변에 더 많은 기술적 글쓰기와 예제를 만들 수 있는 기회를 제공합니다. 이 모든 것을 고려하여, 오늘은 새 프로젝트 ChifiDocs를 만드는 접근 방식에 대해 이야기하겠습니다.

이 프로젝트는 표준 Toolips 방식을 따라 설정됩니다. new_app을 사용하여 앱을 생성한 다음 ToolipsSession을 추가합니다.

<div class="content-ad"></div>

```js
using Toolips; Toolips.new_app("ChifiDocs")
using Pkg; Pkg.add("ToolipsSession")
```

```js
module ChifiDocs
using Toolips
using Toolips.Components
using ToolipsSession

# extensions
logger = Toolips.Logger()
session = Session(["/"])

....

export home, logger, session
end # ChifiDocs <3
```

이제 우리는 Julia 측 백엔드를 만들기 시작할 차례입니다.

## 백엔드


<div class="content-ad"></div>

툴립을 사용하는 가장 큰 장점 중 하나는 백엔드와 프론트엔드가 동일한 위치에 있고 원활하게 연결되어 있다는 것입니다. 많은 웹 개발 경우에 프론트엔드 서비스와 백엔드 서비스 사이에 통신을 하는 반면, 툴립을 사용하면 콜백 이벤트를 등록하고 연결을 제공함으로써 프론트엔드에서 백엔드를 작업할 수 있습니다.

이 문서 웹사이트에 표시하고 싶은 내용에 대한 아이디어가 있으므로, 백엔드에 몇 가지를 추가해야 합니다. 우선, 내 에코시스템을 쉽게 구성하고 모든 패키지 및 내용을 표현하는 쉬운 방법이 있었으면 합니다. 둘째, 탭 기능이 있었으면 하는데 — 비활성 탭을 어딘가에 저장할 방법이 필요하며, 아마도 서버에 저장할 것입니다 (메모리를 보존하고 상대방의 메모리를 사용할 수도 있습니다). 대부분의 경우에 후자가 더 나은 해결책이지만, 이 경우에는 페이지를 메모리에 보관하는 것이 더 합리적인 선택입니다. 왜냐하면 계속해서 다른 클라이언트에게 동일한 페이지를 제공하고 있기 때문입니다. 우리의 백엔드는 이러한 모듈과 이들의 문서를 보관할 데이터를 수용하기 위해 DocModule 및 DocSystem 구조로 시작할 것입니다.

```js
mutable struct DocModule
    mod::Module
    pages::Vector{Component{<:Any}
    mdpath::String
end

mutable struct DocSystem
    name::String
    color::String
    modules::Vector{DocModule}
end
```

제가 생각한 두 구조입니다. DocModule은 모듈, 페이지 및 경로인 mdpath를 보관합니다. DocSystem은 범주별 정보를 갖는 일련의 DocModule을 감싼 것으로, 색상과 표시에 대한 이름을 포함합니다. 이 프로젝트에 필요한 마지막 요소는 이 데이터를 보관할 Toolips 서버 확장 기능입니다. Auth에서 제공되는 인증 데이터를 사용하는 등 다른 옵션이 있지만, 이 경우에는 이 모든 것을 처리할 자체 시스템을 개발하여 사용하겠습니다.

<div class="content-ad"></div>


```js
abstract type AbstractDocClient end

mutable struct DocClient <: AbstractDocClient
    key::String
    tabs::Vector{Component{<:Any}
end

getindex(dc::Vector{<:AbstractDocClient}, ref::String) = begin
    pos = findfirst(cl::AbstractDocClient -> cl.key == ref, dc)
    if isnothing(pos)

    end
    dc[pos]::AbstractDocClient
end

mutable struct ClientDocLoader <: Toolips.AbstractExtension
    docsystems::Vector{DocSystem}
    client_keys::Dict{String, String}
    clients::Vector{DocClient}
    pages::Vector{AbstractComponent}
    ClientDocLoader(docsystems::Vector{DocSystem}) = begin
        pages::Vector{AbstractComponent} = Vector{AbstractComponent}([generate_menu(doc_systems)])
        new(docsystems, Dict{String, String}(), Vector{DocClient}(), pages)::ClientDocLoader
    end
end
```


이제 이 백엔드에서 프론트엔드를 구축하고 올바른 탭을 클라이언트에 제공해야 합니다. 이 모듈에서 메뉴를 구축하는 `generate_menu`로 시작하겠습니다.

```js
function generate_menu(mods::Vector{DocSystem})
    menuholder::Component{:div} = div("mainmenu", align = "center", 
    children = [begin
        mdiv = a(string(menu_mod.name) * "eco", text = "$(menu_mod.name)")
        style!(mdiv, "background-color" => menu_mod.color, 
        "color" => "white", "font-size" => 14pt, "padding" => 10px)
        mdiv::Component{:a}
    end for menu_mod in mods])
    menuholder::Component{:div}
end
```

또한 `ClientDocLoader`에 대한 `Toolips.on_start` 바인딩을 추가하여 서버가 시작될 때 단순히 그것을 Connection 데이터로 푸시합니다.


<div class="content-ad"></div>

```js
function on_start(ext::ClientDocLoader, data::Dict{Symbol, <:Any}, routes::Vector{<:AbstractRoute})
    push!(data, :doc => ext)
end
```

결국, 우리는 각 패키지를 나타내는 더 많은 하위 요소를 생성할 것이며, 이러한 요소를 클릭했을 때 표시됩니다. 또한 generate_tabbar 함수를 추가할 것입니다.

```js
function generate_tabbar(client::DocClient)

end
```

이 함수는 DocClient를 가져와서 탭을 만들 것입니다. 이 함수를 작성하기 전에, 이 모든 것이 어떻게 함께 작동하는지에 대한 보다 명확한 이해를 얻어봅시다.

<div class="content-ad"></div>

```js
function home(c::Toolips.AbstractConnection)
    # 들어오는 클라이언트를 확인합니다.
    client_keys = c[:doc].client_keys
    ip = get_ip(c)
    if ~(ip in keys(client_keys))
        
    end
    key = client_keys[ip]
    client::DocClient = c[:doc].clients[key]
    # 페이지를 구성합니다.
    pages = c[:doc].pages
    tabbar = generate_tabbar(client)
    mainbody::Component{:body} = body("main")
    style!(mainbody, "background-color" => "#333333")
    push!(mainbody, pages["mainmenu"], tabbar)
    write!(c, mainbody)
end
```

이 코드는 꽤 간단한 핸들러입니다. 먼저, 클라이언트가 클라이언트 목록에 등록되었는지 확인합니다. 그렇지 않은 경우 이 조건부에 기본 데이터를 초기화하기 위한 코드가 들어갈 것입니다. 여기서 클라이언트를 로드하고 generate_tabbar를 호출합니다. tabbar와 menu라는 또 다른 변수를 body에 push!하고 Connection에 write!합니다.

이것은 물론 UI를 테스트하고 작동시키기 위한 것입니다. 이제 tabbar를 만들어 봅시다. ClientDocLoader 내에서 menu를 생성하고 있음을 주목해 주세요:

```js
mutable struct ClientDocLoader <: Toolips.AbstractExtension
    docsystems::Vector{DocSystem}
    client_keys::Dict{String, String}
    clients::Vector{DocClient}
    pages::Vector{AbstractComponent}
    ClientDocLoader(docsystems::Vector{DocSystem}) = begin
        pages::Vector{AbstractComponent} = Vector{AbstractComponent}([generate_menu(doc_systems)])
        new(docsystems, Dict{String, String}(), Vector{DocClient}(), pages)::ClientDocLoader
    end
end
```

<div class="content-ad"></div>

실제로 탭바부터 시작하는 게 좋을 것 같아요. 아직 메뉴를 정확히 어떻게 할지 확실하지 않으니까요.

```js
function home(c::Toolips.AbstractConnection)
    # 수신 클라이언트 확인
    client_keys = c[:doc].client_keys
    ip = get_ip(c)
    if ~(ip in keys(client_keys))
        key::String = Toolips.gen_ref(4)
        push!(client_keys, ip => key)
        push!(c[:doc].clients, DocClient(key, [div("maintab", text = "hello world")]))
    end
    key = client_keys[ip]
    client::DocClient = c[:doc].clients[key]
    # 페이지 구성
    pages = c[:doc].pages
    tabbar = generate_tabbar(client)
    mainbody::Component{:body} = body("main")
    style!(mainbody, "background-color" => "#333333")
    push!(mainbody, tabbar)
    write!(c, mainbody)
end
```

해보죠!

```js
include("dev.jl")
```

<div class="content-ad"></div>

이제 간단한 백엔드가 탭 생성 및 메뉴 생성 시스템에 연결되어 있습니다. 다음으로 이 프로젝트의 프론트엔드 부분을 시작하려 합니다. 작은 본문 패널을 만들고 그 위에 탭을 배치할 것입니다.

## 프론트엔드 시작하기

어떻게 구성할지에 대한 아이디어를 꽤 잡았어요. 여기 내 코드 시작 부분입니다:

```js
# 페이지 구성
페이지 = c[:doc].pages
탭바 = generate_tabbar(client)
메인바디::Component{:body} = body("main")
메인컨테이너::Component{:div} = div("main-container")
메인윈도우::Component{:div} = div("main_window")
왼쪽메뉴::Component{:div} = div("left_menu")
style!(메인바디, "background-color" => "#333333")
push!(메인바디, 탭바)
write!(c, 메인바디)
```

<div class="content-ad"></div>

left_menu은 현재 페이지를 탐색하는 메뉴로 사용될 예정이며, main_container는 본문과 탭바를 보유할 것입니다. 나중에 대부분의 기능은 외부 함수로 추출하거나 상황에 따라 미리 만들 것입니다. 그러나 지금은 내가 원하는 대로 빠르게 이것을 작성할 수 있게 해주세요.

```js
function home(c::Toolips.AbstractConnection)
    # 수신 클라이언트 확인
    client_keys = c[:doc].client_keys
    ip = get_ip(c)
    if ~(ip in keys(client_keys))
        key::String = Toolips.gen_ref(4)
        push!(client_keys, ip => key)
        push!(c[:doc].clients, DocClient(key, [div("maintab", text = "hello world")]))
    end
    key = client_keys[ip]
    client::DocClient = c[:doc].clients[key]
    # 페이지 작성
    pages = c[:doc].pages
    mainbody::Component{:body} = body("main", align = "center")
    style!(mainbody, "margin-left" => 5percent, "margin-top" => 5percent, "background-color" => "#333333", "display" => "flex")
    main_container::Component{:div} = div("main-container")
    style!(main_container, "height" => 80percent, "width" => 75percent, "background-color" => "white", "padding" => 0px)
    main_window::Component{:div} = div("main_window")
    tabbar = generate_tabbar(client)
    style!(tabbar, "width" => 50percent)
    push!(main_container, tabbar, main_window)
    left_menu::Component{:div} = div("left_menu")
    style!(left_menu, "width" => 20percent, "height" => 80percent, "background-color" => "darkgray")
    push!(mainbody, left_menu, main_container)
    write!(c, mainbody)
end
```

물론 이 두 가지는 최종적으로 무한한 높이를 갖게 될 것입니다. 여기서 메뉴가 쉽게 맨 위에 올 수 있다고 생각했습니다.

```js
    # 페이지 작성
    pages = c[:doc].pages
    mainbody::Component{:body} = body("main", align = "center")
    style!(mainbody, "margin-left" => 5percent, "margin-top" => 5percent, "background-color" => "#333333", "display" => "flex", 
    "transition" => 1s)
    main_container::Component{:div} = div("main-container")
    style!(main_container, "height" => 80percent, "width" => 75percent, "background-color" => "white", "padding" => 0px, "display" => "flex", "flex-direction" => "column", 
    "border-bottom-right-radius" => 5px, "border-top-right-radius" => 5px, "border" => "2px solid #211f1f", "border-left" => "none", "border-top" => "none")
    main_window::Component{:div} = div("main_window")
    tabbar = generate_tabbar(client)
    style!(tabbar, "width" => 50percent)
    push!(main_container, tabbar, main_window)
    left_menu::Component{:div} = div("left_menu")
    style!(left_menu, "width" => 20percent, "height" => 80percent, "background-color" => "darkgray", "border-bottom-left-radius" => 5px, "border-top-left-radius" => 5px)
    push!(mainbody, pages["mainmenu"], left_menu, main_container)
    write!(c, mainbody)
end
```

<div class="content-ad"></div>

제가 탭에 대해 많은 조정을 했어요:

```js
function generate_tabbar(client::DocClient)
    tabholder::Component{:div} = div("tabs", align = "left",
    children = [begin
        taba = a("tab$(tab.name)", text = "$(tab.name)")
        style!(taba, "padding" => 10px, "font-size" => 13pt, "font-weight" => "bold", 
        "color" => "#333333", "background-color" => "lightgray", "cursor" => "pointer", 
        "border-bottom" => "1px solid #333333", "border-right" => "1px solid #333333")
        taba
    end for (e, tab) in enumerate(client.tabs)])
    childs = tabholder[:children]
    style!(childs[1], "background-color" => "white", "border-bottom" => "0px", 
    "border-top-left-radius" => 10px)
    style!(childs[length(childs)], "border-top-right-radius" => 10px)
    tabholder::Component{:div}
end
```

요것은 여전히 꽤 간단한데, 조금 더 잘 정리하고 싶어하지만 현재 상태에 매우 만족해요.

## back-end II

<div class="content-ad"></div>

우리는 독스트링과 마크다운을 위한 자동화된 문서화 시스템을 만들기 위해 노력 중이에요. 하지만 이를 위해 더 많은 백엔드를 구축할 필요가 있을 거예요. 이 일을 진행하기 위한 첫 번째 단계는 DocModule과 DocSystem 타입을 업데이트하여 필요한 모든 것을 확실히 갖추는 것이에요.

중요한 것은 이 문서 빌더를 실제로 개방적으로 구현하고 싶다는 점이에요. 이 빌더가 Chifi 문서만 생성하는 것이 아니라, 모든 것이 문서 생성기에 로드되기를 원해요. 이에 대한 요구사항은 약간 복잡할 수 있어요. 나의 목표는 각 프로젝트의 데이터를 매핑하는 TOML 구성 파일이 필요하다는 것이죠.

[chifi]
color = "white"
txtcolor = "#333333"
icon = ""

[chifi.Chifi]
path = "toolips/Toolips"
color = ""
pages = ["getting-started", "firstoverview.md"]

[parametric]
color = "#333333"
txtcolor = "white"
icon = ""

[parametric.ParametricProcesses]
color = "#75B2C8"
txtcolor = "white"

[toolips]
color = "#75B2C8"
txtcolor = "white"
icon = ""

[toolips.Toolips]
path = "toolips/Toolips"
color = ""
pages = ["getting-started", "firstoverview.md"]

[toolips.ToolipsSession]
path = "toolips/ToolipsSession"
color = ""
pages = ["nil"]

[gattino]
color = "#C178B5"
txtcolor = "white"
icon = ""

[gattino.Gattino]
path = "gattino/Gattino"
color = ""
pages = ["sample", "gattino.md"]

<div class="content-ad"></div>

다음으로 데이터를 프론트엔드에 채워 넣는 몇 가지 새로운 추가 사항.

```js
function generate_menu(mods::Vector{DocSystem})
    menuholder::Component{:div} = div("mainmenu", align = "center", 
    children = [begin
        mdiv = a(string(menu_mod.name) * "eco", text = "$(menu_mod.name)")
        style!(mdiv, "background-color" => menu_mod.color, 
        "color" => "white", "font-size" => "20pt", "padding" => "14px", "font-weight" => "bold")
        mdiv::Component{:a}
    end for menu_mod in mods])
    style!(menuholder, "position" => "absolute", "top" => "-100", "left" => "0", "width" => "100%", "height" => "0px", 
    "transition" => "800ms")
    menuholder::Component{:div}
end

function generate_menu(dm::Vector{DocModule})
    
end

function switch_tabs!(c::AbstractConnection, cm::ComponentModifier, t::String)

end

function generate_tabbar(c::AbstractConnection, client::DocClient)
    tabholder::Component{:div} = div("tabs", align = "left",
    children = [begin
        labelname = join(split(tab.name, "-")[2:3], " | ")
        taba = a("tab$(tab.name)", text = "$labelname")
        style!(taba, "padding" => "10px", "font-size" => "13pt", "font-weight" => "bold", 
        "color" => "#333333", "background-color" => "lightgray", "cursor" => "pointer", 
        "border-bottom" => "1px solid #333333", "border-right" => "1px solid #333333")
        on(c, taba, "click") do cm::ComponentModifier
            switch_tabs!(c, cm, tab.name)
        end
        taba
    end for (e, tab) in enumerate(client.tabs)])
    childs = tabholder[:children]
    style!(tabholder, "width" => "50%")
    style!(childs[1], "background-color" => "white", "border-bottom" => "0px", 
    "border-top-left-radius" => "10px")
    style!(childs[length(childs)], "border-top-right-radius" => "10px")
    return(tabholder, client.tabs[1].name)
end

function build_main(c::AbstractConnection, client::DocClient)
    tabbar, docname = generate_tabbar(c, client)
    main_container::Component{:div} = div("main-container", children = [tabbar, div("main_window")])
    style!(main_container, "height" => "80%", "width" => "75%", "background-color" => "white", "padding" => "0px", "display" => "flex", "flex-direction" => "column", 
    "border-bottom-right-radius" => "5px", "border-top-right-radius" => "5px", "border" => "2px solid #211f1f", "border-left" => "none", "border-top" => "none")
    return(main_container::Component{:div}, docname)
end

function build_leftmenu(c::AbstractConnection, mod::DocModule)
    [begin 
        pagename = page.name
        openbutton = button("open-$pagename", text = "open")
        labela = a("label-$pagename", text = replace(pagename, "-" => " "))
        pagemenu = div("pagemenu", text = "")
    end for page in mod.pages]
    left_menu::Component{:div} = div("left_menu")
    style!(left_menu, "width" => "20%", "height" => "80%", "background-color" => "darkgray", "border-bottom-left-radius" => "5px", "border-top-left-radius" => "5px")
    left_menu::Component{:div}
end

function home(c::Toolips.AbstractConnection)
    # 수신된 클라이언트 확인
    client_keys::Dict{String, String} = c[:doc].client_keys
    ip::String = get_ip(c)
    if ~(ip in keys(client_keys))
        key::String = Toolips.gen_ref(4)
        push!(client_keys, ip => key)
        push!(c[:doc].clients, DocClient(key, [div("chifi-welcome-Chifi")]))
    end
    key = client_keys[ip]
    client::DocClient = c[:doc].clients[key]
    # 페이지 작성
    pages = c[:doc].pages
    mainbody::Component{:body} = body("main", align = "center")
    style!(mainbody, "margin-left" => "5%", "margin-top" => "5%", "background-color" => "#333333", "display" => "flex", 
    "transition" => "1s")
    main_container::Component{:div}, mod::String = build_main(c, client)
    ecopage = split(mod, "-")
    @info [docmod.name for docmod in c[:doc].docsystems]
    @info [docmod.name for docmod in c[:doc].docsystems["toolips"].modules]
    loaded_page = c[:doc].docsystems[string(ecopage[1])].modules[string(ecopage[3])]
    left_menu = build_leftmenu(c, loaded_page)
    push!(mainbody, pages["mainmenu"], left_menu, main_container)
    write!(c, mainbody)
end
docloader = ClientDocLoader()

function start_from_project(path::String = pwd(), mod::Module = Main; ip::Toolips.IP4 = "127.0.0.1":8000)
    docloader.docsystems = read_doc_config(path * "/config.toml", mod)
    start!(ChifiDocs, ip)
end
```

<div class="content-ad"></div>

@info에 대한 몇 가지 호출도 있습니다. 이는 데이터가 올바르게 로드되었는지 확인하기 위한 점검입니다. 웹 브라우저를 통해 요청을 보냅니다.
```js
julia> include("dev.jl")
  `~/dev/packages/chifi/ChifiDocs`에서 프로젝트를 활성화 중
[ Info: ChifiDocs [4e841206-9f20-48d9-9ddd-dfd252355962] 사전 컴파일 중
  `~/dev/packages/chifi/ChifiDocs/chifi`에서 프로젝트를 활성화 중
┌ Warning: ParametricProcesses에 경로가 없어 건너뛰었습니다
└ @ ChifiDocs ~/dev/packages/chifi/ChifiDocs/src/DocMods.jl:62
🌷 toolips> 로드된 라우터 유형: Vector{Toolips.Route{Toolips.AbstractConnection}
🌷 toolips> 서버가 http://192.168.1.10:8000 에서 수신 대기 중
      활성 매니페스트 파일: 7개 발견됨
      활성 아티팩트 파일: 2개 발견됨
      활성 스크래치 공간: 0개 발견됨
     삭제된 아티팩트, 리포지토리, 패키지 또는 스크래치 공간 없음
[ Info: 수신 대기 중: 192.168.1.10:8000, 스레드 id: 1
   pid              process type             name active
  –––– ––––––––––––––––––––––––– –––––––––––––––– ––––––
  1736 ParametricProcesses.Async ChifiDocs router   true


julia> [ Info: ["gattino", "parametric", "toolips", "chifi"]
[ Info: ["ToolipsSession", "Toolips"]
```

마지막으로 언급할 가치가 있는 것은 이 프로젝트의 설정이 실제로 어떻게 로드되는지입니다. 이 프로젝트에는 두 개의 별도 환경이 있습니다. 하나는 문서화할 모듈을 포함하고 다른 하나는 ChifiDocs 빌드에 필요한 종속성을 포함합니다. 전자는 chifi 아래에 포함되어 있습니다. 또한 이 프로젝트에는 각 생태계를 문서화하기 위한 마크다운 및 에셋이 포함되어 있습니다. 자동 빌드 문서 참조와 기타 자동으로 빌드되는 기능을 원하지만 새로운 튜토리얼 문서를 작성하고 제공할 수 있는 능력도 원합니다.
```js
shell> tree .
.
├── chifi
│   ├── components.jl
│   ├── config.toml
│   ├── getting_started.md
│   ├── Manifest.toml
│   ├── modules
│   │   ├── chifi
│   │   ├── gattino
│   │   │   └── Gattino
│   │   │       └── Gattino.md
│   │   ├── parametric
│   │   │   └── ParametricProcesses
│   │   │       └── ParametricProcesses.md
│   │   └── toolips
│   │       ├── Toolips
│   │       │   └── GettingStarted.md
│   │       └── ToolipsSession
│   │           └── ToolipsSession.md
│   ├── Project.toml
│   └── public
├── dev.jl
├── Manifest.toml
├── Project.toml
└── src
    ├── ChifiDocs.jl
    └── DocMods.jl

13 directories, 14 files
```

<div class="content-ad"></div>

여기가 내 dev.jl 파일이에요:

```julia
using Pkg; Pkg.activate(".")
using ChifiDocs
Pkg.activate("chifi")
using Revise
include("chifi/components.jl")
toolips_process = ChifiDocs.start_from_project("chifi", ChifiDocComponents, ip = "192.168.1.10":8000)
```

그리고 마지막으로 components.jl 파일이에요. 그 파일이 존재하는 이유에 대해 설명하겠습니다.:

```julia
#== components.jl ==
`components.jl`은 이 프로젝트에 특화된 특별한 소스 파일이에요. 이 파일은 dev.jl에서 불러와서 사용되며, 마크다운 문서 페이지에 사용자 정의 구성 요소를 작성하고, 문서 페이지에서 사용할 종속성을 로드할 수 있게 해줘요.
`components.jl` 파일에서는 오직 구성 요소만 내보내야 하며, 이름으로 보간하여 마크다운에서 $를 사용하거나, Julia에서 'interpolate!' 또는 'interpolate_code!'를 사용해야 해요.
`$`.
==#
module ChifiDocComponents
using Toolips
using ToolipsSession
using Gattino

module Chifi

end
end
```

<div class="content-ad"></div>

올 해 제 소프트웨어가 상당히 즐거운 수준에 이르렀어요. Toolips는 함께 작업하기 좋은 웹 개발 프레임워크입니다. Gattino는 이제 사용할 준비가 되었고 두 생태계는 새로운 생태계 추가와 함께 미래의 생태계를 보고 있어요. 그동안 저는 좋은 문서가 필요했었는데, 이제 내가 직접 만들기로 결심했어요.

이 프로젝트는 어느 정도 시간이 걸리겠지만, 최대한 늦어도 6월 말에는 이 문서 브라우저를 공개할 계획이에요 — 많은 기대할 만한 릴리스들과 함께. 곧 다시 다른 생태계와 함께 일할 예정이고, 제 주요 프로젝트인 Olive에 대해 고민해보려 해요. 이미 일부 예비 작업을 시작했는데, IPyCells를 수정하고, OliveHighlighters 패키지를 만들어 하이라이터를 패키징했어요. 그러나 아직 많은 작업이 남아있지만 계속해서 진전을 이뤄가고 그 점이 고맙습니다. 제 진전을 계속 지켜보고 다양한 프로젝트에 관심을 가져주셔서 감사합니다. 올해에는 많은 것들이 더 나아져가고, 올해 말에 제가 더 많은 것들을 제공할 기회를 손에 쥐게 될 것을 기대하고 있어요. 이 프로젝트를 계속할 때 왼쪽 메뉴에 항목을 채우고 내용 영역에 마크다운을 추가할 것이에요. 읽어주셔서 감사합니다!