---
title: "엘로퀀트 깊숙한 학습 라라벨 개발자가 반드시 알아야 할 40가지 잘 사용되지 않는 엘로퀀트 ORM 메서드"
description: ""
coverImage: "/assets/img/2024-06-19-DeepDiveintoEloquent40RarelyUsedEloquentORMMethodsEveryLaravelDeveloperMUSTKnow_0.png"
date: 2024-06-19 14:42
ogImage: 
  url: /assets/img/2024-06-19-DeepDiveintoEloquent40RarelyUsedEloquentORMMethodsEveryLaravelDeveloperMUSTKnow_0.png
tag: Tech
originalTitle: "Deep Dive into Eloquent: 40 Rarely Used Eloquent ORM Methods Every Laravel Developer MUST Know"
link: "https://medium.com/@prevailexcellent/deep-dive-into-eloquent-40-rarely-used-eloquent-orm-methods-every-laravel-developer-must-know-9c75b58f456b"
---


<img src="/assets/img/2024-06-19-DeepDiveintoEloquent40RarelyUsedEloquentORMMethodsEveryLaravelDeveloperMUSTKnow_0.png" />

안녕하세요! 엘로퀀트에 대해 얼마나 잘 아시나요?

라라벨의 엘로퀀트 ORM은 매우 강력한 도구로, 표현력이 풍부하고 우아한 구문을 사용하여 데이터베이스와 상호 작용할 수 있는 기능을 제공합니다. 많은 개발자들이 find(), where(), first(), get(), save()와 같은 일반적인 메서드를 잘 알고 있지만, 워크플로우를 크게 향상시킬 수 있는 몇 가지 잘 알려지지 않은 메서드들이 있습니다. 이 글에서는 이러한 잘 알려지지 않지만 매우 유용한 엘로퀀트 ORM 메서드 중 일부를 살펴보겠습니다.

일반적인 메서드부터 시작해서 가장 좋은 메서드로 이동해보겠습니다. 여러분은 응용 프로그램의 속도와 효율성을 실제로 향상시킬 수 있는 많은 아름다운 메서드를 보게 될 것입니다. 함께 알아보도록 하죠.

<div class="content-ad"></div>

# 1. tap()

왜: 모델에 변경사항을 적용하고 메서드 체이닝을 위해 모델 자체를 반환합니다.

언제: 객체를 수정하고 즉시 다른 작업에 사용하고 싶을 때 사용하세요.

```js
User::find(1)->tap(function ($user) {
    $user->name = 'Updated Name';
})->save();
```

<div class="content-ad"></div>

# 2. firstOrFail()

왜: 유효한 결과를 얻거나 결과가 없는 경우를 처리하기 위해 사용합니다.

언제: 특정 레코드를 가져 와서 존재하지 않는 경우에 오류를 throw하고 싶을 때 사용합니다.

```js
$user = User::where('email', 'example@example.com')->firstOrFail();
// 사용자 세부 정보 처리
```

<div class="content-ad"></div>

# 3. updateOrCreate()

왜: 기존 레코드를 업데이트하거나 새로운 레코드를 생성하여 중복 항목을 방지하기 위해서입니다.

언제: 레코드가 존재하지 않으면 생성되고, 존재한다면 업데이트되도록 하고 싶을 때 사용합니다.

```js
User::updateOrCreate(
    ['email' => 'example@example.com'],
    ['name' => 'John Doe']
);
```

<div class="content-ad"></div>

# 4. increment() / decrement()

이 부분을 정말 좋아해요. 직관적이고 아름다워요. 언제 사용하나요?
언제 사용: 숫자 열을 하나 이상 증가시키거나 감소시킬 때 사용합니다.

왜 사용하나요: 숫자 열의 값을 효율적으로 업데이트하기 위해.

```js
User::where('id', 1)->increment('points'); // 만약 points가 7이면 이제 8이 될 것입니다
User::where('id', 1)->decrement('points', 5); // 만약 7이면 2가 될 것입니다
```

<div class="content-ad"></div>

# 5. withTrashed() / onlyTrashed() / restore()

이 그룹의 메소드들은 라라벨에서 Soft Deletes 기능을 관리하는 데 사용됩니다.
나는 Soft Deletes에 관한 모든 것을 다룬 매우 상세한 기사를 썼어.

왜: Soft 삭제된 레코드를 관리하기 위해.
언제: 이러한 메소드를 사용하여 Soft 삭제된 레코드를 포함하거나 오직 포함하거나 되찾을 때.


```js
$users = User::withTrashed()->get();
$trashedUsers = User::onlyTrashed()->get();
User::withTrashed()->where('id', 1)->restore();
```

<div class="content-ad"></div>

# 6. withoutEvents()

왜: 이벤트 리스너가 작동하는 것을 방지합니다.
언제: 일괄 가져오기와 같이 이벤트를 발생시키지 않아야 하는 작업을 수행할 때 사용합니다.

외부 시스템에서 대량의 사용자를 가져오고 각 가져온 사용자에 대해 UserCreated 이벤트를 트리거하고 싶지 않아서 환영 이메일을 보내거나 생성마다 로깅하는 것을 피하려고 한다고 상상해보세요.

```js
User::withoutEvents(function () {
    User::create([
      'name' => 'John Doe', 
      'email' => 'john@example.com'
    ]);
    User::create([
      'name' => 'Jane Doe', 
      'email' => 'jane@example.com'
    ]);
});
```

<div class="content-ad"></div>

# 7. withoutGlobalScopes()

**왜 사용하나요:** 전역 쿼리 제약을 우회하기 위해 사용합니다.
**언제 사용하나요:** is_published와 같은 전역 스코프를 무시하고 모든 레코드를 가져와야 할 때 사용합니다.

당신의 애플리케이션에는 발행된 게시물만 포함하는 전역 스코프를 가진 Post 모델이 있는 상황을 상상해보세요. 관리자는 컨텐츠를 효율적으로 관리하기 위해 초안 및 미게시된 게시물을 포함한 모든 게시물을 볼 수도 있어야 할 것입니다.

전역 스코프를 무시하고 모든 게시물을 가져오기:

<div class="content-ad"></div>

```js
$allPosts = Post::withoutGlobalScopes()->get();
foreach ($allPosts as $post) {
    echo $post->title . ($post->is_published ? ' (Published)' : ' (Draft)') . "\n";
}
```

위 예시에서 withoutGlobalScopes()를 사용하면 관리자가 미게시된 포스트를 필터링하는 전역 범위를 우회하여 모든 포스트를 볼 수 있습니다.

withoutGlobalScopes()를 사용하는 것은 데이터에 대한 종합적인 액세스가 필요한 관리 작업이나 글로벌 제약 조건이 쿼리에 영향을 미치지 않도록 디버깅 및 테스트 중에 특히 유용합니다.

# 10. is() / isNot()

<div class="content-ad"></div>

이것도 좋아요. 비교와 조건을 확인할 때 매우 간편하고 유용합니다.

왜 필요한가: 두 모델 인스턴스를 비교하기 위해.
언제 사용하는가: 두 모델이 동일한 인스턴스인지 확인할 때 사용합니다.

```js
$user1 = User::find(1);
$user2 = User::find(2);

if ($user1->is($user2)) {
    // 동일한 사용자
}

if ($user1->isNot($user2)) {
    // 동일한 사용자가 아님
}
```

# 11. loadMissing()

<div class="content-ad"></div>

예시: User 모델이 있는데 그 모델은 게시물(posts) 관계를 갖고 있습니다. 사용자와 그들의 게시물을 함께 로드하고 싶지만, 게시물 관계가 이미 로드되었는지 확실하지 않을 때가 있습니다.

왜: 이미 로드되지 않은 관계를 조건부로 eager load하여 데이터베이스 쿼리를 최적화하고 N+1 쿼리 문제를 피하기 위해서입니다.

언제: loadMissing()을 사용할 때는 모델 인스턴스에 관계를 로드하고 싶지만 이미 로드되어 있지 않은 경우에만 사용합니다. 특히 특정 조건에 따라 동적으로 로드하고 싶은 조건부 관계 또는 이미 로드된 것들이 섞인 루프에서 관계를 로드할 때 유용합니다.

```js
$user = User::find(1);

// 'posts' 관계가 이미 로드되었는지 확인
if (!$user->relationLoaded('posts')) {
    // 'posts' 관계는 이미 로드되어 있지 않다면 로드
    $user->loadMissing('posts');
}

// 이제 중복 쿼리 걱정 없이 'posts' 관계에 접근할 수 있습니다
foreach ($user->posts as $post) {
    echo $post->title . "\n";
}
```

<div class="content-ad"></div>

# 12. makeHidden() / makeVisible()

왜: 모델 속성의 가시성을 제어하기 위해서입니다.
언제: 임시로 속성을 숨기거나 보여줄 때 사용합니다. 예를 들어 API 응답에서 사용합니다.

```js
$user = User::find(1);
$user->makeHidden('email');
$user->makeVisible('email');
```

# 13. touch()

<div class="content-ad"></div>

왜: updated_at 타임스탬프를 업데이트하려고.
언제: 다른 속성을 변경하지 않고 레코드를 업데이트된 것으로 표시하려면 사용하세요.

```js
$user = User::find(1);
$user->touch();
```

# 14. append()

왜: 모델의 배열이나 JSON 형식에 사용자 정의 속성을 추가하려고.
언제: 모델의 표현에 추가적인 계산된 속성을 포함하고 싶을 때 사용하세요.

<div class="content-ad"></div>

```php
$user = User::find(1);
$user->append('custom_attribute');
```

안녕하세요! Laravel에서 Json 데이터를 관리하는 방법에 대한 매우 포괄적이고 단계별 자습서를 작성했습니다.

# 15. replicate()

왜: 모델 인스턴스를 복제하기 위함.
언제: 템플릿을 복제하는 것과 같이 동일한 속성을 가진 새 인스턴스를 생성할 때 사용합니다.

<div class="content-ad"></div>

```php
$user = User::find(1);
$newUser = $user->replicate(); // $newUser is matches to $user
$newUser->save();
```

## 16. chunkById()

테이블에 20,000,000개의 레코드가 있는 상황을 상상해보세요. 각 레코드에 대해 작업을 수행해야합니다. 이를 어떻게 해야 할까요?

왜: 대규모 데이터 세트를 효율적으로 처리하는 데 사용합니다.
언제: 대규모 데이터 세트를 처리하여 메모리를 효율적으로 처리하고 대형 테이블에서 더 나은 성능을 얻을 수 있습니다.


<div class="content-ad"></div>

특정 작업을 수행해야 하는 20,000,000개 레코드가 있는 데이터베이스 테이블이 있다고 가정해보세요.

```js
use App\Models\YourModel;

YourModel::orderBy('id')->chunkById(1000, function ($records) {
    foreach ($records as $record) {
        // 각 레코드 처리
    }
});
```

참고: chunk()라는 유사한 메소드가 있습니다. 이러한 두 메소드는 유사한 작업을 수행하지만 차이점이 있습니다. 두 가지 모두 대규모 데이터셋을 효율적으로 일괄 처리하여 메모리 과부하를 방지하고 성능을 최적화합니다. 두 메소드는 한 번에 전체 데이터셋을 한꺼번에 메모리로 로드하지 않고 대규모 데이터셋을 이터레이션할 수 있도록 허용합니다. 그러나 데이터 배치를 결정하는 방식에서 차이가 있습니다:

chunk():

<div class="content-ad"></div>

- chunk()은 첫 번째 매개변수로 지정된 청크 당 레코드 수에 따라 데이터 세트를 청크로 나눕니다.
- 특정한 순서를 고려하지 않고 데이터베이스 테이블에서 레코드를 순차적으로 검색합니다.
- 각 청크의 레코드는 데이터베이스에서 검색된 순서에 기반하여 가져오며, 주로 기본 키 순서에 따라 순서가 지정되지 않을 수 있습니다.
- 처리 순서가 중요하지 않거나 데이터를 작은 관리 가능한 청크로 처리해야 할 때이 유용한 방법입니다.

chunkById():

- chunkById()는 레코드의 기본 키(일반적으로 id) 순서를 기반으로 데이터 세트를 청크로 나눕니다.
- 데이터베이스 테이블에서 레코드를 기본 키 순서에 따라 순차적으로 검색합니다.
- 각 청크에는 지정된 범위 내의 기본 키를 갖고 있는 레코드가 포함되어, 레코드가 기본 키 순서로 처리되도록 보장합니다.
- 데이터 마이그레이션이나 기본 키 순서를 기반으로 순차 처리가 필요한 데이터 업데이트와 같은 작업을 수행할 때 유용한 방법입니다.

# 17. existsOr()

<div class="content-ad"></div>

**왜**: 모델이 존재하는 경우 콜백을 실행하거나 기본값을 반환합니다.  
**언제**: 사용자 정의 로직으로 존재 여부를 처리해야 할 때 사용합니다.

```js
$exists = User::where('email', 'example@example.com')->existsOr(function () {
    return 'User does not exist';
});
```

# 18. firstOrCreate()

**왜**: 단계를 한 번에 기록을 검색하거나 생성하기 위해 사용합니다.  
**언제**: 필요한 경우 레코드를 업데이트하거나 생성하여 중복된 항목을 피하기 위해 사용합니다.

<div class="content-ad"></div>

```js
$user = User::firstOrCreate(['email' => 'example@example.com'], ['name' => 'John Doe']);
```

# 19. firstOrNew()

왜: 저장하지 않고 기존 레코드를 검색하거나 새 레코드를 만들기 위해 사용합니다.
언제: 기존 레코드를 가져 오거나 영구적으로 저장하지 않고 새 인스턴스를 만들기 위해 사용합니다.

```js
$user = User::firstOrNew(['email' => 'example@example.com'], ['name' => 'John Doe']);
```  

<div class="content-ad"></div>

# 20. `sole()`

왜: 하나의 레코드만 가져오거나 예외를 발생시키기 위해 사용합니다.
언제 사용: 단일하고 고유한 결과를 예상하고 중복을 오류로 처리하고 싶은 경우에 사용합니다.

```js
$user = User::where('email', 'example@example.com')->sole();
```

# 21. `findMany()`

<div class="content-ad"></div>

테이블 태그를 Markdown 형식으로 변경하세요.


Why: 여러 개의 기본 키로 레코드를 검색하기 위해 사용합니다. 
When: 여러 개의 ID가 포함된 배열을 사용하여 한 번에 여러 레코드를 가져오는 데 사용합니다.

```js
$users = User::findMany([1, 2, 3]);
```

## 22. update()

Why: 한 번에 여러 레코드를 업데이트하기 위해 사용합니다.
When: 대량 업데이트를 효율적으로 수행하기 위해 사용합니다.


<div class="content-ad"></div>

```js
User::where('status', 'active')->update(['status' => 'inactive']);
```

# 23. forceDelete()

Why: 소프트 삭제된 모델을 영구적으로 삭제하려면 사용하세요.
When: 레코드를 완전히 제거하여 소프트 삭제를 우회할 때 사용하세요.

```js
$user = User::withTrashed()->find(1);
$user->forceDelete();
```

<div class="content-ad"></div>

# 24. getDirty()

이 함수 정말 좋아요. 이 함수를 사용하면 데이터베이스에 저장되기 전 모델에서 변경된 모든 내용을 알 수 있어요.

왜: 변경된 속성들을 확인하려고요.
언제: 저장하기 전에 수정된 속성들을 확인할 때 사용하세요.

```js
$user = User::find(1);
$user->name = '새로운 이름';
$dirty = $user->getDirty();
```

<div class="content-ad"></div>

# 25. getOriginal()

왜: 모델 속성의 원래 값 가져오기 위해 사용합니다.
언제: 변경 전 현재 값과 원래 값 비교할 때 사용합니다.

```js
$user = User::find(1);
$original = $user->getOriginal('name');
```

# 26. setRelation()

<div class="content-ad"></div>

왜: 모델에 특정 관계를 설정하기 위해 사용합니다.
언제: 모델 인스턴스에 수동으로 관계를 정의할 때 사용합니다.

```js
$user = User::find(1);
$user->setRelation('posts', $posts);
```

# 27. without()

왜: 쿼리에서 특정 관계를 제외하기 위해 사용합니다.
언제: 불필요한 관계를 제외하여 쿼리를 최적화할 때 사용합니다.

<div class="content-ad"></div>

```javascript
$user = User::with('posts', 'comments')->without('comments')->find(1);
```

## 28. preventLazyLoading()

왜: 관계의 게으른 로딩을 방지합니다.
언제: 개발 중에 의도하지 않은 게으른 로딩을 방지하려면 사용하세요.

```javascript
Model::preventLazyLoading(!app()->isProduction());
```

<div class="content-ad"></div>

# 29. withoutTimestamps()

왜: created_at 및 updated_at 타임스탬프의 업데이트를 비활성화합니다.
언제: 가져오기와 같이 타임스탬프 업데이트를 트리거해서는 안 되는 작업에 사용합니다.

```js
User::withoutTimestamps(function () {
    User::create(['name' => 'John Doe']);
});
```

# 30. withCasts()

<div class="content-ad"></div>

라라벨은 모델 속성에 동적으로 캐스팅 규칙을 적용할 수 있습니다. 특정 조건이나 런타임 시나리오에 따라 속성을 어떻게 캐스팅할지 실시간으로 변경할 필요가 있을 때 유용합니다. 예를 들어 사용자 입력이나 데이터베이스 값에 따라 속성을 다른 유형으로 캐스팅할 수 있어 데이터 일관성과 애플리케이션의 유연성을 보장할 수 있습니다.

왜: 캐스팅 규칙을 동적으로 적용하기 위해.
언제: 속성을 실시간으로 어떻게 캐스팅할지 변경할 때.

```js
$user = User::withCasts(['is_admin' => 'boolean'])->find(1);
```

# 31. upsert()

<div class="content-ad"></div>

왜: 일치하는 기준에 따라 레코드를 삽입하거나 업데이트하기 위해서입니다.
언제: 대량 삽입 또는 업데이트를 수행하여 중복 항목을 피하기 위해 사용합니다.

고유 식별자로 이메일 열을 갖는 사용자 테이블이 있다고 가정해보세요. 해당 테이블에 이메일이 이미 존재하지 않는 경우 새 사용자를 삽입하거나 이미 존재하는 경우 이메일에 해당하는 이름을 업데이트하려고 합니다.

```js
use App\Models\User;

User::upsert([
    ['email' => 'john@example.com', 'name' => 'John Doe'],
    ['email' => 'jane@example.com', 'name' => 'Jane Doe']
], ['email'], ['name']);
```

# 32. 스코프

<div class="content-ad"></div>

왜: 재사용 가능한 쿼리 스코프를 정의하는 데 사용합니다.
언제: 여러 쿼리에 일반적인 쿼리 제약을 적용하는 데 사용합니다.

```js
// 사용자 모델에서
public function scopeActive($query)
{
    return $query->where('status', 'active');
}

// 사용 방법
$activeUsers = User::active()->get();
```

# 33. macro()

이 메소드를 너무 좋아합니다. 원하는대로 사용자 정의한 고유한 메소드를 생성하는 데 사용할 수 있습니다.

<div class="content-ad"></div>

왜: Eloquent 쿼리 빌더에 사용자 정의 메서드를 정의하기 위해.
언제: 쿼리 빌더를 확장하여 자체 메서드를 추가하는 데 사용됩니다.

당신의 응용 프로그램에서 사용자의 역할에 따라 사용자를 필터링해야 하는 경우가 자주 있습니다. 이 작업을 간단히 하기 위해 쿼리 빌더에 role()이라는 사용자 지정 매크로를 정의할 수 있습니다.

```js
use Illuminate\Database\Eloquent\Builder;

// 'role' 매크로 정의
Builder::macro('role', function ($role) {
    return $this->where('role', $role);
});

// 사용 예
$admins = User::role('admin')->get();
$customers = User::role('customer')->get();
```

# 34. filter()

<div class="content-ad"></div>

**왜**: 동적 쿼리 필터를 적용하기 위해 사용합니다.
**언제**: 요청 매개변수를 기반으로 여러 필터를 적용하기 위해 사용하세요.

```js
// 사용자 모델 내부에서
public function scopeFilter($query, $filters)
{
    return $filters->apply($query);
}

// 사용법
$filters = new UserFilters(['status' => 'active']);
$filteredUsers = User::filter($filters)->get();
```

이 예제에서는 User 모델에 filter() scope를 정의하여 필터 세트를 전달 받습니다. 이러한 필터는 UserFilters 객체의 apply() 메서드를 사용하여 쿼리에 적용될 수 있습니다. 이를 통해 $filters 변수에 지정된 다양한 기준에 따라 사용자를 동적으로 필터링할 수 있습니다.

filter()를 사용하면 데이터베이스 쿼리를 변화하는 요구 사항과 사용자 입력에 더 적응 가능하게 만들어 Laravel 애플리케이션에서 더 유연하고 동적인 데이터 검색이 가능해집니다.

<div class="content-ad"></div>

# 35. whereJsonContains()

왜: 특정 값을 가진 JSON 열을 조회하기 위해 사용합니다.
언제: 배열 또는 객체를 포함하는 JSON 열을 조회할 때 사용합니다.

```js
$users = User::whereJsonContains('options->languages', 'en')->get();
```

라라벨에서 JSON에 관한 모든 것에 대한 문서가 있습니다. 이 곳을 확인해보세요.

<div class="content-ad"></div>

# 36. findOr()

왜: 모델을 검색하거나 찾을 수 없을 때 콜백을 실행하는 데 사용합니다.
언제: 레코드가 없을 때 사용자 정의 로직을 처리할 때 사용하세요.

```js
$user = User::findOr(1, function () {
    return '사용자를 찾을 수 없습니다';
});
```

# 37. lockForUpdate()

<div class="content-ad"></div>

Laravel의 Eloquent ORM에 있는 lockForUpdate() 메서드는 트랜잭션 내에서 데이터베이스 행을 업데이트하기 위해 잠그는 데 사용됩니다. 이 메서드를 쿼리에 적용하면 현재 트랜잭션이 완료될 때까지 선택된 행을 수정하는 다른 데이터베이스 트랜잭션이 방지됩니다. 이를 통해 데이터 일관성을 유지하고 여러 트랜잭션이 동시에 같은 행을 업데이트하려고 할 때 충돌을 방지합니다.

왜: 쿼리에 "for update" 잠금을 적용합니다.
언제: 여러 트랜잭션이 귀하의 트랜잭션 중에 행을 수정하는 것을 방지할 때 사용합니다.

```js
$user = User::where('email', 'example@example.com')->lockForUpdate()->first();
```

# 38. sharedLock()

<div class="content-ad"></div>

왜: 쿼리에 "공유 락"을 적용하려면
언제: 트랜잭션 기간 동안 선택한 행을 잠그는 데 사용합니다.

금융 애플리케이션이 있다고 가정해보겠습니다. 사용자가 계정 잔액을 볼 수 있는 애플리케이션입니다. 사용자가 잔액을 확인할 때, 다른 트랜잭션이 동시에 계정 잔액을 업데이트하더라도 표시된 금액이 일관되게 유지되도록 보장하고 싶습니다. 이러한 경우에는 트랜잭션 중 사용자 계정에 해당하는 행을 잠글 때 sharedLock()을 사용할 수 있습니다. 

```js
use App\Models\Account;

DB::transaction(function () use ($userId) {
    $account = Account::where('user_id', $userId)->sharedLock()->first();
    // 사용자의 계정 잔액 표시
});
```

# 39. withSum()

<div class="content-ad"></div>

왜: 관련 모델 속성의 합계를 결과에 추가하려고 합니다.
언제: 주문 총액을 합산하는 등 관련 모델에서 데이터를 집계해야 할 때 사용합니다.

```js
$users = User::withSum('posts', 'views')->get(); // 총 게시물
```

예를 들어 User 모델이 있고 각 사용자가 여러 주문을 가질 수 있다고 가정합니다. 사용자 목록과 주문 금액의 총 합을 함께 검색하려면 withSum()을 사용할 수 있습니다.

```js
use App\Models\User;

$usersWithTotalOrderAmount = User::withSum('orders', 'amount')->get();

foreach ($usersWithTotalOrderAmount as $user) {
    echo "User: {$user->name}, Total Order Amount: {$user->orders_sum_amount}\n";
}
```

<div class="content-ad"></div>

이 예제에서는 `orders` 관계에서 각 사용자의 금액 열의 총 합계를 검색하기 위해 withSum(`orders`, `amount`)이 사용됩니다. 집계된 합계는 각 사용자 객체의 동적으로 생성된 속성 (orders_sum_amount)으로 사용할 수 있습니다.

withSum()을 사용하여 주 쿼리 결과와 관련된 모델에서 집계된 데이터를 효율적으로 검색하여 코드를 간단하게하고 성능을 향상시킬 수 있습니다.

# 40. withCount()

Laravel의 Eloquent ORM에서 withCount() 메서드는 관련된 모델과 관련 모델의 수를 함께 검색하는 데 사용됩니다. 이것은 추가 쿼리를 수행하거나 수동 계산을 필요로하지 않고 연결된 레코드 수를 검색하려는 경우 유용합니다.

<div class="content-ad"></div>

왜: 관련된 모델의 수를 셀 때 사용합니다.
언제: 사용자 당 게시물 수와 같이 관련 레코드 수를 얻을 때 사용합니다.

```js
use App\Models\User;

$usersWithPostCounts = User::withCount('posts')->get();

foreach ($usersWithPostCounts as $user) {
    echo "User: {$user->name}, Post Count: {$user->posts_count}\n";
}
```

위 예시에서 withCount('posts')는 각 사용자와 관련된 게시물 수를 검색하는 데 사용됩니다. 게시물 수는 각 사용자 객체의 동적으로 생성된 속성(posts_count)로 사용할 수 있습니다.

withCount()를 사용하면 주 쿼리 결과와 함께 데이터베이스로부터 관련 레코드의 수를 효율적으로 검색하여 코드를 단순화하고 성능을 향상시킬 수 있습니다.

<div class="content-ad"></div>

# 결론

우리는 Eloquent에 대해 정말 깊게 알아보았습니다. Laravel 개발자라면 꼭 알아야 할 40가지 사용 빈도가 적은 Eloquent ORM 메서드를 논의했으니 즐기세요!

하지만 마지막까지 읽어준 선물로, 여기 워크플로우를 향상시키고 생산성을 향상시킬 10가지 더 많은 메서드가 있습니다.

- oldest(): 지정된 열을 기준으로 쿼리 결과를 오름차순으로 정렬합니다.
- latest(): 지정된 열을 기준으로 쿼리 결과를 내림차순으로 정렬합니다.
- has(): 관계가 있는 레코드만 포함하도록 쿼리를 필터링합니다.
- whereHas(): 특정 조건과 일치하는 관계가 있는 레코드만 포함하도록 쿼리를 필터링합니다.
- doesntHave(): 관계가 없는 레코드만 포함하도록 쿼리를 필터링합니다.
- whereDoesntHave(): 특정 조건과 일치하는 관계가 없는 레코드만 포함하도록 쿼리를 필터링합니다.
- withPivot(): 중간 테이블 열을 쿼리할 때 추가 피벗 테이블 열을 지정합니다.
- morphTo(): 관련된 모델이 여러 소스 모델에 속할 수 있는 다형 관계를 정의합니다.
- morphMany(): 관련된 모델이 여러 소스 모델에 속할 수 있는 다형 일대다 관계를 정의합니다.
- morphToMany(): 관련된 모델이 여러 소스 모델에 속할 수 있는 다형 다대다 관계를 정의합니다.

<div class="content-ad"></div>

즐겁게 보내세요.

계속 주목하세요!!! 다음 기사에서는 멋진 Laravel 튜토리얼을 더 소개할 예정이에요. 기사가 마음에 드셨길 바래요. 저를 팔로우해주세요 😇 그리고 박수를 좀 👏 부탁드려요. 궁금한 점이 있으면 언제든지 댓글을 남겨주세요.

감사합니다.

끝까지 읽어주셔서 정말 감사합니다. 저를 팔로우하거나 연락할 수 있는 곳:
Twitter: https://twitter.com/EjimaduPrevail
Email: prevailexcellent@gmail.com
Github: https://github.com/PrevailExcel
LinkedIn: https://www.linkedin.com/in/chimeremeze-prevail-ejimadu-3a3535219
BuyMeCoffee: https://www.buymeacoffee.com/prevail
Chimeremeze Prevail Ejimadu