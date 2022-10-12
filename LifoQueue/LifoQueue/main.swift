//
//  main.swift
//  LifoQueue
//
//  Created by jc.kim on 10/12/22.
//

import Foundation

struct LifoQueue<T> {
    private var queue: [T] = []

    mutating func enqueue(_ data: T) {
        queue.append(data)
    }

    mutating func dequeue() -> T? {
        if let _ = queue.last {
            return queue.removeLast()
        }
        return nil
    }
}


var queue = LifoQueue<String>()

(1...10).map { String($0)}
    .forEach {
        queue.enqueue($0)
    }

print(queue)
print(queue.dequeue() ?? "")
print(queue.dequeue() ?? "")
print(queue.dequeue() ?? "")

