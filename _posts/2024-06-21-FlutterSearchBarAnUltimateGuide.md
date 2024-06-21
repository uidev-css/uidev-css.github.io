---
title: "Flutter 검색바 궁극의 가이드"
description: ""
coverImage: "/assets/img/2024-06-21-FlutterSearchBarAnUltimateGuide_0.png"
date: 2024-06-21 23:41
ogImage: 
  url: /assets/img/2024-06-21-FlutterSearchBarAnUltimateGuide_0.png
tag: Tech
originalTitle: "Flutter SearchBar: An Ultimate Guide"
link: "https://medium.com/stackademic/flutter-searchbar-an-ultimate-guide-011a8ae0aa9a"
---


# 소개

모바일 앱 개발 분야에서 잘 설계된 검색 기능은 편의성뿐만 아니라 사용자 참여 및 접근성을 크게 향상시키는 중요한 구성 요소입니다. 특히 방대한 데이터를 다루는 애플리케이션의 경우에는 이러한 요소가 더욱 중요합니다. 모바일 개발자들 사이에서 인기를 끌고 있는 Flutter는 네이티브 컴파일된 애플리케이션을 구축하기 위한 훌륭한 프레임워크로 두드러집니다. 이 글에서는 Flutter에서 다양한 검색 위젯을 디자인하는 여정을 시작해 CustomSearchDelegate와 같은 범용 위젯을 생성하는 방법을 살펴보겠습니다. 우리는 검색을 구현하기 위해 showSearch 메서드를 활용할 것입니다. 먼저 기본 검색 바를 만들고, 이후에는 임의의 프로젝트에서 사용할 수 있는 방식으로 커스터마이징할 것입니다.

결과물은 이렇게 보일 것입니다.

# showSearch:

<div class="content-ad"></div>

ShowSearch은 플러터의 머티리얼 라이브러리에 있는 메소드입니다. 따라서 위젯 트리 어디에서나 접근할 수 있습니다.

```js
Future<T?> showSearch<T>({
  required BuildContext context,
  required SearchDelegate<T> delegate,
  String? query = '',
  bool useRootNavigator = false,
})
```

이 메소드는 BuildContext와 SearchDelegate를 필요로 합니다. SearchDelegate는 T 타입의 파라미터를 받는 추상 클래스입니다.

예시:

<div class="content-ad"></div>

```js
 showSearch(context: context, delegate: CustomSearchDelegate());
```

따라서 검색 기능을 구현하려면 SearchDelegate를 확장하는 클래스를 만들면 됩니다. 그것이 어떻게 이루어지는지 살펴봅시다.

```js
class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // 할 일: buildActions 구현
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // 할 일: buildLeading 구현
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // 할 일: buildResults 구현
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // 할 일: buildSuggestions 구현
    throw UnimplementedError();
  }

}
```

SearchDelegate는 4개의 메소드를 구현하도록 요구합니다.


<div class="content-ad"></div>

- buildActions: 검색 쿼리를 지우는 작업과 같은 액션을 관리합니다. AppBar의 action 매개변수와 유사합니다.
- buildLeading: 일반적으로 네비게이션을 위한 뒤로가기 버튼이 포함됩니다.
- buildResults: 검색 결과를 표시합니다.
- buildSuggestions: 사용자가 쿼리를 입력하는 동안 제안을 제공합니다.

이 델리게이트를 사용하여 기본 검색을 구현해봅시다.

```js
class CustomSearchDelegate extends SearchDelegate {
  List<String> searchables = List.generate(100, (index) => '아이템 ${index + 1}');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, []);
      },
      icon: Icon(
        Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
        size: 22,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SuggestionOrResultWidget(searchables: searchables, query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SuggestionOrResultWidget(searchables: searchables, query: query);
  }
}
```

```js
class SuggestionOrResultWidget extends StatelessWidget {
  const SuggestionOrResultWidget({
    key,
    required this.searchables,
    required this.query,
  });

  final List<String> searchables;
  final String query;

  @override
  Widget build(BuildContext context) {
    final List<String> suggestions = query.isEmpty
        ? searchables
        : searchables.where((element) => element.toLowerCase().contains(query.toLowerCase())).toList();

    if (suggestions.isEmpty) return const NoResultWidget();

    return ListView.separated(
      itemBuilder: (context, index) => ListTile(
        title: Text(suggestions[index]),
      ),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: suggestions.length,
    );
  }
}
```

<div class="content-ad"></div>

```js
class NoResultWidget extends StatelessWidget {
  const NoResultWidget({Key key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No Result Found'),
    );
  }
}
```

결과는 다음과 같이 나타납니다

<img src="https://miro.medium.com/v2/resize:fit:752/1*06CrNqmR7P5yqvzpGdtdXw.gif" />

# 검색 페이지 앱바의 ThemeData 사용자 정의하기


<div class="content-ad"></div>

하나 주목할 점은 검색 페이지를 표시할 때 앱의 테마와 동일하지 않다는 것입니다. 이는 특히 AppBar의 색상에서 확인할 수 있습니다. 아래 코드는 검색 페이지의 AppBar에 앱의 ThemeData를 직접 전달합니다.

```js
class CustomSearchDelegate extends SearchDelegate {
  List<String> searchables = List.generate(100, (index) => 'Item ${index + 1}');

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      // 앱바 테마를 사용자 정의합니다.
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      // 입력 장식 테마를 사용자 정의합니다.
      inputDecorationTheme: const InputDecorationTheme(
        isDense: true,
        isCollapsed: true,
        contentPadding: EdgeInsets.only(left: 12, top: 6, bottom: 6),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.white,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.white,
        )),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
```

<img src="/assets/img/2024-06-21-FlutterSearchBarAnUltimateGuide_0.png" />

# 일반적인 검색 위젯 만들기:

<div class="content-ad"></div>

더 고급 구현으로 나아가기 위해 CustomSearchDelegate를 자세히 살펴봅시다. 이 일반적인 위젯은 여러 데이터 유형에서 재사용성과 적응성을 가장합니다.

```js
/// 어디서나 사용할 수 있는 제네릭 검색 대리자입니다
class CustomSearchDelegate<T> extends SearchDelegate<List<T>> {
  CustomSearchDelegate({
    required this.searchables,
    required this.suggestionOrResult,
    required this.itemMatcher,
    this.onTap,
  });
  
  // 검색 대상 항목
  final List<T> searchables;
  
  // 제안 또는 결과를 가져올 때 표시해야 하는 위젯입니다.
  // 제안과 결과에 대해 별도의 위젯을 사용하려면 suggestionWidget 및 resultWidget을 추가하여 
  // 다른 방식으로 빌드할 수 있습니다.
  final Widget Function(List<T>, String) suggestionOrResult;

  // 일치 실행에 대한 쿼리
  final bool Function(T item, String query) itemMatcher;

  // 항목이 탭될 때의 콜백
  final ValueChanged<T>? onTap;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, []);
      },
      icon: Icon(
        Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
        size: 22,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSuggestionOrResult();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (searchables.isEmpty) return const SizedBox();
    return _buildSuggestionOrResult();
  }

  Widget _buildSuggestionOrResult() {
    final List<T> suggestionList =
        query.isEmpty ? searchables : searchables.where((item) => itemMatcher(item, query)).toList();

    if (suggestionList.isEmpty) {
      return NoResultFoundWidget();
    }

    return suggestionOrResult(suggestionList, query);
  }

}
```

다음과 같이 이 일반 대리자를 사용할 수 있습니다:
```js
showSearch(
  context: context,
  delegate: CustomSearchDelegate<List<String>>(
    searchables: searchables,
    suggestionOrResult: (List<String> suggestions, String query) => ListWidget(
      suggestionsList: searchables,
      query: query,
    ),
    itemMatcher: (String item, String query) => item.toLowerCase().contains(query.toLowerCase()),
  ),
)
```

<div class="content-ad"></div>

# 보너스:

만일 입력된 글자를 제시 목록에서 강조하고 결과로 스크롤하고 싶다면 다음 위젯을 사용할 수 있습니다.

```js
class ListWidget extends StatefulWidget {
  const ListWidget({
    super.key,
    required this.suggestionsList,
    required this.query,
  });

  final List<String> suggestionsList;
  final String query;

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  late List<String> filteredList;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    filterList();
  }

  @override
  void didUpdateWidget(ListWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.query != oldWidget.query) {
      filterList();
    }
  }

  void filterList() {
    filteredList =
        widget.suggestionsList.where((item) => item.toLowerCase().contains(widget.query.toLowerCase())).toList();

    if (filteredList.isNotEmpty) {
      if (filteredList.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) => scrollToFirstMatch());
      }
    }
  }

  void scrollToFirstMatch() {
    int index = widget.suggestionsList.indexOf(filteredList.first);
    if (index != -1 && scrollController.hasClients) {
      scrollController.animateTo(
        index * 32.0, // 각 항목의 높이가 32로 가정
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        final String suggestionText = filteredList[index];
        return ListTile(
          title: RichText(
            text: highlightMatch(suggestionText, widget.query),
          ),
          onTap: () {
            // 여기에 탭 기능을 추가하세요
          },
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }

  TextSpan highlightMatch(String text, String query) {
    if (query.isEmpty || !text.toLowerCase().contains(query.toLowerCase())) {
      return TextSpan(
        text: text,
        style: const TextStyle(color: Colors.black),
      );
    }

    List<TextSpan> spans = [];
    int start = 0;
    int indexOfHighlight = text.toLowerCase().indexOf(query.toLowerCase());

    while (indexOfHighlight != -1) {
      spans.add(TextSpan(
        text: text.substring(start, indexOfHighlight),
        style: const TextStyle(color: Colors.black),
      ));
      spans.add(TextSpan(
        text: text.substring(indexOfHighlight, indexOfHighlight + query.length),
        style: const TextStyle(backgroundColor: Colors.yellow, color: Colors.black),
      ));

      start = indexOfHighlight + query.length;
      indexOfHighlight = text.toLowerCase().indexOf(query.toLowerCase(), start);
    }

    spans.add(TextSpan(
      text: text.substring(start),
      style: const TextStyle(color: Colors.black),
    ));
    return TextSpan(children: spans);
  }
}
```

<img src="https://miro.medium.com/v2/resize:fit:468/1*8xf8nCjiihJQ-XUSlLe5MA.gif" />

<div class="content-ad"></div>

# 결론:

모바일 앱 디자인에서 효과적인 검색 기능은 사용자 만족도와 참여도에 중요한 요소입니다. 이 CustomSearchDelegate은 플러터 앱에서 사용자 정의 및 다양한 검색 기능을 만들기 위한 템플릿을 제공합니다.

독서해 주셔서 감사합니다. 즐거운 코딩 하세요 :)

# Stackademic

<div class="content-ad"></div>

끝까지 읽어주셔서 감사합니다. 떠나시기 전에:

- 작가를 격려하고 팔로우해 주세요! 👏
- 트위터(X), 링크드인, 그리고 유튜브에서 저희를 팔로우해 주세요.
- 전세계에서 무료 프로그래밍 교육을 민주화하고 있는 Stackademic.com을 방문해보세요.