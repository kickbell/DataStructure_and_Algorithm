//
//  main.swift
//  Stack
//
//  Created by jc.kim on 10/13/22.
//

import Foundation


struct Stack<T> {
    private var stackArray: [T] = []

    mutating func push(data: T) {
        stackArray.append(data)
    }

    mutating func pop() -> T? {
        let data = stackArray.last ?? nil
        stackArray.removeLast()
        return data
    }
}


var stack = Stack<Int>()

stack.push(data: 1)
stack.push(data: 2)
stack.push(data: 3)

print(stack.pop() ?? 0)
print(stack.pop() ?? 0)
print(stack.pop() ?? 0)


