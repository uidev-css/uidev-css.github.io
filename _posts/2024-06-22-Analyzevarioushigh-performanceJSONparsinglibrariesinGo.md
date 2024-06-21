---
title: "고성능 JSON 파싱 라이브러리 분석 - Go 언어를 위한 비교 분석"
description: ""
coverImage: "/assets/img/2024-06-22-Analyzevarioushigh-performanceJSONparsinglibrariesinGo_0.png"
date: 2024-06-22 04:18
ogImage: 
  url: /assets/img/2024-06-22-Analyzevarioushigh-performanceJSONparsinglibrariesinGo_0.png
tag: Tech
originalTitle: "Analyze various high-performance JSON parsing libraries in Go."
link: "https://medium.com/faun/analyze-various-high-performance-json-parsing-libraries-in-go-4c699fc12cba"
---


![image](/assets/img/2024-06-22-Analyzevarioushigh-performanceJSONparsinglibrariesinGo_0.png)

`fastjson`, `gjson`, `jsonparser`의 성능, 장단점을 비교해보세요.

이 기사는 Go의 표준 라이브러리가 JSON을 파싱하는 방식을 분석하고, 인기 있는 JSON 파싱 라이브러리, 그 특징들을 탐구하여 다양한 시나리오에서 개발을 더 잘 지원할 수 있는 방법에 대해 알아봅니다.

나는 JSON 라이브러리의 성능 문제를 조사하려고 한 계획은 없었습니다. 그러나 최근에 프로젝트를 pprof로 분석해보니 아래의 flame 그래프에서 비즈니스 로직 처리 시 성능 소비량의 절반 이상이 JSON 파싱 중에 발생했다는 것을 알게 되었습니다. 그래서 이 기사가 만들어졌습니다.

<div class="content-ad"></div>


![이미지](/assets/img/2024-06-22-Analyzevarioushigh-performanceJSONparsinglibrariesinGo_1.png)

이 기사는 Go의 표준 라이브러리가 JSON을 구문 분석하는 방식을 분석하고, 인기있는 JSON 구문 분석 라이브러리, 그 특징, 그리고 다양한 시나리오에서 개발을 더 잘 돕는 방법을 탐색합니다.

주로 다음 라이브러리들의 분석을 소개합니다 (2024년 6월 13일):

![이미지](/assets/img/2024-06-22-Analyzevarioushigh-performanceJSONparsinglibrariesinGo_2.png)


<div class="content-ad"></div>

## JSON Unmarshal

```go
func Unmarshal(data []byte, v interface{})
```

"공식 JSON 구문 분석 라이브러리는 두 개의 매개변수가 필요합니다: 직렬화할 객체와이 객체의 유형입니다. 실제 JSON 구문 분석을 수행하기 전에 reflect.ValueOf를 호출하여 매개변수 v의 리플렉션 객체를 가져옵니다. 그런 다음 들어오는 데이터 객체의 처음에 있는 비어 있지 않은 문자열을 기반으로 구문 분석 방법이 결정됩니다."

```go
func (d *decodeState) value(v reflect.Value) error {
    switch d.opcode {
    default:
        panic(phasePanicMsg)
    // 배열
    case scanBeginArray:
        ...
    // 구조체 또는 맵
    case scanBeginObject:
        ...
    // int, string, float 등을 포함하는 리터럴
    case scanBeginLiteral:
        ...
    }
    return nil
}
```

<div class="content-ad"></div>

파싱된 객체가 [,으로 시작하면 배열 객체이고 scanBeginArray 분기로 들어가게 됩니다. '로 시작하면 객체가 구조체 또는 맵이라는 것을 나타내며 scanBeginObject 분기로 들어가고 이와 같은 방식입니다.

## 하위 요약

Unmarshal의 소스 코드를 살펴보면 많은 양의 반사가 필드 값을 얻기 위해 사용되는 것을 볼 수 있습니다. JSON이 중첩되어 있다면 값 얻기 위해 반복적인 반사가 필요합니다. 따라서 성능은 매우 저조할 것으로 생각됩니다.

하지만 성능이 높은 가치를 가지고 있지 않다면 직접 사용하는 것이 좋은 선택입니다. 완전한 기능성을 갖추고 있으며 공식 팀이 지속적으로 반복 및 최적화하고 있습니다. 미래 버전에서 성능도 질적인 발전을 이룰 수도 있습니다. Go 구조체로 직접 JSON 객체를 변환할 수 있는 유일한 방법일 것입니다.

<div class="content-ad"></div>

# fastjson

이 라이브러리의 특징은 이름이 시사하는 대로 빠르다는 것입니다. 소개 페이지에는 다음과 같이 언급되어 있습니다:

사용 방법도 간단합니다. 아래와 같이 사용할 수 있습니다:

```js
func main() {
     var p fastjson.Parser
     v, _ := p.Parse(`{
                 "str": "bar",
                 "int": 123,
                 "float": 1.23,
                 "bool": true,
                 "arr": [1, "foo", {}]
         }`)
     fmt.Printf("foo=%s\n", v.GetStringBytes("str"))
     fmt.Printf("int=%d\n", v.GetInt("int"))
     fmt.Printf("float=%f\n", v.GetFloat64("float"))
     fmt.Printf("bool=%v\n", v.GetBool("bool"))
     fmt.Printf("arr.1=%s\n", v.GetStringBytes("arr", "1"))
 }
 // 출력:
 // foo=bar
 // int=123
 // float=1.230000
 // bool=true
 // arr.1=foo
```

<div class="content-ad"></div>

fastjson을 사용하려면 먼저 JSON 문자열을 구문 분석하기 위해 Parser parser에 전달한 다음 Parse 메서드로 반환된 객체를 통해 검색해야 합니다. 중첩된 객체인 경우 Get 메서드에 매개변수를 전달할 때 해당 부모-자식 키를 직접 전달할 수 있습니다.

## 분석

fastjson의 설계는 표준 라이브러리 Unmarshal과 다르게 JSON 구문 분석을 Parse와 Get으로 나누는 특징이 있습니다.

Parse는 JSON 문자열을 구조체로 구문 분석하고 반환하는 역할을 합니다. 그런 다음 반환된 구조체에서 데이터를 검색합니다. Parse 프로세스는 락이 없으므로 동시에 Parse를 호출하려면 ParserPool을 사용해야 합니다.

<div class="content-ad"></div>

**fastjson**은 JSON을 가장 위에서부터 아래로 트래버스하여 구문 분석된 데이터를 Value 구조에 저장합니다:

```js
type Value struct { o Object a []*Value s string t Type }
```

이 구조는 다음과 같습니다:

- o Object: 구문 분석된 구조가 객체임을 나타냅니다.
- a []*Value: 구문 분석된 구조가 배열임을 나타냅니다.
- s string: 구문 분석된 구조가 객체나 배열이 아닌 경우, 다른 유형의 값은 문자열로 이 필드에 저장됩니다.
- t Type: 이 구조의 유형을 나타내며, TypeObject, TypeArray, TypeString, TypeNumber 등이 될 수 있습니다.

<div class="content-ad"></div>

```go
type Object struct { kvs []kv keysUnescaped bool } type kv struct { k string v *Value }
```

이 구조는 객체의 재귀 구조를 저장합니다. 위 예시의 JSON 문자열을 구문 분석한 후, 결과물은 다음과 같이 보입니다:

![구조 이미지](/assets/img/2024-06-22-Analyzevarioushigh-performanceJSONparsinglibrariesinGo_3.png)

## 코드

<div class="content-ad"></div>

구현 측면에서 반사 코드의 부재로 인해 전체 구문 분석 프로세스가 매우 깔끔해졌어요. 구문 분석의 중심 부분을 직접 살펴보죠:

```js
func parseValue(s string, c *cache, depth int) (*Value, string, error) {
     if len(s) == 0 {
         return nil, s, fmt.Errorf("빈 문자열을 구문 분석할 수 없습니다")
     }
     depth++
     // json 문자열의 최대 깊이는 MaxDepth를 초과할 수 없습니다
     if depth > MaxDepth {
         return nil, s, fmt.Errorf("중첩 된 JSON에 대한 너무 큰 깊이; %d를 초과합니다", MaxDepth)
     }
     // 객체 구문 분석
     if s[0] == '{' {
         v, tail, err := parseObject(s[1:], c, depth)
         if err != nil {
             return nil, tail, fmt.Errorf("객체를 구문 분석할 수 없음: %s", err)
         }
         return v, tail, nil
     }
     // 배열 구문 분석
     if s[0] == '[' {
         ...
     }
     // 문자열 구문 분석
     if s[0] == '"' {
         ...
     } 
     ...
     return v, tail, nil
 }
```

parseValue 함수는 문자열의 첫 번째 비어 있지 않은 문자를 기반으로 구문 분석할 유형을 결정할 거에요. 여기서 객체 유형이 분석에 사용됩니다:

```js
func parseObject(s string, c *cache, depth int) (*Value, string, error) {
     ...
     o := c.getValue()
     o.t = TypeObject
     o.o.reset()
     for {
         var err error
         // Object 구조 내에서 kv 객체 가져오기
         kv := o.o.getKV()
         ... 
         // 키 값 구문 분석
 
         kv.k, s, err = parseRawKey(s[1:])
         ... 
         // 재귀적 값 구문 분석
         kv.v, s, err = parseValue(s, c, depth)
         ...
         // 만났을 때, 계속 구문 분석
         if s[0] == ',' {
             s = s[1:]
             continue
         }
         // 구문 분석 완료
         if s[0] == '}' {
             return o, s[1:], nil
         }
         return nil, s, fmt.Errorf("객체 값 후 ','가 누락되었습니다")
     }
 }
```

<div class="content-ad"></div>

parseObject 함수도 간단합니다. 루프에서 키 값을 가져와서 순환적으로 parseValue 함수를 호출하여 위에서 아래로 값을 구문 분석하고 '를 마주할 때까지 JSON 객체들을 하나씩 구문 분석합니다.

## 하위 요약

위의 분석을 통해 fastjson은 구현이 훨씬 간단하고 표준 라이브러리보다 성능이 더 높다는 것을 알 수 있습니다. JSON 트리를 구문 분석하는 Parse를 사용한 후에는 여러 번 재사용할 수 있어 반복 구문 분석이 필요 없어지고 성능이 향상됩니다.

그러나 그 기능은 매우 기본적이며 JSON을 구조체로 또는 JSON을 맵으로 변환하는 공통 작업이 부족합니다. JSON에서 값을 간단히 검색하려면이 라이브러리를 사용하는 것이 매우 편리합니다. 하지만 JSON 값을 구조체로 변환하려면 각 값을 수동으로 설정해야 합니다.

<div class="content-ad"></div>

# GJSON

제 테스트 결과, GJSON의 성능은 fastjson만큼 극단적이진 않지만, 기능적으로는 매우 완전하며 성능도 꽤 괜찮습니다. 이제 GJSON의 기능을 간단히 소개하겠습니다.

GJSON의 사용법은 fastjson과 유사하며, 매우 간단합니다. JSON 문자열과 필요한 값을 매개변수로 전달하기만 하면 됩니다.

```js
json := `{"name":{"first":"li","last":"dj"},"age":18}`
lastName := gjson.Get(json, "name.last")
```

<div class="content-ad"></div>

이 함수 외에도 간단한 퍼지 매칭을 수행할 수 있습니다. *와 ?와 같은 와일드카드 문자를 지원합니다. *는 모든 문자와 매치되고 ?는 한 문자와 매치됩니다. 예시는 다음과 같습니다:

```js
json := `{
     "name":{"first":"Tom", "last": "Anderson"},
     "age": 37,
     "children": ["Sara", "Alex", "Jack"]
 }`
 fmt.Println("세 번째 자식*:", gjson.Get(json, "child*.2"))
 fmt.Println("첫 번째 c?ild:", gjson.Get(json, "c?ildren.0"))
```

- child*.2: 먼저, child*는 children과 매치되며, .2는 세 번째 요소를 읽습니다;
- c?ildren.0: c?ildren은 children과 매치되며, .0은 첫 번째 요소를 읽습니다;

퍼지 매칭뿐만 아니라 수정자 작업도 지원합니다.

<div class="content-ad"></div>

```js
json := `{
     "name":{"first":"Tom", "last": "Anderson"},
     "age": 37,
     "children": ["Sara", "Alex", "Jack"]
 }`
 fmt.Println("세 번째 자녀*:", gjson.Get(json, "children|@reverse"))
```

children|@reverse 먼저 배열 "children"를 읽은 다음 수정자 "@reverse"를 사용하여 뒤집어서 출력합니다.

```js
nestedJSON := `{"nested": ["one", "two", ["three", "four"]]}` fmt.Println(gjson.Get(nestedJSON, "nested|@flatten"))
```

@flatten은 내장된 배열을 외부 배열로 평탄화하고 다음을 반환합니다:

<div class="content-ad"></div>

```json
["one," "two," "three," "four"]
```

다른 흥미로운 기능도 있으니 공식 문서에서 확인해보세요.

## 분석

gjson의 Get 메서드 매개변수는 JSON 문자열과 경로(Path)를 포함하며, 해당 JSON 값을 가져올 수 있는 일치 경로를 나타냅니다.

<div class="content-ad"></div>

gjson에서는 파싱을 여러 가지 파싱 시나리오의 정의를 충족해야 하기 때문에 두 부분으로 나뉘어집니다. JSON 문자열을 탐색하기 전에 경로를 파싱해야 합니다.

파싱 프로세스 중 일치하는 값을 만날 경우 해당 값이 직접 반환되며 뒷 부분을 계속해서 탐색할 필요가 없습니다. 여러 값이 일치하는 경우 JSON 문자열 전체가 항상 탐색됩니다. JSON 문자열에서 일치하는 경로를 만나지 못할 경우 전체 JSON 문자열을 탐색해야 합니다.

파싱 과정에서 파싱 내용이 fastjson과 같이 구조에 저장되지 않습니다. 따라서 GetMany를 호출하여 여러 값을 반환할 때 JSON 문자열을 반복적으로 탐색해야 하기 때문에 효율이 비교적 낮아집니다.

![이미지](/assets/img/2024-06-22-Analyzevarioushigh-performanceJSONparsinglibrariesinGo_4.png)

<div class="content-ad"></div>

@flatten 함수는 JSON을 유효성 검사하지 않는다는 사실을 알아두는 것이 중요합니다. 이는 입력 문자열이 유효한 JSON이 아니더라도 구문 분석된다는 의미입니다. 따라서 사용자들은 잠재적인 문제를 피하기 위해 입력이 유효한 JSON인지 다시 한번 확인해야 합니다.

## 코드

```js
func Get(json, path string) Result {
     // 패스를 분석합니다
     if len(path) > 1 {
         ...
     }
     var i int
     var c = &parseContext{json: json}
     if len(path) >= 2 && path[0] == '.' && path[1] == '.' {
         c.lines = true
         parseArray(c, 0, path[2:])
     } else {
         // 다양한 객체에 따라 구문 분석하고 여기서 '{' 또는 '['이 발견될 때까지 루프
         for ; i < len(c.json); i++ {
             if c.json[i] == '{' {
                 i++
 
                 parseObject(c, i, path)
                 break
             }
             if c.json[i] == '[' {
                 i++
                 parseArray(c, i, path)
                 break
             }
         }
     }
     if c.piped {
         res := c.value.Get(c.pipe)
         res.Index = 0
         return res
     }
     fillIndex(json, c)
     return c.value
 }
```

Get 메서드에서 다양한 경로를 구문 분석하는 데 사용된 긴 코드 문자열을 볼 수 있습니다. 그런 다음 '‘나 ‘[‘를 찾을 때까지 for 루프가 JSON을 계속 탐색한 후 해당하는 논리 처리를 수행합니다.

<div class="content-ad"></div>

```go
func parseObject(c *parseContext, i int, path string) (int, bool) {
     var pmatch, kesc, vesc, ok, hit bool
     var key, val string
     rp := parseObjectPath(path)
     if !rp.more && rp.piped {
         c.pipe = rp.pipe
         c.piped = true
     }
     // 두 개의 for 루프를 중첩하여 키 값을 찾습니다.
     for i < len(c.json) {
         for ; i < len(c.json); i++ {
             if c.json[i] == '"' {
                 i++
                 var s = i
                 for ; i < len(c.json); i++ {
                     if c.json[i] > '\\' {
                         continue
                     }
                     // 키 값을 찾고 parse_key_string_done으로 이동합니다.
                     if c.json[i] == '"' {
                         i, key, kesc, ok = i+1, c.json[s:i], false, true
                         goto parse_key_string_done
                     }
                     ...
                 }
                 key, kesc, ok = c.json[s:], false, false
                 // break
              parse_key_string_done:
                     break
                 }
                 if c.json[i] == '}' {
                     return i + 1, false
                 }
             }
             if !ok {
                 return i, false
             }
             // 퍼지 매치인지 확인합니다.
             if rp.wild {
                 if kesc {
                     pmatch = match.Match(unescape(key), rp.part)
                 } else {
                     pmatch = match.Match(key, rp.part)
                 }
             } else {
                 if kesc {
                     pmatch = rp.part == unescape(key)
                 } else {
                     pmatch = rp.part == key
                 }
             }
             // 값을 파싱합니다.
             hit = pmatch && !rp.more
             for ; i < len(c.json); i++ {
                 switch c.json[i] {
                 default:
                     continue
                 case '"':
                     i++
                     i, val, vesc, ok = parseString(c.json, i)
                     if !ok {
                         return i, false
                     }
                     if hit {
                         if vesc {
                             c.value.Str = unescape(val[1 : len(val)-1])
                         } else {
                             c.value.Str = val[1 : len(val)-1]
                         }
                         c.value.Raw = val
                         c.value.Type = String
                         return i, true
                     }
                 case '{':
                     if pmatch && !hit {
                         i, hit = parseObject(c, i+1, rp.path)
                         if hit {
                             return i, true
                         }
                     } else {
                         i, val = parseSquash(c.json, i)
                         if hit {
                             c.value.Raw = val
                             c.value.Type = JSON
                             return i, true
                         }
                     }
                 ...
                 break
             }
         }
     }
     return i, false
}
```

`parseObject` 코드를 검토할 때 JSON 파싱이나 문자열 탐색 방법을 가르치는 것이 아니라 나쁜 경우의 시나리오를 설명하는 것이 목적이었습니다. 중첩된 for 루프와 연이어 나오는 if 문들은 압도적일 수 있고, 직장에서 만난 동료의 코드를 떠올릴 수도 있습니다.

## 하위 요약

장점:

<div class="content-ad"></div>

- 성능: jsonparser는 표준 라이브러리와 비교하여 상대적으로 우수한 성능을 보여줍니다.
- 유연성: 다양한 검색 방법과 사용자 정의 반환 값 옵션을 제공하여 매우 편리합니다.

단점:

- JSON 유효성 검사 미지원: JSON 입력의 정확성을 확인하지 않습니다.
- 코드 구조가 지저분하고 읽기 어렵다. 유지보수가 어려울 수 있습니다.

## 참고문서

<div class="content-ad"></div>

JSON 값을 가져오기 위해 JSON을 파싱할 때, 지정된 키에 따라 GetMany 함수가 JSON 문자열을 여러 번 횡단합니다. JSON을 맵으로 변환하면 횡단 횟수를 줄일 수 있습니다.

## 결론

jsonparser는 주목할 만한 성능과 유연성을 가지고 있지만, JSON 유효성 검사 부족과 복잡하고 읽기 어려운 코드 구조는 상당한 단점으로 나타납니다. JSON을 파싱하고 값을 자주 가져와야 하는 경우, 성능과 코드 유지 관리성 사이의 균형을 고려해야 합니다.

# jsonparser

<div class="content-ad"></div>

## 분석

jsonparser는 입력 JSON 바이트 슬라이스도 처리하며 여러 키를 전달하여 값을 빠르게 찾아내고 반환할 수 있습니다.

GJSON과 유사하게, jsonparser는 fastjson이 하는 것처럼 파싱된 JSON 문자열을 데이터 구조에 캐시하지 않습니다. 하지만 다수의 값을 파싱해야 하는 경우 EachKey 함수를 사용하여 JSON 문자열을 한 번에 여러 값으로 파싱할 수 있습니다.

일치하는 값을 찾으면 jsonparser는 추가적인 탐색 없이 즉시 반환합니다. 다수의 일치하는 값이 있을 경우 전체 JSON 문자열을 탐색합니다. JSON 문자열에서 경로가 일치하는 값이 없다면 여전히 전체 문자열을 탐색합니다.

<div class="content-ad"></div>

jsonparser는 재귀 사용을 줄이고 호출 스택의 깊이를 낮추며 성능을 향상시키기 위해 JSON 탐색 중에 루프를 사용합니다.

ArrayEach, ObjectEach 및 EachKey 함수는 사용자 정의 함수를 전달하여 특정 요구 사항을 충족시키는 기능을 제공하여 jsonparser의 유틸리티를 크게 향상시킵니다.

jsonparser의 코드는 간단하고 명확하여 분석하기 쉽습니다. 관심 있는 사람은 직접 검토할 수 있습니다.

## 하위 요약

<div class="content-ad"></div>

jsonparser의 뛰어난 성능은 다음과 같은 이유가 있습니다:

- 재귀를 최소화하기 위해 for 루프를 사용합니다.
- 표준 라이브러리와는 달리 반영(reflection)을 사용하지 않습니다.
- 해당 키 값이 발견되면 즉시 종료하여 추가 재귀를 피합니다.
- 전달된 JSON 문자열에서 작업하며 새로운 공간을 할당하지 않아 메모리 할당을 줄입니다.

또한 API 디자인이 편리합니다. ArrayEach, ObjectEach, EachKey와 같은 함수는 사용자 정의 함수를 전달할 수 있어 실제 비즈니스 개발에서 많은 문제를 해결할 수 있습니다.

하지만 jsonparser에는 중요한 단점이 있습니다: JSON을 유효성 검사하지 않습니다. 입력이 유효한 JSON이 아닌 경우 jsonparser는 감지하지 못합니다.

<div class="content-ad"></div>

# 성능 비교

## 작은 JSON 문자열 구문 분석

약 190바이트 정도의 간단한 JSON 문자열을 구문 분석하는 것

![이미지](/assets/img/2024-06-22-Analyzevarioushigh-performanceJSONparsinglibrariesinGo_5.png)

<div class="content-ad"></div>

## JSON 문자열 구문 분석하기

중간 정도 복잡성의 JSON 문자열을 구문 분석하려면, 대략 2.3KB 크기를 가질 것입니다.

![이미지](/assets/img/2024-06-22-Analyzevarioushigh-performanceJSONparsinglibrariesinGo_6.png)

## 큰 JSON 문자열 구문 분석하기

<div class="content-ad"></div>

JSON 문자열을 파싱하려면, 대략 2.2MB의 크기가 있어요.

![이미지](/assets/img/2024-06-22-Analyzevarioushigh-performanceJSONparsinglibrariesinGo_7.png)

# 요약

이 비교를 통해 여러 고성능 JSON 파싱 라이브러리를 분석했어요. 이 라이브러리들은 몇 가지 공통 특징을 공유하고 있어요:

<div class="content-ad"></div>

- 리플렉션 사용을 피합니다.
- JSON을 순차적으로 바이트 단위로 탐색하여 파싱합니다.
- 입력 JSON 문자열을 직접 파싱하여 메모리 할당을 최소화합니다.
- 성능을 위해 어느 정도의 호환성을 희생합니다.

이런 점들을 고려해도, 각 라이브러리는 독특한 기능을 제공합니다. fastjson API는 가장 간단한 사용 방법을 제공하며, GJSON은 퍼지 검색 기능과 높은 사용자 정의 가능성을 제공합니다. jsonparser는 고성능 파싱 중에 콜백 함수 삽입을 지원하여 사용 편의성을 제공합니다.

나의 사용 사례는 미리 정의된 필드와 가끔한 사용자 정의 작업이 포함된 HTTP 응답 JSON 문자열에서 특정 필드를 단순히 파싱하는 것이므로, jsonparser가 가장 적합한 도구입니다.

그러므로 성능에 관심이 있다면 비즈니스 요구 사항을 기반으로 JSON 파서를 선택하는 것을 고려해보세요.

<div class="content-ad"></div>

# 참고 자료

- https://github.com/buger/jsonparser
- https://github.com/tidwall/gjson
- https://github.com/valyala/fastjson
- https://github.com/json-iterator/go
- https://github.com/mailru/easyjson
- https://github.com/Jeffail/gabs
- https://github.com/bitly/go-simplejson

![이미지](/assets/img/2024-06-22-Analyzevarioushigh-performanceJSONparsinglibrariesinGo_8.png)

## 👋 만약 이 정보가 도움이 되었다면, 아래 👏 버튼을 몇 번 눌러서 저자를 지원해주세요 👇

<div class="content-ad"></div>

## 🚀 FAUN 개발자 커뮤니티에 참여하고 매주 비슷한 이야기를 이메일로 받아보세요