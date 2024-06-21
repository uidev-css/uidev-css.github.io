---
title: "패키지 없이 Flutter에서 스크롤로 페이지네이션 하는 방법"
description: ""
coverImage: "/assets/img/2024-06-21-FlutterPaginationOnScrollwithoutanypackages_0.png"
date: 2024-06-21 23:10
ogImage: 
  url: /assets/img/2024-06-21-FlutterPaginationOnScrollwithoutanypackages_0.png
tag: Tech
originalTitle: "Flutter Pagination On Scroll without any packages"
link: "https://medium.com/@m1nori/flutter-pagination-without-any-packages-8c24095555b3"
---


안녕하세요 여러분! 이 기사는 플러터에서 어떠한 패키지를 사용하지 않고 동적 인피니티 스크롤 페이징을 구현하는 방법에 대해 소개하고 있어요.
여기서 '동적' 이라는 용어는 스크롤 시 새로운 데이터를 로드하는 것을 의미합니다. maxScrollExtent 위치에 도달했을 때가 아니라는 거죠.

페이징은 항상 앱 개발에서 가장 싫어하는 부분 중 하나였어요. 무시할 수 없지만 제대로 구현할만한 방법을 찾지 못했어요. 저는 무한 스크롤 페이징 패키지를 선호하지 않아요. 왜냐하면 특별한 ListView를 사용하도록 강요하고 때로는 화면의 모든 로직과 레이아웃을 다시 만들어야 할 수도 있기 때문이에요.

그래서 이제 저는 스크롤 중에 페이징을 구현하는 방법을 나누려고 해요. 최적화되었고 데이터가 올바른 횟수만큼 로드되도록 노력했어요.

1) 먼저 PaginationScrollController 클래스를 작성해야 해요. 이 클래스는 loadAction 함수와 scrollController 자체를 저장할 거에요.
boundaryOffset은 데이터를 로드해야 하는 시점을 계산하는 데 사용돼요. 첫 번째로 화면의 반을 넘어가는 시점에 로드를 시작합니다. 그리고 그 다음에는 화면의 0.75 지점을 넘어갈 때 로드합니다. 수식은 다음과 같아요: boundaryOffset = 1-1/(currentPage*2)

<div class="content-ad"></div>

```js
class PaginationScrollController {
  late ScrollController scrollController;
  bool isLoading = false;
  bool stopLoading = false;
  int currentPage = 1;
  double boundaryOffset = 0.5;
  late Function loadAction;

  void init({Function? initAction, required Function loadAction}) {
    if (initAction != null) {
      initAction();
    }
    this.loadAction = loadAction;
    scrollController = ScrollController()..addListener(scrollListener);
  }

  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
  }

  void scrollListener() {
    if (!stopLoading) {
      //load more data
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent * boundaryOffset &&
          !isLoading) {
        isLoading = true;
        loadAction().then((shouldStop) {
          isLoading = false;
          currentPage++;
          boundaryOffset = 1 - 1 / (currentPage * 2);
          if (shouldStop == true) {
            stopLoading = true;
          }
        });
      }
    }
  }
}
```

2) 다음으로 로딩 함수를 작성해야 합니다. 다음과 같이 작성될 것입니다:

```js
  Future getNewRequests() async {
    int lastPage = pagination.lastPage;
    int currentPage = pagination.currentPage;
    if (lastPage > currentPage) {
      // 여기서 데이터를 가져옵니다. 예를 들어
      getRequests(currentPage + 1);
    } else if (lastPage == currentPage) {
      return true;
    }
  }
```

이 함수는 페이지네이션의 마지막 페이지에 도달하면 true를 반환합니다. 이것은 최적화를 위해 페이지네이션 컨트롤러에서 사용합니다.

<div class="content-ad"></div>

3) 마지막 단계는 컨트롤러를 SingleChildScrollView에 연결하는 것입니다. 따라서 우리가 할 일은:

3.1 컨트롤러 초기화 (그리고 dispose를 잊지 마세요)

```dart
class _MyScreenState extends State<MyScreen> {
  PaginationScrollController paginationScrollController =
      PaginationScrollController();

  @override
  void initState() {
    paginationScrollController.init(
        loadAction: () => context.read<RequestCubit>().getNewRequests());
    super.initState();
  }

  @override
  void dispose() {
    paginationScrollController.dispose();
    super.dispose();
  }
}
```

3.2 scrollController를 ListView에 연결하기

<div class="content-ad"></div>

```dart
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: SingleChildScrollView(
          controller: paginationScrollController.scrollController,
          child: Column(
            children: [
              // 필요한 데이터를 포함한 위젯
            ],
          ),
        )
      );
    
  }
```

다음은 구현한 예시입니다 (여기서는 10개의 요소가 있는 5페이지가 있습니다):

<img src="https://miro.medium.com/v2/resize:fit:1200/1*D-AaGGdptQ426UvWV7uNUw.gif" />

그게 다입니다! 동적 페이징이 구현되었습니다. 데이터가 항상 신선하게 유지되며 사용자는 로딩이나 지연을 전혀 눈치채지 못할 것입니다 (물론 안정적인 인터넷 연결이 있는 경우).