//
//  main.swift
//  DoubleLinkedList
//
//  Created by jc.kim on 10/13/22.
//

import Foundation


class Node<T> {
    var data: T
    var prev: Node<T>?
    var next: Node<T>?
    
    init(data: T, prev: Node<T>? = nil, next: Node<T>? = nil) {
        self.data = data
        self.prev = prev
        self.next = next
    }
}

class NodeManager<Int: Equatable> {
    var head: Node<Int>?
    var node: Node<Int>?
    
    init(data: Int) {
        self.head = Node(data: data)
    }
    
    func add(_ data: Int) {
        //1. 포인터를 타고 넘어갈 시작부분 할당
        self.node = self.head
        //2. 마지막 노드를 찾아감. while문을 통과하면 node는 데이터는 있고 다음 next는 nil인 마지막 노드를 가리키게 됨.
        while self.node?.next != nil {
            self.node = self.node?.next
        }
        //3. 마지막 노드에 데이터를 추가함. 생성자에 next = nil이 초기값으로 지정되어 있으므로 data만 추가하면 됨.
        self.node?.next = Node(data: data)
    }
    
    func delete(_ data: Int) {
        //1. 포인터를 타고 넘어갈 시작부분 할당
        self.node = self.head
        
        while self.node?.next != nil {
            //2. 삭제하고자 하는 노드 찾기
            if let unwrapData = self.node?.next?.data, unwrapData == data {
                self.node?.next = self.node?.next?.next
                return
            }
            self.node = self.node?.next
        }
    }
    
    func search(_ data: Int) {
        self.node = self.head
        
        while self.node?.next != nil {
            if let unwrapData = self.node?.data, unwrapData == data {
                print("\(unwrapData) 에 해당하는 데이터값이 있습니다. ")
                return
            }
            self.node = self.node?.next
        }
        
        print("해당하는 데이터값이 없습니다.")
    }
    
    func desc() {
        //순회 전에 제일 처음 초기값 할당
        self.node = self.head
        
        //가장 마지막 데이터 이전까지 출력
        while self.node?.next != nil {
            if let data = self.node?.data {
                print(data)
            }
            self.node = self.node?.next
        }
        
        //while문을 빠져나와서 마지막 데이터까지 출력하기
        if let data = self.node?.data {
            print(data)
        }
    }
}


let linkedList = NodeManager(data: 0)

print("\n==추가==")
(1...10).forEach { linkedList.add($0) }
linkedList.desc()

print("\n==검색==")
linkedList.search(4)

print("\n==삭제==")
linkedList.delete(3)
linkedList.desc()
