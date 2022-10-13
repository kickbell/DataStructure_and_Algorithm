//
//  main.swift
//  LinkedList2
//
//  Created by jc.kim on 10/13/22.
//

import Foundation

class Node<T: Equatable> {
    var data: T
    var pointer: Node<T>?
    
    init(data: T, pointer: Node<T>? = nil) {
        self.data = data
        self.pointer = pointer
    }
}

class NodeManager<T> {
    var head: Node<Int>?
    var node: Node<Int>?
    
    init(data: Int) {
        self.head = Node(data: data)
    }
    
    func add(_ data: Int) {
        node = self.head //처음 노드 할당
        
        while node?.pointer != nil { //마지막 노드를 찾을때까지 반복
            node = node?.pointer
        }
        
        node?.pointer = Node(data: data) //마지막 노드찾음 ㅇㅋ
    }
    
    //특정 데이터 삭제하기
    func delete(_ data: Int) {
        if self.head!.data == data { //1. 맨앞에 있는 애를 삭제하는 경우 (헤드를 삭제하는 경우)
            self.head = self.head!.pointer
        } else { //2. 마지막에 있는 애를 삭제하는 경우, 3. 중간에 있는 애를 삭제하는 경우
            node = self.head
            while node?.pointer != nil {
                if node!.pointer!.data == data {
                    node?.pointer = node?.pointer?.pointer
                } else {
                    node = node?.pointer
                }
            }
        }
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

let linkedList = NodeManager<Int>(data: 0)

print("데이터 추가 후 출력======================================================")

for data in 1...10 {
    linkedList.add(data)
}
linkedList.desc()

print("4 삭제 확인======================================================")

linkedList.delete(4)

linkedList.desc()

print("10 삭제 확인======================================================")

linkedList.delete(10)

linkedList.desc()




//while 문
//var count = 0
//while count < 10 { // 이 조건인 동안만 아래 스코프를 타라.
//    print(count)
//    count += 1
//}



