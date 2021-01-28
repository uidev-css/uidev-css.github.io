---
layout: post
title: "명령 줄에서 이미지 변환 및 최적화"
author: 'CSS Dev'
thumbnail: https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/12/optimize-images-terminal.png
tags: COMMAND LINE,IMAGE OPTIMIZATION,TERMINAL
---


이미지는 평균 웹 페이지 전체 크기의 최대 50 %를 차지합니다.
 그리고 이미지가 최적화되지 않으면 사용자는 추가 바이트를 다운로드하게됩니다.
 그리고 추가 바이트를 다운로드하는 경우 사이트를로드하는 데 훨씬 더 많은 시간이 소요될뿐만 아니라 사용자가 더 많은 데이터를 사용하고 있으며, 둘 다 다운로드하기 전에 이미지를 최적화하여 적어도 부분적으로 해결할 수 있습니다.
 

전 세계의 연구자들은 PNG 나 JPG와 같은 다른 형식에 비해 크기는 작지만 높은 시각적 품질을 가진 새로운 이미지 형식을 개발하는 데 바쁘고 있습니다.
 이러한 새로운 형식은 아직 개발 중이며 일반적으로 브라우저 지원이 제한되어 있지만 그중 하나 인 WebP가 많은 주목을 받고 있습니다.
 래스터 이미지와 같은 등급은 아니지만 SVG는 본질적으로 가벼운 무게로 인해 최근 몇 년 동안 많은 사람들이 사용하고있는 또 다른 형식입니다.
 

더 작고 최적화 된 이미지를 만들 수있는 방법은 많습니다.
 이 자습서에서는 JPG, PNG, WebP 및 SVG를 포함한 가장 일반적인 형식을 대상으로 다양한 이미지 형식으로 이미지를 만들고 최적화하는 bash 스크립트를 작성합니다.
 아이디어는 사용자가 모든 바이트 팽창없이 시각적으로 가장 멋진 경험을 얻을 수 있도록 이미지를 제공하기 전에 이미지를 최적화하는 것입니다.
 

이 GitHub 저장소에는 우리가 사용하는 모든 이미지가 포함되어 있으며 이미지를 가져 와서 따라 할 수 있습니다.
 

### 설정
 verified_user

시작하기 전에 모든 종속성을 순서대로 살펴 보겠습니다.
 다시 한 번 Bash 스크립트를 작성하고 있으므로 명령 줄에서 시간을 보내겠습니다.
 

다음은 이미지 최적화를 시작하는 데 필요한 모든 종속성에 대한 명령입니다.
 

```terminal
sudo apt-get update
sudo apt-get install imagemagick webp jpegoptim optipng
npm install -g svgexport svgo
```

사용을 시작하기 전에 무엇을 사용하고 있는지 아는 것이 좋습니다.
 

- ImageMagick : 모든 종류의 래스터 이미지에서 작동
 
- webp는 WebP 파일을 최적화합니다.
 
- JPEGoptim은 JPG / JPEG 파일을 최적화합니다.
 
- OptiPNG는 PNG 파일을 최적화합니다
 
- SVGO 및 svgexport는 SVG 자산을 최적화하는 노드 패키지입니다.
 

좋습니다. GitHub 저장소의`original-images` 디렉토리에 이미지가 있습니다.
 커밋`3584f9b`에서 따라갈 수 있습니다.
 

참고 : 계속하기 전에 이미지를 백업하는 것이 좋습니다.
 이러한 이미지를 변경하는 프로그램을 실행하려고합니다. 원본은 그대로 두려고하지만 하나의 잘못된 명령으로 되돌릴 수없는 방식으로 이미지를 변경할 수 있습니다.
 따라서 나중에 자신을 저주하지 않도록 실제 프로젝트에서 사용할 계획이라면 무엇이든 백업하십시오.
 

### 이미지 구성
 

좋습니다. 기술적으로 설정되었습니다.
 그러나 모든 것을 최적화하기 전에 파일을 약간 정리해야합니다.
 MIME 유형에 따라 다른 하위 디렉토리로 분할하여 구성 해 보겠습니다.
 사실, 우리를 위해 새로운 bash를 만들 수 있습니다!
 

다음 코드는`organize-images.sh`라는 스크립트를 생성합니다.
 

```organize-images.sh
#!/bin/bash

input_dir="$1"

if [[ -z "$input_dir" ]]; then
  echo "Please specify an input directory."
  exit 1
fi

for img in $( find $input_dir -type f -iname "*" );
do
  # get the type of the image
  img_type=$(basename `file --mime-type -b $img`)

  # create a directory for the image type
  mkdir -p $img_type

  # move the image into its type directory
  rsync -a $img $img_type
done
```

스크립트를 처음 작성하는 경우 혼란스러워 보일 수 있지만 실제로 수행하는 작업은 매우 간단합니다.
 스크립트에 이미지를 찾는 입력 디렉토리를 제공합니다.
 그런 다음 스크립트는 해당 입력 디렉토리로 이동하여 이미지 파일을 찾고 MIME 유형을 식별합니다.
 마지막으로 각 MIME 유형에 대한 입력 폴더에 하위 디렉터리를 만들고 각 이미지의 복사본을 해당 하위 디렉터리에 놓습니다.
 

실행합시다!
 

```terminal
bash organize-images.sh original-images
```

단.
 이제 디렉토리는 다음과 같습니다.
 이제 이미지가 구성되었으므로 각 이미지의 변형을 만들 수 있습니다.
 한 번에 하나의 이미지 유형을 다룰 것입니다.
 

### PNG로 변환
 

이 자습서에서는 WebP, JPEG 및 SVG의 세 가지 유형의 이미지를 PNG로 변환합니다.
 `webp2png.sh`라는 스크립트를 작성하는 것으로 시작하겠습니다.이 스크립트는 WebP 파일을 PNG 파일로 변환하는 작업을 거의 설명합니다.
 

```webp2png.sh
#!/bin/bash

# directory containing images
input_dir="$1"

if [[ -z "$input_dir" ]]; then
  echo "Please specify an input directory."
  exit 1
fi

# for each webp in the input directory
for img in $( find $input_dir -type f -iname "*.webp" );
do
  dwebp $img -o ${img%.*}.png
done
```

상황은 다음과 같습니다.
 

- `input_dir = "$ 1"`: 명령 줄 입력을 스크립트에 저장합니다.
 
- `if [[-z "$ input_dir"]];
 then` : 입력 디렉토리가 정의되지 않은 경우 후속 조건을 실행합니다.
 
- `for img in $ (find $ input_dir -type f -iname "* .webp");`:`.webp` 확장자를 가진 디렉토리의 각 파일을 반복합니다.
 
- `dwebp $ img -o $ {img %. *}. png` : WebP 이미지를 PNG 변형으로 변환합니다.
 

그리고 우리는 간다 :
 

```terminal
bash webp2png.sh webp
```

이제`webp` 디렉토리에 PNG 이미지가 있습니다.
 다음으로`jpg2png.sh`라는 다른 스크립트를 사용하여 JPG / JPEG 파일을 PNG로 변환 해 보겠습니다.
 

```jpg2png.sh
#!/bin/bash

# directory containing images
input_dir="$1"

if [[ -z "$input_dir" ]]; then
  echo "Please specify an input directory."
  exit 1
fi

# for each jpg or jpeg in the input directory
for img in $( find $input_dir -type f -iname "*.jpg" -o -iname "*.jpeg" );
do
  convert $img ${img%.*}.png
done
```

이것은 우리가 설치 한 ImageMagick 패키지에서 제공하는`convert` 명령을 사용합니다.
 마지막 스크립트와 마찬가지로 JPEG / JPG 이미지가 포함 된 입력 디렉토리를 제공합니다.
 스크립트는 해당 디렉토리를 찾고 일치하는 각 이미지에 대한 PNG 변형을 생성합니다.
 자세히 살펴보면`find`에`-o -iname "* .jpeg"`를 추가했습니다.
 이것은`.jpg` 또는`.jpeg` 확장자를 가진 모든 이미지를 찾는 스크립트 인 논리적 OR을 나타냅니다.
 

실행 방법은 다음과 같습니다.
 

```terminal
bash jpg2png.sh jpeg
```

이제 JPG의 PNG 변형이 있으므로 SVG 파일에 대해서도 똑같은 작업을 수행 할 수 있습니다.
 

```svg2png.sh
#!/bin/bash

# directory containing images
input_dir="$1"

# png image width
width="$2"

if [[ -z "$input_dir" ]]; then
  echo "Please specify an input directory."
  exit 1
elif [[ -z "$width" ]]; then
  echo "Please specify image width."
  exit 1
fi

# for each svg in the input directory
for img in $( find $input_dir -type f -iname "*.svg" );
do
  svgexport $img ${img%.*}.png $width:
done
```

이 스크립트에는 새로운 기능이 있습니다.
 SVG는 확장 가능한 형식이므로 `width`지시문을 지정하여 SVG를 확대 또는 축소 할 수 있습니다.
 앞서 설치 한`svgexport` 패키지를 사용하여 각 SVG 파일을 PNG로 변환합니다.
 

```terminal
bash svg2png.sh svg+xml
```

Commit`76ff80a`는 repo의 결과를 보여줍니다.
 

여기에서 다른 이미지 형식을 기반으로 한 많은 PNG 파일을 만들어 많은 훌륭한 작업을 수행했습니다.
 이미지 형식을 최적화하는 실제 작업에 도달하기 전에 나머지 이미지 형식에 대해서도 동일한 작업을 수행해야합니다.
 

### JPG로 변환
 

PNG 이미지 생성의 발자취에 따라 WebP, JPEG 및 SVG를 JPG로 변환합니다.
 PNG를 SVG로 변환하는`png2jpg.sh`라는 스크립트를 작성하여 시작하겠습니다.
 

```png2jpg.sh
#!/bin/bash

# directory containing images
input_dir="$1"

# jpg image quality
quality="$2"

if [[ -z "$input_dir" ]]; then
  echo "Please specify an input directory."
  exit 1
elif [[ -z "$quality" ]]; then
  echo "Please specify image quality."
  exit 1
fi

# for each png in the input directory
for img in $( find $input_dir -type f -iname "*.png" );
do
  convert $img -quality $quality% ${img%.*}.jpg
done
```

지금 쯤이면 이러한 스크립트에서 패턴을 발견 할 수 있습니다.
 그러나 이것은 PNG 이미지를 JPG 이미지로 변환하기 위해`-quality` 지시문을 설정할 수있는 새로운 기능을 소개합니다.
 나머지는 동일합니다.
 

이를 실행하는 방법은 다음과 같습니다.
 

```terminal
bash png2jpg.sh png 90
```

와.
 이제`png` 디렉토리에 JPG 이미지가 있습니다.
 `webp2jpg.sh` 스크립트로 동일한 작업을 수행해 보겠습니다.
 

```webp2jpg.sh
#!/bin/bash

# directory containing images
input_dir="$1"

# jpg image quality
quality="$2"

if [[ -z "$input_dir" ]]; then
  echo "Please specify an input directory."
  exit 1
elif [[ -z "$quality" ]]; then
  echo "Please specify image quality."
  exit 1
fi

# for each webp in the input directory
for img in $( find $input_dir -type f -iname "*.webp" );
do
  # convert to png first
  dwebp $img -o ${img%.*}.png

  # then convert png to jpg
  convert ${img%.*}.png -quality $quality% ${img%.*}.jpg
done
```

다시 말하지만 이것은 WebP를 PNG로 변환하기 위해 작성한 것과 동일합니다.
 그러나 비틀기가 있습니다.
 WebP 형식을 JPG 형식으로 직접 변환 할 수 없습니다.
 따라서 여기서 약간의 창의력을 발휘하고`dwebp`를 사용하여 WebP를 PNG로 변환 한 다음`convert`를 사용하여 PNG를 JPG로 변환해야합니다.
 그렇기 때문에 `for`루프에는 두 가지 단계가 있습니다.
 

이제 실행 해 보겠습니다.
 

```terminal
bash webp2jpg.sh jpeg 90
```

Voilà!
 WebP 이미지에 대한 JPG 변형을 만들었습니다.
 이제 SVG를 JPG로 처리해 보겠습니다.
 

```svg2jpg.sh
#!/bin/bash

# directory containing images
input_dir="$1"

# jpg image width
width="$2"

# jpg image quality
quality="$3"

if [[ -z "$input_dir" ]]; then
  echo "Please specify an input directory."
  exit 1
elif [[ -z "$width" ]]; then
  echo "Please specify image width."
  exit 1
elif [[ -z "$quality" ]]; then
  echo "Please specify image quality."
  exit 1
fi

# for each svg in the input directory
for img in $( find $input_dir -type f -iname "*.svg" );
do
    svgexport $img ${img%.*}.jpg $width: $quality%
done
```

이전에이 스크립트를 본 적이 있다고 생각할 수도 있습니다.
 당신은 있습니다!
 SVG에서 PNG 이미지를 만들기 위해 동일한 스크립트를 사용했습니다.
 이 스크립트에 유일한 추가는 JPG 이미지의`quality` 지시문을 지정할 수 있다는 것입니다.
 

```terminal
bash svg2jpg.sh svg+xml 512 90
```

우리가 방금 한 모든 것은 repo의 commit`884c6cf`에 포함되어 있습니다.
 

### WebP로 변환
 

WebP는 최신 브라우저 용으로 설계된 이미지 형식입니다.
 이 글을 쓰는 시점에서 Safari의 부분 지원을 포함하여 약 90 %의 글로벌 브라우저 지원을 누리고 있습니다.
 WebP의 가장 큰 장점은 시각적 품질을 그대로 유지하면서 다른 마법사 형식에 비해 파일 크기가 훨씬 작다는 것입니다.
 따라서 사용자에게 제공하기에 좋은 형식입니다.
 

그러나 충분한 이야기.
 PNG 파일에서 WebP 이미지를 생성하는`png2webp.sh`를 작성해 보겠습니다.
 

```png2webp.sh
#!/bin/bash

# directory containing images
input_dir="$1"

# webp image quality
quality="$2"

if [[ -z "$input_dir" ]]; then
  echo "Please specify an input directory."
  exit 1
elif [[ -z "$quality" ]]; then
  echo "Please specify image quality."
  exit 1
fi

# for each png in the input directory
for img in $( find $input_dir -type f -iname "*.png" );
do
  cwebp $img -q $quality -o ${img%.*}.webp
done
```

이것은 WebP 파일에서 PNG 이미지를 만드는 데 사용한 스크립트의 반대입니다.
 `dwebp`를 사용하는 대신`cwebp`를 사용합니다.
 

```terminal
bash png2webp.sh png 90
```

WebP 이미지가 있습니다.
 이제 JPG 이미지를 변환 해 보겠습니다.
 까다로운 점은 JPG 파일을 WebP로 직접 변환 할 수있는 방법이 없다는 것입니다.
 따라서 먼저 JPG를 PNG로 변환 한 다음`jpg2webp.sh` 스크립트에서 중간 PNG를 WebP로 변환합니다.
 

```pg2webp.sh
#!/bin/bash

# directory containing images
input_dir="$1"

# webp image quality
quality="$2"

if [[ -z "$input_dir" ]]; then
  echo "Please specify an input directory."
  exit 1
elif [[ -z "$quality" ]]; then
  echo "Please specify image quality."
  exit 1
fi

# for each webp in the input directory
for img in $( find $input_dir -type f -iname "*.jpg" -o -iname "*.jpeg" );
do
  # convert to png first
  convert $img ${img%.*}.png

  # then convert png to webp
  cwebp ${img%.*}.png -q $quality -o ${img%.*}.webp
done
```

이제 다음과 같이 사용하여 JPG 파일의 WebP 변형을 가져올 수 있습니다.
 

```terminal
bash jpg2webp.sh jpeg 90
```

Commit`6625f26`은 결과를 보여줍니다.
 

### 모든 것을 단일 디렉토리로 결합
 

이제 변환이 완료되었으므로 작업을 최적화하는 데 한 걸음 더 가까워졌습니다.
 하지만 먼저 모든 이미지를 단일 디렉토리로 가져 와서 더 적은 명령으로 쉽게 최적화 할 수 있도록합니다.
 

다음은`combine-images.sh`라는 새 bash 스크립트를 만드는 코드입니다.
 

```combine-images.sh
#!/bin/bash

input_dirs="$1"
output_dir="$2"

if [[ -z "$input_dirs" ]]; then
  echo "Please specify an input directories."
  exit 1
elif [[ -z "$output_dir" ]]; then
  echo "Please specify an output directory."
  exit 1
fi

# create a directory to store the generated images
mkdir -p $output_dir

# split input directories comma separated string into an array
input_dirs=(${input_dirs//,/ })

# for each directory in input directory
for dir in "${input_dirs[@]}"
do
  # copy images from this directory to generated images directory
  rsync -a $dir/* $output_dir/
done
```

첫 번째 인수는 이미지를 대상 결합 디렉토리로 전송할 쉼표로 구분 된 입력 디렉토리 목록입니다.
 두 번째 인수는 결합 된 디렉토리를 정의합니다.
 

```terminal
bash combine-images.sh jpeg,svg+xml,webp,png generated-images
```

최종 출력은 저장소에서 볼 수 있습니다.
 

### SVG 최적화
 

SVG 이미지 최적화부터 시작하겠습니다.
 `optimize-svg.sh`에 다음 코드를 추가합니다.
 

```optimize-svg.sh
#!/bin/bash

# directory containing images
input_dir="$1"

if [[ -z "$input_dir" ]]; then
echo "Please specify an input directory."
exit 1
fi

# for each svg in the input directory
for img in $( find $input_dir -type f -iname "*.svg" );
do
  svgo $img -o ${img%.*}-optimized.svg
done
```

여기서는 SVGO 패키지를 사용하고 있습니다.
 사용할 수있는 많은 옵션이 있지만 간단하게 유지하기 위해 SVG 파일 최적화의 기본 동작을 고수하고 있습니다.
 

```terminal
bash optimize-svg.sh generated-images
```

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_FA3C3321F9CAFCD916B8768871CA8981B9B6DA946376796F2D67EB92118AE5DA_1606729556194_Screenshotfrom2020-11-2914-36-11.png?resize=714%2C239&ssl=1)

결과는 커밋 `75045c3`의 저장소에서 확인할 수 있습니다.
 

### PNG 최적화
 

이 코드를 사용하여 계속해서 PNG 파일을 롤링하고 최적화하여`optimize-png.sh` 명령을 만들어 보겠습니다.
 

```optimize-png.sh
#!/bin/bash

# directory containing images
input_dir="$1"

if [[ -z "$input_dir" ]]; then
  echo "Please specify an input directory."
  exit 1
fi

# for each png in the input directory
for img in $( find $input_dir -type f -iname "*.png" );
do
  optipng $img -out ${img%.*}-optimized.png
done
```

여기에서는 OptiPNG 패키지를 사용하여 PNG 이미지를 최적화합니다.
 스크립트는 입력 디렉토리에서 PNG 이미지를 찾고 각각의 최적화 된 버전을 생성하고 파일 이름에`-optimized`를 추가합니다.
 최적화 수준을 지정하는 데 사용할 수있는 흥미로운 인수 `-o`가 있습니다.
 기본값은 `2`**이고 값의 범위는 0 ~ 7입니다. PNG를 최적화하기 위해 다음을 실행합니다.
 

```terminal
bash optimize-png.sh generated-images
```

![image](https://i0.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_FA3C3321F9CAFCD916B8768871CA8981B9B6DA946376796F2D67EB92118AE5DA_1606729794569_Screenshotfrom2020-11-2914-37-50.png?resize=714%2C455&ssl=1)

보시다시피 OptiPNG는 이미지 최적화를 훌륭하게 수행합니다.
 우리는 이미지 품질과 크기 사이에서 적절한 값을 찾기 위해`-o` 인수를 가지고 놀 수 있습니다.
 커밋`4a97f29`에서 결과를 확인하십시오.
 

### JPG 최적화
 

마지막 부분에 도달했습니다!
 JPG 이미지를 최적화하여 마무리 할 것입니다.
 `optimize-jpg.sh`에 다음 코드를 추가합니다.
 

```optimize-jpg.sh
#!/bin/bash

# directory containing images
input_dir="$1"

# target image quality
quality="$2"

if [[ -z "$input_dir" ]]; then
  echo "Please specify an input directory."
  exit 1
elif [[ -z "$quality" ]]; then
  echo "Please specify image quality."
  exit 1
fi

# for each jpg or jpeg in the input directory
for img in $( find $input_dir -type f -iname "*.jpg" -o -iname "*.jpeg" );
do
  cp $img ${img%.*}-optimized.jpg
  jpegoptim -m $quality ${img%.*}-optimized.jpg
done
```

이 스크립트는 JPEGoptim을 사용합니다.
 이 패키지의 문제점은 출력 파일을 지정하는 옵션이 없다는 것입니다.
 이미지 파일 만 최적화 할 수 있습니다.
 먼저 이미지 사본을 만들고 원하는 이름을 지정한 다음 사본을 최적화하여이를 극복 할 수 있습니다.
 `-m` 인수는 이미지 품질을 지정하는 데 사용됩니다.
 품질과 파일 크기 사이의 적절한 균형을 찾기 위해 약간의 실험을하는 것이 좋습니다.
 

```terminal
bash optimize-jpg.sh generated-images 95
```

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/12/s_FA3C3321F9CAFCD916B8768871CA8981B9B6DA946376796F2D67EB92118AE5DA_1606729808381_Screenshotfrom2020-11-2914-40-47.png?resize=714%2C473&ssl=1)

결과는 커밋`35630da`에 표시됩니다.
 

### 마무리
 verified_user

저것 좀 봐?
 몇 개의 스크립트를 사용하면 명령 줄에서 바로 강력한 이미지 최적화를 수행 할 수 있으며 전역 적으로 설치되므로 모든 프로젝트에서 사용할 수 있습니다.
 CI / CD 파이프 라인을 설정하여 각 이미지의 다양한 변형을 만들고 유효한 HTML, API를 사용하여 제공하거나 자체 이미지 변환 웹 사이트를 설정할 수도 있습니다.
 

내가 당신을 위해 글을 쓰는 것을 즐겼던 것만 큼이 기사에서 무언가를 읽고 배우는 것을 즐겼기를 바랍니다.
 즐거운 코딩 되세요!
 