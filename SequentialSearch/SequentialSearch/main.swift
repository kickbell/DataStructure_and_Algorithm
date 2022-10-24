//
//  main.swift
//  SequentialSearch
//
//  Created by jc.kim on 10/25/22.
//

import Foundation

func sequencial(_ array: [Int], searchData: Int) -> Int {
    for index in 0..<array.count {
        if array[index] == searchData { return index } //찾는 데이터의 index 반환
    }
    return -1 //찾는 데이터 없음
}

let list = (1...10).map { _ in Int.random(in: 1...100) }
//print(list)

(1...10).forEach { _ in
    print(sequencial(list, searchData: Int.random(in: 1...100)))
}



