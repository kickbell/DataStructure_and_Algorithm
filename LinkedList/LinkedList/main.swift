//
//  main.swift
//  LinkedList
//
//  Created by jc.kim on 10/13/22.
//

import Foundation

//왜 구조체로 안하고 클래스로 만들까?
//포인터 때문이 확실.. 구조체는 복사되니까.

class Node {
    var data: Double
    var next: Node?
    
    init(data: Double, next: Node? = nil) {
        self.data = data
        self.next = next
    }
}

var node1 = Node(data: 1)
var node2 = Node(data: 2)
node1.next = node2
var head = node1


//입력
func add(data: Double) {
    var node: Node? = head
    
    while node!.next != nil {
        node = node?.next
    }

    node?.next = Node(data: data)
}

for index in 3...10 {
    add(data: Double(index))
}


//출력
var node: Node? = head

while node!.next != nil {
    print(node?.data ?? 0)
    node = node!.next
}
print(node?.data ?? 0)




//중간에 데이터 추가하기

var node3 = Node(data: 3.5)
node = head
var search = true

while search {
    if node?.data == 3.0 {
        search = false
    } else {
        node = node?.next
    }
}

let nonext = node?.next
node?.next = node3
node3.next = nonext


print("==================================================================")


//출력
node = head

while node!.next != nil {
    print(node?.data ?? 0)
    node = node!.next
}
print(node?.data ?? 0)





