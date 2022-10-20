//
//  main.swift
//  Sort
//
//  Created by jc.kim on 10/18/22.
//

import Foundation

func processTime(closure: () -> ()){
    let start = CFAbsoluteTimeGetCurrent()
    closure()
    let processTime = CFAbsoluteTimeGetCurrent() - start
    print("경과 시간: \(processTime)")
}


/*
 버블정렬 1
 https://visualgo.net/en/sorting
 
 예: data_list = [1, 9, 3, 2]
 1차 로직 적용
     1 와 9 비교, 자리바꿈없음 [1, 9, 3, 2]
     9 와 3 비교, 자리바꿈 [1, 3, 9, 2]
     9 와 2 비교, 자리바꿈 [1, 3, 2, 9]
 2차 로직 적용
     1 와 3 비교, 자리바꿈없음 [1, 3, 2, 9]
     3 과 2 비교, 자리바꿈 [1, 2, 3, 9]
     3 와 9 비교, 자리바꿈없음 [1, 2, 3, 9]
 3차 로직 적용
     1 과 2 비교, 자리바꿈없음 [1, 2, 3, 9]
     2 과 3 비교, 자리바꿈없음 [1, 2, 3, 9]
     3 과 9 비교, 자리바꿈없음 [1, 2, 3, 9]
 
 bubblesort1 의 핵심은 일단 array.count - 1 만 순회한다는 것이다.
 배열의 길이가 4라면 4 * 4 가 아니라 3 * 3 회 순회한다.
 그래야 result[index2] > result[index2 + 1] 로직이 정상적으로 동작한다.
 */

func bubblesort1(_ array: [Int]) -> [Int] {
    var result = array
    
    for _ in 0..<array.count - 1 {
        for index2 in 0..<array.count - 1 {
            if result[index2] > result[index2 + 1] {
                result.swapAt(index2, index2 + 1)
            }
        }
    }
    
    return result
}

//print("===before bubble sort1===")
//print([1,9,3,2])
//
//print("===after bubble sort1===")
//print(bubblesort1([1,9,3,2]))




/*
 코드 최적화작업 1
 
 [1, 9, 3, 2] 를 정렬할 때, 1 cycle을 다 돌면 [1, 3, 2, 9]로 제일 오른쪽 숫자는 가장 큰 숫자가 된다.
 그 말은 2 cycle을 돌면 제일 오른쪽 - 1 의 숫자는 두번째로 큰 숫자가 된다는 거고, 3 cycle을 돌면 제일 오른쪽 - 2 의 숫자는 세번째로 큰 숫자가 된다는 거다.
 쉽게 말하면 그거다.
 [1, 9, 3, 2] 일 때, 1 cycle 은 3 회를 돌면 된다.
 2 cycle 은 2회만 돌면 된다.
 3 cycle 은 1회만 돌면 된다.
 왜? 1 cycle 을 반복할 때마다 제일 오른쪽 숫자가 정렬이 되서 가장 큰 숫자가 되니까.
 그러면 아래와 같이 코드를 최적화 할 수 있다.
 
 아래에서 processTime 을 측정해보면 실제로 시간이 덜 걸린다. 반정도?
 */
func bubblesort2(_ array: [Int]) -> [Int] {
    var result = array
    
    for index1 in 0..<array.count - 1 { //여기는 전체 포문이니까 무시하고
        for index2 in 0..<array.count - 1 - index1 { //결국엔 여기다.
            //첫번째 0, 두번째 1, 세번째 2 하면 딱 맞다.
            if result[index2] > result[index2 + 1] {
                result.swapAt(index2, index2 + 1)
            }
        }
    }
    
    return result
}

var list: Set<Int> = []

while list.count < 50 {
    let randomInt = Int.random(in: 1...100)
    list.insert(randomInt)
}

print("===before bubble sort2===")
print(list)

print("===after bubble sort2===")
processTime { print(bubblesort1(Array(list))) }
processTime { print(bubblesort2(Array(list))) }


