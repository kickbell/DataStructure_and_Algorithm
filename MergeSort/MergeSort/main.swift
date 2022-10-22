//
//  main.swift
//  MergeSort
//
//  Created by jc.kim on 10/22/22.
//

import Foundation

//1. 분할(Divide)
func split(_ array: [Int]) -> [Int] {
    if array.count <= 1 { return array }
    
    let medium = array.count / 2
    let left = split(Array(array[..<medium]))
    let right = split(Array(array[medium...]))

    return merge(left, right)
}

//2. 정복(Conquer)
func merge(_ left: [Int], _ right: [Int]) -> [Int] {
    var merged: [Int] = []
    var leftIndex = 0
    var rightIndex = 0
    
    //case 1: left, right가 아직 남아있을 때
    while left.count > leftIndex && right.count > rightIndex {
        if left[leftIndex] > right[rightIndex] {
            merged.append(right[rightIndex])
            rightIndex += 1
        } else {
            merged.append(left[leftIndex])
            leftIndex += 1
        }
    }
    //case 2: left만 남아있을 때
    while left.count > leftIndex {
        merged.append(left[leftIndex])
        leftIndex += 1
    }
    
    //case 3: right만 남아있을 때
    while right.count > rightIndex {
        merged.append(right[rightIndex])
        rightIndex += 1
    }
    
    return merged
}

func mergeSort(_ array: [Int]) -> [Int] {
    return split(array)
}



print("\n===mergeSort===")

let list = (1...10).map { _ in Int.random(in: 1...100)}
print(mergeSort(list))

