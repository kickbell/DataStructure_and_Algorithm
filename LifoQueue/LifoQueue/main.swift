//
//  main.swift
//  LifoQueue
//
//  Created by jc.kim on 10/12/22.
//

import Foundation


var lifoQueue: [Int] = []

func enqueue(_ data: Int) {
    lifoQueue.append(data)
}

func dequeue() -> Int {
    if let _ = lifoQueue.last {
        return lifoQueue.removeLast()
    }
    return -1
}

(1...10).forEach {
    enqueue($0)
}

print(lifoQueue)
print(dequeue())
print(dequeue())
print(dequeue())

