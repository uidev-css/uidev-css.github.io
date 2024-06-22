---
title: "UDP DNS 서버 시작하기 Nodejs로 쉽게 따라하는 방법"
description: ""
coverImage: "/assets/img/2024-06-22-StartingMyUDPDNSServer_0.png"
date: 2024-06-22 15:49
ogImage: 
  url: /assets/img/2024-06-22-StartingMyUDPDNSServer_0.png
tag: Tech
originalTitle: "Starting My UDP DNS Server"
link: "https://medium.com/chifi-media/starting-my-udp-dns-server-8cc196cffbbc"
---


나의 최근 생태계 업데이트에서는 완료 직전에 있는 여러 패키지를 소개했어요. 해당 업데이트에서 논의된 패키지 중 하나는 현재 Julia General에 병합 중인 새 Toolips 확장 프로그램인 ToolipsUDP입니다. ToolipsUDP는 Toolips 생태계를 만들면서 초기화한 프로젝트인데, 프로젝트에 사용 목적이 없었기 때문에 빨리 만들었어요.

패키지가 현재 등록 중이니, 이제 UDP 서버가 필요한(또는 UDP 서버를 선호하는) 애플리케이션이 있다고 가정하는 것이 적절할 것 같아요. 이 가정은 맞아요. 이 경우의 나의 애플리케이션은 도메인 네임 서버 또는 DNS입니다. 도메인 네임 서버를 처음부터 직접 만들어 보지는 않았지만 이러한 종류의 서버를 실행해 본 경험이 있어요. 몇 가지 예비 연구를 진행했고, 이 프로젝트의 일부 측면은 꽤 복잡하지만 목표는 매우 간단합니다. 받은 요청 헤더를 응답 헤더로 변환하여 다시 보내는 것이죠. 이것은 이 유형의 네트워킹에서 일반적인 것입니다.

오늘 이 프로젝트에 많은 작업을 하지는 않겠지만, 이러한 작업을 용이하게 하는 유형 시스템을 만들기 시작하고, 서버 및 ToolipsUDP를 만드는 것을 시작할 거에요. 오늘 만들 프로젝트 링크는 여기 있어요:

# 프로젝트

<div class="content-ad"></div>

Toolips 프로젝트를 시작하려면 보통 Toolips.new_app 또는 Toolips.new_webapp 함수를 사용합니다. 이 경우, UDPServer를 사용하여 new_app을 만들어야 합니다; 이를 위해, 우리는 new_app에 UDPServer을 제공하기만 하면 됩니다. 시작해 봅시다!

```js
11:58 AM|emma|julia🩷> julia
               _
   _       _ _(_)_     |  문서: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  도움말을 보려면 "?"를 입력하세요, 패키지 도움말을 보려면 "]"를 입력하세요.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  버전 1.9.2 (2023-07-05)
 _/ |\__'_|_|_|\__'_|  |  Fedora 38 빌드
|__/                   |

julia> 
(@v1.9) pkg> add https://github.com/ChifiSource/ToolipsUDP.jl
     Cloning git-repo `https://github.com/ChifiSource/ToolipsUDP.jl`
    Updating git-repo `https://github.com/ChifiSource/ToolipsUDP.jl
```

```js
julia> ToolipsUDP.new_app("ChiNS", UDPServer)
  프로젝트 ChiNS 생성 중:
    ChiNS/Project.toml
    ChiNS/src/ChiNS.jl
  `~/dev/packages/julia/ChiNS`의 프로젝트 활성화 중
    Updating git-repo `https://github.com/ChifiSource/Toolips.jl.git`
...
```

이것은 new_app의 다른 방법이며, 따라서 Toolips에서도 이를 호출할 수 있습니다. 여기서 우리의 새로운 서버 설정을 살펴보세요. 기본 설정에 몇 가지 수정을 가했는데, 아마도 향후 버전에서도 수정될 것입니다.

<div class="content-ad"></div>

```julia
module ChiNS
using Toolips
using ToolipsUDP

function start(ip::String = "127.0.0.1", port::Int64 = 2000)
    myserver = UDPServer() do c::UDPConnection
        println(c.packet)
        println(c.ip)
        println(c.port)
    end
    myserver.start()
    myserver
end

function send_to_my_server(myserver::UDPServer, data::String)
    server2 = UDPServer("127.0.0.1", 2005)
    server2.start()
    ToolipsUDP.send(server2, "test", myserver.host, myserver.port)
end
end # - module
```

dev.jl을 포함하면 우리 서버는 즉시 시작됩니다.

```julia
julia> include("dev.jl")
  Activating project at `~/dev/packages/julia/ChiNS`
[ Info: Precompiling ChiNS [3335ca11-6bce-43d8-b1c1-b64d7d07a7e2]
ToolipsUDP.UDPServer
UDP server: 127.0.0.1:2000
status: active (4)
```

더 흥미로운 일을 위해 다른 터미널에서 클라이언트 서버를 열 것입니다. 이렇게 하면 서버가 무엇을 말하는지 보다 쉽게 파악할 수 있습니다. 같은 터미널에서 두 서버가 병렬로 출력되는 것보다 더 편리합니다.


<div class="content-ad"></div>

```js
julia> using ToolipsUDP

julia> client = UDPServer("127.0.0.1", 2020) do c
           println(c.packet)
       end
UDPServer
UDP 서버: 127.0.0.1:2020
상태: 비활성 (1)
```

서버를 server.start로 시작한 다음 데이터를 보내려면 send를 사용하십시오.

```js
julia> client.start()
Task (runnable) @0x00007f17303fb080

julia> send(client, "hello world", "127.0.0.1", 2000)
```

다른 터미널에서 수신된 포트, 패킷 및 IP가 표시됩니다.

<div class="content-ad"></div>

```js
julia> include("dev.jl")
  Activating project at `~/dev/packages/julia/ChiNS`
[ Info: ChiNS [3335ca11-6bce-43d8-b1c1-b64d7d07a7e2]을 컴파일 중
ToolipsUDP.UDPServer
UDP 서버: 127.0.0.1:2000
상태: 활성화됨 (4)

julia> hello world
127.0.0.1
2020
```

## UDP 예제

다음 예제로 들어가기 전에, 응답이 주어지는 또 다른 간단한 UDP 예제를 시도해보겠습니다. 응답은 send 및 respond를 사용하여 제공할 수 있습니다.send를 사용하면 현재 클라이언트에 직접 보낼 수 있습니다. 이는 UDPConnection, UDPServer 또는 호스트 IP 및 포트로 수동으로 수행할 수 있습니다. respond는 Connection과 응답만 받기 때문에 간단합니다.

```js
function start(ip::String = "127.0.0.1", port::Int64 = 2000)
    myserver = UDPServer() do c::UDPConnection
        name = c.packet
        respond(c, "hello $name!")
    end
    myserver.start()
    myserver
end
```

<div class="content-ad"></div>

핸들러 함수가 없어서 dev.jl과 작업시에 리비전이 변경되지 않습니다. 이 부분은 수정될 예정이지만, 일단은 재시작이 필요합니다.

```js
julia> include("dev.jl")
  `~/dev/packages/julia/ChiNS`에서 프로젝트를 활성화 중
[ Info: ChiNS [3335ca11-6bce-43d8-b1c1-b64d7d07a7e2] 사전 컴파일 중
ToolipsUDP.UDPServer
UDP 서버: 127.0.0.1:2000
상태: 활성 (4)
```

이제 데이터를 전송할 때마다 인사를 받을 수 있습니다.

```js
julia> ToolipsUDP.send(newserv, "emma", "127.0.0.1", 2000)

julia> 안녕 emma ! 
```

<div class="content-ad"></div>

우리의 베이스 프로젝트를 완료하고 ChiNS를 준비하기 위해, 제가 지금까지 한 것을 삭제하고 새 핸들러 함수를 만들겠습니다. 이 함수는 이 프로젝트를 공식적으로 시작하는 데 사용될 것입니다.

```js
module ChiNS
using Toolips

using ToolipsUDP

function handler(c::UDPConnection)
    
end

function start(ip::String = "127.0.0.1", port::Int64 = 2000)
    myserver = UDPServer(handler)
    myserver.start()
    myserver
end

function send_to_my_server(myserver::UDPServer, data::String)
    server2 = UDPServer("127.0.0.1", 2005)
    server2.start()
    ToolipsUDP.send(server2, "test", myserver.host, myserver.port)
end

end # - module
```

## DNS 헤더

과거에 이름 서버를 호스팅한 적이 있지만, 이번이 확실히 처음으로 서버를 만드는 것입니다. 사실, 이는 저에게 접속 없는 네트워킹에서 이 정도로 저수준으로 작업하는 것은 처음이죠 (통합 API의 일부로 고수준 UDP 네트워킹을 한 적은 있지만 그 자체로 한 적은 없습니다). 그렇기 때문에 이 주제가 제게 새롭기 때문에 DNS 패킷 구조에 대한 이 개요는 이 프로젝트를 진행하는 데 매우 유용했습니다.

<div class="content-ad"></div>

고려할 점은, 먼저 해야 할 일은 이 문서의 두 번째 페이지에 자세히 설명된 응답 필드를 복제하기 위해 노력해야 한다는 것입니다. 이를 위해 데이터 구조를 사용할 것이므로, 그것이 많은 일을 훨씬 쉽게 만들 것으로 생각합니다. DNS 패킷 구조를 복제하면서 전체 응답 구조를 만들기 시작하겠습니다. 이 네임 서버는 서버가 컨트롤하는 도메인에만 사용되도록 의도되었기 때문에 권한(Authority)이나 추가(Additional)와 같은 필드들과 작업할 필요는 없을 것입니다. 하지만 시간이 지남에 따라 이러한 필드들이 추가될 수 있습니다. 이 유형의 서버의 좋은 점은 꽤 멋진 네임 서버를 만들어내기 위해 충분히 실현 가능한 최소 기능 제품이 있다는 것입니다. 이에 대해 고려할 때, 우리의 DNSResponse 구조는 상당히 간단합니다.

```js
mutable struct DNSResponse
    header::DNSHeader
    question::Any
    answer::Any
end
```

또한 DNSHeader 구조가 필요합니다. 질문과 답변의 타이핑이 정확히 무엇인지 확신할 수 없으므로, 현재 이 필드들은 Any로 설정되어 있습니다. 시작하는 데 주된 관심사는 물론 DNSHeader입니다. DNSHeader 유형의 구조에는 사용하지 않을 많은 필드들이 있습니다. 그러나 구현을 위해 이러한 모든 필드들을 DNSHeader에 넣고 현재 필드들을 간소화하기 위해 내부 생성자를 사용할 것입니다. 여기서 시작하는 것만 기억해주시기 바랍니다. 디자인의 많은 측면이 불확실하기 때문에 이러한 것들을 많이 변경하게 될 것이라고 확신합니다.

```js
mutable struct DNSFlags
    QR::Bool
    opcode::Int64
    AA::Bool
    TC::Bool
    RD::Bool
    RA::Bool
    RCOD::Int64
end

mutable struct DNSHeader
    ID::String
    flags::DNSFlags
    QDCOUNT::String
    ANCOUNT::String
    NSCOUNT::String
    ARCOUNT::String
end

mutable struct DNSResponse
    header::DNSHeader
    question::Any
    answer::Any
end
```

<div class="content-ad"></div>

모든 필드를 간단히 살펴봅시다.

- QR은 쿼리인지 응답인지를 지정합니다.
- opcode는 사용할 쿼리 유형을 나타냅니다.
- AA는 서버가 권위 있는지 여부입니다.
- TC는 데이터가 잘린 여부를 나타냅니다.
- RD는 클라이언트가 재귀를 요청했는지 여부를 나타냅니다.
- RA는 재귀 사용 가능 여부를 클라이언트에게 알려주는 응답입니다.
- RCOD는 우리의 응답 코드입니다.

- ID는 트랜잭션 ID로, 두 서버가 올바르게 통신 중임을 인식합니다.
- flags는 우리의 플래그입니다.
- QDCOUNT는 질문 수를 나타내는데, 대부분은 하나일 것입니다.
- ANCOUNT는 응답 수입니다.
- NSCOUNT는 네임 서버 개수입니다.
- ARCOUNT는 추가적인 리소스 레코드의 수입니다.

이러한 데이터를 고려할 때, 최소 기능 제품을 얻기 위해 몇 가지 필드만 사용할 것입니다. 또한, DNSQuestion 및 DNSHeader 유형을 최종적으로 생성할 것입니다. 지금은 조금 돌아가서 응답 작업을 시작하겠습니다. 필드 섹션에서 언급했듯이, 트랜잭션 ID는 16옥텟(비트) 또는 두 바이트입니다. 8의 배수일 때 데이터를 나누지 않고 데이터를 검색할 수 있어 좋습니다. 이에 맞게 데이터의 첫 두 글자를 가져와서 이를 출력하겠습니다.

<div class="content-ad"></div>

```js
function build_response(data::String)
    tid = data[1:2]
    println(tid)
end

function handler(c::UDPConnection)
    response = build_response(c.packet)
end
```

이제 DNS를 실제로 테스트하기 위해 dig를 사용할 것입니다. dig 서비스는 DNS 서버를 프로파일링하고 진행 상황을 테스트하기 위해 헤더를 보낼 수 있는 간단한 DNS 클라이언트입니다. 이를 위해 dig는 두 가지 인수를 가져야 합니다 — 호스트 이름과 IP입니다. 또한 서버의 포트를 54로 설정해주어야 합니다. 이는 포트 80 아래에 있기 때문에 방화벽 구성도 필요합니다. 이름을 출력해보겠습니다. 한 터미널에서 서버 버전을 시작했습니다. 그리고 여기서 dig를 사용했습니다.

```js
02:00 PM|emma|~🩷> dig chifi.dev @127.0.0.1
;; 통신 오류 127.0.0.1#53: 시간이 초과되었습니다
```

서버가 요청에 아직 응답하지 않았기 때문에 몇 초 후에 시간 초과가 발생했습니다. Julia REPL에서 거래 ID를 출력합니다.

<div class="content-ad"></div>

```js
julia> U�
```

## 플래그

우리가 만들어야 하는 헤더의 다음 부분은 플래그의 행입니다. 지난 예제는 꽤 간단했지만, 우리는 두 바이트만 가져오면 되었습니다. 이번에는 우리의 코드를 옥텟으로 나눠야 할 것입니다. 세 번째 바이트부터 다섯 번째까지 데이터가 제공되는 새로운 함수를 만들 것인데, 플래그 섹션도 두 바이트이기 때문입니다.

```js
function build_response(data::String)
    tid = data[1:2]
    println("Transaction ID: ", tid)
    flags = build_flags(data[3:5])
end
```

<div class="content-ad"></div>

우리 국기 작업을 시작하려면 코드를 옥텟으로 나눠 보겠습니다:

```js
function build_flags(data::String)
    bits = join([bitstring(s) for s in Vector{UInt8}(data)])
end
```

이제 필요한 각 필드의 비트를 간단히 색인하겠습니다. 또한 parse를 사용하여 타입을 구문 분석하고, DNSFlags를 구성하기 위한 준비를 하겠습니다.

```js
function build_flags(data::String)
    bits = join([bitstring(s) for s in Vector{UInt8}(data)])
    println("질의/응답: ", bits[1])
    println("opcode: ", parse(Int64, bits[2:5]))
    println("AA: ", parse(Bool, bits[6]))
    println("TC: ", parse(Bool, bits[7]))
    println("RD: ", parse(Bool, bits[8]))
    println("RA: ", parse(Bool, bits[9]))
    println("Z: ", String(bits[10:12]))
    println("응답 코드: ", String(bits[13:16]))
end
```

<div class="content-ad"></div>

자요! 다시 쿼리에 대답해 보는 것을 시도해 봅시다.

```js
Transaction ID: �4
0
Query/response: 0
opcode: 0
AA: false
TC: false
RD: true
RA: false
Z: 010
Response code: 0000
```

잘 되었네요! 이제 모든 플래그가 완료되었고, 이 데이터를 DNSFlags 생성자에 시간에 맞춰 삽입하는 것만 남았습니다.

```js
function build_flags(data::String)
    bits::String = join([bitstring(s) for s in Vector{UInt8}(data)])
    DNSFlags(parse(Bool, bits[1]), parse(Int64, bits[2:5]), parse(Bool, bits[6]), parse(Bool, bits[7]), parse(Bool, bits[8]),
    parse(Bool, bits[9]), String(bits[10:12]), parse(Int64, bits[13:16]))::DNSFlags
end
```

<div class="content-ad"></div>

이제 build_response 함수에는 ID와 플래그를 받는 핸들러가 있습니다.

```js
function build_response(data::String)
    tid = data[1:2]
    println("Transaction ID: ", tid)
    flags::DNSFlags = build_flags(data[3:5])
    
end
```

이제 DNSHeader를 구성하기 위해 QDCOUNT, ANCOUNT, NSCOUNT 및 ARCOUNT가 필요합니다.

```js
mutable struct DNSHeader
    ID::String
    flags::DNSFlags
    QDCOUNT::String
    ANCOUNT::String
    NSCOUNT::String
    ARCOUNT::String
end
```

<div class="content-ad"></div>

일단 헤더를 구축하는 것으로 여기에서 마무리하겠습니다. 이 프로젝트를 곧 더 개발할 계획이며, 이 프로젝트의 개발은 한동안 계속될 것으로 예상됩니다. 궁극적으로 목표는 이 프로젝트를 2월까지 완료하는 것이라, 모든 것을 고려할 때 정말 순조롭게 진행 중입니다. 물론 상황이 더 복잡해질 것으로 상상하고 있지만, 지금까지 이 프로젝트는 정말 재미있었고 실행 중이라는 점이 정말 기쁩니다.

ToolipsUDP 또한 작동 중입니다. ToolipsUDP 인터페이스에 대해 많은 것을 좋아합니다. 특히 응답 및 UDP 연결 기능의 간결함을 정말 좋아합니다. 그러나 이 초기 버전에서 초기 결함이 분명히 느껴졌습니다. 첫째, 기본 앱이 그리 좋지 않았습니다. UDP로 개발하기에 적합한 기반이 제공되지 않았고 UDP 프로젝트를 대상으로 한 것으로 보였습니다. ToolipsUDP를 더 많이 작업하면 변화할 것입니다. 또한 정말 거슬리는 것은 오류 처리 부분이 매우 부족하다는 것입니다. 이 기본 버전의 ToolipsUDP는 이 프로젝트를 충분히 지원할 수 있지만, 상황은 패키지 업데이트로 더 원할하게 진행될 것이고, 시간이 지날수록 반드시 업데이트를 계속할 것입니다.

## 네트워크 서버의 끝

<img src="/assets/img/2024-06-22-StartingMyUDPDNSServer_0.png" />

<div class="content-ad"></div>

이 글에서 마지막으로 이야기하고 싶은 것은, 도메인 네임 서버를 비롯한 내 네트워크 애플리케이션에 사용할 좋은 작은 서버를 구입했다는 것입니다. 이 서버는 25달러에 구매했어요.

그래서 저는 쿼드 코어 제온을 얻었어요 - 정확한 모델은 기억하지 못하고, 이 기기를 제대로 켜본 적이 없어요 (VGA 케이블이 없어요) 하지만 클럭 속도는 대략 3.5 GHz 정도로 보입니다. 이 서버는 작은 350w 파워 서플라이가 달려 있어요 (저는 이 상황에 이상적으로 생각해요,) 그리고 8GB RAM이 달려 있고 최대 32GB까지 확장할 수 있어요. 또한 서버에 라이저가 함께 제공되었는데, 이는 약 2인치 정도로 카드를 지원할 수 있어요. 물론, 거기서의 도전은 파워 서플라이와 파워 부족이에요. 저는 파워칼러 레드 드래곤 로우 프로파일 5500XT를 검토했었는데, 이 카드는 모든 조건을 만족해요 —

- AMD (리눅스)
- 꽤 강력한 카드, 사실
- 작음
- 파워 연결포트 없음

그러나 이렇게 되면 나 자신에게 조금 더 이상을 이유로 해야겠죠; 이 기기에 정말 그래픽 카드가 필요한가? 제 마음속에선 멋지기 때문에 원하는 거예요 - 그리고 또한, 설정을 마친 후에 다시 연결해야 할 필요가 생길 때 VGA 디스플레이 이상을 갖는 것이 유용할 것 같아요. 그러나 이렇게 되면 TDP가 늘어나고, 거의 항상 모니터를 사용하지 않을 것인데 그TDP 증가를 감당할 가치가 있는지 모르겠어요. 물론, OpenCL이 있지만, 이 서버는 네트워크 애플리케이션용으로 계획된 서버이고 "중량 화물을 옮기는" 서버는 아니에요.

<div class="content-ad"></div>

내 계획에 대한 감을 줄이기 위해 말하자면, 하나의 서버가 간단한 응용 프로그램, 엔드포인트, 데이터베이스 및 DNS를 관리하게 할 계획입니다. 이 서버는 괴물이 될 필요가 없어요. DNS 및 API 요청을 빠르게 처리할 정도로 빠르지만 계산할 양이 많지 않거나 메모리에 저장할 데이터가 많지는 않을 거에요. 이 외에 두 번째 서버가 있을 예정인데, 이 서버에는 두 개의 프로세서와 최소한 200GB의 메모리가 필요합니다. 이 용도로 살펴본 모델들은 보통 총 400GB 정도의 메모리를 제공합니다.

말할 필요도 없이, 이 모든 프로젝트를 배포하기 위해 앞으로 많은 작업이 남아 있습니다. 꽤 중요한 웹 생태계의 소프트웨어 및 하드웨어 부분을 상당히 빠르게 구축 중이며, 정말 기대돼요. 다음 프로젝트 업데이트에서 더 많은 정보를 공유할 때까지 기다릴 수 없어요. 좋은 하루 보내세요!