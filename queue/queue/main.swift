//
//  main.swift
//  queue
//
//  Created by jc.kim on 10/12/22.
//

import Foundation


struct Queue<T> {
    private var queue: [T] = []

    mutating func enqueue(_ data: T) {
        queue.append(data)
    }

    mutating func dequeue() -> T? {
        if let _ = queue.first {
            return queue.removeFirst()
        }
        return nil
    }
}


var queue = Queue<String>()

(1...10).map { String($0)}
    .forEach {
        queue.enqueue($0)
    }

print(queue)
print(queue.dequeue() ?? "")
print(queue.dequeue() ?? "")
print(queue.dequeue() ?? "")

