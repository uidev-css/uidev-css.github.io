---
title: "카운팅 정렬 딜레마 속도와 자원 사용 균형 맞추는 방법"
description: ""
coverImage: "/assets/img/2024-06-21-TheCountingSortConundrumBalancingSpeedandResourceUsage_0.png"
date: 2024-06-21 20:31
ogImage: 
  url: /assets/img/2024-06-21-TheCountingSortConundrumBalancingSpeedandResourceUsage_0.png
tag: Tech
originalTitle: "The Counting Sort Conundrum: Balancing Speed and Resource Usage"
link: "https://medium.com/@gautam007/the-counting-sort-conundrum-balancing-speed-and-resource-usage-9e347f7abec2"
---


## 다트에서 카운팅 정렬 및 실용적인 응용 프로그램에 대해 깊이 파헤쳐보기

![이미지](/assets/img/2024-06-21-TheCountingSortConundrumBalancingSpeedandResourceUsage_0.png)

카운팅 정렬은 선형 시간에 작동하는 정수 정렬 알고리즘입니다. 원소의 범위(최대값과 최소 값의 차이)가 원소의 개수보다 크게 차이나지 않은 배열을 정렬하는 데 특히 효과적입니다. 카운팅 정렬은 각 고유한 요소의 발생 횟수를 세고, 이러한 요소들이 정렬된 배열에서의 위치를 계산하여 작동합니다.

# 카운팅 정렬 작동 방식

<div class="content-ad"></div>

- 범위 결정: 배열에서 최솟값과 최댓값을 찾아 요소들의 범위를 결정합니다.
- 발생 횟수 카운트: 각 고유 요소의 발생 횟수를 저장할 카운트 배열을 만듭니다.
- 위치 계산: 각 인덱스의 요소가 이전 카운트들의 합을 저장하도록 카운트 배열을 수정합니다. 이렇게 하면 정렬된 배열에서 요소의 위치를 알 수 있게 됩니다.
- 요소 배치: 카운트 배열에 지시된 대로 요소를 올바른 위치에 배치하여 출력 배열을 생성합니다.

# 카운팅 정렬 사용 시기

카운팅 정렬은 다음 경우에 특히 유용합니다:

- 정렬해야 하는 요소가 정수인 경우.
- 요소의 범위가 요소의 개수보다 크지 않은 경우.
- 선형 시간 복잡도를 갖는 비교 기반 정렬 알고리즘이 필요한 경우.

<div class="content-ad"></div>

# Counting Sort 알고리즘의 Dart 구현

Dart로 Counting Sort 알고리즘을 구현해봅시다.

```dart
void countingSort(List<int> arr) {
  if (arr.isEmpty) return;

  // Step 1: 최솟값과 최댓값 찾기
  int min = arr[0];
  int max = arr[0];
  for (int num in arr) {
    if (num < min) {
      min = num;
    } else if (num > max) {
      max = num;
    }
  }

  // Step 2: count 배열 생성
  int range = max - min + 1;
  List<int> count = List.filled(range, 0);

  // Step 3: 각 요소의 발생 횟수 세기
  for (int num in arr) {
    count[num - min]++;
  }

  // Step 4: 위치를 계산하기 위해 count 배열 수정
  for (int i = 1; i < count.length; i++) {
    count[i] += count[i - 1];
  }

  // Step 5: 정렬된 배열 작성
  List<int> output = List.filled(arr.length, 0);
  for (int i = arr.length - 1; i >= 0; i--) {
    int num = arr[i];
    output[count[num - min] - 1] = num;
    count[num - min]--;
  }

  // Step 6: 정렬된 요소를 원래 배열로 복사
  for (int i = 0; i < arr.length; i++) {
    arr[i] = output[i];
  }
}

void main() {
  List<int> arr = [4, 2, 2, 8, 3, 3, 1, 7];
  print("원본 배열: $arr");
  
  countingSort(arr);
  
  print("정렬된 배열: $arr");
}
```

# 코드 설명

<div class="content-ad"></div>

- 범위 찾기: 배열을 순회하여 최소값과 최대값을 찾습니다.
- Count 배열 생성: 범위를 계산하고 각 고유 요소의 개수를 저장하는 Count 배열을 생성합니다.
- 발생 회수 계산: 입력 배열을 순회하며 각 요소의 발생 회수로 Count 배열을 업데이트합니다.
- 위치 계산: 누적 카운트를 저장하는 Count 배열을 수정하여 정렬된 배열에서 요소의 위치를 결정하는 데 도움이 되게 합니다.
- 출력 배열 빌드: Count 배열을 기반으로 출력 배열에 요소를 올바른 위치에 배치합니다.
- 정렬된 요소 복사: 마지막으로, 정렬된 요소를 출력 배열에서 원래 배열로 복사합니다.

# 결론

Counting Sort는 요소의 범위가 제한적일 때 특히 효율적이고 간단한 정렬 알고리즘입니다. 선형 시간 복잡성은 특정 범위 내에서 대량의 데이터를 정렬하는 데 유용한 도구로 만들어줍니다. 제공된 Dart 구현은 Counting Sort를 실제 상황에 적용하는 방법을 보여주며 사용법과 이점을 명확히 전달하여 실용적인 예제를 제공합니다.