---
title: "플러터에서 ORM으로 Drift 사용하기"
description: ""
coverImage: "/assets/img/2024-06-19-UseDriftforORMinFlutter_0.png"
date: 2024-06-19 14:28
ogImage: 
  url: /assets/img/2024-06-19-UseDriftforORMinFlutter_0.png
tag: Tech
originalTitle: "Use Drift for ORM in Flutter"
link: "https://medium.com/@winsonet/use-drift-for-orm-in-flutter-a144be7fae80"
---


<img src="/assets/img/2024-06-19-UseDriftforORMinFlutter_0.png" />

# 1. 소개

Drift은 Dart와 Flutter 애플리케이션용 강력한 데이터베이스 라이브러리입니다. 타입 안정한 SQL 쿼리, 데이터베이스의 검증 및 마이그레이션과 같은 고급 기능을 지원하기 위해, 컴파일 시간에 실행되는 빌더와 명령줄 도구를 사용합니다.

아래 표를 마핑하기 위한 Dart 클래스를 생성할 수 있습니다:

<div class="content-ad"></div>

```js
class TodoItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 6, max: 32)();
  TextColumn get content => text().named('body')();
  IntColumn get category => integer().nullable()();
}
```

하지만 저는 ORM 코딩을 생성하기 위해 SQL 문을 사용하는 것을 선호합니다 (나중에 보여드리겠습니다). 보통 테이블용 SQL을 먼저 생성하고, 그 SQL을 재사용해야 하기 때문에 괜찮을 거예요 🙂

# 2. 사용법

나중에 Drift에서 모델을 생성할 때 SQL 문을 사용하는 방법을 보여드리겠습니다.

<div class="content-ad"></div>

# 2.1 필수 라이브러리 가져오기

Drift는 sqlite3와 코드를 생성하는 Flutter 빌드 러너를 기반으로 하고 있기 때문에, pubspec.yaml 파일에 아래 종속성을 가져와야합니다:

```yaml
dependencies:
  drift: ^2.16.0
  sqlite3_flutter_libs: ^0.5.20
  path_provider: ^2.1.2
  path: ^1.9.0

dev_dependencies:
  drift_dev: ^2.16.0
  build_runner: ^2.4.8
```

# 2.2 데이터베이스 클래스 생성하기

<div class="content-ad"></div>

예를 들어, 책 데이터베이스를 생성해야 한다면 아래의 book_database.dart 파일을 만들 수 있습니다.

```dart
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift/native.dart';

part 'book_database.g.dart'; // 이 파일은 생성 파일이며 기존 db 파일과 동일한 파일 이름을 사용해야 함

@DriftDatabase(
  include: {'book.drift'}, // 책 테이블을 만들기 위한 SQL 파일
)
class BookDatabase extends _$BookDatabase {
  BookDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    // 데이터베이스 파일인 db.sqlite을 여기 앱의 documents 폴더로 넣습니다.
    final dbFolder = await getApplicationSupportDirectory();

    // db 파일의 경로 설정
    final file = File(p.join(dbFolder.path, 'book.db'));
    return NativeDatabase.createInBackground(file);
  });
}
```

# 2.2 SQL 문장 파일 생성

book.drift 파일을 생성하여 테이블을 만드는 일반적인 SQL 문장을 입력하고, SQL에서 사용자 정의 메서드도 생성할 수 있습니다.

<div class="content-ad"></div>

```js
CREATE TABLE IF NOT EXISTS "book" (
            "id" INTEGER PRIMARY KEY NOT NULL UNIQUE,
            "viewCount" INTEGER DEFAULT(NULL),
            "name" VARCHAR(64) COLLATE NOCASE NOT NULL UNIQUE,
            "artist" VARCHAR(64) COLLATE NOCASE NOT NULL,
            "folder" VARCHAR(64) COLLATE NOCASE NOT NULL,
            "coverImg" VARCHAR(64) COLLATE NOCASE NOT NULL
);
CREATE UNIQUE INDEX IF NOT EXISTS "book_1" ON book (id);
CREATE UNIQUE INDEX IF NOT EXISTS "book_2" ON book (name);

isBookExists: Select count(*) from book where name = :name Limit 1;
filterBooks: SELECT * FROM book WHERE $predicate;
getTop10: SELECT * FROM book ORDER BY viewCount DESC Limit 10;
```

여기서 간단한 book 테이블을 만들었고, id 및 name 열에 대한 인덱스를 생성했습니다. 한편, 3가지 사용자 정의 메서드도 만들었고, 이후에 사용 방법을 알려드리겠습니다.

코드를 생성한 후 drift가 dart 코드로 DB 도우미 클래스에서 이러한 3가지 메서드를 자동으로 생성할 것입니다.

# 2.3 데이터베이스 도우미 클래스 생성하기```

<div class="content-ad"></div>

아래 명령어를 실행하여 DB 헬퍼 클래스를 생성할 수 있습니다:

```js
dart run build_runner build
```

그 결과로 book_database.g.dart와 같은 하나의 파일이 더 생성될 것이고, 해당 파일 안에 사용자 정의 메서드도 찾을 수 있을 거예요. 물론, 이 동작 방식에 대해 걱정할 필요는 없습니다. 그냥 사용하면 됩니다!

# 2.4 데이터베이스 헬퍼 사용하기

<div class="content-ad"></div>

우리는 예시로 GetX 프레임워크를 사용할 것입니다.

main.dart 파일에 BookDatabase 클래스를 넣어주세요.

```js
Get.put(BookDatabase());
```

이제 우리는 어디서든 사용할 수 있습니다:

<div class="content-ad"></div>

```js
//책 DB 도우미 가져오기
final BookDatabase _bookDB = Get.find<BookDatabase>();

...

//DB에서 모든 책 아이템 가져오기
var dbBooks = await _bookDB.book.select().get();
...
//책 아이템의 folder 열만 업데이트하여 DB에 저장
_bookDB.updateBookItem(
  bookItem.id,
  BookCompanion(
      folder: drift.Value(bookItem.folder),
  ),
);
...
//책 아이템 일괄 삽입
List<BookData> dbBooks = [];
dbBooks.add(BookData(
        id: 1,
        viewCount: 0,
        name: 'book 1',
        artist: 'artist 1',
        folder: 'assets/books/01/',
        coverImg: 'assets/books/01/cover.jpg',));
dbBooks.add(BookData(
        id: 2,
        viewCount: 0,
        name: 'book 2',
        artist: 'artist 2',
        folder: 'assets/books/02/',
        coverImg: 'assets/books/02/cover.jpg',));
_bookDB.book.insertAll(dbBooks);e custom methods
```

예제에서는 SQL 문으로 3개의 메서드를 정의했습니다:

```js
isBookExists: Select count(*) from book where name = :name Limit 1 ;
filterBooks: SELECT * FROM book WHERE $predicate;
getTop10: SELECT * FROM book ORDER BY viewCount DESC Limit 10;
```

아래에서 이를 사용할 수 있습니다.
```  

<div class="content-ad"></div>

```js
// 도서 이름으로 책이 있는지 확인
int bookCount = await _bookDB.isBookExists('bookName').getSingle();

// 사용자 지정 필터로 책 가져오기
var bookItems = await _bookDB.filterBooks((book) => book.name.contains('bookName')).get();

// 상위 10권의 책 가져오기
var topTenBooks = await _bookDB.getTop10().get();
```

# 3. 결론

Drift는 데이터베이스를 관리하는 데 유용합니다. 데이터를 가져오기 위해 사용자 지정 메서드를 생성할 수 있으며 SQL 문을 사용하지 않고 Dart API를 사용할 수도 있습니다. 자세한 내용은 여기에서 확인할 수 있습니다. 여전히 오피서 웹사이트에서 많은 강력한 기능을 찾을 수 있습니다.

이 글이 마음에 드셨다면 .Net Core, Angular 및 기타 기술에 관한 더 많은 이야기를 보려면 Medium에서 팔로우해주세요! 🙂
```