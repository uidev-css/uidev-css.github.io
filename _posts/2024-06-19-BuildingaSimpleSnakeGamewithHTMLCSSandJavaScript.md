---
title: "간단한 Snake 게임 만들기 HTML, CSS 및 JavaScript를 활용하여 함께 해봐요"
description: ""
coverImage: "/assets/img/2024-06-19-BuildingaSimpleSnakeGamewithHTMLCSSandJavaScript_0.png"
date: 2024-06-19 14:38
ogImage: 
  url: /assets/img/2024-06-19-BuildingaSimpleSnakeGamewithHTMLCSSandJavaScript_0.png
tag: Tech
originalTitle: "Building a Simple Snake Game with HTML, CSS, and JavaScript"
link: "https://medium.com/@algorhythm2411/building-a-simple-snake-game-with-html-css-and-javascript-2f98eab6e71d"
---



![Game screenshot](/assets/img/2024-06-19-BuildingaSimpleSnakeGamewithHTMLCSSandJavaScript_0.png)

클래식 스네이크 게임을 만드는 것은 JavaScript 기술을 향상시키는 환상적인 방법입니다. 이 튜토리얼에서는 HTML, CSS 및 JavaScript를 사용하여 간단한 스네이크 게임을 만드는 방법을 단계별로 안내해 드리겠습니다.

여기에서 게임을 확인하실 수 있고, 여기에서 GitHub 저장소를 확인하실 수 있습니다.

# HTML 구조


<div class="content-ad"></div>

HTML 구조부터 시작할게요. 주요 구성 요소는 게임을 렌더링하는 캔버스, 현재 및 최고 점수를 표시하는 스코어보드, 그리고 효과음을 출력하는 오디오 요소입니다.

```js
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Snake Game</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="game-container">
        <div class="score-board">
            <span id="score">Score: 0</span>
            <span id="high-score">High Score: 0</span>
        </div>
        <canvas id="gameCanvas"></canvas>
    </div>
    <audio id="eatSound" src="eat.wav"></audio>
    <audio id="bombSound" src="bomb.wav"></audio>
    <audio id="gameOverSound" src="gameover.wav"></audio>
    <script src="script.js"></script>
</body>
</html>
```

# CSS 스타일링

다음으로, 게임을 중앙 정렬하고 캔버스와 스코어보드 스타일을 추가할게요.

<div class="content-ad"></div>

```js
body {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
    background-color: #282c34;
    color: #61dafb;
    font-family: 'Arial', sans-serif;
}
.game-container {
    text-align: center;
}
.score-board {
    margin-bottom: 10px;
    font-size: 24px;
}
canvas {
    border: 1px solid #61dafb;
    background-color: #000;
}
```

# JavaScript Logic

자, 이제 게임을 기능적으로 만들기 위해 JavaScript에 집중해 봅시다. 게임을 초기화하는 것, 게임 루프를 처리하는 것, 뱀을 그리고 움직이는 것, 음식을 다루는 것, 그리고 게임 오버 조건을 확인하는 것 등이 있습니다.

# 초기 설정


<div class="content-ad"></div>

먼저 캔버스, 콘텍스트 및 초기 게임 변수를 설정합니다.

```js
const canvas = document.getElementById('gameCanvas');
const ctx = canvas.getContext('2d');
const scoreElement = document.getElementById('score');
const highScoreElement = document.getElementById('high-score');
const eatSound = document.getElementById('eatSound');
const bombSound = document.getElementById('bombSound');
const gameOverSound = document.getElementById('gameOverSound');
const gridSize = 20;
canvas.width = 400;
canvas.height = 400;
let snake = [{x: gridSize * 2, y: gridSize * 2}];
let direction = {x: 0, y: 0};
let food = {};
let bombFood = null;
let score = 0;
let highScore = localStorage.getItem('highScore') || 0;
let bombTimeout;
highScoreElement.innerText = `High Score: ${highScore}`;
```

# 게임 초기화

init 함수는 초기 음식을 배치하고 키 입력에 대한 이벤트 리스너를 설정합니다.

<div class="content-ad"></div>

```js
function init() {
    placeFood();
    document.addEventListener('keydown', changeDirection);
    gameLoop();
}
```

# 게임 루프

게임 루프 함수는 게임의 핵심입니다. 일정 간격으로 게임 상태를 업데이트합니다.

```js
function gameLoop() {
    if (isGameOver()) {
        return;
    }
    setTimeout(() => {
        clearCanvas();
        drawSnake();
        moveSnake();
        drawFood();
        if (bombFood) drawBombFood();
        checkFoodCollision();
        checkBombFoodCollision();
        gameLoop();
    }, 100);
}
```

<div class="content-ad"></div>

# 캔버스 초기화

clearCanvas 함수는 매번 새로 그려짐에 앞서 캔버스를 지웁니다.

```js
function clearCanvas() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
}
```

# 뱀 그리기

<div class="content-ad"></div>

다음은 캔버스에 뱀을 렌더링하는 drawSnake 함수입니다.

```js
function drawSnake() {
    ctx.fillStyle = 'green';
    snake.forEach((segment, index) => {
        if (index === 0) {
            ctx.fillStyle = 'lightgreen'; // 머리 색상
        } else {
            ctx.fillStyle = 'green';
        }
        ctx.fillRect(segment.x, segment.y, gridSize, gridSize);
    });
}
```

# 뱀 이동

moveSnake 함수는 현재 방향을 기반으로 뱀의 위치를 업데이트합니다.

<div class="content-ad"></div>

```js
function moveSnake() {
    const head = {x: snake[0].x + direction.x, y: snake[0].y + direction.y};
    if (head.x >= canvas.width) {
        head.x = 0;
    } else if (head.x < 0) {
        head.x = canvas.width - gridSize;
    }
    if (head.y >= canvas.height) {
        head.y = 0;
    } else if (head.y < 0) {
        head.y = canvas.height - gridSize;
    }
    snake.unshift(head);
    snake.pop();
}
```

# 방향 변경

changeDirection 함수는 뱀의 방향을 변경하는 키 입력을 처리합니다.

```js
function changeDirection(event) {
    const keyPressed = event.keyCode;
    const LEFT = 37;
    const UP = 38;
    const RIGHT = 39;
    const DOWN = 40;
    const W = 87;
    const A = 65;
    const S = 83;
    const D = 68;
    const goingUp = direction.y === -gridSize;
    const goingDown = direction.y === gridSize;
    const goingRight = direction.x === gridSize;
    const goingLeft = direction.x === -gridSize;
    if ((keyPressed === LEFT || keyPressed === A) && !goingRight) {
        direction = {x: -gridSize, y: 0};
    } else if ((keyPressed === UP || keyPressed === W) && !goingDown) {
        direction = {x: 0, y: -gridSize};
    } else if ((keyPressed === RIGHT || keyPressed === D) && !goingLeft) {
        direction = {x: gridSize, y: 0};
    } else if ((keyPressed === DOWN || keyPressed === S) && !goingUp) {
        direction = {x: 0, y: gridSize};
    }
}
```

<div class="content-ad"></div>

# 음식 배치

placeFood 함수는 캔버스의 무작위 위치에 음식을 배치합니다.

```js
function placeFood() {
    food = {
        x: Math.floor(Math.random() * canvas.width / gridSize) * gridSize,
        y: Math.floor(Math.random() * canvas.height / gridSize) * gridSize
    };
}
```

# 음식 그리기

<div class="content-ad"></div>

```js
drawFood 함수는 캔버스에 음식을 렌더링합니다.

function drawFood() {
    ctx.fillStyle = 'red';
    ctx.fillRect(food.x, food.y, gridSize, gridSize);
}
```

# 음식 충돌 처리

checkFoodCollision 함수는 뱀이 음식을 먹었는지 확인합니다.

<div class="content-ad"></div>

```js
function checkFoodCollision() {
    if (snake[0].x === food.x && snake[0].y === food.y) {
        eatSound.play();
        score++;
        scoreElement.innerText = `Score: ${score}`;
        snake.push({});
        placeFood();
        if (Math.random() < 0.1) {
            placeBombFood();
        }
    }
}
```

# 폭탄 음식 배치

placeBombFood 함수는 뱀이 추가 점수를 얻을 수 있는 폭탄 음식을 배치합니다.

```js
function placeBombFood() {
    bombFood = {
        x: Math.floor(Math.random() * canvas.width / gridSize) * gridSize,
        y: Math.floor(Math.random() * canvas.height / gridSize) * gridSize
    };
    bombSound.play();
    bombTimeout = setTimeout(() => {
        bombFood = null;
    }, 5000);
}
```

<div class="content-ad"></div>

# 폭탄 음식 그리기

drawBombFood 함수는 캔버스에 폭탄 음식을 렌더링합니다

```js
function drawBombFood() {
    if (bombFood) {
        ctx.fillStyle = 'purple';
        ctx.fillRect(bombFood.x, bombFood.y, gridSize, gridSize);
    }
}
```

# 폭탄 음식 충돌 처리

<div class="content-ad"></div>

테이블 태그를 Markdown 형식으로 변경하세요.

```js
function checkBombFoodCollision() {
    if (bombFood && snake[0].x === bombFood.x && snake[0].y === bombFood.y) {
        eatSound.play();
        score += 2;
        scoreElement.innerText = `점수: ${score}`;
        snake.push({}, {});
        bombFood = null;
        clearTimeout(bombTimeout);
    }
}
```

## 게임 종료 확인

isGameOver 함수는 뱀이 자신과 충돌했는지 확인합니다.

<div class="content-ad"></div>

```js
function isGameOver() {
    for (let i = 4; i < snake.length; i++) {
        if (snake[i].x === snake[0].x && snake[i].y === snake[0].y) {
            playGameOverSound()
                .then(() => {
                    if (score > highScore) {
                        highScore = score;
                        localStorage.setItem('highScore', highScore);
                        highScoreElement.innerText = `High Score: ${highScore}`;
                    }
                    alert('게임 오버!');
                })
                .catch((error) => {
                    console.error('게임 오버 사운드 재생 중 오류 발생:', error);
                    if (score > highScore) {
                        highScore = score;
                        localStorage.setItem('highScore', highScore);
                        highScoreElement.innerText = `High Score: ${highScore}`;
                    }
                    alert('게임 오버!');
                });
            return true;
        }
    }
    return false;
}
```

# 게임 오버 사운드 재생

playGameOverSound 함수는 게임 오버 사운드 효과를 재생합니다.

```js
function playGameOverSound() {
    return new Promise((resolve, reject) => {
        gameOverSound.onended = resolve;
        gameOverSound.onerror = reject;
        gameOverSound.play();
    });
}
```

<div class="content-ad"></div>

# 게임 시작

마침내 init 함수를 호출하여 게임을 시작합니다.

```js
init();
```

# 결론

<div class="content-ad"></div>

여기에서 간단한 뱀 게임이 HTML, CSS 및 JavaScript로 구축되었습니다. 레벨, 다양한 종류의 음식 또는 보다 복잡한 뱀 이동과 같은 기능을 추가하여 이 게임을 확장할 수 있습니다.

읽어 주셔서 감사합니다! 이 기사를 즐겁게 보셨다면 미디엄에서 저를 팔로우해 주시면 저의 향후 컨텐츠를 계속 받아보실 수 있습니다. 응원을 보내주세요!

콘텐츠가 마음에 드셨다면 커피 한 잔 사주는 것으로 응원해 주세요!

![BuildingaSimpleSnakeGamewithHTMLCSSandJavaScript_1.png](/assets/img/2024-06-19-BuildingaSimpleSnakeGamewithHTMLCSSandJavaScript_1.png)