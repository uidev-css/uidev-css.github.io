---
title: "Flapjax Plotly와 Flask로 웹에서 데이터 시각화 하는 방법"
description: ""
coverImage: "/assets/img/2024-06-23-FlapjaxDataVisualizationontheWebwithPlotlyandFlask_0.png"
date: 2024-06-23 15:05
ogImage: 
  url: /assets/img/2024-06-23-FlapjaxDataVisualizationontheWebwithPlotlyandFlask_0.png
tag: Tech
originalTitle: "Flapjax: Data Visualization on the Web with Plotly and Flask"
link: "https://medium.com/towards-data-science/flapjax-data-visualization-on-the-web-with-plotly-and-flask-465090fa3fba"
---


데이터 시각화 앱을 구축하는 가장 좋은 프레임워크는 무엇인가요? Streamlit이나 Dash일까요? 아니면 Jupyter Notebook을 Mercury나 Voilá로 변환하여 바로 웹 앱을 만드는 것일까요?

이 모든 것들은 애플리케이션을 만드는 좋은 방법이며 시작하기 쉽습니다. 하지만 시작하기 쉬운 것이 결국 더 모험적인 영역으로 발전할 수 있습니다. 그래서 저는 다시 기초로 돌아가 Python 서버 코드와 HTML 페이지를 함께 사용하는 것이 생각보다 어려운 일이 아니라고 설득하려고 합니다.

우리는 상당량의 보일러플레이트 코드와 템플릿을 활용하여 매력적인 대화형 애플리케이션을 만들 수 있습니다. 이는 여전히 Python 코드에 집중할 수 있게 해주며 HTML 및 JavaScript에 공부할 부담이 적다는 것을 의미합니다. 저는 이 접근 방식을 Flapjax라고 부릅니다 — 나중에 왜 이렇게 부르는지 설명하겠습니다.

Python으로 웹 애플리케이션을 만드는 가장 간단한 방법 중 하나는 Flask를 사용하는 것이므로, 이를 사용하여 아래 이미지와 같은 앱을 만들어보겠습니다.

<div class="content-ad"></div>


![Flask Framework](/assets/img/2024-06-23-FlapjaxDataVisualizationontheWebwithPlotlyandFlask_0.png)

## 플라스크 프레임워크

Flask는 웹 애플리케이션을 개발하기 위한 최소주의 프레임워크입니다. Flask 앱에서는 웹 페이지가 일반적으로 템플릿과 파이썬 코드에서 제공된 데이터로 구성됩니다. 이 데이터는 웹 페이지의 내용을 형성하는 텍스트나 그래픽일 수 있습니다. 결과물은 사용자에게 브라우저에서 표시되도록 전송됩니다.

아래 다이어그램은 인터랙티브 앱의 기본 구조를 보여줍니다. 앱이 실행 중일 때, Python 부분은 서버에서 실행되고 브라우저에서 실행되는 HTML로 데이터를 전송합니다. 웹 페이지에서 사용자 입력이 다시 Python 코드로 전달되며, 이후 Python 코드는 더 많은 데이터를 전송하여 사용자가 선택한 새로운 콘텐츠 - 사용자가 선택한 새로운 차트와 같은 - 로 HTML을 업데이트할 수 있습니다.


<div class="content-ad"></div>


![Flapjax Data Visualization on the Web with Plotly and Flask](/assets/img/2024-06-23-FlapjaxDataVisualizationontheWebwithPlotlyandFlask_1.png)

웹 애플리케이션을 만드는 가장 쉬운 방법인가요?

내 생각에는 사용자 인터페이스 디자인과 프로그램 로직을 분리하는 것이 정말 쉽게 만드는 방법입니다. 그러나 Streamlit이나 Jupyter Notebooks에서 앱을 만드는 데 익숙하다면, 처음에는 학습 곡선이 존재할 수 있습니다. 그러나 기본 애플리케이션을 위한 패턴을 채택한 후에는 새로운 애플리케이션을 만드는 것이 훨씬 쉬워집니다.

그래서, 우리는 Flask를 사용하여 데이터 시각화 애플리케이션을 개발하고, HTML 페이지를 정의하는 Jinja 템플릿을 사용할 것입니다. 하지만 이 페이지에 나타나는 실제 데이터는 Python 코드에서 정의될 것입니다.


<div class="content-ad"></div>

인터랙티브한 사용자 인터페이스를 만들기 위해서는 일부 UI 구성 요소와 작은 양의 JavaScript가 필요합니다. 그러나 보시다시피 이는 앞으로의 애플리케이션에서 재사용 가능한 코드로 거의 표준 코드라는 것을 확인할 것입니다.

또한 웹 페이지가 왼쪽과 같이 보이는 것으로 만족하는 대신 약간의 노력으로 오른쪽과 같이 만들 수 있기 때문에 Bootstrap 5 UI 구성 요소를 사용할 것입니다.

이 자습서는 두 부분으로 나뉘어 있습니다. 먼저 정적 웹페이지를 만들고 Flask와 HTML이 어떻게 함께 작동하는지 파악한 다음 콜백을 다루어 인터랙티브 페이지를 만들 것입니다.

이 문서의 모든 코드는 내 GitHub 저장소에 있을 것입니다. 발행 후 곧바로 이를 링크할 것입니다.

<div class="content-ad"></div>

## 부트스트랩 UI

부트스트랩을 사용하면 매력적인 웹페이지를 손쉽게 만들 수 있어요. Bootstrap 5 파일을 포함하고 HTML 요소에 몇 가지 속성을 추가하면 기본 HTML을 쉽게 개선할 수 있어요.

부트스트랩 튜토리얼은 아니지만 위 웹페이지의 헤더를 만드는 기본 HTML 코드의 차이를 빨리 보여드릴게요.

기본 HTML

<div class="content-ad"></div>

```js
# 제목

부트스트랩 속성 추가

<header class="bg-primary text-white text-center py-2">
    <h1 class="display-4">제목</h1>
    <p class="lead">부제목</p>
</header>

헤더는 `h1`과 단락 요소 `p` 두 가지 요소로 구성되어 있습니다. 부트스트랩 버전에서 이들 요소는 추가된 속성을 가지고 있습니다: 헤더 자체는 주요한 배경 색상으로 흰색 텍스트를 가지며, 텍스트는 가운데 정렬되고 위아래 패딩이 2픽셀로 설정됩니다; 제목 태그는 display-4 폰트를 사용하고 단락의 폰트는 lead로 설정되어 있습니다— display 폰트는 크고 굵고, lead는 강조해야 하는 일반 텍스트용으로 정의되어 있습니다.

<div class="content-ad"></div>

이러한 특성들은 HTML class 속성에서 설정됩니다. 코드에서 더 많이 볼 수 있으며, 이해하기 쉽게 될 것입니다. 자세히 설명하지는 않겠지만 부트스트랩 문서에서 관련 정보를 찾을 수 있습니다. 그 웹사이트에서 필요한 모든 정보를 얻을 수 있을 거에요.

## 플라스크 프로젝트

플라스크 프레임워크는 웹 기반 어플리케이션을 만들기 쉽게 도와줍니다. 플라스크 어플리케이션은 일반적으로 적어도 두 개 파일로 구성됩니다: 파이썬 앱과 HTML 템플릿입니다.

파이썬 부분에는 어플리케이션 로직이 포함되어 있습니다. 예를 들어, 데이터 시각화 어플리케이션의 경우, 데이터를 Pandas 데이터프레임에로드하고, 분석을 수행하며 Plotly에서 차트를 생성할 수도 있습니다. HTML 템플릿은 웹페이지의 레이아웃을 정의하고, 파이썬 프로그램에 의해 표시할 데이터가 제공됩니다.

<div class="content-ad"></div>

/project_name
    |--- app.py
    |
    |--- /templates
            |
            |--- index.html

위의 다이어그램처럼 만들어야 할 간단한 앱의 디렉토리 구조입니다. 메인 Python 앱은 프로젝트 폴더에 있고 템플릿은 templates라는 서브폴더에 위치해 있습니다.

물론 Flask를 설치해야 합니다:

pip install flask

<div class="content-ad"></div>

가상 환경을 먼저 만드시는 것이 좋습니다.

Flask 앱의 Python 부분은 앱이 응답할 하나 이상의 라우트를 정의합니다. 일반적으로 그 라우트 중 하나는 프로젝트의 루트인 '/'입니다.

아래는 템플릿을 사용하는 최소한의 Python 앱 예시입니다. 템플릿은 index.html이라는 이름이어야 하며 templates 폴더에 있어야 하며 render_template() 라이브러리 함수를 사용하여 Flask에서 웹페이지로 렌더링됩니다. 웹페이지의 제목에 해당하는 값을 생성하고 이를 함수에 전달하는 것에 유의하세요.

from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def index():
    title = "이것이 제목입니다"
    return render_template('index.html', title=title)

<div class="content-ad"></div>

아래는 `title` 값이 인corporated되어야 하는 index.html 템플릿입니다. `h1` 태그 안에 `title` 식별자가 이중 중괄호로 둘러싸여 있음을 볼 수 있습니다.

<!DOCTYPE html>
<html>
<body>
   <h1>{title}</h1>
</body>
</html>

Flask는 HTML 템플릿의 플레이스홀더를 render_template()에 전달된 값으로 대체하는 데 Jinja 템플릿 엔진을 사용합니다.

터미널에서 flask run을 입력하여 애플리케이션을 실행하면 아래와 유사한 응답을 받게 됩니다. (만약 애플리케이션을 app.py로 호출했다면, flask --app app_name run을 입력해야 합니다. 여기서 app_name에는 .py 확장자를 제외한 앱의 이름을 입력해야 합니다.)

<div class="content-ad"></div>

flask run
 * Debug mode: off
경고: 이는 개발 서버입니다. 제품 배포에는 사용하지 마십시오. 대신 제품 WSGI 서버를 사용하십시오.
 * http://127.0.0.1:5000에서 실행 중
CTRL+C를 눌러 종료

브라우저에서 http://127.0.0.1:5000 또는 localhost:5000을 입력하면, Python 코드에서 정의된 텍스트를 표시하는 간단한 웹 페이지가 표시됩니다.

Flask에 대해 더 알아보려면, Quickstart 튜토리얼을 살펴보는 것에서 시작할 수 있지만, 여기에서 시작하는 데 필요한 모든 정보를 다룰 것을 희망합니다.

# 정적 데이터 시각화 애플리케이션
```

<div class="content-ad"></div>

저희 첫 번째 애플리케이션은 지금까지 본 내용을 기반으로 하여 Plotly 차트와 일부 보조 텍스트가 포함된 웹사이트를 생성합니다. 나중에는 상호 작용 기능을 추가할 예정입니다.

파이썬 쪽에 대해 알아보겠습니다. 목록은 아래에 있지만 일단 #### Simple template ####로 시작하는 섹션에 집중해봅시다. 여기서 /simple이라는 경로를 정의했음을 확인할 수 있습니다. 이는 브라우저를 localhost:5000/simple로 가리킴으로써 앱을 호출하게 됩니다. 그리고 데코레이터 아래에 있는 함수 simpleindex()가 실행됩니다.

이 함수에서 웹페이지에 표시할 일부 텍스트와 그래프를 설정합니다. 먼저 일부 변수를 설정하고, 그 변수들을 사용하여 HTML 템플릿이 사용할 매개변수 사전을 작성합니다. 변수들의 이름을 통해 어떻게 사용될지 명확히 알 수 있습니다.

그래프 매개변수는 get_graph() 함수를 사용하여 설정됩니다. 먼저 전역 온도 이상치 데이터를 로드하고, 1881년부터 2022년까지의 데이터가 기후 변화가 시간에 따라 온도에 미치는 영향을 추적합니다 (이에 대한 자세한 내용은 2023년이 역대 최고의 여름이었음을 나타내는 새로운 데이터를 참조하십시오). 데이터는 아래 표에 표시됩니다 (그래프에서 더 잘 나타납니다!).

<div class="content-ad"></div>

정적 앱에는 6월, 7월 및 8월의 온도를 나타내는 단일 열 JJA를 사용할 것입니다. 대화형 앱은 나머지 몇 가지도 사용할 것이므로 현재 앱의 기간 매개변수에 대한 기본값을 설정하여 대화형 앱에서 나중에 변경할 수 있습니다.

데이터는 Plotly 막대 차트를 생성하는 데 사용되며 생성된 도표는 JSON으로 변환됩니다. 그래서 이 JSON 데이터가 반환되어 사전의 매개변수에서 그래프 항목을 설정하는 데 사용됩니다.

이전 함수로 돌아가서 설정한 매개변수를 사용하여 render_template를 호출해야 합니다. 타이핑을 줄이기 위해 template라는 도우미 함수를 만들었습니다. 이 함수는 템플릿 매개변수를 추출하고 모든 데이터를 웹페이지로 전달합니다.

```python
from flask import Flask, request, jsonify, render_template
import json
import pandas as pd
import plotly.express as px

app = Flask(__name__)

def get_graph(period='JJA'):
    df = pd.read_csv('GlobalTemps1880-2022.csv')
    fig = px.bar(df, x='Year', y=period, 
                 color=period, title=period, 
                 color_continuous_scale='reds', 
                 template='plotly_white', width=1000, height=500)

    graphJSON = fig.to_json()
    return json.dumps(graphJSON)

def template(params):
    return render_template(params['template'], params=params)

#### App ####

@app.route('/')
def index():
    return render_template('index.html')

#### Simple template ####

@app.route('/simple')
def simpleindex():
    header = "Global Temperature"
    subheader = "Global Temperature changes over the last few centuries"
    description = """The graph shows the increase in temperature year on year.
    The data spans the years 1881 to 2022 and includes temperature anomalies 
    for the months June through August.
    """
    params = {
        'template': 'simpleindex.html',
        'title': header,
        'subtitle': subheader,
        'content': description,
        'graph': get_graph()
    }
    return template(params)

#### Main ####

if __name__ == '__main__':
    app.run(debug=True)
```

<div class="content-ad"></div>

이젠 HTML 템플릿에 대해 이야기해볼게요. 아래 목록을 확인하고 좋은 소식은 `body`...`/body` 태그 내의 코드를 제외한 모든 것을 무시할 수 있다는 겁니다. 나머지는 Bootstrap과 Plotly를 사용하는 웹페이지에 필요한 보일러플레이트 코드이며, 비슷한 웹페이지에 붙여넣을 수 있습니다. 마지막 `script` 태그도 Bootstrap Javascript 코드를 포함하고 있어서 안심하고 무시할 수 있어요.

```js
    <header>
        <h1>{ params.title }</h1>
        <p>{ params.subtitle }</p>
    </header>

    <div">
        <div id='chart'></div>
        <div>{params.content}</div>
    </div>
    <script type='text/javascript'>
      var figure = JSON.parse({params.graph | safe})
      Plotly.newPlot('chart', figure, {});
    </script>
```

<div class="content-ad"></div>

이전에도 Jinja 매개변수의 사용법을 보았었는데, 이번에는 몇 가지 매개변수를 params라는 딕셔너리로 묶었다는 점이 다릅니다. 따라서 이번에는 그들을 참조할 때 이름 앞에 딕셔너리의 이름을 붙여주어야 합니다. 따라서 `h1`'params.title'`/h1`은 간단히 제목 매개변수를 헤딩 태그 쌍에 넣는 것입니다. 텍스트 매개변수용의 나머지 세 태그도 비슷합니다.

그래프를 그리기 위해서는 그것을 넣을 요소가 필요하며 그 요소에는 id 속성이 있어야 합니다(`div id=`chart/div`). 이 요소는 제목 아래와 설명 위에 위치합니다.

이를 따르는 아래의 스크립트 요소는 다시 차트를 그리기 위해 Plotly Javascript를 호출하는 보일러플레이트 코드입니다. 여기서 주목해야 할 점은 그래프 매개변수를 포함할 때 safe 키워드를 사용한다는 것입니다. 이는 Jinja에게 그래프에 있는 특수 문자를 해석하지 말고, 그대로 사실 그대로 취급할 것을 지시합니다. 따라서 코드는 다음과 같습니다:

```js
var figure = JSON.parse({params.graph | safe})
```

<div class="content-ad"></div>

이제, 템플릿은 프로젝트 디렉토리의 templates 폴더에 있어야 한다는 것을 기억해주세요. 그리고 이 코드가 작동하려면 데이터 파일이 프로젝트 디렉토리 자체에 있어야 합니다. (물론 이동할 수 있지만 Python 프로그램에서 열 때 경로를 변경해야 합니다).

앱을 실행하고 브라우저를 localhost:5000/simple로 이동하여 웹페이지를 보세요. 아마도 아래처럼 웹페이지가 나타날 것입니다.

![웹 앱의 정적 버전](/assets/img/2024-06-23-FlapjaxDataVisualizationontheWebwithPlotlyandFlask_2.png)

그리고 이것이 웹 앱의 정적 버전입니다.

<div class="content-ad"></div>

# 대화형 데이터 시각화 애플리케이션

하지만 여름에만 제한되어 있는 것이 아쉽지 않나요? 우리가 JJA 이외의 기간을 선택할 수 있다면 얼마나 좋을까요? 데이터에는 전체 연간, J-D 및 세 달 기간 (DJF, MAM, JJA 및 SON)을 위한 열도 포함되어 있습니다. (알파벳은 영어로 된 월 이름을 나타냅니다: 12월, 1월, 2월; 3월, 4월, 5월; 그 이후로 계속됩니다.)

이를 위해 사용자가 적절한 기간을 선택할 수 있는 사용자 컨트롤을 통합해야 합니다. 저는 다양한 기간을 표시해 줄 드롭다운 메뉴를 선택했습니다. 이전 웹페이지와 꽤 유사하게 보일 것입니다(아래 이미지 참조).

![Image](/assets/img/2024-06-23-FlapjaxDataVisualizationontheWebwithPlotlyandFlask_3.png)

<div class="content-ad"></div>

이 코드는 처음에는 꽤 유사합니다. 주요 차이점은 새로운 그래프를 선택할 때 발생합니다.

새 값을 선택하면 Javascript 함수가 호출되어 해당 값을 서버의 콜백 함수로 보내고 응답을 기다립니다. 이 콜백 함수는 새로운 차트를 반환하고, 호출하는 Javascript에 의해 표시됩니다.

먼저 익숙한 내용을 다뤄 봅시다. 아래에 새로운 엔드포인트 /ddsimple을 구현하는 함수가 있습니다.

```js
@app.route('/ddsimple')
def ddsimpleindex():
    # Root 엔드포인트는 페이지를 만듭니다.
    header = "지구 온도"
    subheader = "지난 몇 세기 동안의 지구 온도 변화"
    description = """그래프는 연도별 온도 증가를 보여줍니다.
    데이터는 1881년부터 2022년까지의 기간을 포함하며, 각 연도의 온도 이상치를 표시합니다.
    """
    menu_label = "기간을 선택하세요"

    params = {    
        'template': 'ddsimpleindex.html',
        'title': header,
        'subtitle': subheader,
        'content' : description,
        'menu_label': menu_label,
        'options' : [{'code':'J-D', 'desc':'전체 연도'},
                     {'code':'DJF','desc':'겨울 (북반구)'},
                     {'code':'MAM','desc':'봄 (북반구)'},
                     {'code':'JJA','desc':'여름 (북반구)'},
                     {'code':'SON','desc':'가을 (북반구)'}],
        'graph'   : get_graph()
    }
    return template(params)
```

<div class="content-ad"></div>

위의 코드를 Markdown 형식으로 변경하려면 아래와 같이 변경하실 수 있습니다.

```js
<form id="userForm" name="form1" onChange="getFormValues('form1')">
    <div class="mb-3">
        <label for="dropdown" class="form-label lead">{{params.menu_label}}</label>
        <select class="form-select" id="dropdown" name="dropdown">
            {% for opt in params.options %}
                <option value="{{opt.code}}">{{opt.desc}}</option>
            {% endfor %}
        </select>
    </div>
</form>
<div>
    <!-- Main Content Area -->
    <p class="lead">{{params.content}}</p>
</div>
<div id="graph"></div>
```

이렇게하면 드롭다운 메뉴가 포함된 양식을 만들 수 있습니다. 양식에는 이전에 본 두 개의 중괄호로 포함된 메뉴에 대한 레이블도 포함되어 있습니다.

<div class="content-ad"></div>

이전 예제와의 주요 차이점은 메뉴가 구성되는 방식입니다. `select` 요소 내부에는 메뉴에서 제공된 옵션을 나타내는 `option` 태그 목록을 넣어야 합니다. 옵션 태그에는 값과 설명이 있습니다. 이 값들과 설명들은 우리가 params.options 딕셔너리에 정의한 것입니다. 우리는 이 값을 포함하기 위해 ' for opt in param.options '와 같은 Jinja 반복문을 실행하여 딕셔너리를 반복하며 각 요소를 opt라는 지역 변수에 넣습니다. 그런 다음 opt.code와 opt.desc 값을 사용하여 이 값을 옵션 태그에 삽입합니다.

Flask 튜토리얼: Pythonbasics.org 웹사이트의 Templates에서 Jinja 템플릿의 간단한 예제와 설명을 찾을 수 있습니다.

여기에는 우리 목적에 중요한 form 태그의 다른 부분이 있습니다. form 태그 내부에는 onChange라는 속성이 있는데, 이 속성은 어떤 동작의 값을 취합니다. 이 경우에는 폼의 값이 변경될 때 호출되는 자바스크립트 함수입니다. 이 경우에는 메뉴에서 옵션 중 하나를 선택했을 때입니다.

그리고 재미 있는 부분이 여기에서 시작됩니다.

<div class="content-ad"></div>

## 콜백

웹 페이지를 새 차트로 업데이트하기 위해 콜백 메커니즘을 사용하며 아래 차트는 브라우저와 서버 간의 트랜잭션을 보여줍니다. 새 차트를 요청한 응답은 페이지를 다시로드하는 것이 아니라 업데이트하는 것임을 유의하세요. 이는 빠르며 잠깐의 빈 화면을 보여주지 않아 사용자 경험이 훨씬 더 좋아집니다.

![차트 이미지](/assets/img/2024-06-23-FlapjaxDataVisualizationontheWebwithPlotlyandFlask_4.png)

콜백은 웹 페이지의 양식 변경에 의해 호출됩니다, 이전에 언급한대로. 이것을 위한 메커니즘은 양식의 onChange 속성에 식별된 자바스크립트 함수입니다.

<div class="content-ad"></div>

자바스크립트 함수가 어떻게 작동하는지 자세히 설명하려고 합니다. 여기서 기본적으로, 이 함수는 폼에서 값을 가져와 Flask 앱의 콜백 엔드포인트로 보냅니다.

자바스크립트를 작성하는 것이 걱정되시는 분들은 걱정하지 마세요. 이것이 어떻게 작동하는지 알 필요는 없습니다. 그냥 복사해서 사용하면 여러분이 웹 페이지에 포함하고 싶은 어떤 폼이든 작동합니다. 

더 자세한 설명을 읽고 싶으신 모험가들을 위해 아래에 설명을 제공하겠지만, 그렇지 않은 분들은 다음 섹션으로 건너뛰어도 괜찮습니다.

실제로 두 개의 함수가 있습니다. 폼에서 값을 가져오는 함수는 아래와 같습니다.

```js
        function getFormValues(f) {
            const form = document.forms.namedItem(f);
            const formData = new FormData(form);
            const value = Object.fromEntries(formData.entries());
            postJSON(value);
        }
```

<div class="content-ad"></div>

모든 코드는 내장된 JavaScript 함수를 사용합니다: 첫 번째 줄은 문서(즉, 웹 페이지)에서 폼을 가져오고, 두 번째 줄은 폼 데이터를 포함하는 데이터 구조체를 검색하며, 세 번째 줄은 해당 구조체에서 모든 값을 추출합니다.

마지막으로, 이러한 값들은 다른 함수 'postJson'에 전달됩니다.

```js
        async function postJSON(data) {
            try {
                const response = await fetch("/callback", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json",
                    },
                    body: JSON.stringify(data),
                });

                const result = await response.json();
                console.log("Success:");//, result);

                drawGraph(result);
            }
            catch (error) {
                console.error("Error:", error);
            }
        }
```

이 함수는 비동기 함수이므로 호출된 후 프로그램 실행이 즉시 호출한 코드로 돌아가고, 비동기 함수는 별도의 실행 스레드에서 계속 실행됩니다. 즉, 웹 페이지의 실행과 병렬로 수행해야 할 작업을 계속합니다.

<div class="content-ad"></div>

postJSON은 Python 콜백 코드로 전송해야 하는 데이터를 받아서 비동기 fetch 함수를 사용하여 전송합니다. fetch는 데이터가 전달되어야 하는 엔드포인트와 데이터 자체를 매개변수로 받습니다. 데이터를 전송하기 위해 HTTP POST 메커니즘을 사용합니다. postJSON은 fetch가 완료될 때까지 기다린 후, 즉 서버로부터 일부 데이터가 반환될 때까지 기다립니다. 그런 데이터는 그래프를 업데이트하는 drawGraph 함수로 전달됩니다.

코드는 try... catch... 블록에 포함되어 있음을 유의해주세요. 이는 Python 프로그램에서 발견할 수 있는 것과 거의 동일합니다. 즉, try 블록의 코드가 실패하면 — 응답이 없거나 다른 통신 오류가 발생하면 — 해당 실패는 콘솔에 로깅됩니다.

## Python 콜백

이 모든 것이 작동하려면 Flask 코드에 데이터를 받고 처리한 후(예: 새로운 그래프 만들기) 결과를 다시 보내는 콜백 함수가 필요합니다. 여기에 있습니다:

<div class="content-ad"></div>

```python
# 콜백의 엔드포인트를 정의하는 것이 첫 번째 작업입니다. 엔드포인트가 POST 방식으로 데이터를 보내는 것을 명시해야 합니다.

@app.route('/callback', methods=['POST'])
def callback():
    # 콜백은 페이지를 업데이트합니다.
    if request.is_json:
        data = request.get_json() 
        return get_graph(period=data['dropdown'])
    else:
        return jsonify({"error": "잘못된 JSON 데이터입니다"}), 400
```

콜백의 엔드포인트를 정의하는 것이 첫 번째 작업입니다. 엔드포인트가 POST 방식으로 데이터를 보내는 것을 명시해야 합니다.

또한 데이터가 JSON 형식으로 제공되기를 기대하는데, 그렇지 않은 경우 오류를 반환합니다.

데이터가 JSON이라면 드롭다운 메뉴에서 값을 추출하여 get_graph 함수에 전달하고, 이 함수는 그래프를 그리고 Plotly가 예상하는 JSON 형식으로 반환합니다. 이 그래프 데이터는 웹페이지의 JavaScript 함수에 의해 받아들여지고 페이지가 업데이트됩니다.


<div class="content-ad"></div>

위 코드를 사용하면 상단에 있는 대화형 웹 페이지를 제공합니다.

## Flapjax — 이름의 의미

정말이지, 이것은 매우 인위적인 이름입니다: Flask, Python, Javascript 및 ax를 나타내며 이 기법을 가능케 하는 비동기 통신을 의미합니다.

미리 작성된 템플릿과 상당량의 보일러플레이트 코드를 사용하여 Python 코드의 로직에 대부분 집중하면서 유용한 대화형 웹 페이지를 만들 수 있다는 점을 보실 수 있기를 바랍니다.

<div class="content-ad"></div>

이 앱에는 사용자가 새 옵션을 선택할 때 업데이트되는 단일 그래프만 포함되어 있지만 HTML 폼에서 수집할 수 있는 값의 수는 무한입니다. 이 값들은 Flask 앱에 의해 처리된 후 새로운 정보로 웹페이지가 업데이트됩니다. (아마 나중에 이에 대해 자세히 다룰 수도 있을 것입니다).

여기에 설명된 모든 코드와 데이터는 제 GitHub 리포지토리에서 다운로드할 수 있습니다. (jinja-article 폴더를 참조해주세요).

업데이트: GitHub 리포지토리의 reuse 폴더에 새 데이터 세트로 새 앱을 생성하는 새 앱을 작성했습니다. HTML 및 Javascript는 동일하며 Python 코드와 데이터만 변경되었습니다:
Flapjax 템플릿 및 코드 재사용

이 정보가 유용하게 느껴지길 바랍니다. 제 작업을 더 알아보고 싶으시면 웹사이트를 방문하시거나 무료 뉴스레터를 구독함으로써 발행 시 알림을 받을 수 있습니다. (여기를 참조해주세요)

<div class="content-ad"></div>

만약 플라스크가 원하는 것이 아니라면, 내가 미디엄 기사를 기반으로 작성한 eBook Streamlit from Scratch을 읽어보세요.

## 참고 자료

이 기사와 앱에서 사용된 데이터는 아래 1번과 2번에서 설명된 것을 기반으로 합니다.

- GISTEMP 팀, 2023: GISS 표면 온도 분석 (GISTEMP), 버전 4. NASA Goddard 우주 연구소. 데이터 세트는 2023년 9월 19일 data.giss.nasa.gov/gistemp/에서 액세스되었습니다. NASA의 데이터 세트에 대한 구체적인 라이선스가 없음에 유의하십시오. 이러한 데이터는 비상업적 목적으로 NASA에 의해 자유롭게 제공되지만 (위와 같이) 언급이 되어야 합니다.
- Lenssen, N., G. Schmidt, J. Hansen, M. Menne, A. Persin, R. Ruedy, and D. Zyss, 2019: GISTEMP 불확실성 모델의 개선. 대기.지구물리학.연구.저널, 124권, 12호, 6307–6326, doi:10.1029/2018JD029522.

<div class="content-ad"></div>

저자가 별도로 표기하지 않은 경우, 모든 이미지, 다이어그램, 스크린샷 및 코드는 저자가 제작했습니다.