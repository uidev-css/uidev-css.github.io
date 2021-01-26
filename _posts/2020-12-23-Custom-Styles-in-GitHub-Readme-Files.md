---
layout: post
title: "GitHub Readme 파일의 사용자 지정 스타일
 "
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/12/github-custom-styles-svg.jpg
tags: GITHUB
---


GitHub Readme 파일 (일반적으로`. / readme.md`)이 Markdown이고 Markdown이 HTML을 지원하더라도`<style>`또는`<script>`태그를 init에 넣을 수 없습니다.
 (글쎄요, 그냥 벗겨 질 수 있습니다.) 그래서 거기에 커스텀 스타일을 적용 할 수 없습니다.
 아니면 할 수 있습니까?
 

- SVG를`<img src = "./ file.svg"alt = ""/>`(어디서나)로 사용할 수 있습니다.
 
- 그런 식으로 사용하면 그 안에있는 애니메이션 같은 것도 재생됩니다 (와우).
 
- SVG에는 텍스트 콘텐츠의 경우`<text>`와 같은 항목이 있지만 일반 ol `HTML 콘텐츠의 경우`<foreignObject>`도 있습니다.
 
- SVG는`<style>`태그를 지원합니다.
 
- `readme.md` 파일은 SVG 소스에서`<img>`를 지원합니다.
 

Sindre Sorhus는이 모든 것을 하나의 예로 결합했습니다.
 

동일한 SVG 소스가 여기에서 작동합니다.
 

![image](https://css-tricks.com/wp-content/uploads/2020/12/header.svg)