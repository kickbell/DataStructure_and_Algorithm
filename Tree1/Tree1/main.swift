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
    
    
    /*
     delete는 좀 복잡하다. 이렇게 나눠서 생각해야 함
     1. 삭제할 데이터가 있는지부터 확인
     2. 데이터가 있다면 ? 3가지 경우의 수를 통해 작업, 없다면 리턴 false
         - 삭제할 노드가 Leaf Node인 경우
         - 삭제할 노드의 Chile Node 가 1개인 경우
         - 삭제할 노드의 Chile Node 가 2개인 경우
     */
    func delete(value: Int) -> Bool {
        //삭제할 데이터가 있는지 여부를 판단한 Bool 타입 변수와 데이터를 삭제함에 따라서 브랜치를 새로 연결해줘야 하니
        //부모노드도 가지고 있어야 하기 때문에 현재노드, 부모노드를 할당해준다.
        var searched = false
        var currentNode: Node? = self.rootNode
        var parrentNode = self.rootNode
        
        while currentNode != nil {
            guard let cNode = currentNode else { break }
            if cNode.value == value {
                searched = true
                break
            } else if value < cNode.value {
                parrentNode = cNode
                currentNode = cNode.left
            } else {
                parrentNode = cNode
                currentNode = cNode.right
            }
        }
        
        //여기까지 왔다면 데이터가 있어서 break로 빠져나왔든, 또는 데이터는 없고 순회를 다해서 빠져나갔을 경우이다.
        //만약에 데이터가 없다면 더 진행할 필요가 없으므로 여기서 처리해준다.
        if searched == false { return false }
        
        // 1. 삭제할 노드가 Leaf Node인 경우
        if currentNode?.left == nil && currentNode?.right == nil {
            // 지울 노드가 parrentNode 기준 왼/오른쪽이냐에 따라서 브랜치도 다르게 처리해주어야 하기 때문에 이렇게 나눠준다.
            if value < parrentNode.value {
                parrentNode.left = nil
            } else {
                parrentNode.right = nil
            }
            currentNode = nil //다 사용했으니 currentNode는 삭제
        }
        
        // 2. 삭제할 노드의 Chile Node 가 1개인 경우
        /*
         - 현재 노드가 왼쪽에만 Chile Node를 가지고 있을 경우
         - ex.
                        10
         
                    5(c)    15
         
                3       7
         */
        if currentNode?.left != nil && currentNode?.right == nil {
            if value < parrentNode.value {
                parrentNode.left = currentNode?.left
            } else {
                parrentNode.right = currentNode?.left
            }
            currentNode = nil
        }
        /*
         - 현재 노드가 오른쪽에만 Chile Node를 가지고 있을 경우
         - ex.
                        10
         
                    5(c)    15
         
                        3       7
         */
        if currentNode?.left == nil && currentNode?.right != nil {
            if value < parrentNode.value {
                parrentNode.left = currentNode?.right
            } else {
                parrentNode.right = currentNode?.right
            }
            currentNode = nil
        }
        
        
        // 3. 삭제할 노드의 Chile Node 가 2개인 경우
        /*
         #### 5.5.3. Case3-1: 삭제할 Node가 Child Node를 두 개 가지고 있을 경우 (삭제할 Node가 Parent Node 왼쪽에 있을 때)
         #### 5.5.4. Case3-2: 삭제할 Node가 Child Node를 두 개 가지고 있을 경우 (삭제할 Node가 Parent Node 오른쪽에 있을 때)

         * 기본 사용 가능 전략 (여기서는 1번 전략 사용)
           1. **삭제할 Node의 오른쪽 자식 중, 가장 작은 값을 삭제할 Node의 Parent Node가 가리키도록 한다.**
           2. 삭제할 Node의 왼쪽 자식 중, 가장 큰 값을 삭제할 Node의 Parent Node가 가리키도록 한다.
         * 기본 사용 가능 전략 중, 1번 전략을 사용하여 코드를 구현하기로 함
           - 경우의 수가 또다시 두가지가 있음
             - 삭제할 Node가 Parent Node의 왼쪽에 있고, 삭제할 Node의 오른쪽 자식 중, 가장 작은 값을 가진 Node의 Child Node가
             - Case3-1-1: 없을 때
             - Case3-1-2: 있을 때
                - 가장 작은 값을 가진 Node의 Child Node가 왼쪽에 있을 경우는 없음, 왜냐하면 왼쪽 Node가 있다는 것은 해당 Node보다 더 작은 값을 가진 Node가 있다는 뜻이기 때문임
         */
        
        
        
        if currentNode?.left != nil && currentNode?.right != nil { //삭제할 노드의 Chile Node 가 2개인 경우
            
            // 3-1,2 를 나눠서 작업하는데 밑에 가장 작은 노드가 자식을 가지냐에 따라서 또 2가지로 구분된다.
            
            if value < parrentNode.value {
                //#### 5.5.3. Case3-1: 삭제할 Node가 Child Node를 두 개 가지고 있을 경우 (삭제할 Node가 Parent Node 왼쪽에 있을 때)
                var changeNode = currentNode?.right
                var changeParrentNode = currentNode?.right
                //여기부터는 강의 그림 봐라. 그냥 보면 다시봐도 절대 이해 안감.
                while changeNode?.left != nil {
                    //오른쪽 자식을 순회하는 전략을 사용할건데, 이제 거기서 제일 작은애를 찾아야하니 계속 순회
                    changeParrentNode = changeNode
                    changeNode = changeNode?.left
                }
                
                //여기까지오면 이제 가장 작은노드를 찾은거고 그게 changeNode이다.
                //그럼 여기서 이제 가장 작은 노드의 오른쪽에 자식이 있는지 없는지를 판단해서 작업한다.
                //왼쪽에 자식이 있을 수는 없다. 왼쪽에 자식이 있다는 건 그녀석이 가장 작은 수라는 뜻이기 때문
                //여기 작업은 changeParrentNode의 브랜치를 이어주는 작업
                if changeNode?.right != nil {
                    changeParrentNode?.left = changeNode?.right //- Case3-1-1: 없을 때
                } else {
                    changeParrentNode?.left = nil //- Case3-1-2: 있을 때
                }
                   
                //여기 작업은 changeNode를 위로 올려서 재연결 해주는 작업
                parrentNode.left = changeNode
                changeNode?.left = currentNode?.left
                changeNode?.right = currentNode?.right
            } else {
                //#### 5.5.4. Case3-2: 삭제할 Node가 Child Node를 두 개 가지고 있을 경우 (삭제할 Node가 Parent Node 오른쪽에 있을 때)
                var changeNode = currentNode?.right
                var changeParrentNode = currentNode?.right
                
                while changeNode?.left != nil {
                    changeParrentNode = changeNode
                    changeNode = changeNode?.left
                }
                
                if changeNode?.right != nil {
                    changeParrentNode?.left = changeNode?.right
                } else {
                    changeParrentNode?.left = nil
                }
                   
                parrentNode.right = changeNode //이 부분만 다르다.
                changeNode?.left  = currentNode?.left
                changeNode?.right = currentNode?.right
            }
        }
        
        
        return true
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



