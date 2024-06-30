---
title: "플러터에서 BloC 패턴으로 Fetch API 사용 방법"
description: ""
coverImage: "/assets/img/2024-06-21-FetchAPIWithBloCinFlutter_0.png"
date: 2024-06-21 22:39
ogImage:
  url: /assets/img/2024-06-21-FetchAPIWithBloCinFlutter_0.png
tag: Tech
originalTitle: "Fetch API With BloC in Flutter"
link: "https://medium.com/gitconnected/fetch-api-with-bloc-in-flutter-730b9e305c54"
---

이 문서에서는 블록 라이브러리를 사용하여 HTTP 요청을 수행하고 애플리케이션의 상태를 관리하는 방법을 살펴보겠습니다. 최종 애플리케이션은 다음과 같습니다:

![애플리케이션 데모](https://miro.medium.com/v2/resize:fit:576/1*amzYfYKgiZ8zpehBTVcx4w.gif)

앱이 처음 실행될 때, 서버에서 데이터를 가져올 때 로딩 표시기가 표시됩니다. 데이터를 가져온 후에는 목록에 표시됩니다.

이를 위해 몇 가지 패키지를 사용하겠습니다:

<div class="content-ad"></div>

```yaml
dependencies:
  flutter_bloc: ^8.1.1
  http: ^0.13.5
  equatable: ^2.0.5
```

이제 API를 사용하여 서버에서 데이터를 가져오는 메커니즘을 만들어 보겠습니다. http 작업을 수행하기 위해 lib 내부에 폴더를 생성하고 repo라는 이름으로 지정합니다. 이 repo 내부에 repositories.dart라는 새 파일을 생성합니다.

```js
import 'dart:convert';

import 'package:bloc_example/models/user_model.dart';
import 'package:http/http.dart';

class UserRepository {
  String userUrl = 'https://reqres.in/api/users?page=2';

  Future<List<UserModel>> getUsers() async {
    Response response = await get(Uri.parse(userUrl));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      return result.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
```

http 요청을 수행하려면 http 패키지를 사용할 것입니다. 이제 json 내용을 살펴봅시다. 우리는 이 링크의 API를 사용하고 있습니다.

<div class="content-ad"></div>

위의 링크에서 제공되는 JSON을 보면 모델이 어떻게 보일지에 대한 아이디어를 얻을 수 있습니다. 이 JSON에서는 데이터 태그의 속성을 갖게 될 것입니다. 여기서 우리는 firstname, lastname, email, 그리고 avatar에 초점을 맞출 것입니다.

이제 모델 클래스를 만들어 봅시다.

```js
class UserModel {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  UserModel({this.id, this.email, this.firstName, this.lastName, this.avatar});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
  }
}
```

계속해서, 이제 우리의 블록이 어떻게 작동하는지에 대해 알아보겠습니다.

<div class="content-ad"></div>

<img src="/assets/img/2024-06-21-FetchAPIWithBloCinFlutter_0.png" />

위의 그림을 보면

- 먼저 UI가 있고 UI에서 블록으로 요청을 합니다.
- 블록에는 이벤트와 상태 두 가지가 있습니다. 먼저 UI가 블록에 연결되면 이벤트를 생성하고 트리거합니다.
- 이벤트는 최종적으로 엔드포인트를 통해 서버에 저장소를 호출합니다.
- 서버에서 데이터를 가져와 블록에 다시 전달합니다. 데이터가 있으므로 상태를 트리거합니다.
- 상태가 변경되었으므로 UI는 Bloc 패턴에서 알고 UI를 업데이트합니다.

새 폴더 blocs를 만들고 app_states.dart라는 새 파일을 생성합니다.

<div class="content-ad"></div>

```js
import 'package:bloc_example/models/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class UserState extends Equatable {}

class UserLoadingState extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoadedState extends UserState {
  final List<UserModel> users;
  UserLoadedState(this.users);
  @override
  List<Object?> get props => [users];
}

class UserErrorState extends UserState {
  final String error;
  UserErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
```

Equatable를 사용하면 값들을 비교할 수 있습니다. 두 변수가 동일한 값을 갖고 있다면 UI를 변경하거나 업데이트하지 않을 것입니다.

먼저 상태를 생성하려면 equatable을 확장해야 하는 추상 클래스를 생성해야 합니다.

Bloc에서 x.obs를 통해 변수를 반응형으로 만들 수 있는 Getx와 달리 Bloc에서는 이와 같이 작동하지 않습니다. Bloc을 사용할 때는 모든 상태가 클래스임을 염두에 두어야 합니다.

<div class="content-ad"></div>

이 프로젝트에서는 세 가지 상태가 있습니다.

- 데이터를 불러올 때의 상태
- 데이터를 불러왔을 때의 상태
- 데이터를 가져오는 데 오류가 발생했을 때의 상태

그리고 Equatable 내부에 get props라는 속성이 있습니다. 이를 재정의해야 합니다. UserState 클래스가 Equatable을 확장했으므로 UserLoadingState, UserLoadedState 및 UserErrorState 상태 클래스가 get props 속성에 액세스할 수 있게 됩니다. 이를 얻기 위해 재정의하고 해당 값을 설정해야 합니다.

상태 이후, Flutter 블록에서는 각 상태마다 이벤트가 있습니다. 지금 app_events.dart라는 파일을 만들어야 합니다. 상태와 마찬가지로 이벤트를 위한 클래스를 생성해야 합니다.

<div class="content-ad"></div>

```js
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class UserEvent extends Equatable {
  const UserEvent();
}

class LoadUserEvent extends UserEvent {
  @override
  List<Object?> get props => [];
}
```

상태처럼 이벤트도 Equatable 클래스를 확장해야 합니다. 각 이벤트를 위한 전용 클래스를 만들어야 합니다. 이벤트 클래스는 기본 클래스를 확장해야 합니다. 여기서 기본 클래스는 UserEvent입니다. 그리고 이벤트는 LoadUserEvent입니다. 그리고 get props를 재정의해야 합니다.

@immutable은 클래스의 속성을 변경하고 싶지 않다는 것을 나타냅니다.

상태와 이벤트를 생성한 후에는 그들을 연결하는 방법을 찾아야 합니다.

<div class="content-ad"></div>

그러려면 새 클래스를 만들고 방금 만든 상태와 이벤트를 삽입해야 해요. 이제 Bloc 라이브러리를 사용하여 이것들을 연결해 보죠.

blocs 폴더 안에 app_blocs라는 새 파일을 만들어주세요.

```js
import 'package:bloc_example/blocs/app_events.dart';
import 'package:bloc_example/blocs/app_states.dart';
import 'package:bloc_example/repos/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(UserLoadingState()) {
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final users = await _userRepository.getUsers();
        emit(UserLoadedState(users));
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });
  }
}
```

여기엔 UserBloc이라는 클래스가 있습니다. 이 클래스는 Bloc을 확장합니다. 이 Bloc은 이벤트와 상태를 가져와야 합니다. 저희 경우에는 UserEvent와 UserState입니다. 이곳에서 사용하는 Bloc은 실제로 Bloc 라이브러리에서 제공됩니다.

<div class="content-ad"></div>

이 UserBloc에는 리포지토리를 전달하는 생성자가 있어요. UI에서 이것을 호출할 거거든요. 이 클래스를 호출하는 동안 UserRepository를 전달합니다. Bloc을 사용했기 때문에 초기 상태를 슈퍼 생성자에 전달해야해요. 초기값을 호출한 후에는 on 메소드를 호출하게 됩니다.

이제 on 메소드는 이벤트 유형을 가져와서 LoadUserEvent를 여기에 전달합니다. 이 이벤트를 사용하여 어떤 작업을 수행할 수 있어요. 이 이벤트가 호출되면 일부 상태를 방출하도록 지정합니다. 이 경우에는 UserLoadingState를 UI에서 변경 사항을 확인하려고 해요.

BLoc에서 상태, 이벤트를 연결하여 상태를 트리거하고 작업할 수 있도록 하려면 lib 폴더에 homepage.dart라는 새 파일을 만들어요.

```js
class HomePage extends StatelessWidget {
  const HomePage({Key key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc(UserRepository()),
        ),
      ],
      child: Scaffold(
          appBar: AppBar(title: const Text('The BloC App')),
          body: blocBody()),
    );
  }

Widget blocBody() {
    return BlocProvider(
      create: (context) => UserBloc(
        UserRepository(),
      )..add(LoadUserEvent()),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
           if (state is UserErrorState) {
            return const Center(child:  Text("Error"));
          }
          if (state is UserLoadedState) {
            List<UserModel> userList = state.users;
            return ListView.builder(
                itemCount: userList.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Card(
                        color: Theme.of(context).primaryColor,
                        child: ListTile(
                            title: Text(
                              '${userList[index].firstName}  ${userList[index].lastName}',
                              style: const TextStyle(color: Colors.white),
                            ),

                            subtitle: Text(
                              '${userList[index].email}',
                              style: const TextStyle(color: Colors.white),
                            ),

                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  userList[index].avatar.toString()),
                            ))),
                  );
                });
          }

          return Container();
        },
      ),
    );
  }
}
```

<div class="content-ad"></div>

보시다시피 'MultiBlocProvider'가 제공되는 우리의 bloc 라이브러리에서 온 것을 확인할 수 있어요. 서버에서 데이터를로드하고 한 번만 로드하려고하기 때문에 빌드 방법에서 UserRepository를 주입합니다. bloc 형식의 MultiBlocProvider에서는 클래스에 여러 Bloc을 추가하여 전체 클래스에서 사용할 수 있습니다. 또한이 리포지토리를 배치할 위치에는 클래스가 있어야합니다. 우리의 경우에는 Scaffold입니다.

그래서 MultiBlocProvider가 하는 일은 서버에서 데이터를 이동시키고 이를 만들어서 데이터와 상태를 모든 하위 요소에서 사용할 수 있게하는 것입니다.

blocBody 내부에서 BlocProvider를 볼 수 있습니다. Getx에 익숙하다면 Get.put와 비슷합니다. BlocProvider 내부에서는 리포지토리와 함께 bloc 즉 UserBloc을 주입합니다. 위에서 이미 bloc을 주입했으므로 blocBody 내에서 이벤트에 액세스 할 수 있습니다.

리포지토리와 함께 bloc을 주입 한 후에는 이벤트 즉 LoadUserEvent를 추가하고 이를 사용하여 UserBloc에서 UserLoadingState를 트리거하는 캐스캐이딩 연산자를 사용합니다.

<div class="content-ad"></div>

이제 빌더 내부의 상태를 확인할 수 있습니다. 세 가지 상태가 있으므로 각각을 확인하여 다른 작업을 수행하고 다른 UI를 반환합니다.

다음과 같이 확인할 수 있습니다.

- `UserLoadingState`일 때는 데이터를 불러오고 있다는 의미로 CircularProgressIndicator를 표시합니다.
- `UserLoadedState`일 때는 데이터 목록을 반환합니다.
- `UserErrorState`일 때는 오류 메시지를 반환합니다.

이제 애플리케이션을 실행하면 bloc 라이브러리를 사용하여 데이터가 검색될 것입니다.

<div class="content-ad"></div>

단점을 확인하려면 잘못된 종단점을 만들어 보실 수 있습니다.

# 결론

이 글에서 Bloc 및 Bloc 작업 메커니즘에 대해 설명했습니다. 필요에 맞게 코드를 조정하여 사용해 보세요. 새 페이지를 만들어 보는 것도 좋은 방법입니다. Bloc 아키텍처는 대규모 프로젝트에 매우 유용할 수 있습니다.

이 블로그 게시물이 앞으로의 프로젝트에서 bloc 라이브러리와 아키텍처를 사용하는 데 충분한 중요한 정보를 제공해 줄 것을 바랍니다.

<div class="content-ad"></div>

❤ ❤ 이 글 읽어주셔서 감사합니다 ❤ ❤

만약 이 글을 좋아하셨다면 👏 두 번 치세요.

또한, 업데이트되는 흥미로운 글과 프로젝트를 확인하려면 팔로우하세요.

무엇인가 잘못된 점이 있다면? 댓글로 알려주세요. 개선해나가겠습니다.

<div class="content-ad"></div>

# 함께 연결해요

우리 친구가 되어요. 페이스북, 링크드인, 깃허브, 유튜브, BuyMeACoffee, 그리고 인스타그램에서 찾아요.

방문하기: Flutter Junction

기여하기: BuyMeACoffee

<div class="content-ad"></div>

다음 링크에서 전체 코드를 확인하세요:
