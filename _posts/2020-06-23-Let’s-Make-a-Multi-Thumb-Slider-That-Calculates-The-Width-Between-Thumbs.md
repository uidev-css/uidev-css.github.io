---
layout: post
title: "엄지손가락 사이의 너비를 계산하는 다중 엄지 슬라이더를 만듭시다."
author: "Uidev Css"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/06/multi-thumb-slider-percentages.png"
tags: SLIDER
---


HTML에는 가장 단순한 유형의 비율 슬라이더인 `=input type="range"가 있습니다. 이 슬라이더의 엄지손가락이 끝나는 곳이라면 그 이전과 이후의 모든 것의 비율을 나타낼 수 있다(값과 최대 속성 사용). 더 멋있어지기 때문에, 다중 엄지 슬라이더를 만들 수 있습니다. 하지만 오늘날 우리는 또 다른 것을 염두에 두고 있습니다. 엄지손가락이 여러 개인 비율 슬라이더와 겹칠 수 없는 섹션입니다.

오늘 구축될 내용은 다음과 같습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_QWjpLJm" src="//codepen.io/anon/embed/QWjpLJm?height=250&amp;theme-id=1&amp;slug-hash=QWjpLJm&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed QWjpLJm" title="CodePen Embed QWjpLJm" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

슬라이더지만 슬라이더가 아닙니다. 비율 슬라이더입니다. 다양한 섹션은 모두 100%까지 추가되어야 하며 사용자는 이 섹션의 다른 섹션을 조정할 수 있습니다.

### 왜 그런 게 필요하세요?

다음과 같은 슬라이더가 다양한 계획된 비용으로 구성되는 예산 앱을 구축하고자 할 수 있습니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/06/image-17.png?resize=796%2C103&ssl=1)

저는 애니메이션 영화 제안 플랫폼을 만들기 위해 이와 같은 것이 필요했습니다. UX 패턴을 조사하던 중, 다른 애니메이션 영화 제안 사이트에도 이런 종류의 태그를 선택하여 영화 추천을 받을 수 있다는 것을 알게 되었습니다. 그것도 괜찮지만, 무게가 더 나가는 다른 태그보다 무게가 더 큰 태그에 대한 권장 사항이 우선시되도록 해당 태그에 무게를 더하는 것이 얼마나 더 멋질까요? 다른 아이디어들을 찾아봤지만, 별로 찾지 못했어요.

그래서 내가 이걸 지었어! 믿거나 말거나, 그렇게 복잡하지는 않습니다. 단계별로 안내해 드리겠습니다.

반응 및 유형 스크립트로 작성하겠습니다. 그건 필요 없지만요. 이 개념은 바닐라 자바스크립트 또는 다른 프레임워크에 포팅되어야 한다.

시작에 대한 동적 데이터를 사용하여 이 슬라이더를 만들어 보겠습니다. 각 섹션의 이름과 색상을 사용하여 서로 다른 섹션을 가변 배열로 유지합니다.

```js
const _tags = [
  {
    name: "Action",
    color: "red"
  },
  {
    name: "Romance",
    color: "purple"
  },
  {
    name: "Comedy",
    color: "orange"
  },
  {
    name: "Horror",
    color: "black"
  }
];
```

각 태그 섹션의 너비는 최대 100%를 추가하는 백분율 배열에 의해 제어됩니다. 이 작업은 `Array`를 사용하여 수행합니다.각 폭의 상태를 초기화하기 위한 채우기(`) 방법:

```js
const [widths, setWidths] = useState<number[]>(new Array(_tags.length).fill(100 / _tags.length))
```

그런 다음 단일 태그 섹션을 렌더링하는 구성 요소를 생성합니다.

```js
interface TagSectionProps {
  name: string
  color: string
  width: number
}
 
const TagSection = ({ name, color, width }: TagSectionProps) => {
  return <div
    className='tag'
    style={ ...styles.tag, background: color, width: width + '%' }
>
    <span style={styles.tagText}>{name}</span>
   <div
     style={styles.sliderButton}
     className='slider-button'>        
     <img src={"https://assets.codepen.io/576444/slider-arrows.svg"} height={'30%'} />
    </div>
  </div >
}
```

그런 다음 `_tags` 어레이를 통해 매핑하여 모든 섹션을 렌더링하고 위에서 생성한 `TagSection` 구성 요소를 반환합니다.

```js
const TagSlider = () => {
  const [widths, setWidths] = useState<number[]>((new Array(_tags.length).fill(100 / _tags.length)))
  return <div
    style={
      width: '100%',
      display: 'flex'
    }>
    {
    _tags.map((tag, index) => <TagSection
      width={widths[index]}
      key={index}
      name={tag.name}
      color={tag.color}
    />)
    }
  </div>
}
```

테두리를 둥글게 만들고 마지막 슬라이더 버튼을 숨기려면 CSS에서 `:first-of-type` 및 `:last-of-type` 의사 선택기를 사용하십시오.

```css
.tag:first-of-type {
  border-radius: 50px 0px 0px 50px;
}
.tag:last-of-type {
  border-radius: 0px 50px 50px 0px;
}
.tag:last-of-type>.slider-button {
  display:none !important;
}
```

여기가 우리가 지금까지 있는 곳이야. 슬라이더 핸들은 아직 아무 작업도 하지 않습니다! 다음에 하죠.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_abvyqpw" src="//codepen.io/anon/embed/abvyqpw?height=250&amp;theme-id=1&amp;slug-hash=abvyqpw&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed abvyqpw" title="CodePen Embed abvyqpw" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 조절 가능한 슬라이더 섹션

슬라이더 버튼을 마우스 커서나 터치로 끌 때 슬라이더 섹션이 이동을 조정하도록 합니다. 섹션 폭 변경이 슬라이더 단추가 끌린 정도에 해당하는지 확인합니다. 이를 위해서는 다음과 같은 몇 가지 질문에 답해야 합니다.

- 슬라이더 버튼을 클릭했을 때 커서 위치를 얻는 방법은 무엇입니까?
- 슬라이더 버튼을 끄는 동안 커서 위치를 얻는 방법은 무엇입니까?
- 태그 섹션의 너비를 태그 섹션 단추가 끌린 정도에 맞게 하려면 어떻게 해야 합니까?

한 명씩...

`TagSectionProps` 인터페이스에 `onSliderSelect` 이벤트 핸들러를 추가해 보겠습니다.

```js
interface TagSectionProps {
  name: string;
  color: string;
  width: number;
  onSliderSelect: (e: React.MouseEvent<HTMLDivElement, MouseEvent>) => void;
}
```

`onSliderSelect` 이벤트 핸들러는 `TagSection` 구성 요소의 `onPointerDown` 이벤트에 연결됩니다.

```js
const TagSection = ({
  name,
  color,
  width,
  onSliderSelect // Highlight
}: TagSectionProps) => {
  return (
    <div
      className="tag"
      style={
        ...styles.tag,
        background: color,
        width: width + "%"
        }
    >
      <span style={styles.tagText}>{name}</span>
      <span style={ ...styles.tagText, fontSize: 12 }>{width + "%"}</span>
  
      <div
        style={styles.sliderButton}
        onPointerDown={onSliderSelect}
        className="slider-button"
      >
      <img src={"https://animesonar.com/slider-arrows.svg"} height={"30%"} />
      </div>
    </div>
  );
};
```

마우스와 터치스크린 이벤트를 모두 잡기 위해 마우스 다운 대신 온 포인터다운을 사용한다. 여기에 그것에 대한 더 많은 정보가 있다.

슬라이더 버튼을 클릭했을 때 커서의 위치를 얻기 위해 `onSlider Select` propect 기능의 `e.pageX`를 사용하고 있습니다.

```js
<TagSection
  width={widths[index]}
  key={index}
  name={tag.name}
  onSliderSelect={(e) => {
    const startDragX = e.pageX;
  }
/> 

```

원 다운!

이제 포인터무브 터치무브라는 드래그 이벤트를 들을 수 있는 이벤트 리스너를 추가해야 한다. 마우스 커서 및 터치 동작에 이러한 이벤트를 사용합니다. 사용자가 화면에서 손가락을 들어 올리면 섹션 폭이 업데이트를 중지해야 합니다(따라서 끌기 종료).

```js
window.addEventListener("pointermove", resize);
window.addEventListener("touchmove", resize);
 
const removeEventListener = () => {
  window.removeEventListener("pointermove", resize);
  window.removeEventListener("touchmove", resize);
}
 
const handleEventUp = (e: Event) => {
  e.preventDefault();
  document.body.style.cursor = "initial";
  removeEventListener();
}
 
window.addEventListener("touchend", handleEventUp);
window.addEventListener("pointerup", handleEventUp);
```

크기 조정 기능은 슬라이더 버튼을 끄는 동안 커서의 X 좌표를 제공합니다.

```js
const resize = (e: MouseEvent & TouchEvent) => {
  e.preventDefault();
  const endDragX = e.touches ? e.touches[0].pageX : e.pageX
}
```

크기 조정 기능이 터치 이벤트에 의해 트리거되면 `e.touchs`는 배열 값이며, 그렇지 않으면 `endDragX`가 `e.pageX` 값을 갖는 null입니다.

## 태그 섹션의 너비를 태그 섹션 단추가 끌린 정도에 맞게 하려면 어떻게 해야 합니까?

다양한 태그 섹션의 너비 백분율을 변경하려면 슬라이더의 전체 너비를 기준으로 커서가 이동하는 거리를 백분율로 가져옵니다. 여기서부터 해당 값을 태그 섹션에 할당합니다.

먼저 리액트의 useRef 후크를 사용하여 태그슬라이더의 ref를 구해야 한다.

```js
const TagSlider = () => {
const TagSliderRef = useRef<HTMLDivElement>(null);
  // TagSlider
  return (
    <div
      ref={TagSliderRef}
// ... 

```

이제 슬라이더의 참조를 사용하여 요소의 레이아웃 너비를 정수로 반환하는 `오프셋 폭` 속성을 얻습니다.

```js
onSliderSelect={(e) => {
  e.preventDefault();
  document.body.style.cursor = 'ew-resize';
 
  const startDragX = e.pageX;
  const sliderWidth = TagSliderRef.current.offsetWidth;
}; 

```

그런 다음 전체 슬라이더를 기준으로 커서가 이동한 거리를 계산합니다.

```js
const getPercentage = (containerWidth: number, distanceMoved: number) => {
  return (distanceMoved / containerWidth) * 100;
};
 
const resize = (e: MouseEvent & TouchEvent) => {
  e.preventDefault();
  const endDragX = e.touches ? e.touches[0].pageX : e.pageX;
  const distanceMoved = endDragX - startDragX;
  const percentageMoved = getPercentage(sliderWidth, distanceMoved);
} 

```

마지막으로, 새로 계산된 섹션 폭을 `_widths` 상태 변수의 인덱스에 할당할 수 있다.

```js
const percentageMoved = getPercentage(sliderWidth, distanceMoved);
const _widths = widths.slice();
const prevPercentage = _widths[index];
const newPercentage = prevPercentage + percentageMoved
 
_widths[index] = newPercentage;
setWidths(_widths);
```

하지만 이게 끝이 아니야! 다른 섹션은 너비가 변경되지 않으며 백분율이 음수가 되거나 합계가 100%를 넘을 수 있습니다. 말할 것도 없이, 전체 백분율이 변경되지 않도록 하는 제한을 적용하지 않았기 때문에 모든 횡단 폭의 합이 항상 100%와 같지는 않습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_dyYJXdq" src="//codepen.io/anon/embed/dyYJXdq?height=250&amp;theme-id=1&amp;slug-hash=dyYJXdq&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed dyYJXdq" title="CodePen Embed dyYJXdq" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>

### 다른 섹션 수정

옆에 있는 섹션이 변경될 때 한 섹션의 너비가 변경되도록 합니다.

```js
const nextSectionNewPercentage = percentageMoved < 0 
  ? _widths[nextSectionIndex] + Math.abs(percentageMoved)
  : _widths[nextSectionIndex] - Math.abs(percentageMoved)
```

이는 단면이 늘어나면 인접 단면의 폭을 줄이는 효과가 있다. 단축할 수도 있습니다.

```js
const nextSectionNewPercentage = _widths[nextSectionIndex] - percentageMoved
```

섹션 백분율을 조정하면 오른쪽 인접 영역에만 영향을 미칩니다. 즉, 지정된 섹션의 최대 백분율 값은 인접 영역의 전체 공간을 차지할 수 있는 경우 인접 영역의 너비에 인접 너비가 더해져 있어야 합니다.

![image](https://i1.wp.com/css-tricks.com/wp-content/uploads/2020/06/image-18.png?resize=1464%2C298&ssl=1)

최대 백분율 값을 계산하여 이를 실현할 수 있습니다.

```js
const maxPercent = widths[index] + widths[index+1]
```

음의 너비 값을 방지하려면 너비를 0보다 크지만 최대 백분율보다 작은 값으로 제한하십시오.

```js
const limitNumberWithinRange = (value: number, min: number, max: number):number => {
  return Math.min(Math.max(value,min),max)
}
```

`limit Number범위 내 함수는 음수 값과 절의 합이 최대 백분율보다 높은 값을 갖는 인스턴스를 모두 방지합니다. (이 Stavek Overflow 스레드에 대한 해트 팁)

현재 섹션과 인접 섹션의 너비에 이 기능을 사용할 수 있습니다.

```js
const currentSectionWidth = limitNumberWithinRange(newPercentage, 0, maxPercent)
_widths[index] = currentSectionWidth
 
const nextSectionWidth = limitNumberWithinRange(nextSectionNewPercentage, 0, maxPercent);
_widths[nextSectionIndex] = nextSectionWidth;
```

### 추가 터치

현재 슬라이더는 각 섹션의 너비를 전체 컨테이너에서 일부 미친 소수점까지의 백분율로 계산합니다. 매우 정밀하지만, 이런 종류의 UI에는 그다지 유용하지 않습니다. 소수점 대신 정수로 작업하려면 다음과 같은 작업을 수행할 수 있습니다.

```js
const nearestN = (N: number, number: number) => Math.ceil(number / N) * N;
const percentageMoved = nearestN(1, getPercentage(sliderWidth, distanceMoved))
```

이 함수는 두 번째 파라미터의 값을 가장 가까운 `N`에 근사하게 합니다(첫 번째 파라미터로 지정됨). 이 예처럼 N을 1로 설정하면 작은 증분 소수 대신 정수에서 백분율을 변경하는 효과가 있습니다.

또 다른 터치하기 좋은 점은 0% 값이 있는 섹션에 대한 추가 취급을 고려하는 것입니다. 그것들은 더 이상 전체 폭의 어떤 비율도 차지하지 않기 때문에 슬라이더에서 모두 제거해야 한다. 다음 섹션에서 이벤트 수신을 중지할 수 있습니다.

```js
if (tags.length > 2) {
  if (_widths[index] === 0) {
     _widths[nextSectionIndex] = maxPercent;
    _widths.splice(index, 1);
    setTags(tags.filter((t, i) => i !== index));
    removeEventListener();
  }
  if (_widths[nextSectionIndex] === 0) {
    _widths[index] = maxPercent;
    _widths.splice(nextSectionIndex, 1);
    setTags(tags.filter((t, i) => i !== nextSectionIndex));
    removeEventListener();
  }
} 
 

```

### Voila!

마지막 슬라이더는 다음과 같습니다.

<div class="wp-block-cp-codepen-gutenberg-embed-block cp_embed_wrapper resizable" style="height: 250px;"><iframe id="cp_embed_QWjpLJm" src="//codepen.io/anon/embed/QWjpLJm?height=250&amp;theme-id=1&amp;slug-hash=QWjpLJm&amp;default-tab=result" height="250" scrolling="no" frameborder="0" allowfullscreen="" allowpaymentrequest="" name="CodePen Embed QWjpLJm" title="CodePen Embed QWjpLJm" class="cp_embed_iframe" style="width: 100%; overflow: hidden; height: 100%;">CodePen Embed Fallback</iframe><div class="win-size-grip" style="touch-action: none;"></div></div>