//
//  main.swift
//  SelectionSort
//
//  Created by jc.kim on 10/21/22.
//

import Foundation

/*
 선택정렬
 https://visualgo.net/en/sorting
 
 1. 주어진 데이터 중 첫번째꺼와 비교해서 일단 최소값을 찾음
 2. 최소값을 찾는데, 첫번째꺼보다 작다면 작은걸로 즉시 최소값 위치가 바뀌는 것임.
 3. 해당 최소값을 데이터 맨 앞에 위치한 값과 교체함
 4. 맨 앞의 위치를 뺀 나머지 데이터를 동일한 방법으로 반복함
 */


func selectionSort(_ array: [Int]) -> [Int] {
    var result = array
    
    for standIndex in 0..<array.count - 1 { //첫번째를 기준으로 나머지하고 비교하는거니까 4개의 배열이면 0,1,2 로 3개면 됨.
        
        //1. 최소값 찾기
        //최소값의 기준이 되는 minIndex를 만들고 시작점인 standIndex를 할당함
        var minIndex = standIndex
        //제일첫번째(minIndex 또는 standIndex)와 그 다음부터 비교해야하니 (standIndex + 1) 라고 지정함.
        for index in (standIndex + 1)..<array.count {
            //[9, 3, 2, 1] 이라고 할 때, 9가 3보다 크다면 9보다 3이 최소값인 거니까 최소값의 인덱스를 3의 인덱스로 바꿔줌
            //어디까지? 끝까지. 그래서 최소값을 찾는것임. 최소값의 index는 miniIndex가 되어야 겠지.
            if result[minIndex] > result[index] {
                minIndex = index
            }
        }
        
        //2. 최소값을 기준점과 swap하기
        //최소값을 찾았으니 현재의 index(standIndex)와 찾은 최소값을 index(minIndex)의 데이터를 스왑해줌
        result.swapAt(minIndex, standIndex)
    }
    
    return result
}



var list: Set<Int> = []

while list.count < 50 {
    let randomInt = Int.random(in: 1...100)
    list.insert(randomInt)
}

print(list)

print("\n===insertSort===")
print(selectionSort(Array(list)))
