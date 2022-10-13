//
//  main.swift
//  LinkedList
//
//  Created by jc.kim on 10/13/22.
//

import Foundation


class Node {
    var data: Int
    var next: Node?
    
    init(data: Int, next: Node? = nil) {
        self.data = data
        self.next = next
    }
}

var node1 = Node(data: 1)
var node2 = Node(data: 2)
node1.next = node2
var head = node1


//입력
func add(data: Int) {
    var node: Node? = head
    
    while node!.next != nil {
        node = node?.next
    }

    node?.next = Node(data: data)
}

for index in 3...10 {
    add(data: index)
}


//출력
var node: Node? = head

while node!.next != nil {
    print(node?.data ?? 0)
    node = node!.next
}
print(node?.data ?? 0)



