//
//  main.swift
//  PriorityQueue
//
//  Created by jc.kim on 10/12/22.
//

import Foundation

struct PriorityQueue<T> {
    
    private var priorityQueue: [(priority: Int, data: T)] = []

    mutating func enqueue(_ tuple: (priority: Int, data: T)) {
        priorityQueue.append(tuple)
    }

    mutating func dequeue() -> (Int, T)? {
        guard !priorityQueue.isEmpty else { return nil }
        priorityQueue.sort { $0.priority < $1.priority }
        return priorityQueue.removeFirst()
    }
}

var priorityQueue = PriorityQueue<String>()

priorityQueue.enqueue((priority: 5, data: "hello"))
priorityQueue.enqueue((priority: 15, data: "bear"))
priorityQueue.enqueue((priority: 3, data: "zz"))

print(priorityQueue.dequeue() ?? (0, ""))
print(priorityQueue.dequeue() ?? (0, ""))
print(priorityQueue.dequeue() ?? (0, ""))
print(priorityQueue.dequeue() ?? (0, ""))

