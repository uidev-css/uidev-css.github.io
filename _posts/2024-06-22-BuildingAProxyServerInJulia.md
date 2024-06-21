---
title: "Julia로 프록시 서버 구축하는 방법"
description: ""
coverImage: "/assets/img/2024-06-22-BuildingAProxyServerInJulia_0.png"
date: 2024-06-22 04:15
ogImage: 
  url: /assets/img/2024-06-22-BuildingAProxyServerInJulia_0.png
tag: Tech
originalTitle: "Building A Proxy Server In Julia"
link: "https://medium.com/chifi-media/building-a-proxy-server-in-julia-9a6e39d5803c"
---


올해에 서버 및 웹사이트를 배포하는 데 중요한 계획이 있어요. 1년 반 동안 데이터 과학 관점에서 웹 개발을 위해 타깃으로 삼는 줄리아 모듈 시리즈를 개발해 왔어요. 이러한 모듈들이 결합되어 상호 연결된 서버 시스템을 형성하고 이를 올해 초에 배포할 계획입니다. Chifi, Toolips, Olive와 관련해서는 2024년이 될 것입니다. 이 웹 시스템을 용이하게 지원하기 위해 만들어 놓은 생태계 개요를 확인하고 싶다면, chifi README가 좋은 시작점이에요:

Laboratory의 배포를 용이하게 하기 위해, 서버 시스템이 인터넷과 통신할 필요가 있어요. 컴퓨터가 인터넷을 통해 다른 컴퓨터에 연결하는 데 필요한 여러 단계가 있고, 이 모든 단계에 대해 제 프로젝트를 직접 개발할 계획입니다.

# 인터넷 서버

인터넷은 표준화된 프로토콜 세트로, 컴퓨터가 다른 포트에 정렬된 다양한 헤더와 프로토콜을 사용하여 통신할 수 있게 합니다. 웹 기반 TCP 연결의 라우팅을 용이하게 하기 위해 사용되는 서로 다른 유형의 서버가 몇 가지 있어요. 표준 네트워킹 설정에 따라, 사용자를 URL 창에서 웹 페이지로 이동시키기 위한 과정 모두에 주소할 수 있는 다음 서버들이 일부입니다:

<div class="content-ad"></div>

- 최상위 도메인(TLD) 이름 서버
- 동적 호스트 컨트롤 프로토콜(DHCP) 서버
- (도메인) 이름 서버(DNS)
- 웹 서버(HTTP 서버)

이 네 가지 서버 유형 중 두 가지는 서버를 인터넷에 연결하는 데 필요합니다. 이것들은 DHCP 서버와 웹 서버입니다. DHCP 서버는 집 네트워크에서 인터넷으로의 인터페이스이며, 이 서버는 연결된 각 클라이언트에 대해 외부 주소를 할당합니다. 이 주소는 네트워크 주소라고 합니다. 네트워크 주소는 두 가지 주소 유형 중 하나이며, 이는 인터넷 프로토콜에서 귀하의 서버를 다른 모든 서버와 명명하는 데 사용됩니다. 이러한 주소 유형은 각각 인터넷 프로토콜 버전 4와 인터넷 프로토콜 버전 6 (IPv4; IPv6)입니다.

DHCP 서버는 넓은 인터넷, 로컬 네트워크 연결 및 귀하의 기기 간의 중개자 역할을 합니다. 이 서버는 귀하의 기기를 가져오고, 로컬 영역 네트워크(LAN)와 상호 작용하는 주소를 할당하며, 웹과 상호 작용하는 또 다른 주소를 할당합니다. 후자는 외부 또는 공용 IP 주소라고 하며, 전자는 로컬 IP 주소입니다.

![image](/assets/img/2024-06-22-BuildingAProxyServerInJulia_0.png)

<div class="content-ad"></div>

라우터는 DHCP 서버를 호스팅하기 위해 설계된 작은 기계입니다. 대부분의 경우, 라우터는 DHCP와 함께 웹 서버도 호스팅하며, 이를 통해 DHCP 서버를 구성할 수 있습니다. 이 웹 서버는 대중적으로 Default Gateway로 알려져 있으며, DHCP가 할당된 IP 주소의 라우터에 위치합니다.

웹 브라우저에 Default Gateway를 입력하여 이 서버의 웹 인터페이스에 방문할 수 있습니다. 이 Default Gateway는 DHCP 서버를 실행 중인 라우터의 로컬 IP이며, DHCP 서버는 서버 측에서 포트 67을 사용합니다. 이 인터페이스를 통해 DHCP 서버를 구성할 수 있으며, 인터넷으로 다시 전달되는 포트를 포워딩할 수 있습니다. 네트워크의 Default Gateway에 액세스하려면 다음 명령어를 사용하실 수 있습니다.

- Linux — ip route
- Windows — ipconfig
- OSx — netstat -nr

URL은 프로토콜(http/https), 서브도메인, 도메인 이름, 최상위 도메인(TLD), 대상 또는 경로 및 매개변수 네 가지 부분으로 구성되어 있습니다. 서브도메인과 매개변수는 이 퍼즐의 선택적인 부분이므로, 이에 대해 집중해 보겠습니다.

<div class="content-ad"></div>

- 도메인 (name.tld)
- 타겟
- 아규먼트

타겟과 아규먼트는 저희 웹 서버에서 처리되지만, 도메인은 DNS 서버에서 처리됩니다. 웹 브라우저에 URL을 입력하고 브라우저를 탐색할 때, 웹 브라우저는 TLD 네임 서버에 핑을 보냅니다. TLD 서버는 TLD 앞에 입력된 이름과 관련된 DNS에 대한 정보를 반환합니다. 이후 사용자는 TLD 서버에서 반환된 DNS 서버로 이동합니다. 그런 다음 DNS 서버는 그러한 이름을 로컬 IP로 라우팅합니다. 마지막으로 DNS 서버가 이 주소의 서버의 IP 및 포트를 반환한 후, 웹 브라우저는 해당 주소로 서브도메인 및 도메인 이름을 사용하여 이동합니다. 이름 서버에 대해 더 알고 싶다면, 저는 실제로 그 중 하나를 작성 중이고, 해당 프로젝트에 대해 작성한 두 부분을 여기에서 읽을 수 있습니다:

위에서 언급된 서버들은 웹 서버를 호스팅하는 데 필수적이지만, 웹 개발에서 모두 다른 중요한 사용 사례를 가진 이러한 유형의 연결을 용이하게 하는 다양한 선택적 옵션이 있습니다. 더 고급 서버 인프라를 만드는 데 큰 도움이 되는 서버의 한 예로 프록시 서버라는 것이 있습니다.

## 프록시 서버란 무엇인가요?

<div class="content-ad"></div>

"프록시" 라는 단어는 다른 개체를 대표하는 것을 의미합니다. 예를 들어, 프록시 투표는 다른 사람이 내가 되는 척하여 투표한 투표를 나타냅니다. 컴퓨팅에서, 프록시 애플리케이션은 애플리케이션을 실행하는 데 사용되는 애플리케이션으로, 이상적으로는 해당 애플리케이션을 협박하게 합니다. 이 비유에서 투표는 우리의 애플리케이션이고, 프록시는 프록시 서버입니다. 왜 프록시 서버가 필요한지 이해하기 위해서는 우리의 애플리케이션을 고려하는 것이 타당합니다.

우리의 도메인은 서버를 우리 IP로 연결할 것입니다 — 여기서 IP는 단순히 도메인이 연결된 기계를 가리킵니다. 각 포트에는 하나의 서버만 실행될 수 있다는 점을 염두에 두십시오. 웹 서버의 경우 포트는 항상 80이므로, 우리는 https://IP:80 에 하나의 서버만 배포할 수 있습니다. 이는 하나의 애플리케이션을 실행하려면 괜찮지만, 여러 애플리케이션을 실행하려면 새로운 IP — 전혀 새로운 컴퓨터가 필요하다는 것을 의미합니다. 물론 가상 IP 옵션도 있지만, 이 경우에서 가장 좋은 옵션은 다른 방법을 사용하는 것입니다.

프록시 서버는 이 문제에 대한 인터넷의 표준적인 해결책입니다. 프록시 서버는 대상 이름에 대해 여러 서버 주소를 등록하고 요청 시에 해당 서버로 프록시 패스를 수행합니다. 현재 사용되는 대부분의 표준 프록시 서버는 SSL 및 부하 분산 기능과 결합되어 있습니다. 널리 사용되는 프록시 서버의 예로는 NGINX가 있습니다.

## 부하 분산기란 무엇인가요?

<div class="content-ad"></div>

서버가 종종 거대한 기계일 때 이유가 있습니다. 이론적으로 무한대의 클라이언트 목록을 제공하기 위해서는 많은 처리 능력이 필요합니다. 로드 밸런서가 없는 서버 시스템은 특정 도메인이나 IP를 요청하는 모든 클라이언트를 특정 서버로 보냅니다. 로드 밸런서가있는 서버 시스템은 들어오는 사용자를 여러 서버로 분산합니다. 이는 유용하며 프록시 서버의 사용 사례에 인접하기 때문에 로드 밸런싱은 프록시 서버 위에 쉽게 구현할 수 있습니다.

# ChiProxy.jl

오늘은 이 두 가지 개념을 결합하여 프록시 서버를 만들고, 최종적으로 SSL, 로드 밸런싱 및 더 많은 기능을 추가할 의도로 확장 가능한 프록시 라우팅 플랫폼에 프록시 서버를 만들겠습니다. 이 프로젝트는 ChiProxy 라고 부르겠습니다.

![image](/assets/img/2024-06-22-BuildingAProxyServerInJulia_1.png)

<div class="content-ad"></div>

# 프록시 서버 구축

프록시 서버는 놀라울 정도로 유용하고 흥미로운 기능을 가지고 있지만, 복잡한 것은 아닙니다. 다행히도 나의 신경 쓸 부분은 없으며, 간단한 프록시 서버에서 데이터 전송 시 검토해야 할 헤더나 RST는 없습니다. 프록시 서버에서 우리가 정말로 해야 할 일은 들어오는 연결을 저장된 서버 주소(및 포트)로 보내는 것뿐입니다. 이를 어떻게 할지에 대한 몇 가지 아이디어가 있습니다. 특히 줄리아 타입 시스템 및 Toolips 하에서 어떻게 할지에 대한 아이디어가 있습니다. 이 단계로 진입하기 전에, 내 웹 개발 프레임워크의 발전에서 다음 중요 단계를 소개하고 싶습니다.

![프록시 서버 구축](/assets/img/2024-06-22-BuildingAProxyServerInJulia_2.png)

이 프로젝트에서는 새롭고 개선된 Toolips의 중대 버전을 사용할 것입니다! 이 중대 한 릴리스는 Toolips의 기본 컨셉을 달성했던 0.2와는 달리 0.3에서 컨셉을 아주 잘 달성했습니다. 시작 프로젝트도 이를 잘 반영한 것으로 생각됩니다. 그래서 새로운 앱인 ChiProxy를 생성해 보겠습니다.

<div class="content-ad"></div>


```js
using Toolips
Toolips.new_app("ChiProxy")
```

이제 기본 프로젝트를 살펴보겠습니다.

```js
module ChiProxy
using Toolips

# routes
main = route("/") do c::Connection
    write!(c, "hello world!")
end

# 404
err_404 = Toolips.default_404

export main, err_404
end
```

이것을 예전 Toolips와 비교해 보면...


<div class="content-ad"></div>

```js
module ProgressTest
using Toolips
using ToolipsSession
using ToolipsCoolProgress
# 새로운 Toolips 프로젝트에 오신 것을 환영합니다!
"""
home(c::Connection) -> _
--------------------
home 함수는 기본적으로 서버 내에서 라우트로 제공됩니다. 이를 변경하려면 아래의 start 메서드를 확인하십시오.
"""
function home(c::Connection)
    prog = ToolipsCoolProgress.circular_progress("test")
    on(c, prog, "click") do cm::ComponentModifier
        update_progress!(cm, prog, 50)
    end
    write!(c, p("helloworld", text = "hello world!"))
    write!(c, prog)
end

fourofour = route("404") do c
    write!(c, p("404message", text = "404, not found!"))
end

routes = [route("/", home), fourofour]
extensions = Vector{ServerExtension}([Logger(), Files(), Session(), ])

"""
start(IP::String, PORT::Integer, ) -> ::ToolipsServer
--------------------
start 함수는 WebServer를 시작합니다.
"""
function start(IP::String = "127.0.0.1", PORT::Integer = 8000)
     ws = WebServer(IP, PORT, routes = routes, extensions = extensions)
     ws.start(); ws
end


end # - module
```

이 버전은 이해하기 훨씬 쉽고, 훨씬 간결하며 — 확장부터 라우팅까지 모두 완전히 자동으로 처리됩니다. 이번 릴리스에 대한 자세한 정보가 포함된 개요를 곧 공개할 예정입니다.

이 문제에 대한 내 접근 방식은 AbstractRoute 디스패치 아래에 여러 디스패치를 사용하는 것입니다. Toolips 0.3은 모듈 내에 정의된 모든 AbstractRoute을 찾아내기 때문에, 간단히 새로운 라우트 유형을 만들어서 라우트의 기능을 변경할 수 있습니다. 우리 프로젝트에서는 추상 타입 AbstractProxyRoute로 시작할 것입니다. 새로운 프로젝트로 아직 라우트를 생성하지 않을 것이며, 대신 서버 레코드를 간단하게 만들어 프록시 서버가 인식할 수 있도록 하는 기본적인 타입 시스템을 만들 것입니다.

```js
abstract type AbstractProxyRoute <: Toolips.AbstractRoute end
```

<div class="content-ad"></div>

## 프록시 라우트

이 새로운 추상 타입을 기억하며, ProxyRoute를 상상해봅니다 — ProxyRoute에는 어떤 데이터가 필요할까요? AbstractRoute의 일관성을 확인하기 위해 ?를 사용할 수 있습니다:

```js
help?> Toolips.AbstractRoute
```

그래서 필요한 두 가지 일관성은 경로(path)와 route!로의 디스패치입니다. 구조를 시작해봅시다.

<div class="content-ad"></div>

```js
module ChiProxy
using Toolips

abstract type AbstractProxyRoute <: Toolips.AbstractRoute end

mutable struct ProxyRoute <: AbstractProxyRoute
    path::String
end

# routes
main = route("/") do c::Connection
    write!(c, "hello world!")
end

# 404
err_404 = Toolips.default_404

start(IP::String = "127.0.0.1", PORT::Integer = 8000) = start!(ChiProxy, IP, PORT)
end
```

자, 우리가 일관된 구조를 가진 라우팅을 가지게 되었으니, route!를 가져와 확장할 것입니다. route! 함수를 확장함으로써 우리는 두 가지를 할 수 있게 됩니다:

- 새로운 라우터 생성.
- 단일 라우트 기능 변경.

```js
import Toolips: route!
```

<div class="content-ad"></div>

라우터 기능을 변경하려면 경로로 이동하며, 경로는 두 번 호출됩니다 - 벡터에서 한 번 호출되고, 그런 다음 다시 경로로 호출됩니다. 이에 대한 코드를 아래에서 확인하세요:

```js
module ChiProxy
using Toolips
import Toolips: route!

abstract type AbstractProxyRoute <: Toolips.AbstractRoute end

mutable struct ProxyRoute <: AbstractProxyRoute
    path::String
end

function route!(c::Toolips.AbstractConnection, pr::AbstractProxyRoute)
    write!(c, "</br>수정된 `ProxyRoute` 페이지")
end

function route!(c::Connection, vec::Vector{<:AbstractProxyRoute})
    write!(c, Components.DOCTYPE())
    write!(c, "`Connection` 라우터를 수정합니다.")
    route!(c, pr)
end
```

우리의 벡터는 라우트에 해당하는 높은 추상 유형으로 유지되어야 하므로 이를 기억해 주세요 - Vector'Union'... 으로 경로를 설정할 수 있습니다. 일반적으로 Julia 타입 추상화를 사용하며, AbstractRoute s의 벡터가 어떠한 특정 배열 차원인지에 따라 진행할 수 있습니다.

라우트는 내보낸 경우에만 경로 설정됩니다. ProxyRoute 를 구성하고 내보내므로 이를 빠르게 테스트할 수 있습니다.

<div class="content-ad"></div>


```js
test = ProxyRoute("/")
```

```js
module ChiProxy
using Toolips
import Toolips: route!

abstract type AbstractProxyRoute <: Toolips.AbstractRoute end

mutable struct ProxyRoute <: AbstractProxyRoute
    path::String
end

function route!(c::Toolips.AbstractConnection, pr::AbstractProxyRoute)
    write!(c, "</br>our modified `ProxyRoute` page")
end

function route!(c::Connection, vec::Vector{<:AbstractProxyRoute})
    write!(c, Components.DOCTYPE())
    write!(c, "our modified `Connection` router.")
            # indexing our routes with our `Connection's` route
    route!(c, vec[get_route(c)])
end
main = route("/") do c::Connection
    write!(c, "$(c.routes)")
end

test = ProxyRoute("/")
# 404
err_404 = Toolips.default_404

export test
end
```

이제 서버를 시작하여 라우터에 대한 메시지 하나와 Route에 대한 메시지 하나를 작성해야합니다.

```js
include("dev.jl")
``` 


<div class="content-ad"></div>


![image](/assets/img/2024-06-22-BuildingAProxyServerInJulia_3.png)

여기서 필요한 마지막 것은 호스트입니다. 이는 get_host를 통해 얻을 수 있습니다.

```js
function route!(c::Toolips.AbstractConnection, pr::AbstractProxyRoute)
    system = Toolips.get_client_system(c)
    mobile = "not mobile"
    if system[2]
        mobile = "mobile"
    end
    write!(c, "</br>our modified 'ProxyRoute' page<h3>host:</h3>")
    write!(c, get_host(c))
end
```

![image](/assets/img/2024-06-22-BuildingAProxyServerInJulia_4.png)


<div class="content-ad"></div>

이제 라우팅 시스템이 설정되었고 호스트 이름을 가지고 있으니, 기본 프록시 시스템을 확장할 수 있는 ProxyRoute의 필드를 확장할 것입니다. 이 경우에 경로가 호스트 이름이 될 것입니다. 여기서 이름의 트래픽을 리디렉트할 IP와 포트를 가져올 것입니다.

```js
abstract type AbstractProxyRoute <: Toolips.AbstractRoute end

mutable struct ProxyRoute <: AbstractProxyRoute
    path::String
    ip::String
    port::Int64
end
```

새로운 필드인 ip와 port를 가지고 하위 함수를 만들어 이 유형을 쉽게 만들 것입니다.

```js
function proxy_route(path::String, ip::IP4)
    ProxyRoute(path, ip.ip, ip.port)
end
```

<div class="content-ad"></div>

이제 새로운 고수준 구문을 사용하여 ProxyRoute를 만들어 봅시다.

```js
테스트 = proxy_route("127.0.0.1:8000", "127.0.0.1":8000)
```

## 기본 테스트

프록시 라우터의 기본 사항을 작성했으니, 모든 데이터를 보여주고 프록시 서버가 무엇을 하는지 보여줄 기본 레이아웃을 만들어 봅시다. 다음 예제에서는 라우트된 호스트를 출력한 다음 그 호스트를 실행할 서버를 선택합니다. 여기서 기대하는 바는 127.0.0.1이 두 번 나열되는 것을 볼 수 있어야 합니다.

<div class="content-ad"></div>

```kotlin
fun route!(c::Toolips.AbstractConnection, pr::AbstractProxyRoute)
    write!(c, "<h3>선택된 서버:</h3>$(pr.path)")
end

fun route!(c::Connection, vec::Vector{<:AbstractProxyRoute})
    write!(c, Components.DOCTYPE())
    write!(c, "저희 수정된 `Connection` 라우터입니다.")
    write!(c, "<h3>호스트</h3>$(get_host(c))")
    route!(c, vec[get_host(c)])
end
```

![Build Proxy Server](/assets/img/2024-06-22-BuildingAProxyServerInJulia_5.png)

이제 할 일은 dev.jl에서 서버 포트를 80으로 변경하는 것입니다. 이 포트는 2000 미만이므로 방화벽 구성을 위해 조치해야 합니다. Windows나 OSX에서는 이를 어떻게 해야 할지 잘 모르겠습니다. Ubuntu에서는 Ubuntu Firewall인 ufw를 사용하면 됩니다.

```bash
ufw allow 80
```

<div class="content-ad"></div>

저는 firewalld와 Fedora 38을 사용하고 있습니다. 다른 여러 배포판들도 firewalld를 사용하기 때문에, 만약 리눅스를 사용 중이라면 이 방법이 도움이 될 수도 있습니다.

```js
firewall-cmd --zone=public --add-port=80/tcp
```

또 다른 방법으로는 방화벽 서비스를 구성할 수도 있습니다. 이 부분에 대해서는 설명을 드리지 않겠습니다. 추가로, 방화벽을 조정하지 않고 해결할 수 있는 빠른 방법은 sudo를 사용하는 것입니다. 이를 통해 root의 Bash 프로필이 사용되므로 root의 Julia 패키지를 사용하게 됩니다. 이는 이상적이지는 않지만 테스트 목적으로는 문제 없을 수도 있습니다. 포트를 포워딩하지 않는 비공개 네트워크에 연결돼 있다면 잘 동작할 것입니다.

```js
sudo julia -L dev.jl
```

<div class="content-ad"></div>

이제 서버가 80 포트에서 호스팅되고 있으므로 호스트 이름을 서버의 IP 주소로 변경하려고 합니다.

```js
test = proxy_route("127.0.0.1", "127.0.0.1":8000)
```

```js
function route!(c::Toolips.AbstractConnection, pr::AbstractProxyRoute)
    write!(c, "<h3>선택된 서버:</h3>$(pr.ip):$(pr.port)")
end
```

이제 이 서버를 사용하려면 127.0.0.1에서 접속해야 합니다 — 웹 서버가 80 포트에 있으므로 포트를 사용할 필요가 없습니다. 우리의 ProxyRoute는 그런 다음 80 포트에서 8000 포트로 우리를 리디렉션해야 합니다.

<div class="content-ad"></div>


![image](/assets/img/2024-06-22-BuildingAProxyServerInJulia_6.png)

프록시 라우팅을 마무리하려면 Toolips.proxy_pass!를 사용하여 연결을 리디렉션해야 합니다. 서버가 활성화되지 않았으면 터미널에 오류가 발생할 수 있습니다.

```js
function route!(c::Toolips.AbstractConnection, pr::AbstractProxyRoute)
    proxy_pass!(c, "http://$(pr.ip):$(pr.port)")
end
```

이것을 기억하면 다른 포트(8000)에서 호스팅된 또 다른 서버를 만들어야 합니다. 이 서버는 이 프록시 패스에 응답할 것입니다.


<div class="content-ad"></div>


```js
module TestServer
using Toolips
main = route("/") do c::Connection
    write!(c, "</br>this is 127.0.0.1 responding")
end

export main
end
```


이 TestServer를 시작하려면 dev.jl을 업데이트해야 합니다. 일관성을 위해 두 파일을 살펴보겠습니다:

- dev.jl

```js
using Pkg; Pkg.activate(".")
using ChiProxy
using ChiProxy: TestServer

ChiProxy.start!("127.0.0.1":80)

TestServer.start!("127.0.0.1":8000)
```


<div class="content-ad"></div>

- ChiProxy.jl

```js
module ChiProxy
using Toolips
import Toolips: route!

abstract type AbstractProxyRoute <: Toolips.AbstractRoute end

mutable struct ProxyRoute <: AbstractProxyRoute
    path::String
    ip::String
    port::Int64
end

function proxy_route(path::String, ip::IP4)
    ProxyRoute(path, ip.ip, ip.port)
end

function route!(c::Toolips.AbstractConnection, pr::AbstractProxyRoute)
    Toolips.proxy_pass!(c, "http://$(pr.ip):$(pr.port)")
end

function route!(c::Connection, vec::Vector{<:AbstractProxyRoute})
    write!(c, Components.DOCTYPE())
    write!(c, "our modified `Connection` router.")
    write!(c, "<h3>host</h3>$(get_host(c))")
    route!(c, vec[get_host(c)])
end

main = route("/") do c::Connection
    write!(c, "$(c.routes)")
end

test = proxy_route("127.0.0.1", "127.0.0.1":8000)
# 404
err_404 = Toolips.default_404
#== Test server
==#
module TestServer
using Toolips

main = route("/") do c::Connection
    write!(c, "</br>this is 127.0.0.1 responding")
end

export main
end
#==
==#

export test
end
```

이제 다시 포트 80에서 시도해 봅시다.

이제 8000번 포트의 서버가 80번 포트의 서버를 통해 응답했습니다. 다음 단계는 ProxyRoute 라우터에서 모든 쓰기를 제거하는 것입니다.

<div class="content-ad"></div>

```js
module ChiProxy
using Toolips
import Toolips: route!

abstract type AbstractProxyRoute <: Toolips.AbstractRoute end

mutable struct ProxyRoute <: AbstractProxyRoute
    path::String
    ip::String
    port::Int64
end

function proxy_route(path::String, ip::IP4)
    ProxyRoute(path, ip.ip, ip.port)
end

function route!(c::Toolips.AbstractConnection, pr::AbstractProxyRoute)
    Toolips.proxy_pass!(c, "http://$(pr.ip):$(pr.port)")
end

function route!(c::Connection, vec::Vector{<:AbstractProxyRoute})
    route!(c, vec[get_host(c)])
end

main = route("/") do c::Connection
    write!(c, "$(c.routes)")
end

test = proxy_route("127.0.0.1", "127.0.0.1":8000)
# 404
err_404 = Toolips.default_404

module TestServer
using Toolips
main = route("/") do c::Connection
    write!(c, "</br>this is 127.0.0.1 responding")
end

export main
end

export test
end
```

## 결론

이번 1월 초에 일들이 서두를 겪고 있습니다. 이 프록시 서버는 제가 개발할 긴 여정 중 단 한 걸음에 불과하며, DNS 서버와 함께 많은 웹 인프라를 구축하기 위한 준비를 세우고 있습니다. 물론 여전히 해야 할 일이 많습니다. 현재 우리의 프록시 서버에는 SSL도 없고 로드 밸런싱도 없으며, 여러 디스패치를 중심으로 한 이 구현에 대한 더 복잡한 계획도 있습니다.

중요한 것은 Toolips의 이 전 릴리스 버전을 사용하고 있다는 점입니다. Toolips의 메인 실행 버전이 될 때까지 많은 일이 필요합니다. 이 릴리스는 전체 생태계를 파괴합니다. 다행히도, 실제로는 생각보다 더 부담스럽지 않고 이 새로운 Toolips 버전은 상당히 멋질 것입니다! 오늘 사용된 구문에서 유추하신 대로, 몇 가지 함수를 간단히 작성함으로써 Toolips용 사용자 정의 라우터를 만들 수 있습니다. Toolips가 개선된 유일한 측면이 아닙니다.

<div class="content-ad"></div>

모두 읽어 주셔서 감사합니다. 제 웹 사이트는 곧 준비될 것이며 곧 돌아와서 로드 밸런싱 및 "소스"를 추가하는 이 프록시 서버의 두 번째 부분을 진행할 계획입니다. 그 후에는 파일 형식에서 프록시 설정을 불러와 완성된 프록시 서버를 갖게 될 것입니다. 다시 한 번 읽어 주셔서 감사합니다. 즐거운 하루 되세요.