//
//  main.swift
//  RecursiveCall
//
//  Created by jc.kim on 10/21/22.
//

import Foundation

/*
 보통 1,2번과 같은 2가지 패턴으로 많이 쓰인다.
 주로 2번이 더 많이 쓰이는 것 같고.. 자기 자신을 호출하는데 꼭 -1 하거나 +1 하거나 그러곤 하지.
 */
func factorial1(_ num: Int) -> Int {
    if num > 1 {
        return num * factorial1(num - 1)
    } else {
        return num
    }
}

func factorial2(_ num: Int) -> Int {
    if num <= 1 { return num }
    return num * factorial2(num - 1)
}
    

print("\n===factorial===")
(1...10).forEach { print(factorial1($0)) }
(1...10).forEach { print(factorial2($0)) }



//1부터 num까지의 곱
//1*2*3*4*5와 같다.
func multiple1(_ num: Int) -> Int {
    var result = 1
    for index in 1...num {
        result *= index //result = result * index 와 같은 것
    }
    return result
}


func multiple2(_ num: Int) -> Int {
    if num <= 1 { return num }
    return num * multiple2(num - 1)
}

print("\n===multiple===")
print(multiple1(5))
print(multiple2(5))


//숫자가 들어가있는 리스트가 있을 때 그 합을 구해라

let list = [1,2,3,4,5]

func sumList1(_ array: [Int]) -> Int {
    var result = 0
    for num in array {
        result += num
    }
    return result
}

func sumList2(_ array: [Int]) -> Int {
    return array.reduce(0, +)
}

func sumList3(_ array: [Int]) -> Int {
    var result = array
    if result.count <= 1 { return result.first ?? 0 }
    return result.removeFirst() + sumList3(result) //이렇게도 할 수 있고
}

func sumList4(_ array: [Int]) -> Int {
    let result = array
    if result.count <= 1 { return result.first ?? 0 }
    return (result.first ?? 0) + sumList4(Array(result[1...])) //이렇게 처리할 수도 있겠습니다.
}

print("\n===sumList===")
print(sumList1(list))
print(sumList2(list))
print(sumList3(list))
print(sumList4(list))
