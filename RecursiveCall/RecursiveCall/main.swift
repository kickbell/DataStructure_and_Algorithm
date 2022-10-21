//
//  main.swift
//  RecursiveCall
//
//  Created by jc.kim on 10/21/22.
//

import Foundation


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
    

(1...10).forEach { print(factorial1($0)) }

print("\n===\n")

(1...10).forEach { print(factorial2($0)) }
