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

class NodeManager<Double: Equatable> {
    var head: Node<Double>?
    var tail: Node<Double>?
    var node: Node<Double>?
    
    init(data: Double) {
        self.head = Node(data: data)
    }
    
    func add(_ data: Double) {
        //1. 포인터를 타고 넘어갈 시작부분 할당
        self.node = self.head
        //2. 마지막 노드를 찾아감. while문을 통과하면 node는 데이터는 있고 다음 next는 nil인 마지막 노드를 가리키게 됨.
        while self.node?.next != nil {
            self.node = self.node?.next
        }
        //3. 마지막 노드에 데이터를 추가함. 생성자에 next = nil이 초기값으로 지정되어 있으므로 data만 추가하면 됨.
        let newNode = Node(data: data)
        self.node?.next = newNode
        //4. 앞뒤로 포인터를 연결해줘야 하므로 prev에도 node를 할당
        newNode.prev = self.node
        //5. tail도 할당
        self.tail = newNode
    }
    
    //연습3: 위 코드에서 노드 데이터가 특정 숫자인 노드 앞에 데이터를 추가하는 함수를 만들고, 테스트해보기</font></strong><br>
    //- 더블 링크드 리스트의 tail 에서부터 뒤로 이동하며, 특정 숫자인 노드를 찾는 방식으로 함수를 구현하기<br>
    //- 테스트: 임의로 0 ~ 9까지 데이터를 링크드 리스트에 넣어보고, 데이터 값이 2인 노드 앞에 1.5 데이터 값을 가진 노드를 추가해보기
    func insert(_ data: Double, beforeData: Double) {
        self.node = self.tail //1. 뒤에서 부터 갈거니까 tail 할당
        
        //2. beforeData앞에 넣을거니까 그걸 먼저 찾는다. 다르다면 한칸 앞으로 이동
        while self.node!.data != beforeData {
            self.node = self.node?.prev
            if node?.prev == nil { //맨 앞까지 왔다면 해당 데이터가 없는거니까 그냥 break
                print("해당 beforeData : \(beforeData) 는 존재하지 않습니다.")
                return
            }
        }
        
        //3. 여기까지 왔다면 self.node == beforeData를 갖는 노드라는 말이야. 이 애 앞에 새로운 데이터를 넣을거야.
        let preNode = node?.prev
        let newNode = Node(data: data)
        
        //4. 새로만든 노드의 next 포인터 수정작업
        preNode?.next = newNode
        newNode.prev = preNode
        
        //5. 새로만든 노드의 prev 포인터 수정작업
        newNode.next = self.node
        self.node?.prev = newNode
    }
        
    enum Direction {
        case forward
        case backward
    }
    
    func search(_ direction: Direction, _ data: Double) {
        switch direction {
        case .forward:
            self.node = self.head
            
            while self.node?.next != nil {
                if let unwrapData = self.node?.data, unwrapData == data {
                    print("\(unwrapData) 에 해당하는 데이터값이 있습니다. ")
                    return
                }
                self.node = self.node?.next
            }
        case .backward:
            self.node = self.tail
            
            while self.node?.prev != nil {
                if let unwrapData = self.node?.data, unwrapData == data {
                    print("\(unwrapData) 에 해당하는 데이터값이 있습니다. ")
                    return
                }
                self.node = self.node?.prev
            }
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


let linkedList = NodeManager(data: 0.0)

print("\n==추가==")
(1...10).map { Double($0)}
    .forEach{ linkedList.add($0) }
linkedList.desc()

print("\n==검색==")
linkedList.search(.forward, 5)
linkedList.search(.backward, 8)

print("\n==중간에 데이터 추가==")
linkedList.insert(5.5, beforeData: 6)
linkedList.desc()
