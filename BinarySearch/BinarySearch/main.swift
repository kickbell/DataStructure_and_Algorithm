//
//  main.swift
//  BinarySearch
//
//  Created by jc.kim on 10/25/22.
//

import Foundation

func binarySearch(_ array: [Int], searchData: Int) -> Bool {
    //제일 마지막까지 데이터를 나누고 마지막 데이터가 찾는 데이터인 경우
    if array.count == 1 && searchData == array.first ?? 0 { return true }
    //제일 마지막까지 데이터를 나누고, 찾는 데이터가 없는 경우
    if array.count == 1 && searchData != array.first ?? 0 { return false }
    
    let mediumIndex = array.count / 2
    
    //제일 마지막까지 나누지 않았어도 데이터를 찾은 경우
    if searchData == array[mediumIndex] { return true }
    
    //그렇지 않은 경우
    if searchData > array[mediumIndex] {
        return binarySearch(Array(array[mediumIndex...]), searchData: searchData)
    } else {
        return binarySearch(Array(array[..<mediumIndex]), searchData: searchData)
    }
}

let sortedList = (1...10).map { _ in Int.random(in: 1...100) }.sorted()
print(sortedList)

print(binarySearch(sortedList, searchData: 7))
print(binarySearch([11, 17, 23, 49, 51, 77, 83, 90, 90, 92], searchData: 90))


