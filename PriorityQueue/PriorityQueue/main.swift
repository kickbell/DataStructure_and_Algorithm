//
//  main.swift
//  PriorityQueue
//
//  Created by jc.kim on 10/12/22.
//

import Foundation

var priorityQueue: [(priority: Int, data: String)] = []

func enqueue(_ tuple: (priority: Int, data: String)) {
    priorityQueue.append(tuple)
}

func dequeue() -> (Int, String) {
    guard !priorityQueue.isEmpty else { return (-1, "") }
    priorityQueue.sort { $0.priority < $1.priority }
    return priorityQueue.removeFirst()
}

enqueue((priority: 5, data: "hello"))
enqueue((priority: 15, data: "bear"))
enqueue((priority: 3, data: "zz"))

print(dequeue())
print(dequeue())
print(dequeue())
print(dequeue())

