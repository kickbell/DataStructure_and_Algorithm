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

//1. 추가할 데이터 생성, 헤드값 초기화. 맨처음부터 다시 돌아야 되니까
var node3 = Node(data: 3.5)
node = head

//2. 어디에 넣을지 찾는 변수 추가
var search = true

//3. 어디에 넣을지 찾기.
// 그 이전까지는 주소값을 넣어주다가 3을 찾으면 종료시켜버림.
// 중요한 것은 1 + 주소값, 2 + 주소값, 3 -> 종료이기 때문에
// 4,5,6,7,8.. 같은애들애는 주소값이 없어. 즉, 미리 데이터가 다 들어가있는 상황에서
// 중간에 데이터를 삽입할때 쓰는 방법이라는 말임.
while search {
    if node?.data == 3.0 {
        search = false
    } else {
        node = node?.next
    }
}

//4. 새로 넣을 데이터에 주소값 연결하기
// 자, 보면
// 지금 node.next는 원래 3->4 를 가리키던 주소값임.
// 그래서 일단 그걸 다른 변수에 담아놓는다.
let lastNext = node?.next
node?.next = node3 // 그리고 가리키는 값을 node3이 가리키도록 바꿔.
node3.next = lastNext // 그리고 마지막으로 node3이 4(lastNext)를 가리키도록 바꿔준다.


print("==================================================================")


//출력
node = head

while node!.next != nil {
    print(node?.data ?? 0)
    node = node!.next
}
print(node?.data ?? 0)





