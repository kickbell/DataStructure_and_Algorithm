//
//  main.swift
//  QuickSort
//
//  Created by jc.kim on 10/22/22.
//

import Foundation

func quickSort1(_ array: [Int]) -> [Int] {
    if array.count <= 1 { return array }
    
    var left: [Int] = []
    var right: [Int] = []
    let pivot = array.first ?? 0
    
    //pivot이 0번째니까 array.count까지가 아니라 1번째부터 array.count - 1 까지다.
    for index in 1...array.count - 1 {
        if pivot > array[index] {
            left.append(array[index])
        } else {
            right.append(array[index])
        }
    }
    
    return quickSort1(left) + [pivot] + quickSort1(right)
}


func quickSort2(_ array: [Int]) -> [Int] {
    if array.count <= 1 { return array }
    
    let pivot = array.first ?? 0
    let left = array[1...].filter { pivot > $0 }
    let right = array[1...].filter { pivot <= $0 }
    
    return quickSort2(left) + [pivot] + quickSort2(right)
}


print("\n===QuickSort===")

let list = (1...10).map { _ in Int.random(in: 1...100) }
print(list)

print(quickSort1(list))
print(quickSort2(list))

