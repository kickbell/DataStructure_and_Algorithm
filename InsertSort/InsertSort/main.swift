//
//  main.swift
//  InsertSort
//
//  Created by jc.kim on 10/21/22.
//

import Foundation

/*
 삽입정렬
 https://visualgo.net/en/sorting
 
 버블정렬하고 약간 비슷한데 다르기도 하다.
 
 [1,9,3,2] 가 있다고 하면, 일단 두번째 녀석부터 시작한다. 여기서는 9.
 그리고 9를 1과 비교한다. 앞에가 더 작으면 멈추고 아니면 스왑한다.
 언제까지? 자기보다 작은애가 나올때까지.
 
 */


func insertSort(_ array: [Int]) -> [Int] {
    var result = array
    
    for index in 0..<array.count - 1 { //전체 데이터 킉 - 1 만큼 순회
        
        //swift 는 for문 reverse를 위해서 stride 함수를 사용한다.
        //되게 중요한 부분인데, index는 0,1,2,3...이면 위에도 말했듯이 두번째꺼를 기준으로 첫번째꺼와 비교하면서 시작하니까
        //from : index + 1 부터 to : 0 번째 까지 비교해라. 다돌면 by : -1 씩 내려라 뭐 그런 뜻이다.
        for index2 in stride(from: index + 1, to: 0, by: -1) {
            //그래서 index : 0 , index2 : 1 이고, result[1](오른쪽) < result[0](왼쪽) 보다 작으면 스왑이다.
            //약간 헷갈릴 수 있는 부분이다.
            if result[index2] < result[index2 - 1] {
                result.swapAt(index2, index2 - 1)
            } else {
                break
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

print(list)

print("\n===insertSort===")
print(insertSort(Array(list)))
