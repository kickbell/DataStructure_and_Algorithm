//
//  main.swift
//  Sort
//
//  Created by jc.kim on 10/18/22.
//

import Foundation



func bubblesort(_ array: [Int]) -> [Int] {
    var result = array
    
    for index1 in 0..<(array.count - 1) {                // 스캔 작업 반복
        var isSwap = false
        for index2 in 0..<((array.count - index1) - 1) { // 스캔 작업(인접 인덱스 비교 및 swap 반복) : (탐색하려는 요소의 갯수) - 1 => 탐색하려는 요소의 갯수는 스캔 횟수에 따라 차감됨(스캔 횟수만큼 정렬되어 있을테니)
            if result[index2] > result[index2 + 1] {
                result.swapAt(index2, (index2 + 1))
                isSwap = true
            }
        }
        if isSwap == false { break }
    }
    
    return result
}



var list: Set<Int> = []

while list.count < 50 {
    let randomInt = Int.random(in: 1...100)
    list.insert(randomInt)
}

print("===before bubble sort===")
print(list)

print("===after bubble sort===")
print(bubblesort(Array(list)))




