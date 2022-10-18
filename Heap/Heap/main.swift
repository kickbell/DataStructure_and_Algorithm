//
//  main.swift
//  Heap
//
//  Created by jc.kim on 10/17/22.
//

import Foundation


class Heap {
    var heapArray: [Int] = []
    
    init(value: Int) {
        self.heapArray.append(0) // 0 말고 옵셔널로 처리하거나 -1 같은걸로 처리하는 방법도 있긴 하겠는데,,
        self.heapArray.append(value)
    }
    
    //제일 마지막에 입력된 데이터가 루트노드로 가게되고 그 데이터의 위와 아래를 바꿔줘야 되는지를 판단하는 메소드
    //경우의 수 3가지
    //1. 완전 이진 트리이므로 왼쪽 차일드 노드가 없는 경우 ( 바꿀 게 더이상 없으므로 끝냄 )
    //2. 왼쪽만 차일드 노드가 있는 경우 ( 부모와 차일드 비교해서 부모보다 크다면? 바꿔주기 )
    //3. 왼쪽 오른쪽 차일드 둘 다 있는 경우 ( 왼쪽과 오른쪽 차일드를 먼저 비교하고 그것 중에 큰 녀석을 부모와 비교해서 크다면? 바꿔주기 )
    private func moveDown(_ poppedIndex: Int) -> Bool {
        let leftChildIndex = poppedIndex * 2
        let rightChildIndex = poppedIndex * 2 + 1
        
        if leftChildIndex >= heapArray.count {
            //1. 완전 이진 트리이므로 왼쪽 차일드 노드가 없는 경우 ( 바꿀 게 더이상 없으므로 끝냄 )
            /*
                          15
             
                    10          8
             
                5       4
             
             이걸 왜 이렇게 하냐면, BST 같은 경우네는 Node라는 클래스를 가지고 구현을 했었잖아.
             그래서 left, right가 옵셔널 이었고. 근데 얘는 배열로 구현한단 말이야. 그러면 당연히 중간에 빈데이터가 없어야돼. 그건 배열이 아니니까.
              
             그럼 왜 이걸 이렇게 계산하냐? 자 보자. 위에 힙을 기준으로 heapArray.count는 6이야. 0번째를 포함해서. 즉 1번째 ~ 5번째를 가리키고 있는거지
             근데 데이터 8을 기준으로 leftChildIndex는 3 * 2 = 6 이지? 그럼 지금 6이 있나? 없지.
             데이터 5를 기준으로도 해보자 4 * 2 = 8 이다. 8 >= 6 이니까 왼쪽이 없는게 맞고
             데이터 10을 기준으로 해보면 2 * 2 = 4 4 >= 6 이 아니니까 얘는 왼쪽 노드가 있는거지
             데이터 4를 기준으로 해보면 4 * 2 + 1 = 9, 9 >= 6 이니까 얘도 왼쪽이 없는거고
             
             뭐 이런 느낌이다. 쓰면서도 좀 헷갈리긴하는데 애매하면 그냥 외워. 큰 의미없을듯
             */
            return false
        } else if rightChildIndex >= heapArray.count {
            //2. 왼쪽만 차일드 노드가 있는 경우 ( 부모와 차일드 비교해서 부모보다 크다면? 바꿔주기 )
            if heapArray[poppedIndex] < heapArray[leftChildIndex] {
                //2-1. poppedIndex인 내가 왼쪽 자식 인덱스값 보다 작다면 바꿔줘야되는 거니까 true
                return true
            } else { //2-2 크다면 안바꿔줘도 되니까 false
                return false
            }
        } else {
            //3. 왼쪽 오른쪽 차일드 둘 다 있는 경우 ( 왼쪽과 오른쪽 차일드를 먼저 비교하고 그것 중에 큰 녀석을 부모와 비교해서 크다면? 바꿔주기 )
            if heapArray[leftChildIndex] > heapArray[rightChildIndex] {
                //3-1. 왼쪽과 오른쪽을 비교해서 왼쪽이 크다면
                if heapArray[poppedIndex] < heapArray[leftChildIndex] {
                    //3-2. 왼쪽의 큰 녀석인 내가 왼쪽 자식 인덱스값 보다 작다면 바꿔줘야되는 거니까 true
                    return true
                } else {
                    //3-2 크다면 안바꿔줘도 되니까 false
                    return false
                }
            } else {
                //3-1. 오른쪽이 크다면
                if heapArray[poppedIndex] < heapArray[rightChildIndex] {
                    //3-2. 왼쪽의 큰 녀석인 내가 왼쪽 자식 인덱스값 보다 작다면 바꿔줘야되는 거니까 true
                    return true
                } else {
                    //3-2 크다면 안바꿔줘도 되니까 false
                    return false
                }
            }

        }
    }
    
    //데이터를 insert 할 때, 위와 아래를 바꿔줘야 되는지를 판단하는 메소드
    private func moveUp(_ insertedIndex: Int) -> Bool {
        if insertedIndex <= 1 { return false } //루트 노드(insertedIndex <= 1)라면 바꿀 필요 없으니 바로 리턴
        let parentIndex = insertedIndex / 2
        return heapArray[insertedIndex] > heapArray[parentIndex] //가장 마지막에 넣은 데이터가 부모데이터보다 크다면 위아래 스왑
    }
    
    func insert(_ value: Int) {
        self.heapArray.append(value)
        
        //가장 마지막 데이터의 index, 첫번째 0 넣은 길이도 포함해야 한다.
        var insertedIndex = self.heapArray.count - 1
        
        while moveUp(insertedIndex) {
            let parentIndex = insertedIndex / 2
            heapArray.swapAt(insertedIndex, parentIndex)
            insertedIndex = parentIndex
        }
    }
    
    func pop() -> Int {
        let returnedData = heapArray[1] //최대값 또는 최소값 추출, 항상 루트 노드만 추출, 0번째는 항상 비어있으므로 제외
        heapArray[1] = heapArray.removeLast() //마지막에 입력된 데이터를 삭제하면서 해당 리턴값을 루트 노드로 할당
        
        var poppedIndex = 1 //pop된 index, 항상 루트노드부터 시작한다.
        
        while moveDown(poppedIndex) { //moveDown이 true인 경우에만 신경쓰면 되니 false인 경우는 상관하지 않는다.
            let leftChildIndex = poppedIndex * 2
            let rightChildIndex = poppedIndex * 2 + 1
            
            //1. 완전 이진 트리이므로 왼쪽 차일드 노드가 없는 경우 ( 바꿀 게 더이상 없으므로 끝냄 )
            //-> 무시
            
            //2. 왼쪽만 차일드 노드가 있는 경우 ( 부모와 차일드 비교해서 부모보다 크다면? 바꿔주기 )
            if rightChildIndex >= heapArray.count {
                //2. 왼쪽만 차일드 노드가 있는 경우 ( 부모와 차일드 비교해서 부모보다 크다면? 바꿔주기 )
                if heapArray[poppedIndex] < heapArray[leftChildIndex] {
                    heapArray.swapAt(poppedIndex, leftChildIndex) //바꿔주고,
                    poppedIndex = leftChildIndex //계속 순회를 해야되니까 index를 바꿔준 child로 교체
                }
            } else {
            //3. 왼쪽 오른쪽 차일드 둘 다 있는 경우 ( 왼쪽과 오른쪽 차일드를 먼저 비교하고 그것 중에 큰 녀석을 부모와 비교해서 크다면? 바꿔주기 )
                if heapArray[leftChildIndex] > heapArray[rightChildIndex] {
                    //3-1. 왼쪽과 오른쪽을 비교해서 왼쪽이 크다면
                    if heapArray[poppedIndex] < heapArray[leftChildIndex] {
                        heapArray.swapAt(poppedIndex, leftChildIndex) //바꿔주고,
                        poppedIndex = leftChildIndex //계속 순회를 해야되니까 index를 바꿔준 child로 교체
                    }
                } else {
                    //3-1. 오른쪽이 크다면
                    if heapArray[poppedIndex] < heapArray[rightChildIndex] {
                        heapArray.swapAt(poppedIndex, rightChildIndex)
                        poppedIndex = rightChildIndex
                    }
                }
            }
        }
        return returnedData //꼭 변수선언을 해줘야하는게 heapArray[1]에 수정작업이 이뤄지기 때문
    }
}

print("\n===코드 검증===")
let heap = Heap(value: 15)
heap.insert(10)
heap.insert(8)
heap.insert(5)
heap.insert(4)
print(heap.heapArray)

print("\n===20 insert===")
heap.insert(20)
print(heap.heapArray)

print("\n===pop===")
heap.pop()
print(heap.heapArray)





