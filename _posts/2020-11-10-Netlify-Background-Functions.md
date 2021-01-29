---
layout: post
title: "Netlify 백그라운드 기능
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/11/background-functions.png
tags: CLOUD FUNCTIONS,NETLIFY,NETLIFY FUNCTIONS,SERVERLESS
---


최대한 빨리 :
 

- AWS Lambda는 훌륭합니다. 실제로 서버를 실행하지 않고도 서버 측 코드를 실행할 수 있습니다.
 이것이“서버리스”가 주로 의미하는 바입니다.
 
- Netlify 함수는 AWS Lambda에서 실행되며 더 쉽게 사용할 수 있습니다.
 예를 들어, 메인 브랜치로 푸시 할 때 배포하는 폴더에 스크립트를 몇 개 넣습니다.
 또한 로그를 얻습니다.
 
- Netlify 함수는 Lambda가 15 분 동안 실행될 수 있지만 실행 시간이 10 초로 제한되었습니다.
 
- 이제 Netlify에서도 `my-function-background.js`와 같은 파일 이름에 `-background`를 추가하여 15 분 함수를 실행할 수 있습니다.
 (Go에서도 쓸 수 있습니다.)
 
- 즉, 헤드리스 브라우저를 가동하고 일부 데이터를 스크래핑하고, 이미지를 처리하여 PDF로 빌드하고 이메일로 보내고, 일괄 API 요청을 사용하여 시스템간에 데이터를 동기화하는 등 오랜 시간이 걸리는 작업을 수행 할 수 있습니다.
 10 초 미만입니다.
 