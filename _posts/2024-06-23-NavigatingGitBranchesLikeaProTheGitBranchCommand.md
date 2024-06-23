---
title: "Git 브랜치 명령어를 마스터하는 방법 전문가처럼 Git 브랜치 다루기"
description: ""
coverImage: "/assets/img/2024-06-23-NavigatingGitBranchesLikeaProTheGitBranchCommand_0.png"
date: 2024-06-23 15:01
ogImage: 
  url: /assets/img/2024-06-23-NavigatingGitBranchesLikeaProTheGitBranchCommand_0.png
tag: Tech
originalTitle: "Navigating Git Branches Like a Pro: The Git Branch Command"
link: "https://medium.com/git-happy/navigating-git-branches-like-a-pro-the-git-branch-command-f190eb7eb7b6"
---


<img src="/assets/img/2024-06-23-NavigatingGitBranchesLikeaProTheGitBranchCommand_0.png" />

프로 페셔널 소프트웨어 개발자로서, 코드베이스와 mapaches 🦝 커뮤니티 사이에 몇 가지 유사성을 알아차릴 수 있습니다. 이 둘 모두 복잡하게 조직되어 있고 이해하는 데 인내가 필요하며, 발견해야 할 숨겨진 보물이 많습니다.

이 기사에서는 명령줄과 GitHub Desktop을 사용하여 Git 브랜치의 숲 속 길을 안내하겠습니다. 네, 이 모험을 안내해 줄 가이드는 코드 mapache입니다, 왜냐하면 (히싱)! 

# Git에서 브랜치의 기초

<div class="content-ad"></div>

브랜치는 Git 버전 관리의 중요한 부분입니다. 이를 통해 개발자들은 주로 메인 브랜치(또는 때로는 develop 브랜치)를 방해하지 않고 동시에 다른 기능을 작업할 수 있습니다.


# 새로운 mapache 브랜치를 만들어봅시다!
git branch "new_mapache_branch"

# 새로운 브랜치로 이동해봅시다.
git checkout "new_mapache_branch"


이 새로운 브랜치에서 작업을 수행한 후에는 명령줄이나 PR에서 메인(또는 develop) 브랜치로 다시 병합할 수 있습니다.


# develop 브랜치로 변경합니다.
git checkout "develop"

# mapache 브랜치를 develop에 병합합니다.
git merge "new_mapache_branch"


<div class="content-ad"></div>

하지만 이미 알고 계시죠? 그러니 마치 우리의 mapache 친구들처럼 앞으로 달려가 더 많은 브랜치 관리 팁과 트릭에 대해 이야기해봅시다.

# 초보를 넘어서: Git을 활용한 브랜치 관리

git branch 명령어의 일부 기능 중 명확하지 않은 기능들은 브랜치를 쉽게 나열, 이름 변경 및 삭제할 수 있는 기능을 제공합니다.

```js
# 모든 브랜치 나열:
git branch

# 브랜치 이름 변경:
git branch -m "old_mapache_branch" "new_mapache_branch"

# 로컬 mapache 브랜치 삭제:
git branch -d "mapache_branch_to_delete"

# 원격 mapache 브랜치 삭제:
git branch -d -r "remote_mapache_branch_to_delete"
```

<div class="content-ad"></div>

-m 옵션은 브랜치의 이름을 변경할 때 사용되며, -d 옵션은 브랜치를 삭제할 때 사용됩니다. 하지만 주의해서 사용해주세요! 한 번 브랜치가 삭제되면 쉽게 되돌릴 수 없습니다.

게다가, 새로운 브랜치를 만들고 동시에 전환할 수도 있는데, git branch를 사용하지 않고 git checkout -b을 시도해보세요:

```js
# 새로운 브랜치를 생성하고 동시에 전환하기:
git checkout -b "another_mapache_branch"
```

나무를 빠르게 오르는 맵라체와 같이, 이 명령어는 땀 흘리지 않고 새로운 브랜치에서 작업을 시작할 수 있도록 도와줍니다.

<div class="content-ad"></div>

# GitHub Desktop을 사용하여 브랜치 보기 및 삭제하기

명령 줄은 훌륭하지만 때로는 시각적 인터페이스가 모든 차이를 만들어 줍니다. 여기 GitHub Desktop이 나의 가장 좋아하는 Git GUI입니다.

GitHub Desktop에서 레파지토리를 열고 GUI의 상단 작업 행의 중간에 있는 Current Branch 버튼을 클릭하세요. 여기서 모든 브랜치 목록이 표시됩니다. 브랜치를 클릭하면 해당 브랜치가 자동으로 체크아웃되며 새 브랜치를 생성하는 것도 매우 쉽습니다.

GitHub Desktop에서 새 브랜치를 생성하려면 상단의 Branch 메뉴를 클릭한 후 New branch... 메뉴 옵션을 선택하세요. 기본 브랜치(일반적으로 main)에 있지 않은 경우 현재 브랜치에서 분기를 만들 것인지 기본(main)에서 분기를 만들 것인지 선택할 수 있습니다.

<div class="content-ad"></div>

이제 새 브랜치 이름을 입력란에 작성하고 "브랜치 생성" 버튼을 클릭하세요. 그러면 자동으로 체크아웃됩니다. 마치 git checkout -b처럼요.

브랜치를 삭제하려면 다시 맨 위의 현재 브랜치 버튼을 클릭하여 모든 브랜치 목록으로 돌아가세요. 특정 브랜치에서 마우스 오른쪽 버튼을 클릭한 후 삭제...를 선택하고 확인하면 브랜치가 삭제됩니다. 마치 수풀 속에서 사라지는 맵라체나 git branch -d 명령어처럼요.

# 코드 협업을 위한 원격 Git 브랜치 사용

우리의 Git 모험에서 원격 브랜치를 관리하는 개념은 중요합니다. 우리는 로컬에서 Git을 사용할 수 있지만 코드를 원격 "origin" 서버에 공유하지 않는 한, 우리는 일반적으로 다른 전문 개발자들과 협업하고 있습니다.

<div class="content-ad"></div>

원격 브랜치는 원격 저장소인 "origin 서버"에 있는 브랜치의 상태를 가리키는 참조(포인터)를 제공합니다. 원격 브랜치는 마치 북마크처럼 작동하여 원격 저장소의 브랜치가 마지막으로 연결된 시점을 상기시킵니다.

다음과 같이 원격 브랜치를 가져올 수 있습니다:

```js
# "origin 서버"로부터 원격 브랜치 가져오기
git fetch origin "remote_mapache_branch"
```

해당 원격 브랜치에서 작업을 시작하려면 이전과 같이 git checkout -b 명령을 사용하여 해당 원격 브랜치를 확인하고 로컬 브랜치를 생성해야합니다:

<div class="content-ad"></div>

```js
# "tracking branch"을 사용하여 원격 브랜치를 로컬 브랜치로 체크아웃하기
git checkout -b "local_mapache_branch" origin/"remote_mapache_branch"
```

그러면 Git은 로컬 브랜치와 해당 원격 브랜치를 연결하는 "tracking branch" 또는 "upstream branch"를 설정합니다.

로컬 브랜치를 원격 저장소로 푸시하려면 다음을 사용합니다:

```js
# 로컬 브랜치를 원격 저장소인 origin에 푸시하기
git push origin "local_mapache_branch"

# "tracking branch"로 설정되어 있으므로 origin/"remote_mapache_branch"가 업데이트됩니다
```

<div class="content-ad"></div>

이것은 다른 사람들에게 당신이 거기에 있었고 변경 사항을 만들 수도 있다는 것을 알리는 코드 mapache가 표시된 것과 비슷합니다. 🦝

GitHub 데스크톱에서 브랜치를 삭제하는 주제로 돌아가면, 로컬 브랜치를 삭제하려고 시도하면 원격 브랜치를 추적하는 경우 로컬 브랜치만 삭제할지 원격 브랜치도 삭제할지 물어보게 됩니다.

# 오래된 브랜치 정리: Git Fetch 대 브랜치 삭제

좋은 mapache가 하루 종일 쓰레기를 먹은 후에 서식지를 청소하는 것과 마찬가지로, Git은 오래된 사용되지 않는 브랜치를 정리할 수 있도록 해줍니다. 🧹

<div class="content-ad"></div>

협업자가 원격 저장소에서 브랜치를 삭제할 때, 로컬 저장소는 이러한 브랜치에 대한 참조를 제거하지 않습니다.

시간이 지남에 따라 이러한 구식된 참조(또한 "둥근 브랜치"라고도 함)가 저장소를 메우기 시작합니다.

이러한 참조를 제거하기 위해 Git은 --prune 옵션을 제공합니다.

```js
# 브랜치 정리
git fetch --prune
```

<div class="content-ad"></div>

--prune 옵션은 삭제된 원격 브랜치에 대한 로컬 저장소의 원격 추적 참조를 제거합니다.

또한 "마스터에 병합된 로컬 브랜치에서 지난 한 달 이내의 마지막 커밋이 있는 경우 삭제 명령만 표시하는 안전한 방법을 공유하고 싶습니다":

```js
for k in $(git branch --format="%(refname:short)" --merged master); do 
  if (($(git log -1 --since='1 month ago' -s $k|wc -l)==0)); then
    echo git branch -d $k
  fi
done
```

이는 estani의 스택 오버플로 응답에서 나온 내용으로, 엔지니어링 팀을 관리하는 업무에서 유용하게 사용했던 내용입니다.

<div class="content-ad"></div>

해당 명령은 git branch -d 명령어를 화면에 출력하기 때문에 실행하기 전에 명령어를 미리 확인하는 안전한 방법입니다.

댓글러인 Asaf Pinhassi라는 사람이 이 명령에 -r을 추가하여 원격 브랜치를 나열할 수 있다는 팁을 제시했는데, 이것을 여기에 추가하는 것은 좋은 팁입니다!

# 그럼 이만 해요! 여러분! 전 다 브랜치로 이루어진 상태입니다.

우리는 쥐너구리처럼 유연하게 Git 브랜치의 덤불을 탐험했습니다. 브랜치를 만들고, 이름을 바꾸고, 삭제하는 방법을 보았으며, 시각적 브랜치 관리를 위해 GitHub Desktop을 사용하는 방법과 오래된 브랜치를 정리하는 방법을 살펴보았습니다.

<div class="content-ad"></div>

Git 브랜치 습득은 지도처럼 이해해야 한다는 걸 기억해두세요: 인내와 시간이 필요합니다. 그러나 한 번 이해하면, 브랜치는 개발과 협업을 원할하게 돕는 다재다능한 도구임을 깨닫게 될 거에요.

코딩 즐기세요! 🌲

이 글을 좋아하셨다면, 제 다른 인기 글 몇 개도 좋아하실 거에요:

![2024-06-23-NavigatingGitBranchesLikeaProTheGitBranchCommand_1.png](/assets/img/2024-06-23-NavigatingGitBranchesLikeaProTheGitBranchCommand_1.png)