---
title: "Flutter에서 Bloc과 get_it 패키지를 사용하여 클린 아키텍처 구현하는 방법"
description: ""
coverImage: "/assets/img/2024-06-21-HowtoimplementcleanarchitecturewithBlocandget_itpackageinFlutter_0.png"
date: 2024-06-21 21:16
ogImage:
  url: /assets/img/2024-06-21-HowtoimplementcleanarchitecturewithBlocandget_itpackageinFlutter_0.png
tag: Tech
originalTitle: "How to implement clean architecture with Bloc and get_it package in Flutter"
link: "https://medium.com/@jhonmunozromero/how-to-implement-clean-architecture-with-bloc-and-get-it-package-in-flutter-9874f038f6f2"
---

이 기사에서는 get_it 패키지를 서비스 로케이터로, Bloc를 상태 관리로 사용하여 클린 아키텍처를 구현하는 방법을 가르쳐 드리겠습니다. 이를 통해 책임을 분리하고, 앱이 점점 커지고 복잡해짐에 따라 새로운 기능을 더 잘 유지하고 코드를 이해하기 쉽게 유지할 수 있습니다.

다음 이미지에서 보듯이, 우리는 클린 아키텍처 레이어를 기반으로 기본 파일 시스템을 생성하는 방법에 대해 알아볼 것입니다.

![이미지](/assets/img/2024-06-21-HowtoimplementcleanarchitecturewithBlocandget_itpackageinFlutter_0.png)

프로젝트의 요구 사항에 따라이 파일 시스템이 변경될 수 있다는 점을 고려해야 합니다. 일부 개발자는 작은 앱에서 작업할 때 도메인 레이어를 사용하지 않는 경우가 있습니다. 이 경우에는 사용 사례와 리포지토리를 통해 비즈니스 로직을 추상화하는 데 도움이 될 것이므로 사용하겠습니다.

<div class="content-ad"></div>

# 브레이킹 배드 앱

Bloc 및 get_it 패키지를 사용하여 청결한 아키텍처를 배우기 위해, 우리는 Breaking Bad Quotes API(https://api.breakingbadquotes.xyz/v1/quotes)를 사용하는 간단한 앱을 만들 것입니다. 이 API를 통해 Breaking Bad에서 랜덤 명언을 얻을 수 있습니다. 사용하기 매우 쉽고 응답은 명언과 저자가 포함된 객체가 있는 간단한 목록입니다.

좋아요, 시작해 봅시다! API를 사용하면 다음과 같이 간단한 응답을 받게 됩니다.

```js
[
  {
    quote: "Congratulations, you’ve just left your family a second-hand Subaru.",
    author: "Saul Goodman",
  },
];
```

<div class="content-ad"></div>

클린 아키텍처를 구현하려면 도메인 레이어부터 시작하는 것이 좋습니다. 이 레이어는 추상 리포지토리를 주입한 유스케이스를 통해 데이터와 프레젠테이션 레이어 사이의 다리 역할을 합니다.

# 응답 엔티티

우선 엔티티를 만들 것인데, 이는 앱에서 가장 간단한 객체를 나타냅니다. 모든 엔티티와 모델을 Equatable에서 확장하여 객체를 문제없이 비교하고, 앱의 테스트를 개선하며, 상태에서 원치 않는 동작을 피할 수 있도록 해야 합니다.

```js
import 'package:equatable/equatable.dart';

class QuoteEntitie extends Equatable {

  final String? quote;
  final String? author;

  const QuoteEntitie({
    this.quote,
    this.author,
  });

  @override
  List<Object?> get props => [
    quote,
    author,
  ];
}
```

<div class="content-ad"></div>

# 추상 저장소

이제 우리는 리포지토리를 구현하는 모든 클래스에 대해 getQuote() 함수를 강제시키는 계약으로 작용하는 추상 클래스를 통해 엔티티를 반환해야 합니다. 이 구현은 나중에 확인하겠습니다. API 서비스가 비동기 데이터를 반환하기 때문에 Future를 사용합니다.

```js
abstract class QuoteRepository{
  Future<QuoteEntitie> getQuote();
}
```

# 사용 사례

<div class="content-ad"></div>

다음으로, 우리는 리포지토리를 생성자를 통해 주입하는 유스 케이스를 만들 것입니다. 이 유스 케이스는 데이터 레이어와 프레젠테이션 레이어 사이의 다리 역할을 하며 새로운 상태를 발신하는 상태 관리에 중요한 역할을 합니다.

```js
class QuoteUsecase {

  final QuoteRepository _quoteRepository;

  QuoteUsecase(this._quoteRepository);

  Future<QuoteEntity> getQuote() {
    return _quoteRepository.getQuote();
  }
}
```

이 시점에서, 도메인 레이어를 구현합니다. 파일 시스템은 다음과 같이 보여야 합니다:

![image](/assets/img/2024-06-21-HowtoimplementcleanarchitecturewithBlocandget_itpackageinFlutter_1.png)

<div class="content-ad"></div>

이제 데이터 레이어를 구현할 차례입니다. 이름에서 알 수 있듯이 데이터 레이어는 다른 소스(우리 경우 API)에서 데이터를 관리하고 도메인 레이어와 상호 작용하여 프리젠테이션 레이어가 필요로 하는 모든 데이터를 제공합니다.

# 모델 응답

모델 폴더를 앱의 요구에 따라 나눌 수 있습니다. 이 경우 API 응답 모델을 위한 폴더와 API 요청 모델을 위한 폴더 두 개로 나누겠습니다. 우리 앱에서는 API 응답을 위한 모델 하나만 필요하겠지만요. 또한, 객체를 비교할 수 있도록 Equatable에서 모델을 확장하고 엔티티를 구현하는 것을 기억해주세요.

```js
class QuoteResponseModel extends Equatable implements QuoteEntitie {
  @override
  final String? quote;
  @override
  final String? author;

  const QuoteResponseModel({
    this.quote,
    this.author,
  });

  QuoteResponseModel copyWith({
    String? quote,
    String? author,
  }) =>
      QuoteResponseModel(
        quote: quote ?? this.quote,
        author: author ?? this.author,
      );

  factory QuoteResponseModel.fromRawJson(String str) =>
      QuoteResponseModel.fromJson(json.decode(str)[0]);


  factory QuoteResponseModel.fromJson(Map<String, dynamic> json) =>
      QuoteResponseModel(
        quote: json["quote"],
        author: json["author"],
      );

  @override
  List<Object?> get props => [
        quote,
        author,
      ];
}
```

<div class="content-ad"></div>

# 데이터 소스

데이터 소스를 만들어 봅시다. 이는 필요에 따라 데이터를 가져오는 프로세스를 처리합니다. 이 예시에서는 API에서 데이터를 가져와 모든 것이 문제없이 진행되면 응답 객체를 생성하거나 오류가 발생하면 예외를 throw합니다. 보시다시피, 우리는 먼저 추상 클래스를 작성하여 추상 로직을 만듭니다. 이후 이 클래스의 구현은 선택한 클라이언트를 사용하여 데이터를 가져오는 책임을 갖게 됩니다. 이 경우 HTTP 클라이언트는 나중에 get_it 패키지를 사용하여 주입될 것입니다.

```js
import 'package:http/http.dart' as http;

abstract class QuoteDataSource {
  Future<QuoteResponseModel> getQuote();
}

class QuoteDataSourceImpl implements QuoteDataSource {
  final http.Client _client;

  QuoteDataSourceImpl(this._client);

  @override
  Future<QuoteResponseModel> getQuote() async {
    final Uri url = Uri.https('api.breakingbadquotes.xyz', '/v1/quotes');
    final http.Response response = await _client.get(url);
    if (response.statusCode == 200) {
      final QuoteResponseModel quoteResponseModel =
          QuoteResponseModel.fromRawJson(response.body);
      return quoteResponseModel;
    } else {
      throw Exception();
    }
  }
}
```

# 저장소 구현

<div class="content-ad"></div>

데이터 소스를 생성한 후, 이전에 만든 추상 리포지토리를 구현해야 합니다. 이는 구현 클래스의 생성자에 데이터 소스를 주입하고 추상 리포지토리 함수를 오버라이딩하여 달성할 수 있습니다.

```js
class QuoteRepositoryImpl implements QuoteRepository{

  final QuoteDataSource _dataSource;

  QuoteRepositoryImpl(this._dataSource);

  @override
  Future<QuoteEntitie> getQuote() async{
    return await _dataSource.getQuote();
  }

}
```

이 시점에서 애플리케이션에서 모든 것이 정상적으로 작동하는지 간단하게 테스트할 수 있습니다. FutureBuilder 위젯을 사용하여 API 정보를 검색하고 직접 의존성 주입을 통해 use case 객체를 만들어 확인할 수 있습니다.

```js
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final useCase = QuoteUsecase(QuoteRepositoryImpl(QuoteDataSourceImpl()));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quote App',
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: FutureBuilder(
            future: useCase.getQuote(),
            builder:
                (BuildContext context, AsyncSnapshot<QuoteEntitie> snapshot) {
              return Column(
                children: [
                  Text("${snapshot.data?.quote}"),
                  Text("${snapshot.data?.quote}"),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
```

<div class="content-ad"></div>

하지만 이 방식에는 유지 및 확장이 어려워지고, 앱이 추가 기능과 함께 복잡해질수록 문제가 발생할 수 있습니다. 이를 해결하기 위해 홈 화면을 다른 파일로 분리하고, 서비스 로케이터 메서드를 생성하여 Bloc을 사용하여 상태를 관리할 것입니다.

# Bloc 생성

알다시피 Flutter 애플리케이션에서 Bloc을 구현하려면 상태 파일, 이벤트 파일, 그리고 이벤트를 기반으로 상태를 발행하는 Bloc 파일을 생성해야 합니다. 이 경우 API가 데이터를 가져오기 시작할 때와 완료될 때 피드백을 제공하는 간단한 로직 상태가 있습니다. 따라서 로딩 중인지와 견적이 이용 가능한지를 나타내는 상태가 있을 것입니다.

```js
class QuoteBlocState extends Equatable {

  final bool? isLoadingQuote;
  final QuoteEntitie? quote;

  const QuoteBlocState({this.isLoadingQuote, this.quote});

  QuoteBlocState copyWith({
    bool? isLoadingQuote,
    QuoteEntitie? quote
    }) {
    return QuoteBlocState(
      isLoadingQuote: isLoadingQuote ?? this.isLoadingQuote,
      quote: quote ?? this.quote,
    );
  }

  @override
  List<Object?> get props => [
    isLoadingQuote,
    quote
    ];
}
```

<div class="content-ad"></div>

```js
sealed class QuoteBlocEvent extends Equatable {
  const QuoteBlocEvent();

  @override
  List<Object> get props => [];
}

final class GetQuouteEvent extends QuoteBlocEvent{
  const GetQuouteEvent();
}
```

```js
class QuoteBloc extends Bloc<QuoteBlocEvent, QuoteBlocState> {

  final QuoteUsecase _quoteUsecase;

  QuoteBloc(this._quoteUsecase) : super(const QuoteBlocState()) {
    on<GetQuouteEvent>(_getQuote);
  }

  FutureOr<void> _getQuote(
      GetQuouteEvent event, Emitter<QuoteBlocState> emit) async {
    emit(state.copyWith(isLoadingQuote: true));
    final QuoteEntitie response = await _quoteUsecase.getQuote();
    emit(state.copyWith(quote: response, isLoadingQuote: false));
  }
}
```

여기서는 use case가 생성자로 주입되어 getQuote() 함수를 사용할 수 있도록 되어 있다는 점을 강조하는 것이 매우 중요합니다.

우리의 기본 아키텍처를 완성하기 위해 필요한 유일한 것은 서비스를 위한 초기화(init) 함수를 만드는 것입니다. 이 함수를 통해 앱 전체에서 필요한 경우 서비스를 사용할 수 있습니다. get_it 패키지를 사용하면 이를 매우 간단하게 만들 수 있습니다. 아래와 같은 함수를 만드는 것만 필요합니다:

<div class="content-ad"></div>

```js
최종 getIt = GetIt.instance;

void initServices() {

  이제 http.Client client = getIt.registerSingleton(http.Client());

  이제 QuoteDataSourceImpl quoteDataSourceImpl =
      getIt.registerSingleton(QuoteDataSourceImpl(client));

  이제 QuoteRepositoryImpl quoteRepositoryImpl =
      getIt.registerSingleton(QuoteRepositoryImpl(quoteDataSourceImpl));

  이제 QuoteUsecase quoteUsecase =
      getIt.registerSingleton(QuoteUsecase(quoteRepositoryImpl));

  getIt.registerFactory(() => QuoteBloc(quoteUsecase));
}
```

main 함수에서 runApp() 이전에 initServices() 함수를 호출하여 애플리케이션의 모든 부분이 인스턴스에 액세스할 수 있도록 합니다.

```js
void main() {
  intServices();
  runApp(const MyApp());
}
```

이 시점에서 Bloc을 사용한 상태 관리 및 이미 설정된 서비스 로케이터를 사용하여 표현 레이어가 이렇게 보여야 합니다. 화면을 독립적인 파일로 분리하는 것을 잊지 마세요.

<div class="content-ad"></div>

![How to Implement Clean Architecture with Bloc and get_it Package in Flutter 2](/assets/img/2024-06-21-HowtoimplementcleanarchitecturewithBlocandget_itpackageinFlutter_2.png)

마지막으로, 관심 분리를 위해 홈 화면은 작은 위젯으로, 랜덤 인용구와 그 저자를 표시하는 컬럼이 있습니다. 또한, API에서 새 데이터를 가져와 다른 인용구를 검색하는 버튼이 있습니다. 데이터를 가져오는 동안에는 CircularProgressIndicator 위젯을 표시합니다.

```js
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: _QuoteWidget()),
    );
  }
}

class _QuoteWidget extends StatelessWidget {
  const _QuoteWidget();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final QuoteBlocState state = context.select((QuoteBloc bloc) => bloc.state);
      final bool? isLoading = state.isLoadingQuote;
      final QuoteEntity? quote = state.quote;

      if (isLoading == true) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("${quote?.quote}"),
          Text("${quote?.author}"),
          ElevatedButton(
              onPressed: () {
                context.read<QuoteBloc>().add(const GetQuoteEvent());
              },
              child: const Text("Get another quote"))
        ],
      );
    });
  }
}
```

마지막 단계는 Bloc을 get_it을 사용하여 필요한 위치에 주입하는 것입니다. QuouteBloc의 인스턴스가 서비스 로케이터를 사용하여 위젯 트리에 주입되는 점에 유의하십시오. 마지막으로, Bloc 인스턴스가 생성된 후 인용구를 가져오고 새 상태를 발생시키는 이벤트를 호출하기 위해 연속 연산자를 사용하세요.

<div class="content-ad"></div>

```js
class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quote App',
        home: BlocProvider(
          create: (context) => getIt<QuoteBloc>()..add(const GetQuouteEvent()),
          child: Builder(builder: (context) {
            return const HomeScreen();
          }),
        ));
  }
}
```

그러니까 이제 앱을 실행시켜서 코딩의 매력을 만끽해보세요.

![image](/assets/img/2024-06-21-HowtoimplementcleanarchitecturewithBlocandget_itpackageinFlutter_3.png)
