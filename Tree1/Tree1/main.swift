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
    
    func insert(value: Int) {
        //루트노드를 생성하고 현재 노드로 할당
        var currentNode = self.rootNode
        
        while true {
            if value < currentNode.value {
                //새로 들어온 데이터가 현재 노드보다 작으면 왼쪽
                if currentNode.left == nil {
                    //currentNode.left가 nil이면 더이상 데이터가 없는것이니 새로운 노드를 만들어서 할당하면 끝
                    //while문을 빠져나가야 하니 break 필수
                    currentNode.left = Node(value: value)
                    break
                } else {
                    //currentNode.left가 nil이 아니라면 데이터가 더 있다는거니까 기준이 되는 노드를 바꿔줘서 다시 비교를 해야함.
                    currentNode = currentNode.left!
                }
            } else {
                //새로 들어온 데이터가 현재 노드보다 크다면 오른쪽
                if currentNode.right == nil {
                    currentNode.right = Node(value: value)
                    break
                } else {
                    currentNode = currentNode.right!
                }
            }
        }
    }
}


let rootNode = Node(value: 1)
let bst = NodeMgmt(rootNode: rootNode)
bst.insert(value: 2)



