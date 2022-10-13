//
//  main.swift
//  Stack
//
//  Created by jc.kim on 10/13/22.
//

import Foundation


//simple, use array

var stackArray: [Int] = []

func push(data: Int) {
    stackArray.append(data)
}

func pop() -> Int {
    let data = stackArray.last ?? 0
    stackArray.removeLast()
    return data
}


push(data: 1)
push(data: 2)
push(data: 3)

print(pop())
print(pop())
print(pop())

