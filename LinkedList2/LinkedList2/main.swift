//
//  main.swift
//  LinkedList2
//
//  Created by jc.kim on 10/13/22.
//

import Foundation

class Node<T> {
    var data: T
    var pointer: Node<T>?
    
    init(data: T, pointer: Node<T>? = nil) {
        self.data = data
        self.pointer = pointer
    }
}

class NodeManager<T> {
    var head: Node<T>
    var node: Node<T>?
    
    init(data: T) {
        self.head = Node(data: data)
    }
    
    func add(_ data: T) {
        node = head //처음 노드 할당
        
        while node?.pointer != nil { //마지막 노드를 찾을때까지 반복
            node = node?.pointer
        }
        
        node?.pointer = Node(data: data) //마지막 노드찾음 ㅇㅋ
    }
    
    //단순 전체 데이터 출력 용도 메소드
    func desc() {
        node = head // add하면서 node값이 달라졌으므로 첫노드로 다시 할당
        
        while node != nil { //노드가 비어있지 않다면 반복
            guard let unwrapNode = node else { return }
            print(unwrapNode.data)
            node = node?.pointer
        }
    }
}


let linkedList = NodeManager(data: 0)

(10...15).forEach {
    linkedList.add($0)
}

linkedList.desc()





//while 문
//var count = 0
//while count < 10 { // 이 조건인 동안만 아래 스코프를 타라.
//    print(count)
//    count += 1
//}



