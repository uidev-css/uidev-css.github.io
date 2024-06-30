---
title: "DropdownMenu  검색 가능한 드롭다운 Flutter 폼을 향상시키는 방법"
description: ""
coverImage: "/assets/img/2024-06-21-DropdownMenuAsearchabledropdownSuperchargeyourFlutterforms_0.png"
date: 2024-06-21 23:34
ogImage:
  url: /assets/img/2024-06-21-DropdownMenuAsearchabledropdownSuperchargeyourFlutterforms_0.png
tag: Tech
originalTitle: "DropdownMenu — A searchable dropdown: Supercharge your Flutter forms!"
link: "https://medium.com/@mohan-smk23/dropdownmenu-a-searchable-dropdown-supercharge-your-flutter-forms-8dde6d46809f"
---

세 번째 파티 제약을 작별하고! 플러터에서 검색 가능한 드롭다운을 만들어보세요. 검색과 스타일이 적용된 여러분만의 드롭다운.

플러터 DropdownMenu 마스터하기 - 아름답고 강력한 메뉴에 대한 안내

![DropdownMenu](/assets/img/2024-06-21-DropdownMenuAsearchabledropdownSuperchargeyourFlutterforms_0.png)

우리가 목표로 하고 있는 것은 아래와 같아요 👇🏻

<div class="content-ad"></div>

아래는 마크다운 형식으로 변경한 코드입니다.

![이미지](https://miro.medium.com/v2/resize:fit:530/1*7fLEf7WBv-qxlUx5vDYMPQ.gif)

### 준비되셨나요? 코드 작성을 시작해봅시다!

- 드롭다운 메뉴에 표시하고 싶은 항목 목록을 준비해봅시다. 이것은 문자열, 객체 또는 위젯의 리스트일 수 있습니다.

```js
class MenuItem {
  final int id;
  final String label;
  final IconData icon;

  MenuItem(this.id, this.label, this.icon);
}

List<MenuItem> menuItems = [
  MenuItem(1, '홈', Icons.home),
  MenuItem(2, '프로필', Icons.person),
  MenuItem(3, '설정', Icons.settings),
  MenuItem(4, '즐겨찾기', Icons.favorite),
  MenuItem(5, '알림', Icons.notifications),
];
```

<div class="content-ad"></div>

여기 검색 가능한 DropdownMenu의 코드입니다.

```js
DropdownMenu<MenuItem>(
                initialSelection: menuItems.first,
                controller: menuController,
                width: width,
                hintText: "메뉴 선택",
                requestFocusOnTap: true,
                enableFilter: true,
                label: const Text('메뉴 선택'),
                onSelected: (MenuItem? menu) {
                  selectedMenu = menu;
                },
                dropdownMenuEntries:
                    menuItems.map<DropdownMenuEntry<MenuItem>>((MenuItem menu) {
                  return DropdownMenuEntry<MenuItem>(
                      value: menu,
                      label: menu.label,
                      leadingIcon: Icon(menu.icon));
                }).toList(),
              ),
```

요령있죠! DropdownMenuEntry는 각 메뉴 항목의 이름표처럼 동작하여 프로그램에 누구인지 알려주고 사용자에게 어떤 동작을 하는지 보여줍니다.

<div class="content-ad"></div>

테이블 태그를 Markdown 형식으로 변경해 주세요.

<div class="content-ad"></div>

장점:

- 내장: 추가 패키지가 필요하지 않으며, 플러터에서 쉽게 사용할 수 있습니다.
- 사용하기 쉬움: 간단한 드롭다운 메뉴에 대한 기본 구현이 있습니다.
- 사용자 정의 옵션: 메뉴 스타일, 초기 선택 및 필터링 동작을 제어할 수 있습니다.
- 기본적인 요구에 적합: 기능이 제한된 간단한 드롭다운 메뉴에 적합합니다.

단점:

- 검색 기능이 제한적: 내장 필터링이 기본적이며, 레이블의 처음만 일치하는 것만 지원합니다.
- 사용자 정의 제한: 개별 목록 항목을 사용자 정의하거나 복잡한 검색 로직을 구현할 수 없습니다.
- 고급 기능 없음: 자동 완성, 제안 또는 다중 선택과 같은 기능이 없습니다.

그래서, 여기가 함정입니다.

<div class="content-ad"></div>

단순한 드롭다운 및 기본 필터링이 필요하다면, 내장된 DropdownMenu를 사용하세요! 고급 검색, 화려한 사용자 정의 또는 추가 기능이 필요하다면 강력한 dropdown_search 패키지를 선택하세요. 쉽죠!

도움이 되었으면 좋겠네요!

모한쿠마르

중요한 질문이 있고 제가 놓치기를 원치 않으시면, mohan.smk23@gmail.com 으로 이메일 보내주세요.

<div class="content-ad"></div>

플러터에 대한 더 많은 콘텐츠를 보고 싶나요? 커피 한 잔 사주시면 글쓰기 열정에 불을 지킬 수 있어요!

![이미지](/assets/img/2024-06-21-DropdownMenuAsearchabledropdownSuperchargeyourFlutterforms_1.png)

다른 내용도 확인해보세요!
