//
//  main.swift
//  Tree1
//
//  Created by jc.kim on 10/17/22.
//

import Foundation

class Node {
    var value: Int
    var left: Node? = nil
    var right: Node? = nil
    
    init(value: Int) {
        self.value = value
    }
}

class NodeMgmt {
    var rootNode: Node
    
    init(rootNode: Node) {
        self.rootNode = rootNode
    }
    
    func insert(value: Int) -> Int {
        //루트노드를 생성하고 현재 노드로 할당
        var currentNode: Node = self.rootNode
        
        while true {
            if value < currentNode.value {
                //새로 들어온 데이터가 현재 노드보다 작으면 왼쪽
                if currentNode.left == nil {
                    //currentNode.left가 nil이면 더이상 데이터가 없는것이니 새로운 노드를 만들어서 할당하면 끝
                    //while문을 빠져나가야 하니 break 필수
                    currentNode.left = Node(value: value)
                    return value
                } else {
                    //currentNode.left가 nil이 아니라면 데이터가 더 있다는거니까 기준이 되는 노드를 바꿔줘서 다시 비교를 해야함.
                    currentNode = currentNode.left!
                }
            } else {
                //새로 들어온 데이터가 현재 노드보다 크다면 오른쪽
                if currentNode.right == nil {
                    currentNode.right = Node(value: value)
                    return value
                } else {
                    currentNode = currentNode.right!
                }
            }
        }
    }
    
    
    func search(value: Int) -> Bool {
        //맨 위부터 내려가야되니까 초기값을 할당해준건데, 위와는 다르게 옵셔널로 해준이유는 while문을 끝까지 돌게 하려고 한거야.
        //currentNode 가 nil이라는 말은
        var currentNode: Node? = self.rootNode
        
        while currentNode != nil {
            guard let cNode = currentNode else { break }
            if cNode.value == value {
                return true
            } else if value < cNode.value { //파라미터가 현재 노드의 값보다 작으면 왼쪽, 계속 순회
                currentNode = cNode.left
            } else {
                currentNode = cNode.right //파라미터가 현재 노드의 값보다 크면 오른쪽, 계속 순회
            }
            
            //이렇게 들어갔다가 제일 마지막 노드는 left, right에 값이 없겠지 ? insert 에서 안넣어줬고 초기값이 nil 이니까
            //그러면 while 문은 종료가 되고 이 다음줄로 넘어가서 false를 리턴하는거야. 
        }
        return false
    }
}


let rootNode = Node(value: 13)
let bst = NodeMgmt(rootNode: rootNode)

print("\n=== insert ===")
print(bst.insert(value: 21))
print(bst.insert(value: 15))
print(bst.insert(value: 25))
print(bst.insert(value: 42))
print(bst.insert(value: 33))


print("\n=== search ===")
print(bst.search(value: 25))



