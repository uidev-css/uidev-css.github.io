---
title: "Flask, MongoDB, 그리고 React로 실시간 GitHub Webhook 리스너 만드는 방법"
description: ""
coverImage: "/assets/img/2024-06-30-BuildingaReal-TimeGitHubWebhookListenerwithFlaskMongoDBandReact_0.png"
date: 2024-06-30 23:02
ogImage: 
  url: /assets/img/2024-06-30-BuildingaReal-TimeGitHubWebhookListenerwithFlaskMongoDBandReact_0.png
tag: Tech
originalTitle: "Building a Real-Time GitHub Webhook Listener with Flask, MongoDB, and React"
link: "https://medium.com/@achu1997singh/building-a-real-time-github-webhook-listener-with-flask-mongodb-and-react-0ce5bac43ac0"
---


본 기사에서는 "Push", "Pull Request", "Merge"와 같은 GitHub 웹훅을 수신하는 프로젝트를 만드는 방법을 안내하겠습니다. 이러한 이벤트를 Flask 애플리케이션에서 캡처하고 MongoDB에 저장하며, React 프론트엔드를 사용하여 실시간으로 표시할 것입니다. 마지막으로 Flask 앱을 Vercel에 배포해 보겠습니다.

# 배울 내용

- GitHub 웹훅 설정하는 방법
- 웹훅을 처리하기 위한 Flask 애플리케이션 만드는 방법
- 웹훅 데이터를 MongoDB에 저장하는 방법
- 실시간 업데이트를 표시하는 React 애플리케이션 만드는 방법
- Flask 애플리케이션을 Vercel에 배포하는 방법

# 준비물

<div class="content-ad"></div>

- Python, Flask 및 React에 대한 기본 지식
- GitHub 계정
- 로컬에 MongoDB 설치 또는 클라우드 MongoDB 서비스
- Node.js 및 npm 설치
- Vercel 계정

## 단계 1: GitHub Webhook 설정

- GitHub 저장소 설정

GitHub에서 새 저장소를 만듭니다.

GitHub에서 action-repo라는 새 저장소를 만듭니다. 이 저장소는 "Push", "Pull Request", "Merge"와 같은 이벤트에 기반하여 웹훅을 트리거합니다.

<div class="content-ad"></div>

2. 웹훅 추가하기

- GitHub의 작업 리포지토리로 이동합니다.
- 설정에서 웹훅(Webhooks)으로 이동합니다.
- 웹훅 추가를 클릭합니다.
- 페이로드 URL을 Flask 앱의 엔드포인트로 설정합니다 (나중에 이를 설정할 예정입니다).
- 컨텐츠 유형을 application/json으로 설정합니다.
- 개별 이벤트를 선택하도록 "푸쉬(Push)", "풀 리퀘스트(Pull Request)", "병합(Merge)" 이벤트를 선택합니다.
- 웹훅 추가를 클릭합니다.

# 단계 2: Flask 애플리케이션 생성

- 프로젝트 초기화

<div class="content-ad"></div>

플라스크 프로젝트를 위한 webhook-repo라는 디렉토리를 만들어보세요.

```js
mkdir webhook-repo
cd webhook-repo
python3 -m venv venv
source venv/bin/activate
pip install Flask pymongo
```

2. Flask 앱 만들기

webhook-repo 디렉토리에 다음 코드를 사용하여 app.py를 만들어보세요.

<div class="content-ad"></div>

```python
from flask import Flask, request, jsonify
from pymongo import MongoClient
from datetime import datetime

app = Flask(__name__)

# MongoDB 연결
client = MongoClient('mongodb://localhost:27017/')
db = client['github_webhooks']
collection = db['events']

@app.route('/webhook', methods=['POST'])
def webhook():
    data = request.json
    event_type = request.headers.get('X-GitHub-Event')
    
    if event_type == 'push':
        author = data['pusher']['name']
        to_branch = data['ref'].split('/')[-1]
        timestamp = datetime.strptime(data['head_commit']['timestamp'], "%Y-%m-%dT%H:%M:%SZ")
        event_data = {
            "type": "push",
            "author": author,
            "to_branch": to_branch,
            "timestamp": timestamp
        }
    elif event_type == 'pull_request':
        author = data['pull_request']['user']['login']
        from_branch = data['pull_request']['head']['ref']
        to_branch = data['pull_request']['base']['ref']
        timestamp = datetime.strptime(data['pull_request']['created_at'], "%Y-%m-%dT%H:%M:%SZ")
        event_data = {
            "type": "pull_request",
            "author": author,
            "from_branch": from_branch,
            "to_branch": to_branch,
            "timestamp": timestamp
        }
    elif event_type == 'pull_request' and data['pull_request']['merged']:
        author = data['pull_request']['user']['login']
        from_branch = data['pull_request']['head']['ref']
        to_branch = data['pull_request']['base']['ref']
        timestamp = datetime.strptime(data['pull_request']['merged_at'], "%Y-%m-%dT%H:%M:%SZ")
        event_data = {
            "type": "merge",
            "author": author,
            "from_branch": from_branch,
            "to_branch": to_branch,
            "timestamp": timestamp
        }
    else:
        return jsonify({'message': '지원되지 않는 이벤트입니다'}), 400

    collection.insert_one(event_data)
    return jsonify({'message': '이벤트가 수신되었습니다'}), 200

@app.route('/events', methods=['GET'])
def get_events():
    events = list(collection.find().sort("timestamp", -1).limit(10))
    for event in events:
        event['_id'] = str(event['_id'])
    return jsonify(events), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
```

3. requirements.txt 파일 생성

필요한 의존성이 명시된 requirements.txt 파일을 만들어주세요:

```python
Flask
pymongo
```

<div class="content-ad"></div>

# 단계 3: Vercel에 Flask 앱 배포하기

- vercel.json 파일 만들기

vercel.json 설정 파일을 만듭니다:

```js
{
  "version": 2,
  "builds": [
    {
      "src": "app.py",
      "use": "@vercel/python"
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "app.py"
    }
  ]
}
```

<div class="content-ad"></div>

2. Vercel에 배포하기

- Vercel CLI 설치하기: npm install -g vercel
- Vercel에 로그인하기: vercel login
- 프로젝트를 배포하기: vercel

# 단계 4: React 프론트엔드 생성

- React 앱 설정하기

<div class="content-ad"></div>

React 애플리케이션을 새로 만들어 보세요:

```js
npx create-react-app github-webhooks-ui
cd github-webhooks-ui
npm install axios
```

2. App.js 파일을 만들어 보세요

App.js 파일 내용을 다음과 같이 변경해 주세요:

<div class="content-ad"></div>

```js
import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './App.css';

const App = () => {
  const [events, setEvents] = useState([]);

  useEffect(() => {
    const fetchEvents = async () => {
      try {
        const response = await axios.get('https://your-vercel-app.vercel.app/events');
        setEvents(response.data);
      } catch (error) {
        console.error('Error fetching events', error);
      }
    };

    fetchEvents();
    const interval = setInterval(fetchEvents, 15000);
    return () => clearInterval(interval);
  }, []);

  return (
    <div className="App">
      <h1>GitHub Repository Events</h1>
      <ul>
        {events.map(event => (
          <li key={event._id}>
            {event.type === 'push' && `${event.author} pushed to ${event.to_branch} on ${new Date(event.timestamp).toUTCString()}`}
            {event.type === 'pull_request' && `${event.author} submitted a pull request from ${event.from_branch} to ${event.to_branch} on ${new Date(event.timestamp).toUTCString()}`}
            {event.type === 'merge' && `${event.author} merged branch ${event.from_branch} to ${event.to_branch} on ${new Date(event.timestamp).toUTCString()}`}
          </li>
        ))}
      </ul>
    </div>
  );
};

export default App;
```

3. React 앱 실행

React 애플리케이션을 시작하려면:

```js
npm start
```

<div class="content-ad"></div>

# 테스트 및 확인

- GitHub 웹훅 업데이트:

GitHub 웹훅 설정에서 Payload URL을 배포된 Vercel의 Flask 앱을 가리키도록 업데이트하십시오:

```js
https://your-vercel-app.vercel.app/webhook
```

<div class="content-ad"></div>

2. 트리거 이벤트:

- Push Action: 변경 사항을 만들어서 action-repo에 푸시합니다.
- Pull Request Action: 새 브랜치를 만들어서 변경 사항을 적용하고 푸시한 다음 풀 리퀘스트를 오픈합니다.
- Merge Action: 풀 리퀘스트를 병합합니다.

3. 확인: React 앱을 확인해서 이벤트가 올바르게 표시되는지 확인해보세요.

# 결론

<div class="content-ad"></div>

이 프로젝트에서는 다음을 배웠습니다:

- GitHub 웹훅 설정 및 처리 방법
- 웹훅 이벤트를 처리하는 Flask 애플리케이션 생성
- MongoDB에 이벤트 저장
- React 프론트엔드를 사용하여 실시간 이벤트 표시
- Vercel에 Flask 애플리케이션 배포

이 프로젝트는 다양한 기술을 통합하여 실시간 업데이트를 효율적으로 처리하는 풀 스택 애플리케이션을 보여줍니다. 궁금한 점이나 개선하고 싶은 부분이 있으면 인증, 추가적인 이벤트 유형 또는 더 다양하고 진보된 UI 요소를 추가하여 이 프로젝트를 확장해보세요.

즐거운 코딩되세요!