//
//  main.swift
//  MergeSort
//
//  Created by jc.kim on 10/22/22.
//

import Foundation


func split(_ array: [Int]) -> [Int] {
    if array.count <= 1 { return array }
    
    let medium = array.count / 2
    let left = split(Array(array[..<medium]))
    let right = split(Array(array[medium...]))

    return merge(left, right)
}

func merge(_ left: [Int], _ right: [Int]) -> [Int] {

    return []
}


split([4,5,6,3,9])


