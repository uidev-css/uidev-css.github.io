---
title: "Xcode 정리해서 MacBook을 빠르게 만들기"
description: ""
coverImage: "/assets/img/2024-06-19-CleanYourXcodeandFreeUpHardDriveSpacetoMakeYourMacBookRunFaster_0.png"
date: 2024-06-19 00:08
ogImage: 
  url: /assets/img/2024-06-19-CleanYourXcodeandFreeUpHardDriveSpacetoMakeYourMacBookRunFaster_0.png
tag: Tech
originalTitle: "Clean Your Xcode and Free Up Hard Drive Space to Make Your MacBook Run Faster"
link: "https://medium.com/@arshguleria1612/clean-your-xcode-and-free-up-hard-drive-space-to-make-your-macbook-run-faster-f6934be0b02f"
---


<img src="/assets/img/2024-06-19-CleanYourXcodeandFreeUpHardDriveSpacetoMakeYourMacBookRunFaster_0.png" />

iOS 앱을 개발하고 Xcode가 MacBook을 느리게 만드는 걸 느끼고 있나요? 걱정 마세요! 유료 소프트웨어에 의존하지 않는 완벽한 기사를 찾았습니다. 이 안내서를 마치면 Xcode 환경을 정리하고 가치 있는 하드 드라이브 공간을 확보하여 개발 프로세스를 훨씬 빠르게 만들 수 있습니다.

Xcode는 iOS 앱을 개발하는 데 훌륭한 도구이지만 시간이 지남에 따라 많은 불필요한 파일을 축적하기 마련입니다. 이는 시스템을 느리게 만들고 소중한 디스크 공간을 소비할 수 있습니다. 이 기사에서는 내장된 도구와 명령어만을 사용하여 Xcode 환경을 정리하는 중요한 단계를 안내해 드리겠습니다. 유료 소프트웨어가 필요하지 않습니다!

시작해보고 공간을 확보하고 성능을 개선하기 위해 안전하게 제거할 수 있는 일부 폴더를 살펴보겠습니다.

<div class="content-ad"></div>

## 1: Xcode 로그

경로: ~/Library/Developer/Xcode/iOS Device Logs

시간이 지남에 따라 Xcode 로그도 많은 디스크 공간을 차지할 수 있습니다. 이 로그는 디버깅에 유용하지만 필요하지 않은 경우 안전하게 삭제할 수 있습니다. 로그 디렉토리로 이동하여 모든 로그를 삭제하세요:

```js
cd ~/Library/Developer/Xcode/iOS Device Logs
rm -rf *
```

<div class="content-ad"></div>

이는 깔끔한 개발 환경을 유지하는 데 도움이 됩니다.

## 2: 앱 캐시 빌드

경로: ~/Library/Developer/Xcode/DerivedData

프로젝트를 빌드할 때 Xcode가 파생 데이터를 많이 생성합니다. 이 데이터는 안전하게 삭제할 수 있으며 다음 프로젝트 빌드 시 다시 생성됩니다. DerivedData 디렉토리로 이동하여 모든 하위 디렉터리를 제거하세요.

<div class="content-ad"></div>

```sh
cd ~/Library/Developer/Xcode/DerivedData
rm -rf *
```

이 방법을 사용하면 상당한 공간을 확보할 수 있습니다.

## 3: 사용하지 않는 디바이스

경로: ~/Library/Developer/CoreSimulator/Devices
```

<div class="content-ad"></div>

Xcode를 사용하면서 시간이 지남에 따라 테스트 목적으로 많은 시뮬레이터 장치가 생성됩니다. 이러한 시뮬레이터 중 많은 것들이 더 이상 사용되지 않으며 안전하게 삭제할 수 있습니다. 사용되지 않는 시뮬레이터를 삭제하려면 터미널을 열고 다음 명령어를 실행하십시오:

```js
xcrun simctl delete unavailable
```

이 명령어를 실행하면 더 이상 필요하지 않은 시뮬레이터를 삭제하여 하드 드라이브 공간을 확보할 수 있습니다.

## 4: 오래된 장치 지원 파일

<div class="content-ad"></div>

경로: ~/Library/Developer/Xcode/iOS DeviceSupport

iOS 기기를 MacBook에 연결하면 Xcode가 해당 기기의 지원 파일을 저장합니다. 이러한 파일은 여러 기기를 연결하거나 iOS 버전을 업데이트한 경우 특히 빠르게 증가할 수 있습니다. 지정된 경로로 이동하여 더 이상 필요하지 않은 이전 iOS 버전과 관련된 디렉토리를 수동으로 삭제하세요.

예를 들어, 더 이상 해당 iOS 버전을 대상으로 하지 않는 경우 9.0.0과 같이 명명된 폴더를 안전하게 삭제할 수 있습니다.

## 5: 불필요한 캐시 파일

<div class="content-ad"></div>

테이블 태그를 Markdown 형식으로 변경해보세요.

<div class="content-ad"></div>

## 6: 불필요한 아카이브

경로: ~/Library/Developer/Xcode/Archives

Xcode에서 빌드를 아카이브할 때마다, 해당 아카이브는 Archives 디렉토리에 저장됩니다. 이러한 아카이브는 빠르게 누적되어 많은 공간을 차지할 수 있습니다. 이를 정리하려면, Archives 디렉토리로 이동하여 더 이상 필요하지 않은 이전 아카이브를 모두 또는 선택적으로 삭제하십시오:

```bash
cd ~/Library/Developer/Xcode/Archives
rm -rf *
```

<div class="content-ad"></div>

이 작업을 수행하면 빌드를 자주 아카이브하는 경우 상당한 공간을 절약할 수 있습니다.

## 7: 기타 불필요한 파일

경로: ~/Library/Caches/..

캐시 디렉토리에는 Xcode를 포함한 다양한 애플리케이션의 캐시된 파일이 저장됩니다. 이러한 파일을 지우려면 캐시 디렉토리로 이동하여 모든 하위 디렉토리를 제거하세요:

<div class="content-ad"></div>

```sh
cd ~/Library/Caches
rm -rf *
```

이 단계를 따르면 MacBook에서 중요한 공간을 확보할 수 있고 Xcode를 원할하게 실행할 수 있습니다. 이 방법들은 모두 무료이며 기본 도구를 사용하기 때문에 별도의 소프트웨어를 다운로드할 필요가 없습니다. 유료 소프트웨어가 필요하지 않습니다. 이미 Mac에서 사용할 수 있는 도구들만 있으면 됩니다! 즐겁게 코딩하고 더 빠르고 효율적인 개발 경험을 즐기세요!