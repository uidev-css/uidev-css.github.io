#!/usr/bin/env sh

ls

# 정적 sitemap 생성
echo "정적 sitemap 생성중.."
node scripts/sitemap.js
echo "정적 sitemap 생성 완료!"

# abort on errors
set -e

# build
yarn build

# navigate into the build output directory
cd out

# gh-pages clone
git clone -b gh-pages https://github.com/uidev-css/uidev-css.github.io/
cp -rf uidev-css.github.io/.git ./.git
git config user.name "uidev-css"
git config user.email "13akstjq.blog2@gmail.com"
rm -rf uidev-css.github.io

touch .nojekyll

# if you are deploying to a custom domain
# echo 'www.example.com' > CNAME

git add .
git commit -m "add post"

# if you are deploying to https://<USERNAME>.github.io
# git push -f git@github.com:ui-log/ui-log.github.io.git master

# if you are deploying to https://<USERNAME>.github.io/<REPO>
git push origin gh-pages

cd -
