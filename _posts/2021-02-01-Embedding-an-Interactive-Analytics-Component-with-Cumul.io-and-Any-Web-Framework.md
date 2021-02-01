---
layout: post
title: "Cumul.io 및 모든 웹 프레임 워크에 대화 형 분석 구성 요소 포함
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2021/01/0Uz2iFHvwRHTq4Gnz.gif
tags: 
---


이 기사에서는 Cumul.io를 사용하여 통합 된 대화 형 데이터 시각화 레이어를 애플리케이션에 구축하는 방법을 설명합니다.
 이를 위해 Spotify 재생 목록 분석을 시각화하는 데모 애플리케이션을 구축했습니다!
 Cumul.io는 통합을 매우 쉽게 만들고 대시 보드와 애플리케이션 (예 : 사용자 지정 이벤트) 간의 상호 작용을 허용하는 기능을 제공하므로 대화 형 대시 보드로 사용합니다.
 이 앱은 Node.js 서버가있는 간단한 JavaScript 웹 앱이지만 원하는 경우 Cumul.io 대시 보드를 사용하면서 Angular, React 및 React Native에서도 동일한 작업을 수행 할 수 있습니다.
 

여기에서는 Kaggle Spotify 데이터 세트 1921–2020, 16 만 개 이상의 트랙의 데이터와 사용자가 로그인 할 때 Spotify Web API를 통해 데이터를 표시하는 대시 보드를 구축합니다. 우리는 재생 목록 및 노래 특성에 대한 통찰력으로 대시 보드를 구축했습니다.
 이러한 대시 보드를 방문하는 모든 최종 사용자가 차트에서 노래를 선택하고 자신의 Spotify 재생 목록 중 하나에 추가 할 수 있도록 몇 가지 Cumul.io 사용자 지정 이벤트를 추가했습니다.
 또한 노래를 선택하여 더 많은 정보를 표시하고 애플리케이션 내에서 재생할 수 있습니다.
 전체 애플리케이션의 코드는 공개 저장소에서도 공개적으로 사용할 수 있습니다.
 

다음은 정식 버전의 최종 결과에 대한 간략한 설명입니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2021/01/0avSmFUvCNjdLNbTU.gif?resize=1896%2C921&ssl=1)

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/0Uz2iFHvwRHTq4Gnz.gif?resize=1896%2C921&ssl=1)

### Cumul.io 사용자 지정 이벤트 및 기능은 무엇입니까?
 

간단히 말해, Cumul.io 사용자 정의 이벤트는 대시 보드가 통합 된 애플리케이션에서 사용할 대시 보드에서 이벤트를 트리거하는 방법입니다. 대시 보드에서 선택한 차트에 사용자 정의 이벤트를 추가하고 애플리케이션이이를 수신하도록 할 수 있습니다.
 이벤트.
 

왜?
 이 도구의 멋진 점은 내장 된 애플리케이션 내에서 분석 대시 보드 인 BI 도구의 데이터를 재사용 할 수 있다는 점입니다.
 통합 대시 보드 내에서 직접 트리거 할 수있는 데이터를 기반으로하는 작업을 자유롭게 정의 할 수있는 동시에 대시 보드, 분석 계층을 애플리케이션에 대해 완전히 별도의 엔티티로 유지하여 별도로 관리 할 수 있습니다.
 

포함 내용 : Cumul.io 사용자 지정 이벤트는 대시 보드 전체가 아닌 차트에 첨부됩니다.
 따라서 이벤트가 갖는 정보는 차트에있는 정보로 제한됩니다.
 

이벤트는 단순히 JSON 객체를 넣는 것입니다.
 이 개체에는 해당 개체를 트리거 한 대시 보드의 ID, 이벤트 이름 및 이벤트가 트리거 된 차트 유형에 따라 다른 여러 필드와 같은 필드가 포함됩니다.
 예를 들어 이벤트가 산점도에서 트리거 된 경우 트리거 된 지점의 x 축 및 y 축 값을 받게됩니다.
 반면에 테이블에서 트리거 된 경우 예를 들어 열 값을 받게됩니다.
 이러한 이벤트가 다른 차트에서 어떻게 보이는지에 대한 예를 참조하십시오.
 

```js
// 'Add to Playlist' custom event from a row in a table
{
 "type":"customEvent",
 "dashboard":"xxxx",
 "name":"xxxx",
 "object":"xxxx",
 "data":{
   "language":"en",
   "columns":[
     {"id":"Ensueno","value":"Ensueno","label":"Name"}, 
     {"id":"Vibrasphere","value":"Vibrasphere","label":"Artist"}, 
     {"value":0.406,"formattedValue":"0.41","label":"Danceability"}, 
     {"value":0.495,"formattedValue":"0.49","label":"Energy"}, 
     {"value":180.05,"formattedValue":"180.05","label":"Tempo (bpm)"}, 
     {"value":0.568,"formattedValue":"0.5680","label":"Accousticness"}, 
     {"id":"2007-01-01T00:00:00.000Z","value":"2007","label":"Release Date (Yr)"},
   ],
   "event":"add_to_playlist"
 }
}
```

```js
//'Song Info' custom event from a point in a scatter plot
{
 "type":"customEvent",
 "dashboard":"xxxx",
 "name":"xxxx",
 "object":"xxxx",
 "data":{
   "language":"en",
   "x-axis":{"id":0.601,"value":"0.601","label":"Danceability"},
   "y-axis":{"id":0.532,"value":"0.532","label":"Energy"},
   "name":{"id":"xxxx","value":"xxx","label":"Name"},
   "event":"song_info"
  }
}
```

이 기능의 가능성은 사실상 무한합니다.
 물론,하고 싶은 일에 따라 몇 줄의 코드를 더 작성해야 할 수도 있지만, 이는 틀림없이 강력한 도구입니다!
 

### 대시 보드
 

여기서는 실제로 대시 보드 생성 프로세스를 거치지 않고 애플리케이션에 통합 된 후 상호 작용 비트에 초점을 맞출 것입니다.
 이 연습에 통합 된 대시 보드는 이미 생성되었으며 사용자 지정 이벤트가 활성화되어 있습니다.
 물론 사전 구축 한 계정 대신 직접 만든 계정을 통합 할 수 있습니다 (무료 평가판으로 계정을 만들 수 있음).
 그러나 이전에는 Cumul.io 대시 보드에 대한 배경 정보가 있습니다.
 

Cumul.io는 플랫폼 내에서 또는 API를 통해 대시 보드를 생성하는 방법을 제공합니다.
 두 경우 모두 대시 보드는 통합하려는 애플리케이션과 분리 된 플랫폼 내에서 사용할 수 있으므로 완전히 별도로 유지 관리 할 수 있습니다.
 

방문 페이지에 대시 보드가 표시되며 새 대시 보드를 만들 수 있습니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2021/01/1Y0fD7JscJBpmPK5zFkfKKg.png?resize=783%2C295&ssl=1)

하나를 열고 원하는 차트를 끌어서 놓을 수 있습니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2021/01/1c05WlgHphYkir4X-BTTDOg.png?resize=1320%2C635&ssl=1)

데이터를 연결 한 다음 해당 차트로 끌어서 놓을 수 있습니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2021/01/1kEuxpXPguL7HqZcIOleOMA.png?resize=487%2C372&ssl=1)

그리고 그 데이터는 여러 가지 중 하나가 될 수 있습니다.
 Cumul.io에 연결할 수있는 기존 데이터베이스, 사용하는 데이터웨어 하우스의 데이터 세트, 사용자 정의 빌드 플러그인 등과 같습니다.
 

### 사용자 지정 이벤트 활성화
 

이 데모에 사용 된 대시 보드의 산점도 및 테이블에 대해 이러한 사용자 지정 이벤트를 이미 활성화했으며 다음 섹션에서 통합 할 것입니다.
 이 단계를 진행하려면 자신 만의 대시 보드도 자유롭게 만들어보세요!
 

가장 먼저해야 할 일은 차트에 사용자 지정 이벤트를 추가하는 것입니다.
 이렇게하려면 먼저 대시 보드에서 이벤트를 추가 할 차트를 선택합니다.
 차트 설정에서 상호 작용을 선택하고 사용자 지정 이벤트를 켭니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2021/01/0ojFaGidUo9m5K5X3.png?resize=335%2C195&ssl=1)

이벤트를 추가하려면 편집을 클릭하고 이벤트 이름과 레이블을 정의하십시오.
 이벤트 이름은 애플리케이션이 받게 될 것이며 라벨은 대시 보드에 표시되는 것입니다.
 우리의 경우에는 2 개의 이벤트를 추가했습니다.
 `재생 목록에 추가`및 `노래 정보`:
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2021/01/0v-1U3X09jBCtkkBU.png?resize=445%2C66&ssl=1)

이는 대시 보드에서 차트 수준에서 이벤트를 트리거하는 데 필요한 모든 설정입니다.
 편집기를 종료하기 전에 나중에 대시 보드를 통합하려면 대시 보드 ID가 필요합니다.
 대시 보드의 설정 탭에서 찾을 수 있습니다.
 나머지 작업은 애플리케이션 수준으로 유지됩니다.
 여기서 우리가 이러한 이벤트를 수신하면 실제로하고 싶은 일을 정의 할 수 있습니다.
 

### 요점
 

- 이벤트는 차트 수준에서 작동하며 차트의 정보 범위 내에서 정보를 포함합니다.
 
- 이벤트를 추가하려면 이벤트를 추가하려는 차트의 차트 설정으로 이동하십시오.
 
- 이벤트의 이름과 레이블을 정의합니다.
 그리고 끝났습니다!
 
- (통합을 위해 대시 보드 ID를 기록해 두는 것을 잊지 마십시오)
 

### 자신의 플랫폼에서 사용자 지정 이벤트 사용
 

대시 보드에 몇 가지 이벤트를 추가 했으므로 다음 단계는 이벤트를 사용하는 것입니다.
 여기서 핵심은 대시 보드에서 이벤트를 클릭하면 대시 보드를 통합하는 애플리케이션이 이벤트를 수신한다는 것입니다.
 통합 API는 이러한 이벤트를 수신하는 기능을 제공하며 이벤트로 수행 할 작업을 정의하는 것은 사용자의 몫입니다.
 SDK의 API 및 코드 예제에 대한 자세한 내용은 관련 개발자 문서를 확인할 수도 있습니다.
 

이 섹션에서는 맞춤 이벤트를 추가하기위한 시작 프로젝트로 사용할 수있는 개방형 GitHub 저장소 (기본 애플리케이션 용 저장소와 별도로)도 제공합니다.
 

cumulio-spotify-datatalks 저장소는 스켈레톤이라는 커밋에서 처음부터 시작하기 위해 체크 아웃 할 수 있도록 구조화되어 있습니다.
 다음의 모든 커밋은 여기에서 수행하는 단계를 나타냅니다.
 맞춤 이벤트를 보여주는 앱의 주요 부분에 초점을 맞춘 전체 애플리케이션의 요약 버전입니다.
 `src / spotify.js`에있는 Spotify API 호출과 같은 일부 단계를 건너 뛰어이 튜토리얼을 `맞춤 이벤트 추가 및 사용`주제로 제한합니다.
 

### 다음 단계에 대한 유용한 정보
 

- cumulio-spotify-datatalks 저장소를 사용하고 `스켈레톤`커밋을 시작점으로 체크 아웃 할 수 있습니다.
 
- 모든 변경 및 코드 추가는`src / app.js`에서 이루어집니다.
 
- 실행할 종속성 및 지침은이 게시물의 끝에 있습니다.
 

우리의 경우 어떻게되는지 살펴 보겠습니다.
 우리는 두 개의 이벤트를 만들었습니다.
 `add_to_playlist` 및`song_info`.
 대시 보드 방문자가 자신의 Spotify 계정에서 선택한 재생 목록에 노래를 추가 할 수 있기를 바랍니다.
 이를 위해 다음 단계를 수행합니다.
 

- 대시 보드를 앱과 통합
 
- 들어오는 이벤트 듣기
 

먼저 애플리케이션에 대시 보드를 추가해야합니다.
 여기서는 Cumul.io Spotify Playlist 대시 보드를 기본 대시 보드로 사용하고 Song Info 대시 보드를 드릴 스루 대시 보드로 사용합니다 (즉, 이벤트를 트리거 할 때 나타나는 기본 대시 보드 내에 새 대시 보드를 생성 함을 의미합니다).
 스켈레톤 및`npm run start`라는 커밋을 체크 아웃 한 경우 애플리케이션은 현재 오른쪽 상단에 로그인 버튼이있는 빈 `Cumul.io 즐겨 찾기`탭을 열어야합니다.
 프로젝트를 로컬에서 실행하는 방법에 대한 지침은 문서 하단으로 이동하십시오.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2021/01/0x7AFoAvk5ME5pVx7.png?resize=1024%2C459&ssl=1)

대시 보드를 통합하려면`Cumulio.addDashboard ()`함수를 사용해야합니다.
 이 함수에는 대시 보드 옵션이있는 개체가 필요합니다.
 대시 보드를 추가하기 위해 수행하는 작업은 다음과 같습니다.
 

`src / app.js`에서 메인 대시 보드의 대시 보드 ID를 저장하는 객체와`dashboardOptions` 객체와 함께 노래 정보를 표시하는 드릴 스루 대시 보드를 생성합니다.
 

```js
// create dashboards object with the dashboard ids and dashboardOptions object

// !!!change these IDs if you want to use your own dashboards!!!
const dashboards = {
  playlist: 'f3555bce-a874-4924-8d08-136169855807', 
  songInfo: 'e92c869c-2a94-406f-b18f-d691fd627d34',
};

const dashboardOptions = {
  dashboardId: dashboards.playlist,
  container: '#dashboard-container',
  loader: {
    background: '#111b31',
    spinnerColor: '#f44069',
    spinnerBackground: '#0d1425',
    fontColor: '#ffffff'
  }
};
```

`Cumulio.addDashboard ()`를 호출하는`loadDashboard ()`함수를 만듭니다.
 이 함수는 선택적으로 컨테이너를 수신하고 대시 보드를 애플리케이션에 추가하기 전에`dashboardOptions` 객체를 수정합니다.
 

```js
// create a loadDashboard() function that expects a dashboard ID and container

const loadDashboard = (id, container) => {
  dashboardOptions.dashboardId = id;
  dashboardOptions.container = container || '#dashboard-container';  
  Cumulio.addDashboard(dashboardOptions);
};
```

마지막으로이 함수를 사용하여 Cumul.io 즐겨 찾기 탭을로드 할 때 재생 목록 대시 보드를 추가합니다.
 

```js
export const openPageCumulioFavorites = async () => {
  ui.openPage('Cumul.io playlist visualized', 'cumulio-playlist-viz');
  /**************** INTEGRATE DASHBOARD ****************/
  loadDashboard(dashboards.playlist);
};
```

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2021/01/06V59_iEvoCnWbQiX.png?resize=1024%2C505&ssl=1)

이 시점에서 재생 목록 대시 보드를 통합했으며 노래 별 에너지 / 댄스 가능성 산점도에서 한 지점을 클릭하면 이전에 추가 한 사용자 지정 이벤트에 두 가지 옵션이 표시됩니다.
 하지만 아직 아무것도하지 않고 있습니다.
 

이제 대시 보드를 통합 했으므로 이벤트를 수신하면 앱에 작업을 지시 할 수 있습니다.
 여기에 `재생 목록에 추가`및 `노래 정보`이벤트가있는 두 차트는 다음과 같습니다.
 

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2021/01/0hK2NSi-pMFAPzUgf.png?resize=1024%2C243&ssl=1)

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2021/01/0K_egRgHOjJISEMbu.png?resize=1024%2C206&ssl=1)

먼저 들어오는 이벤트를 수신하도록 코드를 설정해야합니다.
 이를 위해서는`Cumulio.onCustomEvent ()`함수를 사용해야합니다.
 여기서는 Cumul.io 즐겨 찾기 탭을로드 할 때 호출 할 수있는`listenToEvents ()`함수로이 함수를 래핑하도록 선택했습니다.
 그런 다음 if 문을 사용하여 수신 한 이벤트를 확인합니다.
 

```js
const listenToEvents = () => {
  Cumulio.onCustomEvent((event) => {
    if (event.data.event === 'add_to_playlist'){
      //DO SOMETHING
    }
    else if (event.data.event === 'song_info'){
      //DO SOMETHING
    }
  });
};
```

이것이 당신의 필요와 창의력에 달려있는 시점입니다.
 예를 들어, 단순히 콘솔에 라인을 인쇄하거나 이벤트에서받은 데이터를 중심으로 자신 만의 동작을 디자인 할 수 있습니다.
 또는 재생 목록 선택기를 표시하는 일부 도우미 기능을 사용하여 재생 목록에 노래를 추가하고 노래 정보 대시 보드를 통합 할 수도 있습니다.
 이것이 우리가 한 방법입니다.
 

### 재생 목록에 노래 추가
 

여기서는`src / ui.js`의`addToPlaylistSelector ()`함수를 사용합니다.
 이 기능은 노래 이름과 ID를 예상하며 로그인 한 사용자의 사용 가능한 모든 재생 목록이있는 창을 표시합니다.
 그런 다음 Spotify API 요청을 게시하여 선택한 재생 목록에 노래를 추가합니다.
 Spotify Web API에서 노래를 추가하려면 노래 ID가 필요하므로 산점도에 사용할 파생 된 `이름 및 ID`필드를 만들었습니다.
 

`add_to_playlist`에서 수신하는 예제 이벤트에는 산점도에 대해 다음이 포함됩니다.
 

```js
"name":{"id":"So Far To Go&id=3R8CATui5dGU42Ddbc2ixE","value":"So Far To Go&id=3R8CATui5dGU42Ddbc2ixE","label":"Name & ID"}
```

테이블에 대한 다음 열 :
 

```js
"columns":[
 {"id":"Weapon Of Choice (feat. Bootsy Collins) - Remastered Version","value":"Weapon Of Choice (feat. Bootsy Collins) - Remastered Version","label":"Name"},
 {"id":"Fatboy Slim","value":"Fatboy Slim","label":"Artist"},  
 // ...
 {"id":"3qs3aHNUcqFGv7jMYJJCYa","value":"3qs3aHNUcqFGv7jMYJJCYa","label":"ID"}
]
```

`getSong ()`함수를 통해 이벤트에서 노래의 이름과 ID를 추출한 다음`ui.addToPlaylistSelector ()`함수를 호출합니다.
 

```js
/*********** LISTEN TO CUSTOM EVENTS AND ADD EXTRAS ************/
const getSong = (event) => {
  let songName;
  let songArtist;
  let songId;
  if (event.data.columns === undefined) {
    songName = event.data.name.id.split('&id=')[0];
    songId = event.data.name.id.split('&id=')[1];
  }
  else {
    songName = event.data.columns[0].value;
    songArtist = event.data.columns[1].value;
    songId = event.data.columns[event.data.columns.length - 1].value;
  }
  return {id: songId, name: songName, artist: songArtist};
};

const listenToEvents = () => {
  Cumulio.onCustomEvent(async (event) => {
    const song = getSong(event);
    console.log(JSON.stringify(event));
    if (event.data.event === 'add_to_playlist'){
      await ui.addToPlaylistSelector(song.name, song.id);
    }
    else if (event.data.event === 'song_info'){
      //DO SOMETHING
    }
  });
};
```

이제 `재생 목록에 추가`이벤트에 로그인 한 사용자가 노래를 추가 할 수있는 사용 가능한 재생 목록이있는 창이 표시됩니다.
 

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2021/01/0xGmzPpSVs1j2yZGj.png?resize=1024%2C365&ssl=1)

### 더 많은 노래 정보 표시
 

마지막으로하고 싶은 것은 `노래 정보`이벤트를 클릭 할 때 다른 대시 보드를 표시하는 것입니다.
 선택한 노래에 대한 추가 정보가 표시되고 노래 재생 옵션이 포함됩니다.
 또한 배경 지식이 필요할 수있는 좀 더 복잡한 API 사용 사례에 들어가는 단계이기도합니다.
 특히, 우리는 매개 변수화 가능한 필터를 사용합니다.
 아이디어는 권한 부여 토큰을 생성하는 동안 값을 정의 할 수있는 대시 보드에 매개 변수를 생성하는 것입니다.
 인증 토큰을 만드는 동안 매개 변수를 메타 데이터로 포함합니다.
 

이 단계에서는 노래 정보 대시 보드의 필터에 사용되는`songId` 매개 변수를 만들었습니다.
 

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2021/01/0ZKnJctEuVVBrrx9X.png?resize=470%2C232&ssl=1)

그런 다음`getDashboardAuthorizationToken ()`함수를 만듭니다.
 이것은 `server / server.js`에있는 서버의 `/ authorization`엔드 포인트에 게시하는 메타 데이터를 예상합니다.
 

```js
const getDashboardAuthorizationToken = async (metadata) => {
  try {
    const body = {};
    if (metadata && typeof metadata === 'object') {
      Object.keys(metadata).forEach(key => {
        body[key] = metadata[key];
      });
    }

    /*
      Make the call to the backend API, using the platform user access credentials in the header
      to retrieve a dashboard authorization token for this user
    */
    const response = await fetch('/authorization', {
      method: 'post',
      body: JSON.stringify(body),
      headers: { 'Content-Type': 'application/json' }
    });

    // Fetch the JSON result with the Cumul.io Authorization key & token
    const responseData = await response.json();
    return responseData;
  }
  catch (e) {
    return { error: 'Could not retrieve dashboard authorization token.' };
  }
};
```

마지막으로`song_info` 이벤트가 트리거 될 때`songInfo` 대시 보드를로드합니다.
 이를 위해 노래 ID를 사용하여 새 인증 토큰을 만듭니다.
 

```js
const loadDashboard = (id, container, key, token) => {
  dashboardOptions.dashboardId = id;
  dashboardOptions.container = container || '#dashboard-container';  

  if (key && token) {
    dashboardOptions.key = key;
    dashboardOptions.token = token;
  }

  Cumulio.addDashboard(dashboardOptions);
};
```

새 토큰을 사용하기 위해`loadDashboard ()`함수를 약간 수정합니다.
 

```js
const loadDashboard = (id, container, key, token) =u003e {n  dashboardOptions.dashboardId = id;n  dashboardOptions.container = container || '#dashboard-container';  nn  if (key u0026u0026 token) {n    dashboardOptions.key = key;n    dashboardOptions.token = token;n  }nn  Cumulio.addDashboard(dashboardOptions);n};
```

그런 다음`ui.displaySongInfo ()`를 호출합니다.
 최종 결과는 다음과 같습니다.
 

```js
const listenToEvents = () => {
  Cumulio.onCustomEvent(async (event) => {
    const song = getSong(event);
    if (event.data.event === 'add_to_playlist'){
      await ui.addToPlaylistSelector(song.name, song.id);
    }
    else if (event.data.event === 'song_info'){
      const token = await getDashboardAuthorizationToken({ songId: [song.id] });
      loadDashboard(dashboards.songInfo, '#song-info-dashboard', token.id, token.token);
      await ui.displaySongInfo(song);
    }
  });
};
```

그리고 voilá!
 끝났습니다!
 이 데모에서는 자세히 다루지 않은 많은 도우미 기능을 사용했지만 데모 저장소를 무료로 복제하여 사용해 볼 수 있습니다.
 이를 무시하고 사용자 지정 이벤트를 중심으로 고유 한 기능을 구축 할 수도 있습니다.
 

### 결론
 

데이터 시각화 및 분석 계층을 애플리케이션에 통합하려는 모든 사용자를 위해 Cumul.io는이 데모 전체에서 보여 주려했던 것처럼이를 달성하는 매우 쉬운 방법을 제공합니다.
 대시 보드는 애플리케이션에서 분리 된 엔터티를 유지 한 다음 별도로 관리 할 수 있습니다.
 비즈니스 환경 내에서 통합 분석을보고 있고 개발자가 항상 대시 보드를 만지작 거리는 것을 원하지 않는다면 이는 상당한 이점이됩니다.
 

반면에 대시 보드에서 트리거하고 호스트 애플리케이션에서 수신 할 수있는 이벤트를 사용하면 분리 된 대시 보드의 정보를 기반으로 구현을 정의 할 수 있습니다.
 이것은 우리의 경우 노래를 재생하는 것부터 특정 이메일을 보내도록 트리거하는 것까지 다양합니다.
 이런 의미에서 세상은 당신의 굴입니다. 당신은 분석 레이어에서 가지고있는 데이터로 무엇을할지 결정합니다.
 즉, 대시 보드의 데이터를 재사용 할 수 있으며 대시 보드 및 분석 세계에 머물 필요가 없습니다. 🙂
 

### 이 프로젝트를 실행하는 단계
 

시작하기 전에 :
 

- Cumul.io 계정이 필요합니다.
 
- Spotify 개발자 대시 보드에 애플리케이션을 등록해야합니다.
 

- `npm install`을 사용하여 cumulio-spotify-datatalks 저장소를 복제합니다.
 
- 루트 디렉터리에`.env` 파일을 만들고 Cumul.io 및 Spotify 개발자 계정에서 다음을 추가합니다.
 
- Cumul.io에서 :`CUMULIO_API_KEY = xxx CUMULIO_API_TOKEN = xxx`
 
- Spotify에서 :`SPOTIFY_CLIENT_ID = xxx SPOTIFY_CLIENT_SECRET = xxx ACCESS_TOKEN = xxx REFRESH_TOKEN = xxxnpm run start`
 
- 브라우저에서`http : // localhost : 3000 /`로 이동하여 Spotify 계정에 로그인하십시오 🥳
 