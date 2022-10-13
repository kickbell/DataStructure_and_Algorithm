//
//  main.swift
//  LinkedList2
//
//  Created by jc.kim on 10/13/22.
//

import Foundation

class Node<T> {
    var data: T
    var next: Node?
    
    init(_ data: T, next: Node? = nil) {
        self.data = data
        self.next = next
    }
}

class NodeMgmt<T> {
    var head: Node<T>?
    var node: Node<T>?
    
    init(data: T) {
        self.head = Node(data)
    }
    
    func add(data: T) {
        if self.head == nil {
            self.head = Node(data)
        } else {
            node = self.head
            while node!.next != nil {
                node = node?.next
            }
            node?.next = Node(data)
        }
    }
    
    func desc() {
        node = self.head
        while node != nil {
            print(node!.data)
            node = node?.next
        }
    }
}



let linkedList = NodeMgmt(data: 0)

for data in 1...10 {
    linkedList.add(data: data)
}

linkedList.desc()


