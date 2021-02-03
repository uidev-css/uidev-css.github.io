---
layout: post
title: "React의 네트워크 및 장치 제약에 따라 이미지 최적화
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/12/3G-Network-React-Images.png
tags: 
---


연결성은 인터넷이 시작된 이래로 인식을 넘어서 진화했습니다.
 우리는 최근 전화 접속을 몇 광년 지나서 모바일 네트워크에 연결되어있는 동안 스마트 폰에서 고해상도로 동영상을 볼 수 있습니다.
 그러나 모든 모바일 연결이 동일하게 생성되는 것은 아닙니다. 이전 세대 네트워크 (3G, 2G 등)가 여전히 지배적이며 2020 년 전 세계 모든 연결의 거의 절반을 차지합니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/12/Cisco-3G-4G-5G-2018-2023.png?resize=672%2C311&ssl=1)

안타깝게도 단계적 제거 프로세스는 매우 느리고 전 세계의 많은 사람들이 가정 인터넷 채택 초기에 비해 페이지로드가 매우 느려졌습니다.
 

현대 웹 사이트는 많은 이미지와 애니메이션을 특징으로하는 자원을 많이 소모했습니다.
 전원이 부족한 장치를 사용하고 네트워크 연결이 취약한 방문자의 경우 평균 웹 페이지가 완전히로드되는 데 몇 분 정도 걸릴 수 있습니다.
 이는 주로 개발자가 사용자의 하드웨어 및 네트워크 상태와 관련하여 이진 결정을 내리는 경우가 많기 때문입니다. 기기는 데스크톱 또는 스마트 폰 카테고리에 속하지만 연결은 온-오프라인의 문제입니다.
 실제로 사용자의 상황은 훨씬 더 미묘한 경향이 있습니다.
 

### 우리는 더 잘할 수 있습니까?
 

평범한 장치와 불안정한 연결에서 사용자의 격차를 해소하려면 어떻게해야합니까?
 먼저, 다음 두 가지 속성을 살펴봄으로써 정확한 조건이 무엇인지 빠르게 평가해야합니다.
 

- `navigator.deviceMemory`
 
- `navigator.connection`
 

이를 기반으로 예를 들어 제공하려는 이미지의 품질을 조정할 수 있습니다.
 그러나 Jamstack 웹 사이트와 앱이 서버에서 렌더링되면 문제가 있습니다. 다른 브라우저 API와 마찬가지로`navigator` 객체는 렌더링 단계에서 사용할 수 없습니다.
 이 문제에 대한 일반적인 해결 방법은 반응 형 이미지 마크 업을 추가하는 것이지만, 비효율적 인 확장이라는 상당한 문제점이 있습니다.
 ImageEngine과 같은 이미지 CDN은 요청 된 리소스에 즉석에서 자동화 된 스마트 조정을 적용하여 장면 뒤의 모든 무거운 작업을 처리하므로 반응 형 이미지와 관련된 기타 함정을 피하는 데 도움이됩니다.
 

사용자의 네트워크 제약에 적응할 때 연결 유형을 감지하고 연결 품질에 따라 압축을 변경하도록 이미지 CDN에 지시 할 수 있습니다.
 다음은 React에서 할 수있는 방법입니다.
 

```jsx
import React, { useState, useEffect } from 'react'

const useConnectionType = (defaultConnectionType) => {

  const isSupported = navigator?.connection?.effectiveType
    ? true
    : false

  const [connectionType, setNetworkStatus] = useState(
    isSupported
      ? navigator.connection.effectiveType
      : defaultConnectionType
  )

  useEffect(() => {
    if (isSupported) {
      const { connection } = navigator
      const updateConnectionType = () => {
        setNetworkStatus(connection.effectiveType)
      }

      connection.addEventListener('change', updateConnectionType)

      return () => {
        connection.removeEventListener('change', updateConnectionType)
      }
    }
  }, [])

  return [ connectionType, setNetworkStatus ]
}

const imageCDNHost = 'images.foo.com

function ConnectionAwareComponent () {

  const [ connectionType ] = useConnectionType()

  let compressionLevel = 0

  switch (connectionType) {
    case 'slow-2g':
      compressionLevel = 65
      break
    case '2g':
      compressionLevel = 50
      break
    case '3g':
      compressionLevel = 30
      break
    case '4g':
      compressionLevel = 0
      break
  }

  return (
    <div>
      {/* Apply variable compression via dedicated directive */}
      <img src={`${imageCDNHost}/?imgeng?=cmpr_${compressionLevel}`} />
    </div>
  )
}
```

흐릿한 이미지를 렌더링하고 필요에 따라 고해상도 버전을 다운로드 할 수있는 옵션을 제공함으로써 매우 느리고 불안정한 네트워크에있는 사람들을 수용하기 위해이 아이디어를 더욱 발전시킬 수 있습니다.
 또는 성과 점수 시스템을 고안하고 그에 따라 전송되는 내용을 조정하십시오.
 

반면에 사용자가 "빠른"4G 연결을 사용하고 있다는 사실은 로밍 중에 웹 사이트에 액세스 할 수 있으므로 반드시 데이터 저장에 관심이 없음을 의미하지는 않습니다.
 웹 사이트에서 클라이언트 힌트를 활성화하면 사이트 소유자가 데이터 세이버 플래그의 존재를 감지하고 필요한 조치를 취하여 사용자의 선호도에 맞게 조정할 수 있습니다.
 

### 더 빠른 이미지의 이유
 

평범한 CPU, 적당한 양의 메모리 및 저급 연결은 상상의 제약이 아닙니다.
 그들은 잠재적으로 전 세계 수억 명의 사용자에게 영향을 미치는 실제 사용자 경험 문제를 제기합니다.
 일부 회사는 포괄적 인 경험을 제품에 적용하기 시작했습니다. Netflix 및 Spotify와 같은 스트리밍 서비스는 네트워크 상태에 따라 스트리밍 품질을 조정하는 반면 다른 많은 회사는 사용자를 위해 자동 이미지 최적화를 수행합니다.
 

아직 모든 사람과 모든 곳에서 빠른 네트워크에 액세스 할 수없는 개발 지역은 목표 시장이 아닐 수 있습니다.
 한편, 선진국의 시골 지역에서 브라우징하는 사람은 웹 사이트의 완전한 버전을 제공 받으면 엉뚱한 경험을 할 것입니다.
 우리는 몇 번의 작은 조정만으로 사용자에게 보내거나 표시하는 내용을 조정함으로써 더 사려 깊고 의도적으로 행동 할 수 있습니다.
 

ImageEngine과 같은 이미지 CDN을 사용하면 이미지 최적화 프로세스가 단순화되고 네트워크 제약 조건에 대한 클라이언트 힌트에 자동으로 응답합니다.
 그 결과 네트워크가 제한된 방문자에게는 더 나은 경험을 제공하고 개발자에게는 우아한 워크 플로를 제공합니다.
 