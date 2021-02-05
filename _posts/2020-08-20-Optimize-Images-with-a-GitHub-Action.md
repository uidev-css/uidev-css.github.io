---
layout: post
title: "GitHub 작업으로 이미지 최적화"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/08/github-actions-image-opt.png
tags: GITHUB,GITHUB ACTIONS
---


나는 요전 날 GitHub Actions를 가지고 놀고 있었다. 정말 좋은 도구네요! 요약: 빌드 프로세스, 테스트 및 배포 실행과 같은 코드를 실행할 수 있습니다. 그러나 구성 파일은 필요한 모든 것을 실행할 수 있습니다. 당신을 위해 일하기를 원하는 모든 행동 시장이 있다.

제가 하고 싶었던 것은 이미지 최적화를 위해 코드를 실행하는 것이었습니다. 그런 식으로 나는 그것에 대해 생각할 필요가 없다. 레포의 모든 이미지가 최적화되었습니다.

이미 이 작업에 대한 작업이 있습니다. 여기서 활용할 Calibre의 이미지 액션입니다. 또한 리포지토리에 대해 작업이 사용 가능한지 확인해야 합니다. 주요 조직에서는 옵션 중 하나인 레포당 작업만 실행한다는 것을 알 수 있습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/08/github-actions-branch.png?resize=1024%2C731&ssl=1)

그런 다음 `/ghub/workflow/optimize-images.yml`에서 파일을 만듭니다. 여기서 이 작업을 구성할 수 있습니다. 원하는 경우 모든 작업에 별도의 파일이 포함될 수 있습니다. (1) 이 파일은 "Push to pull requests"에서만 작동하므로 다른 트리거에서 실행되는 다른 작업이 있으면 해당 작업이 제대로 혼합되지 않습니다. (2) 문서에는 이러한 내용이 있으며 권장 사용법처럼 보입니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/08/Screen-Shot-2020-08-18-at-9.06.48-AM.png?resize=1024%2C549&ssl=1)

```html
name: Optimize images
on: pull_request
jobs:
  build:
    name: calibreapp/image-actions
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Repo
        uses: actions/checkout@master

      - name: Compress Images
        uses: calibreapp/image-actions@master
        with:
          githubToken: ${ secrets.GITHUB_TOKEN }
```

꺼내기 요청을 하면 다음과 같이 실행됩니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/08/Screen-Shot-2020-08-18-at-8.57.15-AM.png?resize=1024%2C827&ssl=1)

이 성공적인 실행은 풀 요청에 대한 코멘트를 남깁니다. 풀 요청에 최적화한 내용은 다음과 같습니다.

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/08/Screen-Shot-2020-08-18-at-8.56.07-AM.png?resize=1024%2C331&ssl=1)

그러면 해당 파일도 꺼내기 요청에 다시 커밋되므로 꺼내기 요청을 그대로 유지하고 작업을 계속하려면 다시 밀어넣어야 최적화된 이미지를 얻을 수 있습니다.

자동 커밋을 통해 그 차이를 확인할 수 있습니다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/08/Screen-Shot-2020-08-18-at-8.57.30-AM.png?resize=1004%2C954&ssl=1)

모든 것을 잘 알고 PR을 병합하는 방법:

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/08/Screen-Shot-2020-08-18-at-9.10.44-AM.png?resize=1024%2C485&ssl=1)

꽤 멋지다. 이미지를 로컬에서 최적화하는 것이 특히 어렵습니까? 아니, 다시는 그런 생각 안 해도 돼? 네, 여기 기술 부채가 조금 있긴 하지만 다른 데로 줄이는 건 아주 공정한 거래예요 적어도 제 책에서는요