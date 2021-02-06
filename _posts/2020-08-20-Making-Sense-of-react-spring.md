---
layout: post
title: "리액션 스프링의 의미"
author: "CSS Dev"
thumbnail: "https://res.cloudinary.com/css-tricks/image/fetch/w_1200,q_auto,f_auto/https://css-tricks.com/wp-content/uploads/2020/07/react-spring.png"
tags: 
---


애니메이션은 리액트에게 맞추기에 더 까다로운 것들 중 하나이다. 이 게시물에서는 처음 시작할 때 갖고 싶었던 리액트 스프링에 대한 소개를 제공하고 몇 가지 흥미로운 사용 사례를 자세히 살펴보겠습니다. 리액트 스프링이 리액트만을 위한 애니메이션 라이브러리는 아니지만, 더 인기 있는 (그리고 더 나은) 라이브러리 중 하나입니다.

저는 이 글에서 현재 출시 후보 상태인 최신 버전 9를 사용할 것입니다. 이 파일을 읽을 때까지 완전히 릴리스되지 않은 경우 `react-spring@next`와 함께 설치하십시오. 제가 본 것과 관리 책임자가 제게 말한 것을 보면, 코드는 믿을 수 없을 정도로 안정적입니다. 내가 본 유일한 문제는 동시 모드에서 사용할 때 약간의 버그뿐인데, 이것은 GitHubrepo에서 추적할 수 있다.

### 반응 스프링 환원제

몇 가지 흥미로운 애플리케이션 활용 사례를 살펴보기 전에 간단한 소개를 시작하겠습니다. 스프링, 높이 애니메이션, 그리고 전환을 다룹니다. 이 섹션 마지막에 작업 데모를 할 테니, 도중에 상황이 조금 혼란스러워지더라도 걱정하지 마세요.

### 샘솟다

애니메이션의 표준 "Hello world"를 생각해 봅시다: 콘텐츠의 안팎을 희미하게 만드는 것입니다. 잠시 멈추고 애니메이션 없이 불투명도를 어떻게 켜거나 끌지 생각해 봅시다. 이렇게 보일 수도 있습니다.

```jsx
export default function App() {
  const [showing, setShowing] = useState(false);
  return (
    <div>
      <div style={ opacity: showing ? 1 : 0 }>
        This content will fade in and fade out
      </div>
      <button onClick={() => setShowing(val => !val)}>Toggle</button>
      <hr />
    </div>
  );
}
```

쉽지만 지루하다. 변화하는 불투명도를 어떻게 애니메이션화합니까? 위의 값들처럼 우리가 원하는 불투명도를 상태에 따라 선언적으로 설정할 수 있다면, 그 값들이 원활하게 애니메이션화 되는 것 말고는 좋지 않을까요? 그게 리액션 스프링이 하는 일입니다. 리액트 스프링을 우리의 변화하는 스타일 가치를 세탁하는 중간자라 생각해보세요. 그래야 우리가 원하는 애니메이션 가치들 간의 원활한 전환이 가능합니다. 다음과 같은 경우:

```jsx
const [showA, setShowA] = useState(false);
 
const fadeStyles = useSpring({
  config: { ...config.stiff },
  from: { opacity: 0 },
  to: {
    opacity: showA ? 1 : 0
  }
});
```

초기 스타일 값을 `from`으로 지정하고 현재 상태를 기준으로 `to` 섹션에서 현재 값을 지정합니다. 반환 값인 `fadeStyles`는 컨텐츠에 적용되는 실제 스타일 값을 포함합니다. 마지막으로 필요한 것이 하나 있습니다.

이렇게 하면 될 것 같습니다.

```jsx
<div style={fadeStyles}>
```

…끝내라. 하지만 일반 div를 사용하는 대신, 우리는 애니메이션 수출에서 만들어진 리액트 스프링 div를 사용할 필요가 있습니다. 혼란스럽게 들릴 수도 있지만, 실제로 의미하는 것은 다음과 같습니다.

```jsx
<animated.div style={fadeStyles}>
```

그리고 그게 다야.

애니메이션에 따라 제로 높이에서 전체 크기로 콘텐츠가 위아래로 미끄러져 주변 콘텐츠가 조정되고 제자리로 원활하게 흘러가길 원할 수 있습니다. 여러분은 우리가 0에서 0으로 되는 높이에서 0으로 되는 위의 것을 복사하는 것을 원할지도 모르지만, 아아, 여러분은 자동 높이로 애니메이션을 할 수 없습니다. 그것은 바닐라 CSS에도, 리액트 스프링에도 작동하지 않는다. 대신, 우리는 콘텐츠의 실제 높이를 알고, 그것을 봄의 `to` 부분에 명시해야 한다.

임의 콘텐츠의 높이를 즉시 확보해야 반응 스프링에 해당 가치를 전달할 수 있습니다. 웹 플랫폼에는 이를 위해 특별히 설계된 "Resize Observer"가 있습니다. 그리고 그 지지는 사실 꽤 좋아요! 리액트를 사용 중이므로, 이 사용법은 당연히 훅으로 포장합니다. 제 것은 다음과 같습니다.

```jsx
export function useHeight({ on = true /* no value means on */ } = {} as any) {
  const ref = useRef<any>();
  const [height, set] = useState(0);
  const heightRef = useRef(height);
  const [ro] = useState(
    () =>
      new ResizeObserver(packet => {
        if (ref.current && heightRef.current !== ref.current.offsetHeight) {
          heightRef.current = ref.current.offsetHeight;
          set(ref.current.offsetHeight);
        }
      })
  );
  useLayoutEffect(() => {
    if (on && ref.current) {
      set(ref.current.offsetHeight);
      ro.observe(ref.current, {});
    }
    return () => ro.disconnect();
  }, [on, ref.current]);
  return [ref, height as any];
}
```

선택적으로 측정값을 켜거나 끄는 `on` 값을 제공할 수 있습니다(나중에 유용하게 사용할 수 있음). `on`이 `true`일 때, 우리는 `Resize Observer`에게 내용을 관찰하라고 말한다. 현재 높이뿐만 아니라 측정하고자 하는 모든 콘텐츠에 적용할 필요가 있는 참조 정보를 반환합니다.

실제로 보자.

```jsx
const [heightRef, height] = useHeight();
const slideInStyles = useSpring({
  config: { ...config.stiff },
  from: { opacity: 0, height: 0 },
  to: {
    opacity: showB ? 1 : 0,
    height: showB ? height : 0
  }
});
```

"사용 높이"는 우리가 측정하고 있는 내용물의 기준값과 높이값을 부여하는데, 이것은 우리의 봄을 따라 지나간다. 그리고 나서 우리는 ref를 바르고 높이 스타일을 적용한다.

```jsx
<animated.div style={ ...slideInStyles, overflow: "hidden" }>
  <div ref={heightRef}>
    This content will fade in and fade out with sliding
  </div>
</animated.div>
```

아, 그리고 용기에 "overflow: hidden"을 추가하는 것을 잊지 마세요. 그러면 높이 값을 적절히 억제할 수 있습니다.

마지막으로, DOM에 애니메이션 항목을 추가 및 제거하는 방법을 살펴보겠습니다. 우리는 이미 DOM에 남아 있는 항목의 변화하는 값을 애니메이션화하는 방법을 알고 있지만, 항목의 추가 또는 제거를 애니메이션화하기 위해서는 새로운 후크인 Transition을 사용해야 합니다.

이전에 리액트 스프링을 사용한 적이 있는 경우, 버전 9가 API를 크게 변경한 몇 안 되는 장소 중 하나입니다. 한번 보자.

다음과 같은 항목 목록을 애니메이션화하려면 다음과 같이 하십시오.

```jsx
const [list, setList] = useState([]);
```

…이렇게 전환 기능을 선언합니다.

```jsx
const listTransitions = useTransition(list, {
  config: config.gentle,
  from: { opacity: 0, transform: "translate3d(-25%, 0px, 0px)" },
  enter: { opacity: 1, transform: "translate3d(0%, 0px, 0px)" },
  leave: { opacity: 0, height: 0, transform: "translate3d(25%, 0px, 0px)" },
  keys: list.map((item, index) => index)
});
```

앞서 언급했듯이, 반환 값인 `list Transitions`는 함수입니다. react-spring은 목록 배열을 추적하여 추가 및 제거된 항목을 감시합니다. 우리는 `list Transition` 함수를 `list Transition` 함수라고 부르고, 단일 `스타일` 객체와 단일 항목을 수락하는 콜백을 제공하며, 리액트 스프링은 이 기능이 새로 추가되었는지, 새로 제거되었는지, 또는 목록에 그냥 앉아 있는지 여부에 따라 올바른 스타일을 가진 목록의 각 항목에 대해 콜백을 할 것이다.

키 섹션을 참고하십시오. 이를 통해 반응 스프링에 목록에 있는 물체를 식별하는 방법을 알려줄 수 있습니다. 이 경우, 어레이의 항목 인덱스가 해당 항목을 고유하게 정의한다고 리액트 스프링에 알려주기로 했습니다. 보통 이것은 끔찍한 생각일 것입니다. 하지만 지금으로서는, 우리가 그 기능을 실제로 볼 수 있게 해줍니다. 아래 데모에서 "Add item" 버튼을 클릭하면 항목이 목록 끝에 추가되고, "Remove last item" 버튼은 가장 최근에 추가된 항목을 목록에서 제거합니다. 입력란에 입력한 다음 빠르게 추가 버튼을 누른 다음 제거 버튼을 누르면 동일한 항목이 부드럽게 입력되기 시작하고 애니메이션의 모든 단계에서 즉시 사라집니다. 반대로 항목을 추가한 다음 제거 단추와 추가 단추를 빠르게 누르면 동일한 항목이 미끄러지기 시작하다가 갑자기 중지된 후 원래 위치로 다시 이동합니다.

### 여기 데모입니다.

휴, 정말 말이 많았구나! 여기 작업 데모가 있습니다. 우리가 방금 보도한 모든 것을 보여줍니다.

### 이런저런 잡동사니들, 이것저것 자질구레한 것들

데모의 콘텐츠를 아래로 밀어내면 스프링처럼 제 자리에 튕겨지는 것을 알아차렸습니까? 여기서 이름이 유래되었습니다: 반응 스프링은 스프링 물리학을 사용하여 변화하는 값을 보간합니다. 단순히 N 등가 지연에 적용되는 N 등가 델타로 변경되는 값을 자르는 것이 아닙니다. 대신 봄과 같은 효과를 내는 보다 정교한 알고리즘을 사용하며, 이는 보다 자연스러워 보일 것이다.

스프링 알고리즘은 완전히 구성 가능하며 선반에서 꺼낼 수 있는 여러 가지 사전 설정이 함께 제공됩니다. 위의 데모에서는 `stick` 및 `gent` 사전 설정이 사용됩니다. 자세한 내용은 문서를 참조하십시오.

또한 `translate 3d` 값 내부의 값을 어떻게 애니메이션하고 있는지 알아 보십시오. 보시다시피, 구문이 가장 용이한 것은 아니므로 반응 스프링은 몇 가지 바로 가기를 제공합니다. 이에 대한 설명서가 있지만, 이 게시물의 나머지 부분에서는 가능한 한 명확성을 유지하기 위해 전체 비바로 가기 구문을 계속 사용할 것입니다.

위의 데모에서 콘텐츠를 위로 밀어 올리면 맨 끝에 있는 콘텐츠가 약간 부풀어 오르는 것을 볼 수 있다는 사실에 주목하여 이 섹션을 마치겠습니다. 이는 동일한 반동 효과의 결과입니다. 콘텐츠가 아래로 튕겨져 나와 제 위치에 있을 때는 날카로워 보이지만, 콘텐츠를 위로 밀어 올릴 때는 그렇지 않습니다. 어떻게 끌 수 있는지 계속 지켜봐. (스포일러, 이건 클램프의 속성이야.)

### 이러한 샌드박스와 관련하여 고려해야 할 몇 가지 사항

코드 샌드박스는 핫 재로딩을 사용합니다. 코드를 변경하면 일반적으로 변경 내용이 즉시 반영됩니다. 이것은 멋있지만 애니메이션의 대혼란을 깨뜨릴 수 있다. 만약 여러분이 땡땡거리기 시작하고, 이상하고 겉으로 보기에 잘못된 행동을 보인다면, 샌드박스를 새로 고쳐보세요.

이 게시물에 있는 다른 샌드박스는 모달(모달)을 사용할 것입니다. 모달이 열려 있으면 어떤 코드도 수정할 수 없습니다. 모달은 포커스를 포기하려고 하지 않습니다. 따라서 변경을 시도하기 전에 반드시 모달을 닫으십시오.

### 이제 진짜를 만들자.

그것들은 반응 스프링의 기본 구성 요소입니다. 좀 더 흥미로운 것을 만들기 위해 그것들을 사용합시다. 위의 모든 것을 고려해 볼 때, 반응 스프링은 사용하기 매우 간단하다고 생각할 수 있습니다. 불행하게도, 실제로, 여러분이 맞히기 위해 필요한 몇 가지 미묘한 것들을 알아내는 것은 어려울 수 있습니다. 이 게시물의 나머지 부분은 이러한 세부 사항들을 자세히 살펴볼 것입니다.

내가 이전에 쓴 블로그 게시물들은 어떤 면에서 나의 북리스트 사이드 프로젝트와 관련이 있었다. 이 프로젝트도 다르지 않을 것입니다. 집착은 아닙니다. 이 프로젝트는 공개 가능한 GraphQL 끝점을 가지고 있고, 활용할 수 있는 수많은 기존 코드를 가지고 있기 때문에 명백한 목표가 될 것입니다.

모달 열고 책을 검색할 수 있는 UI를 구축해 보자. 결과가 나오면 모달 아래에 표시되는 선택된 책의 실행 목록에 결과를 추가할 수 있습니다. 작업을 마치면 모달을 닫고 버튼을 클릭하여 선택 항목과 유사한 책을 찾을 수 있습니다.

먼저 작동 중인 UI로 시작한 다음 진행 중인 대화형 데모를 포함하여 단계별 애니메이션을 진행합니다.

최종 결과가 어떻게 나올지 정말 궁금하시거나, 리액션 스프링에 이미 익숙하시며, 제가 이미 모르는 것을 취재하고 있는지 알고 싶다면, 여기 있습니다(디자인상은 받지 못할 것입니다, 잘 알고 있습니다). 이 게시물의 나머지 부분에서는 해당 종료 상태로 가는 과정을 단계별로 다룹니다.

### 모달 애니메이션 중

일단 모달부터. 어떤 종류의 데이터라도 추가하기 전에 모달 애니메이션을 멋지게 만들어 봅시다. 여기 기본적이고, 애니메이션이 아닌 모달의 모습이 있습니다. 저는 라이언 플로렌스의 리치 UI(특히 모달 구성 요소)를 사용하고 있지만, 모달 제작을 위해 어떤 방법을 사용하든 아이디어는 동일합니다. 우리는 우리의 배경이 사라지게 하고 또한 우리의 모달 콘텐트를 변화시키고 싶습니다.

모달은 일종의 "열린" 속성에 따라 조건부로 렌더링되므로 "전환 사용" 후크를 사용합니다. 나는 이미 리치 UI 모달에 내 모달 컴포넌트를 싸서 아무것도 렌더링하지 않거나 `isOpen` 속성에 기반한 실제 모달 중 하나를 렌더링하고 있었다. 우리는 단지 애니메이션화를 위해 전환 고리를 통과하면 됩니다.

전환 고리는 다음과 같습니다.

```jsx
const modalTransition = useTransition(!!isOpen, {
  config: isOpen ? { ...config.stiff } : { duration: 150 },
  from: { opacity: 0, transform: `translate3d(0px, -10px, 0px)` },
  enter: { opacity: 1, transform: `translate3d(0px, 0px, 0px)` },
  leave: { opacity: 0, transform: `translate3d(0px, 10px, 0px)` }
});
```

여기엔 별로 놀랄만한 것이 없다. 우리는 사물을 페이드 인하여 모달의 활성 여부에 따라 약간의 수직 전환을 제공하기를 원한다. 이상한 점은 다음과 같습니다.

```jsx
config: isOpen ? { ...config.stiff } : { duration: 150 },
```

모달은 열려 있을 경우에만 스프링 물리학을 사용하고 싶습니다. 적어도 내 경험상, 모달 닫는 것은 배경이 완전히 사라지기까지 너무 오래 걸리기 때문에 기본 UI가 너무 오랫동안 상호 작용하지 않기 때문입니다. 모달은 스프링 물리학과 함께 제자리 걸음으로 움직이게 되고, 닫히면 150밀리초 안에 사라지게 됩니다.

그리고 물론, 우리는 우리의 컨텐츠를 우리의 후크가 반환하는 전환 기능을 통해 제공할 것입니다. 배경에 적용할 스타일 객체의 불투명도 스타일을 선택한 다음 실제 모달 내용에 모든 애니메이션 스타일을 적용합니다.

```jsx
return modalTransition(
  (styles, isOpen) =>
    isOpen && (
      <AnimatedDialogOverlay
        allowPinchZoom={true}
        initialFocusRef={focusRef}
        onDismiss={onHide}
        isOpen={isOpen}
        style={ opacity: styles.opacity }
      >
      <AnimatedDialogContent
        style={
          border: "4px solid hsla(0, 0%, 0%, 0.5)",
          borderRadius: 10,
          maxWidth: "400px",
          ...styles
        }
      >
        <div>
          <div>
            <StandardModalHeader caption={headerCaption} onHide={onHide} />
            {children}
          </div>
        </div>
      </AnimatedDialogContent>
    </AnimatedDialogOverlay>
  )
);
```

### 기본 설정

위에서 설명한 사용 사례부터 살펴보겠습니다. 데모를 따라하는 경우 애니메이션은 사용하지 않고 작동되는 모든 작업에 대한 전체 데모가 제공됩니다. 모달을 열고 원하는 항목을 검색합니다(빈 텍스트 상자에서 Enter 키를 누르기만 하면 됩니다). 내 GraphQL 끝점을 누르고 내 개인 라이브러리에서 검색 결과를 가져와야 합니다.

이 게시물의 나머지 부분은 UI에 애니메이션을 추가하는 데 초점을 맞추게 될 것이며, UI에 전후를 볼 수 있는 기회를 제공하고, (희망적으로) 일부 미묘하고 잘 배치된 애니메이션이 UI를 얼마나 더 잘 만들 수 있는지 관찰할 수 있기를 바랍니다.

### 모달 크기 애니메이션

모달 자체부터 시작해보죠. 열어보고 "제퍼슨"이라고 불러요 새 콘텐츠를 수용하기 위해 모달의 크기가 갑자기 커지는 방식에 주목하십시오. 모달 애니메이션을 더 크고 작은 크기로 만들 수 있을까요? 물론이야. 우리의 신뢰할 수 있는 용도를 파헤쳐라.높이 걸쇠를 당기고 우리가 뭘 할 수 있는지 보세요.

불행히도, 우리는 내용물에 담긴 포장지에 키 리프를 가볍게 친 다음 봄에 키 리프를 붙일 수는 없습니다. 이렇게 하면 모달 슬라이드를 초기 크기로 볼 수 있습니다. 우리는 그것을 원하지 않습니다. 우리는 완전히 형성된 모형이 적절한 크기로 나타나서 거기서부터 다시 크기를 조정하기를 원합니다.

우리가 하고 싶은 것은 우리의 모달 콘텐츠가 DOM에 렌더링되기를 기다렸다가 우리의 높이 기준을 설정하고, 측정을 시작하기 위해 우리의 `사용 높이 후크`를 켜는 것이다. 아, 그리고 우리는 우리의 초기 높이를 즉시 설정하고, 애니메이션이 제 위치에 오르지 않기를 원합니다. 많은 것처럼 들리지만, 들리는 것만큼 나쁘지는 않아요.

이것으로 시작하겠습니다.

```jsx
const [heightOn, setHeightOn] = useState(false);
const [sizingRef, contentHeight] = useHeight({ on: heightOn });
const uiReady = useRef(false);
```

우리가 모달의 높이를 측정하는지 아닌지에 대한 어떤 주가 있습니다. 모달이 DOM에 있을 때 이 값은 true로 설정됩니다. 그런 다음 활성 여부를 확인하기 위해 "on" 속성이 있는 "use Height" 후크를 호출합니다. 마지막으로, UI가 준비되었는지 여부를 보류하고 애니메이션을 시작할 수 있습니다.

우선 첫째로, 우리의 모형이 언제 실제로 DOM에 렌더링되는지 어떻게 알 수 있을까요? 우리가 알 수 있는 ref를 사용할 수 있다는 것이 밝혀졌습니다. React에서 `=divref={someRef}`를 하는 데 익숙하지만 실제로 함수를 전달할 수 있으며, 이 함수는 렌더링된 후 Retact에서 DOM 노드로 호출됩니다. 이제 이 기능을 정의해 보겠습니다.

```jsx
const activateRef = ref => {
  sizingRef.current = ref;
  if (!heightOn) {
    setHeightOn(true);
  }
};
```

그러면 높이 참조가 설정되고 `사용 높이` 후크가 켜집니다. 거의 다 됐어요!

어떻게 하면 초기 애니메이션을 바로 만들 수 있을까요? 봄의 사용 후크는 지금부터 살펴볼 두 가지 새로운 특성을 가지고 있다. 그것은 즉각적인 속성을 가지고 있는데, 이것은 국가 변화를 애니메이션화하지 말고 즉시 만들라는 것을 말해준다. 그것은 또한 국가 변화가 끝나면 발포하는 `온레스트` 콜백도 가지고 있다.

둘 다 활용하자. 최종 고리는 다음과 같습니다.

```jsx
const heightStyles = useSpring({
  immediate: !uiReady.current,
  config: { ...config.stiff },
  from: { height: 0 },
  to: { height: contentHeight },
  onRest: () => (uiReady.current = true)
});
```

높이 변경이 완료되면 uiReady를 true로 설정한다. `거짓`인 한, 우리는 리액트 스프링에게 즉각적인 변화를 주라고 말한다. 그래서 우리 모형이 처음 탑재될 때 `콘텐츠`키는 0(측정할 것이 없으면 사용 높이가 0이 된다)이고 봄은 아무 것도 하지 않는 등 오싹하기만 하다. 모달 스위치가 열리고 실제 콘텐츠가 렌더링되면 activateRef ref가 불리고 use Height가 켜지고, 컨텐츠의 실제 높이 값이 얻어지고, 스프링이 즉시 설정되며, 마지막으로 onRest 콜백이 트리거되고, 미래의 변화가 애니메이션화될 것이다. 휴!

일부 대체 사용 사례에서 첫 번째 렌더링을 사용할 때 정확한 높이가 확보되면 위의 후크를 다음과 같이 단순화할 수 있습니다.

```jsx
const heightStyles = useSpring({
  to: {
    height: contentHeight
  },
  config: config.stiff,
})
```

…이것은 실제로 다음과 같이 더욱 단순화할 수 있습니다.

```jsx
const heightStyles = useSpring({
  height: contentHeight,
  config: config.stiff,
})
```

우리의 후크는 처음에 정확한 높이로 렌더링될 것이고, 그 값의 변화는 애니메이션이 될 것이다. 그러나 실제로 보여지기 전에 모형이 렌더링되기 때문에 이러한 단순화에 활용할 수 없습니다.

예리한 독자들은 당신이 모달 문을 닫았을 때 무슨 일이 일어나는지 궁금해 할 것이다. 컨텐츠의 렌더링이 해제되고 높이 후크가 마지막으로 보고된 높이와 함께 유지되지만, 더 이상 DOM에 없는 DOM 노드를 "관찰"합니다. 만약 그게 걱정된다면, 제가 여기 있는 것보다 더 잘 청소해 주세요. 아마 이런 걸로요.

```jsx
useLayoutEffect(() => {
  if (!isOpen) {
    setHeightOn(false);
  }
}, [isOpen]);
```

그러면 해당 DOM 노드의 크기 조정 옵서버가 취소되고 메모리 누수가 수정됩니다.

### 결과 애니메이션

다음으로, 모달 내에서 결과의 변화를 애니메이션으로 살펴보겠습니다. 몇 가지 검색을 실행하면 즉시 결과가 전환 및 전환되는 것을 볼 수 있습니다.

searchBooks.js 파일의 `SearchBooksContent` 구성 요소를 살펴보십시오. 현재 `constbook Obj = 데이터`를 보유하고 있습니다.allBooks;`은 그래프QL 응답의 적절한 결과 집합을 추출한 다음 나중에 렌더링합니다.

```jsx
{booksObj.Books.map(book => (
  <SearchResult
    key={book._id}
    book={book}
    selected={selectedBooksMap[book._id]}
    selectBook={selectBook}
    dispatch={props.dispatch}
  />
))}
```

그래프QL 끝점에서 새로운 결과가 돌아오면 이 객체가 변경되므로 이 사실을 이용하여 이전부터 `사용 전환` 후크에 전달하여 일부 전환 애니메이션을 정의해 보는 것이 좋습니다.

```jsx
const resultsTransition = useTransition(booksObj, {
  config: { ...config.default },
  from: {
    opacity: 0,
    position: "static",
    transform: "translate3d(0%, 0px, 0px)"
  },
  enter: {
    opacity: 1,
    position: "static",
    transform: "translate3d(0%, 0px, 0px)"
  },
  leave: {
    opacity: 0,
    position: "absolute",
    transform: "translate3d(90%, 0px, 0px)"
  }
});
```

`position:static`에서 `position:절대`로 바뀐 점에 유의한다. 절대적인 위치를 갖는 외향적인 결과 세트는 부모의 키에 영향을 주지 않습니다. 이것이 우리가 원하는 것입니다. 부모님께서 새로운 콘텐츠에 맞춰 사이즈를 맞추실 것이고, 물론 위의 작업을 바탕으로 모달도 새로운 사이즈에 맞게 잘 애니메이션화 될 것입니다.

이전과 마찬가지로 전환 기능을 사용하여 컨텐츠를 제공할 것입니다.

```jsx
<div className="overlay-holder">
  {resultsTransition((styles, booksObj) =>
    booksObj?.Books?.length ? (
      <animated.div style={styles}>
        {booksObj.Books.map(book => (
          <SearchResult
            key={book._id}
            book={book}
            selected={selectedBooksMap[book._id]}
            selectBook={selectBook}
            dispatch={props.dispatch}
          />
        ))}
      </animated.div>
    ) : null
  )}
```

이제 새로운 결과 집합이 희미해지고 나가는 결과 집합이 희미해지며(그리고 약간 미끄러져) 사용자에게 상황이 바뀌었다는 추가 신호를 제공합니다.

물론, 결과가 없거나 사용자가 결과 집합의 모든 항목을 선택한 경우와 같은 모든 메시지를 애니메이션화하려고 합니다. 그 코드는 여기 있는 다른 모든 것들과 꽤 반복적이고, 이 게시물은 이미 길어지고 있기 때문에, 데모에 코드를 남겨둘게요.

### 선택한 책 애니메이션(아웃)

지금 당장 책을 고르면 순식간에 명단에서 사라진다. 오른쪽으로 밀면서 늘 하던 페이드 아웃을 발라요. 아이템이 오른쪽으로 미끄러져 나갈 때(변형을 통해), 우리는 아마도 그것의 높이가 0으로 애니메이션화되기를 원할 것입니다. 그래서 아이템이 미끄러져 나가 빈 상자를 남겨두고 즉시 사라지지 않고, 리스트가 나가는 아이템에 부드럽게 적응할 수 있기를 바랍니다.

지금쯤이면 이것이 쉽다고 생각하실 겁니다. 당신은 이와 같은 것을 기대하고 있다.

```js
const SearchResult = props => {
  let { book, selectBook, selected } = props;
 
  const initiallySelected = useRef(selected);
  const [sizingRef, currentHeight] = useHeight();
 
  const heightStyles = useSpring({
    config: { ...config.stiff, clamp: true },
    from: {
      opacity: initiallySelected.current ? 0 : 1,
      height: initiallySelected.current ? 0 : currentHeight,
      transform: "translate3d(0%, 0px, 0px)"
    },
    to: {
      opacity: selected ? 0 : 1,
      height: selected ? 0 : currentHeight,
      transform: `translate3d(${selected ? "25%" : "0%"},0px,0px)`
    }
  }); 
```

그러면 신뢰할 수 있는 `사용 높이` 후크를 사용하여 콘텐츠를 측정하고, `선택한` 값을 사용하여 나가는 항목을 애니메이션으로 만듭니다. 우리는 `선택한` 소품을 추적하고 있으며, 단순히 항목을 제거하고 전환을 사용하는 것이 아니라 이미 선택된 경우 0의 높이로 애니메이션화하거나 시작합니다. 이렇게 하면 동일한 책을 가진 다른 결과 집합이 선택된 경우 해당 결과 집합을 올바르게 표시하지 않을 수 있습니다.

이 코드는 효과가 있다. 이 데모에 한번 도전해 보세요.

하지만 마찰이 있어요. 결과 집합의 대부분의 책을 선택하면 계속 선택하면 일종의 통통 튀는 애니메이션 체인이 나타납니다. 이 책은 목록에서 애니메이션을 시작하고, 모달의 높이 자체가 뒤처지기 시작한다.

![image](https://i2.wp.com/css-tricks.com/wp-content/uploads/2020/07/react-spring-modal-bounce.gif?resize=746%2C552&ssl=1)

내가 보기에 이건 좀 우스꽝스러워 보이는데, 우리가 어떻게 할 수 있는지 보자.

우리는 이미 봄의 모든 애니메이션을 끄는데 `즉각적인` 속성을 사용할 수 있는 방법을 알고 있다. 우리는 또한 애니메이션이 끝났을 때 `on Rest` 콜백 화재를 본 적이 있는데, 여러분이 예상한 대로 할 수 있는 `on Start` 콜백이 있다는 것을 알게 되어도 놀라지 않을 것이라고 확신합니다. 모달 내부의 콘텐츠가 애니메이션 높이가 될 때 모달의 높이 애니메이션을 "끄도록" 허용해 보겠습니다.

먼저, 우리는 애니메이션을 켜고 끄는 모달에 상태를 추가할 것입니다.

```jsx
const animatModalSizing = useRef(true);
const modalSizingPacket = useMemo(() => {
  return {
    disable() {
      animatModalSizing.current = false;
    },
    enable() {
      animatModalSizing.current = true;
    }
  };
}, []);
```

자, 이제 이전과 같은 변화를 시작해보죠.

```jsx
const heightStyles = useSpring({
  immediate: !uiReady.current || !animatModalSizing.current,
  config: { ...config.stiff },
  from: { height: 0 },
  to: { height: contentHeight },
  onRest: () => (uiReady.current = true)
});
```

좋아요. 그럼 어떻게 하면 그 `모달 사이징 패킷`을 우리의 컨텐츠로 가져갈 수 있을까요? 우리가 렌더링하는 모든 것이 필요할 때 모달의 애니메이션을 끌 수 있을까요? 물론이지! 컨텍스트를 만들어 보겠습니다.

```js
export const ModalSizingContext = createContext(null);
```

그런 다음, 모달의 모든 콘텐츠를 이것으로 포장합니다.

```jsx
<ModalSizingContext.Provider value={modalSizingPacket}>
```

이제 SearchResult 구성 요소에서 다음을 수행할 수 있습니다.

```js
const { enable: enableModalSizing, disable: disableModalSizing } = useContext(
  ModalSizingContext
);
```

…봄에 바로 연결:

```jsx
const heightStyles = useSpring({
  config: { ...config.stiff, clamp: true },
  from: {
    opacity: initiallySelected.current ? 0 : 1,
    height: initiallySelected.current ? 0 : currentHeight,
    transform: "translate3d(0%, 0px, 0px)"
  },
  to: {
    opacity: selected ? 0 : 1,
    height: selected ? 0 : currentHeight,
    transform: `translate3d(${selected ? "25%" : "0%"},0px,0px)`
  },
  onStart() {
    if (uiReady.current) {
      disableModalSizing();
    }
  },
  onRest() {
    uiReady.current = true;
    setTimeout(() => {
      enableModalSizing();
    });
  }
});
```

맨 끝에 있는 `setTimeout`에 주목한다. 모든 게 해결될 때까지 모달의 애니메이션을 완전히 차단해야 한다는 걸 깨달았어요.

많은 코드였다는 거 알아 너무 빨리 움직이면 데모에서 이 모든 것이 제대로 작동하는지 확인하십시오.

### 선택한 책 애니메이션 제작(인)

모달 아래에 있는 메인 화면에 나타나는 선택된 책들을 애니메이션으로 마무리하겠습니다. 새로 선택한 책이 선택되면 왼쪽에서 미끄러져 들어오면서 페이드 인하게 하고, 제거되면 높이가 0으로 줄어드는 동안 오른쪽으로 미끄러져 나가도록 하자.

전환기를 쓰겠지만, 이미 문제가 있는 것 같습니다. 왜냐하면 선택된 책들 하나하나에 대한 설명이 필요하기 때문입니다. 각각의 책들이 각각의 높이를 가지고 있어야 하기 때문입니다. 이전에 "사용 전환"에 도달했을 때, 우리는 하나의 "시작"과 "종료" 오브젝트를 가지고 있었는데, 이 오브젝트는 항목의 출입에 적용되었다.

여기서는 대체 양식을 사용하여 `to` 개체에 대한 함수를 제공할 수 있습니다. 실제 애니메이션 항목(이 경우 북 객체)과 함께 호출되며 애니메이션 값이 포함된 `to` 개체를 반환합니다. 또한 각 책의 ID를 높이에 매핑하는 간단한 룩업 개체를 추적하여 전환에 연결합니다.

먼저 높이 값의 맵을 만들어 보겠습니다.

```jsx
const [displaySizes, setDisplaySizes] = useState({});
const setDisplaySize = useCallback(
  (_id, height) => {
    setDisplaySizes(displaySizes => ({ ...displaySizes, [_id]: height }));
  },
  [setDisplaySizes]
);
```

set DisplaySize 업데이트 기능을 selectedbook 구성 요소에 전달하여 useHeight와 함께 사용하여 각 책의 실제 높이를 보고할 예정입니다.

```jsx
const SelectedBook = props => {
  let { book, removeBook, styles, setDisplaySize } = props;
  const [ref, height] = useHeight();
  useLayoutEffect(() => {
    height && setDisplaySize(book._id, height);
  }, [height]);
```

호출하기 전에 높이 값이 실제 값으로 업데이트되었는지 확인하는 방법에 유의하십시오. 즉, 올바른 높이를 설정하기 전에 값을 0으로 미리 설정하지 않습니다. 그러면 콘텐츠가 완전한 형태로 미끄러지는 것이 아니라 애니메이션이 다운될 수 있습니다. 대신 처음에는 높이가 설정되지 않으므로 기본적으로 콘텐츠는 `높이:자동`으로 설정됩니다. 갈고리에 불이 붙으면 실제 높이가 정해집니다. 항목을 제거하면 희미해지고 미끄러져 나가면서 높이가 0으로 애니메이션화됩니다.

전환 후크는 다음과 같습니다.

```jsx
const selectedBookTransitions = useTransition(selectedBooks, {
  config: book => ({
    ...config.stiff,
    clamp: !selectedBooksMap[book._id]
  }),
  from: { opacity: 0, transform: "translate3d(-25%, 0px, 0px)" },
  enter: book => ({
    opacity: 1,
    height: displaySizes[book._id],
    transform: "translate3d(0%, 0px, 0px)"
  }),
  update: book => ({ height: displaySizes[book._id] }),
  leave: { opacity: 0, height: 0, transform: "translate3d(25%, 0px, 0px)" }
});
```

업데이트 콜백에 주목하십시오. 높이가 변경되면 내용을 조정할 수 있습니다. (책 묶음을 선택한 후 결과 창의 크기를 조정하여 데모에서 이 작업을 수행할 수 있습니다.)

케이크 위에 약간의 아이싱을 얹기 위해, 우리가 후크 구성의 `클램프` 속성을 어떻게 조건부로 설정하고 있는지 주목하세요. 콘텐츠가 애니메이션화되면서 `클램프`가 시작되는데, 이는 (적어도 내 생각으로는) 좋은 튕김 효과를 만들어 낸다. 하지만 떠날 때, 클램핑이 꺼진 상태로 전에 보았던 어떤 초조함도 없이, 아래로 움직이지만, 사라지지 않습니다.

### 보너스: 프로세스의 버그를 수정하면서 모달 높이 애니메이션 단순화

이 게시물을 마치고 나서, 저는 모달 구현에서 버그를 발견했습니다. 모달 높이가 표시되지 않을 때 모달 높이가 변경되면, 다음에 모달을 열 때 모달 애니메이션이 올바른 높이로 동작하는 이전 높이를 볼 수 있습니다. 내 말뜻을 보려면 데모 업데이트 내용을 보십시오. 새 단추가 표시되지 않을 때 결과를 삭제하거나 모달에 강제로 넣는 것을 볼 수 있습니다. 모달을 열고 닫은 다음 버튼을 클릭하여 결과를 추가한 다음 다시 엽니다. 모달은 새 높이와 정확하게 일치되지 않습니다.

이를 수정하면 이전부터 높이 애니메이션의 코드를 단순화할 수 있습니다. 문제는 우리의 모달은 현재 Retact 구성 요소 트리에서 표시되지 않더라도 계속 렌더링된다는 것이다. 높이 후크는 여전히 "실행 중"이며, 다음에 모형이 표시될 때만 업데이트되어 하위 모드가 됩니다. 모달의 아이들을 전용 부품으로 옮기고 키높이 고리를 가지고 오면 어떨까요? 이렇게 하면 후크 및 애니메이션 스프링은 모달 표시 시에만 렌더링되며 올바른 값으로 시작할 수 있습니다. 보기보다 덜 복잡해요. 현재 당사의 모달 구성 요소는 다음과 같습니다.

```jsx
<animated.div style={ overflow: "hidden", ...heightStyles }>
  <div style={ padding: "10px" } ref={activateRef}>
    <StandardModalHeader
      caption={headerCaption}
      onHide={onHide}
    />
    {children}
  </div>
</animated.div>
```

필요한 후크 및 참조 정보를 포함하여 이 마크업을 렌더링하는 새 구성 요소를 만들어 보겠습니다.

```jsx
const ModalContents = ({ header, contents, onHide, animatModalSizing }) => {
  const [sizingRef, contentHeight] = useHeight();
  const uiReady = useRef(false);

  const heightStyles = useSpring({
    immediate: !uiReady.current || !animatModalSizing.current,
    config: { ...config.stiff },
    from: { height: 0 },
    to: { height: contentHeight },
    onRest: () => (uiReady.current = true)
  });

  return (
    <animated.div style={ overflow: "hidden", ...heightStyles }>
      <div style={ padding: "10px" } ref={sizingRef}>
        <StandardModalHeader caption={header} onHide={onHide} />
        {contents}
      </div>
    </animated.div>
  );
};
```

이는 이전에 비해 복잡성이 크게 감소한 것입니다. 더 이상 activateRef 기능이 없으며 activateRef에서 설정된 heightOn 상태도 없습니다. 이 구성 요소는 표시되는 모달에서만 렌더링됩니다. 즉, 컨텐츠가 보장되므로 디브에 정규 참조를 추가할 수 있습니다. 불행하게도, 우리는 여전히 우리의 `uiReady` 상태가 필요하다. 왜냐하면 지금도 우리는 처음에 우리의 높이를 첫 번째 렌더링을 가지고 있지 않기 때문이다; 그것은 첫 번째 렌더링이 끝나면 바로 `사용 높이` 레이아웃 효과가 나타나기 전까지는 사용할 수 없다.

그리고 물론, 이것은 이전의 버그를 해결한다. 모달이 닫혔을 때 어떤 일이 일어나든, 다시 열리면 이 부품이 새롭게 렌더링되고, 우리의 봄은 `uiReady`에 대한 새로운 가치로 시작할 것이다.

### 이별의 생각

지금까지 내 곁에 있어준다면 고마워! 이 게시물이 길었다는 건 알지만, 당신이 그 게시물에서 가치를 찾았기를 바랍니다.

리액트 스프링은 리액트(React)로 강력한 애니메이션을 만들 수 있는 놀라운 도구입니다. 때로는 낮은 수준이 될 수 있으므로 사소한 사용 사례를 파악하기 어려울 수 있습니다. 하지만 이런 낮은 수준의 특성 때문에 유연성이 떨어집니다.