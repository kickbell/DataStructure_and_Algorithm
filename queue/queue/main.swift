//
//  main.swift
//  queue
//
//  Created by jc.kim on 10/12/22.
//

import Foundation


//Queue()

var queue: [Int] = []

func enqueue(_ data: Int) {
    queue.append(data)
}

func dequeue() -> Int {
    if let _ = queue.first {
        return queue.removeFirst()
    }
    return -1
}

(1...10).forEach {
    enqueue($0)
}

print(queue)
print(dequeue())
print(dequeue())
print(dequeue())


//LifoQueue()

//PriorityQueue()

