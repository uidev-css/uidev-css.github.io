---
title: "Flutter Web Github Pages에 배포하는 방법"
description: ""
coverImage: "/assets/img/2024-06-21-FlutterWebGithubpages_0.png"
date: 2024-06-21 20:12
ogImage: 
  url: /assets/img/2024-06-21-FlutterWebGithubpages_0.png
tag: Tech
originalTitle: "[Flutter] Web Github pages"
link: "https://medium.com/@sidcode/flutter-web-github-pages-9513667ef3f1"
---


- 이미 "your_id.github.io" 레포지토리를 생성했어요
- 이미 플러터 웹 프로젝트를 만들었어요

- 도메인을 소유하고 계신다면, 플러터 프로젝트 디렉토리로 이동해주세요

```sh
$ cd my_flutter_directory
$ echo -e 'sidcode.me' > web/CNAME
$ cat web/CNAME         
sidcode.me
```

2. 플러터 웹 빌드

<div class="content-ad"></div>

```js
$ flutter build web --release
------------------------------  
폰트 자산 "CupertinoIcons.ttf"이 트리 쉐이크되어 257628바이트에서 1172바이트로 줄었습니다 (99.5% 감소). 앱을 빌드할 때 --no-tree-shake-icons 플래그를 제공하면 트리 쉐이킹을 비활성화할 수 있습니다.
폰트 자산 "MaterialIcons-Regular.otf"이 트리 쉐이크되어 1645184바이트에서 7760바이트로 줄었습니다 (99.5% 감소). 앱을 빌드할 때 --no-tree-shake-icons 플래그를 제공하면 트리 쉐이킹을 비활성화할 수 있습니다.
lib/main.dart를 웹용으로 컴파일 중...                           1,407밀리초
✓ build/web가 생성되었습니다
```

3. flutter build web으로 생성된 웹 페이지로 이동하기

```js
$ cd build/web/
$ ls -all                                                   
drwxr-xr-x sidcode staff 480 B  Thu Jun 20 15:56:49 2024  .
drwxr-xr-x sidcode staff  96 B  Thu Jun 20 15:56:47 2024  ..
.rw-r--r-- sidcode staff  32 B  Thu Jun 20 15:56:49 2024  .last_build_id
drwxr-xr-x sidcode staff 320 B  Thu Jun 20 15:56:48 2024  assets
drwxr-xr-x sidcode staff 320 B  Thu Jun 20 15:56:47 2024  canvaskit
.rw-r--r-- sidcode staff  13 B  Thu Jun 20 15:51:32 2024  CNAME
.rw-r--r-- sidcode staff 917 B  Wed Feb  1 13:05:06 2023  favicon.png
.rw-r--r-- sidcode staff 7.6 KB Tue Jun  4 21:05:58 2024  flutter.js
.rw-r--r-- sidcode staff 7.9 KB Thu Jun 20 15:56:48 2024  flutter_bootstrap.js
.rw-r--r-- sidcode staff 8.0 KB Thu Jun 20 15:56:49 2024  flutter_service_worker.js
drwxr-xr-x sidcode staff 192 B  Thu Jun 20 15:56:48 2024  icons
.rw-r--r-- sidcode staff 1.2 KB Thu Jun 20 15:56:48 2024  index.html
.rw-r--r-- sidcode staff 1.5 MB Thu Jun 20 15:47:11 2024  main.dart.js
.rw-r--r-- sidcode staff 928 B  Thu Jun 20 15:35:13 2024  manifest.json
.rw-r--r-- sidcode staff 102 B  Thu Jun 20 15:56:48 2024  version.json
```

4. git push


<div class="content-ad"></div>

```js
$ git init && git add . && git commit -m  "init" && git branch -M gh-pages
===============================================
$ git remote add origin https://github.com/[your_id]/[repo_name].git
 ******** 토큰이 없는 경우 혹은 깃허브 토큰이 필요한 경우 선택 
$ git remote add origin https://[your_id]:[your_token]@github.io/{your_id}/{repo_name}.git
===============================================
$ git push -u origin gh-pages
------------------------------------------------
오브젝트 나열 중: 43, 완료.
오브젝트 개수 측정 중: 100% (43/43), 완료.
Delta 압축이 최대 10개의 스레드로 이용됨
오브젝트 압축 중: 100% (37/37), 완료.
오브젝트 쓰기 중: 100% (43/43), 5.50 MiB | 5.07 MiB/s, 완료.
총 43 (델타 6), 재사용 0 (델타 0), 팩 재사용 0 (0개로부터)
remote: 변화 해결 중: 100% (6/6), 완료.
To https://github.com/sidcodeme/sidcodeme.github.io.git
 * [새 브랜치]      gh-pages -> gh-pages
'gh-pages' 브랜치가 'origin/gh-pages'를 추적하도록 설정되었습니다.
```

5. 깃허브 페이지 설정

<img src="/assets/img/2024-06-21-FlutterWebGithubpages_0.png" />

작업 완료! 홈페이지로 이동합시다!!!!!


<div class="content-ad"></div>


![Image](/assets/img/2024-06-21-FlutterWebGithubpages_1.png)
